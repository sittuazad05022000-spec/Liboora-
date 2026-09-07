# Liboora — Implementation Roadmap

| Field | Value |
|---|---|
| **Version** | v1.2 |
| **Status** | Active |
| **Date** | 2026-08-02 · revised 2026-08-03 · **revised 2026-08-04** |
| **Baseline** | BASELINE-2026-08-04 |
| **Scope** | `BC-18` Identity & Access to a releasable state, plus the platform work that blocks it |
| **ADRs applied** | `ADR-0001` … **`ADR-0011`** |

---

## 1. What this roadmap is

An ordered list of implementation tasks with **explicit dependencies**, derived from Authentication PRD v2.0, the
accepted ADRs, and the enterprise documentation audit.

It is ordered by **dependency, not by preference.** Where the order looks inconvenient, the dependency is stated so
the cost of reordering is visible rather than discovered.

**It contains no estimates.** Sequencing and readiness are architectural facts; duration is a team fact.

---

## 2. Phase overview

| Phase | Theme | Exit condition |
|---|---|---|
| **Phase 0** | Foundations — enforce what is already decided | Boundaries mechanically enforced; configuration validated at startup |
| **Phase 1** | Real OTP delivery | A user can receive a code by SMS in a real environment |
| **Phase 2** | Remove demo surfaces | `TASK-D10` closed; `MP-CON-11` satisfied |
| **Phase 3** | Two-stage authentication | `ADR-0004` implemented; `AuthService` split |
| **Phase 4** | Sessions and devices | Chapter 6 implemented; SIM-swap defence live |
| **Phase 5** | Roles and policy | Chapter 7 implemented; tenant isolation enforced |
| **Phase 6** | Lifecycle, events, audit | Chapters 9 and 10 implemented |
| **Phase 7** | NFR and release readiness | Chapter 11 acceptance met |
| **Phase 8** | **Library Management** | Library PRD v1.0 implemented; `IMPL-100`…`IMPL-127` closed |
| **Phase 9** | **Student Identity** | Student Identity PRD v1.0 implemented; `IMPL-200`…`IMPL-226` closed |

**Phases 0–2 are prerequisites for a releasable build of anything.** Phase 2 in particular cannot be skipped or
deferred: the current code cannot lawfully ship.

**Phase 8 is numbered last but does not run last.** Its first task, `IMPL-100` tenant foundation, is a *dependency
of* the tenant-scoped authorization work in Phase 5 — `MP-GBR-08` cannot be enforced against a tenant key that no
table carries. Read the dependency graph in §11, not the phase number, for ordering. The phase number records when
the specification arrived; the graph records what blocks what.

**Phase 9 is the clearest example of that, and the most dangerous to defer.** `ADR-0011` made a Global Person
Identity **mandatory and `1:1` with every account, created in the same transaction**. That is not a Phase 9
behaviour — it is a change to account creation, which is Phase 3 work (`IMPL-031`). Building account creation
without identity creation and adding it in Phase 9 means back-filling an identity for every account that already
exists, and the amended `MP-GBR-02` gives no lawful state in which an account is waiting for one. `IMPL-203` must
land **with** account creation, not after it.

---

## 3. Phase 0 — Foundations

### `IMPL-014` — Module boundary checker ⚠ P1

| | |
|---|---|
| **Blocks** | Nothing directly. **Silently permits everything to break** |
| **Depends on** | Nothing |
| **Files** | `tool/check_module_boundaries.dart` (**does not exist**) |

`tool/module_dependencies.yaml` is present and is the only file in `tool/`. The checker that reads it was never
written. `ADR-0001` declares a modular monolith with enforced boundaries; **without this tool the boundaries are
comments.** Twenty-six permitted edges (`E-01`…`E-26`) and fourteen forbidden edges (`X-01`…`X-14`) are currently
enforced by reviewer memory.

Every phase after this one adds code that can violate a boundary. Each week it does not exist, the eventual cost of
adding it rises, because it will fail on accumulated violations rather than on new ones.

**Requirements.**

| # | Requirement |
|---|---|
| 1 | Parse `tool/module_dependencies.yaml` |
| 2 | Walk `lib/` and `packages/`, resolving every import to an owning module |
| 3 | Fail with a non-zero exit code on any edge not in the permitted set |
| 4 | Name the file, line, and the specific `X-nn` violated |
| 5 | Run in CI on every pull request, blocking merge |
| 6 | Report **all** violations, not the first |

