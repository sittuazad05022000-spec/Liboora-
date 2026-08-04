# Validation Report — Student Identity Migration

| Field | Value |
|---|---|
| **Document** | Validation Report |
| **Version** | v1.0 |
| **Status** | **Complete** — all eight required validations executed |
| **Date** | 2026-08-04 |
| **Subject** | The `ADR-0011` code migration and the `IMPL-014` boundary checker |
| **Verdict** | **PASS with one intentional red gate.** Nothing unexplained; nothing waived to obtain a green result |
| **Companions** | [Migration Report](./ARCHITECTURE_MIGRATION_REPORT.md) · [Migration Checklist](./STUDENT_IDENTITY_MIGRATION_CHECKLIST.md) · [Risk Report](./STUDENT_IDENTITY_RISK_REPORT.md) |

---

## 1. Required validations

Eight validations were required. All eight ran. Two produced **real findings**, which were fixed rather than
reclassified.

| # | Validation | Result | Findings |
|---|---|---|---|
| 1 | `flutter analyze` | ✅ **PASS** | 1 found → **fixed** |
| 2 | `flutter test` | ✅ **PASS** | 71/71 |
| 3 | Architecture validation | ⛔ **Exit 1 — intentional** | 9 blocking, 28 waived |
| 4 | Dependency validation | ✅ **PASS** | 0 rank/layer/illegal-import violations |
| 5 | Traceability validation | ✅ **PASS** | 10 stale statements → **corrected** |
| 6 | Boundary validation | ✅ **PASS** | 0 ownership/banned-symbol violations |
| 7 | Cross-reference validation | ✅ **PASS** | 1 mis-citation → **fixed** |
| 8 | Link validation | ✅ **PASS** | 267 links, 0 broken |

---

## 2. `flutter analyze`

```
Analyzing flutter_app...
No issues found! (ran in 2.5s)
```

**This gate did not pass on the first attempt, and the sequence is worth recording** because it shows a gate
catching something a human review had not.

`dart format --output=none --set-exit-if-changed .` initially **failed**, reporting 8 unformatted files. A
baseline probe (`git checkout 9f15750`) showed **2** were pre-existing and **6** were introduced by the
migration — so this was mostly my own untidiness, not inherited.

Applying `dart format .` then produced a **new** analyzer issue:

```
info • Statements in an if should be enclosed in a block
      • tool/check_module_boundaries.dart:786:9
      • curly_braces_in_flow_control_structures
```

The lint had been **masked by an over-long single line**; reformatting split the line and exposed it. Fixed by
using an explicit block with an explanatory comment. Gate 1 and gate 2 then both pass, and the checker's
behaviour is unchanged (identical output before and after).

> **Observation.** Gate 1 exists to make diffs readable, but here it *uncovered a latent lint*. Ordering
> `dart format` before `flutter analyze` (Matrix §10.4) is therefore not cosmetic sequencing — the earlier gate
> feeds the later one.

---

## 3. `flutter test`

```
71 tests, All tests passed!
```

| Suite | Count | Purpose |
|---|---|---|
| `widget_test.dart` | 43 | Pre-existing behaviour — boot, tenant isolation, domain invariants, projections |
| `student_identity_conformance_test.dart` | 14 | `ADR-0011` conformance |
| `architecture/boundary_checker_test.dart` | 14 | The checker's own governance properties |

**The 43 pre-existing tests were not weakened to accommodate the migration.** Their assertions are unchanged;
only 11 `boot()` call sites gained an explicit `seeder:` argument, which *strengthens* them — see §3.2.

### 3.1 The conformance tests that matter most

| Test | Proves |
|---|---|
| `every seeded account has exactly one identity` | `MP-GBR-02` against the **booted container**, not a mock |
| `enrolling the same number twice reuses one identity` | `SID-INV-1` — one person, one identity, across libraries |
| `a provisioned account grants no session until claimed` | Walk-in enrollment cannot become a backdoor (`MP-GBR-25`) |
| Social-absence test | `SID-4.31` — deleting all social data leaves every identity intact |

### 3.2 A false-green risk that validation caught

Breaking the `L1` cycle made seeding an **optional** parameter of `boot()`. Eleven test call sites had relied on
implicit seeding. Had they been left alone, they would have booted an **empty container and still passed** —
reporting success while asserting nothing.

All 11 were updated explicitly. This is recorded because it is the failure mode a green suite *hides*: the tests
would not have gone red to tell anyone.

---

## 4. Architecture validation — the intentional red gate

```
LIBOORA architecture boundary check (IMPL-014)
Manifest version 1 · 22 modules
FAIL — 9 violation(s) in 1 category(ies).

■ cross-context (9)
  default_decision: deny   lib/app/dashboards/money_page.dart:13
  … 8 more, all "app" importing "domain/library"

□ ACKNOWLEDGED DEBT — 28 finding(s) across 12 edge(s), each covered by a dated ADR (§11).
```

