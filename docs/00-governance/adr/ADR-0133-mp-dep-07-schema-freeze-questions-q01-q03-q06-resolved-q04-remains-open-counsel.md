# ADR-0133 — `MP-DEP-07` schema-freeze questions: **`Q-01`, `Q-03` and `Q-06` are RESOLVED**; **`Q-04` REMAINS OPEN** because it requires Legal counsel, which is not conferred

| Field | Value |
|---|---|
| **ADR** | `ADR-0133` |
| **Status** | ⭐ **Accepted** — 2026-09-10, by direct, explicit conferral of the human principal of this engagement, jointly exercising **Product Owner** and **Architecture Owner** (sitting as **ARB**, and as **`BC-04` owner**) authority, scoped to **this act and nothing else**. Same disclosure as `ADR-0033`, `ADR-0036`, `ADR-0129`…`ADR-0132`: ⛔ **no ARB quorum, attendee list, sign-off date, Security review or Legal opinion is asserted**, and *"a conferral for one act is not a standing licence"* (`ADR-0033` §7.1) — both offices ⛔ **revert on completion** |
| **Date** | 2026-09-10 |
| **Act performed** | ⭐ **Resolve the `MP-DEP-07` schema-freeze open questions that existing governed evidence and the conferred authority can lawfully close.** ⛔ **NOTHING ELSE.** |
| **Outcome** | ⭐ **`Q-01` RESOLVED** (by recognition — already answered) · ⭐ **`Q-03` RESOLVED** · ⭐ **`Q-06` RESOLVED** · ⛔⛔ **`Q-04` REMAINS OPEN — STOPPED, not guessed** |
| **Supersedes** | **Nothing.** ⛔ No ADR is amended, restatused, rewritten or superseded |
| **Amends** | `MASTER_PRD.md` **v1.9 → v1.10** (Rank 1) · `LIBOORA_BOUNDED_CONTEXT_MAP.md` **v1.14 → v1.15** (Rank 4) · `ADR-INDEX.md` · `DOCUMENTATION_BASELINE.md` — each by the **smallest change**, enumerated in §8 |

---

## 1. The four questions, verbatim, and the disposition of each

| Q | Question (BC Map §13, verbatim) | Before | After |
|---|---|---|---|
| **`Q-01`** | *"Does an expired membership release the seat immediately, at end-of-day, or after a grace period?"* | ⛔ **Open** — *"recommendation: configurable, default 24h"* | ⭐ **RESOLVED — after a grace period of 3 calendar days**, `W₀ = D+1`, fixed and mandatory V1 |
| **`Q-03`** | *"Entitlement fail-open or fail-closed on timeout?"* | ⛔ **Open** — *"recommendation: per-gate; paid features fail-closed"* | ⭐ **RESOLVED — per feature, from an external configured value**; ⛔ no platform-wide default |
| **`Q-04`** | *"Retention period for `StudentAttendance` after enrollment archival?"* | ⛔ **Open** — *"needs counsel"* | ⛔⛔ **REMAINS OPEN — requires Legal counsel, which this conferral does NOT include** |
| **`Q-06`** | *"Who owns proration arithmetic — BC-02 (rules) or BC-20/Business (execution)?"* | ⛔ **Open** — *"recommendation: `BC-02` computes entitlement delta, Business executes money"* | ⭐ **RESOLVED — `BC-02` owns the entitlement delta; money execution is V2 and belongs to the Business Platform** |

⭐ **Three of four resolved. One stopped.** The stop is §5, and it is the most important section in this ADR.

---

## 2. `Q-01` — RESOLVED by recognition: it was already answered

⚠⚠ **The central finding: `Q-01` did not need a new decision. It needed someone to notice it had already been
decided.**

**`ADR-0036` is `ACCEPTED`** — *"In force. Binding on all implementation"*, *"on all three questions as of
2026-08-31"* — and its §7 gap table records, in its own words:

> | `Q-01` / `SEAT-GAP-003` / `MM-GAP-001` | Seat release timing after expiry | Architecture Owner + `BC-04` owner |
> ✅ **ANSWERED at v2.0 — a 3-calendar-day protection window, mandatory V1** |

**Its §8 outcome table answers all three of its own questions:**

| # | Question | `ADR-0036` outcome |
|---|---|---|
| **1** | Is `Q-01` answered as *"after a 3-calendar-day grace period"*? | ✅ **ANSWERED — YES**, *"3-day renewal protection remains mandatory V1"* |
| **2** | Does the window include `endDate`, or begin the day after? | ✅ **ANSWERED 2026-08-31 — `W₀ = D+1`** |
| **3** | Fixed platform default, or tenant-configurable? | ✅ **ANSWERED — FIXED**, ⛔ not tenant-configurable, ⛔ no `SEAT-CFG-*`/`BC-25` identifier granted |

### 2.1 The resolution

⭐ **`Q-01` is RESOLVED: an expired membership releases the seat *after a grace period* — a 3-calendar-day
protection window beginning `D+1`, fixed at platform level and mandatory in V1.**

