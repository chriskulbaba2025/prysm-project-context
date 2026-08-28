# PRYSM — Conversion-First v4.2 Handoff

Date: 2026-08-28
Status: Ready to begin

## Start here

Continue PRYSM from the authoritative GitHub context repository:

`chriskulbaba2025/prysm-project-context`

Read these files first:

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
EFFICIENCY_METRICS.md
CONVERSION_FIRST_V4_2.md
HANDOFF_CONVERSION_FIRST_V4_2_2026-08-28.md
```

Treat GitHub as authoritative. Do not reconstruct project state from old chats.

## Application repository

Repository:
`chriskulbaba2025/vantage-platform`

Branch:
`main`

Latest verified application checkpoint:
`a540640c0d5c9f3bc9c777a1b8d9aa5e8e8ae212`

Commit message:
`fix(prysm): recover interrupted final narrative pass`

Before substantive work, verify local state:

```powershell
cd C:\Users\kulba\Desktop\vantage-platform
git status --short
git rev-parse HEAD
```

Do not discard or overwrite unrelated work if local state differs.

## Production configuration checkpoint

Explicitly approved current production Narrative v2 budget:

```text
PRYSM_LLM_HARD_BUDGET_USD=5.00
PRYSM_LLM_DAILY_HARD_BUDGET_USD=30.00
```

Writer model at the latest validation:
`gpt-5.6-terra`

Judge model at the latest validation:
`gpt-5.6-sol`

Do not mutate production configuration without new explicit approval.

## Latest production baseline

Target:
`https://www.tbkcreative.com/`

Latest audit:
`9714c206-8ed3-4686-8fe2-ceeca0ca0f82`

Use this audit/report as the primary v4.2 baseline.

Verified latest report results:
- Conversion Readiness: 65/100
- Evidence Confidence: 95/100
- Evidence Coverage: 100%
- Evidence capabilities: 12/13
- Modules assessed: 10/10
- Conversion Path: 100/100
- Performance & Experience: 71/100
- Browser conversion validation: 6/6 selected pages observed a conversion action; 6/6 confirmed visible, interactable, unobstructed action
- Final Narrative v2 continuation: Writer pass 3 / Judge pass 3
- Final Judge score: 97
- Final Judge decision: PASS

Previous comparison audit:
`f7e5e17c-0828-4803-843f-20213f9ad8b9`

Previous report:
- Conversion Readiness: 55/100
- Evidence Confidence: 95/100
- Evidence Coverage: 76%
- Evidence capabilities: 8/13
- Modules assessed: 8/10
- Conversion Path: Not Assessed
- Performance & Experience: 47/100

The latest report is materially stronger. Evidence collection and conversion-path assessment are no longer the primary bottleneck.

## Current product problem

The report is still too technically forward.

Even with strong conversion-path evidence, the Executive Scorecard can still lead with:
- missing meta descriptions;
- inconsistent heading structure;
- incomplete security headers;
- other technical-hygiene issues.

The next redesign must make PRYSM behave first as a conversion-readiness decision system, not a technical SEO/crawl report with conversion language layered on top.

The client-facing order should become:

1. offer and audience clarity;
2. trust and proof;
3. conversion path and action;
4. buyer friction / UX / performance;
5. buyer-question and decision-support content;
6. acquisition/search discoverability;
7. technical causes and resilience.

Technical evidence remains governed and visible, but usually supports a business-facing problem rather than becoming the opening problem by default.

## Known report defects that must stay in scope

### 1. Conversion contradiction

The latest Foundational Readiness section can say:
- no CTA/form was detected;
- visitors have no clear way to convert.

But the dedicated Conversion Path section says:
- Conversion Path = 100/100;
- browser validation assessed 6/6 pages;
- an action was observed on 6 pages;
- visible/interactable/unobstructed action was confirmed on 6 pages.

Do not merely rewrite one sentence. Trace the two evidence consumers and eliminate the underlying cross-layer inconsistency.

### 2. Technical-dimension contradiction

The readiness map says Technical Health is the weakest assessed dimension at 6/100, while another narrative statement can say Technical Health is not the lowest assessed dimension overall.

Trace and reconcile the source/logic responsible.

### 3. Competitor noise

The client-facing competitor tables can include a very large number of SERP-discovered `Insufficient Evidence / Not Assessed` candidates.

