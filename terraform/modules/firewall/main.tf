resource "azurerm_public_ip" "fw_pip" {
  name                = "${var.name_prefix}-fw-pip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "fw" {
  name                = "${var.name_prefix}-fw"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.firewall_subnet_id
    public_ip_address_id = azurerm_public_ip.fw_pip.id
  }
}

output "firewall_id" {
  value = azurerm_firewall.fw.id
}
