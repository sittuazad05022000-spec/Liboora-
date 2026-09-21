<!-- LIBOORA Design Documentation | Design Decision Records | 2026-09-19 -->

> This document is design governance and documentation. ⛔ It does **not** amend product
> requirements, architecture decisions, bounded-context ownership, permissions, roles or
> backend contracts.

# DDR-0017 … DDR-0020 — Founder/Product Authority closure decisions

| Field | Value |
|---|---|
| **Register** | ⭐ Filed under [`design-decisions/README.md`](README.md) §2's **required template** and §4 filing rules |
| **Date** | 2026-09-19 |
| **Approver** | ⭐⭐ **Founder/Product Authority** *(`DESIGN_GOVERNANCE.md` §3 rule 6: *"Founder/Product Authority is the final authority for business and product design direction"*)* |
| **Source of the decisions** | ⭐ A **human decision instruction** answering [`LIBOORA_DESIGN_AUTHORITY_CLOSURE_PACK.md`](../LIBOORA_DESIGN_AUTHORITY_CLOSURE_PACK.md) packages `CP-B2`, `CP-G`, `CP-I`, `CP-J`, `CP-K` |
| **Change class** | ⭐ **D1 — clarification** *(`DDR-0017`, `DDR-0020`)* · **D3 — experience** *(`DDR-0018`)* · **D1/D3** *(`DDR-0019`)*. ⛔ **No D2 and no D4 act is taken here** |
| ⛔ **What this file does NOT do** | ⛔ It does **not** resolve the layer-ratio **CONFLICT** · ⛔ does **not** edit `DESIGN_SYSTEM.md`, `VISUAL_LANGUAGE.md`, `DESIGN_FOUNDATION.md`, `ACCESSIBILITY.md`, `PERFORMANCE.md`, `DESIGN_DEBT.md` or `DD-0007` · ⛔ does **not** select a font, device profile, SLO, spacing or elevation value · ⛔ does **not** record any gate |

> ⭐⭐ **Scope discipline.** ⭐ The instruction named **five** packages and expressly withheld
> **eight** others *(`CP-A`, `CP-B1`, `CP-B4`, `CP-C`, `CP-D`, `CP-E`, `CP-F`, `CP-H`)*.
> ⛔ **None of the eight is touched, implied or pre-judged here.**

> ⚠️⚠️ **Identifier hygiene.** ⭐ `DDR-0012`…`DDR-0016` are **proposed record locations**
> named in the closure pack for **other owners' future decisions**. ⛔ They are **NOT
> allocated by this file** and remain free. ⭐⭐ **`DDR-0013` in particular is reserved for
> the Design System Owner's layer-ratio reconciliation and is deliberately left unused** —
> ⛔ using it here would make a Founder re-affirmation look like the conflict resolution.
> ⭐ `DDR-0017` is used **as the pack reserved it**; `DDR-0018`–`0020` were verified free
> *(**0** repo-wide occurrences)*.

---

## DDR-0017 — Approved design direction is bound to **`v0.1`** *(`CP-I`)*

| Field | Value |
|---|---|
| **Status** | ⭐ **APPROVED** |
| **Date** | 2026-09-19 |
| **Owner** | Design Governance Owner *(custody of the approval record)* |
| **Approver** | ⭐⭐ **Founder/Product Authority** |
| **Scope** | The approval evidence for `DDR-0009` — whole design system |
| **Source references** | `LIBOORA_DESIGN_AUTHORITY_CLOSURE_PACK.md` `CP-I` · `DESIGN_OWNERSHIP.md` §3 · `DDR-0009` · `LIBOORA_MASTER_DESIGN_SYSTEM.md` header **L13** · `LIBOORA_DESIGN_SYSTEM_FINAL_AUDIT.md` §2.3 |
| **Decision** | ⭐⭐ **The approved design direction and Master Design System are identified as version `v0.1`.** ⭐ This supplies the **version** element that `DDR-0009` omitted, curing the defect recorded as `FA-GAP-001` |
| **Alternatives** | ⛔ Leave `DDR-0009` unversioned — **rejected**: `DESIGN_OWNERSHIP.md` §3 requires *"artifact, **version**, decision status, approver role, date, and unresolved conditions"*, and `DDR-0009` supplied **5 of 6** · ⛔ Re-issue `DDR-0009` — **rejected**: `README.md` §4 forbids reusing an ID, and the substance of that approval is unchanged |
| **Consequences** | ⭐⭐ **The approval now binds to a specific revision.** ⭐ This matters because `v0.1` **will be amended** by the outstanding owner acts *(`CP-B1`…`CP-D`)*; ⭐ a future reader can now determine exactly what was approved and what came after · ⛔ **It does NOT re-approve, widen or re-open `DDR-0009`** — ⭐ its two named holes *(typeface family, device profile)* **stand exactly as recorded** · ⛔ It approves **no** subsequent version: ⭐⭐ **any amendment to `v0.1` requires its own approval** |
| **Open questions** | ⭐ Version numbering convention for amended foundations — **Design Governance Owner** *(`DESIGN_CHANGE_MANAGEMENT.md` §2 records exact release numbering as `TO BE DECIDED`)* |
| **Review trigger** | ⭐ Any amendment to `LIBOORA_MASTER_DESIGN_SYSTEM.md`; ⭐ any new approval act |

