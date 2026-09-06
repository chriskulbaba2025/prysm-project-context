param(
    [switch]$AuditOnly,
    [int]$MaxNoProgress = 3
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$P = 'P1'
$RootDefectId = 'P1-CROSS-REPORT-PROJECTION-RECONCILIATION'
$RepairAttempt = 1
$Model = 'gpt-5.6-terra'
$ExpectedApplicationSha = '8fa9ea9db76e2db5e8fa11ebc6a0a7fd56eb6e1c'
$JournalGovernanceSha = '6a65330b0346dd572a59eae06402128533d7bcd2'
$ExpectedInitialDiffSha256 = '6d1db38a328364c6388abe7af63929a2fb2d75340f1ca102daaf9cb055f7ad4f'

$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$GovernanceRepo = (Resolve-Path (Join-Path $ScriptRoot '..\..')).Path
$WorkspaceRoot = Split-Path -Parent $GovernanceRepo
$AppRepo = Join-Path $WorkspaceRoot 'vantage-platform'
$GatePath = Join-Path $GovernanceRepo 'P1_EXECUTION_GATE.env'
$CurrentSessionLauncher = Join-Path $ScriptRoot 'start-prysm-p-current-session.sh'
$FrozenGuard = Join-Path $ScriptRoot 'assert-p1-frozen-history.sh'
$GateRegression = Join-Path $ScriptRoot 'test-prysm-gate-contract.sh'
$BuilderPromptPath = Join-Path $ScriptRoot 'PRYSM-P-BUILDER-AUTORUN-PROMPT.md'
$SchemaPath = Join-Path (Split-Path -Parent $ScriptRoot) 'autorun\PRYSM-AUTORUN-RESULT.schema.json'
$RecoveryEvidencePath = Join-Path $GovernanceRepo 'proof\P1\reopen\P1_R2_RUN1_DIRTY_CHECKPOINT_RECOVERY_2026-09-06.md'

$LocalBase = if ($env:LOCALAPPDATA) { $env:LOCALAPPDATA } else { $env:TEMP }
$StateRoot = Join-Path $LocalBase 'PRYSM-P-Autorun\P1-R2'
$JournalPath = Join-Path $StateRoot 'transaction-journal.json'
$RepairStatePath = Join-Path $StateRoot 'repair-state.json'

$ExpectedInitialDirtyPaths = @(
    'services/worker/src/report/foundation-readiness.js',
    'services/worker/src/report/render-report-v2-conversion.test.js',
    'services/worker/src/report/render-report-v2.js',
    'services/worker/src/report/report-detail-sections.js',
    'services/worker/src/report/v2-pillars.js'
)

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

$AllowedGovernanceRecoveryAdvancePaths = @(
    'CURRENT_STATE.md',
    'P1_EXECUTION_GATE.env',
    'tools/prysm/START-PRYSM-P1-R2.ps1',
    'tools/prysm/test-prysm-p1-r2-windows-contract.ps1',
    'tools/prysm/RESUME-PRYSM-P1-R2-DIRTY.ps1',
    'proof/P1/reopen/P1_R2_RUN1_DIRTY_CHECKPOINT_RECOVERY_2026-09-06.md'
)

$ProtectedControlPlane = @(
    'tools/prysm/START-PRYSM-P1-R2.ps1',
    'tools/prysm/START-PRYSM-P1-R2-AUTORUN.ps1',
    'tools/prysm/RESUME-PRYSM-P1-R2-DIRTY.ps1',
    'tools/prysm/PRYSM-P-BUILDER-AUTORUN-PROMPT.md',
    'tools/prysm/test-prysm-p1-r2-windows-contract.ps1',
    'tools/prysm/test-prysm-gate-contract.sh',
    'tools/prysm/assert-p1-frozen-history.sh',
    'tools/prysm/start-prysm-p-current-session.sh',
    'tools/prysm/start-prysm-p-base.sh',
    'tools/autorun/PRYSM-AUTORUN-RESULT.schema.json',
    'PRYSM_PERMANENT_MEMORY.md'
)

function Fail([string]$Message) {
    throw "PRYSM P1 R2 DIRTY RECOVERY FAIL: $Message"
}

function Notify([string]$Title,[string]$Message) {
    try {
        Add-Type -AssemblyName System.Windows.Forms -ErrorAction Stop
        [System.Media.SystemSounds]::Exclamation.Play()
        [System.Windows.Forms.MessageBox]::Show(
            $Message,
            $Title,
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Warning
        ) | Out-Null
        return
    } catch {}
    try { & msg.exe $env:USERNAME "$Title`n$Message" 2>$null | Out-Null } catch {}
    try { [console]::Beep(880,300) } catch {}
}

function Resolve-Bash {
    $gitBash = 'C:\Program Files\Git\bin\bash.exe'
    if (Test-Path -LiteralPath $gitBash) { return $gitBash }
    $cmd = Get-Command bash -ErrorAction SilentlyContinue
    if ($cmd -and $cmd.Source) { return $cmd.Source }
    Fail 'Git Bash was not found.'
}

function Resolve-Codex {
    $cmd = Get-Command codex.cmd -ErrorAction SilentlyContinue
    if ($cmd -and $cmd.Source) { return $cmd.Source }
    $generic = Get-Command codex -ErrorAction SilentlyContinue
    if ($generic -and $generic.Source) {
        $sibling = [System.IO.Path]::ChangeExtension($generic.Source,'.cmd')
        if (Test-Path -LiteralPath $sibling) { return $sibling }
    }
    Fail 'Codex CLI Windows command shim (codex.cmd) was not found on PATH.'
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

function Read-Gate {
    $values = @{}
    foreach ($line in Get-Content -LiteralPath $GatePath) {
        if ([string]::IsNullOrWhiteSpace($line) -or $line.TrimStart().StartsWith('#')) { continue }
        $idx = $line.IndexOf('=')
        if ($idx -gt 0) { $values[$line.Substring(0,$idx).Trim()] = $line.Substring($idx + 1).Trim() }
    }
    return $values
}

function Get-GitHead([string]$Repo) { return ((& git -C $Repo rev-parse HEAD).Trim()) }
function Get-GitBranch([string]$Repo) { return ((& git -C $Repo branch --show-current).Trim()) }
function Get-GitStatus([string]$Repo) { return ((& git -C $Repo status --porcelain=v1 --untracked-files=all) -join "`n") }

function Get-StatusPaths([string]$Repo) {
    $paths = @()
    foreach ($line in (& git -C $Repo status --porcelain=v1 --untracked-files=all)) {
        if ([string]::IsNullOrWhiteSpace($line)) { continue }
        $path = $line.Substring(3)
        if ($path -match ' -> ') { $path = ($path -split ' -> ')[-1] }
        $paths += $path.Replace('\','/')
    }
    return @($paths | Sort-Object -Unique)
}

function Get-NormalizedDiffSha256([string]$Repo) {
    $old = $ErrorActionPreference
    $diff = ''
    $exitCode = 1
    try {
        $ErrorActionPreference = 'Continue'
        $diff = (& git -C $Repo diff --no-ext-diff --unified=3 2>$null | Out-String)
        $exitCode = $LASTEXITCODE
    } finally {
        $ErrorActionPreference = $old
    }
    if ($exitCode -ne 0) { Fail "git diff failed for $Repo" }
    $normalized = $diff.Replace("`r`n","`n").Replace("`r","`n")
    $normalized = $normalized.TrimEnd([char[]]"`n") + "`n"
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($normalized)
    $sha = [System.Security.Cryptography.SHA256]::Create()
    try { $hash = $sha.ComputeHash($bytes) } finally { $sha.Dispose() }
    return (($hash | ForEach-Object { $_.ToString('x2') }) -join '')
}

function Get-RepoFingerprint([string]$Repo) {
    $head = Get-GitHead $Repo
    $branch = Get-GitBranch $Repo
    $status = Get-GitStatus $Repo

    $old = $ErrorActionPreference
    $tracked = ''
    $staged = ''
    try {
        $ErrorActionPreference = 'Continue'
        $tracked = (& git -C $Repo diff --binary HEAD 2>$null | Out-String)
        $trackedExit = $LASTEXITCODE
        $staged = (& git -C $Repo diff --cached --binary HEAD 2>$null | Out-String)
        $stagedExit = $LASTEXITCODE
    } finally {
        $ErrorActionPreference = $old
    }
    if ($trackedExit -ne 0 -or $stagedExit -ne 0) { Fail "Git diff failed while fingerprinting $Repo" }

    $untracked = @()
    foreach ($path in (& git -C $Repo ls-files --others --exclude-standard)) {
        if ([string]::IsNullOrWhiteSpace($path)) { continue }
        $full = Join-Path $Repo $path
        $hash = 'MISSING'
        if (Test-Path -LiteralPath $full -PathType Leaf) {
            $hash = (Get-FileHash -Algorithm SHA256 -LiteralPath $full).Hash.ToLowerInvariant()
        }
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
        $Value | ConvertTo-Json -Depth 12 | Set-Content -LiteralPath $temp -Encoding UTF8
        Move-Item -LiteralPath $temp -Destination $Path -Force
    } finally {
        Remove-Item -LiteralPath $temp -Force -ErrorAction SilentlyContinue
    }
}

function Get-BaselineMap([string]$Repo,[string]$Prefix) {
    $map = @{}
    foreach ($path in (& git -C $Repo ls-tree -r --name-only HEAD -- $Prefix)) {
        if ([string]::IsNullOrWhiteSpace($path)) { continue }
        $map[$path.Replace('\','/')] = (& git -C $Repo rev-parse "HEAD:$path").Trim()
    }
    return $map
}

function Assert-BaselineUnchanged([string]$Repo,[hashtable]$Baseline,[string]$Label) {
    foreach ($path in $Baseline.Keys) {
        $exists = Invoke-NativeExitCode -Command { & git -C $Repo cat-file -e "HEAD:$path" } -Quiet
        if ($exists -ne 0) { Fail "$Label pre-existing proof was deleted: $path" }
        $blob = (& git -C $Repo rev-parse "HEAD:$path").Trim()
        if ($blob -ne [string]$Baseline[$path]) { Fail "$Label pre-existing proof was modified: $path" }
        & git -C $Repo diff --quiet HEAD -- $path
        if ($LASTEXITCODE -ne 0) { Fail "$Label pre-existing proof has an uncommitted modification: $path" }
    }
}

function Get-ControlPlaneMap {
    $map = @{}
    foreach ($path in $ProtectedControlPlane) {
        $exists = Invoke-NativeExitCode -Command { & git -C $GovernanceRepo cat-file -e "HEAD:$path" } -Quiet
        if ($exists -ne 0) { Fail "Protected control-plane file is missing: $path" }
        $map[$path] = (& git -C $GovernanceRepo rev-parse "HEAD:$path").Trim()
    }
    return $map
}

function Assert-ControlPlane([hashtable]$Baseline) {
    foreach ($path in $Baseline.Keys) {
        & git -C $GovernanceRepo diff --quiet HEAD -- $path
        if ($LASTEXITCODE -ne 0) { Fail "Protected control-plane file has an uncommitted edit: $path" }
        $blob = (& git -C $GovernanceRepo rev-parse "HEAD:$path").Trim()
        if ($blob -ne [string]$Baseline[$path]) { Fail "Protected control-plane file changed during dirty recovery: $path" }
    }
}

function Get-TransactionChangedPaths([string]$Repo,[string]$PreHead,[string]$PostHead) {
    $paths = @()
    if ($PreHead -ne $PostHead) {
        foreach ($path in (& git -C $Repo log --format= --name-only "$PreHead..$PostHead")) {
            if (-not [string]::IsNullOrWhiteSpace($path)) { $paths += $path.Replace('\','/') }
        }
    }
    $paths += @(Get-StatusPaths $Repo)
    return @($paths | Sort-Object -Unique)
}

function Assert-AppBoundary([string]$PreHead,[string]$PostHead,[hashtable]$ProofBaseline) {
    foreach ($path in (Get-TransactionChangedPaths $AppRepo $PreHead $PostHead)) {
        if ($AllowedSourcePaths -contains $path) { continue }
        if ($path -like 'proof/P1/reopen/*') { continue }
        Fail "Application dirty recovery escaped R2 boundary: $path"
    }
    Assert-BaselineUnchanged $AppRepo $ProofBaseline 'Application'
}

function Assert-GovBoundary([string]$PreHead,[string]$PostHead,[hashtable]$ProofBaseline) {
    foreach ($path in (Get-TransactionChangedPaths $GovernanceRepo $PreHead $PostHead)) {
        if ($path -eq 'CURRENT_STATE.md' -or $path -eq 'P1_EXECUTION_GATE.env') { continue }
        if ($path -like 'proof/P1/reopen/*') { continue }
        Fail "Governance dirty recovery escaped R2 boundary: $path"
    }
    Assert-BaselineUnchanged $GovernanceRepo $ProofBaseline 'Governance'
}

function Assert-CleanSynced {
    $gate = Read-Gate
    $branch = [string]$gate['APPLICATION_BRANCH']
    if ((Get-GitBranch $AppRepo) -ne $branch) { Fail "Application branch is not $branch." }
    if (-not [string]::IsNullOrWhiteSpace((Get-GitStatus $AppRepo))) { Fail 'Application worktree is not clean at recovery handoff.' }
    if ((Get-GitBranch $GovernanceRepo) -ne 'main') { Fail 'Governance repository must remain on main.' }
    if (-not [string]::IsNullOrWhiteSpace((Get-GitStatus $GovernanceRepo))) { Fail 'Governance worktree is not clean at recovery handoff.' }

    $appFetchExit = Invoke-NativeExitCode -Command { & git -C $AppRepo fetch origin $branch } -Quiet
    if ($appFetchExit -ne 0) { Fail 'Application fetch failed.' }
    $govFetchExit = Invoke-NativeExitCode -Command { & git -C $GovernanceRepo fetch origin main } -Quiet
    if ($govFetchExit -ne 0) { Fail 'Governance fetch failed.' }

    $appRemote = (& git -C $AppRepo rev-parse "origin/$branch").Trim()
    $govRemote = (& git -C $GovernanceRepo rev-parse origin/main).Trim()
    if ((Get-GitHead $AppRepo) -ne $appRemote) { Fail 'Application HEAD is not synchronized with origin after recovery.' }
    if ((Get-GitHead $GovernanceRepo) -ne $govRemote) { Fail 'Governance HEAD is not synchronized with origin/main after recovery.' }
}

function Invoke-OfficialGate([string]$ExpectedStage,[string]$ExpectedActor) {
    $old = $ErrorActionPreference
    try {
        $ErrorActionPreference = 'Continue'
        $output = (& $Bash $CurrentSessionLauncher P1 2>&1 | Out-String)
        $status = $LASTEXITCODE
    } finally {
        $ErrorActionPreference = $old
    }
    if ($status -ne 0) { Fail "Official deterministic gate failed after recovery.`n$output" }
    if ($output -notmatch 'PRYSM PROCESS GATE PASS') { Fail 'Official deterministic gate did not emit PASS after recovery.' }
    if ($output -notmatch [regex]::Escape("Authorized stage: $ExpectedStage")) { Fail "Gate stage mismatch after recovery. Expected $ExpectedStage." }
    if ($output -notmatch [regex]::Escape("Authorized actor: $ExpectedActor")) { Fail "Gate actor mismatch after recovery. Expected $ExpectedActor." }
    return $output
}

function Assert-GovernanceAdvanceFromRun1 {
    $ancestorExit = Invoke-NativeExitCode -Command { & git -C $GovernanceRepo merge-base --is-ancestor $JournalGovernanceSha HEAD } -Quiet
    if ($ancestorExit -ne 0) { Fail 'Current governance is not a descendant of the Run 1 governance checkpoint.' }

    foreach ($path in (& git -C $GovernanceRepo log --format= --name-only "$JournalGovernanceSha..HEAD")) {
        if ([string]::IsNullOrWhiteSpace($path)) { continue }
        $normalized = $path.Replace('\','/')
        if ($AllowedGovernanceRecoveryAdvancePaths -contains $normalized) { continue }
        if ($normalized -like 'proof/P1/reopen/*') { continue }
        Fail "Governance advanced outside the audited recovery control plane since Run 1: $normalized"
    }
}

function Assert-ContinuationResult($Result,[string]$Label) {
    if ([string]$Result.loop_action -ne 'CONTINUE' -and -not (
        [string]$Result.loop_action -eq 'STOP' -and [string]$Result.next_role -eq 'Builder'
    )) { Fail "$Label is not a Builder continuation." }
    if ([string]$Result.next_role -notin @('Builder','NONE')) { Fail "$Label routes outside Builder continuity." }
    if ([string]$Result.failure_class -notin @('NONE','PROOF_SETUP_FAILURE')) { Fail "$Label has unsupported failure class $($Result.failure_class)." }
    if ([int]$Result.repair_attempt -ne $RepairAttempt) { Fail "$Label repair_attempt drifted." }
    if ([string]$Result.root_defect_id -ne $RootDefectId) { Fail "$Label root_defect_id drifted." }
    if ([int]$Result.material_defects -ne 0) { Fail "$Label reports material defects; automatic dirty recovery is not allowed." }
}

function Assert-InitialRecoveryState {
    if (-not (Test-Path -LiteralPath $JournalPath)) { Fail "R2 journal not found: $JournalPath" }
    try { $journal = Get-Content -LiteralPath $JournalPath -Raw | ConvertFrom-Json }
    catch { Fail "R2 journal is corrupt: $JournalPath" }

    if ([string]$journal.status -ne 'CODEX_EXITED_UNRECONCILED') {
        Fail "Expected CODEX_EXITED_UNRECONCILED journal, found $($journal.status)."
    }
    if ([int]$journal.exitCode -ne 0) { Fail "Unreconciled execution did not exit successfully. Exit code: $($journal.exitCode)." }
    if ([int]$journal.repairAttempt -ne $RepairAttempt) { Fail 'Unreconciled repair attempt does not equal 1.' }
    if ([string]$journal.rootDefectId -ne $RootDefectId) { Fail 'Unreconciled root defect does not match the authorized stable root.' }

    $finalPath = Join-Path ([string]$journal.runDirectory) 'final.json'
    if (-not (Test-Path -LiteralPath $finalPath)) { Fail "Unreconciled final.json is missing: $finalPath" }
    try { $result = Get-Content -LiteralPath $finalPath -Raw | ConvertFrom-Json }
    catch { Fail 'Unreconciled final.json could not be parsed.' }

    $gate = Read-Gate
    if ([string]$gate['AUTHORIZED_STAGE'] -ne 'BOUNDED_BUILD') { Fail 'Dirty recovery requires BOUNDED_BUILD.' }
    if ([string]$gate['APPLICATION_BRANCH'] -ne 'p1/bounded-build-cross-report-integrity') { Fail 'Application branch binding changed.' }

    $appFetchExit = Invoke-NativeExitCode -Command { & git -C $AppRepo fetch origin ([string]$gate['APPLICATION_BRANCH']) } -Quiet
    if ($appFetchExit -ne 0) { Fail 'Application fetch failed during dirty recovery preflight.' }
    $govFetchExit = Invoke-NativeExitCode -Command { & git -C $GovernanceRepo fetch origin main } -Quiet
    if ($govFetchExit -ne 0) { Fail 'Governance fetch failed during dirty recovery preflight.' }

    if ((Get-GitBranch $AppRepo) -ne [string]$gate['APPLICATION_BRANCH']) { Fail 'Application is not on the authorized R2 branch.' }
    if ((Get-GitBranch $GovernanceRepo) -ne 'main') { Fail 'Governance repository is not on main.' }
    if ((Get-GitHead $GovernanceRepo) -ne (& git -C $GovernanceRepo rev-parse origin/main).Trim()) {
        Fail 'Governance HEAD is not synchronized with origin/main.'
    }

    Assert-GovernanceAdvanceFromRun1

    $isRecoveryJournal = ($journal.PSObject.Properties.Name -contains 'recovery') -and [bool]$journal.recovery
    if ($isRecoveryJournal) {
        Assert-ContinuationResult $result 'Recovered continuation result'

        if ([string]$journal.postApplicationSha -ne (Get-GitHead $AppRepo)) {
            Fail 'Application HEAD no longer matches the recovered transaction journal.'
        }
        if ([string]$journal.postGovernanceSha -ne (Get-GitHead $GovernanceRepo)) {
            Fail 'Governance HEAD no longer matches the recovered transaction journal.'
        }

        $appFingerprint = Get-RepoFingerprint $AppRepo
        $govFingerprint = Get-RepoFingerprint $GovernanceRepo
        if ([string]$journal.postApplicationFingerprint -ne $appFingerprint) {
            Fail 'Application fingerprint changed after the last unreconciled recovery turn.'
        }
        if ([string]$journal.postGovernanceFingerprint -ne $govFingerprint) {
            Fail 'Governance fingerprint changed after the last unreconciled recovery turn.'
        }

        Assert-AppBoundary $ExpectedApplicationSha (Get-GitHead $AppRepo) @{}
        Assert-GovBoundary (Get-GitHead $GovernanceRepo) (Get-GitHead $GovernanceRepo) @{}
        return [pscustomobject]@{ Journal=$journal; Result=$result; IsOriginalRun1=$false }
    }

    if ([int]$journal.run -ne 1) { Fail "Expected original R2 Run 1 journal, found run $($journal.run)." }
    if ([string]$journal.postApplicationSha -ne $ExpectedApplicationSha) { Fail 'Run 1 post-application SHA is not the bound recovery SHA.' }
    if ([string]$journal.postGovernanceSha -ne $JournalGovernanceSha) { Fail 'Run 1 post-governance SHA is not the bound recovery SHA.' }
    Assert-ContinuationResult $result 'Run 1 result'
    if ([string]$result.failure_class -ne 'PROOF_SETUP_FAILURE') { Fail 'Run 1 is not the bound PROOF_SETUP_FAILURE checkpoint.' }

    if ((Get-GitHead $AppRepo) -ne $ExpectedApplicationSha) { Fail 'Application HEAD changed since the attributed dirty checkpoint.' }
    if ((& git -C $AppRepo rev-parse "origin/$($gate['APPLICATION_BRANCH'])").Trim() -ne $ExpectedApplicationSha) {
        Fail 'Application origin branch moved since the attributed dirty checkpoint.'
    }
    if (-not [string]::IsNullOrWhiteSpace((Get-GitStatus $GovernanceRepo))) { Fail 'Governance repository is dirty before original Run 1 recovery.' }

    $actualPaths = @(Get-StatusPaths $AppRepo)
    $pathDiff = @($actualPaths | Where-Object { $ExpectedInitialDirtyPaths -notcontains $_ }) +
                @($ExpectedInitialDirtyPaths | Where-Object { $actualPaths -notcontains $_ })
    if ($pathDiff.Count -ne 0 -or $actualPaths.Count -ne $ExpectedInitialDirtyPaths.Count) {
        Fail "Application dirty path set no longer matches the bound checkpoint: $($actualPaths -join ', ')"
    }

    & git -C $AppRepo diff --cached --quiet HEAD
    if ($LASTEXITCODE -ne 0) { Fail 'Bound recovery checkpoint unexpectedly contains staged changes.' }
    $untracked = @(& git -C $AppRepo ls-files --others --exclude-standard)
    if ($untracked.Count -ne 0) { Fail "Bound recovery checkpoint unexpectedly contains untracked files: $($untracked -join ', ')" }

    $actualDiffHash = Get-NormalizedDiffSha256 $AppRepo
    if ($actualDiffHash -ne $ExpectedInitialDiffSha256) {
        Fail "Application dirty diff fingerprint changed. Expected $ExpectedInitialDiffSha256, found $actualDiffHash."
    }

    return [pscustomobject]@{ Journal=$journal; Result=$result; IsOriginalRun1=$true }
}

foreach ($path in @($AppRepo,$GatePath,$CurrentSessionLauncher,$FrozenGuard,$GateRegression,$BuilderPromptPath,$SchemaPath,$RecoveryEvidencePath,$JournalPath)) {
    if (-not (Test-Path -LiteralPath $path)) { Fail "Required recovery dependency is missing: $path" }
}
if ($MaxNoProgress -lt 1) { Fail 'MaxNoProgress must be at least 1.' }

$Bash = Resolve-Bash
$Codex = Resolve-Codex

Write-Host 'PRYSM P1 R2 DIRTY CHECKPOINT RECOVERY'
Write-Host "Governance: $GovernanceRepo"
Write-Host "Application: $AppRepo"
Write-Host "Mode: $(if ($AuditOnly) { 'AUDIT ONLY' } else { 'RESUME ATTRIBUTED BUILDER TRANSACTION' })"

$recovered = Assert-InitialRecoveryState

$frozenExit = Invoke-NativeExitCode -Command { & $Bash $FrozenGuard } -Quiet
if ($frozenExit -ne 0) { Fail 'Frozen-history guard failed during recovery preflight.' }
$regressionExit = Invoke-NativeExitCode -Command { & $Bash $GateRegression } -Quiet
if ($regressionExit -ne 0) { Fail 'Permanent PRYSM gate regression failed during recovery preflight.' }

$appProofBaseline = Get-BaselineMap $AppRepo 'proof/P1/reopen'
$govProofBaseline = Get-BaselineMap $GovernanceRepo 'proof/P1/reopen'
$controlBaseline = Get-ControlPlaneMap

if ($AuditOnly) {
    Write-Host 'PRYSM P1 R2 DIRTY RECOVERY AUDIT PASS'
    Write-Host 'Exact Run 1 dirty checkpoint attribution: PASS'
    Write-Host 'No Codex Builder invocation occurred.'
    exit 0
}

$previousPromptPath = Join-Path ([string]$recovered.Journal.runDirectory) 'prompt.md'
if (-not (Test-Path -LiteralPath $previousPromptPath)) { Fail "Run 1 prompt is missing: $previousPromptPath" }
$basePrompt = Get-Content -LiteralPath $previousPromptPath -Raw

$noProgress = 0
$lastFingerprint = Get-RepoFingerprint $AppRepo
$recoveryRun = 0

while ($true) {
    Assert-ControlPlane $controlBaseline

    $preAppHead = Get-GitHead $AppRepo
    $preGovHead = Get-GitHead $GovernanceRepo
    Assert-AppBoundary $ExpectedApplicationSha $preAppHead $appProofBaseline
    Assert-GovBoundary (Get-GitHead $GovernanceRepo) $preGovHead $govProofBaseline

    $recoveryRun++
    $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
    $runDir = Join-Path $StateRoot ("recovery-{0:D4}-{1}" -f $recoveryRun,$stamp)
    New-Item -ItemType Directory -Force -Path $runDir | Out-Null
    $promptPath = Join-Path $runDir 'prompt.md'
    $stdoutPath = Join-Path $runDir 'stdout.log'
    $stderrPath = Join-Path $runDir 'stderr.log'
    $finalPath = Join-Path $runDir 'final.json'

    $recoveryInstructions = @"
# R2 DIRTY CHECKPOINT RECOVERY OVERRIDE

This is a continuation of the already-authorized P1 R2 Builder transaction. Do not reset, discard, restore, or start over from HEAD.

The current dirty application tree is attributed to R2 Run 1 and has passed the bound recovery fingerprint.

Repair accounting remains:
- repair_attempt: 1
- model: gpt-5.6-terra
- root_defect_id: P1-CROSS-REPORT-PROJECTION-RECONCILIATION

Work only the same three R2 families.

Specific required review before accepting the current work:
1. Preserve the CTA/path and trust-evidence changes only where the governed evidence still supports them.
2. Review the current performance/readiness implementation. Do not broadly relabel unrelated pillars merely because any capability is unavailable. Scope limited-evidence semantics to the causally relevant Performance & Experience condition, especially missing real-user field evidence.
3. Client-facing report copy must be ordinary human language. Do not expose internal status tokens such as LIMITED_EVIDENCE, PARTIAL, AVAILABLE, UNKNOWN, or similar machine/governance labels to the client. Explain the practical limitation plainly.
4. Review CR-40 / CR-43 rendered changes before changing expected hashes. Re-freeze hashes only when the changed output is intentionally accepted as the desired client-facing output.
5. Use only the existing authorized source/test paths and new versioned proof/P1/reopen/* generated proof.
6. Do not modify pre-existing reopened proof or protected control-plane files.
7. Continue through focused tests, required broader P1 verification, rendered proof, and exact governance/application binding.
8. Before returning CONTINUE, leave both repositories committed, pushed, clean, and synchronized. If more work remains after a clean checkpoint, the standard R2 controller will continue it.
9. READY_FOR_BRAD remains the only successful human boundary.

Do not consume repair attempt 2 for this control-plane recovery.
"@

    ($basePrompt + "`r`n`r`n" + $recoveryInstructions) | Set-Content -LiteralPath $promptPath -Encoding UTF8

    Write-JsonAtomic $JournalPath ([ordered]@{
        p='P1';r2=$true;recovery=$true;run=$recoveryRun;status='RUNNING';startedAt=(Get-Date -Format o);
        model=$Model;repairAttempt=$RepairAttempt;rootDefectId=$RootDefectId;
        preApplicationSha=$preAppHead;preGovernanceSha=$preGovHead;
        preApplicationFingerprint=(Get-RepoFingerprint $AppRepo);
        preGovernanceFingerprint=(Get-RepoFingerprint $GovernanceRepo);
        runDirectory=$runDir
    })

    $args = @(
        '--ask-for-approval','never','--sandbox','danger-full-access','--add-dir',$GovernanceRepo,
        'exec','--model',$Model,'--cd',$AppRepo,'--color','never',
        '--output-schema',$SchemaPath,'--output-last-message',$finalPath,'-'
    )

    Write-Host "`n=== P1 R2 DIRTY RECOVERY RUN $recoveryRun | $Model | repair_attempt=1 ==="
    Write-Host "Logs: $runDir"

    $old = $ErrorActionPreference
    try {
        $ErrorActionPreference = 'Continue'
        (Get-Content -LiteralPath $promptPath -Raw) | & $Codex @args 1> $stdoutPath 2> $stderrPath
        $exitCode = $LASTEXITCODE
    } finally {
        $ErrorActionPreference = $old
    }

    $postAppHead = Get-GitHead $AppRepo
    $postGovHead = Get-GitHead $GovernanceRepo
    $postAppFingerprint = Get-RepoFingerprint $AppRepo
    $postGovFingerprint = Get-RepoFingerprint $GovernanceRepo

    Write-JsonAtomic $JournalPath ([ordered]@{
        p='P1';r2=$true;recovery=$true;run=$recoveryRun;status='CODEX_EXITED_UNRECONCILED';
        startedAt=(Get-Date -Format o);finishedAt=(Get-Date -Format o);exitCode=$exitCode;
        model=$Model;repairAttempt=$RepairAttempt;rootDefectId=$RootDefectId;
        preApplicationSha=$preAppHead;postApplicationSha=$postAppHead;
        preGovernanceSha=$preGovHead;postGovernanceSha=$postGovHead;
        postApplicationFingerprint=$postAppFingerprint;postGovernanceFingerprint=$postGovFingerprint;
        runDirectory=$runDir
    })

    Assert-ControlPlane $controlBaseline
    Assert-AppBoundary $ExpectedApplicationSha $postAppHead $appProofBaseline
    Assert-GovBoundary $preGovHead $postGovHead $govProofBaseline

    $postFrozenExit = Invoke-NativeExitCode -Command { & $Bash $FrozenGuard } -Quiet
    if ($postFrozenExit -ne 0) { Fail 'Frozen-history verification failed after recovery Builder execution.' }

    if ($exitCode -ne 0 -or -not (Test-Path -LiteralPath $finalPath)) {
        $allOutput = ((Get-Content $stdoutPath -Raw -ErrorAction SilentlyContinue) + "`n" + (Get-Content $stderrPath -Raw -ErrorAction SilentlyContinue))
        if ($allOutput -match '(?i)hit your usage limit|usage limit.*try again|usage limit.*reset') {
            Notify 'PRYSM P1 BLOCKED' 'Codex usage limit reached during dirty recovery. Repair attempt remains 1.'
            Fail "Codex usage limit reached. Logs: $runDir"
        }
        Fail "Codex recovery execution failed before reconciliation. Logs: $runDir"
    }

    try { $result = Get-Content -LiteralPath $finalPath -Raw | ConvertFrom-Json }
    catch { Fail "Recovery structured result could not be parsed. Logs: $runDir" }

    if ([int]$result.repair_attempt -ne $RepairAttempt) { Fail 'Recovery Builder changed repair_attempt.' }
    if ([string]$result.root_defect_id -ne $RootDefectId) { Fail 'Recovery Builder changed root_defect_id.' }
    if ([string]$result.failure_class -eq 'NEW_ROOT_CAUSE') { Fail 'Recovery established a materially new root cause; owner review is required.' }
    if ([string]$result.failure_class -eq 'REPAIR_PROOF_FAILED') { Fail 'Product repair proof failed during dirty recovery. Do not consume/escalate repair accounting through the recovery path.' }
    if ([string]$result.failure_class -eq 'EXTERNAL_OR_PROTOCOL') { Fail 'External/protocol failure occurred during dirty recovery.' }
    if ([string]$result.failure_class -notin @('NONE','PROOF_SETUP_FAILURE')) { Fail "Unsupported recovery failure class: $($result.failure_class)" }
    if ([string]$result.loop_action -eq 'BLOCKED') { Fail "Recovery Builder reported a genuine blocker: $($result.reason)" }
    if ([string]$result.next_role -eq 'Auditor') { Fail 'Recovery Builder attempted to route directly to Auditor/Betty.' }

    $appDirty = -not [string]::IsNullOrWhiteSpace((Get-GitStatus $AppRepo))
    $govDirty = -not [string]::IsNullOrWhiteSpace((Get-GitStatus $GovernanceRepo))

    if ($appDirty -or $govDirty) {
        $isContinue = ([string]$result.loop_action -eq 'CONTINUE') -or (([string]$result.loop_action -eq 'STOP') -and ([string]$result.next_role -eq 'Builder'))
        if (-not $isContinue) { Fail 'Recovery returned a non-continuation result while repositories remain dirty.' }

        if ($postAppFingerprint -eq $lastFingerprint) { $noProgress++ } else { $noProgress = 0 }
        $lastFingerprint = $postAppFingerprint
        if ($noProgress -ge $MaxNoProgress) { Fail "Dirty recovery made no repository progress for $noProgress consecutive turns." }

        Write-Host 'Attributed dirty continuation preserved; launching another recovery Builder turn.'
        Start-Sleep -Seconds 2
        continue
    }

    Assert-CleanSynced

    $currentGate = Read-Gate
    $stage = [string]$currentGate['AUTHORIZED_STAGE']

    Write-JsonAtomic $JournalPath ([ordered]@{
        p='P1';r2=$true;recovery=$true;run=$recoveryRun;status='RECONCILED';
        checkpoint=[string]$result.checkpoint;reconciledAt=(Get-Date -Format o);
        repairAttempt=$RepairAttempt;rootDefectId=$RootDefectId;
        applicationSha=(Get-GitHead $AppRepo);governanceSha=(Get-GitHead $GovernanceRepo);
        applicationFingerprint=(Get-RepoFingerprint $AppRepo);governanceFingerprint=(Get-RepoFingerprint $GovernanceRepo)
    })

    if ($stage -eq 'OUTCOME_REVIEW' -or [string]$result.checkpoint -eq 'READY_FOR_BRAD') {
        if ($stage -ne 'OUTCOME_REVIEW') { Fail 'Builder claimed READY_FOR_BRAD without advancing governance to OUTCOME_REVIEW.' }
        Invoke-OfficialGate 'OUTCOME_REVIEW' 'BRAD' | Out-Null
        Notify 'PRYSM P1 READY FOR BRAD' 'Recovered R2 candidate is clean, pushed, and passed the deterministic Brad handoff gate.'
        Write-Host 'PRYSM P1 READY FOR BRAD'
        exit 0
    }

    if ($stage -ne 'BOUNDED_BUILD') { Fail "Unsupported stage after dirty recovery: $stage" }

    Write-Host 'PRYSM P1 R2 DIRTY RECOVERY CHECKPOINT PASS'
    Write-Host 'Repositories are clean and pushed. Return to the standard R2 continuous controller.'
    exit 0
}
