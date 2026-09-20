# ADR-0158 — SECURITY PLATFORM designated "Security Owner" (security-review authority only), and the Phase 7 disposition of the 25 remaining `BC-25` parameters

| Field | Value |
|---|---|
| **Status** | ⭐⭐ **Accepted** — 2026-09-19 |
| **Rank** | 2 — Architecture Decision Record |
| **Bounded context** | `BC-25` Configuration *(owning)*; `BC-06`, `BC-13`, `BC-18` *(adjacent)* |
| **Supersedes** | ⛔ **NOTHING.** |
| **Superseded by** | — |
| **Authority instrument** | ⭐⭐ **Seven decisions**, verbatim at §2 — `R-1` … `R-7`. |
| **Decides** | ⭐ **1 designation** *(`R-1`)* + ⭐⭐ **the disposition of all 25 remaining parameters** |
| **Authorizes** | ⛔⛔ **ZERO new parameters.** ⭐ **25 remain HELD**, each with a **recorded reason and a named owner**. |

---

## 1. Context — ⭐⭐ an ADR that authorizes NOTHING, and is still a governance act

⚠️⚠️ **THIS ADR MOVES COVERAGE BY ZERO, AND THAT IS THE CORRECT OUTCOME.**
⭐ Coverage stays at **79 / 104**. ⛔ **104/104 is NOT reached, and was NOT
forced.**

⭐ What it **does** achieve is different and necessary:

1. ⭐⭐ **It constitutes an office that did not exist** *(`R-1`)*, unblocking a
   **procedural** dead end that no amount of evidence could have cleared.
2. ⭐⭐ **It converts 25 unexplained gaps into 25 documented holds**, each with a
   **reason** and a **named owner** — satisfying the standing requirement that
   *every held parameter has a documented reason*.
3. ⭐ **It records four independent audits** — `ATT-CFG` Face, the
   authorization-semantic set, **`ICFG-1`…`10`**, and the retention pair — ⛔ none
   of which produced an allocation.

⛔⛔ **An audit that ends in HOLD is a result, not a failure.**

---

## 2. The decisions, recorded verbatim

### 2.1 ⭐⭐ `R-1` — Security Owner designation

> Formally designate SECURITY PLATFORM as the "Security Owner" referenced by
> `ADR-0153`/`ADR-0021`, limited to security-review/decision authority. No extra
> product, architecture, tenant, implementation, or permission authority.

⭐⭐ **RECORDED. The office is now constituted**, and the procedural blocker
reported at the close of Phase 6 is cleared.

#### 2.1a ⭐ The gap this closes, as measured

⭐ `ADR-0153` routed **4** Face parameters to *"Product Owner + **Security
Owner**"*, and `ADR-0021` **L7**/**L200** requires *"**security input
required**"*. ⛔ **But `PRD_OWNERSHIP_MODEL` §2.2 constitutes only four
offices** — Product, Domain, Architecture, Technical *(**L83-86**)* — and
**`grep -c "security owner"` returns `0`**. ⭐ The named owner **did not exist**,
so those 4 could never be reached.

#### 2.1b ⛔⛔ The limits of the designation, stated so they cannot drift

| The office **HAS** | The office **does NOT have** |
|---|---|
| ⭐ Security review | ⛔ Product authority |
| ⭐ Security decision | ⛔ Architecture authority |
| | ⛔ Tenant authority |
| | ⛔ Implementation authority |
| | ⛔ **Permission authority** |

⚠️⚠️ ⛔ **THE PERMISSION EXCLUSION IS LOAD-BEARING.** ⭐ It means the Security
Owner ⛔ **cannot** resolve the **authorization-semantic** parameters of `R-3` —
those stay with the **Authorization Owner**. ⛔ **A security office is not an
authorization office**, and this ADR does not merge them.

⭐ ⛔ **This is a designation, ⛔ not a new role in `AUTH` ch.07** — the platform
register stays **closed at two** (`PR-1`, `PR-2`) and the library register
**closed at five**. ⭐ A **governance office** and a **runtime role** are
different objects. ⛔ **0** `PERM-*` minted.

### 2.2 ⭐⭐ `R-2` — the Face family

> `ATT-CFG-013`/`015`/`016` → authorize **only if explicit V1 evidence supports
> them**; otherwise HOLD.
> `ATT-CFG-014` → HOLD because frozen evidence says *"Not in V1"*.

