# P1 Governed Repair Design

Date: 2026-09-06
Status: PROPOSED — awaiting Chris approval before application edits

## Outcome to protect

A normal client must receive one coherent, truthful PRYSM report in which every summary, detail page, priority, recommendation, and Narrative statement means no more than the evidence actually supports.

The repair must eliminate the seven confirmed P1 roots as a system rather than patching isolated sentences.

## Final confirmed roots

1. `CTA_PATH_COHERENCE`
2. `PRIORITY_HIERARCHY_COHERENCE`
3. `BUYER_QUESTION_COVERAGE_COHERENCE`
4. `TRUST_ATTRIBUTION_COHERENCE`
5. `PERFORMANCE_QUALIFICATION_COHERENCE`
6. `EVIDENCE_SCOPE_STATUS_COHERENCE`
7. `CONTENT_RECOMMENDATION_INTEGRITY`

## Verified design deficiency

The failed candidate already contains `src/report-model/cross-report-interpretation.js`, intended as a single deterministic interpretation projection. It is too narrow and major consumers still independently reinterpret raw scores, findings, and capability evidence.

Verified examples from the exact failed candidate:

- `render-report-v2.js` independently labels every pillar score >=60 as a strength and `Adequate`, creating summary conflict with detailed path/performance conclusions.
- `report-detail-sections.js` independently derives trust wording and renders the heading `Proof already available but underused` even though placement/use is not established.
- `score-components.js` produces `No buyer-question content detected` from the FAQ finding boundary.
- `report-model.js` contains independent conversion-path and content-idea derivation, including the interpolation path that can emit `Undefined`.
- `action-priority.js` produces a coherent conversion-first ordering, while `render-report-v2.js` separately derives visible impact text from raw finding severity, allowing the priority story to disagree with the ranking story.
- WriterInput already carries deterministic analysis, including the cross-report interpretation projection, but the deterministic report renderer does not consistently consume one authoritative client-truth contract.

Dominant failure boundary:

`canonical evidence / capabilities / findings / scores`
-> `derived interpretation and action logic`
-> `renderer + Narrative Writer/Judge consumers`
-> `client-facing report`

## Architecture decision

### Recommended architecture: deterministic Client Truth Contract + governed Narrative consumer

Score: **9.5 / 10**

Build one expanded deterministic client-truth contract from governed evidence, capabilities, scores, findings, conversion paths, and action hierarchy.

Every client-facing consumer must use that contract instead of reinterpreting raw inputs independently.

Flow:

`Canonical evidence / CapabilityEvidence / ScoreSet / FindingSet`
-> `Client Truth Contract`
-> `deterministic integrity gate`
-> `renderer + WriterInput`
-> `Writer/Judge where Narrative is used`
-> `final render validation`

The existing `cross-report-interpretation.js` is the seed for this contract; do not create a competing parallel truth system.

### n8n decision

**Do not put n8n in the core P1 truth path.**

Reason: the current material defects are semantic/classification defects inside PRYSM before external orchestration. Adding n8n now would add another consumer and another state boundary without fixing the source-of-truth problem.

n8n remains allowed later for orchestration, alerts, replay, human review routing, or operational monitoring after the Client Truth Contract is stable.

Current n8n recommendation score for core P1 repair: **5 / 10**.

Hybrid with deterministic truth + existing Writer/Judge: **9.5 / 10**.

## Client Truth Contract

The contract must carry explicit client-ready facts, not merely raw metrics.

For each governed construct it should include at minimum:

- `state` — assessed / partial / not assessed / not applicable / finding;
- `scope` — what was actually assessed;
- `observation` — what the evidence directly establishes;
- `clientConclusion` — the strongest allowed client-facing conclusion;
- `qualifier` — required limitation language when evidence is partial/unavailable;
- `prohibitedUpgrades` — conclusions that must not appear;
- `evidenceRefs` / lineage;
- `businessMeaning` where deterministically supportable;
- `recommendedAction` only when qualified and complete.

Examples:

### Conversion

Evidence:
CTA/form observed + conversion path Weak.

Client truth:
`A conversion mechanism exists, but the assessed path to complete the action is weak.`

Forbidden:
`Conversion Path is already working / strong / adequate` unless the same contract says the path is clear.

### Buyer questions

Evidence:
FAQ not detected.

Client truth:
`No explicit FAQ content was detected on the assessed page(s).`

Forbidden:
`No buyer-question content exists` unless a separate buyer-question coverage assessment proves it.

### Trust

Evidence:
testimonials / credentials / policies / contact observed.

