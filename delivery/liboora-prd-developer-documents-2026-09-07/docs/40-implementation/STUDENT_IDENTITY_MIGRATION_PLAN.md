# LIBOORA — Student Identity Architecture Migration Plan

| Field | Value |
|---|---|
| **Document** | Student Identity Migration Plan (Phase 2 of the `ADR-0011` migration) |
| **Version** | v1.0 |
| **Status** | **Executed** — every issue below is closed in commit `a22fd7e` unless its row says otherwise |
| **Authority** | `ADR-0011` (approved, official) · `Student_Identity_PRD_v1.md` (frozen) · `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` v1.1 |
| **Audit basis** | Phase 1 audit of all 54 Dart source files + `tool/module_dependencies.yaml` + first execution of `IMPL-014` |
| **Baseline** | `9f15750` (pre-migration) → `a22fd7e` (post-migration) |
| **Last Updated** | 2026-08-04 |

---

## 1. Purpose and scope

This document records the **Phase 1 audit findings as numbered issues** and the migration
strategy applied to each, with the ten fields the migration brief requires: Issue ID, Severity,
Root Cause, Affected Modules, Migration Strategy, Risk, Rollback Plan, Testing Strategy,
Acceptance Criteria and Implementation Order.

**In scope:** implementation and governance only.
**Out of scope, explicitly:** business requirements, PRD content, product rules. The Student
Identity PRD, `ADR-0011` and the Master PRD were treated as frozen inputs and were not edited.
Where the code and the documentation disagreed, **the code was changed** — without exception.

### 1.1 What the audit covered

The Phase 1 audit enumerated the 15 categories named in the brief. Findings are recorded below
as `MIG-01`…`MIG-18`. Four categories produced **no** findings; those are recorded as such in
§4 rather than omitted, because an unreported category is indistinguishable from an unexamined
one.

---

## 2. Severity scale

| Severity | Meaning | Release posture |
|---|---|---|
| **S1 — Correctness** | The code contradicts an approved architectural invariant. A wrong result, a violated law, or a state the documentation says is impossible | Blocks the migration |
| **S2 — Structural** | Ownership, placement or boundary is wrong. No wrong result today, but the boundary that prevents one is absent | Blocks the migration |
| **S3 — Enforcement** | A rule exists in documentation and nothing checks it. `SID-4.56`: an unchecked rule is *unmet* | Blocks the migration |
| **S4 — Debt** | Known divergence, understood, dated, and tracked to an owner | Permitted with an ADR and expiry |

---

## 3. Issue register

### MIG-01 — Identity creation was optional

| Field | Detail |
|---|---|
| **Issue ID** | `MIG-01` |
| **Severity** | **S1 — Correctness** |
| **Root Cause** | `AuthService.verifyOtp` constructed an `Account` and never created a Person Identity. The model predated `ADR-0011`, when `BC-10` was an opt-in social profile. `SID-4.11` requires identity creation **synchronously, in the same unit of work**; `SID-INV-1` requires exactly one identity per account |
| **Affected Modules** | `platform/identity` (rank 4) · `domain/person` (rank 7.5) · `contracts` (rank 0) |
| **Migration Strategy** | Dependency inversion, as documented — **not invented**. PRD §4.3 already specified `BC-18 → this module \| Synchronous port, same unit of work \| E-12`. The interface `PersonIdentityFactory` was placed in `contracts` (rank 0); the implementation `PersonIdentityService` in `domain/person` (rank 7.5); the composition root binds them. This mirrors the existing `Clock` and `IdGenerator` ports exactly |
| **Risk** | A direct call from rank 4 to rank 7.5 would be **upward** (violates `L2`) and a capability importing a domain (violates `L4`). Mitigated by the inversion: no law gained an exception, and rank 7.5 remains literally true |
| **Rollback Plan** | Revert `a22fd7e`. The port is additive to `contracts`, so reverting removes it cleanly; no persisted data exists (in-memory stores only), so no data migration is stranded |
| **Testing Strategy** | Conformance test asserting one account yields exactly one identity; a repeated `createFor` yields no second identity; and — the falsifiable case — a `_ThrowingIdentityFactory` proving that when identity creation throws, **no account survives** (`SID-AC-1`) |
| **Acceptance Criteria** | No code path constructs an `Account` without a `PersonId`. Identity creation failure fails account creation. `SID-4.11`, `SID-INV-1`, `SID-AC-1` all hold |
| **Order** | **1** — everything else depends on identity existing |

