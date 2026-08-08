# LIBOORA — Boundary Checker Design (`IMPL-014`)

| Field | Value |
|---|---|
| **Document** | Architecture Boundary Checker — design and operating rules |
| **Version** | v1.1 |
| **Status** | **Implemented** — `tool/check_module_boundaries.dart`, commit `a22fd7e` |
| **Implements** | `IMPL-014` · `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` §10.2 (Layer 2) and §10.3 (Layer 3) |
| **Governed by** | `ADR-0011` (rank 7.5) · `ADR-0012` (time-boxed exceptions) |
| **Machine-readable input** | `tool/module_dependencies.yaml` |
| **Last Updated** | 2026-08-04 |

---

## 1. Why this exists

Until 2026-08-04 every architectural rule in this repository was enforced by code review.
`SID-4.56` states the governing principle:

> *"A rule that cannot be checked SHALL be treated as unmet, not as satisfied by intent."*

By that standard the five dependency laws had never been enforced. `ADR-0011` made the gap
expensive rather than merely theoretical: **rank 7.5** is a half rank whose entire purpose is to
keep law `L2` literally true, so that a rank-8 library module depends on identity *strictly
downward* and no law needs an exception. A half rank that nothing verifies is just a comment.

Matrix §1 states the intended end state:

> *A pull request that violates a module boundary **fails the build**, with an error message
> naming the rule it broke and the ADR required to change it.*

This document describes the tool that makes that true.

---

## 2. Design decisions

### 2.1 The manifest is the single input

The checker holds **no** architectural knowledge of its own. Ranks, ports, banned imports,
clusters and policies all come from `tool/module_dependencies.yaml`, which the matrix names as
its machine-readable form. A rule that exists only in the checker's source would be a third
source of truth competing with the matrix and the manifest.

**Consequence:** amending the architecture means amending the manifest (through an ADR), not
editing Dart. The one exception is `_symbolOwners` (§3.8), discussed there.

### 2.2 Line-based import parsing, not the analyzer

Imports are extracted with a regular expression over source lines rather than by using
`package:analyzer`.

This is a deliberate trade. The analyzer gives a real AST, but it requires the project to
**resolve** — and the moments when boundary feedback matters most are exactly the moments when
resolution is broken: a half-finished refactor, a deleted class, a cyclic import. A checker that
cannot run during a refactor is a checker that gets skipped during refactors.

The cost is that `export` chains and conditional imports are not followed. Mitigated by the
`barrel_only_cross_module` rule (§3.6): if every cross-module import must target the module's
barrel, a line-based reading of the import list is complete for boundary purposes.

### 2.3 Three exit codes, because two are not enough

| Code | Meaning | CI behaviour |
|---|---|---|
| `0` | No un-waived violations | Gate passes |
| `1` | Violations found | Gate fails; report names each rule |
| `2` | **The checker could not run** | Gate fails |

Exit `2` is the design point most easily got wrong. A missing manifest, unparseable YAML, or a
malformed exception must **never** be reported as success. A tool that silently checks nothing
and exits `0` is worse than no tool, because it manufactures confidence. The banner is explicit:
*"A checker that cannot run is not a clean build."*

### 2.4 Violations carry structure, not just prose

Each `Violation` records `category`, `rule`, `file`, `line`, `detail`, and — for edge findings —
`consumer` and `provider` module names. The structured fields let an `ADR-0012` exception match
an edge **structurally** rather than by string-matching a human-readable message. Matching on
prose would mean a reworded error message silently widens or breaks a waiver.

---

## 3. The twelve checks

Each maps to a law or a named rule. All twelve run on every file; none short-circuits, so one
finding never masks another.

### 3.1 Illegal imports — `L5`

The shared kernel imports nothing. `contracts` declares `allowed_imports` (`dart:core`,
`dart:async`, `dart:convert`, `dart:typed_data`) and `banned_imports` (`package:flutter/**`,
`package:**`, `dart:io`, `dart:ui`).

> **`R-5` mattered here.** The manifest previously pointed `contracts.path` at `lib/contracts`,
> a directory that has never existed. The checker would have scanned **zero** kernel files and
> reported `L5` as satisfied — the exact failure `SID-4.56` describes. Corrected to
> `packages/liboora_contracts/lib` in the same commit. `L5` is additionally enforced
> structurally by that package having an empty `dependencies:`.

### 3.2 Forbidden dependencies

Per-module `banned_imports` glob patterns. This is what keeps `X-05` (Separate Ways) real:
`domain/library` bans `domain/social/**` and `domain/person/**`, the latter because `ADR-0011`
requires identity to be reached by **port** (`E-13` ACL), never by import.

