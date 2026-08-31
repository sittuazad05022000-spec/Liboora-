<!--
  PROVENANCE — PRD-021A Part A4

  CONTEXT-LOSS RECOVERY / CONTINUITY ARTEFACT.

  Status        : DRAFT — v0.1
  Freeze status : NOT FROZEN. NOT FINAL. NOT APPROVED. NOT BASELINED.
  Lifecycle     : No stage advanced. Stage 3 is NOT CONFERRED. The 7-stage
                  finalisation and freeze happen only after A1-A8 are all
                  complete (A1 L15, A2 L223). A5-A8 do not exist.
  Scope status  : THE SCOPE ALLOCATION OF THIS PART IS ITSELF OPEN.
                  No repository document states what Part A4 covers. This part
                  is scoped to the measured residue of BC-15 that A2 explicitly
                  excludes (LCF-XC-007, A2 L459). Whether that residue is A4 is
                  a PRODUCT OWNER decision, recorded as LCG-GAP-001 /
                  LCG-DEC-001. Until it is taken, this document is a CANDIDATE
                  scope, not an allocated one.
  Namespace     : LCG-* — PROPOSED, not registered. Collision-checked
                  (measured: 0 occurrences repo-wide). Registration is a
                  Governance Owner act (ADR-0080 section 5) — LCG-GAP-002.

  This part does NOT:
    - create a bounded context (count remains 31 / 23 in V1)
    - create an integration edge, event, permission, role or parameter
    - reclaim any concern owned by A1, A2, A3, BC-02, BC-10, BC-11, BC-13,
      BC-14, BC-15's CommunityPost half, BC-18, BC-22, BC-25 or BC-26
    - act as a placeholder for A5-A8
    - amend any FROZEN PRD or override any ACCEPTED ADR
    - record any acceptance criterion as passing
-->

# PRD-021A — PART A4

## Community Groups, Group Membership & Community Roles

### Specification v0.1 — DRAFT

> ⚠ **DRAFT — NOT FROZEN, NOT FINAL, NOT ALLOCATED.** Committed for
> context-loss recovery and continuity only. The scope allocation of this part
> is an **OPEN Product Owner decision** (§31 `LCG-GAP-001`).

---

## 0. Document control

| Field | Value |
|---|---|
| **Part** | A4 — Community Groups, Group Membership & Community Roles |
| **Version** | v0.1 — first draft. Supersedes nothing |
| **Status** | **DRAFT — not baselined, not approved, not frozen.** Scope allocation OPEN |
| **Predecessors** | A1 v0.2, A2 v0.8, A3 v0.6 — consumed as published, **not amended** |
| **Classification** | ⏸ **NOT DETERMINED HERE.** Candidate: specification of `BC-15`'s non-post aggregates. Assignment is an Architecture Owner act — §31 `LCG-GAP-003` |
| **Bounded context** | **None created.** Context count remains **31 (23 in V1)** — BC Map L147 |
| **Target release band** | **V2**, inherited: BC Map **L119** (`BC-15` = V2), **L147** (V2 set includes `BC-15`), `MASTER_PRD.md` **L92** `MP-SCOPE-04`. This part ships no earlier than `BC-15` |
| **Identifier namespace** | `LCG-*` — ⏸ **PROPOSED.** Collision-checked: **0** occurrences repo-wide. ⛔ Registration is a Governance Owner act (`ADR-0080` §5) — `LCG-GAP-002` |
| **Frozen documents amended** | **Zero** |
| **ACCEPTED ADRs overridden** | **Zero** |
| **New contexts / edges / events / roles / permissions** | **Zero of each.** Four are *required* and raised as ADR requirements (§32) |

### 0.1 Normative language

| Word | Meaning |
|---|---|
| **MUST** / **SHALL** / **MUST NOT** | Absolute requirement or prohibition. A violation is a defect |
| **SHOULD** | Strong recommendation; departure must be recorded |
| **MAY** | Genuinely optional |
| ⏸ **BLOCKED** | Specified, but not implementable until a named external act occurs |
| ⛔ **OPEN** | No decision exists. This document does not take it |

### 0.2 What this document is not

It does not define architecture (BC Map, Rank 4), does not decide configuration
values (`PRD-023` / `BC-25`), does not confer authority, does not advance any
lifecycle stage, and implements nothing. Where an authority already decides a
question, this document **cites** rather than restates.

### 0.3 ⛔ The scope gate — read before any requirement below

`LCG-INV-001` | **Every requirement in this document is conditional on
`LCG-DEC-001` (§32).** No repository document allocates scope to Part A4. If the
Product Owner allocates this residue elsewhere, this document is withdrawn in
full, not amended.

`LCG-INV-002` | This part SHALL NOT introduce a second answer to any ownership
question already answered by A1, A2, A3, or the BC Map. Where a concern is owned
elsewhere, this part consumes a published contract or does without.

`LCG-INV-003` | This part SHALL NOT act as a container for concerns merely
because they are unowned. A concern enters scope only if it is (a) named in
`BC-15`'s BC Map **L119** charter, **and** (b) explicitly excluded by A2 or A3.

---

## 1. Purpose

`BC-15` is chartered by BC Map **L119** as *"Community & Groups"*, owning
**four** things:

> *"Owns communities, study groups, membership of groups, community roles."*

A2 v0.8 specifies **exactly one** of them — `CommunityPost` — and says so
(`LCF-FR-016`, **L510**), then explicitly excludes the rest:

> `LCF-XC-007` | Study groups, community roles, group membership | **`BC-15`'s
> other aggregates** — BC Map **L119**. A2 specifies `CommunityPost` only

A3 v0.6 orders posts and owns nothing else (`LCR-INV-003`, §5).

⇒ **Three of `BC-15`'s four chartered aggregates have no specification.** This
part specifies them, so that `BC-15` can be implemented against a complete
charter rather than a partial one.

It answers three questions:

1. **What is a group?** — a durable, named, community-scoped collection of
   participants, owned by `BC-15`.
2. **Who belongs to it?** — an explicit, revocable membership edge, distinct
   from library membership (`BC-02`) and from A1's *derived* participant set.
3. **What may a member do inside it?** — a community role, distinct from the
   platform `AccessRole` (`BC-18`).

---

## 2. Scope

### 2.1 In scope

