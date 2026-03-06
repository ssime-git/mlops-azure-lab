#!/bin/bash
# Configure RBAC for MLOps team on a given environment.
# Usage: bash setup-rbac.sh <env> <aad-group-object-id>
set -euo pipefail
ENV=${1:-dev}
GROUP_OID=${2?"Usage: $0 <env> <group-object-id>"}
PROJECT="mlopslab"
RG="rg-${PROJECT}-${ENV}"
SUB=$(az account show --query id -o tsv)

echo "=== RBAC setup for env=$ENV, group=$GROUP_OID ==="

create_role_if_missing () {
  local assignee="$1"
  local role="$2"
  local scope="$3"

  EXISTING_ID=$(az role assignment list \
    --assignee "$assignee" \
    --role "$role" \
    --scope "$scope" \
    --query "[0].id" -o tsv)

  if [[ -n "$EXISTING_ID" ]]; then
    echo "Role already assigned: $role ($scope)"
  else
    az role assignment create \
      --assignee "$assignee" \
      --role "$role" \
      --scope "$scope" 1>/dev/null
    echo "Role assigned: $role ($scope)"
  fi
}

create_role_if_missing "$GROUP_OID" "AzureML Data Scientist" "/subscriptions/$SUB/resourceGroups/$RG"

AKS_ID=$(az aks show --name "aks-${PROJECT}-${ENV}" --resource-group "$RG" --query id -o tsv)
create_role_if_missing "$GROUP_OID" "Azure Kubernetes Service Cluster User Role" "$AKS_ID"

KV_ID=$(az keyvault show --name "kv-${PROJECT}-${ENV}" --resource-group "$RG" --query id -o tsv)
create_role_if_missing "$GROUP_OID" "Key Vault Secrets User" "$KV_ID"

echo "=== Done ==="
