#!/usr/bin/env bash
set -euo pipefail

P_ID="${1:-}"

fail() {
  echo >&2
  echo "PRYSM PROCESS GATE FAIL: $1" >&2
  exit 1
}

[[ -n "$P_ID" ]] || fail "Usage: bash tools/prysm/start-prysm-p.sh P1"
[[ "$P_ID" =~ ^P([1-9]|10)([A-Z][A-Z0-9-]*)?$ ]] || fail "Invalid P# '$P_ID'. Expected P1..P10 or a governed micro-tranche such as P3A."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GOV_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
WORKSPACE_ROOT="$(cd "$GOV_ROOT/.." && pwd)"
APP_ROOT="$WORKSPACE_ROOT/vantage-platform"
GATE_FILE="$GOV_ROOT/${P_ID}_EXECUTION_GATE.env"
CURRENT_STATE="$GOV_ROOT/CURRENT_STATE.md"

ensure_codex_cli() {
  command -v codex >/dev/null 2>&1 && return 0

  local candidate=""
  local appdata_unix=""
  local npm_prefix=""

  candidate="$HOME/AppData/Roaming/npm"
  if [[ -d "$candidate" ]]; then
    export PATH="$PATH:$candidate"
    command -v codex >/dev/null 2>&1 && return 0
  fi

  if [[ -n "${APPDATA:-}" ]]; then
    if command -v cygpath >/dev/null 2>&1; then
      appdata_unix="$(cygpath -u "$APPDATA" 2>/dev/null || true)"
    else
      appdata_unix="$APPDATA"
    fi
    candidate="$appdata_unix/npm"
    if [[ -n "$appdata_unix" && -d "$candidate" ]]; then
      export PATH="$PATH:$candidate"
      command -v codex >/dev/null 2>&1 && return 0
    fi
  fi

  if command -v npm >/dev/null 2>&1; then
    npm_prefix="$(npm config get prefix 2>/dev/null || true)"
    if [[ -n "$npm_prefix" && "$npm_prefix" != "undefined" && -d "$npm_prefix" ]]; then
      export PATH="$PATH:$npm_prefix"
      command -v codex >/dev/null 2>&1 && return 0
    fi
  fi

  return 1
}

command -v git >/dev/null 2>&1 || fail "git is not installed or not on PATH."

[[ -d "$GOV_ROOT/.git" ]] || fail "Governance repository not found at $GOV_ROOT."
[[ -d "$APP_ROOT/.git" ]] || fail "Application repository not found at $APP_ROOT. Expected sibling folder: vantage-platform."
[[ -z "$(git -C "$GOV_ROOT" status --porcelain)" ]] || fail "Governance repository has uncommitted changes. No uncommitted artifact may satisfy a P# gate."
[[ "$(git -C "$GOV_ROOT" branch --show-current)" == "main" ]] || fail "Governance repository must be on main."

echo "Synchronizing authoritative governance state..."
git -C "$GOV_ROOT" fetch origin main
git -C "$GOV_ROOT" pull --ff-only origin main
[[ "$(git -C "$GOV_ROOT" rev-parse HEAD)" == "$(git -C "$GOV_ROOT" rev-parse origin/main)" ]] || fail "Local governance HEAD does not exactly match origin/main."
[[ -z "$(git -C "$GOV_ROOT" status --porcelain)" ]] || fail "Governance repository changed during synchronization."

[[ -f "$CURRENT_STATE" ]] || fail "CURRENT_STATE.md is missing."
[[ -f "$GATE_FILE" ]] || fail "${P_ID}_EXECUTION_GATE.env is missing. The P# has not passed the commit/audit launch gate."
grep -Eq "^(- )?Active P#: \`?${P_ID}(\`|[[:space:]])" "$CURRENT_STATE" || fail "CURRENT_STATE.md does not identify $P_ID as the active P#."

getv() {
  local key="$1"
  awk -F= -v k="$key" '$1 == k {sub(/^[^=]*=/, ""); print; exit}' "$GATE_FILE"
}

