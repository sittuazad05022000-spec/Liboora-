# IMPLEMENTATION TASK REFERENCE — `PRD-021C` C0–C8

**Derived document.** ⛔ No authority. Authority:
[`../IMPLEMENTATION/PRD-021C_IMPLEMENTATION_TASKS.md`](../IMPLEMENTATION/PRD-021C_IMPLEMENTATION_TASKS.md) ·
[`../PRD/`](../PRD/) (**FROZEN**) · **`Accepted`** ADRs in [`../ADR/`](../ADR/).

---

## 1. ⚠ Read this first — this document references, it does not re-invent

The **44** implementation tasks already exist, in full, at
[`../IMPLEMENTATION/PRD-021C_IMPLEMENTATION_TASKS.md`](../IMPLEMENTATION/PRD-021C_IMPLEMENTATION_TASKS.md).
That file is the authority. This document is a **navigational reference** to it.

⛔ **No task is restated in full here, no task is redefined, and ⛔ no new `IMPL-*`
identifier is created by this package.**

⭐ And the header of the authoritative file records the state plainly:

> **Code written** | ⛔ **NONE. 0 lines**

---

## 2. The 44 tasks — `IMPL-1750` … `IMPL-1793`

Reproduced from the authoritative task groups table (**L79**–**L89**):

| Group | Part | Subject | Tasks | Range | Tier |
|---|---|---|---|---|---|
| **G1** | C1 | Marketplace foundation — tenancy-scoped public read surface | 6 | `IMPL-1750`…`1755` | **V1** |
| **G2** | C2 | Library search & local discovery | 6 | `IMPL-1756`…`1761` | **V1** |
| **G3** | C3 | Library public profile | 7 | `IMPL-1762`…`1768` | **V1** |
| **G4** | C4 | Seat availability presentation & booking initiation | 6 | `IMPL-1769`…`1774` | **V1** |
| **G5** | C5 | Ratings & reviews — **absence discipline** | 4 | `IMPL-1775`…`1778` | ⛔ **V2 feature; V1 absence tests** |
| **G6** | C6 | Discovery presentation & ordering | 5 | `IMPL-1779`…`1783` | **V1** |
| **G7** | C7 | Trust & safety integration | 5 | `IMPL-1784`…`1788` | **V1** |
| **G8** | C8 | Technical & production architecture | 5 | `IMPL-1789`…`1793` | **V1** |
| | | **Total** | **44** | `IMPL-1750`…`1793` | |

✅ **Independently re-measured while writing this document:** exactly **44**
distinct identifiers fall in `IMPL-1750`…`IMPL-1793`.

### 2.1 ⚠⚠ The counting trap — a naive census returns the wrong number

A plain `grep -oE 'IMPL-[0-9]{4}' | sort -u` over the task file returns **51**,
not 44. **51 is wrong.** Seven of those identifiers are **citations, not
allocations**:

| Out-of-range identifier | What it actually is |
|---|---|
| `IMPL-1600`, `IMPL-1689` | `PRD-021B`'s **allocated** range — cited for frontier arithmetic |
| `IMPL-1690` | ⭐ *The first number of `PRD-021B`'s declared reserve* — cited, **not used** |
| `IMPL-1794` | ⭐ The **first number of `PRD-021C`'s own reserve** — declared, ⛔ **not allocated** |
| `IMPL-1700`, `IMPL-1800`, `IMPL-1801` | Cited in the discussion of the **measurably stale** allocation table (`S6-F-2`) |

⛔ **Do not conclude from a raw grep that 51 tasks exist.** The authoritative
total is **44**, and the file states the range explicitly.

### 2.2 ⛔ The growth reserve is NOT allocated

From the task file header (**L9**):

> | **Growth reserve** | **`IMPL-1794`…`1849`** — declared reserve, ⛔ **NOT
> allocated and NOT used** |