---

## DDR-0018 — Founder direction re-affirmed: **70% 2D / 25% 2.5D / ≤5% 3D** *(`CP-B2`)*

| Field | Value |
|---|---|
| **Status** | ⭐ **APPROVED** *(as Founder/Product direction)* — ⚠️⚠️ **the CONFLICT remains OPEN** |
| **Date** | 2026-09-19 |
| **Owner** | Design Vision Owner |
| **Approver** | ⭐⭐ **Founder/Product Authority** |
| **Scope** | Visual layer direction — **APP 1** primarily; hierarchy binds all apps |
| **Source references** | `LIBOORA_DESIGN_AUTHORITY_CLOSURE_PACK.md` `CP-B2` · `DDR-0010` · `LIBOORA_DESIGN_SYSTEM_FINAL_AUDIT.md` §4.1 |
| **Decision** | ⭐ **ACCEPT the Founder/Product visual direction: 70% 2D · 25% 2.5D · ≤5% 3D.** ⭐⭐ **This is a re-affirmation of the direction already recorded at `DDR-0010`, ⛔ not a new or different value** |
| ⚠️⚠️ **What this expressly does NOT do** | ⛔⛔ **It does NOT resolve the `70/20/10` conflict.** ⭐ Per the authority's express instruction: *"This does NOT resolve the existing 70/20/10 conflict. Leave the conflict for the Design System Owner + Design Vision Owner."* ⛔ **No canonical document is amended** · ⛔ **Neither value is overwritten** · ⭐ `VISUAL_LANGUAGE.md` §1, `DESIGN_FOUNDATION.md` **L10**, `DESIGN_SYSTEM.md` §2 and `MASTER` L105 **all stand byte-unchanged**, still stating `70/20/10` as **CONFIRMED** |
| ⭐⭐ **What it usefully adds** | ⭐ `DDR-0010` stated `25%` in its Decision cell but ⛔ **flagged only the 3D limb as conflicting** — measured: `20%` appears **0** times in it. ⭐⭐ **This record confirms the Founder's direction covers BOTH limbs**, so the reconciler now has an authority statement on the depth layer too. ⭐ **That is the entirety of what this record adds** |
| **Alternatives** | ⛔ Adopt `70/25/≤5` as canonical and amend the four documents — **rejected**: that is the **Design System Owner's** act and would silently close a `CONFLICT`, barred by `DESIGN_GOVERNANCE.md` §3 rule 4 · ⛔ Withdraw the direction — **not taken** |
| **Consequences** | ⭐⭐ **The conflict is now better specified, not smaller.** ⭐ The reconciler must address **two limbs across four documents**: ⭐ **3D** `~10% → ≤5%` *(stricter — working to ≤5% breaches neither)* and ⭐⭐ **depth** `20% → 25%` *(**looser** — ⛔ the containment argument **fails** on this limb)* · ⭐ Both triples sum to **100** · ⭐ Until reconciled, ⛔ **no canonical layer ratio exists** and ⭐ **design work must treat the ratios as unsettled** · ⚠️ The ≤5% figure remains validated against `DDR-0006`'s **provisional** target only |
| **Open questions** | ⭐⭐ **The reconciliation itself — Design System Owner + Design Vision Owner**, filed as **class D4**, with **Design Documentation Owner** for `DESIGN_FOUNDATION.md` L10. ⭐ Its record location remains **`DDR-0013`**, ⛔ deliberately unused here |
| **Review trigger** | ⭐ The reconciliation act; ⭐ confirmation of the V1 device profile; ⭐ any proposal to add a fifth 3D moment |

---

## DDR-0019 — `DD-0007` update **directed**, subject to the UX Architecture Owner's process *(`CP-J`)*

