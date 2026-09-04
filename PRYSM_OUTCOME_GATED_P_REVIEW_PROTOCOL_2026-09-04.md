# PRYSM Outcome-Gated P Review Protocol

Date: 2026-09-04
Status: ACTIVE GOVERNING PROTOCOL
Application: `chriskulbaba2025/vantage-platform`
Governance: `chriskulbaba2025/prysm-project-context`
Frozen production baseline: `6ea608a2625e2a14e28dbc7a5a04e5752b8eeeec`

## Purpose

Close P1 through P10 against the **actual client/business outcome**, not only the prior engineering contract.

The governing sequence is:

`OUTCOME -> TRUTH -> DIAGNOSIS -> BOUNDED CHANGE -> TECHNICAL PROOF -> PRODUCT/RENDER PROOF -> BRAD REVIEW -> BETTY BLIND-SPOT AUDIT -> CHRIS APPROVAL -> DURABLE GITHUB STATE -> NEXT P#`

No automatic advancement is permitted.

## Core lesson carried forward

The prior PRYSM program proved strong engineering controls: persistent GitHub memory, exact-SHA state, diagnosis-first work, bounded changes, regression/Whole-App protection, evidence integrity, independent audit, and controlled promotion.

The missing control was an explicit product/outcome gate. A technical PASS could therefore be valid while the original client-facing goal was still only partially achieved.

This protocol adds that missing layer without weakening the engineering controls that already worked.

## Roles

### Chris — Outcome Owner / Final Approval

Chris owns:
- the intended client/business outcome;
- the one-sentence definition of done;
- approval of the acceptance criteria before work starts;
- authorization of the bounded repair after diagnosis;
- final P# closure and permission to advance.

Chris answers: **Did we achieve the thing we actually wanted?**

### Brad — Independent Product / Process Reviewer

Brad independently reviews the exact client/user-visible artifact against the frozen outcome.

Brad answers:
- Is the requested improvement visible?
- Is the original problem materially removed?
- Is the output more useful, clear, credible, and decision-ready?
- Is the evidence still truthful?
- Did the change harm an adjacent section or create a new problem?
- Are the acceptance criteria too narrow?

Where practical, Brad receives the frozen outcome and artifact before detailed Builder rationale.

### Betty — Adversarial Blind-Spot Auditor

Betty's job is to find how the work could incorrectly receive PASS.

Betty must challenge:
- requirement drift or narrowing;
- wrong baseline assumptions;
- missing production-visible render/consumer paths;
- stale artifact confusion;
- producer -> persistence -> consumer disconnects;
- hidden P# dependencies;
- false-PASS tests;
- fixture-only confidence;
- missing negative/fail-closed proof;
- evidence-integrity problems;
- symptom fixes that do not address the verified cause;
- product reviews that are too subjective;
- combined-candidate interactions;
- authorization/cost/release boundary mistakes;
- contradictory durable state.

Betty asks: **How could every test and review be green while the original goal is still materially unmet?**

### Builder / Execution Agent

The Builder may be Codex or another authorized agent.

The Builder owns:
- read-only diagnosis first;
- the smallest causally justified implementation;
- narrow proof;
- affected contract/integration/Whole-App proof;
- exact-candidate freeze;
- production-visible artifact preparation.

The Builder cannot unilaterally close a P#.

## Mandatory P# lifecycle

Every P# follows this sequence:

1. **Outcome Contract**
   - original problem;
   - client/business consequence;
   - desired outcome;
   - one-sentence definition of done;
   - observable acceptance criteria;
   - before evidence;
   - known dependencies;
   - non-goals;
   - required product/render proof;
   - false-PASS question.
   - Chris approval required.

2. **Diagnostic Truth**
   - verify current behavior and exact executing/production-visible paths;
   - classify `VERIFIED_ROOT_CAUSE`, `VERIFIED_DESIGN_GAP`, or `UNRESOLVED`;
   - no production-code edit while material cause is `UNRESOLVED`.

3. **Betty Pre-Repair Blind-Spot Attack**
   - attack diagnosis, dependencies, proof plan, production paths, and acceptance criteria;
   - zero unresolved CRITICAL/MAJOR findings required before repair authorization.

