# Terraform - IaC operationnel du lab

Ce dossier contient la version **operationnelle** de l'infrastructure pour la suite du lab.

Parcours recommande:
- J2: demo Bicep rapide (prise en main Azure-native)
- J2/J3+: bascule Terraform pour gerer dev/prod de facon durable

## Usage rapide
```bash
cd infrastructure/terraform
terraform init \
  -backend-config="resource_group_name=rg-tfstate" \
  -backend-config="storage_account_name=satfstatemlops" \
  -backend-config="container_name=tfstate" \
  -backend-config="key=mlopslab-dev.tfstate"

terraform plan -var-file="environments/dev.tfvars"
terraform apply -var-file="environments/dev.tfvars"
```
