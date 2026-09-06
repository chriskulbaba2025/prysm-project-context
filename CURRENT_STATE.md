# Current State

Project:
PRYSM — governed website conversion-readiness report and website decision system

Current objective:
Design the next governed P1 repair package from Brad's completed final outcome disposition. The repair must eliminate the repeat evidence-to-client interpretation/classification/projection failure class across the whole report, not patch isolated wording.

## Verified checkpoint

- Active P#: `P1 — Cross-Report Contradiction Integrity`.
- Prior stage: `OUTCOME_REVIEW` — COMPLETE.
- Current stage: `P1 REPAIR DESIGN`.
- Final Brad disposition: `P1 OUTCOME: FAIL` / `NOT READY TO PASS P1`.
- Final Brad record: `P1_BRAD_FINAL_OUTCOME_DISPOSITION_2026-09-06.md`.
- Active repair-scope decision: `DECISION_PRYSM_P1_OUTCOME_REPAIR_SCOPE_2026-09-06.md`.
- Application repository: `chriskulbaba2025/vantage-platform`.
- Application branch under review: `p1/bounded-build-cross-report-integrity`.
- Failed exact candidate: `a9523ac3de98de76335a05304b60bec246242b65`.
- Rendered-code provenance SHA: `275f3cabb6796f9d0c2e5a30df61e71c4e084b96`.
- All 16 numbered page reviews: COMPLETE.
- All 7 targeted scenario checks: COMPLETE.
- Scenario result: `4 PASS / 3 MATERIAL FAIL`.
- Builder verification for the failed candidate remains historically complete: focused R2 `80/0`, full worker `987/0`, Whole-App PASS, render generation `52/0`.

## Final confirmed P1 material roots

1. `CTA_PATH_COHERENCE`
2. `PRIORITY_HIERARCHY_COHERENCE`
3. `BUYER_QUESTION_COVERAGE_COHERENCE`
4. `TRUST_ATTRIBUTION_COHERENCE`
5. `PERFORMANCE_QUALIFICATION_COHERENCE`
6. `EVIDENCE_SCOPE_STATUS_COHERENCE`
7. `CONTENT_RECOMMENDATION_INTEGRITY`

Unresolved boundary candidates: `0`.

Former boundary candidates:

- `CONTENT_RECOMMENDATION_INTEGRITY` -> promoted to confirmed root #7.
- `PLATFORM_CONSTRAINT_EVIDENCE_CLASSIFICATION` -> absorbed as a manifestation of `EVIDENCE_SCOPE_STATUS_COHERENCE`.
- `TECHNICAL_SEARCH_BLOCKER_CLASSIFICATION` -> absorbed as a manifestation of `EVIDENCE_SCOPE_STATUS_COHERENCE`.

## Final evidence-gathering conclusion

Broad evidence acquisition does **not** appear to be the dominant failure.

PRYSM repeatedly demonstrates correct underlying boundaries including:

- assessed absence vs unavailable evidence;
- CTA/form presence vs conversion-path quality;
- lab performance vs real-user field performance;
- no performance evidence -> no fast/slow conclusion;
- crawl/provider failure -> explicit audit limitation;
- insufficient coverage -> overall score withheld.

Dominant defect class:

`evidence -> classification -> interpretation -> summary/projection -> client-facing language`

The repair target is therefore systemic interpretation/report integrity first. Do not reopen acquisition or scoring without direct evidence proving a separate defect.

## Repair-design authorization

The next repair is outcome-first and is not artificially limited to page styling or the current report-only boundary.

The design may consider, where justified:

- central deterministic client-fact/qualification logic;
- report projection/summary logic;
- recommendation integrity;
- Writer input/prompt/output contracts;
- Judge/cross-report contradiction checks;
- client vs technical evidence presentation;
- n8n orchestration;
- deterministic validation/replay.

External n8n is permitted if it materially improves the solution. n8n must not become the evidence source of truth or bypass deterministic governance.

No implementation boundary is chosen yet.

## Completed

- 16-page Brad outcome review.
- 7-scenario Brad proof batch.
- Independent audit/collation of page and scenario findings.
- Final Brad `P1 OUTCOME: FAIL` synthesis.
- Final seven-root accounting.
- Repair-design scope decision allowing the architecture to cross the old presentation-only boundary where justified.

## Blocked

Until the repair design is approved:

- do not edit application code;
- do not run Builder;
- do not start P2;
- do not run Betty Final Audit;
- do not merge application `main`;
- do not deploy;
- do not call paid/live providers or models;
- do not rerun the failed candidate as if it were passable.

## Important constraints

- GitHub is authoritative.
- Diagnose/design before coding.
- Solve the repeat defect class, not isolated sentences.
- Preserve canonical evidence truth and provenance.
- Missing/partial/unavailable evidence must fail closed everywhere.
- Do not reopen evidence acquisition or scoring without direct proof and dependency-impact analysis.
- Preserve whole-app/model-bearing/release gates for any eventual implementation.
- Existing user work must not be destructively reset or discarded.

## Exact next action

Start a new chat from GitHub authority and read:

1. `PROJECT.md`
2. `GITHUB_PROJECT_MEMORY_PROTOCOL.md`
3. `PRYSM_PERMANENT_MEMORY.md`
4. `REPAIR_BOUNDARY_PROTOCOL.md`
5. `DIAGNOSTIC_EVIDENCE_PROTOCOL.md`
6. `WORKFLOW_INSTRUCTIONS.md`
7. `CURRENT_STATE.md`
8. `CONSTRAINTS.md`
9. `DECISIONS.md`
10. `P1_BRAD_FINAL_OUTCOME_DISPOSITION_2026-09-06.md`
11. `DECISION_PRYSM_P1_OUTCOME_REPAIR_SCOPE_2026-09-06.md`
12. `HANDOFF_PRYSM_P1_OUTCOME_REPAIR_DESIGN_CONTINUATION_2026-09-06.md`

Then produce a **governed P1 repair design before any code** that:

- maps all seven confirmed roots to the responsible interpretation/projection boundaries;
- compares a central deterministic qualification layer, revised Writer/Judge path, external n8n orchestration, and hybrid options;
- selects the architecture most likely to eliminate recurrence across the whole report;
- defines dependency impact, exact expected source-file/system boundaries, regression tests, scenario proofs, and acceptance gates;
- keeps raw provenance available while making the normal client report human/business-first;
- requires Chris approval of the repair design before implementation begins.

Last verified:
2026-09-06
