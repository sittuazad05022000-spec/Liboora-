# ADR-0051 — Audit Trail PRD v0.1 is the official baseline for `BC-24` Audit Trail

| Field | Value |
|---|---|
| **ADR** | `ADR-0051` |
| **Status** | **Accepted** |
| **Date** | 2026-08-19 |
| **Deciders** | **Governance owner** (Stage 7 and the baseline, `PRD_LIFECYCLE.md` §6 L282) — exercised by direct conferral of the human principal of this engagement, §6 |
| **Supersedes** | Nothing |
| **Amends** | **No ranked document's content.** Admits a new document to Rank 3. `MASTER_PRD.md` (Rank 1), the Bounded Context Map and Module Dependency Matrix (Rank 4), `ARCHITECTURE_RULINGS.md` (Rank 5) and `CONFIGURATION_GUIDE.md` (Rank 7) are **unamended** |
| **Amended by** | — |
| **Baseline** | **`BASELINE-2026-08-19-B`** |
| **Closes** | [`PRD_LIFECYCLE.md`](../prd-ecosystem/PRD_LIFECYCLE.md) **Stage 7** for `PRD-016`. Registry status `PLANNED` → **`FROZEN`** |
| **Does NOT close** | **`AUD-GAP-001` … `AUD-GAP-005`** — all five remain **OPEN**, each with its named owner (§4 item 7). Nor `D-016-01`, `D-016-02`, `D-016-03` (code, §3), nor `PGA-08`, `GCP-14`, `S3-A-01`…`03`, `S4-D-01`, `TEN-GAP-001`…`004`, `PGA-01`/`02`/`03`, `GCP-05`/`06`/`09`, `BLK-01`/`TASK-D10` |
| **Opens** | **`GCP-18`** — `PRD_REGISTRY.md` §7's document-existence enumeration never recorded `PRD-013`, found by testing this ADR's own claim to have found nothing. Corrected in this commit and logged, §8.1 |
| **Related** | [`ADR-0050`](./ADR-0050-tenancy-prd-v0.1-baseline.md) (the immediately preceding freeze; the v0.x admission precedent this ADR follows clause by clause) · [`ADR-0020`](./ADR-0020-seat-management-prd-v1.0-baseline.md) (§4 item 2, the version rule; §4 item 6, gaps are not ratified by admission) · [`ADR-0049`](./ADR-0049-revenue-finance-prd-v1.7-baseline.md) (§4 item 3, validation records admitted as such) · [`ADR-0013`](./ADR-0013-capability-context-ownership.md) (capability-context ownership; the two ownership rights) · [`ADR-0014`](./ADR-0014-platform-module-ranks.md) (`platform/audit` at rank 5) · Baseline §7 · `PRD_LIFECYCLE.md` L155–180 |

---

## 1. The question

[`PRD-016_AUDIT_TRAIL.md`](../../30-product/audit/PRD-016_AUDIT_TRAIL.md) has completed **Stages 1–6** of
`PRD_LIFECYCLE.md`. It declares **58 identifiers** across eight registers — **six populated, two declared
empty** — **18 acceptance criteria**, and a **30-task** implementation backlog claiming **35 of 35** obligations.

**Should `PRD-016` be admitted to the documentation baseline at Rank 3 as the authoritative specification for
`BC-24` Audit Trail?**

Stage 7's gate is *"a row in [`DOCUMENTATION_BASELINE.md`](../DOCUMENTATION_BASELINE.md) §3 at an assigned
precedence rank."* Freeze here is **conferred, not claimed**. This ADR therefore exists **before** the baseline row
is written, per baseline §7 step 1.

---

## 2. Evidence — the artefacts, not the feelings

`PRD_LIFECYCLE.md` **L41–42**: *"Each transition has a **gate**: a named artefact that must exist. A gate is not an
opinion — if the artefact does not exist, the stage has not been passed, however complete the work feels."*