**Acceptance.** Tool exists · runs clean on `main` today **or** existing violations are recorded as accepted
exceptions with expiry dates · a deliberately introduced forbidden import fails the build.

Closes governance task `R-5` and `MP-DEP-06`.

---

### `IMPL-015` — Configuration validation at startup ⚠ P1

| | |
|---|---|
| **Blocks** | Safe operation of every security control |
| **Depends on** | Nothing |
| **Reference** | `CONFIGURATION_GUIDE.md` §3 |

`CFG-1`…`CFG-12` are configurable. Nothing currently validates them. A deployment can set a staff idle timeout of
30 days and no part of the system will object.

Implement invariants `INV-1` … `INV-9`. Validation runs at application startup **in every environment**, reports
**all** violations at once, and **refuses to start** on any violation.

**A silently misconfigured security control is worse than a missing one** — the dashboard says it is enabled.

**Acceptance.** All nine invariants implemented · violation prevents startup with a complete, readable message ·
unit-tested for each invariant · development profile passes with its relaxed values.

---

### `IMPL-016` — Configuration surface

| | |
|---|---|
| **Depends on** | `IMPL-015` |

Expose `CFG-1`…`CFG-12` as typed, injected configuration. Values come from environment configuration, never from
literals scattered through call sites.

**No structural fact from PRD §F may be exposed** — code length, validity, attempt count, single-use, one
challenge per number, sole factor, one active library. Exposing one is a defect.

**Acceptance.** No `CFG` value appears as a literal outside the configuration module · no structural fact is
configurable · profiles for development, staging and production match `CONFIGURATION_GUIDE.md` §4.

---

## 4. Phase 1 — Real OTP delivery

### `IMPL-020` — SMS provider integration ⚠ P0

| | |
|---|---|
| **Blocks** | **`TASK-D10`, and therefore every release** |
| **Depends on** | `IMPL-016` |
| **Reference** | `MP-DEP-03`, Chapter 8, `AUTH-11.51` |

The single highest-leverage item in this roadmap. Until a code can actually reach a phone, the demo surfaces
cannot be removed, and while they exist nothing can ship.

**Requirements.**

| # | Requirement |
|---|---|
| 1 | DLT-registered transactional template (Indian TRAI regime) |
| 2 | Provider abstracted behind an interface — swappable per `AUTH-11.51` |
| 3 | Delivery failure surfaces as `AERR-*`, never as a wrong-code error |
| 4 | Development sink writes the code to **server logs only**, never to any client response |
| 5 | Test sink is a fake gateway in `test/`, supporting `TASK-D10` D10-8 |
| 6 | Cost and delivery-rate metrics emitted per `CONFIGURATION_GUIDE.md` §6 |

**Requirement 4 is the one that matters.** If the development sink returns the code to the client, `D-10` has been
recreated under a new name.

**Acceptance.** A real SMS arrives in staging · provider swap needs no change outside the adapter · development
codes appear in server logs and nowhere else · fake gateway available to tests.

---

### `IMPL-021` — Rate limiting

| | |
|---|---|
| **Depends on** | `IMPL-016`, `IMPL-020` |
| **Reference** | `AUTH-8.16`–`AUTH-8.23` |

Implement `CFG-1`, `CFG-2`, `CFG-3`, `CFG-4`.

**`CFG-3` requires care.** The origin must be the true client address, not a proxy or CDN address. Getting this
wrong puts every user in one bucket and takes the platform down. See `CONFIGURATION_GUIDE.md` `CFG-3` deployment
note.

**Acceptance.** Per-number and per-origin limits enforced · lock self-clears without intervention · a simulated
NAT gateway with 60 clients does not lock out · metrics emitted.

---

## 5. Phase 2 — Remove demo surfaces

### `TASK-D10` — Remove demo and debug authentication surfaces ⚠ P0 release blocker

| | |
|---|---|
| **Blocks** | **Every release** |
| **Depends on** | `IMPL-020` (except step D10-4, which depends on nothing) |
| **Detail** | [`TASK-D10-remove-demo-surfaces.md`](./TASK-D10-remove-demo-surfaces.md) |

