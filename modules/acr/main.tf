resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku  # CIS: Use Premium for better security features
  admin_enabled       = var.admin_enabled

  # CIS: Enable geo-replication if Premium
  dynamic "georeplications" {
    for_each = var.sku == "Premium" ? var.georeplication_locations : []
    content {
      location = georeplications.value
    }
  }

  tags = var.tags
}