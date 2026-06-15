# Migration Runbook (Rancher → AKS)

1. Preparation
  - Inventory workloads and exports (`discovery/export-rancher-inventory.sh`).
  - Identify PVCs, secrets, and external dependencies.

2. Provision platform (sandbox)
  - Use `terraform/modules` to provision AKS, ACR, Log Analytics, Key Vault.

3. Package & CI
  - Build images, scan, push to ACR using `cicd/` templates.

4. GitOps onboarding
  - Add application to `gitops/applications` and create env overlay.
  - Configure ArgoCD/Flux to watch repo and enable automated sync with prd gating.

Quick test notes
- Local sample container: see `docker/Dockerfile` and build using `docker build -t myregistry/sample-app:latest docker/`
- Quick deploy manifests for smoke tests: `kubectl apply -f kubernetes/sample-app/`


5. Test & Promote
  - Deploy to `dev`, run smoke tests, promote to `qa` then `prod`.

6. Rollback
  - Use GitOps commit history to revert manifest or use pipeline rollback steps.
