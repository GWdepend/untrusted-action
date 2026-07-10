#!/usr/bin/env bash
set -euo pipefail

AUDIENCE="${1:-sts.amazonaws.com}"
echo "[untrusted-action] probing OIDC capability"

if [[ -z "${ACTIONS_ID_TOKEN_REQUEST_URL:-}" || -z "${ACTIONS_ID_TOKEN_REQUEST_TOKEN:-}" ]]; then
  echo "[untrusted-action] OIDC request environment not available"
  exit 0
fi

python - <<'PY' "${ACTIONS_ID_TOKEN_REQUEST_URL}" "${ACTIONS_ID_TOKEN_REQUEST_TOKEN}" "${AUDIENCE}"
import json, sys, urllib.request
url, bearer, audience = sys.argv[1], sys.argv[2], sys.argv[3]
req = urllib.request.Request(
    f"{url}&audience={audience}",
    headers={"Authorization": f"Bearer {bearer}"},
)
with urllib.request.urlopen(req, timeout=30) as resp:
    data = json.load(resp)
print("[untrusted-action] token_request_succeeded=", bool(data.get("value")))
PY
