# `PRD-021B` B0–B9 Implementation Tasks — `IMPL-1600` … `IMPL-1689`

| Field | Value |
|---|---|
| **Module** | Global Social Graph, Safety, Discovery, Ranking, Recommendations, Scope, Messaging, Realtime/Media (`PRD-021B` parts **B0–B9**, consolidated) |
| **Source PRD** | `PRD-021B` B0–B9 — ten `v0.1` Stage-2 drafts in [`../../30-product/social-graph/`](../../30-product/social-graph/) |
| **Aggregates** | `BC-11` (`Friendship`, `FriendRequest`, `BlockList`, `RateLimitCounter`; ⚠ `Mute` — **`FOD-2`**) and `BC-12` (`Conversation`, `Message`, `DeliveryReceipt`, `RetentionPolicy`). ⛔ No aggregate is created by this document |
| **Range allocated** | **`IMPL-1600` … `IMPL-1689`** — **90** tasks, contiguous, every member carrying **exactly one** row · **`IMPL-1690`…`1749`** declared growth reserve, reserved and **not** allocated |
| **Subjects (byte-unchanged by this document)** | The ten B0–B9 drafts, sha256 in §2.1. ⛔ **Not one byte of any subject is modified by this document** |
| **Identifiers available to cite** | **1,300** across **113** registers, all contiguous from `001`, **0** phantoms (§2.2) |
| **Obligations claimed** | ⛔ **NONE.** This document allocates work. It does not perform it, and it does not certify that any of it is done |
| **Acceptance criteria proven** | ⛔ **0 of 242.** Stage 6 allocates work; it does not perform it. Proof is Stage 8/9 |
| **Stage** | **6 of 9 — Implementation Tasks** (`../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md` **L135–153**) |
| **Status of this document** | **Task allocation.** ⛔ Not a freeze, not a baseline row, not an ADR, not a requirement |
| **Authority** | **Implementation lead** (`PRD_LIFECYCLE.md` **L280** — *"owns Stages 6 and 8"*), exercised by the direct and explicit conferral recorded in §0 |
| **Version** | v0.1 |

---

## §0. The authority this document claims, and its exact limit

`PRD_LIFECYCLE.md` **L280** assigns Stage 6 to the **Implementation lead**.
`ADR-0033` §7.1 (**L169**) holds that *"a conferral for one act is not a standing
licence."* Both constrain what follows.

The instruction that produced this document was, verbatim: *"Execute the
repository's actual Stage 6 — Implementation Tasks for PRD-021B B0–B9 as ONE
consolidated unit"*, with *"Allocate a new unused `IMPL-*` range"* stated as a
requirement and *"Create one consolidated PRD-021B B0–B9 implementation-task
document"* stated as the deliverable. **That instruction is the authority, and it
is the only authority claimed.**

⭐ **This matters because the immediately preceding turn refused.** The Stage 6
readiness audit
([`../../30-product/social-graph/PRD-021B_B0_B9_STAGE6_READINESS_AUDIT.md`](../../30-product/social-graph/PRD-021B_B0_B9_STAGE6_READINESS_AUDIT.md),
commit `b346751`) recorded the Stage 6 gate **BLOCKED 0 of 2** and finding
**`S6-F-1`** — *"`IMPL-*` allocation is the act the turn forbade"* — precisely
because that turn's constraints prohibited `IMPL-*`. The present instruction
**requires** it. `S6-F-1` is therefore discharged by conferral, not by
reinterpretation, and §11.1 records that transition.

### §0.1 What this conferral does **not** extend to

| Act | Disposition |
|---|---|
| Stage 7, freeze, a `DOCUMENTATION_BASELINE.md` §3 row | ⛔ **NOT ENTERED.** `PRD_LIFECYCLE.md` **L161**: *"Freeze is **conferred, not claimed**."* Stage 7 belongs to the **Governance Owner** (**L281**) |
| Editing `PRD_LIFECYCLE.md` — including the stale allocation table of §3.5 | ⛔ **REFUSED.** Lifecycle authority. Routed, not repaired (§11.2) |
| Editing any B0–B9 subject, frozen PRD, accepted ADR, or the BC Map | ⛔ **REFUSED.** §2.1 proves all ten subjects byte-unchanged |
| Closing any of the **17** OPEN items | ⛔ **REFUSED.** They are carried as blockers (§10) |
| Minting a requirement, BC, event, edge, API, integration or owner | ⛔ **REFUSED.** §9.4 measures **0** minted identifiers |
| Writing code | ⛔ **NOT DONE.** Documentation and tasks only |

---

## §1. The gate this document is measured against

`PRD_LIFECYCLE.md` **L135–139**, verbatim:

> ### Stage 6 — Implementation Tasks
>
> **Gate:** an `IMPL-*` range allocated and a task document in which **every task
> traces back to requirements**.

Two conjuncts. Both must hold.

| # | Conjunct | Where met | Result |
|---|---|---|---|
| 1 | An `IMPL-*` range allocated | §3 — `IMPL-1600`…`1689`, derived mechanically | ✅ |
| 2 | A task document in which **every task traces back to requirements** | §6–§8 (the 90 rows) · §9.1 measures **0** orphan tasks | ✅ |

And the four allocation rules, **L140–145**, verbatim:

> 1. Take the next free range. **Never reuse or reassign a number** —
>    cross-references in commits, reviews and test names outlive the document.
> 2. Leave the previous group room to grow contiguously. Student Identity starts
>    at `IMPL-200`, not `IMPL-128`, so Library Management can extend.
> 3. Record `Priority`, `Blocks`, `Blocked by` per task.
> 4. Add a traceability table mapping task groups → requirements → invariants →
>    acceptance.

