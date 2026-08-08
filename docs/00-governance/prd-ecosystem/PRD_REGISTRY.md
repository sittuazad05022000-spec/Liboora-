# LIBOORA — PRD Registry

| Field | Value |
|---|---|
| **Document** | PRD Registry — the single source of truth for the PRD ecosystem |
| **Version** | v1.2 |
| **Status** | Active register of record |
| **Date** | 2026-08-04 |
| **Baseline** | `BASELINE-2026-08-04` |
| **Authority** | **Navigational and administrative only.** This register records *where* specifications are and *what state they are in*. It does **not** create, modify, reinterpret or override a single requirement |
| **Precedence** | Below every document it lists. Where this register disagrees with a PRD, **the PRD is right and this register is a defect** |

---

## 1. What this register is, and the one thing it must never become

The PRD ecosystem grew to five specification documents across three bounded contexts, plus a Master PRD, nine
named-but-unwritten PRDs, and eight bounded contexts carrying product obligations with no PRD at all. Answering
*"which specifications exist, what state are they in, and what depends on them?"* required reading a dozen files
and remembering the answer.

This register answers it in one place.

> **The failure mode this register must avoid.** A registry that restates requirements becomes a second source of
> truth, and the second source is always the stale one. **Nothing here is normative.** Every row points at a
> document; the document governs. If you need to know what a PRD *requires*, this register has failed you and you
> should open the PRD.

`DOCUMENTATION_BASELINE.md` §4 remains the precedence authority. This register does not rank documents; it
records the rank that document assigns.

---

## 2. Status vocabulary — closed set

A PRD is in **exactly one** of these states. No other value is permitted in the Status column.

| Status | Meaning | Entry evidence required |
|---|---|---|
| `PLANNED` | Named as needed. No content, no owner assigned, no discovery started | Named in the Master PRD, a roadmap or this register |
| `DISCOVERY` | Problem space under active investigation. No draft exists | A discovery note or open question register |
| `DRAFT` | Content exists and is being written. Not yet submitted for review | A document on disk with a version header |
| `IN_REVIEW` | Submitted for architecture and requirements review; findings open | A review or alignment document in progress |
| `APPROVED` | Review complete, findings dispositioned, declared authoritative | An alignment/validation record with a verdict |
| `FROZEN` | Approved **and** admitted to the documentation baseline. Change requires an ADR *before* the change | A row in `DOCUMENTATION_BASELINE.md` §3 |
| `IMPLEMENTING` | Frozen and implementation tasks are open and in progress | ≥1 task in progress in an implementation-task document |
| `IMPLEMENTED` | Every implementation task closed | All tasks closed |
| `VERIFIED` | Every acceptance criterion proven by an automated test or a recorded repeatable procedure | Acceptance-verification task closed |

### 2.1 How `FROZEN` is determined here — and why it is not read off the PRD

**No PRD in this repository declares itself frozen in a status field.** Verified: `Authentication_PRD_v2.md`,
`Library_PRD_v1.md`, `14B-Public-Library-Preview.md` and `INVITATION_SECURITY_SPECIFICATION.md` contain **zero**
occurrences of the words *frozen* or *freeze*; `Student_Identity_PRD_v1.md` contains one, and it refers to the
*architecture*, not to itself.

Freeze is therefore **not self-declared**. It is conferred externally by admission to the baseline, and the
operative rule is `DOCUMENTATION_BASELINE.md` §7:

> *"A change to any Rank 1–5 document requires an ADR **before** the change."*

That sentence *is* the freeze. Every document at Rank 1–5 in §3 of the baseline is frozen in the sense this
register uses, whether or not the word appears in it.

This distinction is recorded because the obvious implementation of a registry — grep each PRD for its own status —
would have marked all five specifications **not** frozen and been wrong about every one of them.

### 2.2 Statuses that look adjacent but are not

| Not the same | Difference |
|---|---|
| `APPROVED` vs `FROZEN` | Approved is a review outcome. Frozen is a governance constraint. A document can be approved and still editable; a frozen one needs an ADR first |
| `IMPLEMENTED` vs `VERIFIED` | Implemented means the tasks are closed. Verified means the acceptance criteria are *proven*. Per `SID-4.56`, *"a rule that cannot be checked SHALL be treated as unmet"* — so the gap between these two is not paperwork |
| `PLANNED` vs `DISCOVERY` | Planned means someone wrote the name down. Discovery means someone is doing work |

---

## 3. The register — existing PRDs

Six documents carry normative product requirements. **Four of them are one PRD.**

### 3.1 `PRD-000` — Master PRD

