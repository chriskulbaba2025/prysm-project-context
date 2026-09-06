param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$Entry = Join-Path $ScriptRoot 'START-PRYSM-P1-R2.ps1'
$Runner = Join-Path $ScriptRoot 'START-PRYSM-P1-R2-AUTORUN.ps1'
$Recovery = Join-Path $ScriptRoot 'RESUME-PRYSM-P1-R2-DIRTY.ps1'
$GovRoot = (Resolve-Path (Join-Path $ScriptRoot '..\..')).Path
$AuthV2 = Join-Path $GovRoot 'proof\P1\reopen\P1_BOUNDED_REPAIR_AUTHORIZATION_R2_V2_2026-09-06.md'
$RecoveryEvidence = Join-Path $GovRoot 'proof\P1\reopen\P1_R2_RUN1_DIRTY_CHECKPOINT_RECOVERY_2026-09-06.md'
$Accounting = Join-Path $GovRoot 'proof\P1\reopen\P1_R2_REPAIR_ACCOUNTING_BASELINE_2026-09-06.md'

foreach ($path in @($Entry,$Runner,$Recovery,$AuthV2,$RecoveryEvidence,$Accounting)) {
    if (-not (Test-Path -LiteralPath $path)) { throw "Missing R2 contract file: $path" }
}

function Assert-Parses([string]$Path,[string]$Label) {
    $tokens = $null
    $errors = $null
    [void][System.Management.Automation.Language.Parser]::ParseFile($Path,[ref]$tokens,[ref]$errors)
    if ($errors.Count -gt 0) {
        $detail = ($errors | ForEach-Object { $_.Message }) -join '; '
        throw "$Label does not parse: $detail"
    }
}

Assert-Parses $Entry 'R2 Windows public entrypoint'
Assert-Parses $Runner 'R2 Windows runner'
Assert-Parses $Recovery 'R2 Windows dirty recovery controller'

$entryText = Get-Content -LiteralPath $Entry -Raw
$text = Get-Content -LiteralPath $Runner -Raw
$recoveryText = Get-Content -LiteralPath $Recovery -Raw
$auth = Get-Content -LiteralPath $AuthV2 -Raw
$recoveryEvidenceText = Get-Content -LiteralPath $RecoveryEvidence -Raw
$accounting = Get-Content -LiteralPath $Accounting -Raw

function Require([string]$Needle,[string]$Label='Runner') {
    $haystack = if ($Label -eq 'Auth') { $auth } elseif ($Label -eq 'RecoveryEvidence') { $recoveryEvidenceText } elseif ($Label -eq 'Accounting') { $accounting } elseif ($Label -eq 'Entry') { $entryText } elseif ($Label -eq 'Recovery') { $recoveryText } else { $text }
    if ($haystack -notmatch [regex]::Escape($Needle)) { throw "$Label missing required R2 contract text: $Needle" }
}
function Forbid([string]$Needle,[string]$Label='Runner') {
    $haystack = if ($Label -eq 'Auth') { $auth } elseif ($Label -eq 'RecoveryEvidence') { $recoveryEvidenceText } elseif ($Label -eq 'Accounting') { $accounting } elseif ($Label -eq 'Entry') { $entryText } elseif ($Label -eq 'Recovery') { $recoveryText } else { $text }
    if ($haystack -match [regex]::Escape($Needle)) { throw "$Label contains forbidden R2 contract text: $Needle" }
}

Require '$RootDefectId = ''P1-CROSS-REPORT-PROJECTION-RECONCILIATION'''
Require '$InitialRepairAttempt = 1'
Require '$ModelTerra = ''gpt-5.6-terra'''
Require '$ModelSol = ''gpt-5.6-sol'''
Require "'services/worker/src/report/v2-pillars.js'"
Require "'services/worker/src/report/render-report-v2-sections.test.js'"
Require "if (`$path -like 'proof/P1/reopen/*') { continue }"
Require 'Assert-BaselineUnchanged $AppRepo $ProofBaseline'
Require 'Assert-BaselineUnchanged $GovernanceRepo $ProofBaseline'
Require "`$StateRoot = Join-Path `$LocalBase 'PRYSM-P-Autorun\P1-R2'"
Require "if (`$repairAttempt -eq 1) { `$model = `$ModelTerra }"
Require "elseif (`$repairAttempt -eq 2) { `$model = `$ModelSol }"
Require "if ([string]`$result.failure_class -eq 'NEW_ROOT_CAUSE')"
Require "Invoke-OfficialGate 'OUTCOME_REVIEW' 'BRAD'"
Require "Write-Host 'PRYSM P1 READY FOR BRAD'"
Require 'No-progress anti-thrash limit reached'
Require 'Codex usage limit reached. R2 repair accounting was not advanced.'
Require "'--ask-for-approval','never'"
Require "'--sandbox','danger-full-access'"
Require "'--output-schema',`$SchemaPath"
Require "'--output-last-message',`$finalPath"