| Field | Value |
|---|---|
| **Status** | ⭐ **APPROVED as direction** — ⚠️ ⛔ **the amendment itself is NOT performed and NOT approved as executed** |
| **Date** | 2026-09-19 |
| **Owner** | ⭐ **UX Architecture Owner** *(`DD-0007` header Owner cell)* |
| **Approver** | ⭐ **Founder/Product Authority** *(direction only)* |
| **Scope** | `DD-0007` Configuration surface design — **APP 2** |
| **Source references** | `LIBOORA_DESIGN_AUTHORITY_CLOSURE_PACK.md` `CP-J` · `DDR-0008` · `ADR-0163` **§4.4** · `ADR-0162` · `DD-0007` v0.9 |
| **Decision** | ⭐ **ACCEPT: apply the pre-computed `DD-0007` update — ⛔ subject to its authorized UX Architecture Owner process.** ⭐ Two limbs: ⭐ **(a)** reflect `DDR-0008`'s `C-4` removal; ⭐ **(b)** refresh coverage **79 → 85** per `ADR-0163` §4.4 |
| ⚠️ **The limit of this record, stated plainly** | ⛔⛔ **A Founder direction is not the owner's act.** ⭐ `DESIGN_OWNERSHIP.md` §1 assigns `DD-0007` to the UX Architecture Owner; ⭐ §2 keeps authority and execution separate. ⭐⭐ **`DD-0007` is byte-unchanged** *(md5 `db7beded`)* and ⛔ **remains at v0.9 / 79 of 104** until that office acts |
| **Alternatives** | ⛔ Amend `DD-0007` here — **rejected**: not this record's office, and `DESIGN_DEBT.md` rule 5 bars it · ⛔ Defer the direction — **not taken**: the evidence is complete and pre-computed |
| **Consequences** | ⭐ The owner has an **unambiguous mandate** plus a **pre-computed change set**: *v0.9→v1.0 · 79→85 · holds 25→19 · D3 stays `PARTIAL` · `C-5` stays · Figma blockers stay 4* · ⭐ `DD7-GAP-008` is discharged for V1 **by removal**, ⛔ **not by allocating a reader** — ⛔ **no authority is created** · ⚠️ If a future authorized requirement mandates a `BC-25` audit-reading surface, ⭐⭐ **`C-4` returns and the reader question reopens** · ⛔ This does **not** make `DD-0007` design-ready: ⭐ **19 `BC-25` parameters remain held** and `D3` stays `PARTIAL` |
| **Open questions** | ⭐ Execution — **UX Architecture Owner** · ⭐ The 19 held parameters — per `DP-0004`, ⛔ outside design |
| **Review trigger** | ⭐ Any further change to `BC-25` authorization coverage; ⭐ any new `BC-25` audit-reading requirement |

---

## DDR-0020 — Register count corrections **directed** *(`CP-K`)*

| Field | Value |
|---|---|
| **Status** | ⭐ **APPROVED as direction** — ⚠️ ⛔ **the corrections themselves are NOT performed** |
| **Date** | 2026-09-19 |
| **Owner** | ⭐ **Design Documentation Owner** *(`design-decisions/README.md` §3)* · ⭐ **Design Governance Owner** *(`DESIGN_DEBT.md` `DBT-008`)* |
| **Approver** | ⭐ **Founder/Product Authority** *(direction only)* |
| **Scope** | Two governance registers |
| **Source references** | `LIBOORA_DESIGN_AUTHORITY_CLOSURE_PACK.md` `CP-K` · `design-decisions/README.md` §3 · `DESIGN_DEBT.md` `DBT-008` |
| **Decision** | ⭐ **ACCEPT: correct the factual decision/register counts through the authorized Design Documentation / Governance process.** ⭐ `README.md` §3 states *"**No** design decision has been marked APPROVED"* and `DBT-008` states *"**0** design decisions … APPROVED"* — ⭐⭐ both overtaken: **15 DDR records now exist** *(`DDR-0001`…`0011`, `0017`…`0020`)*, of which **13 are APPROVED**, ⚠️ **1 is provisional** *(`DDR-0006`)* and ⚠️ **1 carries an open conflict** *(`DDR-0010`)* |
| ⚠️⚠️ **A limit that must not be missed** | ⛔⛔ **`DBT-008` is to be CORRECTED, ⛔ NOT CLOSED.** ⭐ Its two limbs are joined by *"and"*, and ⭐ the second — *"Gates `G0`–`G5` exist and **none has been recorded as passed**"* — ⭐⭐ **remains true at 0 of 6**. ⭐ Its review trigger *("A design approval act")* **has fired**, so the row is **due for review**; ⛔ **due for review is not closed** |
| **Alternatives** | ⛔ Close `DBT-008` — **rejected**: half the row is still true · ⛔ Edit the registers here — **rejected**: `DESIGN_DEBT.md` rule 5 and `DESIGN_OWNERSHIP.md` §2 |
| **Consequences** | ⭐ Removes registers that **contradict their own contents** · ⭐ `README.md` §4 also requires each record be **added to the register** — ⭐ **15 records now require registration** · ⛔ **No debt row is closed** and ⛔ **no gate is recorded** |
| **Open questions** | ⭐ Execution — Design Documentation Owner and Design Governance Owner · ⭐ Whether `DBT-008` is re-scoped to its surviving gate limb — **Design Governance Owner** |
| **Review trigger** | ⭐ Any further DDR; ⭐ the first recorded gate pass |

