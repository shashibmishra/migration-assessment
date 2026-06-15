variable "release_name" {
  type    = string
  default = "kube-prom-stack"
}

variable "namespace" {
  type    = string
  default = "monitoring"
}

variable "chart_version" {
  type    = string
  default = "~>45.0.0"
}
