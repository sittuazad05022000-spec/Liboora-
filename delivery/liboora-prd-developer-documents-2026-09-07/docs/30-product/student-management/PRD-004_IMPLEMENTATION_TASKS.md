# `PRD-004` Implementation Tasks — `IMPL-300` … `IMPL-323`

| Field | Value |
|---|---|
| **Document** | Implementation tasks for [`Student_Management_PRD_v1.md`](Student_Management_PRD_v1.md) (`PRD-004`) |
| **Version** | v1.1 |
| **Status** | Backlog record. **Not ranked**, therefore editable without an ADR |
| **Date** | 2026-08-04 *(corrected same day — second-review finding `SR-01`)* |
| **Baseline** | `BASELINE-2026-08-04-B` |
| **Purpose** | Phase 20 deliverable 5. Expands `PRD-004` §10.7 into sequenced, independently verifiable tasks |
| **Implementation state** | ⛔ **NOTHING IN THIS DOCUMENT IS IMPLEMENTED.** Zero files under `lib/` were created or modified. No development has started |
| **Source of truth** | `PRD-004` §10.7. Where this file disagrees with it, **the PRD is right and this file is a defect** |

---

## 1. The one thing this document is not

It is **not** evidence of progress. Writing 18 well-formed tasks can read like work completed; it is a plan for
work **not** begun. Verified, not asserted:

```
git status --short            → only new docs under docs/30-product/student-management/
git diff --stat 630975e -- lib/  → (empty)   # zero application-code changes
```

Per `SID-4.56`, *"a rule that cannot be checked SHALL be treated as unmet."* The same applies to a task: until its
test exists and runs, it is **not done**, however complete its description.

---

## 2. Blocking dependencies outside `PRD-004`

`PRD-004` cannot be fully implemented from its own backlog. These constraints are inherited, not introduced here.

| Blocker | Effect on this backlog | Register |
|---|---|---|
| **`BLK-01`** / `TASK-D10` demo surfaces | **Gate 3 is red today** (9 `cross-context` violations). Any PR in this backlog inherits a red gate 3 until `TASK-D10` lands. **The violations must not be waived to make it green** | `IMPLEMENTATION_BLOCKER_REGISTER.md` |
| **`IMPL-214`** `E-13` ACL | **`IMPL-305` cannot start.** Pre-registered against `PRD-004` in `PRD_REGISTRY.md` line 224 | `PRD_REGISTRY.md` |
| `PRD-005` (`BC-02`) **`PLANNED`** | Membership/expiry projections in `IMPL-312` have **no owning specification** yet | `PRD_REGISTRY.md` |
| `PRD-006`/`007`/`008` **`PLANNED`** | Attendance, seat and fee projections likewise unspecified. Also `SM-GAP-9` | `PRD_REGISTRY.md` |
| `PRD-023` (`BC-25`) unwritten | `IMPL-313` reads `LCFG-5` via `E-19`; the configuration PRD does not exist | `ADR-0017` |

> **Consequence, stated rather than buried:** `IMPL-312` (the Directory itself) can be built against `BC-01` data,
> but **every projected column it displays depends on a `PLANNED` PRD.** A Directory shipped before `PRD-005`–`008`
> would show enrollment columns only. That is a scheduling fact, not a defect in this backlog.

---

## 3. The 24 tasks

Quoted from `PRD-004` §10.7, with sequencing and definition of done added. **Modules** use the repository's
existing layers; no new module is proposed.

### 3.1 Wave 1 — Domain foundation (no Directory yet)

| Task | Scope | Module | Depends on | Requirements | Test requirement |
|---|---|---|---|---|---|
| `IMPL-300` | `StudentRecord` aggregate + value objects | `domain/library` | — | `SM-2.1`–`SM-2.4` | Unit: invariants |
| `IMPL-301` | `EnrollmentStatus` closed state machine | `domain/library` | `IMPL-300` | `SM-2.5`–`SM-2.13` | Reject `Expired`, reject illegal transitions |
| `IMPL-302` | Schema + unique constraints + indexes | `platform/data` | `IMPL-300` | `SM-10.1`–`SM-10.6` | Schema scan: no credential, no `library_member` |
| `IMPL-303` | Tenant-key enforcement on all access | `platform/data` | `IMPL-302` | `SM-8.1`–`SM-8.3` | `X-13` checker category 12 |

