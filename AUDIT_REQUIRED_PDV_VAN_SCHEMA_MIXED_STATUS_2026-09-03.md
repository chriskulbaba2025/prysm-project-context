# Audit Required — PDV VAN-SCHEMA Mixed Status

Application branch: `repair/prysm-van-schema-mixed-status`

Exact candidate SHA: `6ea608a2625e2a14e28dbc7a5a04e5752b8eeeec`

Root defect: `VAN-SCHEMA-001-MIXED-STATUS-PROVENANCE`

The shared finding evidence helper now derives DataForSEO evidence status from a required capability. A required AVAILABLE capability remains AVAILABLE even when the broader site is PARTIAL; required PARTIAL remains PARTIAL with bounded wording; unusable required capabilities remain suppressed; findings without requirements retain site-level status.

Evidence:

- focused scoring suite: 31/31 PASS;
- report-finalization gate suite: 37/37 PASS;
- Whole-App Tranche Gate: PASS, P-B01 through P-B16, 87/87;
- composite closure machine gate: PASS;
- zero live provider/model calls;
- application tree clean and local/remote synchronized 0/0.

Required next action: independent Auditor reviews this exact candidate SHA. Merge, deployment, production mutation, and fresh paid/live audit remain unauthorized.
