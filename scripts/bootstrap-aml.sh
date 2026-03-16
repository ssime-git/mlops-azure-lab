#!/usr/bin/env bash
# Bootstrap AML assets (environment + compute + optional health check) for a target workspace.
set -euo pipefail

TARGET_ENV=${1:-dev}
RESOURCE_GROUP=${2:-${AML_RESOURCE_GROUP:-}}
WORKSPACE=${3:-${AML_WORKSPACE:-}}
RUN_HEALTH_CHECK=${4:-true}

if [[ -z "$RESOURCE_GROUP" || -z "$WORKSPACE" ]]; then
  echo "Usage: bash scripts/bootstrap-aml.sh <dev|prod> <resource_group> <workspace> [run_health_check=true|false]"
  exit 1
fi

echo "[bootstrap-aml] target_env=$TARGET_ENV rg=$RESOURCE_GROUP ws=$WORKSPACE"

az extension add -n ml --yes 1>/dev/null
az configure --defaults group="$RESOURCE_GROUP" workspace="$WORKSPACE"

echo "[bootstrap-aml] Creating/updating AML environment iris-train-env..."
az ml environment create --file mlops/data-science/environment/train-env.yml 1>/dev/null

echo "[bootstrap-aml] Ensuring compute cluster cpu-cluster exists..."
if ! az ml compute show --name cpu-cluster 1>/dev/null 2>&1; then
  az ml compute create \
    --name cpu-cluster \
    --type amlcompute \
    --min-instances 0 \
    --max-instances 4 \
    --size Standard_DS3_v2 1>/dev/null
fi

echo "[bootstrap-aml] Ensuring compute cluster identity is system-assigned..."
az ml compute update \
  --name cpu-cluster \
  --identity-type system_assigned 1>/dev/null

echo "[bootstrap-aml] Ensuring cpu-cluster can pull from ACR..."
sleep 15
COMPUTE_PRINCIPAL_ID=$(az ml compute show --name cpu-cluster --query identity.principal_id -o tsv)
ACR_ID=$(az acr list --resource-group "$RESOURCE_GROUP" --query "[0].id" -o tsv)

if ! az role assignment list \
  --assignee-object-id "$COMPUTE_PRINCIPAL_ID" \
  --scope "$ACR_ID" \
  --query "[?roleDefinitionName=='AcrPull'] | [0]" -o tsv | grep -q .; then
  az role assignment create \
    --assignee-object-id "$COMPUTE_PRINCIPAL_ID" \
    --assignee-principal-type ServicePrincipal \
    --role AcrPull \
    --scope "$ACR_ID" 1>/dev/null
fi

if [[ "$RUN_HEALTH_CHECK" == "true" ]]; then
  echo "[bootstrap-aml] Running AML health-check job..."
  HEALTH_JOB_FILE=$(mktemp /tmp/aml-health-job-XXXXXX.yml)
  cat > "$HEALTH_JOB_FILE" <<'YAML'
$schema: https://azuremlschemas.azureedge.net/latest/commandJob.schema.json
code: mlops/data-science/src
command: python prep.py --output_dir outputs/health
environment: azureml:iris-train-env@latest
compute: azureml:cpu-cluster
experiment_name: aml-bootstrap-health
YAML

  JOB_NAME=$(az ml job create --file "$HEALTH_JOB_FILE" --query name -o tsv)
  STATUS=""

  for attempt in $(seq 1 20); do
    STATUS=$(az ml job show --name "$JOB_NAME" --query status -o tsv)
    echo "[bootstrap-aml] health-check status [$attempt/20]: $STATUS"

    case "$STATUS" in
      Completed)
        break
        ;;
      Failed|Canceled|CancelRequested|NotResponding)
        echo "[bootstrap-aml] Health-check failed with status=$STATUS"
        az ml job show --name "$JOB_NAME" -o json
        exit 1
        ;;
    esac

    sleep 15
  done

  if [[ "$STATUS" != "Completed" ]]; then
    echo "[bootstrap-aml] Health-check failed with status=$STATUS"
    az ml job show --name "$JOB_NAME" -o json
    exit 1
  fi
  echo "[bootstrap-aml] Health-check passed ($JOB_NAME)"
fi

echo "[bootstrap-aml] Done"
