# Decision: PRYSM Report Section Improvement System

Date: 2026-09-07
Status: Active

Decision:
Adopt `PRYSM_REPORT_SECTION_IMPROVEMENT_PROTOCOL.md` (RSIP) as the permanent governed workflow for report-page improvement.

Only one report section may be ACTIVE at a time. Every section must move through baseline audit, frozen contract, repair planning, bounded build, deterministic proof, real-report render, human review, and PASS/LOCK before the next section is activated.

A section passes only at >=95/100 on the universal RSIP scorecard with zero hard-gate failures and a successful human outcome review.

Reason:
Repeated report improvement without a frozen per-section contract and durable stage state risks subjective drift, reopening completed work, inconsistent proof standards, and chat-dependent continuity.

Implication:
Future PRYSM report improvement must recover `PRYSM_REPORT_SECTION_REGISTRY.md`, `PRYSM_REPORT_SECTION_STATE.json`, the active section artifacts, and `CURRENT_STATE.md` before substantive work. PASS_LOCKED sections may be reopened only under the evidence-based reopen rule in RSIP.