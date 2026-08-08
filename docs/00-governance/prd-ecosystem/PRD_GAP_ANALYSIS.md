# LIBOORA — PRD Gap Analysis

| Field | Value |
|---|---|
| **Document** | PRD Gap Analysis — what is missing, what overlaps, what must not be split |
| **Version** | v1.0 |
| **Status** | Active |
| **Date** | 2026-08-04 |
| **Baseline** | `BASELINE-2026-08-04` |
| **Authority** | **Analysis only. Non-normative.** Findings are raised, not resolved. Nothing here modifies a requirement |
| **Finding prefix** | `PGA-n` |

---

## 1. Method, and the constraint that shaped the result

Every finding below cites a document **on disk in this repository**, by section, and where the evidence is a
quotation it is reproduced exactly. Nothing is asserted from memory.

The governing instruction was explicit, and it is the reason this document is shorter than it could have been:

> *"Do not invent requirements merely to increase the number of PRDs. Prefer a smaller number of clear bounded
> contexts over unnecessary fragmentation."*

So a gap is recorded **only** where the repository itself already establishes the obligation — a Master PRD row, a
bounded context with an aggregate, an integration edge with no owner. §6 records the cases where the tempting
answer is a new PRD and the correct answer is **no new document**, which is the harder half of this analysis.

**Two of the six findings in §3–§4 are new.** Neither is recorded in any existing alignment or audit document;
each was found by cross-reading two documents that agree individually and disagree with each other.

---

## 2. Summary

| Category | Count | Severity |
|---|---|---|
| **Missing PRDs** | **18** | 1 Critical · 5 High · 12 Medium |
| **Duplicate PRDs** | **0** | — |
| **Overlapping responsibilities** | **0 genuine** · 2 that look like overlaps and are not | — |
| **Missing dependencies** | **1** (`PGA-02`) | Medium |
| **Architectural conflicts** | **2** (`PGA-01`, `PGA-02`) | 1 Medium · 1 Medium |
| **Requirements with no owning PRD** | **3 classes** (`PGA-03`…`PGA-05`) | 1 Critical · 2 High |
| **PRDs that should be split** | **1** (`PGA-06`) | High |
| **PRDs that should NOT be split** | **6 cases** | — |

---

## 3. Architectural conflicts

### `PGA-01` — The Library PRD attributes finance to `BC-11`…`BC-13`, which are social contexts

**Severity: Medium** · **Type: cross-document conflict in a frozen document** · **Status: raised, unresolved**

`Library_PRD_v1.md` names `BC-11`…`BC-13` as the owner of finance data in **three** places:

| Line | Text |
|---|---|
| 136 | `LXC-7` \| Hold money, price anything, or issue a receipt \| **`BC-11`…`BC-13`** \| Finance PRD |
| 904 | Revenue & Finance \| **`BC-11`…`BC-13`** \| Read projection — never authoritative here |
| 1103 | Invoice, payment, revenue \| **`BC-11`…`BC-13`** \| Reads projection |

The Bounded Context Map assigns those identifiers elsewhere:

| Context | Actual owner |
|---|---|
| `BC-11` | **Social Graph** — friendships, blocks |
| `BC-12` | **Messaging** — conversations |
| `BC-13` | **Trust & Safety** `[CORE]` — moderation, minor safety |

Money owed **student → library** is `BC-05` Fee & Collection. Money owed **library → LIBOORA** is `BC-20`
Subscription & Billing. The map devotes a ubiquitous-language row to keeping precisely these two apart.

**Not previously recorded.** `LIBRARY_PRD_ALIGNMENT.md` — the validation record that found and dispositioned 14
conflicts — contains **zero** occurrences of `BC-11`, `BC-12`, `BC-13` or *"Finance"*. This conflict passed
through that review.

**Why it is Medium and not High.** All three rows say *"read projection — never authoritative here"*, so the
**ownership boundary is correct**; only the identifier is wrong. The Library module is told not to own finance,
which is the load-bearing instruction. The damage is that a developer following `LIB-26.1` — *"the authoritative
answer to 'who owns this field?'"* — is pointed at Trust & Safety when asking who owns an invoice.

