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
.github/workflows/ -> CI/CD GitHub Actions (inlines, sans dependance externe)
lab/               -> Instructions pratiques J1 a J5
scripts/           -> Utilitaires (drift, RBAC)
tests/             -> Tests unitaires Python
```

## Demarrage rapide
Voir `lab/lab0-setup.md` pour les prerequis et la mise en place initiale.
