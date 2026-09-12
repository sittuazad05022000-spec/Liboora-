# `ADR-0137` — `Q-04` REFRAMED from a legal question to an internal data-governance question; `MP-DEP-07` discharged; the unresolved legal risk opened as `LR-01`

| Field | Value |
|---|---|
| **ADR** | `ADR-0137` |
| **Status** | ⭐ **Accepted** — by direct, explicit conferral of the human principal of this engagement, jointly exercising **Product Owner** and **Architecture Owner** authority, scoped to **this act and nothing else**. Same disclosure as `ADR-0033`, `ADR-0036`, `ADR-0129`…`ADR-0133`, `ADR-0136`: ⛔ **no ARB quorum, attendee list, sign-off date, Security review or Legal opinion is asserted**, and *"a conferral for one act is not a standing licence"* (`ADR-0033` §7.1) — both offices ⛔ **revert on completion** |
| **Date** | 2026-09-11 |
| **Baseline** | ⭐⭐ **ADVANCES** — `MASTER_PRD` v1.10 → **v1.11** is a **Rank 1** version change, so `DOCUMENTATION_BASELINE.md` §7 **rule 4** IS triggered |
| **Amends** | `MASTER_PRD` **L574** + **L676** (Rank 1, v1.10 → **v1.11**) · `LIBOORA_BOUNDED_CONTEXT_MAP` **L543** (Rank 4, v1.15 → **v1.16**) |
| **Creates** | `docs/00-governance/LEGAL_RISK_REGISTER.md` **v1.0** (Rank 7, mutable) — sole initial entry **`LR-01`** |
| **Supersedes** | `ADR-0133` **IN PART and IN EFFECT ONLY**, in exactly three places (§3, `D-6`). ⛔ **`ADR-0133` is byte-unchanged** |
| **Does NOT amend** | ⛔ `MP-GBR-04` · ⛔ `MP-NFR-10` · ⛔ `ATT-GAP-005` / `ATT-GAP-014` / `ATT-GAP-016` · ⛔ `AUD-GAP-001` · ⛔ blocker **7a** · ⛔ `API-GAP-001` · ⛔ any frozen PRD · ⛔ any Accepted ADR's decision text |

---

## 0. ⛔⛔ THE FOUR STATEMENTS THIS ADR DOES NOT MAKE

Read these before anything else. They are the boundary of this act.

1. ⛔ **This ADR gives NO legal opinion, contains NO legal advice, and is NOT a substitute for either.**
2. ⛔ **This ADR claims NO compliance** with the DPDP Act 2023, the DPDP Rules 2025, the SPDI Rules 2011, Article 21 of the Constitution, or any other instrument.
3. ⛔ **This ADR does NOT claim that Liboora's retention posture is legally safe, lawful, defensible, or sufficient.**
4. ⛔⛔ **This ADR does NOT decide, default, provisionally set, recommend, imply or reserve ANY retention period, TTL, purge schedule, archival rule, cron job or deletion path.**

⚠⚠ **And specifically:** ⛔ **this ADR does NOT assume, find, or assert that *"no automatic deletion"* means indefinite retention is legally permissible.** That proposition is ⛔ **UNRESOLVED**, is recorded as uncertainty **`U-11`**, and is precisely what **`LR-01`** carries forward.

---

## 1. Context

`Q-04` — *"Retention period for `StudentAttendance` after enrollment archival?"* — has been open since the Bounded Context Map v1.0.

`Accepted` [`ADR-0133`](./ADR-0133-mp-dep-07-schema-freeze-questions-q01-q03-q06-resolved-q04-remains-open-counsel.md) §5 examined it on 2026-09-10 and **deliberately left it open**, recording that **Legal counsel** was the missing authority and that the question was ⛔ *"NOT resolvable by Product or Architecture."*

⭐⭐ **That record was correct on its own terms, was not an oversight, and is NOT disturbed by this ADR.** `ADR-0133` §5.4 closes with *"Stopping here is the correct outcome, not a failure of the act"* — and it was.

**Six** governed sources plus `Accepted` `ADR-0051` name *Legal counsel*: BC Map **L543**, `MASTER_PRD` **L676**, **`MP-NFR-10`**, blocker **7a**, `ATT-GAP-005`, `AUD-GAP-001`. ⭐ **None of them is the `MP-DEP-07` gate itself.**

