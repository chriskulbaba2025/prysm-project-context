param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$Entry = Join-Path $ScriptRoot 'START-PRYSM-P1-R2.ps1'
$Runner = Join-Path $ScriptRoot 'START-PRYSM-P1-R2-AUTORUN.ps1'
$Recovery = Join-Path $ScriptRoot 'RESUME-PRYSM-P1-R2-DIRTY.ps1'
$PlacementRecovery = Join-Path $ScriptRoot 'RECOVER-PRYSM-P1-R2-MISLOCATED-PROOF.ps1'
$GovRoot = (Resolve-Path (Join-Path $ScriptRoot '..\..')).Path
$AuthV2 = Join-Path $GovRoot 'proof\P1\reopen\P1_BOUNDED_REPAIR_AUTHORIZATION_R2_V2_2026-09-06.md'
$RecoveryEvidence = Join-Path $GovRoot 'proof\P1\reopen\P1_R2_RUN1_DIRTY_CHECKPOINT_RECOVERY_2026-09-06.md'
$PlacementEvidence = Join-Path $GovRoot 'proof\P1\reopen\P1_R2_RUN2_TRACKED_PROOF_RELOCATION_RECOVERY_2026-09-06.md'
$Accounting = Join-Path $GovRoot 'proof\P1\reopen\P1_R2_REPAIR_ACCOUNTING_BASELINE_2026-09-06.md'

