# ADR-0164 — `ICFG-1` … `ICFG-10` have **no READ surface in V1**

| Field | Value |
|---|---|
| **Status** | ⭐⭐ **Accepted** — **2026-09-19**, under the one-act conferral recorded **verbatim** at **§10.2**. ⛔ **Reverting on completion** *(`ADR-0033` §7.1)*. ⚠️⚠️ **NO INDEPENDENT REVIEW CLAIMED** — all offices exercised by one principal |
| **Rank** | 2 — Architecture Decision Record |
| **Date prepared** | 2026-09-19 |
| **Bounded context** | `BC-25` Configuration *(owning)*; `BC-18` Identity & Access *(authorization semantics)*; Invitation Security *(source)* |
| **Supersedes** | ⛔ **NOTHING** |
| **Superseded by** | — |
| ⭐⭐ **Deciding authority required** | ⭐⭐ **Authorization Owner** — `PRD_OWNERSHIP_MODEL` **§16.1**, constituted by `Accepted` **`ADR-0159`** |
| **Contributing offices** | **Product Owner** *(V1 read-surface scope)* · **Security Owner** *(security review; ⛔ **no permission authority** — `ADR-0158` §2.1b)*. ⛔ **Neither is the deciding permission authority** |
| **Decides** *(if accepted)* | ⭐ **`ICFG-1` … `ICFG-10` only** — **10** parameters. ⛔ **Nothing else** |
| **Expressly does NOT decide** | ⛔ The other **9** held parameters · ⛔ any `PERM-*` · ⛔ any role, action class or scope · ⛔ `DD-0007`'s counts or design-readiness |
| **Amends** | ⛔⛔ **NOTHING while `Proposed`.** ⭐ On acceptance: `DD-0007` §6.5 row 4 and §6.2 band table — ⭐ a **separate UX Architecture Owner act**, ⛔ not performed here |
| **Origin** | ⭐ [`DP-0005`](../decisions/DP-0005-icfg-read-authorization-decision-pack.md) **Outcome B** |

> ⭐⭐ **Identifier check, performed before drafting.** `ADR-0163` is the highest ADR file
> present. `ADR-0164` measured **3** occurrences repo-wide — ⭐ **all three are
> forward-references inside `DP-0005`**, which names it as the next free identifier;
> ⛔ **0 are allocations**. `ADR-INDEX.md` **L206** — *"Number sequentially. **Never reuse
> a number.**"* — is satisfied.

---

## 1. Context

⭐ `ICFG-1` … `ICFG-10` are the **ten invitation-security configurables** owned by
`BC-25`. They have been **HELD** — unauthorized — across seven prior passes.

⭐ **What is already settled**, and is **not** reopened here:

| Question | State | Source |
|---|---|---|
| **Owning source** | `INVITATION_SECURITY_SPECIFICATION.md` §4, §6, §9, §14 | measured |
| **Register** | `CONFIGURATION_GUIDE.md` §2B **L409–426** | measured |
| **Scope** | ⭐ **`Platform default` (scope 1)** — **RESOLVED** | `ADR-0163` §3; `CNF-FR-026`, `CNF-FR-003`, `CNF-FR-028`; **10/10** in the env-profile table **L806–815** |
| **Ownership** | ⭐ **`BC-25`** | `CONFIGURATION_GUIDE` **L8** |
| **Values + ranges** | ⭐ All **10** defined, with invariants `INV-13`…`INV-16` | §14 **L493–502** |
| **Commercial** | ⭐ **NOT COMMERCIAL** | `ADR-0162` |
| **WRITE** | ⛔ **No role.** Only `INV-SEC-018`'s prohibition | measured |
| ⭐⭐ **READ** | ⛔⛔ **ABSENT — the entire blocker** | §2 below |

⚠️ **`B-3′`** *(`ADR-0162` §11)* records these ten as the **largest single
internally-decidable** `BC-25` blocker — **10 of 19** held parameters, ⛔ none of them
externally gated.

---

