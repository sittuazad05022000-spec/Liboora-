<!--
  PROVENANCE — PRD-021A Part A1

  Purpose of this file
  --------------------
  CONTEXT-LOSS RECOVERY / CONTINUITY ARTEFACT.

  This file exists so that the exact state of PRD-021A Part A1 can be recovered
  from the repository after a context loss. It is NOT a freeze, NOT a baseline,
  and NOT a final document.

  Status        : DRAFT — v0.2 (corrected)
  Freeze status : NOT FROZEN. NOT FINAL. NOT APPROVED. NOT BASELINED.
  Lifecycle     : No stage advanced. The 7-stage finalisation and freeze happen
                  only after A1-A8 are all complete. A2 has NOT been started.
  Blocking item : Exactly one - LCM-GAP-001 / LCM-DEC-001 (the first day of the
                  three-day protected renewal window, reserved to the Product
                  Owner by name in ACCEPTED ADR-0036 section 8.2 question 2).

  Directory placement is NOT the placement decision
  -------------------------------------------------
  This file is filed under docs/30-product/social-graph/ because PRD-021 is
  registered as "Social Graph & Messaging" (PRD_REGISTRY.md L321) and that is
  the document under which the A1 work was commissioned.

  That is a FILING convention only. It is NOT:
    - an architecture placement,
    - a bounded-context assignment,
    - a cluster assignment,
    - a PRD_REGISTRY.md row.

  The specification's own recommended home is the LIBRARY cluster
  (section 0, and conflict C-2 in section 22). Final placement and the
  PRD_REGISTRY.md section 4.2 row remain OPEN as LCM-GAP-004 / LCM-DEC-005 and
  are owner / Governance Owner acts. Relocating this file later is a git mv.

  What this file does NOT do
  --------------------------
    - It creates no bounded context. The count remains 31 (23 in V1).
    - It creates no integration edge, event, permission, role or parameter.
    - It amends no FROZEN PRD (PRD-004, PRD-005, PRD-007).
    - It overrides no ACCEPTED ADR.
    - It amends no Rank 1-5 artefact.
    - It records no acceptance criterion as passing.
    - It does not answer ADR-0036 question 2.

  Sections 0-27  : As delivered. UNCHANGED.
  Sections 28-45 : Integrated in this commit.
-->

# PRD-021A — PART A1

## Library Community Foundation & Membership-Derived Participation

### Specification v0.2 (corrected) — supersedes draft v0.1 in full

> ⚠ **DRAFT — NOT FROZEN, NOT FINAL.** This document is committed for
> context-loss recovery and continuity only. Freeze and the 7-stage
> finalisation occur only after Parts A1–A8 are all complete.

---

## 0. Document control

| Field | Value |
|---|---|
| **Part** | A1 — Community Foundation & Membership (first part of the 021A decomposition) |
| **Version** | v0.2 — corrected against the eleven-conflict resolution audit |
| **Supersedes** | Draft v0.1 (27 sections, chat-delivered). **Superseded in full**, not amended. See §25 for the identifier mapping |
| **Status** | **DRAFT — not baselined, not approved, not frozen.** One blocker open (§20 `LCM-GAP-001`) |
| **Classification** | **Application / read-composition capability of the Library domain.** **NOT a bounded context** |
| **Bounded context** | **None assigned.** Context count remains **31 (23 in V1)** |
| **Authority for classification** | `ARCHITECTURE_RULINGS.md` §23 — ruling `AR-1` |
| **Precedents applied** | Library Discovery (BC Map L86) · **Library Member Directory** (`PRD-004` ch. 5, `LMD-1`…`LMD-31`; Registry L389) |
| **Recommended document home** | `docs/30-product/library/` as a sibling file, on the `14A`/`14B` pattern. ⚠ Final placement and the `PRD_REGISTRY.md` §4.2 row are **owner / Governance Owner acts** — see §20 `LCM-GAP-004` |
| **Registered scope of `PRD-021`** | **Unchanged.** `PRD_REGISTRY.md` L321 keeps `PRD-021` at `BC-11`, `BC-12` |
| **`BC-15` status** | **Unchanged — V2.** BC Map L119, L146-147; `MASTER_PRD` §5.2 `MP-SCOPE-04`; Registry L391 |
| **Frozen documents amended** | **Zero** |
| **ACCEPTED ADRs overridden** | **Zero** |
| **New contexts / edges / events / roles / permissions** | **Zero of each** |
| **Identifier namespace** | `LCM-*` — verified collision-free repository-wide |

### 0.1 Normative language

| Word | Meaning |
|---|---|
| **MUST** / **MUST NOT** | Absolute requirement or prohibition. A violation is a defect |
| **SHOULD** | Strong recommendation; departure must be recorded |
| **MAY** | Genuinely optional |
| **derived** | Computed at read time from a published read model. Never stored, never authoritative |

### 0.2 What this document is not

This document does not define architecture (that is the BC Map, Rank 4), does not decide configuration values (that is `PRD-023`/`BC-25`), does not confer authority, and does not implement anything. Where an authority already decides a question, this document **cites** rather than restates.

---

## 1. Purpose

To give the members of a single library a private, members-only participation surface, without creating any new domain state, and without pulling the V2 Community context into V1.

The capability answers exactly two questions:

1. **Who participates?** — the persons holding an in-force membership at this `TenantOrganisation`, less those excluded by an existing safety or tenancy signal.
2. **May this caller participate?** — a predicate derived at evaluation time from that answer and the caller's existing `AccessRole`.

Everything else that the word "community" ordinarily implies — posts, feeds, groups, community roles, moderation, analytics, public communities — is **out of scope by existing authority**, not by preference (§21).

---

## 2. Scope

### 2.1 In scope

| Item |
|---|
| A **derived participant set** for one `TenantOrganisation` |
| A **derived access predicate** for a caller at that `TenantOrganisation` |
| Consumption of the **published `MembershipValidity` read model** to establish membership force |
| Consumption of **two already-published signals** for exclusion and suppression |
| **Structural tenant isolation** |
| **Deny-by-default gating** by an existing library-level configuration parameter |
| Fixed **`PRIVATE`** visibility |
| The **minor-consent gate** |
| A **read-only** API surface |

### 2.2 The defining property of V1

**A1 performs no mutation of any kind.** There is no join, no leave, no invite, no post, no role assignment, no state transition. Participation is a **computed consequence** of membership, not an act.

This is not a simplification for convenience. It is the reason `AR-1` applies: a capability that writes nothing owns no aggregate, holds no invariant of its own, and carries no business state — which is `AR-1`'s test, verbatim.

---

## 3. Ownership and non-ownership

### 3.1 What A1 owns

| Owned | Nature |
|---|---|
| The **composition logic** that derives the participant set | Read-time computation |
| The **evaluation logic** for the access predicate | Read-time computation |
| Its **own API contract and pagination** | Presentation |
| **Nothing else** | — |

### 3.2 What A1 does not own, and must not duplicate

`LCM-BR-001` — A1 **MUST NOT** own, duplicate, cache authoritatively, or define a competing vocabulary for any of the following.

| Concern | Owner | A1's only lawful relationship |
|---|---|---|
| `PersonId`, `Username`, identity, profile, photo, bio, profile privacy | **BC-10** / `PRD-003` | Reference `PersonId` only, via the existing `E-13` ACL. **Renders no profile field on its own authority** — see `LCM-FR-014` |
| `Library`, `TenantOrganisation`, ownership, operational information, branding | **Library Management** / `Library_PRD_v1.md` | Reads the tenant identity from ambient context |
| `Membership`, status, dates, expiry, suspension, restoration | **Library Membership** / **FROZEN** `PRD-005` | Reads the published `MembershipValidity` read model. **Defines no status of its own** |
| Seat identity, status, layout, schedule, assignment, **seat release** | **Seat Management** / **FROZEN** `PRD-007`, `BC-04` | **No relationship.** A1 never reads, holds, or influences a seat |
| Friends, follows, blocks | **Social Graph** / `PRD-021`, `BC-11` | **No relationship in V1** |
| Messaging, conversations | `BC-12` | **No relationship in V1** |
| Roles, permissions, access policy | **BC-18** / `PRD-001` | Consumes the caller's existing `AccessRole`. **Mints no permission** |
| Safety enforcement, moderation | `BC-14` / `PRD-020` | Consumes one already-published signal. **Performs no moderation** |
| Configuration resolution semantics | `BC-25` / `PRD-023` | Reads a value through the typed accessor |

`LCM-BR-002` — Where a concern above and A1 disagree, **the owner prevails without exception**. A1 has no authority to reconcile.

`LCM-BR-003` — A1 **MUST NOT** duplicate the **Library Member Directory** (`PRD-004` ch. 5). Frozen `MM-BR-011` already forbids `BC-02` from duplicating it; A1 inherits that discipline. Where the Directory already answers a question, A1 **MUST** defer to it rather than re-derive.

---

## 4. `AR-1` classification

`LCM-FR-001` — A1 **MUST** be classified under ruling `AR-1` (`ARCHITECTURE_RULINGS.md` §23) as an application / read-composition capability of the Library domain.

`LCM-FR-002` — A1 **MUST NOT** be assigned a `BC-` identifier. The bounded-context count **remains 31 (23 in V1)**.

`LCM-FR-003` — A1's satisfaction of the `AR-1` test **MUST** be demonstrable, not asserted:

| `AR-1` criterion | A1 | Evidence in this document |
|---|---|---|
| Owns no aggregate | ✅ | §2.2 — no mutation exists |
| Owns no invariant | ✅ | §9 — every invariant is a restatement of an owner's rule or of `AP-3` |
| Owns no business state | ✅ | §10 — nothing is persisted (`LCM-RM-009`) |
| Only orchestrates published read models | ✅ | §10, §13 |
| Delegates all domain operations to owning modules | ✅ | §3.2 — there are no domain operations to delegate |

`LCM-FR-004` — A1 **MUST NOT** be recorded as pulling `BC-15` into V1. `BC-15` remains **V2** (BC Map L119, L146-147; `MP-SCOPE-04`; Registry L391), and every item at `LIBOORA_ENTERPRISE_ARCHITECTURE.md` L967-973 remains at its declared version.

`LCM-FR-005` — A1 code **MUST** reside in the application / read layer. It **MUST NOT** be placed under `lib/domain/`, and **MUST NOT** add a context to `domain/library` or `domain/social` in `tool/module_dependencies.yaml`.

`LCM-FR-006` — A1 **MUST NOT** import `domain/social/**`. `X-05` (`LIBOORA_MODULE_DEPENDENCY_MATRIX.md` L354) prohibits the Library ↔ Student Network pairing beyond the `PersonId` link via the `E-13` ACL, and A1 relies on no more than that link.

---

## 5. Ubiquitous language

`LCM-BR-004` — A1 **MUST** use the resolutions at BC Map §5 verbatim. That column is **binding** (BC Map L200).

| Concept | Term A1 **MUST** use | Term A1 **MUST NOT** coin | Authority |
|---|---|---|---|
| A person holding a membership | **`MembershipHolder`** | *CommunityMember* | BC Map **L212** |
| An authorisation role | **`AccessRole`** | *CommunityRole* | BC Map **L212** |
| The library entity | **`TenantOrganisation`** | bare *"library"* | BC Map **L210** |
| Membership state | The states of frozen `MM-FR-072` | any A1-defined status | `LMD-3` |

`LCM-BR-005` — A1 introduces exactly **one** new term, and it is a **predicate, not an entity**: **`membershipInForce`** — a derived boolean. It is not a status, not a state machine, and not stored (§10).

> ⚠ **Citation note.** `PRD-020` `TSF-XC-031` cites BC Map "L214" for the community-role row; the measured line is **L212**. A1 cites **L212**.

---

## 6. Functional requirements

### 6.1 Participant derivation

`LCM-FR-007` — A1 **MUST** derive the participant set for a `TenantOrganisation` as the set of `MembershipHolder`s whose `membershipInForce` is true at evaluation time, less every exclusion in §13.

`LCM-FR-008` — `membershipInForce` **MUST** be derived from the **published `MembershipValidity` read model**. Frozen `MM-BR-011` obliges `BC-02` to publish plan, membership status, `validUntil` and seat quota through the `E-02` projection; frozen `LMD-16` establishes that a members-only surface reads exactly that projection for expiry determination.

`LCM-FR-009` — A1 **MUST NOT** derive `membershipInForce` from any other source, and **MUST NOT** query membership storage directly.

`LCM-FR-010` — A1 **MUST NOT** define, store, or expose a membership status of its own. `LMD-3` is the governing precedent: a read composition *"MUST NOT define a `MemberStatus` of its own."*

`LCM-FR-011` — A1 **MUST NOT** require, request, or assume any new integration edge. BC Map L292 holds that an edge absent from §7 does not exist; frozen `MM-BR-006` closes `BC-02`'s edge set at ten, with `MM-AC-065` enforcing. `E-02` is already in that set.

`LCM-FR-012` — A1 **SHOULD** obtain the participant set by composing the **existing Library Member Directory** output where that output already satisfies the need, rather than composing the projection independently. `MM-BR-011` and `LMD-1`…`LMD-31` already establish that path, so this is the option with the smallest new surface.

`LCM-FR-013` — Where `LCM-FR-012` is not sufficient, A1 **MAY** compose the published `MembershipValidity` read model directly. This is composition of a published read model, not a new edge — `AR-1` describes such capabilities as ones that *"only orchestrate public read models."* See §22 `LCM-ADR-001`.

### 6.2 Rendering and profile fields

`LCM-FR-014` — A1 **MUST NOT** render any person profile field on its own authority. `PersonId` is A1's only person-level datum. Any human-readable rendering **MUST** be delegated to the surface already authorised to perform it, subject to **BC-10**'s privacy resolution.

`LCM-FR-015` — A1 **MUST NOT** override, relax, or bypass profile visibility. `ADR-0011` L195 records that **private is the default profile visibility** (`AP-3`, `SID-INV-008`, `SCFG-5`). A person appearing in the participant set does **not** make that person's profile visible.

`LCM-FR-016` — A1 **MUST NOT** expose a `StudentRecordId` on any participation surface. Frozen `MM-FR-003` establishes the `StudentRecordId` / `PersonId` separation; BC Map `ID-2`/`ID-3` govern which identifier may cross which boundary.

### 6.3 Tenant scoping

