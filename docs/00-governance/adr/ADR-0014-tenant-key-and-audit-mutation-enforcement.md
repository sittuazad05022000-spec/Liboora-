# ADR-0014 — `X-13` and `X-10` are enforced by reading the manifest that already declared them

| Field | Value |
|---|---|
| **Status** | **Accepted** — 2026-08-04 |
| **Date** | 2026-08-04 |
| **Deciders** | Architecture Review Board, acting through the Architecture Owner role defined in `PRD_OWNERSHIP_MODEL.md` §2.2 |
| **Supersedes** | — |
| **Amends** | `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` (Rank 4) — the **Enforcement coverage** header row and §10.2's two unimplemented check rows — **executed**, see §6. **No rule, no forbidden edge, no dependency law and no `X-*` identifier changed text.** |
| **Amended by** | — |
| **Baseline** | `BASELINE-2026-08-04-B` — **this ADR did not cause the new identifier.** Per §9 the Matrix is Rank 4, so it triggers no re-issue; the identifier advanced because `ADR-0013` changed a Rank 3 document in the same commit |
| **Related** | `ADR-0012` (time-boxed exceptions; gate 3 red by design) · `IMPL-014` · `SID-4.56` |

> ✅ **ACCEPTED 2026-08-04. The migration in §6 has been executed.**
>
> Accepted during the Governance Closure Phase. The correction runs in the **safe direction**: it records that two
> checks which the Matrix declared *unimplemented* are now implemented and passing. Nothing was made green by
> lowering a bar — the `X-10` and `X-13` rule text is untouched, and the checker's output on the existing codebase
> is **byte-identical** to the pre-implementation baseline, proving the two new categories added **zero** false
> positives. `SID-4.56` (*"a rule that cannot be checked SHALL be treated as unmet"*) is satisfied by building the
> check, not by redefining the rule.
>
> **Original proposal text follows, unaltered.**
>
> **This ADR is a PROPOSAL for the documentation change only.**
>
> The enforcement code, its tests and the CI workflow change no ranked document
> and are authorised by `IMPL-014` as already specified in Dependency Matrix
> §10.2. What requires approval here is the **correction of a Rank 4 document**:
> `docs/10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md`, whose header row
> states *"**10 of 12** categories implemented"* and whose §10.2 marks the
> tenant-key and audit-mutation checks unimplemented. Those statements became
> false the moment the checks landed. **The Matrix has not been modified.**
> `DOCUMENTATION_BASELINE.md` §7 step 1 — *"A change to any Rank 1–5 document
> requires an ADR **before** the change"* — admits no exception for a correction
> that happens to be favourable.

---

## 1. Context

### 1.1 Two rules were declared, documented, and unenforced

`LIBOORA_MODULE_DEPENDENCY_MATRIX.md` §10.2 specifies twelve enforcement
categories. `IMPL-014` implemented ten. The two it did not implement were:

| Rule | As written in the Matrix | Remedy the rule itself prescribes |
|---|---|---|
| **`X-10`** | `AUDIT` with an update or delete method | *"Append a correcting entry"* |
| **`X-13`** | Cache/index/vector key without `tenantId` — *"cross-tenant data leak — highest-severity failure class in the system"* | *"Tenant-prefixed key factory"* |

The Matrix header row recorded the consequence honestly:

> *"Enforcement coverage | **10 of 12** categories implemented. `X-13` tenant-key
> and `X-10` audit-mutation are **NOT** implemented and remain **unmet**
> (`SID-4.56`)."*

`SID-4.56` is the governing principle: *"A rule that cannot be checked SHALL be
treated as unmet, not as satisfied by intent."*

### 1.2 The gap was not a missing rule definition — it was an unread key

The intuitive diagnosis is that these two rules lacked machine-readable
definitions. **They did not.** Both were already declared in
`tool/module_dependencies.yaml`, and had been from the start:

```yaml
platform/audit:
  rank: 5
  banned_method_names: ["update*", "delete*", "purge*", "modify*"]   # X-10 append-only

global:
  tenant_key_required_in:
    - cache keys
    - search index names
    - vector namespaces
    - storage prefixes
    - projection table names
  # X-13: the highest-severity failure class in the system
  tenant_key_violation_severity: blocker
```

`grep 'banned_method_names' tool/check_module_boundaries.dart` returned nothing.
The checker parsed `banned_imports`, `banned_symbols` and nine other keys, and
walked straight past these two. The manifest looked complete; the build was
green; the rules were unmet.

This is the most instructive part of the finding. A manifest key that nothing
reads is indistinguishable, at every point of inspection short of reading the
checker source, from a rule that is enforced. It is `SID-4.56`'s failure mode
with a configuration file standing in for the good intention.

### 1.3 Current compliance was real, but unverified — which is not the same thing

Before this change:

* `lib/platform/audit/audit.dart` exposes exactly one mutator, `append()`,
  documented *"The ONLY mutation method. Intentional."*, plus `forTenant`,
  `recent` and `count`. **`X-10`-compliant.**
