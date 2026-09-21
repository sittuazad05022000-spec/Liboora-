<!-- LIBOORA Design Documentation | Design Authority Closure Pack | 2026-09-19 -->

> This document is **design governance and documentation**. ⛔ It does **not** amend product
> requirements, architecture decisions, bounded-context ownership, permissions, roles, app
> boundaries or backend contracts. ⛔ It **decides nothing** and **approves nothing**.
> Where it disagrees with any ranked LIBOORA document, **the ranked document wins.**

# LIBOORA Design Authority — Closure Pack

| Field | Value |
|---|---|
| **Document** | `LIBOORA_DESIGN_AUTHORITY_CLOSURE_PACK.md` |
| **Version** | **v1.0** |
| **Status** | ⚠️ **DECISION PACKAGE SET** — ⛔ not an approval instrument |
| **Rank** | ⛔ **UNRANKED** |
| **Author** | AI, as **Design Documentation Author** *(`DESIGN_GOVERNANCE.md` §5 — ⛔ *"Cannot approve business scope or resolve source conflicts"*)* |
| **Source** | [`LIBOORA_DESIGN_APPROVAL_ACTION_PLAN.md`](LIBOORA_DESIGN_APPROVAL_ACTION_PLAN.md) · [`LIBOORA_DESIGN_SYSTEM_FINAL_AUDIT.md`](LIBOORA_DESIGN_SYSTEM_FINAL_AUDIT.md) · [`DDR-0001…0011`](design-decisions/DDR-0001-to-0009-founder-product-authority-decisions.md) |
| **Contains** | ⭐ **11 decision packages** — `CP-A` … `CP-K`, each sized to be **decided in one sitting** |
| ⭐⭐ **Execution result** | ⭐ **0 decisions taken.** ⚠️ ⭐ **11 packages prepared.** ⭐⭐ **1 new measured fact surfaced** *(`CP-A` §A.4)* |
| ⛔ **Design System status** | ⛔⛔ **NOT APPROVED** — §13 |

---

## 1. What "execute the plan" could and could not mean

⭐ The instruction was to **execute** the action plan. ⭐ I tested each of its 14 blockers
against the question: ⭐ *"is there an act here that is lawfully mine?"*

| Category | Count | ⭐ What I did |
|---|---|---|
| ⛔ Requires a **named human office** to decide | **13** | ⭐ Built the smallest sufficient **decision package** |
| ⚠️ Requires **evidence that does not exist** | **3** *(overlapping)* | ⭐ Named the **exact** missing evidence and who can produce it |
| ⭐ Lawfully mine to perform | ⛔⛔ **ZERO** | ⛔ **Nothing recorded, ratified or closed** |

⭐⭐ **Task F was the only genuinely live question** — *"Record `G0` only if its authorized
process permits it."* ⭐ I tested it properly and **it does not.** See §9.

---

## 2. ⭐ `CP-A` — Technical Owner: V1 device profile *(PRIORITY A)*

| # | Field | Content |
|---|---|---|
| **1** | **Owner** | ⭐⭐ **Technical Owner** — constituted at `PRD_OWNERSHIP_MODEL.md` §2.2 **L86**. ⛔ **Not** the Design Performance Owner, who *"**Cannot** set backend SLOs or claim measured performance"* *(`DESIGN_OWNERSHIP.md` §1)* |
| **2** | **Decision required** | ⭐ State the **official V1 target device profile**: **(a)** minimum Android API level · **(b)** reference RAM + screen class · **(c)** network assumption |
| **3** | **Evidence** | ⭐ **Directional, CONFIRMED:** `MP-CON-12` — *"India-first … a **network-unreliable operating environment**"* · `PERFORMANCE.md` **L10** — *"low-end Android, low/intermittent network, mobile-first"* · `DESIGN_FOUNDATION.md` §4 — *"Low-end respect"*. ⭐⭐ **Plus one measured as-built fact — see §A.4** |
| **4** | **Options** | ⭐ **(i) Ratify the as-built floor** *(API 24)* · ⭐ **(ii) Raise the floor** *(e.g. API 26, matching the design inference)* · ⭐ **(iii) State a different profile entirely.** ⛔ **This pack expresses no preference** |
| **5** | **Consequences** | ⭐ A **weaker** confirmed profile ⇒ the ≤5% 3D budget **must shrink** *(`DDR-0006`)* and font **bundling** becomes costlier · ⭐ A **stronger** profile ⇒ budget may grow · ⛔ **No profile ⇒ `NFR Budgets (V1)` cannot be written and no numeric SLO may be published** |
| **6** | **Approval record location** | ⭐ An authorized **Technical Owner** record; ⭐ then `PERFORMANCE.md` **L10** *(Design Performance Owner)*; ⭐ then a **new** `NFR Budgets (V1)` |
| **7** | **Status** | ⚠️ **EVIDENCE REQUIRED** |
| **8** | **Dependency** | ⛔ **None inbound.** ⭐⭐ **Blocks `CP-E` entirely and `CP-B` partially. Longest lead time — request first** |

### ⭐⭐ A.4 — A measured fact the Technical Owner does not yet have

⭐ Preparing this package required measuring what the build **actually** permits today.
⭐ The result was not in any prior record:

| Probe | Result |
|---|---|
| `android/app/build.gradle.kts:27` | `minSdk = flutter.minSdkVersion` — ⛔ **no project override** |
| `flutter_tools/lib/src/android/gradle_utils.dart:55` *(Flutter 3.35.4)* | ⭐ `const minSdkVersion = '24'` |
| ⭐ **As-built floor** | ⭐⭐ **API 24 — Android 7.0** |
| ⚠️ Design's **inferred** profile | **API 26 — Android 8.0** |

⚠️⚠️ **The inference was STRICTER than the build permits.** ⭐ The app can currently be
installed on **Android 7.0**, a class the design work never considered. ⭐ Two live
consequences: ⭐ **(1)** any budget validated against API 26 is **unvalidated** for the
devices the build actually admits; ⭐ **(2)** the Android platform font stack differs
between 7.0 and 8.0 — ⭐⭐ **which directly conditions the Devanagari probe in `CP-B1`.**

⛔⛔ **This is a FACT, not a decision.** ⛔ It does **not** set the profile, and ⛔ **API 24
is not proposed as the answer** — ⭐ an unreviewed framework default is exactly the kind of
engineering default `DESIGN_DEBT.md` rule 5 forbids promoting to authority. ⭐ It is
surfaced so the Technical Owner decides against **measured reality** rather than against
an unexamined assumption.

---

## 3. ⭐ `CP-B1` — Design System Owner: Typography *(PRIORITY B)*

| # | Field | Content |
|---|---|---|
| **1** | **Owner** | ⭐ **Design System Owner** *(selection + licence)* → **Technical Owner** *(bundling/fallback)*; ⭐ **Design Governance Owner** *(licence review, per `DDR-0002`)* |
| **2** | **Decision required** | ⭐ **(a)** Select the family; ⭐ **(b)** ⭐⭐ **close the gap between `DDR-0002`'s APPROVED guarantee and what ships** |
| **3** | **Evidence** | ⭐ **Requirement APPROVED** — `DDR-0002`: *"V1 **MUST** support Indic/Devanagari student names… the font strategy **MUST guarantee** proper Indic rendering."* ⭐ **As-built measured:** `theme.dart:49` = `fontFamily: 'Roboto'` · **0** bundled `.ttf`/`.otf` · **0** `fontFamilyFallback` · **0** mentions in `docs/design/` · the `pubspec.yaml` `fonts:` block is **entirely commented out** |
| **4** | **Options** *(⭐ carried verbatim from `DDR-0002` — ⛔ none added, none preferred)* | ⭐ **Noto Sans + Noto Sans Devanagari** *(SIL OFL — the only candidate satisfying the pairing criterion **by construction**)* · ⚠️ **Inter + a separate Devanagari companion** — ⭐ permitted **only** if x-height and weight are **verified** to match · ⚠️ **Lexend** — ⛔ Devanagari coverage **unverified** · ⛔ **Inter alone — DISQUALIFIED** *(no Devanagari)* |
| **5** | **Consequences** | ⭐ **Bundling** guarantees rendering but costs app size on low-end Android — ⭐ mitigable by **subsetting**; ⚠️ the acceptable size is governed by **`CP-A`** · ⭐ **Declaring a fallback chain** costs almost nothing but ⛔ **guarantees less** · ⭐ Numeral disambiguation *(`0/O`, `1/l/I`)* remains a selection criterion for seat and enrollment numbers |
| **6** | **Approval record location** | ⭐ **New `DDR-0012`** *(`design-decisions/README.md` §4 — ⭐ verified free: **0** repo-wide occurrences)*; ⭐ then `DESIGN_SYSTEM.md` **L21**, `VISUAL_LANGUAGE.md` §4, `MASTER` L181 |
| **7** | **Status** | ⚠️ **EVIDENCE REQUIRED** — ⭐ **one probe away** |
| **8** | **Dependency** | ⚠️ **Partially on `CP-A`** — ⭐ the **family** can be chosen now; ⛔ the **bundle-vs-fallback** decision needs the device profile |

⚠️⚠️ **The one missing probe, stated exactly:** ⭐ *does the confirmed V1 Android platform
font stack render Devanagari reliably on the target device class?* ⭐ It *usually* does —
⛔ but *"usually"* is not the **"guarantee"** `DDR-0002` requires. ⭐⭐ **`CP-A` §A.4 makes
this sharper:** the answer may differ between **Android 7.0** and **8.0**, and the build
currently admits **7.0**.

⛔⛔ **No font is selected here.** ⭐ Three independent bars: `DDR-0002` expressly reserved
it; `DESIGN_DEBT.md` rule 5; `DESIGN_GOVERNANCE.md` L10. ⛔ **Nor is `Roboto` ratified by
having been observed.**

---

## 4. ⭐ `CP-B2` — Design System Owner: 3D **and depth** ratio conflict

