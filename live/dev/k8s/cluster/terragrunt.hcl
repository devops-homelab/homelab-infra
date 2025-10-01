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
    cluster_version = "1.31.9-do.4"
    vpc_uuid        = "d1a05ead-4618-4fb1-8024-7bdd06c2ef32"

    infra_node_pool = {
        infra_node = {
            node_count = 3
            min_nodes  = 3
            max_nodes  = 3
            size       = "s-4vcpu-8gb"
            labels     = { "cluster" = "infra" }
            tags       = ["homelab-k8s-cluster"]
        }
    }
}
