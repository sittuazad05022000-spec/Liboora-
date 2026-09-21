<!-- LIBOORA Design Documentation | Human Decision Sheet | 2026-09-19 -->

> Design documentation. ⛔ Does **not** amend PRDs, ADRs, permissions, roles, app
> boundaries, BC ownership or backend contracts.

# LIBOORA — Human Decision Sheet
## Final design direction + Student Experience

| Field | Value |
|---|---|
| **Status** | ⛔⛔ **PROPOSED** · ⛔ **0 decisions taken** · ⛔ **nothing approved automatically** |
| **Purpose** | ⭐ One sheet a human can work through and mark **ACCEPT** or **CHANGE** |
| **Proposed direction** | ⭐⭐ **"Calm Premium Study Space"** |
| **Authority** | ⭐ **Founder/Product Authority** is final *(`DESIGN_GOVERNANCE.md` L9; §3 rule 6)* |

---

# PART 1 — The proposed direction

## 1.1 ⭐⭐ "Calm Premium Study Space"

⭐ **One design system, two personalities.** The operational apps stay calm and dense;
the Student App gets warmth, depth and a sense of personal space — ⛔ **without** becoming
a different product.

| | **APP 1 — Student** | **APP 2 — Library** | **APP 3 — Platform** |
|---|---|---|---|
| Feels like | ⭐ *"Study + Library + **my** space"* | ⭐ A fast operational console | ⭐ A read-only ledger |
| Density | Generous, breathing | Dense, efficient | Dense |
| Depth | ⭐ **2.5D layering, soft shadows** | Flat + hairline | Flat |
| 3D | ⭐ **Selective hero moments only** | ⛔ **None** | ⛔ **None** |
| Motion | Subtle micro-interactions | Functional only | Minimal |
| ⭐ Shared | **Same tokens, same components, same a11y floor** | — | — |

⛔ **NOT:** generic admin dashboard · generic education app · childish gamification ·
excessive glassmorphism · heavy 3D game UI.

## 1.2 ⭐ The visual hierarchy — a hard budget, not a vibe

| Layer | Share | Where | Rule |
|---|---:|---|---|
| ⭐ **2D** | **~70%** | All operational content: lists, forms, figures, status | ⭐⭐ **Always the information layer.** ⛔ Never decorated into illegibility |
| ⭐ **2.5D** | **~25%** | Layered cards, soft elevation, perspective illustration, dimensional seat map | ⭐ **The personality layer** |
| ⭐ **3D** | ⛔ **≤5%** | ⭐ **Four approved moments only** *(§1.3)* | ⛔ Never full-screen, never required to complete a task |

⭐ **This mirrors `VISUAL_LANGUAGE.md`'s already-`CONFIRMED` direction** — *"lightweight
premium 2.5D"*, *"About 70% clean 2D"* — and ⭐ `DESIGN_SYSTEM.md` §2's **CONFIRMED**
*"About 10% premium 3D-style illustration… keep the functional UI 2D-first."*

⚠️ **Note the discrepancy, disclosed not resolved:** `DESIGN_SYSTEM.md` says **~10%** 3D;
I propose **≤5%** for the *student* app and **0%** elsewhere. ⭐ Mine is **stricter**, so
it does not breach the confirmed direction — ⛔ but the owner should confirm which number
governs.

## 1.3 ⭐ The only four places 3D is proposed

| # | Moment | Product value | Fallback on low-end |
|---|---|---|---|
| 1 | ⭐ **Seat / library visualisation** | ⭐ A student genuinely needs to understand *where* a seat is — ⭐ depth communicates spatial truth | ⭐ **2D floor plan**, same data |
| 2 | ⭐ **Student hero object** *(a desk/lamp/book vignette on the dashboard)* | ⭐ Ownership and identity — the "my space" feeling | ⭐ **Flat illustration** |
| 3 | ⭐ **Study-space representation** in onboarding | ⭐ Explains what a library membership *is* | ⭐ **Static image** |
| 4 | ⭐ **Selected empty states** | ⭐ Turns a dead end into a welcome | ⭐ **Flat illustration** |

⛔ **Everywhere else: 0% 3D.** ⛔ No full-screen scenes · ⛔ no WebGL-style experiences ·
⛔ no constant parallax · ⛔ no 3D behind text.

