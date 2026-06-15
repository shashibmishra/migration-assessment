variable "rg_name" { type = string }
variable "location" { type = string }
variable "vnet_name" { type = string }
variable "address_space" { type = list(string) }

# AKS subnet
variable "aks_subnet_name" { type = string }
variable "aks_subnet_prefixes" { type = list(string) }

# Firewall subnet (AzureFirewallSubnet recommended name)
variable "firewall_subnet_name" { type = string }
variable "firewall_subnet_prefixes" { type = list(string) }
