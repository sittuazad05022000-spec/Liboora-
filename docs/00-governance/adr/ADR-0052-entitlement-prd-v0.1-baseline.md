# ADR-0052 — Entitlement PRD v0.1 is the official baseline for `BC-21` Entitlement

| Field | Value |
|---|---|
| **ADR** | `ADR-0052` |
| **Status** | **Accepted** |
| **Date** | 2026-08-19 |
| **Deciders** | **Governance owner** (Stage 7 and the baseline, `PRD_LIFECYCLE.md` §6 L282) — exercised by direct conferral of the human principal of this engagement, §6 |
| **Supersedes** | Nothing |
| **Amends** | **No ranked document's content.** Admits a new document to Rank 3. `MASTER_PRD.md` (Rank 1), the Bounded Context Map and Module Dependency Matrix (Rank 4), `ARCHITECTURE_RULINGS.md` (Rank 5) and `CONFIGURATION_GUIDE.md` (Rank 7) are **unamended** |
| **Amended by** | — |
| **Baseline** | **`BASELINE-2026-08-19-C`** |
| **Closes** | [`PRD_LIFECYCLE.md`](../prd-ecosystem/PRD_LIFECYCLE.md) **Stage 7** for `PRD-014`. Registry status `PLANNED` → **`FROZEN`** |
| **Does NOT close** | **`ENT-GAP-001` … `ENT-GAP-008`** — all eight remain **OPEN**, each with its named owner (§4 item 7). Nor `D-014-01`…`D-014-06` (code, §3), nor `H-1`, `Q-03`, `Q-06`, `PGA-08`, `GCP-14`, `S4-F-01`…`03`, `S5-F-01`, `AUD-GAP-001`…`005`, `TEN-GAP-001`…`004`, `PGA-01`/`02`/`03`, `GCP-05`/`06`/`09`, `FEE-GAP-*`, `SEAT-GAP-*`, `ATT-GAP-*` |
| **Opens** | Nothing. Unlike `ADR-0051`, this pass found **no pre-existing governance defect while adding its rows** — and §8.1 records that the search was performed and returned empty, rather than leaving the absence unstated |
| **Related** | [`ADR-0051`](./ADR-0051-audit-trail-prd-v0.1-baseline.md) (the immediately preceding freeze; the v0.x admission precedent followed clause by clause; **L406** reserves `IMPL-930`…`999`) · [`ADR-0050`](./ADR-0050-tenancy-prd-v0.1-baseline.md) (§2.2, the first v0.x admission) · [`ADR-0020`](./ADR-0020-seat-management-prd-v1.0-baseline.md) (§4 item 2, the version rule; §4 item 6, gaps are not ratified by admission) · [`ADR-0012`](./ADR-0012-module-dependency-enforcement.md) (§3.4 acknowledged debt; **L86** declares the `:entitlement` port) · [`ADR-0017`](./ADR-0017-feature-flag-vs-entitlement.md) (**L125–126**, the `BC-25`/`BC-21` boundary) · [`ADR-0035`](./ADR-0035-payment-gateway-architecture.md) (**L123**, `platform/business` holds *"exactly two"* contexts) · [`ADR-0013`](./ADR-0013-capability-context-ownership.md) · [`ADR-0014`](./ADR-0014-platform-module-ranks.md) · Baseline §7 · `PRD_LIFECYCLE.md` L155–180 |

---

## 1. The question

[`PRD-014_ENTITLEMENT.md`](../../30-product/entitlement/PRD-014_ENTITLEMENT.md) has completed **Stages 1–6** of
`PRD_LIFECYCLE.md`. It declares **88 identifiers** across eight registers — **six populated, two declared empty** —
**26 acceptance criteria**, and a **30-task** implementation backlog claiming **54 of 54** obligations.

**Should `PRD-014` be admitted to the documentation baseline at Rank 3 as the authoritative specification for
`BC-21` Entitlement?**

Stage 7's gate is *"a row in [`DOCUMENTATION_BASELINE.md`](../DOCUMENTATION_BASELINE.md) §3 at an assigned precedence
rank."* Freeze here is **conferred, not claimed**. This ADR therefore exists **before** the baseline row, because §7
rule 1 of that declaration requires *"a change to any Rank 1–5 document requires an ADR **before** the change."*

---

## 2. Evidence — the artefacts, not the feelings

Six gate records exist on disk. Each was produced by a stage that could have failed, and two of them did fail on first
run and were made to pass by correcting the **instrument**, not the document.

