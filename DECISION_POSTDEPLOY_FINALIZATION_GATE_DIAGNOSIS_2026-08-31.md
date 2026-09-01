# Decision — PDV4 Post-Narrative Finalization-Gate Diagnosis

Date: 2026-08-31
Status: ACTIVE / DIAGNOSTIC BOUNDARY
Checkpoint: `PDV4`
Diagnostic root ID: `PDV4.FINALIZATION_GATE_POST_NARRATIVE`

## Production evidence

Fresh production validation audit:

- audit ID: `688e0cd2-7e09-4b2c-8e20-d05e507f5b7d`;
- target: `https://www.tbkcreative.com/`;
- exact production application SHA: `368763617a6253183de5931da20bfacb373d1f30`;
- lifecycle progressed through collection, governed scoring, Writer/Judge Narrative execution, and `narrative_ready`;
- it then transitioned to `render_failed` at the finalization/render integrity boundary.

The first bounded diagnostic retrieved the authoritative audit record with HTTP 200. The persisted `render_failed` reason is exactly:

`narrative-v2-finalization-gate-failed:imagesMissingAlt (223) cannot exceed or exist without a valid imageCount denominator (0).; Finding VAN-TECH-002 converts`

Authoritative production source at the exact production SHA proves the truncation occurs before lifecycle persistence: `renderNarrativeV2Draft()` joins the complete `gate.errors` message and then passes `message.slice(0, 120)` into the lifecycle transition reason. Therefore the missing suffix is not recoverable from the persisted lifecycle record or UI.

This proves the first lifecycle diagnostic is complete but insufficient by design to enumerate every finalization-gate error. Diagnosis remains open only for one deterministic re-evaluation of the gate against the already-persisted governed inputs.

## Proven subdefect A — image denominator availability

Confidence: >97%.

Current production source establishes:

1. DataForSEO On-Page can provide a positive `page_metrics.checks.no_image_alt` even when image arrays are unavailable.
2. The adapter deliberately returns `imageCount: null` when image arrays are unavailable.
3. DecisionEvidence v1 requires integer counters, so hydration serializes missing `imageCount` as `0` while retaining the positive `imagesMissingAlt` numerator.
4. The finalization gate correctly rejects a positive numerator over denominator `0` unless denominator unavailability is explicitly known.
5. The gate can recognize explicit `_metaFieldAvailability.images === false`, but the adapter does not currently emit that image availability marker.
6. Deep Content Parsing can make `_contentEvidenceAvailable === true` even while image arrays remain unavailable, defeating the legacy denominator-unavailable fallback.

Therefore the production-shaped branch `positive provider image issue numerator + unavailable image-array denominator + deep body-content evidence available` is not represented correctly at the finalization handoff.

This is branch escape P-B14.

Do not weaken the numerator/denominator integrity check. Preserve unavailable denominator as unavailable.

## Strongly supported subdefect B — PARTIAL heading wording / finalization contract

Current scoring source for `VAN-TECH-002` uses bounded PARTIAL evidence text of the form:

`<n> assessed pages missing H1; <n> assessed pages with multiple H1s; unassessed pages remain unknown`

The finalization PARTIAL-evidence guard rejects language containing `missing` unless its bounded-partial recognition pattern matches. The current bounded pattern does not recognize that explicit assessed-scope wording.

The persisted production reason proves the second finalization error begins with:

`Finding VAN-TECH-002 converts`

This is consistent with the producer/finalization-validator mismatch already mapped as P-B15. The complete deterministic gate output is still required to classify the full second message and determine whether additional finalization errors exist.

Do not weaken the rule that PARTIAL evidence cannot become an unqualified absence claim.

## Why diagnosis is still open

The authoritative audit record cannot expose the complete finalization list because production lifecycle persistence intentionally truncates the joined gate message to 120 characters.

Do not collect broad logs and do not call the production orchestrator from `render_failed`: that path can transition lifecycle state and is therefore outside the read-only diagnostic boundary.

The shortest safe remaining diagnostic is to re-evaluate the pure deterministic `runFinalizationGate` against the same persisted governed DecisionEvidence, CapabilityEvidence, FindingSet, and ScoreSet using source at exact production SHA `368763617a6253183de5931da20bfacb373d1f30`.

## Exact next diagnostic

From a tracked-clean local checkout at exact application SHA `368763617a6253183de5931da20bfacb373d1f30`:

1. connect read-only to the governed S3 artifact store using the existing Railway environment;
2. load the persisted AuditRequest, DecisionEvidence, CapabilityEvidence, canonical findings, and canonical scores for audit `688e0cd2-7e09-4b2c-8e20-d05e507f5b7d`;
3. reconstruct the same current report model used by `renderNarrativeV2Draft()`;
4. execute only `runFinalizationGate`;
5. save the complete `gate.errors` array to `PRYSM-PDV4-FINALIZATION-GATE-FULL.txt`.

This diagnostic must not call the production orchestrator, transition lifecycle state, write governed artifacts, call providers/models, or edit application code.

## Branch-coverage consequence

The live failure proves at least these permanent coverage escapes:

- P-B14 — image numerator available while image denominator is unavailable/coerced to zero, with other deep content evidence available;
- P-B15 — PARTIAL heading finding uses explicit assessed-scope wording through the finalization absence-claim guard.

If the complete deterministic gate output reveals another materially distinct finalization branch, add another permanent matrix row before PDV4 PASS.

## Repair authorization boundary

No application edit is authorized yet.

After the deterministic gate output is captured:

1. classify every finalization error by root defect and branch ID;
2. freeze the complete PDV4 repair boundary;
3. only then reopen autonomous Builder repair at Luna / attempt 0 for each materially new root under the three-attempt rule;
4. require targeted regression + exact-SHA branch-complete Whole-App Gate + independent Auditor.

Still separately unauthorized without later owner approval:

- merge to application `main`;
- deployment;
- production configuration mutation;
- provider/model calls;
- another production audit.

## Efficiency boundary

Do not over-investigate. One deterministic gate re-evaluation against the already-persisted inputs should close the diagnostic boundary if it returns the complete error array.
