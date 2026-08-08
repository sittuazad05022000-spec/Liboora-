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
| **Missing PRDs** | **19** | 1 Critical · 5 High · 13 Medium |
| **Duplicate PRDs** | **0** — no requirement is specified twice | — |
| **Overlapping responsibilities** | **1 genuine finding** (`PGA-11`), spanning **3 contexts** — `BC-19`, `BC-25`, `BC-29` · 2 that look like overlaps and are not | High |
| **Missing dependencies** | **1** (`PGA-02`) | Medium |
| **Architectural conflicts** | **3** (`PGA-01`, `PGA-02`, `PGA-11`) | 1 High · 2 Medium |
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

### `PGA-11` — `BC-19` and `BC-29` are claimed by a frozen PRD and by the Master PRD's own PRD backlog

**Severity: High** · **Type: duplicate ownership** · **Status: raised, unresolved**

This is the one genuine overlap in the repository, and it is the finding this analysis most nearly missed —
because both claims are individually reasonable and neither document is wrong on its own terms.

| Claimant | Statement |
|---|---|
| `Library_PRD_v1.md` line 10 | **Owning contexts:** *"`BC-19` Tenancy · `BC-06` Library Policy · `BC-25` Configuration · `BC-29` File & Media"* |
| `MASTER_PRD.md` §8.1 | Lists `BC-19` and `BC-29` among contexts that *"carry product-visible obligations but had no module entry. Listed here so they receive requirements, budgets and owners."* |

The Master PRD is asking for PRDs covering two contexts a frozen Rank-3 PRD already declares it owns. That
directly engages the rule *"no duplicate ownership between PRDs"*.

**Three pieces of evidence indicate the Library PRD's header over-claims:**

1. **The Library PRD contradicts itself.** Its data-ownership table at line 1094 marks `BC-29` as
   **"References by id"** — while `BC-19`, `BC-06` and `BC-25` are each marked **"Owns"**. The body treats
   `BC-29` as a dependency; only the header calls it owned.
2. **`SID-4.36`** assigns upload, virus scanning, thumbnailing and signed-URL issuance to `BC-29` and forbids
   other modules re-implementing or bypassing them — the signature of a shared platform capability.
3. **The dependency ranks make library ownership impossible.** In `tool/module_dependencies.yaml`,
   `domain/library` is rank **8** and reaches `platform/tenancy:tenant_context` (rank 4) and
   `platform/services:files` (rank 3) through **ports**. A rank-8 module owning a rank-3 capability would
   invert `L2` (downward-only) and make the boundary checker's own configuration incoherent.

**Why `BC-19` is the harder half.** `BC-29` is nearly clean — the Library PRD only over-claims in its header.
`BC-19` is genuinely shared: the Library PRD's `TenantOrganisation` and `StaffAssignment` aggregates are real,
tenant-facing, and specified in detail across `LIB-6.x`. The likely correct resolution is not "`PRD-013` takes
`BC-19`" but a **split**: tenant *lifecycle, context propagation, tiers and residency* to `PRD-013`; the
library-facing organisation record to `PRD-002`. That is a boundary change and needs an ADR, not an edit.

**Why this was not caught earlier.** `LIBRARY_PRD_ALIGNMENT.md` dispositioned 14 conflicts and contains **zero**
occurrences of `BC-19`, `BC-29`, *Tenancy* or *File & Media*. The review compared the Library PRD against the
architecture; it did not compare the Library PRD's ownership header against the Master PRD's PRD backlog.

**Recommended disposition:** one ADR settling both contexts — most economically by correcting the Library PRD
header to distinguish *owns* from *consumes*, which its own body already does. **Not actionable here:**
`Library_PRD_v1.md` is frozen Rank 3, and `DOCUMENTATION_BASELINE.md` §7 requires the ADR **before** the change.

**Not blocking V1** in the sense that no code is wrong today — the boundary checker already enforces the port
relationship, so the implementation follows the correct reading regardless of what the header says. It becomes
blocking the moment someone writes `PRD-013` or `PRD-017`, because they cannot state their scope without
contradicting a frozen document.

#### Scope extension, 2026-08-04 — a **third** context, `BC-25`

The heading above names two contexts because two were all this analysis found. Investigating `PGA-11` for
[`ADR-0013`](../adr/ADR-0013-capability-context-ownership.md) found a **third on identical grounds: `BC-25`
Configuration.** The finding is recorded here rather than rewritten into the heading, because *how* it was missed
is the more useful part.

