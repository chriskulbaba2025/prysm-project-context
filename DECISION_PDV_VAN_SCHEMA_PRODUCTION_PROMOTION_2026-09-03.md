# Decision: VAN-SCHEMA exact-candidate production promotion

Date: 2026-09-03
Status: Active

## Authorization

Owner explicitly authorized merge and production deployment of the exact independently audited VAN-SCHEMA repair candidate:

`6ea608a2625e2a14e28dbc7a5a04e5752b8eeeec`

Application repository:
`chriskulbaba2025/vantage-platform`

Source branch:
`repair/prysm-van-schema-mixed-status`

## Governed scope

This authorization permits only:

1. promotion of exact candidate SHA `6ea608a2625e2a14e28dbc7a5a04e5752b8eeeec` to application `main` without altering the candidate contents;
2. production deployment of that exact promoted SHA;
3. read-only verification that production deployment resolves to that exact SHA and is healthy.

Preferred promotion method: non-force fast-forward so `main` becomes the exact audited candidate SHA with no merge commit.

## Evidence inherited from candidate

Before authorization, exact candidate SHA `6ea608a2625e2a14e28dbc7a5a04e5752b8eeeec` had:

- focused scoring suite PASS 31/31;
- PRYSM Whole-App gate PASS 87/87 covering P-B01 through P-B16;
- closure gate PASS;
- independent Auditor PASS;
- material defects: 0;
- application branch synchronized and clean.

## Explicitly not authorized

This authorization does not permit:

- a fresh live/paid production audit;
- new paid provider/model calls;
- production configuration changes unrelated to deploying this exact SHA;
- destructive reset;
- force push;
- modification of the audited candidate during promotion.

## Exact next action

Promote exact candidate SHA `6ea608a2625e2a14e28dbc7a5a04e5752b8eeeec` to `main`, deploy that exact SHA, verify deployment identity/health, then record the promotion result in governance.
