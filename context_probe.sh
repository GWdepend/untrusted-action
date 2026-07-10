#!/usr/bin/env bash
set -euo pipefail

echo "[untrusted-action] actor=${PROBE_ACTOR:-}"
echo "[untrusted-action] triggering_actor=${PROBE_TRIGGERING_ACTOR:-}"
echo "[untrusted-action] repository=${PROBE_REPOSITORY:-}"
echo "[untrusted-action] ref=${PROBE_REF:-}"
echo "[untrusted-action] workflow_ref=${PROBE_WORKFLOW_REF:-}"
echo "[untrusted-action] workflow_sha=${PROBE_WORKFLOW_SHA:-}"
echo "[untrusted-action] event_name=${PROBE_EVENT_NAME:-}"
