include "live" {
  path   = find_in_parent_folders("live/terragrunt.hcl")
  expose = true
}

terraform {
  source = "../../..///stacks/k8s-cluster"

  extra_arguments "common_var_file" {
    commands  = get_terraform_commands_that_need_vars()
    arguments = ["-var-file=${get_terragrunt_dir()}/terraform.tfvars"]
  }

  extra_arguments "local_backend_credentials" {
    commands = ["init"]
    arguments = fileexists("${get_terragrunt_dir()}/backend.dev.local.hcl") ? [
      "-backend-config=${get_terragrunt_dir()}/backend.dev.local.hcl"
    ] : []
  }
}
