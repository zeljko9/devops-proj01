
output "vm_id" {
  description = "ID of the virtual machine"
  value       = module.virtual_machine.id
}

output "vm_name" {
  description = "Name of the virtual machine"
  value       = module.virtual_machine.name
}

output "public_ip_addresses" {
  value = module.vm_public_ip[0].ip_addresses
}