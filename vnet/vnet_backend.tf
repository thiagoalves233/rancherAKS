module "source" {
  source = "../source"
}

resource "azurerm_network_security_group" "sg-aks-rancher" {
  name                = "SecurityGroup-Backend"
  location            = module.source.resource-group-aks-location
  resource_group_name = module.source.resource-group-aks-name
  # security_rule {
  #   name                       = "test123"
  #   priority                   = 100
  #   direction                  = "Inbound"
  #   access                     = "Allow"
  #   protocol                   = "Tcp"
  #   source_port_range          = "*"
  #   destination_port_range     = "*"
  #   source_address_prefix      = "*"
  #   destination_address_prefix = "*"
  # }
}

resource "azurerm_virtual_network" "vnet-aks-rancher" {
  name                = "aks-rancher-vnet"
  location            = module.source.resource-group-aks-location
  resource_group_name = module.source.resource-group-aks-name
  address_space       = ["192.168.0.0/16"]
}

resource "azurerm_subnet" "aks-rancher-subnet" {
  name                  = "aks-rancher-subnet"
  virtual_network_name  = azurerm_virtual_network.vnet-aks-rancher.name
  resource_group_name   = module.source.resource-group-aks-name
  address_prefixes      = ["192.168.0.0/20"]
}

resource "azurerm_subnet_network_security_group_association" "aks-rancher-subnet" {
  subnet_id                 = azurerm_subnet.aks-rancher-subnet.id
  network_security_group_id = azurerm_network_security_group.sg-aks-rancher.id
}