* `platform/search` does not exist in `lib/` yet. **No `X-13` surface to leak.**

So both checks pass today and find nothing. Under `SID-4.56` that is precisely
the state the rules must not be left in: the code was compliant *by authorship*,
and nothing prevented the next commit from silently ending that. A check that
finds nothing today is a regression guard on the highest-severity failure class
in the system, which is the only reason worth having one.

### 1.4 The gates were automated by convention only

Matrix §10.4 declares six ordered gates and states that gates 3 and 4 are
*"required status checks on the protected branch"*. No `.github/` directory
existed. The gates ran when someone remembered to run them — which, by
`SID-4.56`, is not automation.

---

## 2. Decision

**1. The checker reads the rules from the manifest; it does not restate them.**
`banned_method_names` (`X-10`) and `global.tenant_key_required_in` /
`tenant_key_violation_severity` (`X-13`) are parsed and enforced. Neither rule is
hard-coded in Dart, so widening or narrowing either remains a governed manifest
edit rather than a code change. A test asserts this property directly.

**2. `X-10` is checked at the declaration, not the call site.** The rule governs
the audit store's public surface: if no mutator exists, no caller can invoke one.
Checking declarations needs no call graph and cannot be defeated by an indirect
call. **Private members are violations too** — a `_deleteEntry` helper is one
refactor from being public, and assertion `AU-4` forbids removal outright rather
than merely forbidding its exposure.

**3. `X-13` accepts the remedy `X-13` prescribes.** The rule's stated remedy is a
*"tenant-prefixed key factory"*. A key expression is compliant if it names a
tenant (`tenantId`, `TenantContext`, …) **or** is built through
`TenantPartitionedStore`, whose own contract is that *"every key is namespaced by
tenant inside the store, not by convention at the call site"*.

This second clause is the one judgement call in this ADR, so it is stated
plainly rather than buried in code. It is **not** a loophole:

* `InMemoryAttendanceRepository._key()` builds `'${id.value}#$date'` with no
  tenant term, and hands it to a `TenantPartitionedStore`. A purely lexical check
  would flag it.
* Flagging it would force call sites to re-prefix keys that the store already
  partitions. Duplicated tenant logic in two places is *more* leak-prone than one
  authoritative partition, not less.
* The check is therefore scoped to the **five surfaces the manifest names**, not
  to every method called `_key`. A row id handed to an already-partitioned store
  is not one of the surfaces `X-13` governs.

**4. Severity is carried through from the manifest.** `X-13` findings report
`blocker`, per `tenant_key_violation_severity`, so the report cannot understate a
cross-tenant leak.

**5. The six §10.4 gates are automated as specified**, in the specified order, in
`.github/workflows/architecture.yml`, with a matching local runner
(`tool/gates.sh`) so CI and a developer's machine enforce the same list.

**6. Gate 3 stays red, and the workflow says so.** Nine `app -> domain/library`
findings remain deliberately unwaived under `ADR-0012` §3.4. The workflow
carries no `continue-on-error`, and a comment records why adding one is
forbidden: it would silently disable `X-10` and `X-13` along with everything
else in gate 3.

---

## 3. Options considered

| # | Option | Summary |
|---|---|---|
| **A** | **Read the existing manifest keys** *(proposed)* | Two additive checks, ~230 lines, no rule text touched. |
| B | Do nothing | Leave both rules unmet; keep the honest "10 of 12". |
| C | Delete the unread keys from the manifest | Make the manifest match the checker instead of the reverse. |
| D | Enforce via AST analysis (`package:analyzer`) | Precise, but adds a build step and a dependency. |
| E | Narrow `X-13` to only the modules that exist today | Enforce on `platform/search`; skip the rest until written. |
| F | Waive gate 3 so the pipeline reports green | Add `continue-on-error` to the boundary-checker step. |

---

## 4. Rejected options

| # | Rejected because |
|---|---|
| **B** | `X-13` is *"the highest-severity failure class in the system"*. Leaving the two highest-consequence rules unenforced while ten lower-consequence ones are enforced inverts the priority the Matrix itself sets. |
| **C** | Makes the documents self-consistent by lowering them to the tooling's level. `SID-4.56` reasons in the opposite direction: the rule is the fixed point, the checker is what must catch up. |
| **D** | Rejected on the ground the checker's own doc comment already states: it is *"deliberately not an AST parse"* so it *"stays usable in CI even when the project does not compile — which is exactly when a boundary regression is most likely"*. A line-based check that under-matches is worth more than a precise one that cannot run. Revisit only if a real violation is found to evade it. |
| **E** | Would make `X-13` unenforced for every module written after today — the opposite of a regression guard, and a rule that quietly shrinks as the codebase grows. |
| **F** | Explicitly forbidden by `ADR-0012` §3.4: it converts `TASK-D10`, a tracked P0 release blocker, into untracked debt. It would also disable `X-10` and `X-13` as a side effect, since all three share gate 3. A green pipeline bought this way is fabricated success. |

---

## 5. Consequences

**Positive**

