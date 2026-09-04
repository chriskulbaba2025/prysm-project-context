#!/usr/bin/env bash
set -euo pipefail

P_ID="${1:-}"

fail() {
  echo >&2
  echo "PRYSM AUDIT PIPELINE BLOCKED: $1" >&2
  exit 1
}

[[ -n "$P_ID" ]] || fail "Usage: bash tools/prysm/audit-prysm-p.sh P1"
[[ "$P_ID" =~ ^P([1-9]|10)([A-Z][A-Z0-9-]*)?$ ]] || fail "Invalid P# '$P_ID'."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GOV_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
WORKSPACE_ROOT="$(cd "$GOV_ROOT/.." && pwd)"
APP_ROOT="$WORKSPACE_ROOT/vantage-platform"
CURRENT_STATE="$GOV_ROOT/CURRENT_STATE.md"
PRE_AUDIT_GATE="$GOV_ROOT/${P_ID}_PRE_EXECUTION_AUDIT_GATE.env"

command -v git >/dev/null 2>&1 || fail "git is not installed or not on PATH."
command -v codex >/dev/null 2>&1 || fail "Codex CLI is not installed or not on PATH."

[[ -d "$GOV_ROOT/.git" ]] || fail "Governance repository not found at $GOV_ROOT."
[[ -d "$APP_ROOT/.git" ]] || fail "Application repository not found at $APP_ROOT. Expected sibling folder: vantage-platform."
[[ -z "$(git -C "$GOV_ROOT" status --porcelain)" ]] || fail "Governance repository has uncommitted changes. Preserve/reconcile them before starting the audit."
[[ "$(git -C "$GOV_ROOT" branch --show-current)" == "main" ]] || fail "Governance repository must be on main."

echo "Synchronizing authoritative governance state..."
git -C "$GOV_ROOT" fetch origin main
git -C "$GOV_ROOT" pull --ff-only origin main
[[ "$(git -C "$GOV_ROOT" rev-parse HEAD)" == "$(git -C "$GOV_ROOT" rev-parse origin/main)" ]] || fail "Local governance HEAD does not exactly match origin/main."
[[ -z "$(git -C "$GOV_ROOT" status --porcelain)" ]] || fail "Governance repository changed during synchronization."
AUDIT_BASE_GOV_SHA="$(git -C "$GOV_ROOT" rev-parse HEAD)"

[[ -f "$CURRENT_STATE" ]] || fail "CURRENT_STATE.md is missing."
grep -Fq "Active P#: $P_ID" "$CURRENT_STATE" || fail "CURRENT_STATE.md does not identify $P_ID as the active P#."
grep -Fxq -- '- Current stage: INDEPENDENT PRE-EXECUTION AUDIT' "$CURRENT_STATE" || fail "CURRENT_STATE.md does not authorize INDEPENDENT PRE-EXECUTION AUDIT as the current stage."
grep -Fq "bash tools/prysm/audit-prysm-p.sh $P_ID" "$CURRENT_STATE" || fail "CURRENT_STATE.md does not name the independent $P_ID audit as the exact next action."

[[ -f "$PRE_AUDIT_GATE" ]] || fail "${P_ID}_PRE_EXECUTION_AUDIT_GATE.env is missing. Exact evidence binding has not been committed."

gatev() {
  local key="$1"
  awk -F= -v k="$key" '$1 == k {sub(/^[^=]*=/, ""); print; exit}' "$PRE_AUDIT_GATE"
}

require_gate_value() {
  local key="$1"
  local expected="${2:-}"
  local value
  value="$(gatev "$key")"
  [[ -n "$value" ]] || fail "Pre-audit gate field $key is missing or empty."
  [[ "$value" != *"<"* && "$value" != *">"* ]] || fail "Pre-audit gate field $key contains a placeholder."
  if [[ -n "$expected" && "$value" != "$expected" ]]; then
    fail "Pre-audit gate field $key is '$value'; expected '$expected'."
  fi
  printf '%s' "$value"
}

