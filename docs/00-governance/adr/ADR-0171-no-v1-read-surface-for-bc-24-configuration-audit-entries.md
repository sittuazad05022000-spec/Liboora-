# ADR-0171 — **No V1 READ surface exists for `BC-24` configuration audit entries**: the joint Authorization Owner and `BC-24` Owner determine that no tenant role receives READ, and no permission is created

| Field | Value |
|---|---|
| **Status** | ⭐⭐ **Accepted** — **2026-09-19**, under the **joint** one-act conferral recorded **verbatim** at **§8.1**. ⛔ **Reverting on completion** *(`ADR-0033` §7.1)*. ⚠️⚠️ **NO INDEPENDENT REVIEW CLAIMED** — expressly so stated in the conferral |
| **Rank** | 2 — Architecture Decision Record |
| **Date prepared** | 2026-09-19 |
| **Bounded context** | ⭐ **`BC-24` Audit Trail** / `PRD-016` *(owns the audit capability)* · ⭐ **`BC-18` Identity & Access** / `PRD-001` *(owns authorization semantics)* · `BC-25` Configuration / `PRD-023` *(the requesting surface)* |
| **Supersedes** | ⛔ **NOTHING** |
| **Superseded by** | — |
| ⭐⭐ **Deciding authority** | ⭐⭐ **JOINT — the Authorization Owner** *(`PRD_OWNERSHIP_MODEL` §16.1, constituted by `Accepted` `ADR-0159`)* **and the `PRD-016` / `BC-24` Owner**. ⚠️⚠️ **Joint is structural, ⛔ not stylistic** — see §6.1 |
| **Contributing offices** | ⛔⛔ **NONE.** ⛔ No Product Owner, Security Owner, Privacy Owner, Architecture Owner or Design office input is claimed, exercised or recorded — ⭐ the conferral names two offices only |
| **Decides** | ⭐ **One question — `DD7-GAP-008` / `C-4`: whether any existing tenant role receives a `READ` surface for `BC-24` configuration audit entries in V1.** ⛔ **Nothing else** |
| **Expressly does NOT decide** | ⛔ **APP 3** *(expressly out of scope)* · ⛔ `CFG-12` *(`ADR-0165`, ⛔ not reopened)* · ⛔ `SCFG-2` *(`ADR-0166`, ⛔ not reopened)* · ⛔ `SEAT-CFG-017` · ⛔ `CFG-10`, `SCFG-4` · ⛔ the 4 Face `ATT-CFG-*` · ⛔ any other `DD-0007` hold · ⛔ any external/legal hold *(`LR-01`)* · ⛔ `BC-24` read for **non-configuration** audit entries · ⛔ any `PERM-*` · ⛔ any role, action class or scope class · ⛔ `DD-0007`'s counts, version or design-readiness · ⛔ `AUD-GAP-003`, `AUD-GAP-004`, `D-016-01` |
| **Amends** | ⛔⛔ **NOTHING.** ⭐ The determination **preserves** the existing state exactly; ⛔ **no downstream reconciliation is created or required** *(§7)* |
| **Origin** | ⭐ `DD-0007` **L1514** `DD7-GAP-008`; diagnosed at [`DDR-0025`](../../design/design-decisions/DDR-0025-c4-c5-binding-blocker-diagnosis.md) §A |

> ⭐⭐ **Identifier check, performed immediately before drafting and again before writing.**
> `ADR-0170` is the highest ADR file present. **`ADR-0171` measured 0 files on disk and
> 0 references anywhere in the repository.** ⛔ No identifier is reused, reserved or
> renumbered.

---

## 1. ⭐ Question

> ⭐⭐ **Should any existing tenant role have a `READ` surface for `BC-24` configuration
> audit entries in V1?**

⭐ The question arises because `PRD-023` requires a configuration change history to exist
while forbidding its own module from serving it:

| Source | Text *(minimum necessary)* |
|---|---|
| `PRD-023` **L924** `CNF-BR-006` | *"Configuration history **SHALL** be reconstructible from the audit trail. The module **SHALL NOT** maintain a second, independent version history of its own."* |
| `PRD-023` **L922** `CNF-XC-010` | *"The module **MUST NOT** store, update, delete, retain, expire or **query** audit entries."* ⭐ Owner stated in-line: ***`BC-24` / `PRD-016` (FROZEN)*** |

