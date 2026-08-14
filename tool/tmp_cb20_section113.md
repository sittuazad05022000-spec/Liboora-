### 11.3 Renewal protection — governance resolution, ownership, and the cross-library indicator

> **⛔ RESOLUTION RECORDED — `FEE-GAP-013` is now PARTLY RESOLVED and PARTLY BLOCKED.**
> This subsection was rewritten at **v0.3** to answer the fourteen questions put by the Governance
> Resolution request. Four of them are answered by **measurement against existing authority**, and the
> answers are binding here. The remainder are **blocked**, and the blockers are named with the exact
> authority required. **Nothing in this subsection creates a bounded context, an event, an edge, an API,
> a schema or a configuration range.** Where the honest answer is *"this cannot lawfully exist in V1"*,
> that is what is written.

#### 11.3.1 What the sources actually say — measured, not assumed

| Probe | Result |
|---|---|
| `grep -rniE "renewal.protect\|protection period\|protection window"` over `docs/` | **0 occurrences** — the concept is **unsourced** |
| Nearest existing concept | **Grace period** — BC Map L101: `BC-06` Library Policy owns *"working hours, holidays, attendance rules, seat rules, **grace periods**. The rule **source**; other contexts are rule **consumers**"* |
| Is its length decided? | **No.** `Q-01` / `MM-GAP-001` **OPEN**. Master PRD L673 *"Open — recommendation: configurable, default 24h"*. BC Map L540 scopes it to *"`BC-02`→`BC-04` event handler semantics"* and recommends *"Configurable per tenant (BC-25), default 24h grace"* |
| Frozen `PRD-005` `MM-FR-111` | *"V1 **MUST NOT** implement a grace period that extends entitlement beyond `endDate`"*; §7.4 adds *"A recommendation inside an open question is not a decision"* |
| EA L1368 `Grace Periods (V2)` | Sits under **Entitlement Service** (`BC-21`, SaaS quota) — **a different concept**, not student membership. EA is **Rank 6, descriptive only** |
| Cross-library membership tier | `Multiple Library Memberships` **V2** (EA L911); `Cross Library Membership` **Future** (EA L735); `Membership History` **V2** (EA L734) |
| Cross-tenant read edge for membership status | **None exists.** `E-13` (`BC-01`→`BC-10`, `ACL`) is *"**the only bridge between the two worlds**"* and carries *identity core fields*. `BC-10` *"stores **no** `StudentRecordId` and **no** `tenantId`"* |

#### 11.3.2 Requirement 1 — ownership of the policy. **RESOLVED by measurement.**

The request asked whether the policy belongs to `BC-06`, `BC-02`, or another existing context. It is
**not one owner — it is three, split by the kind of thing being owned**, and every one of the three is an
*existing* context. No new context is proposed.

| Concern | Owner | Basis (measured) |
|---|---|---|
| **Does a protection window exist, and how long is it?** — the *rule* | **`BC-06` Library Policy** | BC Map L101 — `BC-06` owns grace periods and is *"the rule **source**"* |
| **The document that specifies `BC-06`** | **`PRD-002` Library Management**, `FROZEN` v1.1 | `PRD_REGISTRY.md` **L422**: `` | `BC-06` | `PRD-002` | No | `` — uncontested |
| **Membership term arithmetic** — applying any window to a term | **`BC-02` Membership** *(`PRD-005`, `FROZEN` v1.4)* | BC Map L97 — *"the commercial right-to-use: which plan a student holds, **for what term**"* |
| **Seat consequences of expiry** | **`BC-04` Seating** | `MM-FR-112`; `SEAT-FR-155`; `ADR-0019` L310 assigns `Q-01` to *"Architecture + `BC-04` owner"* |
| **Money** — obligations, receipts, ledger | **`BC-05`** — this PRD | BC Map L100 |
| **Protection *usage history*** | **`BC-02`** | It is a membership-lifecycle fact; `MM-FR-084` already records `renewedFromMembershipId` on the membership |
| **Cross-library read projection** | **⛔ UNOWNED — no context, no edge, no PRD** | `FEE-GAP-013(c)` |

