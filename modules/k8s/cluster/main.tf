##------------------------------------------------
## Kubernetes module call
##------------------------------------------------
terraform {
  backend "s3" {}
}
module "homelab_cluster" {
  source          = "github.com/devops-homelab/homelab-terraform-modules.git//digitalocean/kubernetes/cluster/?ref=main"
  name            = var.name
  environment     = var.environment
  region          = var.region
  cluster_version = var.cluster_version
  vpc_uuid        = var.vpc_uuid

  infra_node_pool = var.infra_node_pool

  # app_node_pool = var.app_node_pool
}

module "homelab_cluster_config" {
  source = "github.com/devops-homelab/homelab-terraform-modules.git//digitalocean/kubernetes/config/?ref=main"
  
  deploy_nginx_ingress = {
    nginx = {
      version          = "4.12.0"
    }
  }
  depends_on = [ module.homelab_cluster ]
}