| Rule | Where discharged |
|---|---|
| 1 | §3 (next free range, measured) · §9.2 (no reuse, repository-wide) |
| 2 | §3.4 (the reserve left behind; the two foreign reserves declined) |
| 3 | **§7** — a dedicated `Priority` / `Blocks` / `Blocked by` register, all 90 rows |
| 4 | **§8** — task groups → requirements → invariants → acceptance |

⚠ **The instruction's mandated columns are a superset of rule 3's, not a
replacement for it.** The instruction requires
`IMPL-ID | Task | Requirement ID(s) | BC/Context | Dependency | Acceptance/Done Condition | Owner/Role | Status`.
Rule 3 requires `Priority`, `Blocks`, `Blocked by`. Satisfying only the
instruction would have failed the gate's own rule 3; satisfying only rule 3 would
have failed the instruction. **§6 carries the mandated eight; §7 carries rule 3's
three for the same 90 IDs.** Neither is a subset of the other and both are
present.

---

## §2. The subjects, and proof they were not touched

### §2.1 Ten subjects — sha256, measured at authoring

⛔ **This document changes none of them.** The hashes below are identical to those
recorded at Stage 3 (`510a90b`/`6ddbff9`), Stage 4 (`bd0decd`/`3f40525`), Stage 5
(`60e3782`) and the Stage 6 readiness audit (`b346751`).

| Part | Stem | Lines | Bytes | sha256 |
|---|---|---|---|---|
| B0 | `XPA-` | 393 | 21,735 | `69dae44e5c8f99fa2fcae71d60f88fac7032ba116d9ba04280752f3c2ec94954` |
| B1 | `SGR-` | 773 | 35,883 | `503c804504f2d04e315c0cf3c99d89e6465eaa1ef668e42e938db65db7532816` |
| B2 | `SSF-` | 589 | 27,202 | `7339862f8cf9fc1174686126f3f49f441316f910352b37e0300f64b90c7963af` |
| B3 | `SDS-` | 565 | 28,079 | `a3ccec3de060144efb932cdf7869c83c21b9a423d70854c6960017946953b533` |
| B4 | `DRK-` | 601 | 36,490 | `429ed76f94042e8988391f6add4dad04ab0ed8afb931750bdc6012e969e2d0cd` |
| B5 | `PYK-` | 533 | 31,864 | `2c8f1c3dba8840c18488d81b3e7397af54b05b301b8b73fba59453c375ebe5bc` |
| B6 | `GLS-` | 426 | 24,316 | `1c481c6ae7557568d80e0a7156667d9132ef1a05ba812caa9be82e296f31137b` |
| B7 | `MSG-` | 940 | 53,311 | `01e2a7fad860abe2a01398a6ac288f73e6532e9d69fcdee1ff99b7af4afc9b4a` |
| B8 | `RTM-` | 810 | 45,340 | `a075ba341baa90037d0290c096f4bf886d9b622410c042f13791042f88506f22` |
| B9 | `TPA-` | 983 | 48,545 | `21561f8b53af7602b0f04182645a75c6fff57226af61359f241054ace2d383a5` |

**Total 6,613 lines / 352,765 bytes** under the per-file convention.

### §2.2 The identifier pool this document may cite — 113 registers, 1,300 identifiers

Every register is contiguous from `001`. A `max+1` probe on all 113 returns **0**
phantoms. **A task row may cite only a member of this pool** — §9.3 measures
compliance at **0 dangling references**.

| Part | Stem | Registers | Identifiers | Registers (n) |
|---|---|---|---|---|
| B0 | `XPA-` | 4 | 22 | `BND`:6 `DEP`:6 `PREC`:7 · `ACGAP`:3 ⛔ not a requirement |
| B1 | `SGR-` | 14 | 183 | `FR`:27 `BR`:18 `AC`:30 `API`:14 `EC`:18 `XC`:14 `SEC`:11 `DM`:12 `EVT`:8 `SCOPE`:8 `PRV`:7 `PERF`:7 `CACHE`:6 · `GAP`:3 ⛔ |
| B2 | `SSF-` | 14 | 174 | `FR`:27 `BR`:22 `AC`:28 `XC`:16 `EC`:16 `API`:10 `SEC`:10 `DM`:10 `PRV`:8 `EVT`:6 `SCOPE`:6 `PERF`:6 `CACHE`:6 · `GAP`:3 ⛔ |
| B3 | `SDS-` | 14 | 161 | `AC`:32 `BR`:19 `FR`:17 `XC`:16 `EC`:18 `IDX`:10 `PRV`:9 `PERF`:8 `CACHE`:8 `SEC`:8 `DM`:6 `API`:4 `SCOPE`:3 · `GAP`:3 ⛔ |
| B4 | `DRK-` | 14 | 133 | `AC`:26 `XC`:16 `FR`:14 `EC`:12 `BR`:11 `SIG`:10 `CFG`:8 `DET`:6 `EXP`:6 `EVAL`:5 `PRV`:5 `SCOPE`:5 `SEC`:4 · `GAP`:5 ⛔ |
| B5 | `PYK-` | 16 | 135 | `AC`:24 `XC`:18 `EC`:12 `POL`:8 `SUP`:8 `CFG`:7 `PRS`:7 `PRV`:7 `SRC`:7 `FB`:6 `FR`:6 `FRQ`:6 `BR`:5 `SCOPE`:5 `SEC`:4 · `GAP`:5 ⛔ |
| B6 | `GLS-` | 12 | 100 | `AC`:20 `XC`:14 `FR`:11 `EC`:10 `BR`:8 `INV`:6 `DEF`:6 `CFG`:5 `SEC`:5 `SCOPE`:4 · `GAP`:3 `FUT`:8 ⛔ |
| B7 | `MSG-` | 10 | 137 | `FR`:33 `AC`:30 `XC`:22 `BR`:17 `API`:14 `CFG`:6 `INV`:6 `SEC`:6 `EVT`:1 · `GAP`:2 ⛔ |
| B8 | `RTM-` | 7 | 109 | `FR`:30 `AC`:28 `XC`:23 `BR`:20 `CFG`:3 `SEC`:3 · `GAP`:2 ⛔ |
| B9 | `TPA-` | 8 | 146 | `BR`:49 `FR`:31 `AC`:24 `XC`:17 `PRIN`:9 `INV`:8 `GOAL`:4 · `GAP`:4 ⛔ |
| | | **113** | **1,300** | |

