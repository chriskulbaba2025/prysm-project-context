# PRYSM Report Section Improvement Protocol (RSIP)

Version: 1.0.0
Status: ACTIVE
Date: 2026-09-07

## Purpose

Provide one governed, repeatable process for improving the PRYSM report section by section without losing evidence integrity, reopening completed work casually, or relying on chat memory.

## Governing outcome

Each conceptual report page must be improved against a frozen client-facing contract, verified deterministically, reviewed on the actual rendered report, scored, and either repaired again or locked as PASS before the next page becomes active.

The repository, not the chat, owns current section/state continuity.

## Single-active-section rule

Only one report section may be `ACTIVE` at a time.

A section moves through this lifecycle:

`BASELINE_AUDIT -> CONTRACT -> REPAIR_PLAN -> BUILD -> DETERMINISTIC_AUDIT -> REAL_REPORT_RENDER -> HUMAN_REVIEW -> PASS_LOCKED`

For S01, Chris supplied and approved the contract before the baseline was formally captured. That contract is authoritative; the next stage is therefore `BASELINE_AUDIT` before any new S01 code change.

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

### 3. REPAIR_PLAN

Map every accepted baseline defect to:

`observed problem -> root cause -> required change -> exact source boundary -> proof`

No code change before the plan identifies the complete bounded source/test seam from exact current local source.

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

A test suite must prove the intended pre-change defect where practical; tests that simply accept the new output are insufficient.

### 6. REAL_REPORT_RENDER

Regenerate the actual review report from already-governed persisted/canonical artifacts with no live provider/model calls unless separately authorized.

The rendered client artifact, not source code alone, is the review object.

### 7. HUMAN_REVIEW

Review the actual rendered section for client comprehension, usefulness, scanability, language, and material uncertainty.

The reviewer must not substitute code/test inspection for client outcome review.

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
- the section fails to answer its required client question.

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