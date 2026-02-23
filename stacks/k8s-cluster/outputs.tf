output "node_ids" {
  value       = { for k, m in module.nodes : k => m.id }
  description = "Created cluster node IDs."
}

output "node_names" {
  value       = { for k, m in module.nodes : k => m.name }
  description = "Created cluster node names."
}

output "node_states" {
  value       = { for k, m in module.nodes : k => m.state }
  description = "Created cluster node states."
}

output "network_id" {
  value       = module.network.network_id
  description = "Created VPC network ID."
}

output "subnet_id" {
  value       = module.network.subnet_id
  description = "Created subnet ID."
}

output "fip_id" {
  value       = module.network.fip_id
  description = "Created static public IP ID (attached to cp-01)."
}

output "fip_address" {
  value       = module.network.fip_address
  description = "Created static public IP address (for first control-plane node)."
}

output "snat_gateway_id" {
  value       = module.network.snat_gateway_id
  description = "SNAT gateway ID."
}

output "security_group_id" {
  value       = module.security.id
  description = "Created security group ID."
}

output "vpn_public_ip" {
  value       = try(yandex_vpc_address.vpn[0].external_ipv4_address[0].address, null)
  description = "VPN gateway public IP address."
}
