<!--
  PRD-021C — OWNER DECISION REQUEST
  ==================================================================
  PROVENANCE AND LIMITS OF THIS DOCUMENT
    - This is a REQUEST document, not a decision document.
      Requesting a decision is not making one.
    - Decisions made here ................ ZERO
    - Values proposed here ............... ZERO
    - Open decisions resolved here ....... ZERO
    - ADRs created by this document ...... ZERO
    - Architecture edges/events/contexts/
      metric definitions created ......... ZERO
    - IMPL-* identifiers minted .......... ZERO
    - FROZEN or Rank 1-6 artefacts edited  ZERO
    - Lifecycle effect .................. NONE. PRD-021C stays DRAFT / Stage 2.
      Stage 3 is NOT entered, NOT claimed, NOT passed.
  CONVENTION
    Follows the Pack -> Request pattern established by
    PRD-006_ATT-GAP-017_OWNER_DECISION_REQUEST.md and
    PRD-021A_OWNER_DECISION_REQUEST.md.
  MEASURED BASIS
    Authority audit at HEAD d76d4138ab52bedcef720722a3b21d3e58e9a2cb:
    81 ADRs exist in docs/00-governance/adr/; ZERO mention PRD-021C,
    XPC-OD or XPC-CONF. No owner decision record exists for PRD-021C.
    Therefore NO open decision could be executed, and none was.
  ==================================================================
-->

# `PRD-021C` — Owner Decision Request

> ⚠⚠ **READ THIS FIRST.** This document **makes no decision**. It records a
> measured **authority audit** which found that **no owner ruling exists** for
> any `PRD-021C` open decision, and it routes each blocking question to its
> named owner with the exact wording that owner must answer.
>
> ⛔ **Nothing below closes, resolves, softens or pre-answers any decision.**
> Where an option is listed, it is listed because the **repository** already
> establishes it — never because this document prefers it.

| Field | Value |
|---|---|
| **Document** | `PRD-021C` Owner Decision Request |
| **Version** | **v1.1** — ⛔ **STILL UNANSWERED.** No request in this document has received an owner ruling. v1.1 adds the **execution plan** (§9) — the exact ADR, artefact, cell, smallest-compatible option and deferral impact per blocker — so that each decision is executable the moment authority is recorded |
| **Date** | 2026-09-02 |
| **Status** | **OPEN** — awaiting Architecture Owner, Product Owner and a Governance role-appointment act |
| **Scope** | The **4 blocking** open decisions of `PRD-021C` C2 and C3, plus **3 disclosed non-blockers** |
| **Subject PRD** | `PRD-021C` C0–C4 — **`DRAFT` / Stage 2** |
| **Source** | `PRD-021C_C0_..._v0.1.md` §5/§6 · C2 · C3 · `PRD-021C_MEMORY_AND_CONTINUATION_RECORD.md` — sole sources |
| **Convention** | The Pack → Request pattern of [`PRD-006_ATT-GAP-017_OWNER_DECISION_REQUEST.md`](../attendance-management/PRD-006_ATT-GAP-017_OWNER_DECISION_REQUEST.md) and [`PRD-021A_OWNER_DECISION_REQUEST.md`](../social-graph/PRD-021A_OWNER_DECISION_REQUEST.md) |
| **Decisions made here** | ⛔ **Zero** |
| **Values proposed here** | ⛔ **Zero** |
| **Open decisions resolved here** | ⛔ **Zero** — `XPC-OD-001`…`XPC-OD-007` all remain **OPEN** |
| **ADRs created here** | ⛔ **Zero** |
| **Lifecycle effect** | ⛔ **None.** Not Stage 3. No freeze, approval, baseline or rank |
| **Answered** | ⛔ **0 of 7** — sign-off block §9.5 **UNSIGNED** |
| **Execution plan** | ✅ **§9** — exact ADR, artefact, cell, smallest-compatible option and deferral impact per blocker. ⛔ **Not executed** |
| ⚠ **ADR numbers** | ⛔ **`ADR-0088`/`0089`/`0090` are RESERVED** for `PRD-021B` (`ADR-0091` **L315**) and MUST NOT be used. Next lawful: **`ADR-0093`+** (§9.1) |

---

## §0. ⭐ The authority audit — why nothing was executed

An attempt was made to **formally resolve** `XPC-OD-001`, `XPC-OD-002`,
`XPC-OD-003`, `XPC-OD-007A` and `XPC-OD-007B` on the express condition that the
owner *"has authorized"* each act. That condition was tested by measurement
before any file was touched. **It is not met for any of the five.**

| Probe | Command | Measured result |
|---|---|---|
| ADR corpus size | `ls docs/00-governance/adr/ADR-*.md \| wc -l` | **81** |
| ADRs naming `PRD-021C` / `XPC-OD` / `XPC-CONF` | `grep -rl "PRD-021C\|XPC-OD\|XPC-CONF" docs/00-governance/adr/ \| wc -l` | ⛔ **0** |
| Owner **decision record** for `PRD-021C` | `find docs -iname "*OWNER*DECISION*" -o -iname "*RULING*"` | ⛔ **none for `PRD-021C`** |
| Stage 3 alignment record for `PRD-021C` | `find docs -iname "*ALIGNMENT*"` | ⛔ **none for `PRD-021C`** |
| Registry's standing statement | `PRD_REGISTRY.md` **L1419** | *"⛔ **Resolves none of `XPC-OD-001`…`XPC-OD-006`.** All six stay **OPEN** against named owner roles"* |

