# DP-0003 — Owner Decision Request: the **5 internally decidable** `BC-25` tracks

| Field | Value |
|---|---|
| **Document** | ⭐ **Owner Decision Request** — reusing the repository's established *Pack → Request* pattern *(`PRD-006_ATT-GAP-017_OWNER_DECISION_REQUEST`)* |
| **Version** | v1.0 |
| **Date** | 2026-09-19 |
| **Status** | ⛔ **OPEN** · ⛔ **0 responses received** |
| **Scope** | ⭐ **5 tracks** — `B-1′` · `B-2` · `B-3` · `B-7` · `B-8` · ⭐ **19 parameters** |
| ⛔ **Out of scope** | ⛔⛔ **`B-5`, `B-6`, `B-10` are NOT addressed here** — ⭐ they require an **external** principal *(`DP-0002` Part B)*. ⛔ **Untouched by this sheet.** |
| **Source** | ⭐ `DP-0002` *(the authoritative decision-request pack)* · `Accepted` `ADR-0161` §7 |
| **Values / allocations proposed here** | ⛔⛔ **ZERO** |

> ⭐⭐ **Why this document exists.** `DP-0002` states **8** blockers across two parts.
> ⭐ **5 of them are decidable today by offices that already exist**, with **no**
> dependency on each other and **no** external input. ⭐ This is the owner-facing
> request that stops each decision **at its owner boundary**.
>
> ⛔⛔ **It decides nothing, proposes nothing, and changes no count.** ⭐ Coverage
> stays **79 / 104**; ⛔ **D3 `PARTIAL`**; ⛔ **`DD-0007` NOT design-ready.**

---

## 0. ⛔⛔ Constraints binding every answer

⭐ Reproduced from `DP-0002` §0 because they govern these five exactly as they govern all eight.

| # | Constraint | Source |
|---|---|---|
| 1 | ⛔ Platform roles **closed at TWO** *(`PR-1`, `PR-2`)*; library roles **closed at FIVE** *(`TR-1`…`TR-5`)* | `AUTH` ch.07 **L79**, **L87** |
| 2 | ⛔⛔ **Permission catalogue CLOSED at ZERO** — *"A permission not declared in it **cannot be granted**"* | **`AUTH-7.22`** *(**L2336**)*, `ADR-0132` |
| 3 | ⛔ **`READ` and `WRITE` independent** — *"Each action class **MUST** be granted independently. Read **MUST NOT** imply any other action"* | **`AUTH-7.24`** *(**L2363**)*, `CNF-BR-010` |
| 4 | ⛔ **No hierarchy** — *"Permissions **MUST NOT** form a hierarchy. No permission implies another."* | **`AUTH-7.28`** *(**L2394**)* |
| 5 | ⛔ **Frozen PRDs MUST NOT be amended** to fit a decision | `ADR-INDEX` process |
| 6 | ⛔ **The 104 inventory MUST NOT change** | standing |
| 7 | ⚠️ ⚪ **`N/A` ≠ ⛔ `DENY`** | `ADR-0151` §3.5 · `ADR-0155` `S-4` |
| 8 | ⭐⭐ **`HOLD` is a correct, respected answer.** ⛔ **Do NOT decide to reach 104/104** | standing |
| 9 | ⭐ An office is exercised by **ONE-ACT CONFERRAL**, ⛔ **not by appointment**; ⛔ **no personal name may be recorded** | `PRD_OWNERSHIP_MODEL` **§12.1**, §7 rule 4 · `ADR-0033` §7.1 |

⚠️ **On constraint 9:** ⭐ every office below is **VACANT**, and that is the **normal**
state — `ADR-0161` withdrew the contrary claim. ⛔ **No appointment is requested.**

---

## 1. ⭐ The five tracks at a glance

| Track | Decision required | Owner | Decidable today? | Blocked by | Params |
|---|---|---|---|---|---:|
| **`B-1′`** | Character of a capability-conferring config write, + `READ` | **Authorization Owner** | 🟡 **Partially** — ⚠️ `CFG-12` limb engages `B-6` | ⛔ Nothing for 5 of 6 | **6** |
| **`B-2`** | Name `SCFG-2`'s review authority | **Authorization Owner** | 🟢 **Yes** | ⛔ Nothing | **1** |
| **`B-3`** | `ICFG` `READ` + commercial classification | **Product Owner + SECURITY PLATFORM** | 🟢 **Yes** | ⛔ Nothing | **10** |
| **`B-7`** | Is `enrollmentNumber` human-meaningful? | **Product Owner** *(sole)* | 🟢 **Yes** | ⛔ Nothing | **1** |
| **`B-8`** | Stage-3 confirmation of the `E-05` addition | **`PRD-002` Domain Owner (Library Domain) + Product Owner** | 🟢 **Yes** | ⛔ Nothing | **1** |

