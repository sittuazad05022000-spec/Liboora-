# `PRD-010` — Notifications & Communication (`BC-22` Notification Delivery)

| Field | Value |
|---|---|
| **Document** | `docs/30-product/notifications/PRD-010_NOTIFICATIONS_AND_COMMUNICATION.md` |
| **Version** | **v0.2** |
| **Status** | ⛔ **`DRAFT`** — ⛔ **not reviewed, not conferred, not frozen, not baselined, not ranked** |
| **Date** | 2026-09-05 |
| **Bounded context** | **`BC-22` Notification Delivery** `[GENERIC]`, family *Communication*, **V1** — BC Map **L131** |
| **Registry row** | `PRD_REGISTRY.md` **L247** — `PRD-010` · Notifications & Communication · `BC-22` · V1 · `PLANNED` |
| **Lifecycle stage** | **Stage 2 — Authoring.** ⛔ Stage 3 not entered. ⛔ No `IMPL-*`. ⛔ No code |
| **Identifier prefix** | `NTF-` — ⚠ **PROPOSED, NOT REGISTERED.** Registration is a **Governance Owner** act (`ADR-0080`); see `NTF-GAP-001` |

> ⛔⛔ **GOVERNANCE NOTICE.** This document is a **first draft**. It claims **no** approval, **no**
> conferral and **no** freeze. It adds nothing to `DOCUMENTATION_BASELINE.md`, creates no admitting
> ADR, modifies no frozen PRD, rewrites no historical record, and creates no implementation task.
> Every statement is labelled **`[EVIDENCE]`**, **`[PROPOSED]`** or **`[OPEN]`**.

---

## 1. Purpose

`BC-22` owns **delivery**: turning a business **fact** emitted by a domain context into a message
that reaches a person over a channel, once, at an appropriate time, with consent respected.

`[EVIDENCE]` BC Map **L131** — `BC-22` *"Owns channel selection, templates, deduplication, quiet
hours, delivery guarantees, consent/unsubscribe."* This sentence is the charter, and this PRD is
bounded by it.

---

## 2. ⭐⭐⭐ Problem statement — and the three findings that reshaped this brief

Three research findings **contradict or materially narrow** the drafting brief. Each is reported with
its evidence, because the repository outranks the brief.

### 2.1 ⭐⭐⭐ FINDING 1 — Student↔Student messaging is **already owned**, by a FROZEN document

| Evidence | Reading |
|---|---|
| BC Map **L116** | **`BC-12` Messaging** `[SUPPORTING]`, V1 — *"Owns conversations and messages, delivery guarantees, retention, presence"* |
| BC Map **L378** | `BC-12` aggregate `Conversation`, entities `Message`, `DeliveryReceipt`, `RetentionPolicy` |
| BC Map **L320** | **`E-16`** `BC-11 → BC-12` `C/S` sync port — `canMessage(a, b)`; *"block enforcement lives in the graph"* |
| BC Map **L430** | `BC-11` `social.FriendshipEstablished` / `UserBlocked` → `BC-12` — messaging permission |
| BC Map **L431** | `BC-12` `messaging.MessageSent` → `BC-13` (sampling), `BC-26` |
| `PRD_REGISTRY.md` | `PRD-021B` (`BC-11` + `BC-12`) is **`FROZEN`**, Rank 3, admitted by `ADR-0092` |

⇒ ⛔⛔ **`PRD-010` does NOT own Student↔Student messaging, one-to-one chat, group chat, unread/read
state of conversations, or block/report.** All are `BC-12`/`BC-11`/`BC-13`, and `PRD-021B` is frozen.
`PRD-010` owns only the **notification about** a message — see **§13**.

### 2.2 ⭐⭐⭐ FINDING 2 — SMS, Email and WhatsApp are **V2**, not V1

| Evidence | Reading |
|---|---|
| `MASTER_PRD.md` **L97** `MP-SCOPE-09` | *"SMS, Email and WhatsApp as **general-purpose** notification channels — **V2** — see §22 for the V1 OTP-delivery exception"* |
| `MASTER_PRD.md` §22 **L450-455** | Push **V1** · In-App **V1** · **SMS — OTP delivery only: V1 mandatory** · SMS general **V2** · Email **V2** · WhatsApp **V2** |
| EA **L1502** | *"WhatsApp Integration (V3) — [adapter in INTEGRATION PLATFORM]"* |
| EA **L1821** | *"WhatsApp Business Integration (V3)"* |

⇒ ⭐⭐ **The brief's instruction to keep WhatsApp lightweight is not merely prudent — it is
mandatory.** `MASTER_PRD` is **Rank 1**. A V1 `PRD-010` that shipped an Email or general-SMS channel
would contradict Rank 1. ⇒ **V1 integrated channels are exactly two: In-App and Push.**

⚠ **And OTP SMS is NOT `BC-22`'s** — see **§5 N7**.

### 2.3 ⭐⭐⭐ FINDING 3 — *"Platform Admin"* does **not exist** in the authoritative vocabulary

Measured repo-wide:

| Probe | Result |
|---|---|
| `"Platform Admin"` in BC Map + `PRD_OWNERSHIP_MODEL.md` | ⛔ **0 occurrences** |
| `PLATFORM_ADMIN` / `SUPER_ADMIN` in `Authentication_PRD_v2.md` | ⛔ **0 occurrences** |
| `MASTER_PRD.md` **L120** `MP-GBR-21` | *"The scope register is **closed**: `self`, `guardianOf`, `tenantWide`. **No fourth scope may be introduced without an ADR**"* |
| `Library_PRD_v1.md` **L596** | Supported roles: **Owner · Manager · Reception Staff** |
| `Library_PRD_v1.md` **L612** `LIB-15.3` | Modules *"MUST NOT decide, store or evaluate permissions"* — `BC-18` does |

⇒ ⚠⚠ **A platform-wide notification-broadcast authority would require a FOURTH scope, which
`MP-GBR-21` closes absent an ADR.** ⛔ **This draft therefore does NOT create a Platform Admin
role, and does not grant platform-wide broadcast.** The capability is specified as **conditional and
blocked** at `NTF-GAP-002`, and the platform-level *configuration* surface that **can** be supported
today is specified instead at §20 via **`BC-25` Configuration**.

⭐ **This is the single most important correction in this draft.** The brief asked for Platform Admin
as *"a distinct platform-level authority layer **if supported by the repository**."* Measured: it is
**not** supported. I therefore did not invent it.

---

## 3. Product goals

| # | Goal | Basis |
|---|---|---|
| G1 | Every authoritative V1 business fact that warrants a notice produces exactly one notice per recipient per channel | `[EVIDENCE]` BC Map L131 dedup |
| G2 | No domain context ever performs channel delivery | `[EVIDENCE]` `MP-GBR-33`, `E-23`, `AUTH-10.3` |
| G3 | Authorized tenant staff can communicate with an explicitly bounded audience, safely and auditably | `[PROPOSED]` |
| G4 | Consent, quiet hours and dedup apply to every channel | `[EVIDENCE]` `MP-GBR-35` |
| G5 | No event or notification payload leaks a mobile number | `[EVIDENCE]` `MP-GBR-34` |
| G6 | Tenant isolation is absolute; recipient sets never cross a tenant | `[EVIDENCE]` `MP-GBR-21`, `BC-19` |

---

## 4. Scope (V1)

✅ In-App notification inbox and feed projection · ✅ Push (FCM) delivery · ✅ Notification catalogue
bound to real V1 events · ✅ Templates with approved placeholders · ✅ Deduplication and idempotency ·
✅ Quiet hours · ✅ Consent / unsubscribe · ✅ Delivery lifecycle and retry · ✅ Tenant-scoped manual
communication with preview + confirm · ✅ External WhatsApp **redirect only** · ✅ Delivery
observability · ✅ Audit **via `BC-24`**

