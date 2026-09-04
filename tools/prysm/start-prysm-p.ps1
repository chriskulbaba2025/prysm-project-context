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

$codexCommand = Get-Command codex -ErrorAction Stop
$codexDir = Split-Path -Parent $codexCommand.Source

Write-Host "PRYSM PowerShell launcher"
Write-Host "P#: $WorkstreamId"
Write-Host "Governance: $govRoot"
Write-Host "Codex bin: $codexDir"
Write-Host

$originalPath = $env:PATH
$originalLocation = Get-Location
try {
  $env:PATH = "$codexDir;$originalPath"
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
