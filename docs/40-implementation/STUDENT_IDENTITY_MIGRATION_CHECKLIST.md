# Student Identity Migration Checklist

| Field | Value |
|---|---|
| **Document** | Migration Checklist — verifiable completion record |
| **Version** | v1.0 |
| **Status** | **Complete** — every item verified against the running system |
| **Date** | 2026-08-04 |
| **Commit** | `a22fd7e` (code + `ADR-0012`) · documentation pack in the follow-on commit |
| **Authority** | [`ADR-0011`](../00-governance/adr/ADR-0011-global-person-identity.md) · [`ADR-0012`](../00-governance/adr/ADR-0012-scaffold-port-inversion-debt.md) |
| **Companions** | [Migration Report](./ARCHITECTURE_MIGRATION_REPORT.md) · [Migration Plan](./STUDENT_IDENTITY_MIGRATION_PLAN.md) · [Validation Report](./STUDENT_IDENTITY_VALIDATION_REPORT.md) |

---

## 1. How to read this checklist

Every item states **how it was verified**, not merely that it was done. A checklist whose items are
self-asserted is a to-do list with ticks on it.

| Marker | Meaning |
|---|---|
| ✅ | Done and verified by the stated mechanism |
| ⛔ | Deliberately **not** done, with the reason recorded — not an omission |
| N/A | Does not apply, with justification |

Verification mechanisms, ranked by strength:

| Mechanism | Strength |
|---|---|
| **Automated test** | Strongest — re-verified on every run |
| **Tool output** | Strong — reproducible on demand |
| **Compiler** | Strong — cannot be bypassed while the build is green |
| **Grep / inspection** | Weakest — a point-in-time observation |

---

## 2. Phase 1 — Audit (15 categories)

| # | Category | Outcome | Verification |
|---|---|---|---|
| 1 | Nullable `personId` | ✅ 2 findings → `MIG-02`, `MIG-03` | grep + compiler |
| 2 | Optional identity creation | ✅ 1 finding → `MIG-01` | inspection of `AuthService` |
| 3 | `GlobalStudentProfile` inside social | ✅ 1 finding → `MIG-04` | inspection of `domain/social` |
| 4 | Legacy services | ✅ **No findings** — recorded in Plan §4 | grep for superseded service names |
| 5 | Legacy repositories | ✅ 1 finding → `MIG-04` (repository moved with aggregate) | inspection |
| 6 | Nullable foreign keys | ✅ **No findings** beyond categories 1–2 | grep for `Id?` across `lib/` |
| 7 | Incorrect module ownership | ✅ 1 finding → `MIG-04` | manifest vs. filesystem |
| 8 | Old dependency graph | ✅ 1 finding → `MIG-09` | manifest read |
| 9 | Hidden coupling | ✅ **No findings** — recorded in Plan §4 | boundary checker, 10 categories |
| 10 | Hardcoded assumptions | ✅ **No findings** in identity paths — recorded in Plan §4 | grep |
| 11 | Seed data | ✅ 1 finding → `MIG-07` (4 of 5 accounts identity-less) | inspection + conformance test |
| 12 | Tests | ✅ 1 finding → `MIG-08` | inspection of fixtures |
| 13 | Migrations | N/A — **no `migrations/` directory; all stores in-memory** | `ls migrations` → absent |
| 14 | Configuration | ✅ **No findings** — recorded in Plan §4 | grep of `20-configuration` |
| 15 | Dependency injection | ✅ 2 findings → `MIG-01`, plus `MIG-13` cycle found in Phase 4 | inspection + checker |

**Categories with no findings are recorded explicitly** (Plan §4) rather than omitted. An audit that lists only
hits is indistinguishable from an audit that stopped early.

---

## 3. Phase 3 — the 14 required implementation items

### 3.1 Identity is mandatory

- ✅ **(1) Identity creation is mandatory and atomic.** `AuthService` mints through `PersonIdentityFactory`
  (rank 0) before returning an account. Synchronous method call ⇒ same unit of work (`SID-4.11`).
  *Verified:* conformance test `every seeded account has exactly one identity`.
- ✅ **(2) `Account.personId` nullable removed.** Now `required` and non-nullable.
  *Verified:* compiler — every construction site must supply it; `grep` confirms no `PersonId?` remains.
- ✅ **(3) `StudentRecord.personId` nullable removed.** Now `required` **and `final`**; the mutator
  `linkToPerson` is **deleted** (`SID-4.17`).
  *Verified:* compiler; `grep linkToPerson` → no matches.

### 3.2 Ownership moves out of Social

