<!-- LIBOORA Design Documentation Foundation | 2026-09-09 -->

> This document is design governance and documentation. It does not amend product requirements, architecture decisions, bounded-context ownership, permissions, or backend contracts.
# LIBOORA Accessibility

| Field | Value |
|---|---|
| Status | **APPROVED** — accessibility foundation formally adopted, 2026-10-01, Accessibility Owner; recorded in [`G2_FOUNDATION_APPROVAL_RECORD_2026-10-01.md`](G2_FOUNDATION_APPROVAL_RECORD_2026-10-01.md) |
| Owner | Accessibility Owner |
| Target | Design standard: **WCAG 2.1 AA** ratios as adopted by `DDR-0004` (`APPROVED` 2026-09-19 — contrast 4.5:1 / 3:1; functional at 200% text scale). A legal or product compliance standard remains **TO BE DECIDED** — it is outside design authority; Founder/Product Authority confirms scope |

## 1. Accessibility commitment

Accessibility is a design and QA requirement across structure, content, input, state communication, motion, responsive behavior, and performance. It is not a visual polish pass.

## 2. Required design checks

- Keyboard, switch, screen-reader, and touch paths are considered for every action-bearing surface.
- Focus is visible, ordered, persistent through state change, and not trapped without a source-backed reason.
- Text and controls remain understandable at increased text size and narrow widths.
- Color is never the only carrier of status, error, selection, or availability.
- Labels describe the action or content; icon-only controls require a clear accessible name.
- Errors identify the problem and the next safe recovery action without exposing internal identifiers.
- Loading, empty, offline, stale, and unavailable states are perceivable without motion.
- Reduced motion removes nonessential transitions and parallax-like effects.
- Touch targets and spacing are large enough for reliable use. ⭐ **Minimum values are DECIDED** — `DDR-0004` `APPROVED` (2026-09-19): **≥48×48dp** touch targets · **≥8dp** target spacing (full floor recorded in §2.1).

## 2.1 ⭐ Accessibility minimums — DECIDED (`DDR-0004` `APPROVED`)

The following values are **APPROVED** (Founder/Product Authority, 2026-09-19) and govern this
foundation as a floor for **all apps, no exceptions**. They are design minimums — ⛔ they are
*not* a claim of implementation or QA evidence (see §3 and `DIT-007`). The Accessibility
Owner's formal adoption act into this document is **recorded 2026-10-01** in
[`G2_FOUNDATION_APPROVAL_RECORD_2026-10-01.md`](G2_FOUNDATION_APPROVAL_RECORD_2026-10-01.md).

| Minimum | Value | Authority |
|---|---|---|
| Touch target | **≥ 48×48dp** | `DDR-0004` `APPROVED` |
| Target spacing | **≥ 8dp** between adjacent targets | `DDR-0004` `APPROVED` |
| Text contrast | **4.5:1** normal text | `DDR-0004` `APPROVED` |
| Large-text / non-text contrast | **3:1** | `DDR-0004` `APPROVED` |
| Visible focus | **2dp** indicator, **never removed** | `DDR-0004` `APPROVED` |
| Text scaling | Functional at **200%** | `DDR-0004` `APPROVED` |
| Status signalling | Every status carries **icon + text**; ⛔ never colour alone | `DDR-0004` `APPROVED` |
| Reduced motion | Honoured, with a **static final state** | `DDR-0004` `APPROVED` |

Consequence on record (`DDR-0004` consequences, ACCEPTED): the 48dp floor costs vertical
space ⇒ fewer rows per screen; the denser **36px** data row is permitted **only** on
pointer-only **≥ 905dp**. The driver for the icon+text rule: `success` and `warning` share
luminance (5.02 / 4.73), so colour alone can never carry status. Review trigger: WCAG
version change; any request for a sub-48dp control.

## 3. Content and localization

Write for translation, dynamic text length, plain-language comprehension, and Indian mobile context without embedding assumptions that the PRD does not make. Exact supported languages are **TO BE DECIDED**.

⚠️ **Implementation status, measured:** **0** occurrences of `Semantics`,
`semanticsLabel`, `meetsGuideline` or `textScaleFactor` under `lib/`, and
**0** accessibility assertions under `test/`. The checks above are specified
and currently unimplemented — recorded as `DIT-007` in
[Design to Implementation Traceability](DESIGN_IMPLEMENTATION_TRACEABILITY.md).

## 4. Exceptions

An accessibility exception requires the affected surface, user impact, reason, mitigation, owner, expiry or review date, and Founder/Product Authority or Design Governance approval. “Hard to implement” is not an exception record.
