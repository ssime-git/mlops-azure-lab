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