`LCM-FR-017` — Every A1 read **MUST** be scoped to exactly one `TenantOrganisation`, and the scope **MUST** be applied **server-side before any filter, search, sort or pagination**. `LMD-8` is the governing precedent.

`LCM-FR-018` — The `TenantOrganisation` **MUST** be taken from ambient tenant context, never from a caller-supplied parameter. `E-18`'s declared mechanism is *"ambient TenantContext — never a parameter."*

`LCM-FR-019` — A1 **MUST NOT** support, expose, or make derivable any cross-`TenantOrganisation` participant view, count, aggregate, comparison, or existence check. BC Map L488 (`ID-2`), Matrix L354 (`X-05`), and EA L913 (multiple library memberships are **V2**) each independently forbid it.

`LCM-FR-020` — Cross-tenant isolation **MUST** be structural, not conditional. A1 inherits `platform/tenancy:tenant_context` from the library cluster; it **MUST NOT** implement isolation as application-layer filtering that a defect could omit. BC Map §11.1 identifies the mixing of tenant operational data with a global index as *"the single highest-severity failure mode in the entire architecture."*

### 6.4 Visibility

`LCM-FR-021` — A1's visibility **MUST** be fixed at **`PRIVATE`**. It is not configurable, not per-library, and not per-person.

`LCM-FR-022` — A1 **MUST NOT** appear on any public, anonymous or unauthenticated surface. `LMD-7` forbids it for the Directory; `14B-Public-Library-Preview.md` L173 records the Member Directory *"in any form"* as `LCFG-5`-gated and tenant-private.

`LCM-FR-023` — A1 **MUST NOT** contribute any field to the public discovery index, and **MUST NOT** be reachable through it.

### 6.5 Minor consent

`LCM-FR-024` — A1 **MUST NOT** activate any participation capability for a person whose `Account` is not linked to a guardian consent record where one is required. BC Map **`ID-6`** requires the link *"before any social context is activated"*.

`LCM-FR-025` — Where minor status is **`Unknown`**, A1 **MUST** treat the person as a minor and withhold activation. `SM-INV-3` (`Student_Management_PRD_v1.md` L314) applies the guardian requirement to `Unknown` as well as to a confirmed minor, on the authority of `AP-3` and `SID-4.56`.

`LCM-FR-026` — A withheld activation under `LCM-FR-024`/`LCM-FR-025` **MUST NOT** be reported as an error, a rejection, or an absence of membership. The membership is unaffected; only the participation capability is closed.

### 6.6 Prohibited capabilities

`LCM-FR-027` — A1 **MUST NOT** implement any mutation. Specifically it **MUST NOT** provide join, leave, invite, request, approve, remove, block, post, comment, react, follow, message, or role-assignment operations.

`LCM-FR-028` — A1 **MUST NOT** create, emit, publish or register any event. Frozen `MM-BR-035` closes the membership event register at **seven** (`MM-EVT-001`…`007`).

`LCM-FR-029` — A1 **MUST NOT** define a suspended, frozen, restored or dormant participation state. Frozen `MM-FR-072` closes `MembershipStatus` at **six states and contains no `Suspended`**; frozen `MM-FR-073` makes `Frozen` unreachable in V1.

`LCM-FR-030` — A1 **MUST NOT** define, request or reference a permission identifier. `AUTH-7.22` closes the permission catalogue, and `ADR-0036` §7.1 records that **zero** entries exist repository-wide.

`LCM-FR-031` — A1 **MUST NOT** define a role. `PRD-001` §7 L87 closes the role set at five: `TR-1` Owner, `TR-2` Manager, `TR-3` Reception, `TR-4` Student, `TR-5` Parent.

`LCM-FR-032` — A1 **MUST NOT** reference a "Staff" role or actor. No such role exists in the closed set, and `BC-07` Staff & Shift is **V2**.

`LCM-FR-033` — A1 **MUST NOT** perform, initiate, queue, record or recommend any moderation action. Moderation is **V3** (EA L967-973), and `PRD-020` §9.3 defers the community-moderator actor to `BC-15` at V2.

`LCM-FR-034` — A1 **MUST NOT** read, hold, influence, delay or trigger any seat operation. Frozen `MM-FR-112` assigns seat release to `BC-04`.

`LCM-FR-035` — A1 **MUST NOT** expose, aggregate or infer financial data of any kind.

---

## 7. Business rules

| Ref | Rule | Authority |
|---|---|---|
| `LCM-BR-001`…`005` | See §3.2, §5 | — |
| `LCM-BR-006` | Participation is a **consequence** of membership, never an act. There is no participation record to create or destroy | `AR-1`; §2.2 |
| `LCM-BR-007` | A1's grain is the **`TenantOrganisation`**, not the `Branch`. A person studying at two branches of one library participates in **one** community | BC Map L210; `LMD-8`; `AUTH-7` L72; `MM-FR-003` |
| `LCM-BR-008` | A1 **MUST** fail closed. Where any input is unavailable, unresolved or ambiguous, the participation capability is **withheld**, never granted | `AP-3` (`PRD-001` §7 L51) |
| `LCM-BR-009` | A1 **MUST NOT** be the authority for any fact it displays. Every fact is attributable to an owning context | `AR-1`; `LMD-1` |
| `LCM-BR-010` | A1 **MUST NOT** claim to discharge, satisfy or advance any `PRD-020` gate, T-5 included | `TSF-FR-141`; `SID-4.56` |
| `LCM-BR-011` | A1 **MUST NOT** change any `LCFG-*` value or alter any existing parameter's declared semantics | `CONFIGURATION_GUIDE.md` §5 |
| `LCM-BR-012` | A1 **MUST NOT** decide any question an ACCEPTED ADR has reserved to another authority | `ADR-0036` §6.5, §8.2 |

---

## 8. Data and read model

### 8.1 The composed read model

`LCM-RM-001` — A1's read model is a **projection composition**. It has exactly one shape:

| Field | Type | Source of truth | Path |
|---|---|---|---|
| `tenantOrganisationId` | tenant key | **BC-19** | Ambient context (`E-18`) — never a parameter |
| `personId` | `PersonId` | **BC-10** | Existing `E-13` ACL link |
| `membershipInForce` | boolean | **derived** | Published `MembershipValidity` read model (`MM-BR-011`, `LMD-16`) |
| `participationOpen` | boolean | **derived** | `membershipInForce` ∧ ¬excluded ∧ ¬tenantSuspended ∧ consentSatisfied ∧ gateEnabled |

`LCM-RM-002` — That is the **complete** field list. A1 **MUST NOT** add a field without an amendment to this specification.

`LCM-RM-003` — A1 **MUST NOT** include plan, price, `validUntil`, seat quota, seat identity, attendance, fee, or any financial field. Even though `MM-BR-011` publishes several of these to the Directory, A1 needs only the derived predicate, and `AP-3` makes the minimum the correct set.

`LCM-RM-004` — A1 **MUST NOT** include a display name, photograph, bio, username, or contact field. Rendering is delegated per `LCM-FR-014`.

`LCM-RM-005` — A1 **MUST NOT** include a `StudentRecordId`, a `tenantId` inside any social-side structure, or any identifier whose crossing is governed by `ID-2`/`ID-3`.

### 8.2 Persistence

`LCM-RM-006` — A1 **MUST NOT** persist a participant row, participant table, participant cache, or materialised participant view. `LMD-2` is the governing precedent.

`LCM-RM-007` — A1 **MUST NOT** hold a durable copy of `membershipInForce`.

`LCM-RM-008` — A1 **MAY** hold a request-scoped, in-memory composition for the duration of a single read. Such a structure **MUST NOT** outlive the request and **MUST NOT** be shared across tenants.

`LCM-RM-009` — A1 owns **no schema, no table, no migration and no store**. This requirement exists so that its violation is a specification defect rather than a design discussion.

### 8.3 Consistency

`LCM-RM-010` — The composed read model is **eventually consistent**. Frozen `MM-BR-012` records that validity consumed downstream is eventually consistent and that BC Map §10 accepts a bounded staleness of **< 5s** for seat assignment, describing a *"stale membership projection"* as *"an accepted, bounded risk."*

`LCM-RM-011` — A1 **MUST** adopt **< 5s** as its staleness bound, **cited to `MM-BR-012`, not invented**. A1 **MUST NOT** publish a different figure or a tighter guarantee.

`LCM-RM-012` — A1 **MUST** expose observable projection lag on the pattern already implemented at `lib/domain/social/messaging/enforcement_projection.dart` — a lag accessor and a lag observation hook. It **MUST NOT** invent a new observability shape.

### 8.4 Pagination

`LCM-RM-013` — Participant reads **MUST** be paginated, **cursor-based, not offset-based**, following `LMD-9`/`LMD-10`/`LMD-11`.

`LCM-RM-014` — Page size **MUST** be bounded by an existing declared bound. A1 **MUST NOT** declare a new page-size parameter.

`LCM-RM-015` — A1 **MUST NOT** expose a total participant count. A precise count of everyone who studies at a library is the enumeration risk `LCFG-12` exists to bound, and it is not needed for any in-scope capability.

---

## 9. Invariants

| Ref | Invariant | Restated from |
|---|---|---|
| `LCM-INV-001` | A1 holds no persisted state | `LMD-2`; `AR-1` |
| `LCM-INV-002` | Every read is scoped to exactly one `tenantOrganisationId`, applied server-side before any filter | `LMD-8` |
| `LCM-INV-003` | No cross-tenant participant fact is readable, derivable or inferable | BC Map L488; `X-05`; §11.1 |
| `LCM-INV-004` | A1 defines no membership status | `LMD-3`; `MM-FR-072` |
| `LCM-INV-005` | A1 emits no event | `MM-BR-035` |
| `LCM-INV-006` | A1 confers no authority | `LMD-24`, `LMD-24a`, `LMD-24b` |
| `LCM-INV-007` | A1 grants, stores and assigns no permission | `AUTH-7.22` |
| `LCM-INV-008` | No participation capability activates for a person whose guardian consent is required and absent, **including where minor status is `Unknown`** | BC Map **`ID-6`**; `SM-INV-3` |
| `LCM-INV-009` | Visibility is `PRIVATE` and immutable | §6.4 |
| `LCM-INV-010` | A1 is unreachable from any public, anonymous or unauthenticated surface | `LMD-7`; `14B` L173 |
| `LCM-INV-011` | Absence of an explicit positive determination is refusal | `AP-3` |
| `LCM-INV-012` | A1 exposes no seat, attendance, fee or financial datum | `MM-FR-112`; `AC-7.8` |
| `LCM-INV-013` | A1 renders no profile field on its own authority; profile privacy is resolved by BC-10 | `ADR-0011` L195 |
| `LCM-INV-014` | A1 performs no mutation | §2.2 |

---

## 10. Membership validity and the protected renewal window

### 10.1 What is settled

`LCM-FR-036` — A1 **MUST** treat the following as settled by **ACCEPTED** `ADR-0036`:

| Question | Outcome | Locus |
|---|---|---|
| Is there a three-calendar-day protected renewal window? | ✅ **Yes — 3 calendar days, mandatory, V1** | `ADR-0036` §8.2, q1 |
| Is the duration configurable? | ✅ **No — FIXED** | `ADR-0036` §8.2, q3 |

`LCM-FR-037` — A1 **MUST** reuse the calendar arithmetic already specified at `ADR-0036` §6.4, which names frozen `MM-FR-057`, `MM-FR-058`, `MM-FR-059`, `MM-FR-061`, `MM-FR-062` and `MM-FR-064`. A1 **MUST NOT** implement its own date arithmetic, time-zone handling or day-boundary rule.

`LCM-FR-038` — Where a `TenantOrganisation`'s local day boundary is required, it **MUST** be resolved from `LCFG-1` (time zone) through the `BC-25` typed accessor. A1 **MUST NOT** assume UTC and **MUST NOT** read a raw configuration string.

### 10.2 What is not settled — and is not guessed here

`LCM-FR-039` — A1 **MUST NOT** determine, infer, assume, default or hard-code the **first day of the protected renewal window**. `ADR-0036` is **ACCEPTED on questions 1 and 3 only**; §8.2 records question 2 as **NOT ANSWERED, STILL BLOCKED**, with the owner named as the **Product Owner**, and §6.5 expressly refuses to infer it.

`LCM-FR-040` — A1 **MUST** express the window **parametrically**. The rule is stated as:

> `membershipInForce` remains **true** for a `MembershipHolder` throughout the protected renewal window, where the window spans **three calendar days** beginning at **`W₀`**, and **`W₀` is an unresolved product determination** — either the expiry date itself, or the calendar day following it.

`LCM-FR-041` — A1 **MUST NOT** ship an implementation that silently selects a value for `W₀`. Where `W₀` is unresolved, the participation capability for a `MembershipHolder` inside the ambiguous day **MUST** fail closed under `LCM-BR-008`/`AP-3`.

`LCM-FR-042` — A1 **MUST NOT** amend, reinterpret, extend or supersede `ADR-0036`. It is **ACCEPTED**. Resolution of question 2 arrives as a **new** ADR or a recorded conferral from the Product Owner.

`LCM-FR-043` — A1 **MUST NOT** treat the window as affecting money, entitlement, or seat timing. `ADR-0036` §3 separates those three concerns, and frozen `MM-FR-112` assigns seat release to `BC-04`.

`LCM-FR-044` — The acceptance criterion that would verify the window's first day is **declared unwritable** while `W₀` is unresolved. See `LCM-AC-041` and `LCM-GAP-001`.

> **Why this is stated as a hole rather than filled.** `ADR-0036` §6.5 gives the reason in its own words: a one-day error *"is visible to a paying student on a date that decides whether their seat is released."* Guessing would produce a specification that reads as complete and is wrong on exactly the day that matters.

> **Note, not a claim.** `ADR-0036` §6.1 sets out a minimum amendment set A1–A5 which has **never been applied**. A1 does not apply it, does not depend on it, and does not change its status.

---

## 11. Authorization

### 11.1 Derivation, not grant

`LCM-AUTH-001` — A1's capabilities **MUST** be **derived at evaluation time**. Nothing is granted, assignable, delegable, inheritable, or stored.

`LCM-AUTH-002` — A1 **MUST NOT** introduce a permission identifier. `AUTH-7.22` closes the catalogue; `ADR-0036` §7.1 records **zero** entries repository-wide. `AP-3` additionally makes a newly introduced permission *"unreachable by every role until explicitly granted"* — so minting one would produce a permanently-denied capability.

