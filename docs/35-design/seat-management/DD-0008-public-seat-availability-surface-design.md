<!-- LIBOORA Design Doc | DD-0008 | BC-04 Seating → §14B Public Library Preview -->

> This document is design documentation. It does not amend product requirements,
> architecture decisions, bounded-context ownership, permissions, configuration
> parameters or backend contracts.

# `DD-0008` — Public seat-availability surface design

| Field | Value |
|---|---|
| **Design Doc** | `DD-0008` — ⭐ number measured free before allocation *(§12.1)* |
| **Version** | **v0.1** — first issue |
| **Status** | ⛔⛔ **`PROPOSED`** — awaiting approval. ⛔ **NOT approved, NOT frozen, NOT authoritative.** ⛔ This document does **not** claim its own status |
| **Rank** | ⛔⛔ **UNRANKED.** Where this disagrees with any ranked document, **the ranked document wins and this Design Doc is the defect** |
| **Date** | 2026-09-19 |
| **Bounded context** | **`BC-04` Seating** `[CORE]` *(produces the state)* · **`BC-23` Search Indexing** *(carries it)* · **§14B Public Library Preview** *(renders it — ⛔ **not a bounded context**, `AR-1`)* |
| **Subject contracts** | ⭐ **`LIB-14B.11`**, **`LIB-14B.12`**, **`LIB-14B.14`** *(Approved — authoritative, **Tier V1**)* · `LIB-7.3`, `LIB-7.4` · `SEAT-FR-117`, `SEAT-FR-245` *(**FROZEN**)* |
| ⭐⭐ **Governing decisions** | **`ADR-0167`** *(edge + payload boundary)* · **`ADR-0168`** *(thresholds)* · **`ADR-0169`** *(denominator + zero-capacity)* · **`ADR-0170`** *(`E-35` registered, `SEAT-EVT-005` minted)* — ⭐ **all four `Accepted` 2026-09-19 and registered in `ADR-INDEX`** |
| **Owner** | **UX Architecture Owner** *(role, ⛔ never a personal name)* |
| **Authority for this issue** | ⭐ One-act **UX Architecture Owner** conferral, recorded **verbatim** at **§13.1**. ⛔ **Reverting on completion** *(`ADR-0033` §7.1)*. ⚠️ **No independent review claimed** |
| **Purpose** | ⭐ Specify the public seat-availability surface precisely enough that a Figma prototype or Flutter implementation could be built ⛔ **without inventing UX, thresholds, semantics, roles or authority** |
| ⛔ **Does NOT** | ⛔ Change thresholds, denominator or the zero-capacity rule · ⛔ implement or enable Public Live Occupancy · ⛔ create a role, permission, edge or event · ⛔ modify any frozen/approved PRD · ⛔ alter `ADR-0167`/`0168`/`0169`/`0170` · ⛔ contain or authorise code |

---

## 1. ⭐ Scope and the contract being rendered

### 1.1 What this surface is

⭐ A **single, read-only, unauthenticated** indicator on the public library
profile answering one question: ⭐⭐ ***"do they have room for me?"*** — the need
§14B itself names.

⭐ It renders **one field** — `availabilityState` — arriving over **`E-35`**.

### 1.2 ⛔⛔ The inviolable boundary

⭐ Restated from `ADR-0167` `D-3` and `ADR-0170` §25.3. ⛔ **Not relaxed, not
re-interpreted, not extended.**

| ⛔ The surface MUST NEVER expose | Authority |
|---|---|
| Exact **free-seat count** | `LIB-14B.12`, `ADR-0167` `D-3` |
| **Allocated-seat count** | `LIB-14B.11`, `ADR-0168` `D-3` |
| **Occupancy percentage** or any ratio | `LIB-14B.11`, `LIB-14B.13` |
| **Attendance / presence** information | ⭐⭐ **`LIB-14B.14`** |
| **Seat IDs**, per-seat status, floor/zone position | `LIB-14B.11`, `LIB-7.3`, `SEAT-XC-009` |
| **Student identity** in any form | `ID-2`, `ID-3`, `X-05`, `SEAT-FR-250` |
| **Live occupancy** *(count, %, or "busy/quiet")* | ⛔ **V2** — `LIB-14B.13`, `LIB-24.2`, `SEAT-XC-020` |

⭐⭐ **The payload is the whole event:** `{libraryId, availabilityState}`. ⛔ The
surface has **nothing else to render**, by construction — ⭐ which is the
strongest available privacy control *(§7)*.

---

## 2. ⭐⭐ State mapping — semantics preserved exactly

### 2.1 The mapping table

⭐⭐ **This is a 1:1 relabelling. ⛔ No UI state adds, merges, splits or
reinterprets an approved semantic state.**

