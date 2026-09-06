param(
    [switch]$AuditOnly,
    [int]$HeartbeatSeconds = 60,
    [int]$MaxNoProgress = 3
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$P = 'P1'
$RootDefectId = 'P1-CROSS-REPORT-PROJECTION-RECONCILIATION'
$InitialRepairAttempt = 1
$ModelTerra = 'gpt-5.6-terra'
$ModelSol = 'gpt-5.6-sol'

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
$AuthorizationPath = Join-Path $GovernanceRepo 'proof\P1\reopen\P1_BOUNDED_REPAIR_AUTHORIZATION_R2_V2_2026-09-06.md'
$AccountingBaselinePath = Join-Path $GovernanceRepo 'proof\P1\reopen\P1_R2_REPAIR_ACCOUNTING_BASELINE_2026-09-06.md'

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

$ProtectedControlPlane = @(
    'tools/prysm/START-PRYSM-P1-R2-AUTORUN.ps1',
    'tools/prysm/PRYSM-P-AUTORUN.ps1',
    'tools/prysm/START-PRYSM-P-AUTORUN.ps1',
    'tools/prysm/PRYSM-P-BUILDER-AUTORUN-PROMPT.md',
    'tools/prysm/test-prysm-p-autorun-contract.ps1',
    'tools/prysm/test-prysm-gate-contract.sh',
    'tools/prysm/assert-p1-frozen-history.sh',
    'tools/prysm/start-prysm-p-current-session.sh',
    'tools/prysm/start-prysm-p-base.sh',
    'tools/autorun/PRYSM-AUTORUN-RESULT.schema.json',
    'PRYSM_PERMANENT_MEMORY.md'
)

function Fail([string]$Message) {
    throw "PRYSM P1 R2 WINDOWS AUTORUN FAIL: $Message"
}

function Notify([string]$Title,[string]$Message) {
    try { [console]::Beep(880,250) } catch {}
    try {
        Start-Process -FilePath 'msg.exe' -ArgumentList @($env:USERNAME,('/TIME:30'),("$Title`n$Message")) -WindowStyle Hidden | Out-Null
    } catch {}
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

# Windows PowerShell 5.1 converts redirected native stderr into ErrorRecord
# objects. With ErrorActionPreference=Stop, benign native stderr (for example
# git fetch's normal "From ..." progress line) can terminate the script before
# LASTEXITCODE is checked. Quiet native checks must therefore lower EAP only
# for the native invocation and use the real process exit code as authority.
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

function Get-Fingerprint([string]$Repo) {
    $head = Get-GitHead $Repo
    $status = Get-GitStatus $Repo
    $payload = "$head`n$status"
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($payload)
    $sha = [System.Security.Cryptography.SHA256]::Create()
    try { $hash = $sha.ComputeHash($bytes) } finally { $sha.Dispose() }
    return (($hash | ForEach-Object { $_.ToString('x2') }) -join '')
}

function Get-ChangedPaths([string]$Repo,[string]$PreHead,[string]$PostHead) {
    $paths = @()
    if ($PreHead -ne $PostHead) {
        foreach ($path in (& git -C $Repo log --format= --name-only "$PreHead..$PostHead")) {
            if (-not [string]::IsNullOrWhiteSpace($path)) { $paths += $path.Replace('\','/') }
        }
    }
    foreach ($line in (& git -C $Repo status --porcelain=v1 --untracked-files=all)) {
        if ([string]::IsNullOrWhiteSpace($line)) { continue }
        $path = $line.Substring(3)
        if ($path -match ' -> ') { $path = ($path -split ' -> ')[-1] }
        $paths += $path.Replace('\','/')
    }
    return @($paths | Sort-Object -Unique)
}

function Get-BaselineMap([string]$Repo,[string]$Prefix) {
    $map = @{}
    foreach ($path in (& git -C $Repo ls-tree -r --name-only HEAD -- $Prefix)) {
        if ([string]::IsNullOrWhiteSpace($path)) { continue }
        $blob = (& git -C $Repo rev-parse "HEAD:$path").Trim()
        if ($LASTEXITCODE -ne 0) { Fail "Could not bind baseline proof path: $path" }
        $map[$path.Replace('\','/')] = $blob
    }
    return $map
}

function Assert-BaselineUnchanged([string]$Repo,[hashtable]$Baseline,[string]$Label) {
    foreach ($path in $Baseline.Keys) {
        $nativeExit = Invoke-NativeExitCode -Command { & git -C $Repo cat-file -e "HEAD:$path" } -Quiet
        if ($nativeExit -ne 0) { Fail "$Label pre-existing proof was deleted: $path" }
        $blob = (& git -C $Repo rev-parse "HEAD:$path").Trim()
        if ($blob -ne [string]$Baseline[$path]) { Fail "$Label pre-existing proof was modified: $path" }
        & git -C $Repo diff --quiet HEAD -- $path
        if ($LASTEXITCODE -ne 0) { Fail "$Label pre-existing proof has an uncommitted modification: $path" }
    }
}

function Get-ControlPlaneMap {
    $map = @{}
    foreach ($path in $ProtectedControlPlane) {
        $nativeExit = Invoke-NativeExitCode -Command { & git -C $GovernanceRepo cat-file -e "HEAD:$path" } -Quiet
        if ($nativeExit -ne 0) { Fail "Protected control-plane file is missing: $path" }
        $map[$path] = (& git -C $GovernanceRepo rev-parse "HEAD:$path").Trim()
    }
    return $map
}

function Assert-ControlPlane([hashtable]$Baseline) {
    foreach ($path in $Baseline.Keys) {
        & git -C $GovernanceRepo diff --quiet HEAD -- $path
        if ($LASTEXITCODE -ne 0) { Fail "Protected control-plane file has an uncommitted edit: $path" }
        $blob = (& git -C $GovernanceRepo rev-parse "HEAD:$path").Trim()
        if ($blob -ne [string]$Baseline[$path]) { Fail "Protected control-plane file changed during the active R2 run: $path" }
    }
}

function Assert-AppBoundary([string]$PreHead,[string]$PostHead,[hashtable]$ProofBaseline) {
    foreach ($path in (Get-ChangedPaths $AppRepo $PreHead $PostHead)) {
        if ($AllowedSourcePaths -contains $path) { continue }
        if ($path -like 'proof/P1/reopen/*') { continue }
        Fail "Application transaction escaped the R2 boundary: $path"
    }
    Assert-BaselineUnchanged $AppRepo $ProofBaseline 'Application'
}

function Assert-GovBoundary([string]$PreHead,[string]$PostHead,[hashtable]$ProofBaseline) {
    foreach ($path in (Get-ChangedPaths $GovernanceRepo $PreHead $PostHead)) {
        if ($path -eq 'CURRENT_STATE.md' -or $path -eq 'P1_EXECUTION_GATE.env') { continue }
        if ($path -like 'proof/P1/reopen/*') { continue }
        Fail "Governance transaction escaped the R2 boundary: $path"
    }
    Assert-BaselineUnchanged $GovernanceRepo $ProofBaseline 'Governance'
}

function Assert-CleanSynced {
    $gate = Read-Gate
    $branch = [string]$gate['APPLICATION_BRANCH']
    if ((Get-GitBranch $AppRepo) -ne $branch) { Fail "Application branch is not $branch." }
    if (-not [string]::IsNullOrWhiteSpace((Get-GitStatus $AppRepo))) { Fail 'Application worktree is not clean at a durable checkpoint.' }
    if ((Get-GitBranch $GovernanceRepo) -ne 'main') { Fail 'Governance repository must remain on main.' }
    if (-not [string]::IsNullOrWhiteSpace((Get-GitStatus $GovernanceRepo))) { Fail 'Governance worktree is not clean at a durable checkpoint.' }

    $appFetchExit = Invoke-NativeExitCode -Command { & git -C $AppRepo fetch origin $branch } -Quiet
    if ($appFetchExit -ne 0) { Fail 'Application fetch failed.' }
    $govFetchExit = Invoke-NativeExitCode -Command { & git -C $GovernanceRepo fetch origin main } -Quiet
    if ($govFetchExit -ne 0) { Fail 'Governance fetch failed.' }

    $appRemote = (& git -C $AppRepo rev-parse "origin/$branch").Trim()
    $govRemote = (& git -C $GovernanceRepo rev-parse origin/main).Trim()
    if ((Get-GitHead $AppRepo) -ne $appRemote) { Fail 'Application HEAD is not synchronized with its governed origin branch.' }
    if ((Get-GitHead $GovernanceRepo) -ne $govRemote) { Fail 'Governance HEAD is not synchronized with origin/main.' }
}

function Invoke-OfficialGate([string]$ExpectedStage,[string]$ExpectedActor) {
    $old = $ErrorActionPreference
    try {
        $ErrorActionPreference = 'Continue'
        $output = (& $Bash $CurrentSessionLauncher P1 2>&1 | Out-String)
        $status = $LASTEXITCODE
    } finally { $ErrorActionPreference = $old }
    if ($status -ne 0) { Fail "Official deterministic gate failed.`n$output" }
    if ($output -notmatch 'PRYSM PROCESS GATE PASS') { Fail 'Official deterministic gate did not emit PASS.' }
    if ($output -notmatch [regex]::Escape("Authorized stage: $ExpectedStage")) { Fail "Gate stage mismatch. Expected $ExpectedStage." }
    if ($output -notmatch [regex]::Escape("Authorized actor: $ExpectedActor")) { Fail "Gate actor mismatch. Expected $ExpectedActor." }
    return $output
}

function Write-JsonAtomic([string]$Path,$Value) {
    $temp = "$Path.tmp.$PID"
    try {
        $Value | ConvertTo-Json -Depth 12 | Set-Content -LiteralPath $temp -Encoding UTF8
        Move-Item -LiteralPath $temp -Destination $Path -Force
    } finally { Remove-Item -LiteralPath $temp -Force -ErrorAction SilentlyContinue }
}

if (-not (Test-Path -LiteralPath $AppRepo)) { Fail "Application repository not found at $AppRepo" }
foreach ($path in @($GatePath,$CurrentSessionLauncher,$FrozenGuard,$GateRegression,$BuilderPromptPath,$SchemaPath,$AuthorizationPath,$AccountingBaselinePath)) {
    if (-not (Test-Path -LiteralPath $path)) { Fail "Required governed file is missing: $path" }
}
if ($HeartbeatSeconds -lt 15) { Fail 'HeartbeatSeconds must be at least 15.' }
if ($MaxNoProgress -lt 1) { Fail 'MaxNoProgress must be at least 1.' }

$Bash = Resolve-Bash
$Codex = Resolve-Codex

Write-Host 'PRYSM P1 R2 WINDOWS AUTORUN'
Write-Host "Governance: $GovernanceRepo"
Write-Host "Application: $AppRepo"
Write-Host "Mode: $(if ($AuditOnly) { 'AUDIT ONLY' } else { 'CONTINUOUS BUILDER TO BRAD' })"

Assert-CleanSynced

$gate = Read-Gate
if ([string]$gate['AUTHORIZED_STAGE'] -ne 'BOUNDED_BUILD') { Fail "Expected BOUNDED_BUILD, found $($gate['AUTHORIZED_STAGE'])." }
if ([string]$gate['DIAGNOSTIC_FILE'] -ne 'proof/P1/reopen/P1_DIAGNOSTIC_TRUTH_R2_2026-09-06.md') { Fail 'Gate is not bound to the R2 diagnostic.' }
if ([string]$gate['REPAIR_AUTH_FILE'] -ne 'proof/P1/reopen/P1_BOUNDED_REPAIR_AUTHORIZATION_R2_2026-09-06.md') { Fail 'Gate is not bound to the original R2 repair authorization.' }
if ([string]$gate['R2_EXECUTION_AUTH_FILE'] -ne 'proof/P1/reopen/P1_BOUNDED_REPAIR_AUTHORIZATION_R2_V2_2026-09-06.md') { Fail 'Gate is not bound to the R2 V2 execution authorization.' }

$authorization = Get-Content -LiteralPath $AuthorizationPath -Raw
if ($authorization -notmatch [regex]::Escape($RootDefectId)) { Fail 'R2 V2 authorization does not bind the expected stable root.' }
if ($authorization -notmatch 'Decision: APPROVED') { Fail 'R2 V2 authorization is not APPROVED.' }

$frozenExit = Invoke-NativeExitCode -Command { & $Bash $FrozenGuard }
if ($frozenExit -ne 0) { Fail 'Frozen-history guard failed.' }

$regressionExit = Invoke-NativeExitCode -Command { & $Bash $GateRegression }
if ($regressionExit -ne 0) { Fail 'Permanent PRYSM gate regression failed.' }

$gateOutput = Invoke-OfficialGate 'BOUNDED_BUILD' 'BUILDER'

$controlBaseline = Get-ControlPlaneMap
$appProofBaseline = Get-BaselineMap $AppRepo 'proof/P1/reopen'
$govProofBaseline = Get-BaselineMap $GovernanceRepo 'proof/P1/reopen'

if ($AuditOnly) {
    Write-Host 'PRYSM P1 R2 WINDOWS AUTORUN AUDIT PASS'
    Write-Host 'No Codex Builder invocation occurred.'
    exit 0
}

$LocalBase = if ($env:LOCALAPPDATA) { $env:LOCALAPPDATA } else { $env:TEMP }
$StateRoot = Join-Path $LocalBase 'PRYSM-P-Autorun\P1-R2'
New-Item -ItemType Directory -Force -Path $StateRoot | Out-Null
$RepairStatePath = Join-Path $StateRoot 'repair-state.json'
$JournalPath = Join-Path $StateRoot 'transaction-journal.json'
$HeartbeatPath = Join-Path $StateRoot 'heartbeat.json'
$HeartbeatStopPath = Join-Path $StateRoot 'heartbeat.stop'

if (Test-Path -LiteralPath $JournalPath) {
    try { $existingJournal = Get-Content -LiteralPath $JournalPath -Raw | ConvertFrom-Json }
    catch { Fail "R2 journal is corrupt: $JournalPath" }
    if ([string]$existingJournal.status -in @('RUNNING','CODEX_EXITED_UNRECONCILED')) {
        Fail "R2 journal is incomplete and must be reconciled before another run: $JournalPath"
    }
}

$repairAttempt = $InitialRepairAttempt
if (Test-Path -LiteralPath $RepairStatePath) {
    try { $repairState = Get-Content -LiteralPath $RepairStatePath -Raw | ConvertFrom-Json }
    catch { Fail "R2 repair state is corrupt: $RepairStatePath" }
    if ([string]$repairState.rootDefectId -ne $RootDefectId) { Fail 'R2 repair state is bound to a different root.' }
    $repairAttempt = [int]$repairState.repairAttempt
    if ($repairAttempt -lt $InitialRepairAttempt) { Fail 'R2 repair state attempted to reset below repair index 1.' }
}
if ($repairAttempt -gt 2) { Fail 'R2 same-root repair levels are exhausted.' }

function Save-RepairState {
    Write-JsonAtomic $RepairStatePath ([ordered]@{p='P1';rootDefectId=$RootDefectId;repairAttempt=$repairAttempt;updatedAt=(Get-Date -Format o)})
}
Save-RepairState

Remove-Item -LiteralPath $HeartbeatStopPath -Force -ErrorAction SilentlyContinue
$heartbeatJob = Start-Job -ArgumentList @($HeartbeatPath,$HeartbeatStopPath,$HeartbeatSeconds) -ScriptBlock {
    param($Path,$Stop,$Seconds)
    while (-not (Test-Path -LiteralPath $Stop)) {
        [ordered]@{p='P1';r2=$true;alive=$true;timestamp=(Get-Date -Format o)} | ConvertTo-Json | Set-Content -LiteralPath $Path -Encoding UTF8
        Start-Sleep -Seconds $Seconds
    }
}

$run = 0
$noProgress = 0

try {
    while ($true) {
        Assert-ControlPlane $controlBaseline
        Assert-CleanSynced

        $gate = Read-Gate
        $stage = [string]$gate['AUTHORIZED_STAGE']
        if ($stage -eq 'OUTCOME_REVIEW') {
            Invoke-OfficialGate 'OUTCOME_REVIEW' 'BRAD' | Out-Null
            Notify 'PRYSM P1 READY FOR BRAD' 'Exact R2 candidate and governance passed the deterministic Brad handoff gate.'
            Write-Host 'PRYSM P1 READY FOR BRAD'
            break
        }
        if ($stage -ne 'BOUNDED_BUILD') { Fail "Unsupported stage during R2 autorun: $stage" }

        if ($repairAttempt -eq 1) { $model = $ModelTerra }
        elseif ($repairAttempt -eq 2) { $model = $ModelSol }
        else { Fail "Invalid R2 repair attempt: $repairAttempt" }

        $gateOutput = Invoke-OfficialGate 'BOUNDED_BUILD' 'BUILDER'
        $handoff = (($gateOutput -split "`r?`n") | ForEach-Object -Begin {$capture=$false} -Process {
            if ($_ -eq '----- PRYSM GOVERNED HANDOFF START -----') { $capture=$true; return }
            if ($_ -eq '----- PRYSM GOVERNED HANDOFF END -----') { $capture=$false; return }
            if ($capture) { $_ }
        }) -join "`r`n"
        if ([string]::IsNullOrWhiteSpace($handoff)) { Fail 'Could not extract governed Builder handoff.' }

        $run++
        $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
        $runDir = Join-Path $StateRoot ("run-{0:D4}-{1}" -f $run,$stamp)
        New-Item -ItemType Directory -Force -Path $runDir | Out-Null
        $promptPath = Join-Path $runDir 'prompt.md'
        $stdoutPath = Join-Path $runDir 'stdout.log'
        $stderrPath = Join-Path $runDir 'stderr.log'
        $finalPath = Join-Path $runDir 'final.json'

        $preAppHead = Get-GitHead $AppRepo
        $preGovHead = Get-GitHead $GovernanceRepo
        $preAppFingerprint = Get-Fingerprint $AppRepo
        $preGovFingerprint = Get-Fingerprint $GovernanceRepo

        Write-JsonAtomic $JournalPath ([ordered]@{
            p='P1';r2=$true;run=$run;status='RUNNING';startedAt=(Get-Date -Format o);model=$model;
            repairAttempt=$repairAttempt;rootDefectId=$RootDefectId;preApplicationSha=$preAppHead;preGovernanceSha=$preGovHead;runDirectory=$runDir
        })

        $runtime = @"
# PRYSM P1 R2 WINDOWS CONTINUOUS BUILDER

Current stage: BOUNDED_BUILD
Current model: $model
Current repair_attempt: $repairAttempt
Stable root_defect_id: $RootDefectId

R2 ANTI-DRIFT CONTRACT
- Work only the three R2 families: CTA/path coherence; trust evidence attribution; fail-closed performance/readiness reconciliation.
- Source edits are limited to the exact R2 authorization allowlist.
- New rendered/application proof may be added only under new versioned proof/P1/reopen/* paths. Do not modify any proof/P1/reopen/* path that existed when this R2 controller started.
- Governance may add new versioned proof/P1/reopen/* evidence and intentionally update CURRENT_STATE.md / P1_EXECUTION_GATE.env for durable checkpoints and Brad handoff. Do not modify pre-existing R2 proof evidence.
- Robots/indexability, unrelated copy cleanup, evidence acquisition, scoring policy, providers, Writer/Judge, storage/lifecycle, deployment and application main are outside scope.
- A materially new root, required source path outside the allowlist, or protected dependency is BLOCKED; do not broaden scope.
- Echo repair_attempt exactly as $repairAttempt and root_defect_id exactly as $RootDefectId.
- A model invocation ending is not a workflow boundary. Continue through repair, tests, broader required P1 verification, rendered proof, commit/push, and governance rebinding while safely in scope.
- Before returning CONTINUE, leave both repositories clean and pushed at a durable checkpoint and keep BOUNDED_BUILD gate binding exact.
- Successful terminal boundary is READY_FOR_BRAD / OUTCOME_REVIEW. Do not run Brad, Betty, P2, closure, deployment, or application-main merge.

# Deterministic governed handoff
$handoff

# Shared Builder contract
$(Get-Content -LiteralPath $BuilderPromptPath -Raw)
"@
        $runtime | Set-Content -LiteralPath $promptPath -Encoding UTF8

        $args = @(
            '--ask-for-approval','never','--sandbox','danger-full-access','--add-dir',$GovernanceRepo,
            'exec','--model',$model,'--cd',$AppRepo,'--color','never',
            '--output-schema',$SchemaPath,'--output-last-message',$finalPath,'-'
        )

        Write-Host "`n=== P1 R2 RUN $run | $model | repair_attempt=$repairAttempt ==="
        Write-Host "Logs: $runDir"

        $old = $ErrorActionPreference
        try {
            $ErrorActionPreference = 'Continue'
            (Get-Content -LiteralPath $promptPath -Raw) | & $Codex @args 1> $stdoutPath 2> $stderrPath
            $exitCode = $LASTEXITCODE
        } finally { $ErrorActionPreference = $old }

        $postAppHead = Get-GitHead $AppRepo
        $postGovHead = Get-GitHead $GovernanceRepo
        $postAppFingerprint = Get-Fingerprint $AppRepo
        $postGovFingerprint = Get-Fingerprint $GovernanceRepo

        Write-JsonAtomic $JournalPath ([ordered]@{
            p='P1';r2=$true;run=$run;status='CODEX_EXITED_UNRECONCILED';startedAt=(Get-Date -Format o);finishedAt=(Get-Date -Format o);
            exitCode=$exitCode;model=$model;repairAttempt=$repairAttempt;rootDefectId=$RootDefectId;
            preApplicationSha=$preAppHead;postApplicationSha=$postAppHead;preGovernanceSha=$preGovHead;postGovernanceSha=$postGovHead;runDirectory=$runDir
        })

        Assert-ControlPlane $controlBaseline
        Assert-AppBoundary $preAppHead $postAppHead $appProofBaseline
        Assert-GovBoundary $preGovHead $postGovHead $govProofBaseline
        $postFrozenExit = Invoke-NativeExitCode -Command { & $Bash $FrozenGuard } -Quiet
        if ($postFrozenExit -ne 0) { Fail 'Frozen-history verification failed after Builder execution.' }

        if ($exitCode -ne 0 -or -not (Test-Path -LiteralPath $finalPath)) {
            $allOutput = ((Get-Content $stdoutPath -Raw -ErrorAction SilentlyContinue) + "`n" + (Get-Content $stderrPath -Raw -ErrorAction SilentlyContinue))
            if ($allOutput -match '(?i)hit your usage limit|usage limit.*try again|usage limit.*reset') {
                Notify 'PRYSM P1 BLOCKED' 'Codex usage limit reached. R2 repair accounting was not advanced.'
                Fail "Codex usage limit reached. Logs: $runDir"
            }
            Fail "Codex execution failed before reconciliation. Logs: $runDir"
        }

        try { $result = Get-Content -LiteralPath $finalPath -Raw | ConvertFrom-Json }
        catch { Fail "Structured result could not be parsed. Logs: $runDir" }

        if ([int]$result.repair_attempt -ne $repairAttempt) { Fail "Builder repair_attempt drifted. Expected $repairAttempt, returned $($result.repair_attempt)." }
        if ([string]$result.root_defect_id -ne $RootDefectId) {
            Notify 'PRYSM P1 BLOCKED' 'Root-defect drift detected. Owner review required.'
            Fail "Root-defect drift detected. Expected $RootDefectId, returned $($result.root_defect_id)."
        }
        if ([string]$result.failure_class -eq 'NEW_ROOT_CAUSE') {
            Notify 'PRYSM P1 BLOCKED' 'A materially new root cause was established. Owner review required.'
            Fail 'NEW_ROOT_CAUSE is outside the authorized R2 envelope.'
        }

        $currentGate = Read-Gate
        $currentStage = [string]$currentGate['AUTHORIZED_STAGE']
        if ([string]$result.checkpoint -eq 'READY_FOR_BRAD' -or $currentStage -eq 'OUTCOME_REVIEW') {
            if ([string]$result.loop_action -ne 'STOP' -or [string]$result.next_role -ne 'NONE') { Fail 'READY_FOR_BRAD result contract is invalid.' }
            if ([string]$result.whole_app_gate -ne 'PASS' -or [int]$result.material_defects -ne 0) { Fail 'READY_FOR_BRAD requires green whole-app proof and zero material defects.' }
            if ([string]$result.failure_class -ne 'NONE' -or -not [bool]$result.github_state_synced) { Fail 'READY_FOR_BRAD requires failure_class=NONE and github_state_synced=true.' }
            Assert-CleanSynced
            if ([string]$result.application_sha -ne (Get-GitHead $AppRepo)) { Fail 'READY_FOR_BRAD application SHA mismatch.' }
            if ([string]$result.governance_sha -ne (Get-GitHead $GovernanceRepo)) { Fail 'READY_FOR_BRAD governance SHA mismatch.' }
            Invoke-OfficialGate 'OUTCOME_REVIEW' 'BRAD' | Out-Null
            Write-JsonAtomic $JournalPath ([ordered]@{p='P1';r2=$true;run=$run;status='RECONCILED';checkpoint='READY_FOR_BRAD';reconciledAt=(Get-Date -Format o)})
            Notify 'PRYSM P1 READY FOR BRAD' 'Exact R2 candidate and governance passed the deterministic Brad handoff gate.'
            Write-Host 'PRYSM P1 READY FOR BRAD'
            break
        }

        if ([string]$result.loop_action -eq 'BLOCKED') {
            Write-JsonAtomic $JournalPath ([ordered]@{p='P1';r2=$true;run=$run;status='RECONCILED';checkpoint=[string]$result.checkpoint;reconciledAt=(Get-Date -Format o)})
            Notify 'PRYSM P1 BLOCKED' ([string]$result.reason)
            Fail "Builder reported a genuine blocker: $($result.reason)"
        }

        $failureClass = [string]$result.failure_class
        if ($failureClass -eq 'REPAIR_PROOF_FAILED') {
            if ($repairAttempt -ge 2) {
                Write-JsonAtomic $JournalPath ([ordered]@{p='P1';r2=$true;run=$run;status='RECONCILED';checkpoint='THREE_ATTEMPTS_EXHAUSTED';reconciledAt=(Get-Date -Format o)})
                Notify 'PRYSM P1 BLOCKED' 'Third same-root repair attempt failed. No fourth attempt is permitted.'
                Fail 'Same-root repair limit reached.'
            }
            $repairAttempt++
            Save-RepairState
        } elseif ($failureClass -eq 'PROOF_SETUP_FAILURE') {
            # Same repair level; Builder may fix proof setup inside the authorized boundary.
        } elseif ($failureClass -eq 'EXTERNAL_OR_PROTOCOL') {
            Write-JsonAtomic $JournalPath ([ordered]@{p='P1';r2=$true;run=$run;status='RECONCILED';checkpoint='EXTERNAL_OR_PROTOCOL';reconciledAt=(Get-Date -Format o)})
            Notify 'PRYSM P1 BLOCKED' ([string]$result.reason)
            Fail 'External/protocol failure requires review before another Builder invocation.'
        } elseif ($failureClass -ne 'NONE') {
            Fail "Unsupported failure class: $failureClass"
        }

        $isContinue = ([string]$result.loop_action -eq 'CONTINUE') -or (([string]$result.loop_action -eq 'STOP') -and ([string]$result.next_role -eq 'Builder'))
        if (-not $isContinue) { Fail "Unsupported non-terminal route: loop_action=$($result.loop_action) next_role=$($result.next_role)" }
        if ([string]$result.next_role -eq 'Auditor') { Fail 'Builder attempted to route directly to Auditor/Betty.' }

        Assert-CleanSynced
        $sameFingerprint = ($preAppFingerprint -eq $postAppFingerprint -and $preGovFingerprint -eq $postGovFingerprint)
        if ($sameFingerprint) { $noProgress++ } else { $noProgress = 0 }
        if ($noProgress -ge $MaxNoProgress) { Fail "No-progress anti-thrash limit reached after $noProgress continuations." }

        Write-JsonAtomic $JournalPath ([ordered]@{
            p='P1';r2=$true;run=$run;status='RECONCILED';checkpoint=[string]$result.checkpoint;reconciledAt=(Get-Date -Format o);
            repairAttempt=$repairAttempt;rootDefectId=$RootDefectId;applicationSha=(Get-GitHead $AppRepo);governanceSha=(Get-GitHead $GovernanceRepo)
        })
        Start-Sleep -Seconds 2
    }
}
finally {
    Set-Content -LiteralPath $HeartbeatStopPath -Value 'stop' -Encoding ASCII -ErrorAction SilentlyContinue
    if ($heartbeatJob) {
        Wait-Job $heartbeatJob -Timeout 3 | Out-Null
        Remove-Job $heartbeatJob -Force -ErrorAction SilentlyContinue
    }
}