# Current State

Project:
PRYSM — governed website conversion-readiness report and website decision system

## Current objective

Begin P5 Structured Data / Entity Evidence Verification with requirement preservation and diagnostic-first evidence, then continue the unattended P0-P10 program only when each governed tranche passes.

The owner does not want routine tranche-by-tranche attendance.

## Verified production checkpoint

Application repository:
`chriskulbaba2025/vantage-platform`

Production branch:
`main`

Exact deployed and independently audited production SHA:
`9b9e85d00a0d8b65a5ba6cad37583aa79151b15e`

PDV5:
**PASS / CLOSED**

Narrative v2:
**114/114 PASS**

Whole-App Branch Coverage Gate:
**87/87 PASS**

Required branches:
**P-B01 through P-B15 PASS**

Independent Auditor:
**PASS — zero material defects**

Railway deployment:
**SUCCESS / RUNNING**

Final live production validation:
**PASS**

Controlled audit:
`8d22e6b9-9246-4fb2-9f65-4cfc97a5b9e3`

## Trusted local rollback checkpoint — VERIFIED

Before Codex/GCU report-improvement work, the owner created a local safety backup from:

`C:\Users\kulba\Desktop\vantage-platform`

Its `STARTING-SHA.txt` was directly verified as:

`9b9e85d00a0d8b65a5ba6cad37583aa79151b15e`

Durable record:
`PRYSM_LOCAL_SAFETY_BACKUP_CHECKPOINT_2026-09-02.md`

The exact timestamped Desktop backup directory was not supplied and must not be guessed. Locate it by matching `PRYSM-SAFETY-BACKUP-*` and the verified SHA if restoration is ever explicitly authorized.

## Team report-improvement requirements — COLLATED

Governing work order:
`PRYSM_GCU_REPORT_IMPROVEMENT_WORK_ORDER_2026-09-02.md`

Primary product principle:

`An observation is not yet intelligence.`

Where evidence permits:

`what was found -> where -> why it matters -> what to do -> how to verify`

Where evidence does not permit a conclusion:

`what cannot be determined -> what is missing -> how to obtain/enable it -> what additional insight would then become possible`

Mandatory workstream order:
P0 through P10 as defined by the work order.

## GCU / Codex execution — UNATTENDED AUTHORIZED

Base decision:
`DECISION_PRYSM_GCU_CODEX_REPORT_IMPROVEMENT_2026-09-02.md`

Unattended authorization:
`DECISION_PRYSM_GCU_UNATTENDED_REPORT_IMPROVEMENT_AUTORUN_2026-09-02.md`

Canonical GCU repository:
`chriskulbaba2025/governed-coding-upgrade-skill`

Protocol target:
`v2.4.0 — Verification Integrity`

Codex may automatically progress through normal repository-controlled GCU work, including diagnosis, Surgical Change Contracts, bounded application edits, verification, dedicated repair-branch commits/pushes, governance synchronization, independent-context Auditor review, bounded repair after audit findings, and progression to the next workstream.

Application writes are confined to:
`repair/prysm-report-improvement`

Do not create a second report-generation source of truth in n8n.

## Current tranche

`P5 — Structured Data / Entity Evidence Verification`

P5 diagnostic evidence is verified at application candidate `28b25f64e3140968842cfdec265b9583e1c995d9`.
Durable evidence: `DIAGNOSTIC_P5_STRUCTURED_DATA_ENTITY_EVIDENCE_2026-09-02.md`.
Classification: `VERIFIED_ROOT_CAUSE` `P5_SCHEMA_TYPE_ALIAS_LEAK` for provider token `json_ld` being surfaced as a schema/microdata type; separate `VERIFIED_DESIGN_GAP` for the absence of typed, provenance-bearing location/entity observations in the normalized contract. No historical missed-location claim is made.

Initial P0 condition remains diagnostic-first. P0 must first classify the evidence boundary as:
- `VERIFIED_ROOT_CAUSE`;
- `VERIFIED_DESIGN_GAP`;
- or `UNRESOLVED`.