## 5. Non-scope (V1) — every entry has evidence

| # | Excluded | Owner / basis |
|---|---|---|
| N1 | Conversations, messages, chat, presence, retention | `BC-12` — BC Map L116/L378; `PRD-021B` **FROZEN** |
| N2 | Friend graph, block/unblock, `canMessage` | `BC-11` — L320 `E-16` |
| N3 | Abuse reports, moderation cases, enforcement | `BC-13` — L318 `E-14` |
| N4 | **Email channel** | ⛔ **V2** — `MP-SCOPE-09`, §22 |
| N5 | **General-purpose SMS** | ⛔ **V2** — `MP-SCOPE-09`, §22 |
| N6 | **WhatsApp Business / Cloud API, webhooks, credentials, delivery tracking, inbound, history, templates, billing** | ⛔ **V3** — EA **L1502**, **L1821** |
| N7 | OTP generation **and OTP SMS delivery** | `BC-18` / Auth PRD — `AUTH-10.3`; `MASTER_PRD` §22 assigns OTP SMS to authentication, not to `BC-22` as a general channel |
| N8 | Provider credentials, vendor contracts, outbound retries to third parties | **`BC-31` Integration** — BC Map L140 |
| N9 | The immutable audit record itself | **`BC-24`** — BC Map L133 |
| N10 | Settings hierarchy, feature flags, secret references | **`BC-25`** — BC Map L134; `PRD-023` **FROZEN** |
| N11 | Deciding/storing/evaluating permissions | **`BC-18`** — `LIB-15.3`, `AUTH-7.3` |
| N12 | Broadcast Messaging, Communication Analytics | ⛔ **V2** — EA **L1500-1501** |
| N13 | Voice calls, video broadcasting | ⛔ Future — EA **L1503-1504** |
| N14 | Any platform-wide (cross-tenant) audience | ⛔ Blocked by `MP-GBR-21` — `NTF-GAP-002` |
| N15 | Creating a Platform Admin role | ⛔ Not in the vocabulary — §2.3 |

⚠ **N4/N5/N6 are the correction of a likely product expectation.** They are excluded because
**Rank 1** says V2/V3, not because they are undesirable.

---

## 6. Bounded-context ownership

```
Domain contexts (BC-01..BC-20, BC-13, BC-18, BC-19)
        │  emit FACTS only  ── E-23 (PL, Event) ──►  BC-22 Notification Delivery
        │                                                    │
        │                                    ┌───────────────┼───────────────┐
        │                                    ▼               ▼               ▼
        │                              In-App inbox      Push (FCM)     [V2 channels]
        │                                                    │
        └── BC-24 Audit ◄── who sent what ──────────────────┘
                    BC-25 Configuration ──► notification settings hierarchy
                    BC-31 Integration   ──► provider credentials/contracts
```

`[EVIDENCE]` BC Map **L265** — *"`BC-22` Notification Delivery ◄── **event-driven only**"*.
`[EVIDENCE]` BC Map **L205** — `DeliveryMessage` (`BC-22`) vs `FeedItem` *"owned by `BC-22`'s inbox
projection"* ⇒ ⭐ **the in-app inbox projection is `BC-22`'s**, and this draft claims no more.

### 6.1 ⭐⭐ The authoritative module contract — `platform/communication`

`[EVIDENCE]` **`BC-22` is implemented by the module `platform/communication`.** The mapping appears
in neither the BC Map nor the Dependency Matrix, and is established by three live documents:
`DEVELOPER_HANDOFF.md` **L189** (*"emit a fact (`LEV-*`), let `BC-22` deliver it"*),
`INVITATION_SECURITY_SPECIFICATION.md` **`IAC-23`**, and `REVIEW_14A.md` **`CC-5`**.

`tool/module_dependencies.yaml` **L392-410** is therefore binding on this PRD:

| Element | Authoritative value |
|---|---|
| **Rank** | **5** |
| Imports | `contracts` (rank **0**) — ⭐ downward, `L2` satisfied |
| Port | `platform/integration:connector` — the `BC-31` egress route |
| ⭐ Port | **`platform/identity:notification_address`** — **AMENDMENT `A-3`**, *"the narrow, purpose-limited delivery-address port… resolves ONE address for ONE queued delivery, at delivery time"*; ⭐⭐ *"**this port is the reason no event ever carries a number**"*. Constraint (**L462-464**): *"one address, one queued delivery, resolved at delivery time, **never retained by the caller**"* |
| Events | `consumes_events: ["*"]` — ⭐ `PL` consumption over `E-23`, ⛔ not an import |
| Banned imports | `["domain/**", "app/**"]` |

⭐ **The three module assertions, and where this PRD carries each:**

| Assertion | Authoritative rule | Carried by |
|---|---|---|
| **`CM-1`** | *"`notification_address` is called with an `AccountId` and a delivery purpose; **never with a number, never in bulk, never to test existence**"* | `NTF-INV-003` (no number) · `NTF-FR-004` (per-delivery, never a cached list) · `NTF-FR-009` (no existence/enumeration) |
| **`CM-2`** | *"**no resolved address is persisted, cached, indexed or logged** by this platform"* | `NTF-FR-058` (bars phone/email from bodies, events **and logs**) · `NTF-FR-004` |
| ⭐⭐ **`CM-3`** | *"an unresolvable address **fails the delivery only; it never fails the emitting operation**"* — **`EBR-1030`** | ⭐ **`NTF-INV-011`** (§19) |

⚠ **`A-3` is the mechanism behind `MP-GBR-34`.** Rank 1 forbids a mobile number in any event; `A-3`
is *how* that is achieved — the address is resolved at delivery time through a purpose-limited port,
so no event ever needs to carry one. ⭐ `NTF-INV-003` states the rule; this section names the
mechanism.

⚠ **One pre-existing manifest condition is DISCLOSED and NOT relied upon:** `platform/communication`
(rank 5) declares a port to `platform/integration` (**also rank 5**), while Dependency Matrix **§3.2**
declares only two same-rank clusters, **both within R8**. Recorded as **`NTF-AL-F2`** in
`PRD-010_ARCHITECTURE_ALIGNMENT.md` §4.4, owner **Architecture Owner**. ⛔ **This PRD neither created
it nor may cure it** — amending the manifest is an ADR act (Matrix **L54**) — and ⛔ **no requirement
here depends on that port being lawful**; `NTF-FR-031` states only that Push egress traverses `BC-31`,
per `MASTER_PRD` **L229**.

---

### 6.2 Requirements

| ID | Requirement |
|---|---|
| **`NTF-INV-001`** | `BC-22` **MUST NOT** write to any domain aggregate. It consumes facts and owns only delivery state and the inbox projection. |
| **`NTF-INV-002`** | `BC-22` **MUST NOT** accept an instruction to deliver from a domain context. Only **facts** cross `E-23`. `[EVIDENCE]` `MP-GBR-33`, `AUTH-10.3` |
| **`NTF-INV-003`** | No `BC-22` inbound event or outbound payload may contain a mobile number. `[EVIDENCE]` `MP-GBR-34` |
| **`NTF-INV-004`** | `BC-22` **MUST NOT** decide, store or evaluate a permission; it **MUST** ask `BC-18` at action time. `[EVIDENCE]` `LIB-15.3`, `AUTH-7.3` |
| **`NTF-INV-005`** | `BC-22` **MUST NOT** hold provider credentials; outbound third-party contracts are `BC-31`. `[EVIDENCE]` BC Map L140 |
| **`NTF-INV-006`** | `BC-22` **MUST NOT** maintain a second audit store; audit facts go to `BC-24`. `[EVIDENCE]` BC Map L133 |

---

## 7. Actors and terminology

