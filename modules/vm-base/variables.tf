variable "name" {
  type        = string
  description = "Compute instance name."
}

variable "description" {
  type        = string
  description = "Compute instance description."
}

variable "flavor_id" {
  type        = string
  description = "Flavor ID."
}

variable "availability_zone_name" {
  type        = string
  description = "Availability zone name (for example ru.AZ-1)."
}

variable "image_name" {
  type        = string
  description = "Image name (for example ubuntu-22.04)."
}

variable "host_name" {
  type        = string
  description = "Host name inside image block."
}

variable "user_name" {
  type        = string
  description = "User name inside image block."
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

variable "boot_disk_type_id" {
  type        = string
  description = "Boot disk type ID."
}

variable "subnet_name" {
  type        = string
  description = "Subnet name to attach interface."
}

variable "security_group_id" {
  type        = string
  description = "Security group ID for interface."
}

variable "fip_id" {
  type        = string
  description = "Floating IP ID for interface."
}