⭐ `DD-0007`'s surface `C-4` *"Change history"* therefore has a **requirement to exist** and
⛔ **no identified reader**. ⚠️ The conferral expressly required that this ADR **permit the
outcome "NO V1 READ SURFACE"** if the evidence does not justify allocation.

---

## 2. ⭐⭐ Evidence — measured, not asserted

### 2.1 ⭐ `BC-24` owns the capability and is FORBIDDEN from allocating it

| # | Source | Measurement |
|---|---|---|
| **1** | `PRD-016` **L119** `AUD-FR-002` | *"The module **SHALL** own audit storage, retention execution and **audit query**"* |
| **2** | ⭐⭐ `PRD-016` **L271** `AUD-XC-005` | ⭐⭐ *"The module **MUST NOT** make, store, cache or evaluate an **authorisation decision**. Confining a query to a tenant is not deciding access"* — ⭐ Owner: ***`BC-18`*** |

⭐⭐ **This is the structural core of the finding.** ⭐ `BC-24` holds the *capability* and
**disclaims the authority** to say who may invoke it. ⛔⛔ **Owning a capability is not
allocating it** — ⭐ and inferring otherwise is precisely what `AP-4` forbids.

### 2.2 ⭐⭐ `PRD-016` contains NO role allocation of any kind

| Probe on `PRD-016_AUDIT_TRAIL.md` *(`FROZEN` v0.1, Rank 3, `ADR-0051`)* | Result |
|---|---|
| ⭐⭐ Occurrences of `TR-1`, `TR-2` or `TR-3` | ⛔⛔ **ZERO** |
| ⭐⭐ A protected-operation register *(`AUD-PO-*`)* | ⛔⛔ **ZERO — the register does not exist** |
| ⭐ Registers that **do** exist *(§0.3)* | `AUD-FR` **16** · `AUD-BR` **3** · `AUD-INV` **4** · `AUD-EVT` **declared empty** · `AUD-XC` **12** |

⭐⭐ **So there is no operation to allocate and no role named to receive it.** ⭐ What
`PRD-016` does specify is **confinement**, which is a different thing entirely:
`AUD-FR-014` *(every query confined to one tenant)*, `AUD-FR-015` *(no tenant context ⇒
fail)*, `AUD-FR-016` *(no cross-tenant read surface)*.

### 2.3 ⚠️⚠️ `AUTH-10.23` was tested as a candidate grant — and it is NOT one

⭐ `PRD-001` **L4047** carries the closest thing in the repository to an audit-read
obligation, and it must be confronted rather than ignored:

> `AUTH-10.23` — *"A library **MUST** be able to view audit **only** for actions within its
> own context"*

⚠️ **On a quick reading this looks like the missing grant. It is not, for four measured
reasons:**

| # | Test | Result |
|---|---|---|
| **1** | ⭐⭐ Does it name a role? | ⛔⛔ **NO — 0 occurrences** of `TR-n`, `PR-n`, Owner, Manager or Reception on that line. ⭐ *"A library"* is a **tenant**, ⛔ not a role |
| **2** | ⭐ Does it name an action class or scope class? | ⛔ **NO** — ⭐ `AUTH-7.23` requires *"Every permission **MUST** declare its scope class"* |
| **3** | ⭐⭐ What is its grammatical force? | ⭐⭐ **It is a CONFINEMENT rule, not a grant.** ⭐ The operative word is ***"only"*** — it **limits** any future viewing to own-context. ⛔ It does not create the viewing |
| **4** | ⭐ Is it about **configuration** audit? | ⛔ **NO** — ⭐ §10.4 is the **authentication** auditable-action list *(`AUTH-10.19`…`10.27`)* |

⭐⭐ **And `AUTH-10.26` on the very next line confirms the reading**: *"Authentication
**MUST NOT** own audit storage, retention or query; it **MUST only produce** the records."*
⭐ `PRD-001` is therefore *also* disclaiming the query surface — ⛔ it is not granting one.

