# Jour 3 — CI/CD pour le Machine Learning

## Objectifs
- Comprendre Azure Pipelines et GitHub Actions (theorie)
- Lire et comprendre les 3 workflows CI/CD principaux du repo
- Relier ce qui a ete teste en notebook J1 avec son execution automatisee en CI
- Declencher un CI reel (commit -> AML pipeline)
- Observer le deploiement AKS end-to-end

## Matin — Theorie : Azure Pipelines vs GitHub Actions (40 min)

### Meme concept, deux syntaxes

Les deux systemes font la meme chose : detecter un evenement (push, tag, timer),
executer des steps dans un runner (VM temporaire), interagir avec Azure.
La difference est dans l'ecosysteme et la syntaxe YAML.

```yaml
# Azure Pipelines (azure-pipelines.yml)    # GitHub Actions (.github/workflows/ci.yml)
trigger:                                    on:
  branches:                                   push:
    include: [main]                             branches: [main]

pool:                                       jobs:
  vmImage: ubuntu-latest                      train:
                                               runs-on: ubuntu-latest
steps:
- task: AzureCLI@2                             steps:
  inputs:                                      - uses: actions/checkout@v4
    azureSubscription: 'my-conn'               - uses: azure/login@v2
    scriptType: bash                             with:
    inlineScript: |                                client-id: ${{ secrets.AZURE_CLIENT_ID }}
      az ml job create \                       - run: az ml job create \
        --file pipeline.yml                          --file mlops/pipelines/pipeline.yml
```

### Differences cles

| | Azure Pipelines | GitHub Actions |
|---|---|---|
| Hebergement | dev.azure.com (portail separe) | github.com (meme repo) |
| Auth Azure | Service Connection (UI) | OIDC (Federated Credentials) |
| Reutilisabilite | Templates YAML | Reusable Workflows |
| Ecosysteme | Azure-first | Open source / multi-cloud |
| Visibilite YAML | Dans le repo | Dans le repo |
| Courbe d'apprentissage | Legerement plus verbeux | Plus concis |

### Quand voir ADO en entreprise ?
- Grandes entreprises avec licences Microsoft existantes
- Projets qui utilisent deja Azure Repos (git integre a ADO)
- Equipes qui veulent tout dans un seul portail Azure

**Pour ce lab : GitHub Actions.** Le YAML est dans le repo, les stagiaires le voient
et le modifient directement sans naviguer vers un portail supplementaire.

---

## Apres-midi — Atelier : GitHub Actions en pratique

## Ce qui se passe derriere les workflows

Le point important du Jour 3 est que le `git push` ne lance pas "juste des tests Python".
Il declenche ici la partie CI, puis on lance volontairement le CD dev a la main pour garder le controle sur le build, le push et le deploiement.

Important:
- dans ce lab, le deploiement AKS juste apres un CI vert est un raccourci pedagogique
- l'objectif est de montrer la chaine complete end-to-end en une seule journee
- en pratique, on separe plus souvent entrainement, enregistrement du modele, validation, puis deploiement
- il faut donc lire ce flux comme un environnement `dev` de demonstration, pas comme un modele de production a recopier tel quel

## Deux cibles de deploiement differentes

Le repo montre volontairement **deux manieres de servir un modele** apres l'entrainement.
Elles ne font pas la meme chose et ne servent pas le meme objectif.

| Cible | Ce qui est deploye | Qui gere le runtime | Ce que tu manipules | Usage dans le lab |
|---|---|---|---|---|
| `AKS` | une image Docker de scoring | toi via Kubernetes | image ACR, manifest K8s, service, rollout | montrer le chemin conteneur + ACR + AKS |
| `Managed Endpoint AML` | un endpoint de modele Azure ML | Azure ML | modele AML, endpoint AML, deployment AML | montrer le chemin serving ML gere et le registre de modeles |

En lecture simple:
- `AKS` = approche "plateforme / Kubernetes"
- `Managed Endpoint AML` = approche "service de serving ML gere"

Ce que cela implique concretement:
- deployer sur `AKS` **n'enregistre pas** automatiquement un modele dans le registre AML
- deployer un `Managed Endpoint AML` **enregistre** le modele dans le workspace AML puis le sert via Azure ML
- le Jour 4 depend donc du workflow `Managed Endpoint AML` pour la partie registre de modeles, pas du workflow AKS

