# `PRD-010` — Authority decision package

| Field | Value |
|---|---|
| **Document** | `docs/30-product/notifications/PRD-010_AUTHORITY_DECISION_PACKAGE.md` |
| **Version** | **v1.0** |
| **Type** | ⛔⛔ **DECISION PACKAGE — a request for decisions, not a record of them.** Confers nothing. Not a PRD, not an ADR, not a conferral |
| **Date** | 2026-09-05 |
| **Subject** | `PRD-010_NOTIFICATIONS_AND_COMMUNICATION.md` **v0.9 `DRAFT`** |
| **HEAD at audit** | `682704ec700aa00961b21f598ebd8788852ecb6f`, branch `main`, tree **clean** |

> ⛔⛔ **THE GOVERNING MEASUREMENT, RE-RUN THIS PASS AND STATED FIRST.**
> `grep -rl "NTF-CFG\|NTF-GAP\|PRD-010" docs/00-governance/adr/` → **0 files across all 94 ADRs.**
> ⇒ **No authority act exists for `PRD-010` anywhere in this repository.** Every recommendation below
> is therefore **[RECOMMENDED — NOT AUTHORITATIVE]** or **[OWED]**. ⛔ **Nothing is promoted.**

---

## 1. Two defects in the proposal as received, found before any evaluation

⭐ **Defect 1 — `NTF-CFG-006` is mislabelled in the instruction.** It arrives described as
*"configuration authority"*. ⛔ Measured at subject **L523**, `NTF-CFG-006` is the **deduplication
window** (`NTF-FR-045`, `NTF-FR-049`). *"Configuration authority"* was **`NTF-FR-054`**, which subject
**v0.3** reclassified **out** of the configuration register entirely, because `FIL-XC-009` forbids this
PRD defining a *"resolution order"* and `ADR-0017` §2.5 assigns it to `PRD-023`.
⇒ **Evaluated as the dedup window.** ⛔ **No "configuration authority" slot is created** — doing so
would re-import an obligation already ruled out of scope.

⭐ **Defect 2 — the `NTF-CFG-001` range is unsupported at its ceiling.** See §2.1. The **default 500**
also fails, but for a *different and more interesting* reason than the range.

---

## 2. Product Owner decisions

### 2.1 `NTF-CFG-001` — bulk recipient ceiling and dispatch rate limit

| Field | Content |
|---|---|
| **Proposed** | **500**, range **1 – 1000** |
| **Verdict** | ⛔⛔ **REJECTED — both the default and the range** |

⛔ **Why rejected — measured, not asserted.** Every comparable bulk/abuse ceiling in the repository is
**an order of magnitude smaller**, and each caps its range at **500 or below**:

| Precedent | Default | Range | Rationale (verbatim) |
|---|---|---|---|
| `ICFG-5` outstanding invitations **per library** | **50** | **1 – 500** | *"Bounds the damage of a compromised Owner account, and the cost of enumeration"* |
| `ICFG-6` max acceptances per `IT-3` code | **25** | **1 – 200** | *"A **classroom-sized cohort**"* |
| `ICFG-7` invitations creatable per hour per library | **20** | **1 – 100** | *"Rate limit on the **issuing** side"* |
| `CFG-3` OTP requests per origin/hour | **100** | **50 – 500** | *"**Above 500:** the control stops meaning anything"* |

⇒ ⛔ **`1000` exceeds every ceiling in the register, and `CFG-3`'s own rationale supplies the sentence
that refutes it**: above 500 *"the control stops meaning anything."* A 1000-recipient ceiling on a
tenant-bounded audience is not an abuse control; it is the absence of one.

⭐⭐ **But the default `500` fails for a sharper reason, and this is the substantive finding.** The
repository contains an authoritative **tenant-sizing** fact, in `CFG-3`'s corrected rationale
(`CONFIGURATION_GUIDE.md` **L131-132**):

> *"A study hall is a **single NAT gateway with sixty to two hundred students behind it**."*

