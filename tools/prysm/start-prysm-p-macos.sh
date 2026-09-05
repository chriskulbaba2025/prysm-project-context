#!/usr/bin/env bash
set -euo pipefail

fail() {
  echo >&2
  echo "PRYSM MACOS ADAPTER FAIL: $1" >&2
  exit 1
}

[[ "$(uname -s)" == "Darwin" ]] || fail "This adapter is only certified for macOS (Darwin)."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_ENTRY="$SCRIPT_DIR/start-prysm-p.sh"
[[ -f "$BASE_ENTRY" ]] || fail "Governed PRYSM launcher is missing: $BASE_ENTRY"

# macOS npm installs expose global executables from <npm-prefix>/bin.
# Add only known executable locations; do not install or mutate tooling here.
add_path_if_dir() {
  local dir="$1"
  [[ -n "$dir" && -d "$dir" ]] || return 0
  case ":$PATH:" in
    *":$dir:"*) ;;
    *) PATH="$dir:$PATH" ;;
  esac
}

add_path_if_dir "/opt/homebrew/bin"
add_path_if_dir "/usr/local/bin"
add_path_if_dir "$HOME/.local/bin"
add_path_if_dir "$HOME/.npm-global/bin"

if command -v npm >/dev/null 2>&1; then
  npm_prefix="$(npm config get prefix 2>/dev/null || true)"
  if [[ -n "$npm_prefix" && "$npm_prefix" != "undefined" ]]; then
    add_path_if_dir "$npm_prefix/bin"
  fi
fi

export PATH

# Do not require Codex for Brad/Chris-owned stages. The shared deterministic
# launcher will require it only when a Builder-owned stage is actually reached.
exec bash "$BASE_ENTRY" "$@"
