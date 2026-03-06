# Jour 1 — Fondations DevOps & Azure pour la Data/ML

## Objectifs
- Comprendre DevOps vs MLOps
- Naviguer dans les services Azure cles (AML, ACR, AKS)
- Demarrer par un notebook pour visualiser le flux dans l'interface AML
- Lancer le pipeline ML localement de bout en bout

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
cd mlops-azure-lab && pip install -r requirements.txt
```

### 2. Convention de branches (5 min)
- `main` -> CI + CD prod (approbation manuelle)
- `dev`  -> CI + CD dev automatique
- `feature/*` -> CI seulement

### 3. Creer le workspace AML dev (portail, 15 min)
```bash
az login
az group create --name rg-mlopslab-dev --location westeurope
# Portal > Azure Machine Learning > Create
# RG: rg-mlopslab-dev | Name: aml-mlopslab-dev
```

### 4. Notebook first (15 min)
Ouvrir `mlops/data-science/notebooks/iris-walkthrough.ipynb` dans Azure ML Studio (ou local Jupyter) et executer toutes les cellules.

Points a observer:
- split train/test cree par `prep`
- modele `model.joblib` cree par `train`
- quality gate dans `evaluate`

### 5. Passage notebook -> scripts (15 min)
```bash
python mlops/data-science/src/prep.py --output_dir /tmp/iris
python mlops/data-science/src/train.py --data_dir /tmp/iris --model_dir /tmp/model
python mlops/data-science/src/evaluate.py --data_dir /tmp/iris --model_dir /tmp/model
pytest tests/ -v
```

## Checkpoint J1
- [ ] Notebook Iris execute de bout en bout
- [ ] Pipeline local (prep -> train -> evaluate) sans erreur
- [ ] Workspace AML dev visible sur le portail
- [ ] `pytest tests/ -v` : 3 tests PASSED
