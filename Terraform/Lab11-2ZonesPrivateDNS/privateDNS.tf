#Private DNS zone name
resource "azurerm_private_dns_zone" "sampleDNS" {
  name                = "sample.com"
  resource_group_name = azurerm_resource_group.mainRg.name
}


#Private DNS connect to virtual networks
resource "azurerm_private_dns_zone_virtual_network_link" "privateDNSvNet1" {
  name                  = "linkAddressSpace1"
  resource_group_name   = azurerm_resource_group.mainRg.name
  private_dns_zone_name = azurerm_private_dns_zone.sampleDNS.name
  virtual_network_id    = azurerm_virtual_network.addressSpace1.id
  registration_enabled  = true
}

resource "azurerm_private_dns_zone_virtual_network_link" "privateDNSvNet2" {
  name                  = "linkAddressSpace2"
  resource_group_name   = azurerm_resource_group.mainRg.name
  private_dns_zone_name = azurerm_private_dns_zone.sampleDNS.name
  virtual_network_id    = azurerm_virtual_network.addressSpace2.id
  registration_enabled  = true
}