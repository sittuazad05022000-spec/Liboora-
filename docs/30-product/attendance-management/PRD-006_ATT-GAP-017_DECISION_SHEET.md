# `ATT-GAP-017` — Decision Sheet for the Seven Unresolved `ATT-CFG-*` Settings

| Field | Value |
|---|---|
| **Document** | Decision sheet prepared for the deciders named in [`ADR-0021`](../../00-governance/adr/ADR-0021-attendance-management-configurable-defaults.md) |
| **Type** | **Decision-support artefact.** Unranked. Confers nothing, decides nothing, resolves nothing |
| **Subject** | [`PRD-006_ATTENDANCE-MANAGEMENT.md`](./PRD-006_ATTENDANCE-MANAGEMENT.md) v1.3 DRAFT §16.3 — `ATT-CFG-005`, `006`, `011`, `012`, `014`, `019`, `023` |
| **Subject hash** | `93ab1c60d740c4e0…` — **unmodified by this sheet** |
| **`ADR-0021` status** | **Proposed** — unchanged. **Not** accepted by this sheet |
| **`ATT-GAP-017` status** | 🔴 **OPEN** — unchanged. **Not** resolved by this sheet |
| **Values proposed** | **Zero.** No duration, distance or 0–1 threshold is recommended for any setting |
| **Version / Date** | v1.0 · 2026-08-04 |

> **What this sheet adds beyond `ADR-0021`.**
> `ADR-0021` establishes that **one** decision is owed and puts **four routes** to the product owner. This sheet
> shows that the seven settings are **not one homogeneous decision**. They decompose into **four distinct decision
> types** with **different owners** and **different readiness**, and **three of the seven cannot be decided at all
> right now** — they are downstream of gaps owned by other people. That changes the sequencing, not the verdict.

---

## 1. The rule being breached, quoted at source

> `LIB-16.2` — Every setting **MUST** have a documented default. A library that has changed nothing **MUST** be
> fully operable.
> — `Library_PRD_v1.md` L676, **Rank 3**

Both halves matter and they fail differently:

| Sentence | State | Evidence |
|---|---|---|
| *“Every setting MUST have a documented default”* | 🔴 **BREACHED** — 7 of 24 have none | §16.3 *Default* column reads `ATT-GAP-017` |
| *“A library that has changed nothing MUST be fully operable”* | ✅ **SATISFIED IN FACT** | `ATT-BR-044` — all seven sit behind capabilities that are **Disabled** by default |

**The breach is real but latent.** That is why it blocks freeze (it would confer Rank 3 on a live violation) yet
does not block a day-one tenant, who uses Manual mode with concrete defaults.

Two further constraints bind every option below:

> `ATT-BR-043` — A configurable whose Default column names an unresolved gap has **no default value, and no value
> SHALL be substituted for it** — not zero, not a framework default, not a value copied from another tenant,
> another mode, **another product** or an example in this document.

> `PRD-006` §0.4 — A gap resolved by implementation choice is not resolved — it is an undocumented architecture
> decision made by whoever happened to write the code first.

---

## 2. What each setting actually requires — the four decision types

The seven are not interchangeable. Sorting them by *what kind of decision is owed* is the substantive finding.

| Type | Settings | Decision owed | Owner |
|---|---|---|---|
| **T1 — Security parameter** | `005`, `006` | A defence-window trade-off: how long a displayed code stays valid | Product Owner **with Security Platform** |
| **T2 — Physical/operational parameter** | `011`, `012` | A geometry decision about premises size and device capability | Product Owner |
| **T3 — Statistical threshold on a system that does not exist yet** | `014`, `019` | An error-rate trade-off (FAR/FRR) that **cannot be set without an evaluated engine** | Product Owner **with Security Platform** (`014`) / Product Owner (`019`) |
| **T4 — Business policy** | `023` | How long staff may amend an attendance record | Product Owner alone |

### 2.1 The blocking finding: three of the seven are not decidable today

