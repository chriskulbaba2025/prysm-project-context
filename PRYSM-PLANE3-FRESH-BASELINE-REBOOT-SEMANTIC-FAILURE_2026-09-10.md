# PRYSM Plane 3 Fresh Baseline Reboot Semantic Failure

Date: 2026-09-10 America/Toronto

## Result

`PLANE3_BASELINE_FAIL / HIGH`

## Exact identities

- Semantic candidate: `d7ce3cfe69d5ada8f6d4541c8a9603f17e932a97`
- Tooling HEAD: `5f2c1a27cbb6eaf022fb9d61dc9a2d6c37a9c3eb`
- Writer: `gpt-5.6-terra`
- Judge: `gpt-5.6-sol` configured; no Judge call reached
- Approved TBK WriterInput SHA: `f0581ea32df8a003b7b5d68faeddca44ab68ddbafd87aa1fe4f23511399e5b9f`
- Approved Reboot WriterInput SHA: `1057aa5f9859c231813df8bee3a1e1ac8711b4ae08a5e4314e4461731daa0bad`

## Fresh baseline evidence

- TBK Writer-only fresh generations: `5/5 PASS`
- Reboot Writer-only fresh generations attempted: `2`
- Reboot PASS: `1`
- Reboot FAIL: `1`
- Complete Writer -> Judge orchestrations: `0` because the mandatory stop triggered before orchestration phase
- Total Writer calls: `7`
- Total Judge calls: `0`
- Total actual persisted Writer cost: `USD 0.785116`

## Exact first failure

Fresh Reboot Writer generation 2:

- execution ID: `plane3-writer-only-97d6b2c7-03b9-4530-8ea7-16557502c638-13d81fc4-0ca0-4bc4-8d27-f447a50e7fe0`
- response SHA: `f3c94d3422566bf22de778f3836df069f8927847c66aa7577ad32488febfb56c`
- validator failure: `writerOutput.actionPlan[0].whyNow.text states an unmeasured business outcome with causal certainty`
- semantic disposition: material failure; no retry or replacement permitted
- the failed sample also contained a performance user-impact statement that copied unsupported causal business-impact meaning from source context, requiring exact authority-path diagnosis

## Preserved evidence

- No evidence-status conversions separately observed
- No fabricated evidence observed
- One unsupported causal/commercial-certainty defect
- One material contradiction relative to the bounded Reboot sibling
- GA4 pause preserved
- No provider recollection
- No rescore
- No deployment
- No merge
- No production mutation
- Application worktree remained clean

## Governance consequence

Plane 3 is failed for the current semantic candidate. Do not average away the failed generation. Do not retry the failed fresh Reboot generation, generate a replacement, continue to the remaining Reboot sample, or enter Writer -> Judge orchestration before diagnosis and any required repair are governed and independently verified.

The 5/5 TBK fresh PASS outputs and the one Reboot fresh PASS output remain preserved evidence, but no automatic credit transfer to a future semantic candidate is authorized.

## Exact next action

Run one zero-PRYSM-model-call semantic root-cause diagnosis of the exact failed Reboot execution. Recover and compare the exact frozen WriterInput, exact built Writer prompt, exact parsed provider response, normalized WriterOutput, validation error, passing Reboot sibling, and relevant WriterInput/prompt/validator authority paths. Determine the single first divergence that allowed unsupported causal/commercial certainty to reach `actionPlan[0].whyNow.text` and the sampled performance user-impact text. Classify whether the defect is stale frozen input, WriterInput projection leakage, prompt authority leakage, structured-output/schema insufficiency, validator-only reliance, or another proven source. Do not implement a repair until the exact authority leak is proven.
