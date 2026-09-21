<!-- LIBOORA Governance | Decision Pack | DP-0005 | 2026-09-19 -->

> This document is a **decision request**. ⛔ It decides nothing, allocates nothing,
> appoints nobody, and creates no permission, role, scope or `PERM-*` identifier.
> ⭐ It exists so that the office holding the authority can decide **in one sitting**.

# `DP-0005` — `ICFG-1` … `ICFG-10` READ authorization decision pack

| Field | Value |
|---|---|
| **Pack** | `DP-0005` |
| **Status** | ⛔⛔ **PENDING AUTHORITY** |
| **Rank** | ⛔ **UNRANKED** |
| **Subject** | ⭐ **10** held `BC-25` parameters — `ICFG-1` … `ICFG-10` |
| ⭐⭐ **Deciding office** | ⭐⭐ **Authorization Owner** — `PRD_OWNERSHIP_MODEL` **§16.1**, constituted by `Accepted` **`ADR-0159`** |
| **Contributing offices** | **Product Owner** *(V1 read-surface scope)* · **Security Owner** *(security review; ⛔ **no permission authority** — `ADR-0158` §2.1b)* |
| **Blocker** | `B-3′` *(`ADR-0162` §11)* — ⭐ the **largest single internally-decidable** `BC-25` blocker |
| **Effect if decided** | ⭐ Coverage **85 / 104 → 95 / 104**; held **19 → 9** |
| ⛔ **Effect of this pack alone** | ⛔⛔ **ZERO.** ⭐ Coverage stays **85 / 104**, held stays **19**, all ten stay **HELD** |

---

## 1. ⭐⭐ Appointing authority — the finding

⭐ The question: *can the vacancy be resolved, or is there a governance gap?*
⭐⭐ **Neither. The vacancy is real but it is NOT a blocker — and the evidence is
unambiguous.**

### 1.1 The office has already been exercised — **five times, while vacant**

| # | Act | ADR | Status |
|---|---|---|---|
| 1 | `BC-02` operation×role allocation | `ADR-0150` **L8** | ⭐ **`Accepted` — exercised** |
| 2 | `BC-25` configuration allocation *(22 params)* | `ADR-0151` **L8** | ⭐ **`Accepted` — exercised** |
| 3 | `ATT-CFG` allocation *(17 params)* | `ADR-0153` **L8** | ⭐ **`Accepted` — exercised** |
| 4 | `SCFG` allocation `S-3` | `ADR-0155` | ⭐ **`Accepted` — exercised** |
| 5 | ⭐⭐ `ATT-CFG-022/023/024` + `SEAT-CFG-005/014` | **`ADR-0162`** | ⭐⭐ **`Accepted` — exercised THIS chain** |

⭐⭐ **`ADR-0162` — the very act that produced today's 85 / 104 — exercised the
Authorization Owner office.** ⛔ So the office being *vacant* has demonstrably **not**
prevented authorization decisions from being taken.

### 1.2 ⭐ The mechanism — **conferral**, not appointment

`ADR-0162`'s own authority cell:

> ⭐⭐ *"**A one-act conferral of the human principal of this engagement** … ⛔ **Reverting
> on completion** (`ADR-0033` §7.1: *'a conferral for one act is not a standing licence'*).
> ⚠️ Offices exercised: **Authorization Owner** (§16), **Product Owner**, **SECURITY
> PLATFORM / Security Owner** (§17). ⚠️ **All by one principal — ⛔ no independent review
> is claimed.**"*

⭐⭐ **This is the appointing path, and it is already established.** ⛔ It is **not** an
appointment — it confers authority **for one act**, and **reverts on completion**.

### 1.3 ⚠️ Why the office reads "vacant" — a representation artifact

`PRD_OWNERSHIP_MODEL` §16.1: *"**One holder, per §3 rule 1.** ⛔ **No personal name is
recorded**, per §7 rule 4. The office is **vacant as constituted**."*

⭐⭐ **§7 rule 4 forbids recording a personal name in the repository at all** — *"If a
name is needed operationally, it belongs in a team directory **outside the
repository**."* ⭐ So **no office in this repository can ever read as "filled"**; the
Product, Domain, Architecture and Technical Owners are in the same position.

⚠️⚠️ **"Vacant" therefore does not mean "unreachable."** ⛔ Treating it as a blocker
would be an error — and it would also imply that `ADR-0150`, `0151`, `0153`, `0155` and
`0162` were all invalid, which ⛔ **no repository document asserts** and which would
overturn five `Accepted` ADRs by side effect.