| Stage | Artefact | Verdict |
|---|---|---|
| 1 Discovery | `PRD-014_STAGE1_DISCOVERY.md` (565 lines) | ✅ PASS — `BC-21` identified and **unowned**; 14 findings, 12 rejected |
| 2 Draft | `PRD-014_ENTITLEMENT.md` (658 lines) v0.1 | ✅ On disk, versioned header, all eight registers declared **up front** |
| 3 Architecture | `PRD-014_ARCHITECTURE_ALIGNMENT.md` (437 lines) | ⚠️ **CONDITIONAL PASS** — 8 findings, 11 rejected; §2.1 below |
| 4 Requirements | `PRD-014_STAGE4_REQUIREMENTS_REVIEW.md` (650 lines) | ✅ PASS 6/6; 13 deferrals each with reason and owner |
| 5 Traceability | `PRD-014_STAGE5_CONFERRAL.md` + matrix **v1.15 §2K** | ✅ **CONFERRED** — zero collisions, verified by two independent checkers |
| 6 Impl. tasks | `PRD-014_IMPLEMENTATION_TASKS.md` + `PRD-014_STAGE6_IMPLEMENTATION_TASKS.md` | ✅ PASS — `IMPL-1000`…`1029`, **54/54** obligations claimed |

### 2.1 Figures computed from the PRD, not copied from the reports

Every number below was recomputed by script at the time of this admission. Three independent instruments exist, using
three different parsing strategies (line form, scope position, table column semantics), and all agree.

```
$ python3 tool/docs_check/prd014_traceability.py    # → exit 0   88 identifiers / 8 registers / 26 AC / 54 Class A / 51 covered / 94.4%
$ python3 tool/docs_check/prd014_stage5.py          # → exit 0   8 registers registered in matrix §2K, 0 collisions, 0 outward definitions
$ python3 tool/docs_check/prd014_task_coverage.py   # → exit 0   30 tasks / IMPL-1000..1029 / 54 of 54 claimed / 6 of 6 D-014-* / 0 of 26 proven
```

| Figure | Value | Admitted as |
|---|---|---|
| Identifiers declared | **88** across **8** registers | Six populated, **two declared EMPTY** (§2.4) |
| Acceptance criteria | **26** | ⛔ **0 proven by a passing test** |
| Class A obligations | **54** (`FR`, `BR`, `INV`, `XC`) | **54 of 54 = 100.0%** claimed by a task |
| Acceptance coverage | **51 of 54 = 94.4%** | Admitted at its **measured** value, not rounded up |
| Implementation tasks | **30**, `IMPL-1000`…`IMPL-1029` | **0 of 30** implemented |
| Events published by `BC-21` | **0** | Correct — BC Map L435–437 gives `BC-21` consumers only |
| New `E-*` edges claimed | **0** | BC Map §7 L292: an edge not in the table *"does not exist"* |
| Aggregates claimed | **1** — `EntitlementSet` | Exactly the BC Map L383 grant; **no aggregate owned by another PRD** |

### 2.2 The version, and why it is **not** moved

`PRD-014` is admitted at **v0.1**, the version that was verified. `ADR-0020` **§4 item 2** holds that *"Freeze confers
status; it does not renumber,"* and its §5 expressly **rejects** *"Renumber to v1.0 to mark the freeze."* `PRD-013` was
admitted at v0.1 and `PRD-016` at v0.1 on the same precedent. **This is the third v0.x admission**, and consistency with
the two immediately preceding freezes is itself the reason not to deviate.

### 2.3 Architectural conformance

| Constraint | Source | State |
|---|---|---|
| `EntitlementSet` is the only aggregate | BC Map **L383** | ✅ 1 aggregate, 3 value objects, 1 stated invariant — exactly as granted |
| Derived state only, recomputable from Subscription events | BC Map **L383** | ✅ `ENT-INV-*` restate it as invariants; `IMPL-1009` proves rebuild-equality |
| `E-17` is the only inbound sync edge | BC Map **L326** | ✅ Declared, not invented; `IMPL-1020` implements it |
| Entitlement written **only** by `billing.EntitlementChanged` handlers | Matrix **L360 `X-11`**, manifest **`BZ-1`** | ✅ `ENT-BR-001` + `IMPL-1011`/`1012` |
| No capability context imports a domain context | BC Map **§7.4 `F-1`** | ✅ `banned_imports: ["domain/**","app/**"]` respected; 0 code changes made |
| Authorisation stays in `BC-18` | Matrix **`X-13`** | ✅ `ENT-XC-*` excludes it explicitly |
| `platform/business` holds exactly two contexts | `ADR-0035` **L123** | ✅ `BC-20` + `BC-21`; no third context introduced |
| *"is this on"* vs *"is this paid for"* | `ADR-0017` **L125–126** | ✅ The `BC-25`/`BC-21` line restated as an exclusion, not re-decided |

