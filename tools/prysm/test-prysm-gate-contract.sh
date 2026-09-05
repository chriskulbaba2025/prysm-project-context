#!/usr/bin/env bash
set -euo pipefail

# Permanent regression test for PRYSM gate authority/routing.
# Uses disposable repositories only. It never touches the real governance or app repos.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_LAUNCHER="$SCRIPT_DIR/start-prysm-p-base.sh"
PUBLIC_LAUNCHER="$SCRIPT_DIR/start-prysm-p.sh"
CURRENT_SESSION_LAUNCHER="$SCRIPT_DIR/start-prysm-p-current-session.sh"
PREFLIGHT="$SCRIPT_DIR/prysm-governance-preflight.sh"
TEST_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/prysm-gate-contract.XXXXXX")"
trap 'rm -rf "$TEST_ROOT"' EXIT

pass=0
fail_count=0
ok() { echo "PASS: $1"; pass=$((pass + 1)); }
bad() { echo "FAIL: $1"; fail_count=$((fail_count + 1)); }

setup_fixture() {
  local name="$1"
  local stage="$2"
  local root="$TEST_ROOT/$name"
  mkdir -p "$root"

  git init --bare "$root/gov-remote.git" >/dev/null 2>&1
  git init --bare "$root/app-remote.git" >/dev/null 2>&1
  git clone "$root/gov-remote.git" "$root/prysm-project-context" >/dev/null 2>&1
  git clone "$root/app-remote.git" "$root/vantage-platform" >/dev/null 2>&1

  git -C "$root/prysm-project-context" config user.email prysm-test@example.invalid
  git -C "$root/prysm-project-context" config user.name PRYSM-Test
  git -C "$root/vantage-platform" config user.email prysm-test@example.invalid
  git -C "$root/vantage-platform" config user.name PRYSM-Test

  git -C "$root/vantage-platform" checkout -b p1/bounded-build-cross-report-integrity >/dev/null 2>&1
  echo app > "$root/vantage-platform/app.txt"
  git -C "$root/vantage-platform" add .
  git -C "$root/vantage-platform" commit -m app >/dev/null
  local app_sha
  app_sha="$(git -C "$root/vantage-platform" rev-parse HEAD)"
  git -C "$root/vantage-platform" push -u origin p1/bounded-build-cross-report-integrity >/dev/null 2>&1

  mkdir -p "$root/prysm-project-context/tools/prysm" "$root/prysm-project-context/proof/P1/rendered"
  cp "$BASE_LAUNCHER" "$root/prysm-project-context/tools/prysm/start-prysm-p-base.sh"
  cp "$PUBLIC_LAUNCHER" "$root/prysm-project-context/tools/prysm/start-prysm-p.sh"
  cp "$CURRENT_SESSION_LAUNCHER" "$root/prysm-project-context/tools/prysm/start-prysm-p-current-session.sh"
  cp "$PREFLIGHT" "$root/prysm-project-context/tools/prysm/prysm-governance-preflight.sh"
  chmod +x "$root/prysm-project-context/tools/prysm/"*.sh

  cat > "$root/prysm-project-context/CURRENT_STATE.md" <<STATE
# Current State
- Active P#: P1 — Test
- Current stage: $stage
- Authorized execution stage: $stage
STATE

  echo contract > "$root/prysm-project-context/contract.md"
  printf 'Verdict: PASS\n' > "$root/prysm-project-context/brad.md"
  printf 'Decision: APPROVED\n' > "$root/prysm-project-context/approval.md"
  printf 'Unresolved CRITICAL: 0\nUnresolved MAJOR: 0\nVerdict: PASS\n' > "$root/prysm-project-context/audit.md"
  echo diagnostic > "$root/prysm-project-context/diagnostic.md"
  printf 'Verdict: PASS\nUnresolved CRITICAL: 0\nUnresolved MAJOR: 0\n' > "$root/prysm-project-context/betty.md"
  printf 'Decision: APPROVED\n' > "$root/prysm-project-context/auth.md"
  echo technical > "$root/prysm-project-context/technical.md"
  echo system > "$root/prysm-project-context/system.md"
  echo freeze > "$root/prysm-project-context/freeze.md"
  echo product > "$root/prysm-project-context/product.md"
  echo matrix > "$root/prysm-project-context/matrix.md"
  printf '[{"applicationSha":"%s"}]\n' "$app_sha" > "$root/prysm-project-context/proof/P1/rendered/manifest.json"

  git -C "$root/prysm-project-context" add .
  git -C "$root/prysm-project-context" commit -m evidence >/dev/null
  local evidence_commit
  evidence_commit="$(git -C "$root/prysm-project-context" rev-parse HEAD)"

  cat > "$root/prysm-project-context/P1_EXECUTION_GATE.env" <<GATE
P_ID=P1
AUTHORIZED_STAGE=$stage
APPLICATION_BRANCH=p1/bounded-build-cross-report-integrity
APPLICATION_SHA=$app_sha
CONTRACT_FILE=contract.md
CONTRACT_COMMIT=$evidence_commit
BRAD_REVIEW_FILE=brad.md
BRAD_REVIEW_COMMIT=$evidence_commit
BRAD_VERDICT=PASS
APPROVAL_FILE=approval.md
APPROVAL_COMMIT=$evidence_commit
CHRIS_APPROVAL=APPROVED
PRE_EXECUTION_AUDIT_FILE=audit.md
PRE_EXECUTION_AUDIT_COMMIT=$evidence_commit
PRE_EXECUTION_AUDIT_VERDICT=PASS
DIAGNOSTIC_FILE=diagnostic.md
DIAGNOSTIC_COMMIT=$evidence_commit
DIAGNOSTIC_CLASSIFICATION=VERIFIED_DESIGN_GAP
BETTY_PRE_REPAIR_FILE=betty.md
BETTY_PRE_REPAIR_COMMIT=$evidence_commit
BETTY_PRE_REPAIR_VERDICT=PASS
REPAIR_AUTH_FILE=auth.md
REPAIR_AUTH_COMMIT=$evidence_commit
CHRIS_REPAIR_AUTH=APPROVED
TECHNICAL_PROOF_FILE=technical.md
TECHNICAL_PROOF_COMMIT=$evidence_commit
SYSTEM_PROOF_FILE=system.md
SYSTEM_PROOF_COMMIT=$evidence_commit
CANDIDATE_FREEZE_FILE=freeze.md
CANDIDATE_FREEZE_COMMIT=$evidence_commit
PRODUCT_PROOF_FILE=product.md
PRODUCT_PROOF_COMMIT=$evidence_commit
SCENARIO_MATRIX_FILE=matrix.md
SCENARIO_MATRIX_COMMIT=$evidence_commit
RENDER_MANIFEST_FILE=proof/P1/rendered/manifest.json
RENDER_MANIFEST_COMMIT=$evidence_commit
CANDIDATE_APPLICATION_SHA=$app_sha
GATE

  git -C "$root/prysm-project-context" add P1_EXECUTION_GATE.env
  git -C "$root/prysm-project-context" commit -m gate >/dev/null
  git -C "$root/prysm-project-context" branch -M main
  git -C "$root/prysm-project-context" push -u origin main >/dev/null 2>&1
  git --git-dir="$root/gov-remote.git" symbolic-ref HEAD refs/heads/main

  printf '%s\n' "$root"
}

