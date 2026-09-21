<!-- LIBOORA Design Documentation | Final Consistency Audit | 2026-09-19 -->

> This document is **design governance and documentation**. ⛔ It does **not** amend product
> requirements, architecture decisions, bounded-context ownership, permissions, roles, app
> boundaries or backend contracts. ⛔ It **approves nothing.** Where it disagrees with any
> ranked LIBOORA document, **the ranked document wins and this document is the defect.**

# LIBOORA Design System — Final Consistency Audit

| Field | Value |
|---|---|
| **Document** | `LIBOORA_DESIGN_SYSTEM_FINAL_AUDIT.md` |
| **Version** | **v1.0** |
| **Status** | ⚠️ **AUDIT RECORD** — ⛔ **not an approval instrument** |
| **Rank** | ⛔ **UNRANKED** |
| **Author** | AI, as Design Documentation Author *(`DESIGN_GOVERNANCE.md` §5 — ⛔ *"Cannot approve business scope or resolve source conflicts"*)* |
| **Purpose** | ⭐ Test whether the repository's **authorized human approval process** has actually been satisfied, and record every decision, its evidence and its true status |
| ⭐⭐ **VERDICT** | ⛔⛔ **DESIGN SYSTEM — PENDING HUMAN APPROVAL** |
| **Decisive ground** | ⭐ **1 of 8** mandatory approval acts is present, and ⛔ **7 are absent** — §2 |

---

## 1. Method

Every statement below is **measured** against the repository, with the instrument named.
⛔ Nothing is inferred from plausibility, seniority or convenience.

| Instrument | Use |
|---|---|
| `grep -rn` over `docs/` and `lib/` | Locating and counting authority statements |
| `md5sum` | Proving protected files unchanged |
| `flutter analyze` | Code baseline |
| Direct read of `DESIGN_GOVERNANCE.md` §2–§4, `DESIGN_OWNERSHIP.md` §3, `DESIGN_CHANGE_MANAGEMENT.md` §1 | The **authorized** approval process itself |

⭐ **The approval test was written from the repository's own rules before the evidence was
gathered**, so the conclusion could not be fitted to a desired outcome.

---

## 2. ⭐⭐ THE APPROVAL TEST — the decisive section

### 2.1 What the repository requires before "APPROVED" may be written

Assembled from `DESIGN_GOVERNANCE.md` §2/§3/§4, `DESIGN_OWNERSHIP.md` §3 and
`DESIGN_CHANGE_MANAGEMENT.md` §1 — ⛔ **not invented here**.

| # | Required act | Authority that must perform it | Present? | Evidence |
|---|---|---|---|---|
| **A** | Approve the direction and system as a whole | ⭐ **Founder/Product Authority** | ⚠️ **YES — with a defect** | `DDR-0009`; ⚠️ defect at §2.3 |
| **B** | Ratify colour + spacing tokens into `DESIGN_SYSTEM.md` §2; select the type family | **Design System Owner** | ⛔ **NO** | `DESIGN_SYSTEM.md` md5 `e5f97246` — **byte-unchanged**, still reads `TO BE DECIDED` at L21, L22 |
| **C** | Replace *"exact minimum values are TO BE DECIDED"* in `ACCESSIBILITY.md` §2 | **Accessibility Owner** | ⛔ **NO** | `ACCESSIBILITY.md` md5 `a43d2605` — byte-unchanged, L26 still `TO BE DECIDED` |
| **D** | Create the responsive artifact carrying 600/905dp | **Responsive Design Owner** | ⛔ **NO** | ⭐ **Measured: 0 occurrences of `600dp`, `905dp` or `breakpoint`** in `DESIGN_SYSTEM.md`, `VISUAL_LANGUAGE.md` or `ACCESSIBILITY.md`. `DBT-002` **OPEN** |
| **E** | Confirm the **official V1 device profile** | ⭐⭐ **Technical Owner** | ⛔⛔ **NO** | §2.2 — measured |
| **F** | Record gates `G0`–`G5` as passed | Gate approvers *(`DESIGN_GOVERNANCE.md` §4)* | ⛔ **NO** | ⭐ **0 of 6 recorded as passed** — `DESIGN_GOVERNANCE.md` L49–52, `DBT-008` |
| **G** | Resolve the **class D4 source conflict** | **Design System Owner** *(with Design Vision Owner)* | ⛔ **NO** | `DDR-0010` records it **open**; §4.1 shows it is **larger than recorded** |
| **H** | Record the change under `DESIGN_CHANGE_MANAGEMENT.md` §4 *(G5)* | **Design Governance Owner** | ⛔ **NO** | ⭐ **0** `G5` change records exist |

⭐⭐ **Score: 1 of 8 present — and that one carries an evidence defect.**

⛔⛔ **The Design System therefore MUST NOT be marked FINAL/APPROVED.** Writing
`APPROVED` now would be exactly the act `DESIGN_GOVERNANCE.md` L10 forbids:
*"AI authors and reviews; **AI is not final business authority**."*

### 2.2 ⭐⭐ Test E, measured in full — there is no Technical Owner act

The user instruction was explicit: *"Resolve D-6 **ONLY** from an authoritative Technical
Owner decision."* ⭐ **So the search had to fail before D-6 could stay open — and it did.**

