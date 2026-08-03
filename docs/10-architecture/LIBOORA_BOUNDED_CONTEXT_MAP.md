# LIBOORA — Bounded Context Map (V1)

| Field | Value |
|---|---|
| **Document** | Bounded Context Map |
| **Version** | v1.2 |
| **Status** | Draft for Architecture Review Board sign-off |
| **Derived from** | `LIBOORA_ENTERPRISE_ARCHITECTURE.md` v2.0 (commit `aba0831`) |
| **Last Updated** | 2026-08-02 |
| **Context Count** | 31 (23 in V1 scope) — **unchanged by v1.1 and v1.2** |
| **Companion doc** | `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` |
| **Rulings applied** | `AR-1`, `AR-2`, `AR-3`, `AR-4`, `AR-5`, `AR-6`, `AR-7` — see [`ARCHITECTURE_RULINGS.md`](./ARCHITECTURE_RULINGS.md) |

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

### 3.2 Supporting Domain Contexts (Global Student)

| ID | Context | Type | Owning Platform | V | Responsibility |
|---|---|---|---|---|---|
| **BC-10** | **Global Student Identity** | `[SUPPORTING]` | Global Student | V1 | Owns the person's cross-library public self: username, public profile, privacy settings, verification. |
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
| **Core-classified** | 7 | BC-01→06 + BC-13 |

**Investment rule:** `[CORE]` contexts get hand-written rich domain models, exhaustive unit tests, and ADR-level scrutiny on every change. `[GENERIC]` contexts get the thinnest wrapper that satisfies the port — prefer configuration over code, and buy over build wherever a vendor exists.

---

## 4. The Identity Triad

This is the highest-risk modelling decision in LIBOORA and the one most likely to be got wrong by a team moving fast.

**A single human being appears in three contexts with three different identities and three different lifecycles.** Collapsing them into one `User` table is the mistake that makes multi-library membership, privacy, and account deletion unimplementable later.

| Identity | ID type | Owner | Scope | Lifecycle |
|---|---|---|---|---|
| **Account** | `AccountId` | BC-18 Identity & Access | Global, cross-tenant | Created on first successful OTP. Destroyed on account deletion. Holds *credentials only*. |
| **Person / Global Student** | `PersonId` | BC-10 Global Student Identity | Global, cross-tenant | Created when the human opts into the social product. Holds public profile, username, privacy. **May not exist** for a student who only ever uses the library. |
| **Student Record** | `StudentRecordId` | BC-01 Enrollment | **Per-tenant** | Created when a library enrolls them. One human enrolled at three libraries has **three** `StudentRecordId`s. Survives account deletion (financial/audit record). |

### 4.1 The Linkage Rules

```
AccountId  1 ──── 0..1  PersonId          (an account may never opt into social)
AccountId  1 ──── 0..*  StudentRecordId   (one login, many library enrollments)
PersonId   1 ──── 0..*  StudentRecordId   (social profile spans libraries)
StudentRecordId ── 1     TenantId          (ALWAYS tenant-scoped, no exceptions)
```

| Rule | Statement | Enforcement |
|---|---|---|
| **ID-1** | No context outside BC-18 may store a password, OTP, session or credential. | Security review + schema scan in CI |
| **ID-2** | `StudentRecordId` **never** leaves its tenant. It must not appear in any Global Student context, event or index. | Cross-tenant leak test suite (Quality Platform) |
| **ID-3** | Social contexts (BC-10→17) key exclusively on `PersonId`. They must not be able to resolve which library a person attends unless the person explicitly published it. | ACL at Global Student boundary |
| **ID-4** | Library contexts (BC-01→09) key exclusively on `StudentRecordId`. They may hold a nullable `PersonId` reference for social linkage, and must degrade gracefully when it is null. | Nullable by design; tests assert null path |
| **ID-5** | Account deletion (DSR) deletes the `Account` and anonymises the `Person`. It **does not** delete `StudentRecord` financial and attendance history — that is retained under legal basis and pseudonymised. | Data Privacy runbook + retention policy |
| **ID-6** | A minor's `Account` is linked to a guardian consent record before any social context is activated. | BC-18 Consent Management gate |

