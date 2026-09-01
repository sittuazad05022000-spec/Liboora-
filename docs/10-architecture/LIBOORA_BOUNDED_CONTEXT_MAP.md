# LIBOORA — Bounded Context Map (V1)

| Field | Value |
|---|---|
| **Document** | Bounded Context Map |
| **Version** | v1.10 |
| **Status** | Draft for Architecture Review Board sign-off |
| **Derived from** | `LIBOORA_ENTERPRISE_ARCHITECTURE.md` v2.0 (commit `aba0831`) |
| **Last Updated** | 2026-08-20 |
| **Context Count** | 31 (23 in V1 scope) — **unchanged by v1.1…v1.9**. **Edges: 28** — `E-01`…`E-26` (§7) + **`E-28`, `E-29`** (**§15.1**, v1.9); ⛔ `E-27` permanently vacant (withdrawn by `ADR-0033`, never reused). ⭐ **v1.9 appends §15, a NORMATIVE extension of §7 and §8** admitted by `Accepted` [`ADR-0083`](../00-governance/adr/ADR-0083-prd-021a-owner-rulings-executed.md) — **appended, not inserted**, because insertion into §7 was measured to invalidate **1,293** of this file's **2,812** line-citations against the append's **0** ([`ADR-0079`](../00-governance/adr/ADR-0079-ea-v2.3-capability-enumeration-addenda.md) §8.5 Option A). **§1–§14 byte-identical to v1.8**. ⭐ **v1.10 appends §16**, publishing the `BC-15` scoping identifier `communityId` as rules **`CID-1`…`CID-6`**, admitted by `Accepted` [`ADR-0085`](../00-governance/adr/ADR-0085-communityid-scoping-identifier-published.md) — again **appended, not inserted**; **§1–§15 byte-identical to v1.9** apart from this cell, the `Version` cell and one changelog row. **No context, edge or aggregate changes: still 31 contexts and 28 edges** |
| **Companion doc** | `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` |
| **Rulings applied** | `AR-1`, `AR-2`, `AR-3`, `AR-4`, `AR-5`, `AR-6`, `AR-7` — see [`ARCHITECTURE_RULINGS.md`](./ARCHITECTURE_RULINGS.md) |
| **Implementation status** | `ADR-0011` is **implemented in code** as of `a22fd7e` — see [`../40-implementation/IMPLEMENTATION_STATUS.md`](../40-implementation/IMPLEMENTATION_STATUS.md) |
| **ADRs applied** | `ADR-0011` amends §3.2, §4, §5 and §8 — `BC-10` becomes **Global Person Identity**, `[CORE]`, rank 7.5, cardinality `1:1`. Linkage rules `ID-1`…`ID-6` and prohibition `X-05` are **preserved**. See [`ADR-0011`](../00-governance/adr/ADR-0011-global-person-identity.md) |

---

## Table of Contents

