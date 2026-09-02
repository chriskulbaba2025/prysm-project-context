# Diagnostic P4 — Competitor Qualification

Date: 2026-09-02
Application candidate: `repair/prysm-report-improvement`
Application SHA: `34f47cb35dd7dba39aa488408d1da1242b66dc25`
Root defect: `P4_COMPETITOR_QUALIFICATION_UNGROUNDED`
Classification: **VERIFIED_DESIGN_GAP**

## Requirement preserved

P4 must improve competitor/comparator input quality before benchmark prose changes. Qualification must consider service/business similarity, geographic relevance, customer/audience similarity, and actual commercial overlap. If confidence is insufficient, the system must retain a bounded comparator/confirmation state rather than silently asserting competitor status. P8 consultant confirm/reject controls remain out of scope.

Acceptance: known non-competitors from the controlled review are not silently promoted to qualified competitors under the verified qualification contract.

## Diagnostic evidence

The authoritative implementation is `services/worker/src/evidence/competitor-opportunity-layer.js`.

* `qualifyCandidate()` declares five checks, but the checks are proxies rather than evidence-backed qualification: geographic relevance defaults true when context is absent and only compares free-text location fragments; service relevance compares the candidate topic to the client service/keyword strings; audience relevance is true for nearly every non-reference/community page; commercial relevance is inferred solely from page type; page comparability is also page-type-only.
* Supplied candidates are assigned `topic: topics[0]?.topic`, `geographicContext: input.location`, and `pageType: "landing"` regardless of the supplied page's observed business/service, audience, location, or commercial evidence.
* Every candidate passing those proxies is emitted under `candidates.qualified` with `qualificationPassed: true` and `approvalStatus: pending`. The downstream gap list retains the same candidate and is only gated by later approval; there is no bounded `comparator`/`confirmation_required` state for insufficient qualification confidence.
* The current candidate therefore cannot distinguish a directory/adjacent business or a geographically irrelevant supplied URL when the source adapter has returned an AVAILABLE row, and it can promote it to the qualified candidate set before human review. This is the verified design gap; no historical production non-competitor is reconstructed or claimed here.

## Required acceptance artifact

| Selected URL | Selection reason | Page class | Body requested | Body returned/status | Downstream modules |
|---|---|---|---|---|---|
| `https://competitor-1.example/services/consulting` | user-supplied; current implementation assigns first client topic | forced `landing` | supplied competitor crawl | `AVAILABLE` fixture row | qualification, competitor opportunities, report benchmark, review gate |
| `https://competitor-2.example/web-design` | user-supplied; current implementation assigns first client topic | forced `landing` | supplied competitor crawl | `AVAILABLE` fixture row | qualification, competitor opportunities, report benchmark, review gate |
| SERP candidate | topic query generated from client service/location | provider page type | SERP result/snippet; page evidence may be absent | provider result status | qualification, competitor opportunities, report benchmark |

The rows demonstrate that source availability and page retrieval do not establish competitor identity. The missing qualification evidence is the root boundary.

## Shortest authoritative proof

Command:

`npm test -- --test-name-pattern='competitor|Competitor'`

Result at the exact candidate: **970/970 PASS**, zero failures. Existing green tests prove the current approval workflow and source-status behavior; they do not prove the P4 requirement because no test asserts rejection/bounded comparator state for a known non-competitor or evidence-backed four-factor overlap.

## Decision

Repair is justified, but no application edit is made in this diagnostic step. A Surgical Change Contract must freeze the bounded qualification evidence/state contract before implementation. The likely causally justified surface is the competitor opportunity producer plus its contract/consumer parity tests; benchmark prose and P8 consultant controls are excluded. No live provider or model calls are required for this diagnosis.