Only useful, sufficiently evidenced competitors should dominate the client-facing comparison. Unsupported candidates may remain in governed supporting evidence/appendices if required.

### 4. Competitor/site evidence mismatch

The main report can show Conversion Path = 100/100 while the comparative layer shows this site's Conversion Path as `Not Assessed`.

The comparison layer must consume the same governed site evidence state as the rest of the report.

### 5. Executive hierarchy is too technical

The current executive priorities can still make meta descriptions/headings/security headers feel like the core business problem even when conversion, trust, offer, UX, and buyer-action evidence exists.

This is the central v4.2 design problem.

## Work package

Name:
`CF-01 — Conversion Influence Map`

### Hard instruction

**DO NOT START CODING.**

The first task is diagnostic/design only.

Trace the current application path:

```text
evidence
→ capabilities
→ scoring modules
→ findings
→ action ranking
→ Narrative Writer input
→ Judge
→ Report v2 sections
→ competitor comparison
```

Determine where technical findings gain disproportionate client-facing influence.

For each relevant output identify:
- source evidence;
- source status;
- scoring contribution;
- business-impact domain;
- ranking influence;
- Narrative Writer influence;
- report location;
- competitor-consumer path;
- whether the result is conversion-leading, conversion-supporting, or technical-only.

## Required CF-01 output

Before any edit, return:

1. **Current influence map** — exact files/functions/contracts driving the client-facing hierarchy.
2. **Proven misalignments** — defects supported by source inspection, not assumptions.
3. **Target Conversion-First model** — report/scoring/ranking/narrative hierarchy.
4. **Dependency-impact map** — what each proposed change can affect upstream/downstream.
5. **Smallest implementation sequence** — exact source-file units in order.
6. **Regression plan** — tests required for each change.
7. **Scoring judgment** — explicitly state whether scoring weights actually need changing or whether ranking/narrative/presentation is the real defect.

Do not change scoring merely because technical issues currently appear first.

## Conversion-first design questions

The redesigned tool must answer these before technical detail:

1. Can the right visitor understand the offer and who it is for?
2. Is the value/outcome clear enough to continue?
3. Is enough trust/proof present to reduce uncertainty?
4. Is the next action obvious?
5. Can the buyer complete that action?
6. Where does friction weaken the path?
7. Does the site answer the questions required to make a decision?
8. Can qualified visitors discover the important pages?
9. Which technical conditions actually cause or amplify those problems?

## Guardrails

Preserve:
- existing raw/canonical evidence;
- evidence status semantics;
- Narrative v2 release threshold and Judge evidence-fidelity gates;
- human authorization requirement for final third Writer/Judge pass;
- bounded provider/cost controls;
- 250-page representative On-Page ceiling;
- 20 priority-URL ceiling;
- immutable historical audit artifacts;
- current Viewer v2.2.0 navigation unless a later design decision explicitly changes it.

Do not:
- invent conversion/revenue outcomes;
- convert PARTIAL evidence to confirmed absence/presence;
- hide real technical risk;
- recollect providers for CF-01;
- run a new production audit for design work;
- mutate production configuration;
- make broad multi-file edits before the influence map is approved.

## Deferred CI debt

Before substantial v4.2 implementation, verify current GitHub Actions status.

Two previously diagnosed CI items may still be open:

1. `services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-representative-evidence.test.js`
   - production content-parsing default is 50;
   - regression test still assumed 20 implicitly;
   - intended repair: make `contentParsingPageLimit: 20` explicit in the test scenario, not revert production.

2. `services/worker/src/report/render-report-v2-conversion.test.js`
   - frozen full-render hashes became stale after the intentional branded report-theme change;
   - intended repair: verify intentional renderer output, then re-freeze hashes.

Do not silently mix a failing CI baseline with broad v4.2 implementation.

## Workflow

Follow `WORKFLOW_INSTRUCTIONS.md` exactly once coding begins:
- one governed source-file unit at a time;
- exact file path;
- exact current line numbers/anchors;
- complete replacement block;
- multiple edits presented bottom-up;
- one consolidated verification command block;
- do not advance until verification is confirmed;
- maximum three failed attempts on one observable defect before deeper diagnosis.

## First action in the new chat

1. Read the authoritative context files listed at the top.
2. Verify local Git state and current GitHub CI state.
3. Inspect the current source architecture needed for CF-01.
4. Produce the no-code Conversion Influence Map.
5. Stop for review before proposing application edits.
