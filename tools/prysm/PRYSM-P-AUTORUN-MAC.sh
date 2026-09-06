#!/usr/bin/env bash
set -euo pipefail

P_ID="${1:-}"
MAX_RUNS="${PRYSM_MAC_MAX_RUNS:-12}"
MAX_SECONDS="${PRYSM_MAC_MAX_SECONDS:-2700}"
HEARTBEAT_SECONDS="${PRYSM_MAC_HEARTBEAT_SECONDS:-60}"
ROOT_DEFECT_ID="P1-CROSS-REPORT-PROJECTION-RECONCILIATION"

MODEL_LUNA="gpt-5.6-luna"
MODEL_TERRA="gpt-5.6-terra"
MODEL_SOL="gpt-5.6-sol"

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

fail() {
  echo >&2
  echo "PRYSM MACOS AUTORUN FAIL: $1" >&2
  notify_macos "PRYSM ${P_ID:-P1} NEEDS ATTENTION" "$1"
  exit 1
}

block() {
  local reason="$1"
  echo >&2
  echo "PRYSM $P_ID BLOCKED: $reason" >&2
  notify_macos "PRYSM $P_ID BLOCKED" "$reason"
  exit 2
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
AUTH_FILE="$GOV_ROOT/proof/P1/reopen/P1_BOUNDED_REPAIR_AUTHORIZATION_R2_2026-09-06.md"

for required in "$GATE_ENTRY" "$BUILDER_PROMPT" "$FROZEN_GUARD" "$SCHEMA" "$GATE_FILE" "$AUTH_FILE"; do
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

model_for_attempt() {
  case "$1" in
    0) printf '%s' "$MODEL_LUNA" ;;
    1) printf '%s' "$MODEL_TERRA" ;;
    2) printf '%s' "$MODEL_SOL" ;;
    *) return 1 ;;
  esac
}

read_gate_value() {
  local key="$1"
  awk -F= -v key="$key" '$1 == key { print $2; exit }' "$GATE_FILE"
}

read_gate_stage() {
  read_gate_value AUTHORIZED_STAGE
}

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
      git -C "$repo" log --format= --name-only "$pre_head..$post_head"
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

assert_build_application_boundary() {
  local pre_head="$1"
  local post_head="$2"
  local path
  while IFS= read -r path; do
    [[ -n "$path" ]] || continue
    case "$path" in
      services/worker/src/report-model/cross-report-interpretation.js|\
      services/worker/src/report-model/cross-report-interpretation.test.js|\
      services/worker/src/report/foundation-readiness.js|\
      services/worker/src/report/report-detail-sections.js|\
      services/worker/src/report/v2-pillars.js|\
      services/worker/src/report/render-report-v2.js|\
      services/worker/src/report/render-report-v2-conversion.test.js|\
      services/worker/src/report/render-report-v2.test.js|\
      services/worker/src/report/render-report-v2-sections.test.js) ;;
      *) fail "BOUNDED_BUILD application transaction escaped the R2 allowlist: $path" ;;
    esac
  done < <(changed_paths_between "$APP_ROOT" "$pre_head" "$post_head")
}

