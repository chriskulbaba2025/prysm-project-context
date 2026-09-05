param(
    [Parameter(Mandatory = $true)]
    [ValidatePattern('^P[0-9]+$')]
    [string]$P,

    [string]$AppRepo,
    [string]$GovernanceRepo,
    [switch]$AuditOnly
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
if ([string]::IsNullOrWhiteSpace($GovernanceRepo)) {
    $GovernanceRepo = (Resolve-Path (Join-Path $ScriptRoot '..\..')).Path
}
if ([string]::IsNullOrWhiteSpace($AppRepo)) {
    $parent = Split-Path -Parent $GovernanceRepo
    $AppRepo = Join-Path $parent 'vantage-platform'
}

$Controller = Join-Path $ScriptRoot 'PRYSM-P-AUTORUN.ps1'
$AutorunRegression = Join-Path $ScriptRoot 'test-prysm-p-autorun-contract.ps1'
$GateRegression = Join-Path $ScriptRoot 'test-prysm-gate-contract.sh'
$ProtectedBootstrapFiles = @(
    'tools/prysm/PRYSM-P-AUTORUN.ps1',
    'tools/prysm/START-PRYSM-P-AUTORUN.ps1',
    'tools/prysm/PRYSM-P-BUILDER-AUTORUN-PROMPT.md',
    'tools/prysm/test-prysm-p-autorun-contract.ps1',
    'tools/autorun/PRYSM-AUTORUN-RESULT.schema.json'
)

$gitBash = 'C:\Program Files\Git\bin\bash.exe'
if (Test-Path -LiteralPath $gitBash) {
    $Bash = $gitBash
} else {
    $bashCmd = Get-Command bash -ErrorAction SilentlyContinue
    if (-not $bashCmd -or -not $bashCmd.Source) { throw 'Git Bash was not found.' }
    $Bash = $bashCmd.Source
}

Write-Host "PRYSM $P AUTORUN BOOTSTRAP"
Write-Host "Governance: $GovernanceRepo"
Write-Host "Application: $AppRepo"
Write-Host "Mode: $(if ($AuditOnly) { 'AUDIT ONLY - NO CODEX/PRODUCT EXECUTION' } else { 'CONTINUOUS BUILDER' })"

Write-Host "`n[1/5] Verify bootstrap/control-plane integrity"
if ((& git -C $GovernanceRepo branch --show-current).Trim() -ne 'main') {
    throw 'Governance repository must remain on main.'
}
foreach ($path in $ProtectedBootstrapFiles) {
    & git -C $GovernanceRepo diff --quiet HEAD -- $path
    if ($LASTEXITCODE -ne 0) { throw "Protected autorun file has uncommitted changes: $path" }
}
& git -C $GovernanceRepo fetch origin main
if ($LASTEXITCODE -ne 0) { throw 'Governance fetch origin/main failed.' }
$local = (& git -C $GovernanceRepo rev-parse HEAD).Trim()
$remote = (& git -C $GovernanceRepo rev-parse origin/main).Trim()
$status = ((& git -C $GovernanceRepo status --porcelain=v1 --untracked-files=all) -join "`n")
if ([string]::IsNullOrWhiteSpace($status)) {
    & git -C $GovernanceRepo merge-base --is-ancestor $local $remote *> $null
    if ($LASTEXITCODE -eq 0 -and $local -ne $remote) {
        & git -C $GovernanceRepo pull --ff-only origin main
        if ($LASTEXITCODE -ne 0) { throw 'Clean governance fast-forward failed.' }
    }
} else {
    Write-Host 'Governance contains local in-progress state. Bootstrap will not pull/reset it; controller recovery will verify lineage.'
}

Write-Host "`n[2/5] P# autorun contract regression"
& powershell.exe -NoProfile -ExecutionPolicy Bypass -File $AutorunRegression -P $P
if ($LASTEXITCODE -ne 0) { throw 'P# autorun contract regression failed. Autorun did not start.' }

Write-Host "`n[3/5] Permanent PRYSM gate-contract regression"
& $Bash $GateRegression
if ($LASTEXITCODE -ne 0) { throw 'PRYSM gate-contract regression failed. Autorun did not start.' }

Write-Host "`n[4/5] P# transaction/recovery preflight"
& powershell.exe -NoProfile -ExecutionPolicy Bypass -File $Controller -P $P -AppRepo $AppRepo -GovernanceRepo $GovernanceRepo -PreflightOnly
if ($LASTEXITCODE -ne 0) { throw 'P# autorun preflight failed. Autorun did not start.' }

if ($AuditOnly) {
    Write-Host "`n[5/5] AUDIT-ONLY TERMINAL"
    Write-Host 'PRYSM P# AUTORUN AUDIT PASS'
    Write-Host 'No Codex Builder invocation was started. No application/product execution occurred.'
    exit 0
}

Write-Host "`n[5/5] Start continuous governed Builder loop"
& powershell.exe -NoProfile -ExecutionPolicy Bypass -File $Controller -P $P -AppRepo $AppRepo -GovernanceRepo $GovernanceRepo
exit $LASTEXITCODE
