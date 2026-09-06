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
AUTH_FILE="$GOV_ROOT/proof/P1/reopen/P1_BOUNDED_REPAIR_AUTHORIZATION_R2_2026-09-06.md"

for f in "$MAC_ENTRY" "$MAC_AUTORUN" "$PUBLIC_ENTRY" "$BASE_ENTRY" "$CURRENT_SESSION" "$PREFLIGHT" "$FROZEN_GUARD"; do
  [[ -f "$f" ]] || fail "Required control-plane file missing: $f"
  bash -n "$f" || fail "Bash syntax check failed: $f"
done
[[ -f "$BUILDER_PROMPT" ]] || fail "Autonomous Builder prompt is missing: $BUILDER_PROMPT"
[[ -f "$SCHEMA" ]] || fail "Autorun result schema is missing: $SCHEMA"
[[ -f "$AUTH_FILE" ]] || fail "R2 bounded repair authorization is missing: $AUTH_FILE"
pass "all macOS/Bash control-plane scripts parse"

# The certified runtime is Brad's system Bash 3.2. Reject known Bash-4-only
# constructs in the active shell control plane before any Builder execution.
for compat in "$MAC_ENTRY" "$MAC_AUTORUN" "$PUBLIC_ENTRY" "$BASE_ENTRY" "$CURRENT_SESSION" "$PREFLIGHT" "$FROZEN_GUARD"; do
  if grep -Eq '(^|[[:space:]])(mapfile|readarray)([[:space:]]|$)|(^|[[:space:]])(declare|typeset)[[:space:]]+-A([[:space:]]|$)' "$compat"; then
    fail "Bash 3.2-incompatible construct found in active control-plane file: $compat"
  fi
done
pass "active macOS control plane contains no known Bash-4-only array built-ins"

command -v git >/dev/null 2>&1 || fail "git is not installed or not on PATH"
command -v bash >/dev/null 2>&1 || fail "bash is not installed or not on PATH"
command -v node >/dev/null 2>&1 || fail "node is not installed or not on PATH"
command -v osascript >/dev/null 2>&1 || fail "osascript is not available for macOS completion notifications"
pass "git, bash, node, and macOS notification runtime are discoverable"

[[ -d "$GOV_ROOT/.git" ]] || fail "Governance repository not found at $GOV_ROOT"
[[ -z "$(git -C "$GOV_ROOT" status --porcelain=v1 --untracked-files=all)" ]] || fail "Governance repository must be clean for certification"
pass "governance repository is clean"

# Execute the exact frozen-history guard on the target host rather than only
# parsing it. This is the regression that catches system-Bash compatibility.
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

# Execute the full official gate with Builder shimmed out. Current authoritative
# P1 must be BOUNDED_BUILD / BUILDER before this controller can be certified.
set +e
GATE_OUTPUT="$(bash "$CURRENT_SESSION" P1 2>&1)"
gate_status=$?
set -e
[[ "$gate_status" -eq 0 ]] || fail "Official P1 deterministic gate failed on target macOS host: $GATE_OUTPUT"
printf '%s\n' "$GATE_OUTPUT"
printf '%s\n' "$GATE_OUTPUT" | grep -Fq 'PRYSM PROCESS GATE PASS' || fail "Official P1 gate did not emit PASS"
printf '%s\n' "$GATE_OUTPUT" | grep -Fq 'Authorized stage: BOUNDED_BUILD' || fail "Official P1 gate did not authorize BOUNDED_BUILD"
printf '%s\n' "$GATE_OUTPUT" | grep -Fq 'Authorized actor: BUILDER' || fail "Official P1 gate did not authorize Builder"
printf '%s\n' "$GATE_OUTPUT" | grep -Fq 'PRYSM CURRENT SESSION HANDOFF' || fail "Current-session shim did not intercept Builder launch"
pass "official deterministic P1 BOUNDED_BUILD gate executes successfully without Builder invocation"