| Setting | Blocked by | Owner of the blocker | Consequence |
|---|---|---|---|
| `ATT-CFG-014` | `ATT-FR-064` — *“Until `ATT-GAP-012` and `ATT-GAP-014` are both answered … face verification **MUST NOT** be implemented”* | Architecture Owner + Security Platform (`012`); Legal counsel + Security Platform (`014`) | **A threshold cannot be set for an engine nobody owns, on data nobody may store.** Deciding it now decides nothing |
| `ATT-CFG-019` | `ATT-FR-080` — *“Until `ATT-GAP-010` and `ATT-GAP-011` are answered, the OCR/Vision workflow **MUST NOT** be implemented”* | Architecture Owner (both) | **No OCR capability exists in `docs/**` and no `BC-03` → `BC-27` edge is declared.** A confidence threshold for an unselected engine is not portable |
| `ATT-CFG-005`/`006` | `ATT-GAP-006` — *“What cryptographic construction secures a dynamic QR code?”* | Security Platform owner | **Partially blocked.** The *duration* is a product decision; whether a short rotation is even achievable depends on the construction. `ATT-XC-013` forbids this PRD from specifying it |

**Why this matters to the deciders:** `ADR-0021` Options A and B ask the Product Owner to supply seven values.
For `014` and `019` there is **no defensible way to do so** — a confidence threshold is a property *of a specific
model measured on a specific dataset*, and both engines are unselected and build-blocked. Asking for those two
numbers now invites exactly the *“unreviewable magic number”* `AR-4` warns about, dressed as a resolution.

**Four of the seven — `005`, `006`, `011`, `012`, `023` (five, precisely) — are decidable now.** Two are not.

### 2.2 Coupling constraints the deciders must respect

These are already normative in §16.3 and constrain any values chosen:

- `ATT-CFG-005` **≤** `ATT-CFG-006` — *“Must be > 0 and ≤ validity window”* / *“Must be ≥ rotation interval”*.
  **They must be decided together**; a value for one bounds the other.
- `ATT-CFG-011` and `ATT-CFG-012` are **not** formally coupled in the table, but are operationally: an accuracy
  tolerance looser than the acceptance radius makes the radius unenforceable. Recommend deciding as a pair.
- `ATT-CFG-019` is moderated by `ATT-CFG-020` (unattended creation, default **Disabled**) and by `ATT-BR-028`
  (*“Even a high-confidence entry MUST be presented for creation, not created autonomously”*). **This lowers the
  blast radius of `019` materially** — see its row.

### 2.3 One setting carries an extra, independent obligation

`ATT-FR-042` states: *“An acceptance radius **MUST** be configurable per tenant (`ATT-CFG-011`) **with a default
and a bounded allowed range**.”*

**`ATT-CFG-011` therefore breaches two rules, not one** — `LIB-16.2` *and* a functional requirement inside
`PRD-006` itself. No other of the seven carries a second, module-internal mandate of this kind.

---

## 3. Decision sheet

> **Legend — decision status:** 🟢 *Decidable now* · 🟡 *Decidable now, but sequencing advised* · 🔴 *Not decidable
> — blocked on another owner's gap*
> **All seven remain 🔴 OPEN in `ATT-GAP-017` regardless of this column**, which describes readiness, not status.

### `ATT-CFG-005` — Dynamic QR rotation interval

| | |
|---|---|
| **Why a default/range is required** | `LIB-16.2` (Rank 3). `ATT-FR-025` requires rotation *“on a configured interval”* — the mechanism is normative and cannot run without a value. `ATT-FR-149` makes the mode un-enableable while the value is absent |
| **Type** | T1 — security parameter. Rotation interval **is** the replay-attack defence window |
| **Options** | **(a)** Owner sets interval + range directly · **(b)** Security Platform advises a range, Owner sets the value inside it · **(c)** PRD sets the envelope, `CONFIGURATION_GUIDE.md` sets the operating value (`ICFG-2` pattern) · **(d)** Descope Dynamic QR from V1 |
| **Trade-offs** | Shorter interval → smaller replay window, but more display churn, greater clock-skew sensitivity (`ATT-BR-015`) and worse offline behaviour (`ATT-GAP-016a` open). Longer → a screenshot stays usable longer |
| **Risks** | An interval chosen without security input is a security control set by product intuition. Interacts with `ATT-GAP-006` (construction) — a very short interval may not be achievable under some constructions |
| **Recommended** | **(b)**, then recorded via **(c)**. Security Platform supplies the *range*; Owner picks inside it; the Guide holds the operating value. This matches how the repo already governs 35 parameters and keeps the envelope with the authority that owns the threat model |
| **Owner** | **Product Owner** — decision · **Security Platform (Domain Owner, `PRD-012a`)** — must supply or endorse the range |
| **Status** | 🟡 **Decidable now**, but **decide jointly with `006`** and after `ATT-GAP-006` is at least scoped |

