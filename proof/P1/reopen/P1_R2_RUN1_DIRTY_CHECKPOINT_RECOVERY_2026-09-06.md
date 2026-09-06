# P1 R2 Run 1 Dirty Checkpoint Recovery

Date: 2026-09-06
Decision: APPROVED
Status: CONTROL-PLANE RECOVERY ONLY

## Purpose

Recover the exact attributed dirty application checkpoint left by Windows R2 Run 1 after Codex exited successfully but before the controller reconciled the `CONTINUE -> Builder` result.

This is not a new product repair authorization, does not broaden the R2 source/test boundary, and does not consume or reset repair accounting.

## Binding transaction facts

- P: `P1`
- R2 run: `1`
- Journal status: `CODEX_EXITED_UNRECONCILED`
- Codex exit code: `0`
- Model: `gpt-5.6-terra`
- Repair attempt: `1`
- Stable root: `P1-CROSS-REPORT-PROJECTION-RECONCILIATION`
- Pre/post application SHA: `8fa9ea9db76e2db5e8fa11ebc6a0a7fd56eb6e1c`
- Journal pre/post governance SHA: `6a65330b0346dd572a59eae06402128533d7bcd2`
- Result failure class: `PROOF_SETUP_FAILURE`
- Result route: `CONTINUE -> Builder`
- Material defects: `0`

## Exact attributed dirty application paths

Only these paths are present in the recovered dirty checkpoint:

- `services/worker/src/report/foundation-readiness.js`
- `services/worker/src/report/render-report-v2-conversion.test.js`
- `services/worker/src/report/render-report-v2.js`
- `services/worker/src/report/report-detail-sections.js`
- `services/worker/src/report/v2-pillars.js`

No staged files and no untracked files were present in the diagnostic.

## Exact dirty diff fingerprint

The uploaded diagnostic captured `git diff --no-ext-diff --unified=3` for the application checkpoint.

Normalized line-ending SHA-256:

`6d1db38a328364c6388abe7af63929a2fb2d75340f1ca102daaf9cb055f7ad4f`

Normalization for verification:

1. convert CRLF and CR to LF;
2. remove trailing LF characters;
3. append exactly one LF;
4. hash UTF-8 bytes without BOM using SHA-256.

Any mismatch is a stop condition. Do not auto-adopt a different dirty tree.

## Recovery authority

The already-authorized R2 Builder transaction may continue from this exact dirty checkpoint at repair attempt `1` / Terra without invoking a new clean-entry gate first, because the transaction was already admitted by the deterministic Builder gate before Run 1 and the journal + exact dirty fingerprint preserve attribution.

The recovery controller must fail closed unless all binding transaction facts, exact application lineage, exact dirty fingerprint, and authorized path boundaries pass.

The recovery may continue only the existing three R2 client-visible families:

1. CTA / path coherence;
2. trust evidence attribution;
3. fail-closed performance/readiness reconciliation.

## Required correction during recovery

The current Run 1 work is evidence, not an accepted candidate.

Before freezing or committing the recovered work, Builder must specifically review the current performance/readiness change so that:

- limited-evidence semantics are scoped to the causally relevant performance/readiness condition and do not broadly relabel unrelated pillars merely because any capability is unavailable;
- client-visible copy explains the limitation in ordinary human language rather than exposing internal status tokens such as `LIMITED_EVIDENCE`, `PARTIAL`, `AVAILABLE`, or `UNKNOWN`;
- CTA and trust changes are preserved only if the focused evidence still supports them;
- CR-40 / CR-43 expected hashes are updated only after intentional review confirms the changed rendered output is the desired client-facing output;
- new generated proof is versioned under the already-authorized `proof/P1/reopen/*` surface;
- pre-existing reopened proof remains immutable.

## Recovery checkpoint requirement

The recovery controller may relaunch Builder turns while the same attributed transaction remains inside the exact R2 boundary. A normal Codex invocation ending is not a workflow boundary.

Before returning control to the standard R2 continuous controller, the recovery must establish a durable clean/pushed checkpoint for both repositories or reach the existing `READY_FOR_BRAD` protected boundary.

A process/harness recovery failure does not consume R2 product repair attempt `1`.

## Prohibited recovery actions

Do not use destructive cleanup to satisfy the controller:

- no `git reset --hard`;
- no `git clean`;
- no checkout-overwrite of the recovered work;
- no force push;
- no repair-index reset;
- no new root rename without new direct evidence;
- no product scope expansion.