## 2. ⭐⭐ The measured evidence — READ is absent, not merely unlocated

⭐ A **word-anchored** sweep across **both** owning sources. ⭐ Twelve probe phrases,
⛔ **all zero**:

```
"may read"  0    "read authority"    0    "readable by"        0
"who may read" 0 "can read"          0    "permitted to read"  0
"views the setting" 0 "SHALL read"   0    "MUST read"          0
"read access" 0  "view the value"    0    "visible to"         0
```

⭐⭐ **The owning specification contains exactly ONE occurrence of the word "read" — and
it points AWAY from authorization:**

> **`INV-SEC-001`** *(§1.2, "Explicitly out of scope")* — *"This specification **MUST
> NOT** be **read** as granting this module any authentication or authorisation
> capability."*

⭐ **Role tokens present in the owning source:** `TR-1` ×6, `TR-2` ×6, `TR-3` ×3 —
⛔ **every one in a write or enforcement context, none in a read context**.
⛔ `PR-1`/`PR-2` = **ZERO**.

### 2.1 ⭐ Two source statements that positively support Outcome B

⭐⭐ **This decision is not merely the absence of contrary evidence. Two frozen
statements point toward it:**

| Source | Text | Bearing |
|---|---|---|
| **`INV-SEC-001`** | *"**MUST NOT** be read as granting this module any authentication or **authorisation capability**"* | ⭐ The owning source **disclaims** authorization capability. A no-read determination is **consonant** with it; a read allocation would sit **against** its grain |
| **`INV-SEC-018`** | *"An expired invitation **MUST** be refused, and refusal **MUST NOT** be overridable by **any library role, including `TR-1` Owner**"* | ⭐⭐ The values are **non-overridable by the most senior tenant role**. A configurable that no role may override is ⭐ **enforcement infrastructure**, ⛔ not an administrative setting |

---

## 3. ⭐⭐ Decision (proposed) — **OUTCOME B**

> ⭐⭐ **`ICFG-1` … `ICFG-10` have NO READ SURFACE IN V1.**
>
> ⭐ **(a)** ⛔ **No V1 application, admin or user surface is authorized to READ or
> display these values.** ⛔ No surface may render them, echo them, or disclose them
> indirectly *(e.g. as "attempts remaining", "retry in N minutes", or a displayed cap)*.
>
> ⭐ **(b)** ⭐ **Internal enforcement is unaffected.** The backend and security systems
> **MAY** continue to use these values internally to enforce TTLs, caps, rate limits and
> throttles exactly as `INVITATION_SECURITY_SPECIFICATION` §4, §6 and §9 require.
> ⭐⭐ **Enforcement is not a read surface.**
>
> ⭐ **(c)** ⛔⛔ **No role receives READ.** ⛔ Not `TR-1`…`TR-5`, ⛔ not `PR-1`/`PR-2`,
> ⛔ not the Security Owner, ⛔ not any platform role. ⭐ **This decision grants nothing
> to anyone.**
>
> ⭐ **(d)** ⛔⛔ **No `PERM-*` identifier is created, minted, reserved or implied.**
>
> ⭐ **(e)** ⭐ **A future requirement to expose any of these values requires a SEPARATE
> authorization decision** by the Authorization Owner. ⛔ This ADR does not pre-authorize
> it, and ⛔ **`ICFG-8`/`ICFG-9` would require specific security re-review** *(§5)*.

### 3.1 ⭐ What "no read surface" means precisely — ⛔ and what it does not

| Permitted | ⛔ Forbidden in V1 |
|---|---|
| ⭐ Backend evaluates `ICFG-3` and refuses an expired code | ⛔ Any UI displaying *"this code expires in 24 h"* **sourced from `ICFG-3`** |
| ⭐ Backend counts against `ICFG-6` and stops accepting | ⛔ Any UI showing *"18 of 25 acceptances used"* |
| ⭐ Backend throttles per `ICFG-9`/`ICFG-10` | ⛔ Any UI showing *"3 attempts left"* or *"retry in 30 minutes"* |
| ⭐ Environment profiles supply values at scope 1 | ⛔ Any admin screen listing the ten values |

