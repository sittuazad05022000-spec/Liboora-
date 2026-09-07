# `PRD-007` Stage 7 Freeze Record

| Field | Value |
|---|---|
| **Document** | `PRD-007` Stage 7 gate record — Freeze |
| **Subject** | [`PRD-SEAT-MANAGEMENT.md`](PRD-SEAT-MANAGEMENT.md) **v1.0** |
| **Baseline** | `7602890299c887f23f52534d3161e56d42a8faaa` (Stage 6, verdict A) |
| **Subject hash on entry** | `05dc6fb2fccfd7296d52960e86899e73ad08090ea77cea908dcee3fd38f7b943` |
| **Gate** | A row in [`DOCUMENTATION_BASELINE.md`](../../00-governance/DOCUMENTATION_BASELINE.md) §3 at an assigned precedence rank |
| **Gate satisfied by** | §3.3 row, **Rank 3**, conferred by [`ADR-0020`](../../00-governance/adr/ADR-0020-seat-management-prd-v1.0-baseline.md) under **`BASELINE-2026-08-04-E`** |
| **Findings** | **0 CRITICAL · 0 HIGH · 0 MEDIUM · 0 LOW** against the Stage 7 gate |
| **Pre-existing defects corrected and logged** | 2 — `GCP-07`, `GCP-08` |
| **New defect found, disclosed, deliberately unfixed** | 1 — **`GCP-09`**, ten mis-targeted citations (§8A) |
| **Verdict** | **A — PASS. `PRD-007` is `FROZEN`.** |
| **Stage** | 7 of 9. Stage 8 **not** entered. **0 of 100 tasks and 0 of 226 acceptance criteria are proven.** |
| **Authority** | **Navigational and evidential only.** This record documents that the gate was met. It confers nothing — the baseline row does |
| **Date** | 2026-08-04 |

---

## 1. Verdict

**A — PASS.** `PRD-007` Seat Management is **`FROZEN`** at **v1.0**.

Stage 7's gate is satisfied: `PRD-SEAT-MANAGEMENT.md` v1.0 holds a row in `DOCUMENTATION_BASELINE.md` §3.3 at
**Rank 3**, admitted by `ADR-0020` under `BASELINE-2026-08-04-E`.

**This record does not freeze anything.** It records that the freeze happened elsewhere. If this file were deleted,
`PRD-007` would still be frozen; if the baseline row were deleted, no wording here would keep it frozen.

**`FROZEN` is not `VERIFIED`.** Stage 9 requires implementation evidence that does not exist. Nothing in this record
claims `BC-04` Seating works.

---

## 2. What Stage 7 actually requires

Quoted verbatim from [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) §Stage 7:

> ### Stage 7 — Freeze
>
> **The gate that matters most, because it changes what everyone else may do.**
>
> **Gate:** a row in `DOCUMENTATION_BASELINE.md` §3 at an assigned precedence rank.
>
> Freeze is **conferred, not claimed**. No PRD in this repository declares itself frozen — verified: four of the
> five contain no occurrence of the word at all. The operative rule is baseline §7:
>
> > *"A change to any Rank 1–5 document requires an ADR **before** the change."*

Two consequences shaped the whole of this stage, and both are worth stating because the obvious reading of "freeze
the PRD" gets them backwards:

1. **The deliverable is a baseline row and an ADR, not a string in the PRD.** Writing `Status: FROZEN` into
   `PRD-SEAT-MANAGEMENT.md` and stopping would have *claimed* freeze while conferring none. `ADR-0020` §5 records
   that option and rejects it for exactly that reason.
2. **The ADR comes first.** Baseline §7 step 1 requires *an ADR before the change*, and the baseline is itself a
   Rank 1 document. So `ADR-0020` was written, reviewed and accepted **before** a single ranked byte moved.

The order actually executed was: gates re-verified → `ADR-0020` written → baseline amended → ADR index amended →
PRD metadata amended → registry amended → this record → developer documentation.

---

## 3. Entry conditions — every prior gate re-verified, not assumed

A freeze that trusts a stale PASS is a freeze of unknown material. All three prior gate records were re-read and
both mechanical gates were **re-run at exit 0 immediately before `ADR-0020` was written**.

