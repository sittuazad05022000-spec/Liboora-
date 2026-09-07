# ADR-0019 — Membership Management PRD v1.4 is the official baseline for `BC-02` Membership

| Field | Value |
|---|---|
| **Status** | **Accepted** |
| **Date** | 2026-08-04 |
| **Deciders** | Product owner (freeze authorisation); Principal Enterprise Architect; independent reviewer |
| **Supersedes** | Nothing |
| **Amends** | **No ranked document.** Admits a new document to Rank 3. `MASTER_PRD.md`, the Bounded Context Map, the Module Dependency Matrix and `ARCHITECTURE_RULINGS.md` are **unamended** |
| **Amended by** | — |
| **Baseline** | `BASELINE-2026-08-04-D` |
| **Closes** | [`PRD_LIFECYCLE.md`](../prd-ecosystem/PRD_LIFECYCLE.md) Stage 7 for `PRD-005`. Registry status `PLANNED` → `FROZEN` |
| **Does NOT close** | **`MM-GAP-001`, `MM-GAP-002`, `MM-GAP-005`, `MM-GAP-010`, `MM-GAP-010a`** — see §3. All remain open; each requires its own decision from its named owner. Nor does it close `MM-GAP-006a`/`MM-GAP-007a`, which are carried against the **BC Map**, not against this PRD |
| **Related** | [`ADR-0018`](./ADR-0018-student-management-prd-v1.2-baseline.md) (the `PRD-004` freeze precedent this ADR follows) · `ADR-0008` (authentication baseline) · `ADR-0011` (`BC-10`) · `ADR-0013` · `ADR-0014` · `AR-1` · `AR-2` · BC Map §5, §7, §9 · [`PRD_LIFECYCLE.md`](../prd-ecosystem/PRD_LIFECYCLE.md) Stage 7 · [`DOCUMENTATION_BASELINE.md`](../DOCUMENTATION_BASELINE.md) §7 |

---

## 1. The question

[`PRD-MEMBERSHIP-MANAGEMENT.md`](../../30-product/membership-management/PRD-MEMBERSHIP-MANAGEMENT.md) (`PRD-005`) has
completed lifecycle Stages 2–6. It has been reviewed **five** times independently and corrected **four** times; the
fifth review returned **A — PASS** with **zero findings** and one non-blocking observation.

`PRD_LIFECYCLE.md` Stage 7 states that freeze is **conferred, not claimed**, and that its gate is *"a row in
`DOCUMENTATION_BASELINE.md` §3 at an assigned precedence rank."* `DOCUMENTATION_BASELINE.md` §7 step 1 requires
**an ADR before** any Rank 1–5 change. Adding that row is such a change.

**Question:** should `PRD-005` v1.4 be admitted to the documentation baseline at Rank 3 as the authoritative
specification for `BC-02` Membership, exactly as written?

---

## 2. Evidence

### 2.1 Review history

| Stage | Artefact | Outcome |
|---|---|---|
| 3–4 | [`PRD-005_BLOCKER_ANALYSIS.md`](../../30-product/membership-management/PRD-005_BLOCKER_ANALYSIS.md) | The two self-declared freeze blockers `C-2` and `C-3` investigated against the primary source and **ratified as compliant** — no ADR, BC Map unmodified |
| — | [`PRD-005_CORRECTION_REPORT.md`](../../30-product/membership-management/PRD-005_CORRECTION_REPORT.md) | v1.1. Ratification executed; four stale cross-references and two register-integrity defects fixed |
| 3–4 | [`PRD-005_SECOND_INDEPENDENT_REVIEW.md`](../../30-product/membership-management/PRD-005_SECOND_INDEPENDENT_REVIEW.md) | Adversarial re-review. Verdict **B**. Findings `F-1`…`F-4` |
| — | [`PRD-005_F1-F4_CORRECTION_REPORT.md`](../../30-product/membership-management/PRD-005_F1-F4_CORRECTION_REPORT.md) | v1.2. All four closed; 39 acceptance criteria added |
| 3–4 | [`PRD-005_THIRD_INDEPENDENT_REVIEW.md`](../../30-product/membership-management/PRD-005_THIRD_INDEPENDENT_REVIEW.md) | Verdict **B**. Findings `TR-1`…`TR-5`, two HIGH |
| — | [`PRD-005_TR-1-TR-5_CORRECTION_REPORT.md`](../../30-product/membership-management/PRD-005_TR-1-TR-5_CORRECTION_REPORT.md) | v1.3. All five closed. **A published coverage figure was corrected downward** — 100.0% → 95.1% — after the review proved it counted prose |
| 3–4 | [`PRD-005_FOURTH_INDEPENDENT_REVIEW.md`](../../30-product/membership-management/PRD-005_FOURTH_INDEPENDENT_REVIEW.md) | Verdict **B**. Findings `QR-1`, `QR-2` |
| — | [`PRD-005_QR-1-QR-2_CORRECTION_REPORT.md`](../../30-product/membership-management/PRD-005_QR-1-QR-2_CORRECTION_REPORT.md) | v1.4. Both closed. A **false claim about a Rank 4 document** retracted and the suppressed question recorded as `MM-GAP-010a` |
| — | [`PRD-005_FIFTH_INDEPENDENT_REVIEW.md`](../../30-product/membership-management/PRD-005_FIFTH_INDEPENDENT_REVIEW.md) | Fifth independent review. **Verdict A — PASS. Zero findings**, one non-blocking observation (`OBS-1`) |

