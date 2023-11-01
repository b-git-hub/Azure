output "publicip" {
  value = azurerm_public_ip.lbpublicip.ip_address
}
