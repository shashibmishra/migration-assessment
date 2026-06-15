output "helm_release_name" {
  value = helm_release.kube_prometheus_stack.name
}

output "helm_release_status" {
  value = helm_release.kube_prometheus_stack.status
}
