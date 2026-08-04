# Student Identity & Profile PRD

| Field | Value |
|---|---|
| **Version** | **v1.0** (Startup MVP) |
| **Status** | **Official — declared baseline** |
| **Module** | Student Identity & Profile |
| **Owning bounded context** | **`BC-10` Global Person Identity** `[CORE]`, rank 7.5 |
| **Date** | 2026-08-04 |
| **Baseline** | `BASELINE-2026-08-04` |
| **Aligned to** | Master PRD v1.7 · Authentication PRD v2.0 · Library PRD v1.0 · Enterprise Architecture v2.1 · Bounded Context Map v1.3 · `ADR-0011` |
| **Precedence** | Rank 3 — module baseline, alongside Authentication PRD v2.0 and Library PRD v1.0. The three do not overlap |
| **Requirement prefix** | `SID-n.m` |
| **Supersedes** | The supplied Student Identity & Profile PRD v1.0 draft (Chapters 1–5), preserved in full except where §0.3 records a reconciliation |

---

## 0. How to read this document

### 0.1 Normative language

**MUST**, **MUST NOT**, **SHALL**, **SHALL NOT** are binding. **SHOULD** is a strong default that
requires a recorded reason to depart from. **MAY** is genuinely optional.

Every numbered `SID-n.m` statement is a requirement. Registers in this document:

| Register | Range | Meaning |
|---|---|---|
| `SID-n.m` | Chapters 1–5 | Requirements |
| `SID-BR-1` … `SID-BR-18` | §2.9 | Business rules |
| `SID-INV-1` … `SID-INV-14` | §5.4 | Domain invariants — always true |
| `SXC-1` … `SXC-11` | §1.8 | **Exclusions** — deliberately out of scope |
| `SPO-1` … `SPO-9` | §5.1 | Protected operations — closed set |
| `SCFG-1` … `SCFG-11` | §5.5 | Configurable parameters |
| `SEV-1` … `SEV-16` | §4.14 | Domain events |
| `SID-AC-1` … `SID-AC-26` | §5.6 | Acceptance criteria — **one register only** |

### 0.2 What this module is

Student Identity & Profile owns **who a person is**, permanently and independently of any
organisation. It owns nothing about **what they do** inside one.

### 0.3 Relationship to the supplied draft

This document preserves the supplied draft's vision, feature set and startup scope. **Nothing
user-facing has been removed.** Thirteen genuine conflicts with the frozen architecture were
reconciled; each is recorded with its justification in
[`STUDENT_IDENTITY_ALIGNMENT.md`](./STUDENT_IDENTITY_ALIGNMENT.md) as `SC-1`…`SC-13`. Two review
findings were **rejected** and the draft's original intent kept — see alignment report §6.

The one structural change is recorded in **[`ADR-0011`](../../00-governance/adr/ADR-0011-global-person-identity.md)**:
Global Person Identity is a **platform identity at rank 7.5**, `1:1` with the authentication account
and mandatory — not an optional social profile. This *strengthens* the draft's premise rather than
weakening it.

---

## Chapter 1 — Purpose & Goals

### 1.1 Purpose

Student Identity & Profile is the **authoritative source for the permanent, organisation-neutral
identity and personal profile of every person on the LIBOORA platform.**

It establishes **one reusable identity** that every current and future module consumes without
duplicating personal information — Library Management, Membership, Attendance, Seat Management,
Finance, Notifications, Analytics, Student Network, and the future School, College, Coaching and
Hostel products.

`SID-1.1` — The module **SHALL** own the person's global identity and profile.

`SID-1.2` — The module **SHALL NOT** own what a person does inside any organisation.

`SID-1.3` — The module **SHALL** remain reusable across every current and future education product
without identity migration.

`SID-1.4` — Social capabilities **SHALL** consume this identity. They **SHALL NOT** own it, redefine
it, or be the reason it exists. *(`ADR-0011`)*

### 1.2 Business problem

Without a central identity, every organisation and every feature keeps its own copy of a person's
information.

| Problem | Consequence |
|---|---|
| Duplicate records | The same person appears many times with divergent information |
| Data inconsistency | Updating a profile in one module leaves every other module stale |
| Poor scalability | Adding School, College and Coaching later requires identity migration |
| Privacy exposure | Every additional copy of personal data widens the breach surface |
| Maintenance cost | Every module becomes responsible for profile management |

`SID-1.5` — One global identity, referenced by every module, **SHALL** be the platform's answer to
all five.

### 1.3 Responsibilities owned

| # | Owned |
|---|---|
| 1 | Global Person Identity |
| 2 | Global Profile |
| 3 | Username |
| 4 | Global Profile Photo |
| 5 | Profile Privacy |
| 6 | Person Status and lifecycle |
| 7 | Profile validation |
| 8 | Duplicate prevention |
| 9 | Profile Timeline |
| 10 | Profile metadata |
| 11 | Profile audit events |
| 12 | Profile **composition** — aggregating other modules' read models for display |

### 1.4 Responsibilities NOT owned

| Responsibility | Owner | Context |
|---|---|---|
| Authentication, OTP, sessions, device trust | Authentication PRD v2.0 | `BC-18` |
| Authorisation and role grants | Authentication PRD v2.0 | `BC-18` |
| **Verified mobile number** | Authentication PRD v2.0 | `BC-18` |
| Library information, hours, structure | Library PRD v1.0 | `BC-19`, `BC-06` |
| **Student Record** — the person as a student of one organisation | Student Management PRD | `BC-01` |
| **Library Identification Photo** | Library Member Directory | `BC-01` |
| **Parent / Guardian contact information** | Student Management PRD | `BC-01` |
| Membership, plans, renewals, expiry | Membership Management | `BC-02` |
| Attendance | Attendance Management | `BC-03` |
| Seat allocation | Seat Management | `BC-04` |
| Finance, fees, receipts | Revenue & Finance | `BC-05` |
| Notification delivery | Notifications | `BC-22` |
| Analytics and reporting | Analytics | `BC-26` |
| Social graph, messaging, moderation | Student Network *(Future)* | `BC-11`…`BC-13` |

`SID-1.6` — Student Identity **MAY** consume information from these modules for display. It **SHALL
NEVER** duplicate, store or become the authority for it.

### 1.5 Objectives

`SID-1.7` — Create exactly one Global Person Identity per authenticated account.

`SID-1.8` — Prevent duplicate identities.

`SID-1.9` — Maintain reusable profile information.

`SID-1.10` — Support one identity participating in many organisations simultaneously.

`SID-1.11` — Provide privacy-controlled public profiles under explicit consent.

`SID-1.12` — Provide the identity foundation for future Student Network capabilities.

`SID-1.13` — Provide a stable identity foundation for every platform module.

### 1.6 Scope

**In scope:** Global Person Identity · Global Profile · Username · Global Profile Photo · Profile
Privacy · Person Status · duplicate prevention · profile validation · Profile Timeline · audit events ·
profile composition for display.

**Out of scope — owned elsewhere:** Authentication · Authorisation · verified mobile number · Student
Record · Library Identification Photo · parent/guardian contact · Membership · Attendance · Seat ·
Finance · Notifications · Analytics · social features.

### 1.7 Success metrics

`SID-1.14` — Every authenticated account has exactly one Global Person Identity.

`SID-1.15` — Duplicate identities are never created.

`SID-1.16` — Profiles remain consistent across all modules, because there is one copy.

`SID-1.17` — Username uniqueness is enforced platform-wide.

`SID-1.18` — Privacy settings take effect with no propagation window (`MP-GBR-26`).

`SID-1.19` — Every profile change emits an audit event.

`SID-1.20` — Operational modules reference this identity rather than duplicating profile data.

### 1.8 Exclusion register — `SXC-1` … `SXC-11`

These are **out of scope by decision, not by oversight.** Implementing one requires an ADR, not a
ticket.

| ID | Excluded | Why | Owner if ever built |
|---|---|---|---|
| `SXC-1` | Storing or verifying the mobile number | It is the sole authentication credential (`MP-GBR-25`, `ID-1`) | `BC-18` |
| `SXC-2` | Any credential, OTP, session or device record | `ID-1` | `BC-18` |
| `SXC-3` | Parent / guardian contact **storage** | Tenant-scoped third-party PII; the parent never authenticated here (`ID-6`) | `BC-01` |
| `SXC-4` | Library Identification Photo | Organisation-scoped biometric-adjacent asset | `BC-01` |
| `SXC-5` | Storing `StudentRecordId` or `tenantId` | `ID-2` — tenant identifiers must never enter a global context | — |
| `SXC-6` | Membership, attendance, seat, fee **state** | Operational data (`SID-INV-7`) | `BC-02`…`BC-05` |
| `SXC-7` | Authorisation decisions, or caching one | `X-13`, `MP-GBR-26` | `BC-18` |
| `SXC-8` | Sending any notification | `X-04` — emit facts only | `BC-22` |
| `SXC-9` | Custom / granular privacy tiers | V2. Public/Private only in V1 | This module, V2 |
| `SXC-10` | Permanent hard deletion of an identity | V1 archives; erasure is `BC-18`'s DSR chain (`ID-5`) | `BC-18` |
| `SXC-11` | Government-ID verification, additional identity providers | V2+ (`§5.7`) | TBD |

### 1.9 Assumptions

`SID-1.21` — Authentication verifies the person before the identity exists.

`SID-1.22` — One verified mobile number maps to one account, and therefore to one identity.

`SID-1.23` — A person **MAY** belong to many organisations at once.

`SID-1.24` — The same identity **MAY** later be used by School, College, Coaching and Hostel products.

`SID-1.25` — Organisation-specific information belongs to that organisation's Student Record.

`SID-1.26` — A person **MAY** choose whether their global profile is Public. **Private is the default.**

### 1.10 Constraints

**Business**

`SID-1.27` — Every account **SHALL** have exactly one Global Person Identity.

`SID-1.28` — This module **SHALL NEVER** own Membership, Attendance, Seat allocation, Finance, or any
organisation-specific information.

