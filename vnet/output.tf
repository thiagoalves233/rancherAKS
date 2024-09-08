output "vnet-aks-rancher-id" {
  value = azurerm_virtual_network.vnet-aks-rancher.id
}

output "lb-pubicip-aks-rancher-id" {
  value = azurerm_public_ip.lb-kubernetes-aksOut.id
}

output "subnet-aks-rancher-id" {
  value = azurerm_subnet.aks-rancher-subnet.id
}

