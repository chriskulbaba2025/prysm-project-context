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

  # Standard npm global shim location for Git-for-Windows / VS Code setups.
  candidate="$HOME/AppData/Roaming/npm"
  if [[ -d "$candidate" ]]; then
    export PATH="$PATH:$candidate"
    command -v codex >/dev/null 2>&1 && return 0
  fi

  # Resolve APPDATA when Git Bash receives it in Windows path form.
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

  # Fall back to npm's configured global prefix when npm is already visible.
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
ensure_codex_cli || fail "Codex CLI is installed but not discoverable by this shell, or is not installed. Expected Windows npm shim under ~/AppData/Roaming/npm or the configured npm global prefix."

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
# CURRENT_STATE may carry the governed P# as plain text or as a backticked
# descriptive label such as: - Active P#: `P1 — Cross-Report Contradiction Integrity`
# Require an anchored Active P# line and an exact P-ID token boundary so P1
# cannot accidentally match P10.
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
  [[ "$recorded_blob" == "$current_blob" ]] || fail "$file changed after its recorded gate commit. The gate is stale and must be regenerated."
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

  BRAD_VERDICT="$(require_value BRAD_VERDICT)"
  [[ "$BRAD_VERDICT" == "PASS" || "$BRAD_VERDICT" == "APPROVE_CONTRACT" ]] || fail "BRAD_VERDICT must be PASS or APPROVE_CONTRACT."
  require_value CHRIS_APPROVAL APPROVED >/dev/null
  PRE_EXECUTION_AUDIT_VERDICT="$(require_value PRE_EXECUTION_AUDIT_VERDICT)"
  [[ "$PRE_EXECUTION_AUDIT_VERDICT" == "PASS" ]] || fail "PRE_EXECUTION_AUDIT_VERDICT must be PASS before execution."

  if [[ "$BRAD_VERDICT" == "PASS" ]]; then
    verify_contains_at_commit BRAD_REVIEW_FILE BRAD_REVIEW_COMMIT "Verdict: PASS"
  else
    verify_contains_at_commit BRAD_REVIEW_FILE BRAD_REVIEW_COMMIT "Verdict: APPROVE CONTRACT"
  fi
  verify_contains_at_commit APPROVAL_FILE APPROVAL_COMMIT "Decision: APPROVED"
  verify_unique_audit_result_at_commit PRE_EXECUTION_AUDIT_FILE PRE_EXECUTION_AUDIT_COMMIT "$PRE_EXECUTION_AUDIT_VERDICT"
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
  local command_marker="bash tools/prysm/start-prysm-p.sh $P_ID"

  grep -Fxq -- "$stage_line" "$CURRENT_STATE" || fail "CURRENT_STATE.md current stage does not exactly match authorized stage $stage."
  grep -Fxq -- "$auth_line" "$CURRENT_STATE" || fail "CURRENT_STATE.md does not explicitly authorize execution stage $stage."
  grep -Fq "$command_marker" "$CURRENT_STATE" || fail "CURRENT_STATE.md does not name the governed $P_ID execution launcher as the exact next action."
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
[[ -z "$(git -C "$APP_ROOT" status --porcelain)" ]] || fail "Application repository has uncommitted changes. Preserve/reconcile them before governed execution."
[[ "$(git -C "$APP_ROOT" branch --show-current)" == "$APP_BRANCH" ]] || fail "Application repository must be on '$APP_BRANCH' for this gate."

echo "Verifying exact application candidate..."
git -C "$APP_ROOT" fetch origin "$APP_BRANCH"
[[ "$(git -C "$APP_ROOT" rev-parse "origin/$APP_BRANCH")" == "$APP_SHA" ]] || fail "origin/$APP_BRANCH does not equal the gate's exact APPLICATION_SHA."
git -C "$APP_ROOT" pull --ff-only origin "$APP_BRANCH"
[[ "$(git -C "$APP_ROOT" rev-parse HEAD)" == "$APP_SHA" ]] || fail "Local application HEAD does not equal the gate's exact APPLICATION_SHA."
[[ -z "$(git -C "$APP_ROOT" status --porcelain)" ]] || fail "Application tree is not clean after synchronization."

PROMPT=$(cat <<EOF
You are operating inside the governed PRYSM Chris / Brad / Betty process.

Active workstream: $P_ID
Authorized stage: $AUTHORIZED_STAGE
Exact application branch: $APP_BRANCH
Exact application SHA: $APP_SHA

GitHub/local checked-out Git repositories are authoritative.

Before doing ANY substantive work, perform a PROCESS GATE AUDIT.

Read first:
1. prysm-project-context/CURRENT_STATE.md
2. prysm-project-context/PRYSM_OUTCOME_GATED_P_REVIEW_PROTOCOL_2026-09-04.md
3. prysm-project-context/PRYSM_P_STAGE_COMMIT_AUDIT_GATE_2026-09-04.md
4. prysm-project-context/${P_ID}_EXECUTION_GATE.env
5. every contract, review, independent pre-execution audit, approval, proof, and authorization file named by that gate manifest for the authorized stage.

Independently verify that the required evidence actually addresses its mandated questions, recorded verdicts match contents, zero unresolved CRITICAL/MAJOR findings remain where required, CURRENT_STATE.md agrees with the manifest, and $AUTHORIZED_STAGE is the exact next authorized stage.

If any prerequisite is missing, weak, contradictory, stale, or not actually audited, return:
PRYSM PROCESS GATE FAIL
and explain only the blocking governance defect. Then STOP. Do not diagnose, code, test the application, or advance.

If and only if the process gate passes, return:
PRYSM PROCESS GATE PASS
then perform ONLY the authorized stage: $AUTHORIZED_STAGE.

Hard boundaries remain active: no unauthorized paid/live provider or model calls, no merge/deploy/production change, no destructive reset/clean/discard, no force push, no P# advancement, and no stage advancement beyond the exact authorization in the manifest.

For DIAGNOSTIC_TRUTH specifically: read-only diagnosis only; no production-code edits. Produce the material P# lineage map and branch/scenario inventory required by the Outcome Contract where applicable.
For BOUNDED_BUILD: change only the committed bounded repair authorization.
For OUTCOME_REVIEW: prepare/review the exact frozen client-visible outcome evidence only within the committed proof plan.
For CLOSURE: evaluate committed closure evidence only; do not begin the next P#.
EOF
)

echo
echo "PRYSM PROCESS GATE PASS (machine checks)"
echo "P#: $P_ID"
echo "Authorized stage: $AUTHORIZED_STAGE"
echo "Application: $APP_BRANCH @ $APP_SHA"
echo "Launching Codex for semantic process-gate audit and authorized stage..."
echo

cd "$WORKSPACE_ROOT"
exec codex "$PROMPT"
