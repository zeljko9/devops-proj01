output "id" {
  value = {
    for key, value in azurerm_network_security_group.network_security_group : key => value.id
  }
}

output "name" {
  value = {
    for key, value in azurerm_network_security_group.network_security_group : key => value.name
  }
}