| Stage | Record | Verdict | Re-verified at freeze |
|---|---|---|---|
| 4 — Requirements Review | [`PRD-007_STAGE4_FINAL_REVIEW.md`](PRD-007_STAGE4_FINAL_REVIEW.md) | **A — PASS**, 0/0/0/0 | Read; eight rejected candidate findings confirmed rejected with evidence |
| 5 — Traceability | [`PRD-007_STAGE5_TRACEABILITY.md`](PRD-007_STAGE5_TRACEABILITY.md) | **A — PASS** | `tool/docs_check/prd007_traceability.py` → **exit 0** |
| 6 — Implementation Tasks | [`PRD-007_STAGE6_IMPLEMENTATION_TASKS.md`](PRD-007_STAGE6_IMPLEMENTATION_TASKS.md) | **A — PASS**, 0/0/0/0 | `tool/docs_check/prd007_task_coverage.py` → **exit 0** |

### 3.1 Figures recomputed from source at freeze

| Measure | Value |
|---|---|
| `SEAT-FR` · `SEAT-BR` · `SEAT-INV` · `SEAT-EVT` | 304 · 45 · 14 · 4 |
| `SEAT-XC` · `SEAT-PO` · `SEAT-CFG` · `SEAT-NFR` | 22 · 24 · 18 · 12 |
| `SEAT-AC` · `SEAT-GAP` | **226** · 14 |
| **Total identifiers** | **683** |
| Obligation-bearing | 669 |
| **Criterion-verifiable obligations** | **443** (683 − 226 AC − 14 GAP) |
| Dangling references · orphan criteria · cross-register collisions | **0 · 0 · 0** |
| `SEAT-FR-302` mandated register coverage | **85 / 85 = 100.0%** |
| Overall AC coverage of obligations | **325 / 443 = 73.4%** |
| Implementation tasks | **100**, `IMPL-500` … `IMPL-599`, ten waves |
| Task coverage of obligations | **443 / 443 = 100.0%** |
| Task graph | 0 cycles · 1 root (`IMPL-500`) · 1 leaf (`IMPL-599`) · critical path 18 |

**The 73.4% is reported, not rounded up.** 118 obligations carry no acceptance criterion — 86 `SEAT-FR`, 5
`SEAT-NFR`, 18 `SEAT-PO`, 9 `SEAT-CFG`. `SEAT-FR-302` mandates criteria for four registers and those four are at
100.0%; the shortfall is entirely outside what the PRD requires to be covered. It is named in `ADR-0020` §2.5 and
carried forward rather than hidden, because `SEAT-NFR-011` — quoting `SID-4.56` — holds that *a rule that cannot be
checked SHALL be treated as unmet*, and a coverage figure that flattered itself would be the first thing to
violate it.

---

## 4. The gate row

`DOCUMENTATION_BASELINE.md` §3.3 now carries, at **Rank 3**:

> `PRD-SEAT-MANAGEMENT.md` **v1.0** — *Authoritative — the Seat Management baseline for `BC-04` Seating, 36
> chapters*

with four supporting rows in §3.3 (module README, Stage 4 record, the Stage 5/6/7 gate records, nine review and
correction reports) and two in §3.4 (the implementation backlog and the developer guide, both explicitly
**non-authoritative**).

§4 confers the precedence rank, where Rank 3 now holds **six** module baselines. The `PRD-007` row reads: *Seat
Management PRD v1.0 → `BC-04`*.

**That is the entire gate.** Everything else in this stage exists to make the row true, traceable, or navigable.

---

## 5. What changed in `PRD-007` — and the arithmetic proving it is only metadata

Baseline §7's post-freeze table permits *nothing* for a typo and *a changelog entry* for clarifying wording. The
edits to the PRD at freeze are narrower than either: **four lifecycle metadata rows in the header table, plus one
new changelog section.**

| Row | From | To |
|---|---|---|
| **Status** | **`DRAFT`** — Stage 2, *"not frozen"* | **`FROZEN`** — Stage 7, admitted by `ADR-0020`; **frozen, not `VERIFIED`** |
| **Baseline** | Written against `BASELINE-2026-08-04-D` | …; **admitted to `BASELINE-2026-08-04-E`** |
| **Rank** | Rank 3 — *"claimed on freeze, not now"* | **Rank 3** — conferred by baseline §3.3 and §4, **not claimed here** |
| **Authorities applied** | `ADR-0011`, `ADR-0016` | `ADR-0011`, `ADR-0016`, **`ADR-0020`** |

Plus **§37 Document change history** — a new section, not an edit to an existing one.

