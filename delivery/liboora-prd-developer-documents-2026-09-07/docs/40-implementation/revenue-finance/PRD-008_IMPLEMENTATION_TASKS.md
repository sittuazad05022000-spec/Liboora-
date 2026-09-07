# `PRD-008` Implementation Tasks — `IMPL-700` … `IMPL-799`

| Field | Value |
|---|---|
| **Document** | Implementation tasks for [`PRD-008_REVENUE-AND-FINANCE.md`](../../30-product/revenue-finance/PRD-008_REVENUE-AND-FINANCE.md) (`PRD-008`, `BC-05`) |
| **Version** | v1.0 |
| **Status** | Backlog record. **Not ranked**, therefore editable without an ADR |
| **Date** | 2026-08-17 |
| **Baseline** | Written against `BASELINE-2026-08-05-A`. **Not admitted to it** |
| **Purpose** | [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) **Stage 6** gate — allocate an `IMPL-*` range and record a task document in which **every task traces back to requirements** |
| **Implementation state** | ⛔ **NOTHING IN THIS DOCUMENT IS IMPLEMENTED.** Zero files under `lib/` were created or modified. No development has started |
| **Source of truth** | `PRD-008` v1.7 **DRAFT**, sha256 `d24832f33e600518`. Where this file disagrees with it, **the PRD is right and this file is a defect** |
| **Range** | `IMPL-700` … `IMPL-799`. Allocated per rule 1 (**next free**) and rule 2 (`IMPL-680`…`699` left to Attendance growth) |
| **Authority** | **Implementation Lead**, exercised by **direct, explicit and unconditional conferral of the human principal of this engagement**. That instruction is the authority, and it is the only authority claimed. Scope: **this act only** — not a standing licence (`ADR-0033` §7.1) |
| **Stage** | Stage 6 of 9. Stages 3 and 4 are **CONFERRED** (unconditional). `PRD-008` remains **`DRAFT`** and **unfrozen** with **17** open `FEE-GAP-*`; this document does **not** freeze it and does **not** close any gap |

---

## 1. The one thing this document is not

It is **not** evidence of progress, and it is **not** a specification. Eighty-two
well-formed task rows can read like work completed; they are a plan for work
**not** begun. Verified, not asserted:

```
git diff --stat 5827068 HEAD -- lib test pubspec.yaml android web
  →  (empty)
```

Nor is it a source of requirements. Stage 6's gate runs in one direction only —
**every task traces back to a requirement that already existed**. No task below
introduces an obligation, a rule, a provider behaviour, a permission, an API, a
financial rule or a scope decision. Where the PRD is silent, the task is
**BLOCKED**, not invented.

### 1.1 Why this document allocates `IMPL-700`, and why that required measurement

`PRD_LIFECYCLE.md` Stage 6 carries an allocation table whose last row reads
`` `IMPL-227`+ | **Unallocated** ``. **That row is stale.** Measured:

| Range | Owner | Source |
|---|---|---|
| `IMPL-014`…`073` | Authentication, platform, release readiness | lifecycle table |
| `IMPL-100`…`127` | Library Management | task document |
| `IMPL-128`…`199` | Reserved — Library growth | lifecycle table |
| `IMPL-200`…`226` | Student Identity | task document |
| `IMPL-300`…`323` | `PRD-004` | task document |
| `IMPL-400`…`441` | `PRD-005` | task document |
| `IMPL-500`…`599` | `PRD-007` | task document |
| `IMPL-600`…`679` | `PRD-006` | task document |
| `IMPL-680`…`699` | Reserved — Attendance growth | `PRD-006` task doc L124 |
| **`IMPL-700`…`799`** | **`PRD-008` Revenue & Finance — this document** | **allocated here** |

`IMPL-227` is **TAKEN** by Student Identity. Allocating from the lifecycle
table's `227` would have violated rule 1 (*"Never reuse or reassign a number"*)
and collided with a live range. The frontier was therefore derived from the most
recent task document (`PRD-006` L125: `` `IMPL-700` + | Unallocated ``) and
confirmed by measurement: **the only `IMPL-7xx` string anywhere in the
repository is the row that declares it unallocated.** Zero collisions.

The stale lifecycle row is **not edited here**. `PRD_LIFECYCLE.md` is a
Rank-2 governance document; correcting it is a governance act, and this is an
implementation record. The defect is recorded, not silently fixed.

