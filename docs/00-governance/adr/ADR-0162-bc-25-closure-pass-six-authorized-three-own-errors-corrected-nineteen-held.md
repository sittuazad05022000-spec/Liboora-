# ADR-0162 — `BC-25` closure pass: **6 parameters AUTHORIZED**, **3 of my own prior claims CORRECTED**, **19 HELD**, `DD-0007` still **NOT design-ready**

| Field | Value |
|---|---|
| **Status** | ⭐⭐ **Accepted** — 2026-09-19 |
| **Rank** | 2 — Architecture Decision Record |
| **Bounded context** | `BC-25` Configuration *(owning)*; `BC-03` Attendance, `BC-04` Seating, `BC-01` Student Management *(sources)* |
| **Supersedes** | ⛔ **NOTHING.** ⛔ No `Accepted` ADR is overturned, in whole or in part. |
| **Superseded by** | — |
| **Authority instrument** | ⭐⭐ **A one-act conferral of the human principal of this engagement**, recorded **verbatim** at §2 — per-track directives for `B-1′`, `B-2`, `B-3`, `B-5`, `B-6`, `B-7`, `B-8`, `B-10`. ⛔ **Reverting on completion** (`ADR-0033` §7.1: *"a conferral for one act is not a standing licence"*). ⚠️ Offices exercised: **Authorization Owner** *(§16)*, **Product Owner**, **SECURITY PLATFORM / Security Owner** *(§17)*. ⚠️ **All by one principal — ⛔ no independent review is claimed.** |
| **Decides** | ⭐ **6 of 25** parameters authorized — `ATT-CFG-022`, `ATT-CFG-023`, `ATT-CFG-024`, `SEAT-CFG-005`, `SEAT-CFG-014`, `SMCFG-5` |
| **Coverage** | ⭐⭐ **79 / 104 → 85 / 104.** ⛔ **19 remain HELD.** ⛔⛔ **104/104 is NOT claimed and was NOT forced.** |
| **Expressly does NOT decide** | ⛔ `ICFG-1`…`10` · ⛔ `CFG-10` · ⛔ `CFG-12` · ⛔ `SCFG-2` · ⛔ `SCFG-4` · ⛔ `SEAT-CFG-017` · ⛔ `ATT-CFG-013`/`014`/`015`/`016` |
| **Amends** | ⛔⛔ **No frozen PRD. No `Accepted` ADR. ⛔ `DD-0007` is NOT edited** (§9.3). |

---

## 1. Context

`DP-0002` states **8** remaining blockers over the **25** held `BC-25` parameters;
`DP-0003` puts **5** of them into owner-facing form. ⭐ This ADR records the
principal's answers, applies **only** what existing governance permits, and
⭐⭐ **corrects three claims of my own that the evidence does not support.**

⚠️⚠️ **The headline is not the six.** ⭐ It is that a re-read of the primary
sources falsified three statements in `DP-0002` / `DP-0003` — documents I wrote.
⭐ They are **withdrawn as errors, not re-characterised as closures** (§7), on the
precedent `ADR-0161` set for `B-1` and `B-9`.

---

## 2. The decision instrument — **verbatim**

> **`B-1′`:** *"Treat capability-conferring configuration as configuration, NOT
> creation of permissions/roles. Keep actual authorization/role capability changes
> within the existing authorization boundary. Resolve READ only if explicitly
> supported."*
>
> **`B-2`:** *"Resolve `SCFG-2` review authority through the Authorization Owner
> only if existing governance permits it."*
>
> **`B-3`:** *"Resolve `ICFG` READ + commercial classification using actual
> evidence. Do NOT infer READ from WRITE or symmetry. Existing Platform Default
> scope and non-storable WRITE must remain intact."*
>
> **`B-5`:** *"Resolve Group-3/`LR-01` routing only if Governance + Architecture
> have legitimate authority. If legal determination is required, preserve HOLD."*
>
> **`B-6`:** *"Do NOT invent a Legal Owner. Do NOT fabricate a legal conclusion.
> Do NOT override `ADR-0137`."*
>
> **`B-7`:** *"Resolve `enrollmentNumber` meaning using existing product evidence.
> Prefer system-generated/non-human-semantic only if evidence supports it."*
>
> **`B-8`:** *"Apply the required Stage-3 confirmation for `E-05`. Do not invent
> threshold/scope values."*
>
> **`B-10`:** *"Resolve security/BC-owned portions if existing authority permits.
> Preserve any legal dependency."*
>
> **Standing:** *"Evidence > closure count. Never force AUTHORIZE. Never invent
> authority, owner, role, action, scope, permission, legal conclusion, runtime
> surface, or implementation authorization. No new `PERM-*`. No new roles/actions/
> scopes. Do not modify frozen PRDs to manufacture evidence. Do not overturn
> Accepted ADRs implicitly."*

---

## 3. `B-1′` — **DETERMINATION: the write is a CONFIGURATION act**

### 3.1 What was actually blocking

