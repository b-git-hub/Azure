variable "azure_location" {
  type    = string
  default = "westeurope"
}

variable "azure_rg_name" {
  type    = string
  default = "mainRg123"
}

variable "azure_vm_password" {
  type = string
}

variable "azure_vn_name" {
  type    = string
  default = "azurevn"
}