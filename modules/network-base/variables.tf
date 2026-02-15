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

variable "default_gateway" {
  type        = string
  description = "Subnet default gateway."
}

variable "dns_servers" {
  type        = list(string)
  description = "DNS servers for subnet."
  default     = ["8.8.8.8"]
}

variable "routed_network" {
  type        = bool
  description = "Whether subnet is routed."
  default     = true
}

variable "fip_name" {
  type        = string
  description = "Floating IP name."
}

variable "fip_description" {
  type        = string
  description = "Floating IP description."
}

variable "enable_snat_gateway" {
  type        = bool
  description = "Create SNAT gateway for private subnet egress."
  default     = false
}

variable "snat_gateway_name" {
  type        = string
  description = "SNAT gateway name."
  default     = "snat-gateway"
}

variable "snat_gateway_description" {
  type        = string
  description = "SNAT gateway description."
  default     = "SNAT gateway"
}

variable "availability_zone_id" {
  type        = string
  description = "Availability zone ID (for example AZ1 ID)."
}

variable "project_id" {
  type        = string
  description = "Cloud.ru project ID."
}