root="$(setup_fixture valid-outcome OUTCOME_REVIEW)"
if PATH="/usr/bin:/bin" bash "$root/prysm-project-context/tools/prysm/start-prysm-p.sh" P1 >"$root/out" 2>&1 \
  && grep -q 'Authorized actor: BRAD' "$root/out" \
  && grep -q 'Next actor: BRAD' "$root/out"; then
  ok 'OUTCOME_REVIEW passes without Codex and routes only to Brad'
else
  cat "$root/out"; bad 'OUTCOME_REVIEW routing'
fi

root="$(setup_fixture stale-evidence OUTCOME_REVIEW)"
echo changed >> "$root/prysm-project-context/contract.md"
git -C "$root/prysm-project-context" add contract.md
git -C "$root/prysm-project-context" commit -m mutate >/dev/null
git -C "$root/prysm-project-context" push origin main >/dev/null 2>&1
if ! bash "$root/prysm-project-context/tools/prysm/start-prysm-p.sh" P1 >"$root/out" 2>&1 \
  && grep -q 'bound evidence is stale' "$root/out"; then
  ok 'real bound-evidence mutation fails deterministically'
else
  cat "$root/out"; bad 'stale evidence detection'
fi

root="$(setup_fixture missing-render-proof OUTCOME_REVIEW)"
sed -i.bak '/SCENARIO_MATRIX_FILE=/d;/SCENARIO_MATRIX_COMMIT=/d' "$root/prysm-project-context/P1_EXECUTION_GATE.env" && rm -f "$root/prysm-project-context/P1_EXECUTION_GATE.env.bak"
git -C "$root/prysm-project-context" add P1_EXECUTION_GATE.env
git -C "$root/prysm-project-context" commit -m missing-matrix >/dev/null
git -C "$root/prysm-project-context" push origin main >/dev/null 2>&1
if ! bash "$root/prysm-project-context/tools/prysm/start-prysm-p.sh" P1 >"$root/out" 2>&1 \
  && grep -q 'SCENARIO_MATRIX_FILE is missing or empty' "$root/out"; then
  ok 'missing rendered-proof binding fails deterministically'
