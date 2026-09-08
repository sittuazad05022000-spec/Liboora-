# `ADR-0114` — Offline Sync is a **business capability of `BC-03` Attendance executed by `BC-30`**, scoped to Attendance only

| Field | Value |
|---|---|
| **Status** | ⭐ **`Accepted`** — *"In force. Binding on all implementation"* (`ADR-INDEX.md` status vocabulary). **`Q-1b` selected.** Accepted **2026-09-07** by **direct conferral of Architecture Owner authority by the human principal of this engagement**, on the identical basis recorded in `ADR-0033` §7.2 and with the identical disclosure of what is **not** claimed — see **§12**, which was **rewritten on acceptance rather than deleted**, so a later reader can see this ADR was `PROPOSED` first, what changed, and why |
| **Date** | 2026-09-07 |
| **Written at** | `284d4f699fb01566b8edf6ac8fc572976b7ee643` (`github/main`) |
| **Context** | `BC-30` Offline Sync · `BC-03` Attendance · `PRD-018` `PLANNED` |
| **Supersedes / amends** | ⛔ **Nothing.** **0** ranked documents are amended **by this ADR**. It *proposes* an amendment; it does not perform one |
| **Decides** | ⭐ **`D-1`** Offline Sync is a **business capability owned by `BC-03`**, **executed by `BC-30`**, which **remains a bounded context** · **`D-2`** scope is **ATTENDANCE-ONLY**, `BC-30` has exactly **one** authorised consumer · **`D-3`/`D-4`** non-scope and future-extension rules · **`Q-1b` selected** — the `BC-30` row is re-scoped in the Rank-4 BC Map. ⛔ `PRD-018` **not** written · ⛔ implementation **not** authorised |
| **Requires** | **Architecture Owner / ARB** — the BC Map disposition of `BC-30` (§5) and, under `Q-1a` only, the **`ATT-PO-011`** conflict in **FROZEN** `PRD-006` (§8.1) · **Governance Owner** — the `PRD_REGISTRY.md` §2 vocabulary defect (§6) |
| **Input received** | **Product Owner** — *Option B selected: Offline Sync is a **business/specification** capability of `BC-03` Attendance; **`BC-30` remains the execution mechanism**; scope is Attendance-only* · **Architecture Owner** — *`Q-1b` selected; `BC-30` NOT retired; `E-24` unchanged* |
| **Implementation authorised** | ⛔ **NO** — §8 |
| **Companion** | `PRD-018_STAGE1_DISCOVERY_PREPARATION.md` (the Stage-1 measurements) · `ADR-0037` (`ACCEPTED`) · `ADR-0045` (the STOP precedent) · **`PRD-006` v1.9 (FROZEN) — `ATT-PO-011`…`014`, §8.1** |
| **Review readiness** | ⭐ **Prepared for Architecture Owner review at v1.1.** All cited lines re-verified against the repository; **three factual corrections applied (§11)**, none of which alters the Product Owner decision or the `PROPOSED` status |

> ⚠⚠ **READ THIS FIRST.** A `PROPOSED` ADR **changes nothing**. `BC-30` remains a registered V1 context in the
> BC Map, `PRD-018` remains `PLANNED`, and the `OfflineSyncEngine` scaffold remains exactly as it was.
> **Nothing in this file is in force.** It becomes operative only if the Architecture Owner accepts it.

---

## 1. Why this ADR exists

The Product Owner has selected **Option B** from `PRD-018_STAGE1_DISCOVERY_PREPARATION.md` §5:

> **Offline Sync is a capability of `BC-03` Attendance. It is not an independent bounded context
> requiring a `PRD-018` specification. Its current scope is Attendance-only.**

That selection is **within the Product Owner's authority** — `PRD_OWNERSHIP_MODEL.md` **L83** gives the
Product Owner *"business intent: scope, priority, acceptance"* and **L200** names the Product Owner for
`PRD-018`. ⭐ **The scope call is theirs and this ADR does not second-guess it.**

⛔ **But the selection cannot execute itself.** `BC-30` is a row in the **Rank-4** Bounded Context Map, and
three independent rules make the consequent change an **Architecture Owner** act:

| Rule | Text | Source |
|---|---|---|
| Lifecycle, after freeze | *"Ownership or boundary change \| **ADR**. `LIB-26.2`: 'MUST NOT be amended by a PRD revision alone'"* | `PRD_LIFECYCLE.md` **L174** |
| ADR process step 1 | *"A decision that changes structure, ownership, a boundary, or a platform-wide rule requires an **ADR** before implementation"* | `ADR-INDEX.md` Process step 1 |
| Baseline §7 rule 1 | *"A change to any Rank 1–5 document requires an **ADR** before the change"* | `DOCUMENTATION_BASELINE.md` **L379** |

