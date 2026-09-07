# PRD-006 — Which decisions require an ADR: a determination against the repository's own rules

| Field | Value |
|---|---|
| **Document** | Phase 4 governance/ADR requirement determination |
| **Version** | v1.0 |
| **Date** | 2026-08-04 |
| **Method** | Every candidate tested against the **two** ADR triggers this repository actually states. Nothing tested against usefulness |
| **ADRs created** | **2** — `ADR-0022`, `ADR-0023`, both **`Proposed`** |
| **ADRs accepted** | **0** |
| **Candidates rejected** | **6** |

> **The governing constraint.** *"Do NOT create an ADR merely because it seems useful."* Six candidates below
> would each have made a plausible ADR. Each is rejected because it fails the repository's stated triggers, not
> because it lacked merit.

---

## 1. The two triggers, quoted

There are exactly two rules in this repository that require an ADR. Both were located by search, not assumed.

| # | Rule | Source |
|---|---|---|
| **T1** | *"A decision that changes **structure, ownership, a boundary, or a platform-wide rule** requires an ADR **before** implementation."* | `ADR-INDEX.md` Process step 1 |
| **T2** | *"A change to any **Rank 1–5** document requires an ADR **before** the change."* | `DOCUMENTATION_BASELINE.md` §7 step 1 |

Two derived instances restate T1/T2 for specific cases and are not separate triggers:

* BC Map **L292** — *"If an edge is not in this table, it does not exist and adding it requires an ADR."*
* `PRD_REGISTRY.md` §8.6 — *"adding a bounded context to a PRD's ownership… requires an ADR."*

`PRD_OWNERSHIP_MODEL.md` §2.2 maps both triggers to the same role: **Architecture Owner**.

### 1.1 What is *not* a trigger

Neither rule fires on: recording a decision already made; documenting a gap; requesting an owner decision;
producing a review or gate record; or an unranked document changing. **`PRD-006` is unranked and admitted to no
baseline**, so editing `PRD-006` itself does not fire T2. This matters repeatedly below.

---

## 2. The determination

| # | Candidate decision | T1? | T2? | Verdict |
|---|---|---|---|---|
| 1 | `ATT-GAP-010` — may `BC-03` hold a `FileRef` from `BC-29`? | ✅ boundary | ✅ BC Map is **Rank 4** | ✅ **ADR REQUIRED** → `ADR-0022` **Proposed** |
| 2 | `ATT-GAP-011` — which context owns OCR/Vision? | ✅ structure + ownership | ✅ if `BC-27`'s charter or §3 changes | ✅ **ADR REQUIRED** → `ADR-0023` **Proposed** |
| 3 | `ATT-GAP-015` — Face V1 or V3? | ⚠️ conditional | ⚠️ conditional | ⛔ **NOT YET** — §3.1 |
| 4 | `ATT-GAP-017` — the six configurable defaults | ❌ | ❌ | ⛔ **NO** — §3.2 |
| 5 | Freezing `PRD-006` | ✅ | ✅ | ⛔ **PREMATURE** — §3.3 |
| 6 | Relaxing `LIB-16.2` | ✅ | ✅ Rank 3 | ⛔ **NOT OURS** — §3.4 |
| 7 | Accepting `ADR-0021` | — | — | ⛔ **NOT AUTHORISED** — §3.5 |
| 8 | Correcting `PRD_REGISTRY.md` L236 / `PRD-006` L11 staleness | ❌ | ⚠️ | ⛔ **NO** — §3.6 |

**Both required ADRs were already identified by `PRD-006` itself.** §32 records `ATT-GAP-010`'s owner as
*"Architecture owner — **needs an ADR** (BC Map §7)"* and `ATT-GAP-011`'s as *"Architecture owner — **needs an
ADR**"*. Searching the whole register for that phrase returns **exactly these two rows**. The determination
reproduces the specification's own finding rather than competing with it.

**Neither ADR existed.** `grep -rl 'ATT-GAP-010\|ATT-GAP-011' docs/00-governance/` returned nothing before this
phase.

