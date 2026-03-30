variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "my-terraform-rg"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "vm_size" {
  description = "Size of the VM (CIS: Sufficient RAM for Jenkins/SonarQube)"
  type        = string
  default     = "Standard_DS2_v2"  # 2 vCPUs, 7GB RAM
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key" {
  description = "SSH public key for VM authentication (CIS: Use key-based auth)"
  type        = string
  # Generate with: ssh-keygen -t rsa -b 4096
}

variable "acr_name" {
  description = "Name of the Azure Container Registry"
  type        = string
  default     = "myacrterraform"
}

variable "acr_sku" {
  description = "SKU for ACR"
  type        = string
  default     = "Premium"
}

variable "ssh_source_address_prefix" {
  description = "Source IP for SSH access (CIS: Restrict to specific IPs)"
  type        = string
  default     = "*"  # Change to your IP for security
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {
    Environment = "Dev"
    Project     = "Jenkins-SonarQube"
  }
}