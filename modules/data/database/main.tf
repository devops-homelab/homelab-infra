##------------------------------------------------
## Database module call
##------------------------------------------------
terraform {
  backend "s3" {}
}

module "postgresql" {
  source                       = "github.com/devops-homelab/homelab-terraform-modules.git//digitalocean/database/?ref=v3.2.0"
  name                         = var.name
  environment                  = var.environment
  region                       = var.region
  cluster_engine               = var.cluster_engine
  cluster_version              = var.cluster_version
  cluster_size                 = var.cluster_size
  cluster_node_count           = var.cluster_node_count
  cluster_private_network_uuid = var.cluster_private_network_uuid

  cluster_maintenance = {
    maintenance_hour = var.maintenance_hour
    maintenance_day  = var.maintenance_day
  }
  
  databases = var.databases
  users     = var.users

  create_pools = var.create_pools
  pools        = var.pools

  create_firewall = var.create_firewall
  firewall_rules  = var.firewall_rules
}