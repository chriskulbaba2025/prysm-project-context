# Decision: PRYSM GCU report improvement runs unattended tip-to-tail

Date: 2026-09-02
Status: Active

## Owner authorization

The owner authorizes the repository-controlled PRYSM report-improvement program in `PRYSM_GCU_REPORT_IMPROVEMENT_WORK_ORDER_2026-09-02.md` to run continuously through P0-P10 under Governed Coding Upgrade without per-tranche owner check-ins.

Normal governed diagnosis, Surgical Change Determinacy, bounded application edits, tests, local verification, dedicated repair-branch commits/pushes, governance-memory updates, Builder/Auditor switching, and progression to the next workstream are authorized when the applicable GCU gates pass.

The execution target is unattended repository-controlled completion, not unattended production release.

## Dedicated application branch

Autonomous application writes for this package are confined to:

`repair/prysm-report-improvement`

The Builder may create the branch from verified repository truth when required and may commit/push governed changes there. It must preserve pre-existing user work and may not reset, clean, checkout-overwrite, force push, or discard unrelated work to obtain a convenient baseline.

## No routine interruption

Do not stop merely for:
- completion of a normal diagnostic;
- a verified design gap/root cause whose Surgical Change Contract passes;
- completion of an implementation tranche;
- successful targeted/assembled-system verification;
- a normal independent audit PASS;
- progression from one workstream to the next.

When a tranche is independently PASSed, advance to the next required workstream automatically.

## Mandatory human/external stop boundaries

The autorun must stop and notify the owner when any of these is reached:
- a material cause remains `UNRESOLVED` after the shortest reasonable governed diagnostics;
- three evidence-based repairs against the same root defect are exhausted and a diagnostic reset cannot safely continue autonomously;
- a required external credential/access boundary is missing;
- a required paid provider/model call is needed;
- a required Model-Bearing Release Gate cannot be completed without new paid/live authorization;
- merge to application `main` is required;
- deployment, production configuration mutation, Railway/Vercel/AWS production mutation, or a new production audit is required;
- a destructive recovery/rollback action would be required;
- branch/repository state cannot be reconciled without risking unrelated user work;
- independent audit exposes a CRITICAL/MAJOR issue whose causal boundary cannot be safely repaired under the current work order;
- Codex/controller usage, protocol, authentication, or execution failure prevents safe continuation.

## Protected external authority

This decision does **not** authorize:
- merge to `main`;
- production deployment;
- Railway, Vercel, or AWS production mutation;
- production configuration changes;
- live/paid provider calls;
- live/paid Writer/Judge/model calls;
- a fresh production audit;
- destructive rollback or reset;
- force push.

Green verification never grants those authorities.

## Notification contract

Unattended operation uses two different signals:

### 1. Heartbeat — quiet health signal

The controller must maintain a local heartbeat at least once every 60 seconds while running.

Canonical local heartbeat:

`%LOCALAPPDATA%\PRYSM-Autorun-Report-Improvement\heartbeat.json`

The heartbeat must include at minimum:
- UTC/local timestamp;
- controller PID;
- run number;
- current Builder/Auditor role;
- current tranche/checkpoint when available;
- application HEAD;
- governance HEAD;
- current root-defect identity/repair level when available;
- latest run-log path;
- controller state (`RUNNING`, terminal status, or failure).

Heartbeat is informational only. It must not mutate application/governed production state.

### 2. Remote terminal/exception notification — interrupt only when useful

The controller may POST a small JSON payload to a generic webhook supplied through:

`PRYSM_AUTORUN_NOTIFY_WEBHOOK`

This webhook is an operational notification seam only. It may feed the owner's existing n8n -> Telegram notification pattern. It is **not** a PRYSM report-generation path and must never carry provider credentials, report artifacts, evidence payloads, or secrets.

Remote notification is sent only for:
- `BLOCKED`;
- `STOP` at a real external/authorization boundary;
- controller failure;
- `COMPLETE` repository-controlled completion.

Routine heartbeat ticks and normal tranche progress do not send messages.

If remote notification is required by the run command but the webhook is not configured/reachable at preflight, the long unattended loop must not start.

## Completion meaning

`COMPLETE` means:
- P0-P10 required repository-controlled work is exhausted or explicitly closed as not-applicable from evidence;
- every implementing tranche passed applicable direct proof, assembled-system/branch-complete proof, exact-candidate verification, and independent audit;
- applicable model-bearing proof was completed or the process stopped earlier at its protected external authorization boundary;
- the final combined repair-branch candidate was re-proven;
- governance is synchronized;
- the next protected production action is explicitly recorded.

`COMPLETE` does not mean merged/deployed unless separately authorized later.
