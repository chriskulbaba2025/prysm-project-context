Set-StrictMode -Version Latest

function Normalize-PrysmRootDefectId {
    param([AllowNull()][string]$RootDefectId)

    if ([string]::IsNullOrWhiteSpace($RootDefectId)) {
        return 'NONE'
    }

    return $RootDefectId.Trim()
}

function Resolve-PrysmRepairAccounting {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateRange(0,3)]
        [int]$CurrentRepairAttempt,

        [Parameter(Mandatory = $true)]
        [string]$CurrentRootDefectId,

        [Parameter(Mandatory = $true)]
        [string]$ResultRootDefectId,

        [Parameter(Mandatory = $true)]
        [ValidateSet('NONE','REPAIR_PROOF_FAILED','NEW_ROOT_CAUSE','EXTERNAL_OR_PROTOCOL')]
        [string]$FailureClass,

        [Parameter(Mandatory = $true)]
        [bool]$AuditPassed
    )

    $currentRoot = Normalize-PrysmRootDefectId $CurrentRootDefectId
    $resultRoot = Normalize-PrysmRootDefectId $ResultRootDefectId

    if ($AuditPassed) {
        return [pscustomobject]@{
            RepairAttempt = 0
            RootDefectId = 'NONE'
            Event = 'AUDIT_PASS_RESET'
        }
    }

    switch ($FailureClass) {
        'NEW_ROOT_CAUSE' {
            if ($resultRoot -eq 'NONE') {
                throw 'NEW_ROOT_CAUSE requires a non-NONE root_defect_id.'
            }
            if ($resultRoot -eq $currentRoot) {
                throw "NEW_ROOT_CAUSE requires a changed root_defect_id. Current and result are both '$resultRoot'."
            }
            return [pscustomobject]@{
                RepairAttempt = 0
                RootDefectId = $resultRoot
                Event = 'NEW_ROOT_RESET'
            }
        }

        'REPAIR_PROOF_FAILED' {
            if ($resultRoot -eq 'NONE') {
                throw 'REPAIR_PROOF_FAILED requires a non-NONE root_defect_id.'
            }

            if ($currentRoot -ne 'NONE' -and $resultRoot -ne $currentRoot) {
                # Identity change wins over a stale same-root classification. This is the
                # fail-safe that prevents a newly exposed prerequisite from consuming the
                # previous defect chain's Terra/Sol budget.
                return [pscustomobject]@{
                    RepairAttempt = 0
                    RootDefectId = $resultRoot
                    Event = 'DEFENSIVE_NEW_ROOT_RESET'
                }
            }

            $nextAttempt = [Math]::Min(3, $CurrentRepairAttempt + 1)
            return [pscustomobject]@{
                RepairAttempt = $nextAttempt
                RootDefectId = $resultRoot
                Event = 'SAME_ROOT_ESCALATION'
            }
        }

        'EXTERNAL_OR_PROTOCOL' {
            return [pscustomobject]@{
                RepairAttempt = $CurrentRepairAttempt
                RootDefectId = $currentRoot
                Event = 'NO_ESCALATION_EXTERNAL'
            }
        }

        'NONE' {
            if ($resultRoot -ne $currentRoot) {
                return [pscustomobject]@{
                    RepairAttempt = 0
                    RootDefectId = $resultRoot
                    Event = 'ROOT_CONTEXT_CHANGED'
                }
            }

            return [pscustomobject]@{
                RepairAttempt = $CurrentRepairAttempt
                RootDefectId = $currentRoot
                Event = 'NO_CHANGE'
            }
        }
    }
}

function Assert-PrysmAccountingResult {
    param(
        [Parameter(Mandatory = $true)]$Actual,
        [Parameter(Mandatory = $true)][int]$ExpectedAttempt,
        [Parameter(Mandatory = $true)][string]$ExpectedRoot,
        [Parameter(Mandatory = $true)][string]$ExpectedEvent,
        [Parameter(Mandatory = $true)][string]$Label
    )

    if ([int]$Actual.RepairAttempt -ne $ExpectedAttempt -or
        [string]$Actual.RootDefectId -ne $ExpectedRoot -or
        [string]$Actual.Event -ne $ExpectedEvent) {
        throw "Autorun accounting regression '$Label': expected attempt=$ExpectedAttempt root=$ExpectedRoot event=$ExpectedEvent; got attempt=$($Actual.RepairAttempt) root=$($Actual.RootDefectId) event=$($Actual.Event)."
    }
}

