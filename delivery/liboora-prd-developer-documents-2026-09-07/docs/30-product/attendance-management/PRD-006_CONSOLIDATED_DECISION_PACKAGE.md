# `PRD-006` Attendance Management — Consolidated Owner Decision Package

| Field | Value |
|---|---|
| **Document** | **ONE** consolidated decision package covering every outstanding owner decision that stands between `PRD-006` and Stage 7 |
| **Type** | Decision request / approval sheet. **Not a decision, not a freeze, not an ADR, not part of any specification.** Unranked; confers nothing |
| **Subject** | [`PRD-006_ATTENDANCE-MANAGEMENT.md`](./PRD-006_ATTENDANCE-MANAGEMENT.md) **v1.3 — DRAFT** |
| **Subject hash** | `93ab1c60d740c4e0fe8c82828556491a3f43d77ed47cb7e2b43ef106464ab97b` — **unmodified by this package** |
| **Covers** | `ATT-CFG-005`, `006`, `011`, `012`, `019`, `023` (Blocks A–C) · Face Attendance = V3 (Block D) |
| **Version** | v1.0 · 2026-08-04 |
| **Values proposed** | **ZERO.** No number, duration, distance, ratio or threshold appears anywhere in this document as a proposal |
| **Supersedes** | Nothing. It **consolidates** [`..._ATT-GAP-017_DECISION_SHEET.md`](./PRD-006_ATT-GAP-017_DECISION_SHEET.md), [`..._ATT-GAP-017_OWNER_DECISION_REQUEST.md`](./PRD-006_ATT-GAP-017_OWNER_DECISION_REQUEST.md), [`..._ATT-GAP-015_APPROVAL_REQUEST.md`](./PRD-006_ATT-GAP-015_APPROVAL_REQUEST.md) and [`..._ATT-GAP-015_DECISION_RECORD.md`](./PRD-006_ATT-GAP-015_DECISION_RECORD.md) into one signable artefact. All four remain in force as evidence |

---

## 0. Why one package and not six requests

Four separate artefacts already put pieces of this decision to owners. None of them can be signed as a unit,
and three of the six settings are **coupled** — `005` bounds `006` by §16.3 validation, `012` silently disables
`011` if set loosely, and `019` cannot be decided at all until an Architecture Owner decision that lives in a
fifth document. Asking six questions separately invites six answers that do not compose.

**This package asks four questions, in four blocks, each signable independently and each internally coherent.**

> **The one thing this document will not do.** `ATT-BR-043` (Rank-equivalent normative rule inside the subject):
> a configurable naming an unresolved gap has *"**no default value, and no value SHALL be substituted for it** —
> not zero, not a framework default, not a value copied from another tenant, another mode, another product or an
> example in this document."* Every options list below is drawn from
> [`PRD-006_ATT-GAP-017_DECISION_SHEET.md`](./PRD-006_ATT-GAP-017_DECISION_SHEET.md) §3, which is itself a
> repository artefact. **Nothing is invented here.**

---

## 1. Measured current state — recomputed for this package, not inherited

