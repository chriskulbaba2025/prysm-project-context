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
    [int]$MaxNoProgress = 3,
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

$ProtectedGovernancePaths = @(
    'tools/prysm/PRYSM-P-AUTORUN.ps1',
    'tools/prysm/START-PRYSM-P-AUTORUN.ps1',
    'tools/prysm/PRYSM-P-BUILDER-AUTORUN-PROMPT.md',
    'tools/prysm/test-prysm-p-autorun-contract.ps1',
    'tools/autorun/PRYSM-AUTORUN-RESULT.schema.json',
    'DECISION_PRYSM_P_SCOPED_CONTINUOUS_BUILDER_AUTORUN_2026-09-05.md',
    'PRYSM_PERMANENT_MEMORY.md'
)

function Resolve-RequiredPath {
    param([string]$Path,[string]$Label)
    if ([string]::IsNullOrWhiteSpace($Path) -or -not (Test-Path -LiteralPath $Path)) { throw "$Label does not exist: $Path" }
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

function Resolve-Bash {
    $gitBash = 'C:\Program Files\Git\bin\bash.exe'
    if (Test-Path -LiteralPath $gitBash) { return $gitBash }
    $bash = Get-Command bash -ErrorAction SilentlyContinue
    if ($bash -and $bash.Source) { return $bash.Source }
    throw 'Git Bash was not found.'
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
    if ([string]::IsNullOrWhiteSpace($Value)) { return 'NONE' }
    return $Value.Trim()
}

function Get-PathLockName {
    param([string]$Value)
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($Value.ToLowerInvariant())
    $sha = [System.Security.Cryptography.SHA256]::Create()
    try { $hash = $sha.ComputeHash($bytes) } finally { $sha.Dispose() }
    return (($hash | ForEach-Object { $_.ToString('x2') }) -join '').Substring(0,16)
}

function Get-StringSha256 {
    param([string]$Value)
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($Value)
    $sha = [System.Security.Cryptography.SHA256]::Create()
    try { $hash = $sha.ComputeHash($bytes) } finally { $sha.Dispose() }
    return (($hash | ForEach-Object { $_.ToString('x2') }) -join '')
}

function Get-GitHead { param([string]$Path) return ((& git -C $Path rev-parse HEAD).Trim()) }
function Get-GitBranch { param([string]$Path) return ((& git -C $Path branch --show-current).Trim()) }
function Get-GitStatus { param([string]$Path) return ((& git -C $Path status --porcelain=v1 --untracked-files=all) -join "`n") }

function Test-GitAncestor {
    param([string]$Repo,[string]$Ancestor,[string]$Descendant)
    & git -C $Repo merge-base --is-ancestor $Ancestor $Descendant *> $null
    return ($LASTEXITCODE -eq 0)
}

function Get-ChangedPaths {
    param([string]$Repo)
    $paths = @()
    foreach ($line in (& git -C $Repo status --porcelain=v1 --untracked-files=all)) {
        if ([string]::IsNullOrWhiteSpace($line)) { continue }
        $path = $line.Substring(3)
        if ($path -match ' -> ') { $path = ($path -split ' -> ')[-1] }
        $paths += $path.Replace('\','/')
    }
    return @($paths | Sort-Object -Unique)
}

function Get-TransactionChangedPaths {
    param([string]$Repo,[string]$PreHead,[string]$PostHead)
    $paths = @()
    if (-not [string]::IsNullOrWhiteSpace($PreHead) -and -not [string]::IsNullOrWhiteSpace($PostHead) -and $PreHead -ne $PostHead) {
        foreach ($path in (& git -C $Repo diff --name-only $PreHead $PostHead)) {
            if (-not [string]::IsNullOrWhiteSpace($path)) { $paths += $path.Replace('\','/') }
        }
    }
    $paths += @(Get-ChangedPaths $Repo)
    return @($paths | Sort-Object -Unique)
}

function Get-RepoFingerprint {
    param([string]$Repo)
    $head = Get-GitHead $Repo
    $branch = Get-GitBranch $Repo
    $status = Get-GitStatus $Repo
    $trackedDiff = (& git -C $Repo diff --binary HEAD 2>$null | Out-String)
    $untracked = @()
    foreach ($path in (& git -C $Repo ls-files --others --exclude-standard)) {
        if ([string]::IsNullOrWhiteSpace($path)) { continue }
        $full = Join-Path $Repo $path
        $hash = 'MISSING'
        if (Test-Path -LiteralPath $full -PathType Leaf) {
            try { $hash = (Get-FileHash -Algorithm SHA256 -LiteralPath $full).Hash.ToLowerInvariant() } catch { $hash = 'UNHASHABLE' }
        }
        $untracked += "$path=$hash"
    }
    $payload = "branch=$branch`nhead=$head`nstatus=$status`ntracked=$trackedDiff`nuntracked=$($untracked -join "`n")"
    return [pscustomobject]@{
        branch = $branch
        head = $head
        status = $status
        changedPaths = @(Get-ChangedPaths $Repo)
        sha256 = Get-StringSha256 $payload
    }
}

function Get-ControlPlaneFingerprint {
    param([string]$GovernanceRepo)
    $parts = @()
    foreach ($path in $ProtectedGovernancePaths) {
        $blob = (& git -C $GovernanceRepo rev-parse "HEAD:$path" 2>$null | Out-String).Trim()
        if ([string]::IsNullOrWhiteSpace($blob)) { throw "Protected control-plane file is missing from HEAD: $path" }
        $parts += "$path=$blob"
    }
    return Get-StringSha256 ($parts -join "`n")
}

function Get-Route {
    param($Result)
    $checkpoint = [string]$Result.checkpoint
    $loopAction = [string]$Result.loop_action
    $nextRole = [string]$Result.next_role
    if ($loopAction -eq 'BLOCKED') { return 'BLOCKED' }
    if ($checkpoint -eq 'READY_FOR_BRAD') { return 'READY_FOR_BRAD_CLAIM' }
    if ($nextRole -eq 'Auditor') { return 'CONTRACT_VIOLATION' }
    if ($nextRole -eq 'Builder' -and $loopAction -in @('CONTINUE','STOP')) { return 'CONTINUE' }
    if ($loopAction -eq 'CONTINUE' -and $nextRole -eq 'NONE') { return 'CONTINUE' }
    return 'BLOCKED'
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

function Send-DesktopNotification {
    param([string]$Title,[string]$Message,[ValidateSet('Info','Warning','Error')][string]$Level)
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
        [string]$ApplicationSha='UNBOUND',[string]$GovernanceSha='UNBOUND',
        [string]$Reason='',[string]$NextAction='',[string]$RunLog=''
    )
    if ($Kind -eq 'READY_FOR_BRAD') {
        Send-DesktopNotification -Title "PRYSM $P READY FOR BRAD" -Level 'Info' -Message "Application SHA: $ApplicationSha`nGovernance SHA: $GovernanceSha`nDeterministic Brad handoff gate: PASS`nNext actor: Brad"
        return
    }
    if ($Kind -eq 'BLOCKED') {
        Send-DesktopNotification -Title "PRYSM $P BLOCKED" -Level 'Warning' -Message "Blocker: $Reason`nApplication SHA: $ApplicationSha`nGovernance SHA: $GovernanceSha`nNext action: $NextAction"
        return
    }
    Send-DesktopNotification -Title "PRYSM $P CONTROLLER FAILURE" -Level 'Error' -Message "Failure: $Reason`nLatest run log: $RunLog"
}

function Assert-CodexFeatures {
    param([string]$CodexCmdPath)
    $rootHelp = (& $CodexCmdPath --help 2>&1 | Out-String)
    if ($LASTEXITCODE -ne 0) { throw 'Codex --help failed.' }
    $execHelp = (& $CodexCmdPath exec --help 2>&1 | Out-String)
    if ($LASTEXITCODE -ne 0) { throw 'Codex exec --help failed.' }
    foreach ($required in @('--ask-for-approval','--sandbox','--add-dir','--output-schema','--output-last-message','--model','--cd')) {
        if ($rootHelp -notmatch [regex]::Escape($required) -and $execHelp -notmatch [regex]::Escape($required)) { throw "Installed Codex CLI does not advertise required option: $required" }
    }
    if ($rootHelp -notmatch 'danger-full-access' -and $execHelp -notmatch 'danger-full-access') { throw 'Installed Codex CLI does not advertise danger-full-access.' }
}

function Assert-CurrentStateStage {
    param([string]$GovernanceRepo,[string]$ExpectedStage,[string]$ExpectedActorPattern)
    $statePath = Join-Path $GovernanceRepo 'CURRENT_STATE.md'
    if (-not (Test-Path -LiteralPath $statePath)) { throw 'CURRENT_STATE.md is missing.' }
    $text = Get-Content -LiteralPath $statePath -Raw
    $stageEsc = [regex]::Escape($ExpectedStage)
    if ($text -notmatch "(?m)^- Authorized stage:\s+.*$stageEsc.*$") { throw "CURRENT_STATE.md does not authorize stage $ExpectedStage." }
    if ($text -match '(?m)^- Current stage:\s+([A-Z_]+)\s*$') {
        if ($Matches[1] -ne $ExpectedStage) { throw "CURRENT_STATE current stage is $($Matches[1]), expected $ExpectedStage." }
    } else { throw 'CURRENT_STATE.md does not contain an exact Current stage line.' }
    if (-not [string]::IsNullOrWhiteSpace($ExpectedActorPattern) -and $text -notmatch "(?m)^- Authorized actor:\s+.*$ExpectedActorPattern.*$") {
        throw "CURRENT_STATE.md does not authorize expected actor pattern $ExpectedActorPattern."
    }
}

function Invoke-OfficialGate {
    param([string]$Bash,[string]$ExpectedStage,[string]$ExpectedActor)
    $gateOutput = (& $Bash $CurrentSessionLauncher $P 2>&1 | Out-String)
    if ($LASTEXITCODE -ne 0) { throw "Official PRYSM deterministic gate failed.`n$gateOutput" }
    if ($gateOutput -notmatch 'PRYSM PROCESS GATE PASS') { throw "Official gate did not emit PASS.`n$gateOutput" }
    if ($gateOutput -notmatch [regex]::Escape("Authorized stage: $ExpectedStage")) { throw "Official gate stage mismatch.`n$gateOutput" }
    if ($gateOutput -notmatch [regex]::Escape("Authorized actor: $ExpectedActor")) { throw "Official gate actor mismatch.`n$gateOutput" }
    return $gateOutput
}

function Acquire-ResourceLock {
    param([string]$Path,[string]$Body)
    if (Test-Path -LiteralPath $Path) {
        $existing = Get-Content -LiteralPath $Path -Raw -ErrorAction SilentlyContinue
        $live = $false
        if ($existing -match '(?m)^PID=(\d+)$') {
            try { Get-Process -Id ([int]$Matches[1]) -ErrorAction Stop | Out-Null; $live = $true } catch {}
        }
        if ($live) { throw "Another PRYSM controller is using this resource. Lock: $Path`n$existing" }
        Remove-Item -LiteralPath $Path -Force
    }
    $Body | Set-Content -LiteralPath $Path -Encoding ASCII
}

function Assert-ControlPlaneUnmodified {
    param([string]$GovernanceRepo,[string]$ExpectedFingerprint)
    foreach ($path in $ProtectedGovernancePaths) {
        & git -C $GovernanceRepo diff --quiet HEAD -- $path
        if ($LASTEXITCODE -ne 0) { throw "Builder modified protected PRYSM control-plane file: $path" }
    }
    if (-not [string]::IsNullOrWhiteSpace($ExpectedFingerprint)) {
        $current = Get-ControlPlaneFingerprint $GovernanceRepo
        if ($current -ne $ExpectedFingerprint) { throw 'Committed PRYSM control-plane fingerprint changed during Builder execution.' }
    }
}

function Read-JsonFile {
    param([string]$Path)
    if (-not (Test-Path -LiteralPath $Path)) { return $null }
    try { return (Get-Content -LiteralPath $Path -Raw | ConvertFrom-Json) } catch { return $null }
}

function Write-JsonFile {
    param([string]$Path,$Value)
    $Value | ConvertTo-Json -Depth 12 | Set-Content -LiteralPath $Path -Encoding UTF8
}

function Test-P1ApplicationBoundary {
    param([string[]]$Paths)
    $allowed = @(
        'services/worker/src/report/foundation-readiness.js',
        'services/worker/src/report/render-report-v2.js',
        'services/worker/src/report/report-detail-sections.js',
        'services/worker/src/report/render-report-v2-conversion.test.js',
        'services/worker/src/report-model/cross-report-interpretation.js',
        'services/worker/src/report-model/cross-report-interpretation.test.js'
    )
    foreach ($path in $Paths) { if ($allowed -notcontains $path) { return $false } }
    return $true
}

function Test-P1GovernanceBoundary {
    param([string[]]$Paths)
    foreach ($path in $Paths) {
        $ok = $false
        if ($path -eq 'CURRENT_STATE.md' -or $path -eq 'P1_EXECUTION_GATE.env') { $ok = $true }
        elseif ($path -like 'P1_*') { $ok = $true }
        elseif ($path -like 'proof/P1/*') { $ok = $true }
        if (-not $ok) { return $false }
    }
    return $true
}

function Assert-P1TransactionBoundary {
    param([string]$AppRepo,[string]$GovernanceRepo,$PreApp,$PostApp,$PreGov,$PostGov)
    if ($P -ne 'P1') { return }
    $appPaths = @(Get-TransactionChangedPaths -Repo $AppRepo -PreHead ([string]$PreApp.head) -PostHead ([string]$PostApp.head))
    if (-not (Test-P1ApplicationBoundary -Paths $appPaths)) { throw "P1 application transaction escaped the authorized seam: $($appPaths -join ', ')" }
    $govPaths = @(Get-TransactionChangedPaths -Repo $GovernanceRepo -PreHead ([string]$PreGov.head) -PostHead ([string]$PostGov.head))
    if (-not (Test-P1GovernanceBoundary -Paths $govPaths)) { throw "P1 governance transaction escaped the authorized seam: $($govPaths -join ', ')" }
}

function JournalMatchesFingerprint {
    param($Journal,[string]$Side,[string]$Fingerprint)
    if ($null -eq $Journal) { return $false }
    $node = $null
    if ($Side -eq 'Application') { $node = $Journal.postApplication }
    if ($Side -eq 'Governance') { $node = $Journal.postGovernance }
    if ($null -eq $node) { return $false }
    return ([string]$node.sha256 -eq $Fingerprint)
}

function Get-GovernanceRecovery {
    param([string]$GovernanceRepo,$Anchor,$Journal)
    if ((Get-GitBranch $GovernanceRepo) -ne 'main') { throw 'Governance repository must remain on main.' }
    & git -C $GovernanceRepo fetch origin main | Out-Null
    if ($LASTEXITCODE -ne 0) { throw 'Governance origin fetch failed.' }
    $local = Get-GitHead $GovernanceRepo
    $remote = ((& git -C $GovernanceRepo rev-parse origin/main).Trim())
    $fingerprint = Get-RepoFingerprint $GovernanceRepo

    if ($local -eq $remote -and [string]::IsNullOrWhiteSpace([string]$fingerprint.status)) { return 'GOV_SYNCED' }
    if ([string]::IsNullOrWhiteSpace([string]$fingerprint.status) -and (Test-GitAncestor -Repo $GovernanceRepo -Ancestor $local -Descendant $remote)) {
        & git -C $GovernanceRepo pull --ff-only origin main | Out-Null
        if ($LASTEXITCODE -ne 0) { throw 'Governance fast-forward recovery failed.' }
        return 'GOV_FAST_FORWARDED'
    }
    if ($null -eq $Anchor) { throw "Governance differs from origin/main without a P# entry anchor. Local=$local Remote=$remote" }
    $anchorGov = [string]$Anchor.governanceShaAtEntry
    if (-not (Test-GitAncestor -Repo $GovernanceRepo -Ancestor $anchorGov -Descendant $local)) { throw 'Governance local HEAD is outside the recorded P# entry lineage.' }
    if (-not (Test-GitAncestor -Repo $GovernanceRepo -Ancestor $remote -Descendant $local)) { throw "Governance origin/main is not an ancestor of local recovery state. Local=$local Remote=$remote" }

    if (JournalMatchesFingerprint -Journal $Journal -Side 'Governance' -Fingerprint $fingerprint.sha256) {
        if ([string]::IsNullOrWhiteSpace([string]$fingerprint.status)) { return 'GOV_JOURNALED_CLEAN_RECOVERY' }
        return 'GOV_JOURNALED_DIRTY_RECOVERY'
    }
    if ($null -ne $Journal -and [string]$Journal.status -eq 'RUNNING') { return 'GOV_INTERRUPTED_RUNNING_RECOVERY' }
    throw 'Governance state does not equal the last journaled post-state and is not a live interrupted transaction.'
}

function Get-ApplicationRecovery {
    param([hashtable]$Gate,[string]$AppRepo,$Anchor,$Journal)
    if (-not $Gate.ContainsKey('APPLICATION_BRANCH') -or -not $Gate.ContainsKey('APPLICATION_SHA')) { throw 'P gate is missing application identity.' }
    $branch = Get-GitBranch $AppRepo
    if ($branch -ne $Gate['APPLICATION_BRANCH']) { throw "Application branch mismatch. Current=$branch Required=$($Gate['APPLICATION_BRANCH'])" }
    & git -C $AppRepo fetch origin $branch | Out-Null
    if ($LASTEXITCODE -ne 0) { throw "Application fetch failed for origin/$branch." }
    $head = Get-GitHead $AppRepo
    $origin = ((& git -C $AppRepo rev-parse "origin/$branch").Trim())
    $fingerprint = Get-RepoFingerprint $AppRepo
    $gateSha = [string]$Gate['APPLICATION_SHA']

    if (-not (Test-GitAncestor -Repo $AppRepo -Ancestor $gateSha -Descendant $head)) { throw "Application HEAD is outside the gated lineage. HEAD=$head Gate=$gateSha" }
    if (-not (Test-GitAncestor -Repo $AppRepo -Ancestor $gateSha -Descendant $origin)) { throw "origin/$branch is outside the gated lineage. Origin=$origin Gate=$gateSha" }

    if ($head -eq $gateSha -and $origin -eq $gateSha -and [string]::IsNullOrWhiteSpace([string]$fingerprint.status)) { return 'APP_EXACT_GATE_CLEAN' }
    if ([string]::IsNullOrWhiteSpace([string]$fingerprint.status) -and (Test-GitAncestor -Repo $AppRepo -Ancestor $head -Descendant $origin)) {
        & git -C $AppRepo pull --ff-only origin $branch | Out-Null
        if ($LASTEXITCODE -ne 0) { throw 'Application fast-forward recovery failed.' }
        return 'APP_FAST_FORWARDED_DESCENDANT'
    }

    if ($null -eq $Anchor) {
        if ($P -eq 'P1' -and $head -eq $gateSha -and $origin -eq $gateSha -and -not [string]::IsNullOrWhiteSpace([string]$fingerprint.status)) {
            $paths = @(Get-ChangedPaths $AppRepo)
            if (-not (Test-P1ApplicationBoundary -Paths $paths)) { throw "Initial dirty P1 worktree contains paths outside the reopened repair seam: $($paths -join ', ')" }
            return 'APP_P1_INITIAL_DIRTY_ADOPTION'
        }
        throw 'Application continuation differs from the gate without a verified P# entry anchor.'
    }

    if ([string]$Anchor.p -ne $P -or [string]$Anchor.applicationBranch -ne $branch -or [string]$Anchor.baseGateSha -ne $gateSha) { throw 'P# entry anchor does not match the active application gate.' }
    if (-not (Test-GitAncestor -Repo $AppRepo -Ancestor $origin -Descendant $head)) { throw "Application local branch diverged from or fell behind origin/$branch. Local=$head Origin=$origin" }

    if ($fingerprint.sha256 -eq [string]$Anchor.applicationFingerprintAtEntry) { return 'APP_ANCHORED_ENTRY_RECOVERY' }
    if (JournalMatchesFingerprint -Journal $Journal -Side 'Application' -Fingerprint $fingerprint.sha256) {
        if ([string]::IsNullOrWhiteSpace([string]$fingerprint.status)) { return 'APP_JOURNALED_CLEAN_RECOVERY' }
        return 'APP_JOURNALED_DIRTY_RECOVERY'
    }
    if ($null -ne $Journal -and [string]$Journal.status -eq 'RUNNING') { return 'APP_INTERRUPTED_RUNNING_RECOVERY' }
    throw 'Application state does not equal the entry baseline or the last journaled post-state.'
}

function Sync-LoopLineage {
    param([string]$AppRepo,[string]$GovernanceRepo)
    & git -C $GovernanceRepo fetch origin main | Out-Null
    if ($LASTEXITCODE -ne 0) { throw 'Governance fetch failed during loop.' }
    $govLocal = Get-GitHead $GovernanceRepo
    $govRemote = ((& git -C $GovernanceRepo rev-parse origin/main).Trim())
    $govStatus = Get-GitStatus $GovernanceRepo
    if ($govLocal -ne $govRemote -and -not (Test-GitAncestor -Repo $GovernanceRepo -Ancestor $govRemote -Descendant $govLocal)) {
        if ([string]::IsNullOrWhiteSpace($govStatus) -and (Test-GitAncestor -Repo $GovernanceRepo -Ancestor $govLocal -Descendant $govRemote)) {
            & git -C $GovernanceRepo pull --ff-only origin main | Out-Null
            if ($LASTEXITCODE -ne 0) { throw 'Governance loop fast-forward failed.' }
        } else { throw 'Governance origin moved outside the active local transaction lineage.' }
    }

    $branch = Get-GitBranch $AppRepo
    & git -C $AppRepo fetch origin $branch | Out-Null
    if ($LASTEXITCODE -ne 0) { throw 'Application fetch failed during loop.' }
    $appLocal = Get-GitHead $AppRepo
    $appRemote = ((& git -C $AppRepo rev-parse "origin/$branch").Trim())
    $appStatus = Get-GitStatus $AppRepo
    if ($appLocal -ne $appRemote -and -not (Test-GitAncestor -Repo $AppRepo -Ancestor $appRemote -Descendant $appLocal)) {
        if ([string]::IsNullOrWhiteSpace($appStatus) -and (Test-GitAncestor -Repo $AppRepo -Ancestor $appLocal -Descendant $appRemote)) {
            & git -C $AppRepo pull --ff-only origin $branch | Out-Null
            if ($LASTEXITCODE -ne 0) { throw 'Application loop fast-forward failed.' }
        } else { throw 'Application origin moved outside the active local transaction lineage.' }
    }
}

function Assert-ReadyForBrad {
    param($Result,[string]$AppRepo,[string]$GovernanceRepo,[string]$Bash)
    if ([string]$Result.checkpoint -ne 'READY_FOR_BRAD') { throw 'READY claim is missing checkpoint READY_FOR_BRAD.' }
    if ([string]$Result.loop_action -ne 'STOP') { throw 'READY claim must use loop_action STOP.' }
    if ([string]$Result.next_role -ne 'NONE') { throw 'READY claim must stop before Brad; next_role must be NONE.' }
    if ([string]$Result.whole_app_gate -ne 'PASS') { throw 'READY claim requires whole_app_gate PASS.' }
    if ([int]$Result.material_defects -ne 0) { throw 'READY claim requires material_defects=0.' }
    if (-not [bool]$Result.github_state_synced) { throw 'READY claim requires github_state_synced=true.' }
    if (-not [string]::IsNullOrWhiteSpace((Get-GitStatus $AppRepo))) { throw 'Application tree is not clean at READY_FOR_BRAD.' }
    if (-not [string]::IsNullOrWhiteSpace((Get-GitStatus $GovernanceRepo))) { throw 'Governance tree is not clean at READY_FOR_BRAD.' }

    & git -C $GovernanceRepo fetch origin main | Out-Null
    if ($LASTEXITCODE -ne 0) { throw 'Governance fetch failed at readiness check.' }
    if ((Get-GitHead $GovernanceRepo) -ne ((& git -C $GovernanceRepo rev-parse origin/main).Trim())) { throw 'Governance is not synchronized with origin/main at readiness.' }
    $gatePath = Join-Path $GovernanceRepo ("{0}_EXECUTION_GATE.env" -f $P)
    $gateNow = Read-EnvFile $gatePath
    if ([string]$gateNow['AUTHORIZED_STAGE'] -ne 'OUTCOME_REVIEW') { throw 'P gate has not been advanced to OUTCOME_REVIEW.' }
    Assert-CurrentStateStage -GovernanceRepo $GovernanceRepo -ExpectedStage 'OUTCOME_REVIEW' -ExpectedActorPattern 'BRAD'

    $branch = Get-GitBranch $AppRepo
    & git -C $AppRepo fetch origin $branch | Out-Null
    if ($LASTEXITCODE -ne 0) { throw 'Application fetch failed at readiness check.' }
    $head = Get-GitHead $AppRepo
    $origin = ((& git -C $AppRepo rev-parse "origin/$branch").Trim())
    if ($head -ne $origin) { throw "Application candidate is not synchronized. Local=$head Remote=$origin" }
    if ([string]$Result.application_sha -ne $head) { throw 'Result application_sha does not equal the exact local candidate.' }
    if ([string]$Result.governance_sha -ne (Get-GitHead $GovernanceRepo)) { throw 'Result governance_sha does not equal authoritative governance HEAD.' }
    Invoke-OfficialGate -Bash $Bash -ExpectedStage 'OUTCOME_REVIEW' -ExpectedActor 'BRAD' | Out-Null
}

function Apply-RepairAccounting {
    param($Result,[ref]$RootDefectId,[ref]$RepairAttempt)
    $returnedRoot = Normalize-RootId ([string]$Result.root_defect_id)
    $failureClass = [string]$Result.failure_class
    $currentRoot = [string]$RootDefectId.Value

    if ($failureClass -eq 'NEW_ROOT_CAUSE') {
        if ($returnedRoot -eq 'NONE') { throw 'NEW_ROOT_CAUSE requires a non-NONE root_defect_id.' }
        if ($currentRoot -ne 'NONE' -and $returnedRoot -eq $currentRoot) { throw 'NEW_ROOT_CAUSE must identify a materially new root_defect_id.' }
        $RootDefectId.Value = $returnedRoot
        $RepairAttempt.Value = 0
        return
    }
    if ($failureClass -eq 'REPAIR_PROOF_FAILED') {
        if ($returnedRoot -eq 'NONE') { throw 'REPAIR_PROOF_FAILED requires a non-NONE root_defect_id.' }
        if ($currentRoot -ne 'NONE' -and $returnedRoot -ne $currentRoot) { throw 'Root identity changed without NEW_ROOT_CAUSE.' }
        if ($currentRoot -eq 'NONE') { $RootDefectId.Value = $returnedRoot }
        $RepairAttempt.Value = [int]$RepairAttempt.Value + 1
        return
    }
    if ($currentRoot -ne 'NONE' -and $returnedRoot -ne 'NONE' -and $returnedRoot -ne $currentRoot) { throw 'Root identity changed without NEW_ROOT_CAUSE.' }
    if ($currentRoot -eq 'NONE' -and $returnedRoot -ne 'NONE') { $RootDefectId.Value = $returnedRoot }
}

function Test-PreRunStage {
    param([string]$GovernanceRepo,[string]$AppRepo,[string]$Bash)
    $gatePath = Join-Path $GovernanceRepo ("{0}_EXECUTION_GATE.env" -f $P)
    $gateNow = Read-EnvFile $gatePath
    $stage = [string]$gateNow['AUTHORIZED_STAGE']
    if ($stage -in @('DIAGNOSTIC_TRUTH','BOUNDED_BUILD')) {
        Assert-CurrentStateStage -GovernanceRepo $GovernanceRepo -ExpectedStage $stage -ExpectedActorPattern 'BUILDER'
        return 'BUILDER'
    }
    if ($stage -eq 'OUTCOME_REVIEW') {
        if (-not [string]::IsNullOrWhiteSpace((Get-GitStatus $AppRepo))) { throw 'P# advanced to OUTCOME_REVIEW while application tree is dirty.' }
        if (-not [string]::IsNullOrWhiteSpace((Get-GitStatus $GovernanceRepo))) { throw 'P# advanced to OUTCOME_REVIEW while governance tree is dirty.' }
        Assert-CurrentStateStage -GovernanceRepo $GovernanceRepo -ExpectedStage 'OUTCOME_REVIEW' -ExpectedActorPattern 'BRAD'
        Invoke-OfficialGate -Bash $Bash -ExpectedStage 'OUTCOME_REVIEW' -ExpectedActor 'BRAD' | Out-Null
        return 'READY_FOR_BRAD'
    }
    throw "Unsupported or non-Builder P# stage encountered by autorun: $stage"
}

if ($TestNotification) {
    Send-TerminalNotification -Kind $TestNotification -ApplicationSha 'TEST-APP-SHA' -GovernanceSha 'TEST-GOV-SHA' -Reason 'Test only.' -NextAction 'Close this popup.' -RunLog 'TEST-NO-RUN'
    Write-Host "Notification test sent: $TestNotification"
    exit 0
}

foreach ($requiredPath in @($SchemaPath,$BuilderPromptPath,$CurrentSessionLauncher)) {
    if (-not (Test-Path -LiteralPath $requiredPath)) { throw "Missing autorun dependency: $requiredPath" }
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
    foreach ($case in $cases) { if ((Get-Route $case.Result) -ne $case.Expected) { throw "SelfTest route failure: $($case.Expected)" } }
    if ((Get-ModelForAttempt 0) -ne $ModelLuna -or (Get-ModelForAttempt 1) -ne $ModelTerra -or (Get-ModelForAttempt 2) -ne $ModelSol) { throw 'SelfTest model routing failed.' }
    $root = 'ROOT-A'; $attempt = 1
    $same = [pscustomobject]@{root_defect_id='ROOT-A';failure_class='REPAIR_PROOF_FAILED'}
    Apply-RepairAccounting -Result $same -RootDefectId ([ref]$root) -RepairAttempt ([ref]$attempt)
    if ($root -ne 'ROOT-A' -or $attempt -ne 2) { throw 'SelfTest repair escalation failed.' }
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
$JournalPath = Join-Path $LocalRoot 'transaction-journal.json'
$AppLockPath = Join-Path $SharedLockRoot ("app-{0}.lock" -f (Get-PathLockName $AppRepo))
$GovernanceLockPath = Join-Path $SharedLockRoot ("governance-{0}.lock" -f (Get-PathLockName $GovernanceRepo))

$lockBody = "PID=$PID`nP=$P`nStarted=$(Get-Date -Format o)`nAppRepo=$AppRepo`nGovernanceRepo=$GovernanceRepo`n"
if (-not $PreflightOnly) {
    Acquire-ResourceLock -Path $AppLockPath -Body $lockBody
    try { Acquire-ResourceLock -Path $GovernanceLockPath -Body $lockBody }
    catch { Remove-Item -LiteralPath $AppLockPath -Force -ErrorAction SilentlyContinue; throw }
}

$heartbeatJob = $null
$runNumber = 0
$latestRunLog = ''
$repairAttempt = 0
$rootDefectId = 'NONE'
$recoveryMode = ''

try {
    $anchor = Read-JsonFile $EntryAnchorPath
    $journal = Read-JsonFile $JournalPath
    $govRecovery = Get-GovernanceRecovery -GovernanceRepo $GovernanceRepo -Anchor $anchor -Journal $journal

    $GatePath = Join-Path $GovernanceRepo ("{0}_EXECUTION_GATE.env" -f $P)
    if (-not (Test-Path -LiteralPath $GatePath)) { throw "Missing P execution gate: $GatePath" }
    $gate = Read-EnvFile $GatePath
    if (-not $gate.ContainsKey('P_ID') -or $gate['P_ID'] -ne $P) { throw "P identity mismatch in $GatePath" }

    if ([string]$gate['AUTHORIZED_STAGE'] -notin @('DIAGNOSTIC_TRUTH','BOUNDED_BUILD')) {
        if ([string]$gate['AUTHORIZED_STAGE'] -eq 'OUTCOME_REVIEW') {
            $stageResult = Test-PreRunStage -GovernanceRepo $GovernanceRepo -AppRepo $AppRepo -Bash $Bash
            if ($stageResult -eq 'READY_FOR_BRAD') {
                if (-not $PreflightOnly) { Send-TerminalNotification -Kind 'READY_FOR_BRAD' -ApplicationSha (Get-GitHead $AppRepo) -GovernanceSha (Get-GitHead $GovernanceRepo) -NextAction 'Brad OUTCOME_REVIEW' }
                Write-Host "PRYSM $P READY FOR BRAD"
                return
            }
        }
        throw "$P is not in a Builder-owned stage."
    }
    Assert-CurrentStateStage -GovernanceRepo $GovernanceRepo -ExpectedStage ([string]$gate['AUTHORIZED_STAGE']) -ExpectedActorPattern 'BUILDER'

    $appRecovery = Get-ApplicationRecovery -Gate $gate -AppRepo $AppRepo -Anchor $anchor -Journal $journal
    $recoveryMode = "$govRecovery/$appRecovery"

    if ($null -eq $anchor -and -not $PreflightOnly) {
        if ($appRecovery -eq 'APP_EXACT_GATE_CLEAN') { Invoke-OfficialGate -Bash $Bash -ExpectedStage ([string]$gate['AUTHORIZED_STAGE']) -ExpectedActor 'BUILDER' | Out-Null }
        $appFingerprint = Get-RepoFingerprint $AppRepo
        $govFingerprint = Get-RepoFingerprint $GovernanceRepo
        $anchor = [ordered]@{
            p=$P;applicationBranch=[string]$gate['APPLICATION_BRANCH'];baseGateSha=[string]$gate['APPLICATION_SHA'];
            applicationShaAtEntry=$appFingerprint.head;applicationFingerprintAtEntry=$appFingerprint.sha256;
            governanceShaAtEntry=$govFingerprint.head;governanceFingerprintAtEntry=$govFingerprint.sha256;
            controlPlaneFingerprint=(Get-ControlPlaneFingerprint $GovernanceRepo);recoveryModeAtEntry=$recoveryMode;enteredAt=(Get-Date -Format o)
        }
        Write-JsonFile -Path $EntryAnchorPath -Value $anchor
    }

    if ($null -ne $anchor -and [string]::IsNullOrWhiteSpace([string]$anchor.controlPlaneFingerprint) -and -not $PreflightOnly) {
        $anchor | Add-Member -NotePropertyName controlPlaneFingerprint -NotePropertyValue (Get-ControlPlaneFingerprint $GovernanceRepo) -Force
        Write-JsonFile -Path $EntryAnchorPath -Value $anchor
    }
    $expectedControlPlane = if ($null -ne $anchor) { [string]$anchor.controlPlaneFingerprint } else { Get-ControlPlaneFingerprint $GovernanceRepo }
    Assert-ControlPlaneUnmodified -GovernanceRepo $GovernanceRepo -ExpectedFingerprint $expectedControlPlane

    if ($PreflightOnly) {
        Write-Host "PRYSM $P AUTORUN PREFLIGHT"
        Write-Host "Application:   $AppRepo"
        Write-Host "Governance:    $GovernanceRepo"
        Write-Host "Branch:        $(Get-GitBranch $AppRepo)"
        Write-Host "Stage:         $($gate['AUTHORIZED_STAGE'])"
        Write-Host "Recovery mode: $recoveryMode"
        Write-Host "Codex:         $CodexCmdPath"
        Write-Host "Local state:   $LocalRoot"
        Write-Host 'Approval:      never'
        Write-Host 'Sandbox:       danger-full-access'
        Write-Host 'PREFLIGHT PASS'
        return
    }

    $accounting = Read-JsonFile $AccountingPath
    if ($null -ne $accounting -and [string]$accounting.p -eq $P) {
        $repairAttempt = [int]$accounting.repairAttempt
        $rootDefectId = Normalize-RootId ([string]$accounting.rootDefectId)
    }
    if ($repairAttempt -lt 0) { $repairAttempt = 0 }
    if ($repairAttempt -gt 3) { $repairAttempt = 3 }

    function Write-Accounting {
        Write-JsonFile -Path $AccountingPath -Value ([ordered]@{p=$P;repairAttempt=$repairAttempt;rootDefectId=$rootDefectId;updatedAt=(Get-Date -Format o)})
    }
    function Write-ControllerState {
        param([string]$Status,[string]$Model,[string]$Checkpoint,[string]$Reason,[string]$LogPath)
        Write-JsonFile -Path $ControllerStatePath -Value ([ordered]@{
            p=$P;status=$Status;updatedAt=(Get-Date -Format o);controllerPid=$PID;run=$runNumber;model=$Model;
            checkpoint=$Checkpoint;reason=$Reason;repairAttempt=$repairAttempt;rootDefectId=$rootDefectId;
            latestRunLog=$LogPath;recoveryMode=$recoveryMode;applicationBranch=(Get-GitBranch $AppRepo);
            applicationSha=(Get-GitHead $AppRepo);governanceSha=(Get-GitHead $GovernanceRepo)
        })
    }

    if ($HeartbeatSeconds -lt 15) { throw 'HeartbeatSeconds must be at least 15.' }
    Remove-Item -LiteralPath $HeartbeatStopPath -Force -ErrorAction SilentlyContinue
    Write-Accounting
    Write-ControllerState -Status 'STARTING' -Model '' -Checkpoint 'STARTING' -Reason '' -LogPath ''

    $heartbeatJob = Start-Job -ArgumentList @($HeartbeatPath,$HeartbeatStopPath,$ControllerStatePath,$HeartbeatSeconds,$P) -ScriptBlock {
        param($HeartbeatPath,$StopPath,$StatePath,$Seconds,$PId)
        while (-not (Test-Path -LiteralPath $StopPath)) {
            $state = $null
            try { $state = Get-Content -LiteralPath $StatePath -Raw | ConvertFrom-Json } catch {}
            [ordered]@{
                p=$PId;alive=$true;timestamp=(Get-Date -Format o);
                status=if($state){[string]$state.status}else{'UNKNOWN'};
                run=if($state){[int]$state.run}else{0};
                checkpoint=if($state){[string]$state.checkpoint}else{'UNKNOWN'}
            } | ConvertTo-Json -Depth 4 | Set-Content -LiteralPath $HeartbeatPath -Encoding UTF8
            Start-Sleep -Seconds $Seconds
        }
    }

    $consecutiveFailures = 0
    $readinessRejections = 0
    $noProgressCount = 0
    $lastNoProgressSignature = ''
    Write-Host "PRYSM $P CONTINUOUS AUTORUN STARTED"
    Write-Host "Recovery mode: $recoveryMode"
    Write-Host "Logs: $LocalRoot"

    while ($true) {
        Assert-ControlPlaneUnmodified -GovernanceRepo $GovernanceRepo -ExpectedFingerprint $expectedControlPlane
        Sync-LoopLineage -AppRepo $AppRepo -GovernanceRepo $GovernanceRepo
        $stageNow = Test-PreRunStage -GovernanceRepo $GovernanceRepo -AppRepo $AppRepo -Bash $Bash
        if ($stageNow -eq 'READY_FOR_BRAD') {
            Write-ControllerState -Status 'READY_FOR_BRAD' -Model '' -Checkpoint 'READY_FOR_BRAD' -Reason 'Official deterministic gate authorizes Brad.' -LogPath $latestRunLog
            Send-TerminalNotification -Kind 'READY_FOR_BRAD' -ApplicationSha (Get-GitHead $AppRepo) -GovernanceSha (Get-GitHead $GovernanceRepo) -NextAction 'Brad OUTCOME_REVIEW'
            Write-Host "PRYSM $P READY FOR BRAD"
            break
        }
        if ($MaxRuns -gt 0 -and $runNumber -ge $MaxRuns) { throw "Safety run limit reached: $MaxRuns" }
        if ($repairAttempt -ge 3) {
            $reason = "Three same-root repair attempts exhausted for '$rootDefectId'. No fourth attempt allowed."
            Write-ControllerState -Status 'BLOCKED' -Model '' -Checkpoint 'THREE_ATTEMPTS_EXHAUSTED' -Reason $reason -LogPath $latestRunLog
            Send-TerminalNotification -Kind 'BLOCKED' -ApplicationSha (Get-GitHead $AppRepo) -GovernanceSha (Get-GitHead $GovernanceRepo) -Reason $reason -NextAction 'Review the unchanged root defect.' -RunLog $latestRunLog
            break
        }

        $model = Get-ModelForAttempt $repairAttempt
        if (-not $model) { throw "No governed model for repair attempt $repairAttempt" }
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

        $preApp = Get-RepoFingerprint $AppRepo
        $preGov = Get-RepoFingerprint $GovernanceRepo
        $transaction = [ordered]@{
            p=$P;run=$runNumber;status='RUNNING';startedAt=(Get-Date -Format o);model=$model;
            repairAttempt=$repairAttempt;rootDefectId=$rootDefectId;preApplication=$preApp;preGovernance=$preGov;runDirectory=$runDir
        }
        Write-JsonFile -Path $JournalPath -Value $transaction

        $runtime = @"
# CONTROLLER RUNTIME CONTEXT
Active P#: $P
Role: Builder
Controller run: $runNumber
Application local path: $AppRepo
Governance local path: $GovernanceRepo
P execution gate: $GatePath
Recovery mode: $recoveryMode
Current model: $model
Current repair_attempt: $repairAttempt
Current root_defect_id: $rootDefectId

CONTROLLER RULES
- Echo repair_attempt exactly: $repairAttempt.
- Return CONTINUE + next_role=Builder whenever more Builder work remains.
- A normal end-of-turn is never a workflow stop.
- Do not route to Auditor/Betty. Brad is the next human boundary.
- Do not edit the autorun controller, wrapper, schema, permanent memory, or autorun governance decision.
- Claim READY_FOR_BRAD only after proof is green, application/governance are committed, pushed, clean, and P# governance is advanced to OUTCOME_REVIEW.
- READY_FOR_BRAD is independently rejected unless the official PRYSM gate passes for Authorized actor: BRAD.
- Preserve and reconcile incomplete local checkpoints; never discard them.
- Route from CURRENT_STATE.md and the active P# evidence chain, not stale PRYSM_AUTORUN_STATE.json.
"@
        $basePrompt = Get-Content -LiteralPath $BuilderPromptPath -Raw
        ($runtime + "`r`n" + $basePrompt) | Set-Content -LiteralPath $promptPath -Encoding UTF8

        $codexArgs = @(
            '--ask-for-approval','never','--sandbox','danger-full-access','--add-dir',$GovernanceRepo,
            'exec','--model',$model,'--cd',$AppRepo,'--color','never',
            '--output-schema',$SchemaPath,'--output-last-message',$finalPath,'-'
        )
        Write-ControllerState -Status 'RUNNING' -Model $model -Checkpoint 'BUILDER_RUNNING' -Reason '' -LogPath $transcriptPath
        Write-Host "`n=== $P BUILDER RUN $runNumber | $model | LEVEL $($repairAttempt + 1)/3 | ROOT $rootDefectId ==="
        Write-Host "Logs: $runDir"

        $exitCode = 1
        try {
            Get-Content -LiteralPath $promptPath -Raw | & $CodexCmdPath @codexArgs 1> $stdoutPath 2> $stderrPath
            $exitCode = $LASTEXITCODE
        } catch {
            $exitCode = 1
            ($_ | Out-String) | Set-Content -LiteralPath $stderrPath -Encoding UTF8
        }

        '=== STDOUT ===' | Set-Content -LiteralPath $transcriptPath -Encoding UTF8
        if (Test-Path -LiteralPath $stdoutPath) { Get-Content -LiteralPath $stdoutPath | Add-Content -LiteralPath $transcriptPath }
        '=== STDERR ===' | Add-Content -LiteralPath $transcriptPath
        if (Test-Path -LiteralPath $stderrPath) { Get-Content -LiteralPath $stderrPath | Add-Content -LiteralPath $transcriptPath }

        $postApp = Get-RepoFingerprint $AppRepo
        $postGov = Get-RepoFingerprint $GovernanceRepo
        $transaction.status = 'CODEX_EXITED_UNRECONCILED'
        $transaction.exitCode = $exitCode
        $transaction.finishedAt = Get-Date -Format o
        $transaction.postApplication = $postApp
        $transaction.postGovernance = $postGov
        Write-JsonFile -Path $JournalPath -Value $transaction
        Assert-ControlPlaneUnmodified -GovernanceRepo $GovernanceRepo -ExpectedFingerprint $expectedControlPlane
        Assert-P1TransactionBoundary -AppRepo $AppRepo -GovernanceRepo $GovernanceRepo -PreApp $preApp -PostApp $postApp -PreGov $preGov -PostGov $postGov

        if ($exitCode -ne 0 -or -not (Test-Path -LiteralPath $finalPath)) {
            if (Test-UsageLimit -Paths @($stdoutPath,$stderrPath,$transcriptPath)) {
                $reason = 'Codex usage limit reached. No repair escalation consumed.'
                Write-ControllerState -Status 'BLOCKED' -Model $model -Checkpoint 'USAGE_LIMIT' -Reason $reason -LogPath $transcriptPath
                Send-TerminalNotification -Kind 'BLOCKED' -ApplicationSha (Get-GitHead $AppRepo) -GovernanceSha (Get-GitHead $GovernanceRepo) -Reason $reason -NextAction 'Resume the same P# controller after allowance reset.' -RunLog $transcriptPath
                break
            }
            $consecutiveFailures++
            if ($consecutiveFailures -ge $MaxConsecutiveFailures) { throw "Repeated Codex/controller execution failure. See $transcriptPath" }
            Start-Sleep -Seconds $DelaySeconds
            continue
        }

        try { $result = Get-Content -LiteralPath $finalPath -Raw | ConvertFrom-Json }
        catch {
            $consecutiveFailures++
            if ($consecutiveFailures -ge $MaxConsecutiveFailures) { throw "Repeated structured-result parse failure. See $transcriptPath" }
            Start-Sleep -Seconds $DelaySeconds
            continue
        }
        $consecutiveFailures = 0

        Apply-RepairAccounting -Result $result -RootDefectId ([ref]$rootDefectId) -RepairAttempt ([ref]$repairAttempt)
        Write-Accounting
        $route = Get-Route $result
        $transaction.status = 'RECONCILED'
        $transaction.loopAction = [string]$result.loop_action
        $transaction.nextRole = [string]$result.next_role
        $transaction.checkpoint = [string]$result.checkpoint
        $transaction.reconciledAt = Get-Date -Format o
        Write-JsonFile -Path $JournalPath -Value $transaction

        $noRepoProgress = ($preApp.sha256 -eq $postApp.sha256 -and $preGov.sha256 -eq $postGov.sha256)
        $signature = "$($result.checkpoint)|$($result.reason)|$route"
        if ($route -eq 'CONTINUE' -and $noRepoProgress) {
            if ($signature -eq $lastNoProgressSignature) { $noProgressCount++ } else { $noProgressCount = 1; $lastNoProgressSignature = $signature }
            if ($noProgressCount -ge $MaxNoProgress) { throw "No-progress anti-thrash limit reached after $noProgressCount identical Builder continuations: $signature" }
        } else { $noProgressCount = 0; $lastNoProgressSignature = '' }

        Write-Host "Result: $($result.loop_action) | next=$($result.next_role) | checkpoint=$($result.checkpoint) | route=$route"
        Write-Host "Reason: $($result.reason)"
        if ($route -eq 'CONTINUE') {
            Write-ControllerState -Status 'CONTINUING' -Model $model -Checkpoint ([string]$result.checkpoint) -Reason ([string]$result.reason) -LogPath $transcriptPath
            Start-Sleep -Seconds $DelaySeconds
            continue
        }
        if ($route -eq 'CONTRACT_VIOLATION') {
            $readinessRejections++
            $reason = 'Builder attempted to route directly to Auditor/Betty instead of Brad.'
            if ($readinessRejections -ge $MaxReadinessRejections) { throw "Repeated Builder handoff contract violations. $reason" }
            Write-ControllerState -Status 'CONTINUING' -Model $model -Checkpoint 'HANDOFF_CONTRACT_REJECTED' -Reason $reason -LogPath $transcriptPath
            Start-Sleep -Seconds $DelaySeconds
            continue
        }
        if ($route -eq 'READY_FOR_BRAD_CLAIM') {
            try {
                Assert-ReadyForBrad -Result $result -AppRepo $AppRepo -GovernanceRepo $GovernanceRepo -Bash $Bash
                Write-ControllerState -Status 'READY_FOR_BRAD' -Model $model -Checkpoint 'READY_FOR_BRAD' -Reason ([string]$result.reason) -LogPath $transcriptPath
                Send-TerminalNotification -Kind 'READY_FOR_BRAD' -ApplicationSha ([string]$result.application_sha) -GovernanceSha ([string]$result.governance_sha) -NextAction 'Brad OUTCOME_REVIEW' -RunLog $transcriptPath
                Write-Host "PRYSM $P READY FOR BRAD"
                break
            } catch {
                $readinessRejections++
                $reason = "READY_FOR_BRAD claim rejected: $($_.Exception.Message)"
                if ($readinessRejections -ge $MaxReadinessRejections) { throw "Repeated false/incomplete READY_FOR_BRAD claims. $reason" }
                Write-ControllerState -Status 'CONTINUING' -Model $model -Checkpoint 'READINESS_REJECTED' -Reason $reason -LogPath $transcriptPath
                Start-Sleep -Seconds $DelaySeconds
                continue
            }
        }

        $reason = [string]$result.reason
        if ([string]::IsNullOrWhiteSpace($reason)) { $reason = "Unsafe terminal result: $($result.loop_action)/$($result.next_role)/$($result.checkpoint)" }
        Write-ControllerState -Status 'BLOCKED' -Model $model -Checkpoint ([string]$result.checkpoint) -Reason $reason -LogPath $transcriptPath
        Send-TerminalNotification -Kind 'BLOCKED' -ApplicationSha (Get-GitHead $AppRepo) -GovernanceSha (Get-GitHead $GovernanceRepo) -Reason $reason -NextAction ([string]$result.next_action) -RunLog $transcriptPath
        Write-Host "PRYSM $P BLOCKED"
        break
    }
}
catch {
    $reason = $_.Exception.Message
    if (-not $PreflightOnly) {
        try {
            Write-JsonFile -Path $ControllerStatePath -Value ([ordered]@{
                p=$P;status='CONTROLLER_FAILURE';updatedAt=(Get-Date -Format o);controllerPid=$PID;run=$runNumber;
                checkpoint='CONTROLLER_FAILURE';reason=$reason;repairAttempt=$repairAttempt;rootDefectId=$rootDefectId;
                latestRunLog=$latestRunLog;applicationSha=(Get-GitHead $AppRepo);governanceSha=(Get-GitHead $GovernanceRepo)
            })
        } catch {}
        try { Send-TerminalNotification -Kind 'CONTROLLER_FAILURE' -ApplicationSha (Get-GitHead $AppRepo) -GovernanceSha (Get-GitHead $GovernanceRepo) -Reason $reason -RunLog $latestRunLog } catch {}
    }
    throw
}
finally {
    if (-not $PreflightOnly) {
        try { New-Item -ItemType File -Force -Path $HeartbeatStopPath | Out-Null } catch {}
        if ($heartbeatJob) {
            try { Wait-Job $heartbeatJob -Timeout 3 | Out-Null } catch {}
            try { Stop-Job $heartbeatJob -ErrorAction SilentlyContinue | Out-Null } catch {}
            try { Remove-Job $heartbeatJob -Force -ErrorAction SilentlyContinue | Out-Null } catch {}
        }
        Remove-Item -LiteralPath $AppLockPath -Force -ErrorAction SilentlyContinue
        Remove-Item -LiteralPath $GovernanceLockPath -Force -ErrorAction SilentlyContinue
    }
}
