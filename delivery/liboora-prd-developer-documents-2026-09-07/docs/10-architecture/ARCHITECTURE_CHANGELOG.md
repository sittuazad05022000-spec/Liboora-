# Liboora — Architecture Changelog

| Field | Value |
|---|---|
| **Document** | Architecture Changelog — structural changes to the platform, in order |
| **Version** | v1.0 |
| **Status** | Active — append an entry for every structural change |
| **Date** | 2026-08-04 |
| **Scope** | Changes to **structure**: bounded contexts, ownership, ranks, boundaries, enforcement. Not feature work |

---

## 1. What belongs here

An entry is required when a change alters any of the following:

| Trigger | Example |
|---|---|
| A bounded context is added, renamed, reclassified or moved | `BC-10` → rank 7.5, `[CORE]` |
| Ownership of an aggregate moves between modules | `GlobalStudentProfile` out of `domain/social` |
| A dependency rank changes | Introduction of rank 7.5 |
| A law gains, loses, or is denied an exception | `ADR-0012`'s 12 dated exceptions |
| Enforcement capability changes | `IMPL-014` beginning to run |
| A cardinality or nullability rule changes at the boundary | `personId` nullable → mandatory |

**Feature work does not belong here.** Nor do documentation-only edits, unless they change what is *normative*.

Each entry names the ADR that authorised the change. **A structural change with no ADR is a defect, not an
entry** — Dependency Matrix §11 and `ADR-INDEX.md` §Process rule 1 both require the ADR *before* implementation.

---

## 2. Entries, newest first

### 2026-08-04 — Student Identity migration: code brought into conformance with `ADR-0011`

**Authority:** [`ADR-0011`](../00-governance/adr/ADR-0011-global-person-identity.md) (approved) ·
[`ADR-0012`](../00-governance/adr/ADR-0012-scaffold-port-inversion-debt.md) (raised by this work)
**Commit:** `a22fd7e` — 21 files, +2 757 / −91
**Reports:** [Migration Report](../40-implementation/ARCHITECTURE_MIGRATION_REPORT.md) ·
[Validation Report](../40-implementation/STUDENT_IDENTITY_VALIDATION_REPORT.md)

The documentation had described a mandatory, platform-owned global person identity at rank 7.5 since `ADR-0011`.
The code still implemented an optional, social-owned profile at rank 8. **This entry records the code catching
up; no architectural decision was revisited.**

| Structural change | From | To |
|---|---|---|
| Owning module | `domain/social` (8) | **`domain/person` (7.5)** |
| Aggregate | `GlobalStudentProfile` | **`PersonIdentity`** |
| Classification | `[SUPPORTING]` | **`[CORE]`** |
| Account ↔ Identity cardinality | `0..1` opt-in | **`1:1` mandatory** |
| `Account.personId` | nullable | **non-nullable, required** |
| `StudentRecord.personId` | nullable, mutable | **non-nullable, `final`** |
| Identity creation | optional, on social opt-in | **same transaction as the account** (`SID-4.11`) |
| Social's holding | identity fields duplicated | `SocialPresence` only, **no identity fields** (`SID-BR-11`) |

**The keystone structural addition** is `PersonIdentityFactory`, an interface placed in the **rank-0** shared
kernel. It resolves what looked like a conflict between `SID-4.11` (identity created synchronously, in the same
unit of work) and law `L2` (dependencies strictly downward): `AuthService` at rank 4 cannot depend on rank 7.5,
but both can depend downward on rank 0, with the composition root wiring the implementation. The pattern was not
invented — PRD §4.3 and BC Map §7.2 both specify edge `E-12` as a *"synchronous port, same transaction"*.

**No law gained an exception for this edge**, and the claim is mechanically verified: the boundary checker reports
**zero** findings naming `domain/person`.

---

### 2026-08-04 — `L1` acyclic restored: `di.dart ⇄ seed.dart` cycle removed

**Authority:** Dependency Matrix §2 (`L1` has zero exceptions) and §8.2 (port inversion)
**Commit:** `a22fd7e`

A circular import between the DI container and the seeder **pre-existed this migration** (verified against
`9f15750`) and had never been detected, because nothing checked. Law `L1` is *"the one law with zero exceptions"*
and §11 step 3 records that it is **never** approved for waiver — so there was no governance route and the code
had to change.

Fixed with Matrix §8.2 **port inversion (callback)**: `di.dart` declares
`typedef ContainerSeeder = Future<void> Function(AppContainer, List<Account>)` and no longer imports the seeder;
`main.dart` — the composition root, the one place permitted to know both — supplies `seedDemoData`.

**Structural consequence:** the checker now treats `circular-dependency` as **unwaivable by construction**. An
exception naming a cycle is ignored even when syntactically valid, so `L1` cannot be silenced by manifest edit.

---

### 2026-08-04 — Boundaries became enforced: `IMPL-014` executed for the first time

