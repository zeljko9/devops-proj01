
output "subnet_ids" {
  value = {
    for k, s in azurerm_subnet.subnet : k => s.id
  }
}

output "subnet_names" {
  value = {
    for k, s in azurerm_subnet.subnet : k => s.name
  }
}

output "subnet_address_prefixes" {
  value = {
    for k, s in azurerm_subnet.subnet : k => s.address_prefixes
  }
}