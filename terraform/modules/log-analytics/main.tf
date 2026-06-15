resource "azurerm_log_analytics_workspace" "law" {
  name                = "${var.rg_name}-law"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "PerGB2018"
}

output "log_analytics_workspace_id" {
  value = azurerm_log_analytics_workspace.law.id
}
