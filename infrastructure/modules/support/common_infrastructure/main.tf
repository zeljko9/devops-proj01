module "common_resource_group" {
  source = "../../local/resource-group"

  environment = var.environment
  tags        = var.tags

  resource_number = 1

  settings = var.settings.resource_group
}

module "common_vnet" {
  source = "../../local/vnet"

  environment = var.environment
  tags        = var.tags

  resource_group_name = module.common_resource_group.name
  resource_number     = 1

  settings = var.settings.vnet
}

module "common_subnets" {
  source = "../../local/subnet"

  environment = var.environment
  tags        = var.tags

  resource_group_name = module.common_resource_group.name
  vnet_name           = module.common_vnet.vnet_name

  settings = {
    infrastructure = {
      address_prefixes  = [cidrsubnet(var.settings.vnet.address_space, 2, 0)]
      service_endpoints = []
    }
    vm = {
      address_prefixes  = [cidrsubnet(var.settings.vnet.address_space, 2, 1)]
      service_endpoints = []
    }
  }
}

module "common_network_security_groups" {
  source = "../../local/network-security-group"

  environment = var.environment
  tags        = var.tags

  resource_group_name = module.common_resource_group.name

  settings = {
    vm = {
      associate = true
      subnet_id = module.common_subnets.subnet_ids["vm"]
    }
    infrastructure = {
      associate = true
      subnet_id = module.common_subnets.subnet_ids["infrastructure"]
    }
  }
}

module "common_nsg_rules" {
  source = "../../local/network-security-group/rule"

  resource_group_name         = module.common_resource_group.name
  network_security_group_name = module.common_network_security_groups.name["vm"]

  settings = {
    "allow_ssh" = {
      description                = "Allow SSH (port 22)"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      access                     = "Allow"
      priority                   = 100
      direction                  = "Inbound"
    },
    "allow_http" = {
      description                = "Allow HTTP (port 80)"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      access                     = "Allow"
      priority                   = 110
      direction                  = "Inbound"
    }
  }
}

module "common_workspace" {
  source = "../../local/analytic-workspace"

  environment = var.environment
  tags        = var.tags

  resource_group_name = module.common_resource_group.name
  resource_number     = 1

  settings = {
    sku                                = "PerGB2018"
    retention_in_days                  = 30
    daily_quota_gb                     = 0.2
    internet_ingestion_enabled         = false
    internet_query_enabled             = true
    reservation_capacity_in_gb_per_day = null
  }
}