⭐⭐ **All five are mutually independent** — ⛔ **none blocks another**, and they may be
answered **in any order, by different offices, simultaneously.**

---

## 2. Track `B-1′` — **Authorization Owner**

### 2.1 The question, in one sentence

> ⭐⭐ **Where a configuration parameter's value determines whether a role may perform an
> operation, is writing that parameter a *configuration* act or an *authorization* act —
> and if it may be allocated, who may `READ` these six?**

### 2.2 Authority required

⭐ **Authorization Owner** — `PRD_OWNERSHIP_MODEL` **§16** *(constituted by `ADR-0159`)*, exercised by **one-act conferral**.

### 2.3 Exact evidence *(re-read, verbatim)*

| Source | Text |
|---|---|
| `PRD-006` §19.2 **L1980** | *"Corrections (§18) \| `reception`, `manager` — **subject to `ATT-CFG-022`** \| `tenantWide`"* |
| `PRD-006` §19.2 **L1983** | *"View guarded students' attendance \| `parent` — **subject to `ATT-CFG-024`** \| `guardianOf`"* |
| ⭐⭐ `PRD-007` **L1975** *(the legend)* | *"**Y** permitted · **—** denied · **C** **permitted only where the named configurable grants it**."* |
| `PRD-007` **L1991** | `SEAT-PO-007` Cancel another student's reservation — Reception = **`C (SEAT-CFG-014)`** |
| `PRD-007` **L1994** | `SEAT-PO-010` Override a lock — Manager = **`C (SEAT-CFG-005)`** |
| ⛔ `AUTH-7.22` **L2336** | *"The permission catalogue **MUST** be closed. A permission not declared in it **cannot be granted**"* |

⭐ **The legend is the crux:** `C` means the operation is permitted **only where the named
configurable grants it** — ⭐ so **the parameter *is* the grant.**

### 2.4 ⭐ Allowed decision choices *(from existing governance only)*

| # | Choice | What it would mean |
|---|---|---|
| **(a)** | ⭐ **CONFIGURATION act** | The write is ordinary configuration; allocate `READ`/`WRITE` per the normal bands |
| **(b)** | ⭐ **AUTHORIZATION act** | The write exercises authority over role capability; ⛔ **it may not be allocated as ordinary configuration** and stays **HELD** |
| **(c)** | ⭐ **BOTH** | Allocable, ⚠️ but only with an express statement of the additional control that applies |
| **(d)** | ⛔ **HOLD** | ⭐ A correct and complete answer |

⛔⛔ **A fifth option — inventing a permission to represent the capability — is NOT
available:** `AUTH-7.22` closes the catalogue at **zero**.

### 2.5 ⛔ The decision MUST NOT

⛔ Create any `PERM-*`, role, action class or scope class · ⛔ create a role hierarchy
*(`AUTH-7.28`)* · ⛔ read `WRITE` as implying `READ`, or the reverse *(`AUTH-7.24`,
`CNF-BR-010`)* · ⛔ amend any frozen PRD · ⛔ extend `ADR-0153`'s **17-parameter**
allocation by analogy · ⛔ alter the **15** authorized `SEAT-CFG-*` *(`ADR-0157`)*.

### 2.6 Parameters affected — **6**

`ATT-CFG-022` · `ATT-CFG-023` · `ATT-CFG-024` · `SEAT-CFG-005` · `SEAT-CFG-014` · ⚠️ `CFG-12`

⚠️⚠️ **Two matters the answer should address expressly:**
1. ⭐ **`ATT-CFG-022` and `ATT-CFG-023` may not be safely separable** — `023`
   **time-bounds** the capability `022` gates, so permitting corrections while setting the
   window to `0` would nullify the grant while appearing to confer it. ⭐ Please answer
   them **together**, or state expressly that they may diverge.
