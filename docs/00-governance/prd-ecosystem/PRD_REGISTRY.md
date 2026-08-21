# LIBOORA — PRD Registry

| Field | Value |
|---|---|
| **Document** | PRD Registry — the single source of truth for the PRD ecosystem |
| **Version** | **v2.1** |
| **Status** | Active register of record |
| **Date** | **2026-08-05** |
| **Baseline** | **`BASELINE-2026-08-05-A`** |
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

*"Listed in v1.0"* means the v1.0 Master PRD named them. **Four of the nine have since been written and frozen** —
`PRD-004` (v1.2, `ADR-0018`), `PRD-005` (v1.4, `ADR-0019`), `PRD-007` (v1.0, `ADR-0020`) and **`PRD-006` (v1.9, `ADR-0034`)**.
**The remaining five are `PLANNED`.**

> **Updated 2026-08-05 during the `PRD-006` Stage 7 freeze**, in the same commit as the status row below — which is the whole point
> of the `GCP-08` correction recorded beneath. The sentence and the table were changed **together**, because the defect `GCP-08`
> records is not *"someone wrote a wrong number"* but *"a derived sentence and the table it derives from are edited in separate
> steps"*. `GCP-11` in [`DOCUMENTATION_BASELINE.md`](../DOCUMENTATION_BASELINE.md) §6 records the **fourth** occurrence of that
> same class, found in the baseline declaration during this very freeze — so the class is still live and the discipline here is
> deliberate, not decorative.

> **Corrected 2026-08-04 during the `PRD-007` Stage 7 freeze.** This paragraph read *"**None was ever written.**
> All nine are `PLANNED`"* — true when written, false from the moment `PRD-004` was frozen, and it survived two
> later freezes because a status change updates the *table* while nobody re-reads the sentence above it. The
> table below was already correct; **only this prose was wrong**, so no status was ever misconferred. Recorded as
> `GCP-08` in [`DOCUMENTATION_BASELINE.md`](../DOCUMENTATION_BASELINE.md) §6, not absorbed silently, because it
> is the same class of defect as `GCP-01` and `GCP-07`: a derived statement left behind by a change to the thing
> it describes.

| PRD ID | Name | Bounded context | Type | V | Status | Blocks |
|---|---|---|---|---|---|---|
| `PRD-004` | Student Management | **`BC-01` Enrollment** | `[CORE]` | V1 | **`FROZEN`** — [`student-management/Student_Management_PRD_v1.md`](../../30-product/student-management/Student_Management_PRD_v1.md) **v1.2**, admitted by `ADR-0018` (`BASELINE-2026-08-04-C`) | `PRD-005`…`008`; `IMPL-214` `E-13` ACL |
| `PRD-005` | Membership Management | **`BC-02` Membership** | `[CORE]` | V1 | **`FROZEN`** — [`membership-management/PRD-MEMBERSHIP-MANAGEMENT.md`](../../30-product/membership-management/PRD-MEMBERSHIP-MANAGEMENT.md) **v1.4**, admitted by `ADR-0019` (`BASELINE-2026-08-04-D`) | `PRD-006`, `PRD-007`, `PRD-008` |
| `PRD-006` | Attendance Management | **`BC-03` Attendance** | `[CORE]` | V1 | **`FROZEN`** — [`attendance-management/PRD-006_ATTENDANCE-MANAGEMENT.md`](../../30-product/attendance-management/PRD-006_ATTENDANCE-MANAGEMENT.md) **v1.9**, admitted by `ADR-0034` (`BASELINE-2026-08-05-A`) | — |
| `PRD-007` | Seat Management | **`BC-04` Seating** | `[CORE]` | V1 | **`FROZEN`** — [`seat-management/PRD-SEAT-MANAGEMENT.md`](../../30-product/seat-management/PRD-SEAT-MANAGEMENT.md) **v1.0**, admitted by `ADR-0020` (`BASELINE-2026-08-04-E`) | — |
| `PRD-008` | Revenue & Finance | **`BC-05` Fee & Collection** | `[CORE]` | V1 | **`FROZEN`** — [`revenue-finance/PRD-008_REVENUE-AND-FINANCE.md`](../../30-product/revenue-finance/PRD-008_REVENUE-AND-FINANCE.md) **v1.7**, admitted by `ADR-0049` (`BASELINE-2026-08-17-A`), moved `DRAFT` → `FROZEN` by the **Governance Owner** on 2026-08-17. Stages 3 and 4 **CONFERRED**, Stage 5 gate exit 0, Stage 6 range `IMPL-700`…`IMPL-799` allocated with **83 / 83** tasks traced. ⚠ **`FROZEN` is not `VERIFIED`** — **17 `FEE-GAP-*` remain OPEN**, **20 of 83** tasks are **BLOCKED**, and nothing is implemented. *Superseded text retained verbatim:* **`DRAFT`** … *(was `PLANNED` — see `GCP-14` in §4.3, which remains **OPEN**)*. **`DRAFT` is not `FROZEN`**: no `DOCUMENTATION_BASELINE.md` §3 row exists, and Stages 5–6 are not performed — **both clauses are now false and are kept only as history** | — |
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
>
> ---
>
> ### ✅ Split **CONFIRMED** — 2026-08-04, Governance Closure Phase
>
> **The split is confirmed as already authorised. It required no new decision, and none was made.**
>
> `MASTER_PRD.md` §8 *Correction 2* — a **Rank 1** instruction — states it verbatim:
>
> > *"**Correction 2 — `Security & Automation` is two owners.** 'Security' is the SECURITY platform (R2).
> > 'Automation' is Workflow Orchestration (`BC-28`, V2). A single module name spanning two owners at two ranks
> > violates the Single Owner Rule (EA §10.1.1). The name is preserved; the ownership split is now explicit."*
>
> **What this confirmation does:** records that the reservation above is the correct and complete expression of that
> Rank 1 correction, and that `PRD-012a`/`PRD-012b` may be opened without a further ADR.
>
> **What it does NOT do — deliberately:**
> - **No requirement is changed, added or moved.** `PRD-012` has never been written, so there is no requirement text
>   to divide. The split is of a *reservation*, not of a specification.
> - **No ranked document is amended.** Master PRD §8 Correction 2 already mandates the split; restating it here adds
>   nothing to Rank 1 and takes nothing from it. This register and `PRD_OWNERSHIP_MODEL.md` are both **unranked**
>   (absent from `DOCUMENTATION_BASELINE.md` §4), so this navigational confirmation needs no ADR.
> - **`PRD-012` is not retired yet.** §8 rule 1 ties retirement to the day `PRD-012a` is *opened*. It has not been
>   opened, so `PRD-012` remains `PLANNED` and the summary counts in §7 are unchanged by this confirmation.
> - **No number is reused.** `012a`/`012b` are suffixed identifiers, not new sequence numbers; `PRD-013` onward are
>   untouched.
>
> **Consequence for ownership.** `PRD-012` remains the one PRD *unassignable* under the one-holder-per-role rule
> (§5, §7) — and it remains so **until the split is executed**, not until it is confirmed. Recording the
> confirmation without pretending it resolves the assignability finding.

### 4.2 Bounded contexts with product obligations and no PRD

Master PRD §8.1: these *"carry product-visible obligations but had no module entry. Listed here so they receive
requirements, budgets and owners."* The obligation is the Master PRD's, not this register's.

