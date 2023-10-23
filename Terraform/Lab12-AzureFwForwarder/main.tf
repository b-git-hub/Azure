resource "azurerm_resource_group" "mainRg" {
  name     = var.azure_rg_name
  location = var.azure_location
}

#Create Private Peer to AzureFw
resource "azurerm_virtual_network_peering" "addressSpace1ConnectToAddressSpace3" {
  name                         = "addressSpace1ConnectToAddressSpace3"
  resource_group_name          = azurerm_resource_group.mainRg.name
  virtual_network_name         = azurerm_virtual_network.addressSpace1.name
  remote_virtual_network_id    = azurerm_virtual_network.addressSpace3.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "addressSpace3ConnectToAddressSpace1" {
  name                         = "addressSpace3ConnectToAddressSpace1"
  resource_group_name          = azurerm_resource_group.mainRg.name
  virtual_network_name         = azurerm_virtual_network.addressSpace3.name
  remote_virtual_network_id    = azurerm_virtual_network.addressSpace1.id
  allow_virtual_network_access = true
}

resource "azurerm_virtual_network_peering" "addressSpace2ConnectToAddressSpace3" {
  name                         = "addressSpace2ConnectToAddressSpace3"
  resource_group_name          = azurerm_resource_group.mainRg.name
  virtual_network_name         = azurerm_virtual_network.addressSpace2.name
  remote_virtual_network_id    = azurerm_virtual_network.addressSpace3.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "addressSpace3ConnectToAddressSpace2" {
  name                         = "addressSpace3ConnectToAddressSpace2"
  resource_group_name          = azurerm_resource_group.mainRg.name
  virtual_network_name         = azurerm_virtual_network.addressSpace3.name
  remote_virtual_network_id    = azurerm_virtual_network.addressSpace2.id
  allow_virtual_network_access = true
}