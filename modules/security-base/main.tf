locals {
  ingress_rules = [for r in var.rules : r if lower(r.direction) == "ingress"]
  egress_rules  = [for r in var.rules : r if lower(r.direction) == "egress"]
}

resource "yandex_vpc_security_group" "this" {
  name        = var.name
  description = var.description
  network_id  = var.network_id

  dynamic "ingress" {
    for_each = local.ingress_rules
    content {
      description    = try(ingress.value.description, null)
      protocol       = upper(ingress.value.protocol)
      v4_cidr_blocks = [ingress.value.cidr]
      from_port      = try(ingress.value.from_port, null)
      to_port        = try(ingress.value.to_port, null)
    }
  }

  dynamic "egress" {
    for_each = local.egress_rules
    content {
      description    = try(egress.value.description, null)
      protocol       = upper(egress.value.protocol)
      v4_cidr_blocks = [egress.value.cidr]
      from_port      = try(egress.value.from_port, null)
      to_port        = try(egress.value.to_port, null)
    }
  }
}
