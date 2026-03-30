variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "dev-terraform-rg"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "vm_size" {
  description = "Size of the VM (CIS: Sufficient RAM for Jenkins/SonarQube)"
  type        = string
  default     = "Standard_DS1_v2"  # 1 vCPU, 3.5GB RAM for dev
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
  default     = "devacrterraform"
}

variable "acr_sku" {
  description = "SKU for ACR"
  type        = string
  default     = "Basic"
}

variable "ssh_source_address_prefix" {
  description = "Source IP for SSH access (CIS: Restrict to specific IPs)"
  type        = string
  default     = "*"  # Open for dev, restrict in prod
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {
    Environment = "Dev"
    Project     = "Jenkins-SonarQube"
  }
}

# AKS Variables
variable "aks_cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
  default     = "dev-aks-cluster"
}

variable "aks_node_count" {
  description = "Number of nodes in AKS default pool"
  type        = number
  default     = 1
}

variable "aks_vm_size" {
  description = "VM size for AKS nodes"
  type        = string
  default     = "Standard_DS1_v2"
}

# PostgreSQL Variables
variable "postgresql_server_name" {
  description = "Name of the PostgreSQL server"
  type        = string
  default     = "dev-postgresql-server"
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
  default     = "B_Gen5_1"
}

# Redis Variables
variable "redis_name" {
  description = "Name of the Redis cache"
  type        = string
  default     = "dev-redis-cache"
}

variable "redis_sku" {
  description = "SKU for Redis cache"
  type        = string
  default     = "Basic"
}