### 5.1 Why §37 and not §35

§35 is *"Change log against the source draft"*: it records what changed **while the document was being written**.
A freeze is a change **to the issued document**. Appending the freeze to §35 would have merged two different
histories under one heading and quietly redefined a section a reader may already have cited. §37 opens by naming
the distinction explicitly.

### 5.2 Verified mechanically

`git diff` on the PRD reports **15 insertions, 4 deletions** across two hunks: the header table and the appended
§37. Line-by-line:

- **0** requirements, business rules, invariants, events, exclusions, protected operations, configurables or NFRs
  added, removed, renumbered or reworded.
- **0** acceptance criteria touched — still 226.
- **0** identifiers touched — still 683 across ten registers, re-verified at exit 0.
- **0** gaps touched — all 14 still OPEN.
- **0** scope statements, chapter numbers or §33.x AC groupings touched.
- **Version preserved at v1.0.**

### 5.3 Why the version is not incremented

Freeze **confers status, not content**. `PRD-003` was admitted at v1.0, `PRD-004` at v1.2, `PRD-005` at v1.4 —
each at the version that was verified. Renumbering `PRD-007` to some ceremonial v2.0 would assert that the frozen
text differs from the reviewed text, which is precisely what §5.2 disproves.

### 5.4 Why the Status row cites an ADR instead of asserting freeze

[`PRD_REGISTRY.md`](../../00-governance/prd-ecosystem/PRD_REGISTRY.md) §2.1 is blunt about this: *the obvious
implementation of a registry — grep each PRD for its own status — would have marked all five specifications **not**
frozen and been wrong about every one of them.* Status is conferred externally. So the row **cites `ADR-0020`**
rather than declaring freeze on the document's own authority, following PRD-005's line 8 exactly.

---

## 6. Documents changed at freeze, and documents deliberately not changed

### 6.1 Changed

| Document | Change | Why permitted |
|---|---|---|
| `ADR-0020-…-baseline.md` | **Created** | The ADR that Baseline §7 step 1 requires *before* the change |
| `DOCUMENTATION_BASELINE.md` | Header → `-E`; §3.1, §3.3, §3.4, §4, §6, §8 | **The gate itself**, plus §7 steps 2–4 |
| `ADR-INDEX.md` | Count → 20; `ADR-0020` row; change history | Index of record for ADRs |
| `PRD-SEAT-MANAGEMENT.md` | 4 metadata rows + §37 | Governance-required lifecycle metadata only (§5) |
| `PRD_REGISTRY.md` | `PRD-007` → `FROZEN`; §7 counts; → v1.7; §4.1 prose | Maintenance rule 3: *updated in the same commit as the change it records* |
| `PRD-007_STAGE7_FREEZE.md` | **Created** — this file | Declared in baseline §3.3 |
| `seat-management/README.md` | **Created** | Declared in baseline §3.3 |
| `PRD-007_DEVELOPER_GUIDE.md` | **Created** | Declared in baseline §3.4 |
| `tool/docs_check/prd007_traceability.py` | `ALLOWED` list widened by four **named files** | Gate maintenance, not gate weakening — §6.4 |

### 6.2 Deliberately not changed

| Document | Status |
|---|---|
| [`PRD-007_IMPLEMENTATION_TASKS.md`](../../40-implementation/seat-management/PRD-007_IMPLEMENTATION_TASKS.md) | **Byte-identical** — `e2a47d3d…` |
| [`TRACEABILITY_MATRIX.md`](../../40-implementation/TRACEABILITY_MATRIX.md) | **Byte-identical** — `bc7fd9e7…` |
| [`MASTER_PRD.md`](../MASTER_PRD.md) | **Byte-identical** — `5c31a336…` |
| `PRD_LIFECYCLE.md`, Bounded Context Map, Module Dependency Matrix, `ARCHITECTURE_RULINGS.md` | Untouched |
| All Stage 4/5/6 records, all other PRDs, all other ADRs | Untouched |
| `lib/`, `test/`, `pubspec.yaml` | Untouched — **no code was written**, no schema, no API, no migration |
| `tool/` | One gate script maintained (§6.4); no other file touched |

Stage 7's gate is a baseline row, so amending the matrix or the backlog would have been *optional tidying of
independently verified bytes* — and the `ADR-0018` §3.4 / `ADR-0019` §3.6 precedent is that verified bytes are
preserved rather than tidied. Three stale `IMPL-227+` allocation tables are recorded in `ADR-0020` §3.4 for a
post-freeze clarifying pass, which baseline §7 permits with a changelog entry and no ADR.

