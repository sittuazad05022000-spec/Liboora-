# `PRD-021A` A1–A8 — Stage 4 Requirements Review Record

| Field | Value |
|---|---|
| **Stage** | **Stage 4 — Requirements Review** (`PRD_LIFECYCLE.md` **L108–119**) |
| **Subject** | `PRD-021A` parts **A1–A8**, treated as one multi-part PRD, evaluated **individually** |
| **Gate** | *"conflicts closed or explicitly deferred **with a reason and an owner**"* (**L119**) |
| **Predecessor** | Stage 3 ✅ **CONFERRED** — `PRD-021A_STAGE3_ALIGNMENT_2026-08-31.md` (529 L, `1270a7689e107c19`) + `PRD-021A_STAGE3_ALIGNMENT_A4_A6_RESOLUTION_2026-08-31.md` (344 L) |
| **Measured at** | `25554a9`, working tree **clean** |
| **Reviewer role** | Requirements reviewer (`PRD_LIFECYCLE.md` §6 **L278**). ⚠ **No named holder exists** — `PGA-08` |
| **Authority claimed** | ⛔ **NONE beyond measurement.** See §12. This record is a **measurement**, not a conferral |
| **Mandate** | **Stage 4 only.** ⛔ No PRD modified · no ADR created · no identifier minted · no Rank 1–5 document touched · no registry/baseline/matrix update · no Stage 5 · no Stage 6 · no freeze · no code · no push |
| **Subject hashes** | ⛔ **All eight byte-unchanged by this review** — verified before and after (§9) |
| **Date** | 2026-08-31 |
| **Verdict** | ⚠️ **CONDITIONALLY PASSED — 5 of 6 checks.** Check **4** ⛔ **FAILS**: **211 of 232** acceptance criteria cite no requirement. The **L119 gate itself is SATISFIED** (121 open conflicts, **0** without an owner). **1 STAGE-4 BLOCKER**, **7 REQUIRED REPAIRS**, **4 disclosed non-blocking gaps**, **3 pre-existing repository defects**, **6 already resolved**, **9 false positives**. ⚠ **5 instrument defects disclosed** (§10) |

> ⛔ **Stage-3 PASS did NOT carry to Stage 4, and this record says so rather than rounding up.**
> Stage 3 asks *"is this PRD lawful against Ranks 1–5?"*; Stage 4 asks *"is this PRD **buildable
> and verifiable** as written?"* (`PRD-016_STAGE4_REQUIREMENTS_REVIEW.md` §1). The six checks
> share **no** overlap. A1–A8 passed 48/48 Stage-3 cells and still fail Stage-4 check 4 on
> **91%** of their acceptance criteria.
>
> ⭐ **The blocker is precisely the `PRD-020` `RQ-1` defect, at 6.6× the scale.** `PRD-020`
> failed this same check on 32 of 62 rows and repaired it by writing requirement citations
> inline. Here it is 211 of 232 across eight documents.
>
> ⛔ **No requirement was written to close any criterion.** `PRD-008_STAGE4_CONFERRAL.md` §4:
> *"The most corrupting way to pass a requirements review is to write the missing requirement."*
> **0 identifiers minted; every subject byte-unchanged.**

---

## 1. Method, and what it is worth

Every count is produced by a script over the document text, not by reading. **Where a
mechanical result disagreed with a document's own claim, the disagreement was investigated to
root cause before either was believed** (`PRD-016` §1). That happened **five** times, and in
**four** of them **my instrument was wrong, not the document** — all five are disclosed in §10.

**Definition of "defined"**: a line whose first non-decoration token is the identifier,
followed by a `|`. Status emoji (`⏸`, `✅`, `⛔`, `⚠`) and `~~strikethrough~~` precede
identifiers throughout these documents, so the anchor tolerates up to 8 leading
non-alphanumeric bytes. **My first anchor did not, and under-counted A4 by 5 rows and A8 by 1.**

**Definition of "requirement"** for check 4: an identifier in a **normative** register —
`FR`, `BR`, `INV`, `XC`, `NFR`, `SEC`, `AUTH`, `API`, `EVT`, `RM`, `SIG`, `CFG`, `CONF`, `EC`,
`FS`, `OBS`, `DEP`. ⛔ **`DEC`, `GAP`, `ADR`, `RSK` are NOT requirements** — they are conflict
and risk registers. A criterion citing only `LCG-GAP-006` is **not** requirement-backed; it is
gap-backed, which is the opposite.

### 1.1 Authoritative file set — confirmed present and unchanged (Phase 2)