### `ATT-CFG-006` — Dynamic QR validity window

| | |
|---|---|
| **Why a default/range is required** | `LIB-16.2`. `ATT-FR-024` requires a *“bounded validity window”* normatively; `ATT-FR-026` requires a distinguishable *“expired”* rejection, which presupposes an expiry |
| **Type** | T1 — security parameter |
| **Options** | As `005`. Additionally: **(e)** define `006` as a multiple of `005` (e.g. “validity = N × rotation”), reducing two decisions to one plus a factor |
| **Trade-offs** | Must be **≥** `005` by §16.3 validation. A window barely longer than the interval is strict but fails students on slow networks mid-rotation; a much longer window means several codes are valid at once, widening the replay surface |
| **Risks** | **The near-miss `ADR-0021` §2.1 records applies here specifically.** The Authentication PRD's OTP expiry looks like a source and is not one: an OTP is a one-time secret sent to one phone in `BC-18`; a Dynamic QR is a broadcast display artefact in `BC-03` scanned by many students (`ATT-BR-014`). Copying that number would import a security parameter across a context boundary |
| **Recommended** | **(b)+(e)** — Security Platform sets the range and the permitted `006`:`005` ratio; Owner sets the value. Expressing the relationship removes the commonest misconfiguration (validity < rotation) at the specification level |
| **Owner** | **Product Owner** — decision · **Security Platform** — range and ratio |
| **Status** | 🟡 **Decidable now**, jointly with `005` |

### `ATT-CFG-011` — GPS acceptance radius

| | |
|---|---|
| **Why a default/range is required** | `LIB-16.2` **and** `ATT-FR-042`, which mandates *“a default and a bounded allowed range”* — **the only one of the seven with a second, module-internal mandate**. `ATT-FR-046` requires an *“outside library area”* rejection, undefined without a radius. `ATT-AC-041` asserts an out-of-range radius is rejected at configuration time — untestable while no range exists |
| **Type** | T2 — physical/operational |
| **Options** | **(a)** Owner sets default + range from the real estate profile of target libraries · **(b)** Derive the range from an operational survey of tenant premises (`DOCUMENTATION_AUDIT-001` anchoring pattern) · **(c)** PRD envelope + Guide value · **(d)** Descope Fixed QR + GPS from V1 |
| **Trade-offs** | Too small → false rejections for legitimate students inside large or multi-floor premises, driving fallback to Manual. Too large → attendance markable from outside the building, defeating the mode's purpose |
| **Risks** | **Lowest-risk of the seven and the best candidate for early closure**: it is a measurable physical property, not a threat model or a statistical property. Depends on `ATT-GAP-008` (whether the GPS centre is `LIB-6.5` Map Location or an attendance-owned value) — that affects *what the radius is measured from*, not the radius itself |
| **Recommended** | **(b)** — anchor the range to an actual survey of representative premises, then Owner sets the default inside it. The anchor makes it defensible at review and re-anchorable later without re-litigating intent |
| **Owner** | **Product Owner** (sole). No security approval required |
| **Status** | 🟢 **Decidable now.** Recommend deciding first — it closes 1 of 7 with the least dependency |

### `ATT-CFG-012` — Minimum acceptable location accuracy