| Probe | Result |
|---|---|
| `grep -rn "Technical Owner" docs/` | **16** hits |
| Of those, hits that are a **decision on the V1 device profile** | ⛔⛔ **ZERO** |
| What the 16 actually are | ⭐ **10** are the design records *asking* for the decision *(`DDR-0006`, closure pack, decision sheet)*; ⭐ **6** are `PRD_OWNERSHIP_MODEL` / `TS-00x` role definitions |
| `grep -rni "device profile\|API 26\|Android 8\|target device"` across `docs/` | ⛔ **No authoritative determination.** Every hit is either the design record's own **inference**, or an unrelated passage *(`DESIGN_QA.md` L35 *"low-end device behavior are considered"*, `Authentication_PRD_v2` L967 on Passkeys)* |
| `NFR Budgets (V1)` document | ⛔ **DOES NOT EXIST** — `ADR-0100` L185: *"There is **no** Enterprise Architecture NFR Budgets document"*; EA L339–344 is *"headings with zero values"* |

⭐⭐ **Conclusion: `DDR-0006` stays `PROPOSED — provisional target`.** ⛔ The inferred
profile is **not** promoted to fact. ⭐ **The office is constituted** — `PRD_OWNERSHIP_MODEL`
§2.2 L86 scopes the Technical Owner to *"Implementation, `IMPL-*` tasks, traceability…"* —
⛔ **but it has not acted.** An office existing is not an office deciding.

### 2.3 ⚠️ A defect in the one approval that *is* present

`DESIGN_OWNERSHIP.md` §3 sets the **approval-evidence rule**:

> *"An approval must name the artifact, **version**, decision status, approver role, date,
> and unresolved conditions."*

⭐ Measured against `DDR-0009`:

| Required element | Present? |
|---|---|
| Artifact | ⭐ **YES** — `LIBOORA_MASTER_DESIGN_SYSTEM.md` |
| ⭐⭐ **Version** | ⛔⛔ **NO — the version string `v0.1` is never named in `DDR-0009`** |
| Decision status | ⭐ YES — `APPROVED` |
| Approver role | ⭐ YES — Founder/Product Authority |
| Date | ⭐ YES — 2026-09-19 |
| Unresolved conditions | ⭐ YES — two named holes |

⚠️ **This is a real defect and it is disclosed rather than patched.** ⭐ The Master Design
System is **`v0.1`** (header L13) and will be amended by the owner acts B–E above; an
approval that does not bind to a version cannot later be shown to have covered, or not
covered, those amendments.

⛔ **It is NOT repaired here.** ⭐ Curing it is a **Founder/Product Authority** act — a
re-affirmation naming `v0.1` — or a **Design Governance Owner** act recording the
binding. ⛔ **The AI may not supply the missing element on the authority's behalf.**
Routed at §6 as **`FA-GAP-001`**.

---

## 3. Every decision checked — evidence and final status

⭐ **Reading key.** **DECIDED** = the authority has spoken. **EFFECTIVE** = the canonical
document actually carries the value. ⭐⭐ **The two are different, and the gap between
them is the whole finding of this audit.**

