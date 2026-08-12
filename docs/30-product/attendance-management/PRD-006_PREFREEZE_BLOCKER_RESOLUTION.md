# `PRD-006` Attendance Management — Pre-Freeze Blocker Resolution

| Field | Value |
|---|---|
| **Document** | Pre-freeze blocker investigation and disposition for `PRD-006` / `BC-03` |
| **Type** | Decision/reconciliation record. **Not a freeze, not a baseline row, not an ADR.** Unranked; confers nothing |
| **Subject** | [`PRD-006_ATTENDANCE-MANAGEMENT.md`](./PRD-006_ATTENDANCE-MANAGEMENT.md) **v1.3 — DRAFT** |
| **Subject hash** | `93ab1c60d740c4e0…464ab97b` — **unmodified by this record** |
| **Predecessor** | [`PRD-006_STAGE7_FREEZE_READINESS.md`](./PRD-006_STAGE7_FREEZE_READINESS.md) v1.0 — verdict 🚫 BLOCKED |
| **Version** | v1.0 |
| **Date** | 2026-08-04 |
| **Outcome** | **3 of 6 blockers resolved by investigation. 1 requires a product-owner decision. 2 are mechanical and await that decision.** `PRD-006` is **not yet eligible** for Stage 7 |
| **Prepared** | [`ADR-0021`](../../00-governance/adr/ADR-0021-attendance-management-configurable-defaults.md) — **Proposed**, not accepted |

---

## 1. What this record does

The Stage 7 review returned **BLOCKED** on six items. This record investigates each against repository governance
and disposes of it — by **resolution**, by **referral to a named owner**, or by **preparing the ADR** that
governance requires.

**It resolves nothing by choosing a value.** Where a decision belongs to an owner, the decision is *framed and
put in front of them*, which is the most this record is permitted to do.

| Blocker | Disposition |
|---|---|
| **B-6** `ATT-GAP-017` — 7 configurables without defaults | 🟡 **Investigated; ADR-0021 prepared.** Requires product-owner acceptance |
| **B-1** No admitting ADR | 🟡 **Partially advanced** — `ADR-0021` prepared; the *admitting* ADR remains a separate, later act |
| **Stage 3 conditional finding** | ✅ **RESOLVED — no disposition outstanding** |
| **Stage 4 conditional finding** | ✅ **RESOLVED — disposition complete and correctly recorded** |
| **Q — do CONDITIONAL verdicts permit freeze?** | ✅ **ANSWERED FROM GOVERNANCE — yes** |
| **B-2…B-5** baseline row, §4, index, registry | 🔴 **Remaining** — forbidden now, and downstream of B-6 |

---

## 2. `ATT-GAP-017` — investigated exhaustively, and why it cannot be closed here

### 2.1 The question, quoted from the register

> **`ATT-GAP-017`** — What are the default values and allowed ranges for the seven numeric configurables marked
> unresolved in §16.3 (`ATT-CFG-005`, `006`, `011`, `012`, `014`, `019`, `023`)? · **No Rank 1–5 source.**
> `LIB-16.2` requires *every* setting to have a documented default · **Owner: Product owner**

Note what is being asked: **defaults *and* allowed ranges**. Both are missing. That distinction decides §2.4.

### 2.2 The search for an authoritative source — negative, and verified negative

The PRD asserts *"no Rank 1–5 source."* An assertion by the document under review is not evidence, so it was
tested independently across `docs/30-product/`, `docs/10-architecture/`, `docs/00-governance/` and
`docs/20-configuration/`, excluding `attendance-management/` itself.

| Setting | Concept searched | Authoritative value found |
|---|---|---|
| `ATT-CFG-005` | QR rotation interval | **None** |
| `ATT-CFG-006` | QR validity window / code expiry | **None** — `AUTH-*` expiry rules govern OTP challenges in `BC-18`, a different artefact in a different context |
| `ATT-CFG-011` | GPS acceptance radius | **None** — no radius, geofence or distance value anywhere |
| `ATT-CFG-012` | Minimum location accuracy | **None** |
| `ATT-CFG-014` | Face match confidence | **None** — zero hits |
| `ATT-CFG-019` | OCR high-confidence threshold | **None** — zero hits |
| `ATT-CFG-023` | Correction window | **None** — zero hits |