Required acceptance artifact:

`Selected URL | selection reason | page class | body requested | body returned/status | downstream modules`

The later unattended owner authorization supersedes the earlier requirement to stop after the P0 Surgical Change Contract. If P0 proves a repairable root cause/design gap and the GCU Surgical Change Determinacy Gate passes, the Builder may implement and prove the bounded P0 correction autonomously on the dedicated repair branch, then hand it to the Auditor.

P3 prompt/content-strategy tuning remains blocked until P0 proves or repairs the upstream page-selection/deep-content boundary.

## P0 candidate ready for independent audit

Classification: **VERIFIED_DESIGN_GAP** — frozen TBK evidence retains body observations but not the selection/reason/class/request-to-response ledger needed to determine why that sample was selected. No historical selection defect is claimed.

Application candidate:
`repair/prysm-report-improvement` at `acfc5c1393261bb7733837289bc3adc1062e64d5` (remote equals local; clean tree).

Bounded P0 change:
`services/worker/src/adapters/dataforseo-onpage/dataforseo-onpage-adapter.js` now retains an additive deep-content trace with selection reason, page class, request state, returned/unavailable status, and direct consumers. It does not alter selection ranking, historical evidence, report rendering, prompts/models, provider policy, n8n, or deployment.

Durable evidence:
- `DIAGNOSTIC_P0_DEEP_CONTENT_PAGE_SELECTION_TRACE_2026-09-02.md`
- `SURGICAL_CHANGE_P0_DEEP_CONTENT_PAGE_SELECTION_TRACE_2026-09-02.md`

Verification at the exact candidate:
- direct selector/adapter/programmatic-analysis proof: **19/19 PASS**;
- Whole-App gate: **87/87 PASS**, P-B01 through P-B15 covered;
- no live provider/model calls; Model-Bearing Release Gate: **N/A**.

## Current execution status

P4 independently **PASSED** at application SHA `28b25f64e3140968842cfdec265b9583e1c995d9` with zero material findings. Durable audit: `INDEPENDENT_AUDIT_P4_COMPETITOR_QUALIFICATION_REPAIR_3_PASS_2026-09-02.md`. Independent exact-candidate proof: focused producer/qualification **44/44 PASS**; direct P-B16 assembled gate **PASS**; worker regression **975/975 PASS**; Narrative v2 **114/114 PASS**; Whole-App base **87/87 PASS** with P-B01 through P-B16 covered. The query topic remains discovery metadata and cannot substitute for competitor-observed service evidence. No live provider/model calls occurred; Model-Bearing Release Gate is N/A. P4 repair accounting is reset.

P5 begins diagnostic-first. It must trace actual structured-data/entity acquisition, normalization, persistence, validated read/reopen, consumer, and rendered output; determine whether `json_ld` is incorrectly surfaced as a type; preserve actual schema types; and investigate visible location/market evidence and rendered/include/component acquisition before any copy change.

P4 repair-3 candidate is ready for independent audit at application SHA `28b25f64e3140968842cfdec265b9583e1c995d9` (remote equals local; clean tree). SERP query topic is now separate from competitor-observed service/business evidence: the producer preserves returned title with explicit provenance, and qualification uses only that observed field. Exact-candidate proof passed: focused qualification/producer 44/44, worker 975/975, Narrative v2 114/114, and Whole-App P-B01 through P-B16. Durable evidence: `EVIDENCE_P4_COMPETITOR_QUALIFICATION_REPAIR_3_CANDIDATE_2026-09-02.md`. No live provider/model calls occurred; Model-Bearing Release Gate is N/A. Production remains protected SHA `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e`.