| # | Decision | Recorded in | Evidence *(measured)* | Decided? | ⭐ **Effective in canonical doc?** | Final status |
|---|---|---|---|---|---|---|
| **1** | Colour tokens — `accent-ink #92400E`, `text-muted #5F6585`, split border | `DDR-0001` | ⭐ Contrast computed, not eyeballed: `#92400E` → **7.09** on card / **6.68** on surface; `#5F6585` → **5.70 / 5.37**; `#7F87A6` → **3.34** *(WCAG 1.4.11 needs 3:1)* | ⭐ **YES** | ⛔ **NO** — `DESIGN_SYSTEM.md` `e5f97246` byte-unchanged | ⚠️ **APPROVED, NOT YET EFFECTIVE** |
| **2** | `#B45309` rejected for `accent-ink` | `DDR-0001` | ⭐ **Byte-identical to the existing `warning` token** — a semantic collision, barred by `DESIGN_GOVERNANCE.md` §3 rule 4 | ⭐ **YES** | ⭐ n/a *(a rejection)* | ⭐ **CLOSED** |
| **3** | Semantic tokens — no raw hex in a component | `DDR-0007` | ⭐ The enforceable limb of the dark-mode extensibility clause | ⭐ **YES** | ⛔ **NO** — no token layer exists in `DESIGN_SYSTEM.md` | ⚠️ **APPROVED, NOT YET EFFECTIVE** |
| **4** | ⭐⭐ Indic/Devanagari **required** in V1 | `DDR-0002` | ⭐ Human instruction, express: *"YES"*. `MP-CON-12` India-first | ⭐⭐ **YES** | ⛔ **NO** | ⭐ **APPROVED (requirement)** |
| **5** | ⭐⭐ The **type family** | ⛔ **none** | §4.2 — ⭐ **a new finding: the repo already ships `Roboto` and it fails the requirement** | ⛔⛔ **NO** | ⛔ **NO** | ⛔⛔ **TO BE DECIDED — Design System Owner** |
| **6** | Radius `sm 8 / md 12 / lg 16`; retire 14, 18 | `DDR-0003` | ⭐ `theme.dart` — **7** `BorderRadius.circular()` calls across **3** values (12/14/18); ⛔ **no `LiblRadius` class** | ⭐ **YES** | ⛔ **NO** — `DESIGN_SYSTEM.md` L23 still only *"Moderate, consistent radii"* | ⚠️ **APPROVED, NOT YET EFFECTIVE** |
| **7** | **≥48×48dp** touch targets, ≥8dp spacing | `DDR-0004` | ⭐ UI/UX Pro Max `15de38f`: *"48dp on Android"*; Liboora is Android-first. ⭐ Conflict with the skill's 36px data-dense row **resolved explicitly**: 48dp on touch, 36px only pointer-only ≥905dp | ⭐ **YES** | ⛔ **NO** — `ACCESSIBILITY.md` L26 `a43d2605` still *"TO BE DECIDED"* | ⚠️ **APPROVED, NOT YET EFFECTIVE** |
| **8** | 4.5:1 / 3:1 contrast · 2dp focus · 200% scale · **icon + text always** | `DDR-0004` | ⭐⭐ **Measured driver:** `success` and `warning` have **identical luminance (5.02 / 4.73)** — ⛔ so colour alone can never carry status | ⭐ **YES** | ⛔ **NO** | ⚠️ **APPROVED, NOT YET EFFECTIVE** |
| **9** | Breakpoints **<600 / 600–904 / ≥905 dp** | `DDR-0005` | ⭐ Material 3 window size classes — an external citable standard. ⛔ Skill's 375/768/1024/1440 **px** rejected as web-only | ⭐ **YES** | ⛔⛔ **NO — 0 occurrences** of `600dp`/`905dp`/`breakpoint` in any foundation doc. `DBT-002` **OPEN** | ⚠️ **APPROVED, NO ARTIFACT EXISTS** |
| **10** | V1 device profile | `DDR-0006` | ⭐⭐ §2.2 — **no Technical Owner act exists** | ⛔⛔ **NO** | ⛔ **NO** — `PERFORMANCE.md` L8 `363bc96c` still *"TO BE DECIDED"* | ⛔⛔ **PROVISIONAL TARGET ONLY** |
| **11** | Numeric performance SLOs | ⛔ **none** | ⭐ `NFR Budgets (V1)` **does not exist** *(`ADR-0100` L185)*; `DD7-GAP-009` **OPEN** | ⛔ **NO** | ⛔ **NO** | ⛔ **BLOCKED on #10** |
| **12** | **Dark mode excluded from V1**, architecture extensible | `DDR-0007` | ⭐ No source requires dark mode; extensibility made enforceable via the no-raw-hex rule | ⭐ **YES** | ⛔ **NO** — no foundation doc mentions dark mode | ⚠️ **APPROVED, NOT YET EFFECTIVE** |
| **13** | **"Calm Premium Study Space"** | `DDR-0010` | ⭐ Human instruction, express | ⭐ **YES** | ⛔ **NO** | ⭐ **APPROVED** |
| **14** | 2D-first / 2.5D personality / controlled 3D | `DDR-0010` | ⭐ Consistent with `VISUAL_LANGUAGE.md` §2's **CONFIRMED** exclusions | ⭐ **YES** *(in principle)* | ⚠️ **PARTLY** | ⚠️ **APPROVED — ⛔ ratios in CONFLICT, §4.1** |
| **15** | ⚠️⚠️ The layer **ratios** — ≤5% vs ~10% 3D | `DDR-0010` | ⭐⭐ §4.1 — ⭐ **a new finding: the conflict spans 3 documents and 2 layers, not 1 and 1** | ⛔ **NO** | ⛔ **NO** | ⛔⛔ **CONFLICT — class D4, OPEN** |
| **16** | **`C-4` removed from V1** | `DDR-0008` | ⭐⭐ **Condition tested, not assumed** — 4 probes: `CNF-FR-060` *emits*, does not read · `CNF-BR-006` is *"a subtraction"* · `CNF-AC-044` *"no second version history"* · ⭐ **grep for an audit-reading-surface requirement = ZERO** | ⭐ **YES** | ⛔ **NO** — `DD-0007` `db7beded` byte-unchanged; **L1036** still *"BLOCKED — `DD7-GAP-008`"*, **L1565** still *"3 of 5"* | ⚠️ **APPROVED, NOT YET EFFECTIVE** |
| **17** | AI Coach — **reserved space only**, renders nothing | `DDR-0011` | ⭐ `PRD_REGISTRY` L248: `PRD-011` is **`PLANNED`** ⇒ ⛔ no written requirements exist | ⭐ **YES** | ⛔ n/a *(no surface yet)* | ⭐ **APPROVED** |
| **18** | Adoption of the system as a whole | `DDR-0009` | ⚠️ §2.3 — ⛔ **version not named**, breaching `DESIGN_OWNERSHIP.md` §3 | ⚠️ **YES, defective** | ⛔ **NO** | ⚠️ **APPROVED WITH DEFECT — `FA-GAP-001`** |
| **19** | ⭐⭐ **Spacing tokens** *(`LiblSpace`, 6 steps)* | ⛔ **none** | ⭐ §4.3 — ⭐ **a new finding: `DBT-001` has two limbs and only the colour limb was decided** | ⛔ **NO** | ⛔ **NO** | ⛔ **TO BE DECIDED — Design System Owner** |
| **20** | Elevation tokens | ⛔ **none** | ⭐ `DBT-005`: *"Elevation and typography are in the same position: no token class exists for either"* | ⛔ **NO** | ⛔ **NO** | ⛔ **TO BE DECIDED** |

