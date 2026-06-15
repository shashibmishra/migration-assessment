#!/usr/bin/env bash
set -euo pipefail

if [ -z "${1-}" ]; then
  echo "Usage: $0 <image-ref>"
  exit 2
fi

image="$1"
echo "Scanning $image with Trivy..."
trivy image --exit-code 0 --severity HIGH,CRITICAL "$image"
