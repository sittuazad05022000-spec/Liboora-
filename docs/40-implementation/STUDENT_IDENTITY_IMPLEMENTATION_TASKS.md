# Student Identity — Implementation Tasks

**Source specification:** [`Student_Identity_PRD_v1.md`](../30-product/student-identity/Student_Identity_PRD_v1.md) v1.0
**Governing decision:** [`ADR-0011`](../00-governance/adr/ADR-0011-global-person-identity.md)
**Alignment report:** [`STUDENT_IDENTITY_ALIGNMENT.md`](../30-product/student-identity/STUDENT_IDENTITY_ALIGNMENT.md)
**Baseline:** `BASELINE-2026-08-04`

---

## 0. Honest status

**This module is a migration, not a greenfield build**, and the distinction changes the shape of the
work. Identity code already exists — committed in `a44ebb0`, the original scaffold — and **all of it
implements the superseded pre-`ADR-0011` model**: a nullable, opt-in `PersonId` owned by the social
domain. Verified by search, not assumed:

| Existing artefact | Location | State | Conflicts with |
|---|---|---|---|
| `PersonId` | `packages/liboora_contracts/…/identifiers.dart:61` | Exists; documented as the *"social persona"* that *"may legitimately not exist"* | `ADR-0011`, `SID-2.1` |
| `Account.personId` | `lib/platform/identity/identity.dart:43` | **Nullable** | `SID-INV-1` — `1:1` mandatory |
| `StudentRecord.personId` | `lib/domain/library/enrollment/…/student_record.dart:53` | **Nullable** | **amended `ID-4`**, `SID-4.17` |
| `GlobalStudentProfile` | `lib/domain/social/social.dart` | Exists inside `domain/social` (rank 8) | `SID-4.1`–`SID-4.3` — must be rank 7.5 |
| `GlobalProfileReader` + in-memory repo | `lib/domain/social/social.dart`, wired in `di.dart:93,206` | Exists, port unimplemented | Ownership belongs to `domain/person` |
| Seed accounts | `lib/bootstrap/seed.dart:192,210` | **1 of 5 accounts has a `personId`** | `SID-INV-1` — 4 identity-less accounts |

**What does not exist:** the `lib/domain/person/` directory, any `SEV-*` event schema, and
`tool/check_module_boundaries.dart`.

**The manifest and the code disagree, and the manifest is correct.**
`tool/module_dependencies.yaml` already declares `domain/person: 7.5` and has removed `identity` from
`domain/social`'s contexts per `ADR-0011`. The code has not moved. The manifest describes the decided
architecture; the code describes the one it replaced. This was left unresolved deliberately — see
`IMPL-207` and `IMPL-208` — because relocating a domain aggregate is an implementation change with test
consequences, and the specification review that produced `ADR-0011` was not authorised to make one.

**No code was changed while reconciling the specification.** Every conflict above is recorded as a task.

Two prerequisites sit outside this document and gate several tasks below:

| Prerequisite | Status | Effect here |
|---|---|---|
| `IMPL-014` — module boundary checker | **Absent** | `SID-INT-1` … `SID-INT-12` cannot be mechanically enforced; `IMPL-220` depends on it |
| `BC-01` Student Record | **Partially present** | `StudentRecord` exists in `lib/domain/library/enrollment/`, but not the full `BC-01` specified by the Library PRD. `IMPL-214` can change the field's nullability; it cannot verify `E-13` end to end |

Note that the `BC-01` row is **weaker than previously recorded**. An earlier draft of this document
stated `BC-01` was absent. A `StudentRecord` aggregate does exist, which makes `IMPL-214` partly
actionable — the nullable field can be tightened now — while the ACL it belongs to still cannot be
tested.

Nothing below may be marked done on the strength of the specification being clear. `SID-5.42` and
`SID-5.48` require a failing-then-passing test per invariant and per acceptance criterion.

---

## 1. Task register

### 1.1 Identifier range — why these start at 200

`IMPL-014` … `IMPL-073` belong to authentication, platform and release readiness
([`IMPLEMENTATION_ROADMAP.md`](./IMPLEMENTATION_ROADMAP.md)). `IMPL-100` … `IMPL-127` belong to Library
Management ([`LIBRARY_IMPLEMENTATION_TASKS.md`](./LIBRARY_IMPLEMENTATION_TASKS.md)), which declared
`IMPL-128`+ unallocated.

