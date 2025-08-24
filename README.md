# Homelab Infrastructure

This repository contains the Infrastructure as Code (IaC) implementation for a production-ready homelab environment. Built with Terragrunt and modern Terraform modules, it deploys a complete cloud-native platform with Gateway API support, GitOps automation, and enterprise-grade security on DigitalOcean.

## Architecture Overview

The infrastructure is designed following cloud-native principles with modern Kubernetes networking:

- **Gateway API v1.0.0**: Next-generation Kubernetes networking with Kong
- **GitOps Workflow**: ArgoCD for declarative application deployment
- **Blue-Green Deployments**: Zero-downtime updates with Argo Rollouts
- **TLS Everywhere**: Automatic HTTPS certificates with cert-manager
- **Policy as Code**: Security governance with Kyverno
- **Observability**: Monitoring and alerting stack

## Repository Structure

```
live/
└── dev/
    ├── compute/
    │   └── terragrunt.hcl         # Kubernetes cluster configuration
    ├── data/
    │   └── database/
    │       └── terragrunt.hcl     # PostgreSQL database cluster
    ├── k8s/
    │   └── cluster/
    │       └── terragrunt.hcl     # Kubernetes control plane
    └── networking/
        └── vpc/
            └── terragrunt.hcl     # VPC and networking

modules/                           # Local Terraform modules
├── data/database/                 # Database module
├── k8s/cluster/                   # Kubernetes cluster module
└── networking/vpc/                # VPC networking module

terragrunt.hcl                     # Root Terragrunt configuration
config.env                         # Environment variables
```

## Infrastructure Components

### Networking Layer
- **DigitalOcean VPC**: Private networking with custom IP ranges
- **Load Balancers**: Kong ingress with Gateway API support
- **DNS Management**: Automatic DNS updates for services
- **Network Policies**: Micro-segmentation for security

### Compute Layer
- **DOKS Cluster**: Managed Kubernetes with auto-scaling node pools
- **Node Pools**: Separate pools for infrastructure and application workloads
- **Gateway API**: Modern traffic management with Kong
- **Container Registry**: DigitalOcean Container Registry integration

### Data Layer
- **PostgreSQL Cluster**: Managed database with high availability
- **Backup Strategy**: Automated backups with point-in-time recovery
- **Connection Pooling**: Optimized database connections
- **Security**: VPC-isolated database access

### Platform Services
- **ArgoCD**: GitOps continuous delivery platform
- **Argo Rollouts**: Progressive delivery and blue-green deployments
- **cert-manager**: Automatic TLS certificate management
- **Kyverno**: Policy engine for security and compliance
- **Reloader**: Automatic pod restarts on configuration changes

## Quick Start

