#!/usr/bin/env bash
set -euo pipefail

if [[ -n "${CANARY_SECRET:-}" ]]; then
  echo "[untrusted-action] canary secret is present"
  echo "[untrusted-action] canary length=${#CANARY_SECRET}"
else
  echo "[untrusted-action] canary secret is not present"
fi

if [[ -n "${OPENAI_API_KEY:-}" ]]; then
  echo "[untrusted-action] llm token secret is present"
  echo "[untrusted-action] llm token length=${#OPENAI_API_KEY}"
else
  echo "[untrusted-action] llm token secret is not present"
fi
