# Homelab Infrastructure

This repository contains the infrastructure as code (IaC) for setting up and managing a Kubernetes cluster and related resources for a homelab environment. The infrastructure is defined using HashiCorp Configuration Language (HCL) and managed with Terraform.

## Overview

The repository is organized into several modules, each responsible for a specific component of the infrastructure:

- **Database**: PostgreSQL database setup using DigitalOcean managed databases.
- **Kubernetes Cluster**: Kubernetes cluster setup on DigitalOcean.
- **Networking**: Virtual Private Cloud (VPC) setup for networking.

## Modules

### Database Module

The database module configures a PostgreSQL database with the following features:

- Engine and version configuration
- Cluster size and node count
- Maintenance settings
- Firewall rules

### Kubernetes Cluster Module

The Kubernetes cluster module sets up a Kubernetes cluster with the following features:

- Cluster version and VPC configuration
- Nginx Ingress Controller
- Cert Manager for SSL certificates
- Argo CD for GitOps continuous delivery
- Argo Rollouts for progressive delivery

### Networking Module

The networking module configures a VPC with the following features:

- Region and IP range configuration

## Getting Started

To get started with this repository, follow these steps:

1. Clone the repository:
   \```bash
   git clone https://github.com/devops-homelab/homelab-infra.git
   cd homelab-infra
   \```

2. Initialize Terraform:
   \```bash
   terraform init
   \```

3. Apply the configuration:
   \```bash
   terraform apply
   \```

## Contributing

Contributions are welcome! Please open an issue or submit a pull request.

## License

This project is licensed under the MIT License.
