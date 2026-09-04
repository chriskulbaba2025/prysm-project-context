param(
  [Parameter(Mandatory = $true, Position = 0)]
  [ValidatePattern('^P([1-9]|10)([A-Z][A-Z0-9-]*)?$')]
  [string]$WorkstreamId
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

function Fail([string]$Message) {
  Write-Error "PRYSM POWERSHELL LAUNCH FAIL: $Message"
  exit 1
}

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$govRoot = (Resolve-Path (Join-Path $scriptDir '..\..')).Path
$baseLauncher = Join-Path $scriptDir 'start-prysm-p.sh'

if (-not (Test-Path $baseLauncher)) {
  Fail "Governed Bash launcher is missing: $baseLauncher"
}

$bash = 'C:\Program Files\Git\bin\bash.exe'
if (-not (Test-Path $bash)) {
  $bashCommand = Get-Command bash.exe -ErrorAction SilentlyContinue
  if ($null -eq $bashCommand) {
    Fail 'Git for Windows Bash was not found.'
  }
  $bash = $bashCommand.Source
}

$codexCommand = Get-Command codex -ErrorAction SilentlyContinue
if ($null -eq $codexCommand) {
  Fail 'Codex CLI is not installed or not visible to PowerShell.'
}

$codexDir = Split-Path -Parent $codexCommand.Source
if (-not (Test-Path (Join-Path $codexDir 'codex.cmd'))) {
  Fail "PowerShell found Codex at '$($codexCommand.Source)', but codex.cmd is missing from '$codexDir'."
}

# Pass exact Windows locations into Git Bash. The Bash child does not have to
# infer HOME, APPDATA, npm prefix, or inherited PATH semantics.
$env:PRYSM_GOV_ROOT_WIN = $govRoot
$env:PRYSM_CODEX_BIN_WIN = $codexDir

$bashCommandText = @'
set -euo pipefail
GOV_ROOT="$(cygpath -u "$PRYSM_GOV_ROOT_WIN")"
CODEX_DIR="$(cygpath -u "$PRYSM_CODEX_BIN_WIN")"
export PATH="$CODEX_DIR:$PATH"
cd "$GOV_ROOT"
command -v codex >/dev/null 2>&1 || {
  echo "PRYSM POWERSHELL LAUNCH FAIL: Codex was found by PowerShell but is not executable from Git Bash after deterministic PATH binding." >&2
  exit 1
}
exec bash tools/prysm/start-prysm-p.sh "$1"
'@

Write-Host "PRYSM PowerShell launcher"
Write-Host "P#: $WorkstreamId"
Write-Host "Governance: $govRoot"
Write-Host "Codex bin: $codexDir"
Write-Host

& $bash -c $bashCommandText -- $WorkstreamId
$exitCode = $LASTEXITCODE

if ($exitCode -ne 0) {
  exit $exitCode
}
