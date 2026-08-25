# Current State

Project:
PRYSM — governed website conversion-readiness report and audit-data system

Current objective:
Diagnose, from direct production evidence only, why Stripe audit `75992ac9-e2f1-4efe-b315-7ee8d6bda13b` produced only about 10% evidence coverage and a report with almost no assessable modules. Do not infer the cause from the rendered report alone.

Verified checkpoint:
- Context repository: `chriskulbaba2025/prysm-project-context`.
- Application repository: `chriskulbaba2025/vantage-platform`.
- Governed application branch: `main`.
- Verified application HEAD remains `edd034b62529a4d7317c1416cdb37c71b7cfb517` — `fix(serp): keep request timeout active in CI`.
- Draft-report `← Back to Dashboard` control remains implemented and deployed.
- SERP CI cancellation defect remains closed; Vantage Worker CI run `32905857982` / `#367` completed successfully.
- Viewer remains v2.2.0 / 16 governed pages.
- Scoring remains v4.1.1 unchanged.
- Controlled production Narrative v2 audit `5d22dcef-7d98-422f-8415-933e7b02003e` remains recovered to `draft_rendered`; no fourth Writer/Judge pass is permitted.
- Stripe audit `75992ac9-e2f1-4efe-b315-7ee8d6bda13b` is verified from the portal record as `draft_rendered`, created at approximately 18:07 and reaching `evidence_stored` at approximately 18:20 before scoring, Narrative v2, and rendering completed.
- The rendered Stripe report shows approximately 10% evidence coverage, 1 of 13 evidence capabilities, 0 assessed modules, and crawl-dependent evidence unavailable.
- That symptom is not yet a verified root cause.
- Browser-relative `/api/v1/audits/...` diagnostics were proven to hit the Next.js web origin rather than the Railway worker and therefore were not a valid direct worker diagnostic.
- Current Railway log output did not contain the historical Stripe audit lines; absence from the current log stream does not prove a source failure cause.
- Local filesystem search was not an appropriate production-artifact diagnostic because the production worker is configured to require durable governed S3 artifact storage.
- Authoritative code verification established that the Next.js audit detail page calls `workerClient.getAuditStatus()` server-side; the worker audit service returns `sourceStatus` from the most recent `evidence_locked` lifecycle event.
- Production governed artifacts use tenant/client/audit scoped object keys and normalized source artifacts such as `normalized/dataforseo-onpage.json`.
- A new governing `DIAGNOSTIC_EVIDENCE_PROTOCOL.md` has been created and verified in GitHub. It prohibits guess-driven diagnosis, requires the executing boundary and direct evidence to be verified before stating root cause, and requires unresolved causes to remain explicitly unresolved.
- `PROJECT.md` has been updated and verified so every substantive PRYSM chat must load `DIAGNOSTIC_EVIDENCE_PROTOCOL.md` during startup.

Current environment / branch / version:
- Governed manual VS Code workflow on Desktop application repository.
- Application path: `C:\Users\kulba\Desktop\vantage-platform`.
- Worker path: `C:\Users\kulba\Desktop\vantage-platform\services\worker`.
- Branch: `main`.
- Verified application HEAD: `edd034b62529a4d7317c1416cdb37c71b7cfb517`.
- Viewer: v2.2.0 / 16 governed pages.
- Scoring: v4.1.1.

Completed:
- Prior Narrative v2 production closure remains complete.
- Draft dashboard-return UI repair remains complete.
- SERP CI cancellation repair remains complete and CI-green.
- Diagnostic governance has been strengthened with the new evidence-first, no-guess protocol and mandatory startup loading.
- The failed speculative diagnostic routes used during the initial Stripe investigation have been identified and closed; they must not be repeated as evidence of root cause.

In progress:
- Stripe audit evidence-acquisition diagnosis for audit `75992ac9-e2f1-4efe-b315-7ee8d6bda13b`.
- Root cause status: UNRESOLVED pending direct source-status / persisted normalized evidence.

Blocked:
- No application repair is authorized or ready because the Stripe root cause has not yet been proven.

Important constraints:
- GitHub context is authoritative durable memory.
- `DIAGNOSTIC_EVIDENCE_PROTOCOL.md` is mandatory governing instruction: do not guess, do not present inferred architecture/provider/storage/failure behavior as fact, and do not send the user through a diagnostic path until the relevant code/runtime boundary proves that path can return the needed evidence.
- Use the shortest read-only diagnostic that retrieves the authoritative evidence.
- Do not change application code until the root cause is proven and the `REPAIR_BOUNDARY_PROTOCOL.md` pre-edit gate passes.
- Manual application edits remain user-applied in VS Code unless the user explicitly changes that method.
- Preserve scoring v4.1.1 and Viewer v2.2.0 / 16 pages unless separately approved.
- Do not rerun production audits, recollect provider evidence, rescore, invoke paid Writer/Judge calls, deploy, or mutate persisted production artifacts without explicit approval.
- Same-failure repair attempts remain capped at three before a deeper diagnostic reset.

Exact next action:
Before issuing any further user diagnostic command, verify from authoritative application code the single read-only production path that can retrieve the Stripe audit's `sourceStatus` or persisted normalized source records. Then give the user only that proven diagnostic. Do not state why Stripe failed until that direct evidence is returned.

Last verified:
2026-08-25 America/Toronto