- ✅ **(4) `GlobalStudentProfile` removed from `domain/social`.** Social now holds only `SocialPresence`,
  keyed by `PersonId`, storing **no** identity fields (`SID-BR-11`, `SID-4.53`).
  *Verified:* falsifiable test — deleting all social data leaves every identity intact (`SID-4.31`).
- ✅ **(5) Placed inside the Identity bounded context.** New module `lib/domain/person/` at rank **7.5**,
  classification `[CORE]`, aggregate renamed `PersonIdentity`.
  *Verified:* boundary checker reports **0 findings** naming `domain/person`.

### 3.3 Structural updates

- ✅ **(6) Repositories updated.** `PersonIdentityRepository` moved with its aggregate and now enforces the
  `SID-INV-1` conflict guard; social's repository became `InMemorySocialPresenceRepository`.
  *Verified:* test — enrolling the same mobile number twice reuses **one** identity.
- ✅ **(7) Services updated.** `PersonIdentityService` implements the rank-0 port; `AuthService` rewired;
  `registerProvisionedAccount` added for walk-ins (`AUTH-4.23`…`AUTH-4.28`).
  *Verified:* test — a provisioned account **grants no session** until claimed.
- ✅ **(8) Aggregates updated.** `PersonIdentity` (with `anonymise()` for `ID-5`), `StudentRecord`,
  `SocialPresence`. `PersonIdentity` holds **no** `StudentRecordId` and **no** `TenantId` (`SID-4.19`, `ID-2`).
  *Verified:* boundary checker banned-symbol check; inspection.
- ✅ **(9) Dependency injection updated.** Container fields, construction ordering,
  `provisionIdentityForEnrollment`, plus the `ContainerSeeder` inversion that broke the `L1` cycle.
  *Verified:* checker reports **0** circular dependencies; test `the repository is currently free of import cycles`.

### 3.4 Tests, fixtures, data

- ✅ **(10) Tests updated.** All 43 pre-existing tests pass unmodified in intent; 14 identity conformance tests
  and 14 checker governance tests added. **71 total.**
  *Verified:* `flutter test` → all passed.
- ✅ **(11) Fixtures updated.** Fixtures use the **real** `PersonIdentityService`, not a stub — so a fixture
  cannot drift from production identity rules.
  *Verified:* inspection; the tests would fail if the service's invariants changed.
- ✅ **(12) Seed data updated.** **5 of 5** accounts mint an identity; the identity counter starts at `0`
  (was `4`, a number meaningful only under the old opt-in model).
  *Verified:* conformance test asserts the property against the **booted container** (`MP-GBR-02`).
- N/A **(13) Migrations.** No `migrations/` directory exists; every repository is in-memory. Recorded as N/A
  **with written justification** in Plan §4 rather than silently skipped.
- ✅ **(14) `module_dependencies.yaml` updated.** Now describes the approved architecture, and defect **`R-5`**
  is closed — `contracts.path` corrected from the never-existent `lib/contracts` to
  `packages/liboora_contracts/lib`.
  *Verified:* YAML parse; `domain/person: 7.5` parses as a float; checker consumes it on every run.

---

## 4. Phase 4 — `IMPL-014` boundary checker

### 4.1 The ten required enforcement categories

| # | Check | Law | Implemented | Currently reporting |
|---|---|---|---|---|
| 1 | Dependency ranks | `L2` | ✅ | 0 |
| 2 | Cross-context rules | `L3` | ✅ | 37 (9 blocking, 28 waived) |
| 3 | Forbidden dependencies | `L3` | ✅ | 0 |
| 4 | Circular dependencies | `L1` | ✅ | 0 *(1 found and fixed)* |
| 5 | Same-rank violations | `L2` | ✅ | 0 |
| 6 | Layer violations | `L4` | ✅ | 0 |
| 7 | Illegal imports | `L5` | ✅ | 0 |
| 8 | Ownership violations | — | ✅ | 0 |
| 9 | Boundary violations (banned symbols) | — | ✅ | 0 |
| 10 | Architecture policies (barrels, policy flags) | — | ✅ | 0 |

- ✅ **The checker fails CI on violation.** Exit 1 on blocking findings, exit 2 on a malformed manifest, exit 0
  only when nothing blocks. Wired as Matrix §10.4 gate 3.
  *Verified:* observed exit code 1 on the current tree; exit 2 reproduced by mutation.

### 4.2 The exception mechanism is auditable, not a mute button

Each property was verified by **mutating the real manifest and running the real tool**, restoring it in
`finally`. The manifest was confirmed byte-identical afterwards.

- ✅ **Debt is time-boxed.** Expiring every date moved findings from waived back to blocking (9 → 14 on one wave).
- ✅ **A missing date counts as expired.** Absent or unparseable ⇒ expired, never "permanent".
- ✅ **An exception cannot be anonymous.** Deleting an `adr` field ⇒ **exit 2**, naming the offending field.
- ✅ **An exception cannot be fictional.** Naming an unknown module ⇒ exit 2. Every committed exception cites an
  ADR file that **exists on disk** — asserted by test.
