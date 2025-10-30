resource "azurerm_resource_group" "resource_group" {
  name     = "${var.environment.b_unit_id}-1-${var.environment.environment_id}-${var.environment.location_id}-${var.environment.service_name}-rsg-${format("%02d", var.resource_number)}"
  location = var.environment.location

  tags = var.tags
}