# `PRD-010` — Notifications & Communication (`BC-22` Notification Delivery)

| Field | Value |
|---|---|
| **Document** | `docs/30-product/notifications/PRD-010_NOTIFICATIONS_AND_COMMUNICATION.md` |
| **Version** | **v0.13** |
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
| **`NTF-FR-021`** | ⛔ **NON-SCOPE (V1) — placement RESOLVED at v0.12.** A Student→Staff **inbound** query surface is already prohibited by ratified **`NTF-FR-018`** (*"Students and Parents are **recipients** in V1. They **MUST NOT** initiate tenant communication"*). ⇒ placement is **§5 non-scope**, `[DERIVED]` (`ADR-0109` §6). ⚠ Whether V2 adds a two-way surface stays `NTF-GAP-010` **`[OWED — Product Owner]`**. |

---

## 13. ⭐⭐ Student↔Student messaging — ownership preserved, integration only

⛔⛔ **`PRD-010` owns none of it.** Evidence at §2.1.

| ID | Requirement |
|---|---|
| **`NTF-XC-001`** | `BC-22` **MUST NOT** create, store, read or moderate a `Conversation` or `Message`. Those are `BC-12` aggregates (BC Map **L378**). |
| **`NTF-XC-002`** | `BC-22` **MUST NOT** evaluate `canMessage`; that is `BC-11` over `E-16` (**L320**). |
| **`NTF-XC-003`** | `BC-22` **MUST NOT** implement block, report or enforcement; `BC-11`/`BC-13` own them (**L318**). |
| **`NTF-FR-022`** | ⛔ **EXCLUDED at v0.11 — `NTF-GAP-011` CLOSED.** An unread-message notification is **NOT** a `BC-22` V1 capability: BC Map **L431** routes `messaging.MessageSent` to **`BC-13`** and **`BC-26`** only — ⛔ **not** to `BC-22` — and §7's rule is that an edge absent from the table *"does not exist"*. Architecture Owner ratification of the evidence, `ADR-0108` §6. ⚠ V2 is not foreclosed; ⛔ §5 non-scope **placement** remains `[OWED — Product Owner]`. |

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
| **`NTF-FR-028`** | ⛔ **RESOLVED at v0.12 — the redirect is NOT an auditable `BC-22` action** (`NTF-XC-007`). ⭐ **`NTF-GAP-012` CLOSED `[DERIVED]`**: FROZEN **`AUD-FR-003`** (`PRD-016` **L123-125**) provides that `BC-24` *"**SHALL NOT** decide **what** is auditable in another bounded context — **each emitting context defines its own auditable-action list**"*, and **`AUD-XC-011`** (**L277**) repeats it. ⇒ the gap had been routed to a role FROZEN text bars from answering. `BC-22`'s auditable actions are its **deliveries**, and `NTF-FR-023` makes the redirect create **no** `DeliveryMessage`. (`ADR-0109` §2) |
| **`NTF-FR-029`** | ⛔ **RESOLVED at v0.12 — `BC-22` DOES NOT OWN the WhatsApp redirect.** ⭐ **`NTF-GAP-013` CLOSED `[DERIVED]`**: `NTF-FR-023` makes it *"a **UI action over already-visible contact data**"* creating **no** `DeliveryMessage`, and **`ADR-0107`** §3.1 fixes `BC-22`'s aggregates as **`FeedItem` · `DeliveryMessage`** — an artefact that is neither cannot be `BC-22` state. The affordance belongs to the **profile surface (`BC-01`)**. ⛔ **This PRD writes nothing into `BC-01`.** (`ADR-0109` §3) |

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
| ⭐⭐ **`NTF-FR-044`** | **`delivered` for Push means `BC-22` durably recorded a successful `BC-31` acknowledgement — and NOTHING MORE.** A Push delivery **MUST** be marked `delivered` **when, and only when**, `BC-22` has durably recorded a successful `BC-31` egress acknowledgement for that `DeliveryMessage`; a `BC-31` failure or absent acknowledgement **MUST NOT** be recorded as `delivered`. ⛔ **This state MUST NOT be presented, documented or relied upon as evidence that the notification reached a device, was displayed, or was seen by a person.** ⭐ **Testable without asserting any provider fact** — it asserts only **this system's own record**, the `ITG-FR-019` shape (*"**MUST** return `2xx` when, **and only when**, it has durably accepted the event"*). ⚠ Whether FCM's acknowledgement additionally implies device receipt is **`NTF-GAP-017`** **`[OWED — EXTERNAL EVIDENCE]`**, and ⛔ **no such implication is claimed here**. |

---

## 19. Retry, idempotency and deduplication

| ID | Requirement |
|---|---|
| **`NTF-INV-007`** | ⭐⭐ **Retry MUST NOT produce a second user-visible notification.** The idempotency key is `(eventId, recipientId, channel, templateId)`. |
| **`NTF-FR-045`** | A redelivered or replayed event with an already-seen `eventId` **MUST** be suppressed and counted, not delivered. |
| **`NTF-FR-046`** | Concurrent workers **MUST NOT** both deliver; the idempotency record **MUST** be claimed atomically before dispatch. |
| **`NTF-FR-047`** | Only **transient** failures retry; permanent failures terminate as `failed`. |
| **`NTF-FR-048`** | Restart **MUST NOT** re-deliver work already in `sent`. |
| **`NTF-FR-049`** | ⚠ **NARROWED at v0.11.** Retry **count** is RATIFIED (`NTF-CFG-004` = 3, range 1–5; `ADR-0108` §3). **Backoff** is **NOT configurable in V1** and deferred to V2 (`ADR-0108` §4.1). The **dedup window** is no longer a configurable — see `NTF-FR-066`. ⛔ Remaining owed limb: the **transport deadline** `NTF-CFG-007` (`NTF-GAP-026`). ⛔ **No numbers invented.** |
| ⭐⭐ **`NTF-FR-066`** | **Deduplication-record retention is FIXED and NOT configurable.** A deduplication record for key `(eventId, recipientId, channel, templateId)` **MUST** exist for as long as the `FeedItem` it protects exists, and **MUST NOT** exist thereafter. **No operator or administrator setting exposes this retention**, and **no `NTF-CFG-*` identifier carries it.** `[EVIDENCE]` `ADR-0108` §4.2; `BCM-22-INV-1` (BC Map **§18.4**); precedents `SEAT-FR-202` (*"fixed, not configurable"*) and `ITG-FR-017` (*"not configurable"*). ⚠ **The numerical `FeedItem` lifetime bounds are NOT stated here and are NOT invented** — they are the unresolved bounded decision **`NTF-OBD-001`** (`NTF-GAP-028`, Architecture Owner). |
| ⭐⭐ **`NTF-FR-067`** | **Every `JobRuntime` submission MUST carry a deadline, and that deadline MUST exceed the retry budget's worst-case run.** `BC-22` **MUST** pass `deadline` on every submission (`job_runtime.dart` **L113-114**, `required Duration deadline`) and it **MUST** satisfy `deadline > NTF-CFG-004 x (BC-31 per-attempt bound)`. **Runtime contract, NOT an operator setting** — the provider-facing bound is `BC-31`'s (BC Map **L140**; `NTF-XC-006`). ⚠ The `BC-31` per-attempt number is **`[OWED — EXTERNAL EVIDENCE]`** (`NTF-GAP-017`), so the inequality is **stated and testable but not yet satisfiable**. ⛔ Asserts **no** latency guarantee (`NTF-RTD-001`). |
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

### 20.1 Configurables this module publishes — slots declared, values **not** invented

Declared on the **`PRD-017` §8.5 precedent** (**L1208-1240**), which is the repository's only published
`*-CFG-*` slot register and which establishes three rules this subsection follows exactly:

1. ⭐ **The PRD declares the slot; the PRD does not define the value.** `FIL-XC-009` (**L302**): *"The
   module **MUST NOT** define a configuration value's default, range or resolution order."* Values are
   *"owned as values by their **scope owner**, not by this module"* (**L1211**).
2. ⭐⭐ **A slot may lawfully be published with NO value.** `FIL-CFG-006` carries a range and **no
   default** because *"inventing one would be a determination made by a document with no standing to
   make it"* (**L1236**). `PRD-017` states plainly that *"eight satisfy it and one does not"* rather than
   claiming compliance it does not have.
3. ⭐ **The exception is named in the text, not a footnote** — because *"a subsection that opens by
   claiming all nine comply and then discloses an exception is internally contradictory"* (**L1210**).

All slots resolve through `platform/configuration:settings` (**`E-19`**, BC Map **L328**).
⚠ **`NTF-AL-F3` is disclosed below**: `platform/communication`'s manifest block (**L392-410**) declares
**no** `platform/configuration:settings` port, so `E-19`'s *"all contexts"* grant and the module block
disagree. `PRD-017` has the identical condition (there is **no** `platform/media` module block at all),
so this subsection follows `E-19` as `PRD-017` does — and records the disagreement rather than curing it.

| ID | Configurable | Why it must be configurable | Value owner | Value status |
|---|---|---|---|---|
| **`NTF-CFG-001`** | **Bulk recipient-count ceiling** (`NTF-FR-017`) | Abuse and cost control that is **not** an entitlement — the `FIL-CFG-009` shape | **Product Owner** | ✅ **COMPLETE at v0.13 — ceiling default 200, range 1–500 recipients** **`[AUTHORITATIVE]`** (PO act, `ADR-0108` §7.1). ⭐⭐ **The dispatch RATE / INTERVAL limb is WITHDRAWN from this slot at v0.13** — it is **not** a `PRD-010` configurable; see **`NTF-XC-008`** and §20.7 (`ADR-0110` §2). ⛔ **No rate number invented** |
| **`NTF-CFG-002`** | **Template language / locale** (`NTF-FR-037`) | Locale must change without a template redeploy | **Product** | ⭐ **CITED, NOT MINTED** — resolves to **`LCFG-2`** (`Library_PRD_v1.md` **L717**, FROZEN Rank 3; `CONFIGURATION_GUIDE.md` **L352**): default **`en`**, range *"Supported set"*, owner **Product**. See §20.2 |
| **`NTF-CFG-003`** | **Category classification register** — each catalogue entry's **mandatory / optional** class (`NTF-FR-038`, `NTF-FR-040`) | Adding a catalogue entry must not change the contract | **Product Owner** | ✅ **COMPLETE at v0.12 — allowed set + all 13 per-entry defaults.** Allowed set **{`mandatory`, `optional`}** **`[AUTHORITATIVE]`** (PO act, `ADR-0108` §7.2). ⭐ **Per-entry matrix at §20.6**: 10 `mandatory`, 3 `optional`; **8 `[DERIVED]`** from entitlement/financial/account-lifecycle effect, **2 `[DERIVED]`** from the frozen `AUTH-8.52` security-significant category, **3 `[RECOMMENDED — SELF-SELECTED EXPERT DECISION]`** (`ADR-0109` §5). ⭐⭐ FROZEN `AUTH-8.52`/`-9.29`/`-9.43`/`-9.76` notices are `mandatory` and **MUST NOT** be opt-outable. ⚠ Reminder **timing** for `MembershipExpiringSoon`/`FeeDueRaised` stays `NTF-GAP-003` **`[OWED — PO]`** — a separate slot, ⛔ not this one |
| **`NTF-CFG-004`** | **Retry attempt bound** (`NTF-FR-049`) | Bounds the retry loop so a permanently failing delivery reaches a terminal state rather than retrying forever | **Architecture Owner** | ✅ **RATIFIED — CONDITIONALLY.** ⭐ **Default 3 total attempts, range 1–5**, unit **total attempts including the first** — Architecture Owner act, `ADR-0108` §3. Unit **`[AUTHORITATIVE]`** from the rank-0 contract (`job_runtime.dart` **L103-104**); floor **≥ 1** enforced **executably** (`services.dart` **L152-159**, `INV-21`). ⚠ **Condition:** representation must match the `JobRuntime` contract — **verified satisfied** (`job_runtime.dart` **L113-114**). ⚠ If a later `NTF-CFG-007` value is shorter than 3 × per-attempt duration, attempts 2–3 become unreachable and this bound **MUST be re-ratified downward** (`ADR-0108` §3.1) |
| ~~**`NTF-CFG-005`**~~ | ~~Retry backoff schedule~~ | — | **Architecture Owner** | ⛔⛔ **WITHDRAWN AS A CONFIGURABLE — NOT configurable in V1; backoff deferred to V2.** Architecture Owner act, `ADR-0108` §4.1. **0** backoff schedules exist at Rank 1–5; the V1 adapter implements none (`services.dart` **L189-221**, 0 delay primitives); EA **L1808** places *"Retry & Backoff"* at V2. ⇒ **No `NTF-CFG-*` identifier carries a backoff schedule** |
| ⭐ **`NTF-CFG-007`** | **Transport / attempt-run deadline** (`NTF-FR-049`, `NTF-FR-042`) | ⭐⭐ **RECLASSIFIED at v0.12 — a RUNTIME CONTRACT OBLIGATION, not a user-configurable value.** BC Map **L140** gives **`BC-31`** *"outbound third-party contracts, credentials, **retries**, idempotent delivery"* and `NTF-XC-006` forces push egress through it ⇒ a `BC-22` operator-tunable **provider** timeout would breach both | **Architecture Owner** | ⛔ **NOT operator-configurable.** `BC-22` **MUST** pass a `deadline` on every `JobRuntime` submission (`job_runtime.dart` **L113-114**) strictly greater than `NTF-CFG-004` × the `BC-31` per-attempt bound — stated at **`NTF-FR-067`**, tested by **`NTF-AC-011`**. ⛔ **No default or range published here.** ⚠ The `BC-31` per-attempt **number** stays **`[OWED — EXTERNAL EVIDENCE]`** (`NTF-GAP-017`). ⛔⛔ **MUST NOT be described as a user-visible latency cap** — `services.dart` **L193** checks only *between* attempts, **L207** leaves `await work()` unbounded (**`NTF-RTD-001`** / `NTF-GAP-029`). (`ADR-0109` §4) |
| ~~**`NTF-CFG-006`**~~ | ~~Deduplication window~~ | — | **Architecture Owner** | ⛔⛔ **WITHDRAWN AS A CONFIGURABLE — retention is FIXED and NOT configurable**, bounded by the authoritative `FeedItem` lifetime (`BCM-22-INV-1`, BC Map **§18.4**). Architecture Owner act, `ADR-0108` §4.2, on the `SEAT-FR-202` / `ITG-FR-017` precedent — both *"fixed, not configurable"*, **zero** configurable dedup windows repository-wide. Obligation now stated at **`NTF-FR-066`**. ⚠ **Numerical bounds are NOT invented** — recorded as unresolved bounded decision **`NTF-OBD-001`** (`NTF-GAP-028`) |

⭐⭐⭐ **Six slots, not seven — and this is a correction to the author's own Stage-4 review, not a
convenience.** [`PRD-010_STAGE4_REQUIREMENTS_REVIEW.md`](PRD-010_STAGE4_REQUIREMENTS_REVIEW.md) v1.0
classified **seven** obligations as *"Class-A configurables"*. Three of those seven are **not
configurables at all**, and calling them configurables was a category error:

| Obligation | Prior class | ⭐ Corrected class | Why a default-and-range cannot apply |
|---|---|---|---|
| **`NTF-FR-044`** — Push `delivered` semantics | Class A configurable | ⛔ **Provider-semantic DEFINITION** | No configuration value changes what FCM acknowledges. Rank 1 `MASTER_PRD.md` **L229** already fixes the provider (*"**Firebase Cloud Messaging** — Yes — FCM (V1)"*), so the **provider** is settled; the **acknowledgement model** is that provider's published documentation, which this repository does not contain (the `ADR-0045` condition). ⇒ `NTF-GAP-017` is a **documentation-dependency** gap, not a value gap |
| **`NTF-FR-054`** — platform-level vs tenant-level keys | Class A configurable | ⛔ **Configuration-platform RESOLUTION property** | `FIL-XC-009` forbids this module defining a *"resolution order"*. Which keys resolve at platform scope is `BC-25`'s own semantics — `ADR-0017` **§2.5** assigns *"hierarchy, precedence and override semantics"* to `PRD-023`. ⇒ `PRD-010` may **not** publish this as its own slot |
| **`NTF-FR-065`** — SLO / SLI targets | Class A configurable | ⛔ **NFR locus, not a configurable** | Rank 1 `MP-NFR-01` (`MASTER_PRD.md` **L495**) assigns availability *"targets with SLOs, SLIs and error budgets"* to **SRE / OBSERVABILITY**. An NFR target is ratified by an office, not tuned by an operator. See §20.5 |

⇒ ⭐ **Stage-4 check 3 therefore has a materially smaller and differently-shaped target than the review
recorded**: **six** slots, of which **one is already satisfied by citation** (`NTF-CFG-002`) and **five
are owed**, plus **three obligations that leave the check-3 register entirely** and fall to check 1
(testability) instead.