### 6.3 No edge, no context, no rule

**No integration edge was added.** `BC-04` consumes seven pre-declared inbound edges — `E-01`, `E-02`, `E-05`,
`E-08`, `E-17`, `E-18`, `E-19` — and publishes on three outbound — `E-20` (audit, fire-and-forget), `E-23`
(notification facts), capacity alerting. Every one already exists in BC Map §7, whose line 292 holds that an edge
absent from that table *does not exist*. **The bounded-context count remains 31.** No global business rule changed
and no dependency law gained an exception.

### 6.4 The one tooling change, and why it is not a weakened gate

Writing the four governance documents above turned the **Stage 5 gate red**, on my own new files:

```
FAIL — 2 problem(s):
  * SEAT-* identifier(s) found outside the module and outside the registry:
      ADR-INDEX.md:54, ADR-INDEX.md:96, ADR-0020-…-baseline.md:13, …
```

The gate's collision scan allowed `SEAT-*` citations only under `seat-management/` and in
`TRACEABILITY_MATRIX.md`. That list was written at Stage 5, **before** a freeze had ever cited this register from
the governance layer — so the red was a gap in the gate's model of legitimate citation sites, not a defect in the
documents.

The tempting move was to add the exemption and continue. I checked the precedent first, and it decides the
question: **`tool/docs_check/prd005_traceability.py` L245–252 already enumerates the identical four files** for
`MM-*`, with a rationale stating that *"the freeze ADR states which gaps stay open, the baseline declares what
entered Rank 3, the registry records the status change and the ADR index summarises it"*, and that *"a citation is
not a collision."* `ADR-0018` established the same for `SM-*`. Measured: `ADR-0020` cites `SEAT-*` legitimately,
exactly as `ADR-0019` cites `MM-*` **80 times** and `DOCUMENTATION_BASELINE.md` **18 times**.

So this change **follows an existing convention that my Stage 5 script predates**, rather than inventing an
exemption for convenience. Three properties were preserved deliberately:

1. **Enumerated file by file, never a directory** — copied verbatim from the PRD-005 rationale, so a stray
   `SEAT-` in *any other* governance document still fails the run.
2. **The collision check itself is untouched.** A collision is another register *defining* a `SEAT-` identifier;
   the duplicate-definition, registered-prefix and form checks that catch it are unchanged.
3. **`tool/`, `lib/`, `test/` scanning is unchanged** — a `SEAT-*` identifier appearing in source still fails.

This is materially different from the Stage 6 situation, where a similar leak was **avoidable** and I reworded my
own comments rather than widen the gate. Here the citations are required by governance and cannot be removed
without making the freeze unrecordable.

---

## 7. Open items — admitted open, not ratified

**Admission ratifies nothing that was open.** Fourteen `SEAT-GAP-*` decisions remain OPEN and are recorded
individually in `ADR-0020` §3.1.

- **`SEAT-BR-045`** forbids resolving any gap **by implementation choice**. The Stage 6 backlog therefore assigns
  the gaps **no task**, and names six tempting tasks that must not be created for exactly that reason.
- **§0.3** holds that `SEAT-GAP-*` *"are questions, not requirements, and must never be cited as verifiable."*
- Each gap requires a decision from its named owner, and — now that the PRD is frozen — **an ADR before the
  change** if the answer alters a business rule.

**`SEAT-GAP-009` is structural and deserves naming here.** `BC-04` derives occupancy from `BC-03` Attendance over
`E-08`, and **`PRD-006` Attendance is still `PLANNED`**. A seating module built today would hold allocations
correctly and derive **no live occupancy**. That is a scheduling fact, not a specification defect —
`SEAT-FR-108`…`117` specify the boundary as a port — but it makes `PRD-007` the first frozen PRD in this
repository whose own dependency is unwritten, and `PRD_REGISTRY.md` §7 now says so rather than reporting a tidy
contiguous run of `PLANNED` identifiers.

Inherited items unchanged: `BLK-01` / `TASK-D10` (`ADR-0012`, expiry 2026-10-31) · `IMPL-020` · `IMPL-220` ·
`MM-GAP-010` · `GCP-05` · `GCP-06`.

---

## 8. Two pre-existing governance defects, corrected and logged

