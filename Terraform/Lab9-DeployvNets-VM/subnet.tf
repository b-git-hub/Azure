#Define vNet1
resource "azurerm_subnet" "internalSubnet1" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.mainRg.name
  virtual_network_name = azurerm_virtual_network.addressSpace1.name
  address_prefixes     = ["10.0.0.0/29"]
}

#Define vNet2
resource "azurerm_subnet" "internalSubnet2" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.mainRg.name
  virtual_network_name = azurerm_virtual_network.addressSpace2.name
  address_prefixes     = ["10.0.1.0/29"]
}
