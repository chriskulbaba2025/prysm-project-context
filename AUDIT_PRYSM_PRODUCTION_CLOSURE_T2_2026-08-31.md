# PRYSM T2 Independent Audit — FAIL

- Candidate: `repair/prysm-production-closure` @ `b0c936840c8a321c37f5c266a9e8d3e38e7fe6e1`
- Whole-App Gate: PASS (82 acceptance checks, 10 WriterInput checks, 10 Narrative v2 checks)
- Application tree: clean; local SHA equals `origin/repair/prysm-production-closure`; `git diff --check` clean.

## AUD-T2-001 — Duplicate current replay model reconstruction

- Category: `DUPLICATE_SOURCE_OF_TRUTH`
- Severity: `MAJOR`
- Evidence: `services/worker/scripts/replay-report.js:589-700` defines a separate `buildV2Model()` that manually projects `scoreSet` fields. It does not import or call `hydrateCurrentReportModel` and omits persisted `rootCauseRuleId` and `decisionHierarchy`. The T2 production path uses the canonical helper at `services/worker/src/narrative-v2/production-path.js:793`, while replay remains on the independent projection.
- Impact: current replay can render or finalize a semantic model that differs from the persisted current ScoreSet hierarchy/root-cause identity. This directly violates T2's stated Producer → Contract/Persistence → Loader → Consumer boundary and leaves the known duplicate-projection failure class open.
- Why proof missed it: `services/worker/scripts/prysm-whole-app-gate.js` runs the assembled acceptance, WriterInput tests, and Narrative v2 production-path tests, but does not execute `scripts/replay-report.js`. The gate therefore cannot detect current replay divergence.
- Required bounded correction: make current replay consume the validated persisted current semantic model through `hydrateCurrentReportModel` (with explicit historical compatibility kept separate), and add a production-shaped replay parity regression plus exact-SHA gate coverage. Preserve zero-network/zero-paid-call behavior.
- Owning tranche: T2.

## Verdict

`FAIL`. One open MAJOR finding prevents automatic advancement. No application files were modified by this audit.
