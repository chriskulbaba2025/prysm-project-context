# PRYSM Diagnostic Evidence Protocol

**Version:** 1.1.0  
**Status:** Governing project instruction  
**Purpose:** Prohibit guess-driven diagnosis and require evidence-backed root-cause work.

## Governing Rule

For PRYSM diagnostics, troubleshooting, defect analysis, and repair planning, do not guess.

Before stating a root cause, recommending a repair, or directing the user through a diagnostic path, first verify the relevant runtime, call path, persistence boundary, artifact location, API route, configuration source, or test evidence from authoritative code or directly observed production evidence.

## Required Diagnostic Sequence

1. Define the exact observed failure or deficiency.
2. Verify the executing production/runtime path from authoritative source code or direct runtime evidence.
3. Identify the authoritative persisted record or artifact that can prove the cause.
4. Use the shortest read-only diagnostic that retrieves that evidence.
5. Reproduce the failure deterministically from authoritative persisted bytes when a replay boundary exists.
6. For live/deployed failures, separately establish the exact deployed runtime identity that executed the failure; do not infer it from repository main, a UI deployment, or an unrelated service status.
7. Interpret only what the returned evidence supports.
8. Label any remaining unknown as unresolved; do not convert it into a hypothesis presented as fact.
9. Do not change diagnostic methods merely because an earlier method returned no data. First determine why that method could not observe the required boundary.
10. Do not recommend application changes until the root cause is proven and the Repair Boundary Protocol gate is satisfied.

## No-Guess Rule

Never present an inferred architecture path, storage location, API route, log source, artifact location, environment value, provider behavior, deployed SHA, model configuration, or failure cause as established without verification.

If evidence is unavailable, say that the cause is unresolved and identify the single next diagnostic that would most directly resolve it.

## Live/Production Triangulation Rule

For a production failure whose cause can depend on deployment identity, persisted input/output, or model behavior, one isolated evidence source is not sufficient merely because it is authoritative in its own domain.

Before calling the root VERIFIED, reconcile as applicable:

1. **Observed production outcome** — lifecycle/error/runtime evidence proving what failed.
2. **Persisted production artifacts** — exact governed input/output bytes and hashes proving what crossed the relevant boundary.
3. **Executing runtime identity** — direct proof of the deployed worker/application revision and relevant model/prompt/contract configuration that executed the failing path.
4. **Deterministic reproduction** — the same persisted bytes reproduce the same boundary failure under the identified code path, where technically possible.

If runtime identity remains unproven, state `RUNTIME_IDENTITY_UNPROVEN`. Do not silently treat GitHub main as the deployed worker.

If exact persisted bytes cannot reproduce the observed failure, do not patch the visible symptom. Diagnose the production/replay mismatch first.

## Model-Bearing Diagnostic Rule

For Writer/Judge/model-bearing defects:

- distinguish model generation failure from prompt/schema/validator mismatch, normalization drift, WriterInput/reference defects, orchestration defects, and deployment/configuration drift;
- inspect the exact parsed provider response before normalization when available;
- do not infer the full model/validator failure from a truncated lifecycle reason;
- do not treat a later successful generation as disproving an earlier real failure;
- after the deterministic root is proven, repeated real model-bearing tests may be required under `PRYSM_MODEL_BEARING_RELEASE_GATE.md` to prove robustness rather than one-sample luck.

## Counterexample Rule

A diagnosis is stronger when it predicts both failure and non-failure.

For a repaired material semantic boundary, require where practical:

- the exact failing case or faithful production replay;
- a positive sibling that should pass;
- a negative/counterexample sibling that should still fail.

A repair that only makes the original symptom disappear without proving the intended boundary remains incomplete.

## User-Effort Rule

Do not send the user through repeated browser, shell, log, or storage searches unless the relevant code path has already proven that the requested evidence should exist there and that the command can retrieve it.

Prefer one high-information diagnostic over multiple speculative checks.

When shell evidence is materially useful for human review, prefer a named `.txt` diagnostic artifact rather than terminal scrollback alone.

## Completion Standard

For bounded deterministic defects, a PRYSM root-cause statement is VERIFIED when authoritative direct evidence establishes the failing boundary, such as:

- persisted governed artifact;
- canonical lifecycle/source-status record;
- provider response or normalized source record;
- directly observed production runtime output;
- authoritative executing code path combined with matching runtime evidence;
- deterministic reproduction/test proving the failure boundary.

For live/model-bearing/deployment-sensitive defects, also satisfy the Live/Production Triangulation Rule above to the extent each evidence plane materially affects the cause.

Until then, the root cause remains UNRESOLVED or explicitly PARTIALLY VERIFIED with the unresolved dimension named.
