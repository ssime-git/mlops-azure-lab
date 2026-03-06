# Jour 2 — Infrastructure as Code & Environnements

## Objectifs
- Deployer l'infra Azure via Bicep
- Comprendre la separation dev/prod
- Lire un template Bicep et ses modules
- Comparer Bicep (pratique) vs Terraform (reference)

## Atelier

### 1. Creer les resource groups (10 min)
```bash
az login
az group create --name rg-mlopslab-dev --location westeurope
az group create --name rg-mlopslab-prod --location westeurope
```

### 2. Deployer l'infra dev avec Bicep (25 min)
```bash
az deployment group create \
  --resource-group rg-mlopslab-dev \
  --template-file infrastructure/bicep/main.bicep \
  --parameters infrastructure/bicep/parameters/dev.bicepparam
```

### 3. Verifier sur le portail (10 min)
Portal > rg-mlopslab-dev -> 7 ressources attendues :
Storage Account, Key Vault, ACR, Log Analytics, App Insights, AML Workspace, AKS

### 4. Lire les outputs (5 min)
```bash
az deployment group show \
  --resource-group rg-mlopslab-dev \
  --name main \
  --query properties.outputs
```

### 5. Theorie Terraform reference (10 min)
Ouvrir `infrastructure/terraform-reference/` et comparer :
- providers, backend, state file
- equivalence des ressources avec Bicep

## Checkpoint J2
- [ ] 7 ressources dans rg-mlopslab-dev
- [ ] Outputs deployment visibles (workspace + AKS + ACR)
- [ ] Differences Bicep vs Terraform expliquees