| # | Approved semantic state *(`ADR-0168`/`0169`)* | Condition | ⭐ UI state token | Public label |
|---|---|---|---|---|
| 1 | `Available` | `C > 0` ∧ `A/C < 80%` | `availability.available` | **Available** |
| 2 | `Limited Availability` | `C > 0` ∧ `80% ≤ A/C < 100%` | `availability.limited` | **Limited Availability** |
| 3 | `Full` | `C > 0` ∧ `A/C = 100%` | `availability.full` | **Full** |
| 4 | `Full` *(zero-capacity rule)* | `C = 0` | ⭐⭐ `availability.full` — **the SAME token** | **Full** |

⭐ `A` = active allocations · `C` = **configured seat count in `BC-04`**.

### 2.2 ⭐⭐ Rows 3 and 4 MUST render identically — and that is a privacy requirement

⚠️⚠️ **A UI that distinguished "Full because 100% allocated" from "Full because
no seats configured" would leak `C = 0`** — ⭐ a fact about the library's
inventory that `ADR-0169` deliberately collapsed into a single public state.

⛔⛔ **No separate token, label, icon, tooltip, colour, test-id or analytics
event may distinguish them.** ⭐ They are **one UI state with two upstream
causes**, and the surface **cannot** tell them apart — ⭐⭐ because the payload
carries no capacity field.

### 2.3 ⛔ The surface computes nothing

⭐⭐ **The state arrives pre-computed from `BC-04`.** ⛔ The client **MUST NOT**
compute, recompute, validate, adjust, round or second-guess it, ⛔ and **MUST
NOT** hold `A` or `C` at all.

⭐ If an unrecognised value arrives, the surface renders the **unavailable**
state *(§4.3)* — ⛔ it does **not** guess a nearest state.

---

## 3. ⭐ Component specification

### 3.1 The component

| Property | Value |
|---|---|
| **Name** | `PublicSeatAvailabilityIndicator` |
| **Placement** | Public library profile, within the existing **Seats** section *(14B **L92**)* |
| **Input** | ⭐ Exactly one value: `availabilityState` ∈ {`available`, `limited`, `full`} ∪ {absent} |
| **Interactive?** | ⛔ **NO** — ⭐ static, non-focusable-as-control, ⛔ no tap target, ⛔ no expansion, ⛔ no drill-down |
| **Anatomy** | Status **dot/icon** + **text label** + optional short **helper line** |

⭐⭐ **Why non-interactive:** ⛔ any affordance implies detail behind it, and
⛔ **there is none** — ⭐ a tap revealing "42 of 60 seats" is precisely the
disclosure `LIB-14B.12` forbids. ⭐ Removing the affordance removes the
temptation.

### 3.2 The three states

| | ⭐ **Available** | ⭐ **Limited Availability** | ⭐ **Full** |
|---|---|---|---|
| **Label** | `Available` | `Limited Availability` | `Full` |
| **Meaning to a seeker** | Likely room | Filling up | No room now |
| ⭐ **Icon shape** *(non-colour carrier)* | ● filled circle | ◐ half circle | ○ ring / slash |
| **Colour role** | Success | Warning | Neutral-dense |
| ⚠️ **Exact hex** | ⛔ **TO BE DECIDED** — §9 `DG-2` | ⛔ **TBD** | ⛔ **TBD** |
| **Helper line** *(optional)* | *"Seats are generally available"* | *"Few seats remaining"* | *"No seats available right now"* |
| ⛔ **MUST NOT include** | ⛔ counts, %, "X of Y", progress bar, gauge, fill-meter | ⛔ same | ⛔ same |

⚠️⚠️ **Helper copy is CANDIDATE, not approved** — ⭐ §9 `DG-1`. ⛔ It must not
imply a quantity *("only 3 left")* or a trend *("filling fast")*: ⭐ both would
imply data the payload does not carry.

⭐⭐ **Colour is never the only carrier** — `ACCESSIBILITY.md` §2. ⭐ Shape **and**
text are always present.

### 3.3 ⛔⛔ Prohibited visual forms — named, because they are the likely mistakes

| ⛔ Forbidden | Why |
|---|---|
| Progress bar / fill meter | ⭐⭐ **Encodes a ratio geometrically** — a percentage by another name |
| Gauge, dial, donut | ⭐ Same |
| A 3-segment "traffic light" where segments **fill** | ⭐ Implies position within a range |
| Seat-grid / floor-plan thumbnail | ⛔ Per-seat status *(`LIB-14B.11`)* |
| Sparkline, trend arrow, "busier than usual" | ⛔ Temporal occupancy inference; ⛔ V2 territory |
| Numeric badge of any kind | ⛔ A count |
| Tooltip revealing "more detail" | ⛔ There is no lawful further detail |