---

## ⛔ `CP-G` — expressly KEPT OPEN, ⛔ no decision taken

⭐ The instruction stated: *"`CP-G`: **KEEP OPEN.** No Founder decision required."*
⭐⭐ **Recorded here as a non-decision so the absence is deliberate and visible** — ⛔ no
`DDR-*` identifier is consumed for it.

| Gate | ⛔ Independent prerequisite | Why no Founder act was taken |
|---|---|---|
| **`G1`** Experience architecture | ⛔ **`DBT-006`** — the designed screen set and the built screen set **do not intersect** | ⚠️ ⭐ `DBT-006`'s owning office **is** the Founder/Product Authority — ⭐ so a decision **was** available. ⛔ **The authority declined to take it**, and ⛔ **it is not taken by implication here** |
| **`G4`** Design QA | ⛔ **`DBT-004`** — **1** `testWidgets` assertion against **6** required check categories | ⭐ Owned by the **Design QA Owner** with the engineering counterpart; ⛔ outside this act |

⛔⛔ **Neither gate is downgraded, re-scoped, or routed to a reachable office to make it
actionable** — ⭐ the practice `DESIGN_OWNERSHIP.md` §1.1 expressly warns against.

---

## Register summary — this file

| DDR | Subject | Package | Status |
|---|---|---|---|
| `DDR-0017` | Approved direction bound to **`v0.1`** | `CP-I` | ⭐ **APPROVED** |
| `DDR-0018` | **70 / 25 / ≤5** re-affirmed | `CP-B2` | ⭐ **APPROVED** — ⚠️ **conflict OPEN** |
| `DDR-0019` | `DD-0007` update directed | `CP-J` | ⭐ **APPROVED as direction** |
| `DDR-0020` | Register corrections directed | `CP-K` | ⭐ **APPROVED as direction** |
| — | `G1` / `G4` | `CP-G` | ⛔ **KEPT OPEN — no decision** |

### ⛔ Expressly NOT decided — reserved to their named owners

| Package | Subject | Owner | Record location *(reserved, ⛔ unused)* |
|---|---|---|---|
| `CP-A` | V1 device profile | ⭐⭐ **Technical Owner** | — |
| `CP-B1` | Typeface family | Design System Owner | `DDR-0012` |
| `CP-B2′` | ⭐⭐ **The layer-ratio CONFLICT** | Design System + Design Vision Owner | ⭐ **`DDR-0013`** |
| `CP-B3` | Colour + radius ratification | Design System Owner | `DDR-0014` |
| `CP-B4` | Spacing + elevation | Design System Owner | `DDR-0015` |
| `CP-C` | Accessibility amendments | Accessibility Owner | `DDR-0016` |
| `CP-D` | Responsive artifact | Responsive Design Owner | — |
| `CP-E` | `NFR Budgets (V1)` | Governance + Design Performance Owner | — |
| `CP-F` | Gate `G0` | Design Documentation Owner | — |
| `CP-H` | Gate `G5` | Design Governance Owner | — |

⭐ **4 recorded · 1 kept open · ⛔ 10 reserved to other offices.**

---

## ⛔ What this record does **not** do

⛔ **0** canonical design documents amended *(`DESIGN_SYSTEM.md`, `VISUAL_LANGUAGE.md`,
`DESIGN_FOUNDATION.md`, `ACCESSIBILITY.md`, `PERFORMANCE.md`, `DESIGN_DEBT.md`,
`DD-0007` all **byte-unchanged**)* · ⛔ **0** conflicts resolved · ⛔ **0** fonts, device
profiles, SLOs, spacing, elevation or ratio values selected · ⛔ **0** gates recorded ·
⛔ **0** debt rows closed · ⛔ **0** PRDs, ADRs, permissions, `PERM-*`, roles, scopes or
app boundaries touched · ⛔ **0** code · ⛔ **0** Figma · ⛔ no commit, no push.

⭐⭐ **The Design System remains NOT APPROVED.** ⭐ `DESIGN_GOVERNANCE.md` §3 rule 5:
*"Design approval does not approve a PRD, architecture decision, implementation, or
release."*
