# `TS-002` — `PRD-021C` Library Marketplace: composition-layer Technical Specification

| Field | Value |
|---|---|
| **Document** | `TS-002` |
| **Version** | **v0.1** |
| **Date** | 2026-09-11 |
| **Status** | ⛔ **`DRAFT`** — ⛔⛔ **NOT approved, NOT frozen, NOT authoritative.** ⭐ *"Becomes a **governed document** only when an **Accepted ADR** admits it"* (`PRD_LIFECYCLE.md` §7A.8). ⛔ **This document does NOT claim its own status** (`ADR-0131` §8.2 **`P-7`**) |
| **Class** | Technical Specification — constituted by `Accepted` [`ADR-0131`](../../00-governance/adr/ADR-0131-constitute-technical-specification-governance.md) |
| **Lifecycle stage** | **`6A`** — `PRD_LIFECYCLE.md` §7A. ⛔ The subject PRD's registry status remains **`APPROVED`** (§7A.2); ⛔ **no new status is created** |
| **Rank** | ⛔⛔ **UNRANKED.** `PRD_LIFECYCLE.md` **§7A.7**: *"An admitted Technical Specification is **governed but UNRANKED** … in any disagreement **the ranked document wins by default**"* (`TSG-GAP-004`, **OPEN**, Architecture Owner). ⛔ **No Rank 8 and no other rank is invented** |
| **Subject** | `PRD-021C` Library Marketplace — **Part C8**, Technical & Production Architecture (the composition layer for C1–C7) |
| **Requirement identifier stem** | ⭐ **`LMC`** — declared here per `ADR-0131` §5.2; collision-measured **0** in four directions (§2.2) |
| **Requirement identifier form** | `TS-002-LMC-<nnn>` — `ADR-0131` §5.2 |
| **⭐⭐ Authorising conferral** | ⭐⭐ **`Accepted` [`ADR-0142`](../../00-governance/adr/ADR-0142-prd-021c-c8-nominated-next-stage-6a-subject-tsg-gap-003-c8-limb-disposed-ts-002-authorised.md)** — see §1 |
| **⛔ Offices** | ⛔⛔ **NO OFFICE IS RECORDED AS OCCUPIED.** §1 records which office is **required** and by which **conferral** it was exercised — `PRD_LIFECYCLE.md` §7A.6 |
| **⛔ Does NOT amend** | ⛔ **C8's source document** · ⛔ **A8** · ⛔ **B9** · ⛔ **`TS-001`** · ⛔ `ADR-0131` / `0135` / `0140` / `0141` / `0142` / `0098` · ⛔ `PRD_LIFECYCLE` · ⛔ `TRACEABILITY_MATRIX` · ⛔ `MASTER_PRD` · ⛔ BC Map · ⛔ the Enterprise Architecture · ⛔ `ADR-INDEX` · ⛔ `DOCUMENTATION_BASELINE` |

---

## 1. ⭐⭐ Authority — which office is required, and by which conferral it was exercised

`PRD_LIFECYCLE.md` §7A.6 is explicit, and is obeyed literally here:

> ⛔⛔ **"All offices are VACANT as constituted, and `ADR-0131` fills none of them."** Every `6A` act proceeds under the **one-act-conferral** model, and the offices ⛔ **revert on completion** (`ADR-0033` §7.1). ⛔ A Technical Specification **MUST NOT record an office as occupied** — it records which office is **required** and by which **conferral** it was exercised.

| Office | Role at Stage `6A` (§7A.6) | Required | Conferral by which it was exercised |
|---|---|---|---|
| **Technical Owner** | *"Authors and attests"* | ⭐ **YES** | ⭐ **`ADR-0142`** `D-5` (§6) |
| **Architecture Owner** | *"Approves — boundaries, edges and Rank 4 conformance"* — ⛔ *"Only the Architecture Owner approves"* | ⭐ **YES** | ⭐ **`ADR-0142`** `D-5` (§6) |
| **Product Owner** | *"Attests that no product requirement was invented or altered"* | ⭐ **YES** | ⭐ **`ADR-0142`** `D-5` (§6) |
| **Domain Owner** | *"Reviews ubiquitous language and invariants"* | ⭐ **YES** | ⭐ **`ADR-0142`** `D-5` (§6) |

⛔⛔ **THE CONFERRAL EXPIRES AUTOMATICALLY ON COMPLETION OF THIS ACT.** `ADR-0142` §6.1: *"Expires **AUTOMATICALLY** on completion of that act"*, ⛔ *"**NOT** standing authority"* — *"A conferral for one act is not a standing licence"* (`ADR-0033` §7.1). ⛔ **No office is claimed to be occupied by anyone.** ⛔ **No office is constituted, filled or made permanent.** ⛔ **No personal name appears** (`PRD_OWNERSHIP_MODEL` §8.3 rule 4).

⭐ **`ADR-0142` `D-13` limits this authorisation to ONE document:** *"It authorises **`TS-002` for C8 and nothing further**"* — ⛔ no `TS-003`, ⛔ no third subject, ⛔ no downstream stage, ⛔ no implementation.

⚠ **All four offices are exercised by a single human principal.** That is this repository's established pattern (`ADR-0033` §7.1, `ADR-0092`, `ADR-0135`, `ADR-0140`, `ADR-0142`), ⛔ **but it is NOT four independent reviews, and no such independence is claimed** (`ADR-0142` §6.2).

---

## 2. Scope, the entry gates, and the identifier stem

### 2.1 ⛔ Scope — the C8 composition layer only

This specification addresses **`PRD-021C` Part C8** and ⛔ **nothing else**. ⛔ It does **not** address `PRD-021A` A8, whose `TSG-GAP-003` limb **REMAINS OPEN** (`ADR-0142` `D-11`); ⛔ it does **not** re-open `PRD-021B` B9 or `TS-001`; ⛔ it does **not** address C1–C7 as product parts.

⛔⛔ **It specifies nothing for C5.** C8 `LMT-FR-001` is express: *"⛔ C8 **MUST NOT** specify runtime architecture for **C5**"* — C5 authored no capability, so *"there is nothing to host, store, index, cache, audit or scale"*. ⭐ **This specification obeys that limit and adds no C5 surface.**

