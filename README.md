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

## Usage

1. Clone this repository.

2. Generate SSH key pair (if not already done):
   ```
   ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
   ```

3. Update the appropriate `.tfvars` file with your SSH public key:
   ```
   ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC..."
   ```

4. Initialize Terraform:
   ```
   terraform init
   ```

5. Review the plan for your environment:
   ```
   terraform plan -var-file=dev.tfvars
   ```

6. Apply the configuration:
   ```
   terraform apply -var-file=dev.tfvars
   ```

7. After deployment, you can:
   - SSH into the VM using the public IP output
   - Access ACR using the login server and credentials
   - Connect to AKS using `az aks get-credentials --resource-group <rg> --name <cluster>`

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

## Cleanup

To destroy the resources:
```
terraform destroy
```