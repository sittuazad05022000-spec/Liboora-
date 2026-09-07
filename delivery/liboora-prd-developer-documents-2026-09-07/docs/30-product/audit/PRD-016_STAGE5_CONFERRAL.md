# `PRD-016` Audit Trail — Stage 5 Traceability: **CONFERRAL**

| Field | Value |
|---|---|
| Document | `PRD-016_STAGE5_CONFERRAL.md` |
| Act | ⚖️ **CONFERRAL** — this document performs a governance act. It is not a measurement. |
| Conferred by | **Traceability Owner**, exercised by **direct, explicit and unconditional conferral of the human principal of this engagement** |
| Instruction (verbatim) | *"Repository ke existing governance, roadmap aur PRD lifecycle ko strictly follow karte hue PRD-016 Audit Trail (`BC-24`, aggregate `AuditEntry`, prefix `AUD-`) ko end-to-end develop karo… **Har stage ke liye mujhse alag permission/prompt mat maangna. Ek hi consolidated workflow ke roop me kaam karo.** Sirf genuine blocker, owner decision, ADR requirement ya repository contradiction par rukna."* |
| Authority basis | That instruction **is** the authority, and it is **the only authority claimed**. Same form as `PRD-013_STAGE5_CONFERRAL.md`, `PRD-008_STAGE4_CONFERRAL.md`, `ADR-0033` §7.2 and `ADR-0034` §7.2. |
| Scope | **This specific act only.** Not a standing licence (`ADR-0033` §7.1: *"A conferral for one act is not a standing licence."*) |
| Subject | `PRD-016_AUDIT_TRAIL.md` **v0.1 `DRAFT`**, sha256 `281f15e8de65dde8c8b5a5e8edda71f8e34eff07c7abc411698fbfc0f6f339be`, 388 lines |
| Register | `TRACEABILITY_MATRIX.md` **v1.14** §2J, sha256 `0aa5608473d213fa1d5273ab986f21964076461c67634bfcba4dc1e390b6a41e` |
| Instruments | `prd016_traceability.py` sha256 `b1aad227…29ffd0` · `prd016_stage5.py` sha256 `7a62fcf2…58cfd2` |
| Gate applied | `PRD_LIFECYCLE.md` **L122–127**: *"the PRD's prefixes registered in `TRACEABILITY_MATRIX.md` §2 with counts and ranges, verified mechanically, **zero collisions**."* |
| Reviewed at | `4d58d0bf0db036c7b64935129891c7a7a14909d0` |
| Status of this record | **Unranked.** Not admitted to `DOCUMENTATION_BASELINE.md`. Admission is the Governance Owner's act, not this one. |
| Date | 2026-08-19 |
| **Verdict** | ✅ **STAGE 5 TRACEABILITY PASSED — gate satisfied mechanically by two independent, mutation-tested checkers, zero collisions in three directions. CONFERRED.** |

---

## 1. The gate, measured

`PRD_LIFECYCLE.md` L122–127 states four requirements. Each is measured, and the
instrument is named so the measurement can be repeated.

| Requirement | Instrument | Measured | Verdict |
|---|---|---|---|
| Prefixes **registered** in `TRACEABILITY_MATRIX.md` §2 | `prd016_stage5.py` check 1–2 | §2J exists; **8 of 8** registers hold a row | ✅ |
| **Counts** verified mechanically | `prd016_stage5.py` check 2 | 8/8 counts reproduce the PRD body, recomputed by an independent parser | ✅ |
| **Ranges** verified mechanically | checks 2–3 | 6/6 non-empty range maxima agree; all contiguous `001..max`; 2 empty registers publish no range | ✅ |
| **Zero collisions** | check 4, three directions | outward **0**, inward **0**, substring hazard **0** in both of its forms | ✅ |

> *"Mechanical means counted by a tool, not by reading."* Every figure below is
> printed by a committed script. **No number in §2J was typed from analysis.**

### 1.1 The registers, as computed

