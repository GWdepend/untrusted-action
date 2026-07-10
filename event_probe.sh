#!/usr/bin/env bash
set -euo pipefail

if [[ ! -f "${GITHUB_EVENT_PATH:-}" ]]; then
  echo "[untrusted-action] event payload file is not present"
  exit 0
fi

echo "[untrusted-action] event payload file is present"
echo "[untrusted-action] event_name=${PROBE_EVENT_NAME:-unknown}"

python - <<'PY'
import json
import os

path = os.environ["GITHUB_EVENT_PATH"]
with open(path, "r", encoding="utf-8") as fh:
    data = json.load(fh)

summary = {
    "top_level_keys": sorted(list(data.keys()))[:10],
    "has_repository": "repository" in data,
    "has_sender": "sender" in data,
    "has_workflow": "workflow" in data,
    "action": data.get("action"),
    "ref": data.get("ref"),
}
print("[untrusted-action] event payload summary")
print(json.dumps(summary, sort_keys=True))
PY
