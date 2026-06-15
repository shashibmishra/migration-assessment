variable "prefix" {
  type = string
}

variable "location" {
  type    = string
  default = "eastus"
}

# Backend variables for remote state
variable "backend_rg_name" { type = string }
variable "backend_storage_account_name" { type = string }
variable "backend_container_name" { type = string }
variable "backend_key" { type = string }