**Why this document does not fix it.** `Library_PRD_v1.md` is frozen at Rank 3. `DOCUMENTATION_BASELINE.md` §7:
*"A change to any Rank 1–5 document requires an ADR **before** the change."* Request G additionally forbids
modifying business requirements or redesigning approved PRDs. **Correcting a frozen PRD by silent edit is the
exact failure the freeze exists to prevent**, even when the correction is obviously right.

**Recommended disposition:** an ADR recording the identifier correction, then a versioned amendment to
`Library_PRD_v1.md` §26 and `LXC-7`. Not urgent — no code depends on it — but it should not be carried silently.

### `PGA-02` — `PRD-003` cites integration edge `E-22`, whose consumer list omits `BC-10`

**Severity: Medium** · **Type: missing dependency / stale edge table** · **Status: raised, unresolved**

Bounded Context Map §7.3, exactly:

| # | Consumer | Provider |
|---|---|---|
| `E-21` | `BC-01`, **`BC-10`** | `BC-23` Search Indexing |
| `E-22` | `BC-01`, `BC-14` | `BC-29` File & Media |

`E-21` was extended to include `BC-10`. **`E-22` was not.** But `Student_Identity_PRD_v1.md` §4.8 is headed
*"File & Media — `BC-29` (`E-22`)"*, and `SID-4.35` requires the Global Profile Photo to be *"held as a `FileRef`
issued by `BC-29`"*.

§7's own rule decides the significance:

> *"If an edge is not in this table, it **does not exist** and adding it requires an ADR."*

Read strictly, `BC-10 → BC-29` does not exist, and `SID-4.35` therefore requires an interaction the architecture
does not permit. **Not recorded** in `STUDENT_IDENTITY_ALIGNMENT.md` (zero occurrences of `E-22`).

**Most likely cause:** `ADR-0011` moved `BC-10` and extended `E-21`'s consumer list; `E-22` was missed. The
benign reading is almost certainly correct — and *"almost certainly"* is the standard §7 exists to refuse.

**Recommended disposition:** a one-line ADR adding `BC-10` to `E-22`. Low cost, and it closes a gap that would
otherwise be discovered by a developer implementing `IMPL-212` and finding no lawful edge.

---

## 4. Requirements with no owning PRD

### `PGA-03` — Trust & Safety is a Critical risk mitigation with no specification

**Severity: Critical** · **Status: open**

| Evidence | Source |
|---|---|
| `MP-RSK-02` *"Minor-safety incident on the social product"* — **Critical**, mitigation *"`BC-13` Trust & Safety at V1"* | Master PRD §28 |
| `BC-13` classified **`[CORE]`** *"despite living in a Supporting platform — on a minor-heavy product this is existential legal risk, not a commodity"* | BC Map §3.2 |
| *"T&S is `[CORE]` and, on a minor-heavy product, is existential legal risk — EA critique #8"* | Master PRD §8.1 |
| `ModerationCase` aggregate defined | BC Map aggregates table |
| `E-14` `EnforcementActionTaken` defined with four consumers | BC Map §7.2 |
| `IMPL-222` requires `PRD-003` to consume `safety.EnforcementActionTaken` | SID tasks §1.4 |

So the architecture defines the context, its aggregate, its event and its consumers. **The specification does not
exist, no task exists, and no owner is assigned.** A Critical risk whose stated mitigation is an unwritten
document is an accepted risk, not a mitigated one — and the register does not say so.

`ID-6` compounds it: *"A minor's `Account` is linked to a guardian consent record before any social context is
activated."* The gate is specified; the context that enforces the consequences is not.

### `PGA-04` — Eight capability contexts carry V1 obligations with no PRD

**Severity: High** · **Status: open**

Master PRD §8.1 lists them and states the obligation itself: they *"carry product-visible obligations but had no
module entry. Listed here so they receive requirements, budgets and owners."* They have received none of the
three.