- ✅ **`L1` is structurally unwaivable.** A syntactically valid waiver plus a reintroduced cycle leaves the cycle
  **blocking and absent from `ACKNOWLEDGED DEBT`** (Matrix §11 step 3: *never* approved).
- ✅ **Nothing is committed already expired.** Asserted by test.
- ✅ **Debt is visible on every run.** `□ ACKNOWLEDGED DEBT — 28 finding(s) across 12 edge(s)`, grouped by edge
  with ADR, expiry and reason.

### 4.3 The checker's own correctness

- ✅ **14 governance tests** in `test/architecture/boundary_checker_test.dart`, asserting **properties, not
  counts**. A count-based assertion would need editing whenever debt is paid down, and a test that is routinely
  edited is a test that has stopped being read.
- ✅ **`SID-4.56` applied recursively.** An unverified checker is an unmet rule wearing a green tick.
- ✅ **`yaml: 3.1.3`** declared in `dev_dependencies` (closes `MIG-18`) — dev-only, pinned for reproducibility.

---

## 5. Deliberate non-completions

These are decisions, not gaps. Each is recorded in at least three places so it cannot be mistaken for oversight.

| Item | Status | Reason | Recorded in |
|---|---|---|---|
| 9 × `app → domain/library` findings | ⛔ **Left blocking** | Already tracked by `TASK-D10`, a **P0 release blocker**. Waiving would convert a tracked blocker into untracked debt with a 2027 expiry | `ADR-0012` §3.4 · Plan `MIG-15` · Checker Design §6 |
| 13 port extractions | ⛔ Deferred, dated | Unrelated to Student Identity; bundling them would destroy reviewability. Four waves, first expiry **2026-10-31** | `ADR-0012` §4 |
| Tenant-key check (`X-13`) | ⛔ Not implemented | Matrix §10.2 lists it; it is not built. **Must not be presumed enforced — by `SID-4.56` it remains unmet.** Currently covered by tenant-isolation tests only | Checker Design §7 |
| Audit-mutation check (`X-10`) | ⛔ Not implemented | As above | Checker Design §7 |
| Event payload `personId` | ⛔ No change, by rule | Would enable a cross-tenant join answering "which libraries?" — forbidden by `SID-4.19` | Plan `MIG-17` |
| Re-keying Membership/Attendance/Seating/Finance | ⛔ No change, by rule | `SID-4.23` forbids it | Report §6 |

---

## 6. Scope discipline

- ✅ **No PRD was edited.** `Student_Identity_PRD_v1.md`, `MASTER_PRD.md`, `Authentication_PRD_v2.md`,
  `Library_PRD_v1.md` are byte-unchanged.
  *Verified:* `git diff --stat a22fd7e^ a22fd7e -- docs/30-product/` → empty.
- ✅ **No approved architectural decision was revisited.** `ADR-0011` is untouched; `ADR-0012` *adds* a dated
  debt record without amending any prior decision.
- ✅ **No law was given a new exception.** The rank-4 → rank-7.5 problem was solved by the documented
  synchronous-port pattern (PRD §4.3, edge `E-12`), not by a waiver.
- ✅ **No TODOs, no placeholders.** *Verified:* `grep -rn "TODO\|FIXME\|XXX" lib/ tool/ test/` → no matches.

---

## 7. Final gate status

| Gate (Matrix §10.4 order) | Result |
|---|---|
| 1 · `dart format` | ✅ Clean — **after correction.** The first run of this gate **failed**: 8 files were unformatted (2 pre-existing at baseline, 6 introduced by the migration). Formatting was applied, which then exposed a `curly_braces_in_flow_control_structures` lint that the previously over-long line had masked. Both fixed; gate re-verified |
| 2 · `flutter analyze` | ✅ **No issues found!** |
| 3 · `dart run tool/check_module_boundaries.dart` ◄ blocks merge | ⛔ **Exit 1 — intentional** (9 blocking per `ADR-0012` §3.4; 28 waived) |
| 4 · `flutter test test/architecture/` ◄ blocks merge | ✅ 14/14 |
| 5 · `flutter test` | ✅ **71/71** |
| 6 · `flutter build web --release` | ✅ Builds |

**Gate 3 is red by design.** It names a P0 (`TASK-D10`) that must be closed before release. A red gate that
names a blocker is worth more than a green gate that hides one.

---

## 8. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-04 | Created. Records verification mechanism per item across Phases 1, 3 and 4, the six deliberate non-completions, and the intentionally red gate 3. |