### 2.2 ⭐ The stem `LMC` — measured free in four directions

⛔⛔ **A global count is not a valid verification** (`ADR-0138` §3.4; `ADR-0140` `D-7`). The stem is therefore tested **by location and context**, in four independent directions:

| # | Direction | Method | Result |
|---|---|---|---|
| 1 | Bare token anywhere in governed docs | `grep -rIoE '\bLMC\b' docs/` | ⭐ **0** |
| 2 | Used as an identifier prefix | `grep -rIoE '\bLMC-[0-9]{3}\b' docs/` | ⭐ **0** |
| 3 | Any filename | `find docs -name '*LMC*'` | ⭐ **0** |
| 4 | Code and tooling | `grep -rIoE '\bLMC\b' lib tool` | ⭐ **0** |

⭐ **`LMC` = Library Marketplace Composition**, naming C8's own subject — *"the Composition Layer for C1–C7"*.

⛔⛔ **`LMT-*` IS NOT REUSED, EXTENDED OR REINTERPRETED.** `ADR-0131` §5.3: *"**`LMT-*`** — `PRD-021C` **C8** — ⛔ **MUST NOT be reused**"*. ⛔ Nor are `LTS-*`, `LCTS-*`, `TPA-*`, `MSG-*`, `SGT-*`, `IMPL-*` or `PERM-*`.

⚠⚠ **A MEASUREMENT DISCREPANCY IN `ADR-0142` §3.4 IS RECORDED, NOT SMOOTHED.** `ADR-0142` §3.4 tabulates C8's families as *"Occurrences in C8"* — `LMT-FR` **61**, `LMT-XC` **53**, `LMT-AC` **39**, `LMT-BR` **27**. Re-measured in C8 at this commit the **raw occurrence** figures are **64 / 55 / 41 / 29**, and the **distinct register sizes** are **26 / 20 / 16 / 12 = 74 identifiers**, each contiguous from `001`, exactly as C8 **§1** declares. ⭐ Two different quantities were being counted; the register sizes are the governed ones. ⛔ **`ADR-0142` is NOT amended** (`ADR-INDEX` **L207**: *"An ADR supersedes; it does not delete"*) and ⛔ **C8 is NOT edited** — the discrepancy is **disclosed here** and ⭐ **it changes nothing operative**, because the operative rule is that `LMT-*` is C8's and is not reused, which holds on every figure. **Owner of any correction: Architecture Owner.**

### 2.3 ⭐ `E-1` … `E-4` — re-measured FOR C8, at this commit

⛔ `ADR-0142` §9 forbids relying on that ADR's own §3.3 measurements. Each gate is therefore re-measured here:

| # | Criterion (§7A.4) | Measurement at this commit | Verdict |
|---|---|---|---|
| **`E-1`** | *"frozen or baseline-authoritative — a §3 row, or an Accepted ADR admitting it"* | `Accepted` [`ADR-0098`](../../00-governance/adr/ADR-0098-prd-021c-c0-c8-library-marketplace-rank-3-baseline.md) — Status cell reads **`Accepted` — 2026-09-03**; admits `PRD-021C` **C0–C8** at **Rank 3**; C8 named **20** times | ⭐ **PASS** |
| **`E-2`** | *"**Stage 3** (Architecture Review) has **passed** for the subject"* | `PRD-021C_C0_C8_STAGE3_ARCHITECTURE_ALIGNMENT.md` — verdict **PASS 6/6**, *"`DRAFT` / `STAGE 2` → **`ALIGNED` / `STAGE 3`**"*, C8 cited **42×**; expressly *"with **6 OPEN** owner decisions and **2 inherited gaps**, **none of which fails a Stage-3 check**"* | ⭐ **PASS** |
| **`E-3`** | *"Every Accepted ADR governing the subject is **identified and cited**"* | Discharged **inside this document** — §9's traceability chain cites the governing ADR for every section | ⭐ **PASS** |
| **`E-4`** | *"Every governed decision … **exists** — or the dependency is **recorded as a gap with a named owning office**"* | ⭐ Satisfied **on its second, disjunctive limb**. Every dependency this document could not resolve is in §8's register **with an existing named owning office** — including `API-GAP-001` (*"Product Owner + Architecture Owner"*, `ADR-0135` **L194**–**L196**), `TSF-GAP-009`, `GAP-BCMAP-BC26-EDGES` and the six `XPC-OD-*`. ⚠ `E-4` requires the office **NAMED**, ⛔ **not OCCUPIED** | ⭐ **PASS** |

