 # Migration Assessment Workspace

 This repository contains a structured workspace to complete the "Rancher → AKS Migration" assessment. Use this as a starting point and adapt values/credentials before running any provisioning.

 Repository layout

 - `discovery/` — scripts to inventory Rancher clusters and export manifests
 - `docker/` — sample `Dockerfile` and container artifacts for the sample app
 - `kubernetes/` — raw Kubernetes manifests and overlays for manual testing
 - `helm/` — example Helm charts and `values` for `dev`, `qa`, `prod`
 - `cicd/` — CI/CD pipeline examples for GitHub Actions and Azure DevOps
 - `gitops/`
	 - `argocd-apps/` — ArgoCD `Application` manifests
	 - `flux-config/` — Flux bootstrap/config placeholders
 - `terraform/` — Infrastructure as Code modules and example root configs
 - `observability/`
	 - `dashboards/` — Grafana JSON dashboards
	 - `alerts/` — Prometheus/Grafana alert rules
 - `security/`
	 - `trivy-report/` — image scan reports
	 - `checkov-report/` — IaC scan reports
	 - `policy-examples/` — Kyverno/Gatekeeper/OPA examples
 - `sre/` — SLIs/SLOs and incident response runbooks
 - `runbooks/` — migration runbooks and operational guides
 - `doc/` — architecture diagrams, presentation materials, and supporting docs

 Quick start snippets

 1) Create remote Terraform backend storage (or update `terraform/terraform.tfvars.example`) then run:

```bash
cd terraform
terraform init
terraform plan -var-file=terraform.tfvars
```

2) Inventory Rancher clusters (read-only export):

```bash
cd discovery
./export-rancher-inventory.sh
```

3) Build the sample container and push to your registry (example):

```bash
cd docker
docker build -t myregistry/sample-app:latest .
docker push myregistry/sample-app:latest
```

4) Deploy sample manifests for quick testing (requires cluster context):

```bash
kubectl apply -f kubernetes/sample-app/
```