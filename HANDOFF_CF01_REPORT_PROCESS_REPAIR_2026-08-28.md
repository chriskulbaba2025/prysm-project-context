# PRYSM — CF-01 Report Process Repair Handoff

Date: 2026-08-28
Status: Ready for governed implementation
Supersedes for continuation purposes: `HANDOFF_CONVERSION_FIRST_V4_2_2026-08-28.md`

## Start here

Continue PRYSM from the authoritative GitHub context repository:

`chriskulbaba2025/prysm-project-context`

Read first:

```text
PROJECT.md
GITHUB_PROJECT_MEMORY_PROTOCOL.md
REPAIR_BOUNDARY_PROTOCOL.md
DIAGNOSTIC_EVIDENCE_PROTOCOL.md
WORKFLOW_INSTRUCTIONS.md
TERMINOLOGY.md
CURRENT_STATE.md
CONSTRAINTS.md
DECISIONS.md
CONVERSION_FIRST_V4_2.md
HANDOFF_CF01_REPORT_PROCESS_REPAIR_2026-08-28.md
```

Treat GitHub as authoritative. Do not reconstruct state from prior chats.

## Application checkpoint

Repository:
`chriskulbaba2025/vantage-platform`

Branch:
`main`

Latest verified remote commit:
`90916e94f6feba73e7e60df54bd641bb2362454c`

Commit:
`test(prysm): repair CI regression baselines`

GitHub Actions:
- workflow run: `33171616359`
- job: `98849897567` (`verify`)
- result: COMPLETED / SUCCESS
- all configured test/acceptance steps passed

Before the first source edit in the new chat, verify local state once:

```powershell
cd C:\Users\kulba\Desktop\vantage-platform
git status --short
git rev-parse HEAD
```

Expected HEAD:

```text
90916e94f6feba73e7e60df54bd641bb2362454c
```

If clean and exact, proceed. Do not keep re-checking the baseline unless it changes.

## CI closure completed in this session

### Regression 1 — representative evidence test

File:
`services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-representative-evidence.test.js`

Repair:
The regression scenario now explicitly sets:

```js
contentParsingPageLimit: 20,
```

Production remains:

```text
contentParsingPageLimit = 50
```

Focused result:
`4/4 PASS`

### Regression 2 — branded renderer freeze

File:
`services/worker/src/report/render-report-v2-conversion.test.js`

Repair:
`RENDER_GOLDEN` was re-frozen against the intentional current branded renderer output.

Focused result:
`47/47 PASS`

The subsequent full GitHub `verify` workflow is green. Do not reopen these CI items unless new evidence fails them.

## Frozen TBK baseline

Target:
`https://www.tbkcreative.com/`

Audit:
`9714c206-8ed3-4686-8fe2-ceeca0ca0f82`

Verified report metrics:
- Conversion Readiness: 65/100
- Evidence Confidence: 95/100
- Evidence Coverage: 100%
- Evidence capabilities: 12/13
- Modules assessed: 10/10
- Conversion Path: 100/100
- Performance & Experience: 71/100
- browser conversion validation: 6/6 selected pages
- final Narrative v2 Judge: pass 3, score 97, PASS

The complete governed audit prefix was copied read-only from S3 into:

```text
C:\Users\kulba\Desktop\vantage-platform\services\worker\test-fixtures\report-replay\audit-9714c206-8ed3-4686-8fe2-ceeca0ca0f82\governed
```

Permanent local HTML review copy:

```text
C:\Users\kulba\Desktop\vantage-platform\services\worker\test-fixtures\report-replay\audit-9714c206-8ed3-4686-8fe2-ceeca0ca0f82\TBK-PRYSM-LOCAL.html
```

## Offline replay proof

Command used:

```powershell
cd C:\Users\kulba\Desktop\vantage-platform\services\worker
node scripts/replay-report.js test-fixtures\report-replay\audit-9714c206-8ed3-4686-8fe2-ceeca0ca0f82
```

Verified result:

```text
PASS 9714c206-8ed3-4686-8fe2-ceeca0ca0f82
viewer 2.2.0
findings 4
baseline MATCH
sha256 e002f1570296...
Replay result: 1/1 PASS
```

