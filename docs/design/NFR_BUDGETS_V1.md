<!-- LIBOORA Design Documentation Foundation | 2026-10-01 -->

> This document is design governance and documentation. It does not amend product
> requirements, architecture decisions, bounded-context ownership, permissions, or
> backend contracts.

# NFR Budgets (V1)

| Field | Value |
|---|---|
| **Status** | ⭐ **DECIDED** — five V1 hard ceilings/targets adopted by explicit owner decision, 2026-10-01 |
| **Owner** | ⭐ **Governance Owner** *(document admission — `PRD_OWNERSHIP_MODEL.md` L418)* |
| **Approver / decision** | ⭐ **Governance Owner + Design Performance Owner**, with Engineering input acknowledged · explicit owner decision 2026-10-01 adopting the five values below |
| **Scope** | ⭐ **V1 numeric NFR budgets** for the five categories named at `PERFORMANCE.md` §5 · ⛔ **no additional budgets are invented by this document** |
| **Target class** | ⭐ All five budgets are **measured against the confirmed V1 target class** at [`design-decisions/DDR-0034-cp-a-v1-device-profile-confirmed-by-technical-owner.md`](design-decisions/DDR-0034-cp-a-v1-device-profile-confirmed-by-technical-owner.md) (Technical Owner, ACCEPTED 2026-10-01): **Android 8.0 / API 26 · ~2 GB RAM · 720×1600 · primarily 4G / degraded connectivity where documented** |
| **Closes** | ⭐ **`FA-GAP-010`** (V1 numeric SLOs) · ⭐ **`DD7-GAP-009`** ("no authoritative NFR budget exists") · ⭐ **`CP-E`** (closure pack §9) |

## 1. The five adopted budgets (V1 hard ceilings / targets)

