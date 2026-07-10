#!/usr/bin/env bash
set -euo pipefail

if [[ -n "${LAB_PUBLIC_ENDPOINT:-}" ]]; then
  echo "[untrusted-action] LAB_PUBLIC_ENDPOINT=${LAB_PUBLIC_ENDPOINT}"
else
  echo "[untrusted-action] LAB_PUBLIC_ENDPOINT is not present"
fi

if [[ -n "${LAB_MODEL_PROVIDER:-}" ]]; then
  echo "[untrusted-action] LAB_MODEL_PROVIDER=${LAB_MODEL_PROVIDER}"
else
  echo "[untrusted-action] LAB_MODEL_PROVIDER is not present"
fi

if [[ -n "${LAB_NONSECRET_MARKER:-}" ]]; then
  echo "[untrusted-action] LAB_NONSECRET_MARKER=${LAB_NONSECRET_MARKER}"
else
  echo "[untrusted-action] LAB_NONSECRET_MARKER is not present"
fi