> ⭐ **The repository does not merely lack an authorization — it affirmatively
> records the opposite.** `PRD_REGISTRY.md` **L1419** and **L1353** both state
> the decisions are **OPEN**. Executing an amendment against that would not be
> "following authority"; it would be **contradicting** the only written record
> that exists.

**Precedent for how authority is evidenced in this repository.** `ADR-0083` and
`ADR-0091` each executed owner rulings, and each names its deciders in a
**Deciders** field, disclosing the source of authority in terms — including,
where a role was VACANT, *"filled for this act only by **direct conferral from
the human principal of this engagement**"*, with the conferral **stated
expressly**. ⛔ **No comparable conferral exists for any `PRD-021C` decision.**
An instruction of the form *"if the owner has authorized it, then do X"* is a
**conditional**, not a ruling; the condition is measurably false, so `X` must not
be performed.

⚠ **This is the `ADR-0081`/`ADR-0082` situation exactly.** Those passes refused
to resolve `PRD-021A` items *"for want of an owner"*, and `ADR-0083` **L21**
later records that their refusals **"were correct *for want of an owner*, and an
owner has now ruled."** The refusal below is of the same kind, and is expected to
be superseded the same way — **by a ruling, not by an inference.**

### §0.1 Outcome index

| § | Decision | Owner | V1 blocking | Status |
|---|---|---|---|---|
| §1 | `XPC-OD-001` — `E-21` admit `BC-19`? | **Architecture Owner** | ⛔ **BLOCKS C2** | ⛔ **OPEN — no authority found** |
| §2 | `XPC-OD-002` — `BC-23` V1 contract | **Product + Architecture Owner** | ⛔ **BLOCKS C2** | ⛔ **OPEN — no authority found** |
| §3 | `XPC-OD-003` — `E-22` admit `BC-19`/`BC-25`? | **Architecture Owner** | ⛔ **BLOCKS C3** | ⛔ **OPEN — no authority found** |
| §4 | `XPC-OD-007A` — profile-view producer + edge | **Architecture Owner** | ⛔ **BLOCKS C3 §9A** | ⛔ **OPEN/BLOCKED — and no lawful existing route exists (§4.2)** |
| §5 | `XPC-OD-007B` — metric certification | **Product Owner** | ⛔ **BLOCKS C3 §9A** | ⛔ **OPEN — no authority found** |
| §6 | `XPC-OD-004` — `E-24` admit `BC-04`? | **Architecture Owner** | ✅ Non-blocking | ⛔ OPEN — deferred, disclosed |
| §6 | `XPC-OD-005` — privacy review | **Privacy Owner** ⚠ VACANT | ✅ Non-blocking | ⛔ OPEN — **role appointment** required |
| §6 | `XPC-OD-006` — EA refresh | **Architecture Owner** | ✅ Non-blocking | ⛔ OPEN — optional |

**Answered: 0 of 7.**

---

## §1. `XPC-OD-001` — does `E-21` admit `BC-19`? ⛔ OPEN

**Exact question.** Does `E-21`'s **source** cell admit **`BC-19` Tenancy**, so
the `TenantOrganisation` record may be projected into `BC-23` Search Indexing for
public library discovery?

**Required authority.** **Architecture Owner**, recorded in an ADR that amends
**one cell** — BC Map **L330** — per the `ADR-0016`/`ADR-0055` pattern.

**Measured evidence.**

| Reference | Content |
|---|---|
| BC Map **L330** | `\| E-21 \| BC-01, BC-10 \| BC-23 Search Indexing \| PL \| Event \| *Created/Updated/Deleted → index. Search never reads domain tables \|` — ⛔ **`BC-19` absent** |
| BC Map **L128** | `BC-19` **Tenancy**, `[GENERIC]`, Shared Core, V1 — owns the tenant (library organisation) record |
| BC Map **L132** | `BC-23` **Search Indexing**, `[GENERIC]`, V1 — indices, permission-aware indexing, tenant index isolation |
| `MASTER_PRD.md` **L171** | Module 19, **Rank 1**, **V1** — *"Composition over `BC-19`, `BC-25`, `BC-29`, `BC-06`, `BC-02`, `BC-04`, **projected via `BC-23`**"*, *"not a context"* |
| `ADR-0084` **L23–24, L74–76** | Wildcard-source edges are **`E-17`, `E-18`, `E-19`, `E-20`, `E-23`**. ⛔ **`E-21` is not one** — the wildcard shortcut was tested and **failed** |
| `ADR-0083` §4.5 **AO-9**, **L315** | *"Search → use `E-21` **only if** it supports `BC-15` without a new protocol; otherwise record the amendment explicitly"* → *"⛔ Does not claim `E-21` supports community search"* |
| `ADR-0016` / `ADR-0055` | ⭐ Precedent **form**: one-cell consumer-list amendment, necessity tested per context (`ADR-0055` §3) |

⚠ **Measured this pass:** **no edge anywhere in the BC Map has `BC-19` as a
source.** So no alternative existing carrier is available to name.

