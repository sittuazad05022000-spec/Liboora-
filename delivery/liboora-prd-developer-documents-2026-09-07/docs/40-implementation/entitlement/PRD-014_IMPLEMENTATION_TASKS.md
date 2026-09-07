# `PRD-014` Implementation Tasks — `IMPL-1000` … `IMPL-1029`

| Field | Value |
|---|---|
| **Module** | `platform/business` — rank 6, Bounded Context **`BC-21`** Entitlement |
| **Aggregate** | `EntitlementSet` — the only one (BC Map **L383**) |
| **Source PRD** | [`../../30-product/entitlement/PRD-014_ENTITLEMENT.md`](../../30-product/entitlement/PRD-014_ENTITLEMENT.md) v0.1 `DRAFT` |
| **PRD hash** | `d4ca7e11352d009c84b3ed38f531e7ce73bb059549db0cd3cb2bacc25214c175` — **unchanged** by this document |
| **Range allocated** | **`IMPL-1000` … `IMPL-1029`** — 30 tasks · `IMPL-1030`…`1099` declared growth reserve |
| **Obligations claimed** | **54 of 54 = 100.0%** — computed by [`../../../tool/docs_check/prd014_task_coverage.py`](../../../tool/docs_check/prd014_task_coverage.py) |
| **Acceptance criteria proven** | ⛔ **0 of 26.** No implementation exists; `lib/platform/business/` has **no test file at all** (`D-014-05`) |
| **Stage** | 6 of 9. **Stage 8 is not started.** |
| **Status of this document** | **Unranked.** Not admitted to `DOCUMENTATION_BASELINE.md` |
| **Version** | v1.0 · 2026-08-19 |

---

## 1. The one thing this document is not

**It is not an implementation, and it is not a design.** It allocates numbers and states what each numbered unit of
work must satisfy, citing `ENT-*` obligations that already exist in the PRD. It contains **no** schema, SQL, DDL,
migration, API shape beyond the port signature the PRD already fixes, field list, storage engine choice, index
definition, estimate or sprint assignment.

That restraint is load-bearing for this module in particular. `PRD-014` §0.3 records that **`ENT-CFG-*` is empty
because no document at any rank bounds an entitlement parameter** — BC Map **L326** points at a Config register that
does not exist. A backlog that named a timeout, a grace-period length or a fail disposition would close `Q-03` by
implementation choice, which is exactly the invention the authoring mandate forbids and which §12 of the PRD records
as `ENT-GAP-001`/`ENT-GAP-002`. §8 lists the tasks that must therefore **not** exist.

**Nothing under `lib/`, `packages/` or `test/` was modified.** `git status --short lib/ packages/ test/` returns
**0 lines**. The six code contradictions the PRD recorded (`D-014-01` … `D-014-06`) are **not repaired here** — §4.1
measures them, and Stage 8 owns them.

---

## 2. Stage 6 prerequisites — verified, not assumed

| Prerequisite | Required by | State |
|---|---|---|
| Stage 1 Discovery passed | `PRD_LIFECYCLE.md` L60–76 | ✅ [`PRD-014_STAGE1_DISCOVERY.md`](../../30-product/entitlement/PRD-014_STAGE1_DISCOVERY.md) — `BC-21` identified and **unowned** by any other PRD |
| Stage 2 draft exists, versioned header, registers declared up front | `PRD_LIFECYCLE.md` L79–86 | ✅ `PRD-014_ENTITLEMENT.md` v0.1, **8 registers**, ranges published in §0.2 |
| Stage 3 Architecture alignment recorded | `PRD_LIFECYCLE.md` L90–106 | ⚠ [`PRD-014_ARCHITECTURE_ALIGNMENT.md`](../../30-product/entitlement/PRD-014_ARCHITECTURE_ALIGNMENT.md) — **CONDITIONAL PASS**; the condition is inherited `H-1`, not a `PRD-014` defect (§2.1) |
| Stage 4 conflicts closed or deferred with reason **and** owner | `PRD_LIFECYCLE.md` L108–120 | ✅ [`PRD-014_STAGE4_REQUIREMENTS_REVIEW.md`](../../30-product/entitlement/PRD-014_STAGE4_REQUIREMENTS_REVIEW.md) — **PASS 6/6**, **13** deferrals each with a named owner |
| Stage 5 prefixes registered, counts and ranges verified mechanically, zero collisions | `PRD_LIFECYCLE.md` L121–133 | ✅ [`TRACEABILITY_MATRIX.md`](../TRACEABILITY_MATRIX.md) **v1.15 §2K** · conferred by [`PRD-014_STAGE5_CONFERRAL.md`](../../30-product/entitlement/PRD-014_STAGE5_CONFERRAL.md) · two committed checkers, both exit 0, mutation-tested 6/6 |

