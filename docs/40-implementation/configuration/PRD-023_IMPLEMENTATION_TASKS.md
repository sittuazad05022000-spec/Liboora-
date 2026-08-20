# `PRD-023` Implementation Tasks — `IMPL-1100` … `IMPL-1129`

| Field | Value |
|---|---|
| **Module** | `platform/configuration` — rank **3**, Bounded Context **`BC-25`** Configuration |
| **Aggregate** | ⚠ **None owned.** BC Map §8 lists 17 aggregates; **`BC-25` appears in none of them** (see §4.2) |
| **Source PRD** | [`../../30-product/configuration/PRD-023_SETTINGS_AND_CONFIGURATION.md`](../../30-product/configuration/PRD-023_SETTINGS_AND_CONFIGURATION.md) v0.1 `DRAFT` |
| **PRD hash** | `e97496083a76bfb0f45be9acae754050c374561b64734df5738dac7ff6399326` — **unchanged** by this document |
| **Range allocated** | **`IMPL-1100` … `IMPL-1129`** — 30 tasks · `IMPL-1130`…`1199` declared growth reserve |
| **Obligations claimed** | **113 of 113 = 100.0%** of Class A — every `CNF-FR-*`, `CNF-BR-*`, `CNF-INV-*`, `CNF-XC-*`. **Computed** by [`../../../tool/docs_check/prd023_task_coverage.py`](../../../tool/docs_check/prd023_task_coverage.py), not asserted |
| **Acceptance criteria proven** | ⛔ **0 of 59.** No implementation exists; `lib/platform/configuration/` does not exist |
| **Stage** | 6 of 9. **Stage 8 is not started.** |
| **Status of this document** | **Unranked.** Not admitted to `DOCUMENTATION_BASELINE.md` |
| **Version** | v1.0 · 2026-08-20 |

---

## 1. The one thing this document is not

**It is not an implementation, and it is not a design.** It allocates numbers and states what each numbered unit of
work must satisfy, citing `CNF-*` obligations that already exist in the PRD. It contains **no** schema, SQL, DDL,
migration, storage engine choice, index definition, estimate or sprint assignment.

That restraint is load-bearing for this module **more than for any predecessor**, because of what this module owns.
`ADR-0017` §3.1 item 6 fixes the boundary precisely:

> `PRD-023` owns the resolution machinery, **not the value list**.

`CNF-CFG-*` is **empty**, and the Stage 5 conferral records why: all **104** configurables in the repository belong to
**eight other PRDs, every one FROZEN** — `CFG-1`…`12`, `LCFG-1`…`13`, `ICFG-1`…`10`, `SCFG-1`…`11`, `SMCFG-1`…`7`,
`MM-CFG-001`…`009`, `SEAT-CFG-001`…`018`, `ATT-CFG-001`…`024`. **A backlog that named a default, a range, a scope
value or a flag would silently annex a parameter from a frozen owner.** §8 lists the tasks that must therefore **not**
exist. This is the single largest invention risk in the module, and it is answered by omission, not by care.

**Nothing under `lib/`, `packages/`, `test/` or `web/` was modified.**
`git status --short lib/ packages/ test/ web/ pubspec.yaml` returns **0 lines**.

---

## 2. Stage 6 prerequisites — verified, not assumed

| Prerequisite | Required by | State |
|---|---|---|
| Stage 1 Discovery passed | `PRD_LIFECYCLE.md` L60–76 | ✅ [`PRD-023_STAGE1_DISCOVERY.md`](../../30-product/configuration/PRD-023_STAGE1_DISCOVERY.md) — 792 lines; `IMPL-1100` established as next free by measurement `M-22` |
| Stage 2 draft exists, versioned header, registers declared up front | `PRD_LIFECYCLE.md` L79–86 | ✅ v0.1, **8 registers**, ranges published in §0.2 |
| Stage 3 Architecture alignment recorded | `PRD_LIFECYCLE.md` L90–106 | ✅ [`PRD-023_ARCHITECTURE_ALIGNMENT.md`](../../30-product/configuration/PRD-023_ARCHITECTURE_ALIGNMENT.md) — **PASS, unconditional** (6/6); 10 owned / 13 ceded / 6 edges; **0 edges created** |
| Stage 4 conflicts closed or deferred with reason **and** owner | `PRD_LIFECYCLE.md` L108–120 | ✅ [`PRD-023_STAGE4_REQUIREMENTS_REVIEW.md`](../../30-product/configuration/PRD-023_STAGE4_REQUIREMENTS_REVIEW.md) — **PASS 6/6**; 6 deferrals, each with a named owner |
| Stage 5 prefixes registered, counts and ranges verified mechanically, zero collisions | `PRD_LIFECYCLE.md` L121–133 | ✅ [`TRACEABILITY_MATRIX.md`](../TRACEABILITY_MATRIX.md) **v1.16 §2L** · conferred by [`PRD-023_STAGE5_CONFERRAL.md`](../../30-product/configuration/PRD-023_STAGE5_CONFERRAL.md) · two committed checkers, both exit 0, mutation-tested **12/12** · inventory **frozen at 180** |