**`IMPL-301` is the task that encodes `CONF-1`.** Its test must **fail** if `Expired` is ever accepted as an
`EnrollmentStatus`, because BC Map line 209 assigns `Expired` to `BC-02`. **`IMPL-302` makes `OWN-4` executable**
— the schema scan is the first mechanical proof that no second member store exists.

### 3.2 Wave 2 — Identity ports and registration

| Task | Scope | Module | Depends on | Requirements | Test requirement |
|---|---|---|---|---|---|
| `IMPL-304` | `E-11` account resolution port | `domain/library` | `IMPL-300` | `SM-3.1` | Contract test |
| `IMPL-305` | `E-13` identity ACL | `domain/library` | `IMPL-300`, **`IMPL-214`** | `SM-3.3`, `SM-7.3`, `SM-7.4` | ACL test: no reverse reference |
| `IMPL-306` | Registration use case + idempotency | `domain/library` | `IMPL-301`–`305` | `SM-3.4`–`SM-3.10` | Idempotency, atomic rollback |
| `IMPL-307` | Duplicate prevention | `domain/library` | `IMPL-302`, `IMPL-306` | `SM-3.11`–`SM-3.17` | Concurrency: DB constraint decides |

**`IMPL-307`'s test is deliberately adversarial.** Duplicate prevention keys on `personId` only, and the test must
run **concurrent** registrations to prove the database constraint — not an application-level pre-check — is what
decides. A pre-check passes under single-threaded testing and fails in production.

### 3.3 Wave 3 — Profile, documents, lifecycle, events

| Task | Scope | Module | Depends on | Requirements | Test requirement |
|---|---|---|---|---|---|
| `IMPL-308` | Guardian + minor rules | `domain/library` | `IMPL-305` | `SM-4.4`–`SM-4.8` | Under-18 mandatory guardian |
| `IMPL-309` | Document `FileRef` via `E-22` | `domain/library` | `IMPL-300` | `SM-4.9`–`SM-4.12` | No bytes/path stored |
| `IMPL-310` | Status/archive/restore use cases | `domain/library` | `IMPL-301` | `SM-2.8`–`SM-2.16`, `SM-6.1` | Dues-block on archive |
| `IMPL-311` | `SM-EV-1`…`9` publication | `domain/library` | `IMPL-301` | `SM-7.12`–`SM-7.17` | No `StudentRecordId` in global event |

**`IMPL-310` carries a cross-context pre-condition:** archive is blocked by open dues, checked via `E-09` against
`BC-05` (BC Map line 370). Since `PRD-008` is `PLANNED`, this must be implemented **against the port**, with the
test using a fake — not deferred until `BC-05` exists.

### 3.4 Wave 4 — The Library Members Directory (application layer only)

| Task | Scope | Module | Depends on | Requirements | Test requirement |
|---|---|---|---|---|---|
| `IMPL-312` | **Directory read composition (application layer)** | `app` | `IMPL-306`, `IMPL-310` | `LMD-1`–`LMD-24` | No domain-layer composition; no member table |
| `IMPL-313` | **`LCFG-5` gating via `E-19`** | `app` | `IMPL-312` | `LMD-4`–`LMD-7` | Disabled ⇒ suppressed, data intact |
| `IMPL-314` | Directory search via `BC-23` (`E-21`) | `app` | `IMPL-311` | `LMD-12`–`LMD-14` | No domain-table search query |
| `IMPL-315` | `SM-PO-*` authorisation via `BC-18` | `app` | `IMPL-310` | `SM-8.5`–`SM-8.9` | Per-operation matrix test |

**All four are `app`, never `domain/library`.** `SID-2.41` and `AR-1` place a read composition outside the domain
layer, and **gate 3 enforces this mechanically** — a composition placed in `domain/library` would be caught by
`check_module_boundaries.dart`, not by review. This is the one Directory rule that is already machine-checkable.

**`IMPL-313`'s test is the `LIB-16.6` test:** disabling `LCFG-5` must suppress exposure **while leaving every
membership and student record intact**. A test that only asserts "list is empty" is insufficient — it must also
assert the underlying records still exist, then re-enable and confirm they reappear.

### 3.5 Wave 5 — Audit and bulk

| Task | Scope | Module | Depends on | Requirements | Test requirement |
|---|---|---|---|---|---|
| `IMPL-316` | Audit to `BC-24` incl. read auditing | `platform/audit` | `IMPL-310` | `SM-8.10`–`SM-8.14` | Append-only (`X-10`) |
| `IMPL-317` | Bulk operations + export caps | `app` | `IMPL-312`, `IMPL-315` | `LMD-30`, `LMD-31`, `SM-10.7` | Partial failure reported as partial |

