# Handoff — PRYSM P1 Repair Implementation Start

Date: 2026-09-06
Status: READY FOR CONTINUATION

## Repository authority

Context repository:
`chriskulbaba2025/prysm-project-context`

Application repository:
`chriskulbaba2025/vantage-platform`

GitHub is authoritative. Do not reconstruct current state from chat history.

## Verified checkpoint

P1 outcome review is complete.

Final Brad disposition:

`P1 OUTCOME: FAIL`

All 16 numbered pages and all 7 targeted scenarios were reviewed.

Scenario result on the failed candidate:

`4 PASS / 3 MATERIAL FAIL`

Final confirmed material roots: `7`.

Unresolved boundary candidates: `0`.

## Approved repair architecture

Chris approved:

**Deterministic Client Truth Contract + existing governed Writer/Judge.**

The repair expands the existing `cross-report-interpretation` boundary into one authoritative client-facing truth contract.

Every client-facing consumer must use that same deterministic truth rather than independently reinterpreting raw scores, findings, or evidence states.

A deterministic integrity gate will block stronger-than-evidence conclusions and broken recommendation output.

n8n is not part of the core P1 truth path for this repair. It may be used later for orchestration, alerts, replay, or review routing.

## Seven confirmed roots

1. `CTA_PATH_COHERENCE`
2. `PRIORITY_HIERARCHY_COHERENCE`
3. `BUYER_QUESTION_COVERAGE_COHERENCE`
4. `TRUST_ATTRIBUTION_COHERENCE`
5. `PERFORMANCE_QUALIFICATION_COHERENCE`
6. `EVIDENCE_SCOPE_STATUS_COHERENCE`
7. `CONTENT_RECOMMENDATION_INTEGRITY`

## Governing files for implementation

Read:

- `CURRENT_STATE.md`
- `P1_GOVERNED_REPAIR_DESIGN_2026-09-06.md`
- `DECISION_PRYSM_P1_REPAIR_DESIGN_APPROVED_2026-09-06.md`
- `CONSTRAINT_PRYSM_P1_REPAIR_IMPLEMENTATION_2026-09-06.md`
- `REPAIR_BOUNDARY_PROTOCOL.md`
- `WORKFLOW_INSTRUCTIONS.md`
- applicable Whole-App and model-bearing gate files.

The dated P1 constraint exception supersedes older generic presentation-only/no-Writer-Judge constraints only where required by this approved repair package.

## Application checkpoint

Expected branch:

`p1/bounded-build-cross-report-integrity`

Historical failed candidate:

`a9523ac3de98de76335a05304b60bec246242b65`

Rendered-code provenance SHA:

`275f3cabb6796f9d0c2e5a30df61e71c4e084b96`

The exact local application state has NOT yet been verified after design approval.

## Exact next action

In the VS Code PowerShell terminal:

```powershell
cd C:\Users\kulba\Desktop\vantage-platform
git branch --show-current
git rev-parse HEAD
git status --short
```

Preserve any existing local changes. Do not reset or clean.

After local state is verified, reconcile the exact current source against the approved implementation boundary and begin with the Client Truth Contract producer first.

## Still blocked

- no paid/live providers or models;
- no merge to application `main`;
- no deployment;
- no P2;
- no Betty before Brad PASS;
- no destructive cleanup;
- no evidence-acquisition or scoring reopen without direct proof and dependency-impact analysis.

## Required final proof after repair

- direct Client Truth tests;
- 7 root regressions;
- all 7 scenarios -> `7/7 PASS`;
- cross-consumer parity;
- recommendation-integrity proof;
- focused suites;
- full worker suite;
- Whole-App exact-SHA proof;
- model-bearing gate if Writer/Judge changes;
- repaired exact render candidate;
- Brad outcome + visual review;
- Betty only after Brad PASS.
