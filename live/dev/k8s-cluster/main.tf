module "security" {
  source = "../../../modules/security-base"

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
  source = "../../../modules/network-base"

  subnet_name          = var.subnet_name
  subnet_description   = var.subnet_description
  subnet_address       = var.subnet_address
  default_gateway      = var.default_gateway
  routed_network       = true
  dns_servers          = ["8.8.8.8"]
  fip_name             = var.fip_name
  fip_description      = var.fip_description
  availability_zone_id = var.availability_zone_id
}

module "vm" {
  source = "../../../modules/vm-base"

  name                   = var.vm_name
  description            = var.vm_description
  flavor_id              = var.flavor_id
  availability_zone_name = var.availability_zone_name
  image_name             = var.image_name
  host_name              = var.host_name
  user_name              = var.user_name
  public_key             = var.ssh_public_key
  boot_disk_name         = var.boot_disk_name
  boot_disk_size         = var.boot_disk_size
  boot_disk_type_id      = var.boot_disk_type_id
  subnet_name            = module.network.subnet_name
  security_group_id      = module.security.id
  fip_id                 = module.network.fip_id
}
