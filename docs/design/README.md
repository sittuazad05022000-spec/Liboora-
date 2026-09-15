<!-- LIBOORA Design Documentation Foundation | index -->

> This document is design governance and documentation. It does not amend product requirements, architecture decisions, bounded-context ownership, permissions, or backend contracts.
# LIBOORA Design Documentation — Index

| Field | Value |
|---|---|
| Status | PROPOSED — navigation index for the design foundation |
| Owner | Design Documentation Owner |
| Rank | **UNRANKED.** Carries no precedence over any ranked document |
| Purpose | Make this directory navigable and state where each concern lives |

## 1. What this is, and what it is not

This is the **entry point** for `docs/design/`. It is documentation *about*
documentation: it routes a reader to the right artifact and records which
concerns are covered, which are partial, and which are open.

⛔ **It decides nothing.** It confers no approval, no freeze and no baseline
status, and it introduces no design rule that the documents below do not
already carry. Where this index and a document disagree, **the document
wins and this index is the defect.**

The substantive entry point for design *work* remains
[`DESIGN_FOUNDATION.md`](DESIGN_FOUNDATION.md), which owns the authority and
precedence model. This file only helps you find things.

## 2. Two design directories — read this before filing anything

Both exist. They hold different things, and the split is deliberate and
pre-existing.

| | `docs/design/` *(here)* | [`docs/35-design/`](../35-design/README.md) |
|---|---|---|
| **Holds** | Design **foundation** — system, visual language, UX/IA/screen architecture, accessibility, governance, ownership, QA, registers, templates | Per-feature **Design Docs** (`DD-*`) |
| **Scope** | Product-wide and durable | One feature, one bounded context |
| **Organised by** | Concern | Bounded context |
| **Identifier** | `DDR-*` (Design Decision Record) | `DD-*` (Design Doc) |

⚠️ `DDR-*` and `DD-*` are **different prefixes for different things** and must
not be interchanged. See
[`design-decisions/README.md`](design-decisions/README.md) for `DDR-*` and
[`../35-design/README.md`](../35-design/README.md) §3 for `DD-*`.

⛔ **Do not create a third design directory.** If a concern has no home in
either, that is a gap to record here — not a new directory.

## 3. Foundation documents

Read in this order for orientation.

| # | Document | Answers |
|---|---|---|
| 1 | [`DESIGN_FOUNDATION.md`](DESIGN_FOUNDATION.md) | Authority, precedence, vision, non-negotiable principles. **Start here** |
| 2 | [`DESIGN_GOVERNANCE.md`](DESIGN_GOVERNANCE.md) | Status vocabulary, gates `G0`–`G5`, AI boundary, escalation |
| 3 | [`DESIGN_OWNERSHIP.md`](DESIGN_OWNERSHIP.md) | The 15 design roles, their authority and their boundaries |
| 4 | [`UX_ARCHITECTURE.md`](UX_ARCHITECTURE.md) | Task structure, the governed first journey, trust architecture |
| 5 | [`INFORMATION_ARCHITECTURE.md`](INFORMATION_ARCHITECTURE.md) | Content grouping, navigation model, findability |
| 6 | [`USER_FLOWS.md`](USER_FLOWS.md) | Journey sequencing and per-stage evidence |
| 7 | [`SCREEN_ARCHITECTURE.md`](SCREEN_ARCHITECTURE.md) | Screen families, required states, anatomy |
| 8 | [`DESIGN_SYSTEM.md`](DESIGN_SYSTEM.md) | Layering, foundations, component contract, required states |
| 9 | [`VISUAL_LANGUAGE.md`](VISUAL_LANGUAGE.md) | The 2.5D direction, colour/type/depth/motion posture |
| 10 | [`ACCESSIBILITY.md`](ACCESSIBILITY.md) | Required checks, content rules, exception discipline |
| 11 | [`PERFORMANCE.md`](PERFORMANCE.md) | Design-side asset, network and motion posture |
| 12 | [`FIGMA_FOUNDATION.md`](FIGMA_FOUNDATION.md) | File structure, naming, libraries, variables |
| 13 | [`DESIGN_ENGINEERING_HANDOFF.md`](DESIGN_ENGINEERING_HANDOFF.md) | Handoff package and readiness |
| 14 | [`DESIGN_QA.md`](DESIGN_QA.md) | The design acceptance gate and its evidence |
| 15 | [`DESIGN_CHANGE_MANAGEMENT.md`](DESIGN_CHANGE_MANAGEMENT.md) | Change classes `D1`–`D5`, versioning, rollback |

## 4. Registers

A register records **facts and open items**, not guidance.

| Register | Records |
|---|---|
| [`PRD_DESIGN_TRACEABILITY.md`](PRD_DESIGN_TRACEABILITY.md) | PRD requirement → design treatment, plus the `C-*` source-conflict register |
| [`DESIGN_IMPLEMENTATION_TRACEABILITY.md`](DESIGN_IMPLEMENTATION_TRACEABILITY.md) | Design artifact → screen/component → implementation → QA evidence |
| [`SECURITY_PRIVACY_UX.md`](SECURITY_PRIVACY_UX.md) | `SPX-GAP-*` — security/privacy UX gaps, each routed to a named office |
| [`DESIGN_DEBT.md`](DESIGN_DEBT.md) | `DBT-*` — design debt and deprecation, with owner and review trigger |
| [`design-decisions/README.md`](design-decisions/README.md) | `DDR-*` — durable design decisions |

