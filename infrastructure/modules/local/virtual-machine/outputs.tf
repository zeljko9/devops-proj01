output "name" {
  value = azurerm_linux_virtual_machine.linux_virtual_machine.name
}

output "id" {
  value = azurerm_linux_virtual_machine.linux_virtual_machine.id
}

output "private_ip_address" {
  value = azurerm_linux_virtual_machine.linux_virtual_machine.private_ip_address
}

output "private_ip_addresses" {
  value = azurerm_linux_virtual_machine.linux_virtual_machine.private_ip_addresses
}

output "public_ip_address" {
  value = azurerm_linux_virtual_machine.linux_virtual_machine.public_ip_address
}

output "public_ip_addresses" {
  value = azurerm_linux_virtual_machine.linux_virtual_machine.public_ip_addresses
}

output "virtual_machine_id" {
  value = azurerm_linux_virtual_machine.linux_virtual_machine.virtual_machine_id
}

output "principal_id" {
  value     = try(azurerm_linux_virtual_machine.linux_virtual_machine.identity[0].principal_id, null)
  sensitive = true
}