⛔⛔ **Treating `AUTH-10.23` as the allocation would breach `AP-4`** *("No permission is
derived from role naming, hierarchy, seniority or similarity to another permission")* and
`AUTH-7.23` *(a permission without a declared scope class **is invalid**)*.

### 2.4 ⭐⭐ The existing catalogues were checked, as the conferral required

| Catalogue | Measurement |
|---|---|
| ⭐⭐ `AUTH-7.22` permission catalogue | ⛔⛔ **CLOSED** — *"A permission not declared in it cannot be granted, requested or evaluated."* ⭐ Enumerated permissions measured **ZERO** |
| ⭐ `PERM-*` repository-wide | ⭐ **1** token exists — **`PERM-PARTICIPATE`**, ⛔ which is **not** an audit or configuration permission and ⛔ **cannot be repurposed** *(`AP-4`, `AUTH-7.28`)* |
| ⭐ `PRD-023` protected operations *(`CNF-PO-*`)* | ⛔ **ZERO — the register does not exist** |
| ⭐ `PRD-016` protected operations *(`AUD-PO-*`)* | ⛔ **ZERO — the register does not exist** |

⭐⭐ **Conclusion of the catalogue search: there is NO already-existing valid
role × action × scope combination for reading `BC-24` configuration audit entries.**
⭐ The conferral permitted allocation **only** from such an existing combination and ⛔
expressly forbade minting new primitives. ⭐⭐ **Since none exists, allocation is not
lawfully available on these facts.**

### 2.5 ⭐ Deny-by-default is the governing default, not a tie-breaker

| Source | Text |
|---|---|
| ⭐⭐ `AP-3` *(`AUTH-7.6`)* | *"**Deny by default.** Absence of an explicit grant is **refusal**"* |
| `AUTH-7.24` | *"Each action class **MUST** be granted independently. **Read MUST NOT imply** any other action"* |
| `AUTH-7.28` | *"Permissions **MUST NOT** form a hierarchy. **No permission implies another**"* |

⭐⭐ **The absence measured in §2.2–§2.4 is therefore not an information gap to be filled by
judgement — it is, by `AP-3`, already an answer: refusal.**

### 2.6 ⚠️ A code-state fact, recorded and NOT relied upon

⭐ `PRD-016` **L336** records defect **`D-016-01`**: `AuditTrail.recent()` and `count`
expose **cross-tenant** read surfaces *(`grep -c "tenantId"` within `recent()` → **0**)*,
with callers at `lib/app/dashboards/ops_page.dart:270,272,282`, violating `AUD-FR-016`,
`AUD-XC-003` and `AU-7`.

⛔⛔ **This existing code is NOT treated as evidence of an authorization.** ⭐ `PRD-016`
**L253** already states that `AUD-FR-016` *"contradicts existing code, **deliberately**."*
⭐⭐ **An unlawful read surface in code is a defect, ⛔ not a precedent** — and the conferral
expressly barred inferring authority from *"UI presence… or enforcement references."*
⛔ `D-016-01` remains **OPEN** and is **not repaired, narrowed or ratified** here.

---

## 3. ⭐⭐ Decision

> # ⭐⭐ **NO V1 READ SURFACE**
>
> ⭐⭐ **No existing tenant role receives a `READ` surface for `BC-24` configuration audit
> entries in V1.** ⛔ **No permission, role, scope class, action class or read surface is
> created.**

⭐ Stated positively, so it cannot be misread as an oversight:

1. ⭐⭐ **The determination is a decision, ⛔ not a deferral.** ⭐ `DD7-GAP-008`'s question is
   **answered**: the answer is **no allocation in V1**.
2. ⭐⭐ **`BC-24` retains full ownership of the audit capability** — `AUD-FR-002` is
   **untouched**. ⛔ Nothing here removes, narrows or transfers it.
3. ⭐⭐ **`AUD-XC-005` is preserved and honoured, not circumvented.** ⭐ `BC-24`'s
   prohibition against making authorization decisions is **the reason this ADR exists**,
   and the `BC-24` Owner's participation here is as the **capability owner**, ⛔ not as an
   authorization decider — the authorization limb is the **Authorization Owner's** *(§6.1)*.
4. ⭐ **Audit recording continues entirely unchanged.** ⭐ `E-20` emission, immutability
   *(`AUD-XC-002`)*, tenant confinement *(`AUD-FR-014`…`016`)* and retention are
   **unaffected**. ⭐⭐ **Configuration changes are still audited; only a tenant-facing
   *reader* is withheld.**
5. ⭐⭐ **`CNF-BR-006` is satisfied, not breached.** ⭐ It requires history be
   ***"reconstructible from the audit trail"*** — ⭐ and the entries **exist and are
   reconstructible**. ⛔ It does **not** require a V1 tenant-facing screen, and ⭐ reading a
   reconstructibility guarantee as a UI mandate would be the inference `AP-4` forbids.

### 3.1 ⭐ Why allocation was refused rather than granted

| Option | ⛔ Disposition |
|---|---|
| ⛔ Allocate `READ` to `TR-1` Owner | ⛔⛔ **Refused.** ⭐ No existing role × action × scope combination exists to use *(§2.4)*; ⛔ granting would require **minting** a permission into a catalogue `AUTH-7.22` holds **closed**, which the conferral expressly forbade |
| ⛔ Allocate to `TR-1` + `TR-2`, excluding `TR-3` | ⛔ **Refused — same defect**, plus it would imply a **hierarchy** *(`AUTH-7.28`)* |
| ⛔ Rely on `AUTH-10.23` as the grant | ⛔⛔ **Refused on four measured grounds** *(§2.3)*: names no role, no action class, no scope class, and is a **confinement** rule in the **authentication** audit list |
| ⛔ Repurpose `PERM-PARTICIPATE` | ⛔ **Refused** — ⭐ unrelated subject matter; ⛔ `AP-4` bars derivation *"from similarity to another permission"* |
| ⛔ Treat `ops_page.dart`'s existing read as authorization | ⛔⛔ **Refused** — ⭐ it is recorded defect `D-016-01`; ⛔ enforcement/UI presence is expressly excluded as evidence |
| ⛔ Defer *(leave `DD7-GAP-008` open)* | ⛔ **Refused.** ⭐ The conferral asked for a **decision**, and ⭐ `AP-3` already supplies the default. ⭐⭐ **Leaving it open would have been the evasive outcome** |
| ⭐⭐ **NO V1 READ SURFACE** | ⭐⭐ **SELECTED** — ⭐ the only outcome the measured evidence supports without minting a primitive |

### 3.2 ⭐ Precedent — this is an established disposition, not a novel one

⭐ `Accepted` **`ADR-0164`** *(Outcome B)* disposed of `ICFG-1`…`ICFG-10` on the same shape:
⛔ **no V1 read surface**, ⛔ **no role received `READ`**, ⛔ **no `PERM-*` created**, ⭐ with
internal enforcement continuing unchanged. ⭐⭐ **A parameter — or here, a surface — can be
discharged by being DECIDED, ⛔ not only by being GRANTED.**

---

## 4. ⭐⭐ Exact authorization effect

| Element | Effect |
|---|---|
| ⭐ Roles receiving `READ` | ⛔⛔ **NONE** |
| ⭐ Roles receiving any other action class | ⛔⛔ **NONE** |
| ⭐ `PERM-*` created, reserved, minted or implied | ⛔⛔ **ZERO** — ⭐ `AUTH-7.22` remains **CLOSED AT ZERO** |
| ⭐ Roles created | ⛔ **ZERO** |
| ⭐ Scope classes created | ⛔ **ZERO** |
| ⭐ Action classes created | ⛔ **ZERO** |
| ⭐ UI / read surface created | ⛔ **ZERO** |
| ⭐ `BC-24` capability ownership | ⭐⭐ **PRESERVED UNCHANGED** *(`AUD-FR-002`)* |
| ⭐ `AUD-XC-005` prohibition | ⭐⭐ **PRESERVED UNCHANGED** |
| ⭐ Existing `AUD-*` requirements | ⛔ **0 amended** |
| ⭐ Existing `CNF-*` requirements | ⛔ **0 amended** |
| ⭐ Net change to the authorization state of the repository | ⭐⭐ **ZERO.** ⛔ What changes is that an **open question is now a recorded determination** |

⭐⭐ **Field 5 — does a V1 `READ` surface exist? ⛔⛔ NO.**
⭐⭐ **Field 6 — is any `PERM-*` created? ⛔⛔ NO.**

---

## 5. ⚠️ Consequences for `DD-0007` — ⛔ recorded, NOT applied here

⭐ `DD7-GAP-008` is **answered**, and surface `C-4` *"Change history"* is consequently
**not designable in V1** — ⛔ because there is lawfully **nothing for a tenant user to
read**, ⛔ not because a decision is missing.

⚠️⚠️ **This ADR does NOT amend `DD-0007`.** ⭐ Applying it is a separate **Design
Documentation Owner** act, as `ADR-0164` → `DD-0007` v1.1 already established. ⛔ **This
ADR decides nothing about `DD-0007`'s counts, version, surface tally or design-readiness
verdict** — ⭐ and in particular, ⛔ **it does not make `DD-0007` design-ready**, since
[`DDR-0025`](../../design/design-decisions/DDR-0025-c4-c5-binding-blocker-diagnosis.md)
records that **3 of 5** surfaces, **13** `DD7-GAP-*`, `DBT-001` and `DD7-GAP-009` stand
independently.

⭐ **Also unchanged:** ⛔ the **9** held `BC-25` parameters *(still **9**; coverage still
**95 / 104**)* · ⛔ `C-5` / APP 3 *(out of scope)* · ⛔ `LR-01`.

---

## 6. ⭐⭐ Authority

| Office | Limb exercised | Basis |
|---|---|---|
| ⭐⭐ **Authorization Owner** | ⭐ **The authorization determination** — that no role receives `READ` and no permission is created | `PRD_OWNERSHIP_MODEL` **§16.1**; constituted by `Accepted` **`ADR-0159`**; `BC-18` owns authorization semantics *(`AUD-XC-005` routes here by name)* |
| ⭐⭐ **`PRD-016` / `BC-24` Owner** | ⭐ **The capability limb** — confirming that the audit query capability is `BC-24`'s, that no `AUD-PO-*` register exists, and that ownership is **preserved** | `PRD-016` `AUD-FR-002`; `PRD-023` `CNF-XC-010` names `BC-24` / `PRD-016` as owner |

### 6.1 ⭐⭐ Why the joint form was structurally necessary

⭐ Neither office could have decided this alone, and the reason is in the sources:

* ⛔ **`BC-18` alone cannot grant a query it does not own** — `AUD-FR-002` vests *"audit
  query"* in `BC-24`.
* ⛔ **`BC-24` alone may not decide access** — `AUD-XC-005` forbids it *"make, store, cache
  or evaluate an authorisation decision."*

⭐⭐ **A single-office conferral for this question would have had to be refused.** ⭐ The
joint form resolves it without either office exceeding its mandate: ⭐ the `BC-24` Owner
speaks to the **capability**, the Authorization Owner to the **allocation**. ⛔⛔ **The
`BC-24` Owner's participation is expressly NOT an authorization act** — ⭐ which is why
`AUD-XC-005` survives this ADR intact *(§3 limb 3)*.

---

## 7. ⛔⛔ What this ADR does **not** do

⛔ **0** permissions, `PERM-*`, roles, action classes, scope classes or read surfaces
created · ⛔ **0** PRDs amended *(`PRD-016`, `PRD-023`, `PRD-001` all **byte-unchanged**)* ·
⛔ **0** existing ADRs amended · ⛔ **0** architecture, BC Map, edge or event changes ·
⛔ **`DD-0007` NOT modified** · ⛔ **APP 3 not authorized, not discussed as a dependency,
expressly OUT OF SCOPE** · ⛔ `CFG-12` **not reopened** *(`ADR-0165` stands)* · ⛔ `SCFG-2`
**not reopened** *(`ADR-0166` stands)* · ⛔ `SEAT-CFG-017` **not decided** · ⛔ `CFG-10`,
`SCFG-4` and the 4 Face `ATT-CFG-*` **untouched** · ⛔ **no external/legal hold resolved**
*(`LR-01` remains **PERMANENTLY OPEN**)* · ⛔ `AUD-GAP-003`, `AUD-GAP-004` and `D-016-01`
**remain OPEN** · ⛔ **no code** · ⛔ **no commit, no push**.

⚠️ **One boundary worth stating precisely:** ⭐ this ADR concerns **configuration** audit
entries — the `C-4` question. ⛔⛔ **It decides nothing about reading `BC-24` entries for
other subject matter** *(authentication, attendance, financial and so on)*, each of which
would need its own act.

---

## 8. ⭐⭐ Conferral and reversion

| Field | Value |
|---|---|
| **Form** | ⭐⭐ **JOINT single-act conferral** of the **Authorization Owner** and **`PRD-016` / `BC-24` Owner** offices, from the human principal, this turn |
| **Scope** | ⭐ *"only for this question"* — ⛔ `DD7-GAP-008` / `C-4` |
| ⛔ **Not claimed** | ⛔ **No independent review is claimed** — expressly so stated. ⛔ Not Product Owner, Architecture Owner, Privacy Owner, Security Platform, Design Documentation Owner, UX Architecture Owner, Technical Owner or Founder/Product Authority |
| ⛔ **Not reused** | ⛔ `ADR-0165`/`0166` *(single-office Authorization Owner, **spent**)* · ⛔ `ADR-0154`/`0155`/`0162`/`0164` · ⛔ `ADR-0167`/`0170` *(Architecture)* · ⛔ `ADR-0168`/`0169` *(Product)* · ⛔ `DDR-0021`…`DDR-0025` design-office conferrals · ⛔ the `DD-0007` **v1.2** currency conferral *(all spent)* |
| ⭐⭐ **Reversion** | ⭐⭐ **Reverts on completion of this act** — the issuance of this ADR. ⛔⛔ **Applying this to `DD-0007`, registering it in `ADR-INDEX`, deciding any other hold, or revisiting this question requires a NEW conferral or the competent office** |

### 8.1 ⭐ The conferral, recorded

> *"I confer JOINTLY: 1. the Authorization Owner office, and 2. the PRD-016 / BC-24 Owner
> office for the single act of deciding the authorization question identified as
> DD7-GAP-008 / C-4. Question: Should any existing tenant role have a READ surface for
> BC-24 configuration audit entries in V1? The decision must explicitly permit the outcome:
> NO V1 READ SURFACE if the evidence does not justify allocating READ. … This is a single
> joint authorization decision act. Both offices are being conferred only for this question.
> The conferral reverts on completion. No independent review is claimed."*

⭐ **All nine required statements are present:** question **§1** · evidence **§2** ·
decision **§3** · authorization effect **§4** · V1 read surface exists? **§4** · any
`PERM-*`? **§4** · boundaries/exclusions **§7** · authority and conferral **§6**, **§8** ·
unresolved conditions **§9**.

---

## 9. ⚠️ Unresolved conditions — ⛔ preserved, NOT resolved

| # | Condition | Owning office |
|---|---|---|
| **1** | ⭐⭐ **Whether a configuration-history reader should exist in a LATER release.** ⛔ This ADR decides **V1 only**. ⭐ A V2 reader would need an operation register, an action class and a scope class — ⛔ **none of which exists today** | **Product Owner** *(need)* → **Authorization Owner** + **`BC-24` Owner** *(allocation)* |
| **2** | ⛔ **`D-016-01`** — `AuditTrail.recent()` / `count` expose cross-tenant reads in shipped code, against `AUD-FR-016`. ⚠️⚠️ **This determination makes the defect MORE conspicuous, ⛔ not less**: with **no** authorized tenant reader, an existing unconfined read surface has **no lawful basis at all** | **Technical Owner** *(repair)*; `BC-24` Owner *(requirement)* |
| **3** | ⛔ **`AUD-GAP-003`** *"Legal hold" has no defined mechanism* | **SECURITY + DATA Governance** |
| **4** | ⛔ **`AUD-GAP-004`** Support-access action list undefined | **`BC-24` Owner** + Product |
| **5** | ⚠️ **`DD-0007` L1580** classifies `C-4` as *"Open **Product** Decision"* while **L1514** correctly routes it to *"Authorization Owner + `PRD-016` Owner"*. ⭐⭐ **This ADR settles the question in L1514's terms** and ⛔ leaves the stale cell for its owner | **Design Documentation Owner** |
| **6** | ⭐ Applying this ADR to `DD-0007` *(a v1.3 currency act)* and registering it in `ADR-INDEX` | **Design Documentation Owner** · **Governance Owner** |
| **7** | ⚠️ Whether §2B.5 design-readiness should require a surface that has **no lawful V1 reader** — ⭐ the sibling of the `C-5` question at `DDR-0025` §B.3 | **Design Governance Owner** |

⛔⛔ **None of the seven is decided, narrowed or reassigned here.**

---

## 10. ⭐ Evidence — exact citations

| # | Source | Locus | Proposition |
|---|---|---|---|
| 1 | `PRD-023` | **L924** `CNF-BR-006` | History **SHALL** be reconstructible from the audit trail; ⛔ no second history |
| 2 | `PRD-023` | **L922** `CNF-XC-010` | `BC-25` **MUST NOT** query audit entries; owner **`BC-24`** |
| 3 | `PRD-016` | **L119** `AUD-FR-002` | `BC-24` **SHALL** own audit query |
| 4 | ⭐⭐ `PRD-016` | **L271** `AUD-XC-005` | ⭐⭐ `BC-24` **MUST NOT** evaluate an authorization decision; owner **`BC-18`** |
| 5 | `PRD-016` | §0.3 **L44–48** | ⛔ **No `AUD-PO-*` register exists** |
| 6 | ⭐ `PRD-016` | measured | ⛔⛔ **0** occurrences of `TR-1`/`TR-2`/`TR-3` |
| 7 | `PRD-016` | **L242–250** `AUD-FR-014`…`016` | Tenant **confinement**, ⛔ not allocation |
| 8 | ⭐ `PRD-001` | **L4047** `AUTH-10.23` | *"only… own context"* — ⭐ a **confinement** rule; ⛔ **0** roles named |
| 9 | `PRD-001` | **L4048** `AUTH-10.26` | Authentication **MUST NOT** own audit query |
| 10 | ⭐⭐ `PRD-001` | **L2336** `AUTH-7.22` | ⭐⭐ Permission catalogue **CLOSED**; enumerated permissions **ZERO** |
| 11 | `PRD-001` | `AUTH-7.23` | A permission without a scope class **is invalid** |
| 12 | ⭐⭐ `PRD-001` | **L2263** `AP-3` | ⭐⭐ *"Absence of an explicit grant is **refusal**"* |
| 13 | `PRD-001` | **L2264** `AP-4` | ⛔ No derivation from naming, hierarchy, seniority or similarity |
| 14 | `PRD-001` | **L2363** `AUTH-7.24` · **L2394** `AUTH-7.28` | Action classes independent; ⛔ no permission hierarchy |
| 15 | `PRD-016` | **L336** `D-016-01` | Existing cross-tenant read is a **defect**, ⛔ not a precedent |
| 16 | `PRD-016` | **L253** | `AUD-FR-016` *"contradicts existing code, **deliberately**"* |
| 17 | ⭐ `ADR-0164` | Outcome B | ⭐ Precedent: discharge **by determination**, ⛔ **0** `PERM-*` |
| 18 | `DDR-0025` | §A | The diagnosis this ADR answers |

---

## 11. Change history

| Version | Date | Change |
|---|---|---|
| ⭐ **1.0** | 2026-09-19 | ⭐⭐ **Created and `Accepted`. Decides `DD7-GAP-008` / `C-4`: ⛔⛔ NO V1 READ SURFACE for `BC-24` configuration audit entries — no tenant role receives `READ`, and ⛔ 0 `PERM-*`, roles, scopes, action classes or read surfaces are created.** ⭐⭐ **The evidence made the outcome, ⛔ not a preference**: `PRD-016` measured ⛔⛔ **ZERO** `TR-1`/`TR-2`/`TR-3` occurrences and ⛔⛔ **no `AUD-PO-*` register at all**, so ⭐ **there was no operation to allocate and no role named to receive it**; `AUTH-7.22`'s catalogue is ⛔ **CLOSED at zero enumerated permissions**; and the only `PERM-*` in the repository is **`PERM-PARTICIPATE`**, ⛔ unrelated and ⛔ un-repurposable *(`AP-4`)*. ⭐⭐ **THE STRUCTURAL CORE: `AUD-FR-002` vests "audit query" in `BC-24` while `AUD-XC-005` FORBIDS `BC-24` from evaluating any authorization decision, routing that to `BC-18` by name** — ⭐⭐ so **owning a capability is not allocating it**, and the gap is the **designed consequence of a separation of concerns**, ⛔ not an oversight in either module. ⚠️⚠️ **`AUTH-10.23` WAS CONFRONTED AS THE STRONGEST CANDIDATE GRANT AND REFUSED ON FOUR MEASURED GROUNDS** *(§2.3)* — *"A library MUST be able to view audit **only** for actions within its own context"*: ⛔ it names **0** roles *("a library" is a **tenant**, not a role)*, ⛔ **0** action classes, ⛔ **0** scope classes *(`AUTH-7.23`: a permission without one **is invalid**)*, ⭐⭐ its operative word ***"only"*** makes it a **CONFINEMENT rule, not a grant**, and ⛔ it sits in the **authentication** auditable-action list, not configuration — ⭐ with `AUTH-10.26` on the **next line** *("Authentication MUST NOT own audit storage, retention or query")* confirming `PRD-001` is **disclaiming** the surface, ⛔ not conferring it. ⭐⭐ **`AP-3` SUPPLIES THE ANSWER, NOT MERELY A TIE-BREAK** — *"Absence of an explicit grant is **refusal**"* — so ⭐ the measured absence **is** the decision. ⭐ **SEVEN OPTIONS DISPOSED** *(§3.1)*, ⚠️ including allocation to `TR-1`, to `TR-1`+`TR-2` *(⛔ would imply a hierarchy, `AUTH-7.28`)*, reliance on `AUTH-10.23`, repurposing `PERM-PARTICIPATE`, ⛔ and **DEFERRAL — refused as the evasive outcome**, since the conferral asked for a decision and `AP-3` already answers it. ⛔⛔ **EXISTING CODE WAS EXPRESSLY NOT TREATED AS AUTHORIZATION** — `D-016-01` records `AuditTrail.recent()`/`count` exposing **cross-tenant** reads with callers in `ops_page.dart`, and `PRD-016` **L253** already says `AUD-FR-016` *"contradicts existing code, **deliberately**"*; ⭐⭐ **an unlawful read surface is a DEFECT, ⛔ not a precedent**, and the conferral barred inferring authority from *"UI presence… or enforcement references."* ⚠️⚠️ **THE DETERMINATION MAKES `D-016-01` MORE CONSPICUOUS, ⛔ NOT LESS** — ⭐ with **no** authorized tenant reader, an unconfined read surface now has ⛔ **no lawful basis at all** *(§9 condition 2)*. ⭐⭐ **FOUR PRESERVATIONS STATED POSITIVELY** *(§3)*: `BC-24`'s **capability ownership PRESERVED** *(`AUD-FR-002` untouched)* · `AUD-XC-005`'s **prohibition PRESERVED and HONOURED** — ⭐ the `BC-24` Owner spoke to the **capability**, the Authorization Owner to the **allocation**, so ⛔ **no authorization act was performed by `BC-24`** · **audit RECORDING entirely unchanged** *(`E-20`, immutability, tenant confinement, retention)* — ⭐⭐ **configuration changes are still audited; only a tenant-facing *reader* is withheld** · and ⭐⭐ **`CNF-BR-006` is SATISFIED, not breached** — it requires history be *"**reconstructible** from the audit trail"*, the entries **exist and are reconstructible**, and ⛔ reading a reconstructibility guarantee as a **UI mandate** would be the inference `AP-4` forbids. ⭐⭐ **THE JOINT FORM WAS STRUCTURALLY NECESSARY, ⛔ NOT STYLISTIC** *(§6.1)* — ⛔ `BC-18` alone cannot grant a query it does not own; ⛔ `BC-24` alone may not decide access; ⭐ **a single-office conferral would have had to be refused**. ⭐ **PRECEDENT: `ADR-0164` Outcome B** — ⭐⭐ a surface can be discharged **by being DECIDED, ⛔ not only by being GRANTED**. ⭐ **SEVEN UNRESOLVED CONDITIONS PRESERVED** *(§9)*. ⛔ **APP 3 expressly OUT OF SCOPE and not relied on anywhere** · ⛔ `CFG-12` and `SCFG-2` **NOT reopened** *(`ADR-0165`/`0166` stand)* · ⛔ `SEAT-CFG-017` **not decided** · ⛔ **9 holds still 9; coverage still 95/104** · ⛔ `LR-01` **PERMANENTLY OPEN** · ⛔ **`DD-0007` NOT modified** — ⭐ applying this is a **Design Documentation Owner** act, and ⛔⛔ **this ADR does NOT make `DD-0007` design-ready** *(3 of 5 surfaces, 13 `DD7-GAP-*`, `DBT-001`, `DD7-GAP-009` stand independently)* · ⛔ **0 PRDs, 0 ADRs, 0 architecture modified** · ⛔ **0 code** · ⛔ **no commit, no push**. ⭐⭐ **The joint conferral has REVERTED ON COMPLETION.** |
