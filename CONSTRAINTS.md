# Constraints

Record hard project boundaries here.

## Active PRYSM report-rebuild constraints

- Report structure/presentation only for this rebuild.
- Do not modify evidence collection.
- Do not modify provider/adaptor behavior.
- Do not modify scoring logic or scoring versions.
- Do not modify audit lifecycle or state transitions.
- Do not modify storage behavior.
- Do not modify canonical evidence plumbing.
- Do not modify Writer/Judge governance.
- Do not modify audit orchestration.
- Do not modify n8n flows as part of report-page implementation.
- Do not modify authentication as part of report-page implementation.
- Do not broaden a report change into an architectural redesign.
- Work one report source file at a time.
- If multiple approved report pages/functions live in the same supplied source file, they may be updated together as one governed source-file unit.
- Do not batch changes across separate report source files.
- Required sequence for every governed source-file unit:
  verify stable application branch/head → identify exact source file → user provides current file from VS Code/current working copy → inspect the complete file → apply the smallest approved coherent change → return the complete replacement file directly in the conversation (sequential labeled chunks are allowed) → user pastes all chunks into the working copy → run syntax checks and targeted/relevant regression tests → correct any syntax/code/test errors before commit/update → only after verification passes update/commit the application → then move to another source file.
- PROJECT-WIDE MANUAL CODE FLOW: when the user supplies a current source file for repair, do not give piecemeal find/replace instructions unless explicitly requested. Produce the coherent updated file, split into exact copy-order chunks when useful, then verify syntax and code/tests before any repository update. This workflow is intended to minimize repeated edits to the same file and is the default for PRYSM application changes.
- PROJECT-WIDE THREE-ATTEMPT DIAGNOSTIC RESET: for the same observable failure or unresolved defect, allow no more than three consecutive solve/verify attempts that fail to produce verified improvement. After the third unsuccessful attempt, STOP. Do not make a fourth repair attempt, do not keep changing nearby code, and do not repeat the same hypothesis with different wording. Perform a deeper diagnostic reset first: restate expected versus actual behavior; list what the previous attempts proved or ruled out; verify the exact executing file/runtime/input/output and call path; inspect the complete relevant code/data boundary; and identify one materially new, evidence-backed root-cause hypothesis before any further edit. The attempt count resets only when new evidence materially changes the failure boundary or root-cause hypothesis, not merely because another edit is proposed.
- PROJECT-WIDE CODE DELIVERY RULE: never deliver source code, replacement code, patches, scripts, configuration code, or other code files through generated/downloadable file links or sandbox downloads. This prohibition applies across the entire PRYSM Project, in every chat and work package.
- All code-file replacements must be delivered directly in the conversation. If a complete file is too large for one message, provide it in sequential, clearly labeled code blocks in exact copy order, with no omitted middle content, and explicitly mark the final block as complete.
- Do not directly edit the `vantage-platform` application repository as part of this manual report workflow unless the user explicitly changes that operating method.
- Do not reconstruct, guess, or edit an application source file that the user has not supplied or whose exact current contents have not been verified.
- If a supplied file proves that a second file is strictly required, identify that dependency before modifying the second file.
- Do not move to another source file until the current source-file unit passes its relevant verification.
- Preserve the current left-hand navigation concept unless an approved viewer-contract change requires a minimal section update.
- The current governed viewer contract is 16 pages / Viewer v2.2.0, including standalone Accessibility & Mobile Usability Readiness after Performance and before Internal-Link Opportunities.
- Do not change the governed page count or viewer contract except through a deliberate approved migration with corresponding test-contract verification.
- Do not update tests merely to silence a regression; test changes require an intentional approved contract migration.
- Do not edit `services/worker/src/report/sections-conversion.js` for Report v2. It belongs to the frozen v1 path protected by V2R-07.
- Do not run a paid production audit merely to verify report-presentation changes.
- Every report page must begin with a plain-language client question and answer it before technical evidence.
- Client-facing status labels are:
  PASS / FINDING / PARTIAL / UNAVAILABLE / NOT APPLICABLE.