| Field | Value |
|---|---|
| **PRD ID** | `PRD-000` |
| **Name** | Master PRD |
| **Document** | [`../../30-product/MASTER_PRD.md`](../../30-product/MASTER_PRD.md) |
| **Bounded context** | **None — platform-wide.** Owns no aggregate |
| **Domain** | Platform governance |
| **Current status** | **`FROZEN`** |
| **Version** | v1.7 |
| **Owner** | Product Owner · Domain Owner: *n/a — this is the register itself* · Architecture Owner: ARB · Technical Owner: Platform Engineering — [`PRD_OWNERSHIP_MODEL.md`](./PRD_OWNERSHIP_MODEL.md) |
| **Dependencies** | None. It is the root |
| **Dependents** | **All** — every PRD below, plus the Bounded Context Map and Enterprise Architecture |
| **Related ADRs** | `ADR-0011` amends `MP-GBR-02` |
| **Related implementation tasks** | None directly. `MP-DEP-06` is discharged by `IMPL-014` |
| **Implementation status** | Not applicable — global rules are enforced *through* module implementations, not as a module |
| **Freeze status** | **Frozen.** Rank 1, baseline §3.3. Changing `MP-GBR-*`, `MP-CON-*` or `MP-DEP-*` requires an ADR first |

Identifier namespace: `MP-GBR-01`…`38` · `MP-CON-01`…`16` · `MP-DEP-01`…`08` · `MP-RSK-01`…`08` · `Q-01`…`Q-07`.

**Precedence note.** Rank 1 applies to the Master PRD's *global rules*. §8's module table is a directory of
modules, not a specification of them — §1.1 states the Master PRD *"does not contain detailed feature
specifications for individual modules."* Reading §8 as a requirement source is a category error.

### 3.2 `PRD-001` — Authentication

| Field | Value |
|---|---|
| **PRD ID** | `PRD-001` |
| **Name** | Authentication |
| **Document** | [`../../30-product/authentication/Authentication_PRD_v2.md`](../../30-product/authentication/Authentication_PRD_v2.md) + `prd-v2/00`…`11` |
| **Bounded context** | **`BC-18` Identity & Access** |
| **Domain** | Identity & Access `[GENERIC]` |
| **Current status** | **`FROZEN`** |
| **Version** | **v2.0** — self-described *"PRODUCTION-READY — AUTHORITATIVE"* |
| **Owner** | Product Owner · Domain Owner: Identity Platform (`BC-18`) · Architecture Owner: ARB · Technical Owner: Platform Engineering — [`PRD_OWNERSHIP_MODEL.md`](./PRD_OWNERSHIP_MODEL.md) §4.1 |
| **Dependencies** | `PRD-000` global rules |
| **Dependents** | `PRD-002` (authorisation for protected operations, invitation acceptance) · `PRD-003` (atomic account+identity creation, `E-12`) |
| **Related ADRs** | `ADR-0002` · `ADR-0003` · `ADR-0004` · `ADR-0005` · `ADR-0006` · `ADR-0007` · **`ADR-0008`** (declares this the official baseline) |
| **Related implementation tasks** | `IMPL-030`, `IMPL-031`, `IMPL-040`, `IMPL-041`, `IMPL-050`…`052`, `IMPL-060`…`062`, `IMPL-070`…`073`; checklist in `AUTHENTICATION_IMPLEMENTATION_CHECKLIST.md` |
| **Implementation status** | **Partial.** Scaffold exists; `TASK-D10` demo surfaces are a **P0 release blocker**; `IMPL-020` SMS/DLT unstarted — no OTP can be delivered |
| **Freeze status** | **Frozen.** Rank 3, baseline §3.3 (`BASELINE-2026-08-02`) |

Registers: 1,517 normative identifiers — `AUTH-c.n` (588) · `BR-c.n` (297) · `XC-c.n` (212) · `AC-c.n` (321) ·
`EV-n` (26) · `AERR-n` (13) · `CFG-n` (12) · plus `PR`, `TR`, `SO`, `PP`, `AU`, `EP`.

Provenance: **authored, not recovered.** The v1.0 chapters were never transferred — all eleven files held headers
and zero body text. Recorded in `PRD-V2-GOVERNANCE-NOTE.md`; the empty slots are archived at
`docs/90-archive/authentication-v1/empty-slots/`. Defect `D-7` closed **by authorship**, not by transfer.

### 3.3 `PRD-002` — Library Management

> **This PRD is four documents.** The Master PRD §31 and `library/README.md` both state it: *"The Library PRD
> means **all four**"*. A requirement read from one alone will be implemented wrongly, because most
> security-relevant constraints are cross-references.

| Field | Value |
|---|---|
| **PRD ID** | `PRD-002` |
| **Name** | Library Management (Organization & Library Management) |
| **Documents** | [`Library_PRD_v1.md`](../../30-product/library/Library_PRD_v1.md) §§1–25 · [`14A`](../../30-product/library/14A-Library-Discovery-And-Enrollment.md) · [`14B`](../../30-product/library/14B-Public-Library-Preview.md) · [`INVITATION_SECURITY_SPECIFICATION.md`](../../30-product/library/INVITATION_SECURITY_SPECIFICATION.md) |
| **Bounded contexts** | **`BC-19` Tenancy · `BC-06` Library Policy · `BC-25` Configuration · `BC-29` File & Media** |
| **Domain** | Library Management `[CORE]` |
| **Current status** | **`FROZEN`** |
| **Version** | v1.0 (Startup MVP) |
| **Owner** | Product Owner · Domain Owner: Library Domain (undisputed contexts incl. `BC-06`); ⚠ **Contested** for `BC-19`, `BC-25`, `BC-29` · Architecture Owner: ARB · Technical Owner: Platform Engineering — [`PRD_OWNERSHIP_MODEL.md`](./PRD_OWNERSHIP_MODEL.md) §4.1, §4.4 |
| **Dependencies** | `PRD-000` · `PRD-001` (all authorisation) · `PRD-003` (`E-13` identity resolution) |
| **Dependents** | None among existing PRDs. **Nine unwritten PRDs depend on it** — see [`PRD_DEPENDENCY_GRAPH.md`](./PRD_DEPENDENCY_GRAPH.md) |
| **Related ADRs** | **`ADR-0009`** (invitation is a revocable claim, never a credential) · **`ADR-0010`** (public preview served anonymously from a projection) · rulings `AR-1`, `AR-3`, `AR-4` |
| **Related implementation tasks** | **`IMPL-100`…`IMPL-127`** — 23 tasks, 12 at P0 |
| **Implementation status** | **`FROZEN`, not `IMPLEMENTING`.** Implementation is *"entirely unstarted"* (Master PRD §31) — **0 of 23 tasks begun** |
| **Freeze status** | **Frozen.** Rank 3, baseline §3.3 (`BASELINE-2026-08-03`) |