Student Identity begins at **`IMPL-200`** rather than `IMPL-128` so that Library Management retains room
to grow contiguously. A task number is never reused and never reassigned, for the same reason an ADR
number is not: cross-references in commit messages, review comments and test names outlive the document
that created them.

| Range | Owner | Grouping |
|---|---|---|
| `IMPL-014` … `IMPL-073` | Authentication, platform, release readiness | `IMPLEMENTATION_ROADMAP.md` |
| `IMPL-100` … `IMPL-127` | Library Management | `LIBRARY_IMPLEMENTATION_TASKS.md` |
| `IMPL-128` … `IMPL-199` | Reserved for Library Management growth | — |
| **`IMPL-200` … `IMPL-208`** | **Architecture & foundation** — rank 7.5 tier, contracts, `PersonId`, aggregate, atomic creation, lifecycle, audit, **and the two migrations of existing scaffold code** | This document |
| **`IMPL-210` … `IMPL-216`** | **Profile & identity behaviour** — profile fields, username, photo, privacy, timeline, `E-13`, composition | This document |
| **`IMPL-220` … `IMPL-226`** | **Boundary, security & verification** — boundary enforcement, authorisation, events, search, integrity counters, NFR, acceptance | This document |
| `IMPL-227` + | Unallocated | — |

`IMPL-207` and `IMPL-208` were allocated from that group's reserve to carry the migration of existing
scaffold code, discovered during traceability verification. `IMPL-209` and `IMPL-217`–`219` remain
deliberately unallocated. Each group can grow without renumbering its successors.

### 1.2 Architecture & foundation — `IMPL-200` … `IMPL-208`

| ID | Task | Priority | Blocks | Blocked by |
|---|---|---|---|---|
| `IMPL-200` | **Rank 7.5 tier.** Add `domain/person: 7.5` to `tool/module_dependencies.yaml`; remove `identity` from `domain/social` contexts; declare banned symbols (`StudentRecordId`, `TenantId`) and banned imports (`domain/library/**`, `domain/social/**`, `app/**`); permit `domain/library` → `domain/person` | **P0** | Everything | — |
| `IMPL-201` | **Contracts.** `PersonId` value object and `SEV-1` … `SEV-16` event schemas in `liboora_contracts` with schema versioning. Contracts import nothing (`L5`, `X-12`) | **P0** | `202`, `222` | `200` |
| `IMPL-202` | **Person aggregate.** Global Profile fields, privacy mode, status; no credential, no `StudentRecordId`, no `TenantId`, no organisation collection | **P0** | `203`–`216` | `200`, `201` |
| `IMPL-203` | **Atomic creation with account.** Single transaction with `BC-18` account creation via `E-12`; failure of either fails both. Emit `SEV-1` from the outbox after commit | **P0** | `204`, `210`, `224` | `202` |
| `IMPL-204` | **Lifecycle state machine.** Pending Profile → Active → Suspended / Archived → Restored; same `PersonId` on restore; archived identities remain resolvable | **P0** | `214`, `222` | `203` |
| `IMPL-205` | **Audit emission.** All events in `SID-3.35` through the transactional outbox; append-only; no credential, OTP, mobile number or parent contact in any payload | **P0** | All mutating tasks | `202` |
| `IMPL-206` | **Configuration accessors.** `SCFG-1` … `SCFG-11` as typed accessors via `BC-25`; reject a configuration that would change the privacy default, alter the allow-list, disable an audit event, or set `SCFG-5` to 0 in production | P1 | `211`, `213`, `216` | `202` |
| `IMPL-207` | **Migrate `GlobalStudentProfile` out of `domain/social`.** Move the aggregate, `GlobalProfileReader` and the in-memory repository from `lib/domain/social/social.dart` into `lib/domain/person/`. Rewire `di.dart:93,206`. Leave `domain/social` **consuming** identity, never owning it. Update the file's own doc comment, which currently documents the superseded Separate-Ways model and names `BC-10` as the social domain | **P0** | `202` | `200` |
| `IMPL-208` | **Make both `personId` fields non-nullable.** `Account.personId` (`lib/platform/identity/identity.dart:43`) and `StudentRecord.personId` (`lib/domain/library/enrollment/domain/student_record.dart:53`). Remove every null branch and every *"degrade gracefully when absent"* path — that wording is the superseded `MP-GBR-02`. Delete the two doc comments asserting nullability is *"by design"* | **P0** | `203`, `214`, `224` | `201`, `207` |

