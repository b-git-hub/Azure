resource "azurerm_resource_group" "azureregion" {
  name     = var.azureresourcegroup
  location = var.azurelocation
}

#Deploy Spoke Networks
module "azurevmnetworkdeploy" {
    source = "../modules/azureaddressspace"
    for_each = var.azurevmnetworkinformation

    addressspacesubnet = each.value.addressspacesubnet
    azureaddressspacename = each.value.name
    azureresourcegroup = azurerm_resource_group.azureregion.name
    azurelocation = azurerm_resource_group.azureregion.location
    azuresubnetrange = each.value.subnet
}

# Deply Azure Firewall Network (Hub)
module "azurefwnetworkdeploy" {
    source = "../modules/azureaddressspace"
    for_each = var.azurefwnetworkinformation

    addressspacesubnet = each.value.addressspacesubnet
    azureaddressspacename = each.value.name
    azureresourcegroup = azurerm_resource_group.azureregion.name
    azurelocation = azurerm_resource_group.azureregion.location
    azuresubnetrange = each.value.subnet
}

# Deploy VMs to Spoke Networks
module "azurevmnetworksdeploy" {
    source = "../modules/virtualmachine"
    for_each = module.azurevmnetworkdeploy

    azureresourcegroup = azurerm_resource_group.azureregion.name
    azurelocation = azurerm_resource_group.azureregion.location
    azurevmname = each.value.addressspacename
    azureinternalsubnetid = each.value.id
}
