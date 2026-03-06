# PRD — Repo de Lab MLOps/DevOps Azure
**Spécification complète pour Claude Code Haiku**
Version 1.1 — Mars 2026 | Formation MLOps/DevOps Azure 5 jours

---

## ⚠️ AMENDEMENTS v1.1 — LIRE EN PREMIER

> Ces amendements **remplacent** les sections concernées du document original. En cas de conflit entre un amendement et le reste du doc, **l'amendement prime**.

### Amendement 1 — IaC : Bicep pour le lab J2, Terraform en théorie

**Ce qui change :**
- `infrastructure/` contient désormais **Bicep** (pas Terraform) pour les fichiers de déploiement du lab pratique
- Terraform reste présent dans le repo uniquement comme **référence de lecture** (`infrastructure/terraform-reference/`) — les stagiaires lisent le code en J3, pas de `terraform apply`
- Le lab pratique J2 utilise `az deployment group create` avec des fichiers `.bicep`

**Pourquoi :** Bicep = pas de state file, pas de backend, une commande. Pour des stagiaires qui découvrent l'IaC, c'est 30 min de friction en moins. Terraform est montré pour sa valeur industrielle multi-cloud, sans lab complet.

**Ressources Bicep à créer (remplacent les modules Terraform) :**
- `infrastructure/bicep/main.bicep` — orchestrateur
- `infrastructure/bicep/modules/aml-workspace.bicep`
- `infrastructure/bicep/modules/container-registry.bicep`
- `infrastructure/bicep/modules/key-vault.bicep`
- `infrastructure/bicep/modules/storage-account.bicep`
- `infrastructure/bicep/modules/application-insights.bicep`
- `infrastructure/bicep/modules/aks.bicep`
- `infrastructure/bicep/parameters/dev.bicepparam`
- `infrastructure/bicep/parameters/prod.bicepparam`
- `infrastructure/terraform-reference/` — copie simplifiée du Terraform original (lecture seule, pas exécuté en lab)

**Commande de déploiement dev (remplace `terraform apply`) :**
```bash
az deployment group create \
  --resource-group rg-mlopslab-dev \
  --template-file infrastructure/bicep/main.bicep \
  --parameters infrastructure/bicep/parameters/dev.bicepparam
```

---

### Amendement 2 — CI/CD : ADO en théorie J3, GitHub Actions pour le lab

**Ce qui change :**
- Le repo ne contient **pas** de pipeline Azure DevOps (pas de `azure-pipelines.yml`)
- `lab/jour3.md` inclut une **section théorie** avec comparaison YAML ADO vs GitHub Actions (30 min)
- Le lab pratique J3 après-midi reste GitHub Actions uniquement

**Pourquoi :** Le programme liste "Azure Pipelines, GitHub Actions" comme outils à connaître (J3 matin). La session pratique ne précise pas l'outil. GitHub Actions est dans le repo, visible, modifiable sans portail supplémentaire — meilleur pour l'atelier.

**Ce qu'il faut ajouter dans `lab/jour3.md` :** une section "Théorie — ADO vs GitHub Actions" avec le tableau comparatif YAML (voir section 5.12 mise à jour ci-dessous).

---

### Amendement 3 — Lab 0 ajouté (setup OIDC + prérequis)

**Ce qui change :**
- Ajouter `lab/lab0-setup.md` — fichier de setup complet à faire **avant J1**
- Ce fichier couvre : accès Azure, App Registration, OIDC/Federated Credentials, GitHub Secrets, vérifications
- La section 2 du PRD (Actions Manuelles) est remplacée par ce Lab 0 détaillé

**Pourquoi :** OIDC n'est pas trivial pour des débutants. Les stagiaires doivent le faire eux-mêmes (c'est une compétence MLOps réelle). Il faut un guide pas-à-pas avec captures d'écran mentionnées et commandes de vérification.

---

## 0. Comment utiliser ce document (instructions pour Claude Code)

1. Lire les **amendements ci-dessus en premier** — ils remplacent certaines sections.
2. Lire le document **entièrement** avant de créer le moindre fichier.
3. Exécuter les phases dans l'ordre strict défini en section 8.
4. Ne jamais dévier des décisions de la section 1 (sauf amendements).
5. Terminer par les vérifications de la section 7.

---

## 1. Contexte & Décisions Figées

Formation MLOps/DevOps Azure — 5 jours (60% pratique). Cas fil rouge : déploiement d'un modèle de classification Iris de bout en bout sur Azure, avec CI/CD GitHub Actions, monitoring MLflow + Azure Monitor, gouvernance RBAC + Key Vault.

| Paramètre | Valeur retenue |
|-----------|----------------|
| Repo source | Fork de `Azure/mlops-project-template` via "Use this template" |
| Cloud | Microsoft Azure |
| ML Platform | Azure Machine Learning — CLI v2 / SDK v2 (`azure-ai-ml`) |
| IaC | **Bicep** pour le lab pratique J2 — Terraform en lecture seule (référence) |
| CI/CD | **GitHub Actions** pour le lab — Azure DevOps présenté en théorie J3 matin |
| Environnements | `dev` + `prod` (2 workspaces AML + 2 clusters AKS distincts) |
| Cas ML | Classification Iris (sklearn built-in, **0 dataset externe**) |
| Déploiement | **AKS** (managed online endpoint AML documenté en backup) |
| Auth GitHub→Azure | **OIDC / Federated Identity** — AUCUN secret Service Principal |
| Python | 3.10 — `azure-ai-ml>=1.12.0`, `scikit-learn>=1.3.0`, `MLflow>=2.9.0` |
| Tracking | MLflow intégré AML (`mlflow.autolog` + AML workspace) |
| Secrets | Azure Key Vault + GitHub Encrypted Secrets |

---

## 2. Actions Manuelles AVANT Claude Code + Contenu de lab/lab0-setup.md

> Claude Code doit créer le fichier `lab/lab0-setup.md` avec exactement le contenu de la section 2.2 ci-dessous. C'est le guide que les stagiaires suivent avant J1.

### 2.1 Ce que TU fais (formateur) pour préparer le repo



> ⚠️ Ces étapes nécessitent un navigateur et un compte GitHub. Claude Code ne peut pas les faire. Les exécuter dans l'ordre avant d'ouvrir le repo dans Claude Code.

### Étape 1 — Créer le repo depuis le template

1. Aller sur https://github.com/Azure/mlops-project-template
2. Cliquer **"Use this template"** > **"Create a new repository"**
3. Nom : `mlops-azure-lab` (ou autre)
4. Visibilité : Private
5. Cliquer "Create repository" — **NE PAS forker, utiliser "Use this template"**

### Étape 2 — Cloner localement

```bash
git clone https://github.com/TON_USERNAME/mlops-azure-lab.git
cd mlops-azure-lab
```

### Étape 3 — Configurer OIDC GitHub → Azure

Sur Azure Portal, créer/utiliser un App Registration puis configurer 3 Federated Credentials :
- Entity type : Environment → valeur `dev`
- Entity type : Environment → valeur `production`
- Entity type : Branch → valeur `main`

```bash
# Conserver ces valeurs pour les GitHub Secrets
AZURE_CLIENT_ID=<app-registration-client-id>
AZURE_TENANT_ID=<ton-tenant-id>
AZURE_SUBSCRIPTION_ID=<ton-subscription-id>
```

### Étape 4 — GitHub Secrets & Environments

**Settings > Secrets and variables > Actions > Repository secrets :**

| Secret Name | Valeur |
|-------------|--------|
| `AZURE_CLIENT_ID` | App Registration Client ID |
| `AZURE_TENANT_ID` | Azure Tenant ID |
| `AZURE_SUBSCRIPTION_ID` | Azure Subscription ID |
| `AML_WORKSPACE_DEV` | `aml-mlopslab-dev` |
| `AML_WORKSPACE_PROD` | `aml-mlopslab-prod` |
| `AML_RESOURCE_GROUP_DEV` | `rg-mlopslab-dev` |
| `AML_RESOURCE_GROUP_PROD` | `rg-mlopslab-prod` |
| `AKS_CLUSTER_DEV` | `aks-mlopslab-dev` |
| `AKS_CLUSTER_PROD` | `aks-mlopslab-prod` |

**Settings > Environments :**
- `dev` : aucune protection
- `production` : Required reviewers → ajouter ton GitHub username

### Étape 5 — Donner l'accès à Claude Code

Ouvrir le dossier `mlops-azure-lab` dans Cowork. Claude Code prend le relai à partir de là.

---

### 2.2 Contenu exact de lab/lab0-setup.md (guide stagiaires)

> Claude Code : créer ce fichier à `lab/lab0-setup.md` avec exactement ce contenu.

````markdown
# Lab 0 — Setup de l'environnement (à faire AVANT le Jour 1)

Ce lab 0 prend environ 45 minutes. À faire seul avant la première session.
Si tu bloques sur une étape, note l'erreur exacte et apporte-la en J1.

## Ce que tu vas configurer
1. Accès Azure + outils locaux
2. App Registration Azure (l'identité de ton pipeline)
3. OIDC / Federated Credentials (auth sans mot de passe entre GitHub et Azure)
4. GitHub Secrets et Environments
5. Vérification finale

---

## Étape 1 — Vérifier ton accès Azure et installer les outils

```bash
# Connexion Azure
az login
# Lister tes subscriptions et noter le bon ID
az account list --output table
az account set --subscription "NOM_OU_ID_DU_SUBSCRIPTION"
# Vérifier
az account show --query "{name:name, id:id, state:state}"
# → state doit être "Enabled"

# Installer l'extension AML CLI v2
az extension add -n ml --yes
az ml --version    # doit afficher une version

# Cloner le repo
git clone https://github.com/TON_ORG/mlops-azure-lab.git
cd mlops-azure-lab
pip install -r requirements.txt
```

---

## Étape 2 — Créer l'App Registration Azure

> **C'est quoi ?** Une App Registration est une identité dans Microsoft Entra ID (anciennement
> Azure Active Directory). Elle représente ton pipeline GitHub Actions auprès d'Azure.
> Au lieu de stocker un mot de passe quelque part, tu crées cette identité et tu lui donnes
> des permissions sur Azure. Le mot de passe n'existe jamais — c'est le principe d'OIDC.

