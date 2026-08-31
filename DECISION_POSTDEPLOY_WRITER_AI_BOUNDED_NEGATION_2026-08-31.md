# Decision — Post-Deployment Writer AI Bounded-Negation Repair

Date: 2026-08-31

## Production evidence

Fresh production audit:
`c08a6e65-13ad-4a5d-9614-b7f2fc8e708d`

The lifecycle reached:
`created -> validated -> collecting -> evidence_stored -> evidence_locked -> scored -> narrative_pending -> narrative_failed`.

The persisted lifecycle reason begins:
`Writer execution failed on pass 1: Narrative v2 writer validation failed: writerOutput.aiSearch.answerability.text conve...`

A follow-up attempt to retrieve the raw Writer response by a guessed S3 key returned `NoSuchKey`; this does not contradict the lifecycle diagnosis and is not grounds for further forensic expansion.

## Proven deterministic contradiction

`services/worker/src/narrative-v2/writer-prompt.js` explicitly permits neutral evidence-bounded required-field language such as:

- `No material gap was established from the assessed evidence.`
- `This condition was not assessed sufficiently to establish a limitation.`

The same prompt also requires AI-search interpretation to remain opportunity/bounded language when direct AI-search evidence is absent or partial.

`services/worker/src/narrative-v2/writer-output.js` correctly rejects unsupported negative AI-search claims, but its current `negativeAiPattern` matches terms including `limitation`, while `boundedAiPattern` recognizes `not established` but does not recognize equivalent explicit negated-establishment forms such as `No material AI-search limitation was established from the assessed evidence.`

Therefore compliant neutral language can be classified as an established AI-search limitation. This is a validator/prompt contract contradiction, not authorization to weaken evidence integrity.

## Governing repair

Root defect ID:
`PDV1.WRITER_AI_BOUNDED_NEGATION`

The Builder must make one bounded semantic repair:

1. Preserve the existing fail-closed rule that non-AI evidence cannot establish an AI-search limitation.
2. Extend the bounded-AI recognition only enough to recognize explicit negated-establishment wording, including forms equivalent to `no ... limitation/constraint/weakness/gap ... established/identified/observed/detected`.
3. Do not make generic negative AI statements pass merely because they contain `no` somewhere else.
4. Do not remove or weaken PARTIAL/UNKNOWN/UNAVAILABLE protections.
5. Do not add a hidden model retry, fallback, extra paid call, or silent prose mutation.
6. Do not change scoring, evidence collection, publication, or finalization semantics.

## Required proof

At minimum add an executable regression proving both sides:

- PASS: an `aiSearch.answerability` INTERPRETATION grounded only in non-AI evidence with explicit bounded language such as `No material AI-search limitation was established from the assessed evidence.`
- FAIL: an `aiSearch.answerability` INTERPRETATION grounded only in non-AI evidence that states an actual limitation, such as `AI-search answerability is limited by the available content.`

Then run:

- the focused Writer output regression,
- the relevant Narrative v2 deterministic test family,
- the governed Whole-App Gate,
- an independent Auditor pass on the exact frozen repair SHA.

Do not run another paid/live production audit during this repair. Do not merge or deploy until the owner separately authorizes promotion after deterministic and independent audit PASS.

## Efficiency boundary

This decision is intentionally sufficient for >97% confidence in the repair target. Do not continue artifact-path forensics unless the bounded repair/proof fails in a way that materially contradicts this root-cause model.
