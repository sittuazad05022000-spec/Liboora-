# PRD-023 Settings & Configuration — Stage 5 Traceability Conferral

| Field | Value |
|---|---|
| **Document** | `PRD-023_STAGE5_CONFERRAL.md` |
| **Subject** | `docs/30-product/configuration/PRD-023_SETTINGS_AND_CONFIGURATION.md` — Settings & Configuration (`BC-25`), v0.1 `DRAFT` |
| **Stage** | **5 — Traceability** (`PRD_LIFECYCLE.md` L121–133) |
| **Verdict** | ✅ **GATE SATISFIED — Stage 5 CONFERRED** |
| **Registry status this permits** | `APPROVED` *(not written by this pass; see §7)* |
| **Date** | 2026-08-20 |
| **Reviewed at** | `cbb0fdc` (+ uncommitted registration, §8) |
| **PRD hash at review** | `e97496083a76bfb0f45be9acae754050c374561b64734df5738dac7ff6399326` |
| **Registration** | `TRACEABILITY_MATRIX.md` **§2L**, matrix **v1.15 → v1.16** |
| **Gate scripts** | `tool/docs_check/prd023_traceability.py` (**exit 0**, 545 lines) · `tool/docs_check/prd023_stage5.py` (**exit 0**, 672 lines) |
| **Frozen inventory** | **180 identifiers · 8 registers · 113 obligation-bearing** |
| **PRD modified** | **No.** Hash identical before the pass, after every mutation, and at close — verified 5× |
| **Code modified** | **No.** `git status --short lib/ packages/ test/ web/ pubspec.yaml` → **0 lines** |

---

## 1. What the gate actually requires

`PRD_LIFECYCLE.md` L123–126 states the Stage 5 exit gate:

> the PRD's prefixes registered in `TRACEABILITY_MATRIX.md` §2 with counts and ranges, verified mechanically,
> **zero collisions**. **Mechanical means counted by a tool, not by reading.**

And L41–42 states what a gate is:

> Each transition has a **gate**: a named artefact that must exist. A gate is not an opinion — if the artefact does
> not exist, the stage has not been passed, **however complete the work feels**.

### 1.1 Why this conferral does not edit the PRD

Stage 5 registers identifiers; it does not author them. Editing `PRD-023` would change its `sha256` and invalidate the
Stage 3 and Stage 4 measurements taken at hash `e974960…` — the precise drift `alignment_record_freshness.py` exists
to catch. One defect inherited from Stage 4 (`S4-D-01`) was therefore **disclosed, not repaired**; see §6.3.

---

## 2. The gate, part by part

| Gate clause | How it is satisfied | Evidence |
|---|---|---|
| **Registered in §2** | §2L added, `TRACEABILITY_MATRIX.md` L1205–1368, before `## 3. Chapter map` | Section exists; the checker fails without it (§4.1) |
| **With counts and ranges** | 8 rows + Total, each carrying count **and** range | `CNF-FR-*` 82 / 001..082 · `CNF-BR-*` 11 / 001..011 · `CNF-INV-*` 4 / 001..004 · `CNF-EVT-*` **DECLARED EMPTY** · `CNF-XC-*` 16 / 001..016 · `CNF-CFG-*` **DECLARED EMPTY** · `CNF-AC-*` 59 / 001..059 · `CNF-GAP-*` 8 / 001..008 · **Total 180** |
| **Verified mechanically** | Two committed scripts, both **exit 0**, neither importing the other, parsing by **different strategies**, both reaching **180** | §4 |
| **Zero collisions** | Inward, outward and by substring — all three measured | §5 |

### 2.1 The pre-commit measurement, published with its regex

The bare `grep -c 'CNF-'` form used by §2G…§2J is **unsafe as a method**, per the §2K lesson. The measurement
actually taken was:

```
grep -cE '(^|[^A-Za-z-])CNF-(FR|BR|INV|EVT|XC|CFG|AC|GAP)-[0-9]+' docs/40-implementation/TRACEABILITY_MATRIX.md
→ 0
```

So **180 identifiers in a document scoped by an ACCEPTED ADR were registered nowhere** — the condition Stage 5
exists to prevent.

