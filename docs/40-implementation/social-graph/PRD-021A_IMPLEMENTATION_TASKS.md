# `PRD-021A` Implementation Tasks — `IMPL-1500` … `IMPL-1569`

| Field | Value |
|---|---|
| **Module** | `domain/social` — Bounded Context **`BC-15`** Community & Groups, `[SUPPORTING]`, scope band **V2** |
| **Source PRD** | `PRD-021A` Library Community & Community Feed, **Parts A1–A8**, eight documents in [`../../30-product/social-graph/`](../../30-product/social-graph/) |
| **Aggregates** | `CommunityPost` (`BC-15`, A2 `LCF-FR-016`) and the group/role aggregates A4 specifies. ⛔ **This document creates none of them and names no new one** |
| **Range allocated** | **`IMPL-1500` … `IMPL-1569`** — **70** tasks, contiguous · **`IMPL-1570`…`1599`** declared growth reserve, reserved and **not** allocated |
| **Subjects (byte-unchanged by this document)** | A1 `4c6e0652f4ceb9ff` · A2 `1aca384098a72574` · A3 `fd1a4ca0653f6a04` · A4 `95af7e30a58cbc37` · A5 `44713670aa112e5a` · A6 `b5e16450476fd3e5` · A7 `01097dc13691bbfc` · A8 `cf5670ad89c039e5` — **11,617 lines / 739,840 bytes** |
| **Identifiers available to cite** | **1,982** across **105** registers, as registered at [`../TRACEABILITY_MATRIX.md`](../TRACEABILITY_MATRIX.md) **v1.21 §2P** |
| **Obligations claimed** | Computed by [`../../../tool/docs_check/prd021a_task_coverage.py`](../../../tool/docs_check/prd021a_task_coverage.py), **not asserted**. See §5 |
| **Acceptance criteria proven** | ⛔ **0 of 233.** Stage 6 allocates work; it does not perform it. Proof is Stage 8/9 |
| **Stage** | **6 of 9.** ⛔ **Stage 7 is not entered. Stage 8 is not started. No code is written by this document** |
| **Status of this document** | **Unranked.** Not admitted to `DOCUMENTATION_BASELINE.md` |
| **Authority** | **Implementation lead** (`PRD_LIFECYCLE.md` **L279**), conferred by the human principal for this act only — `ADR-0033` **L169**: *"A conferral for one act is not a standing licence"* |
| **Version** | v1.0 · 2026-09-01 |

---

## 1. What this document is, and the one thing it is not

`PRD_LIFECYCLE.md` **L135** states the Stage 6 gate in one sentence:

> *"an `IMPL-*` range allocated and a task document in which **every task traces back to requirements**."*

This document allocates seventy numbers and states, for each, what requirement
it must satisfy. It contains **no** Dart source, schema, SQL, DDL, migration,
storage-engine choice, index definition, estimate or sprint assignment.

⛔ **It is not an implementation.** Stage 8 is *"Implementation"* and it is a
separate stage with a separate gate (**L182–200**). The instruction authorising
this pass asked for *"code/tests as required"* — and the measured answer is that
**Stage 6 requires none**, for a reason recorded at §2.4 rather than assumed:
writing `BC-15` production code today would implement requirements whose
architecture edge was only conferred on 2026-08-31 and whose scope allocation is
**still an open Product Owner decision** (`LCG-GAP-001`). Allocating the work is
lawful; performing it is not yet.

⛔ **It closes nothing.** It does not close `LCG-GAP-001`, does not move
`PRD-021A` out of `PLANNED`, does not confer `READY`, and mints no identifier of
any kind. §7 states each refusal beside the owner who could lawfully perform it.

---

## 2. Stage 6 prerequisites — verified mechanically, not assumed

Stage 6 sits behind five gates. **Every one was measured for this pass**, and one
of them was found to have been superseded twice, which is why the table cites
three Stage-3 records rather than one.

| Prerequisite | Required by | State |
|---|---|---|
| **Stage 2** draft on disk, versioned header, registers declared | **L79–86** | ✅ **8 documents, 105 registers**, ranges published in §2P.0 of the matrix |
| **Stage 3** architecture alignment recorded, every conflict and disposition named | **L88–104** | ✅ **CONFERRED across A1–A8** — see §2.1. ⚠ Three records, the third superseding the first two on check 2 |
| **Stage 4** conflicts closed **or explicitly deferred with a reason and an owner** | **L108–119** | ✅ [`../../30-product/social-graph/PRD-021A_STAGE4_CONFERRAL_2026-09-01.md`](../../30-product/social-graph/PRD-021A_STAGE4_CONFERRAL_2026-09-01.md) — **PASS 6/6 + the L119 gate, zero failures across A1–A8** |
| **Stage 5** prefixes registered with counts and ranges, verified mechanically, zero collisions | **L121–133** | ✅ [`../TRACEABILITY_MATRIX.md`](../TRACEABILITY_MATRIX.md) **v1.21 §2P** · conferred at [`../../30-product/social-graph/PRD-021A_STAGE5_CONFERRAL_2026-09-01.md`](../../30-product/social-graph/PRD-021A_STAGE5_CONFERRAL_2026-09-01.md) · two instruments, both exit 0, one mutation-tested 4/4 |
| **Stage 6** an `IMPL-*` range allocated | **L135** | ✅ **This document.** Range established by measurement — §3 |

