# ADR-0034 — Attendance Management PRD v1.9 is the official baseline for `BC-03` Attendance

| Field | Value |
|---|---|
| **Status** | **Accepted** |
| **Date** | 2026-08-05 |
| **Deciders** | **Product Owner** (freeze authorisation) and **Architecture Owner** (dependency ruling) — both exercised by **direct conferral of the human principal of this engagement**, recorded as a conferral and **not represented as an ARB meeting**. See §7.2 |
| **Supersedes** | Nothing |
| **Amends** | **No ranked document.** Admits an existing document to Rank 3. `MASTER_PRD.md`, `LIBOORA_BOUNDED_CONTEXT_MAP.md`, `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` and `ARCHITECTURE_RULINGS.md` are **unamended by this ADR** |
| **Amended by** | — |
| **Baseline** | `BASELINE-2026-08-05-A` |
| **Closes** | [`PRD_LIFECYCLE.md`](../prd-ecosystem/PRD_LIFECYCLE.md) Stage 7 for `PRD-006`. Registry status `PLANNED` → `FROZEN` |
| **Does NOT close** | **`ATT-GAP-*` — 18 rows remain OPEN**, including `ATT-GAP-002a` (the load-bearing one) and `ATT-GAP-003`/`004`. Nor `R-14`, nor the `ATT-CFG` tolerance **range** (`ADR-0031`, still `Proposed`), nor `SEAT-GAP-009`, nor `GCP-05`/`06`/`09`, nor the nine `ADR-0012` boundary findings. See §3 |
| **Related** | [`ADR-0020`](./ADR-0020-seat-management-prd-v1.0-baseline.md) (the `PRD-007` freeze precedent this ADR follows) · `ADR-0019` (`PRD-005`) · `ADR-0018` (`PRD-004`) · [`ADR-0032`](./ADR-0032-attendance-presence-visibility-to-seating.md) · [`ADR-0033`](./ADR-0033-e27-core-cluster-edge-allowlist.md) · [`PRD_LIFECYCLE.md`](../prd-ecosystem/PRD_LIFECYCLE.md) Stage 7 · [`DOCUMENTATION_BASELINE.md`](../DOCUMENTATION_BASELINE.md) §7 |

---

## 1. The question

[`PRD-006_ATTENDANCE-MANAGEMENT.md`](../../30-product/attendance-management/PRD-006_ATTENDANCE-MANAGEMENT.md)
(`PRD-006`, `BC-03` Attendance) has completed Stages 1–6 of the lifecycle. `PRD_REGISTRY.md` L236 still records it
`PLANNED`, and `PRD_REGISTRY.md` L548 describes the resulting state precisely:

> *"`PRD-006` Attendance, which is still `PLANNED` — **a frozen consumer waiting on an unwritten producer.**"*

`PRD-007` Seating was frozen on 2026-08-04 and derives live occupancy from `BC-03` over `E-08`. **Should `PRD-006`
v1.9 be admitted to Rank 3 as the authoritative specification for `BC-03`?**

Stage 7's gate is explicit: *"a row in `DOCUMENTATION_BASELINE.md` §3 at an assigned precedence rank"*, and
*"Freeze is **conferred, not claimed**."* This ADR is the instrument of conferral.

---

## 2. Evidence

### 2.1 Gate records, all re-run immediately before acceptance

| Stage | Record | Result |
|---|---|---|
| **Stage 3** — Architecture | [`PRD-006_ARCHITECTURE_ALIGNMENT.md`](../../30-product/attendance-management/PRD-006_ARCHITECTURE_ALIGNMENT.md) v1.2 + [`..._V19_SUPPLEMENT.md`](../../30-product/attendance-management/PRD-006_ARCHITECTURE_ALIGNMENT_V19_SUPPLEMENT.md) **v1.1** | ✅ **ALIGNED — 6 of 6** |
| **Stage 4** — Requirements | [`PRD-006_STAGE4_REREVIEW_V19.md`](../../30-product/attendance-management/PRD-006_STAGE4_REREVIEW_V19.md) | ✅ **A — PASSED, 6 of 6** |
| **Stage 5** — Traceability | `tool/docs_check/prd006_traceability.py` | ✅ **exit 0** |
| **Stage 6** — Task coverage | `tool/docs_check/prd006_task_coverage.py` | ✅ **exit 0 — 285/285 = 100.0%** |

