#!/usr/bin/env bash
# Provisionne les apprenants du lab MLOps Azure.
#
# Pour chaque email du CSV :
#   1. résout l'utilisateur Entra (par UPN, mail, ou guest invité)
#   2. l'ajoute au groupe Entra (Contributor + User Access Administrator sur la subscription)
#   3. lui attribue le rôle Entra "Application Developer" (pour créer des App Registrations
#      quand `allowedToCreateApps=false` au niveau tenant)
#
# Prérequis :
#   - être Global Administrator (pour activer et assigner le rôle Entra)
#   - `az login` effectué
#   - groupe Entra déjà créé (cf. lab/partie0_admin.md)
#
# Usage :
#   bash scripts/admin-provision-users.sh [chemin_csv] [nom_groupe]
#
# Defaults :
#   CSV   = users/users.csv
#   GROUP = grp-mlops-lab-learners
#
# Format CSV attendu (en-tête obligatoire) :
#   nom,prenom,email

set -euo pipefail

CSV_PATH="${1:-users/users.csv}"
GROUP_NAME="${2:-grp-mlops-lab-learners}"
APP_DEV_TEMPLATE_ID="cf1c38e5-3621-4004-a7cb-879624dced7c"

if [ ! -f "$CSV_PATH" ]; then
  echo "ERREUR: fichier CSV introuvable: $CSV_PATH" >&2
  exit 1
fi

echo "==> Résolution du groupe Entra: $GROUP_NAME"
GROUP_ID=$(az ad group show --group "$GROUP_NAME" --query id -o tsv)
if [ -z "$GROUP_ID" ]; then
  echo "ERREUR: groupe '$GROUP_NAME' introuvable" >&2
  exit 1
fi
echo "    group id: $GROUP_ID"

echo "==> Vérification du rôle Entra 'Application Developer'"
APP_DEV_ROLE_ID=$(az rest --method GET \
  --url "https://graph.microsoft.com/v1.0/directoryRoles" \
  --query "value[?roleTemplateId=='$APP_DEV_TEMPLATE_ID'].id | [0]" -o tsv 2>/dev/null || true)

if [ -z "$APP_DEV_ROLE_ID" ] || [ "$APP_DEV_ROLE_ID" = "null" ]; then
  echo "    rôle non activé -> activation depuis le template"
  az rest --method POST \
    --url "https://graph.microsoft.com/v1.0/directoryRoles" \
    --body "{\"roleTemplateId\":\"$APP_DEV_TEMPLATE_ID\"}" >/dev/null
  APP_DEV_ROLE_ID=$(az rest --method GET \
    --url "https://graph.microsoft.com/v1.0/directoryRoles" \
    --query "value[?roleTemplateId=='$APP_DEV_TEMPLATE_ID'].id | [0]" -o tsv)
fi
echo "    role id: $APP_DEV_ROLE_ID"

# Membres actuels du rôle (set pour idempotence)
CURRENT_ROLE_MEMBERS=$(az rest --method GET \
  --url "https://graph.microsoft.com/v1.0/directoryRoles/$APP_DEV_ROLE_ID/members?\$select=id" \
  --query "value[].id" -o tsv || true)

resolve_user_id() {
  local email="$1"
  local uid

  # 1) Essai direct par UPN
  uid=$(az ad user show --id "$email" --query id -o tsv 2>/dev/null || true)
  if [ -n "$uid" ]; then echo "$uid"; return 0; fi

  # 2) Recherche par mail (utilisateur membre)
  uid=$(az rest --method GET \
    --url "https://graph.microsoft.com/v1.0/users?\$filter=mail eq '$email'&\$select=id" \
    --query "value[0].id" -o tsv 2>/dev/null || true)
  if [ -n "$uid" ] && [ "$uid" != "null" ]; then echo "$uid"; return 0; fi

  # 3) Recherche par otherMails (typique des invités guests)
  uid=$(az rest --method GET \
    --url "https://graph.microsoft.com/v1.0/users?\$filter=otherMails/any(c:c eq '$email')&\$select=id" \
    --query "value[0].id" -o tsv 2>/dev/null || true)
  if [ -n "$uid" ] && [ "$uid" != "null" ]; then echo "$uid"; return 0; fi

  return 1
}

SUMMARY_OK=()
SUMMARY_MISSING=()

# Lecture CSV (skip header)
tail -n +2 "$CSV_PATH" | while IFS=, read -r NOM PRENOM EMAIL; do
  EMAIL=$(echo "$EMAIL" | tr -d '\r' | xargs)
  [ -z "$EMAIL" ] && continue

  echo ""
  echo "==> $PRENOM $NOM <$EMAIL>"

  if ! USER_ID=$(resolve_user_id "$EMAIL"); then
    echo "    [SKIP] utilisateur introuvable dans le tenant"
    echo "    -> inviter en guest si besoin :"
    echo "       az rest --method POST --url https://graph.microsoft.com/v1.0/invitations \\"
    echo "         --body '{\"invitedUserEmailAddress\":\"$EMAIL\",\"inviteRedirectUrl\":\"https://portal.azure.com\",\"sendInvitationMessage\":true}'"
    continue
  fi
  echo "    user id: $USER_ID"

  # Ajout au groupe (idempotent : ignore si déjà membre)
  if az ad group member check --group "$GROUP_ID" --member-id "$USER_ID" --query value -o tsv 2>/dev/null | grep -qi true; then
    echo "    [OK] déjà membre du groupe"
  else
    az ad group member add --group "$GROUP_ID" --member-id "$USER_ID" >/dev/null
    echo "    [+] ajouté au groupe $GROUP_NAME"
  fi

  # Application Developer (idempotent)
  if echo "$CURRENT_ROLE_MEMBERS" | grep -q "$USER_ID"; then
    echo "    [OK] déjà Application Developer"
  else
    az rest --method POST \
      --url "https://graph.microsoft.com/v1.0/directoryRoles/$APP_DEV_ROLE_ID/members/\$ref" \
      --body "{\"@odata.id\":\"https://graph.microsoft.com/v1.0/directoryObjects/$USER_ID\"}" >/dev/null
    echo "    [+] rôle Application Developer attribué"
  fi
done

echo ""
echo "==> Terminé."
echo "    Vérification: az ad group member list --group \"$GROUP_NAME\" --query '[].userPrincipalName' -o tsv"
