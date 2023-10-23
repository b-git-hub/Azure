#Define VM1 Network Interface
resource "azurerm_network_interface" "linuxNetworkInterface1Vm1" {
  name                = "linuxVnet1Vm1"
  location            = azurerm_resource_group.mainRg.location
  resource_group_name = azurerm_resource_group.mainRg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internalSubnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}

#Define VM2 Network Interface
resource "azurerm_network_interface" "linuxNetworkInterface2Vm1" {
  name                = "linuxVnet2Vm1"
  location            = azurerm_resource_group.mainRg.location
  resource_group_name = azurerm_resource_group.mainRg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internalSubnet2.id
    private_ip_address_allocation = "Dynamic"
  }
}