Stage 6 is therefore genuinely reachable, and — unlike `PRD-014` — **Stage 3 passed unconditionally**, so no task in
this backlog is contingent on an unresolved hazard. **Registered is not verified**, and Stage 5 conferred nothing
about this stage; its §7 says so explicitly.

---

## 3. `IMPL-*` allocation

### 3.1 Why this range — computed, not chosen

Allocation rule 1: *"Take the next free range. **Never reuse or reassign a number**."* Rule 2: *"Leave the previous
group room to grow contiguously."*

The next free number is **`IMPL-1100`**, established by two independent routes:

1. **Declared.** `../entitlement/PRD-014_IMPLEMENTATION_TASKS.md` **L124** reads
   `| IMPL-1100 + | Unallocated | — |`, and **L123** declares `IMPL-1030`…`1099` as `PRD-014`'s growth reserve,
   ratified at `ADR-0052:279`. Rule 2 is satisfied by **not touching it**.
2. **Measured.** `grep -rhoE 'IMPL-[0-9]+' docs/ tool/ | sort -u` has tail `… 1021 … 1029, 1030, 1099, 1100`, and
   the sole `IMPL-1100` occurrence is the **boundary label** above, not an assignment.

⚠ **Explicitly NOT taken from `PRD_LIFECYCLE.md` L147–153**, whose `IMPL-014`…`IMPL-227+` table is **stale**;
`IMPL-227` is held by Student Identity growth. That staleness is disclosed in §3.3 and **not repaired here** —
amending a governance document is not a Stage 6 act.

### 3.2 The allocation table

| Range | Owner | Document |
|---|---|---|
| `IMPL-800` … `IMPL-829` | Tenancy (`PRD-013`, `BC-19`) — `ADR-0050` | [`../tenancy/PRD-013_IMPLEMENTATION_TASKS.md`](../tenancy/PRD-013_IMPLEMENTATION_TASKS.md) |
| `IMPL-830` … `IMPL-899` | Reserved — `PRD-013` growth. **Not touched here** | — |
| `IMPL-900` … `IMPL-929` | Audit Trail (`PRD-016`, `BC-24`) — `ADR-0051` | [`../audit/PRD-016_IMPLEMENTATION_TASKS.md`](../audit/PRD-016_IMPLEMENTATION_TASKS.md) |
| `IMPL-930` … `IMPL-999` | Reserved — `PRD-016` growth. **Not touched here** | — |
| `IMPL-1000` … `IMPL-1029` | Entitlement (`PRD-014`, `BC-21`) — `ADR-0052` | [`../entitlement/PRD-014_IMPLEMENTATION_TASKS.md`](../entitlement/PRD-014_IMPLEMENTATION_TASKS.md) |
| `IMPL-1030` … `IMPL-1099` | Reserved — **`PRD-014` growth**, 8 open `ENT-GAP-*` (`ADR-0052` L279). **Not touched here** | — |
| **`IMPL-1100` … `IMPL-1109`** | **Wave 1 — Terminology, the register, the five scopes, the resolution algorithm** | This document |
| **`IMPL-1110` … `IMPL-1119`** | **Wave 2 — Validation, the `E-19` typed accessor, failure modes, invariant enforcement** | This document |
| **`IMPL-1120` … `IMPL-1129`** | **Wave 3 — Flags, branding, secrets, audit, authority, tenant isolation, observability, UI, acceptance** | This document |
| `IMPL-1130` … `IMPL-1199` | **Reserved for `PRD-023` growth** — 8 open `CNF-GAP-*` may require tasks | This document, unallocated |
| `IMPL-1200` + | Unallocated | — |

**30 tasks, `IMPL-1100` … `IMPL-1129`, contiguous with no gaps inside the allocated span.** Wave boundaries fall on
round tens so that a task added to a wave later does not force a renumber: rule 1 forbids reassignment, so slack must
be **planned rather than found**.

`IMPL-1130`…`1199` is declared as this module's growth reserve because **eight** `CNF-GAP-*` are genuinely open, and
two of them (`CNF-GAP-001` aggregate ownership, `CNF-GAP-003` scopes 4–5) could each generate tasks once resolved by
their named owners.

### 3.3 Two known stalenesses, disclosed rather than corrected

| Staleness | Why it is not fixed here |
|---|---|
| `PRD_LIFECYCLE.md` L147–153's `IMPL-*` table stops at `IMPL-227+` | Rank-2 governance document. Baseline §7: *"A change to any Rank 1–5 document requires an ADR **before** the change."* Not a Stage 6 act |
| `PRODUCT_IMPLEMENTATION_ROADMAP.md` L78 pairs `IMPL-015`/`016` with configuration validation | Correct as history; it predates `BC-25` having a PRD. §4.3 states the relationship rather than editing the roadmap |

### 3.4 `IMPL-015` and `IMPL-016` are NOT duplicated — the relationship, stated

