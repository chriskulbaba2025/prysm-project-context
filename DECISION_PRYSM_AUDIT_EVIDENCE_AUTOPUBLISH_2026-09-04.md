# Decision — PRYSM Audit Evidence Auto-Publish

Date: 2026-09-04
Status: ACTIVE GOVERNANCE DECISION

## Decision

Governed PRYSM audit launchers must automatically preserve completed audit evidence in the authoritative governance repository so remote review does not depend on manual file transfer, chat copy/paste, or re-upload.

## Required behavior

For each governed audit run:

1. synchronize and freeze the exact governance HEAD being audited;
2. require a clean governance tree before audit start;
3. allow Codex to create only the single declared audit artifact;
4. validate required audit metadata, verdict, and unresolved CRITICAL/MAJOR counts;
5. refuse to commit if Codex changed any other file;
6. re-fetch `origin/main` after the audit and refuse to commit if authoritative governance moved during the audit;
7. commit the audit artifact whether the verdict is PASS or FAIL;
8. push that evidence commit to authoritative governance `main`;
9. verify the pushed commit is current `origin/main` and the local tree is clean;
10. stop after publishing evidence.

## Hard boundary

Automatic audit evidence publication is not stage authorization.

A PASS audit commit does not by itself authorize diagnosis, repair, outcome review, closure, or P# advancement.

A FAIL audit must still be committed and pushed so the failure and its findings remain auditable.

## Purpose

This removes unnecessary human file-transfer steps while strengthening durable evidence, remote review, provenance, and continuous auditability of the PRYSM process itself.

The application repository is not modified or pushed by this audit-publication mechanism.
