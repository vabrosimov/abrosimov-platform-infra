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

output "subnet_id" {
  value       = module.network.subnet_id
  description = "Created subnet ID."
}

output "fip_id" {
  value       = module.network.fip_id
  description = "Created floating IP ID (attached to cp-01)."
}

output "fip_address" {
  value       = module.network.fip_address
  description = "Created floating IP address (for first control-plane node)."
}

output "security_group_id" {
  value       = module.security.id
  description = "Created security group ID."
}