| Part | sha256 (16) | Lines | File |
|---|---|---|---|
| A1 | `bbd3f3945ecc947c` | 1532 | `PRD-021A_A1_LIBRARY_COMMUNITY_FOUNDATION_DRAFT_v0.2.md` |
| A2 | `a81759234ce7a4c8` | 1959 | `PRD-021A_A2_LIBRARY_COMMUNITY_FEED_CONTENT_DRAFT_v0.8.md` |
| A3 | `ecbccedcdde3cf01` | 1330 | `PRD-021A_A3_COMMUNITY_FEED_RANKING_DRAFT_v0.6.md` |
| A4 | `ce37c794e345a733` | 766 | `PRD-021A_A4_COMMUNITY_GROUPS_AND_ROLES_DRAFT_v0.1.md` |
| A5 | `32c09960753476c4` | 1964 | `PRD-021A_A5_OFFICIAL_LIBRARY_COMMUNICATION_DRAFT_v0.1.md` |
| A6 | `abf9c88b59de90c7` | 1188 | `PRD-021A_A6_COMMUNITY_SAFETY_PRIVACY_MODERATION_DRAFT_v0.1.md` |
| A7 | `82b37001d344028d` | 953 | `PRD-021A_A7_COMMUNITY_NOTIFICATIONS_DRAFT_v0.1.md` |
| A8 | `7712e933235ff373` | 1925 | `PRD-021A_A8_TECHNICAL_AND_PRODUCTION_ARCHITECTURE_DRAFT_v0.1.md` |

⚠ **Disclosed:** four of these filenames were **guessed wrong** on first attempt (A3, A5, A7,
A8) and returned "file not found". Had that been read as "nothing to measure", **half the
review would have passed by not running.** Names were resolved with `ls` and every measurement
re-run. This is instrument defect **I-1**.

### 1.2 The authority question, answered before any artefact was produced

`PRD-008_STAGE4_CONFERRAL.md` establishes that a **conferral** quotes its conferring
instruction verbatim and states *"That instruction **is** the authority, and it is **the only
authority claimed**."* **The instruction governing this review contains no such conferral** —
it directs me to *determine* whether authority exists and forbids claiming conferral falsely.

⇒ The lawful artefact is a **REQUIREMENTS_REVIEW (measurement)**, which the `PRD-016` and
`PRD-020` precedents show requires no special authority. **A CONFERRAL is NOT produced.** §12
names the exact authority that would be required.

---

## 2. The six mandated checks — verbatim, and the result

Gate text, `PRD_LIFECYCLE.md` **L108–119**:

| # | Check | Failure mode (repository's own words) | A1–A8 result |
|---|---|---|---|
| 1 | Every requirement testable | *"The system should be fast" — unverifiable* | ⚠ **PASS with 1 repair** — 902 modal-bearing requirement rows; **1** genuine vague construction |
| 2 | Every exclusion states what must be impossible | *"An exclusion is not a deferral"* | ⛔ **FAIL → reclassified.** See §4 — this is a **pre-existing repository-wide convention**, not a PRD-021A defect |
| 3 | Every configurable has a default and a range | *"Unbounded configuration is a specification hole"* | ⚠ **PASS with 2 repairs** — 16 configurables in A1, 14 carry default+bound, **2** do not |
| 4 | **Every acceptance criterion maps to a requirement** | *"Orphan criterion"* | ⛔⛔ **FAIL — 211 of 232 (91%)**. §3 |
| 5 | No requirement restates another PRD's | *"Two sources of truth"* | ✅ **PASS** — cross-prefix use is **citation**, not restatement. §6 |
| 6 | Business rules do not contradict Rank 1 | *"Rank 1 wins; the PRD is wrong"* | ✅ **PASS** — 23 `MP-*` citations, 0 contradictions. §7 |
| — | **GATE (L119)** | *"conflicts closed or explicitly deferred with a reason and an owner"* | ✅ **SATISFIED** — 155 register rows, 34 closed, 121 open, **0 without an owner**. §8 |

**5 of 6 checks pass. Check 4 fails. The gate passes.**

---

## 3. ⛔ Check 4 — the Stage-4 BLOCKER

> *"Every acceptance criterion maps to a requirement | **Orphan criterion**"*

### 3.1 Mechanical result

| Part | AC rows | Cite a **requirement** | Cite only `DEC`/`GAP`/`ADR` | Cite **nothing** | **Orphaned** |
|---|---|---|---|---|---|
| A1 | 60 | 2 | 1 | 57 | **58** |
| A2 | 36 | 0 | 2 | 34 | **36** |
| A3 | 22 | 1 | 3 | 18 | **21** |
| A4 | 18 | 0 | 5 | 13 | **18** |
| A5 | 21 | 0 | 0 | 21 | **21** |
| A6 | 20 | 7 | 0 | 13 | **13** |
| A7 | 21 | 11 | 0 | 10 | **10** |
| A8 | 34 | 0 | 0 | 34 | **34** |
| **Total** | **232** | **21** | **11** | **200** | **211** |

### 3.2 Root cause — structural, not clerical

**The acceptance-criterion tables have no requirement-mapping column at all.** Measured
headers:

| Part | Table header | Mapping column? |
|---|---|---|
| A1 §17.1 (**L598**) | `\| Ref \| Criterion \|` | ⛔ none |
| A4 §30 (**L610**) | `\| ID \| Criterion \| Writability \|` | ⛔ none |
| A6 §27 (**L1054**) | `\| ID \| Criterion \| Status \|` | ⛔ none |