### 2a. Créer l'App Registration

1. Aller sur https://portal.azure.com
2. Barre de recherche en haut → taper **"Microsoft Entra ID"** → cliquer le résultat
3. Menu gauche → **App registrations** → bouton **New registration**
4. Remplir :
   - **Name** : `github-mlops-lab`
   - **Supported account types** : *Accounts in this organizational directory only*
   - **Redirect URI** : laisser vide
5. Cliquer **Register**

### 2b. Noter les 3 identifiants importants

Sur la page qui s'affiche après création, noter :

| Champ | Où le trouver | Variable GitHub Secret |
|-------|---------------|------------------------|
| Application (client) ID | En haut de la page | `AZURE_CLIENT_ID` |
| Directory (tenant) ID | En haut de la page | `AZURE_TENANT_ID` |
| Subscription ID | Via CLI (voir commande ci-dessous) | `AZURE_SUBSCRIPTION_ID` |

```bash
az account show --query id -o tsv
# → copier cette valeur, c'est ton AZURE_SUBSCRIPTION_ID
```

### 2c. Donner les permissions Azure à cette identité

1. Dans le portail Azure → **Subscriptions** → cliquer sur ton subscription
2. Menu gauche → **Access control (IAM)** → **Add role assignment**
3. Onglet **Role** → chercher **Contributor** → sélectionner → **Next**
4. Onglet **Members** → *Assign access to: User, group, or service principal*
5. **Select members** → chercher `github-mlops-lab` → sélectionner → **Next** → **Review + assign**

> ⚠️ Note : Contributor donne accès large. En production réelle on utilise des rôles plus fins
> (AzureML Data Scientist, AKS Cluster User...). C'est ce qu'on verra en J5.

---

## Étape 3 — Configurer OIDC (Federated Credentials)

> **Pourquoi OIDC et pas un secret ?**
>
> Sans OIDC, il faudrait créer un secret (mot de passe) sur l'App Registration et le stocker
> dans GitHub. Problème : ce secret est valable longtemps, peut fuiter dans les logs, et doit
> être renouvelé manuellement.
>
> Avec OIDC (Workload Identity Federation), le flux est :
> ```
> GitHub Actions démarre un job
>         │
>         ▼
> GitHub génère un token temporaire signé (~5 min) :
> "Je suis le workflow du repo TON_ORG/mlops-azure-lab, environment=dev"
>         │
>         ▼
> Azure vérifie la signature + vérifie que le repo/env correspond
> aux Federated Credentials configurés sur l'App Registration
>         │
>         ▼
> Azure délivre un token d'accès Azure (valable ~1h)
> → az login réussit, aucun secret stocké nulle part
> ```
>
> C'est le standard industrie depuis 2022. Zéro secret, zéro rotation manuelle.

### 3a. Accéder aux Federated Credentials

Dans l'App Registration `github-mlops-lab` :
Menu gauche → **Certificates & secrets** → onglet **Federated credentials** → **Add credential**

### 3b. Créer les 3 credentials (un par un)

**Credential 1 — CI sur branche main :**

| Champ | Valeur |
|-------|--------|
| Federated credential scenario | *GitHub Actions deploying Azure resources* |
| Organization | `TON_USERNAME_OU_ORG_GITHUB` |
| Repository | `mlops-azure-lab` |
| Entity type | **Branch** |
| Based on selection | `main` |
| Name | `github-branch-main` |

→ Cliquer **Add**

**Credential 2 — CD environment dev :**

| Champ | Valeur |
|-------|--------|
| Federated credential scenario | *GitHub Actions deploying Azure resources* |
| Organization | `TON_USERNAME_OU_ORG_GITHUB` |
| Repository | `mlops-azure-lab` |
| Entity type | **Environment** |
| Based on selection | `dev` |
| Name | `github-env-dev` |

→ Cliquer **Add**

**Credential 3 — CD environment production :**

| Champ | Valeur |
|-------|--------|
| Federated credential scenario | *GitHub Actions deploying Azure resources* |
| Organization | `TON_USERNAME_OU_ORG_GITHUB` |
| Repository | `mlops-azure-lab` |
| Entity type | **Environment** |
| Based on selection | `production` |
| Name | `github-env-production` |

→ Cliquer **Add**

Tu dois avoir **3 Federated Credentials** listés dans l'onglet.

> **Pourquoi 3 et pas 1 ?** Azure vérifie le token OIDC avec précision.
> Un token émis pour `branch=main` ne peut pas être utilisé pour `environment=production`.
> Chaque credential autorise un contexte précis — c'est le principe du moindre privilège.

---

## Étape 4 — Configurer les GitHub Secrets et Environments

### 4a. Ajouter les 9 Repository Secrets

Dans ton repo GitHub → **Settings** → **Secrets and variables** → **Actions** → **New repository secret**

Ajouter ces secrets un par un :

| Secret Name | Valeur |
|-------------|--------|
| `AZURE_CLIENT_ID` | Application (client) ID (étape 2b) |
| `AZURE_TENANT_ID` | Directory (tenant) ID (étape 2b) |
| `AZURE_SUBSCRIPTION_ID` | Subscription ID (étape 2b) |
| `AML_WORKSPACE_DEV` | `aml-mlopslab-dev` |
| `AML_WORKSPACE_PROD` | `aml-mlopslab-prod` |
| `AML_RESOURCE_GROUP_DEV` | `rg-mlopslab-dev` |
| `AML_RESOURCE_GROUP_PROD` | `rg-mlopslab-prod` |
| `AKS_CLUSTER_DEV` | `aks-mlopslab-dev` |
| `AKS_CLUSTER_PROD` | `aks-mlopslab-prod` |

> Les 4 derniers contiennent les noms des ressources Azure qui seront créées en J2.
> Tu les rentres maintenant pour ne pas avoir à y revenir.

### 4b. Créer les 2 GitHub Environments

Dans ton repo GitHub → **Settings** → **Environments** → **New environment**

**Environment 1 :**
- Name : `dev`
- Pas de protection → cliquer **Configure environment** sans rien modifier

**Environment 2 :**
- Name : `production`
- Cocher **Required reviewers** → ajouter ton GitHub username
- Cliquer **Save protection rules**

> Le workflow `cd-deploy-prod.yml` utilise `environment: production`. GitHub bloquera
> l'exécution jusqu'à ce qu'un reviewer approuve. C'est le quality gate prod.

---

## Étape 5 — Vérification finale

```bash
# Test 1 : Azure CLI connecté
az account show --query "{name:name, state:state}" -o table
# → state = Enabled

# Test 2 : App Registration visible
az ad app list --display-name "github-mlops-lab" --query "[].{name:displayName, id:appId}" -o table
# → 1 ligne affichée

# Test 3 : Role assignment présent
az role assignment list \
  --assignee $(az ad app list --display-name "github-mlops-lab" --query "[0].appId" -o tsv) \
  --query "[].{role:roleDefinitionName}" -o table
# → Contributor affiché

# Test 4 : Pipeline Python local
python mlops/data-science/src/prep.py --output_dir /tmp/iris-check
python mlops/data-science/src/train.py --data_dir /tmp/iris-check --model_dir /tmp/model-check
python mlops/data-science/src/evaluate.py --data_dir /tmp/iris-check --model_dir /tmp/model-check
pytest tests/ -v
# → 3 tests PASSED

# Test 5 : GitHub Secrets (vérification visuelle seulement)
# GitHub > Settings > Secrets > vérifier que les 9 secrets apparaissent dans la liste
# Les valeurs ne sont jamais affichées — c'est normal
```

Si tous les tests passent → prêt pour J1.

---

## Tableau de dépannage

| Symptôme | Cause probable | Solution |
|----------|----------------|----------|
| `az login` échoue / pas de subscription | Compte sans accès | Contacter le formateur |
| App Registration créée mais rôle refusé | Propagation IAM lente | Attendre 2-3 min, réessayer |
| GitHub Actions : `AADSTS70021: No matching federated identity record found` | Federated Credential mal configuré (mauvais repo, org, ou entity type) | Vérifier les 3 credentials : org/repo exact, entity type exact |
| GitHub Actions : `ClientSecretCredentialAuthenticationError` | AZURE_CLIENT_ID ou AZURE_TENANT_ID incorrect | Revérifier les secrets GitHub vs l'App Registration |
| GitHub Actions : `AuthorizationFailed` | Role Contributor pas assigné | Vérifier IAM sur le subscription |
| `pytest` : `ModuleNotFoundError` | `pip install` pas fait | `pip install -r requirements.txt` |
````

---

## 3. Structure Cible du Repo

> ⚠️ Le repo de départ contient du bruit (cv/, nlp/, bicep/, workflows ADO...). Claude Code doit d'abord **nettoyer** (section 4), **puis** créer cette structure.

