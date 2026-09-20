# DP-0002 — FINAL Governance Decision Request: the **8 remaining `DP-0001` blockers** over the 25 held `BC-25` parameters

| Field | Value |
|---|---|
| **Type** | ⭐ **Decision request** — ⛔⛔ **this sheet decides NOTHING** |
| **Status** | ⛔ **OPEN** · ⛔ **0 responses received** |
| **Raised** | 2026-09-19 |
| **Supersedes** | ⛔⛔ **NOTHING.** ⭐ `DP-0001` stays **OPEN** and is **not replaced** — ⭐ this sheet addresses the **blockers**, `DP-0001` addresses the **parameters** |
| **Source of the blocker list** | ⭐⭐ `Accepted` [`ADR-0161`](../adr/ADR-0161-dp-0001-blocker-resolution-pass-b1-b9-corrected-b3-b4-narrowed-six-blockers-preserved.md) §7 |
| **Parameters affected** | ⭐ **25 held** of the **104** inventory. ⛔ Coverage **79 / 104**, unchanged |
| **Prior context** | `DP-0001` §5A *(proposed)* · §5B *(`ADR-0160` assessment)* · §5C *(`ADR-0161` resolution pass)* |

> ⛔⛔ **THIS SHEET AUTHORIZES NOTHING, DECIDES NOTHING, AND CHANGES NO COUNT.**
> ⭐ It states **8 questions**, cites the **frozen text that creates each**, names the
> **existing authority** for each, and records what each decision **must not change**.
>
> ⭐⭐ **`B-9` and `B-1` are absent by design** — ⚠️ `ADR-0161` **withdrew both as errors**
> of `ADR-0160`, ⛔ not as closures. ⭐ `B-1` is replaced by **`B-1′`**, which is the
> **substantive** question the vacancy claim was obscuring. ⛔ `B-4` is absent because
> `ADR-0154` §7 **already determined** it.

---

## 0. ⛔⛔ Constraints binding every answer

| # | Constraint | Source |
|---|---|---|
| 1 | ⛔ Platform roles **closed at TWO** — `PR-1`, `PR-2` | `AUTH` ch.07 **L79** |
| 2 | ⛔ Library roles **closed at FIVE** — `TR-1`…`TR-5` | `AUTH` ch.07 **L87** |
| 3 | ⛔⛔ **The permission catalogue is CLOSED at ZERO** — *"A permission not declared in it **cannot be granted**"* | **`AUTH-7.22`** *(**L2336**)*, `ADR-0132` |
| 4 | ⛔ **`READ` and `WRITE` are independent** — *"Each action class **MUST** be granted independently. Read **MUST NOT** imply any other action"* | **`AUTH-7.24`** *(**L2363**)*, `CNF-BR-010` |
| 5 | ⛔ **No role hierarchy** — *"Permissions **MUST NOT** form a hierarchy. No permission implies another."* | **`AUTH-7.28`** *(**L2394**)* |
| 6 | ⛔ **Frozen PRDs MUST NOT be amended** to fit a decision | `ADR-INDEX` process |
| 7 | ⛔ **The 104 inventory MUST NOT change** | standing |
| 8 | ⚠️ ⚪ **`N/A` ≠ ⛔ `DENY`** | `ADR-0151` §3.5 · `ADR-0155` `S-4` |
| 9 | ⭐⭐ **`HOLD` remains a correct answer.** ⛔ **Do NOT decide to reach 104/104** | standing |
| 10 | ⭐ **An office is exercised by ONE-ACT CONFERRAL, ⛔ not by appointment** — ⛔ **no personal name may be recorded** | `PRD_OWNERSHIP_MODEL` **§12.1**, §7 rule 4 · `ADR-0033` §7.1 |

⚠️⚠️ **Constraint 10 matters procedurally:** ⭐ every office named below is **VACANT**, and
that is the **normal** state. ⛔ **No appointment is being requested** — ⭐ each answer is
given by **direct conferral for that act only**.

---

# PART A — ⭐ DECIDABLE **INSIDE** THE REPOSITORY

⭐ **5 blockers · 20 parameters.** ⭐ Each has a **constituted** office and needs **no**
external input.

---

## `B-1′` — May a configuration write **confer or remove a role capability** at all?