| Measurement | Command | Result |
|---|---|---|
| Settings in `ATT-GAP-017`'s breach **today** | `grep -c 'ATT-GAP-017`\*\* \|' §16.3 | **7** — `005`, `006`, `011`, `012`, **`014`**, `019`, `023` |
| Settings in scope of this package | Instruction scope | **6** — `014` excluded, see §1.1 |
| Configurables total | Stage 5 gate | **24** (`ATT-CFG-001`…`024`) |
| With a concrete default and closed domain | 24 − 7 | **17** |
| Owner decisions recorded anywhere in `docs/**` for any of the six | repo-wide grep | **0** |
| Authoritative Rank 1–5 value source for any of the six | repo-wide search, verified negative twice | **None** |
| Face V3 — Product Owner | Decision record §1 | ✅ **DECIDED** |
| Face V3 — Architecture Owner / ARB | repo-wide search, third independent pass | ⏳ **PENDING — no approval evidence exists** |

### 1.1 Why `ATT-CFG-014` is not in this package, and why that is not a reduction of the problem

The instruction scopes this package to six settings **"after Face V3 is legitimately approved."** That
conditional is load-bearing and is honoured literally:

- `ATT-CFG-014` (Face match confidence) leaves the V1 configuration surface **only when the ARB signs Block D**.
- Until then the measured breach is **SEVEN**, not six.
- `ATT-CFG-014` therefore appears in **Block D's consequences**, not as a seventh decision request.

**Signing Blocks A–C alone does not clear the `LIB-16.2` breach.** Nor does signing all four. §7 of this package
states exactly what each combination achieves.

---

## 2. The rule being breached, quoted at source

`Library_PRD_v1.md` L676, **Rank 3** — `LIB-16.2`:

> Every setting **MUST** have a documented default. A library that has changed nothing **MUST** be fully operable.

| Sentence | State | Evidence |
|---|---|---|
| *"Every setting MUST have a documented default"* | 🔴 **BREACHED** — 7 of 24 have none | §16.3, measured |
| *"A library that has changed nothing MUST be fully operable"* | ✅ **SATISFIED IN FACT** | `ATT-BR-044` — all seven belong to capabilities **off by default**; a day-one tenant uses Manual |

`PRD-006` L1188 says this of itself, in its own words: *"**This is a live breach of `LIB-16.2`**."*

**Measured across every frozen PRD**: `PRD-007` **0** · `PRD-005` **0** · `PRD-004` **0** ·
`Library_PRD_v1.md` **0** · **`PRD-006` 1**. No frozen PRD in this repository carries a self-declared live
breach of a ranked document. That is why this package exists and why it is not paperwork.

---

## 3. The six settings — ten mandatory elements each

> **Element 10, "currently actionable", is not the same as "important".** It records whether the named owner
> can give a defensible answer **today**, or whether another owner must move first. Two of the six are not
> actionable, and saying so is the substantive finding of this section.

---

### 3.1 `ATT-CFG-005` — Dynamic QR rotation interval

| # | Element | Content |
|---|---|---|
| **1** | **Exact setting name** | `ATT-CFG-005` — *Dynamic QR rotation interval*. §16.3 L1159. Owner column: **Owner** (tenant). Default column: **`ATT-GAP-017`**. Allowed domain: *"Bounded duration — **unresolved**"*. Validation: *"Must be > 0 and ≤ validity window"* |
| **2** | **Existing normative requirements** | `ATT-FR-025` (L641) — *"A dynamic code **MUST** rotate on a configured interval (`ATT-CFG-005`)"* · `ATT-AC-017` — *"Codes rotate at the configured interval"* · `ATT-FR-149` — the mode **MUST NOT** be enableable while the value is absent · `ATT-XC-013` (L658) — this document **MUST NOT** specify a cryptographic construction |
| **3** | **Why a default/range is required** | `LIB-16.2` sentence 1, unqualified. Independently: `ATT-FR-025`'s mechanism is normative and **inert without a value** — a rotation requirement with no interval specifies nothing executable. `ATT-AC-017` is untestable |
| **4** | **Current evidence** | Repo-wide search across `docs/30-product/`, `docs/10-architecture/`, `docs/00-governance/`, `docs/20-configuration/`, excluding `attendance-management/`: **no authoritative value found**. `CONFIGURATION_GUIDE.md` cannot supply one — it is Rank 7 and *"sets values **within** the envelope … it cannot change the envelope"*, and the envelope here does not exist |
| **5** | **Existing documented options** *(Decision Sheet §3, verbatim — no new option invented)* | **(a)** Owner sets interval + range directly · **(b)** Security Platform advises a range, Owner sets the value inside it · **(c)** PRD sets the envelope, `CONFIGURATION_GUIDE.md` sets the operating value (the `ICFG-2` pattern) · **(d)** Descope Dynamic QR from V1 |
| **6** | **Decision owner** | **Product Owner** — the decision · **Security Platform** (Domain Owner, `PRD-012a`) — must supply or endorse the range. Per `PRD_OWNERSHIP_MODEL.md` §2.2, *"the Product Owner is not the default answer"* |
| **7** | **Dependencies** | **Coupled to `ATT-CFG-006`** — §16.3 validation makes each bound the other; they cannot be decided apart. Partially blocked by `ATT-GAP-006` (*what cryptographic construction secures a dynamic QR code?*, Security Platform) — a very short interval may not be achievable under some constructions. `ATT-GAP-016a` (offline Dynamic QR) is open |
| **8** | **Consequence of each option** | **(a)** closes the row immediately; a security control set by product intuition without the threat-model owner. **(b)** closes it defensibly; costs one Security Platform engagement. **(c)** closes the `LIB-16.2` breach at PRD level while deferring the operating value; requires the envelope to be stated here first. **(d)** removes `005` and `006` from the V1 breach entirely (7 → 5 today); costs the Dynamic QR mode in V1 and orphans `ATT-FR-024`…`026`, `ATT-CFG-002`, `007` |
| **9** | **Exact decision statement** | See **Block B**, statement **B-1** |
| **10** | **Currently actionable?** | 🟡 **YES, with sequencing.** Decide jointly with `006`; engage Security Platform on the range; `ATT-GAP-006` need only be *scoped*, not closed, for a duration to be defensible |

---

### 3.2 `ATT-CFG-006` — Dynamic QR validity window

| # | Element | Content |
|---|---|---|
| **1** | **Exact setting name** | `ATT-CFG-006` — *Dynamic QR validity window*. §16.3 L1160. Default: **`ATT-GAP-017`**. Allowed domain: *"Bounded duration — **unresolved**"*. Validation: *"Must be ≥ rotation interval"* |
| **2** | **Existing normative requirements** | `ATT-FR-024` (L640) — *"A dynamic code **MUST** have a bounded validity window, after which it is expired"* · `ATT-FR-026` (L642) — *"An expired code **MUST** be rejected with a distinguishable 'expired' reason, separate from 'invalid'"* · `ATT-AC-015` · `ATT-FR-149`/`150` |
| **3** | **Why a default/range is required** | `LIB-16.2`. `ATT-FR-024` mandates a *bounded* window as a MUST — a bound with no value is not a bound. `ATT-FR-026` requires a distinguishable **expired** outcome, which presupposes an expiry that can occur |
| **4** | **Current evidence** | **None.** The one near-miss is recorded and rejected: the Authentication PRD specifies OTP code expiry and `CONFIGURATION_GUIDE.md` gives it a figure. *An OTP is a one-time secret sent to one phone in `BC-18`; a Dynamic QR is a broadcast display artefact in `BC-03` scanned by many students (`ATT-BR-014`).* Reusing that number would import a security parameter across a bounded-context boundary and **dress an invention as a citation** — and `ATT-BR-043` forecloses it by naming *"another product"* explicitly |
| **5** | **Existing documented options** | As `005`: **(a)**/**(b)**/**(c)**/**(d)**. Additionally **(e)** define `006` as a multiple of `005` (*"validity = N × rotation"*), reducing two decisions to one plus a factor |
| **6** | **Decision owner** | **Product Owner** — the decision · **Security Platform** — the range and, under (e), the permitted ratio |
| **7** | **Dependencies** | **Coupled to `ATT-CFG-005`** — §16.3: *"Must be ≥ rotation interval"*. Same `ATT-GAP-006` partial block |
| **8** | **Consequence of each option** | **(a)**–**(d)** as `005`. **(e)** additionally removes the commonest misconfiguration — validity < rotation — at specification level rather than relying on configuration discipline; costs the ability to tune the two independently |
| **9** | **Exact decision statement** | See **Block B**, statement **B-2** |
| **10** | **Currently actionable?** | 🟡 **YES, jointly with `005`.** Not independently — a window value alone cannot be validated against an interval that does not exist |

