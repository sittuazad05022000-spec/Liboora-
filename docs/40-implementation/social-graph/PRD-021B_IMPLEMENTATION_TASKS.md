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
| Minting a requirement, BC, event, edge, API, integration or owner | ⛔ **REFUSED.** §8.5 measures **0** minted identifiers |
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
| 2 | A task document in which **every task traces back to requirements** | §5 (the 90 rows) · §7 (groups → requirements → invariants → acceptance) · §8.3 measures **0** orphan tasks | ✅ |

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
| 1 | §3 (next free range, measured) · §8.2 (no reuse, repository-wide) |
| 2 | §3.4 (the reserve left behind; the four foreign/sibling reserves declined) |
| 3 | **§6** — a dedicated `Priority` / `Blocks` / `Blocked by` register, all 90 rows |
| 4 | **§7** — task groups → requirements → invariants → acceptance |

⚠ **The instruction's mandated columns are a superset of rule 3's, not a
replacement for it.** The instruction requires
`IMPL-ID | Task | Requirement ID(s) | BC/Context | Dependency | Acceptance/Done Condition | Owner/Role | Status`.
Rule 3 requires `Priority`, `Blocks`, `Blocked by`. Satisfying only the
instruction would have failed the gate's own rule 3; satisfying only rule 3 would
have failed the instruction. **§5 carries the mandated eight; §6 carries rule 3's
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
phantoms. **A task row may cite only a member of this pool** — §8.4 measures
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
orphan wearing a citation. §8.3 excludes them from the traceability test, and
**no row in §5 cites one as its Requirement ID(s)** — where a gap governs a task
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
| `PRD-021A_IMPLEMENTATION_TASKS.md` | **L147** | a band row reading `IMPL-1600`+ &vert; `Unallocated — measured empty` | ⭐ **A declaration that the number is FREE** |
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

| Token | Meaning | Count |
|---|---|---|
| `READY` | Every input exists in authority **and** no predecessor is blocked. Schedulable now | **41** |
| ⛔ `BLOCKED` | An OPEN item must be adjudicated first. **Carries a blocker, not a schedulable priority** (§6) | **30** |
| ⏳ `SEQUENCED` | ⭐ Authority inputs all exist — **nothing is undecided for this task** — but a predecessor in the dependency graph is `BLOCKED`, so it is not schedulable *yet* | **18** |
| ⚠ `PARTIAL` | Schedulable, but a named sub-part is gated by an OPEN item | **1** |

⭐ **Why `SEQUENCED` exists, disclosed rather than smoothed over.** The first
draft of §5 marked these 18 rows `READY` while their dependency cells named a
`BLOCKED` predecessor. A mechanical transitive check over the 106 dependency
edges caught it (**`S6-I-4`**). Both available shortcuts were wrong: calling them
`READY` contradicts this legend's own word *"schedulable"*, and calling them
`BLOCKED` would have manufactured a governance blocker where **no decision is
actually missing** — the same error as the false blockers caught at §5.5–§5.7.
`SEQUENCED` states the true condition: *decided, not yet reachable.* The 18 were
re-stated **mechanically** from the graph, not by hand.

⛔ **No row is marked `DONE`, `IN PROGRESS` or `VERIFIED`.** Stage 6 allocates
work. **0 of 242** acceptance criteria are proven, and no code exists.
41 + 30 + 18 + 1 = **90**.

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
| `IMPL-1602` | Implement the privacy/safety precedence order as a single shared resolver, so no part can apply the stages out of order | `XPA-PREC-001`…`007`, `TPA-INV-005` | ⛔ none — consumed by B3/B4/B5 | `IMPL-1600` | Ranking cannot precede safety: `TPA-AC-014` holds, and `DRK-AC-001` shows B4's output is a permutation of its input. ⚠ This resolver is an **input to** `IMPL-1632`/`IMPL-1643`, not a consumer of them | Implementation lead | `READY` |
| `IMPL-1603` | Implement the library/global boundary rule so a global-identity structure can never carry a tenant or student-record key | `XPA-BND-001`…`006`, `GLS-INV-002`, `TPA-INV-003` | `BC-11`, `BC-12` (structure shape only) | `IMPL-1600` | Field enumeration over every `BC-11`/`BC-12` structure yields **no** `StudentRecordId`, `TenantId` or profile field, per `SGR-AC-029`. ⚠ This rule **constrains** `IMPL-1605`/`IMPL-1664`; it does not depend on them | Implementation lead | `READY` |
| `IMPL-1604` | Stand up the acceptance-criteria coverage harness for all 242 B0–B9 criteria, reporting coverage without gating on it | `TPA-FR-027`, `TPA-BR-042` | ⛔ none | `IMPL-1689` | The harness enumerates 242 criteria and reports per-part coverage; ⛔ it does **not** assert any criterion passes. ⚠ `XPA-ACGAP-001`…`003` are **disclosed absences**, carried here as scope, never as the authority | Implementation lead | ⚠ `PARTIAL` — `XPA-ACGAP-002` gates the four Mute criteria |

### §5.2 G1 — B1 global social graph, `BC-11` (`IMPL-1605`…`IMPL-1618`)

| IMPL-ID | Task | Requirement ID(s) | BC/Context | Dependency | Acceptance/Done Condition | Owner/Role | Status |
|---|---|---|---|---|---|---|---|
| `IMPL-1605` | Model `Friendship` as a symmetric relation with at most one row per unordered pair and no self-pair | `SGR-FR-001`, `SGR-FR-002`, `SGR-FR-003` | **`BC-11`** ✅ | ⛔ `FOD-1` (transaction boundary) | `SGR-AC-002` refuses a self-request with no row created; the unordered-pair uniqueness constraint holds under concurrent insert | ARB (`FOD-1`), then Implementation lead | ⛔ `BLOCKED` — `FOD-1` |
| `IMPL-1606` | Implement the `FriendRequest` structure and its exact state machine | `SGR-FR-004`, `SGR-FR-005`, `SGR-FR-006`, `SGR-FR-007` | **`BC-11`** ✅ | ⛔ `FOD-1` | `SGR-AC-001` yields exactly one `PENDING`; `SGR-AC-006` refuses accept by a third party; terminal states are not re-openable | ARB (`FOD-1`), then Implementation lead | ⛔ `BLOCKED` — `FOD-1` |
| `IMPL-1607` | Implement inverse-request auto-acceptance and concurrent-send convergence | `SGR-FR-008`, `SGR-FR-009`, `SGR-BR-005` | **`BC-11`** ✅ | `IMPL-1606`; ⛔ `FOD-1` | `SGR-AC-003` yields exactly one friendship and zero extra requests; `SGR-AC-005` converges to one `PENDING` **or** one friendship under a race | ARB (`FOD-1`), then Implementation lead | ⛔ `BLOCKED` — `FOD-1` |
| `IMPL-1608` | Implement duplicate-send suppression and endpoint idempotency | `SGR-FR-010`, `SGR-FR-011`, `SGR-API-001` | **`BC-11`** ✅ | `IMPL-1606` | `SGR-AC-004` creates no new row, event or notification; `SGR-AC-008` executes the effect once for a repeated key | Implementation lead | ⏳ `SEQUENCED` — authority inputs exist; waits on `IMPL-1606` |
| `IMPL-1609` | Implement the relationship-status query with non-disclosing outcomes | `SGR-FR-012`, `SGR-BR-004`, `SGR-BR-007` | **`BC-11`** ✅ | `IMPL-1606`, `IMPL-1619` | `SGR-AC-007` returns `NONE` without disclosing rejection; `SGR-AC-009` returns `UNAVAILABLE`, never `BLOCKED_BY_TARGET` | Implementation lead | ⏳ `SEQUENCED` — authority inputs exist; waits on `IMPL-1606`, `IMPL-1619` |
| `IMPL-1610` | Implement the friend list with stable cursor pagination and read-time block exclusion | `SGR-FR-013`, `SGR-FR-014`, `SGR-API-013`, `SGR-BR-008` | **`BC-11`** ✅ | `IMPL-1619` | `SGR-AC-023` shows stable cursor order and no offset pagination; `SGR-AC-024` excludes a blocked member at read time | Implementation lead | ⏳ `SEQUENCED` — authority inputs exist; waits on `IMPL-1619` |
| `IMPL-1611` | Implement mutual-connection **count** as a derivation, excluding blocked persons | `SGR-FR-026`, `SGR-FR-027` | **`BC-11`** ✅ — derivation, not stored | `IMPL-1619` | `SGR-AC-025` excludes a viewer-blocked person from the count; ⛔ the browsable mutual list is **V2** and is not built | Implementation lead | ⏳ `SEQUENCED` — authority inputs exist; waits on `IMPL-1619` |
| `IMPL-1612` | Consult B2's Safety Check before creating any `PENDING` request, and fail closed when it is unavailable | `SGR-FR-015`, `SGR-SEC-002` | **`BC-11`** ✅ consuming B2 | `IMPL-1630` | `SGR-AC-011` refuses the mutation when the Safety Check is unavailable | Implementation lead | ⏳ `SEQUENCED` — authority inputs exist; waits on `IMPL-1630` |
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
| `IMPL-1638` | Attach viewer-relative relationship status, and the optional mutual count | `SDS-FR-010`, `SDS-FR-011` | **`BC-11`** ▶ signals | `IMPL-1609`, `IMPL-1611` | Each result carries viewer-relative status; the mutual count, when present, matches `IMPL-1611`'s derivation | Implementation lead | ⏳ `SEQUENCED` — authority inputs exist; waits on `IMPL-1606`, `IMPL-1619` |
| `IMPL-1639` | Implement multi-library union and read-time membership expiry | `SDS-FR-012`, `SDS-FR-013` | **`BC-02`** ▶ | `IMPL-1634` | A multi-library viewer sees the union; expiry takes effect on the next read and ⛔ does **not** wait for a scheduled job | Implementation lead | `READY` |
| `IMPL-1640` | Exclude anonymised, suspended and non-member persons from results | `SDS-FR-014`, `SDS-FR-015`, `SDS-FR-016` | **`BC-10`**, **`BC-13`** (`E-14`) ▶ | `IMPL-1629`, `IMPL-1617` | An anonymised, a suspended (`E-14`) and a membership-less person are each absent from results | Implementation lead | `READY` |
| `IMPL-1641` | Implement the search index access paths and pagination over `BC-23`'s projection | `SDS-IDX-001`…`010`, `SDS-FR-005`, `TPA-FR-014`, `TPA-FR-005` | **`BC-23`** ▶ fed by `E-21` — ⛔ `BC-23` is not owned | `IMPL-1685` | The ten declared access paths are indexed; the projection is fed by `E-21`; ⛔ no engine choice is specified | Implementation lead | `READY` |
| `IMPL-1642` | Publish B3's read contract naming **no** consumer | `SDS-FR-017` | read composition — ⛔ no BC | `IMPL-1632` | The contract is published and names no consumer, per `SDS-XC-009`/`SDS-XC-013`; ⚠ `FOD-4` is **DISCHARGED** by `PRD_REGISTRY.md` §13/§14 and is not blocking | Implementation lead | `READY` |

### §5.5 G4 — B4 discovery ranking, read composition (`IMPL-1643`…`IMPL-1650`)

⛔ **B4 is not a context.** It orders a list B3 already produced.

⭐ **A false blocker was caught here and removed.** An earlier pass marked the G4
rows blocked on `XPB-CONF-003`. **That is wrong as measured:** the Stage 3 ledger
(`PRD-021B_B0_B9_STAGE3_ARCHITECTURE_ALIGNMENT.md` **§7.1**) records
`XPB-CONF-001` **RESOLVED** (`ADR-0091` §3 — the ordering layer is a lawful `AR-1`
read composition) and `XPB-CONF-003`/`XPB-CONF-004` **REFUSED, final** (`ADR-0091`
§5.2). A refusal is a **decision**, not an open question — the co-presence and
impression signals are simply **not built**, which `DRK-SIG-007`/`010` already say.
⇒ **G4 carries no `XPB-CONF-*` blocker.** Marking these blocked would have
manufactured a dependency on a decision that has already been taken.

