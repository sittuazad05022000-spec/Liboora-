# ADR-0166 — `SCFG-2`: the *"review"* authority is **not identifiable** from any authoritative source; the parameter remains **HELD** under outcome (c)

| Field | Value |
|---|---|
| **Status** | ⭐⭐ **Accepted** — **2026-09-19**, under the one-act conferral recorded **verbatim** at **§9.1**. ⛔ **Reverting on completion** *(`ADR-0033` §7.1)*. ⚠️⚠️ **NO INDEPENDENT REVIEW CLAIMED** — expressly so stated in the conferral |
| **Rank** | 2 — Architecture Decision Record |
| **Date prepared** | 2026-09-19 |
| **Bounded context** | `BC-25` Configuration *(owning register)*; `BC-10` / `PRD-003` *(username ownership)*; Student Identity *(owning specification)* |
| **Supersedes** | ⛔ **NOTHING** |
| **Superseded by** | — |
| ⭐⭐ **Deciding authority** | ⭐⭐ **Authorization Owner** — `PRD_OWNERSHIP_MODEL` **§16.1**, constituted by `Accepted` **`ADR-0159`**; routed here by `ADR-0155` **`S-3`** and `ADR-0158` **`O-7`** |
| **Contributing offices** | ⛔⛔ **NONE.** ⭐ No Product Owner, Security Owner or Architecture Owner input is claimed, exercised or recorded — ⭐ the conferral names one office only |
| **Decides** | ⭐ **`SCFG-2`'s review authority only** — **1** parameter, **1** question. ⛔ **Nothing else** |
| **Expressly does NOT decide** | ⛔ `SCFG-2`'s `READ` · ⛔ its `WRITE` · ⛔ its scope *(already `Platform default`, ⛔ not re-decided)* · ⛔ its commercial classification · ⛔ its value · ⛔ `CFG-12` · ⛔ `SEAT-CFG-017` · ⛔ `CFG-10` · ⛔ `SCFG-4` · ⛔ the 4 Face `ATT-CFG-*` · ⛔ any `PERM-*` · ⛔ any role, office, action class or scope class · ⛔ `DD-0007`'s counts or design-readiness · ⛔ the `ADR-0155` `D-4`/§2.5 `WRITE` inconsistency |
| **Amends** | ⛔⛔ **NOTHING.** ⭐ The determination **preserves** the existing state; ⛔ **no downstream reconciliation is created or required** *(§8)* |
| **Origin** | ⭐ [`DP-0004`](../decisions/DP-0004-terminal-decision-requests-seven-blockers-nineteen-parameters.md) **`A-2`** *(= `B-2`)* |

> ⭐⭐ **Identifier check, performed immediately before drafting.** `ADR-0165` is the
> highest ADR file present. `ADR-0166` measured **0** files on disk and **0** references
> anywhere in `docs/`. The range `ADR-0150`…`ADR-0165` was gap-tested and is
> **contiguous** — ⛔ so `0166` is the next sequential number and ⛔ **no number is
> reused** *(`ADR-INDEX` Process rule 2)*. ⭐ Measured mechanically, ⛔ not by
> incrementing.

---

## 1. ⭐⭐ The decision

⭐⭐ **`DP-0004` `A-2` outcome (c) — `SCFG-2` remains HELD.**

⭐ The Authorization Owner, having conducted the search the office exists to conduct,
⭐⭐ **determines that no existing office and no existing role can be identified as the
*"review"* authority from any authoritative source**, and therefore selects the outcome
`ADR-0155` `S-3` expressly provides for:

> *"If the Authorization Owner **cannot identify an authoritative role**, keep `SCFG-2`
> **HELD**."*

### 1.1 ⚠️⚠️ What this determination is, and what it is not

⭐⭐ **This is a finding of fact reached by an office competent to reach it — ⛔ not a
deferral, and ⛔ not a failure to decide.**

| | Before this ADR | After this ADR |
|---|---|---|
| `SCFG-2` | ⛔ **HELD** | ⛔ **HELD** |
| Why | ⭐ `ADR-0155` `D-6` held it pending the Authorization Owner's identification of the reviewer | ⭐⭐ **The Authorization Owner has now searched and determined the reviewer is NOT identifiable** |
| `DP-0004` `A-2` | ⛔ **OPEN**, 0 responses | ⭐ **ANSWERED** — outcome **(c)** |
| Governance character | ⭐ *"awaiting the office's search"* | ⭐⭐ *"the office has searched; the record is silent"* |

⭐⭐ **The question that was open is now closed; the parameter that was held remains
held.** ⛔ Those are different facts, and this ADR changes only the first.

### 1.2 ⭐ Why (c) is a decision and not an evasion

⛔ It would be easy to read *"HOLD"* as the office declining to act. ⭐⭐ **It is the
opposite.** ⭐ `S-3` frames (c) as **conditional on a finding** — *"if the Authorization
Owner cannot identify"* — ⭐ so reaching it **requires** the office to have conducted the
identification attempt and to have **failed**. ⭐⭐ **A hold recorded without the search
would be an evasion; a hold recorded after the search is a determination.** ⭐ §4 and §5
are the search.

