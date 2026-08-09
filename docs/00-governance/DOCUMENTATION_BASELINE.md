# Liboora — Documentation Baseline Declaration

| Field | Value |
|---|---|
| **Baseline** | **BASELINE-2026-08-04-C** |
| **Supersedes** | `BASELINE-2026-08-04-B` |
| **Status** | **Locked** |
| **Date** | 2026-08-04 |
| **Declared by** | Enterprise Architecture review (`DOCUMENTATION_AUDIT-001`); re-issued by the **Governance Closure Phase**; extended by the **`PRD-004` Stage 7 freeze** |
| **Authority** | `ADR-0008`, `ADR-0009`, `ADR-0010`, `ADR-0011`, `ADR-0013`, `ADR-0014`, `ADR-0015`, `ADR-0016`, `ADR-0017`, `ADR-0018` |

---

## 1. What this document does

This document declares the **official documentation baseline** for the Liboora platform. It fixes, at one point in
time, which documents are authoritative, at which versions, and in what order of precedence. Every other document
in the repository is either **in the baseline**, **superseded by it**, or **archived**.

Its purpose is to remove the question *"which document do I believe?"* from the developer's day.

---

## 2. Baseline declaration

**Authentication PRD v2.0 is the official baseline specification for `BC-18` Identity & Access.**

Defect `D-7` — *"the Authentication PRD is not present in this repository"* — is **CLOSED**.

It is closed **by authorship, not by recovery.** The original v1 text was sought and is not in the repository, not
in git history, and not recoverable from any versioned artefact. v2.0 was written from scratch against the binding
constraints that *were* present. It does not reproduce v1 and makes no claim about what v1 contained. Full
reasoning is recorded in [`ADR-0008`](./adr/ADR-0008-authentication-prd-v2-baseline.md).

**If the original v1 ever resurfaces it has no standing.** Reinstating any part of it would require a new ADR.

### 2.1 Second declaration — the Library PRD

**Library PRD v1.1 is the official baseline specification for the Library Management domain**, together with its
two normative extensions §14A and §14B and the Invitation Security Specification.

> `v1.1` amends **ownership statements and context pointers only** — `ADR-0013` (capability-context ownership) and
> `ADR-0015` (finance contexts `BC-05`/`BC-20`). **No requirement was added, removed or changed:** the identifier
> sets are provably identical to `v1.0` (129 `LIB-*`, 10 `LCFG-*`, 10 `LXC-*`, 22 `LEV-*`, 12 `LAC-*`). See
> `ADR-0013` §8.1.

Gap **`U-4`** — *"Library PRD §§1–25 never supplied"* — is **CLOSED by receipt.**

Unlike `D-7`, this is not closed by authorship. The sections were **supplied by the product owner** on 2026-08-03
and are preserved in `Library_PRD_v1.md`. Every requirement in the supplied text survives in the baseline. Fourteen
conflicts against higher-ranked documents were found and corrected; three of those were blocking. The corrections
are recorded, with the reasoning for each, in
[`LIBRARY_PRD_ALIGNMENT.md`](../30-product/library/LIBRARY_PRD_ALIGNMENT.md) §2. **Nothing was removed.**

Deferral **`AR-4` invitation security specification** is also **CLOSED**, by authorship, in
[`INVITATION_SECURITY_SPECIFICATION.md`](../30-product/library/INVITATION_SECURITY_SPECIFICATION.md) and
[`ADR-0009`](./adr/ADR-0009-invitation-security-model.md). The deferral instructed *"do not invent"*; its stated
precondition — that §§1–25 had not been received — no longer holds, and the received text confirms the invitation
feature exists in three distinct forms. It is lifted **on evidence, not by assumption.**

### 2.2 Third declaration — the Student Identity & Profile PRD

**Student Identity & Profile PRD v1.0 is the official baseline specification for `BC-10` Global Person
Identity**, together with its alignment report.

