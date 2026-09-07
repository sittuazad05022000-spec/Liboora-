# `PRD-013` Tenancy — Stage 3 Architecture Alignment **Supplement**

| Field | Value |
|---|---|
| **Act** | 📐 **RE-MEASUREMENT** — the six Stage 3 checks, re-run against the bytes the base record never read |
| **Stage** | **Stage 3 — Architecture Review** ([`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) L88–106) |
| **Supplements** | [`PRD-013_ARCHITECTURE_ALIGNMENT.md`](PRD-013_ARCHITECTURE_ALIGNMENT.md) — **which is not modified by this document** |
| **Base record measured** | `PRD-013_TENANCY.md` @ `fcd99ff7dc6c2b4fc7f44e73cc468ffd178981c5a6cc2b6874fd7e6b19dff97e` |
| **This record measures** | `PRD-013_TENANCY.md` @ `688239cb28c96648addbed4d08081ed2821e867e5873a1f028ae3c49f0f1ba9c` — the post-Stage-4 bytes |
| **Why it exists** | The base record's `✅ ALIGNED` verdict was measured against superseded bytes. Per the [`ADR-0049`](../../00-governance/adr/ADR-0049-revenue-finance-prd-v1.7-baseline.md) §2.1 precedent — *"A verdict measured against superseded bytes cannot be relied on alone, so the supplement re-measured all six checks"* — Stage 7 requires a verdict over the bytes being admitted |
| **Precedent followed** | [`PRD-008_ARCHITECTURE_ALIGNMENT_V17_SUPPLEMENT.md`](../revenue-finance/PRD-008_ARCHITECTURE_ALIGNMENT_V17_SUPPLEMENT.md), admitted jointly with its base record by `ADR-0049` §4 item 3 |
| **Verdict** | ✅ **ALIGNED — 5 of 6 checks PASS, 1 CONDITIONAL (`H-1`, unchanged and pre-existing).** 0 new conflicts. 0 findings raised. 0 dispositions changed |
| **Date** | 2026-08-19 |
| **Mandate** | **Re-measurement only.** No PRD modified. No ranked document touched. No new identifier. No disposition reversed. No historical hash rewritten |

---

## 1. What this document does **not** do

**It does not correct the base record.** The base record's citation of
`fcd99ff7…f97e` is **accurate history** — it records what Stage 3 actually read.
Editing it to cite bytes Stage 3 never saw would make the record claim a review
that did not happen, which is the silent-amendment failure `PRD_LIFECYCLE.md`
L177 forbids: *"A frozen PRD is never silently modified. Not for an obvious
correction, and not for one that is certainly right."*

**It does not re-open a closed disposition.** All 13 withdrawn findings, all 8
rejected candidates and the `H-1` condition stand exactly as the base record left
them. This document adds a verdict; it revises nothing.

**A disclosed defect in this evidence, admitted rather than repaired.** The base
record contains **zero** links to this supplement — a reader who opens the
obvious filename sees a verdict against superseded bytes with nothing pointing
forward. The remedy is the baseline row that admits **both records together**, so
the baseline is the index. Forging a back-link into the base record would edit an
evidence file. `ADR-0049` §2.1 discloses the identical absence for `PRD-008`, and
`PRD-006`'s base alignment record has it too.

---

## 2. What changed between the two hashes

Four Stage 4 corrections, each named in the PRD's own changelog and in
[`PRD-013_STAGE5_CONFERRAL.md`](PRD-013_STAGE5_CONFERRAL.md) §4:

| Correction | What it did | Identifier effect |
|---|---|---|
| `RQ-1` | `TEN-AC-006` stops citing `TEN-INV-001`, which it could not verify | 0 added |
| `RQ-2` | Acceptance coverage added for `TEN-XC-007`/`008`/`009`, `TEN-FR-018`/`019`/`020`, `TEN-INV-002` | **`TEN-AC-009`…`016`** added (8) |
| `RQ-3` | The BC Map §9.1 envelope obligation moves from unidentified prose under an identifier | **`TEN-FR-021`** added (1) |
| `RQ-4` | §0.2 split into three identifier classes | 0 added |

**Net: 9 identifiers added, 0 removed, 0 renumbered, 0 reworded.** Verified by
`tool/docs_check/prd013_traceability.py` at exit 0 over the current bytes.

---

## 3. The six checks, re-measured against `688239cb…ba9c`

`PRD_LIFECYCLE.md` Stage 3 fixes the checks and their authorities. Each is
re-run below over the current bytes, not inferred from the base record.

### 3.1 Check 1 — Context ownership is exclusive · authority BC Map §3

| Measurement over current bytes | Result |
|---|---|
| Aggregate roots claimed by `PRD-013` | **`Tenant` only** — `TEN-FR-004`, *"`Tenant` **SHALL** be the module's only aggregate root"* |
| BC Map §8 L381 assignment for `BC-19` | `Tenant` — **match** |
| `TenantOrganisation` claimed? | **No** — `TEN-XC-001` makes it impossible; owner named as `PRD-002` |
| `StaffAssignment` claimed? | **No** — `TEN-XC-002`, owner `PRD-002` |
| Occurrences of `Branch` in the PRD (case-insensitive) | **0** — measured by `grep -ic`. The PRD claims **no** `BC-06` aggregate, at any version |
| Subscription/billing aggregates claimed? | **No** — `TEN-XC-005`, owner `BC-20` |
| Entitlement outputs claimed? | **No** — `TEN-XC-006`, owner `BC-21` |
| Lifecycle state machine claimed? | **No** — `TEN-XC-008`, cited to frozen `LIB-8.1`…`8.8` |

The nine added identifiers include **no** aggregate claim: `TEN-FR-021` is an
event-envelope obligation and the eight `TEN-AC-*` are criteria over obligations
that already existed.

> ✅ **PASS — unchanged.** Two PRDs own one aggregate: **0 instances.**

### 3.2 Check 2 — Every integration edge exists in BC Map §7 · authority BC Map §7

| Measurement | Result |
|---|---|
| Edges declared by the PRD | **1**, present in §7 |
| Edges invented | **0** |
| Did `TEN-FR-021` add an edge? | **No.** It carries the §9.1 envelope obligation — a *payload* rule on events already registered at §9 L435. `TEN-XC-009` continues to forbid any event beyond those two |

> ⚠️ **CONDITIONAL PASS — the condition is unchanged and is not this PRD's
> defect.** `H-1`: BC Map §7 has no capability→capability subsection, so `BC-19`'s
> §9-published consumers (`BC-21`, `BC-24`) are unregistrable. The identical gap
> affects `BC-20`→`BC-21` (§9 L437). Owned by the Architecture Owner; carried
> forward. **No ADR is required *of this PRD*, because this PRD asserts no
> unregistered edge.**
>
> **This condition does not block freeze.** `ADR-0049` §2 admitted `PRD-008` with
> its Stage 3 evidence in a supplemented state, and `PRD-006`'s Stage 6 task
> document was lawfully written with **⚠️ CONDITIONAL** Stage 3 *and* Stage 4
> verdicts (`ADR-0049` §6.1). A condition owned by a different role, on a
> pre-existing Rank 4 taxonomy hole, is carried — not cured — at freeze.

### 3.3 Check 3 — Rank direction is downward · authority Dependency Matrix `L2`

| Measurement | Result |
|---|---|
| Module rank | R4 `platform/tenancy` — `DEPENDENCY_GRAPH.md` L39 |
| Upward read declared | `TenantContext` interface from R0 `liboora_contracts` — the **declared** `◇*` exception, Matrix legend L157 and §8.3 |
| Illegal import asserted | **0** |
| Did any added identifier alter the rank posture? | **No.** `TEN-FR-008` (unchanged) already bound `TenantId` to R0 |

> ✅ **PASS — unchanged.**

### 3.4 Check 4 — No authorisation decided outside `BC-18` · authority `X-13`

| Measurement | Result |
|---|---|
| `TEN-XC-003` | Module **MUST NOT** make, store or evaluate an authorisation decision |
| `TEN-XC-010` | Module **MUST NOT** produce, cache, alter or short-circuit an authorisation outcome; *"a cached tenant context **MUST NOT** be relied upon as evidence that an authorisation still holds"* |
| Any role/permission/scope/policy defined | **0** |
| Did the eight new `TEN-AC-*` weaken either exclusion? | **No** — they add criteria *verifying* `TEN-XC-007`/`008`/`009`. A criterion cannot narrow the rule it tests |

> ✅ **PASS — unchanged, and strictly better evidenced than at the base record**,
> because `TEN-XC-007` (cross-tenant access impossible) now carries a criterion
> where at `fcd99ff7…f97e` it carried none.

### 3.5 Check 5 — No credential, OTP or session outside `BC-18` · authority `ID-1`

| Measurement | Result |
|---|---|
| `TEN-XC-004` | Module **MUST NOT** store a credential, password, OTP, session or device record |
| Credential-bearing field in any `TEN-FR-*` | **0** |

> ✅ **PASS — unchanged.** `PRD_LIFECYCLE.md` §7: *"`X-13` and `ID-1` are never
> waived under time pressure."* Neither is waived here.

### 3.6 Check 6 — Tenant scoping correct · authority `MP-GBR-08`, `X-13`

| Measurement | Result |
|---|---|
| `TEN-XC-007` | *"**Cross-tenant access MUST be impossible.**"* No operation, query, cache, index or projection may return, reference or infer another tenant's data |
| `TEN-FR-021` (added at Stage 4) | Carries the BC Map §9.1 envelope, in which *"`tenantId` is mandatory on every domain event"* (BC Map L449–450) and `MP-GBR-07` |
| `TEN-AC-002` | *"Two concurrent requests for different tenants never observe each other's tenant context"* → `TEN-FR-014` |
| Direction of the Stage 4 change | **Strengthening.** `RQ-3` moved a tenant-partitioning obligation *under* an identifier, making it citable and testable |

> ✅ **PASS — unchanged in verdict, strengthened in substance.** `MP-RSK-01`
> cross-tenant leak: **0 instances asserted by the specification.**
>
> ⚠️ **A specification/implementation divergence exists and is recorded, not
> waived.** `TEN-FR-014`'s async-scoping obligation is **not met by the
> pre-existing code scaffold** — `D-013-02`, §4 below. That is a **code** defect
> against a **correct** requirement, and Stage 3 reviews the specification.

---

## 4. The two code findings, located at the correct rank

Both were found during Stage 6 while measuring `lib/platform/tenancy/tenancy.dart`
(85 lines, commit `a44ebb0`, authored **before** `PRD-013` existed), and both are
recorded in [`PRD-013_IMPLEMENTATION_TASKS.md`](../../40-implementation/tenancy/PRD-013_IMPLEMENTATION_TASKS.md) §4.1.

**Neither is a Stage 3 finding against `PRD-013`,** and this section exists to say
so with evidence rather than by assertion.

| ID | Where the defect is | Measurement | Why Stage 3 passes anyway |
|---|---|---|---|
| **`D-013-01`** | **Code only.** `final class Branch` is declared in `lib/platform/tenancy/tenancy.dart:28` | `grep -ic branch` on `PRD-013_TENANCY.md` → **0**. `Branch` is assigned to `BC-06` by BC Map L210 and L375, owned by **`PRD-002`** (`PRD_REGISTRY.md` L446), whose §2 L56/L182 claims it as a `BC-06` aggregate, and fixed as a **baseline term** by `DOCUMENTATION_BASELINE.md` §5 | Check 1 measures what **the PRD** claims. The PRD claims `Tenant` and nothing else, and `TEN-FR-003` **forbids** owning any tenant-facing business record beyond `Tenant`. The code violates the PRD; the PRD does not violate the BC Map |
| **`D-013-02`** | **Code only.** `MutableTenantContext` holds four plain mutable fields; `grep -cE 'Zone\|runZoned\|AsyncLocal'` → **0** | `TEN-FR-014` requires async scoping; `TEN-AC-002` is therefore **currently false** of the code | Check 6 measures whether the **specification** partitions tenants correctly. It does, and more strictly than the code. A requirement the code has not yet met is a task, not a misalignment |

**The direction of the conflict is decided by rank, not by preference.**
`PRD-013` is the Rank 3 requirement and post-dates the scaffold. Where they
disagree the **code** is wrong. Amending `TEN-FR-014` to match a non-async
implementation would be letting the implementation write the requirement — and
would weaken a tenant-isolation safeguard, which `MP-RSK-01` classifies Critical.

---

## 5. Reproducible commands

```bash
sha256sum docs/30-product/tenancy/PRD-013_TENANCY.md
grep -ic 'branch' docs/30-product/tenancy/PRD-013_TENANCY.md          # 0
grep -cE 'Zone|runZoned|AsyncLocal' lib/platform/tenancy/tenancy.dart  # 0
grep -n 'class Branch' lib/platform/tenancy/tenancy.dart               # 28
python3 tool/docs_check/prd013_traceability.py                         # exit 0
python3 tool/docs_check/prd013_stage5.py                               # exit 0
python3 tool/docs_check/prd013_task_coverage.py                        # exit 0
```

---

## 6. Disclosed limits of this re-measurement

*A review that hides its own limits is not a review.*

| Limit | Effect |
|---|---|
| This is a **re-measurement**, not an independent second review | It re-runs the base record's checks over new bytes. It does not seek findings the base record could have missed on the shared text |
| The `H-1` condition is **carried, not resolved** | It belongs to the Architecture Owner and affects `BC-20` identically |
| Checks 1–6 measure the **specification** | They cannot and do not certify code. `D-013-01`/`D-013-02` are proof that the code diverges |
| No requirement's *meaning* was compared to the *text* of every rule it cites | The same limit `ADR-0020` §3.7 exposed for `PRD-007`, where 10 mis-targeted citations survived every gate. No script in this repository checks citation semantics |
| **0 of 13** `TEN-AC-*` are proven by a passing test | `SID-4.56`: *"A rule that cannot be checked SHALL be treated as unmet."* Alignment is not verification |

---

## 7. Verdict

> ✅ **ALIGNED at `688239cb…ba9c` — 5 of 6 checks PASS, 1 CONDITIONAL.**
>
> **0 new conflicts. 0 findings raised. 0 dispositions reversed. 0 historical
> hashes rewritten.** The base record's verdict holds over the corrected
> document, and now says so over the bytes a freeze would admit.
>
> The single condition, `H-1`, is a pre-existing taxonomy gap in a frozen Rank 4
> document, owned by the Architecture Owner, affecting `BC-20` identically, and
> asserted by **no** requirement in `PRD-013`.

**This record confers nothing.** Stage 3's verdict for `PRD-013` was conferred by
[`PRD-013_STAGE5_CONFERRAL.md`](PRD-013_STAGE5_CONFERRAL.md) §4's routing and is
adjudicated for freeze purposes by the admission ADR. If this file were deleted,
the base record and its hash would still stand.

---

## 8. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-19 | Created. Re-measures the six Stage 3 checks against `688239cb…ba9c`, the post-Stage-4 bytes, following the `ADR-0049` §2.1 / `PRD-008` supplement precedent. Verdict ✅ ALIGNED, 5 PASS + 1 CONDITIONAL (`H-1`, pre-existing). The base record is **not modified** and its historical hash `fcd99ff7…f97e` is **preserved**. Locates `D-013-01` and `D-013-02` as **code** defects against a correct specification, at the rank where each belongs |
