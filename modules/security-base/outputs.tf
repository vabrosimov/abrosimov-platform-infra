output "id" {
  value       = yandex_vpc_security_group.this.id
  description = "Security group ID."
}

output "name" {
  value       = yandex_vpc_security_group.this.name
  description = "Security group name."
}