**A rejected finding is recorded as rejected, with its reason** — `PRD_LIFECYCLE.md` Stage 3's requirement. Across the
five reviews, findings were rejected with evidence in every correction pass, and in two cases (`TR-1`, `QR-1`) the
review's *finding* was accepted while its *suggested remedy* was rejected because the remedy would have recorded a
defect that does not exist. Both rejections are recorded in the PRD's own change history rather than in this ADR.

**Two of this document's own published claims were retracted by its own review chain** — the v1.2 coverage figures
(`TR-2`) and the v1.3 justification for retaining `BC-28` (`QR-1`). Neither was quietly overwritten: both rows are
annotated in §26 so the superseded reasoning stays auditable. This is the behaviour that makes the register
trustworthy, and it is the reason admission is proposed on the *measured* figures below rather than the declared ones.

### 2.2 Stage gates 5 and 6 — satisfied mechanically

| Gate | Requirement | Evidence |
|---|---|---|
| Stage 5 | Prefixes in `TRACEABILITY_MATRIX.md` §2, verified mechanically, zero collisions | [`TRACEABILITY_MATRIX.md`](../../40-implementation/TRACEABILITY_MATRIX.md) **v1.5** §2D records **ten** `MM-*` registers; **333** identifiers; every register contiguous 1→max; **0** duplicate definitions; **0 collisions** against every registered prefix set; **0** `MM-` hits outside the membership module |
| Stage 6 | `IMPL-*` range allocated; every task traces to requirements | [`PRD-005_IMPLEMENTATION_TASKS.md`](../../40-implementation/membership-management/PRD-005_IMPLEMENTATION_TASKS.md) **v1.0** — **42 tasks `IMPL-400`…`IMPL-441`**, five waves, non-overlapping with `IMPL-014`…`073`, `IMPL-100`…`127`, `IMPL-200`…`226` and `IMPL-300`…`323` |

Both gates are **re-runnable**, and were re-run immediately before this ADR was written:

| Tool | Result |
|---|---|
| `tool/docs_check/prd005_traceability.py` | **PASS**, exit 0 — 333 declared = 333 measured, all ten ranges contiguous, 0 duplicates, 0 collisions, 0 dangling identifiers in any *Verifies* cell |
| `tool/docs_check/prd005_task_coverage.py` | **PASS**, exit 0 — 42 unique tasks, 0 outside the allocated range, 0 foreign collisions, 0 tasks without a requirement, 0 citations to undefined identifiers, 0 unresolvable dependencies, 0 `Blocks`/`Blocked by` disagreements, 0 cycles, longest chain **19** tasks |

Task traceability is **223 of 223 obligation-bearing requirements = 100.0%** — every `MM-FR-*` (119), `MM-BR-*` (35),
`MM-INV-*` (12), `MM-EVT-*` (7), `MM-XC-*` (16), `MM-NFR-*` (14), `MM-PO-*` (11) and `MM-CFG-*` (9) is claimed by at
least one task. `MM-AC-*` and `MM-GAP-*` are excluded by design: a criterion is a test of an obligation, not an
obligation, and a gap is a question.