### Prerequisites
- [Terragrunt](https://terragrunt.gruntwork.io/) v0.84.1+
- [Terraform](https://terraform.io/) v1.5.0+
- DigitalOcean API token
- kubectl for cluster access

### Environment Setup

1. **Clone the repository**:
```bash
git clone https://github.com/devops-homelab/homelab-infra.git
cd homelab-infra
```

2. **Configure environment variables**:
```bash
# Copy and edit the environment configuration
cp config.env.example config.env
# Edit config.env with your DigitalOcean token and other settings
```

3. **Deploy infrastructure**:
```bash
# Deploy VPC and networking
cd live/dev/networking/vpc
terragrunt apply

# Deploy database
cd ../../data/database
terragrunt apply

# Deploy Kubernetes cluster
cd ../../compute
terragrunt apply

# Configure Kubernetes applications
cd ../../k8s/cluster
terragrunt apply
```

### Verification

```bash
# Get cluster credentials
doctl kubernetes cluster kubeconfig save homelab-cluster

# Verify Gateway API components
kubectl get gatewayclasses
kubectl get gateways -A
kubectl get httproutes -A

# Check ArgoCD deployment
kubectl get applications -n argocd

# Verify TLS certificates
kubectl get certificates -A
```

## Gateway API Implementation

### Kong Gateway Controller
The infrastructure deploys Kong with Gateway API v1.0.0 support:

```hcl
deploy_kong = {
  dev = {
    version = "2.48.0"
    gateway_api_enabled = true
    additional_set = [
      {
        name  = "ingressController.gatewayAPI.enabled"
        value = "true"
      }
    ]
  }
}
```

### GatewayClass Configuration
Automatic creation of Kong GatewayClass:

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: GatewayClass
metadata:
  name: kong
spec:
  controllerName: "konghq.com/kic-gateway-controller"
```

### cert-manager Integration
TLS automation with Gateway API support:

```hcl
issuer_type = {
  type          = "cluster_issuer"
  ingress_class = "kong"
  email         = "admin@yourdomain.com"
}
```

## GitOps Configuration

### ArgoCD Bootstrap
The infrastructure automatically deploys ArgoCD with root applications:

```yaml
# Infrastructure bootstrap
spec:
  source:
    repoURL: "https://github.com/devops-homelab/homelab-argo-app-config.git"
    path: "infra"
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

### Application Deployment
Applications are managed through the App of Apps pattern:

```yaml
# Application bootstrap
spec:
  source:
    repoURL: "https://github.com/devops-homelab/homelab-argo-app-config.git"
    path: "apps"
```

## Security Features

### Policy Enforcement
Kyverno policies enforce security standards:
- Resource limits and requests
- Security contexts and capabilities
- Image security and vulnerability scanning
- Network policy enforcement

### Secret Management
Secure handling of sensitive data:
- Sealed Secrets for GitOps-safe secret storage
- External Secrets for cloud provider integration
- Automatic rotation and synchronization

### Network Security
- VPC isolation with private networking
- Network policies for pod-to-pod communication
- TLS encryption for all traffic
- Ingress security policies

## Monitoring & Observability

### Metrics Collection
- Prometheus for metrics aggregation
- Grafana for visualization and alerting
- ServiceMonitor configurations for application metrics

### Log Management
- Centralized logging with log aggregation
- Structured logging for better searchability
- Log retention and archival policies

### Distributed Tracing
- Jaeger for request tracing
- Service mesh integration
- Performance monitoring

## Backup & Disaster Recovery

### Database Backups
```hcl
backup_restore = {
  backup_hour   = 3
  backup_minute = 0
}
```

### Cluster Backup
- etcd snapshots and restoration
- Application state backup
- Configuration backup to Git

### Disaster Recovery Plan
- Multi-region deployment capability
- Recovery time objectives (RTO) < 4 hours
- Recovery point objectives (RPO) < 1 hour

## Cost Optimization

### Resource Management
- Auto-scaling node pools
- Resource quotas and limits
- Spot instance utilization where appropriate

### Monitoring
- Cost tracking and alerting
- Resource utilization dashboards
- Optimization recommendations

## Development Workflow

### Local Testing
```bash
# Validate Terraform configurations
cd modules/k8s/cluster
terraform validate
terraform plan

# Test Terragrunt configurations
cd live/dev/compute
terragrunt validate
terragrunt plan
```

### Staging Environment
- Parallel staging infrastructure
- Feature branch deployments
- Integration testing

### Production Deployment
- Blue-green deployment strategy
- Canary releases for critical changes
- Rollback procedures

## Troubleshooting

### Common Issues

**Terragrunt AWS SDK Compatibility**:
```bash
# Fixed in terragrunt.hcl with AWS SDK v2 support
terraform {
  extra_arguments "aws_sdk_v2" {
    commands = get_terraform_commands_that_need_vars()
    env_vars = {
      AWS_SDK_LOAD_CONFIG = "1"
    }
  }
}
```

**Gateway API Resources**:
```bash
# Check Gateway API CRDs
kubectl get crd | grep gateway

# Verify Kong controller
kubectl logs -n kong deployment/kong-controller
```

**Certificate Issues**:
```bash
# Check cert-manager logs
kubectl logs -n kube-system deployment/cert-manager

# Verify issuer status
kubectl describe clusterissuer letsencrypt-prod
```

## Migration Guide

### From Ingress to Gateway API
1. Deploy Gateway API alongside existing Ingress
2. Update application configurations gradually
3. Test traffic routing and TLS termination
4. Switch DNS to Gateway API endpoints
5. Remove deprecated Ingress resources

## Contributing

### Standards
- Follow Terraform best practices
- Include comprehensive documentation
- Add validation and testing
- Security-first approach

### Development Process
1. Create feature branch
2. Implement changes with tests
3. Validate with `terraform plan`
4. Submit pull request with documentation
5. Code review and approval
6. Merge and deploy

## License

This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

**Terragrunt Powered • Gateway API Ready • Production Tested**
