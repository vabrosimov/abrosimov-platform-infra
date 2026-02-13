variable "name" {
  type        = string
  description = "Security group name."
}

variable "description" {
  type        = string
  description = "Security group description."
}

variable "availability_zone_id" {
  type        = string
  description = "Availability zone ID (for example AZ1 ID)."
}

variable "rules" {
  type = list(object({
    direction        = string
    ether_type       = string
    ip_protocol      = string
    port_range       = string
    remote_ip_prefix = string
    description      = optional(string)
  }))
  description = "Security group rules."
}