**One change to the Stage 5 checker was required by this admission, and is disclosed rather than hidden.** Its
*"`MM-` outside the membership module"* scan allowed only the module directory and `TRACEABILITY_MATRIX.md`, because
when it was written at Stage 5 no governance document could legitimately cite an `MM-*` identifier. Freeze makes four
of them do so necessarily — the freeze ADR must say which gaps stay open, the baseline must declare what entered
Rank 3, the registry must record the status change, and the ADR index must summarise it. The allow-list is therefore
extended to those four files **by name**, not to `docs/00-governance/` as a directory, so a stray `MM-` anywhere else
still fails the run. **This is not a weakening of the collision check:** a *citation* is not a *collision*, a
collision would be another register **defining** an `MM-` identifier, and the duplicate-definition and
registered-prefix checks that catch that are untouched. The identical situation exists for `PRD-004` — `ADR-0018`
cites `SM-*` sixteen times and `DOCUMENTATION_BASELINE.md` cites `SM-EV-*`/`LMD-*` five times — and is correct there
too. Every count, contiguity result and coverage figure is **byte-identical before and after** the change.

**Two defects in the Stage 6 artefact were found by its own checker and fixed before commit**, not by inspection:
`MM-BR-013` was described in a task's prose and test cell but never cited in its *Requirements* column, and one
`Blocks` edge was not the inverse of the `Blocked by` edge that declared it. Coverage was 222/223 until the first was
fixed. **`SID-4.56` — an unchecked rule is unmet — is the reason the checker exists.**

### 2.3 Architectural conformance

| Check | Result |
|---|---|
| Owns exactly one context | ✅ `BC-02` Membership `[CORE]`, Library Management cluster, rank 8 |
| No new bounded context | ✅ Count remains **31**. No `BC-32` |
| Every integration edge exists in BC Map §7 | ✅ `E-01`, `E-02`, `E-03`, `E-07`, `E-10` + generics `E-17`…`E-20`, `E-23`. **No edge added** |
| Rank direction downward | ✅ Gate 4 architecture tests pass (`+77`) |
| No authorisation outside `BC-18` | ✅ `MM-XC-*` exclusions; `MM-PO-001`…`011` name the protected operations without modelling a role |
| No credential, OTP or session | ✅ `ID-1` honoured; no credential surface introduced |
| Tenant scoping | ✅ `X-13` mechanically checked by `ADR-0014`'s enforcement; no cross-tenant read or write specified |
| Event naming `<Context>.<Aggregate><PastTense>` | ✅ Seven `MM-EVT-*`, closed set, `MM-BR-035` requires the register be closed at seven and every consumer resolve to an `MM-BR-006` edge |
| Enrollment and Membership remain two state machines | ✅ BC Map L209's *"two independent state machines"* honoured; `PRD-005` owns no enrollment state and `PRD-004` owns no membership state |
| Depends only on frozen authority | ✅ `E-01` resolves to `PRD-004` **v1.2 FROZEN**. `PRD-006`/`007`/`008` do not exist; this document publishes to them through **pre-declared edges only**, so it depends on no unwritten content |

### 2.4 Money, notification and analytics stay outside `BC-02`

`MM-XC-001`…`016` exclude payment execution, notification delivery, analytics aggregation, audit storage and the
authorisation model. Proration is excluded as V2 (`MM-GAP-002` records the unresolved ownership question rather than
answering it), Membership Analytics as not-V1 (`MM-XC-006`), and Downgrade, Freeze, Transfer, Cancellation and History
as V2, Auto Renewal as V3, Cross-Library as Future. **The document specifies four authoritative capabilities and
declines the rest in writing.**

### 2.5 Verification coverage is measured, and is not complete

This is stated plainly because admission does not depend on hiding it. Under the **strict counting rule** the document
binds itself to in §0.2 — an obligation is verified only if its identifier appears in an `MM-AC-*` *Verifies* cell,
and prose never counts:

| Measure | Value |
|---|---|
| `MM-BR-*`/`MM-INV-*`/`MM-XC-*`/`MM-PO-*`/`MM-EVT-*` registers | **77 / 81 = 95.1%** |
| All criterion-verifiable obligations | **134 / 223 = 60.1%** |
| `MM-INV-*`, `MM-EVT-*`, `MM-XC-*`, `MM-PO-*` | **100%** each |
| `MM-BR-*` | 31 / 35 — the four exceptions are named in §3.5 |

