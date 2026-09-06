param(
    [switch]$AuditOnly
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$GovRoot = (Resolve-Path (Join-Path $ScriptRoot '..\..')).Path
$GatePath = Join-Path $GovRoot 'P1_EXECUTION_GATE.env'
$Contract = Join-Path $ScriptRoot 'test-prysm-p1-r2-windows-contract.ps1'
$Runner = Join-Path $ScriptRoot 'START-PRYSM-P1-R2-AUTORUN.ps1'

foreach ($path in @($GatePath,$Contract,$Runner)) {
    if (-not (Test-Path -LiteralPath $path)) { throw "Missing governed R2 entrypoint dependency: $path" }
}

function Read-Gate {
    $values = @{}
    foreach ($line in Get-Content -LiteralPath $GatePath) {
        if ([string]::IsNullOrWhiteSpace($line) -or $line.TrimStart().StartsWith('#')) { continue }
        $idx = $line.IndexOf('=')
        if ($idx -gt 0) { $values[$line.Substring(0,$idx).Trim()] = $line.Substring($idx + 1).Trim() }
    }
    return $values
}

function Require-GateValue([hashtable]$Gate,[string]$Key,[string]$Expected) {
    if (-not $Gate.ContainsKey($Key)) { throw "P1 execution gate is missing required R2 field: $Key" }
    if ([string]$Gate[$Key] -ne $Expected) { throw "P1 execution gate R2 mismatch for $Key. Expected '$Expected', found '$($Gate[$Key])'." }
}

function Verify-BoundFile([hashtable]$Gate,[string]$FileKey,[string]$CommitKey) {
    $file = [string]$Gate[$FileKey]
    $commit = [string]$Gate[$CommitKey]
    if ([string]::IsNullOrWhiteSpace($file) -or [string]::IsNullOrWhiteSpace($commit)) { throw "Missing R2 binding: $FileKey / $CommitKey" }
    & git -C $GovRoot cat-file -e "$commit^{commit}" 2>$null
    if ($LASTEXITCODE -ne 0) { throw "$CommitKey does not resolve to a governance commit: $commit" }
    & git -C $GovRoot cat-file -e "${commit}:$file" 2>$null
    if ($LASTEXITCODE -ne 0) { throw "$file was not present at bound commit $commit" }
    & git -C $GovRoot cat-file -e "HEAD:$file" 2>$null
    if ($LASTEXITCODE -ne 0) { throw "$file is missing from current governance HEAD" }
    $boundBlob = (& git -C $GovRoot rev-parse "${commit}:$file").Trim()
    $headBlob = (& git -C $GovRoot rev-parse "HEAD:$file").Trim()
    if ($boundBlob -ne $headBlob) { throw "$file changed after its bound R2 commit. Pull the current authoritative state; do not run." }
}

$gate = Read-Gate
Require-GateValue $gate 'P_ID' 'P1'
Require-GateValue $gate 'AUTHORIZED_STAGE' 'BOUNDED_BUILD'
Require-GateValue $gate 'R2_EXECUTION_AUTH_FILE' 'proof/P1/reopen/P1_BOUNDED_REPAIR_AUTHORIZATION_R2_V2_2026-09-06.md'
Require-GateValue $gate 'R2_WINDOWS_ENTRY' 'tools/prysm/START-PRYSM-P1-R2.ps1'
Require-GateValue $gate 'R2_WINDOWS_RUNNER' 'tools/prysm/START-PRYSM-P1-R2-AUTORUN.ps1'
Require-GateValue $gate 'R2_WINDOWS_CONTRACT' 'tools/prysm/test-prysm-p1-r2-windows-contract.ps1'
Require-GateValue $gate 'R2_LOCAL_STATE_NAMESPACE' 'PRYSM-P-Autorun/P1-R2'
Require-GateValue $gate 'R2_INITIAL_REPAIR_ATTEMPT' '1'
Require-GateValue $gate 'R2_STABLE_ROOT' 'P1-CROSS-REPORT-PROJECTION-RECONCILIATION'

Verify-BoundFile $gate 'R2_EXECUTION_AUTH_FILE' 'R2_EXECUTION_AUTH_COMMIT'
Verify-BoundFile $gate 'R2_WINDOWS_ENTRY' 'R2_WINDOWS_ENTRY_COMMIT'
Verify-BoundFile $gate 'R2_WINDOWS_RUNNER' 'R2_WINDOWS_RUNNER_COMMIT'
Verify-BoundFile $gate 'R2_WINDOWS_CONTRACT' 'R2_WINDOWS_CONTRACT_COMMIT'

Write-Host 'PRYSM P1 R2 WINDOWS BOOTSTRAP'
Write-Host "Mode: $(if ($AuditOnly) { 'AUDIT ONLY' } else { 'CONTINUOUS BUILDER TO BRAD' })"
Write-Host 'Gate binding: PASS'

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