`IMPL-015` is **`PRD-001`'s** startup validation of `INV-1`…`INV-9`, and `IMPL-016` its companion. `CNF-GAP-005`
records the discrepancy this creates: **`IMPL-015` validates `INV-1`…`INV-9`; the Rank-7 guide publishes
`INV-1`…`INV-16`** — seven invariants are published but unvalidated.

`IMPL-1112` below therefore does **not** re-implement `IMPL-015`. It requires that the enforced set **equal the
published set** (`CNF-INV-002`, `CNF-AC-034`), which is the obligation `PRD-023` owns and `IMPL-015` never claimed.
Whether that is achieved by extending `IMPL-015` or by a new validator is an **implementation choice this document
does not make**, and whether the seven-invariant gap is `PRD-001`'s to close or `PRD-023`'s remains **`CNF-GAP-005`,
open, owned by the Architecture Owner**. Naming a resolution here would close a gap by backlog, which Stage 6 may not
do.

---

## 4. Blocking dependencies outside `PRD-023`

Required by the stage instruction: work blocked by an external governance dependency must be **classified, not
quietly scheduled**.

| # | Blocker | Classification | Tasks affected | Owner |
|---|---|---|---|---|
| **B-1** | **No `platform/configuration` module block** in `tool/module_dependencies.yaml` — only a rank. `check_module_boundaries.dart` **L778** (`if (module.declaredImports.isEmpty) return;`) **exempts** a blockless module from the `default_decision: deny`, so the module's boundary is currently unenforced | ⛔ **BLOCKED — external, architecture** | `IMPL-1128` cannot be *proven* until the block exists | Architecture Owner — `CNF-GAP-007` |
| **B-2** | **All seven Matrix §10.3 architecture tests are missing**; `test/architecture/` holds only `boundary_checker_test.dart`. `tenant_isolation_test.dart` in particular does not exist | ⛔ **BLOCKED — external, architecture** | `IMPL-1125` (isolation) and `IMPL-1129` (harness) can be **written** but not **passed** | Architecture Owner — `CNF-GAP-008` |
| **B-3** | **UI Design System** does not exist. `MASTER_PRD.md` L500/L502 (`MP-NFR-06`, `MP-NFR-08`) place it at **Rank 1** and name it owner of tokens, components and accessibility targets | ⛔ **BLOCKED — external, product** | `IMPL-1127` states *what the surface must express*; it **must not** define tokens (`CNF-XC-016`) | UI Design System owner |
| **B-4** | **NFR Budgets** do not exist. No document at any rank bounds a resolution latency, cache TTL or startup-validation duration | ⛔ **BLOCKED — external, product** | No task carries a performance target. **Naming one would invent a budget** | NFR owner |
| **B-5** | **Event Catalog** does not exist as a separate artefact; BC Map §7.3 is the authority. `E-19` (L328) and `E-20` (L329) exist and are cited; **`BC-25` has 0 producer rows in §9** | ⚠ **CONSTRAINS, does not block** | `IMPL-1123` asserts *publish-nothing*, which is satisfiable now | BC Map owner |
| **B-6** | **`CNF-GAP-001` — aggregate ownership contested.** `Library_PRD_v1.md` L188 assigns `LibrarySettings` to `BC-02` | ⛔ **BLOCKED — external, product** | **No task creates, moves or names an aggregate.** `IMPL-1101` handles the register without one | `PRD-002` owner + Architecture Owner |
| **B-7** | **`CNF-GAP-003` — scopes 4 and 5 are structurally present and functionally empty.** No PRD declares a value at branch or user scope | ⚠ **CONSTRAINS, does not block** | `IMPL-1104` requires traversal returning nothing **without error** — satisfiable either way (`CNF-AC-013`) | Awaiting any PRD to declare one |
| **B-8** | **`CNF-GAP-002` — seven modules declare a dependency on `platform/configuration:settings`, a port no module provides** | ⚠ **CONSTRAINS, does not block** | `IMPL-1113` binds the port at the composition root, which closes the orphan from this side | Architecture Owner |
| **B-9** | **`CNF-GAP-006` — the EA places `Feature Flags` and `Secret Reference Resolution` at V2** while `ADR-0017` §3.1 assigns both to V1 | ⛔ **BLOCKED — external, governance** | `IMPL-1120`/`1121` and `IMPL-1122` are allocated but **must not be scheduled** until the V1/V2 contradiction is resolved. ⚠ **Not silently resolved here** | EA owner + `ADR-0017` author |

**Five blockers are ⛔ hard-external. None is caused by `PRD-023`, and none is resolved by this document.**

### 4.1 The pre-existing scaffold — measured, not assumed

```
lib/platform/configuration/                       → does not exist
tool/module_dependencies.yaml: platform/configuration: 3   (rank only, no block)
`settings` inbound declarations                   → 7 (L108, 182, 240, 280, 309, 336, 513)
`provides_ports` occurrences in check_module_boundaries.dart → 0
test/architecture/                                → boundary_checker_test.dart only
```

There is **no code to contradict**, so this module records **no `D-023-nn` code contradictions** — unlike `PRD-014`,
which carried six. Everything below is greenfield.