---

## 2. What the tasks are derived from — the measured input set

| Input | Count | Contiguity |
|---|---|---|
| `FEE-FR-*` functional requirements | 62 | 001–062, contiguous |
| `FEE-BR-*` business rules | 28 | 001–028, contiguous |
| `FEE-INV-*` invariants | 10 | 001–010, contiguous |
| `FEE-EVT-*` events | 3 | 001–003, contiguous |
| `FEE-XC-*` exclusions | 23 | 001–023, contiguous |
| `FEE-PO-*` ports | 8 | 001–008, contiguous |
| **Obligations total** | **134** | — |
| `FEE-AC-*` acceptance criteria | 98 | 001–098, contiguous |
| `FEE-GAP-*` open gaps | 17 | 001–017, all **OPEN** |

**No task below cites an identifier outside this set.**

---

## 3. Task groups — `IMPL-700` … `IMPL-799`

Priority: **P1** = required for any usable V1 financial path · **P2** = required
for V1 completeness · **P3** = hardening/reporting · **BLOCKED** = a governance
gap must close first.

### 3.1 `IMPL-700` … `IMPL-709` — Fee structure and the money primitive

| Task | Description | Traces to | Priority | Blocks | Blocked by |
|---|---|---|---|---|---|
| `IMPL-700` | `Money` value object — non-negative, tenant currency, no floating point | `FEE-INV-001` | P1 | 701–799 | — |
| `IMPL-701` | `FeeStructure` aggregate — amount, cadence, tenant scoping | `FEE-FR-001`…`005` | P1 | 710 | 700 |
| `IMPL-702` | Fee-structure amount validation — reject negative and foreign currency | `FEE-INV-001`, `FEE-AC-005` | P1 | — | 700, 701 |
| `IMPL-703` | Tenant-scoped repository for fee structures | `FEE-INV-003`, `E-18` | P1 | 710, 720 | 701 |
| `IMPL-704` | ⛔ **BLOCKED** — fee-type taxonomy | `FEE-FR-006` | BLOCKED | 705 | **`FEE-GAP-004`** — no approved taxonomy |
| `IMPL-705` | ⛔ **BLOCKED** — discount authority set and ceiling; configuration register | `FEE-FR-042`, `FEE-FR-043` | BLOCKED | 750 | **`FEE-GAP-007`** |
| `IMPL-706` | Currency/rounding policy tests against `Money` | `FEE-INV-001` | P2 | — | 700 |
| `IMPL-707` | ⛔ **BLOCKED** — due-date computation rule | `FEE-BR-005` | BLOCKED | 711 | **`FEE-GAP-006`** — rule undefined; depends on `BC-06` (`E-06`) |
| `IMPL-708` | Fee-structure audit trail emission | `FEE-FR-050`, `E-20` | P3 | — | 701, 780 |
| `IMPL-709` | Reserved — fee structure growth | — | — | — | — |

### 3.2 `IMPL-710` … `IMPL-724` — Fee obligations (`FeeDue`) and the snapshot invariant