**Technical**

`SID-1.29` — The internal `PersonId` **SHALL** be immutable.

`SID-1.30` — Username **SHALL** be platform-wide unique.

`SID-1.31` — The verified mobile number **SHALL** remain the primary **business** identifier in V1,
held by `BC-18` and referenced — never copied — by this module.

`SID-1.32` — The identity **SHALL** remain reusable across future education products.

**Security**

`SID-1.33` — `PersonId` **SHALL NEVER** be exposed publicly.

`SID-1.34` — Unauthorised callers **SHALL NOT** reach restricted profile information.

`SID-1.35` — Every profile modification **SHALL** emit an audit event.

`SID-1.36` — Sensitive information **SHALL NEVER** become publicly visible.

### 1.11 The identity architecture *(authoritative — `ADR-0011`)*

```
Authentication Account          (AccountId,  BC-18, rank 4)
        │ 1 ──── 1   mandatory · created atomically · never orphaned
        ▼
Global Person Identity          (PersonId,   BC-10, rank 7.5)   ← THIS MODULE
        │                                    permanent · organisation-neutral · no tenantId
        │ 1 ──── 0..*
        ├──► Student Record — Library A        (StudentRecordId, BC-01, tenant-scoped)
        ├──► Student Record — Library B        (StudentRecordId, BC-01, tenant-scoped)
        ├──► Student Record — School   (Future)
        ├──► Student Record — College  (Future)
        └──► Student Record — Coaching (Future)

        ▲ consumed by, never owned by
        └── BC-11 Social Graph · BC-12 Messaging · BC-13 Trust & Safety · Student Network (Future)
```

`SID-1.37` — One person **SHALL** hold one permanent identity while participating in many
organisations across their lifetime on the platform.

`SID-1.38` — The reference direction **SHALL** be downward only: a Student Record holds a `PersonId`.
The identity **SHALL NOT** hold a list of Student Records. *(`ID-2`)*

---

## Chapter 2 — Student Identity

### 2.1 Identity model

`SID-2.1` — Every authenticated account **SHALL** have exactly **one** Global Person Identity,
created **atomically with the account**. An account without an identity **SHALL NOT** exist, and an
identity without an account **SHALL NOT** exist.

`SID-2.2` — The identity **SHALL** be permanent for the person's lifetime on the platform, regardless
of how many organisations they join or leave.

`SID-2.3` — This module **SHALL** be the authoritative source of global identity across the platform.

**Every person SHALL have exactly one of each:**

| One | Owner |
|---|---|
| Authentication Account | `BC-18` |
| Global Person Identity | `BC-10` — this module |
| Internal `PersonId` | This module |
| Verified mobile number | **`BC-18`** — referenced here, never stored |
| Platform-unique Username | This module |
| Global Profile | This module |

**A person MAY simultaneously have many:**

Library memberships · Student Records (one per organisation) · School enrolments *(Future)* ·
College enrolments *(Future)* · Coaching memberships *(Future)*.

`SID-2.4` — An operational record **SHALL NEVER** cause a second identity to be created.

### 2.2 Global Profile

The Global Profile is the person's permanent personal information, independent of any organisation.

**Required**

| Field | Note |
|---|---|
| Full Name | The only mandatory human-supplied field |
| Username | System-suggested, person-editable |

**Optional**

Gender · Date of Birth · Global Profile Photo · Address · Email Address · Occupation · Bio ·
Education information.

`SID-2.5` — Only the minimum information required for identity **SHALL** be mandatory.

`SID-2.6` — Additional profile information **MAY** be completed later without affecting identity.

`SID-2.7` — Gender **SHALL** be optional and **SHALL** include a "prefer not to say" option. *(Data
minimisation, §5.2. Reconciliation `SC-7`.)*

`SID-2.8` — Parent / guardian contact information **SHALL NOT** be a field of this profile. It is
owned per organisation by `BC-01` and **SHALL** be composed into the profile screen for display
(§2.7, `SXC-3`).

`SID-2.9` — The verified mobile number **SHALL NOT** be a stored field of this profile. It **MAY** be
read through to `BC-18` under authorisation for display to the person themselves.

### 2.3 Internal identity

**`PersonId`**

`SID-2.10` — **SHALL** be system generated.
`SID-2.11` — **SHALL** be globally unique.
`SID-2.12` — **SHALL** be immutable.
`SID-2.13` — **SHALL NEVER** be editable.
`SID-2.14` — **SHALL NEVER** be reused, including after archival.
`SID-2.15` — **SHALL NEVER** be exposed publicly or in any client-facing payload.
`SID-2.16` — **SHALL** be the primary internal identifier for a person across the platform.

**Verified mobile number**

`SID-2.17` — **SHALL** be verified only by `BC-18`.
`SID-2.18` — **SHALL** be unique platform-wide — enforced by `BC-18`.
`SID-2.19` — **SHALL** act as the primary business identifier in V1.
`SID-2.20` — **SHALL NEVER** be verified, stored or mutated by this module.
`SID-2.21` — Mobile number changes **SHALL** originate exclusively from `BC-18`; this module
**SHALL** react to the resulting event.

**Username** — V1 scope.

| Policy | Value |
|---|---|
| Uniqueness | Platform-wide, **case-insensitive** |
| Length | `SCFG-1` — 3–30 characters |
| Allowed | Letters, digits, underscore, period |
| Reserved words | Prohibited — `SCFG-2` reserved list |
| Editable | Yes, subject to cooldown `SCFG-3` |
| Change history | Retained — `SCFG-4` retention |
| Purpose | Discovery · public profile · Student Network *(Future)* |

`SID-2.22` — Username **SHALL NEVER** be usable as an authentication credential.

`SID-2.23` — Authentication **SHALL** continue to use mobile number + OTP exclusively (`MP-GBR-25`).

`SID-2.24` — A released username **SHALL NOT** be immediately reclaimable; a hold period `SCFG-5`
**SHALL** apply, to prevent impersonation of a person who has just renamed.

### 2.4 Profile privacy

`SID-2.25` — Every person **SHALL** control the visibility of their Global Profile.

`SID-2.26` — Supported modes in V1 **SHALL** be exactly **Public** and **Private**. Custom visibility
is `SXC-9`, deferred to V2.

`SID-2.27` — **Private SHALL be the default** for every newly created identity. Public visibility
**SHALL** require an explicit, recorded act of consent by the person. *(`AP-3` deny by default.)*

**When Public — the allow-list.** Only these fields **MAY** be visible to other people:

| Field | Condition |
|---|---|
| Full Name | — |
| Username | — |
| Global Profile Photo | If set and not hidden |
| Bio | — |
| Study statistics | Only if separately enabled by the person |
| Achievements | Only if separately enabled by the person |

`SID-2.28` — Public visibility **SHALL** be governed by this **allow-list**. A field absent from it
is not public. The test **SHALL** be allow-list membership, never a judgement that a field "looks
harmless". *(Same rule class as Library `LIB-14B.44`.)*

**Never public — under any setting**

`PersonId` · verified mobile number · parent / guardian contact · address · emergency contact ·
authentication information · Library Identification Photo · membership information · attendance
records · seat allocation · financial information · audit metadata.

`SID-2.29` — The above **SHALL NEVER** become publicly visible, and **SHALL NOT** be made public by
any configuration value, feature flag or deployment setting.

`SID-2.30` — A change of privacy setting **SHALL** take effect with no propagation window; cached
public projections **SHALL** be invalidated as part of the same operation. *(`MP-GBR-26`.)*

### 2.5 Identity lifecycle

```
Authentication account created
        ↓  (atomic — SID-2.1)
Identity Created  ──►  Pending Profile  ──►  Active
                                              │
                                    ┌─────────┼─────────┐
                                    ▼         ▼         ▼
                               Suspended   Archived   (Restored ──► Active)
```

| State | Meaning |
|---|---|
| **Pending Profile** | Identity exists; required profile information incomplete |
| **Active** | Available for normal platform operations |
| **Suspended** | Identity persists; consuming modules **MAY** restrict operational access |
| **Archived** | Removed from normal operations; historical references remain resolvable |
| **Restored** | The **existing** identity returns to Active |

`SID-2.31` — Restoration **SHALL** return the existing identity to Active. `PersonId` **SHALL NEVER**
change, and a new identity **SHALL NOT** be created.

`SID-2.32` — Archived identities **SHALL** remain resolvable for historical and audit purposes.

`SID-2.33` — Permanent deletion is outside V1 (`SXC-10`). Erasure of the underlying account is owned
by `BC-18` (`AUTH-9.46`…`AUTH-9.60`); on erasure this module **SHALL** anonymise the person while
`BC-01` retains organisation history under legal basis (`ID-5`).

### 2.6 Duplicate prevention

`SID-2.34` — Duplicate validation **SHALL** occur before an identity is created.

V1 checks:

| Check | Authority |
|---|---|
| Account already has an identity | This module — the `1:1` invariant |
| Verified mobile number uniqueness | **`BC-18`** — this module trusts the result |
| Username uniqueness | This module, case-insensitive |

`SID-2.35` — On detecting a duplicate: creation **SHALL** stop, the existing profile **SHALL** remain
unchanged, and validation feedback **SHALL** be returned.

`SID-2.36` — This module **SHALL NEVER** create a duplicate identity.

`SID-2.37` — Duplicate feedback **SHALL NOT** disclose whether a mobile number is registered to an
existing account. Username availability **MAY** be disclosed, because usernames are public by design.
*(Anti-enumeration, `AR-7`.)*

### 2.7 Profile composition

The profile screen **MAY** display information aggregated from many modules. This module owns only
the identity portion and **SHALL NOT** store the rest.

**This module owns**

Full Name · Username · Global Profile Photo · Bio · Gender · Date of Birth · Address · Email ·
Occupation · privacy settings · person status.

**Other modules contribute — read models only**

