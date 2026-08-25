# PRYSM Diagnostic Evidence Protocol

**Version:** 1.0.0  
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
5. Interpret only what the returned evidence supports.
6. Label any remaining unknown as unresolved; do not convert it into a hypothesis presented as fact.
7. Do not change diagnostic methods merely because an earlier method returned no data. First determine why that method could not observe the required boundary.
8. Do not recommend application changes until the root cause is proven and the Repair Boundary Protocol gate is satisfied.

## No-Guess Rule

Never present an inferred architecture path, storage location, API route, log source, artifact location, environment value, provider behavior, or failure cause as established without verification.

If evidence is unavailable, say that the cause is unresolved and identify the single next diagnostic that would most directly resolve it.

## User-Effort Rule

Do not send the user through repeated browser, shell, log, or storage searches unless the relevant code path has already proven that the requested evidence should exist there and that the command can retrieve it.

Prefer one high-information diagnostic over multiple speculative checks.

## Completion Standard

A PRYSM root-cause statement is VERIFIED only when supported by at least one authoritative source of direct evidence such as:

- persisted governed artifact;
- canonical lifecycle/source-status record;
- provider response or normalized source record;
- directly observed production runtime output;
- authoritative executing code path combined with matching runtime evidence;
- deterministic reproduction/test proving the failure boundary.

Until then, the root cause remains UNRESOLVED.