Stage 6 is therefore genuinely reachable. **Registered is not verified**, and Stage 5 conferred nothing about this
stage — its §7 says so explicitly.

### 2.1 Why a CONDITIONAL Stage 3 does not block Stage 6

Stage 3's verdict is **CONDITIONAL PASS**, and the honest question is whether that is a gate failure. It is not, and
the reason is recorded rather than waved past: the condition is **`H-1`**, a hazard `PRD-007` raised at its own
L431 and which `PRD-013` inherited before this module existed. It concerns whether a capability context may write to
`BC-24` Audit Trail. `PRD-014` does not resolve it, does not depend on its resolution to allocate work, and
**declines to presume the answer** — which is why `ENT-FR-026` carries no acceptance criterion (`S4-D-06`).

`IMPL-1026` is written so that it is satisfiable **either way**: it requires that the module hold no audit store, a
prohibition true under both resolutions of `H-1`. No task in this backlog is contingent on `H-1`.

---

## 3. `IMPL-*` allocation

### 3.1 Why this range — computed, not chosen

`PRD_LIFECYCLE.md` Stage 6 allocation rule 1: *"Take the next free range. **Never reuse or reassign a number** —
cross-references in commits, reviews and test names outlive the document."* Rule 2: *"Leave the previous group room
to grow contiguously."*

Every `IMPL-*` identifier in the repository was enumerated rather than read off a table:

```
grep -rhoE 'IMPL-[0-9]+' docs/ tool/ lib/ packages/ test/ | sort -n -u
→ 489 distinct numbers · tail: … 921 922 923 924 925 926 927 928 929 930 999 1000
```

**`IMPL-1000` is the next free block.** `IMPL-900`…`929` belongs to `PRD-016` Audit Trail (30 tasks, `ADR-0051`) and
`IMPL-930`…`999` is **that module's declared growth reserve** for its five open `AUD-GAP-*` — `ADR-0051` **L406**
states it. Beginning at `1000` leaves `PRD-016` its whole reserve untouched, satisfying rule 2. **Nothing below
`1000` is touched, reused or reassigned.**

⚠ **`IMPL-1000` already occurs in the repository, and every occurrence was checked rather than assumed harmless.**

```
grep -rn 'IMPL-1000' docs/ → 5 occurrences before this document, none a task:
  docs/40-implementation/audit/PRD-016_IMPLEMENTATION_TASKS.md:114   | `IMPL-1000` + | Unallocated | — |
  docs/30-product/audit/PRD-016_STAGE6_IMPLEMENTATION_TASKS.md:124   "IMPL-900 is occupied; start at IMPL-1000"
  docs/30-product/entitlement/PRD-014_STAGE1_DISCOVERY.md:483,505    finding R-03 and measurement M-03
  docs/40-implementation/TRACEABILITY_MATRIX.md:1149                 §2K, "the next free block is IMPL-1000+"
```

All are **boundary labels naming this number as free**, or measurements establishing that it is. Taking `IMPL-1000`
is what rule 1's *"take the next free range"* instructs, not a reassignment. The distinction matters because a
scanner counting string occurrences — as the enumeration above does — reports `1000` as present, and treating that
report as occupancy would push this backlog to `IMPL-1100` and silently strand a century. **The occurrences are
disclosed rather than filtered out**, so a later reader can re-derive the decision. This is the identical hazard
`PRD-016` §3.1 recorded for `IMPL-900`, and it is recorded again rather than assumed inherited.

### 3.2 The allocation table