⚠️⚠️ **A boundary this ADR draws deliberately.** ⭐ A refusal message may state **that**
an invitation is expired or throttled — that is `INV-SEC-018`'s own required behaviour.
⛔ **What it may not do is disclose the configured threshold or remaining budget**, which
is what would constitute a read of the parameter. ⭐ **The fact of refusal is not the
value.**

---

## 4. ⭐ Product input — recorded, ⛔ not treated as the authorization

⭐⭐ **Product Owner position:** ⭐ **V1 intentionally has no read surface for these
security thresholds.** ⭐ They are internal security/enforcement configuration; no V1
user or admin journey requires their display.

⚠️⚠️ **The limit of this input, stated plainly.** ⭐ The Product Owner decides
*"business intent: scope, priority, acceptance"* *(`PRD_OWNERSHIP_MODEL` §2.2)*, and
⭐ **whether a read surface is in V1 scope is squarely product.** ⛔ **But whether a role
may read a parameter is authorization**, and §16.3 records that ⛔ *"`ADR-0150`/`0151`/
`0153` each record a **joint Product Owner + Authorization Owner** conferral — ⭐ a joint
conferral is only meaningful if the offices differ."*

⭐⭐ **So the product input answers "is there a surface?" — ⛔ it does not answer "who may
read?", and it is NOT recorded here as having done so.**

### 4.1 ⭐⭐ The product confirmation, recorded **verbatim** — 2026-09-19

⭐ The human principal, exercising **Product Owner** input, confirmed the following.
⭐ Recorded **verbatim**, ⛔ not paraphrased, per the practice `ADR-0162` §2 and
`ADR-0159` both follow:

> *"Authorization decision:*
> *OUTCOME B — NO READ SURFACE IN V1.*
>
> *I confirm this as my decision input for the Authorization Owner process.*
>
> *Proceed only according to the established Authorization Owner conferral and ADR
> acceptance procedure.*
>
> *Do not self-approve.*
> *Do not assume authority from this message alone.*
> *Do not modify DD-0007 yet.*
> *Do not create PERM-\*.*
> *Do not close ICFG-1…10 until ADR-0164 is formally accepted through the required
> authority process."*

### 4.2 ⛔⛔ What this confirmation is — and what it expressly is **NOT**

⚠️⚠️ **This was TESTED against the conferral standard, ⛔ not assumed either way.**

| Question | Answer | Evidence |
|---|---|---|
| Is it a **Product Owner input**? | ⭐⭐ **YES** — and it is now the recorded position | *"I confirm this as my **decision input**"* |
| Is it a **one-act conferral** of the Authorization Owner office? | ⛔⛔ **NO — expressly declined** | *"**Do not assume authority from this message alone**"*; *"Proceed **only** according to the established … conferral and ADR acceptance procedure"* |
| Does it make `ADR-0164` `Accepted`? | ⛔⛔ **NO** | *"**Do not self-approve**"*; the header remains **`Proposed`** |
| Does it close `ICFG-1`…`10`? | ⛔⛔ **NO** | *"**Do not close ICFG-1…10 until ADR-0164 is formally accepted**"* |

⭐⭐ **The distinction that governs this section.** `ADR-0162`'s conferral reads *"**A
one-act conferral of the human principal of this engagement**"* — ⭐ language that
**grants** an office's exercise. ⛔ This message does the opposite: it **withholds** that
grant in terms, and routes the decision back to the established procedure.

⭐⭐ **Therefore the contributing-office column of §6 was SATISFIED for Product Owner by
this message, and the deciding column remained EMPTY at that moment.** ⛔ §10 stayed
**UNCOMPLETED**.

