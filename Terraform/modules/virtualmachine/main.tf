resource "azurerm_network_interface" "networkinterface" {
  name                = "${var.azurevmname}vnic"
  location            = var.azurelocation
  resource_group_name = var.azureresourcegroup

  ip_configuration {
    name                          = "${var.azurevmname}internal"
    subnet_id                     = var.azureinternalsubnetid
    private_ip_address_allocation = "Dynamic"
  }
}