| IMPL-ID | Task | Requirement ID(s) | BC/Context | Dependency | Acceptance/Done Condition | Owner/Role | Status |
|---|---|---|---|---|---|---|---|
| `IMPL-1643` | Implement B4 as a pure function of its inputs, consuming B3's published read contract | `DRK-FR-001`, `DRK-FR-002` | read composition over **`BC-23`** — ⛔ `BC-23` is not owned | `IMPL-1642` | `DRK-AC-001`: output is a permutation of input — same multiset, same cardinality | Implementation lead | `READY` |
| `IMPL-1644` | Enforce that ranking runs strictly after steps [1]–[3] and admits nobody | `DRK-FR-003`, `DRK-FR-004`, `TPA-INV-005` | read composition | `IMPL-1602`, `IMPL-1632` | `DRK-AC-001` plus `TPA-AC-014`: no person is added, admitted, re-admitted or resurrected by ordering | Implementation lead | `READY` |
| `IMPL-1645` | Implement the `DISC-RANK-1` weighted-sum scoring model over the three active signals | `DRK-FR-005`, `DRK-SIG-001`, `DRK-SIG-002`, `DRK-SIG-004`, `DRK-BR-004` | **`BC-23`** ▶ relevance; **`BC-11`** ▶ mutual count; **`BC-10`** ▶ completeness | `IMPL-1611`, `IMPL-1641` | Weights are `0.60`/`0.25`/`0.15`; `DRK-SIG-003` stays at `0.00` (constant in V1); the seven reserved signals remain unweighted. ⛔ `DRK-SIG-007` and `DRK-SIG-010` are **REFUSED, final** (`ADR-0091` §5.2) and are not built | Implementation lead | ⏳ `SEQUENCED` — authority inputs exist; waits on `IMPL-1619` |
| `IMPL-1646` | Implement the non-query-surface path where no `BC-23` relevance is available | `DRK-FR-006`, `DRK-FR-009` | read composition | `IMPL-1645` | On a non-query surface the ordering is produced without a relevance term; `DRK-AC-009` preserves band order on query surfaces | Implementation lead | ⏳ `SEQUENCED` — authority inputs exist; waits on `IMPL-1619` |
| `IMPL-1647` | Implement full determinism: stable tie-break, no wall clock, explicit version, no learned parameter | `DRK-DET-001`…`006`, `DRK-FR-011` | read composition | `IMPL-1645` | `DRK-AC-002`: two runs on identical input and configuration version are byte-identical; `DRK-AC-004`: equal scores order by `PersonId` ascending | Implementation lead | ⏳ `SEQUENCED` — authority inputs exist; waits on `IMPL-1619` |
| `IMPL-1648` | Implement in-band diversity re-ordering and the fallback renormalisation | `DRK-FR-007`, `DRK-FR-008`, `DRK-FR-010`, `DRK-FR-012`, `DRK-FR-014`, `DRK-EC-005` | read composition | `IMPL-1647` | `DRK-AC-009`: re-ordering occurs only within a band; `DRK-AC-010`: remaining active weights renormalise to `1.00` and a result is still returned. ⛔ Per-viewer frequency capping (`DRK-FR-013`) is **not built** | Implementation lead | ⏳ `SEQUENCED` — authority inputs exist; waits on `IMPL-1619` |
| `IMPL-1649` | Implement per-candidate explainability records routed to `BC-24` via `E-20`, never exposed to a peer | `DRK-EXP-001`…`006` | **`BC-24`** ▶ via `E-20` — ⛔ not owned | `IMPL-1685` | A per-candidate record carries the configuration version and records degradations; ⛔ it is never exposed to a peer and holds no profile or message content | Implementation lead | `READY` |
| `IMPL-1650` | Implement offline replay evaluation and pre-activation configuration evaluation | `DRK-EVAL-001`…`005`, `DRK-CFG-001`…`008` | **`BC-25`** ▶ config via `E-19`; **`BC-26`** ▶ metrics — ⛔ neither owned | `IMPL-1647` | Recorded inputs replay to an identical ordering; a configuration change is evaluable before activation. ⛔ No online experiment or A/B split is built (`DRK-EVAL-004`), and no viewer behavioural data is used (`DRK-EVAL-002`) | Implementation lead | ⏳ `SEQUENCED` — authority inputs exist; waits on `IMPL-1619` |

### §5.6 G5 — B5 recommendations, read composition (`IMPL-1651`…`IMPL-1656`)

⭐ **A second false blocker was caught and removed.** `XPB-CONF-002` (B5's wave
conflict) is **RESOLVED**, not open: Stage 3 §7.1 records *"B5 **V1-eligible**,
narrowed to `PYK-SRC-001`; EA **not** edited"* (`ADR-0091` §4, on the `ADR-0061`
precedent). ⇒ **G5 carries no wave blocker.** What *does* block G5 is
`PYK-GAP-002` — dismissal/suppression state has **no sited store**, ⚠ **OPEN**
with **ARB** — and that is carried on the one row it actually reaches.

⚠ B5's reverse-trace coverage is the lowest of the ten parts at **18.2%**. ⛔ **That is a property of the
subject, not a defect introduced here** — B5 is largely composed of prohibitions
(`POL`, `SUP`, `FRQ`), and a prohibition is discharged by *not building
something*, which is why it is task-light by construction.

| IMPL-ID | Task | Requirement ID(s) | BC/Context | Dependency | Acceptance/Done Condition | Owner/Role | Status |
|---|---|---|---|---|---|---|---|
| `IMPL-1651` | Implement B5 as an `AR-1` read composition owning no aggregate, drawing candidates **only** from B3's contract | `PYK-FR-001`, `PYK-FR-002`, `PYK-SRC-001`…`007` | read composition (`AR-1`) — ⛔ no BC | `IMPL-1642` | Every candidate arrives via B3's published contract; ⛔ B5 holds no aggregate, no invariant and no business state. ⚠ Narrowed to `PYK-SRC-001` per `ADR-0091` §4 | Implementation lead | `READY` |
| `IMPL-1652` | Implement system-initiated, reproducible generation, refusing a viewer with no valid membership | `PYK-FR-003`, `PYK-FR-004`, `PYK-FR-005`, `PYK-FR-006` | read composition | `IMPL-1651`, `IMPL-1634` | Same viewer + same `asOf` + same configuration reproduces the set; a viewer with no valid membership receives none | Implementation lead | `READY` |
| `IMPL-1653` | Enforce that a recommendation passes **every** filter a search would, and bypasses nothing | `PYK-POL-001`…`008` | **`BC-11`** ▶ safety; **`BC-10`** ▶ privacy — ⛔ neither owned | `IMPL-1637`, `IMPL-1628` | A blocked person (either direction) and a privacy-excluded person are both absent; no reason for exclusion is disclosed; ⛔ no cross-library recommendation is generated; ⛔ B5 makes no authorisation decision | Implementation lead | ⛔ `BLOCKED` — inherits `FOD-1` via `IMPL-1637` |
| `IMPL-1654` | Implement dismissal feedback and suppression, undisclosed to the dismissed person and never a safety signal | `PYK-FB-001`…`006`, `PYK-SUP-001`…`008` | read composition; ⚠ `PYK-FB-006` records that **feedback state has no sited store** | `IMPL-1652` | A dismissal suppresses the person from that viewer's set, is invisible to the dismissed person, and is not treated as a safety signal. ⚠ The store for feedback state is unsited in the subject and must be sited before build | ARB (`PYK-GAP-002`), then Implementation lead | ⛔ `BLOCKED` — `PYK-GAP-002` / `PYK-FB-006` unsited store |
| `IMPL-1655` | Implement set capping, refresh windows and cached repeat responses | `PYK-FRQ-001`, `PYK-FRQ-002`, `PYK-FRQ-003`, `PYK-FRQ-005`, `PYK-FRQ-006`, `PYK-CFG-001`…`007` | **`BC-25`** ▶ configuration — ⛔ not owned | `IMPL-1652` | The set is capped at `PYK-CFG-002`; repeated requests inside the window return a stable set; ⛔ no unsolicited notification is sent; ⛔ frequency control never excludes a person outright. `PYK-FRQ-004` per-viewer capping is **not specified and not built** | Implementation lead | `READY` |
| `IMPL-1656` | Implement the presentation surface: allow-listed fields, optional mutual count, opaque cursors, no score exposed | `PYK-PRS-001`…`007` | **`BC-10`** ▶ allow-listed fields only | `IMPL-1611`, `IMPL-1652` | Only allow-listed `BC-10` fields appear; ⛔ no browsable mutual-friend list, ⛔ no score, rank position or weight is exposed; pagination uses opaque cursors | Implementation lead | ⏳ `SEQUENCED` — authority inputs exist; waits on `IMPL-1619` |

### §5.7 G6 — B6 discovery scope, pure policy (`IMPL-1657`…`IMPL-1663`)

⛔ **B6 holds no aggregate, no invariant over stored data and no state** — it is a
pure policy function.

⭐ **A third false blocker was caught and removed.** `XPB-CONF-005` (B6 an
unregistered part identifier) is **DISCHARGED** — Stage 3 §7.1 cites `ADR-0091` §6
and `PRD_REGISTRY.md` §13, and `FOD-4` is likewise recorded **DISCHARGED** for
B4/B5/B6 by registry §13 and for B7/B8/B9 by §14. ⇒ **G6 carries no registration
blocker.** ⚠ What remains open in B6 is `GLS-GAP-002` (multi-library viewer
semantics and `GLOBAL` authorisation, **Product Owner + ARB**) — and B6 already
handles it by keeping `GLOBAL` **OFF** and failing such viewers closed, which is
`GLS-FR-003`/`GLS-FR-008`, already allocated.

| IMPL-ID | Task | Requirement ID(s) | BC/Context | Dependency | Acceptance/Done Condition | Owner/Role | Status |
|---|---|---|---|---|---|---|---|
| `IMPL-1657` | Implement `DiscoveryScope` as a closed four-value server-side enum, supplying exactly one value per request | `GLS-DEF-001`, `GLS-DEF-002`, `GLS-FR-001` | pure policy — ⛔ no BC | — | The enum has exactly four values and is closed; ⛔ it cannot be extended without an architecture decision | Implementation lead | `READY` |
| `IMPL-1658` | Force the V1 value to `LIBRARY` always, and reject the other three with the specified refusal | `GLS-FR-002`, `GLS-FR-003` | pure policy | `IMPL-1657` | Every V1 request resolves to `LIBRARY`; `GLOBAL`, `LOCAL` and `NEARBY` are each rejected in V1; ⚠ this is also the standing containment for `GLS-GAP-002` | Implementation lead | `READY` |
| `IMPL-1659` | Make B3, B4 and B5 obtain scope from B6 and treat it as opaque | `GLS-FR-004` | pure policy → B3/B4/B5 | `IMPL-1632`, `IMPL-1643`, `IMPL-1651` | None of B3, B4 or B5 constructs a scope value locally; each treats it as opaque | Implementation lead | `READY` |
| `IMPL-1660` | Resolve scope server-side before candidate generation and apply it in the **eligibility** stage | `GLS-FR-005`, `GLS-FR-006`, `GLS-FR-007` | pure policy | `IMPL-1633` | Scope is applied at eligibility; ⛔ a post-ranking scope application is impossible by construction | Implementation lead | `READY` |
| `IMPL-1661` | Fail closed when resolved scope is unavailable | `GLS-FR-008` | pure policy | `IMPL-1660` | An unavailable scope fails the request closed; ⛔ no default scope is substituted | Implementation lead | `READY` |
| `IMPL-1662` | Enforce the global-identity / library-membership separation as six structural invariants | `GLS-INV-001`…`006` | **`BC-11`** (structure shape); ⛔ `BC-11` does **not** enforce scope per `GLS-INV-005` | `IMPL-1603` | It is **impossible** for a `tenantId` or `StudentRecordId` to enter a global structure; the membership predicate stays `studentRecordId`-keyed; a `LIBRARY`-scoped result cannot leak a global one | Implementation lead | `READY` |
| `IMPL-1663` | Keep B6 stateless with a two-element output surface, and leave the future global architecture defined but **disabled** | `GLS-FR-009`, `GLS-FR-010`, `GLS-FR-011`, `GLS-CFG-001`…`005` | pure policy — ⛔ no state | `IMPL-1657` | The output surface is one scope value plus a refusal; ⛔ B6 persists nothing and holds no aggregate. `GLS-FUT-001`…`008` remain **defined and NOT enabled** | Implementation lead | `READY` |