require_value() {
  local key="$1"
  local expected="${2:-}"
  local value
  value="$(getv "$key")"
  [[ -n "$value" ]] || fail "Gate field $key is missing or empty."
  [[ "$value" != *"<"* && "$value" != *">"* ]] || fail "Gate field $key still contains a placeholder."
  if [[ -n "$expected" && "$value" != "$expected" ]]; then
    fail "Gate field $key is '$value'; expected '$expected'."
  fi
  printf '%s' "$value"
}

verify_evidence() {
  local file_key="$1"
  local commit_key="$2"
  local file commit current_blob recorded_blob
  file="$(require_value "$file_key")"
  commit="$(require_value "$commit_key")"
  [[ "$file" != /* && "$file" != *".."* ]] || fail "$file_key contains an unsafe path."
  [[ "$commit" =~ ^[0-9a-f]{7,40}$ ]] || fail "$commit_key is not a Git commit SHA."
  git -C "$GOV_ROOT" cat-file -e "$commit^{commit}" 2>/dev/null || fail "$commit_key does not resolve to a commit."
  git -C "$GOV_ROOT" merge-base --is-ancestor "$commit" origin/main || fail "$commit_key is not committed on authoritative origin/main."
  git -C "$GOV_ROOT" cat-file -e "$commit:$file" 2>/dev/null || fail "$file was not present at recorded commit $commit."
  git -C "$GOV_ROOT" cat-file -e "origin/main:$file" 2>/dev/null || fail "$file is missing from current authoritative origin/main."
  recorded_blob="$(git -C "$GOV_ROOT" rev-parse "$commit:$file")"
  current_blob="$(git -C "$GOV_ROOT" rev-parse "origin/main:$file")"
  [[ "$recorded_blob" == "$current_blob" ]] || fail "$file changed after its recorded gate commit. The bound evidence is stale and must be intentionally versioned/rebound."
}

verify_contains_at_commit() {
  local file_key="$1"
  local commit_key="$2"
  local exact_line="$3"
  local file commit
  file="$(require_value "$file_key")"
  commit="$(require_value "$commit_key")"
  git -C "$GOV_ROOT" show "$commit:$file" | grep -Fxq "$exact_line" || fail "$file does not contain required committed evidence line: $exact_line"
}

verify_unique_audit_result_at_commit() {
  local file_key="$1"
  local commit_key="$2"
  local expected_manifest_verdict="$3"
  local file commit content verdict_count critical_count major_count verdict critical major

  file="$(require_value "$file_key")"
  commit="$(require_value "$commit_key")"
  content="$(git -C "$GOV_ROOT" show "$commit:$file")"

  verdict_count="$(printf '%s\n' "$content" | grep -Ec '^Verdict: (PASS|FAIL)$' || true)"
  critical_count="$(printf '%s\n' "$content" | grep -Ec '^Unresolved CRITICAL: [0-9]+$' || true)"
  major_count="$(printf '%s\n' "$content" | grep -Ec '^Unresolved MAJOR: [0-9]+$' || true)"

  [[ "$verdict_count" == "1" ]] || fail "$file must contain exactly one Verdict: PASS|FAIL line; found $verdict_count."
  [[ "$critical_count" == "1" ]] || fail "$file must contain exactly one Unresolved CRITICAL count; found $critical_count."
  [[ "$major_count" == "1" ]] || fail "$file must contain exactly one Unresolved MAJOR count; found $major_count."

  verdict="$(printf '%s\n' "$content" | grep -E '^Verdict: (PASS|FAIL)$' | cut -d' ' -f2)"
  critical="$(printf '%s\n' "$content" | grep -E '^Unresolved CRITICAL: [0-9]+$' | awk '{print $3}')"
  major="$(printf '%s\n' "$content" | grep -E '^Unresolved MAJOR: [0-9]+$' | awk '{print $3}')"

  if [[ "$critical" == "0" && "$major" == "0" ]]; then
    [[ "$verdict" == "PASS" ]] || fail "$file has zero unresolved CRITICAL/MAJOR but Verdict is $verdict; expected PASS."
  else
    [[ "$verdict" == "FAIL" ]] || fail "$file has unresolved CRITICAL/MAJOR findings but Verdict is $verdict; expected FAIL."
  fi

  [[ "$expected_manifest_verdict" == "$verdict" ]] || fail "Gate manifest says audit verdict $expected_manifest_verdict but committed audit uniquely resolves to $verdict."
}

verify_contract_gate() {
  verify_evidence CONTRACT_FILE CONTRACT_COMMIT
  verify_evidence BRAD_REVIEW_FILE BRAD_REVIEW_COMMIT
  verify_evidence APPROVAL_FILE APPROVAL_COMMIT
  verify_evidence PRE_EXECUTION_AUDIT_FILE PRE_EXECUTION_AUDIT_COMMIT

  local brad_verdict pre_execution_audit_verdict
  brad_verdict="$(require_value BRAD_VERDICT)"
  [[ "$brad_verdict" == "PASS" || "$brad_verdict" == "APPROVE_CONTRACT" ]] || fail "BRAD_VERDICT must be PASS or APPROVE_CONTRACT."
  require_value CHRIS_APPROVAL APPROVED >/dev/null
  pre_execution_audit_verdict="$(require_value PRE_EXECUTION_AUDIT_VERDICT)"
  [[ "$pre_execution_audit_verdict" == "PASS" ]] || fail "PRE_EXECUTION_AUDIT_VERDICT must be PASS before execution."

  if [[ "$brad_verdict" == "PASS" ]]; then
    verify_contains_at_commit BRAD_REVIEW_FILE BRAD_REVIEW_COMMIT "Verdict: PASS"
  else
    verify_contains_at_commit BRAD_REVIEW_FILE BRAD_REVIEW_COMMIT "Verdict: APPROVE CONTRACT"
  fi
  verify_contains_at_commit APPROVAL_FILE APPROVAL_COMMIT "Decision: APPROVED"
  verify_unique_audit_result_at_commit PRE_EXECUTION_AUDIT_FILE PRE_EXECUTION_AUDIT_COMMIT "$pre_execution_audit_verdict"
}

verify_build_gate() {
  verify_contract_gate
  verify_evidence DIAGNOSTIC_FILE DIAGNOSTIC_COMMIT
  local classification
  classification="$(require_value DIAGNOSTIC_CLASSIFICATION)"
  [[ "$classification" == "VERIFIED_ROOT_CAUSE" || "$classification" == "VERIFIED_DESIGN_GAP" ]] || fail "DIAGNOSTIC_CLASSIFICATION must be VERIFIED_ROOT_CAUSE or VERIFIED_DESIGN_GAP before BOUNDED_BUILD."
  verify_evidence BETTY_PRE_REPAIR_FILE BETTY_PRE_REPAIR_COMMIT
  require_value BETTY_PRE_REPAIR_VERDICT PASS >/dev/null
  verify_contains_at_commit BETTY_PRE_REPAIR_FILE BETTY_PRE_REPAIR_COMMIT "Verdict: PASS"
  verify_contains_at_commit BETTY_PRE_REPAIR_FILE BETTY_PRE_REPAIR_COMMIT "Unresolved CRITICAL: 0"
  verify_contains_at_commit BETTY_PRE_REPAIR_FILE BETTY_PRE_REPAIR_COMMIT "Unresolved MAJOR: 0"
  verify_evidence REPAIR_AUTH_FILE REPAIR_AUTH_COMMIT
  require_value CHRIS_REPAIR_AUTH APPROVED >/dev/null
  verify_contains_at_commit REPAIR_AUTH_FILE REPAIR_AUTH_COMMIT "Decision: APPROVED"
}

verify_outcome_review_gate() {
  verify_build_gate
  verify_evidence TECHNICAL_PROOF_FILE TECHNICAL_PROOF_COMMIT
  verify_evidence SYSTEM_PROOF_FILE SYSTEM_PROOF_COMMIT
  verify_evidence CANDIDATE_FREEZE_FILE CANDIDATE_FREEZE_COMMIT
  verify_evidence PRODUCT_PROOF_FILE PRODUCT_PROOF_COMMIT
  verify_evidence SCENARIO_MATRIX_FILE SCENARIO_MATRIX_COMMIT
  verify_evidence RENDER_MANIFEST_FILE RENDER_MANIFEST_COMMIT
}

verify_closure_gate() {
  verify_outcome_review_gate
  verify_evidence BRAD_OUTCOME_FILE BRAD_OUTCOME_COMMIT
  require_value BRAD_OUTCOME_VERDICT PASS >/dev/null
  verify_contains_at_commit BRAD_OUTCOME_FILE BRAD_OUTCOME_COMMIT "Verdict: PASS"
  verify_evidence BETTY_FINAL_FILE BETTY_FINAL_COMMIT
  require_value BETTY_FINAL_VERDICT PASS >/dev/null
  verify_contains_at_commit BETTY_FINAL_FILE BETTY_FINAL_COMMIT "Verdict: PASS"
  verify_contains_at_commit BETTY_FINAL_FILE BETTY_FINAL_COMMIT "Unresolved CRITICAL: 0"
  verify_contains_at_commit BETTY_FINAL_FILE BETTY_FINAL_COMMIT "Unresolved MAJOR: 0"
  verify_evidence CLOSURE_AUTH_FILE CLOSURE_AUTH_COMMIT
  require_value CHRIS_CLOSURE APPROVE_AND_ADVANCE >/dev/null
  verify_contains_at_commit CLOSURE_AUTH_FILE CLOSURE_AUTH_COMMIT "Decision: APPROVE AND ADVANCE"
}

verify_current_state_authorization() {
  local stage="$1"
  local stage_line="- Current stage: $stage"
  local auth_line="- Authorized execution stage: $stage"

  grep -Fxq -- "$stage_line" "$CURRENT_STATE" || fail "CURRENT_STATE.md current stage does not exactly match authorized stage $stage."
  grep -Fxq -- "$auth_line" "$CURRENT_STATE" || fail "CURRENT_STATE.md does not explicitly authorize execution stage $stage."
}

MANIFEST_P="$(require_value P_ID)"
[[ "$MANIFEST_P" == "$P_ID" ]] || fail "Gate manifest is for $MANIFEST_P, not requested $P_ID."
AUTHORIZED_STAGE="$(require_value AUTHORIZED_STAGE)"

case "$AUTHORIZED_STAGE" in
  DIAGNOSTIC_TRUTH) verify_contract_gate ;;
  BOUNDED_BUILD) verify_build_gate ;;
  OUTCOME_REVIEW) verify_outcome_review_gate ;;
  CLOSURE) verify_closure_gate ;;
  *) fail "Unsupported AUTHORIZED_STAGE '$AUTHORIZED_STAGE'. The governance must explicitly define the stage before execution." ;;
esac

verify_current_state_authorization "$AUTHORIZED_STAGE"

APP_BRANCH="$(require_value APPLICATION_BRANCH)"
APP_SHA="$(require_value APPLICATION_SHA)"
[[ "$APP_SHA" =~ ^[0-9a-f]{40}$ ]] || fail "APPLICATION_SHA must be an exact 40-character SHA."

if [[ "$AUTHORIZED_STAGE" == "OUTCOME_REVIEW" || "$AUTHORIZED_STAGE" == "CLOSURE" ]]; then
  CANDIDATE_APPLICATION_SHA="$(require_value CANDIDATE_APPLICATION_SHA)"
  [[ "$CANDIDATE_APPLICATION_SHA" == "$APP_SHA" ]] || fail "CANDIDATE_APPLICATION_SHA does not equal APPLICATION_SHA."
fi

[[ -z "$(git -C "$APP_ROOT" status --porcelain)" ]] || fail "Application repository has uncommitted changes. Preserve/reconcile them before governed execution."
[[ "$(git -C "$APP_ROOT" branch --show-current)" == "$APP_BRANCH" ]] || fail "Application repository must be on '$APP_BRANCH' for this gate."

echo "Verifying exact application candidate..."
git -C "$APP_ROOT" fetch origin "$APP_BRANCH"
[[ "$(git -C "$APP_ROOT" rev-parse "origin/$APP_BRANCH")" == "$APP_SHA" ]] || fail "origin/$APP_BRANCH does not equal the gate's exact APPLICATION_SHA."
git -C "$APP_ROOT" pull --ff-only origin "$APP_BRANCH"
[[ "$(git -C "$APP_ROOT" rev-parse HEAD)" == "$APP_SHA" ]] || fail "Local application HEAD does not equal the gate's exact APPLICATION_SHA."
[[ -z "$(git -C "$APP_ROOT" status --porcelain)" ]] || fail "Application tree is not clean after synchronization."

stage_actor() {
  case "$1" in
    DIAGNOSTIC_TRUTH|BOUNDED_BUILD) printf '%s' "BUILDER" ;;
    OUTCOME_REVIEW) printf '%s' "BRAD" ;;
    CLOSURE) printf '%s' "CHRIS" ;;
    *) return 1 ;;
  esac
}

AUTHORIZED_ACTOR="$(stage_actor "$AUTHORIZED_STAGE")"

echo
echo "PRYSM PROCESS GATE PASS"
echo "P#: $P_ID"
echo "Authorized stage: $AUTHORIZED_STAGE"
echo "Authorized actor: $AUTHORIZED_ACTOR"
echo "Application: $APP_BRANCH @ $APP_SHA"
echo "Deterministic governance and candidate checks passed."
echo

launch_builder_stage() {
  ensure_codex_cli || fail "Codex CLI is required for Builder stage $AUTHORIZED_STAGE but is not discoverable. Non-Builder stages do not require Codex."

  local prompt
  prompt=$(cat <<EOF_PROMPT
You are operating inside the governed PRYSM Chris / Brad / Betty process.

DETERMINISTIC PROCESS GATE: PASS.
Do NOT perform a second process-gate audit. Do not re-interpret Git freshness, evidence commit bindings, current-state synchronization, or application SHA unless a new command proves state changed after launch. The launcher already verified those facts deterministically.

Active workstream: $P_ID
Authorized stage: $AUTHORIZED_STAGE
Authorized actor: BUILDER
Exact application branch: $APP_BRANCH
Exact application SHA: $APP_SHA

Read the current governing files and perform ONLY the authorized stage.

For DIAGNOSTIC_TRUTH: read-only diagnosis only; no production-code edits. Produce the material P# lineage map and branch/scenario inventory required by the Outcome Contract.
For BOUNDED_BUILD: change only the committed bounded repair authorization and required proof surfaces. Stop on a genuinely new material boundary.

If authoritative evidence encountered during the authorized stage materially contradicts the committed stage inputs, report `PRYSM STAGE EVIDENCE CONFLICT` with the exact evidence. Do not invent a stale-manifest/process-gate failure without deterministic Git evidence.

Hard boundaries remain active: no unauthorized paid/live provider or model calls, no merge/deploy/production change, no destructive reset/clean/discard, no force push, no P# advancement, and no stage advancement beyond $AUTHORIZED_STAGE.
EOF_PROMPT
)

  cd "$WORKSPACE_ROOT"
  exec codex "$prompt"
}

case "$AUTHORIZED_STAGE" in
  DIAGNOSTIC_TRUTH|BOUNDED_BUILD)
    launch_builder_stage
    ;;
  OUTCOME_REVIEW)
    cat <<EOF_HANDOFF
PRYSM ROLE HANDOFF
Next actor: BRAD
Chris action: STOP after this PASS and hand P1 to Brad.

Brad reviews the frozen candidate independently against the committed Outcome Contract.
Outcome contract: $(getv CONTRACT_FILE)
Technical proof: $(getv TECHNICAL_PROOF_FILE)
System proof: $(getv SYSTEM_PROOF_FILE)
Candidate freeze: $(getv CANDIDATE_FREEZE_FILE)
Product proof: $(getv PRODUCT_PROOF_FILE)
Scenario matrix: $(getv SCENARIO_MATRIX_FILE)
Rendered manifest: $(getv RENDER_MANIFEST_FILE)
Application: $APP_BRANCH @ $APP_SHA

Brad review questions are the committed OUTCOME_REVIEW questions in PRYSM_OUTCOME_GATED_P_REVIEW_PROTOCOL_2026-09-04.md.
Brad must create a NEW outcome-review evidence file. Do not edit any manifest-bound prerequisite evidence in place.
No application code changes, no P2, no deploy, no model/provider calls.
EOF_HANDOFF
    exit 0
    ;;
  CLOSURE)
    cat <<EOF_CLOSURE
PRYSM ROLE HANDOFF
Next actor: CHRIS
All committed closure prerequisites and the exact application candidate passed the deterministic gate.
Record/verify durable closure state only. Do not begin the next P# until the closure state commit is verified.
EOF_CLOSURE
    exit 0
    ;;
esac