### 2.1 ⚠ The Stage-3 prerequisite required reading three records, not one

The obvious file, `PRD-021A_STAGE3_ARCHITECTURE_ALIGNMENT.md`, reads at its
**L10**: *"⛔ **FAIL — 5 of 6 mandated checks pass; Check 2 FAILS**"*. Had this
pass stopped there, Stage 6 would have been reported blocked.

It is superseded twice, and both successors were opened:

| Record | Determination |
|---|---|
| `PRD-021A_STAGE3_ARCHITECTURE_ALIGNMENT.md` (453 L) | ⛔ **FAIL** on check 2 — written when A4–A8 were believed not to exist |
| `PRD-021A_STAGE3_ALIGNMENT_2026-08-31.md` (529 L) | ⛔ **A4 and A6 NOT CONFERRED**; the other six cleared 6/6. *"A multi-part PRD is not cleared by majority"* |
| `PRD-021A_STAGE3_ALIGNMENT_A4_A6_RESOLUTION_2026-08-31.md` | ✅ **Stage 3 CONFERRED on A4 and A6 · `PRD-021A` is Stage-3 complete across A1–A8**, on `ACCEPTED` [`../../00-governance/adr/ADR-0084-bc15-outbound-carriers-measured-option-b-selected.md`](../../00-governance/adr/ADR-0084-bc15-outbound-carriers-measured-option-b-selected.md) Option B |

⭐ **The third record's own account of why the first two failed is worth quoting,
because it is the reason this pass trusts it:** *"That ground was produced by a
defect in my own measuring instrument, not by a defect in A4 or A6."* It amends
**only** the check-2 cells for A4 and A6, modifies **zero** Rank 1–5 documents,
and leaves the two superseded records byte-unchanged beside it.

**Stage 6 is therefore genuinely reachable.** Registered is not verified, and the
Stage 5 conferral says so in its own §5: *"not Stage 6, not rank, not freeze."*
This document supplies the Stage 6 act that conferral explicitly withheld.

### 2.2 ⛔ What the prerequisites do **not** establish

| Not established | Consequence for this document |
|---|---|
| That A4's scope exists | `LCG-GAP-001` — *"No document allocates scope to Part A4 … blocks everything"* — is **OPEN**. A4's tasks are allocated **`BLOCKED`**, not schedulable. §4.4 |
| That `communityId` can be resolved | `LCG-GAP-006` — *"no published contract mints or resolves `communityId` … blocks group creation"* — is **OPEN**. `LCG-INV-007` requires rejection until it closes |
| That A7's event set is settled | `LCT-CONF-001` is **RAISED, NOT RESOLVED**. A7 tasks cite only the **3 ACTIVE** events; the 4 withdrawn are never implemented |
| That the module may ship | `PRD-021A` is **`PLANNED`**, **Unranked**, **NOT FROZEN** (`DOCUMENTATION_BASELINE.md` **L139**) |
| That 233 criteria are enough for 757 requirements | Coverage is **27.2%**. §5 reports it and refuses to improve it by minting |

### 2.3 ⛔ Four things this document refused to do to make itself look complete

1. **Allocate a task per requirement** — 757 tasks would exhaust `IMPL-1500`…`2256`, cross into unallocated bands, and claim work no owner has scoped.
2. **Cite an acceptance criterion that does not exist** so that a task looked provable. All 233 are real; the other 551 requirements have none, and §5 says so.
3. **Treat A4's open scope as a detail.** A4 gets tasks, and every one of them is marked `BLOCKED` by `LCG-GAP-001` rather than given a priority it cannot have.
4. **Write production code** to satisfy the word *"code"* in the instruction. §2.4.

### 2.4 ⭐ Why no code is written, stated as a rule rather than a preference

`PRD_LIFECYCLE.md` separates **Stage 6 — Implementation Tasks** (**L135**) from
**Stage 8 — Implementation** (**L182**). Stage 8 is governed by
`DEFINITION_OF_DONE.md` v1.2 and the six pipeline gates, and its rule is:

> *"a requirement that cannot be implemented as written is a **specification
> defect** — raise an amendment, never silently reinterpret it."*

Three of A1–A8's requirements cannot be implemented as written **today**:
`LCG-FR-*` group creation is blocked by `LCG-GAP-006`; A4's entire scope is a
candidate under `LCG-GAP-001`; A7's event surface is under an unresolved
conflict. Writing code against them would be the silent reinterpretation the rule
forbids. **The single precedent in this repository agrees:** `PRD-020`'s
`IMPL-1410` code exists, and it exists under an `Accepted` **`ADR-0065`** that
authorised that one build — not under its Stage 6 document, which states *"It is
not an implementation, and it is not a design."*

⛔ **No `lib/` or `test/` file is created, modified or deleted by this pass**, and
`git status --short lib/ test/` returns **0 lines**. That is a measurement in §8.

---

## 3. `IMPL-*` allocation

