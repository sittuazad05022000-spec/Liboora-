# ADR-0018 — Student Management PRD v1.2 is the official baseline for `BC-01` Enrollment

| Field | Value |
|---|---|
| **Status** | **Accepted** |
| **Date** | 2026-08-04 |
| **Deciders** | Product owner (freeze authorisation); Principal Enterprise Architect; independent reviewer |
| **Supersedes** | Nothing |
| **Amends** | **No ranked document.** Admits a new document to Rank 3. `MASTER_PRD.md`, the Bounded Context Map, the Module Dependency Matrix and `ARCHITECTURE_RULINGS.md` are **unamended** |
| **Amended by** | — |
| **Baseline** | `BASELINE-2026-08-04-C` |
| **Closes** | `PRD_LIFECYCLE.md` Stage 7 for `PRD-004`. Registry status `DRAFT` → `FROZEN` |
| **Does NOT close** | **`SM-GAP-10`** and **`SM-GAP-11`** — see §3. Both remain open and each requires its own ADR |
| **Related** | `ADR-0008` (authentication baseline) · `ADR-0011` (`BC-10`) · `ADR-0013` · `AR-1` · `AR-2` · BC Map §7, §8 · Student Identity PRD §2.7 · `PRD_LIFECYCLE.md` Stage 7 · `DOCUMENTATION_BASELINE.md` §7 |

---

## 1. The question

`Student_Management_PRD_v1.md` (`PRD-004`) has completed lifecycle Stages 2–6. It has been reviewed three times
independently, corrected twice, and the final freeze review returned **A — READY FOR FREEZE** with both of its
findings closed.

`PRD_LIFECYCLE.md` Stage 7 states that freeze is **conferred, not claimed**, and that its gate is *"a row in
`DOCUMENTATION_BASELINE.md` §3 at an assigned precedence rank."* `DOCUMENTATION_BASELINE.md` §7 step 1 requires
**an ADR before** any Rank 1–5 change. Adding that row is such a change.

**Question:** should `PRD-004` v1.2 be admitted to the documentation baseline at Rank 3 as the authoritative
specification for `BC-01` Enrollment, exactly as written?

---

## 2. Evidence

### 2.1 Review history

| Stage | Artefact | Outcome |
|---|---|---|
| 3–4 | `PRD-004_ALIGNMENT_REPORT.md` v1.1 | 3 conflicts resolved toward the frozen architecture; 4 duplicates avoided by citation; **11** gaps recorded rather than invented; **0 requirements invented** |
| 3–4 | `PRD-004_INDEPENDENT_REVIEW_REPORT.md` | 6-persona review. Verdict **C**. 21 findings |
| — | `PRD-004_CORRECTION_REPORT.md` | 15 applied, 3 rejected with evidence. Verdict **B** |
| 3–4 | `PRD-004_SECOND_INDEPENDENT_REVIEW.md` | 17 findings (`SR-01`…`SR-17`), 2 HIGH. Verdict **B** |
| — | `PRD-004_FINAL_CORRECTION_REPORT.md` | Both HIGH resolved; 9 fixed; `SR-13` rejected with evidence. Verdict **A** |
| — | `PRD-004_FINAL_FREEZE_REVIEW.md` | Adversarial re-audit of all 12 mandated items; **10 disproof attempts, 8 failed outright**. 2 LOW findings, **both outside `PRD-004`**. Verdict **B** |
| — | `PRD-004_FINAL_FREEZE_CLOSURE_REPORT.md` | `FR-01` and `FR-02` closed. Verdict **A** |

**A rejected finding is recorded as rejected, with its reason** — `PRD_LIFECYCLE.md` Stage 3's requirement.
Across the three reviews, **6 findings were rejected with evidence** and the draft's intent preserved.

### 2.2 Stage gates 5 and 6 — satisfied mechanically

| Gate | Requirement | Evidence |
|---|---|---|
| Stage 5 | Prefixes in `TRACEABILITY_MATRIX.md` §2, verified mechanically, zero collisions | §2C records ten registers; **251** base identifiers (**266** with sub-lettered); every register contiguous 1→max; **0 collisions**; independently reproduced by two different extractors |
| Stage 6 | `IMPL-*` range allocated; every task traces to requirements | `PRD-004_IMPLEMENTATION_TASKS.md` v1.1 — **24 tasks `IMPL-300`…`IMPL-323`**, six waves, non-overlapping with `IMPL-100`…`127` and `IMPL-200`…`226` |

