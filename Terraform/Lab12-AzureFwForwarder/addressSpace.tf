#Define Address Space for vNet1
resource "azurerm_virtual_network" "addressSpace1" {
  name                = "addressSpace1"
  address_space       = ["10.0.0.0/24"]
  location            = azurerm_resource_group.mainRg.location
  resource_group_name = azurerm_resource_group.mainRg.name
}

#Define Address Space for vNet2
resource "azurerm_virtual_network" "addressSpace2" {
  name                = "addressSpace2"
  address_space       = ["10.0.1.0/24"]
  location            = azurerm_resource_group.mainRg.location
  resource_group_name = azurerm_resource_group.mainRg.name
}


#Define Address Space for vNet3 for Azure FW in Hub/Spoke Design
resource "azurerm_virtual_network" "addressSpace3" {
  name                = "addressSpace3"
  address_space       = ["10.0.2.0/24"]
  location            = azurerm_resource_group.mainRg.location
  resource_group_name = azurerm_resource_group.mainRg.name
}
