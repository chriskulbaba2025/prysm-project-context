# PRYSM Post-MVP Generalization and Exact-Candidate Currentness

Date: 2026-09-23

## Exact candidate

- branch: `repair/prysm-post-mvp-evidence-intelligence-2026-09-22`
- SHA: `2bc8d06eebcf5b705886ef002ee3d0bb8ccb68fd`
- frozen base: `aa9383bdab9047cfbaf3316d5dbca5cd2a0cb355`

## Implemented and proven

- Suspicious URL coverage now invokes bounded structural browser discovery
  when enabled by the live adapter. It visits at most four structural pages,
  retains same-origin URLs only, preserves `RENDERED_BROWSER` provenance, and
  records browser failure as limitation rather than absence.
- Permanent generalized acceptance matrix covers SSR, JS navigation, missing
  and malformed sitemap states, provider partial coverage, llms supporting
  discovery, conflicts, cross-origin filtering, stable tenant/audit graph
  identity, causal fail-closed behavior, Ask PRYSM grounding, and scope
  propagation.
- Full worker regression: `1067 PASS, 0 FAIL, 0 SKIP`.

## Exact hosted currentness

- Railway staging: deployment `704df291-c95e-49aa-8537-36d19d4284be`, running.
- Vercel Preview: deployment `dpl_96m31r4f3vonDQwLMkHeP9EpaZVJ`.
- Hosted browser proof: authenticated reviewer, dashboard, persisted audit
  reload, seven report pages/17 fragments, zero console errors, 4-page PDF.
- A stale shell identity harness escape was preserved and classified as
  `HARNESS_DEFECT`; authoritative Railway variables were then used to pass
  exact-candidate currentness.

## Disposition

Overall candidate remains `HOLD`: the implemented path and deterministic
matrix are proven, but complete arbitrary-site acceptance, bounded live
DataForSEO/model validation where still needed, and longitudinal business
outcomes remain incomplete. Production remains untouched.

Next action: continue from this exact SHA for the remaining generalized and
bounded live-validation work; do not promote or mutate production.