Traceability, computed by `tool/docs_check/prd004_traceability.py`: **227 of 240 real requirements sourced =
94.6%**; 13 untraced are enumerated in the PRD's own §10.5.1, not hidden.

### 2.3 Architectural conformance

| Check | Result |
|---|---|
| Owns exactly one context | ✅ `BC-01` Enrollment `[CORE]`, rank 8 |
| No new bounded context | ✅ Count remains **31**. Chapter 5 is a read composition (`AR-1`), **no `BC-32`** |
| Every integration edge exists in BC Map §7 | ✅ `E-11`, `E-13`, `E-01`, `E-09`, `E-21`, `E-22` + generics `E-17`…`E-20`, `E-23`. **No edge added** |
| Rank direction downward | ✅ Gate 4 architecture tests pass (`+77`) |
| No authorisation outside `BC-18` | ✅ `SM-10.9` names `X-13` and the session-derived tenant rule |
| No credential, OTP or session | ✅ `SM-XC-*` exclusions; `ID-1` honoured |
| Tenant scoping | ✅ `X-13` mechanically checked; *"the real repository has no X-10 or X-13 violation"* passes |
| Event naming `<Context>.<Aggregate><PastTense>` | ✅ Ten `SM-EV-*`, closed set, `SM-7.12` requires an ADR to extend |

### 2.4 Enrollment and Membership remain two state machines

BC Map L209 — *"`EnrollmentStatus` vs `MembershipStatus`. **Two independent state machines** — a student can be
Active with an Expired membership"* — is honoured throughout, and `SM-AC-6` asserts it as a criterion.
**`PRD-004` owns no membership state.**

### 2.5 The Library Members Directory is a read composition, not a second store

`PRD_REGISTRY.md` L338 assigned Master PRD module 3 to `PRD-004`. Delivered as **chapter 5**, `LMD-1`…`LMD-31`,
owning **no aggregate, no invariant, no business state** (`AR-1`), performing composition in the **application
layer** (`LMD-22`, `SID-2.41`). **No `LibraryMember` aggregate and no second member store were created.**

---

## 3. The two open gaps — investigated, not resolved

**`PRD_LIFECYCLE.md` Stage 4 permits deferral *"with a reason and an owner."*** Both gaps below are deferred on
that basis. This ADR **takes no position on either substantive question** and does not invent an answer.

### 3.1 `SM-GAP-10` — is Date of Birth mandatory at `BC-10`?

**Classification: an unresolved external decision, internal to a frozen Rank 3 document. NOT a contradiction
created by `PRD-004`.**

Verified verbatim in `Student_Identity_PRD_v1.md` (Rank 3, frozen):

| Source | Line | Text |
|---|---|---|
| §2.2 *Global Profile* | 311 | DOB appears in the **Optional** field list |
| `SID-2.5` | 316 | *"Only the minimum information required for identity **SHALL** be mandatory."* |
| `SID-5.7` | 1111 | *"…the minimum data required to identify a person… A field not needed for that purpose **SHALL NOT** be added here merely because there is nowhere else convenient."* |
| **`SID-5.9`** | **1122** | *"Date of Birth **SHALL** be stored, because minor-safety obligations (`ID-6`) depend on it, and **SHALL NEVER** be publicly visible…"* |
| `SID-5.14` | 1135 | *"…where Date of Birth indicates a minor, guardian consent **SHALL** be linked before any social context is activated…"* |

**The tension is real and it is entirely inside `PRD-003`.** §2.2 lists DOB as Optional while `SID-5.9` says it
`SHALL` be stored. Both are in the same frozen document. `PRD-004` neither created nor inherited a defect here.

**Why this does not block admission.** `PRD-004` is deterministic under **both** resolutions:

| DOB state at `BC-10` | `PRD-004` behaviour | Requirement |
|---|---|---|
| Present, age < 18 | Guardian mandatory; enrollment refused without one | `SM-INV-3`, `SM-AC-31` |
| Present, age ≥ 18 | Guardian optional; enrollment succeeds | `SM-AC-32` |
| **Absent / `Unknown`** | **Treated as minor-status `Unknown` ⇒ guardian mandatory** — the safe closure | **`SM-INV-3` L314**, `SM-4.5a`, `SM-4.5b` |

