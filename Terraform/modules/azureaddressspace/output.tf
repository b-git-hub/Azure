output "addressspacename" {
  value = azurerm_virtual_network.addressspace.name
}

output "name" {
  value = var.azureaddressspacename
}

output "addressspaceid" {
  value = azurerm_virtual_network.addressspace.id
}

output "subnetid" {
  value = azurerm_subnet.subnet.id
}

output "resourcegroup" {
  value = azurerm_virtual_network.addressspace.resource_group_name
}

output "location" {
  value = azurerm_virtual_network.addressspace.location
}

