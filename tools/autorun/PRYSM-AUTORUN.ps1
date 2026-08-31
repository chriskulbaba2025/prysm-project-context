param(
    [Parameter(Mandatory = $true)]
    [string]$AppRepo,

    [Parameter(Mandatory = $true)]
    [string]$GovernanceRepo,

    [ValidateSet('Builder','Auditor')]
    [string]$StartRole = 'Builder',

    [int]$MaxRuns = 0,
    [int]$DelaySeconds = 3,
    [int]$MaxConsecutiveFailures = 3,
    [switch]$PreflightOnly
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$SchemaPath = Join-Path $ScriptRoot 'PRYSM-AUTORUN-RESULT.schema.json'
$AccountingPath = Join-Path $ScriptRoot 'PRYSM-AUTORUN-ACCOUNTING.ps1'
$BuilderPromptPath = Join-Path $ScriptRoot 'PRYSM-BUILDER-AUTORUN-PROMPT.md'
$AuditorPromptPath = Join-Path $ScriptRoot 'PRYSM-AUDITOR-AUTORUN-PROMPT.md'
$AutorunStatePath = Join-Path $GovernanceRepo 'PRYSM_AUTORUN_STATE.json'

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

function Get-InitialRepairAttempt {
    if (-not (Test-Path -LiteralPath $AutorunStatePath)) {
        return 0
    }

    try {
        $state = Get-Content -LiteralPath $AutorunStatePath -Raw | ConvertFrom-Json
        $attempt = [int]$state.repairAttempt
        if ($attempt -lt 0) { return 0 }
        if ($attempt -gt 3) { return 3 }
        return $attempt
    } catch {
        Write-Warning 'Could not read repairAttempt from PRYSM_AUTORUN_STATE.json; starting at Luna / level 1.'
        return 0
    }
}

function Get-InitialRootDefectId {
    if (-not (Test-Path -LiteralPath $AutorunStatePath)) {
        return 'NONE'
    }

    try {
        $state = Get-Content -LiteralPath $AutorunStatePath -Raw | ConvertFrom-Json
        if ($state.PSObject.Properties.Name -notcontains 'rootDefectId') {
            return 'NONE'
        }
        return (Normalize-PrysmRootDefectId ([string]$state.rootDefectId))
    } catch {
        Write-Warning 'Could not read rootDefectId from PRYSM_AUTORUN_STATE.json; using NONE.'
        return 'NONE'
    }
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

function Send-AutorunNotification {
    param(
        [Parameter(Mandatory = $true)][string]$Title,
        [Parameter(Mandatory = $true)][string]$Message,
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
    } catch {
        # Fall through to msg.exe when WinForms is unavailable.
    }

    try {
        $msg = "$Title`n$Message"
        & msg.exe $env:USERNAME $msg 2>$null | Out-Null
    } catch {
        # Notification failure must never break the governed loop.
    }
}

foreach ($requiredFile in @($SchemaPath,$AccountingPath,$BuilderPromptPath,$AuditorPromptPath)) {
    if (-not (Test-Path -LiteralPath $requiredFile)) {
        throw "Missing autorun contract file: $requiredFile"
    }
}

. $AccountingPath

$AppRepo = Resolve-RequiredPath $AppRepo 'Application repository'
$GovernanceRepo = Resolve-RequiredPath $GovernanceRepo 'Governance repository'
$AutorunStatePath = Join-Path $GovernanceRepo 'PRYSM_AUTORUN_STATE.json'
Assert-GitRepo $AppRepo 'Application repository'
Assert-GitRepo $GovernanceRepo 'Governance repository'
$CodexCmdPath = Resolve-CodexCmd

if ($PreflightOnly) {
    Write-Host ''
    Write-Host 'PRYSM PRODUCTION CLOSURE AUTORUN PREFLIGHT'
    Write-Host '========================================='

    Invoke-CheckedNative -Command 'git' -Arguments @('--version') -Label 'Git version check'

    Write-Host "Codex shim: $CodexCmdPath"
    $versionLine = (& cmd.exe /d /s /c "call `"$CodexCmdPath`" --version" 2>&1 | Out-String).Trim()
    if ($LASTEXITCODE -ne 0) {
        throw "Codex version check failed with exit code $LASTEXITCODE"
    }
    Write-Host $versionLine

    $rootHelp = (& cmd.exe /d /s /c "call `"$CodexCmdPath`" --help" 2>&1 | Out-String)
    if ($LASTEXITCODE -ne 0) {
        throw "Codex root help check failed with exit code $LASTEXITCODE"
    }

    $execHelp = (& cmd.exe /d /s /c "call `"$CodexCmdPath`" exec --help" 2>&1 | Out-String)
    if ($LASTEXITCODE -ne 0) {
        throw "Codex exec help check failed with exit code $LASTEXITCODE"
    }

    foreach ($required in @('--add-dir','--sandbox','--ask-for-approval')) {
        if ($rootHelp -notmatch [regex]::Escape($required) -and $execHelp -notmatch [regex]::Escape($required)) {
            throw "Installed Codex CLI does not advertise required option: $required"
        }
    }

    foreach ($required in @('--output-schema','--output-last-message','--model')) {
        if ($rootHelp -notmatch [regex]::Escape($required) -and $execHelp -notmatch [regex]::Escape($required)) {
            throw "Installed Codex CLI does not advertise required option: $required"
        }
    }

    if ($rootHelp -notmatch 'danger-full-access' -and $execHelp -notmatch 'danger-full-access') {
        throw 'Installed Codex CLI does not advertise danger-full-access, required for governed Git metadata writes on Windows.'
    }

    Write-Host ''
    Write-Host 'Model escalation policy:'
    Write-Host "  Level 1: $ModelLuna (default / cheapest current GPT-5.6 Codex option)"
    Write-Host "  Level 2: $ModelTerra (same root defect only after first failed repair proof)"
    Write-Host "  Level 3: $ModelSol (same root defect only after second failed repair proof)"
    Write-Host '  Root-defect identity change: reset automatically to Level 1 / Luna.'
    Write-Host '  Third same-root repair failure: STOP/BLOCKED + Windows alert; no fourth autonomous attempt.'
    Write-Host '  Successful audited checkpoint: reset next work to Level 1 / Luna and root NONE.'
    Write-Host '  Usage-limit/controller failures do not consume an escalation level.'
    Write-Host '  Codex repair_attempt is echo-only; controller computes the next level.'

    Write-Host ''
    Write-Host 'Application Git state (dirty is allowed and expected initially):'
    Invoke-CheckedNative -Command 'git' -Arguments @('-C',$AppRepo,'status','--short') -Label 'Application status'
    Invoke-CheckedNative -Command 'git' -Arguments @('-C',$AppRepo,'branch','--show-current') -Label 'Application branch'
    Invoke-CheckedNative -Command 'git' -Arguments @('-C',$AppRepo,'rev-parse','HEAD') -Label 'Application HEAD'

    Write-Host ''
    Write-Host 'Governance Git state:'
    Invoke-CheckedNative -Command 'git' -Arguments @('-C',$GovernanceRepo,'status','--short') -Label 'Governance status'
    Invoke-CheckedNative -Command 'git' -Arguments @('-C',$GovernanceRepo,'branch','--show-current') -Label 'Governance branch'
    Invoke-CheckedNative -Command 'git' -Arguments @('-C',$GovernanceRepo,'rev-parse','HEAD') -Label 'Governance HEAD'

    Write-Host ''
    Write-Host 'Checking application GitHub connectivity (read-only)...'
    Invoke-CheckedNative -Command 'git' -Arguments @('-C',$AppRepo,'ls-remote','--exit-code','origin','HEAD') -Label 'Application origin'

    Write-Host ''
    Write-Host 'Checking governance GitHub connectivity (read-only)...'
    Invoke-CheckedNative -Command 'git' -Arguments @('-C',$GovernanceRepo,'ls-remote','--exit-code','origin','HEAD') -Label 'Governance origin'

    Write-Host ''
    Write-Host 'Runtime sandbox: danger-full-access'
    Write-Host 'Reason: governed Git commit/fetch/push requires .git metadata writes that workspace-write can block on Windows.'
    Write-Host 'Application safety: autonomous work is restricted by prompt to repair/prysm-production-closure; no main merge/deploy/live paid audit.'
    Write-Host 'PREFLIGHT PASS'
    return
}

$LocalRoot = if ($env:LOCALAPPDATA) {
    Join-Path $env:LOCALAPPDATA 'PRYSM-Autorun-Production-Closure'
} else {
    Join-Path $env:TEMP 'PRYSM-Autorun-Production-Closure'
}
New-Item -ItemType Directory -Force -Path $LocalRoot | Out-Null

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
        throw "Autorun resource lock already exists. Another PRYSM controller may be using this local repository.`nLock: $lockPath`n$existing"
    }
}

$CurrentRole = $StartRole
$CurrentRepairAttempt = Get-InitialRepairAttempt
$CurrentRootDefectId = Get-InitialRootDefectId
$lockBody = @"
PID=$PID
Started=$(Get-Date -Format o)
StartRole=$StartRole
AppRepo=$AppRepo
GovernanceRepo=$GovernanceRepo
"@
$lockBody | Set-Content -LiteralPath $AppLockPath -Encoding ASCII
$lockBody | Set-Content -LiteralPath $GovernanceLockPath -Encoding ASCII

$runNumber = 0
$consecutiveFailures = 0
$terminalStatus = $null
$terminalMessage = $null
$terminalLevel = 'Info'

try {
    Write-Host ''
    Write-Host 'PRYSM PRODUCTION CLOSURE AUTORUN STARTED'
    Write-Host "Application: $AppRepo"
    Write-Host "Governance:  $GovernanceRepo"
    Write-Host "Codex shim:  $CodexCmdPath"
    Write-Host 'Sandbox:     danger-full-access'
    Write-Host "Logs:        $LocalRoot"
    Write-Host "Start role:  $CurrentRole"
    Write-Host "Repair level: $($CurrentRepairAttempt + 1) of 3"
    Write-Host "Root defect:  $CurrentRootDefectId"
    if ($MaxRuns -eq 0) {
        Write-Host 'Run limit:   unlimited'
    } else {
        Write-Host "Run limit:   $MaxRuns"
    }

    while ($true) {
        if ($MaxRuns -gt 0 -and $runNumber -ge $MaxRuns) {
            $terminalStatus = 'STOP'
            $terminalMessage = "Safety run limit reached: $MaxRuns runs."
            $terminalLevel = 'Warning'
            Write-Host $terminalMessage
            break
        }

        if ($CurrentRepairAttempt -ge 3) {
            $terminalStatus = 'BLOCKED'
            $terminalMessage = "PRYSM exhausted all three governed model levels for root defect '$CurrentRootDefectId'.`n`nLuna -> Terra -> Sol were used against this unchanged root identity. No fourth autonomous attempt is allowed.`nInspect durable state and intervene manually before restarting."
            $terminalLevel = 'Error'
            Write-Host 'AUTORUN BLOCKED AFTER THREE SAME-ROOT REPAIR LEVELS.'
            break
        }

        $CurrentModel = Get-ModelForRepairAttempt $CurrentRepairAttempt
        if (-not $CurrentModel) {
            throw "No governed model exists for repair attempt $CurrentRepairAttempt"
        }

        $runNumber++
        $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
        $runDir = Join-Path $LocalRoot ("run-{0:D4}-{1}-{2}-level{3}" -f $runNumber,$stamp,$CurrentRole.ToLowerInvariant(),($CurrentRepairAttempt + 1))
        New-Item -ItemType Directory -Force -Path $runDir | Out-Null

        $LastMessagePath = Join-Path $runDir 'final.json'
        $StdoutPath = Join-Path $runDir 'codex-stdout.log'
        $StderrPath = Join-Path $runDir 'codex-stderr.log'
        $TranscriptPath = Join-Path $runDir 'codex-output.log'
        $RunPromptPath = Join-Path $runDir 'prompt.md'
        $RunnerCmdPath = Join-Path $runDir 'invoke-codex.cmd'

        $PromptPath = Get-PromptPath $CurrentRole
        $basePrompt = Get-Content -LiteralPath $PromptPath -Raw
        $runtimeHeader = @"
# CONTROLLER RUNTIME CONTEXT

Project: PRYSM Production Closure
Role: $CurrentRole
Controller run number: $runNumber
Application local path: $AppRepo
Governance local path: $GovernanceRepo
Invocation time: $(Get-Date -Format o)
Current governed model: $CurrentModel
Current repair escalation index: $CurrentRepairAttempt
Current model level: $($CurrentRepairAttempt + 1) of 3
Current root defect id: $CurrentRootDefectId

ROOT-DEFECT ACCOUNTING - GOVERNING
- The controller owns escalation accounting. You do not choose the next repair level.
- `repair_attempt` in your structured result is an echo of the CURRENT controller index above. Do not increment or decrement it.
- Return a stable `root_defect_id` for the active repair boundary, or `NONE` when no repair defect is active.
- `failure_class=REPAIR_PROOF_FAILED` only when an actual repair/proof failed against the SAME root defect identity.
- `failure_class=NEW_ROOT_CAUSE` when diagnosis/proof exposes a materially different prerequisite or root boundary. Use a NEW non-NONE root_defect_id and return CONTINUE to Builder. A new root does not consume the old repair chain.
- `failure_class=EXTERNAL_OR_PROTOCOL` for usage, CLI, network, GitHub, or equivalent failures that must not consume repair escalation.
- `failure_class=NONE` when no repair/proof failure occurred in this invocation.
- If a returned root_defect_id changes, the controller resets to Luna / repair attempt 0. Identity change wins defensively even if failure_class was mistakenly reported as REPAIR_PROOF_FAILED.
- After independent Auditor PASS, the controller resets root_defect_id to NONE and repair attempt to 0.
- Do not return BLOCKED merely because you believe the attempt count is exhausted. For a third same-root proof failure, return CONTINUE with REPAIR_PROOF_FAILED; the controller performs the governed BLOCKED transition.
- When writing PRYSM_AUTORUN_STATE.json, keep `repairAttempt` consistent with the current controller index unless you have discovered a NEW_ROOT_CAUSE, in which case write the new `rootDefectId` and `repairAttempt: 0`. Never carry a prior root's attempt count into a new root identity.

MODEL ESCALATION POLICY - GOVERNING
- Level 1 / repair_attempt 0: gpt-5.6-luna. Use for all initial work on a root defect.
- Level 2 / repair_attempt 1: gpt-5.6-terra. Use only after the same root defect has failed one evidence-based repair/proof attempt.
- Level 3 / repair_attempt 2: gpt-5.6-sol. Use only after the same root defect has failed two evidence-based repair/proof attempts.
- The third failed repair against the same unchanged root defect causes the controller to BLOCK. Never attempt a fourth same-root repair.
- Initial defect discovery, newly proven root causes, ordinary CONTINUE, role switching, usage-limit errors, CLI/protocol errors, and infrastructure failures do not consume an escalation level.
- Do not request or select a different model yourself. The controller owns model selection.

The external controller launches another fresh Codex invocation automatically when your structured result says CONTINUE. It also switches between Builder and Auditor according to next_role. Recover durable state on every invocation; do not rely on prior run conversational context.

"@
        ($runtimeHeader + "`r`n" + $basePrompt) | Set-Content -LiteralPath $RunPromptPath -Encoding UTF8

        $runner = @"
@echo off
call "$CodexCmdPath" --ask-for-approval never --sandbox danger-full-access --add-dir "$GovernanceRepo" exec --model "$CurrentModel" -C "$AppRepo" --color never --output-schema "$SchemaPath" --output-last-message "$LastMessagePath" - < "$RunPromptPath" > "$StdoutPath" 2> "$StderrPath"
exit /b %ERRORLEVEL%
"@
        $runner | Set-Content -LiteralPath $RunnerCmdPath -Encoding ASCII

        Write-Host ''
        Write-Host '============================================================'
        Write-Host "PRYSM AUTORUN - CODEX RUN $runNumber - $CurrentRole"
        Write-Host "MODEL: $CurrentModel | LEVEL $($CurrentRepairAttempt + 1)/3 | ROOT: $CurrentRootDefectId"
        Write-Host '============================================================'
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
        if (Test-Path -LiteralPath $StdoutPath) {
            Get-Content -LiteralPath $StdoutPath | Add-Content -LiteralPath $TranscriptPath
        }
        '=== STDERR ===' | Add-Content -LiteralPath $TranscriptPath
        if (Test-Path -LiteralPath $StderrPath) {
            Get-Content -LiteralPath $StderrPath | Add-Content -LiteralPath $TranscriptPath
        }

        if ($exitCode -ne 0 -or -not (Test-Path -LiteralPath $LastMessagePath)) {
            if (Test-UsageLimitFailure -Paths @($StdoutPath,$StderrPath,$TranscriptPath)) {
                $terminalStatus = 'STOP'
                $terminalMessage = "Codex usage limit reached while PRYSM was using $CurrentModel.`n`nNo governed repair escalation level was consumed. Resume the same controller after the usage allowance resets; recovery-first state will continue from the durable checkpoint."
                $terminalLevel = 'Warning'
                Write-Host 'AUTORUN STOPPED ON CODEX USAGE LIMIT. NO MODEL ESCALATION CONSUMED.'
                break
            }

            $consecutiveFailures++
            Write-Warning "Codex execution/protocol failure $consecutiveFailures/$MaxConsecutiveFailures. Model stays $CurrentModel; no governed repair escalation consumed. Inspect $TranscriptPath"
            if (Test-Path -LiteralPath $StderrPath) {
                Get-Content -LiteralPath $StderrPath -Tail 25 | ForEach-Object { Write-Warning $_ }
            }
            if ($consecutiveFailures -ge $MaxConsecutiveFailures) {
                throw "Stopping after $consecutiveFailures consecutive controller/Codex execution failures."
            }
            Start-Sleep -Seconds $DelaySeconds
            continue
        }

        try {
            $result = Get-Content -LiteralPath $LastMessagePath -Raw | ConvertFrom-Json
        } catch {
            $consecutiveFailures++
            Write-Warning "Structured response parse failure $consecutiveFailures/$MaxConsecutiveFailures. Model stays $CurrentModel; no governed repair escalation consumed."
            if ($consecutiveFailures -ge $MaxConsecutiveFailures) {
                throw 'Repeated structured-response parse failures.'
            }
            Start-Sleep -Seconds $DelaySeconds
            continue
        }

        $consecutiveFailures = 0
        $resultRootDefectId = Normalize-PrysmRootDefectId ([string]$result.root_defect_id)
        $failureClass = [string]$result.failure_class

        Write-Host ''
        Write-Host 'RUN RESULT'
        Write-Host "Model:          $CurrentModel"
        Write-Host "Model level:    $($CurrentRepairAttempt + 1)/3"
        Write-Host "Controller attempt: $CurrentRepairAttempt"
        Write-Host "Reported attempt:   $($result.repair_attempt) (echo only)"
        Write-Host "Current root:    $CurrentRootDefectId"
        Write-Host "Result root:     $resultRootDefectId"
        Write-Host "Failure class:   $failureClass"
        Write-Host "Role:           $($result.role)"
        Write-Host "Action:         $($result.loop_action)"
        Write-Host "Next role:      $($result.next_role)"
        Write-Host "Tranche:        $($result.tranche)"
        Write-Host "Checkpoint:     $($result.checkpoint)"
        Write-Host "Whole-app:      $($result.whole_app_gate)"
        Write-Host "Material defects: $($result.material_defects)"
        Write-Host "App branch:     $($result.application_branch)"
        Write-Host "App SHA:        $($result.application_sha)"
        Write-Host "Governance SHA: $($result.governance_sha)"
        Write-Host "GitHub synced:  $($result.github_state_synced)"
        Write-Host "Reason:         $($result.reason)"
        Write-Host "Next:           $($result.next_action)"

        $isAuditPass = ($result.role -eq 'Auditor' -and $result.checkpoint -eq 'PASS' -and [int]$result.material_defects -eq 0)

        switch ($result.loop_action) {
            'CONTINUE' {
                $accounting = Resolve-PrysmRepairAccounting `
                    -CurrentRepairAttempt $CurrentRepairAttempt `
                    -CurrentRootDefectId $CurrentRootDefectId `
                    -ResultRootDefectId $resultRootDefectId `
                    -FailureClass $failureClass `
                    -AuditPassed $isAuditPass

                Write-Host "Accounting event: $($accounting.Event)"

                if ($accounting.Event -eq 'NEW_ROOT_RESET' -or $accounting.Event -eq 'DEFENSIVE_NEW_ROOT_RESET' -or $accounting.Event -eq 'ROOT_CONTEXT_CHANGED') {
                    Write-Host "Root boundary changed: '$CurrentRootDefectId' -> '$($accounting.RootDefectId)'. Resetting to Luna / repair attempt 0."
                }
                if ($accounting.Event -eq 'SAME_ROOT_ESCALATION') {
                    Write-Host "Same-root repair proof failed for '$($accounting.RootDefectId)'. Next repair attempt: $($accounting.RepairAttempt)."
                }
                if ($accounting.Event -eq 'AUDIT_PASS_RESET') {
                    Write-Host 'Independent audit PASS. Resetting root defect to NONE and next work to Luna / Level 1.'
                }

                if ([int]$accounting.RepairAttempt -ge 3) {
                    $terminalStatus = 'BLOCKED'
                    $terminalMessage = "PRYSM exhausted the three governed model levels for the same root defect '$($accounting.RootDefectId)'.`n`nLuna -> Terra -> Sol have been consumed against this unchanged root identity. Manual intervention is required before another same-root attempt.`n`nTranche: $($result.tranche)`nReason: $($result.reason)`nNext: $($result.next_action)"
                    $terminalLevel = 'Error'
                    Write-Host 'AUTORUN BLOCKED AFTER LEVEL 3 SAME-ROOT FAILURE. MANUAL INTERVENTION REQUIRED.'
                    break
                }

                $CurrentRepairAttempt = [int]$accounting.RepairAttempt
                $CurrentRootDefectId = [string]$accounting.RootDefectId

                if ($result.next_role -eq 'Builder' -or $result.next_role -eq 'Auditor') {
                    $CurrentRole = $result.next_role
                }
                Start-Sleep -Seconds $DelaySeconds
                continue
            }
            'STOP' {
                $terminalStatus = 'STOP'
                $terminalMessage = "PRYSM autorun reached an external governed boundary.`n`nTranche: $($result.tranche)`nCheckpoint: $($result.checkpoint)`nNext: $($result.next_action)"
                $terminalLevel = 'Warning'
                Write-Host 'AUTORUN STOPPED AT A GOVERNED EXTERNAL BOUNDARY.'
                break
            }
            'BLOCKED' {
                if ($failureClass -eq 'NEW_ROOT_CAUSE' -and $resultRootDefectId -ne 'NONE' -and $resultRootDefectId -ne $CurrentRootDefectId) {
                    # Defensive compatibility with a model that still returns BLOCKED for a newly
                    # exposed boundary. The controller owns the anti-thrash transition and may
                    # continue because the previous root chain is not exhausted for this new id.
                    $CurrentRootDefectId = $resultRootDefectId
                    $CurrentRepairAttempt = 0
                    $CurrentRole = 'Builder'
                    Write-Warning "Codex returned BLOCKED while declaring NEW_ROOT_CAUSE '$resultRootDefectId'. Controller policy converts this to a Luna/0 continuation. Reconcile PRYSM_AUTORUN_STATE.json to the new root before editing."
                    Start-Sleep -Seconds $DelaySeconds
                    continue
                }

                $terminalStatus = 'BLOCKED'
                $terminalMessage = "PRYSM autorun is blocked.`n`nTranche: $($result.tranche)`nCheckpoint: $($result.checkpoint)`nRoot defect: $resultRootDefectId`nReason: $($result.reason)`nNext: $($result.next_action)"
                $terminalLevel = 'Error'
                Write-Host 'AUTORUN BLOCKED.'
                break
            }
            'COMPLETE' {
                $terminalStatus = 'COMPLETE'
                $terminalMessage = "PRYSM repository-controlled Production Closure is complete.`n`nCheckpoint: $($result.checkpoint)`nApplication SHA: $($result.application_sha)`nNext: $($result.next_action)"
                $terminalLevel = 'Info'
                Write-Host 'AUTORUN COMPLETE.'
                break
            }
            default {
                throw "Unknown loop_action returned by Codex: $($result.loop_action)"
            }
        }

        if ($terminalStatus) { break }
    }
} catch {
    $terminalStatus = 'BLOCKED'
    $terminalMessage = "PRYSM autorun controller failed: $($_.Exception.Message)"
    $terminalLevel = 'Error'
    Write-Error $_
} finally {
    foreach ($lockPath in @($AppLockPath,$GovernanceLockPath)) {
        Remove-Item -LiteralPath $lockPath -Force -ErrorAction SilentlyContinue
    }

    if ($terminalStatus) {
        Send-AutorunNotification -Title "PRYSM Autorun - $terminalStatus" -Message $terminalMessage -Level $terminalLevel
    }
}
