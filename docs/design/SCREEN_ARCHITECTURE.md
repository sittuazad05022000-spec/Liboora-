<!-- LIBOORA Design Documentation Foundation | 2026-09-09 -->

> This document is design governance and documentation. It does not amend product requirements, architecture decisions, bounded-context ownership, permissions, or backend contracts.
# LIBOORA Screen Architecture

| Field | Value |
|---|---|
| Status | PROPOSED — screen inventory and composition rules |
| Owner | UX Architecture Owner |
| Screen rule | A screen is a composition surface, not a new system |

## 1. Canonical screen families

| Screen family | Purpose | Required states | Ownership guardrail | Status |
|---|---|---|---|---|
| Discover / Search | Start local library discovery | loading, results, no results, filter empty, error, offline/stale | C2 consumes BC-23; no duplicate search or ranking | PROPOSED |
| Library Profile | Show one library’s public profile | loading, complete, partial, unavailable, error | C3 owns composition only | PROPOSED |
| Availability | Show source-backed availability | loading, fresh, stale, unavailable, error | No client promise of real-time state | PROPOSED |
| Shift / Seat selection | Present an existing selection choice | loading, selected, conflict, unavailable, retry | Seat and booking authority remain inherited | PROPOSED |
| Booking outcome | Explain initiation result | success, pending, conflict, declined, retryable failure, offline | No duplicate booking authority | PROPOSED |
| Operational dashboard | Support existing staff workflows | loading, empty, partial, error, permission-denied where source defines it | No new role or permission | INHERITED composition |
| Community surface | Reserved for approved community scope | all states must follow approved source rules | A1 status conflict blocks unsupported claims | TO BE DECIDED |

## 2. Screen anatomy

1. Context header: where the user is and what the surface represents.
2. Primary state: the most important fact or next action.
3. Supporting content: source-backed detail, grouped progressively.
4. Recovery: retry, change input, return, or explanation where applicable.
5. Navigation: preserve location and prevent accidental loss of entered intent.

## 3. Cross-screen invariants

The same concept uses the same label and state semantics across search, profile, availability, seat, booking, and operational surfaces. A component must not imply a stronger guarantee than the owning source provides.
