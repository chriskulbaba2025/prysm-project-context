#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# One public entrypoint, safe in both contexts.
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