`LCM-AUTH-003` — The predicate is:

```
participationOpen(caller, tenantOrganisation) :=
      gateEnabled(tenantOrganisation)              // §12
  AND membershipInForce(caller, tenantOrganisation) // §8.1, §10
  AND NOT excluded(caller)                          // §13
  AND NOT tenantSuspended(tenantOrganisation)       // §13
  AND consentSatisfied(caller)                      // §6.5
  AND accessRolePermits(caller, tenantOrganisation)  // §11.2
```

`LCM-AUTH-004` — Every conjunct **MUST** be evaluated. A1 **MUST NOT** short-circuit in a direction that produces a grant.

`LCM-AUTH-005` — The composition **MUST NOT** confer authority. `LMD-24`, `LMD-24a` and `LMD-24b` establish that a read composition may neither enter the domain layer nor confer authority.

`LCM-AUTH-006` — A deny **MUST** defeat an allow, per `XC-7.2`.

### 11.2 Role treatment — explicit, with no inheritance

`LCM-AUTH-007` — A1 **MUST** state each role's treatment explicitly. `AUTH-7.10` / `AP-7` establish that **no role inheritance exists**, so `TR-1` Owner does **not** acquire `TR-4` Student's participation by seniority.

| `AccessRole` | Treatment | Basis |
|---|---|---|
| **`TR-4` Student** | **Permitted**, subject to every conjunct of `LCM-AUTH-003` | The role that holds a membership |
| **`TR-1` Owner** | **Not permitted by role.** Permitted only if this person independently satisfies `membershipInForce` at this `TenantOrganisation` | `AUTH-7.10` — no inheritance |
| **`TR-2` Manager** | **Not permitted by role.** Same rule as `TR-1` | `AUTH-7.10` |
| **`TR-3` Reception** | ⚠ **Interim DENY under `AP-3`** — see `LCM-GAP-002` | `AP-3`; the `SM-8.4a` precedent |
| **`TR-5` Parent** | **Not permitted.** No authority grants a parent a participation surface, and `AP-3` makes absence refusal | `AP-3`; `AUTH-7.21` |

`LCM-AUTH-008` — An `AccessRole` is scoped to exactly one library (`PRD-001` §7 L72). A person may hold `TR-1` at one `TenantOrganisation` and `TR-4` at another — `PRD-001` L343 works precisely that example. A1 **MUST** evaluate against the role held **at the `TenantOrganisation` in ambient context**, and **MUST NOT** carry a role across tenants.

`LCM-AUTH-009` — A1 **MUST NOT** rely on a default role. `AUTH-7.21` establishes that none exists.

`LCM-AUTH-010` — A1 **MUST NOT** expose any financial datum to any role. `AC-7.8` and `PRD-001` §7 L208 make Reception's financial exclusion absolute; `LCM-INV-012` extends the same posture to every role, since A1 has no financial datum at all.

> **On `TR-3` Reception.** No authority addresses whether Reception should see a members-only participation surface. Rather than leave the hole silent, A1 records an **interim deny** and names the Product Owner — following `PRD-004` `SM-8.4a`, which does exactly this: *"records an interim **deny** for `TR-5` under `AP-3`."*

---

## 12. Configuration and gating

`LCM-CFG-001` — A1's exposure **MUST** be gated, and the gate **MUST** be **deny-by-default**. `AP-3` is the direct authority; `LMD-4` is the precedent, gating the Member Directory on a parameter whose default is **Disabled**.

`LCM-CFG-002` — In V1, A1 **MUST** be gated by the **existing** parameter `LCFG-5` (Member directory), default **Disabled**, owner **Security**. **No parameter is created and no amendment is required.**

`LCM-CFG-003` — The reuse is semantic, not opportunistic. `LCFG-5`'s declared rationale (`CONFIGURATION_GUIDE.md` L355) is *"Deny by default (`AP-3`). **Exposes members to members**; must be opted into"* — which is A1's function stated in the parameter's own words. Its expanded rationale (L365-369) applies to A1 with at least equal force:

> *"A member directory is a list of everyone who studies at a library, together with the fact that they study there. In a domain where the users are largely students and a meaningful share are minors, that is not a neutral feature. Deny by default (`AP-3`) is not caution here; it is the only defensible starting position."*

`LCM-CFG-004` — The gate value **MUST** be read through the **`BC-25` typed accessor** on `E-19`. A raw string lookup is forbidden — `LMD-6` establishes the rule.

`LCM-CFG-005` — `LCFG-5` is a **per-library** setting, not per-environment (`CONFIGURATION_GUIDE.md` L829). A1 **MUST NOT** resolve it per environment and **MUST NOT** relax it in development.

`LCM-CFG-006` — Disabling the gate **MUST** suppress exposure **without deleting** any membership, student or person data. `LMD-5` establishes this.

`LCM-CFG-007` — A1 **MUST NOT** create, rename, re-default or re-scope any configuration parameter. Adding a parameter is *"a PRD amendment"* (`CONFIGURATION_GUIDE.md` L863) and promoting a structural fact to configurable requires *"an ADR **and** a PRD amendment"* (L864). A1 requires neither.

`LCM-CFG-008` — A1 **MUST NOT** make its visibility, its window duration, or any invariant in §9 configurable.

> **⚠ Recorded cost of `LCM-CFG-002`.** Reuse means a library cannot enable a member directory while keeping the participation surface closed, or the reverse. The cleaner shape is a dedicated parameter in the next contiguous slot after `LCFG-13`, default Disabled, owner Security — **one Rank 3 amendment to `Library_PRD_v1.md` §16.1, and no ADR** (that document is *"Approved — authoritative"*, not frozen). A1 does **not** take that route in V1, because the brief is the smallest compatible change and a lean V1. Recorded as `LCM-GAP-003`, with no identifier minted.

---

## 13. Signals consumed — and the events not created

### 13.1 The rule

`LCM-SIG-001` — A1 **MUST NOT** create, emit, publish, register or request any event. Frozen `MM-BR-035` closes the membership event register at **seven**; frozen `MM-FR-072` closes `MembershipStatus` at six with **no `Suspended`**; frozen `MM-FR-073` makes `Frozen` unreachable in V1.

`LCM-SIG-002` — Every A1 need **MUST** be met by a signal or read model that **already exists and is already declared**.

### 13.2 The three mechanisms

| Need | Mechanism | Already declared at | Governance cost |
|---|---|---|---|
| `LCM-SIG-003` — membership lapsed or renewed | **No event.** A derived predicate over the published `MembershipValidity` read model. When `validUntil` passes, the predicate flips | `MM-BR-011`; `LMD-16` — the Directory's expiry filter reads the projection, it does not consume an expiry event | **Zero** |
| `LCM-SIG-004` — a person is excluded for safety reasons | Consume **`safety.EnforcementActionTaken`** | BC Map L433 (fan-out); `E-14` consumer set at BC Map L318. `PRD-020` `TSF-FR-029`: the consumer set already includes the relevant contexts, so *"no amendment is needed"* | **Zero** |
| `LCM-SIG-005` — the whole library is suspended | Consume **`tenancy.TenantSuspended`** | Already published on the universal consumer list | **Zero** |

`LCM-SIG-006` — On consuming `safety.EnforcementActionTaken`, A1 **MUST** withhold the participation capability for the affected person for the duration of the action. It **MUST NOT** alter any membership, **MUST NOT** record a status, and **MUST NOT** notify.

`LCM-SIG-007` — On consuming `tenancy.TenantSuspended`, A1 **MUST** suppress the entire surface for that `TenantOrganisation`, without deleting data (`LMD-5`).

`LCM-SIG-008` — A1's consumption **MUST** reuse the evaluation shape already implemented and tested at `lib/domain/social/messaging/enforcement_projection.dart` — a refusal-returning evaluation accessor, a rebuild path, an exposed lag accessor, and a lag observation hook. A1 **MUST NOT** invent a competing shape. That file is 497 lines with 26 passing tests, and `ADR-0065` Option B is the accepted pattern behind it.

`LCM-SIG-009` — A1 **MUST NOT** claim that its consumption discharges any `PRD-020` gate. `PRD-020` T-5 requires integration plus fault-injection evidence (`PRD-020` L2129); no `integration_test/` directory exists; `TSF-FR-141` forbids recording T-5 as passing; `SID-4.56` holds that *"a rule that cannot be checked SHALL be treated as unmet."*

### 13.3 What was removed, and why no amendment was sought

| Removed from draft v0.1 | Reason | Replacement |
|---|---|---|
| A membership-suspended event | `MM-BR-035` closes the register at seven | `LCM-SIG-004` |
| A membership-restored event | Same | `LCM-SIG-004` (expiry of the action) |
| A suspended participation state | `MM-FR-072` has six closed states, none of them suspended | No state — a derived predicate |

**No frozen-document amendment was requested**, because none of the three needs was actually blocked. `ADR-0036` §8 states the discipline: asking to amend a frozen rule that does not block the requirement spends governance authority for nothing.

---

## 14. API surface

`LCM-API-001` — A1's API **MUST** be **read-only**. It exposes no mutation, no command and no side effect.

`LCM-API-002` — A1 exposes exactly **two** read capabilities. Two is the complete surface.

| Ref | Capability | Returns | Notes |
|---|---|---|---|
| `LCM-API-003` | **Participation check** for the calling principal at the ambient `TenantOrganisation` | `participationOpen` boolean, plus a non-enumerating refusal reason | The reason **MUST NOT** disclose which conjunct failed in a way that reveals another person's status, a membership date, or a safety action |
| `LCM-API-004` | **Participant page** for the ambient `TenantOrganisation` | A cursor-paginated page of `PersonId` | Callable **only** when `LCM-API-003` returns true for the caller |

`LCM-API-005` — Both capabilities **MUST** require authentication **and** authorisation. `14B` L231 records that authorisation is required *"in addition to* authentication, never instead of it."*

`LCM-API-006` — Neither capability **MUST** be reachable anonymously, publicly, or through the discovery index.

`LCM-API-007` — `tenantOrganisationId` **MUST NOT** be an API parameter. It is ambient (`E-18`, `LCM-FR-018`).

`LCM-API-008` — Search over participants **MUST NOT** be implemented by A1. Where search is required, it is served by `BC-23` on the existing `E-21` path, permission-aware and tenant-partitioned, per `LMD-12`/`LMD-13`/`LMD-14`. A1 **MUST NOT** build an index.

`LCM-API-009` — Neither capability **MUST** return a total count (`LCM-RM-015`), a membership date, a plan, a seat, a fee, or a profile field.

`LCM-API-010` — A refused call **MUST** return a refusal, not an empty success. An empty page and a denied page **MUST** be distinguishable to the caller and **MUST NOT** be distinguishable in a way that enumerates.

`LCM-API-011` — A1 **MUST NOT** expose an administrative, bulk, export, or reporting variant of either capability in V1.

---

## 15. Non-functional requirements

`LCM-NFR-001` — Staleness bound: **< 5s**, adopted from `MM-BR-012`, **not invented** (`LCM-RM-011`).

`LCM-NFR-002` — A1 **MUST NOT** publish a numeric latency or throughput budget in this version. `SID-4.56` holds that *"a rule that cannot be checked SHALL be treated as unmet"*, and no A1 measurement harness exists. `PRD-020`'s posture — 62 acceptance criteria cited, 2 proven — is the cautionary precedent.

`LCM-NFR-003` — Where a budget is later supplied by a competent authority, it **MUST** be attributed, not derived. `ADR-0057`'s treatment of the media-processing values is the precedent for *"attributed, not derived."*

`LCM-NFR-004` — A1 **MUST** fail closed on unavailability of any input, including the configuration accessor, the projection, and the signal stream.

`LCM-NFR-005` — Projection lag **MUST** be observable (`LCM-RM-012`).

`LCM-NFR-006` — A1 **MUST NOT** relax any security-bearing behaviour in the development environment. The gate's default, the tenant scoping, the consent gate and the fail-closed direction **MUST** hold in every environment.

`LCM-NFR-007` — A1 **MUST NOT** degrade the paying product on failure. Where A1 is unavailable, membership, seating, attendance and fee capabilities **MUST** be unaffected — this is the harm `X-05` was written to prevent (*"a social outage takes down the paying product"*).

`LCM-NFR-008` — A1 **MUST NOT** introduce a synchronous dependency from any library-domain write path onto A1. A1 is a leaf read composition.

---

## 16. Edge cases

| # | Case | Required behaviour | Authority |
|---|---|---|---|
| 1 | Membership expired, inside the protected window | `membershipInForce` **true** — but see case 2 | `ADR-0036` §8.2 q1 |
| 2 | Membership expired, on the **ambiguous first day** | ⛔ **Fail closed.** `W₀` unresolved | `LCM-FR-041`; `AP-3` |
| 3 | Membership expired, past the window | `participationOpen` **false** | §10 |
| 4 | Membership never activated | **false** | `MM-FR-072` |
| 5 | Membership pending payment | **false** — A1 reads the projection and does not interpret payment | `E-10`; `MM-BR-011` |
| 6 | Person under an active safety enforcement action | **false**, membership untouched | `LCM-SIG-006` |
| 7 | Enforcement action expires | **true** again, with no restoration event | `LCM-SIG-004` |
| 8 | `TenantOrganisation` suspended | Entire surface suppressed; no data deleted | `LCM-SIG-007`; `LMD-5` |
| 9 | Gate disabled | Surface absent; no data deleted; no error implying absence of membership | `LCM-CFG-006` |
| 10 | Gate value unreadable | **Fail closed** | `LCM-NFR-004`; `AP-3` |
| 11 | Minor without guardian consent record | Capability withheld; **not** reported as an error | `ID-6`; `LCM-FR-026` |
| 12 | Minor status **`Unknown`** | Treated as a minor; withheld | `SM-INV-3`; `SID-4.56` |
| 13 | Guardian consent later recorded | Capability opens with no A1 action | Derived, not stored |
| 14 | `TR-1` Owner who is not a member at this library | **false** — no role inheritance | `AUTH-7.10` |
| 15 | Person is `TR-1` at library C and `TR-4` at library A | Evaluated **only** against the ambient tenant | `PRD-001` L343; `LCM-AUTH-008` |
| 16 | `TR-3` Reception | **Interim deny** | `AP-3`; `LCM-GAP-002` |
| 17 | `TR-5` Parent | **Deny** | `AP-3`; `AUTH-7.21` |
| 18 | Membership at two branches of one library | **One** participation; grain is `TenantOrganisation` | `LCM-BR-007` |
| 19 | Memberships at two different libraries | **Two independent** evaluations; **no** cross-tenant view | `LCM-FR-019`; `X-05`; EA L913 |
| 20 | Projection lag exceeds the bound | Lag observable; A1 **MUST NOT** silently serve stale data as fresh; **MUST NOT** invent a stricter guarantee | `MM-BR-012`; `LCM-RM-012` |
| 21 | Projection unavailable | **Fail closed**; paying product unaffected | `LCM-NFR-004`; `LCM-NFR-007` |
| 22 | Signal stream unavailable | **Fail closed** — an unknown exclusion is treated as an exclusion | `AP-3` |
| 23 | Caller anonymous or unauthenticated | Refuse | `LCM-FR-022`; `14B` L231 |
| 24 | Caller supplies a tenant parameter | Ignore it and refuse the call as malformed; never honour it | `E-18`; `LCM-FR-018` |
| 25 | Person's profile is private | Person may appear in the participant set as a `PersonId`; **no profile field is rendered** | `ADR-0011` L195; `LCM-FR-014` |
| 26 | Person deletes their account | Person leaves the set by derivation; A1 takes no action and stores no tombstone | `LCM-RM-006` |

