param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$Entry = Join-Path $ScriptRoot 'START-PRYSM-P1-R2.ps1'
$Runner = Join-Path $ScriptRoot 'START-PRYSM-P1-R2-AUTORUN.ps1'
$GovRoot = (Resolve-Path (Join-Path $ScriptRoot '..\..')).Path
$AuthV2 = Join-Path $GovRoot 'proof\P1\reopen\P1_BOUNDED_REPAIR_AUTHORIZATION_R2_V2_2026-09-06.md'
$Accounting = Join-Path $GovRoot 'proof\P1\reopen\P1_R2_REPAIR_ACCOUNTING_BASELINE_2026-09-06.md'

foreach ($path in @($Entry,$Runner,$AuthV2,$Accounting)) {
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

$entryText = Get-Content -LiteralPath $Entry -Raw
$text = Get-Content -LiteralPath $Runner -Raw
$auth = Get-Content -LiteralPath $AuthV2 -Raw
$accounting = Get-Content -LiteralPath $Accounting -Raw

function Require([string]$Needle,[string]$Label='Runner') {
    $haystack = if ($Label -eq 'Auth') { $auth } elseif ($Label -eq 'Accounting') { $accounting } elseif ($Label -eq 'Entry') { $entryText } else { $text }
    if ($haystack -notmatch [regex]::Escape($Needle)) { throw "$Label missing required R2 contract text: $Needle" }
}
function Forbid([string]$Needle,[string]$Label='Runner') {
    $haystack = if ($Label -eq 'Auth') { $auth } elseif ($Label -eq 'Accounting') { $accounting } elseif ($Label -eq 'Entry') { $entryText } else { $text }
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

# Windows PowerShell 5.1 native stderr safety: benign native stderr must not
# become a terminating ErrorRecord before LASTEXITCODE is examined. Every
# assignment from Invoke-NativeExitCode must use -Quiet so command stdout cannot
# contaminate the assigned numeric exit code.
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

# Public entrypoint must guarantee a visible terminal notification even when the
# child runner exits before its own route-specific notifier executes.
Require '[switch]$TestNotification' 'Entry'
Require 'function Send-DesktopNotification' 'Entry'
Require 'System.Windows.Forms.MessageBox' 'Entry'
Require "if (`$TestNotification)" 'Entry'
Require "PRYSM P1 R2 WINDOWS NOTIFICATION TEST PASS" 'Entry'
Require "if (`$runtimeExitCode -ne 0)" 'Entry'
Require "PRYSM P1 R2 STOPPED" 'Entry'
Require 'No automatic rerun will occur.' 'Entry'
Require '$ErrorActionPreference = ''Continue''' 'Entry'
Require '$runtimeExitCode = $LASTEXITCODE' 'Entry'

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
