output "network_id" {
  value       = yandex_vpc_network.this.id
  description = "VPC network ID."
}

output "subnet_id" {
  value       = yandex_vpc_subnet.this.id
  description = "Subnet ID."
}

output "subnet_name" {
  value       = yandex_vpc_subnet.this.name
  description = "Subnet name."
}

output "fip_id" {
  value       = yandex_vpc_address.this.id
  description = "Static public IP ID."
}

output "fip_address" {
  value       = yandex_vpc_address.this.external_ipv4_address[0].address
  description = "Static public IP address."
}

output "snat_gateway_id" {
  value       = try(yandex_vpc_gateway.snat[0].id, null)
  description = "SNAT gateway ID."
}
