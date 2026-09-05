#!/usr/bin/env bash
set -euo pipefail

# Exact governance baseline at which the audited reopened-P1 history was frozen.
# All historical root P1_* evidence and proof/P1/rendered/* that existed here
# are immutable. New reopened proof belongs under proof/P1/reopen/.
P1_FROZEN_BASELINE="0756e4db3746be0c2279c2083ccf83b3ec5c89f5"

# Disposable regression fixtures cannot contain the production commit object.
# A baseline override is accepted only under the explicit gate-contract test
# marker; normal Chris/Brad/Codex execution cannot select a weaker baseline.
if [[ "${PRYSM_GATE_CONTRACT_TEST:-0}" == "1" ]]; then
  [[ -n "${PRYSM_P1_FROZEN_BASELINE:-}" ]] || {
    echo "PRYSM P1 FROZEN HISTORY FAIL: test baseline override is missing" >&2
    exit 1
  }
  P1_FROZEN_BASELINE="$PRYSM_P1_FROZEN_BASELINE"
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GOV_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

fail() {
  echo "PRYSM P1 FROZEN HISTORY FAIL: $1" >&2
  exit 1
}

[[ -d "$GOV_ROOT/.git" ]] || fail "governance repository not found at $GOV_ROOT"
git -C "$GOV_ROOT" cat-file -e "${P1_FROZEN_BASELINE}^{commit}" 2>/dev/null || fail "frozen baseline commit is unavailable: $P1_FROZEN_BASELINE"
HEAD_SHA="$(git -C "$GOV_ROOT" rev-parse HEAD)"
git -C "$GOV_ROOT" merge-base --is-ancestor "$P1_FROZEN_BASELINE" "$HEAD_SHA" || fail "current governance HEAD is outside the frozen P1 lineage"

mapfile -t FROZEN_PATHS < <(
  git -C "$GOV_ROOT" ls-tree -r --name-only "$P1_FROZEN_BASELINE" \
    | grep -E '^(P1_[^/]*|proof/P1/rendered/.+)$' \
    | grep -v '^P1_EXECUTION_GATE\.env$' \
    | sort -u
)

[[ ${#FROZEN_PATHS[@]} -gt 0 ]] || fail "baseline produced no frozen P1 evidence paths"

for path in "${FROZEN_PATHS[@]}"; do
  baseline_blob="$(git -C "$GOV_ROOT" rev-parse "${P1_FROZEN_BASELINE}:${path}")"
  current_blob="$(git -C "$GOV_ROOT" rev-parse "HEAD:${path}" 2>/dev/null || true)"
  [[ -n "$current_blob" ]] || fail "historical P1 evidence was deleted: $path"
  [[ "$baseline_blob" == "$current_blob" ]] || fail "historical P1 evidence changed in current tree: $path"

  # Content equality alone is not enough: changing then reverting a historical
  # evidence file would still leave a misleading governance breadcrumb.
  if git -C "$GOV_ROOT" log --format='%H' "${P1_FROZEN_BASELINE}..HEAD" -- "$path" | grep -q .; then
    fail "historical P1 evidence was touched after freeze baseline: $path"
  fi
done

# Do not permit new root P1_* evidence to bypass the frozen set. The execution
# gate is intentionally mutable; all new repair evidence/proof is versioned
# beneath proof/P1/reopen/.
mapfile -t ROOT_P1_NOW < <(git -C "$GOV_ROOT" ls-tree --name-only HEAD | grep '^P1_' | sort -u || true)
mapfile -t ROOT_P1_BASE < <(git -C "$GOV_ROOT" ls-tree --name-only "$P1_FROZEN_BASELINE" | grep '^P1_' | sort -u || true)
for path in "${ROOT_P1_NOW[@]}"; do
  [[ "$path" == "P1_EXECUTION_GATE.env" ]] && continue
  if ! printf '%s\n' "${ROOT_P1_BASE[@]}" | grep -Fxq "$path"; then
    fail "new root P1 evidence is not allowed; place reopened proof under proof/P1/reopen/: $path"
  fi
done

echo "PRYSM P1 FROZEN HISTORY PASS"
echo "Baseline: $P1_FROZEN_BASELINE"
echo "Frozen paths verified: ${#FROZEN_PATHS[@]}"
