output "resource_group_name" {
  value = module.resource_group.name
}

output "vm_public_ip" {
  value = module.vm.public_ip_address
}

output "acr_login_server" {
  value = module.acr.acr_login_server
}

output "acr_admin_username" {
  value = module.acr.acr_admin_username
}

output "acr_admin_password" {
  value = module.acr.acr_admin_password
  sensitive = true
}

output "aks_cluster_name" {
  value = module.aks.cluster_name
}

output "aks_kube_config" {
  value     = module.aks.kube_config
  sensitive = true
}

output "postgresql_server_fqdn" {
  value = module.postgresql.server_fqdn
}

output "postgresql_admin_login" {
  value = module.postgresql.administrator_login
}

output "postgresql_admin_password" {
  value     = module.postgresql.administrator_login_password
  sensitive = true
}

output "redis_hostname" {
  value = module.redis.hostname
}

output "redis_ssl_port" {
  value = module.redis.ssl_port
}

output "redis_primary_access_key" {
  value     = module.redis.primary_access_key
  sensitive = true
}