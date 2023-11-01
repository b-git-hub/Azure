resource "azurerm_resource_group" "azureregion" {
  name     = var.azureresourcegroup
  location = var.azurelocation
}

#Deploy Spoke Networks
module "azurevmnetworkdeploy" {
  source   = "../modules/azureaddressspace"
  for_each = var.azurevmnetworkinformation

  addressspacesubnet    = each.value.addressspacesubnet
  azureaddressspacename = each.value.name
  azureresourcegroup    = azurerm_resource_group.azureregion.name
  azurelocation         = azurerm_resource_group.azureregion.location
  azuresubnetrange      = each.value.subnet
}


# Deploy Azure Firewall Network (Hub)
module "azurefwnetworkdeploy" {
  source   = "../modules/azureaddressspace"
  for_each = var.azurefwnetworkinformation

  addressspacesubnet    = each.value.addressspacesubnet
  azureaddressspacename = each.value.name
  azureresourcegroup    = azurerm_resource_group.azureregion.name
  azurelocation         = azurerm_resource_group.azureregion.location
  azuresubnetrange      = each.value.subnet
}



# Deploy VMs to Spoke Networks
module "azurevmnetworksdeploy" {
  source   = "../modules/azurevirtualmachine"
  for_each = module.azurevmnetworkdeploy

  azureresourcegroup    = azurerm_resource_group.azureregion.name
  azurelocation         = azurerm_resource_group.azureregion.location
  azurevmname           = each.value.name
  azureinternalsubnetid = each.value.subnetid
}

/*
# Create Peering from Firewall to network vNets
module "azurefwpeering" {
  source   = "../modules/azureprivatepeering"
  for_each = module.azurevmnetworkdeploy

  azureresourcegroup             = each.value.resourcegroup
  azuresourceaddressspace        = module.azurefwnetworkdeploy.azurefirewall.addressspacename
  azuresourceaddressspaceid      = module.azurefwnetworkdeploy.azurefirewall.addressspaceid
  azuredestinationaddressspace   = each.value.addressspacename
  azuredestinationaddressspaceid = each.value.addressspaceid
  allowforwardedtraffic          = true
}


# Create Peering from vNets to Firewalls
module "azurevmpeering" {
  source   = "../modules/azureprivatepeering"
  for_each = module.azurevmnetworkdeploy

  azureresourcegroup             = each.value.resourcegroup
  azuresourceaddressspace        = each.value.addressspacename
  azuresourceaddressspaceid      = each.value.addressspaceid
  azuredestinationaddressspace   = module.azurefwnetworkdeploy.azurefirewall.addressspacename
  azuredestinationaddressspaceid = module.azurefwnetworkdeploy.azurefirewall.addressspaceid
}
*/