---

### 3.3 `ATT-CFG-011` — GPS acceptance radius

| # | Element | Content |
|---|---|---|
| **1** | **Exact setting name** | `ATT-CFG-011` — *GPS acceptance radius*. §16.3 L1165. Default: **`ATT-GAP-017`**. Allowed domain: *"Bounded distance — **unresolved**"*. Validation: *"Must be > 0 and within bound"* |
| **2** | **Existing normative requirements** | `ATT-FR-042` (L737) — *"An acceptance radius **MUST** be configurable per tenant (`ATT-CFG-011`) **with a default and a bounded allowed range**"* · `ATT-FR-046` (L741) — *"outside library area"* rejection · `ATT-AC-035`, `ATT-AC-041` |
| **3** | **Why a default/range is required** | **This setting breaches two rules, not one.** `LIB-16.2` (Rank 3, external) **and** `ATT-FR-042` (internal, MUST-class, and it names *both* a default *and* a bounded range explicitly). **No other of the six carries a second module-internal mandate of this kind.** `ATT-AC-041` asserts an out-of-range radius is rejected at configuration time — untestable while no range exists |
| **4** | **Current evidence** | **None.** No radius, geofence or distance value exists anywhere in `docs/**` |
| **5** | **Existing documented options** | **(a)** Owner sets default + range from the real-estate profile of target libraries · **(b)** Derive the range from an operational survey of tenant premises (the `DOCUMENTATION_AUDIT-001` anchoring pattern) · **(c)** PRD envelope + Guide value · **(d)** Descope Fixed QR + GPS from V1 |
| **6** | **Decision owner** | **Product Owner — sole.** No security approval required. This is a physical/operational property, not a threat-model parameter |
| **7** | **Dependencies** | `ATT-GAP-008` (is the GPS centre `LIB-6.5` Map Location or an attendance-owned value? — **Library PRD owner**) affects **what the radius is measured from**, not the radius itself, and is therefore **not a block**. Operationally paired with `ATT-CFG-012` |
| **8** | **Consequence of each option** | **(a)** closes the row today, and closes an internal `ATT-FR-042` breach with it; unanchored. **(b)** same closure, defensible at review and re-anchorable later without re-litigating intent; costs a survey. **(c)** defers the operating value; the envelope must still be stated here, so most of the work is unavoidable. **(d)** removes `011` and `012` from the breach (7 → 5 today); costs the GPS mode and orphans `ATT-FR-042`…`046`, `ATT-CFG-004`, `010` |
| **9** | **Exact decision statement** | See **Block A**, statement **A-1** |
| **10** | **Currently actionable?** | 🟢 **YES — the least-dependent of the six.** Recommended first: one signature, one owner, no security engagement, no unselected engine, and it clears an internal MUST as well as the external one |

---

### 3.4 `ATT-CFG-012` — Minimum acceptable location accuracy