⭐ **The authority is `ADR-0036`, not this ADR.** This act performs one lawful thing `ADR-0036` could not do for
itself: it **propagates that ACCEPTED answer into the Rank 1 and Rank 4 registers that still say "Open"**, because
`ADR-0036` §7 explicitly declined to amend any ranked document.

### 2.2 ⚠ The `24h` vs `3-day` conflict — resolved by rank, and the record preserved

| Source | Value | Force |
|---|---|---|
| BC Map **L540** `Q-01` recommendation | *"default **24h** grace"* | ⛔ **none** — a recommendation inside an open question |
| `MASTER_PRD` **L673** | *"recommendation: configurable, default 24h"* | ⛔ **none** — same |
| **`ADR-0036`** (`ACCEPTED`, Rank 2) | ⭐ **3 calendar days, fixed, mandatory V1** | ⭐ **binding** |

⭐ Frozen `PRD-005` **L816** already ruled on this exact class of conflict: *"A recommendation inside an open
question is **not a decision**."* ⛔ So the 24-hour figure **never had binding force**, and 3 days does not override
a decision — **there was no decision to override**.

⛔ **The 24h recommendation text is NOT deleted.** Both amended cells retain it verbatim as *prior recorded text*,
because erasing a superseded recommendation destroys the ability to audit what was believed when.

### 2.3 ⚠ What `Q-01`'s resolution does NOT do

⛔ **It does not create the release mechanism.** `ADR-0036` §7 recorded a residual — *"**release actor**: whether
release at window end is automatic or human, given `SEAT-FR-217` forbids a queue acting on its own contents"* —
and that residual is ⛔ **OPEN and untouched** (`BC-04` owner). ⭐ It is **not** part of `Q-01`: `Q-01` asks
*when*, and *when* is now answered.

⛔ **No seat state, aggregate, event, edge, configuration identifier or requirement identifier is created**, and
⛔ **`MM-FR-111`, `MM-XC-012`, `MM-FR-112`, `SEAT-BR-024` and `SEAT-FR-217` are byte-unchanged.** Frozen
`SEAT-BR-024` was written *"to be correct under any resolution"* of `Q-01`, so ⭐ **this resolution requires no
change to it** — which is precisely why it can be made without touching a frozen PRD.

---

## 3. `Q-03` — RESOLVED: the policy *shape* is already frozen; the *value* is a separate, named gap

### 3.1 What the frozen requirement already says

**`ENT-FR-018`** (`PRD-014` Entitlement, **FROZEN** v0.1, Rank 3):

> *"The disposition of a `check` that times out — fail-open or fail-closed — **SHALL** be resolved **per feature**
> from an external configured value. The module **SHALL NOT** define a default disposition, and **SHALL NOT**
> derive one by generalising any other context's statement of its own conduct."*

**Rank 4 `E-17`** (BC Map **L326**) says the same thing from the architecture side:

> *"Fail-closed on timeout for paid gates, fail-open for soft limits — **decided per feature, recorded in Config**"*

### 3.2 The resolution

⭐ **`Q-03` is RESOLVED: the disposition is `per feature`, resolved from an external configured value owned by
`BC-25`. There is NO platform-wide default, and no module may derive one.**

⭐ **This resolves `Q-03` exactly as its own recommendation proposed** — *"per-gate policy; hard paid features
fail-closed, soft limits fail-open"* — and it does so ⛔ **without inventing anything**, because both the
per-feature rule and the Config ownership are already governed at Rank 3 and Rank 4.

### 3.3 ⚠ What `Q-03`'s resolution does NOT do — the distinction that matters

⛔⛔ **The configured VALUES do not exist, and this ADR does not create them.**

| Gap | Subject | Status after this ADR |
|---|---|---|
| **`ENT-GAP-001`** | *"`Q-03` — whether a timed-out `check` fails open or closed — is Open"* | ⭐ **DISCHARGED as to the policy shape** — `Q-03` is resolved. ⚠ Its *value* limb persists as `ENT-GAP-002` |
| **`ENT-GAP-002`** | *"`E-17` requires the per-feature disposition to be recorded in Config. **No entitlement configurable exists at any rank**"* — `ENT-CFG-*` empty by finding | ⛔⛔ **REMAINS OPEN.** Authority: **Governance Owner + `BC-25`/`PRD-023`** |

⚠ **So `ENT-FR-018` remains *satisfiable only after `ENT-GAP-002` closes*, exactly as the frozen PRD states.**
⭐ What changes is that the **question** is no longer open — the **shape** of the answer is settled, and only the
per-feature values remain to be configured. ⛔ **That is progress, not closure, and it is stated as such.**

⛔ **No `ENT-CFG-*` identifier is created** (`PRD-014` declares that register *"empty by finding"*), ⛔ no default
disposition is named, ⛔ `PRD-023` is not amended, and ⛔ `MM-BR-013` / `SEAT-FR-296` — which assert fail-closed
**for their own gates, on their own authority** — are ⛔ **neither generalised nor touched**, per `ENT-XC-007`.

