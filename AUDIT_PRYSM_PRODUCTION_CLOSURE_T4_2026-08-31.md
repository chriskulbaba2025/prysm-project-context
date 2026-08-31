# PRYSM T4 Independent Audit — 2026-08-31

Verdict: **FAIL**

- Application branch: `repair/prysm-production-closure`
- Application SHA: `e0c2ab93481b9c4681da464cf4310e214edc25b2`
- Exact local/remote equality: verified; ahead/behind `0/0`
- Application tree: clean; `git diff --check` passed
- Claimed Whole-App Gate: command passed, but the T4-changed replay CLI boundary was not exercised
- Live/paid provider or model calls: 0 observed

## AUD-T4-001 — Whole-App Gate omits the changed replay CLI boundary

- Category: `FALSE_PASS_PROOF_DEFECT`
- Severity: **MAJOR**
- Evidence: T4 changes `services/worker/scripts/replay-report.js` CLI behavior: default replay rejects historical Judge provenance, `--legacy-compat` is an explicit compatibility mode, and current replay requires ScoreSet `2.0.0` plus persisted hierarchy. The exact gate (`services/worker/scripts/prysm-whole-app-gate.js`) runs `scripts/replay-report.test.js`, whose tests call `buildV2Model()` directly. They do not invoke the replay CLI/main path, do not provide a historical fixture, and do not assert default rejection or compatibility-only labeling.
- Why current proof misses it: the tested helper path bypasses argument parsing, fixture discovery, persisted artifact loading, Judge-version handling, and the new `LEGACY_COMPAT_MODE` branch. A regression in the actual changed production replay boundary could therefore leave the gate green.
- Required correction: add a deterministic zero-cost CLI-level regression using a minimal persisted fixture (or an equivalent subprocess seam) proving (1) default current replay rejects historical Judge `1.0.0`/prompt `2.0.0`, (2) `--legacy-compat` is required for that fixture, and (3) the result is explicitly excluded from current release proof. Include that regression in `scripts/prysm-whole-app-gate.js`; rerun the exact-SHA gate and synchronization checks.
- Owning tranche: **T4**. No later tranche may begin until repaired and independently audited.

## Audit conclusion

The candidate identity and repository synchronization are established, and the gate command itself is deterministic and zero-cost. However, the sole changed production boundary is replay CLI compatibility selection, and the gate does not execute it. Under the Whole-App Tranche Gate and independent-audit protocols, this is a material false-PASS escape. No application files were modified by this audit.