### 4.2 A module that owns no aggregate — stated, not glossed

BC Map §8 lists **17 aggregates**; **`BC-25` owns none of them**, and §9's **14 producer rows include none**. That is
not an omission to be repaired by this backlog — BC Map §7 L292 is explicit: *"if not in this table it does not
exist."* `PRD-023` owns a **resolution algorithm, a register and a port**, which is why Wave 1 begins with
terminology and the register rather than with an aggregate, and why **no task creates one** (`CNF-GAP-001` is open,
B-6).

---

## 5. The 30 tasks

**Reading rules.** `Blocks` and `Blocked by` are within this backlog unless a foreign identifier is named. `P0` =
required before any other wave task can be trusted; `P1` = required for the module to function; `P2` = required for
the module to be *provably* correct. Every task cites the obligations it discharges; **no task cites an obligation
that does not exist**, and every Class A obligation is cited by at least one task (§6).

Each task carries all **ten** required fields. Six are in the table below — **ID**, **objective** (Task),
**requirement traceability** (Discharges), **priority**, **Blocked by**, **Blocks** — and four are stated once per
wave because they are uniform within it: **scope**, **affected module/package**, **security/tenant implications**,
**test requirements**. **Completion definition** is §10, which applies to every task without exception.

### 5.1 Wave 1 — Terminology, the register, the five scopes, the resolution algorithm (`IMPL-1100` … `IMPL-1109`)

> **Scope:** the vocabulary, the parameter register, and the resolution algorithm — no port, no validation, no UI.
> **Affected module:** `lib/platform/configuration/` (to be created), rank 3.
> **Security/tenant implications:** `IMPL-1103` is the tenant gate for the whole module — resolution may not proceed
> on an unresolved tenant scope. Every later task inherits it.
> **Test requirements:** unit tests per task, plus the determinism and totality properties of `IMPL-1105`/`1106`
> exercised as property tests, not examples. ⛔ None can currently be *proven* — B-2.

| ID | Task | Discharges | Priority | Blocked by | Blocks |
|---|---|---|---|---|---|
| `IMPL-1100` | Fix the Setting / Configuration distinction and the three non-synonyms in code vocabulary; forbid a second naming scheme | `CNF-FR-001`, `CNF-FR-004`, `CNF-FR-005`, `CNF-FR-007` | P0 | — | 1101, 1102 |
| `IMPL-1101` | Establish the parameter **register**: membership, per-parameter owning-PRD declaration, and the Setting↔register correspondence | `CNF-FR-002`, `CNF-FR-003`, `CNF-FR-030` | P0 | 1100 | 1102, 1104, 1110 |
| `IMPL-1102` | Address every parameter by the **owning PRD's stable identifier**, treated as permanent; retirement follows the register rule | `CNF-FR-006`, `CNF-FR-008` | P0 | 1100, 1101 | 1103, 1113 |
| `IMPL-1103` | Make scope identifiers **caller-supplied inputs**, and **refuse resolution on an unresolved tenant scope** | `CNF-FR-012`, `CNF-FR-013` | **P0** | 1102 | 1104, 1124, 1125 |
| `IMPL-1104` | Establish exactly **five** scopes in fixed order, structural and non-configurable, with scopes 4–5 traversed and empty **without error** | `CNF-FR-009`, `CNF-FR-010`, `CNF-FR-011` | P0 | 1101, 1103 | 1105, 1107 |
| `IMPL-1105` | Implement resolution as **strongest-scope-wins**, **total** and **deterministic** | `CNF-FR-014`, `CNF-FR-015`, `CNF-FR-016` | P0 | 1104 | 1106, 1108, 1114 |
| `IMPL-1106` | Prohibit **merging, blending or averaging** across scopes — a stronger scope replaces, never combines | `CNF-FR-017` | P0 | 1105 | 1129 |
| `IMPL-1107` | Expose the **resolving scope** for every resolved value | `CNF-FR-018` | P1 | 1104 | 1126, 1127 |
| `IMPL-1108` | Make **override removal** a distinct operation restoring the inherited value, writing nothing | `CNF-FR-019` | P1 | 1105 | 1122, 1127 |
| `IMPL-1109` | Prohibit storing a value **as an override at scope 1** by any route — API, role, actor, environment or maintenance path | `CNF-FR-020`, `CNF-FR-026` | **P0** | 1104 | 1111 |

### 5.2 Wave 2 — Validation, the `E-19` typed accessor, failure modes, invariant enforcement (`IMPL-1110` … `IMPL-1119`)

> **Scope:** every write's validation, the read surface, its failure semantics, and startup invariant enforcement.
> **Affected module:** `lib/platform/configuration/`, plus the **rank-0 shared kernel** `liboora_contracts` for the
> `IMPL-1113` interface declaration only.
> **Security/tenant implications:** `IMPL-1116` forbids fail-open. A configuration module that degrades gracefully
> is a configuration module that silently changes behaviour, so **no substitution path may exist**.
> **Test requirements:** each failure mode needs a test asserting **failure**, not a value; `IMPL-1112` needs a test
> detecting both a **missing** and an **extra** invariant.