Exit code **1**.

### 4.1 Why this is a pass, not a failure

| Question | Answer |
|---|---|
| Are the 9 findings real? | **Yes.** Each names a file and line; each is a genuine barrel import across a context boundary |
| Were they caused by this migration? | **No.** Proven by `git stash` + re-run against pristine `9f15750`: the same 37 cross-context findings appeared, **plus** a cycle. The migration *reduced* the total from 38 to 37 |
| Why not waive them? | They are already tracked by **`TASK-D10`**, a **P0 release blocker**. Waiving would convert a tracked blocker into untracked debt expiring in 2027 |
| Is that decision discoverable? | **Yes** — `ADR-0012` §3.4, Plan `MIG-15`, Checker Design §6, and a **test** that fails if the edge is ever waived |

### 4.2 Distribution across the ten categories

| Category | Law | Count |
|---|---|---|
| circular-dependency | `L1` | **0** *(1 found, fixed in code — never waivable)* |
| cross-context | `L3` | 37 → 9 blocking + 28 waived |
| rank · same-rank | `L2` | **0** |
| layer | `L4` | **0** |
| illegal-import | `L5` | **0** |
| forbidden · ownership · boundary · policy | — | **0** |

Zero rank and zero layer violations is the substantive result: the scaffold always had dependency **direction**
correct. What it lacked was **inversion** — concrete cross-context imports where Matrix §4 requires a port
(`◇` mode: *"Compile-time import allowed? **No**"*).

### 4.3 The rank-7.5 context is clean

```
$ dart run tool/check_module_boundaries.dart | grep -c person
0
```

**Zero findings name `domain/person`.** The module `ADR-0011` created — and the rank-4 → rank-7.5 synchronous
port that makes `SID-4.11` possible — is verified mechanically rather than reviewed. This is the single most
important line in this report.

---

## 5. Dependency validation

| Property | Result |
|---|---|
| Manifest parses | ✅ `yaml.safe_load` OK; 22 modules |
| `domain/person: 7.5` | ✅ Parses as a **float**, ordering correctly between 7 and 8 |
| `contracts.path` | ✅ `packages/liboora_contracts/lib` — **defect `R-5` closed** |
| `L2` downward-only | ✅ 0 violations |
| `L4` capability ≠ domain | ✅ 0 violations |
| `L5` contracts import nothing | ✅ 0 violations, **and now meaningfully checked** |
| `L1` acyclic | ✅ 0 cycles; asserted by test |
| Exceptions well-formed | ✅ 12 exceptions × 6 fields; every `adr` file exists on disk |
| Exceptions not pre-expired | ✅ Asserted by test |

> **`R-5` was the highest-value finding of the whole exercise.** `contracts.path` had pointed at `lib/contracts`
> — a directory that has **never existed**. Had the checker shipped without this fix, law `L5` would have been
> certified green against an empty directory: a passing check that checked nothing. It was found only by treating
> the manifest as an **executable input** rather than as prose, which is precisely what prose review cannot do.

---

## 6. Traceability validation

Every `IMPL-*` item claimed by this migration was traced to its artefact, and the reverse direction was checked
too — which is where the findings were.

| Item | Claim | Verified |
|---|---|---|
| `IMPL-207` | `GlobalStudentProfile` out of `domain/social` | ✅ `lib/domain/person/person.dart`; 0 checker findings |
| `IMPL-208` | `personId` non-nullable | ✅ Compiler; `grep` finds no `PersonId?` |
| `IMPL-014` | Boundary checker exists and runs | ✅ 1 054 lines; exit 1 observed; 14 tests |
| `R-5` | `contracts.path` corrected | ✅ Manifest |
| `MIG-01`…`MIG-18` | 18 issues resolved or closed with reason | ✅ Plan §6 outcome table |

### 6.1 Finding — 10 stale statements

Traceability validation is normally a formality. Here it found that **10 statements across 7 documents** still
asserted that `IMPL-014` *"does not exist"* and that boundaries were *"unenforced"*. True at `9f15750`; **false**
now.

| Document | Occurrences |
|---|---|
| `IMPLEMENTATION_ROADMAP.md` | 3 |
| `TRACEABILITY_MATRIX.md` | 2 |
| `DEVELOPER_HANDOFF.md` | 2 |
| `10-architecture/README.md` | 2 |
| `LIBRARY_IMPLEMENTATION_TASKS.md` | 2 |
| `STUDENT_IDENTITY_IMPLEMENTATION_TASKS.md` | 1 |
| `DEFINITION_OF_DONE.md` | 1 |

