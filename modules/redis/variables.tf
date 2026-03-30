variable "redis_name" {
  description = "Name of the Redis cache"
  type        = string
}

variable "capacity" {
  description = "Capacity of Redis cache (0-6)"
  type        = number
  default     = 1
}

variable "family" {
  description = "Family of Redis cache (C or P)"
  type        = string
  default     = "C"
}

variable "sku_name" {
  description = "SKU name (Basic, Standard, Premium)"
  type        = string
  default     = "Basic"
}

variable "enable_non_ssl_port" {
  description = "Enable non-SSL port"
  type        = bool
  default     = false
}

variable "minimum_tls_version" {
  description = "Minimum TLS version"
  type        = string
  default     = "1.2"
}

variable "enable_authentication" {
  description = "Enable authentication for Redis"
  type        = bool
  default     = true
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