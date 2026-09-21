<!-- LIBOORA Design Documentation | Owner Closure Dashboard | 2026-09-19 -->

> This document is **design governance and documentation**. ⛔ It does **not** amend product
> requirements, architecture decisions, bounded-context ownership, permissions, roles or
> backend contracts. ⛔ It **decides nothing** and **approves nothing**.

# LIBOORA Owner Closure Dashboard

| Field | Value |
|---|---|
| **Document** | `LIBOORA_OWNER_CLOSURE_DASHBOARD.md` · **v1.0** |
| **Status** | ⚠️ **TRACKING VIEW** — ⛔ not an approval instrument |
| **Rank** | ⛔ **UNRANKED** |
| **Author** | AI, as **Design Documentation Author** *(`DESIGN_GOVERNANCE.md` §5)* |
| **Covers** | ⭐ The **10 reserved packages** from [`LIBOORA_DESIGN_AUTHORITY_CLOSURE_PACK.md`](LIBOORA_DESIGN_AUTHORITY_CLOSURE_PACK.md) |
| **Register state** | ⭐ `DDR-0001`…`0011` + `DDR-0017`…`0020` **allocated** *(15 records)* · ⭐ `DDR-0012`…`0016` **reserved and free** *(verified: 0 record headings)* |
| ⛔ **Design System status** | ⛔⛔ **NOT APPROVED** — ⭐ gates **0 of 6** |

---

## A. ⭐ CAN BE DECIDED NOW — 4 packages

⭐ **Evidence is complete. ⛔ Only a signature is missing. ⛔ Nothing waits on anything.**

| | `CP-B2′` — ⭐⭐ **The layer-ratio CONFLICT** |
|---|---|
| **Owner** | **Design System Owner** + **Design Vision Owner**; ⭐ **Design Documentation Owner** for `DESIGN_FOUNDATION.md` L10 |
| **Decision required** | ⭐ Establish the **canonical** layer triple — ⚠️⚠️ **both limbs** |
| **Evidence available** | ⭐ **Complete.** `70/20/10` **CONFIRMED** in 3 documents · `70/25/≤5` **APPROVED** *(`DDR-0010`, re-affirmed `DDR-0018`)* · both sum to **100** |
| **Missing** | ⛔ **Only the decision** |
| **Dependency** | ⛔ **NONE** |
| **Reserved DDR** | ⭐⭐ **`DDR-0013`** *(free — ⛔ deliberately left unused by `DDR-0018`)* |
| **Blocks FINAL?** | ⭐⭐ **YES** |

⚠️⚠️ **The limb that gets missed:** ⭐ **3D** `~10% → ≤5%` is **stricter**, so working to
it breaches neither. ⭐⭐ **Depth** `20% → 25%` is **looser** — ⛔ **the containment
argument fails there.** ⭐ **4 documents** must be amended, including `DESIGN_FOUNDATION.md`
**L10**, the design entry point, which `DDR-0010` never cited.

| | `CP-B3` — Colour + Radius ratification |
|---|---|
| **Owner** | **Design System Owner** + **Accessibility Owner** *(contrast countersign)* |
| **Decision required** | ⭐ Ratify `DDR-0001` colours and `DDR-0003` radius; ⛔ record **14** and **18** as **deprecations** *(`DESIGN_DEBT.md` §3 — ⛔ never by deletion)* |
| **Evidence available** | ⭐⭐ **Complete and computed.** `#92400E` → **7.09 / 6.68** · `#5F6585` → **5.70 / 5.37** · `#7F87A6` → **3.34** · amber-fill + `textPrimary` → **8.42**. ⭐ Radius: **7** calls, **3** values, **2** call sites |
| **Missing** | ⛔ **Only ratification.** ⚠️ If amending `accent-ink`, **`#B45309` is unavailable** — byte-identical to `warning` |
| **Dependency** | ⛔ **NONE** |
| **Reserved DDR** | ⭐ **`DDR-0014`** |
| **Blocks FINAL?** | ⭐ **YES** — part of `G2` |

| | `CP-C` — Accessibility amendments |
|---|---|
| **Owner** | **Accessibility Owner** |
| **Decision required** | ⭐ Adopt `DDR-0004`'s minimums into `ACCESSIBILITY.md`, replacing **2** `TO BE DECIDED` cells |
| **Evidence available** | ⭐⭐ **Complete.** ≥48×48dp · ≥8dp · 4.5:1 / 3:1 · 2dp focus · 200% scale · icon+text always. ⭐ **Measured driver:** `success` and `warning` have **identical luminance (5.02 / 4.73)** ⇒ ⛔ colour can never carry status. ⭐ Density tension already resolved |
| **Missing** | ⛔ **Only the amendment.** ⚠️ L10's *"selected standard"* — ⭐ WCAG 2.1 AA may be named as the **design** standard; ⛔ a **legal** standard is outside design |
| **Dependency** | ⛔ **NONE** |
| **Reserved DDR** | ⭐ **`DDR-0016`** |
| **Blocks FINAL?** | ⭐ **YES** — part of `G2` |