⭐ `ADR-0153` §5 held `ATT-CFG-022`/`023`/`024` and `ADR-0157` `SE-2` held
`SEAT-CFG-005`/`014` on **one** ground: they are **authorization-semantic** —
`PRD-007` **L1975**'s legend defines **`C`** as *"permitted **only where the named
configurable grants it**"*, so ⭐ **the parameter IS the grant.**

⭐⭐ **Both holds were expressly provisional, and both named the same release
condition.** `ADR-0157` `SE-2`, verbatim: *"**HOLD** … **pending explicit
Authorization Owner determination**, consistent with the `ATT-CFG-022`/`024`
precedent."* ⭐ **That determination has now been made.**

### 3.2 The ruling, and its limit

⭐ **Choice (a) — CONFIGURATION act.** ⭐⭐ **And the limiting half of the
instruction is load-bearing:** *"Keep actual authorization/role capability changes
within the existing authorization boundary."*

| What the ruling does | What it ⛔ does **not** do |
|---|---|
| ⭐ The **write** to the parameter is ordinary configuration, allocable by the normal register route | ⛔ It does **not** create a permission, role, action class or scope class |
| ⭐ The **effect** — e.g. Manager gaining lock-override — remains governed by the **existing** authorization model | ⛔ It does **not** widen `SEAT-PO-007`/`010` or `PRD-006` §19.2 |
| ⭐ The `C` cells stay exactly as frozen: the capability is conditional on the value | ⛔ It does **not** make the configurable a substitute for authorization evaluation |

⭐⭐ **This is coherent because the `C` cells ALREADY EXIST in the frozen closed
list.** `SEAT-FR-272`: *"The following list of protected operations is **closed**."*
⭐ The operation, its conditionality and its gating parameter were all written at
freeze. ⛔ **Nothing is added; a pre-existing conditional is given its allocation.**

### 3.3 ⭐ `ATT-CFG-022` and `ATT-CFG-023` — answered **together**

⚠️ `DP-0002` asked whether they may diverge, since `023` **time-bounds** the
capability `022` gates — ⛔ a window of `0` would nullify the grant while appearing
to confer it.

⭐⭐ **They are answered together and receive the identical allocation.** ⭐ The
nullification concern **does not arise**, because `PRD-006` §16.3 gives **both** the
same writer (`Owner`): ⛔ there is no split authority to play one against the other.
⭐ Corroborated — `ATT-FR-115` applies *"where a correction window is configured"*,
and `ATT-CFG-023`'s PO-authorised domain is **0–60 minutes** including `0`
*(`PRD-006_ATT-GAP-017_PO_VALUE_DECISION_RECORD` §8)*: ⭐ **`0` is an
already-authorised value, not a loophole this ADR opens.**

### 3.4 ⭐⭐ The allocations — every dimension **sourced**, ⛔ none chosen

⭐ **`ATT-CFG-022`, `ATT-CFG-023`, `ATT-CFG-024`** — Scope **`Tenant`** · `WRITE`
**`TR-1` ✅ only** · `READ` **`TR-1` + `TR-2` + `TR-3` ✅** · **`NOT COMMERCIAL`**

| Dimension | Source | ⭐ Decided or consumed? |
|---|---|---|
| `WRITE` | ⭐ `PRD-006` **§16.3** Owner column — all three read **`Owner`** *(FROZEN)* | ⭐⭐ **CONSUMED as-is**, exactly as `ADR-0153` §2.1 did for the 17. ⛔ Not widened, narrowed or restated |
| Scope | ⭐ `PRD-006` **L1717** — *"**MUST** be resolvable per tenant (`LIB-16.1`)"*, governing §16.3 as a whole; corroborated by `ATT-FR-009` | ⭐ **Sourced**, ⛔ not chosen |
| `READ` | ⭐ `ADR-0153` §2.2's Product Owner decision — *"`READ` = `TR-1` + `TR-2` + `TR-3`"* — for **this register**, whose only exclusion ground for these three is the one §3.1 discharges | ⭐ **Decided**, ⛔ **not derived from `WRITE`** — and visibly so: `TR-2`/`TR-3` hold `READ` where `WRITE` is ⛔ *(`CNF-BR-010`, `AUTH-7.24` satisfied)* |
| Commercial | ⭐ A correction flag, a correction window and a parent-visibility flag carry **no monetary content**; `ADR-0153` classified the register `NOT COMMERCIAL` | ⭐ **Decided** |

⭐ **`SEAT-CFG-005`, `SEAT-CFG-014`** — Scope **`Tenant`** · `WRITE` **`TR-1` ✅
only** · `READ` **`TR-1` ✅ only** · **`NOT COMMERCIAL`**

