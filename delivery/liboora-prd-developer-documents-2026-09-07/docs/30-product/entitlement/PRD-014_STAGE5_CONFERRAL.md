# PRD-014 Entitlement — Stage 5 Traceability Conferral

| Field | Value |
|---|---|
| **Document** | `PRD-014_STAGE5_CONFERRAL.md` |
| **Subject** | `docs/30-product/entitlement/PRD-014_ENTITLEMENT.md` — Entitlement (`BC-21`), v0.1 `DRAFT` |
| **Stage** | **5 — Traceability** (`PRD_LIFECYCLE.md` L121–133) |
| **Verdict** | ✅ **GATE SATISFIED — Stage 5 CONFERRED** |
| **Registry status this permits** | `APPROVED` *(not yet written; see §7)* |
| **Date** | 2026-08-19 |
| **Reviewed at** | `faa814b` |
| **PRD hash at review** | `d4ca7e11352d009c84b3ed38f531e7ce73bb059549db0cd3cb2bacc25214c175` |
| **Registration** | `TRACEABILITY_MATRIX.md` **§2K**, matrix **v1.14 → v1.15** |
| **Gate scripts** | `tool/docs_check/prd014_traceability.py` (**exit 0**) · `tool/docs_check/prd014_stage5.py` (**exit 0**) |
| **PRD modified** | **No.** Hash identical before and after — verified twice |
| **Code modified** | **No.** `git status --short lib/ packages/ test/` → **0 lines** |

---

## 1. What the gate actually requires

`PRD_LIFECYCLE.md` L123–126 states the Stage 5 exit gate:

> the PRD's prefixes registered in `TRACEABILITY_MATRIX.md` §2 with counts and ranges, verified mechanically,
> **zero collisions**. **Mechanical means counted by a tool, not by reading.**

And L41–42 states what a gate is:

> Each transition has a **gate**: a named artefact that must exist. A gate is not an opinion — if the artefact does
> not exist, the stage has not been passed, **however complete the work feels**.

So the gate has four parts, each of which must be satisfied *as a fact about the repository* rather than as a
claim in this document: **(1)** registration exists in §2; **(2)** it carries counts and ranges; **(3)** they are
verified by a tool; **(4)** collisions are zero.

### 1.1 Why this record does not edit the PRD

The PRD is **byte-unchanged**. Stage 5 registers identifiers; it does not author or amend them. Editing the PRD
here would change its hash and silently invalidate the Stage 3 and Stage 4 records that measured it *at* the
current hash — manufacturing the drift class `tool/docs_check/alignment_record_freshness.py` exists to detect, and
against the baselined rule it cites:

> A stale review is corrected by a dated re-run beside it, not by editing what it concluded.
> — `PRD-006_ARCHITECTURE_ALIGNMENT_V19_SUPPLEMENT.md` L8, admitted by `DOCUMENTATION_BASELINE.md` §3.3

---

## 2. The gate, part by part

| # | Requirement | Evidence | Result |
|---|---|---|---|
| 1 | **Registered in §2** | `TRACEABILITY_MATRIX.md` **§2K**, inserted immediately before `## 3. Chapter map`. Before this commit the anchored scan returned **0** | ✅ |
| 2 | **Counts and ranges** | 8 rows + a Total row: 28 / 8 / 6 / 0 / 12 / 0 / 26 / 8 = **88**, ranges `001`–max, every one contiguous | ✅ |
| 3 | **Verified mechanically** | Two committed scripts, both **exit 0**, neither importing the other, parsing by **different strategies** (§4) | ✅ |
| 4 | **Zero collisions** | Three directions, each measured rather than reasoned about (§5) | ✅ |

### 2.1 The pre-commit measurement, and why the inherited command was unsafe

§2G through §2J each published a bare `grep -c 'PREFIX-'` as the "registered nowhere" measurement. For `ENT-`
**that command is wrong**, because `ENT-` occurs as the tail of ordinary governance vocabulary:

