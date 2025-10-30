
output "resource_group_name" {
  description = "Name of the resource group"
  value       = module.common_resource_group.name
}

output "vnet_name" {
  description = "Name of the virtual network"
  value       = module.common_vnet.vnet_name
}

output "vnet_id" {
  description = "ID of the virtual network"
  value       = module.common_vnet.vnet_id
}

output "subnet_ids" {
  description = "IDs of the subnets"
  value       = module.common_subnets.subnet_ids
}

output "nsg_ids" {
  description = "IDs of the network security groups"
  value       = module.common_network_security_groups.id
}

output "nsg_names" {
  description = "NAMEs of the network security groups"
  value       = module.common_network_security_groups.name
}

output "log_analytics_workspace_id" {
  description = "ID of the Log Analytics Workspace"
  value       = module.common_workspace.id
}

output "log_analytics_workspace_name" {
  description = "Name of the Log Analytics Workspace"
  value       = module.common_workspace.name
}