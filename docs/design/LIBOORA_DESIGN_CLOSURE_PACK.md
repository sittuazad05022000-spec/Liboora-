<!-- LIBOORA Design Documentation | Closure Pack | 2026-09-19 -->

> Design documentation. ⛔ Does **not** amend PRDs, ADRs, permissions, roles, app
> boundaries, BC ownership or backend contracts.

# LIBOORA Design Closure Pack — the 9 open decisions, worked

| Field | Value |
|---|---|
| **Status** | ⛔⛔ **PROPOSED** · ⛔ **0 approvals recorded** · ⛔ **I approve nothing here** |
| **Closes** | ⛔ **NOTHING.** ⭐ It makes each decision *ready to be taken* |
| **Companions** | [`LIBOORA_MASTER_DESIGN_SYSTEM.md`](LIBOORA_MASTER_DESIGN_SYSTEM.md) · [`LIBOORA_DESIGN_DECISION_PACK.md`](LIBOORA_DESIGN_DECISION_PACK.md) · [`LIBOORA_UIUX_PRO_MAX_RULES.md`](LIBOORA_UIUX_PRO_MAX_RULES.md) |
| **Binding rule** | ⭐⭐ `DESIGN_GOVERNANCE.md` §3 rule 4 — *"**A CONFLICT is not closed by choosing the more convenient design.**"* ⭐ Rule 6 — *"Founder/Product Authority is the final authority"* |

> ⭐⭐ **Method.** Every colour value below was **computed**, not chosen by eye: WCAG 2.1
> relative-luminance contrast against **both** `#FFFFFF` (card) and `#F7F8FC` (surface),
> because a token that passes on white can still fail on the canvas — ⭐ **and one does.**

---

## D-1 · Colour tokens

### D-1a `accent-ink` — a readable amber for text and icons

| | |
|---|---|
| **1. Proposed value** | ⭐ **`#92400E`** — ⛔ **NOT** `#B45309` *(see risk)* |
| **2. Evidence** | ⭐ Measured: `#92400E` = **7.09:1** on card, **6.68:1** on surface — ⭐ clears AA (4.5) and **AAA** (7.0) on card. ⭐ Current `#F5A524` = **2.04:1** ⇒ ⛔ fails as text. ⭐ Full candidate ladder measured: `#D97706` **3.19/3.00** ⛔ · `#A16207` **4.92/4.64** ⚠️ *(thin margin)* · `#92400E` **7.09/6.68** ⭐ · `#7C4A03` **7.40/6.97** ⭐ |
| **3. Risk / tradeoff** | ⚠️⚠️ **`#B45309` is arithmetically the obvious pick (5.02/4.73) and I am rejecting it: it is BYTE-IDENTICAL to the existing `warning` token.** ⭐ Reusing it would make "accent" and "warning" indistinguishable — ⛔ a **semantic collision**, and `DESIGN_GOVERNANCE` rule 4 forbids closing a conflict conveniently. ⚠️ Tradeoff: `#92400E` is browner and less "golden" than the brand amber. ⭐ Mitigation: **`accent-fill` keeps `#F5A524`**, so the brand warmth survives in fills |
| **4. Required owner** | **Design System Owner** *(+ Accessibility Owner to countersign the ratio)* |
| **5. Blocks** | ⭐ **Figma: YES** *(variable cannot bind)* · ⭐ **Flutter: YES** *(`ThemeExtension` cannot be authored)* |

### D-1b `accent-fill` — amber as a ground, never as ink

| | |
|---|---|
| **1. Proposed value** | ⭐ **`#F5A524` RETAINED**, ⛔ **fills only**, ⭐ **always** paired with `textPrimary #14183A` |
| **2. Evidence** | ⭐ `textPrimary` on `#F5A524` = **8.42:1** ⭐ · white on `#F5A524` = **2.04:1** ⛔ unusable |
| **3. Risk / tradeoff** | ⭐ Low. ⚠️ Requires a **lint-able rule**: ⛔ white text on `accent-fill` must be impossible |
| **4. Required owner** | **Design System Owner** |
| **5. Blocks** | Figma **YES** · Flutter **YES** |

### D-1c `text-muted` — the failure nobody would notice