| ID | Task | Discharges | Priority | Blocked by | Blocks |
|---|---|---|---|---|---|
| `IMPL-1110` | Validate every write against declared **type and range**; refuse rather than clamp, coerce or default; require both to be declared at registration | `CNF-FR-021`, `CNF-FR-024` | P0 | 1101 | 1111, 1112 |
| `IMPL-1111` | Make refusal **specific and atomic**: a reason naming parameter and constraint, no partial application, identical validation on **every** path including seed, migration and diagnostic | `CNF-FR-022`, `CNF-FR-023`, `CNF-FR-025` | P0 | 1109, 1110 | 1119, 1127 |
| `IMPL-1112` | Enforce the published invariant set at **startup**: fail on any violation, report **all** violations, cover every environment, and make the enforced set **equal** the published set — see §3.4 on `IMPL-015` | `CNF-FR-047`, `CNF-FR-048`, `CNF-FR-049`, `CNF-FR-050`, `CNF-INV-001`, `CNF-INV-002` | **P0** | 1110 | 1114, 1126, 1129 |
| `IMPL-1113` | Declare the typed accessor interface in the **rank-0 shared kernel**, bind the implementation at the composition root, and let **no consumer import the module** — closes the orphan `settings` port from this side | `CNF-FR-031`, `CNF-FR-039`, `CNF-FR-040`, `CNF-FR-041` | P0 | 1102 | 1114, 1115, 1128 |
| `IMPL-1114` | Make the port **synchronous**, the **sole** route to a value, and **conformist** toward consumers | `CNF-FR-032`, `CNF-FR-033`, `CNF-FR-034` | P0 | 1105, 1112, 1113 | 1116, 1124 |
| `IMPL-1115` | Establish what **typed** means — all four properties — and forbid any accessor taking a parameter identifier as a **runtime string** | `CNF-FR-035`, `CNF-FR-036` | P0 | 1113 | 1116, 1129 |
| `IMPL-1116` | Forbid a **generic read surface** — no `get(key)`, `getAll()`, map or key enumeration — and make the readable set **statically enumerable** | `CNF-FR-037`, `CNF-FR-038` | P0 | 1114, 1115 | 1129 |
| `IMPL-1117` | Fail a read of an **unregistered** parameter and a read **before load and validation** — never null, never a default | `CNF-FR-042`, `CNF-FR-043` | **P0** | 1112, 1114 | 1118 |
| `IMPL-1118` | Fail a **stored value that violates its own declared type or range at read time** | `CNF-FR-044` | P1 | 1117 | 1119 |
| `IMPL-1119` | Forbid every **recovery-by-substitution** path — no degraded mode, no fail-open, no stale-cache read, and no cache reuse across differing scope identifiers | `CNF-FR-045`, `CNF-FR-046`, `CNF-FR-067` | **P0** | 1111, 1118 | 1125, 1129 |

### 5.3 Wave 3 — Flags, branding, secrets, audit, authority, isolation, observability, UI, acceptance (`IMPL-1120` … `IMPL-1129`)

> **Scope:** the boundaries. Nine of these ten tasks are predominantly **prohibitions** — the module's correctness is
> mostly a matter of what it cannot do.
> **Affected module:** `lib/platform/configuration/`; `IMPL-1128` additionally requires a block in
> `tool/module_dependencies.yaml` (⛔ B-1); `IMPL-1129` requires `test/architecture/` (⛔ B-2).
> **Security/tenant implications:** the highest in the backlog. `IMPL-1122` (secrets), `IMPL-1125` (tenant
> isolation) and `IMPL-1126` (no secret in telemetry) are each independently sufficient to cause a cross-tenant or
> credential disclosure if wrong.
> **Test requirements:** `IMPL-1125` requires the **missing** `tenant_isolation_test.dart`; `IMPL-1129` builds the
> harness that turns all 59 criteria into executing tests. ⛔ Both gated on B-2.