Like the Library PRD, this is closed **by receipt**: Chapters 1–5 were supplied by the product owner on
2026-08-04. Thirteen conflicts against higher-ranked documents were found; four were blocking. Eleven were
accepted and **two were rejected**, with the draft's original intent preserved in both cases. Every acceptance
and both rejections are recorded in
[`STUDENT_IDENTITY_ALIGNMENT.md`](../30-product/student-identity/STUDENT_IDENTITY_ALIGNMENT.md).
**No functionality was removed.**

**This declaration carries a structural change that the previous two did not.** Resolving conflict `SC-1`
required amending the Bounded Context Map's Identity Triad — the section the map itself flags as *"the
highest-risk modelling decision in LIBOORA"* — and consequentially amending global business rule
`MP-GBR-02`. That reasoning is recorded in
[`ADR-0011`](./adr/ADR-0011-global-person-identity.md), and the amendment is deliberately narrow: **placement,
name, classification and cardinality only.** Linkage rules `ID-1`…`ID-6` and prohibition `X-05` are preserved
unamended, and no dependency law gained an exception — rank 7.5 was introduced precisely so that none was
needed.

Open question **`Q-05`** — *"Is Global Student available to a person with no library enrollment?"* — is
**CLOSED: yes, necessarily.**

### 2.3 Fourth declaration — the Student Management PRD

**Student Management PRD v1.2 is the official baseline specification for `BC-01` Enrollment**, together with the
Library Members Directory read composition delivered as its chapter 5.

Unlike the previous three, this is closed **by authorship followed by three independent reviews.** It was drafted
on 2026-08-04, reviewed, corrected, reviewed a second time, corrected again, and then re-audited adversarially
against twelve mandated verification items — an audit that attempted **ten disproofs of the specification and
failed on eight outright.** Every finding, every correction and every **rejected** finding is recorded in the six
satellite reports listed in §3.3. Reasoning is in
[`ADR-0018`](./adr/ADR-0018-student-management-prd-v1.2-baseline.md).

**This declaration is the narrowest of the four. No ranked document is amended.** No bounded context was created —
the count remains **31**. No integration edge was added. No global business rule changed. No dependency law gained
an exception. `MASTER_PRD.md`, the Bounded Context Map, the Module Dependency Matrix and `ARCHITECTURE_RULINGS.md`
are **untouched**. Master PRD §8 **module 3** (Library Member Directory) is delivered as `PRD-004` chapter 5 —
`LMD-1`…`LMD-31`, owning no aggregate and no invariant per `AR-1`, so **no `BC-32` exists** and no second member
store was created.

**The version is preserved at v1.2.** Freeze confers status; it does not renumber. The Student Identity PRD was
admitted at v1.0 and remained v1.0; this document is admitted at the version that was verified.

> **Two gaps are admitted OPEN, and that is deliberate.** **`SM-GAP-10`** (is Date of Birth mandatory at `BC-10`?)
> and **`SM-GAP-11`** (is `BC-26` a consumer of `SM-EV-1`/`SM-EV-5`?) are tensions **internal to other frozen
> documents** — `PRD-003` §2.2 vs `SID-5.9`, and BC Map §8 vs §7 respectively. `PRD-004` **discloses** both and
> resolves neither, and its own behaviour is deterministic under every resolution. **Admission does not ratify
> either defect.** Each requires a separate ADR from its named owner — see `ADR-0018` §3.1 and §3.2. Recorded in
> §6 as `GCP-05` and `GCP-06`.

**`PRD-004` is `FROZEN`, not `VERIFIED`.** Implementation is **entirely unstarted** — 0 of 24 tasks
(`IMPL-300`…`IMPL-323`), and **0 of its 32 acceptance criteria are proven by a test.** Per `SID-4.56` a rule that
cannot be checked is treated as unmet, so nothing in this declaration should be read as a claim that `BC-01`
works.

---

## 3. Baseline contents

### 3.1 Governance

