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
| Discover | Public library search and nearby discovery | Frozen Library PRD §§14A.3–.4, `14B` `LIB-14B.2`–`.6`; Master PRD §8 module 19 | **RETAINED — V1, source-bounded** |
| Library | Public library profile and approved public facts | Frozen Library PRD §14A.5 and `14B` `LIB-14B.7`–`.10` | **RETAINED — V1, allow-list only** |
| Study access | Aggregate public availability; authenticated student seat viewing/booking follows BC-04 | Frozen `14B` `LIB-14B.11`–`.14`; frozen PRD-007 `SEAT-FR-076`–`.086` | **RETAINED — V1, audience-bounded** |
| My participation | Student management, parent portal, attendance and fee compositions from their own authorities | Master PRD §8 modules 3–5, 8–9; frozen PRD-004/006; PRD-008 remains DRAFT | **RETAINED — V1 compositions; source status preserved** |
| Operations | Owner, Manager and Reception dashboard compositions; role-specific workflows remain owned by their source PRDs | Master PRD §8 modules 10–12; PRD-007, PRD-006 and PRD-008 as applicable | **RETAINED — composition only; no inferred widget set** |
| Community | No V1 information group | Master PRD §5.2 `MP-SCOPE-04` and §8 V2 roadmap | **DEFERRED — V2** |

## 3. Navigation model

No V1 navigation hierarchy or labels are established by the cited sources, so they remain **TO BE DECIDED**. The permitted destination groups are limited to the retained groups in §2 and each destination must respect its audience and source boundary. Explicitly deferred screens (`ops_page.dart`, `overview_page.dart`, `staff_app_shell.dart`, `student_app_shell.dart`, `student_subject.dart`) and Community are not V1 destinations. A backend entity or implementation file alone does not authorize one.

## 4. Findability rules

Public Search/Nearby is the entry to Library discovery under frozen Library PRD §14A.4. Results and profiles expose only the §14A.5 allow-list. Public seat information is aggregate/coarse only (`LIB-14B.11`–`.14`); seat selection and booking require the protected-operation boundary and follow PRD-007. Do not create duplicate discovery, seat, or booking authorities.

## 5. Content model

Each content block is tagged in design with its source owner, freshness expectation, visibility rule if specified, and fallback state. Where the source does not define a visibility rule, the block is TO BE DECIDED—not assumed public.

## 6. V1 scope reconciliation — Founder/Product Authority decision

**PRODUCT SCOPE DECISION — OPTION C (2026-09-30), RECONCILED:** The V1 group boundary
and source-bounded retained groups are recorded in §2. Neither draft screen proposals
nor observed files independently authorize scope.

The retained boundary includes public discovery/profile under frozen Library PRD,
private student seat/booking under frozen PRD-007, the V1 Student/Parent and operational
compositions in Master PRD §8, and only source-backed facts within each. Community and
unsupported screen files are deferred. Navigation labels remain undecided; this does not
define permissions, backend behavior, implementation approval, or a separate G1 act.