| | |
|---|---|
| **1. Proposed value** | ⭐ **`#5F6585`** |
| **2. Evidence** | ⭐⭐ Current `#6B7194` = **4.76 on card** ⭐ but **4.48 on surface** ⛔ — ⭐ **it passes where designers check and fails where users read.** ⭐ `#5F6585` = **5.70 / 5.37** — clears both with margin. ⭐ Ladder: `#666C8E` **5.12/4.83** *(thin)* · `#5A6080` **6.14/5.79** · `#4E5470` **7.43/7.00** *(AAA both)* |
| **3. Risk / tradeoff** | ⚠️ Slightly heavier secondary text; ⭐ marginally reduces the primary/secondary hierarchy. ⭐ Mitigation: hierarchy also carries via **size and weight**, ⛔ not colour alone |
| **4. Required owner** | **Design System Owner + Accessibility Owner** |
| **5. Blocks** | Figma **YES** · Flutter **YES** |

### D-1d `border` — ⚠️ a split the audit forced

| | |
|---|---|
| **1. Proposed value** | ⭐ **TWO tokens:** `border/decorative` = **`#E3E6F0`** *(retained)* · ⭐ `border/control` = **`#7F87A6`** |
| **2. Evidence** | ⭐ Measured `#E3E6F0` vs surface = **1.17:1**. ⭐ **WCAG 1.4.11** requires **3:1** for *UI component boundaries*, ⛔ but **exempts purely decorative graphics**. ⭐ So a divider at 1.17 is **lawful**; ⛔ **an input or control border at 1.17 is not.** ⭐ Measured ladder: `#A8AFC6` **2.06** ⛔ · `#8C94B0` **2.84** ⛔ *(so close, still fails)* · `#7F87A6` **3.34** ⭐ · `#767E9E` **3.77** ⭐ |
| **3. Risk / tradeoff** | ⚠️ `#7F87A6` is visibly darker and makes forms look heavier than the current calm aesthetic. ⭐ That is the **cost of conformance**, not a defect. ⛔ Keeping one soft border for everything would silently fail 1.4.11 on every text field |
| **4. Required owner** | **Design System Owner + Accessibility Owner** |
| **5. Blocks** | Figma **YES** · Flutter **YES** |

### D-1e The rest of the palette — ⭐ retained unchanged

⭐ `brand` **9.56** · `brandDark` **13.91** · `success` **5.02** · `warning` **5.02** ·
`danger` **6.47** · `info` **5.36** · `textPrimary` **17.19** — ⭐ **all PASS on both
grounds; ⛔ no change proposed.** ⭐ Pairings verified: white on brand **9.56**, on danger
**6.47**, on success **5.02**.

⚠️ **`success` and `warning` both measure 5.02/4.73** — ⭐ **identical luminance**. ⛔ They
are distinguishable by hue only ⇒ ⭐⭐ this is *precisely* why **status must always carry
icon + text**, never colour alone. **Recorded as a constraint, ⛔ not a defect.**

---

## D-2 · Typeface

