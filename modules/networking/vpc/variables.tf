variable "name" {
  description = "The name of the VPC"
  type        = string
}

variable "environment" {
  description = "The environment for the VPC (e.g., dev, staging, prod)"
  type        = string
}

variable "region" {
  description = "The region where the VPC will be created"
  type        = string
}

variable "ip_range" {
  description = "The IP range for the VPC"
  type        = string
}