param(
    [ValidatePattern('^P[0-9]+$')]
    [string]$P = 'P1'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$Controller = Join-Path $ScriptRoot 'PRYSM-P-AUTORUN.ps1'
$Wrapper = Join-Path $ScriptRoot 'START-PRYSM-P-AUTORUN.ps1'
$Prompt = Join-Path $ScriptRoot 'PRYSM-P-BUILDER-AUTORUN-PROMPT.md'
$FrozenHistoryGuard = Join-Path $ScriptRoot 'assert-p1-frozen-history.sh'
$CurrentSessionLauncher = Join-Path $ScriptRoot 'start-prysm-p-current-session.sh'
$GateRegression = Join-Path $ScriptRoot 'test-prysm-gate-contract.sh'
$Schema = Join-Path (Split-Path -Parent $ScriptRoot) 'autorun\PRYSM-AUTORUN-RESULT.schema.json'
$GovRoot = (Resolve-Path (Join-Path $ScriptRoot '..\..')).Path
$Decision = Join-Path $GovRoot 'DECISION_PRYSM_P_SCOPED_CONTINUOUS_BUILDER_AUTORUN_2026-09-05.md'
$Memory = Join-Path $GovRoot 'PRYSM_PERMANENT_MEMORY.md'

function Require-File {
    param([string]$Path)
    if (-not (Test-Path -LiteralPath $Path)) { throw "Missing required autorun file: $Path" }
}
function Require-Contains {
    param([string]$Text,[string]$Needle,[string]$Label)
    if ($Text -notmatch [regex]::Escape($Needle)) { throw "$Label missing required contract text: $Needle" }
}
function Require-NotContains {
    param([string]$Text,[string]$Needle,[string]$Label)
    if ($Text -match [regex]::Escape($Needle)) { throw "$Label contains forbidden text: $Needle" }
}

foreach ($path in @($Controller,$Wrapper,$Prompt,$FrozenHistoryGuard,$CurrentSessionLauncher,$GateRegression,$Schema,$Decision,$Memory)) { Require-File $path }

# Parse controller + run pure route/model/accounting tests before repository mutation.
& powershell.exe -NoProfile -ExecutionPolicy Bypass -File $Controller -P $P -SelfTest
if ($LASTEXITCODE -ne 0) { throw 'P# controller self-test failed.' }

$controllerText = Get-Content -LiteralPath $Controller -Raw
$wrapperText = Get-Content -LiteralPath $Wrapper -Raw
$promptText = Get-Content -LiteralPath $Prompt -Raw
$frozenHistoryText = Get-Content -LiteralPath $FrozenHistoryGuard -Raw
$currentSessionText = Get-Content -LiteralPath $CurrentSessionLauncher -Raw
$gateRegressionText = Get-Content -LiteralPath $GateRegression -Raw
$decisionText = Get-Content -LiteralPath $Decision -Raw
$memoryText = Get-Content -LiteralPath $Memory -Raw
$schemaObject = Get-Content -LiteralPath $Schema -Raw | ConvertFrom-Json

# Continuous routing and Brad boundary.
Require-Contains $controllerText "if (`$nextRole -eq 'Builder' -and `$loopAction -in @('CONTINUE','STOP')) { return 'CONTINUE' }" 'Controller'
Require-Contains $controllerText "if (`$nextRole -eq 'Auditor') { return 'CONTRACT_VIOLATION' }" 'Controller'
Require-Contains $controllerText 'Assert-ReadyForBrad' 'Controller'
Require-Contains $controllerText "Invoke-OfficialGate -Bash `$Bash -ExpectedStage 'OUTCOME_REVIEW' -ExpectedActor 'BRAD'" 'Controller'
Require-Contains $controllerText "return 'READY_FOR_BRAD'" 'Controller pre-run handoff recovery'

# Transaction journal, exact restart lineage, and atomic fail-closed local state.
foreach ($needle in @(
    'transaction-journal.json','entry-anchor.json','Get-RepoFingerprint','Get-TransactionChangedPaths',
    'git -C $Repo log --format= --name-only',"status='RUNNING'",'CODEX_EXITED_UNRECONCILED',
    "status = 'RECONCILED'",'JournalMatchesFingerprint','APP_P1_INITIAL_DIRTY_ADOPTION',
    'APP_JOURNALED_DIRTY_RECOVERY','GOV_JOURNALED_DIRTY_RECOVERY','Assert-LoopLineage','Acquire-ResourceLock',
    'P-scoped local state is corrupt and will not be silently reset','Move-Item -LiteralPath $temp -Destination $Path -Force',
    'Application origin moved outside or ahead of the active local transaction lineage.',
    'Governance origin moved outside or ahead of the active local transaction lineage.'
)) { Require-Contains $controllerText $needle 'Controller transaction/recovery' }

# Scope, frozen history, and immutable control plane.
foreach ($needle in @(
    'Assert-P1TransactionBoundary','P1 application transaction escaped the authorized seam',
    'P1 governance transaction modified frozen/history or escaped the authorized seam',
    '$P1FrozenGovernancePaths','proof/P1/rendered/*','proof/P1/reopen/*',
    'Assert-ControlPlaneUnmodified','Committed PRYSM control-plane fingerprint changed during Builder execution.',
    'controlPlaneFingerprint','No-progress anti-thrash limit reached'
)) { Require-Contains $controllerText $needle 'Controller integrity guard' }
Require-Contains $controllerText 'This controller version has explicit transaction-scope enforcement only for P1.' 'Controller fail-closed scope'

# Exhaustive baseline-derived frozen-history guard is part of the official gate.
Require-Contains $currentSessionText 'assert-p1-frozen-history.sh' 'Current-session deterministic gate'
Require-Contains $currentSessionText 'P1 frozen-history verification failed.' 'Current-session deterministic gate'
foreach ($needle in @(
    'P1_FROZEN_BASELINE="0756e4db3746be0c2279c2083ccf83b3ec5c89f5"',
    "grep -E '^(P1_[^/]*|proof/P1/rendered/.+)$'",
    "grep -v '^P1_EXECUTION_GATE\\.env$'",
    'historical P1 evidence was touched after freeze baseline',
    'new root P1 evidence is not allowed; place reopened proof under proof/P1/reopen/',
    'PRYSM_GATE_CONTRACT_TEST'
)) { Require-Contains $frozenHistoryText $needle 'P1 frozen-history guard' }
foreach ($needle in @(
    'historical P1 evidence mutation fails deterministically',
    'change-then-revert historical breadcrumb still fails deterministically',
    'new root P1 evidence is rejected; reopened proof must be versioned under proof/P1/reopen/'
)) { Require-Contains $gateRegressionText $needle 'Permanent gate regression' }

# Repair accounting cannot reset by relabeling a root.
Require-Contains $controllerText 'Apply-RepairAccounting' 'Controller accounting'
Require-Contains $controllerText 'Root identity changed without NEW_ROOT_CAUSE.' 'Controller accounting'
Require-Contains $controllerText 'NEW_ROOT_CAUSE requires a non-NONE root_defect_id.' 'Controller accounting'

# Non-interactive Codex execution.
Require-Contains $controllerText "'--ask-for-approval','never'" 'Controller'
Require-Contains $controllerText "'--sandbox','danger-full-access'" 'Controller'
Require-Contains $controllerText "'--output-schema',`$SchemaPath" 'Controller'
Require-Contains $controllerText "'--output-last-message',`$finalPath" 'Controller'

# Supported public bootstrap is fail closed on unknown/unreconciled transaction state.
Require-Contains $wrapperText 'Verify interrupted-transaction safety' 'Wrapper fail-closed recovery'
Require-Contains $wrapperText 'transaction journal is still RUNNING and has no durable post-run fingerprint' 'Wrapper RUNNING fail-closed recovery'
Require-Contains $wrapperText 'transaction journal contains an unreconciled Codex result' 'Wrapper unreconciled fail-closed recovery'
Require-Contains $wrapperText '-MaxConsecutiveFailures 1' 'Wrapper first-failure stop'
Require-NotContains $wrapperText '-MaxRuns 20' 'Wrapper artificial run cap'
Require-Contains $wrapperText 'Verify bootstrap/control-plane integrity' 'Wrapper'
Require-Contains $wrapperText 'controller recovery will verify lineage' 'Wrapper'
Require-Contains $wrapperText 'test-prysm-p-autorun-contract.ps1' 'Wrapper'
Require-Contains $wrapperText 'test-prysm-gate-contract.sh' 'Wrapper'
Require-Contains $wrapperText '-PreflightOnly' 'Wrapper'
Require-Contains $wrapperText '[switch]$AuditOnly' 'Wrapper audit-only mode'
Require-Contains $wrapperText 'AUDIT ONLY - NO CODEX/PRODUCT EXECUTION' 'Wrapper audit-only mode'
Require-Contains $wrapperText 'PRYSM P# AUTORUN AUDIT PASS' 'Wrapper audit-only terminal'
Require-Contains $wrapperText 'No Codex Builder invocation was started. No application/product execution occurred.' 'Wrapper audit-only terminal'

# Builder receives the same frozen-history and transaction contract.
Require-Contains $promptText 'controller journals each invocation' 'Builder prompt'
Require-Contains $promptText '## Immutable control plane' 'Builder prompt'
Require-Contains $promptText '## Frozen evidence / no rewritten history' 'Builder prompt'
Require-Contains $promptText 'never overwrite or regenerate `proof/P1/rendered/*` in place' 'Builder prompt'
Require-Contains $promptText 'proof/P1/reopen/' 'Builder prompt'
Require-Contains $promptText 'Do not self-modify the execution system that is currently governing you.' 'Builder prompt'
Require-Contains $promptText 'Builder must never route directly to Auditor/Betty.' 'Builder prompt'
Require-Contains $promptText 'AUTHORIZED_STAGE=OUTCOME_REVIEW' 'Builder prompt'
Require-Contains $promptText 'official deterministic PRYSM gate' 'Builder prompt'

# Historical Production Closure coupling is forbidden; stale global state may be named only to reject it as authority.
foreach ($forbidden in @('repair/prysm-production-closure','PRYSM Production Closure')) {
    Require-NotContains $controllerText $forbidden 'Controller'
}
Require-Contains $controllerText 'not stale PRYSM_AUTORUN_STATE.json' 'Controller stale-state rejection'
Require-Contains $promptText 'Do **not** use stale historical `PRYSM_AUTORUN_STATE.json`' 'Builder prompt stale-state rejection'

# Durable governance must describe the exact audited controller behavior.
foreach ($needle in @(
    'Transaction journal and no-crumb rule','Deterministic READY_FOR_BRAD rule',
    'official deterministic PRYSM P1 gate','Current scope of the controller',
    'This audited controller version is **P1-only**','Frozen P1 history','Audit-only runtime verification',
    'supported public entrypoint','CODEX_EXITED_UNRECONCILED'
)) { Require-Contains $decisionText $needle 'Decision' }
Require-Contains $memoryText 'Permanent P-scoped unattended Builder rule' 'Permanent memory'
Require-Contains $memoryText 'transaction journal' 'Permanent memory'
Require-Contains $memoryText 'READY_FOR_BRAD' 'Permanent memory'
Require-Contains $memoryText 'CODEX_EXITED_UNRECONCILED' 'Permanent memory'

# Structured response contract stays strict.
$requiredFields = @(
    'loop_action','role','next_role','tranche','checkpoint','reason','application_branch','application_sha',
    'governance_sha','whole_app_gate','material_defects','repair_attempt','root_defect_id','failure_class','next_action','github_state_synced'
)
$schemaRequired = @($schemaObject.required)
foreach ($field in $requiredFields) {
    if ($schemaRequired -notcontains $field) { throw "Structured result schema missing required field: $field" }
}
$loopEnum = @($schemaObject.properties.loop_action.enum)
foreach ($value in @('CONTINUE','STOP','BLOCKED','COMPLETE')) {
    if ($loopEnum -notcontains $value) { throw "Structured result schema loop_action missing: $value" }
}

Write-Host 'PRYSM P# AUTORUN CONTRACT REGRESSION PASS'
