variable "tags" {
  type        = map(any)
  description = "Map containing the tags that conform to the current documented standards, and anything else required"
}

variable "environment" {
  description = "Object that holds environmental settings for the deployment"
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

variable "common_infrastructure_state" {
  type = object({
    resource_group_name  = string
    storage_account_name = string
    container_name       = string
    key                  = string
  })
}

variable "subscription_id" {
  type = string
}