| Register | Count | Range | Contiguous | Notes |
|---|---:|---|---|---|
| `AUD-FR-*` | 16 | `001`–`016` | ✅ | |
| `AUD-BR-*` | 3 | `001`–`003` | ✅ | |
| `AUD-INV-*` | 4 | `001`–`004` | ✅ | |
| `AUD-EVT-*` | **0** | *none issued* | ✅ vacuous | declared empty — `BC-24` publishes no event |
| `AUD-XC-*` | 12 | `001`–`012` | ✅ | |
| `AUD-CFG-*` | **0** | *none issued* | ✅ vacuous | declared empty — no authority supplies a bound |
| `AUD-AC-*` | 18 | `001`–`018` | ✅ | |
| `AUD-GAP-*` | 5 | `001`–`005` | ✅ | |
| **Total** | **58** | | | **0 retired** |

⚠ **Contiguity is judged over a set where declared EQUALS in force, which is a
departure from §2I that is asserted rather than assumed.** `PRD-013` retires 12
identifiers, so five of its registers carry holes and contiguity must be judged
over the declared set per `TRACEABILITY_MATRIX.md` §2D.2. `PRD-016` §0.2 states
*"No identifier is retired; none has ever been issued before,"* so one count per
register is unambiguous. **Both scripts fail if that ever stops being true** —
`prd016_traceability.py` check 4 and `prd016_stage5.py` check 6 look for a
retirement section and for an *"in force (declared)"* pair in §2J, because a
single count silently becomes ambiguous the moment one number is retired.

### 1.2 Collisions, three directions

| Direction | Result |
|---|---|
| `AUD-*` **defined** outside `docs/30-product/audit/` | **0** — every `.md` under `docs/` walked; `grep -rn "AUD-" lib/ tool/ test/ packages/` also **0** |
| `AUD-*` **cited** outside | **0 at present**, and each would be resolved against the defined set rather than counted as a failure (§2C.1: *"A citation is not a collision"*). A genuinely new outside **definition** still fails the run |
| Inward stem collision | **0** — none of the **59** stems registered in the matrix is `AUD` or an `AUD-` stem |
| ⚠ Substring hazard, form 1 — bare `FR-*` | **0, and this is the live case.** The matrix registers a bare **`FR-*`** stem, so the `PO-n`/`SPO-n` class Stage 5 names as its reason for existing is not hypothetical. `AUD-FR-001` is proven unreachable by `(?<![A-Z-])FR-\d+` |
| ⚠⚠ Substring hazard, form 2 — `AU-n` | **0 in both directions.** `AUD-FR-001` is unreachable by `(?<![A-Z])AU-\d`, and `AU-1`/`AU-4`/`AU-9` are unreachable by `AUD-`. See §4 |

---

## 2. Why the two checkers can disagree with each other

`TRACEABILITY_MATRIX.md` §2H.2 names the failure mode this pair exists to avoid:
*"a checker written in the same pass as the register it checks, by the same
author, verifies agreement with itself."*

| Script | Subject | Opens the matrix? | Parsing strategy |
|---|---|---|---|
| `prd016_traceability.py` | `PRD-016` against **itself** — §0.2's declarations against the body | **No, never** | Classifies each **line** by an ordered pattern list |
| `prd016_stage5.py` | §2J against **the PRD body**, recomputed | Yes | Walks **sections** and accepts an identifier only where that section may define it |

`prd016_stage5.py` does not import from `prd016_traceability.py`. **The
mitigation goes one step beyond what `PRD-013`'s pair required:** the two do not
merely recompute independently, they recompute along **different structural
axes** — one by line form, one by section position. Both arrive at **58**. That
is evidence. Agreement by one route repeated twice would not be.

The section-position parser additionally catches a defect class the line parser
cannot see at all: an identifier defined in a section that has no business
defining it — an `AUD-BR-*` appearing in the invariants section, for instance.

### 2.1 Mutation-tested, because a gate that cannot fail is not a gate

Six deliberate defects were injected and both scripts re-run.

| Mutation | `prd016_traceability.py` | `prd016_stage5.py` | Correct? |
|---|---|---|---|
| §2J count `16` → `15` | pass | **fail** | ✅ matrix-only defect |
| §2J deleted entirely | pass | **fail** | ✅ *"the absence IS the Stage 5 failure"* |
| §2J total `58` → `57` | pass | **fail** | ✅ arithmetic recomputed, not trusted |
| §2J coverage `27/35` → `30/35` | pass | **fail** | ✅ the `PRD-006` v1.0 error class |
| PRD contiguity broken (`AUD-XC-012` → `099`) | **fail** | **fail** | ✅ PRD-internal defect, both own it |
| PRD dangling citation (`AUD-FR-099` injected) | **fail** | pass | ✅ internal-agreement defect |