| # | Element | Content |
|---|---|---|
| **1** | **Exact setting name** | `ATT-CFG-012` — *Minimum acceptable location accuracy*. §16.3 L1166. Default: **`ATT-GAP-017`**. Allowed domain: *"Bounded distance — **unresolved**"*. Validation: *"Must be > 0"* |
| **2** | **Existing normative requirements** | `ATT-FR-045` (L740) — *"Where reported accuracy is worse than the configured threshold (`ATT-CFG-012`), the mode **MUST** fail with a distinguishable 'location inaccurate' reason"* · `ATT-AC-038` |
| **3** | **Why a default/range is required** | `LIB-16.2`. `ATT-FR-045` cannot fire without a threshold to compare against — the rejection reason it mandates is unreachable, so a MUST-class requirement is inert |
| **4** | **Current evidence** | **None.** Zero hits |
| **5** | **Existing documented options** | As `011`: **(a)**/**(b)**/**(c)**/**(d)**. Additionally **(f)** express `012` **relative to** `011` (accuracy must be at least as tight as some fraction of the radius), making the pair internally consistent by construction |
| **6** | **Decision owner** | **Product Owner — sole**, with technical input on device capability |
| **7** | **Dependencies** | Operationally coupled to `ATT-CFG-011`: **an accuracy tolerance looser than the acceptance radius makes the radius unenforceable** |
| **8** | **Consequence of each option** | **(a)**–**(d)** as `011`. **(f)** prevents the silent-disable failure at specification level: a `012` set looser than `011` disables the radius check *while appearing to enforce it*, and this is **the failure mode most likely to pass review unnoticed** because both values look reasonable in isolation. Cost: the two can no longer be tuned independently |
| **9** | **Exact decision statement** | See **Block A**, statement **A-2** |
| **10** | **Currently actionable?** | 🟢 **YES, jointly with `011`** |

---

### 3.5 `ATT-CFG-019` — OCR high-confidence threshold

| # | Element | Content |
|---|---|---|
| **1** | **Exact setting name** | `ATT-CFG-019` — *OCR high-confidence threshold*. §16.3 L1173. Default: **`ATT-GAP-017`**. Allowed domain: *"Bounded 0–1 — **unresolved**"*. Validation: *"Within bound"* |
| **2** | **Existing normative requirements** | `ATT-FR-077` (L945) — the high-confidence threshold **MUST** be configurable · `ATT-BR-027` (L942) — *"Confidence **MUST NOT** be self-certifying"* · `ATT-BR-028` (L948) — *"Even a high-confidence entry **MUST** be presented for creation, not created autonomously"* · **`ATT-FR-080` (L975) — build block**: *"Until `ATT-GAP-010` **and** `ATT-GAP-011` are answered by their named owners, the OCR/Vision workflow **MUST NOT** be implemented"* |
| **3** | **Why a default/range is required** | `LIB-16.2`. `ATT-FR-077` mandates configurability of a threshold that has no value and no range — *"Bounded 0–1"* is a **type, not a range**: it admits `0.01` and `0.99` equally |
| **4** | **Current evidence** | **None — and more than none.** `ATT-GAP-011` records that **no OCR capability is defined anywhere in `docs/**`**, and `LIBOORA_ENTERPRISE_ARCHITECTURE.md` has no OCR node. There is no engine whose confidence scale this number would refer to. A confidence threshold is a property *of a specific model measured on a specific dataset*; it is not portable between engines |
| **5** | **Existing documented options** | **(a)** Owner sets a number now · **(b)** Defer until an OCR engine is selected and measured · **(c)** PRD envelope + Guide value · **(d)** Descope the register-image workflow from V1 |
| **6** | **Decision owner** | **Two-stage.** **Architecture Owner (ARB)** must first resolve the prerequisites — `ATT-GAP-010` (may `BC-03` hold a `FileRef` from `BC-29`?) and `ATT-GAP-011` (who owns OCR/Vision?) — **then Product Owner** sets the threshold. Both prerequisites are the only two gaps in §32 whose owner entry reads *"needs an ADR"*; both are drafted as [`ADR-0022`](../../00-governance/adr/ADR-0022-bc-03-fileref-e22-consumer-list.md) and [`ADR-0023`](../../00-governance/adr/ADR-0023-ocr-vision-capability-ownership.md), **Proposed** |
| **7** | **Dependencies** | 🔴 **Hard-blocked** by `ATT-GAP-010` + `ATT-GAP-011` via `ATT-FR-080`. Blast radius **materially reduced** by `ATT-BR-028` and `ATT-CFG-020` (unattended creation, default **Disabled**): a mis-set `019` degrades staff review efficiency; it does **not** by itself create false attendance |
| **8** | **Consequence of each option** | **(a)** produces exactly the *"unreviewable magic number"* `AR-4` warns about — a threshold for an engine nobody has selected, which would have to be re-set on selection, so **deciding it now decides nothing**. **(b)** keeps the row open but makes the sequence explicit and correct. **(c)** requires an envelope nobody can defensibly bound without an engine. **(d)** removes `019` from the breach (7 → 6 today) and moots `ADR-0022`/`0023` for V1 |
| **9** | **Exact decision statement** | See **Block C**, statements **C-1** (Architecture Owner, prerequisite) and **C-2** (Product Owner, conditional) |
| **10** | **Currently actionable?** | 🔴 **NO — for the Product Owner.** 🟡 **YES — for the Architecture Owner**, as the prerequisite. This is the *only* setting of the six where the named final owner cannot legitimately answer today, and the block is another owner's to lift |

---

### 3.6 `ATT-CFG-023` — Correction window

| # | Element | Content |
|---|---|---|
| **1** | **Exact setting name** | `ATT-CFG-023` — *Correction window*. §16.3 L1177. Default: **`ATT-GAP-017`**. Allowed domain: *"Bounded duration — **unresolved**"*. Validation: *"Must be ≥ 0"* |
| **2** | **Existing normative requirements** | `ATT-FR-115` — applies *"where a correction window is configured"* · `ATT-AC-157` — an out-of-window correction is rejected · `ATT-BR-040` (L1308) — corrections are never silent · `ATT-FR-116` — full correction history |
| **3** | **Why a default/range is required** | `LIB-16.2` sentence 1, and nothing more. **This is the only one of the six with no second reason** |
| **4** | **Current evidence** | **None.** Zero hits. But note the structural difference recorded in `ATT-BR-044`: `ATT-FR-115`'s **conditional phrasing** means the absence of a window is already a *defined* behaviour — no window is enforced — rather than undefined behaviour |
| **5** | **Existing documented options** | **(a)** Owner sets a window + range · **(b)** Set the documented default to **"no window"** (unbounded correction) and record it explicitly · **(c)** PRD envelope + Guide value |
| **6** | **Decision owner** | **Product Owner — sole.** No security dimension, no architecture dimension |
| **7** | **Dependencies** | **None.** No open gap, no unselected engine, no coupled setting, no external owner |
| **8** | **Consequence of each option** | **(a)** data settles quickly and is more trustworthy; genuine errors found late become uncorrectable. **(b)** **closes the row without inventing a number** — *"no window"* is a real, specified default, not a substituted value, and it is what the specification already does; audit risk of an unbounded window is bounded by `ATT-BR-040` and `ATT-FR-116`, which guarantee no correction is silent and all history is retained. **(c)** defers a value that has no security or safety dimension — the most machinery for the least benefit |
| **9** | **Exact decision statement** | See **Block A**, statement **A-3** |
| **10** | **Currently actionable?** | 🟢 **YES — the cheapest of the six.** Option (b) is the single row where the existing behaviour is already correct and only needs to be **written down** |

---

## 4. Four approval blocks

> **How to use this section.** Each block is independently signable. Signing one does not commit you to any
> other. Each block states exactly what it achieves and — equally important — what it does **not**.
> **Choose one lettered option per statement.** An unmarked statement is not a decision.

---

## BLOCK A — Product Owner, sole authority

**Settings:** `ATT-CFG-011` · `ATT-CFG-012` · `ATT-CFG-023`
**Why this owner:** `PRD_OWNERSHIP_MODEL.md` §2.2 — *"Decides whether a requirement is correct and in scope."*
None of these three is a security parameter, none depends on an unselected engine, none requires an
Architecture Owner act.

| | |
|---|---|
| **Decision** | Choose the route by which a documented default and a bounded range are established for three operational/policy settings |
| **Evidence** | §3.3, §3.4, §3.6. Authoritative Rank 1–5 source for any value: **None**, verified negative twice |
| **Consequences** | Closing all three takes the measured breach from **7 → 4 today** (`005`, `006`, `014`, `019` remaining). It does **not** clear `LIB-16.2`. It **does** clear the internal `ATT-FR-042` breach, which is unique to `011` |
| **Owner** | **Product Owner** |
| **Actionable today** | 🟢 **YES — all three** |

### Exact statements to approve

**A-1 — `ATT-CFG-011` GPS acceptance radius.** *Approving this statement means:*

> *"As Product Owner I direct that `ATT-CFG-011`'s default and bounded allowed range be established by route
> ☐ **(a)** — I supply the default and range directly / ☐ **(b)** — anchored to an operational survey of
> representative tenant premises, the survey to be commissioned before the value is set / ☐ **(c)** — `PRD-006`
> states the envelope and `CONFIGURATION_GUIDE.md` sets the operating value within it / ☐ **(d)** — Fixed QR +
> GPS is descoped from V1 and `ATT-CFG-011` leaves the V1 configuration surface.
> I record that `ATT-FR-042` independently mandates both a default and a bounded range for this setting."*

| Route chosen | Value(s) supplied *(only if route (a))* | Signature | Date |
|---|---|---|---|
| ☐ a ☐ b ☐ c ☐ d | ____________________ | ____________________ | __________ |

**A-2 — `ATT-CFG-012` Minimum acceptable location accuracy.** *Approving this statement means:*

> *"As Product Owner I direct that `ATT-CFG-012`'s default and bounded allowed range be established by route
> ☐ **(a)** / ☐ **(b)** / ☐ **(c)** / ☐ **(d)** / ☐ **(f)** — `ATT-CFG-012` is defined **relative to**
> `ATT-CFG-011` such that the accuracy tolerance is at least as tight as a stated fraction of the acceptance
> radius, the fraction to be supplied with this approval.
> I record that a `012` looser than `011` disables the radius check while appearing to enforce it."*

| Route chosen | Value / fraction supplied *(only if (a) or (f))* | Signature | Date |
|---|---|---|---|
| ☐ a ☐ b ☐ c ☐ d ☐ f | ____________________ | ____________________ | __________ |

**A-3 — `ATT-CFG-023` Correction window.** *Approving this statement means:*

> *"As Product Owner I direct that `ATT-CFG-023`'s default and bounded allowed range be established by route
> ☐ **(a)** — I supply a window and range directly / ☐ **(b)** — the documented default is **'no window'**
> (unbounded correction), recorded explicitly as a specified default rather than an absent one, with an optional
> bounded range available to tenants who configure one / ☐ **(c)** — envelope in `PRD-006`, value in
> `CONFIGURATION_GUIDE.md`.
> I record that `ATT-BR-040` and `ATT-FR-116` bound the audit risk of an unbounded window."*

| Route chosen | Value(s) supplied *(only if route (a))* | Signature | Date |
|---|---|---|---|
| ☐ a ☐ b ☐ c | ____________________ | ____________________ | __________ |

---

## BLOCK B — Product Owner **and** Security Platform, jointly

**Settings:** `ATT-CFG-005` · `ATT-CFG-006`
**Why two owners:** these are **security parameters** — the rotation interval *is* the replay-attack defence
window. `PRD_OWNERSHIP_MODEL.md` §2.2 records that *"the Product Owner is not the default answer"*; Security
Platform is a **Domain Owner** (`PRD-012a`) and owns the threat model. `ATT-XC-013` forbids `PRD-006` from
specifying the construction, so the duration must be set by someone who knows what construction is feasible.

| | |
|---|---|
| **Decision** | Choose the route by which defaults and bounded ranges are established for two coupled security parameters |
| **Evidence** | §3.1, §3.2. **The near-miss is recorded and rejected**: the Authentication PRD's OTP expiry is not a source for `006` — different context, different threat model, different owner, and `ATT-BR-043` forecloses copying from *"another product"* |
| **Consequences** | Closing both takes the breach from **7 → 5 today**. `005` and `006` **must be decided together** — §16.3 makes each bound the other |
| **Owners** | **Product Owner** (decision) **+ Security Platform** (range, and the ratio if route (e)) |
| **Actionable today** | 🟡 **YES, with sequencing.** `ATT-GAP-006` (cryptographic construction) need only be *scoped*, not closed |

### Exact statements to approve

**B-1 — `ATT-CFG-005` Dynamic QR rotation interval.** *Approving this statement means:*

> *"As Product Owner, with Security Platform concurrence, I direct that `ATT-CFG-005`'s default and bounded
> allowed range be established by route ☐ **(a)** — I supply interval and range directly / ☐ **(b)** — Security
> Platform supplies the permitted range and I set the value inside it / ☐ **(c)** — `PRD-006` states the
> envelope, `CONFIGURATION_GUIDE.md` sets the operating value / ☐ **(d)** — Dynamic QR is descoped from V1 and
> `ATT-CFG-005` and `ATT-CFG-006` leave the V1 configuration surface.
> I record that §16.3 requires `005` ≤ `006` and that these two are decided as a pair."*

| Route | Range supplied by Security Platform | Value supplied by Product Owner | PO signature | Sec. Platform signature | Date |
|---|---|---|---|---|---|
| ☐ a ☐ b ☐ c ☐ d | ______________ | ______________ | ____________ | ____________ | ________ |

**B-2 — `ATT-CFG-006` Dynamic QR validity window.** *Approving this statement means:*

> *"As Product Owner, with Security Platform concurrence, I direct that `ATT-CFG-006`'s default and bounded
> allowed range be established by route ☐ **(a)** / ☐ **(b)** / ☐ **(c)** / ☐ **(d)** / ☐ **(e)** —
> `ATT-CFG-006` is defined as a stated multiple of `ATT-CFG-005`, the multiple to be supplied and endorsed by
> Security Platform, so that validity < rotation is unrepresentable.
> I record that the Authentication PRD's OTP expiry is **not** an authority for this value."*

| Route | Range / ratio supplied by Security Platform | Value supplied by Product Owner | PO signature | Sec. Platform signature | Date |
|---|---|---|---|---|---|
| ☐ a ☐ b ☐ c ☐ d ☐ e | ______________ | ______________ | ____________ | ____________ | ________ |

---

## BLOCK C — Architecture Owner prerequisite, then Product Owner

**Setting:** `ATT-CFG-019`
**Why two stages:** `ATT-FR-080` build-blocks the entire OCR/Vision workflow until `ATT-GAP-010` and
`ATT-GAP-011` are answered by the Architecture Owner. A confidence threshold for an engine that no document
selects, in a workflow that may not be built, is not a decision the Product Owner can defensibly make.

| | |
|---|---|
| **Decision** | **C-1** — resolve the two prerequisite architecture questions. **C-2** — set the threshold, conditional on C-1 |
| **Evidence** | §3.5. `ADR-0022` and `ADR-0023` are drafted, **Proposed**, and frame both questions with options and costs. Neither proposes an answer |
| **Consequences** | C-1 alone unblocks `ATT-FR-080` and moves `ATT-GAP-010`/`011` out of OPEN. C-1 + C-2 takes the breach from **7 → 6 today**. **C-2 without C-1 is not a legitimate decision** and this package will not accept one |
| **Owners** | **Architecture Owner (ARB)** — C-1 · **Product Owner** — C-2 |
| **Actionable today** | 🟡 **C-1 YES** · 🔴 **C-2 NO** |

### Exact statements to approve

**C-1 — Prerequisite (Architecture Owner / ARB).** *Approving this statement means:*

> *"As Architecture Owner I resolve the two prerequisites that `ATT-FR-080` names, by accepting the options
> selected in [`ADR-0022`](../../00-governance/adr/ADR-0022-bc-03-fileref-e22-consumer-list.md) §4 and
> [`ADR-0023`](../../00-governance/adr/ADR-0023-ocr-vision-capability-ownership.md) §4 and moving both ADRs from
> Proposed to Accepted. I record that `ADR-0023` must preserve `ATT-GAP-011`'s NARROWED classification: BC Map
> §7.4 `F-1`/`F-3`/`F-4` already fix **how** an OCR capability must reach `BC-03` once it exists, so no
> `BC-03` → `BC-27` edge is to be added."*

| `ADR-0022` option | `ADR-0023` option | Signature | Date |
|---|---|---|---|
| ☐ A ☐ B ☐ C ☐ D | ☐ A ☐ B ☐ C ☐ D | ____________________ | __________ |

**C-2 — `ATT-CFG-019` OCR high-confidence threshold (Product Owner, conditional on C-1).**

> *"As Product Owner, **and only once C-1 is signed and both ADRs are Accepted**, I direct that
> `ATT-CFG-019`'s default and bounded allowed range be established by route ☐ **(a)** — I supply a threshold and
> range now / ☐ **(b)** — deferred until an OCR engine is selected, the value then set from measured performance
> on a representative dataset / ☐ **(c)** — envelope in `PRD-006`, value in `CONFIGURATION_GUIDE.md` /
> ☐ **(d)** — the register-image workflow is descoped from V1 and `ATT-CFG-019` leaves the V1 configuration
> surface."*

| Route | Value(s) supplied *(only if (a))* | Signature | Date | C-1 signed first? |
|---|---|---|---|---|
| ☐ a ☐ b ☐ c ☐ d | ______________ | ____________ | ________ | ☐ yes |

> **Route (d) is signable today without C-1.** Descoping does not require the prerequisites to be answered — it
> removes the question. Routes (a)–(c) do require C-1.

---

## BLOCK D — Architecture Owner / ARB — Face Attendance = V3

**Decision:** ratify the Product Owner's ruling that Face Attendance is **V3**, not V1.

| | |
|---|---|
| **Decision** | Whether Face Attendance's release class is **V3**, as the Product Owner has decided and as `LIBOORA_ENTERPRISE_ARCHITECTURE.md` L754 already lists it (*"Face Recognition (V3)"*, **Rank 6 — descriptive only**) |
| **Options** *(verbatim from [`..._ATT-GAP-015_APPROVAL_REQUEST.md`](./PRD-006_ATT-GAP-015_APPROVAL_REQUEST.md))* | **A** — Face is **V1**: three architecture/legal gaps must be resolved before build · **B** — Face is **V3**: the class is ratified, `ATT-GAP-012`/`013`/`014` are **deferred, not closed**, and `ATT-CFG-014` leaves the V1 surface · **C** — defer the class decision itself |
| **Evidence** | Product Owner has recorded **✅ V3** ([`..._ATT-GAP-015_DECISION_RECORD.md`](./PRD-006_ATT-GAP-015_DECISION_RECORD.md) §1). ARB approval: **searched three times, repository-wide, across this and two prior operations — no approval record exists.** Every hit names the Architecture Owner as a *required decider* or *blocked-on party*; none records a decision. The Approval Request's signature lines are blank. **`ADR-0021` is the only ADR mentioning Face, and it is Proposed** |
| **Consequences of B** | `ATT-CFG-014` leaves the V1 configuration surface → the `LIB-16.2` breach narrows **7 → 6**. `ATT-GAP-012`, `013`, `014` leave the V1 path (**deferred, not closed**). `ATT-GAP-009`'s structural impasse is relieved — `BC-08` Inventory is V2 and can own a **V3** scanner though not a V1 one. `ATT-GAP-015` **closes**. Open-gap count 18 → 14. `ATT-CFG-013`, `015`, `016` were never in the breach and are unaffected |
| **Consequences of not signing** | `ATT-GAP-015` stays 🔴 **OPEN** — §32 names *"Product owner **+** architecture owner"* **conjunctively**, and the ledger records that the gap *"cannot self-close"*. The breach stays at **7**. **A one-sided decision creates a new blocker rather than removing one** |
| **Owner** | **Architecture Owner (ARB)** — §2.2: *"Decides ADR approval; **any Rank 1–5 document change**."* Ratifying a release class requires a Rank 2 ADR; correcting Rank 6 EA is an architecture act |
| **Actionable today** | 🟢 **YES.** Nothing blocks this signature. It is the single highest-leverage item in this package |

### Exact statement to approve

> *"As Architecture Owner, acting through the role defined in `PRD_OWNERSHIP_MODEL.md` §2.2, I approve
> Option **☐ A** / **☐ B** / **☐ C** for `ATT-GAP-015`. If **B**: Face Attendance is ratified as **V3**;
> `ATT-GAP-012`, `ATT-GAP-013` and `ATT-GAP-014` are **deferred to V3, not closed**; `ATT-CFG-014` leaves the V1
> configuration surface; and I direct whether a Rank 2 ADR recording this ruling is to be raised —
> ☐ **raise it** / ☐ **not required**."*

| Option | Rank 2 ADR | Signature | Date |
|---|---|---|---|
| ☐ A ☐ B ☐ C | ☐ raise ☐ not required | ____________________ | __________ |

> **Whether to raise an ADR is the Architecture Owner's call, not this package's.**
> [`..._ATT-GAP-015_DECISION_PACK.md`](./PRD-006_ATT-GAP-015_DECISION_PACK.md) §5.1: *"A separate ADR is the
> appropriate instrument. Whether to raise one is the Architecture Owner's call."* No Face ADR has been drafted
> for exactly this reason — drafting one would pre-empt the decision it exists to record.

---

## 5. What each combination of signatures actually achieves

**Recomputed for this package. Every figure is arithmetic on the measured baseline of 7 breaching settings.**

| Signed | Breaching settings | `LIB-16.2` sentence 1 | Open gaps | Freeze-eligible? |
|---|---|---|---|---|
| Nothing *(today)* | **7** | 🔴 breached | **18** | **No** |
| **D** only | **6** | 🔴 breached | **14** | No |
| **A** only | **4** | 🔴 breached | 18 | No |
| **A + B** | **2** (`014`, `019`) | 🔴 breached | 18 | No |
| **A + B + D** | **1** (`019`) | 🔴 breached | 14 | No |
| **A + B + C + D** | **0** | ✅ **satisfied** | ≤ 12 | **Then, and only then, re-audit** |

> **The last row is not a promise of freeze.** It clears the `LIB-16.2` breach, which is the *substantive*
> blocker. Stage 7 additionally requires an admitting ADR and a row in `DOCUMENTATION_BASELINE.md` §3 — see
> [`..._STAGE7_READINESS_AUDIT.md`](./PRD-006_STAGE7_READINESS_AUDIT.md) §7, which lists the eight steps in order.

---

## 6. What this package deliberately did not do

| Not done | Why |
|---|---|
| **Proposed a value for any of the six** | `ATT-BR-043` forbids substitution from *"another tenant, another mode, another product or an example in this document"*. `PRD-006` §0.4: *"A gap resolved by implementation choice is not resolved — it is an undocumented architecture decision made by whoever happened to write the code first"* |
| Invented an option not already in the repository | Every option in §3 and §4 is drawn verbatim from `..._ATT-GAP-017_DECISION_SHEET.md` §3 or `..._ATT-GAP-015_APPROVAL_REQUEST.md` |
| Modified `PRD-006` | Byte-identical: `93ab1c60d740c4e0…` |
| Closed, narrowed or reclassified any gap | No owner has decided. `ATT-GAP-015` and `ATT-GAP-017` both remain 🔴 **OPEN** |
| Accepted, drafted or modified any ADR | `ADR-0021`, `ADR-0022`, `ADR-0023` all remain **Proposed** |
| Drafted a Face ADR | Whether to raise one is the Architecture Owner's call — Block D asks it |
| Touched `PRD_REGISTRY.md`, `DOCUMENTATION_BASELINE.md`, `ADR-INDEX.md`, the BC Map or the Dependency Matrix | None is modifiable to make a gate green |
| Signed anything on an owner's behalf | Every signature field in §4 is blank, and that is the point of the document |

---

## 7. Verification — every claim in this package, recomputed

| # | Claim | Method | Result |
|---|---|---|---|
| 1 | 7 settings carry `ATT-GAP-017` in the Default column | Read §16.3 L1155–1178 | ✅ `005`, `006`, `011`, `012`, `014`, `019`, `023` |
| 2 | 24 configurables total | Stage 5 gate | ✅ `ATT-CFG-001`…`024` |
| 3 | No owner decision recorded for any of the six | Repo-wide grep for a decided/approved/signed value | ✅ **0** |
| 4 | No Rank 1–5 authoritative value source | Repo-wide search, second independent pass | ✅ **None** |
| 5 | ARB approval for Face V3 does not exist | Third independent repo-wide search | ✅ **Not found** |
| 6 | `ADR-0021`, `0022`, `0023` all **Proposed** | `grep '^\| \*\*Status\*\*'` on all three | ✅ 3 of 3 |
| 7 | `ATT-FR-042` mandates default **and** range for `011` | Read L737 | ✅ Verbatim |
| 8 | `ATT-FR-080` build-blocks OCR | Read L975 | ✅ Verbatim |
| 9 | `PRD-006` unmodified | `sha256sum` | ✅ `93ab1c60d740c4e0…` |
| 10 | Stage 5 gate passes on the current tree | `prd006_traceability.py` | ✅ exit 0 |
| 11 | Stage 6 gate passes on the current tree | `prd006_task_coverage.py` | ✅ exit 0, 285/285 |
| 12 | No value proposed anywhere in this document | Read-through | ✅ Zero numerals offered as a value |

---

## 8. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-04 | Created. **Consolidates four existing decision artefacts into ONE signable package** covering all six configurables plus Face V3, organised into four independently-signable blocks by owner: **A** Product Owner sole (`011`, `012`, `023`), **B** Product Owner + Security Platform (`005`, `006`), **C** Architecture Owner prerequisite then Product Owner (`019`), **D** Architecture Owner / ARB (Face V3). Each of the six settings carries all ten mandated elements; each block carries decision, options, evidence, consequences, owner, signature field and an exact statement to approve. Records the **measured** state: **7** settings breaching `LIB-16.2` today (not six — `ATT-CFG-014` leaves the V1 surface only on Block D), **0** owner decisions recorded anywhere, **0** authoritative value sources, **3** ADRs Proposed and none Accepted, ARB approval **absent on a third independent search**. Identifies **two of the six as not currently actionable by their named final owner** — `019` is hard-blocked by `ATT-FR-080`, and `005`/`006` require Security Platform engagement — and states that plainly rather than presenting six equivalent questions. Records the arithmetic of every signature combination in §5, including that clearing all four blocks satisfies `LIB-16.2` but **does not by itself confer freeze**. **No value is proposed for any setting, no option is invented, no gap is closed, no ADR is created or accepted, and `PRD-006`, `PRD_REGISTRY.md`, `DOCUMENTATION_BASELINE.md`, `ADR-INDEX.md`, the BC Map and the Dependency Matrix are all byte-identical.** |