**Authority:** Dependency Matrix §10.2 · `SID-4.56` (*"a rule that cannot be checked SHALL be treated as unmet"*)
**Commit:** `a22fd7e` · **Design:** [`BOUNDARY_CHECKER_DESIGN.md`](./BOUNDARY_CHECKER_DESIGN.md)

This is the most consequential governance change in the platform's history to date, because it converts every rule
in the Dependency Matrix from prose into a merge gate.

| Aspect | Value |
|---|---|
| Categories enforced | **10** of 12 specified |
| Not enforced | `X-13` tenant-key · `X-10` audit-mutation — **remain unmet** per `SID-4.56` |
| First-run result | **38 violations**: 1 `L1` cycle + 37 §4 mode violations |
| Self-verification | 14 tests asserting governance **properties**, not finding counts |
| CI position | §10.4 gate 3, **blocks merge** |

**Defect `R-5` closed as a direct consequence.** The manifest's `contracts.path` pointed at `lib/contracts` — a
directory that has **never existed** in this repository. Law `L5` (*contracts import nothing*) had therefore been
scanning an empty directory and would have been certified green while checking nothing. The defect had survived
prose review; it surfaced within minutes of treating the manifest as an **executable input**.

---

### 2026-08-04 — 12 dated exceptions recorded; one edge deliberately left failing

**Authority:** [`ADR-0012`](../00-governance/adr/ADR-0012-scaffold-port-inversion-debt.md), applying Matrix §11

The 37 mode violations pre-date the migration (proven by re-running the checker against pristine `9f15750`). They
are edges whose *rank direction* is correct but which import a concrete class where §4 requires a port.

Three alternatives were rejected before choosing the §11 route:

| Rejected | Reason |
|---|---|
| Weaken the checker | Makes the tool agree with the code; inverts source of truth |
| Amend the manifest to `mode: import` | Matrix §12 permits exactly **one** direct-import permission |
| Extract all 13 ports immediately | Unrelated to Student Identity; destroys reviewability |

**Structural precedent set:** debt is **time-boxed by tooling**. An expired exception stops waiving and the build
fails; a missing or unparseable date counts as **expired**; a missing `adr` field halts the checker with exit 2.

**The `app → domain/library` edge (9 findings) is deliberately NOT waived.** It is already tracked by `TASK-D10`,
a P0 release blocker. Waiving it would convert a tracked blocker into untracked debt expiring in 2027. Gate 3
therefore **exits 1 by design**, and a test fails if the edge is ever waived.

---

### 2026-08-02 — Rank 7.5 introduced; `BC-10` reclassified `[CORE]`

**Authority:** [`ADR-0011`](../00-governance/adr/ADR-0011-global-person-identity.md)
**Commit:** `9f15750` — *documentation only; the code was migrated on 2026-08-04*

`BC-10` Global Person Identity moved from the Social cluster (`[SUPPORTING]`, rank 8) to **rank 7.5**,
`[CORE]`, owned by the platform. Cardinality with `Account` changed from `0..1` opt-in to **`1:1` mandatory**.
Linkage rules `ID-1`…`ID-6` and prohibition `X-05` were **preserved unamended**.

Rank 7.5 is fractional because identity is consumed by every library context and consumes none of them: it sits
below `domain/library` (8) and above every capability, and rank 7 was already `platform/analytics`, a capability
that `L4` forbids from depending on a domain. Renumbering fifteen modules was rejected as the larger change.

> **Recorded gap, now closed.** This change was made without a Dependency Matrix changelog row. The row was
> retro-added as v1.1 on 2026-08-04, and this changelog exists partly so that a structural change cannot again be
> made without a durable trace.

---

### 2026-07-30 — Baseline: modular monolith, five laws, ten ranks

**Authority:** [`ADR-0001`](../00-governance/adr/ADR-0001-modular-monolith.md)

Initial structure: modular monolith with a pure-Dart shared kernel (`packages/liboora_contracts`, empty
`dependencies:` enforcing `L5`), five dependency laws, ten ranks, seven communication modes, 14 named forbidden
edges, four cycle-breaking patterns, and a three-layer CI enforcement design with a time-boxed exception process.

**Enforcement was specified but not built** — a gap that persisted until 2026-08-04.

---

## 3. Standing structural debt

| Item | Authority | Closes when |
|---|---|---|
| 13 port extractions (4 waves) | `ADR-0012` | Waves expire `2026-10-31` → `2027-03-31` |
| 9 × `app → domain/library` | `TASK-D10` (P0) | Demo surfaces removed |
| `X-13` tenant-key check | Matrix §10.2 | Not scheduled — **unmet** |
| `X-10` audit-mutation check | Matrix §10.2 | Not scheduled — **unmet** |

---

## 4. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-04 | Created during Phase 6 of the Student Identity migration. Backfilled the 2026-07-30 baseline and the 2026-08-02 rank-7.5 entry so the record is continuous rather than starting mid-history. |
