# Handoff — PRYSM P1 Outcome Repair Design Continuation

Date: 2026-09-06
Status: READY FOR NEW CHAT

## Repository authority

Context repository:
`chriskulbaba2025/prysm-project-context`

Application repository:
`chriskulbaba2025/vantage-platform`

GitHub is authoritative. Do not reconstruct current state from the previous chat.

## Verified checkpoint

P1 outcome review is complete.

Final Brad disposition:

`P1 OUTCOME: FAIL`

`NOT READY TO PASS P1`

Failed application candidate:

`a9523ac3de98de76335a05304b60bec246242b65`

Branch:

`p1/bounded-build-cross-report-integrity`

Rendered-code provenance SHA:

`275f3cabb6796f9d0c2e5a30df61e71c4e084b96`

All 16 numbered report pages were reviewed.

All 7 targeted scenarios were reviewed.

Scenario result:

`4 PASS / 3 MATERIAL FAIL`

## Final material-root ledger

Seven confirmed roots:

1. `CTA_PATH_COHERENCE`
2. `PRIORITY_HIERARCHY_COHERENCE`
3. `BUYER_QUESTION_COVERAGE_COHERENCE`
4. `TRUST_ATTRIBUTION_COHERENCE`
5. `PERFORMANCE_QUALIFICATION_COHERENCE`
6. `EVIDENCE_SCOPE_STATUS_COHERENCE`
7. `CONTENT_RECOMMENDATION_INTEGRITY`

Unresolved boundary candidates: `0`.

The previous `PLATFORM_CONSTRAINT_EVIDENCE_CLASSIFICATION` and `TECHNICAL_SEARCH_BLOCKER_CLASSIFICATION` candidates are treated as manifestations of `EVIDENCE_SCOPE_STATUS_COHERENCE`, not separate roots.

## Core diagnosis established by the completed review

The dominant failure is **not broad evidence acquisition**.

The recurring defect is:

`evidence -> classification -> interpretation -> summary/projection -> client-facing language`

PRYSM often knows what evidence it has, but the final report can tell the client something stronger, broader, more positive, or differently classified than the evidence supports.

Examples include:

- weak conversion path -> `Adequate` / already working;
- FAQ absence -> no buyer-question content;
- observed trust assets -> `underused`;
- mixed lab performance + unavailable real-user evidence -> broad PASS/Adequate framing;
- unavailable/failed evidence -> PASS/no action/no blocker reassurance;
- not collected/not assessed -> `NOT APPLICABLE`;
- broken generated recommendation -> `Signs You May Need Undefined`.

## Repair direction authorized by Chris

Do not artificially limit the repair to report styling or isolated wording patches.

Use the architecture that actually closes the failure class.

An external n8n flow is allowed if it is the best way to orchestrate writing, judging, contradiction checks, replay, or auditability.

n8n must not become the authoritative evidence store and must not bypass deterministic governance.

The design may consider:

- central deterministic client-fact / qualification layer;
- revised report projection logic;
- revised Writer/Judge contracts;
- n8n orchestration;
- deterministic contradiction/rule gates;
- separation of client report from technical provenance;
- hybrid architecture.

Do not assume evidence acquisition or scoring needs repair. Reopen those only if direct evidence proves a defect.

## Do not start coding yet

The next chat must design the repair first.

Do not:

- edit application code;
- run Builder;
- start P2;
- run Betty Final Audit;
- merge application `main`;
- deploy;
- run paid/live providers or models.

## Required first action in next chat

Read the authoritative files named in `CURRENT_STATE.md`, especially:

- `P1_BRAD_FINAL_OUTCOME_DISPOSITION_2026-09-06.md`
- `DECISION_PRYSM_P1_OUTCOME_REPAIR_SCOPE_2026-09-06.md`

Then produce one governed P1 repair design that:

1. maps all seven roots to their likely producing/consumer boundaries;
2. identifies the smallest architecture that fixes the repeat class globally rather than patching pages;
3. compares deterministic qualification, Writer/Judge, n8n, and hybrid approaches;
4. explicitly decides where the source of client-facing truth lives;
5. defines the client-vs-technical evidence boundary;
6. defines deterministic fail-closed rules;
7. defines dependency impact and likely source/system boundaries;
8. defines targeted tests plus the same 7 scenario proofs;
9. defines final report and rendered visual acceptance gates;
10. stops for Chris approval before implementation.

## New-chat bootstrap prompt

Continue PRYSM from the authoritative GitHub state in:

`chriskulbaba2025/prysm-project-context`

Read `CURRENT_STATE.md` first, then the governing files it names, especially:

`P1_BRAD_FINAL_OUTCOME_DISPOSITION_2026-09-06.md`

and:

`DECISION_PRYSM_P1_OUTCOME_REPAIR_SCOPE_2026-09-06.md`

and:

`HANDOFF_PRYSM_P1_OUTCOME_REPAIR_DESIGN_CONTINUATION_2026-09-06.md`

Treat GitHub as authoritative. Do not reconstruct state from the previous chat.

P1 outcome review is complete and Brad's final disposition is `P1 OUTCOME: FAIL`.

There are seven confirmed material roots and zero unresolved boundary candidates.

The dominant problem is evidence-to-client interpretation/classification/projection, not broad evidence acquisition.

The next action is **repair design only**. Do not code yet.

The repair is not artificially limited to report styling. An external n8n flow is allowed if it is the best architecture. Compare deterministic qualification, Writer/Judge, n8n, and hybrid options and choose the design most likely to eliminate recurrence across all seven roots.

Return the governed repair design, dependency/test boundary, and recommended architecture, then stop for my approval before implementation.