Three surfaces across five files. **Step D10-4 — deleting the OTP auto-fill line — depends on nothing and should
be done immediately**, ahead of this phase.

**Acceptance.** As specified in the task. Release **and profile** artefacts grepped clean.

---

## 6. Phase 3 — Two-stage authentication

### `IMPL-030` — Split `AuthService` verification

| | |
|---|---|
| **Depends on** | `IMPL-020` |
| **Reference** | `ADR-0004`, Chapters 4 and 6 |

Replace `verifyOtp → AuthSession?` with two stages. Stage 1 yields a verified `Account`. Stage 2 issues a
`Session` once an authorization context exists.

**"Authenticated, no library" must be representable** in the model, the API, and the UI. It is a normal state, not
an error.

**Breaking change**, in scope by `ADR-0004`. No other API changes.

**Acceptance.** Two stages exist · a user with no role reaches a meaningful screen, not an error · conformance
tests updated · no other public API modified.

---

### `IMPL-031` — Account creation and display name

| | |
|---|---|
| **Depends on** | `IMPL-030` |
| **Reference** | `ADR-0005`, `ADR-0006` |

Account created **only** on first successful verification, only by `BC-18`, idempotent per number. Display name
collected before verification, required and non-nullable, with the three machine-detectable prohibitions enforced
at creation. An existing account's name is never rewritten by a later sign-in.

**Acceptance.** No other module can create an `Account` (enforced by `IMPL-014`) · empty, whitespace-only and
mobile-number names refused · re-verification does not overwrite a stored name.

---

## 7. Phase 4 — Sessions and devices

### `IMPL-040` — Session lifecycle

| | |
|---|---|
| **Depends on** | `IMPL-030`, `IMPL-016` |
| **Reference** | Chapter 6, `MP-GBR-26` |

Idle and absolute timeouts per `CFG-5`/`CFG-6` with distinct staff and mobile values. Exactly one active library
per session; switching is a scope change, never re-authentication.

**`MP-GBR-26` is unusually strict:** revocation is *"immediate and global — authoritative-or-absent, with no
propagation window."* A cached authorisation decision that outlives revocation violates it. This constrains
caching platform-wide and must be designed for, not retrofitted.

**Acceptance.** Both timeouts fire correctly per audience · revocation is immediate with no cached grace · exactly
one active library enforced.

---

### `IMPL-041` — Device management ⚠ security-critical

| | |
|---|---|
| **Depends on** | `IMPL-040` |
| **Reference** | Chapter 6, `AUTH-8.41`–`8.47`, `ADR-0002` |

**This is V1, not V2.** The Enterprise Architecture previously tagged it V2; that was corrected in EA v2.1 because
it is wrong in a way that matters.

In a single-factor system, **SIM swap defeats authentication completely.** Unrecognised-device notification
(`EV-16`) is the *only* compensating control. Shipping V1 without device management means shipping with **no
account-takeover detection at all.**

Device registration, trust (`CFG-7`), the device limit (`CFG-8`, user chooses what to remove — never silent
eviction), and unrecognised-device notification.

**Acceptance.** Devices registered and listed · trust expires at `CFG-7` · limit reached prompts user choice ·
**`EV-16` fires on every unrecognised device** · users can revoke a device remotely.

---

## 8. Phase 5 — Roles and policy

### `IMPL-050` — Roles and permissions

| | |
|---|---|
| **Depends on** | `IMPL-030` |
| **Reference** | Chapter 7, `ADR-0003` |

Tenant-scoped role assignment against a global account. `AccessPolicy` always evaluated with a tenant in scope.

**Acceptance.** No policy decision without a tenant · roles scoped per tenant · a user's roles in one library have
no effect in another.

---

### `IMPL-051` — Support elevation

| | |
|---|---|
| **Depends on** | `IMPL-050`, `IMPL-016` |
| **Reference** | `AUTH-7.19`, `CFG-12` |

Time-boxed (`CFG-12` = 1 hour), consented, fully audited. Expiry automatic.

**Every elevation is alertable — not sampled.** This is the highest-privilege state in the platform.

**Acceptance.** Elevation expires automatically · consent recorded · every elevation emits an alertable audit
event with actor, tenant, duration and consent reference.