Registers: ~422 identifiers — `LIB-n.m` (~130) · `LIB-14B.n` (51) · `LIB-DISC-n` (13) · `INV-SEC-n` (71) ·
`LBR`, `LIB-PREV`, `LXC`, `INV-XC`, `LAC`, `LAC-14B`, `IAC`, `LCFG`, `ICFG`, `PO-1`…`PO-12`, `LEV-1`…`LEV-28`.

**Note on §14A.** It carries a provenance block (*"RECEIVED VERBATIM · REVIEW COMPLETE · FROZEN 2026-08-03"*) but
**no version/status header row** of the kind the other three carry. Its version is established externally by
`DOCUMENTATION_BASELINE.md` §3.3, which lists it at v1.0. Recorded as a **cosmetic inconsistency, not a defect** —
see [`PRD_GAP_ANALYSIS.md`](./PRD_GAP_ANALYSIS.md) §7.

### 3.4 `PRD-003` — Student Identity & Profile

| Field | Value |
|---|---|
| **PRD ID** | `PRD-003` |
| **Name** | Student Identity & Profile |
| **Document** | [`../../30-product/student-identity/Student_Identity_PRD_v1.md`](../../30-product/student-identity/Student_Identity_PRD_v1.md) |
| **Bounded context** | **`BC-10` Global Person Identity** `[CORE]`, **rank 7.5** |
| **Domain** | Platform Identity — *its own tier*, below every domain module and above every capability platform |
| **Current status** | **`IMPLEMENTING`** |
| **Version** | v1.0 (Startup MVP) |
| **Owner** | Product Owner · Domain Owner: Person Domain (`BC-10`) · Architecture Owner: ARB · Technical Owner: Platform Engineering — [`PRD_OWNERSHIP_MODEL.md`](./PRD_OWNERSHIP_MODEL.md) §4.1 |
| **Dependencies** | `PRD-000` (amended `MP-GBR-02`) · `PRD-001` (`E-12` atomic creation) |
| **Dependents** | `PRD-002` (`E-13` ACL) · future `MP-FUT-01`…`05` · `BC-11`…`BC-13` as **consumers** |
| **Related ADRs** | **`ADR-0011`** (the governing decision) · `ADR-0012` (scaffold port-inversion debt) |
| **Related implementation tasks** | **`IMPL-200`…`IMPL-208`, `IMPL-210`…`IMPL-216`, `IMPL-220`…`IMPL-226`** — 25 tasks, 17 at P0 |
| **Implementation status** | **Partial.** `IMPL-200`, `IMPL-201`, `IMPL-207`, `IMPL-208` and `IMPL-014` **implemented** (`a22fd7e`). `IMPL-220` **unblocked but not done** — `SID-INT-1`…`12` are review-verified only and therefore **unmet** per `SID-4.56` |
| **Freeze status** | **Frozen.** Rank 3, baseline §3.3 (`BASELINE-2026-08-04`) |

Registers: 343 identifiers — `SID-c.n` (226) · `SID-BR-n` (18) · `SXC-n` (11) · `SPO-n` (9) · `SEV-n` (16) ·
`SID-INT-n` (12) · `SID-INV-n` (14) · `SCFG-n` (11) · `SID-AC-n` (26). All nine ranges verified contiguous.

**Why this is `IMPLEMENTING` while `PRD-002` — frozen a day earlier — is not.** Status here tracks *code*, not
document maturity. Student Identity had scaffold code implementing the **superseded** pre-`ADR-0011` model, so its
first tasks were a **migration**. Library Management has no code at all. A registry that ordered these by freeze
date would imply Library was further along; it is not.

### 3.5 Records that are not PRDs

Listed so nobody mistakes a record for a specification. `DOCUMENTATION_BASELINE.md` §3.3 marks each *"not part of
the specification"*.

| Document | What it is |
|---|---|
| `library/LIBRARY_PRD_ALIGNMENT.md` | Validation record — the 14 conflicts found and their disposition |
| `library/REVIEW_14A.md` | Historical review record |
| `student-identity/STUDENT_IDENTITY_ALIGNMENT.md` | Validation record — `SC-1`…`SC-13`, 11 accepted, **2 rejected** |
| `authentication/PRD-V2-GOVERNANCE-NOTE.md` | Provenance record — explicitly *"not part of the specification"* |
| `library/README.md`, `student-identity/README.md`, `authentication/README.md` | Module indexes — navigational |
| `docs/90-archive/**` | **No authority.** Retained for history |