**60.1% is not a defect being waived; it is the honest figure that replaced a false 100%.** `MM-NFR-014` restates
`SID-4.56` for this document, and §23.1 and §25.3 now carry the measured position with the four unverified rules named
rather than a universal claim. A specification that admits which of its rules no criterion tests is more useful than
one that asserts full coverage, and this one was corrected twice to reach that state.

---

## 3. The open items — investigated, not resolved

**`PRD_LIFECYCLE.md` Stage 4 permits deferral *"with a reason and an owner."*** Every item below is deferred on that
basis. This ADR **takes no position on any substantive question** and does not invent an answer.

### 3.1 `MM-GAP-010` — a systemic defect in a Rank 4 document

BC Map §9 names `BC-26` Analytics a consumer of events from **eleven** producing contexts — `BC-01`, `BC-02`, `BC-03`,
`BC-04`, `BC-05`, `BC-10`, `BC-11`, `BC-12`, `BC-18`, `BC-20`, `BC-27` — while §7 declares an inbound edge to `BC-26`
from exactly **one** of them (`E-26`, from `BC-27`, L335). BC Map L292 states that an edge absent from §7 *"does not
exist"*. **Ten producer→`BC-26` relationships are therefore asserted in one section of a Rank 4 document and denied by
another.**

- **Classification:** internal inconsistency in a frozen Rank 4 document.
- **Owner:** Enterprise Architecture (BC Map owner).
- **Requires:** its own ADR amending BC Map §7 or §9.
- **Why admission is unaffected:** `PRD-005` resolves the tension the same way frozen `PRD-004` resolved its identical
  instance (`SM-GAP-11`, `GCP-06`) — by **not listing** `BC-26` as a consumer (`MM-BR-035`), inventing no edge, and
  recording the tension. `BC-02` publishes facts to the five consumers that verify against §7. Under **every**
  candidate resolution the document's behaviour is unchanged: if the edge is later declared, `BC-26` becomes a
  subscriber to events already published; if it is not, nothing was promised.
- **This gap is broader than `SM-GAP-11`** and supersedes the need for each module PRD to re-derive the same refusal.
  One ruling settles the class.

### 3.2 `MM-GAP-010a` — deliberate deferral or omission?

BC Map §9 L411 names `BC-28` Workflow a consumer of `membership.MembershipExpiringSoon`, yet §7 declares **no edge to
`BC-28` at all**. V2 status does not explain this: §7 **does** declare edges whose consumers are V2 contexts — `E-14`
(L318) runs from V1 `BC-13` to `BC-11`, `BC-12` and the V2 contexts `BC-14` and `BC-15` (L118/L119). The BC Map does
not distinguish deliberate deferral from omission, and **`PRD-005` may not settle that.**

- **Classification:** unresolved external decision in a Rank 4 document.
- **Owner:** Enterprise Architecture (BC Map owner).
- **Why admission is unaffected:** `MM-BR-035` defines a `(V2)`-annotated consumer to assert **no V1 edge and no V1
  delivery obligation**; V1 delivery of `MM-EVT-006` is to `BC-22` on `E-23` alone. The document is correct under
  either reading, so no resolution can falsify it.
- **This gap exists because a false justification was retracted.** v1.3 claimed no wholly-V2 context appears in §7;
  `QR-1` disproved it. The retraction is the reason the question is now recorded instead of answered.

### 3.3 `MM-GAP-001` and `MM-GAP-002` — two schema-freeze open questions

Both are BC Map §13 open questions (`Q-01`, `Q-06`) that land on `BC-02`, and `MP-DEP-07` names `Q-01`…`Q-07` as a
schema-freeze dependency.

| Gap | Question | Owner | Why admission is unaffected |
|---|---|---|---|
| **`MM-GAP-001`** | Does an expired membership get a grace period, and does it extend *entitlement* or only *seat release*? (`Q-01`) | Architecture + `BC-04` owner | V1 behaviour (`MM-FR-111`) is specified so as to be **correct under either resolution** |
| **`MM-GAP-002`** | Who executes proration money, and what is the `BC-02` entitlement-delta contract? (`Q-06`) | Architecture + Business Platform | **Proration is V2.** V1 specifies no proration, so there is nothing for the answer to contradict |

**Neither is decided here.** Deciding `Q-01` inside this ADR would amend the BC Map's open-question register as a side
effect of admitting a module PRD — the silent-amendment failure `PRD_LIFECYCLE.md` L177 prohibits.

