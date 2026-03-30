output "cluster_id" {
  value = azurerm_kubernetes_cluster.aks.id
}

output "cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}

output "kube_config_host" {
  value = azurerm_kubernetes_cluster.aks.kube_config.0.host
}

output "log_analytics_workspace_id" {
  value = var.enable_monitoring ? azurerm_log_analytics_workspace.aks[0].id : null
}