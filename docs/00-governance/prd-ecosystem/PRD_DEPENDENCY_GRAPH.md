# LIBOORA — PRD Dependency Graph

| Field | Value |
|---|---|
| **Document** | PRD Dependency Graph — which PRDs depend on which, and why |
| **Version** | v1.0 |
| **Status** | Active |
| **Date** | 2026-08-04 |
| **Baseline** | `BASELINE-2026-08-04` |
| **Authority** | **Derived. Non-normative.** Every edge below is read from the Bounded Context Map §7 integration table, the Master PRD, or an accepted ADR. This document **adds no edge of its own** |
| **Companion** | [`PRD_REGISTRY.md`](./PRD_REGISTRY.md) — the PRD identities used here |

---

## 1. Scope, and the rule that constrains this document

The Bounded Context Map §7 opens with a sentence that governs everything below:

> *"Every edge that crosses a context boundary in V1. If an edge is not in this table, it **does not exist** and
> adding it requires an ADR."*

A PRD-level dependency graph is therefore **not free to invent relationships.** Every edge here is a projection of
an existing `E-nn` integration edge, a domain event, or an explicit Master PRD dependency, onto the PRD identities
in the registry. Where a PRD pair has no architectural edge, this document records **no edge**, even where one
might seem natural.

**This is not the module dependency graph.** That is
[`DEPENDENCY_GRAPH.md`](../../10-architecture/DEPENDENCY_GRAPH.md) (as-built code) governed by
[`LIBOORA_MODULE_DEPENDENCY_MATRIX.md`](../../10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md) (the rules).
Those constrain *imports*. This one describes *specification* dependencies: which PRD cannot be written, or cannot
be correctly implemented, until another exists.

---

## 2. Dependency types

| Type | Meaning | Consequence if ignored |
|---|---|---|
| **`SPEC`** | B cannot be *written* correctly until A exists — A defines terms, identifiers or ownership B must reference | B invents a definition; two sources of truth |
| **`ARCH`** | B's architecture is constrained by a decision recorded in A | B is built at the wrong rank or with the wrong owner |
| **`DATA`** | B holds or resolves an identifier owned by A | Duplicated aggregate, or a foreign key to nothing |
| **`API`** | B calls a synchronous port owned by A | B re-implements A's logic |
| **`EVENT`** | B consumes a domain event published by A | Silent staleness; B's state drifts |
| **`SEC`** | B relies on A for an authorisation, authentication or safety decision | **B decides for itself — a security defect, not a coupling defect** |
| **`BIZ`** | B's business rules are conditioned on A's | Rules contradict; whichever ships last wins by accident |

`SEC` is separated from `API` deliberately. `X-13` forbids any module from evaluating, granting or caching an
authorisation decision it does not own, and the Master PRD §31.1 warns that the cheapest reading of `LIB-14B.29`
leads exactly there — *"That would be wrong, and it would pass its own tests."*

---

## 3. The graph — existing PRDs

```
                         PRD-000  Master PRD
                         (MP-GBR-*, MP-CON-*, MP-DEP-*)
                                    │  SPEC — global rules bind every PRD
              ┌─────────────────────┼─────────────────────┐
              ▼                     ▼                     ▼
      PRD-001 Authentication   PRD-003 Student      PRD-002 Library
           BC-18                 Identity BC-10        Management
              │                   rank 7.5            BC-19/06/25/29
              │                     ▲                     │
              │   E-12  ARCH+DATA   │                     │
              └─────────────────────┘                     │
              │   atomic, same transaction (ADR-0011)     │
              │                                           │
              │   SEC — every authorisation decision      │
              └──────────────────────────────────────────►│
                                                          │
                              E-13  DATA+API  (the ACL)   │
                    PRD-003 ◄─────────────────────────────┘
                              non-nullable personId
```

### 3.1 Edge detail

