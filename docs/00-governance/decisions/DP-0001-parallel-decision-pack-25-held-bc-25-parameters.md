# DP-0001 — Parallel Decision Pack: the 25 held `BC-25` configuration parameters

| Field | Value |
|---|---|
| **Type** | ⭐ **Decision request** — ⛔ **NOT a decision, NOT an ADR, NOT an authorization** |
| **Status** | ⭐ **OPEN — awaiting 5 authorities, in parallel.** ⚠️⚠️ **§5A now carries 25 PROPOSED dispositions — ⛔ these are NOT authority decisions and ⛔ have NOT been processed.** |
| **Raised from** | `DD-0007` **v0.9** *(coverage **79 / 104**)* · `ADR-0158` §3 hold register |
| **Baseline** | HEAD `98fb1e8` · `github/main` `98fb1e8` |
| **Authorizes** | ⛔⛔ **NOTHING.** ⭐ This sheet **asks**; it does not answer. |

---

## 0. How to use this sheet

⭐⭐ **The five groups are INDEPENDENT. Do not wait for one another.** ⭐ No
group's answer is a precondition for any other's, and ⛔ **no group may be
answered by an authority other than the one named.**

⭐ For **every** item, please return **six fields**:

| Field | Permitted values |
|---|---|
| **1. Decision** | `AUTHORIZE` · `HOLD` |
| **2. Scope** | `Tenant` · `Library` · `Platform default` · `Branch` · `N/A` |
| **3. `READ`** | named roles from the **closed** registers, or `NONE` |
| **4. `WRITE`** | named roles · ⚪ `N/A` *(not runtime-writable)* · ⛔ `DENY` |
| **5. Commercial** | `COMMERCIAL` · `NOT COMMERCIAL` |
| **6. Rationale** | the evidence relied on |

### 0.1 ⛔⛔ Constraints that bind every answer

| # | Constraint | Source |
|---|---|---|
| 1 | ⛔ **Platform roles are closed at TWO** — `PR-1`, `PR-2`. ⛔ No new role. | `AUTH` ch.07 **L79** |
| 2 | ⛔ **Library roles are closed at FIVE** — `TR-1`…`TR-5`. ⛔ No new role. | `AUTH` ch.07 **L87** |
| 3 | ⛔ **The permission catalogue is closed at ZERO** — ⛔ **no `PERM-*` identifier may be created.** | `AUTH-7.22`, `ADR-0132` |
| 4 | ⭐ **`READ` and `WRITE` must be decided INDEPENDENTLY** — neither implies the other. | `CNF-BR-010`, **`AUTH-7.24`** |
| 5 | ⛔ **No role hierarchy** — denying one actor implies **nothing** about another. | **`AUTH-7.28`** |
| 6 | ⛔ **Frozen PRDs/specs MUST NOT be amended** to fit a decision. | `ADR-INDEX` process |
| 7 | ⛔ **The 104 inventory MUST NOT change** absent an express inventory decision. | standing |
| 8 | ⚠️ ⚪ **`N/A` ≠ ⛔ `DENY`.** ⚪ `N/A` = *not runtime-writable by anyone* (`CNF-FR-020`, platform-default only). ⛔ `DENY` = a runtime permission decision. | `ADR-0151` §3.5; `ADR-0157` `SE-4` |
| 9 | ⭐⭐ **`HOLD` is a valid and respected answer.** ⛔ **Do NOT authorize to reach 104/104.** | standing |

⚠️⚠️ **Precedent worth knowing before you answer:** three times in this chain a
plausible cross-register inference was **refused** — a shared *band*
(`ADR-0155`), a shared *role set* (`ADR-0157`), and a shared *value*
(`ADR-0158` §2.4b, *"Matches `CFG-4`"*). ⭐ **A shared anything is not a shared
decision.** ⛔ Please do not rely on one register to settle another.

---

# GROUP 1 — **Authorization Owner** · 7 parameters

⭐⭐ **Why you and no one else:** each of these **configures role capability
itself**. ⚠️⚠️ ⛔ **The "Security Owner" office designated at `ADR-0158` `R-1`
CANNOT answer these** — that designation **expressly excludes permission
authority**. ⭐ A security office is not an authorization office.

### 1.1 `ATT-CFG-022` — Staff correction permitted

| | |
|---|---|
| **Owning source** | `PRD-006` §16.3 **L1769** *(FROZEN v1.9)* |
| **Evidence — value** | Owner-set · Default **Enabled** · domain `true`/`false` · invalid → Reject · effect: Next correction |
| **Evidence — why held** | §19.2 **L1980**: *"Corrections (§18) \| `reception`, `manager` — **subject to `ATT-CFG-022`**"* |
| ⚠️ **The risk** | ⭐ A `TR-1` write to this value **switches off a `TR-2`/`TR-3` capability**. ⛔ That is an authorization act performed through a configuration field. |

### 1.2 `ATT-CFG-023` — Correction window

| | |
|---|---|
| **Owning source** | `PRD-006` §16.3 **L1770** |
| **Evidence — value** | Owner-set · Default **15 minutes** · range **0–60 minutes** · *"Must be ≥ 0"* |
| ⚠️⚠️ **Why it is bundled with 1.1** | ⭐ It **time-bounds the very capability `ATT-CFG-022` gates**. ⛔ **Deciding them apart could permit corrections AND set the window to `0`** — nullifying the permission while appearing to grant it. |
| ⭐ **Request** | ⭐ Please answer **1.1 and 1.2 together**, or state expressly that they may diverge. |

### 1.3 `ATT-CFG-024` — Parent attendance visibility