Schema de separation:
```mermaid
flowchart TD
    A[CI AML reussie] --> B[Option 1: CD dev vers AKS]
    A --> C[Option 2: CD AML Managed Endpoint]
    B --> D[Image Docker dans ACR]
    D --> E[Application de scoring sur AKS]
    C --> F[Modele enregistre dans AML]
    F --> G[Endpoint AML gere]
```

Vue d'ensemble:
```mermaid
flowchart TD
    A[Push sur dev] --> B[GitHub Actions - CI]
    B --> C[Lint + unit tests]
    B --> D[Azure Login via OIDC]
    D --> E[Create/Update AML environment]
    E --> F[Create/Update AML compute]
    F --> G[Submit AML pipeline]
    G --> H[prep_data]
    H --> I[train_model]
    I --> J[evaluate_model]
    J --> K[CI vert]
    K --> L[Declenchement manuel du CD dev]
    L --> M[GitHub Actions - CD dev]
    M --> N[Build image et push vers ACR]
    N --> O[Deploy sur AKS]
    O --> P[Test curl sur endpoint AKS]
```

Pourquoi cela peut prendre du temps:
- GitHub doit d'abord demarrer un runner
- Azure Login via OIDC doit obtenir un token
- AML doit preparer ou mettre a jour l'environnement d'execution
- le compute `cpu-cluster` peut devoir sortir de veille si `min-instances = 0`
- AML doit tirer l'image Docker depuis l'ACR
- le pipeline AML enchaine ensuite `prep_data`, `train_model`, `evaluate_model`
- apres un CI vert, on peut lancer manuellement le workflow CD dev qui construit l'image applicative et la deploie sur AKS

Ce qui serait plus frequent en conditions reelles:
```mermaid
flowchart LR
    A[Push dev] --> B[CI training + evaluation]
    B --> C[Validation metriques]
    C --> D[Enregistrement du modele]
    D --> E[Approbation manuelle ou promotion]
    E --> F[Build image de serving]
    F --> G[Deploiement dev ou staging]
    G --> H[Promotion prod]
```

En pratique, le script Python `prep.py` est tres rapide.
Si l'etape `prep_data` semble longue, le temps est souvent consomme par:
- le reveil du compute AML
- la preparation du conteneur
- le pull de l'image
- les operations d'infrastructure AML avant l'execution du code

Schema du pipeline AML:
```mermaid
flowchart LR
    A[AML Environment] --> B[AML Compute cpu-cluster]
    B --> C[prep_data]
    C --> D[train_model]
    D --> E[evaluate_model]
    E --> F[Metrics + artifacts + status]
```

Ce qu'il faut observer dans AML Studio:
- `Queued` ou `Preparing` = AML prepare l'infra, pas encore ton code
- `Running` sur `prep_data` = le conteneur du step est lance
- `Completed` = le step est termine
- `Failed` = regarder les logs du child job concerne

Regle pratique:
- premier run apres creation du compute: plus lent
- runs suivants: souvent plus rapides grace au cache AML
- ce qui parait "lent" n'est pas forcement un bug, surtout au premier passage

Positionnement du script `bootstrap-aml.sh`:
- il sert a preparer les assets AML apres creation de l'infrastructure
- le meilleur moment pour le lancer manuellement est en fin de Jour 2
- au Jour 3, avec le repo a jour, le workflow CI sait normalement faire ce qu'il faut sans bootstrap manuel
- si un environnement a ete cree avant les derniers correctifs, relancer `bootstrap-aml.sh` reste un bon outil de rattrapage

### 1. Lire les workflows (15 min)
Ouvrir `.github/workflows/` et repondre :
- Qu'est-ce qui declenche `ci-train.yml` ?
- Pourquoi `train-pipeline` a `environment: dev` ?
- Que font les 3 commandes `sed` dans `cd-deploy-dev.yml` ?
- Pourquoi `cd-deploy-prod.yml` necessite `environment: production` ?
- Quelles etapes du notebook J1 sont reprises dans les scripts `prep.py`, `train.py`, `evaluate.py` ?

