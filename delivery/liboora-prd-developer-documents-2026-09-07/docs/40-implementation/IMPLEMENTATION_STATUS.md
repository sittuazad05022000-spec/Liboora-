# Implementation Status

| Field | Value |
|---|---|
| **Document** | Implementation Status — what is built, what is enforced, what is not |
| **Version** | v1.2 |
| **Status** | Active — the single place to check before assuming a capability exists |
| **Date** | 2026-08-04 |
| **Commit** | `a22fd7e` + Phase 6 documentation pack |
| **Governing principle** | `SID-4.56` — *"A rule that cannot be checked SHALL be treated as unmet"* |

---

## 1. Why this document exists

Validation of this migration found **10 statements across 7 documents** asserting that the boundary checker
*"does not exist"* and that boundaries were *"unenforced"*. Every one of those statements was true when written
and false by the time it was read.

That is a predictable failure of distributing status across many documents: each is correct at the moment of
writing and none is updated together. **This document is the one place where implementation status is
authoritative.** Where another document disagrees, this one wins — and the other document is a defect.

---

## 2. Enforcement status — read this before trusting a rule

| Capability | Status | Evidence |
|---|---|---|
| **Module boundary checker (`IMPL-014`)** | ✅ **EXISTS AND RUNS** | `tool/check_module_boundaries.dart`, 1 054 lines |
| Checker wired as a merge gate | ✅ Matrix §10.4 gate 3 | Exit 1 on blocking findings |
| Checker verified against itself | ✅ 14 tests | `test/architecture/boundary_checker_test.dart` |
| Law `L1` acyclic | ✅ Enforced + **unwaivable** | 0 cycles; cycle exceptions structurally ignored |
| Law `L2` downward-only | ✅ Enforced | 0 violations |
| Law `L3` ports-only | ✅ Enforced | 37 findings — 9 blocking, 28 waived |
| Law `L4` capability ≠ domain | ✅ Enforced | 0 violations |
| Law `L5` contracts import nothing | ✅ Enforced **meaningfully** | 0 violations; `R-5` closed |
| Ownership / banned symbols | ✅ Enforced | 0 violations |
| **Tenant-key check (`X-13`)** | ✅ **IMPLEMENTED** — `ADR-0014` | `_checkTenantKey` (checker line 277), category 12; 3 tests |
| **Audit-mutation check (`X-10`)** | ✅ **IMPLEMENTED** — `ADR-0014` | `_checkAuditMutation` (checker line 276), category 11; 2 tests |
| **Enforcement coverage** | ✅ **12 of 12** Matrix §10.2 categories | Was 10 of 12; `ADR-0014` accepted 2026-08-04 |

> ⚠ **This table's own two rows above were stale, and were corrected on 2026-08-04.** They read *"⛔ NOT
> IMPLEMENTED — UNMET per `SID-4.56`"* while the checker had in fact implemented both categories. That is the exact
> failure this document was created to prevent, occurring in this document. §6 says *"if a command disagrees with
> this document, the command is right"* — the command disagreed, and the command was right.
>
> **The correction runs in the safe direction:** it moves two rules from *unmet* to *met* on the strength of code
> and passing tests, not the reverse. Verified by `flutter test test/architecture/`, group *"X-10 / X-13
> enforcement (categories 11 and 12)"*, six tests including *"the real repository has no X-10 or X-13 violation"*.

> **Superseded statements.** Any text claiming `tool/check_module_boundaries.dart` *"does not exist"*, or that
> boundaries are *"unenforced"*, was true at or before commit `9f15750` and is **superseded as of `a22fd7e`**.
> Affected: `IMPLEMENTATION_ROADMAP.md` (3), `TRACEABILITY_MATRIX.md` (2), `DEVELOPER_HANDOFF.md` (2),
> `10-architecture/README.md` (2), `LIBRARY_IMPLEMENTATION_TASKS.md` (2),
> `STUDENT_IDENTITY_IMPLEMENTATION_TASKS.md` (1), `DEFINITION_OF_DONE.md` (1).
>
> Those documents are **not** rewritten here, because several are frozen review artefacts whose historical
> accuracy has value. This notice is the correction of record.

---

## 3. Student Identity (`ADR-0011`) — implementation status

| Item | Status | Verified by |
|---|---|---|
| `IMPL-207` — `GlobalStudentProfile` out of `domain/social` | ✅ **IMPLEMENTED** | 0 checker findings for `domain/person` |
| `IMPL-208` — `personId` non-nullable | ✅ **IMPLEMENTED** | Compiler; no `PersonId?` remains |
| Identity created in the same transaction (`SID-4.11`) | ✅ **IMPLEMENTED** | Rank-0 synchronous port |
| One person, one identity (`SID-INV-1`) | ✅ **IMPLEMENTED** | Conformance test |
| Every account has an identity (`MP-GBR-02`) | ✅ **IMPLEMENTED** | Asserted against the **booted container** |
| Social stores no identity fields (`SID-BR-11`) | ✅ **IMPLEMENTED** | Falsifiable test (`SID-4.31`) |
| Identity cannot answer "which libraries?" (`SID-4.19`) | ✅ **IMPLEMENTED** | No reverse reference exists |
| Erasure anonymises, retains history (`ID-5`) | ✅ **IMPLEMENTED** | `PersonIdentity.anonymise()` |
| Walk-in provisioning (`AUTH-4.23`…`AUTH-4.28`) | ✅ **IMPLEMENTED** | Grants no session until claimed |
| `IMPL-220` — boundary enforcement of `SID-INT-1`…`SID-INT-12` | ⚠️ **UNBLOCKED, not done** | Its blocker (`IMPL-014`) now exists · tracked as `BLK-03` |