| Document | Version | Status |
|---|---|---|
| `00-governance/DOCUMENTATION_BASELINE.md` | **BASELINE-2026-08-04-C** | **This document** |
| `00-governance/adr/ADR-INDEX.md` | Active | Authoritative |
| `00-governance/adr/ADR-0001` … `ADR-0018` | Accepted | Authoritative, binding |
| `00-governance/DOCUMENTATION_AUDIT-001.md` | 001 | Historical record of this review |

### 3.2 Architecture

| Document | Version | Status |
|---|---|---|
| `10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md` | **v1.5** | Authoritative — boundaries, ownership, edges. Identity Triad §4 amended by `ADR-0011`; edge `E-22` consumer list amended by `ADR-0016`. Context count **31, unchanged** |
| `10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md` | **v1.3** | Authoritative — permitted and forbidden dependencies. Rank `R7.5` added by `ADR-0011`; enforcement coverage **12 of 12** per `ADR-0014` |
| `10-architecture/ARCHITECTURE_RULINGS.md` | **v1.2** | Authoritative for `AR-1`, `AR-3`, `AR-4`; `AR-2`, `AR-5`, `AR-6`, `AR-7` promoted to ADRs. `AR-4` deferral lifted |
| `10-architecture/LIBOORA_ENTERPRISE_ARCHITECTURE.md` | **v2.1** | **Descriptive** — must follow the PRDs, never lead them |

### 3.3 Product

| Document | Version | Status |
|---|---|---|
| `30-product/MASTER_PRD.md` | **v1.7** | Authoritative — platform-wide global rules. `MP-GBR-02` amended by `ADR-0011` |
| `30-product/authentication/Authentication_PRD_v2.md` | **v2.0** | **Authoritative — the baseline** |
| `30-product/authentication/prd-v2/00` … `11` | v2.0 | Chapter sources of the above |
| `30-product/authentication/PRD-V2-GOVERNANCE-NOTE.md` | v2.0 | Provenance record — **not part of the specification** |
| `30-product/library/Library_PRD_v1.md` | **v1.1** | **Authoritative — the Library baseline**, §§1–25. Ownership header amended by `ADR-0013`; three finance context identifiers corrected by `ADR-0015`. **No requirement identifier changed** |
| `30-product/library/14A-Library-Discovery-And-Enrollment.md` | v1.0 | Authoritative — discovery, enrollment, public field list |
| `30-product/library/14B-Public-Library-Preview.md` | **v1.0** | Authoritative — anonymous preview, the authentication boundary `PO-1`…`PO-12` |
| `30-product/library/INVITATION_SECURITY_SPECIFICATION.md` | **v1.0** | Authoritative — `IT-1`…`IT-3`, entropy, expiry, revocation, single use, validation, audit, rate limiting |
| `30-product/library/LIBRARY_PRD_ALIGNMENT.md` | v1.0 | Validation record — **not part of the specification** |
| `30-product/library/REVIEW_14A.md` | v1.1 | Historical review record — **not part of the specification** |
| `30-product/student-identity/Student_Identity_PRD_v1.md` | **v1.0** | **Authoritative — the Student Identity baseline**, Chapters 1–5 |
| `30-product/student-identity/README.md` | v1.0 | Module index — navigational, **not part of the specification** |
| `30-product/student-identity/STUDENT_IDENTITY_ALIGNMENT.md` | v1.0 | Validation record, `SC-1`…`SC-13` — **not part of the specification** |
| `30-product/student-management/Student_Management_PRD_v1.md` | **v1.2** | **Authoritative — the Student Management baseline** for `BC-01` Enrollment, 10 chapters. **Chapter 5 is the Library Members Directory** (`LMD-1`…`LMD-31`) as an application-layer **read composition** — no aggregate, no invariant, no second member store (`AR-1`). 251 base identifiers (266 with sub-lettered), ten registers, ten `SM-EV-*` events closed by `SM-7.12`. Admitted by `ADR-0018`; **no requirement identifier changed on admission** |
| `30-product/student-management/README.md` | v1.0 | Module index — navigational, **not part of the specification** |
| `30-product/student-management/PRD-004_ALIGNMENT_REPORT.md` | v1.1 | Validation record, `CONF-1`…`CONF-3`, `DUP-1`…`DUP-4`, `SM-GAP-1`…`SM-GAP-11` — **not part of the specification** |

