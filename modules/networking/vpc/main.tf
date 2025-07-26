##------------------------------------------------
## VPC module call
##------------------------------------------------
terraform {
  backend "s3" {}
}

module "vpc" {
  source      = "github.com/devops-homelab/homelab-terraform-modules.git//digitalocean/vpc/?ref=v3.2.0"
  name        = var.name
  environment = var.environment
  region      = var.region
  ip_range    = var.ip_range
}