variable "azurelocation" {
  type    = string
  default = "westeurope"
}

variable "azureresourcegroup" {
  type    = string
  default = "mainRg123"
}

variable "azurevmnetworkinformation" {
  type = map(any)
  default = {
    network1 = {
      addressspacename   = "network1"
      addressspacesubnet = "10.0.0.0/16"
      subnet             = "10.0.0.0/24"
    }
  }
}

variable "azurefwnetworkinformation" {
  type = map(any)
  default = {
    azurefirewall = {
      addressspacename   = "azurefirewalladdressspace"
      addressspacesubnet = "10.0.0.0/16"
      subnet             = "10.0.0.0/24"
    }
  }
}

