output "server_name" {
  value = azurerm_postgresql_server.postgres.name
}

output "database_name" {
  value = azurerm_postgresql_database.db.name
}

output "server_fqdn" {
  value = azurerm_postgresql_server.postgres.fqdn
}

output "administrator_login" {
  value = azurerm_postgresql_server.postgres.administrator_login
}

output "administrator_login_password" {
  value     = azurerm_postgresql_server.postgres.administrator_login_password
  sensitive = true
}