A criterion that cites no requirement **cannot be shown to verify anything**. At Stage 9 the
question *"which requirement is now proven?"* has no mechanical answer for 211 of 232 rows.

### 3.3 The two candidate defences, both tested and both rejected

**Defence 1 — "a separate mapping artefact supplies it."** `PRD-020` proves such an artefact
is a sanctioned mechanism (`PRD-020_STAGE4_AC_REQUIREMENT_MAPPING.md`, 227 L). **Measured: no
equivalent exists for any PRD-021A part.** Only A1 and A4 have a `Traceability` section at all.

**Defence 2 — "the Traceability sections supply it."** ⛔ **Rejected on the precedent's own
reasoning.** `PRD-020_STAGE4_AC_REQUIREMENT_MAPPING.md` §1.2 refuses to accept an
inverse-direction table:

> *"It runs the **inverse** direction. `G-1 → TSF-AC-001…008` says a goal is *evidenced by*
> criteria; the gate asks whether a criterion is *grounded in* a requirement."*

Measured directions:

| Section | Maps | Direction | Satisfies check 4? |
|---|---|---|---|
| A1 §23 (**L827**) | requirement → upstream authority | requirement outward | ⛔ no |
| A4 §34 (**L704**) | upstream authority → citation | authority inward | ⛔ no |

**Neither runs criterion → requirement.** A1 §23's own preamble confirms it: *"Every A1
**requirement** traces to an existing authority"* — requirements, not criteria.

### 3.4 Classification — **STAGE-4 BLOCKER** (category 1)

| Field | Value |
|---|---|
| **Files** | All eight |
| **Lines** | A1 §17/§38.9 · A2 §29 · A3 §30 · A4 §30 **L611–628** · A5 §27 · A6 §27 · A7 §24 · A8 §39 |
| **Requirement violated** | `PRD_LIFECYCLE.md` **L112** |
| **Why Stage 4 cannot pass** | 91% of criteria are orphans. The check's stated failure mode is *"orphan criterion"*; this is that failure at scale |
| **Owner** | **Product owner** (per `PRD-020` `RQ-1`, same defect, same owner) |
| **Smallest lawful resolution** | Add an inline citation to each criterion row, pointing at a **pre-existing** requirement. ⛔ **Mint nothing.** ⛔ Where no requirement states the obligation, declare the criterion UNMAPPED with a reason and an owner — do **not** write the requirement |
| **Why I did not repair it** | §11 |

---

## 4. Check 2 — measured FAIL, reclassified as a PRE-EXISTING REPOSITORY DEFECT

### 4.1 Mechanical result

| Part | `XC-*` rows | No impossibility clause |
|---|---|---|
| A1 | 37 | **30** |
| A2 | 35 | **32** |
| A3 | 16 | **14** |
| A4 | 16 | **16** |
| A5 | 37 | **37** |
| A6 | 0 | 0 |
| A7 | 0 | 0 |
| A8 | 2 | 0 |
| **Total** | **143** | **129** |

### 4.2 Why this is not a PRD-021A defect

The `PRD-016` standard (§3.1) requires each exclusion row to carry `MUST NOT` or *impossible*.
The PRD-021A exclusion tables are structurally different — measured header, A1 **L716**:

```
ID | Excluded from A1 | Held instead by
```

This is a **scope-allocation register**: it names the excluded thing and **who holds it
instead**. `PRD-016` §3.2 identifies exactly this as the gate's real concern — *"an exclusion
that **defers** rather than excludes: 'we are not doing X' with no statement of who is"* — and
**every** PRD-021A row names a holder (`BC-15`, `BC-13`, A2, A3, Enterprise Architecture).

⚠ **But several holders are release **bands**, not owners** — `LCM-XC-003` *"Enterprise
Architecture L967-973, **V2**"*, `LCM-XC-005` *"**V3**"*. A band is a **deferral**, which is
the precise failure the check names.

**Classification: PRE-EXISTING REPOSITORY DEFECT (category 4).** The convention is inherited
from the Rank-3 Enterprise Architecture V1/V2/V3 banding, is used identically across parts
authored by different hands, and **changing it is a repository-wide convention decision**, not
a PRD-021A repair. Recorded, not repaired. **Owner: Governance Owner** (vacant — `ADR-0080`
§5 **L85**).

---

## 5. Checks 1 and 3 — pass with 3 required repairs

### 5.1 Check 1 — testability

902 requirement rows carry a modal across the eight parts. Two flagged; **one is genuine**:

| Finding | Line | Text | Class |
|---|---|---|---|
| **`S4-R1`** | A1 **L1130** `LCM-NFR-012` | *"rebuildable within an operationally **acceptable** window"* | ⛔ **REQUIRED REPAIR (2)** — unbounded. This is the *"should be fast"* pattern verbatim. **Owner: Product owner** |
| — | A1 `LCM-SIG-014` | *"never a fallback to a last-known-good allow"* | ✅ **FALSE POSITIVE (6)** — matched on *"good"* inside `last-known-good`, a compound technical term. Fully testable |

### 5.2 Check 3 — configurables

