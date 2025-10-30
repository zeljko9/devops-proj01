output "name" {
  value = azurerm_network_interface.network_interface.name
}

output "id" {
  value = azurerm_network_interface.network_interface.id
}

output "applied_dns_servers" {
  value = azurerm_network_interface.network_interface.applied_dns_servers
}

output "internal_domain_name_suffix" {
  value = azurerm_network_interface.network_interface.internal_domain_name_suffix
}

output "mac_address" {
  value = azurerm_network_interface.network_interface.mac_address
}

output "private_ip_address" {
  value = azurerm_network_interface.network_interface.private_ip_address
}

output "private_ip_addresses" {
  value = azurerm_network_interface.network_interface.private_ip_addresses
}

output "virtual_machine_id" {
  value = azurerm_network_interface.network_interface.virtual_machine_id
}