**Stage 3 returned CONDITIONAL, and that is admitted rather than smoothed.** The condition is **`H-1`** — a hazard
`PRD-007` raised at its own L431 and `PRD-013` inherited, both **before** this module existed. It is not a `PRD-014`
defect and `PRD-014` has no authority to resolve it. The backlog was written so that **`IMPL-1026` is satisfiable under
either resolution**, and no task in the 30 is contingent on the answer. Admitting a document whose one condition is
inherited, upstream and neutralised is different from admitting one with an open defect of its own.

### 2.4 Two empty registers, and why emptiness is the correct content

`ENT-EVT-*` and `ENT-CFG-*` are declared **EMPTY**.

- **`ENT-EVT-*` is empty because `BC-21` publishes nothing.** BC Map L435–437 lists only events `BC-21`
  **consumes**. Minting a published event would have created an edge, and §7 L292 states an edge not in the table
  *"does not exist and adding it requires an ADR."*
- **`ENT-CFG-*` is empty because no authority bounds any entitlement parameter.** `CONFIGURATION_GUIDE.md` contains
  **0** entitlement configurables. `Q-03` (fail-open vs fail-closed) and `Q-06` (proration ownership) are **OPEN** at
  BC Map §13 L542/L545 and `MASTER_PRD.md` L675/L678. **A timeout, a grace period and a fail disposition were each
  refused rather than invented.** BC Map L467 requires a grace period be *"configured, not implicit"* — and configuring
  it is not this ADR's to do.

An empty register that says *why* it is empty is evidence. An omitted register is indistinguishable from an oversight.

---

## 3. The six code findings — routed at the correct rank, and **not** fixed here

`lib/platform/business/business.dart` and `lib/bootstrap/seed.dart` contain a pre-existing `EntitlementService`
scaffold that contradicts the specification in six measured ways. All six are recorded; **none is fixed by this ADR.**

| ID | Contradiction | Locus | Scheduled |
|---|---|---|---|
| `D-014-01` | `tenantId` is ambient rather than an explicit argument | `business.dart` L18–23 | `IMPL-1022` |
| `D-014-02` | Tier state held in a bare `Map<String, TenantTier>`, not a derived aggregate | `business.dart` L21 | `IMPL-1000`…`1003` |
| `D-014-03` | Usage held in `Map<String, int>` with no `UsageCounter` value object | `business.dart` L22 | `IMPL-1002` |
| `D-014-04` | No rebuild-from-events path exists, so the BC Map L383 invariant is unprovable | `business.dart` | `IMPL-1009` |
| `D-014-05` | **No test file exists at all** for `platform/business` | — | `IMPL-1029` |
| `D-014-06` | Bootstrap writes entitlement directly, bypassing the event contract | `seed.dart` L95–96 | `IMPL-1012` |

`D-014-06` is the most serious: it is a direct write, which Matrix **L360 `X-11`** warns makes *"revenue leakage
unauditable,"* and manifest assertion **`BZ-1`** forbids. It is **carried to Stage 8, not repaired**, because
`ADR-0020` **§6.2** governs — *"Freeze authorises implementation to begin; it does not perform it"* — and the
engagement's boundary is explicit: **no file under `lib/`, `packages/` or `test/` was touched by this pass.** Verified:
`git status --short lib/ packages/ test/` → **0 lines**.

### 3.1 Why six contradictions do not block the freeze

Because the freeze admits a **document**, and the document is right where the code is wrong. Freezing the specification
is what makes the six contradictions *defects* rather than *opinions*: until now there was no ranked statement for the
scaffold to contradict. Refusing the freeze would leave the code unchallenged and the module unspecified, which is
strictly worse.

---

## 4. The decision

1. **`PRD-014_ENTITLEMENT.md` v0.1 is admitted to `DOCUMENTATION_BASELINE.md` §3.3 at Rank 3** as the authoritative
   specification for **`BC-21` Entitlement** `[GENERIC]`.
2. **The version is NOT incremented.** v0.1 is the version verified (`ADR-0020` §4 item 2).
3. **The six Stage 1–6 gate records are admitted as validation records at Rank 3**, per the `ADR-0049` §4 item 3
   precedent — admitted *as what they are*, measurements, not as requirements.