| Dimension | Source | ⭐ Decided or consumed? |
|---|---|---|
| `WRITE` | ⭐⭐ **`SEAT-PO-021`** *(**L2005**, FROZEN)* — *"Change a module configurable **owned by `BC-25`** (§27)"*: **Owner Y · Manager — · Reception — · Student —**; ⭐ the register shows **both** parameters owned by **`BC-25`** *(**L1906**, **L1915**)*, so ⭐ **they are members of the very class the row governs** · reinforced by **`SEAT-BR-039`** *(configuration is **Owner-only**)* | ⭐⭐ **CONSUMED** |
| `READ` | ⭐ `ADR-0157` **§2.1b** — `PRD-007` grants **no** tenant configuration read beyond the writer; **`CNF-FR-081` prescribes rendering, ⛔ it does not grant** | ⭐ **`TR-1` only** — ⛔ `TR-2`/`TR-3` read **NOT** allocated |
| Scope | ⭐ `ADR-0157` `SE-1`/§2.4a — normal `BC-25` configuration is `Tenant`; ⛔ `SEAT-XC-022`'s branch caveat has **one** referent, `SEAT-CFG-017`, ⛔ **which stays HELD** | ⭐ **Sourced** |
| Commercial | ⭐⭐ **`SEAT-FR-279`** — *"The module **MUST NOT** display or store **any monetary value**"*; `SEAT-FR-144`, `SEAT-XC-011`, `SEAT-AC-194` | ⭐⭐ **MANDATED**, ⛔ not merely satisfied |

⚠️⚠️ **This is application to members of a class the frozen row already names — ⛔
NOT extension by analogy.** ⭐ `SEAT-PO-021` speaks of *"a module configurable owned
by `BC-25`"*; `005` and `014` are such configurables. ⛔ **The `ADR-0153` 17-parameter
allocation is NOT carried across to `PRD-007`, and the `SMCFG` `TR-1`+`TR-2`
allocation is NOT carried across either** — ⭐ `TR-2` is excluded here on
`SEAT-PO-021`'s own **—** cell.

### 3.5 ⛔ `CFG-12` is **NOT** authorized — but its hold ground is **narrowed**

⭐ Under §3.2, `CFG-12` is **configuration**: it is a **duration ceiling** on a
capability `AUTH-7.19` already confers, ⛔ **not a grant of capability**. ⭐ Its
legal limb is **withdrawn as my own error** (§7.2).

⛔⛔ **It is still HELD**, on the one ground that survives: ⭐ `ADR-0154` §6's
**self-reference** finding — a `PR-2` read of the parameter bounding `PR-2`'s own
privilege. ⛔ `ADR-0154`'s Product Owner decision allocated `READ` to **ten**
`CFG-*` and **expressly excluded** `CFG-12`; ⛔ **no explicit `READ` support exists**,
and the instrument says *"Resolve `READ` only if explicitly supported."*
⭐ **Scope (`Platform default`) and `WRITE` (⚪ `N/A`) are already recorded by
`ADR-0154` and are ⛔ not re-decided.**

---

## 4. `B-2` — **DETERMINATION: ⛔ HOLD** *(the correct answer, expressly permitted)*

⭐ `ADR-0155` `S-3`, verbatim: *"Do **NOT** infer the reviewer from
`TR-1`/`TR-2`/`PR-1`/`PR-2` naming, ownership, hierarchy, or UI visibility. **If the
Authorization Owner cannot identify an authoritative role, keep `SCFG-2` HELD.**"*

⭐ **Measured, repository-wide:** the phrase *"removing an entry requires review"*
appears in `Student_Identity_PRD_v1` **L1336** and ⛔ **nowhere else in any primary
source**; every other occurrence is a governance document **quoting** it. ⭐ **No
actor is named anywhere.**

⛔⛔ **HELD.** ⭐ The instrument's condition — *"only if existing governance permits
it"* — is **not met**. ⛔ Naming a reviewer would be invention.

---

## 5. `B-3` — **DETERMINATION: ⛔ ALL TEN HELD; one limb narrowed**

| Limb | Determination | Basis |
|---|---|---|
| ⭐ **Commercial** | ⭐ **`NOT COMMERCIAL`** — evidenced | ⭐ `ADR-0158` §2.4a already measured this dimension **Sufficient**: *"`NOT COMMERCIAL` — TTLs, caps and rate limits"*. ⭐ Re-verified: all ten are durations, counts or rate limits *(`CONFIGURATION_GUIDE` §2B **L417**–**L426**)*; ⛔ **0** monetary values |
| ⛔ **`READ`** | ⛔⛔ **HELD** | ⛔ **0** read statements. ⭐ `ADR-0158` §2.4b refused `PR-1`+`PR-2` on three grounds; `ADR-0160` confirmed; ⭐⭐ **this ADR CONFIRMS it a third time.** The instrument forbids inferring from `WRITE` or symmetry, and ⚪ `N/A` *"by symmetry"* is barred because ⚪ `N/A` rests on **`CNF-FR-020`, a write-only rule** |
| ⚠️ **Scope** | ⚠️⚠️ **HELD — and my own prior claim is CORRECTED** | See §7.1 |

⛔⛔ **All ten remain `NOT YET AUTHORIZED`.** ⭐ Narrowing the commercial limb is
**progress, not closure**: ⛔ a parameter with an unresolved `READ` **and** an
ambiguous scope cannot be authorized.

---

## 6. `B-5`, `B-6`, `B-7`, `B-8`, `B-10`

### 6.1 `B-5` — ⛔ **HOLD preserved**, and the routing **is** corrected

