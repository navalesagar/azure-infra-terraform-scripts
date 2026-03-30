# azure-infra-terraform-scripts

This repository contains Terraform scripts to provision Azure infrastructure including:

- Resource Group
- Virtual Network and Subnet
- Network Security Group (allowing SSH)
- Ubuntu Virtual Machine (with sufficient RAM for Jenkins and SonarQube)
- Azure Container Registry

## Prerequisites

- Azure CLI installed and authenticated (`az login`)
- Terraform installed (v1.0+)

## Usage

1. Clone this repository.

2. Initialize Terraform:
   ```
   terraform init
   ```

3. Review the plan:
   ```
   terraform plan
   ```

4. Apply the configuration:
   ```
   terraform apply
   ```

5. After deployment, you can SSH into the VM using the public IP output.

## Variables

You can customize the deployment by modifying variables in `variables.tf`:

- `resource_group_name`: Name of the resource group
- `location`: Azure region
- `vm_size`: VM size (default: Standard_DS2_v2 with 7GB RAM)
- `admin_username`: VM admin username
- `admin_password`: VM admin password (change this!)
- `acr_name`: Name of the ACR

## Outputs

After `terraform apply`, the following outputs will be displayed:

- `resource_group_name`
- `vm_public_ip`: Public IP to SSH into the VM
- `acr_login_server`: ACR login server URL
- `acr_admin_username` and `acr_admin_password`: Credentials for ACR

## Cleanup

To destroy the resources:
```
terraform destroy
```