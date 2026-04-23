# Partie 5 — Sécurité, Gouvernance & Bonnes pratiques

## Objectifs
- Comprendre comment configurer RBAC pour une équipe MLOps
- Découvrir l'usage d'Azure Key Vault
- Valider les standards d'équipe sur l'ensemble du lab

> [!IMPORTANT]
> Vous n'avez pas besoin d'exécuter les commandes de cette partie. L'objectif est de **découvrir** les patterns de sécurité et de gouvernance qui s'appliqueraient dans un vrai projet MLOps.

## Dépendances depuis les parties précédentes

La Partie 5 suppose que l'environnement `dev` existe déjà (noms suffixés via `lab/env/naming.env`) :
- `$AML_RESOURCE_GROUP_DEV` (ex. `rg-mlopslab-<suffix>-dev`)
- `$AML_WORKSPACE_DEV` (ex. `aml-mlopslab-<suffix>-dev`)
- `$AKS_CLUSTER_DEV` (ex. `aks-mlopslab-<suffix>-dev`)
- Key Vault (ex. `kv-mlopslab-<suffix>-dev`)

Le setup précédent ne crée pas de groupe Entra ID. Pour l'exercice RBAC, vous pouvez :
- soit réutiliser un groupe Entra ID déjà fourni par le formateur
- soit créer un groupe de test, puis le supprimer à la fin

Dans les exemples ci-dessous, le groupe utilisé est `mlops-team`.

## Atelier

### 1. Inspecter les role assignments existants (5 min)

Avant d'ajouter des rôles, observez ceux déjà en place sur le resource group `dev` :

```bash
source lab/env/partie2.env
az role assignment list \
  --resource-group "$AML_RESOURCE_GROUP_DEV" \
  --output table
```

### 2. Configurer RBAC pour l'équipe MLOps (15 min)

Le script `scripts/setup-rbac.sh` attribue un ensemble de rôles à un groupe Entra ID sur les ressources clés du lab :

```bash
# Recuperer l'Object ID du groupe Entra ID
az ad group show --group "mlops-team" --query id -o tsv

# Attribuer les roles via le script du depot
bash scripts/setup-rbac.sh dev <GROUP_OBJECT_ID>

# Verifier les attributions
az role assignment list \
  --assignee <GROUP_OBJECT_ID> \
  --all \
  --query "[].{role:roleDefinitionName,scope:scope}" \
  -o table
```

Si le groupe `mlops-team` n'existe pas :
- utilisez un groupe Entra ID fourni par le formateur
- ou créez un groupe de test avant de lancer le script

Exemple avec un groupe de test :
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

Ce que fait le script :
- attribue `AzureML Data Scientist` au scope du resource group `$AML_RESOURCE_GROUP_DEV`
- attribue `Azure Kubernetes Service Cluster User Role` au scope du cluster AKS `dev`
- attribue `Key Vault Secrets User` au scope du Key Vault `dev`

> [!NOTE]
> La vérification utilise `--assignee --all` car :
> - une partie des rôles est au scope du resource group
> - une autre au scope de ressources individuelles (AKS, Key Vault)
> - `--resource-group` seul ne montre pas toute l'image

Nettoyage optionnel à la fin du lab :

```bash
az ad group delete --group "mlops-team"
```

### 3. Utiliser Key Vault (10 min)

Key Vault centralise les secrets (clés API, mots de passe, certificats). Stockez et relisez un secret de test :

```bash
source lab/env/partie2.env

# Recuperer le nom du Key Vault deploye par Terraform
KV=$(az resource list \
  --resource-group "$AML_RESOURCE_GROUP_DEV" \
  --resource-type Microsoft.KeyVault/vaults \
  --query "[0].name" -o tsv)
echo "KV: $KV"

# Ecrire un secret
az keyvault secret set \
  --vault-name "$KV" \
  --name "model-api-key" \
  --value "secret-key-123"

# Relire le secret
az keyvault secret show \
  --vault-name "$KV" \
  --name "model-api-key" \
  --query value -o tsv
```

Ce que montre cet exercice :
- comment stocker un secret dans Key Vault
- comment le relire via Azure CLI

Ce que cet exercice **ne montre pas** :
- l'injection automatique du secret dans l'application (via CSI driver sur AKS, par exemple)
- la lecture du secret depuis le code applicatif via une identité managée

### 4. Audit OIDC vs Service Principal (10 min)

Questions de compréhension :
- Où est stocké le `Client ID` dans le workflow ? **(GitHub Secret, pas en clair dans le YAML)**
- Quelle est la durée de vie du token OIDC ? **(~1h, non renouvelable en dehors du workflow)**
- Pourquoi est-ce plus sûr qu'un SP avec secret ? **(aucun secret longue durée stocké, pas de fuite possible)**

### 5. Checklist Standards Équipe (20 min)

Parcourez cette checklist en groupe pour valider que le lab respecte les bonnes pratiques MLOps.

**Infrastructure**
- [ ] Les ressources du lab sont gérées principalement via Terraform
- [ ] Tags `environment`, `project`, `managed_by` sur toutes les ressources
- [ ] Budget alert configurée sur la subscription (si votre organisation le permet)

**CI/CD**
- [ ] 0 secret en clair dans le code
- [ ] Quality gate `accuracy >= 0.90` appliquée dans la CI
- [ ] Approbation manuelle requise pour le déploiement `prod`

**ML**
- [ ] Les runs AML journalisent bien des métriques (MLflow)
- [ ] Le modèle `iris-classifier` est visible dans le workspace AML après exécution du workflow `CD — Deploy AML Managed Endpoint`
- [ ] Le déploiement AKS et le Managed Endpoint AML sont compris comme deux chemins distincts
- [ ] Drift et télémétrie vérifiés sur l'environnement `dev`

**Sécurité**
- [ ] OIDC pour l'authentification GitHub → Azure (pas de secret SP)
- [ ] Pas de `Contributor` au scope subscription pour le pipeline (scope RG uniquement)
- [ ] Secrets stockés dans Key Vault
- [ ] RBAC minimal appliqué (principe du moindre privilège)

## Checkpoint Partie 5
- [ ] RBAC configuré via le script (ou lu et compris)
- [ ] Secret écrit et relu depuis Key Vault
- [ ] Checklist complétée et discutée en groupe