| # | Item | Charter basis |
|---|---|---|
| 1 | The **`CommunityGroup`** aggregate — identity, name, lifecycle, community scope | BC Map **L119** *"study groups"*, *"communities"* |
| 2 | The **`GroupMembership`** aggregate — the join/leave edge between a participant and a group | BC Map **L119** *"membership of groups"* |
| 3 | The **`CommunityRole`** value — the in-group capability label | BC Map **L119** *"community roles"*; BC Map **L212** names `CommunityRole` as distinct from `AccessRole` |
| 4 | The **`CommunityMember`** identity term inside `BC-15` | BC Map **L200** distinguishes `CommunityMember` (`BC-15`) from `MembershipHolder` (`BC-02`) |
| 5 | Group lifecycle states and transitions | Consequence of item 1 |
| 6 | Group-scoped visibility of the aggregates A2 owns — **read-side predicate only** | A2 owns `CommunityPost`; this part contributes a scope predicate, never post state |

### 2.2 Explicitly NOT in scope — with the owner who holds it

`LCG-XC-001` | `CommunityPost`, its body, attachments, comments, reactions,
lifecycle | **A2** — `LCF-FR-016`, A2 **L510**

`LCG-XC-002` | Feed retrieval, pagination, feed composition | **A2** §13, §14

`LCG-XC-003` | Feed ordering, ranking, signals, weights | **A3** — A2
`LCF-XC-021`, A3 `LCR-FR-013`

`LCG-XC-004` | Library membership validity, plans, renewals, grace windows |
**`BC-02`** — BC Map **L371**; `ADR-0036`

`LCG-XC-005` | The *derived* community participant set and the *derived* access
predicate | **A1** — A1 §1, §2.1. ⭐ A4 owns a **stored** group membership;
A1 owns a **derived** participation predicate. These are different objects (§4.3)

`LCG-XC-006` | Enforcement, moderation, anti-spam, bans | **`BC-13`** — BC Map
**L379**, **L318** (`E-14`), **L433**

`LCG-XC-007` | Identity, profile, display name, privacy mode | **`BC-10`** — BC
Map **L376** |

`LCG-XC-008` | Social relationships, follow/friend graphs | **`BC-11`** — BC Map
**L377**. ⛔ No edge exists (A3 `LCR-GAP-004`)

`LCG-XC-009` | Direct messaging, group chat transport | **`BC-12`** — BC Map
**L116**. `PRD-021` is `PLANNED` (`PRD_REGISTRY.md` **L321**)

`LCG-XC-010` | Notification dispatch of any kind | **`BC-22`** — BC Map **L131**,
reached only by `E-23`

`LCG-XC-011` | Configuration values, bounds, feature flags | **`BC-25`** — BC Map
**L134**, `E-19`; `PRD-023`. This part **declares** shapes; `BC-25` resolves values

`LCG-XC-012` | Platform permissions, `AccessRole`, permission bundles |
**`BC-18`** — BC Map **L212**. ⛔ Catalogue **closed**: `AUTH-7.22`; `ADR-0036`
§7.1 records **zero** `PERM-*`; re-measured at authoring time → **1** `PERM-`
hit repo-wide, and it is the disclosure *recording the absence*

`LCG-XC-013` | File and media storage for group avatars or attachments |
**`BC-14`** → **`BC-29`** — A2 `LCF-XC-020`; `PRD-017` (FROZEN)

`LCG-XC-014` | Analytics, metrics, reporting, exports | **`BC-26`** — BC Map
**L135**. Community Analytics is **V3** — EA **L973**

`LCG-XC-015` | `StudySession` scheduling | ⏸ **NOT CLAIMED.** BC Map **L207**
names `StudySession` under `BC-15`, but no A-part excludes it and no charter
clause requires it here. → `LCG-GAP-004`, **OPEN**

`LCG-XC-016` | Any scope belonging to A5, A6, A7 or A8 | ⛔ Those parts do not
exist. This part takes **no** custody on their behalf (`LCG-INV-003`)

### 2.3 Non-goals

- **Not** a placeholder. If `LCG-DEC-001` allocates this residue elsewhere, this
  document is withdrawn, not repurposed.
- **Not** a second membership system. `BC-02` membership and A4 group membership
  are orthogonal (§4.3).
- **Not** a permission system. Community roles are `BC-15`-internal labels and
  confer **no** platform permission (`LCG-INV-006`).
- **Not** a V1 capability. Inherited V2 — BC Map **L119**, **L147**.

---

## 3. Actors and roles

| Actor | Definition | Source of truth |
|---|---|---|
| **Participant** | A person A1's derived predicate admits to the community | **A1** — consumed, never re-derived |
| **`CommunityMember`** | A participant holding an in-force `GroupMembership` in a specific group | **A4** — this part |
| **Group `CommunityRole`** | `OWNER`, `MODERATOR`, `MEMBER` — ✅ **DECIDED and CLOSED, 2026-08-31** (Product Owner ruling **PO-4**; `LCG-DEC-003` closed). The set is **CLOSED**: ranking is **`OWNER` > `MODERATOR` > `MEMBER`**, and ⛔ **no other role SHALL be added** — the ruling states *"Do not add any other role."* ⭐ **The candidate set was ratified unchanged, not replaced**, which is why no identifier moves and no permission is re-derived. | ✅ **CLOSED.** BC Map **L212** still names *"Admin/Moderator"* **illustratively, not normatively**, and that remains true — ⛔ **`Admin` is NOT a role in this set** and was not admitted by the ruling; the BC Map line is prose, not an enum, and is **byte-unchanged**. *(Prior text retained verbatim: ⏸ **candidate set, NOT decided** (§32 `LCG-DEC-003`) / ⛔ OPEN)* |
| **Platform `AccessRole`** | Owner / Manager / Reception | **`BC-18`** — BC Map **L212**. Untouched |
| **Enforcement authority** | Issuer of `safety.EnforcementActionTaken` | **`BC-13`** — consumed as a **hard filter** |
| **Product Owner** | Holds `LCG-DEC-001`, `003`, `005`, `006` | `PRD_LIFECYCLE.md` §6 |
| **Architecture Owner** | Holds `LCG-ADR-001`…`004` | `PRD_LIFECYCLE.md` **L277** |
| **Governance Owner** | Holds `LCG-GAP-002` (prefix registration) | `ADR-0080`. ⛔ **VACANT** — `ADR-0080` **L85** |

`LCG-INV-004` | `CommunityRole` and `AccessRole` are **disjoint namespaces**. No
value of one is a value of the other, and neither is derivable from the other.
Authority: BC Map **L212**.

---

## 4. Data and domain considerations

### 4.1 `CommunityGroup`