⭐⭐ **Every 3D moment must have a declared 2D fallback that loses no information.** ⭐ If
the fallback loses data, the 3D was carrying meaning it should not have carried.

## 1.4 ⭐ Student surfaces — with their authority stated

⭐⭐ **Each surface names App · Role · Scope · Permission source · Cross-app dependency**,
per the QA rule. ⛔ **Design does not grant any of it.**

| Surface | App / Role | Authority status |
|---|---|---|
| ⭐ **Personal dashboard** | APP 1 · Student · `self` | ⭐ Existing — `student_dashboard.dart` builds Today/Plan/Fees |
| ⭐ **Seat experience** | APP 1 · Student · `self` | ⭐ `SEAT-PO-005` *(self-booking, `C` on `SEAT-CFG-008`)*, `SEAT-PO-022`, `SEAT-PO-023`, `SEAT-PO-024` *(`self` only)* |
| ⭐ **Attendance streak / progress** | APP 1 · Student · `self` | ⭐ `PRD-006` §19.2 — *"View own attendance \| `student` \| `self`"* |
| ⭐ **Membership status** | APP 1 · Student · `self` | ⭐ Existing — `StudentPlanPage` |
| ⭐ **Study statistics** | APP 1 · Student · `self` | ⚠️ ⭐ **Only from facts the student may already read** — ⛔ **no new metric, no new read** |
| ⚠️ **AI Study Coach** | APP 1 · Student · `self` | ⛔⛔ **SLOT ONLY — see §1.5** |
| ⭐ **Parent view** | APP 1 · Parent · `guardianOf` | ⭐ `PRD-006` **L1983** — *"subject to `ATT-CFG-024`"*; ⚠️⚠️ **`ATT-CFG-024` is now AUTHORIZED** *(`ADR-0162`)*, ⛔ **but authorized ≠ designed** |

## 1.5 ⚠️⚠️ AI Study Coach — what the evidence actually supports

⭐ **Measured, because the brief says *"where already authorized"*:**

| Source | Says |
|---|---|
| ⭐ `LIBOORA_ENTERPRISE_ARCHITECTURE` **L1074** | **`AI Study Coach (V1)`** → Study Plans **(V1)** · Daily Goals **(V1)** · Progress Tracking **(V1)** · Focus Suggestions (V2) · Revision Planner (V2) |
| ⭐ `MASTER_PRD` **L427** | *"Supported assistants: Library Assistant · **Study Coach** · Business Advisor"* |
| ⛔⛔ `PRD_REGISTRY` **L248** | **`PRD-011` AI Super Assistant · `BC-27` · V1 · `PLANNED`** — ⛔ **the PRD does not exist** |

⭐⭐ **Conclusion: the Study Coach is a CONFIRMED V1 *ambition* with ⛔ NO written
requirements.** ⭐ So the honest design act is a **reserved slot**, ⛔ not a feature:

- ⭐ **Reserve the dashboard position** and its visual weight, so adding it later is not a redesign
- ⛔ **Design no prompt, no chat, no suggestion copy, no AI affordance**
- ⛔ **Show nothing** until `PRD-011` exists
- ⭐⭐ And the binding constraints are already written and **must** shape it when it comes:
  **`MP-GBR-31`** *(AI-initiated domain writes need a **Human-in-the-Loop approval record**
  — "**No exceptions in V1**")* and **`MP-GBR-32`** *(**PII redacted before egress to any
  model**)*

⚠️ **This is the one place I have deliberately under-delivered against the brief.**
⭐ Designing coach surfaces now would invent product behaviour that no PRD authorises.

## 1.6 ⛔ Delight never overrides these

⛔ Accessibility floor · ⛔ performance floor · ⛔ information hierarchy · ⛔ repository
governance · ⛔ approved requirements · ⛔ the **3-app boundary** · ⛔ role/permission rules.

⭐⭐ **Concretely:** ⛔ a streak animation may never delay the attendance fact · ⛔ a 3D seat
may never be the *only* way to pick a seat · ⛔ a hero illustration may never push the
next action below the fold · ⛔⛔ **a celebratory surface may never imply an entitlement the
student does not hold.**

---

# PART 2 — The 9 decisions

> ⭐ Mark one box each. ⛔ **Unmarked = not decided.** ⛔ **I have marked nothing.**

---

