<!-- LIBOORA Design Documentation Foundation | 2026-09-09 -->

> This document is design governance and documentation. It does not amend product requirements, architecture decisions, bounded-context ownership, permissions, or backend contracts.
# LIBOORA User Flows

| Field | Value |
|---|---|
| Status | PROPOSED — flow architecture for review |
| Owner | UX Architecture Owner |
| Rule | Flows describe experience sequencing, not new backend behavior |

## 1. Library discovery to booking

**V1 retained, source-bounded flow:** public discovery/profile under frozen Library
PRD §§14A–14B; authenticated booking/seat operations under frozen PRD-007.

Search or Nearby → Results → Library Profile → Availability → Shift or Seat → Booking Initiation → Outcome.

| Stage | Required design evidence | Source / status |
|---|---|---|
| Search or Nearby | Public search by name/city/locality/PIN; nearby and distance sort when location permission is available | Frozen Library PRD §14A.4 `LIB-DISC-003`, `.013`; `14B` `LIB-14B.2`–`.6`. C2 is a draft, not the authority |
| Results | Show only public, approved library facts; private/unavailable records remain non-discoverable | Frozen Library PRD §§14A.5–.6; `14B` `LIB-14B.7`–`.10`, `.23`–`.25` |
| Library Profile | Public profile uses only §14A.5 allow-list and owner projections; protected actions remain gated | Frozen Library PRD §14A.5; `14B` `LIB-14B.7`–`.10`, `.26`–`.29` |
| Availability | Public view exposes aggregate capacity and a coarse qualitative availability indicator only; no live occupancy, precise free-seat count or per-seat state | Frozen `14B` `LIB-14B.11`–`.14`; authenticated student availability per frozen PRD-007 `SEAT-FR-076`, `.079` |
| Shift or Seat | Seat choice and eligibility follow the frozen BC-04 requirements; do not expose another student's allocation | Frozen PRD-007 `SEAT-FR-076`–`.084`; public restrictions in `LIB-14B.11`–`.14` |
| Booking Initiation | Booking is protected; PRD-007 controls self-booking, tenant mode and result semantics. Tenant default is disabled | Frozen PRD-007 `SEAT-FR-076`–`.086`; frozen Library `14B` `PO-4` / `LIB-14B.27` |
| Outcome | Render only the owning booking operation's actual result; do not add C4 draft-only outcome states | Frozen PRD-007 §12 and its closed booking/reservation rules; C4 remains Stage 2 draft |

## 2. Staff operational flow

**V1 source-bounded operations:** Master PRD §8 modules 3–12 establishes Student Management, Parent Portal, Seat Management, Attendance, Revenue & Finance, and Owner/Manager/Reception dashboard compositions. Frozen PRD-004, PRD-006, PRD-007 and role/access sources govern their own behavior. PRD-008 is still DRAFT; its requirements are not represented as frozen. This flow does not approve any screen file or combine systems. Observed files without exact source mapping are deferred as listed in `DESIGN_IMPLEMENTATION_TRACEABILITY.md` §8.1.

## 3. Membership-derived participation flow

**DEFERRED — V2:** Master PRD §5.2 `MP-SCOPE-04` and §8 V2 roadmap place Community & Groups in V2. The PRD-021A status conflict does not alter that explicit V1 exclusion. No community participation flow is included in V1.

## 4. Flow quality checks

Every retained flow stage cites its source and marks boundaries where the source does not authorize a behavior. Candidate states from draft PRD-021C are not inherited as requirements. Exact screen implementations and QA remain outside this scope reconciliation.

## 5. V1 scope reconciliation — Founder/Product Authority decision

**PRODUCT SCOPE DECISION — OPTION C (2026-09-30), RECONCILED:** Neither the seven
proposed screen families nor the observed implementation inventory independently
defines V1. The retained and deferred surface mapping is recorded in
`DESIGN_IMPLEMENTATION_TRACEABILITY.md` §8.1 using approved/frozen V1 PRDs and the
established product role structure.

The reconciliation must cover both (a) core Student/Parent journeys — discovery,
library selection, availability, seat/shift selection, and booking/outcome — and (b)
core Reception, Manager, and Owner operational journeys already defined by V1 PRDs.
Existing implementation is not automatically approved scope; proposed surfaces are not
automatically approved scope. Retained source-bounded flows are bounded by their cited
requirements; Community and unsupported screens are deferred from V1. No behavior from
draft-only requirements is promoted to approved scope.

This is a product-scope reconciliation only. It does not approve implementation,
backend behavior, permissions, undocumented features, QA, or constitute a separate G1
gate-owner act.
