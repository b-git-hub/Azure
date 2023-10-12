resource "azurerm_resource_group" "main_rg" {
  name     = "main_rg1"
  location = "UK South"
}

resource "azurerm_virtual_network" "main_vn" {
  name                = "main_vn"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name
}

resource "azurerm_subnet" "linux_vm_subnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.main_rg.name
  virtual_network_name = azurerm_virtual_network.main_vn.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_network_interface" "linux_vm_int_net_interface" {
  name                = "linux_vm_int_net_interface"
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.linux_vm_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "linuxvm" {
  name                = "linuxvm"
  resource_group_name = azurerm_resource_group.main_rg.name
  location            = azurerm_resource_group.main_rg.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.linux_vm_int_net_interface.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("linux_vm.pub")
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