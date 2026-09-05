param(
    [Parameter(Mandatory = $true)]
    [ValidatePattern('^P[0-9]+$')]
    [string]$P,

    [string]$AppRepo,
    [string]$GovernanceRepo,
    [int]$MaxRuns = 0,
    [int]$DelaySeconds = 2,
    [int]$HeartbeatSeconds = 60,
    [int]$MaxConsecutiveFailures = 3,
    [int]$MaxReadinessRejections = 3,
    [switch]$PreflightOnly,
    [switch]$SelfTest,

    [ValidateSet('READY_FOR_BRAD','BLOCKED','CONTROLLER_FAILURE')]
    [string]$TestNotification
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$ToolsRoot = Split-Path -Parent $ScriptRoot
$SchemaPath = Join-Path $ToolsRoot 'autorun\PRYSM-AUTORUN-RESULT.schema.json'
$BuilderPromptPath = Join-Path $ScriptRoot 'PRYSM-P-BUILDER-AUTORUN-PROMPT.md'
$CurrentSessionLauncher = Join-Path $ScriptRoot 'start-prysm-p-current-session.sh'

$ModelLuna = 'gpt-5.6-luna'
$ModelTerra = 'gpt-5.6-terra'
$ModelSol = 'gpt-5.6-sol'

function Resolve-RequiredPath {
    param([string]$Path,[string]$Label)
    if ([string]::IsNullOrWhiteSpace($Path) -or -not (Test-Path -LiteralPath $Path)) {
        throw "$Label does not exist: $Path"
    }
    return (Resolve-Path -LiteralPath $Path).Path
}

function Assert-GitRepo {
    param([string]$Path,[string]$Label)
    & git -C $Path rev-parse --is-inside-work-tree *> $null
    if ($LASTEXITCODE -ne 0) {
        throw "$Label is not a Git repository: $Path"
    }
}

function Resolve-CodexCmd {
    $cmd = Get-Command codex.cmd -ErrorAction SilentlyContinue
    if ($cmd -and (Test-Path -LiteralPath $cmd.Source)) {
        return $cmd.Source
    }

    $generic = Get-Command codex -ErrorAction SilentlyContinue
    if ($generic -and $generic.Source) {
        $sibling = [System.IO.Path]::ChangeExtension($generic.Source,'.cmd')
        if (Test-Path -LiteralPath $sibling) {
            return $sibling
        }
    }

    throw 'Codex CLI Windows command shim (codex.cmd) was not found on PATH.'
}

function Resolve-Bash {
    $gitBash = 'C:\Program Files\Git\bin\bash.exe'
    if (Test-Path -LiteralPath $gitBash) {
        return $gitBash
    }

    $bash = Get-Command bash -ErrorAction SilentlyContinue
    if ($bash -and $bash.Source) {
        return $bash.Source
    }

    throw 'Git Bash was not found.'
}

function Read-EnvFile {
    param([string]$Path)
    $values = @{}
    foreach ($line in Get-Content -LiteralPath $Path) {
        if ([string]::IsNullOrWhiteSpace($line) -or $line.TrimStart().StartsWith('#')) {
            continue
        }
        $idx = $line.IndexOf('=')
        if ($idx -lt 1) {
            continue
        }
        $values[$line.Substring(0,$idx).Trim()] = $line.Substring($idx + 1).Trim()
    }
    return $values
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

function Normalize-RootId {
    param([string]$Value)
    if ([string]::IsNullOrWhiteSpace($Value)) {
        return 'NONE'
    }
    return $Value.Trim()
}

function Get-PathLockName {
    param([string]$Value)
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($Value.ToLowerInvariant())
    $sha = [System.Security.Cryptography.SHA256]::Create()
    try {
        $hash = $sha.ComputeHash($bytes)
    }
    finally {
        $sha.Dispose()
    }
    return (($hash | ForEach-Object { $_.ToString('x2') }) -join '').Substring(0,16)
}

function Get-GitHead {
    param([string]$Path)
    return ((& git -C $Path rev-parse HEAD).Trim())
}

function Get-GitBranch {
    param([string]$Path)
    return ((& git -C $Path branch --show-current).Trim())
}

function Get-GitStatus {
    param([string]$Path)
    return ((& git -C $Path status --porcelain=v1 --untracked-files=all) -join "`n")
}

function Test-GitAncestor {
    param([string]$Repo,[string]$Ancestor,[string]$Descendant)
    & git -C $Repo merge-base --is-ancestor $Ancestor $Descendant *> $null
    return ($LASTEXITCODE -eq 0)
}

function Get-Route {
    param($Result)
    $checkpoint = [string]$Result.checkpoint
    $loopAction = [string]$Result.loop_action
    $nextRole = [string]$Result.next_role

    if ($loopAction -eq 'BLOCKED') {
        return 'BLOCKED'
    }
    if ($checkpoint -eq 'READY_FOR_BRAD') {
        return 'READY_FOR_BRAD_CLAIM'
    }
    if ($nextRole -eq 'Builder' -and $loopAction -in @('CONTINUE','STOP')) {
        return 'CONTINUE'
    }
    if ($loopAction -eq 'CONTINUE' -and $nextRole -eq 'NONE') {
        return 'CONTINUE'
    }
    if ($nextRole -eq 'Auditor') {
        return 'CONTRACT_VIOLATION'
    }
    return 'BLOCKED'
}

function Test-UsageLimit {
    param([string[]]$Paths)
    foreach ($path in $Paths) {
        if (-not (Test-Path -LiteralPath $path)) {
            continue
        }
        $text = Get-Content -LiteralPath $path -Raw -ErrorAction SilentlyContinue
        if ($text -match '(?i)hit your usage limit|usage limit.*try again|usage limit.*reset') {
            return $true
        }
    }
    return $false
}

function Send-DesktopNotification {
    param(
        [string]$Title,
        [string]$Message,
        [ValidateSet('Info','Warning','Error')][string]$Level
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
    }
    catch {
        # Fall through to msg.exe.
    }

    try {
        & msg.exe $env:USERNAME "$Title`n$Message" 2>$null | Out-Null
    }
    catch {
        # Notification failure is non-fatal.
    }
}

function Send-TerminalNotification {
    param(
        [ValidateSet('READY_FOR_BRAD','BLOCKED','CONTROLLER_FAILURE')][string]$Kind,
        [string]$ApplicationSha='UNBOUND',
        [string]$GovernanceSha='UNBOUND',
        [string]$Reason='',
        [string]$NextAction='',
        [string]$RunLog=''
    )

    switch ($Kind) {
        'READY_FOR_BRAD' {
            $message = "Application SHA: $ApplicationSha`nGovernance SHA: $GovernanceSha`nDeterministic Brad handoff gate: PASS`nNext actor: Brad"
            Send-DesktopNotification -Title "PRYSM $P READY FOR BRAD" -Message $message -Level 'Info'
        }
        'BLOCKED' {
            $message = "Blocker: $Reason`nApplication SHA: $ApplicationSha`nGovernance SHA: $GovernanceSha`nNext action: $NextAction"
            Send-DesktopNotification -Title "PRYSM $P BLOCKED" -Message $message -Level 'Warning'
        }
        default {
            $message = "Failure: $Reason`nLatest run log: $RunLog"
            Send-DesktopNotification -Title "PRYSM $P CONTROLLER FAILURE" -Message $message -Level 'Error'
        }
    }
}

function Assert-CodexFeatures {
    param([string]$CodexCmdPath)

    $rootHelp = (& $CodexCmdPath --help 2>&1 | Out-String)
    if ($LASTEXITCODE -ne 0) {
        throw 'Codex --help failed.'
    }

    $execHelp = (& $CodexCmdPath exec --help 2>&1 | Out-String)
    if ($LASTEXITCODE -ne 0) {
        throw 'Codex exec --help failed.'
    }

    foreach ($required in @('--ask-for-approval','--sandbox','--add-dir','--output-schema','--output-last-message','--model','--cd')) {
        if ($rootHelp -notmatch [regex]::Escape($required) -and $execHelp -notmatch [regex]::Escape($required)) {
            throw "Installed Codex CLI does not advertise required option: $required"
        }
    }

    if ($rootHelp -notmatch 'danger-full-access' -and $execHelp -notmatch 'danger-full-access') {
        throw 'Installed Codex CLI does not advertise danger-full-access.'
    }
}

function Assert-CurrentStateStage {
    param(
        [string]$GovernanceRepo,
        [string]$ExpectedStage,
        [string]$ExpectedActorPattern
    )

    $statePath = Join-Path $GovernanceRepo 'CURRENT_STATE.md'
    if (-not (Test-Path -LiteralPath $statePath)) {
        throw 'CURRENT_STATE.md is missing.'
    }

    $text = Get-Content -LiteralPath $statePath -Raw
    $stageEsc = [regex]::Escape($ExpectedStage)
    if ($text -notmatch "(?m)^- Authorized stage:\s+.*$stageEsc.*$") {
        throw "CURRENT_STATE.md does not authorize stage $ExpectedStage."
    }

    if ($text -match '(?m)^- Current stage:\s+([A-Z_]+)\s*$') {
        if ($Matches[1] -ne $ExpectedStage) {
            throw "CURRENT_STATE current stage is $($Matches[1]), expected $ExpectedStage."
        }
    }

    if (-not [string]::IsNullOrWhiteSpace($ExpectedActorPattern)) {
        if ($text -notmatch "(?m)^- Authorized actor:\s+.*$ExpectedActorPattern.*$") {
            throw "CURRENT_STATE.md does not authorize expected actor pattern $ExpectedActorPattern."
        }
    }
}

function Assert-GovernanceFresh {
    param([string]$GovernanceRepo)

    if ((Get-GitBranch $GovernanceRepo) -ne 'main') {
        throw 'Governance repository must be on main.'
    }
    if (-not [string]::IsNullOrWhiteSpace((Get-GitStatus $GovernanceRepo))) {
        throw 'Governance repository must be clean before controller execution.'
    }

    & git -C $GovernanceRepo fetch origin main | Out-Null
    if ($LASTEXITCODE -ne 0) {
        throw 'Governance origin fetch failed.'
    }

    $local = Get-GitHead $GovernanceRepo
    $remote = ((& git -C $GovernanceRepo rev-parse origin/main).Trim())
    if ($local -ne $remote) {
        throw "Governance main is not synchronized with origin/main. Local=$local Remote=$remote"
    }
}

function Invoke-OfficialGate {
    param(
        [string]$Bash,
        [string]$ExpectedStage,
        [string]$ExpectedActor
    )

    $gateOutput = (& $Bash $CurrentSessionLauncher $P 2>&1 | Out-String)
    $code = $LASTEXITCODE
    if ($code -ne 0) {
        throw "Official PRYSM deterministic gate failed.`n$gateOutput"
    }
    if ($gateOutput -notmatch 'PRYSM PROCESS GATE PASS') {
        throw "Official gate did not emit PASS.`n$gateOutput"
    }
    if ($gateOutput -notmatch [regex]::Escape("Authorized stage: $ExpectedStage")) {
        throw "Official gate stage mismatch.`n$gateOutput"
    }
    if ($gateOutput -notmatch [regex]::Escape("Authorized actor: $ExpectedActor")) {
        throw "Official gate actor mismatch.`n$gateOutput"
    }
    return $gateOutput
}

function Acquire-ResourceLock {
    param([string]$Path,[string]$Body)

    if (Test-Path -LiteralPath $Path) {
        $existing = Get-Content -LiteralPath $Path -Raw -ErrorAction SilentlyContinue
        $live = $false
        if ($existing -match '(?m)^PID=(\d+)$') {
            try {
                Get-Process -Id ([int]$Matches[1]) -ErrorAction Stop | Out-Null
                $live = $true
            }
            catch {
                $live = $false
            }
        }

        if ($live) {
            throw "Another PRYSM controller is using this resource. Lock: $Path`n$existing"
        }
        Remove-Item -LiteralPath $Path -Force
    }

    $Body | Set-Content -LiteralPath $Path -Encoding ASCII
}

function Read-EntryAnchor {
    param([string]$AnchorPath)
    if (-not (Test-Path -LiteralPath $AnchorPath)) {
        return $null
    }
    try {
        return (Get-Content -LiteralPath $AnchorPath -Raw | ConvertFrom-Json)
    }
    catch {
        return $null
    }
}

function Write-EntryAnchor {
    param(
        [string]$AnchorPath,
        [hashtable]$Gate,
        [string]$AppRepo,
        [string]$GovernanceRepo
    )

    [ordered]@{
        p = $P
        applicationBranch = $Gate['APPLICATION_BRANCH']
        baseGateSha = $Gate['APPLICATION_SHA']
        governanceShaAtEntry = Get-GitHead $GovernanceRepo
        applicationShaAtEntry = Get-GitHead $AppRepo
        enteredAt = Get-Date -Format o
    } | ConvertTo-Json -Depth 4 | Set-Content -LiteralPath $AnchorPath -Encoding UTF8
}

function Assert-InitialRecoveryBoundary {
    param(
        [hashtable]$Gate,
        [string]$AppRepo,
        [string]$GovernanceRepo,
        [string]$Bash,
        [string]$AnchorPath
    )

    if (-not $Gate.ContainsKey('AUTHORIZED_STAGE')) {
        throw 'P gate missing AUTHORIZED_STAGE.'
    }
    if ($Gate['AUTHORIZED_STAGE'] -notin @('DIAGNOSTIC_TRUTH','BOUNDED_BUILD')) {
        throw "$P is not Builder-owned: AUTHORIZED_STAGE=$($Gate['AUTHORIZED_STAGE'])"
    }
    if (-not $Gate.ContainsKey('APPLICATION_BRANCH')) {
        throw 'P gate missing APPLICATION_BRANCH.'
    }
    if (-not $Gate.ContainsKey('APPLICATION_SHA')) {
        throw 'P gate missing APPLICATION_SHA.'
    }
    if ($Gate['APPLICATION_SHA'] -notmatch '^[0-9a-f]{40}$') {
        throw 'P gate APPLICATION_SHA is not an exact SHA.'
    }

    Assert-CurrentStateStage -GovernanceRepo $GovernanceRepo -ExpectedStage $Gate['AUTHORIZED_STAGE'] -ExpectedActorPattern 'BUILDER'

    $branch = Get-GitBranch $AppRepo
    if ($branch -ne $Gate['APPLICATION_BRANCH']) {
        throw "Application branch mismatch. Current=$branch Required=$($Gate['APPLICATION_BRANCH']). Controller will not switch branches."
    }

    & git -C $AppRepo fetch origin $branch | Out-Null
    if ($LASTEXITCODE -ne 0) {
        throw "Application fetch failed for origin/$branch."
    }

    $head = Get-GitHead $AppRepo
    $origin = ((& git -C $AppRepo rev-parse "origin/$branch").Trim())
    $status = Get-GitStatus $AppRepo
    $gateSha = $Gate['APPLICATION_SHA']

    if ($head -eq $gateSha -and $origin -eq $gateSha) {
        if ([string]::IsNullOrWhiteSpace($status)) {
            Invoke-OfficialGate -Bash $Bash -ExpectedStage $Gate['AUTHORIZED_STAGE'] -ExpectedActor 'BUILDER' | Out-Null
            Write-EntryAnchor -AnchorPath $AnchorPath -Gate $Gate -AppRepo $AppRepo -GovernanceRepo $GovernanceRepo
            return 'OFFICIAL_GATE_PASS'
        }

        Write-EntryAnchor -AnchorPath $AnchorPath -Gate $Gate -AppRepo $AppRepo -GovernanceRepo $GovernanceRepo
        return 'DIRTY_AUTHORIZED_CONTINUATION'
    }

    $anchor = Read-EntryAnchor -AnchorPath $AnchorPath
    if ($null -eq $anchor) {
        throw "Application state no longer equals the gate SHA and no verified P# entry anchor exists. HEAD=$head Origin=$origin Gate=$gateSha"
    }
    if ([string]$anchor.p -ne $P) {
        throw 'P# entry anchor belongs to a different workstream.'
    }
    if ([string]$anchor.applicationBranch -ne $branch) {
        throw 'P# entry anchor branch does not match the current application branch.'
    }
    if ([string]$anchor.baseGateSha -ne $gateSha) {
        throw 'P# entry anchor base SHA does not match the current Builder gate SHA.'
    }
    if (-not (Test-GitAncestor -Repo $AppRepo -Ancestor $gateSha -Descendant $head)) {
        throw "Current application HEAD is not a descendant of the verified entry gate SHA. HEAD=$head Gate=$gateSha"
    }
    if (-not (Test-GitAncestor -Repo $AppRepo -Ancestor $gateSha -Descendant $origin)) {
        throw "Current origin/$branch is not a descendant of the verified entry gate SHA. Origin=$origin Gate=$gateSha"
    }
    if (-not (Test-GitAncestor -Repo $AppRepo -Ancestor $origin -Descendant $head)) {
        throw "Current application branch has diverged from or fallen behind origin/$branch. Local=$head Origin=$origin"
    }

    return 'ANCHORED_DESCENDANT_RECOVERY'
}

function Assert-ReadyForBrad {
    param(
        $Result,
        [string]$AppRepo,
        [string]$GovernanceRepo,
        [string]$Bash
    )

    if ([string]$Result.checkpoint -ne 'READY_FOR_BRAD') {
        throw 'READY claim is missing checkpoint READY_FOR_BRAD.'
    }
    if ([string]$Result.loop_action -ne 'STOP') {
        throw 'READY claim must use loop_action STOP.'
    }
    if ([string]$Result.next_role -ne 'NONE') {
        throw 'READY claim must stop before human Brad; next_role must be NONE.'
    }
    if ([string]$Result.whole_app_gate -ne 'PASS') {
        throw 'READY claim requires whole_app_gate PASS.'
    }
    if ([int]$Result.material_defects -ne 0) {
        throw 'READY claim requires material_defects=0.'
    }
    if (-not [bool]$Result.github_state_synced) {
        throw 'READY claim requires github_state_synced=true.'
    }

    if (-not [string]::IsNullOrWhiteSpace((Get-GitStatus $AppRepo))) {
        throw 'Application tree is not clean at READY_FOR_BRAD.'
    }
    if (-not [string]::IsNullOrWhiteSpace((Get-GitStatus $GovernanceRepo))) {
        throw 'Governance tree is not clean at READY_FOR_BRAD.'
    }

    Assert-GovernanceFresh -GovernanceRepo $GovernanceRepo

    $gatePath = Join-Path $GovernanceRepo ("{0}_EXECUTION_GATE.env" -f $P)
    $gateNow = Read-EnvFile $gatePath
    if (-not $gateNow.ContainsKey('AUTHORIZED_STAGE') -or $gateNow['AUTHORIZED_STAGE'] -ne 'OUTCOME_REVIEW') {
        throw 'P gate has not been advanced to OUTCOME_REVIEW.'
    }

    Assert-CurrentStateStage -GovernanceRepo $GovernanceRepo -ExpectedStage 'OUTCOME_REVIEW' -ExpectedActorPattern 'BRAD'

    $branch = Get-GitBranch $AppRepo
    & git -C $AppRepo fetch origin $branch | Out-Null
    if ($LASTEXITCODE -ne 0) {
        throw "Application fetch failed for origin/$branch at readiness check."
    }

    $head = Get-GitHead $AppRepo
    $origin = ((& git -C $AppRepo rev-parse "origin/$branch").Trim())
    if ($head -ne $origin) {
        throw "Application candidate is not synchronized with origin/$branch. Local=$head Remote=$origin"
    }
    if ([string]$Result.application_sha -ne $head) {
        throw "Result application_sha does not equal local exact candidate. Result=$($Result.application_sha) Local=$head"
    }
    if ([string]$Result.governance_sha -ne (Get-GitHead $GovernanceRepo)) {
        throw 'Result governance_sha does not equal authoritative local governance HEAD.'
    }

    Invoke-OfficialGate -Bash $Bash -ExpectedStage 'OUTCOME_REVIEW' -ExpectedActor 'BRAD' | Out-Null
}

if ($TestNotification) {
    Send-TerminalNotification -Kind $TestNotification -ApplicationSha 'TEST-APP-SHA' -GovernanceSha 'TEST-GOV-SHA' -Reason 'Test only.' -NextAction 'Close this popup.' -RunLog 'TEST-NO-RUN'
    Write-Host "Notification test sent: $TestNotification"
    exit 0
}

if (-not (Test-Path -LiteralPath $SchemaPath)) {
    throw "Missing schema: $SchemaPath"
}
if (-not (Test-Path -LiteralPath $BuilderPromptPath)) {
    throw "Missing Builder prompt: $BuilderPromptPath"
}
if (-not (Test-Path -LiteralPath $CurrentSessionLauncher)) {
    throw "Missing current-session launcher: $CurrentSessionLauncher"
}

if ($SelfTest) {
    $cases = @(
        @{ Result=[pscustomobject]@{checkpoint='WORK';loop_action='CONTINUE';next_role='Builder'}; Expected='CONTINUE' },
        @{ Result=[pscustomobject]@{checkpoint='WORK';loop_action='STOP';next_role='Builder'}; Expected='CONTINUE' },
        @{ Result=[pscustomobject]@{checkpoint='READY_FOR_BRAD';loop_action='STOP';next_role='NONE'}; Expected='READY_FOR_BRAD_CLAIM' },
        @{ Result=[pscustomobject]@{checkpoint='AUDIT_REQUIRED';loop_action='CONTINUE';next_role='Auditor'}; Expected='CONTRACT_VIOLATION' },
        @{ Result=[pscustomobject]@{checkpoint='WORK';loop_action='BLOCKED';next_role='NONE'}; Expected='BLOCKED' },
        @{ Result=[pscustomobject]@{checkpoint='WORK';loop_action='COMPLETE';next_role='NONE'}; Expected='BLOCKED' }
    )

    foreach ($case in $cases) {
        $actual = Get-Route $case.Result
        if ($actual -ne $case.Expected) {
            throw "SelfTest route failure: expected $($case.Expected), got $actual"
        }
    }

    if ((Get-ModelForAttempt 0) -ne $ModelLuna) {
        throw 'SelfTest Luna routing failed.'
    }
    if ((Get-ModelForAttempt 1) -ne $ModelTerra) {
        throw 'SelfTest Terra routing failed.'
    }
    if ((Get-ModelForAttempt 2) -ne $ModelSol) {
        throw 'SelfTest Sol routing failed.'
    }

    Write-Host 'PRYSM P# AUTORUN SELFTEST PASS'
    exit 0
}

$AppRepo = Resolve-RequiredPath $AppRepo 'Application repository'
$GovernanceRepo = Resolve-RequiredPath $GovernanceRepo 'Governance repository'
Assert-GitRepo -Path $AppRepo -Label 'Application repository'
Assert-GitRepo -Path $GovernanceRepo -Label 'Governance repository'

$CodexCmdPath = Resolve-CodexCmd
$Bash = Resolve-Bash
Assert-CodexFeatures -CodexCmdPath $CodexCmdPath
Assert-GovernanceFresh -GovernanceRepo $GovernanceRepo

$GatePath = Join-Path $GovernanceRepo ("{0}_EXECUTION_GATE.env" -f $P)
if (-not (Test-Path -LiteralPath $GatePath)) {
    throw "Missing P execution gate: $GatePath"
}

$gate = Read-EnvFile $GatePath
if (-not $gate.ContainsKey('P_ID') -or $gate['P_ID'] -ne $P) {
    throw "P identity mismatch in $GatePath"
}

$LocalBase = if ($env:LOCALAPPDATA) { $env:LOCALAPPDATA } else { $env:TEMP }
$LocalRoot = Join-Path $LocalBase ("PRYSM-P-Autorun\{0}" -f $P)
$SharedLockRoot = Join-Path $LocalBase 'PRYSM-Autorun-Locks'
New-Item -ItemType Directory -Force -Path $LocalRoot | Out-Null
New-Item -ItemType Directory -Force -Path $SharedLockRoot | Out-Null

$AccountingPath = Join-Path $LocalRoot 'accounting.json'
$ControllerStatePath = Join-Path $LocalRoot 'controller-state.json'
$HeartbeatPath = Join-Path $LocalRoot 'heartbeat.json'
$HeartbeatStopPath = Join-Path $LocalRoot 'heartbeat.stop'
$EntryAnchorPath = Join-Path $LocalRoot 'entry-anchor.json'
$AppLockPath = Join-Path $SharedLockRoot ("app-{0}.lock" -f (Get-PathLockName $AppRepo))
$GovernanceLockPath = Join-Path $SharedLockRoot ("governance-{0}.lock" -f (Get-PathLockName $GovernanceRepo))

$recoveryMode = Assert-InitialRecoveryBoundary -Gate $gate -AppRepo $AppRepo -GovernanceRepo $GovernanceRepo -Bash $Bash -AnchorPath $EntryAnchorPath

if ($PreflightOnly) {
    Write-Host "PRYSM $P AUTORUN PREFLIGHT"
    Write-Host "Application:   $AppRepo"
    Write-Host "Governance:    $GovernanceRepo"
    Write-Host "Branch:        $(Get-GitBranch $AppRepo)"
    Write-Host "Stage:         $($gate['AUTHORIZED_STAGE'])"
    Write-Host "Recovery mode: $recoveryMode"
    Write-Host "Codex:         $CodexCmdPath"
    Write-Host "Bash:          $Bash"
    Write-Host "Local state:   $LocalRoot"
    Write-Host 'Approval:      never'
    Write-Host 'Sandbox:       danger-full-access'
    Write-Host 'PREFLIGHT PASS'
    exit 0
}

$lockBody = "PID=$PID`nP=$P`nStarted=$(Get-Date -Format o)`nAppRepo=$AppRepo`nGovernanceRepo=$GovernanceRepo`n"
Acquire-ResourceLock -Path $AppLockPath -Body $lockBody
try {
    Acquire-ResourceLock -Path $GovernanceLockPath -Body $lockBody
}
catch {
    Remove-Item -LiteralPath $AppLockPath -Force -ErrorAction SilentlyContinue
    throw
}

$repairAttempt = 0
$rootDefectId = 'NONE'
if (Test-Path -LiteralPath $AccountingPath) {
    try {
        $accounting = Get-Content -LiteralPath $AccountingPath -Raw | ConvertFrom-Json
        $repairAttempt = [int]$accounting.repairAttempt
        $rootDefectId = Normalize-RootId ([string]$accounting.rootDefectId)
    }
    catch {
        $repairAttempt = 0
        $rootDefectId = 'NONE'
    }
}
if ($repairAttempt -lt 0) {
    $repairAttempt = 0
}
if ($repairAttempt -gt 3) {
    $repairAttempt = 3
}

function Write-Accounting {
    [ordered]@{
        p = $P
        repairAttempt = $repairAttempt
        rootDefectId = $rootDefectId
        updatedAt = Get-Date -Format o
    } | ConvertTo-Json -Depth 4 | Set-Content -LiteralPath $AccountingPath -Encoding UTF8
}

function Write-ControllerState {
    param(
        [string]$Status,
        [int]$Run,
        [string]$Model,
        [string]$Checkpoint,
        [string]$Reason,
        [string]$LogPath
    )

    [ordered]@{
        p = $P
        status = $Status
        updatedAt = Get-Date -Format o
        controllerPid = $PID
        run = $Run
        model = $Model
        checkpoint = $Checkpoint
        reason = $Reason
        repairAttempt = $repairAttempt
        rootDefectId = $rootDefectId
        latestRunLog = $LogPath
        recoveryMode = $recoveryMode
        applicationBranch = Get-GitBranch $AppRepo
        applicationSha = Get-GitHead $AppRepo
        governanceSha = Get-GitHead $GovernanceRepo
    } | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath $ControllerStatePath -Encoding UTF8
}

if ($HeartbeatSeconds -lt 15) {
    throw 'HeartbeatSeconds must be at least 15.'
}

Remove-Item -LiteralPath $HeartbeatStopPath -Force -ErrorAction SilentlyContinue
Write-Accounting
Write-ControllerState -Status 'STARTING' -Run 0 -Model '' -Checkpoint 'STARTING' -Reason '' -LogPath ''

$heartbeatJob = Start-Job -ArgumentList @($HeartbeatPath,$HeartbeatStopPath,$ControllerStatePath,$HeartbeatSeconds,$P) -ScriptBlock {
    param($HeartbeatPath,$StopPath,$StatePath,$Seconds,$PId)

    while (-not (Test-Path -LiteralPath $StopPath)) {
        $state = $null
        try {
            $state = Get-Content -LiteralPath $StatePath -Raw | ConvertFrom-Json
        }
        catch {
            $state = $null
        }

        $status = 'UNKNOWN'
        $run = 0
        $checkpoint = 'UNKNOWN'
        if ($null -ne $state) {
            $status = [string]$state.status
            $run = [int]$state.run
            $checkpoint = [string]$state.checkpoint
        }

        [ordered]@{
            p = $PId
            alive = $true
            timestamp = Get-Date -Format o
            status = $status
            run = $run
            checkpoint = $checkpoint
        } | ConvertTo-Json -Depth 4 | Set-Content -LiteralPath $HeartbeatPath -Encoding UTF8

        Start-Sleep -Seconds $Seconds
    }
}

$runNumber = 0
$consecutiveFailures = 0
$readinessRejections = 0
$latestRunLog = ''

try {
    Write-Host "PRYSM $P CONTINUOUS AUTORUN STARTED"
    Write-Host "Branch:        $(Get-GitBranch $AppRepo)"
    Write-Host "Recovery mode: $recoveryMode"
    Write-Host "Logs:          $LocalRoot"
    Write-Host 'Builder relaunches automatically until deterministic READY_FOR_BRAD or a true blocker.'

    while ($true) {
        if ($MaxRuns -gt 0 -and $runNumber -ge $MaxRuns) {
            throw "Safety run limit reached: $MaxRuns"
        }

        if ($repairAttempt -ge 3) {
            $reason = "Three same-root repair attempts exhausted for '$rootDefectId'. No fourth attempt allowed."
            Write-ControllerState -Status 'BLOCKED' -Run $runNumber -Model '' -Checkpoint 'THREE_ATTEMPTS_EXHAUSTED' -Reason $reason -LogPath $latestRunLog
            Send-TerminalNotification -Kind 'BLOCKED' -ApplicationSha (Get-GitHead $AppRepo) -GovernanceSha (Get-GitHead $GovernanceRepo) -Reason $reason -NextAction 'Review the durable P# state and intervene on the unchanged root defect.' -RunLog $latestRunLog
            break
        }

        $model = Get-ModelForAttempt $repairAttempt
        if (-not $model) {
            throw "No governed model for repair attempt $repairAttempt"
        }

        $runNumber++
        $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
        $runDir = Join-Path $LocalRoot ("run-{0:D4}-{1}-builder-level{2}" -f $runNumber,$stamp,($repairAttempt + 1))
        New-Item -ItemType Directory -Force -Path $runDir | Out-Null

        $finalPath = Join-Path $runDir 'final.json'
        $stdoutPath = Join-Path $runDir 'stdout.log'
        $stderrPath = Join-Path $runDir 'stderr.log'
        $transcriptPath = Join-Path $runDir 'codex-output.log'
        $promptPath = Join-Path $runDir 'prompt.md'
        $latestRunLog = $transcriptPath

        $runtime = @"
# CONTROLLER RUNTIME CONTEXT

Active P#: $P
Role: Builder
Controller run: $runNumber
Application local path: $AppRepo
Governance local path: $GovernanceRepo
P execution gate: $GatePath
Initial recovery mode: $recoveryMode
Current model: $model
Current repair_attempt: $repairAttempt
Current root_defect_id: $rootDefectId

CONTROLLER RULES
- Echo repair_attempt exactly: $repairAttempt.
- Return CONTINUE + next_role=Builder whenever more Builder work remains.
- A normal end-of-turn is never a workflow stop.
- Do not route to Auditor/Betty. Brad is the next human boundary.
- Claim READY_FOR_BRAD only after all required proof is green, the application candidate and governance are committed/pushed/clean, P# governance is advanced to OUTCOME_REVIEW, and the exact returned SHAs are authoritative.
- A READY_FOR_BRAD claim is independently rejected by the controller unless the official deterministic PRYSM gate passes for Authorized actor: BRAD.
- Preserve the current governed application worktree and recover incomplete checkpoints before starting new work.
- Route from CURRENT_STATE.md and the active P# reopened evidence chain, not stale historical PRYSM_AUTORUN_STATE.json.
"@

        $basePrompt = Get-Content -LiteralPath $BuilderPromptPath -Raw
        ($runtime + "`r`n" + $basePrompt) | Set-Content -LiteralPath $promptPath -Encoding UTF8

        $codexArgs = @(
            '--ask-for-approval','never',
            '--sandbox','danger-full-access',
            '--add-dir',$GovernanceRepo,
            'exec','--model',$model,'--cd',$AppRepo,'--color','never',
            '--output-schema',$SchemaPath,'--output-last-message',$finalPath,'-'
        )

        Write-ControllerState -Status 'RUNNING' -Run $runNumber -Model $model -Checkpoint 'BUILDER_RUNNING' -Reason '' -LogPath $transcriptPath
        Write-Host "`n=== $P BUILDER RUN $runNumber | $model | LEVEL $($repairAttempt + 1)/3 | ROOT $rootDefectId ==="
        Write-Host "Logs: $runDir"

        $exitCode = 1
        try {
            Get-Content -LiteralPath $promptPath -Raw | & $CodexCmdPath @codexArgs 1> $stdoutPath 2> $stderrPath
            $exitCode = $LASTEXITCODE
        }
        catch {
            $exitCode = 1
            ($_ | Out-String) | Set-Content -LiteralPath $stderrPath -Encoding UTF8
        }

        '=== STDOUT ===' | Set-Content -LiteralPath $transcriptPath -Encoding UTF8
        if (Test-Path -LiteralPath $stdoutPath) {
            Get-Content -LiteralPath $stdoutPath | Add-Content -LiteralPath $transcriptPath
        }
        '=== STDERR ===' | Add-Content -LiteralPath $transcriptPath
        if (Test-Path -LiteralPath $stderrPath) {
            Get-Content -LiteralPath $stderrPath | Add-Content -LiteralPath $transcriptPath
        }

        if ($exitCode -ne 0 -or -not (Test-Path -LiteralPath $finalPath)) {
            if (Test-UsageLimit -Paths @($stdoutPath,$stderrPath,$transcriptPath)) {
                $reason = 'Codex usage limit reached. No repair escalation consumed.'
                Write-ControllerState -Status 'BLOCKED' -Run $runNumber -Model $model -Checkpoint 'USAGE_LIMIT' -Reason $reason -LogPath $transcriptPath
                Send-TerminalNotification -Kind 'BLOCKED' -ApplicationSha (Get-GitHead $AppRepo) -GovernanceSha (Get-GitHead $GovernanceRepo) -Reason $reason -NextAction 'Resume the same P# controller after the usage allowance resets.' -RunLog $transcriptPath
                break
            }

            $consecutiveFailures++
            Write-Warning "Codex/controller execution failure $consecutiveFailures/$MaxConsecutiveFailures. No repair escalation consumed."
            if ($consecutiveFailures -ge $MaxConsecutiveFailures) {
                throw "Repeated Codex/controller execution failure. See $transcriptPath"
            }
            Start-Sleep -Seconds $DelaySeconds
            continue
        }

        try {
            $result = Get-Content -LiteralPath $finalPath -Raw | ConvertFrom-Json
        }
        catch {
            $consecutiveFailures++
            if ($consecutiveFailures -ge $MaxConsecutiveFailures) {
                throw "Repeated structured-result parse failure. See $transcriptPath"
            }
            Start-Sleep -Seconds $DelaySeconds
            continue
        }
        $consecutiveFailures = 0

        $returnedRoot = Normalize-RootId ([string]$result.root_defect_id)
        $failureClass = [string]$result.failure_class

        if ($failureClass -eq 'NEW_ROOT_CAUSE') {
            $rootDefectId = $returnedRoot
            $repairAttempt = 0
        }
        elseif ($returnedRoot -ne 'NONE' -and $rootDefectId -ne 'NONE' -and $returnedRoot -ne $rootDefectId) {
            $rootDefectId = $returnedRoot
            $repairAttempt = 0
        }
        elseif ($failureClass -eq 'REPAIR_PROOF_FAILED') {
            if ($rootDefectId -eq 'NONE' -and $returnedRoot -ne 'NONE') {
                $rootDefectId = $returnedRoot
            }
            $repairAttempt++
        }
        elseif ($rootDefectId -eq 'NONE' -and $returnedRoot -ne 'NONE') {
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

        if ($route -eq 'CONTRACT_VIOLATION') {
            $readinessRejections++
            $reason = 'Builder attempted to route directly to Auditor/Betty instead of the human Brad boundary.'
            Write-Warning $reason
            if ($readinessRejections -ge $MaxReadinessRejections) {
                throw "Repeated Builder handoff contract violations. $reason"
            }
            Write-ControllerState -Status 'CONTINUING' -Run $runNumber -Model $model -Checkpoint 'HANDOFF_CONTRACT_REJECTED' -Reason $reason -LogPath $transcriptPath
            Start-Sleep -Seconds $DelaySeconds
            continue
        }

        if ($route -eq 'READY_FOR_BRAD_CLAIM') {
            try {
                Assert-ReadyForBrad -Result $result -AppRepo $AppRepo -GovernanceRepo $GovernanceRepo -Bash $Bash
                $readinessRejections = 0
                Write-ControllerState -Status 'READY_FOR_BRAD' -Run $runNumber -Model $model -Checkpoint 'READY_FOR_BRAD' -Reason ([string]$result.reason) -LogPath $transcriptPath
                Send-TerminalNotification -Kind 'READY_FOR_BRAD' -ApplicationSha ([string]$result.application_sha) -GovernanceSha ([string]$result.governance_sha) -Reason ([string]$result.reason) -NextAction 'Brad OUTCOME_REVIEW' -RunLog $transcriptPath
                Write-Host "PRYSM $P READY FOR BRAD"
                break
            }
            catch {
                $readinessRejections++
                $reason = "READY_FOR_BRAD claim rejected by deterministic readiness checks: $($_.Exception.Message)"
                Write-Warning $reason
                if ($readinessRejections -ge $MaxReadinessRejections) {
                    throw "Repeated false/incomplete READY_FOR_BRAD claims. $reason"
                }
                Write-ControllerState -Status 'CONTINUING' -Run $runNumber -Model $model -Checkpoint 'READINESS_REJECTED' -Reason $reason -LogPath $transcriptPath
                Start-Sleep -Seconds $DelaySeconds
                continue
            }
        }

        $reason = [string]$result.reason
        if ([string]::IsNullOrWhiteSpace($reason)) {
            $reason = "Unsafe terminal result: $($result.loop_action)/$($result.next_role)/$($result.checkpoint)"
        }
        Write-ControllerState -Status 'BLOCKED' -Run $runNumber -Model $model -Checkpoint ([string]$result.checkpoint) -Reason $reason -LogPath $transcriptPath
        Send-TerminalNotification -Kind 'BLOCKED' -ApplicationSha (Get-GitHead $AppRepo) -GovernanceSha (Get-GitHead $GovernanceRepo) -Reason $reason -NextAction ([string]$result.next_action) -RunLog $transcriptPath
        Write-Host "PRYSM $P BLOCKED"
        break
    }
}
catch {
    $reason = $_.Exception.Message
    try {
        Write-ControllerState -Status 'CONTROLLER_FAILURE' -Run $runNumber -Model '' -Checkpoint 'CONTROLLER_FAILURE' -Reason $reason -LogPath $latestRunLog
    }
    catch {}
    try {
        Send-TerminalNotification -Kind 'CONTROLLER_FAILURE' -ApplicationSha (Get-GitHead $AppRepo) -GovernanceSha (Get-GitHead $GovernanceRepo) -Reason $reason -NextAction 'Inspect latest run log.' -RunLog $latestRunLog
    }
    catch {}
    throw
}
finally {
    try {
        New-Item -ItemType File -Force -Path $HeartbeatStopPath | Out-Null
    }
    catch {}

    if ($heartbeatJob) {
        try { Wait-Job $heartbeatJob -Timeout 3 | Out-Null } catch {}
        try { Stop-Job $heartbeatJob -ErrorAction SilentlyContinue | Out-Null } catch {}
        try { Remove-Job $heartbeatJob -Force -ErrorAction SilentlyContinue | Out-Null } catch {}
    }

    Remove-Item -LiteralPath $AppLockPath -Force -ErrorAction SilentlyContinue
    Remove-Item -LiteralPath $GovernanceLockPath -Force -ErrorAction SilentlyContinue
}