- Every status must include a plain-language explanation.
- No missing, unavailable, partial, blocked, or not-connected evidence may be left unexplained.
- Missing evidence must never be presented as a business failure.
- Important commercial/conversion pages must drive client-facing conclusions.
- Low-value utility-page issues may remain observations but must not dominate site-level conclusions.
- Raw H1/H2 counts are supporting evidence, not the client-facing semantic conclusion.
- Technical observations do not automatically become findings.
- Recommendations require material relevance to search visibility, conversion, trust, accessibility, usability, crawl/indexation, or a defined business objective.
- Passing/healthy areas should be made visible where useful.
- Technical metrics are evidence, not conclusions.
- Competitor behavior alone does not create a recommendation.
- Search demand alone does not create a content recommendation.
- Link quantity alone does not create an internal-link finding.
- Missing schema types alone do not create a schema recommendation.
- Performance lab data must not be represented as field performance.
- Accessibility Readiness must not be represented as legal AODA/WCAG compliance certification.
- Structured report visuals should use deterministic inline SVG by default.
- AI image generation must not be used for deterministic report charts/diagrams such as radar charts, pathway diagrams, or entity maps.
- The Conversion Readiness radar/spider chart must use existing scores only and must not alter scoring.
- Any limited-evidence dimension shown visually must be clearly identified as limited evidence.
- Do not modify `PROJECT_CONTEXT_PROTOCOL.md` for ordinary project-state changes.
- Do not rewrite the production PRD or Adam recommendation source merely to record implementation state; those remain governing/reference documents.
- PROJECT-WIDE CONCISE DIAGNOSTICS RULE: diagnostic, verification, Railway, GitHub, and similar shell commands must default to the shortest command that returns only the evidence required for the current decision. Avoid full JSON, full logs, or broad output unless a deeper diagnostic reset specifically requires it.
- PROJECT-WIDE DURABLE-MEMORY RULE: when a stable milestone materially changes verified checkpoint, blocker, exact next action, SHA/deployment, durable decision, hard constraint, or governing procedure, update the authoritative GitHub context before presenting a new-chat handoff. A chat summary alone is not a completed handoff.
- PROJECT-WIDE ACTION-FIRST RULE: every technical or diagnostic response must include a concrete executable action when further work is required. Do not return explanation-only progress updates, intentions, or descriptions of what the assistant plans to do. Perform available verification/tool work immediately; when user action is required, give the single next action directly.
- PROJECT-WIDE NO-GUESS RULE: do not state a technical cause, runtime behavior, provider behavior, storage path, configuration value, or repair recommendation as fact until the executing boundary and direct evidence support it. If evidence is incomplete, say the cause is unresolved and run the shortest diagnostic that can resolve it.
- PROJECT-WIDE FORWARD-LOOKING RULE: recommendations must account for the next likely failure boundary, downstream dependency, operational cost, and product constraint before implementation. Prefer a design that removes repeat failure classes over a local patch that only fixes one observed symptom.
- PROJECT-WIDE RESPONSE BIAS: when work can advance safely, prefer the next executable action over extended explanation. Keep rationale brief unless the user asks for depth or a deeper diagnostic reset requires it.

## Authorized exception — PRYSM-V2-UAT-RERENDER-01

- User authorization was granted on 2026-08-22 for audit `d3b4cc62-9217-4c0b-b169-e24beb46a79c` only.
- The objective is to visually UAT Viewer v2.2.0 using the audit's already-persisted governed inputs without starting a new audit.
- The permitted implementation is a read-only, in-memory UAT rerender path using persisted AuditRequest, canonical scores/findings, capability evidence, decision evidence, and the already-persisted Narrative v2 release candidate.
- Provider calls are prohibited.
- Writer/Judge/model calls are prohibited.
- The existing approved Viewer v2.1.0 report artifact must not be overwritten, replaced, mutated, or deleted.
- The audit lifecycle state must not transition or be rewritten as part of UAT rerendering.
- Canonical evidence, scores, findings, Narrative v2 artifacts, manifests, and existing report artifacts remain immutable inputs.
- The UAT path may return newly rendered HTML for inspection only; it must not publish or approve anything.
- Normal report access authorization must still execute before any UAT report bytes are returned.
- The manual one-source-file-at-a-time implementation method remains active for this work package unless the user explicitly changes it.