---

## 3. The two objections, discharged rather than argued away

| Objection | Discharge |
|---|---|
| **No role holder.** `PRD_LIFECYCLE.md` §6 assigns Stage 5 to the traceability owner; L283 records `PGA-08`, *"Every PRD needs a named owner. None has one"* | Discharged **by conferral**, in the identical form `PRD-008`/`PRD-013`/`PRD-016`/`PRD-014` used. ⚠ **`PGA-08` is a standing gap and is NOT cured** — a conferral is per-act, not an owner appointment (`ADR-0033` §7.1: *"A conferral for one act is not a standing licence"*) |
| **No committed gate script.** *"A number computed once is not a number verified mechanically on every commit"* | Discharged **by construction** — two scripts committed under `tool/docs_check/` |

---

## 4. Independence of the two instruments

§2H.2 names the failure the pair exists to avoid:

> a checker written in the same pass as the register it checks, by the same author, verifies agreement with itself.

| | `prd023_traceability.py` | `prd023_stage5.py` |
|---|---|---|
| **Opens the matrix?** | **No — never** | Yes; the matrix is the document under test |
| **Compares against** | §0.2's declarations vs the PRD body | §2L vs an independent recomputation |
| **Parsing strategy** | **LINE-FORM** — classifies lines by shape | **SCOPE-POSITION** — splits at both `## ` and `### `, accepts an identifier only where that scope may define it |
| **Authorisation table** | none | **37 entries** — the largest here, because `PRD-023` defines `CNF-FR-*` across **21 distinct scopes** where `PRD-014` used six; longest-prefix matched, so `### 13.1` is not captured by `## 13.` |
| **Result** | **180** | **180** |

**Both reach 180 by different routes**, which is evidence. Agreement by one route repeated twice would not be.

### 4.1 The gate was proven able to fail before it was allowed to pass

`prd023_stage5.py` was run **before §2L existed** and exited **1**:

> `TRACEABILITY_MATRIX.md` has no section 2L — the Stage 5 gate is not satisfied. The gate is the registration,
> not the intention to register.

— while simultaneously recomputing **180** identifiers across **8** registers from the PRD body. A gate that cannot
fail is not a gate.

### 4.2 Mutation testing — 12 injected, 12 caught

**Matrix-side (5/5)** — all five correctly **invisible** to the checker that never opens the matrix:

| # | Injected defect | Caught by |
|---|---|---|
| M1 | `CNF-FR-*` count 82 → 81 | `prd023_stage5.py` — *"publishes count 81, recomputed 82"* |
| M2 | Total 180 → 179 | `prd023_stage5.py` |
| M3 | coverage 76 → 77 | `prd023_stage5.py` |
| M4 | §2L deleted entirely | `prd023_stage5.py` — the gate message |
| M5 | the `CNF-EVT-*` empty row removed | `prd023_stage5.py` — *"empty by design but has no row… An omitted empty register is indistinguishable from an oversight"* |

**PRD-side (7/7):**

| # | Injected defect | Caught by |
|---|---|---|
| M6 | contiguity break `CNF-BR-008` → `012` | **both** |
| M7 | mint a numbered member into `CNF-CFG-*` | both — *"declared EMPTY but 1 numbered member(s) now exist… the Stage 5 mandate forbids minting one without authoritative evidence"* |
| M8 | mint a numbered member into `CNF-EVT-*` | both |
| M9 | strip an obligation from the §13 Coverage paragraph | `prd023_traceability.py` — *"carries no acceptance criterion and is NOT named in the Coverage paragraph — an untested obligation presented as tested"* |
| M10 | stale §14 cross-reference (`§3.1` → `§9.1`) | `prd023_traceability.py` — *"that section does not mention it — the cross-reference is stale"* |
| M11a | scope violation — an **out-of-range invariant** defined in §12.1 | both — *"is defined in scope `### 12.1`, which defines FR"* |
| M11b | scope violation — an **in-range business rule** in §12.1, **contiguity left intact** | both, by the **scope rule alone** |

