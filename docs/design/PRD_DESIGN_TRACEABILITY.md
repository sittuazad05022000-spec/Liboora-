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
| Library Search and Local Discovery | docs/30-product/library-marketplace/PRD-021C_C2_LIBRARY_SEARCH_AND_LOCAL_DISCOVERY_DRAFT_v0.1.md; ADR-0094; `Accepted` ADR-0098 | PRD-021C C0–C8 are `FROZEN` / `BASELINED` at Rank 3 (`Accepted` ADR-0098, Stage 7 `PASS`); the per-file `DRAFT` header is a preserved anchor, not a live source — C-002 source-status resolved by source precedence | Compose Search or Nearby; consume existing discovery contract; no index or ranking system; per-surface V1 mapping remains open (DIT-OD-002) | INHERITED — C-002 source-status RESOLVED; per-surface traceability still OPEN |
| Library Public Profile | docs/30-product/library-marketplace/PRD-021C_C3_LIBRARY_PUBLIC_PROFILE_DRAFT_v0.1.md; ADR-0095–0097; `Accepted` ADR-0098 | PRD-021C C0–C8 are `FROZEN` / `BASELINED` at Rank 3 (`Accepted` ADR-0098); the C3 `DRAFT` header is a preserved anchor — C-002 source-status resolved by source precedence | Compose existing fields; no profile field ownership; analytics is readout only; per-surface V1 mapping remains open (DIT-OD-002) | INHERITED — C-002 source-status RESOLVED; per-surface traceability still OPEN |
| Seat and booking initiation | docs/30-product/library-marketplace/PRD-021C_C4_LIVE_SEAT_AVAILABILITY_AND_BOOKING_DRAFT_v0.1.md; PRD-007 freeze records; `Accepted` ADR-0098 | C4 sits inside the `FROZEN` / `BASELINED` Rank 3 PRD-021C C0–C8 package (`Accepted` ADR-0098); PRD-007 / BC-04 remain the higher-order seat authority — C-002 source-status resolved by source precedence | Use Availability → Shift or Seat → Booking; forward outcome to owner; no duplicate booking, lock, quota, or reservation system; per-surface V1 mapping remains open (DIT-OD-002) | INHERITED / RECOMMENDED — C-002 source-status RESOLVED; per-surface traceability still OPEN |
| Library Community Foundation | docs/30-product/social-graph/PRD-021A_A1_LIBRARY_COMMUNITY_FOUNDATION_DRAFT_v0.2.md; `Accepted` ADR-0087 | PRD-021A A1–A8 are admitted to the baseline at Rank 3 by `Accepted` ADR-0087 (Stage 7 closed); the A1 `DRAFT v0.2` header and the 2026-08-25 `PRD-021A_STAGE7_BLOCKER.md` are byte-unchanged pre-admission anchors, not live sources — C-001 source-status resolved by source precedence | Do not invent public/community permissions or behavior; keep community exploration explicitly gated; Community is V2 per `MASTER_PRD.md` §32 and remains DEFERRED; per-surface mapping open | INHERITED — C-001 source-status RESOLVED; V2 deferral and per-surface traceability still OPEN |
| Availability freshness and failure | applicable C2/C3/C4 source documents and existing developer contracts | INHERITED where specified; otherwise TO BE DECIDED | Show freshness and failure honestly; do not claim real-time or offline write capability | RECOMMENDED |

## 3. Traceability rules

A row is complete when it has a source path, source status, design consequence, design status, owner, and open question if any. A design artifact with no row is not handoff-ready.

This register carries the **upstream** half of the chain — requirement to design treatment. The **downstream** half — design artifact to screen, implementation and QA evidence — is [Design to Implementation Traceability](DESIGN_IMPLEMENTATION_TRACEABILITY.md). Its base register has **0 of 8** rows with a PRD requirement link. The supplemental `DIT-009` feature-level row in §4.2 links to frozen `PRD-005` §20, so the combined count is **1 of 9**; that supplemental link does not resolve which frozen requirement governs the other eight base rows. Closing that base-register gap (`DIT-OD-001`) remains the traceability owner's act, not a documentation-only inference.

