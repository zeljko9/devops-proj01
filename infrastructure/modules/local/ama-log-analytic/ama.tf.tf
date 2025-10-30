
resource "azurerm_virtual_machine_extension" "monitor_agent" {
  name                 = var.settings.name
  virtual_machine_id   = var.settings.target_vm_id
  publisher            = var.settings.publisher
  type                 = var.settings.type
  type_handler_version = var.settings.type_handler_version
}


resource "azurerm_monitor_data_collection_rule" "vm_dcr" {
  name                = "vm-dcr"
  resource_group_name = var.resource_group_name
  location            = var.environment.location

  destinations {
    log_analytics {
      name                  = "log_analytics"
      workspace_resource_id = var.settings.workspace_id
    }
  }

  data_sources {
    dynamic "log_file" {
      for_each = var.settings.docker_log_files
      content {
        name          = log_file.key
        file_patterns = log_file.value.file_patterns
        format        = log_file.value.format
        streams       = log_file.value.streams
      }
    }
  }

  data_flow {
    streams      = flatten([for k, v in var.settings.docker_log_files : v.streams])
    destinations = ["log_analytics"]
  }
}

resource "azurerm_monitor_data_collection_rule_association" "vm_dcr_assoc" {
  name                    = "vm-dcr-association"
  target_resource_id      = var.settings.target_vm_id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.vm_dcr.id
}
