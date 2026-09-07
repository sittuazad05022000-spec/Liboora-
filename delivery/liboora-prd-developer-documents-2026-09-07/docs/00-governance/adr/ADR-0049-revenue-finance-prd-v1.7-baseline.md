# ADR-0049 — Revenue & Finance PRD v1.7 is the official baseline for `BC-05` Fee & Payment

| Field | Value |
|---|---|
| **Status** | **Accepted** |
| **Date** | 2026-08-17 |
| **Deciders** | **Governance Owner** (baseline admission and Stage 7 conferral) — exercised by **direct, explicit and unconditional conferral of the human principal of this engagement**, recorded as a conferral and **not represented as an ARB meeting** |
| **Supersedes** | Nothing |
| **Amends** | **No ranked document.** Admits existing documents to Rank 3. `MASTER_PRD.md`, `LIBOORA_BOUNDED_CONTEXT_MAP.md`, `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` and `ARCHITECTURE_RULINGS.md` are **unamended** by this ADR |
| **Amended by** | — |
| **Baseline** | `BASELINE-2026-08-17-A` |
| **Closes** | [`PRD_LIFECYCLE.md`](../prd-ecosystem/PRD_LIFECYCLE.md) Stage 7 for `PRD-008`. Registry status `DRAFT` → `FROZEN` |
| **Does NOT close** | **`FEE-GAP-*` — all 17 rows remain OPEN**, including `FEE-GAP-001` (refund tier), `FEE-GAP-002`(c) (offline financial capture), `FEE-GAP-009` (Invoice aggregate identity), `FEE-GAP-010` (vendor), `FEE-GAP-013` (renewal protection) and `FEE-GAP-016` (webhook transport owner). Nor `FINDING A-2`, nor `Q-B31`, nor `Q-A6`/`Q-A7`, nor the `FEE-RSK-*` §0.2 declaration defect, nor `ITG-GAP-001`/`002`/`003`, nor `PGA-01`/`PGA-02`/`PGA-08` |
| **Related** | [`ADR-0034`](./ADR-0034-attendance-management-prd-v1.9-baseline.md) (the `PRD-006` freeze precedent this ADR follows) · `ADR-0020` (`PRD-007`) · `ADR-0019` (`PRD-005`) · `ADR-0018` (`PRD-004`) · `ADR-0033` (conferral doctrine) · `ADR-0039`, `ADR-0040`, `ADR-0043`, `ADR-0044`, `ADR-0045`, `ADR-0048` (`PRD-008` and `BC-31` history) |

---

## 1. The question

[`PRD-008_REVENUE-AND-FINANCE.md`](../../30-product/revenue-finance/PRD-008_REVENUE-AND-FINANCE.md)
v1.7 has completed **Stages 1–6** of `PRD_LIFECYCLE.md`. Stage 7's gate is
explicit: a row in [`DOCUMENTATION_BASELINE.md`](../DOCUMENTATION_BASELINE.md)
§3 at an assigned precedence rank, and *"Freeze is **conferred, not claimed**."*

**This ADR is the instrument of conferral.**

The question is **not** whether the module is finished — it plainly is not, with
17 open governance gaps and 20 blocked implementation tasks. The question is
whether the **document** is a stable, authoritative statement of what `BC-05`
owns, such that later work may rely on it and may not silently contradict it.

---

## 2. Stage evidence — the artefacts, not the feelings

`PRD_LIFECYCLE.md` **L48**: *"A gate is not an opinion — if the artefact does not
exist, the stage has not been passed, however complete the work feels."*

| Stage | Gate | Artefact | State |
|---|---|---|---|
| **3** — Architecture alignment | *"a written alignment record naming every conflict and its disposition"* | `PRD-008_ARCHITECTURE_ALIGNMENT.md` (`c9f47cc1d42917ff`, v1.2 base) **jointly with** `PRD-008_ARCHITECTURE_ALIGNMENT_V17_SUPPLEMENT.md` (`6aed0458c1469c21`, v1.7), **conferred** by `PRD-008_STAGE3_CONFERRAL.md` (`59eeea6d4e2fa284`) | ✅ **ALIGNED — 6 of 6.** CONFERRED |
| **4** — Requirements review | *"conflicts closed or explicitly deferred with a reason and an owner"* | `PRD-008_REQUIREMENTS_REVIEW.md` (`0011e25c7c44032c`), **conferred** by `PRD-008_STAGE4_CONFERRAL.md` (`18adf00ddfce9291`) | ✅ **C1–C7, 0 failures.** 17 of 17 gaps name an owner. CONFERRED |
| **5** — Traceability | prefixes registered in `TRACEABILITY_MATRIX.md` §2, *"verified mechanically, zero collisions"* | `tool/docs_check/prd008_stage5.py` | ✅ **exit 0** |
| **6** — Implementation tasks | *"an `IMPL-*` range allocated and a task document in which every task traces back to requirements"* | `PRD-008_IMPLEMENTATION_TASKS.md` (`f9b560d0b1456305`), `IMPL-700`…`IMPL-799` | ✅ **83 / 83** tasks trace back; 0 invented identifiers; 0 reused numbers |

