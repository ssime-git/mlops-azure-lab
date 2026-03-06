# Jour 2 — Infrastructure as Code & Environnements

## Objectifs
- Demarrer avec Bicep pour comprendre l'IaC Azure-native
- Basculer sur Terraform pour la gestion operationnelle de dev/prod
- Comprendre la separation dev/prod
- Comparer Bicep vs Terraform sur une meme architecture

## Atelier

### 1. Demo Bicep rapide (15 min)
```bash
az login
bash scripts/deploy-bicep-demo.sh rg-mlopslab-bicep-demo westeurope
```
Objectif: voir le flux Bicep en mode **lite** (cout + temps reduits) sans impacter les environnements Terraform.

Option avancee (full Bicep avec garde-fous):
```bash
# Garde-fous integres: project_name unique obligatoire + RG reservees bloquees
bash scripts/deploy-bicep-full.sh dev mlopsteam01 rg-mlopsteam01-dev westeurope
```

### 2. Preparer le backend Terraform (10 min)
```bash
TFSTATE_SUFFIX=$(whoami | tr -cd 'a-z0-9' | cut -c1-8)
TFSTATE_SA="satfstate${TFSTATE_SUFFIX}"

az group create --name rg-tfstate --location westeurope
az storage account create --name "$TFSTATE_SA" --resource-group rg-tfstate --sku Standard_LRS
az storage container create --name tfstate --account-name "$TFSTATE_SA"
```

### 3. Terraform dev (25 min)
```bash
cd infrastructure/terraform
terraform init \
  -backend-config="resource_group_name=rg-tfstate" \
  -backend-config="storage_account_name=$TFSTATE_SA" \
  -backend-config="container_name=tfstate" \
  -backend-config="key=mlopslab-dev.tfstate"

terraform plan -var-file="environments/dev.tfvars"
terraform apply -var-file="environments/dev.tfvars"
```

### 4. Terraform prod (optionnel, 10 min)
```bash
terraform init -reconfigure \
  -backend-config="resource_group_name=rg-tfstate" \
  -backend-config="storage_account_name=$TFSTATE_SA" \
  -backend-config="container_name=tfstate" \
  -backend-config="key=mlopslab-prod.tfstate"

terraform plan -var-file="environments/prod.tfvars"
terraform apply -var-file="environments/prod.tfvars"
```

### 5. Verification + comparaison (10 min)
- `terraform output` pour verifier AML/AKS/ACR
- Portail Azure: verifier rg-mlopslab-dev (7 ressources)
- Ouvrir `infrastructure/terraform-reference/` pour voir une version simplifiee de lecture

## Checkpoint J2
- [ ] 7 ressources dans rg-mlopslab-dev
- [ ] Terraform state distant configure
- [ ] Outputs Terraform visibles (workspace + AKS + ACR)
- [ ] Differences Bicep vs Terraform expliquees
