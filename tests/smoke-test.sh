#!/usr/bin/env bash
set -euo pipefail

url="${1:-http://sample-app.default.svc.cluster.local/healthz}"
echo "Running smoke test against $url"
if curl -fsS "$url" >/dev/null; then
  echo "SMOKE TEST OK"
  exit 0
else
  echo "SMOKE TEST FAILED"
  exit 2
fi
