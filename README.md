# MLOps Azure Lab — Formation 5 jours

Cas fil rouge : classification Iris deployee sur Azure ML + AKS via CI/CD GitHub Actions.

## Stack technique
- **Cloud** : Microsoft Azure
- **ML Platform** : Azure Machine Learning (CLI v2 / SDK v2)
- **IaC** : Bicep (demonstration J2) puis Terraform (usage operationnel dev/prod)
- **CI/CD** : GitHub Actions (OIDC auth)
- **Container** : Azure Container Registry -> AKS
- **Monitoring** : MLflow + Azure Monitor + Application Insights
- **Secrets** : Azure Key Vault

## Environnements
| Env  | Resource Group       | AML Workspace       | AKS Cluster         |
|------|----------------------|---------------------|---------------------|
| dev  | rg-mlopslab-dev      | aml-mlopslab-dev    | aks-mlopslab-dev    |
| prod | rg-mlopslab-prod     | aml-mlopslab-prod   | aks-mlopslab-prod   |

## Structure
```
infrastructure/    -> Bicep (demo) + Terraform (operationnel) + Terraform reference (lecture)
mlops/             -> Code ML + pipelines AML + Dockerfile
.github/workflows/ -> CI/CD GitHub Actions (CI/CD + ops bootstrap + endpoint AML)
lab/               -> Instructions pratiques J1 a J5
scripts/           -> Utilitaires (drift, RBAC, bootstrap AML, deploiement Bicep guide)
tests/             -> Tests unitaires Python
```

## Demarrage rapide
Voir `lab/lab0-setup.md` pour les prerequis et la mise en place initiale.
Premier support notebook pour J1 : `mlops/data-science/notebooks/iris-walkthrough.ipynb`.
Pour le setup local rapide: `uv venv --python 3.10 && source .venv/bin/activate && uv pip install -r requirements.txt`.

## Dépendances Python
- `requirements.in` : dépendances directes (source humaine)
- `requirements.txt` : lock déterministe généré via uv (`uv pip compile requirements.in --python-version 3.10 -o requirements.txt`)

## Workflows cles
- `CI — Lint + Tests + AML Training Pipeline`
- `CD — Deploy to Dev (ACR build + AKS deploy)`
- `CD — Deploy to Prod (Manual Approval Required)`
- `Ops — Bootstrap AML Assets`
- `CD — Deploy AML Managed Endpoint`
