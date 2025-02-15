variable "name" {
  description = "The name of the Kubernetes cluster"
  type        = string
}

variable "environment" {
  description = "The environment for the Kubernetes cluster"
  type        = string
}

variable "region" {
  description = "The region where the Kubernetes cluster will be deployed"
  type        = string
}

variable "cluster_version" {
  description = "The version of the Kubernetes cluster"
  type        = string
}

variable "vpc_uuid" {
  description = "The UUID of the VPC"
  type        = string
}

# variable "infra_node_pool" {
#   description = "The configuration for the infra node pool"
#   type = map(object({
#     node_count = number
#     min_nodes  = number
#     max_nodes  = number
#     size       = string
#     labels     = map(string)
#     tags       = list(string)
#     taint = list(object({
#       key    = string
#       value  = string
#       effect = string
#     }))
#   }))
# }

variable "app_node_pool" {
  description = "The configuration for the app node pool"
  type = map(object({
    node_count = number
    min_nodes  = number
    max_nodes  = number
    size       = string
    labels     = map(string)
    tags       = list(string)
    taint      = optional(list(object({
      key    = string
      value  = string
      effect = string
    })), []) # ✅ Ensure taint is optional with an empty list as default
  }))
}