**The PRD's claim is confirmed.** Seven values, zero authoritative sources.

> **The near-miss worth recording.** The Authentication PRD *does* specify code-expiry behaviour, and
> `CONFIGURATION_GUIDE.md` gives OTP validity a concrete figure. Reusing it for `ATT-CFG-006` would look like
> sourcing a value rather than inventing one. It would be neither: an OTP is a one-time secret sent to a phone in
> `BC-18`; a Dynamic QR code is a rotating display artefact in `BC-03`. Same word, different threat model,
> different context, different owner. Borrowing the number would import a security parameter across a bounded
> context boundary and dress an invention as a citation.

### 2.3 The precedent that *looks* decisive, and what it actually establishes

The repository has faced this exact problem twice, and both times solved it — which is why it had to be
examined rather than waved at.

| Precedent | What happened |
|---|---|
| **`ACN-001`** (Authentication) | OTP rate limits unspecified, *"no assumed values."* Closed by specifying the policy **structure** normatively; thresholds became `CFG-1`…`CFG-4` |
| **`AR-4`** (Invitation Security) | Six security parameters deferred: *"inventing security parameters without a mandate is how unreviewable magic numbers enter a codebase."* Deferral **lifted** once the product owner supplied the Library PRD |
| **`DOCUMENTATION_AUDIT-001`** | Twelve `CFG-*` values re-anchored to NIST SP 800-63B, OWASP and market analysis; **six changed** |

**What the precedents establish:** a value may be set once it is **anchored** — to a named external standard or a
stated operational analysis — and recorded in `CONFIGURATION_GUIDE.md`.

**What they do not establish:** that a *reviewer* may perform the anchoring. In every case the anchor came from
an external standard **or** from the product owner supplying missing input. `AR-4`'s deferral was lifted *"because
the Library PRD §§1–25 has been received"* — new authority arrived. **No new authority has arrived for
`ATT-GAP-017`.**

### 2.4 Why `CONFIGURATION_GUIDE.md` cannot absorb these seven

The Configuration Guide is the obvious home — it is **Rank 7** and exists for exactly this. It cannot take them,
for a reason that is structural rather than procedural.

Baseline §4, Rank 7: *"Operating values **within the envelope** 1–3 define."*
Guide header: *"Subordinate to the PRDs. This guide sets values **within** the envelope they define; **it cannot
change the envelope**."*

**An envelope is a declared range.** For all seven, §16.3's *Allowed domain* column reads:

> `Bounded duration — **unresolved**` · `Bounded distance — **unresolved**` · `Bounded 0–1 — **unresolved**`

**The envelopes do not exist.** `Bounded 0–1` is a type, not a range: it excludes 1.7 and admits 0.01 and 0.99
equally, and a face-match threshold of 0.01 authorises impersonation. Writing a Guide entry would require
inventing the envelope first — which is precisely what Rank 7 forbids.

Contrast `ICFG-2`: *"**7 d**, range 1 h – 30 d"* — the PRD supplied the envelope, the Guide set the value inside
it. That division of labour is unavailable here because half of it is missing.

### 2.5 The PRD forbids substitution normatively

Even setting rank aside, `ATT-BR-043` is a **MUST**-class rule in the document under review:

> A configurable whose Default column names an unresolved gap has **no default value, and no value **SHALL** be
> substituted for it** — not zero, not a framework default, not a value copied from another tenant, another mode,
> another product or an example in this document.

*"Another product"* forecloses the `CFG-*` borrowing route explicitly. To supply the seven values, this record
would have to **violate a normative rule of the specification it is trying to make freezable** — resolving a
blocker by breaking the document.

### 2.6 Disposition — 🟡 REFERRED, with the decision framed

**`ATT-GAP-017` remains OPEN.** Not resolved, not narrowed, not downgraded.

