output "state_bucket_name" {
  description = "Remote-state bucket name used by all stacks."
  value       = var.state_bucket_name
}

output "backend_common" {
  description = "Common backend options for S3-compatible storage."
  value       = local.backend_common
  sensitive   = true
}

output "state_keys" {
  description = "State key by environment/stack (format: env/stack => key)."
  value       = local.state_keys
}

output "backend_by_stack" {
  description = "Full backend configuration per environment/stack."
  value       = local.backend_by_stack
  sensitive   = true
}
