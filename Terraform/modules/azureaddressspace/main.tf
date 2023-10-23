resource "azurerm_virtual_network" "addressspace" {
  name                = "${var.azureaddressspacename}vNet"
  address_space       = [var.addressspacesubnet]
  location            = var.azurelocation
  resource_group_name = var.azureresourcegroup
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.azureaddressspacename}subnet"
  resource_group_name  = var.azureresourcegroup
  virtual_network_name = azurerm_virtual_network.addressspace.name
  address_prefixes     = [var.azuresubnetrange]
}
