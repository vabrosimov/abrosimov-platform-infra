locals {
  # Expected path at stack level: <environment>/<stack>
  relative_path = path_relative_to_include()
  path_parts    = split("/", local.relative_path)

  environment = length(local.path_parts) > 0 ? local.path_parts[0] : ""
  stack       = length(local.path_parts) > 1 ? local.path_parts[1] : ""
}

terraform {
  extra_arguments "common_cli_args" {
    commands = get_terraform_commands_that_need_vars()

    arguments = [
      "-compact-warnings"
    ]
  }
}

remote_state {
  backend = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket  = "abrosimov-platform-infra-tfstate-${local.environment}"
    key     = "live/${local.relative_path}/terraform.tfstate"
    region  = "ru-central-1"
    encrypt = false

    endpoints = {
      s3 = "https://s3.cloud.ru"
    }

    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    use_path_style              = true
  }
}

inputs = merge(
  {
    environment = local.environment
  },
  local.stack != "" ? { stack = local.stack } : {}
)
