param(
    [Parameter(Mandatory = $true)]
    [string]$AppRepo,

    [Parameter(Mandatory = $true)]
    [string]$GovernanceRepo,

    [ValidateSet('Builder','Auditor')]
    [string]$StartRole = 'Builder',

    [int]$MaxRuns = 0,
    [int]$DelaySeconds = 3,
    [int]$HeartbeatSeconds = 60,
    [int]$MaxConsecutiveFailures = 3,
    [switch]$RequireRemoteNotification,
    [switch]$PreflightOnly,
    [string]$NotifyWebhookUrl = $env:PRYSM_AUTORUN_NOTIFY_WEBHOOK
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$LegacyAutorunRoot = Join-Path (Split-Path -Parent $ScriptRoot) 'autorun'
$SchemaPath = Join-Path $LegacyAutorunRoot 'PRYSM-AUTORUN-RESULT.schema.json'
$AccountingPath = Join-Path $LegacyAutorunRoot 'PRYSM-AUTORUN-ACCOUNTING.ps1'
$BuilderPromptPath = Join-Path $ScriptRoot 'PRYSM-REPORT-IMPROVEMENT-BUILDER-PROMPT.md'
$AuditorPromptPath = Join-Path $ScriptRoot 'PRYSM-REPORT-IMPROVEMENT-AUDITOR-PROMPT.md'

$ModelLuna = 'gpt-5.6-luna'
$ModelTerra = 'gpt-5.6-terra'
$ModelSol = 'gpt-5.6-sol'

function Resolve-RequiredPath {
    param([string]$Path, [string]$Label)
    if (-not (Test-Path -LiteralPath $Path)) {
        throw "$Label does not exist: $Path"
    }
    return (Resolve-Path -LiteralPath $Path).Path
}

function Assert-GitRepo {
    param([string]$Path, [string]$Label)
    & git -C $Path rev-parse --is-inside-work-tree *> $null
    if ($LASTEXITCODE -ne 0) {
        throw "$Label is not a Git repository/worktree: $Path"
    }
}

function Invoke-CheckedNative {
    param(
        [Parameter(Mandatory = $true)][string]$Command,
        [Parameter(Mandatory = $true)][string[]]$Arguments,
        [string]$Label = $Command
    )
    & $Command @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "$Label failed with exit code $LASTEXITCODE"
    }
}

function Resolve-CodexCmd {
    $cmd = Get-Command codex.cmd -ErrorAction SilentlyContinue
    if ($cmd -and (Test-Path -LiteralPath $cmd.Source)) {
        return $cmd.Source
    }

    $generic = Get-Command codex -ErrorAction SilentlyContinue
    if ($generic -and $generic.Source) {
        $sibling = [System.IO.Path]::ChangeExtension($generic.Source, '.cmd')
        if (Test-Path -LiteralPath $sibling) {
            return $sibling
        }
    }

    throw 'Codex CLI Windows command shim (codex.cmd) was not found on PATH.'
}

function Get-PathLockName {
    param([string]$Value)
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($Value.ToLowerInvariant())
    $sha = [System.Security.Cryptography.SHA256]::Create()
    try {
        $hash = $sha.ComputeHash($bytes)
    } finally {
        $sha.Dispose()
    }
    return (($hash | ForEach-Object { $_.ToString('x2') }) -join '').Substring(0,16)
}

function Get-PromptPath {
    param([string]$Role)
    if ($Role -eq 'Auditor') { return $AuditorPromptPath }
    return $BuilderPromptPath
}

function Get-ModelForRepairAttempt {
    param([int]$RepairAttempt)
    switch ($RepairAttempt) {
        0 { return $ModelLuna }
        1 { return $ModelTerra }
        2 { return $ModelSol }
        default { return $null }
    }
}

function Get-AutorunState {
    param([string]$StatePath)
    if (-not (Test-Path -LiteralPath $StatePath)) { return $null }
    try {
        return (Get-Content -LiteralPath $StatePath -Raw | ConvertFrom-Json)
    } catch {
        return $null
    }
}