---

### `IMPL-052` — Tenant isolation verification

| | |
|---|---|
| **Depends on** | `IMPL-050` |
| **Reference** | `MP-GBR-08`, `SE-1`, `X-13` |

Every tenant-scoped query carries a tenant key. A tenant-less query on tenant data is a **blocker-severity**
defect.

**Acceptance.** Automated test attempts cross-tenant access on every tenant-scoped read and is refused every time.

---

## 9. Phase 6 — Lifecycle, events, audit

### `IMPL-060` — Account lifecycle

| | |
|---|---|
| **Depends on** | `IMPL-031` |
| **Reference** | Chapter 9 |

Eight states. **Both** the valid and the invalid transition tables are normative — invalid transitions must be
actively refused, not merely absent.

`CFG-9` pending retention, `CFG-10` soft-delete retention. A soft-deleted account cannot authenticate.

**Acceptance.** All valid transitions work · **every invalid transition is refused** · retention timers fire.

---

### `IMPL-061` — Events

| | |
|---|---|
| **Depends on** | `IMPL-060`, `IMPL-041` |
| **Reference** | Chapter 10, `EV-1`…`EV-26` |

All twenty-six events with correct producers and consumers.

**Acceptance.** Every event emitted at its specified trigger · `EV-16` verified end-to-end (Phase 4 dependency).

---

### `IMPL-062` — Audit trail

| | |
|---|---|
| **Depends on** | `IMPL-061` |
| **Reference** | Chapter 10 `AU-1`…`AU-9` |

Append-only. **No authentication or authorization event may be unlogged.**

**Acceptance.** Audit is append-only and tamper-evident · no gaps under load · retention meets Chapter 11.

---

## 10. Phase 7 — Release readiness

### `IMPL-070` — NFR verification

| | |
|---|---|
| **Depends on** | All prior |
| **Reference** | Chapter 11 §§11.2–11.5 |

Latency table (8 rows), availability targets, scalability envelope, observability.

### `IMPL-071` — Compliance verification

| | |
|---|---|
| **Reference** | §11.6 |

DPDP, minors' consent, DLT/TRAI, data localisation. **Minors are a large share of the student population** — the
consent path is not an edge case.

### `IMPL-072` — Error classification

| | |
|---|---|
| **Reference** | §11.7 `AERR-1`…`AERR-13` |

Closed set. **Every** authentication failure maps to exactly one `AERR-n`. An unmapped error is a defect.

### `IMPL-073` — Final acceptance

| | |
|---|---|
| **Reference** | `AC-11.1`…`AC-11.37`, `DEFINITION_OF_DONE.md` |

**No emergency bypass (`AUTH-11.53`), no break-glass (`AUTH-11.54`).** Any mechanism proposed under either name
during hardening is out of specification.

---

## 10A. Phase 8 — Library Management

Twenty-three tasks, specified in full in
[`LIBRARY_IMPLEMENTATION_TASKS.md`](./LIBRARY_IMPLEMENTATION_TASKS.md). Not restated here — that document carries
the acceptance criteria, developer checklists and the traps for each one. Summary only:

| Group | Tasks | P0 | Theme |
|---|---|---|---|
| Library core | `IMPL-100` … `IMPL-109` | 4 | Tenancy, lifecycle, profile, structure, hours, facilities, settings, policies, branding |
| Invitations | `IMPL-110` … `IMPL-114` | 4 | Artefact core, lifecycle, `IT-1` staff, `IT-2`/`IT-3` private, rate limiting |
| Public surfaces | `IMPL-120` … `IMPL-127` | 4 | Projection, preview, search, protected-operation gate, intent, rate limiting, events, config validation |

**Exit condition.** All twelve module-P0 tasks closed; `LAC-1`…`LAC-12`, `LAC-14B-1`…`LAC-14B-16` and
`IAC-1`…`IAC-25` verified by automated tests; `LCFG-1`…`LCFG-13` and `ICFG-1`…`ICFG-10` validated at startup.

**The one thing most likely to be got wrong.** `IMPL-123`, the protected-operation gate, is not an authentication
check. Authentication proves *who is calling*; the gate additionally requires *authorisation for this library*
(`LIB-14B.29`). A gate that admits any authenticated user has implemented half of it and will pass every test
written by whoever implemented it.