* Enforcement coverage reaches **12 of 12**. No specified check remains unmet.
* `X-13` and `X-10` become regression guards on a currently-clean codebase, which
  is the cheapest moment to install them.
* The six gates run without relying on anyone's memory.
* Both rules stay defined in one normative place — the manifest.

**Costs**

* Two heuristic, line-based checks that can in principle under-match. Accepted
  deliberately (§4, option D) and documented at each check.
* `_tenantKeySurfacePatterns` maps each declared surface to the Dart identifier
  vocabulary that builds it. New vocabulary for an existing surface needs a code
  edit. The *surfaces* stay manifest-driven; only their spelling is in code.

**Risks**

| Risk | Severity | Mitigation |
|---|---|---|
| A false positive pressures someone into weakening `X-13` | **High** | Checks written to under-match; two tests assert the compliant forms (`tenantId` keys, `TenantPartitionedStore`) are *not* flagged. |
| `continue-on-error` is later added to gate 3 to get a green badge | **High** | Prohibition stated in the workflow at the point of temptation, with its consequence for `X-10`/`X-13` spelled out. |
| The `TenantPartitionedStore` allowance is read as "any store is fine" | Medium | Allowance is named to that one type, justified in §2.3, and scoped to the five declared surfaces. |

---

## 6. Migration requirements — **executed 2026-08-04**

> This section was written while the ADR read *Proposed*, and nothing in it was executed until acceptance.
> M1–M3 landed in the same commit as the status flip.

| # | Change | Document | Rank | Authorising rule | Executed |
|---|---|---|---|---|---|
| **M1** | Header row: *"**10 of 12**"* → *"**12 of 12** categories implemented"*; delete the sentence declaring `X-13`/`X-10` unmet | `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` | **4** | This ADR, once Accepted | ✅ |
| **M2** | §10.2: mark the tenant-key and audit-mutation rows implemented | same | **4** | This ADR (same commit as M1) | ✅ |
| **M3** | Version → **v1.3**, changelog row added | same | **4** | Baseline §7 step 2 (same commit as M1) | ✅ |
| **M4** | Add `ADR-0014` to the register and change history | `ADR-INDEX.md` | — | `ADR-INDEX` §Process step 2 | ✅ |

**Not required.** No `X-*` rule text. No dependency law. No manifest rule
(both keys already existed; only `path`-style parsing was added). No PRD. No
frozen document. No baseline identifier (§9). No new exception — this ADR grants
no waiver and adds nothing to `exceptions:`.

**Already authorised, and done.** The code, its tests and the CI workflow
implement `IMPL-014` against Matrix §10.2 and §10.4 as already specified, and
change no ranked document. `BOUNDARY_CHECKER_DESIGN.md` is descriptive tooling
documentation, unranked in the §4 precedence table — like `DEPENDENCY_GRAPH.md`,
it tracks the code rather than governing it, so §7 does not gate it.

---

## 7. Traceability impact

**Net impact: zero identifiers.** No `X-*`, `AU-*`, `SE-*`, `MP-*`, `LIB-*`,
`SID-*`, `IMPL-*` or `BC-*` identifier is created, retired or renumbered.
`IMPL-014` is unchanged in scope — it was always specified as twelve categories;
this ADR records that it now covers all of them.

---

## 8. Compliance

Four mechanical checks, all currently passing:

1. `dart run tool/check_module_boundaries.dart` reports categories
   `audit-mutation` and `tenant-key` when either is violated.
2. `flutter test test/architecture/` proves each check **fires** on a synthetic
   violation and does **not** fire on the sanctioned compliant forms.
3. A test asserts the checker reads `banned_method_names` and
   `tenant_key_required_in` from the manifest — guarding against the exact
   regression that caused this gap.
4. `tool/gates.sh` and `.github/workflows/architecture.yml` list the same six
   gates in the same order.

---

## 9. Baseline

The baseline identifier is **unchanged**. Baseline §7 step 4: *"The baseline
identifier changes only when a Rank 1–3 document changes version."* The Matrix is
Rank 4.

---

## 10. Change history

| Date | Change |
|---|---|
| 2026-08-04 | Created, **Proposed**. Records the enforcement of `X-13` and `X-10` and requests approval for the Rank 4 Matrix correction (M1–M3). No rule text, no law, no PRD and no frozen document is altered. |
| 2026-08-04 | **Accepted** during the Governance Closure Phase. Decision adopted unmodified; no option re-opened. M1–M4 executed: Matrix → **v1.3**, enforcement coverage **10 of 12 → 12 of 12**, §10.2's tenant-key and audit-mutation rows marked implemented, `ADR-INDEX.md` updated. §8's four mechanical checks re-run and all four pass. **Boundary-checker output unchanged from the pre-implementation baseline — 9 findings in 1 category (`cross-context`), 28 acknowledged-debt findings across 12 edges — confirming the two new categories introduced no false positives and that gate 3 remains red only for the `ADR-0012` §3.4 reason (`TASK-D10`).** Baseline identifier advanced to `BASELINE-2026-08-04-B` by `ADR-0013`, not by this ADR. |
