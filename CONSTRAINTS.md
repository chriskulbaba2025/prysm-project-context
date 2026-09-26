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
- PROJECT-WIDE GENERATED-ARTIFACT OUTPUT SOP: every generated PRYSM proof, audit, report, verification artifact, handoff artifact, or other user-requested output file that is written to the local Windows filesystem must be written directly to `C:\\Users\\kulba\\Downloads\\` unless Chris explicitly specifies a different path for that specific artifact. Do not leave the only copy in the repository root, working directory, temp directory, sandbox, or another folder. This is a hard project-wide default and must be included explicitly in execution prompts that ask an agent to produce a file.
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
- Current production budget implementation for Narrative v2 uses `PRYSM_LLM_HARD_BUDGET_USD=5.00` as the cumulative per-audit hard ceiling and `PRYSM_LLM_DAILY_HARD_BUDGET_USD=30.00` as the cumulative daily hard ceiling.
- The implementation does not enforce a true cumulative USD $2 per-audit hard cap. Any $2 figure used in approval discussions is a human approval/policy threshold, not a technical cumulative per-audit budget limit.
- No new paid continuation call, new audit, recollection, rescoring, deployment, configuration mutation, push, or persisted production-artifact mutation may occur without the applicable explicit approval at that step.

## Authorized exception — Conversion-First v4.2 CF-01 report interpretation repair

- User authorization was granted on 2026-08-28 to implement the already-mapped CF-01 Conversion-First report-process repair against the frozen TBK audit `9714c206-8ed3-4686-8fe2-ceeca0ca0f82`.
- This exception supersedes the generic presentation-only freeze only where required to repair client-facing interpretation, priority hierarchy, cross-consumer consistency, Writer input/prompt hierarchy, Judge cross-view consistency checks, and competitor report projection.
- This exception does **not** authorize changes to evidence collection, provider/adaptor behavior, raw/normalized/canonical evidence, scoring weights or scoring versions, audit lifecycle, storage, authentication, n8n, production configuration, provider/model execution, or audit orchestration.
- Writer/Judge quality governance remains unchanged: do not lower the release threshold, evidence-fidelity requirements, dimension floors, hard-gate protections, major-defect protections, pass limits, or human-authorization requirements. CF-01 may refine Writer inputs/prompts and Judge contract checks only to enforce the governed Conversion-First hierarchy and cross-view consistency.
- Do not mutate the persisted FindingSet to create the new hierarchy. Conversion influence/order must remain a derived client-facing decision view.
- Use the frozen local TBK replay fixture and offline replay harness for verification. Do not run a fresh paid production audit, recollect providers, rescore external data, or call Writer/Judge models for CF-01 implementation verification.
- Scoring weights remain unchanged unless a separate later evidence-backed scoring review proves a scoring-model defect and the user explicitly authorizes that change.
- Technical findings must remain visible and evidence-grounded; CF-01 changes their client-facing influence/order, not the truth of the underlying evidence.
- Preserve Viewer v2.2.0, the 250-page provider crawl ceiling, 20 priority-URL ceiling, production content-parsing default of 50, and current evidence-status semantics.
- The expected implementation sequence and regression gates are governed by `CURRENT_STATE.md` and `HANDOFF_CF01_REPORT_PROCESS_REPAIR_2026-08-28.md`.
- The manual one-source-file-at-a-time workflow remains mandatory. Do not redo the completed CF-01 architecture investigation unless current source evidence materially contradicts the documented repair boundary.

## Authorized exception — PF pre-run report-integrity repair