| Task | Description | Traces to | Priority | Blocks | Blocked by |
|---|---|---|---|---|---|
| `IMPL-710` | `FeeDue` aggregate — amount, student record, tenant, status | `FEE-FR-007`…`012` | P1 | 711–724, 730 | 701, 703 |
| `IMPL-711` | Creation-time amount **snapshot**, immutable for life | `FEE-INV-002`, `FEE-AC-007`, `FEE-AC-010` | P1 | 712 | 710 |
| `IMPL-712` | Snapshot immunity under later fee-structure change | `FEE-INV-010`, `FEE-AC-079` | P1 | — | 711 |
| `IMPL-713` | `MembershipCreated/Renewed/Upgraded/Frozen` consumer → generate/adjust `FeeDue` | `FEE-FR-013`…`016`, `E-07` | P1 | 714 | 710 |
| `IMPL-714` | Idempotent event consumption — replay creates no duplicate obligation | `FEE-INV-005`, `FEE-BR-016` | P1 | — | 713, 731 |
| `IMPL-715` | Obligation state machine — `PENDING`/`PARTIAL`/`CONFIRMED`/`CANCELLED` transitions only as specified | `FEE-FR-017`…`020`, §29 | P1 | 716 | 710 |
| `IMPL-716` | Reject every unspecified transition with a domain error | `FEE-BR-008`, `FEE-AC-017` | P1 | — | 715 |
| `IMPL-717` | Obligation never created locally — only from a membership fact | `G-2`, `FEE-BR-003` | P1 | — | 713 |
| `IMPL-718` | ⛔ **BLOCKED** — correction path for a mis-entered obligation | `FEE-FR-061` | BLOCKED | — | **`FEE-GAP-005`** — no authorised correction path |
| `IMPL-719` | `StudentArchived` consumer — assert no outstanding dues, else block | `FEE-INV-004`, `FEE-AC-057`, `E-09` | P1 | — | 710, 740 |
| `IMPL-720` | Tenant isolation enforcement at the obligation repository | `FEE-INV-003`, `FEE-AC-002`, `FEE-AC-017` | P1 | — | 703 |
| `IMPL-721` | Obligation query API — by student record, by tenant | `FEE-FR-021`…`023` | P2 | 760 | 710 |
| `IMPL-722` | Proration **prohibition** — `BC-05` computes no prorated amount | `FEE-XC-*` (`MM-FR-100` deference) | P1 | — | 710 |
| `IMPL-723` | ⛔ **BLOCKED** — partial-payment obligation semantics | `FEE-FR-024`, `FEE-FR-025` | BLOCKED | — | **`FEE-GAP-008`** — V2 with a real V1 cost |
| `IMPL-724` | Reserved — obligation growth | — | — | — | — |

### 3.3 `IMPL-725` … `IMPL-734` — Invoices *(aggregate identity is unresolved)*

| Task | Description | Traces to | Priority | Blocks | Blocked by |
|---|---|---|---|---|---|
| `IMPL-725` | ⛔ **BLOCKED** — decide Invoice: distinct aggregate or issued form of `FeeDue` | §12 | BLOCKED | 726–729 | **`FEE-GAP-009`** |
| `IMPL-726` | ⛔ **BLOCKED** — invoice issuance | §12 | BLOCKED | — | 725 |
| `IMPL-727` | ⛔ **BLOCKED** — invoice numbering and immutability | §12 | BLOCKED | — | 725 |
| `IMPL-728` | ⛔ **BLOCKED** — invoice rendering/delivery | §12, §26 | BLOCKED | — | 725 |
| `IMPL-729` | Reserved — invoice growth | — | — | — | — |
| `IMPL-730` | `Payment` aggregate — amount, method, gateway reference, idempotency key | `FEE-FR-026`…`030` | P1 | 731–739 | 710 |
| `IMPL-731` | Idempotency key uniqueness — no two `CONFIRMED` share a key or gateway reference | `FEE-INV-005`, `FEE-AC-037`, `FEE-AC-040` | P1 | 714 | 730 |
| `IMPL-732` | Cash capture at reception — server-recorded | `FEE-FR-031`, `FEE-FR-032`, `G-3` | P1 | 740 | 730 |
| `IMPL-733` | UPI / card capture (V1 forms only) | `FEE-FR-033`, `FEE-FR-034` | P1 | 740 | 730 |
| `IMPL-734` | ⛔ **BLOCKED** — bank transfer | `FEE-FR-035` | BLOCKED | — | **`FEE-GAP-003`** — no source document |

### 3.4 `IMPL-735` … `IMPL-744` — Payment verification, gateway boundary, receipts

| Task | Description | Traces to | Priority | Blocks | Blocked by |
|---|---|---|---|---|---|
| `IMPL-735` | Server-side verification obligation — `BC-05`'s own half only | `FEE-FR-028`, `FEE-AC-085`…`089` | P1 | 736 | 730 |
| `IMPL-736` | `business.payment_intent` outbound port (`X-03`) — **no** endpoint, schema, signature, provider or retry policy | `FEE-PO-001`…`004` | P1 | — | 735 |
| `IMPL-737` | ⛔ **BLOCKED** — inbound webhook wire contract | `FEE-FR-028` residual | BLOCKED | — | **`FEE-GAP-016`** — transport has no declared owner; owner is `BC-31` once `PRD-019` exists |
| `IMPL-738` | Enforce `FEE-XC-005`/`FEE-XC-006` — `BC-05` holds, reads or transmits **no** gateway credential | `FEE-XC-005`, `FEE-XC-006` | P1 | — | 736 |
| `IMPL-739` | ⛔ **BLOCKED** — payment vendor selection. `BC-05` stays **vendor-blind** either way | `FEE-XC-006` | BLOCKED | — | **`FEE-GAP-010`** — no vendor chosen; owner **Architecture Owner**; resolve inside `BC-20`'s PRD |
| `IMPL-740` | `Receipt` issuance on confirmed payment | `FEE-FR-036`…`039` | P1 | 741 | 732, 733 |
| `IMPL-741` | Issued receipt **never changes** | `FEE-INV-006`, `FEE-AC-047` | P1 | — | 740 |
| `IMPL-742` | `FeePaymentReceived` event emission (`E-10`, V1 direct handler) | `FEE-EVT-001`, `FEE-FR-040` | P1 | — | 740 |
| `IMPL-743` | Remaining domain events | `FEE-EVT-002`, `FEE-EVT-003` | P2 | — | 740 |
| `IMPL-744` | Reserved — payment growth | — | — | — | — |