| | |
|---|---|
| **Why a default/range is required** | `LIB-16.2`. `ATT-FR-045` requires a distinguishable *“location inaccurate”* rejection, which cannot fire without a threshold. `ATT-AC-038` asserts that behaviour |
| **Type** | T2 — physical/operational, but device-dependent |
| **Options** | As `011`. Additionally **(f)** express `012` relative to `011` (accuracy must be at least as tight as some fraction of the radius), making the pair internally consistent by construction |
| **Trade-offs** | Consumer GPS accuracy degrades badly indoors — precisely where a library attendance scan happens. Too strict → the mode rarely succeeds indoors and students are pushed to Manual. Too loose → a reported position is meaningless and the radius check becomes theatre |
| **Risks** | Setting `012` looser than `011` silently disables the radius check while appearing to enforce it. **This is the failure mode most likely to pass review unnoticed**, because both values look reasonable in isolation |
| **Recommended** | **(f)** — define `012` in relation to `011` rather than as a free-standing number, then anchor as for `011`. Prevents the silent-disable case at specification level rather than relying on configuration discipline |
| **Owner** | **Product Owner** (sole), with technical input on device capability |
| **Status** | 🟢 **Decidable now**, jointly with `011` |

### `ATT-CFG-014` — Face match confidence threshold

| | |
|---|---|
| **Why a default/range is required** | `LIB-16.2`. `ATT-FR-055` requires a match below the threshold to be treated as **no match** — the rule is normative and inert without a value |
| **Type** | T3 — statistical threshold on a system that does not exist |
| **Options** | **(a)** Owner sets a number now · **(b)** Defer until an engine is selected, then set from measured FAR/FRR on a representative dataset · **(c)** PRD envelope + Guide value · **(d)** Descope Face from V1 — **already partly the case**, since `ATT-FR-064` build-blocks it and `ATT-GAP-015` asks whether Face is V1 or V3 at all |
| **Trade-offs** | This is a **false-accept vs false-reject** trade-off, not a preference. A low threshold admits impersonated attendance; a high one locks out legitimate students. `Bounded 0–1` is a *type*, not a range — it admits `0.01` and `0.99` equally, and `0.01` authorises impersonation |
| **Risks** | **Highest-consequence of the seven.** Biometric identification of **minors**. `ATT-GAP-012` (who owns/stores the template) and `ATT-GAP-014` (retention and erasure, incl. minors) are both **open**, and `ATT-FR-064` blocks the build until both are answered. A threshold is not transferable between engines, so any number set now would have to be re-set on engine selection |
| **Recommended** | **(b)**, sequenced behind `ATT-GAP-015` → `ATT-GAP-012` → `ATT-GAP-014`. If `ATT-GAP-015` resolves Face to **V3** (as EA v2.1 lists it), **(d)** closes this row entirely and removes it from the V1 breach |
| **Owner** | **Product Owner** — scope (V1 vs V3) · **Security Platform** — threshold approval · **Legal counsel** — prerequisite via `ATT-GAP-014` |
| **Status** | 🔴 **NOT decidable now.** Blocked by `ATT-GAP-012` + `ATT-GAP-014`; scope itself in question via `ATT-GAP-015` |

### `ATT-CFG-019` — OCR high-confidence threshold

| | |
|---|---|
| **Why a default/range is required** | `LIB-16.2`. `ATT-FR-077` requires the high-confidence threshold to be configurable; `ATT-BR-027` requires a high-confidence detection matching no authoritative record to enter `NEEDS_MANUAL_VERIFICATION` |
| **Type** | T3 — statistical threshold on a system that does not exist |
| **Options** | As `014`. **(b)** = defer until an OCR engine is selected and measured |
| **Trade-offs** | Determines only whether an entry is **presented as** high-confidence. Too low → staff review queue floods with bad detections; too high → the assistance provides little benefit and staff key everything manually |
| **Risks** | **Materially lower than `014`, and the specification already contains the mitigation.** `ATT-BR-028` requires even a high-confidence entry to be *presented for* creation rather than created autonomously, unless `ATT-CFG-020` (default **Disabled**) is enabled. A mis-set `019` therefore degrades staff efficiency; it does not by itself create false attendance. **However** — `ATT-GAP-011` records that *no OCR capability is defined anywhere in `docs/**`*, so there is no engine whose confidence scale this number would even refer to |
| **Recommended** | **(b)**, sequenced behind `ATT-GAP-010` (may `BC-03` hold a `FileRef`?) and `ATT-GAP-011` (who owns OCR?). Both are Architecture Owner decisions and neither is this sheet's to make |
| **Owner** | **Product Owner** — threshold, once an engine exists · **Architecture Owner** — the prerequisite gaps |
| **Status** | 🔴 **NOT decidable now.** Blocked by `ATT-GAP-010` + `ATT-GAP-011` |