**`IMPL-220`'s status changed as a side effect of this migration.** It was previously *blocked* because
`IMPL-014` did not exist. It is now *available to implement*. Until it is, each `SID-INT-*` rule is
review-verified and therefore **unmet** (`SID-4.56`).

---

## 4. Quality gates — current results

| Gate (Matrix §10.4) | Result |
|---|---|
| 1 · `dart format` | ✅ Clean |
| 2 · `flutter analyze` | ✅ **No issues found!** |
| 3 · boundary checker ◄ blocks merge | ⛔ **Exit 1 — intentional** (9 blocking, 28 waived) |
| 4 · `flutter test test/architecture/` ◄ blocks merge | ✅ **20/20** |
| 5 · `flutter test` | ✅ **77/77** |
| 6 · `flutter build web --release` | ✅ Builds |

**Gate 3 is red by design**, not by neglect. The nine blocking findings are `app → domain/library` imports owned
by `TASK-D10`, a P0 release blocker. See [`ADR-0012`](../00-governance/adr/ADR-0012-scaffold-port-inversion-debt.md) §3.4.

---

## 5. Known-open items

| Item | Priority | Nature |
|---|---|---|
| `TASK-D10` — remove demo surfaces | **P0** | Release blocker; also turns gate 3 green |
| `IMPL-020` — SMS / DLT integration | **P0** | Release blocker |
| `ADR-0012` wave 1 (2 edges) | — | Expires **2026-10-31** |
| `ADR-0012` wave 2 (2 edges) | — | Expires **2026-12-31** |
| `ADR-0012` waves 3–4 (8 edges) | — | Expire **2027-03-31** |
| `IMPL-220` — `SID-INT-*` enforcement | P0 | Now unblocked; **`BLK-03`** |
| `GCP-02` — branch protection unavailable | — | GitHub **Free** plan + single-job workflow; **`BLK-04`** |
| `PRD-012a` not opened | — | Split authorized, not executed; **`BLK-05`** |
| GitHub backup | — | ✅ **Current** — `github/main` at `011db0c`, verified via the GitHub API (`RSK-07` closed). Blocked on a 401 at first attempt; authorization was restored |
| `R-4` · `U-3` · `Q-02` `branchId` ADR | P3 | Standing deferrals |

---

## 6. How to confirm any claim in this document

```bash
dart format --output=none --set-exit-if-changed .     # gate 1
flutter analyze                                       # gate 2
dart run tool/check_module_boundaries.dart            # gate 3 — expect exit 1
flutter test test/architecture/                       # gate 4
flutter test                                          # gate 5 — expect 77/77
```

To confirm the GitHub backup claim — note this deliberately does **not** trust `git push`'s own exit code:

```bash
git fetch github
git rev-list --count github/main..HEAD    # expect 0 — nothing unpushed
git rev-list --count HEAD..github/main    # expect 0 — nothing unmerged
```

If a command disagrees with this document, **the command is right**. Update this document in the same commit as
the change that made it stale.

---

## 7. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-04 | Created during Phase 6 after validation found 10 stale `IMPL-014` statements across 7 documents. Establishes a single authoritative status record and names the two Matrix §10.2 checks that remain unimplemented and therefore unmet. |
| v1.1 | 2026-08-04 | GitHub backup row moved from **Failing** to **Current** (`011db0c`) after authorization was restored and the push verified against the GitHub API. Added the divergence commands to §6, since this document's own credibility rests on every claim in it being checkable — the same principle as `SID-4.56`. |
| v1.2 | 2026-08-04 | **Corrected this document's own stale claims,** found by the Governance Closure Phase while running item 8's validation. Four defects: (1) `X-13` and `X-10` were recorded *NOT IMPLEMENTED* although the checker implements both — corrected to IMPLEMENTED per `ADR-0014`, with coverage stated as 12 of 12; (2) architecture test count 14 → **20**; (3) full suite count 71 → **77**, in §4 and in the §6 command comment; (4) the header read v1.0 while this history already listed a v1.1, so the version field was never incremented when v1.1 was written. Added `GCP-02` and `PRD-012a` to §5 and cross-referenced the new `IMPLEMENTATION_BLOCKER_REGISTER.md`. **Gate 3 was not touched and remains red at 9 unwaived violations.** |
