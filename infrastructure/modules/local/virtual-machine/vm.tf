resource "azurerm_linux_virtual_machine" "linux_virtual_machine" {

  resource_group_name             = var.resource_group_name
  location                        = var.environment.location
  name                            = var.settings.name
  admin_username                  = var.settings.admin_username
  network_interface_ids           = var.settings.network_interface_ids
  size                            = var.settings.size
  tags                            = var.tags
  admin_password                  = try(var.settings.admin_password, null)
  allow_extension_operations      = try(var.settings.allow_extension_operations, null)
  availability_set_id             = try(var.settings.availability_set_id, null)
  capacity_reservation_group_id   = try(var.settings.capacity_reservation_group_id, null)
  computer_name                   = try(var.settings.computer_name, null)
  custom_data                     = try(var.settings.custom_data, null)
  dedicated_host_id               = try(var.settings.dedicated_host_id, null)
  dedicated_host_group_id         = try(var.settings.dedicated_host_group_id, null)
  disable_password_authentication = try(var.settings.disable_password_authentication, null)
  edge_zone                       = try(var.settings.edge_zone, null)
  encryption_at_host_enabled      = try(var.settings.encryption_at_host_enabled, null)
  eviction_policy                 = try(var.settings.eviction_policy, null)
  extensions_time_budget          = try(var.settings.extensions_time_budget, null)
  license_type                    = try(var.settings.license_type, null)
  patch_assessment_mode           = try(var.settings.patch_assessment_mode, null)
  patch_mode                      = try(var.settings.patch_mode, null)
  max_bid_price                   = try(var.settings.max_bid_price, null)
  platform_fault_domain           = try(var.settings.platform_fault_domain, null)
  priority                        = try(var.settings.priority, null)
  provision_vm_agent              = try(var.settings.provision_vm_agent, null)
  proximity_placement_group_id    = try(var.settings.proximity_placement_group_id, null)
  secure_boot_enabled             = try(var.settings.secure_boot_enabled, null)
  source_image_id                 = try(var.settings.source_image_id, null)
  user_data                       = try(var.settings.user_data, null)
  vtpm_enabled                    = try(var.settings.vtpm_enabled, null)
  virtual_machine_scale_set_id    = try(var.settings.virtual_machine_scale_set_id, null)
  zone                            = try(var.settings.zone, null)

  os_disk {
    name                             = var.settings.os_disk.name
    caching                          = lookup(var.settings.os_disk, "caching", "ReadWrite")
    storage_account_type             = lookup(var.settings.os_disk, "storage_account_type", "Standard_LRS")
    disk_encryption_set_id           = lookup(var.settings.os_disk, "disk_encryption_set_id", null)
    disk_size_gb                     = lookup(var.settings.os_disk, "disk_size_gb", null)
    secure_vm_disk_encryption_set_id = lookup(var.settings.os_disk, "secure_vm_disk_encryption_set_id", null)
    security_encryption_type         = lookup(var.settings.os_disk, "security_encryption_type", null)
    write_accelerator_enabled        = lookup(var.settings.os_disk, "write_accelerator_enabled", null)

    dynamic "diff_disk_settings" {
      for_each = lookup(var.settings.os_disk, "diff_disk_settings", {}) != {} ? [1] : []
      content {
        option    = var.settings.os_disk.diff_disk_settings.option
        placement = lookup(var.settings.os_disk.diff_disk_settings, "placement", null)
      }
    }
  }

  dynamic "additional_capabilities" {
    for_each = lookup(var.settings, "additional_capabilities", {}) != {} ? [1] : []
    content {
      ultra_ssd_enabled = lookup(var.settings.additional_capabilities, "ultra_ssd_enabled", null)
    }
  }

  dynamic "admin_ssh_key" {
    for_each = try(var.settings.admin_ssh_key, [])
    content {
      public_key = admin_ssh_key.value.public_key
      username   = admin_ssh_key.value.username
    }
  }

  dynamic "boot_diagnostics" {
    for_each = lookup(var.settings, "boot_diagnostics", {}) != {} ? [1] : []
    content {
      storage_account_uri = lookup(var.settings.boot_diagnostics, "storage_account_uri", null)
    }
  }

  dynamic "secret" {
    for_each = lookup(var.settings, "secret", {}) != {} ? [1] : []
    content {
      key_vault_id = var.settings.secret.key_vault_id
      dynamic "certificate" {
        for_each = var.settings.secret.certificate
        content {
          url = certificate.url
        }
      }
    }
  }

  dynamic "gallery_application" {
    for_each = lookup(var.settings, "gallery_application", {}) != {} ? [1] : []
    content {
      configuration_blob_uri = var.settings.gallery_application.configuration_blob_uri
      version_id             = lookup(var.settings.gallery_application, "version_id", null)
      order                  = lookup(var.settings.gallery_application, "order", null)
      tag                    = lookup(var.settings.gallery_application, "tag", null)
    }
  }

  dynamic "identity" {
    for_each = lookup(var.settings, "identity", {}) != {} ? [1] : []
    content {
      type         = var.settings.identity.type
      identity_ids = lookup(var.settings.identity, "identity_ids", null)
    }
  }

  dynamic "source_image_reference" {
    for_each = lookup(var.settings, "source_image_reference", {}) != {} ? [1] : []
    content {
      publisher = lookup(var.settings.source_image_reference, "publisher", null)
      offer     = lookup(var.settings.source_image_reference, "offer", null)
      sku       = lookup(var.settings.source_image_reference, "sku", null)
      version   = lookup(var.settings.source_image_reference, "version", null)
    }
  }

  dynamic "termination_notification" {
    for_each = lookup(var.settings, "termination_notification", {}) != {} ? [1] : []
    content {
      enabled = var.settings.termination_notification.enabled
      timeout = lookup(var.settings.termination_notification, "timeout", null)

    }
  }

  dynamic "plan" {
    for_each = lookup(var.settings, "plan", {}) != {} ? [1] : []
    content {
      name      = var.settings.plan.name
      product   = var.settings.plan.product
      publisher = var.settings.plan.publisher
    }
  }



  lifecycle {
    replace_triggered_by = [
      null_resource.cloud_init_trigger
    ]
  }



}


resource "null_resource" "cloud_init_trigger" {
  triggers = {
    checksum = var.settings.custom_data_checksum
  }
}
