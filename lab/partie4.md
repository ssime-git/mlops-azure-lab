# Jour 4 — Tracking, Registry & Monitoring

## Objectifs
- Comparer des runs MLflow dans AML Studio
- Gérer les versions de modeles dans le registre de modeles du workspace AML
- Configurer une alerte Azure Monitor
- Simuler du data drift

## Dependances depuis J3

La partie 4 suppose que:
- le pipeline AML du Jour 3 a déjà tourné avec succes
- le workflow `CD — Deploy AML Managed Endpoint` a ete lance au moins une fois si tu veux manipuler un modele enregistre dans AML
- le workflow CD dev vers AKS a deja termine si tu veux simuler du drift sur `iris-classifier-svc`

En pratique:
- sans modèle enregistré, la partie "versioning" ne montrera rien
- sans endpoint AKS accessible, la simulation de drift ne peut pas fonctionner

## Bien separer les deux sujets de J3

Le Jour 3 montrait deux cibles de deploiement differentes:

| Sujet | Workflow J3 associe | Ce que cela produit | Utilise au Jour 4 pour |
|---|---|---|---|
| `AKS` | `CD — Deploy to Dev (ACR build + AKS deploy)` | une application de scoring exposee sur AKS | la simulation de drift et l'observation App Insights |
| `Managed Endpoint AML` | `CD — Deploy AML Managed Endpoint` | un modele enregistre dans AML + un endpoint AML gere | le versioning du modele dans le workspace AML |

Donc:
- pour `az ml model list --name iris-classifier`, c'est le workflow `Managed Endpoint AML` qui compte
- pour `kubectl get svc iris-classifier-svc`, c'est le workflow `CD dev vers AKS` qui compte
- ces deux parties sont complementaires, mais elles ne se remplacent pas

Point d'architecture important:
- l'image AKS de serving doit rester legere et orientee inference
- elle n'a pas besoin d'embarquer toutes les dependances du training ou du tracking MLflow
- dans ce repo, la partie serving AKS utilise donc des dependances dediees et separees du runtime de training

## Atelier

### 1. Explorer les runs MLflow (10 min)
Azure ML Studio > Jobs > selectionner 2 runs > Compare.
Observer : Metrics, Parameters, Artifacts, Tags.

### 2. Versioning de modeles dans le workspace AML (10 min)
Precondition:
- avoir lance au moins une fois le workflow `CD — Deploy AML Managed Endpoint` du Jour 3
- ce workflow enregistre le modele `iris-classifier` dans le workspace AML dev

Si la commande suivante ne retourne rien, ce n'est pas un bug du registre AML:
- cela signifie en general que le workflow `CD — Deploy AML Managed Endpoint` n'a pas encore ete lance avec succes
- le deploiement AKS seul ne suffit pas a remplir le registre de modeles AML

```bash
az ml model list --name iris-classifier
az ml model show --name iris-classifier --version 1
```

`Azure ML Studio > Models > iris-classifier` -> historique des versions dans le workspace.

Important:
- ici on parle du registre de modeles du **workspace AML**
- ce lab n'utilise pas un AML Registry partage entre plusieurs workspaces

### 3. Alerte Azure Monitor (15 min)

Repere d'abord ton App Insights (suffixe via `lab/env/naming.env`) :

```bash
source lab/env/partie2.env
az resource list --resource-group "$AML_RESOURCE_GROUP_DEV" \
  --resource-type Microsoft.Insights/components \
  --query "[0].name" -o tsv
```

La commande ci-dessus permet de recuperer le nom de l'instance App Insights.

Puis suivre le chemin dans le portail : `Portal > App Insights > (nom retourne ci-dessus, par ex. appi-mlopslab-<suffix>-dev) > Monitoring > Alerts > Create > New Alert Rule`.

Dans le portail, le signal peut apparaitre sous le libelle lisible `Failed requests`
(equivalent au nom technique `requests/failed`).

Configuration recommandee pour le lab:
- Signal name : `Failed requests`
- Threshold type : `Static`
- Aggregation type : `Count`
- Operator : `Greater than`
- Unit : `Count`
- Threshold : `5`
- Check every : `1 minute`
- Lookback period : `5 minutes`
- Alert rule name : `alert-failed-requests-<appi-name>`
- Action group : email (voir ci-dessous)

> [!INFO]
> - Azure reevalue toutes les `1 minute`
> - en regardant les `5 dernieres minutes`
> - et declenche si plus de `5` requetes ont echoue sur cette fenetre

#### 3.1 Creer l'Action Group et l'attacher a l'alerte

Sans Action Group, l'alerte se declenche mais **personne n'est notifie**. Chaque etudiant utilise **son propre email** :

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

Verifier que l'action group est bien rattache :

```bash
az resource show -g "$AML_RESOURCE_GROUP_DEV" \
  --resource-type "Microsoft.Insights/metricAlerts" \
  -n "$ALERT_NAME" \
  --api-version 2024-03-01-preview \
  --query "properties.actions"
```

Tu dois voir ton `ag-lab-email-${LAB_SUFFIX}` dans la sortie.

