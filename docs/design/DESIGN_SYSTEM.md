<!-- LIBOORA Design Documentation Foundation | 2026-09-09 -->

> This document is design governance and documentation. It does not amend product requirements, architecture decisions, bounded-context ownership, permissions, or backend contracts.
# LIBOORA Design System

| Field | Value |
|---|---|
| Status | PROPOSED — foundation rules awaiting approval |
| Owner | Design System Owner |
| Implementation | Figma Foundation and approved engineering implementation |

## 1. System shape

The system is layered: foundations → tokens → primitives → components → patterns → screens. A component expresses interaction and state; it does not own a domain, record, permission, or backend contract.

## 2. Foundations

| Foundation | Decision status | Direction |
|---|---|---|
| Color | RECOMMENDED | Semantic roles first: surface, text, border, action, focus, success, warning, danger, information. Never use color alone to communicate state. |
| Typography | RECOMMENDED | Use a readable sans-serif family with clear numeral forms, hierarchy, and stable wrapping on small screens. Exact family and licensed source are TO BE DECIDED. |
| Spacing | RECOMMENDED | Use a consistent base spacing scale and generous grouping; exact token values are TO BE DECIDED in Figma after visual review. |
| Radius | RECOMMENDED | Moderate, consistent radii; avoid pill-shaped everything. |
| Elevation | RECOMMENDED | Small number of semantic levels for grouping and priority, not decoration. |
| Iconography | RECOMMENDED | Familiar, simple, legible icons with labels where ambiguity exists. |
| Illustration | CONFIRMED | About 10% premium 3D-style illustration; compress, lazy-load, and keep the functional UI 2D-first. |
| Motion | RECOMMENDED | Short, purposeful transitions with reduced-motion alternatives; no motion required to understand a task. |

### 2.1 ⚠️ Recorded finding — these values are declared undecided while code defines them

`lib/app/shared/theme.dart` already defines a colour set (`LiblColors`, **12** constants) and a spacing scale (`LiblSpace`, **6** steps), and `theme.dart` predates this document by two days. The table above nonetheless records those foundations as `TO BE DECIDED`.

⛔ **This note does not adopt, approve or ratify those values as design tokens.** Doing so is the **Design System Owner's** act and it has not been taken; recording a code default as design authority by side effect is exactly what [Design Change Management](DESIGN_CHANGE_MANAGEMENT.md) §1 class `D2` requires an approval path for.

The divergence — and the absence of any radius, elevation or type token class against §2's own foundation list — is recorded as [`DESIGN_DEBT.md`](DESIGN_DEBT.md) `DBT-001` and `DBT-005`, routed to the Design System Owner. The as-built inventory is recorded as `DIT-001` in [Design to Implementation Traceability](DESIGN_IMPLEMENTATION_TRACEABILITY.md), whose status is `CONFLICT`.

## 3. Component contract

Use [`templates/COMPONENT_SPEC_TEMPLATE.md`](templates/COMPONENT_SPEC_TEMPLATE.md), whose headings are exactly the eleven items below.

Every component specification records purpose, anatomy, variants, content rules, interaction states, responsive behavior, accessibility behavior, loading and error behavior, performance notes, and source trace links.

## 4. Required states

Every data-dependent or action-bearing component must specify loading, ready, empty, error, offline or stale-data behavior where applicable, disabled or unavailable behavior where applicable, focus, pressed, selected, and validation states. The state must not imply an unsupported capability.

## 5. Reuse and extension

Prefer existing components. Extend only when the new need is traceable and the Design System Owner records why composition or an existing variant is insufficient. A new pattern is not a new product capability.

## 6. System quality bar

The system must remain lightweight, accessible, localizable, responsive, inspectable in Figma, and implementable on low-end Android without heavy effects.
