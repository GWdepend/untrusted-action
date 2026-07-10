#!/usr/bin/env bash
set -euo pipefail

if [[ -n "${GITHUB_TOKEN_FROM_CONTEXT:-}" ]]; then
  echo "[untrusted-action] github token from context is present"
  echo "[untrusted-action] github token length=${#GITHUB_TOKEN_FROM_CONTEXT}"
else
  echo "[untrusted-action] github token from context is not present"
  exit 0
fi

python - <<'PY'
import json
import os
import urllib.request

repo = os.environ.get("GITHUB_REPOSITORY", "")
api = os.environ.get("GITHUB_API_URL", "https://api.github.com")
token = os.environ.get("GITHUB_TOKEN_FROM_CONTEXT", "")

req = urllib.request.Request(
    f"{api}/repos/{repo}",
    headers={"Authorization": f"Bearer {token}", "Accept": "application/vnd.github+json"},
)
with urllib.request.urlopen(req, timeout=30) as resp:
    data = json.load(resp)
print("[untrusted-action] github api probe succeeded")
print(json.dumps({"full_name": data.get("full_name"), "private": data.get("private")}, sort_keys=True))
PY
