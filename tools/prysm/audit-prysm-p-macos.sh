#!/usr/bin/env bash
set -euo pipefail

fail() {
  echo >&2
  echo "PRYSM MACOS CERTIFICATION FAIL: $1" >&2
  exit 1
}

pass() {
  printf 'PASS: %s\n' "$1"
}

[[ "$(uname -s)" == "Darwin" ]] || fail "Certification must run on the target macOS host."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GOV_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
MAC_ENTRY="$SCRIPT_DIR/start-prysm-p-macos.sh"
PUBLIC_ENTRY="$SCRIPT_DIR/start-prysm-p.sh"
BASE_ENTRY="$SCRIPT_DIR/start-prysm-p-base.sh"
CURRENT_SESSION="$SCRIPT_DIR/start-prysm-p-current-session.sh"
PREFLIGHT="$SCRIPT_DIR/prysm-governance-preflight.sh"

for f in "$MAC_ENTRY" "$PUBLIC_ENTRY" "$BASE_ENTRY" "$CURRENT_SESSION" "$PREFLIGHT"; do
  [[ -f "$f" ]] || fail "Required control-plane file missing: $f"
  bash -n "$f" || fail "Bash syntax check failed: $f"
done
pass "all macOS/Bash control-plane scripts parse"

command -v git >/dev/null 2>&1 || fail "git is not installed or not on PATH"
command -v bash >/dev/null 2>&1 || fail "bash is not installed or not on PATH"
command -v osascript >/dev/null 2>&1 || fail "osascript is not available for macOS completion notifications"
pass "git, bash, and macOS notification runtime are discoverable"

[[ -d "$GOV_ROOT/.git" ]] || fail "Governance repository not found at $GOV_ROOT"
[[ -z "$(git -C "$GOV_ROOT" status --porcelain=v1 --untracked-files=all)" ]] || fail "Governance repository must be clean for certification"
pass "governance repository is clean"

# Reproduce the macOS adapter's executable discovery without launching PRYSM,
# providers, product tests, or application work.
resolve_codex() {
  command -v codex 2>/dev/null && return 0

  local candidate npm_prefix
  for candidate in "/opt/homebrew/bin" "/usr/local/bin" "$HOME/.local/bin" "$HOME/.npm-global/bin"; do
    if [[ -x "$candidate/codex" ]]; then
      printf '%s\n' "$candidate/codex"
      return 0
    fi
  done

  if command -v npm >/dev/null 2>&1; then
    npm_prefix="$(npm config get prefix 2>/dev/null || true)"
    if [[ -n "$npm_prefix" && "$npm_prefix" != "undefined" && -x "$npm_prefix/bin/codex" ]]; then
      printf '%s\n' "$npm_prefix/bin/codex"
      return 0
    fi
  fi

  return 1
}

CODEX_BIN="$(resolve_codex)" || fail "Codex CLI is not discoverable through the certified macOS resolution rules"
[[ -x "$CODEX_BIN" ]] || fail "Resolved Codex path is not executable: $CODEX_BIN"
pass "Codex CLI resolved at $CODEX_BIN"

CODEX_VERSION="$($CODEX_BIN --version 2>&1)" || fail "Codex CLI --version failed"
[[ -n "$CODEX_VERSION" ]] || fail "Codex CLI returned an empty version"
printf 'PASS: Codex CLI responds: %s\n' "$CODEX_VERSION"

# Static contract assertions: the macOS adapter must remain a thin environment
# adapter and delegate to the same governed public launcher used elsewhere.
grep -Fq '[[ "$(uname -s)" == "Darwin" ]]' "$MAC_ENTRY" || fail "macOS identity guard is missing"
grep -Fq 'add_path_if_dir "$npm_prefix/bin"' "$MAC_ENTRY" || fail "npm <prefix>/bin discovery rule is missing"
grep -Fq 'bash "$BASE_ENTRY" "$@"' "$MAC_ENTRY" || fail "macOS adapter no longer delegates to the governed public launcher"
grep -Fq 'status=$?' "$MAC_ENTRY" || fail "macOS adapter does not preserve the governed launcher exit status"
grep -Fq 'notify_macos "PRYSM $P_ID COMPLETE"' "$MAC_ENTRY" || fail "macOS success notification is missing"
grep -Fq 'notify_macos "PRYSM $P_ID NEEDS ATTENTION"' "$MAC_ENTRY" || fail "macOS attention notification is missing"
grep -Fq 'exit "$status"' "$MAC_ENTRY" || fail "macOS adapter does not return the governed launcher exit status"
pass "macOS adapter and completion-notification invariants are present"

# AUDIT-SAFETY-SCAN-BOUNDARY
# Scan only executable content above this boundary. This prevents the safety
# detector from ever matching its own rule declarations.
AUDIT_PREFIX="$(awk '/^# AUDIT-SAFETY-SCAN-BOUNDARY$/ { exit } { print }' "$0")"
EXECUTABLE_PREFIX="$(printf '%s\n' "$AUDIT_PREFIX" | grep -Ev '^[[:space:]]*(#|$)' || true)"

if printf '%s\n' "$EXECUTABLE_PREFIX" | grep -Eq '^[[:space:]]*(exec[[:space:]]+codex([[:space:]]|$)|codex[[:space:]]+[^-]|npm[[:space:]]+(install|i)([[:space:]]|$)|git[[:space:]]+(push|reset|clean|checkout)([[:space:]]|$))'; then
  fail "Certification script contains a prohibited Builder/mutating command above the audit safety boundary"
fi
pass "audit-only script contains no Builder launch, install, push, reset, clean, or checkout command"

echo
echo "PRYSM MACOS AUTORUN CERTIFICATION PASS"
echo "Environment: $(sw_vers -productName 2>/dev/null || printf 'macOS') $(sw_vers -productVersion 2>/dev/null || true)"
echo "Architecture: $(uname -m)"
echo "Codex: $CODEX_VERSION"
echo "Notification runtime: osascript"
echo "Certification mode: AUDIT ONLY"
echo "No Builder invocation or application/product execution occurred."
