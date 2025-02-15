terraform {
  source = "${get_terragrunt_dir()}/../../../../modules/k8s//cluster"
}

include {
  path = find_in_parent_folders()
}

inputs = {
    name            = "homelab-k8s-cluster"
    environment     = "dev"
    region          = "sgp1"
    cluster_version = "1.32.1-do.0"
    vpc_uuid        = "d1a05ead-4618-4fb1-8024-7bdd06c2ef32"

    infra_node_pool = {
        infra_node = {
            node_count = 2
            min_nodes  = 2
            max_nodes  = 2
            size       = "s-2vcpu-2gb"
            labels     = { "cluster" = "infra" }
            tags       = ["homelab-k8s-cluster"]
        }
    }
}