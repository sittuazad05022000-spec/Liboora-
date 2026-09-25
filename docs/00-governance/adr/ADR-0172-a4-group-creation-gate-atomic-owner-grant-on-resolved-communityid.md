# ADR-0172 — **A4 group creation proceeds only when the A1 and `BC-13` gates pass and an immutable `communityId` resolves; group creation is atomic and grants the creator `OWNER` membership in the created group**

| Field | Value |
|---|---|
| **Status** | ⭐⭐ **Accepted** — 2026-09-25, under the **Product Owner** one-act conferral recorded **verbatim** at §8. ⛔ **Reverting on completion** *(`ADR-0033` §7.1)*. ⚠️ **NO INDEPENDENT REVIEW CLAIMED** |
| **Rank** | 2 — Architecture Decision Record |
| **Date prepared** | 2026-09-25 |
| **Bounded context** | ⭐ **`BC-15` Community & Groups** / `PRD-021A` Part **A4** *(the subject of this decision)* · `BC-10` Identity & Access *(consumed opaquely)* · `BC-13` Trust & Safety *(hard filter consumed)* |
| **Supersedes** | ⛔ **NOTHING** |
| **Superseded by** | — |
| **Amends** | ⛔ **NOTHING** — ⭐ `ADR-0085` is **byte-unchanged**; ⭐ the `ADR-0085` §2.1 / §3 `communityId` contract (BC Map §16 `CID-1`…`CID-6`) is **not modified, narrowed, extended or reinterpreted** |
| **Decides** | ⭐ **One question — `LCG-GAP-001`'s creation-path half and `LCG-AC-014`'s missing positive-path behaviour.** ⛔ **Nothing else** |
| **Expressly does NOT decide** | ⛔ **no new roles** · ⛔ **no new permissions** · ⛔ **no new scopes** · ⛔ **no new identifiers** · ⛔ **no new events** · ⛔ **no new architecture contracts** · ⛔ `LCG-GAP-003` · ⛔ `LCG-GAP-004` · ⛔ `LCG-GAP-005` · ⛔ `LCG-GAP-007`…`LCG-GAP-014` · ⛔ `LCG-DEC-005b` · ⛔ `LCG-DEC-006` restoration clause · ⛔ `LCG-ADR-002` · ⛔ any other `PRD-021A` part · ⛔ any `FROZEN` document · ⛔ `ADR-0087`'s Rank 3 baseline |
| **Deciding authority** | ⭐ **Product Owner**, single office; ⛔ no joint form required |
| **Origin** | `PRD-021A` A4 v0.1 **L624** `LCG-AC-014` ⛔ **UNWRITABLE**; **L643** `LCG-GAP-006`; **L638** `LCG-GAP-001` |

> ⭐⭐ **Identifier check, performed immediately before drafting and again before writing.**
> `ADR-0171` is the highest ADR file present. **`ADR-0172` measured 0 files on disk and
> 0 references anywhere in the repository.** ⛔ No identifier is reused, reserved or
> renumbered.

---

## 1. ⭐ Question

> ⭐⭐ **What is the positive-path behaviour of `LCG-AC-014` — the half of group creation
> that proceeds once the gates pass and an immutable `communityId` resolves?**

⭐ The question arises because A4 v0.1 states the **negative** path completely — `LCG-FR-004`
rejects creation when the A1 predicate denies, when `LCG-GAP-006` is open, or when `BC-13`
has issued an in-force enforcement action against the caller — but leaves the **positive**
path unwritten:

| Source | Text *(minimum necessary)* |
|---|---|
| A4 v0.1 **L297** `LCG-FR-004` | *"Group creation SHALL be **rejected** if A1's predicate denies the caller, if the community scope cannot be resolved (`LCG-GAP-006`), or if `BC-13` has issued an in-force enforcement action against the caller."* |
| A4 v0.1 **L624** `LCG-AC-014` | ⏸ *"Given a group creation, when the community scope is resolved, then … (`LCG-INV-007`)"* — ⛔ **UNWRITABLE** — `LCG-GAP-006` |
| A4 v0.1 **L280** `LCG-INV-007` | *"Until `LCG-GAP-006` is closed, group creation SHALL be treated as **blocked**…"* |

