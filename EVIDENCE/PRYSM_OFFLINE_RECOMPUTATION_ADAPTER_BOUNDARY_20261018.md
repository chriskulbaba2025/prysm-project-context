# PRYSM offline recomputation adapter — scoped recovery after 01A BLOCKED (2026-10-18)

## Actual run result, not a failed fix
Telegram operator screenshot: run `prysm-20261018T220318291Z-PRYSM-FIDELITY-01A-CONTENT-b7f181`, time `2026-10-18T22:04:21.561Z`, state `BLOCKED` / `REPLAY_PROOF_UNAVAILABLE`. Targeted Node test with pre-execution fallback: 5 PASS, 0 FAIL. Existing 44/44 S3-export hash inventory PASS; **no tracked source edits**. Fresh source-to-classification recomputation and a new client render were not established. Do **not** reclassify this as repair PASS or simply rerun the identical command. Full local REPORT.md not independently inspected in chat; rely on screenshot for this summary.

## Missing link independently traced in accepted GitHub code
At app commit `bda9578029fda428e227bae774defb2e6c9a9809`:
- `services/worker/src/scoring/vantage-score.js` exports `scoreAudit(auditRequest, decisionEvidence, { capabilityEvidence, scoredAt })`: real deterministic score and finding producer.
- `services/worker/src/report-intelligence/semantic-ledger.js` exports `buildSemanticLedger({ scoreSet, findings, decisionEvidence, contentIdeas })`: recomputes current content decisions from the **actual candidate** score and evidence.
- `services/worker/src/report-model/current-model.js` exports `hydrateCurrentReportModel(...)` with real input hierarchy/invariant checks.
- `services/worker/src/report/render-report-current.js` calls v13 renderer; `render-narrative-v2.js` checks approved NDP and persisted Writer/Judge. A candidate incompatible with saved approved NDP must STOP; don't fake or reapprove it. No Writer call in offline diagnostics.
- Existing `services/worker/scripts/replay-report.js` loads `governed/canonical/...` and reuses the **stored** score/findings/Writer. Green replay is not evidence of fresh recomputation.
- City Media S3 export contains `objects\\tenants\\prysm-staging\\clients\\citymediacollective.com-city-media-collective\\audits\\77b14b11-e034-456a-be77-6650cc37cf4a\\canonical\\{audit-request,decision-evidence,capability-evidence,scores,findings}.json`, plus provenance, raw/normalized and published HTML.
- Existing run's controller `src/core.ts` enforces **no git commit, no push, exact clean accepted PRYSM SHA** at launch; local tracked edits would prevent the next authorized launch until a separate governed commit/controller authority update. To avoid that repeat blocker, build and test the initial diagnostic adapter only in already gitignored `C:\g\p001\.governance\evidence\...\scratch\`, keep source repo CLEAN.

## Scoped next step: PRYSM-FIDELITY-01A-ADAPTER
Create a **test-only offline adapter** in the existing gitignored scratch folder, not tracked code, and using exact frozen input bytes (read-only). On first activity run `node --test src/report-intelligence/semantic-ledger.test.js` in services/worker to satisfy 150s watchdog; use `--test-isolation=none` only for pre-execution `spawn EPERM`.

In adapter:
1. Verify frozen 44 SHA-256 hashes, strict tenant/client/audit IDs, content hash and declared review input. Map source bytes in memory or scratch (never edit originals). No network shell, provider, re-crawl, LLM, browser or S3 writes.
2. Call the production pure deterministic `scoreAudit` on the frozen `audit-request` + `decision-evidence` + `capability-evidence` using stored `scores.generatedAt`, record candidate scoreSet/findings in *new scratch outputs*. Do not rely on old persisted scores for PASS. Compare deterministic output to stored original to establish parity and trace drift; differences are evidence, not automatic regressions.
3. Call `buildSemanticLedger` on this new result and real evidence with current `contentIdeas`. Independently compare content 12 rows, status/action axes, source completeness, audit identity; output machine-readable differential and expected erroneous 10 labels. Don't repair or backfill missing IDs; if truthful identity binding is absent from consumer, classify HOLD and identify narrow caller change.
4. If model invariants can be satisfied from recomputed state, build a *new* v13 content-page output through the real renderer. If saved NDP/Writer is incompatible, do not bypass publication guards; use deterministic content projection as diagnostic only, mark CLIENT_OUTPUT HOLD and specify next interface.
5. Run a genuinely dissimilar source-based TBK fixture as regression. Require SOURCE_BYTES, RECALCULATION, CONTENT_ACCURACY, SOURCE_CONTROL, CLIENT_OUTPUT separate statuses. Explicitly identify defects to fix in next tracked-source tranche, including clean-repo commit/controller SHA transition.
6. Keep app tree and controller untouched/CLEAN and all originals immutable. Write `PROOF.md`, `REPORT.md` and reproducibility details to the named Downloads proof folder; max three unsuccessful attempts.

**Acceptance of this tranche:** Offline adapter demonstrably runs real source classification and emits new candidate files from frozen inputs, or holds on a specific mismatched contract. No claim the known logic defects are repaired. Subsequent narrow content tracked-code repair and promotion are distinct boundaries, with explicit controller authority synchronization required.