---

## 10B. Phase 9 — Student Identity

Twenty-five tasks, specified in full in
[`STUDENT_IDENTITY_IMPLEMENTATION_TASKS.md`](./STUDENT_IDENTITY_IMPLEMENTATION_TASKS.md). Not restated here.
Summary only:

| Group | Tasks | P0 | Theme |
|---|---|---|---|
| Architecture & foundation | `IMPL-200` … `IMPL-208` | 8 | Rank 7.5 tier, contracts, `Person` aggregate, atomic creation, lifecycle, audit, configuration, **and two migrations of existing scaffold code** |
| Profile & identity behaviour | `IMPL-210` … `IMPL-216` | 4 | Profile fields, username uniqueness, Global Profile Photo, privacy, timeline, `E-13` ACL, aggregated composition |
| Boundary, security & verification | `IMPL-220` … `IMPL-226` | 5 | Boundary enforcement, authorisation, events, search indexing, integrity counters, NFR, acceptance |

**Exit condition.** All seventeen module-P0 tasks closed; `SID-AC-1`…`SID-AC-26` verified by automated tests;
one failing-on-violation test per `SID-INV-1`…`SID-INV-14`; `SCFG-1`…`SCFG-11` validated at startup; the three
integrity counters reading zero.

**This phase is a migration, not a greenfield build**, and that is its defining property. Identity code already
exists — committed in `a44ebb0` — and all of it implements the **superseded** pre-`ADR-0011` model: a nullable,
opt-in `PersonId` owned by `domain/social`. `IMPL-207` relocates `GlobalStudentProfile` out of `domain/social`;
`IMPL-208` makes `Account.personId` and `StudentRecord.personId` non-nullable. Both are P0 and both come early,
because building `domain/person` while `GlobalStudentProfile` still lives in `domain/social` would leave **two**
global identity aggregates in the codebase — the exact outcome `SID-5.51` requires to be rejected. Full record in
[`TRACEABILITY_MATRIX.md`](./TRACEABILITY_MATRIX.md) §8A and
[`STUDENT_IDENTITY_ALIGNMENT.md`](../30-product/student-identity/STUDENT_IDENTITY_ALIGNMENT.md) §8A.

**The one thing most likely to be got wrong.** `SEV-1` `PersonIdentityCreated` looks like the trigger for identity
creation and is not. Creation is **synchronous and transactional** with account creation; `SEV-1` is *"a
notification of a completed fact"* (`SID-4.11`, `SID-4.12`). Wiring creation to the event opens a window in which
an account exists without an identity — which the amended `MP-GBR-02` forbids — and it is the natural mistake for
a developer correctly following the event-driven architecture everywhere else in the platform.

**The second most likely.** Treating Global Person Identity as a social feature and gating it behind social opt-in.
It is `[CORE]`, it is the permanent identity for the whole education ecosystem, and Student Network is only one of
its consumers. `SID-4.31` states the falsifiable test: **deactivating, disabling or never launching the social
product must not affect the existence, validity or usability of any identity.** `IMPL-226` requires a test for it.

---

## 11. Dependency graph

```
IMPL-014 ─────────────────────────────► (gates all merges)
IMPL-015 ──► IMPL-016 ──► IMPL-020 ──┬──► IMPL-021
                                     │
                                     ├──► TASK-D10 ──► releasable
                                     │
                                     └──► IMPL-030 ──┬──► IMPL-031 ──► IMPL-060 ──► IMPL-061 ──► IMPL-062
                                                     │                                              │
                                                     ├──► IMPL-040 ──► IMPL-041 ────────────────────┤
                                                     │                                              │
                                                     └──► IMPL-050 ──┬──► IMPL-051                  │
                                                                     └──► IMPL-052                  │
                                                                                                    ▼
                                                                                        IMPL-070..073
```

### 11.1 Phase 8 — Library Management

