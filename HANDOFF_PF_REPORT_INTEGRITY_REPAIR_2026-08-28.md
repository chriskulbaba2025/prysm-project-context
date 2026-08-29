# PRYSM Handoff — PF Pre-Run Report Integrity Repair

Date: 2026-08-28
Status: Active handoff

## Repository authority

Context repository:
`chriskulbaba2025/prysm-project-context`

Application repository:
`chriskulbaba2025/vantage-platform`

Application branch:
`main`

Verified remote application checkpoint:
`90916e94f6feba73e7e60df54bd641bb2362454c`
`test(prysm): repair CI regression baselines`

GitHub `main` and the uploaded local preflight both verify the same application HEAD. The application working tree is intentionally dirty with known local CF-01/Narrative changes and replay fixtures. Do not reset, clean, discard, or overwrite them.

## Read first

Read the authoritative files before substantive work:

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
HANDOFF_PF_REPORT_INTEGRITY_REPAIR_2026-08-28.md
```

Treat GitHub as authoritative. Do not reconstruct the project from older chats.

## Current work package

Work package:
**PF — Pre-Run Report Integrity Repair**

Purpose:
Repair the proven deterministic evidence-semantic and downstream report/Narrative boundaries before spending on another fresh TBK Writer/Judge run.

Diagnostic status:
The bounded second preflight sweep is complete at approximately 98% confidence that the material report-path defect families have been identified. This confidence is not a completion claim; each PF item still requires executable proof. Do not repeat the broad investigation unless new source/runtime evidence materially contradicts this handoff.

## Frozen TBK baseline

Audit:
`9714c206-8ed3-4686-8fe2-ceeca0ca0f82`

Target:
`https://www.tbkcreative.com/`

Frozen governed fixture:
`C:\Users\kulba\Desktop\vantage-platform\services\worker\test-fixtures\report-replay\audit-9714c206-8ed3-4686-8fe2-ceeca0ca0f82\governed`

Verified baseline metrics:
- Conversion Readiness: 65/100
- Evidence Confidence: 95/100
- Evidence Coverage: 100%
- Evidence capabilities: 12/13
- Modules assessed: 10/10
- Conversion Path: 100/100
- Performance & Experience: 71/100
- Browser conversion validation: 6/6 selected pages
- Viewer: 2.2.0

Frozen raw/normalized/canonical evidence is immutable. PF repairs may rebuild derived findings/scores/report inputs locally or in memory from this frozen evidence, but may not recollect providers or overwrite the frozen evidence artifacts.

## Exact current local application state

Local path:
`C:\Users\kulba\Desktop\vantage-platform\services\worker`

Local HEAD:
`90916e94f6feba73e7e60df54bd641bb2362454c`

Modified application files recorded by `PRYSM-PREFLIGHT-LOCAL.diff`:

```text
src/narrative-v2/contract-closure.test.js
src/narrative-v2/judge-contract.js
src/narrative-v2/live-binding.js
src/narrative-v2/writer-input.js
src/narrative-v2/writer-prompt.js
src/report/action-priority.js
src/report/foundation-readiness.js
src/report/render-report-v2-conversion.test.js
src/report/render-report-v2.js
src/scoring/report-model.js
```

Known untracked local items include:

```text
PRYSM-PREFLIGHT-LOCAL.diff
test-fixtures/report-replay/audit-1e060a5b-2eb4-4800-b8f9-bca52574aa64-narrative-refresh/
test-fixtures/report-replay/audit-9714c206-8ed3-4686-8fe2-ceeca0ca0f82/
test-fixtures/report-replay/audit-9c87448a-c1a1-41eb-a0e5-a8dd63cf8da4-narrative-refresh/
test-fixtures/report-replay/audit-ea9a3b49-d393-4633-956b-d6cb1a2a3fc8-narrative-refresh/
```

Do not delete or clean these as part of PF.

## Local CF-01/Narrative work already completed

Do not redo these repairs merely because they are uncommitted:

