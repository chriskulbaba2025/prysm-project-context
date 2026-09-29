# Current State

Project: PRYSM

Current objective:
Execute the frozen generalized semantic-process repair series defined in `DECISION_PRYSM_GENERALIZED_SEMANTIC_PROCESS_REPAIR_FREEZE_2026-09-29.md`. The repair target is the PRYSM decision pipeline itself—evidence taxonomy, reconciliation, content coverage decisioning, comparative evidence coherence, provenance/action scope, score/label semantics, priority governance, and client-language QA—not any named site or report.

Verified checkpoint:
- Context repository: chriskulbaba2025/prysm-project-context.
- Isolated staging application: chriskulbaba2025/prysm-staging-isolated.
- Branch: repair/prysm-bulk-closure-20260927.
- PR #6 is open; GitHub head verified at ca3dabf0f59f8fe62e4c2a73766d6f12e9999e01.
- Production remains untouched.
- Snapshot V1 and Executive V2 are the active report products.
- Retired Vantage/Karen Leslie/approved-report/report-design-v1 products remain retired and must fail closed.
- The fresh-audit report-design default defect was repaired so current Executive uses designVersion 2.0.0.
- Existing Burlington audit a493b3d2-5d1b-458f-903a-8bf0d4b71c6e preserves its evidence and reached narrative_ready, but its hosted historical state still shows render_failed with render-retired-report-design-requested; hosted recovery was not completed.
- Codex browser/browser-automation acceptance is prohibited. Chris performs final visual acceptance manually in his own signed-in browser.
- Generalized semantic process repair baseline is frozen at application SHA `ca3dabf0f59f8fe62e4c2a73766d6f12e9999e01`.
- Governing freeze/tranche decision: `DECISION_PRYSM_GENERALIZED_SEMANTIC_PROCESS_REPAIR_FREEZE_2026-09-29.md`.
- Named regression sites are fixtures only; implementation must target generalized owning boundaries.

Current environment / branch / version:
- Context repo: chriskulbaba2025/prysm-project-context
- Staging app: chriskulbaba2025/prysm-staging-isolated
- Production app: chriskulbaba2025/vantage-platform
- Branch: repair/prysm-bulk-closure-20260927
- PR: #6
- GitHub PR head: ca3dabf0f59f8fe62e4c2a73766d6f12e9999e01
- Existing Burlington audit: a493b3d2-5d1b-458f-903a-8bf0d4b71c6e
- Report products: Snapshot V1 / Executive V2
- Required Executive designVersion: 2.0.0

Completed:
- Legacy report renderer retirement remains enforced.
- Generic fresh-audit report-design default was repaired away from retired designVersion 1.0.0.
- Retired and unknown report identifiers remain fail-closed.
- Local recovery path for the Burlington audit was proven without provider recollection, but hosted recovery was not executed.
- PR #6 head is verified current at ca3dabf0f59f8fe62e4c2a73766d6f12e9999e01.
- Production remains untouched.

In progress:
- GACM Tranche G0: read-only map of the full decision pipeline and owning contracts for the frozen process-level defect families P1-P9.
- Freeze permitted/prohibited boundaries and proving checks before any application edits.
- Subsequent bounded tranches G1-G7 repair generalized process boundaries; G8 is Chris's manual signed-in staging retest.

Blocked:
- The existing Burlington hosted artifact is still historical render_failed and is not acceptance proof.
- Human visual acceptance cannot occur until current hosted report URLs are available.
- Codex browser/browser automation may not be used as a substitute for Chris's manual review.

Important constraints:
- GitHub is authoritative; do not reconstruct current state from chat when GitHub disagrees.
- Production is read-only unless Chris explicitly authorizes mutation.
- Fix generalized owning boundaries only; named sites/audits are regression evidence, never implementation targets.
- Preserve UNKNOWN/PARTIAL/UNAVAILABLE/FAILED/NOT_CONNECTED distinctions and evidence provenance.
- Do not revive or alias retired report code.
- Snapshot V1 and Executive V2 remain separate current products over the same governed evidence.
- Executive V2 must identify as designVersion 2.0.0.
- Codex browser, browser automation, Playwright-as-human-acceptance, screenshots-as-acceptance, and requests for Chris to connect a browser session to Codex are prohibited.
- Chris performs final visual/browser acceptance manually in his normal authenticated browser.
- Long GACM/Codex runs require full preflight, proof under the established Downloads proof-folder rule, and desktop plus audible completion notification.
- Maximum three failed repairs in one defect family before diagnosis reset.

Exact next action:
Run GACM Tranche G0 from the frozen baseline: recover exact application/context state, map Producer -> canonical evidence -> classification -> reconciliation -> score -> prioritization -> Executive/Snapshot projection, identify the owning contracts for P1-P9, and freeze the implementation/test boundary. Make no product code changes in G0 and do not touch production.

Last verified:
2026-09-29
