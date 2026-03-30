# terraform {
#   backend "azurerm" {
#     resource_group_name  = "terraform-backend-rg"
#     storage_account_name = "terraformbackendstorage"
#     container_name       = "tfstate-qa"
#     key                  = "terraform.tfstate"
#   }
# }