resource "yandex_vpc_network" "this" {
  name = var.network_name
}

resource "yandex_vpc_gateway" "snat" {
  count = var.enable_snat_gateway ? 1 : 0
  name  = var.snat_gateway_name

  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "snat" {
  count      = var.enable_snat_gateway ? 1 : 0
  name       = var.snat_route_table_name
  network_id = yandex_vpc_network.this.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.snat[0].id
  }
}

resource "yandex_vpc_subnet" "this" {
  name           = var.subnet_name
  description    = var.subnet_description
  zone           = var.availability_zone_name
  network_id     = yandex_vpc_network.this.id
  v4_cidr_blocks = [var.subnet_address]
  route_table_id = var.enable_snat_gateway ? yandex_vpc_route_table.snat[0].id : null
}

resource "yandex_vpc_address" "this" {
  count = var.enable_public_fip ? 1 : 0
  name  = var.fip_name

  external_ipv4_address {
    zone_id = var.availability_zone_name
  }
}
