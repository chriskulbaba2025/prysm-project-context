# Current State

Project:
PRYSM — governed website conversion-readiness report and website decision system

Current objective:
Obtain Chris approval for the completed governed P1 systemic repair design, then begin implementation only after approval.

## Verified checkpoint

- Active P#: `P1 — Cross-Report Contradiction Integrity`.
- Prior stage: `OUTCOME_REVIEW` — COMPLETE.
- Current stage: `P1 REPAIR DESIGN — AWAITING CHRIS APPROVAL`.
- Final Brad disposition: `P1 OUTCOME: FAIL` / `NOT READY TO PASS P1`.
- Final Brad record: `P1_BRAD_FINAL_OUTCOME_DISPOSITION_2026-09-06.md`.
- Active repair-scope decision: `DECISION_PRYSM_P1_OUTCOME_REPAIR_SCOPE_2026-09-06.md`.
- Governed repair design: `P1_GOVERNED_REPAIR_DESIGN_2026-09-06.md`.
- Repair-design commit: `865ade5371c863f2553f2069b0014a6c5c3cb2e5`.
- Application repository: `chriskulbaba2025/vantage-platform`.
- Application branch under review: `p1/bounded-build-cross-report-integrity`.
- Failed exact candidate: `a9523ac3de98de76335a05304b60bec246242b65`.
- Rendered-code provenance SHA: `275f3cabb6796f9d0c2e5a30df61e71c4e084b96`.
- All 16 numbered page reviews: COMPLETE.
- All 7 targeted scenario checks: COMPLETE.
- Scenario result: `4 PASS / 3 MATERIAL FAIL`.

## Final confirmed P1 material roots

1. `CTA_PATH_COHERENCE`
2. `PRIORITY_HIERARCHY_COHERENCE`
3. `BUYER_QUESTION_COVERAGE_COHERENCE`
4. `TRUST_ATTRIBUTION_COHERENCE`
5. `PERFORMANCE_QUALIFICATION_COHERENCE`
6. `EVIDENCE_SCOPE_STATUS_COHERENCE`
7. `CONTENT_RECOMMENDATION_INTEGRITY`

Unresolved boundary candidates: `0`.

## Verified design conclusion

Broad evidence acquisition is not the dominant failure.

Dominant defect class:

`evidence -> classification -> interpretation -> summary/projection -> client-facing language`

The failed candidate already contains a deterministic `cross-report-interpretation` projection, but it is too narrow and major consumers still independently infer client meaning from raw scores/findings/evidence.

## Recommended repair architecture

**Deterministic Client Truth Contract + existing governed Writer/Judge.**

- Expand/replace the current cross-report interpretation projection rather than create a competing truth system.
- All client-facing consumers must consume the same deterministic client truth.
- Add a deterministic integrity gate that blocks stronger-than-evidence states and broken recommendation output.
- Preserve raw provenance underneath the client report.
- Keep n8n outside the core P1 truth path for now; it may be used later for orchestration/alerts/replay once the Client Truth Contract is stable.

Architecture score recorded in the design: `9.5 / 10`.

## Expected application boundary after approval

Strongly expected files/systems are documented in `P1_GOVERNED_REPAIR_DESIGN_2026-09-06.md`, including:

- `src/report-model/cross-report-interpretation.js`
- `src/scoring/vantage-score.js`
- `src/scoring/score-components.js`
- `src/scoring/report-model.js`
- `src/report/action-priority.js`
- `src/report/render-report-v2.js`
- `src/report/report-detail-sections.js`
- `src/narrative-v2/writer-input.js`
- `src/narrative-v2/writer-prompt.js`
- `src/narrative-v2/live-binding.js`
- `src/narrative-v2/judge-contract.js` if the new hard-gate class requires contract validation
- likely new `src/report-model/client-truth-gate.js`

Exact current source must still be verified before implementation.

## Verification design

Required after implementation:

- direct Client Truth unit tests;
- one regression per seven confirmed roots;
- all 7 existing scenarios -> required `7 / 7 PASS`;
- cross-consumer parity tests for renderer / WriterInput / Narrative / action hierarchy;
- no `undefined` / `null` / unresolved recommendation placeholders in client output;
- focused report suites;
- full worker suite;
- Whole-App branch-matrix/tranche gate;
- model-bearing gate if Writer/Judge changes;
- exact repaired render candidate;
- Brad repaired-outcome review plus actual rendered visual review;
- Betty only after Brad PASS.

## Blocked until approval

- no application code edits;
- no Builder run;
- no P2;
- no Betty Final Audit;
- no merge to application `main`;
- no deployment;
- no paid/live providers or models.

## Important constraints

- GitHub is authoritative.
- Design before coding.
- Solve the repeat failure class, not isolated sentences.
- Preserve canonical evidence truth and provenance.
- Do not reopen evidence acquisition or scoring without direct evidence and dependency-impact proof.
- Existing user work must not be destructively reset or discarded.

## Exact next action

Chris approves or rejects the architecture in `P1_GOVERNED_REPAIR_DESIGN_2026-09-06.md`.

Recommended approval:

`APPROVE — deterministic Client Truth Contract + existing Writer/Judge, with n8n outside the core truth path for now.`

If approved, the next governed action is to verify the exact current application branch/worktree and begin implementation in the documented order.

Last verified:
2026-09-06
