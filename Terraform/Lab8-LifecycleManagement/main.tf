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

resource "azurerm_storage_container" "demoContainer" {
  name                  = "democontainer1${random_integer.ri.result}"
  storage_account_name  = azurerm_storage_account.storageAccount.name
  container_access_type = "blob"
}

#Lifecycle
resource "azurerm_storage_management_policy" "lifecycleManagment" {
  storage_account_id = azurerm_storage_account.storageAccount.id

  rule {
    name    = "rule1"
    enabled = true
    filters {
      prefix_match = ["${azurerm_storage_container.demoContainer.name}/*.pdf"]
      blob_types   = ["blockBlob"]
    }
    actions {
      base_blob {
        tier_to_cool_after_days_since_modification_greater_than    = 30
        tier_to_archive_after_days_since_modification_greater_than = 365
        delete_after_days_since_modification_greater_than          = 3650
      }
    }
  }
}