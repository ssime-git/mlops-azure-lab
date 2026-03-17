# Jour 5 — Securite, Gouvernance & Bonnes pratiques

## Objectifs
- Configurer RBAC pour une equipe MLOps
- Utiliser Key Vault
- Valider les standards equipe

## Dependances depuis les jours precedents

Le Jour 5 suppose que l'environnement `dev` existe deja:
- `rg-mlopslab-dev`
- `aml-mlopslab-dev`
- `aks-mlopslab-dev`
- `kv-mlopslab-dev`

Le setup precedent ne cree pas de groupe Entra ID pour toi.
Pour l'exercice RBAC, il faut donc:
- soit reutiliser un groupe Entra ID deja fourni
- soit creer un groupe de test, puis le supprimer a la fin

Dans les exemples ci-dessous, on utilise `mlops-team`.

## Atelier

### 1. Inspecter les role assignments existants (5 min)
```bash
az role assignment list --resource-group rg-mlopslab-dev --output table
```

### 2. Configurer RBAC (15 min)
```bash
az ad group show --group "mlops-team" --query id -o tsv
bash scripts/setup-rbac.sh dev <GROUP_OBJECT_ID>
az role assignment list --assignee <GROUP_OBJECT_ID> --all --query "[].{role:roleDefinitionName,scope:scope}" -o table
```

Si le groupe `mlops-team` n'existe pas:
- utiliser un groupe Entra ID existant fourni par le formateur
- ou creer un groupe de test avant de lancer le script

Exemple avec un groupe de test:
```bash
az ad group create \
  --display-name "mlops-team" \
  --mail-nickname "mlops-team"

GROUP_OBJECT_ID=$(az ad group show --group "mlops-team" --query id -o tsv)

bash scripts/setup-rbac.sh dev "$GROUP_OBJECT_ID"

az role assignment list \
  --assignee "$GROUP_OBJECT_ID" \
  --all \
  --query "[].{role:roleDefinitionName,scope:scope}" \
  -o table
```

Ce que fait le script:
- attribue `AzureML Data Scientist` au scope du resource group `rg-mlopslab-dev`
- attribue `Azure Kubernetes Service Cluster User Role` au scope du cluster AKS dev
- attribue `Key Vault Secrets User` au scope du Key Vault dev

Pourquoi la verification utilise `--assignee --all`:
- une partie des rôles est au scope du resource group
- une autre partie est au scope de ressources individuelles comme AKS et Key Vault
- `--resource-group` seul ne montre pas toujours clairement toute l'image

Nettoyage optionnel a la fin du lab:
```bash
az ad group delete --group "mlops-team"
```

### 3. Utiliser Key Vault (10 min)
```bash
KV="kv-mlopslab-dev"
az keyvault secret set --vault-name $KV --name "model-api-key" --value "secret-key-123"
az keyvault secret show --vault-name $KV --name "model-api-key" --query value -o tsv
```

Ce que montre cet exercice:
- comment stocker un secret dans Key Vault
- comment le relire via Azure CLI

Ce que cet exercice ne montre pas encore:
- l'injection automatique du secret dans l'application
- la lecture du secret depuis le code applicatif

### 4. Audit OIDC vs Service Principal (10 min)
Questions de comprehension :
- Ou est stocke le Client ID dans le workflow ? (GitHub Secret, pas en clair)
- Quelle est la duree de vie du token OIDC ? (~1h, non renouvelable)
- Pourquoi est-ce plus sur qu'un SP secret ? (pas de secret longue duree stocke)

### 5. Checklist Standards Equipe (20 min)

**Infrastructure**
- [ ] Les ressources d'infrastructure du lab sont gerees principalement via Terraform
- [ ] Tags `environment`, `project`, `managed_by` sur toutes les ressources
- [ ] Budget alert configuree sur le subscription si ton organisation le permet

**CI/CD**
- [ ] 0 secret en clair dans le code
- [ ] Quality gate accuracy >= 0.90 dans le CI
- [ ] Approbation manuelle requise pour prod

**ML**
- [ ] Les runs AML journalisent bien des metriques (MLflow)
- [ ] Le modele `iris-classifier` est visible dans le workspace AML apres execution du workflow `CD — Deploy AML Managed Endpoint`
- [ ] Le deploiement AKS et le Managed Endpoint AML sont bien compris comme deux chemins differents
- [ ] Drift / telemetrie verifies sur l'environnement `dev`

**Securite**
- [ ] OIDC pour GitHub -> Azure (pas de secret SP)
- [ ] Pas de `Contributor` au scope subscription pour le pipeline (scope RG uniquement)
- [ ] Secrets dans Key Vault
- [ ] RBAC minimal (principe du moindre privilege)

## Checkpoint J5
- [ ] RBAC configure via script
- [ ] Secret lu depuis Key Vault
- [ ] Checklist completee et discutee en groupe