Client truth:
`Trust proof was observed.`

Forbidden:
`underused / poorly placed` unless placement evidence exists.

### Performance

Evidence:
mobile lab 62, desktop lab 91, field unavailable.

Client truth:
`Lab performance is mixed: desktop tested strongly, mobile has room for improvement. Real-user performance was not available.`

Forbidden:
broad `PASS`, `already working`, or real-user claim.

### Evidence scope

Evidence:
not collected / provider failed / crawl blocked.

Client truth:
`We did not have enough evidence to determine this. No positive or negative site conclusion is made.`

Forbidden:
`PASS`, `no action required`, `no blocker`, or `NOT APPLICABLE` unless independently established.

## Root-to-boundary map

### 1. CTA_PATH_COHERENCE
Primary boundary:
- `src/report-model/cross-report-interpretation.js`
- `src/scoring/report-model.js`
- `src/report/render-report-v2.js`

Rule:
summary strength/adequacy must inherit path truth; score threshold alone cannot override path status.

### 2. PRIORITY_HIERARCHY_COHERENCE
Primary boundary:
- `src/report/action-priority.js`
- `src/report/render-report-v2.js`
- WriterInput/Narrative priority projection

Rule:
one action object owns rank, client impact label, business reason, and group. Renderer must not derive a second impact story from `severity`.

### 3. BUYER_QUESTION_COVERAGE_COHERENCE
Primary boundary:
- `src/scoring/score-components.js`
- Client Truth Contract
- renderer / WriterInput

Rule:
FAQ evidence may produce an FAQ conclusion only. Broader buyer-question coverage requires separate evidence.

### 4. TRUST_ATTRIBUTION_COHERENCE
Primary boundary:
- Client Truth Contract
- `src/report/report-detail-sections.js`
- Writer/Judge consumer rules

Rule:
presence != placement/effectiveness. `underused` is forbidden without placement/use evidence.

### 5. PERFORMANCE_QUALIFICATION_COHERENCE
Primary boundary:
- Client Truth Contract
- `src/report/render-report-v2.js`
- `src/report/report-detail-sections.js`
- Writer/Judge consumer rules

Rule:
lab, field, and mobile usability are separate facts. A numeric aggregate cannot create a broader PASS than the evidence state.

### 6. EVIDENCE_SCOPE_STATUS_COHERENCE
Primary boundary:
- Client Truth Contract
- `src/report/report-detail-sections.js`
- `src/report/render-report-v2.js`
- deterministic integrity gate
- Writer/Judge hard-gate rules

Rule:
partial/unavailable/failed/not-collected states must fail closed everywhere. `NOT APPLICABLE` requires affirmative applicability logic, not absence of evidence.

### 7. CONTENT_RECOMMENDATION_INTEGRITY
Primary boundary:
- `src/scoring/report-model.js`
- deterministic integrity gate
- renderer

Rule:
no recommendation may render with undefined/null/empty required semantic slots. Invalid recommendation -> omit it and record limitation, never render placeholder text.

## Expected application file boundary

### Required / strongly expected

1. `services/worker/src/report-model/cross-report-interpretation.js`
   - expand/replace current v1 projection with the authoritative Client Truth Contract.

2. `services/worker/src/scoring/vantage-score.js`
   - build and persist the expanded deterministic projection from governed inputs.

3. `services/worker/src/scoring/score-components.js`
   - narrow FAQ finding semantics so the finding itself does not overclaim buyer-question absence.

4. `services/worker/src/scoring/report-model.js`
   - remove independent semantic drift where it conflicts with client truth; protect content-idea generation from undefined placeholders.

5. `services/worker/src/report/action-priority.js`
   - emit one client-facing priority rationale/impact label consumed everywhere.

6. `services/worker/src/report/render-report-v2.js`
   - stop deriving summary truth from raw thresholds/severity where Client Truth exists.

7. `services/worker/src/report/report-detail-sections.js`
   - consume Client Truth for trust, performance, technical/status, deferred/unavailable and related client conclusions.

8. `services/worker/src/narrative-v2/writer-input.js`
   - expose the Client Truth Contract as a first-class deterministic input/reference source.

9. `services/worker/src/narrative-v2/writer-prompt.js`
   - require Narrative claims to stay at or below Client Truth.

10. `services/worker/src/narrative-v2/live-binding.js`
   - extend Judge instructions so stronger-than-client-truth claims are hard failures.

11. `services/worker/src/narrative-v2/judge-contract.js`
   - if needed, add deterministic contract validation for the new hard-gate class.