---

## 4. The register — PRDs that do not exist

**Nothing in this section is a new requirement.** Every row is a document the repository *already says should
exist*. The evidence is cited per row; where the repository names no owning context, the row says so rather than
inventing one.

### 4.1 Named in Master PRD §31 and never written

The §31 Linked Documents table carries this row verbatim:

> *"Student Management · Membership · Attendance · Seat · Revenue & Finance · Analytics · Notifications ·
> Security & Automation · AI Super Assistant PRDs | Listed in v1.0"*

*"Listed in v1.0"* means the v1.0 Master PRD named them. **None was ever written.** All nine are `PLANNED`.

| PRD ID | Name | Bounded context | Type | V | Status | Blocks |
|---|---|---|---|---|---|---|
| `PRD-004` | Student Management | **`BC-01` Enrollment** | `[CORE]` | V1 | `PLANNED` | `PRD-005`…`008`; `IMPL-214` `E-13` ACL |
| `PRD-005` | Membership Management | **`BC-02` Membership** | `[CORE]` | V1 | `PLANNED` | `PRD-006`, `PRD-007`, `PRD-008` |
| `PRD-006` | Attendance Management | **`BC-03` Attendance** | `[CORE]` | V1 | `PLANNED` | Occupancy in `PRD-007` |
| `PRD-007` | Seat Management | **`BC-04` Seating** | `[CORE]` | V1 | `PLANNED` | — |
| `PRD-008` | Revenue & Finance | **`BC-05` Fee & Collection** | `[CORE]` | V1 | `PLANNED` | — |
| `PRD-009` | Analytics & Reports | **`BC-26` Analytics Read Model** | `[GENERIC]` | V1 | `PLANNED` | Dashboards (modules 10–12) |
| `PRD-010` | Notifications & Communication | **`BC-22` Notification Delivery** | `[GENERIC]` | V1 | `PLANNED` | Every event-driven notice |
| `PRD-011` | AI Super Assistant | **`BC-27` AI Assistance** | `[SUPPORTING]` | V1 | `PLANNED` | — |
| `PRD-012` | Security & Automation | ⚠ **`SECURITY` platform + `BC-28` Workflow** | mixed | V1/V2 | `PLANNED` | — |

> ⚠ **`PRD-012` must not be written as one PRD.** Master PRD §8 Correction 2 states: *"A single module name
> spanning two owners at two ranks violates the Single Owner Rule (EA §10.1.1)."* Writing it as one document
> would re-create the violation the correction removed. See [`PRD_GAP_ANALYSIS.md`](./PRD_GAP_ANALYSIS.md) §5.
>
> **`PRD-012` is therefore a placeholder that will never be authored.** When the work is specified it becomes two
> registered documents, and the suffixed identifiers below are reserved now so that nothing else claims them:
>
> | PRD ID | Name | Owner | Type | V | Status |
> |---|---|---|---|---|---|
> | `PRD-012a` | Security Automation | **SECURITY platform (rank 2)** | `[GENERIC]` | V1 | `PLANNED` |
> | `PRD-012b` | Workflow Orchestration | **`BC-28` Workflow Orchestration** | `[SUPPORTING]` | V2 | `PLANNED` |
>
> The two differ in owner, rank **and** release version — which is precisely why one document cannot hold them.
> `PRD-012` itself is retired on the day `PRD-012a` is opened; its number is **not** reused (§8 rule 1).

### 4.2 Bounded contexts with product obligations and no PRD

Master PRD §8.1: these *"carry product-visible obligations but had no module entry. Listed here so they receive
requirements, budgets and owners."* The obligation is the Master PRD's, not this register's.

| PRD ID | Name | Bounded context | Type | V | Status | Why V1 |
|---|---|---|---|---|---|---|
| `PRD-013` | Tenancy | **`BC-19`** | `[GENERIC]` | V1 | `PLANNED` | *"Nothing multi-tenant works without it"* |
| `PRD-014` | Entitlement | **`BC-21`** | `[GENERIC]` | V1 | `PLANNED` | *"Every paid gate depends on it"* |
| `PRD-015` | Search Indexing | **`BC-23`** | `[GENERIC]` | V1 | `PLANNED` | Permission-aware, tenant-partitioned search |
| `PRD-016` | Audit Trail | **`BC-24`** | `[GENERIC]` | V1 | `PLANNED` | Required by *"every critical action is auditable"* |
| `PRD-017` | File & Media | **`BC-29`** | `[GENERIC]` | V1 | `PLANNED` | Documents, uploads, signed URLs, virus scan |
| `PRD-018` | Offline Sync | **`BC-30`** | `[GENERIC]` | V1 | `PLANNED` | *"Attendance capture in a basement with no signal"* |
| `PRD-019` | Integration | **`BC-31`** | `[GENERIC]` | V1 | `PLANNED` | Outbound contracts, retries, idempotent delivery |
| `PRD-020` | Trust & Safety | **`BC-13`** ⚠ | **`[CORE]`** | V1 | `PLANNED` | *"On a minor-heavy product, is existential legal risk"* |
| `PRD-021` | Social Graph & Messaging | **`BC-11`, `BC-12`** | `[SUPPORTING]` | V1 | `PLANNED` | Named in §8.1 with `BC-13` |