The replay harness blocks network requests. This gives a stable local fixture for report-process work without provider/model calls, production reruns, rescoring external data, or persisted production mutation.

## Defect reproduced visually

The local baseline report still opens the Executive Scorecard with:

- primary root cause: missing meta descriptions;
- first action: missing meta descriptions;
- followed by heading structure and security headers.

At the same time, the same report shows strong governed conversion-path evidence, including Conversion Path 100/100 and 6/6 browser-confirmed actions.

This confirms the current problem is not stale/missing audit data. The saved production report is being reproduced exactly. The defect is the report-process hierarchy and inconsistent interpretation across client-facing consumers.

## CF-01 root cause

PRYSM does not currently carry one shared governed **conversion-influence decision view** from canonical evidence through every client-facing consumer.

Instead, foundation, canonical finding priority, Action Plan, Executive rendering, Writer/Judge, and competitor comparison can independently reinterpret state and importance.

That architecture permits:
- browser-confirmed conversion plus a false “no CTA/form” foundation conclusion;
- technical findings becoming the primary executive story solely through canonical numeric priority;
- Executive “holding back” and “do first” using different priority systems;
- Narrative statements that disagree with deterministic readiness ranking;
- competitor/site conversion states that disagree with the main report;
- large volumes of insufficient competitor candidates appearing in client-facing comparison output.

## Proven source boundaries

### Conversion contradiction

`services/worker/src/report/foundation-readiness.js`

The foundation layer can gate against capability availability but then decide CTA/form state from site-level arrays. That allows empty crawl-derived CTA/form arrays to produce a “no conversion” conclusion even when browser conversion validation is AVAILABLE and 6/6 actions were confirmed.

### Executive priority mismatch

`services/worker/src/report/render-report-v2.js`

The Executive page currently has separate priority consumers:
- “What is holding the site back?” can use canonical finding order (`findings.slice(0, 3)`);
- “What should you do first?” uses conversion-first action ordering.

This permits one page to tell two different priority stories.

### Narrative ordering inconsistency

`services/worker/src/narrative-v2/writer-findings.js`
`services/worker/src/narrative-v2/writer-input.js`
`services/worker/src/narrative-v2/writer-scores.js`
`services/worker/src/narrative-v2/writer-prompt.js`
`services/worker/src/narrative-v2/judge-contract.js`

Writer receives canonical findings/score representations without one shared conversion-influence classification. The prompt does not impose the full v4.2 hierarchy, and Judge does not currently enforce deterministic cross-view ordering consistency.

### Competitor inconsistency/noise

`services/worker/src/scoring/report-model.js`

The comparative layer can derive the audited site's conversion path from crawl CTA/forms instead of the same governed conversion capability used by the main report, and can lose candidate qualification/evidence-status semantics during projection.

`services/worker/src/evidence/competitor-opportunity-layer.js` already has useful QUALIFIED vs INSUFFICIENT_EVIDENCE semantics; preserve them downstream rather than re-solving qualification.

### Existing action priority layer

`services/worker/src/report/action-priority.js`

This is the correct first implementation boundary because it already contains a derived client-facing business-impact rank. Extend it into the shared full Conversion-First v4.2 influence contract rather than creating a new persisted scoring system.

## Scoring judgment

**Do not change score weights for CF-01.**

The observed problem is downstream hierarchy, lineage, and client-facing interpretation. Changing scoring weights would distort otherwise valid technical measurements to hide an ordering defect.

Numeric scoring remains evidence. Conversion-first influence governs which evidence leads the client-facing story.

## Governed target hierarchy

Use `CONVERSION_FIRST_V4_2.md` as the governing specification:

1. Offer and audience clarity
2. Trust and proof
3. Conversion path and action
4. Friction and experience
5. Buyer-question and decision support
6. Acquisition and discoverability
7. Technical causes and resilience

A proven foundation blocker may override the hierarchy only where governed evidence shows the buyer cannot discover, understand, complete, or safely execute the primary action.

Evidence confidence remains a gate. PARTIAL/unknown evidence cannot be upgraded into a confirmed defect simply because the domain is important.

## Smallest expected implementation sequence