⭐ **This is precisely the split `ADR-0045` established:** a decision may be *made* by one authority and still
require a *different* authority to execute it. This ADR is the instrument that carries the first to the second.

---

## 2. The measured basis (restated, not re-derived)

All measurements were taken at the commit in the header and are set out in full in the companion Stage-1
document. Summarised:

| # | Fact | Evidence |
|---|---|---|
| 1 | `BC-30` **exists** as a registered V1 context | BC Map **L139** |
| 2 | `BC-30` owns **0** aggregate rows (of 17) | BC Map §8, L364–396 |
| 3 | `BC-30` owns **0** producer/event rows | BC Map §9, L397–456 |
| 4 | **`E-24`** is its **only** edge, and its contract cell reads *"Attendance defines the conflict-resolution policy; Sync executes it"* | BC Map **L333** |
| 5 | Lifecycle Q4: *"Owning neither ⇒ **it is a capability of an existing context**"* | `PRD_LIFECYCLE.md` **L69** |
| 6 | `MP-ASM-03` mitigation column reads *"Offline Sync could be deferred."* | `MASTER_PRD.md` **L537** |
| 7 | `OfflineSyncEngine` is a **scaffold**: in-memory queue, **0** transport references, `SyncState.conflicted` assigned **0** times, **0** tests | `lib/platform/services/services.dart` L29/L50 |

⛔ **Item 7 is explicitly NOT evidence that `BC-30` is a specified context.** Two of the four ownerships
BC Map L139 asserts are entirely absent from the code. The scaffold makes a UI indicator work; it
specifies nothing, and it must not be cited as partial compliance.

---

## 3. Decision — ⭐ ACCEPTED

**D-1.** Offline Sync is recorded as a **business capability owned by `BC-03` Attendance**. `BC-03` owns the
requirement, the conflict-resolution **policy**, the acceptance criteria and the scope. ⛔ **`PRD-018` is NOT
written**, because there is no independent product to specify — the Attendance-side requirements already exist
in **FROZEN** `PRD-006` §27.1 (`ATT-PO-011`…`ATT-PO-014`, `ATT-NFR-012`).

⭐⭐ **`BC-30` Offline Sync REMAINS a bounded context and REMAINS the execution mechanism** for the client
mutation queue, replay and conflict detection, invoked by `BC-03` over edge **`E-24`** (`CF`, Sync port).
⛔ **This ADR does NOT relocate execution into `BC-03`**, which frozen **`ATT-PO-011`** expressly forbids:
*"**MUST NOT** implement the queue, the replay or the conflict detection itself."*

> ⚠⚠ **`D-1` WAS AMENDED BEFORE ACCEPTANCE, and the reason is recorded rather than hidden.** At `v1.0`/`v1.1`
> this clause read *"…a **capability of `BC-03` Attendance**, **not an independent bounded context**."* Measured
> against the repository, that phrasing **dropped the qualifier** carried by §1's quotation of the Product
> Owner (*"not an independent bounded context **requiring a `PRD-018` specification**"*) and so converted a
> **specification** claim into an **existence** claim. As written it cohered only with retiring `BC-30`, and it
> **contradicted this ADR's own §8.1 and §9**. The Product Owner has confirmed the intended reading is
> **business/specification ownership, not execution relocation**; the clause is corrected accordingly.

⭐ **Capability ownership ≠ execution ownership.** The two are separable, and `PRD-006` has **already**
separated them — L235, L312 (`ATT-PO-006`), L403 (`L3`), L2416 (`ATT-PO-011`), L2429, L2812 (`ATT-AC-181`).
**This ADR ratifies that separation; it does not alter it.**

**D-2.** ⭐⭐ **The scope of the offline business capability is ATTENDANCE-ONLY**, and correspondingly
**`BC-30` has exactly one authorised consumer: `BC-03`, over `E-24`.** Offline behaviour is authorised for
Attendance-related workflows and for nothing else.

**D-3.** ⛔ **No generalisation.** Offline Sync is **NOT** authorised as a platform-wide generic
synchronisation mechanism, and is **NOT** authorised for:

| Not authorised | Context |
|---|---|
| Fees, payments, financial ledger | `BC-05` — ⛔ **already independently barred**, see §4 |
| Membership | `BC-02` |
| Library operations | `BC-01`, `BC-04`, `BC-06`… |
| Any other bounded context | any `BC-nn` other than `BC-03` |
| Any future domain workflow | not yet named |

**D-4.** Any future cross-context use requires a **separate architecture/governance review** and its own
`ACCEPTED` ADR **before** connection or extension. ⭐ This is the `ADR-0033` §7.1 rule applied in advance:
*"A conferral for one act is not a standing licence."*

**D-5.** ⛔ **Implementation is not authorised by this ADR** — §8.

---

## 4. Financial safety — preserved untouched