What *has* changed is that it is no longer an open-ended question. [`ADR-0021`](../../00-governance/adr/ADR-0021-attendance-management-configurable-defaults.md)
is **prepared and Proposed**, and it puts a bounded decision to the product owner: it presents the four options
the repository's own precedents support, records the negative search, and states what each option costs. **It
proposes no values.**

Governance requires this shape. `PRD_LIFECYCLE.md` Stage 4's gate is *"conflicts closed or explicitly deferred
**with a reason and an owner**"* — and instruction 7 says to prepare the ADR rather than bypass governance.

---

## 3. Stage 3 conditional finding — ✅ resolved, nothing outstanding

**Verdict as issued:** ⚠️ CONDITIONALLY ALIGNED — 21 of 22 checks PASS, **1 GAP-BEARING (Check 12)**.

Investigated for outstanding disposition:

| Component | Finding | Outstanding? |
|---|---|---|
| Architectural conflicts vs Ranks 1–5 | **0** | **No** |
| Check 12 GAP-BEARING | Gap-bearing, **not** conflict-bearing — the gaps are recorded with owners | **No** |
| Internal documentation defect `F-1` (§10.1) | A stale register row; disclosed | **No** — cosmetic, disclosed |
| 20 open gaps | Each with a named owner; 2 block a *mode*, **none blocks Stage 3** | **No** |
| 6 rejected candidate findings | Recorded as rejected **with reasons**, per `PRD_LIFECYCLE.md` L104 | **No** |

**Disposition: RESOLVED.** The review's own words: Stage 3 asks whether the *specification* respects the
architecture, and *"refusing to build an unauthorised capability is respect, not failure."*

**The verdict stays ⚠️ CONDITIONAL.** Nothing here upgrades it — the condition is the presence of gaps, which is
a true description that remains true.

---

## 4. Stage 4 conditional finding — ✅ disposition complete

**Verdict as issued:** ⚠️ CONDITIONALLY PASSED — 5 of 6 gate checks PASS, **1 FAILS**, 8 findings.

| Finding | Severity | Disposition | Outstanding? |
|---|---|---|---|
| `RQ-1` | HIGH | **MITIGATED, not resolved** — 5 obligations added specifying behaviour in the absence of a value; **no default invented** | 🟡 **Yes** — = `ATT-GAP-017`, §2 |
| `RQ-2`…`RQ-8` | MED/LOW | **RESOLVED** | No |
| 5 rejected | — | Recorded as rejected with reasons | No |

Re-verification after correction: registers **ALL PASS** at 516 identifiers, coverage **285/285 = 100%**, **0
orphan criteria**, gate **still satisfied**, verdict **unchanged**.

**Disposition: COMPLETE.** All eight findings are dispositioned. The single outstanding item is `RQ-1`, which
**is** `ATT-GAP-017` — one blocker, not two.

### 4.1 The one item genuinely outstanding, correctly recorded

The Stage 4 record states a **Stage 4 re-review remains for an independent reviewer**. That is a process
recommendation, not an unmet gate condition — the gate is *"conflicts closed or explicitly deferred with a reason
and an owner,"* and check 3's failure is deferred with both. Recorded here so it is not mistaken for a blocker,
and not dismissed either.

---

## 5. Do CONDITIONAL Stage 3/4 verdicts permit freeze? — ✅ **Yes**, from governance

The Stage 7 review referred this as an open question. It is answerable from existing governance, and the answer
is **yes** — established four independent ways, none requiring a new rule.

**1. The gates are defined by artefact and disposition, not by grade.** Neither stage's gate mentions a verdict
letter:

> **Stage 3 gate:** *a written alignment record naming every conflict and its disposition.*
> **Stage 4 gate:** *conflicts closed **or explicitly deferred with a reason and an owner**.*

Stage 4's gate **anticipates unresolved items** and states the conditions under which they are acceptable.
`PRD-006` meets them: 19 of 19 open gaps have named owners.

**2. Stage 7's own gate is silent on prior grades.** It requires a baseline row. It does not enumerate verdict
letters as entry conditions.