2. ⚠️ **`CFG-12` carries a second limb** — it is **self-referential** *(it bounds `PR-2`'s
   own elevation ceiling)* and its **owner of record is *"Security + Legal"***, which
   engages ⛔ **`B-6`** *(external)*. ⭐ **It may not be fully answerable here** — please
   state if you consider it out of scope for this track.

### 2.7 ⭐ Decision template

> **`B-1′` — DECISION (Authorization Owner).**
>
> The character of a configuration write that determines a role's capability is:
> ☐ (a) CONFIGURATION ☐ (b) AUTHORIZATION ☐ (c) BOTH ☐ (d) HOLD
>
> Reasoning / authority relied on: ______________________________________
>
> If (a) or (c), the allocation is:
> · `ATT-CFG-022` — SCOPE: ______ READ: ______ WRITE: ______ COMMERCIAL: ______
> · `ATT-CFG-023` — SCOPE: ______ READ: ______ WRITE: ______ COMMERCIAL: ______
> · `ATT-CFG-024` — SCOPE: ______ READ: ______ WRITE: ______ COMMERCIAL: ______
> · `SEAT-CFG-005` — SCOPE: ______ READ: ______ WRITE: ______ COMMERCIAL: ______
> · `SEAT-CFG-014` — SCOPE: ______ READ: ______ WRITE: ______ COMMERCIAL: ______
> · `CFG-12` — ☐ decided as above ☐ **out of scope — routed to `B-6`** ☐ HOLD
>
> `ATT-CFG-022` / `023`: ☐ answered together ☐ **may diverge** — because: ____________
>
> I confirm: ⛔ no `PERM-*`, role, action class or scope class is created; ⛔ `READ` was
> decided **independently** of `WRITE` (`CNF-BR-010`); ⛔ no frozen document is amended.
>
> Authorization Owner *(one-act conferral)*: ______________________ Date: __________

---

## 3. Track `B-2` — **Authorization Owner**

### 3.1 The question, in one sentence

> ⭐ **Who is the authority that performs the "review" `SCFG-2` requires before a reserved
> username may be removed?**

### 3.2 Authority required

⭐ **Authorization Owner** *(one-act conferral)* — ⭐ as already routed by `ADR-0155` **`S-3`**.

### 3.3 Exact evidence *(re-read, verbatim)*

| Source | Text |
|---|---|
| `Student_Identity_PRD_v1` §5.5 **L1336** | `\| SCFG-2 \| Reserved-username list \| Platform-managed list \| — \| ` ⭐ **"Additive only; removing an entry requires review"** |
| ⭐ `SID-5.45` **L1350** | *"Every value above **SHALL** be platform-wide. **None SHALL be organisation-configurable**"* |
| ⛔ `ADR-0155` `S-3` | *"Do **NOT** infer the reviewer from `TR-1`/`TR-2`/`PR-1`/`PR-2` naming, ownership, hierarchy, or UI visibility."* |

⛔⛔ **The source states the obligation and omits the actor.** ⭐ That omission is the blocker.

### 3.4 ⭐ Allowed decision choices

| # | Choice |
|---|---|
| **(a)** | ⭐ **Name an existing office** as the review authority, and allocate `SCFG-2` |
| **(b)** | ⭐ **Name an existing role** *(from the closed `PR-n`/`TR-n` sets)* |
| **(c)** | ⛔ **HOLD** — ⭐ expressly permitted by `S-3`: *"If the Authorization Owner cannot identify an authoritative role, keep `SCFG-2` **HELD**."* |

### 3.5 ⛔ The decision MUST NOT

⛔⛔ **Infer the reviewer** from naming, ownership, hierarchy or UI visibility *(`S-3`)* ·
⛔ create a new role or `PERM-*` · ⛔ reopen the **9** `SCFG-*` allocated by `ADR-0155` ·
⛔ weaken `SID-5.45`'s platform-wide rule.

### 3.6 Parameters affected — **1**

`SCFG-2`

### 3.7 ⭐ Decision template