| | |
|---|---|
| **1. The question** | ⭐⭐ **Where a configuration parameter's value determines whether a role may perform an operation, is writing that parameter a *configuration* act or an *authorization* act?** ⛔ And if it may be allocated, what is the `READ` allocation for these six? |
| **2. Authoritative source** | ⭐ `PRD-006` §19.2 **L1980** — *"Corrections (§18) \| `reception`, `manager` — **subject to `ATT-CFG-022`**"* · **L1983** — *"View guarded students' attendance \| `parent` — **subject to `ATT-CFG-024`**"* · ⭐⭐ `PRD-007` `SEAT-PO-010` = **`C (SEAT-CFG-005)`** and `SEAT-PO-007` = **`C (SEAT-CFG-014)`**, the legend defining **`C`** as *"permitted **only where the named configurable grants it**"* — ⭐ **the parameter IS the grant** · ⛔ `AUTH-7.22` *(**L2336**)* keeps the catalogue **closed at zero** |
| **3. Responsible authority** | ⭐ **Authorization Owner** *(`PRD_OWNERSHIP_MODEL` **§16**, constituted by `ADR-0159`)* — ⭐ by **one-act conferral**, ⛔ **not** an appointment |
| **4. Decision required** | ⭐ **(a)** Rule on the character of such a write — *configuration*, *authorization*, or *both*. ⭐ **(b)** If allocable: the **`READ`** allocation for all six, decided **independently** of `WRITE` *(`CNF-BR-010`)*. ⭐ **(c)** Confirm whether `ATT-CFG-022` and `ATT-CFG-023` may diverge, ⚠️ since `023` **time-bounds** the capability `022` gates — ⛔ permitting corrections while setting the window to `0` would nullify the grant while appearing to confer it |
| **5. ⛔ MUST NOT change** | ⛔ No new `PERM-*` *(`AUTH-7.22`)* · ⛔ no new role, action class or scope class · ⛔ no role hierarchy *(`AUTH-7.28`)* · ⛔ `WRITE` **must not** be read as implying `READ` *(`AUTH-7.24`)* · ⛔ no frozen PRD amended · ⛔ `ADR-0153`'s 17-parameter allocation **not** extended by analogy |
| **6. Parameters blocked** | ⭐ **6** — `ATT-CFG-022` · `ATT-CFG-023` · `ATT-CFG-024` · `SEAT-CFG-005` · `SEAT-CFG-014` · `CFG-12` |

⚠️ **`CFG-12` carries a second dimension:** ⭐ it is **self-referential** — it bounds
**`PR-2`'s own elevation ceiling** — so a `PR-2` read of it cannot be settled by an act
that relies on `PR-2`. ⚠️ Its **owner of record** is *"Security + Legal"*, which engages
**`B-6`**. ⛔ **It may therefore not be answerable in Part A alone** — ⭐ please state
expressly if you consider it out of scope here.

---

## `B-2` — Who is `SCFG-2`'s *"review"* authority?

| | |
|---|---|
| **1. The question** | ⭐ `SCFG-2`'s register entry requires a **review** before an entry may be removed. ⛔⛔ **The source never says by whom.** Who is it? |
| **2. Authoritative source** | ⭐ `Student_Identity_PRD_v1` §5.5 **L1336**, verbatim: <br>`\| `SCFG-2` \| Reserved-username list \| Platform-managed list \| — \| Additive only; **removing an entry requires review** \|` |
| **3. Responsible authority** | ⭐ **Authorization Owner** *(one-act conferral)* — ⭐ as already routed by `ADR-0155` **`S-3`** |
| **4. Decision required** | ⭐ **Name the review authority explicitly**, ⭐ **or** confirm `HOLD`. ⭐ If named, also state the `READ`/`WRITE`/scope/commercial allocation |
| **5. ⛔ MUST NOT change** | ⛔⛔ **The reviewer MUST NOT be inferred** from `TR-n`/`PR-n` naming, ownership, hierarchy or UI visibility — ⭐ `ADR-0155` `S-3` is express · ⛔ the other **9** `SCFG-*` allocations *(`ADR-0155`)* **not** reopened · ⛔ `SID-5.45`'s *"platform-wide … **None SHALL be organisation-configurable**"* **not** weakened |
| **6. Parameters blocked** | ⭐ **1** — `SCFG-2` |

---

## `B-3` — The `ICFG` register's `READ` allocation and commercial classification

