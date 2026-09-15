<!-- LIBOORA Design Documentation | central Design Doc space -->

> This README defines where Design Docs live and how they are named. It is
> **documentation about documentation**. It does **not** amend product
> requirements, architecture decisions, bounded-context ownership,
> permissions, ranks, precedence or backend contracts, and it confers no
> authority that the governance layer has not already conferred.

# Liboora — Design Documentation (`docs/35-design/`)

| Field | Value |
|---|---|
| **Purpose** | The single home for new Liboora **Design Docs** |
| **Status** | `PROPOSED` — structure and conventions, pending Founder/Product Authority approval |
| **Rank** | **UNRANKED.** Carries no precedence over any ranked document |
| **Created at** | `9379676` |

---

## 1. Purpose

A **Design Doc** records *how* a feature will be built: the shape of the
solution, the options considered, the trade-offs taken, and the consequences.
It sits between a requirement (*what* and *why*) and the code (*the thing
itself*).

This directory exists so that a Design Doc has **one predictable location**
instead of being invented next to whichever file its author happened to be
editing.

**A Design Doc is not authority.** It is unranked. Where a Design Doc
disagrees with any ranked document — a PRD, an ADR, the Bounded Context Map,
the Module Dependency Matrix — **the ranked document wins and the Design Doc
is the defect.** This mirrors the framing `ADR-0131` applied to Technical
Specifications, which are *"governed but UNRANKED"* and *"lose any
disagreement with a ranked document by default."*

---

## 2. Structure

Organised by **bounded context / module**, so a reader who knows which part
of the product they are working on knows where to look.

```
docs/35-design/
├── README.md            ← this file
├── membership/          BC-02 Membership
├── student-management/  BC-01 Enrollment
├── attendance/          BC-03 Attendance
├── seat-management/     BC-04 Seating
├── fees-finance/        BC-05 Fee, and revenue/finance concerns
└── shared/              genuinely cross-cutting designs only
```

The subdirectories were created **empty by design**, and this README creates
no Design Doc: whether a feature needs one is a **feature-specific and
governance-specific judgement**, not something a directory layout decides.

New contexts get a new subdirectory when a Design Doc for them is actually
written — not pre-emptively.

### 2.2 ⭐ Register — which contexts have a Design Doc, and why the rest do not

⚠️ **The paragraph above said *"No Design Doc has been written for any
module"*. That was correct when written and is now false for `membership/`;
it is corrected here rather than deleted.**

One Design Doc exists. The **discriminator is measured, not editorial**: a
Design Doc can only be written where a frozen PRD actually fixes surface
requirements, because inventing them is the untraceable design claim
[`../design/PRD_DESIGN_TRACEABILITY.md`](../design/PRD_DESIGN_TRACEABILITY.md)
§3 rejects.

| Context | Design Doc | Frozen PRD's UI/UX section | Disposition |
|---|---|---|---|
| `membership/` | ⭐ [`DD-0001`](membership/DD-0001-membership-management-surface-design.md) **v0.2** | ⭐ **`PRD-005` §20 — 13 `MUST`/`MUST NOT` surface rows** | **WRITTEN** — full handoff depth; ⭐ Figma-ready with 2 labelled substitutions (§19.1) |
| `student-management/` | — | **0** | ⛔ Not written — no surface requirements to design from |
| `attendance/` | — | **0** (0 occurrences of screen/UI/UX) | ⛔ Not written |
| `seat-management/` | — | **0** — 8 UI occurrences, ⛔ **every one a prohibition** | ⛔ Not written |
| `fees-finance/` | — | 1 — `PRD-008` §42.7, ⛔ an express statement of **absence** | ⛔ Not written |
| `shared/` | — | n/a | ⛔ Empty — see §2.1 |

⭐ **Their absence is NOT a defect**, on this README §5.1's own rule that a
missing Design Doc *"is not a precondition of implementation"* and must not
be treated as a blocker. A Design Doc becomes writable for those contexts
when their PRD gains surface requirements — or when a named product office
supplies them.

### 2.1 When `shared/` is correct, and when it is not

`shared/` is for a design that genuinely spans contexts and cannot be
attributed to one owner — a cross-cutting concern, a convention applied
everywhere, a pattern several modules follow.

⛔ **`shared/` is not an "unsure" bucket.** A design that affects two contexts
usually still *belongs* to one of them. Filing it in `shared/` makes it
nobody's, and an unowned design document is one nobody maintains. If you
cannot name the owning context, that is a signal to resolve the ownership
question first — not to file the ambiguity.

---

## 3. Naming

```
DD-NNNN-short-kebab-title.md
```

* `DD-` is the Design Doc prefix. Measured **free** at the time of writing:
  **0** occurrences of `DD-NNNN` repository-wide.
