subscription_id = "7afbbf61-15f2-4b92-a808-1e284f749e8d"

settings = {
  vm = {
    name                 = "linux-service-vm"
    admin_username       = "devops"
    public_ip_allocation = true
    size                 = "Standard_B1s"
    os_disk = {
      name = "linux-service-vm-disk"
      size = 20
    }
    image = {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "18.04-LTS"
      version   = "latest"
    }
  }
  ama = {
    name = "DEV_AzureMonitorLinuxAgent"
    docker_log_files = {
      keycloak = {
        file_patterns = ["/var/lib/docker/containers/*keycloak*.log"]
        format        = "json"
        streams       = ["Custom-KeycloakLogs"]
      },
      nginx = {
        file_patterns = ["/var/lib/docker/containers/*nginx*.log"]
        format        = "json"
        streams       = ["Custom-NginxLogs"]
      },
      postgres = {
        file_patterns = ["/var/lib/docker/containers/*postgres*.log"]
        format        = "json"
        streams       = ["Custom-PostgresLogs"]
      }
    }
  }
}

github_runner_token = "placeholder"

common_infrastructure_state = {
  resource_group_name  = "devops-1-pr-euw-proj01-00"
  storage_account_name = "000devopspreuwproj01stg"
  container_name       = "terraform-remote-states"
  key                  = "development/deployments/common_infrastructure/terraform.tfstate"
}

environment = {
  b_unit_id      = "devops"
  environment_id = "pr"
  location_id    = "euw"
  service_name   = "proj01"
  location       = "westeurope"
}

tags = {
  costcenter = "1212"
  department = "IT"
  part       = "services"
}