- `action-priority.js` now derives a Conversion-First v4.2 influence domain/rank and allows supported evidence to lead while directional evidence cannot displace it.
- `foundation-readiness.js` reconciles browser-validated conversion mechanisms with empty crawl CTA/form arrays.
- `render-report-v2.js` uses the derived action plan for Executive ordering/root cause, suppresses non-AVAILABLE competitor rows from deterministic client rendering, and derives the audited-site comparative conversion state from governed conversion paths.
- `report-model.js` carries browser conversion validation into deterministic conversion state and preserves competitor evidence status/insufficient-evidence projection.
- `writer-input.js` carries `deterministicAnalysis.conversionInfluence` into WriterInput without mutating persisted findings.
- `writer-prompt.js` contains Conversion-First v4.2 ordering plus tightened PARTIAL/AI-search language.
- `judge-contract.js` requires explicit `analysis:conversionInfluence` grounding.
- `live-binding.js` tells Judge to independently challenge evidence certainty, preserve PARTIAL semantics, and perform a broader evidence-fidelity scan before locking revision fields.

Latest targeted Narrative closure test:

```text
tests 5
pass 5
fail 0
duration 473.3933 ms
```

## Fresh Narrative refresh evidence

### Exhausted refresh

Audit:
`ea9a3b49-d393-4633-956b-d6cb1a2a3fc8`

Result:
- passes: 3
- all six Writer/Judge call slots consumed
- final status: `HUMAN_REVIEW_REQUIRED`
- Judge 3 score: 91
- no report rendered

Judge 3 found MAJOR PARTIAL-evidence overclaims in fields Judge 2 had previously treated as locked/clean. This proved that stochastic Judge locking alone is not a reliable semantic safety boundary.

**No fourth pass is permitted on this identity.**

### Latest fresh refresh

Audit:
`9c87448a-c1a1-41eb-a0e5-a8dd63cf8da4`

Result:
- passes: 2
- status: `HUMAN_REVIEW_REQUIRED`
- Judge decision: `REVISE`
- Judge score: 94.5
- no report rendered

Remaining MAJOR defect:
`content.importantGaps` described buyer-question content as an established gap even though `content.body` evidence was PARTIAL (25 of 35 requested pages usable). The evidence supports only “not detected in the available partial assessment” plus an opportunity/recommendation.

This failure triggered the deeper diagnostic reset and full preflight sweep.

## Proven root architecture problem

The report path has repeatedly treated `PARTIAL` as equivalent to “fully assessed.” That leaks through multiple layers:

```text
Evidence/capability status
→ module eligibility/scoring
→ deterministic findings
→ persisted root cause/action inputs
→ deterministic report sections
→ WriterInput
→ free-form Writer prose
→ stochastic Judge
```

The Writer/Judge loop is therefore being asked to repair deterministic semantic contradictions that should have been prevented upstream.

PF fixes move those invariants back into deterministic code and contracts.

## Frozen PF checklist

### PF-01 — PARTIAL is not complete assessment

Required outcome:
`PARTIAL` may remain score-bearing for actually observed evidence, but it may not establish whole-site absence, FALSE/ZERO, or a complete PASS. Every consumer must preserve assessed scope/coverage.

### PF-02 — Cross-capability scoring isolation

Required outcome:
A module may score only fields/signals whose governing capability actually assessed them. CTA/forms, trust, FAQ, pricing, schema, metadata, etc. cannot become negative/zero merely because a different capability ran.

### PF-03 — Negative finding certainty

Required outcome:
Absence findings require sufficient evidence for that exact signal/capability. `VAN-CONTENT-002` and similar rules must not produce unqualified “missing/no/absent” conclusions from PARTIAL coverage. The buyer-question rule must depend on the content evidence it actually interprets, not only `trust.proof`.

### PF-04 — Preserve field-specific evidence certainty

Required outcome:
Do not overwrite field/capability certainty with a coarse site-level status. Repair metadata availability so `_metaFieldAvailability` and aggregate metadata gating cannot disagree about whether title/description/canonical/heading evidence was collected.

