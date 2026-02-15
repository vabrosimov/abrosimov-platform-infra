provider "cloudru" {
  project_id             = var.cloudru_project_id
  auth_key_id            = var.cloudru_auth_key_id
  auth_secret            = var.cloudru_auth_secret
  iam_endpoint           = var.cloudru_iam_endpoint
  k8s_endpoint           = var.cloudru_k8s_endpoint
  evolution_endpoint     = var.cloudru_evolution_endpoint
  cloudplatform_endpoint = var.cloudru_cloudplatform_endpoint
  dbaas_endpoint         = var.cloudru_dbaas_endpoint
}
