variable "cloudru_project_id" {
  type        = string
  description = "Cloud.ru project ID."
}

variable "cloudru_auth_key_id" {
  type        = string
  description = "Cloud.ru API Key ID (login)."
}

variable "cloudru_auth_secret" {
  type        = string
  description = "Cloud.ru API Key Secret (password)."
  sensitive   = true
}

variable "cloudru_iam_endpoint" {
  type        = string
  description = "IAM endpoint."
  default     = "iam.api.cloud.ru:443"
}

variable "cloudru_k8s_endpoint" {
  type        = string
  description = "K8s endpoint."
  default     = "mk8s.api.cloud.ru:443"
}

variable "cloudru_evolution_endpoint" {
  type        = string
  description = "Evolution endpoint."
  default     = "https://compute.api.cloud.ru"
}

variable "cloudru_cloudplatform_endpoint" {
  type        = string
  description = "Cloudplatform endpoint."
  default     = "organization.api.cloud.ru:443"
}

variable "cloudru_dbaas_endpoint" {
  type        = string
  description = "DBaaS endpoint."
  default     = "dbaas.api.cloud.ru:443"
}

variable "availability_zone_id" {
  type        = string
  description = "Availability zone ID."
  default     = "7c99a597-8516-494f-a2c7-d7377048681e"
}

variable "availability_zone_name" {
  type        = string
  description = "Availability zone name."
  default     = "ru.AZ-1"
}

variable "ssh_allowed_cidr" {
  type        = string
  description = "CIDR allowed to access SSH."
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key for VM image block."
}

variable "subnet_name" {
  type        = string
  description = "Subnet name."
  default     = "dev-k8s-subnet"
}

variable "subnet_description" {
  type        = string
  description = "Subnet description."
  default     = "DEV subnet for k8s VM test"
}

variable "subnet_address" {
  type        = string
  description = "Subnet address."
  default     = "10.10.2.0/24"
}

variable "default_gateway" {
  type        = string
  description = "Subnet default gateway."
  default     = "10.10.2.1"
}

variable "fip_name" {
  type        = string
  description = "Floating IP name."
  default     = "dev-k8s-fip"
}

variable "fip_description" {
  type        = string
  description = "Floating IP description."
  default     = "Floating IP for dev k8s VM"
}

variable "security_group_name" {
  type        = string
  description = "Security group name."
  default     = "dev-k8s-sg"
}

variable "security_group_description" {
  type        = string
  description = "Security group description."
  default     = "Security group for dev k8s VM"
}

variable "vm_name" {
  type        = string
  description = "Compute VM name."
  default     = "dev-k8s-vm-01"
}

variable "vm_description" {
  type        = string
  description = "Compute VM description."
  default     = "DEV VM for k8s validation"
}

variable "flavor_id" {
  type        = string
  description = "Flavor ID."
  default     = "22c9e630-2e31-4792-91d5-bc095386836d"
}

variable "image_name" {
  type        = string
  description = "Image name."
  default     = "ubuntu-22.04"
}

variable "host_name" {
  type        = string
  description = "Host name in image settings."
  default     = "dev-k8s-host"
}

variable "user_name" {
  type        = string
  description = "User name in image settings."
  default     = "dev-k8s-user"
}

variable "boot_disk_name" {
  type        = string
  description = "Boot disk name."
  default     = "dev-k8s-disk"
}

variable "boot_disk_size" {
  type        = number
  description = "Boot disk size GB."
  default     = 10
}

variable "boot_disk_type_id" {
  type        = string
  description = "Boot disk type ID."
  default     = "a859e3dc-6b14-42a8-9bcc-890fde0ba6d0"
}