### PF-05 — Denominator and decision-scope integrity

Required outcome:
Client-facing numerator/denominator claims must be internally possible and evidence-backed. Utility-page decision scoping must not leave stale aggregate counts/signals that still include excluded utility pages. Prevent impossible output such as `222 of 0 observed images`.

### PF-06 — Deterministic renderer certainty parity

Required outcome:
E-E-A-T, schema, technical, foundation, accessibility/mobile, and related deterministic pages must obey the same PARTIAL/AVAILABLE distinction as findings/Narrative. PARTIAL cannot silently become complete PASS or complete FINDING.

### PF-07 — Conversion-First consumer parity

Required outcome:
All deterministic and Narrative consumers use the same governed action hierarchy, including the same foundation checklist/override semantics. `writer-input.js` must not derive a weaker/different action plan than the deterministic report.

### PF-08 — Remove stale root-cause authority

Required outcome:
The old numeric-priority `scoreSet.rootCause` must not compete with the newer Conversion-First hierarchy inside WriterInput or client output. Root-cause authority must be one deterministic governed view.

### PF-09 — Deterministic action-plan effort/order

Required outcome:
Writer action effort and order must match the governed finding/action model. The Writer cannot reinterpret governed effort or reorder actions against the deterministic Conversion-First hierarchy.

### PF-10 — Supplied competitor allowlist

Required outcome:
Only URLs supplied in `auditRequest.competitors` are eligible for client-facing competitor comparison or Narrative competitor claims. Discovered SERP candidates may remain internal evidence but cannot be substituted or exposed as additional client competitors.

### PF-11 — Competitor capability viability

Required outcome:
A competitor with an AVAILABLE outer source record is not automatically assessable for trust/CTA/content/path signals. Comparative labels require the relevant usable competitor evidence; otherwise render Not Assessed/insufficient evidence.

### PF-12 — Deterministic Narrative evidence-fidelity validator

Required outcome:
Before Judge, deterministic validation rejects or prevents semantic classes already proven unsafe, including PARTIAL→absence, unmeasured outcome certainty, content detection→AI-search limitation, and governed action effort/order contradictions.

### PF-13 — Neutral Narrative required-field state

Required outcome:
Required output fields such as `importantGaps`, `constraints`, `proofGaps`, and competitor `disadvantages` must support evidence-bounded neutral language/state when no negative conclusion is established. The schema must not force fabrication merely because the field is required.

### PF-14 — Safe Judge locking

Required outcome:
A field cannot become effectively locked for a targeted revision while deterministic semantic validation still finds a material defect in that field. Judge revision directives must not create a pass-3 dead end from latent evidence-fidelity defects.

### PF-15 — Writer source-status reference completeness

Required outcome:
If WriterInput expects `scoreSet.sourceDependencies` to create exact `source:*` references, ScoreSet persistence must actually carry those dependencies or WriterInput must use another governed source. Do not silently drop required source-status grounding.

### PF-16 — Contract/version integrity

Required outcome:
Governance-critical evidence markers used at runtime must have an explicit contract boundary where required; finding evidence source statuses must be constrained to governed statuses; materially changed Writer/Judge prompts/contracts must have truthful versions/hashes.

### PF-17 — Exact deterministic section filters

Required outcome:
Report sections must display only findings belonging to their actual semantic scope. In particular, “Material performance findings” must not include unrelated metadata/headings/security findings merely because they share the broader `technical_performance` dimension.

### PF-18 — Stronger finalization gate

Required outcome:
Before client HTML release, deterministic finalization catches the defect families that can be checked without an LLM: impossible denominators, PARTIAL→complete assessment contradictions, competitor allowlist overflow, action/root-cause hierarchy disagreement, and invalid Narrative semantic state.

## Important preflight findings that must not be lost