**3. The baseline itself carries open gaps — by design.** §6 *"Known gaps carried by this baseline"* is a
standing table, and two entries are decisive:

- **`GCP-05`** — a contradiction **inside `PRD-003` (Rank 3, frozen)**: `SID-5.9` says DOB *"**SHALL** be stored"*
  while §2.2 lists it Optional. **OPEN**, resolution requires the `BC-10` owner and a separate ADR.
- **`GCP-06`** — a contradiction **inside the BC Map (Rank 4, frozen)**: §8 names `BC-26` a consumer, §7 declares
  no such edge, and the same document says an edge absent from §7 *"does not exist."*

**Documents at Rank 3 and Rank 4 are frozen while containing unresolved internal contradictions.** If freeze
required a clean verdict, neither could hold its rank.

**4. The direct precedent.** `ADR-0020` §3 is titled *"The open items — **investigated, not resolved**"* and
admitted `PRD-007` at Rank 3 with **14 open `SEAT-GAP-*`**, including `SEAT-GAP-009`, a structural dependency on
this very PRD.

### 5.1 The honest limit of that answer

`PRD-007` entered Stage 7 with **A — PASS** at Stages 4, 5 and 6. **No precedent exists for freezing on an
explicitly CONDITIONAL verdict.** The four arguments above establish that *open items* do not bar freeze; they do
not establish that a *conditional verdict* is identical to a pass with deferrals.

On the evidence they are the same thing under two names — `PRD-006`'s condition **is** a deferral with a reason
and a named owner, which is exactly what Stage 4's gate permits. But that is an inference, and inference is how
governance gets invented quietly.

**Recorded as a supported reading, referred to the governance owner for confirmation in `ADR-0021` §5.**

---

## 6. The blocker that survives all of this

§5 establishes that open gaps do not bar freeze. **`ATT-GAP-017` is not barred because it is open.** It is
barred because of what it *causes*, and the distinction is the whole of this record.

> Seven rows carry `ATT-GAP-017` instead of a value … **This is a live breach of `LIB-16.2`** (Rank 3, Library
> PRD: *"Every setting **MUST** have a documented default"*).
> — `PRD-006` L1187, the document's own words about itself

Measured: **24/24 structurally complete · 17/24 with a concrete default and closed domain · 7/24 with neither.**

**Every other open gap in `PRD-006` is an absent decision. This one is an active breach of a peer-rank MUST.**
`GCP-05` and `GCP-06` are contradictions *internal* to their documents. `ATT-GAP-017` puts `PRD-006` in violation
of a **different Rank 3 document's** normative rule — and freeze would confer Rank 3 on the violation itself.

**Measured, this would be a first.** Zero occurrences of a self-declared live breach in
`PRD-SEAT-MANAGEMENT.md`, `PRD-MEMBERSHIP-MANAGEMENT.md`, `Student_Management_PRD_v1.md` or
`Library_PRD_v1.md`. One in `PRD-006`. **No frozen PRD in this repository carries one**, so there is no
precedent to rely on and none to distinguish.

### 6.1 What the mitigation does and does not achieve

`ATT-BR-044` demonstrates that `LIB-16.2`'s **second** sentence — *"a library that has changed nothing MUST be
fully operable"* — is satisfied **in fact**: all seven belong to capabilities **off by default**, two are blocked
from being built at all, and a day-one tenant uses Manual, which has concrete defaults. `ATT-FR-149`/`150` make
the absence fail closed. The breach is **latent**: unreachable without an Owner deliberately enabling a mode
whose values the document refused to invent.

**The first sentence remains breached.** *"Every setting MUST have a documented default"* is unqualified. Seven
do not have one.

**This is why the item is a genuine blocker and not paperwork** — and equally why it is *safe to carry in a
DRAFT*, which is exactly where it is.

---

## 7. Blockers: resolved, remaining, referred

