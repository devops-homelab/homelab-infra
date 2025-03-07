variable "name" {
  description = "The name of the database cluster"
  type        = string
}

variable "environment" {
  description = "The environment for the database cluster"
  type        = string
}

variable "region" {
  description = "The region for the database cluster"
  type        = string
}

variable "cluster_engine" {
  description = "The database engine"
  type        = string
  default     = "pg"
}

variable "cluster_version" {
  description = "The version of the database engine"
  type        = string
  default     = "15"
}

variable "cluster_size" {
  description = "The size of the database cluster"
  type        = string
  default     = "db-s-1vcpu-1gb"
}

variable "cluster_node_count" {
  description = "The number of nodes in the database cluster"
  type        = number
  default     = 1
}

variable "cluster_private_network_uuid" {
  description = "The UUID of the private network"
  type        = string
}

variable "maintenance_hour" {
  description = "The hour for maintenance"
  type        = string
  default     = "02:00:00"
}

variable "maintenance_day" {
  description = "The day for maintenance"
  type        = string
  default     = "saturday"
}

variable "databases" {
  description = "List of databases to create"
  type        = list(string)
  default     = ["testdb"]
}

variable "users" {
  description = "List of users to create"
  type        = list(object({
    name = string
  }))
  default = [
    {
      name = "test"
    }
  ]
}

variable "create_pools" {
  description = "Whether to create connection pools"
  type        = bool
  default     = true
}

variable "pools" {
  description = "List of connection pools to create"
  type        = list(object({
    name    = string
    mode    = string
    size    = number
    db_name = string
    user    = string
  }))
  default = [
    {
      name    = "test"
      mode    = "transaction"
      size    = 10
      db_name = "testdb"
      user    = "test"
    }
  ]
}

variable "create_firewall" {
  description = "Whether to create a firewall"
  type        = bool
  default     = false
}

variable "firewall_rules" {
  description = "List of firewall rules"
  type        = list(object({
    type  = string
    value = string
  }))
  default = [
    {
      type  = "ip_addr"
      value = "0.0.0.0"
    }
  ]
}