### 3.4 Configuration and implementation

| Document | Version | Status |
|---|---|---|
| `20-configuration/CONFIGURATION_GUIDE.md` | v1.0 | Normative for operations |
| `40-implementation/DEVELOPER_HANDOFF.md` | v1.0 | Entry point for developers |
| `40-implementation/IMPLEMENTATION_ROADMAP.md` | v1.0 | Sequenced work |
| `40-implementation/AUTHENTICATION_IMPLEMENTATION_CHECKLIST.md` | v1.0 | Per-requirement checklist |
| `40-implementation/TASK-D10-remove-demo-surfaces.md` | v1.0 | Release-blocking task |
| `40-implementation/DEFINITION_OF_DONE.md` | v1.1 | Merge and release gates. Extended to Library Management; the stale `AR-4` *"do not invent"* row replaced |
| `40-implementation/TRACEABILITY_MATRIX.md` | **v1.1** | Requirement → artefact mapping |
| `40-implementation/LIBRARY_IMPLEMENTATION_TASKS.md` | **v1.0** | `IMPL-100`…`IMPL-127` with acceptance criteria and checklists |
| `40-implementation/STUDENT_IDENTITY_IMPLEMENTATION_TASKS.md` | **v1.0** | `IMPL-200`…`IMPL-226` with acceptance criteria and checklists |

### 3.5 Archived — no authority

| Document | Reason |
|---|---|
| `90-archive/authentication-v1/Authentication_PRD.md` | v1 stub; eleven empty slots; superseded by v2.0 |
| `90-archive/authentication-v1/Authentication_PRD_Developer_Guide.md` | Written against the absent v1; every claim of absence is now false |
| `90-archive/authentication-v1/01-*.md` … `11-*.md` | The eleven empty slots |

Archived documents are **retained for history and must not be cited as authority.** Each carries a header saying
so.

---

## 4. Precedence

When two documents disagree, the higher rank wins. This order is not negotiable at implementation time.

| Rank | Source | Scope |
|---|---|---|
| **1** | `MASTER_PRD.md` global rules — `MP-GBR-*`, `MP-CON-*`, `MP-DEP-*` | Platform-wide. Outranks every module PRD |
| **2** | Accepted ADRs (`ADR-0001` … `ADR-0017`) | Structural decisions |
| **3** | **Authentication PRD v2.0** | Everything inside `BC-18` |
| **3** | **Library PRD v1.1** + §14A + §14B + Invitation Security Specification | Everything inside the Library Management domain |
| **3** | **Student Identity & Profile PRD v1.0** + Alignment Report | Everything inside `BC-10` Global Person Identity |
| **3** | **Student Management PRD v1.2** + Alignment Report | Everything inside `BC-01` Enrollment, and the Library Members Directory read composition |
| **4** | Bounded Context Map · Module Dependency Matrix | Boundaries, ownership, permitted edges |
| **5** | Architecture Rulings `AR-1`, `AR-3`, `AR-4` | Domain classifications not promoted to ADRs |
| **6** | Enterprise Architecture v2.1 | **Descriptive only.** Update it to match 1–5; never the reverse |
| **7** | Configuration Guide | Operating values within the envelope 1–3 define |

**A conflict is a defect.** If you find one, do not choose — raise it. The precedence order tells you which
document is *wrong*, not which one to quietly ignore.