| Stage | Gate | Artefact | State |
|---|---|---|---|
| **1** — Discovery | a context in the BC Map, not already owned in `PRD_REGISTRY.md` §6 | `BC-24` at BC Map **L133**; registered to `PRD-016` at `PRD_REGISTRY.md` **L306**; **0** contested contexts (§7) | ✅ **PASSED** — [`PRD-016_STAGE1_DISCOVERY.md`](../../30-product/audit/PRD-016_STAGE1_DISCOVERY.md), 8 findings |
| **2** — Draft | version/status header + registers declared up front with ranges | `PRD-016_AUDIT_TRAIL.md` §0.2, eight registers, every populated range contiguous, **two declared empty rather than omitted** | ✅ **PASSED** |
| **3** — Architecture review | *"a written alignment record naming every conflict and its disposition"* | [`PRD-016_ARCHITECTURE_ALIGNMENT.md`](../../30-product/audit/PRD-016_ARCHITECTURE_ALIGNMENT.md), measured at `281f15e8…f339be` | ✅ **ALIGNED — 6 of 6**, nine candidate findings **rejected with evidence** (`AL-R1`…`AL-R9`) |
| **4** — Requirements review | conflicts closed or deferred **with a reason and an owner** | [`PRD-016_STAGE4_REQUIREMENTS_REVIEW.md`](../../30-product/audit/PRD-016_STAGE4_REQUIREMENTS_REVIEW.md), measured at `281f15e8…f339be` | ✅ **PASS — 6 of 6**, four findings rejected (`S4-R1`…`R4`), one instrument defect recorded (`S4-D-01`) |
| **5** — Traceability | prefixes registered in `TRACEABILITY_MATRIX.md` §2, verified mechanically | §2J (matrix **v1.14**); `prd016_traceability.py` + `prd016_stage5.py`, **two independent checkers**; **conferred** by [`PRD-016_STAGE5_CONFERRAL.md`](../../30-product/audit/PRD-016_STAGE5_CONFERRAL.md) | ✅ **exit 0**, both; 0 collisions in both directions |
| **6** — Implementation tasks | an `IMPL-*` range allocated, every task tracing back to requirements | [`PRD-016_IMPLEMENTATION_TASKS.md`](../../40-implementation/audit/PRD-016_IMPLEMENTATION_TASKS.md), `IMPL-900`…`929`; **record** [`PRD-016_STAGE6_IMPLEMENTATION_TASKS.md`](../../30-product/audit/PRD-016_STAGE6_IMPLEMENTATION_TASKS.md) | ✅ **A — PASS**, `G1`…`G8`, `prd016_task_coverage.py` **exit 0** |

**Every one of the five gate records measured the same bytes.** `PRD-016_AUDIT_TRAIL.md` is
`281f15e8de65dde8c8b5a5e8edda71f8e34eff07c7abc411698fbfc0f6f339be` now, and was that at Stage 3, Stage 4, Stage 5
and Stage 6. **No alignment supplement is required and none is written** — the circumstance that forced one for
`PRD-008` (`ADR-0049`) and `PRD-013` (`ADR-0050`), where a base record's verdict had gone stale against later
bytes, **does not arise here**. This is stated because the absence of a supplement in a freeze ADR is otherwise
indistinguishable from an omission.

### 2.1 Figures computed from the PRD, not copied from the reports

All three gates were re-executed at **exit 0** immediately before this ADR was written.

```
python3 tool/docs_check/prd016_traceability.py    → exit 0
python3 tool/docs_check/prd016_stage5.py          → exit 0
python3 tool/docs_check/prd016_task_coverage.py   → exit 0
```

| Property | Value |
|---|---|
| Registers | **8** — `AUD-FR` · `AUD-BR` · `AUD-INV` · `AUD-EVT` · `AUD-XC` · `AUD-CFG` · `AUD-AC` · `AUD-GAP` |
| Identifiers declared | **58** — FR 16 · BR 3 · INV 4 · **EVT 0** · XC 12 · **CFG 0** · AC 18 · GAP 5 |
| Identifiers retired | **0** — nothing was renumbered or withdrawn at any stage |
| Obligation-bearing (Class A) | **35** = 16 FR + 3 BR + 4 INV + 12 XC + 0 EVT |
| Ranges | every populated register contiguous from `001`; `AUD-FR-001`…`016`, `AUD-BR-001`…`003`, `AUD-INV-001`…`004`, `AUD-XC-001`…`012`, `AUD-AC-001`…`018`, `AUD-GAP-001`…`005` |
| Dangling references | **0** |
| Orphan criteria | **0** |
| Cross-module collisions | **0** in both directions |
| Acceptance coverage | **27 / 35 = 77.1%**; the **8** uncovered obligations are **named** in the PRD's own §9 reverse-coverage paragraph, not hidden |
| Implementation tasks | **30**, `IMPL-900`…`929`, three waves, **0** collisions with the **451** `IMPL-*` numbers already in the repository |
| Task → obligation coverage | **35 / 35 = 100.0%**, 0 cycles, 1 root (`IMPL-900`), 1 leaf (`IMPL-929`), critical path **7**, 47 edges |
| `AUD-EVT-*` | **Declared empty — 0 identifiers.** `BC-24` publishes **zero** events: it appears in BC Map §9 as a **consumer 25 times and a producer 0 times**. An empty register declared explicitly rather than omitted, following the `TEN-CFG-*` precedent (`ADR-0050` §2.1) |
| `AUD-CFG-*` | **Declared empty — 0 identifiers.** No Rank 1–7 authority supplies a default or a bounded range for any audit parameter; `CONFIGURATION_GUIDE.md` carries `CFG-1`…`CFG-12` and **none concerns audit**. §2.4 |

### 2.2 The version, and why it is **not** moved

**`PRD-016` is admitted at v0.1** — the **second** v0.x document admitted to this baseline, after `PRD-013`.