## D-1 · Colour tokens

**1. Proposed decision**
⭐ `accent-ink` **`#92400E`** *(new — text/icons)* · ⭐ `accent-fill` **`#F5A524`** *(kept —
fills only, always with `textPrimary`)* · ⭐ `text-muted` **`#5F6585`** *(replaces
`#6B7194`)* · ⭐ `border/decorative` **`#E3E6F0`** *(kept)* + `border/control` **`#7F87A6`**
*(new)* · ⭐ **7 tokens unchanged** *(brand, brandDark, success, warning, danger, info,
textPrimary)*.

**2. Why**
⭐ Three measured failures make the current set unusable as-is, and ⭐ the fix preserves the
Indigo/Amber identity rather than replacing it.

**3. Evidence** *(WCAG 2.1, computed against **both** `#FFFFFF` and `#F7F8FC`)*

| Token | Measured | Verdict |
|---|---|---|
| `accent #F5A524` as text | **2.04 / 1.92** | ⛔ fails |
| white on `#F5A524` | **2.04** | ⛔ unusable |
| `textPrimary` on `#F5A524` | **8.42** | ⭐ the correct pairing |
| `textMuted #6B7194` | **4.76 card / 4.48 surface** | ⛔ ⭐ **passes where designers check, fails where users read** |
| `border #E3E6F0` | **1.17** | ⭐ lawful for dividers *(1.4.11 exempts decorative)*; ⛔ fails for control borders |
| ⭐ `#92400E` | **7.09 / 6.68** | ⭐ AA + AAA on card |
| ⭐ `#5F6585` | **5.70 / 5.37** | ⭐ clears both |
| ⭐ `#7F87A6` | **3.34** | ⭐ clears 3:1 |

⚠️⚠️ **`#B45309` scores 5.02/4.73 and I rejected it — it is byte-identical to `warning`.**
⛔ A semantic collision; `DESIGN_GOVERNANCE` §3 rule 4 forbids the convenient close.

**4. Impact on Student UX**
⭐ **Positive.** Amber becomes a *celebration fill* — streak badges, milestone chips —
which is exactly the premium-warmth role it should play, ⛔ instead of failing as small
text. ⚠️ Secondary text gets slightly heavier.

**5. Performance / accessibility**
⭐ **Performance: none.** ⭐ **Accessibility: fixes 3 real failures.**

**6. Owner** — **Design System Owner** *(+ Accessibility Owner countersign)*

**7. ☐ ACCEPT ☐ CHANGE → ______________________**

---

## D-2 · Typeface — ⭐⭐ including the Devanagari determination

**1. Proposed decision**
⭐ **Two-part:**
**(a)** ⭐⭐ **DETERMINATION REQUIRED — is Indic-script (Devanagari) student-name display in V1?**
**(b)** ⭐ Then: **Noto Sans + Noto Sans Devanagari** if **YES**; **Inter** if **NO**.

**2. Why**
⭐ The typeface cannot be chosen before the script question is answered — ⛔ a family
without Devanagari is disqualified if Hindi names must render.

**3. Evidence** — ⚠️⚠️ **and this is a genuine gap, reported not guessed**

| Probe | Result |
|---|---|
| ⭐ *"devanagari \| unicode \| hindi \| multilingual \| i18n \| localis(z)ation \| script"* across `Student_Identity_PRD_v1` + `Student_Management_PRD_v1` | ⛔⛔ **ZERO substantive hits** *(the only two matches are the word "script" meaning a shell script, and unrelated prose)* |
| ⭐ `MP-CON-12` | *"**India-first**: DLT template registration, DPDP Act applicability, INR, IST, and a network-unreliable operating environment"* |
| ⭐ Skill `--domain typography` | Returned *Fira Sans* / *Lexend* — ⛔ **its dataset records no script coverage at all** |

⭐⭐ **So: the PRDs are SILENT on script, while `MP-CON-12` makes the product explicitly
India-first.** ⚠️ ⛔ **Silence is not a "no", and India-first is not a "yes".** ⭐ Only the
Product Owner can settle it.

⭐ **Selection criteria if YES:** open licence *(OFL/Apache)* · **matched Devanagari
companion** · unambiguous `0/O`, `1/l/I` at 14px · tabular figures · ≥4 weights · small
file size. ⭐ **Noto Sans + Noto Sans Devanagari is the only shortlist entry that satisfies
the pairing criterion by construction.**