4. **The baseline identifier advances to `BASELINE-2026-08-19-C`**, because a Rank 3 document changed version
   (§7 rule 4). This is the **third** identifier issued on 2026-08-19.
5. **Registry status `PLANNED` → `FROZEN`** for `PRD-014`.
6. **No ranked document's content is amended.** No `E-*` edge, no event, no aggregate, no configurable, no business rule
   and no legal rule is created by this admission.
7. **All eight `ENT-GAP-*` are admitted OPEN**, each retaining its named owner. `ADR-0020` **§4 item 6**: admission does
   not ratify a gap.
8. **`FROZEN` does not mean `VERIFIED`.** ⛔ **0 of 26** acceptance criteria are proven and **0 of 30** tasks are
   implemented. What is frozen is the statement of intent, not evidence of a working module.
9. **`Q-03`, `Q-06` and `H-1` are NOT decided here.** They belong to authorities this ADR does not hold, and BC Map §13
   already directs that each *"should become an ADR."*

### 4.1 What the admission rests on

Three instruments, three parsing strategies, one set of numbers; six gate records each capable of failing; a PRD hash
verified unchanged at every stage boundary (`d4ca7e11…c175`); and mutation testing at Stages 5 and 6 — **6/6** and
**7/7** injected defects caught, with every document restored byte-identical afterwards.

---

## 5. What this admission does **not** rest on

| Not relied upon | Why it would have been wrong |
|---|---|
| That the checkers passed on first run | Two did **not**. Stage 5 failed 5 times, Stage 6 failed 4 — **all nine were instrument defects**, diagnosed and fixed in the instruments. A gate that cannot fail is not a gate |
| That the task document's 100% and the PRD's 94.4% describe the same thing | They do not. 100% is *obligations claimed by a task*; 94.4% is *obligations carrying a criterion*. Conflating them would hide three real gaps behind a full number |
| That `PRD_LIFECYCLE.md`'s `IMPL-*` table is current | It is **stale** — it ends `IMPL-227+ | Unallocated` while `IMPL-227` is occupied. The range was computed from **489** measured identifiers instead. The table is **disclosed, not amended**: repairing a Rank 1 table needs its own ADR |
| That matrix §2J.1's `FR-*` hazard example is accurate | It is **not** — the location it names has no `FR` column (`S5-F-01`). The hazard *class* is real; its stated *location* is wrong. Disclosed, **not edited**, per the standing rule that *"a stale review is corrected by a dated re-run beside it"* |
| That the inherited bare `grep -c 'PREFIX-'` measurement was safe here | It is **not safe for `ENT-`**, which matches inside `MANAGEMENT-` and `ALIGNMENT-`. Every scan in this pass carried `(?<![A-Z])`, and §2K publishes the regex with the count |

---

## 6. The authority basis, stated plainly

`PRD_LIFECYCLE.md` **§6 L282** assigns Stage 7 and the baseline to the **Governance owner**. L283 records that
*"Every PRD needs a named owner. **None has one**"* (`PGA-08`).

The authority exercised here is direct, explicit and unconditional conferral by the human principal, scoped to this
engagement: the instruction was to carry `PRD-014` through **Stages 1–7** in *"one consolidated pass,"* following *"all
existing repository authority and ownership boundaries,"* and to *"only confer FROZEN status through the repository's
actual baseline/governance mechanism."* **That instruction is the authority, and it is the only authority claimed.**

`ADR-0033` §7.1 — *"A conferral for one act is not a standing licence."* This admission does **not** cure `PGA-08`:
`PRD-014` still has no standing named owner after this ADR exists.

### 6.1 The conditions attached to the grant, and how each was tested

