resource "cloudru_evolution_security_group" "this" {
  project_id  = var.project_id
  name        = var.name
  description = var.description

  availability_zone {
    id = var.availability_zone_id
  }

  dynamic "rules" {
    for_each = var.rules
    content {
      direction        = rules.value.direction
      ether_type       = rules.value.ether_type
      ip_protocol      = rules.value.ip_protocol
      port_range       = rules.value.port_range
      remote_ip_prefix = rules.value.remote_ip_prefix
      description      = try(rules.value.description, null)
    }
  }
}