assert_build_governance_boundary() {
  local pre_head="$1"
  local post_head="$2"
  local path
  while IFS= read -r path; do
    [[ -n "$path" ]] || continue
    case "$path" in
      CURRENT_STATE.md|P1_EXECUTION_GATE.env|proof/P1/reopen/*) ;;
      *) fail "BOUNDED_BUILD governance transaction escaped the R2 allowlist: $path" ;;
    esac
  done < <(changed_paths_between "$GOV_ROOT" "$pre_head" "$post_head")
}

assert_governance_synced() {
  [[ -z "$(git -C "$GOV_ROOT" status --porcelain=v1 --untracked-files=all)" ]] || fail "Governance worktree is not clean at a durable checkpoint. Preserve it; do not discard it."
  git -C "$GOV_ROOT" fetch origin main >/dev/null || fail "Governance fetch failed at durable checkpoint."
  local local_head remote_head
  local_head="$(git -C "$GOV_ROOT" rev-parse HEAD)"
  remote_head="$(git -C "$GOV_ROOT" rev-parse origin/main)"
  [[ "$local_head" == "$remote_head" ]] || fail "Governance is not synchronized to authoritative origin/main. Local=$local_head Remote=$remote_head"
}

assert_application_synced() {
  local branch
  branch="$(read_gate_value APPLICATION_BRANCH)"
  [[ -n "$branch" ]] || fail "P1 execution gate has no APPLICATION_BRANCH."
  [[ -z "$(git -C "$APP_ROOT" status --porcelain=v1 --untracked-files=all)" ]] || fail "Application worktree is not clean at a durable checkpoint. Preserve it; do not discard it."
  [[ "$(git -C "$APP_ROOT" branch --show-current)" == "$branch" ]] || fail "Application branch changed outside the governed P1 branch."
  git -C "$APP_ROOT" fetch origin "$branch" >/dev/null || fail "Application fetch failed at durable checkpoint."
  local local_head remote_head
  local_head="$(git -C "$APP_ROOT" rev-parse HEAD)"
  remote_head="$(git -C "$APP_ROOT" rev-parse "origin/$branch")"
  [[ "$local_head" == "$remote_head" ]] || fail "Application candidate is not synchronized to origin/$branch. Local=$local_head Remote=$remote_head"
}

run_official_gate() {
  local expected_stage="$1"
  local expected_actor="$2"
  local output status
  set +e
  output="$(bash "$GATE_ENTRY" "$P_ID" 2>&1)"
  status=$?
  set -e
  printf '%s\n' "$output"
  [[ "$status" -eq 0 ]] || fail "Official deterministic P1 gate failed."
  printf '%s\n' "$output" | grep -Fq 'PRYSM PROCESS GATE PASS' || fail "Official deterministic P1 gate did not emit PASS."
  printf '%s\n' "$output" | grep -Fq "Authorized stage: $expected_stage" || fail "Official P1 gate stage mismatch; expected $expected_stage."
  printf '%s\n' "$output" | grep -Fq "Authorized actor: $expected_actor" || fail "Official P1 gate actor mismatch; expected $expected_actor."
  GATE_CAPTURE="$output"
}

usage_limit_seen() {
  local file
  for file in "$@"; do
    [[ -f "$file" ]] || continue
    if grep -Eiq 'hit your usage limit|usage limit.*try again|usage limit.*reset' "$file"; then
      return 0
    fi
  done
  return 1
}

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
repair_attempt=0

while true; do
  now="$(date +%s)"
  elapsed=$((now - START_EPOCH))
  if (( elapsed >= MAX_SECONDS )); then
    block "Continuous Builder reached its ${MAX_SECONDS}s safety window. Review the latest durable checkpoint before continuing."
  fi
  if (( run >= MAX_RUNS )); then
    block "Continuous Builder reached its $MAX_RUNS-run safety limit. Review the latest durable checkpoint before continuing."
  fi

  stage="$(read_gate_stage)"

  if [[ "$stage" == "OUTCOME_REVIEW" ]]; then
    assert_application_synced
    assert_governance_synced
    run_official_gate OUTCOME_REVIEW BRAD
    notify_macos "PRYSM $P_ID READY FOR BRAD" "Exact candidate and governance passed the deterministic Brad handoff gate."
    echo "PRYSM $P_ID READY FOR BRAD"
    exit 0
  fi

  [[ "$stage" == "DIAGNOSTIC_TRUTH" || "$stage" == "BOUNDED_BUILD" ]] || fail "Unsupported autonomous stage '$stage'. Controller stops before non-Builder stages."

  run=$((run + 1))
  model="$(model_for_attempt "$repair_attempt")" || block "Three same-root repair levels are exhausted for $ROOT_DEFECT_ID."
  stamp="$(date '+%Y%m%d-%H%M%S')"
  RUN_DIR="$STATE_ROOT/run-$(printf '%04d' "$run")-$stamp"
  mkdir -p "$RUN_DIR"
  GATE_LOG="$RUN_DIR/gate.log"
  PROMPT_FILE="$RUN_DIR/prompt.md"
  FINAL_FILE="$RUN_DIR/final.json"
  STDOUT_FILE="$RUN_DIR/stdout.log"
  STDERR_FILE="$RUN_DIR/stderr.log"

  echo
  echo "=== PRYSM $P_ID MACOS CONTINUOUS RUN $run | stage=$stage | model=$model | repair_attempt=$repair_attempt ==="
  echo "Logs: $RUN_DIR"

  run_official_gate "$stage" BUILDER
  printf '%s\n' "$GATE_CAPTURE" > "$GATE_LOG"

  GOVERNED_PROMPT="$(printf '%s\n' "$GATE_CAPTURE" | awk '/^----- PRYSM GOVERNED HANDOFF START -----$/ {capture=1; next} /^----- PRYSM GOVERNED HANDOFF END -----$/ {capture=0} capture {print}')"
  [[ -n "$GOVERNED_PROMPT" ]] || fail "Could not extract the governed Builder prompt from the deterministic gate."

  pre_app="$(repo_fingerprint "$APP_ROOT")"
  pre_gov="$(repo_fingerprint "$GOV_ROOT")"
  pre_app_head="$(git -C "$APP_ROOT" rev-parse HEAD)"
  pre_gov_head="$(git -C "$GOV_ROOT" rev-parse HEAD)"

  if [[ "$stage" == "DIAGNOSTIC_TRUTH" ]]; then
    STAGE_CONTEXT=$(cat <<'EOF_STAGE'
DIAGNOSTIC_TRUTH RULES
- Read-only application diagnosis only. Do not edit application code.
- Create only new versioned diagnostic evidence beneath proof/P1/reopen/.
- Do not modify CURRENT_STATE.md, P1_EXECUTION_GATE.env, control-plane files, or frozen historical evidence in this stage.
- Do not treat an invocation ending as a workflow boundary.
- Do not cross to repair unless authoritative governance has already been separately rebound to BOUNDED_BUILD.
EOF_STAGE
)
  else
    STAGE_CONTEXT=$(cat <<EOF_STAGE
BOUNDED_BUILD R2 RULES
- Owner authorization: proof/P1/reopen/P1_BOUNDED_REPAIR_AUTHORIZATION_R2_2026-09-06.md
- Stable root-defect identity: $ROOT_DEFECT_ID
- Current controller repair_attempt: $repair_attempt
- Repair ONLY these three families together:
  1. CTA/path coherence.
  2. Trust evidence attribution.
  3. Fail-closed performance/readiness reconciliation.
- The historical five-family P1 list in the shared Builder contract is superseded for this R2 envelope by the authorization above. Robots/indexability and unrelated client-language cleanup are NOT authorized repair families.
- Application edits are restricted to the exact path allowlist in the R2 authorization and enforced again by this controller after every invocation.
- Any materially different root, new required application path, or protected-surface dependency is a blocker. Do not broaden the repair.
- Work continuously through implementation, focused tests, broader required P1 verification, rendered proof, hashes/provenance, exact-candidate commit/push, and governance rebinding.
- Before returning CONTINUE, leave both repositories at a clean pushed durable checkpoint so the deterministic gate can safely re-enter.
- When all Builder-owned proof is complete, advance only to OUTCOME_REVIEW / Brad exactly as required by the Builder contract. Do not start Brad, Betty, P2, closure, deploy, or application-main merge.
EOF_STAGE
)
  fi

  cat > "$PROMPT_FILE" <<EOF_PROMPT
# PRYSM macOS continuous Builder execution context

This is a non-interactive, unattended, same-actor Builder run under an already-passed deterministic P1 gate.

Current authorized stage: $stage
Current authorized actor: BUILDER/Codex
Current model: $model
Current repair_attempt: $repair_attempt
Stable root-defect identity: $ROOT_DEFECT_ID

EXECUTION CONTINUITY
- Work continuously through the complete authorized Builder obligation in this invocation when safely possible.
- Do not stop after one file, one test, one proof step, one commit, or an intermediate summary.
- A model turn ending is not a workflow boundary.
- Do not change root identity to reset repair accounting.
- Preserve exact Git lineage and all frozen human-review/history evidence.

$STAGE_CONTEXT

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
    --model "$model" \
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
  post_app_head="$(git -C "$APP_ROOT" rev-parse HEAD)"
  post_gov_head="$(git -C "$GOV_ROOT" rev-parse HEAD)"

  if [[ "$stage" == "DIAGNOSTIC_TRUTH" ]]; then
    [[ "$pre_app" == "$post_app" ]] || fail "DIAGNOSTIC_TRUTH modified the application repository. The run was stopped fail-closed. See $RUN_DIR"
    assert_diagnostic_governance_boundary "$pre_gov_head" "$post_gov_head"
  else
    assert_build_application_boundary "$pre_app_head" "$post_app_head"
    assert_build_governance_boundary "$pre_gov_head" "$post_gov_head"
  fi

  bash "$FROZEN_GUARD" >/dev/null || fail "P1 frozen-history verification failed after Builder execution."

  if [[ "$codex_status" -ne 0 ]]; then
    if usage_limit_seen "$STDOUT_FILE" "$STDERR_FILE"; then
      block "Codex usage limit reached. No repair escalation consumed. Latest log: $RUN_DIR"
    fi
    fail "Codex exited with code $codex_status. See $RUN_DIR"
  fi
  [[ -s "$FINAL_FILE" ]] || fail "Codex did not produce the required structured result. See $RUN_DIR"

  result_line="$(node - "$FINAL_FILE" <<'NODE'
const fs = require('fs');
const p = process.argv[2];
const x = JSON.parse(fs.readFileSync(p, 'utf8'));
const vals = [
  x.loop_action, x.next_role, x.checkpoint, x.reason, x.next_action,
  x.whole_app_gate, x.material_defects, x.repair_attempt, x.root_defect_id,
  x.failure_class, x.github_state_synced, x.application_sha, x.governance_sha
].map(v => v == null ? '' : String(v).replace(/[\t\r\n]+/g, ' '));
process.stdout.write(vals.join('\t'));
NODE
)" || fail "Structured result is not valid JSON. See $FINAL_FILE"

  IFS=$'\t' read -r loop_action next_role checkpoint reason next_action whole_app_gate material_defects returned_attempt returned_root failure_class github_synced returned_app_sha returned_gov_sha <<< "$result_line"

  echo "Result: $loop_action | next=$next_role | checkpoint=$checkpoint | failure=$failure_class"
  echo "Reason: $reason"

  [[ "$returned_attempt" == "$repair_attempt" ]] || fail "Builder repair_attempt drifted. Controller=$repair_attempt Builder=$returned_attempt"

  if [[ "$stage" == "BOUNDED_BUILD" ]]; then
    [[ "$returned_root" == "$ROOT_DEFECT_ID" ]] || block "Root-defect drift detected. Authorized=$ROOT_DEFECT_ID Returned=$returned_root"
    if [[ "$failure_class" == "NEW_ROOT_CAUSE" ]]; then
      block "Builder established a materially new root cause. Owner review is required before scope can change."
    fi
  fi

  current_stage="$(read_gate_stage)"

  if [[ "$checkpoint" == "READY_FOR_BRAD" || "$current_stage" == "OUTCOME_REVIEW" ]]; then
    [[ "$loop_action" == "STOP" ]] || fail "READY_FOR_BRAD requires loop_action=STOP."
    [[ "$next_role" == "NONE" ]] || fail "READY_FOR_BRAD requires next_role=NONE."
    [[ "$checkpoint" == "READY_FOR_BRAD" ]] || fail "Governance advanced to OUTCOME_REVIEW without an exact READY_FOR_BRAD result."
    [[ "$whole_app_gate" == "PASS" ]] || fail "READY_FOR_BRAD requires whole_app_gate=PASS."
    [[ "$material_defects" == "0" ]] || fail "READY_FOR_BRAD requires material_defects=0."
    [[ "$failure_class" == "NONE" ]] || fail "READY_FOR_BRAD requires failure_class=NONE."
    [[ "$github_synced" == "true" ]] || fail "READY_FOR_BRAD requires github_state_synced=true."
    assert_application_synced
    assert_governance_synced
    local_app_sha="$(git -C "$APP_ROOT" rev-parse HEAD)"
    local_gov_sha="$(git -C "$GOV_ROOT" rev-parse HEAD)"
    [[ "$returned_app_sha" == "$local_app_sha" ]] || fail "READY_FOR_BRAD application SHA does not match local exact candidate."
    [[ "$returned_gov_sha" == "$local_gov_sha" ]] || fail "READY_FOR_BRAD governance SHA does not match authoritative local state."
    run_official_gate OUTCOME_REVIEW BRAD
    notify_macos "PRYSM $P_ID READY FOR BRAD" "Application $local_app_sha and governance $local_gov_sha passed the deterministic Brad handoff gate."
    echo "PRYSM $P_ID READY FOR BRAD"
    exit 0
  fi

  if [[ "$loop_action" == "BLOCKED" ]]; then
    block "Builder reported a genuine blocker: $reason Next: $next_action"
  fi

  if [[ "$next_role" == "Auditor" ]]; then
    fail "Builder attempted to route directly to Auditor/Betty. Brad OUTCOME_REVIEW is the next human boundary."
  fi

  if [[ "$failure_class" == "REPAIR_PROOF_FAILED" ]]; then
    if (( repair_attempt >= 2 )); then
      block "Third same-root repair attempt failed for $ROOT_DEFECT_ID. Diagnostic reset/owner review is required; no fourth attempt is permitted."
    fi
    repair_attempt=$((repair_attempt + 1))
  elif [[ "$failure_class" == "PROOF_SETUP_FAILURE" ]]; then
    :
  elif [[ "$failure_class" == "EXTERNAL_OR_PROTOCOL" ]]; then
    block "External/protocol failure requires review before a fresh Builder invocation: $reason"
  elif [[ "$failure_class" != "NONE" ]]; then
    fail "Unsupported failure class: $failure_class"
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
    assert_application_synced
    assert_governance_synced
    sleep 2
    continue
  fi

  fail "Unsafe or unsupported terminal result: loop_action=$loop_action next_role=$next_role checkpoint=$checkpoint failure_class=$failure_class"
done