---

## 17. Acceptance criteria

**Verifiable now — 40 criteria.**

### 17.1 Classification and placement

| Ref | Criterion |
|---|---|
`LCM-AC-001` | No `BC-` identifier is assigned to A1 anywhere in the specification
`LCM-AC-002` | The documented bounded-context count remains **31 (23 in V1)**
`LCM-AC-003` | `BC-15` is recorded as **V2** in every location it appears; A1 changes none of them
`LCM-AC-004` | `PRD_REGISTRY.md` L321 is byte-unchanged; `PRD-021` still lists `BC-11`, `BC-12`
`LCM-AC-005` | `MASTER_PRD.md`, the BC Map, the Module Dependency Matrix and `tool/module_dependencies.yaml` are byte-unchanged
`LCM-AC-006` | No A1 source file resides under `lib/domain/`
`LCM-AC-007` | No context is added to `domain/library` or `domain/social` in the manifest
`LCM-AC-008` | A1 imports nothing from `domain/social/**`
`LCM-AC-009` | `dart run tool/check_module_boundaries.dart` reports **no new violation category** beyond the known `ADR-0012` baseline

### 17.2 Ownership and non-duplication

| Ref | Criterion |
|---|---|
`LCM-AC-010` | A1 defines no aggregate
`LCM-AC-011` | A1 owns no schema, table, migration or store
`LCM-AC-012` | No persisted participant row, table, cache or materialised view exists
`LCM-AC-013` | A1 defines no membership status
`LCM-AC-014` | A1 does not duplicate the Library Member Directory
`LCM-AC-015` | The composed read model contains exactly the four fields at `LCM-RM-001`
`LCM-AC-016` | No `StudentRecordId` appears on any A1 surface
`LCM-AC-017` | No profile field is rendered on A1's own authority

### 17.3 Language

| Ref | Criterion |
|---|---|
`LCM-AC-018` | `MembershipHolder` and `AccessRole` are used verbatim
`LCM-AC-019` | The terms *CommunityMember* and *CommunityRole* appear **nowhere**
`LCM-AC-020` | No bare use of *"library"* remains where `TenantOrganisation` is meant
`LCM-AC-021` | Every BC Map §5 citation for the role/member rows points to **L212**

### 17.4 Tenancy

| Ref | Criterion |
|---|---|
`LCM-AC-022` | Every read applies the tenant scope server-side before any filter, search, sort or page
`LCM-AC-023` | No API accepts a tenant parameter
`LCM-AC-024` | No cross-tenant participant fact, count, comparison or existence check is obtainable
`LCM-AC-025` | Tenant isolation is inherited structurally, not implemented as an application-layer filter

### 17.5 Events, signals and permissions

| Ref | Criterion |
|---|---|
`LCM-AC-026` | A1 emits zero events; the membership register still holds exactly **seven**
`LCM-AC-027` | No suspended, frozen or restored participation state exists
`LCM-AC-028` | Exclusion is driven solely by `safety.EnforcementActionTaken`
`LCM-AC-029` | Suppression is driven solely by `tenancy.TenantSuspended`
`LCM-AC-030` | Membership lapse and renewal are handled with **no event consumption at all**
`LCM-AC-031` | Zero permission identifiers are introduced; the catalogue still holds zero entries
`LCM-AC-032` | Zero roles are introduced; the role set still holds five
`LCM-AC-033` | The word *Staff* appears nowhere as an actor or role

### 17.6 Authorization, gating and consent

| Ref | Criterion |
|---|---|
`LCM-AC-034` | No participation capability activates for a person requiring guardian consent where no consent record exists, **including where minor status is `Unknown`**
`LCM-AC-035` | Every role in the closed set of five has an explicit, stated treatment; no treatment relies on inheritance
`LCM-AC-036` | `TR-3` Reception is denied, and the denial is recorded as interim under `AP-3` with the Product Owner named
`LCM-AC-037` | The surface is absent when `LCFG-5` is Disabled, which is the default, and no data is deleted
`LCM-AC-038` | The gate is read through the `BC-25` typed accessor; no raw string lookup exists
`LCM-AC-039` | No configuration parameter is created, renamed, re-defaulted or re-scoped; no `LCFG-*` value changes
`LCM-AC-040` | A1 is unreachable anonymously, publicly, and through the discovery index

### 17.7 Declared unwritable

| Ref | Criterion | Status |
|---|---|---|
`LCM-AC-041` | *"A membership expiring on date D is in force on the first day of the protected window and out of force on the day after the window."* | ⛔ **UNWRITABLE.** `W₀` unresolved — `ADR-0036` §8.2 q2. Owner: **Product Owner**. Tracked as `LCM-GAP-001` |

`LCM-FR-045` — `LCM-AC-041` **MUST NOT** be recorded as passing, waived, or approximated while `W₀` is unresolved. `TSF-FR-141` and `SID-4.56` establish the discipline.

### 17.8 Criteria deferred for want of a harness

`LCM-FR-046` — Any acceptance criterion requiring fault injection or an integration harness **MUST NOT** be written against a harness that does not exist. **No `integration_test/` directory exists in this repository.** Two consequences:

| Ref | Criterion | Status |
|---|---|---|
`LCM-AC-042` | Fail-closed behaviour under projection unavailability is verified under fault injection | ⏸ **DEFERRED** — prerequisite: an integration harness. Tracked as `LCM-GAP-005` |
`LCM-AC-043` | Fail-closed behaviour under signal-stream unavailability is verified under fault injection | ⏸ **DEFERRED** — same prerequisite |

**Register totals: 43 acceptance criteria — 40 verifiable now, 1 unwritable, 2 deferred. Nothing is recorded as passing.**

---
## 18. Risks

`LCM-RSK-001` … `LCM-RSK-015`.

Rating scale: likelihood × impact, each Low / Medium / High.

ID | Risk | L | I | Mitigation in this document
---|---|---|---|---
`LCM-RSK-001` | The three-day protected renewal window's first day is undefined, so two implementations could differ by one day | High | High | `LCM-FR-041` fails closed on the ambiguous day; `LCM-AC-041` is declared unwritable rather than guessed; escalated as `LCM-GAP-001` / `LCM-DEC-001`
`LCM-RSK-002` | A reader mistakes this read composition for a bounded context and mints a `BC-` identifier | Medium | High | §3, §4 and `LCM-INV-001` state the `AR-1` classification three times; `LCM-XC-001` excludes it explicitly
`LCM-RSK-003` | An implementer adds a `MembershipSuspended` event because the derivation from safety and tenancy signals reads as indirect | Medium | High | `LCM-XC-013`, `LCM-XC-014`, `LCM-SIG-006`, `LCM-SIG-007` name the two source signals; `MM-BR-035` is cited as the closing authority
`LCM-RSK-004` | Reusing `LCFG-5` couples the participation gate to the member directory, so a library that wants one but not the other cannot express it | High | Medium | Disclosed as `LCM-GAP-003` with its exact governance cost measured (one Rank 3 amendment, no ADR); V1 accepts the coupling for leanness
`LCM-RSK-005` | A cached participation decision outlives the membership that justified it | Medium | High | `LCM-BR-013`, `LCM-INV-015` and `LCM-RM-021` forbid caching an authorisation decision, on the `LCFG-13` precedent
`LCM-RSK-006` | Projection lag lets a lapsed member act for up to the staleness bound | High | Medium | Bounded by `MM-BR-012` (< 5s) and surfaced by `LCM-OBS-001`; `LCM-FR-039` makes the stale read fail closed once the bound is exceeded
`LCM-RSK-007` | A cross-tenant read escapes through a filter applied after the query | Medium | High | `LCM-FR-017` requires the tenant predicate server-side *before* any other filter, on the `LMD-8` precedent; `LCM-INV-003`
`LCM-RSK-008` | Participation is read as conferring authority over library operations | Medium | High | §3 non-ownership, `LCM-INV-006`, and the `LMD-24` / `24a` / `24b` precedent
`LCM-RSK-009` | A minor participates without the `ID-6` consent gate being consulted | Low | High | `LCM-INV-008` extends the gate to `Unknown` minor status on the `SM-INV-3` authority
`LCM-RSK-010` | Any part of the surface becomes publicly reachable | Low | High | `LCM-AUTH-002`, `LCM-INV-004`, and the `14B` L173 tenant-private precedent; `LCM-API-004`
`LCM-RSK-011` | The document is filed under `social-graph/` and that is later read as the architecture placement | High | Medium | The provenance block states in five bullets that the directory is a filing convention only; `LCM-GAP-004` / `LCM-DEC-005` remain open
`LCM-RSK-012` | Scope creep pulls feed, moderation, groups or messaging into A1 | Medium | High | §19 excludes 27 items by name, each with the owning module or version that holds it
`LCM-RSK-013` | The `Proposed` ADR required by `LCM-ADR-001` is never raised, so implementation proceeds unclassified | Medium | High | `ADR-INDEX.md` L143 requires the ADR *before implementation*; `LCM-CHK-001` places it first in the checklist
`LCM-RSK-014` | Two ranges of identifiers drift because §24 and §44 report different totals | Medium | Low | §44 carries an explicit supersession sentence naming §24
`LCM-RSK-015` | Absence of an integration harness leaves the two fail-closed criteria permanently unverified | High | Medium | `LCM-AC-042` / `043` are marked DEFERRED, not passing; `LCM-GAP-005` records the missing prerequisite

---

## 19. Exclusions

`LCM-XC-001` … `LCM-XC-027`. Each names where the excluded thing actually lives.

ID | Excluded from A1 | Held instead by
---|---|---
`LCM-XC-001` | A new bounded context or `BC-` identifier | `AR-1`; the count remains 31 (23 in V1)
`LCM-XC-002` | Public or private community objects | `BC-15`, **V2** (`MP-SCOPE-04`)
`LCM-XC-003` | A community feed | Enterprise Architecture L967-973, **V2**
`LCM-XC-004` | Community roles | Enterprise Architecture L967-973, **V2**
`LCM-XC-005` | Community moderation | Enterprise Architecture L967-973, **V3**
`LCM-XC-006` | Community analytics | Enterprise Architecture L967-973, **V3**
`LCM-XC-007` | Study groups | Enterprise Architecture L976-982, **V2**
`LCM-XC-008` | Messaging, threads, or any send path | `BC-12`; enforcement already lives in `lib/domain/social/messaging/`
`LCM-XC-009` | Follow, friend, or any social edge | `BC-11`
`LCM-XC-010` | Content creation, posts or comments | `PRD-020` / `BC-15`, later versions
`LCM-XC-011` | Reporting, appeals, enforcement decisions | `PRD-020` (Trust & Safety) — A1 only *consumes* the outcome
`LCM-XC-012` | Any new integration edge | `MM-BR-006`'s ten-edge allowlist is unchanged; A1 uses existing `E-02`
`LCM-XC-013` | A `MembershipSuspended` event | Does not exist; `MM-BR-035` closes the register at seven
`LCM-XC-014` | A `MembershipRestored` event | Does not exist; same authority
`LCM-XC-015` | A `Suspended` membership state | `MM-FR-072`'s six states contain none
`LCM-XC-016` | A `Frozen` membership state in V1 | `MM-FR-073`
`LCM-XC-017` | Any new membership event of any name | `MM-BR-035`
`LCM-XC-018` | A new `PERM-*` permission | `AUTH-7.22` closes the catalogue; `ADR-0036` §7.1 measured zero repository-wide
`LCM-XC-019` | A new tenant role | `TR-1` … `TR-5` is closed (L87)
`LCM-XC-020` | A default role assignment | `AUTH-7.21`
`LCM-XC-021` | Role inheritance | `AUTH-7.10`
`LCM-XC-022` | A new `LCFG-*` parameter in V1 | `LCFG-1` … `LCFG-13` is the register; A1 reuses `LCFG-5`
`LCM-XC-023` | A `community` context in `tool/module_dependencies.yaml` | `domain/social` declares graph, messaging, safety only — and a read composition needs no manifest context
`LCM-XC-024` | A `domain/library` import from `domain/social` | `X-05`; the manifest bans it
`LCM-XC-025` | A `PersonId` link other than through the `E-13` ACL | Dependency Matrix L354
`LCM-XC-026` | Multiple simultaneous library memberships | Enterprise Architecture L913, **V2**
`LCM-XC-027` | Any answer to `ADR-0036` §8.2 question 2 | Reserved to the Product Owner by name

---

## 20. Declared gaps

`LCM-GAP-001` … `LCM-GAP-005`.

ID | Gap | Blocking? | Owner | Cost to close
---|---|---|---|---
`LCM-GAP-001` | The first day of the three-day protected renewal window is undefined (`ADR-0036` §8.2 q2) | ⛔ **YES — the only blocker** | Product Owner | An answer recorded in `ADR-0036`; no new ADR
`LCM-GAP-002` | Final architecture placement of A1 is not recorded in any register | No | Governance Owner | One `PRD_REGISTRY.md` §4.2 row
`LCM-GAP-003` | The participation gate reuses `LCFG-5` rather than owning a parameter | No | Product | One Rank 3 amendment to `Library_PRD_v1.md` (measured: it is "Approved — authoritative", **not frozen**); no ADR, per `CONFIGURATION_GUIDE.md` L863
`LCM-GAP-004` | The directory this file sits in is a filing convention, not a placement decision | No | Owner | A `git mv` plus the `LCM-GAP-002` row
`LCM-GAP-005` | No `integration_test/` harness exists, so `LCM-AC-042` / `043` cannot be executed | No | Engineering | Create the harness; out of A1's scope