⭐⭐ **DETERMINATION: ⛔ ALL FOUR HELD.** ⭐ The conditional in `R-2` was **tested
against frozen text, ⛔ not assumed** — and the test **failed**, for a reason
worth stating precisely.

#### 2.2a ⚠️⚠️ The V1-value test PASSES for three — and is NOT sufficient

⭐ `PRD-006` §16.3a **L1760-1763** does give three of them V1 values:

| ID | Default | Allowed domain |
|---|---|---|
| `ATT-CFG-013` | **Enabled** | `true` only in V1 |
| `ATT-CFG-015` | **Enabled** | `true` / `false` |
| `ATT-CFG-016` | **Disabled** | `true` / `false` — ⚠️ *"blocked by `ATT-FR-064`"* |
| ⛔ `ATT-CFG-014` | ⛔ **Not in V1** | ⛔ **Not in V1** |

⭐⭐ **BUT A DEFAULT VALUE IS NOT V1 AUTHORIZATION**, and **`ATT-FR-064`**
*(**L1444**, FROZEN)* settles it:

> *"Until `ATT-GAP-012` and `ATT-GAP-014` are **both** answered by their named
> owners, **face verification MUST NOT be implemented**. The mode is specified;
> it is **not authorised to be built**."*

⭐ **Both gaps are OPEN** — `ATT-GAP-012` *(ownership: "No context in BC Map §3
claims biometrics"; enrollment: "no context authorised to hold it")* and
`ATT-GAP-014` *(retention/deletion under `ID-5`/`MP-GBR-04`)*.

⭐⭐ **So all four are HELD**, on two distinct grounds:
⛔ **`014`** — outside V1 by **`D-3a`** *(Face = **V3**)*, both columns reading *"Not in V1"*.
⛔ **`013`/`015`/`016`** — ⭐ **have V1 values but sit inside a mode `ATT-FR-064` forbids building**.

⚠️⚠️ ⭐ **Allocating authority over settings of an unbuildable mode would be
authorization theatre** — and `PRD-006` calls the underlying risk *"a **legal
exposure**, not a scheduling detail"* *(minors' biometric data, no owner, no
retention rule, no deletion path)*. ⛔ **Held.**

### 2.3 ⭐⭐ `R-3` — the authorization-semantic set

> `ATT-CFG-022`/`023`/`024` + `SEAT-CFG-005`/`014` → HOLD pending Authorization
> Owner. Do not create `PERM` IDs.

⭐⭐ **DETERMINATION: ⛔ ALL FIVE HELD.** ⭐ **0** `PERM-*` created.

| ID | Why it is authorization-semantic |
|---|---|
| ⛔ `ATT-CFG-022` | §19.2 **L1980** — *"Corrections \| `reception`, `manager` — **subject to `ATT-CFG-022`**"* |
| ⛔ `ATT-CFG-023` | ⭐ **Held WITH `022`** — it time-bounds the very capability `022` gates; ⛔ deciding them apart could permit corrections **and** set the window to **0** |
| ⛔ `ATT-CFG-024` | §19.2 **L1983** — *"View guarded students' attendance \| `parent` — **subject to `ATT-CFG-024`**"*; ⚠️ also **cross-app** |
| ⛔ `SEAT-CFG-005` | *"**Override grant** — **which roles** beyond Owner may override…"*; `SEAT-PO-010` = **`C`** |
| ⛔ `SEAT-CFG-014` | *"Whether **Reception** may cancel another student's reservation"*; `SEAT-PO-007` = **`C`** |

⭐ ⛔ **`R-1` does NOT unblock these.** ⭐ The Security Owner designation
**expressly excludes permission authority** *(§2.1b)*, and these five **are**
permission questions. ⛔ **Authorization Owner.**

### 2.4 ⭐⭐ `R-4` — `ICFG-1` … `ICFG-10`, audited independently

> `ICFG-1`…`10` → independently audit. Do not inherit `CFG` decisions. Use only
> explicitly supported roles/scope/read/write. Do not add `PR-1`/`PR-2` by
> inference. If authority/evidence is insufficient → HOLD.

⭐⭐ **DETERMINATION: ⛔ ALL TEN HELD — evidence insufficient.**

