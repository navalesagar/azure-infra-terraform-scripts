# QA Environment Variables
resource_group_name = "qa-terraform-rg"
location            = "East US"

vm_size = "Standard_DS2_v2"  # 2 vCPUs, 7GB RAM for QA

acr_name = "qaacrterraform"
acr_sku  = "Standard"

aks_cluster_name = "qa-aks-cluster"
aks_node_count   = 2
aks_vm_size      = "Standard_DS2_v2"

postgresql_server_name = "qa-postgresql-server"
postgresql_sku          = "B_Gen5_2"

redis_name = "qa-redis-cache"
redis_sku  = "Standard"

ssh_source_address_prefix = "10.0.0.0/8"  # Restrict to internal network

tags = {
  Environment = "QA"
  Project     = "Jenkins-SonarQube"
}