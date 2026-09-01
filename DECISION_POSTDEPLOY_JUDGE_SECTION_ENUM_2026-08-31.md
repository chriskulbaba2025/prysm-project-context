# Decision — PDV2 Judge Defect Section Contract Alignment

Date: 2026-08-31
Status: Active
Checkpoint: PDV2
Root defect: `PDV2.JUDGE_DEFECT_SECTION_ENUM`

## Production evidence

Fresh production audit `6c69f909-e3a9-449e-b830-decc3ca2ffd7` on production SHA `008dc9af5ea80706e6db7034ccaaa17817490915` reached:

`created -> validated -> collecting -> evidence_stored -> evidence_locked -> scored -> narrative_pending -> narrative_failed`

The terminal lifecycle reason is:

`narrative-v2-execution-failed:Judge execution failed on pass 2: Narrative v2 judge validation failed: defects[0].section must be a governed Writer fie...`

This proves the prior PDV1 Writer repair cleared the original Writer-pass-1 failure and the live run progressed through Writer pass 1, Judge pass 1, and Writer pass 2 before failing at Judge pass 2 validation.

## Proven contract defect

At production SHA `008dc9af5ea80706e6db7034ccaaa17817490915`:

- `services/worker/src/narrative-v2/judge-contract.js` defines `WRITER_SECTION_FIELDS` and requires `defects[].section` to be one of those governed Writer section identifiers.
- `services/worker/src/narrative-v2/judge-structured-output.js` constrains `defects[].allowedFields` and `mustPreserve` to `WRITER_SECTION_FIELDS`, but defines `defects[].section` only as `nonEmptyString()`.
- Therefore the provider-facing strict structured-output schema can accept a non-empty section string that the deterministic Judge validator subsequently rejects as not governed.

This is a schema/validator contract mismatch, not an evidence, scoring, collection, deployment, or Writer semantic defect.

## Authorized bounded repair

Repair only `PDV2.JUDGE_DEFECT_SECTION_ENUM`.

Expected source/test boundary:

1. `services/worker/src/narrative-v2/judge-structured-output.js`
   - constrain `defects[].section` to the existing `WRITER_SECTION_FIELDS` enum.
   - do not create a second section list or duplicate source of truth.

2. Relevant Judge structured-output/contract test file(s)
   - add a deterministic regression proving `defects[].section` is schema-bounded to the governed Writer section set.
   - preserve existing validator rejection of unknown sections.

## Required proof

Before PDV2 can close:

- focused Judge structured-output / Judge-contract regression PASS;
- relevant deterministic Narrative v2 tests PASS;
- exact-SHA Whole-App Gate PASS;
- `git diff --check` PASS;
- clean frozen application candidate;
- repair branch pushed and synchronized 0/0;
- independent Auditor PASS with zero material defects on the exact candidate SHA;
- governance state synchronized and verified.

## Prohibited scope expansion

Do not:

- weaken `WRITER_SECTION_FIELDS` validation;
- accept arbitrary nested paths as governed section identifiers;
- mutate Judge output silently after provider return;
- add retries, hidden fallbacks, extra model calls, or automatic repair loops;
- change Writer semantics, evidence collection, scoring, lifecycle, publication, rendering, or finalization;
- merge to `main`, deploy, mutate production configuration, or run another paid/live production audit during PDV2 repair.

## Repair accounting

This is a materially new root defect discovered after PDV1 passed. Start at repair attempt 0 / Luna. It does not consume or reopen the PDV1 repair chain.

## Closure

PDV2 is complete only after exact-SHA deterministic proof, Whole-App Gate PASS, and independent Auditor PASS. Production promotion and another fresh live audit remain separate owner authorization boundaries.
