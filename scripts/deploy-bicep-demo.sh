#!/usr/bin/env bash
# Deploy the lightweight Bicep demo stack in an isolated resource group.
set -euo pipefail

RG_NAME=${1:-rg-mlopslab-bicep-demo}
LOCATION=${2:-westeurope}

echo "[bicep-demo] Resource group: $RG_NAME ($LOCATION)"
az group create --name "$RG_NAME" --location "$LOCATION" 1>/dev/null

az deployment group create \
  --resource-group "$RG_NAME" \
  --template-file infrastructure/bicep/main.bicep \
  --parameters infrastructure/bicep/parameters/demo-lite.bicepparam \
  --parameters location="$LOCATION"

echo "[bicep-demo] Done. This is a lite deployment (no AML workspace, no AKS)."