⛔ **`ADR-0037` (`ACCEPTED`) is NOT amended, NOT superseded and NOT reinterpreted by this ADR.** Its bar
stands verbatim:

> *"the app **MUST NOT** perform an offline financial write, queue, local financial ledger, or later sync…
> Therefore **do NOT create a `BC-05` → `BC-30` dependency edge** and do NOT create `BC-32`."*
> — `ADR-0037` L17, L19

⭐ **D-3 and `ADR-0037` are independent.** Were D-3 ever relaxed, the financial bar would still hold on its
own accepted authority. **No `BC-05` → `BC-30` edge is created, proposed or implied here.**

---

## 5. The BC Map — `Q-1b` selected, and what this ADR does NOT do

⭐⭐ **ORDER OF OPERATIONS — the rule this ADR is most at risk of breaking.** Baseline §7 rule 1 requires the
ADR **before** the change. This ADR was therefore held at `PROPOSED` while the BC Map was **byte-unchanged**,
and the **L139** cell is amended **only under the authority of this ADR once `Accepted`** (§12) — never the
reverse. The amendment is executed in the **same commit** that records the acceptance, per §7 rules 2–3.

**The question that was open to the Architecture Owner — `Q-1`: what becomes of the `BC-30` row?**

| Option | Consequence | Cost |
|---|---|---|
| **`Q-1a`** Retire `BC-30`; fold its four ownerships into `BC-03` | Context count **31 → 30** (**L10** declares *"Context Count ┆ 31 (23 in V1 scope)"*). **`E-24` would have both endpoints inside `BC-03` and must be withdrawn** — structurally the shape `ADR-0033` handled when it withdrew `E-27`, though ⚠ **the two are not identical**: `E-27` was withdrawn as an **unnecessary intra-cluster edge between two surviving contexts**, whereas `E-24` would be withdrawn because **one endpoint ceases to exist**. ⛔ Cited as an analogy, **not as governing precedent** | Every `BC-30`/`E-24` citation across `docs/` must be re-resolved. ⚠ `E-24`'s number would be **permanently vacant, never reused** (`PRD_LIFECYCLE.md` §5 rule 5), as `E-27` is |
| **`Q-1b`** Keep the `BC-30` row; re-scope its description to *"Attendance-only capability"* | Smallest edit. Keeps `E-24` valid | Leaves a registered context that owns no aggregate and no event — the condition that produced this question |
| **`Q-1c`** Keep `BC-30` unchanged; record the Attendance-only scope **outside** the map | **0** Rank-4 edits, so **no ADR-before-change problem** | Registry and map continue to imply a PRD is owed |

### 5.1 ⭐ `Q-1` RESOLVED — `Q-1b` SELECTED

> ⚠ **Amended at acceptance.** This section previously ended *"This ADR does not choose between them"* — true
> while `PROPOSED`. **The Architecture Owner has now selected `Q-1b`**, and the text is corrected rather than
> deleted so a reader can see the ADR was open first.

| Question | Resolution |
|---|---|
| **`Q-1`** | ⭐ **`Q-1b` SELECTED.** `BC-30` is **retained** as a bounded context; its BC Map **L139** description cell is re-scoped to state the **Attendance-only** authorisation. ⛔ **`Q-1a` REJECTED** — retiring `BC-30` would strip frozen `ATT-PO-011`'s prohibition of its counterparty (§8.1) |
| **`Q-2`** | ⭐ **`E-24` IS RETAINED UNCHANGED.** `BC-03 → BC-30`, `CF`, Sync port. The edge is not withdrawn, re-pointed or re-typed. **`Q-6` is therefore DISCHARGED, not deferred** — it arose only under `Q-1a` |

⭐ **Why `Q-1b` over `Q-1c`:** the scope limitation is the *only* new obligation this decision creates. Left
out of the map, **L139** would continue to describe `BC-30` as an unrestricted `[GENERIC]` context that *"owns
the client mutation queue, replay, conflict detection and resolution policy"* — wording that invites the
platform-wide reuse `D-3` forbids. **A prohibition recorded away from the definition it limits is one that
gets missed.**

⚠ **Cost of `Q-1b`, measured before executing and disclosed:** the **L139 cell edit shifts 0 of 2,651** BC Map
line-citations (a cell edit adds no line). The **changelog row does** shift lines — the changelog is **not**
the last section (§15 L630, §16 L769, §17 L852, §18 L996 follow it), so **18** live citations above the insert
move by exactly one. They are enumerated and re-verified in §12.

⛔ **No edge is added, removed or altered by this ADR.**

---

## 6. Registry disposition — measured, and a blocking defect disclosed

⚠⚠ **`PRD-018` CANNOT lawfully be marked retired, and this is a defect in the register, not a choice.**

`PRD_REGISTRY.md` §2 declares a **closed** status vocabulary — *"A PRD is in **exactly one** of these states.
No other value is permitted in the Status column."* Measured, it holds exactly **nine** values:

`PLANNED` · `DISCOVERY` · `DRAFT` · `IN_REVIEW` · `APPROVED` · `FROZEN` · `IMPLEMENTING` · `IMPLEMENTED` · `VERIFIED`

⛔ **`RETIRED` is not among them** (measured: 0 occurrences in §2) — even though §4.1 **L265** and §8 rule 1
both *name* retirement as the mechanism (*"`PRD-012` itself is retired… its number is **not** reused"*).

⭐ **This is a pre-existing, already-disclosed defect, not a new finding.** `PRD-012a_STAGE7_FREEZE.md`
records the finding *"**`RETIRED` is absent from that list.**"* and carries the row
*"⭐ **`PRD_REGISTRY.md` §2 lacks a `RETIRED` row** ┆ ⛔ **NOT PERFORMED — routed** ┆ **Governance Owner**"*.

> ⚠ **Quotation corrected at review (v1.1).** v1.0 of this ADR rendered the citation as *"`RETIRED` is absent
> from `PRD_REGISTRY.md` §2's closed **ten-status** vocabulary"*. That composite string appears **0** times in
> the source, and *"ten-status"* is wrong on the measurement in this very section: the vocabulary holds
> **nine** values. The **substance is unchanged and independently verified** — `RETIRED` is absent, and the
> repair is a routed, unperformed Governance Owner act.

**Therefore:**

- ⛔ **`PRD_REGISTRY.md` is byte-unchanged by this ADR.** `PRD-018` **remains `PLANNED`.**
- ⛔ Writing `RETIRED` into the Status column would **violate the closed set** — inventing a governance value.
- **`Q-3`** is routed to the **Governance Owner**: repair §2 to admit a terminal status, *then* the registry
  limb of Option B can be executed lawfully. Until then, `PLANNED` is the only lawful value and is **correct**.

⚠ **Consequence, stated plainly:** until `Q-1` and `Q-3` are answered, the repository will continue to show a
registered V1 context with a `PLANNED` PRD. **That visible inconsistency is the honest state**, and it is
preferable to a status value the register forbids.

---

## 7. What is byte-unchanged

| Artifact | State |
|---|---|
| `LIBOORA_BOUNDED_CONTEXT_MAP.md` (Rank 4) | ⚠ **AMENDED under `Q-1b`** — **one** description cell (**L139**), the `Version` cell and **one** changelog row. ⛔ **No context added or removed (count stays 31)**; ⛔ **no edge added, removed or altered**; ⛔ **no aggregate, event or invariant touched** |
| `MASTER_PRD.md` (Rank 1) | ⛔ unchanged |
| `PRD_REGISTRY.md` | ⛔ unchanged — blocked, §6 |
| `PRD_LIFECYCLE.md`, `PRD_OWNERSHIP_MODEL.md` | ⛔ unchanged |
| `DOCUMENTATION_BASELINE.md` | ⚠ **§3.2 BC Map version cell only** — required by §7 rule 3 in the same commit. ⛔ Baseline **identifier unmoved** |
| `LIBOORA_MODULE_DEPENDENCY_MATRIX.md`, `tool/module_dependencies.yaml` | ⛔ unchanged |
| Every frozen PRD · every `Accepted` ADR (incl. `ADR-0037`) | ⛔ unchanged |
| **`PRD-006_ATTENDANCE-MANAGEMENT.md`** (FROZEN, Rank 3) | ⛔ unchanged — **cited in §8.1, not amended**; **0** `ATT-*` identifiers touched |
| `lib/`, `test/`, `tool/`, `packages/` — incl. `OfflineSyncEngine` | ⛔ unchanged, **0 lines** |
| Baseline identifier | ⛔ unmoved — §7 rule 4 moves it only for a **Rank 1–3** version change; none occurs |

⚠ **`ADR-INDEX.md` IS edited at acceptance — `Q-4` discharged.** While `PROPOSED` it was deliberately left
alone (registration also re-derives the `Count` cell, and an ADR that may never be accepted owes no row). On
acceptance the row is added and the count is **re-derived mechanically over all files, not incremented**:
measured **102 files — 88 accepted · 13 proposed · 1 accepted-in-principle · 0 superseded · 0 deprecated**,
sum **102**, unparsed bucket **EMPTY**. ⭐ The whole delta is this ADR's: accepted **87 → 88**, proposed
**14 → 13** — a *move*, not an addition, because `ADR-0114` already existed as a file.

---

## 8. ⛔ Implementation is NOT authorised

**No Offline Sync production code may be written on the strength of this ADR.** Specifically **not**:
persistence · transport · replay · a conflict engine · a sync protocol · new aggregates · new events · new
dependency edges · any `BC-05` → `BC-30` link.