| | |
|---|---|
| **1. The question** | ⭐ **Who may READ `ICFG-1`…`ICFG-10`**, and ⭐ **are they `COMMERCIAL` or `NOT COMMERCIAL`?** |
| **2. Authoritative source** | ⛔⛔ **The question exists because the sources are SILENT.** ⭐ Measured: **0** read statements and **0** commercial statements across `INVITATION_SECURITY_SPECIFICATION` §11 and `CONFIGURATION_GUIDE` §2B. ⭐ The only role text is a **prohibition**: **`INV-SEC-018`** *(**L175**)* — *"An expired invitation **MUST** be refused, and refusal **MUST NOT** be overridable by any library role, including `TR-1` Owner"* — and **`INV-SEC-019`** *(**L178**)* — *"Expiry **MUST NOT** be extendable."* ⭐ Roles named: `TR-1`×6, `TR-2`×6, `TR-3`×3, ⛔ **`PR-1`/`PR-2` = ZERO** |
| **3. Responsible authority** | ⭐ **Product Owner + SECURITY PLATFORM** *(jointly)* — ⭐ the pairing `ADR-0154` §7 names |
| **4. Decision required** | ⭐ **(a)** An express **`READ`** allocation. ⭐ **(b)** The **commercial** classification. ⭐ **(c)** Whether `ICFG-8` and `ICFG-10` need different treatment — ⚠️ `ICFG-8` *"is what makes 40 bits sufficient"*, and `ICFG-10`'s rationale reads *"Matches `CFG-4`"* |
| **5. ⛔ MUST NOT change** | ⛔⛔ **Scope and `WRITE` are ALREADY DETERMINED and must not be re-decided** — `ADR-0154` §7: **Scope = `Platform default`** *(10/10 in the §4 env table)* and **`WRITE` = none storable** *(`CNF-FR-028`)* ⇒ ⚪ **`N/A`, ⛔ not `DENY`** · ⛔⛔ **`READ` MUST NOT be derived from `WRITE`** *(`CNF-BR-010`, `AUTH-7.24`)* — ⭐ in particular ⛔ **`READ` = `N/A` "by symmetry" is FORBIDDEN**, because ⚪ `N/A` rests on `CNF-FR-020`, a **write-only** rule · ⛔ a denial of `TR-n` is **not** a grant to `PR-n` *(`AUTH-7.28`)* · ⛔ *"Matches `CFG-4`"* is a **value** rationale, **not** an authority statement |
| **6. Parameters blocked** | ⭐ **10** — `ICFG-1` … `ICFG-10` |

⚠️⚠️ **One prior refusal needs your express ruling.** ⭐ `ADR-0158` §2.4b **refused** the
argument that `READ` = `PR-1`+`PR-2` follows from *"every parameter in this register is
security-owned"*. ⭐ `ADR-0160` **confirmed** that refusal. ⭐ **Please either confirm it
again, or overrule it with express authority.**

---

## `B-5` — Which office may allocate a parameter whose **hold reason is the `LR-01` legal question**?

| | |
|---|---|
| **1. The question** | ⚠️⚠️ **`DP-0001` §3 routes `CFG-10`/`SCFG-4` to the Privacy Owner. `LR-01` names that office among those who CANNOT close the retention question.** ⭐ Which office may act, and on what? |
| **2. Authoritative source** | ⭐⭐ `LEGAL_RISK_REGISTER` **`LR-01`**: *"⛔⛔ **PERMANENTLY OPEN.** Closable **ONLY** by an authoritative external determination. ⛔ **NOT closable by Product, Domain, Architecture, Technical, Privacy, Governance, SRE, EVENT-platform or DATA/EVENT Owner, jointly or severally.**"* · ⭐ tripwire **`T-10`** fires on *"**Any proposal to set a retention period**, add a TTL … or amend `RET-01`…`RET-13`"* — ⛔ *"**NOT implementable without a NEW ADR** and the authority the law identifies"* · ⭐ `CFG-10`'s own rationale **is** the legal argument: *"short enough to remain **defensible as erasure under DPDP**"* |
| **3. Responsible authority** | ⭐ **Governance Owner + Architecture Owner** *(jointly, one-act conferral)* |
| **4. Decision required** | ⭐ **(a)** Rule whether the **narrow allocation question** *(who may read/write the parameter)* is **severable** from the **`LR-01` legal question** *(what the value may lawfully be)*. ⭐ **(b)** If severable: name the office that may allocate. ⭐ **(c)** If not: confirm both stay **HELD** pending `B-6`. ⭐ **(d)** Correct `DP-0001` §3's addressee accordingly |
| **5. ⛔ MUST NOT change** | ⛔⛔ **`LR-01` MUST NOT be closed, narrowed, mitigated or re-statused** — ⭐ it closes only on **all five** §5 conditions · ⛔ **no retention period may be set, changed or ratified** *(`T-10`)* · ⛔ `RET-03`/`RET-06`/`RET-13` **must not** be cited as legal justification *(`T-11` — **automatic REJECT**)* · ⛔ **no re-routing merely to escape the prohibition** — ⭐ that is evasion, not resolution |
| **6. Parameters blocked** | ⭐ **2** — `CFG-10` · `SCFG-4` |