### 3.5 `IMPL-745` … `IMPL-754` — Discounts, refunds, corrections

| Task | Description | Traces to | Priority | Blocks | Blocked by |
|---|---|---|---|---|---|
| `IMPL-745` | Discount application — `discount ≤ original`, `payable ≥ 0` | `FEE-INV-007`, `FEE-AC-051` | P1 | — | 710 |
| `IMPL-746` | ⛔ **BLOCKED** — discount authority and ceiling enforcement | `FEE-FR-042`, `FEE-FR-043` | BLOCKED | — | **`FEE-GAP-007`**, 705 |
| `IMPL-747` | Refund V1 — confirmed-only, immutable original, separate operation, **full refund only**, cash server-recorded | `FEE-FR-044`…`047`, `ADR-0039` §3 | P2 | 748 | 740 |
| `IMPL-748` | Refund never mutates the original payment or receipt | `FEE-INV-006`, `FEE-INV-008` | P2 | — | 747 |
| `IMPL-749` | ⛔ **BLOCKED** — refund tier scope, Rank 6 EA still says `Refunds (V2)` | `FEE-BR-019` | BLOCKED | — | **`FEE-GAP-001`** — Product Owner + Architecture Owner |
| `IMPL-750` | Financial history append-only store | `FEE-INV-008`, `FEE-AC-055` | P1 | 751, 760 | 710, 730 |
| `IMPL-751` | History query — chronological, tenant-scoped | `FEE-FR-048`, `FEE-FR-049` | P2 | — | 750 |
| `IMPL-752` | ⛔ **BLOCKED** — long-term retention policy. V1 position exists: **purging is forbidden entirely** | `FEE-XC-011` | BLOCKED | — | **`FEE-GAP-011`** — long-term policy undefined; owner **Product Owner + Security/Compliance** |
| `IMPL-753` | ⛔ **BLOCKED** — renewal protection window, term arithmetic, cross-library disclosure | `FEE-BR-025`, `FEE-BR-026` | BLOCKED | — | **`FEE-GAP-013`** — one part measured **forbidden** |
| `IMPL-754` | Reserved — discount/refund growth | — | — | — | — |

### 3.6 `IMPL-755` … `IMPL-764` — Balance, outstanding dues, profile, reports

| Task | Description | Traces to | Priority | Blocks | Blocked by |
|---|---|---|---|---|---|
| `IMPL-755` | `balance = Σ dues − Σ receipts`, **computed, never stored** | `FEE-INV-009`, `FEE-AC-053`, `FEE-AC-054` | P1 | 756–760 | 710, 740 |
| `IMPL-756` | Outstanding-dues projection — no second ledger | `FEE-FR-051`…`053`, `G-6` | P1 | — | 755 |
| `IMPL-757` | Overdue determination | `FEE-FR-054` | P2 | — | 755, 707 |
| `IMPL-758` | Student financial profile read model | `FEE-FR-055`, `FEE-FR-056` | P2 | — | 755 |
| `IMPL-759` | Revenue dashboard — `BC-05` figures only | `FEE-FR-057`, `FEE-FR-058` | P3 | — | 755 |
| `IMPL-760` | Report tier boundary — analytics stays outside `BC-05` | `FEE-XC-*` §27 | P3 | — | 755 |
| `IMPL-761` | ⛔ **BLOCKED** — report tier and analytics edge | `FEE-BR-011` | BLOCKED | — | **`FEE-GAP-012`** |
| `IMPL-762` | Metric naming discipline — a revenue metric states whose revenue it means | `MP-SM-06` deference | P3 | — | 759 |
| `IMPL-763` | ⛔ **BLOCKED** — platform commission, settlement, platform revenue | §42 | BLOCKED | — | **`FEE-GAP-014`**, **`FEE-GAP-017`** — not `BC-05`'s to own |
| `IMPL-764` | Reserved — reporting growth | — | — | — | — |

