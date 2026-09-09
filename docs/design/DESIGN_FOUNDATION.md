<!-- LIBOORA Design Documentation Foundation | 2026-09-09 -->

> This document is design governance and documentation. It does not amend product requirements, architecture decisions, bounded-context ownership, permissions, or backend contracts.
# LIBOORA Design Foundation

| Field | Value |
|---|---|
| Status | PROPOSED — design foundation awaiting Founder/Product Authority approval |
| Source of truth | Locked repository PRD, architecture, ADR, and developer documentation |
| Visual direction | CONFIRMED — lightweight premium 2.5D: about 70% clean 2D, 20% subtle depth, 10% premium 3D-style illustration |
| Delivery posture | RECOMMENDED — mobile-first, accessible, low-end Android and low/intermittent network aware |

## 1. Purpose

This is the entry point for LIBOORA design work. It establishes a common language for product design, Figma work, handoff, QA, and change control while keeping product and architecture authority in the existing repository records.

## 2. Authority and precedence

1. FROZEN — applicable PRDs, the locked Documentation Baseline, and accepted ADRs.
2. INHERITED — architecture maps, bounded-context ownership, developer contracts, and existing implementation documentation.
3. CONFIRMED — decisions explicitly supplied in the design brief, including the visual foundation and AI governance.
4. APPROVED — only a decision expressly approved by the Founder/Product Authority or by the repository governance mechanism.
5. RECOMMENDED / PROPOSED — design guidance in this foundation until approved.
6. TO BE DECIDED — a real product, policy, architecture, or authority question not answered by the sources.
7. CONFLICT — two repository sources or a source and a design request disagree; design does not resolve it silently.

## 3. Design vision

**PROPOSED:** LIBOORA should make library operations and library discovery feel calm, legible, dependable, and efficient. The interface should reduce uncertainty around the next action without making claims about availability, membership, seating, booking, analytics, or community authority that the source system cannot support.

The product should feel premium through hierarchy, spacing, typography, illustration restraint, and trustworthy state communication—not through visual weight.

## 4. Non-negotiable design principles

| Principle | Status | Rule |
|---|---|---|
| Source fidelity | INHERITED | Design may express existing requirements; it may not create a new capability or ownership boundary. |
| Clarity before decoration | RECOMMENDED | The primary task, current state, and next safe action remain obvious. |
| Trust through evidence | RECOMMENDED | Show freshness, limitations, and failure reasons when source data may be stale or incomplete. |
| Mobile first | CONFIRMED | Start with narrow mobile layouts and scale up; do not treat desktop as the reference surface. |
| Low-end respect | CONFIRMED | Avoid heavy assets, expensive effects, and interaction patterns that punish constrained devices. |
| Accessible by default | RECOMMENDED | Accessibility is designed into structure, content, states, motion, and input—not added at review time. |
| One capability, one owner | INHERITED | Search, marketplace, seats, membership, analytics, and booking are composed from their existing owners; no duplicate system is introduced. |
| Honest progress | RECOMMENDED | Loading, empty, error, offline, and permission states explain what is known and what can happen next. |

## 5. Visual foundation

**CONFIRMED:** lightweight premium 2.5D. The default surface is clean 2D. Depth is reserved for grouping, focus, hierarchy, and physical affordance. Premium 3D-style illustration is reserved for selected explanatory or brand moments.

**RECOMMENDED exclusions:** heavy 3D/WebGL, excessive animation, excessive blur or glass effects, ornamental gradients that reduce contrast, and generic AI-dashboard visual language.

## 6. Required foundation artifacts

- [Design Governance](DESIGN_GOVERNANCE.md)
- [Design Ownership](DESIGN_OWNERSHIP.md)
- [Design System](DESIGN_SYSTEM.md)
- [UX Architecture](UX_ARCHITECTURE.md)
- [Information Architecture](INFORMATION_ARCHITECTURE.md)
- [User Flows](USER_FLOWS.md)
- [Screen Architecture](SCREEN_ARCHITECTURE.md)
- [Visual Language](VISUAL_LANGUAGE.md)
- [Accessibility](ACCESSIBILITY.md)
- [Performance](PERFORMANCE.md)
- [Figma Foundation](FIGMA_FOUNDATION.md)
- [PRD to Design Traceability](PRD_DESIGN_TRACEABILITY.md)
- [Design to Engineering Handoff](DESIGN_ENGINEERING_HANDOFF.md)
- [Design QA](DESIGN_QA.md)
- [Design Change Management](DESIGN_CHANGE_MANAGEMENT.md)
- [Design Decision Records](design-decisions/README.md)

## 7. First governed journey

**INHERITED / CONFIRMED:** Library Search First: Search or Nearby → Library Profile → Availability → Shift or Seat → Booking. This is a design sequence, not a new booking or search backend. Existing ownership and source contracts remain authoritative at each step.

## 8. Completion rule

The foundation is complete only when each artifact has an owner, status labels, source references, link validation, traceability coverage, and an explicit record for unresolved decisions.
