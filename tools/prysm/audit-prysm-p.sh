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

CONTRACT_FILE="$(find "$GOV_ROOT" -maxdepth 1 -type f -name "${P_ID}_OUTCOME_CONTRACT_*.md" | sort | tail -n 1)"
[[ -n "$CONTRACT_FILE" ]] || fail "No ${P_ID} Outcome Contract is committed in the governance repository."
CONTRACT_REL="$(basename "$CONTRACT_FILE")"
git -C "$GOV_ROOT" cat-file -e "origin/main:$CONTRACT_REL" 2>/dev/null || fail "$CONTRACT_REL is not committed on authoritative origin/main."
! grep -Eq '^Status: DRAFT' "$CONTRACT_FILE" || fail "$CONTRACT_REL is still marked DRAFT."

BRAD_DISPOSITION_FILE="$(find "$GOV_ROOT" -maxdepth 1 -type f -name "${P_ID}_BRAD_DISPOSITION_REVIEW*.md" | sort | tail -n 1 || true)"
if [[ -n "$BRAD_DISPOSITION_FILE" ]]; then
  BRAD_REVIEW_FILE="$BRAD_DISPOSITION_FILE"
else
  BRAD_REVIEW_FILE="$(find "$GOV_ROOT" -maxdepth 1 -type f -name "${P_ID}_BRAD_OUTCOME_CONTRACT_REVIEW*.md" | sort | tail -n 1)"
fi
[[ -n "$BRAD_REVIEW_FILE" ]] || fail "No committed Brad approval/preservation review was found for $P_ID."
BRAD_REVIEW_REL="$(basename "$BRAD_REVIEW_FILE")"
git -C "$GOV_ROOT" cat-file -e "origin/main:$BRAD_REVIEW_REL" 2>/dev/null || fail "$BRAD_REVIEW_REL is not committed on authoritative origin/main."
grep -Eq '^Verdict: (APPROVE CONTRACT|APPROVE_CONTRACT|PASS)$' "$BRAD_REVIEW_FILE" || fail "Latest Brad review does not record an approving verdict."

APPROVAL_FILE="$(find "$GOV_ROOT" -maxdepth 1 -type f -name "${P_ID}_APPROVAL_ATTESTATION_*.md" | sort | tail -n 1)"
[[ -n "$APPROVAL_FILE" ]] || fail "No durable ${P_ID} approval attestation was found. The audit launcher will not rely on chat-only approval."
APPROVAL_REL="$(basename "$APPROVAL_FILE")"
git -C "$GOV_ROOT" cat-file -e "origin/main:$APPROVAL_REL" 2>/dev/null || fail "$APPROVAL_REL is not committed on authoritative origin/main."
grep -Fxq 'Decision: APPROVED' "$APPROVAL_FILE" || fail "$APPROVAL_REL does not contain Decision: APPROVED."

DISPOSITION_FILE="$(find "$GOV_ROOT" -maxdepth 1 -type f -name "${P_ID}_PRE_EXECUTION_AUDIT_DISPOSITIONS_*.md" | sort | tail -n 1 || true)"
DISPOSITION_REL=""
if [[ -n "$DISPOSITION_FILE" ]]; then
  DISPOSITION_REL="$(basename "$DISPOSITION_FILE")"
  git -C "$GOV_ROOT" cat-file -e "origin/main:$DISPOSITION_REL" 2>/dev/null || fail "$DISPOSITION_REL is not committed on authoritative origin/main."
fi

APP_SHA="$(grep -Eo '[0-9a-f]{40}' "$CONTRACT_FILE" | head -n 1 || true)"
[[ "$APP_SHA" =~ ^[0-9a-f]{40}$ ]] || fail "Could not recover the exact application SHA from the Outcome Contract."
[[ -z "$(git -C "$APP_ROOT" status --porcelain)" ]] || fail "Application repository has uncommitted changes. Preserve/reconcile them before audit."