### 1.4 ⛔ What this pack therefore does **not** do

⛔ **No holder is appointed, named, nominated or implied.** ⛔ No appointing authority is
invented. ⭐ The existing conferral mechanism is **identified and cited**, ⛔ not created.

⚠️ **One limit, stated plainly:** ⭐ a conferral is the **human principal's** act. ⛔ **I
cannot confer it, and I have not.** ⭐ This pack is what makes such a conferral
*decidable in one sitting* — ⛔ it is not the conferral.

---

## 2. ⭐ The evidence, re-verified for this pack

### 2.1 What is settled

| Question | Answer | Source |
|---|---|---|
| **Owning source** | `INVITATION_SECURITY_SPECIFICATION.md` §4, §6, §9, §14 | measured |
| **Register** | `CONFIGURATION_GUIDE.md` §2B **L409–426** | measured |
| **Scope** | ⭐ **`Platform default` (scope 1)** — RESOLVED | `ADR-0163` §3; `CNF-FR-026`, `CNF-FR-003`, `CNF-FR-028`; **10/10** in the env table **L806–815** |
| **Ownership** | ⭐ **`BC-25`** | `CONFIGURATION_GUIDE` **L8** |
| **Values + ranges** | ⭐ **All 10 defined**, with `INV-13`…`INV-16` invariants | §14 **L493–502** |
| **Commercial** | ⭐ **NOT COMMERCIAL** | `ADR-0162` |
| **WRITE** | ⛔ **No role.** Only `INV-SEC-018`'s prohibition — *"**MUST NOT** be overridable by any library role, including `TR-1` Owner"* | measured |

### 2.2 ⭐⭐ What is absent — the entire blocker

⭐ Word-anchored sweep across **both** owning sources, **12 probe phrases, all zero**:

```
"may read" 0 · "read authority" 0 · "readable by" 0 · "who may read" 0
"can read" 0 · "permitted to read" 0 · "views the setting" 0 · "SHALL read" 0
"MUST read" 0 · "read access" 0 · "view the value" 0 · "visible to" 0
```

⭐⭐ **The owning specification contains exactly ONE occurrence of the word "read", and
it is RESTRICTIVE:**

> **`INV-SEC-001`** — *"This specification **MUST NOT** be **read** as granting this
> module any authentication or authorisation capability."*

⭐ Role tokens present: `TR-1`×6, `TR-2`×6, `TR-3`×3 — ⛔ **all in write/enforcement
contexts, none in a read context**. ⛔ `PR-1`/`PR-2` = **ZERO**.

### 2.3 ⛔ Four arguments tested and refused — ⭐ carried so the decider need not re-run them

| Tempting argument | ⛔ Why refused |
|---|---|
| *"Scope is `Platform default`, same as `CFG-*` → copy the `CFG-*` READ"* | ⛔⛔ **A shared scope is not a shared decision.** `ADR-0154` rested on `PRD-023`-specific evidence **absent here**. Barred by **`AUTH-7.24`** — *"Read **MUST NOT** imply any other action"*, which runs **both ways** |
| *"`INV-SEC-018` denies every library role → so `PR-n` holds it"* | ⛔ **A denial of `TR-n` is not a grant to `PR-n`** — **`AUTH-7.28`**, *"No permission implies another"* |
| *"`ICFG-10` 'Matches `CFG-4`' → inherit `CFG-4`'s allocation"* | ⛔ That is a **value rationale**, ⛔ not an authority statement |
| *"Security-owned → SECURITY PLATFORM reads it"* | ⛔ *"Security-owned"* names a **reviewing office**; `ADR-0158` §2.1b gives it **no permission authority** |

⭐⭐ **This is the fifth time the shortcut has been available and the fifth refusal.**

---

## 3. ⭐⭐ The decision table — `ICFG-1` … `ICFG-10`

⭐ Values transcribed verbatim from `INVITATION_SECURITY_SPECIFICATION.md` §14
**L493–502**. ⛔ **No value is changed, proposed or re-derived.**

