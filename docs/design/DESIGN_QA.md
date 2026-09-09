<!-- LIBOORA Design Documentation Foundation | 2026-09-09 -->

> This document is design governance and documentation. It does not amend product requirements, architecture decisions, bounded-context ownership, permissions, or backend contracts.
# LIBOORA Design QA

| Field | Value |
|---|---|
| Status | PROPOSED — design QA gate |
| Owner | Design QA Owner |
| Result vocabulary | APPROVED, RETURNED, TO BE DECIDED, CONFLICT |

## 1. QA checklist

### Source and scope
- Source paths and statuses are recorded.
- No frozen PRD, ADR, architecture map, permission, BC owner, or backend system was changed or invented.
- Every new design claim has a traceability row or an explicit status label.

### UX and IA
- Entry point, current context, primary action, completion, failure, recovery, and return path are clear.
- Library discovery follows Search or Nearby → Library Profile → Availability → Shift or Seat → Booking.
- Search, marketplace, seat, membership, analytics, and booking are not duplicated.

### Visual and component
- The 2.5D ratio and exclusions are respected.
- Components use the design system and show required states.
- Illustration, effects, and motion earn their cost.

### Accessibility
- Focus, names, labels, contrast, text scaling, non-color cues, reduced motion, and error recovery are reviewed.
- Any exception is documented with owner and expiry/review.

### Responsive and performance
- Narrow mobile, wider mobile, and larger-width behavior are shown where relevant.
- Long content, slow network, offline or stale data, missing assets, and low-end device behavior are considered.

### Handoff
- Figma artifact is canonical, versioned, and linked.
- Engineering questions and unresolved decisions are visible.

## 2. Evidence

QA evidence may be a Figma review record, annotated screenshots, a state matrix, accessibility review, asset report, or implementation comparison. Evidence must identify artifact version and reviewer role.

## 3. Blocking conditions

Design QA returns work for unresolved source conflict, missing critical state, inaccessible essential action, unsupported capability claim, duplicate system behavior, or a performance treatment that violates the foundation.