echo "Verifying application baseline exists..."
git -C "$APP_ROOT" fetch origin main
git -C "$APP_ROOT" cat-file -e "$APP_SHA^{commit}" 2>/dev/null || fail "Outcome Contract application SHA $APP_SHA does not resolve locally after fetch."

AUDIT_FILE="${P_ID}_PRE_EXECUTION_PROCESS_AUDIT_$(date +%Y-%m-%d_%H%M%S).md"
AUDIT_PATH="$GOV_ROOT/$AUDIT_FILE"

PROMPT=$(cat <<EOF
You are the independent pre-execution Auditor for PRYSM $P_ID.

Your task is a separate audit of the currently committed $P_ID governance package before any diagnosis or application execution may begin.

Authoritative governance repository: prysm-project-context
Application repository: vantage-platform
Active P#: $P_ID
Governance HEAD being audited: $AUDIT_BASE_GOV_SHA
Frozen application SHA from the Outcome Contract: $APP_SHA

The launcher has machine-verified that committed approval evidence exists. Do not trust that fact blindly; independently inspect the evidence content and sequencing.

Read first:
1. prysm-project-context/CURRENT_STATE.md
2. prysm-project-context/PRYSM_OUTCOME_GATED_P_REVIEW_PROTOCOL_2026-09-04.md
3. prysm-project-context/PRYSM_P_STAGE_COMMIT_AUDIT_GATE_2026-09-04.md
4. prysm-project-context/$CONTRACT_REL
5. prysm-project-context/$BRAD_REVIEW_REL
6. prysm-project-context/$APPROVAL_REL
EOF
)

if [[ -n "$DISPOSITION_REL" ]]; then
  PROMPT+=$'\n7. prysm-project-context/'"$DISPOSITION_REL"$'\n'
fi

PROMPT+=$(cat <<EOF

Also inspect all other committed $P_ID review/audit/approval evidence that is materially relevant.

AUDIT PURPOSE
Independently determine whether the current $P_ID package is safe and complete enough to become the authority for the later governed $P_ID execution cycle.

Required audit attacks:
- original goal drift or narrowing;
- acceptance criteria that can PASS while the client/business outcome remains unmet;
- missing client-visible/product proof requirements;
- contradictions between Outcome Contract, CURRENT_STATE, review evidence, approval evidence, dispositions, and governing protocol;
- missing, stale, or misrepresented approval evidence;
- hidden dependencies;
- wrong application baseline or provenance assumptions;
- producer/persistence/consumer/render seams that the later diagnosis/proof plan must explicitly cover;
- any way the process could claim a required review/audit/approval happened when durable evidence does not support that claim;
- any way a later technical PASS could still create a false product PASS;
- whether accepted audit findings were actually closed rather than merely relabeled.

Do NOT diagnose application code or root cause.
Do NOT edit application code.
Do NOT create a repair branch.
Do NOT run tests, providers, paid/model workflows, production audits, builds, deployment, or P2 work.
Do NOT authorize DIAGNOSTIC_TRUTH.

You MAY create exactly one file and change nothing else:
prysm-project-context/$AUDIT_FILE

The audit artifact must contain these exact metadata lines:
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

PASS is allowed only if Unresolved CRITICAL: 0 and Unresolved MAJOR: 0 and the audit finds no material process gap that could allow $P_ID to advance without proving its original client/business outcome.

Do not commit or push anything yourself. The governed launcher will validate and preserve the audit after you stop.

Then STOP.
EOF
)

