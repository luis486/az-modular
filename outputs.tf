output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "linux_vm_public_names" {
  value = module.vm[*].public_ip_dns_name
}

output "vm_public_ip_addresses" {
  value = module.vm[*].public_ip_address
}

output "vm_private_ip_addresses" {
  value = module.vm[*].network_interface_private_ip
}

output "vm_hostnames" {
  value = module.vm[*].vm_names
}