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
      attach_fip = i == 0
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
}

module "network" {
  source = "../../modules/network-base"

  network_name           = var.network_name
  subnet_name            = var.subnet_name
  subnet_description     = var.subnet_description
  subnet_address         = var.subnet_address
  availability_zone_name = var.availability_zone_name
  fip_name               = var.fip_name
  enable_snat_gateway    = var.enable_snat_gateway
  snat_gateway_name      = var.snat_gateway_name
  snat_route_table_name  = var.snat_route_table_name
}

module "security" {
  source = "../../modules/security-base"

  name        = var.security_group_name
  description = var.security_group_description
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
      description = "SSH"
    }
  ]
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
