# Surgical Change Contract — P9 Workflow Diagrams / UI Presentation Polish

Date: 2026-09-03
Application branch: `repair/prysm-report-improvement`
Change tier: bounded presentation-only repair
Release intent: `CHANGE_ONLY`

## Contract

Change only the deterministic conversion-path diagram in `services/worker/src/report/render-report-v2.js` so complete labels are wrapped into SVG `tspan` lines and the diagram exposes a wider viewBox with horizontal overflow on narrow screens. Refresh only the deterministic render goldens invalidated by that intentional HTML change.

## Invariants

Preserve the five-step order, arrows, source/model values, status semantics, evidence, scoring, persistence, and all non-conversion diagrams. Do not add model/provider behavior or generated imagery.

## File and branch map

- Producer/consumer: current report model → `renderReportV2` → conversion architecture SVG.
- Application files: `services/worker/src/report/render-report-v2.js`; `services/worker/src/report/render-report-v2.test.js`; frozen goldens in `services/worker/src/report/render-report-v2-conversion.test.js`.
- Material branches: conversion labels with short/long/empty values; all existing report/render branches remain covered by the conversion matrix and Whole-App P-B01–P-B16.

## Acceptance

Direct P9 proof, conversion matrix, deterministic repeatability, and exact-candidate Whole-App gate must pass before handoff. Causal necessity is established because only the conversion SVG layout and its dependent golden bytes changed.
