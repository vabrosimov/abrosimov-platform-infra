variable "name" {
  type        = string
  description = "Security group name."
}

variable "description" {
  type        = string
  description = "Security group description."
}

variable "network_id" {
  type        = string
  description = "VPC network ID."
}

variable "rules" {
  type = list(object({
    direction   = string
    protocol    = string
    from_port   = optional(number)
    to_port     = optional(number)
    cidr        = string
    description = optional(string)
  }))
  description = "Security group rules."
}