⚠⚠ **A CONTRADICTION IN THE SUBJECT'S OWN HEADER IS DISCLOSED, NOT REPAIRED.** C8's header reads *"DRAFT — Stage 2 (authored). Stage 3 NOT entered"*, while the consolidated C0–C8 record **confers** `ALIGNED / STAGE 3`. ⭐ **The conferral governs, and `E-2` is taken from the conferral record — not from the subject header.** ⛔ **C8 is NOT edited** — `PRD_LIFECYCLE.md` **L177**: documents are *"never silently modified. **Not for an obvious correction, and not for one that is certainly right**"*. **Owner of any repair: Product Owner** (C8's document owner), ⛔ **not this act**.

### 2.4 ⭐ C8 is PRECEDENT AND INPUT — not converted

⛔⛔ **C8 is NOT converted, re-expressed, rewritten, renamed, re-identified, restatused or moved** by this document. `ADR-0142` `D-2` disposed the C8 limb of `TSG-GAP-003` **in the negative**: C8 *"remains a Rank-3 part at its own identifier and version"*, serving ⭐ **as cited input and structural precedent** (`ADR-0131` §6.1).

⭐ **C8 remains byte-unchanged at blob `7fc70327f83310148db964f6c3e937257aa14357`**, `DRAFT v0.1`, **778 lines**, Rank 3.

⛔ **`TSG-GAP-003` REMAINS OPEN**, because the **A8 limb** is outstanding (`ADR-0142` `D-11`). ⛔ **Nothing in this document closes it, and nothing here brings A8's disposition closer.**

---

## 3. ⛔⛔ `X-4` — the prohibitions, affirmed INDIVIDUALLY

⭐ `ADR-0142` `D-9` is explicit that it *"does not discharge that duty on the author's behalf"*. Each prohibition is therefore affirmed **one by one**.

### 3.1 `ADR-0131` §3.3 — the five

| # | Prohibition | Affirmation by this document |
|---|---|---|
| 1 | ⛔ **MUST NOT invent a product requirement** | ⭐ **AFFIRMED** — every requirement below restates or composes an **existing** C8/BC Map/ADR rule; ⛔ **0** new product requirements |
| 2 | ⛔ **MUST NOT invent an architecture boundary** | ⭐ **AFFIRMED** — ⛔ **0** bounded contexts, **0** edges; the set **remains 29** and `E-31` is ⛔ **NOT minted** |
| 3 | ⛔ **MUST NOT invent a permission** | ⭐ **AFFIRMED** — ⛔ **ZERO** permission identifiers; ⛔ **no `PERM-*`** (`AUTH-7.22` **CLOSED at 0**) |
| 4 | ⛔ **MUST NOT change a frozen record** | ⭐ **AFFIRMED** — ⛔ **0** Rank 1–5 documents amended; C8, A8, B9, `TS-001`, `MASTER_PRD`, BC Map, `PRD_LIFECYCLE` and `TRACEABILITY_MATRIX` all **byte-unchanged** |
| 5 | ⛔ **MUST NOT resolve a governed gap** | ⭐ **AFFIRMED** — §8 closes ⛔ **NONE**; `TSG-GAP-003` stays **OPEN** |

### 3.2 `ADR-0131` §8.2 — `P-1` … `P-8`, each individually

| # | Prohibition | Affirmation |
|---|---|---|
| **`P-1`** | ⛔ No product requirement invented or altered | ⭐ **AFFIRMED** |
| **`P-2`** | ⛔ No permission, role or scope defined | ⭐ **AFFIRMED** — ⛔ **0** |
| **`P-3`** | ⛔ No retention period, TTL or purge schedule | ⭐ **AFFIRMED** — §7.4; C8 `LMT-XC-004` carried |
| **`P-4`** | ⛔ No bounded context, edge, port or aggregate; `E-34` NOT allocated | ⭐ **AFFIRMED** — ⛔ **0** of each; ⛔ **`E-34` NOT allocated**; ⛔ **`E-31` NOT minted** |
| **`P-5`** | ⛔ No silent conflict resolution | ⭐ **AFFIRMED** — the two contradictions this act met (§2.2, §2.3) are **disclosed and routed**, ⛔ **neither resolved** |
| **`P-6`** | ⛔ No downstream stage entered | ⭐ **AFFIRMED** — ⛔ no Stage 7, no freeze, no implementation |
| **`P-7`** | ⛔ **MUST NOT change its own status** | ⭐ **AFFIRMED** — this document is **`DRAFT`** and ⛔ **does NOT admit itself**; admission requires a **separate Accepted ADR** (§7A.8) |
| **`P-8`** | ⛔ No API mechanism, schema, migration or payment mechanism invented | ⭐ **AFFIRMED** — §5, §7 |

### 3.3 ⛔⛔ §7A.9's five mandatory boundary domains

| Domain | Affirmation |
|---|---|
| **Authentication** | ⛔ **No Auth v4, no authentication rule, no session mechanism invented** — 📤 delegated to Authentication and `BC-18` (C8 `LMT-FR-017`, `LMT-XC-014`) |
| **Payments** | ⛔ **No V1 digital payment and no V2 settlement invented** — C4's duplicate-payment override is 📤 **consumed** as BC Map §10.1 already states it (C8 `LMT-FR-015`) |
| **Permissions** | ⛔ **ZERO permission identifiers**; ⛔ **no `PERM-*`** |
| **Retention / privacy** | ⛔ **No retention period, TTL or purge schedule**; `E-30`'s payload boundary is **consumed unchanged** |
| **API** | ⛔ **No mechanism, header name, endpoint, path, verb, status code, payload or schema invented**; ⛔ **`API-GAP-001` carried OPEN** (§5.2) |

---

## 4. §4 — Composition boundaries *(traceability: PRD → Architecture/BC → ADR → TS)*

### 4.1 `TS-002-LMC-001` — The marketplace is a read-composition, and holds nothing

⭐ **`TS-002-LMC-001`** — The marketplace **SHALL** be realised as a **read-composition over contexts that already own their data**, and **SHALL NOT** hold a system of record for any field it renders.

**Authority, cited not invented:** `MASTER_PRD.md` **L171** classifies the capability *"**not a context**"*; C8 `LMT-BR-002` states the premise; C8 `LMT-FR-002` requires every rendered field to originate from the owner `AR-1` names; C8 `LMT-XC-001` — *"⛔ **No marketplace aggregate, entity, table or store is created.** The composition holds **nothing**; it reads."*

⭐ **This is the load-bearing premise**, and C8 states why: *"A capability that stores nothing needs no schema, no migration, no retention policy of its own, no backup, no consistency model and no isolation mechanism beyond the ones its sources already enforce."*

### 4.2 `TS-002-LMC-002` — The context and edge sets are CONSUMED, not created

⭐ **`TS-002-LMC-002`** — The composition **SHALL** operate using **only** the existing bounded contexts and the existing **29** declared edges.

**Authority:** BC Map **L292** — *"if an edge is not in this table, it **does not exist** and adding it requires an ADR"*; C8 `LMT-XC-009` — set *"remains **29**; `E-27` permanently vacant; `E-31` would be next and ⛔ is not minted here"*; C8 §0.2 measures **0** new contexts and **0** new edges.

⛔⛔ **This document mints NO edge.** ⛔ **`E-31` is NOT minted; `E-34` is NOT allocated; `E-27` stays vacant.** ⛔ **Context count remains 31 (23 in V1).**

### 4.3 `TS-002-LMC-003` — Module placement obeys the existing dependency law

⭐ **`TS-002-LMC-003`** — Composition **SHALL** be realised at the **rank-9 `app`** shell and in **rank-8 `domain/library`**, using **only ports those modules already declare**.

**Authority:** C8 `LMT-FR-003` (`tool/module_dependencies.yaml` **L97**–**L149**, **L502**–**L517**); C8 `LMT-BR-003` 📤 **`L2`** — *"A module may depend only on modules of **strictly lower rank**"*; C8 `LMT-XC-002` — ⛔ no `domain/library` → `domain/social` dependency (`X-05`); C8 `LMT-XC-003` — ⛔ **no new port, no new `imports:` entry, no `banned_imports:` relaxation**.

⛔ **No exception, new cluster or rank change is requested.** ⭐ C7's report path uses the shell's **already declared** `domain/social` port (rank 9 → rank 8, downward, `L2`-clean).

### 4.4 ⛔ `TS-002-LMC-004` — Three absences are LOAD-BEARING and SHALL be honoured

⭐ **`TS-002-LMC-004`** — The following absences **SHALL** be treated as deliberate architecture, ⛔ **never as omissions to be filled**:

1. ⛔ **No marketplace store** — C8 `LMT-XC-001`, `LMT-FR-006` (**0** tables, columns, migrations, constraints).
2. ⛔ **No marketplace event** — C8 `LMT-XC-008`: *"⛔ **No new domain event is created, requested or assumed.**"*
3. ⛔ **No numeric budget** — C8 `LMT-XC-016`: ⛔ no latency target, throughput budget, percentile SLO, payload cap, cache TTL or timeout. ⚠ *"**Disclosed as an absence**, not presented as satisfied."*

---

## 5. §5 — API posture *(traceability: PRD → Architecture/BC → ADR → TS)*

### 5.1 `TS-002-LMC-005` — API rules are CONSUMED as already decided

⭐ **`TS-002-LMC-005`** — Marketplace endpoints **SHALL** compose from **owner-provided reads** and **SHALL NOT** query another context's tables; state-changing endpoints **SHALL** be idempotent via the **existing** API-edge mechanism; every list **SHALL** paginate by **opaque server-generated cursor**.

**Authority:** C8 `LMT-FR-014` 📤 **`F-1`** and BC Map **L330** (*"Search never reads domain tables"*); C8 `LMT-BR-012` 📤 **`F-3`** — domain **re-validates** and the caller is **untrusted**; C8 `LMT-FR-015` — the `platform/services:idempotency` port `domain/library` **already declares**, ⛔ *"No new idempotency store"*; C8 `LMT-FR-016` 📤 **`PG-1`…`PG-4`** (BC Map **L709**–**L712**); C8 `LMT-XC-012` — ⛔ no new API convention, envelope, error taxonomy, version scheme or content type; C8 `LMT-XC-013` — ⛔ no offset pagination, page numbers or total-count guarantee; `ADR-0135` `API-1`…`API-9`.

⛔⛔ **NO endpoint, path, verb, header name, status code, payload or schema is specified here.**

### 5.2 ⛔⛔ `TS-002-LMC-006` — `API-GAP-001` is carried OPEN

⭐ **`TS-002-LMC-006`** — The API deprecation / sunset / multi-version-support policy is **UNDECIDED**, and this document ⛔ **SHALL NOT** supply one.

**Authority:** `ADR-0135` **L194** — *"⛔⛔ **`API-GAP-001` — OPEN.** The API deprecation / sunset / multi-version-support policy is **undecided**"*; **L195** names the authority **Product Owner + Architecture Owner**; `ADR-0139` **formally re-affirmed it OPEN** on re-measured evidence; `ADR-0135` **L168** — *"versioning MECHANISM is not selected here"* (`API-8` **DEFERRED**).

⛔ **No migration period, sunset period, deprecation window, support duration or notice period is stated.** ⭐ This is also the dependency on which **`E-4`** passes, on its **second limb** — a gap with a **named owning office** (§2.3, §8).

### 5.3 `TS-002-LMC-007` — Rate limiting and configuration are delegated whole

⭐ **`TS-002-LMC-007`** — Public surfaces **SHALL** be rate-limited **per origin** and the mechanism **SHALL NOT** identify the visitor; tunable values **SHALL** be read through typed accessors over **`E-19`**.

**Authority:** C8 `LMT-FR-020` (`LIB-14B.41`, `LIB-14B.6`, `LIB-14B.42`); C8 `LMT-XC-015` — ⛔ no counter, bucket, store or evaluator; `RateLimitCounter` **remains `BC-11`'s** (BC Map **L377**); C8 `LMT-FR-019` (BC Map **L328**) — ⛔ *"no raw string lookups in domain code"*, ⛔ no new configuration store or flag system.

---

## 6. §6 — Authorization and isolation *(traceability: PRD → Architecture/BC → ADR → TS)*

### 6.1 ⛔⛔ `TS-002-LMC-008` — ZERO permission identifiers

⭐ **`TS-002-LMC-008`** — Every protected marketplace operation **SHALL** be authorized **server-side** by a **`BC-18` policy decision**, and this document ⛔ **SHALL NOT** define a role, permission, scope, policy language or consent mechanism.

**Authority:** C8 `LMT-FR-017` 📤 **`LIB-DISC-005`/`006`/`008`**; C8 `LMT-XC-014` 📤 **`BC-18`** (BC Map **L127**); C8 `LMT-FR-018` — object references **authorized per request**, ⛔ *"never inferred from possession of an identifier"*; `ADR-0132` (`AUTH-7.22` **CLOSED at 0**, ⛔ unreopened).

⛔⛔ **PERMISSION IDENTIFIERS IN THIS DOCUMENT: ZERO.** ⛔ **No `PERM-*` is minted.**

### 6.2 ⛔⛔ `TS-002-LMC-009` — The two index classes SHALL NOT be mixed

⭐ **`TS-002-LMC-009`** — Every marketplace read **SHALL** be classified into **exactly one** of the two `AR-3` index classes before implementation and **SHALL** carry that class's tenant-key requirement; ⛔ a read **SHALL NOT** mix the classes in one query.

**Authority:** C8 `LMT-FR-007`, `LMT-BR-007` 📤 **`AR-3`** (`ARCHITECTURE_RULINGS.md` **L95**–**L125**); C8 `LMT-FR-008` — the public index **MUST** contain **only** §14A.5 public metadata and ⛔ **MUST NOT** contain seat counts, occupancy, membership, fee, attendance, internal analytics or moderation data.

⚠⚠ **The reason is recorded because it is the highest-severity failure in the architecture:** a join between an untenanted public index and tenanted operational rows is, per BC Map §11.1, *"the single highest-severity failure mode in the entire architecture … a cross-tenant data leak via a capability context."*

### 6.3 `TS-002-LMC-010` — Tenant context is ambient, and absence fails loudly

⭐ **`TS-002-LMC-010`** — Tenant context **SHALL** be ambient; where it is required and absent the operation **SHALL fail loudly** and **SHALL NOT** default, fall back to a *"first"/"default"/"any"* tenant, or proceed untenanted.

**Authority:** C8 `LMT-BR-008` 📤 **`E-18`** (BC Map **L327**) — *"propagated, never passed as a parameter through domain methods"*; C8 `LMT-FR-009`; C8 `LMT-XC-007` — ⛔ no tenant id or `StudentRecordId` may enter `BC-10`…`BC-17` (`ID-2`; `banned_symbols` **L266**–**L267**).

⭐ **This binds C7's report path:** a report carries a `PersonId` and a **public** subject reference, ⛔ **never a `StudentRecordId`**.

---

## 7. §7 — Events, jobs, degradation, analytics *(traceability: PRD → Architecture/BC → ADR → TS)*

### 7.1 `TS-002-LMC-011` — Only pre-existing events, delivered under the inherited contract

⭐ **`TS-002-LMC-011`** — C1–C7 **SHALL** operate using **only** the existing events — `tenancy.*` via **`E-21`**, `tenancy.LibraryProfileViewed` via **`E-30`**, `safety.EnforcementActionTaken` via **`E-14`**, audit facts via **`E-20`** — under BC Map **§9.1**'s Event Delivery Contract, **inherited whole**.

**Authority:** C8 `LMT-FR-011`, `LMT-FR-010` (📤 **DELEGATED IN FULL**), `LMT-BR-009` (naming, BC Map §9), `LMT-XC-008` (⛔ **0** events created or assumed).

⛔ **`E-30`'s payload is NOT extended.** C8 `LMT-XC-010`: ⭐⭐ *"**The payload boundary IS the privacy control**"* — subject library and occurrence time, ⛔ **no viewer identity in any form**.

### 7.2 `TS-002-LMC-012` — Deferred work goes through the declared port only

⭐ **`TS-002-LMC-012`** — Where deferred work is required it **SHALL** be submitted through the **declared port** `platform/services:job_runtime`; ⛔ **no own worker pool, queue, retry scheduler or cron** is created.

**Authority:** C8 `LMT-FR-012` (`ADR-0058`; yaml **L338**); C8 `LMT-BR-011` — V1 is a **lightweight in-process adapter**, ⛔ **not** the V2 Job Runtime deployment, and `submit` **MUST be non-`async`**; C8 `LMT-XC-011` 📤 `FIL-XC-017`.

⭐ **C8 `LMT-FR-013` measured that C1–C7 require NO deferred work of their own**, and this document ⛔ **does not assert one exists** — it records the lawful route should a need later arise.

### 7.3 ⛔ `TS-002-LMC-013` — Degradation omits or relabels; it never fabricates

⭐ **`TS-002-LMC-013`** — When an upstream owner is unavailable the surface **SHALL** degrade by **omitting or truthfully relabelling** the affected element, and **SHALL NOT** substitute a locally computed value, a cached guess, a zero, or a placeholder presented as data.

**Authority:** C8 `LMT-FR-024` and its five-row table (`BC-23`, `BC-04`, `BC-26`, `BC-13`, `BC-29`); C8 `LMT-FR-025` — ⛔ no local write buffer, store-and-forward queue or offline mutation log; C8 `LMT-FR-023` — ⭐ *"The correct response to staleness is **truthful labelling, not a stronger guarantee**"*; `ADR-0097`.

⛔⛔ **`UniqueViewers` remains NOT CERTIFIED** and ⛔ **SHALL NOT** be rendered as zero, unknown, a placeholder, *"coming soon"*, disabled, blurred, teased or estimated (C8 `LMT-XC-018`, `ADR-0097`).

### 7.4 ⛔ `TS-002-LMC-014` — No data, schema, retention or analytics decision is made here

⭐ **`TS-002-LMC-014`** — This document **SHALL NOT** state a schema, migration, index definition, retention period, metric or numeric budget.

**Authority:** C8 `LMT-FR-006` (**0** tables/columns/migrations/constraints); C8 `LMT-XC-004` (⛔ no retention for any data class); C8 `LMT-XC-006` (⛔ no new index, analyzer, tokenizer, synonym list, relevance formula or query rewriter — 📤 `BC-23`); C8 `LMT-XC-018` (⛔ **no metric defined, computed, certified, aggregated, projected or reported** — 📤 `BC-26` **sole** analytics authority); C8 `LMT-XC-019`; C8 `LMT-XC-017` (⛔ no cache tier, invalidation protocol or read replica); C8 `LMT-XC-016`; C8 `LMT-BR-006` — ⛔ *"**Filling those cells with plausible values would be inventing architecture**"*.

⭐ **C8 §0.3's prohibition register is carried forward in full** and ⛔ **nothing in it is relaxed**: ⛔ no message broker other than the declared outbox · no second event bus · no search engine other than `BC-23` · no analytics store other than `BC-26` · no media store other than `BC-29` · no graph database · no vector store · no ML model or feature store · no recommendation service · no CDN configuration · no service mesh · no sharding · no multi-region replication · no read replica · no materialised view outside `BC-26` · no cron scheduler · no distributed lock service · no feature-flag system other than `BC-25`.

⛔ **Media is referenced by `FileRef`, never bytes** (C8 `LMT-FR-005`, `E-22`, BC Map **L331**); ⛔ **no second media store, transform pipeline, thumbnailer, virus scanner or URL signer** (C8 `LMT-XC-005`).

⛔ **No audit entry for an anonymous public view** — `AuditEntry` requires an *"actor of record"* (BC Map **L384**); ⛔ **no second audit store** (C8 §11, `E-20`).

---

## 8. ⛔⛔ `X-5` — Gap register: every unresolved question, with its EXISTING owner

⛔⛔ **NOT ONE OF THESE IS CLOSED**, and ⛔ **no new gap identifier is created**. `X-5` is explicit: ⛔ *"none is closed to make the document look complete"*.

| # | Unresolved question | Existing identifier | Owning office (existing) | Status |
|---|---|---|---|---|
| 1 | API deprecation / sunset / multi-version support | **`API-GAP-001`** | **Product Owner + Architecture Owner** (`ADR-0135` **L195**) | ⛔ **OPEN** |
| 2 | API versioning mechanism selection | **`API-8`** | Architecture Owner | ⛔ **DEFERRED** |
| 3 | Referral transport between `BC-13` and `BC-19` | **`TSF-GAP-009`** | **Architecture Owner** with the **`BC-19` owner** (C8 §13) | ⛔ **OPEN** — blocks `IMPL-1424` |
| 4 | `BC-26`'s undeclared inbound edges | **`GAP-BCMAP-BC26-EDGES`** | **Architecture Owner** (C8 §13, `LMT-BR-010`) | ⛔ **OPEN** |
| 5 | C0-inherited open decision | **`XPC-OD-004`** | **Architecture Owner** | ⛔ **OPEN** |
| 6 | C0-inherited open decision | **`XPC-OD-005`** | **Privacy Owner** — ⭐ role constituted by `ADR-0077`; ⚠ **holder VACANT** | ⛔ **OPEN** |
| 7 | C0-inherited open decision | **`XPC-OD-006`** | **Architecture Owner** | ⛔ **OPEN** |
| 8 | C5-inherited open decision | **`XPC-OD-008`** | **Product Owner** with **Architecture Owner** | ⛔ **OPEN** |
| 9 | C6-inherited open decision | **`XPC-OD-009`** | **Architecture Owner** with the **`BC-23` owner** | ⛔ **OPEN** |
| 10 | C7-inherited open decision | **`XPC-OD-010`** | **Architecture Owner** with **Security** reviewer | ⛔ **OPEN** |
| 11 | Rank of an admitted Technical Specification | **`TSG-GAP-004`** | **Architecture Owner** | ⛔ **OPEN** |
| 12 | Registry status for an admitted specification | **`TSG-GAP-006`** | Governance Owner | ⛔ **OPEN** |
| 13 | Whether **A8** should be re-expressed as a `TS-*` | **`TSG-GAP-003`** (A8 limb) | **Architecture + Product Owner** (`ADR-0131` §11) | ⛔ **OPEN** — ⭐ the C8 limb was disposed by `ADR-0142` `D-2`; ⛔ **the gap is NOT closed** |
| 14 | The two ADRs C8 routed but did not write | C8 **§13** rows 1–2 | **Architecture Owner** | ⛔ **0 written of 2 required** |
| 15 | C8's header *"Stage 3 NOT entered"* vs the conferred `ALIGNED / STAGE 3` | *(no identifier — ⛔ none minted)* | **Product Owner** (C8's document owner) | ⚠ **DISCLOSED, not repaired** (§2.3) |
| 16 | `ADR-0142` §3.4's family figures vs re-measurement | *(no identifier — ⛔ none minted)* | **Architecture Owner** | ⚠ **DISCLOSED, not repaired** (§2.2) |