# Thin macOS launcher invariants.
grep -Fq '[[ "$(uname -s)" == "Darwin" ]]' "$MAC_ENTRY" || fail "macOS identity guard is missing"
grep -Fq 'add_path_if_dir "$npm_prefix/bin"' "$MAC_ENTRY" || fail "npm <prefix>/bin discovery rule is missing"
grep -Fq 'bash "$BASE_ENTRY" "$@"' "$MAC_ENTRY" || fail "macOS adapter no longer delegates to the governed public launcher"
grep -Fq 'notify_macos "PRYSM $P_ID COMPLETE"' "$MAC_ENTRY" || fail "macOS success notification is missing"
grep -Fq 'notify_macos "PRYSM $P_ID NEEDS ATTENTION"' "$MAC_ENTRY" || fail "macOS attention notification is missing"
pass "macOS thin launcher and completion-notification invariants are present"

# Continuous Builder controller invariants.
grep -Fq '[[ "$P_ID" == "P1" ]]' "$MAC_AUTORUN" || fail "macOS controller is not P1-bounded"
grep -Fq 'MAX_RUNS="${PRYSM_MAC_MAX_RUNS:-12}"' "$MAC_AUTORUN" || fail "macOS controller default run bound is not 12"
grep -Fq 'MAX_SECONDS="${PRYSM_MAC_MAX_SECONDS:-2700}"' "$MAC_AUTORUN" || fail "macOS controller default time bound is not 2700 seconds"
grep -Fq 'ROOT_DEFECT_ID="P1-CROSS-REPORT-PROJECTION-RECONCILIATION"' "$MAC_AUTORUN" || fail "macOS controller is not bound to the R2 stable root"
grep -Fq 'MODEL_LUNA="gpt-5.6-luna"' "$MAC_AUTORUN" || fail "Luna repair level is missing"
grep -Fq 'MODEL_TERRA="gpt-5.6-terra"' "$MAC_AUTORUN" || fail "Terra repair level is missing"
grep -Fq 'MODEL_SOL="gpt-5.6-sol"' "$MAC_AUTORUN" || fail "Sol repair level is missing"
grep -Fq '[[ "$stage" == "DIAGNOSTIC_TRUTH" || "$stage" == "BOUNDED_BUILD" ]]' "$MAC_AUTORUN" || fail "macOS controller does not restrict autonomous execution to Builder-owned stages"
grep -Fq 'assert_build_application_boundary' "$MAC_AUTORUN" || fail "macOS controller lacks the R2 application-path guard"
grep -Fq 'services/worker/src/report/v2-pillars.js' "$MAC_AUTORUN" || fail "R2 performance consumer is missing from the application allowlist"
grep -Fq 'assert_build_governance_boundary' "$MAC_AUTORUN" || fail "macOS controller lacks the R2 governance-path guard"
grep -Fq 'NEW_ROOT_CAUSE' "$MAC_AUTORUN" || fail "macOS controller lacks new-root stop handling"
grep -Fq 'Third same-root repair attempt failed' "$MAC_AUTORUN" || fail "macOS controller lacks the no-fourth-attempt boundary"
grep -Fq 'run_official_gate OUTCOME_REVIEW BRAD' "$MAC_AUTORUN" || fail "macOS controller lacks independent deterministic Brad handoff verification"
grep -Fq 'PRYSM $P_ID READY FOR BRAD' "$MAC_AUTORUN" || fail "macOS controller lacks READY FOR BRAD notification"
grep -Fq 'bash "$FROZEN_GUARD"' "$MAC_AUTORUN" || fail "macOS controller lacks frozen-history terminal verification"
grep -Fq 'assert_application_synced' "$MAC_AUTORUN" || fail "macOS controller lacks application GitHub synchronization guard"
grep -Fq 'assert_governance_synced' "$MAC_AUTORUN" || fail "macOS controller lacks governance GitHub synchronization guard"
grep -Fq 'No-progress anti-thrash limit' "$MAC_AUTORUN" || fail "macOS controller lacks anti-thrash protection"
grep -Fq 'heartbeat.txt' "$MAC_AUTORUN" || fail "macOS controller lacks heartbeat state"
grep -Fq -- '--output-schema "$SCHEMA"' "$MAC_AUTORUN" || fail "macOS controller does not bind the structured result schema"
grep -Fq -- '--output-last-message "$FINAL_FILE"' "$MAC_AUTORUN" || fail "macOS controller does not persist the structured terminal result"
pass "macOS continuous P1 Builder-to-Brad invariants are present"

