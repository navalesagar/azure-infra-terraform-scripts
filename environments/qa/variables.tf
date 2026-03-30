variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "qa-terraform-rg"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "vm_size" {
  description = "Size of the VM (CIS: Sufficient RAM for Jenkins/SonarQube)"
  type        = string
  default     = "Standard_DS2_v2"  # 2 vCPUs, 7GB RAM for QA
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key" {
  description = "SSH public key for VM authentication (CIS: Use key-based auth)"
  type        = string
}

variable "acr_name" {
  description = "Name of the Azure Container Registry"
  type        = string
  default     = "qaacrterraform"
}

variable "acr_sku" {
  description = "SKU for ACR"
  type        = string
  default     = "Standard"
}

variable "ssh_source_address_prefix" {
  description = "Source IP for SSH access (CIS: Restrict to specific IPs)"
  type        = string
  default     = "10.0.0.0/8"  # Restrict to internal network
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {
    Environment = "QA"
    Project     = "Jenkins-SonarQube"
  }
}

# AKS Variables
variable "aks_cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
  default     = "qa-aks-cluster"
}

variable "aks_node_count" {
  description = "Number of nodes in AKS default pool"
  type        = number
  default     = 2
}

variable "aks_vm_size" {
  description = "VM size for AKS nodes"
  type        = string
  default     = "Standard_DS2_v2"
}

# PostgreSQL Variables
variable "postgresql_server_name" {
  description = "Name of the PostgreSQL server"
  type        = string
  default     = "qa-postgresql-server"
}

variable "postgresql_admin_password" {
  description = "Administrator password for PostgreSQL"
  type        = string
  sensitive   = true
  default     = "P@ssw0rd123!"  # Change this!
}

variable "postgresql_sku" {
  description = "SKU for PostgreSQL server"
  type        = string
  default     = "B_Gen5_2"
}

# Redis Variables
variable "redis_name" {
  description = "Name of the Redis cache"
  type        = string
  default     = "qa-redis-cache"
}

variable "redis_sku" {
  description = "SKU for Redis cache"
  type        = string
  default     = "Standard"
}