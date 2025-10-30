output "resource_group_name" {
  value = module.infrastructure.resource_group_name
}

output "log_analytics_workspace_id" {
  value = module.infrastructure.log_analytics_workspace_id
}

output "subnet_ids" {
  value = module.infrastructure.subnet_ids
}