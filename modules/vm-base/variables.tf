variable "name" {
  type        = string
  description = "Compute instance name."
}

variable "description" {
  type        = string
  description = "Compute instance description."
}

variable "platform_id" {
  type        = string
  description = "YC platform ID (for example standard-v3)."
  default     = "standard-v3"
}

variable "cores" {
  type        = number
  description = "vCPU count."
}

variable "memory" {
  type        = number
  description = "RAM size in GB."
}

variable "core_fraction" {
  type        = number
  description = "Guaranteed vCPU share percent."
  default     = 100
}

variable "availability_zone_name" {
  type        = string
  description = "Availability zone name (for example ru-central1-a)."
}

variable "image_id" {
  type        = string
  description = "YC image ID for boot disk initialization."
}

variable "host_name" {
  type        = string
  description = "Host name."
}

variable "user_name" {
  type        = string
  description = "Linux username for SSH access."
}

variable "public_key" {
  type        = string
  description = "SSH public key."
}

variable "boot_disk_name" {
  type        = string
  description = "Boot disk name."
}

variable "boot_disk_size" {
  type        = number
  description = "Boot disk size in GB."
}

variable "boot_disk_type" {
  type        = string
  description = "YC boot disk type (for example network-ssd)."
  default     = "network-ssd"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID to attach NIC."
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security group IDs for NIC."
}

variable "nat_ip_address" {
  type        = string
  description = "Static public IP for NIC NAT."
  default     = null
}