⚠️⚠️ **Superseded in fact on 2026-09-19 — recorded, ⛔ not rewritten.** ⭐ A **separate
and later** instrument — the first-person conferral at **§10.2** — supplied the
**Authorization Owner** limb, and §10 is now **COMPLETED**. ⭐⭐ **This section is left
standing as written because it proves the two instruments were distinct**: ⭐ the
Product-Owner message said *"Do not assume authority from this message alone"*; ⭐ the
conferral said *"I confer."* ⛔ **Collapsing them retrospectively would destroy the
evidence that they were never collapsed.**

---

## 5. ⭐ Security input — ⚠️ `ICFG-8` and `ICFG-9` distinguished

⭐ The security rationale is **preserved, not summarised away**. ⚠️ **Exposure risk is
NOT uniform across the ten, and this ADR does not flatten it.**

| ID | Value | Exposure if read-surfaced |
|---|---|---|
| `ICFG-1` | 48 h | ⚠️ Low–moderate — aids invitation-timing reasoning |
| `ICFG-2` | 7 d | ⭐ Low — expiry is already implicit to the invitee |
| `ICFG-3` | 24 h | ⚠️ **Elevated** — governs the **lowest-entropy** artefact (`IT-3`) |
| `ICFG-4` | 15 min | ⚠️ Low–moderate — bound by `INV-15` *(> `CFG-2` × `CFG-1`)* |
| `ICFG-5` | 50 | ⚠️ Moderate — discloses the **blast-radius bound** |
| `ICFG-6` | 25 | ⚠️ Moderate — bound by `INV-16` *(≥ 1)* |
| `ICFG-7` | 20 | ⚠️ Moderate — discloses the **issuing-side** rate limit |
| ⭐⭐ **`ICFG-8`** | **20** | ⛔⛔ **HIGHEST.** §9 **L449**: *"**`ICFG-8` at 20/hour is what makes 40-bit `IT-3` entropy safe in practice.**"* ⭐ §9 **L444**: *"**Raising `ICFG-8` therefore weakens `IT-3` even though the entropy figure does not change.**"* ⚠️ Disclosing the presentation budget **directly informs a guessing strategy** against a 40-bit secret |
| ⭐ **`ICFG-9`** | **10** | ⚠️⚠️ **HIGH** — discloses the **exact throttle threshold**, letting an attacker pace attempts to stay **just below** it |
| `ICFG-10` | 30 min | ⚠️ Moderate — OWASP-bounded; *"long locks are themselves a DoS vector"* |

⭐⭐ **Security Owner position:** ⭐ no-read in V1 is the **conservative and coherent**
posture. ⭐⭐ **For `ICFG-8` and `ICFG-9` specifically, it is the posture the source
itself argues for** — §9 **L449** makes `ICFG-8`'s value **load-bearing for the safety
of the entire `IT-3` mechanism**.

⚠️⚠️ **Consequence recorded for any future reversal:** ⭐ if a later requirement seeks to
expose any of the ten, ⭐⭐ **`ICFG-8` and `ICFG-9` must be re-reviewed SEPARATELY and
MUST NOT be included in a blanket exposure**, ⛔ regardless of what is decided for the
other eight.

⛔ **The Security Owner does not decide this ADR** — `ADR-0158` §2.1b gives the office
⛔ *"no permission authority"*, and *"`R-3` stays with the **Authorization Owner**."*

---

## 6. ⭐ Authority — who must accept this, and why

| Office | Role here | Source |
|---|---|---|
| ⭐⭐ **Authorization Owner** | ⭐⭐ **DECIDING** — *"Which **existing** role may exercise which **existing** protected operation, at which **existing** action and scope — i.e. the **allocation** of authorization"* | `PRD_OWNERSHIP_MODEL` **§16.1** |
| **Product Owner** | ⭐ **Contributing** — V1 read-surface scope | §2.2; §16.3 |
| **Security Owner** | ⭐ **Contributing** — security review | §17.1; `ADR-0158` §2.1b |
| **Architecture Owner** | ⛔ Not engaged — ⭐ **no `PERM-*` is minted** | `ADR-0132` §7 row 7 |
| **Governance Owner** | ⛔ Not engaged | §10.1 |

