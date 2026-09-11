# PRYSM Live UAT TBK Prompt Contradiction Diagnosis

Date: 2026-09-10 America/Toronto

## Result

`DIAGNOSIS_COMPLETE / HIGH`

## Application checkpoint

- Application repository: `chriskulbaba2025/vantage-platform`
- Application HEAD under test: `e8130770401f0e68bd05e310cf6dd66fc6ca1c4a`
- Audit: `9714c206-8ed3-4686-8fe2-ceeca0ca0f82`
- WriterInput: `1.2.0`
- WriterInput SHA: `d95dc2922f8cef3813812a7f3704aef10fc78e5dc2e43e4dd04ddf8fdfa3d6da`

## Live validation result

The authorized single current-format TBK Writer -> Judge validation returned `LIVE_UAT_SINGLE_VALIDATION_FAIL`.

- Writer: `gpt-5.6-terra`, exactly 1 call
- Judge: `gpt-5.6-sol`, exactly 1 call
- Writer structural validation: PASS
- Judge structural validation: PASS
- Judge decision: REVISE
- Judge score: 94
- Hard gate: FAIL
- Material defect: `conversion.whatWorks.text` implied measured completion/effectiveness where evidence established only an observed CTA/invitation and assessed path clarity
- GA4 pause preserved
- Provider recollection: 0
- Rescore: 0
- Deployment: 0
- Production mutation: 0

## Proven first divergence

`services/worker/src/narrative-v2/writer-prompt.js` contains two conflicting authority instructions.

Rule 8d correctly says that a visible form, CTA, enquiry route, or conversion-path condition is not a confirmed conversion, lead, enquiry, or customer outcome and must not be treated as a confirmed downstream outcome.

Rule 11a then says: `CTA clarity measures the observed invitation and path clarity measures completion of that invitation.`

The phrase `measures completion of that invitation` is unsafe because it can be read as evidence that visitor completion was measured. The failed Writer output followed that unsafe interpretation and the Judge correctly rejected it.

## Root cause

`WRITER_PROMPT_AUTHORITY_CONTRADICTION`

This is a prompt semantic defect, not a WriterInput, ScoreSet, GA4, provider, scoring, or Judge defect.

## Minimum repair boundary

Repair Rule 11a in `writer-prompt.js` so conversion-path clarity describes the assessed route from the observed invitation toward the next step, while explicitly stating that path clarity does not measure whether visitors completed the action or converted.

Add a focused regression proving the prompt cannot describe conversion-path clarity as measured visitor completion and remains consistent with Rule 8d / commercial-outcome pause.

Do not weaken WriterOutput validation or Judge fidelity checks. Do not change WriterInput, ScoreSet, scoring, evidence, GA4 authority, provider routes, or report rendering.

## Next governed action

Run one bounded zero-model-call prompt repair with deterministic regression. If it passes, return directly to one newly authorized fresh current-format TBK Writer -> Judge validation; do not reopen legacy corpus work or broader Plane 3 sampling before first human UAT.
