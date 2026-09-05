param(
  [Parameter(Mandatory = $true, Position = 0)]
  [ValidatePattern('^P([1-9]|10)([A-Z][A-Z0-9-]*)?$')]
  [string]$WorkstreamId
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$govRoot = (Resolve-Path (Join-Path $scriptDir '..\..')).Path
$bash = 'C:\Program Files\Git\bin\bash.exe'

if (-not (Test-Path $bash)) {
  throw 'Git for Windows Bash was not found.'
}

# Codex is needed only for Builder-owned stages. Do not make a Chris/Brad
# handoff fail merely because Codex is unavailable in the PowerShell PATH.
$codexCommand = Get-Command codex -ErrorAction SilentlyContinue
$codexDir = $null
if ($null -ne $codexCommand) {
  $codexSource = $codexCommand.Source
  if ([string]::IsNullOrWhiteSpace($codexSource)) {
    $codexSource = $codexCommand.Path
  }
  if (-not [string]::IsNullOrWhiteSpace($codexSource)) {
    $codexDir = Split-Path -Parent $codexSource
  }
}

Write-Host "PRYSM PowerShell launcher"
Write-Host "P#: $WorkstreamId"
Write-Host "Governance: $govRoot"
if ($null -ne $codexDir) {
  Write-Host "Codex bin: $codexDir"
}
else {
  Write-Host "Codex bin: not pre-required; Builder stages will validate Codex only if needed"
}
Write-Host

$originalPath = $env:PATH
$originalLocation = Get-Location
try {
  if ($null -ne $codexDir) {
    $env:PATH = "$codexDir;$originalPath"
  }
  Set-Location $govRoot
  & $bash 'tools/prysm/start-prysm-p.sh' $WorkstreamId
  $exitCode = $LASTEXITCODE
}
finally {
  $env:PATH = $originalPath
  Set-Location $originalLocation
}

if ($exitCode -ne 0) {
  exit $exitCode
}
