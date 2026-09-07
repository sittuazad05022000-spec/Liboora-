# ADR-0081 — Every residual `PRD-021A` gap and decision requirement is dispositioned by authority; `LCR-DEC-009` is REFUSED as undecidable, and `LCF-GAP-005` closes on measurement

| Field | Value |
|---|---|
| **Status** | **Accepted** — 2026-08-25 |
| **Date** | 2026-08-25 |
| **Deciders** | **Architecture Owner** for §3 (`LCF-GAP-005` closure on measurement; `LCF-GAP-009`/`LCR-GAP-008`/`LCR-GAP-004` routing) · **Governance Owner** — the role constituted by `ADR-0080` — for §4 (register disposition and the refusal to close on absent authority). ⛔ **No Product Owner, Privacy Owner, Engineering Owner or Auth Owner decision is taken or simulated in this ADR**, and every item requiring one is recorded as **OPEN with its owner named** |
| **Supersedes** | — |
| **Amends** | ⛔ **No document.** This ADR **dispositions**; it does not amend. The consequential edits to `PRD-021A` A2 (→ v0.7) and A3 (→ v0.5) execute the two closures this ADR authorises and are recorded in §6 |
| **Amended by** | — |
| **Baseline** | **No baseline re-issue.** No Rank 1–3 document changes version; `DOCUMENTATION_BASELINE.md` §7 rule 4 |
| **Closes** | ⭐ **`LCF-GAP-005`** — closed **on measurement**, not on decision: its text is *"A3 does not exist on disk"*, and A3 **now exists** (v0.4, 1,175 lines, committed `8a02d52`) · **`LCR-FND-013`** and the **`LCF-GAP-013` enumeration half** — closed **by `ADR-0079`**, recorded here for register consistency |
| **Does NOT close** | ⭐ **`LCR-DEC-009`** — **REFUSED as undecidable on present authority**, §2 · `LCF-GAP-004`, `006`, `007`, `008`, `009`, `010`, `011` · `LCR-GAP-002`, `004`, `006`, `007`, `008`, `010` · `LCR-DEC-001`, `003`, `004`, `006`, `007` · `ADR-0075` §8.5 **Option B** · `PGA-08` · `Q-A6` · `SECP-DEP-007`'s ownership-model half · **and it does NOT make `PRD-021A` READY or FROZEN** — see §5 |
| **Related** | `ADR-0079` (the EA append) · `ADR-0080` (constituted the Governance Owner; closed `LCF-GAP-001`/`LCR-GAP-001`) · `ADR-0077` (Privacy Owner) · `ADR-0075` §8.5 · `PRD-021A_OWNER_DECISION_REQUEST.md` **L365** (records that **no** value was proposed) · `PRD-021A_LCF-GAP-012_DECISION_RECORD.md` §§7.2–7.4, **L303–304** · A3 `LCR-FR-028a`, `LCR-FR-034`, `LCR-FR-035`, `LCR-RS-003` **L413** · `PRODUCT_IMPLEMENTATION_ROADMAP.md` **L161–164** · `PRD_LIFECYCLE.md` **L177**, §5, §6 **L282**, §7 |

> ✅ **ACCEPTED 2026-08-25.**
>
> This ADR exists to answer a question completely: *"resolve the remaining gaps **according to authority — no
> guessing, no invention**."* Applied honestly, that instruction closes **three** items and **refuses** one, and
> the refusal is the most important entry in the document. **A gap closed without authority is not progress;
> it is an invented requirement wearing a closure marker.**

---

## 1. Context

`PRD-021A` A2 v0.6 and A3 v0.4 carry, between them, **9** open `LCF-GAP-*`, **7** open `LCR-GAP-*` and **6**
open `LCR-DEC-*`. Two prior ADRs in this pass changed the position:

- **`ADR-0079`** executed the EA enumeration by append, closing `LCR-FND-013` and the `LCF-GAP-013`
  enumeration half.
- **`ADR-0080`** constituted the **Governance Owner**, closing `LCF-GAP-001` and `LCR-GAP-001`.

This ADR examines **every remaining item** and assigns exactly one of three dispositions: **CLOSED** (an
authority exists and has been applied), **REFUSED** (the item is not decidable on present authority, and
inventing a value is prohibited), or **OPEN — routed** (a named owner other than the deciders of this ADR must
act). ⛔ **No fourth disposition exists**, and in particular there is no "closed pending" or "closed in
principle".

---

## 2. ⭐ `LCR-DEC-009` — REFUSED, because no authority assigns the value

### 2.1 What it asks

A3 v0.4 **L1012** records it verbatim:

> `LCR-DEC-009` | ⭐ **New at v0.4 — recorded, not decided.** Assign a weight for `LCR-RS-003` Helpfulness and
> renormalise the active set to exactly `100` under `LCR-FR-035`. … A3 SHALL NOT carve this weight out of the
> ruled `70`/`30` split | **Product Owner**

