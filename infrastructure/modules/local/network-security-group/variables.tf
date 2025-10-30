variable "tags" {
  type        = map(any)
  description = "Map containing the tags that conform to the current documented standards, and anything else required"
}

variable "environment" {
  description = "Object that holds environmental settings for the deployment"
}

variable "settings" {
  description = "Object that holds attribute settings for the resource"
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the subnet"
}