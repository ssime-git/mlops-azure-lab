# Jour 1 — Fondations DevOps & Azure pour la Data/ML

## Objectifs
- Comprendre DevOps vs MLOps
- Naviguer dans les services Azure cles (AML, ACR, AKS)
- Demarrer par un notebook pour visualiser le flux dans l'interface AML
- Lancer le pipeline ML localement de bout en bout

## Positionnement de J1 par rapport a J2

Le Jour 1 est une journee de **prise en main**:
- on decouvre les concepts
- on execute le pipeline ML en local
- on comprend comment AML va etre utilise ensuite

La creation "officielle" de l'infrastructure Azure `dev` du lab est faite au **Jour 2** avec Terraform.

Important:
- ne pas creer manuellement `rg-mlopslab-dev` au Jour 1
- ne pas creer manuellement `aml-mlopslab-dev` si tu veux ensuite laisser Terraform gerer l'infra
- sinon le `terraform apply` du Jour 2 echouera car les ressources existeront deja

## Prerequis
- Compte Azure actif avec acces au subscription de lab
- git, Python 3.10, Azure CLI installes
- `az extension add -n ml` execute

## Architecture (schema a dessiner)
```
GitHub Actions (CI/CD)
       |
       |-- Azure ML (train, track, register)
       |         v
       '-- ACR (image) -> AKS (serving)
                              v
                   Azure Monitor + App Insights
                   Key Vault (secrets)
```

## Atelier

### 1. Setup (5 min)
```bash
git clone https://github.com/TON_ORG/mlops-azure-lab.git
cd mlops-azure-lab
uv venv --python 3.10
source .venv/bin/activate
uv pip install -r requirements.txt
```

### 2. Convention de branches (5 min)
- `main` -> CI + CD prod (approbation manuelle)
- `dev`  -> CI + CD dev automatique
- `feature/*` -> CI seulement

### 3. Comprendre le futur workspace AML dev (15 min)
```bash
az login
```

Ce que l'on fait ici:
- verifier l'acces Azure
- comprendre a quoi servira le workspace AML dev
- preparer mentalement la suite du lab

Ce que l'on **ne fait pas** ici:
- creer `rg-mlopslab-dev`
- creer `aml-mlopslab-dev`

Ces ressources seront creees au Jour 2 par Terraform.

Si le formateur fournit deja un workspace AML dev existant pour la demo:
- l'utiliser en lecture / exploration
- ne pas le recreer a la main

### 4. Notebook first (15 min)
Ouvrir `mlops/data-science/notebooks/iris-walkthrough.ipynb` dans Azure ML Studio (ou local Jupyter) et executer toutes les cellules.

Si le workspace AML dev n'existe pas encore a ce stade:
- faire la lecture du notebook localement
- se concentrer sur la logique `prep -> train -> evaluate`
- la partie Azure AML operationnelle sera reprise apres creation de l'infra au Jour 2

Points a observer:
- split train/test cree par `prep`
- modele `model.joblib` cree par `train`
- quality gate dans `evaluate`

### 5. Passage notebook -> scripts (15 min)
```bash
uv run python mlops/data-science/src/prep.py --output_dir /tmp/iris
uv run python mlops/data-science/src/train.py --data_dir /tmp/iris --model_dir /tmp/model
uv run python mlops/data-science/src/evaluate.py --data_dir /tmp/iris --model_dir /tmp/model
uv run pytest tests/ -v
```

## Checkpoint J1
- [ ] Notebook Iris execute de bout en bout
- [ ] Pipeline local (prep -> train -> evaluate) sans erreur
- [ ] `uv run pytest tests/ -v` : 5 tests PASSED

Checkpoint optionnel si un workspace de demo existe deja:
- [ ] Workspace AML dev visible sur le portail
