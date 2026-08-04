# Liboora — Dependency Graph (as built)

| Field | Value |
|---|---|
| **Document** | Dependency Graph — the **as-built** state of the module graph |
| **Version** | v1.0 |
| **Status** | Active — regenerate whenever `tool/module_dependencies.yaml` changes |
| **Date** | 2026-08-04 |
| **Normative source** | [`LIBOORA_MODULE_DEPENDENCY_MATRIX.md`](./LIBOORA_MODULE_DEPENDENCY_MATRIX.md) — the *rules* |
| **Machine source** | [`../../tool/module_dependencies.yaml`](../../tool/module_dependencies.yaml) — the *manifest* |
| **Verified by** | [`../../tool/check_module_boundaries.dart`](../../tool/check_module_boundaries.dart) (`IMPL-014`) |

---

## 1. What this document is, and what it is not

The Dependency **Matrix** states what is *allowed*. This document states what the code *currently does*, and
where the two differ.

Keeping them separate is deliberate. If the as-built graph were edited into the Matrix, then every accommodation
made for existing code would silently become a rule, and the architecture would drift by documentation rather
than by decision. The Matrix is normative; **this document is descriptive and may legitimately show violations.**

> **Read this document with the checker output beside it.** Anything asserted here is reproducible by running
> `dart run tool/check_module_boundaries.dart`.

---

## 2. Ranks as built

22 modules. Rank determines legal dependency direction: **strictly downward** (law `L2`).

| Rank | Module | Kind | Notes |
|---:|---|---|---|
| **0** | `contracts` → `packages/liboora_contracts/lib` | Shared kernel | Pure Dart. Empty `dependencies:` enforces `L5` |
| 1 | `platform/infrastructure` | Capability | |
| 2 | `platform/data` · `platform/security` | Capability | |
| 3 | `platform/configuration` · `platform/observability` · `platform/services` · `platform/event` | Capability | |
| 4 | `platform/tenancy` · `platform/identity` | Capability | `AuthService` lives here |
| 5 | `platform/audit` · `platform/search` · `platform/communication` · `platform/integration` | Capability | |
| 6 | `platform/business` · `platform/workflow` · `platform/ai` | Capability | |
| 7 | `platform/analytics` | Capability | |
| **7.5** | **`domain/person`** | **Domain `[CORE]`** | Created by `ADR-0011`. Parses as a float |
| 8 | `domain/library` · `domain/social` | Domain | |
| 9 | `app` | Composition root + UI | The only module allowed to know concrete types on both sides of a port |

### 2.1 Why 7.5 exists

`BC-10` Global Person Identity is consumed by every library context and consumes none of them. It therefore sits
**below** the library domain (which depends on it) and **above** every platform capability (which it depends on).
There was no integer slot: rank 7 is `platform/analytics`, a capability, and law `L4` forbids a capability
depending on a domain.

`ADR-0011` chose a fractional rank rather than renumbering fifteen modules. The trade-off is recorded as `RSK-08`
in the [Risk Report](../40-implementation/STUDENT_IDENTITY_RISK_REPORT.md): a further fractional rank should
require an ADR arguing the *domain* position, not merely convenience.

---

## 3. The keystone edge: rank 4 → rank 7.5

This is the only place where the approved architecture appeared to conflict with the Five Laws, so the as-built
resolution is drawn explicitly.

`SID-4.11` requires the person identity to be created **synchronously, in the same unit of work** as the account.
`AuthService` is rank 4; `PersonIdentity` is rank 7.5. A rank-4 module cannot depend on rank 7.5.

```
                      ┌──────────────────────────────────────┐
   rank 0             │  packages/liboora_contracts          │
   contracts          │    abstract interface class          │
                      │      PersonIdentityFactory           │
                      └──────────────┬───────────────────────┘
                          implements │ │ depends on
                    ┌────────────────┘ └────────────────┐
                    │                                   │
   rank 7.5  ┌──────┴───────────────┐   rank 4  ┌───────┴──────────────┐
   domain/   │ PersonIdentityService│   platform│ AuthService          │
   person    │ PersonIdentity (agg) │   /identity│ calls factory.mint()│
             └──────┬───────────────┘           └───────┬──────────────┘
                    │                                   │
                    └───────────► rank 9 ◄──────────────┘
                          lib/bootstrap/di.dart
                       (composition root wires both)
```