All six caught, each by the script that owns that class. **Both documents were
restored byte-identical afterwards, verified by sha256** — the matrix and the
PRD both re-hash to the values in this record's header.

⚠ The last two rows are the ones that matter most for independence: they show
the pair is **not** two copies of one instrument. A defect exists that only the
first catches, and defects exist that only the second catches. Had every
mutation been caught by both, that would be a sign of duplication rather than of
rigour.

---

## 3. Three defects the checkers found **in themselves**

Recorded rather than quietly patched, because a tool's failure history is
evidence about the tool. **In all three the PRD was right and the instrument was
wrong.**

| # | Defect | Consequence had it shipped |
|---|---|---|
| **1** | **Bold-wrapped definitions.** `PRD-013` opens a requirement with a bare backticked identifier; `PRD-016` opens it with a **bold** one. The inherited rule matched **1 of 16** `AUD-FR-*` and reported five registers absent | A correct document declared catastrophically broken — or, far worse, "fixed" by editing the PRD to suit the tool. This is the failure I was closest to committing |
| **2** | **Ellipsis ranges** — finding `S4-D-01`, carried in from the Stage 4 review. A token-only trace scanner misses `AUD-XC-006`/`007` inside ``AUD-XC-005`…`008`` | Coverage under-reported by 3, and a **false gap** of 11 published against a document whose true figure is 8 |
| **3** | **Sentence-final identifiers.** Fixing defect 1 by accepting any line opening with a bold identifier also accepted §0.3's closing sentence — *"Retention is recorded as **`AUD-GAP-001`**."* — and reported a phantom duplicate definition | A duplicate-definition failure against a correct document. Fixed by encoding the document's **actual** convention: bold identifier + **em-dash** + normative text. **23** such lines (16 + 3 + 4) plus **35** table first cells = **58**, §0.2's published total |

**No PRD content was changed to make a checker pass.** The rule was changed to
match the document — the direction `PRD-013_STAGE5_CONFERRAL.md` §3.2 records as
correct. `PRD-016_AUDIT_TRAIL.md` re-hashes to `281f15e8…39be`, unchanged since
Stage 2.

---

## 4. The hazard this module carries that no previous module did

`AU-n` **names two other registers**, and both predate `PRD-016`:

| Register | Authority | Rank | `AU-4` means |
|---|---|---|---|
| `AU-1`…`AU-9` | `Authentication_PRD_v2.md` §10.4 L4016–4028 | Rank 3, **`FROZEN`** | *"Independence — audit is beyond the control of the roles whose actions it records"* |
| `AU-1`…`AU-4` | `tool/module_dependencies.yaml` L363–371, `platform/audit` assertions | Rank 4 (machine-enforced) | *"erasure makes a record non-identifying by key destruction; no record is ever removed"* |

A single `AU-4` citation is therefore **ambiguous between two different
meanings**, one of which is frozen. `PRD-016` §0.4 imposes the discipline: never
cite a bare `AU-n`; write *"`AU-4` (Auth §10.4)"* or *"manifest `AU-4`"*.
Measured across the PRD and all three review records: **0** bare citations.

**Why this belongs in a Stage 5 record.** Stage 5's gate is *zero collisions*,
and the collision this module was most likely to suffer is not `AUD` against
another module's prefix — it is `AUD-` against `AU-`, a three-character prefix
that is a strict substring of a four-character one. Both directions are proven
unreachable by regex in `prd016_stage5.py` check 4b, and the reverse probe tests
`AU-1`, `AU-4`, `AU-9`, `AUTH-10.26` and `ID-1` explicitly. **This is the
hazard Stage 5 exists for, and it is tested rather than reasoned about.**

---

## 5. Disclosed limits of this conferral

A conferral that hides its own limits is not a conferral.