**4. Impact on Student UX**
⚠️⚠️ **Potentially severe.** ⭐ A student whose name renders as **tofu boxes (□□□)** on
their own dashboard is the **opposite** of "my personal space". ⭐ This is the single
highest-risk item on the sheet for student experience.

**5. Performance / accessibility**
⚠️ Bundling two families costs app size on low-end Android; ⭐ mitigate with subsetting.
⭐ Accessibility: numeral disambiguation matters for seat and enrollment numbers.

**6. Owner** — ⭐ **(a) Product Owner** *(scope)* → ⭐ **(b) Design System Owner**
*(family)*; licence check **Design Governance Owner**

**7. (a) Indic-script names in V1? ☐ YES ☐ NO ☐ DEFER**
   **(b) ☐ ACCEPT the conditional rule ☐ CHANGE → ______________________**

---

## D-3 · Radius scale

**1. Proposed decision** — ⭐ **8 / 12 / 16**; ⛔ **retire 14 and 18**; pill = status chips only.

**2. Why** — ⭐ Three values with one documented rationale between them is not a scale.

**3. Evidence** — ⭐ Measured in `theme.dart`: **7** `BorderRadius.circular()` calls across
**3** values — **12** *(5 sites)*, **14** *(1)*, **18** *(1)* — ⛔ **no `LiblRadius` class**
*(`DBT-005`)*. ⭐ 12 already dominates; ⛔ no document states why 14 or 18 exist.

**4. Impact on Student UX** — ⭐ Slightly softer, more consistent cards. ⭐ Consistency is
what makes layered 2.5D cards read as *one* system rather than several.

**5. Performance / accessibility** — ⭐ **None.**

**6. Owner** — **Design System Owner**

**7. ☐ ACCEPT ☐ CHANGE → ______________________**

---

## D-4 · Accessibility minimums

**1. Proposed decision** — ⭐ **48×48dp** targets · **≥8dp** spacing · **4.5:1** text ·
**3:1** large & non-text · **2dp** visible focus · **200%** text scale · ⭐⭐ **icon + text
on every status** · reduced motion honoured.

**2. Why** — ⭐ Liboora is Android-first; these are the Android-correct floors.

**3. Evidence** — ⭐ The skill's own result: *"Use 44pt on iOS and **48dp on Android**"*,
with its explicit warning *"**Don't** assume native 44pt or 48dp guidance defines web
conformance"* ⇒ ⭐ the web-only **24 CSS px** figure is **not** governing here.
⭐ WCAG 2.1 SC 1.4.3 / 1.4.4 / 1.4.11 / 2.3.3 / 2.4.7.
⚠️ ⭐ **Also measured: `success` and `warning` have IDENTICAL luminance (5.02/4.73)** —
⭐⭐ which is precisely why status can never be colour alone.

**4. Impact on Student UX**
⭐ **Positive and specific:** students use their own phones one-handed, often outdoors in
glare. ⚠️ **Tradeoff:** 48dp targets cost vertical space — ⭐ **fewer items per screen**.
⭐ For the student app that is *fine*; ⭐ for the dense staff table it is the real tension,
resolved as **≥48dp on touch, 36px only for pointer-only ≥905dp**.

**5. Performance / accessibility** — ⭐ Performance neutral. ⭐⭐ **This IS the
accessibility floor.**

**6. Owner** — **Accessibility Owner**

**7. ☐ ACCEPT ☐ CHANGE → ______________________**

---

## D-5 · Responsive breakpoints

**1. Proposed decision** — ⭐ **< 600dp** · **600–904dp** · **≥ 905dp**.

**2. Why** — ⭐ An external citable standard beats an invented number.

**3. Evidence** — ⭐ **Material 3 window size classes**; Liboora is Flutter/Android and the
code already uses `LayoutBuilder`. ⚠️ **CONFLICT:** the skill's **375/768/1024/1440 px** is
⛔ CSS-pixel web guidance — ⭐ **LIBOORA/Flutter preserved, conflict recorded.**

**4. Impact on Student UX** — ⭐ Most students are < 600dp ⇒ ⭐ **the single-column
student experience is the primary design**, ⛔ not a shrunken tablet layout.