| # | Field | Content |
|---|---|---|
| **1** | **Owner** | ⭐ **Design System Owner**, with **Design Vision Owner**; ⭐ **Design Documentation Owner** for `DESIGN_FOUNDATION.md` L10 |
| **2** | **Decision required** | ⭐⭐ Establish the canonical layer triple — ⚠️ **addressing BOTH limbs** |
| **3** | **Evidence** | ⭐ **Complete — no further measurement needed.** See the table below |
| **4** | **Options** | ⭐ **(i)** Adopt `70/25/≤5` and amend all four documents · ⭐ **(ii)** Retain `70/20/10` and amend `DDR-0010` · ⭐ **(iii)** A third reconciled triple. ⛔⛔ **This pack expresses NO preference** *(`DESIGN_GOVERNANCE.md` §3 rule 4)* |
| **5** | **Consequences** | ⭐ Governs every 2.5D and 3D surface, the four permitted 3D moments, and the asset pipeline · ⚠️ The ≤5% figure is presently validated only against `DDR-0006`'s **provisional** target |
| **6** | **Approval record location** | ⭐ **New `DDR-0013`**; ⭐ then **4 documents** — `VISUAL_LANGUAGE.md` §1 · `DESIGN_FOUNDATION.md` **L10** · `DESIGN_SYSTEM.md` §2 · `MASTER` L105 |
| **7** | **Status** | ⭐ **HUMAN ACTION REQUIRED** — ⭐ **READY** |
| **8** | **Dependency** | ⛔ **None.** ⭐ Can be decided today |

⚠️⚠️ **Both limbs, measured — ⛔ `DDR-0010` recorded only the first:**

| Limb | Existing *(CONFIRMED)* | `DDR-0010` *(APPROVED)* | ⭐ Recorded as a conflict? |
|---|---|---|---|
| 2D | ~70% | 70% | ⭐ No change |
| ⭐⭐ **Depth / 2.5D** | **20%** | **25%** | ⛔⛔ **NO — `20%` appears 0 times in `DDR-0010`** |
| **3D** | ~10% | **≤5%** | ⭐ **Yes** |

⭐ Both triples sum to **100** — ⭐ the 5 points **moved into the depth layer**.
⛔⛔ **The "≤5% is stricter, so working to it breaches neither" containment argument covers
only the 3D limb.** ⭐ **25% depth is MORE than 20%** — ⛔ it **fails** on the depth limb.

⚠️ **Four documents, not two.** ⭐ `DESIGN_FOUNDATION.md` **L10** states `70/20/10` as
**CONFIRMED** and ⛔ `DDR-0010` **never cites it** *(measured: 0 occurrences)*. ⭐ It is
*"the entry point for LIBOORA design work"* (§1) — ⛔ **the worst document to leave stale.**

---

## 5. ⭐ `CP-B3` — Design System Owner: Colour + Radius *(the ready token limbs)*

| # | Field | Content |
|---|---|---|
| **1** | **Owner** | ⭐ **Design System Owner**, with **Accessibility Owner** *(contrast countersign)* |
| **2** | **Decision required** | ⭐ Ratify `DDR-0001` colours and `DDR-0003` radius into the canonical token table; ⛔ record **14** and **18** as **deprecations** |
| **3** | **Evidence** | ⭐⭐ **Complete and computed, ⛔ not eyeballed.** `accent-ink #92400E` → **7.09** card / **6.68** surface · `text-muted #5F6585` → **5.70 / 5.37** · `border/control #7F87A6` → **3.34** *(WCAG 1.4.11 needs 3:1)* · `accent-fill #F5A524` **fills only**, paired with `textPrimary` → **8.42**. ⭐ Radius: **7** `BorderRadius.circular()` calls across **3** values; **2** call sites affected; ⛔ **no `LiblRadius` class** |
| **4** | **Options** | ⭐ Ratify as decided · ⭐ amend · ⛔ reject. ⚠️ **If amending `accent-ink`, `#B45309` is unavailable** — ⭐ byte-identical to `warning`, a semantic collision |
| **5** | **Consequences** | ⭐ Fixes **3 measured WCAG failures** · ⚠️ secondary text and control borders read **heavier** · ⭐ Enables a `LiblRadius` token class · ⛔ `theme.dart` is **not** thereby ratified — ⭐ **code must be brought to these values, not the reverse** |
| **6** | **Approval record location** | ⭐ **New `DDR-0014`**; ⭐ then `DESIGN_SYSTEM.md` §2 *(Color, Radius)*, `VISUAL_LANGUAGE.md` §3, `MASTER` L148–149; ⭐ **`DESIGN_DEBT.md` §3** for the 14/18 deprecations |
| **7** | **Status** | ⭐ **HUMAN ACTION REQUIRED** — ⭐ **READY** |
| **8** | **Dependency** | ⛔ **None** |

⚠️⚠️ ⛔ **Ratifying these does NOT close `DBT-001` or `DBT-005`** — ⭐ both rows have
**further limbs**, in `CP-B4`.

---

## 6. ⭐ `CP-B4` — Design System Owner: Spacing + Elevation tokens