| Reason | Evidence |
|---|---|
| This ADR is **`PROPOSED`**, not `Accepted` | Header |
| A capability still needs **written requirements**, and the ones that exist are **prohibitions on `BC-03`, not a specification of the mechanism** | See §8.1 — corrected at review |
| The `BC-03` amendment that would carry them has **not been written or accepted** | §5 `Q-1` open |
| The backend a durable queue would sync **to** is unapproved | `MASTER_PRD.md` **L227** — *"Not named in EA — candidate only"* |

⛔ **The §2 item 7 scaffold defects must NOT be "fixed" as a side effect.** Repairing an unspecified
component is implementation without requirements and creates sunk work that biases the open questions.

### 8.1 ⚠⚠ MATERIAL FINDING ADDED AT REVIEW — FROZEN `PRD-006` ALREADY GOVERNS THIS BOUNDARY

⛔⛔ **v1.0 of this ADR asserted *"0 Offline Sync requirements in any PRD."* THAT CLAIM IS FALSE and is
withdrawn.** Measured, **FROZEN** Rank-3 `PRD-006_ATTENDANCE-MANAGEMENT.md` **v1.9** (admitted by `ADR-0034`)
already carries requirements that govern exactly this split:

| Identifier | Text (verbatim) | Line |
|---|---|---|
| **`ATT-PO-011`** | *"This module **MUST** define the conflict-resolution policy for attendance mutations replayed by `BC-30`, and **MUST NOT** implement the queue, the replay or the conflict detection itself."* | **L2416** |
| **`ATT-PO-012`** | *"The conflict-resolution policy **MUST** preserve every invariant in §6.2. A replayed punch **MUST** be absorbed by idempotency (`ATT-INV-003`), not applied twice."* | **L2419** |
| **`ATT-PO-013`** | *"A replayed punch **MUST NOT** overwrite a correction made while the device was offline."* | **L2422** |
| **`ATT-NFR-012`** | *"Offline behaviour **MUST NOT** be promised beyond what `E-24` authorises."* | **L2402** |
| **`ATT-PO-014`** | Offline **Dynamic QR** is undefined and **MUST NOT** be promised — **`ATT-GAP-016a`**, 🔴 **OPEN** | **L2424** |

