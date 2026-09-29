# Current State

Project: PRYSM

Current objective:
Review the current isolated-staging PRYSM application manually with Chris, capture the complete set of product/report changes, then repair them through the governed generalized workflow. Technical staging closure remains incomplete until a current audit can generate current Snapshot V1 and Executive V2 outputs for Chris's manual browser review.

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
- Manual review of the current isolated-staging application and reports.
- Build one complete change/defect register from Chris's review before the next coding tranche.
- Technical staging closure so a current audit can produce hosted Snapshot V1 and Executive V2 outputs for manual acceptance.

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
Start the next chat from authoritative GitHub state, review the current isolated-staging app with Chris, capture the full set of desired changes/defects first, and build one governed defect register before making code changes. Do not use Codex browser acceptance and do not touch production.

Last verified:
2026-09-29
