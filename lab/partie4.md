# Partie 4 — Tracking, Registry & Monitoring

## Objectifs
- Comparer des runs MLflow dans AML Studio
- Gérer les versions de modèles dans le registre de modèles du workspace AML
- Configurer une alerte Azure Monitor
- Simuler du data drift sur l'endpoint AKS

## Dépendances depuis la Partie 3

La Partie 4 suppose que :
- le pipeline AML de la Partie 3 a déjà tourné avec succès
- le workflow `CD — Deploy AML Managed Endpoint` a été lancé au moins une fois si vous souhaitez manipuler un modèle enregistré dans AML
- le workflow `CD dev vers AKS` a déjà terminé si vous souhaitez simuler du drift sur `iris-classifier-svc`

Conséquences concrètes :
- sans modèle enregistré, la partie « versioning » ne montrera rien
- sans endpoint AKS accessible, la simulation de drift ne peut pas fonctionner

## Bien séparer les deux sujets de la Partie 3

La Partie 3 montrait deux cibles de déploiement différentes :

| Sujet | Workflow Partie 3 associé | Ce que cela produit | Utilisé en Partie 4 pour |
|---|---|---|---|
| `AKS` | `CD — Deploy to Dev (ACR build + AKS deploy)` | une application de scoring exposée sur AKS | la simulation de drift et l'observation App Insights |
| `Managed Endpoint AML` | `CD — Deploy AML Managed Endpoint` | un modèle enregistré dans AML + un endpoint AML géré | le versioning du modèle dans le workspace AML |

Donc :
- pour `az ml model list --name iris-classifier`, c'est le workflow `Managed Endpoint AML` qui compte
- pour `kubectl get svc iris-classifier-svc`, c'est le workflow `CD dev vers AKS` qui compte
- ces deux parties sont **complémentaires** mais ne se remplacent pas

> [!INFO]
> Avant de continuer, ouvrez le workflow `CD — Deploy AML Managed Endpoint`, puis comparez-le avec le chemin AKS : qu'est-ce qui alimente le registre de modèles, qu'est-ce qui alimente App Insights, et qu'est-ce qui ne se mélange pas ?
> Les **anti-patterns** à repérer ici sont : confondre le serving AKS avec l'enregistrement AML, et conclure qu'un simple `200 OK` prouve l'absence de drift métier.
> Les **bonnes pratiques** correspondantes sont : séparer le chemin de serving applicatif du chemin de registry / tracking, et utiliser le registre AML + App Insights / KQL pour observer respectivement les versions de modèle et la télémétrie technique.

> [!NOTE]
> **Point d'architecture** : l'image AKS de serving doit rester légère et orientée inférence. Elle n'a pas besoin d'embarquer toutes les dépendances du training ou du tracking MLflow. Dans ce dépôt, la partie serving AKS utilise des dépendances dédiées et séparées du runtime de training.

## Atelier

### 1. Explorer les runs MLflow (10 min)

Ouvrez **Azure ML Studio → Jobs**, sélectionnez 2 runs, puis cliquez sur **Compare**.

Observez les onglets :
- **Metrics** : évolution des métriques entre runs
- **Parameters** : hyperparamètres utilisés
- **Artifacts** : fichiers produits (modèle, logs)
- **Tags** : métadonnées

### 2. Versioning de modèles dans le workspace AML (10 min)

> [!IMPORTANT]
> **Précondition** : avoir lancé au moins une fois le workflow `CD — Deploy AML Managed Endpoint` de la Partie 3. Ce workflow enregistre le modèle `iris-classifier` dans le workspace AML `dev`. **Le déploiement AKS seul ne remplit pas le registre de modèles AML.**

Listez les versions enregistrées du modèle :

```bash
# Toutes les versions du modele
az ml model list --name iris-classifier

# Details d'une version precise
az ml model show --name iris-classifier --version 1
```

Ouvrez **Azure ML Studio → Models → `iris-classifier`** pour voir l'historique des versions dans le workspace.

> [!NOTE]
> Ici, vous manipulez le registre de modèles du **workspace AML**. Ce lab n'utilise pas un AML Registry partagé entre plusieurs workspaces.

### 3. Alerte Azure Monitor (15 min)

Repérez d'abord votre instance Application Insights (le suffixe provient de `lab/env/naming.env`) :

```bash
source lab/env/partie2.env
az resource list \
  --resource-group "$AML_RESOURCE_GROUP_DEV" \
  --resource-type Microsoft.Insights/components \
  --query "[0].name" -o tsv
```