---

## 2. ⭐ Scope of the decision

| Dimension | Disposition | Moved by this ADR? |
|---|---|---|
| ⭐⭐ **The *"review"* authority** | ⛔ **NOT IDENTIFIABLE — determined** | ⭐⭐ **YES — this is the whole of the act** |
| **`READ`** | ⛔ **HELD** *(`ADR-0155` §2.5)* | ⛔ **NO** |
| **`WRITE`** | ⚠️ **HELD** per `ADR-0155` §2.5 · ⚪ `N/A` per its `D-4` — ⚠️ see §6.3 | ⛔ **NO** |
| **Scope** | ⭐ `Platform default` — ⭐ **already resolved**, sourced from `SID-5.45` | ⛔ **NO** — ⭐ not re-decided, not disturbed |
| **Commercial** | *"—"* *(unclassified)* | ⛔ **NO** |
| **Value** | *"Platform-managed list"* · Range *"—"* | ⛔ **NO** |
| **Design** | ⛔ Not designed | ⛔ **NO** |

⛔⛔ **`SID-5.45` is not weakened, reinterpreted or engaged.** ⭐ *"Every value above
**SHALL** be platform-wide. **None SHALL be organisation-configurable**"* stands
byte-intact. ⭐ `DP-0004` `A-2`'s `MUST NOT` limb is honoured.

⛔⛔ **This decision does NOT extend to `CFG-12` or `SEAT-CFG-017`.** ⭐ `CFG-12` was
determined separately at `ADR-0165` on the **self-reference** ground; ⭐ `SEAT-CFG-017`
turns on a **Rank-1 `E-05` amendment** and the **`LIB-14B.13` V2 bar**, before
**different offices**. ⭐⭐ **Three parameters, three questions, three determinations.**

---

## 3. ⭐⭐ The `DP-0004` `A-2` decision field — completed

⭐ `DP-0004` `A-2` offers:

> ☐ Reviewer: ____________ **Source conferring it:** ____________ ☐ **HOLD**

⭐⭐ **The Authorization Owner's entry:**

> ⭐⭐ **☑ HOLD** — outcome **(c)**.
>
> ⭐ **Reviewer:** ⛔ **NONE IDENTIFIABLE.**
> ⭐ **Source conferring it:** ⛔⛔ **NONE EXISTS.**
>
> ⚠️⚠️ **The second field is the dispositive one.** ⭐ The form does not ask merely for
> a plausible reviewer — ⭐⭐ **it asks for the SOURCE that confers the authority on
> them.** ⭐ Any candidate this office might name would have to be accompanied by a
> citation to a document that actually confers the review act. ⭐ The search at §4
> establishes that **no such document exists**: the owning specification states the
> obligation *("removing an entry requires review")* in **one line**, and ⛔ **names no
> actor**; ⭐ and `ADR-0155` `S-3` forbids supplying one by inference.
>
> ⭐⭐ **An office may not confer authority on itself by filling in a blank.** ⭐ Under
> **`AP-3`**, *absence of an explicit grant is refusal*; under **`AP-4`**, *no permission
> is derived from role naming, hierarchy, seniority or similarity*. ⛔ The correct entry
> is therefore **HOLD**, and `S-3` expressly provides for it.

---

## 4. ⭐⭐ The identification attempt — the search this determination rests on

⭐⭐ **The office is required to try. This section is the trying, recorded so it can be
audited.**

### 4.1 The obligation, at its single source

⭐ `Student_Identity_PRD_v1` **L1336**:

> `| SCFG-2 | Reserved-username list | Platform-managed list | — | Additive only; removing an entry requires review |`

⭐ And its only other occurrence, **L356**:

> `| Reserved words | Prohibited — SCFG-2 reserved list |`

⭐⭐ **Two lines repository-wide. ⛔ Neither names an actor.** ⭐ Re-swept this pass and
confirmed — ⭐ the same result `ADR-0160`, `ADR-0161`, `ADR-0162` §4 and `ADR-0163` §5.2
each reached independently.

### 4.2 ⭐ Direct probes over the owning specification

| Probe | Result |
|---|---|
| Lines containing *"review"* **and** any actor token *(`TR-`, `PR-`, owner, admin, platform, moderat*, trust, safety)* | ⛔⛔ **0** — ⭐ the only hit is **L1336** itself, whose actor-like word is *"**Platform-managed**"*, ⭐ a **custody descriptor**, ⛔ not an actor grant |
| *"remov*"* co-occurring with *"reserv*"* anywhere in the owning PRD | ⭐ **1** — **L1336**, ⛔ the obligation itself |
| Repository-wide *"reserved username / word / name / list"* outside ADRs and decision packs | ⭐ **3** — **L356**, **L1336**, and `STUDENT_IDENTITY_IMPLEMENTATION_TASKS` **L122** *(`IMPL-211`, a build task, ⛔ not an authority)* |
| *"Platform-managed"* elsewhere in the owning PRD | ⭐ **1** — **L1336** only. ⛔ The term is **never defined** and **never attached to an actor** |