# Authorization must retain the exact anti-drift commitments.
grep -Fxq 'Decision: APPROVED' "$AUTH_FILE" || fail "R2 repair authorization is not APPROVED"
grep -Fq 'P1-CROSS-REPORT-PROJECTION-RECONCILIATION' "$AUTH_FILE" || fail "R2 repair authorization does not bind the stable root"
grep -Fq 'Any required application path outside this list is a scope-boundary event.' "$AUTH_FILE" || fail "R2 repair authorization lacks explicit path-boundary stop"
grep -Fq 'The successful terminal state for this autonomous envelope is `READY_FOR_BRAD`, not P1 closure.' "$AUTH_FILE" || fail "R2 repair authorization does not preserve Brad as terminal human boundary"
pass "R2 repair authorization anti-drift commitments are present"

# The controller itself must not contain destructive Git operations, force push,
# self-install behavior, direct deployment, or application-main merge commands.
if grep -Eq 'git[[:space:]]+(reset|clean|checkout)|git[[:space:]]+push[[:space:]].*--force|npm[[:space:]]+(install|i)([[:space:]]|$)' "$MAC_AUTORUN"; then
  fail "macOS continuous controller contains a prohibited destructive/install command"
fi
pass "macOS continuous controller contains no destructive Git, force-push, or install command"

# AUDIT-SAFETY-SCAN-BOUNDARY
AUDIT_PREFIX="$(awk '/^# AUDIT-SAFETY-SCAN-BOUNDARY$/ { exit } { print }' "$0")"
EXECUTABLE_PREFIX="$(printf '%s\n' "$AUDIT_PREFIX" | grep -Ev '^[[:space:]]*(#|$)' || true)"

if printf '%s\n' "$EXECUTABLE_PREFIX" | grep -Eq '^[[:space:]]*(npm[[:space:]]+(install|i)([[:space:]]|$)|git[[:space:]]+(push|reset|clean|checkout)([[:space:]]|$))'; then
  fail "Certification script contains a prohibited mutating command above the audit safety boundary"
fi
pass "audit-only certification contains no install, push, reset, clean, or checkout command"

echo
echo "PRYSM MACOS CONTINUOUS BUILDER AUTORUN CERTIFICATION PASS"
echo "Environment: $(sw_vers -productName 2>/dev/null || printf 'macOS') $(sw_vers -productVersion 2>/dev/null || true)"
echo "Architecture: $(uname -m)"
echo "Bash: $BASH_VERSION"
echo "Codex: $CODEX_VERSION"
echo "Notification runtime: osascript"
echo "Frozen-history runtime: PASS"
echo "Official deterministic P1 gate runtime: PASS (Builder shimmed)"
echo "Current certified stage: BOUNDED_BUILD"
echo "Stable root: P1-CROSS-REPORT-PROJECTION-RECONCILIATION"
echo "Default safety window: 2700 seconds"
echo "Default max fresh Codex runs: 12"
echo "Heartbeat interval: 60 seconds"
echo "Repair escalation: Luna -> Terra -> Sol; no fourth same-root attempt"
echo "Terminal human boundary: BRAD OUTCOME_REVIEW"
echo "Certification mode: AUDIT ONLY"
echo "No Builder invocation or application/product execution occurred."