> [!IMPORTANT]
> Si tu obtiens `InvalidApiVersionParameter` avec une longue liste d'api-versions, c'est **tres probablement** que `$AML_RESOURCE_GROUP_DEV` ou `$ALERT_NAME` est vide dans ton shell (URL malformee avec `resourcegroups//metricAlerts/`). Verifier avec :
> ```bash
> echo "RG=$AML_RESOURCE_GROUP_DEV  ALERT=$ALERT_NAME"
> ```
> Si l'un est vide, re-sourcer l'environnement : `source lab/env/partie2.env` et re-exporter `ALERT_NAME`.

Alternative via le portail : `Portal > Monitor > Alert rules > <nom de l'alerte> > Actions`.

> [!WARNING]
> - le premier email Azure Monitor tombe souvent dans les **spams**
> - `short-name` est limite a 12 caracteres (d'ou le `${LAB_SUFFIX:0:6}`)

#### 3.2 Tester le declenchement

Le script `generate-drift.py` n'emet que des `200` : il ne declenche **pas** l'alerte. Pour la tester, il faut forcer des erreurs `500` avec un payload invalide :

```bash
ENDPOINT=$(kubectl get svc iris-classifier-svc -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
for i in $(seq 1 10); do
  curl -s -o /dev/null -w "%{http_code}\n" -X POST http://$ENDPOINT/score \
    -H "Content-Type: application/json" -d 'INVALID'
done
```

Attendre 2 a 5 minutes : l'email d'alerte doit arriver (verifier les spams).

### 4. Simulation drift
Précondition:
- le workflow `CD — Deploy to Dev` du Jour 3 doit avoir deploye l'application sur AKS
- `kubectl get svc iris-classifier-svc` doit retourner une `EXTERNAL-IP`
- l'application AKS doit avoir ete redeployee avec l'instrumentation App Insights a jour

```bash
ENDPOINT=$(kubectl get svc iris-classifier-svc -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

# Trafic normal
uv run python scripts/generate-drift.py --endpoint http://$ENDPOINT/score --n_normal 50 --n_drifted 0

# Observer App Insights > Live Metrics pendant l'envoi

# Trafic drifte
uv run python scripts/generate-drift.py --endpoint http://$ENDPOINT/score --n_normal 10 --n_drifted 40

# Observer les reponses anormales dans App Insights > Requests
```

Ce qu'il faut bien comprendre:
- ici, le "drift" est un drift **metier** sur les donnees d'entree
- cela ne signifie pas forcement que l'API doit renvoyer des erreurs HTTP
- dans ce lab, beaucoup de requetes driftes repondent quand meme en `200`
- App Insights sert donc surtout a observer le trafic, les temps de reponse et les eventuelles erreurs techniques
- le drift se voit plutot dans le contenu des predictions que dans un code HTTP `500`

### 5. Observer App Insights avec KQL (15 min)
Dans le portail Azure:
- ouvrir ton App Insights (nom recupere plus haut, ex. `appi-mlopslab-<suffix>-dev`)
- cliquer sur `Logs`
- cela ouvre generalement `Query Hub`
- coller ensuite les requetes KQL ci-dessous puis cliquer sur `Run`

Requete 1 - voir les requetes recentes:
```kusto
requests
| where timestamp > ago(30m)
| order by timestamp desc
| take 20
```

Attendu:
- des lignes recentes correspondant aux appels sur `/score`

Requete 2 - resumer succes / codes HTTP:
```kusto
requests
| where timestamp > ago(30m)
| summarize count() by success, resultCode
```

Attendu:
- majoritairement `success=true`
- souvent `resultCode=200`

Requete 3 - volume de trafic dans le temps:
```kusto
requests
| where timestamp > ago(30m)
| summarize count() by bin(timestamp, 5m), success
| order by timestamp desc
```

Attendu:
- une hausse du nombre de requetes apres l'execution de `generate-drift.py`

Requete 4 - traces recentes si besoin de debug:
```kusto
traces
| where timestamp > ago(30m)
| order by timestamp desc
| take 20
```

Interpretation:
- si `requests` remonte bien, la chaine `AKS -> App Insights` fonctionne
- si les resultats restent en `200`, cela ne veut pas dire qu'il n'y a pas de drift
- cela veut simplement dire que le drift ne casse pas techniquement l'API
- pour aller plus loin sur le drift metier, il faudrait aussi analyser les predictions et leur distribution

Si `EXTERNAL-IP` est vide:
- attendre encore un peu que le Load Balancer Azure soit provisionne
- ou revenir au Jour 3 pour verifier le workflow CD dev

Si tu ne vois toujours pas de requetes dans ton App Insights :
- verifier que le `CD — Deploy to Dev` a bien ete relance apres mise a jour de l'instrumentation
- attendre 1 a 3 minutes de propagation dans App Insights

## Checkpoint J4
- [ ] 2 runs compares dans AML Studio
- [ ] Versions modele visibles dans le workspace AML
- [ ] Alerte Monitor configuree
- [ ] Drift simule et logs observes dans App Insights
