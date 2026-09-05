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
$Decision = Join-Path (Resolve-Path (Join-Path $ScriptRoot '..\..')).Path 'DECISION_PRYSM_P_SCOPED_CONTINUOUS_BUILDER_AUTORUN_2026-09-05.md'

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

foreach ($path in @($Controller,$Wrapper,$Prompt,$Schema,$Decision)) { Require-File $path }

# PowerShell parses the controller and executes its pure routing/model self-test.
& powershell.exe -NoProfile -ExecutionPolicy Bypass -File $Controller -P $P -SelfTest
if ($LASTEXITCODE -ne 0) { throw 'P# controller self-test failed.' }

$controllerText = Get-Content -LiteralPath $Controller -Raw
$wrapperText = Get-Content -LiteralPath $Wrapper -Raw
$promptText = Get-Content -LiteralPath $Prompt -Raw
$schemaObject = Get-Content -LiteralPath $Schema -Raw | ConvertFrom-Json

Require-Contains $controllerText "if (`$nextRole -eq 'Builder' -and `$loopAction -in @('CONTINUE','STOP')) { return 'CONTINUE' }" 'Controller'
Require-Contains $controllerText "if (`$nextRole -eq 'Auditor') { return 'CONTRACT_VIOLATION' }" 'Controller'
Require-Contains $controllerText "Assert-ReadyForBrad" 'Controller'
Require-Contains $controllerText "Invoke-OfficialGate -Bash `$Bash -ExpectedStage 'OUTCOME_REVIEW' -ExpectedActor 'BRAD'" 'Controller'
Require-Contains $controllerText "Dirty Builder continuation is not anchored to the gate APPLICATION_SHA" 'Controller'
Require-Contains $controllerText 'Acquire-ResourceLock' 'Controller'
Require-Contains $controllerText "'--ask-for-approval','never'" 'Controller'
Require-Contains $controllerText "'--sandbox','danger-full-access'" 'Controller'
Require-Contains $controllerText "'--output-schema',`$SchemaPath" 'Controller'
Require-Contains $controllerText "'--output-last-message',`$finalPath" 'Controller'
Require-Contains $controllerText "P gate has not been advanced to OUTCOME_REVIEW" 'Controller'
Require-Contains $controllerText "whole_app_gate PASS" 'Controller READY contract'

Require-NotContains $controllerText 'repair/prysm-production-closure' 'Controller'
Require-NotContains $controllerText 'PRYSM Production Closure' 'Controller'
Require-NotContains $controllerText 'PRYSM_AUTORUN_STATE.json' 'Controller'

Require-Contains $promptText 'Do **not** use stale historical `PRYSM_AUTORUN_STATE.json`' 'Builder prompt'
Require-Contains $promptText 'Builder must never route directly to Auditor/Betty.' 'Builder prompt'
Require-Contains $promptText 'AUTHORIZED_STAGE=OUTCOME_REVIEW' 'Builder prompt'
Require-Contains $promptText 'official deterministic PRYSM gate' 'Builder prompt'

Require-Contains $wrapperText 'test-prysm-p-autorun-contract.ps1' 'Wrapper'
Require-Contains $wrapperText 'test-prysm-gate-contract.sh' 'Wrapper'
Require-Contains $wrapperText '-PreflightOnly' 'Wrapper'

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