| | |
|---|---|
| **Owning source** | `PRD-006` §16.3 **L1771** |
| **Evidence — value** | Owner-set · Default **Enabled** · `true`/`false` · effect: Next read |
| **Evidence — why held** | §19.2 **L1983**: *"View guarded students' attendance \| `parent` — **subject to `ATT-CFG-024`**"* |
| ⚠️⚠️ **Additional dimension** | ⭐ **CROSS-APP** — a `TR-1` write in **APP 2** changes what `TR-5` Parent sees in **another app**. ⛔ This may engage `DD-0007` **D5**; please say if it does. |

### 1.4 `SEAT-CFG-005` — Override grant

| | |
|---|---|
| **Owning source** | `PRD-007` §27.1 **L1906** *(FROZEN v1.1)* |
| **Evidence — verbatim** | *"**Override grant** — **which roles** beyond Owner may override a bounded staff limit: the transfer-per-day limit (`SEAT-FR-066`) and a seat lock (`SEAT-FR-162`)"* |
| **Evidence — value** | Default **Owner only** · domain *"Subset of {Manager} added to Owner"* |
| **Evidence — binding** | `SEAT-PO-010` = **`C (SEAT-CFG-005)`** · **L2024**: *"Manager's lock override is **conditional on `SEAT-CFG-005`**"* · `SEAT-AC-053`: *"only Owner may override by default"* |
| ⚠️⚠️ **The risk** | ⭐ The `SEAT-PO-*` legend defines **`C`** as *"permitted **only where the named configurable grants it**"* — ⭐ **this parameter IS the grant.** |

### 1.5 `SEAT-CFG-014` — Whether Reception may cancel another student's reservation

| | |
|---|---|
| **Owning source** | `PRD-007` §27.1 **L1915** |
| **Evidence — value** | Default **not granted** · Boolean |
| **Evidence — binding** | `SEAT-PO-007` = **`C (SEAT-CFG-014)`** · `SEAT-AC-080`: Reception attempt with it unset → *"**Denied**"* |

### 1.6 `CFG-12` — Platform Support elevated-access maximum duration

| | |
|---|---|
| **Owning source** | `CONFIGURATION_GUIDE` §2 **L317** · `PRD-001` §E |
| **Evidence — value** | Default **1 hour** · range **30 minutes – 4 hours** · Chapters 2, 7 · **Owner: Security + Legal** |
| **Evidence — verbatim** | *"the window in which a Liboora employee holds elevated access into a customer's tenant. It is the **single highest-privilege state in the platform** and the one with the **weakest structural control**, since the actor is **trusted by definition**"* · **L883**: *"**Every** elevation is alertable. This is **not sampled**"* |
| ⚠️⚠️ **Why it could not be batched** | ⭐ **SELF-REFERENTIAL** — it bounds **`PR-2`'s own standing**. ⛔ A `PR-2` read/write of it cannot be settled by the same act that relies on `PR-2`. |
| ⚠️ **Note** | ⭐ Its stated owner is *"Security + Legal"*; ⛔ this pack routes it to **you** because the question is **authorization**, not value. ⚠️ Please redirect if you disagree. |

### 1.7 `SCFG-2` — Reserved-username list

| | |
|---|---|
| **Owning source** | `Student_Identity_PRD_v1` §5.5 **L1336** *(Official baseline)* |
| **Evidence — value** | Default **Platform-managed list** · Scope **`Platform default`** *(`SID-5.45`)* |
| **Evidence — the gap** | *"Additive only; **removing an entry requires review**"* — ⛔ **the document never says by whom.** |
| ⛔ **Constraint** | ⛔ The reviewer **MUST NOT** be inferred from `TR-n`/`PR-n` naming, ownership, hierarchy or UI visibility. |
| ⭐ **Extra field needed** | ⭐ **Name the review authority explicitly**, or confirm `HOLD`. |

---

# GROUP 2 — **Product Owner + SECURITY PLATFORM** · 10 parameters

⭐⭐ **These 10 are held for MISSING EVIDENCE, not for risk.** ⭐ Three
dimensions are already sound; **three are absent from every source.**

### 2.0 What is already established — ⛔ please do not re-decide

| Dimension | Status |
|---|---|
| **Inventory** | ⭐ **10**, contiguous, `INVITATION_SECURITY_SPECIFICATION` §11 *(v1.0, **"Approved — authoritative"**)* |
| **Values** | ⭐ All 10 carry a default **and** a range |
| **Invariants** | ⭐ `INV-13` (`ICFG-1` ≤ 7 d) · `INV-14` (`ICFG-3` ≤ `ICFG-2`) · `INV-15` (`ICFG-4` > `CFG-2` × `CFG-1`) · `INV-16` (`ICFG-6` ≥ 1) |
| **Commercial** | ⭐ Appears `NOT COMMERCIAL` — TTLs, caps, rate limits. ⚠️ **Please confirm.** |

### 2.1 ⛔ What is MISSING — the three questions

| # | Missing | Measurement |
|---|---|---|
| **`Q-A` SCOPE** | ⚠️⚠️ **AMBIGUOUS** | `ICFG-5`/`6`/`7` read *"**per library**"*, yet the env table **L806-815** gives **per-environment** values for `ICFG-1`…`10`. ⭐ The `LCFG-*` carve-out at **L829** — *"per-library settings, **not per-environment**"* — ⛔ **names no `ICFG-*`.** |
| **`Q-B` `READ`** | ⛔ **NO STATEMENT ANYWHERE** | ⛔ Zero read statements in either source. |
| **`Q-C` `WRITE`** | ⛔ **NO ROLE STATEMENT** | ⭐ Only a **prohibition** — `INV-SEC-018`: *"refusal **MUST NOT** be overridable by **any library role, including `TR-1` Owner**"*; `INV-SEC-019`: *"Expiry **MUST NOT** be extendable."* |
| **Roles named** | ⚠️ `TR-1`×6 · `TR-2`×6 · `TR-3`×3 · ⛔ **`PR-1`/`PR-2` = ZERO** |