> **`B-2` — DECISION (Authorization Owner).**
>
> ☐ (a)/(b) The review authority for `SCFG-2` is: ______________________________
>   Authority relied on *(cite the source that confers it)*: __________________
>   Allocation — SCOPE: ______ READ: ______ WRITE: ______ COMMERCIAL: ______
> ☐ (c) **HOLD** — no authoritative role can be identified *(`S-3`)*
>
> I confirm the reviewer was **named from an authoritative source**, ⛔ **not inferred**
> from naming, ownership, hierarchy or UI visibility.
>
> Authorization Owner *(one-act conferral)*: ______________________ Date: __________

---

## 4. Track `B-3` — **Product Owner + SECURITY PLATFORM**

### 4.1 The question, in one sentence

> ⭐ **Who may READ `ICFG-1`…`ICFG-10`, and are they `COMMERCIAL` or `NOT COMMERCIAL`?**

### 4.2 Authority required

⭐ **Product Owner + SECURITY PLATFORM**, **jointly** — ⭐ the pairing `ADR-0154` §7 names.

### 4.3 Exact evidence *(re-read)*

⛔⛔ **The question exists because the sources are SILENT.**

| Dimension | Measurement |
|---|---|
| ⛔ `READ` statements | **0** across `INVITATION_SECURITY_SPECIFICATION` §11 and `CONFIGURATION_GUIDE` §2B |
| ⛔ Commercial statements | **0** |
| ⭐ Roles named in the owning spec | `TR-1`×6 · `TR-2`×6 · `TR-3`×3 · ⛔ **`PR-1`/`PR-2` = ZERO** |
| ⭐ The only role text is a **prohibition** — `INV-SEC-018` **L175** | *"An expired invitation **MUST** be refused, and refusal **MUST NOT** be overridable by **any library role, including `TR-1` Owner**."* |
| `INV-SEC-019` **L178** | *"Expiry **MUST NOT** be extendable."* |
| ⭐ Register character | `CONFIGURATION_GUIDE` §2B — *"**Every parameter in this register is security-owned.** There is no locale or cosmetic value here."* |

⭐⭐ **TWO DIMENSIONS ARE ALREADY DETERMINED AND ARE ⛔ NOT REOPENED** — `ADR-0154` §7:

| Dimension | Determined value | Basis |
|---|---|---|
| ⭐ **Scope** | **`Platform default`** | **10 of 10** in the §4 env-profile table *(**L806**–**L815**)*; ⛔ the per-library carve-out at **L829** names **only** `LCFG-*` |
| ⭐ **`WRITE`** | ⚪ **`N/A`** *(none storable)* | `CNF-FR-028`; ⛔ *"tenant-settable"* declared **0** times |

### 4.4 ⭐ Allowed decision choices

| Limb | Choices |
|---|---|
| **`READ`** | ⭐ **(a)** `PR-1` + `PR-2` · **(b)** a named subset of `TR-n` · **(c)** ⚪ `N/A` *(**only** with express reasoning — see below)* · **(d)** ⛔ **HOLD** |
| **Commercial** | ⭐ **(a)** `NOT COMMERCIAL` · **(b)** `COMMERCIAL` · **(c)** ⛔ **HOLD** |
| **Per-parameter** | ⚠️ Flag any needing different treatment — ⭐ `ICFG-8` *("**is what makes 40 bits sufficient**")* and `ICFG-10` *("Matches `CFG-4`")* are the likely candidates |

⚠️⚠️ **On `READ` = ⚪ `N/A`:** ⛔ it **cannot** be adopted "by symmetry with `WRITE`". ⭐ ⚪
`N/A` on write rests on `CNF-FR-020`, a **write-only** rule, and `ADR-0154` established
that a **read** surface breaches none of the scope-1 prohibitions. ⛔ **Choosing it
requires its own reasoning.**

### 4.5 ⛔ The decision MUST NOT

⛔⛔ **Re-decide scope or `WRITE`** *(already determined — §4.3)* · ⛔⛔ **derive `READ`
from `WRITE`** *(`CNF-BR-010`, `AUTH-7.24`)* · ⛔ treat a denial of `TR-n` as a grant to
`PR-n` *(`AUTH-7.28`)* · ⛔ treat *"Matches `CFG-4`"* as an authority statement — ⭐ it is a
**value** rationale · ⛔ record ⚪ `N/A` as ⛔ `DENY`.

⭐⭐ **One prior refusal needs your express ruling.** `ADR-0158` §2.4b **refused** the
argument that `READ` = `PR-1`+`PR-2` follows from *"every parameter in this register is
security-owned"*; `ADR-0160` **confirmed** that refusal. ⭐ **Please confirm it again, or
overrule it with express authority.**