### 3.7 `IMPL-765` … `IMPL-779` — Authorization, tenancy, audit, notification, offline

| Task | Description | Traces to | Priority | Blocks | Blocked by |
|---|---|---|---|---|---|
| `IMPL-765` | Permission checks on every financial write | `FEE-FR-059`, §23 | P1 | — | 710, 730 |
| `IMPL-766` | ⛔ **BLOCKED** — platform-configuration permission and role | `FEE-BR-014` | BLOCKED | — | **`FEE-GAP-015`** |
| `IMPL-767` | Tenant isolation — cross-tenant financial read is impossible | `FEE-INV-003`, `E-18`, `G-8` | P1 | — | 703, 720 |
| `IMPL-768` | Audit emission for every financially sensitive act | `FEE-FR-050`, `E-20`, `G-7` | P2 | 780 | 750 |
| `IMPL-769` | ⚠ Audit counterpart risk — `BC-24` `D-09` *"Unsatisfied"*, `X-10` not implemented | §33 | P2 | — | 768 |
| `IMPL-770` | Notification of financial facts only (V1) | `FEE-FR-060`, `E-23` | P3 | — | 740 |
| `IMPL-771` | ⛔ **BLOCKED** — offline financial write | `FEE-BR-016` (b) | BLOCKED | — | **`FEE-GAP-002`(c)** — `BC-05`→`BC-30` edges = **0**, no decision given |
| `IMPL-772` | Concurrency — two simultaneous payments on one obligation | `FEE-INV-005`, §34 | P1 | — | 731 |
| `IMPL-773` | Edge cases from §34 as executable tests | §34 | P2 | — | 710, 730 |
| `IMPL-774` | Entitlement counterpart risk — `BC-21` `D-08` *"Unsatisfied — no specification"* | `E-17`, §33 | P2 | — | 765 |
| `IMPL-775` | Configuration counterpart — `BC-25` maturity unverified | `E-19`, §33 | P2 | — | 712 |
| `IMPL-776` | `HolidayCalendar` sync port consumption | `E-06`, `FEE-PO-005` | P2 | 757 | 707 |
| `IMPL-777` | Enforce `FEE-BR-001` — no intra-cluster edge outside `E-01`…`E-10` | `FEE-BR-001` | P1 | — | — |
| `IMPL-778` | Enforce all 23 `FEE-XC-*` exclusions as **impossibilities**, not omissions | `FEE-XC-001`…`023` | P1 | — | — |
| `IMPL-779` | Reserved — platform boundary growth | — | — | — | — |

### 3.8 `IMPL-780` … `IMPL-789` — Acceptance criteria as executable tests

| Task | Description | Traces to | Priority | Blocks | Blocked by |
|---|---|---|---|---|---|
| `IMPL-780` | Test harness — tenant fixtures, `Money` builders, event doubles | §35 | P1 | 781–789 | 700, 703 |
| `IMPL-781` | `FEE-AC-001`…`020` as tests | 20 AC | P1 | — | 780 |
| `IMPL-782` | `FEE-AC-021`…`040` as tests | 20 AC | P1 | — | 780 |
| `IMPL-783` | `FEE-AC-041`…`060` as tests | 20 AC | P1 | — | 780 |
| `IMPL-784` | `FEE-AC-061`…`078` as tests | 18 AC | P2 | — | 780 |
| `IMPL-785` | `FEE-AC-079`…`084` as tests — incl. snapshot immunity | 6 AC | P1 | — | 712 |
| `IMPL-786` | `FEE-AC-085`…`089` as tests — `BC-05`'s verification obligation, no wire contract | 5 AC | P1 | — | 735 |
| `IMPL-787` | `FEE-AC-090`…`098` as tests | 9 AC | P2 | — | 780 |
| `IMPL-788` | Invariant property tests — all 10 `FEE-INV-*` | `FEE-INV-001`…`010` | P1 | — | 780 |
| `IMPL-789` | V1 success criteria verification (§40) | §40 | P2 | — | 781–788 |

