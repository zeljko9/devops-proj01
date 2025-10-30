resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {

  name                = "${var.environment.b_unit_id}-1-${var.environment.environment_id}-${var.environment.location_id}-${var.environment.service_name}-law-${format("%02d", var.resource_number)}"
  resource_group_name = var.resource_group_name
  location            = var.environment.location

  sku                                = try(var.settings.sku, null)
  retention_in_days                  = try(var.settings.retention_in_days, null)
  daily_quota_gb                     = try(var.settings.daily_quota_gb, null)
  internet_ingestion_enabled         = try(var.settings.internet_ingestion_enabled, false)
  internet_query_enabled             = try(var.settings.internet_query_enabled, null)
  reservation_capacity_in_gb_per_day = try(var.settings.reservation_capacity_in_gb_per_day, null)

  tags = var.tags

}