**Affected part / blocking.** **C2** — `LSD-FR-001`…`LSD-FR-008` (**8 FR**) ⚠ CONDITIONAL.

**Options the repository establishes.** **A** amend `E-21` L330 to add `BC-19` by
ADR · **B** name a different existing edge that carries the tenant record into
`BC-23` *(⚠ measurement found none)* · **C** rule V1 discovery is not index-fed
*(⚠ must reconcile with Rank 1 L171)*.

⛔ **No option recommended.** The repository establishes the **form** of the
amendment but contains **no ruling on whether `BC-19` qualifies**.

**Exact decision to record.** *"`E-21`'s source cell **does / does not** admit
`BC-19`. If it does: ADR-nnnn, amending BC Map L330 only, necessity for `BC-19`
tested per `ADR-0055` §3. If it does not: the carrying edge is `E-___`, **or**
V1 public discovery is not index-fed."*

---

## §2. `XPC-OD-002` — the V1 `BC-23` contract ⛔ OPEN

**Exact question.** Is **`Library_PRD_v1.md` §14A** formally established as the
**V1 `BC-23` discovery/query contract** (with `PRD-015` left `PLANNED`), or is
`PRD-015` authored?

**Required authority.** **Product Owner + Architecture Owner**, jointly.

**Measured evidence.**

| Reference | Content |
|---|---|
| `PRD_REGISTRY.md` **L315** | `\| PRD-015 \| Search Indexing \| **BC-23** \| [GENERIC] \| V1 \| PLANNED \| Permission-aware, tenant-partitioned search \|` |
| Filesystem | ⚠ **`PRD-015` is ABSENT.** `find docs -iname "*PRD-015*"` → **nothing** |
| BC Map **L132** | `BC-23` owns indices, permission-aware indexing, tenant index isolation, relevance, query rewriting |
| `Library_PRD_v1.md` **§14A** | **FROZEN.** Already owns the discovery filter/capability list; `XPC-CONF-003` resolved that C2/C3 **consume and cite** §14A and add no public field |
| `AR-3` / BC Map §11.1 | Two index classes — **Platform Public Discovery Index** (anonymous, no caller tenant context) vs **Tenant Operational Data** (tenant key mandatory — `MP-GBR-08`, `SE-1`, `X-13`). *"The single highest-severity failure mode in the entire architecture is a cross-tenant data leak via a capability context"* |
| `PRD_REGISTRY.md` **L1429** | *"⛔ **Does not create `PRD-015`.** `BC-23`'s registered owner remains `PLANNED` … which is exactly why `XPC-OD-002` is **OPEN**"* |

⛔ **`PRD-015` was NOT authored by this pass**, per instruction and per L1429.

**Affected part / blocking.** **C2** — the provider contract for all 32 FR.

**Options.** **A** author `PRD-015` *(consumes no new number)* · **B** formally
establish **§14A** as the V1 `BC-23` contract, `PRD-015` deferred · **C** name
another existing owner document *(⚠ none located)* · **D** rule index-fed
discovery is not V1.

⚠ **Observation about cost, not a ruling:** Option **B** is the smallest
compatible act because §14A **already exists and is FROZEN**. ⛔ The owners are
free to reject it; this document does **not** choose.

**Exact decision to record.** *"The V1 `BC-23` query contract for library
discovery is specified by ☐ `PRD-015` (to be authored) ☐ `Library_PRD_v1.md`
§14A, formally established, `PRD-015` deferred to V___ ☐ other: ______
☐ index-fed discovery is not V1. **Mandatory in every case:** the index class
serving public library discovery is ☐ Platform Public Discovery Index ☐ Tenant
Operational Data (`AR-3` / BC Map §11.1)."*

---

## §3. `XPC-OD-003` — does `E-22` admit `BC-19` and/or `BC-25`? ⛔ OPEN

**Exact question.** Does `E-22`'s **consumer** list admit **`BC-19`** and/or
**`BC-25`**, so public gallery and branding media may be served to the library
public profile as a **`FileRef`**?

**Required authority.** **Architecture Owner**, one-cell ADR amendment of BC Map
**L331**, necessity tested **per context**.

**Measured evidence.**

| Reference | Content |
|---|---|
| BC Map **L331** | `E-22` consumers `BC-01, BC-10, BC-12, BC-14` → `BC-29`, `CF`, Sync port. *"Domain holds a `FileRef`, never bytes or a raw storage path. `BC-10` added by `ADR-0016`… `BC-12` added by `ADR-0055`… **`BC-11` and `BC-13` are deliberately NOT consumers** — `ADR-0055` §3 tested necessity per context: `BC-11` answers eligibility as a boolean and never holds a `FileRef`; `BC-13` reaches this context outbound by `E-14`"* — ⛔ **`BC-19`/`BC-25` absent** |
| ⭐ | **The test is already written into the cell:** does the candidate context **hold a `FileRef`**? Two contexts were admitted by ADR; two were **refused** on this test |
| BC Map **L134** | `BC-25` **Configuration** — settings hierarchy, feature flags, **branding *values***, secret ***references*** |
| BC Map **L138** | `BC-29` **File & Media** — upload, virus scan, thumbnailing, signed URLs, storage abstraction. ⭐ **Remains the sole media infrastructure owner** |
| BC Map **L128** | `BC-19` **Tenancy** — owns the tenant record |