| PRD ID | Name | Bounded context | Type | V | Status | Why V1 |
|---|---|---|---|---|---|---|
| `PRD-013` | Tenancy | **`BC-19`** | `[GENERIC]` | V1 | **`FROZEN`** — [`tenancy/PRD-013_TENANCY.md`](../../30-product/tenancy/PRD-013_TENANCY.md) **v0.1**, 2026-08-19, admitted at **Rank 3** by [`ADR-0050`](../adr/ADR-0050-tenancy-prd-v0.1-baseline.md) under `BASELINE-2026-08-19-A`. **51 identifiers in force / 63 declared**, 34 obligations, `IMPL-800`…`829`. ⚠ **`FROZEN`, not `VERIFIED`** — 0 of 30 tasks, 0 of 13 criteria tested. Version **preserved at v0.1**: freeze confers status, not content (`ADR-0020` §4 item 2) | *"Nothing multi-tenant works without it"* |
| `PRD-014` | Entitlement | **`BC-21`** | `[GENERIC]` | V1 | **`FROZEN`** | *"Every paid gate depends on it"* — **v0.1 admitted at Rank 3 on 2026-08-19 by `ACCEPTED` [`ADR-0052`](../adr/ADR-0052-entitlement-prd-v0.1-baseline.md) under `BASELINE-2026-08-19-C`.** Status is **conferred by the baseline row, not read off the PRD** (§2.1). ⛔ **`FROZEN` is not `VERIFIED`:** 0 of 26 acceptance criteria proven, 0 of 30 `IMPL-1000`…`1029` tasks implemented, 8 `ENT-GAP-*` OPEN, and `D-014-01`…`06` code contradictions unfixed |
| `PRD-015` | Search Indexing | **`BC-23`** | `[GENERIC]` | V1 | `PLANNED` | Permission-aware, tenant-partitioned search |
| `PRD-016` | Audit Trail | **`BC-24`** | `[GENERIC]` | V1 | **`FROZEN`** — [`audit/PRD-016_AUDIT_TRAIL.md`](../../30-product/audit/PRD-016_AUDIT_TRAIL.md) **v0.1**, 2026-08-19, admitted at **Rank 3** by [`ADR-0051`](../adr/ADR-0051-audit-trail-prd-v0.1-baseline.md) under `BASELINE-2026-08-19-B`. **58 identifiers declared / 0 retired**, 35 obligations, `IMPL-900`…`929`. Owns exactly **one** aggregate, `AuditEntry`; adds **0** integration edges — `E-20` (BC Map L329) is consumed, not created. ⚠ **Two registers are deliberately EMPTY**: `AUD-EVT-*` because `BC-24` publishes no events, `AUD-CFG-*` because **no Rank 1–7 document bounds any audit parameter** (`MP-NFR-10` assigns retention to SECURITY + DATA Governance; `Q-04` is *"Open — needs counsel"*). ⚠ **`FROZEN`, not `VERIFIED`** — 0 of 30 tasks, 0 of 18 criteria tested; acceptance coverage **27/35 = 77.1%**, the 8 uncovered obligations named in the PRD. **All 5 `AUD-GAP-*` remain OPEN.** Version **preserved at v0.1**: freeze confers status, not content (`ADR-0020` §4 item 2) | Required by *"every critical action is auditable"* |
| `PRD-017` | File & Media | **`BC-29`** | `[GENERIC]` | V1 | **`FROZEN`** — [`file-media/PRD-017_FILE_AND_MEDIA.md`](../../30-product/file-media/PRD-017_FILE_AND_MEDIA.md) **v0.2**, 2026-08-20, amended by `ACCEPTED` [`ADR-0056`](../adr/ADR-0056-file-media-v0.2-media-optimization.md) under **`BASELINE-2026-08-20-C`**; originally admitted at **Rank 3** by `ACCEPTED` [`ADR-0054`](../adr/ADR-0054-file-media-prd-v0.1-baseline.md) under `BASELINE-2026-08-20-B`. ⚠ **The status cell is deliberately unchanged at `FROZEN`** — an amendment moves the **version**, not the lifecycle stage, so this row does **not** revert to `DRAFT` and does **not** advance to anything beyond Stage 7. **Register totals recomputed: 277 identifiers / 8 registers** (was 232), **150 obligation-bearing** (was 132), **96 acceptance criteria** (was 78), coverage **112/150 = 74.7%** (was 94/132 = 71.2%) — the v0.2 amendment added **45** identifiers with **zero renumbering**. **`FIL-CFG-*` grew 9 → 15**, and ⚠ **three of the six new members (`FIL-CFG-010`/`011`/`015`) carry NO DEFAULT** because no authority supplies a compression quality floor, a minimum document resolution or a processing timeout — published with owners and ranges only, on `FIL-CFG-006`’s precedent, and the debt is `FIL-GAP-014`. **`FIL-GAP-*` grew 13 → 16**; `FIL-GAP-012` is **PARTIALLY CLOSED** (architecture half settled by `ACCEPTED` [`ADR-0055`](../adr/ADR-0055-e22-consumer-list-includes-bc-12.md), which admitted **`BC-12` only** to BC Map `E-22`), and ⛔ **`FIL-GAP-016` records that video/audio optimization was REQUESTED and REFUSED** for want of any Rank 1–4 authority admitting it. *Prior text retained verbatim:* **v0.1**, 2026-08-20, admitted at **Rank 3** by `ACCEPTED` `ADR-0054` under **`BASELINE-2026-08-20-B`**. Status is **conferred by the baseline row, not read off the PRD** (§2.1). **232 identifiers / 8 registers** — 7 populated, **`FIL-EVT-*` DELIBERATELY EMPTY** because `BC-29` is a producer in **zero** BC Map §9 rows. ⚠ **`FIL-CFG-*` is POPULATED at nine — the first v0.x admission whose CFG register is not empty**, the four predecessors each having refused for want of a bounding authority; here size limits, retention windows, MIME allow-lists and signed-URL TTLs **are** bounded by readable authorities, so nine members were derived rather than invented **and rather than reflexively refused**. **132 Class A obligations**, **78** acceptance criteria, `IMPL-1200`…`1239` with `1240`…`1299` reserved. Owns the **bytes and the reference to them, not the meaning of the thing referenced** — a consumer holds a `FileRef`, never bytes or a raw storage path (`E-22`, BC Map **L331**); adds **0** integration edges and changes **0** BC Map cells. **`BC-29` is the first of the two `Platform Services` contexts to hold a Rank 3 specification** (BC Map §3.3 pairs it with `BC-30` Offline Sync, which is `PLANNED`); in the CAPABILITY & GENERIC band it is **3 of 11** — measured, and deliberately **not** dressed in either predecessor's band phrase, both of which were tested and are false here. ⛔ **Student-to-Student Text + File/Media Sharing is RETAINED in V1 and is NOT yet servable:** BC Map **L331** lists `E-22`'s consumers as `BC-01`, `BC-10`, `BC-14` and **not `BC-12` Messaging**. Stage 3 tested necessity **per context** — `BC-12` **YES**, `BC-11` **NO**, `BC-13` **NO** (`E-14` is outbound) — so the gap is **narrow and named**: **`FIL-GAP-012`** / blocker **`B-11`**, blocking `IMPL-1230`…`1236`. ⚠ **`ADR-0016` is the exact one-cell precedent for the fix and `ADR-0054` §3.2 DECLINES to exercise it** — BC Map amendment is an **Architecture Owner** act, the conferred authority was Governance Owner, and the gap is **routed to a named owner rather than closed by a grant that does not reach it**. Frozen on the measured `ATT-GAP-010` precedent (`PRD-006` **L1564**/**L2973**) that a freeze may carry an open `E-22` consumer gap transparently. ⚠ **An alignment supplement WAS required and WAS written**, unlike `PRD-016` and `PRD-023`: three of the four hashes cited by the gate records measured **STALE**, so the convenient no-supplement precedent was **falsified rather than inherited**; the drift was measured as **`+2 FIL-AC-*` and nothing else**, leaving the six Stage 3 verdicts intact. ⛔ **`FROZEN` is not `VERIFIED`:** 0 of **78** acceptance criteria proven, 0 of **40** tasks implemented, **7 of 7** required architecture tests missing (`B-2`), acceptance coverage **94 of 132 = 71.2%** (**not** conflated with the 132/132 = 100.0% task figure; the 38 uncovered are enumerated **XC 17 · FR 17 · BR 3 · INV 1** with **0 undisclosed**), and **all 13 `FIL-GAP-*` OPEN**. Version **preserved at v0.1**: freeze confers status, not content (`ADR-0020` §4 item 2) | Documents, uploads, signed URLs, virus scan. Registered to `BC-29` by [`ADR-0013`](../adr/ADR-0013-capability-context-ownership.md), whose §5 write obligation this admission **closes**. Consumed by **`BC-01`, `BC-10`, `BC-12` and `BC-14`** through `E-22` — **four contexts**, per BC Map **L331** as amended. ⚠ **This cell previously read *"`BC-12` Messaging is the one context that needs the edge and does not hold it"*, and that statement is now FALSE** — it was true when written and was falsified by `ACCEPTED` [`ADR-0055`](../adr/ADR-0055-e22-consumer-list-includes-bc-12.md), which admitted `BC-12` to `E-22`. Corrected 2026-08-21 rather than left standing, because a register whose scope cell contradicts the Rank 4 authority it cites misinforms every reader who trusts it, and the contradiction was one `sed` of BC Map L331 away from being visible to anyone. **`BC-11` and `BC-13` remain deliberately NOT consumers** — `ADR-0055` §3 tested necessity per context and refused both, and `ADR-0059` then made the four-context list **executable**: the `files` port refuses any caller outside it, and the refusal is held by a mutation-proven architecture test rather than by documentation. ⚠ **The implementation half being closed does NOT move this row's status:** `PRD-017` remains **`FROZEN`, not `VERIFIED`** — **0 of 96** `FIL-AC-*` are proven against real storage — and **`FIL-GAP-012`'s register row inside the frozen PRD still reads `OPEN`**, because editing it is an amendment act requiring amendment authority, not a side effect of the code landing. *Prior text retained verbatim:* Consumed by `BC-01`, `BC-10` and `BC-14` through `E-22`; **`BC-12` Messaging is the one context that needs the edge and does not hold it** |
| `PRD-018` | Offline Sync | **`BC-30`** | `[GENERIC]` | V1 | `PLANNED` | *"Attendance capture in a basement with no signal"* |
| `PRD-019` | Integration | **`BC-31`** | `[GENERIC]` | V1 | **`DRAFT`** — [`integration/PRD-019_INTEGRATION.md`](../../30-product/integration/PRD-019_INTEGRATION.md) **v0.1**, 2026-08-15, created by [`ADR-0043`](../adr/ADR-0043-prd-019-creation-and-prd-008-freeze-blocker-closure.md) §3 to give the **payment webhook wire contract a lawful owner**. ⛔ **It assigns that contract to `BC-31` and does NOT author it** — `0` identifiers issued, no range published, Stage 2 **PARTIAL**; the gateway webhook feature remains **unbuildable** (`Q-B31`) | Outbound contracts, retries, idempotent delivery |
| `PRD-020` | Trust & Safety | **`BC-13`** ⚠ | **`[CORE]`** | V1 | `PLANNED` | *"On a minor-heavy product, is existential legal risk"* |
| `PRD-021` | Social Graph & Messaging | **`BC-11`, `BC-12`** | `[SUPPORTING]` | V1 | `PLANNED` | Named in §8.1 with `BC-13` |

> ⚠ **`PRD-020` carries the highest unmitigated product risk in the register.** `BC-13` is classified `[CORE]`
> *despite living in a Supporting platform*, and `MP-RSK-02` — *"minor-safety incident on the social product"* —
> is **Critical** with mitigation *"`BC-13` Trust & Safety at V1"*. That mitigation is a bounded context with no
> specification, no tasks and no owner.

### 4.3 Registered outside both Master PRD lists

**Two** V1 bounded contexts are named in neither §31's nine nor §8.1's eight, yet own aggregates and V1
obligations. They are registered here rather than left in §4.4, because §4.4 is *"not a recommendation to write
documents"* and these two **are**.

| PRD ID | Name | Bounded context | Type | V | Status | Why registered |
|---|---|---|---|---|---|---|
| `PRD-022` | SaaS Billing | **`BC-20` Subscription & Billing** | `[GENERIC]` | V1 | **`DRAFT`** — [`saas-billing/PRD-022_SAAS-BILLING.md`](../../30-product/saas-billing/PRD-022_SAAS-BILLING.md) **v0.3**, 2026-08-15 *(was **v0.2**, 2026-08-05 — superseded text retained)* | Master PRD §8 module 17; owns `Subscription` · `SubscriptionInvoice`; sole writer of entitlement inputs |
| `PRD-023` | Settings & Configuration | **`BC-25` Configuration** | `[GENERIC]` | V1 | **`FROZEN`** — [`configuration/PRD-023_SETTINGS_AND_CONFIGURATION.md`](../../30-product/configuration/PRD-023_SETTINGS_AND_CONFIGURATION.md) **v0.1**, 2026-08-20, admitted at **Rank 3** by `ACCEPTED` [`ADR-0053`](../adr/ADR-0053-configuration-prd-v0.1-baseline.md) under **`BASELINE-2026-08-20-A`**. Status is **conferred by the baseline row, not read off the PRD** (§2.1) | Master PRD §8 **module 18**; owns the settings hierarchy, feature flags, branding *values*, secret *references*, the `E-19` typed-accessor contract and `LCFG-*` resolution semantics. Registered by [`ADR-0017`](../adr/ADR-0017-bc-25-configuration-ownership.md). **180 identifiers / 8 registers**, of which **`CNF-EVT-*` and `CNF-CFG-*` are DELIBERATELY EMPTY** — `BC-25` publishes 0 domain events, and this PRD **owns the resolution machinery, not the value list** (`ADR-0017` §3.1 item 6), the 104 configurables of the clean census staying with their 8 existing owners. **113 Class A obligations**, `IMPL-1100`…`1129`. **`BC-25` completes the BC Map L271 FOUNDATIONAL band at 3 of 3.** ⛔ **`FROZEN` is not `VERIFIED`:** 0 of 59 acceptance criteria proven, 0 of 30 tasks implemented, acceptance coverage **76 of 113 = 67.3%** (all 16 `CNF-XC-*` uncovered *by construction*), 8 `CNF-GAP-*` OPEN, the 7 matrix §10.3 architecture tests missing, and `S4-D-01` **disclosed, not repaired** |

> **`PRD-022` moved `PLANNED` → `DRAFT` on 2026-08-05, and the authority for the move was checked before it was
> made.** §2.1's evidence test for `DRAFT` is *"a document on disk with a version header"* — `PRD-022_SAAS-BILLING.md`
> v0.1 satisfies it — and the **`PRD-004` v1.4 precedent** executed exactly this transition, *"`PLANNED` → **`DRAFT`**
> with its file path."* The draft was written because three findings had terminated outside their own module with no
> lawful home: `FEE-GAP-014` (the platform charge has no owning document), `FEE-GAP-017` (a cash-only library has no
> lawful way to pay) and an unspecified SaaS free trial. **`DRAFT` is the weakest status implying a file exists** —
> not reviewed, not approved, not baselined, **Stage 3 not performed**, and **6 of 6 `SAAS-GAP-*` decisions block both
> Stage 4 and Freeze**. *⚠ The figure **6 of 6** in the sentence above was true of `PRD-022` **v0.1**, the version this note was written about, and has been stale since a seventh gap was registered at v0.2. It is **left standing rather than corrected**, because this paragraph is a dated record of the `PLANNED` → `DRAFT` move and rewriting its numbers would make it describe a day it did not describe. The **live** figure is **7 of 7**, in §5 above, re-derived at v0.3 on 2026-08-15. This is the same defect class already logged as `GCP-08` — a derived statement left behind by a change to the thing it describes — and it is recorded here rather than absorbed.* **No requirement moved into `PRD-022` from any frozen document**; `PRD-008` retains the
> `BC-05` boundary and keeps `FEE-GAP-014`/`FEE-GAP-017` **open**, because a home for a question is not an answer.

> **⚠ `GCP-14` — this register states two incompatible tests for `DRAFT`, and the conflict is raised rather than
> resolved here.** §2.1 L42 makes `DRAFT` a **fact about the disk**: *"a document on disk with a version header."*
> §7's `DRAFT` count row argues the opposite, that status is *"derived from `DOCUMENTATION_BASELINE.md` §3 and **not**
> from a PRD's self-description"*, and cites `PRD-006` carrying `Status: DRAFT` through nine versions while this
> register correctly showed `PLANNED`. **Both cannot be true.** The reconciliation that fits every executed movement
> is that §7's reasoning is about **`FROZEN`** — *"freeze is conferred, not claimed"* — and was over-generalised to
> `DRAFT`; `PRD-004` v1.4 is the decisive counter-example, since this register itself moved a PRD to `DRAFT` on the
> strength of a file. This edit follows the **explicit rule and the executed precedent**, and refers the wording
> defect to a governance owner. **Consequence recorded, not acted on:** `PRD-008_REVENUE-AND-FINANCE.md` also exists
> on disk with a version header (v0.8) and still shows `PLANNED` at §4.1. Under L42 it is the same class of case.
> **It is deliberately left unchanged** — sweeping a second PRD's status inside an edit whose governing rule is
> itself in dispute would be the flattering direction, and `GCP-08` in the baseline is precisely the record of this
> register's prose contradicting its own table. **Authority:** governance owner of `PRD_REGISTRY.md` + `PRD_LIFECYCLE.md`.

> **Why `PRD-023` was missed until 2026-08-04, and why registering it is not "inventing a PRD to fill a gap."**
> This register derived its candidates from Master PRD **§31** (nine named PRDs) and **§8.1** (eight contexts with
> *"no module entry"*). `BC-25` is in neither — and it is absent from §8.1 **precisely because it *does* have a
> module entry**, at §8 row 18. The exclusion that made it look unregistered is the same fact that proves it is a
> module. `BC-20` is **module 17**, one row earlier in the same Rank 1 table, same `[GENERIC]` classification, same
> V1 scope, found by the same method. Registering `PRD-023` therefore applies the mechanism this section already
> established for `PRD-022`; withholding it would judge two adjacent rows of one table by different standards.
> Full reasoning and five rejected alternatives in [`ADR-0017`](../adr/ADR-0017-bc-25-configuration-ownership.md)
> §2 and §4. **No requirement is created or moved by the registration** — `PRD-023` is `PLANNED`.

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
| ~~`BC-25` Configuration (Settings, module 18)~~ | `[GENERIC]` | V1 | **Moved to §4.3 on 2026-08-04.** This row previously read *"**Covered** — `PRD-002` owns `BC-25`"*, which [`ADR-0013`](../adr/ADR-0013-capability-context-ownership.md) made **false** (a capability context is owned by its platform, not by the domain consuming it) and [`ADR-0017`](../adr/ADR-0017-bc-25-configuration-ownership.md) replaced: **`BC-25` → `PRD-023`** |
| Dashboards — Owner, Manager, Reception (modules 10–12) | *not contexts* | V1 | **No PRD.** Presentation compositions; own no aggregate |
| Parent Portal (module 5) | *not a context* | V1 | **No PRD.** Composition over `BC-01`/`03`/`05` |
| Library Member Directory (module 3) | read composition | V1 | **No PRD.** Belongs to `PRD-004` — **placement executed 2026-08-04**: delivered as [`PRD-004` chapter 5](../../30-product/student-management/Student_Management_PRD_v1.md), requirements `LMD-1`…`LMD-31`. Owns no aggregate and no invariant (`AR-1`); **no `BC-32` was created** and the context count remains **31** |
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
  **→ RESOLVED 2026-08-04 by [`ADR-0017`](../adr/ADR-0017-bc-25-configuration-ownership.md).** The finding was
  correct that nothing existed to *transfer* it to; it was wrong to infer that nothing should be *created*. Master
  PRD §8 **module 18** already names *Settings & Configuration* → `BC-25`, `[GENERIC]`, **V1**. `PRD-023` is now
  allocated (§4.3). The sentence above is preserved because the reasoning that produced it — *assign ownership
  systematically and the unassignable cases announce themselves* — is exactly what surfaced the question.

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
| `BC-19` | **`PRD-013`** | **No** — resolved 2026-08-04 by `ADR-0013` |
| `BC-25` | **`PRD-023`** | **No** — resolved 2026-08-04 by `ADR-0013` + `ADR-0017` |
| `BC-29` | **`PRD-017`** | **No** — resolved 2026-08-04 by `ADR-0013` |
| `BC-10` | `PRD-003` | No |
| `BC-20` | `PRD-022` | No |
| `BC-01`…`BC-05`, `BC-11`…`BC-13`, `BC-21`…`BC-24`, `BC-26`, `BC-27`, `BC-30`, `BC-31` | *(unwritten `PRD-004`…`021`)* | No |
| `BC-07`…`BC-09`, `BC-14`…`BC-17`, `BC-28` | None — V2/V3 | No |

**Among the three frozen module PRDs there is no overlap**, exactly as `DOCUMENTATION_BASELINE.md` §4 requires:
*"Rank 3 holds three module baselines and they do not overlap."* `PRD-001`, `PRD-002` and `PRD-003` are disjoint.

### 6.1 The three contested contexts — `BC-19`, `BC-25` and `BC-29` — **all resolved 2026-08-04**

> ✅ **Contested count is now 0.** [`ADR-0013`](../adr/ADR-0013-capability-context-ownership.md) established that a
> capability context is owned by its **platform**, not by the domain that consumes it, and separated **context
> ownership** from **aggregate ownership**. `Library_PRD_v1.md` line 10 was amended (v1.0 → **v1.1**) to distinguish
> the one context it owns, `BC-06`, from the three it consumes through ports. **No requirement moved**: the
> aggregates `TenantOrganisation`, `StaffAssignment` and the `LibraryBranding` values remain owned by `PRD-002`
> (`ADR-0013` §5). `BC-19` → `PRD-013`, `BC-29` → `PRD-017`, and `BC-25` → the newly registered **`PRD-023`** per
> [`ADR-0017`](../adr/ADR-0017-bc-25-configuration-ownership.md).
>
> **`PRD-002`'s entry now lists one owned context where it listed four. This is not a scope reduction** — it is the
> same scope, correctly attributed. `ADR-0013` §6.2 required this sentence to appear here, to prevent exactly that
> misreading.

**The original analysis is preserved below**, because the *reason* the collision was hard to see remains the useful
part of the record.

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

> **That ADR now exists.** `ADR-0013` was accepted 2026-08-04 and the amendment to `Library_PRD_v1.md` line 10 was
> executed under it — written and reviewed *before* the frozen document was touched, per `ADR-INDEX.md` Process
> step 1. `PGA-11` is **closed**: `BC-19` and `BC-29` by `ADR-0013`, `BC-25` by `ADR-0017`. **Contested contexts: 0.**

### 6.2 One case that looks like an overlap and is not

`PRD-003` §4.8 requires the Global Profile Photo to be *"held as a `FileRef` issued by `BC-29`"*. That is
**consumption, not ownership** — `SID-4.36` forbids `BC-10` from re-implementing or bypassing file handling. A
dependency edge, recorded in [`PRD_DEPENDENCY_GRAPH.md`](./PRD_DEPENDENCY_GRAPH.md) §4.

---

## 7. Summary counts

| Measure | Count |
|---|---|
| **PRDs registered** | **24** — `PRD-000`…`PRD-023`. *Was 23; `PRD-023` added 2026-08-04 by `ADR-0017`* |
| **Documents that exist** | **18 files, 16 PRD identities** — `PRD-000`…`PRD-008`, `PRD-013`, `PRD-016`, `PRD-014`, **`PRD-017`**, **`PRD-023`**, `PRD-019` and `PRD-022`. *Advanced from 17 files / 15 identities on 2026-08-20 when `PRD-017_FILE_AND_MEDIA.md` was admitted at Rank 3 by `ACCEPTED` `ADR-0054` — the **second** admission on this date.* ⚠ **The identity count 16 is MEASURED and the file count 18 is INCREMENTED, and the asymmetry is repeated here rather than quietly dropped**, exactly as the prior text below discloses: this row still states **no rule** for what counts as one "file", so 17 + 1 remains the arithmetic of adding one document to a figure whose derivation is unrecorded. `GCP-18`'s residue is unchanged and supplying the counting rule is still a Governance Owner act, not a freeze act. ⚠ **`PRD-017` is REMOVED from the non-contiguity list below in the same edit that adds it above** — leaving it in both places would have made this row state that `PRD-017` exists and does not exist simultaneously, which is precisely the self-contradiction `GCP-18` was opened for when this row asserted `PRD-013` was `FROZEN` while denying its document existed. **The identities remain non-contiguous**: `PRD-009`…`PRD-012`, `PRD-015`, `PRD-018`, `PRD-020` and `PRD-021` do not exist. *Prior text retained:* *Advanced from 16 files / 14 identities on 2026-08-20 when `PRD-023_SETTINGS_AND_CONFIGURATION.md` was admitted at Rank 3 by `ACCEPTED` `ADR-0053`.* ⚠ **The two halves of this advance are NOT equally well established, and the asymmetry the row already discloses below is repeated here rather than quietly dropped.** The **identity** count **15** is *measured*: a sweep of `docs/30-product/` for specification documents — excluding stage, discovery, alignment, review, conferral, freeze, correction and decision records — yields exactly `PRD-000`, `001`, `002`, `003`, `004`, `005`, `006`, `007`, `008`, `013`, `014`, `016`, `019`, `022` and now `023`. The **file** count **17** is *incremented, not measured*, for the same reason recorded below: this row still states **no rule** for what counts as one "file", so 16 + 1 is the arithmetic of adding one document to a figure whose derivation remains unrecorded. That limit is `GCP-18`'s disclosed residue and supplying the missing counting rule is still a Governance Owner act, not a freeze act. **The identities remain non-contiguous**: `PRD-009`…`PRD-012`, `PRD-015`, ~~`PRD-017`~~, `PRD-018`, `PRD-020` and `PRD-021` do not exist. *(`PRD-017` struck 2026-08-20 by the `ADR-0054` admission — the sentence is preserved rather than rewritten, with the one member that ceased to be true marked, so the row records both what was measured then and what is true now.)* ⚠ **`PRD-023` is the last registered PRD number, so its arrival closes the top of the range but not the middle.** *Prior text retained:* *Advanced from 15 files / 13 identities on 2026-08-19 when `PRD-014_ENTITLEMENT.md` was admitted; the enumeration was re-counted from the filesystem rather than incremented, the discipline `GCP-18` exists to enforce.* Prior text retained:* ⚠ **This row was WRONG before `PRD-016` was added to it, and the correction is logged as `GCP-18` in `DOCUMENTATION_BASELINE.md` §6 rather than silently absorbed.** It read *"13 files, 11 PRD identities — `PRD-000`…`PRD-008`, `PRD-019` and `PRD-022`"*, omitting **`PRD-013`** and **`PRD-016`**, both of which were already on disk — so the register simultaneously stated that `PRD-013` was `FROZEN` (two rows below, correctly) and that **no `PRD-013` document existed**. The `ADR-0050` commit advanced this row's `FROZEN` and `PLANNED` counts but never its existence list; `ADR-0051` §8.1 found the defect **by testing its own claim that no pre-existing defect existed**, and that test falsified the claim. ⚠ **A disclosed limit on the repair, stated because the two halves of this row are not equally well established:** the **identity** count **13** is *measured* — a sweep of `docs/30-product/` for specification documents, excluding stage/alignment/review/decision records, yields exactly `PRD-000`, `001`, `002`, `003`, `004`, `005`, `006`, `007`, `008`, `013`, `016`, `019`, `022`. The **file** count **15** is *incremented*, **not measured**: this row states **no rule** for what it counts as one "file" — `PRD-002` alone has four candidate documents under `library/` — so 13 + 2 is the arithmetic of adding `PRD-013_TENANCY.md` and `PRD-016_AUDIT_TRAIL.md` to a figure whose derivation is unrecorded. That is a weaker operation than measurement and it is labelled as such rather than presented as measured; supplying the missing counting rule is a Governance Owner act, not a freeze act. **The identities remain non-contiguous**: `PRD-013`, `PRD-016`, `PRD-019` and `PRD-022` exist while `PRD-009`…`PRD-012`, `PRD-014`, `PRD-015`, `PRD-017`, `PRD-018`, `PRD-020`, `PRD-021` and `PRD-023` do not. *Superseded text retained verbatim:* **13 files, 11 PRD identities** — `PRD-000`…`PRD-008`, **`PRD-019`** and **`PRD-022`**. *Was 12 files / 10 identities; `PRD-019` Integration was created 2026-08-15 by `ADR-0043` §3 as the **owner** of the payment webhook wire contract — a document created to hold a boundary, **not** because the roadmap reached `PRD-019`, and it **authors none of the contract** it owns.* **The identities remain non-contiguous**: `PRD-019` and `PRD-022` exist while `PRD-009`…`PRD-018`, `PRD-020`, `PRD-021` and `PRD-023` do not. *Superseded text retained verbatim:* **12 files, 10 PRD identities** — `PRD-000`…`PRD-008` and **`PRD-022`**. *Was 10 files / 8 identities; `PRD-008` Revenue & Finance and `PRD-022` SaaS Billing are both on disk as of 2026-08-05.* **The identities are no longer contiguous**: `PRD-022` exists while `PRD-009`…`PRD-021` do not, because it was drafted to receive findings that had nowhere lawful to terminate, not because the roadmap reached it. *Was 9 files / 7 identities; `PRD-006` drafted and frozen 2026-08-05.* **The identities are contiguous again**: `PRD-006` Attendance is now `FROZEN` alongside `PRD-007`, which consumes it, so the gap that the `SEAT-GAP-009` note below describes **is closed as a scheduling fact** — though `SEAT-GAP-009` itself remains an **open decision**, because a freeze supplies the producer document, not the missing ruling |
| `FROZEN` | **13** — `PRD-000`, `PRD-001`, `PRD-002`, `PRD-004`, `PRD-005`, `PRD-006`, `PRD-007`, `PRD-008`, `PRD-013`, `PRD-016`, `PRD-014`, `PRD-023`, **`PRD-017`**. *Was 12; **`PRD-017`** File & Media is admitted 2026-08-20 at **v0.1** by `ACCEPTED` `ADR-0054` under **`BASELINE-2026-08-20-B`**. Re-derived by enumerating the status column, not by incrementing.* ⚠ **`BC-29` is the first of the two `Platform Services` contexts to hold a Rank 3 specification**, and that claim was measured against BC Map §3.3's subdomain column — which pairs `BC-29` File & Media with `BC-30` Offline Sync, `BC-30` being `PLANNED` — **rather than borrowed from either precedent sentence in this row, both of which were tested and are false for `BC-29`.** The `PRD-016` row's *"first CAPABILITY & GENERIC band context frozen"* does not transfer: that band (BC Map **L258–268**) holds **eleven** contexts and `BC-21` and `BC-24` are already frozen, so `BC-29` makes it **3 of 11** — an unremarkable figure, stated because it is the true one. The `PRD-023` row's FOUNDATIONAL *"3 of 3"* does not transfer either, `BC-29` not being FOUNDATIONAL. Reusing either would have been fluent and false. ⚠ **This is the fifth v0.x admission** — after `PRD-013`, `PRD-016`, `PRD-014` and `PRD-023` — and the fifth PRD to leave `PLANNED` **directly** for `FROZEN`, each within a single lifecycle pass. ⛔ **`FROZEN` is not `VERIFIED` for `PRD-017`:** 0 of **78** acceptance criteria proven, 0 of **40** `IMPL-1200`…`1239` tasks implemented, acceptance coverage **94 of 132 = 71.2%** (**not** the 132/132 = 100.0% task figure, which counts a different thing), **all 13 `FIL-GAP-*` OPEN**, **`IMPL-1230`…`1236` BLOCKED** on `B-11`, and the 7 architecture tests required by `TRACEABILITY_MATRIX.md` §10.3 still missing. ⛔ **And one thing this admission pointedly does not claim:** the V1 Student-to-Student File/Media sharing capability is **specified and not servable**, because BC Map **L331** does not list `BC-12` Messaging among `E-22`'s consumers — `FIL-GAP-012`, OPEN, **routed to the Architecture Owner rather than closed by the Governance Owner act that froze the document**. *Prior text retained:* *Was 11; **`PRD-023`** Settings & Configuration is admitted 2026-08-20 at **v0.1** by `ACCEPTED` `ADR-0053` under **`BASELINE-2026-08-20-A`**. Re-derived by enumerating the status column, not by incrementing.* ⚠ **`BC-25` Configuration completes the FOUNDATIONAL band at 3 of 3, and that claim was measured against BC Map L271 rather than borrowed from either precedent sentence in this row.** L271 reserves the band for `BC-18`, `BC-19` and `BC-25`; `BC-18` (Authentication) and `BC-19` (`PRD-013`) already held Rank 3, so this is the band's **closing** admission — a different claim from the `PRD-013` row's *"first `FOUNDATIONAL`-tier context frozen"* and from the `PRD-016` row's capability-band wording, and it would have been fluent and false to reuse either. ⚠ **This is the fourth v0.x admission** — after `PRD-013`, `PRD-016` and `PRD-014` — and the fourth PRD to leave `PLANNED` **directly** for `FROZEN`, each within a single lifecycle pass. ⛔ **`FROZEN` is not `VERIFIED` for `PRD-023`:** 0 of 59 acceptance criteria proven, 0 of 30 `IMPL-1100`…`1129` tasks implemented, acceptance coverage **76 of 113 = 67.3%**, 8 `CNF-GAP-*` OPEN, and the 7 architecture tests required by `TRACEABILITY_MATRIX.md` §10.3 still missing. *Prior text retained:* *Was 10; **`PRD-014`** Entitlement is admitted 2026-08-19 at v0.1 by `ACCEPTED` `ADR-0052` under `BASELINE-2026-08-19-C`. Re-derived by enumerating the status column, not by incrementing.* Prior text retained:* *Was 9; **`PRD-016`** Audit Trail is admitted 2026-08-19 by `ADR-0051` at **v0.1** under `BASELINE-2026-08-19-B`.* ⚠ **`PRD-016` is the first CAPABILITY & GENERIC band context frozen, and the claim is stated with its measurement attached rather than borrowed from the row's previous sentence.** The `PRD-013` phrasing below — *"the first `FOUNDATIONAL`-tier context frozen"* — **does not transfer to `BC-24`**: BC Map **L271** reserves that band for `BC-18`, `BC-19` and `BC-25`, while **L259–267** places `BC-24` in the capability band. Of that band's **11** contexts (`BC-20`…`BC-24`, `BC-26`…`BC-31`), **none** was owned by any of the nine PRDs frozen before this one. Reusing the adjacent precedent phrase would have been fluent and false. *The prior row's text follows verbatim:* **9** — `PRD-000`, `PRD-001`, `PRD-002`, `PRD-004`, `PRD-005`, `PRD-006`, `PRD-007`, **`PRD-008`**, **`PRD-013`**. *Was stated as 7.* **Two corrections in one row:** `PRD-008` was frozen 2026-08-17 by `ADR-0049` at **v1.7** but this row still counted it under `DRAFT` — logged as **`GCP-17`** in `DOCUMENTATION_BASELINE.md` §6 rather than silently absorbed; and `PRD-013` Tenancy is admitted 2026-08-19 by `ADR-0050` at **v0.1**. **All four `[CORE]` cluster contexts `BC-01`…`BC-04` are frozen**, which was the first time the Core Library cluster was specified end to end \u2014 and with `BC-05` and `BC-19` added, **the `[CORE]` cluster now has settled contracts on its money and its tenancy boundaries too**. `PRD-013` is the **first `FOUNDATIONAL`-tier** context frozen (BC Map L271) |
| `IMPLEMENTING` | **1** — `PRD-003` |
| **`DRAFT`** | **2** — **`PRD-019`** Integration (v0.4) and **`PRD-022`** SaaS Billing. *Was stated as 3.* **`PRD-008` has been removed from this count: it is `FROZEN` since 2026-08-17 (`ADR-0049`), and counting it here was the `GCP-17` defect.** The original row's text is preserved for audit: **`PRD-008`** Revenue & Finance (v1.7, admitted 2026-08-15), **`PRD-019`** Integration (v0.1, created 2026-08-15) and **`PRD-022`** SaaS Billing. *Was 1.* ⚠ **`PRD-008`’s admission is the act `GCP-14` records as contested, and it is disclosed rather than absorbed.** It is lawful here because (i) `GCP-14` **itself** already reconciles the two tests at L343–L346 — §7’s *"conferred, not claimed"* reasoning *"is about **`FROZEN`** … and was over-generalised to `DRAFT`"*; (ii) `GCP-14` **itself** names the deciding authority at L351, and that authority was **conferred explicitly** for this act (`ADR-0043` §8.2); (iii) the §2.1 **L42** evidence test is met — the document is on disk with a version header; and (iv) the register **already executed** this transition twice, for `PRD-004` v1.4 and `PRD-022` v1.9. ⚠ **`GCP-14`’s wording defect is NOT closed by this move and remains OPEN** — §2.1 and §7 still state incompatible tests — and the direction of travel is stated plainly: this **is** the convenient direction, and the v2.0 pass was right to refuse it **without** conferred authority. ⛔ **`DRAFT` is not `FROZEN` for any of the three:** `PRD-008` has **0 Freeze-blocking gaps** as of v1.7 but **no `DOCUMENTATION_BASELINE.md` §3 row**, and **Stage 5 and Stage 6 have never been performed** — `docs/40-implementation/revenue-finance/` does not exist. `PRD-019` is **Stage 2 PARTIAL** with **0 identifiers issued**. *Superseded text retained verbatim:* **1** — **`PRD-022`** SaaS Billing, admitted 2026-08-05 on the §2.1 L42 evidence test and the `PRD-004` v1.4 precedent; **Stage 3 not performed, 7 of 7 gaps blocking**. **Re-checked at `PRD-022` v0.3, 2026-08-15, and NOT changed — which is the point of re-checking it.** A conferral of ten authority decisions ratified six `PRD-022` defaults (Platform Charge **3%**, future-rate-only with history immutable; settlement due day **15th**, with existing obligations never moving; a **mandatory independent cash-only settlement method**; free trial **14 days**), and the gap count **stayed at 7 / 7 / 7**, because *a default being ratified is not a gap being closed*. `SAAS-GAP-007` is now **narrowed to nothing and still blocking** — the three permitted due days are known, but `X-13` requires a **declared closed range**, and a three-value enumeration in a decision record is not one. `SAAS-GAP-003` and `SAAS-GAP-004` are **untouched**; decision 8 in fact made `SAAS-GAP-004` **harder**, because it makes cash settlement mandatory while that gap records that **no role can perform it** — a worse position on paper and a better one in fact. **Stage 3 was still not performed**, so this row's status does not move either: `PRD-022` stays **`DRAFT`**. See **`GCP-14`** in §4.3: this register states two incompatible tests for `DRAFT`, and `PRD-008` is the same class of case but is deliberately **not** restatused here. *Was 0.* *The prior reading of this row is preserved verbatim below, because it is the evidence for `GCP-14`.* *unchanged, but for a different reason this time.* Neither `PRD-005` nor `PRD-007` ever appeared in this row: each moved `PLANNED` → **`FROZEN`** within a single day. **`PRD-006` did not** — it carried `Status: DRAFT` in its own header through nine versions and **two refused freeze attempts**, and this register nevertheless showed it as `PLANNED` throughout, because status here is derived from `DOCUMENTATION_BASELINE.md` §3 and **not** from a PRD's self-description. That divergence was correct: *"Freeze is **conferred, not claimed**"* |
| `PLANNED` | **8** — `PRD-009`, `PRD-010`, `PRD-011`, `PRD-012`, `PRD-015`, `PRD-018`, `PRD-020`, `PRD-021`. *Was 9; **`PRD-017`** left `PLANNED` on 2026-08-20 by **freezing**, not by being withdrawn — admitted at Rank 3 by `ADR-0054`. Re-derived by enumerating §4.3's status column, not by decrementing.* ⚠ **`PRD-017` is removed from the enumeration explicitly, and the `PRD-015`…`PRD-018` run is now broken from the middle** — so the remaining members stay enumerated individually rather than collapsed into a range, because a range silently containing a frozen document is the defect class this register has logged eleven times. **`PRD-017` is the fifth PRD ever to leave `PLANNED` directly for `FROZEN`**, after `PRD-013`, `PRD-016`, `PRD-014` and `PRD-023`. *Prior text retained:* *Was 10; **`PRD-023`** left `PLANNED` on 2026-08-20 by **freezing**, not by being withdrawn — admitted at Rank 3 by `ADR-0053`. Re-derived by enumerating §4.3's status column, not by decrementing.* ⚠ **`PRD-023` is removed from the enumeration explicitly, because it was the row's last member and a range written as `PRD-020`…`PRD-023` would now silently contain a frozen document** — the defect class this register has logged ten times. **`PRD-023` is the fourth PRD ever to leave `PLANNED` directly for `FROZEN`**, after `PRD-013`, `PRD-016` and `PRD-014`. *Prior text retained:* *Was 11; **`PRD-014`** left `PLANNED` on 2026-08-19 by **freezing**, not by being withdrawn.* Prior text retained:* *Was 12; **`PRD-016`** left `PLANNED` on 2026-08-19 by **freezing**, admitted at Rank 3 by `ADR-0051`.* **The `PRD-014`…`PRD-018` run is broken from the middle** — `PRD-016` has left it, so the remaining members are enumerated individually rather than as a range, because a range that silently contains a frozen member is the defect class this register has now logged nine times. **`PRD-016` is the second PRD ever to leave `PLANNED` directly for `FROZEN`**, after `PRD-013` eight rows above, and like it was drafted, reviewed, traced, task-planned and frozen within a single lifecycle pass. *The prior row's text follows:* **12** — `PRD-009`…`PRD-012`, `PRD-014`…`PRD-018`, `PRD-020`, `PRD-021`, `PRD-023`. *Was 13; **`PRD-013`** left `PLANNED` on 2026-08-19 by **freezing**, admitted at Rank 3 by `ADR-0050`.* **`PRD-013` is the first PRD ever to leave `PLANNED` directly for `FROZEN`**, having been drafted, reviewed, traced, task-planned and frozen within a single lifecycle pass. The prior row's text follows: **13** — `PRD-009`…`PRD-018`, `PRD-020`, `PRD-021`, `PRD-023`. *Was 15; `PRD-008` and `PRD-019` both moved to `DRAFT` on 2026-08-15 (`ADR-0043`).* **Still not a contiguous run**: `PRD-019` and `PRD-022` have both left from the middle. ✅ **The `GCP-14` inconsistency this row used to carry is discharged — `PRD-008` no longer appears here while a versioned file sits on disk** — but **`GCP-14` itself stays OPEN** as a wording defect for the Governance Owner, because the two incompatible `DRAFT` tests in §2.1 and §7 were **not** rewritten. *Superseded text retained verbatim:* **15** — `PRD-008`…`PRD-021`, `PRD-023`. *Was 16; `PRD-022` moved to `DRAFT` 2026-08-05.* **No longer a contiguous run**: `PRD-022` has left the block from the middle. `PRD-008` remains in this row although a v0.8 file exists on disk — see **`GCP-14`** |
| `DISCOVERY` · `IN_REVIEW` · `APPROVED` · `IMPLEMENTED` · `VERIFIED` | **0 each** |
| Missing **V1** PRDs | **10** — *was 11; **`PRD-017`** File & Media now has a document and is `FROZEN` at Rank 3, so like the `PRD-016`, `PRD-014` and `PRD-023` decreases before it this one is **unqualified**: 232 identifiers across 8 registers, a published `IMPL-1200`…`1239` range with `1240`…`1299` reserved, and all seven lifecycle stages passed at their gates.* **The ninth decrease in this row's history.** ⚠ Three things it does **not** claim, stated in the same terms the decreases above use: acceptance coverage is **94 of 132 = 71.2%**, not 100% — and that figure is **not** the 100.0% task-coverage figure, which counts a different thing — **0 of 78** criteria are proven by a test, and **7 of 7** required architecture tests do not exist. So this is **a specification delivered, not a specification verified**. ⚠ **A fourth qualification with no precedent in the rows above, stated because it is the one that matters most to a reader planning V1:** this module's specification is complete and **one of its V1 capabilities cannot lawfully be served**. Student-to-Student Text + File/Media Sharing is retained in V1 scope, and BC Map **L331** does not list `BC-12` Messaging among `E-22`'s consumers — so the context that needs a `FileRef` cannot obtain one. `FIL-GAP-012` is **OPEN** and routed to the Architecture Owner; **`ADR-0016` is the exact one-cell precedent for the fix and `ADR-0054` §3.2 declines to exercise it** for want of authority. **A document delivered is not a capability shippable**, and this row now records the difference. *Prior text retained:* **11** — *was 12; **`PRD-023`** Settings & Configuration now has a document and is `FROZEN` at Rank 3, so like the `PRD-016` and `PRD-014` decreases before it this one is **unqualified**: 180 identifiers across 8 registers, a published `IMPL-1100`…`1129` range, and all seven lifecycle stages passed at their gates.* **The eighth decrease in this row's history.** ⚠ Two things it still does **not** claim, stated in the same terms the two decreases above use: acceptance coverage is **76 of 113 = 67.3%**, not 100% — and that figure is **not** the 100.0% task-coverage figure, which counts a different thing — and **0 of 59** criteria are proven by a test. So this is **a specification delivered, not a specification verified**. ⚠ It also does not claim completeness of the *value* surface: `CNF-CFG-*` is **deliberately empty** because `PRD-023` owns the resolution machinery and not the value list, so the 104 configurables of the clean census stay with their 8 existing owners. *Superseded text retained verbatim:* **12** — *was 13; **`PRD-014`** Entitlement now has a document and is `FROZEN`, so like the `PRD-016` decrease before it this one is **unqualified**. Prior text retained: was 14; **`PRD-016`** Audit Trail now has a document, and unlike the two qualified decreases recorded below this one is **unqualified**: `PRD-016` is `FROZEN` at Rank 3 with **58 identifiers declared**, a published `IMPL-900`…`929` range, and all seven lifecycle stages through Stage 7 passed at their gates.* **The seventh decrease in this row's history.** ⚠ Two things it still does **not** claim: acceptance coverage is **27 of 35 = 77.1%**, not 100%, and **0 of 18** criteria are proven by a test — so this is **a specification delivered, not a specification verified**. *Superseded text retained verbatim:* **14** — *was 15.* **The sixth decrease in this row’s history**, and the most qualified one: `PRD-019` now has a document, but that document **assigns** the payment webhook wire contract to `BC-31` and **authors none of it** — **0 identifiers issued, Stage 2 PARTIAL**. A specification that names its owner is **a boundary drawn, not a specification delivered**, which is a weaker claim than the `PRD-022` row below makes. `PRD-008` is **not** counted as missing either, but it is **`DRAFT`, not `FROZEN`**. *Superseded text retained verbatim:* **15** — *was 16.* **The fifth decrease in this row's history**; every movement before `PRD-004` was upward. `PRD-022` now has a document, though a `DRAFT` with six blocking gaps is a **specification begun, not a specification delivered** |
| Duplicate PRDs | **0** — no requirement is specified twice |
| **Contested bounded contexts** | **0** — *was 2, corrected to 3 on 2026-08-04, then resolved to 0 the same day.* `BC-19` → `PRD-013` and `BC-29` → `PRD-017` by `ADR-0013`; `BC-25` → `PRD-023` by `ADR-0017`. `PGA-11` **closed** |
| &nbsp;&nbsp;resolved by transfer to an existing PRD | **2** — `BC-19` → `PRD-013`, `BC-29` → `PRD-017` |
| &nbsp;&nbsp;resolved by registering a new PRD | **1** — `BC-25` → `PRD-023`, on Master PRD §8 module 18 + the §4.3 `PRD-022` precedent |
| PRDs with an explicit owner model | **24 of 24** — role-based, [`PRD_OWNERSHIP_MODEL.md`](./PRD_OWNERSHIP_MODEL.md) |
| PRDs with a *named individual* owner | **0 of 24** — by design; §5 and model §1.1 forbid recording personal names |
| PRDs unassignable under the one-holder-per-role rule | **1** — `PRD-012`, which spans two owners at two ranks (§5) |

**Reserved, not counted above:** `PRD-012a` and `PRD-012b` (§4.1). They are the two documents `PRD-012` becomes
and are not separately registered until `PRD-012` is retired, so counting them now would double-count one gap.

**No PRD has reached `VERIFIED`, and none is close.** `PRD-001`, the most complete, cannot deliver an OTP
(`IMPL-020`) and carries a P0 release blocker (`TASK-D10`).

> **`PRD-004` is `FROZEN` as of 2026-08-04, admitted at v1.2 by `ADR-0018` under `BASELINE-2026-08-04-C`.** Per
> §2.1 that status is **conferred by the baseline row, not read off the PRD** — it reached Stage 7 through three
> independent reviews and two correction rounds, the last an adversarial re-audit. Changing it now requires **an
> ADR before the change**.
>
> **`FROZEN` is not `VERIFIED`, and the distinction is doing real work here.** Implementation is **entirely
> unstarted** — 0 of **24** tasks (`IMPL-300`…`IMPL-323`) — and its **32** acceptance criteria are asserted by
> **zero** tests. Per `SID-4.56` a rule that cannot be checked is treated as unmet, so a frozen specification is
> a settled *intent*, not working software. It also carries **11 `SM-GAP-*` open decisions**, two of which
> (`SM-GAP-10`, `SM-GAP-11`) are tensions in **other frozen documents** and each need their own ADR —
> `DOCUMENTATION_BASELINE.md` §6 `GCP-05` and `GCP-06`.

> **`PRD-007` is `FROZEN` as of 2026-08-04, admitted at v1.0 by [`ADR-0020`](../adr/ADR-0020-seat-management-prd-v1.0-baseline.md)
> under `BASELINE-2026-08-04-E`.** Per §2.1 that status is **conferred by the baseline row, not read off the
> PRD** — and the PRD's own *Status* row cites `ADR-0020` rather than asserting freeze on its own authority.
> It is the **largest specification in this repository**: **683 identifiers** across ten registers, **226**
> acceptance criteria, 36 chapters.
>
> **`FROZEN` is not `VERIFIED`.** Implementation is **entirely unstarted** — 0 of **100** tasks
> (`IMPL-500`…`IMPL-599`) — and its **226** acceptance criteria are asserted by **zero** tests. Coverage is
> honest rather than flattering: **443 of 443** criterion-verifiable obligations are claimed by a task, but only
> **325 of 443 (73.4%)** are cited by an acceptance criterion. Per `SEAT-NFR-011`, quoting `SID-4.56`, a rule
> that cannot be checked is treated as unmet.
>
> **All fourteen `SEAT-GAP-*` decisions remain open and are not ratified by admission**, and `SEAT-BR-045`
> forbids resolving any of them by implementation choice. One is structural: **`SEAT-GAP-009` depends on
> `PRD-006` Attendance.**
>
> **Updated 2026-08-05.** This passage read *"`PRD-006` Attendance, which is still `PLANNED` — a frozen consumer
> waiting on an unwritten producer"*. **The producer is now written and frozen** (v1.9, `ADR-0034`), so that half is
> discharged: `PRD-006` specifies the `BC-03` side of the `E-08` occupancy contract, and both ends of the chain are
> Rank 3. **`SEAT-GAP-009` is nonetheless still OPEN**, and saying otherwise would be the exact error `SEAT-BR-045`
> forbids — the gap asks a question that only a named owner may answer, and **a freeze answers no questions**. What
> changed is that the obstacle is no longer *"the other document does not exist"*; it is now an unmade decision, which
> is a smaller and more honest description of the same open item. Freezing `PRD-006` did not discharge it any more
> than freezing `PRD-007` created it.

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
| **v2.1** *(deliberately NOT incremented — see below)* | 2026-08-21 | **One false statement corrected in §4.3's `PRD-017` row; §7's counts verified unchanged and left alone.** During the `PRD-017` Phase 3–7 continuation, the trailing scope cell of the `PRD-017` row asserted *"**`BC-12` Messaging is the one context that needs the edge and does not hold it**"*. **That was measurably false**: BC Map **L331** now reads `BC-01, BC-10, BC-12, BC-14` following `ACCEPTED` [`ADR-0055`](../adr/ADR-0055-e22-consumer-list-includes-bc-12.md). The statement was true when written and was falsified by an amendment that never came back to this cell — the same derived-statement defect class logged as `GCP-11`/`GCP-15`/`GCP-16`/`GCP-19`/`GCP-21`/`GCP-25` in `DOCUMENTATION_BASELINE.md` §6, here in its **register** form. It is corrected because §1 of this document says a register that misstates where things stand is a defect, and the header's own **Precedence** row says *"Where this register disagrees with a PRD, the PRD is right and this register is a defect"* — a fortiori where it disagrees with the **Rank 4** BC Map. Prior text is **retained verbatim** inside the cell rather than overwritten. ⚠ **§7's summary counts were re-read and are CORRECT — nothing there was touched.** `FROZEN` remains **13** and `PRD-017` is already in that list; documents remain **18 files / 16 identities**; `PLANNED` remains **8**. **This pass changed no PRD's status**, so a count edit would have been change for its own sake. ⚠ **The version is deliberately NOT incremented to v2.2, and this is a disclosure rather than an oversight.** This register's header still reads **v2.1 / 2026-08-05 / `BASELINE-2026-08-05-A`** while its rows have been edited by every freeze since — the `PRD-017` row alone carries `ADR-0054`, `ADR-0055` and `ADR-0056` content. That **version-discipline defect is pre-existing, systemic and explicitly out of scope** for this pass: incrementing to v2.2 here would imply this one-cell correction is the only change since 2026-08-05, which is false, and would make the header *less* accurate than leaving it visibly stale. Repairing it properly means reconstructing the version history across roughly a dozen freezes and re-anchoring the baseline field — a **Governance Owner** act. ⛔ **No requirement, status, ownership or count was created, moved or reinterpreted**, consistent with the header's *"Navigational and administrative only"* authority |
| **v2.1** | 2026-08-15 | **`PRD-008` and `PRD-019` both moved `PLANNED` → `DRAFT`, and the `GCP-14` question that v2.0 deliberately refused is now answered by conferred authority rather than by fiat.** §4.1’s `PRD-008` row gains its file path and **v1.7**; §4.2’s `PRD-019` row gains its file path and **v0.1**. **Authority checked before the move, not after** — [`ADR-0043`](../adr/ADR-0043-prd-019-creation-and-prd-008-freeze-blocker-closure.md) §8.2: `GCP-14` **itself** reconciles the two `DRAFT` tests at **L343–L346** (§7’s *"conferred, not claimed"* reasoning is about **`FROZEN`** and was over-generalised), `GCP-14` **itself** names the deciding authority at **L351**, §2.1 **L42**’s evidence test is met, and the register had **already executed** this transition twice (`PRD-004` v1.4, `PRD-022` v1.9). ⚠ **What v2.0 said still stands and is not disowned:** advancing `PRD-008` **without** that authority *"would have resolved `GCP-14` by fiat in the direction that happens to be convenient"*. It is still the convenient direction; it is lawful now only because the authority was conferred explicitly and the evidence test is met on measured facts. ⚠ **`GCP-14` REMAINS OPEN** — the incompatible wording in §2.1 and §7 was **not** rewritten, because fixing the prose is a separate governance act. **Why `PRD-019` exists:** `ADR-0040` §2 established by measurement that **four candidate authors were all barred** from writing the payment webhook wire contract, one of them procedurally — *"`PRD-019` does not exist"*. Creating it removes **only** that procedural bar. ⛔ **`PRD-019` authors none of the contract it owns** — 0 identifiers, no published range, Stage 2 **PARTIAL**, and the gateway webhook feature is still **unbuildable** (`Q-B31`). §7 counts: documents **12 files/10 identities → 13 files/11 identities**, `DRAFT` **1 → 3**, `PLANNED` **15 → 13**, missing V1 **15 → 14**. Registered PRDs remain **24** — both rows already existed and changed **status only**. ⛔ **NEITHER PRD IS FROZEN, AND THIS REGISTER DOES NOT CONFER FREEZE:** no `DOCUMENTATION_BASELINE.md` §3 row was written or requested, and for `PRD-008` **Stage 5 and Stage 6 have never been performed** — `docs/40-implementation/revenue-finance/` does not exist. `PRD-008` reaching **0 Freeze-blocking gaps** is a gap count, **not** a lifecycle stage. **No requirement was created, modified, moved or withdrawn; no frozen document was touched; no bounded context was created (still 31); no `E-*` edge was added; no permission, role, retention period, endpoint, schema or provider was invented; and this register created, reinterpreted and withdrew nothing** (§Authority: *"navigational and administrative only"*). |
| **v1.0** | 2026-08-04 | Created. 23 PRDs registered — 4 existing (6 files), 19 planned. Freeze status derived from `DOCUMENTATION_BASELINE.md` §3/§7 rather than from PRD self-declaration, because **no PRD declares its own freeze state** (§2.1). Ownership recorded as **unassigned for all 23** because no document-owner field exists anywhere in the repository (§5). Bounded-context ownership verified across all 31 contexts (§6). **No requirement was created, modified, reinterpreted or withdrawn; no PRD was edited.** |
| **v1.1** | 2026-08-04 | **Ownership closed.** All four `Owner` fields (§§3.1–3.4) changed from *Unassigned* to four organizational roles, and §5 rewritten from *"the field the repository cannot fill"* to *"closed by a role-based model"*, with the original finding preserved verbatim as §5.1 because its reasoning still governs — **no personal name may ever be recorded here**. The gap was resolved by establishing that names were the wrong thing to record: document ownership needs accountable *roles*, and the roles already existed in `ADR-0001`, `ADR-0011`, `ADR-0012` and Dependency Matrix §11. Maintenance rule 7 added (roles only; this register yields to the ownership model). §7 counts now distinguish *explicit owner model* (**23 of 23**) from *named individual* (**0 of 23**, by design). Two findings surfaced **because** ownership was assigned systematically, neither visible while every field read *Unassigned*: `PRD-012` is **unassignable** under one-holder-per-role as scoped (two owners at two ranks — already flagged in §4.1 as violating the Single Owner Rule), and **`BC-25` has no registered claimant** because `PRD-015` is *Search Indexing*, not configuration — so nothing exists to transfer it to, which is why `ADR-0013` §7 stays open and no `PRD-023` is allocated. **No requirement was created, modified or withdrawn; no PRD file was edited; no bounded-context ownership changed.** |
| **v1.0** | 2026-08-04 | Cross-reference verification, same day, before the register was relied on. Three self-inconsistencies found and corrected: (1) `BC-20` Subscription & Billing was described as *"a genuine V1 gap"* while sitting in the table for contexts with **no** PRD obligation, and was cited as `PRD-022` by two companion documents without ever being registered — now registered as `PRD-022` in a new §4.3, and the old §4.3 renumbered §4.4; (2) `PRD-012a`/`PRD-012b` were cited by the roadmap and gap analysis but existed in no register — now reserved explicitly under §4.1; (3) the missing-V1 arithmetic read *"9 from §31 + 8 from §8.1 + `BC-20`"*, which summed to 18 while §8.1 yields **nine** PRDs — corrected to 19. (4) §6 asserted *"no context is claimed by two PRDs"* while §4.2 of the same register assigned `BC-19` to `PRD-013` and `BC-29` to `PRD-017` — contexts §3.3 gives to `PRD-002`. The clean result was an artefact of listing ownership only for PRDs that exist; the register contradicted itself two sections apart. §6 now records both as **contested**, states the three pieces of evidence, applies the precedence reading without claiming to settle it, and raises `PGA-11`. **Version remains v1.0: these were defects in an unreleased document, not amendments to a published one.** No requirement, PRD or architectural decision was touched. |
| **v1.2** | 2026-08-04 | **Contested-context count corrected from 2 to 3 during Phase 4 validation.** §6's table recorded `BC-25` Configuration as *uncontested* (`"BC-06, BC-25 | PRD-002 | No"`) while `ADR-0013` §2, `PRD_OWNERSHIP_MODEL.md` §4.4 and `PRD_GAP_ANALYSIS.md` §8 all recorded it as contested — this register was the only document still carrying the pre-`ADR-0013` reading, and its §7 count of **2** propagated that error into the summary a reader is most likely to quote. `BC-25` now has its own row, §6.1 is retitled *"The three contested contexts"* and explains **why the conflict was invisible**: `BC-25` is in neither Master PRD §31 nor §8.1, so no registered PRD contests the `Library_PRD_v1.md` header — the collision is with the **BC Map's** *"Owning Platform"* column (`platform/configuration`, rank 3), not with another PRD, and a PRD-to-PRD comparison could not see it. §7 now reports **3**, split into the 2 resolvable by transfer and the **1 with no registered claimant**. This is a *reporting* correction: no ownership was reassigned, `ADR-0013` §7 remains open, no `PRD-023` is allocated, and no frozen document was touched. **Version incremented because v1.1 was already committed — unlike the v1.0 defect rows above, this amends a published state.** |
| **v1.3** | 2026-08-04 | **Contested contexts 3 → 0, and `PRD-023` registered. Governance Closure Phase.** `ADR-0013` was **accepted** and its amendment to `Library_PRD_v1.md` line 10 executed (v1.0 → **v1.1**), so §6 now records `BC-19` → `PRD-013`, `BC-29` → `PRD-017` and `BC-25` → **`PRD-023`**, each undisputed. §6.1 carries the resolution banner `ADR-0013` §6.2 required — **`PRD-002` now lists one owned context where it listed four, and this is not a scope reduction**; the `TenantOrganisation`, `StaffAssignment` and `LibraryBranding` aggregates remain owned there. **`PRD-023` Settings & Configuration added to §4.3** by [`ADR-0017`](../adr/ADR-0017-bc-25-configuration-ownership.md): `BC-25` is Master PRD §8 **module 18**, a `[GENERIC]` **V1** product module at Rank 1, registered on the identical grounds §4.3 already used for `PRD-022` (**module 17**, the preceding row of the same table). §4.4's *"Covered — `PRD-002` owns `BC-25`"* row — false once `ADR-0013` was accepted — is struck and cross-referenced rather than deleted. §5's *"no registered claimant"* finding is marked **RESOLVED** with its reasoning preserved, because that reasoning is what surfaced the question. **The `PRD-012` split is CONFIRMED** in §4.1 as already authorised by Master PRD §8 *Correction 2* (Rank 1) — a confirmation, not a new decision: no requirement exists to divide, `PRD-012` is **not** retired (§8 rule 1 ties retirement to `PRD-012a` being *opened*), and it remains the one PRD unassignable under one-holder-per-role. §7 counts: registered **23 → 24**, `PLANNED` **19 → 20**, missing V1 **19 → 20** (*a truer number — a module that was always missing had been mis-recorded as covered*), contested **3 → 0**, owner-model **24 of 24**, named individuals **0 of 24**. **No requirement was created, modified, moved or withdrawn.** |
| **v2.0** | 2026-08-05 | **`PRD-022` v0.1 → v0.2 and the blocking-gap count 6 → 7.** The draft now specifies the **billing period** (a closed inclusive interval bounded by consecutive due days, `[15th of M, 14th of M+1]` at the default), the **calendar due date** (default the **15th**, `PR-1` only, non-retroactive in both date and money), the **library's Platform Charge view** (fully populated for a **100%-cash** library), and both **load tests** worked as arithmetic. Registers move 70 → **102**, obligation-bearing 43 → **64**, traceability 83.7% → **87.5%**, and one **new** gap `SAAS-GAP-007` was opened — a configured due day above 28 has no defined February behaviour — so the blocking count **rose**. **Nothing was closed.** **`ADR-0036` was registered `PROPOSED`** in `ADR-INDEX.md` (proposed 12 → **13**, accepted unchanged at **23**); it overturns a finding recorded in `PRD-008` §39.2, which was **retracted at `PRD-008` v1.0** rather than quietly rewritten. **What this pass deliberately did NOT do:** `PRD-008`'s §4.3 row was **left at `PLANNED` with no version cell**, even though its document moved v0.9 → **v1.0**. Restatusing it is exactly the act **`GCP-14`** records as unresolved — this register states two incompatible tests for `DRAFT` — and that conflict is for a **governance owner**, not for this pass. Advancing `PRD-008` here would have resolved `GCP-14` by fiat in the direction that happens to be convenient. **`GCP-14` therefore remains open, and `PRD-008` remains `PLANNED` in this table while its document is a v1.0 draft on disk** — an inconsistency that is **recorded rather than hidden**. No PRD was frozen, no ADR accepted, no frozen document modified. |
| **v1.9** | 2026-08-05 | **`PRD-022` SaaS Billing drafted — `PLANNED` → `DRAFT`, the second PRD ever to leave `PLANNED` by drafting rather than freezing.** §4.3's `PRD-022` row gains its file path and **v0.1**. **Authority checked before the move, not after:** §2.1 L42's evidence test for `DRAFT` is *"a document on disk with a version header"*, and the **`PRD-004` v1.4 precedent** executed this exact transition; `PRD_REGISTRY.md` is **not** a Rank 1–5 baseline document, so baseline §7 rule 1 requires no prior ADR. **Why the draft exists:** three findings had terminated with no lawful owner — `FEE-GAP-014`, `FEE-GAP-017` and the unspecified SaaS free trial. §7 counts: documents **10 files/8 identities → 12 files/10 identities**, `DRAFT` **0 → 1**, `PLANNED` **16 → 15**, missing V1 **16 → 15**. Registered PRDs remain **24** — `PRD-022` was already registered and changed status only. **`GCP-14` raised, not resolved:** §2.1 L42 and §7's `DRAFT` row state incompatible tests for the same status, and `PRD-008` is the same class of case; it is deliberately **left at `PLANNED`** rather than swept, and referred to a governance owner. **No requirement was created, modified, moved or withdrawn; no frozen document was touched; no bounded context was created; no integration edge was added; no ADR was accepted.** |
| **v1.4** | 2026-08-04 | **`PRD-004` Student Management drafted; Library Member Directory placement executed.** §4.1 `PRD-004` moves `PLANNED` → **`DRAFT`** with its file path, the first PRD to leave `PLANNED` since this register was created. §6's *"Library Member Directory (module 3) — **No PRD.** Belongs to `PRD-004`"* row is annotated **placement executed**: the Directory is delivered as **`PRD-004` chapter 5**, requirements `LMD-1`…`LMD-31`, as a **read composition** owning no aggregate and no invariant (`AR-1`). **No standalone Directory PRD was created, no `BC-32` was created, and the bounded-context count remains 31** — the register's own adjudication was executed, not revisited. §7 counts: documents **6 files/4 identities → 7 files/5 identities**, `DRAFT` **0 → 1**, `PLANNED` **20 → 19**, missing V1 **20 → 19** — **the first decrease in the missing-V1 row's history**, every prior movement having been upward. Registered PRDs remain **24**: `PRD-004` was already registered and changed status only. A note records that `DRAFT` is the *weakest* status implying a file exists — **not frozen, not baselined, not ranked, 0 of 28 acceptance criteria tested, 9 `SM-GAP-*` decisions open**. **No requirement was created, modified, moved or withdrawn; no frozen document was touched; no integration edge was added.** |
| **v1.5** | 2026-08-04 | **`PRD-004` Student Management FROZEN — the fourth baselined PRD, and the first this register has watched move through the full lifecycle.** §4.1 `PRD-004` moves **`DRAFT` → `FROZEN`** at **v1.2**, admitted by **`ADR-0018`** under **`BASELINE-2026-08-04-C`**. §7 counts: `FROZEN` **3 → 4**, `DRAFT` **1 → 0**. The §7 note asserting *"not frozen, not baselined, not ranked"* is replaced, and two stale figures inside it corrected — it said **28** acceptance criteria and **9** gaps; the frozen document carries **32** and **11**. Status is recorded here **because the baseline confers it** (§2.1), not because the PRD declares it: `Student_Management_PRD_v1.md` contains no self-declared freeze, consistent with all four other baselined specifications. **Version preserved at v1.2 — not renumbered to v1.0** — following the `PRD-003`-at-v1.0 precedent, since freeze changes status and not content. **No requirement identifier was added, removed, renumbered or reworded**, no ranked document was amended, no bounded context was created (still **31**) and no integration edge was added. `FROZEN` is **not** `VERIFIED`: 0 of 24 tasks and 0 of 32 acceptance criteria are proven, so nothing here claims `BC-01` works. Two gaps remain open and are **not** ratified by admission — `SM-GAP-10` and `SM-GAP-11`, each requiring a separate ADR from its named owner (`GCP-05`, `GCP-06`). |
| **v1.8** | 2026-08-05 | **`PRD-006` Attendance Management FROZEN — the seventh baselined PRD, and the one that closes the `[CORE]` cluster.** Status `PLANNED` → **`FROZEN`** at **v1.9**, admitted by **`ADR-0034`** under **`BASELINE-2026-08-05-A`**. `FROZEN` **6 → 7**; `PLANNED` **17 → 16**; documents that exist **9 files / 7 identities → 10 files / 8 identities**; missing V1 PRDs **17 → 16**. **`PRD-000`…`PRD-007` are contiguous again** and **all four `[CORE]` contexts `BC-01`…`BC-04` are frozen**, so the `E-08` occupancy chain is Rank 3 at both ends and this register's own complaint that `PRD-007` was *"a frozen consumer waiting on an unwritten producer"* no longer holds. **`SEAT-GAP-009` is NOT closed by this**, and the §7 note was rewritten to say so explicitly: the producer now exists, but the gap asks a question only a named owner may answer, and `SEAT-BR-045` forbids resolving one by implementation choice. **A freeze supplies a document; it answers nothing.** Likewise **all 18 open gap-ledger entries in `PRD-006` remain OPEN** with named owners, and **`ADR-0031` remains `Proposed`** because no Product Owner has approved a range for the presence tolerance — **a twenty-fifth configuration row was refused rather than invented**, and the freeze did not change that. **The freeze was blocked and the blocker was resolved by withdrawal rather than by permission.** Edge `E-27` (`BC-03` → `BC-04`), added by `ADR-0032`, was found to sit outside the intra-cluster allow-list `E-01`…`E-10` that `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` enforces *"as an explicit allow-list, not 'anything within the cluster'"* — and it was measured to be the **only** edge above `E-10` with both endpoints in that cluster. `ADR-0033` was accepted under **Architecture Owner authority conferred by the human principal** (recorded as a conferral, **not** as an ARB meeting) and **withdrew `E-27`**: BC Map → v1.7, edge set back to `E-01`…`E-26`, **26 rows, identical to the pre-`ADR-0032` count**. **The allow-list was not widened and the Dependency Matrix was not amended** — it stands byte-unchanged, because withdrawing the edge **restored compliance with the law that already existed**. **`ADR-0032` was not demoted**; it is still `Accepted` and its decision stands, only its transport changed. **Three prior states of this register are worth recording as being correct rather than lucky.** Through nine PRD versions and **two refused freeze attempts**, `PRD-006` carried `Status: DRAFT` in its own header while this register showed `PLANNED` — and that divergence was right, because status here derives from `DOCUMENTATION_BASELINE.md` §3, never from a PRD's self-description: *"Freeze is **conferred, not claimed**."* The §4.1 prose and the §3 table were updated **in the same commit**, which is the specific discipline `GCP-08` exists to enforce; `GCP-11`, logged in the baseline declaration during this same freeze, is the **fourth** recorded instance of that defect class, so the discipline is applied because the class is live. **No requirement changed anywhere**, **no gate was weakened**, and **no Dart source was touched** (0 files versus the pre-work baseline). **`PRD-006` is `FROZEN`, not `VERIFIED`** — 0 of 80 tasks and 0 of 222 acceptance criteria are proven. |
| **v1.7** | 2026-08-04 | **`PRD-007` Seat Management FROZEN — the sixth baselined PRD, the largest specification in the repository, and the first frozen PRD whose own dependency is still unwritten.** §4.1 `PRD-007` moves **`PLANNED` → `FROZEN`** at **v1.0**, admitted by **[`ADR-0020`](../adr/ADR-0020-seat-management-prd-v1.0-baseline.md)** under **`BASELINE-2026-08-04-E`**. §7 counts: `FROZEN` **5 → 6**, `PLANNED` **18 → 17**, documents **8 files/6 identities → 9 files/7 identities**, missing V1 **18 → 17** — the **third** decrease in that row's history, all three on the same day. `DRAFT` stays at **0**: like `PRD-005`, `PRD-007` was drafted, reviewed and corrected repeatedly and frozen within a single day, so no `DRAFT` row was ever published for it. **Two rows stopped being contiguous runs and now say so** — `PRD-006` Attendance remains `PLANNED` while `PRD-007`, which consumes its occupancy signal (`SEAT-GAP-009`), is frozen; a register that reported *"`PRD-006`…`PRD-023`"* would have hidden a frozen consumer waiting on an unwritten producer. **This is a status change only — the register created, modified, reinterpreted and withdrew nothing** (§Authority). Status is recorded here **because the baseline confers it** (§2.1), not because the PRD declares it. **Version preserved at v1.0 — not renumbered** — following the `PRD-003`-at-v1.0, `PRD-004`-at-v1.2 and `PRD-005`-at-v1.4 precedents, since Stage 7 confers status and not content. **No requirement identifier was added, removed, renumbered or reworded** — **683 identifiers** across ten registers (`SEAT-FR` 304, `SEAT-BR` 45, `SEAT-INV` 14, `SEAT-EVT` 4, `SEAT-XC` 22, `SEAT-PO` 24, `SEAT-CFG` 18, `SEAT-NFR` 12, `SEAT-AC` 226, `SEAT-GAP` 14), unchanged and re-verified at exit 0 before admission — no ranked document was amended beyond the baseline and ADR index, no bounded context was created (still **31**) and **no integration edge was added** (7 inbound, 3 outbound, all pre-declared). `FROZEN` is **not** `VERIFIED`: **0 of 100 tasks (`IMPL-500`…`IMPL-599`) and 0 of 226 acceptance criteria** are proven, so nothing here claims `BC-04` works; AC coverage of criterion-verifiable obligations is **325 of 443 (73.4%)**, recorded rather than rounded up. **Fourteen gaps remain open and are not ratified by admission** — `SEAT-GAP-001`…`SEAT-GAP-014` — each requiring a decision from its named owner, recorded in `ADR-0020` §3; `SEAT-BR-045` forbids resolving any of them by implementation choice. |
| **v1.6** | 2026-08-04 | **`PRD-005` Membership Management FROZEN — the fifth baselined PRD, and the first to move `PLANNED` → `FROZEN` without ever being recorded as `DRAFT`.** §4.1 `PRD-005` moves **`PLANNED` → `FROZEN`** at **v1.4**, admitted by **[`ADR-0019`](../adr/ADR-0019-membership-management-prd-v1.4-baseline.md)** under **`BASELINE-2026-08-04-D`**. §7 counts: `FROZEN` **4 → 5**, `PLANNED` **19 → 18**, documents **7 files/5 identities → 8 files/6 identities**, missing V1 **19 → 18** — the **second** decrease in that row's history, both on the same day. `DRAFT` stays at **0**: unlike `PRD-004`, which this register watched sit at `DRAFT` between two versions, `PRD-005` was drafted, reviewed five times, corrected four times and frozen within a single day, so the register never published a `DRAFT` row for it. **This is a status change only — the register created, modified, reinterpreted and withdrew nothing** (§Authority). Status is recorded here **because the baseline confers it** (§2.1), not because the PRD declares it: freeze is *"conferred externally by admission to the baseline"*, and a `grep` of `PRD-005` for its own status would have been wrong, exactly as §2.1 predicted for all five earlier specifications. **Version preserved at v1.4 — not renumbered to v1.0** — following the `PRD-003`-at-v1.0 and `PRD-004`-at-v1.2 precedents, since Stage 7 confers status and not content. **No requirement identifier was added, removed, renumbered or reworded** (333 identifiers across ten registers, unchanged), no ranked document was amended, no bounded context was created (still **31**) and **no integration edge was added**. `FROZEN` is **not** `VERIFIED`: **0 of 42 tasks (`IMPL-400`…`IMPL-441`) and 0 of 97 acceptance criteria** are proven, so nothing here claims `BC-02` works. **Five gaps remain open and are not ratified by admission** — `MM-GAP-001`, `MM-GAP-002`, `MM-GAP-005`, `MM-GAP-010`, `MM-GAP-010a` — plus `MM-GAP-006a`/`MM-GAP-007a` carried against the BC Map; each requires a decision from its named owner, recorded in `ADR-0019` §3. **Both PRDs on the `E-01` dependency are now frozen**, so `PRD-006`, `PRD-007` and `PRD-008` inherit settled `E-02`, `E-03` and `E-07` contracts before a line of them is written. |
