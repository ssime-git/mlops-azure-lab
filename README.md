# MLOps Azure Lab — Formation 5 Jours

Lab intensif MLOps/DevOps Azure base sur un cas fil rouge unique :
classification Iris, industrialisation CI/CD, deploiement inferentiel, observabilite et gouvernance.

## Objectif
Construire une chaine MLOps de bout en bout, du notebook au deploiement prod,
avec des pratiques proches du terrain entreprise.

## Portee du Lab
- Cloud: Azure
- ML platform: Azure Machine Learning (CLI/SDK v2)
- IaC: Bicep (demo J2) puis Terraform (operationnel dev/prod)
- CI/CD: GitHub Actions + OIDC
- Serving: AKS (primaire) + AML Managed Endpoint (backup fonctionnel)
- Observabilite: MLflow, Azure Monitor, Application Insights
- Secrets & securite: Key Vault, RBAC, federated identity

## Environnements
| Env  | Resource Group       | AML Workspace       | AKS Cluster         |
|------|----------------------|---------------------|---------------------|
| dev  | rg-mlopslab-dev      | aml-mlopslab-dev    | aks-mlopslab-dev    |
| prod | rg-mlopslab-prod     | aml-mlopslab-prod   | aks-mlopslab-prod   |

## Parcours Pedagogique
- J0: setup securise (OIDC, secrets, environnements GitHub)
- J1: setup > notebook > scripts > tests
- J2: demo Bicep puis Terraform operationnel
- J3: CI/CD GitHub Actions + deploiements AKS/AML endpoint
- J4: tracking, registry, monitoring, drift
- J5: RBAC, Key Vault, standards equipe

## Prerequis
- Python 3.10
- `uv` (gestionnaire Python rapide)
- Azure CLI + extension `ml`
- Acces Azure subscription

## Demarrage Rapide (Local)
```bash
git clone https://github.com/TON_ORG/mlops-azure-lab.git
cd mlops-azure-lab
uv venv --python 3.10
source .venv/bin/activate
uv pip install -r requirements.txt

python mlops/data-science/src/prep.py --output_dir /tmp/iris
python mlops/data-science/src/train.py --data_dir /tmp/iris --model_dir /tmp/model
python mlops/data-science/src/evaluate.py --data_dir /tmp/iris --model_dir /tmp/model
pytest tests/ -v
```

## Setup Azure/GitHub
Suivre: `lab/lab0-setup.md`

## Workflows GitHub Actions
- `CI — Lint + Tests + AML Training Pipeline`
- `CD — Deploy to Dev (ACR build + AKS deploy)`
- `CD — Deploy to Prod (Manual Approval Required)`
- `Ops — Bootstrap AML Assets`
- `CD — Deploy AML Managed Endpoint`

## Qualite et Reproductibilite
- Sources dep: `requirements.in`
- Lock dep deterministe: `requirements.txt` (genere via uv)
- Tests: unitaires + integration endpoint local
- Lint/format: flake8 + black

## Structure du Repo
```text
.github/workflows/     CI/CD et workflows ops
infrastructure/bicep/  Demo IaC Azure-native (lite/full)
infrastructure/terraform/ IaC operationnel (dev/prod)
infrastructure/terraform-reference/ support lecture
mlops/data-science/    code ML, notebook, server, Dockerfile
mlops/pipelines/       YAML AML + manifest AKS
lab/                   guides J0 a J5
scripts/               bootstrap, RBAC, drift, deploy helpers
tests/                 tests unitaires + integration
```

## Documentation Formation
- Lab setup: `lab/lab0-setup.md`
- Jour 1: `lab/jour1.md`
- Jour 2: `lab/jour2.md`
- Jour 3: `lab/jour3.md`
- Jour 4: `lab/jour4.md`
- Jour 5: `lab/jour5.md`
- Infographie complete: `docs/infographie-mlops-lab.md`
- Infographie Excalidraw (source editable): `docs/infographie-mlops-lab.excalidraw`
- Infographie PNG (export): `docs/infographie-mlops-lab.png`

## Wiki du Repo
- Index du wiki: `docs/wiki/README.md`
- Vision MLOps cloud: `docs/wiki/01-vision-mlops-cloud.md`
- Architecture du repo: `docs/wiki/02-architecture-du-repo.md`
- CI/CD GitHub Actions + Azure: `docs/wiki/03-ci-cd-github-actions-azure.md`
- Serving, observabilite et gouvernance: `docs/wiki/04-serving-observabilite-gouvernance.md`
- GitHub Actions vs Azure DevOps: `docs/wiki/05-github-actions-vs-azure-devops.md`