`SM-INV-3` reads *"Guardian mandatory if age < 18, **or if minor-status is `Unknown`**"*. The three cases
**partition** the input space with no overlap and no hole, so no resolution of `SM-GAP-10` can change a
`PRD-004` outcome. `SM-4.5b` cites `SID-4.56` (*"a rule that cannot be checked SHALL be treated as unmet"*) and
`AP-3` for the fail-safe direction.

> **Requirement recorded, not decided:** resolving `SM-GAP-10` requires **the `BC-10` owner and a separate ADR**
> amending `PRD-003` — either §2.2 (move DOB out of Optional) or `SID-5.9` (soften `SHALL`). **This ADR does not
> make that decision and must not be read as making it.** Raised originally as `RF-17`.

### 3.2 `SM-GAP-11` — is `BC-26` a consumer of `SM-EV-1` and `SM-EV-5`?

**Classification: an internal inconsistency in a frozen Rank 4 document. NOT a contradiction created by
`PRD-004`.**

Verified verbatim in `LIBOORA_BOUNDED_CONTEXT_MAP.md` (Rank 4, frozen):

| Source | Line | Content |
|---|---|---|
| §8 event table | 404 | `BC-01` `enrollment.StudentEnrolled` → primary consumers **`BC-02, BC-23, BC-24, BC-26, BC-22`** |
| §8 event table | 405 | `BC-01` `enrollment.StudentProfileUpdated` → **`BC-23, BC-24, BC-26`** |
| §7 edge table | 316–335 | `BC-01`'s edges are `E-11`, `E-13`, `E-01`, `E-09`, `E-21`, `E-22`. **No `BC-01`→`BC-26` edge exists** |
| §7 preamble | **292** | *"If an edge is not in this table, it **does not exist** and adding it requires an ADR."* |

**§8 names a consumer that §7 says cannot be reached.** The contradiction is between two sections of the same
frozen document, at Rank 4, and predates `PRD-004`.

**Why this does not block admission.** `PRD-004` §7.4 **discloses the tension explicitly** (L808–815) and
declines to resolve it: `BC-26` is **not** listed as a consumer, and **no edge is asserted**. `SM-7.9` makes the
module publish facts to the bus without enumerating subscribers at runtime, so its behaviour is **identical**
under either resolution. `SM-7.12` closes the event set at ten and requires an ADR to extend it.

**`PRD-004` therefore adds no unauthorised edge.** Admitting it does not ratify §8's implicit edge.

> **Requirement recorded, not decided:** resolving `SM-GAP-11` requires **the architecture owner and a separate
> ADR** — either adding a `BC-01`→`BC-26` edge to §7 (the `ADR-0016` precedent, which added `BC-10` to `E-22`'s
> consumer list for exactly this reason) or removing `BC-26` from the two §8 rows. **This ADR does not make that
> decision.** Raised as findings `SR-04`/`SR-05`.

### 3.3 The other nine gaps

`SM-GAP-1`…`SM-GAP-9` are **absent external decisions**, not contradictions: retention duration, enrollment-number
format, `Inactive`-vs-seat policy, Parent Portal authorisation, member tags/notes, emergency contact, member-to-member
visibility, bulk-import rules, attendance-percentage formula. Each is labelled `PROPOSED GAP` in §10.6 with the
reason no source exists. **None leaves a mandatory behaviour undefined** — where a gap touches an executable path,
`PRD-004` closes it with a disclosed safe default (`SM-8.4a` records an interim **deny** for `TR-5` under `AP-3`)
rather than an invented rule.

### 3.4 One observation on citation precision — recorded, not acted upon

While investigating §3.1 I established that **`SID-2.7` is a requirement identifier** whose text is *"Gender
**SHALL** be optional…"* (`Student_Identity_PRD_v1.md` L318), whereas `PRD-004` §5.4 uses the token `SID-2.7` to
denote **section §2.7 *Profile composition***, whose requirements are `SID-2.38`…`SID-2.42`.

**This is not a defect in the admitted content, for three reasons:**
1. `PRD-004` L615 **spells out what it means** — *"`SID-2.7` (`PRD-003` §2.7 *Profile composition*, Rank 3,
   frozen)"* — so the referent is unambiguous to a reader.
2. Every load-bearing citation alongside it is to the **requirement** IDs `SID-2.38`–`SID-2.41`, which are the
   operative rules and are cited correctly throughout (L595–598, L636, L1105, `LMD-22`).
