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
| Discover | Find and compare libraries through the existing discovery surface | C2 / BC-23 authority | PROPOSED |
| Library | View a library profile and its available public facts | C3 composition only | PROPOSED |
| Study access | Select an existing shift or seat and initiate the applicable flow | BC-04 / PRD-007 authority | PROPOSED |
| My participation | Show a user’s existing membership-derived or attendance-related information where a source permits it | Existing PRDs only; no new permission | PROPOSED |
| Operations | Existing staff workflows for enrollment, membership, attendance, seating, reception, and finance | Library Management ownership | INHERITED grouping |
| Community | Reserved for approved, source-backed community surfaces | PRD-021A status conflict remains open | TO BE DECIDED |

## 3. Navigation model

Primary navigation should expose a small number of stable destinations. Secondary navigation handles filters, profile detail, operational subareas, and settings only where the source product permits them. A screen is not added merely because a backend entity exists.

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