```
IMPL-100 (tenant foundation) ──┬──► IMPL-101 ──► IMPL-102 ──┐
   │                           │                            │
   │                           ├──► IMPL-104 ──► IMPL-105 ───┤
   │                           │        └──────► IMPL-106 ───┤
   │                           │                            │
   │                           ├──► IMPL-107, 108, 109       │
   │                           │                            ▼
   │                           └──► IMPL-126           IMPL-120 (public projection)
   │                                                        │
   └──► IMPL-103 (audit) ──► IMPL-110 ──► IMPL-111 ──┐      ├──► IMPL-121 preview
                                │                     │      ├──► IMPL-122 search
                                │                     ├──────┼──► IMPL-123 PO gate ──► IMPL-124 intent
                                │                     │      │
                                └──► IMPL-114         └──► IMPL-112 (IT-1) ◄── IMPL-020 (SMS)
                                                           IMPL-113 (IT-2/IT-3)

IMPL-125 ◄── IMPL-021        IMPL-127 ◄── IMPL-015
```

**Library critical path:** `IMPL-100` → `IMPL-101` → `IMPL-102` → `IMPL-120` → `IMPL-123` → `IMPL-124`.
Everything public depends on the projection, and the projection depends on there being a library to project.

**`IMPL-112` staff invitation additionally waits on `IMPL-020`.** An `IT-1` invitation is delivered by SMS, so it
inherits the DLT registration dependency. **DLT approval is a multi-week external process and should be started
first**, before any Library code — even though `IMPL-020` is not a Library task. It is the single longest lead time
in the whole programme and nothing else on it is under our control.

**Critical path:** `IMPL-015` → `IMPL-016` → `IMPL-020` → `TASK-D10`. Nothing releases until it completes.

**Start `IMPL-014` immediately and in parallel.** It gates merges; every day without it accumulates violations.

**Do `TASK-D10` step D10-4 today.** One line, no dependencies, closes a live authentication bypass.

**Start `IMPL-100` early.** Tenant-key enforcement under `MP-GBR-08` is cheap to build into a schema and expensive
to add to one. Every table created before it exists is a table that will need migrating.

### 11.2 Student Identity dependencies

```
IMPL-200 rank 7.5 tier ─┬─► IMPL-207 migrate GlobalStudentProfile out of domain/social
                        └─► IMPL-201 contracts ─┬─► IMPL-208 personId non-nullable
                                                └─► IMPL-202 Person aggregate ─► IMPL-203 atomic creation
                                                                                      │
IMPL-031 account creation (Phase 3) ══════════════════════════════════════════════════╡  same transaction
                                                                                      │
IMPL-014 boundary checker (Phase 0) ═════════════════► IMPL-220 boundary enforcement  │
                                                                                      ▼
                                                       IMPL-224 integrity counters ─► IMPL-226 acceptance
```

**Student Identity critical path:** `IMPL-200` → `IMPL-201` → `IMPL-202` → `IMPL-203` → `IMPL-224` → `IMPL-226`.

**`IMPL-203` is coupled to `IMPL-031`, and this is the cross-phase dependency that will be missed.** Account
creation and identity creation are a single transaction (`SID-4.11`). They cannot be built in different phases by
different people and joined later, because there is no lawful intermediate state to join them in.

**`IMPL-220` waits on `IMPL-014`**, which does not exist. Until it does, every `SID-INT-1`…`SID-INT-12` rule is
review-verified and **counted as unmet, not satisfied by intent** (`SID-4.56`). The rank-7.5 boundary is currently
*declared and unenforced*, which reads as protection and is not.

**`IMPL-214` `E-13` is partly blocked.** A `StudentRecord` aggregate exists, so `IMPL-208` can tighten the field
now; the full `BC-01` does not, so the ACL cannot be verified end to end.

---

## 12. Blocked — not on the critical path