⭐ **Tally: 12 decided-and-effective-pending · 2 closed · 6 genuinely open.**
⛔⛔ **Decisions that are EFFECTIVE in a canonical document today: ZERO.**

---

## 4. ⭐⭐ Three findings this audit discovered — ⛔ none of them previously recorded

⭐ These were not in `DDR-0001`…`0011`, the closure pack or the decision sheet. ⭐ They
surfaced only because reconciliation was performed **document by document** rather than
by trusting the prior records.

### 4.1 ⭐⭐ FINDING 1 — the 3D conflict is **larger than `DDR-0010` recorded**

`DDR-0010` files the conflict as *"`DESIGN_SYSTEM.md` §2 states ~10% 3D; this record
states ≤5%"* — ⭐ **one document, one layer.** ⛔ **Measured, it is three documents and
two layers.**

| Source | 2D | Depth / 2.5D | 3D | Status in that document |
|---|---|---|---|---|
| `VISUAL_LANGUAGE.md` §1 | ~70% | ⭐ **~20%** | ⭐ **~10%** | **CONFIRMED direction** |
| `DESIGN_FOUNDATION.md` **L10** | ~70% | ⭐ **20%** | ⭐ **10%** | ⭐⭐ **CONFIRMED** — ⛔ **never cited by `DDR-0010`** |
| `DESIGN_SYSTEM.md` §2 | *(2D-first)* | — | ⭐ **~10%** | **CONFIRMED** |
| `LIBOORA_MASTER_DESIGN_SYSTEM.md` L105 | — | — | ~10% | INHERITED |
| ⭐ **`DDR-0010`** | 70% | ⭐⭐ **25%** | ⭐⭐ **≤5%** | **APPROVED** |

⭐ **Both sets sum to 100** — `70 + 20 + 10` and `70 + 25 + 5`. ⭐⭐ **So the 5 points did
not vanish; they moved from the 3D layer into the depth layer.** `DDR-0010` recorded the
3D limb and ⛔ **is silent on the depth limb** — measured: **0** occurrences of `20%` in
the entire DDR file.

⚠️ **Two consequences, stated plainly:**

1. ⛔ **`DESIGN_FOUNDATION.md` L10 was never cited as a conflicting source.** ⭐ Measured:
   `grep -c "DESIGN_FOUNDATION"` in the DDR file returns **0**. A reconciler working only
   from `DDR-0010` would amend `DESIGN_SYSTEM.md` and `VISUAL_LANGUAGE.md` and ⛔ **leave
   `DESIGN_FOUNDATION.md` stating the superseded figure** — ⭐ in the very document that is
   *"the entry point for LIBOORA design work"* (§1).
2. ⚠️ **The "≤5% is stricter, so working to it breaches neither" containment observation
   does NOT extend to the depth limb.** ⭐ 25% depth is **more** than 20%, ⛔ not less. ⭐ The
   containment argument holds for 3D and **fails for 2.5D** — so it cannot be used to
   justify proceeding on the ratios as a whole.

⛔⛔ **Not resolved here.** ⭐ `DESIGN_GOVERNANCE.md` §3 rule 4: *"A CONFLICT is not closed
by choosing the more convenient design."* ⭐ **Both values preserved, neither overwritten**,
exactly as instructed. ⭐ **Owner: Design System Owner** *(with Design Vision Owner and
Design Documentation Owner for L10)*. ⭐ Recorded as **`FA-GAP-002`**.

### 4.2 ⭐⭐ FINDING 2 — the product **already ships a typeface**, and it fails the approved requirement

⭐ The instruction required: *"Resolve the exact typeface decision. It MUST support the
approved Indic/Devanagari name-rendering requirement."* ⭐ Resolving it required first
measuring what is actually there — ⭐ **and what is there was not in any design record.**

| Probe | Result |
|---|---|
| `grep -rn "fontFamily" lib/` | ⭐⭐ **`lib/app/shared/theme.dart:49` — `fontFamily: 'Roboto'`** *(plus one `'monospace'` in `ops_page.dart`)* |
| `Roboto` in `docs/design/` | ⛔⛔ **ZERO occurrences** |
| `Roboto` anywhere in `docs/` | ⭐ **1** — `DD-0004` L2520, an **as-built observation**: *"Font family \| `Roboto`, Material 3 \| `buildLiblTheme()`"* |
| Font assets in the repo *(`.ttf` / `.otf`)* | ⭐⭐ **ZERO** |
| `fonts:` declared in `pubspec.yaml` | ⛔ **None** — the block is entirely commented out |
| `fontFamilyFallback` | ⛔ **0 occurrences** |

⭐⭐ **What this means, precisely.** `'Roboto'` is declared with **no bundled asset and no
fallback**, so glyph resolution falls to the host platform. ⚠️ On Android the system
*typically* resolves Devanagari via its own font stack — ⭐ **but "typically" is not a
design guarantee**, and `DDR-0002`'s approved requirement is that *"the font strategy
**MUST guarantee** proper Indic rendering."* ⛔ **A platform fallback nobody specified,
bundled or tested is not a guarantee.**

⚠️⚠️ **The exact failure mode `DDR-0002` was written to prevent — a student seeing their
own name as `□□□` — is presently un-prevented by anything in the repository.**

