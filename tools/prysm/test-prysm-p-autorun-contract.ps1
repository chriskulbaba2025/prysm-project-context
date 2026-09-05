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
    if ($Text -match [regex]::Escape($Needle)) { throw "$Label contains forbidden historical coupling: $Needle" }
}

foreach ($path in @($Controller,$Wrapper,$Prompt,$Schema,$Decision,$Memory)) { Require-File $path }

# Parsing the file and executing SelfTest catches PowerShell syntax plus pure route/accounting defects before any repo mutation.
& powershell.exe -NoProfile -ExecutionPolicy Bypass -File $Controller -P $P -SelfTest
if ($LASTEXITCODE -ne 0) { throw 'P# controller self-test failed.' }

$controllerText = Get-Content -LiteralPath $Controller -Raw
$wrapperText = Get-Content -LiteralPath $Wrapper -Raw
$promptText = Get-Content -LiteralPath $Prompt -Raw
$decisionText = Get-Content -LiteralPath $Decision -Raw
$memoryText = Get-Content -LiteralPath $Memory -Raw
$schemaObject = Get-Content -LiteralPath $Schema -Raw | ConvertFrom-Json

# Continuous routing and human boundary.
Require-Contains $controllerText "if (`$nextRole -eq 'Builder' -and `$loopAction -in @('CONTINUE','STOP')) { return 'CONTINUE' }" 'Controller'
Require-Contains $controllerText "if (`$nextRole -eq 'Auditor') { return 'CONTRACT_VIOLATION' }" 'Controller'
Require-Contains $controllerText 'Assert-ReadyForBrad' 'Controller'
Require-Contains $controllerText "Invoke-OfficialGate -Bash `$Bash -ExpectedStage 'OUTCOME_REVIEW' -ExpectedActor 'BRAD'" 'Controller'
Require-Contains $controllerText "return 'READY_FOR_BRAD'" 'Controller pre-run stage recovery'

# Transactional recovery and no-crumb lineage.
Require-Contains $controllerText 'transaction-journal.json' 'Controller'
Require-Contains $controllerText 'Get-RepoFingerprint' 'Controller'
Require-Contains $controllerText "status='RUNNING'" 'Controller journal'
Require-Contains $controllerText "CODEX_EXITED_UNRECONCILED" 'Controller journal'
Require-Contains $controllerText "status = 'RECONCILED'" 'Controller journal'
Require-Contains $controllerText 'entry-anchor.json' 'Controller'
Require-Contains $controllerText 'APP_P1_INITIAL_DIRTY_ADOPTION' 'Controller current P1 recovery'
Require-Contains $controllerText 'APP_INTERRUPTED_DIRTY_RECOVERY' 'Controller crash recovery'
Require-Contains $controllerText 'GOV_INTERRUPTED_DIRTY_RECOVERY' 'Controller governance crash recovery'
Require-Contains $controllerText 'Acquire-ResourceLock' 'Controller'

# Control plane cannot be rewritten by the Builder it governs.
Require-Contains $controllerText 'Assert-ControlPlaneUnmodified' 'Controller'
Require-Contains $controllerText 'PRYSM_PERMANENT_MEMORY.md' 'Controller protected files'
Require-Contains $promptText '## Immutable control plane' 'Builder prompt'
Require-Contains $promptText 'Do not self-modify the execution system that is currently governing you.' 'Builder prompt'

# Repair accounting cannot be reset by casually renaming a root.
Require-Contains $controllerText 'Apply-RepairAccounting' 'Controller'
Require-Contains $controllerText 'Root identity changed without NEW_ROOT_CAUSE.' 'Controller accounting'
Require-Contains $controllerText 'NEW_ROOT_CAUSE requires a non-NONE root_defect_id.' 'Controller accounting'

# Non-interactive Codex execution.
Require-Contains $controllerText "'--ask-for-approval','never'" 'Controller'
Require-Contains $controllerText "'--sandbox','danger-full-access'" 'Controller'
Require-Contains $controllerText "'--output-schema',`$SchemaPath" 'Controller'
Require-Contains $controllerText "'--output-last-message',`$finalPath" 'Controller'

# Bootstrap must not pull/reset over dirty recovery state.
Require-Contains $wrapperText 'Verify bootstrap/control-plane integrity' 'Wrapper'
Require-Contains $wrapperText 'controller recovery will verify lineage' 'Wrapper'
Require-Contains $wrapperText 'test-prysm-p-autorun-contract.ps1' 'Wrapper'
Require-Contains $wrapperText 'test-prysm-gate-contract.sh' 'Wrapper'
Require-Contains $wrapperText '-PreflightOnly' 'Wrapper'

# Remove historical controller coupling.
foreach ($forbidden in @('repair/prysm-production-closure','PRYSM Production Closure','PRYSM_AUTORUN_STATE.json')) {
    Require-NotContains $controllerText $forbidden 'Controller'
}
Require-Contains $promptText 'Do **not** use stale historical `PRYSM_AUTORUN_STATE.json`' 'Builder prompt'
Require-Contains $promptText 'Builder must never route directly to Auditor/Betty.' 'Builder prompt'
Require-Contains $promptText 'AUTHORIZED_STAGE=OUTCOME_REVIEW' 'Builder prompt'
Require-Contains $promptText 'official deterministic PRYSM gate' 'Builder prompt'

# Durable governance must describe the same architecture.
Require-Contains $decisionText 'continuous' 'Decision'
Require-Contains $decisionText 'OUTCOME_REVIEW' 'Decision'
Require-Contains $memoryText 'Permanent P-scoped unattended Builder rule' 'Permanent memory'
Require-Contains $memoryText 'READY_FOR_BRAD' 'Permanent memory'

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
