param(
    [switch]$AuditOnly
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$Contract = Join-Path $ScriptRoot 'test-prysm-p1-r2-windows-contract.ps1'
$Runner = Join-Path $ScriptRoot 'START-PRYSM-P1-R2-AUTORUN.ps1'

foreach ($path in @($Contract,$Runner)) {
    if (-not (Test-Path -LiteralPath $path)) { throw "Missing governed R2 entrypoint dependency: $path" }
}

Write-Host 'PRYSM P1 R2 WINDOWS BOOTSTRAP'
Write-Host "Mode: $(if ($AuditOnly) { 'AUDIT ONLY' } else { 'CONTINUOUS BUILDER TO BRAD' })"

Write-Host "`n[1/2] R2 Windows controller contract"
& powershell.exe -NoProfile -ExecutionPolicy Bypass -File $Contract
if ($LASTEXITCODE -ne 0) { throw 'R2 Windows controller contract failed. Builder did not start.' }

Write-Host "`n[2/2] R2 runtime"
if ($AuditOnly) {
    & powershell.exe -NoProfile -ExecutionPolicy Bypass -File $Runner -AuditOnly
} else {
    & powershell.exe -NoProfile -ExecutionPolicy Bypass -File $Runner
}
exit $LASTEXITCODE
