resource "azurerm_public_ip" "lb-kubernetes-aksOut" {
  name                = "lb-rancher-kubernetes-aksOut"
  location            = module.source.resource-group-aks-location
  resource_group_name = module.source.resource-group-aks-name
  sku                 = "Standard"
  allocation_method   = "Static"

  tags = {
    environment = "dev-qa"
  }
}