### 3.1 Why `IMPL-1500` — computed by three independent routes

Allocation **rule 1**: *"Take the next free range. **Never reuse or reassign a
number**."* **Rule 2**: *"Leave the previous group room to grow contiguously."*

1. **Declared upstream.** [`../trust-safety/PRD-020_IMPLEMENTATION_TASKS.md`](../trust-safety/PRD-020_IMPLEMENTATION_TASKS.md) **L79** reads `| IMPL-1500 + | Unallocated — measured empty | — |`.
2. **Declared by the governance record.** `ADR-0082` **L101**, **L347** and **L454**, `PRD-021A_STAGE7_BLOCKER.md` **L94** and **L339**, and `PRD-021A_LCF-GAP-012_DECISION_RECORD.md` **L818** all independently state the next free block is **`IMPL-1500`+**.
3. **Measured.** `grep -rho 'IMPL-15[0-9][0-9]'` over `docs/ lib/ tool/ test/` returns exactly **one** distinct token, `IMPL-1500`, and every occurrence of it is a *declaration that the number is free*, not a use of it. The `IMPL-16xx` band returns **zero** tokens.

⭐ **The single `IMPL-1500` occurrence was read at its line rather than counted**,
on the `PRD-007` precedent, whose own §3.1 records the identical hazard: *"The
single `IMPL-500` occurrence is a declaration that the number is free, not a use
of it."* Counting it as an allocation would have pushed this range to `IMPL-1600`
and left a 100-number hole.

### 3.2 Rule 2 — the reserve left behind, and the one taken

| Band | Disposition |
|---|---|
| `IMPL-1450`…`1499` | ⛔ **NOT TOUCHED.** `PRD-020` **L2434** reserves it *"for the V2 community work of §25"*. ⚠ **It is tempting to read that as this module's** — §3.3 |
| `IMPL-1500`…`1569` | ✅ **Allocated here** — 70 tasks, contiguous, every member carrying exactly one row |
| `IMPL-1570`…`1599` | ✅ **Growth reserve**, declared and not allocated. `PRD-020` has none, and its own §3.4 calls that *"a disclosed defect, not an oversight"*; this document does not repeat it |
| `IMPL-1600`+ | Unallocated — measured empty |

### 3.3 ⚠ The trap in `IMPL-1450`…`1499`, declined

`PRD-020` **L2434** reserves that band for *"the V2 community work of §25"*, and
`PRD-021A` **is** V2 community work. Taking it would have looked economical.

**It is declined for two reasons, both measurable.** First, the reserve belongs to
`PRD-020` — the reserving document owns it, and consuming another module's
declared reserve is a range-allocation act belonging to the **Governance Owner**.
Second, `PRD-020`'s own Stage 5 conferral records `IMPL-1450` as defect **`I-2`**:
flagged as a phantom by a `max+1` probe, inspected at its line, and *"**Rejected
as a finding** … Had it been 'fixed', a lawful growth reserve would have been
deleted."* A band that was protected from deletion is not available for
appropriation.

### 3.4 Task-count derivation

Seventy is not a round number chosen for looks. It is **eight part budgets**, each
sized to the part's register weight and each capped at what a task row can
honestly claim:

| Part | Requirements (FR+BR) | AC | Tasks | Band |
|---|---|---|---|---|
| **A1** Foundation | 84 | 60 | **12** | `IMPL-1500`…`1511` |
| **A2** Feed & content | 123 | 36 | **12** | `IMPL-1512`…`1523` |
| **A3** Ranking | 116 | 22 | **8** | `IMPL-1524`…`1531` |
| **A4** Groups & roles | 28 | 18 | **6** | `IMPL-1532`…`1537` — ⛔ all `BLOCKED` |
| **A5** Official comms | 133 | 21 | **10** | `IMPL-1538`…`1547` |
| **A6** Safety & moderation | 78 | 20 | **7** | `IMPL-1548`…`1554` |
| **A7** Notifications | 76 | 21 | **5** | `IMPL-1555`…`1559` |
| **A8** Technical architecture | 119 | 35 | **8** | `IMPL-1560`…`1567` |
| **Cross-part** | — | — | **2** | `IMPL-1568`…`1569` |
| **TOTAL** | **757** | **233** | **70** | `IMPL-1500`…`1569` |

---

## 4. The seventy tasks

**Rule 3** requires `Priority`, `Blocks` and `Blocked by` on every row. **Rule 4**
requires every task to trace to requirements. Both are enforced by
`prd021a_task_coverage.py`, not by inspection.

`P` = priority (`P1` highest). `—` in `Blocks`/`Blocked by` means *none*, stated
explicitly rather than left blank.

### 4.1 A1 — Foundation and membership (`IMPL-1500`…`IMPL-1511`)

