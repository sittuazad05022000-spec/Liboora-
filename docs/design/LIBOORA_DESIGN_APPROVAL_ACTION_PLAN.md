<!-- LIBOORA Design Documentation | Approval Action Plan | 2026-09-19 -->

> This document is **design governance and documentation**. ⛔ It does **not** amend product
> requirements, architecture decisions, bounded-context ownership, permissions, roles, app
> boundaries or backend contracts. ⛔ It **approves nothing** and **decides nothing.**
> Where it disagrees with any ranked LIBOORA document, **the ranked document wins.**

# LIBOORA Design Approval — Action Plan

| Field | Value |
|---|---|
| **Document** | `LIBOORA_DESIGN_APPROVAL_ACTION_PLAN.md` |
| **Version** | **v1.0** |
| **Status** | ⚠️ **WORK ORDER** — ⛔ not an approval instrument |
| **Rank** | ⛔ **UNRANKED** |
| **Author** | AI, as Design Documentation Author *(`DESIGN_GOVERNANCE.md` §5 — ⛔ *"Cannot approve business scope or resolve source conflicts"*)* |
| **Source** | [`LIBOORA_DESIGN_SYSTEM_FINAL_AUDIT.md`](LIBOORA_DESIGN_SYSTEM_FINAL_AUDIT.md) · [`DDR-0001…0011`](design-decisions/DDR-0001-to-0009-founder-product-authority-decisions.md) |
| **Purpose** | ⭐ Give each named office **exactly** what it needs to act — and state honestly where the evidence is **not yet sufficient to act at all** |
| ⭐⭐ **Headline** | ⭐ **10 of 13 blockers are READY FOR OWNER ACTION** · ⚠️ **3 are MISSING EVIDENCE** · ⭐ **since `DDR-0013` (2026-10-01): `FA-GAP-002` is RESOLVED** (prior headline retained; see the reconciled tally at the summary table below) |

---

## 1. How to read this plan

⭐ Every blocker carries the six fields requested, plus one verdict:

| Verdict | Meaning |
|---|---|
| ⭐ **READY FOR OWNER ACTION** | ⭐ All evidence the owner needs **already exists in the repository**. ⛔ Only the owner's **decision and signature** are missing |
| ⚠️ **MISSING EVIDENCE** | ⛔ The owner **cannot responsibly decide today** — a fact, measurement or external input does not exist yet |

⚠️⚠️ **The distinction matters.** ⭐ *Ready* means the work is done and waiting. ⭐ *Missing
evidence* means asking the owner to sign now would be asking them to **guess** — which is
how an inference becomes a fact, exactly what `DDR-0006` was written to prevent.

⛔ **No owner, approval, requirement, permission or value is invented here.** ⭐ Every
office named already exists in `DESIGN_OWNERSHIP.md` §1 or `PRD_OWNERSHIP_MODEL.md` §2.2.

---

## 2. Priority ladder — the order that actually unblocks work

⭐ Ordered by **what unblocks what**, not by importance.

