terraform {
  source = "${get_terragrunt_dir()}/../../../../modules/data//database"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name                         = "homelab-postgresql-db-cluster"
  environment                  = "dev"
  region                       = "sgp1"
  cluster_engine               = "pg"
  cluster_version              = "17"
  cluster_size                 = "db-s-1vcpu-1gb"
  cluster_node_count           = 1
  cluster_private_network_uuid = "d1a05ead-4618-4fb1-8024-7bdd06c2ef32"
  maintenance_hour             = "02:00:00"
  maintenance_day              = "saturday"
  databases                    = ["homelab"]
  users = [
    {
      name = "homelab-user"
    }
  ]
  create_pools = false
  # pools = [
  #   {
  #     name    = "test"
  #     mode    = "transaction"
  #     size    = 10
  #     db_name = "testdb"
  #     user    = "test"
  #   }
  # ]
  create_firewall = false
  firewall_rules = [
    {
      type  = "ip_addr"
      value = "0.0.0.0"
    }
  ]
}