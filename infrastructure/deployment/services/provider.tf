terraform {
  required_version = "1.13.4"

  required_providers {
    azurerm = {
      version = "4.50.0"
      source  = "hashicorp/azurerm"
    }
    # azuread = {
    #   version = "2.47.0"
    #   source  = "hashicorp/azuread"
    # }
  }

  # Configure the backend for storing Terraform state in Azure
  backend "azurerm" {
    use_azuread_auth = true
  }
}

# Configure the Azure provider with the specified subscription ID
provider "azurerm" {
  subscription_id     = var.subscription_id
  storage_use_azuread = true # This enables RBAC instead of access keys
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}