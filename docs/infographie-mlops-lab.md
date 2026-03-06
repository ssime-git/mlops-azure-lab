# Infographie — MLOps Azure Lab (Themes, Notions, Technos)

Sources visuelles:
- Editable Excalidraw: `docs/infographie-mlops-lab.excalidraw`
- Export PNG: `docs/infographie-mlops-lab.png`

## 1) Vue d'Ensemble Architecture
```mermaid
flowchart LR
  subgraph Dev[Developer Workflow]
    A[Notebook J1\niris-walkthrough.ipynb]
    B[Scripts Python\nprep/train/evaluate/register/score]
    C[Tests\nunit + integration]
    A --> B --> C
  end

  subgraph GitHub[GitHub]
    D[Repo]
    E[CI\nLint + Tests + AML Pipeline]
    F[CD Dev\nACR Build + AKS Deploy]
    G[CD Prod\nApproval + Promote + Deploy]
    H[Ops\nAML Bootstrap]
    I[CD Backup\nAML Managed Endpoint]
    D --> E
    E --> F
    H --> E
    I --> G
  end

  subgraph Azure[Azure Platform]
    J[Azure ML Workspace]
    K[MLflow Tracking]
    L[ACR]
    M[AKS]
    N[Managed Endpoint AML]
    O[App Insights + Monitor]
    P[Key Vault]
    Q[RBAC / IAM]
    R[Terraform\nstate + infra dev/prod]
  end

  C --> D
  E --> J
  E --> K
  F --> L --> M
  I --> N
  M --> O
  N --> O
  J --> P
  Q --- J
  Q --- M
  R --> J
  R --> L
  R --> M
```

## 2) Progression Pedagogique (J0 -> J5)
```mermaid
timeline
  title Formation MLOps/DevOps Azure - 5 jours
  J0 : Setup securite
     : OIDC federated credentials
     : Secrets + GitHub Environments
  J1 : Data Science to Engineering
     : Setup local uv
     : Notebook Iris
     : Scripts + quality gate
  J2 : Infrastructure as Code
     : Demo Bicep (lite/full)
     : Terraform operationnel dev/prod
  J3 : CI/CD ML
     : CI training pipeline AML
     : CD AKS dev/prod
     : Managed Endpoint AML backup
  J4 : Observabilite
     : MLflow runs + model registry
     : Azure Monitor + App Insights
     : Drift simulation
  J5 : Securite & Gouvernance
     : RBAC minimal
     : Key Vault
     : Team standards checklist
```

## 3) Carte Notions -> Technos
```mermaid
mindmap
  root((MLOps Azure Lab))
    Donnees & Modeles
      Iris classification
      prep/train/evaluate
      register model AML
      scoring API
    Industrialisation
      GitHub Actions
      OIDC auth
      CI lint/test/train
      CD dev/prod
    Infrastructure
      Bicep demo
      Terraform operationnel
      ACR
      AKS
      AML Workspace
    Observabilite
      MLflow
      App Insights
      Azure Monitor
      Drift simulation
    Securite
      Key Vault
      RBAC
      Least privilege
      Prod approval gate
```

## 4) Gates de Qualite
```mermaid
flowchart TD
  A[Push / PR] --> B[Lint: black + flake8]
  B --> C[Tests: unit + integration]
  C --> D[AML pipeline: prep/train/evaluate]
  D --> E{Accuracy >= threshold?}
  E -- Non --> F[Fail pipeline]
  E -- Oui --> G[Build image + deploy dev]
  G --> H[Smoke test endpoint]
  H --> I[Manual approval prod]
  I --> J[Promote image + deploy prod]
```

## 5) Matrice Competences
| Theme | Notions cle | Outils / artefacts |
|---|---|---|
| MLOps fundamentals | train/eval/register/serve | `mlops/data-science/src/*` |
| Reproductibilite | lock dependencies, tests, lint | `requirements.in`, `requirements.txt`, `tests/`, CI |
| IaC | demo vs operationnel, state | `infrastructure/bicep/`, `infrastructure/terraform/` |
| CI/CD | environments, promotion, gates | `.github/workflows/*.yml` |
| Observabilite | metrics, logs, drift | MLflow, App Insights, `scripts/generate-drift.py` |
| Securite | OIDC, RBAC, secrets | `lab/lab0-setup.md`, `scripts/setup-rbac.sh`, Key Vault |