### 2.2 ⚠️⚠️ An argument already CONSIDERED and REFUSED — please rule on it expressly

⭐ There is a tempting case for `READ` = `PR-1` + `PR-2`:
*(i)* `CONFIGURATION_GUIDE` **L413** — *"**Every parameter in this register is
security-owned**"*; *(ii)* `INV-SEC-018` denies **every library role**;
*(iii)* `ICFG-10`'s own rationale reads *"**Matches `CFG-4`**"* — and `CFG-4`
**is** allocated `READ` = `PR-1`+`PR-2` by `ADR-0154`.

⛔⛔ **`ADR-0158` §2.4b REFUSED it**, on three grounds: *"security-owned"* names a
**reviewing office**, not a runtime reader; **a denial of `TR-n` is not a grant
to `PR-n`** (`AUTH-7.28`); and *"Matches `CFG-4`"* is a **value** rationale, ⛔
**not an authority statement**.

⭐ **Please either confirm that refusal, or overrule it with express authority.**

### 2.3 The 10 parameters

| ID | Parameter | Default | Range | Security rationale |
|---|---|---|---|---|
| `ICFG-1` | `IT-1` staff invitation TTL | **48 h** | 1 h – 7 d | ⚠️ Bound by `INV-13` ≤ 7 d |
| `ICFG-2` | `IT-2` private library invitation TTL | **7 d** | 1 h – 30 d | Grants only the *opportunity* to join |
| `ICFG-3` | `IT-3` access code TTL | **24 h** | 1 h – 7 d | ⚠️ `INV-14`: ≤ `ICFG-2` — *"the weakest artefact must never live the longest"* |
| `ICFG-4` | Acceptance window after first use | **15 min** | 5 – 60 min | ⚠️ `INV-15`: > `CFG-2` × `CFG-1` |
| `ICFG-5` | Outstanding invitations per library | **50** | 1 – 500 | *"Bounds the damage of a **compromised Owner account**"* |
| `ICFG-6` | Max acceptances per `IT-3` code | **25** | 1 – 200 | ⚠️ `INV-16`: ≥ 1 |
| `ICFG-7` | Invitations creatable per hour per library | **20** | 1 – 100 | Rate limit, issuing side |
| `ICFG-8` | Presentations per origin per hour | **20** | 5 – 100 | ⭐ *"**`ICFG-8` is what makes 40 bits sufficient**"*; ⚠️ *"Raising `ICFG-8` **weakens `IT-3`** even though the entropy figure does not change"* |
| `ICFG-9` | Failed presentations before throttling | **10** | 3 – 50 | Tolerates typos |
| `ICFG-10` | Throttle duration after threshold | **30 min** | 5 – 120 min | ⚠️ *"**Matches `CFG-4`**"* — see §2.2 |

⭐ **Please answer `Q-A`, `Q-B`, `Q-C` once for the register**, then flag any
parameter needing different treatment — ⚠️ `ICFG-8` and `ICFG-10` are the likely
candidates.

---

# GROUP 3 — **Privacy Owner** · 2 parameters

⭐⭐ **One question, two parameters.** ⭐ They are presented together because both
are **retention periods**; ⛔ deciding one and holding the other would leave the
platform's retention posture **internally inconsistent**.

### 3.1 `CFG-10` — Soft-deleted account retention before permanent erasure

| | |
|---|---|
| **Owning source** | `CONFIGURATION_GUIDE` §2 **L281** · `PRD-001` §E |
| **Evidence — value** | Default **30 days** · range **7 – 90 days** · Chapter 9 · **Owner: Legal + Security** |
| **Evidence — verbatim** | *"The grace window between `Pending Deletion` and `Deleted`… Thirty days is the common consumer standard and is **short enough to remain defensible as erasure under DPDP**."* |
| ⚠️ **Why held** | ⭐ **DPDP-adjacent** — the value is the erasure-defensibility argument itself. |

### 3.2 `SCFG-4` — Username-history retention

| | |
|---|---|
| **Owning source** | `Student_Identity_PRD_v1` §5.5 **L1338** |
| **Evidence — value** | Default **24 months** · range **12 – 120 months** · *"Supports impersonation investigation"* |
| **Evidence — scope** | ⭐ **`Platform default`**, sourced — `SID-5.45`: *"**SHALL** be platform-wide. **None SHALL be organisation-configurable**"* |
| ⚠️ **Tension to weigh** | ⭐ A **longer** retention aids impersonation investigation; ⭐ a **shorter** one aids data minimisation. ⛔ Not an engineering trade-off. |

⭐ **Related but NOT yours:** `SEAT-CFG-004` and `ATT-CFG-*` retention-adjacent
values are **already authorized**; ⛔ this pack does not reopen them.

---

# GROUP 4 — **Product Owner + `BC-06` Owner** · 2 parameters

⚠️⚠️ **These two are NOT authorization questions.** ⭐ In both cases the
**definition itself is open** — ⛔ authority cannot be allocated over a
parameter whose meaning is undecided.

### 4.1 `SMCFG-5` — Enrollment number format · **Product Owner**

| | |
|---|---|
| **Owning source** | `Student_Management_PRD_v1` §10.3 **L1042** *(FROZEN v1.2)* |
| **Evidence — value** | Default *"tenant-prefixed sequence"* · Range **—** · Class Product |
| ⛔ **The gap — `SM-GAP-2`** | **L1168**: *"`enrollmentNumber` format and whether it is human-meaningful. `SM-INV-1` requires uniqueness only. **`SMCFG-5`'s default is a placeholder pending a decision**"* |
| **Corroboration** | `PRD-004_TRACEABILITY` **L187** — *"⚠ **placeholder**", "**undecided**"* · independent review — *"**Remain a gap**"* and *"a configurable **should not publish a default** for a parameter the document says is [undecided]"* · `DD-0002` **L158** — *"**no form**"* |
| ⛔ **Measured** | ⭐ `SM-GAP-2` appears in **ZERO** ADRs. |
| ⭐ **Question** | ⭐ **Is `enrollmentNumber` human-meaningful?** ⭐ If yes, what format? ⭐ If the answer is not ready → **`HOLD`**. |

