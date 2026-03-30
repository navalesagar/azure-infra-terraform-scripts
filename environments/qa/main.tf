# QA Environment Backend
terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-backend-rg"
    storage_account_name = "terraformbackendstorage"
    container_name       = "tfstate-qa"
    key                  = "terraform.tfstate"
  }
}

# QA Environment Provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Resource Group Module
module "resource_group" {
  source   = "../../modules/resource_group"
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# Networking Module
module "networking" {
  source                   = "../../modules/networking"
  vnet_name                = "qa-vnet"
  address_space            = ["10.1.0.0/16"]
  subnet_name              = "qa-subnet"
  subnet_address_prefixes  = ["10.1.1.0/24"]
  nsg_name                 = "qa-nsg"
  ssh_source_address_prefix = var.ssh_source_address_prefix
  location                 = var.location
  resource_group_name      = module.resource_group.name
  tags                     = var.tags
}

# VM Module
module "vm" {
  source               = "../../modules/vm"
  vm_name              = "qa-ubuntu-vm"
  vm_size              = var.vm_size
  admin_username       = var.admin_username
  ssh_public_key       = var.ssh_public_key
  pip_name             = "qa-pip"
  nic_name             = "qa-nic"
  storage_account_name = "qastorageaccountdiag"
  subnet_id            = module.networking.subnet_id
  location             = var.location
  resource_group_name  = module.resource_group.name
  tags                 = var.tags
}

# ACR Module
module "acr" {
  source              = "../../modules/acr"
  acr_name            = var.acr_name
  sku                 = var.acr_sku
  admin_enabled       = true
  location            = var.location
  resource_group_name = module.resource_group.name
  tags                = var.tags
}

# AKS Module
module "aks" {
  source              = "../../modules/aks"
  cluster_name        = var.aks_cluster_name
  dns_prefix          = var.aks_cluster_name
  node_count          = var.aks_node_count
  vm_size             = var.aks_vm_size
  subnet_id           = module.networking.subnet_id
  location            = var.location
  resource_group_name = module.resource_group.name
  tags                = var.tags
}

# PostgreSQL Module
module "postgresql" {
  source                       = "../../modules/postgresql"
  server_name                  = var.postgresql_server_name
  administrator_login_password = var.postgresql_admin_password
  sku_name                     = var.postgresql_sku
  location                     = var.location
  resource_group_name          = module.resource_group.name
  tags                         = var.tags
}

# Redis Module
module "redis" {
  source              = "../../modules/redis"
  redis_name          = var.redis_name
  sku_name            = var.redis_sku
  location            = var.location
  resource_group_name = module.resource_group.name
  tags                = var.tags
}