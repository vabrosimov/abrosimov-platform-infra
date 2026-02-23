data "yandex_compute_image" "base" {
  family = var.image_family
}

locals {
  control_plane_nodes = {
    for i in range(var.control_plane_count) :
    format("cp-%02d", i + 1) => {
      role       = "control-plane"
      cores      = var.control_plane_cores
      memory     = var.control_plane_memory
      attach_fip = i == 0 && !var.enable_vpn_gateway
    }
  }

  worker_nodes = {
    for i in range(var.worker_count) :
    format("worker-%02d", i + 1) => {
      role       = "worker"
      cores      = var.worker_cores
      memory     = var.worker_memory
      attach_fip = false
    }
  }

  cluster_nodes = merge(local.control_plane_nodes, local.worker_nodes)

  base_security_rules = [
    {
      direction = "egress"
      protocol  = "ANY"
      cidr      = "0.0.0.0/0"
    },
    {
      direction   = "ingress"
      protocol    = "TCP"
      from_port   = 22
      to_port     = 22
      cidr        = var.ssh_allowed_cidr
      description = "SSH"
    }
  ]

  vpn_security_rules = var.enable_vpn_gateway ? [
    {
      direction   = "ingress"
      protocol    = "TCP"
      from_port   = 22
      to_port     = 22
      cidr        = var.vpn_client_address
      description = "SSH from WireGuard client"
    }
  ] : []

  cluster_security_rules = concat(local.base_security_rules, local.vpn_security_rules)

  vpn_user_data = var.enable_vpn_gateway ? templatefile("${path.module}/templates/wireguard-cloudinit.tftpl", {
    vpn_server_address = var.vpn_server_address
    vpn_port           = var.vpn_port
    server_private_key = var.vpn_server_private_key
    client_public_key  = var.vpn_client_public_key
    vpn_client_address = var.vpn_client_address
  }) : null
}

module "network" {
  source = "../../modules/network-base"

  network_name           = var.network_name
  subnet_name            = var.subnet_name
  subnet_description     = var.subnet_description
  subnet_address         = var.subnet_address
  availability_zone_name = var.availability_zone_name
  fip_name               = var.fip_name
  enable_public_fip      = !var.enable_vpn_gateway
  enable_snat_gateway    = var.enable_snat_gateway
  snat_gateway_name      = var.snat_gateway_name
  snat_route_table_name  = var.snat_route_table_name
}

module "security" {
  source = "../../modules/security-base"

  name        = var.security_group_name
  description = var.security_group_description
  network_id  = module.network.network_id
  rules       = local.cluster_security_rules
}

resource "yandex_vpc_address" "vpn" {
  count = var.enable_vpn_gateway ? 1 : 0
  name  = var.vpn_fip_name

  external_ipv4_address {
    zone_id = var.availability_zone_name
  }
}

module "vpn_security" {
  count  = var.enable_vpn_gateway ? 1 : 0
  source = "../../modules/security-base"

  name        = var.vpn_security_group_name
  description = var.vpn_security_group_description
  network_id  = module.network.network_id
  rules = [
    {
      direction = "egress"
      protocol  = "ANY"
      cidr      = "0.0.0.0/0"
    },
    {
      direction   = "ingress"
      protocol    = "TCP"
      from_port   = 22
      to_port     = 22
      cidr        = var.ssh_allowed_cidr
      description = "SSH admin"
    },
    {
      direction   = "ingress"
      protocol    = "UDP"
      from_port   = var.vpn_port
      to_port     = var.vpn_port
      cidr        = "0.0.0.0/0"
      description = "WireGuard"
    }
  ]
}

module "vpn_gateway" {
  count  = var.enable_vpn_gateway ? 1 : 0
  source = "../../modules/vm-base"

  name                   = var.vpn_gateway_name
  description            = "VPN gateway (WireGuard)"
  platform_id            = var.platform_id
  cores                  = var.vpn_gateway_cores
  memory                 = var.vpn_gateway_memory
  availability_zone_name = var.availability_zone_name
  image_id               = data.yandex_compute_image.base.id
  host_name              = var.vpn_gateway_name
  user_name              = var.user_name
  public_key             = var.ssh_public_key
  boot_disk_name         = "${var.vpn_gateway_name}-disk"
  boot_disk_size         = var.vpn_gateway_boot_disk_size
  boot_disk_type         = var.boot_disk_type
  subnet_id              = module.network.subnet_id
  security_group_ids     = [module.vpn_security[0].id]
  nat_ip_address         = yandex_vpc_address.vpn[0].external_ipv4_address[0].address
  user_data              = local.vpn_user_data
}

module "nodes" {
  for_each = local.cluster_nodes
  source   = "../../modules/vm-base"

  name                   = "${var.cluster_name}-${each.key}"
  description            = "${var.cluster_name} ${each.value.role} node"
  platform_id            = var.platform_id
  cores                  = each.value.cores
  memory                 = each.value.memory
  availability_zone_name = var.availability_zone_name
  image_id               = data.yandex_compute_image.base.id
  host_name              = "${var.cluster_name}-${each.key}"
  user_name              = var.user_name
  public_key             = var.ssh_public_key
  boot_disk_name         = "${var.cluster_name}-${each.key}-disk"
  boot_disk_size         = var.boot_disk_size
  boot_disk_type         = var.boot_disk_type
  subnet_id              = module.network.subnet_id
  security_group_ids     = [module.security.id]
  nat_ip_address         = each.value.attach_fip ? module.network.fip_address : null
}