**Rank 3 holds four module baselines and they do not overlap.** The Authentication PRD governs `BC-18`; the Student
Identity PRD governs `BC-10`; the Student Management PRD governs `BC-01` Enrollment; the Library
PRD governs Library Management. Where a Library requirement appears to constrain authentication — the preview's
authentication boundary, the invitation acceptance sequence — the Library document states *what must be true* and
`BC-18` remains the sole authority on *how it is decided*. A Library requirement can never grant, evaluate or cache
an authorization decision. That is not a precedence question; it is `X-13` and it is forbidden.

---

## 5. Terms fixed by this baseline

| Term | Means |
|---|---|
| "The Authentication PRD" | Authentication PRD **v2.0**, and nothing else |
| "The specification" (in an authentication context) | Authentication PRD v2.0 |
| "The rulings" | `ARCHITECTURE_RULINGS.md` **v1.2**, noting four are promoted to ADRs |
| "The Library PRD" | `Library_PRD_v1.md` **v1.1** *together with* §14A, §14B and the Invitation Security Specification. All four, never one alone |
| "Library" (unqualified) | **Ambiguous — do not use.** Say `TenantOrganisation` (the billing entity, `BC-19`) or `Branch` (the physical location with hours and seats, `BC-06`) |
| "The BC Map" | `LIBOORA_BOUNDED_CONTEXT_MAP.md` **v1.5** |
| "The EA" | `LIBOORA_ENTERPRISE_ARCHITECTURE.md` v2.1 |

---

## 6. Known gaps carried by this baseline

These are **declared, not hidden.** The baseline is complete for authentication implementation and incomplete
elsewhere. Full detail and priority in `DEVELOPER_HANDOFF.md` §7.