`LCM-FR-048` — A1 SHALL NOT be implemented while `LCM-GAP-001` is open, because the protected-window boundary determines a deny decision and `LCM-FR-041`'s fail-closed default is a disclosed interim, not a specification.

---

## 21. ADR requirements

`LCM-ADR-001`, `LCM-ADR-002`.

ID | Requirement | Status | Why
---|---|---|---
`LCM-ADR-001` | An ADR recording that library-community participation is an application / read-composition capability of the Library domain under `AR-1`, owning no aggregate, no invariant, no business state, and receiving no `BC-` identifier | **Required, `Proposed`** | `ADR-INDEX.md` L143 requires an ADR before implementation for a classification of this kind; the `AR-1` precedent supplies the reasoning, so the ADR records rather than decides
`LCM-ADR-002` | An ADR **is not required** for consuming `E-02`, for deriving exclusion from `safety.EnforcementActionTaken` and `tenancy.TenantSuspended`, or for reusing `LCFG-5` | **Not required** | `E-02` is already in `MM-BR-006`'s allowlist and already obliged by `MM-BR-011`; `TSF-FR-029` states expressly that consuming the safety outcome needs no amendment; reusing an existing parameter is not a configuration act under `CONFIGURATION_GUIDE.md` L863

`LCM-FR-049` — The ADR number for `LCM-ADR-001` SHALL be allocated by the Governance Owner. This document SHALL NOT mint one.

`LCM-FR-050` — `LCM-ADR-001` SHALL be raised with status `Proposed` and SHALL NOT be self-accepted.

`LCM-FR-051` — No ACCEPTED ADR is amended, superseded, weakened or re-scoped by this document.

---

## 22. Architecture consistency audit — the eleven conflicts

Every conflict carried from draft v0.1, with its disposition and its governance cost.

\# | Conflict as stated in v0.1 | Disposition in v0.2 | Cost
---|---|---|---
`C-1` | A1 wanted a V1 bounded context, but `BC-15` (Community) is **V2** per `MP-SCOPE-04` | ✅ **RESOLVED** — `AR-1` applied. A1 is a read composition, takes no `BC-`, and `BC-15` stays exactly where `MASTER_PRD.md` put it | One `Proposed` ADR (`LCM-ADR-001`)
`C-2` | `PRD-021` is registered against `BC-11`, `BC-12` only (`PRD_REGISTRY.md` L321) | ✅ **RESOLVED** — A1 recommends the **library** cluster; L321 is not edited | One registry row, deferred to the Governance Owner (`LCM-GAP-002`)
`C-3` | A V2 `BC-15` may hold no tenant key under `ID-2` | ✅ **DISSOLVED** — the tenant key is native to the library cluster, where A1 now sits | Zero
`C-4` | No Library → Community integration edge exists, and `X-05` prohibits the import | ✅ **DISSOLVED** — no such edge is needed. `E-02` already exists in `MM-BR-006`'s allowlist and `MM-BR-011` already obliges the publication | Zero
`C-5` | v0.1 coined `MembershipHolder` and `AccessRole` against fixed vocabulary | ✅ **RESOLVED** — both coined terms removed; §5 uses only existing terms | Zero
`C-6` | `tool/module_dependencies.yaml` declares no `community` context | ✅ **DISSOLVED** — a read composition is not a manifest context; Dashboards and the Parent Portal set the precedent | Zero
`C-7` | v0.1 required two events that do not exist, against a register `MM-BR-035` closes at seven, plus a `Suspended` state `MM-FR-072` does not have | ✅ **RESOLVED** — exclusion derived from `safety.EnforcementActionTaken` and `tenancy.TenantSuspended`; lapse derived from the projection with **no event at all**, on the `LMD-16` precedent | Zero — **no frozen amendment**
`C-8` | `ADR-0036` §8.2 question 2 leaves the protected window's first day undefined | ⛔ **OPEN — escalated** as `LCM-GAP-001` / `LCM-DEC-001`. Window stated parametrically; ambiguous day fails closed; the acceptance criterion is declared unwritable | Awaiting the Product Owner
`C-9` | The permission catalogue is closed at zero entries and there is no Staff role to hang a grant on | ✅ **RESOLVED** — capabilities are *derived at evaluation time* from membership validity, never granted. Minting a permission would create a capability `AP-3` keeps permanently unreachable | Zero
`C-10` | "Library" was ambiguous between organisation, branch and tenant | ✅ **RESOLVED** — the grain is fixed at `TenantOrganisation` (§5) | Zero
`C-11` | `PRD-020` / `PRD-021` ordering appeared to block A1 | ✅ **EVAPORATED** — A1 contains no content and no moderation, so no ordering dependency arises | Zero

### 22.1 Net governance cost of A1

Item | Count
---|---
FROZEN PRD amendments | **0**
ACCEPTED ADR amendments | **0**
Rank 1–5 artefact amendments | **0**
New bounded contexts | **0**
New integration edges | **0**
New events | **0**
New permissions | **0**
New roles | **0**
New `LCFG-*` parameters | **0**
New `Proposed` ADRs | **1**
New registry rows | **1** (deferred to the Governance Owner)
Blocking decisions escalated | **1**

### 22.2 Assertions this audit does **not** make

- It does not assert that `LCM-ADR-001` will be accepted.
- It does not assert that the recommended library-cluster placement has been approved.
- It does not assert that any acceptance criterion passes.
- It does not assert an answer to `ADR-0036` §8.2 question 2.
- It does not assert that reusing `LCFG-5` is the permanent answer; `LCM-GAP-003` says otherwise.

---

## 23. Traceability

Every A1 requirement traces to an existing authority. No requirement rests on an assertion made only here.

A1 element | Traces to
---|---
`LCM-INV-001` (no bounded context) | `AR-1` §23; `PRD_REGISTRY.md` L389
`LCM-INV-002` (no aggregate, no business state) | `AR-1`; `LMD-1`
`LCM-INV-003`, `LCM-FR-017` (tenant predicate first) | `LMD-8`; `ID-2`
`LCM-INV-004`, `LCM-AUTH-002` (never public) | `LMD-7`; `14B` L173
`LCM-INV-005` (no status vocabulary of its own) | `LMD-3`; `MM-FR-072`
`LCM-INV-006` (confers no authority) | `LMD-24`, `24a`, `24b`
`LCM-INV-008` (minor consent, incl. `Unknown`) | `ID-6`; `SM-INV-3`; `AP-3`
`LCM-RM-001` … `015` (read via projection) | `LMD-16`; `MM-BR-011`; `E-02`
`LCM-RM-012` (staleness bound) | `MM-BR-012` (< 5s)
`LCM-RM-021`, `LCM-BR-013` (no cached authorisation) | `LCFG-13` — "never applies to an authorization decision"
`LCM-AUTH-001` (derived capability) | `AUTH-7.22`; `AP-3`; `ADR-0036` §7.1
`LCM-AUTH-003` (deny defeats allow) | `XC-7.2`
`LCM-CFG-002` (gate default Disabled) | `LCFG-5`; `AP-3`; `LMD-4`
`LCM-SIG-006` (exclusion on enforcement) | `safety.EnforcementActionTaken`; `TSF-FR-029`
`LCM-SIG-007` (exclusion on tenant suspension) | `tenancy.TenantSuspended`
`LCM-SIG-008` (projection shape) | `lib/domain/social/messaging/enforcement_projection.dart`
`LCM-FR-036` … `044` (renewal window) | `ADR-0036` q1 (3 calendar days, mandatory V1), q3 (FIXED), §6.4 (calendar reuse)
`LCM-FR-041` (fail closed on the ambiguous day) | `AP-3`; the `SM-8.4a` interim-deny precedent (`ADR-0018` L162)
§3 ownership disclaimer | `14A` §14A.1, verbatim pattern
`LCM-XC-002` … `007` (community deferrals) | `MP-SCOPE-04`; Enterprise Architecture L967-973
`LCM-XC-024`, `LCM-XC-025` | `X-05`; Dependency Matrix L354
`LCM-ADR-001` | `ADR-INDEX.md` L143

---

## 24. Register summary — interim

State of the registers at the end of §0–§27.

Register | Range | Count
---|---|---
Functional requirements | `LCM-FR-001` … `LCM-FR-051` | 50 — see the note below
Business rules | `LCM-BR-001` … `LCM-BR-012` | 12
Invariants | `LCM-INV-001` … `LCM-INV-014` | 14
Read model | `LCM-RM-001` … `LCM-RM-015` | 15
Authorization | `LCM-AUTH-001` … `LCM-AUTH-010` | 10
Configuration | `LCM-CFG-001` … `LCM-CFG-008` | 8
Signals | `LCM-SIG-001` … `LCM-SIG-009` | 9
API | `LCM-API-001` … `LCM-API-011` | 11
Non-functional | `LCM-NFR-001` … `LCM-NFR-008` | 8
Acceptance criteria | `LCM-AC-001` … `LCM-AC-043` | 43
Risks | `LCM-RSK-001` … `LCM-RSK-015` | 15
Exclusions | `LCM-XC-001` … `LCM-XC-027` | 27
Gaps | `LCM-GAP-001` … `LCM-GAP-005` | 5
ADR requirements | `LCM-ADR-001` … `LCM-ADR-002` | 2
**Total** | — | **229 identifiers across 14 registers**

⚠ This is an **interim** count taken at §27. It is superseded by §44.

⚠ **Measured discrepancy, disclosed rather than papered over.** The functional-requirement
register skips exactly one number — the one immediately after `LCM-FR-046`. §17 ends at
`LCM-FR-046` and §20 resumes at `LCM-FR-048`, so that intervening number is never assigned.
It is deliberately **not written out anywhere in this document**, because reproducing an
unassigned identifier in prose is exactly what makes a phantom look defined to a grep-based
or automated continuity check. The skip is carried from the source delivery. It has **not** been closed by
inventing a requirement to occupy the number, because that would add scope; and it has **not**
been closed by renumbering, because every later reference would then have to move. The register
is therefore **contiguous except for that single unassigned number**, the counts here and at §44 are stated as
*measured* rather than as *implied by the range*, and closing the skip is left as a numbering
correction for a later revision of this draft.

---

## 25. Identifier mapping from draft v0.1

v0.1 identifier | v0.2 outcome
---|---
`A1-BC-15-SCOPE` | Withdrawn — replaced by the `AR-1` classification (§4)
`A1-EVT-SUSPENDED` | **Removed** — the event does not exist (`MM-BR-035`); replaced by `LCM-SIG-006`
`A1-EVT-RESTORED` | **Removed** — same; replaced by `LCM-SIG-006`
`A1-STATE-SUSPENDED` | **Removed** — `MM-FR-072` has no such state
`A1-TERM-MEMBERSHIPHOLDER` | **Removed** — coined term; §5 uses existing vocabulary
`A1-TERM-ACCESSROLE` | **Removed** — coined term
`A1-PERM-PARTICIPATE` | **Removed** — replaced by derived capability `LCM-AUTH-001`
`A1-ROLE-STAFF` | **Removed** — `TR-1` … `TR-5` is closed
`A1-EDGE-LIB-COMM` | **Removed** — `E-02` already exists
`A1-CFG-PARTICIPATION` | Deferred — reuses `LCFG-5`; disclosed as `LCM-GAP-003`
`A1-FR-001` … `A1-FR-022` | Carried forward, renumbered into `LCM-FR-*` with citations added
`A1-EDGE-CASE-1` … `18` | Carried forward and extended to 26 in §16, then to 46 in §34
`A1-AC-001` … `A1-AC-019` | Carried forward and extended into `LCM-AC-*`

---

## 26. What this document does not do

- It does not create a bounded context, and no `BC-` identifier is claimed.
- It does not create an integration edge, an event, a permission, a role, or a configuration parameter.
- It does not amend `PRD-004`, `PRD-005`, or `PRD-007`.
- It does not amend any Rank 1–5 artefact.
- It does not override or weaken any ACCEPTED ADR.
- It does not answer `ADR-0036` §8.2 question 2.
- It does not record any acceptance criterion as passing.
- It does not advance any lifecycle stage.
- It does not freeze, finalise, approve or baseline anything.
- It does not begin Part A2.

---

## 27. Changelog

Version | Change
---|---
**v0.2** | Corrected draft. `AR-1` classification adopted; `BC-15` left at V2; the two invented membership events, the invented `Suspended` state, the coined vocabulary, the invented permission, the invented role and the invented integration edge all removed; exclusion re-derived from existing safety and tenancy signals; `E-02` / `MembershipValidity` reuse made explicit on the `LMD-16` and `MM-BR-011` authorities; the `ID-6` minor-consent gate added and extended to `Unknown` minor status; `LCFG-5` reuse adopted with its cost disclosed; the protected-window boundary left explicitly unresolved with a fail-closed interim and an unwritable acceptance criterion; V1 scope reduced.
**v0.1** | Initial draft, 27 sections, chat-only. Eleven conflicts identified. §27.2 recorded the correction of the draft's own conflict count in the open.

---
## 28. Read model — remaining consistency rules

`LCM-RM-016` … `LCM-RM-028`, plus `LCM-BR-013`, `LCM-INV-015`, `LCM-INV-016`.