| Condition in the instruction | How it was honoured |
|---|---|
| *"EntitlementSet is the BC-21 aggregate and must not claim aggregates owned by other PRDs"* | Exactly 1 aggregate claimed, matching BC Map L383. `Seat`/`SeatQuota` kept distinct per BC Map L211's CI lint rule |
| *"Do not invent requirements, features, events, architecture decisions, ownership, configuration values, legal rules, or business rules"* | 0 events published, 0 edges added, 0 configurables minted, 2 registers left EMPTY, `Q-03`/`Q-06`/`H-1` left undecided |
| *"Do not restate frozen PRDs; cite their authority where required"* | Frozen PRDs cited, never restated |
| *"Use a collision-free identifier prefix and declare all identifier ranges upfront"* | `ENT-` verified collision-free by anchored scan against **68** registered stems; all 8 registers declared in §0.2 before use |
| *"Mechanically verify"* | Three checkers, three strategies, plus 13 mutations across two stages |
| *"Record rejected findings and explain why they were rejected"* | `R3-01`…`R3-11`, `R5-01`…`R5-07`, and 12 at Stage 4 |
| *"Do not silently hide or delete your own mistakes"* | **9 self-inflicted instrument defects** recorded: `S4-C-01`/`02`, `S5-C-01`…`06`, `S6-C-01`…`04` |
| *"Do not modify lib/, packages/, or test/"* | **0 lines changed.** Six code contradictions recorded, none repaired |
| *"Do not start Stage 8"* | Not started. §7 below states what remains forbidden |

---

## 7. What acceptance does **NOT** license

| Claim | Licensed? |
|---|---|
| Implementation of `BC-21` may begin | ✅ Yes — that is the purpose of the freeze |
| `IMPL-1000`…`IMPL-1029` may be worked | ✅ Yes, at Stage 8, by the Implementation Lead |
| `BC-21` is built, tested or working | ❌ **No.** 0 of 30 tasks, 0 of 26 criteria |
| A fail-open/fail-closed disposition is decided | ❌ **No.** `Q-03` remains OPEN |
| Proration ownership is decided | ❌ **No.** `Q-06` remains OPEN |
| A timeout, grace period or retention value is set | ❌ **No.** No configurable exists; none was invented |
| A new `E-*` edge, event or aggregate exists | ❌ **No.** Zero created |
| `H-1` is resolved | ❌ **No.** Inherited and still undetermined |
| `PRD_LIFECYCLE.md`'s stale `IMPL` table is repaired | ❌ **No.** Disclosed for the fourth consecutive backlog; needs its own ADR |
| Matrix §2J.1's `FR-*` location claim is corrected | ❌ **No.** `S5-F-01` disclosed, not edited |
| The four pre-existing exit-1 doc checkers are fixed | ❌ **No.** Out of scope and untouched |
| `PGA-08` is cured | ❌ **No.** Still no named owner |

---

## 8. Counts re-derived by measurement, not by incrementing

| Register | Before | After | Method |
|---|---|---|---|
| ADR files in `docs/00-governance/adr/` | 52 (51 ADRs + index) | **53** (52 ADRs + index) | `ls docs/00-governance/adr/*.md \| wc -l` |
| Accepted ADRs | 38 | **39** | Only this one moves |
| Proposed ADRs | 13 | **13** | Deliberately unchanged — no ADR promoted or demoted |
| Superseded / deprecated | 0 / 0 | **0 / 0** | Unchanged |
| Rank 3 module baselines | ten | **eleven** | §4 prose advanced with §3.3 in the same commit |
| Registry `FROZEN` | 10 | **11** | `PRD-014` only |
| Registry `PLANNED` | 11 | **10** | `PRD-014` only |
| Baseline identifier | `BASELINE-2026-08-19-B` | **`BASELINE-2026-08-19-C`** | §7 rule 4 |

### 8.1 The search for pre-existing defects was performed and returned empty

`ADR-0051` §8.1 opened `GCP-18` after *"testing this ADR's own claim to have found nothing,"* which falsified it. That
precedent obliges the same test here rather than the same conclusion.

The four edit targets were therefore measured before editing: `DOCUMENTATION_BASELINE.md` §3.3 (row count vs §4 prose),
§4 Rank 2/Rank 3 counts vs their own enumerations, `ADR-INDEX.md` L9's declared counts vs a re-classification of every
file's own `Status` row, and `PRD_REGISTRY.md` §7's four count fields vs its own table. **All were internally
consistent.** `GCP-18` and `GCP-19` are recorded as CLOSED by the previous pass and remain so.

**No new `GCP-*` is opened.** That is stated explicitly because an ADR that silently reports no defects is
indistinguishable from one that never looked — and one that has already been caught out this way once.

---

## 9. Options considered

