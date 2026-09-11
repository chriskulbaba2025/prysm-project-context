# PRYSM Plane 3 stale frozen WriterInput bypass diagnosis

Date: 2026-09-10 America/Toronto

## Result

`DIAGNOSIS_COMPLETE / HIGH`

## Exact application state

- Application repository: `chriskulbaba2025/vantage-platform`
- Branch: `review/prysm-solution-directive-authority-betty`
- Tooling HEAD: `5f2c1a27cbb6eaf022fb9d61dc9a2d6c37a9c3eb`
- Verified semantic candidate: `d7ce3cfe69d5ada8f6d4541c8a9603f17e932a97`
- Application worktree: clean at diagnosis

## Primary root cause

`STALE_FROZEN_WRITERINPUT_BYPASSES_CURRENT_PRODUCTION_BUILDER`

The Plane 3 Writer-only harness loads the approved historical Reboot `writer-input.json` directly through `resolveApprovedInput()` and submits that parsed object to `buildWriterPrompt()` / `writerExecutor()` without invoking the current `buildWriterInput()` production construction boundary and without validating that the packet is WriterInput `1.2.0`.

The frozen Reboot packet is WriterInput `1.0.0`, not current `1.2.0`. It retains the historical raw causal `businessImpact` sentence and lacks current typed `businessImpactContext` authority. The active production path now projects bounded inferred downstream significance and keeps GA4 downstream commercial-outcome authority paused.

## Exact first divergence

The first unsafe boundary is the Plane 3 frozen-input loading path before prompt construction and before the model call:

`historical report-replay writer-input.json -> resolveApprovedInput() -> selected.writerInput -> buildWriterPrompt()/writerExecutor()`

No current `buildWriterInput()` call occurs and no current WriterInput version assertion occurs before the model call.

## Fresh Reboot PASS/FAIL interpretation

The passing and failing fresh Reboot executions used identical stale WriterInput bytes, identical prompt bytes, identical model route, and identical structured-output contract. The differing result was stochastic model behavior over an unsafe pre-contract packet: one generation bounded the stale language, the other copied unsupported causal meaning. The WriterOutput validator correctly rejected the latter.

## Validator

`CORRECT`

Do not weaken the WriterOutput validator.

## Current 1.2.0 semantics

The diagnosis confirmed current WriterInput `1.2.0` was bypassed by the Plane 3 harness for the Reboot sample. A deterministic current projection of the same finding produces bounded inferred impact with `commercialOutcomeAuthority: PAUSED`; the historical packet does not.

## Evidence consequence

- Five fresh TBK PASS generations remain valid evidence of model behaviour on the exact bytes actually submitted, but they do not yet prove current WriterInput `1.2.0` semantics unless their frozen packet is separately qualified through the current production boundary.
- Fresh Reboot PASS is likewise evidence only on the stale historical bytes.
- Fresh Reboot FAIL remains a valid demonstrated failure and must not be retried or replaced.
- No automatic Plane 3 credit transfer is authorized.

## Minimum repair boundary

Repair only the Plane 3 frozen-input derivation/loading boundary so approved corpus samples are generated or deterministically reconstructed through the current production WriterInput `1.2.0` production boundary from persisted canonical evidence/scores, with pre-call contract/version/hash assertions.

Preserve historical `1.0.0` packets and failed ledgers as immutable evidence.

No WriterOutput validator, prompt, scoring, evidence semantics, provider collection, GA4 conversion authority, model route, deployment, or production mutation change is justified by this diagnosis.

## Next governed gate

One bounded zero-model-call repair of the proven frozen-input / production-WriterInput boundary, followed by independent verification before any new model-bearing execution.