| Task | Work | Traces to | P | Blocks | Blocked by |
|---|---|---|---|---|---|
| `IMPL-1500` | Community participation read model over the existing `MembershipValidity` projection | `LCM-FR-052`, `LCM-FR-053`, `LCM-RM-001` | P1 | `IMPL-1501`, `IMPL-1512` | — |
| `IMPL-1501` | Participation answer endpoint, tenant-private and authenticated | `LCM-FR-052`, `LCM-API-001`, `LCM-AUTH-001` | P1 | `IMPL-1513` | `IMPL-1500` |
| `IMPL-1502` | Three-day protected renewal window as mandatory V1 behaviour | `LCM-FR-054`, `LCM-INV-001` | P1 | — | `IMPL-1500` |
| `IMPL-1503` | Exclusion derived from `safety.EnforcementActionTaken` | `LCM-FR-055` | P1 | `IMPL-1548` | `IMPL-1500` |
| `IMPL-1504` | Exclusion derived from `tenancy.TenantSuspended` | `LCM-FR-056` | P1 | — | `IMPL-1500` |
| `IMPL-1505` | `ID-6` minor-consent gate, extended to `Unknown` minor status | `LCM-FR-057`, `LCM-SEC-001` | P1 | — | `IMPL-1500` |
| `IMPL-1506` | Per-library enablement gate, default Disabled, reusing `LCFG-5` | `LCM-FR-058`, `LCM-CFG-001` | P1 | `IMPL-1512` | — |
| `IMPL-1507` | The fourteen observability signals | `LCM-FR-059`, `LCM-OBS-001` | P2 | — | `IMPL-1500` |
| `IMPL-1508` | Bounded, tenant-scoped member listing subject to the gate | `LCM-FR-060` | P2 | — | `IMPL-1506` |
| `IMPL-1509` | Object-level authorization checks across the A1 surface | `LCM-AUTH-001`, `LCM-SEC-001`, `LCM-XC-001` | P1 | — | `IMPL-1501` |
| `IMPL-1510` | Signalling prohibitions — A1 publishes no event of its own | `LCM-SIG-001`, `LCM-INV-005` | P1 | — | — |
| `IMPL-1511` | A1 acceptance harness — the 60 `LCM-AC-*` criteria made executable | `LCM-AC-001`, `LCM-AC-010`, `LCM-CHK-001`, `LCM-GWT-001` | P2 | — | `IMPL-1500`…`IMPL-1510` |

### 4.2 A2 — Feed and content (`IMPL-1512`…`IMPL-1523`)

| Task | Work | Traces to | P | Blocks | Blocked by |
|---|---|---|---|---|---|
| `IMPL-1512` | `CommunityPost` aggregate, owned by `BC-15` and by no other context | `LCF-FR-007`, `LCF-FR-016` | P1 | `IMPL-1513`…`IMPL-1519` | `IMPL-1500`, `IMPL-1506` |
| `IMPL-1513` | Durable, ordered, library-private content surface | `LCF-FR-006`, `LCF-INV-001` | P1 | `IMPL-1514`, `IMPL-1524` | `IMPL-1512` |
| `IMPL-1514` | Deterministic default ordering, ranking delegated entirely to A3 | `LCF-FR-011` | P1 | `IMPL-1524` | `IMPL-1513` |
| `IMPL-1515` | The narrow study-library content types | `LCF-FR-008` | P2 | — | `IMPL-1512` |
| `IMPL-1516` | Attachments as opaque `SharedContentRef` — no bytes, no new storage consumer | `LCF-FR-009`, `LCF-FR-018` | P2 | — | `IMPL-1512` |
| `IMPL-1517` | Deterministic resumable retrieval, presupposing no pagination convention | `LCF-FR-010`, `LCF-API-001` | P2 | — | `IMPL-1513` |
| `IMPL-1518` | Server-side scope enforcement, no cross-library leakage | `LCF-FR-014`, `LCF-SEC-001` | P1 | — | `IMPL-1512` |
| `IMPL-1519` | Post read model | `LCF-RM-001` | P2 | — | `IMPL-1512` |
| `IMPL-1520` | The six-event contract, emitted exactly as specified | `LCF-EVT-001`, `LCF-EVT-006`, `LCF-FR-104` | P1 | `IMPL-1555` | `IMPL-1512` |
| `IMPL-1521` | Moderation integration with `BC-13`, defining no moderation policy locally | `LCF-FR-012` | P1 | `IMPL-1548` | `IMPL-1512` |
| `IMPL-1522` | Membership and grace-window behaviour inherited from A1, redefined nowhere | `LCF-FR-013` | P1 | — | `IMPL-1502` |
| `IMPL-1523` | A2 acceptance harness — the 36 `LCF-AC-*` criteria | `LCF-AC-001`, `LCF-AC-012` | P2 | — | `IMPL-1512`…`IMPL-1522` |

### 4.3 A3 — Feed ranking, `RANK-1` (`IMPL-1524`…`IMPL-1531`)

⚠ **A3 is a V2 capability by its own `LCR-FR-012`** — *"It ships no earlier than
the capability it orders."* Every task here is therefore blocked on A2's surface.