| ID | Task | Discharges | Priority | Blocked by | Blocks |
|---|---|---|---|---|---|
| `IMPL-1120` | Treat a **flag as an ordinary boolean parameter** — same declaration route, same resolution path, rollout by override at a scope; **no** cohort, ramp, variant, experiment or targeting mechanism. ⛔ **Do not schedule until B-9 resolves** | `CNF-FR-051`, `CNF-FR-052`, `CNF-FR-053`, `CNF-FR-054` | P1 | 1105 | 1121 |
| `IMPL-1121` | Hold the **`BC-21` boundary**: a flag answers *is this on*, never *is this paid for*; neither implies the other; both required where both apply; and **no call to `business.entitlement`**, no entitlement type, no authorisation decision | `CNF-BR-001`, `CNF-BR-002`, `CNF-BR-003`, `CNF-XC-004`, `CNF-XC-005`, `CNF-XC-006` | **P0** | 1120 | 1129 |
| `IMPL-1122` | Hold **branding = values only** and **secrets = references only**: a `FileRef` for images, never material, never resolution, never a credential — and forbid the `LibraryBranding` aggregate, upload/scan/thumbnail/signed-URL work, and flag misuse against controls, invariants and audit. ⛔ **B-9** | `CNF-FR-055`, `CNF-FR-056`, `CNF-FR-057`, `CNF-FR-058`, `CNF-BR-004`, `CNF-BR-005`, `CNF-XC-007`, `CNF-XC-008`, `CNF-XC-009` | **P0** | 1108 | 1126, 1129 |
| `IMPL-1123` | Emit every committed write as an audit fact **through `E-20`**, distinguish removal from setting, keep **no second version history**, and **publish no domain event** — configuration history reconstructible from the trail, changes effective only forward | `CNF-FR-060`, `CNF-FR-061`, `CNF-FR-062`, `CNF-FR-063`, `CNF-BR-006`, `CNF-BR-007`, `CNF-XC-010`, `CNF-XC-013` | P1 | 1111 | 1129 |
| `IMPL-1124` | Require **authorisation upstream** and **actor + scope as explicit arguments**; expose **no** write surface reachable without passing the authorising boundary; treat authority as the **owning PRD's** to define | `CNF-FR-064`, `CNF-FR-065`, `CNF-FR-066`, `CNF-BR-008`, `CNF-BR-009`, `CNF-BR-010`, `CNF-XC-014` | **P0** | 1103, 1114 | 1129 |
| `IMPL-1125` | Enforce **tenant isolation**: fail on absent tenant identifier; put the tenant identifier in **every** cache key, index, lookup key and namespace; treat a change to any as security-reviewable; and make cross-tenant values unreachable and unobservable — including via refusal reasons. ⛔ **B-2: `tenant_isolation_test.dart` does not exist** | `CNF-FR-068`, `CNF-FR-069`, `CNF-FR-070`, `CNF-INV-003`, `CNF-INV-004`, `CNF-XC-011`, `CNF-XC-012` | **P0** | 1103, 1119 | 1129 |
| `IMPL-1126` | Emit failed resolutions, rejected writes, the **startup validation outcome as a discrete signal carrying every violated invariant**, and the resolving scope — through the registered observability port, with **no secret reference emitted in any log, telemetry attribute, error message or audit payload**, and no resolved secret value ever emitted, and no alert thresholds or dashboards defined here | `CNF-FR-059`, `CNF-FR-071`, `CNF-FR-072`, `CNF-FR-073`, `CNF-FR-074`, `CNF-FR-075`, `CNF-BR-011`, `CNF-XC-015` | P1 | 1112, 1122 | 1129 |
| `IMPL-1127` | Make the surface express **inherited vs overridden**, name the source scope, offer **reset-to-inherited** as a distinct action, show the declared range before submission, attach a refusal to its field, render read-only where readable-but-not-writable, and be portrait-optimised and accessible — while defining **no design token, colour, type or component**. ⛔ **B-3** | `CNF-FR-076`, `CNF-FR-077`, `CNF-FR-078`, `CNF-FR-079`, `CNF-FR-080`, `CNF-FR-081`, `CNF-FR-082`, `CNF-XC-016` | P2 | 1107, 1108, 1111 | 1129 |
| `IMPL-1128` | Enforce **rank-3 placement and the ownership boundary**: serve only parameters an owning PRD declared, hold none of the 104 definitions, and **never** define, re-range, re-default, rename, retire or reclassify one; nor restate `LCFG-1`…`13`; nor author or reinterpret an invariant **statement**; nor infer the active environment. ⛔ **B-1: no module block exists, so `check_module_boundaries.dart` L778 exempts this module from the deny default** | `CNF-FR-027`, `CNF-FR-028`, `CNF-FR-029`, `CNF-XC-001`, `CNF-XC-002`, `CNF-XC-003` | **P0** | 1113 | 1129 |
| `IMPL-1129` | Build the acceptance harness turning `CNF-AC-001`…`CNF-AC-059` from prose into **executing tests**. ⚠ **16 of the 113 obligations are `CNF-XC-*` exclusions carrying no criterion by construction** (§6.2) — the harness must assert **absence**, which is a different test shape from asserting behaviour. ⛔ **B-2** | All 59 `CNF-AC-*` | **P0 for verification** | 1106, 1112, 1116, 1119, 1121, 1122, 1123, 1124, 1125, 1126, 1127, 1128 | — |

---

## 6. Traceability — task group → requirements → invariants → acceptance

Required by allocation rule 4.

| Wave | Tasks | Requirements discharged | Invariants | Acceptance criteria |
|---|---|---|---|---|
| **1** — terminology, register, scopes, resolution | `IMPL-1100`…`1109` | `CNF-FR-001`…`020`, `026`, `030`; `CNF-FR-006`…`008` | — | `CNF-AC-001`…`013` (§13.1, §13.2) |
| **2** — validation, port, failure, invariants | `IMPL-1110`…`1119` | `CNF-FR-021`…`025`, `031`…`047`…`050`, `067` | `CNF-INV-001`, `CNF-INV-002` | `CNF-AC-014`…`035` (§13.3–§13.6) |
| **3** — boundaries, isolation, observability, UI | `IMPL-1120`…`1129` | `CNF-FR-051`…`082`; `CNF-BR-001`…`011`; `CNF-XC-001`…`016` | `CNF-INV-003`, `CNF-INV-004` | `CNF-AC-036`…`059` (§13.7–§13.9) |