The pre-edit repair boundary has already been mapped. Do not repeat the full architecture audit unless current source evidence materially invalidates this sequence.

1. `services/worker/src/report/action-priority.js`
   - extend the shared derived client influence/ranking contract to the full v4.2 hierarchy;
   - keep it derived/render-time; do not mutate persisted FindingSet or scoring.

2. `services/worker/src/report/foundation-readiness.js`
   - consume the governed conversion observation consistently;
   - browser-validated conversion plus empty crawl CTA arrays must not become “no conversion”.

3. `services/worker/src/scoring/report-model.js`
   - preserve competitor candidate qualification/evidence status;
   - reconcile audited-site conversion state with the main governed conversion evidence.

4. `services/worker/src/report/render-report-v2.js`
   - make “holding back” and “do first” consume the same conversion-first influence view;
   - keep technical evidence visible but not automatically leading;
   - client-facing competitor presentation should emphasize usable evidence.

5. `services/worker/src/narrative-v2/writer-input.js`
   and then `writer-findings.js` as a separate governed source-file unit if required
   - expose the same derived conversion influence/order to Writer;
   - do not mutate persisted canonical findings.

6. `services/worker/src/narrative-v2/writer-prompt.js`
   - impose the exact governed Conversion-First hierarchy on synthesis.

7. `services/worker/src/narrative-v2/judge-contract.js`
   - add hierarchy/cross-view consistency checks;
   - preserve existing release threshold, evidence-fidelity gates, dimension floors, and hard-gate protections.

Do **not** modify `services/worker/src/report/sections-conversion.js` unless active Report v2 reachability is directly proven first.

## Required regression gates

At minimum, prove:

1. browser-validated conversion + empty site CTA/form arrays cannot produce a client conclusion that no conversion mechanism exists;
2. a higher technical numeric priority cannot outrank a stronger conversion-leading issue solely because of numeric `finalPriority`;
3. Executive “holding back” and “do first” use the same governed hierarchy;
4. Writer receives derived influence/order without mutation of persisted FindingSet/canonical findings;
5. Writer prompt contains the exact v4.2 hierarchy;
6. Judge rejects deterministic hierarchy/cross-view contradictions while preserving evidence-fidelity rules;
7. competitor QUALIFIED/evidence status survives projection;
8. insufficient-evidence competitor candidates cannot dominate the client-facing comparison;
9. the audited site's Conversion Path state is consistent across main report and comparative layer;
10. legitimate technical findings remain visible as supporting evidence;
11. no scoring-weight, provider, evidence-collection, ceiling, auth, lifecycle, storage, or production-configuration change is introduced.

Use one focused proving test per governed source-file unit, then move on. Do not stack redundant checks.

## Hard boundaries

- No production audit rerun for CF-01.
- No provider/model calls for local replay or report-process verification.
- No production configuration mutation without explicit approval.
- No raw/normalized/canonical evidence mutation.
- No scoring-weight rewrite for an ordering/presentation defect.
- Preserve production content-parsing default = 50.
- Preserve 250 provider crawl ceiling and 20 priority-URL ceiling.
- Preserve Viewer v2.2.0 unless separately approved.
- Preserve AVAILABLE/PARTIAL/UNAVAILABLE/FAILED semantics.
- Preserve Narrative/Judge evidence fidelity and human authorization rules.
- Do not invent revenue/conversion outcomes.
- Do not turn PARTIAL evidence into confirmed absence/presence.
- Follow manual VS Code delivery: exact full path, exact current lines/anchors, bottom-up multiple edits, complete replacement blocks, one proving test, then stop for user result.
- Same observable defect: maximum three failed repair attempts before deeper diagnosis.

## Exact next action

In the new chat:

1. Read the authoritative files listed at the top.
2. Verify local `main` is clean and at `90916e94f6feba73e7e60df54bd641bb2362454c` once.
3. Do **not** redo CF-01 from scratch.
4. Begin the first governed source-file unit in:

```text
C:\Users\kulba\Desktop\vantage-platform\services\worker\src\report\action-priority.js
```

Inspect the exact current file/lines, apply the already-mapped full v4.2 conversion-influence hierarchy, run the single focused proving test, and stop for the result before the next file.
