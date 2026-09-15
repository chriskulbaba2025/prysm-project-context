# Decision: PRYSM client-report content standard

Date: 2026-09-13
Status: Active

## Decision

The current PRYSM Report v2 refinement is a presentation/content pass over existing governed audit evidence. Client-facing primary pages must read like a senior CRO/CMO explaining what the evidence means and what the client should do next.

## Language standard

- Target Grade 7–8 maximum.
- Use language simple enough that a ten-year-old could explain the main point back, while remaining professional for a business owner, CEO, CMO, or CRO.
- Prefer short sentences, common words, active voice, concrete examples, and plain explanations.
- Do not expose internal governance/system language when a normal business phrase can carry the same meaning.
- Preserve evidence truth, uncertainty, UNKNOWN/PARTIAL semantics, scores, rankings, and internal solution linkage. Do not create claims the evidence does not support.

## Depth and usefulness standard

Primary report pages must not be thin summaries. They must contain enough context, interpretation, and next-step guidance that the client can use the report without decoding technical language.

The target pattern is:

`WHAT WE FOUND -> WHY IT MATTERS -> WHAT TO DO -> WHERE TO LOOK/USE IT -> HOW TO KNOW IT WORKED`

Where useful, also show ownership, confidence, effort, buyer-stage context, or cross-links to the relevant report page.

Depth is evidence-led, not word-count-led. Do not pad with filler, but do not compress material guidance into one-sentence cards merely for brevity.

## Page-specific durable standards

### Executive Scorecard

Explain the score and priorities in plain CRO language. Show supported strengths, evidence limitations, and practical next steps. Internal solution IDs remain hidden from the client-facing page.

### Priority Fixes

Each priority is an actionable mini-plan: plain-language heading, what was found, why it matters, what to do, where to look, how to verify, who may need to help, confidence, and effort. Raw capability/disposition/evidence enums are not client-facing.

### Conversion Journey

Explain whether visitors can move from interest to action, where momentum may be lost, what supports the journey, and what behavior the audit cannot determine. This page explains journey impact; it does not duplicate Priority Fixes.

### Content Opportunities

This page is a practical content plan, not a topic list. When evidence supports it, each opportunity should explain the buyer question, why it matters, what to create, what the content should cover, where it helps in the buyer journey, how to use it, and confidence. Roughly 120–200 words per opportunity is acceptable when that depth is supported; do not use filler or invent unsupported business facts.

### Competitor Comparison

Depth matters more than adding more competitor sites. Two well-qualified named competitors are sufficient when the page provides useful competitive intelligence.

The page should use supported buyer-facing dimensions such as offer clarity, trust/proof, service depth, next-step clarity, and conversion path. Use descriptive states or observations only when evidence supports them; never invent numeric scores, rankings, parity, or market-wide conclusions.

The strategic sequence is:

`COMPARISON -> INTERPRETATION -> ACTION`

The client should be able to see where it is holding its own, where a named competitor offers a better buying experience, where evidence is insufficient, what to protect, what to improve, where differentiation may be useful, and what competitor differences to ignore. "Not enough evidence" must never be presented as poor performance.

## Page-by-page operating rule

For this content-refinement phase:

1. Review one report page.
2. Assess its client usefulness and evidence-safe content needs.
3. In the same response, provide the complete execution-ready Codex prompt when Codex is the next action. Chris must not have to ask separately for the prompt.
4. Use only narrow page-focused tests unless new evidence requires broader verification.
5. Do not rerun providers, Writer/Judge, or a production audit merely to review presentation/content changes.
6. Commit each approved page checkpoint locally before moving to the next page, unless Chris explicitly changes the workflow.

## Final acceptance sequence

After Pages 1–7 are complete:

1. Rerender the completed report against the existing TBK production audit's persisted artifacts using a safe read-only persisted-artifact path if available.
2. Review the whole report for presentation/content consistency without recollecting evidence or rerunning Writer/Judge.
3. Make only necessary final presentation corrections.
4. After explicit deployment/production authorization, deploy the approved renderer.
5. Run one fresh live audit through the normal production application as the final proof and team demonstration.

The known local TBK fixture/artifact set does not fully match the latest live TBK report state (including the previously observed LCP finding). Do not synthesize or transplant evidence to hide that mismatch; use the correct persisted production artifacts during final rerender.

## Reason

The report is a paid decision product. Its value comes from turning governed evidence into clear business meaning and practical action, not from exposing internal audit terminology or producing thin technical summaries.

## Implication

Future report-page work must preserve evidence integrity while optimizing for client comprehension, actionability, and strategic usefulness. Presentation changes must remain generic so future audits automatically receive the same client-facing standard.