**All 4 invariants are claimed:** `CNF-INV-001`/`002` by `IMPL-1112`, `CNF-INV-003`/`004` by `IMPL-1125`.

### 6.1 Coverage

| Register | Members | Claimed by ≥1 task | Coverage |
|---|---|---|---|
| `CNF-FR-*` | 82 | 82 | **100.0%** |
| `CNF-BR-*` | 11 | 11 | **100.0%** |
| `CNF-INV-*` | 4 | 4 | **100.0%** |
| `CNF-XC-*` | 16 | 16 | **100.0%** |
| **Class A total** | **113** | **113** | **100.0%** |
| `CNF-AC-*` | 59 | 59 (by `IMPL-1129`) | **100.0%** claimed · ⛔ **0 proven** |

**No task claims zero obligations, and no task cites an obligation that does not exist** — every identifier above is
drawn from the inventory frozen by Stage 5 at **180**.

### 6.2 Why 100% task coverage sits beside 67.3% acceptance coverage — the two are different claims

Stage 5 published **76 / 113 = 67.3%** acceptance coverage. This document publishes **113 / 113 = 100.0%** task
coverage. Both are true, and the difference is not slack:

- **Task coverage** asks *is this obligation somebody's work?* Every obligation is, including the 16 `CNF-XC-*`
  exclusions — enforcing a prohibition is real work (`IMPL-1121`, `1122`, `1128`).
- **Acceptance coverage** asks *is this obligation observably provable?* An exclusion states what must be
  **impossible**, and a criterion asserting that something never happens is **unfalsifiable by observation**.

⚠ **This is the honest reading, and the trap it avoids is worth naming:** it would have been easy to write
`IMPL-1129` as *"prove all 113 obligations"* and publish 100% on both lines. That would restate the `PRD-006` v1.0
failure — *"100% coverage"* against a true **49.1%** — in a new column. `IMPL-1129`'s field therefore says the
exclusion tests are a **different shape** rather than pretending they are the same.

---

## 7. Critical path

`IMPL-1100` → `1101` → `1102` → **`1103`** → `1104` → `1105` → `1114` → `1129`

Eight of the thirty are **P0 for reasons of security or tenancy rather than sequence**: `IMPL-1103` (no resolution on
an unresolved tenant), `1109` (no runtime write at scope 1), `1112` (no read while an invariant is unsatisfied),
`1117` (no read before load), `1119` (no fail-open), `1121` (no entitlement coupling), `1122` (no secret material),
`1124` (no unauthorised write path), `1125` (no cross-tenant reachability). **None may be deferred to make the path
shorter.**

---

## 8. Tasks that must **not** be created

| Forbidden task | Why |
|---|---|
| *"Define the configuration parameter set"* | **The gravest one.** All 104 configurables belong to 8 **FROZEN** PRDs. `CNF-XC-001` forbids defining, re-ranging, re-defaulting, renaming, retiring or reclassifying any of them |
| *"Add a `CNF-CFG-*` register member"* | `CNF-CFG-*` is **declared empty** and Stage 5 found no authoritative evidence requiring a member. Both checkers now **fail** if one appears |
| *"Publish a `configuration.SettingChanged` event"* | `BC-25` has **0** producer rows in BC Map §9. `CNF-XC-010` and `IMPL-1123` require publish-nothing |
| *"Set the resolution cache TTL"* / *"Meet a resolution latency budget"* | **B-4.** No document at any rank bounds either. Naming one invents an NFR |
| *"Define the settings screen design tokens"* | `CNF-XC-016`; the UI Design System is **Rank 1** (B-3) |
| *"Add a sixth scope"* / *"Make the scope count configurable"* | `CNF-FR-010`, `CNF-AC-012` — structural, not configurable |
| *"Resolve secret references"* | `CNF-FR-058`, `CNF-XC-009`. References only — and V1/V2 is contested (B-9) |
| *"Create the `LibrarySettings` aggregate"* | `CNF-GAP-001` is **open and contested** with `BC-02` (B-6) |
| *"Extend `IMPL-015` to `INV-16`"* | That is `PRD-001`'s task or a new one, and `CNF-GAP-005` is open. `IMPL-1112` states the **equality obligation** without choosing the mechanism (§3.4) |
| *"Write the `platform/configuration` module block"* | `CNF-GAP-007`, Architecture Owner (B-1). `IMPL-1128` states the obligation the block would enforce |
| *"Resolve the V1/V2 contradiction"* | `CNF-GAP-006` (B-9) — an EA and `ADR-0017` matter. **Not silently resolved here** |

---

## 9. What this document does **not** claim