# Windows PowerShell 5.1 native stderr safety.
Require 'function Invoke-NativeExitCode'
Require '$ErrorActionPreference = ''Continue'''
Require 'if ($Quiet) { & $Command *> $null } else { & $Command }'
Require 'Invoke-NativeExitCode -Command { & git -C $AppRepo fetch origin $branch } -Quiet'
Require 'Invoke-NativeExitCode -Command { & git -C $GovernanceRepo fetch origin main } -Quiet'
Require 'Invoke-NativeExitCode -Command { & git -C $Repo cat-file -e "HEAD:$path" } -Quiet'
Require 'Invoke-NativeExitCode -Command { & git -C $GovernanceRepo cat-file -e "HEAD:$path" } -Quiet'
Require '$frozenExit = Invoke-NativeExitCode -Command { & $Bash $FrozenGuard } -Quiet'
Require '$regressionExit = Invoke-NativeExitCode -Command { & $Bash $GateRegression } -Quiet'
Require '$postFrozenExit = Invoke-NativeExitCode -Command { & $Bash $FrozenGuard } -Quiet'
Forbid '$frozenExit = Invoke-NativeExitCode -Command { & $Bash $FrozenGuard }`n'
Forbid '$regressionExit = Invoke-NativeExitCode -Command { & $Bash $GateRegression }`n'
Forbid '& git -C $AppRepo fetch origin $branch *> $null'
Forbid '& git -C $GovernanceRepo fetch origin main *> $null'
Forbid '& $Bash $FrozenGuard *> $null'

# Public entrypoint terminal notification and recovery routing.
Require '[switch]$TestNotification' 'Entry'
Require 'function Send-DesktopNotification' 'Entry'
Require 'System.Windows.Forms.MessageBox' 'Entry'
Require "if (`$TestNotification)" 'Entry'
Require 'PRYSM P1 R2 WINDOWS NOTIFICATION TEST PASS' 'Entry'
Require 'function Test-DirtyRecoveryNeeded' 'Entry'
Require "[string]`$journal.status -eq 'CODEX_EXITED_UNRECONCILED'" 'Entry'
Require "R2 journal is still RUNNING and cannot be auto-recovered" 'Entry'
Require "`$Recovery = Join-Path `$ScriptRoot 'RESUME-PRYSM-P1-R2-DIRTY.ps1'" 'Entry'
Require "R2_DIRTY_RECOVERY_FILE" 'Entry'
Require "R2_WINDOWS_RECOVERY" 'Entry'
Require 'DIRTY CHECKPOINT RECOVERY -> CONTINUOUS BUILDER TO BRAD' 'Entry'
Require 'Attributed dirty-checkpoint recovery stopped' 'Entry'
Require "if (`$runtimeExitCode -ne 0)" 'Entry'
Require 'PRYSM P1 R2 STOPPED' 'Entry'
Require 'No automatic rerun will occur.' 'Entry'
Require '$ErrorActionPreference = ''Continue''' 'Entry'
Require '$runtimeExitCode = $LASTEXITCODE' 'Entry'

