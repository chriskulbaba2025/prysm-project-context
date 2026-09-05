#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PREFLIGHT="$SCRIPT_DIR/prysm-governance-preflight.sh"

[[ -f "$PREFLIGHT" ]] || {
  echo "PRYSM PROCESS GATE FAIL: governance pre-flight helper is missing: $PREFLIGHT" >&2
  exit 1
}

# Always run the same cleanliness/hygiene check before selecting the execution
# context. This prevents local diagnostic artifacts from becoming false gate
# blockers and prints exact real blockers when the tree is genuinely dirty.
bash "$PREFLIGHT"

# One public Bash entrypoint, safe in both contexts.
# Codex command shells expose CODEX_THREAD_ID. If the launcher is invoked from
# an already-running Codex session, route to the current-session wrapper so we
# run the exact same governed machine gate without nesting another Codex CLI.
if [[ -n "${CODEX_THREAD_ID:-}" ]]; then
  exec bash "$SCRIPT_DIR/start-prysm-p-current-session.sh" "$@"
fi

# Normal terminal / new-process path (Brad macOS, or Windows via the PS1
# wrapper). The frozen base launcher performs the governed machine checks and
# launches Codex only after they pass.
exec bash "$SCRIPT_DIR/start-prysm-p-base.sh" "$@"