⭐ The instrument permits action *"only if Governance + Architecture have legitimate
authority."* ⭐⭐ **Tested, and they do not:**

| Office | Why it cannot allocate | Source |
|---|---|---|
| **Architecture Owner** | ⭐ `LR-01` names it ***"Risk custodian — custodian of the record **only**"*** | `LEGAL_RISK_REGISTER` **L64** |
| **Governance Owner** | ⭐ Scoped to *"document **status** and **process**"* — ⛔ an authorization allocation is neither | `PRD_OWNERSHIP_MODEL` §10.1 |

⭐ **And the value limb is squarely `LR-01`'s.** `CFG-10`'s own rationale is a legal
argument — *"short enough to remain **defensible as erasure under DPDP**"* — and
**`T-10`** fires on *"any proposal to **set a retention period**"*. ⛔⛔ **HOLD
preserved for `CFG-10` and `SCFG-4`**, per the instrument's own fallback.

⭐⭐ **The routing conflict IS resolved, and that is the real output here.**
`DP-0001` §3 routes both to the **Privacy Owner**, whom `LR-01` names among those
who ⛔ **cannot** close the retention question. ⭐ **Corrected:** the **value** limb
is **external** *(`B-6`)*; the **allocation** limb, when the value limb clears,
belongs to the **Authorization Owner**, ⛔ **not** the Privacy Owner. ⛔ **`LR-01` is
not closed, narrowed, mitigated or re-statused.**

### 6.2 `B-6` — ⛔⛔ **EXTERNAL. No internal act can supply the input**

⛔ **No `Legal Owner` is constituted** — *"Legal Owner"* measures **0**
repository-wide and `Accepted` **`ADR-0137`** *"Does **not** constitute **Legal
Counsel** as an office."* ⛔ **No legal conclusion is drawn.** ⛔ **`ADR-0137` is
not overridden.**

⭐ **The precise external request is recorded at `DP-0002` Part B** — exact question,
affected parameters, `LR-01` conditions, evidence required, responsible external
principal. ⭐ **`T-7` is live**: engaging a qualified Indian advocate *for any
purpose* obliges tabling `LR-01`.

### 6.3 `B-7` — ⭐⭐ **DETERMINATION: `enrollmentNumber` is NOT human-meaningful**

⭐ The instrument permits the non-human-semantic answer *"only if evidence supports
it."* ⭐⭐ **It does — measured across `Student_Management_PRD_v1`:**

| # | Obligation | Character |
|---|---|---|
| 1 | `SM-INV-1` **L312** — *"Unique `(tenantId, enrollmentNumber)`"* | ⭐ machine constraint |
| 2 | `SM-3.4` **L347** step 5 — *"**allocate** `enrollmentNumber`"* | ⭐⭐ **the system allocates it**; ⛔ no human authors it |
| 3 | `SM-3.17` **L402** — *"allocation **MUST** be collision-free under concurrency"* | ⭐ machine constraint |
| 4 | `SM-3.5` — a failure *"**MUST NOT** consume an `enrollmentNumber`"* | ⭐ sequence semantics |
| 5 | `SM-EV-9` **L792** — *"**Searchable** identifier"* | ⭐⭐ **looked up, ⛔ not interpreted** |

⭐⭐ **Five machine-facing obligations; ⛔ ZERO requirement that any human derive
meaning from the value.** ⭐ **DETERMINATION: NOT human-meaningful** — an opaque,
system-allocated, tenant-unique identifier. ⭐ The *"tenant-prefixed sequence"*
default is **expressly confirmed as an opaque generation strategy**, ⛔ **not
ratified by silence** and ⛔ **not a human-readable format**. ⛔ `SM-INV-1` is
unchanged. ⛔ **No format is invented.**

⭐ **`SMCFG-5` is therefore ALLOCATED** — Scope **`Tenant`** · `WRITE` **`TR-1` ✅
+ `TR-2` ✅, `TR-3` ⛔** · `READ` **`TR-1` + `TR-2` + `TR-3` ✅** · **`NOT
COMMERCIAL`** — on `ADR-0156` §2.1a's evidence base, ⭐ **`PRD-023` §9 quoting FROZEN
`PRD-001` §2**, which is a **register-wide role rule**, ⛔ not a per-identifier
decision. ⭐ `TR-2`'s only bar is *"cannot alter **commercial** configuration"* — a
restriction **by subject** — and an enrollment-number format is ⛔ not commercial,
so the bar is **not triggered**.

⚠️⚠️ **This is the most contestable step in the pass, and it is flagged rather than
buried.** ⭐ `ADR-0156` `SM-1` enumerated five identifiers and excluded `SMCFG-5`
**for one stated reason** — *"`SMCFG-5`'s definition is itself undecided"*
*(`SM-GAP-2`)* — ⭐ **the ground this section discharges**. ⛔ If the Product Owner
intends `SM-1`'s enumeration to be exhaustive **independently** of `SM-GAP-2`, the
allocation limb must return to **HELD**; ⭐ the **definition** determination stands
either way.

### 6.4 `B-8` — ⛔ **HOLD**, and the authority is **corrected**