### 3.4 The remaining recorded questions

| Gap | Question | Owner | Blocking? |
|---|---|---|---|
| `MM-GAP-003` | Can age-based plan eligibility be mandatory while DOB's mandatory/optional status is itself unresolved? (`GCP-05` / `SM-GAP-10`) | `BC-10` owner | No — eligibility is `MAY`. **Inherited from `ADR-0018` §3.1 and not re-decided here** |
| `MM-GAP-004` | Should membership search use `BC-23`, requiring a new `E-2x` edge? | Architecture | No — local match suffices at V1 scale; **no edge invented** |
| **`MM-GAP-005`** | May an owner force an immediate `seatQuota` change on active memberships? | Product | No — deferral to renewal is the safe default |
| `MM-GAP-006a` | Should BC Map §5's per-context columns be annotated *"illustrative, not exhaustive"*? | Architecture (BC Map owner) | No — editorial hygiene in Rank 4; **carried against the BC Map, not against this PRD** |
| `MM-GAP-007a` | BC Map §9 omits `MembershipUpgraded` though `E-07` names it, and lists V2 states in a table headed *"V1 event surface"* | Architecture (BC Map owner) | No — two pre-existing Rank 4 inconsistencies, independent of this PRD |
| `MM-GAP-008` | Is `endDate == startDate` permitted against BC Map §8's strict `>`? | Architecture | Blocks **single-day plans only** |
| `MM-GAP-009` | Should holidays extend a term, and via which edge? | Architecture + `BC-06` owner | No — V1 does not extend terms (`MM-FR-060`) |

`MM-GAP-006` and `MM-GAP-007` are **closed** (ratified 2026-08-04, no ADR, BC Map unmodified). Their identifiers are
**retained rather than reused** so prior citations resolve — the checker verifies this explicitly.

### 3.5 The four unverified business rules

`MM-BR-012`, `MM-BR-022`, `MM-BR-027` and `MM-BR-028` carry **no verifying `MM-AC-*`**. This is named in §23.1 and
§25.3 and is the reason the register figure is 31/35 rather than 35/35. It is a **traceability gap, not a rule gap**:
each is defined, each is claimed by an implementation task, and none is weakened. Closing it needs a criterion, which
is a **clarifying addition** — a changelog entry under `PRD_LIFECYCLE.md` Stage 7's change table, not an ADR.

- **Owner:** `PRD-005` editor. **Not blocking:** all four are covered at Stage 6.

### 3.6 Two staleness observations, recorded and deliberately not fixed

Freeze makes two truthful statements inside already-committed documents stale. **Neither is corrected during
admission**, because doing so would change bytes the review chain verified:

| Location | Statement, once frozen | Disposition |
|---|---|---|
| `PRD-005` §25.4, final bullet | *"It did **not** register itself in `PRD_REGISTRY.md` or claim a baseline row… this document is **`DRAFT`** at Stage 2"* | **Accurate as a record of the drafting pass**, which is what §25.4 documents. Frozen `PRD-004` retains the identical construction at its lines 25, 43 and 1232. **Left unmodified** |
| `PRD-005_IMPLEMENTATION_TASKS.md` §9 | *"That `PRD-005` is frozen — it is `DRAFT`"* and *"the registry still records `PRD-005` as `PLANNED`"* | Both were true when written and are superseded by this ADR. The task document is **unranked** and editable without an ADR, but it is **not** edited here: it is one half of the developer handoff package and was independently verified at v1.0. **Recorded for a later clarifying pass** |

`ADR-0018` §3.4 set this precedent exactly — the `SID-2.7` citation imprecision was recorded for a post-freeze
editorial pass rather than fixed during admission.

---

## 4. Decision

**`PRD-MEMBERSHIP-MANAGEMENT.md` v1.4 is admitted to the documentation baseline at Rank 3 as the authoritative
specification for `BC-02` Membership**, exactly as verified, together with its nine review and correction reports as
validation records (**not** part of the specification).

1. **Version is preserved at v1.4.** Freeze confers status; it does not renumber a document. `PRD-003` was admitted
   at v1.0 and remained v1.0; `PRD-004` was admitted at v1.2 and remained v1.2. Baseline §7 step 2 increments a
   version when *content* changes — and **no requirement, criterion, invariant, event, payload, business rule,
   register, ownership row or scope statement changes here.**