1. `PARTIAL` is intentionally allowed to be score-bearing. Do **not** solve PF by suppressing PARTIAL wholesale. Score only what was actually assessed and preserve incomplete coverage.
2. `technical.indexability` and similar consumers can currently interpret PARTIAL as a complete assessment; both false PASS and false FINDING are possible.
3. Several modules use fields governed by other capabilities; unknown interactive/trust/content signals can leak into numeric penalties.
4. DataForSEO emits `_metaFieldAvailability`, but the metadata aggregate gating path can disagree with it, creating score/finding inconsistency.
5. Decision scoping filters utility pages but does not necessarily recompute every aggregate signal derived before filtering.
6. The deterministic detail renderer currently has several `AVAILABLE + PARTIAL` helper paths, reproducing the same semantic bug outside Narrative.
7. Accessibility alt-text rendering can create invalid numerator/denominator language without checking that image evidence/denominator is usable.
8. Performance detail filtering is too broad and can include unrelated technical findings.
9. `scoreSet.rootCause` remains an older deterministic view and is copied into Writer score context even though CF-01 added a separate Conversion-First hierarchy.
10. `writer-input.js` currently derives the action hierarchy with `buildActionPlan({findings})` without passing the same foundation checklist used by deterministic rendering.
11. The current renderer competitor filter is only a presentation filter (`status === AVAILABLE`); it is not the required supplied-competitor allowlist boundary.
12. Decision-evidence hydration receives `suppliedCompetitors` but the preflight found that the client-facing allowlist is not enforced at the correct upstream boundary.
13. Finalization currently does not act as a deterministic backstop for the main PF semantic families.

## Hard boundaries

Do not:
- reset/clean/discard the current local working tree;
- recollect DataForSEO, PageSpeed, backlinks, GA4, GSC, browser evidence, or any other provider evidence for this repair;
- mutate frozen TBK raw/normalized/canonical evidence;
- change scoring weights or scoring version merely to change results;
- lower the Narrative 92 release threshold;
- weaken evidence-fidelity, dimension floors, hard gates, major-defect protections, pass limits, or final-pass authorization;
- exceed the 2 automatic passes / 4 calls or 3 total passes / 6 calls Narrative contract;
- make a fourth call on an exhausted Narrative identity;
- deploy, push, mutate production configuration, or mutate production persisted artifacts without explicit approval;
- change Viewer v2.2.0, provider crawl ceiling 250, priority-URL ceiling 20, or content-parsing default 50 as part of PF;
- redo the broad preflight investigation without materially contradictory new evidence.

The active bounded exception is recorded in `CONSTRAINTS.md` under **Authorized exception — PF pre-run report-integrity repair**.

## Required implementation discipline

Follow `REPAIR_BOUNDARY_PROTOCOL.md`, `DIAGNOSTIC_EVIDENCE_PROTOCOL.md`, and `WORKFLOW_INSTRUCTIONS.md`.

For every source-file unit:
1. verify the exact current local file/boundary;
2. complete the Mandatory Pre-Edit Gate;
3. freeze the observable expected behavior and downstream impact;
4. make the smallest coherent change;
5. exact path + current line numbers/anchors;
6. multiple edits bottom-up;
7. complete replacement blocks;
8. one highest-information proving test;
9. stop for the result before moving to the next source-file unit.

Do not preserve an old test merely because it is green if it encodes behavior now proven to violate evidence semantics. Test changes must represent an intentional corrected contract, not regression silencing.

## Planned repair order

Use root-cause order rather than symptom order:

1. `score-components.js` — PF-01/PF-02/PF-03 foundation.
2. Capability/metadata evidence status boundary required by PF-04 and any proven scoring dependency.
3. Decision-scope / denominator integrity PF-05.
4. Deterministic report certainty parity and exact filters PF-06/PF-17.
5. Conversion-First root/action consumer parity PF-07/PF-08/PF-09.
6. Competitor supplied allowlist + viability PF-10/PF-11.
7. Writer deterministic semantic validation / neutral states / source refs PF-12/PF-13/PF-15.
8. Judge lock safety and contract/version integrity PF-14/PF-16.
9. Finalization gate PF-18.
10. Selected regression suite.
11. Rebuild deterministic TBK findings/scores/report inputs locally from frozen evidence.
12. Offline report preflight and browser-served deterministic review.
13. Only when deterministic PF package is green: obtain explicit approval for one fresh Narrative identity.
14. Fresh Writer/Judge run from the same frozen TBK evidence using repaired derived inputs.
15. Render only on governed PASS, then browser review.
16. Only after report acceptance: consider application commit/push/deploy under explicit authorization.

