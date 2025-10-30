resource "azurerm_public_ip" "public_ip" {

  name                    = "${var.environment.b_unit_id}-1-${var.environment.environment_id}-${var.environment.location_id}-${var.environment.service_name}-pip-${format("%02d", try(var.settings.resource_number, 1))}"
  resource_group_name     = var.resource_group_name
  location                = var.environment.location
  allocation_method       = var.settings.allocation_method
  zones                   = try(var.settings.zones, null)
  ddos_protection_mode    = try(var.settings.ddos_protection_mode, null)
  ddos_protection_plan_id = try(var.settings.ddos_protection_plan_id, null)
  domain_name_label       = try(var.settings.domain_name_label, null)
  edge_zone               = try(var.settings.edge_zone, null)
  idle_timeout_in_minutes = try(var.settings.idle_timeout_in_minutes, null)
  ip_tags                 = try(var.settings.ip_tags, null)
  ip_version              = try(var.settings.ip_version, null)
  public_ip_prefix_id     = try(var.settings.public_ip_prefix_id, null)
  reverse_fqdn            = try(var.settings.reverse_fqdn, null)
  sku                     = try(var.settings.sku, null)
  sku_tier                = try(var.settings.sku_tier, null)
  tags                    = var.tags

}