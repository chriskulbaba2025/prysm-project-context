#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GOV_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

fail() {
  echo >&2
  echo "PRYSM PRE-FLIGHT FAIL: $1" >&2
  exit 1
}

resolve_diag_root() {
  if [[ -n "${PRYSM_DIAGNOSTIC_DIR:-}" ]]; then
    printf '%s' "$PRYSM_DIAGNOSTIC_DIR"
    return 0
  fi

  if [[ -n "${TEMP:-}" ]]; then
    if command -v cygpath >/dev/null 2>&1; then
      printf '%s' "$(cygpath -u "$TEMP" 2>/dev/null || printf '%s' "$TEMP")/PRYSM-diagnostics"
    else
      printf '%s' "$TEMP/PRYSM-diagnostics"
    fi
    return 0
  fi

  if [[ -n "${TMPDIR:-}" ]]; then
    printf '%s' "${TMPDIR%/}/PRYSM-diagnostics"
    return 0
  fi

  printf '%s' "/tmp/PRYSM-diagnostics"
}

DIAG_ROOT="$(resolve_diag_root)"
mkdir -p "$DIAG_ROOT"

# Preserve, do not delete, narrowly recognized local diagnostic leftovers that
# predate the repository ignore rule. Tracked files and unknown untracked files
# are never moved automatically.
quarantine_if_local_diag() {
  local path="$1"
  local rel="${path#$GOV_ROOT/}"
  local stamp dest

  [[ -e "$path" ]] || return 0

  if git -C "$GOV_ROOT" ls-files --error-unmatch -- "$rel" >/dev/null 2>&1; then
    return 0
  fi

  stamp="$(date +%Y%m%d-%H%M%S)"
  dest="$DIAG_ROOT/quarantine-$stamp-${rel//\//_}"
  mv -- "$path" "$dest"
  echo "PRYSM PRE-FLIGHT: preserved local diagnostic outside governance repo: $dest"
}

for path in \
  "$GOV_ROOT"/PRYSM-P*-governance-dirty*.txt \
  "$GOV_ROOT"/PRYSM-LOCAL-DIAG-*.txt \
  "$GOV_ROOT"/PRYSM-GATE-DEBUG-*.txt
do
  [[ -e "$path" ]] || continue
  quarantine_if_local_diag "$path"
done

DIRTY_STATUS="$(git -C "$GOV_ROOT" status --porcelain=v1 --untracked-files=all)"
if [[ -n "$DIRTY_STATUS" ]]; then
  echo >&2
  echo "PRYSM GOVERNANCE DIRTY ENTRIES:" >&2
  printf '%s\n' "$DIRTY_STATUS" >&2
  fail "Governance repository has real uncommitted changes. Only the exact entries above must be reconciled."
fi