2. **Rank 3, non-overlapping.** Rank 3 now holds **five** module baselines: Authentication governs `BC-18`; Student
   Identity governs `BC-10`; the Library PRD governs Library Management; `PRD-004` governs `BC-01` Enrollment; and
   **`PRD-005` governs `BC-02` Membership**. Where `PRD-005` appears to constrain another context it states *what
   must be true*; the owning context remains the sole authority on *how it is decided*.
3. **No ranked document is amended.** No BC Map edit, no `MP-GBR-*` change, no dependency-law exception, no new
   context, **no new edge** — the last despite four recorded temptations to add one (`MM-GAP-004`, `MM-GAP-009`,
   `MM-GAP-010`, `MM-GAP-010a`).
4. **The registers are closed as declared:** seven `MM-EVT-*` closed at seven by `MM-BR-035`; 31 contexts unchanged;
   333 identifiers across ten registers, 320 obligation-bearing, 223 criterion-verifiable, 13 `MM-GAP-*`. The
   suffixed identifiers `MM-FR-057a`, `MM-AC-074a`/`076a`/`080a` and `MM-GAP-006a`/`007a`/`010a` are part of the
   declared registers and are documented in §0.2.
5. **`MM-GAP-001`, `MM-GAP-002`, `MM-GAP-005`, `MM-GAP-010` and `MM-GAP-010a` remain OPEN.** Admission does **not**
   resolve, ratify or close any of them, nor `MM-GAP-006a`/`MM-GAP-007a`, which are carried against the BC Map.
   Each requires a decision from its named owner. **Admitting a PRD that *discloses* a defect in a higher-ranked
   document is not the same as endorsing that defect** — `ADR-0018` §4.5.
6. **Verification coverage is admitted at its measured value, not rounded up.** 95.1% of the rule registers and 60.1%
   of all obligations, with the four unverified business rules named in §3.5. `PRD-005` is **`FROZEN`, not
   `VERIFIED`**: 0 of 42 tasks and 0 of 97 acceptance criteria are proven by a test.
7. **Baseline identifier advances to `BASELINE-2026-08-04-D`** per §7 step 4 — a Rank 3 document enters the baseline.

---

## 5. Options considered

| Option | Why not chosen |
|---|---|
| **Admit at v1.0**, renumbering to match "first frozen release" | Would rewrite a version history that five review reports cite. v1.4 *is* the verified artefact, and three of its changelog rows carry annotations that make superseded reasoning auditable; renumbering would break every citation and imply content changed. Rejected on the `ADR-0018` §5 and `PRD-003` precedents |
| **Resolve `MM-GAP-010`/`MM-GAP-010a` inside this ADR** | Both are defects in a **Rank 4 document this ADR does not own**. Deciding them here would amend BC Map §7 or §9 as a side effect of admitting a module PRD — the silent-amendment failure `PRD_LIFECYCLE.md` L177 prohibits, and the identical option `ADR-0018` rejected for `SM-GAP-11`. **Rejected** |
| **Withhold freeze until `Q-01` and `Q-06` close** | Both are BC Map §13 questions owned outside `BC-02`. `PRD-005` is deterministic under every resolution (§3.3), so blocking would stall a five-times-reviewed specification on decisions it cannot make and does not depend on |
| **Withhold freeze until coverage reaches 100%** | Would reward the *false* 100% that `TR-2` retracted and punish the honest 60.1% that replaced it. The four unverified rules are named, defined and task-covered (§3.5); closing them is a clarifying addition Stage 7 permits **after** freeze, by changelog entry |
| **Fix the stale §25.4 bullet during admission** | Would change bytes the fifth review verified, invalidating the review chain this ADR rests on. §25.4 documents the *drafting pass*, where the statement was true; frozen `PRD-004` retains the identical construction. Recorded in §3.6 instead |
| **Edit the implementation-task document's §9 rows during admission** | The task document is unranked and could be edited without an ADR — but it is half of the developer handoff package, was independently verified at v1.0, and its §9 rows were true when written. Editing a verified handoff artefact to tidy a tense is not a correction. Recorded in §3.6 |
| **Admit at Rank 4 or 5** | `PRD-005` is a module PRD owning a `[CORE]` context. Rank 3 is where the other four module baselines sit. A lower rank would place a specification beneath the boundary documents that merely *describe* its context |
| **PRD-local `Status: FROZEN` with no baseline row** | Contradicts Stage 7 and `PRD_REGISTRY.md` §2.1. Would make `PRD-005` self-declaring while the governance layer still recorded it as `PLANNED`. **Rejected** |
| **Add a `§3.4` baseline row for the implementation-task document** | `PRD-004_IMPLEMENTATION_TASKS.md` has **no** row in `DOCUMENTATION_BASELINE.md` §3.4. A backlog is not a specification and ranking one would make every task edit require an ADR. Follows the precedent exactly: **no row added** |