⭐ **Gap rows: 16. Closed: 0. New gap identifiers minted: 0. Every row names an owning office.**

⭐ The six `XPC-OD-*` offices are taken **verbatim** from the governed `PRD-021C` C0–C8 Stage-3 record, ⛔ **not assigned here**. ⚠⚠ **`XPC-OD-005`'s office is `Privacy Owner`, a role `ADR-0077` constitutes but whose holder the source marks VACANT** — ⭐ recorded exactly as the source states it, because **`E-4` requires the office NAMED, ⛔ not OCCUPIED**, and overstating occupancy would be the fabrication `ADR-0138` exists to prevent.

---

## 9. ⭐ `X-6` — Section-level traceability chain

⭐ Format required by `X-6`: **PRD requirement → Architecture/BC → ADR → this section.**

| § | PRD requirement (C8 / C1–C7) | Architecture / BC authority | ADR | This section |
|---|---|---|---|---|
| §1 | — *(authority record)* | `PRD_LIFECYCLE` §7A.6 | **`ADR-0142`** `D-5`, `ADR-0033` §7.1 | §1 |
| §2.1 | C8 `LMT-FR-001` | — | `ADR-0142` `D-1` | §2.1 |
| §2.2 | C8 §1 registers | — | `ADR-0131` §5.2, §5.3; `ADR-0138` §3.4; `ADR-0140` `D-7` | §2.2 |
| §2.3 | C8 header; C0–C8 Stage-3 record | — | **`ADR-0098`**; `PRD_LIFECYCLE` §7A.4; `ADR-0135` **L194** | §2.3 |
| §2.4 | C8 identity, Rank 3 | `ADR-0131` §6.1 | **`ADR-0098`**, `ADR-0142` `D-2` | §2.4 |
| §3 | — | `PRD_LIFECYCLE` §7A.9 | `ADR-0131` §3.3, §8.2; `ADR-0132` | §3 |
| §4.1 | C8 `LMT-BR-002`, `LMT-FR-002`, `LMT-XC-001` | `MASTER_PRD` **L171**; `AR-1` | `ADR-0098` | §4.1 |
| §4.2 | C8 `LMT-XC-009`, §0.2 | BC Map **L292** | `ADR-0096` | §4.2 |
| §4.3 | C8 `LMT-FR-003`, `LMT-BR-003`, `LMT-XC-002`/`003` | `L2`; yaml **L97**–**L149**, **L502**–**L517**; `X-05` | `ADR-0012` | §4.3 |
| §4.4 | C8 `LMT-XC-001`, `LMT-XC-008`, `LMT-XC-016` | BC Map §9 | `ADR-0097` | §4.4 |
| §5.1 | C8 `LMT-FR-014`/`015`/`016`, `LMT-BR-012`, `LMT-XC-012`/`013` | `F-1`, `F-3`, `PG-1`…`PG-4`; BC Map **L330**, **L709**–**L712** | **`ADR-0135`** | §5.1 |
| §5.2 | — | — | **`ADR-0135`** **L194**–**L196**, **`ADR-0139`** | §5.2 |
| §5.3 | C8 `LMT-FR-019`/`020`, `LMT-XC-015` | BC Map **L328**, **L377**; `LIB-14B.*` | `ADR-0135` | §5.3 |
| §6.1 | C8 `LMT-FR-017`/`018`, `LMT-XC-014` | `BC-18`; BC Map **L127**; `LIB-DISC-005`/`006`/`008` | **`ADR-0132`** | §6.1 |
| §6.2 | C8 `LMT-FR-007`/`008`, `LMT-BR-007` | **`AR-3`** **L95**–**L125**; BC Map §11.1 | `ADR-0098` | §6.2 |
| §6.3 | C8 `LMT-BR-008`, `LMT-FR-009`, `LMT-XC-007` | `E-18`; BC Map **L327**; `ID-2`; yaml **L266**–**L267** | `ADR-0010` | §6.3 |
| §7.1 | C8 `LMT-FR-010`/`011`, `LMT-BR-009`, `LMT-XC-008`/`010` | BC Map **§9**, **§9.1**; `E-14`/`E-20`/`E-21`/`E-30` | **`ADR-0096`**, `ADR-0097` | §7.1 |
| §7.2 | C8 `LMT-FR-012`/`013`, `LMT-BR-011`, `LMT-XC-011` | yaml **L338**; `FIL-XC-017` | **`ADR-0058`** | §7.2 |
| §7.3 | C8 `LMT-FR-023`/`024`/`025`, `LMT-XC-018` | BC Map **§10**, **§10.1** | **`ADR-0097`** | §7.3 |
| §7.4 | C8 `LMT-FR-006`, `LMT-BR-006`, `LMT-XC-004`/`005`/`006`/`016`/`017`/`018`/`019`/`020`, §0.3 | BC Map **L331**, **L384**, **L135**, **L385**; `AR-3` | `ADR-0097` | §7.4 |
| §8 | C8 §13 and its inherited items | — | `ADR-0131` §11; `ADR-0135`; `ADR-0142` `D-11` | §8 |

