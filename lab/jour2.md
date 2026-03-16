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

Recommandation lab:
- Faire **au minimum** l'environnement `dev`
- Prevoir un `terraform destroy -var-file="environments/dev.tfvars"` en fin de session si le cluster ne sert plus
- Ne pas laisser AKS tourner inutilement pendant la nuit ou plusieurs jours

Point cout:
- `dev` cree un cluster AKS avec `1 x Standard_D2s_v3`
- C'est acceptable pour un lab court, mais ce n'est pas une infra "gratuite"

### 4. Terraform prod (optionnel, 10 min)
> **Important — optionnel pour raison de cout**
>
> Cette etape est **optionnelle**. Elle existe pour illustrer la separation `dev` / `prod`,
> mais elle cree une infra sensiblement plus chere que `dev`.
>
> La configuration actuelle `prod` cree un cluster AKS avec `2 x Standard_D4s_v3`.
> Pour un lab, **ne lancer cette etape que si c'est explicitement demande**.
> Sinon, rester sur `dev` suffit pour valider les objectifs du Jour 2.

```bash
terraform init -reconfigure \
  -backend-config="resource_group_name=rg-tfstate" \
  -backend-config="storage_account_name=$TFSTATE_SA" \
  -backend-config="container_name=tfstate" \
  -backend-config="key=mlopslab-prod.tfstate"

terraform plan -var-file="environments/prod.tfvars"
terraform apply -var-file="environments/prod.tfvars"
```

Si tu lances quand meme `prod` pour la demo:
- verifier le `terraform plan` avant `apply`
- detruire l'environnement a la fin avec `terraform destroy -var-file="environments/prod.tfvars"`
- ne pas considerer cette configuration comme une vraie prod

Si tu veux une "prod low cost" uniquement pour tester la commande:
- dupliquer `environments/prod.tfvars` dans un fichier temporaire, par exemple `environments/prod-lowcost.tfvars`
- reduire temporairement la taille a `aks_node_count = 1` et `aks_vm_size = "Standard_D2s_v3"`
- lancer `plan/apply` avec ce fichier temporaire
- detruire juste apres le test

Exemple:
```bash
cp environments/prod.tfvars environments/prod-lowcost.tfvars
# puis editer prod-lowcost.tfvars:
# aks_node_count = 1
# aks_vm_size    = "Standard_D2s_v3"

terraform plan -var-file="environments/prod-lowcost.tfvars"
terraform apply -var-file="environments/prod-lowcost.tfvars"
terraform destroy -var-file="environments/prod-lowcost.tfvars"
```

Pour une vraie production:
- dimensionner AKS selon la charge reelle, pas "au plus petit"
- utiliser au minimum plusieurs nœuds et une capacite compatible avec la haute disponibilite
- definir des exigences claires sur disponibilite, supervision, sauvegarde, reseau et securite
- revoir le SKU ACR, les logs, les policies et le dimensionnement avant toute mise en service

### 5. Verification + comparaison (10 min)
- `terraform output` pour verifier AML/AKS/ACR
- Portail Azure: verifier rg-mlopslab-dev (7 ressources)
- Ouvrir `infrastructure/terraform-reference/` pour voir une version simplifiee de lecture

## Checkpoint J2
- [ ] 7 ressources dans rg-mlopslab-dev
- [ ] Terraform state distant configure
- [ ] Outputs Terraform visibles (workspace + AKS + ACR)
- [ ] Differences Bicep vs Terraform expliquees