| ID | Value *(range)* | Scope | Owner | Current READ | Product question | Security question | Authorization decision required |
|---|---|---|---|---|---|---|---|
| `ICFG-1` | **48 h** *(1 h – 7 d)* | `Platform default` | `BC-25` | ⛔ **ABSENT** | Does staff invitation TTL appear in any V1 surface? | Does exposing TTL aid invitation-timing attack? | ⭐ Allocate READ to a named existing role, **or** determine no read surface |
| `ICFG-2` | **7 d** *(1 h – 30 d)* | `Platform default` | `BC-25` | ⛔ **ABSENT** | Student-facing invite expiry visibility? | Low — expiry is already implied to the invitee | ⭐ Same |
| `ICFG-3` | **24 h** *(1 h – 7 d)* | `Platform default` | `BC-25` | ⛔ **ABSENT** | Access-code expiry shown to issuer? | ⚠️ **Elevated** — lowest-entropy artefact | ⭐ Same |
| `ICFG-4` | **15 min** *(5 – 60 min)* | `Platform default` | `BC-25` | ⛔ **ABSENT** | Is the acceptance window surfaced during OTP? | Bound by `INV-15` *(> `CFG-2`×`CFG-1`)* | ⭐ Same |
| `ICFG-5` | **50** *(1 – 500)* | `Platform default` | `BC-25` | ⛔ **ABSENT** | Should a library see its outstanding-invite cap? | ⚠️ Reveals **blast-radius bound** | ⭐ Same |
| `ICFG-6` | **25** *(1 – 200)* | `Platform default` | `BC-25` | ⛔ **ABSENT** | Should the issuer see remaining acceptances? | Bound by `INV-16` *(≥ 1)* | ⭐ Same |
| `ICFG-7` | **20** *(1 – 100)* | `Platform default` | `BC-25` | ⛔ **ABSENT** | Surfaced when a rate limit is hit? | ⚠️ Reveals **issuing-side** rate limit | ⭐ Same |
| `ICFG-8` | **20** *(5 – 100)* | `Platform default` | `BC-25` | ⛔ **ABSENT** | Surfaced to a throttled invitee? | ⛔⛔ **HIGHEST** — §9 L449: *"**`ICFG-8` at 20/hour is what makes 40-bit `IT-3` entropy safe in practice**"* | ⭐ Same |
| `ICFG-9` | **10** *(3 – 50)* | `Platform default` | `BC-25` | ⛔ **ABSENT** | Shown as "attempts remaining"? | ⚠️ **High** — discloses the throttle threshold | ⭐ Same |
| `ICFG-10` | **30 min** *(5 – 120 min)* | `Platform default` | `BC-25` | ⛔ **ABSENT** | Shown as "try again in…"? | ⚠️ Moderate — OWASP-bounded | ⭐ Same |

⭐⭐ **The authorization question is byte-identical for all ten.** ⚠️ **The security
question is NOT** — `ICFG-8` and `ICFG-9` carry materially higher exposure. ⭐ **They may
be decided together or separately; ⛔ this pack does not collapse that choice.**

---

## 4. ⭐⭐ The two legitimate outcomes

⛔⛔ **Neither is chosen here. ⛔ No existing authoritative decision establishes either.**

### Outcome A — explicit READ allocation

⭐ Name an **existing** role permitted to read. ⭐ Candidate roles exist and are **closed
sets**: `TR-1`…`TR-5` *(tenant)*, `PR-1`/`PR-2` *(platform)*.

⛔ **Constraints binding whoever decides:**
⛔ Must name an **existing** role — `AUTH-7.22` closes the catalogue at **zero**, so
⛔ **no `PERM-*` may be minted** *(and minting is an **Architecture Owner** act anyway,
`ADR-0132` §7 row 7)*. ⛔ Must not derive from naming or seniority *(`AP-4`)*. ⛔ READ
grants nothing else *(`AUTH-7.24`)*.

### Outcome B — explicit NO-READ determination

⭐ Determine that these are **enforced internally with no read surface in V1**.

⭐⭐ **Why this outcome is genuinely available and not a cop-out:** `INV-SEC-001` already
disclaims that the module grants any authorisation capability; `INV-SEC-018` makes the
values **non-overridable**; and §9 **L449** states the security posture depends on
`ICFG-8` **not** being tuned or exposed casually. ⭐ A determination that security
thresholds are enforced-but-never-displayed is **coherent, sourced and closable**.

⚠️ **Outcome B closes the hold without granting anything** — ⭐ but it is still a
**decision**, ⛔ not a default, and ⛔ **it is not taken here**.

---

## 5. ⭐ Ready-to-execute decision artifact

