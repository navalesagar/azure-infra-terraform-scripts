variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}

variable "subnet_address_prefixes" {
  description = "Address prefixes for the subnet"
  type        = list(string)
}

variable "nsg_name" {
  description = "Name of the network security group"
  type        = string
}

variable "ssh_source_address_prefix" {
  description = "Source address prefix for SSH access (CIS: restrict to specific IPs)"
  type        = string
  default     = "*"  # Change to specific IP for better security
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