- User authorization was granted on 2026-08-28 after the bounded preflight review reached approximately 98% confidence that the material report-path defect families had been identified. The frozen checklist is PF-01 through PF-18 in `HANDOFF_PF_REPORT_INTEGRITY_REPAIR_2026-08-28.md`.
- This exception supersedes the generic presentation-only freeze and the narrower CF-01 boundary only where required to repair the proven deterministic evidence-semantic, scoring-eligibility, finding-generation, report-projection, Narrative-validation, competitor-boundary, contract, and finalization-gate defects in PF-01 through PF-18.
- This exception may modify deterministic scoring/finding logic, capability/report interpretation, Writer/Judge validators and prompts/contracts, relevant report rendering, ScoreSet/WriterInput projections, finalization checks, and the minimum contract/schema fields strictly required to close PF-01 through PF-18.
- This exception does **not** authorize evidence recollection, provider/adaptor behavior changes, paid provider calls, raw/normalized/canonical evidence mutation, audit lifecycle/state changes, storage changes, authentication, n8n, deployment configuration, or unrelated orchestration changes.
- Do not change scoring weights or scoring version merely to produce a different score. Any scoring changes in this package must correct proven unknown/PARTIAL/coverage/capability eligibility semantics while preserving the governed weighting model.
- Frozen TBK evidence for audit `9714c206-8ed3-4686-8fe2-ceeca0ca0f82` remains immutable. After repair, derived findings/scores/report inputs may be rebuilt locally/in memory from that frozen evidence so the repaired deterministic logic can be verified. Do not overwrite the frozen evidence artifacts.
- The exhausted refresh identity `ea9a3b49-d393-4633-956b-d6cb1a2a3fc8` may not receive another Writer/Judge call. Do not create a fourth pass on any six-call identity.
- The refresh identity `9c87448a-c1a1-41eb-a0e5-a8dd63cf8da4` ended after two automatic passes with `REVISE` / 94.5 and is diagnostic evidence only. Do not spend another paid call merely to test prompt wording while deterministic PF defects remain open.
- Writer/Judge governance remains unchanged: preserve the 92 release threshold, perfect evidence-fidelity requirement, dimension floors, hard-gate protections, major-defect protections, automatic two-pass/four-call maximum, absolute three-pass/six-call maximum, and explicit human authorization for any final third pass.
- No new paid Writer/Judge identity may be started until the deterministic PF repair package has passed its targeted regression and offline TBK reconstruction/preflight. The applicable paid-call step still requires explicit approval before execution.
- Preserve Viewer v2.2.0, the 250-page provider crawl ceiling, 20 priority-URL ceiling, and production content-parsing default of 50.
- Preserve the existing local uncommitted CF-01/Narrative changes and replay fixtures. Do not reset, clean, discard, or overwrite them while implementing PF repairs.
- The manual one-source-file-at-a-time workflow remains mandatory. Begin with `services/worker/src/scoring/score-components.js` bounded to PF-01/PF-02/PF-03, complete the Mandatory Pre-Edit Gate, make the smallest coherent source-file repair, run one highest-information proving test, and stop for the result before moving to another source-file unit.
- Do not redo the broad preflight investigation unless current source/runtime evidence materially contradicts the frozen PF package.
- PRYSM SERVICE-SECTOR PRICING RULE: client-facing content opportunities and recommendations must never instruct a service-sector business to publish specific prices or create a pricing page. Cost-related buyer questions may be answered with estimate/quote process, factors that affect scope, what happens before a quote, or similar reassurance, but PRYSM must not invent, expose, or recommend publishing prices.

## Authorized exception — isolated-staging DataForSEO raw-evidence contract repair

- User authorization was granted on 2026-09-25 for one narrow isolated-staging repair tranche only.
- The authorized repository is `chriskulbaba2025/prysm-staging-isolated`, working copy `C:\Users\kulba\Desktop\prysm-staging-isolated`, beginning from exact SHA `3e14fb869f590f6bcfc8f63f39194b4ca3d95698`.
- This exception supersedes the generic report-rebuild prohibitions on evidence-collection, provider/adaptor, storage-behavior, and audit-orchestration changes only where strictly required to repair the already-proven universal DataForSEO raw-evidence return contract before `AuditOrchestrator.processOneSource()`.
- The permitted repair boundary covers the existing OnPage, SERP, and Backlinks adapter paths and the minimum shared contract/orchestrator/test surfaces required to guarantee materially sufficient sanitized pre-normalization raw evidence and request context across success, PARTIAL, FAILED, UNAVAILABLE, and NOT_CONNECTED outcomes.
- Deterministic tests required to prove that contract are authorized.
- Zero paid provider calls.
- Zero live audits, including Bulldog Home Maintenance and Reboot Business Coaching.
- Zero deployments.
- Zero production mutation or production credential/infrastructure use.
- No new DataForSEO endpoints.
- No classifier implementation.
- No report redesign.
- Do not change scoring logic or scoring versions, Writer/Judge governance, authentication, n8n, or unrelated lifecycle/report behavior.
- Raw evidence must preserve provider failure/partial/unavailable/not-connected semantics and sufficient interpretation context while excluding credentials, Authorization headers, tokens, cookies/session secrets, and unnecessary personal information.
- Named sites remain regression/validation fixtures only and must not become implementation targets.
- This exception ends when the generalized raw-evidence repair and its deterministic proof gate are complete or when a new authorization boundary is reached.