function Test-PrysmRepairAccountingContract {
    $sameFirst = Resolve-PrysmRepairAccounting -CurrentRepairAttempt 0 -CurrentRootDefectId 'T4.ROOT.A' -ResultRootDefectId 'T4.ROOT.A' -FailureClass 'REPAIR_PROOF_FAILED' -AuditPassed $false
    Assert-PrysmAccountingResult -Actual $sameFirst -ExpectedAttempt 1 -ExpectedRoot 'T4.ROOT.A' -ExpectedEvent 'SAME_ROOT_ESCALATION' -Label 'same root first failure'

    $sameThird = Resolve-PrysmRepairAccounting -CurrentRepairAttempt 2 -CurrentRootDefectId 'T4.ROOT.A' -ResultRootDefectId 'T4.ROOT.A' -FailureClass 'REPAIR_PROOF_FAILED' -AuditPassed $false
    Assert-PrysmAccountingResult -Actual $sameThird -ExpectedAttempt 3 -ExpectedRoot 'T4.ROOT.A' -ExpectedEvent 'SAME_ROOT_ESCALATION' -Label 'same root third failure blocks next'

    $newRoot = Resolve-PrysmRepairAccounting -CurrentRepairAttempt 2 -CurrentRootDefectId 'T4.ROOT.A' -ResultRootDefectId 'T4.ROOT.B' -FailureClass 'NEW_ROOT_CAUSE' -AuditPassed $false
    Assert-PrysmAccountingResult -Actual $newRoot -ExpectedAttempt 0 -ExpectedRoot 'T4.ROOT.B' -ExpectedEvent 'NEW_ROOT_RESET' -Label 'explicit new root reset'

    $defensive = Resolve-PrysmRepairAccounting -CurrentRepairAttempt 2 -CurrentRootDefectId 'T4.ROOT.A' -ResultRootDefectId 'T4.ROOT.B' -FailureClass 'REPAIR_PROOF_FAILED' -AuditPassed $false
    Assert-PrysmAccountingResult -Actual $defensive -ExpectedAttempt 0 -ExpectedRoot 'T4.ROOT.B' -ExpectedEvent 'DEFENSIVE_NEW_ROOT_RESET' -Label 'identity change wins over stale classification'

    $external = Resolve-PrysmRepairAccounting -CurrentRepairAttempt 1 -CurrentRootDefectId 'T4.ROOT.A' -ResultRootDefectId 'T4.ROOT.A' -FailureClass 'EXTERNAL_OR_PROTOCOL' -AuditPassed $false
    Assert-PrysmAccountingResult -Actual $external -ExpectedAttempt 1 -ExpectedRoot 'T4.ROOT.A' -ExpectedEvent 'NO_ESCALATION_EXTERNAL' -Label 'external failure no escalation'

    $auditPass = Resolve-PrysmRepairAccounting -CurrentRepairAttempt 2 -CurrentRootDefectId 'T4.ROOT.A' -ResultRootDefectId 'T4.ROOT.A' -FailureClass 'NONE' -AuditPassed $true
    Assert-PrysmAccountingResult -Actual $auditPass -ExpectedAttempt 0 -ExpectedRoot 'NONE' -ExpectedEvent 'AUDIT_PASS_RESET' -Label 'audit pass reset'

    $contextChange = Resolve-PrysmRepairAccounting -CurrentRepairAttempt 1 -CurrentRootDefectId 'T4.ROOT.A' -ResultRootDefectId 'T4.ROOT.B' -FailureClass 'NONE' -AuditPassed $false
    Assert-PrysmAccountingResult -Actual $contextChange -ExpectedAttempt 0 -ExpectedRoot 'T4.ROOT.B' -ExpectedEvent 'ROOT_CONTEXT_CHANGED' -Label 'nonfailure root context change reset'
}

# Executed on dot-source. The controller therefore fails before any Codex call if
# a future edit breaks the governed same-root/new-root accounting invariants.
Test-PrysmRepairAccountingContract