echo
echo "PRYSM $P_ID pre-execution audit ready."
echo "Outcome Contract: $CONTRACT_REL"
echo "Brad review: $BRAD_REVIEW_REL"
echo "Approval evidence: $APPROVAL_REL"
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
grep -Fxq "Governance HEAD audited: $AUDIT_BASE_GOV_SHA" "$AUDIT_PATH" || fail "Audit artifact does not record the exact governance HEAD audited."
grep -Fxq "Frozen application SHA: $APP_SHA" "$AUDIT_PATH" || fail "Audit artifact does not record the exact frozen application SHA."
grep -Eq '^Unresolved CRITICAL: [0-9]+$' "$AUDIT_PATH" || fail "Audit artifact lacks a valid Unresolved CRITICAL count."
grep -Eq '^Unresolved MAJOR: [0-9]+$' "$AUDIT_PATH" || fail "Audit artifact lacks a valid Unresolved MAJOR count."
grep -Eq '^Verdict: (PASS|FAIL)$' "$AUDIT_PATH" || fail "Audit artifact lacks an exact PASS/FAIL verdict."

STATUS_OUTPUT="$(git -C "$GOV_ROOT" status --porcelain)"
[[ -n "$STATUS_OUTPUT" ]] || fail "No governance change exists after Codex audit."
CHANGED_COUNT="$(printf '%s\n' "$STATUS_OUTPUT" | sed '/^$/d' | wc -l | tr -d ' ')"
[[ "$CHANGED_COUNT" == "1" ]] || fail "Codex changed $CHANGED_COUNT files; exactly one audit artifact is allowed. Nothing was committed."
CHANGED_PATH="$(printf '%s\n' "$STATUS_OUTPUT" | head -n 1 | cut -c4-)"
[[ "$CHANGED_PATH" == "$AUDIT_FILE" ]] || fail "Codex changed '$CHANGED_PATH' instead of only '$AUDIT_FILE'. Nothing was committed."

echo "Rechecking authoritative GitHub state before evidence commit..."
git -C "$GOV_ROOT" fetch origin main
REMOTE_AFTER_AUDIT="$(git -C "$GOV_ROOT" rev-parse origin/main)"
[[ "$REMOTE_AFTER_AUDIT" == "$AUDIT_BASE_GOV_SHA" ]] || fail "origin/main moved from $AUDIT_BASE_GOV_SHA to $REMOTE_AFTER_AUDIT during the audit. Audit evidence remains local and uncommitted because the audited governance state is stale."

git -C "$GOV_ROOT" add -- "$AUDIT_FILE"
git -C "$GOV_ROOT" commit -m "audit: record $P_ID pre-execution process audit"
AUDIT_COMMIT="$(git -C "$GOV_ROOT" rev-parse HEAD)"

echo "Pushing audit evidence to authoritative governance..."
git -C "$GOV_ROOT" push origin main
git -C "$GOV_ROOT" fetch origin main
[[ "$(git -C "$GOV_ROOT" rev-parse origin/main)" == "$AUDIT_COMMIT" ]] || fail "Push returned but origin/main does not equal audit commit $AUDIT_COMMIT."
[[ -z "$(git -C "$GOV_ROOT" status --porcelain)" ]] || fail "Governance tree is not clean after audit evidence push."

VERDICT="$(grep -E '^Verdict: (PASS|FAIL)$' "$AUDIT_PATH" | head -n 1 | cut -d' ' -f2)"
CRITICAL="$(grep -E '^Unresolved CRITICAL: [0-9]+$' "$AUDIT_PATH" | head -n 1 | awk '{print $3}')"
MAJOR="$(grep -E '^Unresolved MAJOR: [0-9]+$' "$AUDIT_PATH" | head -n 1 | awk '{print $3}')"

echo
echo "PRYSM AUDIT EVIDENCE PUBLISHED"
echo "P#: $P_ID"
echo "Audit file: $AUDIT_FILE"
echo "Audit commit: $AUDIT_COMMIT"
echo "Verdict: $VERDICT"
echo "Unresolved CRITICAL: $CRITICAL"
echo "Unresolved MAJOR: $MAJOR"
echo "Remote review can now read this exact audit from GitHub."
echo "STOP: this audit commit does not authorize the next P# stage by itself."
