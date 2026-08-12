# `PRD-006` Attendance Management — Stage 4 Findings Correction Record (`RQ-1` … `RQ-8`)

| Field | Value |
|---|---|
| **Document type** | Correction record — **validation artefact, not part of the specification** |
| **Subject** | [`PRD-006_ATTENDANCE-MANAGEMENT.md`](PRD-006_ATTENDANCE-MANAGEMENT.md) — v1.2 `DRAFT` → **v1.3 `DRAFT`** |
| **Authorising review** | [`PRD-006_REQUIREMENTS_REVIEW.md`](PRD-006_REQUIREMENTS_REVIEW.md) — Stage 4, verdict **⚠️ CONDITIONALLY PASSED** (1 HIGH · 3 MEDIUM · 4 LOW · 5 rejected) |
| **Scope** | `RQ-1` … `RQ-8`, and only where correctable **inside** `PRD-006` |
| **Date** | 2026-08-12 |
| **Corrected at** | `95b1eb9` (review commit) |
| **PRD hash before** | `600c59ecbbc9f92c28f36d98ebc01a8d7339c51e04b28990a5cd152bdd19980a` |
| **PRD hash after** | `93ab1c60d740c4e0fe8c82828556491a3f43d77ed47cb7e2b43ef106464ab97b` |
| **Diff size** | **134 insertions, 28 deletions, 1 file** |
| **Line count** | 2260 → 2366 (+106) |
| **Registers** | **Changed by addition only** — `ATT-FR` 148 → **151**, `ATT-BR` 42 → **45**, `ATT-AC` 209 → **213**. Total 506 → **516**, obligation-bearing 279 → **285**. **Nothing renumbered, withdrawn or reused.** Six other registers unchanged |
| **Gap register** | **No gap changed status.** `ATT-GAP-017` remains 🔴 **OPEN** |
| **Outcome** | `RQ-1` **MITIGATED — not resolved** · `RQ-2` **RESOLVED** · `RQ-3` **RESOLVED** · `RQ-4` **RESOLVED** · `RQ-5` **RESOLVED** · `RQ-6` **RESOLVED** · `RQ-7` **RESOLVED** · `RQ-8` **RESOLVED** |
| **Stage 4 verdict after correction** | **⚠️ CONDITIONALLY PASSED — unchanged.** The condition is `ATT-GAP-017`, and it is not mine to close |

---

## 0. What this record is

This is the execution record for the eight findings raised by `PRD-006_REQUIREMENTS_REVIEW.md`. It follows the
precedent set by [`PRD-007_CORRECTION_RECORD.md`](../seat-management/PRD-007_CORRECTION_RECORD.md), including
the part of that precedent that matters most:

> **The review's verdict and findings are left exactly as issued.** A correction record is a separate artefact.
> It records what was done about a finding; it does not re-verdict the review that raised it, and a document does
> not get to mark its own reviewer's paper.

This document follows `DOCUMENTATION_BASELINE.md` §3.3's treatment of review artefacts: **a validation record, not
part of the specification.** It confers no rank and freezes nothing. `PRD-006` remains `DRAFT`, remains
**Unranked**, and remains **not frozen** — the instruction authorising this work explicitly forbade freezing it,
and nothing here would have justified it in any case.

### 0.1 Why editing `PRD-006` was in scope at all

The two preceding tasks on this document were explicitly read-only. This one was explicitly corrective, and the
document itself permits it: its header declares **`DRAFT`**, **Unranked**, and *"This document claims no
authority"*. It is not frozen. Stage 4 is precisely the lifecycle stage at which requirement defects are closed —
`PRD_LIFECYCLE.md` L119 sets the gate as *"conflicts closed or explicitly deferred **with a reason and an
owner**"*, which presumes that closing them is the expected response.

### 0.2 The four things this correction was forbidden to do, and did not do

