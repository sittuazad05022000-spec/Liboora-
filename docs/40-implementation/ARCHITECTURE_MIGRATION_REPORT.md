# Architecture Migration Report — Student Identity (`ADR-0011`)

| Field | Value |
|---|---|
| **Document** | Architecture Migration Report |
| **Version** | v1.0 |
| **Status** | **Complete** — migration executed, validated, and committed |
| **Date** | 2026-08-04 |
| **Baseline commit** | `9f15750` — *documentation approved, code unmigrated* |
| **Migration commit** | `a22fd7e` — 21 files changed, 2 757 insertions, 91 deletions |
| **Authority** | [`ADR-0011`](../00-governance/adr/ADR-0011-global-person-identity.md) (approved), [`ADR-0012`](../00-governance/adr/ADR-0012-scaffold-port-inversion-debt.md) (raised by this migration) |
| **Companion documents** | [Migration Plan](./STUDENT_IDENTITY_MIGRATION_PLAN.md) (issue register) · [Boundary Checker Design](../10-architecture/BOUNDARY_CHECKER_DESIGN.md) · [Migration Checklist](./STUDENT_IDENTITY_MIGRATION_CHECKLIST.md) · [Validation Report](./STUDENT_IDENTITY_VALIDATION_REPORT.md) · [Risk Report](./STUDENT_IDENTITY_RISK_REPORT.md) |
| **Scope boundary** | Implementation and governance only. **No PRD was edited.** No business requirement was changed |

---

## 1. What this document is

The [Migration Plan](./STUDENT_IDENTITY_MIGRATION_PLAN.md) is the *register*: eighteen issues, each with
ten structured fields. This report is the *narrative*. It answers the questions a register cannot:

- What was actually wrong, in one sentence?
- What was the hardest problem, and how was it solved without weakening the approved architecture?
- What did the migration **not** change, and why is that correct rather than incomplete?
- What is the honest end state, including the part that is still red?

Read the register to audit an individual issue. Read this report to understand the migration.

---

## 2. The one-sentence problem

> The documentation described a mandatory, platform-owned global person identity at dependency rank 7.5.
> The code implemented an optional, social-owned profile at rank 8 — and **nothing checked the difference.**

Every one of the eighteen issues is a consequence of that sentence. The third clause matters most: the
divergence was not a known, tracked deviation. It was invisible, because the fitness function that would
have caught it (`IMPL-014`) had been specified in the Dependency Matrix §10.2 and never written.

---

## 3. The state we started from

The scaffold encoded a **coherent but superseded** model. This is worth stating plainly, because it changes
how the migration should be judged: the old code was not sloppy, it was *obsolete*. It faithfully implemented
the pre-`ADR-0011` design in which a global profile was an opt-in social feature.

| Dimension | Pre-migration code | Approved architecture | Issue |
|---|---|---|---|
| Identity creation | Optional, on social opt-in | **Mandatory**, same transaction as the account | `MIG-01` |
| `Account.personId` | Nullable | **Non-nullable, required** | `MIG-02` |
| `StudentRecord.personId` | Nullable **and mutable** (`linkToPerson`) | **Non-nullable, final** | `MIG-03` |
| Owning module | `domain/social` (rank 8) | `domain/person` (rank **7.5**) | `MIG-04` |
| Aggregate name | `GlobalStudentProfile` | `PersonIdentity` | `MIG-04` |
| Classification | `[SUPPORTING]` | **`[CORE]`** | `MIG-04` |
| Seeded accounts with identity | **1 of 5** | **5 of 5** | `MIG-07` |
| Walk-in enrollment | No identity at all | Identity provisioned | `MIG-06` |
| Boundary enforcement | **None** | Ten checks, CI-blocking | `MIG-11` |

Two further facts framed the work:

1. **The manifest lied by omission.** `tool/module_dependencies.yaml` declared `domain/person: 7.5` with banned
   symbols and banned imports. Nothing read it. Under `SID-4.56` — *"a rule that cannot be checked SHALL be
   treated as unmet"* — that declaration was worth precisely nothing, while *reading* as protection.
