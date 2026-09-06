#!/usr/bin/env bash
set -euo pipefail

P_ID="${1:-}"
MAX_RUNS="${PRYSM_MAC_MAX_RUNS:-6}"
MAX_SECONDS="${PRYSM_MAC_MAX_SECONDS:-1200}"
HEARTBEAT_SECONDS="${PRYSM_MAC_HEARTBEAT_SECONDS:-60}"
MODEL="${PRYSM_MAC_MODEL:-gpt-5.6-luna}"

fail() {
  echo >&2
  echo "PRYSM MACOS AUTORUN FAIL: $1" >&2
  notify_macos "PRYSM ${P_ID:-P1} NEEDS ATTENTION" "$1"
  exit 1
}

notify_macos() {
  local title="$1"
  local message="$2"
  if command -v osascript >/dev/null 2>&1; then
    osascript - "$title" "$message" <<'APPLESCRIPT' >/dev/null 2>&1 || true
on run argv
  set notificationTitle to item 1 of argv
  set notificationMessage to item 2 of argv
  display notification notificationMessage with title notificationTitle sound name "Glass"
end run
APPLESCRIPT
  else
    printf '\a' >&2
  fi
}

[[ "$(uname -s)" == "Darwin" ]] || fail "This controller is certified only for macOS (Darwin)."
[[ "$P_ID" == "P1" ]] || fail "This controller is currently certified only for P1."
[[ "$MAX_RUNS" =~ ^[1-9][0-9]*$ ]] || fail "PRYSM_MAC_MAX_RUNS must be a positive integer."
[[ "$MAX_SECONDS" =~ ^[1-9][0-9]*$ ]] || fail "PRYSM_MAC_MAX_SECONDS must be a positive integer."
[[ "$HEARTBEAT_SECONDS" =~ ^[1-9][0-9]*$ ]] || fail "PRYSM_MAC_HEARTBEAT_SECONDS must be a positive integer."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GOV_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
WORKSPACE_ROOT="$(cd "$GOV_ROOT/.." && pwd)"
APP_ROOT="$WORKSPACE_ROOT/vantage-platform"
GATE_ENTRY="$SCRIPT_DIR/start-prysm-p-current-session.sh"
BUILDER_PROMPT="$SCRIPT_DIR/PRYSM-P-BUILDER-AUTORUN-PROMPT.md"
FROZEN_GUARD="$SCRIPT_DIR/assert-p1-frozen-history.sh"
SCHEMA="$GOV_ROOT/tools/autorun/PRYSM-AUTORUN-RESULT.schema.json"
GATE_FILE="$GOV_ROOT/${P_ID}_EXECUTION_GATE.env"

for required in "$GATE_ENTRY" "$BUILDER_PROMPT" "$FROZEN_GUARD" "$SCHEMA" "$GATE_FILE"; do
  [[ -f "$required" ]] || fail "Missing required governed file: $required"
done
[[ -d "$APP_ROOT/.git" ]] || fail "Application repository not found at expected sibling path: $APP_ROOT"
command -v git >/dev/null 2>&1 || fail "git is not on PATH."
command -v node >/dev/null 2>&1 || fail "node is required for structured-result validation."

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

CODEX_BIN="$(resolve_codex)" || fail "Codex CLI is not discoverable through the certified macOS resolution rules."

STATE_ROOT="$HOME/Library/Application Support/PRYSM-P-Autorun/$P_ID"
LOCK_DIR="$STATE_ROOT/controller.lock"
HEARTBEAT_FILE="$STATE_ROOT/heartbeat.txt"
mkdir -p "$STATE_ROOT"

if ! mkdir "$LOCK_DIR" 2>/dev/null; then
  if [[ -f "$LOCK_DIR/pid" ]]; then
    existing_pid="$(cat "$LOCK_DIR/pid" 2>/dev/null || true)"
    if [[ "$existing_pid" =~ ^[0-9]+$ ]] && kill -0 "$existing_pid" 2>/dev/null; then
      fail "Another macOS PRYSM autorun is already active (PID $existing_pid)."
    fi
  fi
  rm -rf "$LOCK_DIR"
  mkdir "$LOCK_DIR" || fail "Could not acquire autorun lock."
