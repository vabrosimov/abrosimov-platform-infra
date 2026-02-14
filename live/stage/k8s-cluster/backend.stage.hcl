bucket  = "abrosimov-platform-infra-tfstate-dev"
key     = "live/stage/k8s-cluster/terraform.tfstate"
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