### 2.2 The determinability probe, and its result

| Probe | Result |
|---|---|
| Does any Accepted ADR assign a helpfulness weight? | ⛔ **No** |
| Does the Decision Record assign one? | ⛔ **No.** §7.4 rules **only** Recency `70` and Legitimate engagement `30`. **L303–304** states expressly: *"§7.3 resolves **which kind** means helpful; it does **not** assign a weight"* |
| Does the Owner Decision Request propose one? | ⛔ **No.** **L365**: *"**Proposes no reaction kind, no weight, no citation target, no EA node and no value of any kind**"* |
| Does any Rank 1–5 document assign one? | ⛔ **No** — searched repository-wide |
| Does A3 permit inferring one? | ⛔ **No.** `LCR-FR-028a`: *"no implementation SHALL infer a default weight"*; `LCR-FR-034` reserves the weight to the activation owner |
| Whose decision is it? | **Product Owner** — recorded in the register and in the Decision Request |

### 2.3 Determination

⛔ **`LCR-DEC-009` is REFUSED as undecidable on present authority, and remains OPEN, owned by the Product
Owner.**

⭐ **Why refusal is the correct act and not a failure to complete the task.** There are only three ways to
"resolve" this item, and two are prohibited:

| Candidate resolution | Verdict |
|---|---|
| Assign a weight (any value) | ⛔ **Prohibited — this is invention.** The user's instruction is *"no guessing/invention"*, `LCR-FR-028a` forbids inferred weights, and the value is a **Product Owner** judgement about product behaviour |
| Carve the weight out of the ruled `70`/`30` | ⛔ **Prohibited twice over.** `LCR-DEC-009`'s own text says *"A3 SHALL NOT carve this weight out of the ruled `70`/`30` split"*, and doing so would silently overwrite a **decision the Product Owner did make** |
| Record it as REFUSED, owned, with the substrate confirmed ready | ✅ **Correct.** The item is fully analysed, its blocker is named as a *value* and not a *dependency*, and the decision sits with the one role competent to take it |

⭐ **What this ADR *does* settle about it.** The distinction that matters for A3's arithmetic is confirmed:
`LCR-RS-003` is **ELIGIBLE**, not deferred — its **substrate** barrier is genuinely gone (`HELPFUL` is
designated, `LCF-GAP-014` resolved), and only the **weight** is missing. It therefore contributes exactly
**0**, and the active set remains **`LCR-RS-001` 70 + `LCR-RS-004` 30 = exactly 100**. ⛔ **A3 v0.5 SHALL NOT
change any weight.**

---

## 3. ⭐ `LCF-GAP-005` — CLOSED on measurement

Its text is a **statement of fact about the filesystem**, not a decision request: *"A3 does not exist on disk,
so the ranking seam is specified but unexercised."*

| Check | Result |
|---|---|
| Does A3 exist on disk? | ✅ **Yes** — `PRD-021A_A3_COMMUNITY_FEED_RANKING_DRAFT_v0.4.md`, **1,175** lines, committed in `8a02d52` |
| Does it exercise the ranking seam? | ✅ Yes — §12.1 carries the weight table, and `LCR-RS-001`…`008` are specified |
| Does closing it require anyone's decision? | ⛔ **No.** The predicate is false; nothing is chosen |

✅ **CLOSED.** ⭐ **This is the only item in the entire residual set closable without an owner's decision**, and
it is closed for that precise reason.

⚠ **Its sibling was tested identically and is NOT closed.** `LCF-GAP-011` says `integration_test/` does not
exist. Verified this pass: **it still does not exist.** The predicate is **true**, so the gap stays **OPEN**.
The two gaps have the same shape and opposite outcomes, which is why each was measured rather than assumed.

---

## 4. Disposition of every remaining item

### 4.1 A2 — `LCF-GAP-*`