⚠ **M11 was initially a MISS, and was driven to root cause rather than believed in either direction.** The first
injection used a `sed` address matching a **table-row** form, but §12.1 defines requirements as
`` **`CNF-FR-076`** — … `` prose, so the mutation **never applied**. That is a **harness** defect, not a gate blind
spot. M11b is the sharper of the re-runs: contiguity is left intact, so the scope-authorisation rule is the *only*
thing that can catch it — and it does, by name.

Both documents were restored **byte-identical** after every mutation, verified by `sha256` (`e974960…`).

---

## 5. Collisions — checked in three directions

| Direction | Result |
|---|---|
| **Inward** — could an existing register's search find a `CNF-*` identifier? | **0.** Six hazards tested: `FR-n`, `BR-n`, `INV-n`, `XC-n`, `AC-n`, `GAP-n`, `CFG-n` |
| **Outward** — is any `CNF-*` identifier **defined** outside the configuration module? | **0 definitions.** 20 citations, all §2L's own |
| **Substring** — is `CNF-` the tail of an ordinary word? | **Hazard ABSENT, measured** (§5.2) |

Stem census: **78** prefix stems already registered in the matrix; **`CNF` free**; anchored `CNF-` in the matrix
pre-commit **0**.

### 5.1 The two ⚠⚠ inward hazards are sharper here than in any predecessor

**(1) `CFG-1`…`CFG-12` is an OCCUPIED register** owned by `PRD-001` (**FROZEN v2.0**), and the colliding
sub-register `CNF-CFG-*` is **empty**. Every predecessor's inward hazard was a register that *might* be confused;
this one is a **live register with real members**, so a naive `CFG-\d+` sweep that swept up `CNF-CFG-*` would be
reporting members of a register that has none. Sharpened because `PRD-023` **legitimately cites** `CFG-1`…`CFG-12`
when reporting the 104-configurable census, so both registers coexist in one document. Measured: no match.

**(2) `INV-1`…`INV-16` are this module's SUBJECT MATTER.** §2A.1 records three prior meanings (`INV-n` platform
invariant, `INV-SEC-n`, `INV-XC-n`); bare `INV-n` occurs **23 times** in the matrix. `PRD-023` §5 *is about
enforcing* `INV-1`…`INV-16` and cites them **in the same section** that defines `CNF-INV-001`…`004` — the
`PO-n`/`SPO-n` class at its highest density in the repository. Measured: no match in either direction.

### 5.2 The reverse hazard is ABSENT, not merely defeated

`ENT-` is a live substring of `MANAGEMENT-` (10) and `ALIGNMENT-RECORD` (3), so §2K needed elaborate decoys. A
corrected lookbehind scan `(?<=[A-Za-z0-9])CNF-` over `docs/ tool/ lib/ test/` returns **exactly 3 hits, all the
`b` of the regex escape `\bCNF-`** inside quoted grep commands — prose *about* a pattern, not words embedding the
prefix. §2L therefore states the hazard is **absent** rather than manufacturing a decoy that would prove nothing.
What **is** asserted is that the anchored form still matches `CNF-FR-001` and does **not** match inside
`XCNF-FR-001`, because a pattern matching nothing would under-count every register silently.

---

## 6. Findings

### 6.1 Coverage is published at its true value — the lowest this matrix has ever carried

**76 / 113 = 67.3%**, with **⛔ 0 of 59 criteria proven by a passing test**, because no implementation exists. All
**37** uncovered obligations are **named** in §13's Coverage paragraph, located **by anchor rather than a fixed line
slice** (the `S4-C-02` lesson), at L1333.

It is low for a **structural** reason, not a careless one: **all 16 `CNF-XC-*` are uncovered by construction** — an
exclusion states what must be **impossible**, and a criterion asserting that something never happens is
**unfalsifiable by observation**. The remaining 21 are definitional `CNF-FR-*` and 3 rule-restating `CNF-BR-*`. The
`PRD-006` v1.0 error of publishing *"100% coverage"* against a true **49.1%** is not repeated, and both scripts fail
the run if the figure drifts.

### 6.2 Findings raised by this stage