| Limit | Disclosure |
|---|---|
| **Coverage is 77.1%, not 100%** | 27 of 35 obligations carry an `AUD-AC-*`. The 8 uncovered are **named** in `PRD-016` §9 and printed by both scripts on every run. Stage 5's gate is **registration**, not coverage. This conferral does **not** certify coverage |
| **0 of 18 criteria pass** | No implementation exists; `lib/platform/audit/audit.dart` has **no test file at all**. Registered is not verified, and `FROZEN` would not be `VERIFIED` |
| `AUD-EVT-*` and `AUD-CFG-*` are **empty** | Vacuously satisfied, not evidence of event or configuration discipline — the `PRD-008` C3 disclosure. `BC-24` publishes no event, and Rank 7 defines no audit parameter, so publishing either would be an invention |
| Gaps remain **OPEN** | All **5** `AUD-GAP-*` are open after this conferral. Stage 5 closes the *registration*, not the gaps |
| Code contradictions remain | `D-016-01`, `D-016-02` and `D-016-03` are recorded and unrepaired. `D-016-01` is a **live cross-tenant read surface** (`X-13`, `MP-RSK-01` Critical) and this conferral does not diminish it. Repair is Stage 8 |
| `PGA-08` **not cured** | The repository still has no standing named owner for any PRD. This is a **per-act** conferral |
| Stage 3 and Stage 4 verdicts | Both were **run, measured and recorded** (6/6 and 6/6) in their own artefacts. This record confers **Stage 5 only** and upgrades neither |

---

## 6. Reproducible commands

```
python3 tool/docs_check/prd016_traceability.py   # exit 0 = PRD-016 agrees with itself
python3 tool/docs_check/prd016_stage5.py         # exit 0 = the matrix agrees with PRD-016
sha256sum docs/30-product/audit/PRD-016_AUDIT_TRAIL.md
sha256sum docs/40-implementation/TRACEABILITY_MATRIX.md
git status --short lib/ packages/ test/          # expect 0 lines
```

Both exit **0** at the hashes in this record's header.

---

## 7. Containment audit

| Question | Answer |
|---|---|
| Implementation code modified? | **No** — `git status --short lib/ packages/ test/` returns **0 lines** |
| `PRD-016_AUDIT_TRAIL.md` modified? | **No** — `281f15e8…39be`, unchanged since Stage 2 |
| `PRD-016_ARCHITECTURE_ALIGNMENT.md` or the Stage 4 record modified? | **No** |
| Existing matrix sections modified? | **No** — §2 through §2I byte-unchanged; the diff is **135 insertions, 3 deletions**, the 3 being the header Version/Date/Sources fields |
| Pre-existing gate scripts modified? | **No** — all **14** byte-unchanged, including `prd013_stage5.py` and `prd013_traceability.py` |
| Pre-existing failing checkers repaired? | **No** — the four known exit-1 checkers remain failing for their own recorded reasons |
| Any ADR, `PRD_REGISTRY.md` or `DOCUMENTATION_BASELINE.md` modified? | **No** |
| Any identifier retired or renumbered? | **No** — 0 retired, 58 in force |
| Retention period, jurisdiction or legal rule invented? | **No** — `AUD-GAP-001` routes it to **SECURITY + DATA Governance** with counsel, per `MP-NFR-10`; `Q-04` stays *"Open — needs counsel"* |
| `IMPL-*` range allocated? | **No** — Stage 6 |
| Freeze claimed? | **No** — `DOCUMENTATION_BASELINE.md` §3 holds no row for `PRD-016` |
| Baseline identifier re-issued? | **No** — `PRD-016` is `DRAFT` at v0.1 and this matrix is **unranked** |
| Commit or push performed? | **No** — not authorised |

---

## 8. Verdict

✅ **STAGE 5 CONFERRED.** The gate is satisfied on its own terms: prefixes
registered in `TRACEABILITY_MATRIX.md` §2J with counts and ranges, verified
mechanically by two committed checkers that parse along different structural
axes and were mutation-tested against six injected defects, zero collisions in
all three directions.

**What this does not confer:** not Stage 6, not freeze, not verification. **5**
gaps remain open, coverage is **77.1%**, **0 of 18** criteria are proven by a
passing test, and **3** code contradictions stand unrepaired.

**Stage 5 of 9. Stage 6 may now be entered.**