| Prohibition | Evidence it held |
|---|---|
| **Invent a default or a security value** | Zero values added. All seven `ATT-CFG-*` Default cells still read `ATT-GAP-017`; all seven Range cells still read **unresolved**. Verified mechanically — see §10 |
| **Modify authoritative architecture or external governance** | `PRD-007`, `PRD_REGISTRY.md`, BC Map, Dependency Matrix, `DOCUMENTATION_BASELINE.md`, `ADR-INDEX.md`, all 20 ADRs, `MASTER_PRD.md`, `Library_PRD_v1.md`, `PRD_LIFECYCLE.md` — **all byte-identical**, hashes in §11 |
| **Create an ADR** | None created. Nothing here decides structure, ownership, boundaries or a platform rule. `RQ-1`'s architectural question is exactly what `ATT-GAP-017` holds open for its named owner — **writing an ADR would have been the invention the instruction forbade, wearing a governance hat** |
| **Freeze `PRD-006`** | Version row still reads `v1.3 — DRAFT`; Rank still Unranked; no baseline admission |

---

## 1. `RQ-1` — HIGH — **MITIGATED, NOT RESOLVED**

### 1.1 The defect, as raised

Seven configurables have no default:

`ATT-CFG-005` · `ATT-CFG-006` · `ATT-CFG-011` · `ATT-CFG-012` · `ATT-CFG-014` · `ATT-CFG-019` · `ATT-CFG-023`

Each names `ATT-GAP-017` in its Default column and *"unresolved"* in its Range column. This fails Stage 4 check 3
(*"Every configurable has a default and a range"* — failure: *"Unbounded configuration is a specification hole"*)
and breaches `LIB-16.2` (Rank 3, `Library_PRD_v1.md` L676): *"Every setting **MUST** have a documented default. A
library that has changed nothing **MUST** be fully operable."*

### 1.2 Why the obvious fix was the wrong fix

The obvious fix is to write seven numbers. The instruction forbade it, and the document forbids it independently.
`ATT-GAP-017`'s own ledger verdict says why:

> *"**Inventing seven numbers would satisfy the letter and destroy the point.**"*

and §0.4 generalises it:

> *"A gap resolved by implementation choice is not resolved — **it is an undocumented architecture decision made by
> whoever happened to write the code first.**"*

A GPS accuracy radius, a QR rotation interval and a face-match confidence threshold are **security parameters**.
Each one is a decision about how much fraud the product tolerates. Writing a plausible-looking number would have
closed the finding, passed check 3, and shipped an unowned security decision disguised as a specification.

### 1.3 The correction — specify the behaviour in the absence of a value

The insight is that check 3 exists to prevent *unbounded configuration*, and there are two ways for configuration
to be bounded: state the value, or state what happens when there is none. The first was unavailable. The second
was not attempted before.

Five obligations were added at §16.3, and **not one of them supplies a value**:

| New | What it does |
|---|---|
| **`ATT-BR-043`** | No value **SHALL** be substituted — *"not zero, not a framework default, not a value copied from another tenant, another mode, another product or an example in this document."* An implementation that supplies one has resolved `ATT-GAP-017` by implementation choice, which §0.4 forbids |
| **`ATT-FR-149`** | A mode whose required setting has no value **MUST NOT** be enableable; the attempt is rejected with a specific reason **naming the missing setting** (`ATT-NFR-005`). No degraded or partially-validated enable |
| **`ATT-FR-150`** | No attendance is recorded, accepted or rejected by evaluating a valueless setting — the operation **fails closed**, applying `ATT-FR-127`'s rule to configuration rather than tenancy |
| **`ATT-BR-044`** | The `LIB-16.2` operability check, stated so it can be *tested* rather than asserted |
| **`ATT-FR-151`** | The Owner **MUST** be shown that no platform default exists. *"A blank field **MUST NOT** be presented as though it carried a default."* |

### 1.4 `ATT-BR-044` — the operability half of `LIB-16.2`, discharged

`LIB-16.2` has two sentences, and the second is separately testable: *"A library that has changed nothing **MUST**
be fully operable."* That sentence is **satisfied**, and `ATT-BR-044` now shows the working rather than claiming it:

| Setting | Reachable only via | Default state |
|---|---|---|
| `ATT-CFG-005`, `ATT-CFG-006` | Dynamic QR (`ATT-CFG-002`) | **Disabled** |
| `ATT-CFG-011`, `ATT-CFG-012` | Fixed QR + GPS (`ATT-CFG-004`) | **Disabled** |
| `ATT-CFG-014` | Face (`ATT-CFG-016`) | **Disabled** — and `ATT-FR-064` blocks the build outright |
| `ATT-CFG-019` | Register-image workflow (`ATT-CFG-018`) | **Disabled** — and `ATT-FR-080` blocks the build outright |
| `ATT-CFG-023` | — | **Optional by construction**: `ATT-FR-115` applies only *"where a correction window is configured"*, so its absence means no window is enforced, which is a defined behaviour rather than a missing one |

A tenant on day one uses **Manual**, which has a concrete default and no unresolved setting. **The breach is
therefore real but latent** — unreachable without an Owner deliberately enabling a mode whose values this document
has refused to invent.

### 1.5 Why this is recorded as MITIGATED and not RESOLVED

Because it is not resolved. The seven settings still have no defaults; the four affected modes still cannot
operate; `LIB-16.2`'s first sentence is still breached; `ATT-GAP-017` is still 🔴 **OPEN** and still owned by the
**product owner**.

What changed is the *character* of the hole. Before: seven blanks that an implementer would fill in on a Tuesday,
silently, and no rule said they could not. After: seven blanks that are **specified as blanks**, with substitution
forbidden, enablement impossible, evaluation fail-closed, and the Owner told the truth at configuration time.

> **A specification hole that is specified as a hole is still a hole — but it is no longer a trap.**

Recording this as RESOLVED would be the precise failure `§0.4` names. The PRD says so itself, in the note that
closes the new subsection: *"Why this is not a resolution of `ATT-GAP-017`, and must not be recorded as one."*

### 1.6 Effect on the Stage 4 verdict

**None.** Check 3 still fails for seven of 24 configurables, because the check asks for defaults and there are
none. The Stage 4 **gate** — *"conflicts closed or explicitly deferred with a reason and an owner"* — was already
satisfied before this correction and remains satisfied: the reason is recorded and the owner is named. The verdict
stays **⚠️ CONDITIONALLY PASSED**.

---

## 2. `RQ-2` — MEDIUM — **RESOLVED**

### 2.1 The defect, as raised

`ATT-AC-199` was the sole criterion covering the seven defaultless configurables, but named only a subset of them.
The remainder were covered only by inclusion in `ATT-AC-200`'s blanket range `ATT-CFG-001`…`ATT-CFG-024`, which
tests auditing of configuration changes — not the absence of a default. Coverage was **structurally** complete and
**substantively** partial.

### 2.2 The correction

`ATT-AC-199` re-cited to **all seven** configurables plus `ATT-BR-043`. Four criteria added, one per new
obligation, so that no obligation added by this correction arrives without its own test:

| New criterion | Verifies |
|---|---|
| `ATT-AC-210` | `ATT-FR-149` — enable rejected, reason names the missing setting |
| `ATT-AC-211` | `ATT-FR-150` — fails closed, never evaluates a valueless setting |
| `ATT-AC-212` | `ATT-BR-044` — day-one tenant operable by Manual; none of the seven reachable |
| `ATT-AC-213` | `ATT-FR-151` — Owner shown the absence; no blank field posing as a default |

`ATT-BR-045` (added under `RQ-5`) is verified by `ATT-AC-152`, extended rather than duplicated.

**Ordering note.** The four new criteria were initially appended immediately after `ATT-AC-199`, which placed
`ATT-AC-210`…`213` before `ATT-AC-200`…`208` in the table. That is not a defect a scanner would catch — coverage
was correct either way — but a register that reads out of order invites a later reader to assume a renumbering
happened. They were moved to the end of §30.19.

---

## 3. `RQ-3` — MEDIUM — **RESOLVED**

### 3.1 The defect, as raised

One document, three different open-gap counts: **17**, **18**, and a §32 header that disagreed with its own
ledger. Stage 5 requires register counts *"verified **mechanically**"*, and L126 defines mechanical as *"counted by
a tool, not by reading"* — a count that a tool cannot reproduce from the document is not a count, it is a claim.