| ID | Subject | Owner | Disposition |
|---|---|---|---|
| `001` | `LCF-` prefix not registered | Governance Owner | ✅ **CLOSED by `ADR-0080`** §5 — prefix **REGISTERED** |
| `004` | No PRD for `BC-14`; `SharedContentRef` unratified | Architecture Owner / `BC-14` author | ⛔ **OPEN.** A PRD cannot be authored by an ADR. `PRD_LIFECYCLE.md` §5 rule 5 preserves the number |
| `005` | *"A3 does not exist on disk"* | A3 author | ✅ **CLOSED on measurement** — §3 |
| `006` | Body length / attachment count / page-size bounds unset | Product + **Configuration Owner** | ⛔ **OPEN.** Bounds are values; `PRD-023` owns configurables. Inventing a bound is invention |
| `007` | Enforcement staleness ceiling — `PRD-020` is DRAFT | `PRD-020` owner | ⛔ **OPEN.** ⭐ **This is the `PRD-020` release gate and it is expressly preserved** — see §5 |
| `008` | Permission catalogue closed; **0** `PERM-*` exist (`AUTH-7.22`, `ADR-0036` §7.1) | Governance **+ Auth** owner | ⛔ **OPEN.** The Governance Owner now exists but is **not the only** required authority; a closed register needs an ADR *by its owner* (`PRD_LIFECYCLE.md` §5 rule 6) |
| `009` | BC Map §8 has no aggregate row for `BC-15` | Architecture Owner (`LCF-ADR-001`) | ⛔ **OPEN — routed.** ⭐ Measured this pass: BC Map is **625** lines with **1,376** line-citations, max cited **L605**; an append after **L624** would break **0**. **But §8 is a structured register, not an addendum** — an aggregate row must sit *in* §8, and that insertion shifts cited lines. Requires its own ADR; **not performed here** |
| `010` | No latency/throughput budget | Product + Architecture Owner | ⛔ **OPEN.** A budget is a value |
| `011` | ⛔ `integration_test/` does not exist | Engineering Owner | ⛔ **OPEN — verified still true.** §3 |
| `013` | EA does not enumerate comments/reactions | Architecture Owner | ✅ **CLOSED — enumeration half by `ADR-0079`.** The determination half closed earlier |
| `014` | Reaction kinds unenumerated | Product Owner | ✅ Already **RESOLVED** at A2 v0.6 |

### 4.2 A3 — `LCR-GAP-*`

| ID | Subject | Owner | Disposition |
|---|---|---|---|
| `001` | `LCR-` prefix not registered | Governance Owner | ✅ **CLOSED by `ADR-0080`** §5 |
| `002` | No `helpState` / announcement type exists | Product + `BC-15` owner | ⛔ **OPEN.** `LCR-RS-002`/`005` stay **DEFERRED** at weight 0 |
| `004` | Needs a `BC-15 → BC-11` edge (BC Map **L292**: an unlisted edge does not exist) | Architecture Owner | ⛔ **OPEN — routed.** ⭐ The `ADR-0055` precedent covers *"three named cells in one named file"*, but that was a **consumer-cell** amendment; **adding an edge** is a different act, and BC Map §7 is a structured register. Its own ADR is required |
| `006` | Per-viewer impression tracking, minor-inclusive population | **Privacy Owner** + Product | ⛔ **OPEN.** ⭐ The role now **exists** (`ADR-0077`) so the item is *requestable* for the first time — but `ADR-0077` §9.5 states expressly that no privacy decision is taken. `LCR-RS-007` stays **DEFERRED**, weight 0 |
| `007` | No `BC-13` content-quality contract | Architecture Owner + `BC-13` owner | ⛔ **OPEN.** `LCR-RS-008` stays **DEFERRED**, weight 0 |
| `008` | BC Map §8 aggregate row (the A3 half of `LCF-GAP-009`) | Architecture Owner | ⛔ **OPEN — routed**, as §4.1 `009` |
| `010` | No latency budget | Product + Architecture Owner | ⛔ **OPEN** |

### 4.3 A3 — `LCR-DEC-*`

| ID | Subject | Owner | Disposition |
|---|---|---|---|
| `001` | Ranking transparency posture | Product Owner | ⛔ **OPEN** |
| `003` | Per-viewer already-seen tracking | **Privacy Owner** | ⛔ **OPEN** — requestable now, undecided |
| `004` | Official-source priority definition | Product Owner | ⛔ **OPEN** |
| `006` | Feed staleness tolerance | Product Owner | ⛔ **OPEN** |
| `007` | Cold-start behaviour | Product Owner | ⛔ **OPEN** |
| ⭐ `009` | Helpfulness weight | **Product Owner** | ⛔ **REFUSED as undecidable — §2** |

### 4.4 Findings

| ID | Disposition |
|---|---|
| `LCR-FND-013` | ✅ **CLOSED by `ADR-0079`** — the EA now enumerates both capabilities at V2 |

### 4.5 The arithmetic of this ADR

| | Count |
|---|---|
| Items **CLOSED** in this pass (all three ADRs) | **5** — `LCF-GAP-001`, `LCF-GAP-005`, `LCF-GAP-013` (enumeration half), `LCR-GAP-001`, `LCR-FND-013` |
| Items **REFUSED** | **1** — `LCR-DEC-009` |
| Items **OPEN — routed** | **16** |
| Items closed by inventing a value | ⭐ **0** |

---

## 5. ⭐ The `PRD-020` release gate is preserved, and `PRD-021A` is NOT READY / NOT FROZEN

`PRODUCT_IMPLEMENTATION_ROADMAP.md` **L161–164** states that **`PRD-021` must not ship before `PRD-020`**, and
characterises shipping in the wrong order as *"a release-blocking defect"*.

