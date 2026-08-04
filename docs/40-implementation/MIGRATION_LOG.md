# Migration Log

| Field | Value |
|---|---|
| **Document** | Migration Log — chronological record of executed migrations |
| **Version** | v1.0 |
| **Status** | Active — append one entry per executed migration |
| **Date** | 2026-08-04 |
| **Purpose** | Answer *"what was migrated, when, by what authority, and what was left behind?"* without reading commit history |

---

## 1. Why this log is separate from the changelog

| Document | Answers |
|---|---|
| [`ARCHITECTURE_CHANGELOG.md`](../10-architecture/ARCHITECTURE_CHANGELOG.md) | *What structural rule changed?* |
| **This log** | *What code was moved to comply, and what did not move?* |

A structural decision and its migration can be weeks apart — `ADR-0011` was accepted on 2026-08-02 and the code
migrated on 2026-08-04. During that window the documentation and the code disagreed. **This log exists to make
such windows visible rather than implicit**, because an undocumented gap between decision and code is the state
in which an engineer trusts the wrong source.

---

## 2. `MIGRATION-001` — Student Identity: nullable/social → mandatory/platform

| Field | Value |
|---|---|
| **Executed** | 2026-08-04 |
| **Authority** | [`ADR-0011`](../00-governance/adr/ADR-0011-global-person-identity.md) |
| **Raised** | [`ADR-0012`](../00-governance/adr/ADR-0012-scaffold-port-inversion-debt.md) |
| **Baseline** | `9f15750` |
| **Result** | `a22fd7e` — 21 files, +2 757 / −91 |
| **Decision → migration gap** | **2 days** (2026-08-02 → 2026-08-04) |
| **Plan** | [`STUDENT_IDENTITY_MIGRATION_PLAN.md`](./STUDENT_IDENTITY_MIGRATION_PLAN.md) — `MIG-01`…`MIG-18` |
| **Verdict** | Complete. 18 issues closed; 1 (`MIG-15`) intentionally left open |

### 2.1 Execution order, as run

The order was not arbitrary. Two constraints were **non-negotiable**, and both would have produced a *silently
wrong* result if reversed:

| # | Step | Issues | Note |
|---:|---|---|---|
| 1 | Correct `contracts.path` in the manifest | `MIG-10` | **Must precede the checker.** `contracts.path` pointed at `lib/contracts`, which never existed. Writing the checker first would have certified law `L5` green against an empty directory |
| 2 | Declare the rank-0 identity port | `MIG-01` | `PersonIdentityFactory` — resolves rank 4 → rank 7.5 |
| 3 | Create `domain/person` at rank 7.5 | `MIG-04` | `PersonIdentity`, service, repository, `anonymise()` |
| 4 | Make `Account.personId` mandatory | `MIG-02` | Compiler then lists every construction site |
| 5 | Make `StudentRecord.personId` mandatory + `final` | `MIG-03` | `linkToPerson` deleted |
| 6 | Remove identity from Social | `MIG-05` | `SocialPresence` retained, identity fields dropped |
| 7 | Provision identity for walk-ins | `MIG-06` | `AUTH-4.23`…`AUTH-4.28` claim flow |
| 8 | Fix seed data | `MIG-07` | 1/5 → **5/5** accounts with identity |
| 9 | Fix fixtures and tests | `MIG-08` | Fixtures use the **real** service |
| 10 | Update the manifest to the new architecture | `MIG-09` | rank 7.5, banned symbols |
| 11 | **Build and run the checker** | `MIG-11` | **Must precede step 12** — the cycle was invisible until something looked |
| 12 | Fix the `L1` cycle | `MIG-13` | `di.dart ⇄ seed.dart`, Matrix §8.2 |
| 13 | Verify the checker itself | `MIG-12` | 14 governance tests |
| 14 | Record the pre-existing debt | `MIG-14` | `ADR-0012`, 12 dated exceptions |
| 15 | Declare `yaml` dev dependency | `MIG-18` | `yaml: 3.1.3`, pinned |

### 2.2 What moved

| Artefact | From | To |
|---|---|---|
| Global identity aggregate | `lib/domain/social/social.dart` (rank 8) | `lib/domain/person/person.dart` (rank **7.5**) |
| Identity creation trigger | social opt-in | `AuthService`, same transaction |
| Identity port declaration | *did not exist* | `packages/liboora_contracts/lib/src/ports/person_identity_factory.dart` (rank 0) |
| Seeder wiring | `di.dart` imported `seed.dart` | `main.dart` injects `ContainerSeeder` |

### 2.3 What deliberately did **not** move

| Left in place | Authority |
|---|---|
| Membership / Attendance / Seating / Finance keys | `SID-4.23` — re-keying on `PersonId` is forbidden |
| Event payloads (no `personId` added) | `SID-4.19` — would permit a cross-tenant join |
| All PRDs | Explicit scope constraint — *"Keep PRDs frozen"* |
| `TenantContext` | Already correct in rank 0 (Matrix §8.3) |
| 9 × `app → domain/library` imports | `TASK-D10` owns them; see §2.5 |

### 2.4 Data migration

**None required, and this is recorded rather than skipped.** There is no `migrations/` directory and every
repository is in-memory, so there was no persisted state to transform. The nullable → non-nullable change was a
*compile-time* change only.

> **Carried forward.** When persistence lands, this becomes a real migration: both `personId` columns need
> `NOT NULL` plus a uniqueness constraint expressing `SID-INV-1`. Tracked as `RSK-06`.

### 2.5 Left open, on purpose

| Item | Why |
|---|---|
| `MIG-15` — 9 × `app → domain/library` | Already tracked by `TASK-D10`, a **P0 release blocker**. Waiving would convert a tracked blocker into untracked debt with a 2027 expiry. Gate 3 exits 1 by design, and a test fails if the edge is ever waived |
| `MIG-14` — 12 dated exceptions | Genuine debt, time-boxed by tooling. First wave expires **2026-10-31** |

### 2.6 Defects found *by* the migration

Recorded separately because none was in scope; each was found by executing something previously only read.

| Defect | Nature | Status |
|---|---|---|
| `R-5` | `contracts.path` → a directory that never existed; `L5` was checking nothing | **Closed** |
| `L1` cycle | `di.dart ⇄ seed.dart`, pre-existing and undetected | **Closed** |
| 37 mode violations | Pre-existing; concrete imports where §4 requires ports | Governed by `ADR-0012` |
| Masked lint | An over-long line hid `curly_braces_in_flow_control_structures` until `dart format` split it | **Closed** |
| `E-11` mis-citation | The migration plan cited the wrong edge for the claim flow | **Closed** — corrected to `AUTH-4.23`…`AUTH-4.28` |
| 10 stale statements | Seven documents still said `IMPL-014` *"does not exist"* | **Closed** in Phase 6 |

### 2.7 Rollback

Not exercised. Available route: `git revert a22fd7e` restores the pre-migration model in one step. Any partial
rollback fails to compile — deliberately, since `personId` is `required` at every construction site, so a
half-reverted tree cannot silently run with a null identity.

---

## 3. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-04 | Created during Phase 6. Records `MIGRATION-001`, including the two non-negotiable ordering constraints, the six defects the migration exposed, and the deliberate open items. |
