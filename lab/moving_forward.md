# Analyse des Anti-Patterns MLOps & Prochaines Étapes

## Contexte : Ce dépôt est un MVP de démonstration des pratiques MLOps

Ce dépôt a été conçu comme un **exercice pédagogique** pour illustrer les pratiques MLOps de base sur Azure. Il ne s'agit pas d'une architecture de production, mais d'un **point de départ minimal viable (MVP)** permettant de comprendre les concepts fondamentaux du MLOps :

- Orchestration de pipelines de training sur Azure ML
- Déploiement de modèles sur AKS
- Intégration continue et déploiement continu (CI/CD)
- Registre de modèles basique

L'objectif est de montrer la **structure minimale** nécessaire pour mettre en production un modèle de machine learning, pas une architecture optimisée pour la production à grande échelle.


## Anti-Patterns MLOps Identifiés

### 🔴 Critiques

**1. Modèle intégré dans l'image Docker au moment du build** (`cd-deploy-dev.yml:39-43`, `Dockerfile:6`)

Le modèle entraîné est copié directement dans le conteneur lors du build. Cela couple le modèle avec le cycle de vie du conteneur. Chaque modification de code déclenche un retraining complet et une reconstruction de l'image.

**2. Enregistrement du modèle absent du pipeline** (`pipeline.yml`)

Le pipeline AML exécute `prep_data → train_model → evaluate_model` mais **n'enregistre jamais le modèle** dans le registre de modèles. Le script `register.py` existe mais n'est jamais invoqué automatiquement. Les artifacts sont perdus à la fin du job.

**3. Désalignement entre l'environnement de training et de serving**

- Environnement de training : `scikit-learn>=1.3.0` (train-env.yml)
- Environnement d'inférence : `scikit-learn==1.7.2` (inference-env.yml, requirements-serving.txt)
- Dockerfile utilise `python:3.10-slim` (pas l'environnement Azure ML)

Les versions des paquets ne sont pas verrouillées entre training et serving.

---

### 🟠 Importants

**4. Absence de versioning des données**

Les données sont chargées dynamiquement depuis `sklearn.datasets` dans `prep.py` à chaque exécution. Aucun outil comme DVC ou Delta Lake ne trace la lignée des données. La reproductibilité n'est pas garantie.

**5. Absence de Feature Store**

Les features sont calculées à la volée sans Feature Store (Feast, Tecton, etc.). La cohérence des features entre training et serving n'est pas enforced.

**6. Chemins codés en dur**

```python
# train.py, evaluate.py, score.py utilisent tous des valeurs par défaut
parser.add_argument("--data_dir", default="data/processed")
parser.add_argument("--model_dir", default="outputs/model")
```

Pas de gestion centralisée de la configuration pour les différents environnements.

**7. Polling au lieu d'événements pour la fin du pipeline** (`ci-train.yml:131-147`)

```bash
for attempt in $(seq 1 40); do
    STATUS=$(az ml job show --name "$RUN_ID" --query status -o tsv)
    sleep 30
done
```

40 tentatives × 30s = 20 minutes maximum. Devrait utiliser des webhooks ou Azure Event Grid.

**8. Promotion manuelle vers la production** (`cd-deploy-prod.yml:43-58`)

```bash
az acr import --name $PROD_NAME --source ${DEV_SERVER}/iris-classifier:${TAG}
```

Aucune pipeline de promotion automatique avec étapes de validation entre dev et prod.

**9. Échecs silencieux d'authentification** (`register.py:46-52`)

```python
parser.add_argument("--subscription_id", default=os.environ.get("AZURE_SUBSCRIPTION_ID", ""))
```

Utilise une chaîne vide par défaut si la variable d'environnement n'est pas définie.

---

### 🟡 Moyens

**10. État global muable dans le serveur d'inférence** (`score.py:11`)

```python
MODEL = None
def init():
    global MODEL
    MODEL = joblib.load(model_path)
```

Problèmes de thread-safety en production avec Gunicorn `-w 2`.

**11. Absence de déploiement Canary/Blue-Green**

`aks-deployment.yml` a 2 replicas mais pas de partage de trafic, de routage canary ou de stratégie de rollout progressif.

**12. Plages de versions au lieu de versions exactes**

```yaml
# train-env.yml
- scikit-learn>=1.3.0
- pandas>=2.0.0
```

`>=` permet des versions différentes entre les runs du pipeline.

**13. Boucle de vérification de rôle inefficace** (`ci-train.yml:107-116`)

```bash
if ! az role assignment list --assignee-object-id ... | grep -q .; then
    az role assignment create ...
fi
```

Utilise grep sur une sortie structurée. Conditions de course possibles si plusieurs pipelines s'exécutent simultanément.

**14. Absence de monitoring de dérive des données**

Seule l'accuracy est enregistrée dans `evaluate.py`. Aucun tracking de la distribution des features, de la dérive des prédictions ou des métriques de qualité des données.

**15. Déploiement sur une seule AZ**

Le cluster AKS est déployé avec la zone par défaut. Pas de configuration multi-AZ pour la haute disponibilité en production.

**16. Absence de stratégie de versioning du modèle**

Le modèle est enregistré avec un nom codé `"iris-classifier"` sans tags de version. Aucune stratégie de staging (Staging → Production).

---

## Synthèse

| Anti-Pattern | Sévérité | Impact |
|--------------|----------|--------|
| Modèle intégré dans l'image | 🔴 Critique | Déploiements rigides, itération lente |
| Enregistrement du modèle hors pipeline | 🔴 Critique | Pas de traçabilité, pas de lineage |
| Désalignement training/serving | 🔴 Critique | Bugs en production, échecs silencieux |
| Pas de versioning des données | 🟠 Important | Problèmes de reproductibilité |
| Pas de Feature Store | 🟠 Important | Features incohérentes |
| Chemins codés en dur | 🟠 Important | Erreurs spécifiques à l'environnement |
| Polling pour la complétion | 🟠 Important | Gaspillage CI, feedback lent |
| Promotion prod manuelle | 🟠 Important | Risque d'erreur humaine |
| Échecs silencieux | 🟠 Important | Cycles de debug longs |
| État global mutable | 🟡 Moyen | Thread safety, memory leaks |
| Pas de déploiements canary | 🟡 Moyen | Rollouts risqués en production |
| Dépendances non verrouillées | 🟡 Moyen | Runs non reproductibles |

---

## Pour Aller Plus Loin (Prochaines Étapes)

1. **Intégrer l'enregistrement du modèle dans le pipeline AML** avec `register.py`
2. **Verrouiller les versions exactes** des paquets Python dans tous les environnements
3. **Implémenter un Feature Store** (Feast, Tecton, ou Azure Feature Store)
4. **Ajouter du versioning des données** avec DVC
5. **Remplacer le polling par des webhooks** Azure Event Grid
6. **Mettre en place une stratégie de promotion** Staging → Production avec validation automatique
7. **Ajouter du monitoring de dérive** (evidentlyai ou great_expectations)
8. **Implémenter des déploiements canary** avec Argo Rollouts ou Flagger pour passer en mode pull.
9. **Utiliser un registre de modèles centralisé** (MLflow Model Registry, Verta, etc.)
10. **Configurer la haute disponibilité** multi-AZ pour AKS en production