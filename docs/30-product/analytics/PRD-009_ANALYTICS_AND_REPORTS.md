# `PRD-009` — Analytics & Reports

| Field | Value |
|---|---|
| **PRD ID** | `PRD-009` |
| **Name** | Analytics & Reports |
| **Bounded Context** | **`BC-26` Analytics Read Model** `[GENERIC]` |
| **Version** | **v0.1** |
| **Status** | **`DRAFT`** — ⛔ **not ranked, not baselined, not frozen** |
| **Lifecycle stage** | **Stage 2 — Draft.** ⛔ Stages 3–8 **NOT** entered |
| **Identifier prefix** | **`ANL-*`** — ⭐ verified free: **0** pre-existing occurrences repository-wide |
| **Registers declared** | FR 58 · BR 6 · INV 9 · XC 11 · AC 16 · CFG 8 · GAP 24 · OBD 7 — ⭐ ranges published up front as a promise (Stage-2 rule) |
| **Baseline** | ⛔ **`BASELINE-2026-09-03-A` untouched.** This document holds **no rank** |
| **Authority claimed** | ⛔ **NONE.** Stage-2 draft. Every decision requiring an owner is marked `[OWED]` |

---

## 0. Identifier registers — declared up front with contiguous ranges

Stage-2 rule 3: *"Ranges are contiguous. A gap makes the published range false."*

| Register | Range | Count | Meaning |
|---|---|---|---|
| `ANL-FR-001` … `ANL-FR-058` | contiguous | **58** | Functional requirements |
| `ANL-BR-001` … `ANL-BR-006` | contiguous | **6** | Business rules |
| `ANL-INV-001` … `ANL-INV-009` | contiguous | **9** | Invariants |
| `ANL-XC-001` … `ANL-XC-011` | contiguous | **11** | Exclusions — each states what must be **impossible** |
| `ANL-AC-001` … `ANL-AC-016` | contiguous | **16** | Acceptance criteria |
| `ANL-CFG-001` … `ANL-CFG-008` | contiguous | **8** | Configuration slots |
| `ANL-GAP-001` … `ANL-GAP-024` | contiguous | **24** | Open gaps, each with a named owner |
| `ANL-OBD-001` … `ANL-OBD-007` | contiguous | **7** | Open bounded decisions |

⚠ **`ANL-EVT-*` is declared EMPTY, deliberately.** `BC-26` **emits no domain event** — BC Map §7's
event table shows it exclusively as a *consumer*. The empty register is published rather than omitted
so a future reader knows the question was asked and answered.

---

## 1. Document Identity — confirmed against repository sources, not asserted

⭐ **The prompt's asserted identity is CORRECT. No conflict. Verified three ways:**

| Claim | Repository evidence | Verdict |
|---|---|---|
| `PRD-009` = Analytics & Reports, `BC-26`, `[GENERIC]`, V1 | `PRD_REGISTRY.md` **L246** — *"`PRD-009` \| Analytics & Reports \| **`BC-26` Analytics Read Model** \| `[GENERIC]` \| V1 \| `PLANNED` \| Dashboards (modules 10–12)"* | ✅ **Exact match** |
| `BC-26` exists and owns this scope | BC Map **L135** — *"**BC-26** \| **Analytics Read Model** \| `[GENERIC]` \| Analytics \| V1 \| Owns the metric/semantic layer, read-model store, projections, reports, exports."* | ✅ **Confirmed** |
| Module identity | `MASTER_PRD.md` **L166** — module 14, *"Analytics & Reports \| `BC-26` Analytics Read Model \| `[GENERIC]` \| V1"* | ✅ **Confirmed** |
| Not already owned | Registry status **`PLANNED`**; **0** `PRD-009` files exist; **0** `ANL-*` identifiers exist | ✅ **Free to draft** |

### 1.1 Stage-1 Discovery gate — passed, and not as a formality

| Stage-1 question | Answer | Evidence |
|---|---|---|
| Does a bounded context own this? | ✅ **Yes** — `BC-26` | BC Map L135 |
| Does another PRD already own the context? | ✅ **No** | Registry L246 |
| Is it V1/V2/V3 or Future? | ✅ **V1** — not Future, so not barred | Registry L246 |
| Does it own an aggregate **and** an invariant? | ✅ **Yes** — ⭐ `BC-26` **already has a §8 aggregate row** | BC Map **L385** |

⭐⭐ **BC Map L385, verbatim — the single most important line for this PRD:**

> *"BC-26 Analytics Read Model | `Projection` | `CertifiedMetric`, `ReadModel` | **Fully rebuildable
> from the event log; no projection is a system of record; metric definitions single-sourced from the
> semantic layer**"*

⭐ **Contrast worth stating:** `BC-22` reached Stage 4 with **no §8 row at all**, which blocked it for
several passes. `BC-26` arrives with its aggregate, value objects **and** three invariants already
declared at Rank 4. This PRD's job is to *implement that declaration*, not invent one.

---

## 2. Executive Summary

`PRD-009` specifies analytics and reporting for `BC-26` — the context owning the metric/semantic layer,
projections, read models, reports and exports.

The architecture has already decided the hard parts:

| Authority | Rule | Consequence |
|---|---|---|
| **`MP-GBR-36`** (Rank 1) | *"**No dashboard may define its own metric formula.** All metrics come from the Metric (Semantic) Layer as Certified Metrics."* | A semantic layer is **mandatory** |
| **`MP-GBR-37`** (Rank 1) | *"Analytics has **no read access to domain tables**. It learns only from events, and every projection must be **rebuildable from the event log**."* | Event-sourced only; **`X-01`** names the anti-pattern |
| **`MP-GBR-38`** (Rank 1) | *"No projection is a system of record."* | Analytics can never become authoritative |
| **BC Map L385** (Rank 4) | `Projection` aggregate; `CertifiedMetric`, `ReadModel` | The aggregate is given |

⭐ The real work is threefold: define Certified Metrics with legitimate sources, specify who may see
what, and — the point the panel fought hardest over — decide what should be shown to a student at all.

### 2.1 ⛔ The three findings a reader should see first

| # | Finding | Class |
|---|---|---|
| **F-1** | ⭐⭐ **The existing implementation consumes 8 of the 24 events routed to `BC-26` and has NO semantic layer** — a live breach of `MP-GBR-36`. Measured, §8.3 | **HIGH RISK** |
| **F-2** | ⭐⭐⭐ **The student-facing analytics this brief asks for have almost no legitimate data source here.** `BC-26` receives attendance, seating, fee, membership, identity, social, billing and AI events — **no marks, scores, test results, syllabus or mastery signal**. Measured, §12.2 | **BLOCKER for the "learning analytics" framing** |
| **F-3** | ⭐⭐ **A peer leaderboard cannot be built lawfully under `MP-GBR-21`**, whose scope register is closed to `self`, `guardianOf`, `tenantWide`. §17 | **BLOCKER for public ranking** |