**`IMPL-316` covers the easily-missed case (`SM-AC-24`):** a *read* of sensitive data must be audited **even
though no state changed**. Audit implementations commonly hook writes only. It also makes **`OWN-6`** executable —
`personId` must appear in no audit payload, export or global index.

**`IMPL-317`'s failure semantics matter:** a bulk operation with 3 failures out of 100 is **not** success
(`SM-AC-25`). It must report per-record outcomes.

### 3.6 Wave 6 — Correction-pass tasks

**These six tasks were added by the `PRD-004` correction passes and are reproduced here from `PRD-004` §10.7.**
They existed in the PRD but were missing from this document, which meant an implementer reading only this file
would have under-scoped the work by six tasks — finding `SR-01` of the second independent review. The requirement
and test columns are copied from §10.7 verbatim; **nothing here is invented by this document.**

| Task | Scope | Module | Depends on | Requirements | Test requirement |
|---|---|---|---|---|---|
| `IMPL-318` | **Status · expiry · archived-filter indicators** | `app` | `IMPL-312` | `LMD-25`–`LMD-29` | Two independent badges (`SM-AC-19`); archived hidden by default |
| `IMPL-319` | **Field-level authz, history & operations surface** | `app` | `IMPL-306` | `SM-6.1`–`SM-6.8` | Unauthorised field edit refused; history read from `BC-24` |
| `IMPL-320` | **`SM-EV-10` consent-gated person link** | `domain/library` | `IMPL-305`, `IMPL-311` | `SM-EV-10`, `SM-7.12a`, `SM-7.12b`, `SM-10.12` | Not emitted absent consent; carries no `StudentRecordId` |
| `IMPL-321` | **Producer-side transactional outbox** | `platform/event` | `IMPL-302`, `IMPL-311` | `SM-7.7a`, `SM-7.7b` | Commit-without-publish impossible; tenant-partitioned |
| `IMPL-322` | **Absent-DOB minor-status path** | `domain/library` | `IMPL-308` | `SM-4.5a`–`SM-4.5c`, `SM-INV-3` | `SM-AC-29` passes; fail-safe to minor |
| `IMPL-323` | **Deterministic restore among archived records** | `domain/library` | `IMPL-307` | `SM-3.14a`, `SM-3.14b` | `SM-AC-30` passes |

**`IMPL-320` and `IMPL-321` are the two most easily got wrong.** `IMPL-320` must prove a **negative** — that
`SM-EV-10` is *not* emitted when `BC-18` has recorded no consent, and that enrollment still succeeds anyway
(`SM-7.12a`). `IMPL-321` must prove that a committed state change with an unpublished event is **impossible**, not
merely unlikely (`SM-7.7a`); a test that publishes and then checks the outbox proves nothing about the failure
path.

**`IMPL-322` now also carries `SM-AC-31` and `SM-AC-32`.** The second review found that only the *absent*-DOB case
had a criterion; the two present-DOB guardian paths did not. `SM-AC-31` (minor without guardian ⇒ typed rejection,
nothing committed) and `SM-AC-32` (adult without guardian ⇒ enrollment succeeds) are verified here together with
`IMPL-308`, which owns the under-18 rule itself.

**`IMPL-319` is `app`-layer, not `domain`.** `SM-6.6` requires history to be **read from `BC-24`**, so this task
must not create a parallel audit store in the domain — the constraint that `SM-XC-*` and gate 3 both police.

---

## 4. Critical path

```
IMPL-300 → IMPL-301 → IMPL-302 → IMPL-303
              ↓                      ↓
IMPL-214 (EXTERNAL, blocks) → IMPL-305 → IMPL-306 → IMPL-307 → IMPL-323
                                 ↓          ↓
                                 ↓    IMPL-310 → IMPL-312 → IMPL-313 → IMPL-317
                                 ↓                  ↑    ↘
                                 ↓    IMPL-311 → IMPL-314  IMPL-318
                                 ↓       ↓
                                 └→ IMPL-320    IMPL-321 (needs IMPL-302)
                                      IMPL-308 → IMPL-322
                                      IMPL-306 → IMPL-319
```

**Longest chain: `IMPL-300` → `301` → `305`* → `306` → `310` → `312` → `313` → `317` (8 tasks).**
`*` gated by the external `IMPL-214`.