⭐⭐ **The rule of thumb for a reviewer:** ⛔ *if the visual could be measured with
a ruler and converted to a number, it is forbidden.* ⭐ A discrete icon+label
cannot.

---

## 4. ⭐ Loading, unavailable and stale handling

### 4.1 Loading

| Property | Value |
|---|---|
| **Presentation** | Neutral skeleton or *"Checking availability…"*, ⛔ **no spinner-only** |
| ⭐⭐ **Default state** | ⛔⛔ **NONE.** ⭐ The surface **MUST NOT** default to `Available`, `Full`, or any state while loading |
| **Perceivable without motion** | ⭐ **YES** — `ACCESSIBILITY.md` §2 |

⭐⭐ **Why no optimistic default:** ⛔ defaulting to `Available` sends a seeker on
a wasted journey; ⛔ defaulting to `Full` costs the library a visit. ⭐ **Absence
of data is its own state.**

### 4.2 Data absent — the library publishes no availability

⭐ `LIB-14B.11` makes seat information **publishable**, ⛔ **not mandatory**
*(§14A.5: "Seat Capacity (**Optional**)")*.

⭐⭐ **If no `availabilityState` exists for a library, the component is OMITTED
ENTIRELY** — ⛔ **not** rendered as "Unknown", greyed, or a placeholder.

⭐ `LIB-14B.10`: *"A field with no owner **MUST NOT** be published."*
⭐⭐ **An empty control is itself a disclosure** — it tells a visitor the library
*has* seating it is not reporting. ⛔ Omission tells them nothing.

### 4.3 Error / unrecognised value

| Condition | Behaviour |
|---|---|
| Fetch fails | ⭐ Component **omitted**; ⛔ the rest of the profile renders normally |
| Unrecognised `availabilityState` | ⭐ Component **omitted** — ⛔ **never** coerced to a known state |
| ⛔ Error text | ⛔ **MUST NOT** name a context, edge, event, identifier or internal reason *(`ACCESSIBILITY.md` §2; `API-5`)* |

⭐⭐ **Fail closed to silence, ⛔ not to a guess.**

### 4.4 ⭐⭐ Staleness — the most delicate case

⭐ `E-35` is **transition-triggered** *(`ADR-0170` §25.2)*, so a projection may
legitimately be **quiet for hours** while a library sits in one state.

⚠️⚠️ **Therefore "last updated 3 hours ago" is NOT a staleness signal here — it
is the normal, healthy case.**

| Approach | Verdict |
|---|---|
| ⛔ Show a **timestamp** *("Updated 14:32")* | ⛔⛔ **FORBIDDEN** — ⭐⭐ a visible transition time is **occupancy timing**, and repeated observation reconstructs the fill curve. ⛔ `LIB-14B.14` bars *"arrival time of any individual"*; ⭐ a precise transition clock approaches that by inference |
| ⛔ Show **"live" / "real-time"** | ⛔ Overclaims; ⭐ the feed is transition-based |
| ⛔ Show a **freshness countdown** | ⛔ Same timing leak |
| ⭐⭐ **Show a non-temporal qualifier, or nothing** | ⭐ **RECOMMENDED** |

⭐⭐ **Recommended:** render the state with **no time qualifier at all**. ⭐ If a
staleness guard is later judged necessary, the lawful form is a **coarse,
non-numeric** fallback — ⛔ after a threshold the component is **omitted**
*(§4.2)*, ⛔ **not** annotated with an age.

⚠️ ⛔ **The staleness threshold value is NOT decided here** — §9 `DG-3`.

---

## 5. ⭐ Accessibility

⭐ Against `ACCESSIBILITY.md` §2. ⚠️ Its **Target** is *"TO BE DECIDED"* — ⛔ so
no numeric conformance level is claimed here *(§9 `DG-4`)*.

| # | Requirement |
|---|---|
| **A-1** | ⭐⭐ **Colour is never the only carrier** — icon **shape** + **text label** always present |
| **A-2** | ⭐ Exposed to assistive tech as a **status**, ⛔ not a control. Accessible name: the label; ⭐ role conveys "status" |
| **A-3** | ⭐ Announced on change **politely** — ⛔ never as an alert/assertive interruption. ⭐ A seat-availability change is not urgent |
| **A-4** | ⭐⭐ **Not keyboard-focusable** — ⛔ it takes no action *(§3.1)*; ⛔ a focus stop on a non-interactive element is a defect |
| **A-5** | ⭐ Label and helper text remain legible and un-truncated at **increased text size** and narrow widths; ⭐ text **wraps**, ⛔ never ellipsises the state word |
| **A-6** | ⭐ Loading, omitted and changed states perceivable **without motion**; ⭐ reduced-motion removes any transition |
| **A-7** | ⛔ **No icon-only rendering at any breakpoint** — ⭐ the text label is **mandatory everywhere** *(§6)* |
| **A-8** | ⭐ Error/absence states expose ⛔ **no internal identifier** |
| ⚠️ **A-9** | ⛔ **Contrast ratios TBD** — pending the `ACCESSIBILITY.md` target decision *(§9 `DG-4`)* |

