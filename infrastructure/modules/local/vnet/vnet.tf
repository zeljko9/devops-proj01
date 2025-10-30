resource "azurerm_virtual_network" "virtual_network" {
  address_space       = [var.settings.address_space]
  location            = var.environment.location
  name                = "${var.environment.b_unit_id}-1-${var.environment.environment_id}-${var.environment.location_id}-${var.environment.service_name}-vnt-${format("%02d", var.resource_number)}"
  resource_group_name = var.resource_group_name

  tags = var.tags
}