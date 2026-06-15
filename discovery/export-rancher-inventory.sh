#!/usr/bin/env bash
set -euo pipefail

# Read-only discovery script to export Rancher-managed cluster metadata and manifests.
# Requires: kubectl, jq, rancher CLI (optional)

OUTDIR="./exports/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$OUTDIR"

echo "Exporting clusters and namespaces..."

# If rancher CLI present, list clusters
if command -v rancher >/dev/null 2>&1; then
  rancher clusters list -o json > "$OUTDIR/rancher-clusters.json" || true
fi

clusters=$(kubectl config get-contexts -o name || true)
echo "Found contexts:" > "$OUTDIR/contexts.txt"
kubectl config get-contexts -o name >> "$OUTDIR/contexts.txt" || true

for ctx in $clusters; do
  echo "Processing context: $ctx"
  kubectl --context "$ctx" get ns -o json > "$OUTDIR/${ctx}_namespaces.json" || true
  mkdir -p "$OUTDIR/$ctx/manifests"

  # Export common resource types per namespace
  for ns in $(kubectl --context "$ctx" get ns -o jsonpath='{.items[*].metadata.name}'); do
    echo "  exporting namespace: $ns"
    nsdir="$OUTDIR/$ctx/manifests/$ns"
    mkdir -p "$nsdir"
    kubectl --context "$ctx" -n "$ns" get deploy,sts,ds,svc,ingress,cm,secret,pvc -o yaml > "$nsdir/resources.yaml" || true
    kubectl --context "$ctx" -n "$ns" get jobs,cronjobs -o yaml >> "$nsdir/resources.yaml" || true
  done
done

echo "Discovery exports written to: $OUTDIR"