⛔⛔ **This audit does NOT select the family.** ⭐ Three reasons, each sufficient:
`DESIGN_DEBT.md` rule 5 *(a row is never closed by editing the document it indicts)*;
`DESIGN_GOVERNANCE.md` L10 *(AI is not final business authority)*; and ⭐ **`DDR-0002`
expressly reserved it** — *"the final family is NOT selected here."* ⛔ Nor is `Roboto`
ratified by being observed. ⭐ **Owner: Design System Owner.** Recorded as **`FA-GAP-003`**.

⭐ **What the owner now has that they did not have before:** the shortlist *(`DDR-0002`)*,
the requirement *(approved)*, **and the measured fact that the current state is an
undeclared platform dependency** — ⭐ which is a materially different starting point from
"no typeface chosen."

### 4.3 ⭐ FINDING 3 — `DBT-001` has **two** limbs and only one was decided

⭐ `DBT-001` indicts **two** token families, not one:

> *"`LiblColors` with **12** colour constants … **and `LiblSpace` with 6 steps**
> (`xs 4`, `sm 8`, `md 12`, `lg 16`, `xl 24`, `xxl 32`)"*

| Limb | Decided? | Evidence |
|---|---|---|
| Colour | ⭐ **YES** — `DDR-0001` | 12 tokens dispositioned |
| ⭐⭐ **Spacing** | ⛔⛔ **NO** | ⭐ Measured: the DDR file's **only** occurrence of *"spacing"* is `DDR-0004`'s **≥8dp target spacing** — ⛔ an **accessibility minimum**, ⛔ **not a spacing token scale**. `LiblSpace` appears **0** times |

⚠️⚠️ **Therefore `DBT-001` CANNOT be closed**, even after the Design System Owner
ratifies the colours. ⭐ Anyone reading *"`DDR-0001` — Colour tokens — APPROVED"* and
closing `DBT-001` would close a **half-satisfied** row.

⭐ **Same position for `DBT-005`:** `DDR-0003` decides **radius**, but the row also
indicts **elevation and typography** — *"no token class exists for either."* ⛔ `DBT-005`
is likewise **not closable** on `DDR-0003` alone.

⭐ **Owner: Design System Owner.** Recorded as **`FA-GAP-004`**.

---

## 5. Contradiction matrix — the seven documents cross-checked

⭐ Each row is a measured disagreement between a **decided** value and what a document
**actually says today**. ⛔ **None is repaired by this audit.**

