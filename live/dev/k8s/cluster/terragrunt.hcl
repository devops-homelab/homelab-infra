terraform {
  source = "${get_terragrunt_dir()}/../../../../modules/k8s//cluster"
}

include {
  path = find_in_parent_folders()
}

inputs = {
    name            = "homelab-k8s-cluster"
    enable_cluster_bootstrap = true
    enable_application_bootstrap = true
    argo_rollouts_url = "https://argo-rollouts.devopshomelab.live"
    environment     = "dev"
    region          = "sgp1"
    cluster_version = "1.33.1-do.1"
    vpc_uuid        = "d1a05ead-4618-4fb1-8024-7bdd06c2ef32"

    infra_node_pool = {
        infra_node = {
            node_count = 2
            min_nodes  = 2
            max_nodes  = 2
            size       = "s-2vcpu-4gb"
            labels     = { "cluster" = "infra" }
            tags       = ["homelab-k8s-cluster"]
        }
    }
}