| Range | Owner | Grouping |
|---|---|---|
| `IMPL-014` … `IMPL-073` | Authentication, platform, release readiness | [`../IMPLEMENTATION_ROADMAP.md`](../IMPLEMENTATION_ROADMAP.md) |
| `IMPL-100` … `IMPL-127` | Library Management | `LIBRARY_IMPLEMENTATION_TASKS.md` |
| `IMPL-128` … `IMPL-199` | Reserved — Library Management growth | — |
| `IMPL-200` … `IMPL-226` | Student Identity | `STUDENT_IDENTITY_IMPLEMENTATION_TASKS.md` |
| `IMPL-227` … `IMPL-299` | Student Identity growth — **partly consumed** (§3.3) | — |
| `IMPL-300` … `IMPL-323` | Student Management (`PRD-004`, `BC-01`) | `PRD-004_IMPLEMENTATION_TASKS.md` |
| `IMPL-324` … `IMPL-399` | Reserved — Student Management growth | — |
| `IMPL-400` … `IMPL-441` | Membership Management (`PRD-005`, `BC-02`) | `PRD-005_IMPLEMENTATION_TASKS.md` |
| `IMPL-442` … `IMPL-499` | `PRD-005` declared growth reserve | — |
| `IMPL-500` … `IMPL-599` | Seat Management (`PRD-007`, `BC-04`) | `PRD-007_IMPLEMENTATION_TASKS.md` |
| `IMPL-600` … `IMPL-699` | Attendance / integration backlogs | — |
| `IMPL-700` … `IMPL-799` | Revenue & Finance (`PRD-008`, `BC-06`) — `ADR-0049` | `PRD-008_IMPLEMENTATION_TASKS.md` |
| `IMPL-800` … `IMPL-829` | Tenancy (`PRD-013`, `BC-19`) — 30 tasks, `ADR-0050` | [`../tenancy/PRD-013_IMPLEMENTATION_TASKS.md`](../tenancy/PRD-013_IMPLEMENTATION_TASKS.md) |
| `IMPL-830` … `IMPL-899` | Reserved — `PRD-013` growth. **Not touched here** | — |
| `IMPL-900` … `IMPL-929` | Audit Trail (`PRD-016`, `BC-24`) — 30 tasks, `ADR-0051` | [`../audit/PRD-016_IMPLEMENTATION_TASKS.md`](../audit/PRD-016_IMPLEMENTATION_TASKS.md) |
| `IMPL-930` … `IMPL-999` | Reserved — **`PRD-016` growth**, 5 open `AUD-GAP-*` (`ADR-0051` L406). **Not touched here** | — |
| **`IMPL-1000` … `IMPL-1009`** | **Wave 1 — The aggregate, its three value objects, derived-state-only, the six invariants** | This document |
| **`IMPL-1010` … `IMPL-1019`** | **Wave 2 — Derivation from Billing events, idempotency, tenant context, ordering** | This document |
| **`IMPL-1020` … `IMPL-1029`** | **Wave 3 — The `E-17` port, query confinement, the twelve exclusions, acceptance harness** | This document |
| `IMPL-1030` … `IMPL-1099` | **Reserved for `PRD-014` growth** — 8 open `ENT-GAP-*` may require tasks | This document, unallocated |
| `IMPL-1100` + | Unallocated | — |

**30 tasks, `IMPL-1000` … `IMPL-1029`, contiguous with no gaps inside the allocated span.** Wave boundaries fall on
round tens so that a task added to a wave later does not force a renumber: rule 1 forbids reassignment, so slack must
be **planned rather than found**.

`IMPL-1030`…`1099` is declared as this module's growth reserve because **eight** `ENT-GAP-*` are genuinely open, and
two of them would each require real tasks once their owners decide: `ENT-GAP-001` (the fail disposition, `Q-03`) and
`ENT-GAP-002` (the missing Config register). If `Q-03` is ever resolved by a named disposition, that work takes
`IMPL-1030`+ rather than a number inside a wave.

### 3.3 A known staleness, disclosed rather than corrected

`PRD_LIFECYCLE.md`'s Stage 6 range table ends `| IMPL-227+ | **Unallocated** |`. The enumeration in §3.1 shows
`IMPL-227` is **occupied** by Student Identity growth, and `ADR-0049` has already recorded this. Trusting that table
would violate allocation rule 1 by reassigning a live number.

