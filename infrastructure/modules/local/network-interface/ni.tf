resource "azurerm_network_interface" "network_interface" {

  location                = var.environment.location
  name                    = var.settings.name
  resource_group_name     = var.resource_group_name
  dns_servers             = try(var.settings.dns_servers, null)
  edge_zone               = try(var.settings.edge_zone, null)
  internal_dns_name_label = try(var.settings.internal_dns_name_label, null)
  tags                    = var.tags

  dynamic "ip_configuration" {
    for_each = try(var.settings.ip_configuration, [])
    content {
      name                                               = ip_configuration.value.name
      private_ip_address_allocation                      = ip_configuration.value.private_ip_address_allocation
      gateway_load_balancer_frontend_ip_configuration_id = lookup(ip_configuration.value, "gateway_load_balancer_frontend_ip_configuration_id", null)
      subnet_id                                          = lookup(ip_configuration.value, "subnet_id", null)
      private_ip_address_version                         = lookup(ip_configuration.value, "private_ip_address_version", null)
      public_ip_address_id                               = lookup(ip_configuration.value, "public_ip_address_id", null)
      primary                                            = lookup(ip_configuration.value, "primary", null)
      private_ip_address                                 = lookup(ip_configuration.value, "private_ip_address", null)
    }
  }

}