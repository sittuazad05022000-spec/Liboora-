<!-- LIBOORA Design Documentation Foundation | 2026-09-09 -->

> This document is design governance and documentation. It does not amend product requirements, architecture decisions, bounded-context ownership, permissions, or backend contracts.
# LIBOORA Design to Engineering Handoff

| Field | Value |
|---|---|
| Status | PROPOSED — handoff contract |
| Owner | Design–Engineering Handoff Owner |
| Boundary | Design describes experience behavior; engineering and source architecture govern implementation |

## 1. Handoff package

Every handoff includes: canonical Figma link or artifact reference; screen and component inventory; responsive variants; content and localization notes; interaction states; loading, empty, error, offline, and stale states where applicable; accessibility annotations; asset exports and usage rules; performance notes; PRD traceability; unresolved questions; and approval evidence.

## 2. Handoff readiness

A surface is not ready when only the happy path is designed. It is ready when the Design QA Owner confirms state coverage, the Accessibility Owner confirms required checks, the Design Performance Owner confirms asset/effect posture, and the traceability row is complete.

## 3. Ownership boundaries

- Design does not define API shape, database structure, bounded contexts, event contracts, permissions, quotas, locks, ranking, or booking authority.
- Engineering does not silently reinterpret a frozen requirement through a visual implementation.
- A product question is escalated to Founder/Product Authority.
- An architecture or ownership question is escalated to the applicable Architecture Owner.
- A design-system question is escalated to the Design System Owner.

## 4. Change during implementation

If implementation reveals a mismatch, record the design impact and link the source. Do not patch the frozen PRD or ADR from the handoff. Use the change-management process and create a decision record when the design direction changes.