⛔ **`BC-29` stays the media owner. No duplicate media system, BC or event is
created or proposed.**

**Affected part / blocking.** **C3** §6 — `LPP-FR-014`…`LPP-FR-017` (**4 FR**) ⚠ CONDITIONAL.

**Options.** **A** admit `BC-19` only · **B** admit `BC-25` only *(⚠ owner must
say whether "branding **values**" extends to a `FileRef`)* · **C** admit both,
necessity tested separately · **D** admit neither → `LPP-FR-014`…`017`
withdrawn *(⚠ reconcile with `AR-1` "Gallery → `BC-29`")*.

⛔ **No option recommended.** The repository supplies the **test**, not the
**answer**.

**Exact decision to record.** *"`E-22` **does / does not** admit `BC-19`;
**does / does not** admit `BC-25`. Necessity tested per context per `ADR-0055`
§3, reasoning recorded. ADR-nnnn amends BC Map L331 only."*

---

## §4. `XPC-OD-007A` — profile-view producer and edge ⛔ OPEN / BLOCKED

**Exact question.** **Which** bounded context lawfully **produces** the
profile-view fact, and over **which declared edge** does that fact reach
**`BC-26`** Analytics Read Model?

**Required authority.** **Architecture Owner**.

### §4.1 What C3 preserves regardless of this decision

⭐ The Owner Profile Engagement Summary **is authored and preserved** in C3 §9A
(8 subsections, `LPP-FR-029`…`044`, `LPP-AC-015`…`022`) — measured present at
HEAD:

- **`LPP-FR-035`** — *"Total Profile Views **MUST** be read as a `CertifiedMetric`"* → renders **👁️ 1.2K Profile Views**
- **`LPP-FR-037`** — *"The period/trend summary (e.g. **"+18% this week"**) **MUST**…"*
- **`LPP-FR-042`** — *"The **View Analytics** CTA **MUST** hand off to the analytics [capability]"* → **[View Analytics]**

⛔ **C3 calculates nothing** (`LPP-FR-038`, `LPP-XC-013`). What is missing is not
the *presentation* — it is the **lawful source of the fact**.

### §4.2 ⭐ The measured finding: NO lawful existing producer + existing edge exists

The instruction was to *"first determine whether a lawful existing producer +
existing edge exists."* **It was determined. It does not.**

| Probe | Command | Result |
|---|---|---|
| View event for **any** aggregate | BC Map §9 event surface **L395–435** | ⛔ **NONE.** Convention `<Context>.<Aggregate><PastTenseVerb>` is binding; every catalogued producer owns an aggregate |
| Edges with **`BC-26` as target** | `grep -nE "^\| E-[0-9]+ \|[^\|]*\|[^\|]*BC-26"` | ⛔ **Exactly one — `E-26`** (**L335**): `BC-27 AI → BC-26 Analytics, BC-23 Search`, `CF`, Sync port, *"AI retrieves through permission-aware ports only"* — an **AI retrieval port**, ⛔ **not a telemetry ingress** |
| Edges with **`BC-24` as source** | `grep -nE "^\| E-[0-9]+ \| [^\|]*BC-24"` | ⛔ **NONE. `BC-24` is never an edge SOURCE anywhere in the map** |
| C3 as producer | C3 `LPP-XC-001`, `LPP-XC-003` | ⛔ C3 owns **no aggregate** and **cannot emit events** |

⭐ **Conclusion — a measurement, not a decision:** there is **no existing
producer/edge pair** that can lawfully deliver a profile-view fact to `BC-26`.
Option "reuse an existing route" is therefore **not available**, and this is
reported rather than worked around.

### §4.3 ⚠ `BC-24` is NOT treated as an analytics source

Per instruction, **`BC-24` Audit Trail is NOT automatically assumed to be a
`BC-26` analytics source.** Evidence is presented neutrally and **not converted
into a decision**:

- `Student_Management_PRD_v1.md` **L840** (`SM-7.17`), verbatim: *"`StudentViewed` is deliberately absent — viewing is an **audit** concern (§8.3), not [a domain event]"*
- BC Map **L133**: `BC-24` owns *"the immutable append-only record of who did what"*
- BC Map **L329**: `E-20` — `All contexts → BC-24 Audit Trail`, `PL`, *"Event (fire-and-forget, outbox-backed)"*, *"Domain never calls audit synchronously"*
- ⛔ **Measured counter-fact:** `BC-24` is **never an edge source**, so even if an audit record existed, **no declared edge carries it onward to `BC-26`**
- ⛔ **Blocking invariant:** BC Map **L385** — *"metric definitions **single-sourced from the semantic layer**"*. Whether an audit record may lawfully **source** a `CertifiedMetric` is an **unanswered architectural question**, not a detail

> ⭐ **`SM-7.17` shows the repository has faced this question class and chose
> audit over a domain event. It does NOT state that audit may feed analytics,
> and it does not concern a library public profile. Converting it into a ruling
> would be inventing an architecture decision.** It is evidence only.

### §4.4 The refusals honoured

⛔ **No event minted** — `library.ProfileViewed` appears in the repository
**only inside a refusal sentence** (C3 **L435**). ⛔ **No edge minted** —
`LPP-XC-014`. ⛔ **`E-27` is permanently vacant** (withdrawn by `ADR-0033`) and
is **not** a free slot.