| # | Blocker | State | Owner |
|---|---|---|---|
| **1** | Stage 3 conditional finding — outstanding disposition? | ✅ **RESOLVED** — none outstanding | — |
| **2** | Stage 4 conditional finding — outstanding disposition? | ✅ **RESOLVED** — 8/8 dispositioned; `RQ-1` = `ATT-GAP-017` | — |
| **3** | Do CONDITIONAL verdicts bar freeze? | ✅ **ANSWERED — no**, from four governance sources | Governance owner to confirm |
| **4** | `ATT-GAP-017` — 7 configurables, live `LIB-16.2` breach | 🟡 **REFERRED** — investigated exhaustively, `ADR-0021` prepared | **Product owner** |
| **5** | Admitting ADR for the freeze | 🔴 **REMAINING** — a separate, later act after #4 | Architecture owner |
| **6** | Baseline row · §4 · ADR-INDEX · Registry | 🔴 **REMAINING** — forbidden now; downstream of #4 and #5 | Governance owner |

### 7.1 Decisions requiring owner approval

| Decision | Owner | Vehicle |
|---|---|---|
| **D-1** Choose an option for the 7 configurable defaults **and their ranges** | **Product owner** (security input for `ATT-CFG-014`) | `ADR-0021` §4 |
| **D-2** Confirm CONDITIONAL verdicts permit Stage 7 | **Governance owner** | `ADR-0021` §5 |
| **D-3** Accept or reject `ADR-0021` | Product + architecture owners | ADR acceptance |
| **D-4** *(after D-1…D-3)* Author the admitting ADR and the baseline row | Governance owner | A later, separate act |

---

## 8. Is `PRD-006` now eligible for Stage 7? — **No**

**Not eligible.** Two conditions are unmet, and neither can be met by this record:

1. **`ATT-GAP-017` is unresolved**, so the live `LIB-16.2` breach stands. Only the product owner can close it.
2. **No baseline row and no admitting ADR exist**, and creating them is forbidden — and would be premature
   regardless, since the ADR must postdate D-1.

**What changed:** the path is now unambiguous and short. Before this record, `ATT-GAP-017` was an open-ended
question with no analysis of whether the repository could answer it. It is now a **single bounded decision with
four costed options** in front of a named owner, with the negative search recorded so nobody repeats it.

**Eligibility follows from D-1, mechanically.** Once the product owner supplies defaults *and* ranges: §16.3 is
updated (a PRD content change — DRAFT, so no ADR needed for the edit itself), Stage 4 check 3 moves 17/24 → 24/24
and **PASSES**, the `LIB-16.2` breach closes, `ATT-GAP-017` closes, the ledger becomes **3 resolved / 1 narrowed /
17 open**, `IMPL-667` unblocks, and the remaining work is the ordinary freeze sequence.

---

## 9. What this record deliberately did not do

| Not done | Why |
|---|---|
| Supply any of the 7 values | §0.4, `ATT-BR-043`, and instruction 2. Seven numbers would have "resolved" this in one edit |
| Borrow `CFG-*` or `ICFG-*` values | Cross-context import of a security parameter; `ATT-BR-043` names *"another product"* explicitly |
| Add the 7 to `CONFIGURATION_GUIDE.md` | Rank 7 sets values **within** an envelope; these envelopes are themselves unresolved |
| Invent ranges so the Guide *could* take them | Inventing the envelope is the same act one step removed |
| Modify `PRD-006` | It is the subject; hash unchanged, and §6 of the readiness review depends on that |
| Modify `PRD-007` or any frozen document | Instruction 5; all verified byte-identical |
| Modify `prd007_traceability.py` | Its exit 1 is pre-existing and its 2 problem classes are unchanged. Fixing another module's gate is not this record's work |
| Widen the `prd006` `ALLOWED` list to a directory | One named file only (§10.1); a stray `ATT-` elsewhere in governance still fails |
| Resolve any architectural gap | Instruction 6. **18 open, 1 narrowed — unchanged** |
| Upgrade either CONDITIONAL verdict | `PRD_LIFECYCLE.md` L104 |
| **Accept** `ADR-0021` | An ADR is accepted by its deciders. It is **Proposed** |
| Create the baseline row or mark FROZEN | Instruction 8 |

---

## 10. Verification