## Project-wide Codex completion notification rule

- For every long-running PRYSM Codex or agent execution, the terminal-disposition step must trigger a local Windows completion notification so Chris does not have to watch the terminal continuously.
- The completion signal must include both a visible Windows desktop notification and an audible alert.
- The notification must identify the run and its terminal PASS or FAIL disposition.
- Use a native local mechanism that does not require a paid service or external account.
- The notification must occur only after the proof artifact and terminal disposition have been written.
- If the local notification mechanism fails, report that failure explicitly without changing the technical PASS or FAIL result.
- Long PRYSM Codex execution prompts must include this completion-notification requirement by default.

## Project-wide GACM preflight permission rule

- Every long-running PRYSM GACM-style/Codex execution must begin with a fail-closed preflight that verifies all access, identity, permission, runtime, and dependency requirements needed for the entire planned tranche before substantive analysis, repair, provider execution, deployment, or artifact readback begins.
- The preflight must check every applicable surface, including:
  - local workspace/path availability;
  - repository identity, branch, exact starting SHA, remotes, and working-tree state;
  - GitHub read/write permission if the tranche may commit or update durable state;
  - Railway project, environment, service, CLI/session/authentication, and required command access;
  - isolated-staging artifact storage/S3 read access when evidence readback is planned;
  - staging PostgreSQL/database access when lifecycle/audit identity lookup is planned;
  - Vercel access when deployment/runtime verification is planned;
  - AWS/storage credentials and region/bucket configuration when required;
  - provider/model credentials and explicit paid-call authorization when such calls are part of the approved tranche;
  - browser/session/authentication prerequisites when real browser acceptance is part of the tranche;
  - local proof/output path write access;
  - any other prerequisite named by the frozen acceptance contract.
- Do not print, persist, or copy secret values during preflight. Prove presence/identity/access without exposing credentials.
- If any required access is missing, expired, ambiguous, or unauthorized, STOP immediately with one explicit preflight blocker. Do not spend time diagnosing downstream code or data paths that depend on the missing access.
- A preflight PASS must be written into the run proof before substantive work begins.
- If the planned tranche later expands to require a new system or permission not covered by the original preflight, run an incremental preflight for that new surface before continuing.
- This rule applies before autonomous repair loops. The three-repair-cycle allowance starts only after preflight PASS.

## Project-wide dependency-closure preflight rule

- A long PRYSM preflight must validate the complete dependency graph for the planned execution path, not every infrastructure component indiscriminately.
- Every dependency must be tested from the network/runtime context in which the run will actually use it. A Railway private hostname such as `*.railway.internal` failing to resolve from a local Windows process is not evidence that the Railway service is broken.
- Before declaring PREFLIGHT FAIL, the run must:
  1. enumerate the exact execution path and required dependencies;
  2. eliminate dependencies that are not actually required;
  3. test each required dependency from the correct context;
  4. try the already-authorized no-mutation alternative path when one exists;
  5. collect all remaining blockers in one pass rather than returning after the first incidental failure.
- For isolated-staging evidence readback, direct local PostgreSQL connectivity is not required when the existing authenticated worker audit-status route can resolve audit identity. Prefer the existing worker internal-auth boundary plus Railway-injected S3-compatible storage credentials over local access to Railway private DNS.
- Do not expose secrets while proving this chain. Environment-backed secrets may be consumed by a local script/process but must never be echoed, written to proof files, or persisted.
## Authorized exception — isolated-staging provider-readiness closure and one bounded Bulldog rerun

