variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "prod-terraform-rg"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US 2"  # Different region for prod
}

variable "vm_size" {
  description = "Size of the VM (CIS: Sufficient RAM for Jenkins/SonarQube)"
  type        = string
  default     = "Standard_DS3_v2"  # 4 vCPUs, 14GB RAM for prod
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
  default     = "prodacrterraform"
}

variable "acr_sku" {
  description = "SKU for ACR"
  type        = string
  default     = "Premium"
}

variable "ssh_source_address_prefix" {
  description = "Source IP for SSH access (CIS: Restrict to specific IPs)"
  type        = string
  default     = "203.0.113.0/24"  # Example: restrict to specific IP range
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {
    Environment = "Prod"
    Project     = "Jenkins-SonarQube"
    CostCenter  = "IT"
  }
}

# AKS Variables
variable "aks_cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
  default     = "prod-aks-cluster"
}

variable "aks_node_count" {
  description = "Number of nodes in AKS default pool"
  type        = number
  default     = 3
}

variable "aks_vm_size" {
  description = "VM size for AKS nodes"
  type        = string
  default     = "Standard_DS3_v2"
}

# PostgreSQL Variables
variable "postgresql_server_name" {
  description = "Name of the PostgreSQL server"
  type        = string
  default     = "prod-postgresql-server"
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
  default     = "GP_Gen5_4"
}

# Redis Variables
variable "redis_name" {
  description = "Name of the Redis cache"
  type        = string
  default     = "prod-redis-cache"
}

variable "redis_sku" {
  description = "SKU for Redis cache"
  type        = string
  default     = "Premium"
}