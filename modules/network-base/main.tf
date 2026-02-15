resource "cloudru_evolution_subnet" "this" {
  project_id      = var.project_id
  name            = var.subnet_name
  description     = var.subnet_description
  subnet_address  = var.subnet_address
  default_gateway = var.default_gateway
  routed_network  = var.routed_network
  dns_servers     = var.dns_servers

  availability_zone {
    id = var.availability_zone_id
  }
}

resource "cloudru_evolution_fip" "this" {
  name        = var.fip_name
  description = var.fip_description

  availability_zone {
    id = var.availability_zone_id
  }
}