## 4. Conflict register

- **CONFLICT C-001 → RESOLVED (source-status, by source precedence).** The apparent status difference is a preserved-anchor condition, not a live conflict: `PRD-021A` A1–A8 are admitted to the baseline at Rank 3 by `Accepted` [`ADR-0087`](../../00-governance/adr/ADR-0087-prd-021a-library-community-a1-a8-rank-3-baseline.md) (Stage 7 closed). The `A1` `DRAFT v0.2` header and the 2026-08-25 `PRD-021A_STAGE7_BLOCKER.md` are byte-unchanged pre-admission records; their *NOT READY / NOT FROZEN* finding is historical, not a live source-status. The baseline/ADR reference is the higher-order authority and stands. ⛔ No source document was modified. The items that remain open are scope/traceability, not source-status: Community stays **DEFERRED** to V2 per `MASTER_PRD.md` §32, and the per-surface V1 mapping is recorded under `DIT-OD-001` / `DIT-OD-002` (still OPEN).
- **CONFLICT C-002 → RESOLVED (source-status, by source precedence).** `PRD-021C` C0–C8 are `FROZEN` / `BASELINED` at Rank 3 by `Accepted` [`ADR-0098`](../../00-governance/adr/ADR-0098-prd-021c-c0-c8-library-marketplace-rank-3-baseline.md), recorded as a `PASS` verdict in [`PRD-021C_C0_C8_STAGE7_FREEZE.md`](../../30-product/library-marketplace/PRD-021C_C0_C8_STAGE7_FREEZE.md). The per-part `DRAFT` headers are preserved anchors (subject bytes unchanged by the admission) and are not live sources; the baseline row is the authority. ⛔ No source document was modified. The items that remain open are scope/traceability, not source-status: behavior not explicit in a frozen record stays **TO BE DECIDED**, and the exact per-surface V1 mapping is recorded under `DIT-OD-001` / `DIT-OD-002` (still OPEN). This source-status resolution does **not** pass `G1`, does **not** close `DBT-008`, and does **not** resolve the top-level navigation decision (Founder/Product Authority).

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

### 5.1 Per-surface source disposition for G1

The traceability matrix above records the current source conflicts and candidates;
it does not constitute a complete screen-level V1 map. Under Option C:

| Surface group | Existing source evidence | Current disposition |
|---|---|---|
| Discovery/search and profile | PRD-021C C2/C3 + ADR-0094/0095–0097; C-002 source-status resolved by `Accepted` ADR-0098 (Rank 3, Stage 7 `PASS`) | **UNRESOLVED** — source-status is resolved, but no surface is approved V1 until the exact per-surface requirement mapping is completed (`DIT-OD-002`, still OPEN) |
| Availability, seat/shift, booking | PRD-007 freeze records and BC-04 authority; PRD-021C C4 source has draft/status conflict | **UNRESOLVED** — PRD-007 is the authority candidate; exact design-state mapping remains required |
| Student/Parent participation | Master PRD identifies V1 roles/modules; individual display/actions still require source-level mapping and guardian scope | **UNRESOLVED per surface** |
| Reception/Manager/Owner operations | Master PRD defines roles, responsibilities, and V1 dashboard compositions; this does not map each implementation screen | **UNRESOLVED per screen/workflow** |
| Community | Master PRD §32 lists Community as V2; C-001 source-status resolved by `Accepted` ADR-0087 (Rank 3, Stage 7 closed) | **DEFERRED from V1** — deferral rests on `MASTER_PRD.md` §32 (V2), not on source-status; per-surface mapping remains open (`DIT-OD-001`/`DIT-OD-002`) |

Accordingly, G1 traceability is still incomplete. No proposed family or observed
implementation surface is promoted to approved V1 scope by this table.
