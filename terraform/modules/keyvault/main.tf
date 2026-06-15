resource "azurerm_key_vault" "kv" {
  name                        = var.kv_name
  location                    = var.location
  resource_group_name         = var.rg_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  purge_protection_enabled    = false
  soft_delete_enabled         = true
}

data "azurerm_client_config" "current" {}

output "keyvault_id" {
  value = azurerm_key_vault.kv.id
}
