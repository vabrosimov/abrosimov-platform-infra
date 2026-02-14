output "vm_id" {
  value       = module.vm.id
  description = "Created VM ID in dev k8s cluster stack."
}

output "vm_name" {
  value       = module.vm.name
  description = "Created VM name in dev k8s cluster stack."
}

output "vm_state" {
  value       = module.vm.state
  description = "Created VM state in dev k8s cluster stack."
}

output "subnet_id" {
  value       = module.network.subnet_id
  description = "Created subnet ID."
}

output "fip_id" {
  value       = module.network.fip_id
  description = "Created floating IP ID."
}

output "fip_address" {
  value       = module.network.fip_address
  description = "Created floating IP address."
}

output "security_group_id" {
  value       = module.security.id
  description = "Created security group ID."
}
