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
| Discover / Search | Public library discovery/search | Public results, no results, unavailable/private indistinguishable response; other transient states only when defined by source | Frozen Library PRD §14A.4 and `14B` `LIB-14B.2`–`.6`, `.23`–`.25`; no draft C2 ranking behavior | RETAINED — V1, source-bounded |
| Library Profile | Show the public Library PRD §14A.5 allow-list | Available public projection or same anti-enumeration response for inaccessible records | Frozen `14B` `LIB-14B.7`–`.10`, `.22`–`.25`; no C3-only field/state | RETAINED — V1, allow-list only |
| Availability | Public aggregate availability; private student availability in protected seat flow | Public aggregate/coarse status only; no per-seat identity, exact free count, live occupancy or attendance-derived state | Frozen `14B` `LIB-14B.11`–`.14`; private seat availability `SEAT-FR-076`, `.079` | RETAINED — V1, audience-bounded |
| Shift / Seat selection | Student self-booking/selection under BC-04 | Only PRD-007-defined eligibility, selection and rejection outcomes | Frozen PRD-007 `SEAT-FR-076`–`.086`; tenant default disabled; no public per-seat state | RETAINED — V1, protected operation |
| Booking outcome | Explain the result of the owning seat-booking operation | Only PRD-007 booking-mode outcomes (Direct, HoldThenConfirm, ApprovalRequired) and specified rejection; no offline booking claim | Frozen PRD-007 `SEAT-FR-085`–`.086`; frozen Library `14B` `PO-4` | RETAINED — V1, source-bounded |
| Operational dashboard | Owner, Manager and Reception read compositions | Loading/empty/error only as applicable to source-backed projections; permission-denied only where source defines it | Master PRD §8 modules 10–12; no invented role, permission or widget | RETAINED — V1 composition only |
| Community surface | No V1 screen | Not applicable | Master PRD §5.2 `MP-SCOPE-04` and §8 place Community in V2 | DEFERRED — V2 |

### 1.1 ⚠️ These families are specified, not built

Measured: of the seven families above, **five** (Discover/Search, Library
Profile, Availability, Shift/Seat selection, Booking outcome) have **no
implementation** under `lib/app/`, while the **11** screens that do exist are
staff and student operational surfaces with no design artifact. Recorded as
`DIT-005`/`DIT-008` in
[Design to Implementation Traceability](DESIGN_IMPLEMENTATION_TRACEABILITY.md)
and as [`DESIGN_DEBT.md`](DESIGN_DEBT.md) `DBT-006`.

## 1.2 V1 scope reconciliation — Founder/Product Authority decision

**PRODUCT SCOPE DECISION — OPTION C (2026-09-30), RECONCILED:** The seven-family
inventory is disposed by source in §1 and `DESIGN_IMPLEMENTATION_TRACEABILITY.md`
§8.1; implementation observation alone remains non-authoritative.

Retained surfaces are bounded by the specific sources in §1. Student/Parent discovery
uses frozen Library public-discovery requirements; seat availability and booking use
frozen PRD-007; role dashboards are compositions established by Master PRD §8, with no
inferred widget set. Unsupported implementation screens and Community are deferred from
V1. PRD-021C C2/C3/C4 draft-only states are not adopted as requirements.

This is product scope reconciliation only. It does not approve implementation, backend
behavior, permissions, undocumented features, QA, or a separate G1 gate-owner act.

Under Option C, the inventory is descriptive. The five discovery/booking families and
the dashboard composition are retained only within the exact cited source boundaries;
Community is **DEFERRED — V2** by Master PRD §5.2/§8. PRD-021A's status conflict does
not alter that scope. Draft-only states are excluded. Per-screen specifications use
[`templates/SCREEN_SPEC_TEMPLATE.md`](templates/SCREEN_SPEC_TEMPLATE.md).

## 2. Screen anatomy

1. Context header: where the user is and what the surface represents.
2. Primary state: the most important fact or next action.
3. Supporting content: source-backed detail, grouped progressively.
4. Recovery: retry, change input, return, or explanation where applicable.
5. Navigation: preserve location and prevent accidental loss of entered intent.

## 3. Cross-screen invariants

The same concept uses the same label and state semantics across search, profile, availability, seat, booking, and operational surfaces. A component must not imply a stronger guarantee than the owning source provides.