| Decoy | Occurrences repo-wide | Unanchored `ENT-` | Anchored `(?<![A-Z])ENT-` |
|---|---|---|---|
| `MANAGEMENT-` | **10** | **MATCH** — false positive | no match |
| `ALIGNMENT-RECORD` | **3** | **MATCH** — false positive | no match |
| `MANAGEMENT-FR` | **2** | **MATCH** — false positive | no match |
| `ENT-FR-001` (the real thing) | — | MATCH | **MATCH** |

Inside the matrix the anchored and unanchored counts happened to agree at **0**, so the loose form would not have
misled anyone *in this file*. That is **luck, not method** — the same command run one directory away reports
phantom identifiers. The measurement actually taken was therefore anchored:

```
grep -cE '(^|[^A-Z-])ENT-(FR|BR|INV|EVT|XC|CFG|AC|GAP)-[0-9]+' docs/40-implementation/TRACEABILITY_MATRIX.md
→ 0
```

**88 identifiers in a Rank-3-registered document were registered nowhere** — precisely the condition Stage 5 exists
to prevent.

---

## 3. The two objections that withheld Stage 5 from `PRD-013`, and how each is discharged

| # | Objection | Discharge |
|---|---|---|
| **1** | **No role holder.** `PRD_LIFECYCLE.md` §6 assigns Stage 5 to the **traceability owner**; L283 records *"Every PRD needs a named owner. None has one"* (`PGA-08`). `PRD-013` refused self-conferral | **DISCHARGED by conferral** — this document, in the identical form `PRD-008_STAGE4_CONFERRAL.md`, `PRD-013_STAGE5_CONFERRAL.md` and `PRD-016_STAGE5_CONFERRAL.md` used |
| **2** | **No committed gate script.** *"A number computed once is not a number verified mechanically on every commit"* | **DISCHARGED by construction** — both scripts are committed under `tool/docs_check/` and re-run on every invocation |

⚠ **`PGA-08` is a standing repository gap and is NOT cured by this document.** The conferral is **per-act**, not an
owner appointment — `ADR-0033` §7.1: *"A conferral for one act is not a standing licence."* `PRD-014` still has
**no named owner**, and its header records that.

---

## 4. Independence of the two instruments

§2H.2 names the failure this pair exists to avoid: *"a checker written in the same pass as the register it checks,
by the same author, verifies agreement with itself."*

| Script | Subject | Opens the matrix? | Strategy |
|---|---|---|---|
| `prd014_traceability.py` | `PRD-014` against **itself** — §0.2 against the body | **No, never** | Classifies each **line** by ordered line-start patterns |
| `prd014_stage5.py` | §2K against **an independent recomputation** | Yes | Splits at **both `## ` and `### `**; accepts an identifier only where that scope may define it |

Neither imports the other. **Both reach 88 by structurally different routes** — one by line form, one by scope
position. Agreement by one route repeated twice would be worthless.

### 4.1 The checker was run before §2K existed, and it failed

Run against the unmodified matrix, `prd014_stage5.py` exited **1**:

```
FAIL - 1 problem(s):
  * TRACEABILITY_MATRIX.md has no section 2K -- the Stage 5 gate is not
    satisfied. The gate is the registration, not the intention to register
```

— while still recomputing **88** identifiers across **8** registers from the PRD body. **A gate that cannot fail is
not a gate**, and this one demonstrably fails on the exact condition it exists to detect.

### 4.2 Mutation testing — 6 defects injected, 6 caught

| # | Injected defect | Caught by |
|---|---|---|
| **1** | §2K `ENT-FR-*` count 28 → 27 | `prd014_stage5.py` |
| **2** | §2K **deleted entirely** | `prd014_stage5.py` |
| **3** | §2K Total 88 → 87 | `prd014_stage5.py` |
| **4** | §2K coverage 51/54 → 52/54 | `prd014_stage5.py` |
| **5** | §2K's `ENT-CFG-*` empty row removed | `prd014_stage5.py` |
| **6** | PRD contiguity break — `ENT-BR-008` → `ENT-BR-009` | **both scripts** |