```
mlops-azure-lab/
├── .github/
│   └── workflows/
│       ├── ci-train.yml                   ← CI: lint + tests + AML pipeline
│       ├── cd-deploy-dev.yml              ← CD: build ACR + deploy AKS dev
│       └── cd-deploy-prod.yml             ← CD: deploy prod (approbation manuelle)
├── infrastructure/
│   ├── bicep/                            ← LAB PRATIQUE J2
│   │   ├── main.bicep
│   │   ├── modules/
│   │   │   ├── aml-workspace.bicep
│   │   │   ├── container-registry.bicep
│   │   │   ├── key-vault.bicep
│   │   │   ├── storage-account.bicep
│   │   │   ├── application-insights.bicep
│   │   │   └── aks.bicep
│   │   └── parameters/
│   │       ├── dev.bicepparam
│   │       └── prod.bicepparam
│   └── terraform-reference/              ← LECTURE SEULE J2/J3 (pas exécuté en lab)
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── README.md                     ← explique "référence uniquement"
├── mlops/
│   ├── data-science/
│   │   ├── environment/
│   │   │   └── train-env.yml             ← AML environment definition
│   │   ├── src/
│   │   │   ├── prep.py
│   │   │   ├── train.py
│   │   │   ├── evaluate.py
│   │   │   ├── register.py
│   │   │   └── score.py
│   │   ├── Dockerfile
│   │   └── server.py                     ← Flask wrapper pour AKS
│   └── pipelines/
│       ├── pipeline.yml                  ← AML pipeline (prep+train+evaluate)
│       ├── online-endpoint.yml           ← AML managed endpoint (backup)
│       ├── online-deployment.yml
│       └── aks-deployment.yml            ← Kubernetes manifest
├── lab/
│   ├── lab0-setup.md                     ← Setup OIDC + prérequis (avant J1)
│   ├── jour1.md
│   ├── jour2.md
│   ├── jour3.md
│   ├── jour4.md
│   └── jour5.md
├── scripts/
│   ├── generate-drift.py                 ← Simulation drift J4
│   └── setup-rbac.sh                     ← Configuration RBAC J5
├── tests/
│   ├── test_prep.py
│   └── test_train.py
├── .gitignore
├── README.md
└── requirements.txt
```

---

## 4. Phase 1 — Nettoyage (Supprimer en premier)

### Dossiers entiers à supprimer
```
cv/
nlp/
classical/python-sdk-v1/
classical/python-sdk-v2/
classical/rai-aml-cli-v2/
infrastructure/bicep/
.devcontainer/
```

### Fichiers racine à supprimer
```
config-infra-dev.yml
config-infra-prod.yml
environment.yml
requirements.txt          (sera recréé avec le bon contenu)
```

### Dans .github/workflows/
Supprimer **tous** les fichiers `.yml` existants. Ils font des appels à `mlops-templates` comme dépendance externe — incompatible avec l'approche pédagogique. Les 3 nouveaux workflows seront entièrement inlinés.

### Répertoire à migrer
`classical/aml-cli-v2/` → migrer son contenu vers `mlops/` selon l'arborescence cible. Supprimer `classical/` après migration.

---

## 5. Contenu Exact des Fichiers à Créer

### 5.1 README.md

```markdown
# MLOps Azure Lab — Formation 5 jours

Cas fil rouge : classification Iris déployée sur Azure ML + AKS via CI/CD GitHub Actions.

## Stack technique
- **Cloud** : Microsoft Azure
- **ML Platform** : Azure Machine Learning (CLI v2 / SDK v2)
- **IaC** : Terraform (>= 1.5, provider azurerm ~> 3.80)
- **CI/CD** : GitHub Actions (OIDC auth)
- **Container** : Azure Container Registry → AKS
- **Monitoring** : MLflow + Azure Monitor + Application Insights
- **Secrets** : Azure Key Vault

## Environnements
| Env  | Resource Group       | AML Workspace       | AKS Cluster         |
|------|----------------------|---------------------|---------------------|
| dev  | rg-mlopslab-dev      | aml-mlopslab-dev    | aks-mlopslab-dev    |
| prod | rg-mlopslab-prod     | aml-mlopslab-prod   | aks-mlopslab-prod   |

## Structure
```
infrastructure/    → Terraform (deploy dev + prod)
mlops/             → Code ML + pipelines AML + Dockerfile
.github/workflows/ → CI/CD GitHub Actions (inlinés, sans dépendance externe)
lab/               → Instructions pratiques J1 à J5
scripts/           → Utilitaires (drift, RBAC)
tests/             → Tests unitaires Python
```

## Démarrage rapide
Voir `lab/jour1.md` pour les prérequis et la mise en place initiale.
```

---

### 5.2 .gitignore

```
# Python
__pycache__/
*.py[cod]
*.egg-info/
.venv/
venv/
.env

# Terraform
.terraform/
*.tfstate
*.tfstate.backup
*.tfstate.lock.info
.terraform.lock.hcl
*.tfvars.local

# Azure ML
.azureml/
outputs/
logs/
mlruns/

# Misc
.DS_Store
*.log
*.tmp
```

---

### 5.3 requirements.txt

```
azure-ai-ml>=1.12.0
azure-identity>=1.15.0
mlflow>=2.9.0
scikit-learn>=1.3.0
pandas>=2.0.0
numpy>=1.24.0
joblib>=1.3.0
flask>=3.0.0
gunicorn>=21.0.0
requests>=2.31.0
pytest>=7.4.0
black>=23.0.0
flake8>=6.0.0
```

---

### 5.4 Bicep — Lab pratique J2

> ⚠️ Ces fichiers sont utilisés en lab J2. Commande de déploiement dev :
> ```bash
> az deployment group create \
>   --resource-group rg-mlopslab-dev \
>   --template-file infrastructure/bicep/main.bicep \
>   --parameters infrastructure/bicep/parameters/dev.bicepparam
> ```

#### infrastructure/bicep/main.bicep

```bicep
// ============================================================
// main.bicep — Orchestrateur MLOps Lab
// Déploie : Storage, Key Vault, ACR, App Insights, AML, AKS
// ============================================================

@description('Environnement de déploiement')
@allowed(['dev', 'prod'])
param environment string

@description('Région Azure')
param location string = resourceGroup().location

@description('Nom de base du projet')
param projectName string = 'mlopslab'

@description('Nombre de nœuds AKS')
param aksNodeCount int = 1

@description('Taille des VMs AKS')
param aksVmSize string = 'Standard_D2s_v3'

var baseName = '${projectName}-${environment}'
var commonTags = {
  environment: environment
  project: projectName
  managedBy: 'bicep'
}

// ── Storage Account ──────────────────────────────────────────
module storage 'modules/storage-account.bicep' = {
  name: 'deploy-storage'
  params: {
    name: 'sa${replace(baseName, '-', '')}ml'
    location: location
    tags: commonTags
  }
}

// ── Key Vault ─────────────────────────────────────────────────
module keyVault 'modules/key-vault.bicep' = {
  name: 'deploy-keyvault'
  params: {
    name: 'kv-${baseName}'
    location: location
    tags: commonTags
  }
}

// ── Container Registry ────────────────────────────────────────
module acr 'modules/container-registry.bicep' = {
  name: 'deploy-acr'
  params: {
    name: 'acr${replace(baseName, '-', '')}'
    location: location
    sku: environment == 'prod' ? 'Premium' : 'Basic'
    tags: commonTags
  }
}

// ── Application Insights ──────────────────────────────────────
module appInsights 'modules/application-insights.bicep' = {
  name: 'deploy-appinsights'
  params: {
    name: 'appi-${baseName}'
    location: location
    tags: commonTags
  }
}

// ── AML Workspace ─────────────────────────────────────────────
module amlWorkspace 'modules/aml-workspace.bicep' = {
  name: 'deploy-aml'
  params: {
    name: 'aml-${baseName}'
    location: location
    storageAccountId: storage.outputs.id
    keyVaultId: keyVault.outputs.id
    containerRegistryId: acr.outputs.id
    applicationInsightsId: appInsights.outputs.id
    tags: commonTags
  }
}

// ── AKS Cluster ───────────────────────────────────────────────
module aks 'modules/aks.bicep' = {
  name: 'deploy-aks'
  params: {
    name: 'aks-${baseName}'
    location: location
    nodeCount: aksNodeCount
    vmSize: aksVmSize
    acrId: acr.outputs.id
    tags: commonTags
  }
}

// ── Outputs ───────────────────────────────────────────────────
output resourceGroupName string = resourceGroup().name
output amlWorkspaceName string = amlWorkspace.outputs.name
output aksClusterName string = aks.outputs.name
output acrLoginServer string = acr.outputs.loginServer
output keyVaultUri string = keyVault.outputs.vaultUri
```

#### infrastructure/bicep/modules/storage-account.bicep

```bicep
param name string
param location string
param tags object = {}

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: name
  location: location
  tags: tags
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    supportsHttpsTrafficOnly: true
    minimumTlsVersion: 'TLS1_2'
  }
}

output id string = storageAccount.id
output name string = storageAccount.name
```

#### infrastructure/bicep/modules/key-vault.bicep

```bicep
param name string
param location string
param tags object = {}

var tenantId = subscription().tenantId

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    tenantId: tenantId
    sku: {
      family: 'A'
      name: 'standard'
    }
    // RBAC model — pas d'access policies (recommandé Azure 2024+)
    enableRbacAuthorization: true
    softDeleteRetentionInDays: 7
    enablePurgeProtection: false  // false pour faciliter le cleanup en lab
  }
}

output id string = keyVault.id
output vaultUri string = keyVault.properties.vaultUri
output name string = keyVault.name
```

#### infrastructure/bicep/modules/container-registry.bicep

```bicep
param name string
param location string
param sku string = 'Basic'
param tags object = {}

resource acr 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: name
  location: location
  tags: tags
  sku: {
    name: sku
  }
  properties: {
    adminUserEnabled: false
  }
}

output id string = acr.id
output loginServer string = acr.properties.loginServer
output name string = acr.name
```