### 4.6 Parameters affected — **10**

`ICFG-1` · `ICFG-2` · `ICFG-3` · `ICFG-4` · `ICFG-5` · `ICFG-6` · `ICFG-7` · `ICFG-8` · `ICFG-9` · `ICFG-10`

### 4.7 ⭐ Decision template

> **`B-3` — DECISION (Product Owner + SECURITY PLATFORM, jointly).**
>
> **`READ`** for `ICFG-1`…`ICFG-10`: ______________________________________
>   ☐ uniform across all ten ☐ exceptions: __________________________________
> **COMMERCIAL**: ☐ NOT COMMERCIAL ☐ COMMERCIAL ☐ HOLD
> Reasoning / authority relied on: ______________________________________
>
> On `ADR-0158` §2.4b's refusal of the `PR-n` argument:
>   ☐ **CONFIRMED** ☐ **OVERRULED** — express authority: ______________________
>
> ☐ **HOLD** — the register is not yet decidable, because: __________________
>
> I confirm: ⭐ scope (`Platform default`) and `WRITE` (⚪ `N/A`) are **taken as already
> determined** by `ADR-0154` §7 and were **not re-decided**; ⛔ `READ` was decided
> **independently** of `WRITE`; ⛔ no `PERM-*` or role is created.
>
> Product Owner: __________________ SECURITY PLATFORM: __________________ Date: ________

---

## 5. Track `B-7` — **Product Owner** *(sole)*

### 5.1 The question, in one sentence

> ⭐ **Is `enrollmentNumber` human-meaningful, and if so what is its format?**

### 5.2 Authority required

⭐ **Product Owner**, sole — ⭐ `PRD_OWNERSHIP_MODEL` §2.2: *"Decides whether a requirement
is correct and **in scope**."*

### 5.3 Exact evidence *(re-read, verbatim)*

| Source | Text |
|---|---|
| ⭐ `Student_Management_PRD_v1` **L1168** | `\| SM-GAP-2 \| enrollmentNumber format and whether it is human-meaningful \| ` ⭐ **"`SM-INV-1` requires uniqueness only. `SMCFG-5`'s default is a placeholder pending a decision"** |
| `SMCFG-5` register row **L1042** | `\| SMCFG-5 \| Enrollment number format \| tenant-prefixed sequence \| — \| Product \|` |
| ⭐ `SM-INV-1` **L312** | *"Unique `(tenantId, enrollmentNumber)`"* — ⭐ **uniqueness only**; ⛔ no format obligation |
| Corroboration | `PRD-004_TRACEABILITY` **L187** *("placeholder", "undecided")* · `DD-0002` **L158** *("no form")* · ⛔ **`SM-GAP-2` appears in ZERO ADRs** |

⭐⭐ **This is a *definition* question, not an authorization question.** ⛔ Authority cannot
be allocated over a parameter whose meaning is undecided.

### 5.4 ⭐ Allowed decision choices

| # | Choice |
|---|---|
| **(a)** | ⭐ **Human-meaningful = YES** + the format, stated explicitly |
| **(b)** | ⭐ **Human-meaningful = NO** — an opaque unique identifier; ⭐ the *"tenant-prefixed sequence"* default is then withdrawn or confirmed expressly |
| **(c)** | ⛔ **HOLD** — ⭐ a correct answer if the product decision is not ready |

### 5.5 ⛔ The decision MUST NOT

⛔ Weaken `SM-INV-1`'s **uniqueness** invariant · ⛔⛔ **ratify the current
*"tenant-prefixed sequence"* default by silence** — ⭐ the independent review holds that *"a
configurable **should not publish a default** for a parameter the document says is
undecided"* · ⛔ reopen the **6** `SMCFG-*` allocated by `ADR-0156` · ⛔ change the **104**
inventory · ⛔ amend FROZEN `PRD-004`.

### 5.6 Parameters affected — **1**

`SMCFG-5`

### 5.7 ⭐ Decision template