### §5.8 G7 — B7 messaging, `BC-12` (`IMPL-1664`…`IMPL-1676`)

⭐ **B7 declines ownership of `BC-12`** at its own **L34**, and that refusal holds
under FROZEN `PRD-020` §10 **L633–634**. B7 *specifies* `BC-12`; it does not claim
it. ⚠ Four of the five genuinely OPEN `XPB-CONF-*` items land in this group —
**`011` (Help→Message), `014` (read receipts), `015` (configurable retention),
`016` (message deletion)** — and each is carried on the row it actually reaches.

| IMPL-ID | Task | Requirement ID(s) | BC/Context | Dependency | Acceptance/Done Condition | Owner/Role | Status |
|---|---|---|---|---|---|---|---|
| `IMPL-1664` | Implement `Conversation` as the aggregate root with exactly two participants and participation as an internal | `MSG-FR-001`, `MSG-FR-002`, `MSG-FR-003` | **`BC-12`** — ⛔ specified, **not owned** by B7 | `IMPL-1603` | A V1 `Conversation` admits exactly two participants; participation is not separately addressable | Implementation lead | `READY` |
| `IMPL-1665` | Implement the closed `Conversation` state enum | `MSG-FR-004` | **`BC-12`** | `IMPL-1664` | The state is drawn from the closed enum; ⛔ no state is added | Implementation lead | `READY` |
| `IMPL-1666` | Implement `Message` as an entity of `Conversation`, immutable after delivery, with `DELETED` deliberately absent | `MSG-FR-005`, `MSG-FR-010` | **`BC-12`** | `IMPL-1664` | A delivered message cannot be mutated; ⛔ **no `DELETED` state exists** — BC Map **L378** holds *"message immutable after delivery"* | Product + Architecture (`XPB-CONF-016`), then Implementation lead | ⛔ `BLOCKED` — `XPB-CONF-016` (message deletion) |
| `IMPL-1667` | Implement the two send gates and a refusal response that discloses nothing | `MSG-FR-007`, `MSG-FR-032`, `MSG-FR-033` | **`BC-12`** ▶ `BC-11` via `E-16`; ▶ `BC-13` enforcement | `IMPL-1618`, `IMPL-1630` | `canMessage(a,b)` is re-asked on **every** send via `E-16`; a refusal by either gate discloses no reason | Implementation lead | ⛔ `BLOCKED` — inherits `FOD-1` via `IMPL-1630` |
| `IMPL-1668` | Implement delivery/failure transitions, with `FAILED` reachable only before `DELIVERED` | `MSG-FR-008`, `MSG-FR-009`, `MSG-FR-019` | **`BC-12`** | `IMPL-1666` | `DELIVERED` is set on durable acceptance by `BC-12`; ⛔ `FAILED` is unreachable after `DELIVERED`; a `DeliveryReceipt` records delivery to `BC-12`'s durable store | Implementation lead | ⛔ `BLOCKED` — inherits `XPB-CONF-016` via `IMPL-1666` |
| `IMPL-1669` | Implement client-supplied idempotency keys with the declared retention | `MSG-FR-011`, `MSG-FR-012`, `TPA-FR-011` | **`BC-12`** | `IMPL-1667` | A replayed key produces one message; keys are retained for at least the declared minimum | Implementation lead | ⏳ `SEQUENCED` — authority inputs exist; waits on `IMPL-1667` |
| `IMPL-1670` | Implement server-assigned per-conversation sequencing and opaque cursor pagination | `MSG-FR-013`, `MSG-FR-014`, `MSG-FR-015`, `TPA-FR-013` | **`BC-12`** | `IMPL-1666` | Sequence is server-assigned and monotonic per conversation; ⛔ **no cross-conversation ordering is provided**; pagination is opaque-cursor only | Implementation lead | ⏳ `SEQUENCED` — authority inputs exist; waits on `IMPL-1666` |
| `IMPL-1671` | Implement per-participant read cursors and derived unread counts, undisclosed in V1 | `MSG-FR-016`, `MSG-FR-017`, `MSG-FR-018` | **`BC-12`** | `IMPL-1670` | The unread count is **derived**, not stored; ⛔ in V1 a read cursor is **not disclosed** to the other participant | Architecture + Product (`XPB-CONF-014`), then Implementation lead | ⛔ `BLOCKED` — `XPB-CONF-014` (read-receipt wave) |
| `IMPL-1672` | Implement per-participant archive with un-archive on new message, and per-participant mute | `MSG-FR-020`, `MSG-FR-021`, `MSG-FR-022` | **`BC-12`** — ⚠ distinct from B2's `Mute` on `BC-11` | `IMPL-1664` | Archive is per-participant view state; a new message un-archives; mute suppresses only for the muting participant | Implementation lead | `READY` |
| `IMPL-1673` | Constrain context references to an opaque closed enum, and route consent/audit facts to `BC-22` | `MSG-FR-023`, `MSG-FR-024`, `MSG-FR-025` | **`BC-12`**; **`BC-22`** ▶ — ⛔ `BC-22` not owned | `IMPL-1664` | The `type` enum is closed and V1-constrained; the reference stays **opaque**; ⚠ only `E-16` inbound and `E-22` outbound exist for `BC-12` | Implementation lead | `READY` |
| `IMPL-1674` | Implement `RetentionPolicy` as a `Conversation` entity, with purge removing bodies and `FileRef`s | `MSG-FR-026`, `MSG-FR-027`, `MSG-FR-028`, `TPA-FR-025` | **`BC-12`** | `IMPL-1664` | Purge removes message bodies and `FileRef`s; ⚠ in V1 the policy is a **fixed platform value** — the *configurable* policy value is undecided | Architecture + Product (`XPB-CONF-015`), then Implementation lead | ⛔ `BLOCKED` — `XPB-CONF-015` (configurable retention) |
| `IMPL-1675` | Implement the four hand-offs — realtime, notification, media, safety — on pre-existing edges only | `MSG-FR-029`, `MSG-FR-030`, `MSG-FR-031` | **`BC-12`** → `BC-30`/`BC-22`/`BC-29`/`BC-13` via `E-22`, `E-23` | `IMPL-1677`, `IMPL-1679`, `IMPL-1683` | Each hand-off uses a **pre-existing** edge; ⛔ **0 edges are created**; attachments are held as `BC-29` `FileRef`s | Implementation lead | ⏳ `SEQUENCED` — authority inputs exist; waits on `IMPL-1679` |
| `IMPL-1676` | ⛔ Do **not** author the Help → Message flow; preserve B7's six-step refusal | `MSG-FR-024`, `MSG-FR-025` | **`BC-12`** ▶ community — ⛔ the source event is **WITHDRAWN** | ⛔⛔ **`XPB-CONF-011`** | ⛔ **Nothing is built.** `community.HelpRequestAnswered` (`LCN-EVT-007`) is **WITHDRAWN** by `ADR-0083` **L237** and `LCN-FR-019` is **VOID**; the number cannot return. Done condition is that the flow remains **unauthored** | Product + Architecture (`XPB-CONF-011`) | ⛔ `BLOCKED` — `XPB-CONF-011` |

### §5.9 G8 — B8 realtime, media & messaging safety (`IMPL-1677`…`IMPL-1684`)

⛔ **B8 owns nothing.** Realtime is a **port** (`platform/services:realtime`,
manifest **L243**), media is `BC-29`'s, offline is `BC-30`'s, and messaging safety
was already decided by `ADR-0065` Option B. ⚠ **`XPB-CONF-017`** (presence/typing
wave) and **`XPB-CONF-013`** (`FIL-GAP-013` confinement) land here.