### 1.3 Profile & identity behaviour — `IMPL-210` … `IMPL-216`

| ID | Task | Priority | Blocks | Blocked by |
|---|---|---|---|---|
| `IMPL-210` | **Profile fields + validation.** Full Name, Bio, Gender *(optional, "prefer not to say")*, Date of Birth, Address, Email, Occupation. Nothing partial persisted on validation failure | **P0** | `213`, `216` | `203` |
| `IMPL-211` | **Username.** Global case-insensitive uniqueness as a single unbreakable constraint; reserved-word list; rename cooldown; history retention; released-username hold period; `SEV-5`, `SEV-6` | **P0** | `223` | `202`, `206` |
| `IMPL-212` | **Global Profile Photo.** `FileRef` via `BC-29` (`E-22`); set, replace, hide, remove; independent of any Library Identification Photo; no bytes, no raw path, no public URL | P1 | — | `202` |
| `IMPL-213` | **Privacy.** Public/Private with **Private as default**; allow-list projection; never-public set unoverridable by configuration; consent record; immediate cache and index invalidation in the same operation | **P0** | `223` | `210`, `206` |
| `IMPL-214` | **`E-13` ACL.** Resolve identity core fields for a `PersonId` held by a Student Record; ACL translation both ways; non-nullable `PersonId` on the `BC-01` side *(the field change itself is `IMPL-208`)*. **Partly blocked — a `StudentRecord` aggregate exists, the full `BC-01` does not**, so the ACL cannot be verified end to end | **P0** | — | `204`, `208`; full `BC-01` |
| `IMPL-215` | **Profile timeline.** Records *that* a change occurred, not the sensitive value | P2 | — | `205` |
| `IMPL-216` | **Aggregated profile composition.** Application layer (rank 9, `AR-1`), never in the domain; per-contributor timeout `SCFG-9`; degraded sections labelled unavailable, never rendered as empty or zero; every contributed value fetched under the caller's own authorisation | P1 | `225` | `210`, `206` |

### 1.4 Boundary, security & verification — `IMPL-220` … `IMPL-226`

| ID | Task | Priority | Blocks | Blocked by |
|---|---|---|---|---|
| `IMPL-220` | **Boundary enforcement.** Extend the module boundary checker to fail the build on any `SID-INT-1` … `SID-INT-12` violation. **Blocked — `IMPL-014` does not exist**; until it does, each rule is review-verified and counted as unmet, not satisfied (`SID-4.56`) | **P0** | `226` | `200`; `IMPL-014` |
| `IMPL-221` | **Authorisation.** `SPO-1` … `SPO-9` gated per request via `BC-18`; deny by default; never cached; organisation roles `TR-1`–`TR-3` cannot mutate global profile state; Platform Administrator limited to status; every denial audited | **P0** | `226` | `202`, `205` |
| `IMPL-222` | **Event publication & consumption.** `SEV-1` … `SEV-16` via the outbox, at-least-once, idempotent consumers; consume `iam.AccountErased`, `iam.MobileNumberChanged`, `iam.AccountSuspended`, `safety.EnforcementActionTaken` — the last restricting the public projection only, never lifecycle | **P0** | `223`, `226` | `201`, `204` |
| `IMPL-223` | **Search indexing.** Allow-list fields only via `BC-23` (`E-21`); never-public fields never indexed anywhere; Public → Private removes from public search in the same operation; no lookup by mobile number and no confirmation that one is registered | P1 | `226` | `211`, `213`, `222` |
| `IMPL-224` | **Integrity counters.** Continuous monitoring of accounts-without-identity, identities-without-account and duplicate-usernames; each must read zero and alert on non-zero (`SID-5.34`, `SID-5.43`). **Against today's seed data the first counter reads 4, not 0** — this is fixed by removing the demo surface (`TASK-D10`, `MP-CON-11`) and creating identity on the real account path (`IMPL-203`), not by editing the seed file | **P0** | `226` | `203`, `211` |
| `IMPL-225` | **NFR verification.** Measure every p95/p99 target in §5.3.1 under the §5.3.3 V1 load; availability, scalability and observability signals; prove no target is met by caching an authorisation decision or copying another context's data | P1 | `226` | `216`, `221` |
| `IMPL-226` | **Acceptance verification.** An automated test or recorded repeatable procedure for each of `SID-AC-1` … `SID-AC-26`, and one failing-on-violation test per `SID-INV-1` … `SID-INV-14`. The module is not complete at 25 of 26 | **P0** | Release | `220`–`225` |