| Contributor | Contributes | Context |
|---|---|---|
| Student Management / Member Directory | Library Identification Photo · joined organisations · organisation status · **parent / guardian contact** | `BC-01` |
| Membership | plan · status · expiry | `BC-02` |
| Attendance | percentage · present days · summary | `BC-03` |
| Seat Management | current seat · shift · zone | `BC-04` |
| Finance | payment status · outstanding balance | `BC-05` |
| Study Analytics | study hours · streak · reading statistics · productivity | `BC-26` |
| Achievements | badges · milestones · certificates | `BC-26` |

`SID-2.38` — Aggregation **SHALL** be read-only composition. This module **SHALL NOT** store, cache
beyond a display request, or become the authority for any contributed value.

`SID-2.39` — Every contributed value **SHALL** be fetched under the caller's own authorisation. A
person viewing their own profile sees their own data; staff see only what their role permits in the
organisation they are acting for.

`SID-2.40` — Composition **SHALL** degrade gracefully. A contributing module being unavailable
**SHALL** render that section unavailable, and **SHALL NOT** fail the identity portion of the screen.

`SID-2.41` — Composition **SHALL NOT** be performed inside this module's domain layer. It is an
application-layer read composition, consistent with ruling `AR-1`.

### 2.8 Ownership boundary — normative

| Asset | Owner | Context |
|---|---|---|
| Credentials, OTP, sessions, device trust, authorisation | Authentication | `BC-18` |
| **Verified mobile number** | Authentication | `BC-18` |
| Global Person Identity, `PersonId` | **This module** | `BC-10` |
| Username, Global Profile, Global Profile Photo, privacy | **This module** | `BC-10` |
| Student Record, organisation profile, **Library Identification Photo**, **parent contact** | Student Management / Member Directory | `BC-01` |
| Membership · Attendance · Seat · Finance | Respective modules | `BC-02`…`BC-05` |
| Social graph, messaging, moderation | Student Network *(Future)* | `BC-11`…`BC-13` |

`SID-2.42` — This table is **normative**. Changing a row requires an ADR.

### 2.9 Business rules — `SID-BR-1` … `SID-BR-18`

| ID | Rule |
|---|---|
| `SID-BR-1` | Every authenticated account has exactly one Global Person Identity, created atomically with it |
| `SID-BR-2` | Every identity has one immutable, never-reused `PersonId` |
| `SID-BR-3` | Username is platform-wide unique, case-insensitively |
| `SID-BR-4` | The verified mobile number is unique platform-wide — enforced and owned by `BC-18` |
| `SID-BR-5` | Authentication owns identity verification; this module trusts its result and never re-verifies |
| `SID-BR-6` | This module owns global identity and profile information only |
| `SID-BR-7` | `BC-01` owns all organisation-specific information, including the mandatory Library Identification Photo and parent / guardian contact |
| `SID-BR-8` | Global Profile Photo and Library Identification Photo are **independent assets** with independent lifecycles |
| `SID-BR-9` | A person may hide their Global Profile Photo with **no effect** on any Library Identification Photo |
| `SID-BR-10` | Profile privacy is controlled by the person; Private is the default |
| `SID-BR-11` | Operational modules reference this identity instead of duplicating profile information |
| `SID-BR-12` | This module never owns membership, attendance, seat, finance or analytics data |
| `SID-BR-13` | One identity may be referenced by many organisations |
| `SID-BR-14` | Archived identities remain resolvable for historical and audit purposes |
| `SID-BR-15` | The identity is reusable across future Libraries, Schools, Colleges, Coaching Institutes and other education products with **no identity migration** |
| `SID-BR-16` | Global profile privacy never overrides an organisation's security requirements |
| `SID-BR-17` | Social capabilities consume this identity; they never own or redefine it |
| `SID-BR-18` | Every state or profile change emits an audit event and a domain event |

---

## Chapter 3 — Profile Management

### 3.1 Purpose

Profile Management governs the lifecycle of the Global Profile after the identity exists: create,
view, update, archive, restore — preserving identity integrity, privacy and auditability.

`SID-3.1` — This capability **SHALL** own only the Global Profile. Organisation-specific profile
management **SHALL** remain with the owning organisation module.

### 3.2 Profile creation

`SID-3.2` — A Global Profile **SHALL** be created exactly once per identity.

`SID-3.3` — If an identity already exists for the account, the existing profile **SHALL** be reused.
A second **SHALL NOT** be created.

**Workflow**

```
Authentication succeeds (BC-18)
        ↓
Account created  ─── atomic ───  Global Person Identity created  (PersonId issued)
        ↓
Duplicate validation  (account · username)
        ↓
Profile completion  (Pending Profile ──► Active)
        ↓
Audit event + domain event
        ↓
Profile Active
```

`SID-3.4` — Creation **SHALL** require successful authentication first.

`SID-3.5` — `PersonId` **SHALL** be generated automatically and never supplied by a caller.

`SID-3.6` — Username uniqueness **SHALL** be validated before persistence.

`SID-3.7` — Creation timestamp **SHALL** be recorded.

`SID-3.8` — Audit and domain events **SHALL** be emitted.

`SID-3.9` — Creation **SHALL** fail atomically on validation failure. **Partial profiles SHALL
NEVER be persisted.**

### 3.3 View profile

`SID-3.10` — The profile screen **MAY** present global identity information together with composed
read models from other modules (§2.7).

**Global information displayed**

Full Name · Username · Global Profile Photo · Gender · Date of Birth · Bio · Occupation · Education
information · privacy settings.

**Composed sections — displayed, not owned**

| Section | Fields |
|---|---|
| Organisations | joined libraries · current organisation · identification status · **parent / guardian contact** |
| Membership | current plan · status · expiry |
| Attendance | percentage · present days · monthly summary |
| Study Analytics | daily / weekly / monthly study hours · study streak · reading statistics |
| Seat | current seat · shift · zone |
| Finance | membership status · payment status · outstanding balance |
| Achievements | badges · milestones · reading goals · certificates |

`SID-3.11` — Every composed section **SHALL** be labelled with its owning module in developer
documentation, so that a defect is routed to the owner rather than to this module.

### 3.4 Update profile

`SID-3.12` — A person **MAY** update: Full Name · Username · Global Profile Photo · Bio · Gender ·
Date of Birth · Email · Address · Occupation · privacy settings.

`SID-3.13` — The following **SHALL NOT** be directly editable in this module:

| Restricted | Reason | Where changed |
|---|---|---|
| `PersonId` | Immutable (`SID-2.12`) | Nowhere |
| **Verified mobile number** | Sole authentication credential | `BC-18` only |
| Authentication information | `ID-1` | `BC-18` only |
| Role assignments | Authorisation | `BC-18` only |
| **Parent / guardian contact** | Tenant-scoped, `SXC-3` | `BC-01`, per organisation |
| **Library Identification Photo** | Organisation asset, `SXC-4` | `BC-01` |

`SID-3.14` — Every successful update **SHALL** validate input, record the timestamp, emit an audit
event, and publish a domain event.

`SID-3.15` — A failed update **SHALL** persist nothing.

### 3.5 Global Profile Photo

`SID-3.16` — The Global Profile Photo represents the person's platform-wide identity and is owned and
managed by the person.

`SID-3.17` — A person **MAY** upload, replace, remove or hide it.

`SID-3.18` — It **SHALL** follow the person's privacy setting.

`SID-3.19` — It **SHALL** be stored as a `FileRef` via `BC-29` File & Media. This module **SHALL
NOT** hold bytes or a raw storage path. *(Edge `E-22`.)*

`SID-3.20` — Uploads **SHALL** pass virus scanning and **SHALL** be served through signed,
expiring URLs — `BC-29`.

**Library Identification Photo — independent**

`SID-3.21` — The Library Identification Photo is owned by `BC-01`, not this module.

| Characteristic | Value |
|---|---|
| Captured | During library joining |
| Mandatory | Per library policy (configurable) |
| Visible to | Authorised library staff only |
| Used for | Attendance · seat identification · reception verification |
| Public | **Never** |

`SID-3.22` — Hiding or removing the Global Profile Photo **SHALL NOT** affect any Library
Identification Photo, and **SHALL NOT** impair attendance, seat or reception verification.

`SID-3.23` — The Library Identification Photo **SHALL NEVER** become part of the Global Profile, and
**SHALL NEVER** be exposed by any endpoint of this module.

### 3.6 Profile privacy

`SID-3.24` — Privacy modes **SHALL** be Public and Private, Private by default (§2.4).

`SID-3.25` — Privacy settings **SHALL** affect only the Global Profile.

`SID-3.26` — Privacy settings **SHALL NEVER** affect: Library Identification Photo · attendance
verification · seat verification · reception verification · any library operation.

`SID-3.27` — A global privacy setting **SHALL NEVER** override an organisation's security
requirements. *(`SID-BR-16`.)*

### 3.7 Profile Timeline

`SID-3.28` — The platform **SHALL** maintain an immutable Profile Timeline.

Events: Identity Created · Profile Updated · Username Changed · Global Profile Photo Updated ·
Privacy Changed · Status Changed · Suspended · Archived · Restored · Mobile Number Changed
*(received from `BC-18`)*.

`SID-3.29` — Timeline entries **SHALL** be chronological, immutable, system-generated and auditable.

`SID-3.30` — A timeline entry **SHALL NOT** contain a value that is itself restricted — no mobile
number, no parent contact. It records **that** a change occurred, not the sensitive value.

### 3.8 Permissions

Roles are the closed set from Authentication PRD v2.0 `AUTH-7.21`. **No role is invented here.**

| Role | Global Profile | Note |
|---|---|---|
| **Platform Administrator** | View · Suspend · Archive · Restore | **MAY NOT** edit profile content — see `SID-3.32` |
| **`TR-1` Owner** | View composed profile of a person enrolled in their own organisation | Edits the **Student Record** (`BC-01`), never the Global Profile |
| **`TR-2` Manager** | Same as `TR-1`, within their organisation | As above |
| **`TR-3` Reception** | View composed profile within their organisation | As above. **MAY NOT** archive or restore |
| **`TR-4` Student** | View own · update permitted fields · change username · change privacy · manage own photo | The **only** role that edits Global Profile content |
| **`TR-5` Parent** | View the permitted subset for a linked child, within the granting organisation | Read-only. Scope granted by `BC-18`; never inferred here |