### 2.1 Why Stage 3's evidence is two documents and not one

The v1.2 base record carries a `✅ ALIGNED` verdict measured against **v1.2**.
`PRD-008` is now **v1.7**, fourteen identifiers larger (`FEE-AC-085`…`098`). A
verdict measured against superseded bytes cannot be relied on alone, so the
supplement re-measured all six checks against v1.7 and the Stage 3 conferral
adjudicated **both** together.

⚠ **A disclosed defect in that evidence, admitted rather than repaired:** the
v1.2 base record contains **zero** links to the supplement. A reader who opens
the obvious filename sees a stale `✅ ALIGNED` verdict with nothing pointing
forward. The remedy is **this ADR and the baseline row it creates**, which admit
all four records together so the baseline itself is the index. Forging a
back-link into the base record would have edited a byte-frozen evidence file.
Precedent: `PRD-006`'s base alignment record has the same absence and is
discoverable the same way.

---

## 3. `FINDING A-2` — why Stage 7 does not wait for it

`ACCEPTED` `ADR-0048` §7.2 records a live tension in **Rank 4**: BC Map **L178**
(`ID-1`) forbids any context outside `BC-18` to store *"a password, OTP, session
or **credential**"*, while BC Map **L140** grants `BC-31` ownership of
*"outbound third-party contracts, **credentials**, retries, idempotent
delivery."* It is **routed to the Architecture Owner** and carried in `PRD-019`
§7.

**Measured, on grounds independent of how A-2 is eventually decided:**

| Measurement | Result |
|---|---|
| `` `ID-1` `` occurrences in `PRD-008` | **0** |
| `ITG-BR-007` (the webhook secret that makes A-2 live) in `PRD-008` | **0** |
| *"webhook secret"* / *"signing secret"* / *"OTP"* / *"session token"* in `PRD-008` | **0** each |
| `FEE-XC-005` | *"Hold, read or transmit a payment-gateway credential"* — an **exclusion**, i.e. a declared **impossibility** for `BC-05` |
| `FEE-XC-006` | forbids naming a vendor at all |

`PRD-008` holds **no credential of any kind**, and declares that holding one is
outside its boundary. A-2 decides **where a credential may live**; `PRD-008`'s
answer is *"not here"* under either reading. The Architecture Owner authority
conferred for this pass was therefore **not exercised**: the conferral was for
resolving A-2 *"if that resolution is required"*, and it is **not required**.

⛔ **A-2 remains OPEN**, owned by the Architecture Owner, carried in `PRD-019`
§7. **No decision was invented for it.**

---

## 4. The decision

1. **`PRD-008_REVENUE-AND-FINANCE.md` v1.7 is admitted to `DOCUMENTATION_BASELINE.md` §3.3 at Rank 3** — the authoritative Revenue & Finance baseline for `BC-05` Fee & Payment, 43 chapters.
2. **Stage 7 Freeze is CONFERRED.** `PRD_REGISTRY.md` status `DRAFT` → **`FROZEN`**.
3. **Four validation records are admitted with it** — the v1.2 alignment record, the v1.7 supplement, the Stage 3 conferral and the Stage 4 conferral — as validation records, **not** as part of the specification.
4. **The baseline identifier becomes `BASELINE-2026-08-17-A`** (baseline §7 rule 4: the identifier changes when a Rank 1–3 document changes version).
5. **All 17 `FEE-GAP-*` are admitted OPEN.** Freeze records what the module owns; it does not answer what nobody has decided.
6. **`PRD-008_IMPLEMENTATION_TASKS.md` is NOT admitted to the baseline.** It is a backlog record, unranked and editable without an ADR, exactly as `PRD-006`'s task document is.

### 4.1 What freeze actually means here

`PRD_LIFECYCLE.md` L155–180: *"**A frozen PRD is never silently modified.**"*
From this ADR forward, a change to `PRD-008` requires an ADR **before** the
change (baseline §7 rule 1). That is the entire practical effect. It is a
**constraint on future edits**, not a claim about present completeness.

---

## 5. What acceptance does **NOT** license