These are **corrected in Phase 6** of this migration. The consequence of leaving them would be a reader
concluding the gate is optional, or re-implementing a tool that already exists.

> This finding is itself an argument for mechanical validation: **no amount of careful reading found these; a
> `grep` found all ten in under a second.**

---

## 7. Boundary validation

| Rule | Result |
|---|---|
| `PersonIdentity` holds no `StudentRecordId` | ✅ Banned-symbol check + inspection (`SID-4.19`, `ID-2`) |
| `PersonIdentity` holds no `TenantId` | ✅ Banned-symbol check — identity is global, not per-tenant |
| Identity cannot answer "which libraries?" | ✅ No reverse reference exists; direction is upward only |
| Social stores no copies of identity fields | ✅ `SID-BR-11`, `SID-4.53`; falsifiable test |
| Membership/Attendance/Seating/Finance not re-keyed | ✅ `SID-4.23`; still keyed on `StudentRecordId` |
| Event payloads carry no `personId` | ✅ `MIG-17` closed as no-change (`SID-4.19`) |
| `TenantContext` in rank 0 | ✅ Already correct per Matrix §8.3 — verified, not assumed |

### 7.1 Two specified checks are **not** implemented

Matrix §10.2 lists nine checks. The **tenant-key** (`X-13`) and **audit-mutation** (`X-10`) checks are **not
built**. Recorded in Checker Design §7 with the exact wording that they *"must not be presumed enforced — by
`SID-4.56` they remain unmet."*

Stating this in a validation report matters: ten green categories otherwise imply complete coverage. They do not.
Tracked as `RSK-03`.

---

## 8. Cross-reference validation

Every governance identifier cited by the three new documents was resolved against the rest of the documentation
set. **30 distinct identifiers checked.**

| Finding | Resolution |
|---|---|
| **`E-11` mis-cited** as "the claim flow" in `MIG-06` | **Real error, fixed.** The Bounded Context Map §7.2 defines `E-11` as *"`AccountId` resolution on login"*. The account-claim flow is `AUTH-4.23`…`AUTH-4.28` (Auth PRD v2 §4). Citation corrected |
| `lib/contracts` unresolved | **Correct as written.** It is cited *because* it never existed — defect `R-5`. Not an error |
| `ADR-0012` unresolved outside its own file | **Real gap** — `ADR-INDEX.md` did not list it. Closed in Phase 6 |

> The `E-11` finding is the reason this validation was worth running. A plausible-looking citation that names the
> wrong edge is exactly what a reader would later trust and be misled by.

---

## 9. Link validation

```
relative links checked: 267
broken: 0
```

All 80 markdown files under `docs/` scanned for relative markdown links; every target resolved on disk.

---

## 10. Scope discipline

| Constraint | Verification |
|---|---|
| *"Do NOT modify business requirements"* | ✅ `git diff --stat a22fd7e^ a22fd7e -- docs/30-product/` → **empty** |
| *"Do NOT rewrite PRDs"* · *"Keep PRDs frozen"* | ✅ All PRDs byte-unchanged |
| *"DO NOT redesign"* the approved architecture | ✅ `ADR-0011` untouched; `ADR-0012` adds debt tracking without amending any prior decision |
| *"No TODOs. No placeholders."* | ✅ `grep -rn "TODO\|FIXME\|XXX"` over `lib/ tool/ test/ packages/` → no matches |
| *"No architectural regressions"* | ✅ Baseline 38 violations → 37, cycle eliminated, `domain/person` clean |
| *"No duplicated logic"* | ✅ Identity creation exists in exactly one place (`PersonIdentityService`); fixtures use the real service, not a copy |

---

## 11. Verdict

**PASS**, with the architecture gate red by design.

| Dimension | Status |
|---|---|
| Correctness of the migrated identity model | ✅ Guarded by compiler + 14 conformance tests |
| Conformance to the approved architecture | ✅ 0 findings against `domain/person` |
| Enforcement capability (`IMPL-014`) | ✅ Exists, runs, blocks, and is itself tested |
| Documentation integrity | ✅ 267 links, all identifiers resolve |
| Outstanding blocking findings | ⛔ **9**, all `TASK-D10`, deliberately unwaived |
| Not-yet-enforced rules | ⛔ **2** (`X-13`, `X-10`), documented as unmet |

Two validations found real defects — a masked lint and a wrong edge citation — and one found ten stale
statements. **All were fixed rather than reclassified.** A validation report in which every check passes first
time is usually evidence that the checks were too weak, not that the work was flawless.

---

## 12. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-04 | Created. Records all eight required validations, the gate-1 formatting failure and the masked lint it exposed, the `E-11` mis-citation, the 10 stale `IMPL-014` statements, and the two Matrix §10.2 checks that remain unimplemented. |