| Rank | Blocker | Owner | Verdict | Unblocks |
|---|---|---|---|---|
| **1** | `FA-GAP-009` V1 device profile | ⭐⭐ **Technical Owner** | ⭐ **RESOLVED — `DDR-0034`** (2026-10-01; prior ⚠️ **MISSING EVIDENCE** retained) | ⭐ `FA-GAP-010` (unblocked — ⛔ still OPEN), and validates `FA-GAP-002` |
| **2** | `FA-GAP-002` 3D layer-ratio conflict | **Design System Owner** | ⭐ **RESOLVED — `DDR-0013`** (canonical `70/25/≤5`, both limbs, 4 docs amended, 2026-10-01; prior state retained: ⭐ **READY**) | ⭐ All 2.5D/3D specification |
| **3** | `FA-GAP-003` Typography | **Design System Owner** | ⛔ **BLOCKED / UNVERIFIED** *(§4.3 — probe not executable: no Android API-26 target-class rendering environment; ⛔ no rendering PASS; `DDR-0034`'s profile is not Devanagari evidence; `DDR-0012` stays free; re-trigger: a valid API-26 rendering target matching the `DDR-0034` class, or an owner-accepted equivalent environment; prior state retained: ⚠️ **MISSING EVIDENCE**)* | ⭐⭐ `DDR-0002`'s Indic guarantee |
| **4** | `FA-GAP-004` Token reconciliation | **Design System Owner** | ⚠️ **PART READY / PART MISSING** | ⭐ `DBT-001`, `DBT-005`, `G2` |
| **5** | `FA-GAP-005a` Accessibility amendments | **Accessibility Owner** | ⭐ **DECIDED — `DDR-0004` + `G2_FOUNDATION_APPROVAL_RECORD` §3** (2026-10-01 reconciliation: amendment already made, `ACCESSIBILITY.md` L10/§2.1; prior state retained: ⭐ **READY**) · ⚠️ legal standard still `TO BE DECIDED` | ⭐ `G2` |
| **6** | `FA-GAP-007` Responsive artifact | **Responsive Design Owner** | ⭐ **READY** | ⭐ `DBT-002`, `G3` |
| **7** | `FA-GAP-010` V1 numeric SLOs | **Governance + Design Performance Owner** | ⭐ **RESOLVED — `NFR_BUDGETS_V1.md`** (2026-10-01 owner decision: 5 budgets DECIDED, measured against `DDR-0034`; prior state retained: ⚠️ **MISSING EVIDENCE**) | ⭐ `DD7-GAP-009` (satisfied) |
| **8** | `FA-GAP-001` `DDR-0009` version defect | **Founder/Product Authority** | ⭐ **READY** | ⭐ Approval integrity |
| **9** | `FA-GAP-008` `DD-0007` refresh | **UX Architecture Owner** | ⭐ **READY** | ⭐ `DD-0007` readiness |
| **10** | `FA-GAP-006` Gates `G0`–`G5` | ⭐ Six offices | ⚠️ **SEQUENCED** — §5 | ⭐⭐ **FINAL APPROVAL itself** |

⭐⭐ **Note what rank 1 means.** The top blocker is the one that **cannot** be cleared by
design. ⛔ Ranks 2, 5, 6, 8 and 9 do **not** depend on it — ⭐ **five offices can act today,
in parallel, without waiting for the Technical Owner.**

---

## 3. Blockers — ⭐ READY FOR OWNER ACTION

### 3.1 `FA-GAP-002` — 3D layer-ratio conflict *(class D4)*

| Field | Content |
|---|---|
| **1. Action required** | ⭐ Establish the **canonical** layer ratio. ⛔ **Both values must be reconciled, not one chosen for convenience** *(`DESIGN_GOVERNANCE.md` §3 rule 4)*. ⚠️ **The decision has TWO limbs** — see below |
| **2. Authorized owner** | ⭐ **Design System Owner** *(`DESIGN_OWNERSHIP.md` §1 — "Owns tokens, foundations, usage rules")*, with **Design Vision Owner**; ⭐ **Design Documentation Owner** for `DESIGN_FOUNDATION.md` L10 |
| **3. Evidence available** | ⭐ **Complete.** `VISUAL_LANGUAGE.md` §1 = `70/20/10` **CONFIRMED** · `DESIGN_FOUNDATION.md` **L10** = `70/20/10` **CONFIRMED** · `DESIGN_SYSTEM.md` §2 = `~10%` **CONFIRMED** · `MASTER` L105 = `~10%` INHERITED · `DDR-0010` = `70/25/≤5` **APPROVED**. ⭐ Both sets sum to **100** |
| **4. Missing** | ⛔ **Only the owner's decision.** ⛔ No new measurement is needed |
| **5. Artifact(s) to amend** | ⭐ **4 documents** — `VISUAL_LANGUAGE.md` §1 · `DESIGN_FOUNDATION.md` **L10** · `DESIGN_SYSTEM.md` §2 *(Illustration row)* · `LIBOORA_MASTER_DESIGN_SYSTEM.md` L105 |
| **6. Blocks FINAL APPROVAL?** | ⭐⭐ **YES** — an open `CONFLICT` cannot coexist with FINAL *(`DESIGN_GOVERNANCE.md` §2)* · ⛔ no longer applies — the conflict is reconciled (below) |
| ⭐ **Verdict** | ⭐ **RESOLVED — [`DDR-0013`](design-decisions/DDR-0013-cp-b2-layer-ratio-reconciled-70-25-5.md)** (Design System + Vision Owner, 2026-10-01: canonical `70/25/≤5`, both limbs, 4 documents amended; `DDR-0010` historical text preserved) · prior state retained verbatim: ⭐ **READY FOR OWNER ACTION** |

⚠️⚠️ **Two limbs — the second is the one that gets missed:**

| Limb | Old | New | ⭐ Note |
|---|---|---|---|
| **3D** | ~10% | ≤5% | ⭐ `DDR-0010` **recorded this** |
| ⭐⭐ **Depth / 2.5D** | **20%** | **25%** | ⛔⛔ **`DDR-0010` is SILENT** — `20%` appears **0** times in it |

⛔ **The "≤5% is stricter so it breaches neither" containment argument covers only the 3D
limb.** ⭐ **25% depth is MORE than 20%** — ⛔ so the containment reasoning **fails** on the
depth limb and cannot justify proceeding on the ratios as a whole.

⭐ **Minimum sufficient act:** state the canonical triple, ⭐ name **all four** documents,
⭐ address **both** limbs, ⭐ file under `DESIGN_CHANGE_MANAGEMENT.md` §4.

---

### 3.2 `FA-GAP-005a` — Accessibility amendments

| Field | Content |
|---|---|
| **1. Action required** | ⭐ Adopt `DDR-0004`'s minimums into the canonical accessibility document, replacing two `TO BE DECIDED` cells |
| **2. Authorized owner** | ⭐ **Accessibility Owner** *(`DESIGN_OWNERSHIP.md` §1 — "Owns accessibility criteria, review, and exception records")* |
| **3. Evidence available** | ⭐⭐ **Complete and measured.** `DDR-0004` **APPROVED**: ≥48×48dp · ≥8dp spacing · 4.5:1 / 3:1 · 2dp focus · 200% scale · icon+text always · reduced motion. ⭐ **Driver measured, not asserted:** `success` and `warning` have **identical luminance (5.02 / 4.73)** ⇒ ⛔ colour can never carry status. ⭐ Android 48dp sourced from UI/UX Pro Max `15de38f`. ⭐ The 48dp-vs-36px density tension is **already resolved** *(48dp on touch; 36px only pointer-only ≥905dp)* |
| **4. Missing** | ⛔ **Only the owner's amendment.** ⚠️ ⭐ **One dependency to disclose, not a blocker:** the *"selected standard"* in `ACCESSIBILITY.md` L10 — `DDR-0004` adopts **WCAG 2.1 AA** ratios but ⛔ does not name a legal/product standard. ⭐ The owner may name WCAG 2.1 AA as the **design** standard; ⛔ a **legal** standard is outside design authority |
| **5. Artifact(s) to amend** | ⭐ `ACCESSIBILITY.md` **L10** *(Target)* and **L26** *(touch minimums)* |
| **6. Blocks FINAL APPROVAL?** | ⭐ **YES** — gate `G2` requires the Accessibility Owner |
| ⭐ **Verdict** | ⭐ **DECIDED** — `ACCESSIBILITY.md` L10/§2.1 **amended**: WCAG 2.1 AA via `DDR-0004` (`APPROVED` 2026-09-19), minimums DECIDED (≥48×48dp · ≥8dp · 4.5:1/3:1); adoption/approval recorded in [`G2_FOUNDATION_APPROVAL_RECORD_2026-10-01.md`](G2_FOUNDATION_APPROVAL_RECORD_2026-10-01.md) §3 · ⚠️ the **legal** compliance standard (L10) remains `TO BE DECIDED` (Founder/Product Authority — ⛔ not marked resolved) · ⛔ not a new decision — the amendment was already made · prior state retained verbatim: ⭐ **READY FOR OWNER ACTION** |

⚠️ **Disclosed, not repaired:** `DIT-007` measures **0** occurrences of `Semantics`,
`semanticsLabel` or `textScaleFactor` under `lib/`, and **0** accessibility assertions
under `test/`. ⭐ **Amending the document does not implement it** — ⛔ that is a Technical
Owner task and ⛔ it is **not** a precondition of this amendment.

---

### 3.3 `FA-GAP-007` — Responsive artifact

| Field | Content |
|---|---|
| **1. Action required** | ⭐ **Create** the responsive specification carrying `DDR-0005`'s breakpoints. ⭐ **A creation, not an amendment — the artifact does not exist** |
| **2. Authorized owner** | ⭐ **Responsive Design Owner** *(`DESIGN_OWNERSHIP.md` §1 — "Owns breakpoint behavior, layout adaptation, and device-mode rules")* |
| **3. Evidence available** | ⭐ **Values decided** — `DDR-0005` **APPROVED**: `<600dp` compact · `600–904dp` medium · `≥905dp` expanded, on **Material 3 window size classes**. ⭐ Consequence already reasoned: most students are `<600dp` ⇒ ⭐⭐ **single-column student experience is the primary design**. ⭐ `DDR-0004` already fixes the density rule at each class |
| **4. Missing** | ⛔ **Only the artifact.** ⭐ Measured: **0** occurrences of `600dp`, `905dp` or `breakpoint` in any foundation document |
| **5. Artifact(s) to amend** | ⭐ **NEW FILE** — `DBT-002` names the absence; ⛔ **this plan does not name the file**, that is the owner's choice |
| **6. Blocks FINAL APPROVAL?** | ⭐ **YES** — `G3` handoff requires responsive evidence, and `DESIGN_QA.md` §1 cannot be evaluated against nothing |
| ⭐ **Verdict** | ⭐ **READY FOR OWNER ACTION** |

---

### 3.4 `FA-GAP-001` — `DDR-0009` approval-evidence defect

| Field | Content |
|---|---|
| **1. Action required** | ⭐ Cure the missing **version** element, so the approval binds to a specific artifact revision |
| **2. Authorized owner** | ⭐ **Founder/Product Authority** *(re-affirm, naming `v0.1`)*, **or** ⭐ **Design Governance Owner** *(record the binding under `DESIGN_CHANGE_MANAGEMENT.md` §4)* |
| **3. Evidence available** | ⭐ **Complete.** `DESIGN_OWNERSHIP.md` §3 requires *"artifact, **version**, decision status, approver role, date, and unresolved conditions"*. ⭐ `DDR-0009` supplies **5 of 6**; ⛔ the version string **`v0.1`** *(`MASTER` header L13)* is **never named** |
| **4. Missing** | ⛔ **The version binding itself.** ⛔⛔ **An AI may not supply it** — that would be manufacturing the approver's evidence |
| **5. Artifact(s) to amend** | ⭐ `DDR-0009` *(or a new DDR recording the affirmation — `design-decisions/README.md` §4: ⛔ **never reuse an ID**)* |
| **6. Blocks FINAL APPROVAL?** | ⚠️ **YES, but narrowly** — ⭐ the approval is **substantively present**; ⛔ it is **formally defective**. ⭐⭐ It matters because the Master will be **amended** by the acts in this plan, and an unversioned approval cannot later be shown to have covered, or not covered, those amendments |
| ⭐ **Verdict** | ⭐ **READY FOR OWNER ACTION** |

---

### 3.5 `FA-GAP-008` — `DD-0007` refresh

| Field | Content |
|---|---|
| **1. Action required** | ⭐ **Two limbs:** ⭐ **(a)** reflect `DDR-0008`'s `C-4` removal; ⭐ **(b)** refresh coverage **79 → 85** |
| **2. Authorized owner** | ⭐ **UX Architecture Owner** *(`DD-0007` header Owner cell)* |
| **3. Evidence available** | ⭐⭐ **Complete for both.** ⭐ **(a)** `DDR-0008` **APPROVED**, condition **TESTED** on 4 probes — `CNF-FR-060` *emits* not reads · `CNF-BR-006` is *"a subtraction"* · `CNF-AC-044` *"no second version history"* · ⭐ grep for an audit-reading-surface requirement = **ZERO**. ⭐ **(b)** `ADR-0162` authorized **6** parameters; ⭐ **`ADR-0163` §4.4 prescribes the exact minimum change** *(v0.9→v1.0 · 79→85 · holds 25→19 · D3 stays `PARTIAL` · `C-5` stays · Figma blockers stay 4)* |
| **4. Missing** | ⛔ **Only the owner's edit.** ⭐ The change is **pre-computed** |
| **5. Artifact(s) to amend** | ⭐ `DD-0007` — header *(version + coverage)* · **L1036** *(`C-4` row)* · **L1565** *(surfaces "3 of 5")* · §21 · `DD7-GAP-008` row |
| **6. Blocks FINAL APPROVAL?** | ⛔ **NO** — ⭐ `DD-0007` is a **surface design doc**, not a design-system foundation. ⚠️ ⭐ It **does** block `DD-0007`'s own Figma gate |
| ⭐ **Verdict** | ⭐ **READY FOR OWNER ACTION** |

⚠️ ⛔ **`DD7-GAP-008` is discharged for V1 by removal — ⛔ NOT by allocating a reader.**
⭐ If a future authorized requirement mandates a `BC-25` audit-reading surface, **`C-4`
returns and the reader question reopens.**

---

### 3.6 `FA-GAP-004a` — Radius *(the ready limb of token reconciliation)*

| Field | Content |
|---|---|
| **1. Action required** | ⭐ Ratify `sm 8 / md 12 / lg 16`; ⛔ retire **14** and **18**; ⭐ author a `LiblRadius` token set |
| **2. Authorized owner** | ⭐ **Design System Owner** → **Technical Owner** *(the code change)* |
| **3. Evidence available** | ⭐ **Complete.** `DDR-0003` **APPROVED**. ⭐ As-built measured: **7** `BorderRadius.circular()` calls across **3** values *(12, 14, 18)*; ⛔ **no `LiblRadius` class**. ⭐ Impact bounded: **2** call sites |
| **4. Missing** | ⛔ **Only ratification.** ⛔ **Retiring 14/18 must be recorded as a deprecation** — `DESIGN_DEBT.md` §3: ⛔ *"No artifact is deprecated by deletion"* |
| **5. Artifact(s) to amend** | ⭐ `DESIGN_SYSTEM.md` **L23** · ⭐ `DESIGN_DEBT.md` §3 *(deprecation rows for 14 and 18)* |
| **6. Blocks FINAL APPROVAL?** | ⭐ **YES** — part of `G2` |
| ⭐ **Verdict** | ⭐ **READY FOR OWNER ACTION** |

---

### 3.7 `FA-GAP-004b` — Colour tokens *(the ready limb)*

| Field | Content |
|---|---|
| **1. Action required** | ⭐ Ratify `DDR-0001`'s five decisions into the canonical token table |
| **2. Authorized owner** | ⭐ **Design System Owner**, with **Accessibility Owner** *(contrast review)* |
| **3. Evidence available** | ⭐⭐ **Complete and computed, not eyeballed.** `accent-ink #92400E` → **7.09** card / **6.68** surface · `text-muted #5F6585` → **5.70 / 5.37** · `border/control #7F87A6` → **3.34** *(WCAG 1.4.11 needs 3:1)* · `accent-fill #F5A524` retained **fills only**, paired with `textPrimary` → **8.42**. ⛔ `#B45309` **rejected** — byte-identical to `warning` |
| **4. Missing** | ⛔ **Only ratification** |
| **5. Artifact(s) to amend** | ⭐ `DESIGN_SYSTEM.md` §2 *(Color row)* · `VISUAL_LANGUAGE.md` §3 · `MASTER` L148–149 |
| **6. Blocks FINAL APPROVAL?** | ⭐ **YES** — part of `G2` |
| ⭐ **Verdict** | ⭐ **DECIDED** — colour **DECIDED** in `DESIGN_SYSTEM.md` §2 (`DDR-0001` `APPROVED`, aligned by `DDR-0027`); radius **DECIDED** (`DDR-0003` `APPROVED`; `DDR-0028`), `14`/`18` RETIRED · ⛔ not new decisions — this section's §1 "Action required" (ratify into the token table) is satisfied by the recorded decisions · prior state retained verbatim: ⭐ **READY FOR OWNER ACTION** |

⚠️⚠️ ⛔ **Ratifying the colours does NOT close `DBT-001`** — ⭐ that row has a **second
limb** *(spacing)*, unaddressed. See §4.2.

---

### 3.8 `FA-GAP-005b` — Dark-mode and C-4 staleness in the Master

| Field | Content |
|---|---|
| **1. Action required** | ⭐ Clear **3** now-superseded cells: `MASTER` L170 *("Dark mode: TO BE DECIDED")* · §24 item **7** · §24 item **8** *(`C-4` reader — ⭐ **moot**, the surface is removed)* |
| **2. Authorized owner** | ⭐ **Design Vision Owner** *(dark mode)* · **UX Architecture Owner** *(`C-4`)* · **Design System Owner** *(document custody)* |
| **3. Evidence available** | ⭐ **Complete.** `DDR-0007` **APPROVED** — dark mode **out of V1**, ⭐ architecture extensible via the **no-raw-hex** rule. `DDR-0008` **APPROVED** — `C-4` removed |
| **4. Missing** | ⛔ **Only the edits** |
| **5. Artifact(s) to amend** | ⭐ `LIBOORA_MASTER_DESIGN_SYSTEM.md` L170, §24 items 7 and 8 |
| **6. Blocks FINAL APPROVAL?** | ⚠️ **YES** — ⭐ the Master must not present a **decided** question as open |
| ⭐ **Verdict** | ⭐ **READY FOR OWNER ACTION** |

⭐⭐ **Make `DDR-0007`'s extensibility clause enforceable when amending:** ⛔ **no raw hex
may be written in a component**; every colour resolves through a semantic token, ⭐ so a
later dark theme is **a remap, not a rewrite**. ⭐ Its review trigger is literal — ⭐ *any
raw hex found in a component*.

---

### 3.9 `FA-GAP-005c` — Two registers are factually stale

| Field | Content |
|---|---|
| **1. Action required** | ⭐ Update two statements of fact that **11 DDRs** have overtaken |
| **2. Authorized owner** | ⭐ **Design Documentation Owner** *(`design-decisions/README.md` §3)* · **Design Governance Owner** *(`DESIGN_DEBT.md` `DBT-008`)* |
| **3. Evidence available** | ⭐ **Complete.** `README.md` §3 says *"**No** design decision has been marked APPROVED"* — ⭐ **11 DDRs now exist, 9 APPROVED**. `DBT-008` says *"**0** design decisions … APPROVED"* |
| **4. Missing** | ⛔ **Only the edits.** ⭐ `README.md` §4 also requires each record be **added to the register** |
| **5. Artifact(s) to amend** | ⭐ `design-decisions/README.md` §3 · `DESIGN_DEBT.md` `DBT-008` |
| **6. Blocks FINAL APPROVAL?** | ⛔ **NO** — ⚠️ ⭐ but leaving them creates a register that **contradicts its own contents** |
| ⭐ **Verdict** | ⭐ **READY FOR OWNER ACTION** |

⚠️⚠️ ⛔ **`DBT-008` must NOT be closed — only corrected.** ⭐ The row has **two limbs joined
by "and"**, and ⭐ the second — *"Gates `G0`–`G5` … none has been recorded as passed"* —
⭐ **remains true at 0 of 6**. ⭐ Its review trigger *("A design approval act")* **has
fired**, so the row is **due for review**. ⛔ **Due for review is not closed.**

---

## 4. Blockers — ⚠️ MISSING EVIDENCE

⭐⭐ **These three are NOT ready.** ⭐ Asking the owner to sign today would be asking them
to **guess**. ⭐ For each, this section states **precisely what would make it ready** —
⛔ which is the useful part of saying "not yet".

### 4.1 `FA-GAP-009` — V1 device profile ⭐⭐ *(rank 1)*

| Field | Content |
|---|---|
| **1. Action required** | ⭐⭐ **Determine the official V1 target device profile** — minimum Android version, RAM, screen, network assumption |
| **2. Authorized owner** | ⭐⭐ **Technical Owner** — ⭐ office constituted at `PRD_OWNERSHIP_MODEL.md` §2.2 **L86** *("Implementation, `IMPL-*` tasks, traceability…")*. ⛔ **Not** the Design Performance Owner, who *"**Cannot** set backend SLOs or claim measured performance"* *(`DESIGN_OWNERSHIP.md` §1)* |
| **3. Evidence available** | ⭐ **Directional only.** `MP-CON-12` — *"India-first … a **network-unreliable operating environment**"* · `PERFORMANCE.md` L10 — **CONFIRMED** *"low-end Android, low/intermittent network, mobile-first"* · `DESIGN_FOUNDATION.md` §4 — **CONFIRMED** *"Low-end respect"* |
| **4. Missing** | ⛔⛔ **The numbers.** ⭐ Measured: **16** occurrences of *"Technical Owner"* across `docs/`, of which ⛔ **ZERO** are a device-profile decision — **10** are the design records *asking* for it, **6** are role definitions. ⭐ `Android 8.0 / 2 GB / 720×1600 / 3G` is an **inference from `MP-CON-12`**, ⛔ **not a repository fact** |
| **5. Artifact(s) to amend** | ⭐ `PERFORMANCE.md` **L10** *(Constraints)*; ⭐ then a **NEW** `NFR Budgets (V1)` |
| **6. Blocks FINAL APPROVAL?** | ⚠️⚠️ **PARTIALLY — and this is the most useful line in the plan.** ⛔ It blocks **numeric SLOs** *(`FA-GAP-010`)* and **final validation** of the 3D budget. ⭐⭐ It does **NOT** block colour, radius, typography-family selection, accessibility minimums, breakpoints, dark mode or `C-4` — ⭐ **7 of 13 blockers are independent of it** |
| ⚠️ **Verdict** | ⭐ **RESOLVED by [`DDR-0034`](design-decisions/DDR-0034-cp-a-v1-device-profile-confirmed-by-technical-owner.md)** (Technical Owner, 2026-10-01) — the *"a Technical Owner statement naming minSdkVersion, a reference device class and a network assumption"* test is met · prior state retained: ⚠️ **MISSING EVIDENCE** · ⛔ `FA-GAP-010` (`NFR Budgets`) remains **OPEN** — `DDR-0034` unblocks it, does not close it · ⛔ `CP-B1` Devanagari probe remains **OPEN** |

⭐ **What would make it ready:** ⭐ a Technical Owner statement naming **minSdkVersion**, a
**reference device class** (RAM + resolution) and a **network assumption**. ⭐ Nothing more.

⛔⛔ **`DDR-0006` must stay `PROPOSED — provisional target`.** ⭐ It is usable **as a
conservative design target**; ⛔ **no numeric SLO may be published as authoritative.**

---

### 4.2 `FA-GAP-004c` — Spacing and elevation tokens

| Field | Content |
|---|---|
| **1. Action required** | ⭐ Decide the **spacing token scale** and the **elevation scale** |
| **2. Authorized owner** | ⭐ **Design System Owner** |
| **3. Evidence available** | ⭐ **As-built, measured — ⛔ but as-built is not authority.** `LiblSpace` = **6** steps *(`xs 4`, `sm 8`, `md 12`, `lg 16`, `xl 24`, `xxl 32`)*. ⭐ Elevation measured: **3** uses in `theme.dart` — `0`, `0`, `8` — ⛔ **no scale, no token class** |
| **4. Missing** | ⛔⛔ **A decision — and it must not be a rubber stamp.** ⭐ Measured: across all **11** DDRs, `LiblSpace` appears **0** times and the only *"spacing"* hit is `DDR-0004`'s **≥8dp target spacing** — ⭐ an **accessibility minimum**, ⛔ **not a token scale.** ⭐⭐ **The spacing limb has never been before an authority** |
| **5. Artifact(s) to amend** | ⭐ `DESIGN_SYSTEM.md` **L22** *(Spacing)* and **L24** *(Elevation)*; ⭐ then `DESIGN_DEBT.md` `DBT-001` / `DBT-005` |
| **6. Blocks FINAL APPROVAL?** | ⭐⭐ **YES** — ⭐ `DESIGN_SYSTEM.md` §2 names spacing and elevation as **foundations**; ⛔ a foundation reading `TO BE DECIDED` cannot be FINAL |
| ⚠️ **Verdict** | ⭐ **DECIDED** — spacing **RATIFIED** at [`DDR-0027`](design-decisions/DDR-0027-dbt-001-b1-liblspace-ratification-and-foundation-alignment.md) (6-step `LiblSpace` adopted from shipped values — a Design System Owner act, ⛔ not the "silent rubber-stamp" §4.2 warns against) · elevation **DECIDED** at [`DDR-0028`](design-decisions/DDR-0028-dbt-005-radius-elevation-token-scales-decided.md) (3-level semantic scale); `DESIGN_SYSTEM.md` §2 L22/L24 now DECIDED/RATIFIED · ⛔ not new decisions — the decisions were already taken and recorded · prior state retained verbatim: ⚠️ **MISSING EVIDENCE** *(⭐ the **radius** limb is ready — §3.6; ⚠️ the "0 DDR mentions / never before an authority" measurement is stale since `DDR-0027`/`DDR-0028`)* |

⚠️⚠️ **The trap, stated plainly.** ⭐ It is tempting to write `LiblSpace`'s six values into
`DESIGN_SYSTEM.md` and call the row closed. ⛔ **That is the precise act `DESIGN_DEBT.md`
rule 5 names and forbids:**

> ⛔ *"Silently 'fixing' `DBT-001` by writing the code's token values into
> `DESIGN_SYSTEM.md` would convert an engineering default into design authority."*

⭐ **What would make it ready:** the Design System Owner **reviewing** the 6 steps on their
merits and deciding — ⭐ adopt, amend or replace. ⭐ **Adopting them is a legitimate
outcome; adopting them *by default* is not.**

---

### 4.3 `FA-GAP-003` — Typography ⭐⭐ *(the one with a live, unmet requirement)*

| Field | Content |
|---|---|
| **1. Action required** | ⭐ **Two limbs:** ⭐ **(a)** select the family + licence; ⭐ **(b)** ⭐⭐ **close the gap between `DDR-0002`'s approved guarantee and what the product actually ships** |
| **2. Authorized owner** | ⭐ **Design System Owner** *(selection + licence)* → **Technical Owner** *(bundling, subsetting, fallback)*; ⭐ **Design Governance Owner** for licence review *(`DDR-0002`)* |
| **3. Evidence available** | ⭐ **Requirement APPROVED** — `DDR-0002`: *"YES — V1 MUST support Indic/Devanagari student names… the font strategy MUST **guarantee** proper Indic rendering."* ⭐ **Shortlist reasoned:** **Noto Sans + Noto Sans Devanagari** *(SIL OFL — the only candidate satisfying the pairing criterion **by construction**)* · ⛔ **Inter alone disqualified** *(no Devanagari)* · ⚠️ **Lexend** *(coverage unverified)*. ⭐ **As-built measured:** `theme.dart:49` = `fontFamily: 'Roboto'`, with **0** bundled `.ttf`/`.otf`, **0** `fontFamilyFallback`, **0** mentions in `docs/design/` |
| **4. Missing** | ⛔⛔ **ONE probe — and it is small, specific and cheap.** ⭐ **Whether the V1 target Android platform font stack renders Devanagari reliably on the target device class.** ⚠️ It *usually* does — ⭐ **but "usually" is not the "guarantee" `DDR-0002` requires**, and ⭐ the answer decides between two very different outcomes: ⭐ **(i)** declare an explicit fallback chain *(near-zero app-size cost)*, or ⭐ **(ii)** bundle a subsetted Devanagari face *(app-size cost on low-end Android)*. ⚠️ **That cost is governed by `FA-GAP-009`** |
| **5. Artifact(s) to amend** | ⭐ `DESIGN_SYSTEM.md` **L21** · `VISUAL_LANGUAGE.md` §4 · `MASTER` L181; ⭐ then `pubspec.yaml` + `theme.dart` **(Technical Owner)** |
| **6. Blocks FINAL APPROVAL?** | ⭐⭐ **YES** — ⭐ typography is a named foundation, and ⭐⭐ **an APPROVED requirement is currently unsatisfied** |
| ⚠️ **Verdict** | ⛔ **BLOCKED / UNVERIFIED** — the one probe is **not executable in the available environments** (no Android API-26 target-class rendering environment, 2026-10-01) · ⛔ **no rendering PASS established** · ⛔ `DDR-0034` (device profile) **does not constitute Devanagari rendering evidence** · ⛔ **`DDR-0012` must not be created until an actual probe result exists** · ⭐ **re-trigger:** a valid API-26 rendering target matching the `DDR-0034` V1 class (2 GB + 720×1600, primarily 4G), or an explicitly owner-accepted equivalent test environment · prior state retained verbatim: ⚠️ **MISSING EVIDENCE** — ⭐ **one probe away from READY** |

⛔⛔ **No font is selected here.** ⭐ Three independent bars: `DDR-0002` expressly reserved
it *("the final family is NOT selected here")*; `DESIGN_DEBT.md` rule 5; `DESIGN_GOVERNANCE.md`
L10. ⛔ **Nor is `Roboto` ratified by having been observed.**

⚠️⚠️ **State the risk plainly for the owner:** ⭐ the current configuration is an
**undeclared platform dependency**. ⛔ **The exact failure `DDR-0002` was approved to
prevent — a student seeing their own name as `□□□` — is presently prevented by nothing
in the repository.** ⭐ That is a materially stronger starting position than *"no typeface
chosen"*, and it is why this blocker ranks **3**.

---

### 4.4 `FA-GAP-010` — V1 numeric SLOs

| Field | Content |
|---|---|
| **1. Action required** | ⭐ Create `NFR Budgets (V1)` with numeric limits — image weight, font weight, animation duration, screen payload, time-to-interactive |
| **2. Authorized owner** | ⭐ **Governance Owner** *(document admission — `PRD_OWNERSHIP_MODEL.md` L418)* + **Design Performance Owner** *(design-side budgets)* |
| **3. Evidence available** | ⭐ **Structure only.** `PERFORMANCE.md` §5 lists the **5** budget categories. ⭐ `MASTER` proposes **16ms** frame budget and motion `150/200/300ms` — ⛔ **PROPOSED, not adopted** |
| **4. Missing** | ⛔⛔ **The device profile** *(`FA-GAP-009`)*. ⭐ A budget without a target class is arithmetic without units. ⭐ `MASTER_PRD` L663 — *"Targets are deliberately not set here; they belong to … **NFR Budgets**"*; `ADR-0100` L185 — *"There is **no** Enterprise Architecture NFR Budgets document"*; EA L339–344 is *"headings with zero values"* |
| **5. Artifact(s) to amend** | ⭐ **NEW** `NFR Budgets (V1)`; ⭐ then `PERFORMANCE.md` L8 and §5 |
| **6. Blocks FINAL APPROVAL?** | ⚠️ **PARTIALLY** — ⛔ blocks `DD7-GAP-009` and final validation of the ≤5% 3D budget. ⭐ Does **not** block the token, a11y or responsive foundations |
| ⚠️ **Verdict** | ⭐ **RESOLVED — [`NFR_BUDGETS_V1.md`](NFR_BUDGETS_V1.md)** (2026-10-01 owner decision: the five V1 budgets DECIDED — image ≤200 KB · font ≤400 KB/≤4 faces · animation 0/150/200/300 ms · screen data ≤50 KB · TTI 16 ms frame + <100 ms — all measured against `DDR-0034`; `PERFORMANCE.md` L8/§5 moved to DECIDED; P7 `≤2 s/≤5 s` remains the separate BC-23 server/API latency, ⛔ not redefined as TTI) · prior state retained verbatim: ⚠️ **MISSING EVIDENCE** — ⛔ strictly downstream of `FA-GAP-009` |

---

## 5. `FA-GAP-006` — Gates `G0`–`G5`

⭐⭐ **This is the blocker that actually gates FINAL APPROVAL.** ⭐ `DESIGN_GOVERNANCE.md`
§4 constitutes six gates; ⛔ **0 of 6** are recorded as passed. ⭐ Gates are **sequential** —
`G2` cannot be evaluated while a foundation reads `TO BE DECIDED`.

| Gate | Required evidence *(§4, verbatim)* | Approver | Evidence state | Verdict |
|---|---|---|---|---|
| **`G0`** Source audit | *"Relevant PRDs, freeze records, ADRs, architecture, and developer docs read"* | Design Documentation Owner | ⭐⭐ **Satisfied in substance** — `DD-0007` alone carries **245** `PRD-023`/`CNF-*` citations; the DDRs cite PRDs, ADRs and BC Map throughout. ⛔ **Never recorded as a gate pass** | ⭐ **READY FOR OWNER ACTION** |
| **`G1`** Experience architecture | *"Flows, IA, navigation, screen states, and traceability exist"* | UX Architecture Owner | ⚠️ **Partial** — `USER_FLOWS`, `INFORMATION_ARCHITECTURE`, `SCREEN_ARCHITECTURE`, `PRD_DESIGN_TRACEABILITY` exist; ⛔ **`DBT-006`**: the designed screen set and the built set **do not intersect** | ⚠️ **MISSING EVIDENCE** — ⛔ gated on `DBT-006`, a **Founder/Product Authority** scope question |
| **`G2`** Foundation | *"Tokens, components, visual rules, accessibility, and performance guidance exist"* | **Design System + Accessibility Owner** | ⛔ **Blocked** — ⭐ needs `FA-GAP-002`, `003`, `004a/b/c`, `005a` | ⛔ **BLOCKED** — ⭐ the **critical path** |
| **`G3`** Handoff | *"Annotated specs, states, **responsive behavior**, and trace links are complete"* | Design–Engineering Handoff Owner | ⛔ **Blocked** — ⭐ needs `FA-GAP-007`; `DESIGN_ENGINEERING_HANDOFF.md` exists as a **model**, ⛔ no package | ⛔ **BLOCKED** on `G2` + `FA-GAP-007` |
| **`G4`** Design QA | *"visual, interaction, accessibility, responsive, and constrained-network behavior"* | Design QA Owner | ⚠️⚠️ **Thin** — `DBT-004`: **1** `testWidgets` assertion in the entire repository against **6** check categories. ⭐ A `G4` pass today would rest on **review judgement alone** | ⚠️ **MISSING EVIDENCE** |
| **`G5`** Change | *"Version, impact, decision record, and approvals are recorded"* | **Design Governance Owner** | ⛔ **Blocked** — ⭐ the terminal act; ⚠️ also needs `FA-GAP-001` cured | ⛔ **BLOCKED** — ⭐ **last** |

⭐⭐ **Two gates can be taken almost immediately.** ⭐ **`G0` is genuinely ready** — the
source audit has been performed many times over; ⛔ it has simply never been **recorded**.
⭐ Recording it costs one act and moves the count from **0/6 to 1/6**.

⚠️⚠️ **Two gates are honestly not reachable yet, and neither is a design failure:**
⭐ **`G1`** is gated on `DBT-006` — ⭐ a **product-scope** question *(the designed and built
screen sets don't intersect)*, owned by the **Founder/Product Authority**. ⭐ **`G4`** is
gated on `DBT-004` — ⭐ a **test-coverage** question owned jointly with engineering. ⛔ **No
amount of design work clears either.**

---

## 6. Sequencing — what can proceed in parallel

```
  WAVE 1 — today, in parallel, no dependencies
  ├── FA-GAP-002  3D ratio conflict ........... Design System Owner      ⭐ RESOLVED — `DDR-0013`
  ├── FA-GAP-004a Radius ...................... Design System Owner      ⭐ READY
  ├── FA-GAP-004b Colour ...................... Design System Owner      ⭐ DECIDED — `DDR-0001`/`0003`/`0027`/`0028`
  ├── FA-GAP-005a Accessibility ............... Accessibility Owner      ⭐ DECIDED — `DDR-0004`
  ├── FA-GAP-007  Responsive artifact ......... Responsive Design Owner  ⭐ READY
  ├── FA-GAP-005b Master staleness ............ Vision + UX Arch Owner   ⭐ READY
  ├── FA-GAP-005c Register corrections ........ Doc + Governance Owner   ⭐ READY
  ├── FA-GAP-008  DD-0007 refresh ............. UX Architecture Owner    ⭐ READY
  ├── FA-GAP-001  DDR-0009 version ............ Founder/Product Auth.    ⭐ READY
  ├── G0          Record source audit ......... Design Doc Owner         ⭐ READY
   └── FA-GAP-009  V1 DEVICE PROFILE ........... ⭐⭐ TECHNICAL OWNER      ⭐ RESOLVED — `DDR-0034`
            │                                        (profile confirmed 2026-10-01; prior ⚠️ MISSING retained)
   WAVE 2 — unlocked by Wave 1
    ├── FA-GAP-004c Spacing + elevation ......... Design System Owner   ⭐ DECIDED — `DDR-0027`/`0028`
   ├── FA-GAP-003  Typography .................. Design System Owner   ⚠️ needs 1 probe
   │                                              (probe cost now governed by confirmed class — `DDR-0034`)
    └── FA-GAP-010  NFR Budgets (V1) ............ Governance + Perf     ⭐ RESOLVED — `NFR_BUDGETS_V1`
           │                                        (5 budgets DECIDED 2026-10-01, measured against `DDR-0034`; prior ⚠️ OPEN retained)
  WAVE 3 — gates, strictly sequential
  └── G2 ──▶ G3 ──▶ G5          (G1 gated on DBT-006; G4 gated on DBT-004)
  WAVE 4
  └── FINAL APPROVAL — Founder/Product Authority
```

⭐⭐ **The scheduling insight:** ⭐ **10 acts can start today.** ⛔ The one with the longest
external lead time — **`FA-GAP-009`** — is also the one **nobody in design can do**, ⭐ so
it should be **requested first** even though it is needed **last**.

---

## 7. Blocking summary

| Blocker | Owner | Verdict | Blocks FINAL? |
|---|---|---|---|
| `FA-GAP-001` `DDR-0009` version | Founder/Product Authority | ⭐ **READY** | ⚠️ **YES** *(formal)* |
| `FA-GAP-002` 3D ratio conflict | Design System Owner | ⭐ **RESOLVED — `DDR-0013`** (2026-10-01; prior ⭐ **READY** retained) | ⭐ **NO longer** (reconciled; was ⭐⭐ YES) |
| `FA-GAP-003` Typography | Design System Owner | ⛔ **BLOCKED / UNVERIFIED** | ⭐⭐ **YES** |
| `FA-GAP-004a` Radius | Design System Owner | ⭐ **READY** | ⭐ **YES** |
| `FA-GAP-004b` Colour | Design System Owner | ⭐ **DECIDED** — colour **DECIDED** in `DESIGN_SYSTEM.md` §2 (`DDR-0001` `APPROVED`, aligned by `DDR-0027`); ⛔ not a new decision, only the recorded ratification · prior state retained: ⭐ **READY** | ⭐ **NO longer** (decided; was ⭐ YES) |
| `FA-GAP-004c` Spacing + elevation | Design System Owner | ⭐ **DECIDED** — spacing **RATIFIED** (`DDR-0027`), elevation **DECIDED** (`DDR-0028`), sizes+line-heights `DDR-0031`, weights `DDR-0032`; `DESIGN_SYSTEM.md` §2 rows DECIDED/RATIFIED; ⛔ not new decisions · prior state retained: ⚠️ **MISSING** | ⭐ **NO longer** (decided; was ⭐⭐ YES) |
| `FA-GAP-005a` Accessibility | Accessibility Owner | ⭐ **DECIDED** — `ACCESSIBILITY.md` L10/§2.1 amended: WCAG 2.1 AA via `DDR-0004` (`APPROVED` 2026-09-19), minimums DECIDED (≥48×48dp · ≥8dp · 4.5:1/3:1), adoption/approval recorded in `G2_FOUNDATION_APPROVAL_RECORD_2026-10-01.md` §3; ⚠️ the **legal** compliance standard remains `TO BE DECIDED` (Founder/Product Authority — ⛔ not marked resolved) · prior state retained: ⭐ **READY** | ⭐ **NO longer** (decided; was ⭐ YES) |
| `FA-GAP-005b` Master staleness | Vision + UX Arch Owner | ⭐ **READY** | ⚠️ **YES** |
| `FA-GAP-005c` Register corrections | Doc + Governance Owner | ⭐ **READY** | ⛔ **NO** |
| `FA-GAP-006` Gates `G0`–`G5` | Six offices | ⚠️ **SEQUENCED** | ⭐⭐ **YES** |
| `FA-GAP-007` Responsive artifact | Responsive Design Owner | ⭐ **READY** | ⭐ **YES** |
| `FA-GAP-008` `DD-0007` refresh | UX Architecture Owner | ⭐ **READY** | ⛔ **NO** |
| `FA-GAP-009` V1 device profile | ⭐⭐ **Technical Owner** | ⭐ **RESOLVED — `DDR-0034`** (2026-10-01) | ⚠️ **FULLY MET** — device profile confirmed; `FA-GAP-010` now also RESOLVED (`NFR_BUDGETS_V1`) · prior state retained: ⚠️ PARTIAL → device profile met; `FA-GAP-010` still OPEN |
| `FA-GAP-010` V1 numeric SLOs | Governance + Perf Owner | ⭐ **RESOLVED — `NFR_BUDGETS_V1`** (2026-10-01; prior ⚠️ **MISSING** retained) | ⭐ **NO longer** (decided; was ⚠️ PARTIAL) |

⭐ **14 rows — ⭐ 6 READY · ⚠️ 0 MISSING EVIDENCE · ⚠️ 1 SEQUENCED · ⛔ 1 BLOCKED / UNVERIFIED *(FA-GAP-003)* · ⭐ 6 RESOLVED / DECIDED *(FA-GAP-002, via `DDR-0013`; FA-GAP-004b, via `DDR-0001`/`0003`/`0027`/`0028`; FA-GAP-004c, via `DDR-0027`/`0028`/`0031`/`0032`; FA-GAP-005a, via `DDR-0004` + `G2_FOUNDATION_APPROVAL_RECORD` §3; FA-GAP-009, via `DDR-0034`; FA-GAP-010, via `NFR_BUDGETS_V1`)*.** *(prior state retained: ⭐ 8 READY · ⚠️ 1 MISSING EVIDENCE *(FA-GAP-004c)* · ⚠️ 1 SEQUENCED · ⛔ 1 BLOCKED / UNVERIFIED · ⭐ 3 RESOLVED — `FA-GAP-004b`/`004c`/`005a` moved to DECIDED via the already-recorded decision records, 2026-10-01.)*
⭐ **Blocking FINAL: 6 · ⛔ Not blocking: 8 · ⚠️ Partial: 0.** *(counted from the "Blocks FINAL?" column: blocking = `001`, `003`, `004a`, `005b`, `006`, `007` · not blocking = `002`, `004b`, `004c`, `005a`, `005c`, `008`, `009` (met), `010`. `FA-GAP-004b`/`004c`/`005a` no longer block FINAL — their design decisions are already recorded at `DDR-0001`/`0003`/`0004`/`0027`/`0028`/`0031`/`0032` + `G2_FOUNDATION_APPROVAL_RECORD` §3.)*

⭐⭐ **The honest headline:** ⛔ nothing is blocked on missing **design work**. ⭐ **Nine
blockers are waiting on a signature**, ⚠️ **three on a fact that does not exist yet**, and
⭐ **one on the other two finishing.**

---

## 8. ⛔ What this plan does **not** do

⛔ **0** decisions taken · ⛔ **0** approvals granted, inferred or implied · ⛔ **0**
conflicts resolved — ⭐ **both 3D values and both depth values preserved** · ⛔ **0** fonts
selected · ⛔ **0** canonical documents amended · ⛔ **0** debt rows closed · ⛔ **0** gates
recorded as passed · ⛔ **0** owners, roles, permissions, `PERM-*`, requirements or values
invented · ⛔ **0** PRDs, ADRs or code touched · ⛔ **0** Figma artifacts · ⛔ no commit,
no push.

⭐⭐ **Every act in this plan is its named owner's to take** — `DESIGN_DEBT.md` rule 5,
`DESIGN_GOVERNANCE.md` L10.

---

# ⭐ READY FOR DESIGN AUTHORITY CLOSURE