| # | Field | Content |
|---|---|---|
| **1** | **Owner** | ⭐ **Design System Owner** |
| **2** | **Decision required** | ⭐ Decide the **spacing** token scale and the **elevation** scale — ⭐⭐ **on their merits** |
| **3** | **Evidence** | ⚠️ **As-built only — ⛔ and as-built is not authority.** `LiblSpace` = **6** steps *(`xs 4`, `sm 8`, `md 12`, `lg 16`, `xl 24`, `xxl 32`)*. ⭐ Elevation measured: **3** uses in `theme.dart` — `0`, `0`, `8` — ⛔ **no scale, no token class**. ⭐⭐ **Measured: across all 11 DDRs, `LiblSpace` appears 0 times** |
| **4** | **Options** | ⭐ **(i)** Adopt the 6 steps after review · ⭐ **(ii)** amend · ⭐ **(iii)** replace with a different scale. ⛔ **No preference expressed** |
| **5** | **Consequences** | ⭐ Spacing and elevation are **named foundations** in `DESIGN_SYSTEM.md` §2 · ⛔ A foundation reading `TO BE DECIDED` **cannot be FINAL** · ⭐ Deciding both is what makes `DBT-001` and `DBT-005` **closable** |
| **6** | **Approval record location** | ⭐ **New `DDR-0015`**; ⭐ then `DESIGN_SYSTEM.md` **L22**, **L24**; ⭐ then `DESIGN_DEBT.md` `DBT-001` / `DBT-005` |
| **7** | **Status** | ⚠️ **EVIDENCE REQUIRED** — ⭐ **the missing evidence is a REVIEW, not a measurement** |
| **8** | **Dependency** | ⛔ **None inbound** |

⚠️⚠️ **Why this is *evidence required* and not *ready*.** ⭐ The numbers exist in code, so
it looks ready. ⛔ **It is not.** ⭐ The only *"spacing"* mention across all 11 DDRs is
`DDR-0004`'s **≥8dp target spacing** — ⭐ an **accessibility minimum**, ⛔ **not a token
scale**. ⭐⭐ **The spacing limb has never been before an authority at all.** Writing the
code's six values into `DESIGN_SYSTEM.md` is the precise act rule 5 names:

> ⛔ *"Silently 'fixing' `DBT-001` by writing the code's token values into
> `DESIGN_SYSTEM.md` would convert an engineering default into design authority."*

⭐ **Adopting the six steps is a legitimate outcome. Adopting them *by default* is not.**

---

## 7. ⭐ `CP-C` — Accessibility Owner *(PRIORITY C)*

| # | Field | Content |
|---|---|---|
| **1** | **Owner** | ⭐ **Accessibility Owner** *(`DESIGN_OWNERSHIP.md` §1 — ⭐ *"Can block design approval for unresolved accessibility risk"*)* |
| **2** | **Decision required** | ⭐ Adopt `DDR-0004`'s minimums, replacing **2** `TO BE DECIDED` cells |
| **3** | **Evidence** | ⭐⭐ **Complete and measured.** `DDR-0004` **APPROVED**: ≥48×48dp · ≥8dp spacing · 4.5:1 / 3:1 · 2dp focus · 200% scale · icon+text always · reduced motion. ⭐ **Driver measured, not asserted:** `success` and `warning` have **identical luminance (5.02 / 4.73)** ⇒ ⛔ colour can never carry status. ⭐ The 48dp-vs-36px density tension is **already resolved** *(48dp on touch; 36px only pointer-only ≥905dp)* |
| **4** | **Options** | ⭐ Adopt as decided · ⭐ adopt with a named exception *(⚠️ `ACCESSIBILITY.md` §4 requires surface, impact, reason, mitigation, owner, expiry **and** approval — ⛔ *"Hard to implement" is not an exception record*)* |
| **5** | **Consequences** | ⚠️ **The accepted tradeoff:** 48dp costs vertical space ⇒ **fewer rows per screen** · ⭐ `DIT-007` measures **0** `Semantics` / `semanticsLabel` / `textScaleFactor` under `lib/` and **0** accessibility assertions under `test/` — ⭐⭐ **amending the document does not implement it** |
| **6** | **Approval record location** | ⭐ **New `DDR-0016`**; ⭐ then `ACCESSIBILITY.md` **L10** *(Target)* and **L26** *(minimums)* |
| **7** | **Status** | ⭐ **HUMAN ACTION REQUIRED** — ⭐ **READY** |
| **8** | **Dependency** | ⛔ **None** |

⚠️ **One scoping limit disclosed:** `ACCESSIBILITY.md` L10's *"selected standard"*.
⭐ `DDR-0004` adopts **WCAG 2.1 AA ratios**, ⛔ but names no **legal** standard. ⭐ The owner
may name WCAG 2.1 AA as the **design** standard; ⛔ a **legal** determination is outside
design authority — ⛔ and this pack does not make one.

---

## 8. ⭐ `CP-D` — Responsive Design Owner *(PRIORITY D)*

| # | Field | Content |
|---|---|---|
| **1** | **Owner** | ⭐ **Responsive Design Owner** *(`DESIGN_OWNERSHIP.md` §1 — *"Owns breakpoint behavior, layout adaptation, and device-mode rules"*)* |
| **2** | **Action required** | ⭐ **CREATE** the responsive specification. ⭐⭐ **A creation, not an amendment — the artifact does not exist** |
| **3** | **Evidence** | ⭐ **Values decided** — `DDR-0005` **APPROVED**: `<600dp` compact · `600–904dp` medium · `≥905dp` expanded, on **Material 3 window size classes**. ⭐ Reasoning already recorded: most students are `<600dp` ⇒ ⭐⭐ **single-column student experience is the primary design, ⛔ not a shrunken tablet layout**. ⭐ `DDR-0004` already fixes the density rule per class. ⛔ **Measured: 0 occurrences of `600dp`, `905dp` or `breakpoint` in any foundation document** |
| **4** | **Options** | ⭐ Author the artifact carrying `DDR-0005` · ⭐ author it with a documented deviation. ⛔ **The file name and location are the owner's choice — ⛔ not named here** |
| **5** | **Consequences** | ⭐ `G3` handoff and `DESIGN_QA.md` §1 both **require responsive evidence** and currently have **nothing to evaluate against** · ⭐ Closes the artifact half of `DBT-002` |
| **6** | **Approval record location** | ⭐ **New artifact** *(owner-named)*; ⭐ then `DESIGN_DEBT.md` `DBT-002`; ⭐ cross-link from `DESIGN_SYSTEM.md` §2 |
| **7** | **Status** | ⭐ **HUMAN ACTION REQUIRED** — ⭐ **READY** |
| **8** | **Dependency** | ⛔ **None** |

