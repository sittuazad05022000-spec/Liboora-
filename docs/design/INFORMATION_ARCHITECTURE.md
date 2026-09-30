<!-- LIBOORA Design Documentation Foundation | 2026-09-09 -->

> This document is design governance and documentation. It does not amend product requirements, architecture decisions, bounded-context ownership, permissions, or backend contracts.
# LIBOORA Information Architecture

| Field | Value |
|---|---|
| Status | PROPOSED — IA model for review |
| Owner | Information Architecture Owner |
| Boundary | Design grouping only; not a backend or bounded-context map |

## 1. IA principles

- **INHERITED:** preserve the repository’s existing domain and ownership language.
- **RECOMMENDED:** organize around user intent and task completion, not around internal tables or technical modules.
- **RECOMMENDED:** one canonical place for each concept; link or compose rather than duplicate.
- **TO BE DECIDED:** final top-level navigation labels after Founder/Product Authority reviews the complete product scope.

## 2. Proposed product information groups

| Group | Design meaning | Source guardrail | Status |
|---|---|---|---|
| Discover | Candidate grouping for discovery/search | C2 / BC-23 are source candidates; lifecycle/source conflict recorded in `PRD_DESIGN_TRACEABILITY.md` | **UNRESOLVED for V1** |
| Library | Candidate grouping for profile facts | C3 composition candidate; source-status conflict remains | **UNRESOLVED for V1** |
| Study access | Candidate grouping for availability and seat/shift selection | BC-04 / PRD-007 authority candidate; exact screen mapping incomplete | **UNRESOLVED for V1** |
| My participation | Candidate grouping for membership/attendance-derived information | Applicable PRDs and visibility rules must be identified; no new permission | **UNRESOLVED for V1** |
| Operations | Inherited grouping of existing Library Management responsibilities | Master PRD role/module structure is source context; per-screen requirement mappings absent | **INHERITED grouping; surfaces UNRESOLVED** |
| Community | No V1 grouping approved | Master PRD §32 places Community in V2; PRD-021A status conflict remains open | **DEFERRED from V1; conflict carried** |

## 3. Navigation model

Navigation hierarchy and labels are **UNRESOLVED** pending the per-surface V1 PRD/role mapping. The principles in this section are design guidance, not a decided V1 navigation model. Any later proposal must map destinations to approved V1 journeys and established roles; a backend entity or existing implementation alone does not authorize a destination.

## 4. Findability rules

Search is the first path for local discovery. Search, nearby, filters, profile facts, availability, shift/seat choice, and booking initiation must not appear as duplicate parallel systems.

## 5. Content model

Each content block is tagged in design with its source owner, freshness expectation, visibility rule if specified, and fallback state. Where the source does not define a visibility rule, the block is TO BE DECIDED—not assumed public.

## 6. V1 scope reconciliation — Founder/Product Authority decision

**PRODUCT SCOPE DECISION — OPTION C (2026-09-30):** Neither the proposed discovery-to-
booking screen families nor the implemented staff/student screen set is independently
authoritative. V1 grouping must be reconciled from approved/frozen V1 PRDs and the
established product role structure.

The reconciliation covers Student/Parent discovery, library selection, availability,
seat/shift selection, and booking/outcome journeys, plus Reception, Manager, and Owner
operational workflows defined by V1 PRDs. Implementation and proposed design surfaces
are evidence to reconcile, not automatic approval. Each retained group must trace to a
V1 PRD, approved requirement, or established role/workflow; otherwise it remains
unresolved or deferred. This decision does not define permissions, backend behavior, or
G1 approval.
