# Current State

Project:
PRYSM — governed website conversion-readiness report and website decision system

Current objective:
Reach a client-ready PRYSM MVP as quickly as possible without foreseeable rework, evidence-integrity failure, or technical/process false PASS. P1 remains the only active P#.

## Verified checkpoint

- Application repository: `chriskulbaba2025/vantage-platform`
- Governance repository: `chriskulbaba2025/prysm-project-context`
- Frozen application branch/SHA: `main` / `6ea608a2625e2a14e28dbc7a5a04e5752b8eeeec`
- Active P#: P1 — Cross-Report Contradiction Integrity
- P1 Outcome Contract: `P1_OUTCOME_CONTRACT_2026-09-04.md`
- Read-only P1 diagnosis: COMPLETE
- Diagnostic classification: `VERIFIED_DESIGN_GAP`
- Betty Round 1: FAIL / 0 unresolved CRITICAL / 1 unresolved MAJOR
- `P1-BETTY-M01`: ACCEPTED by Chris
- Amended boundary disposition: `P1_BETTY_PRE_REPAIR_DISPOSITION_2026-09-04_1502.md`
- Betty Round 2: `P1_BETTY_PRE_REPAIR_BLIND_SPOT_REVIEW_R2_2026-09-04_1506.md`
- Betty Round 2 commit: `de41cab2a56848d38d579bb9ef365e5c4efdd39f`
- Betty Round 2 verdict: PASS / 0 unresolved CRITICAL / 0 unresolved MAJOR
- Chris bounded repair authorization: `P1_BOUNDED_REPAIR_AUTHORIZATION_2026-09-04_1508.md`
- Repair authorization commit: `94dce9af240871faffcdb4846a1e5b22c52122b9`
- `P1_EXECUTION_GATE.env`: `AUTHORIZED_STAGE=BOUNDED_BUILD`
- Bounded-build gate commit: `2052d00f79388f029d5c555797c9ca79f9e32709`
- Windows PowerShell launcher: `tools/prysm/start-prysm-p.ps1`
- PowerShell launcher commit: `13988cf3ebab7d163420235f685061119ad10462`

## Current stage

- Current stage: BOUNDED_BUILD
- Authorized execution stage: BOUNDED_BUILD
- Diagnostic status: COMPLETE
- Betty pre-repair gate: PASS / 0 / 0
- Chris repair authorization: APPROVED
- BOUNDED_BUILD: AUTHORIZED
- Application repair branch: NOT YET CREATED/VERIFIED
- Application code edits: NOT YET STARTED

## Authorized bounded repair

The Builder is authorized to implement only these five causally linked P1 obligations:

1. make CTA Clarity and Conversion Path Clarity independently meaningful while preserving evidence integrity;
2. add point-of-reading client-visible explanation where materially different related conclusions can appear;
3. route material mobile-usability and indexability deterministic report consumption through the governed cross-report interpretation projection rather than independent raw score/band interpretation;
4. remove the identified legacy trust bypass so the material deterministic consumer uses the governed cross-report interpretation projection;
5. route the material client-visible Narrative v2 conclusion path through the same governed cross-report interpretation authority and prove coherence between deterministic and Narrative layers in the same rendered artifact for material P1 scenarios.

The fifth obligation is limited to the P1 semantic-authority handoff. It does not authorize general Writer/Judge redesign, scoring-policy changes, provider acquisition, unrelated Narrative work, paid model reruns, P2-P10, or broad architecture work.

## Model-bearing dependency

Because the bounded repair may touch WriterInput/reference semantics, Writer prompt/instructions, Writer validation, or client-facing Narrative semantics, `PRYSM_MODEL_BEARING_RELEASE_GATE.md` applies to later release closure.

This does not block the authorized `BOUNDED_BUILD`. Paid/live model execution remains separately authorization-gated and is not authorized by the build gate.

## Exact next action

The official Windows launch path is now PowerShell from the `prysm-project-context` repository root:

```powershell
.\tools\prysm\start-prysm-p.ps1 P1
```

The PowerShell wrapper deterministically discovers the installed Codex CLI from PowerShell, passes its exact npm shim directory into Git for Windows Bash, then invokes the unchanged governed machine gate internally.

Internal governed machine-gate command retained for gate verification:

```bash
bash tools/prysm/start-prysm-p.sh P1
```

Do not manually patch PATH and do not launch this from an existing Codex prompt. Run the PowerShell wrapper directly at the VS Code `PS ...>` terminal prompt.

The Builder must implement the smallest coherent five-obligation repair, stop on any materially broader boundary, and then produce narrow positive/negative proof before broader system verification.

Brad is not the next step. Brad returns after technical/system proof and exact client-visible rendered proof are frozen.

## Hard boundaries

- No fresh live/paid production audit or paid provider/model calls.
- No application-main merge, deploy, production configuration change, destructive reset/clean/discard, or force push.
- No P2 work before P1 closes.
- Do not redo diagnosis unless new material evidence contradicts the committed diagnostic truth.
- Any materially broader implementation boundary must stop and reopen authorization rather than silently expand scope.
- Model-bearing release closure must satisfy `PRYSM_MODEL_BEARING_RELEASE_GATE.md` when applicable.
- Technical PASS is necessary but not sufficient; final P1 closure still requires provenance-bound exact client-visible rendered proof and independent Brad review.

Last verified:
2026-09-04