| Task | Work | Traces to | P | Blocks | Blocked by |
|---|---|---|---|---|---|
| `IMPL-1524` | `RANK-1` pipeline in exactly the specified step order | `LCR-FR-013`, `LCR-FR-014`, `LCR-FR-015` | P2 | `IMPL-1525`…`IMPL-1530` | `IMPL-1513`, `IMPL-1514` |
| `IMPL-1525` | Ordering only — A3 admits, authorises and widens nothing | `LCR-FR-001`, `LCR-INV-001` | P2 | — | `IMPL-1524` |
| `IMPL-1526` | Determinism: identical inputs and configuration yield identical order | `LCR-FR-007` | P2 | — | `IMPL-1524` |
| `IMPL-1527` | Reproducibility from recorded inputs plus a version identifier | `LCR-FR-008` | P2 | — | `IMPL-1524` |
| `IMPL-1528` | Safe degradation — a ranking failure is never a feed failure | `LCR-FR-009` | P1 | — | `IMPL-1524` |
| `IMPL-1529` | Discard of candidates that should have been removed upstream | `LCR-FR-016` | P2 | — | `IMPL-1524` |
| `IMPL-1530` | The ranking signals, with no fabricated signal admitted | `LCR-FR-002`, `LCR-RS-001` | P2 | — | `IMPL-1524` |
| `IMPL-1531` | A3 acceptance harness — the 22 `LCR-AC-*` criteria | `LCR-AC-001`, `LCR-FND-001`, `LCR-API-001` | P3 | — | `IMPL-1524`…`IMPL-1530` |

### 4.4 ⛔ A4 — Groups and roles (`IMPL-1532`…`IMPL-1537`) — **ALL BLOCKED**

⛔⛔ **Every task in this section is `BLOCKED` and carries no schedulable
priority.** A4's **L638** records `LCG-GAP-001` as *"⛔ **OPEN — blocks
everything**"* and its **L643** records `LCG-GAP-006` as *"⛔ **OPEN — blocks
group creation**"*. `LCG-INV-007` requires that group creation be **rejected**
until the latter closes, and `LCG-AC-014` is marked *"⛔ **UNWRITABLE**"* in the
subject itself.

⭐ **These six numbers are allocated anyway, deliberately.** Withholding them
would make the range non-contiguous and would hide the fact that A4 has scoped
work waiting on a decision. Allocating them with `Blocked by` populated records
both the work and the blocker. **`P` reads `⛔` — not a number — because a
priority implies schedulability, and these are not schedulable.**

| Task | Work | Traces to | P | Blocks | Blocked by |
|---|---|---|---|---|---|
| `IMPL-1532` | Group aggregate and lifecycle | `LCG-FR-001`, `LCG-INV-007` | ⛔ | `IMPL-1533`…`IMPL-1537` | **`LCG-GAP-001`**, **`LCG-GAP-006`** |
| `IMPL-1533` | Group creation, rejecting while the community scope is unresolvable | `LCG-FR-010`, `LCG-INV-007`, `LCG-FS-001` | ⛔ | — | **`LCG-GAP-006`**, `IMPL-1532` |
| `IMPL-1534` | Role assignment within a group | `LCG-FR-001`, `LCG-SEC-001` | ⛔ | — | **`LCG-GAP-001`**, `IMPL-1532` |
| `IMPL-1535` | Group event publication over the `ADR-0084` Option B carrier | `LCG-DEP-001` | ⛔ | — | **`LCG-GAP-001`**, `IMPL-1532` |
| `IMPL-1536` | The declared edge cases and fail-safe behaviours | `LCG-EC-001`, `LCG-FS-001` | ⛔ | — | `IMPL-1532` |
| `IMPL-1537` | A4 acceptance harness — 17 of 18 `LCG-AC-*`; `LCG-AC-014` is unwritable | `LCG-AC-001` | ⛔ | — | `IMPL-1532`…`IMPL-1536` |

### 4.5 A5 — Official library communication (`IMPL-1538`…`IMPL-1547`)

| Task | Work | Traces to | P | Blocks | Blocked by |
|---|---|---|---|---|---|
| `IMPL-1538` | Official communication surface, as closed by `PO-7` clauses 1–2 | `LCO-FR-001` | P2 | `IMPL-1539`…`IMPL-1546` | `IMPL-1512` |
| `IMPL-1539` | Authoring and publication path | `LCO-FR-050`, `LCO-AUTH-001` | P2 | — | `IMPL-1538` |
| `IMPL-1540` | Read API for the official surface | `LCO-API-001` | P2 | — | `IMPL-1538` |
| `IMPL-1541` | Authorisation and object-level checks | `LCO-SEC-001`, `LCO-AUTH-001` | P1 | — | `IMPL-1538` |
| `IMPL-1542` | The declared invariants | `LCO-INV-001` | P1 | — | `IMPL-1538` |
| `IMPL-1543` | Declared edge cases | `LCO-EC-001` | P2 | — | `IMPL-1538` |
| `IMPL-1544` | Cross-context constraints | `LCO-XC-001` | P2 | — | `IMPL-1538` |
| `IMPL-1545` | ⛔ **No seventh A2 event.** A5 consumes A2's six-event contract and adds none | `LCF-FR-104` | P1 | — | `IMPL-1520` |
| `IMPL-1546` | Non-functional targets in the V2 band | `LCO-NFR-001` | P3 | — | `IMPL-1538` |
| `IMPL-1547` | A5 acceptance harness — the 21 `LCO-AC-*` criteria | `LCO-AC-001` | P2 | — | `IMPL-1538`…`IMPL-1546` |

