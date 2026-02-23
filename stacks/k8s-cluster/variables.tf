variable "yandex_cloud_id" {
  type        = string
  description = "Yandex Cloud ID."
}

variable "yandex_folder_id" {
  type        = string
  description = "Yandex Folder ID."
}

variable "yandex_service_account_key_file" {
  type        = string
  description = "Path to authorized key JSON for service account."
}

variable "cluster_name" {
  type        = string
  description = "Cluster name prefix for nodes."
}

variable "availability_zone_name" {
  type        = string
  description = "Availability zone name (for example ru-central1-a)."
}

variable "ssh_allowed_cidr" {
  type        = string
  description = "CIDR allowed to access SSH."
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key for VM metadata."
}

variable "control_plane_count" {
  type        = number
  description = "Number of control-plane nodes."
}

variable "worker_count" {
  type        = number
  description = "Number of worker nodes."
}

variable "platform_id" {
  type        = string
  description = "YC compute platform ID."
}

variable "control_plane_cores" {
  type        = number
  description = "vCPU count for control-plane nodes."
}

variable "control_plane_memory" {
  type        = number
  description = "RAM (GB) for control-plane nodes."
}

variable "worker_cores" {
  type        = number
  description = "vCPU count for worker nodes."
}

variable "worker_memory" {
  type        = number
  description = "RAM (GB) for worker nodes."
}

variable "network_name" {
  type        = string
  description = "VPC network name."
}

variable "subnet_name" {
  type        = string
  description = "Subnet name."
}

variable "subnet_description" {
  type        = string
  description = "Subnet description."
}

variable "subnet_address" {
  type        = string
  description = "Subnet CIDR."
}

variable "fip_name" {
  type        = string
  description = "Static public IP name."
}

variable "enable_snat_gateway" {
  type        = bool
  description = "Enable SNAT gateway for private subnet egress."
}

variable "snat_gateway_name" {
  type        = string
  description = "SNAT gateway name."
}

variable "snat_route_table_name" {
  type        = string
  description = "SNAT route table name."
}

variable "security_group_name" {
  type        = string
  description = "Security group name."
}

variable "security_group_description" {
  type        = string
  description = "Security group description."
}

variable "image_family" {
  type        = string
  description = "Image family for VM boot disks."
}

variable "user_name" {
  type        = string
  description = "User name in VM metadata SSH keys."
}

variable "boot_disk_size" {
  type        = number
  description = "Boot disk size GB."
}

variable "boot_disk_type" {
  type        = string
  description = "Boot disk type."
}