P3 independently **PASSED** at application SHA `34f47cb35dd7dba39aa488408d1da1242b66dc25` with zero material findings. Durable audit: `INDEPENDENT_AUDIT_P3_TOPICAL_MAP_STRATEGIC_CONTENT_INTELLIGENCE_REPAIR_PASS_2026-09-02.md`. Independent exact-candidate proof: schema **14/14 PASS**; focused producer/current-consumer/render/Narrative-reference proof **27/27 PASS**; worker regression **970/970 PASS**; Narrative v2 **114/114 PASS**; Whole-App Gate **87/87 PASS** with P-B01 through P-B15 covered. The prior MAJOR fixture/contract false-PASS seam is closed: a valid persisted ScoreSet with a complete evidence-grounded `contentIdeas` projection validates, while materially incomplete rows reject. No live provider/model calls occurred; Model-Bearing Release Gate is N/A. P3 repair accounting is reset.

P4 begins diagnostic-first. It must verify the current comparator/competitor qualification boundary for service/business similarity, geographic relevance, customer/audience similarity, and actual commercial overlap. Where confidence is insufficient, it must retain a bounded comparator/confirmation state rather than promote a competitor silently. P4 must not implement P8 consultant confirm/reject controls by scope creep.

P3 repair candidate is ready for independent re-audit at application SHA `34f47cb35dd7dba39aa488408d1da1242b66dc25` (remote equals local; clean tree). The same-root audit finding was repaired solely by completing the governed valid `score-current` fixture with a schema-valid, evidence-grounded `contentIdeas` projection. Current ScoreSet/ViewModel schemas govern enriched rows and reject materially incomplete rows. Exact-candidate proof: schema 14/14; focused producer/current-consumer/render/Narrative-reference proof 25/25; worker regression 970/970; Narrative v2 114/114; Whole-App Gate 87/87 with P-B01 through P-B15 covered. No live provider/model calls occurred; Model-Bearing Release Gate is N/A.

P3 diagnostic-first classification is **VERIFIED_DESIGN_GAP** at application SHA `a2c54692ce231c34e4f693a6bb34ed3db527d1d6`. Durable evidence: `DIAGNOSTIC_P3_TOPICAL_MAP_STRATEGIC_CONTENT_INTELLIGENCE_2026-09-02.md`. The authoritative worker regression passed **968/968** with no live provider/model calls. The gap is in the deterministic `contentIdeas` producer/contract/consumer projection: it emits mostly fixed templates and does not carry per-opportunity current evidence, gap basis, recommended asset/location, or explicit evidence status. No application files were edited during diagnosis.

P1 independently **PASSED** at application SHA `9a1612c7e2388297120d5196b0be099762c97e2b` with zero material findings. Durable audit: `INDEPENDENT_AUDIT_P1_CROSS_REPORT_CONTRADICTION_INTEGRITY_REPAIR_2026-09-02.md`. Independent direct proof was **54/54 PASS**, including persisted/tampered/missing-projection behavior; Whole-App gate was **87/87 PASS**, P-B01 through P-B15 covered. The model-bearing gate was N/A and no live provider/model calls occurred. P1 root repair accounting is reset.

P2 independently **PASSED** at application SHA `a2c54692ce231c34e4f693a6bb34ed3db527d1d6` with zero material findings. Durable audit: `INDEPENDENT_AUDIT_P2_CLIENT_INTELLIGENCE_OUTPUT_CONTRACT_2026-09-02.md`. Direct renderer/conversion proof was **61/61 PASS**, worker regression **968/968 PASS**, and Whole-App Tranche Gate **87/87 PASS** with P-B01 through P-B15 covered. Model-Bearing Release Gate was N/A; no live provider/model calls occurred. P2 repair accounting is reset.

P3 begins diagnostic-first. It must establish whether current governed content opportunities can be made site-specific and actionable from the P0-proven selection/deep-content evidence boundary, or whether the remaining limitation is an explicit evidence/capability gap. No prompt/model behavior or content strategy may change merely to improve prose. Any model-bearing change requires the applicable Model-Bearing Release Gate; paid/live model execution remains protected.

P0 independently **PASSED** at application SHA `acfc5c1393261bb7733837289bc3adc1062e64d5` with zero material findings. Durable audit: `INDEPENDENT_AUDIT_P0_DEEP_CONTENT_PAGE_SELECTION_TRACE_2026-09-02.md`. The direct gate was **19/19 PASS** and Whole-App gate **87/87 PASS** (P-B01 through P-B15). Historical TBK selection reason/class remains `NOT_RECORDED`; it has not been reconstructed.

