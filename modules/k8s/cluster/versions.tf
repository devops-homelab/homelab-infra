
################################################################################
# Terraform Providers
################################################################################
provider "kubernetes" {
    host  = module.homelab_cluster.endpoint[0]
    token = module.homelab_cluster.token[0]
    cluster_ca_certificate = base64decode(
      module.homelab_cluster.cluster_ca_certificate[0]
    )
}

provider "helm" {
  kubernetes {
    host  = module.homelab_cluster.endpoint[0]
    token = module.homelab_cluster.token[0]
    cluster_ca_certificate = base64decode(
      module.homelab_cluster.cluster_ca_certificate[0]
    )
  }
}

provider "kubectl" {
  host                   = module.homelab_cluster.endpoint[0]
  cluster_ca_certificate = base64decode(module.homelab_cluster.cluster_ca_certificate[0])
  token                  = module.homelab_cluster.token[0]
  load_config_file       = false
}