| Claim | Method | Result |
|---|---|---|
| No Rank 1–5 source for the 7 values | Repo-wide search, 4 concept families, excluding the module | **0 sources** |
| Config Guide is Rank 7, envelope-bound | Baseline §4 + Guide header | Confirmed |
| All 7 domains are themselves unresolved | Parsed §16.3 *Allowed domain* column | **7/7 unresolved** |
| `ATT-BR-043` forbids substitution | Quoted from PRD L1199 | Confirmed |
| Baseline carries open gaps in frozen docs | Baseline §6 `GCP-05`, `GCP-06` | Confirmed |
| `PRD-007` frozen with 14 open gaps | `ADR-0020` §3.1 | Confirmed |
| No frozen PRD carries a live breach | `grep -c 'live breach'` across 4 frozen PRDs | **0, 0, 0, 0** vs `PRD-006` **1** |
| Gap ledger unchanged | Parsed §32.1 verdict cells | **2 · 1 · 18** |
| Stage 5 / Stage 6 gates still pass | Both tools re-run **after** `ADR-0021` was authored and its `ALLOWED` entry added | **exit 0 · exit 0** — see §10.1 |
| Collision check still fires on a genuine stray | Negative control: probe file with `ATT-FR-999` in `docs/00-governance/` | **exit 1** with probe, **exit 0** without |
| `prd007_traceability.py` not worsened | Failing **problem-class** count before vs after | **2 · 2** — unchanged, pre-existing |
| `ADR-0021` defines no identifier | Register-row form, `ATT-*` and `SEAT-*` | Cites only; **0** definitions |
| `PRD-006` unmodified | SHA-256 | `93ab1c60…` unchanged |

### 10.1 A gate this record's own ADR broke, and how it was repaired

**Recorded because it happened after §10's first draft and would otherwise read as a stale pass.**

`tool/docs_check/prd006_traceability.py` was at **exit 0** before `ADR-0021` existed and went to **exit 1** the
moment it did: the collision scan flags any `ATT-` token outside `attendance-management/`, and an ADR *about* the
attendance configurables cannot avoid naming them.

The fix is the repository's **existing** convention, not a new exemption — `prd005_traceability.py` lists
`ADR-0019` for `MM-*` and `prd007_traceability.py` lists `ADR-0020` for `SEAT-*`, both on the recorded reasoning
that *“a citation is not a collision — a collision would be another register **defining** an identifier.”* The
`ALLOWED` list gained **one named file**. `ADR-0021` defines none.

**Deliberately not done:** the list was not widened to `docs/00-governance/` (negative control above proves a stray
still fails); `DOCUMENTATION_BASELINE.md`, `PRD_REGISTRY.md` and `ADR-INDEX.md` were **not** added despite both
precedents listing all three, because those were *freezes* and this is not — none has been modified, and
pre-authorising an unmade edit would let a later change pass unnoticed; the duplicate-definition, registered-prefix
and §2F count checks are untouched; and `prd007_traceability.py` was not modified at all.

Full disclosure: `ADR-0021` §7.2a.

---