| # | Document | What it says now | What the DDR decided | Class | Owner |
|---|---|---|---|---|---|
| **X-1** | `DESIGN_SYSTEM.md` L21 | *"Exact family and licensed source are **TO BE DECIDED**"* | `DDR-0002` — Indic support **required**; ⛔ family still open | ⭐ **NOT a contradiction** — ⭐ correctly still open | Design System Owner |
| **X-2** | `DESIGN_SYSTEM.md` L22 | Spacing *"**TO BE DECIDED** in Figma after visual review"* | ⛔ **Nothing** — §4.3 | ⭐ **NOT a contradiction** — ⭐ genuinely undecided | Design System Owner |
| **X-3** | `DESIGN_SYSTEM.md` §2 Colour | `RECOMMENDED`, no values | `DDR-0001` — **5 token decisions** | ⚠️ **STALE** | Design System Owner |
| **X-4** | `DESIGN_SYSTEM.md` L23 Radius | *"Moderate, consistent radii"* | `DDR-0003` — **8 / 12 / 16**, retire 14 & 18 | ⚠️ **STALE** | Design System Owner |
| **X-5** | `DESIGN_SYSTEM.md` §2 Illustration | ⭐ **~10% 3D, CONFIRMED** | `DDR-0010` — **≤5%** | ⛔⛔ **CONFLICT — D4** | Design System Owner |
| **X-6** | ⭐ `DESIGN_FOUNDATION.md` **L10** | ⭐ **70 / 20 / 10, CONFIRMED** | `DDR-0010` — **70 / 25 / ≤5** | ⛔⛔ **CONFLICT — D4, ⭐ newly found (§4.1)** | Design System Owner + Design Documentation Owner |
| **X-7** | `VISUAL_LANGUAGE.md` §1 | ⭐ **70 / 20 / 10, CONFIRMED** | `DDR-0010` — **70 / 25 / ≤5** | ⛔⛔ **CONFLICT — D4** | UI/Visual Design Owner |
| **X-8** | `VISUAL_LANGUAGE.md` §3, §4 | Palette and family *"**TO BE DECIDED**"* | `DDR-0001` decided palette; ⛔ family open | ⚠️ **PARTLY STALE** | UI/Visual Design Owner |
| **X-9** | `ACCESSIBILITY.md` L26 | *"exact minimum values are **TO BE DECIDED**"* | `DDR-0004` — **≥48dp, ≥8dp** | ⚠️ **STALE** | Accessibility Owner |
| **X-10** | `ACCESSIBILITY.md` L10 | Target *"**TO BE DECIDED**"* | `DDR-0004` — **WCAG 2.1 AA ratios adopted** | ⚠️ **STALE** | Accessibility Owner |
| **X-11** | `ACCESSIBILITY.md` §3 | Languages *"**TO BE DECIDED**"* | ⭐ **Correctly still open** — `DDR-0002` decided **script rendering**, ⛔ not UI localization | ⭐ **NOT a contradiction** | Product Owner |
| **X-12** | `PERFORMANCE.md` L8, §5 | Budgets *"**TO BE DECIDED**"* | ⛔ **Nothing** — `DDR-0006` is provisional | ⭐ **NOT a contradiction** | Technical Owner → Design Performance Owner |
| **X-13** | `PERFORMANCE.md` §2 | *"Avoid … heavy 3D, WebGL"* | `DDR-0010` — 4 permitted 3D moments with 2D fallbacks | ⭐ **CONSISTENT** — ⭐ *"heavy"* ≠ *"≤5% with fallback"* | — |
| **X-14** | `DESIGN_DEBT.md` `DBT-001` | **OPEN** | ⭐ Colour limb decided; ⛔ **spacing limb not** | ⚠️ **PARTIALLY DISCHARGED — ⛔ NOT closable** | Design System Owner |
| **X-15** | `DESIGN_DEBT.md` `DBT-002` | **OPEN** | `DDR-0005` decided the values | ⚠️ **DECIDED, ⛔ artifact still absent** | Responsive Design Owner |
| **X-16** | `DESIGN_DEBT.md` `DBT-005` | **OPEN** | ⭐ Radius decided; ⛔ **elevation + typography not** | ⚠️ **PARTIALLY DISCHARGED — ⛔ NOT closable** | Design System Owner |
| **X-17** | `DESIGN_DEBT.md` `DBT-008` | *"**0** design decisions … `APPROVED`"* | ⭐ **11 DDRs now exist, 9 APPROVED** | ⚠️⚠️ **FACTUALLY STALE** — ⭐ but ⛔ **not closable**: gates `G0`–`G5` remain **0 of 6** | Founder/Product Authority |
| **X-18** | `DD-0007` **L1036** | `C-4` *"**BLOCKED** — `DD7-GAP-008`"* | `DDR-0008` — **`C-4` REMOVED from V1** | ⚠️ **STALE** | UX Architecture Owner |
| **X-19** | `DD-0007` **L1565** | *"Surfaces specified: **3 of 5**"* | ⭐ With `C-4` removed the denominator changes | ⚠️ **STALE** | UX Architecture Owner |
| **X-20** | `DD-0007` header | *"COVERAGE UNCHANGED AT **79 / 104**"* | ⭐ `ADR-0162` authorized 6 ⇒ **85 / 104** | ⚠️ **STALE** — ⭐ update path prescribed at `ADR-0163` §4.4 | UX Architecture Owner |
| **X-21** | `MASTER_DESIGN_SYSTEM` L148–149 | `accent-ink`, `text-muted` *"**TO BE DECIDED**"* | `DDR-0001` decided both | ⚠️ **STALE** | Design System Owner |
| **X-22** | `MASTER_DESIGN_SYSTEM` L170 | *"Dark mode: **TO BE DECIDED**"* | `DDR-0007` — **out of V1** | ⚠️ **STALE** | Design Vision Owner |
| **X-23** | `MASTER_DESIGN_SYSTEM` §24 #8 | *"`C-4` change-history **reader**"* open | `DDR-0008` — ⭐ **surface removed, so no reader is needed** | ⚠️ **STALE** | UX Architecture Owner |
| **X-24** | `DESIGN_GOVERNANCE.md` L49–52 | *"**0** of gates `G0`–`G5` … passed"* | ⛔ **Still true** | ⭐ **ACCURATE** | Design Governance Owner |
| **X-25** | `design-decisions/README.md` §3 | *"**No** design decision has been marked APPROVED"* | ⭐ **11 DDRs now exist** | ⚠️ **FACTUALLY STALE** | Design Documentation Owner |
| **X-26** | ⭐ `theme.dart:49` vs `DDR-0002` | ⭐ **`fontFamily: 'Roboto'`**, no asset, no fallback | *"MUST **guarantee** proper Indic rendering"* | ⛔⛔ **UNSATISFIED REQUIREMENT — ⭐ newly found (§4.2)** | Design System Owner → Technical Owner |

⭐ **Totals: 26 rows — ⛔ 3 CONFLICT (D4) · ⚠️ 14 STALE · ⚠️ 3 partially discharged ·
⭐ 5 correctly open · ⭐ 1 accurate.**

⭐⭐ **Read the pattern, not just the rows.** ⛔ **14 stale rows is not 14 defects — it is
one defect with 14 symptoms:** ⭐ the decisions were **recorded** but the canonical
documents have not been **amended**, because amendment is each owner's act and ⛔ **no
owner has acted yet.** ⭐ That is exactly what `DESIGN_DEBT.md` rule 5 requires, ⛔ and it
is exactly why the system cannot be called FINAL.

---

## 6. Remaining blockers — with the **exact** owner for each

⭐ **`FA-GAP-*` is a new register local to this audit.** ⛔ It allocates no authority,
creates no role and closes nothing. ⭐ Each row names an **existing** office.

### 6.1 Blockers inside design authority

