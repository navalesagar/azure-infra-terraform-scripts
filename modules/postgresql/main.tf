# Azure Database for PostgreSQL
resource "azurerm_postgresql_server" "postgres" {
  name                = var.server_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name = var.sku_name

  storage_mb                   = var.storage_mb
  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
  auto_grow_enabled            = var.auto_grow_enabled

  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
  version                      = var.postgresql_version
  ssl_enforcement_enabled      = var.ssl_enforcement_enabled

  tags = var.tags
}

# PostgreSQL Database
resource "azurerm_postgresql_database" "db" {
  name                = var.database_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.postgres.name
  charset             = var.charset
  collation           = var.collation
}

# Optional: Firewall rule for access
resource "azurerm_postgresql_firewall_rule" "firewall" {
  count               = var.allow_public_access ? 1 : 0
  name                = "AllowAll"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.postgres.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}