### 4.3 ⭐⭐ Five candidate authorities tested — and each refused on its own terms

⭐⭐ **Each was tested because it was the strongest available, ⛔ not dismissed by
assertion.**

| # | Candidate | The argument for it | ⛔ Why it fails |
|---|---|---|---|
| **1** | **`PR-1` Platform Administrator** | ⭐ Its frozen Purpose includes *"**manage platform configuration**"*, and `SCFG-2` is a platform-default configuration parameter. ⭐ Arguably the **strongest** candidate | ⛔⛔ **`S-3` forbids exactly this.** ⭐ It bars inference from *"naming, ownership, hierarchy or **UI visibility**"* — ⭐ and *"manage platform configuration"* is a **general role-scope statement**, ⛔ not a grant of the specific *"review"* act. ⭐ Under **`AP-4`**, *no permission is derived from role naming or similarity*. ⭐⭐ **And decisively: this reasoning would have applied equally to all eleven `SCFG-*`, yet `ADR-0155` allocated nine and HELD this one** — ⛔ so the general scope was already considered and found **insufficient** for `SCFG-2` |
| **2** | ⭐ **The `ADR-0155` allocation pattern** — `READ` = `PR-1`+`PR-2` for the other nine | ⭐ The band matches exactly; ⭐ `SCFG-2` sits in the same register at the same scope | ⛔⛔ **`ADR-0155` held in terms that *"A BAND IS NOT A DECISION"***, seeking **four** separate decisions where the band matched exactly. ⭐⭐ **A shared band is not a shared decision** — ⛔ the argument refused five times in this chain. ⭐ And `READ` is a **different action class** from *"review"* *(`AUTH-7.24`)* |
| **3** | **`CONFIGURATION_GUIDE` change process** | ⭐ §5 defines who may change configuration — *"Adding a parameter — **a PRD amendment**"*; *"Promoting a structural fact to configurable — **an ADR and a PRD amendment**"* | ⭐⭐ **These govern changing the PARAMETER SET, ⛔ not the VALUE of a list.** ⭐ Removing an entry from the reserved-username list is neither adding a parameter nor promoting a structural fact. ⛔ And the Guide is **Rank 7**, *"subordinate to the PRDs… it cannot change the envelope"* — ⛔ it cannot confer an authority the owning Rank-3 specification withholds |
| **4** | **`PRD-023` reviewer roles** | ⭐ It names an *"architecture reviewer"*, a *"requirements reviewer"*, a *"traceability owner"*, a *"governance owner"* | ⛔⛔ **All four are `PRD_LIFECYCLE` STAGE reviewers** — ⭐ they review **documents** through the lifecycle, ⛔ **not runtime configuration values**. ⭐ `PRD-023` contains ⛔ **no** *"requires review"* rule for a configuration entry |
| **5** | ⭐⭐ **`BC-13` Trust & Safety** — ⭐ **the strongest non-obvious candidate** | ⭐ `PRD-020` **L246** lists username as an **impersonation vector**; ⭐ **L338** makes *"Change username or display name"* a **synchronous enforcement** action whose Authority column reads *"**This PRD**"*. ⭐ A reserved-username list is plainly an anti-impersonation control | ⛔⛔ **REFUSED ON ITS OWN EXCLUSION.** ⭐ **`TSF-XC-001`**: *"This PRD does **not** own identity, **username**, profile or profile privacy — `BC-10` / `PRD-003`… **`SID-*` governs**."* ⭐ **L408**: *"`BC-10` owns **username**."* ⭐⭐ And measured: **`SCFG` appears ZERO times in the whole of `PRD-020`.** ⭐ What **L338** governs is **enforcement against a person changing their own username**, ⛔ **not custody of the reserved list**. ⭐ Two different objects |

### 4.4 ⭐⭐ The finding

⭐⭐ **The search is exhausted and the result is a decisive negative.**

⛔⛔ **No authoritative source confers the *"review"* act on any existing office or any
existing role.** ⭐ The obligation exists; ⛔ the authority to discharge it does not.

⚠️⚠️ **This is not a gap that further reading can close.** ⭐ `ADR-0162` §4 already
recorded `B-2` as *"unanswerable on current evidence"*; ⭐ this pass re-ran the search
with five named candidates and confirms it. ⭐⭐ **The missing input cannot be FOUND —
it can only be SUPPLIED**, by an act that creates or assigns the authority. ⛔ **That act
is outside this conferral** *(§6.4)*.

---

## 5. ⛔⛔ Alternatives and inferences considered and REFUSED

### 5.1 The two other `A-2` outcomes