#### infrastructure/bicep/modules/application-insights.bicep

```bicep
param name string
param location string
param tags object = {}

// Log Analytics Workspace requis pour Application Insights workspace-based
resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: 'law-${name}'
  location: location
  tags: tags
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: 30
  }
}

resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: name
  location: location
  tags: tags
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsWorkspace.id
  }
}

output id string = appInsights.id
output instrumentationKey string = appInsights.properties.InstrumentationKey
output name string = appInsights.name
```

#### infrastructure/bicep/modules/aml-workspace.bicep

```bicep
param name string
param location string
param storageAccountId string
param keyVaultId string
param containerRegistryId string
param applicationInsightsId string
param tags object = {}

resource amlWorkspace 'Microsoft.MachineLearningServices/workspaces@2024-01-01-preview' = {
  name: name
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    storageAccount: storageAccountId
    keyVault: keyVaultId
    containerRegistry: containerRegistryId
    applicationInsights: applicationInsightsId
    publicNetworkAccess: 'Enabled'
    v1LegacyMode: false
  }
}

output id string = amlWorkspace.id
output name string = amlWorkspace.name
output principalId string = amlWorkspace.identity.principalId
```

#### infrastructure/bicep/modules/aks.bicep

```bicep
param name string
param location string
param nodeCount int = 1
param vmSize string = 'Standard_D2s_v3'
param acrId string
param tags object = {}

resource aksCluster 'Microsoft.ContainerService/managedClusters@2024-01-01' = {
  name: name
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    dnsPrefix: name
    agentPoolProfiles: [
      {
        name: 'default'
        count: nodeCount
        vmSize: vmSize
        mode: 'System'
        osType: 'Linux'
      }
    ]
    networkProfile: {
      networkPlugin: 'azure'
      loadBalancerSku: 'standard'
    }
  }
}

// AcrPull : autoriser AKS à puller depuis l'ACR
resource acrPullRole 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(aksCluster.id, acrId, 'AcrPull')
  scope: resourceGroup()
  properties: {
    // AcrPull role definition ID (constant Azure)
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '7f951dda-4ed3-4680-a7ca-43fe172d538d')
    principalId: aksCluster.properties.identityProfile.kubeletidentity.objectId
    principalType: 'ServicePrincipal'
  }
}

output id string = aksCluster.id
output name string = aksCluster.name
```

#### infrastructure/bicep/parameters/dev.bicepparam

```bicep
using '../main.bicep'

param environment = 'dev'
param location = 'westeurope'
param projectName = 'mlopslab'
param aksNodeCount = 1
param aksVmSize = 'Standard_D2s_v3'
```

#### infrastructure/bicep/parameters/prod.bicepparam

```bicep
using '../main.bicep'

param environment = 'prod'
param location = 'westeurope'
param projectName = 'mlopslab'
param aksNodeCount = 2
param aksVmSize = 'Standard_D4s_v3'
```

---

### 5.4b Terraform Reference — Lecture seule J2/J3

> ⚠️ **Ces fichiers ne sont PAS exécutés en lab.** Ils existent pour que les stagiaires voient comment la même infrastructure se décrit en Terraform (multi-cloud, state file, providers). Lire pendant J2/J3, discuter en théorie.

#### infrastructure/terraform-reference/README.md

```markdown
# Terraform Reference — Lecture seule

Ce dossier contient la version Terraform de l'infrastructure déployée en Bicep dans `../bicep/`.

**Ne pas exécuter en lab.** Objectif : comparer Bicep (Azure-native, pas de state) vs Terraform (multi-cloud, state file backend).

Points clés à retenir :
- Terraform nécessite un backend (état distant sur Azure Storage ou Terraform Cloud)
- `terraform init` doit être lancé avant tout apply
- Les providers (`hashicorp/azurerm`) s'installent localement dans `.terraform/`
- Les ressources sont identiques — seule la syntaxe HCL diffère du Bicep ARM

Commandes de référence (à ne pas exécuter en lab) :
```bash
terraform init -backend-config="..."
terraform plan -var-file="environments/dev.tfvars"
terraform apply -var-file="environments/dev.tfvars"
terraform destroy -var-file="environments/dev.tfvars"
```
```

#### infrastructure/terraform-reference/variables.tf

```hcl
variable "environment" {
  type        = string
  description = "Deployment environment"
  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "Must be 'dev' or 'prod'."
  }
}

variable "location" {
  type    = string
  default = "westeurope"
}

variable "project_name" {
  type    = string
  default = "mlopslab"
}

variable "aks_node_count" {
  type    = number
  default = 1
}

variable "aks_vm_size" {
  type    = string
  default = "Standard_D2s_v3"
}

variable "tags" {
  type    = map(string)
  default = {}
}
```

#### infrastructure/terraform-reference/main.tf

```hcl
# ============================================================
# RÉFÉRENCE UNIQUEMENT — pas de terraform apply en lab
# ============================================================

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.80"
    }
  }
  # Backend exemple (à configurer pour un vrai projet)
  # backend "azurerm" {
  #   resource_group_name  = "rg-tfstate"
  #   storage_account_name = "satfstatemlops"
  #   container_name       = "tfstate"
  #   key                  = "mlopslab.tfstate"
  # }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = false
      recover_soft_deleted_key_vaults = true
    }
  }
}

locals {
  base_name   = "${var.project_name}-${var.environment}"
  common_tags = merge(var.tags, {
    environment = var.environment
    project     = var.project_name
    managed_by  = "terraform"
  })
}

resource "azurerm_resource_group" "main" {
  name     = "rg-${local.base_name}"
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_storage_account" "main" {
  name                     = "sa${replace(local.base_name, "-", "")}ml"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = local.common_tags
}

resource "azurerm_key_vault" "main" {
  name                     = "kv-${local.base_name}"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = var.location
  tenant_id                = data.azurerm_client_config.current.tenant_id
  sku_name                 = "standard"
  enable_rbac_authorization = true
  tags                     = local.common_tags
}

data "azurerm_client_config" "current" {}

resource "azurerm_container_registry" "main" {
  name                = "acr${replace(local.base_name, "-", "")}"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  sku                 = var.environment == "prod" ? "Premium" : "Basic"
  admin_enabled       = false
  tags                = local.common_tags
}

resource "azurerm_log_analytics_workspace" "main" {
  name                = "law-mlopslab-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = local.common_tags
}

resource "azurerm_application_insights" "main" {
  name                = "appi-${local.base_name}"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  workspace_id        = azurerm_log_analytics_workspace.main.id
  application_type    = "web"
  tags                = local.common_tags
}

resource "azurerm_machine_learning_workspace" "main" {
  name                    = "aml-${local.base_name}"
  resource_group_name     = azurerm_resource_group.main.name
  location                = var.location
  storage_account_id      = azurerm_storage_account.main.id
  key_vault_id            = azurerm_key_vault.main.id
  container_registry_id   = azurerm_container_registry.main.id
  application_insights_id = azurerm_application_insights.main.id
  tags                    = local.common_tags
  identity { type = "SystemAssigned" }
}

resource "azurerm_kubernetes_cluster" "main" {
  name                = "aks-${local.base_name}"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  dns_prefix          = "aks-${local.base_name}"
  tags                = local.common_tags

  default_node_pool {
    name       = "default"
    node_count = var.aks_node_count
    vm_size    = var.aks_vm_size
  }
  identity { type = "SystemAssigned" }
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = azurerm_container_registry.main.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
}
```

#### infrastructure/terraform-reference/outputs.tf

```hcl
output "resource_group_name" { value = azurerm_resource_group.main.name }
output "aml_workspace_name"  { value = azurerm_machine_learning_workspace.main.name }
output "aks_cluster_name"    { value = azurerm_kubernetes_cluster.main.name }
output "acr_login_server"    { value = azurerm_container_registry.main.login_server }
output "key_vault_uri"       { value = azurerm_key_vault.main.vault_uri }
```

---

### 5.5 Code ML — mlops/data-science/src/

#### prep.py

```python
"""Data preparation: load Iris from sklearn, split 80/20, save as CSV."""
import argparse, os
import pandas as pd
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split

def main(args):
    iris = load_iris(as_frame=True)
    df = iris.frame
    df.columns = [c.replace(" (cm)", "").replace(" ", "_") for c in df.columns]
    X = df.drop("target", axis=1)
    y = df["target"]
    X_tr, X_te, y_tr, y_te = train_test_split(X, y, test_size=0.2, random_state=42, stratify=y)
    os.makedirs(args.output_dir, exist_ok=True)
    pd.concat([X_tr, y_tr], axis=1).to_csv(f"{args.output_dir}/train.csv", index=False)
    pd.concat([X_te, y_te], axis=1).to_csv(f"{args.output_dir}/test.csv",  index=False)
    print(f"Prep done — train: {len(X_tr)}, test: {len(X_te)}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--output_dir", default="data/processed")
    main(parser.parse_args())
```

#### train.py

```python
"""Train LogisticRegression on Iris. Log with MLflow autolog. Save model."""
import argparse, os
import mlflow, mlflow.sklearn
import pandas as pd
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score
import joblib

def main(args):
    mlflow.autolog()
    train_df = pd.read_csv(f"{args.data_dir}/train.csv")
    X, y = train_df.drop("target", axis=1), train_df["target"]

    with mlflow.start_run():
        model = LogisticRegression(max_iter=args.max_iter, random_state=42)
        model.fit(X, y)
        acc = accuracy_score(y, model.predict(X))
        mlflow.log_param("max_iter", args.max_iter)
        mlflow.log_metric("train_accuracy", acc)
        mlflow.sklearn.log_model(model, "model")

    os.makedirs(args.model_dir, exist_ok=True)
    joblib.dump(model, f"{args.model_dir}/model.joblib")
    print(f"Train accuracy: {acc:.4f} — model saved to {args.model_dir}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--data_dir",  default="data/processed")
    parser.add_argument("--model_dir", default="outputs/model")
    parser.add_argument("--max_iter",  type=int, default=200)
    main(parser.parse_args())
```

