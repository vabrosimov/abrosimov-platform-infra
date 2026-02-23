resource "yandex_compute_instance" "this" {
  name        = var.name
  hostname    = var.host_name
  description = var.description
  zone        = var.availability_zone_name
  platform_id = var.platform_id

  resources {
    core_fraction = var.core_fraction
    cores         = var.cores
    memory        = var.memory
  }

  scheduling_policy {
    preemptible = false
  }

  boot_disk {
    auto_delete = true

    initialize_params {
      name     = var.boot_disk_name
      image_id = var.image_id
      size     = var.boot_disk_size
      type     = var.boot_disk_type
    }
  }

  network_interface {
    subnet_id          = var.subnet_id
    security_group_ids = var.security_group_ids
    nat                = var.nat_ip_address != null
    nat_ip_address     = var.nat_ip_address
  }

  metadata = {
    ssh-keys = "${var.user_name}:${var.public_key}"
  }
}