3. The authority relied upon — that composition of `BC-02`/`BC-03`/`BC-04`/`BC-05` read models is permitted
   without a §7 edge — **is genuinely established** by §2.7's contributor table and by `BC-10` performing exactly
   that composition with no §7 edge to any of the four.

**It is nevertheless imprecise**, because `SID-2.7` as an identifier means something else. It is recorded here as
an **observation for a future editorial pass**, not fixed: `PRD-004` is being admitted **exactly as verified**,
and amending its prose during admission would break the byte-identity this ADR relies on. After freeze, this
falls under `PRD_LIFECYCLE.md`'s *"clarifying wording with no change in meaning — changelog entry"* row, or its
*"typo… fix directly"* fast path. **No requirement changes either way.**

---

## 4. Decision

**`Student_Management_PRD_v1.md` v1.2 is admitted to the documentation baseline at Rank 3 as the authoritative
specification for `BC-01` Enrollment**, exactly as verified, together with `PRD-004_ALIGNMENT_REPORT.md` v1.1 as
its validation record (not part of the specification).

1. **Version is preserved at v1.2.** Freeze confers status; it does not renumber a document. `PRD-003` was
   admitted at v1.0 and remained v1.0. Baseline §7 step 2 increments a version when *content* changes — and no
   requirement, criterion, invariant, event, API, ownership row or scope statement changes here.
2. **Rank 3, non-overlapping.** Rank 3 now holds **four** module baselines: Authentication governs `BC-18`;
   Student Identity governs `BC-10`; the Library PRD governs Library Management; **`PRD-004` governs `BC-01`
   Enrollment** and, as an application capability, the Library Members Directory read composition. Where
   `PRD-004` appears to constrain another context it states *what must be true*; the owning context remains the
   sole authority on *how it is decided*.
3. **No ranked document is amended.** Unlike `ADR-0011`, this admission required no structural change: no BC Map
   edit, no `MP-GBR-*` change, no dependency-law exception, no new context, no new edge.
4. **The registers are closed as declared:** ten `SM-EV-*` (`SM-7.12`), 31 contexts unchanged, `SM-1.8` and
   `LMD-24` normative tables amendable only by ADR.
5. **`SM-GAP-10` and `SM-GAP-11` remain OPEN.** Admission does **not** resolve, ratify or close either. Each
   requires its own ADR from its named owner (§3.1, §3.2). Admitting a PRD that *discloses* a defect in a
   higher-ranked document is not the same as endorsing that defect.
6. **Baseline identifier advances to `BASELINE-2026-08-04-C`** per §7 step 4 — a Rank 1–3 document changed
   version, in the sense that a Rank 3 document now exists where none did.

---

## 5. Options considered

| Option | Why not chosen |
|---|---|
| **Admit at v1.0**, renumbering to match "first frozen release" | Would rewrite a version history that three review reports cite. v1.2 *is* the verified artefact; renaming it would break every citation and imply content changed. Rejected — and explicitly rejected by the freeze authorisation |
| **Resolve `SM-GAP-10`/`SM-GAP-11` inside this ADR** | Both are defects in documents **this ADR does not own**. Deciding them here would amend `PRD-003` §2.2/§5.2 and BC Map §7/§8 as a side effect of admitting an unrelated PRD — the exact silent-amendment failure `PRD_LIFECYCLE.md` L177 prohibits. **Rejected** |
| **Withhold freeze until both gaps close** | Both need owners outside `BC-01`. `PRD-004` is deterministic under every resolution (§3.1, §3.2), so blocking would stall a verified specification on decisions it cannot make and does not depend on |
| **Admit at Rank 4 or 5** | `PRD-004` is a module PRD owning a `[CORE]` context. Rank 3 is where the other three module baselines sit. A lower rank would place a specification beneath the boundary documents that merely *describe* its context |
| **PRD-local `Status: FROZEN` with no baseline row** | Contradicts Stage 7 and `PRD_REGISTRY.md` §2.1. Would make `PRD-004` the only self-declaring PRD and leave the governance layer recording it as `DRAFT`. **Rejected** |
| **Fix the `SID-2.7` citation during admission** (§3.4) | Would change the bytes that were independently verified, invalidating the review chain this ADR rests on. Recorded for a post-freeze editorial pass instead |

---

## 6. Consequences