- User authorization granted on 2026-09-25 to close the isolated-staging live evidence-provider readiness gap end-to-end.
- Authorized scope:
  - set/update isolated-staging worker variables required for DataForSEO and PageSpeed/CrUX live evidence collection;
  - securely use DATAFORSEO_LOGIN, DATAFORSEO_PASSWORD, GOOGLE_PAGESPEED_API_KEY, and optionally GOOGLE_CRUX_API_KEY;
  - trigger the minimum isolated-staging worker redeploy required to apply those variable changes;
  - perform no-cost/low-cost credential validity checks before the audit;
  - prove deployed Playwright/Chromium readiness;
  - run exactly one fresh Bulldog Home Maintenance isolated-staging audit after readiness gates PASS;
  - permit the bounded paid DataForSEO/provider calls required by that single audit;
  - recover and validate the resulting governed evidence package;
  - continue through external classification, independent second verification, reconciliation, and Evidence Package readiness in the same GACM-style tranche.
- Production remains frozen. No production repo, production Railway project, production Vercel project, production storage, or production credentials may be mutated.
- Do not copy production secrets into isolated staging automatically.
- If required provider credentials cannot be found in an already-authorized secure local source, request them once through a secure interactive input step; never print them or write them to proof.
- Do not run more than one fresh Bulldog audit under this authorization.
- Do not broaden into classifier implementation, report redesign, or v1 renderer repair unless separately authorized after Evidence Package validation.
- Existing provider/readback semantics remain fail-closed: UNKNOWN/PARTIAL/UNAVAILABLE/FAILED/NOT_CONNECTED must remain distinct.
## Authorized exception — one-time secure provider-secret migration into isolated staging

- User authorization granted on 2026-09-25 to securely migrate the existing PRYSM provider credentials from the historical working Railway service into the isolated-staging worker.
- Exact source Railway project: `e2318a74-a4f7-4610-9bfc-cbd5a8f54da5` (`conversion-gap-platform-worker`).
- Exact source environment: `1746a42c-7397-42f9-bf10-7eb78c3a3e2b` (`production`).
- Exact source service: `f4c77320-cd09-4e8d-ac9e-70474bfe3a6d` (`conversion-gap-benchmark-audit-platform`).
- Exact target Railway project: `07f1a0a3-a657-4a24-9ecb-56ba667cfc3f` (`prysm-staging-isolated.`).
- Exact target environment: `b67677ba-4ac1-458f-a6d3-412de5ad9ea8`.
- Exact target service: `3343e2a8-0472-4780-8536-e8b9667fcc7a` (`prysm-worker`).
- Authorized mapping only:
  - source `DATAFORSEO_LOGIN` -> target `DATAFORSEO_LOGIN`;
  - source `DATAFORSEO_PASSWORD` -> target `DATAFORSEO_PASSWORD`;
  - source `VANTAGE_PAGESPEED_API_KEY` -> target `GOOGLE_PAGESPEED_API_KEY`.
- Secret values must be captured only in process memory through the authenticated local Railway CLI and must never be printed, echoed, committed, persisted to proof, written to repository files, or copied through chat.
- Do not migrate any other source variable.
- After migration, verify only variable presence and provider authentication, not secret values.
- This exception supersedes the earlier no-automatic-production-secret-copy restriction only for these three named variables and this exact source/target pair.

## Project-wide environment-parity gate

- Any new PRYSM staging, isolated-staging, replacement worker, or promotion candidate must fail closed before audit execution unless an environment-parity gate has compared:
  1. the exact runtime variables referenced by the executing code;
  2. the exact variable names present in the target environment;
  3. the equivalent variables in the last known working source environment, when one exists;
  4. renamed/deprecated variable aliases and migration mappings;
  5. required runtime binaries/dependencies such as Playwright Chromium;
  6. storage, database, provider, model, browser, and authentication dependencies required by the planned audit/report mode.
- The gate must distinguish REQUIRED, CONDITIONALLY REQUIRED, OPTIONAL, and INTENTIONALLY NOT CONNECTED dependencies.
- A target must not be called audit-ready merely because the service is healthy, deploys successfully, or can reach storage/database.
- Variable-name drift must be treated as a migration defect. In particular, legacy `VANTAGE_PAGESPEED_API_KEY` and current `GOOGLE_PAGESPEED_API_KEY` / `PAGESPEED_API_KEY` must be reconciled explicitly when moving between PRYSM generations.
- The parity proof must be completed before any paid provider execution.