⚠ **F-2 is the finding I expect to be least welcome, so it is stated plainly.** The brief asks for
mastery, strengths, improvement areas and learning progress. A library-operations platform measuring
*attendance, seat usage and fees* can honestly report **study consistency and presence**. It cannot
report *learning* without inventing a data source. This PRD specifies what the evidence supports and
marks the rest `[OWED]`.

---

## 3. Problem Statement

| # | Problem | Repository anchor |
|---|---|---|
| P-1 | Metric drift — *"'revenue' will mean five different things in five dashboards within 18 months"* | `MASTER_PRD.md` L477; risk **`MP-RSK-07`** |
| P-2 | Report queries degrading the operational database | **`X-01`** — *"Just query the students table for the report"* |
| P-3 | Dashboards (modules 10–12) are compositions with no certified source beneath them | `MASTER_PRD.md` L162-164, L173 |
| P-4 | Two different debts could be merged into one revenue number | **`MP-GBR-24`** — *"must never share a model, a table or a metric"* |

---

## 4. Purpose

A single certified analytics foundation for `BC-26` that: defines every metric once with a named
source and owner; learns only from events and can be rebuilt from them; serves Owner, Manager,
Reception and Student from the **same** certified metrics; never becomes authoritative; and does not
harm students psychologically in the name of motivation.

---

## 5. Goals

| ID | Goal | Measured by |
|---|---|---|
| G-1 | Every dashboard number resolves to a Certified Metric | `ANL-AC-001` |
| G-2 | Every projection rebuildable from the event log | `ANL-AC-002` |
| G-3 | Analytics never reads a domain table | `ANL-AC-003` |
| G-4 | Every output tenant-scoped and permission-filtered | `ANL-AC-004`, `-005` |
| G-5 | Student analytics measure **presence and consistency**, honestly labelled | `ANL-AC-010` |
| G-6 | No student-facing analytic uses shame, fear or public failure | `ANL-AC-011` |
| G-7 | Freshness visible wherever data is not real-time | `ANL-AC-008` |
| G-8 | Multi-app ready without V1 complexity | `ANL-AC-016` |

---

## 6. Non-Goals

| ID | Non-goal | Why |
|---|---|---|
| NG-1 | Owning any operational state | `MP-GBR-38` |
| NG-2 | Defining dashboards themselves | Dashboards are **compositions, not contexts** (`MASTER_PRD.md` L173) |
| NG-3 | Academic/learning-outcome analytics in V1 | **F-2** — no data source |
| NG-4 | Peer-identified ranking | **F-3** — `MP-GBR-21` |
| NG-5 | Notification delivery | `BC-22` owns it (`PRD-010`, **FROZEN** Rank 3) |
| NG-6 | Configuration resolution order | `BC-25` owns it (`FIL-XC-009` precedent) |
| NG-7 | External scraping / device surveillance | Prohibited — `ANL-XC-011` |

---

## 7. Scope

**In scope:** semantic/metric layer · projections and read models · `AnalyticalReport` · exports ·
analytics access rules · freshness and data-quality semantics · the permission-aware query port
consumed by dashboards, AI (`E-26`) and future Liboora products.

**Out of scope:** dashboard UI composition · notification delivery · authorization *decisions*
(`BC-18`) · tenant records (`BC-19`) · entitlement (`BC-21`) · the audit record (`BC-24`).

---

## 8. Repository / Architecture Evidence

### 8.1 The 24 events routed to `BC-26` — measured, not assumed

⭐ Enumerated from BC Map §7 by grep: **24 rows**.

| Producer | Events reaching `BC-26` |
|---|---|
| `BC-01` Enrollment | `enrollment.StudentEnrolled`, `StudentProfileUpdated` |
| `BC-02` Membership | `membership.MembershipCreated`, `MembershipRenewed`, `MembershipExpired`, `MembershipFrozen`/`Unfrozen` |
| `BC-03` Attendance | `attendance.StudentCheckedIn`, `StudentCheckedOut`, `AttendanceCorrected` |
| `BC-04` Seating | `seating.SeatAssigned`/`SeatReleased`/`SeatTransferred`, `OccupancyThresholdCrossed` |
| `BC-05` Fee & Payment | `fee.FeeDueRaised`, `FeePaymentReceived`, `RefundIssued` |
| `BC-10` Person Identity | `identity.PersonIdentityCreated`, `PersonProfileUpdated`, `PersonPrivacyModeChanged`, `PersonAnonymised` |
| `BC-11` Social Graph | `social.FriendshipEstablished`/`UserBlocked` |
| `BC-12` Messaging | `messaging.MessageSent` *(engagement metrics)* |
| `BC-18` Identity & Access | `iam.AccountCreated`/`SessionRevoked`/`ConsentGranted` |
| `BC-20` Billing | `billing.SubscriptionActivated`/`Cancelled`/`PaymentFailed` |
| `BC-27` AI | `ai.AgentRunCompleted`/`AiActionApplied` *(cost attribution)* |
| `BC-19` Tenancy | `tenancy.LibraryProfileViewed` — via **`E-30`** (BC Map L899) |

### 8.2 Event envelope and delivery semantics — inherited, not redefined

BC Map §9.1 fixes these; this PRD **consumes** them:

| Property | Rule |
|---|---|
| Envelope | `eventId`, `eventType`, `schemaVersion`, `occurredAt`, `tenantId`, `actorId`, `correlationId`, `causationId`, `aggregateId`, `payload` |
| Delivery | **At-least-once** ⇒ *"every consumer must be idempotent — keyed on `eventId`, with a processed-events table **or equivalent**"* |
| Ordering | Per aggregate only. ⛔ *"No consumer may assume cross-aggregate ordering"* |
| Tenant safety | *"A consumer that processes an event without establishing tenant context must **fail loudly, not default**"* |
| Replay | *"**Every projection (BC-26)** and index (BC-23) must be rebuildable from the log. This is tested quarterly, not assumed"* |

⭐ **Unlike `BC-22`, the replay rule names `BC-26` explicitly** — rebuildability is a pre-existing
obligation here, not something this PRD must argue for.

### 8.3 ⚠⚠ The existing implementation — measured, and partly non-compliant

`lib/platform/analytics/analytics.dart` exists (7,183 bytes), exercised by
`test/architecture/every_projection_rebuildable_test.dart`.

| Measured fact | Value |
|---|---|
| Events subscribed | **8** — `StudentEnrolled`, `MembershipCreated`, `StudentCheckedIn`, `StudentCheckedOut`, `SeatAssigned`, `SeatReleased`, `FeePaymentReceived`, `FeeDueRaised` |
| Events available | **24** ⇒ ⭐ **16 unconsumed** |
| Metric fields | 10 counters + 2 derived (`seatsOccupied`, `insideNow`) |
| Semantic layer | ⛔ **NONE** |
| `CertifiedMetric` type | ⛔ **Absent from code**, though a Rank-4 value object |
| Rebuild | ✅ `rebuildFrom(EventBus bus)` — behaviourally tested |
| Money | ⭐ minor-unit `int`, deliberately not `Money` — *"Analytics must not depend on domain arithmetic rules, only on reported amounts"* |

