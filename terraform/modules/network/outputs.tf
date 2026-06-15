output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}
output "aks_subnet_id" {
  value = azurerm_subnet.aks.id
}

output "firewall_subnet_id" {
  value = azurerm_subnet.firewall.id
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}