⭐⭐ **A-7 is load-bearing.** ⛔ Compressing to a bare coloured dot on mobile
would breach **A-1** — ⭐ and this surface is **most used on mobile**.

---

## 6. ⭐ Responsive behaviour

⚠️ **No approved breakpoint set exists** — ⭐ `LIBOORA_DESIGN_SYSTEM_FINAL_AUDIT`
records the responsive artifact as **missing** *(`CP-D`)*. ⛔ **This document
does not invent one** — ⭐ it specifies behaviour **per class**, ⛔ not per pixel
*(§9 `DG-5`)*.

| Class | Layout | ⛔ Invariant |
|---|---|---|
| ⭐ **Mobile** *(narrow, single column)* | Icon + label **inline**, full-width row within the Seats section; helper line **below** or omitted | ⛔ Label **never** hidden; ⛔ **never** icon-only; ⛔ never truncated |
| ⭐ **Tablet** *(medium)* | Same, within the Seats card; helper line retained | ⛔ Same |
| ⭐ **Desktop** *(wide)* | Same, ⭐ may sit beside Total Seat Capacity if that field is published; helper line retained | ⛔ Same |

⭐⭐ **The component does not change meaning, granularity or detail across
breakpoints.** ⛔ There is **no "expanded desktop view"** — ⭐ **more screen space
does not entitle more data.** ⭐ That is the responsive rule that matters here.

---

## 7. ⭐⭐ Privacy and inference-risk review

⭐⭐ **The question: can a determined observer reconstruct occupancy from this
surface?**

### 7.1 Direct disclosure — ⭐ eliminated by construction

⭐ The payload carries **two fields**; ⛔ neither is numeric-quantitative. ⭐⭐ **The
UI cannot render a number it never receives.** ⛔ §3.3 additionally forbids
geometric encodings of a ratio.

### 7.2 ⭐⭐ Threshold inference — the real residual risk, stated honestly

⚠️⚠️ **The thresholds are published in `ADR-0168`, and total seat capacity is
publicly publishable** *(`LIB-7.3`, `LIB-14B.11` row 1)*. ⭐ So an observer who
sees **"Limited Availability"** and a published capacity of **60** can infer:

> ⭐ `48 ≤ allocated < 60`

⭐⭐ **This is a real inference channel, and I record it rather than claim the
design is leak-proof.**

**Why it is acceptable, and bounded:**

| # | Reason |
|---|---|
| 1 | ⭐⭐ **It is inherent in the approved contract, not introduced by this design.** ⭐ `LIB-14B.12` **mandates** a coarse state; publishing capacity is separately permitted. ⛔ No UI choice available to me removes it |
| 2 | ⭐ **The band is wide.** ⭐ `Available` spans `0–47` of 60 — ⭐⭐ a **48-seat** range. ⛔ That identifies no one |
| 3 | ⭐⭐ **It reveals nothing about a PERSON.** ⛔ `LIB-14B.14`'s concern is *"presence, absence or arrival time of **any individual**"*; ⭐ a band of allocations is **not** a presence signal — and ⭐⭐ **allocation ≠ occupancy** *(`SEAT-FR-245`: "a seat allocated to an absent student is allocated but not occupied")*, ⭐ so even a **perfect** allocation inference tells an observer **nothing about who is physically present** |
| 4 | ⭐ **`Full` is the narrowest inference** *(`A = C`)* — ⭐ but *"the library is full"* is exactly what `LIB-14B.12` **instructs** us to publish |

### 7.3 ⭐⭐ Temporal inference — mitigated by three design choices

⚠️ **The sharper risk is not a single reading but a TIME SERIES.** ⭐ An observer
polling every minute and logging transitions could estimate arrival rates.

| Mitigation | Effect |
|---|---|
| ⭐⭐ **No timestamp displayed** *(§4.4)* | ⛔ Removes the **precise transition clock** — the single most useful datum for a curve |
| ⭐⭐ **Transition-only emission** *(`ADR-0170` §25.2)* | ⭐ At most **~2–4** transitions per day; ⛔ an event-count observer learns almost nothing |
| ⭐ **No trend/sparkline/"busier than usual"** *(§3.3)* | ⛔ The surface never does the time-series work **for** the observer |