### 3.3 Rank ordering — `L2`, including same-rank

A module may import only **strictly lower** ranks. Same-rank imports are legal only between
contexts inside a declared cluster (`internal_edges`), which is the mechanism behind the two
`L2` cluster exceptions.

Ranks are read as `double`, which is what allows `domain/person: 7.5` to be expressed and
verified. Had ranks been integers, `ADR-0011`'s central device would have been unrepresentable.

### 3.4 Layer violations — `L4`

No capability platform may import a domain module. This is forbidden edge `X-12` and the reason
`platform/analytics` can be extracted to its own service later without dragging the library
domain with it.

### 3.5 Cross-context rules — mode enforcement

The subtlest check, and the one that produced all 37 `ADR-0012` findings. Matrix §4 defines the
**Port** mode as *"Consumer imports **no** provider code"* with *"Compile-time import allowed?
**No**"*. §12 states there is exactly **one** direct-import permission: `liboora_contracts`.

So an import of a module that is declared only as a `port` is a violation **even when the rank
order is correct**. Direction and inversion are separate requirements; the scaffold satisfied
the first and not the second.

The composition root (`di.dart`, `seed.dart`, `main.dart`) is exempt: it is the one place
permitted to know both a port and its adapter. Its imports remain governed by `banned_imports`.

### 3.6 Barrel-only imports

Cross-module imports must target `<module>.dart`, never reach past it into `domain/` or `src/`.
This is what makes §2.2's line-based parsing sufficient.

### 3.7 Architecture policies — banned symbols

Global and per-layer symbol bans: `DateTime.now()` and `Random()` in domain code (`X-09` — use
the `Clock` and `RandomSource` ports), plus the ubiquitous-language bans in the kernel (bare
`Student`, `Member`, `Payment`, `Plan`, `Invoice`, `Attendance`) from context map §5.

### 3.8 Ownership violations

A `_symbolOwners` map asserts that `PersonIdentity` is declared in `domain/person`,
`StudentRecord` in `domain/library`, `AuthService` in `platform/identity`, and so on. This is
the check that mechanically enforces `ADR-0011`'s **relocation** — not merely that social no
longer imports identity, but that identity is declared where the ADR says it lives.

This map is the one piece of architectural knowledge held in Dart rather than YAML. It is a
short, ADR-traceable list of aggregate roots; promoting it to the manifest is reasonable future
work but was not required to make the relocation verifiable.

### 3.9 Circular dependencies — `L1`

DFS over the file-level import graph with on-stack detection, reporting the **full cycle path**
rather than just naming the participants, so the edge to cut is visible.

`L1` is *"the one law with zero exceptions"* (§2) and §11 step 3 states it is **never**
approved. This is enforced structurally, not by convention — see §4.3.

### 3.10 Same-rank and cluster rules

Folded into §3.3, since a same-rank import is an `L2` question. Reported with its own message so
the fix (declare an `internal_edge`, or invert the dependency) is unambiguous.

### 3.11 Audit mutation — `X-10`, assertions `AU-1` and `AU-4`

Fails when a module declares a method matching one of its `banned_method_names` globs —
`["update*", "delete*", "purge*", "modify*"]` on `platform/audit`.

Checked at the **declaration**, not the call site: `X-10` governs the audit store's public
surface, so if no mutator exists, no caller can invoke one. This needs no call graph and cannot
be defeated by an indirect call. **Private members count too** — a `_deleteEntry` helper is one
refactor from being public, and `AU-4` forbids removal outright rather than merely forbidding its
exposure. Getters are excluded: a getter cannot mutate.

The reported remedy is the one `X-10` itself prescribes — *"append a correcting entry"*.

### 3.12 Tenant-scoped keys — `X-13`

Fails when one of the five surfaces named by `global.tenant_key_required_in` — cache keys, search
index names, vector namespaces, storage prefixes, projection table names — is built without a
tenant scope. Severity is read from `tenant_key_violation_severity` (`blocker`), so the report
cannot understate what the Matrix calls *"the highest-severity failure class in the system"*.

A key expression is compliant if it **names a tenant** (`tenantId`, `TenantContext`, …) **or** is
built through **`TenantPartitionedStore`**, which is the *"tenant-prefixed key factory"* `X-13`
prescribes as its remedy and whose contract is that *"every key is namespaced by tenant inside the
store, not by convention at the call site"*.

That second clause is the one judgement call in the check, so it is recorded here rather than left
implicit. It is not a loophole. `InMemoryAttendanceRepository._key()` builds `'${id.value}#$date'`
with no tenant term and hands it to a `TenantPartitionedStore`; a purely lexical check would flag
it, and "fixing" it would mean re-prefixing keys the store already partitions — duplicated tenant
logic in two places, which is *more* leak-prone than one authoritative partition, not less. The
check is therefore scoped to the five declared surfaces rather than to every method named `_key`:
a row id handed to an already-partitioned store is not a surface `X-13` governs.

