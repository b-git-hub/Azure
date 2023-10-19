
#Deploy Security Group to Block RDP
resource "azurerm_network_security_group" "vnet2SecurityGroup" {
  name                = "vnet2NetworkSecurityGroup"
  location            = azurerm_resource_group.mainRg.location
  resource_group_name = azurerm_resource_group.mainRg.name

  security_rule {
    name                       = "block3389"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "10.0.1.0/24"
  }
}


resource "azurerm_network_interface_security_group_association" "vnet2SgAssociation" {
  network_interface_id      = azurerm_network_interface.windowsNetworkInterface2Vm1.id
  network_security_group_id = azurerm_network_security_group.vnet2SecurityGroup.id
}