| IMPL-ID | Task | Requirement ID(s) | BC/Context | Dependency | Acceptance/Done Condition | Owner/Role | Status |
|---|---|---|---|---|---|---|---|
| `IMPL-1677` | Implement the realtime hand-off and post-reconnect reconciliation | `RTM-FR-001`, `RTM-FR-002`, `TPA-FR-008` | **`BC-30`** / realtime **port** — ⛔ not a context, not owned | `IMPL-1670` | An accepted `Message` is handed to the realtime port; a client reconciles after reconnect by reading, not by replay | Implementation lead | ⏳ `SEQUENCED` — authority inputs exist; waits on `IMPL-1666` |
| `IMPL-1678` | Implement subscription authorisation and connection lifecycle, with no tenant key in any frame | `RTM-FR-003`, `RTM-FR-004`, `RTM-FR-005`, `TPA-INV-003`, `TPA-FR-017` | realtime **port**; **`BC-12`** state | `IMPL-1603`, `IMPL-1667` | Subscription authorisation is evaluated server-side per subscription; ⛔ **no frame carries a `tenantId`** | Implementation lead | ⏳ `SEQUENCED` — authority inputs exist; waits on `IMPL-1667` |
| `IMPL-1679` | Implement presence and typing as `BC-12` state, undisclosed in V1 | `RTM-FR-006`, `RTM-FR-007` | **`BC-12`** — ⚠ *"un-dated by authority"* | ⛔ **`XPB-CONF-017`** | ⛔ In V1 presence is **not disclosed to any other person**. ⚠ EA **L1854**/**L1855** date presence/typing V2/V3 while B8 needs them; `RTM-GAP-001` is the open record | Architecture + Product (`XPB-CONF-017`) | ⛔ `BLOCKED` — `XPB-CONF-017` |
| `IMPL-1680` | Hold attachments as `BC-29` `FileRef`s, uploading against `BC-29` and never proxying bytes | `RTM-FR-008`, `RTM-FR-009`, `RTM-FR-013`, `TPA-FR-016` | **`BC-29`** ▶ via `E-22` — ⛔ not owned | `IMPL-1675` | Upload targets `BC-29`; ⛔ `BC-12` never stores or proxies media bytes; media in messaging is **V1** per `RTM-FR-013` | Implementation lead | ⏳ `SEQUENCED` — authority inputs exist; waits on `IMPL-1666`, `IMPL-1679` |
| `IMPL-1681` | Implement read-only share grants and grant revocation on retention purge | `RTM-FR-010`, `RTM-FR-011`, `RTM-FR-012` | **`BC-29`** ▶ | `IMPL-1674`, `IMPL-1680` | A grant conveys **read access only** (FROZEN); a purge revokes the grants it created | Implementation lead | ⛔ `BLOCKED` — inherits `XPB-CONF-015` via `IMPL-1674` |
| `IMPL-1682` | ⚠ Record the attachment-sharing confinement **shape** only, without closing `FIL-GAP-013` | `RTM-FR-014`, `RTM-FR-026` | **`BC-29`** ▶ | ⛔ **`XPB-CONF-013`** | ⛔ **Nothing is closed.** FROZEN `PRD-017` **L1162–65** assigns the confinement statement to `PRD-021`; B8 states the shape only, and `RTM-FR-026` **forbids** claiming `TSF-GAP-003` closed | Product Owner (`XPB-CONF-013`) | ⛔ `BLOCKED` — `XPB-CONF-013` |
| `IMPL-1683` | Implement the local enforcement-state read model with a fail-closed staleness gate and observable lag | `RTM-FR-015`, `RTM-FR-016`, `RTM-FR-017`, `RTM-FR-018`, `RTM-FR-019`, `TPA-FR-018`, `TPA-FR-019`, `TPA-INV-008` | **`BC-12`** local read model of **`BC-13`** state | `IMPL-1629`, `IMPL-1685` | The model is consulted on **every** send; a stale model **fails closed**; the check meets FROZEN `TSF-FR-001` **p99 ≤ 50 ms**; lag is observable and alertable | Implementation lead | `READY` |
| `IMPL-1684` | Implement the safety and notification hand-offs, minor-contact restriction and `E-14` self-restriction | `RTM-FR-021`, `RTM-FR-022`, `RTM-FR-023`, `RTM-FR-024`, `RTM-FR-025`, `RTM-FR-029`, `RTM-FR-030`, `TPA-INV-006` | **`BC-13`** ▶, **`BC-22`** ▶ via `E-23` — ⛔ neither owned | `IMPL-1683` | Reported content reaches `BC-13` only in the specified form; a reported link is recorded by normalised URL; on `E-14` `BC-12` **self-restricts** and ⛔ `BC-13` performs no write into it; ⛔ no second notification system is created | Implementation lead | `READY` |

### §5.10 G9 — B9 cross-cutting technical architecture (`IMPL-1685`…`IMPL-1689`)

⛔ **B9 owns nothing** — `TPA-INV-001` forbids any `PRD-021B` part from owning a
row it does not already own. G9 is the platform wiring the other nine groups
depend on, which is why so many rows above name `IMPL-1685`.

| IMPL-ID | Task | Requirement ID(s) | BC/Context | Dependency | Acceptance/Done Condition | Owner/Role | Status |
|---|---|---|---|---|---|---|---|
| `IMPL-1685` | Wire the event architecture — publish two, consume the declared set, on the 16 pre-existing edges, creating none | `TPA-FR-001`, `TPA-FR-009`, `TPA-FR-010`, `TPA-FR-026`, `SGR-EVT-002` | `BC-11`, `BC-12` → `BC-13`, `BC-22`, `BC-23`, `BC-24`, `BC-26`, `BC-29`, `BC-30` | — | **8 edges used, 0 created**; ⛔ `E-27` is **not referenced**; ⛔ **no event is minted** (`SGR-EVT-002`); `BC-26` receives `messaging.MessageSent` and `BC-11`'s two events | Implementation lead | `READY` |
| `IMPL-1686` | Implement per-context persistence, the two recomputable `BC-12` projections, and anonymisation propagation | `TPA-FR-002`, `TPA-FR-003`, `TPA-FR-004`, `TPA-INV-004` | `BC-11`, `BC-12` | `IMPL-1685` | `BC-11` and `BC-12` hold separate persistence; **every projection is reconstructible from its event stream**; `identity.PersonAnonymised` propagates per BC Map **L428** | Implementation lead | `READY` |
| `IMPL-1687` | Implement the declared index set, cache policy restricted to public read models, and opaque-cursor pagination | `TPA-FR-005`, `TPA-FR-013`, `TPA-FR-015`, `SDS-IDX-001`…`010`, `SGR-CACHE-001`…`006`, `SSF-CACHE-001`…`006`, `SDS-CACHE-001`…`008` | `BC-11`, `BC-12`, **`BC-23`** ▶ | `IMPL-1641`, `IMPL-1686` | Every declared access path is indexed; ⛔ **caching is permitted only for public read models**; every list endpoint uses opaque cursors; ⛔ no database engine is selected | Implementation lead | `READY` |
| `IMPL-1688` | Implement observability, background jobs, failure/recovery and the fail-closed consistency rule | `TPA-FR-020`, `TPA-FR-021`, `TPA-FR-022`, `TPA-FR-023`, `TPA-FR-024`, `TPA-FR-031`, `TPA-INV-008` | cross-cutting; **`BC-24`** ▶ via `E-20` | `IMPL-1683`, `IMPL-1686` | Enforcement read-model lag and `canMessage` latency are observable; retention purge runs as background work; strong consistency within an aggregate and eventual across contexts; ⛔ **a safety dependency fails closed** | Implementation lead | `READY` |
| `IMPL-1689` | Enforce module boundaries, additive-only API versioning, default-OFF flags for contested capabilities, and the test matrix | `TPA-FR-027`, `TPA-FR-028`, `TPA-FR-029`, `TPA-FR-030`, `TPA-INV-001` | cross-cutting | `IMPL-1600`, `IMPL-1601` | `tool/module_dependencies.yaml` is the single source and CI enforces it; ⛔ **no removed field or narrowed type ships**; every contested capability is flag-gated **default OFF**; the test matrix covers `MSG-AC-001`…`030` and `RTM-AC-001`…`028`. ⛔ **0 of 242 criteria are proven here** | Implementation lead | `READY` |

---

## §6. Rule 3 — `Priority`, `Blocks`, `Blocked by`, for all 90

`PRD_LIFECYCLE.md` **L142** requires this per task, and the instruction's eight
mandated columns do not carry it (§1). This register supplies it for **the same
90 IDs** — it adds no task, retires none, and renames none.

⭐ **Every cell below is derived, not asserted.** `Blocked by` is the Dependency
cell of §5. `Blocks` is its **mechanical inverse** over all **106** edges.
`Priority` is a function of transitive fan-out — how much work each task unblocks
— *except* for `BLOCKED` rows, where gate-script check 9 requires a blocker
rather than a schedulable priority, so none is given. The graph was verified
**acyclic**; two inversions found while checking it are recorded as **`S6-I-5`**.

| Band | Rule |
|---|---|
| `P1` | Transitively unblocks **≥ 12** tasks — foundation work |
| `P2` | Transitively unblocks **4–11** tasks |
| `P3` | Transitively unblocks **≤ 3** tasks — leaf work |
| ⛔ | `Status` = `BLOCKED`; **no priority is assigned** (check 9) |

| IMPL-ID | Group | Priority | Blocks | Blocked by | Governance blocker |
|---|---|---|---|---|---|
| `IMPL-1600` | G0 | P1 | `IMPL-1601`, `IMPL-1602`, `IMPL-1603`, `IMPL-1689` | `IMPL-1685` | — |
| `IMPL-1601` | G0 | P3 | `IMPL-1689` | `IMPL-1600` | — |
| `IMPL-1602` | G0 | P1 | `IMPL-1624`, `IMPL-1632`, `IMPL-1644` | `IMPL-1600` | — |
| `IMPL-1603` | G0 | P1 | `IMPL-1662`, `IMPL-1664`, `IMPL-1678` | `IMPL-1600` | — |
| `IMPL-1604` | G0 | P3 | ⛔ none — leaf | `IMPL-1689` | — |
| `IMPL-1605` | G1 | ⛔ **not scheduled** — blocker, not a priority | `IMPL-1616` | ⛔ none — root | **`FOD-1`** |
| `IMPL-1606` | G1 | ⛔ **not scheduled** — blocker, not a priority | `IMPL-1607`, `IMPL-1608`, `IMPL-1609` | ⛔ none — root | **`FOD-1`** |
| `IMPL-1607` | G1 | ⛔ **not scheduled** — blocker, not a priority | ⛔ none — leaf | `IMPL-1606` | **`FOD-1`** |
| `IMPL-1608` | G1 | P3 | ⛔ none — leaf | `IMPL-1606` | — |
| `IMPL-1609` | G1 | P3 | `IMPL-1638` | `IMPL-1606`, `IMPL-1619` | — |
| `IMPL-1610` | G1 | P3 | ⛔ none — leaf | `IMPL-1619` | — |
| `IMPL-1611` | G1 | P2 | `IMPL-1638`, `IMPL-1645`, `IMPL-1656` | `IMPL-1619` | — |
| `IMPL-1612` | G1 | P3 | `IMPL-1623` | `IMPL-1630` | — |
| `IMPL-1613` | G1 | ⛔ **not scheduled** — blocker, not a priority | `IMPL-1620` | `IMPL-1619` | **`FOD-1`** |
| `IMPL-1614` | G1 | ⛔ **not scheduled** — blocker, not a priority | `IMPL-1615`, `IMPL-1625` | ⛔ none — root | **`FOD-1`** |
| `IMPL-1615` | G1 | ⛔ **not scheduled** — blocker, not a priority | ⛔ none — leaf | `IMPL-1614`, `IMPL-1626` | **`FOD-1`** |
| `IMPL-1616` | G1 | ⛔ **not scheduled** — blocker, not a priority | ⛔ none — leaf | `IMPL-1605` | **`FOD-1`** |
| `IMPL-1617` | G1 | P3 | `IMPL-1640` | `IMPL-1685` | — |
| `IMPL-1618` | G1 | P3 | `IMPL-1667` | `IMPL-1685` | — |
| `IMPL-1619` | G2 | ⛔ **not scheduled** — blocker, not a priority | `IMPL-1609`, `IMPL-1610`, `IMPL-1611`, `IMPL-1613`, `IMPL-1620`, `IMPL-1621`, `IMPL-1622`, `IMPL-1623`, `IMPL-1627` | ⛔ none — root | **`FOD-1`** |
| `IMPL-1620` | G2 | ⛔ **not scheduled** — blocker, not a priority | ⛔ none — leaf | `IMPL-1613`, `IMPL-1619` | **`FOD-1`** |
| `IMPL-1621` | G2 | ⛔ **not scheduled** — blocker, not a priority | ⛔ none — leaf | `IMPL-1619` | **`FOD-1`** |
| `IMPL-1622` | G2 | ⛔ **not scheduled** — blocker, not a priority | `IMPL-1628`, `IMPL-1630` | `IMPL-1619` | **`FOD-1`** |
| `IMPL-1623` | G2 | ⛔ **not scheduled** — blocker, not a priority | ⛔ none — leaf | `IMPL-1612`, `IMPL-1619` | **`FOD-1`** |
| `IMPL-1624` | G2 | P3 | ⛔ none — leaf | `IMPL-1602` | — |
| `IMPL-1625` | G2 | ⛔ **not scheduled** — blocker, not a priority | `IMPL-1626` | `IMPL-1614` | **`FOD-1`** |
| `IMPL-1626` | G2 | ⛔ **not scheduled** — blocker, not a priority | `IMPL-1615` | `IMPL-1625` | **`FOD-1`** |
| `IMPL-1627` | G2 | ⛔ **not scheduled** — blocker, not a priority | ⛔ none — leaf | `IMPL-1619` | **`FOD-1`** |
| `IMPL-1628` | G2 | ⛔ **not scheduled** — blocker, not a priority | `IMPL-1637`, `IMPL-1653` | `IMPL-1622`, `IMPL-1632` | **`FOD-1`** |
| `IMPL-1629` | G2 | P2 | `IMPL-1640`, `IMPL-1683` | `IMPL-1685` | — |
| `IMPL-1630` | G2 | ⛔ **not scheduled** — blocker, not a priority | `IMPL-1612`, `IMPL-1637`, `IMPL-1667` | `IMPL-1622` | **`FOD-1`** |
| `IMPL-1631` | G2 | ⛔ **not scheduled** — blocker, not a priority | ⛔ none — leaf | ⛔ none — root | **`FOD-2`** |
| `IMPL-1632` | G3 | P1 | `IMPL-1628`, `IMPL-1635`, `IMPL-1642`, `IMPL-1644`, `IMPL-1659` | `IMPL-1602`, `IMPL-1657` | — |
| `IMPL-1633` | G3 | P2 | `IMPL-1634`, `IMPL-1660` | `IMPL-1657` | — |
| `IMPL-1634` | G3 | P2 | `IMPL-1639`, `IMPL-1652` | `IMPL-1633` | — |
| `IMPL-1635` | G3 | P3 | `IMPL-1636` | `IMPL-1632`, `IMPL-1641` | — |
| `IMPL-1636` | G3 | P3 | ⛔ none — leaf | `IMPL-1635` | — |
| `IMPL-1637` | G3 | ⛔ **not scheduled** — blocker, not a priority | `IMPL-1653` | `IMPL-1628`, `IMPL-1630` | **`FOD-1`** |
| `IMPL-1638` | G3 | P3 | ⛔ none — leaf | `IMPL-1609`, `IMPL-1611` | — |
| `IMPL-1639` | G3 | P3 | ⛔ none — leaf | `IMPL-1634` | — |
| `IMPL-1640` | G3 | P3 | ⛔ none — leaf | `IMPL-1617`, `IMPL-1629` | — |
| `IMPL-1641` | G3 | P2 | `IMPL-1635`, `IMPL-1645`, `IMPL-1687` | `IMPL-1685` | — |
| `IMPL-1642` | G3 | P2 | `IMPL-1643`, `IMPL-1651` | `IMPL-1632` | — |
| `IMPL-1643` | G4 | P3 | `IMPL-1659` | `IMPL-1642` | — |
| `IMPL-1644` | G4 | P3 | ⛔ none — leaf | `IMPL-1602`, `IMPL-1632` | — |
| `IMPL-1645` | G4 | P2 | `IMPL-1646`, `IMPL-1647` | `IMPL-1611`, `IMPL-1641` | — |
| `IMPL-1646` | G4 | P3 | ⛔ none — leaf | `IMPL-1645` | — |
| `IMPL-1647` | G4 | P3 | `IMPL-1648`, `IMPL-1650` | `IMPL-1645` | — |
| `IMPL-1648` | G4 | P3 | ⛔ none — leaf | `IMPL-1647` | — |
| `IMPL-1649` | G4 | P3 | ⛔ none — leaf | `IMPL-1685` | — |
| `IMPL-1650` | G4 | P3 | ⛔ none — leaf | `IMPL-1647` | — |
| `IMPL-1651` | G5 | P2 | `IMPL-1652`, `IMPL-1659` | `IMPL-1642` | — |
| `IMPL-1652` | G5 | P3 | `IMPL-1654`, `IMPL-1655`, `IMPL-1656` | `IMPL-1634`, `IMPL-1651` | — |
| `IMPL-1653` | G5 | ⛔ **not scheduled** — blocker, not a priority | ⛔ none — leaf | `IMPL-1628`, `IMPL-1637` | **`FOD-1`** |
| `IMPL-1654` | G5 | ⛔ **not scheduled** — blocker, not a priority | ⛔ none — leaf | `IMPL-1652` | **`PYK-GAP-002`** |
| `IMPL-1655` | G5 | P3 | ⛔ none — leaf | `IMPL-1652` | — |
| `IMPL-1656` | G5 | P3 | ⛔ none — leaf | `IMPL-1611`, `IMPL-1652` | — |
| `IMPL-1657` | G6 | P1 | `IMPL-1632`, `IMPL-1633`, `IMPL-1658`, `IMPL-1663` | ⛔ none — root | — |
| `IMPL-1658` | G6 | P3 | ⛔ none — leaf | `IMPL-1657` | — |
| `IMPL-1659` | G6 | P3 | ⛔ none — leaf | `IMPL-1632`, `IMPL-1643`, `IMPL-1651` | — |
| `IMPL-1660` | G6 | P3 | `IMPL-1661` | `IMPL-1633` | — |
| `IMPL-1661` | G6 | P3 | ⛔ none — leaf | `IMPL-1660` | — |
| `IMPL-1662` | G6 | P3 | ⛔ none — leaf | `IMPL-1603` | — |
| `IMPL-1663` | G6 | P3 | ⛔ none — leaf | `IMPL-1657` | — |
| `IMPL-1664` | G7 | P1 | `IMPL-1665`, `IMPL-1666`, `IMPL-1672`, `IMPL-1673`, `IMPL-1674` | `IMPL-1603` | — |
| `IMPL-1665` | G7 | P3 | ⛔ none — leaf | `IMPL-1664` | — |
| `IMPL-1666` | G7 | ⛔ **not scheduled** — blocker, not a priority | `IMPL-1668`, `IMPL-1670` | `IMPL-1664` | **`XPB-CONF-016`** |
| `IMPL-1667` | G7 | ⛔ **not scheduled** — blocker, not a priority | `IMPL-1669`, `IMPL-1678` | `IMPL-1618`, `IMPL-1630` | **`FOD-1`** |
| `IMPL-1668` | G7 | ⛔ **not scheduled** — blocker, not a priority | ⛔ none — leaf | `IMPL-1666` | **`XPB-CONF-016`** |
| `IMPL-1669` | G7 | P3 | ⛔ none — leaf | `IMPL-1667` | — |
| `IMPL-1670` | G7 | P2 | `IMPL-1671`, `IMPL-1677` | `IMPL-1666` | — |
| `IMPL-1671` | G7 | ⛔ **not scheduled** — blocker, not a priority | ⛔ none — leaf | `IMPL-1670` | **`XPB-CONF-014`** |
| `IMPL-1672` | G7 | P3 | ⛔ none — leaf | `IMPL-1664` | — |
| `IMPL-1673` | G7 | P3 | ⛔ none — leaf | `IMPL-1664` | — |
| `IMPL-1674` | G7 | ⛔ **not scheduled** — blocker, not a priority | `IMPL-1681` | `IMPL-1664` | **`XPB-CONF-015`** |
| `IMPL-1675` | G7 | P3 | `IMPL-1680` | `IMPL-1677`, `IMPL-1679`, `IMPL-1683` | — |
| `IMPL-1676` | G7 | ⛔ **not scheduled** — blocker, not a priority | ⛔ none — leaf | ⛔ none — root | **`XPB-CONF-011`** |
| `IMPL-1677` | G8 | P3 | `IMPL-1675` | `IMPL-1670` | — |
| `IMPL-1678` | G8 | P3 | ⛔ none — leaf | `IMPL-1603`, `IMPL-1667` | — |
| `IMPL-1679` | G8 | ⛔ **not scheduled** — blocker, not a priority | `IMPL-1675` | ⛔ none — root | **`XPB-CONF-017`** |
| `IMPL-1680` | G8 | P3 | `IMPL-1681` | `IMPL-1675` | — |
| `IMPL-1681` | G8 | ⛔ **not scheduled** — blocker, not a priority | ⛔ none — leaf | `IMPL-1674`, `IMPL-1680` | **`XPB-CONF-015`** |
| `IMPL-1682` | G8 | ⛔ **not scheduled** — blocker, not a priority | ⛔ none — leaf | ⛔ none — root | **`XPB-CONF-013`** |
| `IMPL-1683` | G8 | P2 | `IMPL-1675`, `IMPL-1684`, `IMPL-1688` | `IMPL-1629`, `IMPL-1685` | — |
| `IMPL-1684` | G8 | P3 | ⛔ none — leaf | `IMPL-1683` | — |
| `IMPL-1685` | G9 | P1 | `IMPL-1600`, `IMPL-1617`, `IMPL-1618`, `IMPL-1629`, `IMPL-1641`, `IMPL-1649`, `IMPL-1683`, `IMPL-1686` | ⛔ none — root | — |
| `IMPL-1686` | G9 | P3 | `IMPL-1687`, `IMPL-1688` | `IMPL-1685` | — |
| `IMPL-1687` | G9 | P3 | ⛔ none — leaf | `IMPL-1641`, `IMPL-1686` | — |
| `IMPL-1688` | G9 | P3 | ⛔ none — leaf | `IMPL-1683`, `IMPL-1686` | — |
| `IMPL-1689` | G9 | P3 | `IMPL-1604` | `IMPL-1600`, `IMPL-1601` | — |

**Distribution.** `P1` 7 · `P2` 10 · `P3` 43 · ⛔ blocked 30 = **90**.

**Graph shape.** 10 roots · 43 leaves · 106 edges · **acyclic** (verified by depth-first colouring, not by inspection).

⛔ **No `BLOCKED` row carries a priority.** 30 rows of 90 are blocked, and all 30 show a named governance item instead — `PRD-021A`'s gate script calls this check 9.

---

## §7. Rule 4 — traceability: task groups → requirements → invariants → acceptance

`PRD_LIFECYCLE.md` **L143–145** requires this mapping, and it is the conjunct on
which the gate actually turns: *"a task document in which **every task traces back
to requirements**."*

⭐ **Read the denominators, not just the percentages.** `PRD-021B` publishes
**1,300** identifiers across **113** registers, of which **385** are normative
requirements (`FR` + `BR` + `INV`). The remainder are acceptance criteria and
`API`/`DM`/`PRV`/`SEC`/`CACHE`/`IDX`/`POL` registers, plus **disclosed absences**
(`GAP`, `FOD`, `ACGAP`, `FUT`, `CONF`, `DRIFT`) that ⛔ **may not** be cited as a
task's authority. Every figure below is stated **with its denominator**, because
`375 ÷ 365` once produced *102.7%* in this programme and a bare percentage hides
exactly that class of error.

⚠ **Citations are range-expanded before counting.** A cell reading
`` `XPA-BND-001`…`006` `` is six identifiers, not two tokens. Counting tokens
would have understated coverage by **108**.

| Group | Subject | IMPL range | Tasks | Registers | Requirements cited | Invariants carried | ACs named in done-conditions |
|---|---|---|---|---|---|---|---|
| **G0** | B0 cross-part architecture | `IMPL-1600`…`1604` | 5 | 7 | **24** | `GLS-INV-002`, `TPA-INV-003`, `TPA-INV-005` | 4 |
| **G1** | B1 global social graph, `BC-11` | `IMPL-1605`…`1618` | 14 | 7 | **46** | ⛔ none | 26 |
| **G2** | B2 social safety, `BC-11` | `IMPL-1619`…`1631` | 13 | 5 | **39** | ⛔ none | 6 |
| **G3** | B3 student discovery, read composition | `IMPL-1632`…`1642` | 11 | 4 | **31** | `TPA-INV-002`, `TPA-INV-005` | 0 |
| **G4** | B4 discovery ranking, read composition | `IMPL-1643`…`1650` | 8 | 9 | **44** | `TPA-INV-005` | 6 |
| **G5** | B5 recommendations, read composition | `IMPL-1651`…`1656` | 6 | 8 | **54** | ⛔ none | 0 |
| **G6** | B6 discovery scope, pure policy | `IMPL-1657`…`1663` | 7 | 4 | **24** | `GLS-INV-001`, `GLS-INV-002`, `GLS-INV-003`, `GLS-INV-004`, `GLS-INV-005`, `GLS-INV-006` | 0 |
| **G7** | B7 messaging, `BC-12` | `IMPL-1664`…`1676` | 13 | 2 | **35** | ⛔ none | 0 |
| **G8** | B8 realtime, media & messaging safety | `IMPL-1677`…`1684` | 8 | 3 | **35** | `TPA-INV-003`, `TPA-INV-006`, `TPA-INV-008` | 0 |
| **G9** | B9 cross-cutting technical architecture | `IMPL-1685`…`1689` | 5 | 7 | **54** | `TPA-INV-001`, `TPA-INV-004`, `TPA-INV-008` | 58 |
| | **totals** | `IMPL-1600`…`1689` | **90** | **44** | **360** distinct | **13** distinct | **97** distinct |

### §7.1 What the numbers mean, with denominators

| Measure | Value | Denominator | Result |
|---|---|---|---|
| Tasks allocated | **90** | `IMPL-1600`…`1689` contiguous | — |
| Tasks tracing to ≥ 1 requirement | **90** | 90 | **100%** |
| ⛔ Orphan tasks (no citation) | **0** | 90 | ✅ |
| Distinct identifiers cited | **360** | 1300 citable | 27.7% |
| Normative `FR`/`BR`/`INV` cited | **214** | 385 | **55.6%** |
| Invariants carried | **13** | 20 defined | 65.0% |
| Acceptance criteria named in done-conditions | **97** | 242 defined | 40.1% |
| ⛔ Dangling citations | **0** | 360 | ✅ |
| ⛔ Minted identifiers | **0** | — | ✅ |
| Registers touched | **44** | 113 | 38.9% |

⚠ **55.6% is not a defect, and it is not a target.** Stage 5 measured *reverse*
coverage at **53.4%** on the same ten subjects and recorded why: much of
`PRD-021B` is **prohibition**. B5 reverse-traced at **18.2%** because it is
largely a register of things that must not be built, and **a prohibition needs no
implementation task — authoring one would invert it.** The requirements not cited
here are overwhelmingly of that kind, plus `API`/`SEC`/`PRV`/`CACHE` registers
discharged *inside* a cited task rather than as a task of their own. ⛔ **Coverage
is reported, not gated** — `PRD-021A`'s gate script calls this check 10, and this
document does not treat the figure as a pass condition.

⛔ **The 7 invariants not carried, named rather than rounded away:**
`MSG-INV-001`, `MSG-INV-002`, `MSG-INV-003`, `MSG-INV-004`, `MSG-INV-005`, `MSG-INV-006`, `TPA-INV-007`. Each is a B7 messaging invariant or
`TPA-INV-007`, discharged by the behaviour of a cited requirement rather than by a
task of its own. **They are listed because a coverage figure that hides its
exclusions is not a measurement.**

⚠ **Acceptance criteria are *named*, never *proven*, here.** 97 of 242
criteria appear in a done-condition as the test that will decide the task.
⛔ **0 of 242 are proven** — proof is Stage 8/9, and no code exists.


---

## §8. Validation — every guarantee measured, none asserted

Ten checks. Each states what was run, the denominator, and the result. ⭐ The
standard is `tool/docs_check/prd021a_task_coverage.py`, the gate script the
`PRD-021A` Stage 6 precedent was certified with; its ten checks are mirrored here
and §10 discloses why a `prd021b_` twin was not written.

### §8.1 Range integrity

| Probe | Result | Denominator |
|---|---|---|
| Rows parsed from §5 with **exactly 8** columns | **90** | 90 declared |
| Distinct `IMPL-*` numbers | **90** | 90 rows → **no duplicate** |
| Lowest / highest | `IMPL-1600` / `IMPL-1689` | — |
| Contiguous with **no hole** | ✅ `1600..1689` set-equal to `range(1600,1690)` | 90 |
| Numbers carrying **more than one** row | **0** | 90 |
| Numbers carrying **zero** rows | **0** | 90 |

⭐ **Set equality, not min/max.** A range can have the right endpoints and a hole
in the middle; comparing the sorted set against `range(1600,1690)` is the only
test that excludes that.

### §8.2 Rule 1 — no reuse, verified repository-wide

Every file matching `*.md`, `*.py`, `*.dart`, `*.yaml`, `*.yml` outside `.git`
was scanned for `IMPL-\d{3,4}`. **889** distinct numbers occur repository-wide.

| Probe | Result |
|---|---|
| Numbers in `1600`…`1689` occurring **outside** this document | **1** — `IMPL-1600` only |
| Is that an allocation? | ⛔ **No.** Read at its lines: `PRD-021A_IMPLEMENTATION_TASKS.md` **L147** declares it `Unallocated — measured empty` — a statement that the number is **free** — and **L137** warns *"Counting it as an allocation would have pushed this range to `IMPL-1600` and left a 100-number hole."* The `PRD-021B` Stage 6 readiness audit's hits (**L178**, **L198**, **L205**) are **measured evidence** of the ceiling |
| ⛔ Numbers **reused or reassigned** from another module | **0** |
| Growth reserve `1690`…`1749` occupied elsewhere | **EMPTY — 0 occurrences** |

⭐⭐ **This is the trap that decided the range.** Had `IMPL-1600` been counted as
occupied rather than read, allocation would have begun at `1700` and stranded
**100** numbers — the exact error `PRD-021A` **L137** warns against, and the third
time this repository has set it (`PRD-007`'s `IMPL-500`, `PRD-021A`'s `IMPL-1500`).
**Measuring a number is not allocating it.**

### §8.3 THE GATE — every task traces back to requirements

| Probe | Result | Denominator |
|---|---|---|
| Tasks citing **≥ 1** identifier | **90** | 90 → **100%** |
| ⛔ **Orphan tasks** — a task with no requirement | **0** | 90 |
| ⛔ **Dangling citations** — an identifier the subjects do not define | **0** | 360 cited |
| ⛔ Tasks citing a **disclosed absence as their authority** | **0** | 90 |
| ⛔ **Duplicate tasks** — two rows, one job | **0** | 90 |

⭐ **Citations were validated against the subjects, not against a list I wrote.**
All **1,300** identifiers were re-extracted from the ten `PRD-021B` files at
authoring time and every cited token tested for membership. A citation that
merely *looks* well-formed would still fail this check.

⚠ **One defect was caught by this check and repaired, not waived.** `IMPL-1604`
originally cited `XPA-ACGAP-001`…`003` as its authority — an `ACGAP` is a
**disclosed absence**, which §2.2 forbids as an authority. It now cites
`TPA-FR-027` and `TPA-BR-042`, which genuinely mandate the test matrix and its
negative cases, and the `ACGAP` items remain in the done-condition as **scope**.
A gap cannot authorise work; naming one there would have been an orphan wearing a
citation.

### §8.4 Rule 4 — wildcards eliminated

| Probe | Result |
|---|---|
| ⛔ Wildcard citations (`` `MSG-XC-*` ``-style) in a `Requirement ID(s)` cell | **0** |
| Wildcards found and replaced during authoring | **5** — `SSF-BR-*`→`007/008/009`, `SSF-AC-*`, `TPA-AC-*`→`TPA-AC-014`, `DRK-AC-*`→`DRK-AC-001`, `MSG-XC-*`→`MSG-FR-025` |

⭐ A wildcard cannot be checked. `` `MSG-XC-*` `` would satisfy a human reader and
fail check 5 of the gate script, because no identifier by that name exists.

### §8.5 No minting

| Probe | Result |
|---|---|
| ⛔ Requirements minted | **0** |
| ⛔ Acceptance criteria minted | **0** |
| ⛔ BCs, events, edges, APIs, integrations minted | **0** |
| ⛔ Owners invented | **0** — roles only, per `PGA-08` |
| ⛔ Registers extended | **0** |
| Subjects edited | **0 of 10** — sha256 identical to §2.1 |

### §8.6 The dependency graph

| Probe | Result |
|---|---|
| Edges | **106** |
| ⛔ **Cycles** | **0** — verified by depth-first colouring |
| ⛔ Dependencies pointing outside `1600`…`1689` | **0** |
| Roots (no predecessor) | **10** |
| ⛔ `READY` rows sitting behind a `BLOCKED` predecessor | **0** |

⚠⚠ **Two cycles were found here and fixed at source (`S6-I-5`).** `IMPL-1602`
(the precedence resolver) named `IMPL-1632`/`IMPL-1643` as *dependencies* when it
is their **input**, and `IMPL-1603` did the same with `IMPL-1605`/`IMPL-1664`.
Both were inverted arrows, not real cycles in the work — but a task plan with a
cycle in it cannot be scheduled at all, so the arrows were corrected and the
graph re-verified acyclic. ⭐ **A cycle is invisible to inspection and obvious to
a colouring pass**; this is why the check exists.

### §8.7 Status honesty

| Status | Count | Meaning |
|---|---|---|
| `READY` | **41** | Schedulable now |
| ⛔ `BLOCKED` | **30** | Carries a governance blocker, **no priority** |
| ⏳ `SEQUENCED` | **18** | Decided, but behind a blocked predecessor |
| ⚠ `PARTIAL` | **1** | One named sub-part gated |
| **total** | **90** | |

⚠⚠ **`SEQUENCED` exists because this check failed once (`S6-I-4`).** The first
draft marked **18** rows `READY` whose own Dependency cells named a `BLOCKED`
predecessor. Both easy answers were false: `READY` contradicts *"schedulable"*,
and `BLOCKED` would have invented a governance blocker where **no decision is
missing**. The 18 were re-stated **mechanically from the graph**, and the count is
now **0**.

### §8.8 Check 9 — blocked tasks carry blockers, not priorities

| Probe | Result | Denominator |
|---|---|---|
| `BLOCKED` rows | **30** | 90 |
| `BLOCKED` rows carrying a **named** governance item | **30** | 30 → **100%** |
| ⛔ `BLOCKED` rows carrying a schedulable priority | **0** | 30 |
| Distinct blockers | **9** — `FOD-1`, `FOD-2`, `PYK-GAP-002`, `XPB-CONF-011`/`013`/`014`/`015`/`016`/`017` | 90 |

### §8.9 ⭐⭐ Three false blockers caught and removed

The single most consequential check in this document, and it is a **subtraction**.

| Item | I had marked it | The authority says | Where |
|---|---|---|---|
| `XPB-CONF-002` | ⛔ blocking all of G5 (B5) | **RESOLVED** — B5 is **V1-eligible**, narrowed to `PYK-SRC-001` | Stage 3 §7.1; `ADR-0091` §4; `ADR-0061` precedent |
| `XPB-CONF-003` | ⛔ blocking G4 rows | **REFUSED, final** | Stage 3 §7.1; `ADR-0091` §5.2; `X-05` |
| `XPB-CONF-005` | ⛔ blocking G6 rows | **DISCHARGED** | Stage 3 §7.1; `ADR-0091` §6; `PRD_REGISTRY.md` §13 |
| `FOD-4` | ⛔ blocking B4/B5/B7/B8/B9 | **DISCHARGED** — and by **B0 itself**, at L329–345 | B0 §8; registry §13/§14 |

⭐ **How it was caught.** Roughly **15** rows across G4/G5/G6 had been drafted as
`BLOCKED`. The arithmetic did not agree with the carried fact that the OPEN set is
`011`, `013`–`017`, so the **authoritative ledger** — Stage 3 §7.1, a 17-item
table with a per-row Disposition column — was read verbatim instead of trusted
from memory. Four of the blockers were decisions **already taken**.

⛔ **Publishing them would have been the more damaging error.** A false blocker
does not fail a check; it silently converts settled work into work that appears to
need a Governance Owner, and re-opens a decision the repository already made. The
genuine B5 blocker was then re-routed to **`PYK-GAP-002`** — dismissal/suppression
state has **no sited store**, an **ARB** matter — which reaches exactly **one** row
(`IMPL-1654`), not six.

### §8.10 What the checks do not prove

| Probe | Result |
|---|---|
| Acceptance criteria **proven** | ⛔ **0 of 242** |
| Lines of code written | ⛔ **0** |
| Tests written or run against the subjects | ⛔ **0** |
| ⛔ Frozen or accepted documents changed | **0** |
| ⛔ OPEN decisions closed | **0** |
| Repository check sweep | **31 scripts, 25 PASS / 6 FAIL — all six proven pre-existing at the Stage-4 tip `3f40525` via a detached worktree; 0 introduced** |

⭐ Coverage is **reported, not gated** (check 10). This section measures the
**plan**, not the product. A validated plan is still a plan.


---

## §9. OPEN items — carried, owner-routed, ⛔ none closed

The instruction is explicit: *"Do not close existing OPEN product/governance
decisions unless repository authority explicitly permits it."* No such permission
was found for any item below, so **none is closed**. Each is carried with the
owner the **subject itself** names, and the `IMPL-*` rows it reaches.

### §9.1 The six genuinely OPEN `XPB-CONF-*` items

Authority: `PRD-021B_B0_B9_STAGE3_ARCHITECTURE_ALIGNMENT.md` **§7.1** (L354–400),
a 17-item ledger with a per-row Disposition column.

| Item | Question | Owner named by the subject | Reaches | Status |
|---|---|---|---|---|
| **`XPB-CONF-011`** | Is the Help → Message flow wanted at all? | **Product Owner** (scope) **+ Architecture Owner** (a source event and edge would need an ADR) | `IMPL-1676` | ⛔ **OPEN** |
| **`XPB-CONF-013`** | `FIL-GAP-013` attachment-sharing confinement | **Product Owner** | `IMPL-1682` | ⛔ **OPEN** |
| **`XPB-CONF-014`** | Read receipts — which wave? | **Architecture + Product** | `IMPL-1671` | ⛔ **OPEN** |
| **`XPB-CONF-015`** | Configurable retention policy | **Architecture + Product** | `IMPL-1674`, `IMPL-1681` | ⛔ **OPEN** |
| **`XPB-CONF-016`** | Message deletion | **Product + Architecture** | `IMPL-1666`, `IMPL-1668` | ⛔ **OPEN** |
| **`XPB-CONF-017`** | Presence / typing wave | **Architecture + Product** | `IMPL-1679` | ⛔ **OPEN** |

⚠ **A ledger arithmetic discrepancy, disclosed rather than averaged.** §7.1 states
its totals as *"12 RESOLVED · 5 OPEN"*, but **six** rows are bolded OPEN
(`011`, `013`, `014`, `015`, `016`, `017`), and 12 + 6 = **18** against a 17-item
ledger. This document carries **all six** — under-carrying one would silently
schedule work behind an unadjudicated decision. ⛔ **The ledger is NOT edited**;
the discrepancy is raised as **`S6-I-6`** for the Stage 3 record's owner.

### §9.2 The `FOD-*` final open decisions

Authority: B0 **§8** (L294–345), read verbatim, including each row's own
*"Blocks later implementation?"* verdict.

| Item | Question | Owner | Blocks implementation? | Reaches |
|---|---|---|---|---|
| **`FOD-1`** | Do `Friendship`, `FriendRequest`, `BlockList`, `RateLimitCounter` form **one** `BC-11` aggregate? | **ARB** | ✅ **Yes** — *"Schema and concurrency tests cannot be written until fixed"* | **20** rows across G1/G2/G3/G5/G7 |
| **`FOD-2`** | May `BC-11` persist a `Mute` structure? | **ARB** | ⚠ **Partially — the `mute_list` structure ONLY** | `IMPL-1631` |
| **`FOD-3`** | Is `Block Users` V1 or V2? | **Architecture Owner** | ⛔ **No** | ⛔ blocks nothing |
| **`FOD-4`** | B4/B5/B7/B8/B9 consumer/owner | **Governance Owner** | ⛔ **No** — and **DISCHARGED** | ⛔ blocks nothing |

⭐⭐ **`FOD-2` was read narrowly because the subject *is* narrow.** B0 L307–317
says *"⚠ Partially — the `mute_list` structure **only**. `SSF-EC-016`/`SSF-AC-028`
specify a degraded ship mode: mute endpoints return *not implemented*; Block,
unblock, rate limiting, Safety Check and **all of B1 and B3** ship complete."*
So exactly **one** row carries `FOD-2` — not the whole of G2. Blocking the block
and rate-limit rows on it would have contradicted the subject in writing.

⛔ **`FOD-3` and `FOD-4` block nothing, and are recorded anyway.** An open item
that blocks no task is still an open item; dropping it because it is convenient
would make this section a list of obstacles rather than a record.

### §9.3 Carried-forward architectural opens

| Item | Substance | Owner | Reaches |
|---|---|---|---|
| **`PYK-GAP-002`** | Dismissal / suppression state has **no sited store** | **ARB** | `IMPL-1654` |
| **`PYK-GAP-003`** | ⛔ OPEN | ARB / Architecture | ⛔ blocks no row |
| **`GLS-GAP-002`** | `GLOBAL` scope OFF; viewers **fail closed** | Architecture | ⛔ blocks no row — the fail-closed behaviour is specified and buildable |
| **`XPB-DRIFT-001`** | DISCLOSED, not resolved | Architecture | ⛔ blocks no row |
| **`XPB-DRIFT-002`** | DISCLOSED, not resolved | Architecture | ⛔ blocks no row |
| **`MSG-GAP-002`** | `PRD-021` is still `PLANNED` in `PRD_REGISTRY.md` §4.2 **L321** | **Governance Owner** | ⛔ blocks no row |
| **`S5-F-1`** | The `XPB-` stem has **no named owner** | **Governance Owner** | ⛔ blocks no row |
| **`FOD-1`**…**`FOD-4`**, six `XPB-CONF-*` | §9.1–§9.2 | as named | as named |

⛔ **`PGA-08` is carried, not solved.** `PRD_LIFECYCLE.md` **L283**: *"Every PRD
needs a named owner. **None has one**."* This is why every `Owner/Role` cell in
§5 names a **role** and never a person — inventing an owner is one of the acts
the instruction expressly forbids.

### §9.4 Ledger

| Measure | Count |
|---|---|
| OPEN items carried | **17** |
| ⛔ OPEN items closed | **0** |
| ⛔ OPEN items invented | **0** |
| Items with a named owner | **17 of 17** |
| Items blocking ≥ 1 task | **9** |
| Items blocking no task, recorded anyway | **8** |
| ⛔ False blockers published | **0** — four were caught and removed (§8.9) |

---

## §10. Findings — including the ones against this document

`PRD_LIFECYCLE.md` **L104–106**: *"**A rejected finding must be recorded as
rejected, with its reason.** … A review that records only accepted findings is
indistinguishable from a review that found nothing."* Applied here, that means
the defects **this document** contained must be recorded, not quietly repaired.

### §10.1 `S6-F-1` — DISCHARGED by conferral

| Field | Value |
|---|---|
| Raised by | `PRD-021B_B0_B9_STAGE6_READINESS_AUDIT.md` (prior turn) |
| Substance | Stage 6 was not enterable, because the gate requires an `IMPL-*` range and the engagement forbade allocating one |
| Owner | **Implementation lead** (`PRD_LIFECYCLE.md` **L280**) |
| Disposition | ✅ **DISCHARGED** |
| How | ⭐ **By conferral, not by reinterpretation.** This engagement states *"`IMPL-*` allocation is now REQUIRED"* — the authority the prior turn lacked. The gate itself was **never** re-read to mean something else |

⭐ **The prior turn's refusal was correct and is not being reversed as an error.**
It reported `BLOCKED 0/2` because both conjuncts were genuinely unmet and neither
could lawfully be met. The block is cleared by a **new instruction**, which is the
only thing that could clear it. `ADR-0033` §7.1 **L169**: *"A conferral for one act
is not a standing licence"* — so this conferral covers Stage 6 and stops there.

### §10.2 ⛔ `S6-F-2` — the stale lifecycle allocation table, ROUTED not repaired

| Field | Value |
|---|---|
| Substance | `PRD_LIFECYCLE.md` **L147–153** declares `IMPL-227`+ *"Unallocated"* while **569** distinct numbers above 227 are occupied across **20** blocks |
| Class | **`GCP-15`** — *"a derived statement left behind by a change to the thing it describes"* |
| Owner | ⭐ **Governance Owner** (`PRD_LIFECYCLE.md` **L281**) |
| Disposition | ⛔ **OPEN — raised and routed. NOT repaired** |
| Why not repaired | `PRD_LIFECYCLE.md` is **lifecycle authority**. The instruction says *"Do NOT silently edit lifecycle authority"* and *"Do not change … lifecycle authority."* Stage 7 **L164** additionally requires *an ADR before* a change to any Rank 1–5 document. Editing it would have been convenient and out of scope |
| Consequence for this turn | ⭐⭐ **The table could not be used as the source of the next free range.** Following it would have allocated from `IMPL-227` — into ranges already held by Library Management, Student Identity, `PRD-020`, `PRD-021A` and others, breaking rule 1's *"never reuse or reassign a number"* on the first row. **The repository was measured instead** (§3) |
| Standing hazard | ⚠ Any future allocation reading L147–153 will collide. The next allocator must measure, not read |

⛔ **`PRD_LIFECYCLE.md` is byte-unchanged** — sha256 `5031fcc97a95980e…`, identical
to the value recorded before this turn.

### §10.3 `S6-I-3` — the census rule changes the answer

| Field | Value |
|---|---|
| Substance | Three plausible `IMPL-*` regexes give three different censuses: `\d{1,9}` → **804** distinct, min 1; `\d{2,4}` → **797**, min 13; `\d{3,4}` → **796**, min 14 |
| Resolution | ⭐ **All 8 divergent tokens were read at their lines.** Every one is a **regex or prose fragment**, not an identifier: `IMPL-1` is `IMPL-1[3-9][0-9]{2}'` (`PRD-012a` L98) · `IMPL-3` is `IMPL-3[0-9][0-9]` (`PRD-004` L40) · `IMPL-4` (`PRD-005` L71) · `IMPL-6` prose (`ADR-0034` L65) · `IMPL-7` = `IMPL-7xx` (`ADR-0049` L190) · `IMPL-8` = `IMPL-8xx` (`PRD-013` L67) · `IMPL-9` = `IMPL-9xx` (`DOCUMENTATION_BASELINE` L187) · `IMPL-13` = `IMPL-13xx` (`PRD-020` L72) |
| Rule adopted | `IMPL-(\d{3,4})` — **796** distinct, `IMPL-14`…`IMPL-1600` |
| Class | ⚠ **4th appearance** of the census-rule class in this programme, after `I5-1`, `I5-5`, `S6-I-1` |
| Disposition | ✅ Instrument finding, resolved. ⛔ No subject defect |

⭐ **A census is only as good as its published rule.** The three answers differ by
8 tokens, and the difference is entirely regex fragments printed inside prose. A
bare *"796 numbers are in use"* would have been unverifiable.

### §10.4 ⚠ `S6-I-4` — 18 rows were mis-stated `READY` (defect in THIS document)

| Field | Value |
|---|---|
| Substance | 18 of 90 rows were marked `READY` while their own `Dependency` cells named a `BLOCKED` predecessor. `READY` is defined as *"schedulable now"*, which they were not |
| Found by | A **mechanical transitive check** over the 106 dependency edges — ⛔ not by reading |
| Resolution | A fourth status, ⏳ `SEQUENCED` — *decided, not yet reachable* — applied **mechanically from the graph** |
| Why not `BLOCKED` | ⭐ Marking them `BLOCKED` would have **manufactured a governance blocker where no decision is missing** — the same error as §8.9's false blockers, in the opposite direction |
| Disposition | ✅ **Repaired and disclosed.** `READY` 41 · `SEQUENCED` 18 · `BLOCKED` 30 · `PARTIAL` 1 = 90 |

### §10.5 ⚠ `S6-I-5` — two dependency cycles (defect in THIS document)

| Field | Value |
|---|---|
| Substance | `IMPL-1602` ↔ `IMPL-1632` and `IMPL-1603` ↔ `IMPL-1664` formed cycles. Both G0 rows named their *consumers* as their *dependencies* |
| Found by | Depth-first colouring of the dependency graph — ⛔ invisible to inspection |
| Resolution | Arrows corrected: `IMPL-1602` and `IMPL-1603` now depend on `IMPL-1600` and are recorded as **inputs to** the rows that consume them |
| Disposition | ✅ **Repaired.** Graph re-verified **acyclic**, 106 edges, 0 cycles |

⭐ **A task plan containing a cycle cannot be scheduled at all** — every task in
the cycle waits for another. This is why the check is mechanical.

### §10.6 ⚠ `S6-I-6` — the Stage 3 ledger's own totals disagree

| Field | Value |
|---|---|
| Substance | Stage 3 §7.1 states *"12 RESOLVED · 5 OPEN"* but bolds **six** OPEN rows; 12 + 6 = 18 against a **17**-item ledger |
| Owner | The **Stage 3 record's owner** |
| Disposition | ⛔ **OPEN — raised. NOT repaired**, and ⛔ **not averaged away** |
| Action taken here | ⭐ **All six** bolded OPEN items are carried (§9.1). Carrying five would have scheduled a task behind an unadjudicated decision |

### §10.7 ⭐⭐ The false-blocker catch — recorded as a finding against my own draft

| Field | Value |
|---|---|
| Substance | ~15 rows across G4/G5/G6 were drafted `BLOCKED` on `XPB-CONF-002`, `XPB-CONF-003`, `XPB-CONF-005`; `FOD-4` was also treated as blocking |
| The authority | Stage 3 §7.1: `002` **RESOLVED** · `003` **REFUSED, final** · `004` **REFUSED, final** · `005` **DISCHARGED**; B0 L329–345: `FOD-4` **DISCHARGED** |
| Found by | ⭐ Arithmetic disagreement with the carried OPEN set (`011`, `013`–`017`), then **reading the ledger verbatim** rather than trusting memory |
| Resolution | All four removed; the genuine B5 blocker re-routed to **`PYK-GAP-002`**, reaching **1** row instead of 6 |
| Disposition | ✅ **Caught before publication.** 0 false blockers in the delivered document |

⛔ **Why this is the most consequential finding here.** A false blocker passes
every structural check. It does not fail a count or break a table. It silently
converts settled work into work that appears to need a Governance Owner, and
**re-opens a decision the repository already made** — the precise inverse of this
document's purpose.

### §10.8 Findings ledger

| ID | Class | Against | Disposition |
|---|---|---|---|
| `S6-F-1` | Gate enterability | Prior turn | ✅ **DISCHARGED** by conferral |
| `S6-F-2` | `GCP-15` stale authority | `PRD_LIFECYCLE.md` | ⛔ **OPEN** — routed to **Governance Owner**, not repaired |
| `S6-I-3` | Census rule | Instrument | ✅ Resolved, rule published |
| `S6-I-4` | Status honesty | ⚠ **This document** | ✅ Repaired mechanically |
| `S6-I-5` | Dependency cycles | ⚠ **This document** | ✅ Repaired, acyclic |
| `S6-I-6` | Ledger arithmetic | Stage 3 record | ⛔ **OPEN** — raised, not averaged |
| — | False blockers | ⚠ **This document's draft** | ✅ Caught pre-publication |

⭐ **Three of seven findings are against this document.** That is the point of
L104–106: a Stage 6 record that found nothing wrong with its own draft would be
indistinguishable from one that never checked.

---

## §11. ⛔ What this document does NOT do

| Act | Status | Authority that would be required |
|---|---|---|
| Enter Stage 7 | ⛔ **NOT ENTERED** | **Governance Owner** (**L281**); gate is a `DOCUMENTATION_BASELINE.md` §3 row at an assigned rank, which `PRD-021B` does not have |
| Claim freeze | ⛔ **NOT DONE** | **L161**: *"Freeze is **conferred, not claimed**"* |
| Implement code | ⛔ **NOT DONE** | **0** lines under `lib/`, `test/`, `web/`, `tool/` |
| Prove acceptance criteria | ⛔ **0 of 242** | Stage 8/9 |
| Edit `PRD_LIFECYCLE.md` to fix `S6-F-2` | ⛔ **REFUSED** | **Governance Owner**, plus an ADR first (**L164**) |
| Close any OPEN item | ⛔ **REFUSED — 0 closed** | the owner named per item in §9 |
| Change a `PRD-021B` requirement | ⛔ **0 changed** | subjects byte-unchanged, sha256 verified |
| Mint any identifier | ⛔ **0 minted** | — |
| Claim another module's reserve | ⛔ **REFUSED ×4** | **Governance Owner** |
| Name a person as owner | ⛔ **REFUSED** | `PGA-08` — no PRD has a named owner |
| Register in `TRACEABILITY_MATRIX.md` | ⛔ **NOT DONE** — see §11.1 | — |

### §11.1 Why nothing was written to `TRACEABILITY_MATRIX.md`

⭐ Measured, not assumed: **none** of the six Stage 6 precedents registers a row
in `TRACEABILITY_MATRIX.md`. Stage 6's artefact **is** the task document, and
Stage 5's registration is already complete at §2Q. Adding a §2R would register a
passage that did not happen — the `GCP-15` defect this document raises against
`PRD_LIFECYCLE.md` in §10.2, reproduced by my own hand. ⛔ **Byte-unchanged**,
sha256 `119d3ca6bdca09e3…`.

---

## §12. Verdict

| Conjunct | Requirement | Result |
|---|---|---|
| 1 | An `IMPL-*` range allocated | ✅ **MET** — `IMPL-1600`…`IMPL-1689`, 90 contiguous, derived mechanically, 0 reused |
| 2 | Every task traces back to requirements | ✅ **MET** — 90 of 90, **0** orphan, **0** dangling, **0** minted |
| Rule 1 | Next free range, never reuse | ✅ **MET** |
| Rule 2 | Leave room to grow contiguously | ✅ **MET** — `IMPL-1690`…`1749` reserved, 4 foreign reserves declined |
| Rule 3 | `Priority`, `Blocks`, `Blocked by` per task | ✅ **MET** — §6, all 90, derived from the graph |
| Rule 4 | Traceability table | ✅ **MET** — §7 |

# ✅ Stage 6 — Implementation Tasks: **PASS**

⛔ **Stage 7: NOT ENTERED · Freeze: NOT DONE · Code: NOT IMPLEMENTED.**

⚠ **This PASS is a PASS of Stage 6 only**, and Stage 6 allocates work. **0 of 242**
acceptance criteria are proven, **30** of 90 tasks are blocked on **9** items this
document has no authority to close, and no line of code exists. A plan that
validates is still a plan.

---

## §13. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-02 | **Stage 6 — Implementation Tasks for `PRD-021B` B0–B9, ✅ PASS on both gate conjuncts and all four allocation rules.** ⭐⭐ **Range `IMPL-1600`…`IMPL-1689` — 90 contiguous tasks, one row per number — derived by measuring the repository, NOT by reading `PRD_LIFECYCLE.md`'s allocation table, which is measurably stale (`S6-F-2`).** ⭐⭐ **`IMPL-1600` was read at its line rather than counted:** `PRD-021A_IMPLEMENTATION_TASKS.md` **L147** declares it *"Unallocated — measured empty"* and **L137** warns *"Counting it as an allocation would have pushed this range to `IMPL-1600` and left a 100-number hole"* — counting it would have started at `1700` and stranded **100** numbers, the third time this repository has set that trap (`PRD-007`'s `IMPL-500`, `PRD-021A`'s `IMPL-1500`). **Census published with its rule (`S6-I-3`): `IMPL-(\d{3,4})` → 796 distinct, `IMPL-14`…`1600`; all 8 tokens that appear only under looser regexes were read at their lines and are regex/prose fragments (`IMPL-8xx`, `IMPL-3[0-9][0-9]`, …), the 4th appearance of the census-rule class.** ⛔ **Four reserves declined — `1400`…`1449`, `1450`…`1499`, `1500`…`1569`, and PRD-021A's sibling growth reserve `1570`…`1599`** — consuming another module's declared reserve is a Governance Owner act; `1690`…`1749` declared as this module's own growth reserve and **not** allocated. **Gate conjunct 2 met at 90 of 90: 0 orphan tasks · 0 dangling citations · 0 duplicate IDs · 0 duplicate tasks · 0 minted identifiers · 0 wildcard citations (5 eliminated during authoring) · 0 disclosed absences cited as authority.** **Coverage published WITH denominators: 360 of 1,300 identifiers · 214 of 385 normative `FR`/`BR`/`INV` = 55.6% · 13 of 20 invariants · 97 of 242 ACs named (⛔ 0 proven)** — and the 7 uncarried invariants are **named** rather than rounded away, because Stage 5 measured the same subjects at 53.4% reverse coverage and recorded why (much of `PRD-021B` is prohibition; B5 reverse-traced at 18.2%; **a prohibition needs no task — authoring one would invert it**). ⚠⚠ **The denominator trap is carried as a live warning:** `375 ÷ 365` once produced *102.7%* in this programme, so every figure states its denominator. **Rule 3 satisfied by a dedicated register (§6) because the instruction's 8 mandated columns are a SUPERSET of rule 3's three, not a replacement** — satisfying only the instruction would have failed the gate's own rule 3, and satisfying only rule 3 would have failed the instruction; both are present for the same 90 IDs, with `Blocks` computed as the **mechanical inverse** of `Dependency` over 106 edges and `Priority` as a function of transitive fan-out. ⛔ **No `BLOCKED` row carries a priority** (30 of 30 carry a named governance item instead — check 9). ⭐⭐⭐ **FOUR FALSE BLOCKERS WERE CAUGHT AND REMOVED BEFORE PUBLICATION:** ~15 rows across G4/G5/G6 had been drafted `BLOCKED` on `XPB-CONF-002`/`003`/`005` and `FOD-4`, and reading the authoritative Stage 3 §7.1 ledger verbatim proved `002` **RESOLVED** (B5 V1-eligible, narrowed to `PYK-SRC-001`), `003`/`004` **REFUSED, final**, `005` **DISCHARGED**, and `FOD-4` **DISCHARGED by B0 itself** at L329–345 — publishing them would have silently converted settled work into work needing a Governance Owner and **re-opened decisions already taken**; the genuine B5 blocker was re-routed to **`PYK-GAP-002`** (unsited store, **ARB**), reaching **1** row instead of 6. ⭐ **`FOD-2` read narrowly because the subject is narrow** — B0 L307–317 gates *"the `mute_list` structure **only**"* with a degraded ship mode in `SSF-EC-016`/`SSF-AC-028`, so **1** row carries it, not all of G2. **`FOD-1` verified to reach exactly 20 rows across G1/G2/G3/G5/G7.** ⚠⚠ **THREE FINDINGS AGAINST THIS DOCUMENT'S OWN DRAFT, all caught mechanically and all disclosed:** **`S6-I-4`** 18 rows were mis-stated `READY` while depending on a `BLOCKED` predecessor — resolved with a fourth status ⏳ `SEQUENCED` (*decided, not yet reachable*) applied **from the graph**, because `READY` contradicts *"schedulable"* and `BLOCKED` would have invented a blocker where **no decision is missing**; **`S6-I-5`** two dependency **cycles** (`1602`↔`1632`, `1603`↔`1664`) where G0 rows named their consumers as dependencies — arrows corrected, graph re-verified **acyclic** by depth-first colouring, a defect invisible to inspection; **`S6-I-6`** the Stage 3 ledger's own totals disagree (*"12 RESOLVED · 5 OPEN"* against **6** bolded OPEN rows and a 17-item ledger) — ⛔ **not averaged away**, and **all six** carried, since carrying five would schedule a task behind an unadjudicated decision. **One citation defect caught by the gate check and repaired, not waived:** `IMPL-1604` cited `XPA-ACGAP-001`…`003` as its **authority**, which §2.2 forbids — now `TPA-FR-027` + `TPA-BR-042`, with the `ACGAP` items retained as **scope**. ⛔ **`S6-F-1` DISCHARGED BY CONFERRAL, NOT BY REINTERPRETATION** — the prior turn's `BLOCKED 0/2` was correct and is not reversed as an error; only a new instruction could clear it, and `ADR-0033` §7.1 **L169** (*"a conferral for one act is not a standing licence"*) confines it to Stage 6. ⛔⛔ **`S6-F-2` RAISED AND ROUTED TO THE GOVERNANCE OWNER, NOT REPAIRED** — `PRD_LIFECYCLE.md` **L147–153** declares `IMPL-227`+ *"Unallocated"* while **569** numbers above 227 are occupied across **20** blocks, a `GCP-15` defect; **following that table would have allocated from `IMPL-227` into ranges already held and broken rule 1 on the first row**, so the repository was measured instead, and the stale table is flagged as a standing hazard for the next allocator. **17 OPEN items carried, 0 closed, 0 invented, 17 of 17 with a named owner** (9 blocking ≥1 task, **8 blocking none and recorded anyway**). ⛔ **`PGA-08` honoured — no person is named anywhere; `Owner/Role` carries roles only.** ⛔ **Byte-unchanged: all ten B0–B9 subjects (sha256 re-verified), `PRD_LIFECYCLE.md` (`5031fcc97a95980e…`), `DOCUMENTATION_BASELINE.md`, `LIBOORA_BOUNDED_CONTEXT_MAP.md`, FROZEN `PRD-020`, FROZEN `PRD-017`, `TRACEABILITY_MATRIX.md` (`119d3ca6bdca09e3…`), `PRD_REGISTRY.md`, `MASTER_PRD.md`, `ARCHITECTURE_RULINGS.md`, all ADRs, and `tool/docs_check/prd021a_task_coverage.py`.** ⚠ **`TRACEABILITY_MATRIX.md` deliberately NOT extended** — measured against all six Stage 6 precedents, **none** registers a row there; Stage 6's artefact is the task document, and adding a §2R would register a passage that did not happen. **Repository sweep: 31 scripts, 25 PASS / 6 FAIL, 0 introduced** — all six proven pre-existing at the Stage-4 tip `3f40525` via a detached worktree. ⛔ **Stage 7 NOT ENTERED · freeze NOT DONE · code NOT IMPLEMENTED · 0 of 242 acceptance criteria proven** — §11 refuses **11** acts explicitly and names the authority each would require. |
