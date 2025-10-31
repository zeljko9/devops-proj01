subscription_id = "7afbbf61-15f2-4b92-a808-1e284f749e8d"

settings = {
  resource_group = {
    resource_number = 1
  }
  vnet = {
    address_space = "10.0.0.0/16"
  }
}

environment = {
  b_unit_id      = "devops"
  environment_id = "prd"
  location_id    = "euw"
  service_name   = "proj01"
  location       = "westeurope"
}

tags = {
  costcenter = "1212"
  department = "IT"
  part       = "common_infrastructure"
}