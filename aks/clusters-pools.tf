module "vnet" {
  source = "../vnet"
}

module "source" {
  source = "../source"
}

resource "azurerm_kubernetes_cluster" "aks_rancher" {
  name                = "aks-rancher"
  location            = module.source.resource-group-aks-location
  resource_group_name = module.source.resource-group-aks-name
  dns_prefix          = "rancher-mm-aks"

  default_node_pool {
      name            = "default"
      node_count      = 1
      vm_size         = "Standard_B2ms"
      max_pods        = 250
      os_disk_size_gb = 100
      enable_node_public_ip = false
      vnet_subnet_id  = module.vnet.subnet-aks-rancher-id
    }
    network_profile {
      network_plugin    = "azure"
      load_balancer_sku = "Standard"
      load_balancer_profile {
        outbound_ip_address_ids = [
          module.vnet.lb-pubicip-aks-rancher-id
        ]
      }
    }
    service_principal {
        client_id     = "84d28679-2f09-4464-800a-93d34fde3dda"
        client_secret = "D4D.kslmwNMUNIkf2U6MyupRqLIwi-RVZj"
    }
    role_based_access_control {
       enabled = true
    }
  lifecycle {
    ignore_changes = [
      windows_profile
    ]
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "aks_rancher01" {
  name                  = "rancher01"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_rancher.id
  enable_node_public_ip = false
  enable_auto_scaling   = false
  max_pods        = 250
  os_disk_size_gb = 100
  os_type         = "Linux"
  node_count      = 1
  vm_size         = "Standard_B2ms"
  mode            = "User"
  vnet_subnet_id  = module.vnet.subnet-aks-rancher-id
}
