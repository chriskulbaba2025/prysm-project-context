# Decision: WriterInput JSON-canonical optional-field projection

Date: 2026-08-31
Status: Active

## Decision

Current WriterInput objects must be JSON-canonical at construction time. Optional fields whose value is `undefined` must be omitted from the in-memory WriterInput projection before persistence. The current in-memory WriterInput packet and its JSON serialize/reload round-trip must have the same governed object identity for persisted contract fields.

For the T1 AUD-T1-002 blocker, `group` is optional hierarchy metadata. When the persisted decision-hierarchy action does not define `group`, WriterInput must omit `group`; it must not create `group: undefined`.

Do not weaken the production-path equality proof to ignore this difference.

## Reason

The preserved Level-3 production-composed proof established that the governed hierarchy itself is present and correctly ordered across multiple actions. The remaining failure is narrower and materially different: `buildWriterConversionInfluence()` adds `group: undefined` in memory, while JSON serialization necessarily omits that property. The WriterInput module already uses `cloneDefined()` / `copyOwn()` semantics elsewhere to omit undefined optional fields, so omission is consistent with the existing projection contract.

## Implication

- Treat AUD-T1-002 as a newly proven canonical-serialization root-cause boundary, not a fourth attempt against the prior hierarchy-propagation defect.
- Reset the governed repair attempt to 0 / Luna for this new boundary under `DECISION_AUTORUN_MODEL_ESCALATION_2026-08-31.md`.
- Preserve the uncommitted multi-action production proof in `services/worker/src/application/narrative-v2-production-path.test.js`.
- Repair the producer projection so undefined optional hierarchy metadata is omitted before persistence.
- Preserve strict in-memory versus persisted/reloaded WriterInput equality; do not replace it with a weaker subset comparison.
- T1 still requires the exact-SHA Whole-App Tranche Gate and independent Auditor PASS before advancing.