#### evaluate.py

```python
"""Evaluate model on test set. Exit code 1 if accuracy < threshold (CI quality gate)."""
import argparse, os, sys
import mlflow
import pandas as pd
from sklearn.metrics import accuracy_score, f1_score, classification_report
import joblib

def main(args):
    test_df = pd.read_csv(f"{args.data_dir}/test.csv")
    X, y = test_df.drop("target", axis=1), test_df["target"]
    model = joblib.load(f"{args.model_dir}/model.joblib")
    preds = model.predict(X)
    acc = accuracy_score(y, preds)
    f1  = f1_score(y, preds, average="weighted")

    with mlflow.start_run():
        mlflow.log_metric("test_accuracy", acc)
        mlflow.log_metric("test_f1_weighted", f1)

    print(classification_report(y, preds, target_names=["setosa", "versicolor", "virginica"]))
    print(f"Accuracy: {acc:.4f} | F1 (weighted): {f1:.4f} | Threshold: {args.min_accuracy}")

    if acc < args.min_accuracy:
        print(f"FAIL: {acc:.4f} < {args.min_accuracy}")
        sys.exit(1)
    print("PASS: model meets quality threshold")

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--data_dir",     default="data/processed")
    parser.add_argument("--model_dir",    default="outputs/model")
    parser.add_argument("--min_accuracy", type=float, default=0.90)
    main(parser.parse_args())
```

#### register.py

```python
"""Register the trained model in AML Model Registry."""
import argparse, os
from azure.ai.ml import MLClient
from azure.ai.ml.entities import Model
from azure.ai.ml.constants import AssetTypes
from azure.identity import DefaultAzureCredential

def main(args):
    client = MLClient(
        DefaultAzureCredential(),
        subscription_id=args.subscription_id,
        resource_group_name=args.resource_group,
        workspace_name=args.workspace,
    )
    model = Model(
        path=args.model_dir,
        type=AssetTypes.CUSTOM_MODEL,
        name="iris-classifier",
        description="LogisticRegression on Iris dataset",
        tags={"accuracy": args.accuracy, "framework": "scikit-learn", "env": args.environment},
    )
    registered = client.models.create_or_update(model)
    print(f"Registered: {registered.name} v{registered.version}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--model_dir",       required=True)
    parser.add_argument("--accuracy",        default="unknown")
    parser.add_argument("--environment",     default="dev")
    parser.add_argument("--subscription_id", default=os.environ.get("AZURE_SUBSCRIPTION_ID", ""))
    parser.add_argument("--resource_group",  default=os.environ.get("AML_RESOURCE_GROUP", ""))
    parser.add_argument("--workspace",       default=os.environ.get("AML_WORKSPACE", ""))
    main(parser.parse_args())
```

#### score.py — script d'inférence (AML + AKS)

```python
"""Inference script for AML online endpoint and AKS Flask server."""
import json, os
import numpy as np
import joblib

MODEL   = None
CLASSES = ["setosa", "versicolor", "virginica"]

def init():
    global MODEL
    model_path = os.path.join(os.environ.get("AZUREML_MODEL_DIR", "/app/model"), "model.joblib")
    MODEL = joblib.load(model_path)
    print(f"Model loaded from {model_path}")

def run(raw_data: str) -> str:
    data    = json.loads(raw_data)
    features = np.array(data["data"])
    preds   = MODEL.predict(features).tolist()
    probas  = MODEL.predict_proba(features).tolist()
    result  = [
        {"prediction": CLASSES[p], "class_id": p, "probabilities": prob}
        for p, prob in zip(preds, probas)
    ]
    return json.dumps(result)
```

---

### 5.6 mlops/data-science/server.py — Flask wrapper pour AKS

```python
"""Minimal Flask server wrapping score.py for AKS deployment."""
from flask import Flask, request
import sys; sys.path.insert(0, "src")
from score import init, run

app = Flask(__name__)
init()  # Load model at startup

@app.route("/score", methods=["POST"])
def score():
    return run(request.get_data(as_text=True)), 200, {"Content-Type": "application/json"}

@app.route("/health", methods=["GET"])
def health():
    return {"status": "ok"}, 200
```

---

### 5.7 mlops/data-science/Dockerfile

```dockerfile
FROM python:3.10-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt gunicorn flask
COPY src/ ./src/
COPY ../../outputs/model/ ./model/
COPY server.py .
ENV AZUREML_MODEL_DIR=/app/model
ENV PORT=5001
EXPOSE 5001
CMD ["gunicorn", "-w", "2", "-b", "0.0.0.0:5001", "server:app"]
```

> **Note** : En production réelle, le modèle serait téléchargé depuis AML Registry au démarrage. Pour le lab, il est embarqué dans l'image pour simplifier.

---

### 5.8 AML YAML — mlops/data-science/environment/ et mlops/pipelines/

#### mlops/data-science/environment/train-env.yml

```yaml
$schema: https://azuremlschemas.azureedge.net/latest/environment.schema.json
name: iris-train-env
version: 1
description: Training environment for Iris classifier
image: mcr.microsoft.com/azureml/openmpi4.1.0-ubuntu20.04:latest
conda_file:
  name: iris-train
  channels: [defaults, conda-forge]
  dependencies:
    - python=3.10
    - pip
    - pip:
      - azure-ai-ml>=1.12.0
      - mlflow>=2.9.0
      - scikit-learn>=1.3.0
      - pandas>=2.0.0
      - numpy>=1.24.0
      - joblib>=1.3.0
```

#### mlops/pipelines/pipeline.yml

```yaml
$schema: https://azuremlschemas.azureedge.net/latest/pipelineJob.schema.json
type: pipeline
experiment_name: iris-classification
description: End-to-end Iris classification pipeline

settings:
  default_compute: azureml:cpu-cluster
  default_datastore: azureml:workspaceblobstore

jobs:
  prep_data:
    type: command
    code: ../data-science/src
    command: python prep.py --output_dir ${{outputs.processed_data}}
    environment: azureml:iris-train-env@latest
    outputs:
      processed_data:
        type: uri_folder

  train_model:
    type: command
    code: ../data-science/src
    command: python train.py --data_dir ${{inputs.data_dir}} --model_dir ${{outputs.model_dir}} --max_iter 200
    environment: azureml:iris-train-env@latest
    inputs:
      data_dir: ${{parent.jobs.prep_data.outputs.processed_data}}
    outputs:
      model_dir:
        type: uri_folder

  evaluate_model:
    type: command
    code: ../data-science/src
    command: python evaluate.py --data_dir ${{inputs.data_dir}} --model_dir ${{inputs.model_dir}} --min_accuracy 0.90
    environment: azureml:iris-train-env@latest
    inputs:
      data_dir: ${{parent.jobs.prep_data.outputs.processed_data}}
      model_dir: ${{parent.jobs.train_model.outputs.model_dir}}
```

#### mlops/pipelines/online-endpoint.yml (backup AML managed endpoint)

```yaml
$schema: https://azuremlschemas.azureedge.net/latest/managedOnlineEndpoint.schema.json
name: iris-endpoint
description: AML managed online endpoint for Iris classifier (backup — prefer AKS)
auth_mode: key
tags:
  project: mlopslab
```

#### mlops/pipelines/online-deployment.yml (backup AML)

```yaml
$schema: https://azuremlschemas.azureedge.net/latest/managedOnlineDeployment.schema.json
name: iris-deployment
endpoint_name: iris-endpoint
model: azureml:iris-classifier@latest
code_configuration:
  code: ../../data-science/src
  scoring_script: score.py
environment: azureml:iris-train-env@latest
instance_type: Standard_DS2_v2
instance_count: 1
```

#### mlops/pipelines/aks-deployment.yml

> **Important** : Les 3 placeholders `ACR_LOGIN_SERVER_PLACEHOLDER`, `IMAGE_TAG_PLACEHOLDER`, `ENVIRONMENT_PLACEHOLDER` sont remplacés par `sed` dans les workflows CD. Ne pas les modifier.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: iris-classifier
  labels:
    app: iris-classifier
    environment: ENVIRONMENT_PLACEHOLDER
spec:
  replicas: 2
  selector:
    matchLabels:
      app: iris-classifier
  template:
    metadata:
      labels:
        app: iris-classifier
    spec:
      containers:
      - name: iris-classifier
        image: ACR_LOGIN_SERVER_PLACEHOLDER/iris-classifier:IMAGE_TAG_PLACEHOLDER
        ports:
        - containerPort: 5001
        env:
        - name: AZUREML_MODEL_DIR
          value: /app/model
        resources:
          requests: { memory: "256Mi", cpu: "250m" }
          limits:   { memory: "512Mi", cpu: "500m" }
        livenessProbe:
          httpGet: { path: /health, port: 5001 }
          initialDelaySeconds: 10
---
apiVersion: v1
kind: Service
metadata:
  name: iris-classifier-svc
spec:
  type: LoadBalancer
  ports:
  - port: 80
    targetPort: 5001
  selector:
    app: iris-classifier
