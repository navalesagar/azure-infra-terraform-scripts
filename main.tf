# Resource Group Module
module "resource_group" {
  source   = "./modules/resource_group"
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# Networking Module
module "networking" {
  source                   = "./modules/networking"
  vnet_name                = "my-vnet"
  address_space            = ["10.0.0.0/16"]
  subnet_name              = "my-subnet"
  subnet_address_prefixes  = ["10.0.1.0/24"]
  nsg_name                 = "my-nsg"
  ssh_source_address_prefix = var.ssh_source_address_prefix
  location                 = var.location
  resource_group_name      = module.resource_group.name
  tags                     = var.tags
}

# VM Module
module "vm" {
  source               = "./modules/vm"
  vm_name              = "my-ubuntu-vm"
  vm_size              = var.vm_size
  admin_username       = var.admin_username
  ssh_public_key       = var.ssh_public_key
  pip_name             = "my-pip"
  nic_name             = "my-nic"
  storage_account_name = "mystorageaccountdiag"  # Must be globally unique
  subnet_id            = module.networking.subnet_id
  location             = var.location
  resource_group_name  = module.resource_group.name
  tags                 = var.tags
}

# ACR Module
module "acr" {
  source              = "./modules/acr"
  acr_name            = var.acr_name
  sku                 = var.acr_sku
  admin_enabled       = true
  location            = var.location
  resource_group_name = module.resource_group.name
  tags                = var.tags
}