#!/usr/bin/env bash
set -euo pipefail

P_ID="${1:-}"

fail() {
  echo >&2
  echo "PRYSM BRAD DISPOSITION REVIEW BLOCKED: $1" >&2
  exit 1
}

[[ -n "$P_ID" ]] || fail "Usage: bash tools/brad/review-prysm-p-dispositions.sh P1"
[[ "$P_ID" =~ ^P([1-9]|10)([A-Z][A-Z0-9-]*)?$ ]] || fail "Invalid P# '$P_ID'."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GOV_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
WORKSPACE_ROOT="$(cd "$GOV_ROOT/.." && pwd)"
CURRENT_STATE="$GOV_ROOT/CURRENT_STATE.md"

command -v git >/dev/null 2>&1 || fail "git is not installed or not on PATH."
command -v codex >/dev/null 2>&1 || fail "Codex CLI is not installed or not on PATH."

[[ -d "$GOV_ROOT/.git" ]] || fail "Governance repository not found at $GOV_ROOT."
[[ -z "$(git -C "$GOV_ROOT" status --porcelain)" ]] || fail "Governance repository has uncommitted changes. Preserve/reconcile them first."
[[ "$(git -C "$GOV_ROOT" branch --show-current)" == "main" ]] || fail "Governance repository must be on main."

echo "Synchronizing authoritative governance state..."
git -C "$GOV_ROOT" fetch origin main
git -C "$GOV_ROOT" pull --ff-only origin main
[[ "$(git -C "$GOV_ROOT" rev-parse HEAD)" == "$(git -C "$GOV_ROOT" rev-parse origin/main)" ]] || fail "Local governance HEAD does not exactly match origin/main."
[[ -z "$(git -C "$GOV_ROOT" status --porcelain)" ]] || fail "Governance repository changed during synchronization."
REVIEW_BASE_GOV_SHA="$(git -C "$GOV_ROOT" rev-parse HEAD)"

[[ -f "$CURRENT_STATE" ]] || fail "CURRENT_STATE.md is missing."
grep -Fq "Active P#: $P_ID" "$CURRENT_STATE" || fail "CURRENT_STATE.md does not identify $P_ID as active."

CONTRACT_FILE="$(find "$GOV_ROOT" -maxdepth 1 -type f -name "${P_ID}_OUTCOME_CONTRACT_*.md" | sort | tail -n 1)"
DISPOSITION_FILE="$(find "$GOV_ROOT" -maxdepth 1 -type f -name "${P_ID}_PRE_EXECUTION_AUDIT_DISPOSITIONS_*.md" | sort | tail -n 1)"
APPROVAL_FILE="$(find "$GOV_ROOT" -maxdepth 1 -type f -name "${P_ID}_APPROVAL_ATTESTATION_*.md" | sort | tail -n 1)"
SOURCE_AUDIT_FILE="$(find "$GOV_ROOT" -maxdepth 1 -type f -name "${P_ID}_PRE_EXECUTION_PROCESS_AUDIT_*.md" | sort | tail -n 1)"

[[ -n "$CONTRACT_FILE" && -n "$DISPOSITION_FILE" && -n "$APPROVAL_FILE" && -n "$SOURCE_AUDIT_FILE" ]] || fail "Required P# contract/disposition/approval/audit evidence is missing."

CONTRACT_REL="$(basename "$CONTRACT_FILE")"
DISPOSITION_REL="$(basename "$DISPOSITION_FILE")"
APPROVAL_REL="$(basename "$APPROVAL_FILE")"
SOURCE_AUDIT_REL="$(basename "$SOURCE_AUDIT_FILE")"

for file in "$CONTRACT_REL" "$DISPOSITION_REL" "$APPROVAL_REL" "$SOURCE_AUDIT_REL"; do
  git -C "$GOV_ROOT" cat-file -e "origin/main:$file" 2>/dev/null || fail "$file is not committed on authoritative origin/main."
done

grep -Fxq 'M-01: ACCEPT' "$DISPOSITION_FILE" || fail "M-01 disposition is not ACCEPT."
grep -Fxq 'M-02: ACCEPT' "$DISPOSITION_FILE" || fail "M-02 disposition is not ACCEPT."
grep -Fxq 'M-03: ACCEPT' "$DISPOSITION_FILE" || fail "M-03 disposition is not ACCEPT."
grep -Fxq 'M-04: ACCEPT' "$DISPOSITION_FILE" || fail "M-04 disposition is not ACCEPT."
grep -Fxq 'Decision: APPROVED' "$APPROVAL_FILE" || fail "Approval attestation is not APPROVED."

REVIEW_FILE="${P_ID}_BRAD_DISPOSITION_REVIEW_$(date +%Y-%m-%d_%H%M%S).md"
REVIEW_PATH="$GOV_ROOT/$REVIEW_FILE"