⭐ **Artifact required:** a **Rank-2 ADR** — the instrument used by `ADR-0150`, `0151`,
`0153`, `0155`, `0157` and `0162` for every prior allocation. ⛔ **Not** a DDR *(design
cannot allocate authorization)*; ⛔ **not** a `DD-0007` edit *(unranked, and `ADR-0156`
`O-5`: "authorization is not design")*.

⭐ **Next free identifier: `ADR-0164`** *(verified: `ADR-0163` is the highest present)*.
⛔ **Not created, not reserved.**

### 5.1 ⭐ The decision form — ⛔ blanks are the authority's to fill

> **`ADR-0164` — `ICFG-1` … `ICFG-10` READ disposition**
> **Status:** `Accepted` · **Rank:** 2
> **Authority instrument:** a one-act conferral of the human principal, exercising the
> **Authorization Owner** office *(`PRD_OWNERSHIP_MODEL` §16.1, `ADR-0159`)*, with
> **Product Owner** and **Security Owner** input; ⛔ reverting on completion
> *(`ADR-0033` §7.1)*.
>
> **Decision — ONE of:**
> **(A)** READ over `ICFG-1`…`ICFG-10` is allocated to **`________`** *(existing role)*
> at scope `Platform default`. WRITE remains ⚪ `N/A` per `INV-SEC-018`.
> **(B)** `ICFG-1`…`ICFG-10` have **no read surface in V1**. They are enforced
> internally. ⛔ No role may read them; ⛔ no surface may render them.
>
> ⚠️ *If `ICFG-8`/`ICFG-9` are treated differently, state them separately.*
>
> **Consequences:** coverage **85 / 104 → 95 / 104**; held **19 → 9**; `DD-0007` §6.5
> row 4 leaves the register; ⛔ **D3 stays `PARTIAL`**; ⛔ **`DD-0007` stays NOT
> design-ready**; ⛔ **0 `PERM-*`**; ⛔ the 9 remaining holds untouched.

⛔⛔ **This form is NOT filled in, NOT signed, and NOT self-approved.**

---

## 6. Current vs post-decision state

| | Now | If `ADR-0164` is decided |
|---|---|---|
| Authorized | **85 / 104** *(81.7%)* | ⭐ **95 / 104** *(91.3%)* |
| Held | **19** | ⭐ **9** |
| `ICFG-1…10` | ⛔ **HELD** | ⭐ **Resolved** *(A or B)* |
| Remaining holds | 4 Face · 10 `ICFG` · 2 retention · `SEAT-CFG-017` · `CFG-12` · `SCFG-2` | ⭐ 4 Face · 2 retention · `SEAT-CFG-017` · `CFG-12` · `SCFG-2` |
| Of which **externally gated** | **6** *(`LR-01`)* | **6** — ⛔ unchanged |
| D3 | ⚠️ `PARTIAL` | ⚠️ **`PARTIAL`** — ⛔ still not `PASS` |
| Design-ready | ⛔ **NO** | ⛔ **NO** |
| Figma gate | ⛔ **CLOSED** | ⛔ **CLOSED** |

⭐⭐ **This is the single largest internally-decidable move available** — **10 of the 19**
holds, **more than half**, and ⛔ **none of them externally gated**.

⚠️⚠️ **But it does NOT make `DD-0007` design-ready.** ⭐ Even at **95 / 104**, D3 stays
`PARTIAL`, the **6** `LR-01`-gated holds remain, and Figma blockers **3** and **4**
*(`DD7-GAP-007` UI design system, `DD7-GAP-009` NFR budgets)* are **design-system**
questions, ⛔ untouched by any `BC-25` authorization.

---

## 7. ⛔ What this pack does **not** do

⛔ **0** READ allocated, inferred or recommended · ⛔ **0** `CFG-*` allocations copied ·
⛔ **0** `PERM-*` · ⛔ **0** holders appointed, named or implied · ⛔ **0** appointing
authorities invented · ⛔ **0** outcomes chosen between A and B · ⛔ **0** holds closed ·
⛔ **0** counts changed *(**85 / 19 / 104** stand)* · ⛔ **0** roles, scopes or action
classes · ⛔ **0** PRD, ADR, `DD-0007`, code or Figma edits · ⛔ no commit, no push.

⭐⭐ **`ICFG-1` … `ICFG-10` REMAIN HELD.**

---

# ⛔⛔ PENDING AUTHORITY — Authorization Owner