### 6.1 ⚠️⚠️ The vacancy — and why it is **not** a blocker

⭐ `PRD_OWNERSHIP_MODEL` §16.1 records the Authorization Owner as *"**vacant as
constituted**"*. ⚠️ **That is a representation fact, ⛔ not unreachability:**

1. ⭐⭐ **§7 rule 4 forbids recording a personal name anywhere in the repository** —
   *"it belongs in a team directory **outside** the repository."* ⭐ **No office can ever
   read as "filled".** Product, Domain, Architecture and Technical Owners are identical.
2. ⭐⭐ **The office has been exercised FIVE times while vacant** — `ADR-0150` **L8**,
   `ADR-0151` **L8**, `ADR-0153` **L8**, `ADR-0155` `S-3`, and ⭐⭐ **`ADR-0162`**, the
   act that produced the current **85 / 104**.
3. ⭐ **The mechanism is a one-act conferral of the human principal**, reverting on
   completion — `ADR-0033` §7.1: *"**a conferral for one act is not a standing
   licence**."*

⛔⛔ **This ADR appoints nobody, names nobody and invents no appointing authority.** ⭐ It
identifies the **existing** mechanism and leaves its exercise to the human principal.

---

## 7. ⛔⛔ What this ADR does **not** do

| Claim | Status |
|---|---|
| A role receives READ | ⛔⛔ **NO — zero roles, zero grants** |
| A `PERM-*` is created | ⛔⛔ **NO.** `AUTH-7.22` stays **closed at zero** |
| A role, action class or scope is created | ⛔ **NO** — `PR-1`/`PR-2` closed at two; `TR-1`…`TR-5` closed at five |
| Internal enforcement changes | ⛔ **NO** — §3(b): enforcement continues unchanged |
| Any `ICFG` **value** changes | ⛔ **NO** — all ten byte-unchanged; `INV-13`…`INV-16` intact |
| `INVITATION_SECURITY_SPECIFICATION` is amended | ⛔ **NO** — byte-unchanged |
| `DD-0007` is amended | ⛔⛔ **NO** — ⭐ **v1.0**, **85 / 104**, **19 held**, ⛔ **NOT design-ready** |
| The other 9 holds move | ⛔ **NO** — ⭐ 4 Face + 2 retention + `SEAT-CFG-017` + `CFG-12` + `SCFG-2` all untouched |
| `LR-01`-gated holds move | ⛔ **NO** — `LR-01` stays **PERMANENTLY OPEN** |
| `DD-0007` becomes design-ready | ⛔⛔ **NO** — Figma blockers stay **4** |
| ⭐ **This ADR is Accepted** | ⭐⭐ **YES — as of 2026-09-19**, under the conferral at **§10.2**. ⛔ **It was NOT self-approved**: the conferral is the human principal's act, recorded verbatim, and ⛔ **no independent review is claimed** |

---

## 8. Consequences **if accepted** — ⛔ none of which follow yet

| Dimension | Effect |
|---|---|
| Coverage | ⭐ **85 / 104 → 95 / 104** *(91.3%)* |
| Held | ⭐ **19 → 9** |
| `DD-0007` §6.5 | ⭐ Row 4 leaves the register — ⭐ a **UX Architecture Owner** act |
| `DD-0007` §6.2 | ⭐ New band row: **10 × `NO READ SURFACE (V1)`**; `NOT YET AUTHORIZED` **19 → 9**; total stays **104** |
| **D3** | ⚠️⚠️ **stays `PARTIAL`** — ⛔⛔ does **NOT** become `PASS` |
| Surface `C-5` | ⛔ **unchanged at 19** — ⭐ these ten gain **no** surface |
| Figma blockers | ⛔ **stay 4**; surfaces **3 of 5** |
| Design-readiness | ⛔⛔ **still NOT design-ready** |
| Remaining holds | ⭐ **9** — **4** Face + **2** retention + `SEAT-CFG-017` + `CFG-12` + `SCFG-2`; ⛔ **6 of the 9 externally gated by `LR-01`** |