| # | Budget | **Adopted value** | Unit | Measurement definition |
|---|---|---|---|---|
| 1 | **Image weight** | ⭐ **Maximum 200 KB** per displayed raster asset · **SVG permitted as the alternative vector format** | KB / asset | ⭐ **200 KB is the hard maximum *encoded asset size* for each displayed raster asset** (after compression, at the class's 720×1600 native density). ⭐ **SVG is permitted as a vector alternative and is NOT converted into a raster-size requirement** — an SVG asset is governed by its encoded `.svg` byte size, not by any raster rendering of it. ⭐ **200 KB is a hard ceiling, not an approximate value** |
| 2 | **Font weight** | ⭐ **Maximum 4 bundled weight faces: `400 / 500 / 600 / 700`** · ⭐ **Devanagari MUST be subsetted** · **maximum total font payload 400 KB** | faces + KB / payload | ⭐ **400 KB is the hard maximum total bundled font payload for the V1 font set** (the sum of the bundled/subsetted `.ttf`/`.otf` bytes). The 4-face limit is exactly `400/500/600/700` (per `DDR-0032`; 800+ excluded). ⭐ **Devanagari MUST remain subsetted** — the Devanagari face ships as a subset, not a full multi-script file. ⭐ **400 KB is a hard ceiling, not an approximate value** |
| 3 | **Animation duration** | ⭐ **`instant` = 0 ms · `fast` = 150 ms · `base` = 200 ms · `slow` = 300 ms** · ⛔ **no continuous / looping animation** · ⭐ **transform / opacity only** | ms / tier | Duration of each motion tier *as adopted from the existing `LIBOORA_MASTER_DESIGN_SYSTEM.md` §motion proposal (L263–266) — this document **explicitly adopts** that proposal; easing and reduced-motion rules (`prefers-reduced-motion` → static final state, `DDR-0004`) stand unchanged |
| 4 | **Screen payload** | ⭐ **Maximum 50 KB of screen data per screen response** · ⭐ **one image per card permitted separately from the JSON / data payload** | KB / screen response | ⭐ **The 50 KB hard ceiling applies ONLY to structured screen data (JSON / event / data payload)** transferred to render one screen. ⭐ **Media assets are measured separately under budget 1 (Image weight) and are NOT counted against the 50 KB screen-data ceiling — no image byte is double-counted into it.** A permitted per-card image is governed by the 200 KB image ceiling, never by this 50 KB data ceiling. ⭐ **50 KB is a hard ceiling.** ⛔ Not a substitute for, and not the `BC-23` event-payload privacy boundary (`BC Map` §17.2.1) or the P7 latency figure |
| 5 | **Time-to-interactive** | ⭐ **Frame budget 16 ms** *(60 fps; ⛔ no jank)* · ⭐ **interaction acknowledgement < 100 ms** | ms | ⭐ **16 ms is the frame budget** (time to produce the next frame without jank on the target class). ⭐ **< 100 ms is the interaction acknowledgement** (time from user input to a visible acknowledgement — state change, skeleton reservation, or progress indicator). ⛔ **P7's `≤ 2 s` / `≤ 5 s` is the `BC-23` server / API component latency target and is NOT TTI** (`ADR-0100` §3.3; platform reconciliation OPEN, owner SRE/Observability per `MP-NFR-01`). For a networked screen the acknowledgement round-trip may be bounded by P7, but P7 is a separate server-latency figure and is ⛔ not redefined as TTI |

## 2. Target-class rationale (per `DDR-0034`)

⭐ All five ceilings/targets are set for the confirmed class: **Android 8.0 / API 26 · ~2 GB RAM · 720×1600 · primarily 4G / degraded where documented**. For each budget, **repository evidence** (a source in the repo that a figure or rule already rests on) is kept strictly separate from **owner rationale** (the judgement for which this decision is the owner's act, and which no repo document has yet recorded).

### 2.1 Image weight — ≤ 200 KB per displayed raster (SVG alternative)
**Repository evidence:** `PERFORMANCE.md` L18 "prefer SVG or appropriately compressed raster assets"; `MASTER` L324 "lazy-load; compress; fixed aspect box"; `DESIGN_SYSTEM.md` §2 (canonical `≤5%` 3D per `DDR-0013`) — i.e. images are a *bounded* share of a 2D-first surface. **No numeric image cap exists in the repo** (the closure pack records "image weight: no evidence, will not invent it"). **Owner rationale:** on a `720×1600` display, a single screen shows a small number of cards; 200 KB per encoded raster (native density, post-compression) keeps per-card download and decode bounded on a **~2 GB** device and on a **degraded 4G** link, so a screen of a few cards stays well under a few MB total; SVG is preferred for the 2D-first functional UI and is *not* rasterised into a pixel-size requirement. On **API 26** the software path is unchanged, so the ceiling is device-portable.

### 2.2 Font weight — ≤ 4 faces (400/500/600/700), Devanagari subsetted, ≤ 400 KB total
**Repository evidence:** `DDR-0032` *decides* the weight token set (400/500/600/700; 800+ excluded); `DDR-0029` fixes the family + licence (Noto Sans + Noto Sans Devanagari, SIL OFL); `DDR-0002` *requires* guaranteed Indic/Devanagari rendering. **No font *byte* budget exists in the repo** (`VISUAL_LANGUAGE.md` L30 leaves family/weights/type-scale "TO BE DECIDED"; no `.ttf` byte cap is recorded). **Owner rationale:** on a **~2 GB / 4G-degraded** device the dominant font cost is face count plus un-subsetted multi-script files; capping the **total bundled payload at 400 KB** (all faces combined) while *requiring Devanagari to stay subsetted* directly bounds that cost and still satisfies the `DDR-0002` Indic guarantee. The 4-face set is the already-decided `DDR-0032` set — the budget merely makes its payload consequence a hard ceiling. **API 26** ships system Noto Devanagari on most low-end ROMs, which is exactly why the *guarantee* probe (`CP-B1`) is a separate, still-blocked act; this budget only bounds what the app itself ships.

### 2.3 Animation duration — 0 / 150 / 200 / 300 ms, no looping, transform/opacity only
**Repository evidence:** `MASTER` L263–266 proposes exactly `instant 0 / fast 150 / base 200 / slow 300 ms`, "no continuous/looping", "transform and opacity only" — this document **explicitly adopts** that proposal. **Owner rationale:** on a **2 GB / 720×1600** device, short bounded durations confined to the cheap GPU-composite path (transform/opacity, no layout thrash) keep each transition within the 16 ms frame budget and avoid sustained jank; a hard cap at 300 ms for the slowest tier keeps even the longest transition well inside a perceived-instant window. **API 26** and **4G** are neutral to this — it is a CPU/GPU cost, independent of network.

### 2.4 Screen payload — ≤ 50 KB structured data (+ 1 image/card, governed separately by budget 1)
**Repository evidence:** `PERFORMANCE.md` §5 names the "screen payload" category; `BC Map` §17.2.1 establishes that a *payload boundary* is a designed control; `MASTER` L483/575 (`MP-DEP-08`) state targets belong to the NFR document. **No numeric per-screen data cap exists in the repo.** **Owner rationale:** on **4G / degraded** the per-screen transfer that a user actually waits on is the *structured* data; capping that at **50 KB per screen response** (media excluded and governed by the 200 KB image ceiling) keeps time-to-paint predictable on a slow link on a **2 GB** device, while "one image per card" preserves the visual design. **API 26** is neutral to a data-size cap.

### 2.5 Time-to-interactive — 16 ms frame budget + < 100 ms acknowledgement
**Repository evidence:** `MASTER` L321–322 proposes "frame budget 16 ms (60 fps; no jank)" and "interaction feedback < 100 ms" — this document **explicitly adopts** both. `ADR-0100` §3.3 separately records the `BC-23` **server** latency component target `≤ 2 s` / `≤ 5 s`. **Owner rationale:** on a **~2 GB / 720×1600** device the interactive-quality constraint is frame pacing (16 ms) plus a fast visible acknowledgement (< 100 ms); that is what makes the UI feel responsive regardless of network. The **P7 `≤ 2 s / ≤ 5 s`** is a *different* figure — server response latency — and is deliberately **not** TTI; for a networked screen the acknowledgement round-trip is bounded by P7, but TTI itself is the client-side frame/ack metric. **API 26** and **4G** do not change the client-side frame budget.

## 3. Engineering confirmation

**Scope — which budgets require Engineering validation:** budgets **1 (image), 2 (font), 4 (screen data payload)** are *design-side ceilings adopted by the owner decision*; they require **Engineering measurement** to confirm each ceiling is *attainable* on the target class. Budgets **3 (animation)** and **5 (TTI frame/ack)** additionally require **frame profiling** (16 ms budget / jank) on the target class. **Engineering confirmation does not reopen the decision** — it validates feasibility.

**What must be measured, and against which target class:** all measurements run against the `DDR-0034` class (**Android 8.0 / API 26 · ~2 GB RAM · 720×1600 · primarily 4G / degraded**):
- Budget 1 — the *encoded* size of each displayed raster asset (post-compression, native 720×1600 density), vs the 200 KB ceiling.
- Budget 2 — total bytes of the bundled/subsetted font files (all faces), vs 400 KB; confirm Devanagari ships subsetted.
- Budget 4 — the structured data (JSON/event) bytes of a representative screen response, media excluded, vs 50 KB.
- Budgets 3 & 5 — frame-time / jank under the 16 ms budget and the < 100 ms interaction acknowledgement, on a low-end representative device of the class.

**If a ceiling is found unattainable:** the *measurement* is recorded as a **failure against the adopted ceiling** and routed to the **Design Performance Owner + Engineering for a re-decision** (a new owner act under `DESIGN_CHANGE_MANAGEMENT.md` §4, with source references). ⛔ **This does not silently reopen the value to `TO BE DECIDED` and does not weaken the adopted decision** — the adopted ceiling stays authoritative until a new owner decision supersedes it. Until Engineering confirmation is complete, the adopted ceilings are **authoritative for design acceptance** (`PERFORMANCE.md` §5 — the Design Performance Owner may reject an asset or effect that breaches a ceiling).

## 4. What this document does NOT do

- ⛔ **No invented additional budgets** — exactly the five categories `PERFORMANCE.md` §5 names.
- ⛔ **Does not redefine P7** (`≤ 2 s / ≤ 5 s`) as TTI — P7 remains the `BC-23` server/API
  component latency target per `ADR-0100` §3.3; its **platform reconciliation stays OPEN**
  (owner SRE/Observability, `MP-NFR-01`) and is not closed by this document.
- ⛔ **Does not amend `ADR-0100`** — its "platform reconciliation OPEN" note is left intact.
- ⛔ **Does not touch** `CP-B1` / `FA-GAP-003` (Devanagari rendering guarantee — still BLOCKED /
  UNVERIFIED on a real target), `DDR-0012` (still reserved-and-free), production code,
  `pubspec.yaml`, or Android configuration.
- ⛔ **Does not mark G5 PASS** or close `DBT-008` — this is one of the pre-G5 owner decisions;
  G5 remains `PROPOSED / unrecorded`.
- ⛔ **No value is presented as pre-existing** — budgets 1/2/4 were `TO BE DECIDED`; they are now
  **DECIDED** solely by the 2026-10-01 owner decision. Budgets 3 and 5 adopt the **explicitly
  cited** `MASTER` proposals (L263–266, L321–322), which this document promotes from PROPOSED to
  DECIDED by the same owner act.

## 5. Source references

| Element | Source |
|---|---|
| 5 categories | `PERFORMANCE.md` §5 (L35) |
| Target class | [`DDR-0034`](design-decisions/DDR-0034-cp-a-v1-device-profile-confirmed-by-technical-owner.md) (ACCEPTED, Technical Owner, 2026-10-01) |
| Motion tiers (adopted) | `LIBOORA_MASTER_DESIGN_SYSTEM.md` L263–266 *(proposal, promoted to DECIDED here)* |
| Frame budget + interaction ack (adopted) | `LIBOORA_MASTER_DESIGN_SYSTEM.md` L321–322 *(proposal, promoted to DECIDED here)* |
| Image handling (compress / lazy-load / fixed-aspect) | `MASTER` L324 · `DESIGN_SYSTEM.md` §2 |
| 2.5D / 3D allocation (image context) | `VISUAL_LANGUAGE.md` §1 · `DESIGN_SYSTEM.md` §2 *(canonical `≤5%` per `DDR-0013`)* |
| Typeface family + licence | `DDR-0029` (Noto Sans + Noto Sans Devanagari, SIL OFL) |
| Weight token set | `DDR-0032` (`400/500/600/700`; 800+ excluded) |
| Indic rendering requirement | `DDR-0002` (MUST guarantee proper Indic rendering) |
| P7 server/API component latency (distinct from TTI) | `ADR-0100` §3.3 (`≤ 2 s` normal / `≤ 5 s` hard; owner SRE/Observability, `MP-NFR-01`) |
| Document admission owner | `PRD_OWNERSHIP_MODEL.md` L418 (Governance Owner) |
| Gaps closed | `FA-GAP-010` · `DD7-GAP-009` · `CP-E` |

## 6. Change-control note

Per `DESIGN_CHANGE_MANAGEMENT.md` §4: artifact = `NFR Budgets (V1)`, decision status **DECIDED**,
owner (Governance Owner, document admission) + Design Performance Owner (design-side budgets,
Engineering input acknowledged), decision date **2026-10-01**, target class `DDR-0034`, source
references per §5. This is a values/governance decision — no rendering evidence, no gate, and no
code change is implied.