### MIG-02 — `Account.personId` was nullable

| Field | Detail |
|---|---|
| **Issue ID** | `MIG-02` |
| **Severity** | **S1 — Correctness** |
| **Root Cause** | Declared `PersonId? personId`. Encoded the pre-`ADR-0011` cardinality of `0..1`. `MP-GBR-02` (amended) makes it mandatory and `1:1` |
| **Affected Modules** | `platform/identity` |
| **Migration Strategy** | `required this.personId` / `final PersonId personId`. The compiler then enumerates every construction site, so no call site can be missed by grep |
| **Risk** | Every `Account(...)` call site breaks at compile time. This is the *desired* risk profile: a missed site is a build failure, not a runtime null |
| **Rollback Plan** | Revert the field to nullable; call sites continue to compile because they now all pass a value |
| **Testing Strategy** | Compilation is the primary proof. Plus the seed integrity counter asserting zero identity-less accounts after boot |
| **Acceptance Criteria** | `flutter analyze` clean with a non-nullable field. No `personId!` or `?? ` fallback anywhere |
| **Order** | **2** |

### MIG-03 — `StudentRecord.personId` was nullable and mutable

| Field | Detail |
|---|---|
| **Issue ID** | `MIG-03` |
| **Severity** | **S1 — Correctness** |
| **Root Cause** | Declared `PersonId? personId` with a `linkToPerson(PersonId)` setter — a model in which a student record could exist first and acquire an identity later. `SID-4.17` states the field **SHALL** be non-nullable |
| **Affected Modules** | `domain/library/enrollment` (rank 8) |
| **Migration Strategy** | Non-nullable, `final`, `required`. `linkToPerson` **removed** — a mutable link is meaningless once the field is mandatory and final. `_assertInvariants` gained a `!personId.isValid` check, so an empty id is refused at construction rather than tolerated (`SID-4.56`) |
| **Risk** | `EnrollStudent.call` must now receive a `PersonId`, which propagates to the reception UI. Addressed by `MIG-06` |
| **Rollback Plan** | Restore nullability and the setter. No stored data to unwind |
| **Testing Strategy** | A valid `PersonId` is accepted; an empty one is **refused** rather than silently stored |
| **Acceptance Criteria** | `SID-4.17` holds structurally. No code path can produce a record without a valid identity |
| **Order** | **3** |

### MIG-04 — `GlobalStudentProfile` lived inside the Social cluster

| Field | Detail |
|---|---|
| **Issue ID** | `MIG-04` |
| **Severity** | **S2 — Structural** |
| **Root Cause** | `BC-10` sat in `domain/social` at rank 8. `ADR-0011` reclassified it `[CORE]` and moved it to rank 7.5, because a rank-8 library module could not reference a rank-8 social module across the `X-05` Separate Ways boundary |
| **Affected Modules** | `domain/social` (rank 8) · `domain/person` (rank 7.5, new) |
| **Migration Strategy** | Create `lib/domain/person/person.dart` holding `PersonIdentity`, `PersonIdentityStatus`, `PersonIdentityRepository`, `PersonIdentityService`, and the `E-13` ACL (`IdentityDirectory` + `IdentityCoreFields`). Delete `GlobalStudentProfile`, `GlobalProfileReader` and `InMemoryGlobalProfileRepository` from social |
| **Risk** | Social features that read profile fields break. Real, and desirable: it proves social was reading identity data it should not own |
| **Rollback Plan** | The new module is a new directory; deleting it and reverting `social.dart` restores the prior state exactly |
| **Testing Strategy** | `SID-4.31` — the falsifiable test. An identity is created and fully usable **with no social object present at all**. If social absence affected identity, this fails |
| **Acceptance Criteria** | `PersonIdentity` is owned by `domain/person`. `domain/social` declares `banned_imports: domain/person/**` and the checker's ownership rule verifies the placement mechanically |
| **Order** | **4** |

### MIG-05 — Social would have duplicated identity fields

