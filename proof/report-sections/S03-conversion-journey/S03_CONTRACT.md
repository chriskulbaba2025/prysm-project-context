# S03 Contract — Conversion Journey

Date: 2026-09-07
Section: `S03 — Conversion Journey`
RSIP stage: `CONTRACT`
Status: **APPROVED — FROZEN FOR BUILD**
Approved by: Chris (`go`, 2026-09-07)

## Client question

**Can visitors move easily from interest to action?**

## Required client outcome

A non-technical client scanning S03 for approximately 10–20 seconds must be able to identify:

1. whether the assessed path to action is clear;
2. the main observed path in normal language;
3. what is working and should be preserved;
4. whether any material hesitation point was actually established;
5. any material limitation on how broadly the conclusion can be interpreted.

## Governing page model

S03 is a client journey page, not a technical path-verification report.

The page must lead with one direct answer and one visual explanation of the assessed path. It must not require the client to reconcile a diagram, a duplicative status table, and multiple empty-result sections.

## Required hierarchy

Render in this order:

1. kicker: `Conversion Journey`;
2. H2: `Can visitors move easily from interest to action?`;
3. prominent verdict: `The assessed path to action is clear.`;
4. one simplified journey visual;
5. concise `What is working` block;
6. one limitation note only when materially required.

## Journey visual rule

The primary visual must be larger and easier to scan than the current five-box technical diagram.

Use client-language stages derived from the existing assessed path. Do not introduce a new path, new conversion event, or unverified user behavior.

Technical validation wording such as browser-validation mechanics belongs in Supporting Detail unless necessary to preserve evidence meaning.

## Redundancy rule

Remove the primary-page `Important path status` table if it repeats the same journey/status already communicated by the verdict and journey visual.

Do not replace it with another duplicative summary surface.

## Empty-result rule

Do not devote equal-weight sections to absence of findings.

If no material hesitation point or conversion-path finding was established, communicate that once, concisely, within the client conclusion or `What is working` area.

Do not retain separate large sections whose only message is `none found`.

## Plain-language rule

Prefer phrases such as:
- `The assessed path to action is clear.`
- `Visitors on the pages we assessed had a visible next step.`
- `No material obstacle was established in the assessed path.`

Avoid primary-page wording dominated by:
- browser validation mechanics;
- assessed-page count chains;
- system-status terminology;
- repeated `conversion mechanism` or `interactable/unobstructed` mechanics when a simpler bounded client statement is sufficient.

## Evidence-integrity rule

S03 must never overstate the evidence.

Specifically:
- an assessed clear path must not become a site-wide claim;
- visible conversion actions must not become proof of completed enquiries or conversions;
- no material hesitation point found must not become proof that visitors never hesitate;
- partial path evidence must remain bounded;
- unmeasured conversion outcomes must not be presented as measured results.

Any violation is a hard-gate failure.

## Locked cross-report consistency

S03 must remain consistent with:
- S01 `PASS_LOCKED`;
- S02 `PASS_LOCKED`;
- the governed priority order, where mobile performance remains the first improvement priority despite the assessed conversion route being clear.

S03 must not create a new top priority or contradict the locked statement that the conversion route itself is a strength to preserve.

## Navigation dependency

S03 remains PRIMARY 03 with client-facing label `Conversion Journey`.

Peer navigation remains exactly:
1. Executive Scorecard
2. Priority Fixes
3. Conversion Journey
4. Content Opportunities
5. Competitor Comparison
6. Trust & Credibility

Supporting Detail remains subordinate.

## Deterministic acceptance criteria

The repaired S03 must establish at minimum:

1. one clear client question/title hierarchy;
2. one dominant bounded verdict;
3. one simplified journey visual;
4. no duplicative primary status table;
5. no separate equal-weight empty-result sections for hesitation/findings;
6. no unsupported site-wide or completed-conversion claim;
7. no contradiction with locked S01/S02;
8. approved navigation remains unchanged;
9. supporting technical evidence remains reachable;
10. no scoring, evidence, Client Truth, Writer/Judge, canonical, provider/model, or production semantics change.

## Human acceptance test

Within approximately 10–20 seconds, a non-technical reviewer must be able to answer:

1. Is the assessed path to action clear?
2. What does that path look like?
3. What is already working?
4. Was any material obstacle actually established?
5. What limitation applies to the conclusion?

## Approval and freeze

Chris approved the repair direction with `go` on 2026-09-07.

This contract is frozen for bounded repair planning and BUILD. Any material contract change requires explicit approval.