⇒ ⭐ **A tenant's entire eligible audience is ~60–200 students.** `NTF-FR-010` requires that *"All"*
mean *"an explicitly named, **tenant-bounded**, role-filtered eligible audience"* — so a bulk dispatch
**cannot** exceed one tenant's population. ⇒ **A ceiling of 500 is already above the largest realistic
audience, and 1000 is 5× it.** Such a ceiling can never fire, which makes it a control in name only.

#### ⭐ Alternative recommendations, strongest first

| # | Value | Range | Evidence | Rationale | Status |
|---|---|---|---|---|---|
| **A1** | **200** | **1 – 500** | `CONFIGURATION_GUIDE` **L131-132** (*"sixty to two hundred students"*); `ICFG-5` range **1–500**; `CFG-3` *"above 500 the control stops meaning anything"* | ⭐ **Default = the documented upper bound of a real tenant**, so a legitimate whole-tenant announcement succeeds while an implausible one is refused. Range ceiling matches the two existing bulk precedents exactly | ⚠ **[RECOMMENDED — NOT AUTHORITATIVE]** |
| **A2** | **250** | **1 – 500** | as A1 | Adds ~25% headroom over the documented maximum for an unusually large venue | ⚠ **[RECOMMENDED]** — weaker: the headroom is **not** evidenced |
| **A3** | ⛔ **[OWED]** | — | — | If the PO holds that tenant population is a **product** fact not yet fixed, no ceiling can be derived and the slot stays owed | **[OWED]** |

⚠ **Rate limit is a SECOND value inside this slot and is NOT recommended.** `NTF-CFG-001` bundles a
*count* ceiling and a *dispatch rate limit*. `ICFG-7` shows the repository models issuing-rate
separately (*"per hour per library"*), and ⛔ **no notification-dispatch rate evidence exists at any
rank.** ⇒ ⭐ **The PO should consider splitting the slot**; the rate limb is **[OWED]** either way.

### 2.2 `NTF-CFG-003` — mandatory vs optional classification

| Field | Content |
|---|---|
| **Range** | ✅ **`{mandatory, optional}`** — enumerated, **[EVIDENCE]**, from `NTF-FR-038` |
| **Per-entry default** | ⛔ **[OWED]** |

⛔ **No classification is proposed, and the reason is a Rank-1 boundary rather than caution.**
`NTF-FR-038` requires that *"Optional entries honour opt-out; mandatory entries **MUST NOT** be
opt-outable."* ⇒ ⭐⭐ **Marking an entry `mandatory` REMOVES a user's ability to opt out** — a consent
decision, and `MP-GBR-35` places consent/unsubscribe with `BC-22` while the **classification** of a
business notice is a Product judgement about the notice's purpose.

⚠ **What the evidence does supply, offered as input rather than as an answer:** the 13 catalogue
entries divide observably into **transactional** notices arising from an action the recipient took or
owns (enrolment, membership created/renewed/expired, seat assigned) and **advisory/administrative**
notices (occupancy threshold, fraud signal, expiring-soon reminders). ⛔ **The mapping is not asserted**
— `NTF-GAP-015` stays **OPEN**, owner **Product Owner**.

---

## 3. Architecture Owner decisions

### 3.1 `NTF-CFG-004` — retry attempt bound

| Field | Content | Status |
|---|---|---|
| **Unit** | **total attempts, including the first** | ✅ **[AUTHORITATIVE]** — `job_runtime.dart` **L103-104** (`contracts`, rank 0) |
| **Floor** | **≥ 1** | ✅ **[AUTHORITATIVE]** — enforced **executably**, `services.dart` **L152-159**, quoting `INV-21` |
| **Value** | **3** | ⚠ **[RECOMMENDED — NOT AUTHORITATIVE]** |
| **Range** | **1 – 5** | ⚠ **[RECOMMENDED]** |