ID | Rule | Authority
---|---|---
`LCM-RM-016` | The participation read model SHALL be derived exclusively from the `MembershipValidity` projection delivered over `E-02`. It SHALL hold no independently-authored membership fact. | `LMD-16`; `MM-BR-011`
`LCM-RM-017` | The read model SHALL be keyed by (`tenantId`, `PersonId`). No other key is permitted. | `ID-2`; `LMD-8`
`LCM-RM-018` | The read model SHALL NOT store a `PersonId` obtained by any route other than the `E-13` ACL. | `X-05`; Dependency Matrix L354
`LCM-RM-019` | The read model SHALL be rebuildable from the projection alone, with no local state required for correctness. | `LMD-1`; the `rebuildFrom` pattern in `lib/domain/social/messaging/enforcement_projection.dart`
`LCM-RM-020` | A rebuild SHALL be idempotent — replaying the same projection state twice SHALL yield the same read model. | Same pattern
`LCM-RM-021` | No participation authorisation decision SHALL be cached. Cache TTLs MAY apply to descriptive payloads only. | `LCFG-13` — "**never** applies to an authorization decision"
`LCM-RM-022` | A descriptive payload cached under `LCM-RM-021` SHALL NOT include any field from which validity could be inferred. | `LCFG-13`; `LCM-INV-015`
`LCM-RM-023` | The read model SHALL expose validity as a computed boolean at read time, not as a stored flag. | `LMD-3`; `LCM-INV-005`
`LCM-RM-024` | Projection lag SHALL be observable as a duration, on the shape already used by the messaging enforcement projection. | `projectionLag` / `_observeLag` in `enforcement_projection.dart`
`LCM-RM-025` | When observed lag exceeds the `MM-BR-012` bound, reads SHALL be treated as unavailable rather than stale-but-usable. | `MM-BR-012`; `AP-3`
`LCM-RM-026` | The read model SHALL NOT be the source of any membership write. A1 issues no membership command of any kind. | §3; `MM-FR-112`
`LCM-RM-027` | The read model SHALL NOT retain a record for a `PersonId` whose tenancy association has ended. | `LCM-SIG-007`; `ID-2`
`LCM-RM-028` | Read-model contents SHALL NOT be exported, replicated or shared across tenants under any circumstance. | `LMD-7`; `LMD-8`; `14B` L173

`LCM-BR-013` — A participation decision is valid only at the instant it is computed. Reuse of a previous decision is prohibited.

`LCM-INV-015` — At no point does a stored artefact of A1 constitute an authorisation decision.

`LCM-INV-016` — The read model contains no fact that is not derivable from `E-02` plus the tenant context.

---

## 29. Access evaluation

`LCM-AUTH-011` … `LCM-AUTH-018`.

The evaluation order is fixed. Each step can only deny; none can grant.

Step | ID | Check | Outcome if it fails
---|---|---|---
1 | `LCM-AUTH-011` | An authenticated principal is present | Deny — unauthenticated
2 | `LCM-AUTH-012` | A single resolved `tenantId` is present in server-side context | Deny — no tenant context
3 | `LCM-AUTH-013` | The participation gate is Enabled for that tenant | Deny — capability disabled
4 | `LCM-AUTH-014` | The `E-02` projection is available and within the `MM-BR-012` staleness bound | Deny — fail closed
5 | `LCM-AUTH-015` | `MembershipValidity` reports the principal valid for that tenant, or valid under the protected renewal window | Deny — not a valid member
6 | `LCM-AUTH-016` | No safety exclusion is in force for that principal | Deny — excluded
7 | `LCM-AUTH-017` | If minor status is `true` **or `Unknown`**, the `ID-6` consent gate reports consent present | Deny — consent gate closed
8 | `LCM-AUTH-018` | The requested action is within the derived capability set for a valid member | Deny — outside derived capability

`LCM-AUTH-018` note — the derived capability set is computed, never granted. No `PERM-*` is read, written or minted, because `AUTH-7.22` closes the catalogue and `AP-3` would keep any new entry unreachable.

Evaluation properties:

- The order is normative. Step 2 precedes every data access, per `LCM-FR-017`.
- Any single denial is final. There is no allow that overrides a deny (`XC-7.2`).
- An indeterminate result at any step is a denial, not a retry-and-allow (`AP-3`).

---

## 30. Configuration gate

`LCM-CFG-009` … `LCM-CFG-014`, plus `LCM-INV-017`.

ID | Rule | Authority
---|---|---
`LCM-CFG-009` | In V1 the participation gate SHALL reuse the existing `LCFG-5` member-directory parameter. No new parameter is declared. | `CONFIGURATION_GUIDE.md` §2A; `LCM-XC-022`
`LCM-CFG-010` | The gate default SHALL be **Disabled**, matching `LCFG-5`'s own default and its stated reason — deny by default under `AP-3`. | `LCFG-5`; `AP-3`
`LCM-CFG-011` | The gate SHALL be resolved per library, consistent with `CONFIGURATION_GUIDE.md` L829. | L829
`LCM-CFG-012` | A missing, unreadable or indeterminate gate value SHALL be treated as Disabled. | `AP-3`
`LCM-CFG-013` | Enabling the gate SHALL NOT grant any capability by itself; it only removes a prohibition. Validity is still required. | `LCM-AUTH-013`; `LMD-4`
`LCM-CFG-014` | The coupling of the participation gate to the member directory is a **disclosed V1 simplification**, not a design conclusion. Its removal costs one Rank 3 amendment to `Library_PRD_v1.md` and no ADR. | `CONFIGURATION_GUIDE.md` L863; `Library_PRD_v1.md` status "Approved — authoritative", not frozen; `LCM-GAP-003`

`LCM-INV-017` — A1 declares no `LCFG-*` identifier. The register remains `LCFG-1` … `LCFG-13`.

---

## 31. Signals — remaining

`LCM-SIG-010` … `LCM-SIG-014`, plus `LCM-XC-028`, `LCM-XC-029`.

ID | Rule | Authority
---|---|---
`LCM-SIG-010` | A1 SHALL consume signals only. It SHALL publish none. | `LMD-1`; `MM-BR-035`
`LCM-SIG-011` | Signal consumption SHALL be idempotent — redelivery SHALL NOT change the derived state. | `enforcement_projection.dart` rebuild semantics
`LCM-SIG-012` | Signal ordering SHALL NOT be assumed. Derived state SHALL be a function of the latest known values, not of arrival order. | Same
`LCM-SIG-013` | A signal for an unknown `tenantId` or an unknown `PersonId` SHALL be discarded without error and without creating a record. | `ID-2`; `LCM-RM-017`
`LCM-SIG-014` | Loss of the signal stream SHALL cause denial, never a fallback to a last-known-good allow. | `AP-3`; `LCM-AUTH-014`
`LCM-XC-028` | A1 publishes no domain event. | `MM-BR-035`; `LMD-1`
`LCM-XC-029` | A1 declares no new subscriber contract on any existing publisher. | `TSF-FR-029` — the safety consumer set is already declared

---

## 32. API specification

`LCM-API-012` … `LCM-API-024`.

All endpoints are authenticated, tenant-scoped, and read-only.

ID | Rule
---|---
`LCM-API-012` | Every endpoint SHALL require an authenticated principal. There is no anonymous variant.
`LCM-API-013` | Every endpoint SHALL resolve `tenantId` server-side. A client-supplied tenant identifier SHALL be rejected, not honoured.
`LCM-API-014` | No endpoint SHALL accept a write. A1 exposes no mutation.
`LCM-API-015` | Responses SHALL contain no membership status vocabulary. Only a computed participation boolean and descriptive fields are returned.
`LCM-API-016` | Responses SHALL contain no financial field, no payment field and no invoice reference.
`LCM-API-017` | Responses SHALL contain no `PersonId` obtained outside the `E-13` ACL.
`LCM-API-018` | Page size SHALL be bounded. In V1 the bound SHALL reuse the existing public-search page-size convention rather than declaring a new parameter.
`LCM-API-019` | A denial SHALL return an indistinguishable response for "not a member", "excluded" and "gate disabled", so that the response does not leak which condition applied.
`LCM-API-020` | A denial SHALL NOT reveal whether the requested `PersonId` exists in the tenant.
`LCM-API-021` | Projection unavailability SHALL surface as a service-unavailable condition, distinct from a denial, and SHALL NOT be retried into an allow.
`LCM-API-022` | No endpoint SHALL be reachable without the gate being Enabled; when Disabled the surface SHALL behave as if it does not exist.
`LCM-API-023` | Every response SHALL be safe to render for a minor, since a minor who reaches the surface has already passed the `ID-6` gate.
`LCM-API-024` | No endpoint SHALL set a cache header that would permit an authorisation decision to be reused. Descriptive payload caching only.

---

## 33. Security

`LCM-SEC-001` … `LCM-SEC-020`, plus `LCM-BR-014`, `LCM-BR-015`, `LCM-INV-018`.

ID | Requirement
---|---
`LCM-SEC-001` | Deny by default. Absence of an explicit basis to allow is a refusal (`AP-3`).
`LCM-SEC-002` | The tenant predicate SHALL be applied server-side before any other predicate (`LMD-8`).
`LCM-SEC-003` | No surface of A1 SHALL be publicly reachable (`LMD-7`; `14B` L173).
`LCM-SEC-004` | Authorisation SHALL be required in addition to authentication, never as a consequence of it (`14B` L231).
`LCM-SEC-005` | Cross-tenant reads SHALL be impossible by construction, not merely filtered.
`LCM-SEC-006` | Participation SHALL confer no authority over library operations (`LMD-24`, `24a`, `24b`).
`LCM-SEC-007` | No permission SHALL be minted (`AUTH-7.22`).
`LCM-SEC-008` | No role SHALL be minted or reassigned (`TR-1` … `TR-5` closed; `AUTH-7.21`).
`LCM-SEC-009` | No role inheritance SHALL be assumed (`AUTH-7.10`).
`LCM-SEC-010` | A deny SHALL defeat any allow in the same evaluation (`XC-7.2`).
`LCM-SEC-011` | Minor participation SHALL pass the `ID-6` consent gate, including when minor status is `Unknown` (`SM-INV-3`).
`LCM-SEC-012` | An excluded principal SHALL be denied for the duration of the exclusion, with no partial surface remaining.
`LCM-SEC-013` | A tenant-suspended principal SHALL be denied entirely.
`LCM-SEC-014` | Enumeration of members SHALL be bounded by page size and SHALL be denied outright when the gate is Disabled.
`LCM-SEC-015` | Denial responses SHALL be uniform so that they do not disclose the reason (`LCM-API-019`).
`LCM-SEC-016` | Projection unavailability SHALL fail closed (`LCM-AUTH-014`).
`LCM-SEC-017` | Signal-stream unavailability SHALL fail closed (`LCM-SIG-014`).
`LCM-SEC-018` | No authorisation decision SHALL be cached (`LCFG-13`).
`LCM-SEC-019` | No financial data SHALL be readable through A1 (`AC-7.8` precedent for a financial deny).
`LCM-SEC-020` | A1 SHALL NOT weaken any control that any other module already applies to the same data.

`LCM-BR-014` — Every A1 denial path is a *closed* default, and each is traceable to `AP-3` or to a named frozen rule.

`LCM-BR-015` — A1 introduces no new attack surface beyond a tenant-private authenticated read that already exists for the member directory.

`LCM-INV-018` — There is no code path in A1 that produces an allow from an indeterminate input.

---

## 34. Extended edge cases

Cases 27–46, continuing the list at §16.

\# | Situation | Required behaviour
---|---|---
27 | Gate Enabled, membership valid, projection lag beyond the bound | Deny — projection treated as unavailable (`LCM-RM-025`)
28 | Gate Disabled, membership valid | Deny — surface behaves as absent (`LCM-API-022`)
29 | Gate value missing entirely | Deny — treated as Disabled (`LCM-CFG-012`)
30 | Gate flipped Enabled → Disabled mid-session | Next evaluation denies; no grandfathering (`LCM-BR-013`)
31 | Membership lapses mid-session | Next evaluation denies; no session-scoped grace
32 | Membership renewed within the protected window, boundary day ambiguous | Deny on the ambiguous day (`LCM-FR-041`), pending `LCM-GAP-001`
33 | Membership renewed, window unambiguously inside | Allow
34 | Safety exclusion arrives while a request is in flight | The in-flight request may complete; the next evaluation denies
35 | Safety exclusion lifted | Next evaluation allows if all other steps pass; no restoration event is consumed (`LCM-XC-014`)
36 | Tenant suspended | Deny for every principal of that tenant (`LCM-SEC-013`)
37 | Tenant suspension lifted | Evaluation resumes normally; no restoration event exists
38 | Principal is a minor with consent present | Allow if all other steps pass
39 | Principal is a minor with consent absent | Deny (`LCM-AUTH-017`)
40 | Minor status is `Unknown` | Treated as minor; consent gate applies (`SM-INV-3`)
41 | Principal holds memberships in two tenants | Each tenant evaluated independently; no cross-tenant view (`LCM-XC-026`)
42 | Signal for an unknown `PersonId` | Discarded silently; no record created (`LCM-SIG-013`)
43 | Signal redelivered | No change to derived state (`LCM-SIG-011`)
44 | Signals arrive out of order | Latest known values govern (`LCM-SIG-012`)
45 | Read model rebuilt from scratch | Identical result; no local state required (`LCM-RM-019`, `LCM-RM-020`)
46 | Client supplies a `tenantId` in the request | Rejected, not honoured (`LCM-API-013`)

---

## 35. Observability

`LCM-OBS-001` … `LCM-OBS-014`, plus `LCM-INV-019`, `LCM-BR-016`.

ID | Signal to emit | Why
---|---|---
`LCM-OBS-001` | Projection lag, as a duration | Makes the `MM-BR-012` bound measurable rather than assumed
`LCM-OBS-002` | Count of denials by evaluation step | Shows which closed default is actually firing
`LCM-OBS-003` | Count of denials attributable to the ambiguous protected-window day | ⭐ Makes the cost of the open `LCM-GAP-001` an observed operational fact instead of an invisible one
`LCM-OBS-004` | Count of fail-closed denials due to projection unavailability | Detects a silent outage
`LCM-OBS-005` | Count of fail-closed denials due to signal-stream unavailability | Same
`LCM-OBS-006` | Count of denials due to the gate being Disabled | Distinguishes "off" from "broken"
`LCM-OBS-007` | Count of denials due to the `ID-6` consent gate | Confirms the minor path is exercised
`LCM-OBS-008` | Count of denials due to safety exclusion | Confirms the derivation works without a dedicated event
`LCM-OBS-009` | Count of discarded signals for unknown keys | Detects projection / ACL drift
`LCM-OBS-010` | Read-model rebuild duration and outcome | Operational readiness
`LCM-OBS-011` | Count of rejected client-supplied tenant identifiers | Detects probing
`LCM-OBS-012` | Page-size clamp events | Detects enumeration attempts
`LCM-OBS-013` | Gate configuration changes, per library | Change attribution
`LCM-OBS-014` | Count of evaluations completed within the latency budget | Feeds `LCM-NFR-*`

`LCM-INV-019` — No observability signal SHALL contain a `PersonId`, a name, or any other identifying field. Counts and durations only.

