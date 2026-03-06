# Jour 3 — CI/CD pour le Machine Learning

## Objectifs
- Comprendre Azure Pipelines et GitHub Actions (theorie)
- Lire et comprendre les 3 workflows GitHub Actions du repo
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

### 1. Lire les workflows (15 min)
Ouvrir `.github/workflows/` et repondre :
- Qu'est-ce qui declenche `ci-train.yml` ?
- Pourquoi `train-pipeline` a `environment: dev` ?
- Que font les 3 commandes `sed` dans `cd-deploy-dev.yml` ?
- Pourquoi `cd-deploy-prod.yml` necessite `environment: production` ?
- Quelles etapes du notebook J1 sont reprises dans les scripts `prep.py`, `train.py`, `evaluate.py` ?

### 2. Premier push sur dev (10 min)
```bash
git checkout dev
# Modifier train.py : max_iter 200 -> 300
git add mlops/data-science/src/train.py
git commit -m "feat: max_iter 300"
git push origin dev
```
Observer GitHub Actions : les 3 jobs de `ci-train.yml`.

### 3. Observer le pipeline AML (15 min)
Azure ML Studio > Jobs > pipeline en cours.
Cliquer sur chaque etape : prep_data, train_model, evaluate_model.

### 4. Tester l'endpoint AKS (15 min)
```bash
az aks get-credentials --resource-group rg-mlopslab-dev --name aks-mlopslab-dev
kubectl get svc iris-classifier-svc   # noter EXTERNAL-IP
curl -X POST http://EXTERNAL_IP/score \
  -H "Content-Type: application/json" \
  -d '{"data": [[5.1, 3.5, 1.4, 0.2]]}'
# Attendu : [{"prediction": "setosa", ...}]
```

### 5. Tester le quality gate (5 min)
```bash
# Dans evaluate.py, passer min_accuracy a 0.99
# Pousser -> observer le CI echouer sur evaluate_model
# Remettre 0.90 et repousser
```

## Checkpoint J3
- [ ] CI vert (lint + tests + AML pipeline)
- [ ] Endpoint AKS repond a curl
- [ ] Quality gate teste : echec a 0.99, succes a 0.90