⚠️ ⭐ **Residual, disclosed:** ⛔ an observer may still **poll externally** and
build their own series. ⭐⭐ **No UI design can prevent that** — the mitigation
would be rate-limiting at the API edge, ⛔ **outside this document's authority**
*(§9 `DG-6`)*.

### 7.4 ⭐ The `C = 0` channel — closed

⭐ §2.2 makes rows 3 and 4 **visually identical**, so ⛔ **zero-capacity is not
distinguishable** from a genuinely full library.

### 7.5 Verdict

⭐⭐ **The surface adds NO inference channel beyond those already created by the
approved contracts**, and it **actively closes two** that a naive design would
have opened *(the timestamp, and the `C = 0` tell)*. ⛔ **Three residuals are
disclosed at §7.2, §7.3 and §9 `DG-6` rather than dismissed.**

---

## 8. ⭐ Files to create / update

⛔⛔ **NONE is created or updated by this document.** ⭐ This is the design
specification; ⛔ implementation is a **separate act by the Technical Owner**.

### 8.1 ⭐ Created by this act

| File | Status |
|---|---|
| ⭐ `docs/35-design/seat-management/DD-0008-public-seat-availability-surface-design.md` | ⭐⭐ **This document** — the only file created |

### 8.2 ⛔ Expected in a FUTURE implementation act — ⛔ NOT authorised here

⚠️⚠️ **Indicative only.** ⛔ Naming a path is **not** authorising its creation.

| Path | Purpose |
|---|---|
| `lib/app/library/public_profile/widgets/seat_availability_indicator.dart` | The component |
| `lib/app/library/public_profile/models/availability_state.dart` | ⭐ A **3-value enum**; ⛔ no count fields |
| `test/.../seat_availability_indicator_test.dart` | ⭐ Golden + semantics tests, incl. ⭐⭐ **a test asserting no digit renders** |
| `docs/35-design/seat-management/DD-0004-*` | ⚠️ **May** later cross-reference `DD-0008` — ⛔ **not amended here** |

⭐⭐ **A recommended test worth naming:** ⛔ assert the rendered widget tree
contains **no numeric character** in any state. ⭐ That converts §1.2 from a
promise into a **check**.

### 8.3 ⛔ Files deliberately NOT touched

⛔ Every frozen/approved PRD · ⛔ BC Map · ⛔ `ADR-0167`/`0168`/`0169`/`0170` ·
⛔ `DD-0004` · ⛔ `DD-0007` · ⛔ `ADR-INDEX` · ⛔ `DOCUMENTATION_BASELINE` ·
⛔ any `lib/`, `test/`, `tool/` file.

---

## 9. ⚠️⚠️ Remaining design gaps — ⛔ disclosed, NOT resolved

⭐⭐ **Each is named, scoped and routed. ⛔ None is silently decided.**

| ID | Gap | Why not resolved here | Owner | Blocks implementation? |
|---|---|---|---|---|
| ⭐ **`DG-1`** | **Helper-line copy** not approved *(§3.2)* | ⭐ Public-facing copy is **product/content**, ⛔ not UX structure | **Product Owner** | ⛔ **No** — ⭐ the helper line is **optional**; label alone is sufficient |
| ⭐ **`DG-2`** | **Exact colours / tokens** for the three states *(§3.2)* | ⚠️ The colour system is itself unratified — `LIBOORA_DESIGN_SYSTEM_FINAL_AUDIT` `CP-B` | **Design System Owner** | ⚠️ **Partially** — ⭐ shape+text carry meaning without it |
| ⭐⭐ **`DG-3`** | **Staleness threshold** — after how long is the state withheld *(§4.4)* | ⭐⭐ A **timing** decision with privacy implications; ⛔ inventing a number here would create an undecided temporal parameter | **Product Owner** *(+ Architecture)* | ⛔ **No** — ⭐ §4.4's default is **no time qualifier at all** |
| ⭐ **`DG-4`** | **Accessibility target** and contrast ratios *(§5 A-9)* | ⭐ `ACCESSIBILITY.md` **Target = "TO BE DECIDED"** | **Accessibility Owner** | ⚠️ **Partially** — ⭐ A-1…A-8 are specified and actionable |
| ⭐ **`DG-5`** | **Breakpoint pixel values** *(§6)* | ⭐ No responsive artifact exists — `CP-D` | **Responsive Design Owner** | ⛔ **No** — ⭐ §6 specifies per **class** |
| ⭐⭐ **`DG-6`** | **Polling rate-limit** for the public availability read *(§7.3)* | ⭐⭐ An **API-edge** control, ⛔ not a UI one; ⛔ outside UX authority | **Architecture Owner** *(+ Security)* | ⛔ **No** — ⭐ but it is the **only** remaining temporal-inference mitigation |
| ⭐ **`DG-7`** | Whether the indicator appears in **search results / discovery cards**, or only on the profile | ⭐ 14B **L92** places it in the **profile** projection; ⛔ extending it to `BC-23` result cards is a **scope** question | **Product Owner** | ⛔ **No** — ⭐ profile-only is the specified default |