---

## 9. ⭐ `CP-E` — Performance / NFR *(PRIORITY E)*

| # | Field | Content |
|---|---|---|
| **1** | **Owner** | ⭐ **Governance Owner** *(document admission — `PRD_OWNERSHIP_MODEL.md` **L418**)* **+ Design Performance Owner** *(design-side budgets)* |
| **2** | **Action required** | ⭐ Create `NFR Budgets (V1)` with numeric limits for the **5** categories `PERFORMANCE.md` §5 names |
| **3** | **Evidence** | ⭐ **Structure only.** `PERFORMANCE.md` §5 lists the categories. ⭐ `MASTER` proposes **16ms** frame budget and motion **150 / 200 / 300ms** — ⛔⛔ **PROPOSED, not adopted, and ⛔ NOT proposed as answers here.** `MASTER_PRD` **L663** — *"Targets are deliberately not set here; they belong to … **NFR Budgets**"* · `ADR-0100` **L185** — *"There is **no** Enterprise Architecture NFR Budgets document"*; EA **L339–344** is *"headings with zero values"* |
| **4** | **Options** | ⛔⛔ **NONE PROPOSED.** ⭐ A numeric SLO invented by design would be exactly the fabrication this pack exists to prevent |
| **5** | **Consequences** | ⛔ Until it exists, **no numeric SLO may be published as authoritative** and ⭐ the ≤5% 3D budget stays **unvalidated against a confirmed target** |
| **6** | **Approval record location** | ⭐ **New `NFR Budgets (V1)`**; ⭐ then `PERFORMANCE.md` **L8** and **§5** |
| **7** | **Status** | ⚠️ **EVIDENCE REQUIRED** |
| **8** | **Dependency** | ⛔⛔ **STRICTLY downstream of `CP-A`.** ⭐ A budget without a target device class is **arithmetic without units** |

---

## 10. ⭐ `CP-F` — Gate `G0`: ⛔ **I am NOT permitted to record it** *(PRIORITY F)*

⭐⭐ **The instruction said: *"Record `G0` only if its authorized process permits it."*
⭐ I tested that conditional properly. ⛔ It does not permit it — and the test is short.**

| Step | Measured |
|---|---|
| **1. Who approves `G0`?** | ⭐ `DESIGN_GOVERNANCE.md` §4, L42: ⭐⭐ **"Design Documentation *Owner*"** |
| **2. What is the AI's role?** | ⭐ `DESIGN_GOVERNANCE.md` §5, L58: ⭐⭐ **"Design Documentation *Author*"** — *"May draft, normalize, and cross-reference design documentation"* |
| **3. Are they the same office?** | ⛔⛔ **NO.** ⭐ `DESIGN_OWNERSHIP.md` **§2**: *"The **author**, reviewer, implementation mechanism, and final business authority are **separate by design**."* ⭐ The **Owner** *"Can update design docs **under change control**"* (L32); ⭐ the **Author** may only **draft** |
| **4. Verdict** | ⛔⛔ **The authorized process does NOT permit me to record `G0`.** ⭐ One word separates the two offices — *Author* vs *Owner* — ⭐ and `DESIGN_OWNERSHIP.md` §2 exists precisely to make that word load-bearing |

⚠️⚠️ **This was the single most tempting act in the whole instruction set.** ⭐ `G0`'s
evidence *is* substantively satisfied — `DD-0007` alone carries **245** `PRD-023`/`CNF-*`
citations, and the DDRs cite PRDs, ADRs and the BC Map throughout. ⭐ Recording it would
have moved the gate count **0/6 → 1/6** and produced visible progress. ⛔ **But the
evidence being sufficient is a different question from my being the office that may
certify it** — ⭐ and conflating the two is how an author quietly becomes an authority.

### ⭐ `CP-F` — the package for the office that *can* record it

| # | Field | Content |
|---|---|---|
| **1** | **Owner** | ⭐ **Design Documentation Owner**; ⭐ escalate source ambiguity to **Design Governance Owner** *(§4 L42)* |
| **2** | **Action required** | ⭐ Record `G0` **Source audit** as passed, ⭐ status **CONFIRMED** |
| **3** | **Evidence** | ⭐ *"Relevant PRDs, freeze records, ADRs, architecture, and developer docs read"* — ⭐ `DD-0007`: **245** source citations · ⭐ `DDR-0001…0011`: every record carries a **Source references** field · ⭐ the audit's **26-row** contradiction matrix is itself a completed source audit |
| **4** | **Options** | ⭐ Record as passed · ⭐ record with named source ambiguities · ⛔ return |
| **5** | **Consequences** | ⭐ Moves gates **0/6 → 1/6** · ⛔ Does **not** advance `G1`–`G5` — ⭐ gates are sequential |
| **6** | **Approval record location** | ⭐ A gate record under `DESIGN_CHANGE_MANAGEMENT.md` §4. ⚠️ **Disclosed: no gate-record template exists** — `templates/` holds only component, screen and QA-evidence forms. ⭐ Creating one is the **Design Governance Owner's** act |
| **7** | **Status** | ⭐ **HUMAN ACTION REQUIRED** — ⭐ **READY** |
| **8** | **Dependency** | ⛔ **None.** ⭐ The **only** gate takeable today |