**Rationale.** With **no** inter-attempt delay at V1 (`services.dart` **L196-221**, 0 delay
primitives), a larger budget buys **N near-simultaneous calls to a failing provider**, not a wider
recovery window. `1` renders `NTF-FR-047`'s retry obligation inoperative; `2` is defensible but
unsupported; `4` is indistinguishable from `3` on evidence; ⛔ **`5` is rejected** — the repository's
only `5` is **adversarial** (`AUTH-3.9`, an attacker's guess bound, listed *"not configurable"* at
`CONFIGURATION_GUIDE` **L41**). `5` remains acceptable as a **range ceiling** though rejected as a
default.

⚠ **MUST be ratified jointly with `NTF-CFG-007`** — the feasibility inequality
*attempts × per-attempt duration ≤ deadline* cannot be checked otherwise. Precedent: `ADR-0057` set
`FIL-CFG-015` (120 s) and `FIL-CFG-014` (3) **in one act**.

### 3.2 `NTF-CFG-005` — retry / backoff policy

| Option | Assessment | Status |
|---|---|---|
| **B1 — no backoff at V1**, declared explicitly | ⭐ **Least-invention path.** Consistent with the adapter (0 delay primitives) and with EA **L1808** placing *"Retry & Backoff"* at **V2**. ⚠ Requires an explicit AO statement, because fixing V1 behaviour **by omission** is still a decision | ⚠ **[RECOMMENDED — NOT AUTHORITATIVE]** |
| **B2 — configurable backoff now** | ⛔ **Rejected.** **0** backoff schedules at Rank 1–5; every occurrence is a refusal (`ADR-0028`, `ADR-0035` §5.5b, `ADR-0044`, `ADR-0045`, `LCN-FR-050`) or a **provider's own** policy (`ITG-FR-022` `[RZP]`). A value would have **nothing to execute it** | ⛔ **[OWED]** |
| **B3 — ADR** | ⭐ Appropriate **if** B1 is chosen, since declaring "no backoff at V1" fixes behaviour a V2 subsystem will change | — |

⛔ **No timing, delay, jitter or multiplier is proposed.**

### 3.3 `NTF-CFG-006` — deduplication window *(the slot's real subject; see §1)*

| Field | Content |
|---|---|
| **Value** | ⛔ **[OWED]** |
| **Constraint** | ⭐⭐ **Bounded BELOW by an invariant, not by taste** — `NTF-INV-007` forbids retry producing *"a second user-visible notification"*, so a window expiring **while a retry is in flight** violates it ⇒ the window **MUST exceed** the worst-case attempt-run duration |
| **Coupling** | ⛔ **`NTF-CFG-004`, `-005` and `-006` are NOT independently choosable** — `NTF-GAP-018` carries all three |
| **Refused import** | ⛔ `PRD-019`'s 30-day retention is **inapplicable**: an opaque `(tenant, event-id)` **transport** key is not a `(eventId, recipientId, channel, templateId)` **user-visibility** key |

### 3.4 `NTF-CFG-007` — delivery / job deadline

| Field | Content |
|---|---|
| **Semantics** | ✅ **[EVIDENCE]** — a **transport / attempt-run** bound on **one submitted delivery run**. **ONE clock suffices**: quiet-hours deferral and cancellation occur in the **pre-submission `queued`** state (`NTF-FR-014`, `NTF-FR-046`, `NTF-FR-048`), so a deferred notification is not a running job |
| **Value** | ⛔⛔ **[OWED] — no number proposed** |

⛔ **Why no number can be derived.** The value must satisfy
*attempts × per-attempt duration ≤ deadline*, and the **per-attempt duration is the provider's
timeout** — `NTF-GAP-017`, unresolvable because the repository does **not** contain FCM's documentation
(the `ADR-0045` condition). ⭐ `PRD-017` could derive `3` **only because** `ADR-0057` had already fixed
its companion timeout at **120 s**; `PRD-010` has **no analogue**. ⇒ **Inventing one is refused.**

### 3.5 `job_runtime` dependency — manifest decision

