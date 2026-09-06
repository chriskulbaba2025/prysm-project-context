param(
    [switch]$AuditOnly
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$RootDefectId = 'P1-CROSS-REPORT-PROJECTION-RECONCILIATION'
$RepairAttempt = 1
$ApplicationBranch = 'p1/bounded-build-cross-report-integrity'
$OriginalApplicationSha = '8fa9ea9db76e2db5e8fa11ebc6a0a7fd56eb6e1c'
$Run2ApplicationSha = '8d2b38e4d8abd959d412b72028e9934dba8ae185'
$BadProofRoot = 'services/worker/proof/P1/reopen/render-v2-r2-20260906'
$GoodProofRoot = 'proof/P1/reopen/render-v2-r2-20260906'

$ExpectedRun2SourcePaths = @(
    'services/worker/src/report/foundation-readiness.js',
    'services/worker/src/report/render-report-v2-conversion.test.js',
    'services/worker/src/report/render-report-v2.js',
    'services/worker/src/report/report-detail-sections.js',
    'services/worker/src/report/v2-pillars.js'
)

$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$GovernanceRepo = (Resolve-Path (Join-Path $ScriptRoot '..\..')).Path
$WorkspaceRoot = Split-Path -Parent $GovernanceRepo
$AppRepo = Join-Path $WorkspaceRoot 'vantage-platform'
$GatePath = Join-Path $GovernanceRepo 'P1_EXECUTION_GATE.env'
$LocalBase = if ($env:LOCALAPPDATA) { $env:LOCALAPPDATA } else { $env:TEMP }
$StateRoot = Join-Path $LocalBase 'PRYSM-P-Autorun\P1-R2'
$JournalPath = Join-Path $StateRoot 'transaction-journal.json'

function Fail([string]$Message) {
    throw "PRYSM P1 R2 TRACKED PROOF RELOCATION FAIL: $Message"
}

function Invoke-NativeExitCode([scriptblock]$Command,[switch]$Quiet) {
    $old = $ErrorActionPreference
    $exitCode = 1
    try {
        $ErrorActionPreference = 'Continue'
        if ($Quiet) { & $Command *> $null } else { & $Command }
        $exitCode = $LASTEXITCODE
    } finally {
        $ErrorActionPreference = $old
    }
    return $exitCode
}

function Get-GitHead([string]$Repo) { return ((& git -C $Repo rev-parse HEAD).Trim()) }
function Get-GitBranch([string]$Repo) { return ((& git -C $Repo branch --show-current).Trim()) }
function Get-GitStatus([string]$Repo) { return ((& git -C $Repo status --porcelain=v1 --untracked-files=all) -join "`n") }

function Convert-RepoPathToLocal([string]$Repo,[string]$RepoPath) {
    $full = $Repo
    foreach ($segment in ($RepoPath -split '/')) {
        $full = Join-Path $full $segment
    }
    return $full
}

function Write-JsonAtomic([string]$Path,$Value) {
    $temp = "$Path.tmp.$PID"
    try {
        $Value | ConvertTo-Json -Depth 16 | Set-Content -LiteralPath $temp -Encoding UTF8
        Move-Item -LiteralPath $temp -Destination $Path -Force
    } finally {
        Remove-Item -LiteralPath $temp -Force -ErrorAction SilentlyContinue
    }
}

function Assert-CleanSyncedPreflight {
    if ((Get-GitBranch $AppRepo) -ne $ApplicationBranch) { Fail "Application branch is not $ApplicationBranch." }
    if (-not [string]::IsNullOrWhiteSpace((Get-GitStatus $AppRepo))) { Fail 'Application worktree is not clean before tracked proof relocation.' }
    if ((Get-GitBranch $GovernanceRepo) -ne 'main') { Fail 'Governance repository is not on main.' }
    if (-not [string]::IsNullOrWhiteSpace((Get-GitStatus $GovernanceRepo))) { Fail 'Governance repository is not clean before tracked proof relocation.' }

    $appFetch = Invoke-NativeExitCode -Command { & git -C $AppRepo fetch origin $ApplicationBranch } -Quiet
    if ($appFetch -ne 0) { Fail 'Application fetch failed.' }
    $govFetch = Invoke-NativeExitCode -Command { & git -C $GovernanceRepo fetch origin main } -Quiet
    if ($govFetch -ne 0) { Fail 'Governance fetch failed.' }

    $appHead = Get-GitHead $AppRepo
    $appRemote = (& git -C $AppRepo rev-parse "origin/$ApplicationBranch").Trim()
    $govHead = Get-GitHead $GovernanceRepo
    $govRemote = (& git -C $GovernanceRepo rev-parse origin/main).Trim()

    if ($appHead -ne $Run2ApplicationSha -or $appRemote -ne $Run2ApplicationSha) {
        Fail "Application Run 2 checkpoint mismatch. Local=$appHead remote=$appRemote expected=$Run2ApplicationSha"
    }
    if ($govHead -ne $govRemote) { Fail 'Governance HEAD is not synchronized with origin/main.' }
}

function Assert-Run2LineageAndScope {
    $parent = (& git -C $AppRepo rev-parse "$Run2ApplicationSha^1").Trim()
    if ($parent -ne $OriginalApplicationSha) { Fail "Run 2 parent is $parent, expected $OriginalApplicationSha." }

    $changed = @()
    foreach ($path in (& git -C $AppRepo diff --name-only "$OriginalApplicationSha..$Run2ApplicationSha")) {
        if (-not [string]::IsNullOrWhiteSpace($path)) { $changed += $path.Replace('\','/') }
    }
    $changed = @($changed | Sort-Object -Unique)

    $actualSource = @($changed | Where-Object { $ExpectedRun2SourcePaths -contains $_ } | Sort-Object -Unique)
    $missingSource = @($ExpectedRun2SourcePaths | Where-Object { $actualSource -notcontains $_ })
    if ($missingSource.Count -ne 0) { Fail "Run 2 is missing expected authorized source paths: $($missingSource -join ', ')" }

    $badProofCount = 0
    foreach ($path in $changed) {
        if ($ExpectedRun2SourcePaths -contains $path) { continue }
        if ($path -eq $BadProofRoot -or $path.StartsWith("$BadProofRoot/")) {
            $badProofCount++
            continue
        }
        Fail "Run 2 contains an unexpected changed path: $path"
    }
    if ($badProofCount -lt 1) { Fail 'Run 2 does not contain the diagnosed misplaced generated proof.' }

    $trackedBad = @(& git -C $AppRepo ls-tree -r --name-only $Run2ApplicationSha -- $BadProofRoot)
    if ($trackedBad.Count -lt 1) { Fail 'Misplaced Run 2 proof is not tracked in the pushed Run 2 commit.' }

    $trackedGood = @(& git -C $AppRepo ls-tree -r --name-only $Run2ApplicationSha -- $GoodProofRoot)
    if ($trackedGood.Count -ne 0) { Fail 'Governed root target already exists in Run 2; automatic relocation is not allowed.' }

    $badFull = Convert-RepoPathToLocal $AppRepo $BadProofRoot
    $goodFull = Convert-RepoPathToLocal $AppRepo $GoodProofRoot
    if (-not (Test-Path -LiteralPath $badFull -PathType Container)) { Fail "Tracked misplaced proof directory is missing locally: $badFull" }
    if (Test-Path -LiteralPath $goodFull) { Fail "Governed proof target already exists locally: $goodFull" }
}

function Assert-Journal {
    if (-not (Test-Path -LiteralPath $JournalPath)) { Fail "R2 journal missing: $JournalPath" }
    try { $journal = Get-Content -LiteralPath $JournalPath -Raw | ConvertFrom-Json }
    catch { Fail 'R2 journal is corrupt.' }

    if (-not (($journal.PSObject.Properties.Name -contains 'recovery') -and [bool]$journal.recovery)) { Fail 'Journal is not the R2 recovery transaction.' }
    if ([string]$journal.status -ne 'CODEX_EXITED_UNRECONCILED') { Fail "Expected CODEX_EXITED_UNRECONCILED journal, found $($journal.status)." }
    if ([int]$journal.exitCode -ne 0) { Fail "Run 2 Codex exit code was $($journal.exitCode), not 0." }
    if ([int]$journal.repairAttempt -ne $RepairAttempt) { Fail 'Journal repair attempt is not 1.' }
    if ([string]$journal.rootDefectId -ne $RootDefectId) { Fail 'Journal stable root changed.' }
    if ([string]$journal.postApplicationSha -ne $Run2ApplicationSha) { Fail "Journal post-application SHA is $($journal.postApplicationSha), expected $Run2ApplicationSha." }

    $finalPath = Join-Path ([string]$journal.runDirectory) 'final.json'
    if (-not (Test-Path -LiteralPath $finalPath)) { Fail 'Run 2 final.json is missing.' }
    try { $result = Get-Content -LiteralPath $finalPath -Raw | ConvertFrom-Json }
    catch { Fail 'Run 2 final.json is invalid.' }
    if ([int]$result.repair_attempt -ne 1) { Fail 'Run 2 result repair_attempt drifted.' }
    if ([string]$result.root_defect_id -ne $RootDefectId) { Fail 'Run 2 result root_defect_id drifted.' }
    if ([int]$result.material_defects -ne 0) { Fail 'Run 2 reports material defects; automatic relocation is not allowed.' }
    if ([string]$result.failure_class -notin @('NONE','PROOF_SETUP_FAILURE')) { Fail "Run 2 failure class is not recoverable here: $($result.failure_class)" }

    return $journal
}

function Assert-OnlyRelocationStaged {
    $lines = @(& git -C $AppRepo diff --cached --name-status --find-renames)
    if ($lines.Count -lt 1) { Fail 'git mv produced no staged relocation.' }

    foreach ($line in $lines) {
        if ([string]::IsNullOrWhiteSpace($line)) { continue }
        $parts = $line -split "`t"
        if ($parts.Count -ge 3 -and $parts[0] -match '^[RC]') {
            $oldPath = $parts[1].Replace('\','/')
            $newPath = $parts[2].Replace('\','/')
            if (-not ($oldPath -eq $BadProofRoot -or $oldPath.StartsWith("$BadProofRoot/"))) { Fail "Unexpected relocation source: $oldPath" }
            if (-not ($newPath -eq $GoodProofRoot -or $newPath.StartsWith("$GoodProofRoot/"))) { Fail "Unexpected relocation target: $newPath" }
            continue
        }

        if ($parts.Count -lt 2) { Fail "Could not parse staged relocation entry: $line" }
        $path = $parts[-1].Replace('\','/')
        if ($path -eq $BadProofRoot -or $path.StartsWith("$BadProofRoot/")) { continue }
        if ($path -eq $GoodProofRoot -or $path.StartsWith("$GoodProofRoot/")) { continue }
        Fail "Unexpected staged path during proof relocation: $path"
    }

    & git -C $AppRepo diff --quiet
    if ($LASTEXITCODE -ne 0) { Fail 'Unstaged application changes appeared during proof relocation.' }
    $untracked = @(& git -C $AppRepo ls-files --others --exclude-standard)
    if ($untracked.Count -ne 0) { Fail "Untracked application files appeared during proof relocation: $($untracked -join ', ')" }
}

function Update-GovernanceGate([string]$NewApplicationSha) {
    $raw = Get-Content -LiteralPath $GatePath -Raw
    $appCount = ([regex]::Matches($raw,'(?m)^APPLICATION_SHA=.*$')).Count
    $candidateCount = ([regex]::Matches($raw,'(?m)^CANDIDATE_APPLICATION_SHA=.*$')).Count
    if ($appCount -ne 1 -or $candidateCount -ne 1) { Fail 'Gate does not contain exactly one APPLICATION_SHA and one CANDIDATE_APPLICATION_SHA.' }

    $updated = [regex]::Replace($raw,'(?m)^APPLICATION_SHA=.*$',"APPLICATION_SHA=$NewApplicationSha")
    $updated = [regex]::Replace($updated,'(?m)^CANDIDATE_APPLICATION_SHA=.*$',"CANDIDATE_APPLICATION_SHA=$NewApplicationSha")
    if ($updated -eq $raw) { Fail 'Gate SHA binding did not change.' }

    $utf8NoBom = New-Object -TypeName System.Text.UTF8Encoding -ArgumentList $false
    [System.IO.File]::WriteAllText($GatePath,$updated,$utf8NoBom)

    $govStatus = @(& git -C $GovernanceRepo status --porcelain=v1 --untracked-files=all)
    if ($govStatus.Count -ne 1 -or $govStatus[0].Substring(3).Replace('\','/') -ne 'P1_EXECUTION_GATE.env') {
        Fail "Governance changed outside P1_EXECUTION_GATE.env: $($govStatus -join '; ')"
    }
}

if (-not (Test-Path -LiteralPath $AppRepo)) { Fail "Application repository missing: $AppRepo" }
if (-not (Test-Path -LiteralPath $GatePath)) { Fail "P1 execution gate missing: $GatePath" }

Write-Host 'PRYSM P1 R2 TRACKED PROOF RELOCATION RECOVERY'
Write-Host "Application: $AppRepo"
Write-Host "Run 2 checkpoint: $Run2ApplicationSha"
Write-Host "Relocation: $BadProofRoot -> $GoodProofRoot"

Assert-CleanSyncedPreflight
Assert-Run2LineageAndScope
$journal = Assert-Journal

Write-Host 'Run 2 lineage and authorized-path audit: PASS'
Write-Host 'Tracked proof placement diagnosis: PASS'

if ($AuditOnly) {
    Write-Host 'PRYSM P1 R2 TRACKED PROOF RELOCATION AUDIT PASS'
    Write-Host 'No application or governance file was changed.'
    exit 0
}

$goodFull = Convert-RepoPathToLocal $AppRepo $GoodProofRoot
$goodParent = Split-Path -Parent $goodFull
if (-not (Test-Path -LiteralPath $goodParent -PathType Container)) { Fail "Governed proof parent is missing: $goodParent" }

$moveExit = Invoke-NativeExitCode -Command { & git -C $AppRepo mv -- $BadProofRoot $GoodProofRoot } -Quiet
if ($moveExit -ne 0) { Fail 'git mv failed while relocating tracked proof.' }
Assert-OnlyRelocationStaged

$commitExit = Invoke-NativeExitCode -Command { & git -C $AppRepo commit -m 'fix(p1): relocate R2 rendered proof to governed root' } -Quiet
if ($commitExit -ne 0) { Fail 'Application relocation commit failed.' }
$newApplicationSha = Get-GitHead $AppRepo

$pushExit = Invoke-NativeExitCode -Command { & git -C $AppRepo push origin $ApplicationBranch } -Quiet
if ($pushExit -ne 0) { Fail 'Application relocation push failed.' }
$fetchExit = Invoke-NativeExitCode -Command { & git -C $AppRepo fetch origin $ApplicationBranch } -Quiet
if ($fetchExit -ne 0) { Fail 'Application verification fetch failed.' }
if ((& git -C $AppRepo rev-parse "origin/$ApplicationBranch").Trim() -ne $newApplicationSha) { Fail 'Application origin did not reach the relocation checkpoint.' }
if (-not [string]::IsNullOrWhiteSpace((Get-GitStatus $AppRepo))) { Fail 'Application is not clean after relocation commit.' }

Update-GovernanceGate $newApplicationSha
& git -C $GovernanceRepo add -- P1_EXECUTION_GATE.env
if ($LASTEXITCODE -ne 0) { Fail 'Could not stage P1 execution gate update.' }
$govCommitExit = Invoke-NativeExitCode -Command { & git -C $GovernanceRepo commit -m 'P1: bind relocated R2 application checkpoint' } -Quiet
if ($govCommitExit -ne 0) { Fail 'Governance gate commit failed.' }
$newGovernanceSha = Get-GitHead $GovernanceRepo
$govPushExit = Invoke-NativeExitCode -Command { & git -C $GovernanceRepo push origin main } -Quiet
if ($govPushExit -ne 0) { Fail 'Governance gate push failed.' }
$govFetchExit = Invoke-NativeExitCode -Command { & git -C $GovernanceRepo fetch origin main } -Quiet
if ($govFetchExit -ne 0) { Fail 'Governance verification fetch failed.' }
if ((& git -C $GovernanceRepo rev-parse origin/main).Trim() -ne $newGovernanceSha) { Fail 'Governance origin did not reach the relocation checkpoint.' }
if (-not [string]::IsNullOrWhiteSpace((Get-GitStatus $GovernanceRepo))) { Fail 'Governance is not clean after relocation gate commit.' }

$journal | Add-Member -NotePropertyName status -NotePropertyValue 'RECONCILED' -Force
$journal | Add-Member -NotePropertyName checkpoint -NotePropertyValue 'RUN2_TRACKED_PROOF_RELOCATED' -Force
$journal | Add-Member -NotePropertyName reconciledAt -NotePropertyValue (Get-Date -Format o) -Force
$journal | Add-Member -NotePropertyName applicationSha -NotePropertyValue $newApplicationSha -Force
$journal | Add-Member -NotePropertyName governanceSha -NotePropertyValue $newGovernanceSha -Force
$journal | Add-Member -NotePropertyName placementRecovery -NotePropertyValue ([ordered]@{
    status='RELOCATED_TO_GOVERNED_ROOT';
    from=$BadProofRoot;
    to=$GoodProofRoot;
    run2Sha=$Run2ApplicationSha;
    applicationSha=$newApplicationSha;
    governanceSha=$newGovernanceSha;
    repairAttempt=1;
    completedAt=(Get-Date -Format o)
}) -Force
Write-JsonAtomic $JournalPath $journal

Write-Host "Application checkpoint: $newApplicationSha"
Write-Host "Governance checkpoint: $newGovernanceSha"
Write-Host 'PRYSM P1 R2 TRACKED PROOF RELOCATION PASS'
Write-Host 'Clean synchronized Builder checkpoint restored. Standard R2 runner may continue at repair attempt 1.'