Adding a row to a table requires reading it. Both tables were **already wrong before `PRD-007` touched them**.

| Logged as | Document | What was wrong | Disposition |
|---|---|---|---|
| **`GCP-07`** | `DOCUMENTATION_BASELINE.md` §4 | Held **four** Rank 3 module baselines and said *"four"*, though `ADR-0019` admitted `PRD-005` at Rank 3 under `-D`; Rank 2 still read *"`ADR-0001` … `ADR-0017`"* after `ADR-0018`/`ADR-0019` | **CLOSED by correction**; §4 now lists **six** |
| **`GCP-08`** | `PRD_REGISTRY.md` §4.1 | Prose read *"**None was ever written.** All nine are `PLANNED`"* directly above a table showing `PRD-004` and `PRD-005` **`FROZEN`** | **CLOSED by correction** |

Both are **logged rather than absorbed.** Silently adding two rows would have made this freeze appear to add one
row when it repaired two omissions — and it would have destroyed the evidence that the same failure has now
occurred three times.

**They are one defect class**, with `GCP-01`: *a derived statement left behind by a change to the thing it
describes.* `GCP-01` was a version number, `GCP-07` an index table, `GCP-08` a sentence above a table. Three
instances in three documents is an argument for **a mechanical check**, not for more diligence, and both entries
say so.

**Neither ever misconferred a status.** `PRD-005`'s Rank 3 authority came from baseline §3.3 and the `ADR-0019`
acceptance, and the registry's operative record is its table — correct throughout. `PRD_REGISTRY.md` §Precedence
already provides for this: *"Where this register disagrees with a PRD, the PRD is right and this register is a
defect."*

---

## 8A. `GCP-09` — ten mis-targeted citations, found after the gates passed

Authoring the developer guide meant following the §8 acquisition-gate table's *Authority* column rule by rule rather
than reading it as a list. **Ten citations name a rule that exists but governs something else.**

| Location | Cites | What that identifier actually defines | Intended target |
|---|---|---|---|
| §8 gate table **G11** *Not in maintenance* | `SEAT-BR-020` | this module MUST NOT own attendance records | `SEAT-FR-043` / `SEAT-BR-026` |
| §8 gate table **G12** *Not locked* | `SEAT-BR-018` | booking mode is a single tenant value | `SEAT-BR-025` |
| §8 gate table **G15** *No conflicting reservation* | `SEAT-BR-011` | one active **allocation** per seat | `SEAT-INV-004` / `SEAT-FR-042` |
| §6.4 invalid transitions — 3 rows | `SEAT-BR-020`, `SEAT-BR-018` | as above | `SEAT-FR-043` / `SEAT-BR-027` / `SEAT-BR-025` |
| 4 parentheticals (§6.3, §6.4, §16.1) | `SEAT-BR-020`, `SEAT-BR-022` | attendance; flexible-shift sharing | `SEAT-BR-026` |

**Root cause.** `SEAT-BR-018`, `SEAT-BR-020` and `SEAT-BR-022` were renumbered during a Stage 4 correction pass.
The prose definitions moved; the pointer columns did not.

**Six further candidates were examined and rejected.** The same three identifiers are cited **correctly** in the
attendance rows (`SEAT-AC-106`), the flexible-seat rows (`SEAT-AC-085`/`086`) and `SEAT-AC-212` for booking mode —
which is precisely what makes the drift hard to see, and why a blanket search-and-replace would have introduced
six new defects while fixing ten.

**No behavioural ambiguity, and no requirement is wrong.** Each gate's required behaviour is stated in its own
*Gate* and *Failure reason* columns and restated normatively in the owning chapter — lock suppression in §19
(`SEAT-BR-025`), maintenance in §19 (`SEAT-BR-026`/`SEAT-BR-027`), reservation uniqueness in §7 (`SEAT-INV-004`).
A developer following a bad pointer lands on a **real but irrelevant** rule: confusion, not divergent behaviour.

### 8A.1 Why five gates missed it — the more useful finding

| Gate | What it proves | Why it passes anyway |
|---|---|---|
| Stage 5 traceability | every cited identifier **exists** | all ten exist — **0 dangling**, exit 0 |
| Stage 6 task coverage | every obligation is **claimed** by a task | unaffected — **443/443**, exit 0 |
| Stage 4 review | reasoning, consistency, completeness | reads the table as a list of true statements, which each row **is** |