**Affected part / blocking.** **C3 §9A** — `LPP-FR-030`…`044` (**15 FR**) +
`LPP-AC-015`…`022` (**8 AC**).

**Options (candidate shapes the evidence raises — ⚠ NOT a repository-established closed set).**
**A** existing producer over an existing edge — ⛔ **measurement shows this is
unavailable** · **B** existing producer over a **one-cell amended** edge (edge
count stays **28**) · **C** new event **and** new edge — ⚠ largest change; only
if **explicitly** authorized · **D** rule profile-view counting is **not V1** →
C3 §9A withdrawn/deferred, position 7 stays a reserved empty slot.

⛔ **No option recommended. The producer is NOT named here.**

**Exact decision to record.** *"The profile-view fact is produced by `BC-___`
and reaches `BC-26` over edge `E-___` (☐ exists as written ☐ amended by
ADR-nnnn ☐ newly declared by ADR-nnnn). **If an audit-based route is chosen,
state expressly whether a `BC-24` audit record may lawfully source a
`CertifiedMetric` of `BC-26` under BC Map L385 — and which edge carries it,
given `BC-24` is currently never an edge source.** ⛔ **OR** profile-view
counting is not V1 and C3 §9A is ☐ withdrawn ☐ deferred to V___."*

---

## §5. `XPC-OD-007B` — analytics certification ⛔ OPEN

**Exact question.** Does **`PRD-009` Analytics & Reports** certify
**`ProfileViews`** and **`UniqueViewers`** as **`CertifiedMetric`s of `BC-26`**?

**Required authority.** **Product Owner**.

**Measured evidence.**

| Reference | Content |
|---|---|
| BC Map **L135** | `BC-26` **Analytics Read Model**, `[GENERIC]`, V1 — *"Owns the **metric/semantic layer**, read-model store, projections, reports, exports"* ⭐ **retained as the analytics semantic/read-model authority** |
| BC Map **L385** | `BC-26` owns `Projection` / **`CertifiedMetric`**, **`ReadModel`** — *"Fully rebuildable from the event log; no projection is a system of record; **metric definitions single-sourced from the semantic layer**"* |
| `PRD_REGISTRY.md` **L246** | `\| PRD-009 \| Analytics & Reports \| **BC-26** \| [GENERIC] \| V1 \| PLANNED \| Dashboards (modules 10–12) \|` |
| Filesystem | ⚠ **`PRD-009` is ABSENT.** `find docs -iname "*PRD-009*"` → **nothing** |
| C3 `LPP-FR-038`, `LPP-XC-013` | ⛔ **C3 defines no metric semantics** — retained |
| C3 `LPP-FR-036` | ⭐ If `UniqueViewers` is not certified, C3 **OMITS it entirely** — never zero, never "unknown", never "coming soon". **The draft is pre-built for partial certification** |
| C3 `LPP-FR-044` | Degrades **without displaying zeros** |

⛔ **`PRD-009` was NOT created by this pass** — no explicit authorization exists.

**Affected part / blocking.** **C3 §9A**, jointly with §4.

**If the Product Owner certifies, the certification must state** (each is a
metric-semantic property `BC-26` owns and C3 must not invent):
**counting rule** · **duplicate/bot handling** · **uniqueness window** ·
**trend period** · **privacy/suppression rule** · **`CertifiedMetric` ownership**.

**Exact decision to record.** *"`ProfileViews` ☐ certified ☐ not certified.
`UniqueViewers` ☐ certified ☐ not certified. Certified definitions —
counting rule ______ · duplicate/bot handling ______ · uniqueness window ______
· trend period ______ · privacy/suppression rule ______ · `CertifiedMetric`
ownership ______ — recorded in ______. If `PRD-009` must be authored first, that
is Product Owner follow-up and C3 §9A stays ⚠ CONDITIONAL until it exists. If
only `ProfileViews` is certified, `UniqueViewers` is **omitted** per
`LPP-FR-036`."*

---

## §6. Non-blocking decisions — disclosed, deferred, not closed

⚠ **Non-blocking ≠ closed.** Each still requires an owner record.

| Decision | Owner | Disposition requested | Why non-blocking |
|---|---|---|---|
| **`XPC-OD-004`** — `E-24` admit `BC-04`? | Architecture Owner | **Defer.** Offline booking deferred | C4 **excludes** offline booking (`LSB-XC-010`); `XPC-CONF-011` resolved **by exclusion**. Client retry served by FROZEN `PRD-007` idempotency — `SEAT-FR-201`…`203`, `SEAT-BR-032` gate **G3**, key TTL **24h** *"fixed, not configurable"* |
| **`XPC-OD-005`** — privacy review | **Privacy Owner** ⚠ **VACANT** | **Escalate as a role appointment.** ⛔ **No V2 Public Live Occupancy design may begin** before a holder exists **and** the `LIB-24.2` review is recorded | V1 **excludes** the feature — `LIB-14B.13`, `SEAT-XC-009`, `SEAT-FR-117`; C4 title reduced, `LSB-FR-034` forbids the word "live". `ARCHITECTURE_RULINGS.md` §6: *"must not be invented"*. `PRD_OWNERSHIP_MODEL.md` **L509**: *"no holder is appointed"* |
| **`XPC-OD-006`** — EA refresh | Architecture Owner | **Optional.** Not a V1 blocker | EA is **Rank 6, descriptive** — *"must follow the PRDs, never lead them"*; `MASTER_PRD.md` **L171** is **Rank 1**. Precedence already resolves `XPC-CONF-014` |

