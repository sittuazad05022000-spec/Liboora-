<!-- LIBOORA Design Documentation Foundation | screen specification template -->

> This document is design governance and documentation. It does not amend product requirements, architecture decisions, bounded-context ownership, permissions, or backend contracts.
# Screen Specification — TEMPLATE

> **How to use.** Copy this file, rename it for the screen, and delete this
> block. ⛔ **Do not edit this template to describe a real screen.**
>
> ⛔ **A filled template carries no authority its content has not earned.**
> The form does not confer approval, and a complete-looking document with
> invented sources is worse than an incomplete honest one.
>
> ⭐ **`TO BE DECIDED` with a named office is a complete answer.** Leave it
> rather than guessing — [`../DESIGN_GOVERNANCE.md`](../DESIGN_GOVERNANCE.md)
> §2 makes it a first-class status.

| Field | Value |
|---|---|
| Screen | *Name as used in [`../SCREEN_ARCHITECTURE.md`](../SCREEN_ARCHITECTURE.md) §1* |
| Screen family | *One of the families in `SCREEN_ARCHITECTURE.md` §1* |
| Status | `PROPOSED` / `APPROVED` / `TO BE DECIDED` / `CONFLICT` |
| Owner | *Design role — ⛔ never a personal name* |
| Figma frame | *Canonical link, or `NONE`* |
| Date | `YYYY-MM-DD` |

## 1. Purpose

*The one task this screen exists to complete. If it needs two sentences
joined by "and", it may be two screens.*

## 2. Source trace

⛔ Cite; never restate a requirement as if this document owned it.

| Link | Value |
|---|---|
| PRD requirement | *Identifier + path, or `NONE OBSERVED`* |
| Upstream design row | *[`../PRD_DESIGN_TRACEABILITY.md`](../PRD_DESIGN_TRACEABILITY.md) row, or `NONE`* |
| Downstream trace row | *`DIT-NNN` in [`../DESIGN_IMPLEMENTATION_TRACEABILITY.md`](../DESIGN_IMPLEMENTATION_TRACEABILITY.md), or `NOT YET FILED`* |
| Owning bounded context | *`BC-nn`, or `TO BE DECIDED`* |

⚠️ If the PRD row is `NONE OBSERVED`, this screen is **not handoff-ready**
([`../DESIGN_QA.md`](../DESIGN_QA.md) §1). Record it; do not invent a
requirement to fill the cell.

## 3. Anatomy

*Per [`../SCREEN_ARCHITECTURE.md`](../SCREEN_ARCHITECTURE.md) §2: context
header → primary state → supporting content → recovery → navigation.*

## 4. States

⛔ A screen with only a ready state is **not** ready
([`../DESIGN_ENGINEERING_HANDOFF.md`](../DESIGN_ENGINEERING_HANDOFF.md) §2).

| State | Required? | Behaviour | Notes |
|---|---|---|---|
| Loading | | | |
| Ready | yes | | |
| Empty | | | *Distinguish "no data yet" from "no results for this filter"* |
| Error | | | *Name the problem and the next safe action; ⛔ no internal identifiers* |
| Offline / stale | | | ⛔ Do not invent cache semantics or offline writes |
| Permission denied | | | ⚠️ Hidden vs visible-and-disabled is **security-relevant** — see [`../SECURITY_PRIVACY_UX.md`](../SECURITY_PRIVACY_UX.md) `SPX-GAP-006` |

## 5. Data and ownership

| Block | Source owner | Freshness | Fallback |
|---|---|---|---|
| | | | |

⛔ **A screen composes from the owning capability; it owns no field**
([`../UX_ARCHITECTURE.md`](../UX_ARCHITECTURE.md) §1).

⚠️ **Boundary check.** If this screen needs data not currently projected to
the `app` module, that is an **engineering seam question** for the
Architecture Owner, not a design decision — see
[`../DESIGN_IMPLEMENTATION_TRACEABILITY.md`](../DESIGN_IMPLEMENTATION_TRACEABILITY.md)
§5.

## 6. Responsive behaviour

| Width | Behaviour |
|---|---|
| Narrow mobile | |
| Wider mobile | |
| Larger widths | |

⚠️ **Breakpoint values are `TO BE DECIDED`** — the Responsive Design Owner
owns them and no artifact defines them yet
([`../DESIGN_DEBT.md`](../DESIGN_DEBT.md) `DBT-002`). ⛔ **Do not invent
pixel values here.**

## 7. Accessibility

*Against the **9** checks in [`../ACCESSIBILITY.md`](../ACCESSIBILITY.md) §2.*

| Check | Treatment |
|---|---|
| Keyboard / switch / screen-reader path | |
| Focus order and visibility | |
| Increased text size | |
| Non-colour state cues | |
| Accessible names for icon-only controls | |
| Error identification and recovery | |
| Perceivable without motion | |
| Reduced motion | |
| Touch target size | ⚠️ Minimums are `TO BE DECIDED` against the unselected standard |

Exceptions require the full record in `ACCESSIBILITY.md` §4 — ⛔ "hard to
implement" is not an exception.

## 8. Performance

*Per [`../PERFORMANCE.md`](../PERFORMANCE.md). Numeric budgets are
`TO BE DECIDED`; ⛔ do not state one here.*

## 9. Security and privacy

⛔ **Do not depict a behaviour no source defines.** If this screen shows
personal data, consent, session or failure detail, cite the governing
`SPX-GAP-*` row in [`../SECURITY_PRIVACY_UX.md`](../SECURITY_PRIVACY_UX.md)
and mark the behaviour `TO BE DECIDED`.

| Concern | Applies? | Source / gap |
|---|---|---|
| Personal data on screen | | `SPX-GAP-003` |
| Consent | | `SPX-GAP-001` |
| Minor-facing | | `SPX-GAP-002` |
| Auth failure messaging | | `SPX-GAP-004` |
| Tenant identification | | `SPX-GAP-007` |

## 10. Content and localization

*Per [`../ACCESSIBILITY.md`](../ACCESSIBILITY.md) §3. Supported languages
are `TO BE DECIDED`; ⛔ do not assume a language set
([`../DESIGN_DEBT.md`](../DESIGN_DEBT.md) `DBT-003`).*

## 11. Open questions

| # | Question | Owning office | Status |
|---|---|---|---|
| | | | |
