# ADR-0012 — V1 scaffold port-inversion debt is time-boxed, not forgiven

| Field | Value |
|---|---|
| **Status** | **Accepted** |
| **Date** | 2026-08-04 |
| **Deciders** | Principal Software Architect; Technical Governance Architect; Enterprise Refactoring Lead |
| **Supersedes** | Nothing |
| **Amends** | Nothing. Adds 12 dated entries to `module_dependencies.yaml` `exceptions:` under the process defined in `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` §11 |
| **Amended by** | — |
| **Baseline** | `BASELINE-2026-08-04` |
| **Related** | `ADR-0001` (modular monolith) · `ADR-0011` (Global Person Identity) · Module Dependency Matrix §4, §6, §8.2, §10.2, §11 · `IMPL-014` |

---

## 1. Context

`IMPL-014` — the automated boundary checker at `tool/check_module_boundaries.dart` — was
implemented and executed for the first time on 2026-08-04, as part of the Student Identity
architecture migration (`ADR-0011`).

Until that moment, every dependency law in this repository was enforced by code review alone.
`SID-4.56` states the governing principle:

> *"A rule that cannot be checked SHALL be treated as unmet, not as satisfied by intent."*

By that standard the five dependency laws had never been enforced at all. The first run
confirmed it, reporting **38 violations** against the pristine `HEAD` (`9f15750`):

| Category | Count | Verdict |
|---|---|---|
| `circular-dependency` (**L1**) | 1 | **Fixed in code.** See §3.1 |
| `cross-context` | 37 | Pre-existing scaffold debt. This ADR |
| rank ordering (**L2**) | 0 | — |
| layer violations (**L4**) | 0 | — |
| illegal kernel imports (**L5**) | 0 | — |
| forbidden dependencies | 0 | — |
| same-rank violations | 0 | — |
| ownership violations | 0 | — |
| barrel violations | 0 | — |
| architecture policies | 0 | — |

**Two facts establish that this debt is not a consequence of the Student Identity migration.**

1. Running the checker against a stashed working tree — pristine `9f15750`, before any
   migration edit — produced the **same 37 cross-context findings**, plus the cycle.
2. The migration introduced **zero** new violations. `domain/person`, the bounded context
   created by `ADR-0011` at rank 7.5, appears in **no** finding. Its dependency on the rank-0
   `PersonIdentityFactory` port is exactly what the matrix §8.2 prescribes, and the checker
   confirms it mechanically rather than by assertion.

The migration therefore *reduced* the violation count from 38 to 37 and left the remainder
untouched. That remainder is what this ADR governs.

---

## 2. The problem

The matrix is unambiguous. §4 defines the **Port** mode as *"Consumer declares an interface;
provider (or an adapter) implements it; DI wires it at the composition root. Consumer imports
**no** provider code"* — with *"Compile-time import allowed? **No**"*. §6 gives every domain and
platform module `may_import: [ liboora_contracts ]` and nothing else. §12 states the ratio
plainly:

> *Direct-import permissions | **1** (`liboora_contracts` only)*

The V1 scaffold was built differently. It injects **concrete platform classes** through
constructors — `EventBus`, `AuditTrail`, `TenantPartitionedStore`, `AuthService`,
`EntitlementService`, `IdempotencyService` — instead of having each consumer declare a narrow
port that an adapter implements. Dependency *direction* was respected throughout, which is why
zero L2 and zero L4 violations exist. What is missing is the *inversion*.

The 13 edges the checker reports, all strictly downward in rank:

| Consumer | Provider | Ranks | Sites | Already a declared port? |
|---|---|---|---|---|
| `app` | `domain/library` | 9 → 8 | 9 | Yes — `domain/library` |
| `app` | `platform/identity` | 9 → 4 | 2 | Yes — `platform/identity:auth` |
| `app` | `platform/tenancy` | 9 → 4 | 2 | Yes — `platform/tenancy:tenant_context` |
| `app` | `platform/analytics` | 9 → 7 | 1 | Yes — `platform/analytics:read_model` |
| `app` | `platform/business` | 9 → 6 | 1 | Yes — `platform/business:entitlement` |
| `domain/library` | `platform/data` | 8 → 2 | 5 | Yes — `platform/data:repository` |
| `domain/library` | `platform/identity` | 8 → 4 | 5 | Yes — `platform/identity:policy_decision` |
| `domain/library` | `platform/event` | 8 → 3 | 5 | **No** |
| `domain/library` | `platform/services` | 8 → 3 | 2 | Yes — five service ports |
| `domain/library` | `platform/business` | 8 → 6 | 2 | Yes — `:entitlement`, `:payment_intent` |
| `domain/library` | `platform/audit` | 8 → 5 | 1 | **No** |
| `platform/analytics` | `platform/event` | 7 → 3 | 1 | **No** |
| `platform/business` | `platform/tenancy` | 6 → 4 | 1 | **No** |