⚠ **`XPC-OD-005` is not an Architecture or Product Owner decision.** Appointing a
Privacy Owner is a **governance act**; `PRD_OWNERSHIP_MODEL.md` §10 constitutes a
**Governance Owner**. It is **routed there**, not answered here.

---

## §7. What remains true after this document

| Claim | Value |
|---|---|
| Open decisions resolved | ⛔ **0** — `XPC-OD-001`…`XPC-OD-007` all **OPEN** |
| ADRs created | ⛔ **0** |
| Bounded contexts created | ⛔ **0** — count remains **31** |
| Integration edges created or amended | ⛔ **0** — count remains **28**, `E-27` permanently vacant |
| Published events minted | ⛔ **0** |
| Metric definitions created | ⛔ **0** — `BC-26` remains the sole metric/semantic authority |
| Search / media / analytics systems duplicated | ⛔ **0** — `BC-23` search, `BC-29` media, `BC-26` analytics all unchanged |
| `PRD-015` / `PRD-009` created | ⛔ **0** — both remain `PLANNED`, absent |
| `IMPL-*` identifiers | ⛔ **0** |
| FROZEN / Rank 1–6 artefacts amended | ⛔ **0** |
| Lifecycle | **`DRAFT` / Stage 2.** ⛔ Stage 3 **NOT** entered, **NOT** claimed, **NOT** passed |
| Stage 3 permitted | ⛔ **NO** — gate is *"a written alignment record naming every conflict and its disposition"*; **none exists** |
| C2 blockers | ⛔ **2** — `XPC-OD-001`, `XPC-OD-002` |
| C3 blockers | ⛔ **2** — `XPC-OD-003`, `XPC-OD-007` (both halves) |
| C1 blockers | ✅ **0** |
| C4 blockers | ✅ **0** |

---

## §9. ⭐ v1.1 — the execution plan, per blocker

> ⛔ **Nothing in this section is executed.** It exists so that the moment an
> owner records authority, the act is **already fully specified** and no
> interpretation is required at execution time — the `ADR-0083` discipline
> *"Record and execute them exactly as stated. Do not reinterpret them."*
>
> ⚠ **Every "smallest compatible option" below is a MEASUREMENT of which
> candidate act is structurally smallest — NOT a recommendation of which is
> correct.** The owner may select any option, including one this section marks
> larger. Smallest ≠ right.

### §9.1 ⚠ ADR number space — measured, and three numbers are RESERVED

| Fact | Measured value |
|---|---|
| ADRs on disk | **81** (`ADR-0001`…`ADR-0087`, `ADR-0091`, `ADR-0092`, with gaps) |
| ⛔ **RESERVED and unwritten** | **`ADR-0088`, `ADR-0089`, `ADR-0090`** — `ADR-0091` **L315** verifies *"`ADR-0088`/`ADR-0090` remain reserved and unwritten … ✅ 0 matches; ⛔ untouched"*. ⛔ **These MUST NOT be used for `PRD-021C`** — they are reserved for `PRD-021B`'s `FOD-1`/`FOD-2` |
| Other free numbers | `0066`–`0074`, `0093`–`0099` |
| ⭐ **Next lawful numbers for `PRD-021C`** | **`ADR-0093`** onward — the highest-number convention, avoiding all reservations |

### §9.2 The execution table