Both modules depend **downward on rank 0**, which `L2` permits. The call is an ordinary synchronous method
invocation, so it executes inside the caller's unit of work and `SID-4.11` holds literally.

**No law gained an exception for this edge.** Verified: the checker reports **zero** findings naming
`domain/person`.

---

## 4. Communication modes as built

Matrix §4 defines the modes. The default when unspecified is `◇` **port**, for which
*"Compile-time import allowed? **No**"*. Matrix §12 grants exactly **one** direct-import permission
(`liboora_contracts`).

| Mode | Meaning | As-built usage |
|---|---|---|
| `◇` port | Consumer declares an interface, provider implements it, DI wires it. **No import** | The target state for all 13 debt edges; already achieved for `PersonIdentityFactory` |
| Event | Fire-and-forget through the event bus | Used within `domain/library` |
| Command | Directed request with re-validation | Not yet used |
| Direct import | Compile-time dependency | **Permitted only for `contracts`** |

---

## 5. Edges as built

### 5.1 Conformant edges

| Edge | Mode | Status |
|---|---|---|
| every module → `contracts` (rank 0) | direct import | ✅ The one permitted direct import |
| `platform/identity` (4) → `contracts` → `domain/person` (7.5) | `◇` port | ✅ **`E-12`**, same transaction (`SID-4.11`) |
| `domain/library` (8) → `contracts` → `domain/person` (7.5) | `◇` port through an ACL | ✅ **`E-13`**, the only bridge between the two worlds |
| `domain/social` (8) → `PersonId` | shared kernel | ✅ **`E-15`**; social stores no identity fields (`SID-BR-11`) |
| `app` (9) → `platform/*` , `domain/*` | composition | ✅ Legal by rank; see §5.2 for mode debt |

### 5.2 Non-conformant edges (dependency *direction* legal, *mode* wrong)

All 13 edges below have **correct rank direction**. What is wrong is that they import a concrete class where a
port is required. All pre-date this migration; all are governed by
[`ADR-0012`](../00-governance/adr/ADR-0012-scaffold-port-inversion-debt.md).

| Consumer | Provider | Sites | Waived until | Wave |
|---|---|---:|---|---|
| `platform/business` (6) | `platform/tenancy` (4) | 1 | 2026-10-31 | 1 |
| `platform/analytics` (7) | `platform/event` (3) | 1 | 2026-10-31 | 1 |
| `domain/library` (8) | `platform/event` (3) | 5 | 2026-12-31 | 2 |
| `domain/library` (8) | `platform/audit` (5) | 1 | 2026-12-31 | 2 |
| `domain/library` (8) | `platform/data` (2) | 5 | 2027-03-31 | 3 |
| `domain/library` (8) | `platform/services` (3) | 2 | 2027-03-31 | 3 |
| `domain/library` (8) | `platform/identity` (4) | 5 | 2027-03-31 | 3 |
| `domain/library` (8) | `platform/business` (6) | 2 | 2027-03-31 | 3 |
| `app` (9) | `platform/identity` (4) | 2 | 2027-03-31 | 4 |
| `app` (9) | `platform/tenancy` (4) | 2 | 2027-03-31 | 4 |
| `app` (9) | `platform/analytics` (7) | 1 | 2027-03-31 | 4 |
| `app` (9) | `platform/business` (6) | 1 | 2027-03-31 | 4 |
| **`app` (9)** | **`domain/library` (8)** | **9** | ⛔ **NOT waived** | `TASK-D10` |

**Total: 37 findings across 13 edges. 28 waived, 9 blocking.**

### 5.3 The unwaived edge