`SID-3.31` — Organisation staff **SHALL NOT** create, edit or delete Global Profile content. They
create and edit the **Student Record** in their own organisation. *(Reconciliation `SC-2`; rules
`ID-3`, `AP-5`.)*

`SID-3.32` — Platform Administrator **MAY** act on identity **status** for safety and legal reasons
and **SHALL NOT** edit profile content. Editing a person's self-expression is not an administrative
function; every status action is audited.

`SID-3.33` — Authorisation decisions **SHALL** be owned by `BC-18`. This module **SHALL** ask and
**SHALL NOT** evaluate or cache a decision. *(`X-13`, `MP-GBR-26`.)*

`SID-3.34` — A `TR-5` Parent's visible subset **SHALL** be determined by the granting organisation and
**SHALL NOT** include the child's social profile, messaging or private-mode content.

### 3.9 Audit events

`SID-3.35` — Every operation in the following set **SHALL** emit an audit event: Identity Created ·
Profile Updated · Username Changed · Global Profile Photo Updated · Privacy Changed · Mobile Number
Changed *(from `BC-18`)* · Suspended · Archived · Restored · Status Changed · Public Profile Viewed
*(when by a non-owner)*.

`SID-3.36` — Every audit event **SHALL** carry: Event ID · timestamp · actor · `PersonId` ·
organisation context *(if the actor acted for one)* · operation · result.

`SID-3.37` — This module **SHALL** emit audit events. Storage and retention **SHALL** be owned by
`BC-24` Audit. *(`X-04` — emit facts.)*

`SID-3.38` — An audit event **SHALL NOT** contain a credential, an OTP, a mobile number or parent
contact detail.

### 3.10 Edge cases

`SID-3.39` — The platform **SHALL** handle correctly:

| # | Scenario | Required behaviour |
|---|---|---|
| 1 | Duplicate username at creation | Reject; keep existing profile; report availability |
| 2 | Duplicate mobile number detected by `BC-18` | No identity created; **no disclosure** of registration status (`AR-7`) |
| 3 | Person joins a second organisation | Reuse the same identity; new Student Record created by `BC-01` |
| 4 | Username changed | All relationships preserved — they key on `PersonId`, never on username |
| 5 | Global Profile Photo hidden | Library Identification Photo unaffected; attendance and seat verification continue |
| 6 | Archived identity restored | Same `PersonId`; no new identity |
| 7 | Update fails validation midway | Nothing persisted |
| 8 | Unauthorised attempt to edit a restricted field | Denied and audited |
| 9 | Privacy switched Public → Private while a public projection is cached | Cache invalidated in the same operation; next request reflects Private (`MP-GBR-26`) |
| 10 | Person has an identity but no organisation membership | Fully valid. The identity exists independently *(closes `Q-05`)* |
| 11 | A contributing module is unavailable during composition | That section degrades; identity portion still renders (`SID-2.40`) |
| 12 | Account erased via `BC-18` DSR | Person anonymised here; `BC-01` retains organisation history under legal basis (`ID-5`) |
| 13 | Username released, then requested by another person | Hold period `SCFG-5` blocks immediate reclamation (`SID-2.24`) |
| 14 | Two organisations both request a profile update | Neither can: staff edit Student Records, not the Global Profile (`SID-3.31`) |

---

## Chapter 4 — Integration & Module Boundaries

### 4.1 Purpose

This chapter states **who this module talks to, in which direction, through what mechanism, and what
it is forbidden to do.** Chapters 1–3 describe behaviour; this chapter describes the seams. It is the
chapter a reviewer reads when asking *"has anyone quietly re-coupled the paying product to the social
product?"*

Every rule here is derived from the Bounded Context Map (§4 Identity Triad, §8 integration edges,
`X-01`…`X-14`), the Module Dependency Matrix (Five Dependency Laws) and `ADR-0011`.

### 4.2 Integration principles — `SID-4.1` … `SID-4.10`

`SID-4.1` — This module **SHALL** occupy **rank 7.5**: its own tier, below every domain module and
above every capability platform. *(`ADR-0011`.)*

`SID-4.2` — This module **SHALL NOT** import, reference or depend on any domain module. Specifically it
**SHALL NOT** depend on `domain/library/**` (`X-05`) or on `domain/social/**`.

`SID-4.3` — Domain modules **MAY** depend on this module, because rank 8 depending on rank 7.5 is a
strictly downward dependency and therefore legal under **`L2`**.

`SID-4.4` — Every cross-context contract this module publishes or consumes **SHALL** be declared in
`liboora_contracts` (rank 0). Contracts **SHALL** import nothing (**`L5`**, `X-12`).

`SID-4.5` — Every outbound notification of a fact **SHALL** be a domain event delivered through the
outbox. Direct synchronous calls into another context for notification purposes are forbidden
(`X-07`).

`SID-4.6` — Where this module needs an answer it does not own, it **SHALL** ask through a declared
synchronous port and **SHALL NOT** read another context's store.

`SID-4.7` — This module **SHALL NOT** call `DateTime.now()` or generate identifiers directly; it
**SHALL** use the `time` and `id` ports (`X-09`).

`SID-4.8` — This module **SHALL NOT** participate in tenant context. It has no `tenantId`, and its
caches, indices and keys **SHALL** be keyed on `PersonId` alone. *(`X-13` is satisfied by the absence
of tenant-scoped data, not by adding a tenant prefix.)*

`SID-4.9` — Read composition of the aggregated profile screen **SHALL** occur in the application layer
(`app`, rank 9), never inside this module. *(`AR-1`, `SID-2.41`.)*

`SID-4.10` — Adding an integration edge to or from this module **SHALL** require an update to the
Bounded Context Map and an ADR. It **SHALL NOT** be introduced by a pull request alone.

### 4.3 Authentication & Access — `BC-18` *(upstream, `E-12`)*

Authentication is **upstream** of this module and is the only context that may cause an identity to
come into existence.

| Direction | Mechanism | Edge | Purpose |
|---|---|---|---|
| `BC-18` → this module | Synchronous port, same unit of work | `E-12` | Create the identity atomically with the account |
| this module → `BC-18` | Synchronous port | `E-12` | Resolve the verified mobile number for an authorised caller |
| this module → `BC-18` | Synchronous port | `E-12` | Ask for an authorisation decision |
| `BC-18` → this module | Event | `E-12` | Account erased → anonymise |

`SID-4.11` — Identity creation **SHALL** be **synchronous and transactional**, not event-driven. If the
identity cannot be created, account creation **SHALL** fail. *(`SID-INV-2`. An event-driven creation
would permit a window in which an account exists without an identity, which the `1:1` invariant
forbids.)*

`SID-4.12` — `identity.PersonIdentityCreated` (`SEV-1`) is therefore a **notification of a completed
fact**, not the trigger for creation. No consumer **SHALL** treat it as the creation command.

`SID-4.13` — This module **SHALL** treat the verified mobile number as a **read-through value** owned by
`BC-18`. It **SHALL NOT** store it, cache it, index it, log it or include it in any event payload.
*(`SXC-1`, `SID-INV-5`.)*

`SID-4.14` — This module **SHALL NOT** evaluate, derive or cache an authorisation decision. It
**SHALL** ask `BC-18` on every request. *(`SID-3.33`, `MP-GBR-26` — revocation has no propagation
window.)*

`SID-4.15` — This module **SHALL NOT** create, modify or revoke a role assignment. Role names used in
this document are drawn from the closed Authentication set (`AUTH-7.21`) and **SHALL NOT** be extended
here.

### 4.4 Student Management / Library Member Directory — `BC-01` *(downstream, `E-13`)*

This is the seam that `X-05` exists to protect. It is also the seam most likely to be eroded by a team
in a hurry.

| Direction | Mechanism | Edge | Purpose |
|---|---|---|---|
| `BC-01` → this module | Synchronous port through an **ACL** | `E-13` | Resolve identity core fields for a `PersonId` the Student Record already holds |
| `BC-01` → application layer | Read model | — | Contributes Library Identification Photo, organisation status, parent / guardian contact to the composed screen |
| this module → `BC-01` | **Nothing** | — | This module has no outbound dependency on `BC-01` whatsoever |

`SID-4.16` — A Student Record **SHALL** hold a `PersonId`. This module **SHALL NOT** hold a
`StudentRecordId`, a `tenantId`, an organisation name, or a list of the organisations a person belongs
to. *(`ID-2`, `SXC-5`, `SID-1.38`, `SID-INV-6`, `SID-INV-8`.)*

`SID-4.17` — Because the identity now exists from account creation, the `PersonId` held by a Student
Record **SHALL** be **non-nullable**. The previously nullable field is a consequence of the optional
identity that `ADR-0011` removed.

`SID-4.18` — The `E-13` translation **SHALL** remain an Anti-Corruption Layer. `BC-01` **SHALL NOT**
receive this module's domain types, and this module **SHALL NOT** receive `BC-01`'s.

`SID-4.19` — This module **SHALL NOT** answer, and **SHALL NOT** be capable of answering, *"which
libraries does this person attend?"* That question is answerable only by querying `BC-01` per tenant,
under that tenant's authorisation. *(`ID-3`.)*

`SID-4.20` — Organisation staff **SHALL NOT** mutate anything in this module through `BC-01` or through
any other path. *(`SID-3.31`, `AP-5`.)*

`SID-4.21` — This module **SHALL NOT** be on the critical path of attendance check-in, seat allocation,
fee collection or membership validation. Unavailability of this module **SHALL NOT** prevent a library
from operating. *(This is the operational half of `X-05`: a global-identity outage must not take down
the paying product.)*

### 4.5 Membership · Attendance · Seating · Finance — `BC-02` … `BC-05`