⭐⭐ **F-1 restated precisely:** the projection *is* rebuildable (good, and tested), but metrics are
**inline field increments with no definition, owner, version or source record** — a live breach of
`MP-GBR-36`. → **`ANL-GAP-001`**, **HIGH RISK**.

⚠ Also disclosed: `attendance.AttendanceCorrected` is **not** consumed, yet BC Map L416 states its
purpose is *"Audit + **restated metrics**"*. Attendance figures today **cannot restate**. →
**`ANL-GAP-002`**.

### 8.4 Module rank and permitted reach

| Fact | Value |
|---|---|
| Rank | **R7 ANALYTICS** — *"Read models and metrics. Consumes events from everything below"* |
| `ANALYTICS → LIBRARY MANAGEMENT` | **`✖` FORBIDDEN** — *"no read access to domain tables"* |
| Anti-pattern | **`X-01`** |
| AI reach | **`E-26`** — *"AI retrieves through permission-aware ports only — never direct index or table access"* |

---

## 9. Bounded Context Ownership

⭐ **Owns:** metric/semantic layer · read-model store · projections · reports · exports (BC Map L135).
⛔ **Does not own:** any domain fact. Every number derives from another context's event.

### 9.1 The `Report` naming collision — already resolved at Rank 4

BC Map **L206** (§5 Ubiquitous Language Collisions):
> *"**Report** | BC-26: a defined analytical output | BC-13: an abuse report filed by a user |
> `AnalyticalReport` (BC-26) vs `AbuseReport` (BC-13)"*

⭐ **`ANL-BR-001`:** this context's type **MUST** be named `AnalyticalReport` in code and APIs.

⚠ **Scope note, learned from a prior error.** §5's governing text makes a collision row binding on
*"the names that must appear in code, APIs"* — **not** on aggregate structure. L206 fixes the **name**
and says nothing about internals. This PRD does not over-read it.

---

## 10. Domain & Analytics Boundaries

| Concern | Operational contexts | Analytics (`BC-26`) |
|---|---|---|
| Purpose | Transactions, workflow, authoritative state | Trends, summaries, decision support |
| Truth | ⭐ **Authoritative** | ⛔ **Never** (`MP-GBR-38`) |
| Write path | Commands on aggregates | Event consumption only |
| Domain tables | Reads them | ⛔ **Never** (`MP-GBR-37`, `X-01`) |
| Corrections | Corrects the record | **Restates** the metric |

**`ANL-INV-001`** No `BC-26` projection is a system of record.
**`ANL-INV-002`** No `BC-26` component reads a domain table.
**`ANL-INV-003`** Every projection is reconstructible from the event log such that a replay from zero
yields an identical snapshot per tenant.

---

## 11. Analytics Architecture — the certified chain

```
Source Fact (owned by a domain context)
  → Domain Event (§9.1 envelope, at-least-once, per-aggregate order)
    → Idempotent Consumption (keyed on eventId)
      → Projection            [Projection aggregate, BC Map L385]
        → Certified Metric    [CertifiedMetric, semantic layer, MP-GBR-36]
          → Read Model        [ReadModel]
            → Dashboard / AnalyticalReport / Export
              → Authorized User (tenant + role + scope filtered)
```

**`ANL-FR-001`** Every analytic output **MUST** resolve to a Certified Metric.
**`ANL-FR-002`** Every projection **MUST** implement a full rebuild from the event log.
**`ANL-FR-003`** Every consumer **MUST** be idempotent keyed on `eventId`.
**`ANL-FR-004`** A consumer that cannot establish `tenantId` **MUST** fail loudly and **MUST NOT**
default, fall back or process the event.
**`ANL-FR-005`** No `BC-26` component **MUST** be able to issue a domain command.

---

## 12. Data / Event Sources & Metric Feasibility

### 12.1 What the events genuinely support

| Domain | Legitimately derivable | Source |
|---|---|---|
| Attendance | Check-ins/outs, presence duration, consistency, currently-inside | `attendance.*` |
| Occupancy | Seats assigned/released/transferred, occupancy, threshold breaches | `seating.*` |
| Revenue (student→library) | Dues raised, payments received, refunds | `fee.*` |
| Membership | Created, renewed, expired, frozen | `membership.*` |
| Growth | Enrolments over time | `enrollment.*` |
| SaaS billing (library→LIBOORA) | Activations, cancellations, failures | `billing.*` |
| AI cost | Run counts, cost attribution | `ai.*` |
| Engagement | Message volume | `messaging.MessageSent` |
| Public profile | Profile views | `tenancy.LibraryProfileViewed` (`E-30`) |

**`ANL-BR-002`** ⭐ Student-fee revenue (`BC-05`) and SaaS revenue (`BC-20`) **MUST NOT** share a metric,
model or table — **`MP-GBR-24`**, reinforced by `MP-SM-06` which requires any "Revenue Growth" metric
to *state which one it means*.

### 12.2 ⛔ What the events do NOT support — the F-2 blocker in detail

Measured: **0** events reaching `BC-26` carry marks, scores, test results, subject mastery, syllabus
progress, homework or any learning-outcome signal.

| Brief asks for | Data source | Verdict |
|---|---|---|
| Mastery | ⛔ none | **`ANL-GAP-003`** `[OWED — Product Owner]` |
| Strengths / improvement areas | ⛔ none | **`ANL-GAP-004`** `[OWED — Product Owner]` |
| Practice / learning effort | ⛔ none | **`ANL-GAP-005`** `[OWED — Product Owner]` |
| Academic progress over time | ⛔ none | **`ANL-GAP-006`** `[OWED — Product Owner]` |
| Study **consistency** | ✅ `attendance.*` | ✅ **Supported** |
| Time **present** in library | ✅ `attendance.*` | ✅ **Supported** |

⭐⭐ **`ANL-XC-001` — the exclusion that protects students from a false claim:**
> `BC-26` **MUST NOT** publish, label or imply any metric as measuring learning, mastery, academic
> performance, intelligence or ability. It is **impossible** for a V1 Certified Metric to carry such a
> label, because no ingested event contains a learning-outcome fact. A metric derived from attendance
> **MUST** be labelled as presence or consistency, never as achievement.

⚠ Written as an impossibility, not a deferral — an exclusion must state what cannot happen.

### 12.3 Honest labelling

