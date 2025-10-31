subscription_id = "7afbbf61-15f2-4b92-a808-1e284f749e8d"

settings = {
  vm = {
    name           = "linux-service-vm"
    public_ip_allocation = true
    admin_username = "devops"
    size           = "Standard_B1ms"
    os_disk = {
      name = "linux-service-vm-disk"
      size = 30
    }
    image = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-focal"
      sku       = "20_04-lts-gen2"
      version   = "latest"
    }
  }
  ama = {
    name = "AzureMonitorLinuxAgent"

    docker_log_files = {
      keycloak = {
        file_patterns = ["/var/lib/docker/containers/*keycloak*.log"]
        format        = "json"
        streams       = ["Custom-KeycloakLogs_CL"]
      },
      nginx = {
        file_patterns = ["/var/lib/docker/containers/*nginx*.log"]
        format        = "json"
        streams       = ["Custom-NginxLogs_CL"]
      },
      postgres = {
        file_patterns = ["/var/lib/docker/containers/*postgres*.log"]
        format        = "json"
        streams       = ["Custom-PostgresLogs_CL"]
      }
    }
  }
}

common_infrastructure_state = {
  resource_group_name  = "devops-1-dv-euw-proj01-00"
  storage_account_name = "000devopsdveuwproj01stg"
  container_name       = "terraform-remote-states"
  key                  = "development/deployments/common_infrastructure/terraform.tfstate"
}

environment = {
  b_unit_id      = "devops"
  environment_id = "dev"
  location_id    = "euw"
  service_name   = "proj01"
  location       = "westeurope"
}

tags = {
  costcenter = "1212"
  department = "IT"
  part       = "services"
}