P1 repair attempt 1 is complete at application SHA `9a1612c7e2388297120d5196b0be099762c97e2b`. The independent audit finding against the prior candidate was verified: the projection was omitted from ScoreSet/ViewModel persistence paths and report consumers could reconstruct it. The bounded correction persists the projection for normal and Not-Assessed score models, requires it at current hydration, carries it through the ScoreSet/ViewModel and v2 assembly paths, and makes affected consumers fail closed rather than re-derive it.

Exact-candidate proof: worker regression **965/965 PASS**; direct missing/tampered projection and consumer/render proofs PASS; Whole-App Tranche Gate **PASS**, 87/87 with P-B01 through P-B15; Writer/Narrative/replay parity PASS; zero live provider/model calls. Model-Bearing Release Gate: N/A (no prompts/model inputs changed).

The current workstream is **P3 — Topical Map / Strategic Content Intelligence**, ready for Builder diagnostic-first work.

## Heartbeat and notification

The current workstream is **P5 — Structured Data / Entity Evidence Verification**, ready for Builder diagnostic-first work.

Dedicated controller:
`tools/report-improvement-autorun/PRYSM-REPORT-IMPROVEMENT-AUTORUN.ps1`

Builder prompt:
`tools/report-improvement-autorun/PRYSM-REPORT-IMPROVEMENT-BUILDER-PROMPT.md`

Auditor prompt:
`tools/report-improvement-autorun/PRYSM-REPORT-IMPROVEMENT-AUDITOR-PROMPT.md`

Heartbeat:
`%LOCALAPPDATA%\PRYSM-Autorun-Report-Improvement\heartbeat.json`

Default heartbeat interval:
**60 seconds**

Remote notification seam:
`PRYSM_AUTORUN_NOTIFY_WEBHOOK`

Recommended route:
`controller -> n8n webhook -> Telegram`

The webhook is operational notification only and must not become part of report generation or receive report/evidence payloads/secrets.

Routine progress and heartbeat ticks do not message the owner. Remote messages are reserved for `STOP`, `BLOCKED`, controller failure, and repository-controlled `COMPLETE`.

## Protected external authority — STILL REQUIRED

Unattended authorization does **not** authorize:
- merge to application `main`;
- production deployment;
- Railway/Vercel/AWS production mutation;
- production configuration mutation;
- new paid/live provider calls;
- new paid/live Writer/Judge/model calls;
- a fresh production audit;
- destructive rollback/reset;
- force push.

The autorun must stop and notify when one of those actions becomes genuinely necessary.

## Exact next action

Builder must freeze the P5 Surgical Change Contract for the smallest deterministic producer/contract/consumer correction: filter provider category aliases such as `json_ld` from actual schema type collections, preserve actual schema.org types, and decide whether existing acquisition data justifies a typed location/entity evidence field. Then implement/prove only the contracted surface. No live call, model change, merge, or deployment is authorized.

## Protected invariants

- Preserve evidence humility; unavailable/partial evidence is not a negative finding.
- Preserve ranked Priority Fix architecture.
- Preserve explicit limitations and restrained business-consequence language.
- Do not mask upstream evidence defects with copy changes.
- Do not modify n8n merely to restructure/improve report output.
- Preserve canonical evidence and existing production truth unless a separately proven and authorized workstream requires change.
- Model/prompt-bearing changes require applicable PRYSM/GCU Model-Bearing Release proof; paid/live model execution remains separately protected.
- Three failed same-root repair attempts require diagnostic reset/stop according to GCU; no fourth same-root autonomous repair.
- Exact-candidate proof becomes stale if governed candidate content changes afterward.

## Last verified