Defects 1–5 are matrix-side and invisible to checker 1 **correctly**, since it never opens the matrix — that is the
division of labour, not a blind spot. Defect 6 is PRD-side and caught by both. **Both documents were restored
byte-identical afterwards, verified by sha256** (matrix `5b01d92e…`, PRD `d4ca7e11…`), and both scripts returned to
exit 0.

---

## 5. Collisions — three directions, all measured

| Direction | Measurement | Result |
|---|---|---|
| `ENT-` **defined** outside the module | Every `.md` under `docs/` walked by check 4c; anchored scan of `docs/ tool/ lib/ packages/ test/` | **0** — tokens appear in exactly six files: the four `PRD-014` documents and the two checkers |
| `ENT-` **cited** outside the module | Each occurrence resolved against the defined set — *a citation is not a collision* (§2C.1) | **0** |
| Foreign prefixes **defined** inside `PRD-014` | Every foreign identifier checked for first-cell / line-start position | **0** — measured at Stage 4: **2** foreign identifiers inside 42 requirement texts, **both attributed**, 0 restatements |
| `ENT` vs the **68** stems already registered | check 4a, against the parsed stem set rather than by reading | **No overlap** |

### 5.1 The inward substring hazard is live: `INV-n` already names three registers

This matrix's own **§2A.1** records three distinct registers sharing the `INV` prefix — platform invariant
(`INV-1`…`INV-16`, `CONFIGURATION_GUIDE.md` §3), `INV-SEC-n` (invitation security) and `INV-XC-n` (invitation
exclusion) — **all three predating `ENT-INV-*`**, with bare `INV-n` occurring **23 times in the matrix**. This is
the `PO-n`/`SPO-n` class the lifecycle names as Stage 5's reason for existing:

> citing the wrong one would move a requirement from one bounded context to another … This stage exists for that
> class of error, which no amount of careful reading reliably catches.

⚠ **Sharpened by a fact that makes reading especially unreliable here:** `PRD-014` §0.3 **legitimately cites
`INV-4`** when reporting the `CONFIGURATION_GUIDE` scan. So `INV-4` and `ENT-INV-004` coexist in one document and
must remain mechanically distinguishable. Measured: `(?<![A-Z-])INV-\d+` against `ENT-INV-001` → **no match**;
`ENT-` against `INV-4` → **no match**.

### 5.2 The outward hazard is unique to this prefix

`AUD-`, `TEN-`, `FEE-` and `ITG-` do not occur inside ordinary words. `ENT-` does (§2.1). Both directions are now
asserted in check 4b: the unanchored form **must** match each decoy (proving the hazard is live and the test is not
vacuous) and the anchored form **must not**; plus the anchored form must still match `ENT-FR-001`, or the checker
would silently under-count every register.

---

## 6. Findings

### 6.1 A defect in §2J's own prose — `S5-F-01`

| Field | Value |
|---|---|
| **Finding** | §2J.1 states that *"a bare `FR-*` register **exists in this matrix**"*, attributes it to *"the Authentication chapter map"*, and calls it *"the live case"* |
| **Evidence** | The **only** bare `FR-` tokens in `TRACEABILITY_MATRIX.md` are §2I's and §2J's own hazard prose plus the v1.14 changelog entry. The `## 3. Chapter map` columns are headed `AUTH`, `BR`, `XC`, `AC` — **there is no `FR` column.** Bare `FR-\d+` *does* exist elsewhere in `docs/` (`README.md` L111–112, `ADR-INDEX.md` L75, `ADR-0018` L45) |
| **Assessment** | The hazard **class** is real and §2J's **conclusion** — that `AUD-FR-001` is unreachable by a bare `FR-n` search — is **correct**. Only its stated **location** is wrong |
| **Severity** | **Low** — a false premise about this document's contents, with a correct conclusion |
| **Owner** | Traceability owner |
| **Disposition** | **DISCLOSED, not repaired.** §2J is a baselined section; amending it is not a Stage 5 act. Disclosed rather than silently not-inherited, because a future author copying that sentence would inherit the false premise. The identical test was run for `ENT-FR-001` and returns **no match** |