⛔⛔ **No gap above is closed by inference, and none blocks a first
implementation of the profile indicator.**

---

## 10. ⭐ Traceability

| Design element | Source |
|---|---|
| Three states + labels | ⭐ `LIB-14B.12` *(verbatim: "Available, Limited, Full")* |
| Thresholds | ⭐ `ADR-0168` `D-1` |
| Denominator; `C = 0` ⇒ `Full` | ⭐ `ADR-0169` `D-1`, `D-3` |
| Payload boundary | ⭐ `ADR-0167` `D-3`; `ADR-0170` §25.3 |
| Transport | ⭐ `E-35`; `SEAT-EVT-005` *(`ADR-0170`)* |
| ⛔ No counts / % | ⭐ `LIB-14B.12`, `LIB-14B.11` |
| ⛔ No attendance derivation | ⭐⭐ `LIB-14B.14` |
| ⛔ No per-seat / identity | ⭐ `LIB-14B.11`, `SEAT-XC-009`, `SEAT-FR-250` |
| Component omitted when absent | ⭐ `LIB-14B.10`; §14A.5 *"Optional"* |
| ⛔ Not a config toggle | ⭐ `LIB-7.4` |
| Accessibility checks | ⭐ `ACCESSIBILITY.md` §2 |
| ⛔ No Public Live Occupancy | ⭐ `LIB-14B.13`, `LIB-24.2`, `SEAT-XC-020` |

---

## 11. ⛔ Options considered and REFUSED