---

## `B-7` — Is `enrollmentNumber` human-meaningful, and what is its format?

| | |
|---|---|
| **1. The question** | ⭐ **`SMCFG-5`'s definition is undecided** — ⛔ not merely its authority |
| **2. Authoritative source** | ⭐ `Student_Management_PRD_v1` **L1168**, verbatim: <br>`\| `SM-GAP-2` \| `enrollmentNumber` format and whether it is human-meaningful \| `SM-INV-1` requires uniqueness only. **`SMCFG-5`'s default is a placeholder pending a decision** \|` <br>⭐ Corroborated: `PRD-004_TRACEABILITY` **L187** *("placeholder", "undecided")* · `DD-0002` **L158** *("no form")* · ⛔ **`SM-GAP-2` appears in ZERO ADRs** |
| **3. Responsible authority** | ⭐ **Product Owner** *(one-act conferral)* |
| **4. Decision required** | ⭐ **(a)** Is `enrollmentNumber` **human-meaningful**? ⭐ **(b)** If yes, the **format**. ⭐ **(c)** If not ready — ⭐ **`HOLD` is the correct answer** |
| **5. ⛔ MUST NOT change** | ⛔ `SM-INV-1`'s **uniqueness** invariant **not** weakened · ⛔ the current *"tenant-prefixed sequence"* default **must not** be ratified by silence — ⭐ the independent review holds that *"a configurable **should not publish a default** for a parameter the document says is undecided"* · ⛔ the other **6** `SMCFG-*` allocations *(`ADR-0156`)* **not** reopened · ⛔ **the 104 inventory unchanged** |
| **6. Parameters blocked** | ⭐ **1** — `SMCFG-5` |

---

## `B-8` — Does the `E-05` contract carry the occupancy threshold?

| | |
|---|---|
| **1. The question** | ⭐ `SEAT-CFG-017` is owned by **`BC-06` via `E-05`** — ⛔ **the only one of 18 `SEAT-CFG-*` not owned by `BC-25`** — and the threshold is a **proposal**, not a contract term. ⭐ Is the `E-05` addition confirmed? |
| **2. Authoritative source** | ⭐ `PRD-007` **`SEAT-FR-267`**, verbatim: *"The occupancy threshold is a **proposed** addition to the `E-05` contract. Because `E-05`'s payload is fixed by the BC Map, that addition **MUST** be confirmed at **Stage 3** before implementation; it is recorded as **`SEAT-GAP-005`**. Until confirmed, no threshold is set and `SEAT-FR-241`'s unset behaviour applies — **no event is emitted, and no hard-coded value is substituted**."* · ⭐ Register **L1918**: *"**Unset in V1 — no event is emitted and no value is substituted**"* |
| **3. Responsible authority** | ⭐ **`PRD-002` Domain Owner (Library Domain)** + **Product Owner** — ⭐ the `BC-06` incumbent identified by `ADR-0160` §2.4: `PRD_REGISTRY` **L456** maps **`BC-06` → `PRD-002`**; `PRD_OWNERSHIP_MODEL` **L147** records its Domain Owner as **Library Domain** |
| **4. Decision required** | ⭐ **(a)** A **Stage-3 confirmation** that `E-05` carries the threshold — ⭐ **or** an express decision that it does not. ⭐ **(b)** If confirmed: the **scope** — ⚠️ `SEAT-XC-022` reads *"tenant-scoped, **or branch-scoped where `BC-06` owns it**"*, and ⭐ **this is its sole referent** |
| **5. ⛔ MUST NOT change** | ⛔⛔ **The 90% figure MUST NOT be applied as a fallback** — `SEAT-FR-241`, `SEAT-AC-170` forbid it in terms · ⛔ `E-05`'s **Conformist** character **not** altered — *"this module conforms and **MUST NOT** define its own copy"* · ⛔ the **15** authorized `SEAT-CFG-*` *(`ADR-0157`)* **not** reopened · ⭐ ⛔ **no new scope class is needed** — `Branch` is **already** scope 4 of the five in FROZEN `PRD-023` §3.1 **L377** *(`ADR-0161` withdrew the contrary claim)* |
| **6. Parameters blocked** | ⭐ **1** — `SEAT-CFG-017` |

---

# PART B — ⛔⛔ REQUIRES AN **EXTERNAL** PRINCIPAL

⛔ **3 blockers · 6 parameters** *(2 direct + 4 consequential)*. ⭐⭐ **No governance act
inside this repository can supply the missing input.**

---