| Field | Type | Constraint |
|---|---|---|
| `groupId` | Identifier | Mandatory, immutable, `BC-15`-minted |
| `communityId` | Identifier | Mandatory, immutable. Scoping key — see §4.4 |
| `name` | Text | Mandatory. ⏸ Bounds deferred to `BC-25` — `LCG-GAP-005` |
| `description` | Text | Optional. ⏸ Bounds deferred — `LCG-GAP-005` |
| `visibility` | Enum | ✅ **ENUMERATED and CLOSED, 2026-08-31**: **`PUBLIC`**, **`PRIVATE`** (Product Owner ruling **PO-5**). `PUBLIC` is discoverable under the existing discovery rules; `PRIVATE` requires membership or otherwise authorised access. ⛔ **No additional visibility state SHALL be invented** — the ruling states *"Do not invent additional visibility states"*, so there is no `UNLISTED`, `HIDDEN`, `SECRET` or `INVITE_ONLY`. ⚠ **`LCG-DEC-005` is only HALF closed by this**: its second clause — *whether group names are unique per community* — was **not** ruled on and is now tracked as **`LCG-DEC-005b`**, still **OPEN**, Product Owner. *(Prior text retained verbatim: ⏸ **NOT ENUMERATED.** `LCG-DEC-005`, OPEN)* |
| `lifecycleState` | Enum | `ACTIVE`, `ARCHIVED` — §5.2 |
| `createdAt` | Timestamp | Mandatory, immutable |
| `tenantId` | — | ⛔ **ABSENT.** `ACCEPTED` `ADR-0078` §2.1 determines `BC-15` carries **no** `tenantId`. This part does not reopen it |

### 4.2 `GroupMembership`

| Field | Type | Constraint |
|---|---|---|
| `groupMembershipId` | Identifier | Mandatory, immutable |
| `groupId` | Identifier | Mandatory, immutable |
| `personId` | Identifier | Mandatory, immutable. `BC-10`'s identifier, consumed opaquely |
| `communityRole` | `CommunityRole` | Mandatory. ⏸ Value set OPEN — `LCG-DEC-003` |
| `state` | Enum | `ACTIVE`, `REVOKED` |
| `joinedAt` / `revokedAt` | Timestamp | `revokedAt` null iff `state = ACTIVE` |

`LCG-INV-005` | A `GroupMembership` is **stored state**. It is never derived, and
it never substitutes for A1's derived participation predicate.

### 4.3 ⭐ The three membership objects — kept distinct

This is the highest-risk confusion in the subject area. BC Map **L200** already
warns of it.

| Object | Owner | Nature | Question it answers |
|---|---|---|---|
| `MembershipHolder` | **`BC-02`** | Stored, paid | *Does this person hold an in-force library membership?* |
| A1 participant predicate | **A1** | **Derived**, not stored | *May this person participate in this community at all?* |
| `GroupMembership` | **A4** | **Stored**, revocable | *Does this person belong to this specific group?* |

`LCG-BR-001` | Group membership is **subordinate**, never substitutive: a
`GroupMembership` in state `ACTIVE` grants nothing if A1's predicate denies
participation. Evaluation order is fixed by `LCG-FR-012`.

`LCG-INV-006` | A `CommunityRole` confers **no** platform permission, **no**
`AccessRole`, and **no** capability outside `BC-15`. Authority: `AUTH-7.22`
closes the permission catalogue; **0** `PERM-*` exist.

### 4.4 ⏸ BLOCKED — the community scoping key

`LCG-FR-001` | Every `CommunityGroup` SHALL be scoped to exactly one community,
and the scope SHALL be immutable after creation.

⏸ **BLOCKED.** A2 §20.2 models community scope as `communityId`, and `ACCEPTED`
`ADR-0078` §2.1 confirms `BC-15` carries no `tenantId`. But **no published
contract defines how a `communityId` is minted or resolved** — A1 owns a
*derived* predicate and no aggregate (`AR-1`), and A2 mints posts, not
communities. → `LCG-GAP-006`, **OPEN**. Decision owner: **Architecture Owner**.

`LCG-INV-007` | Until `LCG-GAP-006` is closed, group creation SHALL be treated as
**blocked**, in the same shape A2 `LCF-FR-043` uses for `LCF-ADR-002`. This
clause invents no rule; it states the consequence of the scoping key's absence.

---

## 5. Functional requirements

### 5.1 Group creation

`LCG-FR-002` | A group SHALL be created only by a caller whom A1's predicate
admits to the target community.

`LCG-FR-003` | The creator SHALL receive a `GroupMembership` in the highest
available `CommunityRole` at creation time. ⏸ Which value that is depends on
`LCG-DEC-003`.

`LCG-FR-004` | Group creation SHALL be **rejected** if A1's predicate denies the
caller, if the community scope cannot be resolved (`LCG-GAP-006`), or if
`BC-13` has issued an in-force enforcement action against the caller.

`LCG-FR-005` | ⏸ **BLOCKED.** A per-community cap on group count SHALL be
enforced. The **value** is a `BC-25` concern (`PRD-023`); this part declares the
shape and assigns no number. → `LCG-GAP-005`.

### 5.2 Group lifecycle

`LCG-FR-006` | A group SHALL be in exactly one of `ACTIVE`, `ARCHIVED`.

`LCG-FR-007` | `ACTIVE → ARCHIVED` SHALL be permitted to a caller holding the
owning `CommunityRole`.

`LCG-FR-008` | `ARCHIVED → ACTIVE` SHALL be permitted. ⏸ Whether restoration
requires a higher authority is **OPEN** — `LCG-DEC-006`.

`LCG-FR-009` | A group SHALL NOT be hard-deleted. Archival is the terminal state
this part specifies. **Rationale:** `GroupMembership` records and A2-owned posts
reference `groupId`; destroying it would orphan another owner's aggregate.

`LCG-FR-010` | While `ARCHIVED`, a group SHALL accept **no** new
`GroupMembership` and **no** role change. Read access to existing membership
SHALL be preserved.

### 5.3 Join and leave

`LCG-FR-011` | Joining SHALL create exactly one `GroupMembership` in state
`ACTIVE`. A person SHALL NOT hold two `ACTIVE` memberships in one group.

`LCG-FR-012` | ⭐ **Fixed evaluation order** for any join attempt:

1. A1 participation predicate — deny ⇒ reject
2. `BC-13` enforcement hard filter — in force ⇒ reject
3. Group `lifecycleState` — `ARCHIVED` ⇒ reject
4. Existing `ACTIVE` membership ⇒ reject as duplicate
5. Capacity bound (`LCG-FR-005`) ⇒ reject if exceeded
6. Otherwise ⇒ create

`LCG-INV-008` | No `CommunityRole`, group setting, or configuration value can
cause steps 1 or 2 to be skipped. This is not a tunable property. Modelled on A3
`LCR-INV-004`.

`LCG-FR-013` | Leaving SHALL set `state = REVOKED` and stamp `revokedAt`. The
record SHALL be retained, not deleted (audit — §11).

`LCG-FR-014` | A revoked membership SHALL NOT be reactivated. Re-joining creates
a **new** `GroupMembership`.

`LCG-FR-015` | The last holder of the owning role SHALL NOT leave an `ACTIVE`
group. ⏸ Whether the group auto-archives or transfer is mandatory is **OPEN** —
`LCG-DEC-006`.

### 5.4 Community roles

`LCG-FR-016` | Every `ACTIVE` `GroupMembership` SHALL carry exactly one
`CommunityRole`.

`LCG-FR-017` | ⏸ **BLOCKED — the role set is not enumerated here.** BC Map
**L212** mentions *"Admin/Moderator"* illustratively. Enumerating a normative set
is a **Product Owner** act — `LCG-DEC-003`, **OPEN**. This part specifies the
*mechanism*, assigns no values, and mints no identifiers for them.

`LCG-FR-018` | A role change SHALL be performed only by a caller holding a role
that the (undecided) role model ranks above the target. ⏸ Blocked on
`LCG-DEC-003`.

`LCG-FR-019` | A role SHALL NOT be mapped to, derived from, or exchanged for any
`AccessRole` or `PERM-*` (`LCG-INV-004`, `LCG-INV-006`).

### 5.5 Group-scoped visibility contribution

`LCG-FR-020` | This part SHALL publish a **read-side predicate**
`isGroupMember(personId, groupId) → boolean` for consumption by A2.

`LCG-FR-021` | The predicate SHALL be **content-free**: it returns a boolean and
SHALL NOT return, embed, or imply post content, member lists, or counts.
Modelled on A2 `LCF-INV-013`.

`LCG-FR-022` | This part SHALL NOT filter, order, or compose any feed. A2 decides
what to show; A3 decides in what order (`LCG-XC-002`, `LCG-XC-003`).

`LCG-FR-023` | ⏸ Whether A2 posts can be group-scoped **at all** is **A2's**
question, not this part's. A2 v0.8 does not model a `groupId` on
`CommunityPost`. This part publishes the predicate; it does not oblige A2 to
consume it. → `LCG-GAP-007`, **OPEN**, owner **A2 author**.

---

## 6. Workflows

### 6.1 Create a group
```
Caller → [A1 predicate] → deny? ⇒ REJECT (LCG-FR-004)
       → [BC-13 hard filter] → in force? ⇒ REJECT
       → [resolve communityId] → ⏸ BLOCKED (LCG-GAP-006) ⇒ REJECT
       → create CommunityGroup(ACTIVE)
       → create GroupMembership(creator, highest role) ⏸ (LCG-DEC-003)
       → emit GroupCreated ✅ UNBLOCKED (LCG-ADR-002 CLOSED, ADR-0084)
```

### 6.2 Join a group
```
Caller → six-step gate (LCG-FR-012, order fixed by LCG-INV-008)
       → create GroupMembership(ACTIVE, default role) ⏸ (LCG-DEC-003)
       → emit GroupMembershipGranted ✅ UNBLOCKED (ADR-0084)
       ⛔ NO notification is dispatched here — BC-22 owns that (LCG-XC-010)
```

### 6.3 Leave / revoke
```
Caller → last-owner check (LCG-FR-015) ⏸ OPEN (LCG-DEC-006)
       → set state=REVOKED, stamp revokedAt (record retained, LCG-FR-013)
       → emit GroupMembershipRevoked ✅ UNBLOCKED (ADR-0084)
```

### 6.4 Enforcement arrives from `BC-13`
```
BC-13 → safety.EnforcementActionTaken (E-14, BC Map L318/L433)
      → BC-15 SELF-RESTRICTS. T&S never writes into BC-15 (BC Map L318)
      → affected memberships become non-effective for the action's duration
      ⭐ State is NOT mutated: enforcement is a HARD FILTER at evaluation,
        never a stored role change (modelled on A3 LCR-BR-004)
```

---

## 7. Permissions

`LCG-FR-024` | This part mints **zero** permission identifiers.

**Authority:** `AUTH-7.22` closes the permission catalogue; `ADR-0036` §7.1
records **zero** `PERM-*`; re-measured at authoring time → **1** `PERM-` hit
repo-wide, which is the disclosure recording the absence. Extending a closed
register requires an ADR **by its owner** (`PRD_LIFECYCLE.md` §5 rule 6) — and
`ADR-0081` §116 records that item as ⛔ **OPEN**, needing Governance **+ Auth**
authority.

`LCG-FR-025` | In-group capability SHALL be expressed **only** as
`CommunityRole`, a `BC-15`-internal value with no platform meaning.

⏸ `LCG-GAP-008` | If implementation requires a platform permission to gate group
creation, this part is **blocked** and the requirement escalates to the Auth PRD
owner. **OPEN.**

---

## 8. Edge cases

`LCG-EC-001` | Person's library membership lapses while holding group membership
→ A1's predicate denies at step 1; the `GroupMembership` row is **untouched**.
Membership state is `BC-02`'s, not this part's.

`LCG-EC-002` | Enforcement action expires → the hard filter stops matching. No
state change, no restoration event.

`LCG-EC-003` | Last owner is enforcement-banned → group has no effective owner.
✅ **CLOSED — 2026-08-31** (Product Owner ruling **PO-6**). **A community SHALL NOT become ownerless.** The departure or ban of the **last `OWNER`** **SHALL be BLOCKED** until another eligible member has been **explicitly promoted** to `OWNER`. ⛔ **This part still does NOT auto-promote, and the ruling forbids it in terms** — *"Do NOT silently auto-promote a member"* — so the previous refusal to auto-promote is **ratified, not reversed**. ⭐ **The open question was never whether to auto-promote; it was what to do INSTEAD**, and the answer is to fail the departure closed. ⚠ **Whether RESTORATION of an ownerless community requires higher authority was NOT ruled on** and stays open under `LCG-DEC-006`'s second clause — it cannot arise while the first clause is enforced, but it is not thereby answered. *(Prior text retained verbatim: ⏸ **OPEN** — `LCG-DEC-006`. This part does **not** auto-promote; promotion would)*
be an authority act.