| ID | Blocker | ⭐ **Exact owner** | Blocks | Status |
|---|---|---|---|---|
| **`FA-GAP-001`** | ⚠️ `DDR-0009` approval ⛔ **does not name the artifact version**, breaching `DESIGN_OWNERSHIP.md` §3 | ⭐ **Founder/Product Authority** *(re-affirm naming `v0.1`)*, or **Design Governance Owner** *(record the binding)* | ⭐ The integrity of every downstream approval | ⛔ **OPEN** |
| **`FA-GAP-002`** | ⛔⛔ Layer-ratio **CONFLICT** across **3 documents, 2 layers** *(§4.1)* | ⭐ **Design System Owner**, with **Design Vision Owner**; ⭐ **Design Documentation Owner** for `DESIGN_FOUNDATION.md` L10 | ⭐ Any 2.5D/3D specification | ⛔ **OPEN — class D4** |
| **`FA-GAP-003`** | ⛔⛔ **Type family unselected**, while `Roboto` ships with no asset or fallback *(§4.2)* | ⭐ **Design System Owner** *(selection + licence)* → **Technical Owner** *(bundling/subsetting)* | ⭐⭐ **`DDR-0002`'s approved Indic guarantee**; all typography | ⛔ **OPEN** |
| **`FA-GAP-004`** | ⚠️ `DBT-001` **spacing** limb and `DBT-005` **elevation + typography** limbs undecided *(§4.3)* | ⭐ **Design System Owner** | ⭐ Closure of `DBT-001` and `DBT-005` | ⛔ **OPEN** |
| **`FA-GAP-005`** | ⛔ **8 canonical documents still carry superseded or `TO BE DECIDED` text** *(the 14 STALE rows, §5)* | ⭐ Per row — see the matrix's Owner column | ⭐ Figma execution; any implementation | ⛔ **OPEN** |
| **`FA-GAP-006`** | ⛔⛔ **Gates `G0`–`G5`: 0 of 6 recorded as passed** | ⭐ `G0` Design Documentation Owner · `G1` UX Architecture Owner · `G2` **Design System + Accessibility Owner** · `G3` Design–Engineering Handoff Owner · `G4` Design QA Owner · `G5` Design Governance Owner | ⭐⭐ **`DBT-008`; the FINAL/APPROVED status itself** | ⛔ **OPEN** |
| **`FA-GAP-007`** | ⛔ **Responsive artifact does not exist** — `600dp`/`905dp` measure **0** occurrences | ⭐ **Responsive Design Owner** | ⭐ `DBT-002`; `G3` handoff | ⛔ **OPEN** |
| **`FA-GAP-008`** | ⚠️ `DD-0007` not updated for `C-4` removal, nor for **79 → 85** | ⭐ **UX Architecture Owner** *(path prescribed at `ADR-0163` §4.4)* | ⭐ `DD-0007` design-readiness | ⛔ **OPEN** |

### 6.2 Blockers **outside** design authority — ⛔ design cannot clear these

| ID | Blocker | ⭐ **Exact owner** | Why design cannot act |
|---|---|---|---|
| **`FA-GAP-009`** | ⭐⭐ **Official V1 device profile unconfirmed** | ⭐⭐ **Technical Owner** | ⭐ `DESIGN_OWNERSHIP.md` §1: the Design Performance Owner *"**Cannot** set backend SLOs or claim measured performance"* |
| **`FA-GAP-010`** | ⛔ **`NFR Budgets (V1)` does not exist** | ⭐ **Governance Owner + Design Performance Owner** | ⛔ Gated on `FA-GAP-009`; `DD7-GAP-009` |
| **`FA-GAP-011`** | ⛔ **Supported UI languages undecided**; `flutter_localizations` measures **0** | ⭐ **Product Owner** *(scope)* → **Technical Owner** *(i18n stack)* | ⛔ A product-scope question — `DBT-003` |
| **`FA-GAP-012`** | ⛔ **`PRD-011` (AI Coach) is `PLANNED`** | ⭐ **Product Owner** | ⛔ `DDR-0011` reserves space only; ⛔ designing behaviour would invent requirements |
| **`FA-GAP-013`** | ⚠️ **19 `BC-25` parameters still held**; `DD-0007` **not design-ready** | ⭐ Per `DP-0004` — Product Owner, Architecture Owner, Authorization Owner; ⭐ **`B-6` needs external Indian legal counsel** | ⛔ Outside design entirely |

⭐⭐ **13 blockers — 8 inside design authority, 5 outside it.** ⛔ **Zero are dischargeable
by this audit or by any AI act.**

---

## 7. Remaining design debt

| ID | Status now | ⭐ Effect of the recorded decisions | Closable today? |
|---|---|---|---|
| `DBT-001` | ⛔ **OPEN** | ⭐ Colour limb **decided** *(`DDR-0001`)*; ⛔ **spacing limb untouched** | ⛔⛔ **NO** — §4.3 |
| `DBT-002` | ⛔ **OPEN** | ⭐ Values **decided** *(`DDR-0005`)*; ⛔ **artifact absent** | ⛔ **NO** — needs the artifact |
| `DBT-003` | ⛔ **OPEN** | ⭐ **Script rendering** required *(`DDR-0002`)*; ⛔ **UI localization untouched** | ⛔ **NO** |
| `DBT-004` | ⛔ **OPEN** | ⛔ Unaffected — ⭐ **1** `testWidgets` assertion in the repository | ⛔ **NO** |
| `DBT-005` | ⛔ **OPEN** | ⭐ Radius **decided** *(`DDR-0003`)*; ⛔ **elevation + typography untouched** | ⛔⛔ **NO** — §4.3 |
| `DBT-006` | ⛔ **OPEN** | ⛔ Unaffected — ⭐ a **product-scope** question | ⛔ **NO** |
| `DBT-007` | ⚠️ **ACCEPTED, DOCUMENTED** | ⛔ Unaffected | ⭐ n/a |
| `DBT-008` | ⛔ **OPEN** | ⚠️ **Its wording is now factually stale** — ⭐ **11** DDRs exist, **9** APPROVED | ⛔⛔ **NO** — ⭐ its second limb, *"gates `G0`–`G5` … none recorded as passed"*, **remains true at 0 of 6** |

