# PRYSM Actor-Bounded Review and Evidence-Once Pattern — Permanent Decision

Date: 2026-09-04
Status: Active

## Decision

After a deterministic PRYSM stage gate passes, work proceeds through exactly one correct actor, one bounded task, and one evidence write at the end of that actor's review.

The permanent operating sequence is:

`DETERMINISTIC GATE -> CORRECT ACTOR -> BOUNDED TASK -> COLLECT OBSERVATIONS -> WRITE EVIDENCE ONCE -> BIND ONCE -> NEXT ACTOR`

## Required behavior

1. The deterministic gate establishes machine-verifiable Git, manifest, candidate, and stage facts.
2. The actor named by the gate owns the next task. Do not substitute Chris, Brad, Betty, Builder/Codex, or ChatGPT for another actor merely because that agent is already open.
3. The actor reviews only the bounded outcome assigned to that stage. Do not reopen diagnosis, code, or prior technical proof unless new direct evidence proves the governing boundary is wrong.
4. During human/product review, collect independent observations first. Do not create or repeatedly edit the formal evidence file while observations are still being gathered.
5. When the bounded review is complete, create one new versioned evidence file memorializing the completed review.
6. Do not modify manifest-bound prerequisite evidence in place. Bind the new completed evidence once for the next transition.
7. After binding, route to the next actor named by the lifecycle. Do not add an extra semantic re-gate unless the governing protocol explicitly requires a new independent review stage.

## Why this is permanent

Repeated stop/start loops occurred when machine gates, AI re-audits, actor handoffs, and evidence writing were mixed together. The corrected pattern separates those concerns so the process advances without sacrificing governance.

For Brad OUTCOME_REVIEW specifically, Brad must judge the actual rendered product against the Outcome Contract before reading detailed Builder rationale where practical. Brad gathers bounded observations first and creates the formal outcome-review evidence file only after completing the review.

## Non-negotiable intent

PRYSM governance must reduce rework, not manufacture it. A passed stage should move forward to the correct actor and bounded decision unless new direct evidence establishes a real contradiction or defect.
