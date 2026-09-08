# S02 Contract — Priority Fixes

Section: `S02 — Priority Fixes`
RSIP stage: `CONTRACT`
Status: **APPROVED — FROZEN FOR BUILD**
Approved by: Chris
Date: 2026-09-07
Protocol: `PRYSM_REPORT_SECTION_IMPROVEMENT_PROTOCOL.md` v1.2.0
Report-wide IA contract: `PRYSM_REPORT_INFORMATION_ARCHITECTURE_CONTRACT_2026-09-07.md` v1.1.0
Baseline: `proof/report-sections/S02-priority-fixes/S02_BASELINE_AUDIT.md`

## Client question

**What should I fix first, why does it matter, and how will I know it improved?**

## Required client outcome

A non-technical client scanning Priority Fixes for approximately 10–20 seconds must be able to identify:

1. the single governed priority order;
2. what each priority means in normal business language;
3. why each priority matters to the customer or conversion experience;
4. what needs to change;
5. where the change applies without reading a raw URL inventory;
6. how to confirm the change worked;
7. any material uncertainty that limits how strongly the finding should be interpreted.

The page must not require the client to reconcile multiple action frameworks.

## Governing page model

S02 must render **one authoritative ranked client action sequence** derived from the governed action hierarchy / Client Truth boundary.

The primary page must not present Priority Findings, Foundational Readiness, Client Action Plan, Root Cause, and a second Action Plan as independent competing decision structures.

All client-facing action guidance must resolve into the same ranked sequence.

## Required hierarchy

Render in this conceptual order:

1. **What should you fix first?**
2. **Ranked priority actions** — up to the supported governed priority count, currently five for the locked TBK report.
3. **What to check after the changes** — concise confirmation guidance tied to the same priorities, not a new list.
4. **Where to find supporting detail** — link/pointer to technical evidence, complete URL inventories, foundation checks, and implementation mechanics.

No other section may visually compete with the ranked sequence as a second answer to “what should I do first?”

## Required fields for every ranked priority

Each priority must contain these client-facing fields:

### 1. What needs attention
A short plain-language finding title.

### 2. Why it matters
One concise statement connecting the issue to customer understanding, friction, trust, discoverability, or conversion readiness without overstating measured outcomes.

### 3. What to change
A clear client action that describes the required improvement without unnecessary developer implementation detail.

### 4. Where it applies
A short human-readable scope statement such as:

- Homepage
- Assessed service pages
- Some assessed pages
- Pages where the issue was detected

Do not display long raw URL inventories in the primary S02 action sequence. Complete affected-URL evidence belongs in Supporting Detail.

### 5. How to confirm it improved
A short result-oriented check a client can understand.

Detailed crawling, header inspection, structured-data testing, performance-tool settings, and other implementation mechanics belong in Supporting Detail unless the technical term is necessary for the client decision.

### 6. Material uncertainty
Show only when the governed evidence state requires it.

Uncertainty must be stated in plain language and must remain attached to the affected priority rather than being hidden in a generic footer.

## Governed priority-order rule

Priority order must come only from the governed action hierarchy / Client Truth boundary.

The S02 renderer must not create another ranking based on:

- raw severity;
- technical foundation category;
- evidence confidence class;
- effort class;
- finding ID;
- source-section order;
- implementation convenience.

If a foundational issue materially belongs in the governed action order, it must appear in that same ranked sequence.

If it does not belong in the governed action order, it must not be labeled `First Things First`, `Do Now`, or otherwise presented as a competing top-priority list.

## Foundational Readiness rule

The current large `First Things First — Foundational Readiness` matrix must not remain as an equal-weight client decision block on S02.

Foundation evidence remains governed and must remain reachable through Supporting Detail.

S02 may display a short contextual note only when a foundation materially affects execution of a ranked priority. Such a note must not create a second ranking.

PASS / FINDING / UNAVAILABLE foundation matrices, provider limitations, robots/sitemap collection mechanics, NAP checks, header inventories, canonical diagnostics, and similar evidence-level detail belong in Supporting Detail.

