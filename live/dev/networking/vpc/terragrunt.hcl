terraform {
  source = "${get_terragrunt_dir()}/../../../../modules/networking//vpc"
}

include {
  path = find_in_parent_folders()
}

inputs = {
    name        = "homelab-vpc"
    environment = "dev"
    region      = "sgp1"
    ip_range    = "10.10.0.0/16"
}