* `NNNN` is a stable, zero-padded, repository-wide sequential number. It is
  **never reused and never reassigned**, for the same reason `IMPL-*` numbers
  are not: cross-references in commits, reviews and test names outlive the
  document.
* The number is global, not per-directory, so moving a Design Doc between
  subdirectories does not renumber it.

Example: `docs/35-design/membership/DD-0001-renewal-term-calculation.md`

⚠️ `DD-*` is **distinct from `DDR-*`**. A **Design Decision Record**
(`DDR-*`) is a single durable design *choice*, registered under
[`../design/design-decisions/README.md`](../design/design-decisions/README.md).
A Design Doc is the broader *design of a feature* and may cite several DDRs.
Do not use one prefix for the other.

---

## 4. Status

Every Design Doc carries a `Status` field in its header table, using the
vocabulary already established by
[`../design/DESIGN_GOVERNANCE.md`](../design/DESIGN_GOVERNANCE.md) §2 rather
than a second competing set:

| Status | Meaning |
|---|---|
| `PROPOSED` | Written, awaiting approval. The default for a new Design Doc |
| `APPROVED` | Accepted by the applicable authority |
| `SUPERSEDED` | Replaced by a later Design Doc, which it must name |
| `TO BE DECIDED` | Blocked on a decision by a named authority |
| `CONFLICT` | Sources disagree. Preserve both facts and escalate; **do not edit the source** |

A Design Doc that is implemented does **not** become "done" and get deleted.
It is a record of why the code looks the way it does, and it stays readable.

---

## 5. Relationship to PRD / ADR / TS / IMPL

Each of these answers a different question, and none substitutes for another.

| Document | Answers | Rank | Location |
|---|---|---|---|
| **PRD** (`PRD-nnn`) | *What* the product must do, and why | Ranked (3 for module PRDs) | `docs/30-product/` |
| **ADR** (`ADR-nnnn`) | A binding decision on boundaries, ranks, edges, precedence | Ranked (2) | `docs/00-governance/adr/` |
| **TS** (`TS-*`) | The technical contract — API, schema, interface shape | **Unranked** (`ADR-0131`) | `docs/50-technical/` |
| **Design Doc** (`DD-*`) | *How* a feature will be built; options and trade-offs | **Unranked** | **`docs/35-design/`** |
| **IMPL task** (`IMPL-nnn`) | The unit of work, and the test that proves it | Unranked backlog | `docs/40-implementation/` |

### 5.1 What a Design Doc must not do

⛔ **It cannot change a requirement.** A requirement that cannot be
implemented as written is a **specification defect** — raise an amendment
(`PRD_LIFECYCLE.md` Stage 8), never silently reinterpret it in a Design Doc.

⛔ **It cannot substitute for an ADR.** A boundary, rank, edge or ownership
change is the **Architecture Owner's** to accept
(`PRD_OWNERSHIP_MODEL.md` §2.2). Recording such a change in a Design Doc does
not authorise it, and a Design Doc that reads like an ADR is an ADR that
skipped its gate.

⛔ **It cannot confer freeze, approval or baseline status.** Those are
conferred, not claimed.

⛔ **It is not a precondition of implementation.** No governance rule requires
a Design Doc before code. Stage 6A already establishes the precedent that an
inserted document stage is *"OPTIONAL and NON-BLOCKING"* and that its absence
is *"NOT a defect, NOT a blocker and NOT a regression"* (`ADR-0131` §4.3).
The same applies here. Do not treat a missing Design Doc as a blocker, and do
not write one to manufacture the appearance of progress.

---

## 6. Relationship to `docs/design/`

Both directories exist, deliberately, and they hold different things.

| | `docs/design/` | `docs/35-design/` |
|---|---|---|
| **Holds** | Design *foundation* — the design system, visual language, UX and screen architecture, accessibility, design governance, ownership, QA, DDR register | Per-feature **Design Docs** |
| **Scope** | Product-wide and durable | One feature, one context |
| **Organised by** | Concern | Bounded context |

**`docs/design/` was deliberately left where it is.** Its 16 foundation
documents cross-link each other as **relative siblings**
(`](DESIGN_SYSTEM.md)`, `](design-decisions/README.md)`), so distributing
them across per-context subdirectories would break every one of those links
while gaining nothing: they are not per-context documents, and there is no
context to file them under. They were also measured to have **0 inbound
references** from anywhere outside their own directory, so no reader is
currently routed through a path this change could have invalidated either
way.

Moving them was considered and **rejected**: the instruction to move existing
Design Docs applies *"ONLY if doing so does not violate existing
governance/reference rules"*, and breaking sixteen documents' internal
navigation to satisfy a directory shape is a worse outcome than two
well-labelled directories.

If the design foundation should later be consolidated here, that is a
deliberate migration with link rewriting — not a side effect of creating this
space.
