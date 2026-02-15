locals {
  control_plane_nodes = {
    for i in range(var.control_plane_count) :
    format("cp-%02d", i + 1) => {
      role       = "control-plane"
      flavor_id  = var.control_plane_flavor_id
      attach_fip = i == 0
    }
  }

  worker_nodes = {
    for i in range(var.worker_count) :
    format("worker-%02d", i + 1) => {
      role       = "worker"
      flavor_id  = var.worker_flavor_id
      attach_fip = false
    }
  }

  cluster_nodes = merge(local.control_plane_nodes, local.worker_nodes)
}

module "security" {
  source = "../../modules/security-base"

  project_id           = var.cloudru_project_id
  name                 = var.security_group_name
  description          = var.security_group_description
  availability_zone_id = var.availability_zone_id
  rules = [
    {
      direction        = "egress"
      ether_type       = "IPv6"
      ip_protocol      = "any"
      port_range       = "any"
      remote_ip_prefix = "::/0"
    },
    {
      direction        = "egress"
      ether_type       = "IPv4"
      ip_protocol      = "any"
      port_range       = "any"
      remote_ip_prefix = "0.0.0.0/0"
    },
    {
      direction        = "ingress"
      ether_type       = "IPv4"
      ip_protocol      = "tcp"
      port_range       = "22:22"
      remote_ip_prefix = var.ssh_allowed_cidr
      description      = "SSH"
    }
  ]
}

module "network" {
  source = "../../modules/network-base"

  project_id               = var.cloudru_project_id
  subnet_name              = var.subnet_name
  subnet_description       = var.subnet_description
  subnet_address           = var.subnet_address
  default_gateway          = var.default_gateway
  routed_network           = true
  dns_servers              = ["8.8.8.8"]
  fip_name                 = var.fip_name
  fip_description          = var.fip_description
  enable_snat_gateway      = var.enable_snat_gateway
  snat_gateway_name        = var.snat_gateway_name
  snat_gateway_description = var.snat_gateway_description
  availability_zone_id     = var.availability_zone_id
}

module "nodes" {
  for_each = local.cluster_nodes
  source   = "../../modules/vm-base"

  name                   = "${var.cluster_name}-${each.key}"
  description            = "${var.cluster_name} ${each.value.role} node"
  flavor_id              = each.value.flavor_id
  availability_zone_name = var.availability_zone_name
  image_name             = var.image_name
  host_name              = "${var.cluster_name}-${each.key}"
  user_name              = var.user_name
  public_key             = var.ssh_public_key
  boot_disk_name         = "${var.cluster_name}-${each.key}-disk"
  boot_disk_size         = var.boot_disk_size
  boot_disk_type_id      = var.boot_disk_type_id
  subnet_name            = module.network.subnet_name
  security_group_id      = module.security.id
  fip_id                 = each.value.attach_fip ? module.network.fip_id : null
}