> ⚠ **`PRD-020` carries the highest unmitigated product risk in the register.** `BC-13` is classified `[CORE]`
> *despite living in a Supporting platform*, and `MP-RSK-02` — *"minor-safety incident on the social product"* —
> is **Critical** with mitigation *"`BC-13` Trust & Safety at V1"*. That mitigation is a bounded context with no
> specification, no tasks and no owner.

### 4.3 Registered outside both Master PRD lists

One V1 bounded context is named in neither §31's nine nor §8.1's eight, yet owns aggregates and V1 obligations.
It is registered here rather than left in §4.4, because §4.4 is *"not a recommendation to write documents"* and
this one **is**.

| PRD ID | Name | Bounded context | Type | V | Status | Why registered |
|---|---|---|---|---|---|---|
| `PRD-022` | SaaS Billing | **`BC-20` Subscription & Billing** | `[GENERIC]` | V1 | `PLANNED` | Master PRD §8 module 17; owns `Subscription` · `SubscriptionInvoice`; sole writer of entitlement inputs |

> **Why this is a distinct PRD and not part of `PRD-008` Revenue & Finance.** The Bounded Context Map's
> terminology table separates the two at three points: `Payment`, `Plan` and `Invoice` each mean different things
> in `BC-05` and `BC-20`. `BC-05` is money **student → library**; `BC-20` is money **library → LIBOORA**. Merging
> them would collapse `FeePayment` into `SubscriptionCharge` and put a library's revenue in the same aggregate as
> LIBOORA's. Disposition in [`PRD_GAP_ANALYSIS.md`](./PRD_GAP_ANALYSIS.md) `PGA-05`.

### 4.4 Contexts and surfaces with no PRD and no §8.1 obligation

Recorded for completeness. **These are not recommendations to write documents** — several should never be
separate PRDs, and [`PRD_GAP_ANALYSIS.md`](./PRD_GAP_ANALYSIS.md) §6 explains which and why.

| Context / surface | Type | V | Registry position |
|---|---|---|---|
| `BC-25` Configuration (Settings, module 18) | `[GENERIC]` | V1 | **Covered** — `PRD-002` owns `BC-25` |
| Dashboards — Owner, Manager, Reception (modules 10–12) | *not contexts* | V1 | **No PRD.** Presentation compositions; own no aggregate |
| Parent Portal (module 5) | *not a context* | V1 | **No PRD.** Composition over `BC-01`/`03`/`05` |
| Library Member Directory (module 3) | read composition | V1 | **No PRD.** Belongs to `PRD-004` |
| Library Discovery & Enrollment (module 19) | *not a context* | V1 | **Covered** — `PRD-002` §14A/§14B |
| `BC-07`…`BC-09`, `BC-14`, `BC-15`, `BC-28` | `[SUPPORTING]`/`[GENERIC]` | V2 | `PLANNED` — correctly deferred |
| `BC-16`, `BC-17` | `[SUPPORTING]` | V3 | `PLANNED` — correctly deferred |
| `MP-FUT-01`…`MP-FUT-05` | Future | Future | **Not planned, by policy** — EA §10.3: *"do not design for it now, only avoid blocking it"* |

---

## 5. Ownership — closed by a role-based model

**Status: closed 2026-08-04 by [`PRD_OWNERSHIP_MODEL.md`](./PRD_OWNERSHIP_MODEL.md).** Every `Owner` field above now
carries four organizational roles. The original finding is preserved below because it explains *why* the model is
role-based, and the reasoning still governs: **no personal name may ever be recorded here.**