---

## 3. Why the six were rejected

### 3.1 `ATT-GAP-015` — Face V1/V3 — an ADR is required, but not *yet*, and not from me

The triggers **would** fire: a release-class ruling is a platform-wide scheduling decision (T1), and under
Option A it would additionally require correcting **Rank 6** EA — which does not fire T2, since T2 covers Rank
1–5 only.

Three reasons it is not drafted here:

1. **The decision is one signature short.** `PRD-006` §32 names *"Product owner **+** architecture owner"*
   conjunctively. The PO has ruled V3; **ARB approval is ⏳ PENDING** (`PRD-006_ATT-GAP-015_DECISION_RECORD.md`
   §2, six negative searches). *An ADR records a decision that has been made.* Drafting one now would
   pre-format a ratification that does not exist.
2. **Raising it is the Architecture Owner's call**, and the Decision Pack §5.1 already says so:
   *"A **separate ADR** is the appropriate instrument. Whether to raise one is the Architecture Owner's call;
   this pack does not raise it, and drafts no ADR."*
3. **`ADR-0021` is explicitly not the vehicle** — its §3 lists `ATT-GAP-001`…`016` among what it does not decide.

The instrument is nonetheless **named** for the ARB: the `ADR-0013` pattern — a capability/version ruling decided
by *"Architecture Review Board, acting through the Architecture Owner role"*.

> **Contrast with candidates 1 and 2, which is the whole distinction.** Those two are drafted because
> `PRD-006` §32 *records the ADR requirement itself* and names the ARB as sole owner — the draft **is** the
> request. `ATT-GAP-015` has a two-owner conjunction with one signature outstanding, and a request artefact
> already exists and is unsigned. Drafting an ADR there would duplicate a live request, not serve one.

### 3.2 `ATT-GAP-017` — the six configurables — **no trigger fires**

A default value is not structure, not ownership, not a boundary, and not a platform-wide rule → **T1 does not
fire**. The values would be written into `PRD-006` §16.3, which is **unranked** → **T2 does not fire**.

`ADR-0021` exists and reaches the same conclusion from the other direction: it is an ADR *about* these settings
that **declines to decide them**, because the decision belongs to the product owner, not the ARB. Its §3 says
so: *"Any of the seven values — no source exists; `ATT-BR-043` forbids substitution; the owner is named."*

**The correct instrument is an owner decision request, and one exists** —
`PRD-006_ATT-GAP-017_OWNER_DECISION_REQUEST.md`, created in Phase 3. Creating an ADR here would move a product
decision into an architecture instrument and would be the textbook case the constraint forbids.

### 3.3 Freezing `PRD-006` — an ADR **is** required, and it is premature to draft it

Every freeze in this repository is conferred by an admission ADR — `ADR-0008`, `0009`/`0010`, `0011`, `0018`,
`0019`, `0020`. `ADR-INDEX.md` states the principle: *"freeze in this repository is conferred by a row in
`DOCUMENTATION_BASELINE.md` §3, **never claimed by the document itself**."*

So an `ADR-0024`-class admission ADR will eventually be required. **It must not be drafted now.** Every
precedent admission ADR rests on *completed* gates and *recorded* decisions; drafting one against seven live
blockers would produce a document whose §2 evidence section could only be filled with pending items.
`PRD_LIFECYCLE.md` L294 is unambiguous: *"Urgent business need | **No fast path.** Stage 7 is not skippable."*

### 3.4 Relaxing `LIB-16.2` — required, but against a different document, by a different owner

Making `LIB-16.2`'s first sentence conditional would clear the breach at a stroke. It is a change to **Rank 3**
`Library_PRD_v1.md` → T2 fires. But `ADR-0021` §3 already assigns it: *"That is a change to Rank 3
`Library_PRD_v1.md` and requires its own ADR against that document, **by its owner**."*

