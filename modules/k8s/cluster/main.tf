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

}

module "homelab_cluster_config" {
  source = "github.com/devops-homelab/homelab-terraform-modules.git//digitalocean/kubernetes/config/?ref=main"

  deploy_kong = {
    kong = {
      version          = "4.12.0"
      ingress_class    = "kong"
      ingress_controller = true
    }
  }
  
  # deploy_nginx_ingress = {
  #   nginx = {
  #     version          = "4.12.0"
  #   }
  # }

  deploy_cert_manager = {
    cert-manager = {  version = "1.17.1"  }
  }

  issuer_type = {
    type          = "cluster_issuer"
    email         = "navindushane@gmail.com"
    ingress_class = "kong"
  }

  deploy_argo_cd = {
    argo_cd = {
      version                 = "7.8.28"
      pat_token               = var.pat_token
      git_username            = var.git_username
      sso_client_id           = var.sso_client_id
      sso_client_secret       = var.sso_client_secret
    }
  }

  deploy_argo_rollouts = {
    argo_rollouts = {
      version                 = "2.39.0"
      argo_rollouts_url       = var.argo_rollouts_url
    }
  }

  enable_cluster_bootstrap     = var.enable_cluster_bootstrap
  enable_application_bootstrap = var.enable_application_bootstrap

  depends_on = [ module.homelab_cluster ]
}