⚠️⚠️ **Even at 95 / 104, `DD-0007` is not design-ready.** ⭐ Figma blockers **3** and **4**
*(`DD7-GAP-007` UI design system, `DD7-GAP-009` NFR budgets)* are **design-system**
questions, ⛔ untouched by any `BC-25` authorization act.

---

## 9. Evidence — exact citations

| # | Source | Locus | Supports |
|---|---|---|---|
| 1 | `INVITATION_SECURITY_SPECIFICATION.md` | **`INV-SEC-001`** §1.2 | Source disclaims authorization capability |
| 2 | ibid. | **`INV-SEC-018`** **L175–176** | Values non-overridable by **any** library role incl. `TR-1` |
| 3 | ibid. | §14 **L493–502** | The ten values + ranges |
| 4 | ibid. | `INV-13`…`INV-16` **L199–202** | Invariants preserved |
| 5 | ibid. | §9 **L449**, **L444** | ⭐⭐ `ICFG-8` is load-bearing for `IT-3` entropy safety |
| 6 | `CONFIGURATION_GUIDE.md` | §2B **L409–426**; **L8** | Register; `BC-25` ownership |
| 7 | ibid. | env table **L806–815** | **10/10** at scope 1 |
| 8 | `ADR-0163` | §3, §3.2 | Scope **RESOLVED** = `Platform default`; *"per library"* is a **counting unit** |
| 9 | `ADR-0162` | §11 `B-3′` | The blocker, **10** parameters |
| 10 | `ADR-0159` | whole | Authorization Owner **constituted** |
| 11 | `ADR-0158` | §2.1b | Security Owner has ⛔ **no permission authority** |
| 12 | `PRD_OWNERSHIP_MODEL.md` | **§16.1**, §16.3, **§17.1**, §2.2, §7 rule 4 | Deciding office; exclusions; naming rule |
| 13 | `Authentication_PRD_v2.md` | **`AUTH-7.22`** L2336 | Catalogue **closed at zero** |
| 14 | ibid. | **`AUTH-7.24`** L2363 | *"Read **MUST NOT** imply any other action"* |
| 15 | ibid. | **`AUTH-7.28`** L2394 | *"No permission implies another"* |
| 16 | `ADR-0132` | §7 row 7 | `PERM-*` minting is an **Architecture Owner** act |
| 17 | `ADR-0033` | §7.1 | *"A conferral for one act is not a standing licence"* |
| 18 | `DP-0005` | whole | The decision pack this executes |

### 9.1 ⭐ Four arguments tested and refused — carried so they are not re-run

| ⛔ Argument | Why refused |
|---|---|
| *"Scope is `Platform default` like `CFG-*` → copy the `CFG-*` READ"* | ⛔⛔ **A shared scope is not a shared decision.** `ADR-0154` rested on `PRD-023`-specific evidence **absent here**. `AUTH-7.24` runs **both ways** |
| *"`INV-SEC-018` denies every `TR-n` → so `PR-n` holds it"* | ⛔ **A denial of `TR-n` is not a grant to `PR-n`** — `AUTH-7.28` |
| *"`ICFG-10` 'Matches `CFG-4`' → inherit `CFG-4`'s allocation"* | ⛔ A **value rationale**, ⛔ not an authority statement |
| *"Security-owned → SECURITY PLATFORM reads it"* | ⛔ Names a **reviewing** office; `ADR-0158` §2.1b denies it permission authority |

⭐⭐ **Outcome B needed none of them.** ⭐ It closes the hold **without granting anything**,
which is why it survives rules that would defeat every read allocation attempted so far.

---

## 10. ⛔ Acceptance block — to be completed by the deciding authority