⛔ **`IMPL-1794` … `IMPL-1849` must not be consumed.** They are reserved so that
`PRD-021C` can grow contiguously. Taking one is not a small liberty — it
forecloses the reserve that the allocation rules exist to protect.

⭐ Note that `PRD-021C` inherited this discipline from its predecessor:
`PRD-021B` allocated `IMPL-1600`…`1689` and reserved `1690`…`1749`, and
`PRD-021C` **cleared the whole reserve** before starting at `1750` rather than
squeezing into it (**L63**–**L69**).

---

## 3. The three shaping rules

The task file records the rules that produced this allocation. They matter to an
implementer because they explain why there are 44 tasks and not 258.

### 3.1 The range was **measured**, not read

The standing finding **`S6-F-2`** records that the repository's allocation table
is **measurably stale** — it showed `IMPL-227`+ as *"Unallocated"* while far
higher ranges were in use (**L21**).

⭐ **So the range was determined by measuring actual usage across the repository,
not by trusting the index.** If you need the next free number for some *other*
PRD, measure — do not read the table.

### 3.2 Smallest compatible scope — **258 obligations → 44 tasks**

The parts carry **258** normative requirements. They produced **44** tasks. That
is a deliberate compression: a task is sized to the smallest coherent unit of
work that satisfies a group of related obligations, ⛔ not one task per
requirement.

⛔ **Do not expand a task into sub-tasks with new `IMPL-*` numbers.** Break work
down inside your own tracker if you must, but the `IMPL-*` register is fixed.

### 3.3 ⭐⭐ No task creates product

This is the rule that most constrains what the tasks are *for*. Every task
composes, presents, tests or verifies. ⛔ **No task authorises inventing a
capability, a metric, an event, an edge, a schema or a ranking.**

⭐ **G5 is the clearest illustration:** four tasks for a part that specifies **no
capability at all**, and their content is **absence tests**. A task group can
exist to guarantee that something is *not* built. See
[`TESTING_REQUIREMENTS.md`](./TESTING_REQUIREMENTS.md) §3.

---

## 4. Task structure — the nine fields, and the two that matter most

Every task carries **all nine** required fields. The task file singles out two
(**L96**–**L98**):

> ⭐ Every task carries all nine required fields. **Trace** cites requirements and
> acceptance criteria that exist at Stage 5; **Boundary** states what the task may
> **not** touch, because **on a marketplace that composes five foreign contexts the
> boundary is the load-bearing field**.

| Field | Why it matters to you |
|---|---|
| **Trace** | The requirements and ACs the task discharges. ⭐ Every cited identifier **exists at Stage 5** — no forward references to unwritten requirements |
| **Boundary** | ⭐⭐ What the task **may not touch**. On a composition over five foreign contexts, this is the field that prevents the task from silently acquiring ownership |

⭐⭐ **Read the Boundary field before the Description.** The single most common way
to break this architecture is to implement a task correctly *and* incidentally
take ownership of something belonging to `BC-04`, `BC-13`, `BC-23`, `BC-26` or
`BC-29`. The Boundary field is there precisely because that failure is available
on every task.

### 4.1 The worked example the file itself gives

`IMPL-1750` — *Tenancy-scoped public read projection* (**L103**–**L105**):

| Field | Value |
|---|---|
| **Trace** | `LMP-FR-001`, `LMP-FR-002`, `LMP-FR-003` · AC `LMP-AC-001`, `LMP-AC-012` |

⭐ Note the shape: **three requirements and two acceptance criteria** discharged by
**one** task. That ratio is what §3.2's compression looks like in practice.

---

## 5. What the tasks are and are not permitted to do