| # | Option | ⛔ Refused because |
|---|---|---|
| 1 | A **progress bar** of fullness | ⛔⛔ Geometrically encodes a ratio — ⭐ a percentage by another name *(§3.3)* |
| 2 | **"3 seats left"** when nearly full | ⛔ An exact free-seat count — ⭐ the single most explicit `LIB-14B.12` breach |
| 3 | A **tap-to-expand** detail sheet | ⛔ There is no lawful further detail; ⭐ the affordance would promise a leak |
| 4 | **"Updated 2 minutes ago"** | ⛔⛔ Transition timing → occupancy curve *(§4.4)* |
| 5 | Distinguish **`C = 0`** as *"No seating"* | ⛔⛔ Leaks `C = 0`; ⭐ `ADR-0169` collapsed both into `Full` *(§2.2)* |
| 6 | Show **"Unknown"** when data is absent | ⛔ An empty control is itself a disclosure — ⭐ omit instead *(§4.2)* |
| 7 | Default to **`Available`** while loading | ⛔ Sends seekers on wasted journeys; ⭐ absence is its own state *(§4.1)* |
| 8 | **Icon-only** on mobile | ⛔ Breaches **A-1**/**A-7** — ⭐ colour alone would carry meaning |
| 9 | Recompute the state **client-side** from a richer payload | ⛔⛔ Would require a payload the boundary forbids *(§2.3)* |
| 10 | A **"busier than usual"** hint | ⛔⛔ Temporal occupancy inference; ⭐ and *"busy/quiet"* is expressly **V2** *(`SEAT-XC-020`, `SEAT-GAP-014`)* |

---

## 12. ⭐ Identifier hygiene

### 12.1 `DD-0008`

⭐ Measured before allocation: `DD-0001`…`DD-0007` exist; ⭐ **`DD-0008` returned
0 files** repository-wide. ⛔ No number reused. ⭐ Placed in
`docs/35-design/seat-management/` beside `DD-0004`, the `BC-04` surface design.

### 12.2 ⛔ Nothing minted

⛔ **0** `PERM-*` *(`AUTH-7.22` closed at zero)* · ⛔ **0** roles, offices, action
classes, scope classes · ⛔ **0** edges *(⭐ `E-35` **pre-existed** — `ADR-0170`)*
· ⛔ **0** events *(⭐ `SEAT-EVT-005` **pre-existed**)* · ⛔ **0** configuration
parameters · ⛔ **0** requirement identifiers.

⭐ The `DG-1`…`DG-7` tokens are **gap markers local to this document**, ⛔ not
registered identifiers.

---

## 13. ⭐⭐ Authority record

### 13.1 ⭐⭐ The conferral — VERBATIM

> ⭐⭐ **VERBATIM — human principal of this engagement, 2026-09-19:**
>
> ```
> "I confer the UX Architecture Owner office for the single act of designing the
> V1 public seat-availability surface using the already-accepted contracts in
> ADR-0167, ADR-0168, ADR-0169, and ADR-0170. [...] Produce: 1. Public surface UX
> specification. 2. Component/state specification for Available, Limited
> Availability, and Full. 3. Loading, unavailable/error, and stale-data handling.
> 4. Accessibility requirements. 5. Responsive behavior for mobile/tablet/desktop.
> 6. Privacy/inference-risk review, especially ensuring the UI cannot reconstruct
> exact occupancy. 7. Mapping from the approved availability state to the UI
> without changing its semantics. 8. Exact files that should be created/updated.
> 9. Any remaining design gaps, without resolving them silently. Record the design
> decision/artifact according to repository governance, but do not implement code.
> This is a single-act UX Architecture Owner conferral and reverts on completion.
> No independent review is claimed."
> ```

⭐ The full prohibition list *("Do NOT: change thresholds; change denominator
semantics; change the zero-capacity rule; implement Public Live Occupancy;
create roles or permissions; modify frozen/approved PRDs; alter
ADR-0167/0168/0169/0170; create a new architecture edge/event; commit or push")*
is reproduced at **§13.3** and each limb is answered there.

### 13.2 ⭐ Validity

| # | Element | Supplied? |
|---|---|---|
| 1 | First-person grant — *"**I confer**"* | ⭐ **YES** |
| 2 | Names the office — *"the **UX Architecture Owner** office"* | ⭐ **YES** |
| 3 | Single act — *"for the **single act** of designing the V1 public seat-availability surface"* | ⭐ **YES** |
| 4 | Scope basis — *"using the **already-accepted contracts**"* | ⭐ **YES** |
| 5 | Deliverables — **9** enumerated | ⭐ **YES** |
| 6 | Express prohibitions — **9** limbs | ⭐ **YES** |
| 7 | One-act, reverting | ⭐ **YES** |
| 8 | Review disclosure | ⭐ **YES** |
| 9 | ⛔ No commit/push | ⭐ **YES** |

⭐⭐ **9 / 9.** ⭐ `ADR-0080` **L7**; `ADR-0106`. ⛔ **No personal name recorded**
*(`PRD_OWNERSHIP_MODEL` §7 rule 4)*.

⭐⭐ **Element 9 of the deliverables was treated as binding:** *"Any remaining
design gaps, **without resolving them silently**"* — ⭐ §9 lists **seven**, each
routed to a named office.

### 13.3 ⭐ Each prohibition answered

| ⛔ Prohibition | Compliance |
|---|---|
| Change thresholds | ⭐ §2.1 reproduces `ADR-0168` exactly — ⛔ **0** changes |
| Change denominator semantics | ⭐ §2.1 — configured seat count, ⛔ unchanged |
| Change the zero-capacity rule | ⭐ §2.1 row 4 — `C = 0` ⇒ `Full`, ⛔ unchanged |
| Implement Public Live Occupancy | ⛔ §11 row 10; ⭐ stays **V2** |
| Create roles or permissions | ⛔ §12.2 — **0** |
| Modify frozen/approved PRDs | ⛔ §8.3 — **0** |
| Alter `ADR-0167`/`0168`/`0169`/`0170` | ⛔ §8.3 — **0** |
| Create a new edge/event | ⛔ §12.2 — ⭐ both **pre-existed** |
| Commit or push | ⛔ **Not performed** |

### 13.4 ⛔ Not reused

⛔ The `ADR-0167`/`ADR-0170` **Architecture Owner** conferrals *(both reverted;
different office)* · ⛔ the `ADR-0168`/`0169` **Product Owner** exercises ·
⛔ `ADR-0162`/`0164`/`0165`/`0166` **Authorization Owner** conferrals *(all
spent)*.

### 13.5 ⭐⭐ Reversion

⭐⭐ **Reverts on completion of this act** — the issuance of this document.
⛔⛔ **Any further design act — including resolving `DG-1`…`DG-7`, amending
`DD-0004`, or approving this document — requires a NEW conferral or the
competent office.**

⚠️ ⭐ **This document does not approve itself.** ⛔ It is `PROPOSED`; ⭐ approval is
a **Design Documentation Owner / Design Governance** act *(`DESIGN_GOVERNANCE.md`
§4 gate `G0`)*, ⛔ **not performed here** — ⭐ the same Author-≠-Owner refusal
recorded in `LIBOORA_DESIGN_AUTHORITY_CLOSURE_PACK` §10.

---

## 14. Change history

| Version | Date | Change |
|---|---|---|
| ⭐ **v0.1** | 2026-09-19 | ⭐⭐ **Created as `PROPOSED`. Specifies the V1 public seat-availability surface against the four accepted contracts `ADR-0167`/`0168`/`0169`/`0170`** — ⭐ a **1:1 semantic mapping** *(§2)*, ⛔ **no UI state adds, merges, splits or reinterprets an approved state**. ⭐⭐ **THE `C = 0` CASE AND THE `A = C` CASE RENDER IDENTICALLY, AND THAT IS A PRIVACY REQUIREMENT** *(§2.2)* — ⛔ distinguishing them would leak `C = 0`; ⭐ they are **one UI state with two upstream causes**, and the surface **cannot** tell them apart because the payload carries no capacity field. ⭐⭐ **THE COMPONENT IS NON-INTERACTIVE BY DESIGN** *(§3.1)* — ⛔ any affordance implies detail behind it and **there is none**; ⭐ removing the affordance removes the temptation. ⭐⭐ **SEVEN VISUAL FORMS ARE EXPRESSLY FORBIDDEN** *(§3.3)* — progress bar, gauge, filling traffic-light, seat grid, sparkline, numeric badge, detail tooltip — with the reviewer's rule of thumb: ⛔ *if the visual could be measured with a ruler and converted to a number, it is forbidden.* ⭐⭐ **NO OPTIMISTIC DEFAULT WHILE LOADING** *(§4.1)* and ⭐⭐ **OMISSION RATHER THAN "UNKNOWN" WHEN DATA IS ABSENT** *(§4.2)* — ⛔ an empty control is itself a disclosure. ⭐⭐⭐ **THE STALENESS FINDING IS THE MOST CONSEQUENTIAL DESIGN CALL** *(§4.4)* — because `E-35` is **transition-triggered**, hours of silence are the **healthy** case, so a *"last updated"* timestamp is ⛔⛔ **FORBIDDEN**: a visible transition clock is **occupancy timing**, and repeated observation reconstructs the fill curve. ⭐ **NINE ACCESSIBILITY REQUIREMENTS** *(§5)*, with **A-7** *(⛔ never icon-only, at any breakpoint)* load-bearing because compressing to a coloured dot would breach the colour-alone prohibition on the surface's **most-used** form factor. ⭐ **RESPONSIVE BEHAVIOUR SPECIFIED PER CLASS, ⛔ NOT PER PIXEL** *(§6)* — ⭐ no breakpoint artifact exists *(`CP-D`)*, and ⭐⭐ **more screen space does not entitle more data**. ⭐⭐ **THE PRIVACY REVIEW DISCLOSES A REAL RESIDUAL RATHER THAN CLAIMING LEAK-PROOF** *(§7.2)* — ⭐ because thresholds are published **and** total capacity is publicly publishable, *"Limited Availability"* + capacity 60 implies `48 ≤ allocated < 60`; ⭐⭐ **inherent in the approved contract, not introduced by this design**, the band is **48 seats wide**, and ⭐⭐ **allocation ≠ occupancy** *(`SEAT-FR-245`)* so even a perfect inference reveals **nothing about who is physically present**. ⭐ **Temporal inference is mitigated three ways** *(§7.3)* — no timestamp, transition-only emission, no trend affordance — ⛔ with external polling disclosed as unmitigable by UI and routed as **`DG-6`**. ⭐⭐ **THE DESIGN CLOSES TWO CHANNELS A NAIVE VERSION WOULD HAVE OPENED** — the timestamp and the `C = 0` tell. ⭐ **SEVEN GAPS DISCLOSED AND ROUTED, ⛔ NONE RESOLVED SILENTLY** *(§9)* — `DG-1` copy *(Product)*, `DG-2` colour tokens *(Design System)*, `DG-3` staleness threshold *(Product + Architecture)*, `DG-4` accessibility target *(Accessibility)*, `DG-5` breakpoints *(Responsive)*, `DG-6` polling rate-limit *(Architecture + Security)*, `DG-7` discovery-card scope *(Product)*; ⭐ **none blocks a first implementation**. ⭐ **TEN OPTIONS REFUSED** *(§11)*. ⛔ **0** files created or updated other than this one · ⛔ **0** `PERM-*` *(`AUTH-7.22` closed at zero)* · ⛔ **0** roles, offices, action classes or scope classes · ⛔ **0** edges or events *(⭐ `E-35` and `SEAT-EVT-005` **pre-existed**)* · ⛔ **0** thresholds, denominator or zero-capacity changes · ⛔ **0** frozen/approved PRDs modified · ⛔ **0** ADRs altered · ⛔ **0** lines of code · ⛔ **Public Live Occupancy remains V2**; `SEAT-CFG-017` **HELD**; `SEAT-GAP-014` **OPEN** · ⛔ **no commit, no push**. ⚠️ **This document is `PROPOSED` and does NOT approve itself** — ⭐ gate `G0` is a **Design Documentation Owner** act. ⭐⭐ **The conferral has REVERTED ON COMPLETION.** |