#### 2.4a ⭐ The audit, dimension by dimension

| Dimension | Measurement | Sufficient? |
|---|---|---|
| **Inventory** | ⭐ **10**, contiguous, `INVITATION_SECURITY_SPECIFICATION` §11 *(v1.0, **"Approved — authoritative"**)* | ⭐ Yes |
| **Values** | ⭐ All 10 carry defaults **and** ranges; **4** invariants `INV-13`…`INV-16` | ⭐ Yes |
| **Scope** | ⚠️⚠️ **AMBIGUOUS** — `ICFG-5`/`6`/`7` say *"**per library**"*, and the env table **L806** gives `ICFG-1` **per-environment** values; ⛔ but `LCFG-*`'s explicit *"per-library settings, **not per-environment**"* carve-out *(**L829**)* ⛔ **names no `ICFG-*`** | ⛔ **NO** |
| **`READ`** | ⛔ **No read statement anywhere** | ⛔ **NO** |
| **`WRITE`** | ⛔ **No write-role statement**; ⭐ only a **prohibition** — `INV-SEC-018`: *"**MUST NOT** be overridable by **any library role, including `TR-1` Owner**"* | ⛔ **NO** |
| **Roles named** | ⭐ `TR-1`×6, `TR-2`×6, `TR-3`×3 · ⛔ **`PR-1`/`PR-2` = ZERO** | ⛔ **NO** |
| **Commercial** | ⭐ `NOT COMMERCIAL` — TTLs, caps and rate limits | ⭐ Yes |

#### 2.4b ⭐⭐ Why a `PR-1`/`PR-2` allocation was CONSIDERED and REFUSED

⭐ A tempting argument exists: the guide says *"**Every parameter in this
register is security-owned**"* *(**L413**)*, `INV-SEC-018` **denies every library
role**, and ⭐ `ICFG-10`'s own rationale reads *"**Matches `CFG-4`**"* — a
parameter this chain already allocated to `PR-1`+`PR-2` under `ADR-0154`.

⛔⛔ **THAT ARGUMENT IS REFUSED, ON THREE GROUNDS:**

1. ⛔ ***"Security-owned" names a REVIEWING office, not a RUNTIME reader.*** ⭐ `R-1` has just designated that office — ⛔ **and expressly denied it permission authority**. ⭐ Reading a governance office as a runtime role would collapse the very distinction §2.1b draws.
2. ⛔ ***`INV-SEC-018` is a DENIAL, and a denial of `TR-n` is not a grant to `PR-n`.*** ⭐ **`AUTH-7.28`** — no role hierarchy; the absence of one actor's authority implies nothing about another's.
3. ⛔ ***"Matches `CFG-4`" is a VALUE rationale, not an authority statement.*** ⚠️⚠️ ⭐ This is precisely the **`SCFG` error I refused at `ADR-0155`** — a shared band, or here a shared *value*, **is not a shared decision**.

⭐⭐ **And `R-4` forbids exactly this**: *"Do not add `PR-1`/`PR-2` by
inference."* ⛔ **Evidence insufficient → HOLD, all ten.**

### 2.5 ⭐⭐ `R-5`, `R-6`, `R-7` — the remaining six

> **`R-5`:** `CFG-10` + `SCFG-4` → HOLD pending Privacy Owner.
> **`R-6`:** `SMCFG-5` → HOLD until `SM-GAP-2` is defined. `SEAT-CFG-017` → HOLD until `SEAT-GAP-005` / `BC-06` decision is resolved.
> **`R-7`:** `CFG-12` + `SCFG-2` → HOLD pending explicit Authorization Owner/reviewer definition.

⭐⭐ **DETERMINATION: ⛔ ALL SIX HELD**, each confirmed still open:

| ID | Reason | Owner |
|---|---|---|
| ⛔ `CFG-10` | Soft-deleted account retention — **DPDP-adjacent** | **Privacy Owner** |
| ⛔ `SCFG-4` | Username-history retention — ⭐ **the same question**; held **together** | **Privacy Owner** |
| ⛔ `SMCFG-5` | ⛔ **Definition undecided** — `SM-GAP-2` open in **every** source, **0** ADRs | **Product Owner** |
| ⛔ `SEAT-CFG-017` | `BC-06`-owned via `E-05`; value **unset**; `SEAT-GAP-005` open | **Product Owner** + **`BC-06` Owner** |
| ⛔ `CFG-12` | ⭐ **Self-referential** — bears on `PR-2`'s own standing | **Authorization Owner** |
| ⛔ `SCFG-2` | Reserved-username list — *"requires review"*, ⛔ **reviewer undefined** | **Authorization Owner** |

