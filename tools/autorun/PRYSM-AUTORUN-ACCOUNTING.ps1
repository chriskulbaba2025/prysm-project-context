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