| Direction | Mechanism | Purpose |
|---|---|---|
| this module → any of `BC-02`…`BC-05` | **None** | No dependency exists in this direction |
| `BC-02`…`BC-05` → application layer | Read models | Contribute Membership Summary, Attendance Summary, Seat Summary and payment status to the composed profile screen |

`SID-4.22` — This module **SHALL NOT** store, mirror, summarise or become the authority for membership
plan or status, attendance records or percentages, seat allocation, shift, zone, or any fee, due,
receipt or balance. *(`SXC-6`, `SID-INV-7`.)*

`SID-4.23` — These modules key on `StudentRecordId` within a tenant. They **SHALL NOT** be re-keyed on
`PersonId`, and this module **SHALL NOT** request that they be. *(`ID-4`. Re-keying would make `ID-5`
unsatisfiable — see `ADR-0011` §4.)*

`SID-4.24` — A summary rendered on the aggregated profile screen **SHALL** be fetched live under the
caller's authorisation, for the single organisation the caller is acting for, and **SHALL NOT** be
aggregated across organisations by this module. *(`SID-2.39`.)*

### 4.6 Study Analytics & Achievements — `BC-26`

| Direction | Mechanism | Edge | Purpose |
|---|---|---|---|
| this module → `BC-26` | Event | `E-20` / `E-21` class | Profile and status events feed projections |
| `BC-26` → application layer | Read model | — | Contributes Study Statistics and Achievements |

`SID-4.25` — Study Statistics and Achievements **SHALL** be owned by `BC-26` and displayed by
composition. This module **SHALL NOT** compute, store or restate them. *(`X-01` — analytics is a read
model, not a domain store, and equally this module is not an analytics store.)*

`SID-4.26` — Study Statistics and Achievements **SHALL** be publicly visible only if the person has
separately enabled each. Enabling a Public profile **SHALL NOT** implicitly publish either.
*(`SID-2.28` allow-list.)*

`SID-4.27` — A publicly visible statistic **SHALL NOT** disclose which organisation produced it, nor
allow the organisation to be inferred from its granularity. *(`ID-3`.)*

### 4.7 Student Network — `BC-11` · `BC-12` · `BC-13` *(consumers only, `E-15`)*

`SID-4.28` — Social contexts **SHALL** be **consumers** of this identity. They **SHALL NOT** own,
extend, redefine, or gate the existence of the Global Person Identity. *(`SID-1.4`, `ADR-0011`.)*

`SID-4.29` — Social contexts **SHALL** key exclusively on `PersonId` and **SHALL NOT** hold, receive or
be able to infer a `StudentRecordId` or a `tenantId`. *(`ID-3`, enforced by `banned_symbols` in
`tool/module_dependencies.yaml`.)*

`SID-4.30` — This module **SHALL NOT** depend on any social context. The `E-15` shared kernel
(`PersonId`, privacy value objects) **SHALL** live in `liboora_contracts`, not in `domain/social`.
*(Rank 7.5 may not import rank 8.)*

`SID-4.31` — Deactivating, disabling or never launching the social product **SHALL NOT** affect the
existence, validity or usability of any Global Person Identity. *(This is the falsifiable test of
`ADR-0011`: if switching off the social product breaks identities, the boundary has been violated.)*

**Enforcement actions from Trust & Safety (`E-14`).** `E-14` fans `safety.EnforcementActionTaken` out
to consuming contexts, each of which **self-restricts**; Trust & Safety never writes into them. This
module declares the scope of its own self-restriction:

`SID-4.32` — On receiving `safety.EnforcementActionTaken`, this module **SHALL** restrict the
**public projection** of the identity for the stated scope and duration.

`SID-4.33` — It **SHALL NOT** suspend, archive, anonymise or otherwise alter the lifecycle state of the
identity, and **SHALL NOT** impair the person's ability to be a student of any organisation. *(A social
moderation decision that could disable a paying library's student is precisely the harm `X-05`
describes. Restricting a projection is reversible and organisation-neutral; changing lifecycle state is
neither.)*

`SID-4.34` — Consumption of that event **SHALL** be through its `liboora_contracts` schema. This
**SHALL NOT** introduce an import of `domain/social/**`.

### 4.8 File & Media — `BC-29` *(`E-22`)*

`SID-4.35` — The Global Profile Photo **SHALL** be held as a `FileRef` issued by `BC-29`. This module
**SHALL NOT** hold bytes, a raw storage path or a public URL. *(`SID-3.19`.)*

`SID-4.36` — Upload, virus scanning, thumbnailing and signed-URL issuance **SHALL** be owned by
`BC-29`. This module **SHALL NOT** re-implement or bypass any of them.

`SID-4.37` — A `FileRef` for a Global Profile Photo and a `FileRef` for a Library Identification Photo
**SHALL** be distinct references with independent lifecycles. Deleting one **SHALL NOT** delete or
invalidate the other. *(`SID-BR-8`, `SID-INV-13`.)*

### 4.9 Search Indexing — `BC-23` *(`E-21`)*

`SID-4.38` — Discoverability of a public profile **SHALL** be provided by `BC-23`, driven by this
module's events. `BC-23` **SHALL NOT** read this module's store. *(`X-08`.)*

`SID-4.39` — Only allow-list fields (`SID-2.28`) **SHALL** be indexed for public search. A field in the
never-public set **SHALL NOT** be indexed at all, in any index, for any purpose. *(Indexing a
never-public field creates a second, unguarded read path.)*

`SID-4.40` — A privacy change from Public to Private **SHALL** remove the person from public search
results as part of the same operation, not on the next scheduled reindex. *(`SID-2.30`,
`MP-GBR-26`.)*

`SID-4.41` — Public profile search **SHALL NOT** support lookup by mobile number, and **SHALL NOT**
confirm or deny that a mobile number is registered. *(`AR-7`, `SID-2.37`.)*

### 4.10 Notification Delivery — `BC-22` *(`E-23`)*

`SID-4.42` — This module **SHALL** emit facts only. It **SHALL NOT** select a channel, compose a
message, or instruct that a notification be sent. *(`X-04`, `SXC-8`.)*

`SID-4.43` — No event payload emitted by this module **SHALL** contain a mobile number, an email
address, a parent contact, a credential or an OTP. `BC-22` **SHALL** resolve the destination itself
from `BC-18`. *(`SID-4.13`.)*

### 4.11 Audit Trail — `BC-24` *(`E-20`)*

`SID-4.44` — This module **SHALL** emit audit events fire-and-forget through the outbox and **SHALL
NOT** call `BC-24` synchronously from domain code. *(`X-04` class, `E-20`.)*

`SID-4.45` — Audit records **SHALL** be append-only. This module **SHALL NOT** request, and `BC-24`
**SHALL NOT** offer, an update or delete of an audit record. *(`X-10`.)*

`SID-4.46` — An audit event recording a change to a sensitive field **SHALL** record **that** the
change occurred, not the value. *(`SID-3.30`, `SID-3.38`.)*

### 4.12 Configuration — `BC-25` *(`E-19`)*

`SID-4.47` — Every configurable value **SHALL** be declared in the register at §5.5 and read through a
typed accessor. Raw string configuration lookups in domain code are forbidden.

`SID-4.48` — No configuration value **SHALL** be capable of making a never-public field public,
disabling an audit event, weakening `SID-INV-1`…`SID-INV-14`, or making Public the default privacy
mode. *(`SID-2.29`, `SID-5.44`.)*

### 4.13 Tenancy — `BC-19` *(explicitly not integrated)*

`SID-4.49` — This module **SHALL NOT** consume `TenantContext`. It is global by construction, and
`TenantId` **SHALL** be a banned symbol in it.

`SID-4.50` — A caller **MAY** be acting within a tenant context. That context **SHALL** be used only to
evaluate the caller's authorisation in `BC-18`; it **SHALL NOT** be stored, logged against the
identity, or used to scope the identity itself.

### 4.14 Domain events — `SEV-1` … `SEV-16`

All events are published in the `identity.` namespace, defined in `liboora_contracts`, delivered
through the outbox with at-least-once semantics, and **SHALL** be idempotent for consumers.

| ID | Event | Emitted when | Consumers |
|---|---|---|---|
| `SEV-1` | `identity.PersonIdentityCreated` | Identity created atomically with the account | `BC-23`, `BC-24`, `BC-26` |
| `SEV-2` | `identity.PersonProfileCompleted` | Pending Profile → Active | `BC-23`, `BC-24`, `BC-26` |
| `SEV-3` | `identity.PersonProfileUpdated` | Any owned profile field changed | `BC-23`, `BC-24`, `BC-26`, `BC-11` |
| `SEV-4` | `identity.PersonNameChanged` | Full Name changed | `BC-23`, `BC-24`, `BC-11` |
| `SEV-5` | `identity.PersonUsernameChanged` | Username changed | `BC-23`, `BC-24`, `BC-11`, `BC-12` |
| `SEV-6` | `identity.PersonUsernameReleased` | Previous username left the hold period (`SCFG-5`) | `BC-24` |
| `SEV-7` | `identity.PersonProfilePhotoUpdated` | Global Profile Photo set or replaced | `BC-23`, `BC-24`, `BC-11` |
| `SEV-8` | `identity.PersonProfilePhotoRemoved` | Global Profile Photo removed or hidden | `BC-23`, `BC-24`, `BC-11` |
| `SEV-9` | `identity.PersonPrivacyModeChanged` | Public ⇄ Private | `BC-23`, `BC-24`, `BC-11`, `BC-26` |
| `SEV-10` | `identity.PersonStatisticsVisibilityChanged` | Study-statistics visibility toggled | `BC-23`, `BC-24`, `BC-26` |
| `SEV-11` | `identity.PersonAchievementsVisibilityChanged` | Achievements visibility toggled | `BC-23`, `BC-24`, `BC-26` |
| `SEV-12` | `identity.PersonSuspended` | Identity suspended by Platform Administrator | `BC-23`, `BC-24`, `BC-11`, `BC-12` |
| `SEV-13` | `identity.PersonReinstated` | Suspension lifted | `BC-23`, `BC-24`, `BC-11`, `BC-12` |
| `SEV-14` | `identity.PersonArchived` | Identity archived | `BC-23`, `BC-24`, `BC-11`, `BC-12`, `BC-26` |
| `SEV-15` | `identity.PersonRestored` | Archived identity returned to Active, same `PersonId` | `BC-23`, `BC-24`, `BC-11`, `BC-26` |
| `SEV-16` | `identity.PersonAnonymised` | Underlying account erased by `BC-18` (`ID-5`) | `BC-23`, `BC-24`, `BC-11`, `BC-12`, `BC-26` |

