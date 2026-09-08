# S01 Closure-Rerun Test Migration Addendum

Section: S01 — Executive Scorecard
Date: 2026-09-07
Stage: DETERMINISTIC_AUDIT
Status: APPROVED — SECOND TEST-ONLY BOUNDARY EXPANSION

## Evidence

Uploaded proof: `PRYSM-S01-CLOSURE-RERUN-PROOF.txt`.

The first stale application presentation assertion was migrated within its authorized test-only boundary:

- changed file: `src/application/narrative-v2-production-path.test.js`;
- change: old `/A\. Conversion Readiness/` assertion replaced with `/Executive Scorecard/`;
- targeted test file: `10/10 PASS`, `0 FAIL`, exit `0`.

The closure rerun then established:

- worker regression families: `993/993 PASS`, `0 FAIL`;
- application production-path tests: `82/82 PASS`, `0 FAIL`;
- Narrative v2 tests: `114/114 PASS`, `0 FAIL`;
- schema and contract tests: `14/14 PASS`, `0 FAIL`;
- artifact tests: `106/106 PASS`, `0 FAIL`;
- lifecycle tests: `57/57 PASS`, `0 FAIL`;
- PRYSM Full-System Acceptance: `87 PASS / 0 FAIL`;
- zero live provider calls in the governed acceptance path;
- `git diff --check`: exit `0` with LF/CRLF warnings only.

`npm run verify:prysm-closure` still returned exit `1` because the exact assembled Whole-App gate reached one additional stale viewer-version assertion in the replay CLI compatibility tests.

Exact failing file:

- `scripts/replay-report-cli.test.js`

Exact failing case:

- `T4-REPLAY-CLI-03: default CLI validates and renders a production-composed current artifact set`

Observed failure:

- replay CLI compatibility boundary: `4 tests`, `3 PASS`, `1 FAIL`;
- stale assertion expects `/viewer 2\.2\.0/`;
- actual governed output is `viewer 2.3.0`;
- viewer `2.3.0` is the approved S01 presentation version;
- the replay itself otherwise reports `1/1 PASS` and produces the current report artifact.

No product-code failure is established by this evidence. This is another presentation-version test migration required by the already-approved viewer `2.2.0 -> 2.3.0` change.

## Decision

Authorize one additional test-only seam:

- `scripts/replay-report-cli.test.js`

Permitted change:

- update only the stale current-viewer version assertion(s) required to expect viewer `2.3.0` instead of `2.2.0`;
- preserve all historical-compatibility and fail-closed assertions;
- do not weaken or remove unrelated assertions;
- do not change replay production code;
- do not change renderer or any other production code.

No other file is authorized by this addendum.

## Required proof after migration

1. run `node --test scripts/replay-report-cli.test.js` and require PASS;
2. run `npm run verify:prysm-closure` and require PASS;
3. run `git diff --check` and require exit `0`;
4. verify this repair adds no new modified path other than `scripts/replay-report-cli.test.js`;
5. preserve the intentional dirty P1/S01 worktree;
6. no provider/model calls, production mutation, push, merge, deploy, reset, clean, checkout-overwrite, or discard.

## Execution behavior for this bounded rerun

Codex may run autonomously through all required gates without pausing for intermediate approval. It should keep an append-only progress proof in Downloads, recording each completed gate immediately so a long run can be resumed from the last proven checkpoint if interrupted. Accuracy and fail-closed behavior take priority over speed. A failing gate must be recorded exactly and must stop any downstream state advancement.

## Next action

Migrate only the stale viewer-version assertion in `scripts/replay-report-cli.test.js`, run the targeted replay CLI test plus full closure gate, capture one uploadable proof TXT with incremental checkpoints, and stop. Do not regenerate the TBK report until closure passes.