verify_evidence() {
  local file_key="$1"
  local commit_key="$2"
  local file commit recorded_blob current_blob
  file="$(require_gate_value "$file_key")"
  commit="$(require_gate_value "$commit_key")"

  [[ "$file" != /* && "$file" != *".."* ]] || fail "$file_key contains an unsafe path."
  [[ "$commit" =~ ^[0-9a-f]{40}$ ]] || fail "$commit_key must be an exact 40-character Git commit SHA."
  git -C "$GOV_ROOT" cat-file -e "$commit^{commit}" 2>/dev/null || fail "$commit_key does not resolve to a commit."
  git -C "$GOV_ROOT" merge-base --is-ancestor "$commit" origin/main || fail "$commit_key is not an ancestor of authoritative origin/main."
  git -C "$GOV_ROOT" cat-file -e "$commit:$file" 2>/dev/null || fail "$file did not exist at recorded commit $commit."
  git -C "$GOV_ROOT" cat-file -e "origin/main:$file" 2>/dev/null || fail "$file is missing from current origin/main."
  recorded_blob="$(git -C "$GOV_ROOT" rev-parse "$commit:$file")"
  current_blob="$(git -C "$GOV_ROOT" rev-parse "origin/main:$file")"
  [[ "$recorded_blob" == "$current_blob" ]] || fail "$file changed after recorded commit $commit. Pre-audit gate is stale."
}

verify_line() {
  local file_key="$1"
  local commit_key="$2"
  local line="$3"
  local file commit
  file="$(require_gate_value "$file_key")"
  commit="$(require_gate_value "$commit_key")"
  git -C "$GOV_ROOT" show "$commit:$file" | grep -Fxq "$line" || fail "$file lacks required committed line: $line"
}

parse_unique_audit_result_file() {
  local file="$1"
  local verdict_count critical_count major_count verdict critical major

  verdict_count="$(grep -Ec '^Verdict: (PASS|FAIL)$' "$file" || true)"
  critical_count="$(grep -Ec '^Unresolved CRITICAL: [0-9]+$' "$file" || true)"
  major_count="$(grep -Ec '^Unresolved MAJOR: [0-9]+$' "$file" || true)"

  [[ "$verdict_count" == "1" ]] || fail "Audit artifact must contain exactly one Verdict: PASS|FAIL line; found $verdict_count."
  [[ "$critical_count" == "1" ]] || fail "Audit artifact must contain exactly one Unresolved CRITICAL count; found $critical_count."
  [[ "$major_count" == "1" ]] || fail "Audit artifact must contain exactly one Unresolved MAJOR count; found $major_count."

  verdict="$(grep -E '^Verdict: (PASS|FAIL)$' "$file" | cut -d' ' -f2)"
  critical="$(grep -E '^Unresolved CRITICAL: [0-9]+$' "$file" | awk '{print $3}')"
  major="$(grep -E '^Unresolved MAJOR: [0-9]+$' "$file" | awk '{print $3}')"

  if [[ "$critical" == "0" && "$major" == "0" ]]; then
    [[ "$verdict" == "PASS" ]] || fail "Audit artifact has zero unresolved CRITICAL/MAJOR but Verdict is $verdict; expected PASS."
  else
    [[ "$verdict" == "FAIL" ]] || fail "Audit artifact has unresolved CRITICAL/MAJOR findings but Verdict is $verdict; expected FAIL."
  fi

  AUDIT_RESULT_VERDICT="$verdict"
  AUDIT_RESULT_CRITICAL="$critical"
  AUDIT_RESULT_MAJOR="$major"
}

MANIFEST_P="$(require_gate_value P_ID)"
[[ "$MANIFEST_P" == "$P_ID" ]] || fail "Pre-audit gate belongs to $MANIFEST_P, not $P_ID."
require_gate_value AUTHORIZED_AUDIT_STAGE INDEPENDENT_PRE_EXECUTION_AUDIT >/dev/null
APP_SHA="$(require_gate_value APPLICATION_SHA)"
[[ "$APP_SHA" =~ ^[0-9a-f]{40}$ ]] || fail "APPLICATION_SHA must be an exact 40-character SHA."

verify_evidence CONTRACT_FILE CONTRACT_COMMIT
verify_evidence DISPOSITION_FILE DISPOSITION_COMMIT
verify_evidence APPROVAL_FILE APPROVAL_COMMIT
verify_evidence BRAD_REVIEW_FILE BRAD_REVIEW_COMMIT
verify_evidence PRIOR_AUDIT_FILE PRIOR_AUDIT_COMMIT

CONTRACT_REL="$(require_gate_value CONTRACT_FILE)"
DISPOSITION_REL="$(require_gate_value DISPOSITION_FILE)"
APPROVAL_REL="$(require_gate_value APPROVAL_FILE)"
BRAD_REVIEW_REL="$(require_gate_value BRAD_REVIEW_FILE)"
PRIOR_AUDIT_REL="$(require_gate_value PRIOR_AUDIT_FILE)"
BRAD_REVIEW_BASE_GOV_SHA="$(require_gate_value BRAD_REVIEW_BASE_GOV_SHA)"
BRAD_REVIEW_COMMIT="$(require_gate_value BRAD_REVIEW_COMMIT)"
DISPOSITION_COMMIT="$(require_gate_value DISPOSITION_COMMIT)"
APPROVAL_COMMIT="$(require_gate_value APPROVAL_COMMIT)"
PRIOR_AUDIT_COMMIT="$(require_gate_value PRIOR_AUDIT_COMMIT)"

[[ "$BRAD_REVIEW_BASE_GOV_SHA" =~ ^[0-9a-f]{40}$ ]] || fail "BRAD_REVIEW_BASE_GOV_SHA must be an exact 40-character SHA."
git -C "$GOV_ROOT" merge-base --is-ancestor "$DISPOSITION_COMMIT" "$BRAD_REVIEW_BASE_GOV_SHA" || fail "Disposition evidence was not committed before Brad's reviewed governance base."
git -C "$GOV_ROOT" merge-base --is-ancestor "$APPROVAL_COMMIT" "$BRAD_REVIEW_BASE_GOV_SHA" || fail "Approval evidence was not committed before Brad's reviewed governance base."
git -C "$GOV_ROOT" merge-base --is-ancestor "$BRAD_REVIEW_BASE_GOV_SHA" "$BRAD_REVIEW_COMMIT" || fail "Brad review commit does not descend from the exact governance HEAD Brad reviewed."
git -C "$GOV_ROOT" merge-base --is-ancestor "$BRAD_REVIEW_COMMIT" "$PRIOR_AUDIT_COMMIT" || fail "The blocking prior audit does not occur after the committed Brad preservation review."

verify_line CONTRACT_FILE CONTRACT_COMMIT 'Status: AMENDED — CHRIS APPROVED; BRAD PRESERVATION REVIEW COMPLETE; FRESH AUDIT REQUIRED'
verify_line CONTRACT_FILE CONTRACT_COMMIT "Frozen application baseline: \`$APP_SHA\`"
verify_line DISPOSITION_FILE DISPOSITION_COMMIT 'Outcome Owner: Chris Kulbaba'
verify_line DISPOSITION_FILE DISPOSITION_COMMIT 'M-01: ACCEPT'
verify_line DISPOSITION_FILE DISPOSITION_COMMIT 'M-02: ACCEPT'
verify_line DISPOSITION_FILE DISPOSITION_COMMIT 'M-03: ACCEPT'
verify_line DISPOSITION_FILE DISPOSITION_COMMIT 'M-04: ACCEPT'
verify_line APPROVAL_FILE APPROVAL_COMMIT 'Outcome Owner: Chris Kulbaba'
verify_line APPROVAL_FILE APPROVAL_COMMIT 'P#: P1 — Cross-Report Contradiction Integrity'
verify_line APPROVAL_FILE APPROVAL_COMMIT 'Chris attests that the P1 Outcome Contract completed the prior Betty review/approval cycle and Chris approval in chat before the independent pre-execution process audit.'
verify_line APPROVAL_FILE APPROVAL_COMMIT 'It does not claim that Betty re-reviewed any later audit-driven amendment.'
verify_line APPROVAL_FILE APPROVAL_COMMIT 'Decision: APPROVED'
verify_line BRAD_REVIEW_FILE BRAD_REVIEW_COMMIT 'P#: P1'
verify_line BRAD_REVIEW_FILE BRAD_REVIEW_COMMIT "Governance HEAD reviewed: $BRAD_REVIEW_BASE_GOV_SHA"
verify_line BRAD_REVIEW_FILE BRAD_REVIEW_COMMIT "Outcome Contract: $CONTRACT_REL"
verify_line BRAD_REVIEW_FILE BRAD_REVIEW_COMMIT "Disposition File: $DISPOSITION_REL"
verify_line BRAD_REVIEW_FILE BRAD_REVIEW_COMMIT 'Original P1 outcome preserved: PASS'
verify_line BRAD_REVIEW_FILE BRAD_REVIEW_COMMIT 'All four dispositions substantively resolved: PASS'
verify_line BRAD_REVIEW_FILE BRAD_REVIEW_COMMIT 'MVP scope remains bounded: PASS'
verify_line BRAD_REVIEW_FILE BRAD_REVIEW_COMMIT 'Verdict: PASS'
verify_line PRIOR_AUDIT_FILE PRIOR_AUDIT_COMMIT 'Unresolved CRITICAL: 0'
verify_line PRIOR_AUDIT_FILE PRIOR_AUDIT_COMMIT 'Unresolved MAJOR: 2'
verify_line PRIOR_AUDIT_FILE PRIOR_AUDIT_COMMIT 'Verdict: FAIL'

[[ -z "$(git -C "$APP_ROOT" status --porcelain)" ]] || fail "Application repository has uncommitted changes. Preserve/reconcile them before audit."
echo "Verifying application baseline exists..."
git -C "$APP_ROOT" fetch origin main
git -C "$APP_ROOT" cat-file -e "$APP_SHA^{commit}" 2>/dev/null || fail "Frozen application SHA $APP_SHA does not resolve locally after fetch."

AUDIT_FILE="${P_ID}_PRE_EXECUTION_PROCESS_AUDIT_$(date +%Y-%m-%d_%H%M%S).md"
AUDIT_PATH="$GOV_ROOT/$AUDIT_FILE"

PROMPT=$(cat <<EOF
You are the independent pre-execution Auditor for PRYSM $P_ID.

This is a fresh audit of the exact committed P1 governance package after bounded corrections to the two findings in $PRIOR_AUDIT_REL. It is not diagnosis and does not authorize application work.

Authoritative governance repository: prysm-project-context
Application repository: vantage-platform
Active P#: $P_ID
Governance HEAD being audited: $AUDIT_BASE_GOV_SHA
Frozen application SHA: $APP_SHA
Pre-audit evidence manifest: ${P_ID}_PRE_EXECUTION_AUDIT_GATE.env

The launcher has machine-verified exact evidence files, exact commits/blobs, required content, sequencing, and unique prior result lines. Independently verify those claims rather than trusting the launcher.

Read first:
1. prysm-project-context/CURRENT_STATE.md
2. prysm-project-context/PRYSM_OUTCOME_GATED_P_REVIEW_PROTOCOL_2026-09-04.md
3. prysm-project-context/PRYSM_P_STAGE_COMMIT_AUDIT_GATE_2026-09-04.md
4. prysm-project-context/${P_ID}_PRE_EXECUTION_AUDIT_GATE.env
5. prysm-project-context/$CONTRACT_REL
6. prysm-project-context/$DISPOSITION_REL
7. prysm-project-context/$APPROVAL_REL
8. prysm-project-context/$BRAD_REVIEW_REL
9. prysm-project-context/$PRIOR_AUDIT_REL
10. all other committed P1 evidence materially relevant to these gates.

AUDIT PURPOSE
Determine whether the blocking findings from the prior audit are actually closed and whether the corrected package is safe to become the authority for later read-only DIAGNOSTIC_TRUTH.

Required attacks:
- exact evidence binding, commit/blob freshness, ancestry, and sequencing;
- unique, internally consistent audit verdict/count validation at publication and later execution;
- whether approval evidence proves the specific historical P1 attestation it claims without fabricating a new Betty review;
- whether Brad's committed PASS is bound to the dispositions and reviewed governance base;
- whether CURRENT_STATE.md and the Outcome Contract agree that Brad preservation review is complete and a fresh independent audit is the sole current stage;
- whether both the audit launcher and later execution launcher fail closed unless durable state explicitly authorizes the exact stage before Codex starts;
- whether changes after Brad's reviewed governance HEAD materially alter the P1 outcome/proof package. Gate/status/launcher/manifest corrections are non-material only if they do not change the client/business outcome or proof obligations Brad reviewed;
- whether M-03/M-04 remain closed and MVP-bounded;
- any remaining process path that could produce a false PASS.

Do NOT diagnose application code or root cause.
Do NOT edit application code.
Do NOT create a repair branch.
Do NOT run tests, providers, paid/model workflows, production audits, builds, deployment, or P2 work.
Do NOT create P1_EXECUTION_GATE.env.
Do NOT authorize DIAGNOSTIC_TRUTH yourself.

You MAY create exactly one file and change nothing else:
prysm-project-context/$AUDIT_FILE

The artifact must contain these exact metadata lines:
P#: $P_ID
Outcome Contract: $CONTRACT_REL
Governance HEAD audited: $AUDIT_BASE_GOV_SHA
Frozen application SHA: $APP_SHA

It must also contain:
- evidence reviewed;
- findings classified CRITICAL / MAJOR / MINOR;
- explicit disposition for each finding;
- Unresolved CRITICAL: <integer>;
- Unresolved MAJOR: <integer>;
- process false-PASS assessment;
- Verdict: PASS or Verdict: FAIL;
- exact next action.

There must be exactly one Verdict line and exactly one unresolved count line for each required severity. PASS is allowed if and only if Unresolved CRITICAL: 0 and Unresolved MAJOR: 0 and no material process gap remains that could let P1 advance without proving its original client/business outcome.

Do not commit or push anything yourself. The governed launcher will validate and publish the exact audit evidence after you stop.

Then STOP.
EOF
)

echo
echo "PRYSM $P_ID pre-execution audit ready."
echo "Evidence manifest: $(basename "$PRE_AUDIT_GATE")"
echo "Governance HEAD audited: $AUDIT_BASE_GOV_SHA"
echo "Frozen application SHA: $APP_SHA"
echo "Audit artifact target: $AUDIT_FILE"
echo "Launching Codex audit only..."
echo

cd "$WORKSPACE_ROOT"
codex "$PROMPT"

echo
echo "Validating Codex audit artifact..."
[[ -f "$AUDIT_PATH" ]] || fail "Codex exited without creating required audit artifact $AUDIT_FILE."
grep -Fxq "P#: $P_ID" "$AUDIT_PATH" || fail "Audit artifact does not identify exact P#: $P_ID."
grep -Fxq "Outcome Contract: $CONTRACT_REL" "$AUDIT_PATH" || fail "Audit artifact does not identify exact Outcome Contract."
grep -Fxq "Governance HEAD audited: $AUDIT_BASE_GOV_SHA" "$AUDIT_PATH" || fail "Audit artifact does not record exact governance HEAD audited."
grep -Fxq "Frozen application SHA: $APP_SHA" "$AUDIT_PATH" || fail "Audit artifact does not record exact frozen application SHA."
parse_unique_audit_result_file "$AUDIT_PATH"

STATUS_OUTPUT="$(git -C "$GOV_ROOT" status --porcelain)"
[[ -n "$STATUS_OUTPUT" ]] || fail "No governance change exists after Codex audit."
CHANGED_COUNT="$(printf '%s\n' "$STATUS_OUTPUT" | sed '/^$/d' | wc -l | tr -d ' ')"
[[ "$CHANGED_COUNT" == "1" ]] || fail "Codex changed $CHANGED_COUNT files; exactly one audit artifact is allowed. Nothing was committed."
CHANGED_PATH="$(printf '%s\n' "$STATUS_OUTPUT" | head -n 1 | cut -c4-)"
[[ "$CHANGED_PATH" == "$AUDIT_FILE" ]] || fail "Codex changed '$CHANGED_PATH' instead of only '$AUDIT_FILE'. Nothing was committed."

echo "Rechecking authoritative GitHub state before evidence commit..."
git -C "$GOV_ROOT" fetch origin main
REMOTE_AFTER_AUDIT="$(git -C "$GOV_ROOT" rev-parse origin/main)"
[[ "$REMOTE_AFTER_AUDIT" == "$AUDIT_BASE_GOV_SHA" ]] || fail "origin/main moved during audit. Audit remains local/uncommitted because audited governance state is stale."

git -C "$GOV_ROOT" add -- "$AUDIT_FILE"
git -C "$GOV_ROOT" commit -m "audit: record $P_ID pre-execution process audit"
AUDIT_COMMIT="$(git -C "$GOV_ROOT" rev-parse HEAD)"

echo "Pushing audit evidence to authoritative governance..."
git -C "$GOV_ROOT" push origin main
git -C "$GOV_ROOT" fetch origin main
[[ "$(git -C "$GOV_ROOT" rev-parse origin/main)" == "$AUDIT_COMMIT" ]] || fail "Push returned but origin/main does not equal audit commit $AUDIT_COMMIT."
[[ -z "$(git -C "$GOV_ROOT" status --porcelain)" ]] || fail "Governance tree is not clean after audit evidence push."

VERDICT="$AUDIT_RESULT_VERDICT"
CRITICAL="$AUDIT_RESULT_CRITICAL"
MAJOR="$AUDIT_RESULT_MAJOR"

echo
echo "PRYSM AUDIT EVIDENCE PUBLISHED"
echo "P#: $P_ID"
echo "Audit file: $AUDIT_FILE"
echo "Audit commit: $AUDIT_COMMIT"
echo "Verdict: $VERDICT"
echo "Unresolved CRITICAL: $CRITICAL"
echo "Unresolved MAJOR: $MAJOR"
echo "Remote review can now read this exact audit from GitHub."
echo "STOP: audit publication never authorizes the next stage by itself."
