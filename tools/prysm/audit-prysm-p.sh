#!/usr/bin/env bash
set -euo pipefail

P_ID="${1:-}"

fail() {
  echo >&2
  echo "PRYSM AUDIT START BLOCKED: $1" >&2
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

[[ -f "$CURRENT_STATE" ]] || fail "CURRENT_STATE.md is missing."
grep -Fq "Active P#: $P_ID" "$CURRENT_STATE" || fail "CURRENT_STATE.md does not identify $P_ID as the active P#."

CONTRACT_FILE="$(find "$GOV_ROOT" -maxdepth 1 -type f -name "${P_ID}_OUTCOME_CONTRACT_*.md" | sort | tail -n 1)"
[[ -n "$CONTRACT_FILE" ]] || fail "No ${P_ID} Outcome Contract is committed in the governance repository."
CONTRACT_REL="$(basename "$CONTRACT_FILE")"

git -C "$GOV_ROOT" cat-file -e "origin/main:$CONTRACT_REL" 2>/dev/null || fail "$CONTRACT_REL is not committed on authoritative origin/main."

BRAD_REVIEW_FILE="$(find "$GOV_ROOT" -maxdepth 1 -type f -name "${P_ID}_BRAD_OUTCOME_CONTRACT_REVIEW*.md" | sort | tail -n 1)"
[[ -n "$BRAD_REVIEW_FILE" ]] || fail "No committed Brad Outcome Contract review was found for $P_ID."
BRAD_REVIEW_REL="$(basename "$BRAD_REVIEW_FILE")"
git -C "$GOV_ROOT" cat-file -e "origin/main:$BRAD_REVIEW_REL" 2>/dev/null || fail "$BRAD_REVIEW_REL is not committed on authoritative origin/main."
grep -Eq '^Verdict: (APPROVE CONTRACT|APPROVE_CONTRACT)$' "$BRAD_REVIEW_FILE" || fail "Latest Brad review does not record APPROVE CONTRACT."

APP_SHA="$(grep -Eo '[0-9a-f]{40}' "$CONTRACT_FILE" | head -n 1 || true)"
[[ "$APP_SHA" =~ ^[0-9a-f]{40}$ ]] || fail "Could not recover the exact application SHA from the Outcome Contract."
[[ -z "$(git -C "$APP_ROOT" status --porcelain)" ]] || fail "Application repository has uncommitted changes. Preserve/reconcile them before audit."

echo "Verifying application baseline exists..."
git -C "$APP_ROOT" fetch origin main
git -C "$APP_ROOT" cat-file -e "$APP_SHA^{commit}" 2>/dev/null || fail "Outcome Contract application SHA $APP_SHA does not resolve locally after fetch."

AUDIT_FILE="${P_ID}_PRE_EXECUTION_PROCESS_AUDIT_$(date +%Y-%m-%d).md"

PROMPT=$(cat <<EOF
You are the independent pre-execution Auditor for PRYSM $P_ID.

This is NOT the Betty approval step. Betty/Brad contract evaluation is already complete. Your task is a separate audit of the approved $P_ID package and the governance process before any diagnosis or application execution may begin.

Authoritative governance repository: prysm-project-context
Application repository: vantage-platform
Active P#: $P_ID
Frozen application SHA from the Outcome Contract: $APP_SHA

Read first:
1. prysm-project-context/CURRENT_STATE.md
2. prysm-project-context/PRYSM_OUTCOME_GATED_P_REVIEW_PROTOCOL_2026-09-04.md
3. prysm-project-context/PRYSM_P_STAGE_COMMIT_AUDIT_GATE_2026-09-04.md
4. prysm-project-context/$CONTRACT_REL
5. prysm-project-context/$BRAD_REVIEW_REL
6. all other committed $P_ID Outcome Contract review/approval evidence that is materially relevant.

AUDIT PURPOSE
Independently determine whether the approved $P_ID package is safe and complete enough to be frozen and committed as the authority for the later governed $P_ID execution cycle.

Required audit attacks:
- original goal drift or narrowing;
- acceptance criteria that can PASS while the client/business outcome remains unmet;
- missing client-visible/product proof requirements;
- contradictions between Outcome Contract, CURRENT_STATE, review evidence, and governing protocol;
- missing or stale approval evidence;
- hidden dependencies;
- wrong application baseline or provenance assumptions;
- producer/persistence/consumer/render seams that the later diagnosis/proof plan must explicitly cover;
- any way the process could claim the required review/audit happened when durable evidence does not support that claim;
- any way a later technical PASS could still create a false product PASS.

Do NOT diagnose application code or root cause.
Do NOT edit application code.
Do NOT create a repair branch.
Do NOT run tests, providers, paid/model workflows, production audits, builds, deployment, or P2 work.
Do NOT authorize DIAGNOSTIC_TRUTH.

You MAY create exactly one governance audit artifact:
prysm-project-context/$AUDIT_FILE

The audit artifact must contain:
- exact P#;
- exact Outcome Contract file;
- exact governance HEAD audited;
- exact frozen application SHA;
- evidence reviewed;
- findings classified CRITICAL / MAJOR / MINOR;
- explicit disposition for each finding;
- Unresolved CRITICAL count;
- Unresolved MAJOR count;
- process false-PASS assessment;
- Verdict: PASS or FAIL;
- exact next action.

PASS is allowed only if Unresolved CRITICAL: 0 and Unresolved MAJOR: 0 and the audit finds no material process gap that could allow $P_ID to advance without proving its original client/business outcome.

Do not commit or push the audit artifact. Leave it for Chris review and durable commit after disposition.

Then STOP.
EOF
)

echo
echo "PRYSM $P_ID pre-execution audit ready."
echo "Outcome Contract: $CONTRACT_REL"
echo "Brad review: $BRAD_REVIEW_REL"
echo "Frozen application SHA: $APP_SHA"
echo "Audit artifact target: $AUDIT_FILE"
echo "Launching Codex audit only..."
echo

cd "$WORKSPACE_ROOT"
exec codex "$PROMPT"