| Blocker | Smallest compatible option *(measured, not recommended)* | Exact artefact + cell to amend | Exact ADR | Authority required | ⛔ Impact if deferred |
|---|---|---|---|---|---|
| **`XPC-OD-001`** | **Option A** — admit `BC-19` to `E-21`'s source cell. Smallest because it is **one cell, one line**, and the `ADR-0016`/`ADR-0055` precedent already establishes the form. ⚠ Options B and C are **not smaller** — B requires naming an edge that measurement shows does not exist; C contradicts Rank 1 `MASTER_PRD.md` **L171** | `LIBOORA_BOUNDED_CONTEXT_MAP.md` **L330** — the `E-21` **source** cell only. ⛔ No new edge. ⛔ `BC-23` unchanged. ⛔ Tenant isolation preserved via `AR-3` + `MP-GBR-08` (the amendment carries a record into an index; it does **not** relax index isolation) | **`ADR-0093`** *(next lawful)* | **Architecture Owner** | ⛔ C2 `LSD-FR-001`…`008` (**8 FR**) stay ⚠ CONDITIONAL. C2 cannot reach Stage 3. ⚠ `MASTER_PRD.md` L171 (Rank 1, V1, *"projected via `BC-23`"*) stays **unimplementable** |
| **`XPC-OD-002`** | **Option B** — formally establish `Library_PRD_v1.md` **§14A** as the V1 `BC-23` discovery/query contract; `PRD-015` stays **`PLANNED`**. Smallest because §14A **already exists and is FROZEN** — **zero new documents**, versus authoring a full PRD. ⚠ This is your stated *"preferred smallest-compatible path"*; it still requires the owners' ruling and is **not** exercised here | An **append-only** ruling record — the ADR itself, plus an **append** to `PRD_REGISTRY.md`. ⛔ **§14A is NOT edited** (FROZEN; establishing it as the contract does not change its bytes). ⛔ **`PRD-015` NOT created.** ⛔ `PRD_REGISTRY.md` **L315** stays `PLANNED`, amended by append only (append-only rule, 366+ line citations) | **`ADR-0094`** | **Product Owner + Architecture Owner** *(joint)* | ⛔ C2 has **no specified provider** → cannot reach Stage 3 at all, independent of `XPC-OD-001`. Both C2 blockers must clear |
| **`XPC-OD-003`** | ⚠ **NO option is measurably smallest — this is a genuine discretionary choice.** `BC-19`-only and `BC-25`-only are **equal in size** (one cell each). ⭐ The repository supplies the **test**, in `E-22`'s own cell: *does the context hold a `FileRef`?* — the identical test by which `ADR-0055` §3 **admitted** `BC-10`/`BC-12` and **refused** `BC-11`/`BC-13` | `LIBOORA_BOUNDED_CONTEXT_MAP.md` **L331** — the `E-22` **consumer** cell only. ⛔ **`BC-29` remains the sole media infrastructure owner.** ⛔ No duplicate media system, BC or event | **`ADR-0095`** | **Architecture Owner** | ⛔ C3 `LPP-FR-014`…`017` (**4 FR**) stay ⚠ CONDITIONAL. The public profile carries **no gallery** in V1, against `AR-1`'s *"Gallery → `BC-29`"* |
| **`XPC-OD-007A`** | ⛔ **NO smallest option can be offered, because the cheapest option is measurably UNAVAILABLE.** Option **A** (existing producer + existing edge) **does not exist** — see §4.2. Between the remainder, **B** (amend an existing edge) is structurally smaller than **C** (mint an event *and* an edge), and **D** (defer) is smallest of all but **removes the feature**. ⛔ **Choosing between "amend", "mint" and "defer" is an act of architectural discretion this document must not perform** | ⚠ **Depends entirely on the option chosen.** B → one edge cell in BC Map §7. C → BC Map §7 **and** the §9 event surface *(⛔ `E-27` is permanently vacant per `ADR-0033` and is **not** a free slot)*. D → C3 §9A only, no Rank 4 edit at all | **`ADR-0096`** | **Architecture Owner** | ⛔ C3 §9A `LPP-FR-030`…`044` (**15 FR**) + `LPP-AC-015`…`022` (**8 AC**) stay ⚠ CONDITIONAL. **👁️ Profile Views · trend · [View Analytics] remain authored but non-renderable.** ⭐ **The feature is NOT lost — it is unreleasable** |
| **`XPC-OD-007B`** | **Certify `ProfileViews` only** is the smallest *certifying* option — C3 `LPP-FR-036` is **already built** to omit `UniqueViewers` entirely (never zero, never "unknown", never "coming soon"), so partial certification needs **no C3 edit**. ⚠ Certifying nothing is smaller still but leaves the feature blocked | The certification record named by the Product Owner. ⛔ **`PRD-009` NOT created** without explicit authorization. ⛔ `PRD_REGISTRY.md` **L246** stays `PLANNED`. ⛔ **`BC-26` remains the sole analytics semantic/read-model authority** (BC Map **L135**, **L385**); C3 defines **no** metric semantics (`LPP-FR-038`, `LPP-XC-013`) | **`ADR-0097`** *(or recorded inside `ADR-0096` if the owners rule jointly)* | **Product Owner** | ⛔ C3 §9A stays ⚠ CONDITIONAL even if `XPC-OD-007A` is decided. **Both halves are required** |

### §9.3 ⛔ Invariants that bind every option

These hold **whichever** way each decision goes, and are **not** open for trade:

| # | Invariant | Authority |
|---|---|---|
| 1 | **`BC-23`** remains the sole search/index owner. ⛔ No second search system, index or edge | BC Map **L132** |
| 2 | **`BC-29`** remains the sole media infrastructure owner. ⛔ No second media system | BC Map **L138**; `AR-1` |
| 3 | **`BC-26`** remains the sole analytics semantic/read-model authority; **metric definitions single-sourced from the semantic layer** | BC Map **L135**, **L385** |
| 4 | **C3 is render-only** — computes nothing, defines no metric semantics, owns no aggregate, emits no event | `LPP-FR-038`, `LPP-XC-001`, `LPP-XC-003`, `LPP-XC-011`…`014` |
| 5 | ⛔ **`BC-24` Audit Trail is NOT an assumed `BC-26` source.** `BC-24` is **never an edge source** anywhere in the map; `SM-7.17` is **evidence only** | §4.3; BC Map measured |
| 6 | **Tenant isolation is absolute.** Public discovery must declare its index class — Platform Public Discovery Index vs Tenant Operational Data | `AR-3` / BC Map §11.1; `MP-GBR-08`, `SE-1`, `X-13` |
| 7 | Context count stays **31**; edge count stays **28** unless an ADR **expressly** changes it. **`E-27` permanently vacant** | `ADR-0033`; C0 §9 |
| 8 | Every ADR amends **one cell of one artefact**, necessity tested **per context** | `ADR-0016`, `ADR-0055` §3 |
| 9 | ⛔ **No `IMPL-*`. No application code. No Stage 3. No freeze/approval/baseline/rank.** Lifecycle stays **`DRAFT` / Stage 2** | `PRD_LIFECYCLE.md`; your standing instruction |
| 10 | ⛔ **`ADR-0088`/`0089`/`0090` MUST NOT be used** — reserved for `PRD-021B` | `ADR-0091` **L315** |