⭐ The instrument requires the Stage-3 confirmation ⛔ *"Do not invent threshold/scope
values."* ⭐⭐ **The two cannot both be satisfied inside this repository:**

1. ⛔⛔ **`E-05`'s payload does not contain the threshold.** BC Map **L302**:
   `E-05 | BC-06 Library Policy | BC-04 Seating | CF | Sync port |
   SeatRules{maxTransfersPerDay, reservationWindow}`. ⭐ **Confirming that `E-05`
   carries an occupancy threshold means AMENDING that payload.**
2. ⛔ `SEAT-GAP-005` records the constraint itself: *"`E-05`'s contract is fixed by
   the BC Map; BC Map §7 says an edge not in the table does not exist and **changing
   one requires an ADR**"* — ⭐ and a BC Map amendment is a **Rank 1** act, outside
   both this conferral and the permitted change set.
3. ⛔ **No value may be substituted** — `SEAT-FR-241`, `SEAT-AC-170` and §27.1 forbid
   the 90% figure as a fallback in terms.

⛔⛔ **`SEAT-CFG-017` stays HELD.** ⚠️ **And the authority `DP-0002` named is wrong
— see §7.3.**

### 6.5 `B-10` — ⛔ **HOLD**; ⭐ the legal dependency is preserved

⭐ The instrument permits resolving *"security/BC-owned portions … if existing
authority permits"* and to *"preserve any legal dependency."*

| Gap | Could existing authority resolve it? | Determination |
|---|---|---|
| **`ATT-GAP-012`** — which context **owns** biometric templates | ⛔ **No.** *"**No context in BC Map §3 claims biometrics**"* — ⭐ assigning one is a **BC Map** act *(Rank 1, Architecture Owner)*, ⛔ not a Security Owner act. ⭐ `PRD_OWNERSHIP_MODEL` §17.1 denies the Security Owner ⛔ **architecture authority** | ⛔ **HELD** |
| **`ATT-GAP-014`** — retention / deletion | ⛔⛔ **No — it is `LR-01`'s own subject.** `LR-01` §5 condition **4** names `ATT-GAP-014` as something the external determination must disposition | ⛔ **HELD — legal dependency preserved** |

⭐⭐ **And `ATT-FR-064` requires BOTH**: *"Until `ATT-GAP-012` and `ATT-GAP-014` are
**both** answered by their named owners, face verification **MUST NOT** be
implemented."* ⛔ **All four Face parameters stay HELD.** ⛔ `ATT-CFG-014` carries a
**second, independent** bar — outside V1 by `D-3a` *(Face = **V3**)*. ⛔⛔
**Configuration authority is NOT allocated ahead of build authorization** —
`ADR-0160` called that *authorization theatre*, and that refusal stands.

---

## 7. ⚠️⚠️ **THREE CLAIMS OF MY OWN ARE WITHDRAWN AS ERRORS**

⭐⭐ **These are errors, not closures.** ⛔ **They release ZERO parameters.**

### 7.1 ⛔ `ICFG` scope was **NOT** *"already determined"*

⚠️ **`DP-0002` `B-3` and `DP-0003` §4.3 both state that `ADR-0154` §7 **determined**
`ICFG` scope as `Platform default`, and instruct that it *"must not be
re-decided"*.** ⛔⛔ **That is wrong on two counts:**

1. ⭐ `ADR-0154` **§7 is titled *"`ICFG-1`…`ICFG-10` — expressly NOT batched"*** and
   concludes *"**they remain `NOT YET AUTHORIZED`**"*. ⭐ Its scope row is an **audit
   observation**, ⛔ **not a determination** — and `D-8` says the classification
   *"**MUST NOT** be extended to them by analogy."*
2. ⭐⭐ `Accepted` **`ADR-0158` §2.4a contradicts it directly**, recording scope as
   ⚠️ **"AMBIGUOUS"** and **Sufficient? ⛔ NO** — because `ICFG-5`/`6`/`7` say *"per
   library"* while the env table gives per-environment values.

⭐ **Corrected:** `ICFG` scope is **OPEN**, not determined. ⚠️ This makes `B-3`
**harder**, not easier — ⛔ a third dimension is unresolved.

### 7.2 ⛔ `CFG-12` does **NOT** engage `B-6`

⚠️ **`DP-0002` `B-6-adj` records that `CFG-12`'s owner-of-record *"Security + Legal"*
**engages the external legal blocker**.** ⛔⛔ **Measured and falsified:**

| Probe | Result |
|---|---|
| `CFG-12` in `LEGAL_RISK_REGISTER` | ⛔ **0** |
| *"elevated"* / *"elevation"* in `LEGAL_RISK_REGISTER` | ⛔ **0** |
| `LR-01`'s subject matter | ⭐ *"Data-retention legal basis for **`StudentAttendance`, `StudentRecord` financial history, biometric-adjacent data and register images**"* — ⛔ **elevated-access duration is none of these** |
| `U-1`…`U-13` touching elevated access | ⛔ **0** |
| Retention vocabulary in `CFG-12`'s own guide section | ⛔ **0** |