## `B-6` — ⭐⭐ THE CRITICAL PATH: the retention legal basis is **UNDETERMINED**

| | |
|---|---|
| **1. The question** | ⛔⛔ **What does Indian law actually require of Liboora's data retention?** ⭐ And, consequently, **who** may set a retention period? |
| **2. Authoritative source** | ⭐⭐ `LR-01` — *"Data-retention legal basis … is **UNDETERMINED**"*, ⛔ **PERMANENTLY OPEN**, severity *"**HIGH and UNQUANTIFIED**"*, with **13 unresolved uncertainties** `U-1`…`U-13` — ⭐ `U-11` being *"whether **indefinite retention is permissible at all**"*, recorded as **the central residual risk** · ⛔⛔ **The office named as owner of the affected parameters does NOT exist:** *"Legal Owner"* measures **0** repository-wide, and `Accepted` **`ADR-0137`** states expressly — ⛔ *"Does **not** constitute **Legal Counsel** as an office"* |
| **3. Responsible authority** | ⛔⛔ **NOT a governance office.** ⭐ `LR-01` §5 requires *"a written determination from a **qualified Indian advocate** — or a competent authority, court, or Data Protection Board ruling"*. ⭐ The **risk bearer** is recorded as **the human principal of this engagement** — *"the risk is **borne, not delegated**"* |
| **4. Input required** | ⭐ **All five** `LR-01` §5 closure conditions: **(1)** a written external determination addressing `U-1`…`U-13`; **(2)** recorded in a **NEW ADR** *(⛔ `ADR-0137` may not be edited)*; **(3)** a retention **period** — or an express determination that none is required — adopted by **the office the determination identifies**; **(4)** `ATT-GAP-005`, `ATT-GAP-014`, `ATT-GAP-016`, `AUD-GAP-001` and blocker **7a** each dispositioned; **(5)** `MP-GBR-04`'s *"retained under legal basis"* clause **substantiated or amended** |
| **5. ⛔ MUST NOT change** | ⛔⛔ **A `Legal Owner` MUST NOT be constituted internally** — ⭐ `ADR-0137` refused it, and constituting one would **overturn an `Accepted` ADR by implication** and **manufacture the appearance** of an authority no internal act can confer · ⛔ **`LR-01` does not close on any subset** of the five · ⛔ **mitigation is not compliance** — `RET-01`…`RET-13` resolve **no** legal question · ⛔ `T-11`: citing `RET-03`/`RET-06`/`RET-13` as legal justification is an **automatic REJECT** |
| **6. Parameters blocked** | ⭐ **2 directly** — `CFG-10`, `CFG-12` *(owner of record "Legal + Security" / "Security + Legal")*; ⭐ **4 more via `B-10`** — the Face family, through `ATT-GAP-014` |

⚠️⚠️ **This is the only blocker whose resolution lies wholly outside this repository, and
it gates the largest number of parameters.** ⭐ **`T-7`** is directly relevant: *"Liboora
**engages a qualified Indian advocate for ANY purpose** — `LR-01` **must be tabled** in
that engagement."*

---

## `B-10` — `ATT-GAP-012` and `ATT-GAP-014`: biometric ownership, retention and deletion

| | |
|---|---|
| **1. The question** | ⭐ **Which context owns biometric templates, and what is their retention/deletion rule?** ⛔ Until both are answered, the Face mode **may not be built** |
| **2. Authoritative source** | ⭐⭐ `PRD-006` **`ATT-FR-064`** *(**L1444**, FROZEN)*, verbatim: *"Until `ATT-GAP-012` and `ATT-GAP-014` are **both** answered by their named owners, face verification **MUST NOT** be implemented. The mode is specified; it is **not** authorised to be built."* · ⭐ And the reason the document itself gives: *"**This is the one mode this document blocks outright.** Enrolling biometric data **for minors** with no owner, no retention rule and no deletion path is a **legal exposure, not a scheduling detail**."* · ⛔ `ATT-GAP-012` — *"**No context in BC Map §3 claims biometrics**"* · ⛔ `ATT-GAP-014` — retention/deletion under `ID-5`/`MP-GBR-04` |
| **3. Responsible authority** | ⭐ **Security Owner** *(constituted `ADR-0158` `R-1`; recorded `PRD_OWNERSHIP_MODEL` §17)* **+ `BC-13`/`BC-18`** — ⛔⛔ **and *Legal*, which does not exist** ⇒ ⭐ **blocked by `B-6`** |
| **4. Decision required** | ⭐ **(a)** `ATT-GAP-012` — the **owning context** for biometric templates, and the enrollment storage path. ⭐ **(b)** `ATT-GAP-014` — the **retention/deletion** rule, reconciled with `ID-5` erasure and `MP-GBR-04`. ⭐ **(c)** Only then: the authorization allocation for `ATT-CFG-013`/`015`/`016` |
| **5. ⛔ MUST NOT change** | ⛔⛔ **`ATT-FR-064` MUST NOT be amended, narrowed or worked around** *(FROZEN)* · ⛔⛔ **Configuration authority MUST NOT be allocated ahead of build authorization** — ⭐ `DP-0001` §5.1 offered this and `ADR-0160` **expressly declined** it as **authorization theatre**; ⭐ if you wish to permit it, it is a **NEW PRECEDENT** and must be recorded as such · ⛔ **a default value is not authorization** — ⚠️ `013`/`015`/`016` **do** carry V1 defaults, and that is **not** sufficient · ⛔ `ATT-GAP-014` **must not** be answered in a way that pre-empts `LR-01` |
| **6. Parameters blocked** | ⭐ **4** — `ATT-CFG-013` · `ATT-CFG-014` · `ATT-CFG-015` · `ATT-CFG-016` |