| Option | Rejected because |
|---|---|
| **Admit at Rank 3, v0.1** *(chosen)* | The verified state of a document that passed six gates |
| Renumber to v1.0 to mark the freeze | `ADR-0020` §5 expressly rejects this |
| Refuse until `Q-03`/`Q-06` are decided | Both belong to other authorities; BC Map §13 already routes them. Refusing would leave `BC-21` permanently unspecified while a code scaffold writes entitlement directly |
| Refuse because Stage 3 was CONDITIONAL | The condition is inherited `H-1`, not a `PRD-014` defect, and the backlog is correct under either resolution |
| Fix the six code contradictions first | Stage 8 work, expressly forbidden by the engagement boundary |
| Populate `ENT-CFG-*` with sensible defaults | Inventing configuration values. Explicitly prohibited |
| Admit at Rank 4 or 5 | `PRD-014` is a module PRD; Rank 3 is its place, and the ten existing module baselines set the precedent |

---

## 10. Consequences

### 10.1 Immediate

- `PRD-014` becomes the authority for `BC-21`. Any later business-rule change requires **ADR → version increment →
  changelog → baseline update, in that order** (`PRD_LIFECYCLE.md` L155–180).
- The six `D-014-*` contradictions become **defects against a ranked document**, not matters of taste.
- `IMPL-1000`…`IMPL-1029` is permanently allocated. `IMPL-1030`…`1099` is reserved for `PRD-014` growth.

### 10.2 What does **not** change

No code. No test. No `E-*` edge. No event. No configurable. No other PRD. No ADR's status but this one's.

### 10.3 Carried forward

`ENT-GAP-001`…`008` · `D-014-01`…`06` · `H-1` · `Q-03` · `Q-06` · `S4-F-01`…`03` · `S5-F-01` · `PGA-08` · `GCP-14` ·
the stale `PRD_LIFECYCLE.md` `IMPL` table · the four pre-existing exit-1 doc checkers · ⛔ 0 of 26 criteria proven.

---

## 11. Compliance

| §7 rule of `DOCUMENTATION_BASELINE.md` | Satisfied |
|---|---|
| 1. A change to any Rank 1–5 document requires an ADR **before** the change | ✅ This ADR was written and accepted first |
| 2. The changed document's version is incremented and its changelog updated in the same commit | ✅ Baseline, `ADR-INDEX`, registry and matrix all updated in this commit |
| 3. This declaration is updated in the same commit | ✅ §3.3, §4, §6, §8 and the change history together |
| 4. The baseline identifier changes only when a Rank 1–3 document changes version | ✅ A Rank 3 document is admitted → `BASELINE-2026-08-19-C` |

---

## 12. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-19 | Created **`ACCEPTED`** as the admission ADR for `PRD-014` Entitlement, admitting it at **Rank 3, v0.1** for **`BC-21`** and advancing the baseline to **`BASELINE-2026-08-19-C`**. Figures recomputed by **three instruments using three parsing strategies** — **88** identifiers / **8** registers (**2 EMPTY by finding**) / **26** AC / **54** Class A / **51** covered = **94.4%** / **30** tasks `IMPL-1000`…`1029` claiming **54 of 54 = 100.0%** — never copied from the stage reports. **The version is deliberately NOT incremented** (`ADR-0020` §4 item 2); this is the **third** v0.x admission after `PRD-013` and `PRD-016`. ⛔ **0 of 26** criteria proven, **0 of 30** tasks implemented — `FROZEN` is not `VERIFIED`. **All 8 `ENT-GAP-*` admitted OPEN**; `Q-03`, `Q-06` and `H-1` **left undecided** because they belong to other authorities. **2 registers admitted EMPTY rather than populated** — `BC-21` publishes no event and no authority bounds any entitlement parameter, so a timeout, grace period and fail disposition were each **refused rather than invented**. ⚠ **Stage 3 was CONDITIONAL and that is admitted, not smoothed**: the condition is inherited `H-1`, and `IMPL-1026` is satisfiable under either resolution. ⛔ **`D-014-01`…`D-014-06` were NOT fixed** — six code contradictions carried to Stage 8, `git status --short lib/ packages/ test/` → **0 lines**. ⚠ **9 self-inflicted instrument defects are recorded, not hidden** (`S4-C-01`/`02`, `S5-C-01`…`06`, `S6-C-01`…`04`), including two caught by a guard catching its own author's bad input, and one case where **the checker was wrong and the document right** — had it been trusted, a correct document would have been edited to satisfy a defective instrument. **13 mutations injected across Stages 5 and 6, all 13 caught**, every document restored byte-identical. ⚠ The stale Rank 1 `IMPL-227+` table and matrix §2J.1's false `FR-*` location claim (`S5-F-01`) are **disclosed and left intact**. **No new `GCP-*` opened — and §8.1 records that the search was performed and returned empty**, following the `ADR-0051` §8.1 precedent that obliges the test rather than the conclusion |
