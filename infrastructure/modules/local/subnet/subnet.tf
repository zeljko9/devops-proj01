resource "azurerm_subnet" "subnet" {

  for_each = var.settings

  name                                          = try(each.value.name, "${var.environment.b_unit_id}-1-${var.environment.environment_id}-${var.environment.location_id}-${var.environment.service_name}-${each.key}-sub-${format("%02d", try(each.value.resource_number, 1))}")
  resource_group_name                           = var.resource_group_name
  virtual_network_name                          = var.vnet_name
  address_prefixes                              = each.value.address_prefixes
  default_outbound_access_enabled               = try(each.value.default_outbound_access_enabled, null)
  private_endpoint_network_policies             = try(each.value.private_endpoint_network_policies, "Enabled")
  private_link_service_network_policies_enabled = try(each.value.private_link_service_network_policies_enabled, null)
  service_endpoints                             = try(each.value.service_endpoints, null)
  service_endpoint_policy_ids                   = try(each.value.service_endpoint_policy_ids, null)

  dynamic "delegation" {
    for_each = lookup(each.value, "delegation", {}) != {} ? [1] : []
    content {
      name = each.value.delegation.name

      service_delegation {
        name    = each.value.delegation.service_delegation.name
        actions = lookup(each.value.delegation.service_delegation, "actions", null)
      }
    }
  }

}