PROMPT=$(cat <<EOF
You are Brad, the Independent Product / Process Reviewer for PRYSM.

This is a bounded preservation review after Chris dispositioned the independent pre-execution audit findings.

Active P#: $P_ID
Governance HEAD being reviewed: $REVIEW_BASE_GOV_SHA

Read first:
1. prysm-project-context/$CONTRACT_REL
2. prysm-project-context/$SOURCE_AUDIT_REL
3. prysm-project-context/$DISPOSITION_REL
4. prysm-project-context/$APPROVAL_REL
5. prysm-project-context/CURRENT_STATE.md
6. prysm-project-context/PRYSM_OUTCOME_GATED_P_REVIEW_PROTOCOL_2026-09-04.md
7. prysm-project-context/PRYSM_P_STAGE_COMMIT_AUDIT_GATE_2026-09-04.md

Your task is NOT to diagnose application code and NOT to decide implementation details.

Judge only whether:
- all four audit findings were substantively dispositioned rather than relabeled;
- M-03/M-04 amendments still prove the original P1 client/business outcome;
- the amendments avoid unnecessary scope expansion beyond material P1 paths;
- the MVP/no-rework balance is reasonable: enough proof to prevent foreseeable rework, without turning P1 into a whole-application redesign;
- the amended contract still preserves evidence integrity and point-of-reading clarity;
- another material outcome requirement is not missing.

Do NOT edit the contract, dispositions, approval evidence, application code, or any other file.
Do NOT diagnose, test, build, deploy, create a branch, or begin P2.

You MAY create exactly one file:
prysm-project-context/$REVIEW_FILE

The review file must contain these exact metadata lines:
P#: $P_ID
Governance HEAD reviewed: $REVIEW_BASE_GOV_SHA
Outcome Contract: $CONTRACT_REL
Disposition File: $DISPOSITION_REL

Then return these exact review fields:
Original P1 outcome preserved: PASS / FAIL
All four dispositions substantively resolved: PASS / FAIL
MVP scope remains bounded: PASS / FAIL
Foreseeable rework risk materially reduced: PASS / FAIL
Material missing requirement: YES / NO
Material unnecessary scope added: YES / NO
Verdict: PASS / FAIL

If FAIL, identify only the material blocker(s). If PASS, state that the package may proceed to a fresh independent pre-execution process audit, not diagnosis.

Then STOP.
EOF
)

echo
echo "PRYSM $P_ID Brad disposition review ready."
echo "Governance HEAD: $REVIEW_BASE_GOV_SHA"
echo "Review artifact target: $REVIEW_FILE"
echo "Launching Codex as Brad..."
echo

cd "$WORKSPACE_ROOT"
codex "$PROMPT"

[[ -f "$REVIEW_PATH" ]] || fail "Codex exited without creating $REVIEW_FILE."
grep -Fxq "P#: $P_ID" "$REVIEW_PATH" || fail "Review artifact has wrong P#."
grep -Fxq "Governance HEAD reviewed: $REVIEW_BASE_GOV_SHA" "$REVIEW_PATH" || fail "Review artifact lacks exact governance HEAD."
grep -Fxq "Outcome Contract: $CONTRACT_REL" "$REVIEW_PATH" || fail "Review artifact lacks exact contract."
grep -Fxq "Disposition File: $DISPOSITION_REL" "$REVIEW_PATH" || fail "Review artifact lacks exact disposition file."
grep -Eq '^Verdict: (PASS|FAIL)$' "$REVIEW_PATH" || fail "Review artifact lacks exact PASS/FAIL verdict."

STATUS_OUTPUT="$(git -C "$GOV_ROOT" status --porcelain)"
[[ -n "$STATUS_OUTPUT" ]] || fail "No governance change exists after review."
CHANGED_COUNT="$(printf '%s\n' "$STATUS_OUTPUT" | sed '/^$/d' | wc -l | tr -d ' ')"
[[ "$CHANGED_COUNT" == "1" ]] || fail "Codex changed $CHANGED_COUNT files; exactly one review artifact is allowed. Nothing was committed."
CHANGED_PATH="$(printf '%s\n' "$STATUS_OUTPUT" | head -n 1 | cut -c4-)"
[[ "$CHANGED_PATH" == "$REVIEW_FILE" ]] || fail "Codex changed '$CHANGED_PATH' instead of only '$REVIEW_FILE'. Nothing was committed."

echo "Rechecking authoritative GitHub state before review commit..."
git -C "$GOV_ROOT" fetch origin main
REMOTE_AFTER_REVIEW="$(git -C "$GOV_ROOT" rev-parse origin/main)"
[[ "$REMOTE_AFTER_REVIEW" == "$REVIEW_BASE_GOV_SHA" ]] || fail "origin/main moved during review. Review remains local and uncommitted because its governance base is stale."

git -C "$GOV_ROOT" add -- "$REVIEW_FILE"
git -C "$GOV_ROOT" commit -m "review: record $P_ID Brad audit-disposition preservation review"
REVIEW_COMMIT="$(git -C "$GOV_ROOT" rev-parse HEAD)"

echo "Pushing Brad review evidence to authoritative governance..."
git -C "$GOV_ROOT" push origin main
git -C "$GOV_ROOT" fetch origin main
[[ "$(git -C "$GOV_ROOT" rev-parse origin/main)" == "$REVIEW_COMMIT" ]] || fail "origin/main does not equal Brad review commit $REVIEW_COMMIT after push."
[[ -z "$(git -C "$GOV_ROOT" status --porcelain)" ]] || fail "Governance tree is not clean after review push."

VERDICT="$(grep -E '^Verdict: (PASS|FAIL)$' "$REVIEW_PATH" | head -n 1 | cut -d' ' -f2)"

echo
echo "PRYSM BRAD REVIEW EVIDENCE PUBLISHED"
echo "P#: $P_ID"
echo "Review file: $REVIEW_FILE"
echo "Review commit: $REVIEW_COMMIT"
echo "Verdict: $VERDICT"
if [[ "$VERDICT" == "PASS" ]]; then
  echo "Next gate: rerun independent pre-execution process audit."
else
  echo "STOP: disposition package requires repair before another audit."
fi