```

---

### 5.9 GitHub Actions Workflows

> ⚠️ **Règle absolue** : Ces workflows n'utilisent **aucune** dépendance vers `mlops-templates`. Tous les steps sont inlinés. Aucun `uses: Azure/mlops-templates/...` n'est acceptable.

#### .github/workflows/ci-train.yml

```yaml
name: CI — Lint + Tests + AML Training Pipeline

on:
  push:
    branches: [main, dev]
    paths: ['mlops/**', 'tests/**', 'requirements.txt']
  pull_request:
    branches: [main]

permissions:
  id-token: write
  contents: read

env:
  PYTHON_VERSION: "3.10"

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with: { python-version: "${{ env.PYTHON_VERSION }}" }
      - run: pip install black flake8
      - run: black --check mlops/ tests/
      - run: flake8 mlops/ tests/ --max-line-length=100

  unit-tests:
    runs-on: ubuntu-latest
    needs: lint
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with: { python-version: "${{ env.PYTHON_VERSION }}" }
      - run: pip install -r requirements.txt pytest
      - run: pytest tests/ -v --tb=short

  train-pipeline:
    runs-on: ubuntu-latest
    needs: unit-tests
    environment: dev
    steps:
      - uses: actions/checkout@v4

      - name: Azure Login (OIDC)
        uses: azure/login@v2
        with:
          client-id:       ${{ secrets.AZURE_CLIENT_ID }}
          tenant-id:       ${{ secrets.AZURE_TENANT_ID }}
          subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}

      - name: Install AML CLI v2
        run: az extension add -n ml --yes

      - name: Configure AML defaults
        run: |
          az configure --defaults \
            group=${{ secrets.AML_RESOURCE_GROUP_DEV }} \
            workspace=${{ secrets.AML_WORKSPACE_DEV }}

      - name: Create compute cluster if not exists
        run: |
          az ml compute create \
            --name cpu-cluster \
            --type amlcompute \
            --min-instances 0 \
            --max-instances 4 \
            --size Standard_DS3_v2 || true

      - name: Submit AML training pipeline
        id: submit
        run: |
          RUN_ID=$(az ml job create \
            --file mlops/pipelines/pipeline.yml \
            --query name -o tsv)
          echo "run_id=$RUN_ID" >> $GITHUB_OUTPUT

      - name: Wait for pipeline completion
        run: |
          az ml job stream --name ${{ steps.submit.outputs.run_id }}
          STATUS=$(az ml job show --name ${{ steps.submit.outputs.run_id }} --query status -o tsv)
          [ "$STATUS" = "Completed" ] || { echo "Pipeline failed: $STATUS"; exit 1; }
```

#### .github/workflows/cd-deploy-dev.yml

```yaml
name: CD — Deploy to Dev (ACR build + AKS deploy)

on:
  workflow_run:
    workflows: ["CI — Lint + Tests + AML Training Pipeline"]
    types: [completed]
    branches: [main, dev]
  workflow_dispatch:

permissions:
  id-token: write
  contents: read

env:
  IMAGE_TAG: ${{ github.sha }}

jobs:
  check-ci:
    if: ${{ github.event.workflow_run.conclusion == 'success' || github.event_name == 'workflow_dispatch' }}
    runs-on: ubuntu-latest
    steps:
      - run: echo "CI passed — starting CD"

  build-push:
    needs: check-ci
    runs-on: ubuntu-latest
    environment: dev
    outputs:
      acr_server: ${{ steps.acr.outputs.server }}
    steps:
      - uses: actions/checkout@v4

      - name: Azure Login (OIDC)
        uses: azure/login@v2
        with:
          client-id:       ${{ secrets.AZURE_CLIENT_ID }}
          tenant-id:       ${{ secrets.AZURE_TENANT_ID }}
          subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}

      - name: Get ACR login server
        id: acr
        run: |
          NAME=$(az acr list --resource-group ${{ secrets.AML_RESOURCE_GROUP_DEV }} --query "[0].name" -o tsv)
          SERVER=$(az acr show --name $NAME --query loginServer -o tsv)
          echo "server=$SERVER" >> $GITHUB_OUTPUT

      - name: Build and push to ACR
        run: |
          az acr build \
            --registry ${{ steps.acr.outputs.server }} \
            --image iris-classifier:${{ env.IMAGE_TAG }} \
            --file mlops/data-science/Dockerfile \
            mlops/data-science/

  deploy-aks:
    needs: build-push
    runs-on: ubuntu-latest
    environment: dev
    steps:
      - uses: actions/checkout@v4

      - name: Azure Login (OIDC)
        uses: azure/login@v2
        with:
          client-id:       ${{ secrets.AZURE_CLIENT_ID }}
          tenant-id:       ${{ secrets.AZURE_TENANT_ID }}
          subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}

      - name: Get AKS credentials (dev)
        run: |
          az aks get-credentials \
            --resource-group ${{ secrets.AML_RESOURCE_GROUP_DEV }} \
            --name ${{ secrets.AKS_CLUSTER_DEV }} \
            --overwrite-existing

      - name: Substitute placeholders in manifest
        run: |
          sed -i "s|ACR_LOGIN_SERVER_PLACEHOLDER|${{ needs.build-push.outputs.acr_server }}|g" mlops/pipelines/aks-deployment.yml
          sed -i "s|IMAGE_TAG_PLACEHOLDER|${{ env.IMAGE_TAG }}|g" mlops/pipelines/aks-deployment.yml
          sed -i "s|ENVIRONMENT_PLACEHOLDER|dev|g" mlops/pipelines/aks-deployment.yml

      - name: Apply manifest
        run: kubectl apply -f mlops/pipelines/aks-deployment.yml

      - name: Verify rollout
        run: |
          kubectl rollout status deployment/iris-classifier --timeout=300s
          kubectl get pods -l app=iris-classifier
          kubectl get svc iris-classifier-svc
```

#### .github/workflows/cd-deploy-prod.yml

```yaml
name: CD — Deploy to Prod (Manual Approval Required)

on:
  workflow_dispatch:
    inputs:
      confirm:
        description: "Type CONFIRM to deploy to production"
        required: true

permissions:
  id-token: write
  contents: read

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - name: Check confirmation
        if: ${{ github.event.inputs.confirm != 'CONFIRM' }}
        run: echo "Must type CONFIRM" && exit 1

  deploy-prod:
    needs: validate
    runs-on: ubuntu-latest
    environment: production    # Triggers Required Reviewer approval configured in GitHub
    steps:
      - uses: actions/checkout@v4

      - name: Azure Login (OIDC)
        uses: azure/login@v2
        with:
          client-id:       ${{ secrets.AZURE_CLIENT_ID }}
          tenant-id:       ${{ secrets.AZURE_TENANT_ID }}
          subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}

      - name: Get AKS credentials (prod)
        run: |
          az aks get-credentials \
            --resource-group ${{ secrets.AML_RESOURCE_GROUP_PROD }} \
            --name ${{ secrets.AKS_CLUSTER_PROD }} \
            --overwrite-existing

      - name: Get latest image from ACR prod
        id: image
        run: |
          NAME=$(az acr list --resource-group ${{ secrets.AML_RESOURCE_GROUP_PROD }} --query "[0].name" -o tsv)
          SERVER=$(az acr show --name $NAME --query loginServer -o tsv)
          TAG=$(az acr repository show-tags --name $NAME --repository iris-classifier --orderby time_desc --top 1 -o tsv)
          echo "server=$SERVER" >> $GITHUB_OUTPUT
          echo "tag=$TAG"       >> $GITHUB_OUTPUT

      - name: Deploy to AKS prod
        run: |
          cp mlops/pipelines/aks-deployment.yml /tmp/aks-prod.yml
          sed -i "s|ACR_LOGIN_SERVER_PLACEHOLDER|${{ steps.image.outputs.server }}|g" /tmp/aks-prod.yml
          sed -i "s|IMAGE_TAG_PLACEHOLDER|${{ steps.image.outputs.tag }}|g" /tmp/aks-prod.yml
          sed -i "s|ENVIRONMENT_PLACEHOLDER|prod|g" /tmp/aks-prod.yml
          kubectl apply -f /tmp/aks-prod.yml
          kubectl rollout status deployment/iris-classifier --timeout=600s
```

---

### 5.10 Tests unitaires — tests/

#### tests/test_prep.py

```python
import os, tempfile, sys
sys.path.insert(0, "mlops/data-science/src")
from prep import main as prep_main
import pandas as pd

class A:
    def __init__(self, d): self.output_dir = d

def test_files_created():
    with tempfile.TemporaryDirectory() as tmp:
        prep_main(A(tmp))
        assert os.path.exists(f"{tmp}/train.csv")
        assert os.path.exists(f"{tmp}/test.csv")

def test_split_ratio():
    with tempfile.TemporaryDirectory() as tmp:
        prep_main(A(tmp))
        tr = pd.read_csv(f"{tmp}/train.csv")
        te = pd.read_csv(f"{tmp}/test.csv")
        assert len(tr) + len(te) == 150
        assert abs(len(te) / 150 - 0.2) < 0.02
```

#### tests/test_train.py

```python
import os, tempfile, sys
sys.path.insert(0, "mlops/data-science/src")
from prep import main as prep_main
from train import main as train_main

class PA:
    def __init__(self, d): self.output_dir = d

class TA:
    def __init__(self, data_dir, model_dir, max_iter=50):
        self.data_dir = data_dir; self.model_dir = model_dir; self.max_iter = max_iter

def test_model_created():
    with tempfile.TemporaryDirectory() as tmp:
        data  = f"{tmp}/data"
        model = f"{tmp}/model"
        prep_main(PA(data))
        train_main(TA(data, model))
        assert os.path.exists(f"{model}/model.joblib")
