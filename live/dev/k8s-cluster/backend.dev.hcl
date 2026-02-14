bucket = "abrosimov-platform-infra-tfstate-dev"
key    = "live/dev/k8s-cluster/terraform.tfstate"
region = "ru-central-1"
encrypt = false

# Set your Object Storage S3-compatible endpoint.
# Example format: https://<s3-endpoint>
endpoints = {
  s3 = "https://s3.cloud.ru"
}

# Required for non-AWS S3-compatible backends.
skip_credentials_validation = true
skip_metadata_api_check     = true
skip_region_validation      = true
skip_requesting_account_id  = true
use_path_style              = true
