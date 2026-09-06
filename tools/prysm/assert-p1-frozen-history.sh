#!/usr/bin/env bash
set -euo pipefail

# Exact governance baseline at which the audited reopened-P1 history was frozen.
# All historical root P1_* evidence and proof/P1/rendered/* that existed here
# are immutable. New reopened proof belongs under proof/P1/reopen/.
P1_FROZEN_BASELINE="0756e4db3746be0c2279c2083ccf83b3ec5c89f5"

# Brad's second independent reopened-candidate outcome review was intentionally
# created after the original exhaustive baseline. It is now supplemental frozen
# history: immutable at its exact creation commit and not a precedent for new
# root P1_* evidence.
P1_SUPPLEMENTAL_FROZEN_PATH="P1_BRAD_OUTCOME_REVIEW_REOPEN_2026-09-05.md"
P1_SUPPLEMENTAL_FROZEN_COMMIT="d73c57be0a15291855fc771326d6b181ff281c54"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GOV_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

fail() {
  echo "PRYSM P1 FROZEN HISTORY FAIL: $1" >&2
  exit 1
}

# Disposable gate-contract fixtures cannot contain the production commit
# object. A baseline override is accepted only when BOTH the explicit test
# marker is present and this script is physically inside the disposable
# prysm-gate-contract.* fixture tree created by the regression suite. Merely
# setting environment variables in the real governance repo cannot weaken the
# production baseline.
PRODUCTION_FREEZE=1
if [[ "${PRYSM_GATE_CONTRACT_TEST:-0}" == "1" ]]; then
  case "$GOV_ROOT" in
    */prysm-gate-contract.*/*/prysm-project-context) ;;
    *) fail "test baseline override refused outside disposable gate-contract fixture: $GOV_ROOT" ;;
  esac
  [[ -n "${PRYSM_P1_FROZEN_BASELINE:-}" ]] || fail "test baseline override is missing"
  P1_FROZEN_BASELINE="$PRYSM_P1_FROZEN_BASELINE"
  PRODUCTION_FREEZE=0
fi

[[ -d "$GOV_ROOT/.git" ]] || fail "governance repository not found at $GOV_ROOT"
git -C "$GOV_ROOT" cat-file -e "${P1_FROZEN_BASELINE}^{commit}" 2>/dev/null || fail "frozen baseline commit is unavailable: $P1_FROZEN_BASELINE"
HEAD_SHA="$(git -C "$GOV_ROOT" rev-parse HEAD)"
git -C "$GOV_ROOT" merge-base --is-ancestor "$P1_FROZEN_BASELINE" "$HEAD_SHA" || fail "current governance HEAD is outside the frozen P1 lineage"

# Bash 3.2 compatibility: macOS ships Bash 3.2, which does not provide
# `mapfile`. Load indexed arrays explicitly with read loops instead.
FROZEN_PATHS=()
frozen_count=0
while IFS= read -r path; do
  [[ -n "$path" ]] || continue
  FROZEN_PATHS[$frozen_count]="$path"
  frozen_count=$((frozen_count + 1))
done < <(
  git -C "$GOV_ROOT" ls-tree -r --name-only "$P1_FROZEN_BASELINE" \
    | grep -E '^(P1_[^/]*|proof/P1/rendered/.+)$' \
    | grep -v '^P1_EXECUTION_GATE\.env$' \
    | sort -u
)

[[ "$frozen_count" -gt 0 ]] || fail "baseline produced no frozen P1 evidence paths"

for path in "${FROZEN_PATHS[@]}"; do
  baseline_blob="$(git -C "$GOV_ROOT" rev-parse "${P1_FROZEN_BASELINE}:${path}")"
  current_blob="$(git -C "$GOV_ROOT" rev-parse "HEAD:${path}" 2>/dev/null || true)"
  [[ -n "$current_blob" ]] || fail "historical P1 evidence was deleted: $path"
  [[ "$baseline_blob" == "$current_blob" ]] || fail "historical P1 evidence changed in current tree: $path"

  # Builder-time safety: an uncommitted edit is a violation too. This makes the
  # same guard useful before governance commits, not only at final clean gates.
  if [[ -n "$(git -C "$GOV_ROOT" status --porcelain=v1 --untracked-files=all -- "$path")" ]]; then
    fail "historical P1 evidence has an uncommitted change: $path"
  fi

  # Content equality alone is not enough: changing then reverting a historical
  # evidence file would still leave a misleading governance breadcrumb.
  if git -C "$GOV_ROOT" log --format='%H' "${P1_FROZEN_BASELINE}..HEAD" -- "$path" | grep -q .; then
    fail "historical P1 evidence was touched after freeze baseline: $path"
  fi
done

# Preserve the later Brad reopened-candidate FAIL exactly as committed. This
# extends the immutable set narrowly without moving or weakening the original
# exhaustive freeze baseline.
if [[ "$PRODUCTION_FREEZE" == "1" ]]; then
  git -C "$GOV_ROOT" cat-file -e "${P1_SUPPLEMENTAL_FROZEN_COMMIT}^{commit}" 2>/dev/null || fail "supplemental frozen commit is unavailable: $P1_SUPPLEMENTAL_FROZEN_COMMIT"
  git -C "$GOV_ROOT" merge-base --is-ancestor "$P1_SUPPLEMENTAL_FROZEN_COMMIT" "$HEAD_SHA" || fail "current governance HEAD is outside the supplemental frozen review lineage"
  supplemental_blob="$(git -C "$GOV_ROOT" rev-parse "${P1_SUPPLEMENTAL_FROZEN_COMMIT}:${P1_SUPPLEMENTAL_FROZEN_PATH}" 2>/dev/null || true)"
  current_supplemental_blob="$(git -C "$GOV_ROOT" rev-parse "HEAD:${P1_SUPPLEMENTAL_FROZEN_PATH}" 2>/dev/null || true)"
  [[ -n "$supplemental_blob" && -n "$current_supplemental_blob" ]] || fail "supplemental frozen Brad review is missing: $P1_SUPPLEMENTAL_FROZEN_PATH"
  [[ "$supplemental_blob" == "$current_supplemental_blob" ]] || fail "supplemental frozen Brad review changed: $P1_SUPPLEMENTAL_FROZEN_PATH"
  if [[ -n "$(git -C "$GOV_ROOT" status --porcelain=v1 --untracked-files=all -- "$P1_SUPPLEMENTAL_FROZEN_PATH")" ]]; then
    fail "supplemental frozen Brad review has an uncommitted change: $P1_SUPPLEMENTAL_FROZEN_PATH"
  fi
  if git -C "$GOV_ROOT" log --format='%H' "${P1_SUPPLEMENTAL_FROZEN_COMMIT}..HEAD" -- "$P1_SUPPLEMENTAL_FROZEN_PATH" | grep -q .; then
    fail "supplemental frozen Brad review was touched after its binding commit: $P1_SUPPLEMENTAL_FROZEN_PATH"
  fi
fi

# Do not permit new root P1_* evidence to bypass the frozen set. The execution
# gate is intentionally mutable; all new repair evidence/proof is versioned
# beneath proof/P1/reopen/. The one supplemental Brad review above is allowed
# only because it is separately pinned and verified immutable.
ROOT_P1_NOW=()
root_now_count=0
while IFS= read -r path; do
  [[ -n "$path" ]] || continue
  ROOT_P1_NOW[$root_now_count]="$path"
  root_now_count=$((root_now_count + 1))
done < <(git -C "$GOV_ROOT" ls-tree --name-only HEAD | grep '^P1_' | sort -u || true)

ROOT_P1_BASE=()
root_base_count=0
while IFS= read -r path; do
  [[ -n "$path" ]] || continue
  ROOT_P1_BASE[$root_base_count]="$path"
  root_base_count=$((root_base_count + 1))
done < <(git -C "$GOV_ROOT" ls-tree --name-only "$P1_FROZEN_BASELINE" | grep '^P1_' | sort -u || true)

root_path_is_baseline() {
  local needle="$1"
  local candidate
  for candidate in "${ROOT_P1_BASE[@]}"; do
    [[ "$candidate" == "$needle" ]] && return 0
  done
  return 1
}

for path in "${ROOT_P1_NOW[@]}"; do
  [[ "$path" == "P1_EXECUTION_GATE.env" ]] && continue
  if [[ "$PRODUCTION_FREEZE" == "1" && "$path" == "$P1_SUPPLEMENTAL_FROZEN_PATH" ]]; then
    continue
  fi
  if ! root_path_is_baseline "$path"; then
    fail "new root P1 evidence is not allowed; place reopened proof under proof/P1/reopen/: $path"
  fi
done

# Catch a newly created root P1_* path before it is committed.
while IFS= read -r line; do
  [[ -n "$line" ]] || continue
  path="${line:3}"
  if [[ "$path" == P1_* && "$path" != "P1_EXECUTION_GATE.env" ]]; then
    if [[ "$PRODUCTION_FREEZE" == "1" && "$path" == "$P1_SUPPLEMENTAL_FROZEN_PATH" ]]; then
      fail "supplemental frozen Brad review has an uncommitted change: $path"
    fi
    if ! root_path_is_baseline "$path"; then
      fail "new uncommitted root P1 evidence is not allowed; place reopened proof under proof/P1/reopen/: $path"
    fi
  fi
done < <(git -C "$GOV_ROOT" status --porcelain=v1 --untracked-files=all)

echo "PRYSM P1 FROZEN HISTORY PASS"
echo "Baseline: $P1_FROZEN_BASELINE"
echo "Frozen baseline paths verified: $frozen_count"
if [[ "$PRODUCTION_FREEZE" == "1" ]]; then
  echo "Supplemental frozen review verified: $P1_SUPPLEMENTAL_FROZEN_PATH @ $P1_SUPPLEMENTAL_FROZEN_COMMIT"
fi
