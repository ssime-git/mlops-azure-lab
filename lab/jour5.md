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

Il suppose aussi qu'un groupe Entra ID existe deja pour l'exercice RBAC.
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
az role assignment list --resource-group rg-mlopslab-dev --output table
```

Si le groupe `mlops-team` n'existe pas:
- utiliser un groupe Entra ID existant fourni par le formateur
- ou creer un groupe de test avant de lancer le script

### 3. Utiliser Key Vault (10 min)
```bash
KV="kv-mlopslab-dev"
az keyvault secret set --vault-name $KV --name "model-api-key" --value "secret-key-123"
az keyvault secret show --vault-name $KV --name "model-api-key" --query value -o tsv
```

### 4. Audit OIDC vs Service Principal (10 min)
Questions de comprehension :
- Ou est stocke le Client ID dans le workflow ? (GitHub Secret, pas en clair)
- Quelle est la duree de vie du token OIDC ? (~1h, non renouvelable)
- Pourquoi est-ce plus sur qu'un SP secret ? (pas de secret longue duree stocke)

### 5. Checklist Standards Equipe (20 min)

**Infrastructure**
- [ ] Les ressources d'infrastructure du lab sont gerees principalement via Terraform
- [ ] Tags `environment`, `project`, `managed_by` sur toutes les ressources
- [ ] Budget alert configuree sur le subscription

**CI/CD**
- [ ] 0 secret en clair dans le code
- [ ] Quality gate accuracy >= 0.90 dans le CI
- [ ] Approbation manuelle requise pour prod

**ML**
- [ ] Chaque modele deploye = enregistre dans le workspace AML
- [ ] Chaque run = metriques loggees (MLflow)
- [ ] Drift monitoring configure sur endpoint prod

**Securite**
- [ ] OIDC pour GitHub -> Azure (pas de secret SP)
- [ ] Pas de `Contributor` au scope subscription pour le pipeline (scope RG uniquement)
- [ ] Secrets dans Key Vault
- [ ] RBAC minimal (principe du moindre privilege)

## Checkpoint J5
- [ ] RBAC configure via script
- [ ] Secret lu depuis Key Vault
- [ ] Checklist completee et discutee en groupe