---

## 11. ⭐ `CP-G` — `G1` and `G4`: preserved as blocked *(PRIORITY G)*

⭐⭐ **Both are blocked by prerequisites that no design act can clear.** ⭐ Recorded so
neither is mistaken for design slippage.

| Gate | Approver | ⛔ Independent prerequisite | Why design cannot clear it |
|---|---|---|---|
| **`G1`** Experience architecture | UX Architecture Owner | ⛔⛔ **`DBT-006`** — *"The designed screen set and the built screen set **do not intersect**"*: **5** designed families with no implementation; **11** built screens with no design artifact | ⭐⭐ **`DBT-006`'s owning office is the Founder/Product Authority** and the register calls it *"a **product scope** question, not a documentation defect"* |
| **`G4`** Design QA | Design QA Owner | ⛔⛔ **`DBT-004`** — **1** `testWidgets` assertion in the entire repository against `DESIGN_QA.md` §1's **6** check categories | ⭐ A `G4` pass today *"would rest on **review judgement alone** for every surface but one"*. ⭐ Owned jointly with the **engineering counterpart** |

⛔⛔ **Neither is downgraded, re-scoped or routed to a reachable office to make it
actionable** — ⭐ the practice `DESIGN_OWNERSHIP.md` §1.1 expressly warns against.

---

## 12. ⭐ `CP-H` — Design Governance Owner: `G5` closure package *(PRIORITY H)*

| # | Field | Content |
|---|---|---|
| **1** | **Owner** | ⭐ **Design Governance Owner** *(`DESIGN_GOVERNANCE.md` §4, L47)* |
| **2** | **Action required** | ⭐ The **terminal** governance act: record *"Version, impact, decision record, and approvals"* per `DESIGN_CHANGE_MANAGEMENT.md` §4 |
| **3** | **Evidence** | ⛔ **Not yet assembled** — ⭐ `G5` records the **outcome** of `CP-A`…`CP-D`, which have not occurred |
| **4** | **Options** | ⛔ **None available today** |
| **5** | **Consequences** | ⭐ `G5` is what converts a set of owner decisions into an **approved design system** |
| **6** | **Approval record location** | ⭐ A `G5` change record under `DESIGN_CHANGE_MANAGEMENT.md` §4 |
| **7** | **Status** | ⛔ **BLOCKED — last in sequence** |
| **8** | **Dependency** | ⛔ `CP-B1`…`B4`, `CP-C`, `CP-D`, `CP-I`, and gates `G0`→`G2`→`G3` |

### ⭐ The `G5` checklist — ⛔ **0 of 11 items satisfied today**

| # | Required before `G5` | Status |
|---|---|---|
| 1 | `CP-A` V1 device profile confirmed | ⛔ **NO** |
| 2 | `CP-B1` Typeface selected + Indic guarantee closed | ⛔ **NO** |
| 3 | `CP-B2` Layer ratios reconciled **(both limbs, 4 documents)** | ⛔ **NO** |
| 4 | `CP-B3` Colour + radius ratified; 14/18 deprecated | ⛔ **NO** |
| 5 | `CP-B4` Spacing + elevation decided | ⛔ **NO** |
| 6 | `CP-C` `ACCESSIBILITY.md` amended | ⛔ **NO** |
| 7 | `CP-D` Responsive artifact created | ⛔ **NO** |
| 8 | `CP-E` `NFR Budgets (V1)` created | ⛔ **NO** |
| 9 | `CP-I` `DDR-0009` version defect cured | ⛔ **NO** |
| 10 | Gates `G0`–`G4` recorded | ⛔ **NO — 0 of 6** |
| 11 | `DBT-001`/`002`/`005` closable | ⛔ **NO** |

---

## 13. ⭐ Remaining packages — `CP-I`, `CP-J`, `CP-K`

### `CP-I` — Founder/Product Authority: cure the `DDR-0009` version defect

| # | Field | Content |
|---|---|---|
| **1** | **Owner** | ⭐ **Founder/Product Authority** *(re-affirm naming `v0.1`)* **or** **Design Governance Owner** *(record the binding)* |
| **2** | **Action required** | ⭐ Bind the approval to an artifact **version** |
| **3** | **Evidence** | ⭐ `DESIGN_OWNERSHIP.md` §3 requires *"artifact, **version**, decision status, approver role, date, and unresolved conditions"*. ⭐ `DDR-0009` supplies **5 of 6**; ⛔ `v0.1` *(`MASTER` header L13)* is **never named** |
| **4** | **Options** | ⭐ Re-affirm naming `v0.1` · ⭐ record the binding as a governance note |
| **5** | **Consequences** | ⭐⭐ The Master **will be amended** by `CP-B`…`CP-D`; ⛔ an unversioned approval cannot later be shown to have covered, or not covered, those amendments |
| **6** | **Approval record location** | ⭐ **New `DDR-0017`** *(⛔ **never reuse an ID** — `README.md` §4)* |
| **7** | **Status** | ⭐ **HUMAN ACTION REQUIRED** — ⭐ **READY** |
| **8** | **Dependency** | ⛔ **None** |