| | `CP-D` — Responsive artifact |
|---|---|
| **Owner** | **Responsive Design Owner** |
| **Decision required** | ⭐⭐ **CREATE** the responsive specification — ⛔ **a creation, not an amendment** |
| **Evidence available** | ⭐ Values **APPROVED** *(`DDR-0005`)*: `<600` / `600–904` / `≥905 dp`, on Material 3 window classes. ⭐ Per-class density already fixed by `DDR-0004` |
| **Missing** | ⛔ **The artifact.** ⭐ Measured: **0** occurrences of `600dp`, `905dp` or `breakpoint` in any foundation document |
| **Dependency** | ⛔ **NONE** |
| **Reserved DDR** | ⭐ **New artifact** *(owner-named)* → `DESIGN_DEBT.md` `DBT-002` |
| **Blocks FINAL?** | ⭐ **YES** — `G3` |

---

## B. ⚠️ NEEDS FACTUAL EVIDENCE — 2 packages

⛔ **Signing these today would mean guessing.**

| | `CP-A` — ⭐⭐ **V1 device profile** *(the bottleneck)* |
|---|---|
| **Owner** | ⭐⭐ **Technical Owner** — ⛔ **not** the Design Performance Owner, who *"**Cannot** set backend SLOs or claim measured performance"* |
| **Decision required** | ⭐ State **(a)** minimum Android API · **(b)** reference RAM + screen · **(c)** network assumption |
| **Evidence available** | ⭐ **Directional only** — `MP-CON-12` *"India-first … network-unreliable"*; `PERFORMANCE.md` L10 *"low-end Android"*. ⭐⭐ **Plus one measured fact: as-built floor is API 24 (Android 7.0)** — `build.gradle.kts:27` → Flutter default `'24'`, **no project override** |
| **Missing** | ⛔⛔ **The numbers.** ⭐ Measured: **16** *"Technical Owner"* hits repo-wide, ⛔ **0** are a profile decision |
| **Dependency** | ⛔ **NONE inbound** — ⭐⭐ **start first, longest lead time** |
| **Reserved DDR** | ⭐ A Technical Owner record → `PERFORMANCE.md` L10 |
| **Blocks FINAL?** | ⚠️ **PARTIAL** — ⛔ blocks `CP-E`, ⚠️ conditions `CP-B1`; ⭐ **does NOT block `CP-B2′`, `B3`, `B4`, `C`, `D`, `F`** |

⚠️⚠️ **The design inference (API 26) was *stricter* than the build permits.** ⭐ The app
installs on **Android 7.0** today — a class the design work never considered. ⛔ **API 24
is NOT proposed as the answer** — an unreviewed framework default must not become
authority.

| | `CP-B4` — Spacing + Elevation tokens |
|---|---|
| **Owner** | **Design System Owner** |
| **Decision required** | ⭐ Decide the **spacing** scale and the **elevation** scale |
| **Evidence available** | ⚠️ **As-built only.** `LiblSpace` = **6** steps *(4/8/12/16/24/32)*; elevation = **3** uses *(`0`,`0`,`8`)*, ⛔ **no scale, no token class** |
| **Missing** | ⭐⭐ **A REVIEW, not a measurement.** ⭐ Measured: across all 15 DDRs, `LiblSpace` appears **0** times; the only *"spacing"* hit is `DDR-0004`'s **≥8dp target spacing** — ⭐ an accessibility minimum, ⛔ **not a token scale.** ⭐⭐ **This limb has never been before an authority** |
| **Dependency** | ⛔ **NONE inbound** |
| **Reserved DDR** | ⭐ **`DDR-0015`** |
| **Blocks FINAL?** | ⭐⭐ **YES** — ⭐ spacing and elevation are **named foundations**; ⛔ a foundation reading `TO BE DECIDED` cannot be FINAL |

⚠️ **Why not category A:** the numbers exist in code, so it *looks* ready. ⛔ Writing them
into `DESIGN_SYSTEM.md` is the precise act `DESIGN_DEBT.md` rule 5 forbids — ⭐ *"would
convert an engineering default into design authority."* ⭐ **Adopting them after review is
legitimate; adopting them by default is not.**

---

## C. ⛔ DEPENDS ON ANOTHER OWNER — 2 packages