### 4.2 `SEAT-CFG-017` — Occupancy percentage that emits `SEAT-EVT-004` · **`BC-06` Owner + PO**

| | |
|---|---|
| **Owning source** | `PRD-007` §27.1 **L1918** |
| ⚠️⚠️ **Owner** | ⛔ **`BC-06` via `E-05` — the ONLY one of the 18 `SEAT-CFG-*` not owned by `BC-25`** |
| **Evidence — value** | ⛔ *"**Unset in V1** — no event is emitted and **no value is substituted**"* |
| ⛔ **The gap — `SEAT-GAP-005`** | **L1935**: *"The occupancy threshold is a **proposed** addition to the `E-05` contract"* · §27.1 preamble: **90%** *"becomes the applicable default **only once** the threshold is carried by the `E-05` contract; until that confirmation it is a **documented proposal, not an active default**"* |
| ⛔⛔ **Hard constraint** | ⛔ **The 90% figure MUST NOT be applied as a fallback** — `SEAT-FR-241`, `SEAT-AC-170`. ⛔ Please do **not** supply a value to unblock this. |
| ⚠️ **Scope caveat** | `SEAT-XC-022`: *"tenant-scoped, **or branch-scoped where `BC-06` owns it**"* — ⭐ **this is the sole parameter that referent reaches.** ⚠️ Please state **`Tenant` or `Branch`** expressly. |

---

# GROUP 5 — **Security Owner + `BC-13`/`BC-18`** · 4 parameters

⭐⭐ **The office answering this group was constituted by `ADR-0158` `R-1`** —
SECURITY PLATFORM, **security review and decision only**. ⛔ It has **no
permission authority**, so ⛔ **Group 1 is not yours.**

### 5.0 ⛔⛔ The blocker that covers all four

⭐ **`ATT-FR-064`** *(`PRD-006` **L1444**, FROZEN)*:

> *"Until **`ATT-GAP-012`** and **`ATT-GAP-014`** are **both** answered by their
> named owners, **face verification MUST NOT be implemented**. The mode is
> specified; it is **not authorised to be built**."*

⭐ And the reason, stated in the frozen document itself:

> *"**This is the one mode this document blocks outright.** Enrolling biometric
> data **for minors** with no owner, no retention rule and no deletion path is a
> **legal exposure, not a scheduling detail**."*

| Gap | Open question | Evidence |
|---|---|---|
| ⛔ **`ATT-GAP-012`** | **Ownership + enrollment** | **L1427**: *"**No context in BC Map §3 claims biometrics**"* · **L1429**: *"Enrollment writes a durable biometric record. With no owner and no storage path, **there is no context authorised to hold it**"* |
| ⛔ **`ATT-GAP-014`** | **Retention / deletion** | **L1433**: *"`ID-5` and `MP-GBR-04` require that erasure delete the `Account`, anonymise the `Person`, and **retain** attendance history"* — ⚠️ a biometric template interacts with all three |

⭐⭐ **These two gaps are the real decision. The four parameters below follow
from them.**

### 5.1 The four parameters

| ID | Parameter | V1 default | Domain | Status |
|---|---|---|---|---|
| `ATT-CFG-013` | Face enrollment required before use | **Enabled** | `true` only in V1 | ⚠️ **Has a V1 value** |
| ⛔ `ATT-CFG-014` | Face match confidence threshold | ⛔ **Not in V1** | ⛔ **Not in V1** | ⛔ Outside V1 — `D-3a`, Face = **V3** |
| `ATT-CFG-015` | Face liveness required | **Enabled** | `true`/`false` | ⚠️ **Has a V1 value** |
| `ATT-CFG-016` | Face mode enabled | **Disabled** | `true`/`false` — *"blocked by `ATT-FR-064`"* | ⚠️ **Has a V1 value** |

⚠️⚠️ **A finding you should have before answering:** `013`, `015` and `016`
**do** carry V1 defaults and allowed domains (§16.3a) — ⭐ so a *"no V1 value"*
argument would be **factually wrong**. ⛔ **But a default value is not
authorization**: all three configure a mode `ATT-FR-064` forbids building. ⭐
`ADR-0158` `D-3` therefore held them on the ground that **allocating authority
over settings of an unbuildable mode would be authorization theatre**.

⭐ **Your decision:** ⭐ resolve `ATT-GAP-012`/`ATT-GAP-014` and authorize · or
⭐ confirm `HOLD` until they are · ⚠️ or state that configuration authority may
be allocated **ahead of** build authorization, ⛔ which would be a **new
precedent** and should be recorded as such.

⛔ **`ATT-CFG-014` is separately blocked** — outside V1 by `D-3a`. ⭐ Please
treat it independently of the other three.

---

## 5A. ⚠️⚠️ PROPOSED DISPOSITIONS — AWAITING AUTHORITY CONFIRMATION

⛔⛔ **EVERY ROW IN THIS SECTION IS `PROPOSED — AWAITING AUTHORITY CONFIRMATION`.**

⚠️⚠️ **These are NOT authority decisions.** ⛔ They were **not** issued by any of
the five named authorities; ⭐ they are a **suggested starting position**, recorded
so each authority has something concrete to **confirm, amend or reject**.

### 5A.0 ⛔ What these proposals have NOT done