**Stage 5 measured registers:** `ATT-FR` 151 · `ATT-BR` 45 · `ATT-INV` 12 · `ATT-EVT` **4** · `ATT-XC` 21 ·
`ATT-PO` 14 · `ATT-CFG` 24 · `ATT-NFR` 14 · `ATT-AC` 222 · `ATT-GAP` 18 numbers / 23 rows — **525 identifiers**,
285 obligation-bearing, **0 dangling references, 0 orphan criteria, 0 collisions**, ranges contiguous, no duplicate
definition.

### 2.2 The dependency question was resolved, not deferred

The single architectural blocker at the last review was `E-27`. It is **closed by removal**:

| | |
|---|---|
| **Found** | `E-27` (`BC-03` → `BC-04`) was an **intra-cluster** Core Library edge, while Rank 4 `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` L89/L202 permits **only** `E-01`…`E-10`, *"Enforced as an explicit allow-list"*. `E-27` was the **only** edge above `E-10` with both endpoints in the cluster |
| **Ruled** | [`ADR-0033`](./ADR-0033-e27-core-cluster-edge-allowlist.md) **`Accepted`**, option **`O-C` — withdraw `E-27`** |
| **Executed** | `LIBOORA_BOUNDED_CONTEXT_MAP.md` **v1.6 → v1.7**; the edge set returns to **`E-01`…`E-26`**, **26 edge rows, identical to baseline `01684e5`** |
| **Why withdrawal was correct** | Frozen Rank 3 **`SEAT-FR-104`** already composes Seat Card holder data **from `BC-01` at read time** while **no `BC-01` → `BC-04` edge has ever existed**. Read-time cross-context composition is an **already-ratified pattern needing no numbered edge**. `E-27` was never architecturally required |
| **Not done** | The allow-list was **not widened**; `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` is **unamended** (`9895d244494372af`) |

### 2.3 Verification coverage, admitted at its measured value

**Obligation coverage is 285/285 = 100.0%** of `ATT-NFR-010`'s mandate, and **`ATT-AC` 222 criteria** exist. But
`PRD-006` is **`FROZEN`, not `VERIFIED`**: **0 of 179 `IMPL-6*` tasks and 0 of 222 acceptance criteria are proven
by a test**, and `SID-4.56` holds that *"a rule that cannot be checked SHALL be treated as unmet"*. This is stated
here rather than rounded up, following `ADR-0019` §2 and `ADR-0020` §2.5.

### 2.4 No requirement changed on admission

**No requirement, API, event, payload, invariant, acceptance criterion, business rule, register, exclusion,
protected operation, configurable or scope statement was added, removed, renumbered or reworded.** The PRD's only
edits on admission are its *Status*, *Baseline*, *Rank* and *ADRs applied* metadata rows plus one changelog entry.
**The version is preserved at v1.9** — freeze confers status, not a renumbering, following `PRD-003`-at-v1.0,
`PRD-004`-at-v1.2, `PRD-005`-at-v1.4 and `PRD-007`-at-v1.0.

**Specifically preserved:** the 5-minute grace · the 30-minute Owner/Manager-configurable tolerance · final
qualifying Wi-Fi disconnect = attendance exit · no exit inference from absence or process death · multi-device OR
presence · optional Location Verification **default OFF** · the no-booking and overstay statuses · **four** Seat
Card states (⚪ NOT ATTENDED · 🟢 PRESENT · 🟠 ATTENDED·PRESENCE UNVERIFIED · 🔵 ATTENDED·LEFT) · manual attendance
≠ verified presence · Seat allocation ≠ presence · Seat Card read-time composition · the Seat Card never reading
raw Wi-Fi or device state · **exactly four** attendance events, no fifth, and no overload of the existing
check-out event.

---

## 3. The open items — investigated, not resolved

**Admission does not ratify a single open gap.** Each remains open and is listed so no reader mistakes a frozen
specification for a settled one. This follows `ADR-0020`, which froze `PRD-007` with **all fourteen**
`SEAT-GAP-*` OPEN, and `PRD-007_INDEPENDENT_GAP_VERIFICATION.md` `GV-2`, which established that *"an open gap
blocks a PASS"* is **not a rule in this repository**. The Stage 4 gate is *"conflicts closed **or explicitly
deferred with a reason and an owner**"*.