| Actor | Repository basis | Notes |
|---|---|---|
| **Owner** | `Library_PRD_v1.md` **L596** | Tenant-scoped maximum authority |
| **Manager** | **L596** | Tenant-scoped, delegated |
| **Reception Staff** | **L596** | ⚠ The authoritative name is **"Reception Staff"**, not "Staff" |
| **Student** | `MASTER_PRD` **L110** | `AccountId` + `StudentRecordId` per library |
| **Parent** | `MASTER_PRD` **L111**, **L124** | *"full `Account` with a guardian role"*; scope `guardianOf` |
| **System** | `E-23` | The event consumer |
| ⚠ **Platform Admin** | ⛔ **0 occurrences** | **Not an actor in V1** — §2.3, `NTF-GAP-002` |

`[EVIDENCE]` `MP-GBR-21` — authorization scopes are the **closed** set `self`, `guardianOf`,
`tenantWide`. ⭐ **Every audience in this PRD resolves to one of these three. There is no fourth.**

---

## 8. ⭐⭐ Automatic notification catalogue — built from the BC Map event table, not invented

`[EVIDENCE]` Every row below is an event the BC Map §8 table **already routes to `BC-22`**. ⛔ No
event was invented; ⛔ no timing is asserted.

| Trigger event (BC Map line) | Source | Audience | Timing | Channel (V1) |
|---|---|---|---|---|
| `enrollment.StudentEnrolled` (**L405**) | `BC-01` | Student, `guardianOf` | Immediate | In-App + Push |
| `membership.MembershipCreated` (**L409**) | `BC-02` | Student, `guardianOf` | Immediate | In-App + Push |
| `membership.MembershipRenewed` (**L410**) | `BC-02` | Student, `guardianOf` | Immediate | In-App + Push |
| ⭐ `membership.MembershipExpiringSoon` (**L411**) | `BC-02` | Student, `guardianOf` | ⚠ **`NTF-GAP-003`** | In-App + Push |
| `membership.MembershipExpired` (**L412**) | `BC-02` | Student, `guardianOf` | Immediate | In-App + Push |
| `attendance.StudentCheckedIn` (**L414**) | `BC-03` | ⭐ `guardianOf` — L414 says *"parent notification"* | Immediate | In-App + Push |
| `attendance.FraudSignalDetected` (**L417**) | `BC-03` | Owner, Manager | Immediate | In-App + Push |
| `seating.SeatAssigned`/`Released`/`Transferred` (**L418**) | `BC-04` | Student | Immediate | In-App |
| `seating.OccupancyThresholdCrossed` (**L419**) | `BC-04` | Owner, Manager | Immediate | In-App + Push |
| `fee.FeeDueRaised` (**L420**) | `BC-05` | Student, `guardianOf` | ⚠ **`NTF-GAP-003`** | In-App + Push |
| `fee.FeePaymentReceived` (**L421**) | `BC-05` | Student, `guardianOf` | Immediate | In-App + Push |
| `safety.AbuseReportFiled` (**L432**) | `BC-13` | ⚠ moderator — **`NTF-GAP-004`** | Immediate | In-App |
| `billing.SubscriptionActivated`/`Cancelled`/`PaymentFailed` (**L436**) | `BC-20` | Owner | Immediate | In-App + Push |

### 8.1 ⛔ Events the brief requested that the repository does **NOT** route to `BC-22`

| Brief item | Measured |
|---|---|
| Grace-period started / nearing / expired | ⛔ **No such event in BC Map §8.** `MembershipFrozen`/`Unfrozen` (**L413**) route to `BC-05`/`BC-04`/`BC-26` — ⛔ **not `BC-22`** ⇒ `NTF-GAP-005` |
| Payment failed (tenant fees) | ⛔ Only `billing.PaymentFailed` (`BC-20`, library→Liboora) exists; ⛔ no `fee.PaymentFailed` ⇒ `NTF-GAP-005` |
| Outstanding balance | ⛔ No event ⇒ `NTF-GAP-005` |
| Absence-related events | ⛔ No `attendance.StudentAbsent` event exists ⇒ `NTF-GAP-005` |
| Account/security, OTP, account status | ⚠ `iam.AccountCreated`/`SessionRevoked`/`ConsentGranted` (**L437**) route to **`BC-24`, `BC-26` — NOT `BC-22`**. ⭐ But `AUTH-10.3` says Auth *"MUST only determine that one is warranted and emit the fact"*, and Auth §10 lists *"notification"* among consumers (**L91**, L111, L121, L141, L203) ⇒ ⚠ **the BC Map §8 row and the Auth PRD disagree** ⇒ **`NTF-GAP-006`** |
| Staff / Manager / Owner creation lifecycle | ⛔ No event; staff invitation is `INVITATION_SECURITY_SPECIFICATION.md` ⇒ `NTF-GAP-005` |
| Renewal reminder | ⚠ Covered by `MembershipExpiringSoon`; ⛔ no separate event |

⭐⭐ **This is the most consequential section of the draft.** Roughly half the automatic
notifications the brief listed have **no authoritative source event**. Inventing them would have
created requirements that can never be satisfied. They are registered as gaps instead.

### 8.2 Requirements

| ID | Requirement |
|---|---|
| **`NTF-FR-001`** | Each catalogue entry **MUST** name exactly one source event, one audience scope, one timing rule, one template and one channel set. |
| **`NTF-FR-002`** | A notification **MUST NOT** be produced for any trigger not in the catalogue. |
| **`NTF-FR-003`** | If a consumed event's payload lacks a field a template requires, `BC-22` **MUST** fail the notification and record it, and **MUST NOT** query a domain context to enrich it. |
| **`NTF-FR-004`** | Where audience is `guardianOf`, `BC-22` **MUST** resolve guardians via `BC-18`/`BC-10` at delivery time, never from a cached list in the event. |

---

## 9. Recipient resolution and audience

| ID | Requirement |
|---|---|
| **`NTF-FR-005`** | Every audience **MUST** resolve to `self`, `guardianOf` or `tenantWide`. `[EVIDENCE]` `MP-GBR-21` |
| **`NTF-FR-006`** | `tenantWide` **MUST** be bounded by exactly one `TenantId`. A recipient set spanning two tenants **MUST** be rejected. |
| **`NTF-FR-007`** | Recipient eligibility **MUST** be re-evaluated at send time, not at selection time. |
| **`NTF-FR-008`** | A denial on `self`/`guardianOf` **MUST** be indistinguishable from not-found. `[EVIDENCE]` `MP-GBR-22` |
| **`NTF-FR-009`** | Recipient **count** may be shown; recipient **identities MUST NOT** be enumerable beyond what the actor is independently authorized to read. |

⭐ **`NTF-FR-009`** implements the brief's rule that *"ability to discover a user does not imply
permission to communicate with them"* — and `MP-GBR-22` is its Rank-1 anchor.

---

## 10. Manual communication — Send-to-All and selected recipients

| ID | Requirement |
|---|---|
| **`NTF-FR-010`** | "All" **MUST** mean an explicitly named, tenant-bounded, role-filtered eligible audience. It **MUST NOT** mean every platform user. `[EVIDENCE]` `MP-GBR-21` |
| **`NTF-FR-011`** | Before dispatch the initiator **MUST** be shown: audience definition, resolved recipient count, template, channel set. |
| **`NTF-FR-012`** | Dispatch **MUST** require an explicit confirmation distinct from the preview action. |
| **`NTF-FR-013`** | One dispatch to N recipients **MUST** be one auditable operation with one `OperationId` and N delivery records. |
| **`NTF-FR-014`** | A dispatch **MUST** be cancellable while any recipient remains in `queued`. |
| **`NTF-FR-015`** | Partial failure **MUST NOT** fail the operation; per-recipient state is authoritative and the operation reports `partially_failed`. |
| **`NTF-FR-016`** | Re-submitting the same `OperationId` **MUST** be idempotent and **MUST NOT** re-deliver. |
| **`NTF-FR-017`** | ⚠ Recipient-count ceiling and rate limit are **`NTF-GAP-007`** — ⛔ **no number is proposed** |