| ⛔ Not done | Confirmation |
|---|---|
| ⛔ **No ADR created** | ⛔ `ADR-0159`+ **does not exist** |
| ⛔ **`DD-0007` NOT modified** | ⭐ still **v0.9** |
| ⛔ **Authorization counts UNCHANGED** | ⭐ **79 authorized · 25 held · 104 total** |
| ⛔ **No frozen file touched** | ⭐ all hashes intact |
| ⛔ **No `PERM-*`, role, action class or scope created** | ⭐ **0 / 0 / 0 / 0** |
| ⛔ **`DP-0001` remains OPEN** | ⭐ all 5 groups still awaited |

⭐⭐ **Every proposal below is `HOLD`.** ⛔ **Not one parameter is proposed for
authorization**, so ⛔ confirming **all 25 exactly as proposed would still leave
coverage at 79 / 104** and ⛔ `DD-0007` **not design-ready**. ⭐ These proposals
therefore **cannot** be mistaken for progress toward 104/104.

⚠️ **A `HOLD` proposal is still only a proposal.** ⭐ An authority may reply
**`AUTHORIZE`**, and that reply governs — ⛔ the rows below do **not** constrain it.

---

### 5A.1 Group 1 — **Authorization Owner** · 7 · ⚠️ PROPOSED

| ID | Parameter | Proposed | Scope | `READ` | `WRITE` | Commercial | Status |
|---|---|---|---|---|---|---|---|
| `ATT-CFG-022` | Staff correction permitted | ⛔ **HOLD** | — | — | — | — | ⚠️ **PROPOSED** |
| `ATT-CFG-023` | Correction window | ⛔ **HOLD** | — | — | — | — | ⚠️ **PROPOSED** |
| `ATT-CFG-024` | Parent attendance visibility | ⛔ **HOLD** | — | — | — | — | ⚠️ **PROPOSED** |
| `SEAT-CFG-005` | Override grant | ⛔ **HOLD** | — | — | — | — | ⚠️ **PROPOSED** |
| `SEAT-CFG-014` | Reception may cancel a reservation | ⛔ **HOLD** | — | — | — | — | ⚠️ **PROPOSED** |
| `CFG-12` | Platform Support elevated-access max duration | ⛔ **HOLD** | — | — | — | — | ⚠️ **PROPOSED** |
| `SCFG-2` | Reserved-username list | ⛔ **HOLD** | — | — | — | — | ⚠️ **PROPOSED** |

⭐ **Proposed rationale:** ⛔ each parameter **configures role capability itself**
*(evidence at §1.1–§1.7)*; ⛔ no Authorization Owner determination exists.

⚠️ **Scope / `READ` / `WRITE` / Commercial are left blank deliberately** — ⛔ a
`HOLD` decides none of them, and ⭐ filling them in would imply an allocation.

---

### 5A.2 Group 2 — **PO + SECURITY PLATFORM** · 10 · ⚠️ PROPOSED

| ID | Proposed | Scope *(proposed)* | `READ` | `WRITE` | Commercial *(proposed)* | Status |
|---|---|---|---|---|---|---|
| `ICFG-1` | ⛔ **HOLD** | ⚠️ *Platform Default* | — | — | *NOT COMMERCIAL* | ⚠️ **PROPOSED** |
| `ICFG-2` | ⛔ **HOLD** | ⚠️ *Platform Default* | — | — | *NOT COMMERCIAL* | ⚠️ **PROPOSED** |
| `ICFG-3` | ⛔ **HOLD** | ⚠️ *Platform Default* | — | — | *NOT COMMERCIAL* | ⚠️ **PROPOSED** |
| `ICFG-4` | ⛔ **HOLD** | ⚠️ *Platform Default* | — | — | *NOT COMMERCIAL* | ⚠️ **PROPOSED** |
| `ICFG-5` | ⛔ **HOLD** | ⚠️ *Platform Default* | — | — | *NOT COMMERCIAL* | ⚠️ **PROPOSED** |
| `ICFG-6` | ⛔ **HOLD** | ⚠️ *Platform Default* | — | — | *NOT COMMERCIAL* | ⚠️ **PROPOSED** |
| `ICFG-7` | ⛔ **HOLD** | ⚠️ *Platform Default* | — | — | *NOT COMMERCIAL* | ⚠️ **PROPOSED** |
| `ICFG-8` | ⛔ **HOLD** | ⚠️ *Platform Default* | — | — | *NOT COMMERCIAL* | ⚠️ **PROPOSED** |
| `ICFG-9` | ⛔ **HOLD** | ⚠️ *Platform Default* | — | — | *NOT COMMERCIAL* | ⚠️ **PROPOSED** |
| `ICFG-10` | ⛔ **HOLD** | ⚠️ *Platform Default* | — | — | *NOT COMMERCIAL* | ⚠️ **PROPOSED** |

⭐ **Proposed rationale:** ⛔ **explicit `READ`/`WRITE` authority is still missing**
— the register has **no read statement** and **no write role**, only
`INV-SEC-018`'s prohibition.

⚠️⚠️ **TWO CAVEATS ON THIS GROUP'S PROPOSED FIELDS — please read before
confirming:**

1. ⚠️⚠️ **The proposed scope `Platform Default` is NOT what the sources say.**
   ⛔ `ICFG-5`/`6`/`7` read *"**per library**"*; ⭐ the env table **L806-815** gives
   per-environment values; ⛔ and the `LCFG-*` per-library carve-out at **L829**
   **names no `ICFG-*`**. ⭐ §2.1 `Q-A` records this as **AMBIGUOUS**.
   ⛔⛔ **This proposal does not resolve that ambiguity and must not be read as
   having done so** — ⭐ `Q-A` stays open and still requires an express answer.
2. ⭐ **`NOT COMMERCIAL` is consistent with the evidence** *(TTLs, caps, rate
   limits — §2.0)*, ⚠️ but is still **proposed**, ⛔ not confirmed.

⭐ ⛔ **Confirming `HOLD` does not settle `Q-A`, `Q-B` or `Q-C`** — those three
questions survive the hold and ⭐ still need answers before any allocation.