```

---

### 5.11 Scripts utilitaires

#### scripts/generate-drift.py

```python
"""Send normal + drifted requests to endpoint. Used in J4 monitoring exercise."""
import json, random, argparse
import requests

NORMAL = {
    "sepal_length": (4.3, 7.9), "sepal_width": (2.0, 4.4),
    "petal_length": (1.0, 6.9), "petal_width":  (0.1, 2.5),
}

def sample(drifted=False):
    return [
        round(random.uniform(lo, hi) * (random.uniform(1.5, 2.5) if drifted else 1.0), 2)
        for lo, hi in NORMAL.values()
    ]

def main(args):
    hdrs = {"Content-Type": "application/json",
            "Authorization": f"Bearer {args.api_key}"}
    for i in range(args.n_normal):
        r = requests.post(args.endpoint, data=json.dumps({"data": [sample(False)]}), headers=hdrs)
        if i % 10 == 0: print(f"Normal  [{i:3d}] → {r.status_code}")
    for i in range(args.n_drifted):
        r = requests.post(args.endpoint, data=json.dumps({"data": [sample(True)]}), headers=hdrs)
        print(f"DRIFTED [{i:3d}] → {r.status_code}: {r.text[:60]}")

if __name__ == "__main__":
    p = argparse.ArgumentParser()
    p.add_argument("--endpoint",  required=True)
    p.add_argument("--api_key",   default="")
    p.add_argument("--n_normal",  type=int, default=50)
    p.add_argument("--n_drifted", type=int, default=20)
    main(p.parse_args())
```

#### scripts/setup-rbac.sh

```bash
#!/bin/bash
# Configure RBAC for MLOps team on a given environment.
# Usage: bash setup-rbac.sh <env> <aad-group-object-id>
set -e
ENV=${1:-dev}
GROUP_OID=${2?"Usage: $0 <env> <group-object-id>"}
PROJECT="mlopslab"
RG="rg-${PROJECT}-${ENV}"
SUB=$(az account show --query id -o tsv)

echo "=== RBAC setup for env=$ENV, group=$GROUP_OID ==="

az role assignment create \
  --assignee "$GROUP_OID" \
  --role "AzureML Data Scientist" \
  --scope "/subscriptions/$SUB/resourceGroups/$RG"

AKS_ID=$(az aks show --name "aks-${PROJECT}-${ENV}" --resource-group "$RG" --query id -o tsv)
az role assignment create \
  --assignee "$GROUP_OID" \
  --role "Azure Kubernetes Service Cluster User Role" \
  --scope "$AKS_ID"

KV_ID=$(az keyvault show --name "kv-${PROJECT}-${ENV}" --resource-group "$RG" --query id -o tsv)
az role assignment create \
  --assignee "$GROUP_OID" \
  --role "Key Vault Secrets User" \
  --scope "$KV_ID"

echo "=== Done ==="
```

---

### 5.12 Fiches Lab — lab/jour1.md à lab/jour5.md

#### lab/jour1.md

```markdown
# Jour 1 — Fondations DevOps & Azure pour la Data/ML

## Objectifs
- Comprendre DevOps vs MLOps
- Naviguer dans les services Azure clés (AML, ACR, AKS)
- Lancer le pipeline ML localement de bout en bout

## Prérequis
- Compte Azure actif avec accès au subscription de lab
- git, Python 3.10, Azure CLI installés
- `az extension add -n ml` exécuté

## Architecture (schéma à dessiner)
```
GitHub Actions (CI/CD)
       │
       ├── Azure ML (train, track, register)
       │         ↓
       └── ACR (image) → AKS (serving)
                              ↓
                   Azure Monitor + App Insights
                   Key Vault (secrets)
```

## Atelier

### 1. Setup (5 min)
```bash
git clone https://github.com/TON_ORG/mlops-azure-lab.git
cd mlops-azure-lab && pip install -r requirements.txt
```

### 2. Convention de branches (5 min)
- `main` → CI + CD prod (approbation manuelle)
- `dev`  → CI + CD dev automatique
- `feature/*` → CI seulement

### 3. Créer le workspace AML dev (portail, 15 min)
```bash
az login
az group create --name rg-mlopslab-dev --location westeurope
# Portal > Azure Machine Learning > Create
# RG: rg-mlopslab-dev | Name: aml-mlopslab-dev
```

### 4. Lancer le pipeline localement (25 min)
```bash
python mlops/data-science/src/prep.py --output_dir /tmp/iris
python mlops/data-science/src/train.py --data_dir /tmp/iris --model_dir /tmp/model
python mlops/data-science/src/evaluate.py --data_dir /tmp/iris --model_dir /tmp/model
pytest tests/ -v
```

## Checkpoint J1
- [ ] Pipeline local (prep → train → evaluate) sans erreur
- [ ] Workspace AML dev visible sur le portail
- [ ] `pytest tests/ -v` : 3 tests PASSED
```

#### lab/jour2.md

```markdown
# Jour 2 — Infrastructure as Code & Environnements

## Objectifs
- Déployer l'infra Azure via Terraform
- Comprendre la séparation dev/prod
- Lire un plan Terraform et comprendre les modules

## Atelier

### 1. Préparer le backend state (15 min)
```bash
az group create --name rg-tfstate --location westeurope
az storage account create --name satfstatemlops --resource-group rg-tfstate --sku Standard_LRS
az storage container create --name tfstate --account-name satfstatemlops
```

### 2. Init + Plan + Apply dev (25 min)
```bash
cd infrastructure
terraform init \
  -backend-config="resource_group_name=rg-tfstate" \
  -backend-config="storage_account_name=satfstatemlops" \
  -backend-config="container_name=tfstate" \
  -backend-config="key=mlopslab-dev.tfstate"

terraform plan -var-file="environments/dev.tfvars"
# Lire le plan : combien de ressources ? Lesquelles ?
terraform apply -var-file="environments/dev.tfvars"
```

### 3. Vérifier sur le portail (10 min)
Portal > rg-mlopslab-dev → 7 ressources attendues :
Storage Account, Key Vault, ACR, Log Analytics, App Insights, AML Workspace, AKS

### 4. Lire les outputs (5 min)
```bash
terraform output
```

### 5. (Optionnel) Déployer prod
```bash
terraform init -reconfigure -backend-config="key=mlopslab-prod.tfstate" [autres configs]
terraform apply -var-file="environments/prod.tfvars"
```

## Checkpoint J2
- [ ] 7 ressources dans rg-mlopslab-dev
- [ ] `terraform output` affiche workspace + AKS + ACR
- [ ] Différence dev.tfvars / prod.tfvars expliquée
```

#### lab/jour3.md

```markdown
# Jour 3 — CI/CD pour le Machine Learning

## Objectifs
- Comprendre Azure Pipelines et GitHub Actions (théorie)
- Lire et comprendre les 3 workflows GitHub Actions du repo
- Déclencher un CI réel (commit → AML pipeline)
- Observer le déploiement AKS end-to-end

## Matin — Théorie : Azure Pipelines vs GitHub Actions (40 min)

### Même concept, deux syntaxes

Les deux systèmes font la même chose : détecter un événement (push, tag, timer),
exécuter des steps dans un runner (VM temporaire), interagir avec Azure.
La différence est dans l'écosystème et la syntaxe YAML.

```yaml
# Azure Pipelines (azure-pipelines.yml)    # GitHub Actions (.github/workflows/ci.yml)
trigger:                                    on:
  branches:                                   push:
    include: [main]                             branches: [main]

pool:                                       jobs:
  vmImage: ubuntu-latest                      train:
                                               runs-on: ubuntu-latest
steps:
- task: AzureCLI@2                             steps:
  inputs:                                      - uses: actions/checkout@v4
    azureSubscription: 'my-conn'               - uses: azure/login@v2
    scriptType: bash                             with:
    inlineScript: |                                client-id: ${{ secrets.AZURE_CLIENT_ID }}
      az ml job create \                       - run: az ml job create \
        --file pipeline.yml                          --file mlops/pipelines/pipeline.yml
```

### Différences clés

| | Azure Pipelines | GitHub Actions |
|---|---|---|
| Hébergement | dev.azure.com (portail séparé) | github.com (même repo) |
| Auth Azure | Service Connection (UI) | OIDC (Federated Credentials) |
| Réutilisabilité | Templates YAML | Reusable Workflows |
| Ecosystème | Azure-first | Open source / multi-cloud |
| Visibilité YAML | Dans le repo | Dans le repo |
| Courbe d'apprentissage | Légèrement plus verbeux | Plus concis |

### Quand voir ADO en entreprise ?
- Grandes entreprises avec licences Microsoft existantes
- Projets qui utilisent déjà Azure Repos (git intégré à ADO)
- Équipes qui veulent tout dans un seul portail Azure

**Pour ce lab : GitHub Actions.** Le YAML est dans le repo, les stagiaires le voient
et le modifient directement sans naviguer vers un portail supplémentaire.

---

## Après-midi — Atelier : GitHub Actions en pratique

### 1. Lire les workflows (15 min)
Ouvrir `.github/workflows/` et répondre :
- Qu'est-ce qui déclenche `ci-train.yml` ?
- Pourquoi `train-pipeline` a `environment: dev` ?
- Que font les 3 commandes `sed` dans `cd-deploy-dev.yml` ?
- Pourquoi `cd-deploy-prod.yml` nécessite `environment: production` ?

### 2. Premier push sur dev (10 min)
```bash
git checkout dev
# Modifier train.py : max_iter 200 → 300
git add mlops/data-science/src/train.py
git commit -m "feat: max_iter 300"
git push origin dev
```
Observer GitHub Actions : les 3 jobs de `ci-train.yml`.