### 3.9 `IMPL-790` … `IMPL-799` — Reserved for Revenue & Finance growth

`IMPL-790` … `IMPL-799` — **Reserved.** **17** open `FEE-GAP-*` may require tasks
once resolved. No number is pre-assigned; rule 1 forbids reassignment, so these
stay empty until a gap actually closes.

---

## 4. Traceability — task groups → requirements → invariants → acceptance

Rule 4 of Stage 6. Every group traces **back**; no group introduces scope.

| Task group | Requirements | Invariants | Acceptance | Open gaps blocking |
|---|---|---|---|---|
| `700`–`709` Fee structure | `FEE-FR-001`…`006`, `FEE-FR-042`, `FEE-FR-043`, `FEE-FR-050`, `FEE-BR-005` | `FEE-INV-001` | `FEE-AC-005` | `004`, `006`, `007` |
| `710`–`724` Obligations | `FEE-FR-007`…`025`, `FEE-FR-061`, `FEE-BR-003`, `FEE-BR-008`, `FEE-BR-016` | `FEE-INV-002`, `003`, `004`, `010` | `FEE-AC-002`, `007`, `010`, `017`, `057`, `079` | `005`, `008` |
| `725`–`729` Invoices | §12 | — | — | **`009`** (whole group) |
| `730`–`734` Payments | `FEE-FR-026`…`035` | `FEE-INV-005` | `FEE-AC-037`, `040` | `003` |
| `735`–`744` Verification & receipts | `FEE-FR-028`, `036`…`040`, `FEE-PO-001`…`004`, `FEE-XC-005`, `FEE-XC-006`, `FEE-EVT-001`…`003` | `FEE-INV-006` | `FEE-AC-047`, `085`…`089` | `010`, `016` |
| `745`–`754` Discounts/refunds/history | `FEE-FR-042`…`049`, `FEE-BR-019`, `FEE-BR-025`, `FEE-BR-026` | `FEE-INV-007`, `008` | `FEE-AC-051`, `055` | `001`, `007`, `011`, `013` |
| `755`–`764` Balance & reporting | `FEE-FR-051`…`058`, `FEE-BR-011` | `FEE-INV-009` | `FEE-AC-053`, `054` | `012`, `014`, `017` |
| `765`–`779` Authz/tenancy/audit/offline | `FEE-FR-059`, `060`, `FEE-BR-001`, `FEE-BR-014`, `FEE-BR-016`, `FEE-XC-001`…`023`, `FEE-PO-005` | `FEE-INV-003`, `005` | §34 cases | `002`(c), `015` |
| `780`–`789` Acceptance tests | §35 | all 10 | **all 98** | — |
| `790`–`799` Reserved | — | — | — | 17 open |

### 4.1 Coverage arithmetic

| Measure | Value |
|---|---|
Measured by `verify_tasks.py`, not asserted. The first version of this table
claimed **82** tasks and **14** blocked gaps; both were wrong, and the
measurement corrected them before this document was admitted anywhere.

| Measure | Value |
|---|---|
| Task rows `IMPL-700`…`IMPL-789` | **90** |
| — of which **Reserved** placeholders | **7** |
| **Substantive tasks** | **83** |
| Substantive tasks citing at least one requirement | **83 / 83** |
| Tasks that introduce a requirement | **0** |
| Duplicate or reused numbers (rule 1) | **0** |
| Tasks missing `Priority` (rule 3) | **0** |
| Invariants covered | **10 / 10** |
| Acceptance criteria covered | **98 / 98** (groups `781`–`787`) |
| `FEE-*` identifiers cited | **97** |
| Identifiers **invented** (absent from the PRD) | **0** |
| Tasks marked ⛔ **BLOCKED** by an open gap | **20** |
| Open gaps named as a blocker by at least one task | **17 / 17** |
| Open gaps closed by this document | **0** |
| PRD obligation count, before and after | **134 → 134** |

**Every one of the 17 open gaps blocks at least one task.** That is not a sign
of thoroughness; it is the measurement of how much of this module cannot yet be
built. Twenty of eighty-three tasks — just under a quarter — are unstartable
until a human authority rules.

