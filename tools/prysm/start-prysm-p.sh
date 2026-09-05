#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PREFLIGHT="$SCRIPT_DIR/prysm-governance-preflight.sh"

[[ -f "$PREFLIGHT" ]] || {
  echo "PRYSM PROCESS GATE FAIL: governance pre-flight helper is missing: $PREFLIGHT" >&2
  exit 1
}

# Always run the same cleanliness/hygiene check before selecting execution
# context. This prevents local diagnostic artifacts from becoming false gate
# blockers and prints exact real blockers when the tree is genuinely dirty.
bash "$PREFLIGHT"

# One public Bash entrypoint, safe in both contexts.
# If already inside Codex, the internal wrapper prevents nested Codex only when
# the deterministic gate reaches a Builder-owned stage. Brad/Chris-owned stages
# return their role handoff directly and never require Codex.
if [[ -n "${CODEX_THREAD_ID:-}" ]]; then
  exec bash "$SCRIPT_DIR/start-prysm-p-current-session.sh" "$@"
fi

# Normal terminal path (Brad macOS, or Windows via the PS1 wrapper). The base
# launcher performs the deterministic gate once and then routes to the exact
# authorized actor for the stage.
exec bash "$SCRIPT_DIR/start-prysm-p-base.sh" "$@"
