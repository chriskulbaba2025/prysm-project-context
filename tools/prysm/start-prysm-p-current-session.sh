#!/usr/bin/env bash
set -euo pipefail

P_ID="${1:-}"

fail() {
  echo >&2
  echo "PRYSM CURRENT-SESSION LAUNCH FAIL: $1" >&2
  exit 1
}

[[ -n "$P_ID" ]] || fail "Usage: bash tools/prysm/start-prysm-p-current-session.sh P1"
[[ "$P_ID" =~ ^P([1-9]|10)([A-Z][A-Z0-9-]*)?$ ]] || fail "Invalid P# '$P_ID'."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_LAUNCHER="$SCRIPT_DIR/start-prysm-p.sh"

[[ -f "$BASE_LAUNCHER" ]] || fail "Governed base launcher is missing: $BASE_LAUNCHER"

# The normal launcher deliberately hands off to a new Codex CLI process after
# all machine gates pass. When the launcher is invoked from an existing Codex
# session, spawning Codex again is both unnecessary and unreliable (no TTY /
# child shell PATH differences). Provide a temporary local handoff shim so the
# exact same governed machine gate runs unchanged, but its final Codex handoff
# is returned to the already-running Codex session instead of nesting Codex.
SHIM_DIR="$(mktemp -d)"
cleanup() {
  rm -rf "$SHIM_DIR"
}
trap cleanup EXIT

cat > "$SHIM_DIR/codex" <<'SHIM'
#!/usr/bin/env bash
set -euo pipefail

PROMPT="${1:-}"

echo
echo "PRYSM CURRENT SESSION HANDOFF"
echo "The governed machine launcher passed. Continue in THIS existing Codex session."
echo "Do not launch another Codex process and do not rerun the launcher."
echo "Treat the following governed handoff prompt as the active instruction:"
echo "----- PRYSM GOVERNED HANDOFF START -----"
printf '%s\n' "$PROMPT"
echo "----- PRYSM GOVERNED HANDOFF END -----"
SHIM
chmod +x "$SHIM_DIR/codex"

PATH="$SHIM_DIR:$PATH" bash "$BASE_LAUNCHER" "$P_ID"