---

## 4. The exception mechanism (`ADR-0012`)

Matrix §11 defines a time-boxed exception process. The checker implements it with three
properties that distinguish a governance record from a mute button.

### 4.1 An exception cannot be created silently

`from`, `to`, `mode`, `reason`, `adr` and `expires` are **all required**. A missing field is a
`_CheckerError` → **exit 2**, not a skipped line:

```
BOUNDARY CHECKER COULD NOT RUN
  exceptions[0] is missing `adr`. MODULE_DEPENDENCY_MATRIX §11 requires
  from, to, reason, adr and expires on every exception.
```

An unparseable date and an unknown module name are likewise exit 2. A typo must never be
assumed to waive something.

### 4.2 An exception stays visible

A waived violation is **still reported**, under `ACKNOWLEDGED DEBT`, grouped by edge, with its
ADR, expiry and reason — on every run, including passing ones:

```
□ ACKNOWLEDGED DEBT — 28 finding(s) across 12 edge(s), each covered by a dated ADR (§11).
  domain/library -> platform/event — 5 site(s)
      ADR-0012 · expires 2026-12-31
      Five use cases take EventBus as a constructor type...
```

Suppressed-and-forgotten is the failure mode that turns architecture documents into fiction. An
exception that stops being visible stops being debt and becomes an assumption.

### 4.3 An exception expires, and `L1` can never have one

`isExpired` treats a missing or unparseable date as **expired**, never as indefinite. After the
date the exception stops applying and the violation fails the build again — §11 step 5:
*"Debt is time-boxed by the tooling, not by good intentions."*

`appliesTo` refuses to match `category == 'circular-dependency'` **regardless of what the
manifest requests**. No future manifest edit can waive `L1`. This is asserted by test, not left
to reading.

---

## 5. Verifying the checker itself

`SID-4.56` applies recursively: the tool that enforces every other rule is the one whose
correctness cannot be taken on trust. `test/architecture/boundary_checker_test.dart` (matrix
§10.3) contains **14 tests** that assert governance *properties*, not finding counts — a
count-based test needs editing whenever debt is paid down, and a test that is routinely edited is
a test that has stopped being read.

| Property asserted | Method |
|---|---|
| The checker runs and produces a report | Run it; require exit `0` or `1`, never `2` |
| An expired exception stops waiving | Rewrite every date to `2020-01-01`; require blocking count to **increase** |
| A missing expiry is not "never expires" | Delete the field; require non-pass |
| A missing `adr` halts the run | Delete the field; require exit `2` and `adr` named in stderr |
| An unparseable date halts the run | Set `expires: someday`; require exit `2` |
| An unknown module halts the run | Rename a module; require exit `2` |
| **`L1` cannot be waived** | Insert a valid self-edge waiver; require `circular-dependency` never appears under `ACKNOWLEDGED DEBT` |
| The repository is cycle-free | Require no `circular-dependency` in the report |
| Every exception has all six fields | Parse the committed manifest |
| Every exception cites a **real ADR file** | Check `docs/00-governance/adr/` for the file |
| No exception is committed already expired | Compare against the current date |
| `app → domain/library` is **not** waived | `ADR-0012` §3.4 — assert its absence |

Each mutation test runs the **real** checker against a temporarily modified manifest and restores
it in a `finally` block, so a failing expectation cannot leave the repository dirty. A
post-suite diff confirms the manifest is byte-equivalent afterwards.

---

## 6. CI integration

Matrix §10.4 defines the gate ordering. The checker is **step 3**, a required status check on the
protected branch:

```
1. dart format --set-exit-if-changed .
2. flutter analyze
3. dart run tool/check_module_boundaries.dart   ◄── blocks merge
4. flutter test test/architecture/              ◄── blocks merge
5. flutter test
6. flutter build web --release
```

**Current state, stated plainly:** step 3 exits **1**. The nine `app → domain/library` sites are
deliberately unwaived (`ADR-0012` §3.4) because `TASK-D10` already tracks their deletion as a P0
release blocker. Waiving them would convert a tracked blocker into untracked debt with a distant
expiry date.

The pipeline is therefore red until `TASK-D10` lands. That is a true statement about the
codebase, and it is preferable to a green pipeline bought with a waiver.

`yaml: 3.1.3` is declared in `dev_dependencies` so the gate is reproducible on a clean checkout.

---

## 7. Known limitations