| | `CP-B1` — Typeface |
|---|---|
| **Owner** | **Design System Owner** *(selection + licence)* → **Technical Owner** *(bundling/fallback)*; **Design Governance Owner** *(licence)* |
| **Decision required** | ⭐ **(a)** select the family; ⭐ **(b)** ⭐⭐ close the gap between `DDR-0002`'s **APPROVED guarantee** and what ships |
| **Evidence available** | ⭐ Requirement **APPROVED** — *"MUST **guarantee** proper Indic rendering."* ⭐ Shortlist: **Noto Sans + Noto Sans Devanagari** *(matched pair by construction)* · ⚠️ Inter + companion *(only if x-height/weight verified)* · ⚠️ Lexend *(unverified)* · ⛔ **Inter alone disqualified**. ⭐⭐ **As-built: `theme.dart:49` = `Roboto`, 0 font assets, 0 `fontFamilyFallback`, 0 mentions in `docs/design/`** |
| **Missing** | ⛔ **One probe** — does the confirmed V1 Android font stack **guarantee** Devanagari on the target class? ⚠️ The answer may differ between **Android 7.0** and **8.0** |
| **Dependency** | ⚠️ **On `CP-A`** — ⭐ the **family** can be chosen now; ⛔ **bundle-vs-fallback** needs the device profile |
| **Reserved DDR** | ⭐ **`DDR-0012`** |
| **Blocks FINAL?** | ⭐⭐ **YES** |

⚠️⚠️ ⛔ **The protection you approved does not exist yet.** ⭐ A student seeing their own
name as `□□□` is presently prevented by **nothing in the repository** — only by an
undeclared platform fallback.

| | `CP-E` — `NFR Budgets (V1)` |
|---|---|
| **Owner** | **Governance Owner** *(admission)* + **Design Performance Owner** *(budgets)* |
| **Decision required** | ⭐ Create `NFR Budgets (V1)` with numeric limits for `PERFORMANCE.md` §5's **5** categories |
| **Evidence available** | ⭐ **Structure only.** `MASTER` proposes 16ms frame and 150/200/300ms motion — ⛔⛔ **PROPOSED, not adopted, ⛔ not proposed as answers** |
| **Missing** | ⛔⛔ **The device profile.** ⭐ `ADR-0100` L185: *"There is **no** Enterprise Architecture NFR Budgets document"*; EA L339–344 is *"headings with zero values"* |
| **Dependency** | ⛔⛔ **STRICTLY downstream of `CP-A`** — ⭐ a budget without a target class is arithmetic without units |
| **Reserved DDR** | ⭐ **New `NFR Budgets (V1)`** → `PERFORMANCE.md` L8, §5 |
| **Blocks FINAL?** | ⚠️ **PARTIAL** — ⛔ blocks `DD7-GAP-009` and final validation of ≤5% 3D |

---

## D. ⛔ GATE-ONLY ACTION — 2 packages

| | `CP-F` — Gate `G0` *(Source audit)* |
|---|---|
| **Owner** | ⭐⭐ **Design Documentation Owner** — ⛔ **NOT the AI**, which `DESIGN_GOVERNANCE.md` §5 constitutes as Design Documentation **Author**; ⭐ `DESIGN_OWNERSHIP.md` §2: *"separate by design"* |
| **Decision required** | ⭐ Record `G0` as passed, status **CONFIRMED** |
| **Evidence available** | ⭐⭐ **Substantively satisfied** — `DD-0007` alone carries **245** source citations; all 15 DDRs carry a **Source references** field; the audit's 26-row matrix is itself a completed source audit |
| **Missing** | ⛔ **Only the record.** ⚠️ **Disclosed: no gate-record template exists** — `templates/` holds only component, screen and QA-evidence forms |
| **Dependency** | ⛔ **NONE** |
| **Reserved DDR** | ⭐ A gate record under `DESIGN_CHANGE_MANAGEMENT.md` §4 |
| **Blocks FINAL?** | ⭐ **YES** *(via `G5`)* — ⭐⭐ **the only gate takeable today** |

| | `CP-H` — Gate `G5` *(Change / final closure)* |
|---|---|
| **Owner** | **Design Governance Owner** |
| **Decision required** | ⭐ Record *"Version, impact, decision record, and approvals"* |
| **Evidence available** | ⛔ **Not yet assembled** — ⭐ `G5` records the **outcome** of everything above |
| **Missing** | ⛔⛔ **11 preconditions — 0 satisfied** |
| **Dependency** | ⛔ **Everything.** ⭐ Terminal act |
| **Reserved DDR** | ⭐ A `G5` change record under `DESIGN_CHANGE_MANAGEMENT.md` §4 |
| **Blocks FINAL?** | ⭐⭐ **YES — it IS the final approval** |

---

## E. ⛔ Outside these 10 — carried for visibility

