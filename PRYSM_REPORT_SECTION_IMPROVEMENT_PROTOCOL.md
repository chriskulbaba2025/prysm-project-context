# PRYSM Report Section Improvement Protocol (RSIP)

Version: 1.2.0
Status: ACTIVE
Date: 2026-09-07

## Purpose

Provide one governed, repeatable process for improving the PRYSM report section by section without losing evidence integrity, reopening completed work casually, or relying on chat memory.

## Governing outcome

Each conceptual report page must be improved against a frozen client-facing contract, verified deterministically, reviewed on the actual rendered report, scored, and either repaired again or locked as PASS before the next page becomes active.

The repository, not the chat, owns current section/state continuity.

Report-wide navigation is additionally governed by:

`PRYSM_REPORT_INFORMATION_ARCHITECTURE_CONTRACT_2026-09-07.md`

The primary client report contains exactly 6 peer decision-oriented destinations plus one visibly subordinate `Supporting Detail` destination. Technical/evidence pages remain governed supporting detail and do not compete in the primary menu.

## Single-active-section rule

Only one report section may be `ACTIVE` at a time.

A section moves through this lifecycle:

`BASELINE_AUDIT -> CONTRACT -> REPAIR_PLAN -> BUILD -> DETERMINISTIC_AUDIT -> REAL_REPORT_RENDER -> HUMAN_REVIEW -> PASS_LOCKED`

## Required artifacts per section

Each section uses:

`proof/report-sections/S##-<slug>/`

with these artifacts when their stage is reached:

- `S##_CONTRACT.md`
- `S##_BASELINE_AUDIT.md`
- `S##_REPAIR_PLAN.md`
- `S##_DETERMINISTIC_PROOF.md`
- `S##_HUMAN_REVIEW.md`
- `S##_CLOSURE.md`

Do not create later-stage artifacts as if complete before their evidence exists.

## Stage gates

### 1. BASELINE_AUDIT

Use the actual current rendered report from the governed candidate/evidence boundary.

Record:
- rendered artifact identity/path/hash when available;
- current headings/order;
- current client-facing claims;
- current priorities/actions;
- positives;
- uncertainty/limitations;
- machine/internal audit language;
- duplicate material;
- current score against the universal scorecard.

No application edit is allowed during baseline capture.

### 2. CONTRACT

Define and freeze:
- client question the section must answer;
- client decision/outcome;
- required content/hierarchy;
- prohibited content/language;
- evidence-integrity rules;
- required links/pointers to supporting detail;
- deterministic acceptance criteria;
- human acceptance criteria.

Once BUILD begins, the contract is frozen. A material contract change requires explicit Chris approval and versioned evidence.

Every section contract must also comply with the approved report-wide information architecture contract. Section-level decisions may not silently add, remove, rename, or promote primary navigation entries.

### 3. REPAIR_PLAN

Map every accepted baseline defect to:

`observed problem -> root cause -> required change -> exact source boundary -> proof`

No code change before the plan identifies the complete bounded source/test seam from exact current local source.

When a section repair affects navigation, the repair plan must explicitly map the change to `PRYSM_REPORT_INFORMATION_ARCHITECTURE_CONTRACT_2026-09-07.md` and include navigation regression proof.

### 4. BUILD

Change only the approved bounded seam.

Preserve the active dirty P1 worktree and all existing PRYSM no-reset/no-clean/no-discard rules.

### 5. DETERMINISTIC_AUDIT

Prove:
- required content exists;
- prohibited content is absent;
- evidence uncertainty is preserved;
- governed rank/order is preserved;
- Client Truth is not upgraded or reinterpreted;
- relevant regressions pass;
- required whole-app/closure gates pass when the change boundary requires them.

For any report-wide navigation change, also prove:
- exactly 6 peer client destinations;
- exact approved order;
- exact approved client-facing labels;
- exactly one subordinate `Supporting Detail` destination;
- zero supporting-detail pages exposed as peer primary items;
- all supporting-detail content remains reachable;
- viewer switching and print/save behaviour remain functional.