`ADR-0020` §4 item 2 is the operative rule: *"**The version is preserved at v1.0.** Freeze confers status; it does
not renumber. `PRD-003` was admitted at v1.0, `PRD-004` at v1.2 and `PRD-005` at v1.4 — **each at the version that
was verified.**"* `ADR-0020` §5 rejects the contrary option explicitly: *"Renumber to v1.1 to mark the freeze |
Stage 7 confers status, not content."*

**The verified version of `PRD-016` is v0.1.** All five gate records measured `281f15e8…f339be`, which is v0.1.

| Candidate | Rejected because |
|---|---|
| **Admit at v0.1** *(chosen)* | It is the version that was verified. `ADR-0020` §4 item 2, applied literally, and `ADR-0050` §2.2 has already applied it to a v0.x document |
| Renumber v0.1 → v1.0 to mark the freeze | The act `ADR-0020` §5 rejects. It would make the baseline cite a version string no gate measured |
| Refuse the freeze because v0.x is "not release-ready" | This was **`PRD-013`'s Stage 7 blocker 1, and it was withdrawn as an invented rule** (`ADR-0050` §5). Repeating it here would re-introduce a prohibition the repository has already rejected in writing |

### 2.3 Architectural conformance

`PRD-016` holds **context ownership of `BC-24`** and **aggregate ownership of `AuditEntry` only** — the two-rights
distinction `ADR-0013` §1.5 draws. It matches BC Map §8 **L384** exactly, which grants `BC-24` the aggregate
`AuditEntry` with the constraint *"Append-only, no update or delete path exists in code; entry carries the tenant
and actor of record; legal hold blocks purge."*

