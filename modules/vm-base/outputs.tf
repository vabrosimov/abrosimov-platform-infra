output "id" {
  value       = yandex_compute_instance.this.id
  description = "Compute instance ID."
}

output "name" {
  value       = yandex_compute_instance.this.name
  description = "Compute instance name."
}

output "state" {
  value       = yandex_compute_instance.this.status
  description = "Compute instance state."
}