⚠️⚠️ **`ATT-CFG-014` carries a SECOND, INDEPENDENT bar** — ⛔ it is **outside V1** by
`D-3a` *(Face = **V3**)*, with both §16.3 columns reading *"Not in V1"*. ⭐⭐ **It would
NOT move even if `B-6` and `B-10` were both cleared.** ⭐ Please treat it separately.

---

## `B-6-adj` — ⚠️ `CFG-12`'s second dimension *(recorded, not a separate blocker)*

⭐ `CFG-12` appears in **`B-1′`** *(authorization-semantic)* **and** engages **`B-6`**
*(owner of record "Security + Legal")*. ⛔ **It is counted once** — in `B-1′`. ⚠️
**Recorded here so the dependency is visible**: ⭐ even a favourable `B-1′` ruling may
leave `CFG-12` held on the `B-6` limb.

---

## 1. ⭐ Summary — decisions, authorities, parameters

| # | Decision required | Authority | Params | Part |
|---|---|---|---:|---|
| **`B-1′`** | Character of a capability-conferring config write + `READ` | **Authorization Owner** | **6** | ⭐ A |
| **`B-2`** | Name `SCFG-2`'s review authority | **Authorization Owner** | **1** | ⭐ A |
| **`B-3`** | `ICFG` `READ` + commercial classification | **PO + SECURITY PLATFORM** | **10** | ⭐ A |
| **`B-5`** | Which office may allocate under `LR-01` | **Governance + Architecture Owner** | **2** | ⭐ A |
| **`B-7`** | Is `enrollmentNumber` human-meaningful? | **Product Owner** | **1** | ⭐ A |
| **`B-8`** | Stage-3 confirmation of the `E-05` addition | **`PRD-002` Domain Owner + PO** | **1** | ⭐ A |
| **`B-6`** | ⛔⛔ External legal determination | ⛔ **Qualified Indian advocate / court / DPB** | **2** *(+4)* | ⛔ B |
| **`B-10`** | Biometric ownership + retention | **Security Owner** + ⛔ *Legal* + `BC-13`/`BC-18` | **4** | ⛔ B |

⭐⭐ **Reconciliation:** 6 + 1 + 10 + 2 + 1 + 1 = **21** in Part A; **4** in Part B
*(`B-10`)*; ⭐ `B-6`'s 2 direct parameters *(`CFG-10`, `CFG-12`)* are **already counted** —
`CFG-10` under `B-5`, `CFG-12` under `B-1′`. ⭐ **21 + 4 = 25.** ⛔ **No parameter counted
twice, none omitted.**

---

## 2. ⭐⭐ Dependency order and parallelism

### 2.1 ⭐ Fully parallel — **no dependencies between them**

| Track | Blockers | Params |
|---|---|---:|
| **T1** | ⭐ `B-2` | 1 |
| **T2** | ⭐ `B-3` | 10 |
| **T3** | ⭐ `B-7` | 1 |
| **T4** | ⭐ `B-8` | 1 |
| **T5** | ⭐ `B-1′` *(⚠️ `CFG-12` limb may survive — see `B-6-adj`)* | 6 |

⭐⭐ **These five may be answered simultaneously, in any order, by five different
authorities.** ⛔ **None blocks another.** ⭐ Together they reach **19 of 25** parameters.

### 2.2 ⚠️ Sequential chain