| ID | Finding | Disposition |
|---|---|---|
| **`S5-F-01`** | The matrix header said *"§2K added"* and carried v1.15 while §2L was being written; §2L.2 claimed *"three header fields and one change-history row"* **before those existed** | **REPAIRED within this pass** — v1.15 → **v1.16**, Date and Sources extended, §11 row added. A claim a document makes about itself must be true |
| **`S5-C-01`** | Instrument defect — a **line-start** definition rule accused §14 of falsely claiming **six of seven** gaps were raised in the body | **Rule strengthened** (§6.4) |
| **`S5-C-02`** | Instrument defect — the reverse-hazard scan over-reported by **645** | **Fixed**; hazard restated as absent (§5.2) |
| **`S5-C-03`** | Instrument defect — the dangling-citation rule could not tell a **citation** from a **regex test vector** | **Fixed narrowly and guarded** (§6.4) |
| **`S5-F-02`** | My own **regression-sweep harness** reported all 20 pre-existing checkers at exit 0, contradicting the known 5 failures | **Root-caused and re-run** (§6.6) |

### 6.3 Carried from Stage 4, deliberately not repaired

**`S4-D-01` — the document OVER-declares its own uncovered set by three.** The Coverage paragraph names **40**
where only **37** are uncovered: `CNF-XC-005`, `CNF-XC-008` and `CNF-XC-014` *are* cited by `CNF-AC-038`, `041`
and `048`. It therefore **understates its own verification coverage** — the **safe** direction, and the exact
opposite of the Stage 4 failure the check guards. Repairing it would change the PRD's hash and invalidate the
Stage 3 and Stage 4 measurements. **Disclosed, not repaired.**

`S4-D-02`, and `D-01`…`D-06` from Stage 4, likewise stand as recorded.

### 6.4 Three defects the checkers found in themselves

In **all three** the PRD was right and the instrument was wrong, and in each **the rule was changed rather than the
document**.

1. **`S5-C-01` — a duplicate-definition rule that was too narrow.** The first form of
   `prd023_traceability.py` asserted that each gap §14 names as *"raised in the body"* must carry a **line-start**
   definition site. It failed for **six of the seven**. The document was **right**: `PRD-023` raises gaps
   **inline, mid-sentence** (*"Recorded as `CNF-GAP-001`."*), and only `CNF-GAP-006` happens to begin its line. The
   fix was made **stronger, not weaker** — §14 states not merely *that* each gap was raised but **where**, so every
   `CNF-GAP-nnn at §x.y` pointer is now resolved against that section's actual text. **A stale pointer now fails,
   which the line-start rule could never have detected** (mutation M10).

2. **`S5-C-02` — a reverse-hazard scan that over-reported by 645.** It read the first character of its own match
   instead of the character before it. Had it been believed, an elaborate §2K-style decoy would have been built
   **proving nothing**, since the hazard does not exist for this prefix.

3. **`S5-C-03` — a dangling-citation rule that could not tell a citation from a regex test vector.** After §2L was
   written, `prd023_stage5.py` exited **1** pointing at §2L.1's own **measurement** — a would-be `CNF-CFG` member
   fed to the bare `CFG-\d+` pattern to prove it does **not** match. That token is a *string fed to a pattern*, not
   a reference a reader must resolve. ⚠ **But the checker was also RIGHT twice over:** while describing the
   mutation runs I had named four identifiers — an out-of-range invariant, an in-range business rule, and one member
   in each empty register — that **exist in no version of the PRD**. That is exactly the dangling citation §2J
   mutation-tested with `AUD-FR-099`, reintroduced by me in the very row claiming the gate catches it. **The prose
   was corrected, not the rule**; mutations are now described **by kind, not by phantom number**. Only the genuine
   test-vector case is excluded, **narrowly and guarded** — single-quoted tokens inside an inline-code span
   containing `re.search`, in the matrix only, with a guard that **fails loudly if that convention disappears**, so
   it cannot rot into a blanket exemption.

**No PRD content was changed to make a checker pass.**

### 6.5 The two empty registers, and why no number was minted

The Stage 5 mandate forbids creating numbered `CNF-EVT` or `CNF-CFG` members *"unless Stage 5 finds authoritative
evidence requiring them."* Stage 5 **looked, and found none**:

- **`CNF-EVT-*` = 0** — `BC-25` publishes no domain event; BC Map §9 producer rows for `BC-25`: **0**.
- **`CNF-CFG-*` = 0** — **the most consequential empty register in the repository, because the module that owns
  configuration owns no configurable.** `PRD-023` owns the **resolution machinery, not the value list**
  (`ADR-0017` §3.1 item 6), and the clean census places **all 104** configurables with **8 other owning PRDs, every
  one FROZEN**: `CFG-1`…`12`, `LCFG-1`…`13`, `ICFG-1`…`10`, `SCFG-1`…`11`, `SMCFG-1`…`7`, `MM-CFG-001`…`009`,
  `SEAT-CFG-001`…`018`, `ATT-CFG-001`…`024`.

Both are **registered as empty rather than omitted**, because an omitted empty register is indistinguishable from an
oversight (M5). Emptiness is verified **real, not merely described** (`grep -cE '\bCNF-CFG-[0-9]+'` → **0**) and is
now **enforced as a test** — both checkers fail if a member ever appears (M7, M8). ⚠ Deliberately **unlike
`TEN-CFG-001`**, which was issued then retired, **no number is burned at all**.

### 6.6 A contradiction in my own regression sweep, driven to root cause

The first sweep reported **all 20** pre-existing checkers at **exit 0** — contradicting the standing record of
**5 known failures**. Rather than report that as good news, it was investigated:
`alignment_record_freshness.py` printed `PROBLEMS: 1` and holds `sys.exit(1 if problems else 0)`, yet the sweep
recorded 0. **Root cause: the sweep harness, not the checkers.** A `case … continue` inside the loop reset `$?`
before `echo` read it, so every line printed the *`case` statement's* status. Re-run with a correct harness:
**5 non-zero, exactly the 5 known pre-existing failures** — `alignment_record_freshness.py`,
`prd004_traceability.py`, `prd005_traceability.py`, `prd006_traceability.py`, `prd007_traceability.py`. **Nothing
was weakened**; a masking harness had merely hidden them. Recorded as **`S5-F-02`**.

### 6.7 Candidates considered and rejected