fi
printf '%s\n' "$$" > "$LOCK_DIR/pid"

heartbeat_pid=""
cleanup() {
  if [[ -n "$heartbeat_pid" ]]; then
    kill "$heartbeat_pid" 2>/dev/null || true
    wait "$heartbeat_pid" 2>/dev/null || true
  fi
  rm -rf "$LOCK_DIR"
}
trap cleanup EXIT INT TERM

(
  while true; do
    printf '%s pid=%s p=%s\n' "$(date -u '+%Y-%m-%dT%H:%M:%SZ')" "$$" "$P_ID" > "$HEARTBEAT_FILE"
    sleep "$HEARTBEAT_SECONDS"
  done
) &
heartbeat_pid=$!

START_EPOCH="$(date +%s)"
run=0
no_progress=0

repo_fingerprint() {
  local repo="$1"
  printf '%s|%s' "$(git -C "$repo" rev-parse HEAD)" "$(git -C "$repo" status --porcelain=v1 --untracked-files=all | shasum -a 256 | awk '{print $1}')"
}

changed_paths_between() {
  local repo="$1"
  local pre_head="$2"
  local post_head="$3"
  {
    if [[ "$pre_head" != "$post_head" ]]; then
      git -C "$repo" diff --name-only "$pre_head..$post_head"
    fi
    while IFS= read -r line; do
      [[ -n "$line" ]] || continue
      path="${line:3}"
      if [[ "$path" == *" -> "* ]]; then
        path="${path##* -> }"
      fi
      printf '%s\n' "$path"
    done < <(git -C "$repo" status --porcelain=v1 --untracked-files=all)
  } | sed '/^$/d' | sort -u
}

