# Azure Cache for Redis
resource "azurerm_redis_cache" "redis" {
  name                = var.redis_name
  location            = var.location
  resource_group_name = var.resource_group_name
  capacity            = var.capacity
  family              = var.family
  sku_name            = var.sku_name
  enable_non_ssl_port = var.enable_non_ssl_port
  minimum_tls_version = var.minimum_tls_version

  redis_configuration {
    enable_authentication = var.enable_authentication
  }

  tags = var.tags
}

# Optional: Redis Firewall Rule
resource "azurerm_redis_firewall_rule" "firewall" {
  count               = var.allow_public_access ? 1 : 0
  name                = "AllowAll"
  redis_cache_name    = azurerm_redis_cache.redis.name
  resource_group_name = var.resource_group_name
  start_ip            = "0.0.0.0"
  end_ip              = "255.255.255.255"
}