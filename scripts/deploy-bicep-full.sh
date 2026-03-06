#!/usr/bin/env bash
# Deploy the full Bicep stack with guardrails to avoid collisions with Terraform-managed lab envs.
set -euo pipefail

ENVIRONMENT=${1:-dev}
PROJECT_NAME=${2:-}
RG_NAME=${3:-}
LOCATION=${4:-westeurope}

if [[ -z "$PROJECT_NAME" || -z "$RG_NAME" ]]; then
  echo "Usage: bash scripts/deploy-bicep-full.sh <env> <project_name> <resource_group> [location]"
  echo "Example: bash scripts/deploy-bicep-full.sh dev mlopsteam01 rg-mlopsteam01-dev westeurope"
  exit 1
fi

if [[ "$PROJECT_NAME" == "mlopslab" ]]; then
  echo "Guardrail: project_name 'mlopslab' is reserved for Terraform flow in this lab."
  echo "Choose a unique project_name to avoid naming collisions."
  exit 1
fi

if [[ "$RG_NAME" == "rg-mlopslab-dev" || "$RG_NAME" == "rg-mlopslab-prod" ]]; then
  echo "Guardrail: resource groups rg-mlopslab-dev/prod are reserved for Terraform flow."
  echo "Use a dedicated RG for Bicep full demo."
  exit 1
fi

az group create --name "$RG_NAME" --location "$LOCATION" 1>/dev/null

az deployment group create \
  --resource-group "$RG_NAME" \
  --template-file infrastructure/bicep/main.bicep \
  --parameters environment="$ENVIRONMENT" \
  --parameters projectName="$PROJECT_NAME" \
  --parameters location="$LOCATION" \
  --parameters deployFullStack=true

echo "[bicep-full] Deployment complete for env=$ENVIRONMENT, project=$PROJECT_NAME"