`BC-19` · `BC-21` · `BC-23` · `BC-24` · `BC-29` · `BC-30` · `BC-31` · `BC-11`/`BC-12`/`BC-13`.

**Two are already load-bearing for frozen PRDs:**

- **`BC-29` File & Media** — `PRD-002` `LIB-6.6` requires logo/cover storage through it; `PRD-003` `SID-4.35`
  requires the profile photo through it. `PRD-002` *owns* `BC-29`, so ownership exists — **requirements do not**.
- **`BC-24` Audit Trail** — required by a global rule; `X-10` (audit-mutation check) is **not implemented** and
  therefore **unmet** per `SID-4.56`.

### `PGA-05` — Nine module PRDs named in v1.0 and never written

**Severity: High** · **Status: open**

Master PRD §31, verbatim:

> *"Student Management · Membership · Attendance · Seat · Revenue & Finance · Analytics · Notifications ·
> Security & Automation · AI Super Assistant PRDs | Listed in v1.0"*

All nine are V1 in §32's roadmap. Five own `[CORE]` bounded contexts with defined aggregates and invariants:

| PRD | Context | Aggregate | Invariant that will be lost if unspecified |
|---|---|---|---|
| `PRD-004` | `BC-01` | `StudentRecord` | Per-tenant identity; survives account deletion |
| `PRD-005` | `BC-02` | `Membership` | Cannot exist without an active enrollment (`E-01`) |
| `PRD-006` | `BC-03` | `AttendanceDay` | **Idempotent** by `studentRecordId` + date + idempotency key |
| `PRD-007` | `BC-04` | `SeatAllocation` | *"One active allocation per seat per time window (pessimistic lock / DB unique constraint — **never optimistic**)"* |
| `PRD-008` | `BC-05` | `FeeLedger` | Money student → library, never library → LIBOORA |

**`PRD-007`'s invariant is the one most likely to be lost.** It names the mechanism, not just the rule, because
optimistic locking produces a system that passes every test written by whoever chose it and double-allocates
under real concurrency. `MP-RSK-04` rates it High.

**`PRD-004` also blocks live work.** `IMPL-214` (`E-13` ACL) is recorded as *"partly blocked — a `StudentRecord`
aggregate exists, the full `BC-01` does not"*, so the ACL *"cannot be verified end to end."*

**One further V1 gap outside the nine:** `BC-20` Subscription & Billing — SaaS Billing, Master PRD §8 module 17,
V1, `Subscription` and `SubscriptionInvoice` aggregates. Registered as `PRD-022`.

---

## 5. PRDs that should be split

### `PGA-06` — `Security & Automation` must never be written as one PRD

**Severity: High** · **Status: decided by the Master PRD; recorded here so it is not undone**

Master PRD §8 Correction 2, verbatim:

> *"**Correction 2 — `Security & Automation` is two owners.** 'Security' is the SECURITY platform (R2).
> 'Automation' is Workflow Orchestration (`BC-28`, V2). A single module name spanning two owners at two ranks
> violates the Single Owner Rule (EA §10.1.1). The name is preserved; the ownership split is now explicit."*

| Half | Owner | Rank | Version |
|---|---|---|---|
| Security | SECURITY platform | R2 | V1 |
| Automation | `BC-28` Workflow Orchestration | R6 | **V2** |

Two owners, two ranks, **two different release versions**. Writing one PRD would re-create the violation the
correction removed, and would drag a V2 context into a V1 document.

**This is the only split recommended in this analysis.** It is recommended because the Master PRD already decided
it — not because splitting is generally preferable.

---

## 6. PRDs that should NOT be split — and things that should not become PRDs

The instruction to prefer *"a smaller number of clear bounded contexts over unnecessary fragmentation"* has more
consequences here than the split above.

### 6.1 `PRD-002` Library Management must stay one PRD across four files