**Therefore `BC-05` is not the owner of any part of the renewal-protection policy.** It is a *consumer* of
whatever `BC-02` decides. `FEE-XC-018` and `FEE-XC-020` make that refusal explicit rather than implied.

> **Why this is a resolution and not a deferral.** The request's own phrasing — *"BC-06, BC-02, or another
> existing bounded context"* — presumes a single owner. The measured architecture already splits *rule
> source* from *rule consumer* at BC Map L101, and that split is the answer: `BC-06` owns whether a window
> exists and how long it is; `BC-02` owns what a window does to a term. Naming one owner for both would
> collapse a separation the BC Map states explicitly.

#### 11.3.3 Requirement 2 — the exact V1 rule. **CANNOT BE ISSUED FROM THIS PRD.**

The request asks for: *protection window = 3 days by default*; *configurable by the policy owner only if
existing architecture permits*; *example due date 5 Aug → protection until 8 Aug*.

**`BC-05` cannot issue this rule, and no existing authority supplies it.** The measured position:

| Element of the requested rule | Measured status |
|---|---|
| A protection window exists at all | **⛔ Unsourced** — 0 occurrences repo-wide. The nearest concept's existence question, `Q-01`, is **OPEN** |
| Default = **3 days** | **⛔ Conflicts with the only recorded recommendation.** BC Map L540 and Master PRD L673 both recommend **24h**, not 3 days — and even that is *"Open"*, and `PRD-005` §7.4 states a recommendation inside an open question *"is not a decision"* |
| It extends entitlement past `endDate` | **⛔ Directly forbidden in V1** by frozen `MM-FR-111` |
| Configurable by the policy owner | **⛔ No register permits it.** `BC-06`'s configurables are `PRD-002` §16.1 `LCFG-1`…`LCFG-10` — an exactly-enumerated table stating *"Values are configurable; their **ranges and invariants are not**"*. **There is no protection-window row, and `PRD-002` is `FROZEN`.** `BC-25`/`E-19` supply the *typed accessor mechanism*, not permission to invent a value |
| Example *"5 Aug → 8 Aug"* | Cannot be normative here — it presupposes every row above |

**`E-19` does not help.** BC Map L328: `E-19` gives *"Typed config accessors; no raw string lookups in
domain code."* That is **how** a configured value is read, not authority that a given value **exists**.
Adding a `FEE-CFG-*` row for a protection window would be *"creating a configuration range without
authoritative support"* — exactly what requirement 11 forbids, and the same restraint §0.2 already applies
in refusing to open a `FEE-CFG-*` register at all.

> **The worked example is the clearest demonstration of the blocker.** *"Due date 5 Aug → protection until
> 8 Aug"* means entitlement, or seat, or both, survive past 5 Aug. Under frozen `MM-FR-111` a V1 membership
> confers nothing after `endDate`; under `MM-BR-032` an `Expired` membership *"**MUST NOT** be treated as
> active entitlement."* So the example cannot be implemented in V1 by any module — not by `BC-02`, and
> certainly not by `BC-05`. Writing it here as a normative rule would create a specification that frozen
> Rank 3 text forbids. Routed as **`FEE-GAP-013(a)`**.

#### 11.3.4 Requirement 3 — deducting the 3 protected days. **⛔ BLOCKED — frozen Rank 3 conflict.**

The request states the protected days *"are deducted from the NEW membership duration, according to the
approved membership policy."* **Measured: there is no approved membership policy that permits this, and
three frozen requirements forbid it.** This is the single hardest finding in this resolution, and it is
reported as a conflict rather than absorbed.