**No script in this repository compares a citation's meaning to the cited rule's text.** So a document can be
mechanically spotless and still send a reader to the wrong rule ten times. This is recorded as a stated limitation
of the gates, not as a reason to doubt the figures they do verify.

### 8A.2 Why it is disclosed and not fixed

`PRD_LIFECYCLE.md` Stage 7 is explicit, and it anticipated exactly this temptation:

> **A frozen PRD is never silently modified.** Not for an obvious correction, and not for one that is certainly
> right — `PGA-01` and `PGA-02` are two confirmed defects in frozen documents left unfixed for exactly this
> reason. If a silent edit is acceptable when the editor is confident, the freeze protects nothing, because every
> editor is confident.

I am confident about all ten. That is the argument **for** leaving them, not against. The correct route is a
**clarifying-wording pass** under baseline §7 — changelog entry, **no** ADR, **no** version increment, no
business-rule change — owned by the `BC-04` specification owner. Logged as **`GCP-09`** in
[`DOCUMENTATION_BASELINE.md`](../../00-governance/DOCUMENTATION_BASELINE.md) §6 and
[`ADR-0020`](../../00-governance/adr/ADR-0020-seat-management-prd-v1.0-baseline.md) §3.7.

**The freeze verdict stands.** Stage 7's gate is a baseline row at an assigned rank; `GCP-09` does not bear on
whether that row is correctly placed. It is carried as a known defect, exactly as `PGA-01` and `PGA-02` are.
[`PRD-007_DEVELOPER_GUIDE.md`](../../40-implementation/seat-management/PRD-007_DEVELOPER_GUIDE.md) warns developers
about it directly, so nobody follows a bad pointer unwarned.

---

## 9. Link verification

Every relative link in the four documents created or amended at freeze was resolved against the filesystem and its
target confirmed to exist. Result: **0 broken links.** Method and per-link results are recorded in
[`README.md`](README.md) and re-executed as the final check before commit.

---

## 10. What this verdict does **not** authorise

| Not authorised | Why |
|---|---|
| Writing code | Stage 8 has its own gate — six pipeline checks, two of which block merge |
| Treating any AC as satisfied | 0 of 226 are proven by a test |
| Treating any task as done | 0 of 100 are started |
| Resolving a `SEAT-GAP-*` in code | `SEAT-BR-045` forbids it |
| Editing `PRD-007` | Business-rule change ⇒ **ADR → version → changelog → baseline**, in that order |
| Fixing the ten `GCP-09` citations *now* | A frozen PRD is never silently modified — needs a clarifying pass with a changelog entry (§8A.2) |
| Claiming `BC-04` works | `SID-4.56`: a rule that cannot be checked is **unmet** |

---

## 11. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-04 | Stage 7 gate record created. Verdict **A — PASS**; `PRD-007` **`FROZEN`** at v1.0 by a Rank 3 row in `DOCUMENTATION_BASELINE.md` §3.3, conferred by `ADR-0020` under `BASELINE-2026-08-04-E`. Entry conditions re-verified rather than assumed: Stage 4 record re-read, Stage 5 and Stage 6 gates **re-run at exit 0**, and all figures — **683** identifiers, **226** AC, **443/443** task coverage, **85/85** mandated AC coverage, **325/443 = 73.4%** overall — recomputed from source. PRD edits confined to **four header metadata rows plus a new §37**, proven by `git diff` at 15 insertions / 4 deletions with **0** requirements, criteria, identifiers or gaps touched and the version preserved at v1.0. `TRACEABILITY_MATRIX.md`, `PRD-007_IMPLEMENTATION_TASKS.md` and `MASTER_PRD.md` deliberately left byte-identical. **No edge added, no context created (still 31), no code written.** All fourteen `SEAT-GAP-*` admitted **OPEN**, including the structural `SEAT-GAP-009` dependency on the still-`PLANNED` `PRD-006`. Two pre-existing governance defects — `GCP-07` and `GCP-08` — corrected in the same commit and **logged as one defect class with `GCP-01`** rather than absorbed. **One new defect was opened rather than closed**: **`GCP-09`**, ten mis-targeted citations found while authoring the developer guide *after* every gate had passed — six further candidates examined and rejected — **disclosed and deliberately left unfixed** on the Stage 7 rule that a frozen PRD is never silently modified, and admitted as a stated limitation of the gates themselves (§8A). |