| ✅ A task may | ⛔ A task may not |
|---|---|
| Compose reads over existing contexts | Store business state (`LMT-XC-001`) |
| Present data an owner supplies | Compute a metric (`LMT-XC-018`) |
| Consume one of the **four** existing events | Create an event or an edge (`LMT-XC-008`, `LMT-XC-009`) |
| Reference media by `FileRef` | Hold bytes or a storage path (`LMT-FR-005`) |
| Enter a safety report | Decide a safety outcome (C7) |
| Present seat availability | Perform a booking write — `BC-04` owns it (C4 **L17**–**L21**) |
| Apply C2's declared ordering + C6's tie-break | Define a ranking (`LSD-XC-002`) |
| Assert an absence (G5) | Create the deferred capability |
| Read `ProfileViews` as certified | Render `UniqueViewers` in any form (`ADR-0097`) |

For the reasoning behind each prohibition, see
[`ARCHITECTURE_AND_BOUNDARIES.md`](./ARCHITECTURE_AND_BOUNDARIES.md).

---

## 6. ⛔⛔ Allocation of these tasks does NOT authorise implementation

**This is the most important statement in this document.**

Stage 6 **allocated** the tasks. Stage 7 **froze** the PRD. ⛔ **Stage 8 —
implementation — has NOT been entered, and no task here has been started.**

| State | Value |
|---|---|
| Tasks allocated | **44** (`IMPL-1750`…`IMPL-1793`) |
| Tasks implemented | **0** |
| Lines of application code written | ⛔ **0** |
| Lines of test code written | ⛔ **0** |
| Stage 8 entered | ⛔ **NO** |

⭐ A task list is a **plan of record**, not a work order. The existence of
`IMPL-1750` means the work has been *specified and scoped*; it does not mean it
has been approved to start, and nothing in this package starts it.

---

## 7. ⚠ One task is blocked by an unwritten ADR

**`IMPL-1424`** — inherited from `PRD-020` — is **blocked** by **`TSF-GAP-009`**,
the `BC-13` → `BC-19` referral transport question. The ADR that would resolve it
is ⚠ **REQUIRED and NOT WRITTEN**.

**Owner:** Architecture Owner, with the `BC-19` owner.

⛔ Do not unblock it by choosing a transport. C8 **§13** records the posture
explicitly — it declines *"to resolve an Architecture Owner question by
drafting."*

⚠ Note this is a `PRD-020` task, not one of the 44 — it is recorded here because
it bears on C7's integration and appears in the inherited blocker set.

---

## 8. Self-check before touching the task register

1. **Am I creating a new `IMPL-*` number?** ⛔ Stop. **0** new tasks.
2. **Am I using a number in `1794`…`1849`?** ⛔ That is the **unallocated reserve**.
3. **Did I get my task count from a raw grep?** ⚠ Then it is probably **51**. The
   answer is **44**.
4. **Did I read the task's Boundary field?** If not, read it before the
   description.
5. **Does my implementation take ownership of anything in the Boundary field?**
   ⛔ Stop.
6. **Am I treating a G5 task as "build ratings later"?** ⛔ It is an **absence
   test** now.
7. **Am I about to start Stage 8?** ⛔ It has not been entered.
8. **Am I editing `PRD-021C_IMPLEMENTATION_TASKS.md`?** ⛔ Out of scope for this
   package.

---

## 9. Open items in this area

| Item | Status | Owner |
|---|---|---|
| `IMPL-1794`…`IMPL-1849` growth reserve | ⛔ **Declared, NOT allocated, NOT used** | — |
| `IMPL-1424` blocked by `TSF-GAP-009`; ADR **required, not written** | **OPEN, INHERITED from `PRD-020`** | Architecture Owner with `BC-19` owner |
| `S6-F-2` — the repository allocation table is **measurably stale** | ⚠ **Standing finding, disclosed** | Recorded at Stage 6 |
| `GAP-BCMAP-BC26-EDGES` — `BC-26` inbound edge; ADR **required, not written** | **OPEN, INHERITED** | Architecture Owner |
| Stage 8 entry | ⛔ **NOT PERFORMED** | Per `PRD_LIFECYCLE.md` |

⛔ **Stage 8 implementation has NOT been performed.** **0** of the **44** tasks
have been started. **0** lines of application code exist for `PRD-021C`.
