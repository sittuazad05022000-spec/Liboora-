# ADR-0022 — Whether `BC-03` Attendance may hold a `FileRef` from `BC-29`, and this ADR does not decide it

| Field | Value |
|---|---|
| **Status** | **Proposed** — not binding. *(`ADR-INDEX.md` status vocabulary: "Under consideration; not binding")* |
| **Date** | 2026-08-04 |
| **Deciders** | **Architecture owner (ARB)** — `PRD-006` §32 names the owner and states *"needs an ADR (BC Map §7)"* |
| **Supersedes** | Nothing |
| **Amends** | **Nothing. The Bounded Context Map is unmodified.** An amendment is what a decision would authorise; none is made here |
| **Related** | `ATT-GAP-010` · `ATT-XC-004` · `ATT-FR-080` · `ADR-0016` (the exact mechanism precedent) · BC Map §7.3 edge `E-22` L331, L292 · `PRD-006` §13B |

> ⚠️ **`Proposed`. This ADR frames a decision it is not authorised to make.**
>
> It exists because two repository rules independently require one *before* anything changes:
>
> * `ADR-INDEX.md` Process step 1 — *"A decision that changes structure, ownership, **a boundary**, or a
>   platform-wide rule requires an ADR **before** implementation."*
> * `DOCUMENTATION_BASELINE.md` §7 step 1 — *"A change to any **Rank 1–5** document requires an ADR **before**
>   the change."* The Bounded Context Map is **Rank 4** (baseline §3 L213) and frozen.
>
> Bounded Context Map **L292** makes the requirement explicit for this class of change:
> *"If an edge is not in this table, it **does not exist** and adding it requires an ADR."*

---

## 1. Context

`PRD-006` §13B specifies a *register-image* workflow: staff photograph a paper attendance register and the image
is processed into attendance records. The workflow needs somewhere for the image bytes to legally live.

The platform's answer for image bytes is `BC-29` File & Media, reached over edge **`E-22`**. BC Map L331 records
that edge:

```
| E-22 | BC-01, BC-10, BC-14 | BC-29 File & Media | CF | Sync port |
  Domain holds a `FileRef`, never bytes or a raw storage path.
  `BC-10` added by ADR-0016 — required by SID-4.35 |
```

**`BC-03` Attendance is not on that list.** Under L292 the `BC-03` → `BC-29` edge therefore *does not exist*.
`PRD-006` records this as exclusion **`ATT-XC-004`** and gap **`ATT-GAP-010`**, and does not resolve it.

The consequence is already written into the specification rather than left implicit. **`ATT-FR-080`**:

> *"Until `ATT-GAP-010` and `ATT-GAP-011` are answered by their named owners, the OCR/Vision workflow **MUST NOT**
> be implemented. §13A individual manual entry is **unaffected** and remains fully specified and buildable."*

---

## 2. Evidence

### 2.1 The mechanism is known and proven; only the decision is missing

`ADR-0016` — *"Edge `E-22` must list `BC-10`, an edge the Student Identity PRD already requires"* — amended this
**same consumer list**, took the BC Map to **v1.5**, and did so on a single finding: a Rank 3 requirement
(`SID-4.35`) depended on an edge §7 said did not exist.

`PRD-006` §32.1 states the comparison and, importantly, states it **against** itself:

> *"**`ADR-0016` is the exact precedent** — it added `BC-10` to this same consumer list… The mechanism to close
> this is therefore *known and proven*; only the decision is missing. **This document does not make it** — and
> unlike `ADR-0016`'s trigger, **no Rank 3 requirement compels `BC-03`'s inclusion, so the case is weaker, not
> stronger.**"*

That asymmetry is the whole difficulty. `ADR-0016` corrected an *omission*: the map contradicted a frozen Rank 3
requirement. Nothing here contradicts anything. `PRD-006` is **unranked and not admitted to any baseline**, so it
cannot compel a Rank 4 amendment the way `SID-4.35` could.

### 2.2 This is not the OCR direction question, and must not be confused with it

