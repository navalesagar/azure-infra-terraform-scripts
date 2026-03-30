# Development Environment Variables
resource_group_name = "dev-terraform-rg"
location            = "East US"

vm_size = "Standard_DS1_v2"  # 1 vCPU, 3.5GB RAM for dev

acr_name = "devacrterraform"
acr_sku  = "Basic"

aks_cluster_name = "dev-aks-cluster"
aks_node_count   = 1
aks_vm_size      = "Standard_DS1_v2"

postgresql_server_name = "dev-postgresql-server"
postgresql_sku          = "B_Gen5_1"

redis_name = "dev-redis-cache"
redis_sku  = "Basic"

ssh_source_address_prefix = "*"  # Open for dev, restrict in prod

tags = {
  Environment = "Dev"
  Project     = "Jenkins-SonarQube"
}