**`ANL-FR-006`** Every student-facing metric **MUST** display what it derives from (e.g. *"based on
your check-ins"*).
**`ANL-FR-007`** No metric name **MUST** be able to imply a broader claim than its source supports.

---

## 13. Metric & Semantic Governance

**`ANL-FR-008`** Every Certified Metric **MUST** carry all nine fields: `metricId` · `name` ·
`definition` · `sourceEvents[]` · `calculation` · `owningContext` · `timeSemantics` ·
`freshnessExpectation` · `accessScope`.
**`ANL-FR-009`** A metric missing any of the nine **MUST** be rejected at registration, not published
with blanks.
**`ANL-FR-010`** Metric definitions **MUST** be versioned; a calculation change **MUST** create a new
version rather than mutating the existing one.
**`ANL-FR-011`** Any output built on a metric version **MUST** state which version it used.
**`ANL-BR-003`** ⭐ No dashboard, report, export or AI answer **MUST** be able to define its own formula
(`MP-GBR-36`).
**`ANL-INV-004`** Exactly one active definition per `metricId` per version.

⚠ **`ANL-OBD-001`** — **who owns a Certified Metric's definition?** `MP-GBR-36` mandates the layer but
names no owner. Candidates: Product Owner (business meaning) vs Architecture Owner (structure).
`[OWED — Architecture Owner + Product Owner]`. **DECISION REQUIRED.**

---

## 14. Read Models & Projections

**`ANL-FR-012`** Each projection **MUST** declare the events it consumes.
**`ANL-FR-013`** A rebuild **MUST** produce a snapshot identical to the live-subscription snapshot per
tenant — the property the existing test already asserts behaviourally.
**`ANL-FR-014`** Rebuild **MUST** be executable per tenant without affecting another tenant's data.
**`ANL-FR-015`** A projection **MUST NOT** hold state that cannot be reconstructed from the log.
**`ANL-INV-005`** Replay from zero is deterministic — no wall-clock read inside projection logic
(`X-09` precedent; the existing test injects a fixed "today" for exactly this reason).

⚠ **`ANL-GAP-007`** — rebuild is *"tested quarterly"* (BC Map L453) but no scheduling mechanism exists.
`[OWED — Implementation Lead]`.
⚠ **`ANL-OBD-007`** — is `Projection` one aggregate or one per subject area? BC Map L385 says
`Projection` singular; the code holds one `DashboardMetrics` per tenant. `[OWED — Architecture Owner]`.

---

## 15. Student Analytics — `Today → Progress → Motivation → Detail`

⭐ Scoped honestly to presence and consistency (§12.2).

| Screen | Content | Source |
|---|---|---|
| **Today** | Currently inside? · today's presence duration · seat | `attendance.*`, `seating.*` |
| **Progress** | Presence over 7/30 days · personal trend · personal-best consistency | `attendance.*` |
| **Motivation** | Personal milestones · consistency goals | derived |
| **Detail** | Own history · own dues and receipts | `attendance.*`, `fee.*` |

**`ANL-FR-016`** A student **MUST** be able to see only their own analytics — scope `self`
(`MP-GBR-21`).
**`ANL-FR-017`** Student analytics **MUST** default to personal-progress framing, not comparison.
**`ANL-FR-018`** A student with no history **MUST** see an explanatory empty state, never a zero
presented as a score.
**`ANL-FR-019`** A student **MUST** be able to view fee dues and payment history for themselves only.
**`ANL-XC-002`** A student **MUST NOT** be able to see another identified student's analytics —
peer-identified visibility is **impossible** in V1.

---

## 16. Student Psychology — panel-resolved, with evidence classes separated

⚠ **Discipline applied:** every item is labelled. ⛔ **I cite no external studies**, because this
repository contains no research corpus and the brief forbids inventing facts. Items marked
`[EVIDENCE]` are widely-held design principles and I flag that they are **not repository-verified**.

| Principle | Class | Consequence |
|---|---|---|
| Personal-progress framing is safer than rank | `[EVIDENCE — not repo-verified]` | `ANL-FR-017` |
| Public failure indicators cause shame | `[EVIDENCE — not repo-verified]` | `ANL-XC-003` |
| Streaks motivate some, discourage others on break | `[HYPOTHESIS]` | `ANL-FR-021` |
| Milestones motivate more healthily than ranks | `[HYPOTHESIS]` | §17 |
| Optimal notification frequency | `[EXPERIMENT REQUIRED]` | `ANL-GAP-008` |
| Whether Indian teen students prefer guardian-visible progress | `[EXPERIMENT REQUIRED]` — ⛔ **must not be assumed** | `ANL-GAP-009` |

**`ANL-XC-003`** `BC-26` **MUST NOT** emit any student-facing output that ranks a student publicly,
labels a student as failing/weak/bad, uses fear or urgency to drive behaviour, or displays a negative
comparison against an identified peer. Such output **MUST** be impossible to construct.
**`ANL-FR-020`** Every student-facing analytic **MUST** be expressible without a negative value
judgement.
**`ANL-FR-021`** A broken streak **MUST NOT** be presented as failure or loss; recovery framing is
required and the streak **MUST NOT** be the primary progress signal.
**`ANL-FR-022`** Analytics **MUST NOT** trigger a disciplinary notification to a guardian without an
authorization decision from `BC-18` and a lawful scope under `MP-GBR-21`.
**`ANL-FR-023`** A metric whose only lever is attendance **MUST** be labelled as attendance, so that
gaming it gains nothing but honesty.
**`ANL-FR-024`** Analytics **MUST NOT** be mandatory to use the app.
**`ANL-FR-025`** Analytics-originated notification triggers **MUST** be rate-limited per recipient per
period.

### 16.1 Psychological edge cases

| Case | Safeguard |
|---|---|
| Repeatedly checking rank | No rank in V1 (§17) |
| Streak break discouragement | `ANL-FR-021` |
| Comparison with high performers | `ANL-XC-002`, `-003` |
| Guardian pressure from reports | `ANL-FR-022`; `ANL-GAP-009` |
| Gaming the metric | `ANL-FR-023` |
| Avoiding analytics entirely | `ANL-FR-024` |
| Notification fatigue | Delivery is `BC-22`'s; `ANL-FR-025` caps triggers |

---

## 17. Healthy Competition — and why V1 has no leaderboard

⭐⭐ **`MP-GBR-21` is dispositive:** *"The scope register is **closed**: `self`, `guardianOf`,
`tenantWide`. No fourth scope may be introduced **without an ADR**."*

A peer-visible leaderboard requires a *peer* scope — a fourth scope. ⇒ **It cannot be built in V1
without an ADR.** An architectural bar, not a preference — and it happens to align with the
psychological finding.

**`ANL-XC-004`** V1 **MUST NOT** expose any peer-identified ranking, leaderboard or comparison. It is
**impossible** under the closed scope register.

**Lawful alternatives, all `self`-scoped:** personal best · own improvement over own baseline ·
milestone progress · consistency goals · optional anonymised **aggregate** cohort band.

⚠ **`ANL-OBD-002`** — is an anonymised cohort band (*"top third"*) `self`, or a disguised peer scope?
⭐ **I do not resolve this**: in a small tenant it may be re-identifying. `[OWED — Architecture Owner
+ Privacy]`. **DECISION REQUIRED.**
⚠ **`ANL-GAP-010`** — minimum cohort size for any aggregate band. `[OWED — Privacy]`.

**`ANL-FR-026`** If a future ADR permits competition, it **MUST** define eligibility · visibility ·
ranking scope and frequency · opt-in/opt-out · anti-cheating · tie handling · missing and late data ·
minimum population · accessibility · psychological safeguards.

---

## 18–21. Management Analytics — `Status → Attention → Action → Analysis`

**`ANL-FR-027`** Management surfaces **MUST** follow Status → Attention → Action → Analysis, not a
chart wall.
**`ANL-FR-028`** Every "attention" item **MUST** name the metric, the threshold crossed and the
drill-down path.
**`ANL-BR-004`** ⭐ A management **role MUST NOT** by itself grant data visibility — authorization
(`BC-18`) and entitlement (`BC-21`) remain authoritative.

| Role | Needs | V1 analytics | Source |
|---|---|---|---|
| **Owner** (§19) | Confidence, trends, exceptions, risk | Occupancy trend · student-fee collections vs dues · membership growth/expiry · enrolment trend · AI cost | `seating.*`, `fee.*`, `membership.*`, `enrollment.*`, `ai.*` |
| **Manager** (§20) | Operational clarity, attention areas | Today's occupancy · threshold breaches · expiring memberships · overdue dues · attendance anomalies | `seating.*`, `membership.*`, `fee.*`, `attendance.*` |
| **Reception** (§21) | Immediate actionable context | Who is inside now · seats free · today's check-ins · dues-on-arrival flag | `attendance.*`, `seating.*`, `fee.*` |

⭐ `insideNow` and `seatsOccupied` already exist in code — the Reception view is closest to buildable
today.

**`ANL-XC-005`** Reception **MUST NOT** be able to see aggregate financial or business-performance
analytics; least privilege makes it impossible, not merely hidden.
⚠ **`ANL-OBD-003`** — the exact per-role metric visibility matrix. `[OWED — Product Owner + BC-18]`.

---

## 22–25. Dashboards · Reports · Exports · Preferences

| Surface | Purpose | Owned by |
|---|---|---|
| **Dashboard** | Ongoing situational awareness | ⛔ **Composition — not this context** (modules 10–12) |
| **`AnalyticalReport`** | Structured / recurring analysis | ✅ `BC-26` |
| **Export** | Authorized downstream, sharing, print, archival | ✅ `BC-26` |

**`ANL-FR-029`** `BC-26` **MUST** expose certified metrics through a permission-aware query port;
dashboards compose over it and **MUST NOT** compute their own values.
**`ANL-FR-030`** Every `AnalyticalReport` **MUST** declare fourteen fields: user · purpose · question
answered · source events · metrics · frequency · freshness · format · filters · drill-down ·
permissions · privacy class · export rules · V1/V2/V3.
**`ANL-FR-031`** A report failing to declare all fourteen **MUST NOT** be publishable.
**`ANL-FR-032`** Every export **MUST** be authorized per export and **MUST** record actor, tenant,
scope, metric versions and freshness at generation time.
**`ANL-FR-033`** Every export **MUST** emit an audit fact to `BC-24`.
**`ANL-XC-006`** An export **MUST NOT** contain a field the requesting actor could not see in-app.
**`ANL-XC-007`** Analytics **MUST NOT** deliver reports; scheduled delivery is `BC-22`'s (`PRD-010`,
FROZEN).

