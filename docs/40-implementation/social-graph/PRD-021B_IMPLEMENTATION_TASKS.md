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
| ⛔ `BLOCKED` | An OPEN item must be adjudicated first. **Carries a blocker, not a schedulable priority** (§6) |
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
| `IMPL-1602` | Implement the privacy/safety precedence order as a single shared resolver, so no part can apply the stages out of order | `XPA-PREC-001`…`007`, `TPA-INV-005` | ⛔ none — consumed by B3/B4/B5 | `IMPL-1632`, `IMPL-1643` | Ranking cannot precede safety: `TPA-AC-014` holds, and `DRK-AC-001` shows B4's output is a permutation of its input | Implementation lead | `READY` |
| `IMPL-1603` | Implement the library/global boundary rule so a global-identity structure can never carry a tenant or student-record key | `XPA-BND-001`…`006`, `GLS-INV-002`, `TPA-INV-003` | `BC-11`, `BC-12` (structure shape only) | `IMPL-1605`, `IMPL-1664` | Field enumeration over every `BC-11`/`BC-12` structure yields **no** `StudentRecordId`, `TenantId` or profile field, per `SGR-AC-029` | Implementation lead | `READY` |
| `IMPL-1604` | Stand up the acceptance-criteria coverage harness for all 242 B0–B9 criteria, reporting coverage without gating on it | `TPA-FR-027`, `TPA-BR-042` | ⛔ none | `IMPL-1689` | The harness enumerates 242 criteria and reports per-part coverage; ⛔ it does **not** assert any criterion passes. ⚠ `XPA-ACGAP-001`…`003` are **disclosed absences**, carried here as scope, never as the authority | Implementation lead | ⚠ `PARTIAL` — `XPA-ACGAP-002` gates the four Mute criteria |

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
| `IMPL-1645` | Implement the `DISC-RANK-1` weighted-sum scoring model over the three active signals | `DRK-FR-005`, `DRK-SIG-001`, `DRK-SIG-002`, `DRK-SIG-004`, `DRK-BR-004` | **`BC-23`** ▶ relevance; **`BC-11`** ▶ mutual count; **`BC-10`** ▶ completeness | `IMPL-1611`, `IMPL-1641` | Weights are `0.60`/`0.25`/`0.15`; `DRK-SIG-003` stays at `0.00` (constant in V1); the seven reserved signals remain unweighted. ⛔ `DRK-SIG-007` and `DRK-SIG-010` are **REFUSED, final** (`ADR-0091` §5.2) and are not built | Implementation lead | `READY` |
| `IMPL-1646` | Implement the non-query-surface path where no `BC-23` relevance is available | `DRK-FR-006`, `DRK-FR-009` | read composition | `IMPL-1645` | On a non-query surface the ordering is produced without a relevance term; `DRK-AC-009` preserves band order on query surfaces | Implementation lead | `READY` |
| `IMPL-1647` | Implement full determinism: stable tie-break, no wall clock, explicit version, no learned parameter | `DRK-DET-001`…`006`, `DRK-FR-011` | read composition | `IMPL-1645` | `DRK-AC-002`: two runs on identical input and configuration version are byte-identical; `DRK-AC-004`: equal scores order by `PersonId` ascending | Implementation lead | `READY` |
| `IMPL-1648` | Implement in-band diversity re-ordering and the fallback renormalisation | `DRK-FR-007`, `DRK-FR-008`, `DRK-FR-010`, `DRK-FR-012`, `DRK-FR-014`, `DRK-EC-005` | read composition | `IMPL-1647` | `DRK-AC-009`: re-ordering occurs only within a band; `DRK-AC-010`: remaining active weights renormalise to `1.00` and a result is still returned. ⛔ Per-viewer frequency capping (`DRK-FR-013`) is **not built** | Implementation lead | `READY` |
| `IMPL-1649` | Implement per-candidate explainability records routed to `BC-24` via `E-20`, never exposed to a peer | `DRK-EXP-001`…`006` | **`BC-24`** ▶ via `E-20` — ⛔ not owned | `IMPL-1685` | A per-candidate record carries the configuration version and records degradations; ⛔ it is never exposed to a peer and holds no profile or message content | Implementation lead | `READY` |
| `IMPL-1650` | Implement offline replay evaluation and pre-activation configuration evaluation | `DRK-EVAL-001`…`005`, `DRK-CFG-001`…`008` | **`BC-25`** ▶ config via `E-19`; **`BC-26`** ▶ metrics — ⛔ neither owned | `IMPL-1647` | Recorded inputs replay to an identical ordering; a configuration change is evaluable before activation. ⛔ No online experiment or A/B split is built (`DRK-EVAL-004`), and no viewer behavioural data is used (`DRK-EVAL-002`) | Implementation lead | `READY` |

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
| `IMPL-1656` | Implement the presentation surface: allow-listed fields, optional mutual count, opaque cursors, no score exposed | `PYK-PRS-001`…`007` | **`BC-10`** ▶ allow-listed fields only | `IMPL-1611`, `IMPL-1652` | Only allow-listed `BC-10` fields appear; ⛔ no browsable mutual-friend list, ⛔ no score, rank position or weight is exposed; pagination uses opaque cursors | Implementation lead | `READY` |

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
| `IMPL-1669` | Implement client-supplied idempotency keys with the declared retention | `MSG-FR-011`, `MSG-FR-012`, `TPA-FR-011` | **`BC-12`** | `IMPL-1667` | A replayed key produces one message; keys are retained for at least the declared minimum | Implementation lead | `READY` |
| `IMPL-1670` | Implement server-assigned per-conversation sequencing and opaque cursor pagination | `MSG-FR-013`, `MSG-FR-014`, `MSG-FR-015`, `TPA-FR-013` | **`BC-12`** | `IMPL-1666` | Sequence is server-assigned and monotonic per conversation; ⛔ **no cross-conversation ordering is provided**; pagination is opaque-cursor only | Implementation lead | `READY` |
| `IMPL-1671` | Implement per-participant read cursors and derived unread counts, undisclosed in V1 | `MSG-FR-016`, `MSG-FR-017`, `MSG-FR-018` | **`BC-12`** | `IMPL-1670` | The unread count is **derived**, not stored; ⛔ in V1 a read cursor is **not disclosed** to the other participant | Architecture + Product (`XPB-CONF-014`), then Implementation lead | ⛔ `BLOCKED` — `XPB-CONF-014` (read-receipt wave) |
| `IMPL-1672` | Implement per-participant archive with un-archive on new message, and per-participant mute | `MSG-FR-020`, `MSG-FR-021`, `MSG-FR-022` | **`BC-12`** — ⚠ distinct from B2's `Mute` on `BC-11` | `IMPL-1664` | Archive is per-participant view state; a new message un-archives; mute suppresses only for the muting participant | Implementation lead | `READY` |
| `IMPL-1673` | Constrain context references to an opaque closed enum, and route consent/audit facts to `BC-22` | `MSG-FR-023`, `MSG-FR-024`, `MSG-FR-025` | **`BC-12`**; **`BC-22`** ▶ — ⛔ `BC-22` not owned | `IMPL-1664` | The `type` enum is closed and V1-constrained; the reference stays **opaque**; ⚠ only `E-16` inbound and `E-22` outbound exist for `BC-12` | Implementation lead | `READY` |
| `IMPL-1674` | Implement `RetentionPolicy` as a `Conversation` entity, with purge removing bodies and `FileRef`s | `MSG-FR-026`, `MSG-FR-027`, `MSG-FR-028`, `TPA-FR-025` | **`BC-12`** | `IMPL-1664` | Purge removes message bodies and `FileRef`s; ⚠ in V1 the policy is a **fixed platform value** — the *configurable* policy value is undecided | Architecture + Product (`XPB-CONF-015`), then Implementation lead | ⛔ `BLOCKED` — `XPB-CONF-015` (configurable retention) |
| `IMPL-1675` | Implement the four hand-offs — realtime, notification, media, safety — on pre-existing edges only | `MSG-FR-029`, `MSG-FR-030`, `MSG-FR-031` | **`BC-12`** → `BC-30`/`BC-22`/`BC-29`/`BC-13` via `E-22`, `E-23` | `IMPL-1677`, `IMPL-1679`, `IMPL-1683` | Each hand-off uses a **pre-existing** edge; ⛔ **0 edges are created**; attachments are held as `BC-29` `FileRef`s | Implementation lead | `READY` |
| `IMPL-1676` | ⛔ Do **not** author the Help → Message flow; preserve B7's six-step refusal | `MSG-FR-024`, `MSG-FR-025` | **`BC-12`** ▶ community — ⛔ the source event is **WITHDRAWN** | ⛔⛔ **`XPB-CONF-011`** | ⛔ **Nothing is built.** `community.HelpRequestAnswered` (`LCN-EVT-007`) is **WITHDRAWN** by `ADR-0083` **L237** and `LCN-FR-019` is **VOID**; the number cannot return. Done condition is that the flow remains **unauthored** | Product + Architecture (`XPB-CONF-011`) | ⛔ `BLOCKED` — `XPB-CONF-011` |

