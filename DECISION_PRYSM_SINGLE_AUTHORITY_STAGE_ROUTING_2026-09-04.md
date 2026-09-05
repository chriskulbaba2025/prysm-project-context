# PRYSM Single-Authority Gate and Stage Routing — Permanent Decision

Date: 2026-09-04
Status: Active

## Decision

PRYSM uses exactly one deterministic authority for machine-verifiable process-gate facts. After that gate passes, execution routes directly to the one role that owns the authorized stage. No AI may re-run an open-ended process-gate audit of the same Git/manifest facts.

## Root cause closed

The prior launcher performed deterministic Git/manifest checks and then launched Codex with instructions to independently re-audit those same prerequisites. That duplicate authority produced a false stale-binding failure even though current Git blobs exactly matched their recorded gate commits. OUTCOME_REVIEW was also being routed to Codex even though Brad owns that stage, and Codex was pre-required before the launcher knew whether a Builder stage was active.

## Permanent rules

1. Deterministic launcher owns Git cleanliness, synchronization, commit ancestry, evidence blob binding, required verdict literals, stage identity, application branch/SHA, and candidate proof binding.
2. Semantic review occurs in explicit committed review/audit artifacts before manifest binding.
3. After deterministic PASS, Builder prompts may execute only the authorized Builder stage and must not re-audit the process gate.
4. OUTCOME_REVIEW routes to Brad.
5. CLOSURE routes to Chris/durable state closure.
6. Codex CLI is required only for Builder-owned stages.
7. Manifest-bound evidence files are immutable for the stage; later state uses CURRENT_STATE or new versioned evidence.
8. OUTCOME_REVIEW must verify technical proof, system proof, candidate freeze, rendered product proof, scenario matrix, rendered manifest, and exact candidate SHA.
9. Launcher/gate changes are incomplete until `bash tools/prysm/test-prysm-gate-contract.sh` passes.

## Evidence for this decision

During the 2026-09-04 process audit, the current blobs and the blobs at the gate-recorded commits were directly compared for the P1 Outcome Contract, Brad review, approval attestation, pre-execution audit, Diagnostic Truth, Betty pre-repair review, bounded repair authorization, technical proof, system proof, candidate freeze, product proof, scenario matrix, and rendered manifest. The compared blobs matched. The application branch also matched the gate SHA `85bbeda3cb4bb2fefb47b5e551f9edc0432feea2`.

The replacement gate was then exercised in isolated Git repositories with six deterministic regression cases: 6 PASS / 0 FAIL.
