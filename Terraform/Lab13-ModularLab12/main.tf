resource "azurerm_resource_group" "azureregion" {
  name     = var.azureresourcegroup
  location = var.azurelocation
}

module "azureaddressspace" {
    source = "../modules/azureaddressspace"
    for_each = var.azureipinformation

    addressspacesubnet = each.value.addressspacesubnet
    azureaddressspacename = each.value.name
    azureresourcegroup = azurerm_resource_group.azureregion.name
    azurelocation = azurerm_resource_group.azureregion.location
    azuresubnetrange = each.value.subnet
}