**Wave 6 does not lengthen the critical path.** `IMPL-318`–`IMPL-323` all branch off existing nodes
(`IMPL-312`, `IMPL-306`, `IMPL-305`/`311`, `IMPL-302`/`311`, `IMPL-308`, `IMPL-307`) and none of them is a
prerequisite of another wave-6 task, so all six are parallelisable once their single dependency lands.

**Start `IMPL-300` and `IMPL-302` first** — they unblock the widest fan-out. **Do not start `IMPL-312`** (the
Directory) early to show visible progress: it depends on `IMPL-306` and `IMPL-310`, and building it first would
require exactly the standalone member store that `SM-10.6` and `OWN-4` forbid.

---

## 5. Definition of done — applies to every task

A task is done when **all** hold. Items 3 and 4 block merge (Matrix §10.4).

1. `dart format --set-exit-if-changed .` → exit 0
2. `flutter analyze` → `No issues found!`
3. `dart run tool/check_module_boundaries.dart` → **no new violation** (the 9 existing `TASK-D10` violations are pre-existing and **must not be waived**)
4. `flutter test test/architecture/` → all pass
5. `flutter test` → all pass, **including the task's own new test**
6. The mapped `SM-*`/`LMD-*` requirements are each asserted by at least one test
7. No frozen document modified; no integration edge added beyond `E-01`, `E-09`, `E-11`, `E-13`, `E-21`, `E-22`

> **Item 6 is the one that is usually skipped.** A task can pass items 1–5 while asserting nothing about its
> requirements. `SID-4.56` treats such a requirement as **unmet**.

---

## 6. Tasks that must **not** be created

| Tempting task | Why it must not exist |
|---|---|
| "Create `LibraryMember` aggregate" | `SM-1.7`, `AR-1`, BC Map `R1`. The member record **is** the `StudentRecord` |
| "Create `library_member` / `member_directory` table" | `SM-10.6`, `LMD-2`, `OWN-4` |
| "Add `Expired` to `EnrollmentStatus`" | BC Map line 209; would need an ADR and would break the two-state-machine split |
| "Implement member tags / notes" | **`SM-GAP-5`** — no authoritative source. Implementing it would invent a requirement |
| "Implement Parent Directory access" | **`SM-GAP-4`** — `TR-5` authorisation model undefined |
| "Waive the 9 cross-context violations" | `BLK-01`. They are real debt owned by `TASK-D10` |

**Six tasks a reasonable engineer might add, each of which would violate a rule.** They are listed so the
omission is visible as a decision rather than an oversight.

---

## 7. What this document does **not** claim

| Not claimed | Actual state |
|---|---|
| That any task is started | **Zero.** No `lib/` file changed |
| That the estimates are estimates | **None is given.** No sizing was requested and inventing one would be noise |
| That 24 tasks complete `BC-01` | They cover `PRD-004` v1.2. The **11 `SM-GAP-*`** decisions remain open |
| That `IMPL-300`…`323` are registered | They are declared in `PRD-004` §10.7 and here. The roadmap's `IMPL-*` register is **not yet updated** |
| That gate 3 will be green | It is **red** and stays red until `TASK-D10`/`BLK-01` |

---

## 8. Change history

| Version | Date | Change |
|---|---|---|
| v1.1 | 2026-08-04 | **Synchronised with `PRD-004` §10.7 — second-review finding `SR-01` (HIGH).** This document held **18** tasks (`IMPL-300`…`IMPL-317`) while the PRD had **24** (`IMPL-300`…`IMPL-323`); the six tasks added by the first correction pass were never propagated here, so this file under-scoped the backlog and disagreed with its own declared source of truth. Added **§3.6 Wave 6** with `IMPL-318`…`IMPL-323`, copied from §10.7 verbatim, plus the critical-path and count updates. `IMPL-322` now also carries `SM-AC-31`/`SM-AC-32`, the two guardian/DOB criteria added by the final correction pass (finding `SR-10`). **No task was invented, no estimate added, and nothing is implemented — zero `lib/` files changed.** |
| v1.0 | 2026-08-04 | Created as Phase 20 deliverable 5. Sequences the 18 tasks from `PRD-004` §10.7 into five waves with an explicit critical path, a 7-item definition of done in which items 3–4 block merge, and the five **external** blockers (`BLK-01`, `IMPL-214`, `PRD-005`–`008`, `PRD-023`) that constrain the backlog. Records that **all four Directory tasks are `app`-layer**, enforced by gate 3 rather than review. Lists **six tasks that must not be created**, each mapped to the rule it would break. **Nothing is implemented: zero `lib/` files changed, no estimates invented, no task registered in the roadmap yet.** |
