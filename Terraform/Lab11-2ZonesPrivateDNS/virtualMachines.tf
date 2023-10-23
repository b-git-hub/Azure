
#Linux VM1
resource "azurerm_linux_virtual_machine" "linuxvm1" {
  name                = "linuxvm1"
  resource_group_name = azurerm_resource_group.mainRg.name
  location            = azurerm_resource_group.mainRg.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.linuxNetworkInterface1Vm1.id,
  ]
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("linux.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}

#Linux VM2
resource "azurerm_linux_virtual_machine" "linuxvm2" {
  name                = "linuxvm2"
  resource_group_name = azurerm_resource_group.mainRg.name
  location            = azurerm_resource_group.mainRg.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.linuxNetworkInterface2Vm1.id,
  ]

  # ssh-keygen
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("linux.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}