| Outcome | ⛔ Refused because |
|---|---|
| ⛔ **(a) Name an existing office** | ⭐ Requires a **source conferring it**; ⛔ **none exists** *(§4)*. ⭐ The nearest candidates — Governance Owner, Architecture Owner, Privacy Owner — are each scoped away: ⛔ Governance to *"document **status** and **process**"* *(§10.1)*; ⛔ Architecture to boundaries, ranks and edges; ⛔ Privacy to whether processing personal data is permissible. ⭐⭐ **A reserved-word list entry is none of those.** ⛔ Naming one would be **conferral by this ADR**, which `AP-4` forbids and §16.1 excludes |
| ⛔ **(b) Name an existing role** | ⭐ The registers are **closed at two** *(`PR-1`, `PR-2`)* and **five** *(`TR-1`…`TR-5`)*. ⛔ `TR-1`…`TR-5` are barred at the threshold — **`AUTH-7.14`** scopes every library role to **one library**, and `SID-5.45` makes `SCFG-2` **platform-wide and not organisation-configurable**, so ⛔ **a tenant role cannot reach it at all**. ⛔ `PR-1`/`PR-2` fail for the reason at §4.3 row 1 |

### 5.2 ⛔ Six inferences refused

| # | Inference | ⛔ Refused on |
|---|---|---|
| 1 | *"Platform-managed"* ⇒ `PR-1` reviews it | ⭐⭐ **`S-3`** — ⛔ no inference from **naming** or ownership. ⭐ *"Platform-managed"* describes **custody of the list**, ⛔ not authority over removals |
| 2 | `PR-1` manages platform configuration ⇒ `PR-1` reviews | ⭐ **`AP-4`** — ⛔ no permission from role naming, hierarchy, seniority or similarity |
| 3 | The other nine `SCFG-*` went to `PR-1`+`PR-2` ⇒ so does this | ⭐⭐ **`ADR-0155`: *"A BAND IS NOT A DECISION."*** ⛔ Refused a sixth time |
| 4 | `BC-13` polices impersonation ⇒ `BC-13` reviews | ⭐⭐ **`TSF-XC-001`** — ⛔ `PRD-020` **expressly disclaims** username ownership |
| 5 | Seniority — *"the most senior platform role must be able to"* | ⭐ **`AUTH-7.28`** — ⛔ permissions form **no hierarchy**; **`AP-4`** — ⛔ no derivation from seniority |
| 6 | The obligation exists ⇒ someone must be able to discharge it ⇒ name the likeliest | ⭐⭐ **This is the core temptation and it is the one `S-3` was written to stop.** ⛔ An unperformable obligation is a **defect to be recorded**, ⛔ not a licence to appoint |

### 5.3 ⛔⛔ Three structural moves refused

⛔ **Constituting a *"Reserved-List Reviewer"* office or action class.** ⭐⭐ **Expressly
forbidden by the conferral** — *"Do not create any role, permission, scope, or new action
class"*. ⭐ And independently: minting an action class or `PERM-*` is an **Architecture
Owner** act *(`ADR-0132` §7 row 7)*, ⛔ **excluded from this office by §16.1**.

⛔ **Deciding `SCFG-2`'s `READ` or `WRITE` while here.** ⭐ The conferral is scoped to
*"the authorized review authority"*. ⭐⭐ **`AUTH-7.24` makes each action class
independent** — ⛔ determining that the *review* authority is unidentifiable says
**nothing** about `READ`, which remains **HELD** on `ADR-0155` §2.5.

⛔ **Repairing the `ADR-0155` `D-4` / §2.5 `WRITE` inconsistency.** ⭐ Disclosed at
`ADR-0162` §8 and routed to the **Architecture Owner**. ⛔ Outside this conferral, ⛔ and
⭐ nothing here depends on which reading is right — ⭐⭐ **`SCFG-2` is held either way.**

### 5.4 ⚠️ The `ADR-0164` Outcome-B analogy — seen and not applied

⭐ `ADR-0164` discharged ten holds by **determining** the parameters have no V1 read
surface. ⭐ A parallel is conceivable: *the list is additive-only in V1, so no removal
occurs, so no reviewer is needed.*

⛔⛔ **NOT APPLIED**, for three reasons:

1. ⭐⭐ **It is not an `A-2` outcome.** ⭐ The form offers three; *"no removal in V1"* is
   ⛔ not among them, and the conferral is scoped to `A-2`'s *"permitted existing
   outcomes"*.
2. ⭐ It would be a **product scoping determination** — ⛔ **Product Owner** territory,
   ⭐ and no Product Owner input is conferred or claimed.
3. ⭐ The owning text says *"Additive only; removing an entry **requires review**"* —
   ⭐⭐ **it contemplates removal and imposes a condition on it**, ⛔ it does not forbid
   removal. ⭐ Reading it as *"removal never happens"* would **rewrite a frozen line**.

⭐ Recorded so a future office sees the option was **considered and deliberately left
open**, ⛔ not missed.

---

## 6. ⭐ Authority

### 6.1 Why the Authorization Owner

⭐ **Positive basis** — `PRD_OWNERSHIP_MODEL` **§16.1**: the office decides *"which
**existing** role may exercise which **existing** protected operation… i.e. the
**allocation** of authorization"*.