⚠ **`ANL-GAP-011`** — export formats (PDF/CSV) unspecified; each must be justified per report, not
adopted by default. `[OWED — Product Owner]`.
⚠ **`ANL-GAP-012`** — export retention. `[OWED — Privacy + BC-29]`.
### 25.1 Configuration slots — declared, with every value `[OWED]`

⚠ **Stage-4 check 3 will require a default and a range for each.** ⛔ **None is asserted here**, because
no Rank 1–5 authority supplies one and inventing eight numbers would create untested requirements. The
slots are **declared so the range is honest**; the values are owed.

| ID | Slot | Default | Range | Owner |
|---|---|---|---|---|
| `ANL-CFG-001` | Report page size | `[OWED]` | `[OWED]` | Product Owner |
| `ANL-CFG-002` | Export row cap | `[OWED]` | `[OWED]` | SRE + Product Owner |
| `ANL-CFG-003` | Freshness-warning display threshold | `[OWED]` | `[OWED]` | SRE (`ANL-GAP-020`) |
| `ANL-CFG-004` | Analytics-originated trigger rate limit | `[OWED]` | `[OWED]` | Product Owner (`ANL-FR-025`) |
| `ANL-CFG-005` | Minimum cohort size for an aggregate band | `[OWED]` | `[OWED]` | Privacy (`ANL-GAP-010`) |
| `ANL-CFG-006` | Projection retention window | `[OWED]` | `[OWED]` | Architecture + Legal (`ANL-OBD-006`) |
| `ANL-CFG-007` | Default reporting period | `[OWED]` | `[OWED]` | Product Owner |
| `ANL-CFG-008` | Rebuild batch size | `[OWED]` | `[OWED]` | Implementation Lead |

⚠⚠ **`ANL-CFG-005` is the one that must not be guessed.** A cohort minimum is a **re-identification
control**, not a UI preference — too small a value silently turns an "anonymised" band into a peer
comparison. It is bound to `ANL-OBD-002` and must not ship before it.

⛔ **`ANL-XC-*` reminder:** `BC-26` **MUST NOT** define any of these values' resolution **order** —
that is `BC-25`'s (`FIL-XC-009` precedent).

---

## 26. India-First UX

**`ANL-FR-034`** Every analytic **MUST** be readable on a small mobile screen without horizontal
scroll.
**`ANL-FR-035`** Every screen **MUST** lead with a plain-language summary before any chart.
**`ANL-FR-036`** Every metric label **MUST** be localizable — no concatenated sentence fragments.
**`ANL-FR-037`** Currency **MUST** be INR-formatted and timestamps IST (`MP-CON-12`).

⚠ **`ANL-GAP-013`** — Hindi/regional readiness depends on `BC-25`/`LCFG-2`; `BC-26` **consumes** locale
and **MUST NOT** define it. `[OWED — BC-25]`.
⚠ **`ANL-GAP-014`** — printability requirements unverified. `[OWED — Product Owner]`. ⛔ **I decline to
assume Indian users want PDFs** — that would be an unsupported cultural assumption, which the brief
forbids.

---

## 27–28. Privacy, Authorization & Multi-Tenancy