---

## 11. ⭐ Permission matrix — proposed, and explicitly not self-authorizing

`[EVIDENCE]` `LIB-15.3`/`AUTH-7.3`: this PRD **may not** decide permissions. The matrix below is a
**`[PROPOSED]`** input to `BC-18`, and is registered as **`NTF-GAP-008`** pending the Authorization
PRD's authority.

| Capability | Owner | Manager | Reception Staff | Student | Parent |
|---|---|---|---|---|---|
| Receive catalogue notifications | ✅ | ✅ | ✅ | ✅ | ✅ (`guardianOf`) |
| Send to selected recipients | ✅ | ⚠ delegated | ⛔ **not by default** | ⛔ | ⛔ |
| Send to all eligible (tenant) | ✅ | ⚠ delegated | ⛔ | ⛔ | ⛔ |
| Use approved template | ✅ | ✅ | ⚠ if granted | ⛔ | ⛔ |
| Author free-text content | ✅ | ⚠ delegated | ⛔ | ⛔ | ⛔ |
| Schedule a communication | ⚠ **`NTF-GAP-009`** | ⚠ | ⛔ | ⛔ | ⛔ |
| View communication history | ✅ | ✅ | ⚠ own only | ⛔ | ⛔ |
| View delivery status | ✅ | ✅ | ⚠ own only | ⛔ | ⛔ |
| WhatsApp redirect | ⚠ if contact-visible | ⚠ | ⚠ | ⛔ | ⛔ |
| Platform-wide broadcast | ⛔ | ⛔ | ⛔ | ⛔ | ⛔ |

| ID | Requirement |
|---|---|
| **`NTF-BR-001`** | Reception Staff **MUST NOT** inherit Manager or Owner communication capability. Each capability is granted explicitly or not at all. |
| **`NTF-BR-002`** | No role in this matrix may address an audience outside its own tenant. |
| **`NTF-BR-003`** | Authorization **MUST** be evaluated at action time by `BC-18`; a stale grant **MUST NOT** authorize a dispatch. |

---

## 12. Student / Parent communication

| ID | Requirement |
|---|---|
| **`NTF-FR-018`** | Students and Parents are **recipients** in V1. They **MUST NOT** initiate tenant communication. `[PROPOSED]` |
| **`NTF-FR-019`** | A Parent **MUST** receive only notices concerning students within `guardianOf`. `[EVIDENCE]` `MP-GBR-21`, `MASTER_PRD` L111 |
| **`NTF-FR-020`** | Where a notice concerns a student, the guardian copy **MUST** be a separate delivery record with its own consent and quiet-hours evaluation. |
| **`NTF-FR-021`** | ⚠ Student→Staff inbound queries are **`NTF-GAP-010`** — ⛔ no two-way surface is created here |

---

## 13. ⭐⭐ Student↔Student messaging — ownership preserved, integration only

⛔⛔ **`PRD-010` owns none of it.** Evidence at §2.1.

| ID | Requirement |
|---|---|
| **`NTF-XC-001`** | `BC-22` **MUST NOT** create, store, read or moderate a `Conversation` or `Message`. Those are `BC-12` aggregates (BC Map **L378**). |
| **`NTF-XC-002`** | `BC-22` **MUST NOT** evaluate `canMessage`; that is `BC-11` over `E-16` (**L320**). |
| **`NTF-XC-003`** | `BC-22` **MUST NOT** implement block, report or enforcement; `BC-11`/`BC-13` own them (**L318**). |
| **`NTF-FR-022`** | ⚠ An **unread-message notification** is a legitimate `BC-22` capability **only if** `BC-12` emits a fact `BC-22` may consume. Measured: **L431** routes `messaging.MessageSent` to **`BC-13` and `BC-26` only** — ⛔ **not `BC-22`** ⇒ **`NTF-GAP-011`**, ⛔ **no edge invented** |

⭐⭐ **This is a real, load-bearing gap.** A notification for a new chat message *looks* obviously in
scope, but the only event that would carry it is **not routed to `BC-22`**. Adding that route needs
an Architecture Owner act (a new consumer on `messaging.MessageSent`, or a new event). ⛔ **Not done
here** — BC Map **L292**: *"if an edge is not in this table, it does not exist."*

---

## 14. ⭐ External WhatsApp redirect — deliberately minimal

