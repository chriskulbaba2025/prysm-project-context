param(
    [switch]$AuditOnly,
    [switch]$TestNotification
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$GovRoot = (Resolve-Path (Join-Path $ScriptRoot '..\..')).Path
$WorkspaceRoot = Split-Path -Parent $GovRoot
$AppRepo = Join-Path $WorkspaceRoot 'vantage-platform'
$GatePath = Join-Path $GovRoot 'P1_EXECUTION_GATE.env'
$Contract = Join-Path $ScriptRoot 'test-prysm-p1-r2-windows-contract.ps1'
$Runner = Join-Path $ScriptRoot 'START-PRYSM-P1-R2-AUTORUN.ps1'
$Recovery = Join-Path $ScriptRoot 'RESUME-PRYSM-P1-R2-DIRTY.ps1'
$LocalBase = if ($env:LOCALAPPDATA) { $env:LOCALAPPDATA } else { $env:TEMP }
$JournalPath = Join-Path $LocalBase 'PRYSM-P-Autorun\P1-R2\transaction-journal.json'

foreach ($path in @($GatePath,$Contract,$Runner,$Recovery)) {
    if (-not (Test-Path -LiteralPath $path)) { throw "Missing governed R2 entrypoint dependency: $path" }
}

function Send-DesktopNotification {
    param(
        [string]$Title,
        [string]$Message,
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
        [System.Windows.Forms.MessageBox]::Show(
            $Message,
            $Title,
            [System.Windows.Forms.MessageBoxButtons]::OK,
            $icon
        ) | Out-Null
        return
    } catch {}

    try { & msg.exe $env:USERNAME "$Title`n$Message" 2>$null | Out-Null } catch {}
    try { [console]::Beep(880,300) } catch {}
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

function Require-GateValue([hashtable]$Gate,[string]$Key,[string]$Expected) {
    if (-not $Gate.ContainsKey($Key)) { throw "P1 execution gate is missing required R2 field: $Key" }
    if ([string]$Gate[$Key] -ne $Expected) { throw "P1 execution gate R2 mismatch for $Key. Expected '$Expected', found '$($Gate[$Key])'." }
}

function Verify-BoundFile([hashtable]$Gate,[string]$FileKey,[string]$CommitKey) {
    $file = [string]$Gate[$FileKey]
    $commit = [string]$Gate[$CommitKey]
    if ([string]::IsNullOrWhiteSpace($file) -or [string]::IsNullOrWhiteSpace($commit)) { throw "Missing R2 binding: $FileKey / $CommitKey" }

    $old = $ErrorActionPreference
    try {
        $ErrorActionPreference = 'Continue'
        & git -C $GovRoot cat-file -e "$commit^{commit}" 2>$null
        $commitExit = $LASTEXITCODE
        & git -C $GovRoot cat-file -e "${commit}:$file" 2>$null
        $boundExit = $LASTEXITCODE
        & git -C $GovRoot cat-file -e "HEAD:$file" 2>$null
        $headExit = $LASTEXITCODE
    } finally {
        $ErrorActionPreference = $old
    }

    if ($commitExit -ne 0) { throw "$CommitKey does not resolve to a governance commit: $commit" }
    if ($boundExit -ne 0) { throw "$file was not present at bound commit $commit" }
    if ($headExit -ne 0) { throw "$file is missing from current governance HEAD" }

    $boundBlob = (& git -C $GovRoot rev-parse "${commit}:$file").Trim()
    $headBlob = (& git -C $GovRoot rev-parse "HEAD:$file").Trim()
    if ($boundBlob -ne $headBlob) { throw "$file changed after its bound R2 commit. Pull the current authoritative state; do not run." }
}

function Test-DirtyRecoveryNeeded {
    if (-not (Test-Path -LiteralPath $JournalPath)) { return $false }
    try { $journal = Get-Content -LiteralPath $JournalPath -Raw | ConvertFrom-Json }
    catch { throw "R2 journal is corrupt and will not be reset: $JournalPath" }

    if ([string]$journal.status -eq 'RUNNING') {
        throw "R2 journal is still RUNNING and cannot be auto-recovered: $JournalPath"
    }
    return ([string]$journal.status -eq 'CODEX_EXITED_UNRECONCILED')
}

$gate = Read-Gate
Require-GateValue $gate 'P_ID' 'P1'
Require-GateValue $gate 'AUTHORIZED_STAGE' 'BOUNDED_BUILD'
Require-GateValue $gate 'R2_EXECUTION_AUTH_FILE' 'proof/P1/reopen/P1_BOUNDED_REPAIR_AUTHORIZATION_R2_V2_2026-09-06.md'
Require-GateValue $gate 'R2_DIRTY_RECOVERY_FILE' 'proof/P1/reopen/P1_R2_RUN1_DIRTY_CHECKPOINT_RECOVERY_2026-09-06.md'
Require-GateValue $gate 'R2_WINDOWS_ENTRY' 'tools/prysm/START-PRYSM-P1-R2.ps1'
Require-GateValue $gate 'R2_WINDOWS_RUNNER' 'tools/prysm/START-PRYSM-P1-R2-AUTORUN.ps1'
Require-GateValue $gate 'R2_WINDOWS_RECOVERY' 'tools/prysm/RESUME-PRYSM-P1-R2-DIRTY.ps1'
Require-GateValue $gate 'R2_WINDOWS_CONTRACT' 'tools/prysm/test-prysm-p1-r2-windows-contract.ps1'
Require-GateValue $gate 'R2_LOCAL_STATE_NAMESPACE' 'PRYSM-P-Autorun/P1-R2'
Require-GateValue $gate 'R2_INITIAL_REPAIR_ATTEMPT' '1'
Require-GateValue $gate 'R2_STABLE_ROOT' 'P1-CROSS-REPORT-PROJECTION-RECONCILIATION'

Verify-BoundFile $gate 'R2_EXECUTION_AUTH_FILE' 'R2_EXECUTION_AUTH_COMMIT'
Verify-BoundFile $gate 'R2_DIRTY_RECOVERY_FILE' 'R2_DIRTY_RECOVERY_COMMIT'
Verify-BoundFile $gate 'R2_WINDOWS_ENTRY' 'R2_WINDOWS_ENTRY_COMMIT'
Verify-BoundFile $gate 'R2_WINDOWS_RUNNER' 'R2_WINDOWS_RUNNER_COMMIT'
Verify-BoundFile $gate 'R2_WINDOWS_RECOVERY' 'R2_WINDOWS_RECOVERY_COMMIT'
Verify-BoundFile $gate 'R2_WINDOWS_CONTRACT' 'R2_WINDOWS_CONTRACT_COMMIT'

if ($TestNotification) {
    Send-DesktopNotification -Title 'PRYSM P1 R2 NOTIFICATION TEST' -Level 'Info' -Message 'Notification path PASS. No Codex Builder invocation occurred.'
    Write-Host 'PRYSM P1 R2 WINDOWS NOTIFICATION TEST PASS'
    exit 0
}

$recoveryNeeded = Test-DirtyRecoveryNeeded

Write-Host 'PRYSM P1 R2 WINDOWS BOOTSTRAP'
Write-Host "Mode: $(if ($AuditOnly) { 'AUDIT ONLY' } elseif ($recoveryNeeded) { 'DIRTY CHECKPOINT RECOVERY -> CONTINUOUS BUILDER TO BRAD' } else { 'CONTINUOUS BUILDER TO BRAD' })"
Write-Host 'Gate binding: PASS'

Write-Host "`n[1/2] R2 Windows controller contract"
& powershell.exe -NoProfile -ExecutionPolicy Bypass -File $Contract
if ($LASTEXITCODE -ne 0) {
    Send-DesktopNotification -Title 'PRYSM P1 R2 CONTROLLER FAILURE' -Level 'Error' -Message 'Windows R2 controller contract failed. Builder did not start. See the terminal for the exact error.'
    throw 'R2 Windows controller contract failed. Builder did not start.'
}

if ($recoveryNeeded) {
    Write-Host "`n[2/2] R2 attributed dirty-checkpoint recovery"
    $old = $ErrorActionPreference
    try {
        $ErrorActionPreference = 'Continue'
        if ($AuditOnly) {
            & powershell.exe -NoProfile -ExecutionPolicy Bypass -File $Recovery -AuditOnly
        } else {
            & powershell.exe -NoProfile -ExecutionPolicy Bypass -File $Recovery
        }
        $recoveryExitCode = $LASTEXITCODE
    } finally {
        $ErrorActionPreference = $old
    }

    if ($recoveryExitCode -ne 0) {
        Send-DesktopNotification -Title 'PRYSM P1 R2 RECOVERY STOPPED' -Level 'Error' -Message "Attributed dirty-checkpoint recovery stopped with exit code $recoveryExitCode. No blind rerun or cleanup occurred. See the terminal for the exact failure."
        exit $recoveryExitCode
    }

    if ($AuditOnly) { exit 0 }

    $gate = Read-Gate
    if ([string]$gate['AUTHORIZED_STAGE'] -eq 'OUTCOME_REVIEW') {
        Send-DesktopNotification -Title 'PRYSM P1 READY FOR BRAD' -Level 'Info' -Message 'Recovered R2 candidate reached OUTCOME_REVIEW. Brad is the next actor.'
        Write-Host 'PRYSM P1 READY FOR BRAD'
        exit 0
    }
    if ([string]$gate['AUTHORIZED_STAGE'] -ne 'BOUNDED_BUILD') {
        Send-DesktopNotification -Title 'PRYSM P1 R2 STOPPED' -Level 'Error' -Message "Recovery ended at unsupported stage $($gate['AUTHORIZED_STAGE']). See the terminal."
        exit 1
    }
}

Write-Host "`n[2/2] R2 runtime"
$old = $ErrorActionPreference
try {
    $ErrorActionPreference = 'Continue'
    if ($AuditOnly) {
        & powershell.exe -NoProfile -ExecutionPolicy Bypass -File $Runner -AuditOnly
    } else {
        & powershell.exe -NoProfile -ExecutionPolicy Bypass -File $Runner
    }
    $runtimeExitCode = $LASTEXITCODE
} finally {
    $ErrorActionPreference = $old
}

if ($runtimeExitCode -ne 0) {
    Send-DesktopNotification -Title 'PRYSM P1 R2 STOPPED' -Level 'Error' -Message "The R2 controller stopped with exit code $runtimeExitCode. No automatic rerun will occur. Preserve the current state and see the terminal for the exact failure."
}

exit $runtimeExitCode