### 6.1 Immediate

- `PRD-004` becomes **`FROZEN`**. Any change to it now requires **an ADR before the change** (baseline §7 step 1).
- Rank 3 gains a fourth module baseline. `PRD-005`…`PRD-008` and `IMPL-214` (`E-13` ACL) may now cite it as
  settled authority rather than as a draft.
- `SM-*` identifiers become **stable**. `SM-1.8`, `LMD-24` and §7.4's event set may not be amended by revision alone.
- The `[CORE]` context with the most downstream dependents in the Library cluster acquires a frozen specification.

### 6.2 What does **not** change

- **No requirement identifier is added, removed, renumbered or reworded.** Registers stay at 251 base / 266 total,
  32 acceptance criteria, ten events, 11 gaps.
- **No global business rule changes.** Unlike `BASELINE-2026-08-04`, no `MP-GBR-*` is touched.
- **No architecture document changes.** BC Map, Dependency Matrix, `ARCHITECTURE_RULINGS.md` untouched.
- **No code changes.** Implementation remains **entirely unstarted** — 0 of 24 tasks.
- **No context count change.** 31 before, 31 after.

### 6.3 Carried forward

| Item | Owner | Requires |
|---|---|---|
| **`SM-GAP-10`** DOB mandatory at `BC-10`? | `BC-10` owner | **A separate ADR** amending `PRD-003` §2.2 or `SID-5.9` |
| **`SM-GAP-11`** `BC-26` consumer of `SM-EV-1`/`SM-EV-5`? | Architecture owner | **A separate ADR** amending BC Map §7 or §8 |
| `SM-GAP-1`…`9` | Named per gap in §10.6 | A source decision; none blocks implementation start |
| §3.4 `SID-2.7` citation precision | `PRD-004` editor | Post-freeze clarifying pass; changelog entry, no ADR |
| 13 untraced requirements (5.4%) | `PRD-004` editor | Enumerated in §10.5.1; a citation, not a rule change |
| **0 of 32 acceptance criteria proven by test** | Implementation | Stage 9. **`PRD-004` is `FROZEN`, not `VERIFIED`** |

---

## 7. Compliance

| Rule | Satisfied |
|---|---|
| `PRD_LIFECYCLE.md` Stage 7 — freeze conferred by a baseline §3 row | ✅ Row added in the same commit |
| `DOCUMENTATION_BASELINE.md` §7 step 1 — **ADR before the change** | ✅ This ADR is the first artefact of the sequence |
| §7 step 2 — version incremented, changelog updated, same commit | ✅ **v1.2 preserved** (no content change); changelog entry added |
| §7 step 3 — declaration updated in the same commit | ✅ One coherent commit |
| §7 step 4 — baseline identifier changes | ✅ → `BASELINE-2026-08-04-C` |
| `PRD_LIFECYCLE.md` L177 — a frozen document is never silently modified | ✅ No frozen document modified at all |
| Stage 3 — rejected findings recorded with reasons | ✅ 6 across three reviews |
| Stage 4 — conflicts closed **or deferred with a reason and an owner** | ✅ §3.1, §3.2 name both owners |
| BC Map L292 — an edge absent from §7 needs an ADR | ✅ **No edge added.** §3.2 declines to add one |
| `SID-4.56` — an unchecked rule is unmet, not satisfied by intent | ✅ Every count tool-verified; 0 tests ≠ verified, hence `FROZEN` not `VERIFIED` |
| `X-13`, `ID-1` never waived | ✅ Strengthened by `SM-10.9`; no credential surface added |

---

## 8. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-04 | Accepted. Admits `Student_Management_PRD_v1.md` **v1.2** to the baseline at **Rank 3** as the authoritative specification for `BC-01` Enrollment, **exactly as verified and with the version preserved**. No ranked document amended, no requirement changed, no edge added, no context created, no global business rule touched, no code modified. **`SM-GAP-10` and `SM-GAP-11` investigated in §3 and left OPEN**, each with its classification, verbatim sources, owner, and the requirement for a separate ADR recorded rather than a decision invented. One citation-precision observation (`SID-2.7` denotes §2.7, while `SID-2.7` as an identifier reads *"Gender SHALL be optional"*) recorded in §3.4 for a post-freeze editorial pass, deliberately not fixed during admission so the verified bytes are preserved. Baseline advances to `BASELINE-2026-08-04-C` |