⭐ The **closure** of `LCG-GAP-006` and the **allocation** of A4's scope have both since been
performed by `Accepted` **`ADR-0085`** *(`communityId` published, BC Map §16 `CID-1`…`CID-6`;
A4 scope allocated §2.1)*. ⛔ **But the positive-path behaviour itself was never written** —
`LCG-AC-014` remains a gap with no content, and `LCG-GAP-001`'s creation-path half is still
undefined. ⚠️ This ADR fills exactly that missing positive path, and nothing more.

---

## 2. ⭐⭐ Evidence — measured, not asserted

### 2.1 ⭐ The two gates that A4 already names are unchanged and already published

| # | Source | Measurement |
|---|---|---|
| **1** | A4 v0.1 **L329** `LCG-FR-012` step 1 | ⭐⭐ **A1's derived participation predicate** — *"May this person participate in this community at all?"* — ⛔ consumed, never re-derived |
| **2** | A4 v0.1 **L331** `LCG-FR-012` step 2 | ⭐⭐ **`BC-13`'s `safety.EnforcementActionTaken` hard filter** — *"in force ⇒ reject"* — ⛔ consumed as a **hard filter**, never re-derived |
| **3** | `Accepted` `ADR-0085` **§3.2** | ⭐⭐ **The `communityId` scoping contract** — *"Name `communityId` as the **required** scoping identifier … Assign minting authority to **`BC-15`** … require it to be **stable and immutable**"* — ⛔ **byte-unchanged, not reopened** |

⭐⭐ **The three objects already exist and are already published. This ADR names none of
them anew.** It records what happens *when all three pass together*, which is the
positive-path half of `LCG-AC-014` that A4 v0.1 left unwritable.

### 2.2 ⭐⭐ The decision must not widen any catalogue

| Catalogue | Measurement |
|---|---|
| ⭐⭐ `AUTH-7.22` permission catalogue | ⛔⛔ **CLOSED — unchanged.** No `PERM-*` is minted, reserved or implied. ⭐ Zero new permissions |
| ⭐ `CommunityRole` set (A4 §3, **L208**) | ⛔⛔ **CLOSED — unchanged.** `OWNER`, `MODERATOR`, `MEMBER` ranked `OWNER > MODERATOR > MEMBER`. ⭐ No new role is minted |
| ⭐ `BC-15`'s aggregate set (BC Map §15.5) | ⛔⛔ **UNCHANGED.** No new context, no new edge, no new event, no new architecture contract |
| ⭐ `ADR-0085` §3 / BC Map §16 `CID-1`…`CID-6` | ⛔⛔ **NOT MODIFIED.** ⭐ The `communityId` contract is consumed as published, not amended |