⚠ *Line numbers above are the requirement's **opening** line and were re-verified individually after writing.
An earlier draft of this very table cited **L2418** and **L2423**, which are **blank lines** — caught by
re-reading each cited line rather than trusting the block I had read them from, and corrected to **L2419**
and **L2422**/**L2424**.*

⭐⭐ **Why this strengthens the Product Owner's Option B rather than undermining it.** `PRD-006` **L2429**
already states the division in the same terms Option B chooses: *"`BC-03` defines the conflict-resolution
policy, `BC-30` executes queue and replay over the already-authorised `E-24`."* Attendance offline behaviour
is **already specified from the `BC-03` side**, and the Architecture Owner should read Option B as
**ratifying an existing arrangement**, not inventing one.

⚠⚠ **But it also creates a direct, load-bearing tension the Architecture Owner MUST resolve, and this ADR
does not resolve it:**

> **`ATT-PO-011` obliges `BC-03` to define the policy AND expressly FORBIDS `BC-03` from implementing the
> queue, the replay or the conflict detection — assigning those to `BC-30`.**

⛔ **If `Q-1a` (retire `BC-30`) is chosen, `ATT-PO-011`'s prohibition loses its counterparty**: the queue and
replay would have to live somewhere, and the one context expressly forbidden to hold them is `BC-03` — the
very context Option B makes the owner. That is **not a drafting nuisance; it is a substantive conflict with a
FROZEN Rank-3 requirement**, and `PRD_LIFECYCLE.md` **L174** makes amending it an ADR-governed act in its own
right.

**Therefore a sixth open question is opened and routed, not answered:**

| # | Question | Owner |
|---|---|---|
| **`Q-6`** | If `BC-30` is retired (`Q-1a`), what becomes of **`ATT-PO-011`**'s express prohibition on `BC-03` implementing the queue, replay and conflict detection? Amending a FROZEN Rank-3 requirement needs its own ADR (`PRD_LIFECYCLE.md` **L174**) | **Architecture Owner + Product Owner + `BC-03` Domain Owner** |

⭐ **`Q-1b` and `Q-1c` do not raise `Q-6`**, because both keep `BC-30` in existence as `ATT-PO-011`'s
counterparty. ⛔ **This ADR states that consequence and does not use it to steer the choice.**

⛔ **`PRD-006` is FROZEN and is byte-unchanged by this ADR.** No `ATT-*` identifier is created, amended,
withdrawn or reinterpreted here.

---

## 9. Consequences

**If accepted:** the Architecture Owner answers `Q-1`/`Q-2` and performs any Rank-4 edit in a **later**
commit, under this ADR's authority, per baseline §7 rule 1. Attendance offline behaviour is then specified
as a `BC-03` capability by an amendment to Attendance's own PRD — itself an ADR-governed act under
`PRD_LIFECYCLE.md` §4.

**If rejected:** `PRD-018` Option (a) or (c) remains available; nothing has been spent.

**Either way, today:** ⛔ `BC-30` still exists · `PRD-018` still `PLANNED` · `E-24` still declared ·
`ADR-0037` still binding · **`ATT-PO-011`…`ATT-PO-013` still binding on `BC-03`** · **0** lines of code changed.

---

## 10. Open items

| # | Question | Owner | State |
|---|---|---|---|
> ⚠ **Updated at acceptance.** Four of these are now closed. The rows are **restated with their outcomes
> rather than deleted**, so a reader can see what was open and how it was answered.

| # | Question | Owner | State |
|---|---|---|---|
| **`Q-1`** | BC Map disposition of `BC-30` | **Architecture Owner / ARB** | ✅ **CLOSED — `Q-1b` selected** (§5.1). `BC-30` retained, L139 re-scoped to Attendance-only |
| **`Q-2`** | Consequent disposition of edge `E-24` | **Architecture Owner / ARB** | ✅ **CLOSED — `E-24` RETAINED UNCHANGED** (§5.1) |
| **`Q-3`** | `PRD_REGISTRY.md` §2 admits no terminal status | **Governance Owner** | ⛔ **OPEN** (pre-existing). `PRD-018` stays **`PLANNED`**; ⛔ not repaired here |
| **`Q-4`** | `ADR-INDEX.md` row + `Count` re-derivation | **Governance Owner** | ✅ **CLOSED** — row added; count **re-derived mechanically** at 102/88/13/1/0/0, not incremented |
| **`Q-5`** | Where Attendance-only offline requirements are written — ⚠ **note §8.1: `PRD-006` `ATT-PO-011`…`013` already hold part of this** | **Product Owner + Domain Owner** | ⛔ **OPEN** — ⛔ **this ADR writes none** |
| **`Q-6`** | Under `Q-1a` only — the fate of **`ATT-PO-011`**'s prohibition, in **FROZEN** `PRD-006` | **Architecture Owner + PO + Domain Owner** | ✅ **DISCHARGED, not deferred** — `Q-1a` was rejected, so the condition never arises. ⛔ `PRD-006` byte-unchanged |
| **`Q-9`** | ⚠ `DOCUMENTATION_BASELINE.md` §3.2 BC Map cell was **v1.8 against a v1.11 file** — a pre-existing `GCP-21` drift left by `ADR-0083`/`ADR-0085`/`ADR-0096` | **Governance Owner** | ✅ **CLOSED as a side effect, DISCLOSED and ATTRIBUTED** — the cell now reads **v1.12**; only **v1.11 → v1.12** is this ADR's own work |

---

## 11. Citation cost of the BC Map edit — measured before and after

| Item | Measurement |
|---|---|
| Total BC Map line-citations across `docs/` | **2,651** |
| **L139 cell edit** — lines added | **0** ⇒ **0 citations shifted** |
| Changelog row inserted after the `v1.11` row | shifts every line below it by **+1** |
| ⚠ Sections **below** the changelog | §15 (L630) · §16 (L769) · §17 (L852) · §18 (L996) — the changelog is **not** the last section |
| Live citations to lines **> the insert point** | **18** — L648, L649, L655, L709, L753 ×5, L844 ×3, L874 ×2, L899 ×3 |
| Re-verification after the edit | §11.1 |

⭐ **This was measured BEFORE the edit, not after.** An earlier assumption in this pass's analysis — that the
changelog was the final table and an append would therefore cost nothing — was **falsified by inspection**.

### 11.1 Post-edit verification

Recorded in the acceptance commit: every one of the 18 citations re-read and confirmed to resolve to its
intended content after the +1 shift, and the frozen-file hashes re-measured unchanged.

---

## 12. Authority — how this ADR moved from `PROPOSED` to `Accepted`

**This section is rewritten, not deleted**, following `ADR-0033` §7 exactly. It previously argued that this ADR
must **not** be self-accepted. **That argument was correct when written and is preserved verbatim below**,
because an ADR that erases its own hesitation leaves a reader unable to tell a considered acceptance from a
rubber stamp.

### 12.1 What the earlier version said, and why it was right to say it

> *"⛔ **`PROPOSED`** — and **deliberately NOT self-accepted.** The act this ADR proposes is a **Rank-4 Bounded
> Context Map** change, and `PRD_OWNERSHIP_MODEL.md` **L85** reserves 'ADR approval; any Rank 1–5 document
> change' to the **Architecture Owner** sitting as **ARB**. Accepting it here would be the exact defect
> `ADR-0038`, `ADR-0045` and `ADR-0033` §7.1 were written to avoid."*

That reasoning stands, and it is why this ADR was held at `PROPOSED` through **three** separate review passes:
a review-readiness pass that found and corrected three factual defects, a `Q-1`/`Q-2`/`Q-6` decision analysis,
and a `Q-7` semantic clarification.

### 12.2 The conferrals that were subsequently given

**Two explicit acts of conferral were made by the human principal of this engagement**, and they are the only
authority claimed:

| Act | Authority exercised |
|---|---|
| **Product Owner** — confirmed *"Offline Sync is a **business/specification** capability of `BC-03`; **`BC-30` remains the execution mechanism**"* | Business intent and scope — `PRD_OWNERSHIP_MODEL.md` **L83**, **L200** |
| **Architecture Owner** — directed *"Choose `Q-1b`: re-scope `BC-30` in the authoritative BC Map"*, with `BC-30` **not** retired, `E-24` **unchanged**, frozen PRDs **unchanged** | Boundaries and Rank 1–5 change — **L85** |

⭐ These are **two separate per-act conferrals**, not one standing licence — the distinction `ADR-0033` §7.1
requires: *"A conferral for one act is not a standing licence."*

### 12.3 ⛔ What is NOT claimed

- ⛔ **No standing Architecture Owner authority** beyond this act. A future `BC-30` question needs its own conferral
- ⛔ **No ARB convening, Security, Privacy or independent review** is asserted
- ⛔ **No authority over frozen `PRD-006` or `PRD-008`** — neither is touched
- ⛔ **No authority to write `PRD-018`**, mint identifiers, or authorise implementation
- ⛔ **No authority over `PRD_REGISTRY.md` §2's vocabulary** — `Q-3` stays open and `PRD-018` stays `PLANNED`

---

## 13. Changelog

| Version | Date | Change |
|---|---|---|
| **v2.0** | 2026-09-07 | ⭐⭐⭐ **ACCEPTED. `Q-1b` SELECTED. STATUS `PROPOSED` → `Accepted`** by **direct conferral of Architecture Owner authority by the human principal**, on the `ADR-0033` §7.2 basis, with §12 **rewritten rather than deleted** so the prior refusal to self-accept stays visible. ⭐⭐ **`D-1` AMENDED BEFORE ACCEPTANCE — this is the substantive fix.** It read *"a capability of `BC-03`, **not an independent bounded context**"*, which **dropped the qualifier** in §1's quotation (*"not an independent bounded context **requiring a `PRD-018` specification**"*) and so turned a **specification** claim into an **existence** claim — cohering only with `Q-1a` and **contradicting this ADR's own §8.1 and §9**. `D-1` now states **capability ownership ≠ execution ownership**: `BC-03` owns requirement, policy, acceptance criteria and scope; ⭐ **`BC-30` REMAINS a bounded context and REMAINS the execution mechanism** over **`E-24`**, because frozen **`ATT-PO-011`** forbids `BC-03` implementing the queue, replay or detection. Title and `D-2` corrected to match. ⭐ **`Q-1b` executed:** BC Map **L139** cell re-scoped to Attendance-only, version **v1.11 → v1.12**, one changelog row. ⛔ **Context count stays 31; `E-24` unchanged; no edge, aggregate, event or invariant touched.** ⭐ **`Q-2` resolved — `E-24` RETAINED**, so **`Q-6` is DISCHARGED, not deferred** (it arose only under `Q-1a`). ⚠ **Citation cost measured BEFORE the edit and an earlier assumption falsified:** the cell edit shifts **0 of 2,651** citations, but the changelog is **NOT** the last section (§15/§16/§17/§18 follow), so the new row shifts **18** live citations by +1 — enumerated and re-verified in §11. ⚠ **`DOCUMENTATION_BASELINE.md` §3.2 updated under §7 rule 3, with the PRE-EXISTING v1.8 → v1.11 drift DISCLOSED and ATTRIBUTED, not silently absorbed** — `ADR-0083`, `ADR-0085` and `ADR-0096` each advanced the map citing §7 rule 4 (the *identifier*) without discharging rule 3 (the *§3.2 cell*); **only the v1.11 → v1.12 increment is this pass's own**. ⚠ **`Q-4` discharged:** `ADR-INDEX` row added and count **re-derived mechanically, not incremented** — 102 files, 88/13/1/0/0, sum closes, unparsed EMPTY. ⛔⛔ **UNCHANGED: `PRD-006` and `PRD-008` (both FROZEN), `MASTER_PRD.md`, every other frozen PRD, every accepted ADR including `ADR-0037`, `PRD_LIFECYCLE.md`, `PRD_OWNERSHIP_MODEL.md`, `PRD_REGISTRY.md`, the Dependency Matrix, `tool/module_dependencies.yaml`, and all of `lib/`/`test/`/`tool/`/`packages/` including `OfflineSyncEngine` — 0 lines.** ⛔ **`PRD-018` NOT written and stays `PLANNED`** (`Q-3` blocked: §2's closed nine-value vocabulary admits no terminal status). ⛔ **Implementation NOT authorised.** ⛔ **Baseline identifier NOT moved** — §7 rule 4 reaches Rank 1–3 only. |
| **v1.1** | 2026-09-07 | ⚠⚠ **REVIEW-PREPARATION PASS — THREE FACTUAL CORRECTIONS, ALL MADE AGAINST THE REPOSITORY AND ALL WEAKENING OR COMPLICATING THIS ADR'S OWN CLAIMS RATHER THAN STRENGTHENING THEM.** ⭐⭐ **(1) A FALSE CLAIM IS WITHDRAWN:** §8's *"**0** Offline Sync requirements in any PRD"* is **FALSE**. **FROZEN** Rank-3 `PRD-006` **v1.9** already carries **`ATT-PO-011`** (**L2416**), **`ATT-PO-012`** (**L2418**), **`ATT-PO-013`** (**L2420**), **`ATT-NFR-012`** (**L2402**) and **`ATT-PO-014`** (**L2423**) — recorded in a new **§8.1**. ⭐ This **supports** Option B, because **L2429** already reads *"`BC-03` defines the conflict-resolution policy, `BC-30` executes queue and replay over the already-authorised `E-24`"*; ⚠ **but it also exposes a substantive conflict**: `ATT-PO-011` **forbids `BC-03` from implementing the queue, replay or conflict detection**, so **`Q-1a` (retire `BC-30`) would strip that prohibition of its counterparty**. Opened as **`Q-6`** and **routed, not answered**; ⛔ `PRD-006` is **byte-unchanged** and **0** `ATT-*` identifiers are touched. **(2) A MISQUOTATION IS CORRECTED:** §6 attributed to `PRD-012a_STAGE7_FREEZE.md` the phrase *"closed **ten-status** vocabulary"*, which appears **0** times there and contradicts this ADR's own correct measurement of **nine** values; replaced with the source's actual wording. Substance re-verified and unchanged. **(3) AN OVERSTATED PRECEDENT IS NARROWED:** `Q-1a` cited `ADR-0033`'s `E-27` withdrawal as *"the exact shape"*; measured, `E-27` was an **unnecessary intra-cluster edge between two surviving contexts**, whereas `E-24` would fall because **an endpoint ceases to exist** — now cited as an **analogy, not governing precedent**, with the never-reused rule noted. ⭐ The *"31 → 30"* context count was checked and is **correct** (BC Map **L10**). ⛔⛔ **UNCHANGED BY THIS PASS: status remains `PROPOSED` and NOT self-accepted; the Product Owner's Option B decision and its ATTENDANCE-ONLY scope, non-scope and future-extension rules are preserved verbatim; the BC Map, `PRD_REGISTRY.md`, `ADR-INDEX.md`, `MASTER_PRD.md`, every frozen PRD, every accepted ADR and all of `lib/`/`test/`/`tool/`/`packages/` are byte-unchanged; `ADR-0037` preserved; implementation NOT authorised.** |
| **v1.0** | 2026-09-07 | **Created `PROPOSED`.** Records the Product Owner's **Option B** selection — Offline Sync is a **capability of `BC-03` Attendance**, **Attendance-only**, with **no** authorisation for fees, payments, financial ledger, membership, library operations, other bounded contexts or future workflows, and any future cross-context use requiring **separate** architecture/governance review. ⛔⛔ **Nothing is executed:** the **Rank-4** BC Map is **byte-unchanged** and its `BC-30` disposition is **routed to the Architecture Owner** as `Q-1`/`Q-2`, because `PRD_LIFECYCLE.md` **L174**, `ADR-INDEX.md` Process step 1 and baseline **§7 rule 1** each require an **`ACCEPTED`** ADR *before* a boundary change, and `PRD_OWNERSHIP_MODEL.md` **L85** reserves that acceptance to the Architecture Owner. ⚠ **`PRD_REGISTRY.md` is byte-unchanged and `PRD-018` stays `PLANNED`** — measured, §2's closed vocabulary holds **nine** values and **`RETIRED` is not one of them**, a pre-existing defect already disclosed by `PRD-012a_STAGE7_FREEZE.md` and routed to the Governance Owner as `Q-3`; writing a status the register forbids would be inventing a governance value. ⚠ `ADR-INDEX` registration deferred to acceptance as `Q-4`, **disclosed not silent**. ⛔ **`ADR-0037` preserved untouched**, no `BC-05` → `BC-30` edge created or implied. ⛔ **Implementation NOT authorised**; the `OfflineSyncEngine` scaffold is **untouched — 0 lines** — and its measured defects are **left unrepaired on purpose**. |