| Frozen authority (`PRD-005` v1.4, Rank 3) | Exact text | Effect on requirement 3 |
|---|---|---|
| **`MM-FR-086`** | *"The new `endDate` **MUST** be computed from the new `startDate` by §4.3, using the **target plan's current** `durationDays`."* | A renewal term is the plan's **full** duration. There is no subtrahend |
| **`MM-FR-057`** | *"`endDate` **MUST** be computed as `startDate + (durationDays − 1)` days"* | The formula is closed. `− 3` is not in it |
| **`MM-FR-058`** | *"The computation **MUST** be a **pure function** of (`startDate`, `durationDays`, tenant timezone). It **MUST NOT** depend on the current clock, on holidays, or on the working calendar."* | A deduction derived from *when* the student renewed makes `endDate` depend on the clock and on prior history — **which this requirement forbids** |
| **`MM-FR-057a`** | *"**The single permitted re-derivation, and the only one.**"* — delayed-payment activation, `MM-CFG-009`, and even then *"the computation itself **MUST** remain the pure function `MM-FR-058` requires"* | Enumerates **one** exception, and this is not it. *"Moving `endDate` while holding `startDate` fixed **MUST** be impossible"* |
| **`MM-XC-012`** | *"Proration arithmetic executed as money (**V2**; and `Q-06` is open — see `MM-GAP-002`)"* | Reducing a term by days already consumed **is** proration. It is **V2**, and its ownership question `Q-06` is **OPEN** |
| **`MM-FR-100`** | *"This module **MUST NOT** compute a prorated monetary credit for the source membership's unused days"* | The mirror-image arithmetic is already prohibited |

**Conclusion.** Requirement 3's deduction is a **term-shortening proration rule**. It is (i) not present in
the approved membership policy, (ii) contradicted by `MM-FR-086` and `MM-FR-058`, and (iii) classified
**V2** with an **open** ownership question (`Q-06` / `MM-GAP-002`). Under `MP-CON-08` a disagreement with a
higher-ranked document is *"a **defect to be raised**, not a choice to be made."* `PRD-008` therefore
**raises it** and does not specify it. Routed as **`FEE-GAP-013(f)`**, owner **`BC-02` owner + Product
Owner + Architecture Owner**, authority **REQUIRES AN ADR AMENDING FROZEN `PRD-005`**.

`FEE-XC-020` already forbids `BC-05` from determining, shortening or extending a membership's duration, so
**no `FEE-*` requirement changes as a result of requirement 3.** What changes is that the conflict is now
recorded with its exact citations instead of being silently unaddressed.

> **Why `BC-05` must not "help" here.** A tempting shortcut is to leave the term alone and instead charge
> 3 days less — the student experiences the same net effect. That is forbidden twice over: `FEE-FR-059`
> requires the amount to come solely from the originating `E-07` `priceSnapshot`, and frozen `MM-FR-088`
> requires the renewal amount to be *"the target plan's **current** price … **MUST NOT** be copied from the
> source membership's snapshot."* Simulating a duration change through money would put term policy in the
> finance module — precisely the confusion `FEE-XC-020` exists to prevent.

#### 11.3.5 Requirement 4 — non-renewal. **RESOLVED on the financial side.**

Requirement 4 — protection expires, no permanent penalty, a future membership gets its full configured
duration, and *"the old 3-day usage must never automatically deduct from a membership months later"* — is
**already fully satisfied** by frozen authority plus this PRD's prohibitions, and needs no new rule:

- **Full future duration** is guaranteed by `MM-FR-086` (target plan's **current** `durationDays`) and
  `MM-FR-081` (renewal from `Expired` permitted *"without limit of elapsed time"*). It is `BC-02`'s
  guarantee, not `BC-05`'s (`FEE-XC-020`).
- **No months-later deduction** is guaranteed financially by `FEE-FR-059` + `FEE-BR-026`, and verified by
  `FEE-AC-078`, which requires the later amount to be **bit-identical** to the amount computed with no
  prior usage at all.
- **No permanent penalty** is guaranteed by `FEE-BR-026` and `FEE-XC-021`.

**Requirements 3 and 4 are mutually consistent only because requirement 3 is blocked.** Were requirement 3
implemented as written, a *"deducted"* term and requirement 4's *"full configured duration"* would be two
different arithmetic rules distinguished only by elapsed time — which is exactly the clock dependency
`MM-FR-058` forbids. This is recorded in `FEE-GAP-013(f)` as a reason the deduction needs an ADR rather
than an implementation.

#### 11.3.6 Requirement 5 — voluntary departure vs. remaining. **PARTLY RESOLVED.**

The distinction the request asks to preserve is **already the frozen model**, for the leaving case:

| Case | Existing authority | Financial consequence in `BC-05` |
|---|---|---|
| Student **voluntarily leaves before** the due date | `MM-FR-079` — voiding *"**MUST NOT** be extended to an `Active` membership"*; Membership Cancellation with refund is **V2** (`MM-XC-011`). The term therefore runs to `endDate` and expires normally via `MM-EVT-005` | **Obligations already raised stand.** `MP-GBR-12` — financial records are immutable; a reversal is a compensating entry, never a mutation. Refund is `FEE-GAP-001` |
| Student **remains and requests** renewal protection | **⛔ No authority exists** — the request path, the approval, and the window are all unsourced (§11.3.1) | Nothing to specify: no `FeeDue` amount changes either way (`FEE-FR-059`) |
| Seat consequence, either case | `MM-FR-112` + `SEAT-FR-155` — the allocation is **flagged**, not auto-released, and release timing *"awaits the `Q-01` grace decision"* | Out of scope — `FEE-XC-004` |

**So half of requirement 5 is already true and needs no new rule; the other half is blocked because the
"requests protection" path does not exist.** Note that `PRD-007` L846 independently records that its
two-valued field *"cannot represent a student who is inside an approved grace period"* — a second module
confirming that no approved grace state exists to represent. Routed as **`FEE-GAP-013(g)`**.

#### 11.3.7 Requirements 6, 7 and 8 — the cross-library indicator. **⛔ BLOCKED. RECOMMENDATION: NOT V1.**

The request asks me to resolve the `ID-2` / `ID-3` conflict explicitly, to prefer a minimal `PersonId`-based
status projection *"if and only if governance approves it"*, and — if no lawful path exists — to say so and
recommend V1, V2 or removal. **The measured answer is that no lawful path exists in V1, and the blocker is
stronger than `ID-2`/`ID-3` alone.**

**The four barriers, in ascending order of severity:**

**1. `ID-2` — and it is CI-enforced, not merely written.**
> *"`StudentRecordId` **never** leaves its tenant. It must not appear in any Global Student context, event
> or index."*

Enforcement is a *"Cross-tenant leak test suite"*, and `tool/module_dependencies.yaml` L216–218 bans the
literal symbol in `domain/person` with the comment *"Rule ID-2 — a tenant identifier must never enter a
global context."* A `StudentRecordId`-keyed projection is therefore rejected by a **gate that already
exists**, not by a reviewer's opinion. **`ID-2` is respected in full: nothing proposed here carries a
`StudentRecordId`.**

**2. `ID-3` — the previous-library name is precisely the forbidden field.**
> *"Global and social contexts (BC-10→17) key exclusively on `PersonId`. They **must not be able to resolve
> which library a person attends** unless the person explicitly published it."*

The requested indicator's example includes *"Previous library"*. That field **is** the resolution `ID-3`
forbids. The request itself says *"unless an authoritative privacy rule explicitly permits it"* — **measured
answer: no source permits it, and one source forbids it in the strongest available form.**

**3. `SID-4.19` — a *capability* prohibition, which the `PersonId` proposal cannot satisfy.** This is the
decisive finding, and it is stronger than `ID-3`:
> `SID-4.19` — *"This module **SHALL NOT** answer, and **SHALL NOT** be capable of answering, 'which
> libraries does this person attend?'"*

`SID-INV-8` and `SID-1.38` make the reference direction **downward only** — the identity *"holds no
collection"* of Student Records. `SID-INT-12` lists *"Holding a collection of organisations or Student
Records"* as an integrity violation. **A `PersonId`-keyed membership-status projection is a
`PersonId → {membership status at some library}` map. Even with the library name omitted and no
`StudentRecordId` present, a non-empty result discloses that this person is enrolled *somewhere*, and a
result readable by Library B while Library B has no enrollment discloses enrollment *elsewhere*.** That
makes `BC-10` *capable of answering* the forbidden question — which `SID-4.19` prohibits as a **capability**,
not merely as an exposed field. The request's preferred option is therefore **not lawful as stated**, and
saying so is the honest answer rather than proposing it and hoping review catches the flaw.

Reinforcing this, `SID-4.22` forbids `BC-10` from *"stor[ing], mirror[ing], summaris[ing] or becom[ing] the
authority for **membership plan or status**"*; `SID-5.8` lists **`membership state`** among fields that
*"**SHALL NEVER** exist as a stored field of this module"*; `SID-4.23` forbids re-keying `BC-02`…`BC-05` on
`PersonId` and forbids `BC-10` from *"request[ing] that they be"*; and `SXC-6`/`SID-INV-7` place membership
state outside `BC-10` entirely.

**4. No registered edge — and inventing one is the highest-severity failure mode named in the architecture.**
BC Map §7 governs: *"If an edge is not in this table, it does not exist"* — needs an ADR. There is **no**
`BC-02`→`BC-10` edge and **no** cross-tenant membership read edge; `BC-05`'s only edges are `E-06`, `E-07`,
`E-09`, `E-10`. BC Map L510 calls a cross-tenant leak via a capability context *"**the single
highest-severity failure mode in the entire architecture**."* Tier evidence agrees: `Multiple Library
Memberships` **V2**, `Cross Library Membership` **Future**.

**Resolution of the `ID-2`/`ID-3` conflict, stated explicitly as requirement 7 asks:**

| Option | Verdict | Reason |
|---|---|---|
| Key the indicator on `StudentRecordId` | **⛔ REJECTED — unlawful** | `ID-2`, CI-enforced by `banned_symbols` |
| Key it on `PersonId`, include previous-library name | **⛔ REJECTED — unlawful** | `ID-3` + `SID-4.19` + `SID-5.8` |
| Key it on `PersonId`, **omit** library name, minimum disclosure | **⛔ NOT APPROVABLE AS DESIGNED** | Still makes `BC-10` *capable* of answering the forbidden question — `SID-4.19`, `SID-INV-8`, `SID-INT-12`, `SID-4.22`. Also still requires an unregistered edge |
| Build nothing cross-library in V1 | ✅ **RECOMMENDED** | Costs no capability `BC-05` owns, and preserves tenant isolation |

**Recommendation, as requirement 8 demands a choice: the cross-library indicator is NOT V1.** It is a
**V2 candidate**, consistent with the tier the Enterprise Architecture already records for `Multiple
Library Memberships` (V2) and `Membership History` (V2). It **should not be silently removed** either,
because the underlying product need is legitimate; it should be **registered as V2 and specified only after
an ADR** by the authorities named in `FEE-GAP-013`. If a V2 design is pursued, the measured constraint is
that the projection cannot live in `BC-10` as `PRD-003` is written — so the ADR must either place it in a
**new authorised context with explicit person consent** (the `ID-3` *"unless the person explicitly
published it"* carve-out is the only lawful door in the current text) or amend `SID-4.19`, which is a
privacy-critical requirement of an `IMPLEMENTING` PRD and therefore a Security decision, not an
architecture convenience.

> **Why "explicit person consent" is named as the only door, and is still not a design.** `ID-3` contains
> exactly one exception — *"unless the person explicitly published it."* That makes consent the only
> mechanism in the current text under which any library-attendance fact may cross a boundary. Naming the
> door is not the same as opening it: a consent-based disclosure needs a consent record owner (`BC-18` per
> `ID-6`), a lawful basis, a revocation path, and a registered edge — **none of which exist**, and none of
> which this PRD may create. It is recorded so the V2 discussion starts from the one lawful option rather
> than re-deriving it.

#### 11.3.8 What `BC-05` does specify — unchanged at v0.3, and re-verified

The financial rules below were introduced at v0.2 and are **re-affirmed unchanged** by this resolution:
`FEE-FR-059` (a new obligation is priced solely from its own `E-07` `priceSnapshot`), `FEE-BR-026` (no
financial penalty persists beyond the membership it arose on), `FEE-BR-027` (a renewal inside a window
carries no adverse marker), `FEE-XC-018` (not the system of record for protection history), `FEE-XC-019`
(no cross-tenant financial disclosure, **unconditional**), `FEE-XC-020` (no duration authority) and
`FEE-XC-021` (**no risk score, fraud score, trust score, blacklist, watchlist, cross-library punishment, or
*cheater*/*fraud*/*abuser*/*high risk* label**).

**Requirement 6's prohibitions are satisfied without approval and hold regardless of how `FEE-GAP-013`
is later decided.** `FEE-XC-019` is explicitly unconditional: it holds *even if* a cross-library
membership-status read is one day authorised. `FEE-XC-021` is likewise unconditional, and note that
`BC-13` **Trust & Safety** already exists for abuse handling — so even a legitimate future need would not
land in `BC-05`.

`FEE-FR-059` — *(text unchanged; see the register in §29)* — is re-verified against `MM-FR-088`,
`MM-FR-084` and `MM-FR-081`, all of which remain in force at `PRD-005` v1.4.

#### 11.3.9 Disposition of all fourteen requirements

| # | Requirement | Disposition | Where |
|---|---|---|---|
| 1 | Which BC owns the policy | ✅ **RESOLVED** — `BC-06` owns the rule (via `FROZEN` `PRD-002`, registry L422); `BC-02` owns term effect; `BC-04` owns seat effect; `BC-05` owns none of it | §11.3.2 |
| 2 | Exact V1 rule, 3-day default, configurable | ⛔ **BLOCKED** — unsourced; conflicts with the recorded 24h recommendation, which is itself open; `MM-FR-111` forbids V1 entitlement extension; no configurable row exists and `PRD-002` §16.1 is `FROZEN` | §11.3.3, `FEE-GAP-013(a)` |
| 3 | Deduct 3 protected days from the new term | ⛔ **BLOCKED — frozen conflict** — `MM-FR-086`, `MM-FR-057`, `MM-FR-058`, `MM-FR-057a`, `MM-XC-012` (**V2**, `Q-06` open) | §11.3.4, `FEE-GAP-013(f)` |
| 4 | Non-renewal: no penalty, full future duration | ✅ **RESOLVED** — financially by `FEE-FR-059`, `FEE-BR-026`, `FEE-AC-078`; duration by `MM-FR-086`/`MM-FR-081` at `BC-02` | §11.3.5 |
| 5 | Voluntary-leave vs. remain distinction | ⚠️ **PARTLY RESOLVED** — the leaving case is the frozen model (`MM-FR-079`, `MM-XC-011`); the *"requests protection"* path is unsourced | §11.3.6, `FEE-GAP-013(g)` |
| 6 | Minimum indicator; never expose payments/notes; no fraud score | ✅ **SPECIFIED AS PROHIBITIONS** — `FEE-XC-019`, `FEE-XC-021`, both unconditional | §11.3.8 |
| 7 | Resolve `ID-2`/`ID-3`; prefer `PersonId` projection iff approved | ✅ **RESOLVED AS "NOT APPROVABLE AS DESIGNED"** — `ID-2` CI-enforced; `ID-3` forbids the library name; **`SID-4.19` forbids the *capability***, which the `PersonId` option cannot satisfy | §11.3.7 |
| 8 | If no lawful path, record blocker + authority + V1/V2/removed | ✅ **RESOLVED** — blocker recorded; **recommendation: V2, not V1, not removed** | §11.3.7, `FEE-GAP-013` |
| 9 | No silent frozen edits | ✅ **HONOURED** — 0 files changed under `membership-management/`, `library/`, `student-identity/`, `seat-management/`, `10-architecture/`, `00-governance/` | §41 |
| 10 | No ADR without authority | ✅ **HONOURED** — no ADR authored; four are *required* and named | `FEE-GAP-013` |
| 11 | No new events/edges/APIs/schemas/config ranges | ✅ **HONOURED** — 3 `fee.*` events unchanged; 4 edges unchanged; **no `FEE-CFG-*` register**, and §11.3.3 explains why one was refused | §0.2, §9.1, §26 |
| 12 | Update only genuinely supported decisions | ✅ **HONOURED** — the two resolutions added (§11.3.2, §11.3.5) rest on `PRD_REGISTRY.md` L422, BC Map L101 and frozen `MM-FR-086`/`MM-FR-081`; **no `FEE-*` requirement was added or altered at v0.3** | §41 |
| 13 | Re-run gates and traceability | ✅ **DONE** — see the covering report | — |
| 14 | Report Stage 3 eligibility | ✅ **REPORTED** — see the covering report §K | — |

#### 11.3.10 What remains blocked, and to whom it is routed

| Blocked item | Exact blocker | Authority required |
|---|---|---|
| A protection window exists; its length; its configurability | `Q-01`/`MM-GAP-001` **OPEN**; `MM-FR-111`; `PRD-002` §16.1 `LCFG-1`…`10` is a closed table in a `FROZEN` PRD | **Product Owner** + **`BC-06` owner (`PRD-002`)** — an ADR amending `FROZEN` `PRD-002` |
| Deducting protected days from a new term | `MM-FR-086`, `MM-FR-058`, `MM-FR-057a`; `MM-XC-012` **V2**; `Q-06`/`MM-GAP-002` **OPEN** | **`BC-02` owner** + Product Owner + Architecture Owner — an ADR amending `FROZEN` `PRD-005` |
| Storing protection-usage history | `BC-02` `FROZEN` v1.4 with no such field; `Membership History` EA-**V2** | **`BC-02` owner** — post-freeze ADR |
| Library B reads any status signal | No registered edge (BC Map §7 *"if an edge is not in this table, it does not exist"*); BC Map L510 | **Architecture Owner** |
| Indicator keyed on `PersonId`, name omitted | **`SID-4.19`** capability prohibition; `SID-INV-8`, `SID-INT-12`, `SID-4.22`, `SID-5.8`, `SID-4.23` | **Security + Privacy** + **`BC-10` owner (`PRD-003`)** |
| Indicator naming the previous library | **`ID-3`**, whose only exception is explicit publication by the person | **Security + Privacy**; consent record owner is `BC-18` (`ID-6`) |
| *"Full configured duration"* as a guarantee | Not `BC-05`'s (`FEE-XC-020`); it is `MM-FR-086`'s | **`BC-02` owner** — already satisfied, recorded for completeness |

**No frozen document was modified.** `PRD-002` v1.1 (`BC-06`), `PRD-005` v1.4 (`BC-02`), `PRD-004` v1.2
(`BC-01`) and `PRD-007` v1.1 (`BC-04`) are `FROZEN`; `PRD-003` (`BC-10`) is `IMPLEMENTING` and Rank 3
frozen. Four distinct ADRs by four distinct owners would be required to build the feature as requested,
and **none has been authored here**, because requirement 10 forbids accepting an ADR without its authority.