### 2. Premier push sur dev (10 min)
Avant le push, verifier que l'identite GitHub OIDC a bien les droits sur le workspace cree au Jour 2.
Sans cela, le job `train-pipeline` echoue typiquement sur `az ml environment create`.

Checks conseilles:
```bash
PRINCIPAL_ID=$(az ad sp list --display-name "github-mlops-lab" --query "[0].id" -o tsv)

az role assignment list \
  --assignee "$PRINCIPAL_ID" \
  --all \
  --query "[].{role:roleDefinitionName,scope:scope}" \
  -o table
```

Verifier au minimum:
- `Contributor` sur `rg-mlopslab-dev`
- `User Access Administrator` sur `rg-mlopslab-dev`

Si les roles viennent d'etre ajoutes:
- attendre 2 a 5 minutes
- relancer ensuite le workflow

Puis faire le push:
```bash
git checkout dev
# Modifier train.py : max_iter 200 -> 300
git add mlops/data-science/src/train.py
git commit -m "feat: max_iter 300"
git push origin dev
```
Observer GitHub Actions : les 3 jobs de `ci-train.yml`.

Si tu veux relancer la CI avec le **dernier contenu du repo**:
- eviter de seulement cliquer sur `Re-run jobs` d'un ancien workflow si des fichiers ont change depuis
- un rerun relance le workflow sur le meme commit SHA
- attention: un commit vide ne declenche pas `ci-train.yml` ici, car le workflow a un filtre `paths`
- pour relancer avec le dernier contenu du repo, utiliser de preference `Run workflow` sur `CI — Lint + Tests + AML Training Pipeline`
- autre option: pousser une vraie modification dans `mlops/**`, `tests/**`, `requirements.txt` ou `requirements.in`

Exemple:
```bash
# Option A: lancer le workflow manuellement depuis l'onglet Actions

# Option B: pousser une vraie modification qui match le filtre paths
git add mlops/data-science/src/train.py
git commit -m "chore: rerun ci with tracked change"
git push origin dev
```

Ce que fait concretement ce push:
```mermaid
sequenceDiagram
    participant Dev as Apprenant
    participant GH as GitHub Actions
    participant Azure as Azure via OIDC
    participant AML as Azure ML

    Dev->>GH: git push origin dev
    GH->>GH: lint
    GH->>GH: unit-tests
    GH->>Azure: login OIDC
    GH->>AML: create/update environment
    GH->>AML: create/update compute + role AcrPull
    GH->>AML: submit pipeline
    AML-->>GH: status prep_data -> train_model -> evaluate_model
```

### 3. Observer le pipeline AML (15 min)
Azure ML Studio > Jobs > pipeline en cours.
Cliquer sur chaque etape : prep_data, train_model, evaluate_model.

Pourquoi `prep_data` peut sembler "bloque":
- le code de preparation est simple et rapide
- mais AML doit parfois d'abord allouer le compute, preparer l'environnement et tirer l'image
- c'est donc souvent une attente d'infrastructure, pas une attente "metier"

Si le job echoue sur `az ml environment create` avec `AuthorizationFailed`:
- verifier a nouveau les rôles Azure RBAC de l'app `github-mlops-lab`
- confirmer que `rg-mlopslab-dev` a bien ete cree par Terraform puis que les rôles ont ete reappliques dessus
- relancer le workflow apres propagation IAM

### 4. Lancer le CD dev manuellement (10 min)
Dans GitHub Actions, lancer le workflow manuel:
- `CD — Deploy to Dev (ACR build + AKS deploy)`

Pourquoi manuel dans ce lab:
- le pipeline AML prend deja plusieurs minutes
- on ne veut pas builder, pusher et deployer a chaque push de test
- cela rend la demonstration plus previsible et plus proche d'un vrai gate de promotion `dev`
- en pratique, l'ordre devient donc: `push` -> `CI AML` -> verification du resultat -> lancement manuel du `CD dev`

Ce que fait exactement ce workflow:
- il reconstruit un artefact modele local pour embarquer l'application de scoring
- il build une image Docker
- il push cette image dans l'ACR
- il deploie cette image sur AKS avec Kubernetes

