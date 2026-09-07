# PRD-004 — Final Freeze Review

| Field | Value |
|---|---|
| **Document** | `PRD-004_FINAL_FREEZE_REVIEW.md` |
| **Subject** | [`Student_Management_PRD_v1.md`](Student_Management_PRD_v1.md) — `PRD-004`, **v1.2 `DRAFT`** |
| **Review type** | Independent final freeze review — **adversarial**, audit-only |
| **Reviewed at commit** | `6d4f4e7` (`local main == github/main`) |
| **Posture** | Attempted **disproof**, not confirmation. Every count re-derived with an independently written method rather than by trusting the correction report |
| **Date** | 2026-08-04 |
| **Nothing modified** | No document, no code, no manifest. This review is read-only and creates only itself |
| **Verdict** | **B — MINOR CORRECTIONS REQUIRED** (see §14) |

> **Method note.** I did not re-run the correction pass's own scripts and accept their output. For every count I
> wrote a **different** extraction (different regex, different definition of "a definition", different traversal)
> and compared. Where the two agreed I report agreement as corroboration. Where I could construct an attack —
> cross-line grammar, a tightened traceability regex, contradiction between criteria, transitive authority claims
> — I ran the attack and report whether it succeeded. Two genuine defects were found that the correction pass
> missed. Both are outside PRD-004 itself.

---

## 1. Repository and synchronisation state

| Check | Result |
|---|---|
| `HEAD` | `6d4f4e7` — *"docs(PRD-004): final correction report — verdict A…"* |
| Working tree | **clean** — `git status --porcelain` empty |
| `local main` | `6d4f4e792d2a353c800a490afd02218236e86896` |
| `github/main` | `6d4f4e792d2a353c800a490afd02218236e86896` |
| **Synchronised?** | ✅ **YES — identical SHAs** |
| Total change since `a030b07` | **8 files**: 6 modified + 2 added, all documentation |

**Item 12 — GitHub/local synchronisation: ✅ VERIFIED.**

---

## 2. Item 11 — Unauthorised frozen/ranked document changes

The strongest possible form of this test: diff the **entire** ranked and code surface between the pre-correction
baseline and `HEAD`.

```
git diff --stat a030b07 HEAD -- docs/MASTER_PRD.md docs/00-governance/ docs/10-architecture/ \
  docs/20-* docs/30-product/authentication/ docs/30-product/library/ \
  docs/30-product/student-identity/ lib/ test/ tool/ packages/ pubspec.yaml web/ android/
→ (empty)
```

**Empty.** Nothing ranked, nothing frozen, no ADR, no code, no manifest, no test was touched.

The eight changed files are:

| File | Rank | Change |
|---|---|---|
| `Student_Management_PRD_v1.md` | **unranked, `DRAFT`** | M |
| `PRD-004_IMPLEMENTATION_TASKS.md` | **unranked** | M |
| `PRD-004_TRACEABILITY.md` | **unranked** | M |
| `PRD-004_ALIGNMENT_REPORT.md` | **unranked** | M |
| `TRACEABILITY_MATRIX.md` | **unranked** | M |
| `docs/README.md` | **unranked** | M |
| `PRD-004_SECOND_INDEPENDENT_REVIEW.md` | n/a | A |
| `PRD-004_FINAL_CORRECTION_REPORT.md` | n/a | A |

Cross-checked against `DOCUMENTATION_BASELINE.md` §4 (L152–176): all six modified files are unranked or `DRAFT`.
**No ADR was required, and none was fabricated.**

**Item 11: ✅ VERIFIED — zero unauthorised changes.**

---

## 3. Item 1 & 2 — `SR-01` (HIGH): counts and task range

### 3.1 Independent recount

I wrote my own extractor treating a *definition* as either a body line `` `ID` — text `` or a table row
`` | `ID` | … | ``, classified by a fresh prefix map. It agrees with the matrix on **every register**:

| Register | Matrix §2C claims | **My independent count** | Agree? |
|---|---|---|---|
| `SM-c.n` | 107 | **107** | ✅ |
| `SM-BR-n` | 16 | **16** | ✅ |
| `SM-XC-n` | 14 | **14** | ✅ |
| `SM-INV-n` | 11 | **11** | ✅ |
| `SM-EV-n` | 10 | **10** | ✅ |
| `SM-PO-n` | 12 | **12** | ✅ |
| `SM-AC-n` | 32 | **32** | ✅ |
| `SMCFG-n` | 7 | **7** | ✅ |
| `LMD-n` | 31 | **31** | ✅ |
| `SM-GAP-n` | 11 | **11** | ✅ |
| **Base total** | **251** | **251** | ✅ |
| Sub-lettered | 15 | **15** (11 `SM-`, 4 `LMD-`) | ✅ |
| **Total** | **266** | **266** | ✅ |

Contiguity independently confirmed for all eight fixed-prefix registers. Per-chapter `SM-c.n`, computed
separately: Ch 1 = 8 · Ch 2 = 16 · Ch 3 = 17 · Ch 4 = 12 · Ch 6 = 8 · Ch 7 = 17 · Ch 8 = 17 · **Ch 10 = 12** —
matching matrix L161 exactly, **with zero numbering gaps in any chapter** (I tested for holes, not just totals).
Chapters 5 and 9 hold no `SM-c.n` by design, which the matrix states.

### 3.2 Task range

```
comm -3 <(grep -o 'IMPL-3[0-9][0-9]' PRD | sort -u) <(grep -o 'IMPL-3[0-9][0-9]' TASKS | sort -u)
→ (empty)
count → 24
```

PRD §10.7 and `PRD-004_IMPLEMENTATION_TASKS.md` hold **identical** 24-task sets, `IMPL-300`…`IMPL-323`.

### 3.3 Was the Stage 5 gate actually unblocked?

`PRD_LIFECYCLE.md` (at `docs/00-governance/prd-ecosystem/PRD_LIFECYCLE.md`) L121–126 requires registration
*"verified mechanically… counted by a tool, not by reading."* The matrix now agrees with two independently written
tools. **The gate is satisfiable.**

**`SR-01`: ✅ CORRECTLY FIXED, both halves.**

---

## 4. Item 2 — `SR-02` (HIGH): the three negated-MUST requirements

### 4.1 Line-level scan

All three read as prohibitions:

- `SM-10.9` (L1027) — *"An endpoint **MUST NOT** accept `tenant_id`… Tenant scope **MUST** derive from the
  session's authorisation context (`SM-8.2`, `SM-8.3`, `X-13`)."*
- `SM-7.14` (L829) — *"An event payload **MUST NOT** contain a credential, an OTP, a raw document byte, a
  `FileRef` resolvable without authorisation, or a `BC-10`-owned personal field."*
- `LMD-24a` (L633) — *"A composed row in this table **MUST NOT** be read from this module's **domain layer**…"*

### 4.2 Attack: cross-line grammar

Line-based grep cannot see a negation whose `MUST` falls on the next line. **I reassembled the document into 306
paragraph blocks and re-scanned across line breaks.** Result: **1 hit**, and it is the §11 change-history row at
L1227 *quoting* the old defective pattern for the record. Zero genuine hits. Double-negative scan: **0 hits**,
both line-level and cross-line.

### 4.3 Was `X-13` weakened?

**No — strengthened.** The pre-correction text never named `X-13`; the repaired text invokes it explicitly and
adds the positive derivation rule. `X-13` is independently confirmed as a real, enforced rule: `ARCHITECTURE_RULINGS.md`
L111 calls it *"Mandatory"*, `BOUNDARY_CHECKER_DESIGN.md` §3.12 implements it, and Gate 4 test *"X-13 fires on a
tenant-less key on each declared surface"* passes. `SM-7.14`'s prohibited set is unchanged; `LMD-24a` retains all
four prohibitions plus `SID-2.38`–`SID-2.41`.

**`SR-02`: ✅ CORRECTLY FIXED. No rule weakened; one strengthened.**