⭐ **Debt: 8 rows — 7 OPEN, 1 accepted, ⛔ 0 closed. ⭐ Net movement this cycle: 0 closed,
4 partially discharged.**

⚠️⚠️ **On `DBT-008` specifically.** ⭐ It is tempting to close it — *"decisions are now
approved"*. ⛔ **That would be wrong.** The row has **two** limbs joined by *"and"*, and
⭐ **the gate limb is still measurably unmet.** ⭐ Its own review trigger is *"A design
approval act"* — ⭐ **that trigger has fired**, so the row is now **due for review by the
Founder/Product Authority**. ⛔ **Due for review is not closed**, and ⛔ **reviewing it is
not this audit's act** *(`DESIGN_DEBT.md` rule 5)*.

### 7.1 ⭐ New debt this audit measured

| Proposed row | Finding | Owner |
|---|---|---|
| ⭐ **`FA-GAP-003`** *(candidate `DBT-009`)* | ⭐⭐ **`theme.dart` declares `fontFamily: 'Roboto'` with 0 bundled font assets, 0 `fontFamilyFallback` and 0 mentions in `docs/design/`** — an undeclared platform dependency carrying an **approved** Indic requirement | **Design System Owner** |

⛔⛔ **This row is NOT written into `DESIGN_DEBT.md`.** ⭐ That register's owner is the
**Design Governance Owner** and rule 5 bars this document from editing it. ⭐ It is
**proposed here with its measurement attached**, ready for that office to file.

---

## 8. Consistency audit — protected artifacts verified unchanged

| Artifact | md5 | Verdict |
|---|---|---|
| `docs/design/DESIGN_SYSTEM.md` | `e5f972464ae0a70e10cef72e00642b0e` | ⭐ **UNCHANGED** |
| `docs/design/ACCESSIBILITY.md` | `a43d2605755248f35adb2ba2d1f0753f` | ⭐ **UNCHANGED** |
| `docs/design/PERFORMANCE.md` | `363bc96cacec0504c0d87414215e1af3` | ⭐ **UNCHANGED** |
| `docs/design/DESIGN_DEBT.md` | `ba9bbb0fbeac7f022bb51c2fbbf7bb12` | ⭐ **UNCHANGED** |
| `docs/design/VISUAL_LANGUAGE.md` | `2a7925d0363f62b02f3e41d0d03d7ce2` | ⭐ **UNCHANGED** |
| `docs/35-design/configuration/DD-0007-…md` | `db7beded63de7db918287c639ee3ad8b` | ⭐ **UNCHANGED** |
| `lib/app/shared/theme.dart` | `abfe98ad82a768029ca13576f6da9810` | ⭐ **UNCHANGED** |

| Check | Result |
|---|---|
| `flutter analyze` | ⭐ **No issues found!** |
| Files changed by this audit | ⭐ **1** — this file, **newly created** |
| PRDs / ADRs / roles / permissions / `PERM-*` altered | ⛔ **0** |
| Application code altered | ⛔ **0** |
| Figma artifacts created | ⛔ **0** |
| Commit / push | ⛔ **NONE** |

---

## 9. ⛔⛔ Final determination

⭐ The instruction set the rule: *"Do **NOT** claim APPROVED merely because the AI
considers the design good."* ⭐ Applying the repository's own test:

| Question | Answer |
|---|---|
| Is the **design work** complete and evidence-backed? | ⭐ **Substantially yes** |
| Has the **Founder/Product Authority** decided the product direction? | ⭐ **Yes** — `DDR-0001`…`0011` |
| ⭐⭐ Has the repository's **authorized human approval process** been **satisfied**? | ⛔⛔ **NO — 1 of 8 acts present, and that one is defective** |
| May the Design System be marked **FINAL/APPROVED**? | ⛔⛔ **NO** |

⭐⭐ **The distinction that decides this audit: the Founder/Product Authority approved the
DECISIONS; the owning offices have not yet APPROVED THE DOCUMENTS.** ⭐ `DESIGN_DEBT.md`
rule 5 and `DESIGN_OWNERSHIP.md` §1 make those separate acts by separate offices — ⛔ and
an AI may perform neither.

⛔⛔ **No approval is fabricated. No conflict is silently resolved. No status is inflated.**

---

## 10. ⛔ What this audit does **not** do

⛔ **0** approvals granted, inferred or implied · ⛔ **0** conflicts resolved · ⛔ **0**
canonical documents amended · ⛔ **0** debt rows closed · ⛔ **0** PRDs, ADRs, roles,
permissions, `PERM-*`, scopes or app boundaries touched · ⛔ **0** requirements invented ·
⛔ **0** lines of application code · ⛔ **0** Figma artifacts · ⛔ no commit, no push.

⭐⭐ **The amendments that follow from the recorded decisions are their owners' acts,
⛔ not this audit's** — `DESIGN_DEBT.md` rule 5.

---

# ⛔⛔ DESIGN SYSTEM — PENDING HUMAN APPROVAL
