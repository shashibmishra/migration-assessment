# Prometheus & Grafana (observability notes)

This folder contains guidance for deploying Prometheus and Grafana on AKS or using Azure Monitor.

- Use the Prometheus Community Helm chart or `kube-prometheus-stack`.
- Configure `ServiceMonitors` for application metrics.
- Export dashboards into `observability/grafana/dashboards`.