---

## 2. The problem this ADR solves

### 2.1 The gate's own text

`MASTER_PRD` **L574** states the dependency verbatim:

> `Resolution of open questions Q-01…Q-07`

⭐⭐⭐ **The words *"legal determination"*, *"legal opinion"* and *"counsel"* appear NOWHERE in `MP-DEP-07`.**

The counsel requirement entered governance through the **answer** earlier records reached for — a retention **period**, which is a question about what law requires — ⛔ **not through the gate**, which requires only that the question be **resolved**.

### 2.2 The named authority does not exist in this system

| Measurement | Result |
|---|---|
| *"counsel"* in [`PRD_OWNERSHIP_MODEL`](../prd-ecosystem/PRD_OWNERSHIP_MODEL.md) | ⛔ **0 occurrences** across its **nine** constituted offices (Product, Domain, Architecture, Technical, Privacy §9, Governance §10, SRE §13, EVENT platform §14, DATA/EVENT §15) |
| *"SECURITY + DATA Governance"* (`MP-NFR-10`, `MASTER_PRD` **L504**) | ⛔ Named at **Rank 1** but **constituted NOWHERE** |

⛔⛔ **The authority `ADR-0133` waited for cannot be conferred within this governance system.** A dependency waiting on a non-existent office is not *pending* — it is **permanently dead**, and would have blocked the V1 schema freeze forever.

### 2.3 The only measured gate

⭐ `MP-DEP-07` (**L574**) is the **ONLY** `MP-DEP-*` row in `MASTER_PRD` whose Gate cell reads *"Schema freeze"*. The other seven gate *Everything*, *Module implementation*, *V1 launch*, *SaaS Billing*, *Push notifications*, *Mitigation of `MP-RSK-06`*, and *Verifiability of §25*. ⭐ So discharging `MP-DEP-07` discharges the schema-freeze dependency — ⛔ **and nothing wider**.

---

## 3. Decision

| # | Decision |
|---|---|
| **`D-1`** | ⭐ **The `Q-04` question is REFRAMED, not answered.** It ceases to be *"what retention period does law require?"* — a legal question this engagement has ⛔ **no authority to answer** — and becomes *"what may Liboora's V1 product and schema safely do **while that legal question remains unresolved**?"* — a **product and data-governance** question squarely within Product Owner + Architecture Owner competence. |
| **`D-2`** | ⭐⭐ **`Q-04` is NOT "resolved" in its original form. It is SUPERSEDED IN EFFECT for `MP-DEP-07` purposes ONLY**, by the internal interim policy `RET-01`…`RET-13` (§4). ⛔ Its **legal content is NOT resolved, NOT answered, NOT closed and NOT determined.** |
| **`D-3`** | ⛔⛔ **NO RETENTION PERIOD IS DECIDED, DEFAULTED, PROVISIONALLY SET, RECOMMENDED OR IMPLIED.** `ADR-0133` §5.4's prohibition **survives this ADR in full**. The *"7 years financial / 2 years attendance"* note remains **EXPRESSLY NOT ADOPTED** — blocker **7a** reads *"**Do not adopt** '7 years financial / 2 years attendance'"* and `ATT-GAP-005` rejects it as unratified. |
| **`D-4`** | ⭐⭐ **`LR-01` is OPENED** in the new [`LEGAL_RISK_REGISTER.md`](../LEGAL_RISK_REGISTER.md) and carries the **entire** unresolved legal risk, including `U-1`…`U-13`. ⭐ `Q-04`'s legal content is **TRANSFERRED, NOT EXTINGUISHED**. |
| **`D-5`** | **`MP-DEP-07` is DISCHARGED** once `RET-01`…`RET-13` are adopted and `LR-01` is open — because the gate's text requires resolution of the **question**, and the question **as reframed by `D-1`** is resolved. |
| **`D-6`** | ⛔ **`ADR-0133` is superseded IN PART and IN EFFECT ONLY, in exactly three places, and in NO other** — see §3.1. |
| **`D-7`** | ⛔ **Authority conferred: Product Owner + Architecture Owner. Legal Counsel is EXPRESSLY NOT REQUIRED — because NO legal determination is made.** ⭐ This is **not** a workaround of the counsel requirement; it is a decision of a **different question** that does not engage it. |