`LCG-EC-004` | Group archived while a join is in flight → step 3 rejects.

`LCG-EC-005` | Concurrent duplicate joins → step 4 must be evaluated under a
uniqueness constraint on (`groupId`, `personId`, `state=ACTIVE`).

`LCG-EC-006` | Person identity is deleted/anonymised in `BC-10` → ⏸ **OPEN**.
`BC-10` owns erasure; no contract published. → `LCG-GAP-009`.

`LCG-EC-007` | Community itself is dissolved → ⏸ undefined, because no
community aggregate is specified (`LCG-GAP-006`).

`LCG-EC-008` | Group name collides within a community → ⏸ whether names are
unique is **OPEN**, `LCG-DEC-005`.

`LCG-EC-009` | Role changed concurrently by two owners → last-writer-wins is
**not** asserted; ordering guarantees are `LCG-GAP-010`.

`LCG-EC-010` | A2 queries the predicate for a non-existent `groupId` → returns
`false`, never an error that leaks existence (§10).

---

## 9. Failure states

`LCG-FS-001` | A1 predicate unavailable → **fail closed.** Deny participation.
Modelled on A3 `LCR-BR-007` (an unavailable signal contributes zero and is
declared, never estimated).

`LCG-FS-002` | `BC-13` enforcement feed unavailable → **fail closed.** Deny.
Enforcement is a hard filter and SHALL NOT be assumed absent.

`LCG-FS-003` | `BC-25` configuration unavailable → group creation SHALL be
refused rather than defaulted. This part publishes no fallback number.

`LCG-FS-004` | Community scope unresolvable → creation blocked
(`LCG-INV-007`).

`LCG-FS-005` | Partial write between `CommunityGroup` and creator's
`GroupMembership` → the pair SHALL be atomic. A group with no owner SHALL NOT
be observable.

`LCG-FS-006` | Event emission fails → the write SHALL NOT be rolled back;
emission is at-least-once and consumers are idempotent. ✅ **NO LONGER BLOCKED**
— `ACCEPTED` [`ADR-0084`](../../00-governance/adr/ADR-0084-bc15-outbound-carriers-measured-option-b-selected.md) closes `LCG-ADR-002`. ⭐ This clause was already **exactly** BC Map §9.1's event-delivery contract — *"Transactional Outbox"*, *"At-least-once. Therefore every consumer must be idempotent — keyed on `eventId`"* — which is why it needed no amendment, only an authority.

---

## 10. Privacy and security considerations

`LCG-SEC-001` | The predicate `isGroupMember` SHALL be content-free
(`LCG-FR-021`).

`LCG-SEC-002` | Member enumeration SHALL NOT be possible via group surfaces.
Modelled on A2 `LCF-SEC-011` / `LCF-FR-084`; A1 records `LCFG-5` defaults the
member directory to **Disabled**.

`LCG-SEC-003` | Group existence SHALL NOT be disclosed to a caller A1's
predicate denies. Absence and denial SHALL be indistinguishable.

`LCG-SEC-004` | Group data SHALL NOT appear on any public library surface.
Authority: `14A` §14A.5, `14B` **L173**, A2 `LCF-SEC-004` / `005`.

`LCG-SEC-005` | Community isolation is absolute: no cross-community group,
membership, or predicate result. Modelled on A3 `LCR-BR-002`, `LCR-INV-002`.

`LCG-SEC-006` | This part stores **no** profile data. `personId` is consumed
opaquely; display resolution is `BC-10`'s (`LCG-XC-007`).

`LCG-SEC-007` | ⏸ **Minor-inclusive population.** The subject population
includes minors (`SM-INV-3`; `BC-10` **L376** *"privacy default = most
restrictive"*). Any group surface that widens visibility beyond members is
**OPEN** and requires a privacy decision — `LCG-GAP-011`.

`LCG-SEC-008` | This part introduces **no** new personal-data category. Group
membership is an association between two existing identifiers.

`LCG-SEC-009` | Retention of `REVOKED` memberships (`LCG-FR-013`) is for audit.
⏸ The retention **period** is **OPEN** — `LCG-GAP-012`, owner `BC-25` + privacy
authority.

---

## 11. Observability and audit

`LCG-OBS-001` | Group creation, archival, restoration, join, revoke, and role
change SHALL each be auditable.

`LCG-OBS-002` | ⏸ **BLOCKED.** Audit records are `BC-24`'s / `PRD-016`'s
(FROZEN). This part emits facts and SHALL NOT create an audit store.
→ `LCG-GAP-013`, requires a published contract.

`LCG-OBS-003` | Emitted facts SHALL be **content-free** beyond identifiers,
timestamps, and the transition name.

`LCG-OBS-004` | This part SHALL NOT interpret its own facts. Metrics and
reporting are `BC-26`'s (`LCG-XC-014`); Community Analytics is **V3** (EA
**L973**).

`LCG-OBS-005` | Rejection reasons SHALL be recorded internally but SHALL NOT be
returned to a denied caller at a granularity that discloses group existence
(`LCG-SEC-003`).

---

## 12. Dependencies

| # | Depends on | Nature | Status |
|---|---|---|---|
| `LCG-DEP-001` | **A1 v0.2** participation predicate | Consumed at step 1 | ✅ Published. ⚠ A1 itself has `LCM-GAP-001` open |
| `LCG-DEP-002` | **A2 v0.8** `CommunityPost` ownership | Boundary respected | ✅ Published |
| `LCG-DEP-003` | **A3 v0.6** ranking ownership | Boundary respected | ✅ Published |
| `LCG-DEP-004` | **`BC-13`** `safety.EnforcementActionTaken` via `E-14` | Hard filter | ✅ Edge exists — BC Map **L318**, **L433** |
| `LCG-DEP-005` | **`BC-10`** `personId` | Opaque identifier | ⚠ Consumed opaquely; no edge asserted |
| `LCG-DEP-006` | **`BC-02`** membership validity | ⛔ **Reached only via A1**, never directly | ⛔ **No `BC-02 → BC-15` edge exists.** `E-02` targets `BC-04` only (BC Map **L299**) |
| `LCG-DEP-007` | **`BC-25`** configuration values | Declared, resolved elsewhere | ⏸ `E-19` exists; values OPEN |
| `LCG-DEP-008` | **`BC-24`** audit sink | Fact emission | ⏸ `LCG-GAP-013` |
| `LCG-DEP-009` | **`BC-22`** notifications | ⛔ Not consumed | Out of scope (`LCG-XC-010`) |
| `LCG-DEP-010` | **`BC-11`** social graph | ⛔ Not consumed | ⛔ No edge — A3 `LCR-GAP-004` |