### `ATT-CFG-023` — Correction window

| | |
|---|---|
| **Why a default/range is required** | `LIB-16.2`. `ATT-FR-115` applies *“where a correction window is configured”*; `ATT-AC-157` asserts an out-of-window correction is rejected |
| **Type** | T4 — business policy. **The only one of the seven that is purely a product decision** |
| **Options** | **(a)** Owner sets a window + range · **(b)** Set the documented default to **“no window”** (unbounded correction) and record it explicitly · **(c)** PRD envelope + Guide value |
| **Trade-offs** | Short window → data settles quickly and is more trustworthy, but genuine errors found late become uncorrectable. Long/absent window → maximum flexibility, but attendance history stays mutable indefinitely. `ATT-BR-040` guarantees corrections are never *silent* and `ATT-FR-116` requires full correction history — so the audit risk of a long window is bounded |
| **Risks** | **Lowest risk of the seven.** No security dimension, no external dependency, no unselected engine, no open gap. `ATT-FR-115`'s conditional phrasing means the absence of a window is already a *defined* behaviour, not undefined behaviour |
| **Recommended** | **(b)** — adopt *“no window by default”* as the documented default, with an optional bounded range for tenants who want one. **This is the one row where the existing behaviour is already correct and only needs to be written down.** It satisfies `LIB-16.2` without inventing a number, because *“no window”* is a real, specified default rather than a substituted value |
| **Owner** | **Product Owner** (sole) |
| **Status** | 🟢 **Decidable now.** Cheapest of the seven to close |

---

## 4. Consolidated sheet

| ID | Setting | Why default/range required | Options | Recommended | Decision owner | Status |
|---|---|---|---|---|---|---|
| `ATT-CFG-005` | Dynamic QR rotation interval | `LIB-16.2`; `ATT-FR-025` mechanism inert without it | a / b / c / d | **b→c** — Security range, Owner value, Guide records | **Product Owner** + **Security Platform** | 🟡 Decidable; pair with `006` |
| `ATT-CFG-006` | Dynamic QR validity window | `LIB-16.2`; `ATT-FR-024`, `ATT-FR-026` | a / b / c / d / e | **b+e** — range + ratio to `005` | **Product Owner** + **Security Platform** | 🟡 Decidable; pair with `005` |
| `ATT-CFG-011` | GPS acceptance radius | `LIB-16.2` **and** `ATT-FR-042` (*“a default and a bounded allowed range”*); `ATT-AC-041` untestable | a / b / c / d | **b** — anchor range to a premises survey | **Product Owner** | 🟢 **Decide first** |
| `ATT-CFG-012` | Min. location accuracy | `LIB-16.2`; `ATT-FR-045`, `ATT-AC-038` | a / b / c / f | **f** — express relative to `011` | **Product Owner** | 🟢 Decidable; pair with `011` |
| `ATT-CFG-014` | Face match confidence | `LIB-16.2`; `ATT-FR-055` inert without it | a / b / c / d | **b**, or **d** if `ATT-GAP-015` → V3 | **Product Owner** (scope) + **Security Platform** (threshold) + **Legal** (prereq) | 🔴 **Blocked** — `ATT-GAP-012`, `014`; `ATT-FR-064` |
| `ATT-CFG-019` | OCR high-confidence | `LIB-16.2`; `ATT-FR-077`, `ATT-BR-027` | a / b / c / d | **b** — after engine selection | **Product Owner** (threshold) + **Architecture Owner** (prereq) | 🔴 **Blocked** — `ATT-GAP-010`, `011`; `ATT-FR-080` |
| `ATT-CFG-023` | Correction window | `LIB-16.2`; `ATT-FR-115`, `ATT-AC-157` | a / b / c | **b** — *“no window”* as the documented default | **Product Owner** | 🟢 **Cheapest to close** |