The Library PRD's owner is not the attendance workstream. Drafting it here would be one module proposing to
weaken a platform-wide rule to make its own freeze easier — which is the failure mode `ADR-0014` refused when it
declined to waive gate 3 for a green pipeline.

### 3.5 Accepting `ADR-0021` — not a decision available to this operation

`ADR-0021` is **`Proposed`**. Its deciders are the **product owner** (D-1) and the **governance owner** (D-2).
`ADR-INDEX.md` step 2 forbids editing an Accepted ADR's decision text; nothing authorises a reviewer to *make* an
ADR accepted. **Never manufacture an approval or acceptance.** `ADR-0021` is byte-identical, still `Proposed`.

### 3.6 The two staleness defects — no ADR, and no fix

Two factual defects are known:

| Defect | Why no ADR, and why no fix |
|---|---|
| `PRD_REGISTRY.md` L236 says `PRD-006` is `PLANNED` | Correcting a status cell is not structure/ownership/boundary/rule → T1 no. The Registry is **unranked** in baseline §3 → T2 no. But it is **not this operation's document**; it belongs to the governance owner, and `ADR-0021` §3 already assigns it there |
| `PRD-006` L11 claims *"Stages 5, 6 and 7 are unattempted"* — false | No trigger fires (`PRD-006` is unranked). **Not corrected anyway**, because the instruction forbids modifying `PRD-006`. Reported to Phase 8 |

Both follow the `GCP-01`/`GCP-07`/`GCP-08` class the baseline already names — *"a derived statement left behind by
a change to the thing it describes"* — and both are **disclosed rather than absorbed**.

---

## 4. What Phase 4 did not do

| Not done | Why |
|---|---|
| Accept any ADR | Acceptance is the decider's act. **0 accepted** |
| Mark `ADR-0021` Accepted | Its deciders are the product and governance owners |
| Decide `ATT-GAP-010` or `ATT-GAP-011` | The drafts frame options and choose none |
| Add a BC Map edge | L292 forbids it without an accepted ADR. `ADR-0022` §4 declines |
| Extend `BC-27`'s charter or create a context | Count remains **31**. `ADR-0023` §4 declines |
| Draft an ADR for Face V3 | §3.1 — one signature short; raising it is the ARB's call |
| Draft an admission/freeze ADR | §3.3 — premature; Stage 7 is not skippable |
| Update `ADR-INDEX.md` | Registering an unseen draft overstates its standing; disclosed in `ADR-0022` §6 |
| Modify `PRD-006`, the Registry, the Baseline, the BC Map or EA | All byte-identical |

---

## 4a. Disclosed: one gate script was maintained, and the maintenance is recorded rather than performed silently

**Authoring the two drafts broke a passing gate, and the break was caused by the drafts.**
`tool/docs_check/prd006_traceability.py` was at **exit 0** before they existed and went to **exit 1** the moment
they did, because its collision scan treats any `ATT-` token outside `attendance-management/` as a possible
collision — and an ADR *about* `ATT-GAP-010`/`011` cannot avoid naming them, nor the exclusion (`ATT-XC-004`,
`ATT-XC-005`) and build block (`ATT-FR-080`) that depend on them.

**The fix is the repository's existing convention, not a new exemption**, and it follows `ADR-0021` §7.2a — which
recorded the identical event when *that* ADR was written. The `ALLOWED` list gained **two named files**:

| Precedent | Script | Names |
|---|---|---|
| `MM-*` | `prd005_traceability.py` | `ADR-0019` |
| `SEAT-*` | `prd007_traceability.py` | `ADR-0020` |
| `ATT-*` | `prd006_traceability.py` | `ADR-0021`, and now **`ADR-0022`, `ADR-0023`** |

All three rest on the recorded reasoning that *"a citation is not a collision — a collision would be another
register **defining** an identifier."* **Neither draft defines anything**: `grep -E '^\| \*?\*?`?ATT-[A-Z]+-[0-9]+'`
returns only rows inside *"What this ADR does not decide"* and *"Consequences"* tables, every token referring to a
row defined in `PRD-006`.