⭐ **Direct routing** — three `Accepted` ADRs name it for **this exact question**:
`ADR-0155` **`S-3`** *(originating)*; `ADR-0158` **`R-7`** and **`O-7`**; and
`DP-0004` **`A-2`**. ⭐ `DD-0007` §6.5 row 7 and §6.3.5a concur. ⭐⭐ **Unlike `CFG-12`,
there is NO routing conflict on `SCFG-2`** — ⭐ every source says *Authorization Owner*
and **only** that.

### 6.2 ⭐ Why no other office could have absorbed it

⭐ `PRD_OWNERSHIP_MODEL` §16.3 tests all nine and excludes each. ⭐ Applied here:
⛔ **Architecture** — `ADR-0155` recorded `S-3` *(Authorization)* and `S-4`
*(Architecture)* as **two distinct decisions in one ADR**; ⛔ merging would overturn an
`Accepted` ADR by side effect. ⛔ **Product** — §2.2 scopes it to *"scope, priority,
acceptance"*. ⛔ **Security** — §17.1 excludes *"the allocation of authorization"*.
⛔ **Governance** — §10.1, *"document status and process"*. ⛔ **Privacy** — §9.1,
personal-data permissibility.

### 6.3 ⚠️ A pre-existing inconsistency, DISCLOSED and NOT repaired

⚠️ `Accepted` `ADR-0155` `D-4` states ⚪ `WRITE` = `N/A` *"for **all 11**"*, while its own
§2.5 table row shows `SCFG-2`'s `WRITE` as ⛔ **HELD**. ⭐ Same document, same rank —
⛔ **rank cannot resolve it.**

⛔ **Not repaired here.** ⭐ Disclosed at `ADR-0162` §8 and routed to the **Architecture
Owner**. ⭐⭐ **Nothing in this determination depends on it** — ⭐ `SCFG-2` is held on
either reading, and this ADR decides the **review** question, ⛔ not `WRITE`.

### 6.4 ⭐⭐ What would be required to answer the question positively

⭐ Recorded as **routing**, ⛔ **not as a recommendation and not as authorization:**

⭐ A positive answer needs a **source that confers the review act**. ⭐ On the present
record that means either **(i)** an amendment to the owning specification naming an
existing office or role — ⛔ a **`PRD-003` / Student Identity owner** act; or **(ii)**
the constitution of a new action class or office — ⛔ an **Architecture Owner** act under
`ADR-0132` §7.

