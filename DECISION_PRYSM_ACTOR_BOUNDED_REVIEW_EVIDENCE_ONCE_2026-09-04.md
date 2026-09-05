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

## Brad using Codex during Brad-owned review

Brad normally works in VS Code on macOS and may use Codex as his guided review assistant during `OUTCOME_REVIEW`.

The role boundary is permanent:

- **Brad is the actor and decision-maker.**
- **Codex is the review facilitator.** It may guide the bounded review sequence, open or point Brad to the exact rendered artifacts, ask the committed review questions, capture Brad's observations in the active session, and later draft the formal outcome-review evidence from Brad's completed observations.
- Codex must not re-run or second-guess a passed deterministic process gate.
- Codex must not inspect application code first, reopen diagnosis, change the application, call providers/models, start P2, or create the formal evidence file while Brad is still gathering observations.
- Codex must not substitute its own product judgment for Brad's. If Brad has not personally judged an item, it remains unreviewed.
- Once Brad completes all bounded review batches, Codex may help memorialize those observations into one new versioned Brad outcome-review evidence file, which is then committed/bound once for the next transition.
- Never nest Codex inside Codex. If Brad already has an active Codex session, continue in that session. If he is in a normal VS Code terminal, run the deterministic launcher first; after PASS he may enter/continue Codex for the bounded Brad review.

### Brad OUTCOME_REVIEW operating sequence

1. In the normal VS Code terminal, sync governance and run `bash tools/prysm/start-prysm-p.sh P#`.
2. Confirm deterministic output names `Authorized actor: BRAD`.
3. Stop process-gate activity. Do not ask Codex to audit Git/manifest freshness again.
4. In Brad's existing or newly opened Codex session, give Codex the bounded Brad-review instruction for the current batch.
5. Brad personally views the rendered product and gives his observations/verdict for each item.
6. Codex records those observations in-session only; no evidence file yet.
7. Repeat bounded batches until the committed OUTCOME_REVIEW questions are all answered.
8. Create one new formal Brad outcome-review evidence file from Brad's completed observations.
9. Commit/bind that new evidence once, then route to the next governed actor.

## Why this is permanent

Repeated stop/start loops occurred when machine gates, AI re-audits, actor handoffs, and evidence writing were mixed together. The corrected pattern separates those concerns so the process advances without sacrificing governance.

For Brad OUTCOME_REVIEW specifically, Brad must judge the actual rendered product against the Outcome Contract before reading detailed Builder rationale where practical. Brad gathers bounded observations first and creates the formal outcome-review evidence file only after completing the review.

## Non-negotiable intent

PRYSM governance must reduce rework, not manufacture it. A passed stage should move forward to the correct actor and bounded decision unless new direct evidence establishes a real contradiction or defect.
