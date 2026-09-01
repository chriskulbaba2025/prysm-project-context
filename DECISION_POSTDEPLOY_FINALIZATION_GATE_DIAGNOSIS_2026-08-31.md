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
- audit began 2026-08-31 at approximately 10:37 p.m. America/Toronto;
- lifecycle progressed through collection, governed scoring, Writer/Judge Narrative execution, and `narrative_ready`;
- at approximately 10:56 p.m. it transitioned to `render_failed`;
- visible lifecycle reason begins:
  `narrative-v2-finalization-gate-failed:imagesMissingAlt (223) cannot exceed or exist without a valid imageCount denominator (0); Finding VAN-TECH-002 converts...`

This proves PDV1, PDV2, and PDV3 failure boundaries were traversed successfully in this run. The current failure is after Narrative release-candidate creation at the finalization/render integrity boundary.

## Proven subdefect A — image denominator availability

Confidence: >97% for this subdefect.

Current production source establishes:

1. DataForSEO On-Page can provide `page_metrics.checks.no_image_alt`, so `imagesMissingAlt` can be a positive integer even when image arrays are unavailable.
2. The adapter deliberately returns `imageCount: null` when image arrays are unavailable.
3. DecisionEvidence v1 requires integer counters, so hydration serializes missing `imageCount` as `0` while retaining the positive `imagesMissingAlt` numerator.
4. The finalization gate correctly rejects a positive numerator over denominator `0` unless the denominator is explicitly known unavailable.
5. The gate recognizes unavailability when `_metaFieldAvailability.images === false`, or by a legacy fallback when the images marker is absent, `_contentEvidenceAvailable === false`, and the coerced denominator is `0`.
6. The adapter's `_metaFieldAvailability` currently records titles/descriptions/canonicals/headings but does not record `images`.
7. Deep Content Parsing can make `_contentEvidenceAvailable === true` even though DataForSEO image arrays remain unavailable. In that production branch, the gate loses the evidence that the image denominator is unavailable and treats the schema-coerced `0` as a valid denominator.

Therefore the production-shaped branch `positive provider image issue numerator + unavailable image-array denominator + deep body-content evidence available` is not represented correctly at the finalization handoff.

Do not weaken the finalization ratio check. Preserve unknown-denominator honesty and fix the availability propagation/contract so the gate can distinguish unavailable denominator from true zero images.

## Proven subdefect B — PARTIAL heading finding wording / finalization contract

Confidence: high, but the full production error list must still be captured before repair scope is frozen.

Current scoring source for `VAN-TECH-002` uses bounded PARTIAL evidence text:

`<n> assessed pages missing H1; <n> assessed pages with multiple H1s; unassessed pages remain unknown`

The finalization gate's PARTIAL-evidence absence guard rejects language containing `missing` unless its bounded-partial recognition pattern matches. The current bounded pattern does not recognize the producer's explicit `assessed pages ... unassessed pages remain unknown` wording.

The live lifecycle reason visibly begins a second error:

`Finding VAN-TECH-002 converts...`

This is consistent with a deterministic producer/finalization-validator wording mismatch, but the exact full reason must be captured once before deciding whether this is the complete second root or whether additional finalization errors are present.

Do not weaken the principle that PARTIAL evidence cannot become an unqualified absence claim. Any repair must preserve the fail-closed guard while recognizing or producing explicitly bounded assessed-scope language.

## Why diagnosis is not yet complete

The UI lifecycle reason is visually truncated after the start of the `VAN-TECH-002` error. A historical TBK replay at the same application lineage contained multiple semicolon-separated finalization errors, so assuming the two visible errors are the complete live error list would violate the PRYSM no-guess rule.

One read-only lifecycle diagnostic is therefore required before any application edit or autonomous repair run.

## Exact next diagnostic

From:

`C:\Users\kulba\Desktop\vantage-platform\services\worker`

retrieve the exact audit record for `688e0cd2-7e09-4b2c-8e20-d05e507f5b7d` and save it as a named text file, preferably:

`PRYSM-PDV4-FINALIZATION-DIAGNOSTIC.txt`

The output must include the complete lifecycle/reason text. Do not collect broad logs unless the complete audit record still does not expose the full finalization reason.

## Branch-coverage consequence

The live failure proves at least two current material production branches were not adequately represented in the branch-complete Whole-App proof:

- P-B14 — image numerator available while image denominator is unavailable/coerced to zero, with other deep content evidence available;
- P-B15 — PARTIAL heading finding uses assessed-scope wording through the finalization absence-claim guard.

Both become permanent matrix rows. If the full lifecycle reason reveals another materially distinct finalization branch, add another permanent row before repair PASS.

## Repair authorization boundary

No application edit is authorized by this decision yet.

After the one bounded lifecycle diagnostic:

1. classify every semicolon-separated finalization error by root defect and affected branch ID;
2. determine whether errors share one contract boundary or require separate bounded roots;
3. update this decision/current state as needed;
4. only then reopen autonomous Builder repair at Luna / attempt 0 for each materially new root under the three-attempt rule;
5. require targeted regression + exact-SHA branch-complete Whole-App Gate + independent Auditor.

Still separately unauthorized without later owner approval:

- merge to application `main`;
- deployment;
- production configuration mutation;
- fresh paid/live provider or Writer/Judge calls;
- another production audit.

## Efficiency boundary

Do not over-investigate. The next diagnostic is only to obtain the complete already-recorded finalization reason. Once the full error list is known and the root boundaries are >97% supported, move to bounded deterministic repair.