`LCM-BR-016` — Observability is a requirement of A1, not an optional extra, because two of A1's controls (fail-closed on projection and the ambiguous-day denial) are otherwise silent.

---

## 36. Performance and reliability

`LCM-NFR-009` … `LCM-NFR-022`, plus `LCM-BR-017`.

ID | Requirement
---|---
`LCM-NFR-009` | An access evaluation SHALL complete within a budget that permits it to run on every request without caching, since caching is prohibited.
`LCM-NFR-010` | Projection staleness SHALL remain within the `MM-BR-012` bound of under five seconds in normal operation.
`LCM-NFR-011` | Exceeding the staleness bound SHALL degrade to denial, not to increased latency.
`LCM-NFR-012` | The read model SHALL be rebuildable within an operationally acceptable window without a maintenance outage of any other module.
`LCM-NFR-013` | A rebuild SHALL not require any write to a membership, identity or safety store.
`LCM-NFR-014` | Evaluation SHALL be O(1) with respect to the number of members in the tenant.
`LCM-NFR-015` | Listing SHALL be bounded by page size and SHALL not permit unbounded enumeration.
`LCM-NFR-016` | Loss of the projection SHALL degrade A1 only. It SHALL NOT impair membership, identity, library or messaging operations.
`LCM-NFR-017` | A1 SHALL hold no lock and no transaction spanning another module.
`LCM-NFR-018` | A1 SHALL be able to start cold with an empty read model and serve denials safely until the projection is warm.
`LCM-NFR-019` | Signal processing SHALL not block request handling.
`LCM-NFR-020` | Signal backlog SHALL be observable and SHALL translate into the staleness measure of `LCM-OBS-001`.
`LCM-NFR-021` | A1 SHALL add no new persistent store that requires its own backup or retention policy beyond the derived read model.
`LCM-NFR-022` | Removing A1 entirely SHALL leave every other module's behaviour unchanged, because A1 owns nothing.

`LCM-BR-017` — A1's availability is strictly bounded above by the availability of the `E-02` projection. It never exceeds it by substituting a local assumption.

---

## 37. V1 scope statement

`LCM-FR-052` … `LCM-FR-060`, plus `LCM-BR-018`, `LCM-XC-030` … `LCM-XC-034`, `LCM-INV-020`.

### 37.1 In V1

ID | Included
---|---
`LCM-FR-052` | A tenant-private, authenticated read that answers whether the calling principal may participate in their library's community surface
`LCM-FR-053` | Derivation of that answer from the existing `MembershipValidity` projection over `E-02`
`LCM-FR-054` | Application of the three-day protected renewal window as a mandatory V1 behaviour, per `ADR-0036` q1
`LCM-FR-055` | Derivation of exclusion from `safety.EnforcementActionTaken`
`LCM-FR-056` | Derivation of exclusion from `tenancy.TenantSuspended`
`LCM-FR-057` | The `ID-6` minor-consent gate, extended to `Unknown` minor status
`LCM-FR-058` | The per-library gate, defaulting to Disabled, reusing `LCFG-5`
`LCM-FR-059` | The fourteen observability signals of §35
`LCM-FR-060` | A bounded, tenant-scoped member listing, subject to the gate

### 37.2 Not in V1

ID | Deferred
---|---
`LCM-XC-030` | Any community object, feed, role, or moderation surface — `BC-15` V2/V3
`LCM-XC-031` | Study groups — V2
`LCM-XC-032` | Multiple simultaneous library memberships — V2
`LCM-XC-033` | A dedicated participation configuration parameter — pending `LCM-GAP-003`
`LCM-XC-034` | Integration-level fault-injection verification — pending `LCM-GAP-005`

`LCM-BR-018` — V1 is deliberately the smallest surface that is useful and safe: one derived read, one gate, two derived exclusions, one consent gate. Anything larger would require an act reserved to another owner.

`LCM-INV-020` — Nothing in V1 requires an amendment to a FROZEN PRD, an ACCEPTED ADR, or a Rank 1–5 artefact.

---
## 38. Given / When / Then

`LCM-GWT-001` … `LCM-GWT-032`, and the acceptance criteria they establish, `LCM-AC-044` … `LCM-AC-060`.

### 38.1 Classification and ownership

ID | Given | When | Then
---|---|---|---
`LCM-GWT-001` | The architecture registers are read | A1 is looked up | No `BC-` identifier is found for it and the context count is 31 (23 in V1)
`LCM-GWT-002` | A1 is deployed | Any membership command is attempted through A1 | It is refused; A1 exposes no mutation
`LCM-GWT-003` | A valid member participates | Their library-operations authority is checked | It is unchanged by participation

### 38.2 Tenancy

ID | Given | When | Then
---|---|---|---
`LCM-GWT-004` | A principal of tenant T1 | They request participation data | Only T1 data is considered, and the tenant predicate was applied before any other
`LCM-GWT-005` | A principal of tenant T1 | They supply `tenantId` = T2 in the request | The request is rejected, not honoured
`LCM-GWT-006` | No resolved tenant context | An evaluation runs | It denies at step 2

### 38.3 The gate

ID | Given | When | Then
---|---|---|---
`LCM-GWT-007` | The gate is at its default | No configuration has been made | The gate is Disabled and every evaluation denies
`LCM-GWT-008` | The gate is Disabled | A valid member requests the surface | The response is indistinguishable from the surface not existing
`LCM-GWT-009` | The gate value is missing or unreadable | An evaluation runs | It is treated as Disabled
`LCM-GWT-010` | The gate is Enabled but the principal is not a valid member | An evaluation runs | It denies; enabling grants nothing by itself
`LCM-GWT-011` | The gate is flipped Enabled → Disabled | The same principal evaluates again | The new evaluation denies, with no grandfathering

### 38.4 Membership validity

ID | Given | When | Then
---|---|---|---
`LCM-GWT-012` | A principal with a valid membership and the gate Enabled | An evaluation runs | It allows
`LCM-GWT-013` | A principal whose membership has lapsed | An evaluation runs | It denies, with no lapse event having been required
`LCM-GWT-014` | A membership lapses mid-session | The next evaluation runs | It denies
`LCM-GWT-015` | The `E-02` projection is unavailable | An evaluation runs | It denies, and the denial is counted under `LCM-OBS-004`
`LCM-GWT-016` | Observed projection lag exceeds the `MM-BR-012` bound | An evaluation runs | The read is treated as unavailable and the evaluation denies

### 38.5 The protected renewal window

ID | Given | When | Then
---|---|---|---
`LCM-GWT-017` | A renewal falls unambiguously inside the three-day window | An evaluation runs | It allows
`LCM-GWT-018` | A renewal falls unambiguously outside the window | An evaluation runs | It denies
`LCM-GWT-019` | A renewal falls on the day whose inclusion `ADR-0036` q2 leaves undefined | An evaluation runs | It **denies**, and the denial is counted under `LCM-OBS-003`
`LCM-GWT-020` | `LCM-GAP-001` is still open | An attempt is made to assert the window's exact first day | No such assertion is available in this document

### 38.6 Exclusion

ID | Given | When | Then
---|---|---|---
`LCM-GWT-021` | A safety enforcement action is in force for a principal | An evaluation runs | It denies, derived from the existing signal with no membership event involved
`LCM-GWT-022` | A safety enforcement action is lifted | The next evaluation runs | It allows if every other step passes, with no restoration event consumed
`LCM-GWT-023` | A tenant is suspended | Any principal of that tenant evaluates | It denies
`LCM-GWT-024` | The signal stream is unavailable | An evaluation runs | It denies rather than falling back to a last-known-good allow

### 38.7 Minors

ID | Given | When | Then
---|---|---|---
`LCM-GWT-025` | A principal is a minor with consent present | An evaluation runs | It allows if every other step passes
`LCM-GWT-026` | A principal is a minor with consent absent | An evaluation runs | It denies
`LCM-GWT-027` | A principal's minor status is `Unknown` | An evaluation runs | They are treated as a minor and the consent gate applies

### 38.8 Read model and API

ID | Given | When | Then
---|---|---|---
`LCM-GWT-028` | The read model is discarded and rebuilt from the projection alone | The same evaluations are repeated | The results are identical
`LCM-GWT-029` | The same projection state is replayed twice | The read model is inspected | It is unchanged after the second replay
`LCM-GWT-030` | Three different denial reasons occur | The three responses are compared | They are indistinguishable to the caller
`LCM-GWT-031` | A response is returned | Its cache directives are inspected | No directive would permit an authorisation decision to be reused
`LCM-GWT-032` | An observability signal is emitted | Its payload is inspected | It contains no `PersonId`, name, or other identifying field

### 38.9 Acceptance criteria established by §38

ID | Criterion | Status
---|---|---
`LCM-AC-044` | `LCM-GWT-001` … `003` pass — classification and non-ownership hold | ☐ Not verified
`LCM-AC-045` | `LCM-GWT-004` … `006` pass — tenancy isolation holds | ☐ Not verified
`LCM-AC-046` | `LCM-GWT-007` … `011` pass — the gate behaves as a closed default | ☐ Not verified
`LCM-AC-047` | `LCM-GWT-012` … `014` pass — validity governs the decision | ☐ Not verified
`LCM-AC-048` | `LCM-GWT-015`, `016` pass — projection unavailability fails closed at the unit level | ☐ Not verified
`LCM-AC-049` | `LCM-GWT-017`, `018` pass — the unambiguous window cases behave correctly | ☐ Not verified
`LCM-AC-050` | `LCM-GWT-019` passes — the ambiguous day denies | ☐ Not verified
`LCM-AC-051` | `LCM-GWT-020` holds — no assertion of the window's first day exists in this document | ☑ Verifiable by inspection of this file
`LCM-AC-052` | `LCM-GWT-021`, `022` pass — exclusion is derived without a dedicated event | ☐ Not verified
`LCM-AC-053` | `LCM-GWT-023` passes — tenant suspension denies | ☐ Not verified
`LCM-AC-054` | `LCM-GWT-024` passes — signal loss fails closed at the unit level | ☐ Not verified
`LCM-AC-055` | `LCM-GWT-025` … `027` pass — the minor gate holds, including `Unknown` | ☐ Not verified
`LCM-AC-056` | `LCM-GWT-028`, `029` pass — rebuild is faithful and idempotent | ☐ Not verified
`LCM-AC-057` | `LCM-GWT-030` passes — denial responses do not leak the reason | ☐ Not verified
`LCM-AC-058` | `LCM-GWT-031` passes — no authorisation decision is cacheable | ☐ Not verified
`LCM-AC-059` | `LCM-GWT-032` passes — observability carries no identifying field | ☐ Not verified
`LCM-AC-060` | All fourteen `LCM-OBS-*` signals are emitted and observable | ☐ Not verified

Nothing above is recorded as passing. A1 is not implemented.

---

## 39. Risks and mitigations — continued

`LCM-RSK-016` … `LCM-RSK-026`.

ID | Risk | L | I | Mitigation
---|---|---|---|---
`LCM-RSK-016` | The evaluation order in §29 is reordered during implementation and the tenant check moves after a data access | Medium | High | `LCM-FR-017` and `LCM-AUTH-012` make the order normative; `LCM-GWT-004` verifies it
`LCM-RSK-017` | A well-meaning optimisation caches the participation decision to meet a latency budget | High | High | `LCM-NFR-009` sets the budget on the *uncached* path precisely so the optimisation is unnecessary; `LCM-SEC-018` prohibits it; `LCM-GWT-031` checks it
`LCM-RSK-018` | Denial responses differentiate by reason for "better UX" | High | Medium | `LCM-API-019`, `LCM-SEC-015`, `LCM-GWT-030`
`LCM-RSK-019` | Observability payloads accumulate identifying fields over time | Medium | Medium | `LCM-INV-019` and `LCM-GWT-032` make it a checked invariant, not a convention
`LCM-RSK-020` | A cold start serves allows before the projection is warm | Low | High | `LCM-NFR-018` requires safe denial while warming
`LCM-RSK-021` | A1's read model becomes a de facto second source of membership truth | Medium | High | `LCM-RM-016`, `LCM-RM-026`, `LCM-INV-016`, `LCM-NFR-022`
`LCM-RSK-022` | The `E-13` ACL is bypassed for convenience when resolving a `PersonId` | Medium | High | `LCM-RM-018`, `LCM-API-017`, `X-05`, Dependency Matrix L354
`LCM-RSK-023` | Page-size bounds are relaxed to serve a large tenant | Medium | Medium | `LCM-NFR-015`, `LCM-SEC-014`, `LCM-OBS-012`
`LCM-RSK-024` | The V1 `LCFG-5` reuse hardens into a permanent decision by inertia | High | Medium | `LCM-CFG-014` labels it a disclosed simplification and states the exact cost of removing it
`LCM-RSK-025` | This draft is mistaken for a frozen artefact after a context loss | Medium | High | Four independent guards: the filename, the provenance freeze-status line, the DRAFT callout, and §0's status row
`LCM-RSK-026` | A2 work is merged into this file, blurring part boundaries | Medium | Medium | §45 fixes A1's boundary explicitly; the provenance block records that A2 has not begun

---

## 40. ADR requirements — consolidated

`LCM-FR-061`, `LCM-FR-062`.

Requirement | Needed? | Basis
---|---|---
Classification of A1 as an `AR-1` read composition (`LCM-ADR-001`) | **Yes — `Proposed`** | `ADR-INDEX.md` L143
Consumption of `E-02` | No | Already in `MM-BR-006`'s allowlist; already obliged by `MM-BR-011`
Derivation of exclusion from the safety outcome | No | `TSF-FR-029` — "no amendment is needed"
Derivation of exclusion from tenant suspension | No | Existing tenancy signal, existing consumer relationship
Reuse of `LCFG-5` | No | Reuse is not a configuration act (`CONFIGURATION_GUIDE.md` L863 concerns *adding* a parameter)
A dedicated participation parameter (future) | No ADR — one Rank 3 PRD amendment | `CONFIGURATION_GUIDE.md` L863; `Library_PRD_v1.md` is not frozen
Answering `ADR-0036` q2 | No new ADR — an answer recorded in the existing ACCEPTED ADR | `ADR-0036` §8.2
The `PRD_REGISTRY.md` placement row | No ADR — a Governance Owner registry act | `LCM-GAP-002`

`LCM-FR-061` — Exactly one new ADR is required for A1, and it is to be raised `Proposed`.