---

## 6. Consequences

### 6.1 Immediate

- `PRD-005` becomes **`FROZEN`**. Any change to it now requires **an ADR before the change** (baseline §7 step 1).
- Rank 3 gains a **fifth** module baseline. `PRD-006`, `PRD-007` and `PRD-008` may now cite `BC-02` as settled
  authority rather than as a draft — and their `E-02`, `E-03` and `E-07` contracts are fixed before they are written.
- **`MM-*` identifiers become stable.** All 333, including the suffixed successors, may not be renumbered by revision
  alone. `MM-BR-035`'s closure of the event register at seven may not be extended without an ADR.
- The **second `[CORE]` context of the Library cluster** acquires a frozen specification. With `BC-01` frozen at
  `ADR-0018`, the `E-01` dependency *"membership may not exist without an active enrollment"* is now frozen on **both
  sides**.
- The 42 tasks `IMPL-400`…`IMPL-441` become a backlog against a frozen specification rather than against a draft.

### 6.2 What does **not** change

- **No requirement identifier is added, removed, renumbered or reworded.** Registers stay at **333** identifiers, 320
  obligation-bearing, 223 criterion-verifiable, 97 `MM-AC-*`, seven `MM-EVT-*`, 13 `MM-GAP-*`.
- **No coverage figure changes.** 95.1% and 60.1%, re-measured by tool during this admission.
- **No global business rule changes.** No `MP-GBR-*` is touched.
- **No architecture document changes.** BC Map, Dependency Matrix, `ARCHITECTURE_RULINGS.md`, EA untouched.
- **No other PRD changes.** `PRD-004` and the three other Rank 3 baselines are byte-identical.
- **`TRACEABILITY_MATRIX.md` and the implementation-task document are not modified.** Stage 7's gate is a baseline
  row; neither document is part of it, and §3.6 records why the one stale statement in each is left alone.
- **No code changes.** Implementation remains **entirely unstarted** — 0 of 42 tasks.
- **No context count change.** 31 before, 31 after. **No edge added.**

### 6.3 Carried forward

| Item | Owner | Requires |
|---|---|---|
| **`MM-GAP-010`** — ten producer→`BC-26` relations asserted in BC Map §9, denied by §7 | Architecture owner | **A separate ADR** amending BC Map §7 or §9. Supersedes the per-module instances `SM-GAP-11`/`GCP-06` |
| **`MM-GAP-010a`** — is `BC-28`'s absence from §7 deferral or omission? | Architecture owner | **A separate ADR** or an explicit BC Map scoping statement |
| **`MM-GAP-001`** grace period (`Q-01`) | Architecture + `BC-04` owner | A source decision on a BC Map §13 question |
| **`MM-GAP-002`** proration ownership (`Q-06`) | Architecture + Business Platform | A source decision; V2 scope |
| **`MM-GAP-005`** forced `seatQuota` change | Product | A product decision |
| `MM-GAP-006a`, `MM-GAP-007a` | Architecture (BC Map owner) | Rank 4 editorial hygiene; non-blocking |
| `MM-GAP-003`, `MM-GAP-004`, `MM-GAP-008`, `MM-GAP-009` | Named per gap in §25.2 | A source decision; none blocks implementation start |
| **Four unverified business rules** `MM-BR-012`/`022`/`027`/`028` | `PRD-005` editor | Post-freeze **clarifying pass**: a criterion each, changelog entry, **no ADR** |
| §25.4 and task-document §9 staleness (§3.6) | `PRD-005` editor | Post-freeze clarifying pass; changelog entry, no ADR |
| **0 of 97 acceptance criteria proven by test** | Implementation | Stage 9. **`PRD-005` is `FROZEN`, not `VERIFIED`** |
| `BLK-01` demo-surface debt (`ADR-0012`, expiry 2026-10-31) | Implementation | Unaffected by this ADR; **not waived** |