⭐ **`IMPL-1545` is a task whose whole content is a prohibition**, and it exists
because `PO-7` clauses 4–5 **refused** A5 a seventh event. A refusal that no task
carries is a refusal nothing enforces.

### 4.6 A6 — Safety, privacy and moderation (`IMPL-1548`…`IMPL-1554`)

| Task | Work | Traces to | P | Blocks | Blocked by |
|---|---|---|---|---|---|
| `IMPL-1548` | Moderation projection fed by the existing edge, per the `ADR-0065` pattern | `LCS-FR-001`, `LCS-EDGE-001` | P1 | `IMPL-1549`…`IMPL-1553` | `IMPL-1503`, `IMPL-1521` |
| `IMPL-1549` | Report filing over the `ADR-0084` Option B carrier | `LCS-FR-040` | P1 | — | `IMPL-1548` |
| `IMPL-1550` | ⛔ **No `ModerationCase` aggregate created.** `BC-13` keeps it | `LCS-OWN-001` | P1 | — | `IMPL-1548` |
| `IMPL-1551` | The authoring principles applied to the safety surface | `LCS-AP-001` | P2 | — | `IMPL-1548` |
| `IMPL-1552` | Privacy and security constraints | `LCS-SEC-001` | P1 | — | `IMPL-1548` |
| `IMPL-1553` | The declared non-goals, enforced as exclusions | `LCS-NG-001`, `LCS-G-001` | P2 | — | `IMPL-1548` |
| `IMPL-1554` | A6 acceptance harness — the 20 `LCS-AC-*` criteria | `LCS-AC-001` | P2 | — | `IMPL-1548`…`IMPL-1553` |

### 4.7 A7 — Notifications (`IMPL-1555`…`IMPL-1559`)

⛔⛔ **A7's four withdrawn events are never implemented.** `SD-1` Option B
withdrew the **four** `LCN-EVT` numbers above `003` — `MembershipChanged`,
`ContentEligibilityChanged`, `OfficialCommunicationPublished` and
`HelpRequestAnswered`. Their identifiers are retained in A7 and **must never be
reused** (`PRD_LIFECYCLE.md` **L258** §5 rule 5). No task below cites one, and
they are named here **by their event names rather than their numbers** so that no
`grep` for a withdrawn identifier finds an apparent implementation obligation in
a Stage 6 document. See `K-7`.

⚠ **`LCT-CONF-001` — A7's seven events against A2's closure at six — is RAISED
and NOT RESOLVED.** `IMPL-1556` is written so that it is satisfiable **either
way**: it requires that A7 publish no event of its own and consume A2's contract,
which holds whichever way the conflict is later ruled.

| Task | Work | Traces to | P | Blocks | Blocked by |
|---|---|---|---|---|---|
| `IMPL-1555` | Notification trigger from the three **ACTIVE** A7 events only | `LCN-EVT-001`, `LCN-EVT-002`, `LCN-EVT-003` | P2 | `IMPL-1556`…`IMPL-1558` | `IMPL-1520` |
| `IMPL-1556` | Delivery routed through `BC-22`; `BC-15` mints no delivery capability | `LCN-FR-001` | P1 | — | `IMPL-1555` |
| `IMPL-1557` | Notification preference and suppression behaviour | `LCN-FR-040` | P2 | — | `IMPL-1555` |
| `IMPL-1558` | ⛔ **The three VOID `LCN-FR-*` positions are not implemented** and not reused | `LCN-FR-001` | P1 | — | `IMPL-1555` |
| `IMPL-1559` | A7 acceptance harness — the 21 `LCN-AC-*` criteria | `LCN-AC-001` | P2 | — | `IMPL-1555`…`IMPL-1558` |

### 4.8 A8 — Technical and production architecture (`IMPL-1560`…`IMPL-1567`)

| Task | Work | Traces to | P | Blocks | Blocked by |
|---|---|---|---|---|---|
| `IMPL-1560` | V2-band runtime wiring, inventing no new V2 infrastructure | `LCT-FR-001`, `LCT-AP-001` | P1 | `IMPL-1561`…`IMPL-1566` | `IMPL-1512` |
| `IMPL-1561` | Events carry **no** `tenantId`; `ID-2` is authoritative for `BC-15` | `LCT-INV-001` | P1 | — | `IMPL-1520`, `IMPL-1560` |
| `IMPL-1562` | Security architecture for the community surface | `LCT-SEC-001` | P1 | — | `IMPL-1560` |
| `IMPL-1563` | ⛔ **Event Replay NOT pulled forward from V3.** Where impossible in V2, conditional/deferred | `LCT-FR-060` | P2 | — | `IMPL-1560` |
| `IMPL-1564` | Observability and production readiness | `LCT-FR-001` | P2 | — | `IMPL-1560` |
| `IMPL-1565` | The declared non-goals as enforced exclusions | `LCT-NG-001`, `LCT-G-001` | P2 | — | `IMPL-1560` |
| `IMPL-1566` | Rejected alternatives recorded, not silently revived | `LCT-R-001` | P3 | — | `IMPL-1560` |
| `IMPL-1567` | A8 acceptance harness — the 35 `LCT-AC-*` criteria | `LCT-AC-001` | P2 | — | `IMPL-1560`…`IMPL-1566` |