⭐ **Nothing in `ADR-0079`, `ADR-0080` or this ADR weakens that gate, and this ADR expressly reaffirms it.**

### 5.1 Why READY/FROZEN is refused — the conditions that are genuinely unmet

| # | Blocking condition | Measured status |
|---|---|---|
| 1 | ⭐ `PRD-020` must precede `PRD-021` | ⛔ **`PRD-020` is still DRAFT/unranked** (`LCF-GAP-007`). **The gate is unsatisfied** |
| 2 | Enforcement staleness ceiling | ⛔ OPEN — depends on 1 |
| 3 | `integration_test/` exists and exercises the seam | ⛔ **Directory does not exist** (`LCF-GAP-011`) |
| 4 | Permission identifiers exist | ⛔ **0 `PERM-*` in the repository** (`LCF-GAP-008`) |
| 5 | `BC-14` has a PRD; `SharedContentRef` ratified | ⛔ OPEN (`LCF-GAP-004`) |
| 6 | BC Map §8 carries a `BC-15` aggregate row | ⛔ OPEN (`LCF-GAP-009`, `LCR-GAP-008`) |
| 7 | `BC-15 → BC-11` edge registered | ⛔ OPEN (`LCR-GAP-004`) — BC Map **L292**: an unlisted edge **does not exist** |
| 8 | Ranking weights complete under `LCR-FR-035` | ⛔ **`LCR-DEC-009` REFUSED/OPEN** — §2 |
| 9 | Privacy determinations for per-viewer tracking | ⛔ OPEN (`LCR-DEC-003`, `LCR-GAP-006`) |
| 10 | Latency/throughput budgets | ⛔ OPEN (`LCF-GAP-010`, `LCR-GAP-010`) |
| 11 | Stage 7 performed by the Governance Owner | ⛔ **Not performed.** `ADR-0080` constituted the role; it did not exercise it, and `PRD_LIFECYCLE.md` §7 makes Stage 7 non-skippable |

⛔ **Determination: `PRD-021A` A2 and A3 remain NOT READY and NOT FROZEN.** ⭐ Eleven conditions are unmet, and
the first is a **release-blocking gate on a different PRD** that no act inside `PRD-021A` can satisfy. The
instruction governing this pass was to declare READY/FROZEN **only if** all required conditions were genuinely
complete. **They are not.** Declaring otherwise would be the single most damaging act available here, because a
freeze marker is relied upon downstream as evidence that the gates were passed.

### 5.2 What *did* change

⭐ Five items closed **by authority**, one refused **with its reason measured**, and the EA defect that had been
`EXECUTION BLOCKED` since `ADR-0075` is **executed** with **0** citations broken and **0** frozen files touched.
That is genuine progress. It is not readiness, and this ADR does not present it as readiness.

---

## 6. Consequential edits authorised

| Document | Change | Authority |
|---|---|---|
| A2 → **v0.7** | `LCF-GAP-013` enumeration half → **CLOSED**; `LCF-GAP-005` → **CLOSED**; registers recounted; **NOT READY / NOT FROZEN preserved** | `ADR-0079`, §3 |
| A3 → **v0.5** | `LCR-FND-013` → **CLOSED**; `LCR-DEC-009` recorded **REFUSED/OPEN**; ⭐ **weights unchanged at 70 + 30 = 100**; **NOT READY / NOT FROZEN preserved** | `ADR-0079`, §2 |
| `ADR-INDEX.md` | Rows for `ADR-0079`, `0080`, `0081`; Count re-derived | Governance Owner |
| Decision Record → **v2.1** | New §7.12 recording these three acts | Governance Owner |

⛔ **No other document is touched.** In particular: **no frozen PRD**, no `MASTER_PRD.md`, no BC Map, no
`ARCHITECTURE_RULINGS.md`, and no `tool/` gate.

---

## 7. What this ADR does not do

| Claim | Status |
|---|---|
| `LCR-DEC-009` is resolved | ⛔ **No — REFUSED as undecidable.** OPEN, Product Owner |
| Any weight, bound, budget or permission identifier is assigned | ⛔ **No.** Zero values invented |
| Any Product / Privacy / Engineering / Auth Owner decision is taken | ⛔ **No** |
| `PRD-020`'s gate is satisfied, waived or bypassed | ⛔ **No** — reaffirmed in §5 |
| A BC Map edge or aggregate row is added | ⛔ **No** — routed, each needing its own ADR |
| Any frozen document is modified | ⛔ **No.** **0** frozen files touched in this entire pass |
| `PRD-021A` becomes READY or FROZEN | ⛔ **No** — **11** conditions unmet, §5.1 |
| Any lifecycle stage advances | ⛔ **No.** Stage 7 not performed |