### 4.2 Why this matters commercially

Multi-library membership (V2) and Cross-Product Identity (Future) are both listed in the tree. Neither is achievable if `StudentRecordId` and `PersonId` are the same column. This triad is what makes those roadmap items a schema-compatible extension rather than a rewrite.

---

## 5. Ubiquitous Language Collisions

Each row is a word that means **different things in different contexts**. Every one of these is a latent bug. The resolution column is binding: these are the names that must appear in code, APIs, events and UI copy.

| Ambiguous word | Context A meaning | Context B meaning | Resolution (binding) |
|---|---|---|---|
| **Student** | BC-01: an enrolled record in *this* library, with dues and a seat | BC-10: a public social persona across libraries | `StudentRecord` (BC-01) vs `GlobalStudentProfile` (BC-10). The bare word `Student` is **banned** in shared code. |
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

1. **`Separate Ways` between Library Management and Global Student is deliberate.** The temptation is to link them tightly ("show a student's friends in the reception dashboard"). Resisting that is what keeps the social product's outages, moderation problems and privacy obligations from taking down the paying product. The only bridge is a nullable `PersonId` and an ACL.

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
| E-12 | BC-18 Identity | BC-10 Global Identity | `CF` | Sync port | `AccountId` → `PersonId` creation on social opt-in |
| E-13 | BC-01 Enrollment | BC-10 Global Identity | **`ACL`** | Explicit user-consented link | Student may link their enrollment to a `PersonId`. **The only bridge between the two worlds.** Enrollment stores nullable `personId`; Global Identity stores **no** `StudentRecordId` (rule ID-2) |
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
| E-22 | BC-01, BC-14 | BC-29 File & Media | `CF` | Sync port | Domain holds a `FileRef`, never bytes or a raw storage path |
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
| Separate Ways | 1 | Library Management ⟷ Global Student (structural) |
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
| BC-10 | `identity.PersonProfileUpdated` | BC-23, BC-11 | Social index |
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
| BC-10→17 Global Student | **Global.** No `tenantId`. Keyed on `PersonId`. | Must never receive a `StudentRecordId` or `tenantId` (rule ID-2). Asserted by cross-tenant leak tests. |
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
| Q-05 | Is Global Student available to a person with **no** library enrollment? | Growth strategy + moderation exposure | Yes (drives PLG), but with reduced trust tier until enrolled |
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
| **Not owned by** | `BC-18` Identity & Access · `BC-02` Membership · `BC-01` Enrollment / Global Student Identity |
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
separation inside one bounded context**, not a context split. No integration edge is added; `E-01`…`E-26` are
unchanged.

---

## Changelog

| Version | Date | Change |
|---|---|---|
| **v1.2** | 2026-08-02 | Applied approved architecture rulings `AR-5`, `AR-6`, `AR-7`. §14 gains three rows; §14.2 added, recording the approved authentication stage sequence and confirming that an `Account` may exist before any tenant role. **No context added, removed, renamed or re-scoped; count remains 31 (23 in V1). No aggregate, invariant, integration edge, event, identity rule or tenancy model changed** — §4 and §11 are confirmed as written, not amended. `AR-6` is a stage separation *within* `BC-18`, not a context split. |
| **v1.1** | 2026-08-02 | Applied approved architecture rulings `AR-1`…`AR-4`. §2 records Library Discovery as a non-context read composition. §11.1 added, distinguishing the Platform Public Discovery Index from Tenant Operational Data without relaxing `MP-GBR-08`, `SE-1` or `X-13`. §14 added as the in-document rulings summary, including invitation ownership. **No context added, removed, renamed or re-scoped; count remains 31 (23 in V1). No aggregate, invariant, integration edge, event, identity rule or tenancy model changed.** |
| **v1.0** | 2026-07-30 | Initial bounded context map derived from Enterprise Architecture v2.0. 31 contexts registered, 26 integration edges specified, Identity Triad defined, 14 ubiquitous-language collisions resolved, 17 aggregates with invariants, 30 V1 events, extraction order set. |