> ⭐⭐ **COMPLETED — 2026-09-19.**
>
> | Field | Value |
> |---|---|
> | Status | ⭐⭐ **Accepted** |
> | Date | **2026-09-19** |
> | Authority instrument | ⭐⭐ **A one-act conferral of the human principal of this engagement**, recorded **verbatim** at **§10.2**. ⛔ **Reverting on completion** *(`ADR-0033` §7.1: "a conferral for one act is not a standing licence")* |
> | Offices exercised | ⭐ **Authorization Owner** *(deciding — `PRD_OWNERSHIP_MODEL` §16.1, `ADR-0159`)*; **Product Owner** *(contributing — §4.1)*; **Security Owner** *(contributing — §5)* |
> | Independent review | ⛔⛔ **NONE CLAIMED.** ⚠️ All three offices exercised by **one principal**, disclosed in the conferral itself |
> | Follow-on | ⛔ **NOT performed here:** `DD-0007` §6.5 / §6.2 update — **UX Architecture Owner**; `ADR-INDEX` registration — **Governance Owner** |

### 10.1 ⭐⭐ Two steps, not one — ⚠️ acceptance is **incomplete** if only §10 is filled

⚠️⚠️ **A defect in the first draft of this block, found on review and corrected here:**
⭐ filling §10 alone would leave the **header Status cell (L5)** still reading
`Proposed`, ⛔ producing an ADR that contradicts itself. ⭐ **Both must change in the
same act:**

| Step | Location | Change |
|---|---|---|
| **1** | ⭐ **Header `Status` cell, L5** | `⛔⛔ **Proposed** — not binding…` → ⭐ `**Accepted** — YYYY-MM-DD` |
| **2** | ⭐ **This block (§10)** | Fill every `________` |

⛔ `ADR-INDEX.md` **L206**: *"**Never edit an Accepted ADR's decision text**"* — ⭐ so
§3's decision text must be settled **before** step 1, ⛔ not after.

### 10.2 ⭐ The conferral, recorded **verbatim** — ⛔ the slot the precedent requires

⭐ Every prior authorization act in this chain records its conferral **verbatim**, not
paraphrased — `ADR-0162` does so at its §2. ⭐⭐ **The conferral supplied on 2026-09-19
is recorded below, WORD FOR WORD:**

> ⭐⭐ **VERBATIM CONFERRAL — human principal of this engagement, 2026-09-19:**
>
> ```
> "I confer the Authorization Owner office on this engagement for the single act
> of deciding ADR-0164 — to Accept, Reject or Amend it. This conferral is limited
> to that one act and reverts on completion. I am concurrently exercising Product
> Owner and Security Owner input, and no independent review is claimed."
> ```

#### ⭐ Validity, tested against `ADR-0080` **L7** · `ADR-0106` · `ADR-0033` §7.1

| # | Required element | Supplied? | The words relied on |
|---|---|---|---|
| 1 | ⭐ Direct **first-person** grant | ⭐ **YES** | *"**I confer**…"* |
| 2 | ⭐ Names the office conferred | ⭐ **YES** | *"the **Authorization Owner** office"* |
| 3 | ⭐ Scoped to a **single act** | ⭐ **YES** | *"for the **single act of deciding ADR-0164**"* |
| 4 | ⭐ Decision scope stated | ⭐ **YES** | *"to **Accept, Reject or Amend** it"* |
| 5 | ⭐⭐ **One-act, reverting** *(`ADR-0033` §7.1)* | ⭐ **YES** | *"**limited to that one act and reverts on completion**"* |
| 6 | ⚠️ Concurrent-office disclosure *(`ADR-0162`, `ADR-0159` precedent)* | ⭐ **YES** | *"**concurrently exercising Product Owner and Security Owner input, and no independent review is claimed**"* |

⭐⭐ **6 / 6.** ⭐ The conferring authority is the **human principal of this engagement** —
⭐ `ADR-0080` **L7** *("direct conferral from the human principal")*, which `ADR-0106`
calls *"the **only** authority competent to fill this office."*