### §5.9 G8 — B8 realtime, media & messaging safety (`IMPL-1677`…`IMPL-1684`)

⛔ **B8 owns nothing.** Realtime is a **port** (`platform/services:realtime`,
manifest **L243**), media is `BC-29`'s, offline is `BC-30`'s, and messaging safety
was already decided by `ADR-0065` Option B. ⚠ **`XPB-CONF-017`** (presence/typing
wave) and **`XPB-CONF-013`** (`FIL-GAP-013` confinement) land here.

| IMPL-ID | Task | Requirement ID(s) | BC/Context | Dependency | Acceptance/Done Condition | Owner/Role | Status |
|---|---|---|---|---|---|---|---|
| `IMPL-1677` | Implement the realtime hand-off and post-reconnect reconciliation | `RTM-FR-001`, `RTM-FR-002`, `TPA-FR-008` | **`BC-30`** / realtime **port** — ⛔ not a context, not owned | `IMPL-1670` | An accepted `Message` is handed to the realtime port; a client reconciles after reconnect by reading, not by replay | Implementation lead | `READY` |
| `IMPL-1678` | Implement subscription authorisation and connection lifecycle, with no tenant key in any frame | `RTM-FR-003`, `RTM-FR-004`, `RTM-FR-005`, `TPA-INV-003`, `TPA-FR-017` | realtime **port**; **`BC-12`** state | `IMPL-1603`, `IMPL-1667` | Subscription authorisation is evaluated server-side per subscription; ⛔ **no frame carries a `tenantId`** | Implementation lead | `READY` |
| `IMPL-1679` | Implement presence and typing as `BC-12` state, undisclosed in V1 | `RTM-FR-006`, `RTM-FR-007` | **`BC-12`** — ⚠ *"un-dated by authority"* | ⛔ **`XPB-CONF-017`** | ⛔ In V1 presence is **not disclosed to any other person**. ⚠ EA **L1854**/**L1855** date presence/typing V2/V3 while B8 needs them; `RTM-GAP-001` is the open record | Architecture + Product (`XPB-CONF-017`) | ⛔ `BLOCKED` — `XPB-CONF-017` |
| `IMPL-1680` | Hold attachments as `BC-29` `FileRef`s, uploading against `BC-29` and never proxying bytes | `RTM-FR-008`, `RTM-FR-009`, `RTM-FR-013`, `TPA-FR-016` | **`BC-29`** ▶ via `E-22` — ⛔ not owned | `IMPL-1675` | Upload targets `BC-29`; ⛔ `BC-12` never stores or proxies media bytes; media in messaging is **V1** per `RTM-FR-013` | Implementation lead | `READY` |
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
