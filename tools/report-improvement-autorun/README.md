# PRYSM GCU Report Improvement — Unattended Autorun

This controller runs the governed P0-P10 report-improvement program continuously across fresh Codex invocations.

It reuses the proven PRYSM Builder/Auditor loop pattern but is specific to the report-improvement work order and adds:
- unattended progression through normal GCU tranche gates;
- 60-second local heartbeat;
- generic remote terminal/exception webhook;
- dedicated application branch `repair/prysm-report-improvement`;
- protected stop boundaries for production/paid/external authority.

## What it may do automatically

Under the owner authorization in `DECISION_PRYSM_GCU_UNATTENDED_REPORT_IMPROVEMENT_AUTORUN_2026-09-02.md`, Codex may:
- diagnose P0-P10;
- freeze Surgical Change Contracts;
- make causally bounded application changes on `repair/prysm-report-improvement`;
- run targeted, contract, branch-complete, whole-app and exact-candidate verification as required;
- commit/push the dedicated repair branch;
- update/push PRYSM governance;
- alternate Builder and independent-context Auditor;
- repair bounded audit findings;
- advance automatically to the next workstream after audit PASS.

## What remains protected

The controller must stop before:
- merge to `main`;
- production deployment;
- Railway/Vercel/AWS production mutation;
- production config changes;
- new paid/live provider/model calls;
- fresh production audit;
- destructive rollback/reset/force push.

## Notification design

### Heartbeat

While the controller is running it updates:

`%LOCALAPPDATA%\PRYSM-Autorun-Report-Improvement\heartbeat.json`

approximately every 60 seconds.

Quick heartbeat check:

```powershell
Get-Content "$env:LOCALAPPDATA\PRYSM-Autorun-Report-Improvement\heartbeat.json" -Raw | ConvertFrom-Json | Format-List status,timestamp,run,role,tranche,checkpoint,applicationSha,governanceSha,rootDefectId,latestRunLog
```

A recent timestamp with `status: RUNNING` is the health signal. Normal heartbeat ticks do not message the owner.

### Remote issue/completion message

The controller uses a generic webhook from the environment variable:

`PRYSM_AUTORUN_NOTIFY_WEBHOOK`

Recommended routing:

`PRYSM controller -> n8n Webhook -> Telegram Send Message`

This is notification-only. It is not part of PRYSM report generation.

The controller sends JSON only on:
- `BLOCKED`;
- `STOP` at a real governed external boundary;
- controller failure;
- `COMPLETE`.

Payload fields include project/workflow/event/severity/timestamp/message/role/run/tranche/applicationSha/governanceSha/controllerPid. Do not place secrets or report/evidence payloads in this webhook.

## One-time notification setup

Create or reuse an n8n Webhook endpoint that accepts POST JSON and routes the event/message fields to Telegram.

Set the webhook only in the current PowerShell environment or a user-scoped secret/config mechanism; do not commit it:

```powershell
$env:PRYSM_AUTORUN_NOTIFY_WEBHOOK = "<YOUR-N8N-WEBHOOK-URL>"
```

For unattended runs where remote messaging is required, launch with `-RequireRemoteNotification`. The controller refuses to start if the environment variable is absent.

## Local prerequisites

- local application repo: `C:\Users\kulba\Desktop\vantage-platform`
- local `prysm-project-context` clone
- authenticated Git/GitHub access
- authenticated Codex CLI
- trusted pre-GCU safety backup already recorded at application SHA `9b9e85d00a0d8b65a5ba6cad37583aa79151b15e`
- notification webhook environment variable when `-RequireRemoteNotification` is used

No Railway, Vercel, AWS, DataForSEO, or paid-model credential is required merely to start repository-controlled work. The autorun stops if a later governed tranche truly requires a protected external permission/call.

## Preflight

From the local `prysm-project-context` root:

```powershell
$App = "C:\Users\kulba\Desktop\vantage-platform"
$Gov = (Get-Location).Path

.\tools\report-improvement-autorun\PRYSM-REPORT-IMPROVEMENT-AUTORUN.ps1 `
  -AppRepo $App `
  -GovernanceRepo $Gov `
  -StartRole Builder `
  -HeartbeatSeconds 60 `
  -RequireRemoteNotification `
  -PreflightOnly
```

Do not start the long loop unless the last line is:

`PREFLIGHT PASS`

## Start unattended tip-to-tail execution

```powershell
$App = "C:\Users\kulba\Desktop\vantage-platform"
$Gov = (Get-Location).Path

.\tools\report-improvement-autorun\PRYSM-REPORT-IMPROVEMENT-AUTORUN.ps1 `
  -AppRepo $App `
  -GovernanceRepo $Gov `
  -StartRole Builder `
  -MaxRuns 0 `
  -HeartbeatSeconds 60 `
  -RequireRemoteNotification
```

`-MaxRuns 0` means unlimited controller iterations until `STOP`, `BLOCKED`, `COMPLETE`, controller failure, or Ctrl+C.

Logs are written outside Git under:

`%LOCALAPPDATA%\PRYSM-Autorun-Report-Improvement\run-####-timestamp-role-level#`

## Expected unattended terminal behavior

Normal path:

`Builder diagnose/build/prove -> Auditor challenge -> PASS -> next Builder -> ... -> final combined candidate -> Auditor -> COMPLETE`

Repair path:

`Auditor finding -> Builder bounded repair -> proof -> Auditor again`

External boundary:

`STOP + remote notification`

Unsafe/unresolved boundary:

`BLOCKED + remote notification`

Repository-controlled completion:

`COMPLETE + remote notification`

The owner should not need to attend routine progress. Use the heartbeat only when you want to confirm that the controller is still alive.
