<!-- LIBOORA Design Documentation Foundation | component specification template -->

> This document is design governance and documentation. It does not amend product requirements, architecture decisions, bounded-context ownership, permissions, or backend contracts.
# Component Specification — TEMPLATE

> **How to use.** Copy this file, rename it for the component, and delete
> this block. ⛔ **Do not edit this template to describe a real component.**
>
> The headings below are the **11 items** that
> [`../DESIGN_SYSTEM.md`](../DESIGN_SYSTEM.md) §3 already requires of every
> component specification. ⛔ This template adds no twelfth requirement.
>
> ⛔ **A component expresses interaction and state. It does not own a
> domain, record, permission or backend contract**
> ([`../DESIGN_SYSTEM.md`](../DESIGN_SYSTEM.md) §1).

| Field | Value |
|---|---|
| Component | *Name* |
| Layer | `primitive` / `component` / `pattern` *(per `DESIGN_SYSTEM.md` §1)* |
| Status | `PROPOSED` / `APPROVED` / `TO BE DECIDED` / `CONFLICT` |
| Owner | *Design role — ⛔ never a personal name* |
| Figma component | *Canonical link, or `NONE`* |
| Implementation | *`lib/…` path, or `NONE OBSERVED`* |
| Date | `YYYY-MM-DD` |

## 1. Purpose

*What this component is for, and the interaction it expresses.*

## 2. Anatomy

*Named parts, and which are required vs optional.*

## 3. Variants

| Variant | When to use | Differs by |
|---|---|---|
| | | |

⚠️ **Before adding a variant**, [`../DESIGN_SYSTEM.md`](../DESIGN_SYSTEM.md)
§5 requires the Design System Owner to record why composition or an existing
variant is insufficient. ⛔ **A new pattern is not a new product capability.**

## 4. Content rules

*Length limits, truncation, empty text, numerals. ⛔ Write for translation
and text expansion — supported languages are `TO BE DECIDED`
([`../DESIGN_DEBT.md`](../DESIGN_DEBT.md) `DBT-003`).*

## 5. Interaction states

⛔ Required for every data-dependent or action-bearing component
([`../DESIGN_SYSTEM.md`](../DESIGN_SYSTEM.md) §4).

| State | Applies? | Behaviour |
|---|---|---|
| Default | yes | |
| Hover / focus | | *Focus must be visible and must survive state change* |
| Pressed | | |
| Selected | | |
| Disabled / unavailable | | ⚠️ Distinguish "not permitted" from "not possible right now" |
| Loading | | |
| Empty | | |
| Error / validation | | |
| Offline / stale | | |

⛔ **A state must not imply a capability the source does not support**
([`../DESIGN_SYSTEM.md`](../DESIGN_SYSTEM.md) §4).

## 6. Responsive behaviour

⚠️ **Breakpoint values are `TO BE DECIDED`** (`DBT-002`). Describe
*adaptation* — wrap, stack, truncate, reflow — ⛔ **not pixel thresholds.**

## 7. Accessibility behaviour

| Check | Treatment |
|---|---|
| Accessible name | *Required for any icon-only control* |
| Role / semantics | |
| Keyboard operation | |
| Focus treatment | |
| Non-colour state cue | ⛔ Colour alone may never carry state |
| Text scaling | |
| Reduced motion | |

## 8. Loading and error behaviour

*What is shown while data is pending, and on failure. ⛔ Errors name the
problem and the next safe action without exposing internal identifiers
([`../ACCESSIBILITY.md`](../ACCESSIBILITY.md) §2).*

## 9. Performance notes

*Asset weight, effect cost, reuse. Per
[`../PERFORMANCE.md`](../PERFORMANCE.md) §4, blur, backdrop filters,
continuous animation and parallax are **exceptions requiring explicit
justification**. Numeric budgets are `TO BE DECIDED`.*

## 10. Tokens used

| Token class | Tokens |
|---|---|
| Colour | |
| Spacing | |
| Radius | ⚠️ **No radius token class exists** — `DBT-005` |
| Elevation | ⚠️ **No elevation token class exists** — `DBT-005` |
| Type | ⚠️ **No type token class exists** — `DBT-005` |

⚠️⚠️ **Read `DBT-001` before filling this section.**
[`../DESIGN_SYSTEM.md`](../DESIGN_SYSTEM.md) §2 records token values as
`TO BE DECIDED`, while `lib/app/shared/theme.dart` already defines
`LiblColors` (**12** colours) and `LiblSpace` (**6** steps). ⛔ **Citing a
code constant here does not ratify it as a design token** — that is the
Design System Owner's act, and it has not been taken
([`../DESIGN_DEBT.md`](../DESIGN_DEBT.md) `DBT-001`).

## 11. Source trace

| Link | Value |
|---|---|
| Screen(s) using this | |
| Upstream design row | *[`../PRD_DESIGN_TRACEABILITY.md`](../PRD_DESIGN_TRACEABILITY.md), or `NONE`* |
| Downstream trace row | *`DIT-NNN`, or `NOT YET FILED`* |
| QA evidence | *Test path + name, or `NONE OBSERVED`* |

## 12. Open questions

| # | Question | Owning office | Status |
|---|---|---|---|
| | | | |