`SID-4.51` — `SEV-1` … `SEV-16` are a **closed set** for V1. Adding an event requires an update to this
register and to the Bounded Context Map §9 event catalogue.

`SID-4.52` — Every payload **SHALL** carry: event ID · event type · schema version · `PersonId` ·
occurred-at · actor. It **SHALL NOT** carry a mobile number, email, parent contact, address,
`StudentRecordId`, `tenantId`, credential or OTP. *(`SID-4.43`, `SID-INV-5`, `SID-INV-6`.)*

`SID-4.53` — `BC-01` and other operational modules **MAY** consume these events to **invalidate a
display cache**. They **SHALL NOT** consume them to **store a copy** of a profile field, because that
would reintroduce the duplication `SID-BR-11` forbids.

`SID-4.54` — `SEV-16` **SHALL NOT** be interpreted by any consumer as authority to delete organisation
history. Organisation records are retained under legal basis and pseudonymised. *(`ID-5`.)*

### 4.15 Events consumed

| Source | Event | This module's reaction |
|---|---|---|
| `BC-18` | `iam.AccountCreated` | **None** — creation is synchronous and already complete (`SID-4.11`) |
| `BC-18` | `iam.MobileNumberChanged` | Invalidate any in-flight read-through; store nothing |
| `BC-18` | `iam.AccountErased` *(DSR chain `AUTH-9.46`…`9.60`)* | Anonymise the person; emit `SEV-16` |
| `BC-18` | `iam.AccountSuspended` | Reflect availability to consumers; **SHALL NOT** archive |
| `BC-13` | `safety.EnforcementActionTaken` | Restrict the public projection only (`SID-4.32`, `SID-4.33`) |
| `BC-25` | configuration change | Re-read typed accessors; **SHALL NOT** weaken any invariant (`SID-4.48`) |

`SID-4.55` — Consumption **SHALL** be idempotent. Re-delivery of any event above **SHALL** produce no
additional state change and no duplicate audit record.

### 4.16 Forbidden integrations — `SID-INT-1` … `SID-INT-12`

Each row is a violation, not a trade-off. Each is detectable.

| ID | Forbidden | Why | Rule | Detection |
|---|---|---|---|---|
| `SID-INT-1` | Importing `domain/library/**` | Merges two tenancy models and two privacy regimes | `X-05` | `banned_imports` |
| `SID-INT-2` | Importing `domain/social/**` | Rank inversion; makes identity depend on social | `L2` | Rank check |
| `SID-INT-3` | Storing or emitting `StudentRecordId` | Tenant identifier escapes its tenant | `ID-2` | `banned_symbols` |
| `SID-INT-4` | Storing or emitting `TenantId` | This module is not tenant-scoped | `ID-2`, `X-13` | `banned_symbols` |
| `SID-INT-5` | Storing a mobile number, OTP, session or credential | Credential data outside `BC-18` | `ID-1` | Field + payload scan |
| `SID-INT-6` | Caching an authorisation decision | Breaks immediate revocation | `MP-GBR-26`, `X-13` | Code review + revocation test |
| `SID-INT-7` | Calling `BC-22` to send a notification | Domain instructing a channel | `X-04` | `banned_imports` |
| `SID-INT-8` | Calling `BC-24` synchronously from domain code | Couples domain to audit availability | `E-20` | Code review |
| `SID-INT-9` | Reading another context's tables or index | Bypasses the published contract | `X-07`, `X-08` | Repository allow-list |
| `SID-INT-10` | Indexing a never-public field | Creates a second unguarded read path | `SID-4.39` | Index schema review |
| `SID-INT-11` | Composing the aggregated profile inside this module | Domain performing cross-context reads | `AR-1` | Layer check |
| `SID-INT-12` | Holding a collection of organisations or Student Records | Inverts the reference direction | `SID-1.38` | Schema review |

`SID-4.56` — Every row above **SHALL** be enforceable by the module boundary checker (`IMPL-014`) once
it exists, and **SHALL** be verified by review until then. A rule that cannot be checked **SHALL** be
treated as unmet, not as satisfied by intent.

---

## Chapter 5 — Security, Non-Functional Requirements, Invariants & Acceptance

### 5.1 Protected operations — `SPO-1` … `SPO-9`

A **protected operation** is one that requires an explicit authorisation decision from `BC-18` before
it may proceed. The list is **closed**: an operation not on it is either unprotected because it changes
nothing, or it is missing and the list must be amended by ADR.

| ID | Operation | Who may perform it | Notes |
|---|---|---|---|
| `SPO-1` | Create Global Person Identity | System only, atomically with account creation | No human actor may invoke this directly (`SID-4.11`) |
| `SPO-2` | View own Global Profile in full | The person (`TR-4`) | Includes fields never visible to anyone else |
| `SPO-3` | View another person's **public** profile | Any authenticated account | Allow-list only (`SID-2.28`); subject to that person's privacy mode |
| `SPO-4` | Update own Global Profile | The person (`TR-4`) | Restricted fields per §3.4 |
| `SPO-5` | Change own Username | The person (`TR-4`) | Subject to cooldown `SCFG-3` |
| `SPO-6` | Set, replace, hide or remove own Global Profile Photo | The person (`TR-4`) | No effect on any Library Identification Photo (`SID-3.22`) |
| `SPO-7` | Change own privacy mode or per-section visibility | The person (`TR-4`) | Immediate effect, no propagation window (`SID-2.30`) |
| `SPO-8` | Suspend, reinstate, archive or restore an identity **status** | Platform Administrator | **Status only** — never profile content (`SID-3.32`) |
| `SPO-9` | Resolve identity core fields for a held `PersonId` | `BC-01` through the `E-13` ACL | Non-mutating; returns only what the calling role is permitted (`SID-2.39`) |

`SID-5.1` — Every operation above **SHALL** be denied unless explicitly permitted. *(`AP-3` deny by
default.)*

`SID-5.2` — No organisation role — `TR-1` Owner, `TR-2` Manager, `TR-3` Reception — appears in this
table for any mutating operation. Organisation staff **SHALL NOT** mutate global identity state.
*(`SID-3.31`, `SID-4.20`, `AP-5`.)*

`SID-5.3` — `TR-5` Parent appears nowhere in this table. A parent's visibility is granted by an
organisation over that organisation's Student Record, not over the Global Profile. *(`SID-3.34`.)*

`SID-5.4` — This document **SHALL NOT** introduce a role name. Every role referenced is drawn from the
closed Authentication set `TR-1`…`TR-5` plus Platform Administrator (`AUTH-7.21`).

`SID-5.5` — Every denied attempt at a protected operation **SHALL** be audited with actor, target
`PersonId`, operation and reason. *(`SID-3.35`.)*

`SID-5.6` — Authorisation **SHALL** be re-evaluated per request. A previously granted decision
**SHALL NOT** be reused. *(`SID-4.14`, `MP-GBR-26`.)*

### 5.2 Data protection, minimisation & compliance

`SID-5.7` — This module **SHALL** hold the minimum data required to identify a person across the
platform. A field not needed for that purpose **SHALL NOT** be added here merely because there is
nowhere else convenient.

`SID-5.8` — The following **SHALL NEVER** exist as a stored field of this module: password, PIN, OTP,
OTP hash, session token, device record, mobile number, `StudentRecordId`, `tenantId`, parent /
guardian contact, Library Identification Photo, membership state, attendance record, seat allocation,
financial amount. *(`ID-1`, `ID-2`, `SXC-1`…`SXC-6`.)*

`SID-5.9` — Date of Birth **SHALL** be stored, because minor-safety obligations (`ID-6`) depend on it,
and **SHALL NEVER** be publicly visible in any form, including as an age, an age bracket or a birthday.

`SID-5.10` — Gender **SHALL** be optional and **SHALL** offer "prefer not to say". Absence **SHALL NOT**
block profile completion. *(`SID-2.7`, reconciliation `SC-7`.)*

`SID-5.11` — Address and Email, where provided, **SHALL** be treated as restricted fields, never public,
and **SHALL NOT** be included in any event payload or index. *(`SID-4.52`, `SID-4.39`.)*

`SID-5.12` — `PersonId` **SHALL NOT** appear in a URL, a public API response, a client-side log, an
analytics payload sent to a third party, or any user-visible surface. *(`SID-1.33`.)*

`SID-5.13` — Data at rest and in transit **SHALL** be encrypted by the platform. This module **SHALL
NOT** implement its own cryptography.

`SID-5.14` — Minor-safety obligations **SHALL** be honoured: where Date of Birth indicates a minor,
guardian consent **SHALL** be linked before any social context is activated for that person. This
module **SHALL** expose the age-derived signal required for that check and **SHALL NOT** itself
implement the social gate. *(`ID-6`.)*

`SID-5.15` — Consent to make a profile Public **SHALL** be recorded with actor, timestamp and the exact
setting consented to, and **SHALL** be revocable at any time with immediate effect. *(`SID-2.27`,
`SID-2.30`.)*

`SID-5.16` — Erasure **SHALL** be performed through `BC-18`'s DSR chain (`AUTH-9.46`…`AUTH-9.60`). On
erasure this module **SHALL** anonymise the person and emit `SEV-16`; organisation history **SHALL**
remain with `BC-01` under legal basis, pseudonymised. *(`ID-5`, `SXC-10`.)*

`SID-5.17` — A data-export request **SHALL** return the fields this module owns and **SHALL NOT**
attempt to assemble another context's data on its behalf.