`BC-25` was invisible to this analysis because the method was **PRD-to-PRD comparison**. `BC-19` and `BC-29` are
both named in Master PRD §8.1, so each acquired a second claimant (`PRD-013`, `PRD-017`) that could be set against
the Library PRD's header. `BC-25` appears in **neither** §31's nine nor §8.1's eight, so it had exactly one PRD
claimant and looked uncontested — `PRD_REGISTRY.md` recorded it as *"Covered."* Its true collision is with
`LIBOORA_BOUNDED_CONTEXT_MAP.md` line 134, which gives its **Owning Platform** as *Configuration*
(`platform/configuration`, rank 3) — a document-to-**architecture** conflict, which this analysis was not looking
for. The same rank-8-cannot-own-rank-3 argument in evidence item 3 above applies to it unchanged.

**This makes `BC-25` the asymmetric case and the reason `ADR-0013` §7 stays open.** `BC-19` and `BC-29` can be
resolved by transfer to an already-registered PRD. `BC-25` cannot — there is no PRD to transfer it to, and
inventing one would breach *"do not invent requirements."* No `PRD-023` has been allocated.

**Revised count: 3 contested contexts** — `BC-19`, `BC-25`, `BC-29`. §8 and `PRD_REGISTRY.md` §6/§7 both carry
the revised figure.

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
V1, `Subscription` and `SubscriptionInvoice` aggregates. Named in neither §31's nine nor §8.1's eight, which is
why it is easy to miss entirely. Registered as `PRD-022` in [`PRD_REGISTRY.md`](./PRD_REGISTRY.md) §4.3.

It must not be folded into `PRD-008` Revenue & Finance. The Bounded Context Map's terminology table separates the
two at three points — `Payment`, `Plan` and `Invoice` each mean different things in `BC-05` and `BC-20` — because
`BC-05` is money **student → library** and `BC-20` is money **library → LIBOORA**. One PRD covering both would put
a library's revenue and LIBOORA's revenue in the same aggregate.

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
| ~~`PGA-08`~~ | **No PRD has a named owner.** No document-owner field exists anywhere in `docs/30-product/` | Medium | ✅ **CLOSED 2026-08-04** — resolved role-based, not by naming individuals. See §8, §8.1 |
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
| *"No duplicate ownership between PRDs"* | ⛔ **Not satisfied** — *corrected 2026-08-04* | **`PGA-11`**: `BC-19`, `BC-29` and `BC-25` are each claimed by the `Library_PRD_v1.md` header **and** by the BC Map's *"Owning Platform"* column. Resolution path: `ADR-0013` |
| *"Every PRD has an explicit owner model"* | ✅ **Satisfied** — *closed 2026-08-04* | [`PRD_OWNERSHIP_MODEL.md`](./PRD_OWNERSHIP_MODEL.md): four roles for all 23 PRDs |
| *"Every PRD has a **named** owner"* | ⛔ **Not satisfied, by design** | No personal name exists to record, and recording one would fabricate accountability. Ownership is role-based — model §1.1 |

**Row 2 was previously recorded as satisfied.** That reading came from `PRD_REGISTRY.md` §6, which listed ownership
only for PRDs that already existed — so the three contexts claimed by a *planned* PRD never appeared alongside the
Library PRD's header claim. The clean result was an artefact of the sample, not a property of the ecosystem. Corrected
here rather than left standing, because a false "satisfied" is more damaging than an open finding.

### 8.1 How `PGA-08` was closed

The original disposition read: *"filling in the registry's `Owner` column would require inventing names."* That was
correct about the constraint and wrong about the conclusion. **Document ownership never required names** — only
accountable roles, and four such roles were already in use in `ADR-0001`, `ADR-0011`, `ADR-0012` and Dependency
Matrix §11 (*"product owner"*, *"Architecture Review Board"*, *"Principal Enterprise Architect"*, *"DDD reviewer"*).

[`PRD_OWNERSHIP_MODEL.md`](./PRD_OWNERSHIP_MODEL.md) derives the four roles from six existing governance rules rather
than importing a framework, and records **roles only** — rule 7.4: *"never record a personal name."*

Assigning ownership systematically surfaced two findings that an empty column had concealed:

| # | Finding | Recorded as |
|---|---|---|
| 1 | **`PRD-012` is unassignable** under one-holder-per-role as scoped — it spans the SECURITY platform (rank 2) and `BC-28` Workflow (rank 6) | Model §4.2 note; already flagged by `PGA-06` and §4.1 as violating the Single Owner Rule |
| 2 | **`BC-25` Configuration has no registered claimant** — `PRD-015` is *Search Indexing*, so unlike `BC-19`/`BC-29` no second PRD contests the Library PRD's header | Model §4.4; `ADR-0013` §7 left deliberately open |

The second is the more consequential: it means `BC-25` cannot be resolved by transferring it, because there is nothing
to transfer it to. Creating a PRD to receive it would be inventing a requirement.

**An empty ownership field hides a conflict as effectively as a wrong one.**

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
| ~~`PGA-08`~~ | **CLOSED 2026-08-04** — [`PRD_OWNERSHIP_MODEL.md`](./PRD_OWNERSHIP_MODEL.md), role-based, 23 of 23. Surfaced two further findings (§8.1) | No |
| `PGA-09`, `PGA-10` | Nothing, or a Master PRD refresh at next version | No |
| `PGA-11` | **ADR settling `BC-19` / `BC-29` ownership**, then a versioned amendment to the `Library_PRD_v1.md` header | Not yet — **blocks `PRD-013` and `PRD-017`** |

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
| **v1.0** | 2026-08-04 | **`PGA-08` closed** by [`PRD_OWNERSHIP_MODEL.md`](./PRD_OWNERSHIP_MODEL.md) — four organizational roles for all 23 registered PRDs, derived from six existing governance rules and using vocabulary already present in `ADR-0001`/`ADR-0011`/`ADR-0012`/Matrix §11 rather than a new framework. The original disposition (*"filling in the `Owner` column would require inventing names"*) was right about the constraint and wrong about the conclusion: document ownership needs accountable **roles**, not names. §8 also **corrects a stale row of its own**: *"No duplicate ownership between PRDs"* was recorded ✅ Satisfied, which `PGA-11` contradicts — the clean reading was an artefact of `PRD_REGISTRY.md` §6 sampling only PRDs that already existed. Assigning ownership systematically surfaced two further findings (§8.1): **`PRD-012` is unassignable** under one-holder-per-role as scoped, and **`BC-25` has no registered claimant** because `PRD-015` is *Search Indexing* — so `BC-25` cannot be resolved by transfer, and `ADR-0013` §7 must stay open. No requirement was invented, modified or withdrawn; no PRD was edited. |
| **v1.0** | 2026-08-04 | Cross-reference verification, same day, before the analysis was relied on. **`PGA-11` added** — the one genuine overlap in the repository: `Library_PRD_v1.md` declares `BC-19` and `BC-29` as owning contexts while `MASTER_PRD.md` §8.1 lists both as needing PRDs, which this register carries as `PRD-013` and `PRD-017`. Found while verifying `PRD_REGISTRY.md` §6's claim of zero duplicate ownership — a claim that was true only because §6 listed ownership for existing PRDs and ignored planned ones, so the register contradicted itself two sections apart. The *"0 genuine overlaps"* headline is corrected to **1**, missing PRDs to **19** (`PRD-022` was cited by two companion documents without ever being registered), and architectural conflicts to **3**. `PGA-11` was **not fixed**: `Library_PRD_v1.md` is frozen Rank 3. No requirement was invented, modified or withdrawn; no PRD was edited. |
| **v1.0** | 2026-08-04 | Phase 4 validation consistency pass. **`PGA-11` extended from two contested contexts to three** — `BC-25` Configuration added, on grounds identical to `BC-19`/`BC-29`. The finding is recorded as a dated *scope extension* under `PGA-11` rather than folded into its heading, because the reason it was missed is itself the lesson: this analysis compared **PRD against PRD**, and `BC-25` appears in neither Master PRD §31 nor §8.1, so it had only one PRD claimant and read as uncontested. Its actual collision is with `LIBOORA_BOUNDED_CONTEXT_MAP.md` line 134 (*Owning Platform: Configuration*, rank 3) — a **document-to-architecture** conflict the method was not built to detect. §2's overlap row now reads *1 genuine finding spanning 3 contexts*, matching §8, `ADR-0013` §2 and `PRD_REGISTRY.md` §6/§7. **No finding was reclassified or closed, no requirement touched, no frozen document edited; `ADR-0013` §7 remains open and no `PRD-023` is allocated.** |