A test suite must prove the intended pre-change defect where practical; tests that simply accept the new output are insufficient.

### 6. REAL_REPORT_RENDER

Regenerate the actual review report from already-governed persisted/canonical artifacts with no live provider/model calls unless separately authorized.

The rendered client artifact, not source code alone, is the review object.

### 7. HUMAN_REVIEW

Review the actual rendered section for client comprehension, usefulness, scanability, language, and material uncertainty.

The reviewer must not substitute code/test inspection for client outcome review.

For primary client navigation, human review must confirm that the 6-peer-menu structure is immediately understandable and that one subordinate Supporting Detail destination clearly contains deeper technical/evidence material.

### 8. PASS_LOCKED

A section may become `PASS_LOCKED` only when:
- universal score >= 95/100;
- every required deterministic gate passes;
- zero hard-gate failures remain;
- human review passes;
- `S##_CLOSURE.md` records the result;
- registry and machine-readable state are updated.

Only then may the next section become ACTIVE.

## Universal 100-point scorecard

| Dimension | Weight |
|---|---:|
| Client decision clarity | 25 |
| Actionability | 20 |
| Plain-language readability | 15 |
| Evidence integrity | 20 |
| Information hierarchy / scanability | 10 |
| Cross-report consistency | 10 |
| **Total** | **100** |

PASS threshold: **95/100 minimum + zero hard-gate failures**.

## Hard-gate failures

Any one of these is an automatic FAIL regardless of numeric score:

- unsupported certainty;
- `PARTIAL`, `NOT_ASSESSED`, unavailable, failed, blocked, or not-detected evidence upgraded into a confirmed website defect beyond governed scope;
- contradiction with another governed report section/Client Truth;
- client action unsupported by evidence;
- internal PRYSM mechanics presented as the client conclusion when the section contract prohibits them;
- material machine/technical language that prevents the intended non-technical client understanding;
- priority/rank/business reason materially disagrees with the governed action hierarchy;
- the section fails to answer its required client question;
- a supporting-detail page appears as an equal-weight peer primary navigation item;
- the peer client menu count/order/labels or subordinate Supporting Detail structure disagree with the approved information-architecture contract.

## Execution order

### Primary client lane — first

`S01 -> S02 -> S03 -> S05 -> S06 -> S07`

These are the peer client destinations and must be completed before the supporting-detail lane.

### Supporting-detail lane — second

`S12 -> S13 -> S04 -> S08 -> S09 -> S10 -> S11 -> S14 -> S15 -> S16`

These sections remain governed and measurable even though they are subordinate in client navigation.

## Reopen rule

A `PASS_LOCKED` section may be reopened only when new direct evidence establishes one of:
- a regression changed the locked section;
- another section exposes a material cross-report contradiction;
- a newly approved report-wide contract requires migration;
- the locked closure proof is shown to be invalid.

Stylistic preference alone does not reopen a locked section.

A reopen must be versioned and recorded in the registry/state before edits begin.

## State files

Permanent control files:
- `PRYSM_REPORT_SECTION_REGISTRY.md`
- `PRYSM_REPORT_SECTION_STATE.json`
- `PRYSM_REPORT_INFORMATION_ARCHITECTURE_CONTRACT_2026-09-07.md`
- `CURRENT_STATE.md`

Every substantive section-stage transition must update the registry/state and, when it changes the project’s exact next action or checkpoint, `CURRENT_STATE.md`.

## Execution boundaries

RSIP does not authorize:
- destructive Git operations;
- production mutation;
- provider/model calls;
- deployment;
- merge;
- unrelated scoring/evidence/lifecycle changes;
- bypassing active P1 Client Truth/evidence-integrity governance.

Existing PRYSM governing constraints and explicit current authorization boundaries remain controlling.
