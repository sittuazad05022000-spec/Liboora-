<!-- LIBOORA Design Documentation Foundation | 2026-09-09 -->

> This document is design governance and documentation. It does not amend product requirements, architecture decisions, bounded-context ownership, permissions, or backend contracts.
# LIBOORA PRD to Design Traceability

| Field | Value |
|---|---|
| Status | PROPOSED — traceability register |
| Owner | PRD→Design Traceability Owner |
| Rule | Every design claim is source-linked or explicitly marked RECOMMENDED / PROPOSED / TO BE DECIDED |

## 1. Source precedence

The locked Documentation Baseline, accepted ADRs, frozen PRDs, architecture maps, and developer documents are authoritative in their applicable order. Design documents never rewrite them.

## 2. Traceability matrix

| Design area | Source | Source status | Design treatment | Design status |
|---|---|---|---|---|
| Library domain ownership | docs/00-governance/DOCUMENTATION_BASELINE.md and docs/10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md | FROZEN / INHERITED | Preserve existing Library Management and BC ownership; no duplicate system | INHERITED |
| Library Search and Local Discovery | docs/30-product/library-marketplace/PRD-021C_C2_LIBRARY_SEARCH_AND_LOCAL_DISCOVERY_DRAFT_v0.1.md; ADR-0094 | C2 file says DRAFT; C0–C8 freeze record and baseline declare PRD-021C baselined | Compose Search or Nearby; consume existing discovery contract; no index or ranking system | INHERITED with CONFLICT recorded |
| Library Public Profile | docs/30-product/library-marketplace/PRD-021C_C3_LIBRARY_PUBLIC_PROFILE_DRAFT_v0.1.md; ADR-0095–0097 | C3 file says DRAFT; C0–C8 freeze record declares C0–C8 baselined | Compose existing fields; no profile field ownership; analytics is readout only | INHERITED with CONFLICT recorded |
| Seat and booking initiation | docs/30-product/library-marketplace/PRD-021C_C4_LIVE_SEAT_AVAILABILITY_AND_BOOKING_DRAFT_v0.1.md; PRD-007 freeze records | C4 source contains draft language; existing seat authority remains higher-order | Use Availability → Shift or Seat → Booking; forward outcome to owner; no duplicate booking, lock, quota, or reservation system | INHERITED / RECOMMENDED |
| Library Community Foundation | docs/30-product/social-graph/PRD-021A_A1_LIBRARY_COMMUNITY_FOUNDATION_DRAFT_v0.2.md; PRD-021A_STAGE7_BLOCKER.md; ADR-0087 | CONFLICT — baseline/ADR references PRD-021A baseline while A1 and blocker say draft/not frozen | Do not invent public/community permissions or behavior; keep community exploration explicitly gated | CONFLICT / TO BE DECIDED |
| Availability freshness and failure | applicable C2/C3/C4 source documents and existing developer contracts | INHERITED where specified; otherwise TO BE DECIDED | Show freshness and failure honestly; do not claim real-time or offline write capability | RECOMMENDED |

## 3. Traceability rules

A row is complete when it has a source path, source status, design consequence, design status, owner, and open question if any. A design artifact with no row is not handoff-ready.

This register carries the **upstream** half of the chain — requirement to design treatment. The **downstream** half — design artifact to screen, implementation and QA evidence — is [Design to Implementation Traceability](DESIGN_IMPLEMENTATION_TRACEABILITY.md). ⚠️ That register currently holds **0** rows with a PRD requirement link, and closing that gap (`DIT-OD-001`) is this document's owner's act, not a documentation fix.

## 4. Conflict register

- **CONFLICT C-001:** PRD-021A status differs between locked baseline/ADR references and current A1/blocker language. Escalate to Governance Owner and Founder/Product Authority; do not modify either source.
- **CONFLICT C-002:** PRD-021C component files retain draft headers while the C0–C8 freeze record and baseline declare the package frozen/baselined. Use the higher-order baseline for authority and mark behavior not explicit in a frozen record as TO BE DECIDED.

## 5. DBT-006 V1 scope reconciliation

**Founder/Product Authority decision — OPTION C (2026-09-30):** Neither the proposed
discovery-to-booking screen families nor the implemented staff/student screen set is
independently authoritative for V1. The authoritative scope must be reconciled from
approved/frozen V1 PRDs and the established product role structure.

The retained scope must cover the applicable Student/Parent discovery, library
selection, availability, seat/shift selection, and booking/outcome journeys, together
with Reception, Manager, and Owner operational workflows defined by V1 PRDs. Existing
implementation and proposed design surfaces are not automatic authority. Every retained
surface requires a source link to a V1 PRD, approved requirement, or established
role/workflow; unsupported surfaces remain unresolved, deferred, or are removed from V1
design scope. Frozen PRDs and ADRs are not amended by this record.

This decision establishes product scope only. It does not approve implementation,
backend behavior, permissions, undocumented features, G1, or `DBT-006` closure.
