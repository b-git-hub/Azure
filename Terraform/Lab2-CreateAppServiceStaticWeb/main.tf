resource "azurerm_resource_group" "main_rg" {
  name     = "main_rg1"
  location = var.azure_location
}

# Generate a random integer to create a globally unique name
resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

# Create Static Site
resource "azurerm_static_site" "web" {
  name                = "webapp-static-${random_integer.ri.result}"
  resource_group_name = azurerm_resource_group.main_rg.name
  location            = var.azure_location
}