⭐ **22 traceability rows. Every section is chained; ⛔ no section asserts a technical fact without a cited authority.**

---

## 10. ⛔ What this document does NOT do

1. ⛔⛔ **It does NOT admit itself.** Status is **`DRAFT`**; admission requires a **separate Accepted ADR** (§7A.8; `P-7`).
2. ⛔⛔ **It assigns itself NO RANK.** It would be **governed but UNRANKED** on admission; ⛔ **no Rank 8 is invented**; `TSG-GAP-004` **OPEN**.
3. ⛔⛔ **It creates NO registry status.** C8's PRD stays **`APPROVED`**; `TSG-GAP-006` **OPEN**.
4. ⛔⛔ **It confers NO Stage 7, NO freeze and NO implementation authority.** Stage `6A` is **OPTIONAL and NON-BLOCKING**, ⛔ *"still not a precondition of Stage 7"*, and ⛔ *"passing `6A` authorises no downstream act"* (§7A.3, §7A.10).
5. ⛔⛔ **It modifies C8, A8, B9 or `TS-001` in no way** — all four **byte-unchanged**.
6. ⛔⛔ **It amends NO Rank 1–5 document** — ⛔ `MASTER_PRD`, BC Map, `PRD_LIFECYCLE`, `TRACEABILITY_MATRIX`, `ADR-0131`/`0135`/`0140`/`0141`/`0142` all untouched.
7. ⛔ **It closes NO gap** — §8 has **16 rows, 0 closed**; ⛔ **`TSG-GAP-003` stays OPEN** on the A8 limb.
8. ⛔ **It authorises no further specification** — ⛔ no `TS-003`, ⛔ no third subject (`ADR-0142` `D-13`).
9. ⛔ **It mints no identifier beyond `TS-002-LMC-001`…`014`** — ⛔ no new prefix, ⛔ no new gap identifier, ⛔ no `PERM-*`, ⛔ no `E-31`, ⛔ no `E-34`.
10. ⛔ **It touches no file under `lib/`, `test/`, `tool/`, `packages/`, `android/`, `web/`**; `pubspec.yaml` unchanged. ⛔ **No push.**
11. ⛔ **It repairs none of the disclosed pre-existing issues** — ⛔ not C8's *"Stage 3 NOT entered"* header, ⛔ not the `B-8` label collision, ⛔ not `DOCUMENTATION_BASELINE` §3.4's matrix-version drift. ⭐ Each is **routed, not resolved**.