**`ANL-INV-006`** Every projection, metric, report and export is tenant-scoped; a cross-tenant read is
impossible.
**`ANL-INV-007`** Analytics visibility is confined to `self`, `guardianOf`, `tenantWide`
(`MP-GBR-21`).
**`ANL-FR-038`** Every query **MUST** carry `tenantId` and actor permissions (the `AI-1` pattern).
**`ANL-FR-039`** `identity.PersonAnonymised` **MUST** remove that person from every identifiable
analytics output.
**`ANL-FR-040`** `identity.PersonPrivacyModeChanged` **MUST** be honoured with **no propagation
window** (BC Map L427, `SEV-9`).
**`ANL-XC-008`** Analytics **MUST NOT** be a route to data the actor cannot access operationally.

⚠⚠ **`ANL-OBD-004` — HIGH RISK.** The `parent` role is *"Attendance visibility, fee updates and
important notifications"* (`MASTER_PRD.md` L111). ⭐ **That does not obviously extend to analytical
aggregates or trend reports about a minor.** Whether `guardianOf` covers *derived analytics* is
undecided. `[OWED — Privacy + BC-18]`. **DECISION REQUIRED before any guardian-facing analytic ships.**
⚠ **`ANL-GAP-015`** — the repository establishes no student age bands or minor status, so
teen-specific protections cannot be specified on evidence. `[OWED — Product Owner + Legal]`.
⚠ **`ANL-GAP-016`** — DPDP applicability to *derived* analytics (`MP-NFR-10`). `[OWED — Legal/Security]`.

---

## 29–30. Accessibility & Localization

**`ANL-FR-041`** No analytic **MUST** convey meaning by colour alone.
**`ANL-FR-042`** Every chart **MUST** have a text or table equivalent.
**`ANL-FR-043`** Every metric **MUST** be screen-reader labelled with name, value and freshness.
⚠ **`ANL-GAP-017`** — contrast and type-scale targets: no repository accessibility standard exists.
`[OWED — Design]` · **NFR DECISION REQUIRED.**

---

## 31. Notifications — a boundary, not a feature