2026-09-02 America/Toronto — P5 diagnostic classified verified root cause `P5_SCHEMA_TYPE_ALIAS_LEAK` and verified design gap for typed location/entity evidence at application candidate `28b25f64e3140968842cfdec265b9583e1c995d9`. Durable record: `DIAGNOSTIC_P5_STRUCTURED_DATA_ENTITY_EVIDENCE_2026-09-02.md`. Next action is Surgical Change Contract freeze; production remains protected SHA `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e`.

2026-09-02 America/Toronto — independent audit **PASSED** P4 repair-3 candidate `28b25f64e3140968842cfdec265b9583e1c995d9` with zero material findings. Focused proof passed 44/44, worker 975/975, Narrative v2 114/114, and Whole-App base 87/87 with P-B01 through P-B16 covered. Durable record: `INDEPENDENT_AUDIT_P4_COMPETITOR_QUALIFICATION_REPAIR_3_PASS_2026-09-02.md`. P5 is next for Builder diagnostic-first work; production remains protected SHA `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e`.

2026-09-02 America/Toronto — Builder repaired P4-MAJOR-03 at exact application candidate `28b25f64e3140968842cfdec265b9583e1c995d9`, pushed the clean branch, and completed exact-candidate proof: focused 44/44, worker 975/975, Narrative v2 114/114, Whole-App P-B01 through P-B16 PASS. The accounting-title/physiotherapy-query producer case now fails service relevance; an explicitly observed physiotherapy service signal remains positive-path compatible. Candidate awaits independent audit. Production remains protected SHA `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e`.

2026-09-02 America/Toronto — independent audit **FAILED** P4 repair candidate `de94a30426c3fd4c81e8fda0753bf12e6cc09535` with MAJOR `P4-MAJOR-03`. The current SERP producer copies client query topic into `candidate.topic`, and the common qualification contract accepts it as service relevance without competitor-observed service/business evidence. A deterministic accounting-result/physiotherapy-query counterexample passes all five checks. Durable record: `INDEPENDENT_AUDIT_P4_COMPETITOR_QUALIFICATION_REPAIR_3_FAIL_2026-09-02.md`. Same root `P4_COMPETITOR_QUALIFICATION_UNGROUNDED`; repair attempt remains controller-provided `1`. Production remains protected SHA `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e`.

2026-09-02 America/Toronto — Builder repaired same-root P4-MAJOR-02 at `de94a30426c3fd4c81e8fda0753bf12e6cc09535`, pushed it to `origin/repair/prysm-report-improvement`, and synchronized P4 evidence. Direct 24/24, SERP adapter 101/101, worker 975/975, Narrative v2 114/114, and Whole-App P-B01–P-B16 PASS. The candidate awaits independent audit; production remains protected SHA `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e`.

2026-09-02 America/Toronto — independent audit **FAILED** P4 repair candidate `cc4f0c3a8800f568a8e5949288feeadf494790a5` with MAJOR `P4-MAJOR-02`. The candidate fail-closes incomplete supplied URLs but leaves SERP candidates qualified from query locale and inferred page type without competitor-observed geography, audience, or commercial evidence. Durable record: `INDEPENDENT_AUDIT_P4_COMPETITOR_QUALIFICATION_REPAIR_2_FAIL_2026-09-02.md`. Same root `P4_COMPETITOR_QUALIFICATION_UNGROUNDED`; repair attempt remains controller-provided `1`. Production remains protected SHA `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e`.

2026-09-02 America/Toronto — P4 same-root repair candidate `cc4f0c3a8800f568a8e5949288feeadf494790a5` has exact deterministic proof and is ready for independent audit. Production remains protected SHA `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e`.

2026-09-02 America/Toronto — P3 independently PASSED at repair candidate `34f47cb35dd7dba39aa488408d1da1242b66dc25`; P4 is next for Builder diagnostic-first work. Production remains protected SHA `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e`.

2026-09-02 America/Toronto — P3 same-root repair candidate `34f47cb35dd7dba39aa488408d1da1242b66dc25` is ready for independent re-audit; all required deterministic exact-candidate proof passed. Production remains protected SHA `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e`.
