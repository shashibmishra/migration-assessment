provider "azurerm" {
  features = {}
}

variable "prefix" {}
variable "location" { default = "eastus" }

module "aks" {
  source = "./modules/aks"
  rg_name = "${var.prefix}-rg"
  location = var.location
  cluster_name = "${var.prefix}-aks"
  vnet_subnet_id = module.network.subnet_id
  private_cluster = false
}

module "network" {
  source = "./modules/network"
  rg_name = "${var.prefix}-rg"
  location = var.location
  vnet_name = "${var.prefix}-vnet"
  address_space = ["10.1.0.0/16"]
  aks_subnet_name = "${var.prefix}-aks-subnet"
  aks_subnet_prefixes = ["10.1.1.0/24"]
  firewall_subnet_name = "AzureFirewallSubnet"
  firewall_subnet_prefixes = ["10.1.254.0/24"]
}

module "nat" {
  source = "./modules/nat_gateway"
  rg_name = "${var.prefix}-rg"
  location = var.location
  name_prefix = var.prefix
  subnet_id = module.network.aks_subnet_id
}

module "firewall" {
  source = "./modules/firewall"
  rg_name = "${var.prefix}-rg"
  location = var.location
  name_prefix = var.prefix
  firewall_subnet_id = module.network.firewall_subnet_id
}

# Role assignments: grant AKS identity access to ACR and Key Vault
data "azurerm_role_definition" "acr_pull" {
  name = "AcrPull"
}

data "azurerm_role_definition" "kv_secrets_user" {
  name = "Key Vault Secrets User"
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  scope              = module.acr.acr_id
  role_definition_id = data.azurerm_role_definition.acr_pull.id
  principal_id       = module.aks.kubelet_identity_object_id
}

resource "azurerm_role_assignment" "aks_kv_secrets" {
  scope              = module.keyvault.keyvault_id
  role_definition_id = data.azurerm_role_definition.kv_secrets_user.id
  principal_id       = module.aks.identity_principal_id
}


module "acr" {
  source = "./modules/acr"
  rg_name = "${var.prefix}-rg"
  location = var.location
  acr_name = "${var.prefix}acr"
}

module "log_analytics" {
  source = "./modules/log-analytics"
  rg_name = "${var.prefix}-rg"
  location = var.location
}

module "keyvault" {
  source = "./modules/keyvault"
  rg_name = "${var.prefix}-rg"
  location = var.location
  kv_name = "${var.prefix}-kv"
}