## 11. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0.1** | 2026-08-04 | **Corrects §10 and adds §10.1 after authoring `ADR-0021` broke a gate that §10 had already recorded as passing.** `prd006_traceability.py` went **exit 0 → exit 1** the moment the ADR existed, because its collision scan flags any `ATT-` token outside `attendance-management/` and an ADR *about* the attendance configurables cannot avoid naming them. Repaired by the repository's **existing** convention — the `ALLOWED` list gained **one named file**, matching `prd005_traceability.py`'s listing of `ADR-0019` and `prd007_traceability.py`'s of `ADR-0020`, on the recorded reasoning that *“a citation is not a collision”*; `ADR-0021` **defines no identifier**. Adds three verification rows: a **negative control** proving a stray `ATT-FR-999` probe elsewhere in `docs/00-governance/` still returns exit 1; confirmation that `prd007_traceability.py`'s failing **problem-class** count is **unchanged at 2** and pre-existing; and confirmation that `ADR-0021` defines **0** `ATT-*` and **0** `SEAT-*` identifiers. Records in §9 that `prd007_traceability.py` was **not** modified and that the `ALLOWED` list was **not** widened to a directory, and that `DOCUMENTATION_BASELINE.md`/`PRD_REGISTRY.md`/`ADR-INDEX.md` were deliberately **not** added despite both precedents listing all three — those were *freezes*, this is not, none has been modified, and pre-authorising an unmade edit would let a later change pass unnoticed. **The §10 row was corrected rather than left standing**: it was true when written and false by the time the work finished, which is the failure mode `GCP-01`/`GCP-07`/`GCP-08` record as a class. |
| **v1.0** | 2026-08-04 | Created to dispose of the six Stage 7 blockers. **Three resolved by investigation, one referred, two remaining.** Stage 3's conditional finding has **no outstanding disposition** (0 architectural conflicts; Check 12 is gap-bearing, not conflict-bearing; `F-1` cosmetic and disclosed; 6 findings recorded as rejected with reasons). Stage 4's disposition is **complete** — 8 of 8 findings dispositioned, the sole outstanding item `RQ-1` being `ATT-GAP-017` itself, so one blocker rather than two; the outstanding independent Stage 4 **re-review** is recorded as a process recommendation, not an unmet gate condition. **Answered from existing governance that CONDITIONAL verdicts do not bar freeze** — Stage 3's gate requires a record of dispositions and Stage 4's explicitly permits *"deferred with a reason and an owner"*; Stage 7's gate names no verdict grade; baseline §6 carries `GCP-05` and `GCP-06`, unresolved contradictions **inside frozen Rank 3 and Rank 4 documents**; and `ADR-0020` §3 admitted `PRD-007` with 14 open gaps under the heading *"investigated, not resolved"* — while recording the **honest limit** that no precedent exists for an explicitly CONDITIONAL verdict, since `PRD-007` was A—PASS throughout, and referring that confirmation to the governance owner rather than inferring it. **`ATT-GAP-017` was investigated exhaustively and deliberately not closed**: a repo-wide search across four concept families found **zero** authoritative values, independently confirming the PRD's own claim; the `ACN-001`/`AR-4`/`DOCUMENTATION_AUDIT-001` precedents were examined and found to establish that values may be **anchored**, not that a reviewer may do the anchoring — in every case the anchor came from an external standard or from the product owner supplying new input, and **no new authority has arrived**; `CONFIGURATION_GUIDE.md` cannot absorb the seven because Rank 7 sets values *within an envelope* and **all seven envelopes are themselves marked unresolved**, so a Guide entry would require inventing the range first; and `ATT-BR-043` forbids substitution normatively, naming *"another product"* explicitly, which forecloses borrowing the `CFG-*`/`ICFG-*` figures. Records the near-miss that the Authentication PRD's code-expiry values would have *looked* like a source for `ATT-CFG-006` while actually importing a security parameter across a bounded-context boundary. Isolates **why this gap blocks when eighteen others do not**: it is not an absent decision but a **live breach of Rank 3 `LIB-16.2`** — measured **17/24 with defaults, 7/24 with neither** — which freeze would confer Rank 3 upon, and which would be **the first such breach in a frozen PRD in this repository** (measured: 0 in each of the four frozen module PRDs, 1 in `PRD-006`); `ATT-BR-044` satisfies `LIB-16.2`'s *second* sentence in fact and makes the breach latent, but the first sentence is unqualified and remains breached. Prepared **[`ADR-0021`](../../00-governance/adr/ADR-0021-attendance-management-configurable-defaults.md) — Proposed, not accepted**, presenting four costed options and **proposing no values**. Concludes `PRD-006` is **NOT yet eligible** for Stage 7, and states the mechanical consequence of the owner's decision: check 3 moves 17/24 → 24/24, the breach closes, the ledger becomes 3/1/17, `IMPL-667` unblocks. **Nothing frozen, no baseline row, no value invented, no gap resolved, no verdict re-graded, `PRD-006` byte-identical, and no frozen or authoritative document modified.** |
