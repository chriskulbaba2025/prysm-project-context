# P1 Outcome Contract — Cross-Report Contradiction Integrity

Date: 2026-09-04
Status: DRAFT — BRAD RE-REVIEW / CHRIS APPROVAL REQUIRED
Application: `chriskulbaba2025/vantage-platform`
Governance: `chriskulbaba2025/prysm-project-context`
Frozen application baseline: `6ea608a2625e2a14e28dbc7a5a04e5752b8eeeec`

## Original problem

A client must not receive materially opposing conclusions from different sections of the PRYSM report unless the report clearly explains that those sections measure different constructs.

## Client/business consequence

If one section appears to say something is strong while another appears to say the same thing is weak, the client cannot reliably determine what PRYSM believes, what the evidence means, or what action should be taken.

That reduces trust in the report and weakens its value as a decision-making tool.

## Desired outcome

The client-visible report presents one coherent interpretation of each material issue.

Where different conclusions are legitimate because different constructs are being measured, that distinction must be clear at the point where the client encounters those conclusions.

## One-sentence definition of done

When P1 is complete, a client can read every material P1-related conclusion across the report and understand one coherent assessment, with any differing conclusions clearly identified and explained at the point of reading as measurements of distinct constructs.

## Observable acceptance criteria

1. The exact client-visible report contains no materially opposing P1 conclusions unless they are either reconciled into one coherent assessment or explicitly identified and explained at the point of reading as different constructs.
2. A client must not need to compare distant sections, infer terminology differences, consult technical documentation, or receive a Builder explanation to understand why two apparently different conclusions are both valid.
3. If related constructs produce materially different conclusions, the relevant client-visible wording must state what each construct measures and why the conclusions differ.
4. This applies at minimum to Offer Clarity, CTA / next-step clarity, Conversion Path Clarity, buyer-question coverage, trust/proof, mobile usability, and SEO/indexability.
5. Offer Clarity, CTA Clarity, and Conversion Path Clarity must remain separately meaningful constructs, but whenever their conclusions materially differ, the report must make that distinction understandable where those conclusions are presented.
6. Brad must be able to review the exact client-visible artifact without detailed Builder rationale and conclude that apparently conflicting statements are either genuinely reconciled or visibly explained as distinct measures.
7. Evidence integrity remains controlling. P1 cannot achieve coherence by suppressing valid differences, changing evidence meaning, hiding uncertainty, or forcing different constructs into one artificial conclusion.

## Before evidence

- Current authoritative application baseline: `6ea608a2625e2a14e28dbc7a5a04e5752b8eeeec`.
- Original P1 evidence identified materially conflicting or potentially confusing interpretations across conversion-path clarity, offer clarity, buyer-question coverage, trust/proof, mobile usability, and SEO/indexability.
- Historical P1 engineering diagnosis classified the issue as `VERIFIED_DESIGN_GAP` because related semantic areas were independently interpreted by multiple report consumers.
- Historical repair introduced a deterministic shared interpretation projection and migrated affected consumers.
- Historical technical proof passed focused and Whole-App verification, including fail-closed protection against missing or malformed projections.
- Current outcome rebaseline is: `Substantial engineering improvement exists -> VERIFY rendered/client outcome`.
- Prior technical PASS is evidence of engineering improvement, not by itself evidence that the client-visible P1 outcome is complete.
- Historical stored reports are not accepted as current rendered proof unless exact provenance establishes that they represent the candidate being judged.

## Known dependencies

P1 requires an exact client-visible artifact with provenance tied to the application candidate being reviewed.

The production-visible producer -> persistence -> consumer -> renderer path must be established during the later read-only diagnostic phase.

No P2 work is permitted while P1 remains open.

## Non-goals

P1 does not authorize work on P2-P10.

P1 does not authorize changes to canonical evidence, scoring policy, provider acquisition, Writer/Judge prompts, n8n, production configuration, or unrelated report presentation.

P1 does not authorize a fresh paid/live audit, paid provider/model execution, deployment, merge to application `main`, or destructive repository operation.

## Required product/render proof

P1 closure requires an exact client-visible rendered artifact tied to a frozen application SHA.

The review must examine the affected conclusions across the report rather than proving only one isolated section.

Where different P1 constructs produce different statuses, the rendered artifact must visibly communicate the distinction at the point of reading.

Brad must review the frozen outcome and artifact independently before detailed Builder rationale where practical.

Historical reports without exact candidate provenance cannot satisfy this gate.

## False-PASS test

P1 FAILS if individual sections are each technically defensible but a reasonable client could still read them as materially contradictory without an immediate explanation of why the conclusions differ.

## Current gate

Brad re-review and Chris approval are required.

No P1 diagnosis, repair branch, application edit, or P2 work is authorized until the Outcome Contract is approved by Chris.
