data "terraform_remote_state" "common_infrastructure" {
  backend = "azurerm"
  config = {
    resource_group_name  = var.common_infrastructure_state.resource_group_name
    storage_account_name = var.common_infrastructure_state.storage_account_name
    container_name       = var.common_infrastructure_state.container_name
    key                  = var.common_infrastructure_state.key
    use_azuread_auth     = true
  }
}