---

## 5. Item 2 & 9 — `SR-10` (MEDIUM): guardian acceptance criteria

### 5.1 The criteria exist and are objective

| ID | Criterion | Objective? |
|---|---|---|
| `SM-AC-31` | DOB < 18, no `GuardianLink` ⇒ **rejected with a typed domain error**; no `StudentRecord` committed; **not a generic 500** | ✅ Names input state, outcome, *and* an excluded outcome |
| `SM-AC-32` | DOB ≥ 18, no `GuardianLink` ⇒ **succeeds**; supplying one is also accepted; neither path blocks | ✅ Both branches asserted |

### 5.2 Attack: do `SM-AC-29` and `SM-AC-31` contradict each other?

This was my most promising line of attack. `SM-AC-29` says an absent-DOB enrollment **is recorded** (minor-status
`Unknown`, held in `Pending`); `SM-AC-31` says a minor without a guardian **is rejected, nothing committed**. If
both applied to the same input, they would be contradictory.

**The attack fails.** Reading §4.2.1's case table (L440–442) and `SM-4.5a`, the three cases partition on a single
discriminant — *is a DOB present at `BC-10`?*

| Case | Discriminant | Behaviour | Criterion |
|---|---|---|---|
| 1 | DOB present, age < 18 | reject, typed error, nothing committed | `SM-AC-31` |
| 2 | DOB present, age ≥ 18 | succeed | `SM-AC-32` |
| 3 | DOB **absent** | record with minor-status `Unknown`, held in `Pending`, guardian required, `ID-6` closed | `SM-AC-29` |

No input satisfies two rows. `SM-INV-3` was independently confirmed to cover both branches — L314: *"Guardian
mandatory if age < 18, **or if minor-status is `Unknown`**"* — so the invariant is not silent on case 3 either.
The absent-DOB behaviour is **unchanged** by this pass.

**`SR-10`: ✅ CORRECTLY FIXED. Three cases partition cleanly; no contradiction.**

---

## 6. Item 3 — `RF-01` / `AR-1` architecture validity

### 6.1 The attack

The correction pass re-attributed §5.4's four composition rows from `AR-1` (Rank 5) to `SID-2.7` (Rank 3, frozen).
I tried to break this three ways.

**Attack 1 — does `AR-1` really omit `BC-03`/`BC-05`?** Confirmed. `grep -c` on `ARCHITECTURE_RULINGS.md` returns
**0** for both. `AR-1`'s worked table (L38–50) composes only {`BC-19`, `BC-25`, `BC-29`, `BC-06`, `BC-02`, `BC-04`,
`BC-23`}. The withdrawn *"identical precedent"* claim **was** false, and §5.4 now says so in the document itself.

**Attack 2 — does `SID-2.7` actually authorise these four contributors?** Read verbatim at
`Student_Identity_PRD_v1.md` L455–495. Its contributor table lists **Membership `BC-02`** (plan · status · expiry),
**Attendance `BC-03`** (percentage · present days), **Seat Management `BC-04`** (seat · shift · zone), **Finance
`BC-05`** (payment status · outstanding balance). All four, read-only, governed by `SID-2.38`–`SID-2.41`. The
authority is real and it is Rank 3 frozen.

**Attack 3 — is `SID-2.7` transferable from `BC-10` to `BC-01`?** This is the subtle one: `SID-2.7` authorises
*`BC-10`'s* profile screen, not `BC-01`'s directory. Does PRD-004 over-extend it?

**The attack fails, for a structural reason.** `SID-2.41` states composition *"**SHALL NOT** be performed inside
this module's domain layer. It is an **application-layer read composition**, consistent with ruling `AR-1`."* The
frozen text therefore establishes a **mechanism** — application-layer read composition of a public read model, with
no integration edge — and expressly ties it to `AR-1`, which is a *classification* ruling of general application.
Decisively: **`BC-10` composes all four contexts with no BC Map §7 edge to any of them.** I verified §7 (L316–335)
contains no `BC-10`→`BC-02/03/04/05` edge. So composition-without-an-edge is established practice at Rank 3, and
PRD-004 relies on the mechanism rather than claiming `SID-2.7`'s specific grant as its own. §5.4 states exactly
this distinction (*"`AR-1` classifies this mechanism; `SID-2.7` authorises these specific contributors"*).