Cette commande retourne le nom de l'instance Application Insights (ex. `appi-mlopslab-sebs-dev`).

Suivez ensuite ce chemin dans le portail : **Portal → App Insights → (le nom retourné ci-dessus) → Monitoring → Alerts → Create → New Alert Rule**.

Dans le portail, le signal apparaît sous le libellé `Failed requests` (équivalent au nom technique `requests/failed`).

Configuration recommandée pour le lab :

| Champ | Valeur |
|---|---|
| Signal name | `Failed requests` |
| Threshold type | `Static` |
| Aggregation type | `Count` |
| Operator | `Greater than` |
| Unit | `Count` |
| Threshold | `5` |
| Check every | `1 minute` |
| Lookback period | `5 minutes` |
| Alert rule name | `alert-failed-requests-<appi-name>` |
| Action group | email (voir ci-dessous) |

> [!INFO]
> Lecture de la règle : Azure réévalue toutes les `1 minute`, en regardant les `5 dernières minutes`, et déclenche si plus de `5` requêtes ont échoué sur cette fenêtre.

#### 3.1 Créer l'Action Group et l'attacher à l'alerte

Sans Action Group, l'alerte se déclenche mais **personne n'est notifié**. Chaque étudiant utilise **son propre email** :

```bash
source lab/env/partie2.env

# Ton email de notification (remplace par le tien, ou utilise celui du compte Azure connecte)
MY_EMAIL=$(az ad signed-in-user show --query mail -o tsv)
[ -z "$MY_EMAIL" ] && MY_EMAIL=$(az ad signed-in-user show --query userPrincipalName -o tsv)
echo "Notification email: $MY_EMAIL"

# 1. Creer l'Action Group (nom unique par etudiant via $LAB_SUFFIX)
AG_ID=$(az monitor action-group create \
  -g "$AML_RESOURCE_GROUP_DEV" \
  -n "ag-lab-email-${LAB_SUFFIX}" \
  --short-name "lab${LAB_SUFFIX:0:6}" \
  --action email me "$MY_EMAIL" \
  --query id -o tsv)

# 2. Recuperer le nom exact de l'alerte creee dans le portail
ALERT_NAME=$(az resource list -g "$AML_RESOURCE_GROUP_DEV" \
  --resource-type "Microsoft.Insights/metricAlerts" \
  --query "[?starts_with(name, 'alert-failed-requests')].name | [0]" -o tsv)
echo "Alert: $ALERT_NAME"

# 3. Attacher l'Action Group a l'alerte
az monitor metrics alert update \
  -g "$AML_RESOURCE_GROUP_DEV" \
  -n "$ALERT_NAME" \
  --add-action "$AG_ID"
```

Vérifiez que l'Action Group est bien rattaché :

```bash
az resource show \
  -g "$AML_RESOURCE_GROUP_DEV" \
  --resource-type "Microsoft.Insights/metricAlerts" \
  -n "$ALERT_NAME" \
  --api-version 2024-03-01-preview \
  --query "properties.actions"
```

Vous devez voir votre `ag-lab-email-${LAB_SUFFIX}` dans la sortie.

> [!IMPORTANT]
> Si vous obtenez `InvalidApiVersionParameter` avec une longue liste d'api-versions, c'est **très probablement** que `$AML_RESOURCE_GROUP_DEV` ou `$ALERT_NAME` est vide dans votre shell (URL malformée avec `resourcegroups//metricAlerts/`). Vérifiez avec :
> ```bash
> echo "RG=$AML_RESOURCE_GROUP_DEV  ALERT=$ALERT_NAME"
> ```
> Si l'une des variables est vide, re-sourcez l'environnement : `source lab/env/partie2.env` et redéfinissez `ALERT_NAME`.

Alternative via le portail : **Portal → Monitor → Alert rules → `<nom de l'alerte>` → Actions**.

