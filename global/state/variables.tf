variable "state_bucket_name" {
  type        = string
  description = "Name of S3-compatible bucket used for Terraform remote state."
  default     = "abrosimov-platform-infra-tfstate-dev"
}

variable "state_region" {
  type        = string
  description = "Region for S3-compatible state backend."
  default     = "ru-moscow-1"
}

variable "state_endpoint" {
  type        = string
  description = "S3-compatible endpoint for state backend."
}

variable "state_access_key" {
  type        = string
  description = "Access key used by Terraform S3 backend."
  sensitive   = true
}

variable "state_secret_key" {
  type        = string
  description = "Secret key used by Terraform S3 backend."
  sensitive   = true
}

variable "environments" {
  type        = list(string)
  description = "Environments that will have isolated state keys."
  default     = ["dev", "stage", "prod"]
}

variable "stacks" {
  type        = list(string)
  description = "Infrastructure stacks with isolated state keys per environment."
  default     = ["k8s-cluster", "jenkins", "nexus"]
}