| # | From (depends) | On | Type | Architectural source | What breaks if reversed or dropped |
|---|---|---|---|---|---|
| **D-01** | `PRD-001` | `PRD-000` | `SPEC` | Rank 1 global rules | Authentication contradicts a platform rule |
| **D-02** | `PRD-002` | `PRD-000` | `SPEC` | Rank 1 global rules | Library contradicts a platform rule |
| **D-03** | `PRD-003` | `PRD-000` | `SPEC`, `BIZ` | **Amended `MP-GBR-02`** (`ADR-0011`) | Identity treated as optional — the superseded model |
| **D-04** | `PRD-003` | `PRD-001` | `ARCH`, `DATA` | **`E-12`** — sync port, *same transaction* | An account exists without an identity. The amended `MP-GBR-02` gives that state **no lawful representation** |
| **D-05** | `PRD-002` | `PRD-003` | `DATA`, `API` | **`E-13`** — the ACL, *"the only bridge between the two worlds"* | `BC-01` cannot resolve a person; a nullable `personId` reappears |
| **D-06** | `PRD-002` | `PRD-001` | **`SEC`** | `LIB-14B.29`, `PO-1`…`PO-12`, `X-13` | **Library evaluates authorisation itself — an `X-13` violation that passes its own tests** |

### 3.2 Two edges that are commonly assumed and do not exist

| Assumed edge | Reality |
|---|---|
| `PRD-003` → `PRD-002` | **Does not exist.** `BC-10` holds **no** `StudentRecordId` and **no** `tenantId` (`ID-2`, `SID-4.19`). The reference is *"upward only — the identity holds no list of records"* (`E-13`). A rank-7.5 module importing rank 8 would violate `L2` and `X-05` |
| `PRD-003` → social contexts | **Inverted.** `BC-11`…`BC-13` are **consumers** of `BC-10`, never owners (`ADR-0011`). `SID-4.31` is the falsifiable test: *"deactivating, disabling or never launching the social product must not affect the existence, validity or usability of any identity"* |

**`D-04` is the highest-consequence edge in the graph.** `IMPL-203` must land *with* account creation
(`IMPL-031`), not after it. The Implementation Roadmap §2 states the cost of getting this wrong: deferring it
means *"back-filling an identity for every account that already exists"*, into a model with no lawful waiting
state.

---

## 4. Edges from existing PRDs to unwritten ones

These edges exist **architecturally today** and are satisfied by nothing, because the downstream PRD is
unwritten. Each is a live risk, not a future one.

| # | Consumer | Provider | Type | Source | Status today |
|---|---|---|---|---|---|
| **D-07** | `PRD-002` | `PRD-013` `BC-19` Tenancy | `ARCH`, `DATA` | `E-18` ambient `TenantContext` | **Partly self-satisfied** — `PRD-002` *owns* `BC-19` |
| **D-08** | All write paths | `PRD-014` `BC-21` Entitlement | `API` | `E-17` — called **before** the aggregate mutates | **Unsatisfied** — no specification |
| **D-09** | `PRD-002`, `PRD-003` | `PRD-016` `BC-24` Audit | `EVENT` | `E-20` outbox-backed, fire-and-forget | **Unsatisfied.** `X-10` audit-mutation check **not implemented** — unmet per `SID-4.56` |
| **D-10** | `PRD-003`, `PRD-004` | `PRD-015` `BC-23` Search | `EVENT` | `E-21` | **Unsatisfied.** ⚠ see §4.1 |
| **D-11** | `PRD-003`, `PRD-004` | `PRD-017` `BC-29` File & Media | `API` | `E-22` `FileRef`, never bytes | **Owner exists** (`PRD-002` owns `BC-29`); ⚠ see §4.1 |
| **D-12** | All | `PRD-010` `BC-22` Notification | `EVENT` | `E-23` — domain emits *facts*, never *"send an SMS"* | **Unsatisfied** |
| **D-13** | `PRD-006` | `PRD-018` `BC-30` Offline Sync | `API` | `E-24` — Attendance defines policy, Sync executes | Both unwritten |
| **D-14** | `PRD-008`/`PRD-020` | `PRD-019` `BC-31` Integration | `API` | `E-25` | Both unwritten |
| **D-15** | `PRD-011` | `PRD-009`, `PRD-015` | `API` | `E-26` — permission-aware ports only | Both unwritten |
| **D-16** | `PRD-021` | `PRD-020` `BC-13` Trust & Safety | `EVENT`, `SEC` | `E-14` `EnforcementActionTaken` | **Unsatisfied — `MP-RSK-02` is Critical** |
| **D-17** | `PRD-002` | `PRD-001` + `PRD-013` | `SEC` | `ADR-0009` — invitation is a revocable claim | Partly satisfied |