| Item | Owner | Why it is not a package here |
|---|---|---|
| **`G1`** via `DBT-006` | ⭐ **Founder/Product Authority** | ⭐ Designed and built screen sets **do not intersect** — ⭐ *"a **product scope** question"*. ⚠️ **KEPT OPEN** by express instruction |
| **`G4`** via `DBT-004` | Design QA Owner + engineering | ⭐ **1** `testWidgets` assertion against **6** check categories |
| `CP-J` / `CP-K` | UX Arch · Doc + Governance Owner | ⭐ **Directed** by `DDR-0019` / `DDR-0020`; ⛔ execution pending. ⛔ Neither blocks FINAL |

---

## F. Dashboard totals

| Category | Count | Blocks FINAL |
|---|---|---|
| ⭐ **A — Can be decided now** | **4** | **4** |
| ⚠️ **B — Needs factual evidence** | **2** | **2** *(1 partial)* |
| ⛔ **C — Depends on another owner** | **2** | **2** *(1 partial)* |
| ⛔ **D — Gate-only** | **2** | **2** |

⭐⭐ **Offices holding work: 8.** ⭐ **Acts available today: 5** *(4 from A + `CP-F`)* —
⛔ **plus `CP-A`, which must be *requested* today even though it is *needed* last.**

---

## G. ⭐⭐ Shortest sequence to `DESIGN SYSTEM — FINAL/APPROVED`

⭐ **Four waves. ⭐ The critical path is `CP-A → CP-B1 → G2 → G3 → G5` — ⛔ five links.**

```
WAVE 1 — all start today, in parallel (6 offices)
  ⭐ CP-A   REQUEST the V1 device profile ......... Technical Owner   ⚠️ longest lead
  ⭐ CP-B2′ Reconcile layer ratios (2 limbs, 4 docs) Design System + Vision Owner
  ⭐ CP-B3  Ratify colour + radius; deprecate 14/18  Design System Owner
  ⭐ CP-B4  REVIEW then decide spacing + elevation   Design System Owner
  ⭐ CP-C   Amend ACCESSIBILITY.md L10 + L26 ....... Accessibility Owner
  ⭐ CP-D   CREATE the responsive artifact ......... Responsive Design Owner
  ⭐ CP-F   Record gate G0 ........................ Design Documentation Owner
     └─ also, not blocking: CP-J (DD-0007), CP-K (registers)

WAVE 2 — unlocked by CP-A
  ⭐ CP-B1  Select typeface + close the Indic gap .. Design System → Technical Owner
  ⭐ CP-E   Create NFR Budgets (V1) ................ Governance + Design Perf Owner

WAVE 3 — gates, strictly sequential
  ⭐ G2  Foundation ...... Design System + Accessibility Owner
         (needs B1, B2′, B3, B4, C)
  ⭐ G3  Handoff ......... Design–Engineering Handoff Owner  (needs G2 + CP-D)

WAVE 4 — terminal
  ⭐ G5  Change/closure .. Design Governance Owner
  ⭐ FINAL APPROVAL ...... Founder/Product Authority
```

### ⚠️⚠️ Two honest caveats on "shortest"

⭐ **1. `G1` and `G4` are NOT on this path, and that is a real limitation.**
⭐ `DESIGN_GOVERNANCE.md` §4 constitutes **six** gates. ⭐ The sequence above reaches
`G0`, `G2`, `G3`, `G5` — ⛔ **it does not reach `G1` or `G4`**, because each is blocked by
a prerequisite **no design act can clear**: `DBT-006` *(product scope — Founder)* and
`DBT-004` *(1 widget test vs 6 check categories — QA + engineering)*.

⛔⛔ **So the shortest design-only path produces 4 of 6 gates.** ⭐ Whether that is
sufficient for FINAL is the **Design Governance Owner's** call at `G5` — ⛔ **this
dashboard does not decide it, and must not.** ⭐ If all six are required, then
**`DBT-006` and `DBT-004` join the critical path** and the sequence lengthens.

⭐ **2. The bottleneck is the one act design cannot perform.**
⭐ `CP-A` has the longest lead time, gates `CP-E`, conditions `CP-B1`, and belongs
entirely to the **Technical Owner**. ⭐⭐ **Requesting it is the single highest-value act
available today.**

---

## ⛔ What this dashboard does not do

⛔ **0** decisions · ⛔ **0** approvals · ⛔ **0** values invented · ⛔ **0** conflicts
resolved *(all four ratio values preserved)* · ⛔ **0** canonical documents amended ·
⛔ **0** gates recorded · ⛔ **0** debt closed · ⛔ **0** PRDs, ADRs, code or Figma ·
⛔ no commit, no push.

⭐⭐ **Design System status: ⛔ NOT APPROVED — gates 0 of 6.**
