output "name" {
  value = azurerm_public_ip.public_ip.name
}

output "id" {
  value = azurerm_public_ip.public_ip.id
}

output "fqdn" {
  value = azurerm_public_ip.public_ip.fqdn
}

output "ip_addresses" {
  value = var.settings.allocation_method == "Static" ? azurerm_public_ip.public_ip.ip_address : null
}