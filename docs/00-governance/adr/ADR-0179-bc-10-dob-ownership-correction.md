<!-- LIBOORA Governance | Architecture Decision Record | 2026-11-25 -->

> **Product Owner authorization (recorded verbatim, one-act form):** *"PRODUCT OWNER AUTHORIZED — OPTION C. Repository baseline: b39a16e6. Scope: BC-10 DOB ownership correction + E-13 DOB read capability + Student Enrollment integration. … Never fabricate DOB, actors, events, registrationSource or identity mappings. Preserve raw v1 DOB rows until migration verification. Preserve all previously authorized enrollment semantics. No waivers, no weakened or deleted tests, no unrelated refactoring. Stop and report if a frozen requirement requires a new Product Owner decision. ADR changes only for the BC-10 DOB ownership decision. Git operations: NO COMMIT, NO PUSH, NO MERGE without separate explicit authorization."* (The full authorization message, including the priority list and strict rules, is preserved in the work order; this quotation is the decision grant. ⛔ No standing authority — the act reverts on completion and its verification report, per `ADR-0033` §7.1.)

# ADR-0179 — **BC-10 owns the date of birth: `StudentRecord` v2, the `E-13` DOB read, and the legacy transfer**

| Field | Value |
|---|---|
| **Status** | ⭐⭐ **ACCEPTED** — 2026-11-25, by **direct Product Owner conferral** recorded verbatim above (one-principal form; ⛔ no ARB quorum / external audit asserted — `ADR-0103`/`ADR-0146` disclosure form). Decision substance in §1–§4 is executed in the same authorized act and left **uncommitted** pending the separately authorized git act. |
| **Rank** | **4 — Domain/Bounded-Context Decision** |
| **Date** | 2026-11-25 |
| **Bounded context** | **`BC-10` Global Person Identity (owner)**, with the `E-13` ACL and the `BC-01` read side this decision corrects |
| **Route** | ⭐ **Standalone ADR** on the `ADR-0011` form (BC-10 ownership); ⛔ **not** a PRD amendment — `PRD-004` §`SM-4.2`/`SM-4.5` already freeze the ownership; this ADR *executes* the frozen text against a legacy storage deviation |
| **Supersedes** | ⛔ **NOTHING** — the pre-Option-C storage shape (DOB on `StudentRecord`) was a **deviation** from the frozen model, not an Accepted decision, and so is corrected, not superseded |
| **Superseded by** | — |
| **Amends** | `docs/40-implementation/` records only. ⛔ No Rank 1–3 document · no BC Map edge · no `X-*`/`SID-*` identifier rewritten · no manifest edit (the port declaration pattern used is the one `ADR-0011` already sanctions) · no waiver added or shortened |
| **Decides** | ⭐ **One matter only:** where the date of birth lives, who may write it, how age is derived at enrollment, and how the legacy DOB-bearing rows are transferred — nothing else |
| **Expressly does NOT decide** | ⛔ The persistence migration (`SM-3.16`'s unique constraint remains the future persistence layer's obligation) · ⛔ any UI structure beyond the walk-in dialog's honest fields · ⛔ OTP/account-claim flow (`E-11` behaviour is recovered verbatim from commit `86d8008`, unchanged) · ⛔ any fee, membership, seating or attendance semantics · ⛔ any git operation (no commit/push/merge without separate authorization) |
| **Deciding authority** | **Product Owner** (one-act conferral, recorded above) |
| **Origin** | ⭐ The pre-Option-C implementation stored `dateOfBirth` on `StudentRecord` — a deviation from the frozen `SM-4.2` ("the DOB is owned by BC-10") and `SM-4.5` ("age derives from the identity"), discovered during the Phase-2 Student-Enrollment readiness audits. The Product Owner authorized **Option C** — the ownership correction, the `E-13` read capability, and the enrollment integration — as one act. |

---

## 1. Decision — DOB ownership is BC-10's, and stays there

**1.1 The `PersonIdentity` aggregate holds `dateOfBirth` (nullable).** It is personal data owned by BC-10 (`ADR-0011`). Erasure (`anonymise()`) clears it together with the rest of the profile content.

**1.2 The DOB is written through exactly one path**: `PersonIdentityService.recordDateOfBirth`, which enforces, in order — the identity must exist (no identity is created here, `SPO-1`); **first-wins** (a different DOB than the recorded one is a `conflict`, never a silent overwrite); **same-DOB replay is a no-op** (idempotent); and **a future DOB is invalid input**, measured against the injected clock (`X-09` — the invariant lives on the clock-owning write path, never in the aggregate constructor).

**1.3 `StudentRecord` v2 stores no DOB.** The aggregate carries `minorStatus` and, when applicable, the audited `AgeDeclaration` — the *derivations* of age, never the evidence itself (`SM-4.2`, `SM-4.5`).