### 4.1 Decisions requiring approval, by owner

| Owner | Must decide | Settings |
|---|---|---|
| **Product Owner** (sole authority) | Radius, accuracy and correction-window policy | `011`, `012`, `023` |
| **Product Owner + Security Platform** *(Domain Owner, `PRD-012a`)* | QR rotation/validity — a security control, not a preference | `005`, `006` |
| **Product Owner** (scope) **+ Security Platform** (threshold) **+ Legal counsel** (prerequisite) | Whether Face is V1 at all, then the biometric threshold | `014` |
| **Architecture Owner** (prerequisite) **then Product Owner** | OCR ownership and `FileRef` permission, then the threshold | `019` |
| **Governance Owner** | Whether a CONDITIONAL Stage 3/4 verdict permits Stage 7 (`ADR-0021` §5, **D-2**) | — |

> **On role vocabulary.** `PRD_OWNERSHIP_MODEL.md` §2.2 defines **four** roles — Product, Domain, Architecture,
> Technical. There is **no “Security Owner” role**. Security Platform appears as a **Domain Owner**
> (`PRD-012a`, L180). *“Security Owner”* is used in the instruction and mapped here to **Security Platform as
> Domain Owner**, so the sheet does not invent a fifth role.

### 4.2 Recommended sequence

| Step | Action | Closes | Depends on |
|---|---|---|---|
| 1 | Product Owner decides `023` (*“no window”* default) | 1 of 7 | Nothing |
| 2 | Product Owner decides `011` + `012` as a pair | 3 of 7 | Premises survey; `ATT-GAP-008` informs the *centre*, not the radius |
| 3 | Security Platform supplies range/ratio; Owner sets `005` + `006` | 5 of 7 | `ATT-GAP-006` scoped |
| 4 | Product Owner answers `ATT-GAP-015` (Face V1 or V3?) | — | Nothing — **this is the cheapest way to clear `014`** |
| 5 | If V1: Architecture + Security + Legal close `ATT-GAP-012`/`014`, then set `014`. If V3: `014` leaves V1 scope | 6 of 7 | Step 4 |
| 6 | Architecture Owner closes `ATT-GAP-010`/`011`, engine selected, then set `019` | 7 of 7 | — |

**`ATT-GAP-017` closes only at step 6.** Steps 1–3 close five of seven and are unblocked today; the `LIB-16.2`
breach persists until all seven are documented, so **partial progress does not make `PRD-006` freezable.**

---

## 5. What this sheet deliberately did not do

| Not done | Why |
|---|---|
| Propose any value for any of the seven | `ATT-BR-043`; `PRD-006` §0.4; the instruction. **Zero numeric values appear as recommendations** |
| Propose any allowed range | The range is the harder half and is equally a product/security decision |
| Mark `ADR-0021` Accepted | An ADR is accepted by its deciders. Status is **Proposed**, unchanged |
| Freeze `PRD-006` or create a baseline row | Stage 7's gate is a baseline row; not this sheet's act |
| Modify `PRD_REGISTRY.md` or `DOCUMENTATION_BASELINE.md` | Instruction 6. Both verified byte-identical |
| Modify `PRD-006`, `LIB-16.2` or any frozen document | The subject and the breached rule are both read-only here |
| Resolve `ATT-GAP-017`, silently or otherwise | It remains 🔴 **OPEN**. Sequencing a decision is not making it |
| Resolve `ATT-GAP-006`/`008`/`010`/`011`/`012`/`014`/`015` | Each has its own named owner. This sheet **cites** them as blockers; it does not answer them |
| Re-grade any Stage verdict | Stage 3 and Stage 4 remain ⚠️ CONDITIONAL |