### 3.1 ⛔ `D-6` — the exact supersession scope

⛔ **`ADR-0133` is superseded IN PART and IN EFFECT ONLY, in exactly these three places:**

**(a) `ADR-0133` §5.4 — the *"Required authority"* row**, which reads:

> `| **Required authority** | **Legal counsel** + **Architecture Owner** (per `MP-NFR-10`: **SECURITY + DATA Governance**) |`

⭐ Superseded **as to the Legal-counsel limb ONLY**. ⭐⭐ **The Architecture-Owner limb STANDS, unamended and authoritative.**

**(b) `ADR-0133` §6.1 — exactly two current-state rows**, which read:

> `| \`Q-04\` | ⛔ Open | ⛔⛔ **STILL OPEN — counsel required** |`
> `| **\`MP-DEP-07\`** | *"partially resolved (\`Q-02\`, \`Q-07\` settled)"* | ⭐ **"6 of 7 resolved; \`Q-04\` alone OPEN"** |`

⭐ Superseded **as statements of CURRENT STATE ONLY**. ⭐⭐ They remain **TRUE as of 2026-09-10** and **TRUE as history**. ⛔ The *Before* column is untouched.

**(c) `ADR-0133` §6.2 — the heading and its current-state schema-freeze statement concerning `Q-04`**, which read:

> `### 6.2 ⛔⛔ Schema freeze: STILL BLOCKED`
> *"`Q-04` is open, so `MP-DEP-07` is not discharged, and schema freeze remains blocked."*

⭐ Superseded **as statements of CURRENT STATE ONLY**.

### 3.2 ⭐ What in `ADR-0133` STANDS — authoritative and unamended

- ✅ **§5.2** — the six-source table naming Legal counsel
- ✅ **§5.3** — the named trap
- ✅ **§5.4's prohibition paragraph** — *"⛔ No retention period is decided, defaulted, provisionally set, recommended or implied. ⛔ No TTL, purge schedule, archival rule or deletion path is created."*
- ✅ **§5.4's Architecture-Owner limb** and its *"Conferred here"*, *"Dependent gaps"* and *"Consequence"* rows
- ✅ **§6.1's *Before* column** and its five other rows (`Q-01`, `Q-02`, `Q-03`, `Q-05`, `Q-06`, `Q-07`)
- ✅ **§6.2's** *"⛔ This ADR designs no schema, no table, no column, no index, no migration and no SQL"*
- ✅ **§7** in its entirety

⭐⭐ **`ADR-0133` §6.2's reasoning was CORRECT ON ITS PREMISE.** It held schema freeze blocked *because `Q-04` was open*. ⭐ `ADR-0137` does **not** contradict that reasoning — it **changes the premise** by reframing the question.

### 3.3 ⛔ `ADR-0133` immutability

⛔ **No byte of `ADR-0133` is edited** — `ADR-INDEX` **L206**: *"Never reuse a number. Never edit an Accepted ADR's decision text — supersede it with a new ADR."*

⭐ **Required blob, verified before and after this act: `de29b3d8f543cc11cf1dd3a62656d358a974f929`.**

---

## 4. The adopted internal interim product policy — `RET-01`…`RET-13`

⚠⚠ **STATUS OF THIS POLICY, STATED ONCE AND BINDING ON EVERY ROW BELOW: this is an INTERNAL INTERIM PRODUCT POLICY PENDING `LR-01` REVIEW.** ⛔ It is **NOT** a legal position, ⛔ **NOT** a compliance measure, ⛔ **NOT** claimed lawful, safe or sufficient, and ⛔ **NOT** a retention period.

