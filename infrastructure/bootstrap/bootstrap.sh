#!/bin/bash

# Global settings
LOCATION="westeurope"

# Subscriptions
NONPROD_SUBSCRIPTION_ID="7afbbf61-15f2-4b92-a808-1e284f749e8d"
PROD_SUBSCRIPTION_ID="7953a2ec-9aee-448a-8ba4-5a7c3c819a1c"

# Resource Groups
NONPROD_RG="devops-1-dv-euw-proj01-00sub"
PROD_RG="devops-1-pr-euw-proj01-00sub"

# App Registrations
NONPROD_APP_NAME="sp-nonprod-pr1-infra-pipeline"
PROD_APP_NAME="sp-prod-pr1-infra-pipeline"

# Security Groups
NONPROD_OWNER_GROUP="nonprod_pr1_owners"
PROD_OWNER_GROUP="prod_pr1_owners"
NONPROD_READER_GROUP="nonprod_pr1_readers"
PROD_READER_GROUP="prod_pr1_readers"

# Storage Accounts
NONPROD_STORAGE="000devopsdveuwproj01stg"
PROD_STORAGE="000devopspreuwproj01stg"
CONTAINER_NAME="terraform-remote-states"

# Your email
OWNER_EMAIL="zeljko.m99@hotmail.com"


REPO="devops-proj01"
SECRET_NAME="dev_ssh_key"
SECRET_VALUE="<your private ssh key>"
# generate ssh keys
# put public key in infrastructure/deployment/services/templates/devops_vm.pub

# Login
az login

# Create Resource Groups
az account set --subscription $NONPROD_SUBSCRIPTION_ID
az group create --name $NONPROD_RG --location $LOCATION

az account set --subscription $PROD_SUBSCRIPTION_ID
az group create --name $PROD_RG --location $LOCATION
# Create App Registrations
az account set --subscription $NONPROD_SUBSCRIPTION_ID
NONPROD_APP_ID=$(az ad app create --display-name $NONPROD_APP_NAME --query appId -o tsv)
NONPROD_SP_ID=$(az ad sp create --id $NONPROD_APP_ID --query objectId -o tsv)

az ad app federated-credential create --id $NONPROD_APP_ID --parameters '{
  "name": "github-federation",
  "issuer": "https://token.actions.githubusercontent.com",
  "subject": "repo:<your-org>/<your-repo>:ref:refs/heads/main",
  "audiences": ["api://AzureADTokenExchange"]
}'

az account set --subscription $PROD_SUBSCRIPTION_ID
PROD_APP_ID=$(az ad app create --display-name $PROD_APP_NAME --query appId -o tsv)
PROD_SP_ID=$(az ad sp create --id $PROD_APP_ID --query objectId -o tsv)

az ad app federated-credential create --id $PROD_APP_ID --parameters '{
  "name": "github-federation",
  "issuer": "https://token.actions.githubusercontent.com",
  "subject": "repo:<your-org>/<your-repo>:ref:refs/heads/main",
  "audiences": ["api://AzureADTokenExchange"]
}'

# Create Security Groups
for group in $NONPROD_OWNER_GROUP $NONPROD_READER_GROUP $PROD_OWNER_GROUP $PROD_READER_GROUP; do
  az ad group create --display-name "$group" --mail-nickname "$group"
done

# Add members to Owner groups
OWNER_OBJECT_ID=$(az ad user show --id $OWNER_EMAIL --query id -o tsv)

az ad group member add --group $NONPROD_OWNER_GROUP --member-id $OWNER_OBJECT_ID
az ad group member add --group $NONPROD_OWNER_GROUP --member-id $NONPROD_SP_ID

az ad group member add --group $PROD_OWNER_GROUP --member-id $OWNER_OBJECT_ID
az ad group member add --group $PROD_OWNER_GROUP --member-id $PROD_SP_ID

# Create containers in existing Storage Accounts
az account set --subscription $NONPROD_SUBSCRIPTION_ID
az storage container create --name $CONTAINER_NAME --account-name $NONPROD_STORAGE

az account set --subscription $PROD_SUBSCRIPTION_ID
az storage container create --name $CONTAINER_NAME --account-name $PROD_STORAGE

# Assign Storage Blob Data Contributor to Owner groups
NONPROD_OWNER_GROUP_ID=$(az ad group show --group $NONPROD_OWNER_GROUP --query id -o tsv)
PROD_OWNER_GROUP_ID=$(az ad group show --group $PROD_OWNER_GROUP --query id -o tsv)

az role assignment create --assignee-object-id $NONPROD_OWNER_GROUP_ID \
  --role "Storage Blob Data Contributor" \
  --scope "/subscriptions/$NONPROD_SUBSCRIPTION_ID/resourceGroups/$NONPROD_RG/providers/Microsoft.Storage/storageAccounts/$NONPROD_STORAGE"

az role assignment create --assignee-object-id $PROD_OWNER_GROUP_ID \
  --role "Storage Blob Data Contributor" \
  --scope "/subscriptions/$PROD_SUBSCRIPTION_ID/resourceGroups/$PROD_RG/providers/Microsoft.Storage/storageAccounts/$PROD_STORAGE"


gh auth login

if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <repo> <secret_name> <secret_value>"
  echo "Example: $0 zeljko/my-repo VM_SSH_PRIVATE_KEY \"<private-key-content>\""
  exit 1
fi

if ! command -v gh &> /dev/null; then
  echo "GitHub CLI (gh) not installed"
  exit 1
fi

# Postavljanje secret-a
gh secret set "$SECRET_NAME" --repo "$REPO" --body -
echo " Secret '$SECRET_NAME' postavljen u repo '$REPO'"

echo " Bootstrap complete for NonProd and Prod."