4. **Bounded Repair Authorization**
   - freeze allowed files/boundaries, protected surfaces, expected observable change, proof plan, and reopen conditions;
   - Chris authorizes the exact bounded repair.

5. **Bounded Build**
   - change only the authorized causal surface;
   - any new material boundary stops work and reopens diagnosis.

6. **Narrow Technical Proof**
   - prove the direct issue once;
   - include positive path and negative/fail-closed proof when applicable.

7. **System Verification**
   - execute required contract/integration/branch-complete/Whole-App proof;
   - no materially required production branch may remain UNMAPPED or UNEXECUTED;
   - applicable regression/build/static/machine gates must pass.

8. **Exact Candidate Freeze**
   - freeze one exact application SHA and tree state;
   - any material candidate change stales applicable proof.

9. **Product / Rendered Outcome Proof**
   - produce the exact client/user-visible artifact needed to judge the P#;
   - record exact application SHA and artifact provenance;
   - identify whether artifact is new deterministic/offline output, live output, or persisted historical output;
   - an old stored report cannot prove newly deployed renderer behavior.

10. **Brad Outcome Review**
    - Requested improvement visible: PASS/FAIL
    - Original problem removed: PASS/FAIL
    - Client usefulness improved: PASS/FAIL
    - Evidence remains truthful: PASS/FAIL
    - Adjacent quality harmed: YES/NO
    - Acceptance criteria too narrow: YES/NO
    - Material blind spot found: YES/NO
    - Verdict: PASS/FAIL

11. **Betty Final Adversarial Audit**
    - review frozen outcome, diagnosis, change surface, technical proof, exact SHA, artifact, and Brad review;
    - zero unresolved CRITICAL/MAJOR findings required.

12. **Chris Closure**
    - Chris selects one:
      - `APPROVE AND ADVANCE`
      - `REOPEN SAME P#`
      - `DEFER WITH RECORDED LIMITATION`
      - `STOP PROGRAM`
    - no implicit approval.

13. **Durable GitHub State**
    - update P# closure evidence and `CURRENT_STATE.md`;
    - record one exact next action;
    - verify the GitHub write;
    - only then is the P# CLOSED and the next P# permitted to start.

## Micro-tranches

A P# must be split when it contains more than one material outcome or root cause.

Example:
- P3A — current evidence shown for opportunity;
- P3B — gap reasoning;
- P3C — recommended asset, placement, funnel stage, and internal links.

Each micro-tranche repeats the full outcome/test/review cycle. The parent P# receives one integrated review before closure.

## Blind-spot back-and-forth

Blind-spot review is bounded to three rounds unless a new material fact appears.

Round 1:
Betty attacks the plan/diagnosis.

Round 2:
Builder/Chris disposition each finding with evidence as:
- ACCEPT;
- REJECT WITH EVIDENCE;
- DEFER AS NON-MATERIAL.
Brad checks whether the disposition preserves the intended outcome.

Round 3:
Betty attacks unresolved or newly created material seams only.

Stop when:
- zero unresolved CRITICAL;
- zero unresolved MAJOR;
- the acceptance test still proves the original outcome.

Do not allow blind-spot review to become an endless unrelated-improvement loop. Non-blocking discoveries go to backlog.

## Advancement rule

The only valid P# -> next P# transition is:

`CHRIS_APPROVED + GITHUB_STATE_VERIFIED`

Technical PASS, Brad PASS, Betty PASS, or autorun completion alone cannot advance the program.

## Standing P0 dependency

The active outcome-closure sequence is P1 through P10. P0 remains a dependency gate where later work depends on page/deep-content selection, especially P3.

Prior P0 work improved traceability but did not itself change selection ranking. Before P3 can close, the program must explicitly verify that downstream content intelligence is reasoning from the intended commercial/representative evidence set or reopen the P0 causal dependency.

## Production and cost boundaries

This protocol does not authorize:
- a fresh live/paid production audit;
- new paid provider/model calls;
- merge to application `main`;
- deployment;
- production configuration changes;
- destructive reset/clean/discard;
- force push.

Those require separate explicit owner authorization where applicable.

## Three-attempt anti-thrash rule

After three failed repair attempts against the same root cause, stop repair attempts and perform a diagnostic reset before another implementation attempt.