| ID | Rule | Rationale — **product / engineering ONLY** | ⛔ What it is NOT |
|---|---|---|---|
| **`RET-01`** | ⛔ **NO fixed retention period is adopted, defaulted, provisionally set or recommended** — for attendance, financial history, biometric-adjacent data or register images. | `ADR-0133` §5.4's prohibition survives in full. ⛔ No authorised office exists to set one. | ⛔ **NOT** a finding that no period is required. `U-1`/`U-2` unresolved. |
| **`RET-02`** | ⛔ **NO hard-coded TTL, expiry constant, purge schedule, cron job or scheduled deletion** anywhere in `lib/`, migrations, or backend configuration. | A TTL in code **IS** a retention decision, made by the wrong office and invisible to governance. | ⛔ **NOT** a claim that TTLs are unlawful. |
| **`RET-03`** | ⛔ **NO automatic deletion IN APPLICATION CODE OR CONFIGURATION.** Data is removed **only** by an explicit, logged, human-initiated action. ⚠⚠ **See `RET-13` — managed-infrastructure backup/PITR expiry is OUT OF SCOPE of this rule and is NOT resolved.** | ⚠⚠ **An interim choice between two exposures, NOT an absence of exposure.** Deleting data that law may require retained is **irreversible**; retaining it is **reversible**. Reversibility is the **only** ground. | ⛔⛔ **NOT a finding that indefinite retention is legally permissible** — `U-11`. ⛔ **Must NEVER be cited as legal cover.** ⛔ **NOT** a claim that no deletion occurs anywhere in the system — see `RET-13`. |
| **`RET-04`** | ⭐ **Retention *capability* is built; NO retention *period* is committed.** Schema and code must make period-based retention **implementable later without migration** — via `RET-05`/`RET-06` — but must ship with ⛔ **no period configured**. | Lets the schema freeze proceed while leaving the legal question **genuinely open**. ⭐ This rule is what makes the freeze legitimate rather than premature. | ⛔ **NOT** a reserved or implied default. An unconfigured capability is **not** a decision. |
| **`RET-05`** | ⭐ **`purposeCeasedAt` — NULLABLE timestamp, DEFAULT NULL**, on the aggregates holding attendance and financial history. Set **only** when a purpose is affirmatively determined to have ceased. ⛔ NULL carries **no** meaning beyond *"not determined"*. | If a purpose-cessation rule is later held to apply, the field that rule needs already exists. Adding it post-freeze would be a migration. | ⛔ **NOT** an assertion that purpose-cessation erasure applies (`U-1`). ⛔ NULL ≠ *"purpose subsists"*. ⛔ See **`RET-12`** — no duration may be computed from it. |
| **`RET-06`** | ⭐ **`retentionBasis` — nullable reference to a governance record** (ADR id / statutory citation), DEFAULT NULL. ⛔ **NULL is the CORRECT and EXPECTED V1 value** and must be **readable as *"no basis recorded"***. | Makes the **absence** of a legal basis **visible in data** instead of hidden in prose. | ⚠⚠ Populating it does ⛔ **NOT** create a legal basis. ⛔ It must **NEVER** be back-filled with an invented citation. ⛔ See **`RET-12`**. |
| **`RET-07`** | ⭐ **Erasure-request capability exists from V1**: a Data-Principal erasure request can be **received, logged, tracked and acted on**, with an audit trail, internal target response **90 days**. ⛔ The *outcome* of any request is a case-by-case decision, ⛔ **NOT** pre-determined by this policy. ⚠⚠ **The 90-day figure is an INTERNAL SERVICE-RESPONSE TARGET chosen for operational planning. ⛔ It is NOT a retention period, NOT a deletion deadline, NOT a statutory period, and is NOT derived from any provision of the DPDP Act 2023, the DPDP Rules 2025 or any other instrument.** | The capability is needed **whichever way `U-3` resolves**. Building it is cheap; retrofitting it under a commenced statute is not. | ⛔ **NOT** an assertion that §12 applies, nor that 90 days is a legal deadline. |
| **`RET-08`** | ⭐ **Attendance and financial records SEPARATED** — distinct aggregates, distinct stores, distinct access paths, ⛔ **no shared deletion path, no cascade**. | If the two ever attract different treatment, they must be **separately actionable**. A cascade would make that impossible without a migration. | ⛔ **NOT** a claim they attract different obligations (unknown). |
| **`RET-09`** | ⭐⭐ **Pseudonymisation is a SECURITY control ONLY.** ⛔ It must **NEVER** be described, documented or relied on as satisfying erasure, anonymisation, minimisation or any retention obligation. ⚠ `MP-GBR-04`'s *"retained under legal basis and pseudonymised"* clause remains ⛔ **UNSUPPORTED** — **flagged here, ⛔ NOT amended by this act**. | `U-10` is unresolved. Treating a security control as a legal one is exactly the category error `ADR-0133` §5.3 named. | ⛔ **NOT** a finding that pseudonymised data falls outside scope. |
| **`RET-10`** | ⭐ **Child-data minimisation at capture**: collect the **minimum** for the specified purpose; ⛔ **NO behavioural profiling, NO targeted advertising, NO attendance-derived behavioural analytics** on any user recorded as, or plausibly, under 18. | Narrows exposure under `U-4`/`U-5` **regardless of how they resolve**. Cheapest at capture, most expensive retrofitted. | ⛔ **NOT** an assertion that §9 applies, nor that these measures satisfy it. |
| **`RET-11`** | ⭐ **Multi-student register images RESTRICTED**: no general-purpose retention; access limited to the narrowest role set; ⛔ **not** exported, shared, bulk-downloaded, or used for training/analytics; each image treated as containing **multiple** data principals. | One image can expose many principals, including minors. The blast radius per record is the highest in the system. `ATT-GAP-016` is open. | ⛔ **NOT** a claim the restriction is sufficient (`U-7`). |
| ⭐⭐ **`RET-12`** | ⛔⛔ **NO V1 code, query, view, report, migration, scheduled job, configuration, or other executable logic may compute duration, age, deadline, expiry, eligibility, purge timing, deletion timing, or archive timing from `purposeCeasedAt`, `retentionBasis`, or record timestamps, for retention / deletion / archive / purge purposes.** ⭐ These fields are **facts / metadata ONLY**. ⭐⭐ **The FIRST implementation of any such duration or eligibility computation would constitute ADOPTION OF A RETENTION / DELETION RULE and requires a NEW governance ADR BEFORE implementation.** | ⭐ Engineering guard. Without it, the first engineer to write `now() - purposeCeasedAt > X` silently sets a retention period **outside governance**. Any such proposal fires **`T-10`**. | ⛔ **NOT** a legal position. ⛔ **NOT** a claim that such computation would be unlawful — only that it would be **ungoverned**. |
| ⭐⭐ **`RET-13`** | ⚠⚠ **DISCLOSED, NOT RESOLVED.** The V1 backend runtime is a **managed BaaS (Supabase)** — [`ADR-0116`](./ADR-0116-v1-backend-runtime-supabase.md) (`BC-30` Offline Sync) and [`ADR-0124`](./ADR-0124-v1-authentication-backend-runtime-baas.md) (authentication). ⚠ Managed BaaS backup / point-in-time-recovery (PITR) data **may auto-expire on a VENDOR-SET schedule that Liboora has NOT chosen, reviewed or ratified.** ⛔ **Liboora's application cannot bind vendor infrastructure to an internal retention rule**, so `RET-02` and `RET-03` — which bind Liboora's own code and configuration — do **not** and **cannot** reach it. ⭐ This may therefore be a **de-facto infrastructure retention boundary**. ⛔ It is **NOT adopted as Liboora's retention period**, ⛔ **NOT endorsed as lawful**, ⛔ **NOT a product retention decision**. ⭐⭐ **Its actual configured window MUST BE MEASURED at the first `LR-01` review** and is recorded as uncertainty **`U-13`**. ⛔⛔ **Until that window is measured, NO unqualified global statement such as *"there is no automatic deletion anywhere"* may be made in any Liboora document.** | ⭐ Honesty guard. Every prior draft asserted *"no automatic deletion"* as though Liboora controlled all deletion. **It does not.** | ⚠⚠ **MEASURED DISCLOSURE — `ADR-0116` and `ADR-0124` are cited ONLY as establishing the managed-BaaS runtime. ⛔ NEITHER ADR governs, references, ratifies or mentions any backup, PITR or expiry schedule** — `ADR-0124` contains **0** such occurrences and `ADR-0116` mentions retention only to say *"**no** retention period"*. ⛔⛔ **NO governed Liboora document addresses backup/PITR expiry at all.** That makes the gap **wider**, not narrower. |