⭐ `LCG-DEP-006` **is the load-bearing constraint.** BC Map **L292**: *"If an
edge is not in this table, it does not exist and adding it requires an ADR."*
`BC-15` has **exactly one** inbound edge in BC Map §7 — `E-14` from `BC-13`.
Therefore group membership **cannot** validate library membership directly; it
must route through A1, which is why `LCG-BR-001` and `LCG-FR-012` are written as
they are. **This part creates no edge.**

---

## 13. Non-functional requirements

`LCG-NFR-001` | Every evaluation SHALL be deterministic and reproducible for a
fixed input state. Modelled on A3 `LCR-BR-006`.

`LCG-NFR-002` | ⏸ **DEFERRED.** Binding latency and throughput budgets are a
Product Owner + Architecture Owner concern, consistent with A2 `LCF-GAP-010` and
A3 `LCR-GAP-010`. → `LCG-GAP-010`.

`LCG-NFR-003` | The predicate SHALL be safe to call per-post without implying a
caching contract. Caching is an implementation concern, not specified here.

`LCG-NFR-004` | ⏸ **DEFERRED.** Group-count and membership-count scale bounds
are `BC-25` values — `LCG-GAP-005`.

---

## 30. Acceptance criteria

✅ **Registered prefix status:** ⏸ `LCG-` is **PROPOSED, not registered**
(`LCG-GAP-002`). ⛔ The criteria below are **UNRATIFIED** and **none** is
claimed to pass. No criterion is recorded as verified.

| ID | Criterion | Writability |
|---|---|---|
`LCG-AC-001` | Given a caller A1's predicate denies, when a join is attempted, then it is rejected at step 1 | Verifiable |
`LCG-AC-002` | Given an in-force `BC-13` action, when a join is attempted, then it is rejected at step 2 | Verifiable |
`LCG-AC-003` | Given an `ARCHIVED` group, when a join is attempted, then it is rejected at step 3 | Verifiable |
`LCG-AC-004` | Given an existing `ACTIVE` membership, when a join is attempted, then it is rejected as duplicate | Verifiable |
`LCG-AC-005` | Given a leave, when it completes, then `state=REVOKED` and the record still exists | Verifiable |
`LCG-AC-006` | Given a revoked membership, when re-join occurs, then a **new** record is created | Verifiable |
`LCG-AC-007` | Given any `CommunityRole`, when platform permission is checked, then no `PERM-*` is granted | Verifiable |
`LCG-AC-008` | Given a denied caller, when a group is queried, then absence and denial are indistinguishable | Verifiable |
`LCG-AC-009` | Given the A1 predicate is unavailable, when a join is attempted, then it fails **closed** | Verifiable |
`LCG-AC-010` | Given the `BC-13` feed is unavailable, when a join is attempted, then it fails **closed** | Verifiable |
`LCG-AC-011` | Given group creation, when it completes, then group + owner membership are atomic | Verifiable |
`LCG-AC-012` | Given `isGroupMember`, when called, then the response contains no post content, member list or count | Verifiable |
`LCG-AC-013` | Given any group operation, when it completes, then no cross-community result is observable | Verifiable |
⏸ `LCG-AC-014` | Given a group creation, when the community scope is resolved, then … | ⛔ **UNWRITABLE** — `LCG-GAP-006` |
✅ `LCG-AC-015` | Given a role change by an owner, when it completes, then the target member holds exactly one of `OWNER`, `MODERATOR`, `MEMBER` and the change is rejected if the value is outside that closed set | ✅ **NOW WRITABLE — 2026-08-31.** The role set is closed by **PO-4** (`OWNER` > `MODERATOR` > `MEMBER`); `LCG-DEC-003` is CLOSED. ⚠ **NOT recorded as passing** — the test still has to be written and run |
✅ `LCG-AC-016` | Given the last owner attempts to leave or is banned, when the operation is evaluated, then it is **BLOCKED** and the community retains at least one `OWNER`; no member is promoted implicitly | ✅ **NOW WRITABLE — 2026-08-31.** Last-owner policy closed by **PO-6**: block, never auto-promote; `LCG-DEC-006`'s first clause is CLOSED. ⚠ **NOT recorded as passing** — the test still has to be written and run. ⚠ The restoration half of `LCG-DEC-006` stays OPEN and no criterion is claimed for it |
⏸ `LCG-AC-017` | Given the group cap is reached, when creation is attempted, then it is rejected | ⏸ **DEFERRED** — no value, `LCG-GAP-005` |
⏸ `LCG-AC-018` | Cross-community isolation asserted per query in integration | ⏸ **DEFERRED** — `integration_test/` does **not** exist (measured at authoring time: `ls -d integration_test` → *No such file or directory*). Same condition as A2 `LCF-AC-035` / `LCF-GAP-011` |

**18 criteria — 13 verifiable · 3 unwritable · 2 deferred.** ⛔ **0 passing.**

---

## 31. Gap register

| ID | Gap | Owner | State |
|---|---|---|---|
`LCG-GAP-001` | ⭐ **No document allocates scope to Part A4.** This part's entire scope is a candidate | **Product Owner** | ⛔ **OPEN — blocks everything** |
`LCG-GAP-002` | `LCG-` prefix not registered (`ADR-0080` §5 registers only `LCF-`, `LCR-`) | **Governance Owner** — ⛔ **VACANT**, `ADR-0080` **L85** | ⛔ OPEN |
`LCG-GAP-003` | Classification of this part (capability vs. context specification) not assigned | **Architecture Owner** | ⛔ OPEN |
`LCG-GAP-004` | `StudySession` (BC Map **L207**) claimed by no part | **Product Owner** | ⛔ OPEN |
`LCG-GAP-005` | Name bounds, description bounds, group/membership caps | `BC-25` / `PRD-023` | ⛔ OPEN |
`LCG-GAP-006` | ⭐ No published contract mints or resolves `communityId` | **Architecture Owner** | ⛔ **OPEN — blocks group creation** |
`LCG-GAP-007` | Whether A2 posts can be group-scoped at all | **A2 author** | ⛔ OPEN |
`LCG-GAP-008` | Whether a platform permission is needed to gate group creation | Auth PRD owner + Governance | ⛔ OPEN |
`LCG-GAP-009` | `BC-10` erasure/anonymisation contract | `BC-10` owner | ⛔ OPEN |
`LCG-GAP-010` | Latency/throughput budgets; concurrent-write ordering guarantees | PO + AO | ⏸ DEFERRED |
`LCG-GAP-011` | Minor-inclusive privacy review for any wider group visibility | Privacy authority | ⛔ OPEN |
`LCG-GAP-012` | Retention period for `REVOKED` memberships | `BC-25` + privacy | ⛔ OPEN |
`LCG-GAP-013` | Audit sink contract (`BC-24` / `PRD-016` FROZEN) | `BC-24` owner | ⛔ OPEN |
`LCG-GAP-014` | `integration_test/` does not exist | Pre-existing repository condition (A2 `LCF-GAP-011`) | ⛔ OPEN |

