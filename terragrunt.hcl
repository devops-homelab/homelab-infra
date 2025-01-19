# Define remote state configuration for DigitalOcean Spaces
remote_state {

   backend =  "s3"

   config = {
        bucket         = "homelab-terraform-state"
        key            = "${path_relative_to_include()}/terraform.tfstate"
        region         = "us-east-1"
        endpoints = {
            s3 = "https://sgp1.digitaloceanspaces.com"
        }
        encrypt        = true
        skip_credentials_validation = true
        skip_requesting_account_id  = true
        skip_metadata_api_check     = true
        skip_region_validation      = true
        skip_s3_checksum            = true

    }

}