**It adds no integration edge.** `BC-24` consumes the existing `E-20` (BC Map **L329**, *"All contexts → BC-24, `PL`,
Event (fire-and-forget, outbox-backed)"*) and publishes nothing. **0** edges are invented — which matters here
because BC Map **L292** states *"If an edge is not in this table, it **does not exist** and adding it requires an
ADR"*, and this ADR adds none.

**The core invariant is upheld at the level the instruction required — impossibility, not absence.** `AUD-INV-*`
makes `AuditEntry` append-only, and the exclusion register states what must be **impossible** rather than merely
undone. `tool/module_dependencies.yaml` **L356–371** already enforces the mechanical half at rank 5:
`banned_method_names: ["update*","delete*","purge*","modify*"]`, `banned_imports: ["domain/**","app/**"]`,
assertions `AU-1`…`AU-4`. **That manifest is unchanged by this admission** — the PRD conforms to the rule that
already existed rather than the rule being widened to fit the PRD.

**Tenant isolation complies with the frozen `PRD-013` contract and does not restate it.** `X-13` (Matrix **L362**,
*"Cache/index/vector key without tenantId → Cross-tenant data leak — highest-severity failure class in the
system"*) and `ID-1` are **upheld and neither is waived** — `PRD_LIFECYCLE.md` §7: *"`X-13` and `ID-1` are never
waived under time pressure."* `MP-RSK-01` classes a cross-tenant leak **Critical**, and BC Map §9.1 **L440–450**
requires that *"tenantId is mandatory … must fail loudly, not default"*.

**The audit *principles* are cited, not restated.** `AU-1`…`AU-9` remain in the **frozen** Authentication PRD
§10.4 (**L4014–4028**), and `AUTH-10.26` (**L4050**) — *"Authentication MUST NOT own audit storage, retention or
query"* — is the authority by which `BC-24` owns them. `PRD-016` cites both rather than duplicating either, per
the instruction's *"cite existing authority instead of restating it."*

### 2.4 Two empty registers, and why emptiness is the correct content

This is the point on which this admission is most likely to be misread as incomplete, so it is stated plainly.

| Register | Why empty | Why the alternative would have been worse |
|---|---|---|
| `AUD-EVT-*` | `BC-24` is a **producer in zero** BC Map §9 rows and a consumer in **25**. Audit is a terminal sink | Inventing an event name would have created an integration edge BC Map **L292** says does not exist, and required an ADR to add. **`IMPL-919` instead makes the empty event surface enforceable** |
| `AUD-CFG-*` | **No Rank 1–7 authority supplies a retention period, a legal-hold trigger or any bound.** `MP-NFR-10` assigns retention and legal hold to **SECURITY + DATA Governance**; `Q-04` records *"Retention period … Open — needs counsel"*; `CONFIGURATION_GUIDE.md` has no audit row | A configurable with an invented default is *"a specification hole"* — and a retention period invented here would be a **legal** determination made by a document with no standing to make it. Recorded as **`AUD-GAP-001`**, which is what the quality gate requires: *"every configurable has a justified default and bounded range, otherwise keep the register empty"* |

Both are **declared** in §0.2 rather than omitted, following `TEN-CFG-*` (`ADR-0050` §2.1). A register that is
absent cannot be distinguished from a register that was forgotten; a register that is declared empty states a fact.

---

## 3. The three code findings — routed at the correct rank, and **not** fixed here

All three were found at Stage 6 while measuring `lib/platform/audit/audit.dart` (**64 lines**, commit **`a44ebb0`**,
authored **before** `PRD-016` existed). All three are recorded in the task document §4.1 and scheduled to Stage 8.

### 3.1 `D-016-01` — unconfined query surface

`AuditTrail.recent([int n = 25])` (**L60**) and `AuditTrail.count` (**L63**) read across the whole store with **no
tenant argument**. Under `X-13` and `MP-GBR-08`/`09` a read path without a tenant key is the highest-severity
failure class in the system. `forTenant()` (**L57**) is present and correct, which is the evidence that the
confinement discipline was understood and these two methods predate it.

**Routed to `IMPL-922`** — query confinement. **Not fixed here:** removing or re-signing a public method is a code
act, and `ADR-0020` §6.2 governs — *"Freeze authorises implementation to begin; it does not perform it."*

### 3.2 `D-016-02` — a silent epoch default for the audit timestamp

`append()` (**L51**) reads `at ?? DateTime.fromMillisecondsSinceEpoch(0)`. A missing timestamp becomes
**1970-01-01** rather than failing. BC Map §9.1 states the envelope's discipline for its mandatory fields — *"must
fail loudly, not default"* — and a defaulted audit timestamp is a fact recorded wrongly rather than not recorded.

**Routed to `IMPL-910`…`912`** — server-time recording. **Not fixed here**, for the same reason.

### 3.3 `D-016-03` — recording failure is silent

The module offers no path by which a failed append becomes a failure of the recorded action. This sits directly on
the tension `AUD-GAP-002` records between **`AUTH-10.27`** (**L4051**, *"Inability to record an audit fact MUST be
treated as a failure of the action for security-critical operations"*) and **`E-20`**'s fire-and-forget transport.

**Routed to `IMPL-913`. The tension is NOT resolved here, and that is deliberate.** `IMPL-913`/`914` are written so
that **the module's obligation is identical under either reading of `AUTH-10.27`** — so the gap does not block
implementation, and no reading is imposed on the two frozen documents whose owners must settle it.

### 3.4 Why three contradictions do not block the freeze

Because **the specification is not what they contradict.** Each is a defect in code that predates the PRD, measured
against the PRD, and scheduled by the PRD's own backlog. A freeze admits a *document* at a rank; it does not assert
that the code already complies. `ADR-0050` §3.3 established this for two such findings and the reasoning is
unchanged for three.

**`find test -iname '*audit*'` returns 0.** There is no test for this module, which is why §4 item 9 admits **0 of
18** acceptance criteria proven.

---

## 4. The decision

1. **`PRD-016_AUDIT_TRAIL.md` v0.1 is admitted to `DOCUMENTATION_BASELINE.md` §3.3 at Rank 3** as the authoritative
   specification for **`BC-24` Audit Trail**. The **tenth** Rank 3 module baseline.
2. **Stage 7 Freeze is CONFERRED.** `PRD_REGISTRY.md` status `PLANNED` → **`FROZEN`**. `PRD-016` is the **second**
   PRD to leave `PLANNED` directly for `FROZEN`, after `PRD-013`.
3. **Five validation records are admitted with it** — the Stage 1 discovery, the Stage 3 alignment, the Stage 4
   requirements review, the Stage 5 conferral and the Stage 6 record — as **validation records, not part of the
   specification**, on the `ADR-0049` §4 item 3 precedent. **The Stage 6 record confers nothing; the §3.3 row
   does.**
4. **The version is preserved at v0.1.** Freeze confers status, not content — §2.2.
5. **No requirement identifier is added, removed, renumbered or reworded.** All 58 identifiers, all 18 criteria,
   the two empty registers and the five gaps are **unchanged**. The PRD's **only** edits are its *Status*,
   *Baseline*, *Rank*, *Registry status* and *Reviewed at* metadata rows, its **§12 lifecycle-position table**, and
   one changelog entry — §4.1.
6. **No ranked document's content is amended.** `MASTER_PRD.md`, the BC Map, the Dependency Matrix,
   `ARCHITECTURE_RULINGS.md` and `CONFIGURATION_GUIDE.md` are untouched. **No integration edge is added.** No
   global business rule changes. No dependency law gains an exception. No bounded context is created — still **31**.
   **`tool/module_dependencies.yaml` is unchanged**, and no gate under `tool/` is modified.
7. **All five `AUD-GAP-*` are admitted OPEN and are not ratified.** `ADR-0020` §4 item 6. Each retains its named
   owner: `AUD-GAP-001` (retention period — SECURITY + DATA Governance, `MP-NFR-10`, `Q-04`), `002` (the
   `AUTH-10.27` / `E-20` reading — Architecture Owner jointly with the `BC-18` owner), `003` (legal-hold
   mechanism), `004` (support-access action list), `005` (`EVT-*` member names).
8. **The baseline identifier becomes `BASELINE-2026-08-19-B`**, because a Rank 3 document entered the baseline
   (baseline §7 step 4). It is the **first** identifier in this repository to advance by suffix within the same
   day, which is the mechanism §7 step 4 prescribes when the date does not move.
9. **`PRD-016` is `FROZEN`, not `VERIFIED`.** **0 of 30** tasks and **0 of 18** acceptance criteria are proven by a
   test; acceptance coverage is **77.1%**, not 100%. `SID-4.56`: *"A rule that cannot be checked SHALL be treated
   as unmet."*
10. **`PRD-016_IMPLEMENTATION_TASKS.md` is NOT admitted to the baseline.** It is a backlog record — unranked and
    editable without an ADR — exactly as `PRD-006`'s, `PRD-008`'s and `PRD-013`'s task documents are
    (`ADR-0049` §4 item 6).
11. **`BC-24` is the first CAPABILITY & GENERIC band context to hold a frozen product specification.** Measured,
    not assumed: of the eleven contexts in that band (BC Map **L259–267**), **none** is owned by any of the nine
    previously frozen PRDs.

### 4.1 Why §12 may be corrected, and by what authority

`PRD-016` §12 is a **Lifecycle position** table asserting *"Stage 3 — ⏳ Next"*, *"Stage 4 — ⏳"*, *"Stage 5 — ⏳"*,
*"Stage 6 — ⏳"*, *"Stage 7 — ⏳"*. All five statements are **false** against the artefacts in §2. Leaving them would
make the baseline contradict the repository at the moment of admission — and baseline §7 step 3 states the
standard: *"**A baseline that does not match the repository is worse than no baseline.**"*

The authority is `ADR-0050` §4.1, applied unchanged: `ADR-0020` §4 item 3 licenses editing freeze **metadata** and
one changelog entry, and §12 is derived lifecycle metadata of exactly that kind — the PRD's own header says
*"Lifecycle stage | See §12"* and *"This document confers no status on itself."* Correcting it applies the sentence
the document already contains. The `PRD_LIFECYCLE.md` Stage 7 post-freeze table classes a stale derived statement
as *"Clarifying wording, no meaning change → Changelog entry"*. **No business rule, requirement, exclusion,
invariant, criterion or identifier is touched.**

**Prior verdicts are quoted, not erased**, per the `PRD-019` §6 practice `ADR-0050` §4.1 records.

**What is deliberately *not* done to §12:** Stages 8 and 9 remain ⛔ **NOT STARTED**. This ADR does not begin
implementation, and a freeze record that quietly advanced them would claim work that has not happened.

---

## 5. What this admission does **not** rest on

Recorded because a freeze ADR that lists only its supports is not auditable.

| Not relied upon | Why it is absent |
|---|---|
| An alignment supplement | **Not needed.** All five gate records measured the same hash — §2. Writing one would fabricate a staleness that does not exist |
| A resolved `AUTH-10.27` / `E-20` reading | `AUD-GAP-002`, **OPEN**. The backlog is written to be correct under either reading, so the gap does not block — §3.3 |
| A retention period | `AUD-GAP-001`, **OPEN**. `MP-NFR-10` and `Q-04` place it with counsel and DATA Governance. **None is invented** — §2.4 |
| Any `AUD-CFG-*` or `AUD-EVT-*` identifier | Both registers are **declared empty**. Nothing was minted to make a register look populated |
| A test | **None exists.** `find test -iname '*audit*'` → 0. §4 item 9 |
| A repair of `audit.dart` | Three contradictions stand, scheduled to `IMPL-910`…`913` and `IMPL-922`. §3 |
| A correction to `PRD_LIFECYCLE.md`'s stale `IMPL-227`+ table | Rank 1. It requires an ADR **before** the change and this ADR does not make it. Disclosed in the task document §3.3 and left standing — the `ADR-0049` precedent |
| A repair of the four pre-existing exit-1 checkers | Pre-existing, unrelated, unmodified |

---

## 6. The authority basis, stated plainly

`PRD_LIFECYCLE.md` §6 **L282** assigns **Stage 7 and the baseline** to the **governance owner**. **L283** records
that *"Every PRD needs a named owner. **None has one**"* — `PGA-08`.

The authority exercised here is a **direct, explicit conferral by the human principal of this engagement**, quoted
verbatim:

> *"Repository ke existing governance, roadmap aur PRD lifecycle ko strictly follow karte hue PRD-016 Audit Trail
> (`BC-24`, aggregate `AuditEntry`, prefix `AUD-`) ko end-to-end develop karo… Sirf genuine blocker, owner
> decision, ADR requirement ya repository contradiction par rukna."*

And on the freeze specifically:

> *"Reach Stage 7 only if all lifecycle gates are genuinely satisfied. Freeze PRD-016 only through the repository's
> actual baseline/freeze mechanism; **never claim FROZEN merely by changing a status field**."*

**That instruction is the authority, and it is the only authority claimed.** Same form as `ADR-0033` §7.2,
`ADR-0034` §7.2, `ADR-0049` §6 and `ADR-0050` §6. **`PGA-08` is not cured** by this ADR; per `ADR-0033` §7.1,
*"A conferral for one act is not a standing licence."*

### 6.1 The conditions attached to the grant, and how each was tested

| Condition | How it was met |
|---|---|
| *"all lifecycle gates genuinely satisfied"* | Six gate artefacts exist and three scripts exit 0 — §2, measured immediately before this ADR |
| *"never claim FROZEN merely by changing a status field"* | The status change is **conferred by the §3.3 baseline row**, and the PRD's status row **cites this ADR** rather than asserting freeze. §11 |
| *"do not invent … retention periods, legal requirements, jurisdictions or security rules"* | `AUD-CFG-*` is **empty** and `AUD-GAP-001`/`003`/`004` are **OPEN**. §2.4, §5 |
| *"preserve rejected findings and explain why they were rejected"* | Nine at Stage 3 (`AL-R1`…`R9`), four at Stage 4 (`S4-R1`…`R4`), eleven mutations at Stage 6, and the `IMPL-900` occurrence-vs-occupancy reasoning — all retained in their records |
| *"stop only if it genuinely blocks the current stage"* | Five gaps and three code defects are open and **none blocks Stage 7**, because none is a defect in the specification being admitted. §3.4 |

**What was NOT asserted.** No ARB meeting was held, minuted or attended. No quorum, attendee list or sign-off date
is claimed. **No Product Owner act is asserted**, because none is required: the version is **preserved**, not
moved, so there is nothing for a content owner to release — the reasoning `ADR-0050` §5 established when it
withdrew the contrary blocker as invented.

---

## 7. What acceptance does **NOT** license

| Not licensed | Why |
|---|---|
| `FROZEN` does **not** mean `VERIFIED` | Stages 8–9. **0 of 30** tasks, **0 of 18** criteria proven. Coverage **77.1%**, with 8 obligations uncovered and named |
| Does **not** start Stage 8 | Freeze authorises implementation to *begin*. It does not begin it. **No file under `lib/`, `packages/` or `test/` is touched** |
| Does **not** fix `D-016-01`, `D-016-02` or `D-016-03` | §3. Routed to `IMPL-922`, `IMPL-910`…`912` and `IMPL-913` |
| Does **not** close any `AUD-GAP-*` | Five remain OPEN with named owners. `ADR-0020` §4 item 6 |
| Does **not** set a retention period, legal-hold trigger, jurisdiction or support-access action list | `AUD-GAP-001`/`003`/`004`. Each needs its named owner's ruling. **None is asserted** |
| Does **not** decide the `AUTH-10.27` / `E-20` reading | `AUD-GAP-002`. Both documents are **frozen**; neither is amended here, and the backlog is correct under either reading |
| Does **not** create an event | `AUD-EVT-*` stays **empty**. `BC-24` publishes nothing; BC Map **L292** would require an ADR to add an edge and this ADR adds none |
| Does **not** create a configurable | `AUD-CFG-*` stays **empty**. `CONFIGURATION_GUIDE.md` unchanged at Rank 7 |
| Does **not** cure `PGA-08` | No named individual owner is appointed. §6 |
| Does **not** modify any gate under `tool/` | No checker's `ALLOWED` list is widened; `tool/module_dependencies.yaml` is unchanged. All three `AUD-*` gates exit 0 **after** these edits |
| Does **not** correct `PRD_LIFECYCLE.md`'s stale `IMPL-227`+ table | Rank 1 needs an ADR before the change. Disclosed, not fixed — §5 |
| Does **not** repair `S3-A-01`, `S3-A-02`, `S3-A-03` or `S4-D-01` | Recorded in their own gate records; all outside this admission's scope |
| Does **not** promote any `PROPOSED` ADR | `ADR-0021`…`0031`, `0038`, `0041` all stay `PROPOSED`. Count **13**, unchanged |
| Does **not** fix the 9 `ADR-0012` boundary violations | `dart run tool/check_module_boundaries.dart` exits 1 — **pre-existing**, unrelated, clears with `TASK-D10` |
| Does **not** grant a standing licence | `ADR-0033` §7.1 |

---

## 8. Counts re-derived by measurement, not by incrementing

Baseline §4 Rank 2, `ADR-INDEX.md` L9 and `PRD_REGISTRY.md` §7 each carry a count this admission moves. **This
register has been measurably wrong about its own counts on several recorded occasions**, so none was incremented.

All 51 ADR files' own `Status` rows were classified on the **leading declared token**, stripping `**` **and**
backticks:

```
files 51 · ACCEPTED 38 · PROPOSED 13 · superseded 0 · deprecated 0   → sums to 51
```

**Only one number moves — accepted 37 → 38 — and `proposed` is deliberately unchanged at 13.** One event:
`ADR-0051` added `ACCEPTED`.

| Register | Before | After | Moved by |
|---|---|---|---|
| `ADR-INDEX.md` L9 | 37 accepted · 13 proposed · 50 files | **38 · 13 · 51** | this ADR |
| Baseline §4 Rank 2 | ends `ADR-0050` | ends **`ADR-0051`** | this ADR |
| Baseline §4 module-baseline count | *"nine module baselines"* | **ten** | the §3.3 row |
| `PRD_REGISTRY.md` §7 `FROZEN` | 9 | **10** | §4 item 2 |
| `PRD_REGISTRY.md` §7 `PLANNED` | 12 | **11** | `PRD-016` leaves the `PRD-014`…`018` run |
| `PRD_REGISTRY.md` §7 documents that exist | 13 files, **11** identities | **15 files, 13 identities** | `PRD-016_AUDIT_TRAIL.md` — **and `PRD-013_TENANCY.md`, which this row never recorded.** §8.1 |
| `PRD_REGISTRY.md` §7 missing V1 PRDs | 14 | **13** | one fewer unwritten V1 |

### 8.1 One pre-existing defect, found by testing this ADR's own claim — `GCP-18`

This section first read *"no pre-existing defect was found."* **That statement was written before it was tested,
and testing it falsified it.** The correction is recorded here rather than made silently, because a freeze ADR that
asserts a clean register without measuring one is worth less than no assertion.

`PRD_REGISTRY.md` §7 *Documents that exist* reads **"13 files, 11 PRD identities — `PRD-000`…`PRD-008`,
`PRD-019` and `PRD-022`."** Measured against disk:

```
identities with a specification document on disk : 13
  PRD-000 001 002 003 004 005 006 007 008 013 016 019 022
enumerated by the row                            : 11
missing from the enumeration                     : PRD-013, PRD-016
```

**`PRD-013_TENANCY.md` has been on disk and `FROZEN` since `ADR-0050`, and this row never recorded it.** The same
commit updated the row's `FROZEN` count 9 and its `PLANNED` count 12 for `PRD-013`, but not its existence
enumeration — so the register simultaneously states that `PRD-013` is frozen and that no `PRD-013` document exists.

This is the **`GCP-15`/`16`/`17` defect class exactly** — *"a derived statement left behind by a change to the thing
it describes"* — and it is now its **eighth recorded instance across five documents**. It is **logged as `GCP-18`**
(`GCP-14` is the highest previously issued number in `PRD_REGISTRY.md`'s own §4.3 and `GCP-17` the highest in the
baseline; **no number is reused**). It is corrected in this commit on the `ADR-0020` §3.6 precedent that *"leaving a
table wrong while adding a row to it would produce a worse record than either state alone."*

**It never misconferred a status.** `PRD-013`'s freeze rests on its `DOCUMENTATION_BASELINE.md` §3.3 row, which is
present and correct; only this derived count was stale.

**A disclosed limit on the file half of the correction.** The row states **no rule** for what it counts as one
"file" — `PRD-002` alone has four (`Library_PRD_v1.md` plus §14A, §14B and the Invitation Security Specification),
and 11 identities cannot be reconciled with 13 files under any single rule I can derive from the row itself. The
**identity** count is therefore re-derived by measurement (**13**), while the **file** count is advanced by
**increment** — 13 + 1 for `PRD-013_TENANCY.md` + 1 for `PRD-016_AUDIT_TRAIL.md` = **15**. That is a weaker
operation than measurement and it is labelled as such rather than presented as measured.

---

## 9. Options considered

| Option | Verdict |
|---|---|
| **Admit `PRD-016` v0.1 at Rank 3** *(chosen)* | Every gate has its artefact and every gate exits 0. The five open gaps are decisions owned elsewhere, not holes in the specification |
| Refuse until `AUD-GAP-001` (retention) is decided | **Rejected.** It would make a Rank 3 admission hostage to a legal determination `MP-NFR-10` assigns to counsel, and `ADR-0020` §4 item 6 has already settled that **open gaps do not bar admission** — `PRD-007` was admitted with 14 |
| Refuse until acceptance coverage reaches 100% | **Rejected.** `PRD-007` was admitted at **73.4%** and `PRD-013` at a coverage no test proves at all. 77.1% is disclosed in the row, and the 8 uncovered obligations are **named** |
| Populate `AUD-CFG-*` with a defensible default | **Rejected as invention.** §2.4. The instruction forbids it and the quality gate prescribes the empty register instead |
| Renumber to v1.0 | **Rejected.** `ADR-0020` §5; §2.2 |
| Fix the three code defects first | **Rejected.** Stage 8 work. `ADR-0020` §6.2 |

---

## 10. Consequences

### 10.1 Immediate

1. `BC-24` has an authoritative specification at Rank 3. Any other document contradicting it on audit ownership,
   append-only semantics or audit query confinement is **wrong**, not merely different.
2. **`BC-24` is settled as a terminal sink.** It publishes no events, and a future proposal that it should must go
   through BC Map §7 and an ADR.
3. `IMPL-900`…`929` is the sanctioned backlog. `IMPL-930`…`999` is `PRD-016`'s growth reserve; `IMPL-1000`+ remains
   unallocated.
4. `AUTH-10.26` now has a counterpart: the module it points at exists as a specification.

### 10.2 What does **not** change

`MASTER_PRD.md`, BC Map, Dependency Matrix, `ARCHITECTURE_RULINGS.md`, `CONFIGURATION_GUIDE.md`,
`tool/module_dependencies.yaml`, every `tool/docs_check` script, and every file under `lib/`, `packages/` and
`test/`.

### 10.3 Carried forward

Five `AUD-GAP-*`; three code defects; `PGA-08`; `S3-A-01`…`03`; `S4-D-01`; `GCP-14`; the stale `IMPL-227`+ table;
the four exit-1 checkers; and every inherited item `ADR-0050` carried.

---

## 11. Compliance

| Requirement | Where satisfied |
|---|---|
| Baseline §7 step 1 — ADR **before** the change | This document, written before any ranked document was touched |
| Baseline §7 step 2 — version + changelog in the same commit | `PRD-016` v0.1 **preserved**; changelog entry added in the same commit |
| Baseline §7 step 3 — declaration updated in the same commit | `DOCUMENTATION_BASELINE.md` header, §3.3, §4, §8 |
| Baseline §7 step 4 — identifier changes on a Rank 1–3 change | `BASELINE-2026-08-19-A` → **`BASELINE-2026-08-19-B`** |
| `PRD_LIFECYCLE.md` Stage 7 — a row in §3 at an assigned rank | `DOCUMENTATION_BASELINE.md` §3.3, Rank 3 in §4 |
| `PRD_LIFECYCLE.md` Stage 7 — *"conferred, not claimed"* | §4 item 1. The PRD's status row cites this ADR |
| `PRD_REGISTRY.md` §2.1 — status conferred, never self-declared | Conferred here |
| `ADR-0020` §4 item 2 — admit at the verified version | v0.1 preserved. §2.2 |
| `ADR-0020` §4 item 3 — only freeze metadata edited | §4 item 5; §4.1 states the §12 authority explicitly |
| `ADR-0020` §4 item 6 — gaps are not ratified by admission | §4 item 7. Five OPEN with named owners |
| `X-13` / `ID-1` never waived | §2.3. Neither waived |
| `SID-4.56` — unchecked rules are unmet | §4 item 9 admits **0 of 18** criteria and **0 of 30** tasks proven |
| Stage 8 not entered | §7. `git status --short lib/ packages/ test/` returns **0 lines** |

---

## 12. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-19 | Created and **Accepted**. Admits `PRD-016_AUDIT_TRAIL.md` **v0.1** to Rank 3 as the authoritative specification for `BC-24` Audit Trail — the **tenth** module baseline and the **first CAPABILITY & GENERIC band** context frozen (measured against all nine prior freezes, §4 item 11). **The second v0.x document admitted**, at the version that was verified, per `ADR-0020` §4 item 2 and the `ADR-0050` §2.2 precedent. **No alignment supplement was written, and §2 records why**: all five gate records measured the same hash `281f15e8…f339be`, so the staleness that forced supplements for `PRD-008` and `PRD-013` does not arise. **Two registers are admitted DELIBERATELY EMPTY** — `AUD-EVT-*` because `BC-24` produces nothing, `AUD-CFG-*` because no authority supplies a bound, and §2.4 records why populating either would have been invention rather than completeness. Routes `D-016-01`, `D-016-02` and `D-016-03` as **code** defects against a correct specification (§3), including a query surface with no tenant argument and a silent epoch default for the audit timestamp. Admits **five `AUD-GAP-*` OPEN**, and explicitly **does not decide** the retention period, the legal-hold mechanism, the support-access action list or the `AUTH-10.27` / `E-20` tension — the backlog is written to be correct under either reading of the last. Counts re-derived by classifying all **51** files' own `Status` rows — **51 / 38 / 13 / 0** — not by incrementing (§8). ⚠ **§8 originally claimed no pre-existing defect was found; testing that claim falsified it**, and the correction is recorded rather than made silently: `PRD_REGISTRY.md` §7's document-existence enumeration **never recorded `PRD-013`** despite counting it as `FROZEN` in the adjacent row — the eighth instance of the `GCP-15`/`16`/`17` defect class, logged as **`GCP-18`** and corrected here (§8.1), with the file half of the count labelled as **incremented rather than measured** because the row states no rule for what it counts as one file. Written **before** any ranked document was touched, per baseline §7 step 1 |
