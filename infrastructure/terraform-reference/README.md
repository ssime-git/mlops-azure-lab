# Terraform Reference — Lecture seule

Ce dossier contient la version Terraform de l'infrastructure deployeee en Bicep dans `../bicep/`.

Le code Terraform **operationnel** du lab est dans `../terraform/`.
Ce dossier `terraform-reference/` reste volontairement simplifie pour la comparaison pedagogique.

Points cles a retenir :
- Terraform necessite un backend (etat distant sur Azure Storage ou Terraform Cloud)
- `terraform init` doit etre lance avant tout apply
- Les providers (`hashicorp/azurerm`) s'installent localement dans `.terraform/`
- Les ressources sont identiques : seule la syntaxe HCL differe du Bicep ARM

Commandes de reference (a ne pas executer en lab) :
```bash
terraform init -backend-config="..."
terraform plan -var-file="environments/dev.tfvars"
terraform apply -var-file="environments/dev.tfvars"
terraform destroy -var-file="environments/dev.tfvars"
```
