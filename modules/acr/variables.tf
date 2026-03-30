variable "acr_name" {
  description = "Name of the Azure Container Registry"
  type        = string
}

variable "sku" {
  description = "SKU for ACR (CIS: Premium for advanced security)"
  type        = string
  default     = "Premium"
}

variable "admin_enabled" {
  description = "Enable admin user for ACR"
  type        = bool
  default     = true
}

variable "georeplication_locations" {
  description = "Locations for geo-replication (for Premium SKU)"
  type        = list(string)
  default     = []
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