### 4.9 Cross-part (`IMPL-1568`…`IMPL-1569`)

| Task | Work | Traces to | P | Blocks | Blocked by |
|---|---|---|---|---|---|
| `IMPL-1568` | Cross-part constraint enforcement across all eight parts. ⚠ **Its A4 clause is unreachable while A4's scope is open** — the task is completable for seven parts and **partial** for the eighth | `LCM-XC-001`, `LCF-XC-001`, `LCR-XC-001`, `LCG-XC-001`, `LCO-XC-001`, `LCT-XC-001` | P1 (⛔ partial) | — | `IMPL-1512`, `IMPL-1560`, ⛔ **`LCG-GAP-001`** *(A4 clause only)* |
| `IMPL-1569` | ⭐ **Sweep task** — the acceptance criteria no other task names by identifier. See §5.2. ⚠ **Cannot reach `LCG-AC-014`, which A4 marks `UNWRITABLE`** | `LCM-AC-001`, `LCF-AC-001`, `LCR-AC-001`, `LCG-AC-001`, `LCO-AC-001`, `LCS-AC-001`, `LCN-AC-001`, `LCT-AC-001` | P2 (⛔ partial) | — | all of `IMPL-1500`…`IMPL-1568`, ⛔ **`LCG-GAP-001`** *(A4 clause only)* |

---

## 5. Coverage — computed, published, and deliberately not gated

### 5.1 What the instrument reports

[`prd021a_task_coverage.py`](../../../tool/docs_check/prd021a_task_coverage.py) is
the **third** instrument of this set. It shares no code with
`prd021a_traceability.py` (subject vs itself) or `prd021a_stage5.py` (matrix §2P
vs subjects); its subject is **this document**. It computes, rather than accepts:

- the declared range is fully allocated, contiguous, and every member carries exactly **one** row;
- **no** `IMPL-*` allocated here appears as an allocation in any other module's task document;
- every row records `Priority`, `Blocks`, `Blocked by`;
- **the Stage 6 gate** — every task traces to at least one identifier the subjects actually define;
- **no minted identifier** — every `LC*` and `IMPL-*` token in this document already exists.

### 5.2 The figure, and why it is low

Requirement coverage by task row is **far below 100%**, and that is stated rather
than dressed. 70 tasks cannot individually name 757 requirements, and the honest
consequence is that most requirements are reached through a **group** task or the
`IMPL-1569` sweep rather than by name.

⛔ **Coverage is reported and does NOT fail the run.** Stage 6's gate is that
every **task** traces, not that every **requirement** is claimed. Gating on
coverage would create exactly the incentive `PRD-020`'s §5.3 refuses: *adding
unsourced citations to task rows to move a percentage.* The number is published so
it can be audited and argued with.

### 5.3 ⚠ The 551 requirements with no acceptance criterion

Matrix §2P.2 measures acceptance coverage across A1–A8 at **206 of 757 =
27.2%** — the lowest ever registered in this repository. **551 normative
requirements have no acceptance criterion at all.**

No task in §4 can prove those requirements, because there is nothing to prove
against. ⛔ **Minting the missing 551 criteria was available and is refused** —
it would take the register from 233 to 784, falsify every count in §2P.0, and is a
**Product Owner** authoring act. A5 is the sharpest case at **12.0%**: 133
`LCO-FR-*` against 21 `LCO-AC-*`. Recorded under `SID-4.56` — *"A rule that
cannot be checked SHALL be treated as unmet"* — and left as existing open work.

---

## 6. Defects in this document, disclosed rather than repaired