`LCM-FR-062` — No existing ADR is amended, superseded, weakened or re-scoped.

---

## 41. Implementation checklist

`LCM-CHK-001` … `LCM-CHK-030`, plus `LCM-FR-063`. Ordered. Nothing below has been done.

\# | Step | Gate
---|---|---
`LCM-CHK-001` | Obtain the Product Owner's answer to `ADR-0036` §8.2 q2 | ⛔ **Blocking** — `LCM-GAP-001`
`LCM-CHK-002` | Raise `LCM-ADR-001` as `Proposed` | Required before implementation (`ADR-INDEX.md` L143)
`LCM-CHK-003` | Obtain the Governance Owner's placement decision and registry row | `LCM-GAP-002`
`LCM-CHK-004` | Relocate this file to the decided cluster by `git mv` if the recommendation is accepted | `LCM-GAP-004`
`LCM-CHK-005` | Confirm the `E-02` `MembershipValidity` projection contract as published | `MM-BR-011`
`LCM-CHK-006` | Confirm the `E-13` ACL is the only `PersonId` route in the intended design | `X-05`
`LCM-CHK-007` | Implement the tenant-scoped read model keyed (`tenantId`, `PersonId`) | `LCM-RM-017`
`LCM-CHK-008` | Implement rebuild-from-projection, idempotent | `LCM-RM-019`, `LCM-RM-020`
`LCM-CHK-009` | Implement projection-lag measurement on the existing enforcement-projection shape | `LCM-RM-024`
`LCM-CHK-010` | Implement the staleness-bound denial | `LCM-RM-025`
`LCM-CHK-011` | Implement the eight-step evaluation in the normative order | §29
`LCM-CHK-012` | Implement the gate read against `LCFG-5`, defaulting Disabled | `LCM-CFG-009`, `LCM-CFG-010`
`LCM-CHK-013` | Implement the indeterminate-gate denial | `LCM-CFG-012`
`LCM-CHK-014` | Implement safety-exclusion derivation | `LCM-SIG-006`
`LCM-CHK-015` | Implement tenant-suspension derivation | `LCM-SIG-007`
`LCM-CHK-016` | Implement the `ID-6` consent gate including `Unknown` | `LCM-AUTH-017`
`LCM-CHK-017` | Implement idempotent, order-independent signal handling | `LCM-SIG-011`, `LCM-SIG-012`
`LCM-CHK-018` | Implement unknown-key signal discard | `LCM-SIG-013`
`LCM-CHK-019` | Implement the read-only, authenticated, tenant-scoped API | §32
`LCM-CHK-020` | Implement uniform denial responses | `LCM-API-019`
`LCM-CHK-021` | Implement server-side tenant resolution and rejection of client-supplied tenant identifiers | `LCM-API-013`
`LCM-CHK-022` | Implement page-size bounding | `LCM-API-018`
`LCM-CHK-023` | Verify no cache directive permits decision reuse | `LCM-API-024`
`LCM-CHK-024` | Emit all fourteen `LCM-OBS-*` signals | §35
`LCM-CHK-025` | Verify no observability payload carries an identifying field | `LCM-INV-019`
`LCM-CHK-026` | Write unit tests for `LCM-GWT-001` … `032` | §38
`LCM-CHK-027` | Confirm `dart run tool/check_module_boundaries.dart` shows no new violation beyond the `ADR-0012` baseline | `X-05`
`LCM-CHK-028` | Confirm `flutter analyze` is clean and `flutter test` passes | Repository baseline
`LCM-CHK-029` | Record which acceptance criteria pass, and leave `LCM-AC-041` marked unwritable until `LCM-GAP-001` closes | §17, §38
`LCM-CHK-030` | Create the integration harness, then execute `LCM-AC-042` / `043` | `LCM-GAP-005`

`LCM-FR-063` — `LCM-CHK-001` and `LCM-CHK-002` SHALL be completed before any code is written. Neither is an engineering act.

---

## 42. Architecture consistency audit — final

Every authority this document relies on, and what A1 does to it.

\# | Authority | Rank / status | A1's effect
---|---|---|---
1 | `ARCHITECTURE_RULINGS.md` `AR-1` | Ruling, standing | **Applied.** Not amended, not extended
2 | `MASTER_PRD.md` `MP-SCOPE-04` | Rank 1 | **Unchanged.** `BC-15` stays V2
3 | `LIBOORA_BOUNDED_CONTEXT_MAP.md` | Rank 4 | **Unchanged.** Count stays 31 (23 in V1); no new edge
4 | `PRD-005` Membership Management | **FROZEN** | **Unchanged.** `E-02` consumed as already obliged by `MM-BR-011`
5 | `MM-BR-006` ten-edge allowlist | FROZEN | **Unchanged.** No eleventh edge
6 | `MM-BR-035` event register | FROZEN | **Unchanged.** Still seven events
7 | `MM-FR-072` / `073` states | FROZEN | **Unchanged.** No `Suspended`, no V1 `Frozen`
8 | `MM-BR-012` staleness bound | FROZEN | **Honoured** as the denial threshold
9 | `PRD-004` Student Management ch. 5 (`LMD-*`) | **FROZEN** | **Followed as precedent.** Not amended
10 | `SM-INV-3` | FROZEN | **Followed and applied** to `Unknown` minor status
11 | `ADR-0036` | **ACCEPTED** | **Unchanged.** q1 and q3 applied; q2 left open
12 | `ADR-0011` | ACCEPTED | Consistent — private by default
13 | `ADR-0018` (`SM-8.4a`) | ACCEPTED | **Followed as precedent** for a disclosed interim deny
14 | `ADR-0012` | ACCEPTED | Baseline untouched; A1 adds no violation
15 | `ADR-INDEX.md` L143 | Governance rule | **Complied with** — `LCM-ADR-001` precedes implementation
16 | `AP-3` deny-by-default | Policy | **Applied** at every A1 denial
17 | `AUTH-7.22` closed permission catalogue | Policy | **Unchanged.** Zero permissions minted
18 | `TR-1` … `TR-5` closed role set | Policy | **Unchanged.** Zero roles minted
19 | `XC-7.2` deny defeats allow | Policy | **Applied** in §29
20 | `CONFIGURATION_GUIDE.md` `LCFG-1` … `13` | Configuration register | **Unchanged.** `LCFG-5` reused; `LCFG-13`'s no-cached-authorisation rule adopted
21 | `X-05` / Dependency Matrix L354 | Boundary rule | **Respected.** No `domain/library` import from `domain/social`; `E-13` ACL only
22 | `PRD_REGISTRY.md` | Register | **Unchanged.** L321 not edited; one row deferred to the Governance Owner

### 42.1 Amendments made by this document

**None.** No FROZEN PRD, no ACCEPTED ADR, and no Rank 1–5 artefact is amended.

### 42.2 Identifiers minted by this document

Only `LCM-*` identifiers, which are local to A1. No `BC-`, `E-`, `PERM-`, `TR-`, `LCFG-`, `MM-`, `SM-`, `ADR-` or `AR-` identifier is minted.

### 42.3 What remains unproven

- `LCM-ADR-001` is not raised, let alone accepted.
- The placement recommendation is not approved.
- No acceptance criterion is recorded as passing.
- `ADR-0036` q2 is unanswered, and A1 says so in five places.

---

## 43. Remaining decisions

`LCM-DEC-001` … `LCM-DEC-012`, plus `LCM-FR-064` and `LCM-GAP-006` … `LCM-GAP-008`.

ID | Decision | Owner | Blocking? | Related
---|---|---|---|---
`LCM-DEC-001` | The first day of the three-day protected renewal window | **Product Owner** | ⛔ **YES** | `ADR-0036` q2; `LCM-GAP-001`
`LCM-DEC-002` | Whether to accept the `AR-1` classification for A1 | Architecture / Governance Owner | No — A1 states it, the ADR records it | `LCM-ADR-001`
`LCM-DEC-003` | Whether A1's V1 surface is the right product minimum | Product Owner | No | §37
`LCM-DEC-004` | Whether the participation gate should be coupled to the member directory beyond V1 | Product | No | `LCM-GAP-003`, `LCM-CFG-014`
`LCM-DEC-005` | Final architecture placement of A1 (recommended: the library cluster) | Owner | No | `LCM-GAP-004`
`LCM-DEC-006` | Whether a bounded member listing belongs in V1 at all, or only the self-check | Product Owner | No | `LCM-FR-060`
`LCM-DEC-007` | Whether the latency budget of `LCM-NFR-009` is acceptable on the uncached path | Engineering | No | `LCM-RSK-017`
`LCM-DEC-008` | Whether uniform denial responses are acceptable to product, given the UX cost | Product Owner | No | `LCM-API-019`
`LCM-DEC-009` | Whether `LCM-OBS-003` should raise an alert, not merely a counter | Engineering / Product | No | `LCM-GAP-001` visibility
`LCM-DEC-010` | The `PRD_REGISTRY.md` §4.2 row for A1 | **Governance Owner** | No | `LCM-GAP-002`
`LCM-DEC-011` | When to create the integration harness | Engineering | No | `LCM-GAP-005`
`LCM-DEC-012` | The A1 → A2 boundary, i.e. what A2 receives from A1 | Product Owner | No | §45

`LCM-FR-064` — Every decision above is recorded as outstanding. None is treated as settled by this document.

ID | Additional gap | Owner
---|---|---
`LCM-GAP-006` | No alerting policy is defined for `LCM-OBS-003`, so an open `LCM-GAP-001` could deny silently at scale | Engineering
`LCM-GAP-007` | The page-size bound of `LCM-API-018` reuses an existing convention rather than a named parameter, so it is not independently tunable | Product
`LCM-GAP-008` | The A1 → A2 handoff contract is not yet written, because A2 has not begun | Product Owner

---

## 44. Consolidated register summary

Final state of every register in this document.

Register | Range | Count
---|---|---
Functional requirements | `LCM-FR-001` … `LCM-FR-067` | 66 — one number after `LCM-FR-046` unassigned, see §24
Business rules | `LCM-BR-001` … `LCM-BR-018` | 18
Invariants | `LCM-INV-001` … `LCM-INV-020` | 20
Read model & consistency | `LCM-RM-001` … `LCM-RM-028` | 28
Authorization | `LCM-AUTH-001` … `LCM-AUTH-018` | 18
Configuration | `LCM-CFG-001` … `LCM-CFG-014` | 14
Signals | `LCM-SIG-001` … `LCM-SIG-014` | 14
API | `LCM-API-001` … `LCM-API-024` | 24
Security | `LCM-SEC-001` … `LCM-SEC-020` | 20
Observability | `LCM-OBS-001` … `LCM-OBS-014` | 14
Non-functional | `LCM-NFR-001` … `LCM-NFR-022` | 22
Acceptance criteria | `LCM-AC-001` … `LCM-AC-060` | 60
Given / When / Then | `LCM-GWT-001` … `LCM-GWT-032` | 32
Implementation checklist | `LCM-CHK-001` … `LCM-CHK-030` | 30
Risks | `LCM-RSK-001` … `LCM-RSK-026` | 26
Exclusions | `LCM-XC-001` … `LCM-XC-034` | 34
Gaps | `LCM-GAP-001` … `LCM-GAP-008` | 8
ADR requirements | `LCM-ADR-001` … `LCM-ADR-002` | 2
Decisions outstanding | `LCM-DEC-001` … `LCM-DEC-012` | 12
**Total** | — | **462 identifiers across 19 registers**

⚠ **This table supersedes the counts at §24.** §24 is the interim total taken at the end of §0–§27 (229 identifiers across 14 registers); the table above is the final total for §0–§45. Both are correct for their scope, and the difference is not drift.

### 44.1 Verification posture

Measure | Value
---|---
Acceptance criteria total | 60
Verifiable now | 57
Declared **unwritable** pending `LCM-GAP-001` | 1 — `LCM-AC-041`
**Deferred** pending an integration harness | 2 — `LCM-AC-042`, `LCM-AC-043`
Recorded as **passing** | **0**
Blocking gaps | **1** — `LCM-GAP-001`
Non-blocking gaps | 7
FROZEN documents amended | **0**
ACCEPTED ADRs amended | **0**
New bounded contexts | **0**
Registers contiguous | 18 of 19 — one number after `LCM-FR-046` unassigned (§24)
Distinct identifiers measured in this file | **462**

---

## 45. Document completeness

`LCM-FR-065`, `LCM-FR-066`, `LCM-FR-067`.

`LCM-FR-065` — This document covers Part A1 only: the classification, the membership-derived participation decision, the read model that supports it, the gate, the derived exclusions, the consent gate, the API shape, the security and observability requirements, the V1 scope, and the outstanding decisions. Sections §0 through §45 are complete for that purpose.

`LCM-FR-066` — Part A2 has **not** been started, and nothing in this document constitutes A2 content. The A1 → A2 handoff contract is recorded as an open gap (`LCM-GAP-008`) and an open decision (`LCM-DEC-012`).

`LCM-FR-067` — This document is a **DRAFT**. It is not frozen, not final, not approved, and not baselined. No lifecycle stage has been advanced. The 7-stage finalisation and freeze occur only after Parts A1 through A8 are all complete. This file exists in the repository so that A1's exact state can be recovered after a context loss.

### 45.1 Changelog addendum

Version | Change
---|---
**v0.2 (§28–§45)** | Integrated the continuation: remaining read-model and consistency rules; the eight-step access evaluation; the configuration gate; remaining signal rules; the API specification; twenty security requirements; extended edge cases 27–46; fourteen observability signals including the `LCM-GAP-001` visibility counter; performance and reliability; the V1 scope statement; thirty-two Given/When/Then scenarios and the seventeen acceptance criteria they establish; eleven further risks; the consolidated ADR position; a thirty-step implementation checklist; the final twenty-two-authority consistency audit; twelve outstanding decisions and three further gaps; the consolidated register summary superseding §24; and this completeness statement. §0–§27 were carried forward **unchanged**.
**v0.2 (§0–§27)** | As recorded at §27.
**v0.1** | As recorded at §27.

---

**End of PRD-021A Part A1 draft v0.2.**

> ⚠ **DRAFT — NOT FROZEN, NOT FINAL, NOT APPROVED, NOT BASELINED.**
> Committed for context-loss recovery and continuity only.
> One blocking decision remains open: `LCM-GAP-001` / `LCM-DEC-001`.
> Part A2 has not been started.