## Plain-language rule

S02 is the client action page, not the implementation specification.

Use normal business language first. Technical wording is allowed only when removing it would make the action materially less accurate.

Required translation direction for the locked TBK priorities:

| Current technical/system wording | Required client-language direction |
|---|---|
| `Mobile largest contentful paint is slow` | **Main content takes too long to appear on mobile.** |
| `Buyer-question content was not detected in the available partial assessment` | **Buyer-question content was not found on the pages we could assess.** |
| `Meta descriptions were not detected on some assessed pages` | **Some assessed pages do not have a search-result description.** |
| `Heading structure is inconsistent` | **Page headings are inconsistent.** |
| `Security headers are incomplete` | **Some basic browser security protections are not configured on the assessed response.** |

Exact final wording may vary only if it remains equally understandable and does not exceed the governed evidence.

## Prohibited primary-page mechanics

Do not expose these as ordinary client-facing S02 fields:

- rule IDs such as `VAN-PERF-001`;
- internal action classes such as `HIGH_CONVERSION` or `OPTIMIZATION`;
- raw evidence-confidence classifications;
- `deterministic evidence confidence` wording;
- raw effort codes such as `M` / `L`;
- long raw affected-URL lists;
- crawl-inventory dumps;
- implementation-only labels such as `hosting layer` when a client-level phrase is sufficient;
- `render-blocking` as the main client action wording;
- technical metric acronyms such as `LCP` when plain wording is sufficient;
- repeated `re-crawl` language as the visible client conclusion;
- internal PRYSM reasoning about why a rank was assigned.

These may remain in governed Supporting Detail where needed for implementation or audit traceability.

## Evidence-integrity rule

S02 must never upgrade evidence state.

Specifically:

- `not detected` does not become `missing`, `absent`, or `does not exist` unless complete governed evidence establishes absence;
- `PARTIAL` does not become complete/site-wide certainty;
- `NOT_ASSESSED`, unavailable, blocked, failed, or not-collected evidence does not become a website defect;
- unassessed pages remain unknown;
- unmeasured conversion outcomes must not be presented as measured gains or losses;
- expected effects must be stated as intended or possible outcomes, not guaranteed results;
- wording must remain at or below the Client Truth Contract.

Any violation is a hard-gate failure regardless of score.

## Visual-density / scanability rule

The primary S02 action sequence must not depend on a dense seven-column table.

The presentation must give each ranked priority enough horizontal or vertical space that:

- the finding title is immediately readable;
- `why it matters` and `what to change` are not compressed into narrow text columns;
- long URLs do not widen or crowd the layout;
- internal classification fields do not compete with the action;
- the complete priority can be understood without reading across a large matrix.

The contract governs the outcome, not a specific component implementation. Cards, stacked rows, or another layout may be used only if they preserve the single ranked sequence and improve scanability.

## Duplication rule

Every client action appears once in the authoritative ranked sequence.

Do not repeat the same five actions under separate visible frameworks such as:

- Priority Findings;
- Do Now / Do Next;
- Root Cause priorities;
- later Action Plan;
- Measure list.

Verification guidance may be summarized after the sequence only when it clearly points back to the same priorities and does not restate the recommendations as a new action list.

## Supporting Detail rule

S02 must preserve access to deeper evidence without reproducing it on the main client page.

Supporting Detail should retain, where governed and available:

- rule IDs;
- exact affected URLs;
- complete foundation matrix;
- evidence states and collection limitations;
- raw confidence/classification fields needed for audit traceability;
- detailed implementation instructions;
- exact technical verification procedures;
- performance metrics;
- technical SEO/security diagnostics.

Moving material to Supporting Detail is presentation-only and must not delete or weaken governed evidence.

## Cross-report consistency rule

S02 must remain consistent with locked S01.

For the locked TBK report this means at minimum:

1. mobile main-content loading remains the first governed priority;
2. buyer-question content remains the second priority and preserves assessed-scope uncertainty;
3. search-result descriptions remain the third priority;
4. S02 may add implementation-useful detail, but may not reinterpret or contradict S01;
5. S02 must not create a new `first` priority through foundation labeling or a secondary action framework.