| Field | Content |
|---|---|
| **Required change** | ⭐ **ONE line**: add `platform/services:job_runtime` to `platform/communication`'s `ports:` list |
| **Shape** | The **`A-3` precedent** (`amendments_applied` **L715-721**), by which this same module gained `platform/identity:notification_address` |
| **`L2` waiver** | ⛔ **NOT required** — `platform/services` **rank 3** → `platform/communication` **rank 5** is **strictly downward** (manifest **L26-49**; Matrix **L49**) |
| **ADR required?** | ✅ **YES.** `DOCUMENTATION_BASELINE.md` §7: *"A change to any Rank 1–5 document requires an ADR **before** the change."* The manifest is **Rank 4** |
| **Mechanism exists?** | ✅ Port `job_runtime.dart` **L100**; adapter `InProcessJobRuntime` `services.dart` **L100**, registered `di.dart` **L240-243** |

⛔ **Manifest NOT modified by this package.**

---

## 4. AO + PO — `NTF-GAP-027` limb 3 (quiet hours)

| Field | Content |
|---|---|
| **Status** | ⛔ **[OPEN]** — limbs 1 and 2 were already resolved by **existing** authority at subject **v0.8** |
| **The conflict** | **Rank 1 `MP-GBR-35`**: quiet hours *"are owned by `BC-22` and apply to **every** channel"*; **BC Map L131**: `BC-22` *"Owns … quiet hours"*; ⚠ **EA L1447**: *"Quiet Hours & DND **(V2)**"* |
| **Governing rule** | ⭐ **`MP-CON-08`** — the EA is *"descriptive, not prescriptive"* and such a disagreement is *"**a defect to be raised, not a choice to be made**"* |
| **Recommendation** | ⚠ **Raise as a defect.** ⛔ **No V1/V2 answer proposed and no quiet-hours slot minted** — minting one would presuppose the answer `MP-CON-08` reserves |

⚠ **Note for the deciders:** `NTF-FR-039` (*"defer, never drop"*) is **already** a stated V1 obligation
in the subject, so a V2 ruling would leave that requirement without a mechanism — which is precisely
why the disagreement must be resolved rather than absorbed.

---

## 5. SRE / Observability — `NTF-FR-065` SLO / SLI

| Field | Content | Status |
|---|---|---|
| **Unit** | **`% monthly`** | ✅ **[EVIDENCE]** — `authentication/prd-v2/11-NFR-Compliance-and-Final-Acceptance.md` **L67-69**. ⛔ *"rolling 30 d"* has **0** occurrences repository-wide |
| **Ceiling** | **≤ 99.9%** | ✅ **[EVIDENCE]** — a dependent sits **below** its dependency (`ADR-0100` §3.2); `BC-18` is 99.95% |
| **Ordering** | Notification is the **least** availability-critical plane ⇒ it **cannot** carry a **tighter** outage bound than authentication's 30 min | ✅ **[EVIDENCE]** — `NTF-INV-011` |
| **Numeric SLO / SLI / error budget** | ⛔⛔ **[OWED]** | — |

⛔⛔ **Two independent reasons no number is proposed.** (1) ⭐ **The repository has NEVER ratified an SLO
for anything** — `ADR-0102` ratified a **target** and left **`SRE-GAP-001` expressly OPEN** on the
SLO/SLI/error-budget limbs; a value here would be the repository's **first**, claiming more than the
one conferred SRE act claimed for itself. (2) ⭐ **A fresh conferral is required** — `ADR-0033` §7.1:
*"a conferral for one act is not a standing licence"*, and `ADR-0102`'s office was **`PRD-015`-only**.

---

## 6. Consolidated authority decision matrix

