# PRYSM Repair Boundary Protocol

**Version:** 1.0.0  
**Status:** Governing project instruction  
**Purpose:** Prevent premature file editing, repeated user edits, local fixes that miss the full problem, and implementation drift across PRYSM work packages.

## 1. Governing Rule

**No application source file may be requested for editing, modified, or replaced until the complete repair boundary has been mapped and the implementation plan is coherent.**

The assistant must solve the design problem before starting the file-editing problem.

A proven local defect is not, by itself, permission to begin editing the first file in its call path.

## 2. Mandatory Pre-Edit Gate

Before requesting the first application source file from the user, all of the following must be complete:

1. Restate the actual user outcome being protected, not merely the immediate error.
2. Verify the exact executing runtime/call path relevant to that outcome.
3. Map the full failure or improvement boundary from upstream inputs through downstream consumers.
4. Identify all application source files that are reasonably expected to require change.
5. Identify all tests, contracts, fixtures, or verification boundaries that must prove the repair.
6. Identify material downstream reactions, including evidence coverage, scoring eligibility, lifecycle behavior, storage behavior, report conclusions, cost, retry behavior, and performance where relevant.
7. Distinguish required changes from explicitly out-of-scope systems.
8. Define the smallest coherent production-grade repair that solves the whole mapped problem.
9. Check whether the user's latest requirements materially broaden or change that repair before implementation starts.
10. State the complete implementation sequence before asking the user to open or paste the first file.

If any item is unresolved and could materially change the edit, **do not begin file editing**.

## 3. Whole-Problem Rule

When the user expands the objective during diagnosis or design, incorporate the new requirement into the repair boundary before implementation.

Do not continue with an earlier narrow plan merely because a smaller defect was already proven.

Examples:

- A timeout defect that exposes inadequate evidence depth must be designed together with the required acquisition behavior before editing timeout code.
- A crawl-limit defect that affects enterprise-scale sites must be evaluated against representative sampling, programmatic-page detection, conversion evidence, trust/E-E-A-T signals, and downstream report use before choosing the repair.

## 4. File-Set Rule

Before the first edit, identify the expected file set for the coherent repair.

This does **not** authorize batch editing across files. The existing manual VS Code workflow remains active: one verified source-file unit at a time.

The purpose of identifying the full file set first is to prevent this failure mode:

`edit file A → discover file B is needed → re-edit file A → discover test/contract C → re-edit again`

The intended sequence is:

`map whole repair → identify file set/tests → user approves direction → edit file A once → verify → edit file B once → verify → complete integrated regression verification`

## 5. No Premature File Requests

Do not ask the user to:

- open a source file;
- paste a source file;
- make a find/replace;
- change a timeout;
- run an implementation command;

until the Mandatory Pre-Edit Gate passes.

Diagnostic read-only commands are permitted when they are necessary to complete the gate and do not mutate the application or paid/provider state.

## 6. One-Pass Edit Quality

For each source-file unit, inspect the complete verified current file and apply every already-approved change that belongs to that file in one coherent replacement whenever safely possible.

Do not knowingly stage multiple edits to the same file merely to simplify assistant reasoning.

The user should not have to manage the assistant's decomposition by repeatedly reopening and repasting the same source file.

## 7. New Evidence During Implementation

If genuinely new evidence discovered during implementation materially changes the repair boundary:

1. stop further edits;
2. explain what changed;
3. remap the affected repair boundary;
4. update the expected file/test set;
5. only then resume the governed file workflow.

Do not silently expand scope while editing.

## 8. Enterprise-Product Standard

When the repair affects evidence acquisition, crawl depth, competitor intelligence, search visibility, conversion analysis, trust, or E-E-A-T, optimize for **defensible decision quality**, not merely minimum execution time or minimum provider spend.

Cost controls and timeouts are safety boundaries. They must not arbitrarily prevent acquisition of the evidence required for an enterprise-grade conversion-readiness decision.

For large sites, prefer representative, structure-aware evidence acquisition over either exhaustive crawling or arbitrary fixed-page truncation. Where programmatic SEO or template-scale content exists, the design must preserve enough evidence to assess material conversion/search/trust patterns without requiring every duplicate or near-duplicate URL to be deeply processed.

## 9. Completion Test for the Gate

The pre-edit gate is PASS only when the assistant can answer, before touching code:

- What exact user outcome are we fixing?
- What is the verified root cause or design deficiency?
- What is the full executing boundary?
- Which files are expected to change?
- Which files are explicitly not expected to change?
- Which tests prove the direct repair?
- Which tests prove downstream safety?
- What cost/performance/retry implications exist?
- What is the implementation order?
- Why should the user not need to revisit the same file because of something already knowable now?

If those answers are not available, continue diagnosis/design instead of implementation.

## 10. Relationship to Other PRYSM Rules

This protocol supplements, and does not replace:

- `GITHUB_PROJECT_MEMORY_PROTOCOL.md`;
- the manual VS Code source-file workflow;
- the three-attempt diagnostic reset;
- the durable dependency-impact ledger requirement;
- all production/provider/persistence approval boundaries.

Where there is tension, choose the sequence that preserves both requirements: **design the complete repair first, then implement it through the governed one-source-file-at-a-time workflow.**
