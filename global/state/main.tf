locals {
  # Canonical S3 backend settings reused by all stacks.
  backend_common = {
    bucket = var.state_bucket_name
    region = var.state_region

    endpoint = var.state_endpoint
    encrypt  = true

    access_key = var.state_access_key
    secret_key = var.state_secret_key

    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    force_path_style            = true
  }

  # Full map of stack state keys by environment.
  state_keys = {
    for pair in setproduct(var.environments, var.stacks) :
    "${pair[0]}/${pair[1]}" => "live/${pair[0]}/${pair[1]}/terraform.tfstate"
  }

  backend_by_stack = {
    for k, key in local.state_keys :
    k => merge(local.backend_common, { key = key })
  }
}