⭐ **A word in an owner-of-record cell is not an engagement of a risk register.**
⭐ **Corrected:** `CFG-12` is held on the **self-reference** ground alone (§3.5).
⛔ **It is NOT externally blocked.**

### 7.3 ⛔ `B-8`'s authority was mis-named

⚠️ **`DP-0002` and `DP-0003` route `B-8` to the *"`PRD-002` Domain Owner (Library
Domain) + Product Owner"*.** ⭐ That was derived from `BC-06` → `PRD-002` ownership.
⛔⛔ **But `SEAT-GAP-005`'s own owner column reads *"**Architecture**"*
*(`PRD-007` **L2257**)*, because the act required is a **BC Map payload
amendment**, not a domain decision.

⭐ **Corrected:** `B-8` is an **Architecture Owner** act *(with the Product Owner for
the resulting value)*. ⛔ Routing it to a Domain Owner would have sent it to an office
that cannot perform it.

---

## 8. ⚠️ A pre-existing inconsistency, **disclosed and NOT repaired**

⭐ `ADR-0155` `D-4` reads *"⚪ **`WRITE` = `N/A`** for **all 11**"*, ⛔ but its §2.5
table row for `SCFG-2` shows **HELD** in the `WRITE` cell. ⭐ **The two statements
cannot both be exact.**

⛔⛔ **Not repaired here.** ⭐ `ADR-0155` is `Accepted`; correcting it is a separate
act, and ⛔ nothing in this ADR depends on which reading is right — `SCFG-2` is
**HELD** either way (§4). **Owner: Architecture Owner.**

---

## 9. Reconciliation and gate re-evaluation

### 9.1 ⭐⭐ The 104, reconciled exactly

| Group | IDs | Count | State |
|---|---|---:|---|
| 1 Face family | `ATT-CFG-013`, `014`, `015`, `016` | **4** | ⛔ **HELD** — §6.5 |
| 2 Authorization-semantic — attendance | `ATT-CFG-022`, `023`, `024` | ⭐ **3** | ⭐⭐ **AUTHORIZED** — §3.4 |
| 3 Authorization-semantic — seat | `SEAT-CFG-005`, `014` | ⭐ **2** | ⭐⭐ **AUTHORIZED** — §3.4 |
| 4 Invitation security | `ICFG-1`…`10` | **10** | ⛔ **HELD** — §5 |
| 5 Retention / DPDP | `CFG-10`, `SCFG-4` | **2** | ⛔ **HELD** — §6.1 |
| 6 Definition undecided | `SMCFG-5` → ⭐ **AUTHORIZED**; `SEAT-CFG-017` → ⛔ **HELD** | **1 + 1** | ⭐ **1 / ⛔ 1** — §6.3, §6.4 |
| 7 Authorization — other | `CFG-12`, `SCFG-2` | **2** | ⛔ **HELD** — §3.5, §4 |
| | **TOTAL** | ⭐ **25** | ⭐ **6 authorized · ⛔ 19 held** |

⭐⭐ **79 + 6 = 85 AUTHORIZED · 19 HELD · 85 + 19 = 104.** ⛔ **The inventory is
unchanged at 104; ⛔ no parameter was authorized to reach a number.**

### 9.2 ⭐ `DD-0007` `D1`–`D5`, re-evaluated

| Gate | Before | After | Why |
|---|---|---|---|
| **D1** Target app | ⭐ PASS | ⭐ **PASS — unchanged** | ⛔ All six are **APP 2** tenant parameters; ⛔ no app added, ⛔ APP 3 untouched |
| **D2** | ⭐ PASS | ⭐ **PASS — unchanged** | ⛔ Nothing engaged |
| **D3** Authorization coverage | ⚠️ `PARTIAL` 79/104 | ⚠️⚠️ **`PARTIAL` 85/104** | ⛔ **19 remain.** ⛔⛔ **104/104 NOT claimed** |
| **D4** Scope | ⭐ PASS | ⭐ **PASS** — ⭐ gains **6** at `Tenant` | ⛔ No new scope class; ⛔ `Branch` still **0**; ⛔ `SEAT-XC-022`'s sole referent still HELD |
| **D5** Cross-app dependencies | ⭐ PASS *(exactly one)* | ⭐ **PASS — still exactly ONE** | ⛔ The six are **APP 2 tenant** parameters, ⛔ **not** platform-default; ⛔ surface `C-5` stays at **19** |

⭐⭐ **`DD-0007` DESIGN-READINESS: ⛔⛔ NOT DESIGN-READY.** ⭐ **D3 is `PARTIAL`**,
**19** parameters are held, and ⚠️ **AUTHORIZED ≠ DESIGNED** — ⛔ the six are **not
designed** here, so Figma blockers stay at **4** and surfaces at **3 of 5**.

### 9.3 ⛔⛔ `DD-0007` is **NOT edited**

⭐ The permitted change set is *decision records, ADRs, indexes and `DP-0001`/`0002`/
`0003`*. ⛔ **`DD-0007` is none of these**, and it has been treated as read-only
throughout this chain *(md5 `db7beded`)*.

