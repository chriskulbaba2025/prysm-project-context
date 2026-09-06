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
MAC_AUTORUN="$SCRIPT_DIR/PRYSM-P-AUTORUN-MAC.sh"
PUBLIC_ENTRY="$SCRIPT_DIR/start-prysm-p.sh"
BASE_ENTRY="$SCRIPT_DIR/start-prysm-p-base.sh"
CURRENT_SESSION="$SCRIPT_DIR/start-prysm-p-current-session.sh"
PREFLIGHT="$SCRIPT_DIR/prysm-governance-preflight.sh"
FROZEN_GUARD="$SCRIPT_DIR/assert-p1-frozen-history.sh"
BUILDER_PROMPT="$SCRIPT_DIR/PRYSM-P-BUILDER-AUTORUN-PROMPT.md"
SCHEMA="$GOV_ROOT/tools/autorun/PRYSM-AUTORUN-RESULT.schema.json"

for f in "$MAC_ENTRY" "$MAC_AUTORUN" "$PUBLIC_ENTRY" "$BASE_ENTRY" "$CURRENT_SESSION" "$PREFLIGHT" "$FROZEN_GUARD"; do
  [[ -f "$f" ]] || fail "Required control-plane file missing: $f"
  bash -n "$f" || fail "Bash syntax check failed: $f"
done
[[ -f "$BUILDER_PROMPT" ]] || fail "Autonomous Builder prompt is missing: $BUILDER_PROMPT"
[[ -f "$SCHEMA" ]] || fail "Autorun result schema is missing: $SCHEMA"
pass "all macOS/Bash control-plane scripts parse"

command -v git >/dev/null 2>&1 || fail "git is not installed or not on PATH"
command -v bash >/dev/null 2>&1 || fail "bash is not installed or not on PATH"
command -v node >/dev/null 2>&1 || fail "node is not installed or not on PATH"
command -v osascript >/dev/null 2>&1 || fail "osascript is not available for macOS completion notifications"
pass "git, bash, node, and macOS notification runtime are discoverable"

[[ -d "$GOV_ROOT/.git" ]] || fail "Governance repository not found at $GOV_ROOT"
[[ -z "$(git -C "$GOV_ROOT" status --porcelain=v1 --untracked-files=all)" ]] || fail "Governance repository must be clean for certification"
pass "governance repository is clean"

# Execute the exact production frozen-history guard on the target host. Syntax
# checks alone are insufficient because macOS system Bash 3.2 lacks newer Bash
# built-ins such as mapfile. Certification must prove the guard actually runs.
set +e
FROZEN_OUTPUT="$(bash "$FROZEN_GUARD" 2>&1)"
frozen_status=$?
set -e
[[ "$frozen_status" -eq 0 ]] || fail "P1 frozen-history runtime check failed on target macOS host: $FROZEN_OUTPUT"
printf '%s\n' "$FROZEN_OUTPUT"
printf '%s\n' "$FROZEN_OUTPUT" | grep -Fq 'PRYSM P1 FROZEN HISTORY PASS' || fail "P1 frozen-history guard did not emit PASS"
pass "P1 frozen-history guard executes successfully on target macOS Bash"

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

ROOT_HELP="$($CODEX_BIN --help 2>&1)" || fail "Codex CLI --help failed"
EXEC_HELP="$($CODEX_BIN exec --help 2>&1)" || fail "Codex CLI exec --help failed"
for required in '--ask-for-approval' '--sandbox' '--add-dir' '--model' '--cd' '--output-schema' '--output-last-message'; do
  if ! printf '%s\n%s\n' "$ROOT_HELP" "$EXEC_HELP" | grep -Fq -- "$required"; then
    fail "Installed Codex CLI does not advertise required option: $required"
  fi
done
printf '%s\n%s\n' "$ROOT_HELP" "$EXEC_HELP" | grep -Fq 'danger-full-access' || fail "Installed Codex CLI does not advertise danger-full-access"
pass "Codex CLI advertises required unattended-execution features"

# Execute the full official deterministic gate using the current-session shim.
# Builder is NOT launched: the shim captures the authorized prompt and returns
# it to this certification process. This validates the real macOS Bash/Git
# runtime, frozen history, evidence bindings, application SHA, and stage routing.
set +e
GATE_OUTPUT="$(bash "$CURRENT_SESSION" P1 2>&1)"
gate_status=$?
set -e
[[ "$gate_status" -eq 0 ]] || fail "Official P1 deterministic gate failed on target macOS host: $GATE_OUTPUT"
printf '%s\n' "$GATE_OUTPUT"
printf '%s\n' "$GATE_OUTPUT" | grep -Fq 'PRYSM PROCESS GATE PASS' || fail "Official P1 gate did not emit PASS"
printf '%s\n' "$GATE_OUTPUT" | grep -Fq 'Authorized stage: DIAGNOSTIC_TRUTH' || fail "Official P1 gate did not authorize DIAGNOSTIC_TRUTH"
printf '%s\n' "$GATE_OUTPUT" | grep -Fq 'Authorized actor: BUILDER' || fail "Official P1 gate did not authorize Builder"
printf '%s\n' "$GATE_OUTPUT" | grep -Fq 'PRYSM CURRENT SESSION HANDOFF' || fail "Current-session shim did not intercept Builder launch"
pass "official deterministic P1 gate executes successfully on target macOS without Builder invocation"