| ID | Value | Range | Evidence | Authority | Status |
|---|---|---|---|---|---|
| `NTF-CFG-001` ceiling | **200** *(alt: 250)* | **1 – 500** | `CONFIGURATION_GUIDE` **L131-132**, `ICFG-5`, `CFG-3` | Product Owner | ⚠ **[RECOMMENDED]** |
| `NTF-CFG-001` rate limit | ⛔ none | ⛔ none | **0** at any rank | Product Owner | **[OWED]** |
| `NTF-CFG-002` | **`en`** | Supported set | `Library_PRD_v1.md` **L717** (FROZEN R3) | Product | ✅ **[AUTHORITATIVE]** |
| `NTF-CFG-003` | ⛔ per-entry none | `{mandatory, optional}` | `NTF-FR-038` | Product Owner | Range **[EVIDENCE]** · default **[OWED]** |
| `NTF-CFG-004` | **3** | **1 – 5** | `job_runtime.dart` **L103-104**; `services.dart` **L152-159**, **L196-221** | Architecture Owner | Unit+floor ✅ **[AUTHORITATIVE]** · value ⚠ **[RECOMMENDED]** |
| `NTF-CFG-005` | *no backoff at V1* | n/a | adapter 0 delays; EA **L1808** | Architecture Owner | ⚠ **[RECOMMENDED]** + ADR |
| `NTF-CFG-006` | ⛔ none | ⛔ none | `NTF-INV-007` lower bound | Architecture Owner | **[OWED]** |
| `NTF-CFG-007` | ⛔ none | ⛔ none | semantics **[EVIDENCE]**; timeout `NTF-GAP-017` | Architecture Owner | **[OWED]** |
| `job_runtime` port | one line, `A-3` shape | n/a | manifest **L26-49**, **L715-721** | Architecture Owner | ⚠ **[RECOMMENDED]** · **ADR required** |
| `NTF-GAP-027` limb 3 | ⛔ none | n/a | `MP-GBR-35` vs EA **L1447** | AO + PO | **[OPEN]** — raise as defect |
| `NTF-FR-065` | ⛔ none | ≤ 99.9% monthly | auth NFR **L67-69**; `ADR-0100` §3.2 | SRE (fresh conferral) | Unit+ceiling **[EVIDENCE]** · value **[OWED]** |

⇒ ⭐ **1 of 11 lines is [AUTHORITATIVE]**, and it was authoritative before this package.
⛔ **0 promotions performed.**

---

## 7. Stage status — unchanged

| Stage | Result |
|---|---|
| **3** | ✅ **PASS 6/6** — highest legitimately completed stage |
| **4** | ⛔ **NOT READY / NOT CONFERRED** — check 3 still fails (**1 of 7** slots satisfied); conferral belongs to the **Requirements Reviewer** (`PRD_LIFECYCLE.md` §6 **L278**) |
| **5** | ⛔ **NOT ENTERED** — `NTF-` = **0** in `TRACEABILITY_MATRIX.md` |
| **6** | ⛔ **NOT ENTERED** — **0** `IMPL-*` |
| **7** | ⛔ **NOT ENTERED** — **0** baseline rows |

⭐ **This package changes no stage.** A recommendation is an input to a decision, not the decision.

---

## 8. What this package does NOT do

| ⛔ | Confirmation |
|---|---|
| Promote any value | **0** — `[RECOMMENDED]` → `[AUTHORITATIVE]` conversions: **0** |
| Manufacture an authority act | **0** — no PO/AO/SRE/Governance/Reviewer act claimed |
| Create an ADR | **0** — count stays **94** |
| Modify the manifest | **0** — Rank 4; §7 requires an ADR first |
| Invent a number | **0** ceilings adopted, **0** rates, **0** classifications, **0** deadlines, **0** backoff timings, **0** dedup windows, **0** SLOs |
| Close a gap | **0** — **27 OPEN** |
| Mint an identifier | **0** |
| Touch a frozen or ranked document | **0** `MASTER_PRD` · **0** BC Map · **0** EA · **0** matrix · **0** `CONFIGURATION_GUIDE` · **0** frozen PRDs · **0** baseline · **0** registry |
| Create Stage 5/6/7 artefacts | **0** |
| Touch code or tests | **0** — port, adapter and DI read **as evidence only** |

---