⚠️ **Consequence, disclosed:** `DD-0007` **v0.9** still records **79 / 104**. ⭐ It is
now **STALE by six**, and ⛔ **reconciling it is a separate act requiring its own
authority.** ⭐ This ADR, not `DD-0007`, is the current record of coverage.

---

## 10. ⛔ What is **NOT** created

⛔ **0** `PERM-*` *(`AUTH-7.22` closed at zero)* · ⛔ **0** roles *(platform **2**,
library **5**)* · ⛔ **0** action classes · ⛔ **0** scope classes · ⛔ **0** permission
hierarchies *(`AUTH-7.28`)* · ⛔ **0** bounded contexts, edges or ports *(⛔ `E-05`
payload **unchanged**)* · ⛔ **0** retention periods, TTLs or purge schedules
*(`T-10`)* · ⛔ **0** legal conclusions · ⛔ **0** offices · ⛔ **0** appointments
*(every office remains **vacant**; ⛔ no personal name recorded)* · ⛔ **0** frozen
documents modified · ⛔ **0** `Accepted` ADRs amended · ⛔ **0** runtime code, schemas
or implementation authority.

⭐⭐ **Configuration authorization ≠ implementation authorization.** ⛔ **Nothing here
authorises anything to be built.**

---

## 11. ⛔ Remaining blockers — **7**, over **19** parameters

| # | Blocker | Authority | ⛔ Internal or external | Params |
|---|---|---|---|---:|
| **`B-1″`** | `CFG-12` `READ` — **self-reference** *(narrowed; ⛔ legal limb withdrawn)* | Authorization Owner | ⭐ Internal | **1** |
| **`B-2`** | `SCFG-2`'s reviewer is named **nowhere** | Authorization Owner | ⭐ Internal — ⛔ but **unanswerable on current evidence** | **1** |
| **`B-3′`** | `ICFG` **`READ` + scope** *(commercial now evidenced)* | Product Owner + SECURITY PLATFORM | ⭐ Internal | **10** |
| **`B-5′`** | `CFG-10` / `SCFG-4` **value** limb | ⛔ **External** via `B-6` | ⛔ **External** | **2** |
| **`B-6`** | `LR-01` — retention legal basis **UNDETERMINED** | ⛔⛔ Qualified Indian advocate / court / DPB | ⛔⛔ **EXTERNAL** | *(gates `B-5′`, `B-10`)* |
| **`B-8′`** | `E-05` payload amendment, then `SEAT-CFG-017` | ⭐ **Architecture Owner** *(corrected)* + Product Owner | ⭐ Internal — ⛔ **Rank 1 act**, outside this change set | **1** |
| **`B-10`** | `ATT-GAP-012` *(BC Map)* + `ATT-GAP-014` *(`LR-01`)* | Architecture Owner + Security Owner + ⛔ external | ⛔ **Mixed — externally gated** | **4** |
| | | | ⭐ **TOTAL** | ⭐ **19** |

⭐⭐ **The external set is RECOMPOSED, not reduced:** ⛔ `CFG-10`, `SCFG-4` **(2)** +
the Face family **(4)** = **6** externally gated; ⭐ `CFG-12` **moves out** of the
external set into the internal one (§7.2).

---

## 12. Changelog

