resource "azurerm_network_security_group" "network_security_group" {

  for_each = var.settings

  name                = try(each.value.name, "${var.environment.b_unit_id}-1-${var.environment.environment_id}-${var.environment.location_id}-${var.environment.service_name}-${each.key}-nsg-${format("%02d", try(each.value.resource_number, 1))}")
  resource_group_name = var.resource_group_name
  location            = var.environment.location

  tags = var.tags

}

resource "azurerm_subnet_network_security_group_association" "association" {
  for_each = var.settings

  subnet_id                 = each.value.subnet_id
  network_security_group_id = azurerm_network_security_group.network_security_group[each.key].id
}