# Current State

Project:
PRYSM — governed website conversion-readiness report and website decision system

## Current objective

Run the team-driven PRYSM report-improvement program **unattended tip-to-tail through P0-P10** using Codex under Governed Coding Upgrade (GCU), with Builder/Auditor switching, a local heartbeat, and remote notification only for genuine terminal/exception boundaries.

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

`P0 — Deep-content/page-selection evidence trace`

Initial P0 condition remains diagnostic-first. P0 must first classify the evidence boundary as:
- `VERIFIED_ROOT_CAUSE`;
- `VERIFIED_DESIGN_GAP`;
- or `UNRESOLVED`.

Required acceptance artifact:

`Selected URL | selection reason | page class | body requested | body returned/status | downstream modules`

The later unattended owner authorization supersedes the earlier requirement to stop after the P0 Surgical Change Contract. If P0 proves a repairable root cause/design gap and the GCU Surgical Change Determinacy Gate passes, the Builder may implement and prove the bounded P0 correction autonomously on the dedicated repair branch, then hand it to the Auditor.

P3 prompt/content-strategy tuning remains blocked until P0 proves or repairs the upstream page-selection/deep-content boundary.

## Heartbeat and notification

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

1. Configure the notification webhook in the local PowerShell environment if remote Telegram messaging is required:

`$env:PRYSM_AUTORUN_NOTIFY_WEBHOOK = "<n8n webhook URL>"`

2. From the local `prysm-project-context` root, run the dedicated preflight with `-RequireRemoteNotification`.

3. Only after `PREFLIGHT PASS`, launch the unlimited unattended controller with `-MaxRuns 0`.

Run commands are documented in:
`tools/report-improvement-autorun/README.md`

No Railway, Vercel, AWS, DataForSEO, or paid-model credential is required simply to begin repository-controlled P0-P10 work. If a later tranche truly reaches one of those protected boundaries, the controller stops and notifies rather than guessing permission.

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

2026-09-02 America/Toronto — production remains verified at SHA `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e`; final live-production validation is PASS; the trusted local pre-GCU safety backup is recorded at the same SHA; the P0-P10 team work order is frozen; and the owner has now authorized unattended repository-controlled Codex/GCU execution with 60-second heartbeat and remote terminal/exception notification. The exact next action is notification-webhook configuration plus dedicated autorun preflight, then unlimited execution after `PREFLIGHT PASS`.