⚠ **`GAP`, `FOD`, `ACGAP`, `FUT`, `CONF` and `DRIFT` are NOT requirements.** They
are *disclosed absences*. A task citing one as its authority would be an
orphan wearing a citation. §9.1 excludes them from the traceability test, and
**no row in §6 cites one as its Requirement ID(s)** — where a gap governs a task
it appears in `Dependency` or `Status` as a **blocker**, which is where the
repository's own gate-script check 9 puts it.

---

## §3. Why `IMPL-1600` — derived mechanically, not read off the lifecycle table

⛔ **The lifecycle allocation table could not be used as the source.** It declares
`IMPL-227`+ *"Unallocated"* while **569** distinct numbers above 227 are in fact
occupied. That is finding **`S6-F-2`** (§11.2) and it is routed, not repaired.
**The repository was therefore measured.**

### §3.1 The census — published with its rule, because the rule changes the answer

⚠ Three regex rules were run over `docs/`, `tool/`, `lib/`, `test/`,
`delivery/`. They disagree, and the disagreement is an **artefact of the rule**,
not new data:

| Rule | Pattern | Distinct | Min | Max |
|---|---|---|---|---|
| **R3_4** *(the rule adopted)* | `IMPL-(\d{3,4})` | **796** | **14** | **1600** |
| R2_4 | `IMPL-(\d{2,4})` | 797 | 13 | 1600 |
| R1_9 | `IMPL-(\d{1,9})` | 804 | 1 | 1600 |

The eight extra tokens under the looser rules were **read at their lines** rather
than counted, and every one is a **fragment of a regex printed in prose**, not an
identifier:

| Token | Where | What it actually is |
|---|---|---|
| `IMPL-1` | `PRD-012a_IMPLEMENTATION_TASKS.md` L98 | the string `IMPL-1[3-9][0-9]{2}'` — a documented grep |
| `IMPL-3` | `PRD-004_FINAL_CORRECTION_REPORT.md` L40 | `IMPL-3[0-9][0-9]` — a documented grep |
| `IMPL-4` | `PRD-005_IMPLEMENTATION_TASKS.md` L71 | `IMPL-4[0-9][0-9]` — a documented grep |
| `IMPL-6` | `ADR-0034` L65 | `IMPL-6*` — prose ("0 of 179 `IMPL-6*` tasks") |
| `IMPL-7` | `ADR-0049` L190 | `IMPL-7xx` — prose |
| `IMPL-8` | `PRD-013_STAGE6_IMPLEMENTATION_TASKS.md` L67 | `IMPL-8xx` — prose |
| `IMPL-9` | `DOCUMENTATION_BASELINE.md` L187 | `IMPL-9xx` — prose |
| `IMPL-13` | `PRD-020_IMPLEMENTATION_TASKS.md` L72 | `IMPL-13xx` — prose |

⭐ **This is the fourth appearance of the census-rule defect class** in this PRD's
lifecycle (`I5-1`, `I5-5`, `S6-I-1`, and now `S6-I-3`). It is recorded as an
**information item, not a defect**: the numbers were never inconsistent, only the
rules were. **R3_4 is adopted** because a three-digit floor is the narrowest rule
that admits every real identifier (`IMPL-014` is the lowest, per the lifecycle
table itself) and excludes every prose fragment above.

### §3.2 ⭐ The trap in `IMPL-1600`, inspected at its line rather than counted

Under R3_4 the **highest occupied token in the repository is `IMPL-1600`**, and it
occurs in exactly two files. **A counting scanner would have concluded 1600 was
taken and started this range at 1700, stranding 100 numbers.** Both occurrences
were read:

