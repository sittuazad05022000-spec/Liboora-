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

## 3. Component contract

Every component specification records purpose, anatomy, variants, content rules, interaction states, responsive behavior, accessibility behavior, loading and error behavior, performance notes, and source trace links.

## 4. Required states

Every data-dependent or action-bearing component must specify loading, ready, empty, error, offline or stale-data behavior where applicable, disabled or unavailable behavior where applicable, focus, pressed, selected, and validation states. The state must not imply an unsupported capability.

## 5. Reuse and extension

Prefer existing components. Extend only when the new need is traceable and the Design System Owner records why composition or an existing variant is insufficient. A new pattern is not a new product capability.

## 6. System quality bar

The system must remain lightweight, accessible, localizable, responsive, inspectable in Figma, and implementable on low-end Android without heavy effects.
