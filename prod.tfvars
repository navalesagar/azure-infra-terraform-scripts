# Production Environment Variables
resource_group_name = "prod-terraform-rg"
location            = "East US 2"  # Different region for prod

vm_size = "Standard_DS3_v2"  # 4 vCPUs, 14GB RAM for prod

acr_name = "prodacrterraform"
acr_sku  = "Premium"

aks_cluster_name = "prod-aks-cluster"
aks_node_count   = 3
aks_vm_size      = "Standard_DS3_v2"

postgresql_server_name = "prod-postgresql-server"
postgresql_sku          = "GP_Gen5_4"

redis_name = "prod-redis-cache"
redis_sku  = "Premium"

ssh_source_address_prefix = "203.0.113.0/24"  # Example: restrict to specific IP range

tags = {
  Environment = "Prod"
  Project     = "Jenkins-SonarQube"
  CostCenter  = "IT"
}