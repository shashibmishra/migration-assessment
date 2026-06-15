variable "rg_name" {
  type = string
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "cluster_name" {
  type = string
}

variable "node_count" {
  type    = number
  default = 3
}

variable "node_vm_size" {
  type    = string
  default = "Standard_DS2_v2"
}

variable "vnet_subnet_id" {
  type    = string
  default = ""
}

variable "private_cluster" {
  type    = bool
  default = false
}