`LCM-CFG-001`…`014` = 16 rows. 14 carry a default and a bound (`LCM-CFG-002` *"default
Disabled"*, `LCM-CFG-010` *"SHALL be **Disabled**"*, `LCM-CFG-012` *"missing … treated as
Disabled"*).

| Finding | Line | Text | Class |
|---|---|---|---|
| **`S4-R2`** | A1 **L471** `LCM-CFG-008` | *"MUST NOT make its visibility, its window duration, or any invariant configurable"* | ✅ **FALSE POSITIVE (6)** — a **prohibition** on configurability. A thing that must not be configurable has no default or range by definition |
| **`S4-R3`** | A8 **L1652** `LCT-CONF-*` | 2 rows, no default, 1 no range | ✅ **FALSE POSITIVE (6)** — `LCT-CONF-*` is A8's **cross-part conflict** register (`LCT-CONF-001` = the event conflict), not configuration. Prefix collision with `CONF` |

⚠ **Both check-3 "failures" were my instrument.** Instrument defect **I-4**.

---

## 6. Check 5 — no requirement restates another PRD's ✅ PASS

Cross-prefix identifier use is heavy and was tested as a restatement candidate:

| Part | Foreign identifiers used | Verdict |
|---|---|---|
| A3 | 37 `LCF-FR-*` | ✅ **citation** — A3 §5 receives A2's already-authorised set |
| A5 | 28 `LCF-FR-*` | ✅ **citation** — `LCO-XC-001`…`003` explicitly **exclude** A2/A3 scope and name the holder |
| A8 | 22 `LCF-FR` + 20 `LCR-FR` + 12 `LCN-FR` + 22 `LCF-NFR` | ✅ **citation** — A8 is the architecture part; it reconciles others' requirements and owns none of them |
| A6 | 18 `LCF-ADR-*` | ✅ **citation** |

⭐ **The strongest evidence is a refusal.** A5 `LCO-FR-113`: *"⛔ **A2's event set is CLOSED at
six.** … A5 therefore proposes **no seventh event** by its own authority."* A part that
declines to restate A2's contract when it would have been convenient is not forking it.

**0 duplicated ownership found.** The exclusion register is the mechanism and it is used
deliberately, exactly as `PRD-020` check 5 found.

---

## 7. Check 6 — business rules do not contradict Rank 1 ✅ PASS

23 `MP-*` citations across the eight parts; 22 `MASTER_PRD` references. **0 contradictions.**
Every "contradiction-language" hit (52 total) was inspected: all are the parts **asserting
compliance** or **recording that they do not override** Rank 1 — e.g. A6 **L732** *"⛔ A6
**SHALL NOT** mint a permission identifier"*, A8 **L1882** *"No credential/OTP/session outside
`BC-18` | ✅ | A8 mentions none"*.

**Security sub-audit:**

| Assertion | Measured | Result |
|---|---|---|
| No `PERM-*` minted | 1 token, A1 **L906** `A1-PERM-PARTICIPATE` — *"**Removed** — replaced by derived capability"* | ✅ **withdrawal record, not a mint** |
| Authz delegated to `BC-18` | 42 `BC-18` references; A2 **L964**, A5 **L703**, A6 **L732** each prohibit minting | ✅ |
| `ID-2` intact | 42 `ID-2` references; `ADR-0078` cited 60× | ✅ |
| Pagination convention | `cursor` in A1/A2/A3/A8; **0** `offset`/`page=`/`keyset` conflicts | ✅ single convention |

---

## 8. ✅ The L119 GATE — SATISFIED

> *"conflicts closed or explicitly deferred **with a reason and an owner**."*

| Part | Register rows | Closed | Open | **Open without an owner** |
|---|---|---|---|---|
| A1 | 22 | 2 | 20 | **0** |
| A2 | 25 | 12 | 13 | **0** |
| A3 | 19 | 9 | 10 | **0** |
| A4 | 25 | 6 | 19 | **0** |
| A5 | 29 | 1 | 28 | **0** |
| A6 | 9 | 0 | 9 | **0** |
| A7 | 11 | 0 | 11 | **0** |
| A8 | 15 | 4 | 11 | **0** |
| **Total** | **155** | **34** | **121** | **0** |

⭐ **121 open conflicts do NOT fail this gate.** The gate permits deferral; it requires a
**reason and an owner**. All 121 have both.

⚠ **9 rows initially reported as owner-less; all 9 were my instrument** (defect **I-5**).
Each was opened individually:

| Row | Owner cell | Adjudication |
|---|---|---|
| A1 `LCM-GAP-003`, `LCM-GAP-007` | `Product` | ✅ owner — abbreviated form |
| A1 `LCM-DEC-004` | `Product` | ✅ owner |
| A1 `LCM-ADR-001`, `LCM-ADR-002` | — | ✅ **not a deferral register.** Header is `ID \| Requirement \| Status \| Why`; `LCM-ADR-002` reads *"An ADR **is not required**"* |
| A4 `LCG-GAP-010` | `PO + AO` | ✅ owner — Product Owner + Architecture Owner |
| A4 `LCG-ADR-003` | `Required, Proposed` | ✅ status register, not a deferral |
| A5 `LCO-DEC-005` | `Product Owner` (**L1817**, wrapped line) | ✅ owner |
| A5 `LCO-DEC-007` | `Product Owner + Privacy Owner` (**L1825**) | ✅ owner |

---

## 9. Phases 6–9 — the four special checks

### 9.1 Phase 6 — A1 `LCM-AC-041` re-measured from scratch

⛔ *"Do not declare PASS merely because the owner decision exists."*

| Test | Result |
|---|---|
| Ruling actually reflected | ✅ **L671** instantiates it: *"for a membership expiring on D the protected window is `D+1`, `D+2`, `D+3`; in force on `D+1` and out of force on `D+4`"* |
| AC now writable | ✅ `W₀` has a value; the sentence is constructible |
| Observable test precise | ✅ Two boundary assertions, both decidable |
| Maps to correct requirement | ⛔ **NO** — the row cites `LCM-GAP-001` and `ADR-0036`, **not** `LCM-FR-036`…`044`, the requirements that define the window. **Part of the §3 blocker** |
| No hidden ambiguity | ⛔ **NO — two stale antecedents found** |

| Finding | Line | Text | Class |
|---|---|---|---|
| **`S4-R4`** | A1 **L1494** | §44.1 still reads *"Declared **unwritable** pending `LCM-GAP-001` \| 1 — `LCM-AC-041`"* — contradicting **L671** and **L755**, which mark both CLOSED | ⛔ **REQUIRED REPAIR (2)**. Owner: **Product owner** |
| **`S4-R5`** | A1 **L1247** | `LCM-GWT-020` asserts *"Given `LCM-GAP-001` is still open"* — an antecedent that can **no longer be constructed** | ⛔ **REQUIRED REPAIR (2)**. Owner: **Product owner** |
| — | A1 **L1377** | `LCM-CHK-029` *"leave `LCM-AC-041` marked unwritable until `LCM-GAP-001` closes"* | ✅ **ALREADY RESOLVED (5)** — a conditional whose condition is now met; reads correctly |

⚠ **A1 §24 vs §44 AC count (43 vs 60)** — ✅ **FALSE POSITIVE (6).** §24 is explicitly labelled
*"an **interim** count taken at §27 … superseded by §44"*, and §44's note states *"the
difference is not drift."* Measured: **60** distinct ids. §44 is correct.

### 9.2 Phase 7 — A4 `LCG-AC-015` / `LCG-AC-016`

⛔ *"Do not treat the A4 Stage-3 resolution as automatically satisfying Stage 4."*

| Test | Result |
|---|---|
| Closed `CommunityRole` enum | ✅ **L208** — `OWNER`, `MODERATOR`, `MEMBER`, *"⛔ no other role SHALL be added"*; `Admin` expressly **not** admitted |
| `OWNER > MODERATOR > MEMBER` | ✅ **L208**, **L663** |
| Closed visibility values | ✅ **L231** — `PUBLIC`, `PRIVATE`, *"no `UNLISTED`, `HIDDEN`, `SECRET` or `INVITE_ONLY`"* |
| Ownerless-community rule | ✅ **L455** — departure of the last `OWNER` **BLOCKED**; ⛔ no auto-promotion |
| Publication carrier | ✅ `ADR-0084` — zero edges; `E-20`/`E-23` wildcard carriers |
| Event contracts | ✅ `LCG-ADR-002` CLOSED; **0** `LCG-EVT-*` minted |
| `LCG-AC-015` testable | ✅ closed-set membership + rejection outside it — decidable |
| `LCG-AC-016` testable | ✅ blocked + ≥1 `OWNER` retained + no implicit promotion — three decidable assertions |
| Maps to a requirement | ⛔ **NO** — both cite only `PO-4`/`PO-6`/`LCG-DEC-*`. **Part of the §3 blocker** |

**Three stale antecedents found** — the rulings closed the decisions but the flow diagrams and
field tables were not swept:

| Finding | Line | Text | Class |
|---|---|---|---|
| **`S4-R6`** | A4 **L243** | `communityRole` field: *"⏸ Value set **OPEN** — `LCG-DEC-003`"* — contradicts **L208**/**L663** CLOSED | ⛔ **REQUIRED REPAIR (2)**. Owner: **Product owner** |
| **`S4-R7`** | A4 **L295**, **L358**, **L363**, **L395**, **L402** | *"⏸ Which value that is depends on `LCG-DEC-003`"* / *"is a **Product Owner** act — `LCG-DEC-003`, **OPEN**"* / flow markers `⏸ (LCG-DEC-003)` | ⛔ **REQUIRED REPAIR (2)**. Owner: **Product owner** |
| — | A4 **L409** | Flow marker `⏸ OPEN (LCG-DEC-006)` | ⚠ **DISCLOSED NON-BLOCKING GAP (3)** — `LCG-DEC-006` is genuinely **half** closed; the restoration clause is open. The marker is **correct** |
| — | A4 **L470** | *"unique is **OPEN**, `LCG-DEC-005`"* | ✅ **ALREADY RESOLVED (5)** — correctly refers to the un-ruled uniqueness half, tracked as `LCG-DEC-005b` |

⚠ **A4's own disclosure stands and is honoured by this review**: **L605–608** states `LCG-` is
**PROPOSED, not registered** and its criteria are **UNRATIFIED**. **Owner: Governance Owner
(vacant).** Category **3**.

### 9.3 Phase 8 — A6 reporting

⛔ *"Do NOT weaken a requirement merely because the command surface exists."*

| Test | Result |
|---|---|
| `LCS-FR-030` intact | ✅ **L660** — *"⚠⚠ **THIS REQUIREMENT STILL STANDS AND IS STILL NOT RELAXED** … `ADR-0084` does NOT weaken it by one word."* Only the **antecedent** discharged; the rule is unchanged and re-arms on unavailability |
| `LCS-AC-014` testable against the real mechanism | ✅ **L1057** — reporter `PersonId` **absent** from every store/log/cache/index/event/audit record, because filing never transits `BC-15`. `PENDING`, ⛔ not passing |
| `LCS-AC-017` testable against the real mechanism | ✅ **L1068** — re-stated against the **general fail-closed condition**, exercised by **fault injection** rather than by an open decision. `PENDING` |
| `BC-13` command surface real | ✅ `PRD-020` **§21.3 L1800** — `FileAbuseReport`, actor *"Any authenticated person"*. **Zero inbound edges by design** |
| Requirement weakened? | ⛔ **NO.** Verified: `LCS-FR-030`'s text is a standing invariant; both ACs remain `PENDING`, neither recorded as passing |
| Maps to a requirement | ✅ **the only part that partly does** — 7 of 20 cite `LCS-SEC-002`, `LCS-FR-030`, `LCS-FR-061` |

✅ **A6 passes Phase 8.** No weakening. This is the correct pattern: *antecedent discharged,
rule retained, criterion re-stated against a real mechanism, status held at `PENDING`.*

### 9.4 Phase 9 — A7/A8 event contract

Authoritative contract = A2 §24 (**L1489–1494**), **six** events, closed by `LCF-FR-104`.

| Test | Result |
|---|---|
| A7 defines no withdrawn event as active | ✅ **L316–319** — `LCN-EVT-004`…`007` all ⛔ **WITHDRAWN**, retained as records |
| `CommentPublished` consistent | ✅ A7 **L315** renamed from `CommentAdded`; A2 already used `CommentPublished` — the drift was A7's and is gone |
| `ReactionChanged` consistent | ✅ A7 **L316** renamed from `ReactionAdded` |
| Withdrawn ids never reused | ✅ 4 withdrawn, **0** refilled; `LCN-FR-019`/`020`/`026` retained as **VOID** records for audit |
| **No seventh event** | ✅ **A2 = 6, A7 active = 3, A5 = 0** (`LCO-FR-113` refuses). **No seventh exists** |
| Naming follows BC Map convention | ✅ all `community.*` |
| A8 references the same active set | ⛔⛔ **NO — A8 IS STALE** |

| Finding | Line | Text | Class |
|---|---|---|---|
| **`S4-R8`** | A8 **L857–893** §15.3 | Headed *"⛔ OPEN OWNER DECISION — **the most material finding in A8**"*. Reconciles A7's **seven** facts, lists `CommentAdded` and `ReactionAdded` as *"name divergence"* and four as *"no counterpart"*. **SD-1 resolved all of it** — renames applied, four withdrawn. `LCT-FR-048` still blocks A7's register as *"unsettled"* | ⛔ **REQUIRED REPAIR (2)**. Owner: **Social Domain Owner** (as A2's owner) |
| **`S4-R9`** | A8 **L1879** | Repeats *"`BC-15` is the source of **ZERO** edges"* and calls A4/A6 *"a **genuine Stage-3 Check-2 failure**"*. ⛔ **`ADR-0084` disproved exactly this** — it was a column-offset instrument error; five wildcard-source edges exist (`E-17`…`E-20`, `E-23`) | ⛔ **REQUIRED REPAIR (2)**. Owner: **Architecture Owner** |
| — | A7 **L316** | Cites the same disproved *"ZERO edges"* claim inside a **withdrawal rationale** | ⚠ **DISCLOSED NON-BLOCKING GAP (3)** — the withdrawal outcome stands on `LCF-FR-104` (contract closure) independently; only the supporting rationale is stale |

⭐ **A8 §15.3 is the second-most serious finding in this review.** It is not a stale
cross-reference — it is A8's **self-declared most material finding**, still labelled OPEN,
still blocking A7's event register, and **already resolved**. A reader of A8 alone would
conclude the event contract is unresolved.

---

## 10. ⚠ Defects in this review's own instruments — all five disclosed

| # | Defect | Effect | Correction |
|---|---|---|---|
| **I-1** | Four filenames guessed (A3, A5, A7, A8) | 4 of 8 parts returned "not found". **Half the review would have passed by not running** | Resolved with `ls`; every measurement re-run |
| **I-2** | AC row anchor required the identifier at byte 0; these documents prefix `⏸`/`✅`/`⛔`/`~~` | Under-counted **A4 by 5** (13 vs 18) and **A8 by 1** (34 vs 35) — and A4's 5 missed rows include **`LCG-AC-015`/`016`, the Phase 7 targets** | Anchor widened to tolerate ≤8 leading non-alphanumeric bytes; counts now reconcile with every part's own register claim |
| **I-3** | First check-4 pass counted `DEC`/`GAP`/`ADR` citations as requirement mappings | Under-reported the orphan count (183 vs the true **211**) | Normative registers separated from conflict registers. ⭐ **This defect made the subject look *better* than it is** |
| **I-4** | Check 3 treated any `CONF`/`CFG` prefix as configuration, and prohibitions as unbounded configurables | 2 phantom failures (A8's conflict register; A1's *"MUST NOT be configurable"*) | Rows opened individually; both withdrawn |
| **I-5** | L119 owner regex matched only full role titles | **9 phantom owner-less rows** — missed `Product`, `PO + AO`, `Product Owner + Privacy Owner`, and two status registers | All 9 opened individually; all 9 withdrawn. Gate result corrected to **0** |

⚠ **Four of five over-reported defects; one (I-3) under-reported.** Publishing them matters:
had the 211 genuine orphans been reported alongside 11 uncorrected phantoms, a reader would
have had no way to tell which figures to trust.

---

## 11. Phase 5 — repairs considered and NOT performed

⛔ **This review modified nothing.** Every one of the eight identified repairs
(`S4-R1`, `S4-R4`…`S4-R9`, plus the §3 blocker) requires authority I do not hold:

| Repair | Authority required | Why I stopped |
|---|---|---|
| §3 blocker — 211 AC citations | **Product owner** | `PRD-020` set the precedent that this repair **edits the subject** and publishes before/after hashes. That is a subject-modifying act on eight `DRAFT` documents. ⛔ Not granted here |
| `S4-R1` — bound `LCM-NFR-012` | **Product owner** | Choosing the window **is** the product decision. Writing a number would be *"simulating the decision"* |
| `S4-R4`, `S4-R5` — A1 stale antecedents | **Product owner** | Sweeping a closed gap's residue is a content edit |
| `S4-R6`, `S4-R7` — A4 stale antecedents | **Product owner** | Same |
| `S4-R8` — A8 §15.3 stale conflict | **Social Domain Owner** | A8 routes it there explicitly (**L893**). Closing another owner's routed conflict is not mine |
| `S4-R9` — A8 stale ZERO-edges claim | **Architecture Owner** | `ADR-0084` is the corrective authority; applying it to A8's Stage-3 self-assessment is an architecture act |

⭐ **The instruction's own words govern**: *"If a repair requires Product Owner / Architecture
Owner / Governance Owner / Social Domain Owner authority that is not already granted: **STOP
at that item and record it. Do not simulate the decision.**"*

⛔ **And the deeper reason.** `PRD-008_STAGE4_CONFERRAL.md` §4: *"The most corrupting way to
pass a requirements review is to write the missing requirement."* Repairing check 4 by
inventing requirements for 211 criteria would manufacture check 5's *"two sources of truth"*
failure — trading a **disclosed** failure for a **hidden** one.

---

## 12. Phase 11 — Stage-4 conferral: ⛔ NOT CONFERRED

⚠ **Evidence PASS ≠ formal conferral — and the evidence does not even PASS.**

| Question | Answer |
|---|---|
| Who may confer Stage 4? | **Requirements reviewer** (`PRD_LIFECYCLE.md` §6 **L278**) |
| Does a named holder exist? | ⛔ **No** — `PGA-08`: *"Every PRD needs a named owner. None has one"* |
| How has it been exercised before? | `PRD-008_STAGE4_CONFERRAL.md`: *"exercised by **direct, explicit and unconditional conferral of the human principal**"*, with the instruction quoted **verbatim** as the authority basis |
| Does the current instruction contain such a conferral? | ⛔ **NO.** It directs me to *determine* whether authority exists and states: *"do not falsely claim Stage 4 CONFERRED"* |
| Is Stage 4 conferred? | ⛔ **NO** |

### 12.1 The exact authority that would be required

> A **direct, explicit and unconditional conferral of Requirements Reviewer authority** by the
> human principal, for the specific act of reviewing and — **if the evidence satisfies
> `PRD_LIFECYCLE.md` L108–119** — conferring Stage 4 on `PRD-021A` A1–A8.

⛔ **Even with that conferral, Stage 4 could not be conferred today**, because check 4 fails on
211 of 232 criteria. `PRD-008_STAGE4_CONFERRAL.md` §5.1 is explicit that a conferral *"does
not close any gap"* — and `SID-4.56` holds that *"a rule that cannot be checked SHALL be
treated as unmet."* **The blocker must be repaired by its owner first.**

### 12.2 What this record does NOT claim

| Not claimed | Why |
|---|---|
| That Stage 4 is conferred | No conferral exists. §12 |
| That Stage 4 passed | 5 of 6. Check 4 **fails**. §3 |
| That the 211 orphans are acceptable | They are a **BLOCKER**, recorded as one |
| That any conflict is closed | **121** remain open with reasons and owners |
| That `LCG-` is a registered prefix | It is **PROPOSED**. A4 **L605** |
| That any criterion passes | **0** recorded as passing across all eight parts |
| Stage 5, 6 or 7 readiness | ⛔ None entered. Stage 5 registrations: **0** |
| Any authority over Rank 1–5 | **Byte-unchanged**, verified |

---

## 13. Verification performed

| Check | Result |
|---|---|
| `git status --porcelain` | **clean** before and after |
| Subject files modified | **0** — all eight hashes identical to §1.1, re-verified post-review |
| `docs_check` | ✅ **`CHECKERS=28 TOTAL_NONZERO=6`** — exactly the baseline (`alignment_record_freshness`, `prd004/005/006/007_traceability`, `prd020_stage5`) |
| Protected hashes | ✅ all 7 intact: `5c31a3363d99a5f6` · `5031fcc97a95980e` · `eab88c9ab3be6f91` · `34761df53bfbf149` · `7e1c69f92363a5e5` · `bf16eb2de31d2994` · `1270a7689e107c19` |
| Partial hashes | ✅ ownership `head -569` = `7bc36cd91ffc0d4f` · BC Map `head -612` = `ea23b1c7fabc0922` |
| Rank 1–5 + tooling diff vs `cf1d07f` | ✅ **EMPTY** |
| ADR count | **75** (61 accepted · 13 proposed · 1 accepted-in-principle) — **unchanged** |
| Identifiers minted | **0** |
| New permissions / policy values | **0** |
| `IMPL-*` in PRD-021A | **0** |
| Stage-5 matrix registrations of `LC*-` | **0** |
| Stage 6 / freeze | ⛔ not entered |
| Push | ⛔ **NOT performed** |

---

## 14. Determination

⚠️ **STAGE 4 — CONDITIONALLY PASSED ON EVIDENCE, NOT CONFERRED.**

**5 of 6 checks pass. The L119 gate is satisfied. Check 4 fails on 211 of 232 acceptance
criteria, and that is a STAGE-4 BLOCKER owned by the Product owner.**

| Part | Checks passed | Blocking finding |
|---|---|---|
| A1 | 5 of 6 | 58 orphan criteria · `S4-R1`, `S4-R4`, `S4-R5` |
| A2 | 5 of 6 | 36 orphan criteria |
| A3 | 5 of 6 | 21 orphan criteria |
| A4 | 5 of 6 | 18 orphan criteria · `S4-R6`, `S4-R7` · `LCG-` unregistered |
| A5 | 5 of 6 | 21 orphan criteria |
| A6 | 5 of 6 | 13 orphan criteria — ✅ **best-mapped part; passes Phase 8 without weakening** |
| A7 | 5 of 6 | 10 orphan criteria — ✅ **passes Phase 9** |
| A8 | 5 of 6 | 34 orphan criteria · `S4-R8`, `S4-R9` — ⛔ **stale on the resolved event contract** |

⛔ **No part may proceed to Stage 5.** ⛔ **Stage 4 is not conferred.** ⛔ **Nothing is frozen.**

> ⭐ **The goal was correct Stage-4 completion, not forcing a PASS.** Stage 3 passed 48/48 and
> Stage 4 still fails, because they measure different things. Recording that honestly — with
> five of my own instrument defects published alongside it — is the only outcome that leaves
> the next reviewer able to trust these numbers.

---

## 15. Change history

| Version | Date | Change |
|---|---|---|
| 1.0 | 2026-08-31 | Created as the **Stage 4 Requirements Review Record** for `PRD-021A` A1–A8, measured at `25554a9`. All six checks decided mechanically. **5 of 6 PASS**; check 4 ⛔ **FAILS** on 211 of 232 criteria (**1 STAGE-4 BLOCKER**). L119 gate ✅ satisfied — 121 open conflicts, **0** without an owner. **7 required repairs** (`S4-R1`, `S4-R4`…`S4-R9`), **4 disclosed non-blocking gaps**, **3 pre-existing repository defects**, **6 already resolved**, **9 false positives**. Phase 6: `LCM-AC-041` writable but 2 stale antecedents. Phase 7: A4 role/visibility/ownerless sets all closed; 2 stale antecedents. Phase 8: ✅ A6 passes, **no requirement weakened**. Phase 9: ✅ A7 clean, **no seventh event**; ⛔ A8 stale on the resolved contract. **5 instrument defects disclosed.** ⛔ **Stage 4 NOT CONFERRED** — no Requirements Reviewer conferral exists. **0 PRDs modified · 0 identifiers minted · 0 ADRs created · 0 Rank 1–5 bytes changed · no Stage 5 · no Stage 6 · no freeze · no push.** |
