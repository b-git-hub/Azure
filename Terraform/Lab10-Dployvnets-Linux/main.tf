resource "azurerm_resource_group" "mainRg" {
  name     = var.azure_rg_name
  location = var.azure_location
}

#Create Private Peer between both vNets
resource "azurerm_virtual_network_peering" "addressSpace1ConnectToAddressSpace2" {
  name                         = "addressSpace1ConnectToAddressSpace2"
  resource_group_name          = azurerm_resource_group.mainRg.name
  virtual_network_name         = azurerm_virtual_network.addressSpace1.name
  remote_virtual_network_id    = azurerm_virtual_network.addressSpace2.id
  allow_virtual_network_access = true
}

resource "azurerm_virtual_network_peering" "addressSpace2ConnectToAddressSpace1" {
  name                         = "addressSpace2ConnectToAddressSpace1"
  resource_group_name          = azurerm_resource_group.mainRg.name
  virtual_network_name         = azurerm_virtual_network.addressSpace2.name
  remote_virtual_network_id    = azurerm_virtual_network.addressSpace1.id
  allow_virtual_network_access = true
}