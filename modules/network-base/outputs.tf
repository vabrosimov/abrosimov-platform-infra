output "subnet_id" {
  value       = cloudru_evolution_subnet.this.id
  description = "Subnet ID."
}

output "subnet_name" {
  value       = cloudru_evolution_subnet.this.name
  description = "Subnet name."
}

output "fip_id" {
  value       = cloudru_evolution_fip.this.id
  description = "Floating IP ID."
}

output "fip_address" {
  value       = cloudru_evolution_fip.this.ip_address
  description = "Floating IP address."
}
