resource "azurerm_firewall" "azureFw" {
  name                = "azureFw"
  location            = azurerm_resource_group.mainRg.location
  resource_group_name = azurerm_resource_group.mainRg.name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.azureFwSubnet.id
    public_ip_address_id = azurerm_public_ip.public.id
  }
}


###Inbound SSH Rule
resource "azurerm_firewall_nat_rule_collection" "inboundSSH" {
  name                = "inboundssh"
  azure_firewall_name = azurerm_firewall.azureFw.name
  resource_group_name = azurerm_resource_group.mainRg.name
  priority            = 100
  action              = "Dnat"

  rule {
    name = "inboundssh"

    source_addresses = [
      "*",
    ]

    destination_ports = [
      "22",
    ]

    destination_addresses = [
      azurerm_public_ip.public.ip_address
    ]

    translated_port = 22

    translated_address = azurerm_linux_virtual_machine.linuxvm1.private_ip_address

    protocols = [
      "TCP",
    ]
  }
}

###Allow Internal Subnets
resource "azurerm_firewall_network_rule_collection" "internaltraffic" {
  name                = "internaltraffic"
  azure_firewall_name = azurerm_firewall.azureFw.name
  resource_group_name = azurerm_resource_group.mainRg.name
  priority            = 100
  action              = "Allow"

  rule {
    name = "any"

    source_addresses = [
      azurerm_subnet.internalSubnet1.address_prefixes[0],
      azurerm_subnet.internalSubnet2.address_prefixes[0],
    ]

    destination_ports = [
      "*",
    ]

    destination_addresses = [
      "*",
    ]

    protocols = [
      "Any",
    ]
  }
}