---

## 4. `Q-06` — RESOLVED: the boundary is already implemented in a frozen PRD

### 4.1 What the frozen requirements already do

| Requirement | Text | Q-06 half |
|---|---|---|
| **`MM-FR-099`** (FROZEN) | *"The **price difference** applicable to an upgrade **MUST** be computed as `targetPlan.price − sourceMembership.priceSnapshot` and published on `MM-EVT-004`, together with the source's remaining day count."* | ⭐ **the `BC-02` half — the entitlement delta** |
| **`MM-FR-100`** (FROZEN) | *"This module **MUST NOT** compute a prorated monetary credit for the source membership's unused days, and **MUST NOT** compute a refund."* | ⭐ **the exclusion — no money in `BC-02`** |
| **`MM-XC-012`** (FROZEN) | *"Proration arithmetic executed as money (**V2**; and `Q-06` is open — see `MM-GAP-002`)"* | ⭐ **money execution is V2** |

⭐ **`PRD-005`'s own note states the position precisely:** *"`MM-FR-099` publishes the **entitlement delta** (price
difference and remaining days) which is the recommendation's `BC-02` half; it deliberately stops short of money."*

### 4.2 The resolution

⭐ **`Q-06` is RESOLVED: `BC-02` Membership owns the *entitlement delta* — the price difference and the remaining
day count, published on `MM-EVT-004`. Money execution belongs to the Business Platform (`BC-20`/`BC-05` as
applicable) and is ⛔ V2.**

⭐ **This adopts `Q-06`'s own recommendation** — *"`BC-02` computes the entitlement delta, Business Platform
executes the money"* — and the `BC-02` half is **already frozen and already implemented in requirements**. The
question was open only because no act had ever signed the recommendation.

### 4.3 ⚠ What `Q-06`'s resolution does NOT do

⛔⛔ **It does not bring money proration into V1.** `MM-XC-012` keeps *"proration arithmetic executed as money"* at
**V2**, `NG-6` in `PRD-008` lists *"Proration engine, dunning, credit/debit notes"* as **V2**, and ⛔ **this ADR
changes neither.** ⭐ `Q-06` settles **ownership**, not **scope**.

⛔ **The V2 execution contract is NOT designed.** `Q-06`'s recommendation adds *"Contract in `liboora_contracts`"*
— ⛔ **no contract, class, method or interface is created here**, and `packages/liboora_contracts` is
**byte-unchanged**.