#### 20.2 `NTF-CFG-002` — why `LCFG-2` may be cited here although `PRD-015` was refused it

⚠ **This looks like the borrowing `PRD-015` was four times refused, so the distinction is stated before
the citation is relied upon.** `SRCHCL-X3`, `SRCHGR-X4`, `SRCHGB-X4` and `PRD-015_F5_OWNERSHIP_RULING.md`
**§4.3** each **REJECTED** `LCFG-2`, the last calling it *"a **false friend**"*.

⭐ **Every one of those rejections turns on the same measured reason, and that reason does not obtain
here.** `PRD-015_P2_ARCHITECTURE_DECISION.md` **L222**: *"It is also a **UI-string locale**, not a
**script inventory**."* `F5_OWNERSHIP_RULING` **§4.3**: *"a tenant set to `en` may hold a Devanagari
name."* The refusals hold that a **UI-string locale cannot determine an indexed field's script**.

⭐⭐ A notification **template is a UI string**. `LCFG-2`'s own published rationale is verbatim *"Only
locale with complete strings at V1"*. `NTF-CFG-002` asks for exactly the property `LCFG-2` governs, so
the *false-friend* objection is inapplicable — it was never an objection to `LCFG-2` as a **string
locale**, only to `LCFG-2` as a **script inventory**.

⛔ **Two things are still NOT claimed.** (1) ⛔ `ADR-0100` **§3.7**'s closed **English + Hindi** inventory
is **search-scoped** and is **NOT** imported — `NTF-FR-037`'s existing prohibition on borrowing
`SRCHPO-17` **stands unamended**. (2) ⛔ **No second source of truth is created**: `NTF-CFG-002` is
recorded as a **consumption of `LCFG-2`**, not as an independent slot holding a copied value.
⚠ Whether a `BC-22` template may consume a **Library-scoped** `LCFG-*` value is an **Architecture Owner**
question, registered as **`NTF-GAP-024`** — the citation's *value* is authoritative, its *cross-context
consumption* is not yet ruled.

#### 20.3 `NTF-CFG-004` — the unit is fixed by precedent even though the value is not

⭐ **`FIL-CFG-014`** (`CONFIGURATION_GUIDE.md` **§2C.6**, **L607-621**) is the repository's only retry
bound. Its **Unit** is *"attempts"* and its **Default** is *"**3** attempts total (initial + 2
retries)"*; **`INV-21`** (**L757**) requires *"retry bound **≥ 1**"* because *"zero attempts means
nothing is ever processed."*

⇒ ⭐ **A retry configurable in this repository counts TOTAL ATTEMPTS, not retries.** Any `NTF-CFG-004`
value expressed as *retries* with a floor of `0` would contradict `INV-21`'s floor of `1` under the
repository's established unit. **The unit is therefore declared here; the number is not.**

⭐⭐⭐ **STRENGTHENED AT v0.4 — the unit is fixed by a SHARED-KERNEL CONTRACT, not merely by another
PRD's precedent.** v0.3 rested this on `FIL-CFG-014`, which is a **`PRD-017`-scoped value** and
therefore weak authority for `PRD-010`. The stronger and correct authority is the **`JobRuntime` port
itself** — `contracts`, **rank 0**, consumable by every module:

> *"`retryBudget` is the **total** attempts permitted, **including the first** — the consumer supplies
> the bound and the runtime owns the loop."*
> — `packages/liboora_contracts/lib/src/ports/job_runtime.dart` **L103-104**

⇒ ⭐ **The unit is not a borrow at all.** It is the signature of the platform port any `BC-22` retry
must be submitted through, and `JobOutcome.attempts` is documented as *"attempts consumed, **including
the first**"* (**L82**). The `≥ 1` floor is **executable**, not aspirational:
`services.dart` **L152-159** throws `ArgumentError` on `retryBudget < 1`, quoting `INV-21` by name.

⇒ ⭐⭐ **`NTF-CFG-004`'s unit is therefore REPOSITORY-AUTHORITATIVE for `PRD-010`, not merely
precedent-supported** — a stronger classification than v0.3 published.

⛔ **`FIL-CFG-014`'s NUMBER (3) is still NOT carried across**, and the reason is now sharper than
v0.3's. Its rationale is a **storage** failure domain — *"a worker eviction, a storage blip"* — and its
recovery model is `FIL-FR-057`/`FIL-FR-083`: *a derivative is **never the sole copy** and is
**regenerable***.

⛔⛔ **v0.4's "inverted recovery models" CLAIM IS FALSIFIED AND WITHDRAWN AT v0.5 — I asserted a
durability property of this domain without measuring the channel set.** v0.4 stated that *"a
notification is **not regenerable** and has **no second copy**"*. **Both halves are wrong**, and the
measurement is in this document's own §8 catalogue:

| Measurement | Result |
|---|---|
| Catalogue rows naming **In-App** | ⭐ **13 of 13** |
| Rows that are **Push-only** (no In-App) | ⭐⭐ **ZERO** |
| Rows that are **In-App + Push** | **11**; the remaining 2 are **In-App only** |
| In-app inbox ownership | ⭐ *"`FeedItem` … owned by **`BC-22`'s inbox projection**"* — BC Map **L205** |
| Projection durability | ⭐⭐ **`BC-22`'s inbox is a PROJECTION**, and BC Map **L453** (Rank 4) requires *"every projection … **must be rebuildable from the log**. This is tested quarterly, not assumed."* |
| Event delivery guarantee | ⭐ **At-least-once** with mandatory consumer idempotency — BC Map **L446-447** |

⇒ ⭐⭐⭐ **A failed Push is NOT a lost notification.** For **every** catalogue entry the In-App inbox
carries the same fact, that inbox is a **rebuildable projection**, and the source event is retained in
the log under an at-least-once contract. **The notification IS regenerable and DOES have a second
copy** — the exact property v0.4 denied.

⇒ ⭐⭐ **The corrected comparison points the OPPOSITE WAY from v0.4's conclusion.** `PRD-017` and
`PRD-010` do **not** have inverted recovery models — **both** have a surviving copy and a regeneration
path. So the *shape* of `FIL-CFG-014`'s reasoning (a small bound that absorbs transient faults without
masking deterministic failure, because a durable fallback exists) **does** transfer, even though its
**number does not** transfer as authority.

⚠ **This makes `3` more defensible than v0.4 said, and it is recorded even though it weakens my own
earlier position.** ⛔ **But it still does not make `3` authoritative for `PRD-010`**, for a reason
that survives the correction: `FIL-CFG-014` is a **`PRD-017`-scoped value** owned by that PRD's scope
owner, and `ADR-0033` **§7.1** forbids importing it. ⭐ **What changed is the argument, not the
verdict** — v0.4 refused `3` *on the merits*; v0.5 finds **no merits objection remains**, leaving only
the **authority** objection. See §20.3b for the derivation this permits and the one it does not.

#### 20.3b ⭐ What CAN be derived, and the one thing that cannot

⭐⭐ **Two bounds are derivable from repository evidence and are recorded as CONSTRAINTS, not values:**

| Bound | Value | Derivation |
|---|---|---|
| **Floor** | ⭐ **≥ 1 total attempt** | ⛔ **Not a proposal — already binding.** `INV-21` (*"retry bound ≥ 1"*) and the **executable** guard at `services.dart` **L152-159**, which throws `ArgumentError` on `retryBudget < 1` |
| **Ceiling constraint** | ⭐⭐ **Attempts × per-attempt duration MUST fit inside the job `deadline`** | `job_runtime.dart` **L105-107**: *"`deadline` bounds the whole job; on expiry the runtime moves it to `JobState.failed`"*, and `services.dart` **L190-201** checks the deadline **before each attempt**. ⇒ a budget whose attempts cannot all be tried before the deadline is **partly unreachable** — the same class of defect `INV-20`/`INV-18` guard against elsewhere |

⛔⛔ **The exact number is NOT derivable, and the reason is specific rather than procedural.** The
ceiling constraint above is a **function of two quantities that do not exist**: (a) a notification job
**deadline** — `NTF-CFG-*` declares none and **0** exists at any rank; (b) the **provider's** retry and
acknowledgement behaviour, which is `NTF-GAP-017`, unresolvable because the repository does not contain
FCM's documentation (the `ADR-0045` condition). ⇒ ⭐ **Any specific number — 3, 4 or 5 — would be
picked, not derived.** `PRD-017` could derive **3** only because `ADR-0057` had **already** fixed its
companion timeout at **120 s** (`FIL-CFG-015`); `PRD-010` has **no companion deadline**, so the same
derivation is **structurally unavailable** here.

⇒ ⛔ **`NTF-CFG-004`'s value remains OWED.** ⚠ **A range is nonetheless the right SHAPE** — every
comparable slot in `CONFIGURATION_GUIDE` §2A/§2C publishes one (`LCFG-6` *0–300 s*, `LCFG-12` *5–50*,
`FIL-CFG-014` *1–5*) — but its **bounds** depend on the missing deadline, so the range is owed **with
the floor already fixed at 1**.

#### 20.3c ⭐⭐⭐ Comparative analysis 1 · 2 · 3 · 4 · 5 — and the measurement that decides it

⭐⭐⭐ **THE DECISIVE RUNTIME FACT, measured rather than assumed: the V1 retry loop contains NO DELAY
BETWEEN ATTEMPTS.** A probe for every delay primitive returns **zero** in both artefacts:

| Probe | Result |
|---|---|
| `Future.delayed` · `sleep` · `Timer` in the **retry loop** | ⛔ **NONE.** `services.dart` **L196-221** is: deadline check → `attempts++` → `await work()` → `catch` → **loop immediately** |
| Any delay primitive in the **port contract** | ⛔ **NONE.** `job_runtime.dart` — 0 occurrences of `delay`, `Timer`, `interval` |
| The single `await Future.wait` in the file | ⭐ **L124 — inside `drain()`**, a test/shutdown join point, ⛔ **not** the attempt loop |

⇒ ⭐⭐⭐ **At V1 every attempt in the budget is consumed in an immediate, tight burst.** This is the
fact that governs the comparison, and it **inverts the usual reasoning**: without backoff, a larger
budget does not buy resilience against a transient outage — it buys **N near-simultaneous calls to the
same failing provider**, which is the definition of a retry storm and is what `MP-GBR-22`-adjacent
provider-load thinking exists to prevent.

| Budget | Assessment against measured behaviour |
|---|---|
| **1** | ⛔ **Rejected — lawful but pointless.** `services.dart` **L152-159** permits it and `FIL-CFG-014`'s own text calls 1 *"no retry, permitted for diagnostics"*. It cannot absorb a single dropped packet, and `NTF-FR-047` explicitly contemplates transient failures **being retried** — a budget of 1 makes that requirement inoperative |
| **2** | ⚠ **Defensible, and the strongest rival to 3.** One immediate re-attempt absorbs a single-packet loss. ⛔ But two adjacent attempts with **zero** spacing address only the very shortest fault, and nothing in the repository supports 2 over 3 |
| **3** | ⭐ **Best available V1 choice on the evidence** — the reasoning, **not the number**, transfers from `FIL-CFG-014`: *"three attempts absorb transient faults … without masking a deterministic failure"*, a rationale that holds **because** a durable fallback exists — and §20.3's correction establishes that `PRD-010` **has** one (In-App inbox is a rebuildable projection, **13/13** rows, BC Map **L205**/**L453**) |
| **4** | ⛔ **Rejected — no evidence distinguishes it from 3**, and with **no backoff** the 4th immediate attempt adds provider load without adding a meaningfully different time window. Selecting it would be preference presented as derivation |
| **5** | ⛔⛔ **Rejected on two independent grounds.** (1) Same as 4, amplified. (2) ⭐ **The only `5` in the repository is adversarial, not reliability-based** — `AUTH-3.9` *"at most **5** verification attempts"* bounds an **attacker's guesses**, and `CONFIGURATION_GUIDE` **L41** lists it among values that are *"**not configurable**"*. Borrowing its shape would import a security-throttle rationale into a fault-tolerance slot |

⇒ ⭐⭐ **TECHNICAL RECOMMENDATION (labelled as such): `3` total attempts, range `1–5`.** The **range**
is independently supported: its floor `1` is **already binding** (`INV-21`, executable), and `1–5` is
the shape every comparable slot uses. ⚠ **`5` is acceptable as a range CEILING even though it is
rejected as a default** — a range bounds what an operator may set; it does not endorse the extreme.

⛔⛔ **BUT THIS REMAINS A RECOMMENDATION, NOT A DETERMINATION, AND THE REASON IS NOT PROCEDURAL
CAUTION.** ⭐ **The ceiling inequality is still unsolvable**: with **no** inter-attempt delay, the
attempts consume ≈ 3 × (provider timeout), and **neither factor is known** — `NTF-CFG-007` (deadline)
is **OWED** (`NTF-GAP-026`) and the provider's timeout/acknowledgement model is **`NTF-GAP-017`**,
blocked by absent FCM documentation. ⇒ A budget fixed now could be **partly unreachable** the moment a
deadline is chosen: if the deadline is shorter than 3 × timeout, the 2nd or 3rd attempt is **never
tried** and the configured value would be a fiction. ⭐ **That is exactly the defect class `INV-18` and
`INV-20` exist to prevent**, and `FIL-CFG-015`'s own history is the precedent — it was *"added because
writing the configurable exposed that the obligation was missing."*

⇒ ⭐⭐⭐ **ORDERING IS THEREFORE SUBSTANTIVE, NOT BUREAUCRATIC: `NTF-CFG-007` (deadline) MUST be
decided BEFORE or WITH `NTF-CFG-004`.** They are one decision with two limbs, and `PRD-017` is the
proof: `ADR-0057` set the **120 s** timeout and the **3**-attempt bound **in the same act**.

⚠ **`NTF-GAP-025` (DLQ) does NOT block the budget** — it governs what happens **after** exhaustion, not
how many attempts occur. It is recorded as **non-blocking** for this decision.

⚠ **One further precedent is disclosed rather than relied upon.** `test/architecture/job_runtime_port_test.dart`
**L43** declares `const int _retryBound = 3` — but its own comment names it *"the recorded
**`FIL-CFG-014`** default"*, i.e. a **`PRD-017`** value used as a test fixture. ⛔ **It is not
`PRD-010` authority**, and citing an executing test as if it ratified a value for a different bounded
context would be manufacturing authority from a fixture.

⚠ **A limit of the §20.3 correction is disclosed.** BC Map **L453**'s rebuildability rule is Rank 4 and
binding, but `test/architecture/every_projection_rebuildable_test.dart` covers **Analytics** projections
only — **0** occurrences of `BC-22`, `inbox` or `FeedItem` — and `lib/platform/` contains **no
`communication` module**. ⇒ ⭐ The In-App fallback is **specified and required**, but **not yet
executably proven** for `BC-22`. The recommendation of `3` rests on the **specification**, and that
distinction is stated rather than blurred.

⇒ ⛔ **`NTF-CFG-004`'s value stays OWED**, with the **unit authoritative**, the **floor already fixed
at 1**, and **`3` / `1–5` standing as a technical recommendation awaiting Architecture Owner
ratification jointly with `NTF-CFG-007`.**

#### 20.3d ⛔⛔ ADVERSARIAL AUDIT OF §20.3c — the recommendation SURVIVES as to the number, but is DISPROVED as to COMPLETENESS

An adversarial pass was run against §20.3c specifically looking for evidence that **disproves** it.
The number `3` and the range `1–5` **survived**. ⛔ **But three structural defects were found that
§20.3c did not contemplate, and the first two make `NTF-CFG-007` — as I previously framed it —
UNANSWERABLE rather than merely owed.**

**⛔ DISPROOF 1 — a single `JobRuntime` deadline CANNOT express a deferrable notification.**

`NTF-FR-039` (this document, **L423**): *"Quiet hours **MUST defer, never drop**, a deferrable
notification."* Quiet hours are, by nature, **hours**. The `JobRuntime` deadline *"bounds the **whole
job**; on expiry the runtime moves it to `JobState.failed`"* (`job_runtime.dart` **L105-107**).

⇒ ⭐⭐⭐ **A deferred notification held overnight would blow ANY delivery-sized deadline and terminate
as `failed` — converting a *"defer, never drop"* obligation into a DROP.** ⇒ ⛔ **The two cannot be the
same clock.** `NTF-CFG-007` as previously framed (*"the whole-job bound"*) is therefore **not one
value**: it must distinguish

- an **attempt/transport budget** — how long one delivery pipeline may run, which is what bounds
  `NTF-CFG-004`; from
- a **notification validity horizon** — how long a *deferred but still-wanted* notification remains
  worth sending, which is what `NTF-FR-039` and the `expired` state require.

⛔ **Neither number is invented here.** ⭐ The finding is that **`NTF-CFG-007` was under-specified by
its own author**, and a deadline chosen without this split would silently break a stated requirement.