---

## 3. ⭐⭐ The complete 25 — reconciled

| # | Group | IDs | Count | Owner | Decision |
|---|---|---|---|---|---|
| 1 | Face family | `ATT-CFG-013`,`014`,`015`,`016` | **4** | PO + **Security Owner** *(now constituted)* | `R-2` |
| 2 | Authorization-semantic — attendance | `ATT-CFG-022`,`023`,`024` | **3** | Authorization Owner | `R-3` |
| 3 | Authorization-semantic — seat | `SEAT-CFG-005`,`014` | **2** | Authorization Owner | `R-3` |
| 4 | Invitation security | `ICFG-1`…`10` | **10** | PO + SECURITY PLATFORM | `R-4` |
| 5 | Retention / DPDP | `CFG-10`, `SCFG-4` | **2** | Privacy Owner | `R-5` |
| 6 | Definition undecided | `SMCFG-5`, `SEAT-CFG-017` | **2** | PO *(+ `BC-06`)* | `R-6` |
| 7 | Authorization — other | `CFG-12`, `SCFG-2` | **2** | Authorization Owner | `R-7` |
| | | **TOTAL** | ⭐ **25** | | |

⭐⭐ **79 authorized + 25 held = 104.** ⛔ **No parameter is unaccounted, and
⛔ none was authorized to reach a number.**

---

## 4. Invariants checked

| # | Invariant | Held? |
|---|---|---|
| 1 | Permission catalogue closed at zero (`AUTH-7.22`) | ⭐ **YES** — **0** `PERM-*` |
| 2 | Platform role register closed at two (`AUTH` ch.07 **L79**) | ⭐ **YES** — ⛔ a **governance office** is not a runtime role |
| 3 | Library role register closed at five (**L87**) | ⭐ **YES** |
| 4 | ⛔ No authority inferred from a shared value or band | ⭐ **YES** — §2.4b |
| 5 | ⛔ No `PR-n` added by inference (`R-4`) | ⭐ **YES** |
| 6 | ⛔ Denial of `TR-n` not read as grant to `PR-n` (`AUTH-7.28`) | ⭐ **YES** |
| 7 | ⛔ Security office ≠ authorization office | ⭐ **YES** — §2.1b, §2.3 |
| 8 | Frozen sources unmodified | ⭐ **YES** — `PRD-006`, `PRD-007`, the Invitation spec |
| 9 | ⛔ 104 inventory unchanged | ⭐ **YES** |
| 10 | ⛔ Nothing superseded | ⭐ **YES** |
| 11 | ⛔ **104/104 NOT forced** | ⭐ **YES** — **0** authorized here |

---

## 5. Decisions — `D-1` … `D-9`

| ID | Decision |
|---|---|
| **`D-1`** | ⭐ **SECURITY PLATFORM is designated "Security Owner"** for `ADR-0153`/`ADR-0021` — ⛔ **security review and decision ONLY**. |
| **`D-2`** | ⛔ The office has **no** product, architecture, tenant, implementation or **permission** authority; ⛔ it is **not** a runtime role and ⛔ adds nothing to `AUTH` ch.07. |
| **`D-3`** | ⛔ **`ATT-CFG-013`/`014`/`015`/`016` HELD.** ⭐ `013`/`015`/`016` **have V1 values**, ⛔ but sit in a mode **`ATT-FR-064` forbids building** while `ATT-GAP-012`/`014` stay open; ⛔ `014` is **outside V1** (`D-3a`). |
| **`D-4`** | ⛔ **`ATT-CFG-022`/`023`/`024` + `SEAT-CFG-005`/`014` HELD** — authorization-semantic; ⛔ **`D-1` does NOT unblock them**. |
| **`D-5`** | ⛔ **`ICFG-1`…`10` HELD** — ⛔ **no** `READ` statement, ⛔ **no** `WRITE` role, ⚠️ **ambiguous scope**, ⛔ **0** `PR-n` in the source. |
| **`D-6`** | ⛔ A `PR-1`/`PR-2` `ICFG` allocation was **considered and REFUSED** on three grounds (§2.4b) — ⭐ notably that *"Matches `CFG-4`"* is a **value** rationale, ⛔ not an authority statement. |
| **`D-7`** | ⛔ **`CFG-10`+`SCFG-4`**, **`SMCFG-5`+`SEAT-CFG-017`**, **`CFG-12`+`SCFG-2`** all **HELD**, owners named. |
| **`D-8`** | ⭐ **All 25 now carry a documented reason and a named owner** — ⭐ the standing requirement is **met**, though ⛔ the parameters stay unauthorized. |
| **`D-9`** | ⭐ Coverage is **UNCHANGED at 79 / 104**. ⛔⛔ **`DD-0007` is NOT design-ready; D3 stays `PARTIAL`.** |