2. **The manifest also contained a latent defect.** `contracts.path` pointed at `lib/contracts`, a directory that
   has **never existed** in this repository (defect `R-5`). Had the checker been written without fixing this
   first, law `L5` — *contracts import nothing* — would have been certified green against an empty directory.
   That is the single highest-value finding of the audit, and it was found only because writing the checker
   forced someone to read the manifest as an executable input rather than as prose.

---

## 4. The central architectural problem, and its resolution

This deserves its own section because it is the only place where the approved architecture and the
Five Dependency Laws appeared, at first reading, to be in conflict.

### 4.1 The apparent contradiction

`SID-4.11` requires that the person identity be created **synchronously, in the same unit of work** as the
account. Therefore:

- `AuthService` lives in `platform/identity` at **rank 4**.
- `PersonIdentity` lives in `domain/person` at **rank 7.5**.
- Law `L2` permits dependencies **downward only** — strictly lower rank.

A rank-4 service cannot call rank-7.5 code. But `SID-4.11` says it must, atomically. A naïve engineer has three
tempting exits, and all three are wrong:

| Tempting exit | Why it is wrong |
|---|---|
| Move `AuthService` up | It is a platform capability; `L4` forbids a capability depending on a domain, and moving it inverts the whole platform |
| Move identity down | Contradicts `ADR-0011`, which places `BC-10` at rank 7.5 as a **`[CORE]` domain**. Redesigning an approved decision was explicitly forbidden |
| Make creation asynchronous | Contradicts `SID-4.11`. An event-driven identity is eventually consistent, so an account could exist without an identity — the exact defect being migrated away from |

### 4.2 The resolution was already written down

The answer was not invented. It is in the Student Identity PRD §4.3, which specifies edge `E-12` as
`| BC-18 → this module | Synchronous port, same unit of work | E-12 |`, and in the Bounded Context Map §7.2,
which records `E-12` as *"Sync port, **same transaction**"*.

A **synchronous port** resolves the rank conflict completely:

```
┌─ rank 0 ── packages/liboora_contracts ────────────────────────────┐
│  abstract interface class PersonIdentityFactory                   │  ◄── the declaration
└───────────────────────────────────────────────────────────────────┘
        ▲ implemented by                    ▲ depended on by
        │                                   │
┌─ rank 7.5 ── domain/person ──────┐  ┌─ rank 4 ── platform/identity ─┐
│  PersonIdentityService           │  │  AuthService                  │
│  PersonIdentity  (aggregate)     │  │  calls factory.mintFor(...)   │
└──────────────────────────────────┘  └───────────────────────────────┘
        ▲                                   ▲
        └──────── wired at rank 9 ──────────┘
                 lib/bootstrap/di.dart (composition root)
```

`AuthService` depends **downward** on rank 0, which `L2` permits. `PersonIdentityService` depends downward on
rank 0, which `L2` permits. The composition root, which sits above both, is the one place allowed to know both
concrete types. The call is an ordinary synchronous method call, so it runs in the caller's unit of work and
`SID-4.11` is satisfied literally rather than approximately.

**No law was bent. No law gained an exception. No approved decision was revisited.**

### 4.3 This claim is verified, not asserted

The important property of the resolution is that it is *checkable*, and it was checked. After the migration the
boundary checker reports **zero findings whose consumer or provider is `domain/person`**:

```
$ dart run tool/check_module_boundaries.dart | grep -c person
0
```

The rank-7.5 tier that `ADR-0011` created is the **only** part of this codebase with no boundary debt at all.
That is the correct outcome: it is the newest module, built after the rules existed, and it is the one module
whose compliance was mechanically proven rather than reviewed.

---

## 5. What the migration changed

Fourteen numbered items were required. All fourteen are complete. The register carries the per-issue detail;
this is the structural summary.

### 5.1 New files

