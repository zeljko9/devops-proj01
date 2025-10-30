variable "tags" {
  type        = map(any)
  description = "Map containing the tags that conform to the current documented standards, and anything else required"
}

variable "environment" {
  description = "Object that holds environmental settings for the deployment"
}

variable "settings" {
  description = "Object that holds attribute settings for the resource"
  type = object({
    resource_group = object({
      resource_number = number
    })
    vnet = object({
      address_space = string
    })
  })
}

variable "subscription_id" {
  type = string
}