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
$BuilderPromptPath = Join-Path $ScriptRoot 'PRYSM-BUILDER-AUTORUN-PROMPT.md'
$AuditorPromptPath = Join-Path $ScriptRoot 'PRYSM-AUDITOR-AUTORUN-PROMPT.md'

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

foreach ($requiredFile in @($SchemaPath,$BuilderPromptPath,$AuditorPromptPath)) {
    if (-not (Test-Path -LiteralPath $requiredFile)) {
        throw "Missing autorun contract file: $requiredFile"
    }
}

$AppRepo = Resolve-RequiredPath $AppRepo 'Application repository'
$GovernanceRepo = Resolve-RequiredPath $GovernanceRepo 'Governance repository'
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

    foreach ($required in @('--output-schema','--output-last-message')) {
        if ($execHelp -notmatch [regex]::Escape($required)) {
            throw "Installed Codex exec does not advertise required option: $required"
        }
    }

    if ($rootHelp -notmatch 'danger-full-access' -and $execHelp -notmatch 'danger-full-access') {
        throw 'Installed Codex CLI does not advertise danger-full-access, required for governed Git metadata writes on Windows.'
    }

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

        $runNumber++
        $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
        $runDir = Join-Path $LocalRoot ("run-{0:D4}-{1}-{2}" -f $runNumber,$stamp,$CurrentRole.ToLowerInvariant())
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

The external controller launches another fresh Codex invocation automatically when your structured result says CONTINUE. It also switches between Builder and Auditor according to next_role. Recover durable state on every invocation; do not rely on prior run conversational context.

"@
        ($runtimeHeader + "`r`n" + $basePrompt) | Set-Content -LiteralPath $RunPromptPath -Encoding UTF8

        $runner = @"
@echo off
call "$CodexCmdPath" --ask-for-approval never --sandbox danger-full-access --add-dir "$GovernanceRepo" exec -C "$AppRepo" --color never --output-schema "$SchemaPath" --output-last-message "$LastMessagePath" - < "$RunPromptPath" > "$StdoutPath" 2> "$StderrPath"
exit /b %ERRORLEVEL%
"@
        $runner | Set-Content -LiteralPath $RunnerCmdPath -Encoding ASCII

        Write-Host ''
        Write-Host '============================================================'
        Write-Host "PRYSM AUTORUN - CODEX RUN $runNumber - $CurrentRole"
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
            $consecutiveFailures++
            Write-Warning "Codex execution/protocol failure $consecutiveFailures/$MaxConsecutiveFailures. Inspect $TranscriptPath"
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
            Write-Warning "Structured response parse failure $consecutiveFailures/$MaxConsecutiveFailures."
            if ($consecutiveFailures -ge $MaxConsecutiveFailures) {
                throw 'Repeated structured-response parse failures.'
            }
            Start-Sleep -Seconds $DelaySeconds
            continue
        }

        $consecutiveFailures = 0

        Write-Host ''
        Write-Host 'RUN RESULT'
        Write-Host "Role:           $($result.role)"
        Write-Host "Action:         $($result.loop_action)"
        Write-Host "Next role:      $($result.next_role)"
        Write-Host "Tranche:        $($result.tranche)"
        Write-Host "Checkpoint:     $($result.checkpoint)"
        Write-Host "Whole-app:      $($result.whole_app_gate)"
        Write-Host "Material defects: $($result.material_defects)"
        Write-Host "Repair attempt: $($result.repair_attempt)"
        Write-Host "App branch:     $($result.application_branch)"
        Write-Host "App SHA:        $($result.application_sha)"
        Write-Host "Governance SHA: $($result.governance_sha)"
        Write-Host "GitHub synced:  $($result.github_state_synced)"
        Write-Host "Reason:         $($result.reason)"
        Write-Host "Next:           $($result.next_action)"

        switch ($result.loop_action) {
            'CONTINUE' {
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
                $terminalStatus = 'BLOCKED'
                $terminalMessage = "PRYSM autorun is blocked.`n`nTranche: $($result.tranche)`nCheckpoint: $($result.checkpoint)`nReason: $($result.reason)`nNext: $($result.next_action)"
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