> **`B-7` — DECISION (Product Owner).**
>
> Is `enrollmentNumber` human-meaningful? ☐ **YES** ☐ **NO** ☐ **HOLD**
>
> If YES — the format is: ______________________________________________
> If NO — the current *"tenant-prefixed sequence"* default is:
>   ☐ confirmed as an opaque generation strategy ☐ **withdrawn** ☐ to be re-stated as: ______
>
> Basis for the decision: ______________________________________________
>
> I confirm: ⛔ `SM-INV-1`'s uniqueness invariant is unchanged; ⛔ no value is copied from
> another product, tenant or mode; ⛔ FROZEN `PRD-004` is not amended.
>
> Product Owner: ______________________ Date: __________

---

## 6. Track `B-8` — **`PRD-002` Domain Owner (Library Domain) + Product Owner**

### 6.1 The question, in one sentence

> ⭐ **Does the `E-05` contract carry the occupancy threshold — and if so, at what scope?**

### 6.2 Authority required

⭐ **`PRD-002` Domain Owner (Library Domain)** + **Product Owner**.
⭐ *Incumbent identified by measurement in `ADR-0160` §2.4:* `PRD_REGISTRY` **L456** maps
**`BC-06` → `PRD-002`**; `PRD_OWNERSHIP_MODEL` **L147** records its Domain Owner as
**Library Domain**.

### 6.3 Exact evidence *(re-read, verbatim)*

| Source | Text |
|---|---|
| ⭐⭐ `PRD-007` **`SEAT-FR-267`** | *"The occupancy threshold is a **proposed** addition to the `E-05` contract. Because `E-05`'s payload is fixed by the BC Map, that addition **MUST** be confirmed at **Stage 3** before implementation; it is recorded as **`SEAT-GAP-005`**. Until confirmed, no threshold is set and `SEAT-FR-241`'s unset behaviour applies — **no event is emitted, and no hard-coded value is substituted**."* |
| Register **L1918** | `SEAT-CFG-017` — owner **`BC-06` via `E-05`** · ⭐ *"**Unset in V1 — no event is emitted and no value is substituted**"* · **90%** *"applies only once `E-05` carries the threshold"* |
| `SEAT-FR-266` | ⭐ `E-05` is a **Conformist** edge — *"this module conforms and **MUST NOT** define its own copy, translate the value, cache it indefinitely, or offer a local override"* |
| ⚠️ `SEAT-XC-022` | *"Every configurable above is tenant-scoped, **or branch-scoped where `BC-06` owns it**"* — ⭐ **`SEAT-CFG-017` is its sole referent** |

⭐ **`SEAT-CFG-017` is the only one of the 18 `SEAT-CFG-*` not owned by `BC-25`.**

### 6.4 ⭐ Allowed decision choices

| # | Choice |
|---|---|
| **(a)** | ⭐ **CONFIRMED at Stage 3** — `E-05` carries the threshold; ⭐ then state the **scope**: ☐ `Tenant` ☐ `Branch` |
| **(b)** | ⭐ **NOT confirmed** — the addition is declined or deferred; ⛔ `SEAT-CFG-017` stays **unset** and **HELD** |
| **(c)** | ⛔ **HOLD** — Stage 3 cannot be reached today |

⭐ **On scope:** ⛔ **no new scope class is required.** ⭐ `Branch` is **already scope 4 of
five** in FROZEN `PRD-023` §3.1 **L377** — *"platform default → tenant → library → branch
→ user"*. ⭐ *(`ADR-0161` withdrew the earlier contrary claim.)*

### 6.5 ⛔ The decision MUST NOT

⛔⛔ **Apply the 90% figure as a fallback** — `SEAT-FR-241` and `SEAT-AC-170` forbid it in
terms · ⛔ alter `E-05`'s **Conformist** character · ⛔ define a local copy or override
*(`SEAT-FR-266`)* · ⛔ reopen the **15** `SEAT-CFG-*` authorized by `ADR-0157` · ⛔ amend
FROZEN `PRD-007` or the BC Map.

### 6.6 Parameters affected — **1**

`SEAT-CFG-017`

### 6.7 ⭐ Decision template