# Exact Run 1 dirty-checkpoint recovery contract.
Require '$RepairAttempt = 1' 'Recovery'
Require "$Model = 'gpt-5.6-terra'" 'Recovery'
Require "$ExpectedApplicationSha = '8fa9ea9db76e2db5e8fa11ebc6a0a7fd56eb6e1c'" 'Recovery'
Require "$JournalGovernanceSha = '6a65330b0346dd572a59eae06402128533d7bcd2'" 'Recovery'
Require "$ExpectedInitialDiffSha256 = '6d1db38a328364c6388abe7af63929a2fb2d75340f1ca102daaf9cb055f7ad4f'" 'Recovery'
Require "'services/worker/src/report/foundation-readiness.js'" 'Recovery'
Require "'services/worker/src/report/render-report-v2-conversion.test.js'" 'Recovery'
Require "'services/worker/src/report/render-report-v2.js'" 'Recovery'
Require "'services/worker/src/report/report-detail-sections.js'" 'Recovery'
Require "'services/worker/src/report/v2-pillars.js'" 'Recovery'
Require 'Get-NormalizedDiffSha256' 'Recovery'
Require 'Get-RepoFingerprint' 'Recovery'
Require 'CODEX_EXITED_UNRECONCILED' 'Recovery'
Require 'PROOF_SETUP_FAILURE' 'Recovery'
Require 'Assert-GovernanceAdvanceFromRun1' 'Recovery'
Require 'Assert-AppBoundary' 'Recovery'
Require 'Assert-GovBoundary' 'Recovery'
Require 'Assert-ControlPlane' 'Recovery'
Require 'Exact Run 1 dirty checkpoint attribution: PASS' 'Recovery'
Require 'Do not broadly relabel unrelated pillars' 'Recovery'
Require 'Client-facing report copy must be ordinary human language.' 'Recovery'
Require 'Do not expose internal status tokens such as LIMITED_EVIDENCE, PARTIAL, AVAILABLE, UNKNOWN' 'Recovery'
Require 'Re-freeze hashes only when the changed output is intentionally accepted' 'Recovery'
Require 'Do not consume repair attempt 2 for this control-plane recovery.' 'Recovery'
Require 'Attributed dirty continuation preserved; launching another recovery Builder turn.' 'Recovery'
Require 'Repositories are clean and pushed. Return to the standard R2 continuous controller.' 'Recovery'
Require "Invoke-OfficialGate 'OUTCOME_REVIEW' 'BRAD'" 'Recovery'
Require "'--ask-for-approval','never'" 'Recovery'
Require "'--sandbox','danger-full-access'" 'Recovery'
Forbid 'git reset --hard' 'Recovery'
Forbid 'git clean' 'Recovery'
Forbid 'checkout --force' 'Recovery'
Forbid 'reset below repair index' 'Recovery'

# Recovery evidence must bind the uploaded diagnostic state exactly.
Require 'Decision: APPROVED' 'RecoveryEvidence'
Require 'CONTROL-PLANE RECOVERY ONLY' 'RecoveryEvidence'
Require 'Codex exit code: `0`' 'RecoveryEvidence'
Require 'Repair attempt: `1`' 'RecoveryEvidence'
Require 'Result failure class: `PROOF_SETUP_FAILURE`' 'RecoveryEvidence'
Require '`6d1db38a328364c6388abe7af63929a2fb2d75340f1ca102daaf9cb055f7ad4f`' 'RecoveryEvidence'
Require 'No staged files and no untracked files were present' 'RecoveryEvidence'
Require 'process/harness recovery failure does not consume R2 product repair attempt `1`' 'RecoveryEvidence'

# Runtime must consume the exact V2 execution authorization that the gate binds.
Require "`$AuthorizationPath = Join-Path `$GovernanceRepo 'proof\P1\reopen\P1_BOUNDED_REPAIR_AUTHORIZATION_R2_V2_2026-09-06.md'"
Require "if ([string]`$gate['R2_EXECUTION_AUTH_FILE'] -ne 'proof/P1/reopen/P1_BOUNDED_REPAIR_AUTHORIZATION_R2_V2_2026-09-06.md')"

Forbid 'MaxSeconds'
Forbid '2700'
Forbid 'PRYSM-P-Autorun\P1\transaction-journal.json'

Require 'Decision: APPROVED' 'Auth'
Require 'Stable root: `P1-CROSS-REPORT-PROJECTION-RECONCILIATION`' 'Auth'
Require 'Only these source/test paths may be edited:' 'Auth'
Require 'new versioned' 'Auth'
Require '%LOCALAPPDATA%\PRYSM-P-Autorun\P1-R2' 'Auth'
Require 'PRYSM P1 READY FOR BRAD' 'Auth'

Require 'R2 begins at repair index `1`.' 'Accounting'
Require 'No fourth same-root attempt is permitted.' 'Accounting'
Require 'may not initialize below this R2 baseline' 'Accounting'

Write-Host 'PRYSM P1 R2 WINDOWS AUTORUN CONTRACT PASS'
Write-Host 'PRYSM P1 R2 WINDOWS TERMINAL NOTIFICATION CONTRACT PASS'
Write-Host 'PRYSM P1 R2 WINDOWS DIRTY RECOVERY CONTRACT PASS'