| File | Line | Text | Verdict |
|---|---|---|---|
| `PRD-021A_IMPLEMENTATION_TASKS.md` | **L147** | `| IMPL-1600`+ | Unallocated — measured empty |` | ⭐ **A declaration that the number is FREE** |
| `PRD-021A_IMPLEMENTATION_TASKS.md` | **L137** | *"Counting it as an allocation would have pushed this range to `IMPL-1600` and left a 100-number hole."* | ⭐ Prose **warning against this exact error** |
| `PRD-021B_B0_B9_STAGE6_READINESS_AUDIT.md` | L178, L191–205, L685 | the readiness audit's own occupancy measurement | Measured evidence, not a use |

⭐⭐ **`PRD-021A` §3.1 documents this hazard against itself**, and cites `PRD-007`
doing the same: *"The single `IMPL-500` occurrence is a declaration that the
number is free, not a use of it."* **`IMPL-1600` is the third instance of the same
pattern, and it is resolved the same way: the number is free.**

⚠ Note the recursion, and that it is harmless: the readiness audit of the
preceding turn *measured* 1600 and thereby became a second file containing the
token. **Measuring a number does not allocate it.** Had that been miscounted as
occupancy, the same 100-number hole would have opened.

### §3.3 Confirmation — the band above is empty

| Band | Tokens found under R3_4 |
|---|---|
| `IMPL-1600`…`1699` | **`1600` only** — and it is a free-declaration (§3.2) |
| `IMPL-1700`…`1799` | ⭐ **0 — empty** |
| `IMPL-1800`…`1899` | ⭐ **0 — empty** |

⇒ **`IMPL-1600` is the next free number.** Rule 1 — *"take the next free
range"* — selects it.

### §3.4 Rule 2 — the reserve left behind, and the two declined

| Band | Disposition |
|---|---|
| `IMPL-1400`…`1449` | ⛔ **NOT TOUCHED** — `PRD-020` reserve (`ADR-0082`) |
| `IMPL-1450`…`1499` | ⛔ **NOT TOUCHED** — `PRD-020`'s declared reserve, cited by `ADR-0086`, `ADR-0087`, `TRACEABILITY_MATRIX.md` and `PRD-020_STAGE5_CONFERRAL.md`. ⚠ `PRD-020`'s Stage 5 recorded `IMPL-1450` as defect `I-2` and **rejected the finding**, because *"had it been 'fixed', a lawful growth reserve would have been deleted"* |
| `IMPL-1500`…`1569` | ⛔ **NOT TOUCHED** — allocated to `PRD-021A` A1–A8, 70 tasks |
| `IMPL-1570`…`1599` | ⛔ **NOT TOUCHED** — `PRD-021A`'s **declared growth reserve**. ⚠ `PRD-021B` is the sibling of `PRD-021A` and it would have looked economical to extend into it. **Declined:** the reserving document owns its reserve, and consuming another module's declared reserve is a range-allocation act belonging to the **Governance Owner** |
| **`IMPL-1600`…`1689`** | ✅ **Allocated here** — **90** tasks, contiguous, every member carrying exactly one row |
| **`IMPL-1690`…`1749`** | ✅ **Growth reserve** — **60**, declared and **not** allocated. B0–B9 carries **17 OPEN items** (§10); when `FOD-1`, `FOD-2` and the six `XPB-CONF-*` are adjudicated, tasks will be added, and they must be able to extend **contiguously** |
| `IMPL-1750`+ | Unallocated — measured empty. ⚠ **This row is a declaration that the numbers are free, not a use of them** (§3.2) |

### §3.5 ⛔ What the lifecycle table says, and why it was not followed

`PRD_LIFECYCLE.md` **L147–153** carries:

| Range | Owner |
|---|---|
| `IMPL-227`+ | **Unallocated** |

**That statement is false as measured** — 569 distinct numbers above 227 are
occupied across 20 blocks, including the whole of `PRD-020`'s and `PRD-021A`'s
allocations. Obeying it would have re-issued `IMPL-227` and violated rule 1's
*"never reuse or reassign a number."*

⛔ **`PRD_LIFECYCLE.md` was NOT edited.** It is lifecycle authority; a Rank 1–5
change requires *"an ADR **before** the change"* (`PRD_LIFECYCLE.md` **L164**).
The discrepancy is raised as **`S6-F-2`** and routed to the **Governance Owner**
in §11.2.

---

## §4. Task groups — how the 90 are organised

Ten groups, one per part, sized in proportion to each part's normative content.
⛔ **No group invents scope.** Every group is a partition of requirements that
already exist in its subject.

| Group | Part | Range | n | Owning BC / form |
|---|---|---|---|---|
| G0 | B0 — cross-part architecture, dependency & precedence | `IMPL-1600`…`1604` | 5 | ⛔ owns nothing — allocation instrument |
| G1 | B1 — global social graph | `IMPL-1605`…`1618` | 14 | **`BC-11`** ✅ owns |
| G2 | B2 — social safety (block/mute/abuse) | `IMPL-1619`…`1631` | 13 | **`BC-11`** ✅ owns block/mute |
| G3 | B3 — student discovery read composition | `IMPL-1632`…`1642` | 11 | read composition (`AR-1`) — ⛔ no BC |
| G4 | B4 — discovery ranking | `IMPL-1643`…`1650` | 8 | read composition over **`BC-23`** — ⛔ no BC |
| G5 | B5 — recommendations | `IMPL-1651`…`1656` | 6 | read composition (`AR-1`) — ⛔ no BC |
| G6 | B6 — discovery scope | `IMPL-1657`…`1663` | 7 | pure policy function — ⛔ no BC, no state |
| G7 | B7 — messaging | `IMPL-1664`…`1676` | 13 | **`BC-12`** ✅ owns |
| G8 | B8 — realtime, media & messaging safety | `IMPL-1677`…`1684` | 8 | **`BC-12`** uses `BC-29`/`BC-30`; ⛔ owns neither |
| G9 | B9 — cross-cutting technical architecture | `IMPL-1685`…`1689` | 5 | cross-cutting — ⛔ owns nothing |
| | | **`IMPL-1600`…`1689`** | **90** | |

### §4.1 Legend for the `Status` column

| Token | Meaning |
|---|---|
| `READY` | Every input exists in authority. Schedulable now |
| ⛔ `BLOCKED` | An OPEN item must be adjudicated first. **Carries a blocker, not a schedulable priority** (§7) |
| ⚠ `PARTIAL` | Schedulable, but a named sub-part is gated by an OPEN item |

⛔ **No row is marked `DONE`, `IN PROGRESS` or `VERIFIED`.** Stage 6 allocates
work. **0 of 242** acceptance criteria are proven, and no code exists.

### §4.2 Legend for `Owner/Role`

⚠ **`PGA-08` applies: `PRD_LIFECYCLE.md` L283 records that no PRD has a named
owner.** ⛔ **This document therefore names no person.** `Owner/Role` carries the
**role** already established by repository authority — `Implementation lead`
(`PRD_LIFECYCLE.md` **L280**) for buildable work, and the adjudicating role named
by the subject itself (`ARB`, `Architecture Owner`, `Governance Owner`,
`Product Owner`) for anything blocked. **Inventing an owner is barred.**

---

## §5. ⭐ The 90 tasks — the eight mandated columns

> **Reading rule.** `Requirement ID(s)` cites only identifiers that exist in
> §2.2's pool. `Acceptance/Done Condition` cites the part's own `AC-*` where the
> subject supplies one; where it does not, the condition restates the
> requirement's own test and says so. ⛔ **No new requirement, BC, event, API,
> edge, integration or owner appears in any cell.**

### §5.1 G0 — B0 cross-part architecture (`IMPL-1600`…`1604`)

| IMPL-ID | Task | Requirement ID(s) | BC/Context | Dependency | Acceptance/Done Condition | Owner/Role | Status |
|---|---|---|---|---|---|---|---|
| `IMPL-1600` | Encode the 15-capability ownership matrix as an enforceable module-boundary configuration, so that a build fails if a part touches a capability marked ⛔ for it | `XPA-BND-001`…`006` | ⛔ none — B0 is the allocation instrument | `IMPL-1685` (module manifest) | `dart run tool/check_module_boundaries.dart` reports **zero violations introduced by `PRD-021B`**, pre-existing `ADR-0012` set excluded, per `SGR-AC-028` | Implementation lead | `READY` |
| `IMPL-1601` | Encode the dependency-direction rules as a directed-acyclic check over the B0–B9 parts, refusing any inbound edge B0 declares forbidden | `XPA-DEP-001`…`006` | ⛔ none | `IMPL-1600` | The acyclicity check runs in CI and fails on an added reverse edge; `TPA-FR-028`'s manifest is the single source | Implementation lead | `READY` |
| `IMPL-1602` | Implement the privacy/safety precedence order as a single shared resolver, so no part can apply the stages out of order | `XPA-PREC-001`…`007`, `TPA-INV-005` | ⛔ none — consumed by B3/B4/B5 | `IMPL-1632`, `IMPL-1643` | Ranking cannot precede safety: `TPA-AC-*` ordering case passes and `DRK-AC-*` step-order case passes | Implementation lead | `READY` |
| `IMPL-1603` | Implement the library/global boundary rule so a global-identity structure can never carry a tenant or student-record key | `XPA-BND-001`…`006`, `GLS-INV-002`, `TPA-INV-003` | `BC-11`, `BC-12` (structure shape only) | `IMPL-1605`, `IMPL-1664` | Field enumeration over every `BC-11`/`BC-12` structure yields **no** `StudentRecordId`, `TenantId` or profile field, per `SGR-AC-029` | Implementation lead | `READY` |
| `IMPL-1604` | Stand up the acceptance-criteria coverage harness for all 242 B0–B9 criteria, reporting coverage without gating on it | `XPA-ACGAP-001`…`003` *(disclosure, cited as scope not authority)*, `TPA-FR-027` | ⛔ none | `IMPL-1689` | The harness enumerates 242 criteria and reports per-part coverage; ⛔ it does **not** assert any criterion passes | Implementation lead | ⚠ `PARTIAL` — `XPA-ACGAP-002` gates the four Mute criteria |

### §5.2 G1 — B1 global social graph, `BC-11` (`IMPL-1605`…`IMPL-1618`)

| IMPL-ID | Task | Requirement ID(s) | BC/Context | Dependency | Acceptance/Done Condition | Owner/Role | Status |
|---|---|---|---|---|---|---|---|
| `IMPL-1605` | Model `Friendship` as a symmetric relation with at most one row per unordered pair and no self-pair | `SGR-FR-001`, `SGR-FR-002`, `SGR-FR-003` | **`BC-11`** ✅ | ⛔ `FOD-1` (transaction boundary) | `SGR-AC-002` refuses a self-request with no row created; the unordered-pair uniqueness constraint holds under concurrent insert | ARB (`FOD-1`), then Implementation lead | ⛔ `BLOCKED` — `FOD-1` |
| `IMPL-1606` | Implement the `FriendRequest` structure and its exact state machine | `SGR-FR-004`, `SGR-FR-005`, `SGR-FR-006`, `SGR-FR-007` | **`BC-11`** ✅ | ⛔ `FOD-1` | `SGR-AC-001` yields exactly one `PENDING`; `SGR-AC-006` refuses accept by a third party; terminal states are not re-openable | ARB (`FOD-1`), then Implementation lead | ⛔ `BLOCKED` — `FOD-1` |
| `IMPL-1607` | Implement inverse-request auto-acceptance and concurrent-send convergence | `SGR-FR-008`, `SGR-FR-009`, `SGR-BR-005` | **`BC-11`** ✅ | `IMPL-1606`; ⛔ `FOD-1` | `SGR-AC-003` yields exactly one friendship and zero extra requests; `SGR-AC-005` converges to one `PENDING` **or** one friendship under a race | ARB (`FOD-1`), then Implementation lead | ⛔ `BLOCKED` — `FOD-1` |
| `IMPL-1608` | Implement duplicate-send suppression and endpoint idempotency | `SGR-FR-010`, `SGR-FR-011`, `SGR-API-001` | **`BC-11`** ✅ | `IMPL-1606` | `SGR-AC-004` creates no new row, event or notification; `SGR-AC-008` executes the effect once for a repeated key | Implementation lead | `READY` |
| `IMPL-1609` | Implement the relationship-status query with non-disclosing outcomes | `SGR-FR-012`, `SGR-BR-004`, `SGR-BR-007` | **`BC-11`** ✅ | `IMPL-1606`, `IMPL-1619` | `SGR-AC-007` returns `NONE` without disclosing rejection; `SGR-AC-009` returns `UNAVAILABLE`, never `BLOCKED_BY_TARGET` | Implementation lead | `READY` |
| `IMPL-1610` | Implement the friend list with stable cursor pagination and read-time block exclusion | `SGR-FR-013`, `SGR-FR-014`, `SGR-API-013`, `SGR-BR-008` | **`BC-11`** ✅ | `IMPL-1619` | `SGR-AC-023` shows stable cursor order and no offset pagination; `SGR-AC-024` excludes a blocked member at read time | Implementation lead | `READY` |
| `IMPL-1611` | Implement mutual-connection **count** as a derivation, excluding blocked persons | `SGR-FR-026`, `SGR-FR-027` | **`BC-11`** ✅ — derivation, not stored | `IMPL-1619` | `SGR-AC-025` excludes a viewer-blocked person from the count; ⛔ the browsable mutual list is **V2** and is not built | Implementation lead | `READY` |
| `IMPL-1612` | Consult B2's Safety Check before creating any `PENDING` request, and fail closed when it is unavailable | `SGR-FR-015`, `SGR-SEC-002` | **`BC-11`** ✅ consuming B2 | `IMPL-1630` | `SGR-AC-011` refuses the mutation when the Safety Check is unavailable | Implementation lead | `READY` |
| `IMPL-1613` | Implement block-induced friendship removal and pending-request cancellation | `SGR-FR-016`, `SGR-BR-013` | **`BC-11`** ✅ | `IMPL-1619`; ⛔ `FOD-1` | `SGR-AC-010` removes the friendship and cancels pending requests in either direction | ARB (`FOD-1`), then Implementation lead | ⛔ `BLOCKED` — `FOD-1` |
| `IMPL-1614` | Implement rolling-window rate limiting on friend-request sends, refusing with no state change | `SGR-FR-017`, `SGR-FR-018` | **`BC-11`** ✅ — `RateLimitCounter` | ⛔ `FOD-1` | `SGR-AC-014` refuses with no request, no event and no notification | ARB (`FOD-1`), then Implementation lead | ⛔ `BLOCKED` — `FOD-1` |
| `IMPL-1615` | Expose rate-limit refusals to B2 as deterministic, countable abuse signals | `SGR-FR-019` | **`BC-11`** ✅ → B2 | `IMPL-1614`, `IMPL-1626` | `SGR-AC-015` makes the refusal available as a deterministic signal | Implementation lead | ⛔ `BLOCKED` — inherits `FOD-1` via `IMPL-1614` |
| `IMPL-1616` | Implement global relationship persistence across membership expiry and zero-library membership | `SGR-BR-010`, `SGR-BR-011`, `SGR-BR-012`, `SGR-BR-014` | **`BC-11`** ✅ | `IMPL-1605` | `SGR-AC-016` keeps the friendship after expiry; `SGR-AC-017` persists with zero libraries; `SGR-AC-018` permits cross-library requests; `SGR-AC-019` auto-creates nothing on membership grant | Implementation lead | ⛔ `BLOCKED` — inherits `FOD-1` via `IMPL-1605` |
| `IMPL-1617` | Consume the four `BC-10` identity events and apply privacy changes with no propagation window | `SGR-EVT-005`, `SGR-PRV-007`, `SGR-DM-007` | **`BC-11`** ✅ consuming `BC-10` | `IMPL-1685` (event wiring) | `SGR-AC-020` applies a public→private switch on the next read; `SGR-AC-021` removes all relations of an anonymised person; `SGR-AC-022` treats an unenriched `PersonId` as valid | Implementation lead | `READY` |
| `IMPL-1618` | Publish exactly the two closed `BC-11` events, answer `canMessage` synchronously via `E-16`, and write append-only audit records | `SGR-EVT-001`, `SGR-EVT-002`, `SGR-EVT-007`, `SGR-FR-020`, `SGR-FR-021`, `SGR-FR-022`, `SGR-FR-023`, `SGR-FR-024`, `SGR-BR-018`, `SGR-SEC-010` | **`BC-11`** ✅; consumers `BC-12`, `BC-22`, `BC-26` | `IMPL-1685` | `SGR-AC-027` shows exactly `social.FriendshipEstablished` with **no** event minted; `SGR-AC-026` answers `canMessage` synchronously without disclosing a reason; `SGR-AC-030` writes actor/target/transition/timestamp | Implementation lead | `READY` |

### §5.3 G2 — B2 social safety, `BC-11` (`IMPL-1619`…`IMPL-1631`)

⚠ **`FOD-2` gates the `mute_list` structure only.** B2's own `SSF-EC-016` /
`SSF-AC-028` specify a **degraded ship mode**: mute endpoints return *not
implemented* while *"Block, unblock, rate limiting, Safety Check and all of B1 and
B3 ship complete."* The rows below reflect exactly that split — ⛔ **the mute rows
carry a blocker; the block rows do not.**

| IMPL-ID | Task | Requirement ID(s) | BC/Context | Dependency | Acceptance/Done Condition | Owner/Role | Status |
|---|---|---|---|---|---|---|---|
| `IMPL-1619` | Implement `BlockList` and the idempotent block operation by `PersonId` | `SSF-FR-001`, `SSF-FR-003` | **`BC-11`** ✅ — `BlockList` | ⛔ `FOD-1` (transaction boundary) | A repeated block produces no second row and no second event; the `BlockList` uniqueness constraint holds under concurrent insert | ARB (`FOD-1`), then Implementation lead | ⛔ `BLOCKED` — `FOD-1` |
| `IMPL-1620` | Cancel pending friend requests in either direction on block | `SSF-FR-002` | **`BC-11`** ✅ | `IMPL-1619`, `IMPL-1613` | A block with a `PENDING` request in either direction leaves zero pending requests | Implementation lead | ⛔ `BLOCKED` — inherits `FOD-1` |
| `IMPL-1621` | Implement the idempotent unblock operation, restricted to the blocker | `SSF-FR-005`, `SSF-FR-006` | **`BC-11`** ✅ | `IMPL-1619` | A repeated unblock is a no-op; a non-blocker cannot unblock | Implementation lead | ⛔ `BLOCKED` — inherits `FOD-1` |
| `IMPL-1622` | Enforce block server-side on every block-sensitive read and mutation | `SSF-FR-004`, `SSF-FR-011`, `SSF-FR-012` | **`BC-11`** ✅ | `IMPL-1619` | Every block-sensitive read filters server-side and every block-sensitive mutation is refused server-side; ⛔ no client-side filtering is relied on | Implementation lead | ⛔ `BLOCKED` — inherits `FOD-1` |
| `IMPL-1623` | Implement friend-request protection with an indistinguishable refusal | `SSF-FR-013`, `SSF-FR-014` | **`BC-11`** ✅ | `IMPL-1619`, `IMPL-1612` | A block in either direction prevents the request, and the refusal is indistinguishable from "person unavailable" | Implementation lead | ⛔ `BLOCKED` — inherits `FOD-1` |
| `IMPL-1624` | Implement the five-rank safety precedence order so a lower rank can never override a higher one | `SSF-BR-007`, `SSF-BR-008`, `SSF-BR-009`, `XPA-PREC-001`…`007` | **`BC-11`** ✅ | `IMPL-1602` | The precedence resolver of `IMPL-1602` is the only ordering authority; enforcement > block > privacy > mute > relationship state holds, and Mute stays rank **4** per `TSF-XC-005` | Implementation lead | `READY` |
| `IMPL-1625` | Apply the rate-limit surface B2 declares, refusing with no state change, no event and no notification | `SSF-FR-015`, `SSF-FR-016`, `SSF-FR-017` | **`BC-11`** ✅ — `RateLimitCounter` (owned via `E-*` per `SSF-FR-015`) | `IMPL-1614` | A rate-limited action changes no state, emits no event and sends no notification | Implementation lead | ⛔ `BLOCKED` — inherits `FOD-1` via `IMPL-1614` |
| `IMPL-1626` | Expose deterministic, countable abuse signals | `SSF-FR-018` | **`BC-11`** ✅ | `IMPL-1625` | Every exposed signal is deterministic and countable; ⛔ no probabilistic or ML signal is introduced | Implementation lead | ⛔ `BLOCKED` — inherits `FOD-1` |
| `IMPL-1627` | Route reports to `BC-13` without duplicating moderation, and offer block in the same flow as an independent action | `SSF-FR-019`, `SSF-FR-020`, `SSF-API-009` | **`BC-13`** ✅ owns moderation; B2 **routes only** | `IMPL-1619` | A report creates a `BC-13` `AbuseReport`; ⛔ B2 stores no moderation case; report and block remain independently invocable | Implementation lead | ⛔ `BLOCKED` — inherits `FOD-1` |
| `IMPL-1628` | Expose the safety filter to B3's read composition, and answer `canMessage` false on a block in either direction | `SSF-FR-021`, `SSF-FR-022` | **`BC-11`** ✅ → B3, `BC-12` | `IMPL-1622`, `IMPL-1632` | B3's step [3] removes anyone blocked in either direction; `canMessage` is false under a block in either direction | Implementation lead | ⛔ `BLOCKED` — inherits `FOD-1` |
| `IMPL-1629` | Consume `EnforcementActionTaken` and `identity.PersonAnonymised` and apply the required local effects | `SSF-FR-024`, `SSF-FR-025` | **`BC-11`** ✅ consuming `BC-13`, `BC-10` | `IMPL-1685` | On `EnforcementActionTaken` the specified local effect is applied; on `PersonAnonymised` the specified removal is applied; ⛔ `BC-13` performs no write into `BC-11` | Implementation lead | `READY` |
| `IMPL-1630` | Implement the **Safety Check** internal interface for an ordered pair, fail-closed and non-disclosing | `SSF-FR-026`, `SSF-API-001` | **`BC-11`** ✅ — internal, ⛔ not a public surface | `IMPL-1622` | The check answers for an ordered pair; unavailability fails closed per `SGR-AC-011`; no reason is disclosed | Implementation lead | ⛔ `BLOCKED` — inherits `FOD-1` |
| `IMPL-1631` | ⚠ Implement `Mute`/unmute as a unilateral, undisclosed preference — **and ship the degraded mode until `FOD-2` is adjudicated** | `SSF-FR-007`, `SSF-FR-008`, `SSF-FR-009`, `SSF-FR-010`, `SSF-FR-027`, `SSF-EC-016` | **`BC-11`** ⚠ — `TSF-XC-005` (FROZEN) fixes owner and classification; ⛔ **`Mute` is absent from BC Map §8 L377** | ⛔⛔ **`FOD-2`** — requires **one ADR** authorizing a Rank 4 append. ⚠ `ADR-0088`/`ADR-0090` are **RESERVED and UNWRITTEN** | ⛔ **`SSF-AC-021`…`024` CANNOT be executed while `FOD-2` is open** (`XPA-ACGAP-002`). Interim done-condition is `SSF-AC-028`: mute endpoints return *not implemented* and the degraded state is covered | ARB (`FOD-2`), then Implementation lead | ⛔ `BLOCKED` — `FOD-2` |

### §5.4 G3 — B3 student discovery, read composition (`IMPL-1632`…`IMPL-1642`)

⛔ **B3 owns no aggregate.** It is the `AR-1` read-composition shape:
*"orchestrates public read models only"*, *"No `BC-` identifier is assigned; the
context count remains 31."*

| IMPL-ID | Task | Requirement ID(s) | BC/Context | Dependency | Acceptance/Done Condition | Owner/Role | Status |
|---|---|---|---|---|---|---|---|
| `IMPL-1632` | Implement the four-stage pipeline in exactly the specified order | `SDS-FR-002`, `TPA-INV-002`, `TPA-INV-005` | read composition — ⛔ no BC | `IMPL-1602`, `IMPL-1657` | Steps [1]–[4] execute in order; ⛔ a reordering fails the check of `IMPL-1602` | Implementation lead | `READY` |
| `IMPL-1633` | Constrain the candidate pool to library-scoped eligible persons, answered by `BC-11` as a boolean | `SDS-FR-001`, `SDS-FR-003` | **`BC-11`** ▶ eligibility boolean | `IMPL-1657` | Eligibility is a boolean from `BC-11`; ⛔ no membership detail crosses the boundary | Implementation lead | `READY` |
| `IMPL-1634` | Read membership validity from the `MembershipValidity` projection only | `SDS-FR-004` | **`BC-02`** ▶ `MembershipValidity` | `IMPL-1633` | Reads resolve against `MembershipValidity{studentRecordId, validUntil, seatQuota}`; ⛔ `BC-02` internals are not read | Implementation lead | `READY` |
| `IMPL-1635` | Implement student search applying steps [1]–[3] before returning, with zero results a valid outcome | `SDS-FR-005`, `SDS-FR-006`, `SDS-FR-007` | read composition; **`BC-23`** ▶ index | `IMPL-1632`, `IMPL-1641` | Search applies privacy and safety before returning; zero results is indistinguishable from "no match" | Implementation lead | `READY` |
| `IMPL-1636` | Return a public-profile **projection**, never the profile aggregate | `SDS-FR-008` | **`BC-10`** ▶ projection only — ⛔ `BC-10` is not owned | `IMPL-1635` | The returned shape is a projection; ⛔ no `BC-10` aggregate field leaks | Implementation lead | `READY` |
| `IMPL-1637` | Apply B2's Safety Check as pipeline step [3] | `SDS-FR-009` | **`BC-11`** ▶ via B2 | `IMPL-1630`, `IMPL-1628` | Anyone blocked in either direction is absent from results | Implementation lead | ⛔ `BLOCKED` — inherits `FOD-1` via `IMPL-1630` |
| `IMPL-1638` | Attach viewer-relative relationship status, and the optional mutual count | `SDS-FR-010`, `SDS-FR-011` | **`BC-11`** ▶ signals | `IMPL-1609`, `IMPL-1611` | Each result carries viewer-relative status; the mutual count, when present, matches `IMPL-1611`'s derivation | Implementation lead | `READY` |
| `IMPL-1639` | Implement multi-library union and read-time membership expiry | `SDS-FR-012`, `SDS-FR-013` | **`BC-02`** ▶ | `IMPL-1634` | A multi-library viewer sees the union; expiry takes effect on the next read and ⛔ does **not** wait for a scheduled job | Implementation lead | `READY` |
| `IMPL-1640` | Exclude anonymised, suspended and non-member persons from results | `SDS-FR-014`, `SDS-FR-015`, `SDS-FR-016` | **`BC-10`**, **`BC-13`** (`E-14`) ▶ | `IMPL-1629`, `IMPL-1617` | An anonymised, a suspended (`E-14`) and a membership-less person are each absent from results | Implementation lead | `READY` |
| `IMPL-1641` | Implement the search index access paths and pagination over `BC-23`'s projection | `SDS-IDX-001`…`010`, `SDS-FR-005`, `TPA-FR-014`, `TPA-FR-005` | **`BC-23`** ▶ fed by `E-21` — ⛔ `BC-23` is not owned | `IMPL-1685` | The ten declared access paths are indexed; the projection is fed by `E-21`; ⛔ no engine choice is specified | Implementation lead | `READY` |
| `IMPL-1642` | Publish B3's read contract naming **no** consumer | `SDS-FR-017` | read composition — ⛔ no BC | `IMPL-1632` | The contract is published and names no consumer, per `SDS-XC-009`/`SDS-XC-013`; ⚠ `FOD-4` is thereby not blocking | Implementation lead | `READY` |
