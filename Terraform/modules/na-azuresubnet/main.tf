resource "azurerm_subnet" "subnet" {
  name                 = "${var.azuresubnetname}subnet"
  resource_group_name  = var.azureresourcegroup
  virtual_network_name = "${var.azuresubnetname}vNet"
  address_prefixes     = [var.azuresubnetrange]
}