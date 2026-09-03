# `DEVELOPER/` — derived documentation for `PRD-021C` C0–C8

| Field | Value |
|---|---|
| **Status of these documents** | **Derived.** ⛔ They carry **no authority** |
| **Authority** | [`../PRD/`](../PRD/) (the nine frozen subjects) · the **`Accepted`** ADRs in [`../ADR/`](../ADR/) · [`../ARCHITECTURE/`](../ARCHITECTURE/) |
| **Written for** | This package. ⚠ The repository contained **no** `PRD-021C` developer documentation — measured, see §3 |
| **Invented content** | ⛔ **None.** Where the authorities are silent, these documents say so |

---

## 1. The rule that governs every document in this directory

> **When a document in `DEVELOPER/` and a document in `PRD/` disagree, `PRD/`
> wins, and the disagreement is a defect in the `DEVELOPER/` document.**
> Report it. ⛔ Do **not** resolve it in code.

`PRD-021C` C0–C8 is **FROZEN / BASELINED at Rank 3**. Nothing in this directory
may be read as amending it. These documents **reorganise** the frozen sources
for implementation; they add no requirement, no acceptance criterion, no
identifier, no event, no edge and no decision.

---

## 2. ⭐⭐ The one thing to understand before opening anything else

**`PRD-021C` owns almost nothing that it displays.**

The marketplace is **not a bounded context**. It is a **read-composition and
initiation surface** over contexts that already own every entity, field, rule
and event it presents. C0 **§3.2** states the ownership position exactly:

> | **Nothing else** | ⛔ No aggregate. ⛔ No invariant. ⛔ No business state. ⛔ No stored price, seat, membership, index or media byte |

Consequences an implementer meets immediately, each measured from the frozen text:

| Fact | Value | Source |
|---|---|---|
| New bounded contexts | **0** | C0 **L533**; context count stays **31** |
| New domain events | **0** | C8 `LMT-XC-008`; C0 §3.3 |
| New integration edges | **0** | C8 `LMT-XC-009`; edge set stays **29** |
| New tables, columns, migrations | **0** | C8 `LMT-FR-006` |
| Bookings defined | **0** | C4 **L17** — *"BOOKING IS ALREADY OWNED, FROZEN, BY `PRD-007`"* |

Read [`ARCHITECTURE_AND_BOUNDARIES.md`](./ARCHITECTURE_AND_BOUNDARIES.md) first.
An implementer who has not internalised the composition rule will write the one
class of defect this specification is most concerned to prevent: **a marketplace
that stores, derives or re-decides something an owning context already owns.**

---

## 3. Why these documents exist at all

The instruction governing this package requires developer documentation, and
permits authoring it **only** where it is genuinely missing.

**Measured before writing.** `git ls-files docs/ | grep -icE 'developer'`
returns **3**, and none of the three is a `PRD-021C` document:

| Existing developer document | Subject |
|---|---|
| `DEVELOPER_GUIDE.md` (repository root) | Repository-wide |
| `docs/40-implementation/DEVELOPER_HANDOFF.md` | Repository-wide — **included** at [`../IMPLEMENTATION/`](../IMPLEMENTATION/) |
| `docs/40-implementation/seat-management/PRD-007_DEVELOPER_GUIDE.md` | `PRD-007`, a **different** subject |

So `PRD-021C` developer documentation was **genuinely missing**, and these
documents were derived from the frozen PRD and the existing architecture.
⛔ The two repository-wide documents were **packaged unchanged** rather than
rewritten.

---

## 4. The documents

| # | Document | What it gives you | Required topics covered |
|---|---|---|---|
| 1 | [`ARCHITECTURE_AND_BOUNDARIES.md`](./ARCHITECTURE_AND_BOUNDARIES.md) | The composition model, module placement, the dependency law, and the boundaries that must not move | architecture/boundaries · BC ownership · availability/booking boundaries |
| 2 | [`OWNERSHIP_AND_DATA.md`](./OWNERSHIP_AND_DATA.md) | Who owns every entity and field on every surface; the two index classes; tenant isolation | data/entity ownership · tenant isolation |
| 3 | [`API_AND_CONTRACTS.md`](./API_AND_CONTRACTS.md) | Contract expectations, ports, idempotency, pagination, rate limiting — and why there is no endpoint table | API/contract expectations |
| 4 | [`INTEGRATIONS_AND_EVENTS.md`](./INTEGRATIONS_AND_EVENTS.md) | The edges the marketplace may use, the events it may consume, and the delivery contract it inherits | integrations · events |
| 5 | [`AUTHORIZATION_AND_SECURITY.md`](./AUTHORIZATION_AND_SECURITY.md) | The authentication boundary, server-side authorisation, and the security obligations | authorization · security |
| 6 | [`SEARCH_RANKING_AND_DISCOVERY.md`](./SEARCH_RANKING_AND_DISCOVERY.md) | What C2 and C6 do and do not own; ordering vs ranking; determinism | search/ranking |
| 7 | [`ANALYTICS_AND_OBSERVABILITY.md`](./ANALYTICS_AND_OBSERVABILITY.md) | `BC-26` as sole analytics authority; the certified/not-certified split; telemetry and audit | analytics · observability |
| 8 | [`ERROR_AND_FAILURE_HANDLING.md`](./ERROR_AND_FAILURE_HANDLING.md) | Degraded modes, the forbidden substitutions, consistency | error/failure handling |
| 9 | [`TESTING_REQUIREMENTS.md`](./TESTING_REQUIREMENTS.md) | What must be tested, drawn from the **123** acceptance criteria — including the absence tests | testing requirements |
| 10 | [`IMPLEMENTATION_TASK_REFERENCE.md`](./IMPLEMENTATION_TASK_REFERENCE.md) | The **44** tasks `IMPL-1750`…`IMPL-1793`, referenced — ⛔ not re-invented | implementation task references |

All **16** required topics are covered. Coverage, and the evidence for each, is
tabulated in [`ARCHITECTURE_AND_BOUNDARIES.md`](./ARCHITECTURE_AND_BOUNDARIES.md) §8.

---

## 5. Reading order

1. This file.
2. [`ARCHITECTURE_AND_BOUNDARIES.md`](./ARCHITECTURE_AND_BOUNDARIES.md) — **the one you cannot skip.**
3. [`OWNERSHIP_AND_DATA.md`](./OWNERSHIP_AND_DATA.md) — then you know what you may and may not store.
4. [`../ADR/ADR-0098-prd-021c-c0-c8-library-marketplace-rank-3-baseline.md`](../ADR/ADR-0098-prd-021c-c0-c8-library-marketplace-rank-3-baseline.md) — the admitting decision.
5. [`../PRD/`](../PRD/) — **C0 in full**, then the part you are building.
6. The remaining `DEVELOPER/` documents as your work touches them.
7. [`../IMPLEMENTATION/PRD-021C_IMPLEMENTATION_TASKS.md`](../IMPLEMENTATION/PRD-021C_IMPLEMENTATION_TASKS.md) — your task and its stated boundary.

---

## 6. ⛔ Stage 8 has not been performed

**No application code exists for `PRD-021C`, and none is included here.**
`PRD_LIFECYCLE.md` **L182** places code at **Stage 8**, which has **not** been
entered. The **44** tasks are a *plan*, not a record of work done.
See [`../README.md`](../README.md) §5.
