output "redis_name" {
  value = azurerm_redis_cache.redis.name
}

output "hostname" {
  value = azurerm_redis_cache.redis.hostname
}

output "ssl_port" {
  value = azurerm_redis_cache.redis.ssl_port
}

output "primary_access_key" {
  value     = azurerm_redis_cache.redis.primary_access_key
  sensitive = true
}

output "secondary_access_key" {
  value     = azurerm_redis_cache.redis.secondary_access_key
  sensitive = true
}