---

## 11. ⚠ Honest assessment

1. ⚠ **This document invents no architecture, and that is the point** — C8's central finding is that *"C1–C7 require **ZERO new infrastructure**"*, so a specification that added a mechanism would be **contradicting its own subject**.
2. ⚠ **Its value is boundary-holding, not novelty.** It names which convention, which owner and which citation governs each composition surface, so a future implementer cannot quietly invent one.
3. ⚠⚠ **The four offices are exercised by one principal.** ⛔ **No independent review is claimed.** A self-audit cannot validate the judgement calls inside the document it audits.
4. ⚠⚠ **Two contradictions were found in governing records and NEITHER was repaired** (§2.2, §2.3). Both are disclosed with a named owner. ⭐ That is `P-5` operating as designed — ⛔ **a specification may not resolve a conflict by drafting**.
5. ⚠ **`E-4` passes on its disjunctive second limb, not its first.** Several dependencies — most importantly `API-GAP-001` — **do not exist as decisions**; they qualify only because they are *"recorded as a gap with a named owning office"*. ⭐ Read strictly, this document rests on **16 open questions**.
6. ⚠ **`TSG-GAP-003` is now disposed for two of three limbs and CANNOT be closed** until A8's limb is disposed. ⛔ Nothing here brings that closer.
7. ⭐ **Admission is not guaranteed.** `X-1`…`X-6` are measured **after** authoring (§12), and an admitting ADR may still decline.