| Field | Detail |
|---|---|
| **Issue ID** | `MIG-05` |
| **Severity** | **S2 — Structural** |
| **Root Cause** | The natural rewrite of `social.dart` keeps `displayName` and `headline` on the social object. `SID-BR-11` and `SID-4.53` forbid social storing **copies** of identity fields |
| **Affected Modules** | `domain/social` |
| **Migration Strategy** | `SocialPresence` holds **only** `personId` plus a `lifetimeStudyMinutes` projection. Names and headlines are resolved through the `E-13` ACL at read time, never stored |
| **Risk** | An extra resolution hop per render. Accepted: the alternative is two sources of truth for a person's name |
| **Rollback Plan** | Re-add the fields. Nothing depends on their absence except the test below |
| **Testing Strategy** | A test asserting `SocialPresence` exposes no identity field it could duplicate — it fails if someone re-adds one |
| **Acceptance Criteria** | `SID-BR-11` and `SID-4.53` hold, and are enforced by a test rather than by review |
| **Order** | **5** |

### MIG-06 — Walk-in enrollment had no identity to supply

| Field | Detail |
|---|---|
| **Issue ID** | `MIG-06` |
| **Severity** | **S1 — Correctness** |
| **Root Cause** | Reception enrolls students who have never signed in. After `MIG-03` the `PersonId` is mandatory, and `SID-INV-2` says an identity exists **iff** an account exists. There was no rule in the code for "a student who has an identity but has not authenticated" |
| **Affected Modules** | `app` (rank 9) · `platform/identity` (rank 4) · `domain/person` (rank 7.5) |
| **Migration Strategy** | Derived from **existing** rules, not invented: `MP-GBR-01` (every student has an Account) + `AUTH-4.23`…`AUTH-4.28` (the account-claim flow: a library may hold an unclaimed record, which the person later binds to a verified account) + `MP-GBR-25` (mobile possession is the sole factor, so reception cannot verify on the student's behalf). `provisionIdentityForEnrollment` creates a **role-less, unverified** account whose identity is minted alongside it. `AuthService.registerProvisionedAccount` accepts a fully-formed `Account`, returns `void`, and no-ops on a duplicate phone |
| **Risk** | A provisioned account could be mistaken for a verified one, or the registration method could become an enumeration oracle. Mitigated: it returns `void` and takes an `Account` rather than a phone number, so it cannot answer "is this number registered"; `_accountForPhone` stays private; and the account holds no role, so `issueSession` refuses it |
| **Rollback Plan** | Remove the method and revert `session.dart`. Reception enrollment then fails to compile, which correctly surfaces that `MIG-03` needs an answer |
| **Testing Strategy** | Enrolling the same number twice reuses **one** identity. A provisioned account **grants no session** until claimed |
| **Acceptance Criteria** | Walk-in enrollment succeeds; the resulting account cannot sign in until the holder proves possession of the number; no second identity is ever minted for the same person |
| **Order** | **6** |

### MIG-07 — Four of five seeded accounts had no identity

| Field | Detail |
|---|---|
| **Issue ID** | `MIG-07` |
| **Severity** | **S1 — Correctness** |
| **Root Cause** | The seeder set `personId` on one account only. The booted system therefore violated `MP-GBR-02` from the first frame |
| **Affected Modules** | `bootstrap/seed` |
| **Migration Strategy** | All five accounts mint identities through the **real** `PersonIdentityService`. The former `GlobalStudentProfile` write became identity *enrichment* plus a `SocialPresence` row. Both enrollment sites mint a `PersonId` first |
| **Risk** | Seeding through real services means a domain invariant breaks **boot**. That is the intended property — the seeder is a conformance test that runs on every launch |
| **Rollback Plan** | Revert `seed.dart` |
| **Testing Strategy** | The integrity counter that previously reported **4** identity-less accounts must report **0** |
| **Acceptance Criteria** | `MP-GBR-02` holds for the booted system, asserted by a test rather than by inspection |
| **Order** | **7** |

### MIG-08 — Test fixtures encoded the old model

| Field | Detail |
|---|---|
| **Issue ID** | `MIG-08` |
| **Severity** | **S2 — Structural** |
| **Root Cause** | `authentication_conformance_test.dart` built accounts with no `personId` and constructed `AuthService` with no identity factory |
| **Affected Modules** | `test/` |
| **Migration Strategy** | Fixtures use the **real** `PersonIdentityService`, not a fake. A fake would test a system that does not exist |
| **Risk** | Coupling auth tests to the identity service. Accepted deliberately: `SID-4.11` makes them one unit of work, so testing them separately would test a fiction |
| **Rollback Plan** | Revert the test file |
| **Testing Strategy** | All 43 pre-existing tests must still pass unmodified in intent |
| **Acceptance Criteria** | 43/43 original tests green with the new fixtures |
| **Order** | **8** |

### MIG-09 — The manifest did not describe the new architecture

| Field | Detail |
|---|---|
| **Issue ID** | `MIG-09` |
| **Severity** | **S3 — Enforcement** |
| **Root Cause** | `tool/module_dependencies.yaml` had no `domain/person` path, no `person_identity_factory` port on either side of the `BC-18 → BC-10` edge, and no `domain/person` entry in `app.ports` |
| **Affected Modules** | `tool/module_dependencies.yaml` |
| **Migration Strategy** | Add the path; declare `person_identity_factory` under `domain/person.provides_ports` and under `platform/identity.ports` — annotated as a **port, not an import**, so `banned_imports: ["domain/**"]` still holds; add `domain/person` to `app.ports` |
| **Risk** | A manifest that lags the code makes the checker enforce the wrong architecture |
| **Rollback Plan** | Revert the YAML |
| **Testing Strategy** | YAML parse validation; `domain/person: 7.5` must parse as a **float**, not a string |
| **Acceptance Criteria** | Manifest parses; the checker reports zero findings against `domain/person` |
| **Order** | **9** |

### MIG-10 — Manifest defect `R-5`: the kernel path never existed

| Field | Detail |
|---|---|
| **Issue ID** | `MIG-10` |
| **Severity** | **S3 — Enforcement** |
| **Root Cause** | `contracts.path` was `lib/contracts`. That directory has **never existed**; the shared kernel is the separate pure-Dart package `packages/liboora_contracts/` |
| **Affected Modules** | `tool/module_dependencies.yaml` |
| **Migration Strategy** | Correct the path to `packages/liboora_contracts/lib`, with a comment recording that `L5` is enforced by the package having an empty `dependencies:` rather than by a lint |
| **Risk** | **This was the highest-value finding of the audit.** Left uncorrected, the checker would have scanned **zero** kernel files and reported `L5` as satisfied — precisely the "unmet rule mistaken for a passing rule" failure `SID-4.56` warns about. A green tick would have been worse than no check |
| **Rollback Plan** | Revert the path (not advisable) |
| **Testing Strategy** | Confirm the checker scans kernel files: `L5` violations are detectable, and the kernel's banned-symbol rules apply |
| **Acceptance Criteria** | `R-5` closed. The checker demonstrably reads the real kernel |
| **Order** | **10** |

### MIG-11 — `IMPL-014` did not exist; no law was enforced

| Field | Detail |
|---|---|
| **Issue ID** | `MIG-11` |
| **Severity** | **S3 — Enforcement** |
| **Root Cause** | Matrix §10.2 specifies a boundary fitness function. It had never been written. Every dependency law was enforced by code review alone. Under `SID-4.56` all five laws were therefore **unmet**. `ADR-0011` raised the stakes: rank 7.5 is a half rank whose only purpose is keeping `L2` literally true, and a half rank nothing verifies is just a comment |
| **Affected Modules** | `tool/` (non-runtime) |
| **Migration Strategy** | Implement all ten categories from the brief. Exit `0` clean / `1` violations / `2` could-not-run, so a checker that cannot run is never mistaken for a clean build. Line-based import parsing was chosen deliberately over the analyzer package so the checker still runs when the project does not compile |
| **Risk** | A checker with false negatives is worse than none, because it manufactures confidence. Mitigated by `MIG-12`: 14 tests assert the checker's own governance properties |
| **Rollback Plan** | Delete the tool. Nothing at runtime depends on it |
| **Testing Strategy** | Run against pristine `HEAD` to establish a baseline; then verify by mutation that each safety property actually holds |
| **Acceptance Criteria** | Ten categories implemented; the tool runs; findings are actionable and name the rule they break |
| **Order** | **11** |

### MIG-12 — The checker's own correctness was unverified

| Field | Detail |
|---|---|
| **Issue ID** | `MIG-12` |
| **Severity** | **S3 — Enforcement** |
| **Root Cause** | `SID-4.56` applies recursively. The tool that enforces every other rule is the one piece of code whose correctness cannot be taken on trust; an unverified checker is an unmet rule wearing a green tick |
| **Affected Modules** | `test/architecture/` (new, per matrix §10.3) |
| **Migration Strategy** | 14 tests asserting **governance properties**, not finding counts. A count-based test would need editing whenever debt is paid, and a test that is routinely edited is a test that has stopped being read. Each test runs the **real** checker against a temporarily mutated manifest, restored in a `finally` block |
| **Risk** | Tests that mutate a repository file could corrupt it on failure. Mitigated by `finally`-block restoration, plus an explicit post-run diff confirming the manifest is byte-equivalent |
| **Rollback Plan** | Delete the test file |
| **Testing Strategy** | Self-referential by design: expiry, missing ADR, unparseable date, unknown module, and the `L1`-unwaivable guard are each proven by mutation |
| **Acceptance Criteria** | 14/14 green; manifest verified unchanged after the run |
| **Order** | **12** |

### MIG-13 — `L1` violation: `di.dart` ⇄ `seed.dart`

| Field | Detail |
|---|---|
| **Issue ID** | `MIG-13` |
| **Severity** | **S1 — Correctness** |
| **Root Cause** | `di.dart` imported `seed.dart` to call `seedDemoData`; `seed.dart` imports `di.dart` for `AppContainer`. A file-level cycle. **Pre-existed this migration** — verified present at `9f15750` |
| **Affected Modules** | `bootstrap/di` · `bootstrap/seed` · `main` · `test/` |
| **Migration Strategy** | `L1` is *"the one law with zero exceptions"* and §11 step 3 says it is **never** approved, so a waiver was not an option. Fixed in code with the documented §8.2 port inversion: `boot()` takes an optional `ContainerSeeder` typedef; `main.dart` — the composition root, which legitimately knows both files — supplies `seedDemoData`. The edge now runs one way: `seed → di` |
| **Risk** | Eleven `boot()` call sites in tests relied on implicit seeding and would silently boot an **empty** container — a false pass. Mitigated by making the parameter explicit at every site and re-running the full suite |
| **Rollback Plan** | Restore the import and the direct call. Not advisable: it reintroduces an `L1` violation |
| **Testing Strategy** | The checker reports no `circular-dependency`. A dedicated test asserts a cycle can never be waived even with a syntactically valid exception present |
| **Acceptance Criteria** | Zero cycles. `L1` clean without any exception entry |
| **Order** | **13** |

### MIG-14 — 37 cross-context mode violations (scaffold debt)

| Field | Detail |
|---|---|
| **Issue ID** | `MIG-14` |
| **Severity** | **S4 — Debt** (12 edges) + **S2 — Structural** (1 edge, unwaived) |
| **Root Cause** | The V1 scaffold injects **concrete platform classes** — `EventBus`, `AuditTrail`, `TenantPartitionedStore`, `PolicyDecisionPoint`, `EntitlementService` — where matrix §4 requires ports and §6/§12 permit exactly **one** direct import (`liboora_contracts`). Dependency *direction* was always correct; the *inversion* was never done. **Pre-existed this migration**: pristine `HEAD` produced the same 37 findings |
| **Affected Modules** | `app` · `domain/library` · `platform/analytics` · `platform/business` |
| **Migration Strategy** | Four options were weighed (see `ADR-0012` §3.2). Weakening the checker and rewriting the manifest to match the code were both rejected — each makes documentation follow implementation, inverting the instruction that documentation is the source of truth. Extracting 13 ports now was rejected as an unrelated refactor of ~13 interfaces across five modules inside a migration commit. **Chosen:** matrix §11 — 12 dated, ADR-backed exceptions with a four-wave removal plan |
| **Risk** | An exception that stops being visible stops being debt and becomes an assumption. Mitigated by three properties: waived findings are still **printed** under `ACKNOWLEDGED DEBT` on every run; a missing ADR or expiry is a **hard checker error** (exit 2); an absent or unparseable date is treated as **expired** |
| **Rollback Plan** | Delete the `exceptions:` block. The checker then fails on all 37, which is a true statement about the code and safe — only louder |
| **Testing Strategy** | Mutation-tested: expiring every date moved findings from waived to blocking (9 → 14 for one wave); removing an `adr` produced exit 2 |
| **Acceptance Criteria** | Zero **un-waived** violations except `app → domain/library` (see `MIG-15`). Every exception carries all six §11 fields and cites an ADR file that exists |
| **Order** | **14** |

### MIG-15 — `app → domain/library`: deliberately left failing

| Field | Detail |
|---|---|
| **Issue ID** | `MIG-15` |
| **Severity** | **S2 — Structural** |
| **Root Cause** | Nine sites import the library domain barrel from the UI. Four are demo surfaces already scheduled for deletion by `TASK-D10` (a P0 release blocker); the rest are dashboard reads that the existing `platform/analytics:read_model` port already exists to serve |
| **Affected Modules** | `app` |
| **Migration Strategy** | **No waiver.** Waiving an edge already scheduled for deletion converts a tracked P0 blocker into untracked debt with a distant expiry. The checker continues to fail, which is the correct signal: `TASK-D10` is not done |
| **Risk** | **Stated plainly:** `dart run tool/check_module_boundaries.dart` exits **1**. It is a required status check per §10.4, so the pipeline is red until `TASK-D10` lands. This is a true statement about the codebase and is preferable to a green pipeline bought with a waiver |
| **Rollback Plan** | Not applicable — nothing was changed. Adding a waiver later would require amending `ADR-0012` |
| **Testing Strategy** | A test asserts this edge is **absent** from the exceptions list, so no future edit can quietly waive it |
| **Acceptance Criteria** | The edge remains unwaived until `TASK-D10` deletes the demo surfaces |
| **Order** | **15 — remains open by design** |

### MIG-16 — `PersonId` documentation described the superseded model

| Field | Detail |
|---|---|
| **Issue ID** | `MIG-16` |
| **Severity** | **S2 — Structural** |
| **Root Cause** | The `PersonId` doc comment in `identifiers.dart` described a *"cross-library social persona"* that *"may legitimately not exist"* — the pre-`ADR-0011` model, in the shared kernel every module reads |
| **Affected Modules** | `contracts` |
| **Migration Strategy** | Rewrite to describe the permanent, always-present, `1:1` platform identity, citing `SID-INV-1`, `SID-INV-2`, `MP-GBR-02`, `SID-4.31`, `ID-4`, `SID-4.17` |
| **Risk** | Left stale, the most-read comment in the codebase would teach the model the migration just removed |
| **Rollback Plan** | Revert the comment |
| **Testing Strategy** | Review; no executable assertion is possible for prose |
| **Acceptance Criteria** | No comment in `contracts` describes identity as optional or social |
| **Order** | **16** |

### MIG-17 — Enrollment event payload

| Field | Detail |
|---|---|
| **Issue ID** | `MIG-17` |
| **Severity** | **S2 — Structural** (resolved as *no change*) |
| **Root Cause** | `EnrollStudent` now holds a `PersonId`, raising the question of whether `enrollment.StudentEnrolled` should carry it |
| **Affected Modules** | `domain/library/enrollment` |
| **Migration Strategy** | **Deliberately unchanged.** `SID-4.23` states Membership, Attendance, Seating and Finance **SHALL NOT** be re-keyed on `PersonId`. Adding it to a widely-consumed event invites exactly that re-keying. `SID-4.19` reinforces it: the identity module must not be *capable* of answering "which libraries does this person attend?", and broadcasting the link in a tenant-scoped event is how that capability leaks |
| **Risk** | A future consumer may want the field. It should then arrive through the `E-13` ACL, not through an event payload |
| **Rollback Plan** | Not applicable — no change made |
| **Testing Strategy** | The `E-13` ACL test asserts it exposes only core fields, never organisations |
| **Acceptance Criteria** | `SID-4.23` and `SID-4.19` hold; no consumer can key on `PersonId` from this event |
| **Order** | **17 — closed as no-change** |

### MIG-18 — `yaml` was not a declared dependency

| Field | Detail |
|---|---|
| **Issue ID** | `MIG-18` |
| **Severity** | **S3 — Enforcement** |
| **Root Cause** | `IMPL-014` imports `package:yaml`. It resolved from the pub cache but was absent from `pubspec.yaml`, so the tool would fail on a clean checkout — including in CI, where it is a required gate |
| **Affected Modules** | `pubspec.yaml` |
| **Migration Strategy** | Add `yaml: 3.1.3` under `dev_dependencies`, pinned exactly. A dev dependency only: no shipped code parses YAML, so the release bundle is unaffected |
| **Risk** | None material. `depend_on_referenced_packages: error` (§10.1) would have flagged this eventually; declaring it removes the latent CI failure |
| **Rollback Plan** | Remove the line; the checker then fails on a clean checkout |
| **Testing Strategy** | `flutter pub get` resolves; the checker runs |
| **Acceptance Criteria** | The gate is reproducible on a machine with an empty pub cache |
| **Order** | **0 — prerequisite to `MIG-11`** |

---

## 4. Audit categories with no findings

Recorded explicitly, because an unreported category is indistinguishable from an unexamined one.

| Category | Finding | Evidence |
|---|---|---|
| **Nullable foreign keys** (beyond `MIG-02`/`MIG-03`) | **None** | `MembershipId`, `SeatId`, `FeeLedgerId`, `AttendanceDayId` are all non-nullable and correctly tenant-scoped |
| **Hidden coupling in the library cluster** | **None** | All 11 files under `attendance/`, `fee/`, `membership/`, `policy/`, `seating/` verified free of `social`, `Person` and `Global` references. Correctly **not** re-keyed on `PersonId` per `SID-4.23` |
| **Hardcoded assumptions** | **None new** | The demo phone constant and seeded-account list are `TASK-D10` surfaces, already tracked as a P0 blocker and out of this migration's scope |
| **Schema migrations** | **Not applicable** | No `migrations/` directory exists and none is required: all stores are in-memory (`TenantPartitionedStore`, `InMemory*Repository`). There is no persisted schema to version, so Phase 3.13 has no artefact. Recorded as N/A with justification rather than silently skipped |
| **Configuration** | **None** | No configuration key referenced identity. `SCFG-1`…`SCFG-11` remain unimplemented and are correctly tracked as forward work in `STUDENT_IDENTITY_IMPLEMENTATION_TASKS.md`, not as migration defects |
| **Legacy services / repositories** | **Closed by `MIG-04`** | `GlobalProfileReader` and `InMemoryGlobalProfileRepository` were the only legacy identity services; both removed |

---

## 5. Implementation order as executed

```
 0. MIG-18  declare yaml            ← prerequisite for the checker
 1. MIG-01  identity mandatory      ← everything depends on identity existing
 2. MIG-02  Account.personId        ← compiler enumerates call sites
 3. MIG-03  StudentRecord.personId
 4. MIG-04  move BC-10 to rank 7.5
 5. MIG-05  SocialPresence
 6. MIG-06  walk-in provisioning    ← unblocks MIG-03's UI consequence
 7. MIG-07  seed data
 8. MIG-08  fixtures
 9. MIG-09  manifest describes new architecture
10. MIG-10  R-5 kernel path         ← without this the checker verifies nothing
11. MIG-11  IMPL-014
12. MIG-12  checker's own tests
13. MIG-13  L1 cycle                ← found only once the checker existed
14. MIG-14  ADR-0012 exceptions
15. MIG-15  app -> domain/library   ← remains open by design
16. MIG-16  PersonId documentation
17. MIG-17  event payload           ← closed as no-change
```

Two ordering constraints were non-negotiable. `MIG-10` had to precede `MIG-11`, or the checker
would have scanned zero kernel files and certified `L5` falsely. `MIG-11` had to precede
`MIG-13`, because the cycle was invisible until something looked for it.

---

## 6. Migration outcome

| Measure | Before (`9f15750`) | After (`a22fd7e`) |
|---|---|---|
| `flutter analyze` | clean | clean |
| Tests passing | 43 | **71** (43 + 14 identity + 14 checker) |
| Boundary checker | did not exist | 10 categories enforced |
| Total violations | 38 | 37 |
| — blocking | 38 | **9** (`MIG-15`, by design) |
| — dated ADR-backed debt | 0 | 28 |
| `L1` cycles | 1 | **0** |
| `L2` / `L4` / `L5` violations | unknown (unchecked) | **0** (verified) |
| Ownership / barrel / policy violations | unknown | **0** (verified) |
| Identity-less seeded accounts | 4 of 5 | **0 of 5** |
| Nullable `personId` fields | 2 | **0** |
| Violations attributable to this migration | — | **0** |

The last row is the one to check independently: running `IMPL-014` against a stashed pristine
tree reproduces the same 37 cross-context findings plus the cycle. `domain/person` — the bounded
context this migration created — appears in **no** finding.

---

## Changelog

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-04 | Phase 2 register created from the Phase 1 audit: `MIG-01`…`MIG-18` across 15 categories, six categories recorded as no-finding, executed in commit `a22fd7e`. `MIG-15` remains open by design; `MIG-17` closed as no-change; schema migrations recorded N/A with justification. |