**Verified safe, not assumed safe:**

| Check | Result |
|---|---|
| List stays enumerated file by file, not widened to `docs/00-governance/` | ✅ A stray `ATT-` elsewhere in governance **still fails** |
| Duplicate-definition, registered-prefix and count checks | ✅ **Untouched** |
| `DOCUMENTATION_BASELINE.md`, `PRD_REGISTRY.md`, `ADR-INDEX.md` | ✅ Still **deliberately excluded** — this is not a freeze |
| Every count after the change | ✅ **Identical** — 516 / 285 / 213 / 18 open / 100.0% / 0 collisions |
| Verdict change caused by the edit | ✅ **None.** Both gaps remain open |

---

## 5. Verification

| Claim | Method | Result |
|---|---|---|
| Exactly two triggers exist | `grep -rn 'requires an ADR\|needs an ADR\|MUST.*ADR'` over `docs/00-governance/` | T1, T2 + 2 derived restatements |
| `PRD-006` §32 flags exactly two gaps as needing an ADR | `grep -c 'needs an ADR'` over the register | **2** — `ATT-GAP-010`, `ATT-GAP-011` |
| Neither had an ADR | `grep -rl 'ATT-GAP-010\|ATT-GAP-011' docs/00-governance/` | **none** before this phase |
| Numbering is sequential, unreused | `ls docs/00-governance/adr/` | highest was `0021` → `0022`, `0023` |
| Both new ADRs are `Proposed` | Header L5 of each | **Proposed**, ×2 |
| `ADR-0021` unchanged | `sha256sum` | `018dac636251008e` — **Proposed** |
| BC Map unchanged | `sha256sum` | `e527df027664680e` |
| `PRD-006` unchanged | `sha256sum` | `93ab1c60d740c4e0` |
| Registry / Baseline unchanged | `sha256sum` | `f8e71ce876c2b53b` / `42405be29d392e14` |
| No context created | BC Map §3 | **31** |
| No edge added | BC Map §7 | unchanged |
| Zero code changes | `git status lib/ test/ pubspec.yaml` | **0** |
| Gate restored after the `ALLOWED` maintenance | `prd006_traceability.py` | **exit 0, PASS** — all counts identical |
| Other three gates unaffected | re-run | task coverage **exit 0**; `prd007_task` **exit 0**; `prd007_trace` **exit 1, same 2 pre-existing classes** |

---

## 6. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-04 | Created as the Phase 4 determination. Located the **two** ADR triggers the repository actually states — `ADR-INDEX.md` Process step 1 (structure/ownership/boundary/platform-wide rule) and `DOCUMENTATION_BASELINE.md` §7 step 1 (any Rank 1–5 change) — plus two derived restatements, and tested **eight** candidates against them. **Two require an ADR** and are drafted **`Proposed`**: `ADR-0022` (`ATT-GAP-010`, `E-22` consumer list, a Rank 4 boundary change) and `ADR-0023` (`ATT-GAP-011`, OCR/Vision capability ownership, a structure/ownership decision). Both were independently identified by `PRD-006` §32, which is the **only** two rows in its gap register carrying the phrase *"needs an ADR"*, and neither had an existing ADR. **Six candidates rejected**, each with a stated reason rather than silence: Face V3 is one signature short and raising it is the ARB's call per Decision Pack §5.1; the six configurables fire **neither** trigger, since a default value is not structure and `PRD-006` §16.3 is unranked, and `ADR-0021` already exists declining exactly this; a freeze/admission ADR is required eventually but premature against seven live blockers; relaxing `LIB-16.2` belongs to the Library PRD's owner and would be one module weakening a platform rule for its own convenience; accepting `ADR-0021` is its deciders' act; and the two staleness defects fire no trigger and belong to the governance owner. **No ADR was accepted, none was marked Accepted, no edge was added, no context created (still 31), no charter extended, and `PRD-006`, `ADR-0021`, the Registry, the Baseline, the BC Map and EA are all byte-identical.** |