foreach ($path in @($Entry,$Runner,$Recovery,$PlacementRecovery,$AuthV2,$RecoveryEvidence,$PlacementEvidence,$Accounting)) {
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
Assert-Parses $PlacementRecovery 'R2 Windows tracked proof relocation helper'

$entryText = Get-Content -LiteralPath $Entry -Raw
$text = Get-Content -LiteralPath $Runner -Raw
$recoveryText = Get-Content -LiteralPath $Recovery -Raw
$placementText = Get-Content -LiteralPath $PlacementRecovery -Raw
$auth = Get-Content -LiteralPath $AuthV2 -Raw
$recoveryEvidenceText = Get-Content -LiteralPath $RecoveryEvidence -Raw
$placementEvidenceText = Get-Content -LiteralPath $PlacementEvidence -Raw
$accounting = Get-Content -LiteralPath $Accounting -Raw

function Require([string]$Needle,[string]$Label='Runner') {
    $haystack = if ($Label -eq 'Auth') { $auth } elseif ($Label -eq 'RecoveryEvidence') { $recoveryEvidenceText } elseif ($Label -eq 'PlacementEvidence') { $placementEvidenceText } elseif ($Label -eq 'Accounting') { $accounting } elseif ($Label -eq 'Entry') { $entryText } elseif ($Label -eq 'Recovery') { $recoveryText } elseif ($Label -eq 'Placement') { $placementText } else { $text }
    if ($haystack -notmatch [regex]::Escape($Needle)) { throw "$Label missing required R2 contract text: $Needle" }
}
function Forbid([string]$Needle,[string]$Label='Runner') {
    $haystack = if ($Label -eq 'Auth') { $auth } elseif ($Label -eq 'RecoveryEvidence') { $recoveryEvidenceText } elseif ($Label -eq 'PlacementEvidence') { $placementEvidenceText } elseif ($Label -eq 'Accounting') { $accounting } elseif ($Label -eq 'Entry') { $entryText } elseif ($Label -eq 'Recovery') { $recoveryText } elseif ($Label -eq 'Placement') { $placementText } else { $text }
    if ($haystack -match [regex]::Escape($Needle)) { throw "$Label contains forbidden R2 contract text: $Needle" }
}

# Existing standard R2 runner contract.
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
Forbid '& git -C $AppRepo fetch origin $branch *> $null'
Forbid '& git -C $GovernanceRepo fetch origin main *> $null'
Forbid '& $Bash $FrozenGuard *> $null'

# Public entrypoint and notification/recovery routing.
Require '[switch]$TestNotification' 'Entry'
Require 'function Send-DesktopNotification' 'Entry'
Require 'System.Windows.Forms.MessageBox' 'Entry'
Require 'PRYSM P1 R2 WINDOWS NOTIFICATION TEST PASS' 'Entry'
Require 'function Test-DirtyRecoveryNeeded' 'Entry'
Require 'R2 journal is still RUNNING and cannot be auto-recovered' 'Entry'
Require "`$Recovery = Join-Path `$ScriptRoot 'RESUME-PRYSM-P1-R2-DIRTY.ps1'" 'Entry'
Require "`$PlacementRecovery = Join-Path `$ScriptRoot 'RECOVER-PRYSM-P1-R2-MISLOCATED-PROOF.ps1'" 'Entry'
Require 'R2_MISLOCATED_PROOF_RECOVERY_FILE' 'Entry'
Require 'R2_TRACKED_PROOF_RECOVERY_FILE' 'Entry'
Require 'R2_WINDOWS_PLACEMENT_RECOVERY' 'Entry'
Require 'MISLOCATED PROOF RECOVERY -> DIRTY RECOVERY -> CONTINUOUS BUILDER' 'Entry'
Require 'PRYSM P1 R2 WINDOWS PLACEMENT RECOVERY AUDIT PASS' 'Entry'
Require 'No boundary expansion occurred.' 'Entry'
Require 'PRYSM P1 R2 STOPPED' 'Entry'

# Existing original dirty-continuation recovery contract.
Require '$RepairAttempt = 1' 'Recovery'
Require '$Model = ''gpt-5.6-terra''' 'Recovery'
Require '$ExpectedApplicationSha = ''8fa9ea9db76e2db5e8fa11ebc6a0a7fd56eb6e1c''' 'Recovery'
Require 'Do not broadly relabel unrelated pillars' 'Recovery'
Require 'Client-facing report copy must be ordinary human language.' 'Recovery'
Require 'Do not expose internal status tokens such as LIMITED_EVIDENCE, PARTIAL, AVAILABLE, UNKNOWN' 'Recovery'
Require 'Do not consume repair attempt 2 for this control-plane recovery.' 'Recovery'
Require 'Attributed dirty continuation preserved; launching another recovery Builder turn.' 'Recovery'
Require 'Repositories are clean and pushed. Return to the standard R2 continuous controller.' 'Recovery'
Forbid 'git reset --hard' 'Recovery'
Forbid 'git clean' 'Recovery'
Forbid 'checkout --force' 'Recovery'

# Exact Run 2 tracked-proof relocation contract. This section intentionally
# checks semantic operations rather than stale formatting/path-construction text.
Require '$RepairAttempt = 1' 'Placement'
Require '$OriginalApplicationSha = ''8fa9ea9db76e2db5e8fa11ebc6a0a7fd56eb6e1c''' 'Placement'
Require '$Run2ApplicationSha = ''8d2b38e4d8abd959d412b72028e9934dba8ae185''' 'Placement'
Require '$BadProofRoot = ''services/worker/proof/P1/reopen/render-v2-r2-20260906''' 'Placement'
Require '$GoodProofRoot = ''proof/P1/reopen/render-v2-r2-20260906''' 'Placement'
Require "'services/worker/src/report/foundation-readiness.js'" 'Placement'
Require "'services/worker/src/report/render-report-v2-conversion.test.js'" 'Placement'
Require "'services/worker/src/report/render-report-v2.js'" 'Placement'
Require "'services/worker/src/report/report-detail-sections.js'" 'Placement'
Require "'services/worker/src/report/v2-pillars.js'" 'Placement'
Require 'Application Run 2 checkpoint mismatch.' 'Placement'
Require 'Run 2 contains an unexpected changed path:' 'Placement'
Require 'Misplaced Run 2 proof is not tracked in the pushed Run 2 commit.' 'Placement'
Require 'Governed root target already exists in Run 2; automatic relocation is not allowed.' 'Placement'
Require 'CODEX_EXITED_UNRECONCILED' 'Placement'
Require 'Run 2 result repair_attempt drifted.' 'Placement'
Require 'Run 2 result root_defect_id drifted.' 'Placement'
Require '& git -C $AppRepo mv -- $BadProofRoot $GoodProofRoot' 'Placement'
Require 'Assert-OnlyRelocationStaged' 'Placement'
Require 'fix(p1): relocate R2 rendered proof to governed root' 'Placement'
Require 'Update-GovernanceGate $newApplicationSha' 'Placement'
Require 'APPLICATION_SHA=$NewApplicationSha' 'Placement'
Require 'CANDIDATE_APPLICATION_SHA=$NewApplicationSha' 'Placement'
Require 'P1: bind relocated R2 application checkpoint' 'Placement'
Require 'RUN2_TRACKED_PROOF_RELOCATED' 'Placement'
Require 'RELOCATED_TO_GOVERNED_ROOT' 'Placement'
Require "-NotePropertyName status -NotePropertyValue 'RECONCILED'" 'Placement'
Require 'Standard R2 runner may continue at repair attempt 1.' 'Placement'
Forbid 'git reset --hard' 'Placement'
Forbid 'git clean' 'Placement'
Forbid 'checkout --force' 'Placement'
Forbid 'push --force' 'Placement'
Forbid 'QUARANTINED_AND_REMOVED' 'Placement'

# Recovery evidence bindings.
Require 'Decision: APPROVED' 'RecoveryEvidence'
Require 'CONTROL-PLANE RECOVERY ONLY' 'RecoveryEvidence'
Require 'process/harness recovery failure does not consume R2 product repair attempt `1`' 'RecoveryEvidence'

Require 'Decision: APPROVED' 'PlacementEvidence'
Require 'APPROVED CONTROL-PLANE / GENERATED-PROOF RELOCATION RECOVERY' 'PlacementEvidence'
Require '`8d2b38e4d8abd959d412b72028e9934dba8ae185`' 'PlacementEvidence'
Require 'Its parent is the R2 entry candidate:' 'PlacementEvidence'
Require '`services/worker/proof/P1/reopen/render-v2-r2-20260906/*`' 'PlacementEvidence'
Require '`proof/P1/reopen/*`' 'PlacementEvidence'
Require 'use Git-aware relocation so all proof content is preserved exactly' 'PlacementEvidence'
Require 'update only `APPLICATION_SHA` and `CANDIDATE_APPLICATION_SHA`' 'PlacementEvidence'
Require 'mark the local P1-R2 transaction journal `RECONCILED`' 'PlacementEvidence'
Require 'repair attempt: `1`' 'PlacementEvidence'
Require 'must not' 'PlacementEvidence'
Require 'force-push or rewrite application history' 'PlacementEvidence'
Require '`CLEAN SYNCHRONIZED R2 BUILDER CHECKPOINT`' 'PlacementEvidence'

# Runtime continues to consume the exact V2 execution authorization.
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
Write-Host 'PRYSM P1 R2 WINDOWS TRACKED PROOF RELOCATION CONTRACT PASS'