**5. Performance / accessibility** — ⭐ Neutral; ⭐ prevents horizontal-scroll failures.

**6. Owner** — **Responsive Design Owner**

**7. ☐ ACCEPT ☐ CHANGE → ______________________**

---

## D-6 · Performance budgets — ⭐⭐ including the V1 device profile

**1. Proposed decision**
⭐ **Two-part:**
**(a)** ⭐⭐ **DETERMINE the V1 target device profile.** ⭐ **Proposed:** **Android 8.0
(API 26)+**, **2 GB RAM**, **720×1600**, **intermittent 3G**.
**(b)** ⭐ Then derive numeric SLOs into **`NFR Budgets (V1)`**.

**2. Why** — ⭐ Every "is this fast enough?" question is unanswerable without a named
device. ⭐ And the 2.5D/3D budget in Part 1 **cannot be validated** without one.

**3. Evidence**

| Source | Says |
|---|---|
| ⭐ `MP-CON-12` | *"India-first… and a **network-unreliable operating environment**"* — ⭐⭐ **the network half of the profile is already CONFIRMED governance** |
| ⛔ `PERFORMANCE.md` **L8** | *"numeric budgets are **TO BE DECIDED**"* |
| ⛔ `MASTER_PRD` **L663** | *"Targets are deliberately not set here; they belong to… **NFR Budgets**"* |
| ⛔ `MP-DEP-08` | Names **`NFR Budgets`** a dependency — ⛔ **the document does not exist** |
| ⚠️ `android/app/build.gradle.kts` | `minSdk = flutter.minSdkVersion` — ⛔ **inherited from Flutter, ⛔ not a product decision** |

⚠️⚠️ **My Android-8/2GB proposal is an INFERENCE from `MP-CON-12`'s India-first posture,
⛔ NOT a repository fact.** ⭐ It is offered so the owner has something concrete to accept
or correct — ⛔ **it must not be cited as evidence.**

⭐ **What I will NOT invent:** p95 latency · cold-start · bundle size · image weight.
⭐ **What is arithmetic, not a target:** 16 ms = 60 fps; <100 ms = perceived instant.

**4. Impact on Student UX**
⭐⭐ **This decision directly governs how much 2.5D/3D the student app may have.**
⭐ On a 2 GB Android 8 device: ⭐ **≤5% 3D with 2D fallbacks is viable**; ⛔ full-screen 3D
is not. ⭐ A richer profile would permit more.

**5. Performance / accessibility**
⭐⭐ **This IS the performance floor.** ⚠️ Without it, *"is this too heavy?"* is
unfalsifiable and the 3D budget is unenforceable.

**6. Owner** — ⭐ **(a) Technical Owner** *(device profile)* → ⭐ **(b) Governance Owner +
Design Performance Owner** *(`NFR Budgets (V1)`)*

**7. (a) Device profile: ☐ ACCEPT Android 8 / 2 GB / 3G ☐ CHANGE → ____________**
   **(b) ☐ Commission `NFR Budgets (V1)` ☐ DEFER**

---

## D-7 · Dark mode

**1. Proposed decision** — ⭐ **Out of V1.**

**2. Why** — ⭐ No source requires it; semantic tokens make it a later **remap, not a
rewrite**.

**3. Evidence** — ⭐ **0** LIBOORA sources require dark mode *(measured)*. ⭐ The skill's
own output lists *"Dark mode by default"* under ⛔ **AVOID**.

**4. Impact on Student UX** — ⚠️ **A real loss, stated honestly.** ⭐ Students study at
night; dark mode is an expected premium affordance and its absence will be noticed.
⭐ Mitigation: ship light-only **but** ⛔ **never hard-code a hex** — then dark mode is one
token file later.

**5. Performance / accessibility** — ⭐ Neutral. ⚠️ Some low-vision users prefer dark;
⭐ 200% scaling and 4.5:1 contrast serve them meanwhile.

**6. Owner** — **Design Vision Owner**

**7. ☐ ACCEPT (out of V1) ☐ CHANGE → ______________________**

---

## D-8 · `C-4` Change history — ⭐ including removal from V1

**1. Proposed decision** — ⭐ **Two options; ⛔ I recommend neither.**
⭐ **Option A** — allocate a reader *(a **governance** act)*.
⭐ **Option B** — ⭐⭐ **remove `C-4` from V1**, which closes `DD7-GAP-008` without
allocating anything.