> [!WARNING]
> - le premier email Azure Monitor tombe souvent dans les **spams**
> - `short-name` est limité à 12 caractères (d'où le `${LAB_SUFFIX:0:6}`)

#### 3.2 Tester le déclenchement

Le script `generate-drift.py` n'émet que des `200` : il ne déclenche **pas** l'alerte. Pour tester cette dernière, forcez des erreurs `500` avec un payload invalide :

```bash
ENDPOINT=$(kubectl get svc iris-classifier-svc -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
for i in $(seq 1 10); do
  curl -s -o /dev/null -w "%{http_code}\n" -X POST http://$ENDPOINT/score \
    -H "Content-Type: application/json" -d 'INVALID'
done
```

Attendez 2 à 5 minutes : l'email d'alerte doit arriver (**vérifiez les spams**).

### 4. Simulation de drift (15 min)

> [!IMPORTANT]
> **Préconditions** :
> - le workflow `CD — Deploy to Dev` de la Partie 3 doit avoir déployé l'application sur AKS
> - `kubectl get svc iris-classifier-svc` doit retourner une `EXTERNAL-IP`
> - l'application AKS doit avoir été redéployée avec l'instrumentation App Insights à jour

Le script `generate-drift.py` envoie deux types de trafic : des requêtes « normales » (distribution Iris typique) et des requêtes « driftées » (valeurs hors distribution).

```bash
ENDPOINT=$(kubectl get svc iris-classifier-svc -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

# 1) Trafic normal : 50 requetes representatives
uv run python scripts/generate-drift.py \
  --endpoint http://$ENDPOINT/score \
  --n_normal 50 --n_drifted 0

# Observer App Insights > Live Metrics pendant l'envoi

# 2) Trafic drifte : 10 normales + 40 avec valeurs hors distribution
uv run python scripts/generate-drift.py \
  --endpoint http://$ENDPOINT/score \
  --n_normal 10 --n_drifted 40

# Observer les reponses anormales dans App Insights > Requests
```

> [!NOTE]
> **À bien comprendre** :
> - ici, le « drift » est un drift **métier** sur les données d'entrée
> - cela ne signifie pas forcément que l'API renvoie des erreurs HTTP
> - beaucoup de requêtes driftées répondent quand même en `200`
> - App Insights sert surtout à observer le trafic, les temps de réponse et les erreurs techniques
> - le drift métier se voit plutôt dans le contenu des prédictions que dans un code HTTP `500`

### 5. Observer App Insights avec KQL (15 min)

Dans le portail Azure :
- ouvrez votre Application Insights (nom récupéré plus haut, ex. `appi-mlopslab-<suffix>-dev`)
- cliquez sur **Logs**
- cela ouvre le **Query Hub**
- collez les requêtes KQL ci-dessous puis cliquez sur **Run**

#### Requête 1 — voir les requêtes récentes

```kusto
requests
| where timestamp > ago(30m)
| order by timestamp desc
| take 20
```

Attendu : des lignes récentes correspondant aux appels sur `/score`.

#### Requête 2 — résumer succès / codes HTTP
```kusto
requests
| where timestamp > ago(30m)
| summarize count() by success, resultCode
```

Attendu :
- majoritairement `success=true`
- souvent `resultCode=200`

#### Requête 3 — volume de trafic dans le temps
```kusto
requests
| where timestamp > ago(30m)
| summarize count() by bin(timestamp, 5m), success
| order by timestamp desc
```

Attendu : une hausse du nombre de requêtes après l'exécution de `generate-drift.py`.

#### Requête 4 — traces récentes (debug)
```kusto
traces
| where timestamp > ago(30m)
| order by timestamp desc
| take 20
```

Interprétation :
- si `requests` remonte bien, la chaîne `AKS → App Insights` fonctionne
- si les résultats restent en `200`, cela ne signifie pas qu'il n'y a pas de drift : cela veut simplement dire que le drift ne casse pas techniquement l'API
- pour aller plus loin sur le drift métier, il faudrait analyser les prédictions et leur distribution

> [!WARNING]
> **Dépannage** :
> - si `EXTERNAL-IP` est vide : attendez que le Load Balancer Azure soit provisionné, ou revenez à la Partie 3 pour vérifier le workflow CD `dev`
> - si vous ne voyez toujours pas de requêtes dans App Insights : vérifiez que `CD — Deploy to Dev` a bien été relancé après mise à jour de l'instrumentation, puis attendez 1 à 3 minutes de propagation

> [!INFO]
> Ouvrez `mlops/data-science/src/evaluate.py` et `scripts/generate-drift.py` : qu'est-ce qui est mesuré, et qu'est-ce qui ne l'est pas ?
> Les **anti-patterns** à noter ici sont : seule l'accuracy est suivie, et le drift métier n'est pas détecté même si beaucoup de requêtes répondent en `200`.
> Les **bonnes pratiques** à retenir sont : suivre la distribution des features et des prédictions, et distinguer drift métier de drift technique (HTTP 200 ≠ absence de drift).

## Checkpoint Partie 4
- [ ] 2 runs comparés dans AML Studio
- [ ] Versions de modèle visibles dans le workspace AML
- [ ] Alerte Azure Monitor configurée avec Action Group
- [ ] Drift simulé et logs observés dans App Insights
