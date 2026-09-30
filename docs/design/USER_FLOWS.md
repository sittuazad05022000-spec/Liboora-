<!-- LIBOORA Design Documentation Foundation | 2026-09-09 -->

> This document is design governance and documentation. It does not amend product requirements, architecture decisions, bounded-context ownership, permissions, or backend contracts.
# LIBOORA User Flows

| Field | Value |
|---|---|
| Status | PROPOSED — flow architecture for review |
| Owner | UX Architecture Owner |
| Rule | Flows describe experience sequencing, not new backend behavior |

## 1. Library discovery to booking

**INHERITED sequence skeleton; V1 surface scope UNRESOLVED under Option C.**

Search or Nearby → Results → Library Profile → Availability → Shift or Seat → Booking Initiation → Outcome.

| Stage | Required design evidence | Source / status |
|---|---|---|
| Search or Nearby | Candidate flow stage; query, location, loading, no-result, stale, error, and offline states are design requirements only, not approval of a V1 surface | PRD-021C C2 / BC-23 are cited in `PRD_DESIGN_TRACEABILITY.md` with source-status conflict; V1 mapping **UNRESOLVED** |
| Results | Candidate flow stage; identity, public facts, filter state, and return path require source mapping | C2 composition candidate; exact frozen V1 requirement **UNRESOLVED** |
| Library Profile | Candidate flow stage; profile facts/actions require source mapping | PRD-021C C3 status conflict; fields and V1 mapping **UNRESOLVED** |
| Availability | Candidate flow stage; freshness and capacity only when source-backed | PRD-007 is authority candidate; PRD-021C C4 conflict remains; per-state mapping **UNRESOLVED** |
| Shift or Seat | Candidate flow stage; selection/conflict handling only as defined by authority | PRD-007 / BC-04 authority candidate; screen-family-to-implementation mapping **UNRESOLVED** |
| Booking Initiation | Candidate flow stage; review/outcome states are not independently approved here | Existing booking authority candidate; exact V1 screen/state mapping **UNRESOLVED** |

## 2. Staff operational flow

**INHERITED role/workflow categories; per-surface V1 mapping UNRESOLVED:** enrollment, membership, attendance, seating, reception, and finance remain owned by their existing product sources. This document does not approve the currently implemented screens, specify new permissions, or combine those systems. Each retained workflow must be traced to an exact applicable V1 PRD requirement.

## 3. Membership-derived participation flow

**CONFLICT / TO BE DECIDED:** A1 contains draft community foundation rules and explicitly says it owns no persisted state, permission, authority, or public surface, while higher-order baseline records reference PRD-021A. Design may represent a private, membership-derived read surface only after source authority confirms the applicable baseline and visibility rule.

## 4. Flow quality checks

Every flow must answer: where did the user enter, what is known, what may be stale, what is the primary action, what can fail, how does the user recover, and which source owns the outcome? For G1, each stage also requires an authoritative V1 source link and explicit `PROPOSED`, `INHERITED`, `UNRESOLVED`, or `DEFERRED` disposition. The present flows are not complete for G1 while those per-surface links remain open.

## 5. V1 scope reconciliation — Founder/Product Authority decision

**PRODUCT SCOPE DECISION — OPTION C (2026-09-30):** Neither the seven proposed
screen families (five discovery/booking families, the inherited Operational Dashboard,
and Community) nor the currently implemented staff/student screens is
independently authoritative for V1. The V1 experience scope must be reconciled from
approved/frozen V1 PRDs and the established product role structure.

The reconciliation must cover both (a) core Student/Parent journeys — discovery,
library selection, availability, seat/shift selection, and booking/outcome — and (b)
core Reception, Manager, and Owner operational journeys already defined by V1 PRDs.
Existing implementation is not automatically approved scope; proposed surfaces are not
automatically approved scope. Every retained surface requires a trace to an applicable
V1 PRD, approved product requirement, or established role/workflow. Unsupported
surfaces remain unresolved, deferred, or are removed from V1 design scope.

This is a product-scope decision only. It does not approve implementation, backend
behavior, permissions, undocumented features, or G1, and it does not close `DBT-006`.