**2. Why** — ⛔ A design document **cannot** allocate a reader. ⭐ But it *can* observe
that the surface may simply not be required in V1.

**3. Evidence**

| Source | Says |
|---|---|
| ⭐⭐ `AUTH-10.23` | *"A **library** MUST be able to view audit only for actions within its own context"* — ⭐⭐ **names a TENANT, ⛔ not a ROLE** |
| ⭐ `AUD-FR-014`/`015`/`016` | Confine every query to one tenant; ⛔ **no role named** |
| ⭐⭐ `AUD-XC-005` | *"The module **MUST NOT** make, store, cache or evaluate an **authorisation decision**"* |
| ⭐ `CNF-BR-006` | History **SHALL** be *reconstructible from the audit trail* — ⭐⭐ ⛔ **it does NOT require a `BC-25` surface** |
| ⭐ `CNF-XC-010` | Bars `BC-25` from a query surface |

⭐⭐ **The gap is exact: scope is settled, the actor is not.**
⚠️⚠️ **The tempting inference — *"`TR-1` Owner, because Owner sees everything"* — is
REFUSED.** ⛔ That is derivation from seniority, barred by **`AUTH-7.28`** *(no hierarchy)*
and **`AP-4`** *(no permission from naming or seniority)*.

**4. Impact on Student UX** — ⭐ **None.** `C-4` is an **APP 2** staff surface.

**5. Performance / accessibility** — ⭐ **None.**

**6. Owner** — ⭐ **Authorization Owner + `PRD-016` Owner** — ⛔ **NOT a design office**

**7. ☐ Option A — allocate reader: ____________ ☐ Option B — remove `C-4` from V1 ☐ HOLD**

---

## D-9 · Adopt the direction and the system as a whole

**1. Proposed decision** — ⭐ Adopt **"Calm Premium Study Space"** + the Master Design
System, **as PROPOSED**.

**2. Why** — ⭐ Piecemeal adoption risks an incoherent system; ⭐ D-1/D-3/D-4/D-5/D-7
interlock.

**3. Evidence** — ⭐ `DESIGN_GOVERNANCE.md` L10: *"AI authors and reviews; **AI is not
final business authority**"*; ⭐ §3 rule 6: Founder/Product Authority is final.

**4. Impact on Student UX** — ⭐⭐ **This is the decision that authorises the student app
to have a personality at all.**

**5. Performance / accessibility** — ⭐ Governed by D-4 and D-6; ⛔ the direction cannot
override either.

**6. Owner** — ⭐ **Founder/Product Authority**

**7. ☐ ACCEPT ☐ ACCEPT WITH CHANGES → ____________ ☐ REJECT**

---

# PART 3 — Summary

## 3.1 Ready to decide now — **5**
⭐ **D-1** colours · **D-3** radius · **D-4** accessibility · **D-5** breakpoints ·
**D-7** dark mode. ⭐ *One session, three owners.*

## 3.2 Need a fact first — **2**
⚠️ **D-2** → *Are Indic-script names in V1?* **(Product Owner)**
⚠️ **D-6** → *What is the V1 target device?* **(Technical Owner)**

## 3.3 Not a design decision — **1**
⛔ **D-8** → **Authorization Owner + `PRD-016` Owner**, or remove `C-4` from V1.

## 3.4 Final — **1**
⭐ **D-9** → **Founder/Product Authority.**

## 3.5 ⛔ What remains blocked regardless
⛔ **`IMPL-020`** SMS/DLT — ⭐ **nothing can authenticate**; multi-week external lead time
⛔ Gate 3 — **9** boundary violations · ⛔ `ADR-0012` debt **expires 2026-10-31**
⛔ **19** held `BC-25` parameters *(6 externally gated by `LR-01`)*
⛔ **`PRD-011`** AI Super Assistant is **`PLANNED`** — ⛔ no AI surface may be designed

---

## What this sheet does **not** do

⛔ **0** decisions taken · **0** tokens ratified · **0** `DD7-GAP-*` closed · **0** PRDs,
ADRs, governance documents, permissions, `PERM-*`, roles, scopes, architecture, Figma or
code touched · ⛔ no commit, no push.

---

# WAITING FOR HUMAN DECISIONS
