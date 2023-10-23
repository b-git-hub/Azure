#Azure Public IP requires standard sku
resource "azurerm_public_ip" "public" {
  name                = "azurefwPublicIP"
  resource_group_name = azurerm_resource_group.mainRg.name
  location            = azurerm_resource_group.mainRg.location
  allocation_method   = "Static"
  sku                 = "Standard"
}