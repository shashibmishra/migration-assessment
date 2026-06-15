resource "azurerm_private_endpoint" "pe" {
  name                = "${var.name_prefix}-pe"
  location            = var.location
  resource_group_name = var.rg_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.name_prefix}-psc"
    is_manual_connection           = false
    private_connection_resource_id = var.target_resource_id
    subresource_names              = var.subresource_names
  }
}

output "private_endpoint_id" {
  value = azurerm_private_endpoint.pe.id
}