---

### 5A.3 Group 3 — **Privacy Owner** · 2 · ⚠️ PROPOSED

| ID | Parameter | Proposed | Scope | `READ` | `WRITE` | Commercial | Status |
|---|---|---|---|---|---|---|---|
| `CFG-10` | Soft-deleted account retention | ⛔ **HOLD** | — | — | — | — | ⚠️ **PROPOSED** |
| `SCFG-4` | Username-history retention | ⛔ **HOLD** | — | — | — | — | ⚠️ **PROPOSED** |

⭐ **Proposed rationale:** ⛔ **Privacy Owner determination required.**

---

### 5A.4 Group 4 — **PO + `BC-06` Owner** · 2 · ⚠️ PROPOSED

| ID | Parameter | Proposed | Scope | `READ` | `WRITE` | Commercial | Status |
|---|---|---|---|---|---|---|---|
| `SMCFG-5` | Enrollment number format | ⛔ **HOLD** | — | — | — | — | ⚠️ **PROPOSED** |
| `SEAT-CFG-017` | Occupancy % emitting `SEAT-EVT-004` | ⛔ **HOLD** | ⚠️ *unresolved — `Tenant` **or** `Branch`* | — | — | — | ⚠️ **PROPOSED** |

⭐ **Proposed rationale:** ⛔ **`SM-GAP-2` and `SEAT-GAP-005` remain unresolved.**

⚠️ ⭐ `SEAT-CFG-017`'s scope stays **expressly unresolved** — `SEAT-XC-022` admits
**`Branch`** where `BC-06` owns the parameter, and ⛔ this proposal does **not**
convert it to `Tenant`.

---

### 5A.5 Group 5 — **Security Owner + `BC-13`/`BC-18`** · 4 · ⚠️ PROPOSED

| ID | Parameter | Proposed | Scope | `READ` | `WRITE` | Commercial | Status |
|---|---|---|---|---|---|---|---|
| `ATT-CFG-013` | Face enrollment required | ⛔ **HOLD** | — | — | — | — | ⚠️ **PROPOSED** |
| `ATT-CFG-014` | Face match confidence threshold | ⛔ **HOLD** | — | — | — | — | ⚠️ **PROPOSED** |
| `ATT-CFG-015` | Face liveness required | ⛔ **HOLD** | — | — | — | — | ⚠️ **PROPOSED** |
| `ATT-CFG-016` | Face mode enabled | ⛔ **HOLD** | — | — | — | — | ⚠️ **PROPOSED** |

⭐ **Proposed rationale:** ⛔ **`ATT-FR-064` blocks Face Verification build
authorization**; ⛔ **`ATT-CFG-014` is explicitly outside V1**.

⚠️⚠️ **A distinction the confirming authority should preserve:** ⭐ the four are
**not** held on one ground. ⛔ `ATT-CFG-014` is outside V1 *(`D-3a`, Face = **V3**;
both §16.3 columns read "Not in V1")*, whereas ⭐ `013`/`015`/`016` **DO carry V1
defaults** and are held **only** because `ATT-FR-064` forbids building the mode
while `ATT-GAP-012`/`014` stay open. ⭐ **If those two gaps are answered,
`013`/`015`/`016` could move — ⛔ `014` would not.**

---

### 5A.6 ⭐ Reconciliation of the proposals

| Group | Authority | Proposed `HOLD` | Proposed `AUTHORIZE` |
|---|---|---:|---:|
| 1 | Authorization Owner | **7** | **0** |
| 2 | PO + SECURITY PLATFORM | **10** | **0** |
| 3 | Privacy Owner | **2** | **0** |
| 4 | PO + `BC-06` Owner | **2** | **0** |
| 5 | Security Owner + `BC-13`/`BC-18` | **4** | **0** |
| | **TOTAL** | ⭐ **25** | ⛔ **0** |

⭐⭐ **25 proposed-held + 79 authorized = 104.** ⛔ The **79** are untouched by this
section, and ⛔ the **104** inventory is unchanged.

---

## 6. Return format

⭐ One row per parameter. ⭐ `HOLD` needs only fields **1** and **6**.

```
ID | DECISION | SCOPE | READ | WRITE | COMMERCIAL | RATIONALE
```

### 6.1 ⛔ What will NOT be done on receipt

⛔ **Nothing will be inferred beyond what you write.** ⭐ Specifically: ⛔ an
answer for one group will **not** be carried to another; ⛔ a `WRITE` will not
imply a `READ`, nor the reverse; ⛔ ⚪ `N/A` will not be recorded as ⛔ `DENY`;
⛔ no `PERM-*` will be created; ⛔ no frozen document will be amended; ⛔ the
**104** inventory will not change.

⭐ Each answered group will be recorded in **its own ADR**, registered in
`ADR-INDEX`, reflected in `DD-0007`, validated and pushed. ⭐ **Partial returns
are useful** — a group can be recorded as soon as it arrives.

### 6.2 ⭐ Current state, for context

⭐ **79 / 104 authorized** *(76.0%)* · ⛔ **25 held** · ⭐ **79 + 25 = 104**, exact.
**D1 PASS · D2 PASS · ⚠️ D3 `PARTIAL` · D4 PASS · D5 PASS** · QA **13/13** ·
**4** Figma blockers · surfaces **3 of 5**.

⛔⛔ **`DD-0007` is NOT design-ready, and D3 is the sole remaining declaration
blocker.** ⭐ It closes only when all 25 are resolved — ⛔ **and `HOLD` remains a
correct answer for any of them.** ⛔ **Please do not authorize anything merely
to close it.**

---

## 7. Provenance

⛔ **This sheet authorizes nothing, decides nothing, and changes no count.**
⭐ It quotes only existing frozen and authoritative sources; ⛔ **0** `PERM-*`,
⛔ **0** roles/actions/scopes, ⛔ **0** frozen edits, ⛔ **0** runtime code,
⛔ **0** parameters moved.