assert_diagnostic_governance_boundary() {
  local pre_head="$1"
  local post_head="$2"
  local path
  while IFS= read -r path; do
    [[ -n "$path" ]] || continue
    case "$path" in
      proof/P1/reopen/*) ;;
      *) fail "DIAGNOSTIC_TRUTH governance transaction escaped the authorized new-evidence path: $path" ;;
    esac
  done < <(changed_paths_between "$GOV_ROOT" "$pre_head" "$post_head")
}

assert_governance_synced() {
  [[ -z "$(git -C "$GOV_ROOT" status --porcelain=v1 --untracked-files=all)" ]] || fail "Governance worktree is not clean at the diagnostic handoff. Preserve it; do not discard it."
  git -C "$GOV_ROOT" fetch origin main >/dev/null || fail "Governance fetch failed at diagnostic handoff."
  local local_head remote_head
  local_head="$(git -C "$GOV_ROOT" rev-parse HEAD)"
  remote_head="$(git -C "$GOV_ROOT" rev-parse origin/main)"
  [[ "$local_head" == "$remote_head" ]] || fail "Diagnostic governance evidence is not synchronized to authoritative origin/main. Local=$local_head Remote=$remote_head"
}

read_gate_stage() {
  awk -F= '$1 == "AUTHORIZED_STAGE" { print $2; exit }' "$GATE_FILE"
}

while true; do
  now="$(date +%s)"
  elapsed=$((now - START_EPOCH))
  if (( elapsed >= MAX_SECONDS )); then
    notify_macos "PRYSM $P_ID NEEDS ATTENTION" "Sustained autorun reached its ${MAX_SECONDS}s safety window. Review the latest log before continuing."
    echo "PRYSM MACOS AUTORUN SAFETY WINDOW REACHED"
    exit 2
  fi
  if (( run >= MAX_RUNS )); then
    notify_macos "PRYSM $P_ID NEEDS ATTENTION" "Sustained autorun reached its $MAX_RUNS-run safety limit. Review the latest log before continuing."
    echo "PRYSM MACOS AUTORUN RUN LIMIT REACHED"
    exit 2
  fi

  stage="$(read_gate_stage)"
  [[ "$stage" == "DIAGNOSTIC_TRUTH" ]] || fail "Mac sustained autorun is currently certified only for DIAGNOSTIC_TRUTH; gate now authorizes '$stage'."

  run=$((run + 1))
  stamp="$(date '+%Y%m%d-%H%M%S')"
  RUN_DIR="$STATE_ROOT/run-$(printf '%04d' "$run")-$stamp"
  mkdir -p "$RUN_DIR"
  GATE_LOG="$RUN_DIR/gate.log"
  PROMPT_FILE="$RUN_DIR/prompt.md"
  FINAL_FILE="$RUN_DIR/final.json"
  STDOUT_FILE="$RUN_DIR/stdout.log"
  STDERR_FILE="$RUN_DIR/stderr.log"

  echo
  echo "=== PRYSM $P_ID MACOS SUSTAINED RUN $run | stage=$stage | model=$MODEL ==="
  echo "Logs: $RUN_DIR"

  set +e
  bash "$GATE_ENTRY" "$P_ID" > "$GATE_LOG" 2>&1
  gate_status=$?
  set -e
  cat "$GATE_LOG"
  [[ "$gate_status" -eq 0 ]] || fail "Deterministic PRYSM gate failed. See $GATE_LOG"
  grep -Fq 'PRYSM PROCESS GATE PASS' "$GATE_LOG" || fail "Deterministic gate did not emit PASS."
  grep -Fq 'Authorized stage: DIAGNOSTIC_TRUTH' "$GATE_LOG" || fail "Gate no longer authorizes DIAGNOSTIC_TRUTH."
  grep -Fq 'Authorized actor: BUILDER' "$GATE_LOG" || fail "Gate no longer authorizes Builder."

  GOVERNED_PROMPT="$(awk '/^----- PRYSM GOVERNED HANDOFF START -----$/ {capture=1; next} /^----- PRYSM GOVERNED HANDOFF END -----$/ {capture=0} capture {print}' "$GATE_LOG")"
  [[ -n "$GOVERNED_PROMPT" ]] || fail "Could not extract the governed Builder prompt from the deterministic gate."

  pre_app="$(repo_fingerprint "$APP_ROOT")"
  pre_gov="$(repo_fingerprint "$GOV_ROOT")"
  pre_gov_head="$(git -C "$GOV_ROOT" rev-parse HEAD)"

  cat > "$PROMPT_FILE" <<EOF_PROMPT
# PRYSM macOS sustained execution context

This is a non-interactive, unattended, same-actor Builder run under an already-passed deterministic P1 gate.

Current authorized stage: DIAGNOSTIC_TRUTH
Current authorized actor: BUILDER/Codex
Current model: $MODEL

EXECUTION CONTINUITY REQUIREMENT
- Work continuously through the complete authorized DIAGNOSTIC_TRUTH obligation in this run when safely possible.
- Do not stop after one file inspection, one scenario, one finding, one test, one intermediate summary, or a convenient response boundary.
- A model turn ending is not a workflow boundary.
- Diagnose the complete remaining material set together: CTA/path coherence; Trust evidence overstatement; fail-closed projection/performance-state reconciliation.
- Robots/indexability is not a decisive P1 blocker unless new diagnostic evidence proves otherwise.
- Read-only application diagnosis only. DO NOT edit application code during DIAGNOSTIC_TRUTH.
- Do not cross into BOUNDED_BUILD or perform a repair. Repair requires a later governed authorization.
- Complete the lineage/root-cause/scenario/seam analysis and create only new versioned diagnostic governance evidence under proof/P1/reopen/.
- Do not modify CURRENT_STATE.md, P1_EXECUTION_GATE.env, control-plane files, or frozen historical evidence during this diagnostic run.
- Before any governance commit/push and before returning, run the P1 frozen-history guard required by the Builder contract.
- If diagnosis is complete and the only remaining step is Chris repair authorization, return BLOCKED with a checkpoint/reason/next_action that clearly says repair authorization is required. That is the expected human boundary, not a failure.
- Otherwise, if more authorized diagnostic work remains, return CONTINUE to Builder.
- Never route to Betty/Auditor from this stage.

# Deterministic governed handoff
$GOVERNED_PROMPT

# Autonomous Builder result contract
$(cat "$BUILDER_PROMPT")
EOF_PROMPT

  set +e
  "$CODEX_BIN" \
    --ask-for-approval never \
    --sandbox danger-full-access \
    --add-dir "$GOV_ROOT" \
    exec \
    --model "$MODEL" \
    --cd "$APP_ROOT" \
    --color never \
    --output-schema "$SCHEMA" \
    --output-last-message "$FINAL_FILE" \
    - < "$PROMPT_FILE" > "$STDOUT_FILE" 2> "$STDERR_FILE"
  codex_status=$?
  set -e

  cat "$STDOUT_FILE"
  if [[ -s "$STDERR_FILE" ]]; then
    echo "--- Codex stderr ---"
    cat "$STDERR_FILE"
  fi

  post_app="$(repo_fingerprint "$APP_ROOT")"
  post_gov="$(repo_fingerprint "$GOV_ROOT")"
  post_gov_head="$(git -C "$GOV_ROOT" rev-parse HEAD)"

  [[ "$pre_app" == "$post_app" ]] || fail "DIAGNOSTIC_TRUTH modified the application repository. The run was stopped fail-closed. See $RUN_DIR"
  assert_diagnostic_governance_boundary "$pre_gov_head" "$post_gov_head"
  bash "$FROZEN_GUARD" >/dev/null || fail "P1 frozen-history verification failed after diagnostic execution."
  [[ "$codex_status" -eq 0 ]] || fail "Codex exited with code $codex_status. See $RUN_DIR"
  [[ -s "$FINAL_FILE" ]] || fail "Codex did not produce the required structured result. See $RUN_DIR"

  result_line="$(node - "$FINAL_FILE" <<'NODE'
const fs = require('fs');
const p = process.argv[2];
const x = JSON.parse(fs.readFileSync(p, 'utf8'));
const vals = [x.loop_action, x.next_role, x.checkpoint, x.reason, x.next_action].map(v => v == null ? '' : String(v).replace(/[\t\r\n]+/g, ' '));
process.stdout.write(vals.join('\t'));
NODE
)" || fail "Structured result is not valid JSON. See $FINAL_FILE"

  IFS=$'\t' read -r loop_action next_role checkpoint reason next_action <<< "$result_line"
  echo "Result: $loop_action | next=$next_role | checkpoint=$checkpoint"
  echo "Reason: $reason"

  if [[ "$loop_action" == "BLOCKED" ]]; then
    if [[ "$checkpoint" == *"AUTH"* || "$reason" == *"authoriz"* || "$next_action" == *"authoriz"* ]]; then
      assert_governance_synced
      notify_macos "PRYSM $P_ID READY FOR CHRIS" "Diagnostic work reached the repair-authorization boundary. Review: $reason"
      echo "PRYSM $P_ID DIAGNOSTIC COMPLETE — READY FOR CHRIS"
      exit 0
    fi
    notify_macos "PRYSM $P_ID NEEDS ATTENTION" "Builder reported a blocker: $reason"
    echo "PRYSM $P_ID BLOCKED"
    exit 2
  fi

  if [[ "$checkpoint" == "READY_FOR_BRAD" || "$next_role" == "Auditor" || "$next_role" == "BRAD" || "$next_role" == "Brad" ]]; then
    fail "Builder attempted to cross the DIAGNOSTIC_TRUTH human/governance boundary without repair authorization."
  fi

  if [[ "$loop_action" == "CONTINUE" || ( "$loop_action" == "STOP" && "$next_role" == "Builder" ) ]]; then
    if [[ "$pre_app" == "$post_app" && "$pre_gov" == "$post_gov" ]]; then
      no_progress=$((no_progress + 1))
    else
      no_progress=0
    fi
    if (( no_progress >= 3 )); then
      fail "No-progress anti-thrash limit reached after three Builder continuations with no repository progress."
    fi
    assert_governance_synced
    sleep 2
    continue
  fi

  fail "Unsafe or unsupported terminal result: loop_action=$loop_action next_role=$next_role checkpoint=$checkpoint"
done