function Get-InitialRepairAttempt {
    param([string]$StatePath)
    $state = Get-AutorunState $StatePath
    if (-not $state) { return 0 }
    try {
        $attempt = [int]$state.repairAttempt
        if ($attempt -lt 0) { return 0 }
        if ($attempt -gt 3) { return 3 }
        return $attempt
    } catch {
        return 0
    }
}

function Get-InitialRootDefectId {
    param([string]$StatePath)
    $state = Get-AutorunState $StatePath
    if (-not $state -or $state.PSObject.Properties.Name -notcontains 'rootDefectId') {
        return 'NONE'
    }
    return (Normalize-PrysmRootDefectId ([string]$state.rootDefectId))
}

function Get-CurrentTranche {
    param([string]$StatePath)
    $state = Get-AutorunState $StatePath
    if (-not $state) { return 'UNKNOWN' }
    try {
        if ($state.currentTranche) { return [string]$state.currentTranche }
    } catch {}
    return 'UNKNOWN'
}

function Test-UsageLimitFailure {
    param([string[]]$Paths)
    foreach ($path in $Paths) {
        if (-not (Test-Path -LiteralPath $path)) { continue }
        $text = Get-Content -LiteralPath $path -Raw -ErrorAction SilentlyContinue
        if ($text -match '(?i)hit your usage limit|usage limit.*try again|usage limit.*reset') {
            return $true
        }
    }
    return $false
}

function Send-LocalNotification {
    param(
        [string]$Title,
        [string]$Message,
        [ValidateSet('Info','Warning','Error')][string]$Level = 'Info'
    )

    try {
        Add-Type -AssemblyName System.Windows.Forms -ErrorAction Stop
        switch ($Level) {
            'Error'   { [System.Media.SystemSounds]::Hand.Play() }
            'Warning' { [System.Media.SystemSounds]::Exclamation.Play() }
            default   { [System.Media.SystemSounds]::Asterisk.Play() }
        }
        $icon = switch ($Level) {
            'Error'   { [System.Windows.Forms.MessageBoxIcon]::Error }
            'Warning' { [System.Windows.Forms.MessageBoxIcon]::Warning }
            default   { [System.Windows.Forms.MessageBoxIcon]::Information }
        }
        [System.Windows.Forms.MessageBox]::Show(
            $Message,
            $Title,
            [System.Windows.Forms.MessageBoxButtons]::OK,
            $icon
        ) | Out-Null
        return
    } catch {}

    try {
        & msg.exe $env:USERNAME "$Title`n$Message" 2>$null | Out-Null
    } catch {}
}

function Send-RemoteNotification {
    param(
        [string]$WebhookUrl,
        [string]$Event,
        [string]$Level,
        [string]$Message,
        [string]$Role,
        [int]$RunNumber,
        [string]$Tranche,
        [string]$ApplicationSha,
        [string]$GovernanceSha
    )

    if ([string]::IsNullOrWhiteSpace($WebhookUrl)) { return $false }

    $payload = [ordered]@{
        source = 'PRYSM-Autorun-Report-Improvement'
        project = 'PRYSM'
        workflow = 'GCU_REPORT_IMPROVEMENT'
        event = $Event
        severity = $Level
        timestamp = (Get-Date -Format o)
        message = $Message
        role = $Role
        run = $RunNumber
        tranche = $Tranche
        applicationSha = $ApplicationSha
        governanceSha = $GovernanceSha
        controllerPid = $PID
    }

    try {
        Invoke-RestMethod -Method Post -Uri $WebhookUrl -ContentType 'application/json' -Body ($payload | ConvertTo-Json -Depth 6) -TimeoutSec 15 | Out-Null
        return $true
    } catch {
        Write-Warning "Remote notification failed: $($_.Exception.Message)"
        return $false
    }
}