### 6.2 Did PRD-004 assert an edge it may not?

No. `grep "BC-26"` shows PRD-004 never lists `BC-26` as a consumer; §7.4 discloses the omission and defers.
§5.4 marks the four composition rows *"none — none required"* and states the `E-01`/`E-09` edges are **event**
edges that *"**MUST NOT** be changed to suit this screen."* No new edge is claimed anywhere.

**Item 3: ✅ VERIFIED — `AR-1`/`RF-01` architecture remains valid, and is now better-founded than before.**

---

## 7. Item 4 — `SM-EV-10` ownership

`SM-EV-10` is `enrollment.StudentLinkedToPerson`, producer **`BC-01`**, consumer `BC-10` via the `E-13` ACL.
Verified against the frozen BC Map §8 (L407): `| BC-01 | enrollment.StudentLinkedToPerson | BC-10 (via ACL) | The
consented social bridge |`. `E-13` is confirmed in §7 as *"**The only bridge**"* between enrollment and global
identity.

Naming convention `<Context>.<Aggregate><PastTenseVerb>` (BC Map §8, binding) — satisfied.
Guards intact: `SM-7.12a` (consent gate via `BC-18`), `SM-7.12b` and `SM-7.15` (**never** `StudentRecordId`),
`SM-10.12` (outbox biconditional). Register still **closed at ten**; `IMPL-320` carries it.

**Item 4: ✅ VERIFIED — correctly owned by `BC-01`, matching a frozen Rank 4 assignment.**

---

## 8. Item 5 — Global Identity boundary

| Probe | Result |
|---|---|
| Does PRD-004 store `BC-10`-owned fields? | **No.** L414: Address, Email, Occupation *"are owned by `BC-10` (`SID-2.8`) and read through `E-13`"* |
| Date of Birth | `SM-4.5`: *"derived from the `BC-10` Date of Birth read through `E-13`, **never stored here**"* |
| Global photo | L417: owned by `BC-10`; the module holds only a distinct **Library Identification Photo** — matching `SID-2.7`'s own contributor row |
| Event leakage | `SM-7.14` forbids `BC-10`-owned personal fields in payloads; `SM-7.15` forbids `StudentRecordId` in global events |
| Does it push DOB mandatory upstream? | `SM-4.5c` **forbids** it and defers to `SM-GAP-10` |
| Data minimisation | `SM-8.15` cites `SID-5.7`, which I verified **verbatim** at L1111–1113 |

**Item 5: ✅ VERIFIED — boundary correct and defended in both directions.**

---

## 9. Items 6 & 7 — Enrollment/Membership separation; Directory as read composition

