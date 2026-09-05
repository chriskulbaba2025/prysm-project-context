param(
    [Parameter(Mandatory = $true)]
    [ValidatePattern('^P[0-9]+$')]
    [string]$P,

    [string]$AppRepo,
    [string]$GovernanceRepo
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
$GateRegression = Join-Path $ScriptRoot 'test-prysm-gate-contract.sh'
$CurrentSessionGate = Join-Path $ScriptRoot 'start-prysm-p-current-session.sh'

Write-Host "PRYSM $P AUTORUN BOOTSTRAP"
Write-Host "Governance: $GovernanceRepo"
Write-Host "Application: $AppRepo"

Write-Host "`n[1/4] Controller self-test"
& powershell.exe -NoProfile -ExecutionPolicy Bypass -File $Controller -P $P -SelfTest
if ($LASTEXITCODE -ne 0) { throw 'P# autorun controller self-test failed.' }

Write-Host "`n[2/4] PRYSM gate-contract regression"
& bash $GateRegression
if ($LASTEXITCODE -ne 0) { throw 'PRYSM gate-contract regression failed. Autorun did not start.' }

Write-Host "`n[3/4] Deterministic stage authority"
$appDirty = (& git -C $AppRepo status --porcelain)
if ([string]::IsNullOrWhiteSpace(($appDirty -join "`n"))) {
    Write-Host 'Application tree is clean. Running the official deterministic P# gate in current-session/no-nested-Codex mode.'
    Push-Location $GovernanceRepo
    try {
        & bash $CurrentSessionGate $P
        if ($LASTEXITCODE -ne 0) { throw 'Deterministic PRYSM P# gate failed. Autorun did not start.' }
    }
    finally {
        Pop-Location
    }
}
else {
    Write-Host 'Application tree is dirty. Treating this as an in-progress governed Builder continuation.'
    Write-Host 'The deterministic gate is NOT rerun because the current authorized repair created the dirty state after gate PASS.'
    Write-Host 'The P-scoped controller preflight will require the exact authorized P# branch/stage and preserve the dirty worktree.'
}

Write-Host "`n[4/4] P# controller preflight"
& powershell.exe -NoProfile -ExecutionPolicy Bypass -File $Controller -P $P -AppRepo $AppRepo -GovernanceRepo $GovernanceRepo -PreflightOnly
if ($LASTEXITCODE -ne 0) { throw 'P# autorun preflight failed. Autorun did not start.' }

Write-Host "`nStarting continuous governed Builder loop."
& powershell.exe -NoProfile -ExecutionPolicy Bypass -File $Controller -P $P -AppRepo $AppRepo -GovernanceRepo $GovernanceRepo
exit $LASTEXITCODE