The sequence may be adjusted only when a verified dependency requires a different source-file order. Do not turn the list into parallel multi-file editing.

## Exact next action

At the start of the new chat:

```powershell
cd C:\Users\kulba\Desktop\vantage-platform
git status --short
git rev-parse HEAD
```

Expected HEAD:

```text
90916e94f6feba73e7e60df54bd641bb2362454c
```

The tree is expected to be dirty with the known files/fixtures above. **Do not clean it.** If HEAD differs or unknown application files have changed, stop and reconcile before editing.

Then begin the Mandatory Pre-Edit Gate for:

```text
C:\Users\kulba\Desktop\vantage-platform\services\worker\src\scoring\score-components.js
```

First bounded objective:
**PF-01 + PF-02 + PF-03 only.**

Before changing code, inspect the exact current `score-components.js` and the directly relevant existing tests. Freeze the smallest repair contract that:
- preserves PARTIAL as score-bearing for observed data;
- prevents unassessed signals from becoming negative scores;
- requires the correct capability for each scored/negative signal;
- prevents unqualified absence findings from PARTIAL coverage;
- fixes the buyer-question finding dependency/wording at its deterministic source.

Then make the first governed source-file edit and run one proving test. Stop for the result.

**Do not call Writer/Judge and do not rerun the broad investigation.**

## New-chat paste prompt

```text
Continue PRYSM from the authoritative GitHub state in:

chriskulbaba2025/prysm-project-context

Read first:

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
HANDOFF_PF_REPORT_INTEGRITY_REPAIR_2026-08-28.md

Treat GitHub as authoritative. Do not reconstruct state from previous chats.

APPLICATION
Repository: chriskulbaba2025/vantage-platform
Branch: main
Expected HEAD: 90916e94f6feba73e7e60df54bd641bb2362454c

The local tree is intentionally dirty with verified CF-01/Narrative changes and frozen/local replay fixtures. Do not reset, clean, discard, overwrite, or recreate them.

The broad report-integrity preflight is COMPLETE at approximately 98% confidence. The frozen defects are PF-01 through PF-18 in the handoff. DO NOT redo the architecture/blind-spot investigation unless current source evidence materially contradicts it.

First action:
1. Verify `git status --short` and `git rev-parse HEAD` once.
2. Do not clean the tree.
3. Begin the Mandatory Pre-Edit Gate for:
   C:\Users\kulba\Desktop\vantage-platform\services\worker\src\scoring\score-components.js
4. Bound the first source-file unit to PF-01/PF-02/PF-03 only.
5. Inspect the exact current file and relevant existing tests before editing.
6. Preserve PARTIAL as score-bearing for actually observed data, but prevent PARTIAL/unassessed evidence from becoming complete absence, complete PASS, or negative scoring for signals that were not assessed.
7. Fix the buyer-question finding dependency/wording at its deterministic source.
8. Give exact current lines/anchors and bottom-up replacements per WORKFLOW_INSTRUCTIONS.md.
9. Run one highest-information proving test and stop for my result.

Do not call providers or Writer/Judge. Do not run a production audit. Do not alter scoring weights/version, Viewer 2.2.0, crawl limits, Narrative release threshold, or pass limits.

Goal after PF-01 through PF-18 close:
rebuild derived TBK findings/scores/report inputs locally from the immutable frozen evidence, pass offline/browser preflight, then obtain explicit approval for one fresh governed Writer/Judge identity and finally render the report.
```