### 4.1 A finding: `E-21` and `E-22` do not list `BC-10`

Verified against the Bounded Context Map §7.3, quoted exactly:

| # | Consumer | Provider |
|---|---|---|
| `E-21` | **`BC-01`, `BC-10`** | `BC-23` Search Indexing |
| `E-22` | **`BC-01`, `BC-14`** | `BC-29` File & Media |

`E-21` lists `BC-10`. **`E-22` does not.** Yet `Student_Identity_PRD_v1.md` §4.8 is headed *"File & Media —
`BC-29` (`E-22`)"* and `SID-4.35` requires the Global Profile Photo to be *"held as a `FileRef` issued by
`BC-29`"*.

So `PRD-003` cites an edge whose consumer list omits it. Per §7's own rule — *"if an edge is not in this table,
it does not exist and adding it requires an ADR"* — this is a **documentation defect in one of the two
documents**, and it is not recorded in `STUDENT_IDENTITY_ALIGNMENT.md` (searched: zero occurrences of `E-22`).

**This document does not resolve it**, because resolving it means editing a frozen document, which Request G
forbids and `DOCUMENTATION_BASELINE.md` §7 gates behind an ADR. Raised as `PGA-02` in
[`PRD_GAP_ANALYSIS.md`](./PRD_GAP_ANALYSIS.md) §4.

The benign reading is that `E-22`'s list was written before `ADR-0011` and never extended. That is probably
right — and *"probably right"* is exactly the standard §7 exists to refuse.

---

## 5. Event-driven edges

From the Bounded Context Map domain-event register. Events are **facts already committed**, never instructions —
a distinction `SID-4.11`/`4.12` make load-bearing.

| Publisher | Events | Consumers |
|---|---|---|
| `BC-01` Enrollment (`PRD-004`) | `StudentEnrolled` · `StudentProfileUpdated` · `StudentStatusChanged` · **`StudentLinkedToPerson`** | `BC-02` (`E-01`), `BC-05` (`E-09`), `BC-23` (`E-21`), `BC-10` via ACL |
| `BC-02` Membership (`PRD-005`) | 5 membership events | `BC-04` (`E-02`), `BC-03` (`E-03`), `BC-05` (`E-07`) |
| `BC-03` Attendance (`PRD-006`) | 4 attendance events | `BC-04` (`E-08`) — **Seating owns occupancy; Attendance is the trigger** |
| `BC-05` Fee (`PRD-008`) | fee events | `BC-02` (`E-10`) |
| `BC-06` Policy (`PRD-002`) | `policy.BranchPolicyChanged` | `BC-03`, `BC-04`, `BC-05` (`E-04`…`E-06`) |
| **`BC-10`** (`PRD-003`) | `SEV-1` `PersonIdentityCreated` · `SEV-3` · `SEV-5` · `SEV-9` · `SEV-16` `PersonAnonymised` | `BC-23`, `BC-24`; social contexts as consumers |
| `BC-13` T&S (`PRD-020`) | `EnforcementActionTaken` | `BC-11`, `BC-12`, `BC-14`, `BC-15` self-restrict (`E-14`) |
| `BC-18` (`PRD-001`) | `iam.AccountErased` · `iam.MobileNumberChanged` · `iam.AccountSuspended` | `BC-10` (`IMPL-222`) |

