# Backend setup - run this first to create remote backend resources
# After creating, comment out this block and uncomment backend.tf

resource "azurerm_resource_group" "backend_rg" {
  name     = "terraform-backend-rg"
  location = "East US"
}

resource "azurerm_storage_account" "backend_storage" {
  name                     = "terraformbackendstorage"
  resource_group_name      = azurerm_resource_group.backend_rg.name
  location                 = azurerm_resource_group.backend_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  tags = {
    Environment = "Backend"
    Purpose     = "Terraform State"
  }
}

resource "azurerm_storage_container" "backend_container" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.backend_storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "backend_container_dev" {
  name                  = "tfstate-dev"
  storage_account_name  = azurerm_storage_account.backend_storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "backend_container_qa" {
  name                  = "tfstate-qa"
  storage_account_name  = azurerm_storage_account.backend_storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "backend_container_prod" {
  name                  = "tfstate-prod"
  storage_account_name  = azurerm_storage_account.backend_storage.name
  container_access_type = "private"
}

# Outputs for backend configuration
output "backend_resource_group" {
  value = azurerm_resource_group.backend_rg.name
}

output "backend_storage_account" {
  value = azurerm_storage_account.backend_storage.name
}

output "backend_container" {
  value = azurerm_storage_container.backend_container.name
}