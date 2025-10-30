variable "settings" {
  description = "Object that holds attribute settings for the resource"
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Network Security Rule. Changing this forces a new resource to be created."
}

variable "network_security_group_name" {
  description = "The name of the Network Security Group that we want to attach the rule to. Changing this forces a new resource to be created."
}