---

## 32. Decision requirements

⛔ **This document takes none of these.**

| ID | Decision | Owner |
|---|---|---|
`LCG-DEC-001` | ⭐ Is this residue Part A4, or A5+, or a separate PRD? | **Product Owner** | ✅ **CLOSED — 2026-08-31 (PO-3): it is Part A4 — `Community Groups & Roles`.** ⛔ **A4 remains a PART of `PRD-021A` and is NOT a standalone PRD**, in the ruling's own words. ⭐ This also discharges `LCG-ADR-001`'s classification half |
`LCG-DEC-002` | Confirm the allocation duplicates no `BC-02` / `BC-13` / `BC-15`-post ownership (the `P0-5` trap, A3 **L413**) | **Architecture Owner** |
`LCG-DEC-003` | Enumerate the `CommunityRole` set and its ranking | **Product Owner** | ✅ **CLOSED — 2026-08-31 (PO-4).** Closed set `OWNER`, `MODERATOR`, `MEMBER`; ranking `OWNER` > `MODERATOR` > `MEMBER`; ⛔ no other role |
`LCG-DEC-004` | Whether group membership is self-service or invitation-gated | **Product Owner** |
`LCG-DEC-005` | Group `visibility` enum; whether names are unique per community | **Product Owner** | ⚠ **HALF CLOSED — 2026-08-31 (PO-5).** ✅ The enum is closed at **`PUBLIC`**, **`PRIVATE`**; ⛔ no further states. ⏸ **The name-uniqueness clause was NOT ruled on** — split out below as **`LCG-DEC-005b`** rather than silently treated as answered, because inferring it would breach the ruling's Execution Rule 5 (*"Do NOT invent additional decisions"*) |
`LCG-DEC-006` | Last-owner departure/ban policy; whether restoration needs higher authority | **Product Owner** | ⚠ **HALF CLOSED — 2026-08-31 (PO-6).** ✅ Departure/ban of the last `OWNER` is **BLOCKED** until another member is explicitly promoted; ⛔ **no silent auto-promotion**. ⏸ **The restoration-authority clause was NOT ruled on and stays OPEN** |
`LCG-DEC-005b` | ⏸ **NEW, 2026-08-31 — OPEN.** Whether group names must be **unique per community**. ⭐ **Split out of `LCG-DEC-005`, whose visibility half PO-5 answered and whose uniqueness half it did not.** Recorded as a separate item so that a half-answered decision is not booked as closed | **Product Owner** | ⏸ **OPEN.** Blocks no acceptance criterion currently written; `LCG-FR-*` naming rules stay parametric until ruled |

### ADR requirements