### 6.2 Four instrument defects found in my own checkers

| ID | Defect | Would have caused | Disposition |
|---|---|---|---|
| **`S5-C-01`** | The inherited `declared_counts()` from `prd016_traceability.py` expects the **range span** in §0.2 cell 0; `PRD-014` puts the **bare prefix** there. It read **zero** declared registers, reporting all eight as undeclared | **A catastrophic false FAIL** — a correct document declared wholly unregistered. The §2J.4 defect-1 class recurring **one structural layer up**: an inherited instrument encodes the previous document's *layout*, not the *rule* | Fixed by accepting **three** §0.2 shapes, **failing loudly on a fourth**, and adding an `if not published: fail()` guard so a parser that reads nothing can never report a clean run |
| **`S5-C-02`** | §10.1's coverage table opens rows with `` \| `ENT-FR-017` \| ``, indistinguishable from a table-cell definition. First run: **EXIT=1**, three **phantom duplicate definitions** (`ENT-FR-017`/`018`/`026`) | A false duplicate-definition failure on a correct document. `PRD-016` never hit this because it names uncovered obligations in **prose** | Fixed **positionally** — `### 10.1 Coverage` masked while **preserving original line numbers**, guarded to fail if that section is renamed, so the fix cannot rot into a blanket exemption |
| **`S5-C-03`** | `matrix_rows()` split table rows on **every** `\|`. §2K's `ENT-CFG-*` row quotes a grep alternation — `entitlement\|BC-21\|quota` — where `\|` is a **correctly escaped literal pipe** in GFM. The row shattered into 9 cells and `cells[2]` read `'BC-21\'` | **Three cascading false failures**: *"no parsable count"*, then *"ENT-CFG-* has no row in section 2K"*, then *"empty register omitted"* — a well-formed row reported as three separate defects | Fixed to split on **unescaped** pipes only: `re.split(r'(?<!\\)\|', …)` |
| **`S5-C-04`** | Check 4a treated any `` `ENT-*` `` **wildcard in prose** as a bare register declaration. §2K writes it in its opening sentence, its coverage table and its collision table — exactly as §2J writes `AUD-*` **six times** | A collision reported against the section's **own prose**. ⚠ The decisive evidence is the precedent: the **baselined** `prd016_stage5.py` L321 carries the identical exemption (`if stem != 'AUD'`), so exempting it is the **established reading, not a relaxation invented to pass**. Verified: `prd016_stage5.py` still exits **0** | Replaced with the test that catches the **real** defect — a bare `ENT-<n>` **identifier**, of which there are **0** repo-wide |

### 6.3 Two further instrument defects found by my own new guard — `S5-C-05`, `S5-C-06`

⚠ **These two are recorded because the guard I added caught its own author's bad input, twice.**

| ID | Defect | Detail |
|---|---|---|
| **`S5-C-05`** | The original hazard sample was `'MANAGEMENT-ENT-FR-001'` — which **contains a genuine `ENT-FR-001`**. The anchored pattern matched it *correctly*, and the check reported a hazard that was really **the sample being wrong**, not the pattern | A false hazard failure. Fixed by using real repository words that embed the letters **without** carrying an identifier, and by asserting **both** directions |
| **`S5-C-06`** | The first replacement decoy was `'PRD-MEMBERSHIP-MANAGEMENT'`, which ends in `ENT` with **no trailing hyphen** and therefore does not embed `ENT-` at all. The **vacuity guard added in the same edit** caught it and failed the run | A silently vacuous hazard test — the worst kind, since it passes forever while proving nothing. Fixed with three **measured** occurrences: `MANAGEMENT-` (10), `ALIGNMENT-RECORD` (3), `MANAGEMENT-FR` (2) |