The gap was resolved not by finding names but by establishing that names were the wrong thing to record. Four roles —
**Product Owner · Domain Owner · Architecture Owner · Technical Owner** — were *derived* from six governance rules
this repository already enforced, using vocabulary (*"product owner"*, *"Architecture Review Board"*, *"DDD
reviewer"*) that `ADR-0001`, `ADR-0011`, `ADR-0012` and Dependency Matrix §11 already used.

Two findings surfaced *because* ownership was assigned systematically, neither of which was visible while every field
read *Unassigned*:

* **`PRD-012` is unassignable** under the one-holder-per-role rule as currently scoped — it spans the SECURITY
  platform (rank 2) and `BC-28` Workflow (rank 6). §4.1 already flagged this as violating the Single Owner Rule;
  the ownership model records it as unassignable rather than inventing a single owner to fill the cell.
* **`BC-25` Configuration has no registered claimant.** `PRD-015` is *Search Indexing*, so unlike `BC-19` and
  `BC-29` there is no second PRD contesting the Library PRD's header claim — there is nothing to transfer it to.
  This is why `ADR-0013` §7 leaves `BC-25` open and why no `PRD-023` is allocated.

**Assigning ownership is what made these visible.** An empty field hides a conflict as effectively as a wrong one.

### 5.1 The original finding (preserved)

**Every `Owner` field above read *Unassigned*, and that was a finding, not an omission in this register.**

Searched: no PRD carries a document owner, a team name or an accountable individual. The only `Owner` strings in
`docs/30-product/` are `Owner Name` (a library's proprietor, `LIB-6.x`), *"Owner authentication credential"*, and
the Invitation Security Specification's `Owner` field — which names a **bounded context**, `BC-19`, not a person.

So the repository consistently records **context ownership** and never records **document ownership**. The
architectural rule *"every bounded context must have explicit ownership"* is satisfied — every context has exactly
one owning module, enforced by `tool/check_module_boundaries.dart`. The governance rule *"every PRD has an owner"*
is **not** satisfied, because no such field exists anywhere.

Filling these in would require inventing names. This register recorded the gap instead; disposition in
[`PRD_GAP_ANALYSIS.md`](./PRD_GAP_ANALYSIS.md) §8.

**That last paragraph was right about the constraint and wrong about the conclusion.** Inventing names was indeed
inadmissible — but *document ownership* never required names, only accountable roles, and the roles already existed
in the repository's own decision records. The distinction this section drew between **context ownership** (an
architectural fact, enforced in code) and **document ownership** (a governance fact) is preserved intact by the
model; conflating the two is what produced `PGA-11`.

---

## 6. Bounded-context ownership

Verified against the Bounded Context Map's 31 contexts.

| Context | Owning PRD | Contested? |
|---|---|---|
| `BC-18` | `PRD-001` | No |
| `BC-06` | `PRD-002` | No |
| `BC-19` | `PRD-002` **and** `PRD-013` | ⚠ **Yes** |
| `BC-25` | `PRD-002` header — **no second claimant** | ⚠ **Yes** (§6.1) |
| `BC-29` | `PRD-002` **and** `PRD-017` | ⚠ **Yes** |
| `BC-10` | `PRD-003` | No |
| `BC-20` | `PRD-022` | No |
| `BC-01`…`BC-05`, `BC-11`…`BC-13`, `BC-21`…`BC-24`, `BC-26`, `BC-27`, `BC-30`, `BC-31` | *(unwritten `PRD-004`…`021`)* | No |
| `BC-07`…`BC-09`, `BC-14`…`BC-17`, `BC-28` | None — V2/V3 | No |

**Among the three frozen module PRDs there is no overlap**, exactly as `DOCUMENTATION_BASELINE.md` §4 requires:
*"Rank 3 holds three module baselines and they do not overlap."* `PRD-001`, `PRD-002` and `PRD-003` are disjoint.

### 6.1 The three contested contexts — `BC-19`, `BC-25` and `BC-29`

The collision is **not** between two written PRDs. It is between a written one and the Master PRD's own list of
contexts that still need PRDs.

- `Library_PRD_v1.md` line 10 declares its **owning contexts** as *"`BC-19` Tenancy · `BC-06` Library Policy ·
  `BC-25` Configuration · `BC-29` File & Media."*
- Master PRD §8.1 lists `BC-19` and `BC-29` among contexts that *"carry product-visible obligations but had no
  module entry. Listed here so they receive requirements, budgets and owners"* — which is why this register
  carries `PRD-013` Tenancy and `PRD-017` File & Media at all.

**`BC-25` Configuration is contested on identical grounds, and this register recorded it as uncontested until
2026-08-04.** The correction is noted here rather than quietly applied: the row above previously read
*"`BC-06`, `BC-25` | `PRD-002` | No"*. The reason the conflict was invisible is that `BC-25` appears in neither
Master PRD §31's nine nor §8.1's eight, so **no registered PRD contests the header claim** — there was no second
claimant to collide with in a PRD-to-PRD comparison. But `LIBOORA_BOUNDED_CONTEXT_MAP.md` gives its
*"Owning Platform"* as **Configuration** (`platform/configuration`, rank 3), which contradicts a rank-8 domain PRD
owning it for exactly the `L2` reason given in the evidence table below.

`BC-25` is therefore the **asymmetric** case: contested, but not resolvable by transferring it to another PRD,
because there is no PRD to transfer it to. [`ADR-0013`](../adr/ADR-0013-capability-context-ownership.md) §7 leaves
its owner **deliberately open** — allocating a `PRD-023` here would pre-empt that decision, and inventing a
requirement is forbidden.

Both statements cannot be true as written. Three pieces of evidence indicate the **Library PRD's header
over-claims**, and that the capability contexts are platform-owned:

| Evidence | What it shows |
|---|---|
| `Library_PRD_v1.md` line 1094 | Its own data table gives `BC-29` as **"References by id"** — *not* "Owns", unlike the `BC-19`/`BC-06`/`BC-25` rows. The header contradicts the body. |
| `SID-4.36` | Assigns upload, scanning, thumbnailing and signed-URL issuance to `BC-29` and forbids other modules re-implementing them — a shared capability, not library-owned. |
| `tool/module_dependencies.yaml` | `domain/library` (rank **8**) reaches `platform/tenancy:tenant_context` (rank 4) and `platform/services:files` (rank 3) as **ports**. A rank-8 consumer cannot own a rank-3/4 capability without inverting `L2`. |

**Precedence resolves the reading, not the conflict.** `DOCUMENTATION_BASELINE.md` §4 puts Master PRD global
structure at Rank 1 and module PRDs at Rank 3, so `PRD-013`/`PRD-017` are the provisional owners of the
capabilities and `PRD-002` owns the tenant-facing library data that *uses* them. This register applies that
reading and flags it — **it does not settle it.** Settling it means amending a frozen Rank-3 document, which
`DOCUMENTATION_BASELINE.md` §7 requires an ADR to do first.

Recorded as [`PRD_GAP_ANALYSIS.md`](./PRD_GAP_ANALYSIS.md) `PGA-11`. Until that ADR exists, **`BC-19`, `BC-25` and `BC-29`
are the only three contexts in the product without a single undisputed owner.**

### 6.2 One case that looks like an overlap and is not

`PRD-003` §4.8 requires the Global Profile Photo to be *"held as a `FileRef` issued by `BC-29`"*. That is
**consumption, not ownership** — `SID-4.36` forbids `BC-10` from re-implementing or bypassing file handling. A
dependency edge, recorded in [`PRD_DEPENDENCY_GRAPH.md`](./PRD_DEPENDENCY_GRAPH.md) §4.

---

## 7. Summary counts

| Measure | Count |
|---|---|
| **PRDs registered** | **23** — `PRD-000`…`PRD-022` |
| **Documents that exist** | **6 files, 4 PRD identities** (`PRD-000`…`PRD-003`) |
| `FROZEN` | **3** — `PRD-000`, `PRD-001`, `PRD-002` |
| `IMPLEMENTING` | **1** — `PRD-003` |
| `PLANNED` | **19** — `PRD-004`…`PRD-022` |
| `DISCOVERY` · `DRAFT` · `IN_REVIEW` · `APPROVED` · `IMPLEMENTED` · `VERIFIED` | **0 each** |
| Missing **V1** PRDs | **19** — 9 from §31 (§4.1) + 9 from §8.1 (§4.2) + `PRD-022` (§4.3) |
| Duplicate PRDs | **0** — no requirement is specified twice |
| **Contested bounded contexts** | **3** — `BC-19`, `BC-25`, `BC-29` (§6.1, `PGA-11`). *Corrected from 2 on 2026-08-04* |
| &nbsp;&nbsp;of which resolvable by transfer | **2** — `BC-19` → `PRD-013`, `BC-29` → `PRD-017`, if `ADR-0013` is accepted |
| &nbsp;&nbsp;of which have **no** registered claimant | **1** — `BC-25`; `ADR-0013` §7 open, no `PRD-023` allocated |
| PRDs with an explicit owner model | **23 of 23** — role-based, [`PRD_OWNERSHIP_MODEL.md`](./PRD_OWNERSHIP_MODEL.md) |
| PRDs with a *named individual* owner | **0 of 23** — by design; §5 and model §1.1 forbid recording personal names |
| PRDs unassignable under the one-holder-per-role rule | **1** — `PRD-012`, which spans two owners at two ranks (§5) |

**Reserved, not counted above:** `PRD-012a` and `PRD-012b` (§4.1). They are the two documents `PRD-012` becomes
and are not separately registered until `PRD-012` is retired, so counting them now would double-count one gap.

**No PRD has reached `VERIFIED`, and none is close.** `PRD-001`, the most complete, cannot deliver an OTP
(`IMPL-020`) and carries a P0 release blocker (`TASK-D10`).

---

## 8. Maintenance

1. A new PRD gets the next free `PRD-nnn`. **Numbers are never reused or reassigned** — the same rule as ADRs and
   `IMPL-*` tasks, for the same reason: cross-references outlive documents.
2. A status change requires the entry evidence in §2. *"It feels done"* is not evidence.
3. This register is updated **in the same commit** as the change it records.
4. `FROZEN` is set **only** when the document appears in `DOCUMENTATION_BASELINE.md` §3 at Rank 1–5.
5. If this register disagrees with a PRD, **fix this register**.
6. Adding a bounded context to a PRD's ownership is an **architecture change requiring an ADR** — see
   `LIB-26.2` and `ADR-INDEX.md` process step 1.
7. The `Owner` field records **roles only**. A personal name is never recorded here — see
   [`PRD_OWNERSHIP_MODEL.md`](./PRD_OWNERSHIP_MODEL.md) §1.1 and §7.4. If this register and the ownership model
   disagree, **fix this register**: the model is the authority on ownership (model §7.5).

---

## 9. References

[`DOCUMENTATION_BASELINE.md`](../DOCUMENTATION_BASELINE.md) ·
[`ADR-INDEX.md`](../adr/ADR-INDEX.md) ·
[`MASTER_PRD.md`](../../30-product/MASTER_PRD.md) ·
[`LIBOORA_BOUNDED_CONTEXT_MAP.md`](../../10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md) ·
[`LIBOORA_MODULE_DEPENDENCY_MATRIX.md`](../../10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md) ·
[`ARCHITECTURE_RULINGS.md`](../../10-architecture/ARCHITECTURE_RULINGS.md) ·
[`TRACEABILITY_MATRIX.md`](../../40-implementation/TRACEABILITY_MATRIX.md) ·
[`IMPLEMENTATION_STATUS.md`](../../40-implementation/IMPLEMENTATION_STATUS.md) ·
[`PRD_DEPENDENCY_GRAPH.md`](./PRD_DEPENDENCY_GRAPH.md) ·
[`PRODUCT_IMPLEMENTATION_ROADMAP.md`](./PRODUCT_IMPLEMENTATION_ROADMAP.md) ·
[`PRD_GAP_ANALYSIS.md`](./PRD_GAP_ANALYSIS.md) ·
[`PRD_OWNERSHIP_MODEL.md`](./PRD_OWNERSHIP_MODEL.md) ·
[`PRD_LIFECYCLE.md`](./PRD_LIFECYCLE.md)

---

## 10. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-04 | Created. 23 PRDs registered — 4 existing (6 files), 19 planned. Freeze status derived from `DOCUMENTATION_BASELINE.md` §3/§7 rather than from PRD self-declaration, because **no PRD declares its own freeze state** (§2.1). Ownership recorded as **unassigned for all 23** because no document-owner field exists anywhere in the repository (§5). Bounded-context ownership verified across all 31 contexts (§6). **No requirement was created, modified, reinterpreted or withdrawn; no PRD was edited.** |
| **v1.1** | 2026-08-04 | **Ownership closed.** All four `Owner` fields (§§3.1–3.4) changed from *Unassigned* to four organizational roles, and §5 rewritten from *"the field the repository cannot fill"* to *"closed by a role-based model"*, with the original finding preserved verbatim as §5.1 because its reasoning still governs — **no personal name may ever be recorded here**. The gap was resolved by establishing that names were the wrong thing to record: document ownership needs accountable *roles*, and the roles already existed in `ADR-0001`, `ADR-0011`, `ADR-0012` and Dependency Matrix §11. Maintenance rule 7 added (roles only; this register yields to the ownership model). §7 counts now distinguish *explicit owner model* (**23 of 23**) from *named individual* (**0 of 23**, by design). Two findings surfaced **because** ownership was assigned systematically, neither visible while every field read *Unassigned*: `PRD-012` is **unassignable** under one-holder-per-role as scoped (two owners at two ranks — already flagged in §4.1 as violating the Single Owner Rule), and **`BC-25` has no registered claimant** because `PRD-015` is *Search Indexing*, not configuration — so nothing exists to transfer it to, which is why `ADR-0013` §7 stays open and no `PRD-023` is allocated. **No requirement was created, modified or withdrawn; no PRD file was edited; no bounded-context ownership changed.** |
| **v1.0** | 2026-08-04 | Cross-reference verification, same day, before the register was relied on. Three self-inconsistencies found and corrected: (1) `BC-20` Subscription & Billing was described as *"a genuine V1 gap"* while sitting in the table for contexts with **no** PRD obligation, and was cited as `PRD-022` by two companion documents without ever being registered — now registered as `PRD-022` in a new §4.3, and the old §4.3 renumbered §4.4; (2) `PRD-012a`/`PRD-012b` were cited by the roadmap and gap analysis but existed in no register — now reserved explicitly under §4.1; (3) the missing-V1 arithmetic read *"9 from §31 + 8 from §8.1 + `BC-20`"*, which summed to 18 while §8.1 yields **nine** PRDs — corrected to 19. (4) §6 asserted *"no context is claimed by two PRDs"* while §4.2 of the same register assigned `BC-19` to `PRD-013` and `BC-29` to `PRD-017` — contexts §3.3 gives to `PRD-002`. The clean result was an artefact of listing ownership only for PRDs that exist; the register contradicted itself two sections apart. §6 now records both as **contested**, states the three pieces of evidence, applies the precedence reading without claiming to settle it, and raises `PGA-11`. **Version remains v1.0: these were defects in an unreleased document, not amendments to a published one.** No requirement, PRD or architectural decision was touched. |
| **v1.2** | 2026-08-04 | **Contested-context count corrected from 2 to 3 during Phase 4 validation.** §6's table recorded `BC-25` Configuration as *uncontested* (`"BC-06, BC-25 | PRD-002 | No"`) while `ADR-0013` §2, `PRD_OWNERSHIP_MODEL.md` §4.4 and `PRD_GAP_ANALYSIS.md` §8 all recorded it as contested — this register was the only document still carrying the pre-`ADR-0013` reading, and its §7 count of **2** propagated that error into the summary a reader is most likely to quote. `BC-25` now has its own row, §6.1 is retitled *"The three contested contexts"* and explains **why the conflict was invisible**: `BC-25` is in neither Master PRD §31 nor §8.1, so no registered PRD contests the `Library_PRD_v1.md` header — the collision is with the **BC Map's** *"Owning Platform"* column (`platform/configuration`, rank 3), not with another PRD, and a PRD-to-PRD comparison could not see it. §7 now reports **3**, split into the 2 resolvable by transfer and the **1 with no registered claimant**. This is a *reporting* correction: no ownership was reassigned, `ADR-0013` §7 remains open, no `PRD-023` is allocated, and no frozen document was touched. **Version incremented because v1.1 was already committed — unlike the v1.0 defect rows above, this amends a published state.** |