⚠ **The table is a Rank 1 governance document and is NOT amended here.** Repairing it requires its own ADR
(`DOCUMENTATION_BASELINE.md` §7 rule 1: *"A change to any Rank 1–5 document requires an ADR **before** the
change"*), and amending a governance document is not a Stage 6 act. The staleness is **worked around by
measurement and disclosed**, which is the fourth consecutive backlog to do so — `PRD-008`, `PRD-013`, `PRD-016` and
now `PRD-014`. That it has now been disclosed four times without being fixed is itself evidence the repair is owed;
it is recorded as such rather than performed.

---

## 4. Blocking dependencies outside `PRD-014`

| Dependency | Owner | Effect on this backlog |
|---|---|---|
| `billing.EntitlementChanged` must exist and be published | **`BC-20` Billing** (`PRD-022`) | ⛔ **Hard blocker for Wave 2.** `ENT-FR-005` names it *"the only writer of entitlement inputs"* (BC Map **L437**), and `PRD-022` mentions entitlement **0 times in 962 lines** (`ENT-GAP-004`). Every Wave 2 task is written against the **event contract as BC Map L437 states it**, not against a `PRD-022` section that does not exist |
| The fail disposition per feature | `Q-03` — **Open**, Rank 4 (BC Map L542) and Rank 1 (`MASTER_PRD.md` L675) | ⚠ **Partial blocker for `IMPL-1021`.** The task requires the disposition be **read from configuration**, not that it hold any particular value — satisfiable without deciding `Q-03` |
| The Config register `E-17` points at | `ENT-GAP-002` — **does not exist** | ⚠ Same as above. `IMPL-1021` requires the read path; creating the register is `ENT-GAP-002`'s owner's act |
| Whether `BC-21` may write to `BC-24` | `H-1` — inherited, **Open** | ⚠ Bounded to `IMPL-1026`, written to be satisfiable either way (§2.1) |
| Whether `platform/business` needs a physical split | `ENT-GAP-006` — **Open**, Architecture Owner | ⚠ Affects **where** code lives, not what it must do. `IMPL-1027` asserts the rank-6 import rules that hold under either outcome |
| Proration ownership | `Q-06` — **Open** (BC Map L545, `MASTER_PRD.md` L678) | **None.** `ENT-XC-005` makes proration arithmetic impossible **here** regardless of who owns it. `IMPL-1025` asserts the prohibition, not the owner |

### 4.1 The pre-existing scaffold — measured, not assumed

`lib/platform/business/business.dart` (92 lines) already contains an `EntitlementService`. It is **not** a partial
implementation of this PRD; it contradicts it in six measured ways, recorded in `PRD-014` §13:

| ID | Contradiction | Obligation contradicted | Task that covers it |
|---|---|---|---|
| `D-014-01` | `check(Feature f, {int delta = 1})` carries **no `tenantId`** — the tenant is read ambiently from `_tenantContext` | `ENT-FR-013`, `ENT-FR-014` | `IMPL-1020`, `IMPL-1022` |
| `D-014-02` | `_tier` lookup **silently defaults** to `TenantTier.starter` for an unknown tenant | `ENT-BR-007`; Rank 1 `MP-GBR-07` *"fails loudly, never defaults"* | `IMPL-1014` |
| `D-014-03` | `_limits` and `_gates` are **hardcoded `static const`** — not derived from any event | `ENT-FR-003`, `ENT-FR-005`, `ENT-INV-001` | `IMPL-1002`, `IMPL-1010` |
| `D-014-04` | `_usage` is an **in-memory `Map`**, so a rebuild cannot reproduce it | `ENT-FR-004`, `ENT-INV-001` | `IMPL-1003`, `IMPL-1013` |
| `D-014-05` | **No test file exists at all** for `platform/business` | Every `ENT-AC-*` — 0 of 26 provable | `IMPL-1029` |
| `D-014-06` | `lib/bootstrap/seed.dart:95–96` calls `registerTenant(...)` — a **direct write** outside a `billing.EntitlementChanged` handler | `ENT-BR-001`, `ENT-INV-002`; Matrix `X-11`, manifest `BZ-1` | `IMPL-1011`, `IMPL-1012` |

⚠ **The scaffold's existence means Stage 8 is a correction, not a green field**, and the backlog is sized
accordingly: six tasks exist specifically because working code already contradicts the specification. `X-11` rates
the `D-014-06` class as making *"revenue leakage unauditable"*, which is why `IMPL-1011` and `IMPL-1012` are
Priority **P0**.

**None of the six is repaired by this document.**

---

## 5. The 30 tasks

**Reading rules.** `Blocks` and `Blocked by` are within this backlog unless a foreign identifier is named.
`P0` = required before any other wave task can be trusted; `P1` = required for the module to function; `P2` =
required for the module to be *provably* correct. Every task cites the obligations it discharges; **no task cites an
obligation that does not exist**, and every obligation is cited by at least one task (§6).

### 5.1 Wave 1 — The aggregate, its three value objects, derived-state-only, the six invariants (`IMPL-1000` … `IMPL-1009`)

| ID | Task | Discharges | Priority | Blocked by | Blocks |
|---|---|---|---|---|---|
| `IMPL-1000` | Establish `EntitlementSet` as the module's **single** aggregate, instantiated per tenant | `ENT-FR-001` | P0 | — | 1001, 1002, 1005 |
| `IMPL-1001` | Establish exactly three value objects — `FeatureGate`, `UsageCounter`, `Limit` — and **no fourth** | `ENT-FR-002` | P0 | 1000 | 1004, 1020 |
| `IMPL-1002` | Remove every write path that sets gate or limit state outside derivation; expose **no** mutator | `ENT-FR-003`, `ENT-INV-002` | P0 | 1000 | 1010, 1011 |
| `IMPL-1003` | Make `EntitlementSet` **reconstructible** from the input event stream — no state that is not a function of events | `ENT-FR-004`, `ENT-INV-004` | P0 | 1000 | 1013, 1028 |
| `IMPL-1004` | Bind every `EntitlementSet`, `FeatureGate`, `UsageCounter` and `Limit` to exactly one tenant, with **no** cross-tenant reachability | `ENT-INV-003` | P0 | 1001 | 1021, 1022 |
| `IMPL-1005` | Assert the module holds **no domain entity**; references to domain identity are by identifier only | `ENT-INV-005`, `ENT-FR-027` | P1 | 1000 | 1027 |
| `IMPL-1006` | Assert `TenantTier` and `Quota` are **inputs only** — never written, never versioned here | `ENT-BR-003`, `ENT-XC-001` | P1 | 1002 | 1024 |
| `IMPL-1007` | Separate **gate presence** from **flag state**: neither implies the other | `ENT-BR-004`, `ENT-XC-008` | P1 | 1001 | 1024 |
| `IMPL-1008` | Assert entitlement derives from **library→LIBOORA** money only, never student→library | `ENT-BR-006` | P1 | 1002 | 1024 |
| `IMPL-1009` | Establish the **derivability equality check** as a runnable comparison: incremental state vs rebuild | `ENT-INV-001`, `ENT-BR-002` | P0 | 1003 | 1028, 1029 |

### 5.2 Wave 2 — Derivation from Billing events, idempotency, tenant context, ordering (`IMPL-1010` … `IMPL-1019`)

| ID | Task | Discharges | Priority | Blocked by | Blocks |
|---|---|---|---|---|---|
| `IMPL-1010` | Derive gate and limit state **solely** from `billing.EntitlementChanged` | `ENT-FR-005` | P0 | 1002 | 1013, 1028 |
| `IMPL-1011` | Prohibit every non-handler write path, in code, not by convention | `ENT-BR-001`, `ENT-INV-002`; Matrix `X-11`, manifest `BZ-1` | **P0** | 1002 | 1012, 1028 |
| `IMPL-1012` | Remove the bootstrap direct-write route (`D-014-06`) and route it through the event contract | `ENT-BR-001` | **P0** | 1011 | 1028 |
| `IMPL-1013` | Consume `billing.SubscriptionActivated` / `Cancelled` / `PaymentFailed` as derivation inputs | `ENT-FR-006` | P1 | 1003, 1010 | 1016 |
| `IMPL-1014` | Consume `tenancy.TenantProvisioned` / `TenantSuspended` as lifecycle gates; **fail loudly** on unknown tenant | `ENT-FR-007`, `ENT-BR-007` | **P0** | — | 1015, 1021 |
| `IMPL-1015` | Reject an input event with absent or unresolvable `tenantId` — no default, no silent skip | `ENT-FR-009`, `ENT-BR-007` | P0 | 1014 | 1021 |
| `IMPL-1016` | Make every input handler **idempotent on `eventId`**; re-application changes nothing | `ENT-FR-008`, `ENT-INV-006` | P0 | 1013 | 1028 |
| `IMPL-1017` | Rely only on **per-tenant** ordering; assume no global ordering | `ENT-FR-010` | P1 | 1016 | — |
| `IMPL-1018` | Route an out-of-band entitlement change through the same event contract as an ordinary one | `ENT-FR-011` | P1 | 1010 | — |
| `IMPL-1019` | Apply gate tightening after downgrade as **eventually consistent**, with the grace period read from configuration | `ENT-BR-008` | P2 | 1010 | — |

### 5.3 Wave 3 — The `E-17` port, query confinement, the exclusions, acceptance harness (`IMPL-1020` … `IMPL-1029`)

| ID | Task | Discharges | Priority | Blocked by | Blocks |
|---|---|---|---|---|---|
| `IMPL-1020` | Expose the decision surface as the registered port `:entitlement` (`ADR-0012` L86) | `ENT-FR-012` | P0 | 1001 | 1021, 1022 |
| `IMPL-1021` | Implement `check(tenantId, feature, delta)` as a **pre-mutation** check; read the timeout disposition from configuration **without asserting its value** | `ENT-FR-013`, `ENT-FR-015`, `ENT-FR-018`, `ENT-BR-005` | P0 | 1004, 1015, 1020 | 1023, 1029 |
| `IMPL-1022` | Make `tenantId` an **explicit argument**, never ambient (`D-014-01`) | `ENT-FR-014` | **P0** | 1004, 1020 | 1023 |
| `IMPL-1023` | Answer both halves of the `BC-21` question — allowed, and how much remains — with refusals **distinguishable by cause** | `ENT-FR-016`, `ENT-FR-017`, `ENT-FR-019` | P1 | 1021, 1022 | 1029 |
| `IMPL-1024` | Confine reads to the read-optimised `EntitlementSet`, single-tenant-scoped, exposing remaining allowance and gate state | `ENT-FR-020`, `ENT-FR-021`, `ENT-FR-022`, `ENT-FR-023` | P1 | 1004 | 1029 |
| `IMPL-1025` | Assert the **money and plan** exclusions are impossible: no `Subscription`, no gateway call, no invoice, no proration arithmetic, no `MembershipPlan` | `ENT-XC-002`, `ENT-XC-004`, `ENT-XC-005`, `ENT-XC-006` | P1 | 1006 | 1029 |
| `IMPL-1026` | Assert the **neighbouring-context** exclusions: no `Seat`, no feature flag, no authorisation decision, no `AuditEntry` or audit store | `ENT-XC-007`, `ENT-XC-008`, `ENT-XC-009`, `ENT-XC-010` | P1 | 1007 | 1029 |
| `IMPL-1027` | Enforce rank-6 placement: import `contracts` only, **no** `domain/**` or `app/**`, and the `SeatQuota` naming rule | `ENT-FR-027`, `ENT-FR-028`, `ENT-XC-011`; manifest `banned_imports` | P1 | 1005 | 1029 |
| `IMPL-1028` | Enforce the **publish-nothing, add-no-edge** boundary: no domain event, no new integration edge, no self-audit | `ENT-FR-024`, `ENT-FR-025`, `ENT-FR-026`, `ENT-XC-003`, `ENT-XC-012` | P1 | 1009, 1011, 1016 | 1029 |
| `IMPL-1029` | Build the acceptance harness that turns `ENT-AC-001`…`ENT-AC-026` from prose into **executing tests** (`D-014-05`) | All 26 `ENT-AC-*` | **P0 for verification** | 1009, 1021, 1023, 1024, 1025, 1026, 1027, 1028 | — |

---

## 6. Traceability — task group → requirements → invariants → acceptance

Required by allocation rule 4. **Computed** by `prd014_task_coverage.py`, not asserted.

| Wave | Tasks | Requirements discharged | Invariants | Acceptance |
|---|---|---|---|---|
| **1 — Aggregate and invariants** | `IMPL-1000`…`1009` | `ENT-FR-001`…`004`, `ENT-FR-027`; `ENT-BR-002`, `003`, `004`, `006`; `ENT-XC-001`, `008` | `ENT-INV-001`…`005` | Criteria proving single aggregate, three value objects, derived-state-only, tenant binding, derivability |
| **2 — Derivation** | `IMPL-1010`…`1019` | `ENT-FR-005`…`011`; `ENT-BR-001`, `005`, `007`, `008` | `ENT-INV-002`, `004`, `006` | Criteria proving sole-writer, idempotency, loud failure on absent tenant, eventual tightening |
| **3 — Port, reads, exclusions** | `IMPL-1020`…`1029` | `ENT-FR-012`…`026`, `028` | `ENT-INV-003` | All 26 `ENT-AC-*` become executable at `IMPL-1029` |

### 6.1 Coverage, computed

| Measure | Value |
|---|---|
| Class A obligations in `PRD-014` | **54** |
| Obligations claimed by at least one task | **54** |
| **Coverage** | **54 / 54 = 100.0%** |
| Tasks claiming an obligation that does not exist | **0** |
| Tasks claiming no obligation | **0** |
| `ENT-AC-*` covered by the harness task | **26 of 26** |
| Criteria **proven by a passing test today** | ⛔ **0 of 26** |
| `D-014-*` contradictions covered by a task | **6 of 6** |

⚠ **100% task coverage is not 100% verification, and the two are not one row apart by accident.** Every obligation
is *claimed* by a task; **no** criterion passes, because no implementation exists. `PRD-016`'s backlog published the
same pair for the same reason. The `PRD-006` v1.0 error — publishing *"100% coverage"* against a true 49.1% — is
avoided by computing both numbers and printing the ⛔ row directly beneath the ✅ one.

⚠ **Coverage here is 100% where the PRD's own acceptance coverage is 94.4%, and that is not a contradiction.** The
two measure different things: §10.1 measures *obligations carrying an acceptance criterion*; this table measures
*obligations claimed by a task*. `ENT-FR-017`, `ENT-FR-018` and `ENT-FR-026` have **no criterion** yet are each
claimed by a task (`IMPL-1023`, `IMPL-1021`, `IMPL-1028`) — a task can implement an obligation whose *proof* is
blocked on an open decision. Conflating the two would have let a genuine gap hide behind a full-looking number.

---

## 7. Critical path — computed, not asserted

```
IMPL-1000 → 1002 → 1011 → 1012        (sole-writer, the X-11 leak)
IMPL-1000 → 1003 → 1009               (derivability, the BC-21 invariant)
IMPL-1014 → 1015 → 1021 → 1023        (loud failure → the E-17 port → causes)
IMPL-1001 → 1004 → 1022               (explicit tenantId, D-014-01)
                          ↓
                     IMPL-1029        (acceptance harness — depends on 8 tasks)
```

**Longest chain: 5 tasks** (`1000 → 1002 → 1011 → 1012 → 1029`). **`IMPL-1029` is the single convergence point**, by
design: until the harness exists, `D-014-05` means every criterion in this module is unproven prose.

**Seven P0 tasks**: `1000`, `1002`, `1003`, `1004`, `1011`, `1012`, `1014`, plus `1015`, `1020`, `1021`, `1022` — the
sole-writer chain and the tenant-explicitness chain, because `X-11` rates unauthorised entitlement writes as making
*"revenue leakage unauditable"* and `MP-GBR-09` rates cross-tenant leakage as *"the single highest-severity failure
mode"*.

---

## 8. Tasks that must **not** be created

| Forbidden task | Why |
|---|---|
| *"Choose the fail-open/fail-closed default"* | `Q-03` is **Open** at Rank 4 and Rank 1. Choosing it here decides an architecture question by implementation. `IMPL-1021` requires the **read path**, not the value |
| *"Define the entitlement Config register"* | `ENT-GAP-002`. BC Map L326 points at a register that does not exist; creating it is a Rank 7 act with an owner elsewhere |
| *"Set the grace-period length"* | `ENT-BR-008` requires *"a **configured** value, never an implicit one"*. A number here would be an invented configurable |
| *"Add a timeout value to `check`"* | Same class. `ENT-CFG-*` is empty **because no authority bounds it** |
| *"Emit `entitlement.*` events"* | `ENT-FR-024` and `ENT-XC-003`. `BC-21` publishes **nothing**; BC Map §7: *"If an edge is not in this table, it does not exist and adding it requires an ADR"* |
| *"Write entitlement decisions to the audit trail"* | `ENT-FR-026`, `ENT-XC-010`, and `H-1` is **Open**. `IMPL-1026` asserts the prohibition, which holds either way |
| *"Split `platform/business` into two modules"* | `ENT-GAP-006`, Architecture Owner. `ADR-0035` L123 currently permits *"exactly two"* contexts there |
| *"Compute proration"* | `ENT-XC-005`; `Q-06` Open |
| *"Define `Seat` / allocate seats"* | `ENT-XC-007`. `BC-04` owns `Seat`; L211's CI lint rule enforces `Seat` vs `SeatQuota` |
| *"Repair `PRD_LIFECYCLE.md`'s IMPL table"* | Rank 1; needs an ADR **before** the change (§3.3) |
| *"Fix `ENT-XC-012`'s missing Owner cell"* or *"disambiguate `ENT-FR-017`/`022`"* | `S4-F-01`, `S4-F-02` — **product owner** acts on the PRD, deferred with reasons at Stage 4. A backlog task cannot amend a PRD |

---

## 9. What this document does **not** claim

| Not claimed | Why |
|---|---|
| That any code works | **0 of 26** criteria pass. `lib/platform/business/` has no test file (`D-014-05`) |
| That the scaffold is a starting point | It **contradicts** the PRD in six measured ways (§4.1). Stage 8 is a correction |
| That Stage 7 is reached | Freeze requires a row in `DOCUMENTATION_BASELINE.md` §3. None exists for `PRD-014` |
| That the eight gaps are closed | All **8** `ENT-GAP-*` remain **OPEN** |
| That `PRD-022` supports Wave 2 | It mentions entitlement **0 times in 962 lines** (`ENT-GAP-004`). Wave 2 cites **BC Map L437**, the actual authority |
| That this document is ranked | **Unranked.** It confers nothing |
| That estimates or a schedule exist | No estimate, story point, sprint or date appears here. `Priority` orders work; it does not size it |

---

## 10. Definition of done — applies to every task

1. The obligation cited is satisfied **as stated in the PRD**, not as paraphrased here.
2. A test exists that **fails** if the obligation is violated — `D-014-05` means there is currently no such test for
   anything in this module.
3. `dart run tool/check_module_boundaries.dart` shows **no new violation** for `platform/business`.
4. Manifest assertion **`BZ-1`** (entitlement written only by `billing.EntitlementChanged` handlers) holds.
5. No `ENT-CFG-*` value is introduced; any tunable is **read**, never defaulted in code.
6. No new integration edge and no published event appear (`ENT-FR-024`, `ENT-FR-025`).

---

## 11. Stage 6 exit gate — re-runnable

`PRD_LIFECYCLE.md` L137: *"an `IMPL-*` range allocated and a task document in which **every task traces back to
requirements**."*

| Gate element | Evidence | Result |
|---|---|---|
| Range allocated | `IMPL-1000`…`1029`, next free **by measurement** (§3.1), reserve `1030`…`1099` declared | ✅ |
| Task document exists | This file | ✅ |
| **Every task traces to requirements** | **30 of 30**; 0 tasks cite a non-existent obligation; 0 tasks cite none | ✅ |
| Rule 1 — no reuse or reassignment | Nothing below `1000` touched; the 5 prior `IMPL-1000` occurrences shown to be **boundary labels** | ✅ |
| Rule 2 — previous group room to grow | `IMPL-930`…`999` left wholly to `PRD-016` (`ADR-0051` L406) | ✅ |
| Rule 3 — `Priority`, `Blocks`, `Blocked by` per task | Present on all 30 rows | ✅ |
| Rule 4 — traceability table | §6, computed | ✅ |
| Verified mechanically | `prd014_task_coverage.py`, **exit 0** | ✅ |

---

## 12. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-19 | Created as the **Stage 6** gate artefact for `PRD-014` v0.1 `DRAFT`. Allocates **`IMPL-1000`…`IMPL-1029`** — 30 tasks in 3 waves — established as the next free block **by enumerating all 489 distinct `IMPL-\d+` identifiers**, not from `PRD_LIFECYCLE.md`'s **stale** L147–153 table (`IMPL-227` is occupied; disclosed in §3.3, **not** amended, since a Rank 1 change needs an ADR first). The **5** pre-existing `IMPL-1000` occurrences are shown to be **boundary labels**, disclosed rather than filtered. `IMPL-1030`…`1099` declared as growth reserve for the 8 open `ENT-GAP-*`; `IMPL-930`…`999` left wholly to `PRD-016` per `ADR-0051` L406, satisfying rule 2. Coverage **54/54 = 100.0%** of Class A obligations, **0** tasks citing a non-existent obligation, **0** citing none, **6 of 6** `D-014-*` contradictions covered — with ⛔ **0 of 26** criteria proven by a passing test, because no implementation exists and `platform/business` has **no test file at all** (`D-014-05`). ⚠ Records why 100% **task** coverage coexists with the PRD's 94.4% **acceptance** coverage: a task may implement an obligation whose *proof* is blocked on an open decision, and conflating the two would let a real gap hide behind a full number. ⚠ Records why a **CONDITIONAL** Stage 3 does not block Stage 6: the condition is inherited `H-1`, and `IMPL-1026` is written to be satisfiable under either resolution. **No code, PRD, ADR, registry or baseline change**; PRD hash `d4ca7e11…c175` unchanged; the six code contradictions recorded, none repaired — Stage 8 owns them |
