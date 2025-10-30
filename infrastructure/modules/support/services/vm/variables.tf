
variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
}

variable "tags" {
  description = "Tags to apply to resources"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "settings" {
  description = "Settings for VM, network interface, and diagnostics"
  type = object({
    vm = object({
      name           = string
      public_ip_allocation = bool
      admin_username = string
      size           = string
      os_disk = object({
        name = string
        size = number
      })
      image = object({
        publisher = string
        offer     = string
        sku       = string
        version   = string
      })
      subnet_id                  = string
      log_analytics_workspace_id = string
    })
    ama = object({
      name = string
      docker_log_files = map(object({
        file_patterns = list(string)
        format        = string
        streams       = list(string)
      }))
    })
  })
}