### 5.3 Non-functional requirements

The supplied draft stated performance as *"no noticeable delays"*, *"fast loading"* and similar. Those
statements are not testable and are therefore replaced in full by the measurable targets below. Nothing
functional was removed in doing so.

`SID-5.18` — Every requirement in this section **SHALL** be measurable, observable or verifiable.

`SID-5.19` — Where a target cannot yet be measured, the measurement capability **SHALL** be built before
the target is claimed as met. *(Same rule as `AUTH-11.3`.)*

`SID-5.20` — A non-functional target **SHALL NOT** be met by weakening a functional, security or privacy
requirement. Specifically, no latency target **SHALL** be met by caching an authorisation decision, by
storing a copy of another context's data, or by relaxing the allow-list. *(`AUTH-11.2` class.)*

#### 5.3.1 Performance

Measured server-side at the module boundary, excluding network transit and excluding time spent inside
contributing modules during composition.

| Operation | Target (p95) | Upper bound (p99) |
|---|---|---|
| Create identity *(within the account-creation transaction)* | 300 ms | 900 ms |
| Read own Global Profile | 200 ms | 600 ms |
| Read another person's public profile | 250 ms | 700 ms |
| Update Global Profile | 400 ms | 1,200 ms |
| Username availability check | 150 ms | 400 ms |
| Username change *(including uniqueness reservation)* | 500 ms | 1,500 ms |
| Global Profile Photo `FileRef` attach | 400 ms | 1,200 ms |
| Privacy mode change *(including cache and index invalidation)* | 500 ms | 1,500 ms |
| Resolve identity core fields for `BC-01` via `E-13` | 100 ms | 300 ms |
| Emit a domain event to the outbox | 50 ms | 150 ms |

**Aggregated profile screen** — composed in the application layer from many contributors:

| Property | Target |
|---|---|
| Identity portion rendered | p95 400 ms |
| Each contributed section rendered | p95 800 ms |
| Per-contributor timeout after which the section degrades | 1,500 ms |
| Whole screen usable even if every contributor times out | Always |

`SID-5.21` — `E-13` resolution **SHALL** be the fastest path in the module, because it sits behind
operational screens used by reception staff under queue pressure.

`SID-5.22` — Performance **SHALL NOT** degrade with the number of organisations a person belongs to,
because this module holds no such collection. *(`SID-1.38` — this is a consequence of the model, and is
the property to regression-test.)*

`SID-5.23` — Performance **SHALL NOT** degrade with the number of identities on the platform beyond
logarithmic index growth.

`SID-5.24` — A slow or failed contributor **SHALL NOT** increase the latency of the identity portion.
*(`SID-2.40`.)*

#### 5.3.2 Availability & reliability

| Property | Target |
|---|---|
| Identity read availability | 99.9% monthly |
| `E-13` resolution availability | 99.95% monthly |
| Identity write availability | 99.5% monthly |
| Maximum tolerable continuous outage | 30 minutes |
| Data durability for identity records | No tolerated loss |

`SID-5.25` — `E-13` resolution is held to the highest target in this module because operational library
screens consume it. Profile **editing** is held to the lowest, because a person unable to change their
bio for ten minutes is inconvenienced, not blocked.

`SID-5.26` — Unavailability of this module **SHALL NOT** prevent check-in, seat allocation, fee
collection, membership validation or sign-in. *(`SID-4.21` — this is the availability expression of
`X-05`.)*

`SID-5.27` — Every failure mode **SHALL** fail closed with respect to visibility: if privacy mode cannot
be determined, the profile **SHALL** be treated as Private.

`SID-5.28` — No `PersonId`, identity record, username-history entry or audit event **SHALL** be lost
under any failure.

`SID-5.29` — Recovery from backup **SHALL NOT** reverse a privacy change, un-archive an archived
identity, restore a released username to its previous holder, or re-publish a profile made Private.
*(Same hazard class as `AUTH-11.17`.)*

`SID-5.30` — Loss of an in-flight profile update **SHALL** be tolerable; nothing partial **SHALL** be
persisted. *(`SID-3.9`.)*

#### 5.3.3 Scalability

| Dimension | V1 target | Design headroom |
|---|---|---|
| Global Person Identities | 100,000 | 5,000,000 |
| Identities created per hour, peak | 5,000 | 250,000 |
| Profile reads per second, peak | 500 | 25,000 |
| `E-13` resolutions per second, peak | 200 | 10,000 |
| Organisations per person | 10 | 100 |
| Username change events per day | 1,000 | 50,000 |
| Username-history entries per person | 20 | 200 |

`SID-5.31` — The design **SHALL** accommodate the headroom column without architectural change.

`SID-5.32` — Scaling **SHALL NOT** require per-organisation configuration, partitioning or deployment,
because this module is not organisation-scoped.

`SID-5.33` — Username uniqueness **SHALL** remain a single global constraint at every scale. It
**SHALL NOT** be sharded, partitioned or made eventually consistent. *(`SID-BR-3` — an eventually
consistent uniqueness constraint is not a uniqueness constraint.)*

#### 5.3.4 Observability

| Category | Required signals |
|---|---|
| Volume | Identities created · profiles updated · usernames changed · photos updated · privacy changes |
| Privacy posture | Count Public vs Private · statistics-visible count · achievements-visible count |
| Latency | Distribution for every operation in §5.3.1 |
| Composition health | Per-contributor success rate, latency and degradation count |
| Authorisation | Allow rate, deny rate, denials by operation |
| Integrity | Accounts without an identity *(**SHALL** be zero)* · identities without an account *(**SHALL** be zero)* · duplicate usernames *(**SHALL** be zero)* |
| Events | Emitted, delivered, retried, dead-lettered per `SEV-*` |

`SID-5.34` — The three integrity counters above **SHALL** be monitored continuously, and a non-zero
value **SHALL** raise an alert, because each represents a violated invariant rather than a degraded
metric.

`SID-5.35` — No log, metric label, trace attribute or error message **SHALL** contain a mobile number,
an OTP, a `PersonId`, a parent contact or an address. *(`SID-5.12`.)*

`SID-5.36` — A privacy-mode change **SHALL** be traceable end to end, including cache and index
invalidation, so that `SID-2.30` can be demonstrated rather than asserted.

#### 5.3.5 Usability & accessibility

`SID-5.37` — Profile screens **SHALL** be usable on a mid-range Android device in portrait orientation
over an unreliable mobile connection, which is the platform's primary operating condition.

`SID-5.38` — The privacy control **SHALL** state plainly what becomes visible and to whom, before the
change is applied. Consent obtained without that statement is not informed consent. *(`SID-5.15`.)*

`SID-5.39` — The distinction between the Global Profile Photo and the Library Identification Photo
**SHALL** be explained wherever both appear, so that a person hiding one does not believe they have
hidden the other. *(`SID-3.22`.)*

`SID-5.40` — A degraded section **SHALL** be labelled as temporarily unavailable and **SHALL NOT** be
rendered as empty, zero or absent, because "0 present days" and "attendance unavailable" are different
statements.

### 5.4 Domain invariants — `SID-INV-1` … `SID-INV-14`

An invariant is a statement that is true at every observable moment. A violation is a defect of the
highest severity, not a bug to be triaged.

| ID | Invariant | Enforced by |
|---|---|---|
| `SID-INV-1` | An account has exactly **one** Global Person Identity — never zero, never two | Unique constraint on `AccountId` + atomic creation |
| `SID-INV-2` | An identity exists **if and only if** its account exists; neither may exist without the other at any observable moment | Single transaction (`SID-4.11`) |
| `SID-INV-3` | `PersonId` is a UUID, immutable for the lifetime of the identity, and **never reused** — including after archival or anonymisation | Generation policy + no-delete policy |
| `SID-INV-4` | Username is unique platform-wide, case-insensitively, at every instant — including during a rename | Global unique constraint (`SID-5.33`) |
| `SID-INV-5` | No credential, OTP, session, device record or mobile number exists in this module's schema, events, logs or indices | Schema review + payload scan (`ID-1`) |
| `SID-INV-6` | No `StudentRecordId` and no `TenantId` exists in this module's schema, events, logs or indices | `banned_symbols` (`ID-2`) |
| `SID-INV-7` | No membership, attendance, seat, fee or analytics **state** is stored here; only composed for display | Schema review (`SXC-6`) |
| `SID-INV-8` | The identity holds no collection of organisations or Student Records; the reference direction is downward only | Schema review (`SID-1.38`) |
| `SID-INV-9` | Privacy mode is exactly Public or Private, and **Private** is the state of every newly created identity | Type + default (`SID-2.27`) |
| `SID-INV-10` | A field absent from the §2.28 allow-list is never publicly readable, by any caller, through any path, under any configuration | Allow-list projection (`SID-2.29`) |
| `SID-INV-11` | A never-public field is never indexed, never in an event payload, and never in a log | `SID-4.39`, `SID-4.52`, `SID-5.35` |
| `SID-INV-12` | Global profile privacy never reduces what an organisation may see about its own Student Record | Separate ownership (`SID-BR-16`) |
| `SID-INV-13` | The Global Profile Photo and the Library Identification Photo are distinct assets with independent lifecycles; neither operation on one affects the other | Distinct `FileRef`s in distinct contexts (`SID-4.37`) |
| `SID-INV-14` | Every state change and every profile change has a corresponding audit event and domain event; neither may occur without the other | Transactional outbox (`SID-BR-18`) |

`SID-5.41` — `SID-INV-1` … `SID-INV-14` **SHALL NOT** be weakened by a configuration value, feature
flag, deployment setting, migration or emergency procedure. *(`SID-4.48`.)*

`SID-5.42` — Each invariant **SHALL** have at least one automated test that fails if the invariant is
violated. An invariant asserted only in prose **SHALL** be treated as unenforced.

`SID-5.43` — `SID-INV-1`, `SID-INV-2` and `SID-INV-4` **SHALL** additionally be verified by the
continuous integrity counters of §5.3.4, because a constraint that holds in tests can still be violated
by a migration.