> **`B-8` — DECISION (`PRD-002` Domain Owner + Product Owner).**
>
> Does `E-05` carry the occupancy threshold?
>   ☐ (a) **CONFIRMED at Stage 3** → scope: ☐ `Tenant` ☐ `Branch`
>   ☐ (b) **NOT confirmed** — declined / deferred
>   ☐ (c) **HOLD**
>
> If confirmed — allocation for `SEAT-CFG-017`:
>   SCOPE: ______ READ: ______ WRITE: ______ COMMERCIAL: ______
>
> Basis / Stage-3 evidence: ______________________________________________
>
> I confirm: ⛔ the **90%** figure is **not** applied as a fallback; ⛔ `E-05`'s Conformist
> character is unchanged; ⛔ no local copy or override is defined; ⛔ no frozen document
> is amended.
>
> `PRD-002` Domain Owner: ______________ Product Owner: ______________ Date: ________

---

## 7. ⛔ Consequence of not deciding

| Consequence | Detail |
|---|---|
| ⛔ **D3 stays `PARTIAL`** | ⭐ **79 / 104**; ⛔ **19** of the 25 held parameters sit in these five tracks |
| ⛔ **`DD-0007` cannot become design-ready** | ⭐ **D3 is the sole remaining declaration blocker** |
| ⛔ `DP-0001` and `DP-0002` stay **OPEN** | ⛔ **0** authority responses to date |
| ⚠️ The external path does **not** advance either | ⭐ `B-5`/`B-6`/`B-10` are independent of these five — ⛔ deciding these does **not** unblock those, and **vice versa** |

⭐⭐ **But note what deciding these five would NOT do:** ⛔ even if **all five** resolved
favourably, **6 parameters** would remain held behind `B-5`/`B-6`/`B-10`, and ⛔
**`ATT-CFG-014` cannot reach `AUTHORIZED` this cycle at all** *(outside V1 by `D-3a`,
Face = **V3**)*. ⛔ **104/104 is not reachable in this cycle.**

---

## 8. ⭐ Return handling

⭐ Answers may be returned **individually** — ⭐ each track is recorded the moment it
arrives, in its own ADR, registered in `ADR-INDEX`, reflected in `DD-0007` and validated.

### 8.1 ⛔ What will NOT be done on receipt

⛔ Nothing inferred beyond what is written · ⛔ no answer carried between tracks · ⛔ no
`WRITE`→`READ` derivation or the reverse · ⛔ ⚪ `N/A` not recorded as ⛔ `DENY` · ⛔ no
`PERM-*`, role, action class or scope class created · ⛔ no frozen document amended · ⛔
the **104** inventory unchanged · ⛔ no `Accepted` ADR edited or superseded by implication.

---

## 9. Provenance

⛔⛔ **This sheet decides nothing, proposes no value or allocation, and changes no count.**

| | |
|---|---|
| Parameters in scope | ⭐ **19** — 6 + 1 + 10 + 1 + 1 |
| ⛔ Out of scope | ⭐ **6** — `B-5` *(2)*, `B-10` *(4)*; ⭐ `B-6`'s two counted under `B-5`/`B-1′` |
| Coverage | ⭐ **79 / 104**, unchanged · ⛔ **D3 `PARTIAL`** · ⛔⛔ **NOT design-ready** |
| Created | ⛔ **0** `PERM-*` · **0** roles/actions/scopes · **0** offices · **0** holders · **0** frozen edits · **0** runtime code |

| Source | Used for |
|---|---|
| ⭐ `DP-0002` | the blocker statements and constraints |
| `Accepted` `ADR-0161` §7 | the blocker list |
| `ADR-0154` §7 | ⭐ `B-3`'s already-determined scope and `WRITE` |
| `ADR-0155` `S-3` · `ADR-0157` · `ADR-0158` §2.4b · `ADR-0159` · `ADR-0160` | constraints and prior determinations |
| `PRD-006` *(FROZEN v1.9)* · `PRD-007` *(FROZEN v1.1)* | `B-1′`, `B-8` |
| `Student_Identity_PRD_v1` · `Student_Management_PRD_v1` *(FROZEN v1.2)* | `B-2`, `B-7` |
| `INVITATION_SECURITY_SPECIFICATION` · `CONFIGURATION_GUIDE` | `B-3` |
| `PRD-023` *(FROZEN)* · `Authentication_PRD_v2` | the §0 constraints, `B-8` scope |
| `PRD_OWNERSHIP_MODEL` §2.2, §12.1, §16 · `PRD_REGISTRY` **L456** | the authorities |
| ⭐ `PRD-006_ATT-GAP-017_OWNER_DECISION_REQUEST` | ⭐ **the template pattern reused here** |
