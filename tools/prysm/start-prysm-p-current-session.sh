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
GOV_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
BASE_LAUNCHER="$SCRIPT_DIR/start-prysm-p-base.sh"
P1_FROZEN_HISTORY_GUARD="$SCRIPT_DIR/assert-p1-frozen-history.sh"

[[ -f "$BASE_LAUNCHER" ]] || fail "Governed base launcher is missing: $BASE_LAUNCHER"

# Make direct current-session use self-diagnosing too. The public launcher
# normally runs the shared preflight first, but this internal wrapper keeps an
# exact dirty-tree guard in case it is invoked directly by an agent.
DIRTY_STATUS="$(git -C "$GOV_ROOT" status --porcelain=v1 --untracked-files=all)"
if [[ -n "$DIRTY_STATUS" ]]; then
  echo >&2
  echo "PRYSM GOVERNANCE DIRTY ENTRIES (as seen by Bash/Git):" >&2
  printf '%s\n' "$DIRTY_STATUS" >&2
  fail "Governance repository has uncommitted changes. Resolve only the listed entries before rerunning."
fi

# P1 historical evidence is immutable. Every deterministic P1 gate verifies
# the exhaustive baseline-derived frozen set before any actor handoff can PASS.
if [[ "$P_ID" == "P1" ]]; then
  [[ -f "$P1_FROZEN_HISTORY_GUARD" ]] || fail "P1 frozen-history guard is missing: $P1_FROZEN_HISTORY_GUARD"
  bash "$P1_FROZEN_HISTORY_GUARD" || fail "P1 frozen-history verification failed."
fi

# Only Builder-owned stages need a Codex handoff. If the base launcher reaches
# such a handoff while already inside Codex, this temporary shim returns the
# authorized stage prompt to the existing session instead of nesting Codex.
# Brad/Chris-owned stages never call the shim; the base launcher prints the
# deterministic role handoff directly.
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
echo "The governed deterministic launcher passed. Continue in THIS existing Codex session."
echo "Do not launch another Codex process and do not rerun the process gate."
echo "Treat the following governed stage prompt as the active instruction:"
echo "----- PRYSM GOVERNED HANDOFF START -----"
printf '%s\n' "$PROMPT"
echo "----- PRYSM GOVERNED HANDOFF END -----"
SHIM
chmod +x "$SHIM_DIR/codex"

PATH="$SHIM_DIR:$PATH" exec bash "$BASE_LAUNCHER" "$P_ID"