### 5.5 Configurable parameters — `SCFG-1` … `SCFG-11`

Every value below is configuration, owned by `BC-25`, read through a typed accessor. Every other number
in this document is a **requirement**, not a setting.

| ID | Parameter | Default | Range | Notes |
|---|---|---|---|---|
| `SCFG-1` | Username length | 3–30 characters | 3–50 | Lower bound **SHALL NOT** go below 3 |
| `SCFG-2` | Reserved-username list | Platform-managed list | — | Additive only; removing an entry requires review |
| `SCFG-3` | Username rename cooldown | 30 days | 0–365 days | 0 permitted only in non-production |
| `SCFG-4` | Username-history retention | 24 months | 12–120 months | Supports impersonation investigation |
| `SCFG-5` | Released-username hold period | 90 days | 30–365 days | **SHALL NOT** be 0 in production (`SID-2.24`) |
| `SCFG-6` | Bio maximum length | 300 characters | 0–1,000 | 0 disables the field, it does not make it public |
| `SCFG-7` | Global Profile Photo maximum size | 5 MB | 1–15 MB | Enforced by `BC-29` |
| `SCFG-8` | Global Profile Photo accepted formats | JPEG, PNG, WebP | — | Additive only |
| `SCFG-9` | Per-contributor composition timeout | 1,500 ms | 250–5,000 ms | Beyond this the section degrades (`SID-5.24`) |
| `SCFG-10` | Public-profile view rate limit | 60 per minute per account | 10–600 | Anti-scraping of the public surface |
| `SCFG-11` | Username availability-check rate limit | 30 per minute per account | 10–300 | Anti-enumeration of the username space |

`SID-5.44` — No configuration value **SHALL** be able to change the **default** privacy mode, alter the
allow-list, disable an audit event, or set `SCFG-5` to 0 in production. *(`SID-4.48`, `SID-5.41`.)*

`SID-5.45` — Every value above **SHALL** be platform-wide. None **SHALL** be organisation-configurable,
because this module is not organisation-scoped. *(`SID-4.49`.)*

`SID-5.46` — A change to any value above **SHALL** be audited with actor, previous value and new value.

### 5.6 Acceptance criteria — `SID-AC-1` … `SID-AC-26`

**This is the module's only acceptance register.** The supplied draft repeated acceptance criteria in
several chapters; those duplicates are removed and consolidated here so that a single list determines
whether the module is done. Every criterion is objectively verifiable.

| ID | Criterion | Verifies |
|---|---|---|
| `SID-AC-1` | Creating an authenticated account creates exactly one Global Person Identity in the same transaction; failure of either fails both | `SID-INV-1`, `SID-INV-2`, `SID-4.11` |
| `SID-AC-2` | No sequence of operations produces an account without an identity or an identity without an account; the integrity counters read zero | `SID-INV-2`, `SID-5.34` |
| `SID-AC-3` | `PersonId` is a UUID, never changes, and is not reissued after archival or anonymisation | `SID-INV-3` |
| `SID-AC-4` | Two accounts cannot hold the same username in any casing, including under concurrent creation | `SID-INV-4` |
| `SID-AC-5` | A newly created identity is **Private**; no action is required to make it private | `SID-INV-9`, `SID-2.27` |
| `SID-AC-6` | Making a profile Public records explicit consent with actor, timestamp and the setting consented to | `SID-5.15` |
| `SID-AC-7` | A public profile exposes **only** allow-list fields; every never-public field is absent from the response, the index and the event payload | `SID-INV-10`, `SID-INV-11` |
| `SID-AC-8` | No configuration value, feature flag or deployment setting can make a never-public field public | `SID-2.29`, `SID-5.44` |
| `SID-AC-9` | Switching Public → Private removes the profile from public reads and public search within the same operation, with no propagation window | `SID-2.30`, `SID-4.40` |
| `SID-AC-10` | A person may change their username; every relationship, event and reference survives because all key on `PersonId` | `SID-2.22`, `SID-3.39` #4 |
| `SID-AC-11` | A released username cannot be claimed by another person before `SCFG-5` elapses | `SID-2.24` |
| `SID-AC-12` | Hiding or removing the Global Profile Photo leaves every Library Identification Photo intact, and attendance and seat verification continue unaffected | `SID-INV-13`, `SID-3.22` |
| `SID-AC-13` | The Global Profile Photo and the Library Identification Photo can be set, replaced and removed independently in any order | `SID-INV-13`, `SID-4.37` |
| `SID-AC-14` | No mobile number is stored, indexed, logged or emitted by this module; the number is resolved read-through from `BC-18` under authorisation | `SID-INV-5`, `SID-4.13` |
| `SID-AC-15` | No `StudentRecordId` and no `TenantId` appears in this module's schema, events, logs or indices | `SID-INV-6`, `SID-INT-3`, `SID-INT-4` |
| `SID-AC-16` | Parent / guardian contact is never stored here; it appears on the aggregated screen only as a contribution from `BC-01` under the caller's authorisation | `SXC-3`, `SID-2.8` |
| `SID-AC-17` | Organisation staff — `TR-1`, `TR-2`, `TR-3` — cannot mutate any global profile field through any path; every attempt is denied and audited | `SID-3.31`, `SID-5.2`, `SID-5.5` |
| `SID-AC-18` | A Platform Administrator can change identity **status** but cannot edit profile content | `SID-3.32`, `SPO-8` |
| `SID-AC-19` | Every role referenced by the implementation is one of `TR-1`…`TR-5` or Platform Administrator; no new role name exists | `SID-5.4` |
| `SID-AC-20` | Every authorisation decision is obtained from `BC-18` per request and never cached; revoking access takes effect on the next request | `SID-4.14`, `SID-5.6` |
| `SID-AC-21` | An identity with no organisation membership is fully valid and usable | `SID-3.39` #10, closes `Q-05` |
| `SID-AC-22` | Joining a second organisation creates a second Student Record and **no** second identity | `SID-2.4`, `SID-BR-13` |
| `SID-AC-23` | Restoring an archived identity returns the same `PersonId` and creates no new identity | `SID-2.31` |
| `SID-AC-24` | Account erasure anonymises the person and emits `SEV-16`, while `BC-01` retains organisation history pseudonymised under legal basis | `ID-5`, `SID-5.16` |
| `SID-AC-25` | Every contributor being unavailable still renders the identity portion, with each section labelled unavailable rather than empty or zero | `SID-2.40`, `SID-5.40` |
| `SID-AC-26` | Every operation in §5.3.1 meets its p95 and p99 target under the §5.3.3 V1 load, and no target is met by caching an authorisation decision or copying another context's data | `SID-5.18`, `SID-5.20` |

`SID-5.47` — `SID-AC-1` … `SID-AC-26` are the **complete** acceptance set for V1. A criterion **SHALL
NOT** be restated elsewhere in this document, and any acceptance statement found outside this register
**SHALL** be treated as an editing error.

`SID-5.48` — Each criterion **SHALL** be demonstrated by an automated test or a recorded, repeatable
verification procedure. A criterion signed off by inspection alone **SHALL NOT** be considered met.

`SID-5.49` — The module **SHALL NOT** be declared complete while any criterion is unverified, and
**SHALL NOT** be declared complete by satisfying 25 of 26.

### 5.7 Future scope — V2 and beyond

Listed so that V1 decisions do not foreclose them. Nothing here is a V1 commitment, and nothing here
requires an identity migration — which is the point of `ADR-0011`.

| Area | Future capability | Depends on |
|---|---|---|
| Privacy | Granular and per-audience visibility tiers (`SXC-9`) | Allow-list generalised, not replaced |
| Verification | Government-ID verification, additional identity providers (`SXC-11`) | `BC-18`; this module consumes the result |
| Education products | School, College, Coaching and Hostel Student Records against the **same** identity | `MP-FUT-02`…`MP-FUT-04`; no identity change required |
| Student Network | Social graph, messaging, communities, reputation, marketplace | `BC-11`…`BC-17` as **consumers** (`SID-4.28`) |
| Portability | Person-initiated export and portability of the Global Profile | `SID-5.17` |
| Achievements | Cross-organisation achievement portfolio | `BC-26`; composed, never stored here |
| Discovery | Richer public discovery of consenting profiles | `BC-23`; allow-list unchanged |

`SID-5.50` — No future capability **SHALL** be delivered by relaxing `SID-INV-1`…`SID-INV-14`, by
adding tenant scope to this module, or by making the identity dependent on the social product. A future
requirement that appears to need one of those **SHALL** be raised as an ADR against `ADR-0011`, not
implemented as an exception.

`SID-5.51` — The permanence of the identity across all future products is the module's central
long-term guarantee. Any change that would require a person to obtain a second identity in order to
join a new education product **SHALL** be rejected.

---

## Document control

| Property | Value |
|---|---|
| Document | Student Identity & Profile PRD |
| Version | 1.0 |
| Status | Official — declared baseline |
| Owning context | `BC-10` Global Person Identity `[CORE]`, rank 7.5 |
| Governing ADR | `ADR-0011` — Global Person Identity is a platform identity, not a social profile |
| Precedence | Rank 3, alongside Authentication PRD v2.0 and Library PRD v1.0 |
| Companion documents | `STUDENT_IDENTITY_ALIGNMENT.md` · `STUDENT_IDENTITY_IMPLEMENTATION_TASKS.md` |
| Registers defined here | `SID-n.m` · `SID-BR-1`…`18` · `SID-INV-1`…`14` · `SXC-1`…`11` · `SPO-1`…`9` · `SCFG-1`…`11` · `SEV-1`…`16` · `SID-INT-1`…`12` · `SID-AC-1`…`26` |
| Closed sets | `SPO-*` protected operations · `SEV-*` domain events · `SID-AC-*` acceptance criteria · role names (Authentication `AUTH-7.21`) |
| Open questions closed | `Q-05` — a Global Person Identity exists for every account, with or without enrollment |
