resource "azurerm_resource_group" "main_rg" {
  name     = var.azure_rg_name
  location = var.azure_location
}


#Virtual Network
resource "azurerm_virtual_network" "vn" {
  name                = var.azure_vn_name
  address_space       = ["10.0.0.0/16"]
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.main_rg.name
}

#Azure Internal Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.main_rg.name
  virtual_network_name = azurerm_virtual_network.vn.name
  address_prefixes     = ["10.0.2.0/24"]
}

#Azure Public IP
resource "azurerm_public_ip" "public" {
  name                = "azurevm_publicIP"
  resource_group_name = azurerm_resource_group.main_rg.name
  location            = var.azure_location
  allocation_method   = "Dynamic"
}

#Azure Interface
resource "azurerm_network_interface" "interface" {
  name                = "windowsinterface"
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.main_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public.id
  }
}

#Create VM
resource "azurerm_windows_virtual_machine" "windows" {
  name                = "windowsDemo"
  resource_group_name = azurerm_resource_group.main_rg.name
  location            = var.azure_location
  size                = "Standard_DS1_v2"
  admin_username      = "adminuser"
  admin_password      = var.azure_vm_password
  network_interface_ids = [
    azurerm_network_interface.interface.id,
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}