⚠ **Residual gaps remain OPEN and are NOT closed:** **`MM-GAP-002`** (`PRD-005`'s own `Q-06` record) and
**`ENT-GAP-003`** (`PRD-014`'s). ⭐ Both are **discharged as to the ownership question** but ⛔ **neither is closed
as to the V2 money mechanism**, and ⛔ `ENT-XC-005`'s *"undetermined owner"* cell is ⛔ **not rewritten** — that is
`PRD-014`'s act, not this one.

---

## 5. ⛔⛔ `Q-04` — STOPPED. It remains OPEN, and it is not guessed

### 5.1 The instruction that governs this section

The brief is explicit: *"If any question requires Product, Architecture, or counsel decision that is not currently
authorized, **STOP and record it as OPEN rather than guessing**."*

⭐ **`Q-04` is exactly that case**, and the evidence is unanimous.

### 5.2 The measured authority requirement

| Source | Owner named for retention |
|---|---|
| **BC Map `Q-04`** (**L543**, Rank 4) | *"**Define with counsel**; default 7 years financial, 2 years attendance"* |
| **`MASTER_PRD` L676** (Rank 1) | *"Open — **needs counsel**"* |
| **`MP-NFR-10`** (Rank 1) | assigns retention enforcement to **SECURITY + DATA Governance** |
| **`IMPLEMENTATION_BLOCKER_REGISTER` 7a** | *"**Legal counsel + Architecture Owner**"* |
| **`ATT-GAP-005`** (`PRD-006`, FROZEN) | *"Legal counsel + architecture owner"* |
| **`AUD-GAP-001`** (`PRD-016`, FROZEN) | *"`MP-NFR-10` and `Q-04` place it **with counsel**"* |
| **`ADR-0051`** (`ACCEPTED`) | records the retention gap as **open**, with counsel |

⭐ **Six independent governed sources, plus an Accepted ADR, all name Legal counsel.** ⛔ **Legal counsel is not
conferred by this act, and cannot be substituted by Product or Architecture authority.**

### 5.3 ⚠ The trap, named explicitly

`IMPLEMENTATION_BLOCKER_REGISTER` item **7a** states the danger in its own words:

> *"**OPEN** — no authoritative retention number. **Do not adopt "7 years financial / 2 years attendance".**"*
> … *"`ATT-GAP-005` **rejects the unratified note**"*

⚠⚠ **The BC Map's own recommendation is therefore a NAMED TRAP.** The figures *"7 years financial, 2 years
attendance"* sit in the recommendation column of an open question, look authoritative, and have been ⭐ **expressly
rejected** as unratified by a frozen PRD's gap record and by the blocker register. ⛔ **This ADR does not adopt
them, does not soften them into a "provisional default", and does not cite them as a starting point.**

### 5.4 The disposition

⛔⛔ **`Q-04` REMAINS OPEN.** ⛔ No retention period is decided, defaulted, provisionally set, recommended or
implied. ⛔ No TTL, purge schedule, archival rule or deletion path is created.

| Field | Value |
|---|---|
| **Required authority** | **Legal counsel** + **Architecture Owner** (per `MP-NFR-10`: **SECURITY + DATA Governance**) |
| **Conferred here** | Product Owner + Architecture Owner — ⛔ **counsel is MISSING** |
| **Dependent gaps, all still OPEN** | `ATT-GAP-005` (attendance retention) · `ATT-GAP-014` (biometric retention/erasure — recorded as *a conflict, not a void*) · `ATT-GAP-016` (register-image retention) · `AUD-GAP-001` (audit retention) · blocker **7a** |
| **Consequence** | ⭐ **`MP-DEP-07` is NOT fully discharged, and schema freeze remains blocked by `Q-04` alone** (§6) |

⭐ **Stopping here is the correct outcome, not a failure of the act.** A retention period invented by an
unauthorised office would be a legal exposure wearing the costume of a governance decision.

---

## 6. `MP-DEP-07` and schema-freeze status

### 6.1 Before and after

| | Before | After |
|---|---|---|
| `Q-01` | ⛔ Open | ⭐ **RESOLVED** (`ADR-0036`, propagated here) |
| `Q-02` | ✅ Settled | ✅ Settled — unchanged |
| `Q-03` | ⛔ Open | ⭐ **RESOLVED** — per feature, Config-owned |
| `Q-04` | ⛔ Open | ⛔⛔ **STILL OPEN — counsel required** |
| `Q-05` | ✅ Closed (`ADR-0011`) | ✅ Closed — unchanged |
| `Q-06` | ⛔ Open | ⭐ **RESOLVED** — `BC-02` delta / Business money (V2) |
| `Q-07` | ✅ Settled | ✅ Settled — unchanged |
| **`MP-DEP-07`** | *"partially resolved (`Q-02`, `Q-07` settled)"* | ⭐ **"6 of 7 resolved; `Q-04` alone OPEN"** |

### 6.2 ⛔⛔ Schema freeze: STILL BLOCKED

⚠ **The honest answer, stated without softening: schema freeze is NOT unblocked by this act.**

`MP-DEP-07` makes *"Resolution of open questions `Q-01`…`Q-07`"* the dependency of **schema freeze**, and that
dependency is satisfied only when **all seven** are resolved. ⛔ **`Q-04` is open, so `MP-DEP-07` is not
discharged, and schema freeze remains blocked.**

⭐ **What did change:** the blocker narrowed from **four open questions to one**, and the one that remains has a
**single, named, external prerequisite** — Legal counsel. ⭐ That is a materially better position than four
questions with mixed owners, but ⛔ **it is not a freeze authorisation and must not be read as one**.

⛔ **This ADR designs no schema, no table, no column, no index, no migration and no SQL**, and ⛔ **`Q-02`'s
`branchId` settlement is neither re-opened nor implemented.**

---

## 7. What this ADR does NOT do

⛔ **No Technical Specification drafted** · ⛔ **`TS-001` NOT allocated** · ⛔ **`docs/50-technical/` NOT created** ·
⛔ **no API, endpoint, OpenAPI or contract** · ⛔ **no database, schema, table, migration or SQL** · ⛔ **no Supabase
artefact** · ⛔ **no code, no test, no CI change**.

⛔ **No permission created** — `AUTH-7.22` remains **closed and empty**; `ADR-0132`'s disposition stands; ⛔ no
`PERM-*`. ⛔ **Authentication v2.0/v3.0 byte-unchanged**, ⛔ **no v4.0**.

⛔ **`ADR-0130`, `ADR-0131`, `ADR-0132`, `ADR-0036`, `ADR-0011`, `ADR-0051` and `ADR-0052` byte-unchanged.**
⛔ **`PRD-008`, `PRD-019`, `PRD-022` NOT modified.** ⛔ **`PRD-005`, `PRD-006`, `PRD-007`, `PRD-014`, `PRD-016`,
`PRD-023` NOT modified** — every frozen PRD is untouched, and `SEAT-BR-024`'s *"correct under any resolution"*
drafting is why that was possible.

⛔ **No requirement, configuration, event, aggregate, edge, port, state or bounded context created** — count remains
**31**, highest edge remains **`E-33`**, ⛔ **`E-34` NOT allocated**, ⛔ **`ENT-CFG-*` still empty**.

⛔ **Blockers `B-4`, `B-5` and `B-6` are NOT resolved:**

| Blocker | State | Authority |
|---|---|---|
| **B-4** | ⛔ **OPEN** — `PRD-008` FROZEN §6.1 **L209**/**L210**/**L211**/**L213**/**L214** still say V1; superseded **in effect by rank**, recorded not repaired | Product + Architecture + Governance |
| **B-5** | ⛔ **OPEN** — no API style, error taxonomy, versioning or idempotency transport | Architecture Owner |
| **B-6** | ⛔ **OPEN** — `DEVELOPER_HANDOFF.md` + 6 implementation documents stale on authentication | Governance + Technical Owner |

⛔ **No `GCP-*` closed** · ⛔ **`ADR-0129`'s register row still MISSING** (disclosed three times, ⛔ still not
authored) · ⛔ **`SAAS-GAP-003`/`004` remain OPEN and V2-deferred** · ⛔ **`A-9` not executed** · ⛔ **NOT pushed**.

---

## 8. Governance records amended

| File | Rank | Change | Why required |
|---|---|---|---|
| `MASTER_PRD.md` | **1** | **v1.9 → v1.10**; **L673**, **L675**, **L678** and **L574** amended **strictly in place**; changelog row appended | The Rank 1 register says *"Open"* for questions now resolved. A baseline that contradicts an Accepted ADR is the defect `MP-DEP-07` exists to prevent |
| `LIBOORA_BOUNDED_CONTEXT_MAP.md` | **4** | **v1.14 → v1.15**; **L540**, **L542**, **L543**, **L545** and the version cell amended **strictly in place**; ⚠ the changelog entry is **APPENDED AT END OF FILE as a new §21 — NOT inserted into the `## Changelog` table**, see **§8.4** | Same, at Rank 4. `E-17`'s **L326** wording is ⛔ **unchanged** — it was already correct |
| `ADR-INDEX.md` | — | `ADR-0133` registered; `Count` cell corrected in place | `ADR-INDEX` Process rule 1 |
| `DOCUMENTATION_BASELINE.md` | — | `ADR-0133` added to §1 Authority; §3.2/§3.3 version cells; §8 changelog row | §7 rule 3 — *"This declaration is updated in the same commit"* |

### 8.1 ⚠ `Q-04`'s cells are amended too — but only to say it is STILL OPEN

⭐ **`MASTER_PRD` L676 and BC Map L543 are amended in place** to record that `Q-04` was **examined under this act
and deliberately left OPEN**, that **Legal counsel is the missing authority**, and that the *"7 years / 2 years"*
recommendation is ⛔ **expressly NOT adopted** (`ATT-GAP-005` rejects it as unratified; blocker 7a says *"Do not
adopt"*).

⚠ **This is the opposite of closing it.** A reader who finds `Q-04` still marked *"Open — needs counsel"* with no
record of examination cannot tell whether it was considered or overlooked. ⭐ **Recording the stop is part of the
governance value of this act.**

### 8.2 ⚠ The baseline identifier MUST advance

⭐ `MASTER_PRD` **v1.9 → v1.10** is a **Rank 1 version change**, which is §7 **rule 4**'s exact trigger
(*"The baseline identifier changes only when a Rank 1–3 document changes version"*). ⚠ The date does not advance,
so the suffix moves **`-B` → `-C`**, the **third** advance on 2026-09-10. ⭐ **§7 rule 3's *same commit* limb is
SATISFIED** — every amendment and this ADR move in **ONE** governed commit.

⚠ **The BC Map is Rank 4**, so its v1.14 → v1.15 change does ⛔ **not** independently trigger rule 4; the advance
is owed to `MASTER_PRD` alone, on the precedent `BASELINE-2026-08-20-C` recorded for `ADR-0055`.

### 8.3 Citation discipline

⚠⚠ **Every amended cell is CITED, so every amendment is STRICTLY IN PLACE.**

| Cell | Measured inbound citations | Treatment |
|---|---|---|
| `MASTER_PRD` **L673** (`Q-01`) | **3 documents** | ⭐ in place |
| `MASTER_PRD` **L675** (`Q-03`) | **9 documents** | ⭐ in place |
| `MASTER_PRD` **L676** (`Q-04`) | 0 | ⭐ in place anyway |
| `MASTER_PRD` **L678** (`Q-06`) | **4 documents** — ⚠ and **L678 is the HIGHEST cited line in the file** | ⭐ in place |
| `MASTER_PRD` **L574** (`MP-DEP-07`) | 0 | ⭐ in place |
| BC Map **L540**, **L542**, **L543**, **L545** | cited by `ADR-0036`, `ADR-0052`, `PRD-006`, `PRD-007`, `PRD-008`, `PRD-014` and others | ⭐ in place |

⭐ **`MASTER_PRD` carries 416 citations across 125 documents, highest L678**, and its changelog row lands **below**
that line, per the `ADR-0079` §8.5 append-not-insert doctrine.

### 8.4 ⚠⚠ A MEASUREMENT IN AN EARLIER DRAFT OF THIS ADR WAS FALSE, AND IS CORRECTED HERE RATHER THAN QUIETLY DROPPED

⚠⚠ **An earlier draft of §8.3 asserted *"the BC Map's highest [cited line] is L654."* That is FALSE**, and it was
caught by re-measuring immediately before the write rather than trusting the draft.

⭐ **The error had a specific cause worth recording:** **L654** is the highest citation *reported in the BC Map's own
v1.13/v1.14 changelog rows*, and those rows were read as if they were a current measurement. They were not — they
were measurements taken at **v1.13/v1.14**, before §19 and §20 were appended, and they counted only a **tight window**
around the phrase *"28 edges."*

⭐⭐ **The re-measurement, taken against the live file, found genuine citations far below L654 — the highest being
L1108, inside `Accepted` `ADR-0129`:**

| BC Map line cited | Citing document | Resolves today? |
|---|---|---|
| **L613** | `PRD-021B_B0_B9_STAGE3_ARCHITECTURE_ALIGNMENT.md` **L210** | ✅ |
| **L614** | `PRD_REGISTRY.md` **L1273** | ✅ |
| **L654** | `PRD-021A_STAGE4_AC_REQUIREMENT_MAPPING_2026-09-01.md` **L524** | ✅ |
| **L655** | `PRD-021B_STAGE4_REQUIREMENTS_REVIEW.md` **L135** | ✅ |
| **L712** | `PRD-021C_C8_TECHNICAL_AND_PRODUCTION_ARCHITECTURE_DRAFT_v0.1.md` **L101** | ✅ |
| **L753** | `PRD-015_SEARCH_INDEXING.md` **L261** | ✅ |
| **L844** | `PRD-015_ARCHITECTURE_OWNER_DECISION_PACKET.md` **L373** | ✅ |
| **L874** | `PRD-015_SEARCH_INDEXING.md` **L1324** | ✅ |
| **L936** | `PRD-015_FINAL_BLOCKER_RESOLUTION.md` **L266** | ✅ |
| ⭐⭐ **L1108** | ⛔ **`ADR-0129` L79** — an **`Accepted`** ADR | ✅ **verified byte-exact** |

⚠⚠ **Why this changes the method.** The BC Map's `## Changelog` is **NOT the last section** — the table occupies
**L611–L627** and **§15 … §20 all sit BELOW it** (L633–L1219). ⭐ A row inserted **newest-first**, which is this
file's established ordering, would therefore land at **L613** and shift **every one of the ten citations above by +1**.

⛔⛔ **One of those ten is inside an `Accepted` ADR, which this act may not edit** — `ADR-INDEX` **L206**: *"Never edit
an Accepted ADR's decision text."* So the insertion would either break `ADR-0129`'s citation or force an edit this act
is forbidden to make. ⭐ **Both outcomes are unacceptable, and neither was visible under the false measurement.**

⭐⭐ **THEREFORE THE CHANGELOG ENTRY IS APPENDED AT END OF FILE AS §21, SHIFTING ZERO CITATIONS.** This is the
`ADR-0079` §8.5 **Option A** doctrine applied to its own terms, and it follows `ADR-INDEX`'s end-of-file addendum
precedent — used for `ADR-0125`, `ADR-0126`, `ADR-0127`, `ADR-0128`, `ADR-0131` and `ADR-0132` for exactly this reason.

⚠ **A cost is disclosed rather than hidden:** the `## Changelog` table will **not** contain a `v1.15` row, so a reader
consulting only that table sees v1.14 as the newest. ⭐ **§21 states this explicitly and points back to the table**, and
the header **Version** cell — amended in place at **zero** citation cost — reads **v1.15**, so no reader is misled about
the current version. ⛔ Inserting the row to tidy the table would break an `Accepted` ADR's citation; **the tidier
outcome is the unlawful one.**

⛔ **Three cells were tested for amendment and deliberately NOT touched:** **L326** (`E-17` — already correct, and
cited by `ADR-0052`), **L544** (`Q-05` — closed, and cited by `PRD-021B_STAGE3` **L135**), and **L10** (the header
count cell — ⛔ **no context, edge or aggregate changes in this act**, so it has nothing to record).

---

## 9. Consequences

### 9.1 Positive

⭐ Three of four `MP-DEP-07` questions are resolved **without inventing a single requirement**: `Q-01` from an
ACCEPTED ADR, `Q-03` from a frozen Rank 3 requirement plus Rank 4 `E-17`, `Q-06` from two frozen Rank 3
requirements. ⭐ **Every answer was already in the repository; what was missing was an act willing to sign it.**

⭐ The Rank 1 and Rank 4 registers now **agree with the ACCEPTED ADR corpus** on `Q-01`, closing a contradiction in
which the highest-ranked documents said *"Open"* about a question `ADR-0036` had answered nine days earlier.

⭐ The schema-freeze blocker narrows from **four questions to one**, with a single named external prerequisite.

### 9.2 Negative and honest

⛔⛔ **Schema freeze is still blocked.** `Q-04` alone holds `MP-DEP-07`, and no amount of Product or Architecture
authority can discharge it.

⚠ **`Q-03`'s resolution is partial in effect**: the shape is settled, but `ENT-FR-018` stays unsatisfiable until
`ENT-GAP-002` supplies configured values — so no entitlement gate can be implemented from this resolution alone.

⚠ **`Q-06` settles ownership while leaving the V2 money contract undesigned**, and `MM-GAP-002` / `ENT-GAP-003`
persist in their V2 limbs.

⚠ **`Q-01`'s release actor remains OPEN** (`ADR-0036` §7 residual, `BC-04` owner), so *when* the seat releases is
known while *who or what performs the release* is not.

---

## 10. Changelog

| Version | Date | Change |
|---|---|---|
| **1.0** | 2026-09-10 | ⭐⭐ **Created and `Accepted`. `MP-DEP-07`'s schema-freeze questions resolved where lawful: `Q-01`, `Q-03` and `Q-06` RESOLVED; `Q-04` STOPPED and left OPEN** — by a one-act joint conferral of **Product Owner** and **Architecture Owner** (as **ARB** and **`BC-04` owner**) authority; ⛔ both offices **revert on completion** (`ADR-0033` §7.1). ⭐⭐ **`Q-01` RESOLVED BY RECOGNITION — it was already answered and nobody had propagated it.** `ADR-0036` is **`ACCEPTED`** and its §7 records *"✅ **ANSWERED at v2.0 — a 3-calendar-day protection window, mandatory V1**"*, with §8 answering all three of its own questions: duration **3 calendar days**, boundary **`W₀ = D+1`** (2026-08-31), scope **FIXED, not tenant-configurable**. ⛔ The Rank 1 and Rank 4 registers nonetheless still read *\"Open — recommendation: configurable, default 24h\"*, a contradiction this act repairs by **propagating the ACCEPTED answer**, which `ADR-0036` §7 had expressly declined to do. ⭐ **The `24h` vs `3-day` conflict is resolved by rank and the record PRESERVED**: frozen `PRD-005` **L816** already ruled *\"A recommendation inside an open question is **not a decision**\"*, so the 24h figure ⛔ **never had binding force** — and it is ⛔ **NOT deleted**, being retained verbatim as prior recorded text in both amended cells. ⭐ **`Q-03` RESOLVED — per feature, from an external configured value owned by `BC-25`; ⛔ NO platform-wide default and no module may derive one** — taken verbatim from **FROZEN `ENT-FR-018`** and Rank 4 **`E-17`** (BC Map **L326**), so ⛔ **nothing is invented**; ⚠ and the distinction is stated rather than blurred: the **policy shape** is settled while ⛔⛔ **the configured VALUES do not exist** — **`ENT-GAP-002`** (*\"no entitlement configurable exists at any rank\"*, `ENT-CFG-*` empty by finding) ⛔ **REMAINS OPEN** with **Governance Owner + `BC-25`/`PRD-023`**, so `ENT-FR-018` stays *satisfiable only after `ENT-GAP-002` closes*; ⛔ no `ENT-CFG-*` minted, ⛔ no default named, ⛔ `PRD-023` untouched, ⛔ `MM-BR-013`/`SEAT-FR-296` **neither generalised nor touched** (`ENT-XC-007`). ⭐ **`Q-06` RESOLVED — `BC-02` owns the entitlement delta (price difference + remaining days, on `MM-EVT-004`); money execution belongs to the Business Platform and is V2** — adopting `Q-06`'s own recommendation, whose `BC-02` half is **already frozen and already implemented** by **`MM-FR-099`** and **`MM-FR-100`** (*\"MUST NOT compute a prorated monetary credit … MUST NOT compute a refund\"*), with `PRD-005`'s own note confirming it *\"publishes the entitlement delta … it deliberately stops short of money\"*; ⛔⛔ **money proration is NOT brought into V1** — `MM-XC-012` keeps it **V2** and `PRD-008` `NG-6` lists the proration engine **V2**, both unchanged; ⛔ **no `liboora_contracts` contract, class, method or interface created**; ⚠ **`MM-GAP-002` and `ENT-GAP-003` are discharged as to OWNERSHIP but ⛔ NOT closed as to the V2 mechanism**, and ⛔ `ENT-XC-005`'s *\"undetermined owner\"* cell is **not rewritten**. ⛔⛔ **`Q-04` STOPPED — REMAINS OPEN, and deliberately NOT guessed**, per the brief's own instruction. **Six independent governed sources plus an Accepted ADR all name Legal counsel**: BC Map **L543** (*\"Define with counsel\"*), `MASTER_PRD` **L676** (*\"needs counsel\"*), **`MP-NFR-10`** (SECURITY + DATA Governance), blocker **7a** (*\"Legal counsel + Architecture Owner\"*), **`ATT-GAP-005`**, **`AUD-GAP-001`** and **`ADR-0051`** — and ⛔ **Legal counsel is NOT conferred by this act and cannot be substituted by Product or Architecture authority**. ⚠⚠ **THE TRAP IS NAMED:** blocker **7a** states *\"**Do not adopt** '7 years financial / 2 years attendance'\"* and **`ATT-GAP-005` rejects the unratified note** — those figures sit in the *recommendation* column of an open question, look authoritative, and are ⛔ **expressly NOT adopted, NOT softened into a provisional default, and NOT cited as a starting point**. ⛔ **No retention period, TTL, purge schedule, archival rule or deletion path is created**, and `ATT-GAP-005`, `ATT-GAP-014`, `ATT-GAP-016`, `AUD-GAP-001` and blocker **7a** ⛔ **all remain OPEN**. ⭐ **`MP-DEP-07` advances from *\"partially resolved (`Q-02`, `Q-07` settled)\"* to *\"6 of 7 resolved; `Q-04` alone OPEN\"*** — ⛔⛔ **but SCHEMA FREEZE REMAINS BLOCKED**, stated without softening: `MP-DEP-07` requires **all seven**, `Q-04` is open, therefore the dependency is **not discharged**. ⭐ The blocker narrowed from **four questions to one with a single named external prerequisite**, which is progress and ⛔ **not a freeze authorisation**. ⭐ **Four governance files amended, each minimally** (§8): `MASTER_PRD.md` **v1.9 → v1.10** (**L673**, **L675**, **L676**, **L678**, **L574** + version + changelog), `LIBOORA_BOUNDED_CONTEXT_MAP.md` **v1.14 → v1.15** (**L540**, **L542**, **L543**, **L545** + version + changelog), `ADR-INDEX.md`, `DOCUMENTATION_BASELINE.md`. ⚠⚠ **EVERY AMENDED CELL IS CITED, SO EVERY AMENDMENT IS STRICTLY IN PLACE** — `MASTER_PRD` **L673** (3 documents), **L675** (9), **L678** (4, and ⚠ **the HIGHEST cited line in the file**); BC Map **L540**/**L542**/**L543**/**L545** cited by `ADR-0036`, `ADR-0052`, `PRD-006`, `PRD-007`, `PRD-008` and `PRD-014`. ⭐ **`MASTER_PRD`: 416 citations / 125 documents, highest L678; BC Map highest L654** — both changelog rows land **below** every cited line (`ADR-0079` §8.5). ⭐ **Baseline identifier MUST advance `-B` → `-C`** (§7 rule 4, Rank 1 version change; third advance on 2026-09-10; ⚠ the Rank 4 BC Map change does **not** independently trigger it, on the `ADR-0055` precedent), and ⭐ **§7 rule 3's *same commit* limb is SATISFIED**. ⛔ **`E-17`'s BC Map **L326** wording is UNCHANGED** — it was already correct. ⛔⛔ **NOTHING ELSE EXECUTED:** ⛔ **every frozen PRD untouched** — `PRD-005`, `PRD-006`, `PRD-007`, `PRD-008`, `PRD-014`, `PRD-016`, `PRD-023`; ⭐ possible only because frozen `SEAT-BR-024` was written *\"to be correct under any resolution\"* of `Q-01` · ⛔ `PRD-019`/`PRD-022` **not modified** · ⛔ `ADR-0130`/`0131`/`0132`/`0036`/`0011`/`0051`/`0052` **byte-unchanged** · ⛔ Auth **v2.0/v3.0** byte-unchanged, **no v4.0** · ⛔ **no permission, no `PERM-*`** — `AUTH-7.22` remains closed and empty per `ADR-0132` · ⛔ **no requirement, configuration, event, aggregate, edge, port, state or bounded context created** (count **31**, highest edge **`E-33`**, **`E-34` NOT allocated**, `ENT-CFG-*` still empty) · ⛔ **no Technical Specification, `TS-001` NOT allocated, `docs/50-technical/` NOT created** · ⛔ **no API, endpoint, OpenAPI, SQL, schema, table, column, index, migration or Supabase artefact** · ⛔ **`Q-02`'s `branchId` settlement neither re-opened nor implemented** · ⛔ **no code, no test, no CI change** · ⛔ **`B-4`, `B-5`, `B-6` ALL REMAIN OPEN** · ⛔ **`ADR-0036`'s release-actor residual remains OPEN** (`BC-04` owner) · ⛔ **`SAAS-GAP-003`/`004` remain OPEN and V2-deferred** · ⛔ **no `GCP-*` closed** · ⛔ **`ADR-0129`'s register row still MISSING** · ⛔ **`A-9` not executed** · ⛔ **NOT pushed** — `github/main` remains `267f46e5c9b191da874553ffdfaf70dbfd3720cb`. |

---

*End of `ADR-0133`. ⭐ **Accepted** — resolves `Q-01`, `Q-03`, `Q-06`. ⛔ **`Q-04` remains OPEN; schema freeze remains blocked.***
