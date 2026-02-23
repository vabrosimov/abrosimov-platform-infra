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

variable "availability_zone_name" {
  type        = string
  description = "Availability zone name (for example ru-central1-a)."
}

variable "fip_name" {
  type        = string
  description = "Static public IP name."
}

variable "enable_public_fip" {
  type        = bool
  description = "Create public static IP for control-plane node."
  default     = true
}

variable "enable_snat_gateway" {
  type        = bool
  description = "Create SNAT gateway and route table for private egress."
  default     = false
}

variable "snat_gateway_name" {
  type        = string
  description = "SNAT gateway name."
  default     = "snat-gateway"
}

variable "snat_route_table_name" {
  type        = string
  description = "Route table name for SNAT default route."
  default     = "snat-route-table"
}