| Not licensed | Why |
|---|---|
| `FROZEN` does **not** mean `VERIFIED` | `VERIFIED` requires implementation and test evidence — Stages 8–9. **Zero** files under `lib/` exist for `BC-05`. `git diff` against `5827068` is empty. |
| Does **not** close any of the 17 gaps | Each retains its named owner and authority. 20 of 83 tasks stay **BLOCKED**. |
| Does **not** decide refund tier, Invoice identity or vendor | `FEE-GAP-001`, `009`, `010` need a Product Owner or Architecture Owner ruling. None is asserted. |
| Does **not** resolve `FINDING A-2` | §3. Routed, not decided. |
| Does **not** specify an endpoint, schema, signature scheme, provider or retry policy | Excluded by `ACCEPTED` `ADR-0035` §5.5b and `ADR-0040` §2/§4; `FEE-GAP-016` stays open. |
| Does **not** promote `ADR-0038` or `ADR-0041` | Both stay `PROPOSED`. `ADR-0041` still contains no decision at all. |
| Does **not** cure the `FEE-RSK-*` §0.2 defect | `FEE-RSK-*` is registered in `TRACEABILITY_MATRIX.md` §2G but not declared in `PRD-008` §0.2 — a **Stage 2** defect, admitted with the document rather than silently fixed. |
| Does **not** amend the stale `IMPL-227`+ row in `PRD_LIFECYCLE.md` | Recorded in the task document §1.1. A Rank 2 edit needs its own governance act. |
| Does **not** fix the 9 `ADR-0012` boundary violations | `dart run tool/check_module_boundaries.dart` exits 1 with 9 violations and 28 acknowledged findings across 12 edges — **pre-existing**, proven byte-identical at `5827068`. Unrelated to `PRD-008`. |
| Does **not** assert an ARB meeting | **No ARB meeting was held, minuted or attended. No quorum, attendee list or sign-off date is asserted.** |
| Does **not** grant a standing licence | `ADR-0033` §7.1: *"A conferral for one act is not a standing licence."* The authority conferred was for the acts in this lifecycle pass only. |

---

## 6. The authority basis, stated plainly

`PRD_OWNERSHIP_MODEL.md` §5 and **L284**: *"Only the Architecture Owner approves.
The others attest, review or confirm."* `PRD_LIFECYCLE.md` §6 assigns Stage 7 and
the baseline to the **governance owner** — and **L283** records that *"Every PRD
needs a named owner. **None has one**"* (`PGA-08`).

The authority exercised here is a **direct, explicit and unconditional conferral
by the human principal of this engagement**, quoted verbatim:

> *"Confer Governance Owner authority for the specific acts of creating the
> admission ADR, admitting `PRD-008` to the baseline, and formally conferring
> Stage 7 Freeze — but only after every lifecycle prerequisite is actually
> satisfied."*

**That instruction is the authority, and it is the only authority claimed.** Same
form as `ADR-0033` §7.2 and `ADR-0034` §7.2. `PGA-08` is **not** cured by this
ADR; a conferral for one act does not appoint a standing owner.

### 6.1 The condition attached to the grant, and how it was tested

The grant was conditional on *"every lifecycle prerequisite actually
satisfied."* Each was measured, not assumed (§2). One prerequisite my own
instrument reported as unmet — a baseline §3 row required *before* Stage 6 —
was **false**: that is the **Stage 7** gate, which comes *after* Stage 6. The
error was found by re-reading the gate text verbatim and confirmed by the
`PRD-006` precedent, whose Stage 6 task document was lawfully written while
`PRD-006` was **`DRAFT`** with **⚠️ CONDITIONAL** Stage 3 and Stage 4 verdicts.
Had that instrument been trusted, Stage 6 would have been reported permanently
unreachable and this freeze wrongly refused.

---

## 7. Consequences

**Positive.** `BC-05`'s boundary is now stable and citable: 134 obligations, 10
invariants, 98 acceptance criteria, 23 exclusions and 8 ports may be relied on by
`PRD-019`, `BC-20` and `BC-31` without fear of silent revision. `IMPL-700`…`799`
is allocated, so implementation may begin on the 63 unblocked tasks.

**Negative, and stated rather than minimised.** A frozen document with **17 open
gaps** invites the reading that those gaps are settled. They are not. Roughly a
quarter of the planned work cannot start. Anyone who reads `FROZEN` as *"ready to
build in full"* will be wrong, which is why §5 exists and why the registry row
carries the gap count.

**Reversible.** If an authority later rules against any part of this document,
the remedy is an ADR that amends it — the normal Rank 3 path, not a silent edit.

---

## 8. Verification — what was measured before conferring

| Check | Result |
|---|---|
| `PRD-008` byte-unchanged through Stages 3, 4 and 6 | ✅ `d24832f33e600518` throughout |
| Obligation count unchanged | ✅ **134 → 134** |
| Acceptance criteria unchanged | ✅ **98 → 98** |
| Gaps unchanged and all open | ✅ **17 → 17**, all **OPEN** |
| `IMPL-700`…`799` collision-free | ✅ **0** collisions; the only prior `IMPL-7xx` string was the row declaring it unallocated |
| Stage 6 tasks trace to requirements | ✅ **83 / 83**; **0** invented identifiers |
| Dart source touched | ✅ **none** — `git diff --stat 5827068 HEAD -- lib test pubspec.yaml android web` is empty |
| Checkers weakened | ✅ **none** — 11 `tool/docs_check` gates give verdicts identical to pre-pass |
| Protected documents mutated | ✅ **none** — all hashes unchanged |