| Version | Date | Change |
|---|---|---|
| ⭐⭐ **v1.0** | 2026-09-19 | ⭐⭐ **Created and `Accepted`. `BC-25` authorization coverage 79 / 104 → 85 / 104.** ⭐ **SIX parameters authorized** — `ATT-CFG-022`/`023`/`024` *(`Tenant`; `WRITE` **`TR-1`** consumed from FROZEN `PRD-006` §16.3; `READ` **`TR-1`+`TR-2`+`TR-3`**; `NOT COMMERCIAL`)*, `SEAT-CFG-005`/`014` *(`Tenant`; `WRITE` **`TR-1` only** on **`SEAT-PO-021`**, which governs *"a module configurable **owned by `BC-25`**"* and ⭐ **both are `BC-25`-owned**; `READ` **`TR-1` only** per `ADR-0157` §2.1b; `NOT COMMERCIAL` **mandated** by `SEAT-FR-279`)* and `SMCFG-5` *(`Tenant`; `WRITE` **`TR-1`+`TR-2`**, `TR-3` ⛔; `READ` all three; `NOT COMMERCIAL`)*. ⭐⭐ **`B-1′` DETERMINED: a capability-conferring configuration write is a CONFIGURATION act** — ⛔ **not** the creation of a permission or role — ⭐ with the limiting half enforced: the **effect** stays inside the existing authorization boundary, and ⭐ **the `C` cells were already in `SEAT-FR-272`'s CLOSED protected-operation list**, so ⛔ nothing is added. ⭐ **`022`/`023` answered TOGETHER** — ⛔ the nullification concern does not arise, both having the same writer, and `0` already being a PO-authorised value. ⭐⭐ **`B-7` DETERMINED on FIVE measured machine-facing obligations and ZERO human-meaning obligations** *(`SM-INV-1`, `SM-3.4` step 5 *"allocate"*, `SM-3.17` collision-free, `SM-3.5`, `SM-EV-9` *"searchable"*)* — `enrollmentNumber` is ⛔ **NOT human-meaningful**; the *"tenant-prefixed sequence"* default is **expressly confirmed as an opaque generation strategy**, ⛔ **not ratified by silence**. ⚠️ **The `SMCFG-5` ALLOCATION limb is flagged as the pass's most contestable step** and its reversion condition stated. ⚠️⚠️ **THREE CLAIMS OF MY OWN ARE WITHDRAWN AS ERRORS, RELEASING ZERO PARAMETERS:** ⛔ **(1)** `DP-0002`/`DP-0003`'s *"`ICFG` scope is already determined by `ADR-0154` §7"* — ⭐ §7 is titled *"expressly **NOT** batched"*, concludes *"remain `NOT YET AUTHORIZED`"*, and ⭐⭐ `Accepted` `ADR-0158` §2.4a records scope **AMBIGUOUS / Sufficient? NO** — ⚠️ this makes `B-3` **harder**; ⛔ **(2)** `DP-0002` `B-6-adj`'s *"`CFG-12` engages the legal blocker"* — ⭐ measured **0** occurrences of `CFG-12`, *"elevated"* or *"elevation"* in `LEGAL_RISK_REGISTER`, and `LR-01`'s subject is retention of four named data classes, ⛔ none of them elevated-access duration — ⭐ **a word in an owner-of-record cell is not an engagement of a risk register**; ⛔ **(3)** `DP-0002`'s routing of `B-8` to the *"`PRD-002` Domain Owner"* — ⭐ `SEAT-GAP-005`'s own owner column reads **Architecture**, the act being a **BC Map payload amendment**. ⛔⛔ **FOUR BLOCKERS PRESERVED ON EXPRESS GROUNDS:** `B-2` **HELD** — *"removing an entry requires review"* occurs in **exactly one** primary source and ⛔ **names no actor**; `S-3` makes `HOLD` the correct answer. `B-3` **all ten HELD** — ⭐ the commercial limb is **evidenced `NOT COMMERCIAL`**, ⛔ but `READ` has **0** statements and scope is ambiguous; ⭐⭐ `ADR-0158` §2.4b's refusal of the `PR-n` argument is **CONFIRMED A THIRD TIME**. `B-5` **HOLD preserved** — ⭐ tested and **neither** Governance nor Architecture has authority: `LR-01` makes the Architecture Owner *"custodian of the record **only**"* — ⭐⭐ **but the routing conflict IS fixed**: `DP-0001` §3's addressee was the **Privacy Owner**, whom `LR-01` disqualifies. `B-8`/`B-10` **HELD** — ⭐ `E-05`'s payload is `SeatRules{maxTransfersPerDay, reservationWindow}` *(BC Map **L302**)* and confirming a threshold means **amending a Rank-1 contract**; ⛔ `ATT-GAP-014` **is `LR-01`'s own §5 condition 4**, and `ATT-FR-064` requires **both** gaps answered. ⛔⛔ **`B-6` UNTOUCHED AND EXTERNAL** — ⛔ **no `Legal Owner` constituted** *(measured **0**; `ADR-0137` refused it)*, ⛔ **no legal conclusion drawn**, ⛔ **`ADR-0137` not overridden**. ⚠️ **A pre-existing inconsistency inside `Accepted` `ADR-0155` is DISCLOSED, ⛔ not repaired** — `D-4` says ⚪ `WRITE` = `N/A` *"for all 11"* while the §2.5 table shows `SCFG-2`'s `WRITE` as **HELD**; ⛔ nothing here depends on it. ⭐ **D1, D2, D5 UNCHANGED**; ⭐ **D4 gains 6 at `Tenant`**; ⚠️⚠️ **D3 REMAINS `PARTIAL` at 85 / 104** — ⛔⛔ **`DD-0007` REMAINS NOT DESIGN-READY**. ⛔⛔ **`DD-0007` IS NOT EDITED** — it is outside the permitted change set; ⚠️ its **v0.9** figure of **79 / 104** is therefore **STALE by six**, ⭐ **disclosed rather than silently corrected**. ⛔⛔ **PRESERVED BYTE-UNCHANGED:** `ADR-0151`…`ADR-0161` · `PRD-006` · `PRD-007` · `PRD-004` · `Student_Identity_PRD_v1` · `Authentication_PRD_v2` · `PRD-023` · `INVITATION_SECURITY_SPECIFICATION` · `CONFIGURATION_GUIDE` · `LEGAL_RISK_REGISTER` · BC Map · `DD-0007` · the **104**-parameter inventory. ⛔ **0** `PERM-*` · **0** roles/actions/scopes · **0** offices · **0** appointments · **0** retention periods · **0** legal conclusions · **0** frozen edits · **0** lines of runtime code · ⛔ **no commit, no push**. |

---

*End of `ADR-0162`. ⭐ **85 / 104 authorized · 19 held · D3 `PARTIAL` · `DD-0007` NOT design-ready.***