---

## 12. Changelog

| Version | Date | Change |
|---|---|---|
| **v0.1** | 2026-09-11 | ⭐⭐ **Created as `DRAFT`** — the **second** Technical Specification in this repository, for **`PRD-021C` Part C8**, under the **four-office one-act conferral** recorded at `Accepted` **`ADR-0142`** `D-5`, which ⛔⛔ **expires automatically on completion of this act** and is ⛔ **not standing authority**; ⛔ **no office is recorded as occupied** (§7A.6) and ⛔ **no personal name appears**. ⭐ Stem **`LMC`** declared and **measured free in four directions** (bare token **0**, prefixed identifiers **0**, filenames **0**, `lib`/`tool` **0**); ⛔ **`LMT-*` NOT reused, extended or reinterpreted** (`ADR-0131` §5.3), nor `LTS-*`, `LCTS-*`, `TPA-*`, `MSG-*`, `SGT-*`, `IMPL-*`, `PERM-*`. ⭐ **`E-1`…`E-4` re-measured FOR C8 at this commit** rather than inherited from `ADR-0142` §3.3: `E-1` by `Accepted` **`ADR-0098`** (Rank 3, C8 named 20×), `E-2` by the C0–C8 Stage-3 record (**PASS 6/6**, C8 cited 42×), `E-3` discharged inside §9, ⚠ **`E-4` on its DISJUNCTIVE second limb only** — the dependencies are *"recorded as a gap with a named owning office"*, and `E-4` requires the office **NAMED, ⛔ not OCCUPIED**. ⭐ **14 requirements `TS-002-LMC-001`…`014`, contiguous from 001.** ⭐ **`X-4` discharged INDIVIDUALLY** — `ADR-0131` §3.3's **five**, §8.2's **`P-1`…`P-8`** and §7A.9's **five** boundary domains, **18 affirmations**. ⭐ **`X-5`: 16 gap rows, ⛔ 0 closed, ⛔ 0 new gap identifiers minted, ⭐ every row naming an owning office** — the six `XPC-OD-*` offices taken **verbatim** from the governed C0–C8 Stage-3 record, ⚠ including **`XPC-OD-005`'s `Privacy Owner`, whose holder that source marks VACANT**, recorded as stated because `E-4` requires the office **NAMED, ⛔ not OCCUPIED**. ⭐ **`X-6`: 22 section-level traceability rows.** ⛔⛔ **NOTHING IS INVENTED:** ⛔ **0** bounded contexts, **0** edges (set **remains 29**, ⛔ **`E-31` NOT minted**, ⛔ **`E-34` NOT allocated**, `E-27` stays vacant), **0** events, **0** aggregates, **0** tables, **0** columns, **0** migrations, **0** indexes, **0** caches, **0** queues, **0** worker pools, **0** cron jobs, **0** API conventions, **0** endpoints, **0** permissions (⛔ **no `PERM-*`**; `AUTH-7.22` **CLOSED at 0**), **0** roles, **0** metrics, **0** retention periods, **0** numeric budgets, **0** lines of code. ⭐ **C8's §0.3 prohibition register carried in full** and ⛔ **nothing relaxed**. ⛔⛔ **C8 is NOT converted, re-expressed, renamed, re-identified, restatused or moved** — **byte-unchanged** (`7fc70327f83310148db964f6c3e937257aa14357`), **Rank 3**, serving as ⭐ **cited input and structural precedent**; ⛔ **A8** (`1a0fbcf3…`), **B9** (`6b241eaf…`) and **`TS-001`** (`fba2441f…`) untouched. ⛔ **`TSG-GAP-003` REMAINS OPEN** on the **A8 limb** and ⛔ **is not closed**; ⛔ `TSG-GAP-001`/`002`/`004`/`005`/`006`, **`API-GAP-001` OPEN**, **`API-8` DEFERRED**, `TSF-GAP-009`, `GAP-BCMAP-BC26-EDGES`, the six `XPC-OD-*`, `Q-04`/`LR-01`, `SX-02` **WITHDRAWN** with ⛔ **no `SX-05`**, blocker **7a**, `B-5` and the ⚠ **`B-8` label collision** — **ALL UNTOUCHED**. ⚠⚠ **TWO CONTRADICTIONS DISCLOSED AND ROUTED, NEITHER REPAIRED** (`P-5`; `PRD_LIFECYCLE` **L177**): C8's header *"Stage 3 NOT entered"* against the conferred `ALIGNED / STAGE 3` — ⭐ **the conferral governs** — routed to the **Product Owner**; and `ADR-0142` §3.4's family figures (61/53/39/27 raw) against re-measurement (**64/55/41/29 raw**; **register sizes 26/20/16/12 = 74**, contiguous, as C8 §1 declares) — routed to the **Architecture Owner**; ⛔ **`ADR-0142` NOT amended** (`ADR-INDEX` **L207**) and ⛔ **C8 NOT edited**. ⛔⛔ **THIS DOCUMENT DOES NOT ADMIT ITSELF** — **`DRAFT`**, ⛔ **UNRANKED**, admission only by a **separate Accepted ADR** (§7A.8, **`P-7`**); ⛔ **no Stage 7, no freeze, no implementation authority**; ⛔ **no `TS-003`, no third subject** (`ADR-0142` `D-13`). ⛔ **0** code/test/tool files; ⛔ **no push**. |
