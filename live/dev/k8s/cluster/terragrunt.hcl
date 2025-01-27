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
    cluster_version = "1.31.1-do.5"
    vpc_uuid        = "d1a05ead-4618-4fb1-8024-7bdd06c2ef32"

    infra_node_pool = {
    infra_node = {
        node_count = 1
        min_nodes  = 1
        max_nodes  = 1
        size       = "s-1vcpu-2gb"
        labels     = { "cluster" = "infra" }
        tags       = ["homelab-k8s-cluster"]
        taint = [
        {
            key    = "dedicated"
            value  = "infra"
            effect = "NoSchedule"
        }
        ]
    }
    }

    app_node_pool = {
    app_node = {
        node_count = 0
        min_nodes  = 0
        max_nodes  = 0
        size       = "s-1vcpu-2gb"
        labels     = { "cluster" = "app" }
        tags       = ["homelab-k8s-cluster"]
        taint = [
        {
            key    = "dedicated"
            value  = "app"
            effect = "NoSchedule"
        }
        ]
    }
    }
}