Three of those gaps (`FEE-GAP-012` in part, `FEE-GAP-014`, `FEE-GAP-017`)
concern matters **`BC-05` does not own** — platform commission, settlement and
the report tier. Their tasks (`IMPL-761`, `IMPL-763`) exist precisely to record
that the work is **not** this module's, so that a later reader does not
implement it here by default.

---

## 5. What this document does **NOT** do

| Not claimed | Why |
|---|---|
| Does **not** implement anything | Zero files under `lib/` touched. `git diff` is empty. |
| Does **not** freeze `PRD-008` | Freeze is Stage 7 — the Governance Owner's act via an admission ADR and a baseline row. |
| Does **not** close any `FEE-GAP-*` | All **17** remain **OPEN**. 20 tasks are blocked *because* they remain open. |
| Does **not** create a requirement | 134 obligations before, 134 after. |
| Does **not** decide `FEE-GAP-001`/`009`/`010` | Refund tier, Invoice identity and vendor choice need a Product Owner or Architecture Owner ruling. Tasks are recorded **BLOCKED** rather than guessed. |
| Does **not** specify a wire contract | `IMPL-737` stays blocked; the webhook transport's owner is `BC-31` once `PRD-019` exists (`ADR-0040` §2/§4). |
| Does **not** resolve `FINDING A-2` | Credential handling is excluded from `BC-05` by `FEE-XC-005`. A-2 is a `BC-31` matter. |
| Does **not** amend `PRD_LIFECYCLE.md` | Its stale `IMPL-227`+ row is recorded in §1.1, not edited. Rank 2 governance edits need a governance act. |
| Does **not** rank itself | Backlog record. Not in `DOCUMENTATION_BASELINE.md`; editable without an ADR. |
| Does **not** assert an ARB meeting | No ARB meeting was held, minuted or attended. No quorum, attendee list or sign-off date is asserted. |

### 5.1 Prerequisites this document relies on, by hash

Stage 6 is lawful here because Stages 3 and 4 were **conferred**, not because the
work felt complete (`PRD_LIFECYCLE.md` L48). The prerequisites are named by
content hash so a later reader can prove which bytes were relied on:

| Prerequisite | sha256 (16) | State |
|---|---|---|
| `PRD-008_REVENUE-AND-FINANCE.md` v1.7 | `d24832f33e600518` | the source of truth; **unchanged** by this document |
| `PRD-008_STAGE3_CONFERRAL.md` | `59eeea6d4e2fa284` | Stage 3 ✅ **CONFERRED**, 6 of 6 |
| `PRD-008_STAGE4_CONFERRAL.md` | `18adf00ddfce9291` | Stage 4 ✅ **CONFERRED**, C1–C7, 0 failures |
| `prd008_stage5.py` | — | Stage 5 gate **exit 0** |

**Stage 6 requires none of the following, and none is claimed:** a
`DOCUMENTATION_BASELINE.md` §3 row (that is the **Stage 7** gate, which comes
*after* this stage), a non-`DRAFT` status, or the existence of `PRD-019`.
Precedent: `PRD-006_IMPLEMENTATION_TASKS.md` was lawfully written while `PRD-006`
was **`DRAFT`** with **⚠️ CONDITIONAL** Stage 3 and Stage 4 verdicts — a weaker
position than `PRD-008` holds here.

---

## 6. References

| Document | Used for |
|---|---|
| `PRD_LIFECYCLE.md` L135–153 | the Stage 6 gate and the four allocation rules |
| `PRD-008_REVENUE-AND-FINANCE.md` v1.7 | every requirement, invariant and acceptance criterion cited |
| `PRD-008_STAGE3_CONFERRAL.md` | Stage 3 conferred |
| `PRD-008_STAGE4_CONFERRAL.md` | Stage 4 conferred |
| `PRD-006_IMPLEMENTATION_TASKS.md` | the Stage 6 document template and the `IMPL-700`+ frontier |
| `ADR-0039` §3 | refund V1 shape — cited, not extended |
| `ADR-0040` §1, §2, §4 | ingress ownership; wire contract left open |
| `ADR-0033` §7.1 | conferral is not a standing licence |

---

**Stage 6 of 9 — task document recorded, range `IMPL-700`…`IMPL-799` allocated.**
`PRD-008` remains **`DRAFT`** and **unfrozen** with **17** open gaps and **20**
blocked tasks. **Nothing is implemented.**
