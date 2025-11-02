output "public_ip_address" {
  value = module.vm_service.public_ip_address
}

output "ansible_inventory" {
  value = templatefile("${path.module}/templates/inventory.tpl", {
    env_name = var.environment.environment_id
    ip       = module.vm_service.public_ip_address
  })
}