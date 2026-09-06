param(
    [switch]$AuditOnly
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$RootDefectId = 'P1-CROSS-REPORT-PROJECTION-RECONCILIATION'
$RepairAttempt = 1
$ExpectedApplicationSha = '8fa9ea9db76e2db5e8fa11ebc6a0a7fd56eb6e1c'
$BadProofRoot = 'services/worker/proof/P1/reopen/render-v2-r2-20260906'
$AllowedRootProofPrefix = 'proof/P1/reopen/'

$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$GovernanceRepo = (Resolve-Path (Join-Path $ScriptRoot '..\..')).Path
$WorkspaceRoot = Split-Path -Parent $GovernanceRepo
$AppRepo = Join-Path $WorkspaceRoot 'vantage-platform'
$LocalBase = if ($env:LOCALAPPDATA) { $env:LOCALAPPDATA } else { $env:TEMP }
$StateRoot = Join-Path $LocalBase 'PRYSM-P-Autorun\P1-R2'
$JournalPath = Join-Path $StateRoot 'transaction-journal.json'

$AllowedSourcePaths = @(
    'services/worker/src/report-model/cross-report-interpretation.js',
    'services/worker/src/report-model/cross-report-interpretation.test.js',
    'services/worker/src/report/foundation-readiness.js',
    'services/worker/src/report/report-detail-sections.js',
    'services/worker/src/report/v2-pillars.js',
    'services/worker/src/report/render-report-v2.js',
    'services/worker/src/report/render-report-v2-conversion.test.js',
    'services/worker/src/report/render-report-v2.test.js',
    'services/worker/src/report/render-report-v2-sections.test.js'
)

function Fail([string]$Message) {
    throw "PRYSM P1 R2 MISLOCATED PROOF RECOVERY FAIL: $Message"
}

function Get-GitHead([string]$Repo) { return ((& git -C $Repo rev-parse HEAD).Trim()) }
function Get-GitBranch([string]$Repo) { return ((& git -C $Repo branch --show-current).Trim()) }

function Get-StatusEntries([string]$Repo) {
    $entries = @()
    foreach ($line in (& git -C $Repo status --porcelain=v1 --untracked-files=all)) {
        if ([string]::IsNullOrWhiteSpace($line)) { continue }
        $path = $line.Substring(3)
        if ($path -match ' -> ') { $path = ($path -split ' -> ')[-1] }
        $normalized = $path -replace '\\','/'
        $entries += [pscustomobject]@{ Code=$line.Substring(0,2); Path=$normalized }
    }
    return @($entries)
}

function Get-RepoFingerprint([string]$Repo) {
    $head = Get-GitHead $Repo
    $branch = Get-GitBranch $Repo
    $status = ((& git -C $Repo status --porcelain=v1 --untracked-files=all) -join "`n")
    $old = $ErrorActionPreference
    try {
        $ErrorActionPreference = 'Continue'
        $tracked = (& git -C $Repo diff --binary HEAD 2>$null | Out-String)
        $trackedExit = $LASTEXITCODE
        $staged = (& git -C $Repo diff --cached --binary HEAD 2>$null | Out-String)
        $stagedExit = $LASTEXITCODE
    } finally { $ErrorActionPreference = $old }
    if ($trackedExit -ne 0 -or $stagedExit -ne 0) { Fail 'Git diff failed while fingerprinting application.' }

    $untracked = @()
    foreach ($path in (& git -C $Repo ls-files --others --exclude-standard)) {
        if ([string]::IsNullOrWhiteSpace($path)) { continue }
        $full = Join-Path $Repo $path
        $hash = if (Test-Path -LiteralPath $full -PathType Leaf) { (Get-FileHash -Algorithm SHA256 -LiteralPath $full).Hash.ToLowerInvariant() } else { 'MISSING' }
        $untracked += "$path=$hash"
    }
    $payload = "branch=$branch`nhead=$head`nstatus=$status`ntracked=$tracked`nstaged=$staged`nuntracked=$($untracked -join "`n")"
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($payload)
    $sha = [System.Security.Cryptography.SHA256]::Create()
    try { $hashBytes = $sha.ComputeHash($bytes) } finally { $sha.Dispose() }
    return (($hashBytes | ForEach-Object { $_.ToString('x2') }) -join '')
}

function Write-JsonAtomic([string]$Path,$Value) {
    $temp = "$Path.tmp.$PID"
    try {
        $Value | ConvertTo-Json -Depth 16 | Set-Content -LiteralPath $temp -Encoding UTF8
        Move-Item -LiteralPath $temp -Destination $Path -Force
    } finally { Remove-Item -LiteralPath $temp -Force -ErrorAction SilentlyContinue }
}

if (-not (Test-Path -LiteralPath $AppRepo)) { Fail "Application repo missing: $AppRepo" }
if (-not (Test-Path -LiteralPath $JournalPath)) { Fail "Recovery journal missing: $JournalPath" }

try { $journal = Get-Content -LiteralPath $JournalPath -Raw | ConvertFrom-Json }
catch { Fail 'Recovery journal is corrupt.' }

if (-not (($journal.PSObject.Properties.Name -contains 'recovery') -and [bool]$journal.recovery)) { Fail 'Journal is not a recovery transaction.' }
if ([string]$journal.status -ne 'CODEX_EXITED_UNRECONCILED') { Fail "Expected CODEX_EXITED_UNRECONCILED, found $($journal.status)." }
if ([int]$journal.exitCode -ne 0) { Fail "Recovery Codex exit code was $($journal.exitCode), not 0." }
if ([int]$journal.repairAttempt -ne $RepairAttempt) { Fail 'Repair attempt is not 1.' }
if ([string]$journal.rootDefectId -ne $RootDefectId) { Fail 'Stable root changed.' }
if ((Get-GitBranch $AppRepo) -ne 'p1/bounded-build-cross-report-integrity') { Fail 'Application branch changed.' }
if ((Get-GitHead $AppRepo) -ne $ExpectedApplicationSha) { Fail 'Application HEAD changed; placement recovery is not authorized.' }

$finalPath = Join-Path ([string]$journal.runDirectory) 'final.json'
if (-not (Test-Path -LiteralPath $finalPath)) { Fail 'Recovery final.json is missing.' }
try { $result = Get-Content -LiteralPath $finalPath -Raw | ConvertFrom-Json }
catch { Fail 'Recovery final.json is invalid.' }
if ([int]$result.repair_attempt -ne 1) { Fail 'Result repair_attempt drifted.' }
if ([string]$result.root_defect_id -ne $RootDefectId) { Fail 'Result root_defect_id drifted.' }
if ([int]$result.material_defects -ne 0) { Fail 'Result reports material defects; automatic placement recovery is not allowed.' }
if ([string]$result.failure_class -notin @('NONE','PROOF_SETUP_FAILURE')) { Fail "Unsupported result failure class: $($result.failure_class)" }

$entries = @(Get-StatusEntries $AppRepo)
$badEntries = @($entries | Where-Object { $_.Path -eq $BadProofRoot -or $_.Path.StartsWith("$BadProofRoot/") })
if ($badEntries.Count -eq 0) { Fail "No mislocated proof exists under $BadProofRoot." }

foreach ($entry in $entries) {
    if ($AllowedSourcePaths -contains $entry.Path) { continue }
    if ($entry.Path.StartsWith($AllowedRootProofPrefix)) { continue }
    if ($entry.Path -eq $BadProofRoot -or $entry.Path.StartsWith("$BadProofRoot/")) { continue }
    Fail "Unexpected dirty path outside placement recovery: $($entry.Path)"
}

foreach ($entry in $badEntries) {
    if ($entry.Code -ne '??') { Fail "Mislocated proof is not purely untracked generated output: $($entry.Code) $($entry.Path)" }
}

$trackedBad = @(& git -C $AppRepo ls-files -- $BadProofRoot)
if ($trackedBad.Count -ne 0) { Fail "Tracked files exist under mislocated proof root: $($trackedBad -join ', ')" }

$badFull = $AppRepo
foreach ($segment in ($BadProofRoot -split '/')) { $badFull = Join-Path $badFull $segment }
if (-not (Test-Path -LiteralPath $badFull -PathType Container)) { Fail "Mislocated proof directory missing: $badFull" }

$files = @(Get-ChildItem -LiteralPath $badFull -Recurse -File)
if ($files.Count -eq 0) { Fail 'Mislocated proof directory contains no files.' }

$manifest = @()
foreach ($file in $files) {
    $relative = $file.FullName.Substring($badFull.Length).TrimStart([char[]]@('\','/'))
    $relative = $relative -replace '\\','/'
    $manifest += [ordered]@{ path=$relative; sha256=(Get-FileHash -Algorithm SHA256 -LiteralPath $file.FullName).Hash.ToLowerInvariant(); length=$file.Length }
}

Write-Host 'PRYSM P1 R2 MISLOCATED PROOF RECOVERY'
Write-Host "Mislocated proof root: $BadProofRoot"
Write-Host "Generated files: $($files.Count)"
Write-Host 'Attribution and untracked-only checks: PASS'

if ($AuditOnly) {
    Write-Host 'PRYSM P1 R2 MISLOCATED PROOF RECOVERY AUDIT PASS'
    Write-Host 'No application file was changed.'
    exit 0
}

$stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$quarantineBase = Join-Path $StateRoot 'quarantine'
$quarantineRoot = Join-Path $quarantineBase "run2-mislocated-proof-$stamp"
$quarantineFiles = Join-Path $quarantineRoot 'files'
New-Item -ItemType Directory -Force -Path $quarantineFiles | Out-Null
Copy-Item -LiteralPath $badFull -Destination $quarantineFiles -Recurse -Force
$manifestPath = Join-Path $quarantineRoot 'manifest.json'
Write-JsonAtomic $manifestPath ([ordered]@{
    sourceRepo=$AppRepo;sourcePath=$BadProofRoot;quarantinedAt=(Get-Date -Format o);
    repairAttempt=1;rootDefectId=$RootDefectId;files=$manifest
})

$preCleanupFingerprint = Get-RepoFingerprint $AppRepo
Remove-Item -LiteralPath $badFull -Recurse -Force
if (Test-Path -LiteralPath $badFull) { Fail 'Mislocated proof directory still exists after quarantine cleanup.' }

$remaining = @(Get-StatusEntries $AppRepo)
foreach ($entry in $remaining) {
    if ($AllowedSourcePaths -contains $entry.Path) { continue }
    if ($entry.Path.StartsWith($AllowedRootProofPrefix)) { continue }
    Fail "Unexpected dirty path remains after placement recovery: $($entry.Path)"
}

$postCleanupFingerprint = Get-RepoFingerprint $AppRepo
$journal | Add-Member -NotePropertyName prePlacementRecoveryFingerprint -NotePropertyValue $preCleanupFingerprint -Force
$journal | Add-Member -NotePropertyName postApplicationFingerprint -NotePropertyValue $postCleanupFingerprint -Force
$journal | Add-Member -NotePropertyName placementRecovery -NotePropertyValue ([ordered]@{
    status='QUARANTINED_AND_REMOVED';sourcePath=$BadProofRoot;quarantinePath=$quarantineRoot;manifestPath=$manifestPath;completedAt=(Get-Date -Format o)
}) -Force
Write-JsonAtomic $JournalPath $journal

Write-Host "Quarantine: $quarantineRoot"
Write-Host 'PRYSM P1 R2 MISLOCATED PROOF RECOVERY PASS'
Write-Host 'Mislocated generated proof was preserved outside the repo and removed from the application worktree.'