| File | Lines | Purpose |
|---|---|---|
| `packages/liboora_contracts/lib/src/ports/person_identity_factory.dart` | 45 | The rank-0 declaration that resolves §4. **The keystone of the migration** |
| `lib/domain/person/person.dart` | 244 | The rank-7.5 bounded context: `PersonIdentity` aggregate, `PersonIdentityService`, repository, `anonymise()` for `ID-5` |
| `test/student_identity_conformance_test.dart` | 328 | 14 behavioural tests, including the `SID-4.31` falsifiable test |
| `tool/check_module_boundaries.dart` | 1 054 | `IMPL-014`. Ten checks, three exit codes, dated exception handling |
| `test/architecture/boundary_checker_test.dart` | 365 | 14 tests that verify the checker itself (`SID-4.56` applied recursively) |
| `docs/00-governance/adr/ADR-0012-…md` | — | Governs the pre-existing port-inversion debt the checker exposed |

### 5.2 Behavioural changes, stated as invariants now true

| Invariant | Mechanism |
|---|---|
| No account can exist without exactly one identity | `Account.personId` is `required` and non-nullable; `AuthService` mints through the rank-0 port before returning |
| No student record can exist without an identity | `StudentRecord.personId` is `required` and `final`; `linkToPerson` **deleted** |
| One person, one identity, across all libraries | `SID-INV-1` conflict guard in the repository; enrolling the same mobile number twice reuses one `PersonId` |
| A walk-in student gets an identity but no session | `provisionIdentityForEnrollment` creates a role-less, unverified account; `issueSession` refuses it until claimed (`AUTH-4.23`…`AUTH-4.28`) |
| Social cannot own or copy identity | `GlobalStudentProfile` deleted; `domain/social` now holds only `SocialPresence`, keyed by `PersonId`, storing **no** identity fields (`SID-BR-11`, `SID-4.53`) |
| Deleting social data cannot affect identity | Asserted by a falsifiable test (`SID-4.31`) |
| Identity cannot answer "which libraries?" | `PersonIdentity` holds no `StudentRecordId` and no `TenantId` (`SID-4.19`, `ID-2`) |
| Erasure anonymises the person, retains record history | `PersonIdentity.anonymise()` (`ID-5`) |

### 5.3 The seed-data change is the one users would see

Before: 5 accounts, **1** with an identity, and an identity counter that started at `4` — a number that made
sense only under the old opt-in model. After: **5 of 5** accounts mint an identity through the real
`PersonIdentityService`, counter starts at `0`.

This matters beyond tidiness. `MP-GBR-02` states that every account has exactly one global identity. Under the
old seed, the *booted application* was a live counter-example to its own governing business rule. A conformance
test now asserts the property against the booted container rather than against a mock.

---

## 6. What the migration deliberately did **not** change

A migration report that lists only changes invites the reader to assume everything else was overlooked. These
were considered and consciously left alone.

| Untouched | Why this is correct |
|---|---|
| **All PRDs** | Explicitly out of scope: *"Do NOT modify business requirements. Do NOT rewrite PRDs."* The documentation is the source of truth; the code moved to meet it |
| **Membership, Attendance, Seating, Finance keys** | `SID-4.23` forbids re-keying them on `PersonId`. They remain keyed on `StudentRecordId`. Re-keying would have looked like thoroughness and violated a normative rule |
| **Event payloads** (`MIG-17`, closed as no-change) | Adding `personId` to per-tenant events would let a consumer join across tenants and answer "which libraries does this person attend?" — forbidden by `SID-4.19`. **Closed as no-change with justification, not skipped** |
| **`TenantContext`** | Already correctly in rank 0 per Dependency Matrix §8.3. Verified rather than assumed |
| **Database migrations** (`MIG-13`) | Recorded **N/A with written justification**: there is no `migrations/` directory and no persistent store. All repositories are in-memory. A migration script would have been theatre |
| **The nine `app → domain/library` findings** | Deliberately **not** waived — see §8 |

