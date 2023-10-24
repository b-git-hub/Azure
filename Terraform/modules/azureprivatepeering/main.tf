resource "azurerm_virtual_network_peering" "privatepeering" {
  name                         = "${var.azuresourceaddressspace}to${var.azuredestinationaddressspace}"
  resource_group_name          = var.azureresourcegroup
  virtual_network_name         = var.azuresourceaddressspace
  remote_virtual_network_id    = var.azuredestinationaddressspaceid
  allow_virtual_network_access = true
  allow_forwarded_traffic      = var.allowforwardedtraffic
}