### New file likely warranted

12. `services/worker/src/report-model/client-truth-gate.js`
   - deterministic validation of the Client Truth Contract and prohibited upgrades before rendering/Narrative consumption.

Exact source-file edits must be verified from the current working candidate before implementation. This design identifies the expected complete boundary; it does not authorize editing yet.

## Files/systems explicitly not expected to change unless new evidence proves otherwise

- provider/adaptor acquisition code;
- raw/normalized/canonical evidence collection;
- scoring weights or scoring version solely to change outcomes;
- lifecycle/state transitions;
- authentication;
- storage architecture;
- production deployment configuration;
- n8n core orchestration;
- provider/model configuration.

## Deterministic hard rules

The repair must enforce at least these rules:

1. `UNAVAILABLE / FAILED / BLOCKED / NOT_COLLECTED` -> never client `PASS`, `no blocker`, `no action required`, or absence claim.
2. `PARTIAL` -> never complete/site-wide certainty without explicit bounded scope.
3. CTA/form presence -> never usable/effective conversion path by itself.
4. Weak path -> never summary `working/strong/adequate` unless a separately defined score label is explicitly qualified and cannot be mistaken for path quality.
5. FAQ false -> never broad buyer-question absence.
6. trust asset present -> never `underused/poorly placed` without placement evidence.
7. lab performance -> never real-user field performance.
8. missing field performance -> never complete performance readiness conclusion.
9. `NOT APPLICABLE` -> requires affirmative rule that the question genuinely does not apply.
10. recommendation strings containing unresolved placeholders, `undefined`, `null`, or missing required semantic values -> fail validation and do not render.
11. priority rank, impact label, and business reason -> come from one action hierarchy object.
12. renderer and Writer cannot independently reclassify a Client Truth construct.

## Test / proof plan

### A. New direct contract tests

Add deterministic tests for every Client Truth construct and all 12 hard rules above.

### B. Seven root regressions

One targeted regression per confirmed root.

### C. Existing 7 scenario proofs — required result 7/7 PASS

- `path-validated-blocker.html`
- `competitor-present.html`
- `unassessed.html`
- `no-conversion-mechanism.html`
- `no-performance.html`
- `crawl-blocked.html`
- `provider-failed.html`

### D. Cross-consumer parity tests

The same Client Truth values must be observed by:

- deterministic renderer;
- WriterInput;
- Narrative Writer/Judge contract;
- action plan / executive summary consumers.

No consumer may recompute the governed meaning independently.

### E. Recommendation integrity tests

No `undefined`, `null`, empty semantic slot, or broken interpolation may reach client HTML.

### F. Full deterministic regression

- focused report suites;
- full worker suite;
- Whole-App branch matrix/tranche gate;
- exact-SHA render generation.

### G. Model-bearing gate

Required if Writer/Judge input/prompt/contract is changed. Deterministic PASS alone is not sufficient.

### H. Human outcome review

After a repaired exact candidate exists:

- Brad re-checks the repaired 7 roots and 7 scenarios;
- rendered visual review is completed on actual screenshots/browser render;
- Betty Final Audit only after Brad PASS.

## Cost / performance / retry impact

- Core Client Truth Contract is deterministic and should add negligible runtime/cost.
- No new provider calls are required.
- No n8n dependency is required for correctness.
- Writer/Judge prompt/input growth should be bounded because Client Truth can replace repeated raw interpretation context rather than only add to it.
- No automatic extra model pass is authorized.

## Implementation order after approval

1. Freeze/verify exact current application branch and working tree.
2. Add/upgrade Client Truth Contract + direct unit tests.
3. Add deterministic Client Truth gate.
4. Repair producer semantics: FAQ finding + content recommendation integrity.
5. Repair unified action-priority client rationale.
6. Migrate deterministic renderer consumers to Client Truth.
7. Migrate detail-section consumers to Client Truth.
8. Migrate WriterInput/Writer/Judge to Client Truth.
9. Run targeted seven-root tests.
10. Run all 7 scenario proofs; require 7/7.
11. Run full worker + Whole-App + model-bearing gates as applicable.
12. Generate exact repaired candidate.
13. Brad outcome re-review + rendered visual review.
14. Betty only after Brad PASS.
15. Merge/deploy only after all release gates and explicit authorization.

## Decision requested from Chris

Approve or reject this architecture before any application edit.

Recommended decision:

**APPROVE — deterministic Client Truth Contract + existing Writer/Judge, with n8n kept outside the core truth path for now.**