- **Not that the module works.** ⛔ **0 of 59** criteria are proven; no implementation exists.
- **Not that Stage 6 confers Stage 7.** Freeze is conferred in `DOCUMENTATION_BASELINE.md` §3, which contains **no
  row admitting `PRD-023`**.
- **Not that any gap is closed.** All **8** `CNF-GAP-*` remain **OPEN**.
- **Not that the blockers are scheduled.** Five are ⛔ hard-external, owned elsewhere (§4).
- **Not that the PRD changed.** Hash `e974960…`, verified unchanged.
- **Not that any frozen document changed.** No `PRD-001`/`002`/`003`/`004`/`005`/`006`/`007` parameter touched.

---

## 10. Definition of done — applies to every task

A task is done when, and only when:

1. The obligations it cites are satisfied **in code**, not in comment.
2. A test exercises each cited obligation, and **fails if the obligation is removed** — the mutation standard Stage 5
   held itself to.
3. For an exclusion, the test asserts **absence** — a static or structural check, not a behavioural one (§6.2).
4. `dart run tool/check_module_boundaries.dart` does not regress, **and** the `platform/configuration` block exists
   so that L778 no longer exempts this module (⛔ B-1).
5. `flutter analyze` and `dart format` are clean.
6. `TRACEABILITY_MATRIX.md` §2L's Status column is updated **in the same commit**, per `DEFINITION_OF_DONE.md`
   Gate 2.
7. No parameter definition, default, range, token, budget or event was added (§8).

---

## 11. Stage 6 exit gate

`PRD_LIFECYCLE.md` L137: *"an `IMPL-*` range allocated and a task document in which **every task traces back to
requirements**."*

| Gate clause | State |
|---|---|
| Range allocated | ✅ **`IMPL-1100` … `IMPL-1129`**, next-free by two independent routes, previous group's reserve untouched (rule 1, rule 2) |
| Task document exists | ✅ this file, at the precedent path `40-implementation/<module>/` |
| Every task traces back to requirements | ✅ 30 tasks, **113 of 113** Class A obligations claimed, **0** tasks citing zero obligations, **0** citations of non-existent identifiers |
| `Priority`, `Blocks`, `Blocked by` per task | ✅ rule 3 — all 30 rows |
| Traceability table | ✅ §6, rule 4 — task group → requirements → invariants → acceptance |

### 11.1 The gate is measured, and was proven able to fail

A third instrument, `tool/docs_check/prd023_task_coverage.py`, parses the **task document** — which neither of the
Stage 5 checkers opens — and re-derives the PRD's obligation set itself rather than trusting a number either of them
published. Nine checks: range declared in the header · contiguity with no duplicates · nothing outside the range,
nothing reaching into `PRD-014`'s reserve, nothing claiming `IMPL-015`/`016` · every cited obligation exists · every
Class A obligation claimed and the published figure reproduced · no task claiming nothing · rule-3 fields on every
row · the rule-4 table non-vacuous · **both empty registers still empty**.

⚠ **It failed this document on its first run, and the document was corrected rather than the figure.** The header
published **113 of 113** while **`CNF-FR-059`** — no secret reference in any log, telemetry attribute, error message
or audit payload — was claimed by **no task**. Publishing 113 when 112 was true would have been the `PRD-006` v1.0
failure (*"100% coverage"* against a true 49.1%) reproduced in a new column, in the very document that names that
failure in §6.2. `CNF-FR-059` is now discharged by `IMPL-1126`, where the emission prohibition belongs, and the
recomputation reports **113 / 113**.

**Mutation-tested: 7 injected, 7 caught.**

| # | Injected defect | Caught |
|---|---|---|
| M12 | renumber a task outside the allocated range | ✅ hole **and** out-of-range, both reported |
| M13 | reach into `IMPL-1030`…`1099`, `PRD-014`'s reserve | ✅ named as an **allocation rule 2** breach |
| M14 | cite a non-existent `CNF-FR-099` | ✅ *"reads as diligent while discharging nothing"* |
| M15 | drop an obligation, leaving it unclaimed | ✅ unclaimed **and** the published figure contradicted |
| M16 | **mint a configurable** (`CNF-CFG-*`) in a task | ✅ caught twice — non-existent **and** the empty-register prohibition |
| M17 | empty a `Priority` cell | ✅ **rule 3** |
| M18 | duplicate a task number | ✅ **rule 1**, plus count and hole |

The document was restored **byte-identical** after every mutation.

✅ **STAGE 6 — PASS.**

---

## 12. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-20 | Stage 6. Range `IMPL-1100`…`1129` allocated, 30 tasks in 3 waves, 113/113 Class A obligations claimed, `IMPL-1130`…`1199` declared growth reserve. **9 external blockers classified**, 5 of them ⛔ hard. 11 forbidden tasks enumerated. `IMPL-015`/`016` relationship stated without duplication or gap-closure. Gate **measured** by a third committed checker, `prd023_task_coverage.py`, which **failed this document on its first run** over an unclaimed `CNF-FR-059` — corrected in the document, not the figure — and is **mutation-tested 7/7** |