### §9.4 ⭐ What happens to Profile Views under each `XPC-OD-007A` outcome

| Outcome | 👁️ Profile Views | Trend | [View Analytics] | C3 edit needed |
|---|---|---|---|---|
| **A / B / C** decided **and** `007B` certifies both | ✅ Renders | ✅ Renders | ✅ Renders | ⛔ **None** — `LPP-FR-035`/`037`/`042` already specify it |
| **A / B / C** decided, `007B` certifies **`ProfileViews` only** | ✅ Renders | ✅ Renders | ✅ Renders | ⛔ **None** — `LPP-FR-036` already omits `UniqueViewers` |
| **A / B / C** decided, `007B` certifies **neither** | ⛔ Blocked | ⛔ Blocked | ⛔ Blocked | ⛔ None — stays ⚠ CONDITIONAL |
| **D — defer from V1** | ⛔ Withdrawn/deferred | ⛔ | ⛔ | ⚠ C3 §9A marked deferred; **position 7 stays a reserved empty slot** (`LPP-FR-029`) |

⭐ **In no outcome is the authored specification discarded.** §9A survives as either a renderable requirement set or an explicitly deferred one.

### §9.5 Owner sign-off block — ⛔ UNSIGNED

```
XPC-OD-001  E-21 admits BC-19?        ☐ YES, ADR-____   ☐ NO   ☐ DEFER
XPC-OD-002  V1 BC-23 contract is      ☐ §14A (PRD-015 stays PLANNED), ADR-____
                                      ☐ PRD-015 authored   ☐ other ______  ☐ DEFER
            index class:              ☐ Platform Public Discovery  ☐ Tenant Operational
XPC-OD-003  E-22 admits               ☐ BC-19  ☐ BC-25  ☐ both  ☐ neither  ☐ DEFER
            FileRef test per context recorded: ______________________
XPC-OD-007A                           ☐ A existing+existing (⚠ measured unavailable)
                                      ☐ B existing producer + amended edge: BC-__ / E-__
                                      ☐ C new event + new edge (EXPLICIT authorization)
                                      ☐ D defer Profile Views from V1
XPC-OD-007B ProfileViews              ☐ certified   ☐ not certified
            UniqueViewers             ☐ certified   ☐ not certified (→ omit)
            counting rule ______  bot/duplicate ______  uniqueness window ______
            trend period ______  privacy/suppression ______  owner: BC-26

Architecture Owner ____________  Product Owner ____________  Date __________
⛔ No personal name recorded (PRD_OWNERSHIP_MODEL §7 rule 4)
⛔ Signing does NOT confer Stage 3, freeze, approval, baseline or rank.
```

**Status: ⛔ UNSIGNED. 0 of 7 answered. Execution has NOT begun.**

---

## §8. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-02 | Created after a measured authority audit found **0 of 81 ADRs** reference `PRD-021C`, and no owner decision or alignment record exists. Routes `XPC-OD-001`, `XPC-OD-002`, `XPC-OD-003`, `XPC-OD-007A`, `XPC-OD-007B` to named owners with exact wording, and discloses `XPC-OD-004`/`005`/`006` as non-blocking. ⭐ Records the measured finding that **no lawful existing producer + existing edge exists** for a profile-view fact (`BC-26` has exactly one inbound edge, `E-26`, an AI retrieval port; `BC-24` is **never** an edge source). ⛔ Resolves nothing, decides nothing, proposes no value, creates no ADR/edge/event/context/metric/`IMPL-*`, amends no FROZEN or Rank 1–6 artefact, and confers no Stage 3, freeze, approval, baseline or rank |
| **v1.1** | 2026-09-02 | ⭐ **Upgraded from a request to a decision-READY resolution package.** Adds **§9 execution plan**: per blocker, the exact artefact and cell to amend, the exact ADR number, the authority required, the measured smallest-compatible option and the impact if deferred (§9.2); the **10 invariants** binding every option (§9.3); a table of what happens to **👁️ Profile Views** under each `XPC-OD-007A` outcome (§9.4); and an owner **sign-off block** (§9.5). ⚠ Records the measured discovery that **`ADR-0088`, `ADR-0089`, `ADR-0090` are RESERVED and unwritten** for `PRD-021B` (`ADR-0091` **L315**) and **MUST NOT** be used by `PRD-021C` — the next lawful numbers are **`ADR-0093`+** (§9.1). ⚠ Records that for `XPC-OD-003` **no option is measurably smallest** and for `XPC-OD-007A` **the cheapest option is measurably unavailable** — both stated as findings rather than resolved by preference. ⛔ **Re-audited at `c892d31`: still 0 of 81 ADRs reference `PRD-021C`; no owner decision record exists.** Therefore **0 decisions executed, 0 ADRs created, 0 cells amended.** `XPC-OD-001`…`007` all remain **OPEN**; sign-off block **UNSIGNED**; lifecycle unchanged at **`DRAFT` / Stage 2** |