---

## 6. Verification

| Claim | Method | Result |
|---|---|---|
| 7 of 24 configurables carry `ATT-GAP-017` | Parsed §16.3 rows L1155–1178 | **24 rows · 7 unresolved** |
| `LIB-16.2` text as quoted | `Library_PRD_v1.md` L676 | Verbatim match |
| `ATT-FR-042` mandates a default **and** range for `011` | `PRD-006` L737 | Confirmed — unique among the seven |
| Exactly two capabilities are build-blocked | `grep 'MUST NOT be implemented'` | **2** — `ATT-FR-064` (Face), `ATT-FR-080` (OCR) |
| Dynamic QR and GPS are **not** build-blocked | Same search | Confirmed — neither appears |
| `ATT-BR-028` moderates `019`'s blast radius | `PRD-006` L948 | Confirmed — presented, not auto-created |
| No “Security Owner” role exists | `PRD_OWNERSHIP_MODEL.md` §2.2 | **4 roles**; Security Platform is a *Domain Owner* (L180) |
| `ADR-0021` still Proposed | Header row | **Proposed** — unchanged |
| `PRD-006` unmodified | SHA-256 | `93ab1c60d740c4e0…` unchanged |
| Registry and baseline unmodified | SHA-256 | `f8e71ce876c2b53b` · `42405be29d392e14` unchanged |
| Zero values recommended | Unit-scoped scan of all *Recommended* cells | **0** durations, distances or 0–1 thresholds |

---

## 7. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-04 | Created as decision support for the deciders named in `ADR-0021`. **Proposes no value and no range for any of the seven settings.** Establishes that the seven are **not one decision but four types** — T1 security parameter (`005`, `006`), T2 physical/operational (`011`, `012`), T3 statistical threshold on an unbuilt system (`014`, `019`), T4 business policy (`023`) — with different owners and different readiness. **The substantive finding is that three of the seven are not decidable today**: `014` is build-blocked by `ATT-FR-064` pending `ATT-GAP-012`/`014` and its very scope is in question via `ATT-GAP-015`; `019` is build-blocked by `ATT-FR-080` pending `ATT-GAP-010`/`011`, and `ATT-GAP-011` records that **no OCR capability is defined anywhere in `docs/**`**, so there is no engine whose confidence scale the number would refer to; `005`/`006` are partially gated by `ATT-GAP-006` (cryptographic construction, Security Platform). This qualifies `ADR-0021` Options A and B, which ask the Product Owner for seven values: for `014` and `019` there is no defensible way to supply one, and doing so would produce exactly the *“unreviewable magic number”* `AR-4` warns against. Records that **`ATT-CFG-011` breaches two rules, not one** — `LIB-16.2` *and* `ATT-FR-042`, which independently mandates *“a default and a bounded allowed range”*, making it unique among the seven. Records the **silent-disable failure mode** for `012`: an accuracy tolerance looser than the acceptance radius disables the radius check while appearing to enforce it, which is why the recommendation expresses `012` relative to `011` rather than as a free-standing number. Records that **`023` is the cheapest to close** because *“no window”* is already a **defined** behaviour under `ATT-FR-115`'s conditional phrasing — so `LIB-16.2` can be satisfied by documenting the existing behaviour rather than inventing a number. Records that **`019`'s blast radius is materially lower than `014`'s** because `ATT-BR-028` requires even a high-confidence entry to be *presented for* creation unless `ATT-CFG-020` (default **Disabled**) is enabled. Maps *“Security Owner”* to **Security Platform as Domain Owner** per `PRD_OWNERSHIP_MODEL.md` §2.2 rather than inventing a fifth role, since only four are defined. Gives a six-step sequence closing five of seven without any blocked dependency, while stating plainly that **`ATT-GAP-017` closes only at step 6 and partial progress does not make `PRD-006` freezable**. **`ATT-GAP-017` remains OPEN, `ADR-0021` remains Proposed, `PRD-006` is byte-identical, and `PRD_REGISTRY.md` and `DOCUMENTATION_BASELINE.md` are unmodified.** |