It owns **four** contexts — `BC-19`, `BC-06`, `BC-25`, `BC-29` — which looks like a split candidate. It is not.
The four documents are already declared to be one specification: *"'The Library PRD' means all four normative
documents, never one alone. A requirement read in isolation from the other three will be implemented wrongly —
most of the security-relevant constraints are cross-references."*

Splitting by context would sever those cross-references. **File count is not document count.**

### 6.2 `PRD-001` Authentication must not split by chapter

Eleven chapters, 1,517 identifiers, one context, one precedence rank, and the document declares itself
*"self-contained"*. The chapter sources under `prd-v2/` are the same specification, not eleven of them.

### 6.3 Dashboards must not get PRDs

Master PRD §8 Correction 1 quotes the context map: *"Dashboards (Owner, Manager, Reception, Parent) are not
contexts. They are presentation compositions over read models. **They own no aggregate and no invariant.**"*

A PRD per dashboard would invite exactly the outcome the correction prevents — a team building an aggregate
behind a presentation surface. Their requirements belong to `PRD-009` Analytics and the contexts they read.

### 6.4 Library Discovery & Enrollment must not become a context

Ruling `AR-1`: *"NOT a new bounded context… it owns no aggregate, no invariant and no business state."* It is
already specified inside `PRD-002` as §14A/§14B. **The context count remains 31.**

### 6.5 `BC-11` and `BC-12` should share one PRD

Registered as a single `PRD-021`. `E-16` makes them inseparable in specification: *"`canMessage(a, b)` —
Messaging must ask; **block enforcement lives in the graph**."* Two PRDs would put a security-relevant rule and
its enforcement point in separate documents, and the tempting local implementation — Messaging keeping its own
block list — is the defect this avoids.

### 6.6 Global Student Network must not get a PRD now

`MP-FUT-01` is Future. EA §10.3: *"do not design for it now, only avoid blocking it."* `ADR-0011` already did the
not-blocking part by making `BC-10` a platform identity rather than a social profile. Writing it now would invent
requirements — the specific outcome prohibited.

---

## 7. Minor findings

| ID | Finding | Severity | Note |
|---|---|---|---|
| `PGA-07` | **`14A` has no version/status header row.** Its three sibling documents each carry one; `14A` carries a provenance comment block instead | Cosmetic | Version established externally by `DOCUMENTATION_BASELINE.md` §3.3 (v1.0). Not a defect — it is a *verbatim capture* whose format was deliberately preserved. Recorded so a future registry pass does not read it as unversioned |
| `PGA-08` | **No PRD has a named owner.** No document-owner field exists anywhere in `docs/30-product/` | Medium | See §8 |
| `PGA-09` | **Master PRD §31 lists the ADR set as `ADR-0001`…`ADR-0010`**; twelve are accepted | Low | Staleness only. `ADR-INDEX.md` is the register of record and is current |
| `PGA-10` | **`MP-DEP-06` says the boundary checker is *"not implemented"*** | Low | Superseded — `IMPL-014` exists and runs as gate 3. `IMPLEMENTATION_STATUS.md` §2 is the correction of record and already names this class of staleness |

`PGA-09` and `PGA-10` are both in the frozen Master PRD, and both are *stale statements* rather than wrong rules.
`IMPLEMENTATION_STATUS.md` already exists precisely to absorb this failure mode: *"each is correct at the moment
of writing and none is updated together."*

---

## 8. `PGA-08` — ownership, stated precisely

Two different rules are involved, and the repository satisfies one and not the other:

| Rule | Status | Evidence |
|---|---|---|
| *"Every bounded context must have explicit ownership"* | ✅ **Satisfied** | Every context has exactly one owning module; enforced mechanically by `tool/check_module_boundaries.dart` |
| *"No duplicate ownership between PRDs"* | ✅ **Satisfied** | Verified across all 31 contexts — `PRD_REGISTRY.md` §6 |
| *"Every PRD has a named owner"* | ⛔ **Not satisfied** | **No document-owner field exists** in any PRD |