### 3. Observer le pipeline AML (15 min)
Azure ML Studio > Jobs > pipeline en cours.
Cliquer sur chaque étape : prep_data, train_model, evaluate_model.

### 4. Tester l'endpoint AKS (15 min)
```bash
az aks get-credentials --resource-group rg-mlopslab-dev --name aks-mlopslab-dev
kubectl get svc iris-classifier-svc   # noter EXTERNAL-IP
curl -X POST http://EXTERNAL_IP/score \
  -H "Content-Type: application/json" \
  -d '{"data": [[5.1, 3.5, 1.4, 0.2]]}'
# Attendu : [{"prediction": "setosa", ...}]
```

### 5. Tester le quality gate (5 min)
```bash
# Dans evaluate.py, passer min_accuracy à 0.99
# Pousser → observer le CI échouer sur evaluate_model
# Remettre 0.90 et repousser
```

## Checkpoint J3
- [ ] CI vert (lint + tests + AML pipeline)
- [ ] Endpoint AKS répond à curl
- [ ] Quality gate testé : échec à 0.99, succès à 0.90
```

#### lab/jour4.md

```markdown
# Jour 4 — Tracking, Registry & Monitoring

## Objectifs
- Comparer des runs MLflow dans AML Studio
- Gérer les versions de modèles dans AML Registry
- Configurer une alerte Azure Monitor
- Simuler du data drift

## Atelier

### 1. Explorer les runs MLflow (10 min)
Azure ML Studio > Jobs > sélectionner 2 runs > Compare.
Observer : Metrics, Parameters, Artifacts, Tags.

### 2. Versioning de modèles (10 min)
```bash
az ml model list --name iris-classifier
az ml model show --name iris-classifier --version 1
```
Azure ML Studio > Models > iris-classifier → historique des versions.

### 3. Alerte Azure Monitor (15 min)
Portal > App Insights (`appi-mlopslab-dev`) > Alerts > New Alert Rule.
- Signal : `requests/failed`
- Threshold : > 5 en 5 min
- Action group : email

### 4. Simulation drift (25 min)
```bash
ENDPOINT=$(kubectl get svc iris-classifier-svc -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

# Trafic normal
python scripts/generate-drift.py --endpoint http://$ENDPOINT/score --n_normal 50 --n_drifted 0

# Observer App Insights > Live Metrics pendant l'envoi

# Trafic drifté
python scripts/generate-drift.py --endpoint http://$ENDPOINT/score --n_normal 10 --n_drifted 40

# Observer les réponses anormales dans App Insights > Requests
```

## Checkpoint J4
- [ ] 2 runs comparés dans AML Studio
- [ ] Versions modèle visibles dans AML Registry
- [ ] Alerte Monitor configurée
- [ ] Drift simulé et logs observés dans App Insights
```

#### lab/jour5.md

```markdown
# Jour 5 — Sécurité, Gouvernance & Bonnes pratiques

## Objectifs
- Configurer RBAC pour une équipe MLOps
- Utiliser Key Vault
- Valider les standards équipe

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

### 3. Utiliser Key Vault (10 min)
```bash
KV="kv-mlopslab-dev"
az keyvault secret set --vault-name $KV --name "model-api-key" --value "secret-key-123"
az keyvault secret show --vault-name $KV --name "model-api-key" --query value -o tsv
```

### 4. Audit OIDC vs Service Principal (10 min)
Questions de compréhension :
- Où est stocké le Client ID dans le workflow ? (GitHub Secret, pas en clair)
- Quelle est la durée de vie du token OIDC ? (~1h, non renouvelable)
- Pourquoi est-ce plus sûr qu'un SP secret ? (pas de secret longue durée stocké)

### 5. Checklist Standards Équipe (20 min)

**Infrastructure**
- [ ] Toute ressource créée via Terraform (0 clic portail)
- [ ] Tags `environment`, `project`, `managed_by` sur toutes les ressources
- [ ] Budget alert configurée sur le subscription

**CI/CD**
- [ ] 0 secret en clair dans le code
- [ ] Quality gate accuracy >= 0.90 dans le CI
- [ ] Approbation manuelle requise pour prod

**ML**
- [ ] Chaque modèle déployé = enregistré dans AML Registry
- [ ] Chaque run = métriques loggées (MLflow)
- [ ] Drift monitoring configuré sur endpoint prod

**Sécurité**
- [ ] OIDC pour GitHub → Azure (pas de secret SP)
- [ ] Secrets dans Key Vault
- [ ] RBAC minimal (principe du moindre privilège)

## Checkpoint J5
- [ ] RBAC configuré via script
- [ ] Secret lu depuis Key Vault
- [ ] Checklist complétée et discutée en groupe
```

---

## 6. GitHub Environments & Secrets — Récapitulatif

### Environments à créer dans GitHub
- `dev` : aucune protection
- `production` : Required reviewers → ton GitHub username

### 9 Repository Secrets requis

| Secret | Description |
|--------|-------------|
| `AZURE_CLIENT_ID` | App Registration Client ID |
| `AZURE_TENANT_ID` | Azure Tenant ID |
| `AZURE_SUBSCRIPTION_ID` | Azure Subscription ID |
| `AML_WORKSPACE_DEV` | `aml-mlopslab-dev` |
| `AML_WORKSPACE_PROD` | `aml-mlopslab-prod` |
| `AML_RESOURCE_GROUP_DEV` | `rg-mlopslab-dev` |
| `AML_RESOURCE_GROUP_PROD` | `rg-mlopslab-prod` |
| `AKS_CLUSTER_DEV` | `aks-mlopslab-dev` |
| `AKS_CLUSTER_PROD` | `aks-mlopslab-prod` |

---

## 7. Checklist de Validation Finale

```bash
# ── Structure ──────────────────────────────────────────────────────────────
ls infrastructure/modules/   # 7 modules : resource-group aml-workspace container-registry key-vault storage-account application-insights aks
ls mlops/data-science/src/   # prep.py train.py evaluate.py register.py score.py
ls .github/workflows/        # ci-train.yml cd-deploy-dev.yml cd-deploy-prod.yml
ls lab/                      # jour1.md jour2.md jour3.md jour4.md jour5.md

# Dossiers de bruit supprimés (cv/, nlp/, classical/)
for d in cv nlp classical; do
  [ ! -d "$d" ] && echo "OK: $d absent" || echo "ERREUR: $d existe encore"
done

# Bicep lab présent
for f in infrastructure/bicep/main.bicep \
          infrastructure/bicep/parameters/dev.bicepparam \
          infrastructure/bicep/parameters/prod.bicepparam; do
  [ -f "$f" ] && echo "OK: $f" || echo "ERREUR: $f manquant"
done

# Terraform reference présent
[ -f "infrastructure/terraform-reference/main.tf" ] && echo "OK: terraform-reference/main.tf" || echo "ERREUR: terraform-reference/main.tf manquant"

# Aucune référence externe mlops-templates
grep -r "mlops-templates" .github/ && echo "ERREUR" || echo "OK: pas de mlops-templates"

# ── Python ─────────────────────────────────────────────────────────────────
pip install -r requirements.txt
python mlops/data-science/src/prep.py --output_dir /tmp/iris-check
python mlops/data-science/src/train.py --data_dir /tmp/iris-check --model_dir /tmp/model-check
python mlops/data-science/src/evaluate.py --data_dir /tmp/iris-check --model_dir /tmp/model-check
pytest tests/ -v  # Attendu : 3 PASSED

# ── Terraform Reference (syntaxe seulement, pas de apply) ──────────────────
cd infrastructure/terraform-reference
terraform init -backend=false
terraform validate   # Success! The configuration is valid.
terraform fmt -check
cd ../..

# ── GitHub Actions YAML ────────────────────────────────────────────────────
grep -r "id-token: write" .github/        # 3 lignes attendues
grep -r "environment: dev" .github/       # ≥ 1 ligne
grep -r "environment: production" .github/ # 1 ligne
```

---

## 8. Ordre d'Exécution STRICT pour Claude Code

1. **Lire les amendements** (début du doc) + **lire le document entièrement** avant de créer le moindre fichier
2. **Nettoyage** : supprimer tous les dossiers/fichiers listés en section 4
3. **Créer les dossiers vides** : toute l'arborescence de la section 3.1
4. **Fichiers racine** : `.gitignore`, `requirements.txt`, `README.md`
5. **Bicep** (amendement 1) : `infrastructure/bicep/main.bicep`, les 6 modules, `dev.bicepparam`, `prod.bicepparam`
6. **Terraform référence** (amendement 1) : `infrastructure/terraform-reference/` — version simplifiée avec `README.md` "lecture seule"
7. **Code ML Python** : `prep.py`, `train.py`, `evaluate.py`, `register.py`, `score.py`
8. **AML YAML** : `train-env.yml`, `pipeline.yml`, `online-endpoint.yml`, `online-deployment.yml`, `aks-deployment.yml`
9. **Dockerfile + server.py** dans `mlops/data-science/`
10. **GitHub Actions** : `ci-train.yml`, `cd-deploy-dev.yml`, `cd-deploy-prod.yml` — **INLINÉS, SANS mlops-templates**
11. **Tests** : `tests/test_prep.py`, `tests/test_train.py`
12. **Scripts** : `scripts/generate-drift.py`, `scripts/setup-rbac.sh`
13. **Lab docs** : `lab/lab0-setup.md` (section 2.2 du PRD), `lab/jour1.md` à `lab/jour5.md` (avec jour3.md mis à jour incluant la théorie ADO)
14. **Validation** : exécuter toutes les commandes de la section 7

---

*Fin du PRD — v1.1*