function Get-GitHeadSafe {
    param([string]$Path)
    try {
        return (& git -C $Path rev-parse HEAD 2>$null | Select-Object -First 1).Trim()
    } catch {
        return 'UNKNOWN'
    }
}

foreach ($requiredFile in @($SchemaPath,$AccountingPath,$BuilderPromptPath,$AuditorPromptPath)) {
    if (-not (Test-Path -LiteralPath $requiredFile)) {
        throw "Missing report-improvement autorun contract file: $requiredFile"
    }
}

. $AccountingPath

$AppRepo = Resolve-RequiredPath $AppRepo 'Application repository'
$GovernanceRepo = Resolve-RequiredPath $GovernanceRepo 'Governance repository'
$AutorunStatePath = Join-Path $GovernanceRepo 'PRYSM_AUTORUN_STATE.json'
Assert-GitRepo $AppRepo 'Application repository'
Assert-GitRepo $GovernanceRepo 'Governance repository'
$CodexCmdPath = Resolve-CodexCmd

$LocalRoot = if ($env:LOCALAPPDATA) {
    Join-Path $env:LOCALAPPDATA 'PRYSM-Autorun-Report-Improvement'
} else {
    Join-Path $env:TEMP 'PRYSM-Autorun-Report-Improvement'
}
New-Item -ItemType Directory -Force -Path $LocalRoot | Out-Null

$HeartbeatPath = Join-Path $LocalRoot 'heartbeat.json'
$ControllerStatePath = Join-Path $LocalRoot 'controller-state.json'
$HeartbeatStopPath = Join-Path $LocalRoot 'heartbeat.stop'

if ($HeartbeatSeconds -lt 15) {
    throw 'HeartbeatSeconds must be at least 15 seconds.'
}

