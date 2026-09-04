#!/usr/bin/env bash
set -euo pipefail

EXPECTED_APP_SHA="6ea608a2625e2a14e28dbc7a5a04e5752b8eeeec"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GOV_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
WORKSPACE_ROOT="$(cd "$GOV_ROOT/.." && pwd)"
APP_ROOT="$WORKSPACE_ROOT/vantage-platform"

fail() {
  echo
  echo "PRYSM P1 STARTUP BLOCKED: $1" >&2
  exit 1
}

command -v git >/dev/null 2>&1 || fail "git is not installed or not on PATH."
command -v codex >/dev/null 2>&1 || fail "Codex CLI is not installed or not on PATH."

[[ -d "$GOV_ROOT/.git" ]] || fail "Governance repository was not found at $GOV_ROOT."
[[ -d "$APP_ROOT/.git" ]] || fail "Application repository was not found at $APP_ROOT. Expected sibling folder: vantage-platform."

[[ -z "$(git -C "$GOV_ROOT" status --porcelain)" ]] || fail "Governance repository has local changes. Preserve/reconcile them before continuing."
[[ -z "$(git -C "$APP_ROOT" status --porcelain)" ]] || fail "Application repository has local changes. Preserve/reconcile them before continuing."

GOV_BRANCH="$(git -C "$GOV_ROOT" branch --show-current)"
APP_BRANCH="$(git -C "$APP_ROOT" branch --show-current)"

[[ "$GOV_BRANCH" == "main" ]] || fail "Governance repository must be on main for this P1 startup. Current branch: $GOV_BRANCH"
[[ "$APP_BRANCH" == "main" ]] || fail "Application repository must be on main at the P1 Outcome Contract stage. Current branch: $APP_BRANCH"

echo "Updating authoritative governance state..."
git -C "$GOV_ROOT" pull --ff-only origin main

echo "Verifying frozen application baseline..."
git -C "$APP_ROOT" fetch origin main
REMOTE_APP_SHA="$(git -C "$APP_ROOT" rev-parse origin/main)"
[[ "$REMOTE_APP_SHA" == "$EXPECTED_APP_SHA" ]] || fail "origin/main is $REMOTE_APP_SHA, but P1 is frozen at $EXPECTED_APP_SHA. Do not continue until governance is reconciled."
git -C "$APP_ROOT" pull --ff-only origin main
LOCAL_APP_SHA="$(git -C "$APP_ROOT" rev-parse HEAD)"
[[ "$LOCAL_APP_SHA" == "$EXPECTED_APP_SHA" ]] || fail "Local application HEAD is $LOCAL_APP_SHA, expected $EXPECTED_APP_SHA."

REQUIRED_FILES=(
  "CURRENT_STATE.md"
  "PRYSM_OUTCOME_GATED_P_REVIEW_PROTOCOL_2026-09-04.md"
  "PRYSM_P1_P10_OUTCOME_REBASELINE_2026-09-04.md"
  "HANDOFF_PRYSM_OUTCOME_GOVERNANCE_CONTINUATION_2026-09-04.md"
  "P1_OUTCOME_CONTRACT_2026-09-04.md"
)

for file in "${REQUIRED_FILES[@]}"; do
  [[ -f "$GOV_ROOT/$file" ]] || fail "Required P1 governance file is missing: $file"
done

PROMPT=$(cat <<'EOF'
You are operating as Brad, the Independent Product / Process Reviewer for PRYSM.

GitHub/local checked-out Git repositories are the authoritative working source for this session.

Governance repository:
prysm-project-context

Application repository:
vantage-platform

Read these files first, in this exact order:

1. prysm-project-context/CURRENT_STATE.md
2. prysm-project-context/PRYSM_OUTCOME_GATED_P_REVIEW_PROTOCOL_2026-09-04.md
3. prysm-project-context/PRYSM_P1_P10_OUTCOME_REBASELINE_2026-09-04.md
4. prysm-project-context/HANDOFF_PRYSM_OUTCOME_GOVERNANCE_CONTINUATION_2026-09-04.md
5. prysm-project-context/P1_OUTCOME_CONTRACT_2026-09-04.md

Current active workstream:
P1 — Cross-Report Contradiction Integrity

Current authorized activity:
Re-review the revised P1 Outcome Contract only.

Roles:
- Chris = Outcome Owner / final approval authority.
- Brad = Independent Product / Process Reviewer.
- Betty = Adversarial Blind-Spot Auditor.
- Codex = execution assistant limited to the currently authorized stage.

Hard stops:
- Do not diagnose P1 yet.
- Do not inspect application code for root cause.
- Do not edit application code.
- Do not create a repair branch.
- Do not begin P2.
- Do not run a fresh live/paid audit.
- Do not make paid provider/model calls.
- Do not merge or deploy.
- Do not change production configuration.
- Do not reset, clean, discard, or force push.

First verify the governing files and frozen application SHA.

Then perform only the Brad P1 Outcome Contract re-review.

Return exactly:

P1 OUTCOME CONTRACT REVIEW

Original goal preserved: PASS / FAIL
Definition of done sufficient: PASS / FAIL
Acceptance criteria sufficient: PASS / FAIL
Could current contract still false-PASS: YES / NO
Material missing outcome requirement: YES / NO
Verdict: APPROVE CONTRACT / REVISE CONTRACT

If REVISE CONTRACT, identify only the single material gap preventing approval.

Then STOP.
EOF
)

echo
echo "PRYSM P1 verified. Launching Codex for Brad's Outcome Contract review..."
echo "Frozen application SHA: $LOCAL_APP_SHA"
echo

cd "$WORKSPACE_ROOT"
exec codex "$PROMPT"