**`ANL-XC-009`** `BC-26` **MUST NOT** send any notification directly; it may only publish a fact for
`BC-22`.
⚠ **`ANL-GAP-018`** / **`ANL-OBD-005`** — `BC-26` currently emits **no** event and BC Map §7 gives it
no producer row. An analytics→`BC-22` trigger needs a **new edge and an ADR** (*"if an edge is not in
this table, it does not exist"*). `[OWED — Architecture Owner]`. **DECISION REQUIRED.**

---

## 32. AI Boundary

Anchored on **`E-26`** and the `ai` manifest assertions (`AI-1`, `AI-2`, `AI-3`).

**`ANL-FR-044`** AI **MUST** obtain analytics only through the permission-aware port — never direct
store access (`E-26`).
**`ANL-FR-045`** AI **MUST NOT** redefine, recompute or override a Certified Metric.
**`ANL-FR-046`** Every AI analytic statement **MUST** cite the metric IDs and versions used.
**`ANL-FR-047`** AI **MUST** represent uncertainty and **MUST NOT** state a number absent from a
certified metric.
**`ANL-XC-010`** AI **MUST NOT** be able to produce an analytics figure untraceable to a Certified
Metric — hallucinated analytics must be structurally impossible, not merely discouraged.
**`ANL-FR-048`** AI cost **MUST** be attributable per tenant (`ai.*`, `MP-NFR-11`).

---

## 33–34. External Ecosystem & Multi-App Compatibility

**`ANL-FR-049`** The semantic layer **MUST** be product-agnostic — metrics keyed by tenant and
identity concepts, not by app.
**`ANL-FR-050`** New producers **MUST** be addable by registering events, without forking the layer.
**`ANL-XC-011`** `BC-26` **MUST NOT** ingest data from any external platform except through an
authorized mechanism (official API, webhook, OAuth, partner integration, authorized import). Scraping
and device surveillance are **impossible** by specification.

⭐ **No external platform is claimed to expose an API.** Integration is a **future capability**;
`PRD-019` owns integration boundaries.
⚠ **`ANL-GAP-019`** — Liboora School/College/Coaching do not exist in the repository. V1 must *avoid
blocking* them, not design for them (`EA §10.3` discipline). `[OWED — Product Owner]`.

---

## 35–36. Data Quality & Freshness

| Condition | Required behaviour | ID |
|---|---|---|
| Duplicate event | Idempotent by `eventId`, no double count | `ANL-FR-003` |
| Out-of-order | No cross-aggregate ordering assumption | `ANL-FR-051` |
| Delayed / late arrival | Metric restates; restatement visible | `ANL-FR-052` |
| Correction (`AttendanceCorrected`) | Metric **MUST** restate | `ANL-FR-053` |
| Missing events | Output **MUST** mark partial, not silently under-report | `ANL-FR-054` |
| Deleted / anonymised source | Removed from identifiable output | `ANL-FR-039` |
| Timezone / period boundary | IST; boundary rule declared per metric via `timeSemantics` | `ANL-FR-055` |
| Stale pipeline | Output **MUST** show last-updated and **MUST NOT** claim real-time | `ANL-FR-056` |
| Metric version change | Output states the version used | `ANL-FR-011` |

**`ANL-INV-008`** No analytic output presents stale data as current.
**`ANL-INV-009`** Every output carries the freshness of its underlying projection.
**`ANL-FR-057`** Every Certified Metric **MUST** declare a freshness expectation; a breach **MUST** be
visible to the consumer.
⚠ **`ANL-GAP-020`** — numeric freshness targets. ⛔ **I decline to invent SLA numbers**; no repository
standard exists. `[OWED — SRE]` · **NFR DECISION REQUIRED.**

---

## 37–40. Performance · Reliability · Observability · Security

**`ANL-FR-058`** Report generation and export **MUST** run as background work that cannot block an
operational transaction.
⚠ **`ANL-GAP-021`** — dashboard load, report generation, large-tenant and concurrency targets: **no
repository numeric standard exists**. `[OWED — SRE]` · **NFR DECISION REQUIRED.**
⚠ **`ANL-GAP-022`** — DLQ thresholds for analytics consumers. BC Map calls DLQ depth *"an
SLO-monitored signal, not a silent bin"*, but sets no analytics threshold. `[OWED — SRE]`.

Observability is **never authoritative** (`MP-NFR-09`) and must not carry identifiers it is not cleared
to hold. Security: tenant isolation (`tenant_isolation_test.dart` exists), least privilege, audit via
`BC-24`, PII redaction before any model egress (`AI-2`).

---

## 41–42. Edge Cases & Failure Modes

| Case | Behaviour |
|---|---|
| Zero data / new student | Explanatory empty state (`ANL-FR-018`) |
| Inactive / deleted / anonymised student | Excluded from identifiable output (`ANL-FR-039`) |
| Transferred student · tenant migration | ⚠ **`ANL-GAP-023`** `[OWED — BC-19]` |
| Frozen membership | Presence continues; billing metrics reflect the freeze |
| Refund / cancelled / partial payment | Revenue restates (`fee.RefundIssued`) |
| Corrected attendance | Restatement (`ANL-FR-053`) — ⚠ blocked today by `ANL-GAP-002` |
| Offline-created events | Late arrival ⇒ restatement |
| Month / year boundary | Declared `timeSemantics` |
| Insufficient cohort population | Band suppressed (`ANL-GAP-010`) |
| Unauthorized export | Refused **and** audited |
| Failed report generation | Explicit failure state, never a partial passed off as complete |
| Very large report | Background + pagination |
| Projection corruption | Rebuild from the log |

⭐ **Failure principle: fail visibly.** A wrong number that looks right is worse than a missing one.

---

## 43. V1 / V2 / V3

| Phase | Contents | Why |
|---|---|---|
| **V1** | Semantic layer + Certified Metric registry · projections over the 24 events · Reception/Manager/Owner surfaces · student presence & consistency (`self`) · core reports · authorized export · freshness · rebuild | Required for `MP-GBR-36` compliance and the V1 dashboards (modules 10–12) |
| **V2** | Richer reports · report preferences · anonymised cohort bands *(if `ANL-OBD-002` resolves)* · guardian analytics *(if `ANL-OBD-004` resolves)* · scheduled reports via `BC-22` | Valuable, but each depends on an unresolved decision |
| **V3** | AI narrative summaries · cross-product analytics · external ecosystem ingestion · advanced personalization | Depends on products and integrations that do not exist |

⛔ **Learning/academic analytics sit in no phase** — they need a data source first
(`ANL-GAP-003`…`-006`). Phasing a requirement whose input does not exist would be false planning.

---

## 44. NFRs

| ID | NFR | Status |
|---|---|---|
| `ANL-NFR-01` | Tenant isolation | ✅ Inherited; test exists |
| `ANL-NFR-02` | Rebuildability | ✅ Inherited; test exists |
| `ANL-NFR-03` | Freshness targets | ⛔ **NFR DECISION REQUIRED** (`ANL-GAP-020`) |
| `ANL-NFR-04` | Dashboard / report / export performance | ⛔ **NFR DECISION REQUIRED** (`ANL-GAP-021`) |
| `ANL-NFR-05` | Accessibility targets | ⛔ **NFR DECISION REQUIRED** (`ANL-GAP-017`) |
| `ANL-NFR-06` | DLQ thresholds | ⛔ **NFR DECISION REQUIRED** (`ANL-GAP-022`) |

⭐ **Four NFRs are deliberately unnumbered.** Inventing latency or contrast values would create
requirements no authority set and no test could justify.

---

## 45. Acceptance Criteria — 16, each testable

| ID | Criterion | Verifies |
|---|---|---|
| `ANL-AC-001` | Given a dashboard value, when traced, then it resolves to a Certified Metric carrying all nine fields | `ANL-FR-001`, `-008` |
| `ANL-AC-002` | Given a projection, when the log is replayed from zero, then the snapshot matches the live snapshot exactly per tenant | `ANL-FR-013` |
| `ANL-AC-003` | Given the analytics module, when imports are inspected, then no domain repository or table reference exists | `ANL-INV-002`, `X-01` |
| `ANL-AC-004` | Given a query without `tenantId`, when executed, then it fails loudly and processes nothing | `ANL-FR-004` |
| `ANL-AC-005` | Given actor A of tenant T1, when querying tenant T2, then access is refused | `ANL-INV-006` |
| `ANL-AC-006` | Given the same event delivered twice, when consumed, then metrics increment once | `ANL-FR-003` |
| `ANL-AC-007` | Given `attendance.AttendanceCorrected`, when consumed, then the affected metric restates | `ANL-FR-053` |
| `ANL-AC-008` | Given a stale projection, when output renders, then last-updated shows and no real-time claim is made | `ANL-FR-056`, `ANL-INV-008` |
| `ANL-AC-009` | Given a metric calculation change, when published, then a new version is created and outputs cite it | `ANL-FR-010`, `-011` |
| `ANL-AC-010` | Given a student-facing presence metric, when labelled, then it states its attendance derivation and makes no achievement claim | `ANL-FR-006`, `ANL-XC-001` |
| `ANL-AC-011` | Given any student-facing output, when inspected, then it contains no rank, no peer identity and no failure label | `ANL-XC-003`, `-004` |
| `ANL-AC-012` | Given `identity.PersonAnonymised`, when consumed, then that person appears in no identifiable output | `ANL-FR-039` |
| `ANL-AC-013` | Given an export request, when the actor lacks in-app visibility of a field, then the export omits it and the attempt is audited | `ANL-XC-006`, `ANL-FR-033` |
| `ANL-AC-014` | Given an AI analytics answer, when inspected, then every figure cites a metric ID and version | `ANL-FR-046`, `ANL-XC-010` |
| `ANL-AC-015` | Given a student-fee revenue metric and a SaaS revenue metric, when compared, then they share no model, table or metric ID | `ANL-BR-002`, `MP-GBR-24` |
| `ANL-AC-016` | Given a new event producer, when registered, then it is ingested without modifying existing metric definitions | `ANL-FR-050` |

⭐ `ANL-BR-005` Every acceptance criterion **MUST** be capable of failing — *"a criterion that cannot
fail is not a test"* (`ITG-AC-017` precedent).
⭐ `ANL-BR-006` Every requirement **MUST** carry a unique identifier (Stage-2 rule 1).

---

## 46. Traceability Matrix (specimen — full registration is Stage 5)

| Requirement | Architecture source | Data source | Metric | Read model | Consumer | Permission | AC |
|---|---|---|---|---|---|---|---|
| `ANL-FR-001` | `MP-GBR-36` | all | all Certified | all | dashboards, AI | per-metric `accessScope` | `ANL-AC-001` |
| `ANL-FR-002` | `MP-GBR-37`, BC Map L385/L453 | event log | — | all | ops | — | `ANL-AC-002` |
| `ANL-FR-053` | BC Map L416 | `attendance.AttendanceCorrected` | presence | attendance RM | Manager, Student | `tenantWide`/`self` | `ANL-AC-007` |
| `ANL-FR-016` | `MP-GBR-21` | `attendance.*` | consistency | student RM | Student | `self` | `ANL-AC-011` |
| `ANL-BR-002` | `MP-GBR-24`, `MP-SM-06` | `fee.*` vs `billing.*` | two distinct | two | Owner | `tenantWide` | `ANL-AC-015` |
| `ANL-FR-044` | `E-26`, `AI-1` | via port | any | any | `BC-27` | actor's | `ANL-AC-014` |

⛔ **Stage 5 not entered.** No `TRACEABILITY_MATRIX.md` registration is claimed or performed.

---

## 47. Risks

| ID | Risk | Severity |
|---|---|---|
| `ANL-RSK-01` | Metric drift if the semantic layer is skipped again | **HIGH** (`MP-RSK-07`) |
| `ANL-RSK-02` | Student analytics misread as academic judgement | **HIGH** |
| `ANL-RSK-03` | Guardian analytics increasing pressure on a minor | **HIGH** (`ANL-OBD-004`) |
| `ANL-RSK-04` | Export becoming a privacy bypass | **HIGH** |
| `ANL-RSK-05` | Cohort bands re-identifying in small tenants | **MEDIUM** |
| `ANL-RSK-06` | AI presenting uncertified figures | **MEDIUM** |
| `ANL-RSK-07` | Analytics load reaching OLTP via a shortcut | **MEDIUM** (`X-01`) |
| `ANL-RSK-08` | Report fatigue | **LOW** |

---

## 48. Open Decisions — 7

| ID | Decision | Owner | Class |
|---|---|---|---|
| `ANL-OBD-001` | Who owns a Certified Metric definition | Architecture + Product Owner | **DECISION REQUIRED** |
| `ANL-OBD-002` | Is an anonymised cohort band `self` or a fourth scope | Architecture + Privacy | **DECISION REQUIRED** |
| `ANL-OBD-003` | Per-role metric visibility matrix | Product Owner + `BC-18` | **DECISION REQUIRED** |
| `ANL-OBD-004` | Does `guardianOf` extend to derived analytics | Privacy + `BC-18` | **HIGH RISK** |
| `ANL-OBD-005` | Does `BC-26` ever emit an event (needs edge + ADR) | Architecture Owner | **DECISION REQUIRED** |
| `ANL-OBD-006` | Retention of projections vs source events | Architecture + Legal | **DECISION REQUIRED** |
| `ANL-OBD-007` | Is `Projection` one aggregate or one per subject area | Architecture Owner | **DECISION REQUIRED** |

---

## 49. Gaps — 24, each with a named owner

`-001` no semantic layer (**HIGH**, Arch+Impl) · `-002` `AttendanceCorrected` unconsumed (Impl) ·
`-003`…`-006` no learning / mastery / effort / academic source (**BLOCKER**, PO) · `-007` quarterly
rebuild schedule (Impl) · `-008` notification frequency (**EXPERIMENT**, PO) · `-009`
guardian-visibility preference (**EXPERIMENT**, PO) · `-010` minimum cohort size (Privacy) · `-011`
export formats (PO) · `-012` export retention (Privacy+`BC-29`) · `-013` locale readiness (`BC-25`) ·
`-014` printability (PO) · `-015` student age / minor status (PO+Legal) · `-016` DPDP for derived
analytics (Legal) · `-017` accessibility targets (Design) · `-018` analytics→`BC-22` edge (Arch) ·
`-019` multi-product compatibility (PO) · `-020` freshness targets (SRE) · `-021` performance targets
(SRE) · `-022` DLQ thresholds (SRE) · `-023` tenant migration / transfer semantics (`BC-19`) ·
`-024` which of the **16 unconsumed events** are V1 (Arch+PO).

---

## 50. Explicit Non-Requirements

⛔ Not required: real-time streaming analytics · academic scoring · predictive/ML forecasting ·
peer leaderboards · guardian dashboards (V1) · external platform ingestion · custom report builder ·
data-warehouse export · cross-tenant benchmarking.

⭐ Each is listed because a reader might otherwise assume it — silence would be read as intent.

---

## 51. Governance / ADR Requirements

| # | Required ADR | Why |
|---|---|---|
| 1 | Certified Metric definition ownership | `ANL-OBD-001` |
| 2 | Cohort-band scope, or a fourth scope | `MP-GBR-21` requires an ADR for any fourth scope |
| 3 | `guardianOf` extension to derived analytics | `ANL-OBD-004` |
| 4 | `BC-26` as event producer + a new edge | BC Map §7 — *"if an edge is not in this table, it does not exist"* |
| 5 | `Projection` granularity | `ANL-OBD-007` |

⛔ **None is written here.** Authoring an ADR is an Architecture-Owner act; this is a Stage-2 draft.

---

## 52. Final Product Readiness Assessment

| Dimension | Verdict |
|---|---|
| Architectural fit | ✅ **Strong** — context, aggregate, invariants and 24 event sources already declared |
| Data availability — **operations** analytics | ✅ **Good** — attendance, seating, fees, membership, growth all sourced |
| Data availability — **learning** analytics | ⛔ **ABSENT** — `ANL-GAP-003`…`-006` |
| Metric governance | ⚠ **Mandated but unbuilt** — `ANL-GAP-001` |
| Privacy readiness | ⚠ **Guardian/minor questions unresolved** — `ANL-OBD-004`, `ANL-GAP-015` |
| Psychological safety | ✅ **Designed for**, and the riskiest feature (ranking) is barred by architecture |
| NFR readiness | ⛔ **4 decisions required** |
| V1 buildability | ⚠ **Partial** — Reception/Manager closest; student surface buildable only in the honest presence/consistency framing |

### 52.1 Verdict

⭐ **`PRD-009` is architecturally well-founded and ready to enter Stage 3 review.** ⛔ **It is not ready
to build**, for one dominant reason: `MP-GBR-36`'s semantic layer is mandated at Rank 1 and does not
exist in code, while the existing projection consumes a third of its available events.

⚠⚠ **And the brief's central student-facing ambition cannot be met on current data.** The most useful
thing this document does is say so in §12.2, rather than specify twelve learning metrics with no
source.

---

## 53. Changelog

| Version | Date | Change |
|---|---|---|
| **v0.1** | 2026-09-05 | Created as the **Stage-2 draft** for `PRD-009` Analytics & Reports (`BC-26`). ⭐ Identity confirmed three ways (`PRD_REGISTRY.md` **L246**, BC Map **L135**, `MASTER_PRD.md` **L166**) — **no conflict**, so no stop-and-report was required. Registers declared up front: **FR 58 · BR 6 · INV 9 · XC 11 · AC 16 · CFG 8 · GAP 24 · OBD 7**, contiguous, on prefix **`ANL-*`** verified free (**0** prior occurrences). `ANL-EVT-*` declared **EMPTY** with a reason. ⭐⭐ Three findings lead the document: **F-1** the existing `lib/platform/analytics/analytics.dart` consumes **8 of 24** routed events and has **no semantic layer** — a live breach of Rank-1 `MP-GBR-36`; **F-2** ⛔ **no ingested event carries any learning-outcome fact**, so mastery / strengths / academic-progress analytics have **no legitimate source** and are made **impossible** by `ANL-XC-001` rather than invented; **F-3** a peer leaderboard is **barred by `MP-GBR-21`**'s closed scope register and would need an ADR. ⚠ Also disclosed: `attendance.AttendanceCorrected` is unconsumed although BC Map L416 assigns it *"restated metrics"*. ⛔ **4 NFR targets and all 8 `ANL-CFG-*` defaults left unasserted** rather than fabricated. ⛔ Stages 3–8 not entered; nothing ranked, baselined or frozen; **0** ADRs authored; **0** application code changed; `PRD-010` untouched and still **FROZEN** at Rank 3. |
