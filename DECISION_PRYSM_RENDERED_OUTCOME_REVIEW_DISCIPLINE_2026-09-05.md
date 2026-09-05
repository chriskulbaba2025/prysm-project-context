# PRYSM Rendered Outcome Review Scenario Discipline — Decision

Date: 2026-09-05
Status: Active

## Decision

During Brad-owned `OUTCOME_REVIEW`, rendered HTML scenario artifacts are controlled evidence conditions used to test client-facing behavior. They are not alternate report versions to rank against one another.

Brad reviews the assigned scenarios one artifact at a time as a client, records the observation for each, completes the full bounded review inventory, and only then allows the findings to be consolidated for a reopen/repair decision.

## Required review lens

For each assigned rendered artifact, record:

1. `CLEAR` or `CONFUSING` — can a normal client understand what the report is saying at the point of reading?
2. `Contradiction: YES/NO` — does another client-visible section appear incompatible with the same underlying condition?
3. `Evidence truthful: YES/NO` — does the report preserve the difference between measured-good, measured-bad, missing, partial, failed, and unavailable evidence?
4. `Client usefulness: YES/NO` — can the client understand what is known, what is unknown, and what to do next?
5. Plain-English `What I noticed` notes owned by Brad.

Where useful, distinguish a **material P# defect** from a **minor wording/quality reservation**. A wording reservation may be retained for later cleanup without turning an otherwise evidence-safe scenario into a material P# failure.

## Review-before-repair rule

- Review all artifacts assigned to the current bounded batch before changing application/report code.
- Do not repair one rendered scenario while other assigned scenarios remain unreviewed.
- Do not reopen diagnosis/build from a single page observation when the bounded review inventory is still incomplete.
- Consolidate the complete material defect set first.
- If the overall outcome remains materially unmet, create the formal Brad evidence once, bind it once, route to Chris for `REOPEN SAME P#`, and perform one coherent diagnosis/replan/repair cycle against the full observed defect set.
- After repair, regenerate/review the affected governed scenarios rather than assuming the wording change fixed all related projections.

## Evidence-state rule

Missing, partial, failed, unavailable, and measured evidence must remain distinct in client-facing language.

Examples:

- a failed device run must not become a bad device score;
- missing performance evidence must not become either a positive or negative performance conclusion;
- poor lab performance must not be represented as proven poor mobile usability;
- a PASS explanation must not imply that an explicitly absent trust signal was observed.

## Why this is durable

P1 has shown that deterministic tests can pass while client-facing wording still creates a misleading or contradictory product outcome. Artifact-by-artifact human review catches those failures, while completing the bounded inventory before repair prevents symptom-by-symptom thrash and cross-scenario regressions.

This decision extends and must be read with `DECISION_PRYSM_ACTOR_BOUNDED_REVIEW_EVIDENCE_ONCE_2026-09-04.md`.