## 9. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-05 | Created. ⭐⭐ **Two defects in the instruction's own proposal found before evaluation:** (1) **`NTF-CFG-006` is mislabelled** — it arrives as *"configuration authority"* but is the **deduplication window** (subject **L523**); *"configuration authority"* was `NTF-FR-054`, which v0.3 reclassified **out** of the register under `FIL-XC-009` / `ADR-0017` §2.5 ⇒ evaluated as the dedup window and **no new slot created**. (2) ⛔⛔ **`NTF-CFG-001 = 500, range 1–1000` REJECTED on both limbs** — every comparable ceiling is an order of magnitude smaller and caps at ≤ 500 (`ICFG-5` 50/1–500 · `ICFG-6` 25/1–200 · `ICFG-7` 20/1–100 · `CFG-3` 100/50–500), and `CFG-3`'s own rationale supplies the refuting sentence: *"**Above 500:** the control stops meaning anything."* ⭐⭐ **The sharper finding is about the DEFAULT:** `CONFIGURATION_GUIDE` **L131-132** records an authoritative tenant-sizing fact — *"a single NAT gateway with **sixty to two hundred students** behind it"* — and `NTF-FR-010` bounds a dispatch to one **tenant**, so **500 already exceeds the largest realistic audience and 1000 is 5×** it: a ceiling that can never fire is a control in name only. ⇒ **Alternative A1 = 200, range 1–500** (default = the documented upper bound of a real tenant; range ceiling matching both bulk precedents), with **A2 = 250** offered and marked weaker because its headroom is unevidenced, and **A3 = [OWED]**. ⚠ **The rate-limit limb is separated and left [OWED]** — `ICFG-7` shows the repository models issuing-rate separately and **0** notification-dispatch rate evidence exists; a slot split is suggested. ⛔ **`NTF-CFG-003` classification NOT asserted** — marking an entry `mandatory` **removes** opt-out under `NTF-FR-038`, a consent-adjacent Product judgement; the transactional/advisory division is offered as **input**, not an answer. ✅ **`NTF-CFG-004`** unit and floor confirmed **[AUTHORITATIVE]** from the **rank-0** port contract and its **executable** guard; value **3** / range **1–5** ⚠ **[RECOMMENDED]** with `5` rejected as a default because the repository's only `5` is **adversarial** (`AUTH-3.9`, *"not configurable"*). ⭐ **`NTF-CFG-005`**: three options, **B1 "no backoff at V1" recommended with an ADR** because fixing behaviour **by omission** is still a decision; **B2 rejected** (0 schedules at Rank 1–5; nothing would execute a value). ⛔ **`NTF-CFG-006` [OWED]** but shown **bounded below by `NTF-INV-007`**; `PRD-019`'s 30-day retention **refused as inapplicable**. ⛔⛔ **`NTF-CFG-007` [OWED] with NO number** — the inequality needs the provider timeout (`NTF-GAP-017`, absent FCM documentation), and `PRD-017` could derive `3` **only because** `ADR-0057` had already fixed its 120 s companion. ⭐ **Manifest**: one line, `A-3` shape, **no `L2` waiver** (rank 3 → 5 downward), but **ADR required first** (baseline §7, Rank 4). ⛔ **`NTF-GAP-027` limb 3** raised as an **`MP-CON-08` defect**, not decided. ⛔⛔ **`NTF-FR-065` [OWED]** on two independent grounds — the repository has **never** ratified an SLO, and `ADR-0033` §7.1 bars reusing `ADR-0102`'s `PRD-015`-only office. ⇒ **1 of 11 matrix lines is [AUTHORITATIVE]**, and it already was. ⛔ **0 promotions · 0 authority acts · 0 ADRs (94) · 0 manifest · 0 values invented · 0 gaps closed (27 OPEN) · 0 identifiers minted · 0 Stage 5/6/7 artefacts · 0 frozen documents · 0 code · 0 tests.** Stage 4 remains **NOT READY / NOT CONFERRED**; highest completed stage **Stage 3**. |