| Gap | Effect | Priority |
|---|---|---|
| `D-10` demo surfaces present in code | **Release blocker** under `MP-CON-11` | **P0** — task `TASK-D10` |
| `IMPL-020` SMS provider / DLT registration not integrated | No OTP can be delivered. Blocks authentication **and** `IT-1` staff invitations | **P0** — on the critical path; DLT approval is multi-week and should be started first |
| ~~`tool/check_module_boundaries.dart` does not exist~~ | **CLOSED 2026-08-04.** Delivered as `IMPL-014`; **12 of 12** enforcement categories implemented per `ADR-0014`. `ADR-0001` is now mechanically enforced, not advisory | — |
| `app → domain/library` boundary findings deliberately **unwaived** | Gate 3 (`check_module_boundaries.dart`) **exits 1 by design** — 9 findings in 1 category. Not a checker defect and **must not** be silenced; clears when `TASK-D10` removes the demo surfaces (`ADR-0012` §3.4) | **P0** — tracked with `TASK-D10` |
| Library Management has **no** implementation code | Documentation is complete; `IMPL-100`…`IMPL-127` are unstarted | **P1** — 23 tasks, 12 at P0 within the module |
| `IMPL-220` — `SID-INT-*` integration rules unenforced | The twelve integration rules are specified but have no mechanical check; **unmet under `SID-4.56`** | P1 |
| ~~`R-5` — `lib/contracts/` referenced but absent~~ | **CLOSED.** Resolved as the pure-Dart package `packages/liboora_contracts`; law `L5` is now certified against real code rather than an empty directory | — |
| `D-8`, `D-9` | Carried forward unchanged | P2 |
| Public Live Occupancy (V2) | Deferred pending a privacy review; V1 exposes only a coarse indicator (`LIB-14B.12`) | P3 — **V2**, no V1 effect |
| Reviews & Ratings (V2) | No bounded context assigned; will require one | P3 — **V2**, no V1 effect |
| Development Standards document (`R-4`) | Deferred | P3 |
| `Q-02` — `branchId` model undecided | Multi-Branch is **V3**; no V1 effect, but the decision needs an ADR before Multi-Branch work starts | P3 — **V3** |
| `GCP-01` — this declaration drifted behind two Rank-4 documents | **CLOSED 2026-08-04 by correction.** §3.2 claimed BC Map v1.3 / Matrix v1.1 while the files read v1.4 / v1.2. Cause: both documents self-recorded a version bump without the §7 step 3 update here. **Prevention:** §7 step 3 already requires it — the rule was not weakened, it was not followed. A mechanical check comparing §3's versions against each file's header is recommended as a future gate | P2 — recurrence risk |
| `GCP-03` — this declaration contained a **broken changelog table** | **CLOSED 2026-08-04 by correction.** §8's `BASELINE-2026-08-04-B` and `BASELINE-2026-08-04` rows were joined into a single physical line by a literal `\n` (two characters, not a newline) left by the scripted insertion that wrote the new row. The table rendered as one malformed row, hiding the previous baseline's entry. Also corrected: §3.1's self-reference row still read `BASELINE-2026-08-04` after this document had been re-issued as `-B`, so the declaration disagreed with its own header. **Both found by item 8 validation, not by review** | P3 — cosmetic, but it concealed a changelog row |
| **`GCP-05`** — **`SM-GAP-10`: is Date of Birth mandatory at `BC-10`?** | **OPEN.** A tension **internal to `PRD-003` (Rank 3, frozen)**: §2.2 lists Date of Birth in the **Optional** field set and `SID-2.5` mandates only *"the minimum information required for identity"*, while **`SID-5.9` states it *"**SHALL** be stored, because minor-safety obligations (`ID-6`) depend on it."*** Predates `PRD-004`, which **discloses** it as `SM-GAP-10` and resolves it in neither direction. `PRD-004` is deterministic under both — `SM-INV-3` requires a guardian when age < 18 **or when minor-status is `Unknown`**, so the DOB-absent case is closed safely (`SM-AC-31`, `SM-AC-32`). **Resolution requires the `BC-10` owner and a separate ADR** amending `PRD-003` §2.2 or `SID-5.9`. Recorded by `ADR-0018` §3.1; originally finding `RF-17` | P2 — no V1 behavioural effect; a documentation contradiction inside a frozen Rank 3 document |
| **`GCP-06`** — **`SM-GAP-11`: is `BC-26` a consumer of `SM-EV-1` / `SM-EV-5`?** | **OPEN.** A tension **internal to the Bounded Context Map (Rank 4, frozen)**: **§8 names `BC-26` a primary consumer of `enrollment.StudentEnrolled` and `enrollment.StudentProfileUpdated`, while §7 declares no `BC-01`→`BC-26` edge**, and line 292 states an edge absent from §7 *"does not exist"* and that adding one requires an ADR. Predates `PRD-004`, which **discloses** it in §7.4, **omits `BC-26` from its consumer list and asserts no edge**; `SM-7.9` publishes facts without enumerating subscribers, so behaviour is identical either way. **Resolution requires the architecture owner and a separate ADR** — adding the §7 edge (the `ADR-0016` precedent) or removing `BC-26` from the two §8 rows. Recorded by `ADR-0018` §3.2; findings `SR-04`/`SR-05` | P2 — no V1 behavioural effect; §8 and §7 of the same frozen document disagree |
| No `.github/` issue or pull-request templates | Contributors get no structured prompt to cite an ADR or a requirement id | P3 |

**Two gaps left this table on 2026-08-03**, and the distinction matters:

- *"Library PRD §§1–25 never supplied"* — **closed.** The specification exists. See §2.1.
- *"Invitation security specification never written"* — **closed.** The specification exists. See §2.1.

Nothing else moved. In particular `D-10` and `IMPL-020` are **code** gaps, and a document cannot close a code gap
however carefully it is written. They are restated here as tasks, not as findings awaiting a decision.

---

## 7. Changing the baseline

1. A change to any Rank 1–5 document requires an ADR **before** the change.
2. The changed document's version is incremented and its changelog updated in the same commit.
3. This declaration is updated in the same commit. A baseline that does not match the repository is worse than no
   baseline.