if ($PreflightOnly) {
    Write-Host ''
    Write-Host 'PRYSM REPORT IMPROVEMENT AUTORUN PREFLIGHT'
    Write-Host '=========================================='

    Invoke-CheckedNative -Command 'git' -Arguments @('--version') -Label 'Git version check'
    $versionLine = (& cmd.exe /d /s /c "call `"$CodexCmdPath`" --version" 2>&1 | Out-String).Trim()
    if ($LASTEXITCODE -ne 0) { throw 'Codex version check failed.' }
    Write-Host $versionLine

    Write-Host ''
    Write-Host 'Application:'
    Invoke-CheckedNative -Command 'git' -Arguments @('-C',$AppRepo,'status','--short') -Label 'Application status'
    Invoke-CheckedNative -Command 'git' -Arguments @('-C',$AppRepo,'branch','--show-current') -Label 'Application branch'
    Invoke-CheckedNative -Command 'git' -Arguments @('-C',$AppRepo,'rev-parse','HEAD') -Label 'Application HEAD'

    Write-Host ''
    Write-Host 'Governance:'
    Invoke-CheckedNative -Command 'git' -Arguments @('-C',$GovernanceRepo,'status','--short') -Label 'Governance status'
    Invoke-CheckedNative -Command 'git' -Arguments @('-C',$GovernanceRepo,'branch','--show-current') -Label 'Governance branch'
    Invoke-CheckedNative -Command 'git' -Arguments @('-C',$GovernanceRepo,'rev-parse','HEAD') -Label 'Governance HEAD'

    Write-Host ''
    Write-Host 'Checking GitHub connectivity (read-only)...'
    Invoke-CheckedNative -Command 'git' -Arguments @('-C',$AppRepo,'ls-remote','--exit-code','origin','HEAD') -Label 'Application origin'
    Invoke-CheckedNative -Command 'git' -Arguments @('-C',$GovernanceRepo,'ls-remote','--exit-code','origin','HEAD') -Label 'Governance origin'

    if ($RequireRemoteNotification -and [string]::IsNullOrWhiteSpace($NotifyWebhookUrl)) {
        throw 'Remote notification is required but PRYSM_AUTORUN_NOTIFY_WEBHOOK is not configured.'
    }

    Write-Host ''
    Write-Host "Heartbeat: $HeartbeatPath"
    Write-Host "Heartbeat interval: $HeartbeatSeconds seconds"
    if ([string]::IsNullOrWhiteSpace($NotifyWebhookUrl)) {
        Write-Host 'Remote notification: NOT CONFIGURED (local Windows terminal alerts only)'
    } else {
        Write-Host 'Remote notification: CONFIGURED via PRYSM_AUTORUN_NOTIFY_WEBHOOK'
    }
    Write-Host 'Protected boundaries: no main merge, deploy, Railway/Vercel/AWS production mutation, paid/live provider/model calls, or fresh production audit.'
    Write-Host 'PREFLIGHT PASS'
    return
}

$SharedLockRoot = if ($env:LOCALAPPDATA) {
    Join-Path $env:LOCALAPPDATA 'PRYSM-Autorun-Locks'
} else {
    Join-Path $env:TEMP 'PRYSM-Autorun-Locks'
}
New-Item -ItemType Directory -Force -Path $SharedLockRoot | Out-Null

$AppLockPath = Join-Path $SharedLockRoot ("app-{0}.lock" -f (Get-PathLockName $AppRepo))
$GovernanceLockPath = Join-Path $SharedLockRoot ("governance-{0}.lock" -f (Get-PathLockName $GovernanceRepo))
foreach ($lockPath in @($AppLockPath,$GovernanceLockPath)) {
    if (Test-Path -LiteralPath $lockPath) {
        $existing = Get-Content -LiteralPath $lockPath -Raw -ErrorAction SilentlyContinue
        throw "Autorun resource lock already exists. Another PRYSM controller may be using this repository.`nLock: $lockPath`n$existing"
    }
}

if ($RequireRemoteNotification -and [string]::IsNullOrWhiteSpace($NotifyWebhookUrl)) {
    throw 'Remote notification is required but PRYSM_AUTORUN_NOTIFY_WEBHOOK is not configured.'
}

$CurrentRole = $StartRole
$CurrentRepairAttempt = Get-InitialRepairAttempt $AutorunStatePath
$CurrentRootDefectId = Get-InitialRootDefectId $AutorunStatePath
$runNumber = 0
$consecutiveFailures = 0
$terminalStatus = $null
$terminalMessage = $null
$terminalLevel = 'Info'
$latestRunDir = ''
$heartbeatJob = $null

$lockBody = @"
PID=$PID
Started=$(Get-Date -Format o)
Workflow=GCU_REPORT_IMPROVEMENT
StartRole=$StartRole
AppRepo=$AppRepo
GovernanceRepo=$GovernanceRepo
"@
$lockBody | Set-Content -LiteralPath $AppLockPath -Encoding ASCII
$lockBody | Set-Content -LiteralPath $GovernanceLockPath -Encoding ASCII
Remove-Item -LiteralPath $HeartbeatStopPath -Force -ErrorAction SilentlyContinue

function Write-ControllerState {
    param(
        [string]$Status,
        [string]$Role,
        [int]$Run,
        [string]$Model,
        [string]$Tranche,
        [string]$Checkpoint,
        [string]$LatestLog
    )
    $state = [ordered]@{
        status = $Status
        updatedAt = (Get-Date -Format o)
        controllerPid = $PID
        role = $Role
        run = $Run
        model = $Model
        tranche = $Tranche
        checkpoint = $Checkpoint
        repairAttempt = $CurrentRepairAttempt
        rootDefectId = $CurrentRootDefectId
        latestRunLog = $LatestLog
    }
    $state | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath $ControllerStatePath -Encoding UTF8
}

Write-ControllerState -Status 'STARTING' -Role $CurrentRole -Run 0 -Model '' -Tranche (Get-CurrentTranche $AutorunStatePath) -Checkpoint 'STARTING' -LatestLog ''

$heartbeatJob = Start-Job -ArgumentList @($HeartbeatPath,$HeartbeatStopPath,$ControllerStatePath,$AutorunStatePath,$AppRepo,$GovernanceRepo,$PID,$HeartbeatSeconds) -ScriptBlock {
    param($HeartbeatPath,$StopPath,$ControllerStatePath,$AutorunStatePath,$AppRepo,$GovernanceRepo,$ParentPid,$Seconds)
    while (-not (Test-Path -LiteralPath $StopPath)) {
        try {
            $controller = $null
            if (Test-Path -LiteralPath $ControllerStatePath) {
                $controller = Get-Content -LiteralPath $ControllerStatePath -Raw | ConvertFrom-Json
            }
            $govState = $null
            if (Test-Path -LiteralPath $AutorunStatePath) {
                try { $govState = Get-Content -LiteralPath $AutorunStatePath -Raw | ConvertFrom-Json } catch {}
            }
            $appSha = try { (& git -C $AppRepo rev-parse HEAD 2>$null | Select-Object -First 1).Trim() } catch { 'UNKNOWN' }
            $govSha = try { (& git -C $GovernanceRepo rev-parse HEAD 2>$null | Select-Object -First 1).Trim() } catch { 'UNKNOWN' }
            $hb = [ordered]@{
                status = if ($controller) { [string]$controller.status } else { 'RUNNING' }
                timestamp = (Get-Date -Format o)
                controllerPid = $ParentPid
                run = if ($controller) { $controller.run } else { 0 }
                role = if ($controller) { $controller.role } else { 'UNKNOWN' }
                model = if ($controller) { $controller.model } else { '' }
                tranche = if ($controller -and $controller.tranche) { $controller.tranche } elseif ($govState -and $govState.currentTranche) { $govState.currentTranche } else { 'UNKNOWN' }
                checkpoint = if ($controller) { $controller.checkpoint } else { '' }
                repairAttempt = if ($controller) { $controller.repairAttempt } elseif ($govState) { $govState.repairAttempt } else { 0 }
                rootDefectId = if ($controller) { $controller.rootDefectId } elseif ($govState) { $govState.rootDefectId } else { 'NONE' }
                applicationSha = $appSha
                governanceSha = $govSha
                latestRunLog = if ($controller) { $controller.latestRunLog } else { '' }
            }
            $tmp = "$HeartbeatPath.tmp"
            $hb | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath $tmp -Encoding UTF8
            Move-Item -LiteralPath $tmp -Destination $HeartbeatPath -Force
        } catch {}
        Start-Sleep -Seconds $Seconds
    }
}

try {
    Write-Host ''
    Write-Host 'PRYSM GCU REPORT IMPROVEMENT AUTORUN STARTED'
    Write-Host "Application: $AppRepo"
    Write-Host "Governance:  $GovernanceRepo"
    Write-Host "Heartbeat:   $HeartbeatPath"
    Write-Host "Logs:        $LocalRoot"
    Write-Host "Start role:  $CurrentRole"
    Write-Host "Root defect: $CurrentRootDefectId"
    Write-Host "Repair level: $($CurrentRepairAttempt + 1) of 3"
    if ($MaxRuns -eq 0) { Write-Host 'Run limit:   unlimited' } else { Write-Host "Run limit:   $MaxRuns" }

    while ($true) {
        if ($MaxRuns -gt 0 -and $runNumber -ge $MaxRuns) {
            $terminalStatus = 'STOP'
            $terminalMessage = "Safety run limit reached: $MaxRuns runs."
            $terminalLevel = 'Warning'
            break
        }

        if ($CurrentRepairAttempt -ge 3) {
            $terminalStatus = 'BLOCKED'
            $terminalMessage = "Three same-root repair levels are exhausted for '$CurrentRootDefectId'. No fourth autonomous attempt is allowed."
            $terminalLevel = 'Error'
            break
        }

        $CurrentModel = Get-ModelForRepairAttempt $CurrentRepairAttempt
        if (-not $CurrentModel) { throw "No governed model exists for repair attempt $CurrentRepairAttempt" }

        $runNumber++
        $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
        $runDir = Join-Path $LocalRoot ("run-{0:D4}-{1}-{2}-level{3}" -f $runNumber,$stamp,$CurrentRole.ToLowerInvariant(),($CurrentRepairAttempt + 1))
        New-Item -ItemType Directory -Force -Path $runDir | Out-Null
        $latestRunDir = $runDir

        $LastMessagePath = Join-Path $runDir 'final.json'
        $StdoutPath = Join-Path $runDir 'codex-stdout.log'
        $StderrPath = Join-Path $runDir 'codex-stderr.log'
        $TranscriptPath = Join-Path $runDir 'codex-output.log'
        $RunPromptPath = Join-Path $runDir 'prompt.md'
        $RunnerCmdPath = Join-Path $runDir 'invoke-codex.cmd'

        $CurrentTranche = Get-CurrentTranche $AutorunStatePath
        Write-ControllerState -Status 'RUNNING' -Role $CurrentRole -Run $runNumber -Model $CurrentModel -Tranche $CurrentTranche -Checkpoint 'CODEX_RUNNING' -LatestLog $runDir

        $PromptPath = Get-PromptPath $CurrentRole
        $basePrompt = Get-Content -LiteralPath $PromptPath -Raw
        $runtimeHeader = @"
# CONTROLLER RUNTIME CONTEXT

Project: PRYSM GCU Report Improvement
Role: $CurrentRole
Controller run: $runNumber
Application local path: $AppRepo
Governance local path: $GovernanceRepo
Invocation: $(Get-Date -Format o)
Current model: $CurrentModel
Current repair index: $CurrentRepairAttempt
Current root defect id: $CurrentRootDefectId
Current authoritative tranche: $CurrentTranche
Dedicated application repair branch: repair/prysm-report-improvement
Trusted pre-GCU rollback SHA: 9b9e85d00a0d8b65a5ba6cad37583aa79151b15e

The controller owns model escalation. Echo repair_attempt=$CurrentRepairAttempt exactly.
A same-root actual repair/proof failure uses REPAIR_PROOF_FAILED.
A materially new root uses NEW_ROOT_CAUSE with a new stable root_defect_id.
Proof setup failures and external/protocol failures do not consume repair escalation.
After Auditor PASS, the controller resets repair accounting for the next workstream.

The owner authorized unattended repository-controlled progression through P0-P10. Do not stop for ordinary tranche approval. Stop only at the protected external/authorization or safety boundaries in the governing unattended decision.

"@
        ($runtimeHeader + "`r`n" + $basePrompt) | Set-Content -LiteralPath $RunPromptPath -Encoding UTF8

        $runner = @"
@echo off
call "$CodexCmdPath" --ask-for-approval never --sandbox danger-full-access --add-dir "$GovernanceRepo" exec --model "$CurrentModel" -C "$AppRepo" --color never --output-schema "$SchemaPath" --output-last-message "$LastMessagePath" - < "$RunPromptPath" > "$StdoutPath" 2> "$StderrPath"
exit /b %ERRORLEVEL%
"@
        $runner | Set-Content -LiteralPath $RunnerCmdPath -Encoding ASCII

        Write-Host ''
        Write-Host "PRYSM REPORT IMPROVEMENT - RUN $runNumber - $CurrentRole - $CurrentTranche"
        Write-Host "Model: $CurrentModel | Level $($CurrentRepairAttempt + 1)/3 | Root: $CurrentRootDefectId"
        Write-Host "Run logs: $runDir"

        $exitCode = 1
        try {
            & cmd.exe /d /s /c "call `"$RunnerCmdPath`""
            $exitCode = $LASTEXITCODE
        } catch {
            $exitCode = 1
            ($_ | Out-String) | Set-Content -LiteralPath $StderrPath -Encoding UTF8
        }

        '=== STDOUT ===' | Set-Content -LiteralPath $TranscriptPath -Encoding UTF8
        if (Test-Path -LiteralPath $StdoutPath) { Get-Content -LiteralPath $StdoutPath | Add-Content -LiteralPath $TranscriptPath }
        '=== STDERR ===' | Add-Content -LiteralPath $TranscriptPath
        if (Test-Path -LiteralPath $StderrPath) { Get-Content -LiteralPath $StderrPath | Add-Content -LiteralPath $TranscriptPath }

        if ($exitCode -ne 0 -or -not (Test-Path -LiteralPath $LastMessagePath)) {
            if (Test-UsageLimitFailure -Paths @($StdoutPath,$StderrPath,$TranscriptPath)) {
                $terminalStatus = 'STOP'
                $terminalMessage = "Codex usage limit reached. No repair escalation was consumed. Resume the same controller after allowance resets. Logs: $runDir"
                $terminalLevel = 'Warning'
                break
            }

            $consecutiveFailures++
            Write-Warning "Codex/controller execution failure $consecutiveFailures/$MaxConsecutiveFailures. No repair escalation consumed."
            if ($consecutiveFailures -ge $MaxConsecutiveFailures) {
                throw "Stopping after $consecutiveFailures consecutive Codex/controller execution failures."
            }
            Start-Sleep -Seconds $DelaySeconds
            continue
        }

        try {
            $result = Get-Content -LiteralPath $LastMessagePath -Raw | ConvertFrom-Json
        } catch {
            $consecutiveFailures++
            if ($consecutiveFailures -ge $MaxConsecutiveFailures) { throw 'Repeated structured-result parse failures.' }
            Start-Sleep -Seconds $DelaySeconds
            continue
        }

        $consecutiveFailures = 0
        $resultRootDefectId = Normalize-PrysmRootDefectId ([string]$result.root_defect_id)
        $failureClass = [string]$result.failure_class
        $isAuditPass = ($result.role -eq 'Auditor' -and $result.checkpoint -eq 'PASS' -and [int]$result.material_defects -eq 0)

        Write-ControllerState -Status 'RUNNING' -Role ([string]$result.role) -Run $runNumber -Model $CurrentModel -Tranche ([string]$result.tranche) -Checkpoint ([string]$result.checkpoint) -LatestLog $runDir

        Write-Host "Action: $($result.loop_action) | Next role: $($result.next_role) | Checkpoint: $($result.checkpoint) | Defects: $($result.material_defects)"
        Write-Host "App SHA: $($result.application_sha) | Governance SHA: $($result.governance_sha)"
        Write-Host "Reason: $($result.reason)"
        Write-Host "Next: $($result.next_action)"

        switch ($result.loop_action) {
            'CONTINUE' {
                $accounting = Resolve-PrysmRepairAccounting `
                    -CurrentRepairAttempt $CurrentRepairAttempt `
                    -CurrentRootDefectId $CurrentRootDefectId `
                    -ResultRootDefectId $resultRootDefectId `
                    -FailureClass $failureClass `
                    -AuditPassed $isAuditPass

                if ([int]$accounting.RepairAttempt -ge 3) {
                    $terminalStatus = 'BLOCKED'
                    $terminalMessage = "Three governed repair levels are exhausted for root '$($accounting.RootDefectId)'. Tranche: $($result.tranche). Reason: $($result.reason). Next: $($result.next_action)"
                    $terminalLevel = 'Error'
                    break
                }

                $CurrentRepairAttempt = [int]$accounting.RepairAttempt
                $CurrentRootDefectId = [string]$accounting.RootDefectId
                if ($result.next_role -eq 'Builder' -or $result.next_role -eq 'Auditor') {
                    $CurrentRole = [string]$result.next_role
                }
                Start-Sleep -Seconds $DelaySeconds
                continue
            }
            'STOP' {
                $terminalStatus = 'STOP'
                $terminalMessage = "PRYSM report-improvement autorun reached a protected external boundary. Tranche: $($result.tranche). Checkpoint: $($result.checkpoint). Next: $($result.next_action)"
                $terminalLevel = 'Warning'
                break
            }
            'BLOCKED' {
                if ($failureClass -eq 'NEW_ROOT_CAUSE' -and $resultRootDefectId -ne 'NONE' -and $resultRootDefectId -ne $CurrentRootDefectId) {
                    $CurrentRootDefectId = $resultRootDefectId
                    $CurrentRepairAttempt = 0
                    $CurrentRole = 'Builder'
                    Start-Sleep -Seconds $DelaySeconds
                    continue
                }
                $terminalStatus = 'BLOCKED'
                $terminalMessage = "PRYSM report-improvement autorun is blocked. Tranche: $($result.tranche). Root: $resultRootDefectId. Reason: $($result.reason). Next: $($result.next_action)"
                $terminalLevel = 'Error'
                break
            }
            'COMPLETE' {
                $terminalStatus = 'COMPLETE'
                $terminalMessage = "PRYSM repository-controlled report improvement is complete. Application SHA: $($result.application_sha). Checkpoint: $($result.checkpoint). Next: $($result.next_action)"
                $terminalLevel = 'Info'
                break
            }
            default {
                throw "Unknown loop_action: $($result.loop_action)"
            }
        }

        if ($terminalStatus) { break }
    }
} catch {
    $terminalStatus = 'BLOCKED'
    $terminalMessage = "PRYSM report-improvement autorun controller failed: $($_.Exception.Message)"
    $terminalLevel = 'Error'
    Write-Error $_
} finally {
    $finalTranche = Get-CurrentTranche $AutorunStatePath
    $finalAppSha = Get-GitHeadSafe $AppRepo
    $finalGovSha = Get-GitHeadSafe $GovernanceRepo

    if ($terminalStatus) {
        Write-ControllerState -Status $terminalStatus -Role $CurrentRole -Run $runNumber -Model '' -Tranche $finalTranche -Checkpoint $terminalStatus -LatestLog $latestRunDir
    }

    try {
        $terminalHeartbeat = [ordered]@{
            status = if ($terminalStatus) { $terminalStatus } else { 'STOPPED' }
            timestamp = (Get-Date -Format o)
            controllerPid = $PID
            run = $runNumber
            role = $CurrentRole
            tranche = $finalTranche
            repairAttempt = $CurrentRepairAttempt
            rootDefectId = $CurrentRootDefectId
            applicationSha = $finalAppSha
            governanceSha = $finalGovSha
            latestRunLog = $latestRunDir
        }
        $terminalHeartbeat | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath $HeartbeatPath -Encoding UTF8
    } catch {}

    New-Item -ItemType File -Force -Path $HeartbeatStopPath | Out-Null
    if ($heartbeatJob) {
        Stop-Job -Job $heartbeatJob -ErrorAction SilentlyContinue
        Remove-Job -Job $heartbeatJob -Force -ErrorAction SilentlyContinue
    }

    foreach ($lockPath in @($AppLockPath,$GovernanceLockPath)) {
        Remove-Item -LiteralPath $lockPath -Force -ErrorAction SilentlyContinue
    }

    if ($terminalStatus) {
        $remoteSent = Send-RemoteNotification `
            -WebhookUrl $NotifyWebhookUrl `
            -Event $terminalStatus `
            -Level $terminalLevel `
            -Message $terminalMessage `
            -Role $CurrentRole `
            -RunNumber $runNumber `
            -Tranche $finalTranche `
            -ApplicationSha $finalAppSha `
            -GovernanceSha $finalGovSha

        if ($RequireRemoteNotification -and -not $remoteSent) {
            Write-Warning 'Required remote notification could not be delivered. Local notification will still be attempted.'
        }
        Send-LocalNotification -Title "PRYSM Report Autorun - $terminalStatus" -Message $terminalMessage -Level $terminalLevel
    }
}