else
  cat "$root/out"; bad 'rendered-proof binding'
fi

root="$(setup_fixture candidate-mismatch OUTCOME_REVIEW)"
perl -0pi -e 's/^CANDIDATE_APPLICATION_SHA=.*/CANDIDATE_APPLICATION_SHA=0000000000000000000000000000000000000000/m' "$root/prysm-project-context/P1_EXECUTION_GATE.env"
git -C "$root/prysm-project-context" add P1_EXECUTION_GATE.env
git -C "$root/prysm-project-context" commit -m bad-candidate >/dev/null
git -C "$root/prysm-project-context" push origin main >/dev/null 2>&1
if ! bash "$root/prysm-project-context/tools/prysm/start-prysm-p.sh" P1 >"$root/out" 2>&1 \
  && grep -q 'CANDIDATE_APPLICATION_SHA does not equal APPLICATION_SHA' "$root/out"; then
  ok 'candidate identity mismatch fails deterministically'
else
  cat "$root/out"; bad 'candidate identity binding'
fi

root="$(setup_fixture builder-stage DIAGNOSTIC_TRUTH)"
mkdir -p "$root/fakebin"
cat > "$root/fakebin/codex" <<'CODEX'
#!/usr/bin/env bash
printf '%s\n' "$1"
CODEX
chmod +x "$root/fakebin/codex"
if CODEX_THREAD_ID=test PATH="$root/fakebin:/usr/bin:/bin" bash "$root/prysm-project-context/tools/prysm/start-prysm-p.sh" P1 >"$root/out" 2>&1 \
  && grep -q 'DETERMINISTIC PROCESS GATE: PASS' "$root/out" \
  && ! grep -q 'perform a PROCESS GATE AUDIT' "$root/out" \
  && grep -q 'Authorized actor: BUILDER' "$root/out"; then
  ok 'Builder prompt cannot re-run the process gate'
else
  cat "$root/out"; bad 'Builder single-authority handoff'
fi

root="$(setup_fixture no-codex-outcome OUTCOME_REVIEW)"
if PATH="/usr/bin:/bin" bash "$root/prysm-project-context/tools/prysm/start-prysm-p.sh" P1 >"$root/out" 2>&1; then
  ok 'non-Builder stages do not require Codex CLI'
else
  cat "$root/out"; bad 'stage-scoped Codex requirement'
fi

root="$(setup_fixture diagnostic-quarantine OUTCOME_REVIEW)"
echo local > "$root/prysm-project-context/PRYSM-LOCAL-DIAG-test.txt"
if PRYSM_DIAGNOSTIC_DIR="$root/diag" PATH="/usr/bin:/bin" bash "$root/prysm-project-context/tools/prysm/start-prysm-p.sh" P1 >"$root/out" 2>&1 \
  && grep -q 'preserved local diagnostic outside governance repo' "$root/out" \
  && grep -q 'Next actor: BRAD' "$root/out" \
  && [[ ! -e "$root/prysm-project-context/PRYSM-LOCAL-DIAG-test.txt" ]]; then
  ok 'public preflight quarantines recognized local diagnostics and continues'
else
  cat "$root/out"; bad 'diagnostic quarantine path'
fi

root="$(setup_fixture unknown-dirty OUTCOME_REVIEW)"
echo unknown > "$root/prysm-project-context/UNKNOWN.tmp"
if ! PATH="/usr/bin:/bin" bash "$root/prysm-project-context/tools/prysm/start-prysm-p.sh" P1 >"$root/out" 2>&1 \
  && grep -q 'UNKNOWN.tmp' "$root/out" \
  && grep -q 'PRYSM PRE-FLIGHT FAIL' "$root/out"; then
  ok 'public preflight blocks unknown dirty files and prints exact path'
else
  cat "$root/out"; bad 'unknown dirty-file protection'
fi

echo "PRYSM GATE CONTRACT: $pass PASS / $fail_count FAIL"
[[ "$fail_count" -eq 0 ]]