**1.4 Age is derived at enrollment, from the `E-13` ACL.** `EnrollStudent` resolves `IdentityCoreFields` (with the DOB read through the rank-0 `IdentityDirectoryPort` — declared in `liboora_contracts`, implemented by BC-10, consumed by BC-01; the manifest's *reach-by-port, never-by-import* rule, `ADR-0011`). Derivation order, frozen:

| Condition | Result |
|---|---|
| BC-10 holds a DOB | Age computed against the tenant clock → `minor` / `adult` (`SM-4.5`) |
| No DOB, `SM-4.5a` declaration supplied | `minor` / `unknown` per the declaration; a DOB and a declaration are **mutually exclusive** inputs — the recorded DOB always wins because it is evidence, not assertion |
| No DOB, no declaration | `unknown`; **the record may not leave the draft unresolved** (`SM-4.5a` refuses enrollment) |
| `unknown` at read time | **Fail-safe to minor** — guardian mandatory (`SM-4.5b`); an `unknown` status is never read as adult |

**1.5 The durable identity directory.** Identities previously existed only in memory — a restart silently emptied the directory that restored accounts point at. This is a pre-existing gap closed as a precondition of DOB ownership: an owned DOB must survive restart. Identities persist through the same durable adapter as accounts (global keys, no tenant partition, `SID-4.49`), with the codec injected at the composition root (the `TenantPartitionedStore` pattern — rank 7.5 never reaches bootstrap codecs).

## 2. The legacy rule — transfer, never fabricate

**2.1 Raw v1 rows are preserved until verified.** The durable `student_records` namespace is shared as one constant (`kStudentRecordsDurableNamespace`) between the store and the migration. The migration **never writes or deletes a student row**; the old `dateOfBirth` key stays on the raw row until that row is next saved in v2. Rollback is therefore always available by simply not running the migration.

**2.2 The transfer is idempotent and honest.** `migrateStudentDobToIdentities` runs at boot, after the identity directory is restored and before the container is built. For each raw row: no DOB → skipped (nothing to transfer); DOB present and the person has no identity → counted as an **orphan** and reported at boot, never guessed at; identity already holds a DOB → counted `alreadyOwned` (no overwrite); otherwise the DOB is transferred through `recordDateOfBirth` (BC-10's own write path), preserving the value exactly (day-for-day).

**2.3 The codec is versioned (`kStudentSchemaV2 = 2`).** v2 rows carry `accountId`, `registrationSource`, `minorStatus`, `ageDeclaration`, `archivedAt` and the append-only `statusHistory`; they carry **no DOB**. A v1 row is decoded by *deriving* `minorStatus` from the DOB it factually recorded — a v1 minor always carried a guardian and a v1 adult needs none, so the `SM-4.5b` fail-safe never misfires on restored data. A v1 row with no DOB decodes as `unknown` **with an empty history**: legacy absences are represented as absent, never synthesized (`registrationSource` stays null; no status-history entry is invented for a row that never had one).

**2.4 Honest representations are load-bearing.** No migration step, decoder or constructor may invent a DOB, an actor, an event, a `registrationSource` or an identity mapping. Where the data is absent, the record says so.

## 3. The enrollment semantics this decision rides on (preserved, not re-decided)

These were authorized in the Option C work order and are implemented unchanged; they are restated here only so the ADR records what the DOB correction touched:

- **Duplicate detection is by `personId` only** (`SM-3.11`/`SM-3.12`); a duplicate response carries the existing `StudentRecordId` (`SM-3.13`).
- **Archived records are restored, never duplicated** (`SM-3.14`); the most-recently-archived record is the restore target (`SM-3.14a`); restore is **TR-1 only**, enforced inside `RestoreStudent` via the PDP, never in UI (`SM-2.3`).
- **Idempotency is tenant-scoped** (`SM-3.6`): the same (tenant, person, key) replays the prior record and emits nothing; a key reused for a **different** person is a typed conflict.
- **A failed registration emits no `SM-EV-1`**; a replay emits no duplicate; the restore emits `SM-EV-2` (`SM-2.12`).
- **The enrollment number is allocated after validation, inside the synchronous critical section** — a failure never consumes a number (`SM-3.5`). Atomicity is **single-isolate in-memory**; it is not database-level protection, and `SM-3.16`'s unique constraint remains the future persistence migration's obligation.
- **`E-11` account resolution** is recovered verbatim from commit `86d8008` (IMPL-304) and wired as a rank-0 port; enrollment holds a `PersonId`/`AccountId` pair it was given — it never creates accounts (`SPO-1`, `SID-4.11`).

## 4. Consequences

- `StudentRecord` no longer compiles with a `dateOfBirth`; every construction site derives `minorStatus` upstream or states `unknown` and takes the fail-safe.
- The `E-13` port gains its first real consumer; the "declared but unused" disclosure in `no_orphan_ports_test.dart` is replaced by the positive wired-by-type assertion it requested.
- The walk-in dialog records either a real DOB (BC-10 evidence) or an audited declaration — a year alone is never expanded into a fabricated date.
- The raised-event measurement moves 13 → 14 (`enrollment.StudentStatusChanged` is declared in §9 and is now raised).
- All changes remain **uncommitted**; the git act requires separate authorization.

## 5. Verification

Executed under the work order's gates: `dart format`, `flutter analyze` (clean), `dart run tool/check_module_boundaries.dart` (**PASS** — no un-waived violations), the full `flutter test` suite, and `flutter build web`. The focused suites are: person-DOB ownership, `E-13` read capability, `E-11` resolution, the legacy DOB migration, and the enrollment registration semantics (duplicate/restore/idempotency/fail-safe).

---

### Registration hygiene

| Check | Result |
|---|---|
| Number | ⭐ `ADR-0179` is the next unregistered ADR (`ADR-0178` is the highest prior); no number reused or renumbered |
| Citation cost | ⭐⭐ Zero edits to past ADR entries or the index's historical cells |
| Status act | ⭐ Registration records the Accepted status; ⛔ no decision text is re-decided or widened; Process rule 2 (*never edit an Accepted ADR's decision text*) is preserved |
| Change surface | ⭐ `lib/` (BC-10, BC-01, composition root, app layer), `packages/liboora_contracts` (E-11 recovery, E-13 port), `test/`, `tool/bench_p95.dart` call-site fix only — ⛔ no manifest edit, no PRD, no checker rule change |