Recorded because an undocumented limitation is indistinguishable from a bug.

| Limitation | Consequence | Mitigation |
|---|---|---|
| Line-based parsing does not follow `export` chains | A module could re-export a forbidden type through its barrel | `barrel_only_cross_module` plus §3.8 ownership checks. Promoting to an AST pass is future work |
| Conditional imports (`if (dart.library.io)`) are read as unconditional | Would over-report on a platform-split file | None exist in this repository today |
| `_symbolOwners` lives in Dart, not YAML | Adding an aggregate needs a code edit, not a manifest edit | Short and ADR-traceable; promotion to the manifest is future work |
| ~~Tenant-key and audit-mutation checks (§10.2) are **not** implemented~~ | — | **Closed 2026-08-04.** Both are implemented as categories 11 (`X-10`) and 12 (`X-13`). See §7.1 |
| Tenant-key and audit-mutation checks are line-based heuristics | Could under-match an unusual key-building or method-declaration form | Deliberate: both are written to under-match rather than over-match, because a false positive creates pressure to weaken the rule. Each is verified by a test that proves it fires on a synthetic violation |
| `_tenantKeySurfacePatterns` lives in Dart, not YAML | New identifier vocabulary for an existing `X-13` surface needs a code edit | The *surfaces* remain manifest-driven (`global.tenant_key_required_in`); only their Dart spelling is in code. Same trade-off as `_symbolOwners` above |
| File-level, not symbol-level, cycle detection | A cycle between two symbols in one file is invisible | Acceptable: `L1` is defined at module and file granularity in §2 |

### 7.1 The two closed rows — how the gap was actually caused

The first row was, until 2026-08-04, *"the most important"* row in this table:
two Matrix-listed checks were unenforced, and by `SID-4.56` therefore **unmet**.
Both are now implemented, taking coverage from **10 of 12** to **12 of 12**.

The cause is worth recording, because it was not the obvious one. Neither rule
was missing a machine-readable definition. Both were **already declared** in
`tool/module_dependencies.yaml` from the beginning — `banned_method_names` on
`platform/audit` (`X-10`), and `global.tenant_key_required_in` plus
`tenant_key_violation_severity: blocker` (`X-13`). The checker simply never read
either key. The fix was to read the manifest that already existed; no rule was
added, and none was weakened.

**A manifest key that nothing reads is `SID-4.56`'s failure mode with a
configuration file standing in for the good intention.** It is
indistinguishable, at every point of inspection short of reading the checker
source, from a rule that is enforced. Two tests now assert that the checker reads
these specific keys, guarding against precisely that regression.

Note what the checks find today: **nothing.** `lib/platform/audit/audit.dart`
exposes only `append()` plus reads, and `platform/search` does not exist yet. The
codebase was compliant *by authorship* — and nothing prevented the next commit
from silently ending that. Installing the guard while the tree is clean is the
cheapest moment to do it, not a redundant one.

Governance note: correcting the **Rank 4** Dependency Matrix header
(*"10 of 12"* → *"12 of 12"*) requires an ADR **before** the change, per
`DOCUMENTATION_BASELINE.md` §7 step 1 — which admits no exception for a
correction that happens to be favourable. That change is therefore **not** made
here; it is requested by `ADR-0014` and is pending approval. This document is
descriptive and unranked in the §4 precedence table, so it tracks the code
directly.

---

## Changelog

| Version | Date | Change |
|---|---|---|
| **v1.1** | 2026-08-04 | **Enforcement coverage reaches 12 of 12.** Adds §3.11 audit mutation (`X-10`) and §3.12 tenant-scoped keys (`X-13`) — the two checks v1.0 recorded as not implemented and therefore, per `SID-4.56`, **unmet**. Root cause recorded in §7.1: both rules were **already declared** in `module_dependencies.yaml` (`banned_method_names`; `global.tenant_key_required_in` + `tenant_key_violation_severity`) and the checker never read either key — the fix was to read the manifest that already existed. **No rule was added and none weakened.** Self-verification tests 14 → 20; the four new behavioural tests each prove a check *fires* on a synthetic violation, since both checks find nothing on the current tree and an "all clear" assertion could not distinguish a working check from an absent one. Two `§7` limitation rows closed, three added. The corresponding **Rank 4** Dependency Matrix correction is **not** made here — it requires an ADR first (Baseline §7 step 1) and is requested by `ADR-0014`. |
| **v1.0** | 2026-08-04 | Initial design. Ten checks, three exit codes, manifest-driven, `ADR-0012` time-boxed exception mechanism with `L1` structurally unwaivable, 14 self-verification tests. Records two matrix-listed checks as not yet implemented. |
