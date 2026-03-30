# azure-infra-terraform-scripts

This repository contains Terraform scripts to provision Azure infrastructure including:

- Resource Group
- Virtual Network and Subnet
- Network Security Group (allowing SSH, Jenkins, and SonarQube ports)
- Ubuntu Virtual Machine (with sufficient RAM for Jenkins and SonarQube)
- Azure Container Registry (Premium SKU)
- Azure Kubernetes Service (AKS) cluster
- Azure Database for PostgreSQL
- Azure Cache for Redis

All modules follow CIS Benchmark best practices for Azure security.

## Prerequisites

- Azure CLI installed and authenticated (`az login`)
- Terraform installed (v1.0+)
- SSH public key for VM authentication

## Environment-Based Folder Structure

This repository uses a folder-based approach for environment management:

```
environments/
├── dev/           # Development environment
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars
├── qa/            # QA environment
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars
└── prod/          # Production environment
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
    └── terraform.tfvars

modules/           # Shared Terraform modules
└── ...
```

Each environment folder contains:
- **main.tf**: Module calls and provider configuration
- **variables.tf**: Environment-specific variable definitions
- **outputs.tf**: Output definitions
- **terraform.tfvars**: Variable values (add your SSH key here)

## Usage

### Deploy Development Environment

```bash
cd environments/dev
terraform init
terraform plan
terraform apply
```

### Deploy QA Environment

```bash
cd environments/qa
terraform init
terraform plan
terraform apply
```

### Deploy Production Environment

```bash
cd environments/prod
terraform init
terraform plan
terraform apply
```

### Backend Setup

Before deploying any environment, ensure the backend resources exist:

```bash
# From root directory
terraform apply -target=azurerm_resource_group.backend_rg \
                -target=azurerm_storage_account.backend_storage \
                -target=azurerm_storage_container.backend_container_dev \
                -target=azurerm_storage_container.backend_container_qa \
                -target=azurerm_storage_container.backend_container_prod
```

## Environments

The repository includes environment-specific variable files:

- `dev.tfvars`: Development environment with minimal resources
- `qa.tfvars`: QA environment with medium resources and restricted access
- `prod.tfvars`: Production environment with high availability and security

Use the appropriate file with `-var-file` flag:

```bash
terraform plan -var-file=dev.tfvars
terraform apply -var-file=prod.tfvars
```

## Variables

You can customize the deployment by modifying variables in `variables.tf` or override them using `.tfvars` files:

- `resource_group_name`: Name of the resource group
- `location`: Azure region
- `vm_size`: VM size for the Ubuntu server
- `ssh_public_key`: Your SSH public key
- `acr_name`: Name of the ACR
- `aks_cluster_name`: Name of the AKS cluster
- `aks_node_count`: Number of nodes in AKS
- `ssh_source_address_prefix`: Restrict SSH access (default: open, change to your IP)

## Outputs

After `terraform apply`, the following outputs will be displayed:

- `resource_group_name`
- `vm_public_ip`: Public IP to SSH into the VM
- `acr_login_server`: ACR login server URL
- `acr_admin_username` and `acr_admin_password`: Credentials for ACR
- `aks_cluster_name`: Name of the AKS cluster
- `aks_kube_config`: Kubeconfig for AKS (sensitive)
- `postgresql_server_fqdn`: PostgreSQL server FQDN
- `postgresql_admin_login` and `postgresql_admin_password`: PostgreSQL credentials
- `redis_hostname` and `redis_ssl_port`: Redis connection details
- `redis_primary_access_key`: Redis access key (sensitive)

## Modules

The configuration is organized into reusable modules:

- `modules/resource_group`: Manages the Azure Resource Group
- `modules/networking`: VNet, Subnet, and NSG with security rules
- `modules/vm`: Ubuntu VM with SSH key authentication and boot diagnostics
- `modules/acr`: Azure Container Registry with Premium SKU
- `modules/aks`: AKS cluster with CIS-compliant settings
- `modules/postgresql`: Azure Database for PostgreSQL with SSL enforcement
- `modules/redis`: Azure Cache for Redis with TLS 1.2 minimum

## Security Best Practices (CIS Benchmarks)

- SSH key-based authentication (no passwords)
- Managed disks for VMs and AKS
- RBAC enabled on AKS
- System-assigned managed identity for AKS
- Network isolation using VNet integration
- Boot diagnostics enabled
- Premium ACR SKU for advanced security

## Remote Backend Setup

This configuration uses Azure Storage Account as remote backend for state management and locking.

### Initial Setup

1. **Create backend resources** (run once):
   ```bash
   # Ensure all backend-*.tf files have commented backend blocks
   terraform init
   terraform apply -target=azurerm_resource_group.backend_rg -target=azurerm_storage_account.backend_storage -target=azurerm_storage_container.backend_container -target=azurerm_storage_container.backend_container_dev -target=azurerm_storage_container.backend_container_qa -target=azurerm_storage_container.backend_container_prod
   ```

2. **Configure remote backend for your environment**:
   ```bash
   # For dev environment:
   # Uncomment the backend block in backend-dev.tf
   terraform init  # This will migrate state to remote backend

   # For qa:
   # Uncomment the backend block in backend-qa.tf
   terraform init

   # For prod:
   # Uncomment the backend block in backend-prod.tf
   terraform init
   ```

### Backend Features

- **State Storage**: Terraform state stored securely in Azure Storage
- **State Locking**: Automatic locking using Azure blob leases (prevents concurrent modifications)
- **State Versioning**: Blob versioning enabled for state history
- **Access Control**: Private container with RBAC permissions
- **Environment Isolation**: Separate containers for dev/qa/prod

### Security Considerations

- Use separate storage account for backend
- Enable blob versioning for state recovery
- Restrict access using storage account firewalls
- Use Azure AD authentication for backend access
- Each environment has isolated state