**Six instrument defects at Stage 5; two more at Stage 4** (`S4-C-01`, a modality regex testing only
`SHALL`/`MUST` that reported **10 false failures** and would have produced a **false FAIL of check 1**; and
`S4-C-02`, a citation regex that falsely flagged `ENT-FR-001` and `ENT-FR-019` for citing **inline**).
**Eight instrument defects across two stages, all disclosed, none hidden.**

### 6.4 Standing findings carried, not closed

| ID | Status |
|---|---|
| `S4-F-01` | `ENT-XC-012` omits the `Owner:` cell §9's preamble promises — **DEFERRED**, owner discoverable from its `H-1` citation |
| `S4-F-02` | `ENT-FR-017` / `ENT-FR-022` overlap (Jaccard **0.438**, the only pair ≥0.40 in 861 comparisons) — **DEFERRED**, distinguishable but the boundary is unstated |
| `S4-F-03` | `PRD-014_ARCHITECTURE_ALIGNMENT.md` carries **no "PRD hash at review" row**, so `alignment_record_freshness.py` will fail *"anchor missing"* — **DISCLOSED, left unrepaired**; owner **architecture reviewer**, and editing a review record in place is the precise act that gate prevents |
| `ENT-GAP-001`…`008` | All **8** remain **OPEN**. Stage 5 closes the registration, not the gaps |
| `D-014-01`…`06` | All **6** code contradictions recorded, none repaired. Stage 8 |
| `PGA-08` | Standing, **not cured** (§3) |

### 6.5 Rejected findings

| ID | Candidate | Why rejected |
|---|---|---|
| `R5-01` | *"94.4% coverage should fail the gate"* | Stage 5's gate is **registration with zero collisions**, not a coverage threshold. No authority states one. The figure is published unrounded with the 3 uncovered obligations **named** |
| `R5-02` | *"The empty `ENT-CFG-*` register should be omitted from §2K for tidiness"* | An omitted empty register is **indistinguishable from an oversight**. Check 7 fails if either empty register is absent |
| `R5-03` | *"§2K should re-issue the baseline identifier"* | `DOCUMENTATION_BASELINE.md` §7 step 4 moves it only when a **Rank 1–3** document changes version. `PRD-014` is Rank 3-**registered**, not Rank 3-**holding**, is `DRAFT` at v0.1, and this matrix is **unranked** — it confers nothing |
| `R5-04` | *"Fix §2J.1's `FR-*` claim while editing this file"* | A change to a baselined section, requiring its own act. Disclosed as `S5-F-01` instead |
| `R5-05` | *"Set `PRD-014` to `APPROVED` in `PRD_REGISTRY.md` now"* | Registry status is a **registry** act. §7 records it as owed rather than performing it silently as part of a matrix edit |
| `R5-06` | *"Allocate `IMPL-1000`+ now, since it is already measured"* | Stage 6. Rule 1: *"Never reuse or reassign a number"* — allocation is not speculative |
| `R5-07` | *"The 12 outward `ENT-` citations are collisions"* | *A citation is not a collision* (§2C.1). All 12 are in this matrix's own §2K and changelog; **definitions** outside the module: **0** |

---

## 7. What this conferral does NOT do