| Source | Used for |
|---|---|
| `PRD-006` *(FROZEN v1.9, `d4731e10`)* | 1.1–1.3 · Group 5 |
| `PRD-007` *(FROZEN v1.1, `03a8ba0a`)* | 1.4–1.5 · 4.2 |
| `PRD-004` *(FROZEN v1.2, `93322b23`)* | 4.1 |
| `Student_Identity_PRD_v1` *(`de9efeb7`)* | 1.7 · 3.2 |
| `INVITATION_SECURITY_SPECIFICATION` *(`1c680a3d`)* | Group 2 |
| `CONFIGURATION_GUIDE` *(`e435d4f7`)* | 1.6 · 2 · 3.1 |
| `ADR-0151`…`ADR-0158` | constraints and precedent |

---

## 5B. ⭐⭐ ASSESSMENT RESULTS — `ADR-0160` parallel closure pass *(2026-09-19)*

⛔⛔ **THIS SECTION IS AN ASSESSMENT, ⛔ NOT AN AUTHORITY RESPONSE.** ⭐ `DP-0001`
remains **OPEN** with ⛔ **0 authority responses received**. ⚠️ §5A's PROPOSED
dispositions are **unchanged and unaltered** by this section.

⭐ Recorded under `Accepted`
[`ADR-0160`](../adr/ADR-0160-dp-0001-parallel-closure-pass-all-25-assessed-zero-authorized-blockers-re-characterized.md).

### 5B.0 ⛔⛔ The headline

| | |
|---|---|
| Parameters assessed | ⭐ **25 of 25** |
| ✅ **AUTHORIZED** | ⛔⛔ **0** |
| Coverage | ⭐ **UNCHANGED at 79 / 104** · ⛔ **D3 `PARTIAL`** · ⛔ **`DD-0007` NOT design-ready** |

⭐⭐ **Not one parameter was authorized, and none was authorized to reduce the hold
count.** ⭐ What the pass produced instead is **four re-characterized blockers** and
**two structural findings**.

### 5B.1 Verdicts — all 25