## 5. Templates

[`templates/`](templates/) holds copy-and-fill structures so a new artifact
does not invent its own shape. Templates are **forms, not decisions** — a
filled template carries no authority its content does not earn.

| Template | For |
|---|---|
| [`templates/SCREEN_SPEC_TEMPLATE.md`](templates/SCREEN_SPEC_TEMPLATE.md) | One screen: states, responsive, accessibility, trace |
| [`templates/COMPONENT_SPEC_TEMPLATE.md`](templates/COMPONENT_SPEC_TEMPLATE.md) | One component, against the `DESIGN_SYSTEM.md` §3 contract |
| [`templates/DESIGN_QA_EVIDENCE_TEMPLATE.md`](templates/DESIGN_QA_EVIDENCE_TEMPLATE.md) | One `DESIGN_QA.md` review result |

## 6. Coverage map

⚠️ **Status here describes the *documentation*, not the product.** A `DONE`
row means the concern has an owning document — ⛔ **not** that the design is
approved, implemented or verified. Every foundation document is still
`PROPOSED` or `RECOMMENDED` pending the Founder/Product Authority.

| Concern | Where | Coverage |
|---|---|---|
| Foundation & UX principles | `DESIGN_FOUNDATION.md`, `UX_ARCHITECTURE.md` | Documented |
| Design system, components, states | `DESIGN_SYSTEM.md`, `VISUAL_LANGUAGE.md` | Documented; ⚠️ token values contested — `DBT-001` |
| Accessibility | `ACCESSIBILITY.md` | Documented; ⚠️ target standard `TO BE DECIDED` |
| Information architecture | `INFORMATION_ARCHITECTURE.md` | Documented |
| Navigation & flows | `USER_FLOWS.md`, `INFORMATION_ARCHITECTURE.md` §3 | Documented |
| Screen architecture | `SCREEN_ARCHITECTURE.md` | Documented |
| Feature-level design | [`../35-design/`](../35-design/README.md) | ⭐ **1** Design Doc — [`DD-0001`](../35-design/membership/DD-0001-membership-management-surface-design.md) (`BC-02`); the other 5 contexts have no surface requirements to design from — see [`../35-design/README.md`](../35-design/README.md) §2.2 |
| Responsive behaviour | scattered across 5 documents | ⚠️ **No owning document** — `DBT-002` |
| Figma workflow | `FIGMA_FOUNDATION.md` | Documented |
| Governance & ownership | `DESIGN_GOVERNANCE.md`, `DESIGN_OWNERSHIP.md` | Documented |
| Change management | `DESIGN_CHANGE_MANAGEMENT.md` | Documented |
| Design → engineering handoff | `DESIGN_ENGINEERING_HANDOFF.md` | Documented |
| Design QA | `DESIGN_QA.md` + `templates/` | Documented; ⚠️ evidence base thin — `DBT-004` |
| PRD → Design traceability | `PRD_DESIGN_TRACEABILITY.md` | Documented; 6 rows, 2 open conflicts |
| Design → Implementation traceability | `DESIGN_IMPLEMENTATION_TRACEABILITY.md` | Structure exists; ⚠️ **0 complete rows** by design |
| Security / privacy UX | `SECURITY_PRIVACY_UX.md` | ⚠️ **Gaps recorded, none resolved** |
| Localization / i18n | `ACCESSIBILITY.md` §3 | ⚠️ Partial — `DBT-003` |
| Performance | `PERFORMANCE.md` | Documented; ⚠️ numeric budgets `TO BE DECIDED` |
| Design debt & deprecation | `DESIGN_DEBT.md` | Documented |
| Templates & conventions | `templates/`, `design-decisions/README.md` | Documented |

## 7. Traceability chain

The intended chain, and which link is currently weakest:

```
PRD requirement        → PRD_DESIGN_TRACEABILITY.md        (6 rows)
  → Design artifact    → foundation docs / ../35-design/   (0 Design Docs)
    → Screen/component → SCREEN_ARCHITECTURE.md            (7 families)
      → Implementation → DESIGN_IMPLEMENTATION_TRACEABILITY.md
        → QA evidence  → DESIGN_QA.md + templates/         (1 UI test)
```

⚠️ The chain is **navigable but not yet complete end to end**, and no
document in this directory should be read as claiming otherwise. The
measured weak links are recorded as `DBT-*`.

## 8. Scaling rules

So this space survives many contexts, features and teams:

1. **One concern, one document.** Extend the owning document rather than
   adding a near-duplicate. If you cannot tell which document owns a
   concern, that ambiguity is the thing to fix.
2. **Registers grow by rows, guidance grows by sections.** A new fact is a
   row in a register; a new rule is a section in the owning document.
3. **Per-feature design goes in [`../35-design/`](../35-design/README.md)**,
   by bounded context — never here.
4. **Identifier prefixes are never reused or reassigned** (`DDR-*`, `DD-*`,
   `SPX-GAP-*`, `DBT-*`), matching the `IMPL-*` and `ADR-*` discipline.
5. **Add a row to §6 when a concern gains or loses a home** — an index that
   silently drifts from its directory is worse than none.
6. **Never record an unmade decision as made.** `TO BE DECIDED` with a named
   office is a complete and acceptable entry.
