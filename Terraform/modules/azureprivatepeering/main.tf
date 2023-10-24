resource "azurerm_virtual_network_peering" "firewall2vmnetwork" {
  name                         = "${var.azurefwaddressspacename}to${var.azurevmaddressspacename}"
  resource_group_name          = var.azureresourcegroup
  virtual_network_name         = var.azurefwaddressspacename
  remote_virtual_network_id    = var.azurevmaddressspaceid
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "vmnetwork2firewall" {
  name                         = "${var.azurevmaddressspacename}to${var.azurefwaddressspacename}"
  resource_group_name          = var.azureresourcegroup
  virtual_network_name         = var.azurevmaddressspacename
  remote_virtual_network_id    = var.azurefwaddressspaceid
  allow_virtual_network_access = true
}