## Authorized exception — audit-data validation and correction for audit 97d6b2c7

- User authorization was granted on 2026-08-23 to critically test the evidence-acquisition and interpretation path using audit `97d6b2c7-03b9-4530-8ea7-16557502c638` for `https://rebootbusinesscoaching.com/`.
- This is a separately governed data-quality investigation, not part of the presentation-only report rebuild. The presentation-only freeze therefore does not prevent investigation of proven evidence/provider defects under this exception.
- Existing persisted artifacts for audit `97d6b2c7-03b9-4530-8ea7-16557502c638` remain immutable evidence. Do not overwrite, delete, or mutate them for diagnosis.
- Do not create or rerun a full production audit merely to diagnose the selected audit.
- Read-only artifact inspection, direct HTTP diagnostics, local execution of existing read-only acquisition code, and isolated minimal provider requests are permitted when needed to prove or disprove one defect.
- Prefer no-cost diagnostics first. Before any paid provider request, state what it tests, expected cost exposure, what it cannot change, and what result would prove or disprove the hypothesis.
- Writer/Judge/model reruns are prohibited for this investigation unless separately and explicitly authorized later.
- Before changing application code, the defect must be proven and recorded in `REFERENCE/AUDIT_DATA_VALIDATION_97d6b2c7.md` with upstream inputs, downstream consumers, artifact/contracts affected, cost/retry implications, regression risks, and required tests.
- Any authorized data-layer repair must be the smallest coherent fix for the proven defect. Do not broaden it into unrelated scoring, lifecycle, storage, authentication, n8n, report-design, or architecture changes.
- If a data repair legitimately changes capability eligibility, scoring inputs, evidence coverage, or report conclusions, treat those as downstream reactions to verify, not as reasons to suppress the correct evidence.
- Application source changes continue to use the governed manual VS Code source-file workflow unless the user explicitly changes that operating method.
- After each diagnostic or fix, update the durable investigation ledger when the result materially changes known state or downstream impact.

## Authorized exception — Narrative v2 human-review continuation repair

- User authorization was granted on 2026-08-25 to repair the production workflow that stopped an otherwise scored audit at `narrative_failed` when Narrative v2 returned `HUMAN_REVIEW_REQUIRED` after the bounded automatic rounds.
- The repair may modify Narrative v2 orchestration, live-binding, production-runtime/API, portal review-action code, and deterministic Narrative v2 rendering only as required to provide and complete the governed continuation path.
- The existing Narrative v2 quality gate remains unchanged; do not lower the 92/100 release threshold, evidence-fidelity requirement, dimension floors, hard-gate protections, or major-defect protections.
- The continuation must reuse already-persisted governed evidence and scores. It must not rerun DataForSEO, PageSpeed, backlinks, GA4, GSC, collection, evidence locking, or scoring.
- The existing first/second-round narrative artifacts remain immutable evidence of the prior execution. The final third-round artifacts are additive and auditable.
- The final third Writer/Judge round required explicit human authorization. It has now been completed successfully for audit `5d22dcef-7d98-422f-8415-933e7b02003e`; no fourth Writer/Judge round is permitted.
- The controlled audit reached a governed release candidate and then `draft_rendered` after deterministic render recovery. Do not rerun the audit or re-authorize another final narrative pass merely to verify the completed result.
- Production Writer remains the approved Terra model; Judge remains unchanged.
- Current production budget implementation for Narrative v2 uses `PRYSM_LLM_HARD_BUDGET_USD=1.50` as an individual model-call hard ceiling and `PRYSM_LLM_DAILY_HARD_BUDGET_USD=30.00` as the cumulative daily hard ceiling.
- The implementation does not enforce a true cumulative USD $2 per-audit hard cap. Any $2 figure used in approval discussions is a human approval/policy threshold, not a technical cumulative per-audit budget limit.
- No new paid continuation call, new audit, recollection, rescoring, deployment, configuration mutation, push, or persisted production-artifact mutation may occur without the applicable explicit approval at that step.