### 3.2 The cause, located rather than guessed

A mechanical pass over the §32 register's verdict column yields **2 resolved / 1 narrowed / 18 open**. The document
claimed 3/1/17. The extra "resolution" is `ATT-GAP-012`, whose verdict cell reads:

> *"🔴 **OPEN** — storage sub-question **RESOLVED** negatively"*

An earlier tally read the word RESOLVED in that cell and counted the row. But the cell's own verdict is OPEN, and
the sub-question answered is not the question that defines the gap.

### 3.3 The correction — fix the counting rule, not the statuses

The count is now stated **over the 21 rows**, and **a row is counted by the status in its own verdict cell**. This
makes the figure reproducible by exactly the scan Stage 5 will run. Three passages were rewritten to say so, the
figure is now **2 resolved, 1 narrowed, 18 open** everywhere it appears as a live statement, and the earlier
figures are explicitly marked **superseded**:

> *"The v1.1 and v1.2 changelog entries state the earlier figures **3 resolved / 1 narrowed / 17 open** … those
> figures are superseded by this row, and **no gap's status changed to produce the new ones.**"*

`ATT-GAP-012` is counted **open**, with the reasoning stated in place: *"a partially answered gap is an open gap."*

The v1.0, v1.1 and v1.2 changelog rows were **left as written**. They record what those versions claimed, which is
the point of a changelog; correcting history to match the present would destroy the evidence that the miscount ever
happened.

### 3.4 Verification

A tool now reproduces the stated figure from the ledger column: **21 rows → 2 RESOLVED, 1 NARROWED, 18 OPEN.**
See §10.

---

## 4. `RQ-4` — MEDIUM — **RESOLVED**

### 4.1 The defect, as raised

`ATT-GAP-002` was recorded **RESOLVED** in the §32.1 ledger and in §5.2, while its row in the §32 register still
read **OPEN**. Two states for one gap in one document. Raised originally by `PRD-006_ARCHITECTURE_ALIGNMENT.md`
§10.1 and carried forward unfixed.

### 4.2 Which state was correct, and why that direction

RESOLVED is correct, and the resolution stands on an existing ratified pattern rather than on a new decision.
Frozen `PRD-007` (Rank 3) consumes `BC-18` with **no `E-` edge** — its §3 context table and `SEAT-BR-030`. A Core
context composing authenticated identity without a declared edge is therefore an established, ratified pattern, not
an invention. `ATT-GAP-002` asked whether `BC-03` may do the same. The answer already existed.

### 4.3 The correction

The §32 register row now reads `✅ **RESOLVED in v1.1 — see §32.1 and §5.2**`, restates the original question so the
row remains self-contained, cites the two sources as *"no longer in tension"*, closes the owner —

> *"*Was: architecture owner.* **Closed by an existing ratified pattern** — no owner decision was needed"*

— and sets Blocks to *"**Nothing.** No `BC-18 → BC-03` edge is asserted or required."*

All four mentions of `ATT-GAP-002` in the document (L316, L2161, L2195, L2216) now agree. **Frozen `PRD-007` was
read, quoted and left byte-identical.**

---

## 5. `RQ-5` — LOW — **RESOLVED**

### 5.1 The defect, as raised

§23.4 *"No second attendance system"* was a heading with no body. The section a reader consults for the
attendance/seating boundary said nothing.

### 5.2 The correction

The section now states the prohibition **in both directions**, showing that both halves already existed and were
merely never brought together: `PRD-007`'s `SEAT-BR-020` forbids `BC-04` from creating, storing, modifying,
deleting or verifying an attendance record; `ATT-BR-033` and `ATT-FR-140` are the reciprocal obligation on this
side.

`ATT-BR-045` was added to close the case the two existing rules leave implicit — **divergence**:

> *"Neither module **SHALL** hold a shadow copy of the other's system of record … Where the two disagree — a missed
> or stale event — `SEAT-FR-115` makes occupancy advisory and non-corrupting; **the attendance record is never
> reconciled backwards from occupancy.**"*