⛔⛔ **Both are outside this conferral, and both are outside the Authorization Owner's
competence entirely** *(§16.1: ⛔ *"the minting of a `PERM-*` identifier"*; ⛔ scope and
acceptance are the Product Owner's)*. ⭐⭐ **That is precisely why (c) is the correct
outcome rather than a weaker form of (a).**

---

## 7. ⭐⭐ Express confirmations

| # | Confirmation | State |
|---|---|---|
| 1 | ⛔⛔ **NO reviewer is named** | ⭐ No office, no role, no actor |
| 2 | ⛔⛔ **NO role is created** | ⭐ Platform register **closed at 2**; library register **closed at 5** |
| 3 | ⛔⛔ **NO office is created** | ⭐ 0 |
| 4 | ⛔⛔ **NO `PERM-*` is created, reserved, minted or implied** | ⭐ **`AUTH-7.22` remains CLOSED AT ZERO** |
| 5 | ⛔⛔ **NO action class is created** | ⭐ ⛔ The *"review"* act is **NOT** constituted — ⭐ it remains an **obligation without an authority** |
| 6 | ⛔⛔ **NO scope class is created** | ⭐ 0; ⭐ `Platform default` **pre-existed** *(`SID-5.45`)* |
| 7 | ⛔ **`READ` unchanged** — HELD | ⭐ Not derived from this determination |
| 8 | ⛔ **`WRITE` unchanged** | ⭐ ⚠️ its `D-4`/§2.5 inconsistency preserved as disclosed |
| 9 | ⛔ **Scope unchanged** — `Platform default` | ⭐ Not re-decided |
| 10 | ⛔ **Value unchanged** — *"Platform-managed list"* | ⭐ Not in issue |
| 11 | ⛔ **`SID-5.45` not weakened** | ⭐ Byte-intact |
| 12 | ⛔ **NO frozen document amended** | ⭐ `Student_Identity_PRD_v1` byte-unchanged |
| 13 | ⛔ **NO other parameter decided** | ⭐ `CFG-12`, `SEAT-CFG-017`, `CFG-10`, `SCFG-4`, 4 Face — ⛔ **untouched** |
| 14 | ⛔ **The 104 inventory unchanged** | ⭐ **104** |
| 15 | ⛔ **The 9-hold count unchanged** | ⭐ **95 / 9** — ⛔ no reconciliation required *(§8)* |
| 16 | ⛔ **0 lines of runtime code** | ⭐ 0 |

---

## 8. ⭐⭐ Downstream impact — assessed **NIL**

| Artifact | Current | After | Action |
|---|---|---|---|
| `DD-0007` coverage | **95 / 104** | ⭐ **95 / 104** | ⛔ **NONE** |
| `DD-0007` §6.5 hold register | **9**, `SCFG-2` in row 7 | ⭐ **9**, unchanged | ⛔ **NONE** |
| `DD-0007` §6.3.5 / §6.3.5a | ⛔ `SCFG-2` **HELD** | ⭐ unchanged | ⛔ **NONE** |
| Declaration **D3** | ⚠️ `PARTIAL` | ⚠️ **`PARTIAL`** | ⛔ **NONE** |
| Design-readiness | ⛔ NOT design-ready | ⛔ **NOT design-ready** | ⛔ **NONE** |

⭐⭐ **`HOLD` moves nothing, so nothing downstream is stale.** ⭐ `DD-0007` v1.1 already
records `SCFG-2` as held with the reviewer undefined — ⭐ **it remains accurate.**

⭐ **`DP-0004` `A-2` is DISCHARGED.** ⛔ `A-1` and `A-4` and Part B remain **OPEN**.
⭐⭐ **`ADR-0158` `O-7` is now FULLY DISCHARGED** — ⭐ `CFG-12` at `ADR-0165`, `SCFG-2`
here. ⭐ **`ADR-0155` `O-1`** *("Resolve `SCFG-2`'s review authority, **or keep it
HELD**")* is **DISCHARGED on its second limb**.

⚠️ **One OPTIONAL, non-blocking follow-up**, ⛔ not performed: a future `DD-0007` owner
act might annotate §6.5 row 7 to show both holds are now **determined** rather than
**outstanding**. ⭐ A clarity improvement, ⛔ not a correctness one.

⚠️⚠️ **A defect is recorded, ⛔ not closed.** ⭐⭐ **A frozen specification imposes an
obligation — *"removing an entry requires review"* — that NO existing authority can
discharge.** ⛔ This ADR does not repair that; ⭐ it **establishes it as a determined
finding** rather than an open question, and routes the remedy at §6.4.

---

## 9. ⭐⭐ Authority record

### 9.1 ⭐⭐ The conferral — recorded VERBATIM

> ⭐⭐ **VERBATIM CONFERRAL — human principal of this engagement, 2026-09-19:**
>
> ```
> "I confer the Authorization Owner office for `SCFG-2` at `DP-0004 A-2`. Decide
> the authorized review authority using only the permitted existing outcomes, then
> record the decision in the resulting ADR and accept that ADR. This one-act
> conferral reverts on completion. No independent review is claimed. Do not create
> any role, permission, scope, or new action class, and do not decide any other
> parameter."
> ```

### 9.2 ⭐ Validity — `ADR-0080` **L7** · `ADR-0106` · `ADR-0033` §7.1

| # | Required element | Supplied? | The words relied on |
|---|---|---|---|
| 1 | ⭐ Direct **first-person** grant | ⭐ **YES** | *"**I confer**"* |
| 2 | ⭐ Names the office conferred | ⭐ **YES** | *"the **Authorization Owner** office"* |
| 3 | ⭐ Scoped to a **single act** | ⭐ **YES** | *"for **`SCFG-2` at `DP-0004 A-2`**"* |
| 4 | ⭐ Decision scope stated | ⭐ **YES** | *"Decide the authorized review authority **using only the permitted existing outcomes**"* |
| 5 | ⭐⭐ **One-act, reverting** | ⭐ **YES** | *"This **one-act** conferral **reverts on completion**"* |
| 6 | ⭐⭐ **Acceptance expressly covered** | ⭐ **YES** | *"record the decision in the resulting ADR and **accept that ADR**"* |
| 7 | ⚠️ Independent-review disclosure | ⭐ **YES** | *"**No independent review is claimed**"* |
| 8 | ⭐⭐ **Express prohibitions** | ⭐ **YES** | *"**Do not create any role, permission, scope, or new action class, and do not decide any other parameter**"* |

⭐⭐ **8 / 8.** ⭐ The conferring authority is the **human principal of this engagement** —
`ADR-0080` **L7**; `ADR-0106` calls it *"the **only** authority competent to fill this
office."*

### 9.3 ⭐⭐ One material difference from the `ADR-0165` conferral

⚠️⚠️ **This conferral did NOT pre-supply the outcome.** ⭐ The `ADR-0165` conferral said
*"Decision: HOLD"*; ⭐⭐ **this one says *"Decide the authorized review authority using
only the permitted existing outcomes"*** — ⭐ it delegates the **choice**, constrained to
`A-2`'s three.

⭐⭐ **The office therefore had to genuinely decide**, and `HOLD` was reached **by
conducting the §4 search and failing to identify an authority** — ⛔ **not** by being
instructed to. ⭐ Had the search located a conferring source, outcome **(a)** or **(b)**
would have been recorded instead.

⭐ **The prohibitions were load-bearing, not decorative.** ⭐⭐ *"Do not create any role,
permission, scope, or new action class"* **forecloses the only route by which a reviewer
could have been named** — and ⭐ it aligns exactly with §16.1's own exclusions, so it
narrows nothing the office actually held.

### 9.4 ⛔⛔ Three things this conferral is NOT

⛔ **NOT a standing licence** — `ADR-0033` §7.1, and the text says so.
⛔ **NOT the `ADR-0165` §9.1 conferral** — ⭐ that one reverted on completion and was
scoped to `CFG-12` `READ`. ⛔ **Not reused.**
⛔ **NOT the `ADR-0164` §10.2 or `ADR-0162` §2 conferrals** — ⭐ both spent and reverted.
⛔ **Not reused.**

### 9.5 ⭐⭐ Reversion

⭐⭐ **The conferral reverts on completion of this act** — completion being the recording
of this determination and the acceptance of this ADR. ⛔⛔ **Any further authorization
act — including `SEAT-CFG-017`, or any revisiting of `SCFG-2` — requires a NEW one-act
conferral.**

---

## 10. ⭐ Sources relied on

| # | Source | Locus | Relied on for |
|---|---|---|---|
| 1 | ⭐⭐ `ADR-0155` | **`S-3`**, `D-6`, `O-1` | ⭐ **The originating hold and the express (c) permission** |
| 2 | `PRD_OWNERSHIP_MODEL` | §16.1, §16.3, §17.1, §10.1, §9.1 | The deciding office; why no other |
| 3 | `ADR-0159` | — | Constituted the Authorization Owner |
| 4 | `ADR-0080` · `ADR-0106` · `ADR-0033` | L7 · L7 · §7.1 | Conferral mechanism and its limits |
| 5 | ⭐⭐ `Student_Identity_PRD_v1` | **L1336**, **L356**, `SID-5.45`, `SID-4.49` | ⭐ **The obligation; the absent actor; the scope** |
| 6 | `ADR-0158` | §2.1b, `R-7`, `O-7` | Routing; Security ≠ authorization |
| 7 | `ADR-0160` · `ADR-0161` · `ADR-0162` §4 · `ADR-0163` §5.2 | — | Four prior independent searches, all negative |
| 8 | ⭐ `PRD-020` | `TSF-XC-001`, **L246**, **L338**, **L408** | ⭐ **Candidate 5 tested and refused** |
| 9 | `Authentication_PRD_v2` | `AP-3` **L2263**, `AP-4` **L2264**, `AUTH-7.24`, `AUTH-7.28`, `AUTH-7.14`, `AUTH-7.22` | Deny-by-default; no derivation; independence |
| 10 | `prd-v2/02` | **L123-127** | ⭐ `PR-1`'s scope — **candidate 1 tested and refused** |
| 11 | `CONFIGURATION_GUIDE` | **L9**, **L863-864** | ⭐ Candidate 3 tested and refused |
| 12 | `ADR-0132` | §2, §7 row 7 | `PERM-*` at zero; minting reserved |
| 13 | `DP-0004` | `A-2`, §0 constraint 8 | The decision form; ⭐ `HOLD` is correct |
| 14 | `DD-0007` v1.1 | §6.3.5, §6.3.5a, §6.5 row 7 | Register state |

---

## 11. ⭐ Status after acceptance

| Item | State |
|---|---|
| **This ADR** | ⭐⭐ **Accepted** — 2026-09-19 |
| **`SCFG-2`** | ⛔⛔ **HELD — determined**; ⭐ reviewer **NOT IDENTIFIABLE** |
| **`SCFG-2` `READ` / `WRITE` / scope / value** | ⛔ **Unchanged** |
| **`DP-0004` `A-2`** | ⭐ **DISCHARGED** — outcome **(c)** |
| **`DP-0004` `A-1`, `A-4`, Part B** | ⛔ **OPEN** |
| **`ADR-0158` `O-7`** | ⭐⭐ **FULLY DISCHARGED** *(with `ADR-0165`)* |
| **`ADR-0155` `O-1`** | ⭐ **DISCHARGED** — second limb |
| **Coverage** | ⭐ **95 / 104** — ⛔ **unchanged** |
| **Held** | ⛔ **9** — ⛔ **unchanged** |
| **`PERM-*`** | ⛔ **0** — `AUTH-7.22` closed at zero |
| **D3** | ⚠️ **`PARTIAL`** |
| **`DD-0007`** | ⛔⛔ **NOT design-ready**; ⛔ **not modified**; ⛔ **no reconciliation required** |
| **`ADR-INDEX`** | ⛔ **Not modified** — ⭐ registration is a **Governance Owner** act |
| **The conferral** | ⛔⛔ **REVERTED ON COMPLETION** |

---

## 12. Change history

| Version | Date | Change |
|---|---|---|
| ⭐⭐ **1.0** | 2026-09-19 | ⭐⭐ **Created and `Accepted`. `SCFG-2`'s *"review"* authority is determined to be NOT IDENTIFIABLE from any authoritative source; the parameter remains HELD under `DP-0004` `A-2` outcome (c)** — the outcome `ADR-0155` `S-3` expressly provides for: *"**If the Authorization Owner cannot identify an authoritative role, keep `SCFG-2` HELD**."* ⭐⭐ **THE CONFERRAL DID NOT PRE-SUPPLY THE OUTCOME** *(§9.3)* — unlike `ADR-0165`'s, it said *"**Decide** the authorized review authority using only the permitted existing outcomes"*, ⭐ so the office had to genuinely choose among three; ⭐⭐ **`HOLD` was reached BY CONDUCTING THE SEARCH AND FAILING, ⛔ not by instruction.** ⭐⭐ **FIVE CANDIDATE AUTHORITIES WERE TESTED AND EACH REFUSED ON ITS OWN TERMS** *(§4.3)*: ⛔ **`PR-1`** *(\"manage platform configuration\" is a **general role scope**, ⛔ not the specific act — and ⭐⭐ the same reasoning would have covered all eleven `SCFG-*`, yet `ADR-0155` allocated nine and HELD this one)*; ⛔ **the `ADR-0155` band** *(**\"A BAND IS NOT A DECISION\"** — refused a **sixth** time)*; ⛔ **the `CONFIGURATION_GUIDE` change process** *(governs the **parameter SET**, ⛔ not a list's **value**; and Rank 7 *\"cannot change the envelope\"*)*; ⛔ **`PRD-023`'s reviewers** *(all four are **lifecycle STAGE** reviewers of **documents**)*; and ⭐⭐ **`BC-13` Trust & Safety — the strongest non-obvious candidate**, which polices username as an **impersonation vector** *(`PRD-020` **L246**, **L338**)* ⛔ **but is REFUSED ON ITS OWN EXCLUSION**: **`TSF-XC-001`** — *\"This PRD does **not** own identity, **username**… **`SID-*` governs**\"*, **L408** *(\"`BC-10` owns **username**\")*, and ⭐ **`SCFG` measured ZERO times in the whole of `PRD-020`**. ⭐⭐ **THE `A-2` FORM'S SECOND FIELD IS DISPOSITIVE** *(§3)* — it asks not merely for a reviewer but for the *\"**Source conferring it**\"*, and ⛔⛔ **no such source exists**; ⭐ **an office may not confer authority on itself by filling in a blank** *(`AP-3` deny-by-default; `AP-4` no derivation from naming, hierarchy, seniority or similarity)*. ⭐ **SIX INFERENCES AND THREE STRUCTURAL MOVES REFUSED** *(§5)*, incl. ⛔ constituting a *\"Reserved-List Reviewer\"* *(**expressly forbidden by the conferral**, ⭐ and an **Architecture Owner** act under `ADR-0132` §7 row 7 in any event)* and ⛔ the tempting *\"the obligation exists, so name the likeliest\"* — ⭐⭐ **an unperformable obligation is a defect to be recorded, ⛔ not a licence to appoint.** ⚠️ **The `ADR-0164` Outcome-B analogy was seen and NOT applied** *(§5.4)* — ⛔ not an `A-2` outcome, ⛔ a **Product Owner** scoping act, and ⛔ the frozen text *\"removing an entry **requires review**\"* **contemplates removal**, so reading it as *\"removal never happens\"* would rewrite a frozen line. ⭐⭐ **DOWNSTREAM IMPACT ASSESSED NIL** *(§8)* — coverage stays **95 / 104**, held stays **9**, **D3** stays `PARTIAL`, ⛔ **NOT design-ready**, ⛔ **`DD-0007` NOT stale and NOT modified**. ⭐ **`DP-0004` `A-2` DISCHARGED**; ⭐⭐ **`ADR-0158` `O-7` now FULLY discharged** *(with `ADR-0165`)*; ⭐ `ADR-0155` `O-1` discharged on its second limb. ⚠️⚠️ **A DEFECT IS RECORDED, ⛔ NOT CLOSED** — ⭐⭐ **a frozen specification imposes an obligation that no existing authority can discharge**; ⛔ the remedy is a **`PRD-003`/Student-Identity owner** amendment or an **Architecture Owner** constitution act *(§6.4)*, ⛔ **both outside this office's competence**. ⚠️ **The `ADR-0155` `D-4`/§2.5 `WRITE` inconsistency is DISCLOSED, ⛔ not repaired** *(§6.3)* — ⭐ nothing here depends on it. ⛔⛔ **NOT REUSED:** the `ADR-0165` §9.1, `ADR-0164` §10.2 and `ADR-0162` §2 conferrals — ⭐ all reverted. ⛔ Supersedes **NOTHING** · ⛔ **0** reviewers named · ⛔ **0** roles · ⛔ **0** offices · ⛔ **0** `PERM-*` *(`AUTH-7.22` closed at zero)* · ⛔ **0** action classes *(the *\"review\"* act is **NOT** constituted)* · ⛔ **0** scope classes · ⛔ **0** `READ`/`WRITE`/scope/value changes · ⛔ **0** other parameters decided · ⛔ **0** frozen edits *(`SID-5.45` byte-intact)* · ⛔ **0** runtime code · ⛔ `DD-0007` **not modified** · ⛔ `ADR-INDEX` **not modified** · ⛔ **no commit, no push**. ⭐⭐ **The conferral has REVERTED ON COMPLETION.** |