1. [Purpose & How to Read This](#1-purpose--how-to-read-this)
2. [Platform ≠ Bounded Context](#2-platform--bounded-context)
3. [Context Register](#3-context-register)
4. [The Identity Triad](#4-the-identity-triad)
5. [Ubiquitous Language Collisions](#5-ubiquitous-language-collisions)
6. [Context Map Diagram](#6-context-map-diagram)
7. [Integration Relationships](#7-integration-relationships)
8. [Aggregate & Invariant Register](#8-aggregate--invariant-register)
9. [Published Language — Event Surface](#9-published-language--event-surface)
10. [Transaction & Consistency Boundaries](#10-transaction--consistency-boundaries)
11. [Multi-Tenancy in the Context Map](#11-multi-tenancy-in-the-context-map)
12. [Microservice Extraction Order](#12-microservice-extraction-order)
13. [Open Questions](#13-open-questions)
14. [Architecture Rulings](#14-architecture-rulings)

---

## 1. Purpose & How to Read This

The architecture tree answers *"what capabilities exist and who owns them."*
This document answers the harder question: **"where are the model boundaries, and what is allowed to cross them."**

A bounded context in LIBOORA is a **linguistic and transactional boundary**. Inside it, one term means exactly one thing and invariants are enforced synchronously. Across it, meaning must be translated and consistency is eventual.

**Three rules govern this document:**

| Rule | Statement |
|---|---|
| **R1 — One language per context** | A term (`Student`, `Member`, `Attendance`, `Payment`) resolves to exactly one model inside a context. If two contexts need the word differently, they are two contexts. No shared "Student" class. |
| **R2 — One writer per aggregate** | Exactly one context may mutate an aggregate. Every other context reads a projection or reacts to an event. Cross-context writes go through the owner's command API — never through the database. |
| **R3 — Cross-context = eventual** | No distributed transaction. Cross-context consistency is achieved by domain event + idempotent handler, orchestrated by a saga when compensation is required. |

**Notation used below**

| Marker | Meaning |
|---|---|
| `[CORE]` | Core Domain — competitive differentiator, highest modelling investment, best engineers |
| `[SUPPORTING]` | Supporting Domain — needed, LIBOORA-specific, but not the moat |
| `[GENERIC]` | Generic Subdomain — solved problem; buy or use a thin in-house wrapper |
| `⇢` | Upstream → Downstream flow (upstream shapes the contract) |
| `ACL` | Anti-Corruption Layer required at the receiving side |
| `OHS` | Open Host Service — the context publishes a stable, versioned public API |
| `PL` | Published Language — a versioned shared schema (events / DTOs) |
| `SK` | Shared Kernel — a deliberately shared model, jointly owned, changes require both owners' approval |
| `CF` | Conformist — downstream accepts the upstream model as-is, no translation |
| `C/S` | Customer / Supplier — downstream's needs are negotiated into upstream's backlog |

---

## 2. Platform ≠ Bounded Context

The single most important correction this document makes to the architecture tree:

> **`LIBRARY MANAGEMENT PLATFORM` is not one bounded context. It is six.**

A platform is an **ownership and deployment grouping**. A bounded context is a **model boundary**. Treating the whole Library Management Platform as one model produces the exact monolith we are trying to avoid: a `Student` class with 60 fields serving enrollment, attendance, seating, billing and analytics simultaneously.

| Platform | Decomposes into | Why |
|---|---|---|
| **LIBRARY MANAGEMENT** | Enrollment · Membership · Attendance · Seating · Fee & Collection · Library Policy | Six independent lifecycles, six different rates of change, six different invariant sets. Attendance writes thousands of rows/day; Enrollment writes once per student. |
| **GLOBAL STUDENT** | Global Identity · Social Graph · Messaging · Trust & Safety · Content Sharing · Community · Reputation · Marketplace | Messaging is a high-throughput, low-consistency context. Trust & Safety must be able to act *on* every other context — it cannot be a peer inside one model. |
| **BUSINESS PLATFORM** | Subscription & Billing · Entitlement | Entitlement is read on every request by every context; Billing is written rarely by one context. Radically different NFRs. |
| Everything else | 1 platform ≈ 1 context | These are already correctly scoped. |

Dashboards (`Owner`, `Manager`, `Reception`, `Parent`) are **not contexts**. They are presentation compositions over read models. They own no aggregate and no invariant. This is already stated in the tree and is reaffirmed here.

**Library Discovery & Enrollment is likewise not a context** (ruling `AR-1`). It is an application / read composition capability of the Library domain: it owns **no aggregate, no invariant and no business state**, it orchestrates **public read models only**, and it delegates every domain operation to the owning module — registration to `BC-18`, membership creation to `BC-02`, student records to `BC-01`. It composes `BC-19`, `BC-25`, `BC-29`, `BC-06`, `BC-02` and `BC-04` through `BC-23`, and **references those contexts rather than duplicating them**. No `BC-` identifier is assigned; the context count remains 31.

---

## 3. Context Register

### 3.1 Core Domain Contexts

| ID | Context | Type | Owning Platform | V | Responsibility (one sentence) |
|---|---|---|---|---|---|
| **BC-01** | **Enrollment** | `[CORE]` | Library Management | V1 | Owns the identity and lifecycle of a person *as a student of this library*: registration, profile, status, guardian linkage, documents. |
| **BC-02** | **Membership** | `[CORE]` | Library Management | V1 | Owns the commercial right-to-use: which plan a student holds, for what term, and whether it is currently valid. |
| **BC-03** | **Attendance** | `[CORE]` | Library Management | V1 | Owns the verified record of physical presence: check-in, check-out, verification method, fraud controls, corrections. |
| **BC-04** | **Seating** | `[CORE]` | Library Management | V1 | Owns physical space allocation: layout, seat inventory, assignment, transfer, live occupancy. |
| **BC-05** | **Fee & Collection** | `[CORE]` | Library Management | V1 | Owns money owed by a **student to the library**: fee structures, dues, receipts, discounts, refunds, cash reconciliation. |
| **BC-06** | **Library Policy** | `[CORE]` | Library Management | V1 | Owns the operating rules of a branch: working hours, holidays, attendance rules, seat rules, grace periods. The rule *source*; other contexts are rule *consumers*. |
| **BC-07** | Staff & Shift | `[SUPPORTING]` | Library Management | V2 | Owns staff records, shift schedules and **staff** attendance (distinct from BC-03). |
| **BC-08** | Inventory | `[SUPPORTING]` | Library Management | V2 | Owns books, furniture, devices, consumables, stock movements, issue/return. |
| **BC-09** | Visitor | `[SUPPORTING]` | Library Management | V2 | Owns non-student entry: visitor registration, passes, logs. |

**Why six core contexts and not one:** consider the invariant *"a student may not be seated without a valid membership."* If Enrollment, Membership and Seating are one model, this is an `if` statement buried in a service and enforced inconsistently in four places. As three contexts, it becomes an explicit **policy at the Seating boundary** consuming a published `MembershipValidity` projection — testable, auditable, and impossible to bypass.

### 3.2 Global Person Identity & Student Network

**Amended by `ADR-0011`.** `BC-10` is no longer part of the Global Student platform or the Social cluster. It is a **platform identity at rank 7.5** — its own tier, below every domain module and above every capability platform — and is classified `[CORE]`. `BC-11`…`BC-17` remain the Student Network. Social contexts are **consumers** of `BC-10`; they do not own it, and disabling the social product entirely must leave every identity fully usable.

| ID | Context | Type | Owning Platform | V | Responsibility |
|---|---|---|---|---|---|
| **BC-10** | **Global Person Identity** | `[CORE]` | Platform Identity *(rank 7.5)* | V1 | Owns the person's **permanent platform-wide identity**: `PersonId`, username, global profile, profile photo, privacy. Created **atomically and mandatorily** with the authentication account (`1:1`). Organisation-neutral — holds no `tenantId`, no `StudentRecordId` and no operational data. **Not a social profile** — see `ADR-0011`. |
| **BC-11** | **Social Graph** | `[SUPPORTING]` | Global Student | V1 | Owns relationships: friend requests, friendships, blocks, rate limits on graph mutation. |
| **BC-12** | **Messaging** | `[SUPPORTING]` | Global Student | V1 | Owns conversations and messages, delivery guarantees, retention, presence. |
| **BC-13** | **Trust & Safety** | `[CORE]` ⚠ | Global Student | V1 | Owns abuse reports, moderation decisions, strikes, bans, minor-safety enforcement. **Classified CORE despite living in a Supporting platform** — on a minor-heavy product this is existential legal risk, not a commodity. |
| **BC-14** | Content Sharing | `[SUPPORTING]` | Global Student | V2 | Owns user-generated notes, media, links; copyright and takedown. |
| **BC-15** | Community & Groups | `[SUPPORTING]` | Global Student | V2 | Owns communities, study groups, membership of groups, community roles. |
| **BC-16** | Reputation | `[SUPPORTING]` | Global Student | V3 | Owns reputation score, badges, levels, anti-gaming. |
| **BC-17** | Marketplace | `[SUPPORTING]` | Global Student | V3 | Owns listings, orders, listing moderation. |

### 3.3 Generic / Platform Contexts

| ID | Context | Type | Owning Platform | V | Responsibility |
|---|---|---|---|---|---|
| **BC-18** | **Identity & Access** | `[GENERIC]` | Identity & Access | V1 | Owns credentials, sessions, devices, OTP, roles, permissions, policy decisions, consent. |
| **BC-19** | **Tenancy** | `[GENERIC]` | Shared Core | V1 | Owns the tenant (library organisation) record, tenant context propagation, tiers, residency, lifecycle. |
| **BC-20** | **Subscription & Billing** | `[GENERIC]` | Business | V1 | Owns money owed by a **library to LIBOORA**: plans, subscriptions, invoices, gateway, dunning, revenue recognition. |
| **BC-21** | **Entitlement** | `[GENERIC]` | Business | V1 | Owns the answer to *"is tenant T allowed to do X, and how much of it is left?"* Single source of truth for limits and gates. |
| **BC-22** | **Notification Delivery** | `[GENERIC]` | Communication | V1 | Owns channel selection, templates, deduplication, quiet hours, delivery guarantees, consent/unsubscribe. |
| **BC-23** | **Search Indexing** | `[GENERIC]` | Search | V1 | Owns indices, permission-aware indexing, tenant index isolation, relevance, query rewriting. |
| **BC-24** | **Audit Trail** | `[GENERIC]` | Audit | V1 | Owns the immutable append-only record of who did what, including AI actions and support access. |
| **BC-25** | **Configuration** | `[GENERIC]` | Configuration | V1 | Owns settings hierarchy, feature flags, branding values, secret *references*. |
| **BC-26** | **Analytics Read Model** | `[GENERIC]` | Analytics | V1 | Owns the metric/semantic layer, read-model store, projections, reports, exports. |
| **BC-27** | **AI Assistance** | `[SUPPORTING]` | AI | V1 | Owns prompts, agents, RAG retrieval, memory, guardrails, PII redaction, human-in-the-loop, model routing. |
| **BC-28** | Workflow Orchestration | `[GENERIC]` | Workflow | V2 | Owns long-running process definitions, sagas, scheduling, compensation, DLQ. |
| **BC-29** | **File & Media** | `[GENERIC]` | Platform Services | V1 | Owns upload, virus scan, thumbnailing, signed URLs, storage abstraction. |
| **BC-30** | **Offline Sync** | `[GENERIC]` | Platform Services | V1 | Owns the client mutation queue, replay, conflict detection and resolution policy. |
| **BC-31** | **Integration** | `[GENERIC]` | Integration | V1 | Owns outbound third-party contracts, credentials, retries, idempotent delivery. |

### 3.4 Scope Summary

| Scope | Count | Contexts |
|---|---|---|
| **V1** | 23 | BC-01→06, BC-10→13, BC-18→27, BC-29→31 |
| **V2** | 6 | BC-07, BC-08, BC-09, BC-14, BC-15, BC-28 |
| **V3** | 2 | BC-16, BC-17 |
| **Core-classified** | 8 | BC-01→06 + BC-10 + BC-13 |

**Investment rule:** `[CORE]` contexts get hand-written rich domain models, exhaustive unit tests, and ADR-level scrutiny on every change. `[GENERIC]` contexts get the thinnest wrapper that satisfies the port — prefer configuration over code, and buy over build wherever a vendor exists.

---

## 4. The Identity Triad

This is the highest-risk modelling decision in LIBOORA and the one most likely to be got wrong by a team moving fast.

**A single human being appears in three contexts with three different identities and three different lifecycles.** Collapsing them into one `User` table is the mistake that makes multi-library membership, privacy, and account deletion unimplementable later.

| Identity | ID type | Owner | Scope | Lifecycle |
|---|---|---|---|---|
| **Account** | `AccountId` | BC-18 Identity & Access | Global, cross-tenant | Created on first successful OTP. Destroyed on account deletion. Holds *credentials only*. |
| **Person / Global Student** | `PersonId` | BC-10 Global Person Identity | Global, cross-tenant | Created **atomically with the Account** and mandatory for every account (`ADR-0011`). Holds global profile, username, privacy. Permanent for the person's lifetime on the platform; reused unchanged by future School, College and Coaching products. **Always exists** for an authenticated person, with or without any enrollment. |
| **Student Record** | `StudentRecordId` | BC-01 Enrollment | **Per-tenant** | Created when a library enrolls them. One human enrolled at three libraries has **three** `StudentRecordId`s. Survives account deletion (financial/audit record). |

### 4.1 The Linkage Rules

```
AccountId  1 ──── 1     PersonId          (mandatory, atomic — ADR-0011)
AccountId  1 ──── 0..*  StudentRecordId   (one login, many library enrollments)
PersonId   1 ──── 0..*  StudentRecordId   (identity spans organisations; reference points UPWARD only)
StudentRecordId ── 1     TenantId          (ALWAYS tenant-scoped, no exceptions)
```

| Rule | Statement | Enforcement |
|---|---|---|
| **ID-1** | No context outside BC-18 may store a password, OTP, session or credential. | Security review + schema scan in CI |
| **ID-2** | `StudentRecordId` **never** leaves its tenant. It must not appear in any Global Student context, event or index. | Cross-tenant leak test suite (Quality Platform) |
| **ID-3** | Global and social contexts (BC-10→17) key exclusively on `PersonId`. They must not be able to resolve which library a person attends unless the person explicitly published it. | ACL at the BC-10 boundary |
| **ID-4** | Library contexts (BC-01→09) key exclusively on `StudentRecordId`. They hold a **non-nullable** `PersonId` reference, because every account now has an identity (`ADR-0011`). | Non-nullable by design; FK to BC-10 via the E-13 ACL |
| **ID-5** | Account deletion (DSR) deletes the `Account` and anonymises the `Person`. It **does not** delete `StudentRecord` financial and attendance history — that is retained under legal basis and pseudonymised. | Data Privacy runbook + retention policy |
| **ID-6** | A minor's `Account` is linked to a guardian consent record before any social context is activated. | BC-18 Consent Management gate |

### 4.2 Why this matters commercially

Multi-library membership (V2) and Cross-Product Identity (Future) are both listed in the tree. Neither is achievable if `StudentRecordId` and `PersonId` are the same column. This triad is what makes those roadmap items a schema-compatible extension rather than a rewrite.

**Why the split survives `ADR-0011`.** Making `PersonId` mandatory removes the optionality, not the separation. `ID-5` is the load-bearing reason: erasure must delete the Account, anonymise the Person, and **retain** organisation financial and attendance history pseudonymised under legal basis. Merging `PersonId` and `StudentRecordId` makes that simultaneously-required outcome impossible to express. The identity is now permanent so that a person joining a Library, then a School, then a Coaching Institute never needs a second identity — the migration `ADR-0011` exists to prevent.

---

## 5. Ubiquitous Language Collisions

Each row is a word that means **different things in different contexts**. Every one of these is a latent bug. The resolution column is binding: these are the names that must appear in code, APIs, events and UI copy.

| Ambiguous word | Context A meaning | Context B meaning | Resolution (binding) |
|---|---|---|---|
| **Student** | BC-01: an enrolled record in *this* library, with dues and a seat | BC-10: the person's permanent platform-wide identity | `StudentRecord` (BC-01) vs `GlobalPersonIdentity` (BC-10). The bare word `Student` is **banned** in shared code. |
| **Member** | BC-02: a holder of a paid library membership plan | BC-15: a participant in a community/study group | `MembershipHolder` (BC-02) vs `CommunityMember` (BC-15) |
| **Attendance** | BC-03: a student's verified physical presence, drives occupancy & fee logic | BC-07: a staff member's shift presence, drives payroll | `StudentAttendance` vs `StaffAttendance`. Never a shared table. |
| **Payment** | BC-05: cash/UPI collected from a student at reception | BC-20: a card charge from a library owner to LIBOORA | `FeePayment` (BC-05) vs `SubscriptionCharge` (BC-20) |
| **Plan** | BC-02: a library's membership offering to students (e.g. "Monthly Night Shift") | BC-20: LIBOORA's SaaS tier sold to library owners (e.g. "Pro") | `MembershipPlan` (BC-02) vs `SubscriptionPlan` (BC-20) |
| **Invoice** | BC-05: a fee demand issued to a student | BC-20: a tax invoice issued to a library | `FeeDue` (BC-05) vs `SubscriptionInvoice` (BC-20) |
| **Notification** | BC-22: a message dispatched over a channel | BC-01: an in-app item in the student's feed | `DeliveryMessage` (BC-22) vs `FeedItem` (owned by BC-22's inbox projection) |
| **Report** | BC-26: a defined analytical output | BC-13: an abuse report filed by a user | `AnalyticalReport` (BC-26) vs `AbuseReport` (BC-13) |
| **Session** | BC-18: an authenticated login session | BC-15: a scheduled study session | `AuthSession` (BC-18) vs `StudySession` (BC-15) |
| **Profile** | BC-01: internal student profile visible to staff | BC-10: public profile visible to peers | `StudentProfile` (BC-01, tenant-internal) vs `PublicProfile` (BC-10) |
| **Status** | BC-01: Active/Inactive/Suspended/Archived enrollment state | BC-02: Valid/Expired/Frozen membership state | `EnrollmentStatus` vs `MembershipStatus`. **Two independent state machines** — a student can be Active with an Expired membership. |
| **Library** | BC-19: the tenant organisation (billing entity) | BC-06: a physical branch with hours and seats | `TenantOrganisation` (BC-19) vs `Branch` (BC-06). Critical for Multi-Branch (V3). |
| **Seat** | BC-04: a physical numbered position in a layout | BC-02: an allowance count in a plan ("2 seats included") | `Seat` (BC-04) vs `SeatQuota` (BC-21 Entitlement) |
| **Role** | BC-18: a permission bundle (Owner/Manager/Reception) | BC-15: a community role (Admin/Moderator) | `AccessRole` (BC-18) vs `CommunityRole` (BC-15) |

**Enforcement:** a CI lint rule (see companion doc §7) fails the build if a banned bare term appears in a cross-context contract file. Ubiquitous language is not documentation — it is a compile-time constraint.

---

## 6. Context Map Diagram

```
                          ┌───────────────────────────────────────────────┐
                          │            EDGE / COMPOSITION                 │
                          │   API PLATFORM  ·  BFF  ·  Dashboards         │
                          │   (owns no aggregate — composes read models)  │
                          └───────────────────────┬───────────────────────┘
                                                  │ OHS (versioned REST/GraphQL)
        ┌─────────────────────────────────────────┴─────────────────────────────────────────┐
        │                                                                                   │
╔═══════▼═══════════════════════════════════════╗              ╔═══════════════════════════▼═══════╗
║   CORE  ·  LIBRARY MANAGEMENT (tenant-scoped) ║              ║  SUPPORTING · GLOBAL STUDENT      ║
║                                               ║              ║        (global, PersonId)         ║
║  ┌──────────────┐   guardian    ┌───────────┐ ║              ║  ┌───────────────────────────┐    ║
║  │  BC-01       │◄──linkage────►│  BC-06    │ ║              ║  │ BC-10 Global Identity     │    ║
║  │  Enrollment  │  consumes     │  Library  │ ║   ACL        ║  │        (PersonId owner)   │    ║
║  │ [StudentRec] │  policy       │  Policy   │ ║  ╔═══════╗   ║  └────┬─────────────┬────────┘    ║
║  └──┬────────┬──┘               └─────┬─────┘ ║  ║       ║   ║       │             │             ║
║     │        │                        │       ║  ║ Sepa- ║   ║  ┌────▼──────┐  ┌───▼───────────┐ ║
║     │ C/S    │ C/S              policy│       ║  ║ rate  ║   ║  │ BC-11     │  │ BC-12         │ ║
║  ┌──▼─────┐ ┌▼──────────┐             │       ║  ║ Ways  ║   ║  │ Social    │◄─┤ Messaging     │ ║
║  │ BC-02  │ │ BC-03     │◄────────────┘       ║  ║  ──   ║   ║  │ Graph     │  │               │ ║
║  │Member- │ │ Attendance│                     ║  ║ NO    ║   ║  └────┬──────┘  └───┬───────────┘ ║
║  │ ship   │ └────┬──────┘                     ║  ║ direct║   ║       │             │             ║
║  └──┬─────┘      │ occupancy                  ║  ║ model ║   ║       └──────┬──────┘             ║
║     │ validity   │                            ║  ║ reuse ║   ║        ┌─────▼──────────┐        ║
║     │        ┌───▼──────┐                     ║  ╚═══════╝   ║        │ BC-13 Trust &  │        ║
║     │        │ BC-04    │                     ║              ║        │ Safety  [CORE] │        ║
║     └───────►│ Seating  │                     ║              ║        │ (acts ON all)  │        ║
║              └──────────┘                     ║              ║        └────────────────┘        ║
║  ┌──────────┐                                 ║              ╚═══════════════════════════════════╝
║  │ BC-05    │  dues from membership + policy   ║
║  │ Fee &    │◄─────────────────────────────    ║          ⚠ BC-05 (student→library money)
║  │Collection│                                 ║             is NOT BC-20 (library→LIBOORA money)
║  └──────────┘                                 ║
╚═══════════════════════════════════════════════╝

        ── all of the above depend DOWNWARD on ports / events only ──
                                  │
╔═════════════════════════════════▼═════════════════════════════════════════════════════════╗
║                        CAPABILITY & GENERIC CONTEXTS                                      ║
║  These MUST NOT import any domain context. They learn about the domain only via           ║
║  Published Language events and registered handler ports.                                  ║
║                                                                                           ║
║  BC-21 Entitlement ◄── consulted by every write path      BC-27 AI Assistance             ║
║  BC-20 Subscription & Billing ──► emits EntitlementChanged BC-26 Analytics Read Model     ║
║  BC-22 Notification Delivery   ◄── event-driven only      BC-23 Search Indexing           ║
║  BC-24 Audit Trail             ◄── event-driven only      BC-28 Workflow (V2)             ║
║  BC-29 File & Media   BC-30 Offline Sync   BC-31 Integration                              ║
╚═══════════════════════════════════════════════════════════════════════════════════════════╝
                                  │
╔═════════════════════════════════▼═════════════════════════════════════════════════════════╗
║  FOUNDATIONAL  ·  BC-18 Identity & Access   ·   BC-19 Tenancy   ·   BC-25 Configuration   ║
║  Every context depends on these three. They depend on nothing above them.                 ║
╚═══════════════════════════════════════════════════════════════════════════════════════════╝
                                  │
╔═════════════════════════════════▼═════════════════════════════════════════════════════════╗
║  SHARED KERNEL  ·  liboora_contracts                                                       ║
║  Value objects (TenantId, PersonId, Money, DateRange), event schemas, error taxonomy.      ║
║  Importable by ALL. Imports NOTHING. Changes require Architecture Review Board approval.   ║
╚═══════════════════════════════════════════════════════════════════════════════════════════╝
```

**Two structural observations worth internalising:**

1. **`Separate Ways` between Library Management and Global Student is deliberate.** The temptation is to link them tightly ("show a student's friends in the reception dashboard"). Resisting that is what keeps the social product's outages, moderation problems and privacy obligations from taking down the paying product. The only bridge is a `PersonId` and an ACL (`E-13`). **`ADR-0011` does not weaken this.** Making the identity mandatory changes who owns it, not who may reach across the boundary: `BC-10` is now a rank-7.5 platform identity that library modules may depend on downward, while `BC-11`…`BC-17` remain `Separate Ways` from Library Management. A library module may resolve an identity; it still may not reach a social graph.

2. **`BC-13 Trust & Safety` acts *on* other contexts, not beside them.** It needs the ability to hide content, suspend a `PersonId`, and freeze messaging — capabilities that would create cycles if modelled as normal peer calls. Resolution: T&S publishes `EnforcementActionTaken` events and other contexts subscribe and self-restrict. T&S never reaches into their models.

---

## 7. Integration Relationships

Every edge that crosses a context boundary in V1. If an edge is not in this table, it **does not exist** and adding it requires an ADR.

### 7.1 Core ↔ Core

| # | Upstream | Downstream | Pattern | Mechanism | Contract |
|---|---|---|---|---|---|
| E-01 | BC-01 Enrollment | BC-02 Membership | `C/S` | Event | `StudentEnrolled`, `StudentStatusChanged` → Membership may not exist without an active enrollment |
| E-02 | BC-02 Membership | BC-04 Seating | `C/S` + `PL` | Read projection | `MembershipValidity{studentRecordId, validUntil, seatQuota}` — Seating **rejects** assignment if invalid |
| E-03 | BC-02 Membership | BC-03 Attendance | `C/S` + `PL` | Read projection | Same projection — Attendance records presence but flags `membershipInvalid` rather than blocking entry (business decision: never lock a paying student out at the door) |
| E-04 | BC-06 Library Policy | BC-03 Attendance | `CF` | Sync port | `AttendanceRules{openTime, closeTime, graceMinutes, lateEntryPolicy}` — Attendance conforms, does not translate |
| E-05 | BC-06 Library Policy | BC-04 Seating | `CF` | Sync port | `SeatRules{maxTransfersPerDay, reservationWindow}` |
| E-06 | BC-06 Library Policy | BC-05 Fee & Collection | `CF` | Sync port | `HolidayCalendar` for proration and freeze-day computation |
| E-07 | BC-02 Membership | BC-05 Fee & Collection | `C/S` | Event | `MembershipCreated/Renewed/Upgraded/Frozen` → generates or adjusts `FeeDue` |
| E-08 | BC-03 Attendance | BC-04 Seating | `PL` | Event | `StudentCheckedIn/CheckedOut` → Seating updates live occupancy. **Seating is the occupancy owner**, Attendance is the trigger |
| E-09 | BC-01 Enrollment | BC-05 Fee & Collection | `C/S` | Event | `StudentArchived` → Fee context asserts no outstanding dues, else blocks with a domain error |
| E-10 | BC-05 Fee & Collection | BC-02 Membership | `C/S` | Event | `FeePaymentReceived` → may activate a pending membership (saga in V2, direct handler in V1) |

**Note on E-03 vs E-02 asymmetry:** Seating *blocks* on invalid membership; Attendance *records and flags*. This is intentional and is a business rule, not an inconsistency. Documented here so a future engineer does not "fix" it.

### 7.2 Core ↔ Supporting (the guarded bridge)

| # | Upstream | Downstream | Pattern | Mechanism | Contract |
|---|---|---|---|---|---|
| E-11 | BC-18 Identity | BC-01 Enrollment | `CF` | Sync port | `AccountId` resolution on login; Enrollment stores it, never mutates it |
| E-12 | BC-18 Identity | BC-10 Global Person Identity | `CF` | Sync port, **same transaction** | `AccountId` → `PersonId` created **atomically and mandatorily** with the account. Failure of either fails both (`ADR-0011`). Also carries mobile-number read-through and authorisation questions |
| E-13 | BC-01 Enrollment | BC-10 Global Person Identity | **`ACL`** | Sync port through an ACL | Enrollment resolves identity core fields for the `PersonId` it holds. **The only bridge between the two worlds.** Enrollment stores a **non-nullable** `personId` (`ADR-0011`); Global Person Identity stores **no** `StudentRecordId` and **no** `tenantId` (rule `ID-2`). Reference direction is **upward only** — the identity holds no list of records |
| E-14 | BC-13 Trust & Safety | BC-11, BC-12, BC-14, BC-15 | `PL` | Event | `EnforcementActionTaken{personId, action, scope, until}` → each context self-restricts. T&S never writes into them |
| E-15 | BC-10 Global Identity | BC-11 Social Graph | `SK` | Shared kernel | `PersonId` + `PrivacyPolicy` value objects are jointly owned |
| E-16 | BC-11 Social Graph | BC-12 Messaging | `C/S` | Sync port | `canMessage(a, b)` — Messaging must ask; block enforcement lives in the graph |

### 7.3 Domain → Capability (downward, ports only)

| # | Consumer (domain) | Provider (capability) | Pattern | Mechanism | Notes |
|---|---|---|---|---|---|
| E-17 | All write paths | BC-21 Entitlement | `CF` | Sync port `check(tenantId, feature, delta)` | Called **before** the aggregate mutates. Fail-closed on timeout for paid gates, fail-open for soft limits — decided per feature, recorded in Config |
| E-18 | All contexts | BC-19 Tenancy | `SK` | Ambient `TenantContext` | Propagated, never passed as a parameter through domain methods |
| E-19 | All contexts | BC-25 Configuration | `CF` | Sync port | Typed config accessors; no raw string lookups in domain code |
| E-20 | All contexts | BC-24 Audit Trail | `PL` | Event (fire-and-forget, outbox-backed) | Domain never calls audit synchronously |
| E-21 | BC-01, BC-10 | BC-23 Search Indexing | `PL` | Event | `*Created/Updated/Deleted` → index. Search never reads domain tables |
| E-22 | BC-01, BC-10, BC-12, BC-14 | BC-29 File & Media | `CF` | Sync port | Domain holds a `FileRef`, never bytes or a raw storage path. `BC-10` added by [`ADR-0016`](../00-governance/adr/ADR-0016-e22-consumer-list-includes-bc-10.md) — required by `SID-4.35`. `BC-12` added by [`ADR-0055`](../00-governance/adr/ADR-0055-e22-consumer-list-includes-bc-12.md) — required by `FIL-FR-075`…`FIL-FR-082`, V1 student-to-student file sharing. **`BC-11` and `BC-13` are deliberately NOT consumers** — `ADR-0055` §3 tested necessity per context: `BC-11` answers eligibility as a boolean and never holds a `FileRef`; `BC-13` reaches this context outbound by `E-14` |
| E-23 | All contexts | BC-22 Notification Delivery | `PL` | Event | Domain emits *facts* (`MembershipExpiringSoon`), never "send an SMS" |
| E-24 | BC-03 Attendance | BC-30 Offline Sync | `CF` | Sync port | Attendance defines the conflict-resolution policy; Sync executes it |
| E-25 | BC-20 Billing | BC-31 Integration | `CF` | Sync port | Gateway abstraction; Billing knows no vendor names |
| E-26 | BC-27 AI | BC-26 Analytics, BC-23 Search | `CF` | Sync port | AI retrieves through permission-aware ports only — never direct index or table access |

### 7.4 Capability → Domain: the forbidden direction

| Rule | Statement |
|---|---|
| **F-1** | **No capability context may import, reference, or query a domain context.** Not AI, not Analytics, not Search, not Notification, not Workflow, not Audit. |
| **F-2** | Capability contexts learn about the domain **exclusively** through Published Language events defined in `liboora_contracts`. |
| **F-3** | Where a capability must *cause* a domain change (e.g. Workflow expiring a membership, AI applying a suggestion), it does so by **invoking the domain's public command API** through a registered port — with the domain re-validating every invariant. The capability is an untrusted caller. |
| **F-4** | AI-initiated domain writes additionally require a Human-in-the-Loop approval record (BC-27) and produce an `AI Action Log` entry (BC-24). No exceptions in V1. |

This single set of rules is what makes the "Future Microservice readiness" claim in the architecture tree real rather than aspirational: every capability context can be lifted out with no domain code changes, because it never depended on domain code in the first place.

### 7.5 Relationship Pattern Distribution

| Pattern | Count | Where |
|---|---|---|
| Customer/Supplier (`C/S`) | 8 | Core↔Core lifecycle dependencies, Entitlement |
| Conformist (`CF`) | 10 | Domain → capability ports, Policy → consumers |
| Published Language (`PL`) | 7 | All event-based integration |
| Anti-Corruption Layer (`ACL`) | 1 | E-13 Enrollment ↔ Global Identity — the only place translation is mandatory |
| Shared Kernel (`SK`) | 2 | `liboora_contracts`, `PersonId`/privacy VOs |
| Separate Ways | 1 | Library Management ⟷ Student Network `BC-11`…`BC-17` (structural). **`BC-10` is excluded** — it is a rank-7.5 platform identity that library modules depend on downward via `E-13` (`ADR-0011`) |
| Open Host Service (`OHS`) | 1 | API Platform edge |

A healthy map has **few ACLs and few Shared Kernels**. Two shared kernels and one ACL across 31 contexts is a good ratio — it means boundaries were drawn where the language actually changes, not arbitrarily.

---

## 8. Aggregate & Invariant Register

One row per aggregate. **The aggregate is the transaction boundary** — one aggregate, one database transaction, no exceptions.

| Context | Aggregate Root | Key entities / VOs | Invariants enforced synchronously inside the boundary |
|---|---|---|---|
| BC-01 Enrollment | `StudentRecord` | `ContactDetails`, `GuardianLink`, `DocumentRef`, `EnrollmentStatus` | Unique (tenant, enrollmentNumber); at least one contactable channel; guardian mandatory if age < 18; cannot Archive with open dues (checked via E-09 pre-condition) |
| BC-02 Membership | `Membership` | `MembershipPlanRef`, `Term(DateRange)`, `FreezeWindow[]`, `MembershipStatus` | No overlapping active terms for one `StudentRecordId`; `validUntil > validFrom`; freeze days ≤ plan allowance; upgrade preserves paid value (proration computed, not guessed) |
| BC-03 Attendance | `AttendanceDay` *(aggregate = one student-day, not one punch)* | `Punch`, `VerificationEvidence(GPS/WiFi/QR)`, `CorrectionRecord` | Check-out cannot precede check-in; **idempotent by (studentRecordId, date, idempotencyKey)**; no more than one open session per student; corrections are append-only with actor + reason |
| BC-04 Seating | `SeatAllocation` · `SeatLayout` | `Seat`, `Floor`, `SeatCategory`, `OccupancySnapshot` | **One active allocation per seat per time window** (pessimistic lock / DB unique constraint — never optimistic); allocation requires valid membership (E-02); layout edits cannot orphan an active allocation |
| BC-05 Fee & Collection | `FeeLedger` *(per student)* | `FeeDue`, `Receipt`, `Discount`, `RefundRecord`, `Money` | Ledger balance = Σ dues − Σ receipts (never stored independently); receipt is immutable once issued; refund ≤ received; discount requires an authorised approver role |
| BC-06 Library Policy | `BranchPolicy` | `WorkingHours`, `HolidayCalendar`, `AttendanceRules`, `SeatRules` | Working hours non-overlapping per weekday; policy changes are versioned with `effectiveFrom` (never retroactive — historical attendance must remain judgeable under the rules that were live at the time) |
| BC-10 Global Identity | `GlobalStudentProfile` | `Username`, `PrivacySettings`, `VerificationState` | Globally unique username; privacy default = most restrictive; minors cannot set profile to public |
| BC-11 Social Graph | `Friendship` · `BlockList` | `FriendRequest`, `RateLimitCounter` | Symmetric friendship; block is unilateral and overrides friendship; request rate limit per rolling window; no self-friendship |
| BC-12 Messaging | `Conversation` | `Message`, `DeliveryReceipt`, `RetentionPolicy` | Participants must satisfy `canMessage` at send time; message immutable after delivery; retention purge is irreversible and audited |
| BC-13 Trust & Safety | `ModerationCase` | `AbuseReport`, `EnforcementAction`, `StrikeRecord`, `Appeal` | Every enforcement action has a case, an actor and a reason; strikes escalate deterministically; appeal cannot be decided by the enforcing actor |
| BC-18 Identity & Access | `Account` · `AccessPolicy` | `Credential`, `AuthSession`, `Device`, `ConsentRecord` | One active credential set per account; OTP single-use with TTL; session revocation is immediate and global; minor guardian consent precedes social activation |
| BC-19 Tenancy | `Tenant` | `TenantTier`, `Quota`, `ResidencyRegion`, `TenantLifecycleState` | Tenant ID immutable; suspended tenant rejects all writes; residency region immutable after first write |
| BC-20 Subscription & Billing | `Subscription` · `SubscriptionInvoice` | `SubscriptionPlan`, `PaymentAttempt`, `DunningState` | One active subscription per tenant; **payment idempotent by gateway reference**; invoice immutable once finalised; entitlement change emitted on every state transition |
| BC-21 Entitlement | `EntitlementSet` *(per tenant, read-optimised)* | `FeatureGate`, `UsageCounter`, `Limit` | Derived state only — **never** hand-edited; recomputable from Subscription events (rebuild-from-events must yield identical output) |
| BC-24 Audit Trail | `AuditEntry` | `Actor`, `Action`, `Target`, `TenantContext` | **Append-only, no update or delete path exists in code**; entry carries the tenant and actor of record; legal hold blocks purge |
| BC-26 Analytics Read Model | `Projection` | `CertifiedMetric`, `ReadModel` | Fully rebuildable from the event log; no projection is a system of record; metric definitions single-sourced from the semantic layer |
| BC-27 AI Assistance | `AgentRun` | `PromptVersion`, `RetrievalSet`, `Guardrail`, `ApprovalRecord` | Retrieval is tenant- and permission-filtered (asserted, not assumed); PII redacted before egress to any model; write-capable runs require an `ApprovalRecord` |

### 8.1 Aggregate Sizing Notes

Two deliberate design calls worth defending:

- **`AttendanceDay`, not `AttendancePunch`, is the aggregate.** The invariants that matter ("check-out after check-in", "one open session", "idempotent punch") are all day-scoped. Making the punch the aggregate would push those invariants into a service layer where they cannot be enforced transactionally.
- **`FeeLedger` per student, not per invoice.** Balance is an invariant *across* dues and receipts. An invoice-scoped aggregate makes "outstanding balance" a query that can disagree with itself under concurrency.

---

## 9. Published Language — Event Surface

The V1 event surface, by producing context. This is the **seed of the full Event Catalog** (open action item #4 in the architecture README) — names, producers and consumers are fixed here; payload schemas and versioning belong in the catalog.

**Naming convention (binding):** `<Context>.<Aggregate><PastTenseVerb>` — e.g. `membership.MembershipRenewed`. Events are facts about the past. An event named as an imperative (`SendReminder`) is a command, belongs to Workflow, and must not enter the event bus as a domain event.

| Producer | Event | Primary consumers | Purpose |
|---|---|---|---|
| BC-01 | `enrollment.StudentEnrolled` | BC-02, BC-23, BC-24, BC-26, BC-22 | Enables membership, indexes, audits, counts |
| BC-01 | `enrollment.StudentProfileUpdated` | BC-23, BC-24, BC-26 | Re-index, audit |
| BC-01 | `enrollment.StudentStatusChanged` | BC-02, BC-04, BC-23, BC-24 | Suspension cascades to seat release |
| BC-01 | `enrollment.StudentLinkedToPerson` | BC-10 (via ACL) | The consented social bridge |
| BC-02 | `membership.MembershipCreated` | BC-05, BC-04, BC-26, BC-22 | Generates dues, unlocks seating |
| BC-02 | `membership.MembershipRenewed` | BC-05, BC-26, BC-22 | Extends validity |
| BC-02 | `membership.MembershipExpiringSoon` | BC-22, BC-28 | Reminder trigger (fact, not command) |
| BC-02 | `membership.MembershipExpired` | BC-04, BC-26, BC-22 | Seat reclamation policy |
| BC-02 | `membership.MembershipFrozen` / `Unfrozen` | BC-05, BC-04, BC-26 | Proration + seat hold |
| BC-03 | `attendance.StudentCheckedIn` | BC-04, BC-26, BC-22 | Occupancy, parent notification |
| BC-03 | `attendance.StudentCheckedOut` | BC-04, BC-26 | Occupancy release |
| BC-03 | `attendance.AttendanceCorrected` | BC-24, BC-26 | Audit + restated metrics |
| BC-03 | `attendance.FraudSignalDetected` | BC-24, BC-13, BC-22 | Anti-proxy enforcement |
| BC-04 | `seating.SeatAssigned` / `SeatReleased` / `SeatTransferred` | BC-26, BC-24, BC-22 | Occupancy analytics |
| BC-04 | `seating.OccupancyThresholdCrossed` | BC-22, BC-26 | Capacity alerting |
| BC-05 | `fee.FeeDueRaised` | BC-22, BC-26, BC-28 | Reminder + revenue analytics |
| BC-05 | `fee.FeePaymentReceived` | BC-02, BC-26, BC-24, BC-22 | Activates membership, receipt |
| BC-05 | `fee.RefundIssued` | BC-26, BC-24 | Revenue restatement |
| BC-06 | `policy.BranchPolicyChanged` | BC-03, BC-04, BC-05, BC-24 | Effective-dated rule propagation |
| BC-10 | `identity.PersonIdentityCreated` | BC-23, BC-24, BC-26 | Identity created atomically with the account (`SEV-1`) |
| BC-10 | `identity.PersonProfileUpdated` | BC-23, BC-24, BC-26, BC-11 | Profile change (`SEV-3`) |
| BC-10 | `identity.PersonUsernameChanged` | BC-23, BC-24, BC-11, BC-12 | Username change (`SEV-5`) |
| BC-10 | `identity.PersonPrivacyModeChanged` | BC-23, BC-24, BC-11, BC-26 | Public ⇄ Private, no propagation window (`SEV-9`) |
| BC-10 | `identity.PersonAnonymised` | BC-23, BC-24, BC-11, BC-12, BC-26 | Account erased; organisation history retained by BC-01 (`SEV-16`, `ID-5`) |
| BC-10 | *(full register)* | — | `SEV-1`…`SEV-16` — closed set, see Student Identity PRD §4.14 |
| BC-11 | `social.FriendshipEstablished` / `UserBlocked` | BC-12, BC-26 | Messaging permission |
| BC-12 | `messaging.MessageSent` | BC-13 (sampling), BC-26 | Moderation + engagement metrics |
| BC-13 | `safety.AbuseReportFiled` | BC-24, BC-22 | Moderator queue |
| BC-13 | `safety.EnforcementActionTaken` | BC-10, BC-11, BC-12, BC-14, BC-15, BC-24 | **Self-restriction fan-out (E-14)** |
| BC-18 | `iam.AccountCreated` / `SessionRevoked` / `ConsentGranted` | BC-24, BC-26 | Security audit |
| BC-19 | `tenancy.TenantProvisioned` / `TenantSuspended` | All, BC-21, BC-24 | Lifecycle gates |
| BC-20 | `billing.SubscriptionActivated` / `Cancelled` / `PaymentFailed` | BC-21, BC-22, BC-26, BC-24 | **Drives entitlement** |
| BC-20 | `billing.EntitlementChanged` | BC-21 | The only writer of entitlement inputs |
| BC-27 | `ai.AgentRunCompleted` / `AiActionApplied` | BC-24, BC-26 | AI action log + cost attribution |

### 9.1 Event Delivery Contract

Non-negotiable properties for every event above, owned by **EVENT PLATFORM**:

| Property | Requirement |
|---|---|
| **Atomicity with state** | Written via **Transactional Outbox** in the same DB transaction as the aggregate mutation. Never published from application code after commit. |
| **Delivery** | At-least-once. Therefore **every consumer must be idempotent** — keyed on `eventId`, with a processed-events table or equivalent. |
| **Ordering** | Guaranteed per aggregate (partition key = `aggregateId`). **Not** guaranteed globally. No consumer may assume cross-aggregate ordering. |
| **Envelope** | `eventId`, `eventType`, `schemaVersion`, `occurredAt`, `tenantId`, `actorId`, `correlationId`, `causationId`, `aggregateId`, `payload`. |
| **Tenant safety** | `tenantId` is mandatory on every domain event. A consumer that processes an event without establishing tenant context must fail loudly, not default. |
| **Schema evolution** | Additive only within a major version. Breaking change = new `schemaVersion` with dual publication during migration. Registry-enforced. |
| **Failure** | Retry with backoff → Dead Letter Queue. DLQ depth is an SLO-monitored signal, not a silent bin. |
| **Replay** | Every projection (BC-26) and index (BC-23) must be rebuildable from the log. This is tested quarterly, not assumed. |

---

## 10. Transaction & Consistency Boundaries

| Operation | Contexts touched | Consistency | Mechanism |
|---|---|---|---|
| Register a walk-in student | BC-01 | **Strong** — single aggregate | One transaction |
| Assign a seat | BC-04 (+ read of BC-02 projection) | **Strong** on seat, **eventual** on membership validity | DB unique constraint on (seat, window) + pessimistic lock. Stale membership projection is an accepted, bounded risk (< 5s) |
| Check in a student | BC-03, then BC-04 | **Strong** within `AttendanceDay`, **eventual** occupancy | Idempotent punch → outbox → occupancy update |
| Collect fee at reception | BC-05, then BC-02 | **Strong** on ledger, **eventual** activation | `FeePaymentReceived` → membership handler. V1: direct handler. V2: saga with compensation |
| Renew membership with payment | BC-02, BC-05, BC-22 | **Eventual, compensating** | **Saga (BC-28, V2)**. V1 constraint: reception UI performs the two steps as an explicit two-stage flow with a visible reconciliation queue for failures — deliberately not hidden behind a fake atomic button |
| Enroll → activate social profile | BC-01, BC-18, BC-10 | **Eventual** | Consent gate → `StudentLinkedToPerson` → ACL |
| Tenant subscription downgrade | BC-20, BC-21, then all | **Eventual** | `EntitlementChanged` → recompute → gates tighten. Grace period configured, not implicit |
| Ban a user | BC-13, then BC-10/11/12/14/15 | **Eventual** | `EnforcementActionTaken` fan-out. **Messaging must additionally check enforcement state at send time** — eventual consistency is unacceptable for abuse containment, so this path is belt-and-braces |

### 10.1 Where Eventual Consistency Is *Not* Acceptable

Three places where the eventual-by-default rule is explicitly overridden, with the mitigation:

| Case | Why eventual fails | Mitigation |
|---|---|---|
| **Double seat allocation** | Two reception staff assigning the same seat concurrently produces a physical-world conflict that cannot be compensated | DB-level unique constraint + row lock. Strongly consistent within BC-04. |
| **Abuse containment** | A banned user sending one more abusive message during propagation lag is a real harm | Synchronous enforcement check at send time in BC-12, in addition to event-driven self-restriction |
| **Duplicate payment capture** | Charging a student twice is unrecoverable trust damage | Idempotency key at API edge + gateway reference uniqueness + reconciliation job |

---

## 11. Multi-Tenancy in the Context Map

| Context group | Tenancy model | Isolation enforcement |
|---|---|---|
| BC-01→09 Library Management | **Tenant-scoped.** Every row carries `tenantId`. | Row-level security + mandatory `TenantContext` in repository base class. A query without tenant predicate must fail at runtime, not silently return everything. |
| BC-10 Global Person Identity | **Global.** No `tenantId`. Keyed on `PersonId`. Rank 7.5. | Must never receive a `StudentRecordId` or `tenantId` (rule `ID-2`). Holds no organisation collection. Asserted by cross-tenant leak tests + `banned_symbols`. |
| BC-11→17 Student Network | **Global.** No `tenantId`. Keyed on `PersonId`. | Must never receive a `StudentRecordId` or `tenantId` (rule `ID-2`). Consumers of BC-10, never owners (`ADR-0011`). |
| BC-18 Identity | **Hybrid.** `Account` is global; role assignments are tenant-scoped. | `AccessPolicy` is always evaluated with a tenant in scope |
| BC-19→31 Capability | **Tenant-aware.** Carry and propagate `tenantId`, own no tenant data of record. | Indices, caches, projections, prompts, embeddings and files are **all** tenant-partitioned. Vector search isolation is asserted per query, not by convention. |

### 11.1 Platform Public Discovery Index vs Tenant Operational Data

Ruling `AR-3` establishes two **categorically different** index classes. Conflating them is the failure mode described below.

| | **Platform Public Discovery Index** | **Tenant Operational Data** |
|---|---|---|
| **Indexed unit** | The `TenantOrganisation` record itself (`BC-19`) | Rows belonging to one tenant |
| **Contents** | Only explicitly public library metadata — the fields enumerated in Library PRD §14A.5 | Students, memberships, attendance, fees, analytics, configuration, staff |
| **Tenant key in index name** | Not applicable — the tenant **is** the indexed record | **Mandatory** — `MP-GBR-08`, `SE-1`, forbidden edge `X-13` |
| **Caller tenant context** | None; anonymous and pre-authentication | Always required (`E-18`) |
| **Visibility gate** | `LIB-DISC-002` (verified + activated) and `LIB-DISC-004` (Private excluded) | Tenant-private, permission-scoped |
| **Severity if violated** | Indexing tenant-private data here is a **blocker** | Serving a tenant-less query is a **blocker** |

**This distinction does not relax any existing rule.** `MP-GBR-08`, `SE-1` and `X-13` remain in force,
unmodified, at `blocker` severity for all tenant operational data. `AR-3` states only that a *directory of
tenants* is not an *index of tenant data*. Operational, financial, administrative, member, attendance and
analytics data must **never** appear in the public discovery index.

**The single highest-severity failure mode in the entire architecture** is a cross-tenant data leak via a capability context — an unpartitioned search index, a shared embedding collection, or a cache key missing the tenant prefix. The Quality Platform's **Multi-Tenant Test Suite** exists specifically to make this class of bug fail in CI. Treat any change to a cache key, index name, or vector namespace as a security-reviewable change.

---

## 12. Microservice Extraction Order

LIBOORA ships as a **modular monolith**. This is correct: at current scale, the operational cost of microservices exceeds their benefit. But the boundaries above are drawn so that extraction is a deployment change, not a redesign.

If and when extraction becomes necessary, this is the order — driven by *independent scaling need* and *lowest coupling*, using the Strangler Fig pattern:

| # | Extract | Trigger | Why it's first / safe |
|---|---|---|---|
| 1 | **BC-12 Messaging** | Message volume or connection count dominates infra cost | Highest throughput, weakest coupling, own data store already |
| 2 | **BC-27 AI Assistance** | GPU/inference cost or latency needs independent scaling | Already event- and port-driven; imports no domain code |
| 3 | **BC-23 Search Indexing** | Index size or query load | Already a separate engine; only consumes events |
| 4 | **BC-26 Analytics Read Model** | Report load impacts OLTP, or data volume needs a warehouse | Already CQRS-separated with its own store |
| 5 | **BC-03 Attendance** | Check-in spikes (exam season) need independent elasticity | Clean aggregate, idempotent writes, event-out only |
| 6 | **BC-20/21 Billing & Entitlement** | Compliance or PCI scope isolation | Well-bounded, low change rate |
| — | **Never extract independently** | — | BC-01/02/04/05/06 are one transactional cluster. Splitting Enrollment from Membership from Fee introduces distributed transactions across invariants that genuinely need strong consistency. **They stay together.** |

The last row is the most valuable line in this table. Knowing what *not* to extract is what separates a considered architecture from cargo-cult microservices.

---

## 13. Open Questions

Items requiring a decision before V1 implementation freeze. Each should become an ADR.

| # | Question | Impact if undecided | Recommendation |
|---|---|---|---|
| Q-01 | Does an expired membership release the seat immediately, at end-of-day, or after a grace period? | BC-02→BC-04 event handler semantics | Configurable per tenant (BC-25), default 24h grace |
| Q-02 | Is `Branch` (BC-06) a first-class V1 entity or introduced at V3 Multi-Branch? | Schema shape of every tenant-scoped table | **Model `branchId` in V1 schema, default single branch.** Retrofitting it later is a migration across every core table |
| Q-03 | Entitlement fail-open or fail-closed on timeout? | Revenue leakage vs availability | Per-gate policy; hard paid features fail-closed, soft limits fail-open |
| Q-04 | Retention period for `StudentAttendance` after enrollment archival? | Legal + storage cost | Define with counsel; default 7 years financial, 2 years attendance |
| ~~Q-05~~ | ~~Is Global Student available to a person with **no** library enrollment?~~ | — | **CLOSED 2026-08-04 by `ADR-0011`: yes, necessarily.** Every account has an identity from creation, so the question can no longer arise. The "reduced trust tier" recommendation is **not** adopted — a trust tier is an authorisation concern owned by BC-18, and implementing it in BC-10 would mean a global context evaluating authorisation (`X-13`) |
| Q-06 | Who owns proration arithmetic — BC-02 (rules) or BC-20/Business (execution)? | Currently split by design; needs explicit contract | BC-02 computes the *entitlement delta*, Business Platform executes the *money*. Contract in `liboora_contracts` |
| Q-07 | Does Parent get an `Account` (BC-18) or a scoped view token? | Auth complexity, consent model | Full account with guardian role — required for consent audit trail |

---

## 14. Architecture Rulings

Approved project decisions issued by the product owner. The register of record is
[`ARCHITECTURE_RULINGS.md`](./ARCHITECTURE_RULINGS.md); this section states their effect on **this** document.
A ruling settles ownership, classification and boundaries. It creates no requirement.

| ID | Ruling | Effect on this map |
|---|---|---|
| **`AR-1`** | Library Discovery & Enrollment is **not** a bounded context. It is an application / read composition capability of the Library domain, owning no aggregate, no invariant and no business state. | §2 — recorded alongside Dashboards as a non-context composition. Context count unchanged at 31. No `BC-` identifier assigned. |
| **`AR-2`** | The Authentication architecture is the source of truth. **Account creation on first successful OTP verification is explicitly approved.** `BC-18` retains OTP, Registration, Account creation, Session management and Authorization handoff. Library Discovery must never implement registration logic. | §4 Identity Triad is **confirmed, not changed** — *"Created on first successful OTP"* stands as written. Implementation divergence documented in [`ACR-001`](../90-archive/authentication-v1/reports/ACR-001-OTP-Account-Creation.md); no production code altered. |
| **`AR-3`** | Public Library Discovery is a **platform-wide public directory** indexing only explicitly public library metadata. It is not a tenant data index, and must not weaken tenant isolation. | §11.1 added — distinguishes the Platform Public Discovery Index from Tenant Operational Data. `MP-GBR-08`, `SE-1` and `X-13` remain in force, unmodified. |
| **`AR-4`** | Invitation Links, Invitation QR Codes and Library Invitation Codes are owned by the **Library Management / Tenant Organization** module. Authentication, Membership and Student Identity do **not** own invitations. | Ownership assigned below. The invitation **security specification now exists** — [`INVITATION_SECURITY_SPECIFICATION.md`](../30-product/library/INVITATION_SECURITY_SPECIFICATION.md), governed by `ADR-0009`. The deferral was lifted 2026-08-03 on receipt of Library PRD §§1–25. |
| **`AR-5`** | The Registration flow collects the user's Display Name **before** OTP verification. `displayName` remains required and non-nullable. Empty string, mobile number, placeholder and auto-generated names are prohibited. Authentication is responsible for **OTP verification only**; Registration owns the collection of user profile information. | No context, aggregate or identity rule changes. `BC-18` continues to own credentials and OTP; the display name is **profile information**, collected by the Registration flow and supplied to `BC-18` only at the moment of account creation. §14.2 below. |
| **`AR-6`** | **Authentication and Session Issuance are separate stages.** An `Account` may exist before any tenant role exists. Authentication owns identity verification and account creation; Authorization owns tenant roles; session issuance occurs only after the required authorization context exists. Authentication and Authorization must not be merged. | §11 `BC-18` tenancy model is **confirmed, not changed** — *"`Account` is global; role assignments are tenant-scoped"* stands as written. §14.2 records the stage sequence this makes explicit. |
| **`AR-7`** | The security objective of `F-02` is anti-enumeration. Identical observable behaviour is preserved for registered and unregistered phone numbers until OTP verification succeeds. Conformance tests validate security behaviour rather than implementation details such as internal storage. `F-01` and `F-02` are not weakened. | No map change. Recorded here because it governs how `BC-18`'s conformance suite is written. |

### 14.1 Invitation ownership (`AR-4`)

| Aspect | Position |
|---|---|
| **Owner** | Library Management / Tenant Organization |
| **Not owned by** | `BC-18` Identity & Access · `BC-02` Membership · `BC-01` Enrollment · `BC-10` Global Person Identity |
| **Rationale** | An invitation is the access mechanism for a **Private library** (Library PRD §14A.6) — a property of the organisation, not of a credential or a plan |
| **Security specification** | ✅ **Specified** — [`INVITATION_SECURITY_SPECIFICATION.md`](../30-product/library/INVITATION_SECURITY_SPECIFICATION.md). Three types `IT-1`…`IT-3`, 71 requirements, ten configurables `ICFG-1`…`ICFG-10`. Expiry §4 · revocation §5 · single-use §6 · entropy §3 · validation §7 · audit §8 |
| **Governing principle** | `INV-SEC-002` — an invitation is a **revocable, expiring claim, never a credential**. It authenticates nobody (`ADR-0009`). This preserves `MP-GBR-25`, the mobile number as sole authentication factor |
| **Delegation** | Artefact validation and consumption are this module's. OTP verification and the role grant are `BC-18`'s (`INV-XC-1`, `INV-XC-2`) |

### 14.2 Authentication stage sequence (`AR-5`, `AR-6`)

The approved sequence. Each stage names its owning concern; **no new context, aggregate or invariant is created by
recording it.**

```
Registration
  → Collect Display Name                 (Registration — profile information)
  → Collect Mobile Number                (Registration)
  → OTP Verification                     (BC-18 — Authentication)
  → Create Account                       (BC-18 — Authentication; §4 "Created on first successful OTP")
  → Continue Original Action
  → Membership Processing (if required)   (BC-02 Membership)
  → Role Assignment                      (BC-18 — Authorization concern, tenant-scoped)
  → Session Issuance                     (BC-18 — only after the authorization context exists)
```

| Property | Position |
|---|---|
| **An `Account` may exist with no tenant role** | Yes. This is a legitimate, representable state, not a failure. It follows directly from §11's Hybrid tenancy model for `BC-18` |
| **`AccountId` lifecycle** | Unchanged — §4 stands: *"Created on first successful OTP"* |
| **`PersonId`, `StudentRecordId`** | Unchanged. `ID-1`…`ID-6` unaffected |
| **Session issuance precondition** | A role must exist in the tenant in scope. Consistent with §11: *"`AccessPolicy` is always evaluated with a tenant in scope"* |
| **Where roles come from** | Membership Processing (`BC-02`), per Library PRD §14A.7 — *after* Authentication |
| **Display name** | Profile information. Collected by Registration before OTP verification; never derived from the mobile number, never generated |

**Boundary note.** Because Authentication and Authorization are both concerns of `BC-18`, `AR-6` is a **stage
separation inside one bounded context**, not a context split. No integration edge is added by `AR-6`; `E-01`…`E-26`
are unchanged **by that ruling**. *(Edge `E-27` was added by `ADR-0032` and **withdrawn again by [`ADR-0033`](../00-governance/adr/ADR-0033-e27-core-cluster-edge-allowlist.md) in v1.7**; it was unrelated to `AR-6` either way. The edge set is once more `E-01`…`E-26`.)*

---

## Changelog

| Version | Date | Change |
|---|---|---|
| **v1.10** | 2026-09-01 | **One identifier published, by APPEND as a new §16. No context, edge, aggregate, member, invariant, event, identity rule or tenancy model changed; context count remains 31 (23 in V1); the edge set remains `E-01`…`E-26`, `E-28`, `E-29` with `E-27` permanently vacant. §1–§15 are BYTE-IDENTICAL to v1.9** — only this row, the header **Version** cell and the header **Context Count** cell differ. Applies **`Accepted`** [`ADR-0085`](../00-governance/adr/ADR-0085-communityid-scoping-identifier-published.md) §3, an **Architecture Owner** act discharging ruling 3 of the `PRD-021A` Owner Rulings: *"approve a stable `communityId` as the required community/group scoping identifier and publish it through the appropriate existing architecture contract. Do not create duplicate identifiers."* **New §16 rules `CID-1`…`CID-6`**: `communityId` is the **required** scoping identifier for `BC-15`'s `Community` and `Group` (**§15.5**); **`BC-15` is the sole minting authority**; it is **stable and immutable**; it is **not** tenant-derived, which **preserves `ID-2` and `EV-3` rather than weakening them**; and ⛔ **no second scoping identifier is authorised**. ⭐ **This NAMES an existing concept rather than introducing one** — `Accepted` [`ADR-0078`](../00-governance/adr/ADR-0078-community-scope-identifier-carries-no-tenantid.md) §2.1 already reads *"`BC-15`-owned community identifiers"* and **§15.4 `EV-3`** already reads *"the community's own identifier"*; what was missing was the name and the contract, which `PRD-021A` A4 **L276** records as *"no contract defines how a `communityId` is minted or resolved"*. **The no-duplicates constraint was TESTED, not assumed:** `grep -c communityId` against this file at v1.9 returned **0** and `grep -rn "CID-[0-9]"` across `docs/` and `tool/` returned **0**, so both the name and the `CID-` stem were free before use. ⚠ **`CID-6` records a deliberate residue:** **no format, encoding, length or generation algorithm is specified** — the ruling said *"stable"*, not *"a UUIDv7"*, and inventing a representation would exceed the authority granted. Closes `LCG-GAP-006` and `LCG-ADR-003`. ⭐ **Why APPEND, stated as measurement.** **2,977** tight-window line-citations point into this file; appending below the former last line **L763** invalidates **0**. This is the method [`ADR-0079`](../00-governance/adr/ADR-0079-ea-v2.3-capability-enumeration-addenda.md) §8.5 Option A established and `ADR-0083` reused. ⚠ **ONE cost is DISCLOSED and deliberately NOT repaired:** this changelog row is itself an insertion, and it shifts `PRD-021A_STAGE4_AC_REQUIREMENT_MAPPING_2026-09-01.md` **L524**'s pointer at **L649** (the 28-edge set) to **L650**. That file is a **dated Stage-4 review record** committed at `12b0071`; historical review records are not edited after the fact, so the drift is logged as **`GAP-BCMAP-L649-CITE`** rather than silently corrected. The row could not be avoided — `DOCUMENTATION_BASELINE.md` **§7 rule 2** requires the changelog to be updated in the same commit, and **11 of the 14** candidate citations above L613 were measured to be **false positives** citing other documents. ⚠ **§16 measured 83 lines against ADR-0085 §7's predicted 42** — the prediction is **corrected to the measurement** in that ADR rather than quietly overwritten, per the `ADR-0079` §3.3 precedent. **No baseline re-issue** — Rank 4, per `DOCUMENTATION_BASELINE.md` §7 rule 4. ⛔ **Confers no lifecycle stage: `PRD-021A` remains NOT FROZEN and Stage 7 remains NOT CONFERRED** |
| **v1.9** | 2026-08-31 | **Two new edges, one cluster extended, four rule blocks added — all by APPEND as a new §15. No existing edge added to, removed from or altered inside §7; no aggregate row altered inside §8; no context, invariant, identity rule or tenancy model changed; context count remains 31 (23 in V1). §1–§14 are BYTE-IDENTICAL to v1.8** — only this row, the header **Version** cell and the header **Context Count** cell differ above §15. Applies **`Accepted`** [`ADR-0083`](../00-governance/adr/ADR-0083-prd-021a-owner-rulings-executed.md), which executes 22 `PRD-021A` Owner rulings conferred directly by the human principal. **New §15.1 edges: `E-28`** `BC-11 Social Graph` → `BC-15 Community & Groups` (`C/S`, Sync port, **V2**), authorising `LCF-ADR-007` per **AO-1**; **`E-29`** `BC-14 Content Sharing` → `BC-15` (`CF`, Sync port, **V2**), authorising `LCF-ADR-002` per **AO-3**. ⛔ **`E-27` IS NOT REUSED** — minted by `ADR-0032`, withdrawn by [`ADR-0033`](../00-governance/adr/ADR-0033-e27-core-cluster-edge-allowlist.md) in v1.7 (row below), and `PRD_LIFECYCLE.md` §5 rule 5 reads *"Numbers are never reused, even after withdrawal."* The edge set is therefore **`E-01`…`E-26`, `E-28`, `E-29` = 28 edges with `E-27` permanently vacant** — a gap that records a withdrawal rather than an error. **§15.2** extends the declared **Social cluster** to `BC-11`, `BC-12`, `BC-13`, **`BC-15`** per **AO-7**, resolving `D-2`; the operative amendment is in Rank 4 [`LIBOORA_MODULE_DEPENDENCY_MATRIX.md`](LIBOORA_MODULE_DEPENDENCY_MATRIX.md) **L90**/**L652**, edited in place. ⭐ A **third** R8 cluster was deliberately NOT created — `ADR-0011` L92–95 warns that doing so *"dissolves the Separate Ways boundary"*. **§15.3** opaque cursor pagination `PG-1`…`PG-4` per **AO-2**, populating the declared-but-empty `Pagination & Filtering Standards (V1)` node at EA **L379** (measured: **0** cursor definitions existed anywhere in `docs/10-architecture/`). **§15.4** envelope rules `EV-1`…`EV-4` per **AO-6**: `BC-15` events carry **no `tenantId`**. ⭐ This is **not a new exemption** — §10 **L488** already reads *"`BC-11`→`17` Student Network | **Global.** No `tenantId` … Must never receive a `StudentRecordId` or `tenantId` (rule `ID-2`)"*; the defect was an envelope rule phrased as universal, so **`ID-2` is preserved, not weakened**, and no other BC gains this exception. **§15.5** registers `BC-15`'s aggregates **`Community`** and **`Group`** by append per **AO-8**, with the `OWNER > MODERATOR > MEMBER` closed role set (**PO-4**), the `PUBLIC`/`PRIVATE` closed visibility enum (**PO-5**) and the no-ownerless-community invariant (**PO-6**, departure **blocked**, ⛔ never silent auto-promotion). **§15.6** records that moderation reaches `BC-15` as an **existing-edge-fed local projection** per **AO-4** — ⛔ **no `BC-15 → BC-13` edge was created**, the `ADR-0065` pattern is reused, and `BC-13`/`PRD-020` aggregate ownership is untouched — and that **community search is NOT authorised**: `E-21` (**L330**) runs `BC-01, BC-10 → BC-23` and `BC-15` is **measured absent** from its consumer cell, so per **AO-9**'s own conditional the refusal is recorded rather than support silently claimed. ⭐ **Why APPEND rather than insertion, stated as measurement.** At commit `c66f1d7`, **2,812** line-citations pointed into this file and the highest was **L624**, then the last line. Inserting a row after `E-26` would have shifted **1,293** of them, several inside **FROZEN** Rank 3 documents; inserting into §8 would have shifted **747**; appending shifted **0**. This is the method [`ADR-0079`](../00-governance/adr/ADR-0079-ea-v2.3-capability-enumeration-addenda.md) §8.5 Option A established for the Enterprise Architecture. **AO-8** required exactly this discipline for §8; it was applied to §7 as well. ⚠ **This changelog row is itself the one deliberate insertion**, costing **1** measured citation (`ADR-0083` **L115**, repaired in the same commit) — accepted because a changelog that omits its own current version is the worse defect. ⚠ **Two residues are DISCLOSED, NOT resolved.** (1) **`E-29`'s `L2` clearance is UNDETERMINED** — `BC-14` returns **0** occurrences in *both* Rank 4 dependency documents, and **AO-7** enumerates only `BC-11/12/13/15`, so whether `E-29` is same-rank-within-cluster or lawful downward **cannot be measured**; recorded as **`GAP-BC14-RANK`**, Architecture Owner. `BC-14` was **NOT** added to the cluster, because that would exceed the ruling. (2) **`BC-15` remains the source of ZERO edges** — `E-14`, `E-28` and `E-29` are all inbound — so `PRD-021A` Part A4's `GroupCreated`/`GroupMembershipGranted`/`GroupMembershipRevoked` are still **unpublishable** and `LCG-ADR-002` **stays OPEN**. **No baseline re-issue** — Rank 4, per `DOCUMENTATION_BASELINE.md` §7 rule 4 |
| **v1.8** | 2026-08-20 | **One consumer cell. No edge added, no edge removed, no existing edge's mode, mechanism or contract changed; no context, aggregate, invariant, event, identity rule or tenancy model changed; count remains 31 (23 in V1).** Applied [`ADR-0055`](../00-governance/adr/ADR-0055-e22-consumer-list-includes-bc-12.md). §7 edge **`E-22`** consumer cell `BC-01, BC-10, BC-14` → `BC-01, BC-10, BC-12, BC-14`, admitting **`BC-12` Messaging** as a consumer of `BC-29` File & Media, required by `PRD-017` **FROZEN** `FIL-FR-075`…`FIL-FR-082` (V1 student-to-student file sharing). **`BC-11` Social Graph and `BC-13` Trust & Safety were tested and deliberately NOT admitted** — `ADR-0055` §3 applied a per-context necessity test rather than admitting the whole `domain/social` module, so the map stays context-grained where the manifest is module-grained (`GCP-23`). This is the **second** instance of the `ADR-0016` defect class — a Rank 3 PRD depending on an edge the Rank 4 register did not list — and it is **sharper** than the first, because `tool/module_dependencies.yaml` **L242** already granted `domain/social` the `platform/services:files` port while this cell denied the edge; `FIL-FR-007` rules that a port grant is not an edge authorisation, so the **map** was the incomplete record. Closes the architecture half of `FIL-GAP-012` / `B-11`; the implementation half stays open. **No baseline re-issue** — Rank 4, per `DOCUMENTATION_BASELINE.md` §7 step 4 and the `ADR-0016` precedent |
| **v1.7** | 2026-08-05 | **One edge removed. No edge added; no existing edge's mode, mechanism, contract or consumer cell changed; no context, aggregate, invariant, event, identity rule or tenancy model changed; count remains 31 (23 in V1); §9's event surface is untouched.** Applies [`ADR-0033`](../00-governance/adr/ADR-0033-e27-core-cluster-edge-allowlist.md), which selects its option **`O-C`**. §7.1 **loses `E-27`**, together with the "`E-27` vs `E-08`" note that explained a row which no longer exists; the edge set returns to **`E-01`…`E-26`**. **Why it was withdrawn rather than legalised.** `E-27` ran `BC-03` → `BC-04`, and **both are members of the Core Library cluster**, whose permitted internal edges Rank 4 [`LIBOORA_MODULE_DEPENDENCY_MATRIX.md`](LIBOORA_MODULE_DEPENDENCY_MATRIX.md) L89/L202 restrict to **`E-01`…`E-10`**, *"Enforced as an explicit allow-list, not 'anything within the cluster'"*. Measured across the whole map, `E-27` was the **only** edge numbered above `E-10` with both endpoints inside that cluster. **The allow-list was NOT widened to accommodate it** — that would have been adding an edge to erase a contradiction — and the Dependency Matrix is therefore **unamended**. **Why nothing breaks.** `ADR-0032`'s substantive decision `O-5` never depended on this row: frozen Rank 3 `SEAT-FR-104` already obliges the Seat Card to compose holder data **from `BC-01` at read time**, and **no `BC-01` → `BC-04` edge has ever existed in §7** — so read-time composition across a context boundary is an **already-ratified pattern that requires no numbered edge**, and `PRD-007` §3 records three further no-edge consumptions (`BC-10`, `BC-05`, `BC-18`) on the same footing. `E-27` documented a transport governance had already permitted without one. **What is unchanged:** `E-08`'s row is **byte-identical** — Attendance still pushes check-in and check-out to Seating for occupancy; the Seat Card still shows four states, still stores no presence, still reads no raw Wi-Fi or device state, and there is still **no fifth `attendance.*` event**. `ADR-0032` **remains `Accepted`**; only its transport is withdrawn. `SEAT-FR-103`…`SEAT-FR-107` are **not modified**. **`SEAT-GAP-009` remains open** — it concerns the opposite direction. |
| **v1.6** | 2026-08-05 | **One new edge. No edge removed, no existing edge's mode, mechanism, contract or consumer cell changed; no context, aggregate, invariant, event, identity rule or tenancy model changed; count remains 31 (23 in V1); §9's event surface is untouched.** Applied [`ADR-0032`](../00-governance/adr/ADR-0032-attendance-presence-visibility-to-seating.md), which selects its option **`O-5`**. §7.1 gains **`E-27`** — `BC-03 Attendance` → `BC-04 Seating`, `C/S` + `PL`, **Read projection**, carrying `StudentPresence{studentRecordId, tenant, presenceState, attendedToday, method, asOf}` so that the Seat Card can show **current student presence beside seat allocation** as `PRD-006` §23.4a requires. **Why an edge was needed at all:** §7's own rule states *"If an edge is not in this table, it **does not exist** and adding it requires an ADR"* — `PRD-006` could compute the presence state but had **no authorised way to make it visible on a seat**. **Why a new row rather than widening `E-08`:** `E-08` is *push* and this is *pull*; a presence change that is neither a check-in nor a check-out has no event, and a fifth `attendance.*` event was **measured** to cost two Rank 4 register amendments and to contradict an existing `PRD-006` acceptance criterion that fixes the published set at *"exactly four … and no other"* (identifier deliberately not written here: `PRD-006`'s Stage 5 gate reads any well-formed `ATT-*` token in a foreign file as a collision, and this row was rephrased rather than the check weakened — the same discipline `PRD-006`'s own v1.6 and v1.7 changelog rows record). **`E-08`'s contract is preserved verbatim.** **What `E-27` does NOT do:** it carries **no event**, creates **no aggregate**, permits **no** raw Wi-Fi or network-observation read by `BC-04`, permits **no** inference of presence from the *absence* of an event, and stores **nothing** on the seat — frozen `SEAT-FR-104` already requires cross-context card values to be *"composed at read time"* and `SEAT-FR-105`/`SEAT-FR-106` already require as-of labelling and visible degradation, so this edge **reuses a ratified pattern rather than introducing one**. **`SEAT-GAP-009` is NOT closed by this row** and is explicitly recorded as still open: it asks about a `BC-04` → `BC-03` read, which is the **opposite** direction. §7.4's forbidden direction and `X-05` are untouched — this is a domain → domain read, so `F-1`…`F-4` are not engaged. |
| **v1.5** | 2026-08-04 | **One consumer cell. No context, aggregate, invariant, event, identity rule or tenancy model changed; no edge added or removed; count remains 31 (23 in V1).** Applied [`ADR-0016`](../00-governance/adr/ADR-0016-e22-consumer-list-includes-bc-10.md), closing `PGA-02`. §7.3 edge **`E-22`** (→ `BC-29` File & Media) had consumers `BC-01, BC-14`; **`BC-10` is added**. Root cause: `ADR-0011`'s migration extended `E-21`'s consumer list with `BC-10` but not `E-22`'s, leaving the Rank 3 requirement `SID-4.35` — *"The Global Profile Photo **SHALL** be held as a `FileRef` issued by `BC-29`"*, under a §4.8 heading that names `E-22` explicitly — dependent on an edge that §7's own rule (*"if an edge is not in this table, it **does not exist**"*) said did not exist. The mode `CF`, the *Sync port* mechanism and the note *"Domain holds a `FileRef`, never bytes or a raw storage path"* are **unchanged** — `BC-10` joins under a constraint `SID-4.35` already imposes on itself. Invisible to `tool/check_module_boundaries.dart` by design: `domain/person` (7.5) → `platform/services` (3) was always a legal downward port call, so no mechanical check was ever going to detect a missing row in a prose table. **No dependency law gained an exception; `X-05` untouched.** |
| **v1.4** | 2026-08-04 | **Implementation status only — no context, aggregate, invariant, edge, event, identity rule or tenancy model changed; count remains 31 (23 in V1).** Recorded because the `ADR-0011` amendments carried by v1.3 are now **implemented in code** (commit `a22fd7e`): `BC-10` exists as `lib/domain/person/` at rank 7.5, edge `E-12` is realised as a synchronous rank-0 port (`PersonIdentityFactory`) satisfying `SID-4.11` in the same unit of work, edge `E-13` is a non-nullable `personId` on `StudentRecord`, and `BC-11` holds `SocialPresence` with **no** identity fields (`SID-BR-11`). Cardinality `1:1` mandatory is enforced by the compiler and asserted against the booted container (`MP-GBR-02`). `ID-2` and `SID-4.19` are verified: the identity holds no `StudentRecordId` and no `TenantId`. Enforcement is mechanical as of `IMPL-014` — **0 findings name `domain/person`**. See [`../40-implementation/ARCHITECTURE_MIGRATION_REPORT.md`](../40-implementation/ARCHITECTURE_MIGRATION_REPORT.md). |
| **v1.3** | 2026-08-04 | Applied [`ADR-0011`](../00-governance/adr/ADR-0011-global-person-identity.md). §3.2, §4, §5 and §8 amended: `BC-10` renamed **Global Person Identity**, reclassified `[SUPPORTING]` → **`[CORE]`**, moved out of the Social cluster to **rank 7.5**, and its cardinality with `Account` changed from `0..1` opt-in to **`1:1` mandatory**. Edge `E-12` recorded as a *synchronous port, same transaction*; edge `E-13` as the sole ACL bridge with a **non-nullable** `personId`. Linkage rules `ID-1`…`ID-6` and prohibition `X-05` **preserved unamended**. **No context added, removed or re-scoped; count remains 31 (23 in V1).** Retro-recorded: this row was omitted when the change was made. |
| **v1.2** | 2026-08-02 | Applied approved architecture rulings `AR-5`, `AR-6`, `AR-7`. §14 gains three rows; §14.2 added, recording the approved authentication stage sequence and confirming that an `Account` may exist before any tenant role. **No context added, removed, renamed or re-scoped; count remains 31 (23 in V1). No aggregate, invariant, integration edge, event, identity rule or tenancy model changed** — §4 and §11 are confirmed as written, not amended. `AR-6` is a stage separation *within* `BC-18`, not a context split. |
| **v1.1** | 2026-08-02 | Applied approved architecture rulings `AR-1`…`AR-4`. §2 records Library Discovery as a non-context read composition. §11.1 added, distinguishing the Platform Public Discovery Index from Tenant Operational Data without relaxing `MP-GBR-08`, `SE-1` or `X-13`. §14 added as the in-document rulings summary, including invitation ownership. **No context added, removed, renamed or re-scoped; count remains 31 (23 in V1). No aggregate, invariant, integration edge, event, identity rule or tenancy model changed.** |
| **v1.0** | 2026-07-30 | Initial bounded context map derived from Enterprise Architecture v2.0. 31 contexts registered, 26 integration edges specified, Identity Triad defined, 14 ubiquitous-language collisions resolved, 17 aggregates with invariants, 30 V1 events, extraction order set. |



---

## 15. ⭐ `ADR-0083` Extension — `BC-15` Community & Groups integration (V2)

> ⚠⚠ **THIS SECTION IS A NORMATIVE EXTENSION OF §7 AND §8, NOT A COMMENTARY ON THEM.**
> Admitted 2026-08-31 by **`Accepted`** [`ADR-0083`](../00-governance/adr/ADR-0083-prd-021a-owner-rulings-executed.md)
> under **Architecture Owner** authority. §7's rule at **L292** — *"If an edge is not in this table, it does not
> exist and adding it requires an ADR"* — is satisfied by this section: the ADR exists, and the rows below **are**
> that table, extended.
>
> ⭐ **Why this is an APPEND and not two rows inserted into §7.3, stated as measurement rather than preference.**
> Measured across all of `docs/` at commit `c66f1d7`: **2,812** line-citations point into this file, and the
> highest is **L624** — the last line before this section. Inserting a row after `E-26` (~L336) would have shifted
> **1,293** of those citations, several inside **FROZEN** Rank 3 documents. Appending shifts **zero**. This is the
> method [`ADR-0079`](../00-governance/adr/ADR-0079-ea-v2.3-capability-enumeration-addenda.md) §8.5 Option A
> established for the Enterprise Architecture, where **482** citations re-resolved and **0** were invalidated.
> **§1–§14 are byte-identical to v1.8.**

### 15.1 New integration edges

⛔ **`E-27` IS NOT REUSED AND IS PERMANENTLY VACANT.** It was minted by `ADR-0032`, withdrawn by
[`ADR-0033`](../00-governance/adr/ADR-0033-e27-core-cluster-edge-allowlist.md) in v1.7, and
`PRD_LIFECYCLE.md` §5 rule 5 states *"Numbers are never reused, even after withdrawal."* The edge set is
therefore **`E-01`…`E-26`, `E-28`, `E-29`** — **28 edges, with `E-27` a deliberate gap that records a
withdrawal**. A reader who finds no `E-27` has found the correct state.

| # | Upstream (provider) | Downstream (consumer) | Pattern | Mechanism | Release | Contract |
|---|---|---|---|---|---|---|
| **E-28** | BC-11 Social Graph | BC-15 Community & Groups | `C/S` | Sync port | **V2** | `RateLimitCounter` and `BlockList` reads. `BC-15` **asks**; enforcement and both aggregates remain `BC-11`'s (§8 **L377**). Same shape as `E-16` — the consumer never holds the provider's state. Required by `PRD-021A` A2 `LCF-FR-034`, `LCF-AUTH-012`, `LCF-FR-096`, `LCF-FR-095`. Admitted by `ADR-0083` §4.1 on ruling **AO-1** (`LCF-ADR-007`) |
| **E-29** | BC-14 Content Sharing | BC-15 Community & Groups | `CF` | Sync port | **V2** | Community posts reference user-generated media. `BC-15` holds a **reference only — never bytes, never a raw storage path**, and **does NOT become a second media owner**: `BC-14` remains sole owner of user-generated notes, media and links (**L118**) including copyright and takedown. Admitted by `ADR-0083` §4.1 on ruling **AO-3** (`LCF-ADR-002`). ⛔ **See §15.1.1 — this edge's `L2` clearance is UNDETERMINED** |

**Direction.** Both rows are **inbound to `BC-15`**: it is a consumer in each. ⭐ **`BC-15` is therefore still
the source of ZERO edges**, and consequently publishes **no** event. `PRD-021A` A4's `GroupCreated`,
`GroupMembershipGranted` and `GroupMembershipRevoked` remain **unpublishable**, and A4's `LCG-ADR-002` remains
**OPEN** — `ADR-0083` §4.6. Nothing in this section authorises a `BC-15`-sourced event.

**On §7's "in V1" heading.** **L292** scopes §7 to V1 and both contexts here are **V2**. This is an existing
shape, not a new one: `E-14` (**L318**) already lists the V2 contexts `BC-14` and `BC-15` among its consumers,
and `E-10` (**L307**) already carries a V2 qualifier in its contract cell. Both rows above are explicitly
**V2-scoped** so no reader mistakes them for V1 obligations.

#### 15.1.1 ⛔⛔ `E-29`'s `L2` clearance is UNDETERMINED — recorded, not assumed

`LIBOORA_MODULE_DEPENDENCY_MATRIX.md` rule `L2` (**L49**) forbids same-rank dependencies outside a declared
cluster. §15.2 extends the Social cluster to `BC-11`, `BC-12`, `BC-13`, `BC-15` — **the four members ruling AO-7
enumerates. `BC-14` is not among them.**

**Measured:** `BC-14` appears **0** times in `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` and **0** times in
`tool/module_dependencies.yaml`. Its module and rank are **unassigned by any Rank 4 document**. Therefore:

- if `BC-14` is rank 8 in `domain/social`, `E-29` is an **`L2` violation** (same rank, outside the declared cluster);
- if `BC-14` is lower-ranked, `E-29` is a lawful downward port call;
- **which of these holds is not determinable from the repository.**

⛔ **`BC-14` is NOT added to the cluster here** — that would exceed AO-7's explicit enumeration. ⛔ **No `L2`
clearance is claimed for `E-29`.** The determination is routed as **`GAP-BC14-RANK`**, **Architecture Owner**.
⚠ Until it closes, A2 `LCF-FR-043`'s restriction stands: **only `TEXT` posts ship**; `NOTE`, `MEDIA` and `LINK`
remain blocked.

### 15.2 Social cluster extended — `BC-15` admitted

Admitted by `ADR-0083` §4.2 on rulings **AO-1** (second required act) and **AO-7** (D-2).

| Cluster | Members after this section | Allowed internal edges |
|---|---|---|
| **Social cluster** (within R8) | `BC-11` Graph, `BC-12` Messaging, `BC-13` Safety, **`BC-15` Community & Groups** | `E-14`…`E-16` **and `E-28`** |

`domain/social` remains rank **8** (`tool/module_dependencies.yaml` **L47**) — unchanged.

⭐ **No third cluster was created, and that was the point.** Matrix **L92–95** records `ADR-0011`'s finding that
a third R8 cluster spanning both worlds *"dissolves the Separate Ways boundary"*. `BC-15` is already inside the
**Student Network** subdomain (**L119**), so admitting it to the cluster that governs that subdomain adds no
bridge. **`X-05` is untouched** — `BC-15` is on the social side of the prohibition, `E-13` via ACL remains the
sole bridge to Library Management, and §7.5's Separate Ways row is unchanged.

### 15.3 Pagination convention — opaque cursor

Admitted by `ADR-0083` §4.5 on ruling **AO-2** (`LCF-ADR-003`).

| Rule | Statement |
|---|---|
| **PG-1** | Feed and list pagination SHALL use an **opaque, server-generated cursor**. |
| **PG-2** | The cursor SHALL be treated by clients as an **opaque value**. Clients SHALL NOT parse, construct, decrement or arithmetically manipulate it. |
| **PG-3** | The cursor SHALL NOT expose internal ordering keys, database identifiers, offsets, table names or index structure. |
| **PG-4** | An expired or malformed cursor SHALL produce a domain error, never a silent reset to the first page. |

⭐ **This populates a node the Enterprise Architecture had already declared and left empty.** EA **L379** reads
`Pagination & Filtering Standards (V1)` beneath `API Specification (V1)`, and a measured sweep of
`docs/10-architecture/*.md` for `cursor`, `opaque token` and `page token` returned **0** occurrences. So this is
a reserved slot being filled, **not** a new architectural layer.

### 15.4 ⭐ Event envelope `tenantId` and `BC-15` — the exception, narrowly scoped

Admitted by `ADR-0083` §4.5 on ruling **AO-6** (`LCT-CONF-002`).

| Rule | Statement |
|---|---|
| **EV-1** | `BC-15` community events SHALL NOT carry a `tenantId` in the event envelope. |
| **EV-2** | This is **not** a relaxation of `ID-2`. §11 **L488** already requires that `BC-11`→`17` *"must never receive a `StudentRecordId` or `tenantId`"*. The defect was an envelope rule phrased as universal; `ID-2` is and was authoritative. |
| **EV-3** | Community scope is carried by the community's own identifier, which is **not** tenant-derived — `Accepted` [`ADR-0078`](../00-governance/adr/ADR-0078-community-scope-identifier-carries-no-tenantid.md) §2.1. |
| **EV-4** | ⛔ **No other bounded context receives this exception** without a separate authorisation. |

⭐ Stated plainly: **nothing is being exempted from `ID-2`.** `ID-2` forbids the field; this rule stops an
envelope convention from contradicting it. `PRD-021A` A2 and A8 now share one rule.

### 15.5 `BC-15` aggregates registered

Admitted by `ADR-0083` §4.5 on ruling **AO-8** (D-5). ⭐ **Appended rather than inserted into §8** — a mid-table
insert at ~L388 was measured to invalidate **747** line-citations. **§8's table is byte-unchanged.**

| Context | Aggregate root(s) | Members | Key invariants |
|---|---|---|---|
| **BC-15 Community & Groups** | `Community` · `Group` | `GroupMembership`, `CommunityRole`, `GroupVisibility`, `GroupLifecycleState` | `CommunityRole` ∈ {`OWNER`, `MODERATOR`, `MEMBER`}, closed, ranked `OWNER > MODERATOR > MEMBER` (`ADR-0083` §3, PO-4) · `visibility` ∈ {`PUBLIC`, `PRIVATE`}, closed (PO-5) · **a community SHALL NOT become ownerless** — the last `OWNER`'s departure is blocked until another member is explicitly promoted, and **no silent auto-promotion occurs** (PO-6) · `CommunityRole` and `BC-18` `AccessRole` are **disjoint namespaces** · carries **no** `tenantId` (`ID-2`, §15.4) |

⛔ **No existing aggregate ownership moves.** `ModerationCase`, `AbuseReport`, `EnforcementAction` and
`StrikeRecord` remain **`BC-13`'s** (**L379**); `Friendship`, `BlockList` and `RateLimitCounter` remain
**`BC-11`'s** (**L377**); user-generated media remains **`BC-14`'s** (**L118**). ⚠ `Group.name` uniqueness is
**NOT** specified — the unanswered half of `LCG-DEC-005`, tracked as `LCG-DEC-005b`, **Product Owner**.

### 15.6 Moderation reads, and search — what is authorised and what is refused

| Subject | Determination |
|---|---|
| **Moderation reads** (`LCS-ADR-001`, ruling **AO-4**) | ✅ **Option B — existing-edge-fed local projection. ZERO new edges.** `BC-15` and A6 read a **local projection fed by the existing `E-14`**, which already targets `BC-15` (**L318**), following `Accepted` [`ADR-0065`](../00-governance/adr/ADR-0065-bc12-send-time-safety-check-transport.md). ⛔ **No `BC-15` → `BC-13` edge is created.** Moderation state stays owned by `BC-13` / `PRD-020`; A6 reads, never writes, and holds no moderation aggregate |
| **Media** (ruling **AO-3**) | ✅ Authorised as `E-29`, §15.1 — subject to §15.1.1 |
| **Community search** (ruling **AO-9**) | ⛔ **NOT AUTHORISED, and no support is claimed.** AO-9 permits `E-21` *"only if the existing contract supports it without inventing a new search protocol"*. **Measured: `E-21` (L330) reads `BC-01, BC-10 → BC-23`. `BC-15` is NOT a consumer.** It does not support it. Per AO-9's own conditional the amendment is **recorded, not assumed**: community search is **out of band for V2**, and `PRD-021A` A8 `LCT-FR-064` and `LCT-AC-032` are **CONFIRMED CORRECT** |

### 15.7 What this section does **not** do

- ⛔ Does **not** add a bounded context — **31** before and after, 23 in V1.
- ⛔ Does **not** change any existing edge's endpoints, pattern, mechanism or contract. **§7 is byte-unchanged.**
- ⛔ Does **not** change any existing aggregate or invariant. **§8 is byte-unchanged.**
- ⛔ Does **not** mint `E-27` or reuse any withdrawn number.
- ⛔ Does **not** make `BC-15` an event producer, and authorises **no** `BC-15`-sourced event.
- ⛔ Does **not** create a `BC-15` → `BC-13` edge.
- ⛔ Does **not** move `BC-14` or `BC-15` from V2 into V1.
- ⛔ Does **not** add a `tenantId` to anything, and does not weaken `ID-2`, `ID-1` or `X-05`.
- ⛔ Does **not** confer any lifecycle stage on `PRD-021A` or any of its parts.

---

## 16. ⭐ ADR-0085 Extension — `communityId`, the `BC-15` community/group scoping identifier (V2)

Admitted by `Accepted` [`ADR-0085`](../00-governance/adr/ADR-0085-communityid-scoping-identifier-published.md)
§3 on **Architecture Owner** authority, discharging ruling 3 of the `PRD-021A` Owner Rulings:
*"approve a stable `communityId` as the required community/group scoping identifier and publish it
through the appropriate existing architecture contract. Do not create duplicate identifiers."*

⭐ **Appended, not inserted.** §1–§15 are **byte-identical to v1.9** apart from the header `Version`
cell, the header `Context Count` cell and one changelog row. See §16.4 for the measurement.

### 16.1 The rules

| Rule | Statement |
|---|---|
| **CID-1** | `BC-15`'s `Community` and `Group` aggregates (**§15.5**) SHALL be scoped by a **`communityId`**. It is the **required** community/group scoping identifier, named here for the first time in a normative contract. |
| **CID-2** | **`BC-15` is the sole minting authority.** No other bounded context creates, allocates or reassigns a `communityId`, because `BC-15` owns both aggregates (**§15.5**). |
| **CID-3** | A `communityId` SHALL be **stable and immutable** for the lifetime of the aggregate it identifies. It is never re-pointed, recycled or reissued. |
| **CID-4** | A `communityId` SHALL NOT be derived from, encode, or be recoverable to a `tenantId`. This **preserves** `ID-2` and **`EV-3`** (**§15.4**) unchanged and grants **no** new exemption. |
| **CID-5** | ⛔ **No second scoping identifier for `BC-15` is authorised.** A community or group is scoped by its `communityId` and by nothing else. Any alternative requires its own ADR. |
| **CID-6** | ⚠ **The representation is deliberately UNSPECIFIED.** No format, encoding, length, character set, ordering property or generation algorithm is decided here. This is recorded as an **open residue**, not an omission. |

### 16.2 ⭐ This names an existing concept; it does not introduce one

The concept was already `Accepted` — only its **name** and its **contract** were missing.

| Existing record | What it already says |
|---|---|
| `Accepted` [`ADR-0078`](../00-governance/adr/ADR-0078-community-scope-identifier-carries-no-tenantid.md) **§2.1** | *"`BC-15`'s aggregates key exclusively on `PersonId` and on **`BC-15`-owned community identifiers**"* |
| **§15.4 `EV-3`** (this file, v1.9) | *"Community scope is carried by **the community's own identifier**, which is **not** tenant-derived"* |
| `PRD-021A` A4 **L228** | `` `communityId` | Identifier | Mandatory, immutable. Scoping key `` |

⭐ **The duplicate-identifier prohibition was tested, not assumed.** `grep -c communityId` against this
file at v1.9 returned **0**, and `grep -rn "CID-[0-9]"` across `docs/` and `tool/` returned **0**. The
`CID-` stem and the name `communityId` were both free before use. Nothing is renamed and nothing is
superseded: `CID-1`…`CID-6` **publish** the identifier that `ADR-0078` §2.1 and `EV-3` already presume.

### 16.3 What this unblocks, and what it does not

`PRD-021A` A4 **L276** records the defect as *"no contract defines how a `communityId` is minted or
resolved"*. **`CID-1`…`CID-5` define exactly that**, so A4 **L393**'s blocked group-creation path may
proceed. `LCG-GAP-006` and `LCG-ADR-003` are closed by `ADR-0085` §3.

⛔ **It does not confer a lifecycle stage.** `PRD-021A` and every one of its parts remain **NOT
FROZEN**; Stage 7 remains **NOT CONFERRED**. Publishing a Rank 4 contract is not a freeze act.

### 16.4 ⭐ Measurement, and one disclosed cost

| Quantity | Measured |
|---|---|
| Tight-window line-citations into this file (≤ 763) | **2,977** |
| Candidates resolving at or above the changelog row (**L613**) | **14** |
| — of those, false positives (cite *other* documents) | **11** |
| — of those, version-qualified to v1.9 and therefore still true | **1** (`ADR-0083` **L115**) |
| ⭐ Citations invalidated by the **append** below former **L763** | ⭐ **0** |
| ⚠ Citations invalidated by the **mandated changelog row** | ⚠ **1** |

⚠ **The one cost, disclosed rather than hidden or silently repaired.**
`PRD-021A_STAGE4_AC_REQUIREMENT_MAPPING_2026-09-01.md` **L524** cites this file's **L649** for the
28-edge set. The changelog row shifts that content to **L650**, so the pointer is off by one.

**It is deliberately NOT repaired.** That file is a **dated Stage-4 review record**, committed at
`12b0071`, and historical review records are not edited after the fact. The defect is therefore
**disclosed as `GAP-BCMAP-L649-CITE`** and routed, exactly as `ADR-0083` disclosed and repaired its own
single-citation cost in the commit that caused it. ⭐ **The row could not be avoided**:
`DOCUMENTATION_BASELINE.md` **§7 rule 2** requires that *"the changed document's version is incremented
and its changelog updated in the same commit"*, and a changelog omitting its own current version is the
worse defect. The alternative — deleting a blank line below **L613** to keep the count stable — was
**rejected**: it would edit §15, which this amendment declares byte-identical.

### 16.5 What this section does **not** do

- ⛔ Does **not** add, remove or alter a bounded context — **31** before and after, 23 in V1.
- ⛔ Does **not** add, remove or alter an edge. The set stays `E-01`…`E-26`, `E-28`, `E-29`; `E-27` stays vacant.
- ⛔ Does **not** alter any aggregate, member or invariant. **§8 and §15.5 are byte-unchanged.**
- ⛔ Does **not** specify a format, encoding, length or generation algorithm — see **`CID-6`**.
- ⛔ Does **not** create a second identifier, alias or synonym for community scope.
- ⛔ Does **not** weaken `ID-1`, `ID-2`, `X-05` or `EV-1`…`EV-4`.
- ⛔ Does **not** make `BC-15` an event producer — `LCG-ADR-002` stays **OPEN**.
- ⛔ Does **not** re-issue the baseline — this file is **Rank 4** (`DOCUMENTATION_BASELINE.md` §7 rule 4).
- ⛔ Does **not** confer any lifecycle stage on `PRD-021A` or any of its parts.