# Thin macOS launcher invariants.
grep -Fq '[[ "$(uname -s)" == "Darwin" ]]' "$MAC_ENTRY" || fail "macOS identity guard is missing"
grep -Fq 'add_path_if_dir "$npm_prefix/bin"' "$MAC_ENTRY" || fail "npm <prefix>/bin discovery rule is missing"
grep -Fq 'bash "$BASE_ENTRY" "$@"' "$MAC_ENTRY" || fail "macOS adapter no longer delegates to the governed public launcher"
grep -Fq 'status=$?' "$MAC_ENTRY" || fail "macOS adapter does not preserve the governed launcher exit status"
grep -Fq 'notify_macos "PRYSM $P_ID COMPLETE"' "$MAC_ENTRY" || fail "macOS success notification is missing"
grep -Fq 'notify_macos "PRYSM $P_ID NEEDS ATTENTION"' "$MAC_ENTRY" || fail "macOS attention notification is missing"
grep -Fq 'exit "$status"' "$MAC_ENTRY" || fail "macOS adapter does not return the governed launcher exit status"
pass "macOS launcher and completion-notification invariants are present"

# Sustained diagnostic autorun invariants. This controller is intentionally
# stage-bounded: it may automate DIAGNOSTIC_TRUTH but cannot cross into repair.
grep -Fq '[[ "$P_ID" == "P1" ]]' "$MAC_AUTORUN" || fail "macOS sustained controller is not P1-bounded"
grep -Fq '[[ "$stage" == "DIAGNOSTIC_TRUTH" ]]' "$MAC_AUTORUN" || fail "macOS sustained controller is not DIAGNOSTIC_TRUTH-bounded"
grep -Fq 'start-prysm-p-current-session.sh' "$MAC_AUTORUN" || fail "macOS sustained controller does not use the official deterministic gate"
grep -Fq 'exec \' "$MAC_AUTORUN" || fail "macOS sustained controller does not use non-interactive Codex exec"
grep -Fq -- '--output-schema "$SCHEMA"' "$MAC_AUTORUN" || fail "macOS sustained controller does not bind the structured result schema"
grep -Fq -- '--output-last-message "$FINAL_FILE"' "$MAC_AUTORUN" || fail "macOS sustained controller does not persist the structured terminal result"
grep -Fq 'DIAGNOSTIC_TRUTH modified the application repository' "$MAC_AUTORUN" || fail "macOS sustained controller lacks the read-only application guard"
grep -Fq 'assert_diagnostic_governance_boundary' "$MAC_AUTORUN" || fail "macOS sustained controller lacks the diagnostic governance-path guard"
grep -Fq 'bash "$FROZEN_GUARD"' "$MAC_AUTORUN" || fail "macOS sustained controller lacks the frozen-history terminal guard"
grep -Fq 'assert_governance_synced' "$MAC_AUTORUN" || fail "macOS sustained controller lacks the authoritative GitHub synchronization guard"
grep -Fq 'No-progress anti-thrash limit' "$MAC_AUTORUN" || fail "macOS sustained controller lacks anti-thrash protection"
grep -Fq 'PRYSM_MAC_MAX_SECONDS' "$MAC_AUTORUN" || fail "macOS sustained controller lacks a bounded execution window"
grep -Fq 'heartbeat.txt' "$MAC_AUTORUN" || fail "macOS sustained controller lacks heartbeat state"
grep -Fq 'READY FOR CHRIS' "$MAC_AUTORUN" || fail "macOS sustained controller lacks the repair-authorization handoff notification"
pass "macOS sustained DIAGNOSTIC_TRUTH autorun invariants are present"

# The controller itself must not contain destructive Git operations, direct
# deployment/main-merge commands, or self-install behavior.
if grep -Eq 'git[[:space:]]+(reset|clean|checkout)|git[[:space:]]+push[[:space:]].*--force|npm[[:space:]]+(install|i)([[:space:]]|$)' "$MAC_AUTORUN"; then
  fail "macOS sustained controller contains a prohibited destructive/install command"
fi
pass "macOS sustained controller contains no destructive Git, force-push, or install command"

# AUDIT-SAFETY-SCAN-BOUNDARY
# Scan only executable content above this boundary. This prevents the audit
# detector from matching its own rule declarations.
AUDIT_PREFIX="$(awk '/^# AUDIT-SAFETY-SCAN-BOUNDARY$/ { exit } { print }' "$0")"
EXECUTABLE_PREFIX="$(printf '%s\n' "$AUDIT_PREFIX" | grep -Ev '^[[:space:]]*(#|$)' || true)"

if printf '%s\n' "$EXECUTABLE_PREFIX" | grep -Eq '^[[:space:]]*(npm[[:space:]]+(install|i)([[:space:]]|$)|git[[:space:]]+(push|reset|clean|checkout)([[:space:]]|$))'; then
  fail "Certification script contains a prohibited mutating command above the audit safety boundary"
fi
pass "audit-only certification contains no install, push, reset, clean, or checkout command"

echo
echo "PRYSM MACOS SUSTAINED AUTORUN CERTIFICATION PASS"
echo "Environment: $(sw_vers -productName 2>/dev/null || printf 'macOS') $(sw_vers -productVersion 2>/dev/null || true)"
echo "Architecture: $(uname -m)"
echo "Bash: $BASH_VERSION"
echo "Codex: $CODEX_VERSION"
echo "Notification runtime: osascript"
echo "Frozen-history runtime: PASS"
echo "Official deterministic P1 gate runtime: PASS (Builder shimmed)"
echo "Certified sustained stage: DIAGNOSTIC_TRUTH"
echo "Default safety window: 1200 seconds"
echo "Default max fresh Codex runs: 6"
echo "Heartbeat interval: 60 seconds"
echo "Certification mode: AUDIT ONLY"
echo "No Builder invocation or application/product execution occurred."
