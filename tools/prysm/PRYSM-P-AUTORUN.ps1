param(
    [Parameter(Mandatory = $true)]
    [ValidatePattern('^P[0-9]+$')]
    [string]$P,

    [Parameter(Mandatory = $ true)]
    [string]$AppRepo,

    [Parameter(Mandatory = $true)]
    [string]$GovernanceRepo,

    [int]$MaxRuns = 0,
    [int]$DelaySeconds = 2,
    [int]$HeartbeatSeconds = 60,
    [int]$MaxConsecutiveFailures = 3,
    [switch]$PreflightOnly,
    [switch]$SelfTest,

    [ValidateSet('READY_FOR_BRAD','BLOCKED','CONTROLLER_FAILURE')]
    [string]$TestNotification
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$SchemaPath = Join-Path (Split-Path -Parent $ScriptRoot) 'autorun\PRYSM-AUTORUN-RESULT.schema.json'
$BuilderPromptPath = Join-Path $ScriptRoot 'PRYSM-P-BUILDER-AUTORUN-PROMPT.md'

$ModelLuna = 'gpt-5.6-luna'
$ModelTerra = 'gpt-5.6-terra'
$ModelSol = 'gpt-5.6-sol'

function Resolve-RequiredPath {
    param([string]$Path,[string]$Label)
    if (-not (Test-Path -LiteralPath $Path)) { throw "$Label does not exist: $Path" }
    return (Resolve-Path -LiteralPath $Path).Path
}

function Assert-GitRepo {
    param([string]$Path,[string]$Label)
    & git -C $Path rev-parse --is-inside-work-tree *> $null
    if ($LASTEXITCODE -ne 0) { throw "$Label is not a Git repository: $Path" }
}

function Resolve-CodexCmd {
    $cmd = Get-Command codex.cmd -ErrorAction SilentlyContinue
    if ($cmd -and (Test-Path -LiteralPath $cmd.Source)) { return $cmd.Source }
    $generic = Get-Command codex -ErrorAction SilentlyContinue
    if ($generic -and $generic.Source) {
        $sibling = [System.IO.Path]::ChangeExtension($generic.Source,'.cmd')
        if (Test-Path -LiteralPath $sibling) { return $sibling }
    }
    throw 'Codex CLI Windows command shim (codex.cmd) was not found on PATH.'
}

function Read-EnvFile {
    param([string]$Path)
    $values = @{}
    foreach ($line in Get-Content -LiteralPath $Path) {
        if ([string]::IsNullOrWhiteSpace($line) -or $line.TrimStart().StartsWith('#')) { continue }
        $idx = $line.IndexOf('=')
        if ($idx -lt 1) { continue }
        $values[$line.Substring(0,$idx).Trim()] = $line.Substring($idx + 1).Trim()
    }
    return $values
}

function Normalize-RootDefectId {
    param([string]$Value)
    if ([string]::IsNullOrWhiteSpace($Value)) { return 'NONE' }
    return $Value.Trim()
}

function Get-ModelForAttempt {
    param([int]$Attempt)
    switch ($Attempt) {
        0 { return $ModelLuna }
        1 { return $ModelTerra }
        2 { return $ModelSol }
        default { return $null }
    }
}

function Send-DesktopNotification {
    param(
        [Parameter(Mandatory = $true)][string]$Title,
        [Parameter(Mandatory = $true)][string]$Message,
        [ValidateSet('Info','Warning','Error')][string]$Level = 'Info'
    )
    try {
        Add-Type -AssemblyName System.Windows.Forms -ErrorAction Stop
        switch ($Level) {
            'Error' { [System.Media.SystemSounds]::Hand.Play() }
            'Warning' { [System.Media.SystemSounds]::Exclamation.Play() }
            default { [System.Media.SystemSounds]::Asterisk.Play() }
        }
        $icon = switch ($Level) {
            'Error' { [System.Windows.Forms.MessageBoxIcon]::Error }
            'Warning' { [System.Windows.Forms.MessageBoxIcon]::Warning }
            default { [System.Windows.Forms.MessageBoxIcon]::Information }
        }
        [System.Windows.Forms.MessageBox]::Show($Message,$Title,[System.Windows.Forms.MessageBoxButtons]::OK,$icon) | Out-Null
        return
    } catch {}
    try { & msg.exe $env:USERNAME "$Title`n$Message" 2>$null | Out-Null } catch {}
}

function Send-TerminalNotification {
    param(
        [ValidateSet('READY_FOR_BRAD','BLOCKED','CONTROLLER_FAILURE')][string]$Kind,
        [string]$ApplicationSha = 'UNBOUND',
        [string]$GovernanceSha = 'UNBOUND',
        [string]$Reason = '',
        [string]$NextAction = '',
        [string]$RunLog = ''
    )
    if ($Kind -eq 'READY_FOR_BRAD') {
        Send-DesktopNotification -Title "PRYSM $P READY FOR BRAD" -Level Info -Message "Application SHA: $ApplicationSha`nGovernance SHA: $GovernanceSha`nFocused/full verification: PASS`nRendered proof: PASS`nNext actor: Brad"
    } elseif ($Kind -eq 'BLOCKED') {
        Send-DesktopNotification -Title "PRYSM $P BLOCKED" -Level Warning -Message "Blocker: $Reason`nApplication SHA: $ApplicationSha`nGovernance SHA: $GovernanceSha`nNext action: $NextAction"
    } else {
        Send-DesktopNotification -Title "PRYSM $P CONTROLLER FAILURE" -Level Error -Message "Failure: $Reason`nLatest run log: $RunLog"
    }
}

function Test-UsageLimit {
    param([string[]]$Paths)
    foreach ($path in $Paths) {
        if (-not (Test-Path -LiteralPath $path)) { continue }
        $text = Get-Content -LiteralPath $path -Raw -ErrorAction SilentlyContinue
        if ($text -match '(?i)hit your usage limit|usage limit.*try again|usage limit.*reset') { return $true }
    }
    return $false
}

function Get-Route {
    param($Result)
    $checkpoint = [string]$Result.checkpoint
    $loopAction = [string]$Result.loop_action
    $nextRole = [string]$Result.next_role

    if ($checkpoint -eq 'READY_FOR_BRAD') { return 'READY_FOR_BRAD' }
    if ($loopAction -eq 'BLOCKED') { return 'BLOCKED' }

    # Safety: this controller never launches Auditor/Betty. A Builder attempt to hand to
    # Auditor means the Builder-owned candidate is ready for the human Brad boundary.
    if ($nextRole -eq 'Auditor') { return 'READY_FOR_BRAD' }

    # Critical anti-stop/start rule: if Builder says more Builder work remains, keep
    # relaunching even if the individual Codex turn used STOP as its narrative action.
    if ($nextRole -eq 'Builder' -and ($loopAction -eq 'CONTINUE' -or $loopAction -eq 'STOP')) { return 'CONTINUE' }

    if ($loopAction -eq 'CONTINUE' -and $nextRole -eq 'NONE') { return 'CONTINUE' }
    if ($loopAction -eq 'COMPLETE' -and $checkpoint -eq 'READY_FOR_BRAD') { return 'READY_FOR_BRAD' }

    return 'BLOCKED'
}

if ($TestNotification) {
    Send-TerminalNotification -Kind $TestNotification -ApplicationSha 'TEST-APP-SHA' -GovernanceSha 'TEST-GOV-SHA' -Reason 'Test notification only.' -NextAction 'Close this popup.' -RunLog 'TEST-NO-RUN'
    Write-Host "Notification test sent: $TestNotification"
    exit 0
}

if (-not (Test-Path -LiteralPath $SchemaPath)) { throw "Missing schema: $SchemaPath" }
if (-not (Test-Path -LiteralPath $BuilderPromptPath)) { throw "Missing Builder prompt: $BuilderPromptPath" }

if ($SelfTest) {
    $a = [pscustomobject]@{ checkpoint='WORK'; loop_action='CONTINUE'; next_role='Builder' }
    $b = [pscustomobject]@{ checkpoint='WORK'; loop_action='STOP'; next_role='Builder' }
    $c = [pscustomobject]@{ checkpoint='READY_FOR_BRAD'; loop_action='STOP'; next_role='NONE' }
    $d = [pscustomobject]@{ checkpoint='AUDIT_REQUIRED'; loop_action='CONTINUE'; next_role='Auditor' }
    $e = [pscustomobject]@{ checkpoint='WORK'; loop_action='BLOCKED'; next_role='NONE' }
    if ((Get-Route $a) -ne 'CONTINUE') { throw 'SelfTest failed: CONTINUE+Builder' }
    if ((Get-Route $b) -ne 'CONTINUE') { throw 'SelfTest failed: STOP+Builder must continue' }
    if ((Get-Route $c) -ne 'READY_FOR_BRAD') { throw 'SelfTest failed: READY_FOR_BRAD' }
    if ((Get-Route $d) -ne 'READY_FOR_BRAD') { throw 'SelfTest failed: Auditor handoff must stop for Brad' }
    if ((Get-Route $e) -ne 'BLOCKED') { throw 'SelfTest failed: BLOCKED' }
    if ((Get-ModelForAttempt 0) -ne $ModelLuna -or (Get-ModelForAttempt 1) -ne $ModelTerra -or (Get-ModelForAttempt 2) -ne $ModelSol) { throw 'SelfTest failed: model escalation' }
    Write-Host 'PRYSM P# AUTORUN SELFTEST PASS'
    exit 0
}

$AppRepo = Resolve-RequiredPath $AppRepo 'Application repository'
$GovernanceRepo = Resolve-RequiredPath $GovernanceRepo 'Governance repository'
Assert-GitRepo $AppRepo 'Application repository'
Assert-GitRepo $GovernanceRepo 'Governance repository'
$CodexCmdPath = Resolve-CodexCmd

$GatePath = Join-Path $GovernanceRepo ("{0}_EXECUTION_GATE.env" -f $P)
if (-not (Test-Path -LiteralPath $GatePath)) { throw "Missing P execution gate: $GatePath" }
$gate = Read-EnvFile $GatePath
if (-not $gate.ContainsKey('P_ID') -or $gate['P_ID'] -ne $P) { throw "P gate identity mismatch for $P" }
if (-not $gate.ContainsKey('AUTHORIZED_STAGE')) { throw "P gate missing AUTHORIZED_STAGE: $GatePath" }
if ($gate['AUTHORIZED_STAGE'] -notin @('DIAGNOSTIC_TRUTH','BOUNDED_BUILD')) { throw "P $P is not Builder-owned according to AUTHORIZED_STAGE=$($gate['AUTHORIZED_STAGE'])" }
if (-not $gate.ContainsKey('APPLICATION_BRANCH')) { throw "P gate missing APPLICATION_BRANCH" }

$currentBranch = (& git -C $AppRepo branch --show-current).Trim()
if ($currentBranch -ne $gate['APPLICATION_BRANCH']) {
    throw "Application branch mismatch. Current=$currentBranch Required=$($gate['APPLICATION_BRANCH']). Controller will not switch a dirty worktree."
}

$LocalBase = if ($env:LOCALAPPDATA) { $env:LOCALAPPDATA } else { $env:TEMP }
$LocalRoot = Join-Path $LocalBase ("PRYSM-P-Autorun\{0}" -f $P)
New-Item -ItemType Directory -Force -Path $LocalRoot | Out-Null
$AccountingPath = Join-Path $LocalRoot 'accounting.json'
$ControllerStatePath = Join-Path $LocalRoot 'controller-state.json'
$HeartbeatPath = Join-Path $LocalRoot 'heartbeat.json'
$HeartbeatStopPath = Join-Path $LocalRoot 'heartbeat.stop'

$repairAttempt = 0
$rootDefectId = 'NONE'
if (Test-Path -LiteralPath $AccountingPath) {
    try {
        $accounting = Get-Content -LiteralPath $AccountingPath -Raw | ConvertFrom-Json
        $repairAttempt = [int]$accounting.repairAttempt
        $rootDefectId = Normalize-RootDefectId ([string]$accounting.rootDefectId)
    } catch {
        $repairAttempt = 0
        $rootDefectId = 'NONE'
    }
}
if ($repairAttempt -lt 0) { $repairAttempt = 0 }
if ($repairAttempt -gt 3) { $repairAttempt = 3 }

function Write-Accounting {
    [ordered]@{
        p = $P
        repairAttempt = $repairAttempt
        rootDefectId = $rootDefectId
        updatedAt = (Get-Date -Format o)
    } | ConvertTo-Json -Depth 4 | Set-Content -LiteralPath $AccountingPath -Encoding UTF8
}

function Write-ControllerState {
    param([string]$Status,[int]$Run,[string]$Model,[string]$Checkpoint,[string]$Reason,[string]$LogPath)
    [ordered]@{
        p = $P
        status = $Status
        updatedAt = (Get-Date -Format o)
        controllerPid = $PID
        run = $Run
        model = $Model
        checkpoint = $Checkpoint
        reason = $Reason
        repairAttempt = $repairAttempt
        rootDefectId = $rootDefectId
        latestRunLog = $LogPath
        applicationBranch = ((& git -C $AppRepo branch --show-current).Trim())
        applicationSha = ((& git -C $AppRepo rev-parse HEAD).Trim())
        governanceSha = ((& git -C $GovernanceRepo rev-parse HEAD).Trim())
    } | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath $ControllerStatePath -Encoding UTF8
}

if ($PreflightOnly) {
    Write-Host "PRYSM $P AUTORUN PREFLIGHT"
    Write-Host "Application: $AppRepo"
    Write-Host "Governance:  $GovernanceRepo"
    Write-Host "Branch:      $currentBranch"
    Write-Host "Stage:       $($gate['AUTHORIZED_STAGE'])"
    Write-Host "Codex:       $CodexCmdPath"
    Write-Host "Prompt:      $BuilderPromptPath"
    Write-Host "Schema:      $SchemaPath"
    Write-Host "Local state: $LocalRoot"
    Write-Host 'Approval:    never'
    Write-Host 'Sandbox:     danger-full-access'
    Write-Host 'PREFLIGHT PASS'
    exit 0
}

if ($HeartbeatSeconds -lt 15) { throw 'HeartbeatSeconds must be at least 15.' }
Remove-Item -LiteralPath $HeartbeatStopPath -Force -ErrorAction SilentlyContinue
Write-Accounting
Write-ControllerState -Status 'STARTING' -Run 0 -Model '' -Checkpoint 'STARTING' -Reason '' -LogPath ''

$heartbeatJob = Start-Job -ArgumentList @($HeartbeatPath,$HeartbeatStopPath,$ControllerStatePath,$HeartbeatSeconds,$P) -ScriptBlock {
    param($HeartbeatPath,$StopPath,$StatePath,$Seconds,$PId)
    while (-not (Test-Path -LiteralPath $StopPath)) {
        $state = $null
        try { $state = Get-Content -LiteralPath $StatePath -Raw | ConvertFrom-Json } catch {}
        [ordered]@{
            p = $PId
            alive = $true
            timestamp = (Get-Date -Format o)
            status = if ($state) { $state.status } else { 'UNKNOWN' }
            run = if ($state) { $state.run } else { 0 }
            checkpoint = if ($state) { $state.checkpoint } else { 'UNKNOWN' }
        } | ConvertTo-Json -Depth 4 | Set-Content -LiteralPath $HeartbeatPath -Encoding UTF8
        Start-Sleep -Seconds $Seconds
    }
}

$runNumber = 0
$consecutiveFailures = 0
$latestRunLog = ''

try {
    Write-Host "PRYSM $P CONTINUOUS AUTORUN STARTED"
    Write-Host "Branch: $currentBranch"
    Write-Host "Logs: $LocalRoot"
    Write-Host 'The controller will keep relaunching Builder until READY_FOR_BRAD or a true blocker.'

    while ($true) {
        if ($MaxRuns -gt 0 -and $runNumber -ge $MaxRuns) {
            throw "Safety run limit reached: $MaxRuns"
        }
        if ($repairAttempt -ge 3) {
            $reason = "Three same-root repair attempts exhausted for '$rootDefectId'. No fourth attempt allowed."
            Write-ControllerState -Status 'BLOCKED' -Run $runNumber -Model '' -Checkpoint 'THREE_ATTEMPTS_EXHAUSTED' -Reason $reason -LogPath $latestRunLog
            Send-TerminalNotification -Kind BLOCKED -ApplicationSha ((& git -C $AppRepo rev-parse HEAD).Trim()) -GovernanceSha ((& git -C $GovernanceRepo rev-parse HEAD).Trim()) -Reason $reason -NextAction 'Review the durable P# state and intervene on the unchanged root defect.' -RunLog $latestRunLog
            break
        }

        $model = Get-ModelForAttempt $repairAttempt
        if (-not $model) { throw "No governed model for repair attempt $repairAttempt" }

        $runNumber++
        $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
        $runDir = Join-Path $LocalRoot ("run-{0:D4}-{1}-builder-level{2}" -f $runNumber,$stamp,($repairAttempt + 1))
        New-Item -ItemType Directory -Force -Path $runDir | Out-Null
        $lastMessagePath = Join-Path $runDir 'final.json'
        $stdoutPath = Join-Path $runDir 'stdout.log'
        $stderrPath = Join-Path $runDir 'stderr.log'
        $transcriptPath = Join-Path $runDir 'codex-output.log'
        $promptPath = Join-Path $runDir 'prompt.md'
        $runnerPath = Join-Path $runDir 'invoke-codex.cmd'
        $latestRunLog = $transcriptPath

        $basePrompt = Get-Content -LiteralPath $BuilderPromptPath -Raw
        $runtime = @"
# CONTROLLER RUNTIME CONTEXT

Active P#: $P
Role: Builder
Controller run: $runNumber
Application local path: $AppRepo
Governance local path: $GovernanceRepo
P execution gate: $GatePath
Authorized stage at controller start: $($gate['AUTHORIZED_STAGE'])
Authorized application branch: $($gate['APPLICATION_BRANCH'])
Current model: $model
Current repair_attempt: $repairAttempt
Current root_defect_id: $rootDefectId

CONTROLLER RULES
- Echo repair_attempt exactly: $repairAttempt.
- Return CONTINUE + next_role=Builder whenever more Builder work remains.
- A normal end-of-turn is never a workflow stop.
- When the repaired candidate is fully proven and the next actor is Brad, return checkpoint=READY_FOR_BRAD, loop_action=STOP, next_role=NONE.
- Never launch or hand directly to Betty/Auditor; the controller converts any Auditor handoff into READY_FOR_BRAD.
- Preserve current valid dirty application work. Do not reset/clean/overwrite it.
- CURRENT_STATE.md plus the active P# reopened decision/evidence chain controls routing. Do not route from stale historical PRYSM_AUTORUN_STATE.json.

"@
        ($runtime + "`r`n" + $basePrompt) | Set-Content -LiteralPath $promptPath -Encoding UTF8

        $runner = @"
@echo off
call "$CodexCmdPath" --ask-for-approval never --sandbox danger-full-access --add-dir "$GovernanceRepo" exec --model "$model" -C "$AppRepo" --color never --output-schema "$SchemaPath" --output-last-message "$lastMessagePath" - < "$promptPath" > "$stdoutPath" 2> "$stderrPath"
exit /b %ERRORLEVEL%
"@
        $runner | Set-Content -LiteralPath $runnerPath -Encoding ASCII

        Write-ControllerState -Status 'RUNNING' -Run $runNumber -Model $model -Checkpoint 'BUILDER_RUNNING' -Reason '' -LogPath $transcriptPath
        Write-Host "`n=== $P BUILDER RUN $runNumber | $model | LEVEL $($repairAttempt + 1)/3 | ROOT $rootDefectId ==="
        Write-Host "Logs: $runDir"

        $exitCode = 1
        try {
            & cmd.exe /d /s /c "call `"$runnerPath`""
            $exitCode = $LASTEXITCODE
        } catch {
            $exitCode = 1
            ($_ | Out-String) | Set-Content -LiteralPath $stderrPath -Encoding UTF8
        }

        '=== STDOUT ===' | Set-Content -LiteralPath $transcriptPath -Encoding UTF8
        if (Test-Path -LiteralPath $stdoutPath) { Get-Content -LiteralPath $stdoutPath | Add-Content -LiteralPath $transcriptPath }
        '=== STDERR ===' | Add-Content -LiteralPath $transcriptPath
        if (Test-Path -LiteralPath $stderrPath) { Get-Content -LiteralPath $stderrPath | Add-Content -LiteralPath $transcriptPath }

        if ($exitCode -ne 0 -or -not (Test-Path -LiteralPath $lastMessagePath)) {
            if (Test-UsageLimit -Paths @($stdoutPath,$stderrPath,$transcriptPath)) {
                $reason = 'Codex usage limit reached. No repair escalation consumed.'
                Write-ControllerState -Status 'BLOCKED' -Run $runNumber -Model $model -Checkpoint 'USAGE_LIMIT' -Reason $reason -LogPath $transcriptPath
                Send-TerminalNotification -Kind BLOCKED -ApplicationSha ((& git -C $AppRepo rev-parse HEAD).Trim()) -GovernanceSha ((& git -C $GovernanceRepo rev-parse HEAD).Trim()) -Reason $reason -NextAction 'Resume the same P# controller after the usage allowance resets.' -RunLog $transcriptPath
                break
            }
            $consecutiveFailures++
            Write-Warning "Codex/controller execution failure $consecutiveFailures/$MaxConsecutiveFailures. No repair escalation consumed."
            if ($consecutiveFailures -ge $MaxConsecutiveFailures) { throw "Repeated Codex/controller execution failure. See $transcriptPath" }
            Start-Sleep -Seconds $DelaySeconds
            continue
        }

        try { $result = Get-Content -LiteralPath $lastMessagePath -Raw | ConvertFrom-Json }
        catch {
            $consecutiveFailures++
            Write-Warning "Structured result parse failure $consecutiveFailures/$MaxConsecutiveFailures."
            if ($consecutiveFailures -ge $MaxConsecutiveFailures) { throw "Repeated structured result parse failures. See $transcriptPath" }
            Start-Sleep -Seconds $DelaySeconds
            continue
        }
        $consecutiveFailures = 0

        $returnedRoot = Normalize-RootDefectId ([string]$result.root_defect_id)
        $failureClass = [string]$result.failure_class

        if ($failureClass -eq 'NEW_ROOT_CAUSE' -or ($returnedRoot -ne 'NONE' -and $returnedRoot -ne $rootDefectId)) {
            $rootDefectId = $returnedRoot
            $repairAttempt = 0
        } elseif ($failureClass -eq 'REPAIR_PROOF_FAILED') {
            if ($rootDefectId -eq 'NONE' -and $returnedRoot -ne 'NONE') { $rootDefectId = $returnedRoot }
            $repairAttempt++
        } elseif ($rootDefectId -eq 'NONE' -and $returnedRoot -ne 'NONE') {
            $rootDefectId = $returnedRoot
        }
        Write-Accounting

        $route = Get-Route $result
        Write-Host "Result: $($result.loop_action) | next=$($result.next_role) | checkpoint=$($result.checkpoint) | route=$route"
        Write-Host "Reason: $($result.reason)"

        if ($route -eq 'CONTINUE') {
            Write-ControllerState -Status 'CONTINUING' -Run $runNumber -Model $model -Checkpoint ([string]$result.checkpoint) -Reason ([string]$result.reason) -LogPath $transcriptPath
            Start-Sleep -Seconds $DelaySeconds
            continue
        }

        if ($route -eq 'READY_FOR_BRAD') {
            $appSha = if ([string]::IsNullOrWhiteSpace([string]$result.application_sha)) { (& git -C $AppRepo rev-parse HEAD).Trim() } else { [string]$result.application_sha }
            $govSha = if ([string]::IsNullOrWhiteSpace([string]$result.governance_sha)) { (& git -C $GovernanceRepo rev-parse HEAD).Trim() } else { [string]$result.governance_sha }
            Write-ControllerState -Status 'READY_FOR_BRAD' -Run $runNumber -Model $model -Checkpoint 'READY_FOR_BRAD' -Reason ([string]$result.reason) -LogPath $transcriptPath
            Send-TerminalNotification -Kind READY_FOR_BRAD -ApplicationSha $appSha -GovernanceSha $govSha -Reason ([string]$result.reason) -NextAction 'Brad OUTCOME_REVIEW' -RunLog $transcriptPath
            Write-Host "PRYSM $P READY FOR BRAD"
            break
        }

        $blockReason = [string]$result.reason
        if ([string]::IsNullOrWhiteSpace($blockReason)) { $blockReason = "Controller rejected terminal result: loop_action=$($result.loop_action), next_role=$($result.next_role), checkpoint=$($result.checkpoint)" }
        Write-ControllerState -Status 'BLOCKED' -Run $runNumber -Model $model -Checkpoint ([string]$result.checkpoint) -Reason $blockReason -LogPath $transcriptPath
        Send-TerminalNotification -Kind BLOCKED -ApplicationSha ((& git -C $AppRepo rev-parse HEAD).Trim()) -GovernanceSha ((& git -C $GovernanceRepo rev-parse HEAD).Trim()) -Reason $blockReason -NextAction ([string]$result.next_action) -RunLog $transcriptPath
        Write-Host "PRYSM $P BLOCKED"
        break
    }
} catch {
    $reason = $_.Exception.Message
    try { Write-ControllerState -Status 'CONTROLLER_FAILURE' -Run $runNumber -Model '' -Checkpoint 'CONTROLLER_FAILURE' -Reason $reason -LogPath $latestRunLog } catch {}
    Send-TerminalNotification -Kind CONTROLLER_FAILURE -ApplicationSha ((& git -C $AppRepo rev-parse HEAD 2>$null | Select-Object -First 1).Trim()) -GovernanceSha ((& git -C $GovernanceRepo rev-parse HEAD 2>$null | Select-Object -First 1).Trim()) -Reason $reason -NextAction 'Inspect the latest run log.' -RunLog $latestRunLog
    throw
} finally {
    try { New-Item -ItemType File -Force -Path $HeartbeatStopPath | Out-Null } catch {}
    if ($heartbeatJob) {
        try { Wait-Job $heartbeatJob -Timeout 3 | Out-Null } catch {}
        try { Stop-Job $heartbeatJob -ErrorAction SilentlyContinue | Out-Null } catch {}
        try { Remove-Job $heartbeatJob -Force -ErrorAction SilentlyContinue | Out-Null } catch {}
    }
}
