
################################################################################
# Terraform Providers
################################################################################
# provider "kubectl" {
#   host                   = module.kube_cluster.cluster_endpoint
#   cluster_ca_certificate = base64decode(module.kube_cluster.cluster_certificate_authority_data)
#   exec {
#     api_version = "client.authentication.k8s.io/v1"
#     command     = "aws"
#     args        = ["eks", "get-token", "--cluster-name", module.kube_cluster.cluster_id]
#   }
# }

provider "helm" {
  kubernetes {
    host  = module.homelab_cluster.endpoint
    token = module.homelab_cluster.kube_config[0].token
    cluster_ca_certificate = base64decode(
      module.homelab_cluster.kube_config[0].cluster_ca_certificate
    )
  }
}