`[EVIDENCE]` EA **L1502**/**L1821** tier WhatsApp Business Integration at **V3**; `MP-SCOPE-09` tiers
WhatsApp as a channel at **V2**.

⇒ ⭐⭐ **A redirect is only lawful in V1 because it is NOT a channel.** Liboora sends nothing; a human
sends the message inside WhatsApp.

| ID | Requirement |
|---|---|
| **`NTF-FR-023`** | The redirect **MUST** be modelled as a **UI action over already-visible contact data**, ⛔ **not** as a `BC-22` delivery channel. It creates **no** `DeliveryMessage`. |
| **`NTF-FR-024`** | It **MUST** be offered only where the actor is **independently authorized** to view that contact datum. Visibility of the button **MUST** follow the same authorization as the number itself. |
| **`NTF-FR-025`** | ⛔ **No** WhatsApp Business/Cloud API, provider, webhook, credential, token, template, billing, delivery status, inbound processing or message history. `[EVIDENCE]` EA V3 |
| **`NTF-FR-026`** | ⛔ **No** WhatsApp message content may be stored in Liboora, and WhatsApp messages **MUST NOT** appear in communication history. |
| **`NTF-FR-027`** | The action **MUST NOT** place a mobile number into any event. `[EVIDENCE]` `MP-GBR-34` |
| **`NTF-FR-028`** | ⚠ Whether *use* of the redirect is itself an auditable event is **`NTF-GAP-012`** — it is a **read** of contact data plus an outbound hand-off; `BC-24`'s policy governs, and this PRD **MUST NOT** create a parallel audit. |
| **`NTF-FR-029`** | ⚠ **Ownership caveat.** Because the redirect is a UI affordance over contact data and **not** a delivery channel, it may belong to the surface that owns the student profile (`BC-01`) rather than `BC-22` ⇒ **`NTF-GAP-013`** |

⭐ **`NTF-FR-029` is an honest self-challenge**: the brief asked me to identify if this feature belongs
elsewhere. On the evidence, it plausibly does.

---

## 15. Channel model (V1)

| Channel | V1 status | Kind | Evidence |
|---|---|---|---|
| **In-App** | ✅ **V1** | Integrated | `MASTER_PRD` §22 L451 |
| **Push (FCM)** | ✅ **V1** | Integrated | §22 L450; **L229** *"`BC-22` via `BC-31` Integration — Firebase Cloud Messaging — Yes (V1)"* |
| SMS (general) | ⛔ **V2** | — | `MP-SCOPE-09` |
| Email | ⛔ **V2** | — | `MP-SCOPE-09` |
| WhatsApp (channel) | ⛔ **V2/V3** | — | `MP-SCOPE-09`; EA L1821 |
| WhatsApp (redirect) | ✅ V1 | ⭐ **External redirect — not a channel** | §14 |

| ID | Requirement |
|---|---|
| **`NTF-FR-030`** | V1 integrated channels are **exactly** In-App and Push. Adding Email or general SMS **MUST NOT** occur without an ADR amending `MP-SCOPE-09`. |
| **`NTF-FR-031`** | Push **MUST** reach FCM through **`BC-31`**; `BC-22` **MUST NOT** hold FCM credentials. `[EVIDENCE]` `MASTER_PRD` L229, BC Map L140 |
| **`NTF-FR-032`** | A channel adapter **MUST** be a port; `BC-22` **MUST NOT** name a vendor in its domain model. `[EVIDENCE]` `E-25` precedent — *"Billing knows no vendor names"* |

---

## 16. Templates, content and localization

| ID | Requirement |
|---|---|
| **`NTF-FR-033`** | A template **MUST** declare its channel, its placeholder set and its version. |
| **`NTF-FR-034`** | Placeholders **MUST** come from a closed approved list per trigger; an unknown placeholder **MUST** fail validation. |
| **`NTF-FR-035`** | A placeholder **MUST NOT** resolve to a mobile number, a credential, or a financial figure not already visible to that recipient. |
| **`NTF-FR-036`** | Template version **MUST** be recorded on every delivery record for audit. |
| **`NTF-FR-037`** | ⚠ Language/localization set is **`NTF-GAP-014`**. ⚠ Note `PRD-015` `SRCHPO-17` bound **Latin + Devanagari** for search text — ⭐ **that is search-scoped authority and MUST NOT be borrowed here.** |

---

## 17. Preferences, consent and quiet hours

`[EVIDENCE]` `MP-GBR-35` — quiet hours, dedup and consent/unsubscribe are `BC-22`'s and apply to
**every** channel.

| ID | Requirement |
|---|---|
| **`NTF-FR-038`** | Each catalogue entry **MUST** be classified **mandatory** or **optional**. Optional entries honour opt-out; mandatory entries **MUST NOT** be opt-outable. |
| **`NTF-FR-039`** | Quiet hours **MUST** defer, never drop, a deferrable notification. |
| **`NTF-FR-040`** | ⚠ Which entries are mandatory is **`NTF-GAP-015`** — a Product Owner call. ⛔ **No classification asserted.** |
| **`NTF-FR-041`** | Preference storage **MUST** use the `BC-25` settings hierarchy rather than a private store. `[EVIDENCE]` BC Map L134; ⚠ contested ownership — `NTF-GAP-016` |

---

## 18. Delivery lifecycle

`[PROPOSED]` states: `created → queued → processing → sent → delivered | failed | expired |
cancelled`; `read` applies to In-App only; `partially_failed` is an **operation** state, never a
per-recipient state.

| ID | Requirement |
|---|---|
| **`NTF-FR-042`** | State transitions **MUST** be monotonic; a delivered record **MUST NOT** return to queued. |
| **`NTF-FR-043`** | `delivered` **MUST** mean provider-acknowledged, **not** user-seen. `read` is In-App only. |
| **`NTF-FR-044`** | ⚠ Push `delivered` semantics depend on FCM's acknowledgement model ⇒ **`NTF-GAP-017`**; ⛔ no guarantee asserted. |

---

## 19. Retry, idempotency and deduplication

| ID | Requirement |
|---|---|
| **`NTF-INV-007`** | ⭐⭐ **Retry MUST NOT produce a second user-visible notification.** The idempotency key is `(eventId, recipientId, channel, templateId)`. |
| **`NTF-FR-045`** | A redelivered or replayed event with an already-seen `eventId` **MUST** be suppressed and counted, not delivered. |
| **`NTF-FR-046`** | Concurrent workers **MUST NOT** both deliver; the idempotency record **MUST** be claimed atomically before dispatch. |
| **`NTF-FR-047`** | Only **transient** failures retry; permanent failures terminate as `failed`. |
| **`NTF-FR-048`** | Restart **MUST NOT** re-deliver work already in `sent`. |
| **`NTF-FR-049`** | ⚠ Retry counts, backoff and dedup window are **`NTF-GAP-018`** — ⛔ **no numbers invented.** |
| ⭐⭐ **`NTF-INV-011`** | **The emitting-operation failure boundary.** Where a notification cannot be delivered because its notification address cannot be resolved, that failure **MUST** fail **only that notification delivery**, and **MUST NOT** fail, roll back, abort, retry or otherwise render unsuccessful the originating business operation that emitted the business fact. `[EVIDENCE]` `tool/module_dependencies.yaml` **`CM-3`** — *"an unresolvable address fails the delivery only; it never fails the emitting operation"* — and **`EBR-1030`** |

⭐ **`NTF-INV-007` is the single highest-value invariant here**: `MembershipExpiringSoon` is
inherently repeatable, and a naive scheduler would notify daily.

### 19.1 ⭐⭐ `NTF-INV-011` — why the boundary belongs here, and what it protects

⭐ **`NTF-INV-011` protects OTHER bounded contexts, not `BC-22`.** A membership renewal, a fee
posting or a check-in emits a fact over `E-23` and is then **complete**; whether a notice about it
reaches anyone is `BC-22`'s problem alone. ⛔ **Without this invariant a failed address lookup could
propagate backwards and roll back a paid renewal** — the precise harm `CM-3` exists to prevent.

| Distinction | Requirement |
|---|---|
| A **template field** is missing from the event payload | **`NTF-FR-003`** — fail the notification, record it, ⛔ never query a domain context |
| ⭐ The **notification address** cannot be resolved | ⭐⭐ **`NTF-INV-011`** — fail that delivery only, ⛔ never the emitting operation |

⚠ **These are different triggers and were verified not to duplicate each other**: `NTF-FR-003`
governs payload sufficiency and states no boundary protecting the emitter; `NTF-INV-011` states the
boundary and says nothing about payloads.

---

## 20. ⭐ Configuration — the lawful substitute for "Platform Admin"

Since §2.3 shows no platform role exists, the platform-level **configuration** surface is specified
through `BC-25`, which is real.

| ID | Requirement |
|---|---|
| **`NTF-FR-050`** | Notification configuration (enable/disable, timing, template selection, channel set per trigger) **MUST** live in the **`BC-25`** settings hierarchy. `[EVIDENCE]` BC Map L134 |
| **`NTF-FR-051`** | ⭐⭐ **Configuration MUST NOT be able to invent a business fact.** No configuration path may cause `BC-22` to emit or synthesize a domain event. Configuration selects **behaviour for facts that already occurred**. `[EVIDENCE]` `MP-GBR-33`, `E-23` |
| **`NTF-FR-052`** | Configuration **MUST NOT** widen an audience beyond `MP-GBR-21`'s three scopes. |
| **`NTF-FR-053`** | Configuration changes **MUST** be audited via `BC-24`. |
| **`NTF-FR-054`** | ⚠ Which configuration keys are platform-level vs tenant-level is **`NTF-GAP-019`** — `BC-25` ownership is recorded **contested** (`PRD_REGISTRY.md` L148). |

⭐ **`NTF-FR-051` is exactly the boundary the brief demanded** — *"Platform Admin must NOT redefine
business facts"* — expressed against a mechanism that actually exists.

---

## 21. Platform vs tenant boundary

| ID | Requirement |
|---|---|
| **`NTF-INV-008`** | No recipient set, preview, count, history record or delivery record may span two tenants. |
| **`NTF-INV-009`** | A tenant actor **MUST NOT** obtain platform-wide authority through any notification surface. |
| **`NTF-FR-055`** | Platform-wide announcements are ⛔ **NOT V1** — `NTF-GAP-002`. |

---

## 22. Security and privacy

| ID | Requirement |
|---|---|
| **`NTF-INV-010`** | Cross-tenant recipient access **MUST** be impossible by construction, not by filtering. |
| **`NTF-FR-056`** | Recipient enumeration via preview, counts, error messages or timing **MUST** be prevented; denials mimic not-found. `[EVIDENCE]` `MP-GBR-22` |
| **`NTF-FR-057`** | A notification **MUST NOT** disclose membership, attendance or financial detail to a recipient not authorized for that datum — including guardians beyond `guardianOf`. |
| **`NTF-FR-058`** | Phone/email **MUST NOT** appear in notification bodies, events or logs. `[EVIDENCE]` `MP-GBR-34` |
| **`NTF-FR-059`** | Privilege escalation via template, placeholder or audience configuration **MUST** be prevented; each is authorization-checked independently. |

---

## 23. Audit, history, observability

| ID | Requirement |
|---|---|
| **`NTF-FR-060`** | Audit facts **MUST** be emitted to **`BC-24`**: initiator, role, tenant, audience definition, recipient count, category, channel, template+version, timestamp, authorization result, delivery outcome. ⛔ **No parallel audit store.** `[EVIDENCE]` BC Map L133 |
| **`NTF-FR-061`** | Automation enable/disable and configuration changes **MUST** be audited. |
| **`NTF-FR-062`** | Communication history **MUST** show tenant-scoped sent operations, per-recipient delivery status and read state (In-App). |
| **`NTF-FR-063`** | ⛔ WhatsApp-redirect messages **MUST NOT** appear in communication history. `[EVIDENCE]` §14 |
| **`NTF-FR-064`** | Observability **MUST** expose volume, success/failure, retry counts, queue depth, dedup-suppression count, bulk operation status. |
| **`NTF-FR-065`** | ⚠ SLO/SLI targets are **`NTF-GAP-020`** — an **SRE/Observability** act. ⚠ Note `ADR-0102` conferred that office **for `PRD-015` only** and `ADR-0033` §7.1 forbids reuse ⇒ ⛔ **not borrowed.** |

---

## 24. Dependencies

| Dependency | Status | Note |
|---|---|---|
| `BC-18` Authorization / `PRD-001` | ✅ **FROZEN** | Permission evaluation; `AUTH-10.3` |
| `BC-19` Tenancy / `PRD-013` | ✅ **FROZEN** | Tenant boundary |
| `BC-24` Audit / `PRD-016` | ✅ **FROZEN** | Audit sink |
| `BC-25` Configuration / `PRD-023` | ✅ **FROZEN** | Settings hierarchy; ⚠ contested ownership |
| `BC-11`/`BC-12` / `PRD-021B` | ✅ **FROZEN** | Messaging — ⛔ do not duplicate |
| `BC-13` / `PRD-020` | ✅ **FROZEN** | Abuse/enforcement |
| `BC-01` Enrollment / `PRD-004` | ✅ FROZEN | Source events |
| `BC-02`/`BC-03`/`BC-04`/`BC-05` | ✅ FROZEN | Source events |
| `BC-20` Billing / `PRD-022` | ⚠ `DRAFT` | Source events |
| ⚠ **`BC-31` Integration / `PRD-019`** | ⚠ **v0.4 `DRAFT`** — **111 `ITG-*` identifiers issued** (54 obligation-bearing + 54 `ITG-AC-*` + 3 `ITG-GAP-*`); ⛔ not architecture-reviewed, not frozen | ⭐⭐ **Push delivery depends on it** ⇒ **`NTF-GAP-021`**. ⚠ *Corrected at v0.2 — the v0.1 reading "`DRAFT`, 0 identifiers issued" was **stale**; see §32 v0.2* |
| `BC-26` Analytics | ⚠ unwritten | Not required for V1 |

⭐⭐ **`NTF-GAP-021` is a hard scheduling fact**: `MASTER_PRD` **L229** routes Push through `BC-31`,
and `PRD-019` is **v0.4 `DRAFT`** — ⭐ carrying **111 `ITG-*` identifiers**, so the dependency is
**real, declared and substantiated**, ⛔ but **not frozen** and ⛔ **not architecture-reviewed**
(`PRD-019` §1: *"NOT approved. NOT architecture-reviewed. NOT frozen"*). ⇒ ⭐ **V1 Push egress is
specifiable in form** — `NTF-FR-031` traverses `BC-31` per `MASTER_PRD` **L229**, and the
`platform/integration:connector` port is **declared** in the manifest — ⛔ **but it cannot be relied
on for delivery guarantees until `PRD-019` is conferred.** Reported rather than assumed away.

⚠ **A pre-existing registry inconsistency is disclosed, not repaired:** `PRD_REGISTRY.md` **L319**
records `PRD-019` at **v0.1** while **L545** records **v0.4**. The subject document's own header
(**v0.4**) is treated as controlling, per the registry's §8 rule 5 — *"If this register disagrees
with a PRD, fix this register"* — ⛔ **which is a Governance Owner act and is NOT performed here.**

---

## 25. Integration contracts

| ID | Requirement |
|---|---|
| **`NTF-XC-004`** | `BC-22` consumes over **`E-23`** (`PL`, Event) only. ⛔ No new edge is created by this PRD. `[EVIDENCE]` BC Map L332, L292 |
| **`NTF-XC-005`** | `BC-22` **MUST NOT** call a domain context synchronously to enrich a notification. |
| **`NTF-XC-006`** | Push egress **MUST** traverse `BC-31`; ⛔ no direct vendor call. |

---

## 26. Risks

| # | Risk | Severity | Disposition |
|---|---|---|---|
| R1 | Duplicate reminders from repeatable expiry events | ⭐⭐ High | `NTF-INV-007` |
| R2 | Accidental Send-to-All | ⭐⭐ High | `NTF-FR-011`, `-012`; ⚠ limit is `NTF-GAP-007` |
| R3 | Cross-tenant leak via audience config | ⭐⭐⭐ Critical | `NTF-INV-008`, `-010`, `NTF-FR-052` |
| R4 | Guardian over-notification beyond `guardianOf` | ⭐⭐ High | `NTF-FR-019`, `-057` |
| R5 | Mobile number entering an event | ⭐⭐ High | `NTF-INV-003` |
| R6 | Scope creep into `BC-12` messaging | ⭐⭐ High | `NTF-XC-001`…`-003` |
| R7 | WhatsApp scope creep to Business API | ⭐⭐ High | `NTF-FR-025`; EA V3 |
| R8 | Reception Staff privilege escalation | ⭐ Medium | `NTF-BR-001` |
| R9 | Push unspecifiable while `PRD-019` is DRAFT | ⭐⭐ High | `NTF-GAP-021` |
| R10 | Inventing a Platform Admin scope | ⭐⭐⭐ Critical | ⛔ **Refused** — §2.3, `NTF-GAP-002` |

---

## 27. Edge cases

Recipient loses eligibility between preview and send (`NTF-FR-007`) · guardian relationship revoked
mid-dispatch · student in two tenants (`NTF-INV-008`) · quiet hours spanning midnight · event replay
after restart (`NTF-FR-048`) · template deleted while queued (version pinned, `NTF-FR-036`) ·
tenant suspended mid-dispatch ⇒ ⚠ **`NTF-GAP-022`** · duplicate event with same `eventId` but
different payload ⇒ ⚠ **`NTF-GAP-023`** · zero eligible recipients (operation succeeds with count 0).

---

## 28. ⛔ OPEN DECISIONS / GAPS — 23 registered, each with an owner

| ID | Gap | Owner | Blocks |
|---|---|---|---|
| `NTF-GAP-001` | `NTF-` prefix registration | **Governance Owner** | Stage 5 |
| ⭐ `NTF-GAP-002` | Platform-wide audience needs a 4th scope — `MP-GBR-21` requires an **ADR** | **Architecture + Product Owner** | Any platform broadcast |
| `NTF-GAP-003` | Reminder timing for `ExpiringSoon` / `FeeDueRaised` | **Product Owner** | Timing config |
| `NTF-GAP-004` | Moderator audience definition for `AbuseReportFiled` | **Product Owner** + `BC-13` owner | That entry |
| ⭐ `NTF-GAP-005` | 6 requested notifications have **no source event** (grace period, fee payment failed, outstanding balance, absence, staff lifecycle) | **Architecture + Product Owner** | Those entries |
| ⭐ `NTF-GAP-006` | ⚠ BC Map **L437** routes `iam.*` to `BC-24`/`BC-26` only, but Auth §10 lists *"notification"* as a consumer — **contradiction** | **Architecture Owner** | Security notices |
| `NTF-GAP-007` | Bulk recipient ceiling and rate limits | **Product Owner** | `NTF-FR-017` |
| `NTF-GAP-008` | The permission matrix requires `BC-18` authority | **Authorization owner** | §11 |
| `NTF-GAP-009` | Whether scheduling is V1 | **Product Owner** | Scheduling |
| `NTF-GAP-010` | Student→Staff inbound queries | **Product Owner** | Two-way surface |
| ⭐ `NTF-GAP-011` | `messaging.MessageSent` is **not routed to `BC-22`** — unread-message notification has no lawful trigger | **Architecture Owner** | Chat notifications |
| `NTF-GAP-012` | Is WhatsApp-redirect use auditable? | `BC-24` owner | `NTF-FR-028` |
| ⭐ `NTF-GAP-013` | Does the redirect belong to `BC-01`, not `BC-22`? | **Architecture Owner** | §14 ownership |
| `NTF-GAP-014` | Language/localization set | **Product Owner** | Templates |
| `NTF-GAP-015` | Mandatory vs optional classification | **Product Owner** | Opt-out |
| `NTF-GAP-016` | `BC-25` ownership is **contested** | **Architecture Owner** | `NTF-FR-041` |
| `NTF-GAP-017` | Push `delivered` semantics | **Architecture Owner** | Lifecycle |
| `NTF-GAP-018` | Retry/backoff/dedup-window values | **Architecture Owner** | Retry |
| `NTF-GAP-019` | Platform vs tenant configuration keys | **Architecture Owner** | §20 |
| `NTF-GAP-020` | Notification SLO/SLI | **SRE/Observability** | Observability |
| ⭐ `NTF-GAP-021` | Push depends on `PRD-019` — **v0.4 `DRAFT`, 111 `ITG-*` identifiers**, ⛔ not architecture-reviewed, not frozen | **Product + Architecture Owner** | V1 Push delivery guarantees |
| `NTF-GAP-022` | Tenant suspended mid-dispatch | **Architecture Owner** | Edge case |
| `NTF-GAP-023` | Same `eventId`, different payload | **Architecture Owner** | Dedup |

---

## 29. Acceptance criteria (sample — the register is not complete at v0.1)

| ID | Criterion |
|---|---|
| `NTF-AC-001` | Given a `MembershipExpiringSoon` event delivered twice with the same `eventId`, when processed, then exactly **one** user-visible notification exists and the suppression counter increments by 1. |
| `NTF-AC-002` | Given a dispatch preview showing N recipients, when one loses eligibility before confirmation, then that recipient receives nothing and the operation reports N−1 sent. |
| `NTF-AC-003` | Given an actor in tenant A, when any audience is resolved, then no recipient from tenant B appears — verified by a cross-tenant fixture. |
| `NTF-AC-004` | Given any emitted `BC-22` event or payload, when inspected, then it contains no mobile number. |
| `NTF-AC-005` | Given a Reception Staff account with no explicit grant, when Send-to-All is attempted, then it is denied and the denial is audited. |
| `NTF-AC-006` | Given the WhatsApp redirect is used, when communication history is queried, then no WhatsApp message record exists. |
| `NTF-AC-007` | Given a guardian outside `guardianOf` for a student, when a notice for that student is produced, then the guardian receives nothing and the denial is indistinguishable from not-found. |
| `NTF-AC-008` | Given a transient channel failure, when retried to success, then exactly one user-visible notification exists. |
| ⭐⭐ `NTF-AC-009` | Given a business operation that emits a fact over `E-23`, when the notification address for a recipient **cannot be resolved**, then that delivery record terminates as `failed`, **and** the originating business operation remains successful and un-rolled-back — verified by asserting the emitting aggregate's post-state is unchanged from the success path. `[EVIDENCE]` `NTF-INV-011`, `CM-3`, `EBR-1030` |

---

## 30. ⭐⭐ Adversarial self-review — what I tried to break, and what broke

| # | Attack | Outcome |
|---|---|---|
| 1 | *Own chat notifications, since they're "notifications"* | ⛔ **Broke.** `BC-12` owns messages; and `messaging.MessageSent` isn't even routed to `BC-22` ⇒ §13, `NTF-GAP-011` |
| 2 | *Ship Email — every notification system has it* | ⛔ **Broke.** `MP-SCOPE-09` = **V2**, Rank 1 ⇒ N4 |
| 3 | *Add a light WhatsApp send* | ⛔ **Broke.** EA **L1821** = **V3** ⇒ N6 |
| 4 | *Create Platform Admin as the brief suggests* | ⛔⛔ **Broke hardest.** 0 occurrences; `MP-GBR-21` closes the scope register ⇒ §2.3, `NTF-GAP-002` |
| 5 | *Let config define new triggers* | ⛔ **Broke.** `MP-GBR-33`/`E-23` ⇒ `NTF-FR-051` |
| 6 | *Write the reminder as "7 days before"* | ⛔ **Broke.** No authority ⇒ `NTF-GAP-003` |
| 7 | *Catalogue grace-period notices* | ⛔ **Broke.** `MembershipFrozen` doesn't route to `BC-22` ⇒ `NTF-GAP-005` |
| 8 | *Catalogue account-security notices* | ⚠ **Contradiction found** between BC Map L437 and Auth §10 ⇒ `NTF-GAP-006`, ⛔ not resolved in my own favour |
| 9 | *Set a 500-recipient bulk cap* | ⛔ **Broke.** Arbitrary ⇒ `NTF-GAP-007` |
| 10 | *Reuse `PRD-015`'s Latin+Devanagari binding for templates* | ⛔ **Broke.** `SRCHPO-17` is search-scoped ⇒ `NTF-GAP-014` |
| 11 | *Reuse `ADR-0102`'s SRE office for notification SLOs* | ⛔ **Broke.** One-act conferral, `ADR-0033` §7.1 ⇒ `NTF-GAP-020` |
| 12 | *Assume Push is specifiable* | ⚠ **Partly broke.** `BC-31`/`PRD-019` is **v0.4 DRAFT** — ⭐ 111 identifiers and a declared `connector` port, so the **form** is specifiable, ⛔ but delivery **guarantees** are not until it is conferred ⇒ `NTF-GAP-021` *(refined at v0.2)* |
| 13 | *Call the role "Staff"* | ⚠ **Corrected** to **Reception Staff** (`Library_PRD_v1` L596) |
| 14 | *Own the audit trail of communications* | ⛔ **Broke.** `BC-24` ⇒ `NTF-INV-006` |
| 15 | *Own notification preferences storage* | ⚠ **Narrowed** to `BC-25` ⇒ `NTF-FR-041`, `NTF-GAP-016` |
| 16 | *Claim the WhatsApp redirect is definitely `BC-22`'s* | ⚠ **Self-challenged** ⇒ `NTF-GAP-013` |

⭐ **Corrected in-draft:** role naming (13), preference ownership (15), audit ownership (14), channel
list (2, 3), catalogue pruning (7), and the removal of Platform Admin (4).
⛔ **Left as gaps because resolution needs authority I do not have:** 1, 4, 6, 8, 9, 10, 11, 12, 16.

---

## 31. Traceability and identifier strategy

`[PROPOSED]` Prefix **`NTF-`**, collision-checked: `NTF-` occurs **8** times, **all** in
`docs/90-archive/`, which `DOCUMENTATION_BASELINE.md` **§3.5** declares *"retained for history and
**must not be cited as authority**."* `NOTIF-` = **0**, `COM-` = **0**. ⚠ Registration remains a
**Governance Owner** act — `NTF-GAP-001`.

Registers: `NTF-FR-*` (65 drafted) · `NTF-BR-*` (3) · `NTF-INV-*` (10) · `NTF-XC-*` (6) ·
`NTF-AC-*` (8 sample) · `NTF-GAP-*` (23). ⚠ **Counts are provisional; the AC register is
deliberately incomplete at v0.1** and Stage 4 will require 1:1 obligation coverage.

---

## 32. Changelog

| Version | Date | Change |
|---|---|---|
| **v0.2** | 2026-09-05 | ⭐⭐ **REQUIRED CORRECTION applied — the two additive amendments accepted at `NTF-AL-B2` in [`PRD-010_ARCHITECTURE_ALIGNMENT.md`](PRD-010_ARCHITECTURE_ALIGNMENT.md) §8.3, and nothing else.** ⭐⭐⭐ **`C-1` — the emitting-operation failure boundary is now stated: new invariant `NTF-INV-011`** requires that an unresolvable notification address fail **only that delivery** and ⛔ **never** fail, roll back, abort or retry the originating business operation, carrying `tool/module_dependencies.yaml` **`CM-3`** / **`EBR-1030`** verbatim; supported by new **§19.1**, which explains that the invariant **protects other bounded contexts, not `BC-22`** — without it a failed address lookup could roll back a paid membership renewal — and by new acceptance criterion **`NTF-AC-009`**, which asserts the emitting aggregate's post-state is unchanged. ⭐ **Verified NOT a duplicate before adding**: a repository-wide probe for an existing failure-boundary requirement (`fail the emitting`, `emitting operation`, `roll back`, `originating operation`, `never fail`) returned **0 hits**, and §19.1 records the distinction from `NTF-FR-003`, which governs **payload sufficiency** and states no emitter boundary. ⭐⭐ **`C-2` — the authoritative module contract is now cited in new §6.1**: `platform/communication`, **rank 5**, `imports: contracts` (rank 0), ports `platform/integration:connector` and **`platform/identity:notification_address`** under **AMENDMENT `A-3`** with its *"one address, one queued delivery… never retained by the caller"* constraint (**L462-464**), `consumes_events: ["*"]`, `banned_imports`, and a clause-by-clause table mapping **`CM-1`** → `NTF-INV-003`/`-FR-004`/`-FR-009`, **`CM-2`** → `NTF-FR-058`/`-FR-004`, **`CM-3`** → `NTF-INV-011`. ⭐ §6.1 also records that **`A-3` is the mechanism behind `MP-GBR-34`** — the address is resolved at delivery time, which is *why* no event need carry a number. ⚠ **`NTF-AL-F2` is DISCLOSED in §6.1 and expressly NOT relied upon or cured** — the pre-existing rank-5→rank-5 `platform/integration` port is an Architecture-Owner-owned manifest condition, and no requirement here depends on its lawfulness. ⚠ **The stale `PRD-019` fact is corrected in 4 places, re-measured from the document itself**: **v0.4 `DRAFT`** with **111 `ITG-*` identifiers** (54 obligation-bearing + 54 `ITG-AC-*` + 3 `ITG-GAP-*`), replacing v0.1's *"`DRAFT`, 0 identifiers"*; `NTF-GAP-021` is **refined, not closed** — Push egress is specifiable **in form** (declared `connector` port, `MASTER_PRD` **L229**) but ⛔ **its delivery guarantees are not, until `PRD-019` is conferred**. ⚠ **A pre-existing `PRD_REGISTRY.md` self-contradiction is disclosed, not repaired** (**L319** v0.1 vs **L545** v0.4) — resolving it is a **Governance Owner** act. ⛔ **NOTHING ELSE CHANGED: 0 requirements redesigned, 0 identifiers renumbered, 0 `NTF-GAP-*` closed (23 remain OPEN), Platform Admin authorization untouched, 0 business events invented, `messaging.MessageSent → BC-22` NOT invented, WhatsApp scope unchanged, `NTF-AL-F2` NOT fixed.** ⛔ **0 BC Map · 0 `MASTER_PRD` · 0 frozen PRDs · 0 baseline · 0 registry status · 0 dependency matrix · 0 `module_dependencies.yaml` · 0 ADRs created or modified · 0 `IMPL-*` · 0 lines of application code.** Status remains **`DRAFT`**; ⛔ no approval or freeze claimed; `PRD_REGISTRY.md` remains **`PLANNED`**. |
| **v0.1a** | 2026-09-05 | ⚠ **Self-audit of the author's own published counts and cross-references — three defects found and repaired, two false alarms cleared.** ⭐ **All six registers verified CONTIGUOUS and complete by measurement**, not by assertion: `NTF-FR-001`…`065` (65) · `NTF-BR-001`…`003` (3) · `NTF-INV-001`…`010` (10) · `NTF-XC-001`…`006` (6) · `NTF-AC-001`…`008` (8) · `NTF-GAP-001`…`023` (23) — **0 missing, 0 out-of-range, 0 duplicate definitions**, and all **23** gaps confirmed present in the §28 table. ⚠⚠ **THREE BROKEN CROSS-REFERENCES REPAIRED** — they cited the *drafting brief's* 56-section outline rather than this document's actual 32 sections: *"see §29"* → **§13** (Student↔Student messaging; §29 is Acceptance Criteria), and two citations of a non-existent *"§35.3"* → **§5 N7** and an explicit `AUTH-10.3` / `MASTER_PRD` §22 citation respectively. ⭐ **Two apparent duplicates were investigated and CLEARED as legitimate**: `NTF-FR-009` appears twice as one definition plus one prose citation, and `NTF-GAP-003` is deliberately cited by **two** catalogue rows (`MembershipExpiringSoon` and `FeeDueRaised`) because one unresolved timing decision governs both. ⭐ **Every remaining `§` reference was verified to be either internal and ≤32, or externally qualified** (`MASTER_PRD` §22, BC Map §8, `DOCUMENTATION_BASELINE` §3.5). ⛔ **No requirement text, register membership, gap, verdict, ownership finding or evidence citation was changed** — this entry corrects pointers and publishes measured counts only. ⛔ Status remains **`DRAFT`**; ⛔ 0 approvals, 0 conferrals, 0 baseline rows, 0 ADRs, 0 frozen documents touched, 0 `IMPL-*`, 0 code. |
| **v0.1** | 2026-09-05 | ⭐⭐ **Created at Stage 2 as a DRAFT.** Catalogue built **only** from BC Map §8 events already routed to `BC-22`. ⭐⭐⭐ **Three brief-contradicting findings recorded:** (1) Student↔Student messaging is owned by **`BC-12`** under **FROZEN** `PRD-021B` ⇒ integration-only, and `messaging.MessageSent` is **not routed to `BC-22`** (`NTF-GAP-011`); (2) **SMS/Email/WhatsApp are V2** by Rank-1 `MP-SCOPE-09`, WhatsApp Business **V3** by EA L1502/L1821 ⇒ V1 integrated channels are **exactly In-App + Push**; (3) ⭐ **"Platform Admin" has 0 occurrences** in the BC Map, ownership model and Auth PRD, and `MP-GBR-21` **closes** the scope register to `self`/`guardianOf`/`tenantWide` ⇒ ⛔ **no Platform Admin role created**, platform broadcast blocked at `NTF-GAP-002`, and platform-level *configuration* routed through the real `BC-25` instead. ⛔ **Six requested notifications have no source event** and are registered at `NTF-GAP-005` rather than invented. ⚠ **A contradiction between BC Map L437 and Auth PRD §10 is disclosed** (`NTF-GAP-006`) and ⛔ not resolved in the author's favour. ⛔ **0 timings, 0 bulk limits, 0 retry values, 0 SLOs invented.** ⛔ Authority **not borrowed** from `PRD-015`'s `SRCHPO-17` or `ADR-0102`. **23 gaps registered, each with a named owner.** ⛔ **No approval, no conferral, no freeze, no baseline row, no admitting ADR, no frozen document touched, no historical record modified, no `IMPL-*`, no application code.** Status **`DRAFT`**; `PRD_REGISTRY.md` still shows `PLANNED` and ⛔ **was not modified.** |
