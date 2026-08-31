# PRYSM Production Closure T4 Independent Audit

Application candidate: `repair/prysm-production-closure` @ `0b10e67662b4c2ad7e97ae94b6927e2c47db0903`
Verdict: **FAIL**

## Finding AUD-T4-003

- Category: `PERSISTENCE_OR_RELOAD_DEFECT`
- Severity: `MAJOR`
- Root defect: `T4.V2_PUBLICATION_RETRIEVAL_CONTRACT`
- Evidence: `services/worker/src/storage/report-store.js:558-581` writes the approved v2 page to the legacy local report directory (`reportDir/.../index.html`) and records only `['index.html']`. `services/worker/src/application/production-runtime.js:942-948` detects the v2 manifest and retrieves `report-v2/pages/${filename}` instead. Thus the post-publication retrieval proof can read the still-present draft v2 page rather than the approved/published artifact. `createS3ReportStore` has no `writeApprovedV2Page` implementation, so the v2 runtime falls back to the legacy approval path.
- Why current proof misses it: the Whole-App Gate checks publication and retrieval only for `index.html`, and the retrieved bytes are not compared with the approved artifact or publication verification record. The acceptance proof therefore passes while publication verifies a different path than retrieval. It also does not exercise the S3 implementation boundary.
- Required bounded correction: make v2 approval, publication verification, and published retrieval use one versioned artifact location and contract for both local and S3 stores; ensure the publication record verifies that exact artifact; add a regression that mutates/removes or distinguishes the draft versus approved path and proves retrieval is fail-closed/reads the verified approved bytes. Extend the gate to exercise this exact assertion. Preserve legacy 16-page v1 behavior.
- Owning tranche: T4.

## Evidence executed

- `node scripts/prysm-whole-app-gate.js`: PASS (82 acceptance checks; all listed test families pass; current replay CLI passed 1/1).
- Application HEAD equals remote branch; working tree clean; `git diff --check` clean.
- No application files were modified by the Auditor.

## Verdict rationale

The candidate has sufficient current replay and historical compatibility coverage, but the production v2 approval/publication/retrieval chain is not closed. The defect can cause a client-facing published report to be served from an unverified draft location and is a required T4 boundary.