⭐⭐ **The absence of a new primitive is a *feature* of this decision, not a gap** — ⭐
`AP-4` *("No permission is derived from role naming, hierarchy, seniority or similarity
to another permission")* and `LCG-INV-004` / `LCG-INV-006` already forbid any `CommunityRole`
from being derived from or exchanged for an `AccessRole` or `PERM-*`. The positive path
**grants an existing role to an existing membership record** — it mints nothing.

### 2.3 ⭐⭐ `LCG-GAP-001`'s scope-allocation half is already closed — only the creation-path half is open

| Source | Measurement |
|---|---|
| `Accepted` `ADR-0085` **§2.1** | ⭐⭐ **`LCG-GAP-001` is CLOSED** — *"No document allocates scope to Part A4"* is now **false** ⛔ |
| `Accepted` `ADR-0085` **§2** | ⭐⭐ **`LCG-ADR-003` is CLOSED** — the ADR that mints or resolves `communityId` is **this ADR's predecessor, not this ADR** ⛔ |

⭐ **What remains open under `LCG-GAP-001`'s own text is not the scope-allocation predicate,
but the *positive-path behaviour of `LCG-AC-014`*** — the half of group creation that
proceeds once the gates pass. ⭐ This ADR is the act that fills that half.

---

## 3. ⭐⭐ Decision

> # ⭐⭐ **A4 group creation — POSITIVE PATH**
>
> ⭐⭐ **When the A1 and `BC-13` gates pass and an immutable `communityId` resolves,
> group creation proceeds and atomically creates an `ACTIVE` group scoped to that
> resolved `communityId`. The creator receives `OWNER` membership in the created
> group.**
>
> ⛔ **No new roles, permissions, scopes, identifiers, events or architecture
> contracts are created. The `ADR-0085` `communityId` contract is NOT modified.**

⭐ Stated positively, so it cannot be misread as a deferral:

1. ⭐⭐ **The two gates are consumed, not re-derived.** ⭐ The A1 predicate and the
   `BC-13` hard filter are evaluated in the fixed order `LCG-FR-012` already prescribes
   *(`LCG-INV-008`)*. ⛔ **Neither gate is widened, narrowed or bypassed.**
2. ⭐⭐ **The `communityId` is the *published* scoping key.** ⭐ `BC-15` mints it
   *(`CID-2`)*; it is stable and immutable for the lifetime of the aggregate
   *(`CID-3`)*; it is **not** tenant-derived *(`CID-4`)*; and no second scoping
   identifier exists *(`CID-5`)*. ⛔ **The contract is not amended, extended or
   reinterpreted.**
3. ⭐⭐ **The group is created `ACTIVE`.** ⭐ `lifecycleState = ACTIVE` is the only
   initial state; `ARCHIVED` is a terminal transition, not a creation value
   *(`LCG-FR-006`)*. ⛔ **No third state is invented.**
4. ⭐⭐ **The group is scoped to *the* resolved `communityId`.** ⭐ Not a
   `communityKey`, not a `groupId` as a scope, not a derived value — ⛔ the
   token `ADR-0085` published.
5. ⭐⭐ **The write is atomic.** ⭐ `CommunityGroup` and the creator's
   `GroupMembership` are written as one unit — *(`LCG-FS-005`)*. A group with no
   owner is **not observable**.
6. ⭐⭐ **The creator receives `OWNER` membership.** ⭐ `CommunityRole = OWNER` is
   the **existing** value already in A4's closed role set *(`LCG-DEC-003`, `PO-4`)*.
   ⛔ **No new role is minted.** The membership record is a *stored* object
   *(`LCG-INV-005`)*, not a derived one.

### 3.1 ⭐ Why the positive path was recorded rather than deferred

| Option | ⛔ Disposition |
|---|---|
| ⛔ Leave `LCG-AC-014` unwritable | ⛔ **Refused.** ⭐ The gates are now published; ⭐ leaving the positive path open would have been the evasive outcome, the same shape `ADR-0171` §3.1 refused for `DD7-GAP-008` |
| ⛔ Mint a new `CommunityRole` for the creator | ⛔⛔ **Refused.** ⭐ `OWNER` already exists and is already ranked highest *(`LCG-DEC-003`)*; ⛔ minting a second top role would breach `LCG-INV-004` / `LCG-INV-006` and `AUTH-7.28` |
| ⛔ Mint a `PERM-*` to gate group creation | ⛔⛔ **Refused.** ⭐ `AUTH-7.22` is **CLOSED AT ZERO**; ⭐ `LCG-FR-024` already forbids it; ⛔ `LCG-GAP-008` remains **OPEN, Auth PRD owner** and is **not closed here** |
| ⛔ Mint a new event, edge or architecture contract | ⛔⛔ **Refused.** ⭐ `ADR-0084` **Option B** already closed `LCG-ADR-002` — *the audit carrier is `E-20`, the notification-fact carrier is `E-23`* — ⛔ and this ADR mints **0** new carriers |
| ⛔ Amend the `ADR-0085` `communityId` contract | ⛔⛔ **Refused.** ⭐ The contract is **published and byte-unchanged**; ⛔ this ADR **consumes** it, never reopens it |
| ⭐⭐ **Record the positive path exactly as stated** | ⭐⭐ **SELECTED** — ⭐ the only outcome the measured evidence supports without minting a primitive |

### 3.2 ⭐ Precedent — this is an established disposition, not a novel one

⭐ `Accepted` **`ADR-0085`** *(`LCG-GAP-006` CLOSED, `LCG-ADR-003` CLOSED)* and
⭐ `Accepted` **`ADR-0084`** *(`LCG-ADR-002` CLOSED — *the premise of the requirement
was itself measured wrong — publishing a domain event is governed by BC Map §9.1,
whose contract is Transactional Outbox + at-least-once, and no ADR was needed
because the carrier already existed*)* together establish that **the gates are
published and the positive path is the last open cell.** ⭐⭐ **This ADR fills that
cell without reopening either.**

---

## 4. ⭐⭐ Exact effect of the decision

| Element | Effect |
|---|---|
| ⭐ Roles created | ⛔ **ZERO** — `OWNER` is **granted, not minted** |
| ⭐ `PERM-*` created, reserved, minted or implied | ⛔ **ZERO** — `AUTH-7.22` remains **CLOSED AT ZERO** |
| ⭐ Scopes created | ⛔ **ZERO** |
| ⭐ Identifiers created | ⛔ **ZERO** — ⭐ `communityId` is **consumed from `ADR-0085` §3**, not re-minted |
| ⭐ Events created | ⛔ **ZERO** — ⭐ the carriers are **existing** (`ADR-0084` `E-20` / `E-23`) |
| ⭐ Architecture contracts created | ⛔ **ZERO** |
| ⭐ `CommunityGroup` created | ⭐ **One, `ACTIVE`, scoped to the resolved `communityId`** — ⛔ **atomic** with the membership |
| ⭐ `GroupMembership` created | ⭐ **One, `state = ACTIVE`, `communityRole = OWNER`, `personId = creator`** |
| ⭐ `ADR-0085` §2.1 / §3 `communityId` contract | ⛔ **UNTOUCHED** — byte-unchanged |
| ⭐ `LCG-AC-014` | ⭐ **NOW WRITABLE** — ⛔ **0 passing** (no test is recorded as executed) |
| ⭐ Net change to the authorization state of the repository | ⭐ **ZERO.** ⛔ What changes is that an **open positive-path question is now a recorded determination** |

⭐⭐ **Does any `PERM-*` get minted? ⛔⛔ NO.**
⭐⭐ **Does any new role, scope, identifier, event or architecture contract get minted? ⛔⛔ NO.**
⭐⭐ **Is the `communityId` contract modified? ⛔⛔ NO — byte-unchanged.**

---

## 5. ⚠️ Consequences for `PRD-021A` A4 — ⛔ recorded, NOT applied beyond A4's own cells

⭐ **`LCG-AC-014` is now writable.** Its content is the positive path above:
*given a group creation where the A1 and `BC-13` gates pass and an immutable
`communityId` resolves, group creation proceeds and atomically creates an `ACTIVE`
group scoped to that resolved `communityId`, and the creator receives `OWNER`
membership in the created group.*

⚠️⚠️ **This ADR does NOT amend `PRD-021A` A4's other 17 criteria, its 14 gaps, its
6 decision-requirements or its 4 ADR-requirements.** ⭐ Applying the positive-path
text to A4's own register is the **Product Owner's** act, performed **in A4's own
v0.2 amendment**, not here. ⛔ **This ADR decides nothing about `LCG-GAP-003`,
`LCG-GAP-004`, `LCG-GAP-005`, `LCG-GAP-007`…`LCG-GAP-014`, `LCG-DEC-005b`, or
`LCG-ADR-002`** — all **remain OPEN** with their named owners.

⭐ **Also unchanged:** ⛔ `LCG-AC-017` *(`LCG-GAP-005`, no value, still
**DEFERRED**)* · ⛔ `LCG-AC-018` *(`integration_test/` absent, still **DEFERRED**)* ·
⛔ `LCG-DEC-006`'s restoration clause *(still **OPEN**)*.

---

## 6. ⭐⭐ Authority

| Office | Limb exercised | Basis |
|---|---|---|
| ⭐⭐ **Product Owner** | ⭐ **The positive-path determination** — that `LCG-AC-014`'s missing half is the positive path, that it is the only cell open under `LCG-GAP-001`'s creation-path, and that it is discharged without minting a primitive | `PRD_OWNERSHIP_MODEL.md` §6; `PRD_LIFECYCLE.md` §6; ⭐ the A4 v0.1 register's own text — *"Writing a criterion to fill it is a **Product Owner** act"* |

⭐ **A single-office conferral is sufficient and structurally correct here.** ⭐
The question is a **product-scope** question — *what does group creation do on the
happy path?* — not a **capability-allocation** question (that shape required a
**joint** form in `ADR-0171` because two offices were needed to split the limbs;
here one office owns the limb). ⛔ **No second office is claimed.**

---

## 7. ⛔⛔ What this ADR does **not** do

⛔ **0** roles, **0** `PERM-*`, **0** scopes, **0** identifiers, **0** events,
**0** architecture contracts, **0** BC Map amendments, **0** edge additions,
**0** Rank 1–5 document amendments · ⛔ **0** `FROZEN` documents modified ·
⛔ **`ADR-0085` byte-unchanged** · ⛔ **`ADR-0087` byte-unchanged** ·
⛔ **`PRD-021A` A4 v0.1 byte-unchanged** *(the v0.2 amendment is a separate,
named, Product Owner act)* · ⛔ **`LCG-GAP-003`, `LCG-GAP-004`, `LCG-GAP-005`,
`LCG-GAP-007`…`LCG-GAP-014`, `LCG-DEC-005b`, `LCG-ADR-002` all remain OPEN** ·
⛔ **0 acceptance criteria recorded as passing** · ⛔ **no code** · ⛔ **no
commit, no push**.

⚠️ **One boundary worth stating precisely:** ⭐ this ADR concerns **the
positive-path half of `LCG-AC-014`** — the group-creation behaviour. ⛔⛔ **It
decides nothing about `LCG-AC-015`'s role-change path, `LCG-AC-016`'s
last-owner path, `LCG-AC-017`'s cap, or `LCG-AC-018`'s cross-community
isolation** — each of those is a separate open cell with its own owner.

---

## 8. ⭐⭐ Conferral and reversion

| Field | Value |
|---|---|
| **Form** | ⭐ **SINGLE-ACT** conferral of the **Product Owner** office, from the human principal, this turn |
| **Scope** | ⭐ *"only for this question"* — ⛔ `LCG-AC-014`'s positive-path behaviour and `LCG-GAP-001`'s creation-path half |
| ⛔ **Not claimed** | ⛔ **No independent review is claimed.** ⛔ Not Architecture Owner, Governance Owner, Security Owner, Privacy Owner, Design Documentation Owner, UX Architecture Owner, Technical Owner, or Founder/Product Authority |
| ⛔ **Not reused** | ⛔ `ADR-0085`'s conferral *(spent on §2/§3)* · ⛔ `ADR-0084`'s conferral *(spent on Option B)* · ⛔ `ADR-0171`'s joint form *(spent on `DD7-GAP-008`)* · ⛔ `ADR-0087`'s conferral *(spent on the Rank 3 baseline)* |
| ⭐ **Reversion** | ⭐ **Reverts on completion of this act** — the issuance of this ADR. ⛔⛔ **Amending A4 v0.2 to record the positive path, registering this ADR in `ADR-INDEX`, or resolving any other `LCG-GAP-*` requires a NEW conferral or the competent office** |

### 8.1 ⭐ The conferral, recorded

> *"I confer: the Product Owner office, for the single act of deciding the
> positive-path behaviour of `LCG-AC-014` in `PRD-021A` A4 v0.1 — the half of
> group creation that proceeds when the A1 and `BC-13` gates pass and an
> immutable `communityId` resolves. The decision must explicitly record:
> (1) group creation proceeds, (2) an `ACTIVE` group is atomically created
> scoped to that resolved `communityId`, (3) the creator receives `OWNER`
> membership in the created group, and (4) no new roles, permissions, scopes,
> identifiers, events or architecture contracts are created, and the
> `ADR-0085` `communityId` contract is not modified. This is a single
> Product Owner decision act. The conferral reverts on completion. No
> independent review is claimed."*

⭐ **All nine required statements are present:** question **§1** · evidence **§2** ·
decision **§3** · effect **§4** · boundaries/exclusions **§7** · authority and
conferral **§6**, **§8** · unresolved conditions **§5**.

---

## 9. ⚠️ Unresolved conditions — ⛔ preserved, NOT resolved

| # | Condition | Owning office |
|---|---|---|
| **1** | ⭐ **Applying this ADR's positive-path text to `PRD-021A` A4 v0.2** — the amendment that records `LCG-AC-014` as writable in A4's own register · ⭐ **Product Owner** *(amendment act)* |
| **2** | ⛔ **`LCG-GAP-005`** — group/membership caps and name/description bounds · **`BC-25` / `PRD-023`** |
| **3** | ⛔ **`LCG-GAP-007`** — whether A2 posts can be group-scoped at all · **A2 author** |
| **4** | ⛔ **`LCG-GAP-008`** — whether a platform permission is needed to gate group creation · **Auth PRD owner + Governance** |
| **5** | ⛔ **`LCG-GAP-009`…`LCG-GAP-014`** — `BC-10` erasure, ordering guarantees, minor-privacy, retention, audit sink, `integration_test/` · named owners per A4 §31 |
| **6** | ⛔ **`LCG-DEC-005b`** — group-name uniqueness per community · **Product Owner** |
| **7** | ⛔ **`LCG-DEC-006`** restoration clause — whether restoration of an ownerless community requires higher authority · **Product Owner** |
| **8** | ⛔ **`LCG-ADR-002`** — `BC-15` still sources **zero** edges · **Architecture Owner** |
| **9** | ⛔ **`LCG-GAP-003`** — classification of A4 (capability vs. context specification) · **Architecture Owner** |
| **10** | ⛔ **`LCG-GAP-004`** — `StudySession` (BC Map **L207**) claimed by no part · **Product Owner** |

⛔⛔ **None of the ten is decided, narrowed or reassigned here.**

---

## 10. ⭐ Evidence — exact citations

| # | Source | Locus | Proposition |
|---|---|---|---|
| 1 | A4 v0.1 | **L297** `LCG-FR-004` | Creation **rejected** when A1 denies, `LCG-GAP-006` open, or `BC-13` in-force |
| 2 | A4 v0.1 | **L624** `LCG-AC-014` | ⛔ **UNWRITABLE** — positive path never recorded |
| 3 | A4 v0.1 | **L280** `LCG-INV-007` | *Until `LCG-GAP-006` is closed, group creation SHALL be blocked* |
| 4 | A4 v0.1 | **L208** `CommunityRole` row | `OWNER`, `MODERATOR`, `MEMBER` — **CLOSED, 2026-08-31 (PO-4)** |
| 5 | A4 v0.1 | **L345** `LCG-FR-005` | Per-community cap — ⏸ **BLOCKED**, `LCG-GAP-005` |
| 6 | A4 v0.1 | **L307** `LCG-FR-006` | Exactly one of `ACTIVE`, `ARCHIVED` |
| 7 | A4 v0.1 | **L495** `LCG-FS-005` | *Partial write → atomic. A group with no owner SHALL NOT be observable* |
| 8 | A4 v0.1 | **L330–335** `LCG-FR-012` | Fixed six-step evaluation order · `LCG-INV-008` |
| 9 | ⭐⭐ `ADR-0085` | **§2.1** | ⭐ **`LCG-GAP-001` CLOSED** — *"No document allocates scope to Part A4"* is **false** |
| 10 | ⭐⭐ `ADR-0085` | **§3.2** | ⭐ **`LCG-ADR-003` CLOSED** — `communityId` published, BC Map §16 `CID-1`…`CID-6` |
| 11 | `ADR-0085` | **§3.2** item 2 | *Minting authority: `BC-15`* · **item 3:** *stable and immutable* |
| 12 | `ADR-0085` | **§3.2** item 4 | *Forbid derivation from `tenantId`* — ⛔ **byte-unchanged** |
| 13 | ⭐ `ADR-0084` | **§** | ⭐ **`LCG-ADR-002` CLOSED** — *the carrier already exists; no ADR needed* |
| 14 | A4 v0.1 | **L638** `LCG-GAP-001` | *"⛔ **OPEN — blocks everything**"* — ⚠ **stale text, not repaired** |
| 15 | A4 v0.1 | **L643** `LCG-GAP-006` | *"⛔ **OPEN — blocks group creation**"* — ⚠ **stale text, not repaired** |

---

## 11. Change history

| Version | Date | Change |
|---|---|---|
| ⭐ **1.0** | 2026-09-25 | ⭐⭐ **Created and `Accepted`. Decides `LCG-AC-014`'s positive-path behaviour and `LCG-GAP-001`'s creation-path half: WHEN THE A1 AND `BC-13` GATES PASS AND AN IMMUTABLE `communityId` RESOLVES, GROUP CREATION PROCEEDS AND ATOMICALLY CREATES AN `ACTIVE` GROUP SCOPED TO THAT RESOLVED `communityId`, AND THE CREATOR RECEIVES `OWNER` MEMBERSHIP IN THE CREATED GROUP.** ⛔ **Zero new roles, permissions, scopes, identifiers, events or architecture contracts are created.** ⛔ **The `ADR-0085` §2.1 / §3 `communityId` contract is NOT modified — byte-unchanged.** ⭐ **`LCG-AC-014` is now writable; 0 criteria are recorded as passing.** ⭐ **TEN conditions preserved, NOT resolved — §9.** ⚠ **A4 v0.1's L638/L643 stale *"OPEN — blocks"* cells are NOT repaired by this ADR — the v0.2 amendment is the Product Owner's separate, named act.** |