The only `Owner` fields found name a bounded context (`INVITATION_SECURITY_SPECIFICATION.md` → `BC-19`) or a
library's proprietor (`LIB-6.x`). Filling in the registry's `Owner` column would require inventing names, so it
records *Unassigned* for all 22 and raises this finding instead.

---

## 9. Disposition

**No finding in this document has been acted on.** Each requires either an ADR or a decision this analysis is not
authorised to make.

| Finding | Requires | Blocking V1? |
|---|---|---|
| `PGA-01` | ADR + versioned amendment to `Library_PRD_v1.md` | No |
| `PGA-02` | One-line ADR extending `E-22` | No — but blocks clean `IMPL-212` |
| `PGA-03` | **Write `PRD-020`.** Or formally accept `MP-RSK-02` and record the acceptance | ⚠ **Yes if social ships** |
| `PGA-04` | Write `PRD-013`…`019` per the roadmap waves | **Yes** |
| `PGA-05` | Write `PRD-004`…`012`, `PRD-022` | **Yes** |
| `PGA-06` | Split into `PRD-012a` / `PRD-012b` when written | No |
| `PGA-07` | Nothing. Recorded only | No |
| `PGA-08` | A governance decision on document ownership | No |
| `PGA-09`, `PGA-10` | Nothing, or a Master PRD refresh at next version | No |

---

## 10. What this analysis deliberately did not do

- **Did not invent a single requirement.** Every missing PRD is one the repository already names.
- **Did not propose splitting any existing PRD.** The only split is one the Master PRD already mandated.
- **Did not edit a frozen document**, including the two carrying confirmed conflicts.
- **Did not resolve `PGA-01` or `PGA-02`.** Both need an ADR first — that is what freeze *means*.
- **Did not manufacture owners** to fill an empty column.

---

## 11. References

[`MASTER_PRD.md`](../../30-product/MASTER_PRD.md) §8, §8.1, §28, §31, §32 ·
[`LIBOORA_BOUNDED_CONTEXT_MAP.md`](../../10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md) §3, §7 ·
[`Library_PRD_v1.md`](../../30-product/library/Library_PRD_v1.md) §26 ·
[`LIBRARY_PRD_ALIGNMENT.md`](../../30-product/library/LIBRARY_PRD_ALIGNMENT.md) ·
[`Student_Identity_PRD_v1.md`](../../30-product/student-identity/Student_Identity_PRD_v1.md) §4.8 ·
[`STUDENT_IDENTITY_ALIGNMENT.md`](../../30-product/student-identity/STUDENT_IDENTITY_ALIGNMENT.md) ·
[`DOCUMENTATION_BASELINE.md`](../DOCUMENTATION_BASELINE.md) §6, §7 ·
[`ARCHITECTURE_RULINGS.md`](../../10-architecture/ARCHITECTURE_RULINGS.md) `AR-1` ·
[`IMPLEMENTATION_STATUS.md`](../../40-implementation/IMPLEMENTATION_STATUS.md) ·
[`PRD_REGISTRY.md`](./PRD_REGISTRY.md) ·
[`PRD_DEPENDENCY_GRAPH.md`](./PRD_DEPENDENCY_GRAPH.md) ·
[`PRODUCT_IMPLEMENTATION_ROADMAP.md`](./PRODUCT_IMPLEMENTATION_ROADMAP.md)

---

## 12. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-04 | Created. 10 findings: 18 missing PRDs, **0 duplicates**, **0 genuine overlaps**, 2 architectural conflicts, 1 mandated split, 6 cases where splitting is explicitly rejected. **`PGA-01` and `PGA-02` are new** — neither appears in `LIBRARY_PRD_ALIGNMENT.md` or `STUDENT_IDENTITY_ALIGNMENT.md`, and both were found by cross-reading documents that are individually self-consistent. Neither was fixed: both live in frozen documents and `DOCUMENTATION_BASELINE.md` §7 requires an ADR first. No requirement was invented, modified or withdrawn; no PRD was edited. |