`PRD-006` §5.4 records that the first draft asked for a `BC-03` → `BC-27` AI Assistance edge and that BC Map §7.4
rules **`F-1`**/**`F-3`** make such an edge *architecturally backwards*. That finding **narrowed `ATT-GAP-011`**
and refuted a requested edge.

**It does not touch `ATT-GAP-010`.** `PRD-006` says so directly:

> *"`ATT-GAP-010` — where the image bytes may legally live — is **untouched by §7.4**."*

`E-22` is a domain → capability `CF` port of exactly the kind `F-3` contemplates. The direction is not in
question; the **membership of the consumer list** is.

### 2.3 The constraint being tested is a real one, not a formality

`E-22`'s own note fixes what any consumer may hold: *"Domain holds a `FileRef`, **never bytes or a raw storage
path**."* Whatever is decided, `BC-03` would hold a reference, not an image. The decision is about **whether
Attendance is a legitimate holder of student-bearing imagery at all** — a register photograph contains many
students' handwriting, which is why `PRD-006` separately raises **`ATT-GAP-016`** on its retention rule, owner
*Legal counsel + architecture owner*.

**`ATT-GAP-016` is not decided here either, and a decision on this ADR would not decide it.**

---

## 3. What this ADR does not decide

| Not decided | Why |
|---|---|
| Whether `BC-03` joins `E-22`'s consumer list | It is the question. The owner is the architecture owner (ARB) |
| Whether the Bounded Context Map is amended | A Rank 4 frozen document. §7 step 1 requires an accepted ADR first; this one is `Proposed` |
| `ATT-GAP-011` — who owns OCR/Vision | A distinct question with its own draft. Both must be answered before `ATT-FR-080` lifts |
| `ATT-GAP-016` — retention of register imagery | Legal counsel + architecture owner. Reachable only if this is decided affirmatively |
| Whether §13B stays in V1 | A product-scope decision, not an architecture one |
| Whether `PRD-006` is frozen | Stage 7's gate is a baseline row. No baseline row is created here |

---

## 4. Options, costed. None is recommended

### Option A — Add `BC-03` to `E-22`'s consumer list

Follows `ADR-0016` exactly. Requires: this ADR accepted first (§7 step 1) → BC Map consumer cell amended and
version incremented (§7 step 2) → `DOCUMENTATION_BASELINE.md` updated in the same commit (§7 step 3).
**No new baseline identifier** — §7 step 4 issues one only when a **Rank 1–3** document changes version, and the
BC Map is Rank 4; `ADR-0016` set that precedent.

Unblocks half of `ATT-FR-080`. Opens `ATT-GAP-016` as a live obligation. Weaker justification than `ADR-0016`
had, per §2.1.

### Option B — Refuse; `BC-03` never holds imagery

`ATT-XC-004` stands permanently, `ATT-FR-080` never lifts for this half, and §13B is unbuildable for as long as
the exclusion holds. Costs nothing in Rank 1–5 changes. Makes the register-image workflow a specified capability
that is deliberately never built — which the product owner, not the ARB, would have to accept.

### Option C — Route the image through an existing `E-22` consumer

`BC-01`, `BC-10` and `BC-14` already hold `FileRef`s. Placing a register photograph with one of them avoids a BC
Map change but assigns attendance-originated imagery to a context that does not own attendance — the ownership
error `ADR-0013` exists to prevent. **Requires examination before it is treated as cheap.**

### Option D — Defer

`ATT-GAP-010` stays 🔴 OPEN with a recorded reason and review date. Open gaps do not bar freeze — `ADR-0020`
admitted `PRD-007` with fourteen — so this is a legitimate outcome, not an evasion.

---

## 5. Consequences while `Proposed`

| Consequence | State |
|---|---|
| Bounded Context Map | **Unmodified.** Byte-identical |
| `ATT-GAP-010` | 🔴 **OPEN** — a draft ADR is not an answer |
| `ATT-FR-080` | **Stands.** The OCR/Vision workflow remains build-blocked |
| `ATT-XC-004` | **Stands.** `BC-03` MUST NOT consume `BC-29` |
| `PRD-006` | Unmodified, unranked, DRAFT |
| `ADR-INDEX.md` | **Not updated.** Its *Count* field is therefore stale; see §6 |

---

## 6. Disclosed: `ADR-INDEX.md` is not updated

`ADR-INDEX.md` reads *"**20 accepted** · **0 proposed**"*. With `ADR-0021` and this draft it is stale by **two**
in the proposed count. It is left stale deliberately: the index is the *register of record*, and registering a
draft that its decider has not seen would overstate the draft's standing. The correction belongs in the commit
that accepts or withdraws these ADRs, per Process step 4.

---

## 7. Compliance

| Rule | Compliance |
|---|---|
| `ADR-INDEX.md` step 1 — ADR before implementation | ✅ Written while the BC Map stands untouched |
| `ADR-INDEX.md` step 2 — number sequentially, never reuse | ✅ `ADR-0022`; highest existing was `ADR-0021` |
| Baseline §7 step 1 — ADR before a Rank 1–5 change | ✅ No Rank 1–5 document is changed |
| BC Map L292 — adding an edge requires an ADR | ✅ **No edge added.** §4 declines to add one |
| `PRD-006` §0.4 — a gap resolved by implementation choice is not resolved | ✅ No choice made |
| `PRD_OWNERSHIP_MODEL.md` §2.2 — architecture owner decides Rank 1–5 changes | ✅ The decision is left to that role |

---

## 8. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-04 | Created **`Proposed`** during a Phase 4 governance/ADR determination, because `PRD-006` §32 records `ATT-GAP-010`'s owner as *"Architecture owner — **needs an ADR** (BC Map §7)"* and both repository triggers fire: adding a consumer to `E-22` is a boundary change (`ADR-INDEX.md` step 1) to a **Rank 4 frozen** document (Baseline §7 step 1), and BC Map L292 requires an ADR by name. Frames four options and **chooses none**. Records that `ADR-0016` supplies the exact mechanism but that the justification here is **weaker**, since no Rank 3 requirement compels `BC-03`'s inclusion and `PRD-006` is unranked. Records that BC Map §7.4's `F-1`/`F-3` direction finding narrowed `ATT-GAP-011` but leaves `ATT-GAP-010` **untouched**, so the two must not be conflated. **The Bounded Context Map is unmodified, no edge is added, `ATT-GAP-010` remains OPEN, `ATT-FR-080` stands, and this ADR is not Accepted.** |
