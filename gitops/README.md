# GitOps repository structure

Suggested structure for ArgoCD/Flux:

```
gitops/
  applications/
  environments/
    dev/
    qa/
    prod/
  platform/
```

Place application manifests or Helm chart references under `applications/` and environment-specific overlays under `environments/`.