Nine of the thirteen edges are **already declared as ports** in the manifest. For those, the
manifest and the documentation agree with each other and only the *code* is wrong: the
interface was never extracted, so the consumer imports the implementation. Four edges are not
declared at all and need a port declaration as well as an extraction.

---

## 3. Decision

### 3.1 The one law with no exceptions is fixed in code, immediately

`L1` (acyclic) is *"the one law with zero exceptions"* (§2) and §11 step 3 states it is
**never** approved by the Architecture Review Board. The reported cycle —
`lib/bootstrap/di.dart -> lib/bootstrap/seed.dart -> lib/bootstrap/di.dart` — was therefore
**not** a candidate for a waiver and has been repaired in code, using the documented §8.2 port
inversion:

`AppContainer.boot` now accepts an optional `ContainerSeeder` typedef rather than importing
`seed.dart` to call `seedDemoData` directly. The composition root (`main.dart`), which
legitimately knows both files, supplies the seeder. The edge now runs one way only:
`seed -> di`.

This is recorded here rather than as a separate ADR because it changed no boundary, no
ownership and no rule — it removed a cycle that the documentation already forbade.

### 3.2 The 37 cross-context findings become 12 dated exceptions

The four remaining options were considered:

| Option | Assessment |
|---|---|
| **A. Weaken the checker** so `mode: port` tolerates an import | **Rejected.** This is the failure the matrix was written to prevent: *"An architecture diagram that is not mechanically enforced degrades to fiction within two quarters."* It would also make `ADR-0011`'s rank 7.5 unverifiable, which was the entire reason `IMPL-014` exists |
| **B. Amend the manifest** to declare these as `mode: import` | **Rejected.** The manifest is not wrong. §6 and §12 permit exactly one direct import, `liboora_contracts`. Declaring 13 more would silently rewrite the documented architecture to match the code — the inverse of the instruction that documentation is the source of truth |
| **C. Extract all 13 ports now** | **Rejected for this change.** It means defining ~13 interfaces and adapters across five modules, touching attendance, seating, membership, fee, policy, analytics, business and every dashboard. None of it is required by `ADR-0011`, and all of it carries regression risk in code the Student Identity migration does not otherwise touch. Mixing an unrelated refactor of that size into a migration commit is how migrations become unreviewable |
| **D. Record it as dated, ADR-backed debt** (§11) | **Accepted** |

Option D is the mechanism the matrix itself specifies for exactly this situation, and §11 step 5
supplies the property that makes it safe: *"CI fails after the expiry date if the exception
still exists. Debt is time-boxed by the tooling, not by good intentions."*

Accordingly, 12 entries are added to `module_dependencies.yaml` `exceptions:`, each carrying
`from`, `to`, `mode`, `reason`, `adr: ADR-0012` and `expires`. The thirteenth edge —
`app -> domain/library` — is **not** waived; see §3.4.

### 3.3 The exceptions are visible, not silent

`IMPL-014` was extended so that a waiver **suppresses the build failure without suppressing the
finding**. A waived violation is still printed, under `ACKNOWLEDGED DEBT`, grouped by edge, with
its ADR number, its expiry date and its reason. The count appears on every run, including
passing ones.

Three further properties were built in deliberately:

* **A malformed exception is a checker error, not a skipped line.** Omitting `adr` or `expires`
  fails the run with exit code 2. An exception that cannot be audited must never be mistaken
  for permission.
* **A missing or unparseable expiry is treated as expired**, never as indefinite.
* **`appliesTo` refuses to match a cycle** regardless of what the manifest requests, so no
  future edit to the exceptions list can waive `L1`.

### 3.4 `app -> domain/library` is deliberately left failing

The nine `app -> domain/library` sites are **not** waived. Four of them
(`login_screen.dart`, `session.dart`) are already scheduled for deletion by `TASK-D10`
(remove demo surfaces, a P0 release blocker), and the remainder are dashboard reads that the
existing `platform/analytics:read_model` port already exists to serve.

