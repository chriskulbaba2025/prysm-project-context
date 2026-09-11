# PRYSM Plane 3 Fresh Model-Bearing Authorization

Date: 2026-09-10 America/Toronto
Status: AUTHORIZED

## Exact authorization

Chris explicitly authorized one fresh governed Plane 3 model-bearing baseline against semantic candidate `d7ce3cfe69d5ada8f6d4541c8a9603f17e932a97`, using tooling HEAD `5f2c1a27cbb6eaf022fb9d61dc9a2d6c37a9c3eb`, Writer `gpt-5.6-terra`, Judge `gpt-5.6-sol`, the approved frozen corpus, current budget gates, the paused-GA4 release boundary, and the permanent `PRYSM_MODEL_BEARING_RELEASE_GATE.md`.

## Authorization boundary

Authorized:
- one fresh governed Plane 3 model-bearing baseline against the exact semantic candidate and tooling HEAD above;
- real Writer calls using `gpt-5.6-terra`;
- real Judge calls using `gpt-5.6-sol` where required by the Plane 3 baseline;
- use of the already approved frozen production-shaped corpus only;
- normal governed cost reservations/usage ledgers within the validated soft, hard, and daily budget gates;
- isolated replay/test persistence required by the permanent Plane 3 harness.

Not authorized:
- provider recollection;
- rescore;
- a fresh production audit;
- GA4 conversion-outcome authority expansion;
- deployment;
- application-main merge;
- production mutation;
- model-route changes;
- retry of the historical failed Reboot Run 2;
- resume of the historically abandoned Judge call;
- bypass or weakening of Writer/Judge validation or model-bearing release gates.

## Fail-closed execution rule

A single materially invalid fresh generation is a Plane 3 gate failure and must stop the baseline for diagnosis. It must not be averaged away, silently retried, or replaced with a lucky generation.

Every fresh model-bearing run must record exact semantic candidate SHA, tooling HEAD, frozen input identity/hash, model ID, prompt/output contract identity, validation result, usage/cost, artifact hashes, and semantic-quality result required by the permanent gate.

## Current preflight authority

Preflight result before authorization: `PLANE3_PREFLIGHT_READY / HIGH`.

Validated before any paid call:
- harness identity PASS;
- Writer route `gpt-5.6-terra`;
- Judge route `gpt-5.6-sol`;
- HTTPS endpoint present;
- API credential present;
- token ceilings valid;
- price table valid;
- soft/hard/daily budget gates valid;
- first Writer deterministic cost preflight PASS;
- TBK frozen input PASS;
- Reboot frozen input PASS;
- zero prior calls/reservations in the fresh baseline.

## Exact next action

Execute the fresh governed Plane 3 model-bearing baseline under `PRYSM_MODEL_BEARING_RELEASE_GATE.md`, using the exact candidate/tooling identities and approved frozen corpus above. Stop immediately on any material structural, evidence-integrity, semantic-fidelity, causal-certainty, relevance, contradiction, routing, budget, or identity failure. If the required baseline sample completes cleanly, persist a complete proof and proceed only to the next governed semantic-quality gate; do not deploy or run a fresh production audit.
