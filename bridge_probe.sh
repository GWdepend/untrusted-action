#!/usr/bin/env bash
set -euo pipefail

mkdir -p bridge
mkdir -p .bridge-cache

python - <<'PY'
import base64
import json
import os
from pathlib import Path

summary = {
    "canary_present": bool(os.environ.get("CANARY_SECRET")),
    "canary_length": len(os.environ.get("CANARY_SECRET", "")),
    "llm_token_present": bool(os.environ.get("OPENAI_API_KEY")),
    "llm_token_length": len(os.environ.get("OPENAI_API_KEY", "")),
    "github_token_present": bool(os.environ.get("GITHUB_TOKEN_FROM_CONTEXT")),
    "github_token_length": len(os.environ.get("GITHUB_TOKEN_FROM_CONTEXT", "")),
    "event_name": os.environ.get("PROBE_EVENT_NAME", ""),
    "repository": os.environ.get("PROBE_REPOSITORY", ""),
    "ref": os.environ.get("PROBE_REF", ""),
}
encoded = base64.b64encode(json.dumps(summary, sort_keys=True).encode("utf-8")).decode("ascii")
Path("bridge/summary.json").write_text(json.dumps(summary, indent=2, sort_keys=True), encoding="utf-8")
Path(".bridge-cache/summary.json").write_text(json.dumps(summary, indent=2, sort_keys=True), encoding="utf-8")
with open(os.environ["GITHUB_OUTPUT"], "a", encoding="utf-8") as fh:
    fh.write(f"bridge_summary_b64={encoded}\n")
print("[untrusted-action] bridge summary written to outputs, artifact path, and cache path")
PY
