# PRYSM Independent Post-Run Audit Protocol

Version: 1.0.0
Status: ACTIVE / MANDATORY FOR PRODUCTION CLOSURE
Effective: 2026-08-31

## Purpose

Provide a fresh-context independent challenge after every application-changing Production Closure tranche so Builder self-verification cannot be the sole authority for PASS.

The Auditor does not repair application code. It attempts to falsify the tranche's closure claim.

## Audit target contract

One audit target must resolve to:
- application repository `chriskulbaba2025/vantage-platform`;
- dedicated repair branch;
- one exact pushed application SHA;
- one closure tranche T1-T7 (T0 is normally governance-only);
- corresponding Builder checkpoint evidence;
- corresponding PRYSM Whole-App Tranche Gate evidence;
- applicable local/composite verification evidence.

If one exact target cannot be established, verdict is BLOCKED.

## Required audit dimensions

1. **Identity and scope**
   - exact branch/SHA;
   - local/remote equality;
   - clean candidate tree;
   - changed files match tranche objective;
   - no unrelated user work discarded.

2. **Producer-contract-consumer closure**
   - changed producer semantics persisted;
   - persisted contract defines release-critical fields;
   - read boundary validates current compatible artifact;
   - every consumer receives the current governed state;
   - no later consumer independently re-derives a contradictory answer.

3. **Single-source-of-truth review**
   - no duplicated current hierarchy/root-cause/report-model authority;
   - no base/V2/replay copy that can drift silently;
   - helper abstractions actually govern the production paths they claim.

4. **Semantic honesty**
   - UNKNOWN/UNAVAILABLE/PARTIAL/not-deeply-parsed remains explicit;
   - no missing -> 0/false/empty/Complete/AVAILABLE/NOT_CONNECTED coercion where meaning changes;
   - source status coherent across current artifacts and report surfaces.

5. **Version/compatibility integrity**
   - incompatible semantics have truthful versions;
   - current validator does not ambiguously accept historical shape;
   - legacy replay is separate from current release proof;
   - replay does not recompute historical business decisions using current algorithms without an explicit migration contract.

6. **Narrative governance**
   - WriterInput current required context is produced by current production path;
   - production-shaped fixtures activate current hierarchy checks;
   - Writer action order/rank/effort comes from governed current decision state;
   - Judge uses required current hierarchy evidence;
   - persisted release candidate is revalidated before render/recovery;
   - invalid terminal artifacts do not authorize another model spend.

7. **False-PASS audit**
   - no hardcoded `valid: true` at the production acceptance boundary;
   - no pre-seeded near-terminal state pretending to prove tip-to-tail production path;
   - no empty findings/hierarchy fixture when action parity is under test;
   - no synthetic richer-than-production input satisfying a validator;
   - no omitted test family hidden behind a label such as "full";
   - changed production path is exercised by Whole-App gate.

8. **Persistence/recovery**
   - write validation and read validation both exist for current release-critical artifacts;
   - exact identities survive persistence/reload;
   - recovery uses verified persisted state rather than reconstructed defaults;
   - repeat/recovery behavior does not trigger unauthorized paid work.

9. **Release controls**
   - exact-SHA gates precede PASS;
   - no PASS based on queued/stale CI;
   - application branch is synchronized;
   - governance is synchronized;
   - no merge/deploy/live audit was performed without explicit authorization.

10. **Blind-spot challenge**
   - ask what another consumer, restart path, historical artifact, or fixture could do with the changed contract;
   - search for the same field/semantic concept repository-wide;
   - inspect comments/docs that claim direct use while implementation reconstructs;
   - stop when the bounded audit has no material unresolved line of inquiry; do not turn the audit into open-ended redesign.

## Defect severity

CRITICAL:
- can produce materially wrong client-facing conclusion, evidence-status mutation, unauthorized spend, corrupted persistence/recovery, or false production readiness.

MAJOR:
- breaks a required current contract/path, leaves duplicate current authority, allows current false-PASS, or prevents deterministic production closure.

MINOR:
- real issue that does not invalidate tranche safety/semantic correctness and can be scheduled separately.

Only zero CRITICAL/MAJOR findings permits verdict PASS.

## Verdicts

PASS:
No open CRITICAL/MAJOR findings and required proof is sufficient.

PASS_WITH_MINOR:
No CRITICAL/MAJOR findings, but one or more bounded MINOR findings require Builder disposition before automatic advance under this closure roadmap.

FAIL:
At least one CRITICAL/MAJOR finding.

BLOCKED:
Exact target/evidence cannot be established or required proof cannot safely be executed.

## Evidence standard

Prefer direct evidence in this order:
1. exact candidate source/diff;
2. persisted current artifact/schema;
3. executable test/gate at exact SHA;
4. local/remote Git identity;
5. current governance state;
6. historical artifacts only for compatibility comparison.

Do not infer PASS from comments, names, prior chats, or previous green SHAs.

## Audit write contract

The Auditor owns only:
- `PRYSM_POSTRUN_AUDIT_STATE.json`;
- `AUDIT_PRYSM_PRODUCTION_CLOSURE_<TRANCHE>_<YYYY-MM-DD>.md`;
- bounded audit evidence summaries explicitly referenced by the report.

The Auditor does not edit application code or shared Builder state.

## Final audit

T7 final audit repeats the audit across the combined candidate, not merely the latest diff.

It must explicitly review all known systemic escape classes discovered on 2026-08-31:
- missing Writer DecisionEvidence propagation;
- effort/rank fixture drift;
- Judge hierarchy reference drift;
- rootCauseRuleId producer/persistence/consumer loss;
- multiple model reconstructions;
- incomplete/permissive ScoreSet contract;
- stale WriterInput/current-historical version identity;
- replay compatibility contamination;
- semantic defaults in downstream packages;
- incomplete `npm test`/CI coverage;
- weak exact-head release control.

Final PASS requires one exact combined candidate SHA with no open material repository-controlled defect.