### `CP-J` — UX Architecture Owner: `DD-0007` refresh

| # | Field | Content |
|---|---|---|
| **1** | **Owner** | ⭐ **UX Architecture Owner** *(`DD-0007` header Owner cell)* |
| **2** | **Action required** | ⭐ **(a)** reflect `DDR-0008`'s `C-4` removal; ⭐ **(b)** refresh coverage **79 → 85** |
| **3** | **Evidence** | ⭐⭐ **Complete and pre-computed.** ⭐ **(a)** `DDR-0008` **APPROVED**, condition **TESTED** on 4 probes — `CNF-FR-060` *emits* not reads · `CNF-BR-006` is *"a subtraction"* · `CNF-AC-044` *"no second version history"* · grep for an audit-reading-surface requirement = **ZERO**. ⭐ **(b)** `ADR-0163` **§4.4** prescribes the exact minimum change: *v0.9→v1.0 · 79→85 · holds 25→19 · D3 stays `PARTIAL` · `C-5` stays · Figma blockers stay 4* |
| **4** | **Options** | ⭐ Apply as prescribed · ⭐ apply with recorded variance |
| **5** | **Consequences** | ⭐ `DD7-GAP-008` discharged for V1 **by removal**, ⛔ **not by allocating a reader** · ⚠️ If a future authorized requirement mandates a `BC-25` audit-reading surface, ⭐ **`C-4` returns and the reader question reopens** |
| **6** | **Approval record location** | ⭐ `DD-0007` — header, **L1036**, **L1565**, §21, `DD7-GAP-008` row |
| **7** | **Status** | ⭐ **HUMAN ACTION REQUIRED** — ⭐ **READY** |
| **8** | **Dependency** | ⛔ **None** · ⛔ **Does NOT block FINAL APPROVAL** *(a surface doc, not a foundation)* |

### `CP-K` — Two registers are factually stale

| # | Field | Content |
|---|---|---|
| **1** | **Owner** | ⭐ **Design Documentation Owner** *(`README.md` §3)* · ⭐ **Design Governance Owner** *(`DBT-008`)* |
| **2** | **Action required** | ⭐ Correct two statements of fact that **11 DDRs** have overtaken |
| **3** | **Evidence** | ⭐ `design-decisions/README.md` §3: *"**No** design decision has been marked APPROVED"* · `DBT-008`: *"**0** design decisions … APPROVED"* — ⭐ **11 DDRs now exist, 9 APPROVED** |
| **4** | **Options** | ⭐ Correct the counts and add the records to the register *(`README.md` §4 requires it)* |
| **5** | **Consequences** | ⭐ Removes a register that **contradicts its own contents** |
| **6** | **Approval record location** | ⭐ `design-decisions/README.md` §3 · `DESIGN_DEBT.md` `DBT-008` |
| **7** | **Status** | ⭐ **HUMAN ACTION REQUIRED** — ⭐ **READY** |
| **8** | **Dependency** | ⛔ **None** · ⛔ **Does NOT block FINAL APPROVAL** |

⚠️⚠️ ⛔ **`DBT-008` must be CORRECTED, not CLOSED.** ⭐ Its two limbs are joined by *"and"*,
and ⭐ the second — *"Gates `G0`–`G5` … none has been recorded as passed"* — ⭐ **remains
true at 0 of 6**. ⭐ Its review trigger *("A design approval act")* **has fired**, so the
row is **due for review**. ⛔ **Due for review is not closed.**

---

## 14. ⭐⭐ FINAL READINESS MATRIX

### 14.1 ⛔ FINAL APPROVAL READY

| Item | Status |
|---|---|
| ⛔⛔ **NOTHING** | ⭐ **0 items.** ⭐ `G5` requires **11** preconditions; ⛔ **0 are satisfied** *(§12)* |

⛔⛔ **The Design System is NOT approved and MUST NOT be marked FINAL/APPROVED.**

### 14.2 ⭐ HUMAN ACTION REQUIRED — ⭐ evidence complete, awaiting a signature

| Pack | Action | Owner | Blocks FINAL? |
|---|---|---|---|
| **`CP-B2`** | ⭐⭐ Reconcile layer ratios — **both limbs, 4 documents** | Design System Owner | ⭐⭐ **YES** |
| **`CP-B3`** | Ratify colour + radius; deprecate 14/18 | Design System Owner | ⭐ **YES** |
| **`CP-C`** | Amend `ACCESSIBILITY.md` L10 + L26 | Accessibility Owner | ⭐ **YES** |
| **`CP-D`** | **Create** the responsive artifact | Responsive Design Owner | ⭐ **YES** |
| **`CP-F`** | Record gate `G0` | ⭐ **Design Documentation Owner** | ⭐ **YES** *(via `G5`)* |
| **`CP-I`** | Cure the `DDR-0009` version defect | Founder/Product Authority | ⚠️ **YES** *(formal)* |
| **`CP-J`** | `DD-0007` — `C-4` removal + 79→85 | UX Architecture Owner | ⛔ **NO** |
| **`CP-K`** | Correct 2 stale registers | Doc + Governance Owner | ⛔ **NO** |

