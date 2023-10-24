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

# Deploy Azure Firewall Network (Hub)
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
    source = "../modules/azurevirtualmachine"
    depends_on = [module.azurefwnetworkdeploy.network1]
    for_each = module.azurevmnetworkdeploy

    azureresourcegroup = azurerm_resource_group.azureregion.name
    azurelocation = azurerm_resource_group.azureregion.location
    azurevmname = each.value.name
    azureinternalsubnetid = each.value.subnetid
}

# Create Peering from vm vNets and connect them to Azure Fw vNet
module "azurepeering" {
    source = "../modules/azureprivatepeering"
    for_each = module.azurevmnetworkdeploy

    azureresourcegroup = azurerm_resource_group.azureregion.name
    azurevmaddressspacename = each.value.addressspacename
    azurefwaddressspacename = module.azurefwnetworkdeploy.azurefirewall.addressspacename
    azurevmaddressspaceid = each.value.addressspaceid
    azurefwaddressspaceid = module.azurefwnetworkdeploy.azurefirewall.addressspaceid

}