| ID | Requirement | Status |
|---|---|---|
`LCG-ADR-001` | An ADR classifying this part and assigning (or withholding) `BC-15` specification authority | ✅ **SATISFIED — 2026-08-31 by `ADR-0083`** (`Accepted`). Classification settled by **PO-3** (A4 is a part of `PRD-021A`); `BC-15` aggregate registration performed by **AO-8** in BC Map **§15.5** by append, leaving §8 byte-unchanged. *(Prior status retained verbatim: **Required, `Proposed`**)* |
`LCG-ADR-002` | An ADR registering any `BC-15`-sourced event (`GroupCreated`, `GroupMembershipGranted`/`Revoked`). ⛔ BC Map §7 sources **no** edge from `BC-15`; BC Map **L292** applies | ✅✅ **CLOSED — 2026-08-31 by `ACCEPTED` [`ADR-0084`](../../00-governance/adr/ADR-0084-bc15-outbound-carriers-measured-option-b-selected.md) — AND THE PREMISE OF THIS ROW WAS ITSELF MEASURED WRONG.** ⭐⭐⭐ **The requirement is discharged because no such ADR is needed, not because one was written.** Publishing a domain event is governed by BC Map **§9 "Published Language — Event Surface"**, whose §9.1 contract is Transactional Outbox + at-least-once + per-aggregate ordering. **§7 governs synchronous boundary crossings** — its own preamble at **L292** says *"Every edge that **crosses a context boundary**"*. ⭐⭐ **Proof that §9 is independent of §7, measured on the live document, three times over:** `BC-11` publishes to **`BC-26`** (**L430**) with no §7 edge to it (`BC-11`'s only outbound edge is `E-16` → `BC-12`); `BC-03` publishes to **`BC-13`** (**L417**) with no §7 edge to it; `BC-12` publishes to **`BC-13`** (**L431**) with no §7 edge to it. If §7 governed event publication, all three frozen rows would be violations. They are not. ⭐ **And the earlier claim that `BC-15` sources ZERO edges was an INSTRUMENT ERROR** — the scan read the edge table's column 2 (the edge **id**) as the source cell; §7 puts the source in column 3. Re-measured: **five** edges have a wildcard source — `E-17` *"All write paths"*, and `E-18`/`E-19`/`E-20`/`E-23` *"All contexts"* — and *"All contexts"* includes `BC-15`. The audit carrier is **`E-20`** (BC Map **L329**) and the notification-fact carrier is **`E-23`** (**L332**), which is the identical reasoning A7 **L167** was **conferred Stage 3 on**. ⛔ **What is NOT authorised:** no `LCG-EVT-*` identifier is minted, **no BC Map §9 producer row is added** (these events have no named domain consumer, so a Rank 4 amendment would be gratuitous — the same restraint `PRD-017` **R-6** exercised), and **§7 is byte-unchanged**. ⚠ **Only this marker clears.** `LCG-DEC-003`, `LCG-DEC-006` and `LCG-GAP-006` are untouched and the flows in §6 still carry their ⏸ markers
`LCG-ADR-003` | An ADR minting or resolving the `communityId` scoping key (`LCG-GAP-006`) | **Required, `Proposed`** |
`LCG-ADR-004` | An ADR **is not required** for consuming `E-14` — the edge already exists (BC Map **L318**, **L433**) and `BC-15` is already a declared consumer | **Not required** |

`LCG-FR-026` | ADR numbers SHALL be allocated by the Governance Owner. This
document mints **none**. (Next free number measured as `0083`; not reserved
here.)

`LCG-FR-027` | Each required ADR SHALL be raised `Proposed` and SHALL NOT be
self-accepted.

---

## 33. Risks

| ID | Risk | Severity | Mitigation / owner |
|---|---|---|---|
`LCG-RSK-001` | `LCG-DEC-001` allocates this residue elsewhere, voiding this part | **High** | `LCG-INV-001` makes withdrawal, not amendment, the response |
`LCG-RSK-002` | This part is mistaken for a placeholder for A5–A8 | Medium | `LCG-INV-003`, `LCG-XC-016` |
`LCG-RSK-003` | `communityId` is never specified, permanently blocking creation | **High** | `LCG-INV-007` blocks rather than defaults |
`LCG-RSK-004` | `CommunityRole` is conflated with `AccessRole` in implementation | **High** | `LCG-INV-004`, `LCG-INV-006`, `LCG-AC-007`; BC Map **L212** |
`LCG-RSK-005` | Group membership is treated as a substitute for library membership | **High** | `LCG-BR-001`, §4.3, `LCG-DEP-006` |
`LCG-RSK-006` | A new `BC-02 → BC-15` edge is added as a shortcut past A1 | Medium | `LCG-DEP-006` records the affirmative reason not to; BC Map **L292** |
`LCG-RSK-007` | `LCG-` prefix collides with a future registration | Medium | Collision-checked (0 occurrences); `LCG-GAP-002` routes registration |
`LCG-RSK-008` | Group surfaces enable member enumeration | Medium | `LCG-SEC-002`; `LCFG-5` defaults directory Disabled |
`LCG-RSK-009` | `integration_test/` never materialises, leaving `LCG-AC-018` deferred | Medium | `LCG-GAP-014`. Pre-existing condition |
`LCG-RSK-010` | A future revision treats this DRAFT as ratified because it is committed to `main` | Medium | §0 and the provenance block state DRAFT explicitly; no governance register references it |

---

## 34. Traceability

⛔ **This part appears in `TRACEABILITY_MATRIX.md` zero times, and this document
does not add it.** Measured: the matrix contains **0** `LCF-` and **0** `LCR-`
registrations — Stage 5 has not been entered for **any** `PRD-021A` part.
Registering `LCG-*` is a Stage 5 act by the traceability owner
(`PRD_LIFECYCLE.md` §6).

| Upstream authority | Cited as |
|---|---|
`MASTER_PRD.md` **L92** `MP-SCOPE-04` (Rank 1) | V2 band |
BC Map **L119** | `BC-15` charter — the four aggregates |
BC Map **L147** | V2 set includes `BC-15` |
BC Map **L200**, **L207**, **L212** | The three terminology disambiguations |
BC Map **L292** | Edge rule — ⚠ **and its SCOPE is now stated precisely**: L292 governs edges that *"cross a context boundary"* (synchronous coupling), **not** Published Language event publication, which BC Map **§9** and **§9.1** govern separately. `LCG-ADR-002` ✅ CLOSED on this distinction (`ADR-0084`); `LCG-DEP-006` unaffected |
BC Map **L299** (`E-02`) | Proof no `BC-02 → BC-15` edge exists |
BC Map **L318**, **L433** (`E-14`) | The one existing inbound edge |
BC Map **L371**, **L376**, **L377**, **L379** | `BC-02`, `BC-10`, `BC-11`, `BC-13` ownership |
EA **L973** | Community Analytics is V3 |
`ACCEPTED` `ADR-0078` §2.1 | `BC-15` carries no `tenantId` |
`ADR-0080` §5 **L195**/**L196**, **L85** | Registered prefixes; Governance Owner vacant |
`AUTH-7.22`, `ADR-0036` §7.1 | Permission catalogue closed; 0 `PERM-*` |
`PRD_LIFECYCLE.md` §5, §6, Stages 1–7 | Identifier and stage rules |
A1 v0.2 §1, §2.1 | Derived participation predicate |
A2 v0.8 `LCF-XC-007` (**L459**), `LCF-FR-016` (**L510**) | The exclusion this part answers |
A3 v0.6 §5 (**L413**, **L432**) | `P0-5` correction; deferred-custody clause |

---

## 35. Register state

| Register | Count | Range |
|---|---|---|
`LCG-FR-*` | 27 | `001`–`027` |
`LCG-INV-*` | 8 | `001`–`008` |
`LCG-BR-*` | 1 | `001` |
`LCG-XC-*` | 16 | `001`–`016` |
`LCG-SEC-*` | 9 | `001`–`009` |
`LCG-OBS-*` | 5 | `001`–`005` |
`LCG-EC-*` | 10 | `001`–`010` |
`LCG-FS-*` | 6 | `001`–`006` |
`LCG-DEP-*` | 10 | `001`–`010` |
`LCG-NFR-*` | 4 | `001`–`004` |
`LCG-AC-*` | 18 | `001`–`018` |
`LCG-GAP-*` | 14 | `001`–`014` |
`LCG-DEC-*` | 6 | `001`–`006` |
`LCG-ADR-*` | 4 | `001`–`004` |
`LCG-RSK-*` | 10 | `001`–`010` |

**Total: 148 identifiers across 15 registers.** All ranges contiguous
(`PRD_LIFECYCLE.md` §5 rule 4). ⏸ The `LCG-` **prefix** is **PROPOSED, not
registered** (`LCG-GAP-002`); the identifiers it labels are **UNRATIFIED**.

⛔ **Lifecycle status:** No stage advanced. Stage 3 **NOT CONFERRED**. **NOT
READY. NOT FROZEN.** `LCG-DEC-001` is open, so even this part's *existence as
A4* is unconfirmed.

---

| Field | Value |
|---|---|
| **Version** | v0.1 |
| **Determination** | **DRAFT — candidate scope, not allocated.** 14 gaps open, 6 decisions required, 3 ADRs required, 0 acceptance criteria passing |