⚠️⚠️ **Three things this conferral is NOT, recorded so the limits survive the act:**
⛔ **Not** a standing licence — `ADR-0033` §7.1, and the text says so itself.
⛔ **Not** the spent `ADR-0162` §2 `B-3` conferral, which reverted on completion and was
discharged **negatively** *(its §11 preserved these ten holds)* — ⭐ **this is fresh
text**.
⛔ **Not** the Product Owner input at §4.1 — ⭐ that message expressly said *"Do not
assume authority from this message alone."* ⭐⭐ **This one says "I confer." The
difference is the whole point.**

⚠️⚠️ ⛔ **NO INDEPENDENT REVIEW IS CLAIMED.** ⭐ One principal exercises the deciding
office **and** both contributing offices. ⭐ That is lawful on the `ADR-0162` / `ADR-0159`
precedent, ⛔ **but it is a disclosure, not a strength**, and it is recorded as such.

### 10.3 ⭐ If the decision is **Rejected** or **Amended**

⭐ **Rejected** — ⭐ record the reason in §10; ⛔ **the ten stay HELD**; ⭐ `DD-0007`
unchanged at **85 / 104** and **19**; ⭐ `B-3′` stays **OPEN**; ⛔ **nothing else moves**.

⭐ **Amended** *(e.g. `ICFG-8`/`ICFG-9` treated separately from the other eight)* —
⭐ state the split explicitly; ⚠️ **the resulting coverage figure will NOT be 95 / 104**
and ⛔ **must be re-derived**, ⛔ not assumed from §8.

⭐⭐ **§10 was completed on 2026-09-19 under the conferral recorded verbatim at §10.2 —
⛔ NOT by the author's own authority.** ⭐ `DESIGN_GOVERNANCE.md` L10 and
`PRD_OWNERSHIP_MODEL` §2 separate the author from the authority; ⭐ the conferral supplied
that authority, and ⛔ **it reverted on completion of this single act.**

---

## 11. ⭐⭐ Status after acceptance — ⚠️ what has and has **not** changed

⭐⭐ **`ADR-0164` is `Accepted`. The authorization question for `ICFG-1` … `ICFG-10` is
DECIDED: Outcome B — no read surface in V1.**

⚠️⚠️ **But the register has NOT yet moved, and that gap is deliberate:**

| Artifact | State **now** | Why |
|---|---|---|
| ⭐ `ADR-0164` | ⭐⭐ **`Accepted`** | This act |
| ⚠️ `DD-0007` | ⛔ **v1.0 · 85 / 104 · 19 held — UNCHANGED** | ⭐⭐ Amending it is the **UX Architecture Owner's** act — ⛔ **outside this conferral**, which was *"for the **single act of deciding `ADR-0164`**"* |
| ⚠️ `ICFG-1`…`10` register row | ⛔ **still listed HELD** | ⭐ Same reason: the **decision** exists; the **register entry** follows by another office's act |
| ⚠️ `ADR-INDEX` | ⛔ **not registered** | ⭐ A **Governance Owner** act *(`PRD_OWNERSHIP_MODEL` L418)* |

⭐⭐ **The honest position: authorization coverage is now DECIDED at 95 / 104, while
`DD-0007` still RECORDS 85 / 104 — and will until its owner acts.** ⭐ `DD-0007`'s own
header settles which governs meanwhile: ⛔ *"the **ranked** document wins and this Design
Doc is the defect"* — ⭐ and **this Rank-2 ADR is the ranked document**.

⛔⛔ **Unchanged by this acceptance:** ⛔ **D3 stays `PARTIAL`** · ⛔ **`DD-0007` is still
NOT design-ready** · ⛔ **Figma blockers stay 4**, surfaces **3 of 5**, surface `C-5`
stays **19** · ⛔ the other **9** holds untouched, **6** still gated by **`LR-01`**
*(PERMANENTLY OPEN)* · ⛔ **0 `PERM-*`** — `AUTH-7.22` stays **closed at zero** · ⛔ **0**
roles, action classes or scopes · ⛔⛔ **0 READ granted to anyone**.

⭐ **The conferral has reverted on completion.** ⛔ Any further authorization act requires
a **new** conferral.
