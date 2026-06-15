#!/usr/bin/env bash
set -euo pipefail

# Preview rendered manifests for kube-prometheus-stack using the values file in this repo.
# Usage: ./tools/preview-helm.sh [chart-version]

DIR="$(cd "$(dirname "$0")/.." && pwd)"
VALUES_FILE="$DIR/helm/observability/values.yaml"
CHART_NAME="prometheus-community/kube-prometheus-stack"
REPO_NAME="prometheus-community"
REPO_URL="https://prometheus-community.github.io/helm-charts"

version="$1"

echo "Adding helm repo $REPO_NAME -> $REPO_URL"
helm repo add "$REPO_NAME" "$REPO_URL" >/dev/null 2>&1 || true
helm repo update >/dev/null

if [ -n "${version:-}" ]; then
  echo "Rendering chart $CHART_NAME (version $version)"
  helm template preview "$CHART_NAME" --version "$version" -f "$VALUES_FILE"
else
  echo "Rendering chart $CHART_NAME (latest)"
  helm template preview "$CHART_NAME" -f "$VALUES_FILE"
fi
