# Terragrunt configuration
remote_state {
  backend = "s3"

  config = {
    bucket                      = "homelab-terraform-state"
    key                         = "${path_relative_to_include()}/terraform.tfstate"
    endpoint                    = "https://sgp1.digitaloceanspaces.com"
    use_path_style              = true  # New AWS SDK v2 parameter (replaces force_path_style)
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_s3_checksum            = true
    disable_bucket_update       = true
    region                      = "us-east-1"
  }
}