---

## 6. ⛔ What this ADR does NOT do

⛔ **It authorizes NO parameter** — coverage moves by **zero**.
⛔ **It does not create a role, action class, scope class or `PERM-*`.**
⛔ **It does not give the Security Owner permission authority** — `R-3` stays with the Authorization Owner.
⛔ **It does not resolve `ATT-GAP-012`, `ATT-GAP-014`, `SM-GAP-2`, `SEAT-GAP-005`, `CNF-GAP-002` or `CNF-GAP-007`.**
⛔ **It does not amend `PRD_OWNERSHIP_MODEL`** — ⚠️ recording the designation **there** is `O-1`, a **Governance Owner** act.
⛔ **It does not make `DD-0007` design-ready.**

---

## 7. Obligations — `O-1` … `O-7`

| ID | Obligation | Owner |
|---|---|---|
| **`O-1`** | ⭐ Record the **Security Owner** office in `PRD_OWNERSHIP_MODEL` §2.2 | **Governance Owner** |
| **`O-2`** | Resolve **`ATT-GAP-012`** *(biometric ownership)* and **`ATT-GAP-014`** *(retention/deletion)*, then revisit the Face family | **Security Owner** + `BC-13`/`BC-18` |
| **`O-3`** | Determine the **5 authorization-semantic** parameters | **Authorization Owner** |
| **`O-4`** | Supply the missing `ICFG` `READ`/`WRITE`/scope statements, then allocate | **PO** + **SECURITY PLATFORM** |
| **`O-5`** | Determine **`CFG-10`** + **`SCFG-4`** as one retention question | **Privacy Owner** |
| **`O-6`** | Resolve **`SM-GAP-2`** and **`SEAT-GAP-005`** | **PO** + **`BC-06` Owner** |
| **`O-7`** | Determine **`CFG-12`** and **`SCFG-2`** | **Authorization Owner** |

---

## 8. Changelog

| Version | Date | Change |
|---|---|---|
| ⭐⭐ **1.0** | 2026-09-19 | ⭐⭐ **ACCEPTED, and it authorizes NOTHING — deliberately.** ⭐ **`R-1`: SECURITY PLATFORM designated "Security Owner"**, ⛔ security review/decision **only** — ⛔ no product, architecture, tenant, implementation or **permission** authority, and ⛔ **not** a runtime role. ⭐ This constitutes an office `PRD_OWNERSHIP_MODEL` §2.2 **did not contain** *(measured: **0** occurrences)*. ⛔⛔ **All 25 remaining parameters HELD**, each with a reason and a named owner: **4** Face *(⭐ `013`/`015`/`016` **have V1 values** ⛔ but `ATT-FR-064` forbids building the mode; `014` outside V1)* · **5** authorization-semantic *(⛔ `R-1` does **not** unblock these)* · **10** `ICFG` *(⛔ no `READ`, no `WRITE` role, ambiguous scope, **0** `PR-n`)* · **2** retention · **2** undefined · **2** authorization-other. ⭐⭐ A `PR-n` `ICFG` allocation was **considered and REFUSED** — ⭐ *"Matches `CFG-4`"* is a **value** rationale, ⛔ not an authority statement. ⭐ Coverage **UNCHANGED at 79 / 104**; ⛔⛔ **104/104 NOT forced**. ⛔ Supersedes nothing · **0** `PERM-*` · **0** roles/actions/scopes · **0** frozen edits · **0** runtime code. ⛔ **D3 still `PARTIAL`.** |
