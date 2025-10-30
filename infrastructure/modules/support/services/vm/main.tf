module "virtual_machine" {
  source = "../../../local/virtual-machine"

  environment = var.environment
  tags        = var.tags

  resource_group_name = var.resource_group_name

  settings = {
    name                  = var.settings.vm.name
    admin_username        = var.settings.vm.admin_username
    network_interface_ids = [module.vm_network_interface.id]
    size                  = var.settings.vm.size


    custom_data_checksum = filesha256("${path.module}/cloud-init.yaml")


    os_disk = {
      name         = var.settings.vm.os_disk.name
      disk_size_gb = var.settings.vm.os_disk.size
    }

    source_image_reference = {
      publisher = var.settings.vm.image.publisher
      offer     = var.settings.vm.image.offer
      sku       = var.settings.vm.image.sku
      version   = var.settings.vm.image.version
    }

    admin_ssh_key = [{
      username   = var.settings.vm.admin_username
      public_key = file("~/.ssh/devops_vm.pub")
    }]

  custom_data = base64encode(file("${path.module}/cloud-init.yaml")) }
}

module "vm_network_interface" {
  source = "../../../local/network-interface"

  environment = var.environment
  tags        = var.tags

  resource_group_name = var.resource_group_name

  settings = {
    name = "vm_network_interface"

    ip_configuration = {
      "vm_ip_config" = {
        name                          = "vm_ip_config"
        private_ip_address_allocation = "Dynamic"
        subnet_id                     = var.settings.vm.subnet_id
        public_ip_address_id          = module.vm_public_ip[0].id
    } }
  }
}

module "vm_public_ip" {
  source = "../../../local/public-ip"

  count = var.settings.vm.public_ip_allocation == true ? 1 : 0

  environment = var.environment
  tags        = var.tags

  resource_group_name = var.resource_group_name

  settings = {
    allocation_method = "Static"
    sku               = "Standard"
    resource_number   = 1
  }
}

# module "ama-log-analytic" {
#   source = "../../../local/ama-log-analytic"

#   environment = var.environment
#   tags        = var.tags

#   resource_group_name = var.resource_group_name

#   settings = {
#     name                 = var.settings.ama.name
#     target_vm_id         = module.virtual_machine.id
#     publisher            = "Microsoft.Azure.Monitor"
#     type                 = "AzureMonitorLinuxAgent"
#     type_handler_version = "1.10"

#     workspace_id = var.settings.vm.log_analytics_workspace_id

#     docker_log_files = var.settings.ama.docker_log_files
#   }
# }