⭐⭐ **8 acts can be taken today, in parallel, by 6 different offices.** ⛔ **None waits on
anything.**

### 14.3 ⚠️ EVIDENCE REQUIRED — ⛔ cannot responsibly be signed yet

| Pack | Missing evidence — ⭐ stated exactly | Who can produce it |
|---|---|---|
| **`CP-A`** | ⭐⭐ **The V1 device profile numbers** — minSdk, reference RAM/screen, network assumption. ⭐ Measured: **16** *"Technical Owner"* hits, ⛔ **0** are a profile decision | ⭐⭐ **Technical Owner** |
| **`CP-B1`** | ⭐ **One probe** — does the confirmed V1 Android font stack **guarantee** Devanagari on the target class? ⚠️ Sharpened by §A.4: the answer may differ between **Android 7.0** and **8.0** | Design System + Technical Owner |
| **`CP-B4`** | ⭐⭐ **A review, not a measurement** — the 6 `LiblSpace` steps have **never been before an authority** *(0 DDR mentions)* | Design System Owner |
| **`CP-E`** | ⭐ **The device profile** — ⛔ a budget without a target class is arithmetic without units | Technical Owner → Governance + Perf Owner |

### 14.4 ⛔ EXTERNALLY BLOCKED

| Item | Blocker | ⭐ Note |
|---|---|---|
| **`CP-B1`** *(bundling limb)* | ⛔ Font **licence** review — SIL OFL terms | ⭐ Design Governance Owner; ⭐ external licence text |
| ⚠️ `IMPL-020` SMS / DLT | ⛔ External telecom registration, multi-week lead | ⛔ **Outside design entirely** — ⭐ noted because it gates the product, ⛔ not this pack |
| ⚠️ `B-6` / `LR-01` | ⛔ Requires a **qualified Indian advocate**, court or DPB determination | ⛔ **Outside design entirely** |

### 14.5 ⛔ OUTSIDE DESIGN SCOPE

| Item | Rightful office | Why design cannot act |
|---|---|---|
| ⭐⭐ **V1 device profile** | **Technical Owner** | ⭐ Design Performance Owner *"**Cannot** set backend SLOs or claim measured performance"* |
| **`G1`** via `DBT-006` | **Founder/Product Authority** | ⭐ *"a **product scope** question, not a documentation defect"* |
| **`G4`** via `DBT-004` | **Design QA Owner** + engineering | ⭐ **1** widget test against **6** check categories |
| **Supported UI languages** | **Product Owner** | ⭐ `DBT-003`; ⛔ **0** `flutter_localizations` |
| **`PRD-011` AI Coach** | **Product Owner** | ⭐ `PLANNED`; ⛔ designing behaviour would invent requirements |
| **Font bundling in code** | **Technical Owner** | ⛔ `pubspec.yaml` / `theme.dart` are code |
| **19 held `BC-25` parameters** | Per `DP-0004` | ⛔ Authorization/architecture, not design |

### 14.6 Totals

| Category | Count |
|---|---|
| ⛔ **FINAL APPROVAL READY** | ⛔⛔ **0** |
| ⭐ **HUMAN ACTION REQUIRED** | ⭐ **8** |
| ⚠️ **EVIDENCE REQUIRED** | ⚠️ **4** |
| ⛔ **EXTERNALLY BLOCKED** | ⛔ **3** |
| ⛔ **OUTSIDE DESIGN SCOPE** | ⛔ **7** |

---

## 15. ⭐ Execution record — what this pass actually did

| Act | Count |
|---|---|
| ⭐ Decision packages prepared | **11** *(`CP-A` … `CP-K`)* |
| ⭐⭐ **New measured facts surfaced** | **1** — ⭐ **as-built `minSdk` = API 24 (Android 7.0)**, ⚠️ **weaker than the design inference of API 26** |
| ⛔ Decisions taken | **0** |
| ⛔ Approvals granted or implied | **0** |
| ⛔ Gates recorded | **0** — ⭐ `G0` **tested and refused** *(§10)* |
| ⛔ Fonts selected | **0** |
| ⛔ Conflicts resolved | **0** — ⭐ **all four ratio values preserved** |
| ⛔ Numeric SLOs invented | **0** |
| ⛔ Spacing/elevation ratified from code | **0** |
| ⛔ Canonical documents amended | **0** |
| ⛔ Debt rows closed | **0** |
| ⛔ Owners, roles, permissions, `PERM-*`, requirements invented | **0** |
| ⛔ PRDs / ADRs / code / Figma touched | **0** |
| ⛔ Commit / push | **NONE** |

⭐⭐ **On the one act that looked available:** ⭐ recording `G0` would have shown progress
and its evidence *is* sufficient. ⛔ **The authorized process names the Design
Documentation *Owner*, and `DESIGN_GOVERNANCE.md` §5 constitutes the AI as the Design
Documentation *Author*.** ⭐ `DESIGN_OWNERSHIP.md` §2 makes that distinction load-bearing:
*"separate by design."* ⛔ **So it was not taken.**

---

# ⭐ DESIGN AUTHORITY CLOSURE PACK READY