Waiving an edge that is already scheduled to disappear would convert a tracked release blocker
into untracked debt with a later expiry date. The checker therefore continues to fail on these
nine sites, which is the correct signal: `TASK-D10` is not done.

**Consequence, stated plainly:** `dart run tool/check_module_boundaries.dart` exits **1** at the
time of this ADR. It is a required status check per §10.4, so the pipeline is red until
`TASK-D10` lands. That is a true statement about the codebase and it is preferable to a green
pipeline bought with a waiver.

---

## 4. Removal plan

Every exception has a date. The order below is by ascending blast radius, so the cheapest
extractions establish the pattern before the expensive ones begin.

| Wave | Edges | Work | Expires |
|---|---|---|---|
| **1** | `platform/business -> platform/tenancy` | `EntitlementService` needs only the `TenantTier` enum and the R0 `TenantContext` it already has. Either promote `TenantTier` to `liboora_contracts` as shared vocabulary (an ownership change, so it needs its own ADR) or have Business declare a one-method `TenantTierSource` port | **2026-10-31** |
| **1** | `platform/analytics -> platform/event` | Analytics needs subscribe-and-replay only. Declare `EventStream { void subscribe(EventHandler); Future<void> replay(); }` in `liboora_contracts`; `EventBus` implements it | **2026-10-31** |
| **2** | `domain/library -> platform/event`, `-> platform/audit` | Declare `EventPublisher` and `AuditSink` in `liboora_contracts`. Five and one call sites respectively; both are append-only interfaces with no read surface | **2026-12-31** |
| **3** | `domain/library -> platform/data`, `-> platform/services`, `-> platform/identity`, `-> platform/business` | The repository interfaces already exist per context; what leaks is `TenantPartitionedStore` as a constructor type. Move each `InMemory*Repository` to an adapter outside the domain barrel. Largest wave: 14 sites across six contexts | **2027-03-31** |
| **4** | `app -> platform/*` (4 edges) | Dashboards read through the declared `read_model`, `auth`, `tenant_context` and `entitlement` ports instead of importing platform barrels | **2027-03-31** |
| **—** | `app -> domain/library` | **Not waived.** Closes with `TASK-D10` | n/a |

`platform/analytics -> platform/event` is listed as an extraction rather than a permanent
allowance even though both are capability platforms, because §6 grants no capability module a
direct import either.

---

## 5. Consequences

**Positive**

* The five dependency laws are mechanically enforced for the first time. `ADR-0011`'s rank 7.5
  is now verified on every run rather than trusted.
* The true state of the codebase is written down: 12 dated exceptions and one intentional
  failure, rather than an unknown number of unenforced rules.
* `L1` is genuinely clean, not merely believed to be.
* Any *new* violation fails the build immediately, because the exception list matches exact
  `from`/`to` pairs and nothing broader. The debt cannot grow quietly.

**Negative**

* The boundary check is red until `TASK-D10` lands (§3.4). This is deliberate and is the
  honest signal.
* Twelve exceptions exist where the ideal number is zero. Each has an owner date; none is
  indefinite.
* Wave 3 is a genuinely large refactor. Recording it with a date is not the same as doing it.

**Neutral**

* No business requirement, PRD or product rule changed. This ADR governs implementation and
  governance only.

---

## 6. Compliance

| Requirement | Where satisfied |
|---|---|
| §11 step 1 — attempt §8 patterns first | §8.2 applied to the `L1` cycle (§3.1). §8.2 is also the prescribed remedy for all 12 waived edges; the removal plan (§4) is that work, scheduled |
| §11 step 2 — ADR stating edge, law, why §8 is insufficient, blast radius, dated removal plan | §2 (edges), §3.2 (options), §4 (blast radius and dates). §8 is not *insufficient* here — it is simply not yet applied, which is why every entry is temporary |
| §11 step 3 — `L1` never approved | §3.1 — fixed in code, and `appliesTo` structurally refuses to waive a cycle |
| §11 step 4 — manifest entry with `adr` and `expires` | `module_dependencies.yaml` `exceptions:` |
| §11 step 5 — CI fails after expiry | `DependencyException.isExpired`; an absent or unparseable date is treated as expired |
| `SID-4.56` — an uncheckable rule is unmet | `IMPL-014` makes all ten categories checkable |