---

## 7. The cycle: the one law that could not be waived

Running the checker for the first time exposed a **circular dependency**: `lib/bootstrap/di.dart` imported
`seed.dart`, which imported `di.dart`.

Law `L1` (acyclic) is described by the Dependency Matrix §2 as *"the one law with zero exceptions"*, and §11
step 3 records that `L1` is **never** approved for exception. So there was no governance route. The code had to
change.

The fix used Matrix §8.2 — **port inversion (callback)** — one of the four documented cycle-breaking patterns
(*"there is no fifth option"*):

```dart
// lib/bootstrap/di.dart — no longer imports seed.dart
static Future<AppContainer> boot({ContainerSeeder? seeder}) async { … }

/// What [AppContainer.boot] needs from a seeder, expressed without naming one.
typedef ContainerSeeder =
    Future<void> Function(AppContainer container, List<Account> accounts);
```

`main.dart` — the composition root, the one place allowed to know both — supplies `seedDemoData`.

Two points of diligence:

1. **The cycle pre-existed the migration.** Verified with `git show HEAD:lib/bootstrap/di.dart` against the
   baseline. This was a repair of existing damage, not damage control for new damage.
2. **Making the parameter optional created a false-green risk.** Eleven test call sites relied on implicit
   seeding. Left alone, they would have booted an **empty** container and still passed. All eleven were updated
   explicitly. This is the kind of failure that a green test suite hides rather than reveals, so it is recorded
   here rather than in a commit message.

`L1` now holds repository-wide, and a test asserts it (`the repository is currently free of import cycles`).

---

## 8. The honest end state: the pipeline is red, on purpose

The checker's first run produced **38 violations**. The distribution is itself a finding:

| Category | Count |
|---|---|
| circular-dependency (`L1`) | 1 |
| cross-context mode (`L3`) | 37 |
| rank (`L2`) · layer (`L4`) · illegal-import (`L5`) · ownership · forbidden · same-rank · barrel · policy | **0** |

Zero rank violations and zero layer violations mean the scaffold always had dependency *direction* right. What
it never did was the *inversion*: modules imported concrete classes across context boundaries where the
Dependency Matrix §4 requires a port (`◇` mode — *"Compile-time import allowed? **No**"*), and §12 permits
exactly **one** direct-import permission (`liboora_contracts`).

**These 37 findings pre-existed the migration.** Proven, not asserted: `git stash` restored pristine `9f15750`,
the checker was re-run, and the same 37 appeared, plus the cycle. The migration *reduced* the count.

### 8.1 Four options, and why three were rejected

| Option | Verdict |
|---|---|
| **A** — Weaken the checker to ignore barrel imports | **Rejected.** Makes the tool agree with the code. The user's instruction is the opposite: code conforms to documentation |
| **B** — Amend the manifest to `mode: import` on these edges | **Rejected.** Matrix §12 permits one direct-import permission. This is option A wearing a manifest |
| **C** — Extract all 13 ports immediately | **Rejected.** ~13 interfaces plus adapter relocation, unrelated to Student Identity, in the same commit as an identity migration. Reviewability collapses |
| **D** — Dated, ADR-backed exceptions per edge (Matrix §11) | **Accepted.** §11 exists for precisely this case. Twelve exceptions, each naming `ADR-0012`, each with a removal date, in four waves |

### 8.2 Nine findings were left failing deliberately

The `app → domain/library` edge (9 sites) is **absent** from the exception list. This is the most consequential
judgement in the migration, so the reasoning is recorded in full.

Those nine imports exist because `lib/app` renders demo dashboards. They are **already tracked** by
`TASK-D10 — remove demo surfaces`, a **P0 release blocker**. Waiving them would convert a tracked release
blocker into untracked debt with a 2027 expiry date — it would make the pipeline green by making a P0 quieter.

From `ADR-0012` §3.4:

> *"Waiving an edge that is already scheduled to disappear would convert a tracked release blocker into
> untracked debt."*

