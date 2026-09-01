# PRYSM Repair Boundary Protocol

**Version:** 1.1.0  
**Status:** Governing project instruction  
**Purpose:** Prevent premature file editing, repeated user edits, local fixes that miss the full problem, implementation drift across PRYSM work packages, and ambiguity during manual VS Code edits.

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

This does **not** authorize uncontrolled batch editing across files. The manual VS Code workflow remains active, but coherent source units may be grouped when the complete boundary is already known and a single integrated verification is safer and faster.

The purpose of identifying the full file set first is to prevent this failure mode:

`edit file A → discover file B is needed → re-edit file A → discover test/contract C → re-edit again`

The intended sequence is:

`map whole repair → identify file set/tests → user approves direction → apply each known file change once → verify the coherent unit → complete integrated regression verification`

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

## 7. Manual Edit Instruction Format

When the user is manually editing an existing source file in VS Code, instructions must be mechanical and unambiguous.

For every edit to an existing file, the assistant must provide:

1. the exact repository-relative file path;
2. the change number when more than one edit belongs to the file;
3. the exact starting line number from the verified current file;
4. the exact starting anchor text;
5. the exact ending line number from the verified current file;
6. the exact ending anchor text;
7. a clear instruction stating whether to replace, insert before, insert after, or delete;
8. the complete replacement or inserted code required for that change.

**Line numbers must never be the only locator.** Anchor text is required because prior edits may shift later line numbers.

When a file has multiple edits whose line numbers would shift as changes are applied, the assistant should instruct the user to work **from the bottom of the file upward**. The assistant should present the changes in that bottom-up order unless there is a concrete technical reason not to.

For a bottom-up edit set:

- identify the original line ranges before any edits are made;
- present the highest line-number change first;
- continue toward the top of the file;
- use both line ranges and start/end anchors for every change;
- do not require the user to recalculate shifted line numbers.

For a single-line change, explicitly say that only that line is replaced.

For a new file, provide the complete path and complete file contents; no line-range instructions are required.

After all edits in the coherent unit are saved, provide one consolidated syntax/test/diff/commit block whenever practical. Do not split routine verification into unnecessary micro-commands unless a failure requires diagnosis.

## 8. New Evidence During Implementation

If genuinely new evidence discovered during implementation materially changes the repair boundary:

1. stop further edits;
2. explain what changed;
3. remap the affected repair boundary;
4. update the expected file/test set;
5. only then resume the governed file workflow.

Do not silently expand scope while editing.

## 9. Enterprise-Product Standard

When the repair affects evidence acquisition, crawl depth, competitor intelligence, search visibility, conversion analysis, trust, or E-E-A-T, optimize for **defensible decision quality**, not merely minimum execution time or minimum provider spend.

Cost controls and timeouts are safety boundaries. They must not arbitrarily prevent acquisition of the evidence required for an enterprise-grade conversion-readiness decision.

For large sites, prefer representative, structure-aware evidence acquisition over either exhaustive crawling or arbitrary fixed-page truncation. Where programmatic SEO or template-scale content exists, the design must preserve enough evidence to assess material conversion/search/trust patterns without requiring every duplicate or near-duplicate URL to be deeply processed.

## 10. Completion Test for the Gate

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

## 11. Relationship to Other PRYSM Rules

This protocol supplements, and does not replace:

- `GITHUB_PROJECT_MEMORY_PROTOCOL.md`;
- the manual VS Code source-file workflow;
- the three-attempt diagnostic reset;
- the durable dependency-impact ledger requirement;
- all production/provider/persistence approval boundaries.

Where there is tension, choose the sequence that preserves both requirements: **design the complete repair first, then implement it through clear, one-pass, mechanically locatable manual edits with integrated verification.**

---

## 12. Whole-App Branch Coverage Pre-Edit Amendment

For application-changing production-closure or post-deployment repair work, the Mandatory Pre-Edit Gate now also requires `PRYSM_WHOLE_APP_BRANCH_COVERAGE_PROTOCOL.md` and `PRYSM_WHOLE_APP_BRANCH_MATRIX.md`.

Before the first application edit, additionally:

1. identify every materially distinct current production branch directly changed by the repair;
2. identify materially adjacent alternate producers/paths that emit into the same changed contract or consumer;
3. map those branches to stable matrix IDs;
4. identify which existing deterministic Whole-App scenarios exercise each branch;
5. mark any required branch without coverage as a verification gap that must be repaired in the same coherent package;
6. define the contract assertions required at each producer -> persistence -> reload -> consumer handoff;
7. state whether the repair creates, removes, or splits a branch and therefore requires a matrix update.

A pre-edit plan that says only “run the Whole-App gate” is insufficient when the materially distinct branch inventory has not been checked.

The intended sequence for governed application work is now:

`diagnose -> map full producer/contract/consumer boundary -> reconcile affected branch IDs -> define direct + branch regressions -> edit coherent unit -> targeted proof -> coherent commit -> exact-SHA branch-matrix Whole-App proof -> full verification -> independent audit`

Do not enumerate every conditional. The required scope is every branch whose omission could materially change contract acceptance, persisted state, lifecycle, scoring/decision semantics, Narrative sequence, recovery/publication, or client-facing output.