---

## 7. Compliance

| Rule | Satisfied |
|---|---|
| `PRD_LIFECYCLE.md` Stage 7 — freeze conferred by a baseline §3 row | ✅ Row added to §3.3 in the same commit |
| `PRD_LIFECYCLE.md` Stage 5 — prefixes registered, zero collisions | ✅ `TRACEABILITY_MATRIX.md` v1.5 §2D; tool exit 0 |
| `PRD_LIFECYCLE.md` Stage 6 — `IMPL-*` allocated, every task traces | ✅ `IMPL-400`…`441`; **223/223 = 100.0%**; tool exit 0 |
| `DOCUMENTATION_BASELINE.md` §7 step 1 — **ADR before the change** | ✅ This ADR is the first artefact of the sequence |
| §7 step 2 — version incremented, changelog updated, same commit | ✅ **v1.4 preserved** (no content change); changelog entry added |
| §7 step 3 — declaration updated in the same commit | ✅ One coherent commit |
| §7 step 4 — baseline identifier changes | ✅ → `BASELINE-2026-08-04-D` |
| `PRD_LIFECYCLE.md` L177 — a frozen document is never silently modified | ✅ **No frozen document modified.** `PRD-004` and the three other Rank 3 baselines byte-identical |
| Stage 3 — rejected findings recorded with reasons | ✅ Across five reviews, in the PRD's own §26; two remedies rejected while their findings were accepted |
| Stage 4 — conflicts closed **or deferred with a reason and an owner** | ✅ Eight conflicts in §25.1; §3 names an owner for every open gap |
| BC Map L292 — an edge absent from §7 needs an ADR | ✅ **No edge added.** §3.1 and §3.2 decline to add one |
| `SID-4.56` / `MM-NFR-014` — an unchecked rule is unmet, not satisfied by intent | ✅ Every count tool-verified; the four unchecked rules named in §3.5; 0 tests ≠ verified, hence `FROZEN` not `VERIFIED` |
| `X-13`, `ID-1` never waived | ✅ No credential surface added; tenant scoping mechanically enforced by `ADR-0014` |
| `AR-1`, `AR-2` honoured | ✅ Discovery delegates membership creation to `BC-02`; Authentication owns registration |

---

## 8. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-04 | Accepted. Admits `PRD-MEMBERSHIP-MANAGEMENT.md` **v1.4** to the baseline at **Rank 3** as the authoritative specification for `BC-02` Membership, **exactly as verified and with the version preserved**. Fifth *admission* ADR, following `ADR-0008`, `ADR-0009`/`ADR-0010`, `ADR-0011` and `ADR-0018`. No ranked document amended, no requirement changed, **no edge added**, no context created, no global business rule touched, no code modified; `TRACEABILITY_MATRIX.md` and the implementation-task document deliberately **not** modified. Stage 5 and Stage 6 gates re-run immediately before acceptance and both **PASS** at exit 0 — 333 identifiers with 0 collisions, and 42 tasks `IMPL-400`…`441` covering **223/223 = 100.0%** of obligations. **Five gaps recorded as OPEN, not resolved** — `MM-GAP-001`, `MM-GAP-002`, `MM-GAP-005`, `MM-GAP-010`, `MM-GAP-010a` — plus `MM-GAP-006a`/`MM-GAP-007a` carried against the BC Map; §3 records each classification, owner and the requirement for a separate decision rather than inventing one. `MM-GAP-010` is admitted as **systemic**: it supersedes the per-module `SM-GAP-11`/`GCP-06` instance by naming all ten denied producer→`BC-26` relations. **Verification coverage admitted at its measured value, not rounded up** — 95.1% of the rule registers and 60.1% of all obligations, with the four unverified business rules `MM-BR-012`/`022`/`027`/`028` named in §3.5; the figures are the *corrected* ones that replaced a false 100% retracted by `TR-2`. Two staleness observations recorded in §3.6 for a post-freeze clarifying pass and deliberately not fixed during admission, on the `ADR-0018` §3.4 precedent, so the verified bytes are preserved. Baseline advances to **`BASELINE-2026-08-04-D`**, issued because a Rank 3 document entered the baseline (§7 step 4). `PRD-005` is `FROZEN`, **not `VERIFIED`** — 0 of 42 tasks and 0 of 97 acceptance criteria are proven by a test |