So the gate is red, and it reports:

```
FAIL — 9 violation(s) in 1 category(ies).
□ ACKNOWLEDGED DEBT — 28 finding(s) across 12 edge(s), each covered by a dated ADR (§11).
```

A red gate that names a P0 is worth more than a green gate that hides one. This is stated in three places —
`ADR-0012` §3.4, the Migration Plan `MIG-15`, and Boundary Checker Design §6 — so that no future reader mistakes
it for an unfinished job. `TASK-D10` closes it.

---

## 9. Verification summary

| Gate | Result |
|---|---|
| `flutter analyze` | **No issues found!** |
| `flutter test` | **71 tests, all passed** (43 pre-existing + 14 identity conformance + 14 checker governance) |
| `dart run tool/check_module_boundaries.dart` | **Exit 1** — 9 blocking (deliberate, `ADR-0012` §3.4), 28 waived under dated exceptions |
| Findings naming `domain/person` | **0** — the new rank-7.5 context is clean |
| Nullable `personId` remaining in the codebase | **0** |
| Documentation link validation | **267 relative links, 0 broken** |
| Cross-reference validation | All governance identifiers resolve |

Full evidence, including the mutation tests that prove the exception mechanism cannot be used as a mute button,
is in the [Validation Report](./STUDENT_IDENTITY_VALIDATION_REPORT.md).

---

## 10. What this migration proves about the governance model

Three observations worth carrying forward.

1. **An unenforced rule is not a weak rule; it is not a rule.** The manifest declared rank 7.5 with banned
   symbols for an entire release cycle. It was worth nothing until something read it — and worse than nothing,
   because it read as protection. `SID-4.56` is the most operationally important sentence in the specification
   set.

2. **Writing the checker was itself an audit.** Defect `R-5` (`contracts.path` → a directory that never existed)
   had survived review because prose review does not execute paths. It surfaced within minutes of treating the
   manifest as an executable input. Fitness functions find things reviews cannot.

3. **The escape hatch must be visible, dated, and self-expiring.** `ADR-0012`'s exceptions are printed on every
   run under `ACKNOWLEDGED DEBT`, each with its ADR and expiry. A missing `adr` field halts the checker with
   exit 2. An unparseable or absent date counts as **expired**. `L1` is structurally unwaivable. Each of these
   properties was verified by mutating the real manifest and observing the real tool — because, per §10.2 of
   this report's own reasoning, an unverified checker is *an unmet rule wearing a green tick*.

---

## 11. Traceability

| Requirement | Where satisfied |
|---|---|
| `SID-4.11` — synchronous, same unit of work | §4.2; `PersonIdentityFactory` at rank 0 |
| `SID-4.17` — `StudentRecord.personId` non-nullable | §5.2; `MIG-03` |
| `SID-4.19` — cannot answer "which libraries?" | §5.2, §6; `MIG-17` closed as no-change |
| `SID-4.23` — no re-keying of the four contexts | §6 |
| `SID-4.31` — falsifiable social-absence test | §5.2 |
| `SID-4.56` — an uncheckable rule is unmet | §8, §10; the whole of `IMPL-014` |
| `SID-INV-1` — one person, one identity | §5.2; repository conflict guard |
| `MP-GBR-02` — every account has one identity | §5.3; asserted against the booted container |
| `ID-5` — erasure anonymises, retains history | §5.2; `anonymise()` |
| `IMPL-207` / `IMPL-208` | §5.2; both **implemented** |
| `IMPL-014` | §8; **implemented and CI-wired** |
| `R-5` | §3; **closed** |

---

## 12. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-04 | Created. Records the migration of the scaffold from the pre-`ADR-0011` optional/social identity model to the approved mandatory/platform model at rank 7.5, the `L1` cycle repair, the first execution of `IMPL-014`, and the deliberate decision to leave nine `app → domain/library` findings blocking rather than waive a tracked P0. No PRD was edited. |
