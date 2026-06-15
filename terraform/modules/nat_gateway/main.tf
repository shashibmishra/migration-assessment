resource "azurerm_public_ip" "nat_ip" {
  name                = "${var.name_prefix}-nat-pip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway" "nat" {
  name                = "${var.name_prefix}-nat"
  location            = var.location
  resource_group_name = var.rg_name
  sku_name            = "Standard"

  public_ip_address_ids = [azurerm_public_ip.nat_ip.id]
}

resource "azurerm_subnet_nat_gateway_association" "assoc" {
  subnet_id     = var.subnet_id
  nat_gateway_id = azurerm_nat_gateway.nat.id
}

output "nat_gateway_id" {
  value = azurerm_nat_gateway.nat.id
}