`app → domain/library` is **deliberately absent** from the exception list. Those nine imports exist only to render
demo dashboards, and they are already tracked by `TASK-D10 — remove demo surfaces`, a **P0 release blocker**.

From `ADR-0012` §3.4:

> *"Waiving an edge that is already scheduled to disappear would convert a tracked release blocker into
> untracked debt."*

So gate 3 exits 1 and the pipeline is red. A test asserts the edge stays unwaived, so making it green requires
turning the test suite red — the shortcut is not silent.

---

## 6. Cycles

**Zero.** One existed and was repaired during this migration:

```
BEFORE:  lib/bootstrap/di.dart ──► lib/bootstrap/seed.dart
                              ◄──┘                                (cycle)

AFTER:   di.dart declares:  typedef ContainerSeeder =
                              Future<void> Function(AppContainer, List<Account>)
         main.dart supplies: AppContainer.boot(seeder: seedDemoData)
```

Law `L1` is *"the one law with zero exceptions"* (Matrix §2), and §11 step 3 records that it is **never** approved
for waiver. There was therefore no governance route: the code had to change. The fix is Matrix §8.2
**port inversion (callback)** — one of the four documented patterns, of which *"there is no fifth option"*.

`L1` is now asserted by a test, and the checker treats `circular-dependency` as **structurally unwaivable**: a
syntactically valid exception naming that edge is ignored, and the cycle still blocks.

---

## 7. Enforcement status per law

| Law | Statement | Enforced | Findings |
|---|---|---|---|
| `L1` | Acyclic — zero exceptions | ✅ Checker + test | 0 |
| `L2` | Downward only; same-rank forbidden outside a cluster | ✅ Checker | 0 |
| `L3` | Domain depends only on ports it declares | ✅ Checker | 37 (mode debt) |
| `L4` | Capability never depends on a domain | ✅ Checker | 0 |
| `L5` | Contracts import nothing | ✅ Checker — **meaningfully, since `R-5`** | 0 |

> **`L5` was previously certified against nothing.** `contracts.path` pointed at `lib/contracts`, a directory that
> has never existed in this repository (defect `R-5`). Fixed to `packages/liboora_contracts/lib`. Before the fix,
> a green `L5` result was an artefact of scanning an empty directory.

---

## 8. Two checks that are **not** enforced

Matrix §10.2 lists nine checks. Ten categories are implemented, but these two are **not built**:

| Missing check | Rule | Consequence |
|---|---|---|
| Tenant-key enforcement | `X-13` | A cross-tenant query would pass CI |
| Audit immutability | `X-10` | A mutated audit entry would pass CI |

Per `SID-4.56` — *"a rule that cannot be checked SHALL be treated as unmet"* — **these two rules are unmet.** They
must not be presumed enforced because the other ten are. Tracked as `RSK-03`.

---

## 9. Metrics

| Metric | Value |
|---|---|
| Modules | 22 |
| Ranks in use | 11 (including the fractional 7.5) |
| Direct-import permissions | **1** (`liboora_contracts`) |
| Cycles | **0** |
| `L2` / `L4` / `L5` violations | **0** |
| `L3` mode violations | 37 → 9 blocking, 28 waived |
| Dated exceptions | 12, all citing `ADR-0012`, earliest expiry **2026-10-31** |
| Findings naming `domain/person` | **0** |
| Enforcement categories implemented | 10 of 12 specified |

---

## 10. How to regenerate

```bash
dart run tool/check_module_boundaries.dart      # exit 0 clean · 1 violations · 2 bad manifest
flutter test test/architecture/                 # verifies the checker itself
```

This document must be revised whenever an `ADR-0012` wave closes, when `TASK-D10` lands, or when the manifest
changes. If it disagrees with the checker, **the checker is right**.

---

## 11. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-04 | Created after the first-ever execution of `IMPL-014`. Records the as-built graph including rank 7.5, the rank-4 → rank-7.5 keystone port, the repaired `L1` cycle, the 13 mode-debt edges with expiry waves, the deliberately unwaived `app → domain/library` edge, and the two Matrix §10.2 checks that remain unimplemented. |
