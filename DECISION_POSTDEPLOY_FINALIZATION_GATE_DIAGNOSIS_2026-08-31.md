# Decision — PDV4 Post-Narrative Finalization-Gate Repair

Date: 2026-08-31
Status: ACTIVE / REPAIR BOUNDARY FROZEN / BUILDER AUTHORIZED
Checkpoint: `PDV4`
Diagnostic umbrella ID: `PDV4.FINALIZATION_GATE_POST_NARRATIVE`

## Production evidence

Fresh production validation audit:

- audit ID: `688e0cd2-7e09-4b2c-8e20-d05e507f5b7d`;
- target: `https://www.tbkcreative.com/`;
- exact production application SHA: `368763617a6253183de5931da20bfacb373d1f30`;
- lifecycle traversed collection, governed scoring, Writer/Judge Narrative execution, and `narrative_ready`;
- it then transitioned to `render_failed` at the finalization/render integrity boundary.

The first read-only audit-record diagnostic proved that lifecycle persistence itself truncates the joined finalization reason to 120 characters via `message.slice(0, 120)`.

The second read-only deterministic diagnostic re-evaluated only `runFinalizationGate` against the already-persisted governed artifacts for the same live audit. It returned exactly:

- `passed: false`;
- `errorCount: 2`;
- error 1: `site.imagesMissingAlt` / `technical-health` — `imagesMissingAlt (223) cannot exceed or exist without a valid imageCount denominator (0).`;
- error 2: `findings[].evidence` / `priority-fixes` — `Finding VAN-TECH-002 converts PARTIAL evidence into an unqualified absence claim.`

No third materially distinct finalization error was returned. No P-B16 row is required from this diagnostic.

`PDV4_REPAIR_BOUNDARY_2026-08-31.md` is the frozen pre-edit repair map.

## Root 1 — P-B14 image denominator availability

Root defect ID:
`PDV4.IMAGE_DENOMINATOR_AVAILABILITY`

Confidence: >97%.

Verified chain:

1. DataForSEO summary `page_metrics.checks.no_image_alt` can supply a positive `imagesMissingAlt` numerator when the pages response does not supply image arrays.
2. The On-Page adapter emits `imageCount: null` when that denominator is unavailable.
3. DecisionEvidence v1 requires integer counters and currently serializes the unavailable denominator as `0` while passing `_metaFieldAvailability` through.
4. The finalization gate already distinguishes an unavailable denominator when `_metaFieldAvailability.images === false`.
5. The adapter currently emits field availability for titles, descriptions, canonicals, and headings, but not images.
6. Deep Content Parsing can make `_contentEvidenceAvailable === true`, so broad content availability cannot stand in for image-array availability.

Required repair direction:
propagate explicit image-denominator availability at the producer/handoff. Do not weaken the numerator/denominator integrity rule and do not reinterpret unavailable as proven zero.

## Root 2 — P-B15 PARTIAL heading scope validation

Root defect ID:
`PDV4.PARTIAL_HEADING_SCOPE_VALIDATION`

Confidence: >97% after the complete deterministic replay.

Verified chain:

1. `VAN-TECH-002` deliberately emits bounded PARTIAL text:
   `<n> assessed pages missing H1; <n> assessed pages with multiple H1s; unassessed pages remain unknown`.
2. This text preserves the assessed scope and explicitly leaves unassessed pages unknown.
3. The finalization PARTIAL absence guard sees `missing` but its current bounded recognition pattern does not recognize this assessed-scope form.
4. The deterministic replay returned exactly the corresponding `VAN-TECH-002` rejection.

Required repair direction:
recognize explicitly assessed-scope PARTIAL wording while retaining fail-closed rejection for genuinely unqualified absence claims. Do not globally weaken the absence guard.

## Root accounting and order

The two errors are materially distinct roots and must not share one repair escalation counter.

Ordered Builder work:

1. active root: `PDV4.IMAGE_DENOMINATOR_AVAILABILITY`, Luna / repair attempt 0;
2. after its direct proof passes, move to new root `PDV4.PARTIAL_HEADING_SCOPE_VALIDATION`, reset Luna / repair attempt 0;
3. after both direct roots pass, freeze one coherent PDV4 candidate containing both repairs and permanent P-B14/P-B15 branch regressions;
4. execute the exact-SHA Whole-App Branch Coverage Gate with P-B14 and P-B15 both executed and PASS;
5. run applicable composite/local verification, clean-tree proof, push the dedicated repair branch, prove local/remote 0/0, then hand the exact SHA to the independent Auditor.

## Branch-coverage consequence

Permanent rows:

- P-B14 — positive image issue numerator + unavailable image-array denominator serialized as zero + deep content available;
- P-B15 — PARTIAL `VAN-TECH-002` assessed-scope wording through finalization absence guard.

Both are now `MAPPED / UNEXECUTED` pending Builder implementation and exact-SHA proof.

## Authorization boundary

Application repair is now authorized only within the frozen PDV4 boundary under the existing autonomous Production Closure decision.

Authorized:
- bounded source/test/gate edits needed for P-B14 and P-B15;
- deterministic local diagnostics/tests and zero-cost assembled Whole-App proof;
- coherent commits and normal push only to `repair/prysm-production-closure`;
- governance synchronization and independent Auditor handoff.

Still separately unauthorized without later owner approval:

- merge to application `main`;
- deployment;
- production configuration mutation;
- live/paid provider calls;
- live/paid Writer/Judge calls;
- another production audit.

## Exact next action

Start autonomous Builder at root `PDV4.IMAGE_DENOMINATOR_AVAILABILITY`, Luna / repair attempt 0, following `PDV4_REPAIR_BOUNDARY_2026-08-31.md`. Do not repair P-B15 under the P-B14 attempt counter; switch to the P-B15 root with a reset attempt 0 after P-B14 direct proof passes.
