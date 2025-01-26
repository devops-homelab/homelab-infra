# ------------------------------------------------------------------------------
# Outputs
# ------------------------------------------------------------------------------
output "id" {
  value       = module.homelab_cluster[*].id
  description = "The id of Kubernetes cluster."
}