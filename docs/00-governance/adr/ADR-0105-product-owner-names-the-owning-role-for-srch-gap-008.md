# ADR-0105 — The **Product Owner names the owning role** for `SRCH-GAP-008`: **Architecture Owner with the Security reviewer role**

| Field | Value |
|---|---|
| **Status** | **Accepted** — 2026-09-05 |
| **Date** | 2026-09-05 |
| **Deciders** | ⭐⭐ **The Product Owner**, by **direct, explicit, first-person act** quoted verbatim at §2. Naming the owning role of a gap is a **scope/ownership determination**, which `PRD_OWNERSHIP_MODEL.md` **§2.2** assigns to the Product Owner. ⛔ **`ADR-0033` §7.1 — not a standing licence.** ⛔ **No personal name is recorded** (§7 rule 4) |
| **Supersedes** | — |
| **Amends** | `ADR-INDEX.md` (register row + count cell) only. ⛔ **No PRD, no frozen document, no Rank 1–3 artefact is modified.** ⛔⛔ **`PRD-015_SEARCH_INDEXING.md` is NOT edited** — it is hash-locked; see §5 |
| **Amended by** | — |
| **Baseline** | ⛔ **No baseline re-issue by this ADR.** `BASELINE-2026-09-03-A` stands — no Rank 1–3 document changes version here |
| **Closes** | ⭐ **`PRD-015` Stage-7 entry condition 10** (*"Open gaps each have a named owner"*) — the register moves from **8 / 9** to **9 / 9** |
| **Does NOT close** | ⛔⛔ **`SRCH-GAP-008` ITSELF.** Naming an owner is **not** deciding the question — the gap stays **OPEN**. ⛔ **`XPC-OD-010`** stays OPEN. ⛔ **`SRE-GAP-001`** · ⛔ **`SRCH-S7-01`** · ⛔ **`SRCH-GAP-003`** as a substantive question · ⛔ Stage-7 **condition 11**, which needs a different office. ⛔⛔ **Stage 7 is NOT conferred by this ADR** |
| **Related** | `PRD-015_SEARCH_INDEXING.md` **L770**, **L986** · `PRD-021C_C0_CROSS_PART_ARCHITECTURE_AND_OPEN_DECISIONS_v0.1.md` **L428** · `PRD-021C_C0_C8_STAGE3_ARCHITECTURE_ALIGNMENT.md` **L270** · `ADR-0098` **§6 L218** (the `XPC-OD-005` vacant-owner precedent) · `DOCUMENTATION_BASELINE.md` **§6 L356** · `PRD_OWNERSHIP_MODEL.md` **§2.2**, **§7 rule 4** · `PRD-006_STAGE7_FREEZE_READINESS.md` **§3 row 6** (the condition's origin) |

---

## 1. Context — the exact gate that was blocked, and why the obvious fix was the wrong one

`PRD-015` Stage-7 entry condition **10** reads, verbatim and inherited from
`PRD-006_STAGE7_FREEZE_READINESS.md` **§3 row 6**:

> **"Open gaps each have a *named owner*"**

⭐⭐⭐ **The condition tests OWNERSHIP, not SCOPE.** This distinction is the whole substance of this
ADR, and it was established by measurement rather than preference:

| Instrument | Measured |
|---|---|
| `PRD-015_SEARCH_INDEXING.md` **L770** | *"⛔ **No owner exists** — `XPC-OD-010` is OPEN"* · assigned: *"⛔ **No** — recorded, not assigned"* |
| `PRD-015_SEARCH_INDEXING.md` **L986** | Owner: *"⛔ **No owner exists**"* · **Blocks: *"⛔ Nothing in V1"*** |
| `PRD-015_STAGE7_FREEZE_READINESS.md` §3.1 owner table | ⛔ `SRCH-GAP-008` is **absent** — `grep -c` = **0**. Eight of nine gaps appear; it does not |

⚠⚠ **A scope ruling would NOT have closed condition 10.** `SRCH-GAP-008`'s **`Blocks`** cell at
**L986** *already* reads **"Nothing in V1"** — so an out-of-scope declaration would have restated a
fact the hash-locked subject already records, while leaving the **owner** cell still saying
*"No owner exists"*. ⇒ ⭐ **The gate would not have moved.** That route was therefore identified as
insufficient and **not taken**.

### 1.1 ⭐⭐ The decisive precedent — a NAMED role satisfies condition 10 even when the office is VACANT

Three independent instruments establish that condition 10 requires a **named role**, not a **seated
holder**:

| # | Evidence | What it shows |
|---|---|---|
| 1 | `PRD-015_STAGE7_FREEZE_READINESS.md` §3.1 | `SRCH-GAP-001` → owner **"Governance Owner"** ✅ **counted as owned** — ⭐ and that office is **VACANT** (`ADR-0080` **L85**) |
| 2 | `ADR-0098` **§6 L218** | `XPC-OD-005` → *"**Privacy Owner** ⚠ role **VACANT**"* — ⭐ and it was nevertheless **admitted** into `BASELINE-2026-09-03-A` |
| 3 | `DOCUMENTATION_BASELINE.md` **§6 L356** | *"Each has a reason and **a named owner**"* … *"⛔ **cannot be closed by anyone at present because the Privacy Owner is VACANT**"* |

⇒ ⭐⭐⭐ **Vacancy is DISCLOSED, not DISQUALIFYING.** `SRCH-GAP-008` failed condition 10 for one
reason only: it had **no name at all**. This ADR supplies the name and nothing else.

---

## 2. ⭐⭐⭐ The Product Owner act, quoted verbatim — the ONLY authority claimed

> *"I, as Product Owner, name the Architecture Owner with the Security reviewer role as the owner of
> SRCH-GAP-008. It remains OPEN, blocks nothing in V1, and its vacancy is disclosed, not closed."*

⭐ Recorded in the form this repository requires of a conferral — a **first-person operative act** —
on the `ADR-0032` §5.2 / `ADR-0033` §7.2 / `ADR-0036` §8.2 / `PRD_OWNERSHIP_MODEL.md` §12.1 /
`ADR-0102` §2 / `ADR-0103` §2 / `ADR-0104` §2 precedent.

### 2.1 ⛔ Four things this act is NOT, stated so the limits are falsifiable

| Not | Why it matters |
|---|---|
| ⛔ **Not** a decision of the rate-limiting question | The act says *"remains OPEN"*. `SRCH-GAP-008` is **owned and open** |
| ⛔ **Not** an appointment of a holder | *"vacancy is disclosed, not closed"*. §7 rule 4 — no personal name |
| ⛔ **Not** a closure of `XPC-OD-010` | That is a `PRD-021C` register entry with its own owner; untouched |
| ⛔ **Not** authority for the baseline admission | That is a **Governance Owner** act — a *different role* (`ADR-0054` **L148**) |

---

## 3. Why **Architecture Owner + Security reviewer**, and why the pairing is not narrowed

The pairing is **measured, not chosen**. `SRCH-GAP-008`'s own upstream is `XPC-OD-010`, whose
authoritative owner cell reads:

> `PRD-021C_C0_CROSS_PART_ARCHITECTURE_AND_OPEN_DECISIONS_v0.1.md` **L428** —
> **"Architecture Owner** with the **Security** reviewer role"

Corroborated independently at `PRD-021C_C0_C8_STAGE3_ARCHITECTURE_ALIGNMENT.md` **L270**:
*"**Architecture Owner** with **Security** reviewer"*.

### 3.1 ⛔⛔ `ADR-0098` **L222** is NOT used as the assignment — and that refusal is load-bearing

⚠ An earlier pass of this engagement proposed adopting `ADR-0098` **L222** as the ownership route.
**That route was investigated and REFUTED**, and the refutation is preserved rather than buried:

| Line | Text | Routes to `PRD-015`? |
|---|---|---|
| `ADR-0098` **L221** `XPC-OD-009` | *"OPEN — **routed to `PRD-015` when authored**"* | ✅ **YES, expressly** |
| `ADR-0098` **L222** `XPC-OD-010` | *"OPEN — *"NOT resolved by C7"*"* | ⛔ **NO — `grep -c "PRD-015"` = 0** |

⭐⭐ **`ADR-0098`'s author knew how to route an open decision into `PRD-015` and did so one line
above, for a different decision.** The omission at L222 is deliberate. Further, `ADR-0098` **§6** is
a table of items *"admitted OPEN — declared, not hidden"* on the `ADR-0020` §4 rule that a baseline
*"admits a document **as it is**"* ⇒ ⛔ **it assigns a routing target; it does not confer an act.**

⇒ **This ADR's authority is §2's Product Owner act, and the pairing's content comes from
`PRD-021C_C0` L428 — a different and valid instrument.**

### 3.2 ⛔ The pairing is recorded in full, not reduced to "Architecture Owner"

⚠ `ADR-0098` L222's single-cell shorthand reads *"Architecture Owner"* alone. That is the
**narrower** rendering, and adopting it would have quietly dropped the **Security reviewer** limb.
⭐ **The two-role pairing is recorded as measured.** Precedent: `SRCH-GAP-004`, `005`, `006`, `007`
all carry two-role owners in the same register.

---

## 4. ⭐ What condition 10 now measures

| Gap | Owner | Blocks |
|---|---|---|
| `SRCH-GAP-001` | **Governance Owner** *(office VACANT — disclosed)* | ⛔ Nothing in authoring |
| `SRCH-GAP-002` | **Architecture Owner** | ✅ Stage 3 — CLOSED |
| `SRCH-GAP-003` | **Architecture Owner** | ⚠ Stage 3 — `SRCH-S7-01` |
| `SRCH-GAP-004` | **Architecture Owner** + **Product Owner** | ⛔ Nothing in V1 |
| `SRCH-GAP-005` | **Architecture Owner** + **Product Owner** | ⛔ Nothing in V1 |
| `SRCH-GAP-006` | **Product Owner** + **Architecture Owner** | ⛔ Nothing in V1 |
| `SRCH-GAP-007` | **Product Owner** + **Architecture Owner** | ✅ Stage 3 — CLOSED |
| ⭐ **`SRCH-GAP-008`** | ⭐⭐ **Architecture Owner + Security reviewer** *(vacancy disclosed)* | ⛔ **Nothing in V1** (**L986**) |
| `SRCH-GAP-009` | **Product Owner** | ⛔ Not V1-blocking |

⇒ ⭐⭐ **9 / 9 gaps carry a named owner. Condition 10 PASSES.**

---

## 5. ⛔⛔ The subject is NOT edited — the owner name lives here, not there

`PRD-015_SEARCH_INDEXING.md` is **hash-locked** at
`fe3093e60a3fae5516f0f65c9c62ac2bb28bdfa514a5b1870352d9bdbc2c4544` across Stages 3–6, and its
**L770**/**L986** cells still read *"No owner exists."*

⚠ **That is a deliberate, disclosed consequence, not an oversight.** Editing the subject to insert
the owner would:

1. break the hash-lock every Stage 3–6 record depends on, and
2. amount to a **silent rewrite** of a measurement that was **true when written**.

⭐ Precedent: `ADR-0098` **§5.1** left a pre-existing defect *"routed, not repaired as a side
effect"*; the `Q-A6`/`GCP-20` handling did the same. ⇒ ⭐ **The owner is established by this ADR,
which outranks the PRD's own register cell** (Rank 2 over Rank 3, `DOCUMENTATION_BASELINE.md` §4).
The subject's stale cells are **disclosed here** and left for a lawful future version increment.

---

## 6. Consequences

| Consequence | Detail |
|---|---|
| ⭐ Condition 10 | 🚫 BLOCKED → ✅ **PASS**, 9/9 named owners |
| ⛔ `SRCH-GAP-008` | **OPEN**, owned, blocks nothing in V1 |
| ⛔ Condition 11 | **STILL BLOCKED** — needs a Governance Owner, a *different role* |
| ⛔ Stage 7 | **NOT conferred by this ADR** |
| ⚠ Subject cells L770/L986 | **STALE and disclosed** (§5); ⛔ not edited |
| ⚠ Two-role owner, both limbs vacant | **Disclosed** on the `XPC-OD-005` precedent; ⛔ no holder appointed |

---

## 7. Seven refusals

| # | Refused |
|---|---|
| 1 | ⛔ Using `ADR-0098` **L222** as the assignment — measured refuted (§3.1) |
| 2 | ⛔ Narrowing the owner to *"Architecture Owner"* alone (§3.2) |
| 3 | ⛔ Editing the hash-locked subject to insert the owner (§5) |
| 4 | ⛔ Treating the naming as a **decision** of the rate-limiting question (§2.1) |
| 5 | ⛔ Appointing a **holder** for either limb — §7 rule 4 |
| 6 | ⛔ Claiming any effect on condition 11, `SRE-GAP-001`, `SRCH-S7-01` or `SRCH-GAP-003` |
| 7 | ⛔ Conferring Stage 7 |

---

## 8. Changelog

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-05 | ⭐⭐⭐ **Created. The Product Owner NAMES the owning role of `SRCH-GAP-008` — `Architecture Owner` with the `Security` reviewer role — closing `PRD-015` Stage-7 entry condition 10 at 9/9 named owners.** ⭐⭐ **The decisive insight is that condition 10 tests OWNERSHIP, not SCOPE**: `SRCH-GAP-008`'s `Blocks` cell at **L986** *already* reads *"Nothing in V1"*, so an out-of-scope ruling would have restated a hash-locked fact while leaving the owner cell reading *"No owner exists"* — ⛔ **the gate would not have moved**, and that route was refused as insufficient. ⭐⭐ **A named role suffices even when the office is VACANT**, established on three independent instruments: `SRCH-GAP-001` is already counted as owned by the **VACANT** Governance Owner; `ADR-0098` **§6 L218** admitted `XPC-OD-005` owned by the **VACANT** Privacy Owner; and `DOCUMENTATION_BASELINE.md` **§6 L356** requires *"a reason and a named owner"* while expressly recording that the item *"cannot be closed by anyone at present"*. ⇒ **vacancy is disclosed, not disqualifying.** ⭐ **The pairing is MEASURED, not chosen** — `PRD-021C_C0` **L428** and `STAGE3_ARCHITECTURE_ALIGNMENT` **L270** both read *"Architecture Owner with the Security reviewer role"*, and the **Security limb is preserved** rather than narrowed to `ADR-0098` L222's single-cell shorthand. ⛔⛔ **`ADR-0098` L222 is expressly NOT used as the assignment** — the L221/L222 contrast is preserved as evidence: L221 routes `XPC-OD-009` to `PRD-015` *"when authored"* while L222 does not mention `PRD-015` at all (`grep -c` = **0**), and §6 is a register of items *"admitted OPEN"* under `ADR-0020` §4, which assigns a routing target rather than conferring an act. ⛔⛔ **The hash-locked subject is NOT edited**; **L770**/**L986** still read *"No owner exists"* and that staleness is **disclosed** (§5) on the `ADR-0098` §5.1 *"routed, not repaired"* precedent, the owner being established at Rank 2 instead. ⛔ **Closes nothing else:** `SRCH-GAP-008` stays **OPEN**, `XPC-OD-010` stays OPEN, `SRE-GAP-001`, `SRCH-S7-01` and `SRCH-GAP-003` are untouched, **no holder is appointed**, **no personal name is recorded**, and ⛔⛔ **Stage-7 condition 11 remains BLOCKED and Stage 7 is NOT conferred.** **0** identifiers minted · **0** frozen bytes changed · **0** lines of application code |