| ID | Rejected candidate | Why |
|---|---|---|
| `R5-01` | Mint `CNF-CFG-001` so the owning module owns at least one configurable | No authoritative evidence; all 104 belong to 8 FROZEN PRDs. Inventing one would breach the explicit Stage 5 prohibition |
| `R5-02` | Mint `CNF-EVT-001` for a "configuration changed" event | BC Map §9 gives `BC-25` **0** producer rows; §7 L292 — *"if not in this table it does not exist"* |
| `R5-03` | Repair `S4-D-01`'s three over-declared exclusions | Changes the PRD hash, invalidating Stage 3/4 measurements |
| `R5-04` | Exempt §14 from the duplicate-definition rule | Would hide stale cross-references; the rule was **strengthened** instead |
| `R5-05` | Build a `MANAGEMENT-`-style reverse decoy for `CNF-` | The hazard is **absent** for this prefix; the test would prove nothing |
| `R5-06` | Round coverage up, or describe 67.3% as "substantial" | The `PRD-006` v1.0 failure exactly |
| `R5-07` | Broaden the citation rule to ignore all single-quoted tokens | Would hide real dangling citations; a narrow, guarded, matrix-only exclusion was used instead |
| `R5-08` | Allocate `IMPL-1100`…`1129` while the numbers were already measured | Stage 6's act. Registered is not allocated |
| `R5-09` | Close `CNF-GAP-007` by writing the missing `platform/configuration` block | Stage 6/8 work, and an architecture-owner act |
| `R5-10` | Repair `GCP-20` (baseline §4's missing `PRD-014` row) while editing governance files | Explicitly out of scope; **carried, not repaired** |
| `R5-11` | Update `PRD_LIFECYCLE.md`'s stale `IMPL-227+` table | Amending a governance document is not a Stage 5 act |

---

## 7. What this conferral does NOT do

| Not done | Why |
|---|---|
| **No `IMPL-*` range allocated** | Stage 6. `docs/40-implementation/configuration/` does not exist; next free is **`IMPL-1100`+**, per `PRD-014_IMPLEMENTATION_TASKS.md` **L124** — ⚠ **not** from `PRD_LIFECYCLE.md` L147–153, whose table is **stale** |
| **No freeze** | Stage 7. `DOCUMENTATION_BASELINE.md` §3 has **no row admitting `PRD-023`** — the only place freeze can be conferred. *"Freeze is conferred, not claimed"* |
| **No verification** | Registered is not verified. **0 of 59** criteria have a passing test |
| **No registry status written** | `PRD-023` stays **`PLANNED`** at `PRD_REGISTRY.md` L327 and **v0.1 `DRAFT`** |
| **No gap closed** | All **8** `CNF-GAP-*` remain **OPEN**, including `CNF-GAP-007` (no `platform/configuration` block, which `check_module_boundaries.dart` **L778** exempts from the deny default) and `CNF-GAP-008` (all **seven** §10.3 architecture tests missing; `SID-4.56` — *"A rule that cannot be checked SHALL be treated as unmet"*) |
| **No requirement moved** | `ADR-0017` §3.2 — *"This ADR moves no requirement"* — still holds; **0 moved**. §3.1/§3.2 scope preserved unaltered |
| **No edge created** | **0**. `E-19` already exists and is cited, not created |
| **`PGA-08` not cured** | Conferral is per-act (`ADR-0033` §7.1) |
| **`GCP-20` not repaired** | `DOCUMENTATION_BASELINE.md` §4's missing `PRD-014` row is an **unrelated** defect — carried forward to the Stage 7 freeze record |

`ADR-0017` §5.3's pre-registered number-collision risk, *"Deferred to Stage 5, which is the stage that decides it
mechanically"*, is **now decided: zero collisions in three directions.**

---

## 8. Containment

| Could this pass have… | Evidence |
|---|---|
| **Changed the PRD?** | **No.** `e974960…` verified before the pass, after every one of 12 mutations, and at close |
| **Changed §2 through §2K?** | **No.** `git diff e210978 -- TRACEABILITY_MATRIX.md` → **168 insertions, 3 deletions**, and all three deletions are the **header fields** replaced by their v1.16 values |
| **Changed any other governance document?** | **No.** `PRD_REGISTRY.md`, `DOCUMENTATION_BASELINE.md`, all **53** ADRs untouched |
| **Weakened an existing checker?** | **No.** All **20** pre-existing scripts byte-unchanged; corrected sweep shows the **same 5** pre-existing failures, no more, no fewer (§6.6) |
| **Changed code?** | **No.** `git status --short lib/ packages/ test/ web/ pubspec.yaml` → **0 lines** |

---

## 9. Verdict

✅ **STAGE 5 — PASS. GATE SATISFIED.**

Registration exists in §2 (L1205–1368); it carries counts **and** ranges for all 8 registers; it is verified by
**two** committed tools that reach **180** by different strategies, one of which was **proven able to fail**; and
collisions are **zero in three directions**.

**The final requirement inventory is FROZEN at:**

```
CNF-FR-*   82   001..082   contiguous
CNF-BR-*   11   001..011   contiguous
CNF-INV-*   4   001..004   contiguous
CNF-EVT-*   0   DECLARED EMPTY  (BC-25 publishes no domain event)
CNF-XC-*   16   001..016   contiguous
CNF-CFG-*   0   DECLARED EMPTY  (owns the resolution machinery, not the value list)
CNF-AC-*   59   001..059   contiguous
CNF-GAP-*   8   001..008   contiguous
-----------------------------------------------------------------
TOTAL     180 identifiers · 8 registers · 113 obligation-bearing
coverage  76 / 113 = 67.3%   0 orphans   0 undisclosed   0 proven by test
```

No identifier may be added, renumbered or retired after this point without an approved governance update.

---

## 10. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-20 | Stage 5 conferred. §2L registered at matrix v1.16. Two checkers committed, 12 mutations injected and **12 caught**, 3 self-found instrument defects (`S5-C-01`…`S5-C-03`) and 2 process findings (`S5-F-01`, `S5-F-02`) disclosed, 11 candidates rejected, inventory frozen at 180 |
