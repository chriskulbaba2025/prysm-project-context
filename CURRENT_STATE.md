# Current State

Project: PRYSM

Current objective:
Lock a defensible, useful V1 report foundation by strengthening evidence acquisition, evidence classification, scoring verification, and reconciliation before redesigning or automating the report. Automation and recurring remediation workflows are V2.

Verified checkpoint:
- Authoritative durable context repository: `chriskulbaba2025/prysm-project-context`.
- Active isolated staging repository for this tranche: `chriskulbaba2025/prysm-staging-isolated`.
- Isolated staging default branch: `main`.
- Exact isolated staging HEAD verified on 2026-09-25: `3e14fb869f590f6bcfc8f63f39194b4ca3d95698`.
- The isolated staging repository was initialized from production snapshot `26fb91d29559cb189064c301cdf89ff69f330492`.
- `STAGING_ISOLATION.md` explicitly marks this repository staging-only and freezes production; it must not mutate the production Vercel, Railway, PostgreSQL, AWS/storage, Cognito, production domain, or `chriskulbaba2025/vantage-platform`.
- Repository inspection confirms current DataForSEO adapter families for OnPage, SERP, and Backlinks.
- Repository inspection confirms governed storage primitives with tenant/client/audit-scoped object keys and artifact categories including `raw`, `normalized`, `canonical`, `report`, and `manifests`.
- It is NOT yet proven that every useful DataForSEO provider payload is persisted materially intact in governed `raw` storage before normalization. That is the active gate.
- The GACM prompt `PRYSM DATAFORSEO RAW EVIDENCE PRESERVATION GATE` is prepared. It requires zero paid provider calls, zero deployments, zero live audits, and no production mutation.
- The report-foundation decisions are recorded in `DECISIONS.md`: V1 report before V2 automation; deliberate evidence classification; independent second verification after scoring; real-DFS tuning before classifier implementation; and the 2 TOFU / 2 MOFU / 2 BOFU / 2 Leading Edge content contract.
- The service-sector no-pricing recommendation rule is recorded as an active hard constraint.

Current environment / branch / version:
- Working directory: `C:\Users\kulba\Desktop\prysm-staging-isolated`
- Repository: `chriskulbaba2025/prysm-staging-isolated`
- Branch: `main`
- SHA: `3e14fb869f590f6bcfc8f63f39194b4ca3d95698`
- Production source snapshot: `26fb91d29559cb189064c301cdf89ff69f330492`

Completed:
- Selected Bulldog Home Maintenance as the relatively strong validation fixture and Reboot Business Coaching as the more complex/weak validation fixture; neither may become an implementation target.
- Defined the report-foundation sequence: evidence acquisition -> normalization -> classification -> scoring -> independent verification -> reconciliation -> client-facing report.
- Defined the principle that the second measurement must be meaningfully independent and disagreements must reconcile or fail closed rather than be averaged.
- Defined the content opportunity target of up to eight primary ideas across TOFU/MOFU/BOFU/Leading Edge.
- Prepared the bounded GACM raw-evidence preservation gate for Codex.

In progress:
- DataForSEO raw-evidence preservation diagnosis has not yet been run.

Blocked:
- No current project blocker is proven. If Codex authentication fails again, resolve the local authentication/runtime issue before the GACM run; do not change PRYSM code to work around it.

Important constraints:
- Production remains frozen. No production mutation is authorized.
- Work only in the isolated staging repository for this tranche.
- Do not run Bulldog or Reboot, make paid provider calls, deploy, redesign reports, add new DataForSEO endpoints, or implement the classifier during the raw-evidence gate.
- Do not declare a `raw` artifact sufficient merely because it is named raw; prove enough provider evidence survives for independent future reclassification.
- Preserve provider failure/partial/unavailable states; UNKNOWN must never become ABSENT or a negative finding.
- Preserve secrets/data minimization: raw evidence storage must exclude credentials, authorization headers, tokens, cookies/session secrets, and unnecessary personal information.
- Data acquisition is driven by defined evidence questions. Use DataForSEO where it closes the evidence question; use first-party sources for facts only first-party systems can establish.
- Service-sector content recommendations must never recommend publishing specific pricing or a pricing page.
- Named sites are regression/validation fixtures only.

Exact next action:
Run the prepared `GACM — PRYSM DATAFORSEO RAW EVIDENCE PRESERVATION GATE` in `C:\Users\kulba\Desktop\prysm-staging-isolated` from exact SHA `3e14fb869f590f6bcfc8f63f39194b4ca3d95698`. Stop after the proof gate. If it passes with sufficient raw preservation, the next tranche is one fresh Bulldog isolated-staging audit followed by external classification/second-verification analysis before any classifier or report code is changed.

Last verified:
2026-09-25