---

## 5. ⛔ What this ADR expressly does NOT do

- ⛔ Does **not** give, contain, rely on, or substitute for a **legal opinion** or legal advice
- ⛔ Does **not** claim **compliance** with the DPDP Act 2023, the DPDP Rules 2025, the SPDI Rules 2011, Article 21, or any other instrument
- ⛔ Does **not** claim the policy is **legally safe**, **lawful**, **defensible**, or **sufficient**
- ⛔ Does **not** invent, imply, or reserve a retention **period**, **TTL**, **purge schedule**, **cron job** or **deletion deadline**
- ⛔ Does **not** resolve **any** of the thirteen preserved uncertainties `U-1`…`U-13` (§6)
- ⛔ Does **not** assume that *"no automatic deletion"* means **indefinite retention is legally permissible** — `U-11`
- ⛔ Does **not** assert that no automatic deletion occurs **anywhere in the system** — `RET-13`
- ⛔ Does **not** amend `MP-GBR-04`, `MP-NFR-10`, `ATT-GAP-005`, `ATT-GAP-014`, `ATT-GAP-016`, or `AUD-GAP-001`
- ⛔ Does **not** amend, close, or re-status blocker **7a** — ⭐ **7a remains OPEN and UNAMENDED**; its text *"no authoritative retention number"* remains **TRUE** and its *"Do not adopt"* instruction remains **BINDING**
- ⛔ Does **not** constitute **Legal Counsel** as an office
- ⛔ Does **not** constitute the *"SECURITY + DATA Governance"* office
- ⛔ Does **not** mint any permission — `AUTH-7.22`'s catalogue stays closed with **0** enumerated permissions (`ADR-0132`)
- ⛔ Does **not** create, rename or re-rank any role or office
- ⛔ Does **not** alter `API-GAP-001` / `SX-02`, and ⛔ **does NOT unblock Stage 6A** (§8.2)
- ⛔ Does **not** design a schema, table, column, index, migration or SQL
- ⛔ Does **not** add, remove or alter any bounded context, edge, aggregate, event or invariant
- ⛔ Changes **no** file under `lib/`, `test/`, `tool/`, `packages/`, `android/`, `web/`; ⛔ `pubspec.yaml` unchanged
- ⛔ Confers **no** lifecycle stage

