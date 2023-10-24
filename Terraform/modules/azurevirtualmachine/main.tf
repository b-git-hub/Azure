resource "azurerm_network_interface" "networkinterface" {
  name                = "${var.azurevmname}vnic"
  location            = var.azurelocation
  resource_group_name = var.azureresourcegroup

  ip_configuration {
    name                          = "${var.azurevmname}internal"
    subnet_id                     = var.azureinternalsubnetid
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "linuxvm" {
  name                = "${var.azurevmname}vm"
  resource_group_name = var.azureresourcegroup
  location            = var.azurelocation
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.networkinterface.id,
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