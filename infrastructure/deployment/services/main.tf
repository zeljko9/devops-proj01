module "vm_service" {
  source = "../../modules/support/services/vm"

  environment = var.environment
  tags        = var.tags

  resource_group_name = data.terraform_remote_state.common_infrastructure.outputs.resource_group_name

  settings = {
    vm = merge(
      var.settings.vm,
      {
        subnet_id                  = data.terraform_remote_state.common_infrastructure.outputs.subnet_ids["vm"]
        log_analytics_workspace_id = data.terraform_remote_state.common_infrastructure.outputs.log_analytics_workspace_id
      }
    )
    ama = var.settings.ama
  }
}