Ce qu'il ne fait pas:
- il n'enregistre pas `iris-classifier` dans le registre de modeles AML
- il ne cree pas de `Managed Endpoint` Azure ML

### 5. Tester l'endpoint AKS (15 min)
Si `kubectl` n'est pas installe en local:
```bash
az aks install-cli
```

Puis:
```bash
az aks get-credentials --resource-group rg-mlopslab-dev --name aks-mlopslab-dev --overwrite-existing

kubectl get svc iris-classifier-svc

curl -X POST http://<EXTERNAL-IP>/score -H "Content-Type: application/json" -d '{"data": [[5.1, 3.5, 1.4, 0.2]]}'
```

Remplacer `<EXTERNAL-IP>` par la vraie valeur retournee par `kubectl get svc iris-classifier-svc`.
Attendu:
```json
[{"prediction": "setosa", "...": "..."}]
```

Cette etape ne teste pas AML directement.
Elle teste le resultat du workflow CD dev:
- build de l'image applicative
- push dans l'ACR
- deploiement Kubernetes sur AKS
- exposition du service `iris-classifier-svc`

Note d'architecture:
- ici, le deploiement AKS est lance manuellement apres un CI vert pour garder la main sur le temps et le cout
- dans un vrai flux MLOps, on prefererait souvent un declenchement manuel ou une promotion explicite avant de deployer

### 6. Deployer le Managed Endpoint AML (backup fonctionnel, 10 min)
Dans GitHub Actions, lancer le workflow manuel:
- `CD — Deploy AML Managed Endpoint`
- `target_env=dev`

Puis verifier l'invocation smoke-test dans les logs du workflow.

Ce que fait exactement ce workflow:
- il prepare les assets AML utiles au workspace
- il entraine et evalue le modele dans le runner GitHub
- il enregistre ensuite `iris-classifier` dans le registre de modeles du workspace AML
- il cree aussi un environnement AML d'inference dedie au serving du Managed Endpoint
- il cree ou met a jour un `online endpoint` AML et son deployment associe
- il invoque enfin l'endpoint pour un smoke test

Quand l'utiliser dans le lab:
- si tu veux comparer `AKS` et `Managed Endpoint AML`
- si tu veux preparer le Jour 4 et voir apparaitre `iris-classifier` dans `az ml model list`
- si tu veux une voie de serving plus proche d'un service ML gere que d'un cluster Kubernetes

Point d'attention quota/cout:
- ce workflow consomme des ressources de `Managed Online Endpoint` Azure ML, avec ses propres quotas de VM
- sur certaines subscriptions de lab, le deployment peut echouer si la taille de VM demandee n'est pas disponible
- dans ce repo, le deployment est volontairement dimensionne de facon modeste pour limiter ce risque, mais AKS reste le chemin principal du lab

Pourquoi cette etape est importante pour la suite:
- ce workflow enregistre aussi le modele `iris-classifier` dans le workspace AML
- c'est ce modele enregistre que tu manipuleras au Jour 4 avec `az ml model list --name iris-classifier`
- si tu sautes cette etape, la partie "versioning de modeles" du Jour 4 risque de ne rien afficher

Pourquoi ce workflow n'a pas le meme probleme MLflow que le pipeline AML:
- ici, `prep.py`, `train.py` et `evaluate.py` tournent localement dans le runner GitHub, pas comme job AML distant
- `train.py` ne fait plus de `mlflow.sklearn.log_model()`
- le modele est enregistre ensuite proprement dans AML via `register.py` et le SDK `azure-ai-ml`
- le serving AML utilise un environnement d'inference separe de l'environnement d'entrainement
- on evite donc ici l'incompatibilite rencontree plus tot avec l'URI `azureml://...` du tracking MLflow en job AML

### 7. Tester le quality gate (5 min)
```bash
# Dans evaluate.py, passer min_accuracy a 0.99
# Pousser -> observer le CI echouer sur evaluate_model
# Remettre 0.90 et repousser
```

## Checkpoint J3
- [ ] CI vert (lint + tests + AML pipeline)
- [ ] Endpoint AKS repond a curl
- [ ] Managed Endpoint AML deploye et invoque avec succes
- [ ] Quality gate teste : echec a 0.99, succes a 0.90
