# Azure Kubernetes Service Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  # CIS Benchmark: Use managed identity for authentication
  identity {
    type = "SystemAssigned"
  }

  # Default node pool
  default_node_pool {
    name                = var.node_pool_name
    node_count          = var.node_count
    vm_size             = var.vm_size
    vnet_subnet_id      = var.subnet_id
    enable_auto_scaling = var.enable_auto_scaling
    min_count           = var.enable_auto_scaling ? var.min_node_count : null
    max_count           = var.enable_auto_scaling ? var.max_node_count : null

    # CIS: Use managed disks
    os_disk_type = "Managed"
  }

  # CIS: Enable RBAC
  role_based_access_control_enabled = true

  # Network profile
  network_profile {
    network_plugin = var.network_plugin
    load_balancer_sku = "standard"
  }

  # CIS: Enable Azure Monitor (optional, but recommended)
  oms_agent {
    log_analytics_workspace_id = var.log_analytics_workspace_id
  }

  tags = var.tags
}

# Optional: Log Analytics Workspace for monitoring
resource "azurerm_log_analytics_workspace" "aks" {
  count               = var.enable_monitoring ? 1 : 0
  name                = "${var.cluster_name}-logs"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = var.tags
}