> **`PRD-004` was drafted on 2026-08-04 and added no edge to this graph.** Verified by comparing its declared
> integrations against this table: `E-01`, `E-09`, `E-11`, `E-13`, `E-21`, `E-22` were **all already present**,
> and the four `BC-01` events above were already listed here **before** `PRD-004` existed. `SM-EV-1`…`SM-EV-9`
> name the same facts plus guardian, document, archive, restore and contact events on existing edges. This matters
> because BC Map line 292 states: *"If an edge is not in this table, it does not exist and adding it requires an
> ADR."* Drafting a PRD is the moment an unauthorised edge would normally appear; none did, so **no ADR was
> required and no row here changed**. `D-10` and `D-11` remain **Unsatisfied** — `PRD-004` consumes `BC-23` and
> `BC-29`, whose specifications are still unwritten.

**`SEV-1` is the trap.** It looks like the trigger for identity creation and is not — creation is *synchronous
and transactional*; `SEV-1` is *"a notification of a completed fact"*. Wiring creation to the event opens a
window in which an account has no identity, which the amended `MP-GBR-02` forbids. The Implementation Roadmap
§10B calls this *"the natural mistake for a developer correctly following the event-driven architecture
everywhere else in the platform"* — which is why it belongs in a dependency graph rather than only in a task list.

---

## 6. Dependency depth

Longest specification chain among **existing** PRDs:

```
PRD-000 ──► PRD-001 ──► PRD-003 ──► PRD-002
Master      Auth        Identity     Library
            (D-01)      (D-04, E-12) (D-05, E-13)
```

**Depth 4. No cycles.** Verified by inspection of §3.1 and §4 — every edge points from a higher-rank consumer to
a lower-rank provider, matching law `L1` (acyclic, *"the one law with zero exceptions"*).

The apparent `PRD-002` ⟷ `PRD-003` cycle is not one: `PRD-002` → `PRD-003` is `D-05` (`E-13`, resolve an
identity), and there is **no** return edge — `BC-10` holds no `StudentRecordId` and no `tenantId`. The
`ADR-0011` rank-7.5 decision exists precisely to make this direction lawful; §94 of the Dependency Matrix records
that a same-rank `BC-10` would have been *"the precise shape `X-05` prohibits."*

---

## 7. What a new PRD must check before claiming a dependency

1. Does the edge appear in Bounded Context Map §7? **If not, it does not exist** — an ADR is required first.
2. Is it downward by rank? A rank-7.5 module may not depend on rank 8.
3. Is it `SEC`? Then the consumer states *what must be true* and the owner decides *how* — `X-13`.
4. Is it `EVENT`? Then it is asynchronous, at-least-once, idempotent, and carries **no** credential, OTP, mobile
   number or parent contact.
5. Does it duplicate data another context owns? Read a projection; never store it.

---

## 8. References

[`LIBOORA_BOUNDED_CONTEXT_MAP.md`](../../10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md) §7 ·
[`LIBOORA_MODULE_DEPENDENCY_MATRIX.md`](../../10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md) ·
[`DEPENDENCY_GRAPH.md`](../../10-architecture/DEPENDENCY_GRAPH.md) ·
[`ADR-0011`](../adr/ADR-0011-global-person-identity.md) ·
[`MASTER_PRD.md`](../../30-product/MASTER_PRD.md) §29 ·
[`IMPLEMENTATION_ROADMAP.md`](../../40-implementation/IMPLEMENTATION_ROADMAP.md) §11 ·
[`PRD_REGISTRY.md`](./PRD_REGISTRY.md) ·
[`PRD_GAP_ANALYSIS.md`](./PRD_GAP_ANALYSIS.md)

---

## 9. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-04 | Created. 17 PRD-level edges derived from the Bounded Context Map §7 integration table, the domain-event register and Master PRD §29. **No edge was invented** — §3.2 records two commonly assumed edges that do **not** exist and states why. Recorded finding: **`E-22`'s consumer list omits `BC-10`** while `Student_Identity_PRD_v1.md` §4.8 cites `E-22` (§4.1) — raised as `PGA-02`, not resolved here, because resolution requires editing a frozen document. Depth 4, **no cycles**. No requirement created or modified; no PRD edited. |