| Item | Blocked by | Priority |
|---|---|---|
| ~~Library module beyond §14A~~ | ~~Library PRD §§1–25 never supplied~~ → ✅ **UNBLOCKED 2026-08-03.** Specification received; see Phase 8 | — |
| ~~Private-library invitations~~ | ~~Invitation security spec (`AR-4`) never written~~ → ✅ **UNBLOCKED 2026-08-03.** All six properties specified in `INVITATION_SECURITY_SPECIFICATION.md`; `ADR-0009` accepted | — |
| Public Live Occupancy | **V2.** Deferred pending a privacy review. V1 exposes a coarse indicator only (`LIB-14B.12`) | P3 |
| Reviews & Ratings | **V2.** No bounded context assigned; assigning one is an architecture change requiring an ADR | P3 |
| Multi-Branch operation | **V3** per Master PRD §32. `branchId` is nonetheless modelled in V1 (`IMPL-104`) — retrofitting it later is a migration across every core table | P3 |
| Development Standards (`R-4`) | Deferred | P3 |
| `D-8`, `D-9`, `R-5` | Carried forward | P2 |
| ~~Global Student Identity cardinality (`Q-05`)~~ | ~~Open question: is it available to a person with no enrollment?~~ → ✅ **CLOSED 2026-08-04.** `ADR-0011`: yes, necessarily — the identity exists from account creation, so the question cannot arise | — |
| Student Network — `BC-11`…`BC-17` | **`MP-FUT-01`.** Deferred as a product, **not** as an identity. `BC-10` ships in V1 independently; the social product is only a consumer of it (`SID-4.31`) | P3 |
| School / College / Coaching Student Records | **`MP-FUT-02`…`MP-FUT-04`.** Each adds a Student Record type under the same `PersonId`. No second identity is permitted — `SID-5.51` | P3 |

**Two long-standing blocks cleared on 2026-08-03.** `AR-4` said *"do not invent"*, and nothing was invented — the
deferral was lifted only after §§1–25 arrived and confirmed which invitation forms actually exist. Anything the
source did not describe is recorded as an explicit exclusion (`INV-XC-1`…`INV-XC-7`) rather than filled in.

**What replaced them is not smaller.** Twenty-three Library tasks are now open, twelve at P0 within the module.
A specification is not an implementation, and the roadmap says so in the same place it used to say the
specification was missing.

---

## 13. References

`DOCUMENTATION_BASELINE.md` · **`ADR-0001`…`ADR-0011`** · Authentication PRD v2.0 ·
`CONFIGURATION_GUIDE.md` · `TASK-D10-remove-demo-surfaces.md` · `DEFINITION_OF_DONE.md` v1.2 ·
`DOCUMENTATION_AUDIT-001.md` findings `G-4`, `R-F` · Library PRD v1.0 · `LIBRARY_IMPLEMENTATION_TASKS.md` ·
`ADR-0009`, `ADR-0010` ·
[`Student_Identity_PRD_v1.md`](../30-product/student-identity/Student_Identity_PRD_v1.md) v1.0 ·
[`STUDENT_IDENTITY_IMPLEMENTATION_TASKS.md`](./STUDENT_IDENTITY_IMPLEMENTATION_TASKS.md) ·
[`ADR-0011`](../00-governance/adr/ADR-0011-global-person-identity.md)

---

## 14. Change history

| Version | Date | Change |
|---|---|---|
| **v1.2** | 2026-08-04 | Added **Phase 9 — Student Identity** (§10B, 25 tasks) and its dependency graph (§11.2). Recorded the cross-phase coupling that matters most: **`IMPL-203` identity creation is in the same transaction as `IMPL-031` account creation** (Phase 3), so `ADR-0011` cannot be deferred to Phase 9 without leaving accounts that the amended `MP-GBR-02` gives no lawful state for. Recorded that Phase 9 is a **migration** — `IMPL-207` and `IMPL-208` change scaffold code that implements the superseded model. Closed `Q-05` in §12; added the Student Network and School/College/Coaching deferrals, noting the social product is deferred **as a product, not as an identity**. Baseline raised to `BASELINE-2026-08-04`; ADR range to `ADR-0011`. No existing task was renumbered, reprioritised or removed. |
| **v1.1** | 2026-08-03 | Added **Phase 8 — Library Management** (§10A) and its dependency graph (§11.1). Cleared two long-standing blocks in §12 — Library §§1–25 and the `AR-4` invitation deferral — and replaced them with the V2/V3 deferrals that genuinely remain. Recorded that `IMPL-020` DLT registration is now also on the Library critical path via `IMPL-112`, and that it has the longest external lead time in the programme. Baseline reference raised to `BASELINE-2026-08-03`. No existing task was renumbered, reprioritised or removed. |
| v1.0 | 2026-08-02 | Created. Phases 0–7, `IMPL-014`…`IMPL-073`, `TASK-D10`. Closes audit finding `G-4`. |