**⛔ DISPROOF 2 — the lifecycle's terminal states do not map onto `JobState`.**

§18 declares terminal states `delivered | failed | expired | cancelled`. `JobState` has exactly
**two** terminal members — `succeeded` and `failed` — and **`failed` explicitly conflates two
causes**: *"Attempts exhausted, **or the deadline expired**"* (`job_runtime.dart` **L62-63**).

⇒ ⛔ **`expired` and `cancelled` have no representation in the runtime**, and `NTF-FR-042`'s
monotonicity plus `NTF-FR-064`'s observability both depend on telling them apart — the same
distinction `CONFIGURATION_GUIDE` **L892** insists on for `PRD-017` (*"objects moved to `FAILED` **by
timeout**, distinct from failure by error"*). ⇒ ⭐ `JobOutcome.reasonCode` is the available carrier
(`deadline_exceeded` vs `retries_exhausted`, `services.dart` **L197**/**L226**), but **mapping the two
runtime terminals onto four lifecycle terminals is an unmade architecture decision**.

**⚠ DISPROOF 3 — quiet hours have no configuration slot at all, and a Rank-1 / Rank-6 tension.**

⛔ **`NTF-CFG-001`…`007` contain ZERO quiet-hours parameters** (measured: 0 occurrences of *"quiet"* in
§20.1), yet Rank 1 **`MP-GBR-35`** assigns quiet hours to `BC-22` and **BC Map L131** lists them among
what `BC-22` *owns*. ⚠ Meanwhile **EA L1447** places *"Quiet Hours & DND"* at **V2**. ⭐ Per
**`MP-CON-08`**, the EA is *"descriptive, not prescriptive"* and a disagreement is *"a **defect to be
raised**, not a choice to be made"* ⇒ **Rank 1 wins and this is raised, not resolved.** ⛔ **No quiet
window is invented and no slot is minted here** — minting one would presuppose the V1/V2 answer.

⇒ ⭐⭐ **REVISED CONCLUSION.** The retry budget is **not** blocked by an unknown *number*; it is blocked
by an **unmade structural decision** — whether the delivery clock is one bound or two, and how four
lifecycle terminals map onto two runtime terminals. ⛔ **This is PROVEN INSUFFICIENCY, not caution:**
no arithmetic over repository values can produce the missing distinction, because the distinction is
**categorical**. ⇒ **`NTF-GAP-027`** carries it.

⭐ **What survives the audit unchanged:** the **unit** (total attempts incl. first), the **floor**
(`≥ 1`, executable), the **recommendation** `3` with range `1–5`, and the finding that **more attempts
without backoff buys provider load, not resilience**.

#### 20.3e ⭐⭐⭐ RESOLUTION — §20.3d's Disproofs 1 and 2 are THEMSELVES DISPROVED. One clock, and BC-22 owns its own lifecycle

⛔⛔ **§20.3d concluded STOP CONDITION B on a hypothesis it never tested: that `DeliveryMessage`'s
lifecycle and the `JobRuntime` job are the same object. They are not — and the port contract says so in
its own words.** The resolution below required no new authority; it required reading the contract §20.3d
was reasoning about.

**⭐⭐⭐ DISPROOF 2 DISSOLVES — the port ALREADY separates job state from domain lifecycle.**

> *"`JobState` is **deliberately not the same enum** as a File & Media object lifecycle
> (`RECEIVED → VALIDATING → PROCESSING → READY | FAILED`, `FIL-FR-092`). **A job is the mechanism; the
> object lifecycle is the domain fact.** Fusing them would put media semantics into a platform port and
> hand `BC-29` state it does not own."*
> — `packages/liboora_contracts/lib/src/ports/job_runtime.dart` **L45-51**

⇒ ⭐⭐ **There is no "2 → 4 mapping problem", because no mapping is required.** `PRD-017` already runs a
**five**-state lifecycle over the same two-state job and this is expressly the *intended* design, not a
tension. ⭐ **`DeliveryMessage` is a `BC-22`-owned aggregate root** — declared by **`ADR-0107`** §3.1 and BC Map
**§18.1**. ⚠⚠ **CORRECTED at v0.11:** earlier text cited **BC Map L205** for this, which was an
**over-reading** — L205 is a row in **§5 Ubiquitous Language Collisions**, whose column is binding on
*"the names that must appear in code, APIs"* (**L195**), **not** on aggregate structure. The aggregate
declaration did not exist until `ADR-0107`. So §18's lifecycle is
**`BC-22`'s domain state**, persisted by `BC-22`, and `JobState` is merely the **mechanism** state of one
transport attempt-run. `JobOutcome.reasonCode` (`deadline_exceeded` vs `retries_exhausted`) is the
**input** `BC-22` uses to set its own state — not a competing lifecycle.

**⭐⭐⭐ DISPROOF 1 DISSOLVES — deferral happens BEFORE submission, so it never touches the deadline.**

The decisive evidence is §18's own ordering plus two requirements §20.3d did not connect:

| Fact | Source |
|---|---|
| Lifecycle order is `created → **queued** → processing → sent → …` | §18 |
| A dispatch is cancellable **while any recipient remains in `queued`** | **`NTF-FR-014`** |
| The idempotency record is claimed **atomically before dispatch** | **`NTF-FR-046`** |
| Restart **MUST NOT** re-deliver work already in `sent` | **`NTF-FR-048`** |

⇒ ⭐⭐⭐ **`queued` is a pre-submission `BC-22` state.** Quiet-hours deferral, cancellation and
scheduling all occur **in `queued`, before any job exists**. ⇒ **A deferred notification is not a
running job whose deadline is ticking — it is a `queued` `DeliveryMessage` that has not been submitted
yet.** ⇒ ⛔ **The "deferred overnight → deadline blown → `failed`" scenario cannot arise**, because the
deadline only begins when `BC-22` submits at the end of the quiet window.

⇒ ⭐⭐ **ONE CLOCK IS SUFFICIENT, AND IT IS THE SMALLEST ARCHITECTURE THAT SATISFIES EVERY
REQUIREMENT** — `NTF-CFG-007` is a **transport/attempt-run deadline**, scoped to one submitted
delivery run, and **not** a notification validity horizon. ⛔ **The v0.5 "split the slot" proposal is
WITHDRAWN as unnecessary**: it would have added a second configurable to solve a problem created by
conflating a pre-submission domain state with a running job.

⚠ **Two consequences are stated so the resolution is falsifiable rather than merely tidy.**
1. ⭐ **`expired` is a `queued`-side domain concern**, not a job outcome — a notification that is still
   `queued` when it ceases to be worth sending expires **without a job ever running**. Whether such a
   horizon exists at V1 is a **product** question about `NTF-FR-039`'s deferral, ⛔ **not** a
   `JobRuntime` parameter, and ⛔ **no horizon value is proposed**.
2. ⭐ **`cancelled` likewise never needs runtime representation** — `NTF-FR-014` bounds cancellation to
   `queued`, i.e. before submission. **Once submitted, cancellation is out of scope by construction**,
   which is a **stronger** guarantee than a mapping would have provided.

⇒ ⭐ **`NTF-GAP-027` is NARROWED, not closed.** Its limbs 1 and 2 are **resolved by existing
authority** (the port's own contract + §18/`NTF-FR-014`/`-046`/`-048`). ⛔ **Limb 3 remains OPEN**: quiet
hours still have **0** configuration slots while **Rank-1 `MP-GBR-35`** assigns them to `BC-22` and
**EA L1447** places them at **V2** — a **`MP-CON-08`** *"defect to be raised, not a choice to be
made"*. ⛔ **Not closed here**; closing it is an Architecture Owner act.

⭐⭐ **What this changes for the retry budget.** The ceiling inequality is now well-formed —
*attempts × per-attempt duration ≤ **transport** deadline* — and it is bounded by a **single**
transport-scoped value rather than by an undefined clock. ⛔ **But the two quantities are still
missing**: the transport deadline (`NTF-CFG-007`, **OWED**) and the provider timeout
(**`NTF-GAP-017`**, blocked by absent FCM documentation). ⇒ ⭐ **`3` / range `1–5` stands as
`[RECOMMENDED]`**, and **`NTF-CFG-007` is now a well-defined single value awaiting one Architecture
Owner number** — a materially smaller decision than §20.3d left open.

#### 20.3a `NTF-CFG-005` (backoff) — the one genuinely premature slot, and why

| Measurement | Result |
|---|---|
| Backoff schedules anywhere at Rank 1–5 | ⛔ **0.** Every occurrence is a **refusal** (`ADR-0028` §10, `ADR-0035` §5.5b, `ADR-0044` §3.2, `ADR-0045`, `LCN-FR-050`) or a **provider's own** policy (`ITG-FR-022`, Razorpay `[RZP]`, expressly *"not ours"*) |
| Backoff in the **V1 `JobRuntime` adapter** | ⛔ **NONE.** `services.dart` **L189-221** retries **immediately** on failure |
| EA placement | ⭐ *"Retry & Backoff **(V2)**"* — EA **L1808**, **L1869**; `ADR-0058` §3.3 confirms *"no distributed backoff"* is built at V1 |

⇒ ⭐⭐ **A backoff *value* configured at V1 would have nothing to execute it.** This — and **not** the
attempt bound — is the slot `NTF-AL-F4` genuinely renders premature. ⛔ **No schedule is proposed.**

⚠⚠ **A Rank-4 obligation is disclosed rather than claimed as satisfied.** BC Map **L452** requires, for
the **event backbone**: *"Retry with backoff → **Dead Letter Queue**. DLQ depth is an SLO-monitored
signal, not a silent bin."* ⭐ **This governs event *consumption*, owned by EVENT PLATFORM (§9.1
preamble) — not `BC-22`'s outbound *channel* delivery**, which is why `NTF-FR-047`'s terminal `failed`
does not contradict it. ⛔ **But `PRD-010` contains 0 occurrences of DLQ or dead-letter**, and `BC-28`
(which BC Map **L137** says *"owns … DLQ"*) is **V2**. ⇒ ⭐ **`NTF-GAP-025`** — whether a failed
notification delivery requires a dead-letter path, or whether the terminal `failed` record plus
`NTF-FR-064` observability discharges L452 for the outbound plane. Owner: **Architecture Owner**.
⛔ Not resolved in this document's favour.

⛔ **`FIL-CFG-014`'s value is NOT carried across.** Its rationale is a **storage** failure domain
(*"a worker eviction, a storage blip"*); a push-provider `503` is a different domain, and its owner is
the **file-media Configuration Owner**. Importing the number would be precisely the cross-PRD borrow
`ADR-0033` **§7.1** forbids.

⚠⚠ **`NTF-AL-F4` — an architecture finding, NARROWED at v0.4 after the author's own overstatement was
corrected.** `platform/communication`'s block (**L392-410**) declares **no** job, scheduler or timer
port; **`platform/workflow` is the only module declaring `platform/services:job_runtime`** (**L338**).
⇒ `NTF-FR-049` presupposes a retry mechanism the manifest does not currently grant `BC-22`.

⛔⛔ **THE v0.3 FORMULATION WAS WRONG IN TWO RESPECTS AND IS WITHDRAWN, NOT SOFTENED.**

1. ⛔ **It cited `FIL-XC-017` as though it bound `BC-22`. It does not.** `FIL-XC-017` is a **`PRD-017`
   exclusion binding `BC-29`**. `PRD-010`'s own exclusion register (`NTF-XC-001`…`-006`) contains **no**
   prohibition on `BC-22` scheduling. ⇒ Applying a **frozen exclusion from another PRD** to this
   subject is exactly the cross-PRD borrow this document refuses elsewhere. The finding is a **missing
   port**, not a violated prohibition.
2. ⛔⛔ **It called the condition *"the same as `FIL-GAP-015`"* while `FIL-GAP-015` is CLOSED.**
   ⭐ **`ADR-0058` (`Accepted`, 2026-08-20) closes `FIL-GAP-015`** and was **not measured** before v0.3
   published the comparison. Its holding is directly on point: the gap was a
   **port-vs-runtime conflation**, and *"every child of EA 'Job Runtime (V2)' … is scaled
   **infrastructure**, and **none of them is the port**."*

⭐⭐⭐ **The consequence is favourable and was missed: the mechanism `NTF-FR-049` needs ALREADY EXISTS.**

| Element | Status | Evidence |
|---|---|---|
| `JobRuntime` **port interface** | ✅ **EXISTS** | `packages/liboora_contracts/lib/src/ports/job_runtime.dart` **L100**; exported at `liboora_contracts.dart` **L27** |
| **V1 adapter** | ✅ **EXISTS and is registered** | `InProcessJobRuntime`, `lib/platform/services/services.dart` **L100**; composition root `lib/bootstrap/di.dart` **L240-243** |
| **Rank lawfulness of a `BC-22` → port edge** | ✅ **STRICTLY DOWNWARD** | `platform/services` = **rank 3**, `platform/communication` = **rank 5** (manifest **L26-49**) ⇒ **`L2` satisfied with no exception, no cluster and no ADR-0012-style debt** |
| **Retry unit in the port contract** | ⭐⭐ **`retryBudget` is *"the **total** attempts permitted, **including the first**"*** | `job_runtime.dart` **L103-104** |
| **`≥ 1` enforcement** | ✅ **Executable**, citing `INV-21` by name | `services.dart` **L152-159** — `ArgumentError` if `retryBudget < 1` |
| **Backoff in the V1 adapter** | ⛔ **NONE** — the loop retries immediately | `services.dart` **L189-221**: deadline check, attempt, `catch`, loop; **no delay** |

⇒ ⭐ **`NTF-AL-F4` reduces to ONE narrow act**: a manifest amendment adding
`platform/services:job_runtime` to `platform/communication`'s `ports:` list — the **`A-3` shape**
(`amendments_applied` **L715-721**), which is how this same module gained
`platform/identity:notification_address`. ⛔ **Not** an exception, ⛔ **not** a law waiver, ⛔ **not**
new infrastructure. Owner: **Architecture Owner**. ⛔ **The manifest is NOT edited here** — this PRD has
no standing to amend a Rank 4 artefact.

⭐ **Why this materially changes the value question rather than merely relabelling it.** v0.3 said the
retry value was *premature*. That was **wrong**: the runtime exists, the unit is contract-fixed, and the
lawful edge is one downward port. What is genuinely premature is only **`NTF-CFG-005` (backoff)** — see
§20.3a.

#### 20.4 `NTF-CFG-006` — invariant-constrained, and therefore not a free tuning value

⭐⭐ **`NTF-INV-007`** states that *"retry **MUST NOT** produce a second user-visible notification."*
A deduplication **window** that expires while a retry is still in flight would produce exactly that.
⇒ The dedup window is bounded **below** by an invariant, not merely by taste, and its lawful range
must be derived jointly with `NTF-CFG-004` and `NTF-CFG-005`. ⛔ **The three are NOT independently
choosable**, which is why `NTF-GAP-018` carries all three together.

⛔ **`PRD-019`'s 30-day dedup retention is NOT applicable.** `ITG-FR-017` retains an opaque
`(tenant, event-id)` **transport** key derived from a payment provider's 24-hour retry and 15-day
replay windows (`ADR-0047` **L101**). `NTF-INV-007`'s key is
`(eventId, recipientId, channel, templateId)` — a **user-visibility** key. Different key, different
purpose, different owner.

#### 20.5 `NTF-FR-065` — why no SLO is published here

Rank 1 **`MP-NFR-01`** assigns availability *"targets with SLOs, SLIs and error budgets"* to
**SRE / OBSERVABILITY**. ⭐⭐⭐ **The repository has never ratified an SLO for anything.** `ADR-0102`
constituted that office **for `PRD-015` only**, ratified a **target** (`99.9% monthly`), and expressly
recorded **`SRE-GAP-001` OPEN** because *"this act ratifies the **target** only; the **SLO**, **SLI**
and **error budget** are **NOT**"* specified. ⇒ An SLO published here would be the **first in the
repository**, asserting *more* authority than the one conferred act claimed. ⛔ Refused.

⭐ **What the repository does fix, and what it does not:**

| Element | Repository position |
|---|---|
| **Unit** | ⭐ **`% monthly`** — `authentication/prd-v2/11-NFR-Compliance-and-Final-Acceptance.md` **L67-69** (*"99.9% monthly"*, *"99.95% monthly"*). ⛔ *"rolling 30 d"* has **0** occurrences repository-wide |
| **Coherence direction** | ⭐ A dependent service sits **below** its dependency (`ADR-0100` **§3.2**). `BC-22` depends on `BC-31` and `BC-18` ⇒ its target **MUST NOT exceed 99.9%** |
| **Continuous-outage analogue** | *"Maximum tolerable continuous outage — **30 minutes**"* (**L70**) — for a service the same document calls *"availability-critical"* |
| **Criticality ordering** | ⭐⭐ **`NTF-INV-011`** makes notification failure the one plane that **must never** fail a business operation ⇒ notification is the **least** availability-critical plane, so it **cannot** carry a **tighter** outage bound than authentication without inverting the ordering **L72-73** states expressly |
| **Numeric value** | ⛔ **OWED** — `NTF-GAP-020`, owner **SRE / Observability**, requiring a **fresh** conferral for `PRD-010` (`ADR-0033` §7.1 bars reusing `ADR-0102`) |

---

#### 20.6 ⭐ `NTF-CFG-003` — the per-entry class matrix (all 13 catalogue entries)

| # | Catalogue entry | Class | Basis | Label |
|---|---|---|---|---|
| 1 | `enrollment.StudentEnrolled` | **mandatory** | Account-lifecycle fact; the recipient cannot be left unaware their record exists | `[DERIVED]` |
| 2 | `membership.MembershipCreated` | **mandatory** | Entitlement commencement — contractual/financial | `[DERIVED]` |
| 3 | `membership.MembershipRenewed` | **mandatory** | Entitlement continuation — financial | `[DERIVED]` |
| 4 | `membership.MembershipExpiringSoon` | **optional** | A **reminder**, not a state change; the fact is re-derivable from the membership record | `[RECOMMENDED — SELF-SELECTED EXPERT DECISION]` |
| 5 | `membership.MembershipExpired` | **mandatory** | Loss of entitlement — access changes | `[DERIVED]` |
| 6 | `attendance.StudentCheckedIn` | **optional** | Routine, high-frequency, per-visit; opt-out is a legitimate user need at `CFG-3` volumes | `[RECOMMENDED — SELF-SELECTED EXPERT DECISION]` |
| 7 | `attendance.FraudSignalDetected` | **mandatory** | ⭐ **Security-significant** — the frozen `AUTH-8.52` category; an anti-proxy signal must not be silenceable | `[DERIVED]` |
| 8 | `seating.SeatAssigned`/`Released`/`Transferred` | **mandatory** | Changes what the student may occupy | `[DERIVED]` |
| 9 | `seating.OccupancyThresholdCrossed` | **optional** | Operational telemetry to staff; no entitlement or security effect | `[RECOMMENDED — SELF-SELECTED EXPERT DECISION]` |
| 10 | `fee.FeeDueRaised` | **mandatory** | Financial obligation arising (`MP-GBR-24`) | `[DERIVED]` |
| 11 | `fee.FeePaymentReceived` | **mandatory** | Financial receipt | `[DERIVED]` |
| 12 | `safety.AbuseReportFiled` | **mandatory** | Safety/moderation duty. ⚠ **Recipient** identity is the emitter's (`BC-13`), not `BC-22`'s — `NTF-GAP-004` closed on that basis | `[DERIVED]` |
| 13 | `billing.SubscriptionActivated`/`Cancelled`/`PaymentFailed` | **mandatory** | Tenant entitlement and payment state | `[DERIVED]` |

⛔ **What this matrix does NOT decide:** reminder **timing** (`NTF-GAP-003`, **PO**) and moderator **recipient** identity (the emitter's, per BC Map **L432** and `BC-13`'s §8 row). ⚠ **Three entries are expert recommendations, not derivations**, and are labelled so a Product Owner can overturn any of them without touching the other ten.

#### 20.7 ⭐ Why the dispatch rate limb is NOT a `PRD-010` configurable

⭐⭐ **The audit asked the wrong question first.** *"Which rate number?"* has no answer in this repository; *"whose parameter is a rate?"* does.

| Rate precedent | Subject it bounds | Transfers? |
|---|---|---|
| `CFG-1` (5/number/hour) · `CFG-3` (100/origin/hour) · `CFG-11` (5/24 h) | ⛔ **adversary** — OTP guessing, SMS cost, claim abuse | ⛔ No |
| `ICFG-7` (20/library/hour) · `ICFG-8` (20/origin/hour) · `ICFG-9`/`ICFG-10` | ⛔ **adversary / enumeration**, then throttle | ⛔ No |
| `LCFG-12` (page size 20) | ⛔ *"Bounds **enumeration** rate"* | ⛔ No |
| `BC-11` `RateLimitCounter` | ⛔ friend-request abuse, **`BC-11`-owned** | ⛔ No |

⇒ ⭐⭐ **Every rate value in the repository bounds an adversary or an enumeration. None bounds legitimate throughput of a system-initiated dispatch.** Borrowing one would import a security-throttle rationale into a capacity parameter — the same category error this document already refused when it declined `AUTH-3.9`'s `5`.

⭐ **And Rank 4 already assigns the subject elsewhere:** `Quota` is a `Tenant` entity (**`BC-19`**, BC Map **L381**); `UsageCounter` and `Limit` are `EntitlementSet` entities (**`BC-21`**, **L383**); outbound pacing sits with **`BC-31`** (**L140** — *"retries, idempotent delivery"*). With FROZEN **`FIL-XC-009`** forbidding a module from defining another's configuration default or range, a rate published here would be `BC-22` setting another context's limit.

⛔ **This is not a claim that no rate limit should exist** — only that **this PRD is not its home**. ⛔ **No number is proposed, here or to the owning contexts.**

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
| **`NTF-FR-065`** | ⭐⭐ **RESTATED at v0.12 as a TESTABLE EMISSION OBLIGATION, not a target.** `BC-22` **MUST** emit, per tenant, delivery-outcome telemetry sufficient to compute an availability SLI — **attempted**, **succeeded**, **failed-terminal** and **suppressed-duplicate** counts — over `platform/observability:telemetry`, carrying ⛔ **no** `StudentRecordId`, mobile number or template body. ⛔ **No numeric target, threshold or error budget is published here**: Rank 1 `MP-NFR-01` assigns those to **SRE/Observability**, `SRE-GAP-001` is OPEN, and `ADR-0033` §7.1 bars reusing `ADR-0102`. ⇒ `NTF-GAP-020` remains **`[OWED — SRE]`** for the **target** only. `[EVIDENCE]` `MP-NFR-09`; `ADR-0109` §7 |

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
| ⭐ **`NTF-XC-007`** | `BC-22` **MUST NOT** emit an audit event, a `DeliveryMessage`, a `FeedItem` or any stored record for use of the external WhatsApp redirect. It is a **UI action over already-visible contact data** (`NTF-FR-023`) and is **not** a `BC-22` auditable action (`NTF-FR-028`). `[EVIDENCE]` FROZEN `AUD-FR-003` / `AUD-XC-011`; `ADR-0109` §2 |
| ⭐ **`NTF-XC-008`** | `BC-22` **MUST NOT** define, default, range or publish a **dispatch rate limit, send-rate or throughput quota**. Tenant-scoped quota is **`BC-19`**'s (`Quota`; BC Map **L128**, **L381**), metered usage limits are **`BC-21`**'s (`UsageCounter`, `Limit`; **L383**), and outbound provider pacing is **`BC-31`**'s (**L140** — *"retries, idempotent delivery"*). ⛔ Publishing a rate here would be this module setting another context's limit — the `FIL-XC-009` prohibition. `[EVIDENCE]` `ADR-0110` §2 |

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
| ~~`NTF-GAP-007`~~ | ✅ **CLOSED at v0.13** — the **ceiling** is ratified (200 / 1–500, `ADR-0108` §7.1) and the **rate limb is WITHDRAWN** as `NTF-XC-008`: Rank 4 assigns quota to `BC-19`, metered limits to `BC-21` and outbound pacing to `BC-31` (`ADR-0110` §2) | **Product Owner** (ceiling) | Bulk dispatch |
| `NTF-GAP-008` | The permission matrix requires `BC-18` authority | **Authorization owner** | §11 |
| `NTF-GAP-009` | Whether scheduling is V1 | **Product Owner** | Scheduling |
| `NTF-GAP-010` | ⚠ **NARROWED at v0.12** — V1 placement is **settled** (§5 non-scope, derived from `NTF-FR-018`). ⛔ Only the **V2 scope question** remains | **Product Owner** | Two-way surface |
| ~~`NTF-GAP-011`~~ | ✅ **CLOSED at v0.11 — EXCLUDED.** `messaging.MessageSent` is **not routed to `BC-22`** (BC Map **L431**); unread-message notification therefore has **no lawful V1 trigger**. Architecture Owner ratification of the evidence, `ADR-0108` §6 | **Architecture Owner** | Chat notifications |
| ~~`NTF-GAP-012`~~ | ✅ **CLOSED at v0.12 `[DERIVED]`** — FROZEN `AUD-FR-003`/`AUD-XC-011` bar `BC-24` from deciding another context's auditable-action list, so this had been routed to a role that cannot answer it. `BC-22` defines its own list; the redirect is **not** on it (`NTF-XC-007`) | **`BC-22`** (was mis-assigned to `BC-24`) | `NTF-FR-028` |
| ~~`NTF-GAP-013`~~ | ✅ **CLOSED at v0.12 `[DERIVED]`** — the redirect creates no `BC-22` aggregate (`NTF-FR-023` + `ADR-0107` §3.1), so `BC-22` **declines ownership**; the affordance is `BC-01`'s profile surface | **Architecture Owner** (derivation recorded, `ADR-0109` §3) | §14 ownership |
| `NTF-GAP-014` | Language/localization set | **Product Owner** | Templates |
| `NTF-GAP-015` | Mandatory vs optional classification | **Product Owner** | Opt-out |
| `NTF-GAP-016` | `BC-25` ownership is **contested** | **Architecture Owner** | `NTF-FR-041` |
| `NTF-GAP-017` | ⚠ **NARROWED at v0.13** — `NTF-FR-044` is now **testable** on `BC-22`'s own durable `BC-31` acknowledgement record (`NTF-AC-013`), so this no longer blocks Gate 1. ⛔ Only the question whether a provider acknowledgement **additionally implies device receipt** remains | **`[OWED — EXTERNAL EVIDENCE]`** | Push semantics |
| `NTF-GAP-018` | Retry/backoff/dedup-window values | **Architecture Owner** | Retry |
| `NTF-GAP-019` | Platform vs tenant configuration keys | **Architecture Owner** | §20 |
| `NTF-GAP-020` | ⚠ **NARROWED at v0.12** — the **instrumentation** is now a testable obligation (`NTF-FR-065`, `NTF-AC-012`). ⛔ Only the numeric **SLO/SLI target** remains, needing a **fresh** SRE conferral | **SRE/Observability** | Observability |
| ⭐⭐ `NTF-GAP-028` | **`NTF-OBD-001`** — the **numerical** lower and upper bounds of the `FeedItem` lifetime, and therefore of dedup retention. `BCM-22-INV-1` fixes durability, **not** lifetime. ⛔ **No value invented** (`ADR-0108` §4.3) | **Architecture Owner** | Retention |
| ⭐⭐ `NTF-GAP-029` | **`NTF-RTD-001` — RUNTIME DEFECT, not a config gap.** `services.dart` **L193** checks the deadline only *between* attempts and **L207** leaves `await work()` **unbounded**, defeating the contract's *"`deadline` bounds the whole job"* (`job_runtime.dart` **L105-107**). Fix = bound the awaited call. ⛔ **Not fixed here; 0 code lines changed** (`ADR-0109` §4.4) | **Architecture Owner** + Implementation lead | Runtime |
| ⭐ `NTF-GAP-021` | Push depends on `PRD-019` — **v0.4 `DRAFT`, 111 `ITG-*` identifiers**, ⛔ not architecture-reviewed, not frozen | **Product + Architecture Owner** | V1 Push delivery guarantees |
| `NTF-GAP-022` | Tenant suspended mid-dispatch | **Architecture Owner** | Edge case |
| `NTF-GAP-023` | Same `eventId`, different payload | **Architecture Owner** | Dedup |
| ⭐⭐ `NTF-GAP-027` | ⭐⭐ **NARROWED at v0.8 — limbs 1 and 2 RESOLVED by existing authority (§20.3e); ONLY LIMB 3 REMAINS OPEN.** Limb 1 (one clock or two) is resolved: deferral and cancellation occur **pre-submission** in `queued` (`NTF-FR-014`, `NTF-FR-046`, `NTF-FR-048`), so **one transport clock suffices**. Limb 2 (terminal mapping) is resolved: the port declares `JobState` *"**deliberately not the same enum**"* as a domain lifecycle — *"a job is the **mechanism**; the object lifecycle is the **domain fact**"* (`job_runtime.dart` **L45-51**) — and `DeliveryMessage` is `BC-22`-owned (BC Map **L205**), so **no mapping is required**. ⛔ **LIMB 3 STILL OPEN:** quiet hours have **0** configuration slots although Rank-1 `MP-GBR-35` and BC Map **L131** assign them to `BC-22` while **EA L1447** places them at **V2** — a `MP-CON-08` *"defect to be raised, not a choice to be made"*. **Original text retained below for audit.** ⛔⛔ **THE DELIVERY CLOCK IS STRUCTURALLY UNDER-SPECIFIED — three coupled defects found by adversarial audit (§20.3d).** (1) A single `JobRuntime` deadline **cannot** express `NTF-FR-039`'s *"defer, never drop"*: a notification deferred overnight by quiet hours would exceed any delivery-sized deadline and terminate `failed`, **turning a defer obligation into a DROP** ⇒ the clock must be **two** bounds, not one. (2) §18's four terminal states (`delivered`/`failed`/`expired`/`cancelled`) have **no mapping** onto `JobState`'s **two** (`succeeded`/`failed`), and `failed` conflates *"attempts exhausted **or** the deadline expired"* (`job_runtime.dart` **L62-63**) ⇒ `NTF-FR-042` monotonicity and `NTF-FR-064` observability cannot be satisfied without a declared mapping. (3) ⚠ **Quiet hours have 0 configuration slots** although Rank-1 `MP-GBR-35` and BC Map **L131** assign them to `BC-22`, while EA **L1447** places them at **V2** — a Rank-1/Rank-6 disagreement which `MP-CON-08` makes *"a defect to be raised, not a choice to be made"*. ⇒ ⭐ **No arithmetic over repository values can supply the missing distinction — it is CATEGORICAL** | **Architecture Owner** | `NTF-CFG-004`, `NTF-CFG-007`, `NTF-FR-039`, `NTF-FR-042`, `NTF-FR-064` |
| ⭐ `NTF-GAP-026` | ⭐⭐ **No delivery job deadline exists** (`NTF-CFG-007`), yet the `JobRuntime` contract **requires** one on every submission (`job_runtime.dart` **L105-107**). ⇒ `NTF-CFG-004`'s attempt count is **unbounded in time** and its upper bound is **underivable** until this is set — the `FIL-CFG-015` (120 s) companion that let `PRD-017` derive **3** has **no analogue here** | **Architecture Owner** | `NTF-CFG-004`, `NTF-CFG-007`, `NTF-FR-042` |
| ⭐ `NTF-GAP-025` | ⚠ **Does a failed notification delivery require a dead-letter path?** BC Map **L452** (Rank 4) mandates *"Retry with backoff → **Dead Letter Queue**"* for the **event backbone**; `PRD-010` has **0** DLQ occurrences and `BC-28`, which *"owns … DLQ"* (**L137**), is **V2**. ⇒ Is L452 discharged for the **outbound channel plane** by `NTF-FR-047`'s terminal `failed` plus `NTF-FR-064` observability, or is a DLQ required? | **Architecture Owner** | `NTF-FR-047`, `NTF-CFG-005` |
| ⭐ `NTF-GAP-024` | ⚠ **May a `BC-22` template consume the Library-scoped `LCFG-2` value?** §20.2 cites `LCFG-2` as the authoritative **value** for `NTF-CFG-002`, but **cross-context consumption of an `LCFG-*` slot is unruled** — `ADR-0017` **§2.5** notes the `LCFG-*` set *"currently live in the **Library** PRD"* and assigns only their *resolution semantics* to `PRD-023` | **Architecture Owner** | `NTF-CFG-002` |

---

## 29. Acceptance criteria (sample — the register is deliberately incomplete)

⚠ **Coverage is measured, not claimed: 9 criteria against 85 obligation-bearing identifiers (10.6%).**
The register is a **sample** and Stage 5 will require bidirectional coverage. ⭐ **Every criterion now
names the requirement it verifies**, so Stage-4 check 4 (*"every acceptance criterion maps to a
requirement"*) is satisfiable by inspection rather than by inference.

| ID | Criterion | ⭐ Verifies |
|---|---|---|
| `NTF-AC-001` | Given a `MembershipExpiringSoon` event delivered twice with the same `eventId`, when processed, then exactly **one** user-visible notification exists and the suppression counter increments by 1. | `NTF-INV-007`, `NTF-FR-045` |
| `NTF-AC-002` | Given a dispatch preview showing N recipients, when one loses eligibility before confirmation, then that recipient receives nothing and the operation reports N−1 sent. | `NTF-FR-011`, `NTF-FR-015` |
| `NTF-AC-003` | Given an actor in tenant A, when any audience is resolved, then no recipient from tenant B appears — verified by a cross-tenant fixture. | `NTF-INV-008`, `NTF-INV-010` |
| `NTF-AC-004` | Given any emitted `BC-22` event or payload, when inspected, then it contains no mobile number. | `NTF-FR-058` |
| `NTF-AC-005` | Given a Reception Staff account with no explicit grant, when Send-to-All is attempted, then it is denied and the denial is audited. | ⚠ §11 matrix — **`NTF-GAP-008`** |
| `NTF-AC-006` | Given the WhatsApp redirect is used, when communication history is queried, then no WhatsApp message record exists. | `NTF-FR-063` |
| `NTF-AC-007` | Given a guardian outside `guardianOf` for a student, when a notice for that student is produced, then the guardian receives nothing and the denial is indistinguishable from not-found. | `NTF-FR-057`, `NTF-FR-056` |
| `NTF-AC-008` | Given a transient channel failure, when retried to success, then exactly one user-visible notification exists. | `NTF-FR-047`, `NTF-INV-007` |
| ⭐⭐ `NTF-AC-009` | Given a business operation that emits a fact over `E-23`, when the notification address for a recipient **cannot be resolved**, then that delivery record terminates as `failed`, **and** the originating business operation remains successful and un-rolled-back — verified by asserting the emitting aggregate's post-state is unchanged from the success path. `[EVIDENCE]` `NTF-INV-011`, `CM-3`, `EBR-1030` | ⭐⭐ `NTF-INV-011` |
| ⭐⭐ `NTF-AC-010` | Given a `FeedItem` F and its deduplication record D for key `(eventId, recipientId, channel, templateId)`, when F exists, then D exists **and** a redelivery of the same `eventId` is suppressed; and when F ceases to exist, then D is absent **and** a subsequent delivery bearing the same key is processed as new. ⚠ **Both ends are asserted deliberately** — under a floor-only wording an implementation retaining D **forever** would pass, and *a criterion that cannot fail is not a test* (`ITG-AC-017`). | `NTF-FR-066`, `NTF-INV-007` |
| ⭐⭐ `NTF-AC-011` | Given a delivery submitted to the `JobRuntime`, when the submission is inspected, then a `deadline` is present **and** `deadline > NTF-CFG-004 x (BC-31 per-attempt bound)`; and a submission carrying no deadline, or one failing that inequality, is **rejected**. ⚠ **Stated now; becomes executable when `NTF-GAP-017` supplies the per-attempt bound** — recorded as pending, not as passing. | `NTF-FR-067`, `NTF-CFG-004` |
| ⭐⭐ `NTF-AC-012` | Given any completed delivery attempt, when telemetry is inspected for that tenant, then the **attempted**, **succeeded**, **failed-terminal** and **suppressed-duplicate** counters all exist and are non-null, **and** no emitted telemetry record contains a `StudentRecordId`, a mobile number or a template body. ⚠ **Falsifiable without any SLO** — a missing counter fails, and a leaked identifier fails. | `NTF-FR-065` |
| ⭐⭐ `NTF-AC-013` | Given a Push `DeliveryMessage`, when `BC-22` has durably recorded a successful `BC-31` acknowledgement, then its state is `delivered`; and when the acknowledgement is absent or unsuccessful, then its state is **not** `delivered`. **And** no user-facing surface, API field name, label or document describes `delivered` as meaning the notification reached a device, was displayed or was seen. ⚠ **Both limbs are falsifiable today and neither asserts a provider fact.** | `NTF-FR-044`, `NTF-FR-043` |

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

Registers, **re-measured at v0.13** (`grep -o | sort -u`, not asserted): `NTF-FR-*` (**67**) ·
`NTF-BR-*` (**3**) · `NTF-INV-*` (**11**) · `NTF-XC-*` (**8**) · `NTF-AC-*` (**13**) ·
`NTF-GAP-*` (**29**) · `NTF-CFG-*` (**7 declared — 5 configurable, 2 withdrawn as NOT configurable**). ⚠ **Counts are provisional; the AC register is
deliberately incomplete** and Stage 4 will require 1:1 obligation coverage.

⚠⚠ **Two counts published at v0.1a were STALE and are corrected here.** This subsection read
*"`NTF-INV-*` (10)"* and *"`NTF-AC-*` (8 sample)"*, but v0.2 added **`NTF-INV-011`** and
**`NTF-AC-009`** and did **not** update §31. Measurement returns **11** and **9**. ⭐ The defect is
disclosed rather than silently overwritten, because v0.1a's changelog entry expressly claimed *"all six
registers verified CONTIGUOUS and complete **by measurement**"* — a claim that a later amendment
falsified, and the honest remedy is to say so.

⭐ **`NTF-CFG-*` is a NEW register opened at v0.3** (§20.1), previously **0** occurrences. It is
**reserved, not closed** — the `ADR-0048` distinction that keeps `PRD_LIFECYCLE.md` §5 rule 6
untriggered. Collision-checked: `NTF-CFG-` = **0** repository-wide before this version.

---

## 32. Changelog

| Version | Date | Change |
|---|---|---|
| **v0.13** | 2026-09-05 | ⭐⭐⭐ **THE FINAL TWO GATING BLOCKERS ARE RESOLVED — with no invented number and no asserted provider fact.** Authority: **`ADR-0110`**, which claims **no new authority act**. ⭐⭐⭐ **Blocker 1 — the dispatch RATE limb is WITHDRAWN from `NTF-CFG-001` as new `NTF-XC-008`, because the audit showed the question was never *"which number?"* but *"whose parameter?"*** New **§20.7** records the measurement: **every** rate value in this repository — `CFG-1`, `CFG-3`, `CFG-11`, `ICFG-7`…`ICFG-10`, `LCFG-12`, `BC-11`'s `RateLimitCounter` — bounds an **adversary or an enumeration**; ⛔ **none** bounds legitimate throughput of a system-initiated dispatch, so borrowing one would import a security-throttle rationale into a capacity parameter — the error this document already refused when it declined `AUTH-3.9`'s `5`. ⭐ And Rank 4 already assigns the subject: `Quota` to **`BC-19`** (**L381**), `UsageCounter`/`Limit` to **`BC-21`** (**L383**), outbound pacing to **`BC-31`** (**L140**) — with FROZEN **`FIL-XC-009`** forbidding a module from defining another's default or range. ⇒ **`NTF-CFG-001` is COMPLETE** on its ratified ceiling (**200**, range **1–500**) and **`NTF-GAP-007` CLOSES**. ⛔ **No rate number proposed — here or to the owning contexts** — and ⛔ **no PO approval claimed**: the limb is withdrawn on **Rank 4 ownership** grounds, not decided. ⭐⭐⭐ **Blocker 2 — `NTF-FR-044` is now TESTABLE WITHOUT ASSERTING ANY PROVIDER FACT.** On the accepted **`ITG-FR-019`** shape (*"**MUST** return `2xx` when, **and only when**, it has durably accepted the event"*), `delivered` is redefined by **`BC-22`'s own durable record** of a successful `BC-31` acknowledgement — ⛔ **with an express prohibition on presenting it as evidence that the notification reached a device, was displayed or was seen.** That prohibition is the honest half: it refuses the false equivalence *acknowledgement = device delivery* rather than resolving it by assumption, and it is consistent with already-ratified `NTF-FR-043`. New **`NTF-AC-013`** tests **both** limbs, and both are falsifiable today. ⇒ **Gate 1's last `[OPEN]` obligation row is removed — 0 remain.** ⚠ **`NTF-GAP-017` NARROWED, not closed** — only whether a provider acknowledgement *additionally implies device receipt* stays **`[OWED — EXTERNAL EVIDENCE]`**, and it no longer blocks a gate. ⛔ **0 FCM semantics, timeouts or TTLs invented.** Registers re-measured mechanically: **FR 67 · BR 3 · INV 11 · XC 8 · AC 13 · GAP 29 · CFG 7 declared (4 in-scope configurables, all complete)**, contiguous, 0 collisions. ⛔ **`ADR-0107`/`0108`/`0109` NOT reopened · BC Map NOT modified · 0 frozen PRDs modified (`PRD-017`, `PRD-019` cited as authority) · 0 Rank 1–2 changes · 0 `CONFIGURATION_GUIDE` · 0 `TRACEABILITY_MATRIX` · 0 `IMPL-*` · 0 baseline · 0 registry (`PLANNED`) · 0 application or test code.** ⛔⛔ **Stage 4 remains NOT CONFERRED** — the substantive obstacle is gone, the procedural one is not: conferral is the **Requirements Reviewer**'s act (`PRD_LIFECYCLE.md` §6 **L278**), and `ADR-0104` holds that *"appointing a reviewer is not performing a review"*. ⛔ **Stage 5 NOT ENTERED.** Status remains **`DRAFT`**. |
| **v0.12** | 2026-09-05 | ⭐⭐⭐ **AUTONOMOUS EXPERT RESOLUTION — every remaining blocker that repository evidence can settle is settled, and the four that genuinely cannot are named with the reason.** Authority: **`ADR-0109`**, which claims **no new authority act** — each closure is `[DERIVED]` from an accepted or FROZEN artefact, or labelled `[RECOMMENDED — SELF-SELECTED EXPERT DECISION]`, on the `PRD-019` v0.4 precedent that closing a check *"under EXISTING authority"* creates no new decision. ⭐⭐⭐ **`NTF-GAP-012` CLOSED — and closing it required correcting THIS repository's own owner assignment.** It had been routed to the *"`BC-24` owner"*, but FROZEN **`AUD-FR-003`** (`PRD-016` **L123-125**) provides that `BC-24` *"**SHALL NOT** decide **what** is auditable in another bounded context — **each emitting context defines its own auditable-action list**"*, reinforced by **`AUD-XC-011`** (**L277**). ⇒ **the gap was waiting on a role FROZEN text forbids to answer it.** `BC-22` defines its own list; the redirect is not on it — recorded as new **`NTF-XC-007`**, a falsifiable exclusion, with ⛔ **no audit event invented**. ⭐⭐ **`NTF-GAP-013` CLOSED** — `NTF-FR-023` makes the redirect create **no** `DeliveryMessage`, and `ADR-0107` fixes `BC-22`'s aggregates as `FeedItem`/`DeliveryMessage`; an artefact that is neither cannot be `BC-22` state, so `BC-22` **declines ownership** and the affordance is `BC-01`'s. ⛔ **Nothing written into `BC-01`.** ⭐⭐⭐ **`NTF-CFG-007` RECLASSIFIED from a user-configurable value to a RUNTIME CONTRACT** — BC Map **L140** gives **`BC-31`** *"outbound third-party contracts, credentials, **retries**, idempotent delivery"* and `NTF-XC-006` forces push egress through it, so a `BC-22` operator-tunable **provider** timeout would breach both. New **`NTF-FR-067`** states the obligation (`deadline > NTF-CFG-004 × BC-31 per-attempt bound`) and **`NTF-AC-011`** tests it. ⛔ **No default or range published**; the provider number stays `[OWED — EXTERNAL EVIDENCE]`. ⚠⚠ **`NTF-RTD-001` documented SEPARATELY as a RUNTIME DEFECT (`NTF-GAP-029`)**, not hidden inside the config slot: `services.dart` **L193** checks the deadline only *between* attempts and **L207** leaves `await work()` **unbounded**, defeating *"`deadline` bounds the whole job"* — ⛔ **not fixed, 0 code lines changed.** ⭐⭐ **`NTF-FR-065` MADE TESTABLE WITHOUT AN SLO** — restated as a per-tenant telemetry **emission** obligation (attempted/succeeded/failed-terminal/suppressed-duplicate, carrying no `StudentRecordId`, number or template body), tested by **`NTF-AC-012`**, on the `PRD-017` / `MP-NFR-09` precedent that the observability plane is *"never authoritative"*. ⛔ **No target, threshold or error budget**; `ADR-0102` **NOT** reused. ⭐ **`NTF-CFG-003` COMPLETE** — new **§20.6** classifies all **13** entries (10 mandatory, 3 optional): **10 `[DERIVED]`** (8 from entitlement/financial/account-lifecycle effect, 2 from the frozen `AUTH-8.52` security-significant category) and **3 labelled `[RECOMMENDED]`** so a PO can overturn any one without disturbing the rest. ⭐ **`NTF-GAP-004` CLOSED** — moderator recipient identity is the emitter's (`BC-13`), never `BC-22`'s. ⭐ **`NTF-FR-021`/`-022` placement CLOSED** — `-022` follows from its own `ADR-0108` exclusion, `-021` from ratified **`NTF-FR-018`** (*"MUST NOT initiate tenant communication"*); both are §5 non-scope, so **Gate 2's last open item is removed**. ⚠ **`NTF-GAP-010` and `NTF-GAP-020` NARROWED, not closed** — V1 placement and instrumentation are settled; only the V2 scope question and the numeric SLO target remain. ⛔⛔ **STILL GENUINELY OWED, and none is substitutable by judgment:** `NTF-GAP-017` FCM/`BC-31` per-attempt bound **`[EXTERNAL EVIDENCE]`** · `NTF-GAP-028`/`NTF-OBD-001` `FeedItem` numeric lifetime **`[AUTHORITY — AO]`** · `NTF-CFG-001` rate limb and `NTF-GAP-003` reminder timing **`[AUTHORITY — PO]`** · `NTF-GAP-020` target **`[AUTHORITY — SRE]`** · `NTF-GAP-029` runtime fix **`[AUTHORITY + implementation]`**. ⛔ **0 numbers invented.** Registers re-measured mechanically: **FR 67 · BR 3 · INV 11 · XC 7 · AC 12 · GAP 29 · CFG 7 declared (5 configurable)**, all contiguous, 0 collisions. ⛔ **`ADR-0107`/`ADR-0108` NOT reopened · BC Map NOT modified (§8 and §18 both untouched) · 0 frozen PRDs modified (`PRD-016` cited as authority) · 0 Rank 1–2 changes · 0 `CONFIGURATION_GUIDE` · 0 `TRACEABILITY_MATRIX` · 0 `IMPL-*` · 0 baseline · 0 registry (`PLANNED`) · 0 application or test code.** ⛔⛔ **Stage 4 NOT CONFERRED** — conferral is the **Requirements Reviewer**'s (`PRD_LIFECYCLE.md` §6 **L278**). ⛔ **Stage 5 NOT ENTERED.** Status remains **`DRAFT`**. |
| **v0.11** | 2026-09-05 | ⭐⭐⭐ **RATIFIED AUTHORITY APPLIED — the Architecture Owner's acts `AO-1`…`AO-10` and the Product Owner's acts `PO-1`, `PO-3`, recorded in **`ADR-0107`** and **`ADR-0108`**, are executed here.** ⭐⭐ **`BC-22` now has a declared aggregate structure**: two roots `FeedItem` · `DeliveryMessage` (BC Map **§18.1**, appended per the §15.5 precedent with **§8's table byte-unchanged**), with `BCM-22-R1` forbidding any cross-root transaction, `BCM-22-INV-1` fixing `FeedItem` durability/rebuildability and **non**-system-of-record status, and `BCM-22-INV-2` confining `read` to a `FeedItem`. ⚠⚠ **THE AUTHOR'S OWN L205 OVER-READING IS CORRECTED, NOT QUIETLY DROPPED:** v0.8–v0.10 asserted *"`DeliveryMessage` is a `BC-22`-owned aggregate (BC Map **L205**)"*. **L205 does not say that** — it is a **§5 Ubiquitous Language Collisions** row whose column is binding on *"the names that must appear in code, APIs"* (**L195**), **not** on aggregate structure; the declaration did not exist until `ADR-0107`. ⭐ **`NTF-CFG-004` RATIFIED conditionally** — 3 total attempts, range 1–5, unit *total attempts including the first*; the condition (representation consistent with the `JobRuntime` contract) is **verified satisfied** against `job_runtime.dart` **L113-114**. ⭐⭐ **`NTF-CFG-005` and `NTF-CFG-006` WITHDRAWN AS CONFIGURABLES** — backoff is NOT configurable in V1 (deferred V2); dedup retention is **FIXED**, bounded by the `FeedItem` lifetime, on the `SEAT-FR-202` / `ITG-FR-017` precedent and the `PRD-019` v0.4 route (*"no configurable to bound"*). ⇒ **check 3's target falls 7 → 5.** ⭐ **`NTF-FR-066` minted** stating that retention, and ⭐ **`NTF-AC-010` minted asserting BOTH ends** — presence while the `FeedItem` exists and **absence** after — because *"a criterion that cannot fail is not a test"* (`ITG-AC-017`). ⭐ **`NTF-GAP-011` CLOSED as EXCLUDED**: BC Map **L431** routes `messaging.MessageSent` to `BC-13`/`BC-26` only, so unread-message notification has **no lawful V1 trigger**; `NTF-FR-022` restated accordingly. ⭐ **`NTF-CFG-001` ceiling ratified 200 / 1–500** and **`NTF-CFG-003` allowed set ratified {mandatory, optional}**, with the FROZEN `AUTH-8.52`/`-9.29`/`-9.43`/`-9.76` MUST-notify duties recorded as making those classes non-opt-outable. ⛔⛔ **WHAT WAS EXPRESSLY NOT DECIDED, because the deciding acts withheld it:** `NTF-CFG-007` value (**`[OWED — AO]`**; ⛔ 120 s rejected; ⛔ must NOT be described as a latency cap while `services.dart` **L207** leaves `await work()` unbounded) · `NTF-CFG-001` **rate limb** · `NTF-CFG-003` **per-entry defaults** · `NTF-GAP-013` · `NTF-FR-021`/`-022` **§5 placement** · **any SLO** (`ADR-0102` **NOT** reused; `ADR-0033` §7.1). ⚠ **`NTF-GAP-028` / `NTF-OBD-001` OPENED rather than closed** — the numerical `FeedItem` lifetime bounds are an **unresolved bounded decision**, recorded instead of fabricated, exactly as the AO act required. ⛔ **0 numbers invented** beyond the two the PO and AO expressly supplied. Registers re-measured: **FR 66 · BR 3 · INV 11 · XC 6 · AC 10 · GAP 28 · CFG 7 declared (5 configurable)**. ⛔ **0 frozen PRDs modified, reopened or re-ranked · 0 Rank 1 changes · 0 `CONFIGURATION_GUIDE` bytes · 0 `TRACEABILITY_MATRIX` · 0 `IMPL-*` · 0 baseline · 0 registry (`PLANNED`) · 0 application or test code.** ⛔⛔ **Stage 4 remains NOT CONFERRED** — check 3 still **FAILS** on three limbs (`NTF-CFG-001` rate, `NTF-CFG-003` defaults, `NTF-CFG-007` value), and conferral is the **Requirements Reviewer**'s (`PRD_LIFECYCLE.md` §6 **L278**). ⛔ **Stage 5 NOT ENTERED.** Status remains **`DRAFT`**. |
| **v0.10** | 2026-09-05 | ⭐⭐ **STAGE-4 AGENT-ACTIONABLE CORRECTIONS ONLY — two defects fixed, and nothing requiring a human decision was touched.** ⭐⭐⭐ **Fix 1 — §29 gains a `Verifies` column, so all NINE acceptance criteria now name the requirement(s) they test.** Previously **8 of 9** carried no requirement identifier, so Stage-4 check 4 (*"every acceptance criterion maps to a requirement"*) could be satisfied only by a reader's inference. Mappings were **measured, not guessed** — every target was located and read before it was cited: `NTF-AC-001`→`NTF-INV-007`/`NTF-FR-045`; `-002`→`NTF-FR-011`/`-015`; `-003`→`NTF-INV-008`/`-010`; `-004`→`NTF-FR-058`; `-006`→`NTF-FR-063`; `-007`→`NTF-FR-057`/`-056`; `-008`→`NTF-FR-047`/`NTF-INV-007`; `-009`→`NTF-INV-011`. ⚠⚠ **`NTF-AC-005` is the honest exception and is labelled as such rather than force-mapped:** it tests the §11 permission matrix, which is expressly **`[PROPOSED]`** and registered as **`NTF-GAP-008`** pending `BC-18`'s authority — so its cell cites the **gap**, not a requirement. ⛔ **Inventing a requirement for it, or quietly pointing it at an unrelated one, would convert a missing authority into apparent coverage** — exactly what check 4 exists to prevent. ⭐ The heading now states coverage **9/85 = 10.6%** by measurement, replacing the stale *"not complete at v0.1"*. ⭐⭐ **Fix 2 — six rows labelled `[OPEN]`, because they are GAP-POINTERS, not requirements:** `NTF-FR-021` (`NTF-GAP-010`), `-022` (`NTF-GAP-011`), `-028` (`NTF-GAP-012`), `-029` (`NTF-GAP-013`), `-044` (`NTF-GAP-017`), `-065` (`NTF-GAP-020`). Each states that a decision is **absent**; none states an obligation, so check 1 (*"every requirement testable"*) was being measured against text that **cannot** be testable by construction. Labelling makes the register self-describing. ⛔⛔ **THIS IS DELIBERATELY NOT A FIX OF THE UNDERLYING GAPS, and that distinction is the point:** `NTF-FR-044` still awaits FCM's acknowledgement model (absent documentation — the `ADR-0045` condition); `NTF-FR-065` still awaits a **fresh** SRE conferral (`ADR-0033` §7.1 bars reusing `ADR-0102`); `-021`/`-022`/`-028`/`-029` still await Product/Architecture rulings. **All six gaps remain OPEN, owners unchanged.** Re-wording a missing decision into text that reads complete is expressly refused. ⛔ **0 requirements reworded, retired, renumbered or re-scoped; 0 obligations added or removed; 0 identifiers minted** — all seven registers verified unchanged (**FR 65 · BR 3 · INV 11 · XC 6 · AC 9 · GAP 27 · CFG 7**), and the §29 table verified well-formed at exactly **3 columns** per row. ⛔ **0 configuration values changed or promoted** — `NTF-CFG-001`/`-003`/`-005`/`-006`/`-007` stay **[OWED]**; `NTF-CFG-004` stays **[RECOMMENDED]** with unit and floor **[AUTHORITATIVE]**; `NTF-CFG-002` unchanged. ⛔ **0 gaps closed (27 OPEN) · 0 stages entered or conferred · 0 ADRs (94) · 0 manifest · 0 `TRACEABILITY_MATRIX` · 0 `IMPL-*` · 0 baseline · 0 registry (`PLANNED`) · 0 BC Map · 0 `MASTER_PRD` · 0 EA · 0 `CONFIGURATION_GUIDE` · 0 frozen PRDs · 0 application code · 0 test code.** ⚠ The two content fixes above were captured by a **tenth platform auto-backup** (`a685915`) during an interruption; content verified byte-correct, message not the author's, **disclosed rather than amended**. ⛔ **Stage 4 remains NOT CONFERRED** — conferral is the **Requirements Reviewer**'s (`PRD_LIFECYCLE.md` §6 **L278**), and check 3 still **FAILS** on 6 of 7 slots. Status remains **`DRAFT`**. |
| **v0.9** | 2026-09-05 | ⚠⚠ **SELF-AUDIT OF MY OWN v0.8 CITATIONS — TEN LINE REFERENCES WERE WRONG AND ARE CORRECTED; the substance is unaffected and the error is disclosed rather than quietly fixed.** v0.8 rested its central holdings on the `JobRuntime` contract and cited two passages by line. **Both citations were off by one to three lines**, measured by `grep -n` rather than re-asserted: the retry-unit sentence (*"`retryBudget` is the **total** attempts permitted, **including the first**"*) is at **L103-104**, not *L104-106*; and the deadline sentence (*"`deadline` bounds the whole job; on expiry the runtime moves it to `JobState.failed`"*) is at **L105-107**, not *L107-110*. ⛔ **Ten occurrences corrected in this document** (4 + 6). ⭐ **Why this mattered enough to version the document:** every load-bearing claim in v0.4–v0.8 — that the unit is repository-authoritative rather than borrowed from `FIL-CFG-014`, and that one transport clock suffices — depends on a reader being able to **open the file and see the sentence**. A citation that does not resolve is indistinguishable from an invented quotation, which is the precise failure this engagement refuses elsewhere. ✅ **The QUOTED TEXT was verified verbatim and is correct in every instance**; only the line numbers moved, so **0 findings, 0 verdicts and 0 values change**. ⭐ **Four other citations re-verified and CONFIRMED correct**: `job_runtime.dart` **L45-51** (*"**Deliberately not** the same enum … a job is the **mechanism**; the object lifecycle is the **domain fact**"*) — ⚠ a first probe reported 0 hits and was a **false alarm caused by case-sensitivity** (`Deliberately`), cleared by re-measurement rather than acted on; **L62-63** (`failed` conflates *"attempts exhausted, **or the deadline expired**"*); **L82** (*"Attempts consumed, **including the first**"*); BC Map **L205** (`DeliveryMessage` is `BC-22`'s); `services.dart` **L152-159** (`ArgumentError` on `retryBudget < 1`) and **L163-165** (duplicate `JobKey` short-circuit). ⛔⛔ **NOTHING SUBSTANTIVE CHANGED: the clock model is still ONE transport clock, the lifecycle still needs NO mapping, `NTF-CFG-004` is still `[RECOMMENDED]` 3 with range 1–5 and its value still OWED, `NTF-CFG-007` is still OWED, backoff still OWED, `NTF-GAP-025` still OPEN and non-blocking, `NTF-GAP-027` limb 3 still OPEN.** ⛔ **0 values invented; 0 slots minted (`NTF-CFG-*` stays 7); 0 gaps closed (27 OPEN); 0 identifiers minted or renumbered; 0 requirements reworded; 0 ACs changed; 0 ADRs (94); 0 manifest; 0 BC Map; 0 `MASTER_PRD`; 0 EA; 0 matrix; 0 `CONFIGURATION_GUIDE`; 0 frozen PRDs; 0 baseline; 0 registry (`PLANNED`); 0 `IMPL-*`; 0 lines of application or test code.** ⛔ **Stage 4 NOT READY, NOT CONFERRED**; Stage 3 **PASS 6/6**. Status **`DRAFT`**. |
| **v0.8** | 2026-09-05 | ⭐⭐⭐ **§20.3d's OWN DISPROOFS 1 AND 2 ARE THEMSELVES DISPROVED — v0.7 declared STOP CONDITION B on a hypothesis it never tested, and the resolution needed NO new authority.** ⛔ v0.7 assumed `DeliveryMessage`'s lifecycle and the `JobRuntime` job are the **same object**. They are not, and **the port contract says so in its own words** — a contract v0.7 was reasoning *about* without reading this passage. ⭐⭐⭐ **DISPROOF 2 DISSOLVES:** `job_runtime.dart` **L45-51** states `JobState` is *"**deliberately not the same enum** as a File & Media object lifecycle (`RECEIVED → VALIDATING → PROCESSING → READY | FAILED`) … **a job is the mechanism; the object lifecycle is the domain fact**. Fusing them would put media semantics into a platform port."* ⇒ **there is no "2 → 4 mapping problem" because no mapping is required** — `PRD-017` already runs a **five**-state lifecycle over the same two-state job **by design**, and `DeliveryMessage` is a **`BC-22`-owned aggregate** (BC Map **L205**), so §18's states are `BC-22`'s **domain** state while `JobState` is one attempt-run's **mechanism** state; `JobOutcome.reasonCode` (`deadline_exceeded` vs `retries_exhausted`) is the **input** `BC-22` uses, not a competing lifecycle. ⭐⭐⭐ **DISPROOF 1 DISSOLVES:** §18's order is `created → **queued** → processing → sent`, and **`NTF-FR-014`** makes a dispatch cancellable *"while any recipient remains in **`queued`**"*, **`NTF-FR-046`** claims the idempotency record *"**before dispatch**"*, **`NTF-FR-048`** protects work already `sent` ⇒ ⭐⭐ **`queued` is a PRE-SUBMISSION `BC-22` state**, so quiet-hours deferral, cancellation and scheduling all happen **before any job exists** and **the deadline only starts when `BC-22` submits at the end of the quiet window** ⇒ ⛔ **the "deferred overnight → deadline blown → `failed`" scenario CANNOT ARISE.** ⇒ ⭐⭐ **ONE CLOCK IS SUFFICIENT and is the SMALLEST architecture satisfying every requirement**: `NTF-CFG-007` is a **transport/attempt-run deadline**, not a validity horizon; ⛔ **the v0.5 "split the slot" proposal is WITHDRAWN as unnecessary** — it would have added a configurable to solve a problem created by conflating a pre-submission domain state with a running job. ⚠ **Two falsifiable consequences stated rather than left implicit:** (1) **`expired` is a `queued`-side domain concern**, reachable **without any job running**, so whether a validity horizon exists at V1 is a **product** question about `NTF-FR-039` and ⛔ **no horizon value is proposed**; (2) **`cancelled` never needs runtime representation** because `NTF-FR-014` bounds cancellation to `queued` — once submitted, cancellation is **out of scope by construction**, a **stronger** guarantee than any mapping. ⭐ **`NTF-GAP-027` NARROWED, NOT CLOSED** — limbs 1 and 2 resolved by **existing** authority; ⛔ **limb 3 remains OPEN** (quiet hours: **0** slots, Rank-1 `MP-GBR-35` vs **EA L1447** V2, a `MP-CON-08` defect **to be raised**), and closing it is an Architecture Owner act. ⭐⭐ **NET EFFECT ON THE BUDGET:** the ceiling inequality is now **well-formed** — *attempts × per-attempt duration ≤ **transport** deadline* — bounded by a **single** transport-scoped value instead of an undefined clock; ⛔ but the two quantities remain missing (`NTF-CFG-007` **OWED**; provider timeout **`NTF-GAP-017`**, absent FCM documentation) ⇒ **`3` / range `1–5` stands `[RECOMMENDED]`**, and `NTF-CFG-007` is now **one well-defined number awaiting one Architecture Owner decision** — materially smaller than v0.7 left open. ⛔⛔ **0 VALUES INVENTED: 0 deadlines, 0 horizons, 0 quiet windows, 0 attempt counts made authoritative, 0 backoff.** ⛔ **0 slots minted** (`NTF-CFG-*` stays **7**); ⛔ **0 gaps closed** (**27** OPEN — `NTF-GAP-027` narrowed with its original text **retained for audit**); ⛔ **0 identifiers minted or renumbered**; ⛔ **0 requirements reworded**; ⛔ **0 ACs changed**; ⛔ **0 lifecycle states added or removed**. ⛔ **0 ADRs (94)**; ⛔ **0** `module_dependencies.yaml`, BC Map, `MASTER_PRD`, matrix, EA, `CONFIGURATION_GUIDE`, frozen PRDs, baseline, registry (`PLANNED`), `IMPL-*`; ⛔ **0 lines of application or test code** — `job_runtime.dart` **read as evidence only**. ⛔ **Stage 4 NOT READY, NOT CONFERRED**; Stage 3 **PASS 6/6**. Status **`DRAFT`**. |
| **v0.7** | 2026-09-05 | ⛔⛔ **ADVERSARIAL AUDIT OF MY OWN §20.3c RECOMMENDATION — THE NUMBER SURVIVES, THE FRAMING DOES NOT.** A pass run specifically to **disprove** v0.6 confirmed `3` / range `1–5` / unit *total attempts incl. first* / floor `≥ 1`, and confirmed that **more attempts without backoff buys provider load rather than resilience**. ⛔ **But THREE structural defects were found that §20.3c never contemplated, and the first two make `NTF-CFG-007` — as I FRAMED IT — UNANSWERABLE rather than merely owed.** ⭐⭐⭐ **DISPROOF 1 — a single `JobRuntime` deadline CANNOT express a deferrable notification.** `NTF-FR-039` requires quiet hours to *"**defer, never drop**"*, and quiet hours are by nature **hours**; but the runtime deadline *"bounds the **whole job**; on expiry the runtime moves it to `JobState.failed`"* (`job_runtime.dart` **L105-107**). ⇒ a notification deferred overnight would blow **any** delivery-sized deadline and terminate `failed`, **converting a defer obligation into a DROP**. ⇒ ⛔ **the clock must be TWO bounds, not one** — an **attempt/transport budget** (which is what actually bounds `NTF-CFG-004`) and a **notification validity horizon** (which `NTF-FR-039` and the `expired` state require). ⭐ **`NTF-CFG-007` was therefore UNDER-SPECIFIED BY ITS OWN AUTHOR at v0.5**, and any value chosen against the old framing would have silently broken a stated requirement. ⭐⭐ **DISPROOF 2 — the lifecycle terminals do not map onto `JobState`.** §18 declares **four** terminals (`delivered`/`failed`/`expired`/`cancelled`); `JobState` has exactly **two** (`succeeded`/`failed`), and `failed` **conflates two causes** — *"attempts exhausted, **or the deadline expired**"* (**L62-63**). ⇒ `expired` and `cancelled` have **no runtime representation**, yet `NTF-FR-042` monotonicity and `NTF-FR-064` observability both depend on distinguishing them — the same distinction `CONFIGURATION_GUIDE` **L892** insists on for `PRD-017` (*"moved to `FAILED` **by timeout**, distinct from failure by error"*). ⭐ `JobOutcome.reasonCode` (`deadline_exceeded` vs `retries_exhausted`, `services.dart` **L197**/**L226**) is the available carrier, but **the 2→4 mapping is an unmade architecture decision**. ⚠ **DISPROOF 3 — quiet hours have ZERO configuration slots** (measured: 0 occurrences of *"quiet"* in §20.1) although **Rank-1 `MP-GBR-35`** and **BC Map L131** assign them to `BC-22`, while **EA L1447** places *"Quiet Hours & DND"* at **V2**; per **`MP-CON-08`** the EA is *"descriptive, not prescriptive"* and such a disagreement is *"**a defect to be raised, not a choice to be made**"* ⇒ ⭐ **raised, NOT resolved**, and ⛔ **no quiet window invented and no slot minted**, since minting one would presuppose the V1/V2 answer. ⇒ ⭐⭐⭐ **REVISED CONCLUSION — STOP CONDITION B (PROVEN INSUFFICIENCY), not caution:** the retry budget is **not** blocked by an unknown *number* but by an **unmade STRUCTURAL decision** — whether the delivery clock is one bound or two, and how four lifecycle terminals map onto two runtime terminals. **No arithmetic over repository values can supply that distinction because it is CATEGORICAL.** ⭐ **`NTF-GAP-027` minted** to carry all three coupled defects. ⭐ **What survives unchanged:** unit, floor, the `3` / `1–5` recommendation, and the retry-storm finding. ⛔⛔ **0 VALUES INVENTED: 0 deadlines, 0 horizons, 0 quiet windows, 0 attempt counts made authoritative, 0 backoff schedules.** ⛔ **0 slots minted** (`NTF-CFG-*` stays **7**); ⛔ **0 gaps closed** (**27** OPEN, one newly minted); ⛔ **0 requirements reworded or renumbered**; ⛔ **0 ACs changed**; ⛔ **0 lifecycle states added or removed**. ⛔ **0 ADRs (94)**; ⛔ **0** `module_dependencies.yaml`, BC Map, `MASTER_PRD`, matrix, EA, `CONFIGURATION_GUIDE`, frozen PRDs, baseline, registry (`PLANNED`), `IMPL-*`; ⛔ **0 lines of application or test code** — `job_runtime.dart`, `services.dart` **read as evidence only**. ⛔ **Stage 4 NOT READY, NOT CONFERRED**; Stage 3 **PASS 6/6**. Status **`DRAFT`**. |
| **v0.6** | 2026-09-05 | ⭐⭐⭐ **New §20.3c compares 1 · 2 · 3 · 4 · 5 against the ACTUAL runtime, and one measured fact decides it: THE V1 RETRY LOOP CONTAINS NO DELAY BETWEEN ATTEMPTS.** A probe for every delay primitive returns **zero** in both artefacts — `services.dart` **L196-221** is *deadline check → `attempts++` → `await work()` → catch → loop immediately*, and `job_runtime.dart` has **0** occurrences of `delay`, `Timer` or `interval`; the single `await Future.wait` (**L124**) is inside **`drain()`**, a shutdown/test join point, ⛔ **not** the attempt loop. ⇒ ⭐⭐⭐ **every attempt is consumed in an immediate tight burst, which INVERTS the usual reasoning**: without backoff a larger budget does not buy resilience, it buys **N near-simultaneous calls to the same failing provider**. ⭐ **On that measurement: `1` is rejected** (lawful, but `FIL-CFG-014` itself calls 1 *"no retry, permitted for diagnostics"*, and it would render `NTF-FR-047`'s retry obligation inoperative); **`2` is the strongest rival and defensible** but addresses only the very shortest fault and nothing favours it over 3; **`4` is rejected** — no evidence distinguishes it from 3 and the 4th immediate attempt adds load without a materially different time window; ⛔⛔ **`5` is rejected on two grounds** — the same as 4, amplified, **and** because ⭐ **the only `5` in the repository is ADVERSARIAL, not reliability-based** (`AUTH-3.9`, *"at most 5 verification attempts"*, bounding an **attacker's guesses**, and listed at `CONFIGURATION_GUIDE` **L41** among values that are *"**not configurable**"*) — borrowing its shape would import a security-throttle rationale into a fault-tolerance slot. ⇒ ⭐⭐ **TECHNICAL RECOMMENDATION, explicitly labelled `[RECOMMENDED — NOT AUTHORITATIVE]`: 3 total attempts, range 1–5**, the *reasoning* (not the number) transferring from `FIL-CFG-014` — *"three attempts absorb transient faults … without masking a deterministic failure"* — a rationale that holds **because** a durable fallback exists, which §20.3 established `PRD-010` **has**. ⚠ **`5` is acceptable as a range CEILING though rejected as a default**: a range bounds what an operator may set, it does not endorse the extreme. ⛔⛔ **THE VALUE IS STILL NOT FIXED, AND THE REASON IS SUBSTANTIVE RATHER THAN PROCEDURAL CAUTION:** with **no** inter-attempt delay the budget consumes ≈ 3 × (provider timeout), and **neither factor exists** — `NTF-CFG-007` is **OWED** (`NTF-GAP-026`) and the provider timeout is **`NTF-GAP-017`** (absent FCM documentation, the `ADR-0045` condition). ⇒ ⭐ **a budget fixed now could be PARTLY UNREACHABLE the moment a deadline is chosen**: if the deadline is shorter than 3 × timeout the 2nd or 3rd attempt is **never tried** and the configured value would be a fiction — ⭐⭐ **exactly the defect class `INV-18`/`INV-20` exist to prevent**. ⇒ ⭐⭐⭐ **ORDERING IS SUBSTANTIVE: `NTF-CFG-007` MUST be decided BEFORE or WITH `NTF-CFG-004`** — they are one decision with two limbs, and `PRD-017` proves it, since `ADR-0057` set the **120 s** timeout and the **3**-attempt bound **in the same act**. ⚠ **`NTF-GAP-025` (DLQ) recorded as NON-BLOCKING** for this decision — it governs what happens **after** exhaustion, not how many attempts occur. ⚠⚠ **TWO SELF-LIMITING DISCLOSURES made rather than left for a reader to catch:** (1) `test/architecture/job_runtime_port_test.dart` **L43** declares `const int _retryBound = 3`, but its own comment names it *"the recorded **`FIL-CFG-014`** default"* ⇒ ⛔ **a `PRD-017` test fixture, NOT `PRD-010` authority** — citing an executing test as ratification for another bounded context would be manufacturing authority from a fixture; (2) BC Map **L453**'s rebuildability rule is Rank 4 and binding, but `every_projection_rebuildable_test.dart` covers **Analytics only** (**0** hits for `BC-22`/`inbox`/`FeedItem`) and `lib/platform/` has **no `communication` module** ⇒ ⭐ the In-App fallback underpinning the `3` recommendation is **specified and required but NOT YET EXECUTABLY PROVEN** for `BC-22`, and the recommendation rests on the **specification**. ⛔⛔ **0 VALUES MADE AUTHORITATIVE: `NTF-CFG-004` remains OWED, `NTF-CFG-007` remains OWED, backoff remains OWED (0 schedules at Rank 1–5; adapter implements none; EA places *"Retry & Backoff"* at V2).** ✅ **`NTF-FR-047` CONFIRMED unchanged** (transient retry, permanent terminates `failed`); ✅ **`NTF-INV-011` / `CM-3` / `EBR-1030` CONFIRMED unchanged** (`module_dependencies.yaml` **L409-410**). ⛔ **0 gaps closed** (26 OPEN); ⛔ **0 requirements reworded or renumbered**; ⛔ **0 ACs changed**; ⛔ **0 new identifiers minted** — registers unchanged at FR 65 / BR 3 / INV 11 / XC 6 / AC 9 / GAP 26 / CFG 7. ⛔ **0 ADRs (94)**; ⛔ **0** `module_dependencies.yaml`, BC Map, `MASTER_PRD`, matrix, `CONFIGURATION_GUIDE`, frozen PRDs, baseline, registry (`PLANNED`), `IMPL-*`; ⛔ **0 lines of application code or test code** — `job_runtime.dart`, `services.dart`, `di.dart` and `job_runtime_port_test.dart` **read as evidence only**. ⛔ **Stage 4 NOT READY, NOT CONFERRED**; Stage 3 **PASS 6/6**. Status **`DRAFT`**. |
| **v0.5** | 2026-09-05 | ⛔⛔ **MY OWN v0.4 "INVERTED RECOVERY MODELS" CLAIM IS FALSIFIED AND WITHDRAWN — I asserted a durability property of this domain without measuring the channel set.** v0.4 refused `FIL-CFG-014`'s value of `3` partly *on the merits*, stating that *"a notification is **not regenerable** and has **no second copy**"*. ⭐⭐⭐ **BOTH HALVES ARE WRONG, and the refuting evidence is in this document's own §8 catalogue:** **13 of 13** rows name **In-App**, **ZERO** are Push-only (11 are In-App + Push, 2 are In-App only); BC Map **L205** makes `FeedItem` *"owned by **`BC-22`'s inbox projection**"*; and BC Map **L453** (Rank 4) requires *"every projection … **must be rebuildable from the log**. This is tested quarterly, not assumed"*, under the **at-least-once** delivery contract at **L446-447**. ⇒ **a failed Push is NOT a lost notification** — the In-App inbox carries the same fact, the inbox is a **rebuildable projection**, and the source event persists. ⇒ ⭐⭐ **The corrected comparison points the OPPOSITE WAY from v0.4's conclusion:** `PRD-017` and `PRD-010` do **not** have inverted recovery models — **both** have a surviving copy and a regeneration path — so the *shape* of `FIL-CFG-014`'s reasoning **does** transfer. ⚠ **This makes `3` MORE defensible than v0.4 said, and it is recorded although it weakens my own earlier position.** ⛔ **But the VERDICT is unchanged and the value stays OWED**, because the surviving objection is **authority, not merit**: `FIL-CFG-014` is a **`PRD-017`-scoped value** owned by that PRD's scope owner and `ADR-0033` **§7.1** forbids importing it. ⭐ **What changed is the argument, not the outcome.** ⭐⭐⭐ **NEW §20.3b SEPARATES WHAT CAN BE DERIVED FROM WHAT CANNOT.** Derivable and now recorded as **constraints**: (1) **floor ≥ 1 total attempt** — not a proposal but **already binding**, via `INV-21` and the **executable** `ArgumentError` guard at `services.dart` **L152-159**; (2) ⭐⭐ a **ceiling constraint** — *attempts × per-attempt duration MUST fit inside the job `deadline`*, since `job_runtime.dart` **L105-107** makes `deadline` bound the whole job and `services.dart` **L190-201** re-checks it **before each attempt**, so an over-large budget is **partly unreachable** (the defect class `INV-18`/`INV-20` guard elsewhere). ⛔⛔ **The exact number is NOT derivable, for a SPECIFIC rather than procedural reason:** the ceiling is a function of two quantities that **do not exist** — a notification job **deadline** (**0** at any rank) and the **provider's** acknowledgement/retry behaviour (`NTF-GAP-017`, unresolvable because FCM's documentation is absent — the `ADR-0045` condition). ⭐ **`PRD-017` could derive `3` ONLY because `ADR-0057` had already fixed its companion timeout at 120 s (`FIL-CFG-015`); `PRD-010` has no companion deadline, so that derivation is STRUCTURALLY UNAVAILABLE here.** ⇒ any number — 3, 4 or 5 — would be **picked, not derived**. ⭐⭐ **`NTF-CFG-007` MINTED — the delivery job deadline** — published on the **`FIL-CFG-015` precedent** (*"added at v0.2 because writing the configurable exposed that the obligation was missing"*): the `JobRuntime` contract **requires** a `deadline` on every submission, so `BC-22` cannot lawfully submit work without one, and without it `NTF-CFG-004`'s attempt count is **unbounded in time**. ⭐ **`NTF-GAP-026` minted** to carry it and to record that it is the **blocking companion** for `NTF-CFG-004`'s upper bound. ⚠ **A RANGE is confirmed as the correct SHAPE** — every comparable slot publishes one (`LCFG-6` *0–300 s*, `LCFG-12` *5–50*, `FIL-CFG-014` *1–5*) — with its **floor already fixed at 1** and its **upper bound owed**. ⛔⛔ **ZERO VALUES INVENTED: 0 attempt counts, 0 upper bounds, 0 deadlines, 0 backoff schedules, 0 delays, 0 jitter, 0 dedup windows, 0 DLQ depths.** ⛔ **0 gaps closed** (26 OPEN, one newly minted); ⛔ **0 requirements reworded or renumbered**; ⛔ **0 ACs changed**; ⛔ `FIL-CFG-014`'s number **NOT** imported; ⛔ the adversarial **5-attempt** OTP limit (`AUTH-3.9`) **NOT** borrowed — it bounds an **attacker**, not a transient fault, and `CONFIGURATION_GUIDE` **L41** lists it among values *"**not configurable**"*. ⛔ **0 ADRs (94)** — `ADR-0058`/`ADR-0057` **cited, never amended**; ⛔ **0** `module_dependencies.yaml`; ⛔ **0** BC Map; ⛔ **0** `MASTER_PRD`; ⛔ **0** matrix; ⛔ **0** `CONFIGURATION_GUIDE`; ⛔ **0** frozen PRDs; ⛔ **0** baseline; ⛔ **0** registry (`PLANNED`); ⛔ **0** `IMPL-*`; ⛔ **0 lines of application code** — `job_runtime.dart`, `services.dart`, `di.dart` **read as evidence only**. ⛔ **Stage 4 NOT READY, NOT CONFERRED**; Stage 3 **PASS 6/6**. Status **`DRAFT`**. |
| **v0.4** | 2026-09-05 | ⛔⛔ **THE AUTHOR'S OWN `NTF-AL-F4` FINDING WAS OVERSTATED IN TWO RESPECTS AND IS WITHDRAWN, NOT SOFTENED — because an `Accepted` Rank-2 ADR that decides this exact question was never measured.** ⭐⭐⭐ **`ADR-0058` (`Accepted`, 2026-08-20) CLOSES `FIL-GAP-015`**, and v0.3 asserted the `BC-22` condition was *"the same condition `FIL-GAP-015` records"* while that gap was **already closed**. Its holding is directly on point: the gap was a **port-vs-runtime conflation**, since *"every child of EA 'Job Runtime (V2)' … is scaled **infrastructure**, and **none of them is the port**."* **Defect 2:** v0.3 cited **`FIL-XC-017`** as though it bound `BC-22` — ⛔ **it does not**; it is a **`PRD-017` exclusion binding `BC-29`**, and `PRD-010`'s own register (`NTF-XC-001`…`-006`) contains **no** scheduling prohibition. Applying another PRD's **frozen exclusion** to this subject is precisely the cross-PRD borrow this document refuses elsewhere. ⇒ the finding is a **missing port**, not a violated prohibition. ⭐⭐⭐ **THE CONSEQUENCE IS FAVOURABLE AND WAS MISSED: the mechanism `NTF-FR-049` needs ALREADY EXISTS** — the `JobRuntime` **port interface** (`packages/liboora_contracts/lib/src/ports/job_runtime.dart` **L100**, exported **L27**), a **registered V1 adapter** (`InProcessJobRuntime`, `lib/platform/services/services.dart` **L100**; composition root `lib/bootstrap/di.dart` **L240-243**), and a **strictly downward** lawful edge — `platform/services` **rank 3** → `platform/communication` **rank 5** ⇒ **`L2` satisfied with no exception, no cluster, no ADR-0012 debt**. ⇒ ⭐ **`NTF-AL-F4` reduces to ONE narrow act**: a manifest amendment adding `platform/services:job_runtime` to `platform/communication`'s `ports:` list — the **`A-3` shape** (`amendments_applied` **L715-721**), the same mechanism by which this module gained `platform/identity:notification_address`. ⛔ **Manifest NOT edited** — this PRD has no standing to amend a Rank 4 artefact. ⭐⭐⭐ **`NTF-CFG-004`'s UNIT IS UPGRADED from precedent-supported to REPOSITORY-AUTHORITATIVE.** v0.3 rested it on `FIL-CFG-014`, a **`PRD-017`-scoped value** and therefore weak authority here. The correct and stronger authority is the **shared-kernel port contract itself** (`contracts`, **rank 0**): *"`retryBudget` is the **total** attempts permitted, **including the first**"* (**L103-104**), with `JobOutcome.attempts` documented as *"attempts consumed, **including the first**"* (**L82**) and the **≥ 1 floor enforced EXECUTABLY** — `services.dart` **L152-159** throws `ArgumentError` on `retryBudget < 1`, quoting `INV-21` by name. ⇒ **the unit is not a borrow at all**; it is the signature every `BC-22` retry must be submitted through. ⛔⛔ **The NUMBER `3` is still REFUSED, and the reason is now sharper than "not authorised":** `FIL-CFG-014`'s rationale is a **storage** failure domain whose recovery model is `FIL-FR-057`/`FIL-FR-083` — *a derivative is **never the sole copy** and is **regenerable***. ⭐⭐ **Notification delivery has the INVERTED property** — a notification is **not regenerable** and has **no second copy**; a lost expiry notice is simply not sent. ⇒ `3` is not merely unauthorised for `PRD-010`, it is **derived from an assumption that does not hold here** — so the borrow would be **wrong on the merits**, independently of `ADR-0033` §7.1. ⭐ **New §20.3a isolates `NTF-CFG-005` (backoff) as the ONE genuinely premature slot** — **0** backoff schedules exist at Rank 1–5 (every occurrence is a **refusal** or a **provider's own** policy, `ITG-FR-022` `[RZP]`), the **V1 adapter implements none** (`services.dart` **L189-221** retries immediately), and the EA places *"Retry & Backoff"* at **V2** (**L1808**, **L1869**). ⇒ a backoff value would have **nothing to execute it** — which corrects v0.3's claim that the *attempt bound* was premature. ⚠⚠ **A Rank-4 obligation is DISCLOSED rather than claimed satisfied: `NTF-GAP-025` minted** — BC Map **L452** mandates *"Retry with backoff → **Dead Letter Queue**"*, `PRD-010` has **0** DLQ occurrences, and `BC-28` (which **L137** says *"owns … DLQ"*) is **V2**; ⭐ L452 governs the **event backbone** (owned by EVENT PLATFORM per §9.1) and **not** `BC-22`'s **outbound channel** plane, which is why `NTF-FR-047`'s terminal `failed` does not contradict it — but whether the outbound plane needs a dead-letter path is **unruled** and is **not resolved in this document's favour**. ⛔⛔ **ZERO VALUES INVENTED: 0 attempt counts, 0 ranges, 0 backoff schedules, 0 delays, 0 jitter, 0 dedup windows, 0 DLQ depths.** ⛔ **0 gaps closed** (25 OPEN, one newly minted); ⛔ **0 requirements reworded or renumbered**; ⛔ **0 ACs changed**; ⛔ **0 exclusions added**; ⛔ `FIL-XC-017` **NOT** applied to `BC-22`; ⛔ `FIL-CFG-014`'s number **NOT** imported. ⛔ **0 ADRs created or modified (94)** — `ADR-0058` is **cited, never amended**; ⛔ **0** `module_dependencies.yaml` bytes; ⛔ **0** BC Map; ⛔ **0** `MASTER_PRD`; ⛔ **0** matrix; ⛔ **0** `CONFIGURATION_GUIDE.md`; ⛔ **0** frozen PRDs; ⛔ **0** baseline; ⛔ **0** registry status (`PLANNED`); ⛔ **0** `IMPL-*`; ⛔ **0 lines of application code** — `job_runtime.dart` and `services.dart` are **read as evidence only**. ⛔ **Stage 4 remains NOT READY and NOT CONFERRED**; Stage 3 **PASS 6/6** untouched. Status remains **`DRAFT`**. |
| **v0.3** | 2026-09-05 | ⭐⭐⭐ **The `NTF-CFG-*` slot register is opened at new §20.1 — SIX slots declared, and NOT seven, because three of the seven the author's own Stage-4 review classified as configurables are NOT configurables.** Authored under the **`PRD-017` §8.5 / `FIL-CFG-006` precedent** (**L1208-1240**), whose governing sentence is that a slot is published with its range and owner *"even when no authority yet supplies a number, because inventing one **would be a determination made by a document with no standing to make it**"*, and under `FIL-XC-009` (**L302**), which forbids the module defining *"a configuration value's default, range or resolution order"*. ⭐⭐ **THREE OBLIGATIONS ARE RECLASSIFIED OUT of check 3, correcting `PRD-010_STAGE4_REQUIREMENTS_REVIEW.md` v1.0's own finding:** **`NTF-FR-044`** is a **provider-semantic definition** (Rank 1 `MASTER_PRD.md` **L229** already fixes the provider as *"**Firebase Cloud Messaging** — Yes — FCM (V1)"*; the acknowledgement model is that provider's documentation, absent from this repository — the `ADR-0045` condition), **`NTF-FR-054`** is a **`BC-25` resolution property** that `FIL-XC-009` forbids this PRD publishing and `ADR-0017` **§2.5** assigns to `PRD-023`, and **`NTF-FR-065`** is an **NFR locus** owned by SRE/Observability under Rank 1 `MP-NFR-01` — *an NFR target is ratified by an office, not tuned by an operator*. ⇒ ⭐ **Check 3's target is 6 slots, of which 1 is satisfied by citation and 5 are owed.** ⭐⭐⭐ **`NTF-CFG-002` is SATISFIED BY CITATION, not by invention** — it resolves to **`LCFG-2`** (default **`en`**, range *"Supported set"*, owner **Product**, rationale *"Only locale with complete strings at V1"*; `Library_PRD_v1.md` **L717** FROZEN Rank 3, `CONFIGURATION_GUIDE.md` **L352**). ⚠ **New §20.2 confronts the objection that `PRD-015` was refused this exact citation FOUR times** (`SRCHCL-X3`, `SRCHGR-X4`, `SRCHGB-X4`, `F5_OWNERSHIP_RULING` §4.3 — *"a **false friend**"*) and shows every refusal turns on one measured reason — *"a **UI-string locale**, not a **script inventory**"* — which **does not obtain** for a notification template, since a template **is** a UI string and `LCFG-2`'s own rationale is about *"complete **strings**"*. ⛔ `ADR-0100` §3.7's closed **English + Hindi** inventory is **search-scoped and NOT imported**; `NTF-FR-037`'s prohibition on borrowing `SRCHPO-17` **stands unamended**; ⛔ no second source of truth — the slot **consumes** `LCFG-2`, it does not copy it. ⭐ **`NTF-CFG-004`'s UNIT is fixed by precedent while its VALUE is refused** (new §20.3): `FIL-CFG-014` counts *"**3** attempts **total** (initial + 2 retries)"* with **`INV-21`** requiring *"retry bound **≥ 1**"* ⇒ a repository retry bound counts **total attempts**, so any value expressed as *retries with a floor of 0* would contradict `INV-21`; ⛔ `FIL-CFG-014`'s **number** is NOT carried across, its failure domain being storage rather than a push provider. ⭐ **`NTF-CFG-006` is shown to be invariant-constrained, not free** (new §20.4): a dedup window expiring mid-retry violates **`NTF-INV-007`**, so the three retry slots are **not independently choosable**; ⛔ `PRD-019`'s 30-day retention is **inapplicable** — a transport `(tenant, event-id)` key is not a `(eventId, recipientId, channel, templateId)` user-visibility key. ⭐ **New §20.5 records what the repository DOES fix about availability and what it does not**: the unit is **`% monthly`** (`authentication/prd-v2/11-…` **L67-69**) — ⛔ *"rolling 30 d"* has **0** occurrences repository-wide — the coherence direction puts a dependent **below** its dependency ⇒ `BC-22` **MUST NOT exceed 99.9%**, and ⭐⭐ **`NTF-INV-011` makes notification the LEAST availability-critical plane**, so it cannot carry a **tighter** outage bound than authentication; ⛔ **no numeric SLO is published**, because `ADR-0102` ratified a **target** and left **`SRE-GAP-001` OPEN** on the SLO/SLI/error-budget limbs — an SLO here would be the **first in the repository**. ⚠⚠ **TWO NEW ARCHITECTURE FINDINGS DISCLOSED, NEITHER CURED:** **`NTF-AL-F3`** — `platform/communication`'s manifest block (**L392-410**) declares **no** `platform/configuration:settings` port, so `E-19`'s *"all contexts"* grant and the module block disagree (⭐ `PRD-017` has the identical condition — there is **no** `platform/media` block at all — so this PRD follows `E-19` as `PRD-017` does, and records the disagreement); **`NTF-AL-F4`** — `NTF-FR-049` presupposes a retry scheduler the manifest does not grant `BC-22`: `platform/workflow` is the **only** module declaring `platform/services:job_runtime` (**L338**), mirroring `FIL-GAP-015`, so a retry value would be **configured but not consumable**. ⭐ **`NTF-GAP-024` minted** — cross-context consumption of a Library-scoped `LCFG-*` slot is unruled (Architecture Owner). ⚠ **Two STALE counts in §31 corrected by measurement and DISCLOSED** — it read `NTF-INV-*` (10) and `NTF-AC-*` (8) but v0.2 had added `NTF-INV-011` and `NTF-AC-009`; actual **11** and **9**, which falsifies v0.1a's claim that all six registers were *"verified CONTIGUOUS and complete by measurement"*. ⛔⛔ **ZERO VALUES INVENTED: 0 recipient ceilings, 0 rate limits, 0 retry counts, 0 backoff schedules, 0 dedup windows, 0 SLO/SLI/error budgets, 0 percentages, 0 mandatory/optional classifications.** ⛔ **0 gaps closed** (24 OPEN, one newly minted); ⛔ **0 requirements renumbered or reworded**; ⛔ **0 ACs changed**; ⛔ `ADR-0102` **NOT** reused; ⛔ `SRCHPO-17` / `ADR-0100` §3.7 **NOT** borrowed; ⛔ **0 ADRs** created or modified (94); ⛔ **0** `CONFIGURATION_GUIDE.md` bytes — filling the guide is step 3 and needs the values first; ⛔ **0** frozen PRDs, **0** baseline, **0** registry status (still `PLANNED`), **0** BC Map, **0** `MASTER_PRD`, **0** dependency matrix, **0** `module_dependencies.yaml`, **0** `IMPL-*`, **0** lines of application code. ⛔ **Stage 4 remains NOT CONFERRED** — conferral is the **Requirements Reviewer**'s (`PRD_LIFECYCLE.md` §6 **L278**); Stage 3 **PASS 6/6** untouched. Status remains **`DRAFT`**. |
| **v0.2** | 2026-09-05 | ⭐⭐ **REQUIRED CORRECTION applied — the two additive amendments accepted at `NTF-AL-B2` in [`PRD-010_ARCHITECTURE_ALIGNMENT.md`](PRD-010_ARCHITECTURE_ALIGNMENT.md) §8.3, and nothing else.** ⭐⭐⭐ **`C-1` — the emitting-operation failure boundary is now stated: new invariant `NTF-INV-011`** requires that an unresolvable notification address fail **only that delivery** and ⛔ **never** fail, roll back, abort or retry the originating business operation, carrying `tool/module_dependencies.yaml` **`CM-3`** / **`EBR-1030`** verbatim; supported by new **§19.1**, which explains that the invariant **protects other bounded contexts, not `BC-22`** — without it a failed address lookup could roll back a paid membership renewal — and by new acceptance criterion **`NTF-AC-009`**, which asserts the emitting aggregate's post-state is unchanged. ⭐ **Verified NOT a duplicate before adding**: a repository-wide probe for an existing failure-boundary requirement (`fail the emitting`, `emitting operation`, `roll back`, `originating operation`, `never fail`) returned **0 hits**, and §19.1 records the distinction from `NTF-FR-003`, which governs **payload sufficiency** and states no emitter boundary. ⭐⭐ **`C-2` — the authoritative module contract is now cited in new §6.1**: `platform/communication`, **rank 5**, `imports: contracts` (rank 0), ports `platform/integration:connector` and **`platform/identity:notification_address`** under **AMENDMENT `A-3`** with its *"one address, one queued delivery… never retained by the caller"* constraint (**L462-464**), `consumes_events: ["*"]`, `banned_imports`, and a clause-by-clause table mapping **`CM-1`** → `NTF-INV-003`/`-FR-004`/`-FR-009`, **`CM-2`** → `NTF-FR-058`/`-FR-004`, **`CM-3`** → `NTF-INV-011`. ⭐ §6.1 also records that **`A-3` is the mechanism behind `MP-GBR-34`** — the address is resolved at delivery time, which is *why* no event need carry a number. ⚠ **`NTF-AL-F2` is DISCLOSED in §6.1 and expressly NOT relied upon or cured** — the pre-existing rank-5→rank-5 `platform/integration` port is an Architecture-Owner-owned manifest condition, and no requirement here depends on its lawfulness. ⚠ **The stale `PRD-019` fact is corrected in 4 places, re-measured from the document itself**: **v0.4 `DRAFT`** with **111 `ITG-*` identifiers** (54 obligation-bearing + 54 `ITG-AC-*` + 3 `ITG-GAP-*`), replacing v0.1's *"`DRAFT`, 0 identifiers"*; `NTF-GAP-021` is **refined, not closed** — Push egress is specifiable **in form** (declared `connector` port, `MASTER_PRD` **L229**) but ⛔ **its delivery guarantees are not, until `PRD-019` is conferred**. ⚠ **A pre-existing `PRD_REGISTRY.md` self-contradiction is disclosed, not repaired** (**L319** v0.1 vs **L545** v0.4) — resolving it is a **Governance Owner** act. ⛔ **NOTHING ELSE CHANGED: 0 requirements redesigned, 0 identifiers renumbered, 0 `NTF-GAP-*` closed (23 remain OPEN), Platform Admin authorization untouched, 0 business events invented, `messaging.MessageSent → BC-22` NOT invented, WhatsApp scope unchanged, `NTF-AL-F2` NOT fixed.** ⛔ **0 BC Map · 0 `MASTER_PRD` · 0 frozen PRDs · 0 baseline · 0 registry status · 0 dependency matrix · 0 `module_dependencies.yaml` · 0 ADRs created or modified · 0 `IMPL-*` · 0 lines of application code.** Status remains **`DRAFT`**; ⛔ no approval or freeze claimed; `PRD_REGISTRY.md` remains **`PLANNED`**. |
| **v0.1a** | 2026-09-05 | ⚠ **Self-audit of the author's own published counts and cross-references — three defects found and repaired, two false alarms cleared.** ⭐ **All six registers verified CONTIGUOUS and complete by measurement**, not by assertion: `NTF-FR-001`…`065` (65) · `NTF-BR-001`…`003` (3) · `NTF-INV-001`…`010` (10) · `NTF-XC-001`…`006` (6) · `NTF-AC-001`…`008` (8) · `NTF-GAP-001`…`023` (23) — **0 missing, 0 out-of-range, 0 duplicate definitions**, and all **23** gaps confirmed present in the §28 table. ⚠⚠ **THREE BROKEN CROSS-REFERENCES REPAIRED** — they cited the *drafting brief's* 56-section outline rather than this document's actual 32 sections: *"see §29"* → **§13** (Student↔Student messaging; §29 is Acceptance Criteria), and two citations of a non-existent *"§35.3"* → **§5 N7** and an explicit `AUTH-10.3` / `MASTER_PRD` §22 citation respectively. ⭐ **Two apparent duplicates were investigated and CLEARED as legitimate**: `NTF-FR-009` appears twice as one definition plus one prose citation, and `NTF-GAP-003` is deliberately cited by **two** catalogue rows (`MembershipExpiringSoon` and `FeeDueRaised`) because one unresolved timing decision governs both. ⭐ **Every remaining `§` reference was verified to be either internal and ≤32, or externally qualified** (`MASTER_PRD` §22, BC Map §8, `DOCUMENTATION_BASELINE` §3.5). ⛔ **No requirement text, register membership, gap, verdict, ownership finding or evidence citation was changed** — this entry corrects pointers and publishes measured counts only. ⛔ Status remains **`DRAFT`**; ⛔ 0 approvals, 0 conferrals, 0 baseline rows, 0 ADRs, 0 frozen documents touched, 0 `IMPL-*`, 0 code. |
| **v0.1** | 2026-09-05 | ⭐⭐ **Created at Stage 2 as a DRAFT.** Catalogue built **only** from BC Map §8 events already routed to `BC-22`. ⭐⭐⭐ **Three brief-contradicting findings recorded:** (1) Student↔Student messaging is owned by **`BC-12`** under **FROZEN** `PRD-021B` ⇒ integration-only, and `messaging.MessageSent` is **not routed to `BC-22`** (`NTF-GAP-011`); (2) **SMS/Email/WhatsApp are V2** by Rank-1 `MP-SCOPE-09`, WhatsApp Business **V3** by EA L1502/L1821 ⇒ V1 integrated channels are **exactly In-App + Push**; (3) ⭐ **"Platform Admin" has 0 occurrences** in the BC Map, ownership model and Auth PRD, and `MP-GBR-21` **closes** the scope register to `self`/`guardianOf`/`tenantWide` ⇒ ⛔ **no Platform Admin role created**, platform broadcast blocked at `NTF-GAP-002`, and platform-level *configuration* routed through the real `BC-25` instead. ⛔ **Six requested notifications have no source event** and are registered at `NTF-GAP-005` rather than invented. ⚠ **A contradiction between BC Map L437 and Auth PRD §10 is disclosed** (`NTF-GAP-006`) and ⛔ not resolved in the author's favour. ⛔ **0 timings, 0 bulk limits, 0 retry values, 0 SLOs invented.** ⛔ Authority **not borrowed** from `PRD-015`'s `SRCHPO-17` or `ADR-0102`. **23 gaps registered, each with a named owner.** ⛔ **No approval, no conferral, no freeze, no baseline row, no admitting ADR, no frozen document touched, no historical record modified, no `IMPL-*`, no application code.** Status **`DRAFT`**; `PRD_REGISTRY.md` still shows `PLANNED` and ⛔ **was not modified.** |
