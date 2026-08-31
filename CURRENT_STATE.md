# Current State

Project:
PRYSM — governed website conversion-readiness report and website decision system

Current objective:
T4 Replay, ReportContent, and semantic-coherence closure — BLOCKED after Level-3 proof failure.

Verified checkpoint:
- Application repository: `chriskulbaba2025/vantage-platform`.
- Remote application `main` baseline remains `e7e8477819f8bff0a7e3f0c5969637df9fb787a3` — `fix(prysm): close governed report integrity repairs`.
- Autonomous application repair branch: `repair/prysm-production-closure`.
- T0 PASS.
- T1 PASS by independent Auditor on exact candidate SHA `192326cbf1e3d732a3e7132cfe33e2d7c931b0fe`.
- T2 candidate `4f03947517beec98c54dedf028bcc79f8771c7ae` independently PASSed after the ReportViewModel current-contract migration and base/Narrative/replay parity proof.
- AUD-T2-002 then exposed the next material boundary: the base consumer had previously avoided canonical current hydration by reconstructing a ScoreSet-shaped object without current contract identity. Preserving the current persisted object correctly activates `rootCauseRuleId` and `decisionHierarchy` in `buildReportViewModel()`.
- Focused Level-3 T2 proof passed 5/5, but assembled `node scripts/acceptance-prysm.js` failed closed because the current hydrated ReportViewModel emitted those current governed fields while still declaring `contractVersion: 1.0.0`; the frozen v1 ReportViewModel schema has `additionalProperties: false` and does not define them.
- `DECISION_REPORTVIEWMODEL_V2_CURRENT_CONTRACT_2026-08-31.md` resolves the owner-guided process reset: current production rendering must use a truthfully versioned current ReportViewModel contract; v1 remains historical/compatibility-only. Do not strip or adapt away current hierarchy/root-cause semantics merely to satisfy v1.
- The central AJV validator supports registering multiple schemas by stable versioned `$id`, so the current-contract migration fits the existing contract architecture.
- The application tree intentionally contains the preserved uncommitted Level-3 T2 repair plus generated evidence. It must not be reset, cleaned, overwritten, or discarded.

Current environment / branch / version:
- Application remote baseline: `main` at `e7e8477819f8bff0a7e3f0c5969637df9fb787a3`.
- Autonomous application repair branch: `repair/prysm-production-closure`.
- Last committed T2 candidate SHA before the preserved dirty repair: `0bc6cfa758b7c6c20efd2f01ae3b3485ea540fbe`.
- Current autonomous tranche: T4.
- Autorun status: CONTINUE.
- Governed repair attempt: 0 / Luna for T4.
- Last passed tranche: T3.
- Governed viewer: Viewer v2.2.0.
- Scoring version remains `4.1.1`.
- Current Narrative WriterOutput version: `1.0.0`.
- Current Writer prompt version: `2.1.0`.
- Current Judge contract version: `1.1.0`.
- Current Judge prompt version: `2.1.0`.

Completed:
- Deep systemic production-closure diagnosis and T0 recovery/inventory are complete.
- Cheap-first Luna -> Terra -> Sol escalation policy is active.
- T1 persisted Conversion-First hierarchy / ScoreSet closure is independently PASS.
- T2 AUD-T2-001 replay canonical-hydration repair reached a pushed candidate and exact-SHA gate proof.
- T2 Level-3 failure was diagnosed to the ReportViewModel contract-version boundary rather than treated as another local hydration defect.
- Owner-guided process reset selected the versioned current ReportViewModel migration as the canonical architecture.
- T3 candidate `e9c744d7024ce1af7da3c7b0e25ff67a4bc122a1` aligns stale Judge-version fixtures with the governed 1.1.0/2.1.0 Judge contract and repairs minimal fixtures to include required persisted hierarchy; Narrative v2 98/98, acceptance, and Whole-App Gate pass.
- T4 candidate `e0c2ab93481b9c4681da464cf4310e214edc25b2` makes historical Judge 1.0.0/2.0.0 replay explicitly compatibility-only and requires current replay artifacts to carry ScoreSet 2.0.0 plus persisted root-cause identity and decision hierarchy. Targeted replay/parity proofs and the exact-SHA Whole-App Gate pass.

In progress:
- T4: split current replay from historical compatibility replay, preserve source-state uncertainty in ReportContent, reject stale current artifacts, and consume the canonical current hydration boundary.
- AUD-T4-002 proof work is preserved uncommitted in `services/worker/scripts/replay-report-cli.test.js`. It adds a current CLI subprocess scenario by migrating the persisted ScoreSet boundary in a temporary fixture. The CLI reaches current validation/rendering but finalization correctly rejects three stale semantic contradictions: unavailable competitor allowlist provenance, `imagesMissingAlt` 222 with `imageCount` 0, and VAN-TECH-002 converting PARTIAL evidence into an unqualified absence claim.

Blocked:
- The AUD-T4-002 false-PASS proof defect has exhausted the governed Level-3 repair/proof attempt. A fourth autonomous repair is prohibited. Owner-guided process reset must choose a trustworthy current fixture source: generate artifacts through deterministic production composition, or govern a full semantic migration of the historical fixture rather than patching the nearest contradictions.
- Application merge to `main`, deployment/production configuration mutation, live/paid provider calls, live/paid Writer/Judge calls, and starting a fresh production audit remain unauthorized.

Important constraints:
- GitHub governance is authoritative durable project memory, but valid uncommitted local application work must be preserved and reconciled rather than overwritten.
- Never reset hard, clean, checkout-overwrite, discard, or force-push the local application repair work.
- Do not weaken or remove current `rootCauseRuleId` / `decisionHierarchy` semantics to fit the frozen v1 ReportViewModel schema.
- ReportViewModel data-contract versioning is separate from report-design versioning; do not redesign the renderer merely to close this schema migration.
- Newly proven materially different root causes reset model escalation; same-root-defect failures still permit at most Luna -> Terra -> Sol, then BLOCKED.
- UNKNOWN / UNAVAILABLE / PARTIAL / not-deeply-parsed must never become absence, false, zero, empty, Complete, AVAILABLE, or fully assessed unless governed evidence establishes that state.
- No application-changing tranche advances on targeted tests alone. Exact-SHA Whole-App Tranche Gate evidence plus independent Auditor PASS is mandatory.
- For material diagnostic output intended for review, write a named `.txt` evidence file rather than relying on terminal scrollback.
- No paid provider/model call, production audit, deployment, production configuration mutation, or production persistence mutation without explicit authorization.

Exact next action:
Owner-guided root-cause/process reset for AUD-T4-002. Preserve the dirty application proof work and do not attempt a fourth autonomous repair.

Last verified:
2026-08-31 America/Toronto — T2 candidate 4f03947517beec98c54dedf028bcc79f8771c7ae pushed; Whole-App Tranche Gate PASS.
