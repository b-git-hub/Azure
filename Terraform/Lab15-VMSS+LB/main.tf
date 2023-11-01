## Get the existing resource group 
data "azurerm_resource_group" "rg" {
  name = "rg"
}

## Public IP for load balancer
resource "azurerm_public_ip" "lbpublicip" {
  name                = "PublicIPForLB"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}

## Create Load Balancer 
resource "azurerm_lb" "lb" {
  name                = "LBForVMSS"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lbpublicip.id
  }
}

## Create Load Balancer Backend
resource "azurerm_lb_backend_address_pool" "lbbackend" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "lbbackend"
}

## Create Virtual Network for LB Backend
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]
}

##Create lb rule to connect to backend
resource "azurerm_lb_rule" "lbnatrule" {
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "http"
  protocol                       = "Tcp"
  frontend_port                  = var.application_port
  backend_port                   = var.application_port
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lbbackend.id]
  frontend_ip_configuration_name = "PublicIPAddress"
}

## Create the VMSS 
resource "azurerm_windows_virtual_machine_scale_set" "vmss" {
  name                = "vmss"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  sku                 = "Standard_DS1_v2"
  instances           = 1
  admin_password      = var.azure_vm_password
  admin_username      = "adminuser"

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "vmssnetworkcard"
    primary = true

    ip_configuration {
      name                                   = "internal"
      primary                                = true
      subnet_id                              = azurerm_subnet.internal.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.lbbackend.id]
    }
  }
}

## Subnet for VMs
resource "azurerm_subnet" "internal" {
  name                 = "vmsubnet"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}





## VMSS to call custom script
resource "azurerm_virtual_machine_scale_set_extension" "vmss" {
  name                         = "vmsscustomscript"
  virtual_machine_scale_set_id = azurerm_windows_virtual_machine_scale_set.vmss.id
  publisher                    = "Microsoft.Compute"
  type                         = "CustomScriptExtension"
  type_handler_version         = "1.10"
  settings = jsonencode({
    "fileUris" : ["https://demostorage56316.blob.core.windows.net/democontainer56316/customscriptazure.ps1"],
    "commandToExecute" : "powershell -ExecutionPolicy Unrestricted -file customscriptazure.ps1"
  })
}