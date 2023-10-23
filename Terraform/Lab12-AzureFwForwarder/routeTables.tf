
#Create Default Route to Azure Fw
resource "azurerm_route_table" "defaultRouteTableSubnet1" {
  name                = "defaultRouteTableSubnet1"
  location            = azurerm_resource_group.mainRg.location
  resource_group_name = azurerm_resource_group.mainRg.name

  route {
    name                   = "example"
    address_prefix         = azurerm_subnet.internalSubnet2.address_prefixes[0]
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.azureFw.ip_configuration[0].private_ip_address
  }
}

resource "azurerm_route_table" "defaultRouteTableSubnet2" {
  name                = "defaultRouteTableSubnet2"
  location            = azurerm_resource_group.mainRg.location
  resource_group_name = azurerm_resource_group.mainRg.name

  route {
    name                   = "example"
    address_prefix         = azurerm_subnet.internalSubnet1.address_prefixes[0]
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.azureFw.ip_configuration[0].private_ip_address
  }
}


###Associate Routes to a particular subnet
resource "azurerm_subnet_route_table_association" "internalSubnet1RT" {
  subnet_id      = azurerm_subnet.internalSubnet1.id
  route_table_id = azurerm_route_table.defaultRouteTableSubnet1.id
}

resource "azurerm_subnet_route_table_association" "internalSubnet2RT" {
  subnet_id      = azurerm_subnet.internalSubnet2.id
  route_table_id = azurerm_route_table.defaultRouteTableSubnet2.id
}