| | |
|---|---|
| **1. Proposed value** | ⛔⛔ **NO SINGLE FAMILY PROPOSED.** ⭐ Proposed **selection criteria**, and a shortlist |
| **2. Evidence** | ⭐ Skill query `--domain typography` returned **"Dashboard Data"** *(Fira Code + Fira Sans)* and **"Corporate Trust"** *(Lexend + Source Sans 3)*. ⭐⭐ **Neither was verified for Devanagari**, and ⛔ **the skill's dataset does not record script coverage.** ⭐ Indian libraries display Hindi student names — ⭐ a family without Devanagari is **disqualified regardless of its score** |
| ⭐ **Criteria (proposed)** | **(1)** Open licence *(SIL OFL or Apache)* · **(2)** ⭐⭐ **Devanagari coverage in a matched companion** · **(3)** unambiguous numerals — ⭐ `0/O`, `1/l/I` distinguishable at 14px · **(4)** tabular figures · **(5)** variable weight or ≥4 static weights · **(6)** ⭐ small file size for low-end Android |
| ⭐ **Shortlist** | ⭐ **Noto Sans + Noto Sans Devanagari** *(SIL OFL; ⭐ **designed as a matched pair** — the only shortlist entry that satisfies criterion 2 by construction)* · ⚠️ **Inter** *(OFL, superb numerals, ⛔ **no Devanagari** — needs a paired companion)* · ⚠️ **Lexend** *(skill's "Corporate Trust", ⛔ Devanagari unverified)* |
| **3. Risk / tradeoff** | ⚠️ Noto is safe but visually neutral — ⛔ it will not read as "premium" on its own. ⭐ Mitigation: premium comes from **spacing, density and restraint**, ⛔ not from a distinctive typeface. ⚠️ Pairing Inter with a separate Devanagari font risks **mismatched x-height and weight** |
| **4. Required owner** | **Design System Owner** *(licence check: **Design Governance Owner**)* |
| **5. Blocks** | ⭐ **Figma: YES** · ⭐ **Flutter: YES** *(the font asset must be bundled)* |

⚠️⚠️ **This is category B — needs more evidence.** ⭐ Someone must confirm **whether Hindi
(or other Indic) names are actually stored and displayed in V1**. ⛔ I did not find a
definitive statement, and ⛔ **I am not going to assume one either way.**

---

## D-3 · Radius scale

| | |
|---|---|
| **1. Proposed value** | ⭐ **`sm`=8 · `md`=12 · `lg`=16**; ⛔ **retire 14 and 18**; ⭐ pill reserved for status chips |
| **2. Evidence** | ⭐ Measured in `theme.dart`: **7** `BorderRadius.circular()` calls across **3** values — **12** *(5 sites)*, **14** *(1)*, **18** *(1)* — with ⛔ **no `LiblRadius` class** *(`DBT-005`)*. ⭐ **12 already dominates 5 of 7 sites**; ⭐ 14 and 18 are single-use near-duplicates with ⛔ **no stated rationale anywhere in the repository** |
| **3. Risk / tradeoff** | ⭐ Very low — ⭐ a purely visual, reversible change affecting **2** call sites. ⚠️ Someone may have intended 18 to signal "sheet-level"; ⛔ **no document says so** |
| **4. Required owner** | **Design System Owner** |
| **5. Blocks** | ⚠️ **Figma: partially** *(components can be drawn, then re-bound)* · ⭐ **Flutter: YES** *(`LiblRadius` cannot be authored)* |

---

## D-4 · Accessibility minimums

| | |
|---|---|
| **1. Proposed value** | ⭐ **48×48dp** targets · **≥8dp** spacing · **4.5:1** text / **3:1** large & non-text · **2dp** visible focus · **200%** text scale · ⭐⭐ **icon + text for every status** · reduced motion honoured |
| **2. Evidence** | ⭐ The skill's own result: *"Use 44pt on iOS and **48dp on Android**; for web use the separate WCAG Target Size rule"*, with the explicit warning *"**Don't** assume native 44pt or 48dp guidance defines web conformance"* — ⭐ Liboora is **Android-first**, so **48dp**, and ⛔ the web-only **24 CSS px** figure is **not** the governing number. ⭐ WCAG 2.1 SC 1.4.3 / 1.4.11 / 1.4.4 / 2.4.7 / 2.3.3 |
| **3. Risk / tradeoff** | ⚠️⚠️ **Real and worth stating: 48dp targets inside a data-dense layout cost vertical space.** ⭐ A 36px table row *(the skill's `data-dense` default)* **cannot** host a 48dp target. ⭐ Resolution: **row height ≥48dp on touch**, ⛔ the denser 36px reserved for **pointer-only** ≥905dp. ⭐ **This is the central tension of the whole system and it is resolved explicitly, not ignored** |
| **4. Required owner** | **Accessibility Owner** |
| **5. Blocks** | ⭐ **Figma: YES** *(no target size can be drawn)* · ⚠️ **Flutter: partially** *(Material defaults are close, but unverifiable without the rule)* |

---

## D-5 · Responsive breakpoints

| | |
|---|---|
| **1. Proposed value** | ⭐ **< 600dp** *(compact)* · **600–904dp** *(medium)* · **≥ 905dp** *(expanded)* |
| **2. Evidence** | ⭐ **Material 3 window size classes** — ⭐ an **external, citable, versioned standard**, and Liboora is a **Flutter/Android** product whose existing code already uses the `LayoutBuilder` pattern. ⚠️ **CONFLICT:** the skill's checklist gives **375/768/1024/1440 px** — ⛔ **CSS pixels for web**, ⛔ not Android dp. ⭐ **LIBOORA/Flutter preserved; conflict recorded** |
| **3. Risk / tradeoff** | ⭐ Low. ⚠️ 600dp splits large phones from small tablets imperfectly — ⭐ but **no breakpoint is perfect**, and an external standard is defensible where an invented number is not |
| **4. Required owner** | **Responsive Design Owner** |
| **5. Blocks** | ⭐ **Figma: YES** *(frame widths)* · ⚠️ **Flutter: partially** *(`LayoutBuilder` exists; thresholds unfixed)* |

---

## D-6 · Numeric performance budgets

| | |
|---|---|
| **1. Proposed value** | ⛔⛔ **NO NUMBERS PROPOSED** |
| **2. Evidence** | ⭐ `PERFORMANCE.md` L8: *"numeric budgets are **TO BE DECIDED**"*; ⭐ `MASTER_PRD` L663: *"Targets are deliberately not set here; they belong to the Product Roadmap and **NFR Budgets** documents"*; ⭐ `MP-DEP-08` names **`NFR Budgets`** as a dependency; ⭐ the document **does not exist** *(`DD7-GAP-009`)* |
| ⭐ **What I *can* offer** | ⭐ The **measurement frame**, ⛔ not the values: frame budget **16ms** *(60fps — arithmetic, not a target)* · interaction ack **<100ms** *(a perception constant)* · ⭐ **CLS ≈ 0** via space-reserving skeletons. ⛔ **p95 latency, cold-start, bundle size, image weight: I have no evidence and will not invent them** |
| **3. Risk / tradeoff** | ⚠️⚠️ **Inventing an SLO is worse than having none** — it would be cited later as if authoritative. ⛔ That is the `DESIGN_DEBT` rule-5 failure mode in a different register |
| **4. Required owner** | **Governance Owner** *(creates the artefact)* **+ Design Performance Owner** *(design-side figures)* |
| **5. Blocks** | ⚠️ **Figma: partially** *(asset weight guidance absent)* · ⚠️ **Flutter: partially** *(no acceptance threshold to test against)* |

⚠️ **Category B — needs more evidence.** ⭐ Requires a **real device profile**: which
Android version, RAM and network the V1 target actually is. ⛔ **Not in the repository.**

---

## D-7 · Dark mode

| | |
|---|---|
| **1. Proposed value** | ⭐ **OUT of V1** |
| **2. Evidence** | ⭐ **0** LIBOORA sources require dark mode *(measured)*. ⭐ The skill's own design-system output lists **"Dark mode by default"** under ⛔ **AVOID**. ⭐ `DESIGN_SYSTEM.md` §2 does not mention it |
| **3. Risk / tradeoff** | ⚠️ Reception desks are sometimes dimly lit, and dark mode is an expected modern affordance. ⭐ Mitigation: **semantic tokens** *(§3.3)* make a later dark theme a **remap, not a rewrite**. ⚠️ Deferring is cheap **only if** the team never hard-codes a hex |
| **4. Required owner** | **Design Vision Owner** |
| **5. Blocks** | ⛔ **Neither** — ⭐ deferral is a complete answer |

---

## D-8 · `C-4` Change history — the authorized reader

| | |
|---|---|
| **1. Proposed value** | ⛔⛔ **NO VALUE PROPOSED — HOLD.** ⭐ This is a **governance** decision, ⛔ not a design one |
| **2. Evidence** | ⭐ `CNF-BR-006` routes history to the audit trail; ⭐ `CNF-XC-010` bars `BC-25` from a query surface; ⭐ `PRD-016` `AUD-FR-014`/`015`/`016` confine every audit query to **one tenant**; ⭐⭐ **`AUD-XC-005`: *"The module MUST NOT make, store, cache or evaluate an authorisation decision"***; ⭐⭐ **`AUTH-10.23`: *"A **library** MUST be able to view audit only for actions within its own context"*** — ⭐⭐ **that names a TENANT, ⛔ not a ROLE.** ⭐ **The gap is exact: scope is settled, actor is not** |
| **3. Risk / tradeoff** | ⚠️⚠️ **The tempting move is to infer `TR-1` Owner "because Owner sees everything."** ⛔ **Refused** — that is derivation from seniority, which `AUTH-7.28` *(no hierarchy)* and `AP-4` *(no permission from naming or seniority)* both forbid. ⛔ A design document **cannot** allocate a reader |
| **4. Required owner** | ⭐ **Authorization Owner + `PRD-016` Owner** — ⛔ **NOT a design office** |
| **5. Blocks** | ⭐ **Figma: YES for `C-4` only** *(`C-1`/`C-2`/`C-3`/`C-5` unaffected)* · ⭐ **Flutter: YES for `C-4` only** |

⭐ **A legitimate alternative exists:** ⭐ **drop `C-4` from V1.** `CNF-BR-006` requires
history be *reconstructible from the audit trail* — ⛔ it does **not** require a `BC-25`
surface. ⭐ **That would close `DD7-GAP-008` without allocating anything.**

---

## D-9 · Approve the Master Design System as a whole

| | |
|---|---|
| **1. Proposed value** | ⛔⛔ **Cannot be proposed by me** |
| **2. Evidence** | ⭐⭐ `DESIGN_GOVERNANCE.md` L10: *"AI authors and reviews; **AI is not final business authority**"*; ⭐ L9 and §3 rule 6: **Founder/Product Authority is final** |
| **3. Risk / tradeoff** | ⚠️ Approving D-1…D-7 **piecemeal** risks an incoherent system. ⭐ Recommended: **take D-1, D-3, D-4, D-5, D-7 in one session** *(they interlock)*; ⭐ D-2 and D-6 can follow |
| **4. Required owner** | ⭐ **Founder/Product Authority** |
| **5. Blocks** | ⭐ **Everything downstream** |

---

# A. Ready for approval — ⭐ 5 decisions

⭐ **Every value measured, every tradeoff stated. These can be taken in one session.**

| # | Decision | Proposed |
|---|---|---|
| **D-1** | Colour tokens | ⭐ `accent-ink` **`#92400E`** · `accent-fill` **`#F5A524`** *(fills only)* · `text-muted` **`#5F6585`** · `border/decorative` **`#E3E6F0`** + `border/control` **`#7F87A6`** · ⭐ 7 tokens unchanged |
| **D-3** | Radius | ⭐ **8 / 12 / 16**; retire 14, 18 |
| **D-4** | Accessibility | ⭐ **48dp** · 8dp · **4.5:1** · 2dp focus · **200%** · icon+text |
| **D-5** | Breakpoints | ⭐ **600 / 905dp** |
| **D-7** | Dark mode | ⭐ **Out of V1** |

# B. Needs more evidence — ⭐ 2 decisions

| # | Decision | Missing evidence | Who can supply it |
|---|---|---|---|
| **D-2** | Typeface | ⭐⭐ **Is Devanagari (or other Indic) name display in V1 scope?** ⛔ Not stated anywhere. Plus a licence review | **Product Owner** *(scope)* → **Design System Owner** |
| **D-6** | Perf SLOs | ⭐ **The V1 target device profile** — Android version, RAM, network | **Technical Owner** → **`NFR Budgets (V1)`** |

# C. Figma blockers

| Blocker | Cleared by |
|---|---|
| ⛔ Tokens unbound *(`DD7-GAP-007`, `DBT-001`, `DBT-005`)* | ⭐ **D-1 + D-3** |
| ⛔ No target size / contrast rule | ⭐ **D-4** |
| ⛔ No frame widths | ⭐ **D-5** |
| ⛔ No typeface | ⚠️ **D-2** *(evidence first)* |
| ⛔ `C-4` has no reader *(`DD7-GAP-008`)* | ⭐ **D-8** — ⛔ **governance, not design** |

⭐⭐ **D-1, D-3, D-4, D-5 clear four of five.** ⛔ `C-4` is the only one design cannot touch.

# D. Flutter blockers

| Blocker | Cleared by |
|---|---|
| ⛔ No `ThemeExtension` token source | ⭐ **D-1** |
| ⛔ No `LiblRadius` class *(`DBT-005`)* | ⭐ **D-3** |
| ⛔ Font asset unselected | ⚠️ **D-2** |
| ⛔ No perf acceptance threshold | ⚠️ **D-6** |
| ⚠️ Breakpoint constants unfixed | ⭐ **D-5** |

⛔⛔ **Independent of all of the above, and NOT a design matter:** ⭐ `IMPL-020`
*(SMS/DLT — nothing can authenticate)*, ⭐ Gate 3's **9** boundary violations, and ⭐ the
`ADR-0012` debt **expiring 2026-10-31**.

# E. Exact next action

⭐⭐ **Convene one session — Design System Owner + Accessibility Owner + Responsive Design
Owner — and take D-1, D-3, D-4, D-5, D-7.**

⭐ Each arrives with a **measured value, a stated tradeoff and a named owner**. ⭐ The
session output is a short decision record; ⭐ then `DESIGN_SYSTEM.md`, `ACCESSIBILITY.md`
and `PERFORMANCE.md` are amended **by their owners** — ⛔ **not by me**, per
`DESIGN_DEBT.md` rule 5.

⭐ **In parallel, two questions can be answered by anyone with the facts:**
⭐ **(1)** Is Indic-script name display in V1? ⭐ **(2)** What is the V1 target device?

⛔ **`C-4`** goes to the **Authorization Owner + `PRD-016` Owner** — ⭐ or is **dropped
from V1**, which closes `DD7-GAP-008` without allocating anything.

---

## What this pack does **not** do

⛔ **0** decisions approved · **0** tokens ratified · **0** `DD7-GAP-*` closed · **0**
PRDs, ADRs, permissions, `PERM-*`, roles, scopes, architecture or Figma touched · **0**
code modified · ⛔ no commit, no push.

⭐⭐ **All 9 decisions remain PROPOSED.**

---

*End. ⛔⛔ **PROPOSED — NOT APPROVED.***