---

## 6. ⛔ Preserved uncertainties — carried to `LR-01`, NOT resolved

| # | Uncertainty | Status |
|---|---|---|
| `U-1` | Whether DPDP §8(7) purpose-cessation erasure reaches `StudentAttendance` | ⛔ **UNRESOLVED** |
| `U-2` | Whether DPDP Rule 8(3)'s one-year floor is a general floor (Construction 1), Seventh-Schedule-limited (Construction 2), or hybrid (Construction 3) | ⛔ **UNRESOLVED** — three live constructions, none authoritative |
| `U-3` | Whether §12(3)'s *"necessary for the specified purpose"* limb permits refusal of a student erasure request | ⛔ **UNRESOLVED** |
| `U-4` | Whether §9 verifiable-parental-consent duties attach to Liboora's under-18 users | ⛔ **UNRESOLVED** |
| `U-5` | Whether §9(3)'s behavioural-monitoring prohibition reaches attendance analytics | ⛔ **UNRESOLVED** |
| `U-6` | Whether SPDI Rules 2011 r.5(4) governs attendance at all — r.3 is a **CLOSED list of 8** categories and ordinary attendance appears to fall within none | ⛔ **UNRESOLVED** — prospect materially reduced, **not eliminated** |
| `U-7` | Whether *Puttaswamy* ¶205 (⚠ in **A.K. SIKRI, J.**'s opinion) constrains multi-year archival of minors' records in a private context | ⛔ **UNRESOLVED** |
| `U-8` | Whether the §40(2)(z) residual rule-making power cures a Rule 8(3) *ultra vires* argument | ⛔ **UNRESOLVED** — ⚠ this is the counter-argument **AGAINST** Liboora's convenient reading |
| `U-9` | Whether any state education, tax, or record-keeping statute imposes an independent retention floor | ⛔ **NOT RESEARCHED** |
| `U-10` | Whether pseudonymisation under `MP-GBR-04` has any legal effect on retention obligations | ⛔ **UNRESOLVED** — treated as **security only** (`RET-09`) |
| ⭐⭐ `U-11` | Whether *"no automatic deletion"* is itself lawful as an interim posture — i.e. whether **indefinite retention is permissible at all** | ⛔⛔ **UNRESOLVED — THE CENTRAL RESIDUAL RISK** |
| `U-12` | Whether Liboora will be notified a Significant Data Fiduciary (§10) | ⛔ **UNRESOLVED** |
| ⭐⭐ `U-13` | Whether managed-BaaS backup / PITR expiry constitutes retention-relevant deletion — **and what the actual configured window IS** | ⛔⛔ **NOT MEASURED, NOT RATIFIED.** ⚠ **No governed Liboora document addresses backup/PITR expiry at all** (`RET-13`) |

⚠⚠ **Every reading behind this table was produced by an AI research assistant. ⛔ It is NOT legal advice, has NOT been reviewed by any qualified Indian advocate, and MUST NOT be relied on as a determination.** ⚠ Two primary sources were read via third-party mirrors (G.S.R. 843(E) via `dpdpa.com`; SPDI Rules 2011 via `dataguidance.com`) and **require confirmation against the e-Gazette**.

---

## 7. ⚠ Honest costs — recorded, not minimised

1. ⚠⚠ **The legal risk is UNCHANGED by this ADR.** It is **relocated** from a blocking question into a tracked open item. ⛔ **Relocation is not reduction.**
2. ⚠⚠ **`RET-01`…`RET-13` are the LESSER OF TWO RISKS, not the absence of risk.** Deleting data that law requires retained, and retaining data that law requires deleted, are **both** exposures. This policy picks one. ⛔ It does **not** escape the choice.
3. ⚠⚠ **The DPDP commencement timing is a HARD DEADLINE, not a horizon.** **G.S.R. 843(E)** clause (c) brings §§3–5, §6(1)–(8)&(10), **§§7–10**, **§§11–17**, §§28–34, 36, 37 and §44(2) into force **eighteen months from 13 November 2025 — approximately 13 May 2027**. ⚠ **This is a legal COMMENCEMENT date ONLY. ⛔ It is NOT a retention period and must never be read as one.** `LR-01` must be closed **before** then, or Liboora operates under a commenced statute with **no determination**.
4. ⚠ **`RET-13` discloses a boundary Liboora does not control.** The managed backend may already expire backups on an unmeasured schedule. ⛔ That is **not** a decision anyone in this governance system made.

---

## 8. Consequences

### 8.1 ⭐ `MP-DEP-07` and the V1 schema freeze

⭐ **`MP-DEP-07` is DISCHARGED, and the V1 schema freeze is UNBLOCKED — ON THIS DEPENDENCY ONLY.**

`MASTER_PRD` L574 requires *"all seven"*. `ADR-0133` resolved `Q-01`, `Q-03`, `Q-06`; `Q-02`, `Q-05`, `Q-07` were already settled or closed; ⭐ **`Q-04` was the sole remaining obstruction**, and `D-1`…`D-5` discharge it.

⚠ **What the freeze does and does not mean:**
- ⭐ It covers a schema that **can** implement period-based retention later (`RET-04`/`RET-05`/`RET-06`) **without migration**
- ⛔ It contains **no** TTL, **no** purge schedule, **no** cron, **no** deletion path, **no** period
- ⛔ Freezing the schema does **NOT** freeze the legal question — **`LR-01` remains OPEN across the freeze**
- ⚠ If `LR-01` later resolves requiring a period, **no schema migration should be needed** — only configuration of fields `RET-05`/`RET-06` already provide. ⛔ That is an **engineering expectation**, **not** a guarantee, and **not** a legal position.

### 8.2 ⛔⛔ Stage 6A is NOT unblocked

| Blocker | Status after this ADR |
|---|---|
| `Q-04` / `MP-DEP-07` / schema freeze | ⭐ **DISCHARGED** (§8.1) |
| ⛔⛔ **`API-GAP-001` / `SX-02`** (`ADR-0135`) | ⛔⛔ **STILL OPEN — WHOLLY UNAFFECTED AND UNALTERED by this ADR** |
| `ATT-GAP-005`, `ATT-GAP-014`, `ATT-GAP-016`, `AUD-GAP-001` | ⛔ **STILL OPEN and UNAMENDED** |
| Blocker **7a** | ⭐ **OPEN and UNAMENDED** — ⛔ **NOT closed, NOT re-statused** |
| `MP-GBR-04` *"retained under legal basis"* | ⛔ **UNSUPPORTED** — flagged by `RET-09`, ⛔ **NOT amended** |
| `MP-NFR-10` *"SECURITY + DATA Governance"* | ⛔ **STILL CONSTITUTED NOWHERE** |

⭐ **The precise consequence:** this ADR reduces Stage 6A's blocker set from **two independent families** — (i) the *permanently unresolvable* `Q-04` retention authority, and (ii) the *ordinarily resolvable* `API-GAP-001`/`SX-02` — down to **one**. ⭐⭐ **Stage 6A moves from *structurally impossible* to *merely blocked*.** ⛔ **But Stage 6A REMAINS BLOCKED**, and `API-GAP-001`/`SX-02` must be dispositioned by its **own** ADR, independently. ⛔ Nothing here anticipates or prejudges that act.

---

## 9. Citation-cost measurement

| File | Rank | Change | Citations shifted |
|---|---|---|---|
| `MASTER_PRD` | **1** | **L574** + **L676** replaced **strictly in place**; changelog row **inserted** above the `v1.10` row | ⭐ **0** — table gains no row at L574/L676; **0** `#L` anchors exist file-wide |
| BC Map | **4** | **L543** replaced **strictly in place**; v1.16 entry **APPENDED as §22** | ⭐ **0** — ⛔ an insert at L613 would shift **ten**, incl. **L1108 cited by `Accepted` `ADR-0129` L79**, which `ADR-INDEX` **L206** forbids editing |
| `ADR-INDEX` | — | `ADR-0137` registered as an **EOF addendum section** (the `ADR-0115`…`ADR-0136` pattern); L9 Count edited in place | ⭐ **0** |
| `DOCUMENTATION_BASELINE` | — | L5 identifier, L10 Authority, §3.1/§3.2 inventory Version cells, new `LEGAL_RISK_REGISTER` row, §8 changelog row | ⭐ **0** |
| `IMPLEMENTATION_BLOCKER_REGISTER` | 7 | ⛔ **EOF cross-reference ONLY** — blocker **7a** byte-unchanged | ⭐ **0** |
| `LEGAL_RISK_REGISTER` | 7 | **NEW FILE** | ⭐ **0** |

---

## 10. ⚠ The interpretive premise, disclosed

⚠⚠ **This ADR rests on one reading of Rank 1 text: that `MP-DEP-07`'s *"Resolution of open questions"* does not import a legal-determination requirement.**

⭐ The supporting measurement is objective — the words *"legal determination"*, *"legal opinion"* and *"counsel"* are **absent** from `MP-DEP-07`, and the authority earlier records named is **constituted nowhere**.

⚠ **But the inference from that measurement is an interpretation**, and it was produced by the same agent that authored the `ADR-0133` §5 STOP record it now narrows. ⛔ **No audit performed by that agent can validate the premise, because every such audit inherits it.**

⭐ **This is recorded so that a future reader — or a future advocate reading `LR-01` — can locate and challenge the single load-bearing inference in this act.**

---

## 11. Changelog

| Version | Date | Change |
|---|---|---|
| **1.0** | 2026-09-11 | ⭐⭐ **Created and `Accepted`. `Q-04` REFRAMED from a legal question to an internal data-governance question; `MP-DEP-07` DISCHARGED; the V1 schema freeze UNBLOCKED on that dependency; and the unresolved legal risk OPENED as `LR-01`** with uncertainties `U-1`…`U-13` preserved and interim policy `RET-01`…`RET-13` adopted. ⛔ **No legal opinion. No compliance claim. No retention period, TTL, purge schedule, cron or deletion deadline. No legal uncertainty resolved. No office constituted. No permission minted. `ADR-0133` byte-unchanged. Blocker 7a OPEN and UNAMENDED. `API-GAP-001`/`SX-02` unaltered and Stage 6A still BLOCKED.** |

---

*End of `ADR-0137`. ⭐ **Accepted** — reframes a question; ⛔ **answers no legal question, adopts no retention period, and claims no compliance.** ⚠ The unresolved legal risk lives in [`LR-01`](../LEGAL_RISK_REGISTER.md), permanently open.*
