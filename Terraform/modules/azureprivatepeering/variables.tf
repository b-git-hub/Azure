variable "azureresourcegroup" {
  type    = string
}

variable "azuresourceaddressspace" {
  type    = string
}

variable "azuredestinationaddressspace" {
  type    = string
}

variable "azuredestinationaddressspaceid" {
  type    = string
}

variable "azuresourceaddressspaceid" {
  type    = string
}

variable "allowforwardedtraffic" {
  type    = bool
  default = false
}
