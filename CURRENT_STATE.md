# Current State

Project:
PRYSM — governed website conversion-readiness report and website decision system

Current objective:
Redesign the client-facing decision model so PRYSM is genuinely conversion-first rather than a broad technical website audit with conversion language. Preserve the evidence-integrity repairs already proven and deployed. Do not weaken unknown-evidence handling, capability gates, or provenance.

Verified application checkpoint:
- Authoritative context repository: `chriskulbaba2025/prysm-project-context`.
- Application repository: `chriskulbaba2025/vantage-platform`.
- Governed application branch: `main`.
- Current deployed application checkpoint: `a00d1d1d21114b0809875b635d593bebc01aadcb` — `fix(prysm): complete final TBK evidence repairs`.
- Railway deployment for this commit was visually verified ACTIVE / Deployment successful on 2026-08-27.

Evidence-integrity repair package — COMPLETE / PUSHED / DEPLOYED:
1. Production browser activation — PASS.
   - Normal production intake defaults `crawl.pathValidationLiveBrowser` to true unless explicitly disabled or killed by `PRYSM_DISABLE_LIVE_BROWSER`.
   - Focused proof: `production-runtime-browser-default.test.js` — 1/1 PASS.
2. Browser evidence bridge — PASS.
   - Genuine browser observations can support `conversion.cta`, `conversion.form`, and `conversion.path` only where actually assessed.
   - NOT_ASSESSED remains suppressed/non-penalizing.
   - Browser-observed readiness is consumed by conversion scoring/report projection rather than stale empty site arrays.
   - Focused proof: `browser-evidence-bridge.test.js` — 1/1 PASS, 0 fail, duration 132.0491 ms.
3. Real response-header evidence — PASS.
   - Existing bounded Playwright document navigation captures only the four governed response-header signals.
   - `technical.headers`, Risk Reduction scoring, technical subscore, and missing-header finding consume real browser-observed evidence when available.
   - Header collection failure remains unknown and cannot create false missing-header findings.
   - Focused proof: `response-header-evidence-bridge.test.js` — 1/1 PASS, 0 fail, duration 95.525 ms.

Application commit/push:
- Commit: `a00d1d1d21114b0809875b635d593bebc01aadcb`.
- Message: `fix(prysm): complete final TBK evidence repairs`.
- 9 intended files; no unrelated files in the committed repair package.
- Remote `main` verified at the commit.

Final TBK production verification audit:
- Target: `https://www.tbkcreative.com/`.
- Audit ID: `f7e5e17c-0828-4803-843f-20213f9ad8b9`.
- Started from the normal production UI after deployment.
- Last observed lifecycle state: `collecting`.
- Do not infer final module coverage/results until the production audit completes.

New active work package:
PRYSM CONVERSION-FIRST REDESIGN

Verified product problem:
- PRYSM contains a conversion-first action planner, but the Executive Scorecard still selects its top three findings directly from raw `model.findings`, allowing technical findings sorted by numeric priority to headline the report.
- The current overall score is named Conversion Readiness but uses broad readiness dimensions: conversion pathways 25%, trust/risk 25%, content/funnel 20%, technical/performance 20%, entity/schema/AI 10%. This is broader than a strict conversion-readiness construct.
- The 16-page client report devotes substantial first-class space to technical SEO, headings, schema, performance, accessibility/mobile, and internal links, making the product feel more like a technical/SEO audit than a conversion decision system.
- Changing only the finding-priority coefficient is insufficient. The current finding priority already weights conversion impact at 40% and a separate conversion-first action planner already ranks domains Conversion → Trust → Performance/UX → Acquisition → Technical.

Conversion-first redesign target:
1. Primary client question: What is stopping more qualified visitors from understanding the offer, trusting it, and completing the desired action?
2. Executive/top-priority lists must use the governed conversion-first action plan, never raw finding order.
3. The primary Conversion Readiness score must measure conversion determinants, not broad technical health.
4. Technical, schema, SEO, and infrastructure evidence remain audited but normally act as diagnostics/supporting evidence unless they create a demonstrated conversion, acquisition, rendering, safety, or measurement blocker.
5. Technical Health may remain as a secondary diagnostic score/appendix concept, separate from Conversion Readiness.
6. The first two-thirds of the client-facing report should answer: what is blocking conversion, why, what evidence supports that conclusion, and what should be changed first.
7. Technical detail should be compressed/deferred unless directly conversion-relevant.

Proposed conversion-readiness domains for design review (NOT YET IMPLEMENTED):
- Offer clarity and next-action clarity — 30%.
- Conversion path completion/readiness — 25%.
- Trust, proof, and buyer risk reduction — 20%.
- Decision-stage/content support — 15%.
- UX/performance conversion friction — 10%.
These weights are a design proposal only and must be validated against existing evidence capabilities and scorer semantics before code changes.

97+ acceptance standard for this work package:
- Executive top three cannot be dominated by technical hygiene when assessed conversion/trust issues exist.
- Every top action must trace to collected evidence and a governed finding; no invented conversion claims.
- Unknown evidence remains unknown and cannot lower the score or create a negative finding.
- Primary Conversion Readiness must have an explicit, defensible conversion-specific weighting contract.
- Technical Health must not silently contaminate the primary score outside explicitly conversion-relevant friction/blocker rules.
- Report ordering and language must make conversion decisions unmistakably primary within the first screen/page and first two-thirds of the report.
- A technically strong but conversion-weak fixture must score/report as conversion-weak.
- A technically imperfect but conversion-strong fixture must not be incorrectly prioritized as a technical remediation project unless the technical defect demonstrably blocks conversion/acquisition/safety/measurement.
- Existing evidence-integrity tests remain green; no regression in browser evidence, response-header evidence, or unknown handling.

Architecture boundary:
Do not re-open evidence collection unless the conversion redesign exposes a specific missing conversion signal that cannot be derived from existing collected evidence. No n8n changes.

Operating constraints:
- GitHub context is authoritative.
- Diagnose before editing; no guessing.
- Design scoring/priority/report contract before code.
- Smallest coherent change set after design is locked.
- User applies application source edits manually.
- Exact Windows path, exact lines/anchors, complete replacement blocks; multiple edits bottom-up.
- One high-information focused test after each coherent repair unit; no redundant check stacking.
- Maximum three failed attempts on the same defect before deeper diagnosis.
- No paid provider/model call, production audit rerun, deploy, or production mutation without explicit approval.

Exact next action:
Map the current conversion-readiness score construction, action-priority consumption, executive report selection, pillar/report page structure, and relevant tests. Produce a locked Conversion-First Product Contract containing: primary-score domains/weights, technical-escalation rules, executive-priority rules, report page order, and acceptance fixtures. Do not edit application code until that contract is agreed.

Last verified:
2026-08-27 America/Toronto
