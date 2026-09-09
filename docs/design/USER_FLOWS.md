<!-- LIBOORA Design Documentation Foundation | 2026-09-09 -->

> This document is design governance and documentation. It does not amend product requirements, architecture decisions, bounded-context ownership, permissions, or backend contracts.
# LIBOORA User Flows

| Field | Value |
|---|---|
| Status | PROPOSED — flow architecture for review |
| Owner | UX Architecture Owner |
| Rule | Flows describe experience sequencing, not new backend behavior |

## 1. Library discovery to booking

**CONFIRMED / INHERITED:**

Search or Nearby → Results → Library Profile → Availability → Shift or Seat → Booking Initiation → Outcome.

| Stage | Required design evidence | Source / status |
|---|---|---|
| Search or Nearby | Query, location or nearby entry, loading, no-result, stale, error, and offline states | C2 / BC-23; source authority is INHERITED |
| Results | Clear result identity, relevant public facts, filter state, and return path | C2 composition; no new rank or index |
| Library Profile | Profile facts, trust cues, available actions, and limits of public data | C3 composition; no field ownership |
| Availability | Freshness indication and capacity/availability state when supplied | C4 and existing seat authority |
| Shift or Seat | Existing source-backed selection and conflict handling | PRD-007 / BC-04 authority |
| Booking Initiation | Review, submit, pending, success, conflict, and retry states | Existing booking authority; no duplicate lock |

## 2. Staff operational flow

**INHERITED:** staff workflows remain organized by existing Library Management responsibilities: enrollment, membership, attendance, seating, reception, and finance. This document does not specify new staff permissions or combine those systems.

## 3. Membership-derived participation flow

**CONFLICT / TO BE DECIDED:** A1 contains draft community foundation rules and explicitly says it owns no persisted state, permission, authority, or public surface, while higher-order baseline records reference PRD-021A. Design may represent a private, membership-derived read surface only after source authority confirms the applicable baseline and visibility rule.

## 4. Flow quality checks

Every flow must answer: where did the user enter, what is known, what may be stale, what is the primary action, what can fail, how does the user recover, and which source owns the outcome?