4. The baseline identifier changes only when a Rank 1–3 document changes version.

---

## 8. Changelog

| Baseline | Date | Change |
|---|---|---|
| **BASELINE-2026-08-04-C** | 2026-08-04 | **`PRD-004` Student Management admitted to the baseline — one ADR accepted, zero ranked documents amended, zero requirements changed.** Issued because a **Rank 3** document entered the baseline (§7 step 4): `Student_Management_PRD_v1.md` **v1.2**, together with `PRD-004_ALIGNMENT_REPORT.md` v1.1 as its validation record. Rank 2 extended to **`ADR-0018`**. **`ADR-0018`** admits `PRD-004` at Rank 3 as the authoritative specification for **`BC-01` Enrollment**, and delivers Master PRD §8 **module 3** (Library Member Directory) as its **chapter 5** — `LMD-1`…`LMD-31`, an application-layer **read composition** owning no aggregate and no invariant (`AR-1`), so **no `BC-32` was created and the context count remains 31**. **This is the narrowest of the four declarations: no ranked document was amended.** `MASTER_PRD.md`, the Bounded Context Map, the Module Dependency Matrix and `ARCHITECTURE_RULINGS.md` are **untouched**; **no integration edge was added**, no global business rule changed, no dependency law gained an exception, and no bounded context was created. **The version is preserved at v1.2** — freeze confers status, not a renumbering, following the `PRD-003`-at-v1.0 precedent; **no requirement identifier was added, removed, renumbered or reworded on admission** (251 base / 266 total identifiers, ten registers, ten `SM-EV-*` events closed by `SM-7.12`, 32 acceptance criteria, all unchanged). Admission followed **three independent reviews and two correction rounds**, the last an adversarial re-audit that attempted ten disproofs and failed on eight outright; six findings were **rejected with evidence** and the draft's intent preserved. **Two gaps are admitted OPEN and are not ratified by admission**: `SM-GAP-10` (`GCP-05`, DOB Optional vs `SID-5.9` — internal to `PRD-003`) and `SM-GAP-11` (`GCP-06`, BC Map §8 vs §7 over `BC-26`), each requiring a **separate ADR from its named owner**. `PRD-004` is **`FROZEN`, not `VERIFIED`** — implementation is entirely unstarted, 0 of 24 tasks and **0 of 32 acceptance criteria proven by a test**. |
| **BASELINE-2026-08-04-B** | 2026-08-04 | **Governance closure — five ADRs accepted, one Rank-3 and one Rank-4 document amended, zero requirements changed.** Issued because a **Rank 3** document changed version (§7 step 4): `Library_PRD_v1.md` v1.0 → **v1.1**. Rank 2 extended to `ADR-0017`. **`ADR-0013`** (capability contexts are platform-owned) amends the Library PRD's *Owning contexts* header row to separate the one context it owns (`BC-06`) from the three it consumes through ports (`BC-19`, `BC-25`, `BC-29`); the aggregates `TenantOrganisation`, `StaffAssignment` and `LibraryBranding` values remain owned there — **this is not a scope reduction.** **`ADR-0014`** (tenant-key and audit-mutation enforcement) raises the Dependency Matrix to **v1.3** and its enforcement coverage from *10 of 12* to **12 of 12** categories, making `X-10` and `X-13` mechanically checked and therefore *met* under `SID-4.56`. **`ADR-0015`** corrects three wrong finance context identifiers in the Library PRD (`BC-11`…`BC-13` → `BC-05` Fee & Collection and `BC-20` Subscription & Billing); the ownership boundary those rows assert was already correct, only the identifiers were wrong. **`ADR-0016`** adds `BC-10` to edge `E-22`'s consumer list in the BC Map (**v1.4**), an edge `SID-4.35` already depends on and which BC Map line 292 requires an ADR to add. **`ADR-0017`** resolves `BC-25` Configuration ownership: it is a named **V1 product module** (Master PRD §8 module 18) and receives a dedicated **`PRD-023`**, registered on the precedent `PRD_REGISTRY.md` §4.3 set for `PRD-022` — not invented to fill a gap. `PGA-01`, `PGA-02`, `PGA-06` and `PGA-11` closed; contested contexts **3 → 0**. **No requirement identifier was added, removed, renumbered or reworded in any PRD**, and no dependency law gained an exception. **Two pre-existing staleness defects in this declaration were also corrected**, and are recorded rather than quietly overwritten: §3.2 stated the Bounded Context Map at **v1.3** when the file was already at **v1.4**, and the Module Dependency Matrix at **v1.1** when the file was already at **v1.2**. Both drifted because v1.4 (BC Map, implementation-status row) and v1.2 (Matrix, fitness-function-executed row) were self-recorded in those documents without the §7 step 3 update to this declaration. Logged as **`GCP-01`** in §6. |
| **BASELINE-2026-08-04** | 2026-08-04 | **`BC-10` Global Person Identity admitted to the baseline, and the identity architecture finalised.** `Student_Identity_PRD_v1.md` v1.0 (Chapters 1–5) and `STUDENT_IDENTITY_ALIGNMENT.md` declared authoritative at Rank 3 — the **third** module baseline, alongside Authentication (`BC-18`) and Library Management. `ADR-0011` accepted — Rank 2 extended to `ADR-0011`. **`ADR-0011` amends the Bounded Context Map §4 Identity Triad**: `BC-10` renamed Global Person Identity, reclassified `[SUPPORTING]` → `[CORE]`, moved out of the Social cluster to **rank 7.5**, cardinality `0..1` opt-in → **`1:1` mandatory**. Linkage rules `ID-1`…`ID-6` and prohibition `X-05` preserved unamended; `ID-4`'s `PersonId` becomes non-nullable. BC Map raised to v1.3; Module Dependency Matrix to v1.1; Master PRD to v1.7. `tool/module_dependencies.yaml` gains `domain/person: 7.5`. Nine registers declared: `SXC-1`…`11`, `SID-BR-1`…`18`, `SPO-1`…`9`, `SEV-1`…`16`, `SID-INT-1`…`12`, `SID-INV-1`…`14`, `SCFG-1`…`11`, `SID-AC-1`…`26`. `Q-05` closed. **One global business rule was changed — `MP-GBR-02`** — the first such change since the baseline was established; it is recorded in Master PRD §36. Two review findings were rejected and the supplied draft's intent preserved. No requirement was withdrawn and no earlier decision reversed. |
| **BASELINE-2026-08-03** | 2026-08-03 | **Library Management admitted to the baseline.** `Library_PRD_v1.md` v1.0 (§§1–25), `14B-Public-Library-Preview.md` v1.0 and `INVITATION_SECURITY_SPECIFICATION.md` v1.0 declared authoritative at Rank 3 alongside §14A. `U-4` closed by receipt; `AR-4` invitation-security deferral closed by authorship; `CC-5`, `CC-6`, `CC-7` closed. `ADR-0009` and `ADR-0010` accepted — Rank 2 extended to `ADR-0010`. Architecture Rulings raised to v1.2; Master PRD to v1.6; Traceability Matrix to v1.1. Thirteen Library configurables `LCFG-1`…`LCFG-13`, ten invitation configurables `ICFG-1`…`ICFG-10` and seven invariants `INV-10`…`INV-16` added to the Configuration Guide. No requirement was withdrawn and no earlier decision reversed. |
| **BASELINE-2026-08-02** | 2026-08-02 | Initial declaration. Authentication PRD v2.0 declared official; `D-7` closed by authorship; EA raised to v2.1; `CFG-3`, `CFG-4`, `CFG-5`, `CFG-6`, `CFG-7`, `CFG-12` reset to standards-anchored defaults; `ADR-0001`…`ADR-0008` accepted; twelve stale documents corrected or archived. |
