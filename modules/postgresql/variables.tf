variable "server_name" {
  description = "Name of the PostgreSQL server"
  type        = string
}

variable "database_name" {
  description = "Name of the PostgreSQL database"
  type        = string
  default     = "mydatabase"
}

variable "administrator_login" {
  description = "Administrator login for PostgreSQL"
  type        = string
  default     = "psqladmin"
}

variable "administrator_login_password" {
  description = "Administrator password for PostgreSQL"
  type        = string
  sensitive   = true
}

variable "sku_name" {
  description = "SKU for PostgreSQL server (e.g., B_Gen5_1, GP_Gen5_2)"
  type        = string
  default     = "B_Gen5_1"
}

variable "storage_mb" {
  description = "Storage size in MB"
  type        = number
  default     = 5120
}

variable "backup_retention_days" {
  description = "Backup retention days"
  type        = number
  default     = 7
}

variable "geo_redundant_backup_enabled" {
  description = "Enable geo-redundant backup"
  type        = bool
  default     = false
}

variable "auto_grow_enabled" {
  description = "Enable auto-grow for storage"
  type        = bool
  default     = true
}

variable "postgresql_version" {
  description = "PostgreSQL version"
  type        = string
  default     = "11"
}

variable "ssl_enforcement_enabled" {
  description = "Enable SSL enforcement"
  type        = bool
  default     = true
}

variable "charset" {
  description = "Database charset"
  type        = string
  default     = "UTF8"
}

variable "collation" {
  description = "Database collation"
  type        = string
  default     = "English_United States.1252"
}

variable "allow_public_access" {
  description = "Allow public access via firewall rule"
  type        = bool
  default     = true
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default     = {}
}