| # | Defect | Nature |
|---|---|---|
| **`K-1`** | ⛔ **6 of 70 tasks (8.6%) are unschedulable** — all of A4 — because `LCG-GAP-001` blocks its entire scope. A range in which one part cannot start is a defect of the **specification**, surfaced here rather than hidden by omitting A4 | subject, disclosed |
| **`K-2`** | **551 of 757 requirements have no acceptance criterion**, so no task can prove them. Inherited from §2P.2, not created here | subject, disclosed |
| **`K-3`** | Requirement coverage by task row is low by construction — 70 tasks against 757 requirements. Group tasks and `IMPL-1569` carry the remainder, which is weaker than per-requirement tasks and is said so | this document |
| **`K-4`** | ⚠ **`LCG-AC-014` is `UNWRITABLE` in the subject itself**, so `IMPL-1537` can only ever discharge 17 of A4's 18 criteria. Writing a criterion to fill it is a Product Owner act | subject, disclosed |
| **`K-5`** | ⚠ **This document has no mechanically-verified predecessor for a multi-part Stage 6.** Every prior task document has exactly one source PRD; this one has eight, so "the PRD defines it" becomes "some part defines it" — the instrument therefore resolves each token against the **union** of the eight, which is weaker than per-part resolution and is a disclosed limit, not a claim |
| **`K-6`** | ⛔⛔ **This document's own §7 row 10 wrote out the two ADR-drift gap numbers, which no subject defines — so the gate reported this document as MINTING them.** The row's purpose was to *disclose* the drift, and disclosure by reproducing the token is exactly what makes a Stage 6 document look like an identifier's definition site. **The instrument caught it; the author did not.** Corrected to name both by position. ⭐ **This is `J-1a` recurring one stage later**: at Stage 5 the same mistake was made in the section disclosing phantoms, and here it was made in the row disclosing drift — the identical failure shape in a document written by an author who had just recorded `J-1a` |
| **`K-7`** | ⛔ **The A7 prohibition paragraph wrote a withdrawn event number to say it must never be implemented**, and the gate correctly read that as a Stage 6 document citing a withdrawn identifier. A prohibition that reproduces the forbidden token defeats every `grep`-based check that looks for it. Corrected to name the four withdrawn events by **event name** instead |
| **`K-8`** | ✅ **The gate's A4 check was too coarse and the instrument was widened, not the document weakened.** It failed `IMPL-1568`/`IMPL-1569` — the two cross-part tasks — for holding a schedulable priority while touching `LCG-*`. But those tasks are *partly* reachable: seven parts today, A4 when its scope opens. The instrument now distinguishes **A4-owned** tasks (all `LCG-*` ⇒ unschedulable) from **cross-part** tasks (⇒ must disclose the A4 clause as partial). ⚠ **The tempting fix was to delete `LCG-XC-001` from the two rows and pass the gate** — which would have hidden a real cross-part obligation. Both rows now disclose the partial reachability instead |

---

## 7. Governance acts this document does **not** perform

| # | Act | Owner | State |
|---|---|---|---|
| 1 | Close `LCG-GAP-001` (A4 scope) | **Product Owner** | ⛔ Not performed. It blocks 6 tasks and is left open |
| 2 | Close `LCG-GAP-006` (`communityId`) | **Architecture Owner** | ⛔ Not performed |
| 3 | Resolve `LCT-CONF-001` (7 events vs 6) | **Architecture Owner** | ⛔ Not performed. `IMPL-1556` is written to hold either way |
| 4 | Move `PRD-021A` out of `PLANNED` in `PRD_REGISTRY.md` | **Governance Owner** | ⛔ Not performed |
| 5 | Confer `READY`, rank, or freeze; write a baseline row | **Governance Owner** | ⛔ Not performed. **Stage 7 is not entered** |
| 6 | Mint any `LC*` identifier or acceptance criterion | **Product Owner** | ⛔ **Zero minted.** Verified mechanically |
| 7 | Mint an ADR number | **Governance Owner** | ⛔ Not performed. 21 `*-ADR-*` requirements remain unallocated |
| 8 | Write `BC-15` production code | **Implementation lead**, at **Stage 8** | ⛔ Not performed — §2.4 |
| 9 | Consume `PRD-020`'s `IMPL-1450`…`1499` reserve | **Governance Owner** | ⛔ Not performed — §3.3 |
| 10 | Absorb the two ADR-vs-subject gap drifts published at matrix §2P.6 — one `LCF-GAP` number minted by `ADR-0082` past A2's maximum, one `LCM-GAP` number cited by `ADR-0083` past A1's maximum | **document owners** | ⛔ Not performed. Carried forward from §2P.6. ⚠ **The two tokens are deliberately named by position rather than written out here** — they are *not defined by any of the eight subjects*, so writing them in a Stage 6 document would make this document their apparent definition site. See `K-6` |

---

## 8. Measurements

| Measurement | Value |
|---|---|
| Range allocated | `IMPL-1500`…`IMPL-1569` — **70**, contiguous, one row each |
| Growth reserve | `IMPL-1570`…`IMPL-1599` — **30**, reserved, not allocated |
| Tasks blocked by an open gap | **6** — all of A4 |
| Identifiers minted by this document | **0** |
| Acceptance criteria proven | **0 of 233** — Stage 8/9 work |
| Subjects modified | **0** — eight sha256 unchanged |
| Rank 1–5 documents modified | **0** |
| `lib/` and `test/` files changed | **0** |
| Stage conferred | **6 of 9.** Stage 7 **not** entered |

---

## 9. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-01 | Initial allocation. **`IMPL-1500`…`1569`** established as next free by three independent routes and **`IMPL-1570`…`1599`** reserved for growth. **70 tasks across A1–A8 plus 2 cross-part**, every row carrying `Priority`/`Blocks`/`Blocked by` and tracing to identifiers the eight subjects actually define — **0 minted**. ⛔ **All 6 A4 tasks allocated `BLOCKED`** on `LCG-GAP-001`/`LCG-GAP-006` rather than omitted or given a priority they cannot have. ⛔ **A7's 4 withdrawn events are cited by no task**; `IMPL-1556` written to satisfy `LCT-CONF-001` either way. ⛔ **No code written** — Stage 6 and Stage 8 are different stages (§2.4). Five defects disclosed (`K-1`…`K-5`), of which two are inherited from the subjects and three belong to this document. `PRD-020`'s `IMPL-1450`…`1499` reserve deliberately **not** consumed (§3.3) |
