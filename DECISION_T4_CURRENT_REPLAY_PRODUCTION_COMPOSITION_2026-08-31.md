# Decision: Generate current replay artifacts through deterministic production composition

Date: 2026-08-31
Status: Active

## Decision

Current-release replay proof must use a current artifact set generated through deterministic production composition. Historical persisted fixtures remain historical/compatibility-only and must not be incrementally patched, migrated field-by-field, or relabeled as current-release proof.

The deterministic current artifact source must exercise the real repository-controlled production composition with controlled/frozen transports, current contract builders, current persistence boundaries, and no live/paid provider or model calls. The produced persisted artifacts may then be replayed by the current replay CLI/path as the current-release fixture.

The preserved uncommitted `services/worker/scripts/replay-report-cli.test.js` work must be reconciled, not discarded. Its CLI/subprocess proof intent is retained, but its current artifact source must change from a migrated historical fixture to deterministic production-composed current artifacts.

## Reason

AUD-T4-002 exhausted Luna -> Terra -> Sol because the attempted current CLI proof kept upgrading a historical fixture one contradiction at a time. The real current replay/finalization path correctly rejected stale historical semantics including competitor allowlist provenance, an impossible `imagesMissingAlt`/`imageCount` relationship, and a PARTIAL-evidence absence claim.

Those failures show that the fixture itself is not a trustworthy current semantic source. Continuing to repair its nearest contradiction would repeat the same root defect and create an unbounded fixture-migration exercise.

The repository already has deterministic production-composition coverage using `createProductionRuntime`, controlled adapters, memory artifact storage, and current Narrative v2 composition. That mechanism can generate a coherent current artifact set from current contracts rather than guessing how a historical artifact should be transformed.

## Implication

- Treat unreliable historical-fixture migration as the exhausted root defect.
- Treat deterministic production-composed current replay artifacts as a materially new repair/proof boundary.
- Reset governed T4 repair attempt to 0 / Luna for this new boundary.
- Preserve the dirty application tree and all Level-3 proof work; do not reset, clean, overwrite, or discard it.
- Historical replay remains explicitly compatibility-only and cannot satisfy current release readiness.
- Current replay proof must originate from current deterministic composition and persist/reload the real current contracts.
- Do not weaken finalization or evidence-integrity validators to make a stale fixture pass.
- Do not fabricate or manually patch semantic fields merely to satisfy the current replay path.
- No live/paid providers, Writer/Judge calls, deployment, or production mutations are authorized by this decision.
- T4 still requires focused proof, exact-SHA Whole-App Tranche Gate PASS, and independent Auditor PASS before T5.
