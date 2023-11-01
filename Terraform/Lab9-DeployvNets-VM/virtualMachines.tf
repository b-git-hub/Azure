#Create VM1 in vNet1
resource "azurerm_windows_virtual_machine" "windowsVnet1VM" {
  name                = "windowsVnet1VM"
  resource_group_name = azurerm_resource_group.mainRg.name
  location            = azurerm_resource_group.mainRg.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password      = var.azure_vm_password
  network_interface_ids = [
    azurerm_network_interface.windowsNetworkInterface1Vm1.id,
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}

#Create VM1 in vNet2
resource "azurerm_windows_virtual_machine" "windowsVnet2VM" {
  name                = "windowsVnet2VM"
  resource_group_name = azurerm_resource_group.mainRg.name
  location            = azurerm_resource_group.mainRg.location
  size                = "Standard_DS1_v2"
  admin_username      = "adminuser"
  admin_password      = var.azure_vm_password
  network_interface_ids = [
    azurerm_network_interface.windowsNetworkInterface2Vm1.id,
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}