```
B-6  (EXTERNAL: legal determination)
 ├──► B-5   (which office may allocate)  ──►  CFG-10
 └──► B-10  (ATT-GAP-012 + ATT-GAP-014)  ──►  ATT-CFG-013/015/016
                                               ⛔ ATT-CFG-014 stays held (V3)
```

⭐ **`B-5` has a conditional shortcut:** ⭐ if the Governance + Architecture Owners rule the
**allocation** question **severable** from the **legal** question, `B-5` can complete
**without** `B-6`, releasing `CFG-10`/`SCFG-4` from the routing conflict. ⛔ **That ruling
is theirs to make — this sheet does not pre-judge it.**

### 2.3 ⛔ Blocked externally

| | |
|---|---|
| ⛔ Params behind `B-6` | ⭐ **up to 6** — `CFG-10`, `CFG-12` + the **4** Face parameters via `B-10` |
| ⛔ Earliest internal resolution | ⭐ **None.** `LR-01` closes **only** on all five §5 conditions, of which **(1)** is external |
| ⛔ Parameters that **cannot** reach `AUTHORIZED` this cycle | ⭐ **at minimum `ATT-CFG-014`** — ⛔ outside V1 by `D-3a`, **independently** of everything above |

---

## 3. ⭐ Return format

⭐ One block per blocker. ⭐ **`HOLD` needs only fields 1 and 5.**

```
BLOCKER   | B-nn
AUTHORITY | (the office answering, exercised by one-act conferral)
DECISION  | RESOLVE | HOLD | RE-ROUTE
ANSWER    | (the determination, verbatim)
PARAMS    | (per parameter: SCOPE | READ | WRITE | COMMERCIAL — or HOLD)
LIMITS    | (anything the answer must NOT be read as deciding)
```

### 3.1 ⛔ What will NOT be done on receipt

⛔ Nothing inferred beyond what is written · ⛔ no answer carried between blockers · ⛔ no
`WRITE`→`READ` derivation or the reverse · ⛔ ⚪ `N/A` not recorded as ⛔ `DENY` · ⛔ no
`PERM-*` created · ⛔ no frozen document amended · ⛔ the **104** inventory unchanged · ⛔
no `Accepted` ADR edited or superseded by implication.

⭐ **Partial returns are useful** — ⭐ each of the five parallel tracks can be recorded the
moment it arrives.

---

## 4. ⭐ Current state, for context

| | |
|---|---|
| Coverage | ⭐ **79 / 104 authorized** *(76.0%)* · ⛔ **25 held** · ⭐ **79 + 25 = 104**, exact |
| `DD-0007` | ⭐ **D1 PASS · D2 PASS · ⚠️ D3 `PARTIAL` · D4 PASS · D5 PASS** · ⛔⛔ **NOT design-ready** |
| ⭐ The gate | ⛔ **D3 is the sole remaining declaration blocker** |

⛔⛔ **D3 closes only when all 25 are resolved — ⭐ and `HOLD` remains a correct resolution
for any of them.** ⛔ **Please do not decide anything merely to close it.**

---

## 5. Provenance

⛔ **This sheet authorizes nothing, decides nothing, and changes no count.** ⭐ It quotes
only existing frozen and authoritative sources. ⛔ **0** `PERM-*` · ⛔ **0** roles, actions
or scopes · ⛔ **0** frozen edits · ⛔ **0** runtime code · ⛔ **0** parameters moved · ⛔
**0** offices constituted.

| Source | Used for |
|---|---|
| `Accepted` `ADR-0161` §7 | ⭐ the blocker list |
| `ADR-0154` §7 · `ADR-0155` `S-3` · `ADR-0157` · `ADR-0158` · `ADR-0159` · `ADR-0160` | constraints and prior determinations |
| `Accepted` `ADR-0137` | ⛔ the `Legal Counsel` refusal |
| `LEGAL_RISK_REGISTER` `LR-01` §3, §5, §6 | `B-5`, `B-6` |
| `PRD-006` *(FROZEN v1.9)* | `B-1′`, `B-10` |
| `PRD-007` *(FROZEN v1.1)* | `B-1′`, `B-8` |
| `Student_Identity_PRD_v1` | `B-2` |
| `Student_Management_PRD_v1` *(FROZEN v1.2)* | `B-7` |
| `INVITATION_SECURITY_SPECIFICATION` · `CONFIGURATION_GUIDE` | `B-3` |
| `PRD-023` *(FROZEN)* · `Authentication_PRD_v2` | the §0 constraints |
| `PRD_OWNERSHIP_MODEL` §12.1, §16, §17 | the authorities and the conferral mechanism |

---

## 6. ⭐ Owner-facing workspace for Part A — `DP-0003`