| Open item | Owner | Why admission is still sound |
|---|---|---|
| **18 `ATT-GAP-*` rows**, incl. the load-bearing `ATT-GAP-002a` — `BC-03` has no authorised inbound device-identity edge | **Architecture Owner** (`ADR-0030`, `Proposed`) | The PRD **specifies the boundary as a port** and refuses to invent the edge. A mode that cannot be built is declared unbuildable rather than silently assumed |
| **The tolerance *range*** — `ADR-0031` remains `Proposed`; no allowed range has been approved | **Product Owner** | **A twenty-fifth `ATT-CFG` row was deliberately NOT created.** Inventing a range would have been an unapproved numeric. All **24** existing `ATT-CFG-*` rows carry a Default **and** a Range, so Stage 4 check 3 passes *because* the row was refused |
| **`R-14`** — accepting no mandatory foreground service, at the cost of more `INCOMPLETE / EXIT NOT VERIFIED` outcomes | **Product Owner** | A product trade-off, explicitly recorded; the specification is deterministic under either answer |
| **`ATT-GAP-003`/`004`** — BC Map §9 names `BC-26`/`BC-13` consumers that §7 gives no edge | **Architecture Owner** | The **systemic** `SM-GAP-11`/`MM-GAP-010` defect across ten producing contexts. **Frozen `PRD-004`, `PRD-005` and `PRD-007` all declined it.** `PRD-006` follows the frozen precedent exactly |
| **`SEAT-GAP-009`** — may `BC-03` read `BC-04`'s allocation? | **Architecture Owner** | The **opposite** direction to `E-27`; untouched by `ADR-0033` and explicitly still open |
| **`GCP-05`, `GCP-06`, `GCP-09`** and the nine `ADR-0012` boundary findings | Architecture Owner / named owners | Pre-existing, time-boxed, and unrelated to `BC-03` |

**This ADR makes no decision on any of them.**

---

## 4. Decision

**`PRD-006_ATTENDANCE-MANAGEMENT.md` v1.9 is admitted to Rank 3 as the authoritative specification for `BC-03`
Attendance**, at baseline `BASELINE-2026-08-05-A`. Registry status `PLANNED` → **`FROZEN`**.

`BC-03` is the **seventh** Rank 3 module baseline and the **fourth** `[CORE]` Library-cluster context to be frozen.
With `BC-01`, `BC-02` and `BC-04` already frozen, the `E-01`/`E-02`/`E-03`/`E-08` chain is now frozen end to end,
and `PRD-007`'s occupancy dependency — recorded as an open scheduling fact in `ADR-0020` §3.2 — **is answered**:
its producer is now specified.

**From this moment `PRD-006` is never silently modified.** Any change requires an ADR naming it, per Stage 7 and
`DOCUMENTATION_BASELINE.md` §7.

---

## 5. Options considered

| Option | Disposition |
|---|---|
| **Freeze at v1.9** | ✅ **SELECTED.** All six Stage 3 checks, all six Stage 4 checks and both mechanical gates pass; the one architectural blocker was resolved by `ADR-0033` |
| Withhold the freeze until every `ATT-GAP-*` closes | ❌ Rejected — `GV-2` established this is **not a rule**, and `ADR-0020` froze `PRD-007` with fourteen gaps open. Applying an invented stricter rule to `PRD-006` alone would be inconsistent, not careful |
| Withhold until the tolerance range is approved | ❌ Rejected — the range is a **`Proposed` ADR for the Product Owner**, and the PRD is deterministic without it. Freezing does not approve it |
| Renumber to v1.0 on admission | ❌ Rejected — four precedents preserve the version. Stage 7 confers status, not a renumbering |
| Freeze at v1.8 or earlier | ❌ Rejected — Stage 4 was re-run for **v1.9** specifically; earlier versions have no current gate record |

---

## 6. Consequences

**Positive.** `BC-03` has an authoritative specification. `PRD-007`'s producer exists. The `E-27` contradiction is
gone and the Core Library cluster is once again fully inside its Rank 4 allow-list.

**Negative, and stated plainly.**

- **`PRD-006` is `FROZEN`, not `VERIFIED`.** 0 of 179 tasks and 0 of 222 criteria are proven by a test.
- **Two modes remain unbuildable** pending `ATT-GAP-002a` and the device-identity edge. The PRD says so itself.
- **The tolerance range is still unapproved.** A configurable with a default and a documented range exists for all
  24 registered settings, but the *new* tolerance setting `ADR-0031` describes was **never created**, so no
  implementer can build it yet. **This is deliberate: refusing to invent a number is why Stage 4 check 3 passes.**
- **18 gaps remain open**, each with a named owner.

**Neutral.** `TRACEABILITY_MATRIX.md` and `PRD-006_IMPLEMENTATION_TASKS.md` are **deliberately not modified** —
Stage 7's gate is a baseline row, and the `ADR-0018` §3.4 / `ADR-0019` §3.6 / `ADR-0020` §3.4 precedent preserves
independently verified bytes rather than tidying them.

