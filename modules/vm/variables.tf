variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
}

variable "vm_size" {
  description = "Size of the VM (CIS: Choose size with sufficient RAM for applications)"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key" {
  description = "SSH public key for authentication (CIS: Use key-based auth)"
  type        = string
}

variable "os_disk_size_gb" {
  description = "Size of the OS disk in GB"
  type        = number
  default     = 30
}

variable "pip_name" {
  description = "Name of the public IP"
  type        = string
}

variable "nic_name" {
  description = "Name of the network interface"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the storage account for boot diagnostics"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet"
  type        = string
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