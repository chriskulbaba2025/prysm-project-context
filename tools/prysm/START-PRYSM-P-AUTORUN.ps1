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
$AutorunRegression = Join-Path $ScriptRoot 'test-prysm-p-autorun-contract.ps1'
$GateRegression = Join-Path $ScriptRoot 'test-prysm-gate-contract.sh'

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

Write-Host "`n[1/5] Synchronize authoritative governance"
if (-not [string]::IsNullOrWhiteSpace(((& git -C $GovernanceRepo status --porcelain=v1 --untracked-files=all) -join "`n"))) {
    throw 'Governance repository is dirty. Autorun will not pull over uncommitted governance work.'
}
& git -C $GovernanceRepo pull --ff-only origin main
if ($LASTEXITCODE -ne 0) { throw 'Governance pull --ff-only failed.' }
if (-not [string]::IsNullOrWhiteSpace(((& git -C $GovernanceRepo status --porcelain=v1 --untracked-files=all) -join "`n"))) {
    throw 'Governance repository is not clean after synchronization.'
}

Write-Host "`n[2/5] P# autorun contract regression"
& powershell.exe -NoProfile -ExecutionPolicy Bypass -File $AutorunRegression -P $P
if ($LASTEXITCODE -ne 0) { throw 'P# autorun contract regression failed. Autorun did not start.' }

Write-Host "`n[3/5] Permanent PRYSM gate-contract regression"
& $Bash $GateRegression
if ($LASTEXITCODE -ne 0) { throw 'PRYSM gate-contract regression failed. Autorun did not start.' }

Write-Host "`n[4/5] P# recovery/preflight verification"
& powershell.exe -NoProfile -ExecutionPolicy Bypass -File $Controller -P $P -AppRepo $AppRepo -GovernanceRepo $GovernanceRepo -PreflightOnly
if ($LASTEXITCODE -ne 0) { throw 'P# autorun preflight failed. Autorun did not start.' }

Write-Host "`n[5/5] Start continuous governed Builder loop"
& powershell.exe -NoProfile -ExecutionPolicy Bypass -File $Controller -P $P -AppRepo $AppRepo -GovernanceRepo $GovernanceRepo
exit $LASTEXITCODE