---

## 2. Sequencing

```
IMPL-200 rank 7.5 tier
   ├── IMPL-207 migrate GlobalStudentProfile out of domain/social   ← existing code
   └── IMPL-201 contracts
          ├── IMPL-208 personId non-nullable (Account, StudentRecord) ← existing code
          └── IMPL-202 Person aggregate
                 ├── IMPL-203 atomic creation ── IMPL-204 lifecycle ── IMPL-214 E-13 ACL *(full BC-01)*
                 ├── IMPL-205 audit
                 ├── IMPL-206 configuration
                 ├── IMPL-210 profile fields ─┬─ IMPL-213 privacy ─┐
                 ├── IMPL-211 username ───────┘                    ├── IMPL-223 search
                 ├── IMPL-212 photo                                 │
                 └── IMPL-221 authorisation                         │
                        IMPL-216 composition ───────────────────────┤
                        IMPL-222 events ────────────────────────────┤
                        IMPL-224 integrity counters ────────────────┤
                        IMPL-220 boundary checker *(IMPL-014)* ─────┤
                        IMPL-225 NFR verification ──────────────────┤
                                                                    └── IMPL-226 acceptance
```

`IMPL-200` is first and non-negotiable. Writing the aggregate before the rank tier exists means the first
import that violates `L2` is discovered by review rather than by the build, which is how boundaries erode.

**`IMPL-207` and `IMPL-208` are the two branches that touch code written before the decision**, and they
are placed early on purpose. `IMPL-207` must precede `IMPL-202`, because building a new `Person` aggregate
in `domain/person` while `GlobalStudentProfile` still lives in `domain/social` would leave the platform
with **two** global identity aggregates — precisely the outcome `SID-5.51` says must be rejected.
`IMPL-208` must precede `IMPL-224`, because an integrity counter asserting that every account has an
identity cannot pass while the field permitting its absence still type-checks.

---

## 3. Traceability

| Task group | Requirements | Invariants | Acceptance |
|---|---|---|---|
| `IMPL-200`–`208` | `SID-1.37`, `SID-1.38`, `SID-2.1`–`2.4`, `SID-2.14`, `SID-4.1`–`4.12`, **`SID-4.17`** | `SID-INV-1`–`3`, `SID-INV-8`, `SID-INV-14` | `SID-AC-1`–`3`, `SID-AC-22`, `SID-AC-23` |
| `IMPL-210`–`216` | `SID-2.7`–`2.9`, `SID-2.22`–`2.30`, `SID-3.2`–`3.34`, `SID-4.35`–`4.37` | `SID-INV-4`, `SID-INV-9`, `SID-INV-10`, `SID-INV-13` | `SID-AC-4`–`13`, `SID-AC-16`, `SID-AC-25` |
| `IMPL-220`–`226` | `SID-4.13`–`4.56`, `SID-5.1`–`5.51` | `SID-INV-5`–`7`, `SID-INV-11`, `SID-INV-12` | `SID-AC-14`–`21`, `SID-AC-24`, `SID-AC-26` |

---

## 4. Definition of Done additions

Beyond the standard gates in [`DEFINITION_OF_DONE.md`](./DEFINITION_OF_DONE.md), a Student Identity task
is not done until:

1. No `StudentRecordId`, `TenantId`, mobile number, OTP, session or credential appears in this module's
   schema, event payloads, logs, metrics or indices — verified by scan, not by inspection.
2. No import of `domain/library/**` or `domain/social/**` exists.
3. Every new configurable value appears in the `SCFG` register with a default and a range.
4. Every role reference is one of `TR-1` … `TR-5` or Platform Administrator.
5. Any acceptance statement written outside `SID-AC-1` … `SID-AC-26` is removed as an editing error.
6. The three integrity counters read zero.
7. Disabling the social product entirely leaves every identity fully usable (`SID-4.31`).
8. No `personId` field is nullable, and no code path treats an absent identity as a valid state — the
   superseded `MP-GBR-02` wording *"degrade gracefully when it is null"* appears nowhere (`IMPL-208`).
9. Exactly **one** global identity aggregate exists in the codebase (`SID-5.51`, `IMPL-207`).