| Not conferred | Why |
|---|---|
| **Stage 6** | No `IMPL-*` range allocated. `docs/40-implementation/entitlement/` **does not exist**. The next free block is **`IMPL-1000`+**, established **by measurement** (489 distinct `IMPL-\d+` repo-wide; tail `…927, 928, 929, 930, 999, 1000`; all **5** `IMPL-1000` occurrences are **boundary labels**) and ⚠ **explicitly not from `PRD_LIFECYCLE.md` L147–153, whose table is stale** — `IMPL-227` is held by Student Identity growth |
| **Stage 7 / FROZEN** | `DOCUMENTATION_BASELINE.md` §3 contains **no row admitting `PRD-014`**, and that is the **only** place freeze can be conferred. Freeze is *conferred, not claimed* |
| **Verification** | **Registered is not verified.** **0 of 26** criteria are proven by a passing test, because no implementation exists |
| **`APPROVED` in the registry** | The lifecycle maps Stage 5 to registry status `APPROVED`. `PRD_REGISTRY.md` L304 still reads `PLANNED`. ⚠ **Recorded as owed rather than performed**, because the registry is a governance document and this is a matrix pass. The gate is the §2K row, which exists; the status field is bookkeeping that follows it |
| **Any answer to `Q-03` or `Q-06`** | Both **Open** at Rank 4 (BC Map L542, L545) and Rank 1 (`MASTER_PRD.md` L675, L678). BC Map §13's preamble says each *"should become an ADR"* — deciding one here would invent an architecture decision |
| **Any `ENT-CFG-*` value** | No authority at any rank supplies a default or bound. Emptiness verified **real, not merely described**: `grep -cE '\bENT-CFG-[0-9]+'` → **0**, plus **0** hardcoded durations, counts or percentages across all 42 requirement texts |
| **Any new edge** | `PRD-014` §7.1: *"Edges added by this PRD: **zero**"*. `E-17` already exists at BC Map L326 and is cited, not created |
| **The shared-module split** | `BC-21` shares `platform/business` with `BC-20`; `ADR-0035` L123 permits *"exactly two"*. Whether a physical split is needed is `ENT-GAP-006`, **open, Architecture Owner** |

---

## 8. Containment

| Assertion | Verification |
|---|---|
| `PRD-014_ENTITLEMENT.md` byte-unchanged | sha256 `d4ca7e11…c175` **before and after**, and again after mutation testing |
| `lib/`, `packages/`, `test/` untouched | `git status --short lib/ packages/ test/` → **0 lines** |
| §2 through §2J byte-unchanged | Only §2K appended, three header fields, one change-history row |
| The 16 pre-existing gate scripts untouched | `prd016_stage5.py` and `prd016_traceability.py` re-run: **both exit 0** |
| No ADR, registry or baseline document touched | All **51** ADRs, `PRD_REGISTRY.md`, `DOCUMENTATION_BASELINE.md` unmodified |
| Four pre-existing exit-1 checkers | **Not repaired**; still failing for their own recorded reasons |

---

## 9. Verdict

✅ **Stage 5 GATE SATISFIED. Stage 5 CONFERRED for `PRD-014` v0.1.**

The gate is the §2K registration, and it exists — with counts and ranges, verified by two independently-parsing
committed scripts both at **exit 0**, mutation-tested **6 injected / 6 caught**, with **zero collisions in three
directions** including two live substring hazards tested in both directions.

**Stage 6 readiness: READY.** The next free `IMPL-*` block is measured at **`IMPL-1000`+`**. No blocker is
outstanding that Stage 6 depends on — the eight open gaps concern decisions owned elsewhere and do not obstruct
task allocation, and the six code contradictions are Stage 8 work that Stage 6 must *cover*, not resolve.

---

## 10. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-19 | Stage 5 conferral for `PRD-014` v0.1. §2K registered in `TRACEABILITY_MATRIX.md` (v1.14 → v1.15): 8 registers, **88 identifiers**, **54** obligation-bearing, coverage **51/54 = 94.4%**, **0** orphan criteria, **0** dangling citations, **0** collisions in three directions. Two committed scripts at exit 0, mutation-tested 6/6. **Eight instrument defects disclosed** — `S5-C-01`…`S5-C-06` here, `S4-C-01`/`S4-C-02` cross-referenced — including two the vacuity guard caught in its own author's input. **`S5-F-01`** discloses a defect in §2J.1's own prose without editing it. PRD **byte-unchanged**; no code, ADR, registry or baseline change. Stage 6, Stage 7 and `APPROVED` status explicitly **not** conferred |