**Separation.** Seven independent load-bearing statements, all consistent with frozen BC Map L209 (*"Two
independent state machines"*): `SM-2.7` (`Expired` **MUST NOT** be an `EnrollmentStatus`), `SM-BR-2`, `SM-6.8`
(renewal delegated to `BC-02`), `LMD-24b` (composition **MUST NOT** make `BC-01` authoritative over
`MembershipStatus`), `LMD-25` (two independent badges, never merged), L509. `SM-AC-6` tests it, and its
`SR-06` citation repair *reinforced* the separation by pointing at BC Map L209.

**Read composition.** `LMD-24` (normative, never authoritative), `LMD-24a` (application layer only; no
persistence, no caching beyond the display request, no invariant evaluation), `LMD-24b` (writes delegated to
owning command APIs), `LMD-22`, `SM-7.1a`. Corroborated mechanically: `module_dependencies.yaml` already grants
`app` (rank 9) ports to `domain/library`, `domain/person`, `domain/social` and `platform/*`, so the composition is
legal **without any manifest change** — and Gate 4's test *"app → domain/library is deliberately NOT waived"*
passes, proving the layering is enforced rather than asserted.

**Items 6 & 7: ✅ VERIFIED.**

---

## 10. Item 8 — Traceability, mechanically

```
Identifiers located in the PRD      : 251
Proposed gaps (SM-GAP-*, excluded)  : 11
Denominator — real requirements     : 240
  traced DIRECT                    : 218
  traced DERIVED                   : 9
  UNTRACED                         : 13
Coverage                           : 227/240 = 94.6%
```

Untraced, reprinted by the tool on every run and named in PRD §10.5.1: `SM-2.8`, `SM-3.12`, `SM-3.13`, `SM-3.14`,
`SM-3.16`, `SM-3.17`, `SM-4.1`, `SM-6.1`, `SM-6.3`, `SM-6.5`, `SM-10.1`, `SM-10.7`, `SM-10.8`. **Falsifiable, as a
traceability claim should be.**

### 10.1 Attack: was the metric gamed?

**Attack 1 — the `SR-14` self-citation loophole.** The script's `EXTERNAL` regex includes `\bPRD-0\d\d\b`, which
matches `PRD-004` itself. I did not take the correction report's word that this is immaterial. **I patched the
regex to `\bPRD-0(?!04)\d\d\b` and re-ran.** Result: **`227/240 = 94.6%`, 13 untraced — identical.** The loophole
moves nothing. Independently confirmed immaterial.

**Attack 2 — were requirements reworded to satisfy the regex?** The four `SR-07` citations were read against their
sources. `SM-8.15` cites `SID-5.7`, quoted verbatim and confirmed at L1111–1113 (*"A field not needed for that
purpose **SHALL NOT** be added here merely because there is nowhere else convenient"*) — materially the same rule.
`SM-6.8` cites BC Map L209, which I read and which does say `BC-02` owns `MembershipStatus`. `SM-6.6` cites
`E-20`/`X-10`/`SM-8.10`; `SM-8.11` cites `SM-8.10`/`X-10`. All four sources are real and were already true.

**Attack 3 — did the denominator shrink to flatter the ratio?** No: it **rose**, 238 → 240. A pass gaming the
metric would have moved requirements into the excluded `SM-GAP-*` bucket. Two were added, but as genuine gaps
(`SM-GAP-11`) and criteria (`SM-AC-31/32`), and the real-requirement count increased.

**Item 8: ✅ VERIFIED — counts and traceability are mechanically correct and honestly derived.**

---

## 11. Item 9 & 10 — Acceptance criteria; duplicates and contradictions

### 11.1 Acceptance criteria

| Check | Result |
|---|---|
| Rows | **32**, `SM-AC-1`…`SM-AC-32`, contiguous |
| Empty `Verifies` cells | **0** |
| ACs citing no requirement | **0** |
| AC-cited local identifiers that are undefined | **none** |
| Duplicated criterion text | **none** |
| Vague/unfalsifiable language (*appropriate*, *properly*, *reasonable*…) | **0 occurrences** |
| Criteria with no observable outcome | **0** — my first heuristic flagged 18, but on inspection all use indicative outcome verbs my regex missed (*yields*, *cannot*, *remains*, *is refused*). Re-run with a corrected verb set: **0** genuine |
| Distinct requirements carried | **50** |

I record the false positive because a reviewer who reported "18 untestable criteria" without reading them would
have manufactured a HIGH finding out of a regex defect.

### 11.2 Duplicates

My independent extractor found **2** identifiers with more than one definition-shaped line: `SM-7.1a` (L69, L719)
and `SM-8.4a` (L76, L880). Both inspected: L69 and L76 are **§0.2 register rows** (`| SM-7.1a | SM-7.1 — scopes it
to the domain layer | RF-01 |`), L719 and L880 the real definitions. **Benign — no competing definitions, no
collisions.**

### 11.3 Contradictions

Tested and **not** found: the DOB triad (§5.2), `EnrollmentStatus` vs `MembershipStatus` (§9), domain-layer vs
application-layer composition (§9), `SM-4.5c` vs `SM-GAP-10`. Every prohibition in §1.5 `SM-XC-*` was checked
against the requirement that could violate it; none does.

**Items 9 & 10: ✅ VERIFIED.**

---

## 12. Findings of this review

Two genuine defects. **Neither is in PRD-004.** Both are in unranked satellite documents and both are
count/consistency staleness of exactly the class `SR-01` addressed — the correction pass fixed four such documents
and missed two sites.

| ID | Severity | Location | Finding | Evidence | Freeze impact |
|---|---|---|---|---|---|
| **`FR-01`** | **LOW** | `docs/README.md` L107, L108 | The document index is **stale for two satellites the correction pass itself bumped**. L107 states `PRD-004_TRACEABILITY.md` is **v1.1** — the file's header reads **v1.2**. L108 states `PRD-004_IMPLEMENTATION_TASKS.md` is **v1.0** with **`IMPL-300`…`IMPL-317`, five waves** — the file is **v1.1** with **`IMPL-300`…`IMPL-323`, six waves**. The task-range error is the *same defect* `SR-01` was raised for, surviving in a third location | `grep -m2 Version` on both files vs `sed -n '107,108p' docs/README.md` | **Does not block.** `docs/README.md` is unranked and is an index, not a specification. But it now misstates the very range whose correctness was the HIGH finding |
| **`FR-02`** | **LOW** | `PRD-004_ALIGNMENT_REPORT.md` §5 (L126, L142) | The report **contradicts itself on the gap count**. Its §4 row was updated to *"**Eleven** are recorded as `SM-GAP-*`"*, but §5's heading still reads *"Missing requirements — **nine**"*, its table lists only `SM-GAP-1`…`SM-GAP-9`, and its blockquote says *"These **nine** rows are quoted from `PRD-004` §10.6."* `SM-GAP-10` and `SM-GAP-11` are absent from the table | L38 says Eleven; L126/L142 say nine; table ends at `SM-GAP-9` | **Does not block.** The report is explicitly *"Not part of the specification"* (per `docs/README.md` L105) and PRD-004 §10.6 is authoritative for the gaps, listing all 11 correctly. But the blockquote's claim to quote §10.6 is now false |

### Why these are not upgraded

Neither touches PRD-004's normative content; neither creates a contradiction *within* the specification; neither
affects a requirement, a criterion or an architecture decision. PRD-004 §10.6 lists all 11 gaps correctly and
`TRACEABILITY_MATRIX.md` §2C records 11. Both defects are in documents that either disclaim specification status
or serve as an index. They are **LOW** and mechanically trivial to fix — but they are real, they are of exactly
the class the last round was convened to eliminate, and `FR-02` makes a document assert a false quotation.

### Findings I attempted and could not sustain

Recorded so the board can see the attacks that failed rather than only the ones that landed:

| Attempted | Outcome |
|---|---|
| Cross-line negated-MUST survives in `SM-10.9`/`SM-7.14`/`LMD-24a` | **Failed** — 306-block reassembly finds only the change-history quotation |
| `SM-AC-29` contradicts `SM-AC-31` | **Failed** — cases partition on DOB presence; `SM-INV-3` covers `Unknown` |
| `SID-2.7` is not transferable from `BC-10` to `BC-01` | **Failed** — `SID-2.41` establishes the mechanism and ties it to `AR-1`; `BC-10` itself composes with no §7 edge |
| The 94.6% is inflated by the `PRD-004` self-citation loophole | **Failed** — patched regex yields the identical 94.6% |
| Requirements were reworded to satisfy the traceability regex | **Failed** — all four `SR-07` sources read and confirmed pre-existing; denominator rose |
| Acceptance criteria are untestable | **Failed** — 0 vague terms, 0 without an outcome once the heuristic was corrected |
| Duplicate identifiers exist | **Failed** — 2 apparent, both §0.2 register rows |
| PRD-004 asserts an unauthorised `BC-26` edge | **Failed** — never listed; disclosed and deferred as `SM-GAP-11` |
| A ranked or frozen document was quietly edited | **Failed** — diff over the entire ranked + code surface is empty |
| `SR-13`'s rejection was self-serving | **Mostly failed** — see §13 |

---

## 13. On `SR-13`, and a nuance the correction report did not concede

The correction report rejected its own predecessor's finding `SR-13` on the grounds that
`PRD-004_CORRECTION_REPORT.md` §3 L160 reads *"`RF-16` — stale roadmap. **NOT REJECTED**, but out of scope for
this pass."* I verified that text independently. It is present verbatim, and the rejection is **correct on its
central claim**: §3 does not classify `RF-16` as rejected.

**But there is a nuance neither document states.** §3's heading is *"## 3. Findings rejected, with evidence"*
(L140). The `RF-16` paragraph sits **inside that section**. So a reader scanning by section heading — which is how
the second review reached its conclusion — is misled by the document's own structure, even though the row itself
is explicit. The second review's *diagnosis* was wrong; its *instinct* that the placement is confusing was not.

This is a presentational blemish in a historical, unranked report, not a defect in PRD-004, and I do not raise it
as a finding. I record it because the correction report declared the finding simply "wrong", when the more precise
statement is: *the claim was wrong; the confusion it arose from is real and lives in the section layout.* A freeze
board should know the difference.

---

## 14. Validation summary

| # | Check | Method | Result |
|---|---|---|---|
| 1 | Requirement IDs | independent extractor | ✅ 251 base / 266 total; all registers contiguous; **0 numbering gaps in any chapter** |
| 2 | Duplicate IDs | independent scan | ✅ 2 apparent, both §0.2 register rows — **0 collisions** |
| 3 | Traceability | script + **tightened-regex re-run** | ✅ `227/240 = 94.6%`; identical under the hardened regex |
| 4 | Acceptance criteria | 7 structural probes | ✅ 32 rows, 0 empty, 0 undefined, 0 vague, 0 duplicated |
| 5 | Links | full `docs/**/*.md` resolver | ✅ **535 checked, 0 broken** |
| 6 | YAML | `yaml.safe_load` | ✅ **4/4 OK** |
| 7 | Gate 1 — format | `dart format --set-exit-if-changed` | ✅ `59 files (0 changed)` · EXIT=0 |
| 8 | Gate 2 — analyze | `flutter analyze` | ✅ **`No issues found!`** |
| 9 | Gate 3 — arch checker | `dart run tool/check_module_boundaries.dart` | ⚠️ **EXIT=1 — pre-existing**; 5 `ADR-0012` waivers (`BLK-01`). `git diff a030b07 HEAD -- lib/ test/ tool/ packages/ pubspec.yaml` is **empty**, so causation by the documentation pass is nil |
| 10 | Gate 4 — arch tests | `flutter test test/architecture/` | ✅ all passed, incl. `X-13`, `X-10`, L1-acyclic, *"app → domain/library deliberately NOT waived"* |
| 11 | Gate 5 — full suite | `flutter test -r compact` | ✅ **`+77 All tests passed!`** |
| 12 | Frozen-document integrity | diff over entire ranked + code surface | ✅ **EMPTY** |
| 13 | git diff scope | `--name-status` | ✅ 8 files, all unranked/draft documentation |
| 14 | GitHub sync | `rev-parse` both refs | ✅ **identical SHA** `6d4f4e7` |

Gate 6 (`flutter build web --release`) not run: no code, asset or manifest input changed, so the build input is
byte-identical to the last green build. Stated as reasoning, not claimed as a run.

**Per instruction, the following are NOT treated as freeze blockers:** 0 executed acceptance tests (implementation
has not started) and the 11 clearly-labelled `PROPOSED GAP` entries. I tested the gaps for the exception the
instruction allows — *do they create an actual contradiction or a missing mandatory requirement?* — and they do
not: each names an absent external decision, `SM-GAP-10` and `SM-GAP-11` are deferred to named owners with an ADR
requirement, and none leaves a mandatory behaviour undefined (the DOB case, the only one that could, is fully
specified by `SM-4.5a`–`SM-4.5c` with `SM-AC-29`).

---

## 15. Verdict

### **B — MINOR CORRECTIONS REQUIRED**

**Everything the freeze depends on is sound.** Both HIGH findings are genuinely resolved and survived deliberate
attack: `SR-01`'s counts reproduce exactly under an independently written extractor, and the task sets are
identical; `SR-02`'s three requirements read as prohibitions with no residue at line level **or** across line
breaks, and `X-13` emerged strengthened. `SR-10`'s two criteria are objective and the three DOB cases partition
without contradiction. The `AR-1`/`SID-2.7` architecture is valid and now better-founded than before the
correction — I tried three ways to break the authority chain and failed each time. `SM-EV-10` is correctly owned
per a frozen Rank 4 assignment. The Global Identity boundary, the Enrollment/Membership separation and the
Directory-as-read-composition all hold, the last two corroborated by *passing architecture tests* rather than by
prose. No ranked or frozen document was touched. Local and GitHub are identical.

**I am nonetheless withholding A**, for one narrow reason: **`FR-01` leaves the implementation-task range
misstated in a third document.** `docs/README.md` L108 still advertises `IMPL-300…IMPL-317, five waves`. That the
range was stale in two documents was the substance of `SR-01`, the HIGH finding this entire round was convened to
close. Freezing PRD-004 while a reader following the documentation index is told the wrong task range — and the
wrong version for the traceability satellite — would freeze the specification alongside a live instance of the
defect that blocked it. `FR-02` compounds this: the alignment report now claims to *quote* PRD-004 §10.6 while
listing nine of its eleven gaps.

Both are LOW, both are outside PRD-004, and both are mechanical edits to unranked documents requiring **no ADR,
no requirement change, and no change to PRD-004 itself**. This is a **B**, not a C: nothing needs to be
re-specified, re-numbered or re-architected.

**Why not A.** Two verified stale-count defects remain, one of them a third instance of the HIGH finding.
**Why not C.** No requirement, criterion, count, invariant or architecture decision in PRD-004 is wrong.
**Why not D.** No architectural blocker. The two open architecture questions (`SM-GAP-10`, `SM-GAP-11`) are
defects *in other, frozen documents*, correctly deferred to named owners with an ADR requirement, and PRD-004
behaves deterministically under both without asserting an unauthorised edge.

### Required to reach A

1. `docs/README.md` L107 — `PRD-004_TRACEABILITY.md` **v1.1 → v1.2**.
2. `docs/README.md` L108 — `PRD-004_IMPLEMENTATION_TASKS.md` **v1.0 → v1.1**, `IMPL-300…IMPL-317` →
   **`IMPL-300`…`IMPL-323`**, *five waves* → **six waves**.
3. `PRD-004_ALIGNMENT_REPORT.md` §5 — reconcile *"nine"* with its own §4 *"Eleven"*, either by adding
   `SM-GAP-10`/`SM-GAP-11` to the table or by scoping the heading to the nine gaps present at creation.
4. *(Optional, hygiene)* Add the two new review documents to the `docs/README.md` index; neither is currently listed.

None requires an ADR. None touches PRD-004. After these, I would expect **A** on re-review.

**PRD-004 has NOT been frozen by this review, and I have not modified any document.** Work stops here.

---

## 16. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-04 | Initial issue. Independent adversarial final freeze review at commit `6d4f4e7`. All 12 mandated items verified; 10 disproof attacks attempted, 8 failed outright and 1 partially sustained as a presentational nuance (§13). Two genuine LOW defects found, both outside PRD-004 (`FR-01` stale `docs/README.md` index incl. a third instance of the `SR-01` task range; `FR-02` self-contradictory gap count in the alignment report). Counts independently reproduced: 251 base / 266 total · 227/240 = 94.6% · 32 criteria · 24 tasks · 11 gaps. Verdict **B — MINOR CORRECTIONS REQUIRED**. PRD-004 not frozen. |