| ID | Group | ⭐ Verdict | Ground |
|---|---|---|---|
| `ATT-CFG-022` | 1 | ⚠️ **NEEDS OWNER DECISION** | §19.2 **L1980** — a `TR-1` write removes a `TR-2`/`TR-3` capability |
| `ATT-CFG-023` | 1 | ⚠️ **NEEDS OWNER DECISION** | ⭐ Time-bounds `022`; ⛔ not separable |
| `ATT-CFG-024` | 1 | ⚠️ **NEEDS OWNER DECISION** | §19.2 **L1983** — gates `TR-5` parent visibility |
| `SEAT-CFG-005` | 1 | ⚠️ **NEEDS OWNER DECISION** | `SEAT-PO-010` = **`C`** — ⭐ the parameter **IS** the grant |
| `SEAT-CFG-014` | 1 | ⚠️ **NEEDS OWNER DECISION** | `SEAT-PO-007` = **`C`**; `SEAT-AC-080` denies while unset |
| `CFG-12` | 1 | ⚠️ **NEEDS OWNER DECISION** ⛔ **+ missing office** | ⭐ Self-referential *(bounds `PR-2`'s own ceiling)*; ⛔ owner of record names **Legal** — §5B.3 |
| `SCFG-2` | 1 | ⛔ **HOLD** | ⛔ The source says *"requires **review**"* and **never says by whom** |
| `ICFG-1`…`ICFG-10` | 2 | ⛔ **HOLD** *(all 10)* | ⛔ **`Q-B` `READ` = zero statements**; ⛔ **`Q-C` `WRITE` = no role**, only `INV-SEC-018`'s prohibition |
| `CFG-10` | 3 | ⛔ **HOLD** + ⚠️⚠️ **ROUTING CONFLICT** | §5B.2 |
| `SCFG-4` | 3 | ⛔ **HOLD** + ⚠️⚠️ **ROUTING CONFLICT** | §5B.2 |
| `SMCFG-5` | 4 | ⛔ **HOLD** | ⭐ **The definition itself is undecided** — `SM-GAP-2` OPEN, **0** ADRs |
| `SEAT-CFG-017` | 4 | ⛔ **HOLD** | ⭐ Three grounds intact: `BC-06`-owned · *"Unset in V1"* · `SEAT-GAP-005` OPEN. ⛔⛔ **90% NOT applied as a fallback** |
| `ATT-CFG-013` | 5 | ⛔ **HOLD** | ⚠️ Has a V1 value — ⛔ but `ATT-FR-064` forbids building the mode |
| `ATT-CFG-014` | 5 | ⛔ **HOLD** | ⛔⛔ **Independently outside V1** *(`D-3a`, Face = **V3**)* — ⭐ would **not** move even if the gaps closed |
| `ATT-CFG-015` | 5 | ⛔ **HOLD** | ⚠️ Has a V1 value — same bar as `013` |
| `ATT-CFG-016` | 5 | ⛔ **HOLD** | ⚠️ Has a V1 value; ⭐ its own domain note reads *"blocked by `ATT-FR-064`"* |

⭐ **Totals:** ⛔ **19** HOLD · ⚠️ **6** NEEDS OWNER DECISION · ⚠️ **2** CONFLICT
*(routing, on 2 already-held parameters)* · ✅ **0** AUTHORIZE.
⭐⭐ **79 + 25 = 104**, exact.

### 5B.2 ⭐⭐ What CHANGED — four blockers re-characterized

1. ⭐⭐ **Group 1's blocker changed CLASS.** ⛔ Before: *"the `Authorization Owner`
   office does not exist"* — **unanswerable by any evidence**. ⭐ Now, after
   `Accepted` `ADR-0159` constituted it: *"the office exists and is **VACANT**"* —
   ⭐ **answerable by an appointment**, a far smaller act.
2. ⭐⭐ **`Q-A` IS RESOLVED — NEGATIVELY, BY MEASUREMENT.** ⭐ All **10** `ICFG` sit
   in the §4 **per-environment** table; ⭐ the *"per library"* wording occurs **only
   inside the NAMES** of `ICFG-5`/`ICFG-7` *(a **counting unit**, not a scope)*; ⛔
   the `LCFG` per-library carve-out at **L829** **names no `ICFG`**. ⭐ This applies
   the **existing** `ADR-0153` precedent — *a name is not a scope declaration*.
   ⛔⛔ **BUT THE POSITIVE SCOPE CLASS IS STILL NOT ALLOCATED** — ⭐ reading is not
   deciding. ⛔ **`Q-B` and `Q-C` remain at ZERO evidence.**
3. ⚠️⚠️ **A ROUTING CONFLICT IN THIS PACK ITSELF.** ⭐ §3 routes `CFG-10`/`SCFG-4`
   to the **Privacy Owner**. ⛔ `LEGAL_RISK_REGISTER` **`LR-01`** records retention
   legal basis as *"**PERMANENTLY OPEN** … **NOT closable by** Product, Domain,
   Architecture, Technical, **Privacy**, Governance, SRE, EVENT-platform or
   DATA/EVENT Owner, **jointly or severally**"*. ⭐ **The limit, stated honestly:**
   `LR-01` governs the **legal basis**; this pack asks the **narrower** allocation
   question — ⛔ but `CFG-10`'s hold reason **is** that legal question
   (*"defensible as erasure under DPDP"*). ⚠️ **The addressee must be corrected
   before an answer can lawfully be given.**
4. ⛔⛔ **GROUP 5 IS DEEPER THAN RECORDED.** ⭐ **`ATT-GAP-014` is named in `LR-01`'s
   own *"Related, all still OPEN and UNAMENDED"* list** — ⛔ entangling it with a
   question **no constituted office may close**.

### 5B.3 ⛔⛔ Two structural findings

| # | Finding |
|---|---|
| **1** | ⛔⛔ **An office named as owner of 4 held parameters DOES NOT EXIST — and was EXPRESSLY REFUSED.** *"Legal Owner"* measures **0** repository-wide, and `Accepted` **`ADR-0137`** states ⛔ *"Does **not** constitute **Legal Counsel** as an office"*. ⭐ It is the owner of record for **`CFG-10`**, **`CFG-12`**, and via their gaps **`ATT-GAP-012`**/**`ATT-GAP-014`** *(which block 4 Face parameters)*. ⭐⭐ **`ADR-0160` deliberately did NOT repeat `ADR-0159`'s remedy** — constituting it would **overturn an `Accepted` ADR by side effect**, and ⭐ `LR-01` shows the missing input is an **external determination**, ⛔ **not an internal office** |
| **2** | ⚠️⚠️ **`Branch` IS NOT A CONSTITUTED SCOPE CLASS.** ⭐ Only **`Tenant`**, **`Platform default`** and **`Library`** are in use across `ADR-0151`…`ADR-0157`. ⛔ So `SEAT-CFG-017` could **not** be branch-scoped even if its owner decided to, without a **prior constituting act** |

### 5B.4 ⭐ Two routing facts resolved *(⛔ neither is a decision)*

| | ⭐ Resolved |
|---|---|
| **The `BC-06` incumbent** | ⭐ `PRD_REGISTRY` **L456** maps **`BC-06` → `PRD-002`**, whose Domain Owner is **Library Domain** *(`PRD_OWNERSHIP_MODEL` **L147**)*. ⭐ `SEAT-CFG-017` is now **addressable**; ⛔ the decision is still **not made** |
| **Group 5's Security limb** | ⭐ Addressable via `ADR-0159` **§17** — ⛔ but **blocked** by the missing Legal co-owner |

### 5B.5 ⛔⛔ Two arguments tested and REFUSED

| Argument | Disposition |
|---|---|
| ⭐ *"Authorize Group 1's `WRITE` — `PRD-006` §16.3 and `SEAT-PO-021` already frozen-state `TR-1`"* | ⛔⛔ **REFUSED.** ⭐ The strongest available case, and it still fails: **(1)** `READ` has **no** decision — `ADR-0153` decided **17 named** parameters and ⛔ **these are not among them**; **(2)** `CNF-BR-010` makes the dimensions **independent**, so a `WRITE`-only record resolves nothing for **D3**; **(3)** ⭐⭐ the live question is **whether a configuration write may confer or remove a role capability at all** — ⛔ **undecided**, catalogue closed at **zero** |
| ⭐ §5.1's *"configuration authority may be allocated **ahead of** build authorization"* | ⛔⛔ **EXPRESSLY DECLINED.** ⭐ A **new precedent** that would allocate authority over settings of a mode a **FROZEN `MUST NOT`** forbids building; `PRD-006` calls the risk *"a **legal exposure**, not a scheduling detail"* |

⭐ `ADR-0158` §2.4b's refusal of the `PR-n` `ICFG` argument is ⭐ **CONFIRMED**, ⛔ not
overruled — ⛔ no express authority to overrule it was presented.

### 5B.6 ⛔ Status after this pass

| | |
|---|---|
| `DP-0001` | ⛔ **OPEN** · ⛔ **0 authority responses** · ⭐ §5A **unchanged** |
| Coverage | ⭐ **79 / 104** — ⛔ unchanged · ⛔ **D3 `PARTIAL`** · ⛔⛔ **NOT design-ready** |
| Created | ⛔ **0** `PERM-*` · **0** roles/actions/scopes · **0** holders · **0** frozen edits · **0** runtime code |
