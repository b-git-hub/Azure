#Azure Public IP
resource "azurerm_public_ip" "public" {
  name                = "azurevmPublicIP"
  resource_group_name = azurerm_resource_group.mainRg.name
  location            = azurerm_resource_group.mainRg.location
  allocation_method   = "Dynamic"
}