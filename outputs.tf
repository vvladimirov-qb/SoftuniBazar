output "webapp_url" {
  value = azurerm_linux_web_app.softunibazar.default_hostname
}

output "webapp_ips" {
  value = azurerm_linux_web_app.softunibazar.outbound_ip_addresses
}