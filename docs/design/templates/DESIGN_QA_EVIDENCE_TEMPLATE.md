<!-- LIBOORA Design Documentation Foundation | design QA evidence template -->

> This document is design governance and documentation. It does not amend product requirements, architecture decisions, bounded-context ownership, permissions, or backend contracts.
# Design QA Evidence — TEMPLATE

> **How to use.** Copy this file, rename it for the review, and delete this
> block. ⛔ **Do not edit this template to record a real review.**
>
> The checks below are those [`../DESIGN_QA.md`](../DESIGN_QA.md) §1 already
> specifies. ⛔ This template adds no new check and lowers no bar.
>
> ⛔ **A completed form is not a pass.** [`../DESIGN_QA.md`](../DESIGN_QA.md)
> §2 requires evidence identifying **artifact version and reviewer role** —
> a ticked box with no evidence is not evidence.

| Field | Value |
|---|---|
| Artifact reviewed | *Screen, component or flow* |
| Artifact version | *⛔ Required — `DESIGN_QA.md` §2* |
| Reviewer role | *⛔ Design role, never a personal name* |
| Date | `YYYY-MM-DD` |
| Result | `APPROVED` / `RETURNED` / `TO BE DECIDED` / `CONFLICT` |

## 1. Result

*One sentence. If `RETURNED`, name the blocking condition from
[`../DESIGN_QA.md`](../DESIGN_QA.md) §3.*

## 2. Checks

Mark each `PASS`, `FAIL`, `N/A` or `TO BE DECIDED`. ⛔ Every non-`PASS`
needs a note. ⛔ **`N/A` requires a reason** — an unexplained `N/A` is how a
check quietly disappears.

### 2.1 Source and scope

| Check | Result | Evidence / note |
|---|---|---|
| Source paths and statuses recorded | | |
| ⛔ No frozen PRD, ADR, architecture map, permission, BC owner or backend changed or invented | | |
| Every design claim has a traceability row or explicit status label | | |

### 2.2 UX and IA

| Check | Result | Evidence / note |
|---|---|---|
| Entry, context, primary action, completion, failure, recovery, return path clear | | |
| Governed journey order respected where applicable | | |
| ⛔ Search, marketplace, seat, membership, analytics, booking not duplicated | | |

### 2.3 Visual and component

| Check | Result | Evidence / note |
|---|---|---|
| 2.5D ratio and exclusions respected | | |
| Components from the design system, with required states | | |
| Illustration, effects and motion earn their cost | | |
| Tokens used rather than ad-hoc values | | ⚠️ See `DBT-001`/`DBT-005` — token authority is unsettled |

### 2.4 Accessibility

| Check | Result | Evidence / note |
|---|---|---|
| Focus, names, labels, contrast | | |
| Text scaling | | |
| Non-colour cues | | |
| Reduced motion | | |
| Error recovery | | |
| Exceptions recorded with owner and expiry | | |

⚠️ **The target standard is `TO BE DECIDED`**
([`../ACCESSIBILITY.md`](../ACCESSIBILITY.md) header). Record what was
checked against **what** — ⛔ do not assert conformance to an unselected
standard.

### 2.5 Responsive and performance

| Check | Result | Evidence / note |
|---|---|---|
| Narrow mobile, wider mobile, larger widths shown where relevant | | ⚠️ No breakpoints defined — `DBT-002` |
| Long content, slow network, offline/stale, missing assets, low-end device considered | | |

### 2.6 Security and privacy

⛔ Not in `DESIGN_QA.md` §1's original list; included because
[`../SECURITY_PRIVACY_UX.md`](../SECURITY_PRIVACY_UX.md) §5 imposes a
restraint that a reviewer must check. ⛔ **It adds no security
requirement.**

| Check | Result | Evidence / note |
|---|---|---|
| ⛔ No security or privacy behaviour depicted that no source defines | | |
| Any such behaviour marked `TO BE DECIDED` and citing its `SPX-GAP-*` row | | |

### 2.7 Handoff

| Check | Result | Evidence / note |
|---|---|---|
| Figma artifact canonical, versioned, linked | | |
| Engineering questions and unresolved decisions visible | | |
| Downstream `DIT-NNN` row filed | | |

## 3. Evidence attached

*Figma review record, annotated screenshots, state matrix, accessibility
review, asset report or implementation comparison
([`../DESIGN_QA.md`](../DESIGN_QA.md) §2).*

| # | Evidence | Type | Location |
|---|---|---|---|
| | | | |

⚠️ **On automated evidence.** The repository currently contains **1**
`testWidgets` assertion in total
([`../DESIGN_DEBT.md`](../DESIGN_DEBT.md) `DBT-004`), so for nearly every
surface automated UI evidence **does not exist**. Record that honestly as
`NONE OBSERVED`; ⛔ do not cite the **819**-test suite as UI evidence — it
overwhelmingly tests domain rules, not screens.

## 4. Blocking conditions found

*Per [`../DESIGN_QA.md`](../DESIGN_QA.md) §3: unresolved source conflict ·
missing critical state · inaccessible essential action · unsupported
capability claim · duplicate system behaviour · performance treatment
violating the foundation.*

| # | Condition | Affected surface | Owning office |
|---|---|---|---|
| | | | |

## 5. Follow-up

| # | Item | Owning office | Status |
|---|---|---|---|
| | | | |
