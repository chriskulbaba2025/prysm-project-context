# PDV4 Repair Boundary — Finalization Gate Production Escapes

Date: 2026-08-31
Status: FROZEN / BUILDER AUTHORIZED
Checkpoint: `PDV4`
Production audit: `688e0cd2-7e09-4b2c-8e20-d05e507f5b7d`
Production application SHA: `368763617a6253183de5931da20bfacb373d1f30`

## Diagnostic closure

The read-only deterministic finalization-gate replay against the already-persisted governed artifacts returned exactly two errors:

1. `site.imagesMissingAlt` / `technical-health` — `imagesMissingAlt (223) cannot exceed or exist without a valid imageCount denominator (0).`
2. `findings[].evidence` / `priority-fixes` — `Finding VAN-TECH-002 converts PARTIAL evidence into an unqualified absence claim.`

`errorCount` is exactly `2`. No third materially distinct finalization error exists in this production-shaped replay. No P-B16 row is required from this diagnostic.

The earlier audit-record diagnostic remains valid: lifecycle persistence truncates the joined gate message to 120 characters, which is why the second error was incomplete in the persisted lifecycle reason.

## Root classification

The two errors are materially distinct roots and must use independent repair-attempt accounting.

### Root 1 — P-B14

Root defect ID:
`PDV4.IMAGE_DENOMINATOR_AVAILABILITY`

Branch:
`P-B14`

Failure chain:
`DataForSEO On-Page producer -> SourceResult availability metadata -> DecisionEvidence hydration -> finalization image numerator/denominator guard`

Verified facts:
- DataForSEO summary `page_metrics.checks.no_image_alt` can provide a positive `imagesMissingAlt` numerator while image arrays are not supplied by the pages endpoint.
- The adapter emits `imageCount: null` when the image denominator is unavailable.
- DecisionEvidence v1 currently serializes the unavailable counter as integer `0` because the frozen schema requires integers.
- DecisionEvidence already passes `_metaFieldAvailability` through without reinterpretation.
- The finalization gate already has the correct semantic behavior when `_metaFieldAvailability.images === false`: skip ratio validation because the denominator is unavailable, not zero.
- The adapter currently emits availability markers for titles, descriptions, canonicals, and headings, but not images.
- Deep Content Parsing can set `_contentEvidenceAvailable === true`; therefore the legacy finalization fallback cannot safely infer image-array unavailability from the broad content marker.

Repair objective:
Propagate explicit image-denominator availability from the On-Page producer through the existing `_metaFieldAvailability` handoff so a schema-coerced `imageCount: 0` remains distinguishable from a proven zero-image denominator.

Required semantic invariants:
- `images === false` means image-array denominator evidence was unavailable, not that the site has zero images.
- A positive provider image-issue numerator with an unavailable denominator remains valid bounded evidence but must not produce a ratio.
- A proven numeric image denominator still enforces `numerator <= denominator`.
- Do not weaken or remove the finalization numerator/denominator integrity check.
- Do not infer image availability from `_contentEvidenceAvailable`.

Expected application boundary:
- `services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.js`
- `services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.test.js`
- DecisionEvidence hydration is an affected handoff and must be verified, but source change is not expected unless proof shows the existing `_metaFieldAvailability` pass-through is insufficient.
- `services/worker/src/scoring/report-finalization-gate.js` is an affected consumer and must be regression-proven; changing its image integrity rule is not expected for this root.
- Whole-App branch proof must include P-B14.

Direct proof required:
1. production-shaped adapter fixture where DataForSEO provides positive `no_image_alt`, no image arrays, and deep content is available;
2. assert explicit image availability survives SourceResult -> DecisionEvidence;
3. assert `imageCount` may be schema-coerced to `0` while the explicit marker remains unavailable;
4. assert finalization does not reject the positive numerator solely because the unavailable denominator is serialized as `0`;
5. negative sibling: when image denominator is actually available/proven, impossible numerator > denominator remains rejected.

### Root 2 — P-B15

Root defect ID:
`PDV4.PARTIAL_HEADING_SCOPE_VALIDATION`

Branch:
`P-B15`

Failure chain:
`deterministic VAN-TECH-002 producer wording -> persisted FindingSet -> finalization PARTIAL absence-claim guard`

Verified facts:
- `VAN-TECH-002` deliberately emits PARTIAL evidence text of the form:
  `<n> assessed pages missing H1; <n> assessed pages with multiple H1s; unassessed pages remain unknown`.
- This wording is explicitly scope-bounded and preserves unknown unassessed pages.
- The finalization guard searches PARTIAL-only finding claim text for absence words such as `missing`.
- Its current bounded-PARTIAL pattern does not recognize the producer's `assessed pages ... unassessed pages remain unknown` wording.
- The deterministic production replay returned exactly the resulting `VAN-TECH-002` rejection.

Repair objective:
Make finalization semantic validation recognize explicitly assessed-scope PARTIAL wording while continuing to reject genuinely unqualified absence claims.

Required semantic invariants:
- PARTIAL evidence must never become a site-wide/unqualified absence claim.
- `assessed page(s)` is a legitimate bounded observation scope.
- `unassessed pages remain unknown` must remain truthful and must not be stripped or reinterpreted as absence.
- Unqualified wording such as `pages missing H1` without an assessment boundary must continue to fail when supporting evidence is PARTIAL-only.
- Do not weaken the absence-pattern guard globally.

Expected application boundary:
- `services/worker/src/scoring/report-finalization-gate.js`
- its direct finalization-gate test file(s)
- `services/worker/src/scoring/score-components.js` is the producer contract to preserve; changing its truthful assessed-scope wording is not expected unless deterministic proof shows the wording itself violates another governed contract.
- Whole-App branch proof must include P-B15.

Direct proof required:
1. PARTIAL-only `VAN-TECH-002` with `assessed pages ... unassessed pages remain unknown` passes the finalization absence guard;
2. an otherwise equivalent PARTIAL-only finding with unqualified `pages missing H1` still fails;
3. existing bounded PARTIAL phrases already accepted by the guard remain accepted;
4. existing genuine absence-claim negative regressions remain green.

## Ordered Builder sequence

1. Recover exact application/governance state without discarding local work.
2. Start at root `PDV4.IMAGE_DENOMINATOR_AVAILABILITY`, Luna / repair attempt 0.
3. Implement the smallest P-B14 producer/handoff correction plus direct regressions.
4. If P-B14 direct proof passes, move to new root `PDV4.PARTIAL_HEADING_SCOPE_VALIDATION`, reset Luna / repair attempt 0, and implement the P-B15 validator regression/correction.
5. After both direct roots pass, add/confirm assembled Whole-App scenarios for P-B14 and P-B15 in the governed branch gate.
6. Freeze one coherent PDV4 candidate SHA containing both root repairs and permanent branch regressions.
7. Run exact-SHA branch-complete Whole-App Gate; P-B14 and P-B15 must be executed and PASS, not merely listed.
8. Run applicable composite/local verification and clean-tree/exact-SHA proofs.
9. Push only `repair/prysm-production-closure`, verify local/remote 0/0.
10. Hand the exact candidate SHA to the independent Auditor.

## Authorization boundary

Authorized now:
- bounded application edits/tests/scripts required to close P-B14 and P-B15 on `repair/prysm-production-closure`;
- deterministic local tests and zero-cost whole-app proof;
- coherent local commits and normal push of the repair branch;
- governance synchronization and independent Auditor handoff.

Still not authorized without separate owner approval:
- merge to application `main`;
- deployment;
- production configuration mutation;
- live/paid provider calls;
- live/paid Writer/Judge calls;
- another production audit.