---

## 7. Compliance

### 7.1 Process order

`DOCUMENTATION_BASELINE.md` §7 requires **ADR → change → version → changelog → baseline**. This ADR was written
and reviewed **before** `PRD-006`'s status metadata, the registry row or the §3 baseline row were touched.

### 7.2 Authority basis — recorded as it actually is

`PRD_OWNERSHIP_MODEL.md` §5: *"Only the Architecture Owner approves."* The authority exercised here is a **direct,
explicit conferral by the human principal of this engagement**, who instructed that `PRD-006` be taken *"to FINAL
FREEZE"*, that the `E-27`/`O-C` ruling be resolved *"according to Architecture Owner authority"*, that a *"proper
admitting ADR"* be created and registered, and that the `DOCUMENTATION_BASELINE.md` §3 record be added. **That
instruction is the authority, and it is the only authority claimed.**

**What is NOT claimed, stated so no later reader infers it:**

| Not claimed |
|---|
| **No ARB meeting was held, minuted or attended.** No quorum, attendee list or sign-off date is asserted |
| **No Security review, no independent external reviewer and no Principal Enterprise Architect approval** is claimed. `ADR-0020` names three deciders; this ADR names a conferral, and the difference is deliberate |
| **No Product Owner signature on the open items.** `R-14` and the tolerance range remain open and are **not** approved by this freeze |
| **This freeze does not confer `VERIFIED`.** Stage 9 requires implementation evidence that does not exist |

### 7.3 What was verified mechanically, not asserted

`prd006_traceability.py` **exit 0** · `prd006_task_coverage.py` **exit 0** · BC Map edge rows **26**, matching
baseline · `E-08` **byte-identical** (md5 `34dc906540c90ed447003348e52f5f39`) ·
`LIBOORA_MODULE_DEPENDENCY_MATRIX.md` **`9895d244494372af`, unchanged** · **zero** Dart source files changed since
baseline `01684e5` · **zero** gate scripts modified · working tree clean.

### 7.4 Known-red checks, disclosed rather than cleared

| Check | State | Why it does not block |
|---|---|---|
| `tool/check_module_boundaries.dart` | ❌ **FAIL — 9 violations** | All are pre-existing `ADR-0012` time-boxed `app → domain/library` findings, **red by design** until 2026-10-31, and **none concerns `BC-03` or `E-27`** |
| `tool/docs_check/prd007_traceability.py` | ❌ **FAIL — 2** | Pre-existing: `SEAT-*` citations inside attendance-module governance documents. **A citation is not a collision** (`DOCUMENTATION_BASELINE.md` L298 precedent). The `ALLOWED` list was **not** widened to clear it |

**Neither was made green.** Weakening a gate to obtain a freeze is the failure mode this section exists to
foreclose.

---

## 8. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-05 | Created and **Accepted**. Admits `PRD-006` **v1.9** to Rank 3 as the baseline for `BC-03` Attendance — the **seventh** Rank 3 module baseline and the **fourth** frozen `[CORE]` Library-cluster context, completing the `E-01`/`E-02`/`E-03`/`E-08` chain and answering `ADR-0020` §3.2's open occupancy dependency. Baseline **`BASELINE-2026-08-05-A`**, issued because a **Rank 3** document entered the baseline (§7 step 4). Rests on Stage 3 ✅ **ALIGNED 6/6** (after `ADR-0033` withdrew `E-27`), Stage 4 ✅ **A — 6/6**, and two mechanically re-run gates at **exit 0** (525 identifiers, 0 dangling, 0 orphans, 0 collisions; 285/285 obligations claimed). **All 18 `ATT-GAP-*` are admitted OPEN and none is ratified**, following `ADR-0020`'s fourteen-open-gap precedent and `GV-2`'s finding that an open gap does not block a PASS. **The tolerance range remains unapproved and a twenty-fifth `ATT-CFG` row was deliberately NOT created** — refusing to invent a number is precisely why Stage 4 check 3 passes. **No requirement identifier was added, removed, renumbered or reworded**; the version is preserved at v1.9 on four precedents. **Two gates remain red and are disclosed rather than cleared** — nine `ADR-0012` boundary findings and two pre-existing `SEAT-*` citation hits — and **no gate script was modified**. `PRD-006` is **`FROZEN`, not `VERIFIED`**: 0 of 179 tasks and 0 of 222 acceptance criteria are proven by a test. |
