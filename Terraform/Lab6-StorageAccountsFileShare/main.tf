resource "azurerm_resource_group" "mainRg" {
  name     = var.azure_rg_name
  location = var.azure_location
}

# Generate a random integer to create a globally unique name
resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

# Storage Account 
resource "azurerm_storage_account" "storageAccount" {
  name                     = "demostorage${random_integer.ri.result}"
  resource_group_name      = azurerm_resource_group.mainRg.name
  location                 = var.azure_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  access_tier              = "Hot"

  tags = {
    environment = "staging"
  }
}

#FileShare
resource "azurerm_storage_share" "storageShare" {
  name                 = "demofileshare${random_integer.ri.result}"
  storage_account_name = azurerm_storage_account.storageAccount.name
  quota                = 1
}