That last clause is the load-bearing one. Without it, a plausible-sounding reconciliation job could "repair"
attendance from seating and corrupt the system of record while appearing to fix it. `ATT-AC-152` extended to
verify it.

---

## 6. `RQ-6` — LOW — **RESOLVED**

### 6.1 The defect, as raised

`ATT-FR-078` required the audit chain for the register-image workflow but was phrased so that the obligation could
be read as contingent on the workflow's open questions being answered a particular way. An audit chain that is
optional under some resolutions is not an audit chain.

### 6.2 The correction

Now: *"Where this workflow operates at all, the audit relationship **MUST** be retained… **This obligation is
unconditional within the workflow.**"* — with the consequence stated plainly:

> *"if the answers do not permit the full chain to be retained, **the workflow does not ship** — the chain is not
> the part that gets dropped."*

This narrows nothing and adds no identifier; it removes a reading under which the obligation could evaporate.

---

## 7. `RQ-7` — LOW — **RESOLVED**

### 7.1 The defect, as raised

`ATT-FR-096` read *"**MUST** conceptually support"*. An obligation qualified by "conceptually" is untestable — the
precise failure mode of Stage 4 check 1. Any implementation can claim conceptual support.

### 7.2 The correction

One word deleted: *"**MUST** support"*. `ATT-AC-104` already tests it concretely (*"50+ students checking in within
one burst all succeed, with every §6.2 invariant intact"*), so the criterion was already stronger than the
requirement it verified. The requirement now matches its own test.

---

## 8. `RQ-8` — LOW — **RESOLVED**

### 8.1 The defect, as raised

`ATT-INV-010` appeared to restate `ATT-INV-004` — a Stage 4 check 5 concern (*"No requirement restates another"* —
failure: *"Two sources of truth"*), here in its internal form.

### 8.2 Why it is not a restatement, and the correction

It is a **narrowing**: `ATT-INV-004` is the aggregate invariant; `ATT-INV-010` is the same rule applied at the
operation level and scoped to the tenant. The document now says this in place, and explains the qualifier that
makes the difference material — via `ID-2`, *"a person enrolled at two libraries is two records"*, therefore:

> *"the tenant qualifier is load-bearing — one person **MAY** hold an open presence at two different libraries at
> the same time, and that is not a violation."*

Both invariants are retained deliberately, with a note recording why, *"so that neither invariant is later deleted
as a duplicate of the other."* Deleting either would have been the wrong correction: one would lose the aggregate
guarantee, the other the multi-tenant clarification.

---

## 9. Register bookkeeping

Adding obligations changes counts, and a count that is not updated becomes the next `RQ-3`. Every derived figure
in the document was found and corrected:

| Site | Before | After |
|---|---|---|
| §0.3 register table — `ATT-FR` | `…ATT-FR-148` / 148 | `…ATT-FR-151` / **151** |
| §0.3 register table — `ATT-BR` | `…ATT-BR-042` / 42 | `…ATT-BR-045` / **45** |
| §0.3 register table — `ATT-AC` | `…ATT-AC-209` / 209 | `…ATT-AC-213` / **213** |
| §0.3 totals paragraph | 506 / 279 / 209 | **516 / 285 / 213** |
| §28 business-rule index | ends `ATT-BR-042` | + `ATT-BR-043`, `ATT-BR-044`, `ATT-BR-045` |
| §30 preamble | *"209 criteria … 279 obligations"* | *"**213** criteria … **285** obligations"* |
| §31.1 coverage table | 148 / 42 / **279** | 151 / 45 / **285** |
| §31.1 orphan sentence | *"all 209 criteria"* | *"all **213** criteria"* |
| Header Version row | v1.2 — DRAFT | **v1.3 — DRAFT** |
| End-of-file line | v1.2 DRAFT | **v1.3 DRAFT** |
| §34 Change Log | — | v1.3 row added |

Two notes added rather than silent renumbering: §0.3 records **why** the totals moved and that nothing was
renumbered; §31.1 records that the denominator and numerator moved together and that coverage was **re-measured**
after the edit rather than assumed to have survived it.

### 9.1 The Status row

The header Status row read *"**Stage 2**. **Not reviewed**…"* — which had become false. Stage 3 and Stage 4 have
both been performed. It now records the accurate position:

> Stage 3 and Stage 4 *"have both been **performed** and both returned **⚠️ CONDITIONAL**; a conditional verdict is
> not a pass, so **no stage is claimed passed**"*

This is a correction **downward in claim and upward in accuracy**: it withdraws "not reviewed" (false) without
substituting "reviewed and passed" (also false).

---

## 10. Re-verification — the complete Stage 4 pass, after correction

Every figure below was produced by running a tool over the corrected document, not by reading it.

### 10.1 Registers — contiguity and totals

```
ATT-FR   151/151 max=151 contiguous=True PASS
ATT-BR    45/45  max=45  contiguous=True PASS
ATT-INV   12/12  max=12  contiguous=True PASS
ATT-EVT    4/4   max=4   contiguous=True PASS
ATT-XC    21/21  max=21  contiguous=True PASS
ATT-PO    14/14  max=14  contiguous=True PASS
ATT-CFG   24/24  max=24  contiguous=True PASS
ATT-NFR   14/14  max=14  contiguous=True PASS
ATT-AC   213/213 max=213 contiguous=True PASS
ATT-GAP   18/18  max=18  contiguous=True PASS
TOTAL identifiers: 516 (expect 516) PASS
suffixed GAP rows: 3 ['ATT-GAP-008a','ATT-GAP-016a','ATT-GAP-017a']
mode constants: 6                        PASS
ATTENDANCE_MODE_RFID occurrences: 0      PASS
attendance.* events: 4                   PASS
out-of-range tokens: 0                   PASS
RESULT: ALL PASS
```

### 10.2 Coverage — denominators derived, not restated

The coverage tool previously carried its denominators as literals. That is the same defect class as `RQ-3` — a
figure a tool asserts rather than measures — so the tool was changed to **derive** each denominator from the
document and assert contiguity, meaning it can no longer silently disagree with the registers it measures:

```
derived denominators: {FR:151, BR:45, INV:12, EVT:4, XC:21, PO:14, CFG:24, NFR:14}
AC rows parsed: 213
ORPHAN ACs (no requirement named): []
TOTAL 285/285 = 100.0%
```

Every one of the six new obligations is covered, and each by its own criterion:

```
ATT-FR-149 -> ATT-AC-210      ATT-BR-043 -> ATT-AC-199
ATT-FR-150 -> ATT-AC-211      ATT-BR-044 -> ATT-AC-212
ATT-FR-151 -> ATT-AC-213      ATT-BR-045 -> ATT-AC-152
```

### 10.3 The six Stage 4 checks

| # | Check | Result | Evidence |
|---|---|---|---|
| 1 | Every requirement testable | ✅ **PASS** | 285/285 obligations carry ≥1 criterion. `RQ-6` and `RQ-7` closed the two untestable phrasings. `ATT-NFR-003`'s refusal to state a latency figure remains **compliance, not a defect** — rejected as `R-4` in the review and unchanged here |
| 2 | Every exclusion states what is **impossible** | ✅ **PASS** | 21/21. The **MUST NOT** is carried in the §29 column header and every row begins `…`, so the prohibition is inherited by all 21. No deferral language in any row |
| 3 | Every configurable has a default and a range | ❌ **FAIL — 17/24** | Unchanged, and deliberately so. 7 still name `ATT-GAP-017`. **Mitigated** by `ATT-BR-043`, `ATT-FR-149`, `ATT-FR-150`, `ATT-BR-044`, `ATT-FR-151` — see §1 |
| 4 | Every criterion maps to a requirement | ✅ **PASS** | 213 AC rows, **0 orphans** |
| 5 | No requirement restates another PRD's | ✅ **PASS** | 11 foreign identifiers referenced, **0 defined here**. `RQ-8` resolved the internal case; `RQ-5` documented the `PRD-007` boundary by citation |
| 6 | Business rules do not contradict Rank 1 | ✅ **PASS** | 10 `MP-GBR-*` cited, all present in `MASTER_PRD.md`, none contradicted. No new obligation touches a Rank 1 rule |

**Five of six pass. Check 3 fails on the seven defaultless configurables and cannot pass until `ATT-GAP-017` is
answered by its owner.**

### 10.4 The gate

`PRD_LIFECYCLE.md` L119: *"conflicts closed or explicitly deferred **with a reason and an owner**."*

The gate is **satisfied**. Check 3's failure is deferred with a reason (*"inventing seven numbers would satisfy the
letter and destroy the point"*) and an owner (**product owner**), both recorded in `ATT-GAP-017` before this
correction and unchanged by it. A document can fail a check and still pass the gate; that distinction is what
keeps a known, owned, documented hole from being papered over.

---

## 11. Containment audit

| Protected file | SHA-256 (first 16) | State |
|---|---|---|
| `PRD-SEAT-MANAGEMENT.md` (`PRD-007`, frozen) | `c8760a46a8a371a6` | **Unchanged** |
| `PRD_REGISTRY.md` | `f8e71ce876c2b53b` | **Unchanged** |
| `LIBOORA_BOUNDED_CONTEXT_MAP.md` | `e527df027664680e` | **Unchanged** |
| `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` | `9895d244494372af` | **Unchanged** |
| `DOCUMENTATION_BASELINE.md` | `42405be29d392e14` | **Unchanged** |
| `ADR-INDEX.md` | `110d533b144f029c` | **Unchanged** |
| `MASTER_PRD.md` (Rank 1) | `5c31a3363d99a5f6` | **Unchanged** |
| `Library_PRD_v1.md` (Rank 3) | `a587c65e2f451e02` | **Unchanged** |
| `PRD_LIFECYCLE.md` | `5031fcc97a95980e` | **Unchanged** |

- **Protected-path diff** across `docs/00-governance/`, `docs/10-architecture/`, `docs/30-product/seat-management/`,
  `docs/30-product/library/`, `MASTER_PRD.md`, `lib/`, `test/`, `tool/`, `pubspec.yaml` — **empty**.
- **ADR files changed: 0** of 20.
- **No Dart source, test, tool or build file touched.** No `prd006_*` gate script created — that is a Stage 5
  deliverable and Stage 5 has not been reached.

---

## 12. What remains unresolved

| Item | State | Owner |
|---|---|---|
| **`ATT-GAP-017`** — seven defaultless configurables | 🔴 **OPEN.** Live `LIB-16.2` breach, now **latent and specified** rather than silent | **Product owner** |
| Stage 4 **check 3** | ❌ Fails 17/24 — a direct consequence of the above | Closes with `ATT-GAP-017` |
| **17 other open gaps** | 🔴 Unchanged. None resolved, narrowed or reworded by this correction | As named per row |
| `ATT-GAP-012`, `ATT-GAP-014` | 🔴 Open — still block Face mode from being built | As named per row |
| Stage 5, 6, 7 | Unattempted | — |
| Four stale *derived* lines in `PRD_REGISTRY.md` | Identified in §32.2, **deliberately not corrected** — registry owner's under §8 rule 3 | Registry owner |

---

## 13. Verdict

**Stage 4: ⚠️ CONDITIONALLY PASSED — unchanged from the review.**

Seven of eight findings are **RESOLVED**. The eighth, `RQ-1`, is **MITIGATED and explicitly not resolved**, because
resolving it requires seven security-relevant values that only the product owner may set.

The verdict does not improve, and it should not. A correction record that upgraded the verdict of the review that
authorised it would be marking its own work. Stage 4's condition was `ATT-GAP-017` before this correction and
remains `ATT-GAP-017` after it — what changed is that the document now behaves safely while the question is open,
instead of leaving seven blanks for an implementer to fill in by accident.

---

*End of `PRD-006_STAGE4_FINDINGS_CORRECTION.md`. Validation artefact. Confers no rank. Freezes nothing.*
