provider "helm" {
  kubernetes {
    config_path = var.kubeconfig_path
  }
}

resource "helm_release" "kube_prometheus_stack" {
  name       = var.release_name
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = var.chart_version
  namespace  = var.namespace

  # Use a values file committed to the repo; adjust path as needed
  values = [file("${path.module}/../../helm/observability/values.yaml")]

  # wait for CRDs and resources to be ready
  timeout = 600
}
