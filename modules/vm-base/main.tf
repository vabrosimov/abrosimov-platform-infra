resource "cloudru_evolution_compute" "this" {
  name        = var.name
  flavor_id   = var.flavor_id
  description = var.description

  availability_zone {
    name = var.availability_zone_name
  }

  image {
    name       = var.image_name
    host_name  = var.host_name
    user_name  = var.user_name
    public_key = var.public_key
  }

  boot_disk {
    name = var.boot_disk_name
    size = var.boot_disk_size

    disk_type {
      id = var.boot_disk_type_id
    }
  }

  network_interfaces {
    subnet {
      name = var.subnet_name
    }

    security_groups {
      id = var.security_group_id
    }

    dynamic "fip" {
      for_each = var.fip_id == null ? [] : [var.fip_id]
      content {
        id = fip.value
      }
    }
  }
}