Any material contradiction with S01 or Client Truth is a hard-gate failure.

## Report-wide navigation dependency

S02 remains primary client destination **02 of 06**.

Peer client navigation must remain exactly:

1. Executive Scorecard
2. Priority Fixes
3. Conversion Journey
4. Content Opportunities
5. Competitor Comparison
6. Trust & Credibility

One visibly subordinate destination remains:

`Supporting Detail`

S02 work must not reopen or alter this approved navigation contract unless separately authorized through the RSIP reopen/versioning rule.

## Universal RSIP scorecard

| Dimension | Weight |
|---|---:|
| Client decision clarity | 25 |
| Actionability | 20 |
| Plain-language readability | 15 |
| Evidence integrity | 20 |
| Information hierarchy / scanability | 10 |
| Cross-report consistency | 10 |
| **Total** | **100** |

PASS requires `>=95/100`, zero hard-gate failures, deterministic PASS, and human-review PASS.

## Deterministic acceptance criteria

The eventual S02 deterministic proof must establish at minimum:

1. exactly one authoritative ranked client action sequence is rendered;
2. governed rank/order is unchanged;
3. no competing `First Things First`, `Do Now`, `Do Next`, or second action-plan ranking remains;
4. every rendered priority contains `What needs attention`, `Why it matters`, `What to change`, `Where it applies`, and `How to confirm it improved`;
5. material uncertainty is attached to the affected priority when required;
6. buyer-question uncertainty remains bounded to assessed scope;
7. unavailable/not-assessed evidence is not upgraded into a defect;
8. unmeasured conversion outcomes are not stated as measured outcomes;
9. rule IDs and internal action classes are absent from the primary S02 client sequence;
10. raw evidence-confidence mechanics are absent from the primary S02 client sequence;
11. raw effort codes are absent from the primary S02 client sequence;
12. long raw URL inventories are absent from the primary S02 client sequence;
13. foundation matrices are removed from the equal-weight primary S02 decision layer while remaining reachable in Supporting Detail;
14. implementation-only jargon is translated where plain client wording is sufficient;
15. the primary S02 layout no longer depends on the current dense seven-column action table;
16. duplicate visible action frameworks are removed;
17. technical/evidence traceability remains available through Supporting Detail;
18. S02 top-three priorities remain consistent with locked S01;
19. approved six-item peer navigation plus one subordinate Supporting Detail destination remains unchanged;
20. no canonical evidence, scoring, lifecycle, provider/model, or production semantics change as part of the presentation repair;
21. existing relevant cross-report/evidence-integrity regressions remain green;
22. no undefined/null/empty required client fields render.

## Human acceptance test

Using the actual repaired TBK Priority Fixes page, a non-technical reviewer must be able to answer within approximately 10–20 seconds:

1. What should be fixed first?
2. What should be fixed second and third?
3. Why does each priority matter?
4. What needs to change?
5. How will we know the change improved?
6. Is any priority uncertain because the assessment scope was incomplete?
7. Where can technical implementation/evidence detail be found?

Required human outcome:

- the governed rank is immediately obvious;
- one action framework only;
- no material machine-language leakage;
- no misleading certainty;
- no dense table or duplicated sections preventing quick comprehension;
- supporting evidence remains reachable.

## Approval and freeze

Chris explicitly approved this S02 contract on 2026-09-07 with `go`.

The contract is now frozen for BUILD. Any material contract change after this point requires explicit Chris approval and versioned evidence under RSIP.

## Contract boundary

Contract approval does **not** itself authorize application edits.

No BUILD work may begin until:

1. a bounded `S02_REPAIR_PLAN.md` maps every accepted defect to the exact current local source/test seam;
2. the intentional dirty P1/S01 worktree has been inspected and preserved;
3. the next application-edit boundary is explicitly authorized.

All existing no-reset/no-clean/no-discard/no-provider/no-production/no-push/no-merge/no-deploy constraints remain in force.