⭐ The **5 internally decidable tracks** of Part A are prepared as an owner-facing
decision workspace in
[`DP-0003`](DP-0003-owner-decision-request-five-internally-decidable-bc-25-tracks.md),
reusing the repository's established *Pack → Request* pattern.

| | |
|---|---|
| ⭐ Tracks | `B-1′` · `B-2` · `B-3` · `B-7` · `B-8` — **19** parameters |
| ⭐ Per track | ⭐ one-sentence question · exact authority · **verbatim** evidence · allowed choices · ⛔ what the decision must **not** change · a **fill-in decision template** |
| ⛔ Out of scope | ⛔⛔ **`B-5`, `B-6`, `B-10` are NOT addressed there** — ⭐ they need an **external** principal and are **untouched** |

⛔⛔ **`DP-0003` decides nothing and proposes no value or allocation.** ⭐ Coverage stays
**79 / 104**; ⛔ **D3 `PARTIAL`**; ⛔ **`DD-0007` NOT design-ready**.


---

## 7. ⭐⭐ DISPOSITION by `ADR-0162` — **3 blockers closed, 3 of THIS pack's own claims CORRECTED** *(appended 2026-09-19)*

| Blocker | Disposition | Params |
|---|---|---:|
| ⭐⭐ **`B-1′`** | ✅ **CLOSED — CONFIGURATION act.** ⛔ Not permission/role creation; the **effect** stays in the existing authorization boundary | ⭐ **5 released** · ⛔ `CFG-12` held |
| ⛔ **`B-2`** | ⛔ **HELD** — reviewer named **nowhere**; `S-3` makes `HOLD` the correct answer | **1** |
| ⛔ **`B-3`** | ⛔ **HELD** — ⭐ commercial limb **evidenced `NOT COMMERCIAL`**; ⛔ `READ` **0** statements · ⚠️ **scope OPEN, see §7.1 below** | **10** |
| ⛔ **`B-5`** | ⛔ **HOLD preserved** — ⭐ tested: **neither** Governance nor Architecture has authority. ⭐⭐ **Routing corrected** | **2** |
| ⛔⛔ **`B-6`** | ⛔⛔ **EXTERNAL — untouched.** ⛔ No `Legal Owner`, ⛔ no legal conclusion, ⛔ `ADR-0137` not overridden | *(gates)* |
| ⭐⭐ **`B-7`** | ✅ **CLOSED — NOT human-meaningful**, on **5** machine-facing obligations vs **0** human-meaning ones | ⭐ **1 released** |
| ⛔ **`B-8`** | ⛔ **HELD** — ⭐ `E-05`'s payload is `SeatRules{maxTransfersPerDay, reservationWindow}`; confirming a threshold = **Rank-1 amendment** | **1** |
| ⛔ **`B-10`** | ⛔ **HELD** — `ATT-GAP-012` is a **BC Map** act; `ATT-GAP-014` **is `LR-01` §5 condition 4** | **4** |

### 7.1 ⚠️⚠️ THREE CLAIMS IN **THIS DOCUMENT** ARE WITHDRAWN AS ERRORS

| # | The claim, as written here | ⛔ Why it is wrong |
|---|---|---|
| **1** | `B-3` §5: *"**Scope and `WRITE` are ALREADY DETERMINED**"* for `ICFG` | ⭐ `ADR-0154` **§7 is titled *"expressly NOT batched"*** and concludes *"remain `NOT YET AUTHORIZED`"*; ⭐⭐ `Accepted` `ADR-0158` §2.4a records scope **AMBIGUOUS / Sufficient? NO**. ⚠️ **`B-3` is HARDER than stated** |
| **2** | `B-6-adj`: *"`CFG-12` … **engages `B-6`**"* | ⭐ Measured **0** hits for `CFG-12`, *"elevated"* and *"elevation"* in `LEGAL_RISK_REGISTER`; `LR-01`'s subject is retention of four named data classes. ⭐ **A word in an owner-of-record cell is not an engagement of a risk register** |
| **3** | `B-8` §3: authority = *"**`PRD-002` Domain Owner** + Product Owner"* | ⭐ `SEAT-GAP-005`'s own owner column *(`PRD-007` **L2257**)* reads **Architecture** — the act is a **BC Map payload amendment** |

⛔⛔ **All three release ZERO parameters.** ⭐ They are recorded because they were
**mine**.

### 7.2 ⭐ Current state

⭐⭐ **85 / 104 authorized · 19 held** · ⚠️ **D3 `PARTIAL`** · ⛔⛔ **`DD-0007` NOT
design-ready.** ⭐ **Part B is unchanged and remains the external request of record.**
