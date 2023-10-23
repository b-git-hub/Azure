variable "azurelocation" {
  type    = string
  default = "westeurope"
}

variable "azureresourcegroup" {
  type    = string
  default = "mainRg123"
}

variable "azureipinformation" {
  type    = map(any)
  default = {
    addressspaceazurefirewall = {
        addressspacename = "azurefirewalladdressspace"
        addressspacesubnet = "10.0.0.0/16"
        subnet = "10.0.0.0/24"
    }
  }
}
