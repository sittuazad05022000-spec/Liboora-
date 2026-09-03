<!--
  PROVENANCE — PRD-021C OWNER DECISION FORM
  =========================================
  This file is a BLANK SIGN-OFF INSTRUMENT. It is not a decision document.

  Decisions made by this file .................. ZERO
  Options selected by this file ................ ZERO
  Values proposed by this file .................. ZERO
  Open decisions resolved by this file ......... ZERO
  ADRs created by this file .................... ZERO
  Bounded contexts declared .................... ZERO
  Edges declared or amended .................... ZERO
  Domain events declared ....................... ZERO
  Metric definitions certified ................. ZERO
  Identifiers minted (FR/AC/XC/OD/CONF) ........ ZERO
  IMPL-* identifiers ........................... ZERO
  Application code touched ..................... ZERO
  Frozen or Rank 1-6 artefacts edited .......... ZERO
  Lifecycle effect ............................. NONE (not Stage 3, no freeze,
                                                 no approval, no baseline, no rank)

  Every tick-box below is DELIBERATELY EMPTY. An empty box is the correct and
  intended state of this file until a named owner fills it. Filling a box on the
  owner's behalf would be a governance violation, not a convenience.
-->

# `PRD-021C` — Owner Decision Form

**A blank sign-off instrument for the five blocking decisions of `PRD-021C` C2 and C3.**

> ⭐⭐ **Read this first.**
>
> This form **does not make, imply, recommend or rank any decision.** It exists so that
> the owners named in `PRD_OWNERSHIP_MODEL.md` can record a ruling in one place, in the
> repository, with the authority disclosed.
>
> **A form is not a decision. A tick-box is not a ruling. Signing this form is the act
> that confers authority — not authoring it.**

| Field | Value |
|---|---|
| **Document** | `PRD-021C` Owner Decision Form |
| **Version** | **v1.0** |
| **Date** | 2026-09-02 |
| **Status** | ⛔ **OPEN — PENDING OWNER DECISION** |
| **Decisions on this form** | **5** — `XPC-OD-001`, `XPC-OD-002`, `XPC-OD-003`, `XPC-OD-007A`, `XPC-OD-007B` |
| **Answered** | ⛔ **0 of 5** |
| **Subject PRD** | `PRD-021C` C0–C4 — **`DRAFT` / Stage 2** |
| **Companion** | [`PRD-021C_OWNER_DECISION_REQUEST.md`](PRD-021C_OWNER_DECISION_REQUEST.md) **v1.1** — the *evidence and execution plan*. This form is the *signature surface* for it |
| **Evidence** | ⛔ **Not restated here.** Each decision below cites the request document's section. Read the evidence there; record the ruling here |
| **Decisions made by authoring this form** | ⛔ **Zero** |
| **ADRs created by authoring this form** | ⛔ **Zero** — ADR numbers are assigned **only after** authorization |
| **Lifecycle effect** | ⛔ **None.** Stage 3 is **NOT** entered by this form |
| ⚠ **Reserved ADR numbers** | ⛔ **`ADR-0088`, `ADR-0089`, `ADR-0090`** are reserved and unwritten for `PRD-021B` (`ADR-0091` **L315**). `PRD-021C` **MUST NOT** use them. Next lawful: **`ADR-0093`+** |

---

## §0. How to use this form

| Step | Action | Who |
|---|---|---|
| 1 | Read the evidence in `PRD-021C_OWNER_DECISION_REQUEST.md` **v1.1** for the decision you hold | The named owner |
| 2 | Tick **exactly one** option box in that decision's §*n*.1 | The named owner |
| 3 | Complete the §*n*.2 sign-off block — rationale, role, date, explicit authorization | The named owner |
| 4 | For `XPC-OD-007B` options **A / B / D**, additionally complete the §5.3 metric definition fields | Product Owner |
| 5 | Commit the completed form | Anyone |
| 6 | **Then**, and only then, author the ADR that carries the ruling and amend the affected cell | Implementer, under the recorded authority |

> ⛔ **Step 6 must never precede step 3.** An amendment without a recorded ruling is an
> invented decision, however plausible it looks.

### §0.1 Rules that bind the person filling this form

| # | Rule |
|---|---|
| 1 | ⛔ **Tick one box only** per decision. Two ticks is not a ruling; it is an unresolved decision |
| 2 | ⛔ **Do not tick a box you do not hold the role for.** The role is stated on every decision |
| 3 | ⛔ **Do not record a personal name** — `PRD_OWNERSHIP_MODEL.md` **§7 rule 4**. Record the **role**, and the **source of authority** |
| 4 | ✅ **A deferral (the "defer" option) is a real, valid, recordable decision.** It is not a failure to decide |
| 5 | ⛔ **Leaving a box blank is not a deferral.** Blank = still **OPEN**. Deferral must be ticked explicitly |
| 6 | ⛔ **Do not assign an ADR number before signing.** The ADR field is filled *after* authorization |
| 7 | ⛔ **Signing this form does not confer** Stage 3, freeze, approval, baseline or rank |

### §0.2 Status index — ⛔ all OPEN

| Decision | Subject | Required owner | Blocks | Status |
|---|---|---|---|---|
| **`XPC-OD-001`** | Does `E-21` admit `BC-19` → `BC-23`? | **Architecture Owner** | C2 | ⛔ **OPEN — PENDING OWNER DECISION** |
| **`XPC-OD-002`** | The V1 `BC-23` search contract | **Product Owner + Architecture Owner** (joint) | C2 | ⛔ **OPEN — PENDING OWNER DECISION** |
| **`XPC-OD-003`** | Does `E-22` admit `BC-19` and/or `BC-25`? | **Architecture Owner** | C3 | ⛔ **OPEN — PENDING OWNER DECISION** |
| **`XPC-OD-007A`** | Profile-view producer and edge | **Architecture Owner** | C3 | ⛔ **OPEN — PENDING OWNER DECISION** |
| **`XPC-OD-007B`** | Analytics metric certification | **Product Owner** | C3 | ⛔ **OPEN — PENDING OWNER DECISION** |

⛔ **0 of 5 answered. Nothing on this form is resolved.**

---

## §1. `XPC-OD-001` — does `E-21` admit `BC-19` → `BC-23`?

| Field | Value |
|---|---|
| **Decision ID** | `XPC-OD-001` |
| **Required owner** | ⭐ **Architecture Owner** |
| **Blocks** | **C2** — `LSD-FR-001`…`LSD-FR-008` (currently authored as ⚠ conditional) |
| **Evidence** | `PRD-021C_OWNER_DECISION_REQUEST.md` **§1** |
| **Question** | May `BC-19 Tenancy` publish to `BC-23 Search Indexing` over the **existing** edge `E-21`, or is another lawful route required? |
| **Status** | ⛔ **OPEN — PENDING OWNER DECISION** |

**Measured facts** (do not re-derive; see §1 of the request document):
`E-21` is declared at `LIBOORA_BOUNDED_CONTEXT_MAP.md` **L330** with sources **`BC-01, BC-10`** only — **`BC-19` is absent**. `E-21` is **not** a wildcard-source edge (`ADR-0084` L72–76 lists the wildcard edges: `E-17`, `E-18`, `E-19`, `E-20`, `E-23`). `ADR-0083` **L315** explicitly declines to claim `E-21` supports a new consumer.

### §1.1 Select exactly one — Architecture Owner

```
[ ]  A — E-21 में BC-19 admit
        Amend the E-21 source cell (BC Map L330) to add BC-19.
        One-cell amendment, per the ADR-0016 / ADR-0055 precedent.
        BC-23 remains the sole search-index owner. Tenant index isolation preserved.
        No second search edge and no second search system is created.

[ ]  B — existing alternative edge/contract
        Route discovery indexing over an already-declared edge or contract instead of E-21.
        Owner MUST name the edge/contract in the rationale below.
        No new edge is declared.

[ ]  C — discovery indexing V1 defer
        Defer BC-19-sourced discovery indexing out of V1.
        C2's LSD-FR-001…008 remain authored but stay conditional/unreleasable.
        This is a valid, recordable decision.
```

### §1.2 Sign-off — `XPC-OD-001`

```
Selected option ............ [        ]   (A / B / C — exactly one)

Decision rationale ........................................................
...........................................................................
...........................................................................

If option B — the named existing edge/contract ............................
...........................................................................

Owner role ................. [ Architecture Owner ]
Source of authority ........ ..............................................
                             (e.g. role holder per ADR-xxxx, or direct
                              conferral disclosed in the manner of ADR-0083)
                             ⛔ Do NOT record a personal name
                                (PRD_OWNERSHIP_MODEL.md §7 rule 4)

Decision date .............. [ YYYY-MM-DD ]

Explicit authorization ..... [ ] I hold the Architecture Owner role for this
                                 decision and I authorize the option ticked above.

Applicable ADR number ...... [        ]
                             ⛔ LEAVE BLANK until authorization above is complete.
                             ⛔ MUST NOT be 0088 / 0089 / 0090 (reserved, ADR-0091 L315).
                             Next lawful: ADR-0093+
```

**Status after authoring this form: ⛔ OPEN — PENDING OWNER DECISION.**

---

## §2. `XPC-OD-002` — the V1 `BC-23` search contract

| Field | Value |
|---|---|
| **Decision ID** | `XPC-OD-002` |
| **Required owner** | ⭐ **Product Owner + Architecture Owner** — ⚠ **joint**; one signature alone does not carry this decision |
| **Blocks** | **C2** — the searchable field set and query contract |
| **Evidence** | `PRD-021C_OWNER_DECISION_REQUEST.md` **§2** |
| **Question** | What is the authoritative V1 `BC-23` search contract — which fields are indexed, and under which index class? |
| **Status** | ⛔ **OPEN — PENDING OWNER DECISION** |

**Measured facts:** `PRD-015 Search Indexing` is registered against `BC-23` as **V1 / `PLANNED`** at `PRD_REGISTRY.md` **L315**, but **no such file exists** in the repository (`find docs -iname "*PRD-015*"` → nothing). `PRD_REGISTRY.md` **L1429** states: *"⛔ Does not create `PRD-015`."* `Library_PRD_v1.md` **§14A** already exists and is **FROZEN**, and already carries discovery and public-field lists.

⚠ **Index class must be stated with this decision.** `ARCHITECTURE_RULINGS.md` `AR-3` separates the **Platform Public Discovery Index** (anonymous, no caller tenant context) from **Tenant Operational Data** (tenant key mandatory — `MP-GBR-08`, `SE-1`, `X-13`). A cross-tenant leak via a capability context is recorded as *"the single highest-severity failure mode in the entire architecture."*

### §2.1 Select exactly one — Product Owner **and** Architecture Owner jointly

```
[ ]  A — Library_PRD_v1.md §14A को V1 BC-23 contract establish
        Formally establish the existing FROZEN §14A field lists as the V1 BC-23 contract.
        PRD-015 remains PLANNED and is NOT authored.
        Requires an append-only ruling + a PRD_REGISTRY append. §14A itself is NOT edited.

[ ]  B — PRD-015 author
        Authorize authoring PRD-015 Search Indexing as a new PRD.
        ⛔ PRD-015 MUST NOT be created without this box ticked.
        Note: this opens a full PRD lifecycle (Stages 1-7) for a new document.

[ ]  C — existing alternative contract
        Establish a different already-existing artefact as the V1 BC-23 contract.
        Owner MUST name the artefact and section in the rationale below.

[ ]  D — discovery indexing V1 defer
        Defer the V1 BC-23 search contract out of V1.
        C2 search requirements remain authored but conditional/unreleasable.
```

### §2.2 Sign-off — `XPC-OD-002` (⚠ BOTH signatures required)

```
Selected option ............ [        ]   (A / B / C / D — exactly one)

Decision rationale ........................................................
...........................................................................
...........................................................................

If option C — the named existing artefact + section ......................
...........................................................................

⚠ Index class for the V1 contract (MANDATORY, AR-3):
   [ ] Platform Public Discovery Index  (anonymous; no caller tenant context)
   [ ] Tenant Operational Data          (tenant key mandatory)
   [ ] Both, with the boundary stated in the rationale above

--- Signature 1 of 2 ---
Owner role ................. [ Product Owner ]
Source of authority ........ ..............................................
Decision date .............. [ YYYY-MM-DD ]
Explicit authorization ..... [ ] I hold the Product Owner role for this
                                 decision and I authorize the option ticked above.

--- Signature 2 of 2 ---
Owner role ................. [ Architecture Owner ]
Source of authority ........ ..............................................
Decision date .............. [ YYYY-MM-DD ]
Explicit authorization ..... [ ] I hold the Architecture Owner role for this
                                 decision and I authorize the option ticked above.

⛔ This decision is NOT carried by one signature. Both blocks must be complete.

Applicable ADR number ...... [        ]
                             ⛔ LEAVE BLANK until BOTH authorizations are complete.
                             ⛔ MUST NOT be 0088 / 0089 / 0090. Next lawful: ADR-0093+
```

**Status after authoring this form: ⛔ OPEN — PENDING OWNER DECISION.**

---

## §3. `XPC-OD-003` — does `E-22` admit `BC-19` and/or `BC-25`?

| Field | Value |
|---|---|
| **Decision ID** | `XPC-OD-003` |
| **Required owner** | ⭐ **Architecture Owner** |
| **Blocks** | **C3** — `LPP-FR-014`…`LPP-FR-017` (gallery / branding media) |
| **Evidence** | `PRD-021C_OWNER_DECISION_REQUEST.md` **§3** |
| **Question** | May `BC-19 Tenancy` and/or `BC-25 Configuration` consume `BC-29 File & Media` over the **existing** edge `E-22`? |
| **Status** | ⛔ **OPEN — PENDING OWNER DECISION** |

**Measured facts:** `E-22` is declared at `LIBOORA_BOUNDED_CONTEXT_MAP.md` **L331** with consumers **`BC-01, BC-10, BC-12, BC-14`** — **`BC-19` and `BC-25` are both absent**. `BC-25` already owns *"branding values"* (**L134**). `BC-29` owns *"upload, virus scan, thumbnailing, signed URLs, storage abstraction"* (**L138**).

⭐ **The repository writes its own admission test into the `E-22` cell**, and `ADR-0055` §3 applied it per context: **does the context hold a `FileRef`?** `BC-11` and `BC-13` were *deliberately* excluded on exactly that ground. The owner should apply the same test to `BC-19` and to `BC-25` **separately**.

⚠ **No option here is measurably smaller than another.** `BC-19`-only and `BC-25`-only are structurally identical in size (one cell each). This is a **genuine discretionary architectural choice** and this form must not pre-empt it.

### §3.1 Select exactly one — Architecture Owner

```
[ ]  A — BC-19 admit
        Amend the E-22 consumer cell (BC Map L331) to add BC-19 only.
        Necessity tested for BC-19 per the ADR-0055 §3 method (does it hold a FileRef?).

[ ]  B — BC-25 admit
        Amend the E-22 consumer cell (BC Map L331) to add BC-25 only.
        Necessity tested for BC-25 per the ADR-0055 §3 method.

[ ]  C — BC-19 + BC-25 admit
        Amend the E-22 consumer cell to add both.
        ⚠ Necessity MUST be tested SEPARATELY for each context, not jointly
          (the ADR-0055 §3 requirement). Both tests must be recorded.

[ ]  D — gallery/branding V1 defer
        Defer profile gallery / branding media out of V1.
        C3's LPP-FR-014…017 remain authored but conditional/unreleasable.
```

**Binding on options A, B and C:** `BC-29` remains the **sole** media owner. ⛔ No duplicate media system, no second media edge, and no direct byte or raw-storage-path handling in the admitted context — the domain holds a `FileRef` only.

### §3.2 Sign-off — `XPC-OD-003`

```
Selected option ............ [        ]   (A / B / C / D — exactly one)

Decision rationale ........................................................
...........................................................................
...........................................................................

FileRef necessity test (ADR-0055 §3 method) — record per context:
   BC-19 holds a FileRef?  [ ] Yes   [ ] No   — reason: ....................
   BC-25 holds a FileRef?  [ ] Yes   [ ] No   — reason: ....................

Owner role ................. [ Architecture Owner ]
Source of authority ........ ..............................................
                             ⛔ Do NOT record a personal name
                                (PRD_OWNERSHIP_MODEL.md §7 rule 4)
Decision date .............. [ YYYY-MM-DD ]
Explicit authorization ..... [ ] I hold the Architecture Owner role for this
                                 decision and I authorize the option ticked above.

Applicable ADR number ...... [        ]
                             ⛔ LEAVE BLANK until authorization is complete.
                             ⛔ MUST NOT be 0088 / 0089 / 0090. Next lawful: ADR-0093+
```

**Status after authoring this form: ⛔ OPEN — PENDING OWNER DECISION.**

---

## §4. `XPC-OD-007A` — profile-view producer and edge

| Field | Value |
|---|---|
| **Decision ID** | `XPC-OD-007A` |
| **Required owner** | ⭐ **Architecture Owner** |
| **Blocks** | **C3** — `LPP-FR-030`…`LPP-FR-044`, `LPP-AC-015`…`LPP-AC-022` (👁️ Profile Views) |
| **Evidence** | `PRD-021C_OWNER_DECISION_REQUEST.md` **§4** (incl. §4.1–§4.4) |
| **Question** | By which **lawful producer and which edge** does a profile-view reach `BC-26 Analytics Read Model`? |
| **Status** | ⛔ **OPEN / BLOCKED — PENDING OWNER DECISION** |

**What C3 preserves regardless of this decision:** the **👁️ Profile Views count + trend + [View Analytics]** surface stays authored in C3 **§9A** (`LPP-FR-035`, `LPP-FR-037`, `LPP-FR-042`). C3 is **render-only**; `BC-26` remains the **sole analytics/semantic authority**. ⭐ **In no outcome is the authored specification discarded** — only its releasability changes.

### ⚠ §4.0 The measured finding — read before ticking

| Probe | Result |
|---|---|
| A profile-view / page-view domain event anywhere in the event surface (BC Map §9) | ⛔ **None** |
| Edges targeting `BC-26` | **Exactly one — `E-26`** (**L335**), and it is an **AI retrieval port**, not telemetry |
| Edges whose **source** is `BC-24 Audit Trail` | ⛔ **None. `BC-24` is never an edge source anywhere in the map** |

⛔⛔ **`BC-24 Audit Trail` → `BC-26 Analytics` is NOT assumed by this form, and must not be assumed by the reader.** `Student_Management_PRD_v1.md` **`SM-7.17`** (L840) — *"viewing is an audit concern, not a domain event"* — is **evidence only**. It is **not** an architectural decision, and the measured absence of any `BC-24` outbound edge is a direct counter-fact to reading it as one. Converting `SM-7.17` into an edge is precisely the decision this box exists to obtain.

⚠ **Consequence for option A:** on the evidence above, **no lawful existing producer + existing edge pair has been found.** Option A is retained on this form because only the Architecture Owner may rule on whether one exists — but the owner should expect to have to name it.

### §4.1 Select exactly one — Architecture Owner

```
[ ]  A — existing lawful producer + edge
        An already-declared producer and an already-declared edge carry profile views.
        ⚠ Owner MUST name BOTH the producer and the edge in the rationale below.
        ⚠ Measured: no such pair was found. Naming is mandatory, not optional.
        No amendment, no new event, no new edge.

[ ]  B — existing producer + authorized edge amendment
        An existing producer, carried over an EXISTING edge whose cell is amended.
        ⚠ Owner MUST name the producer and the exact edge/cell to amend.
        One-cell amendment via ADR. No new edge is created.

[ ]  C — explicitly authorized new event + edge
        Authorize a NEW domain event and a NEW edge into BC-26.
        ⚠ This is the only option that mints new architecture. It requires an
          explicit ADR and MUST NOT be inferred from SM-7.17 or from any
          audit-trail reasoning.
        Owner MUST state the event name and the edge in the rationale below.

[ ]  D — Profile Views V1 defer
        Defer 👁️ Profile Views out of V1.
        C3 §9A remains authored; LPP-FR-030…044 stay conditional/unreleasable.
        The specification is retained, not deleted.
```

**Binding on every option:** `BC-26` remains the sole analytics and semantic authority; `BC-26` projections stay fully rebuildable and are never a system of record (BC Map **L385**); C3 stays render-only; tenant isolation is absolute; ⛔ no duplicate analytics system.

### §4.2 Sign-off — `XPC-OD-007A`

```
Selected option ............ [        ]   (A / B / C / D — exactly one)

Decision rationale ........................................................
...........................................................................
...........................................................................

If option A — named existing producer .....................................
              named existing edge .........................................

If option B — named existing producer .....................................
              exact edge + cell to amend ..................................

If option C — new event name ..............................................
              new edge (source -> target, type) ...........................
              why no existing route suffices ..............................

⛔ Confirm: this decision does NOT rely on an assumed BC-24 -> BC-26 flow.
   [ ] Confirmed

Owner role ................. [ Architecture Owner ]
Source of authority ........ ..............................................
                             ⛔ Do NOT record a personal name
                                (PRD_OWNERSHIP_MODEL.md §7 rule 4)
Decision date .............. [ YYYY-MM-DD ]
Explicit authorization ..... [ ] I hold the Architecture Owner role for this
                                 decision and I authorize the option ticked above.

Applicable ADR number ...... [        ]
                             ⛔ LEAVE BLANK until authorization is complete.
                             ⛔ MUST NOT be 0088 / 0089 / 0090. Next lawful: ADR-0093+
```

**Status after authoring this form: ⛔ OPEN / BLOCKED — PENDING OWNER DECISION.**

---

## §5. `XPC-OD-007B` — analytics metric certification

| Field | Value |
|---|---|
| **Decision ID** | `XPC-OD-007B` |
| **Required owner** | ⭐ **Product Owner** |
| **Blocks** | **C3** — `LPP-FR-035` (Total Profile Views as a `CertifiedMetric`), `LPP-FR-037` (trend) |
| **Evidence** | `PRD-021C_OWNER_DECISION_REQUEST.md` **§5** |
| **Question** | Which profile-engagement metrics are **certified** for V1, and with what exact definitions? |
| **Status** | ⛔ **OPEN — PENDING OWNER DECISION** |

**Measured facts:** `BC-26` *"owns the metric/semantic layer"* and *"metric definitions [are] single-sourced from the semantic layer"* (BC Map **L135**, **L385**). `PRD-009 Analytics & Reports` is registered against `BC-26` as **V1 / `PLANNED`** at `PRD_REGISTRY.md` **L246**, but **no such file exists**. C3 `LPP-FR-035` requires Total Profile Views to be read **as a `CertifiedMetric`** — a metric cannot be certified by C3, only consumed by it.

⚠ **`XPC-OD-007B` is independent of `XPC-OD-007A` but not sufficient alone.** Certifying a definition does not create a producer. **Both** `007A` and `007B` must be decided before 👁️ Profile Views is releasable.

⛔ **`PRD-009` MUST NOT be created without explicit authorization**, which is not requested by this form.

### §5.1 Select exactly one — Product Owner

```
[ ]  A — ProfileViews + UniqueViewers certify
        Certify BOTH metrics for V1.
        ⚠ Complete the §5.3 definition fields for BOTH metrics.
        ⚠ UniqueViewers implies per-viewer identity handling — see the §5.2 warning.

[ ]  B — ProfileViews only certify
        Certify ProfileViews for V1. UniqueViewers stays OMITTED from V1.
        ⚠ Complete the §5.3 definition fields for ProfileViews.
        C3 must not render UniqueViewers under this option.

[ ]  C — neither certify
        Certify no profile-engagement metric for V1.
        C3's LPP-FR-035 / 037 remain authored but conditional/unreleasable.
        No §5.3 fields are required under this option.

[ ]  D — different metric definition
        Certify a different metric (or a differently-defined metric) instead.
        ⚠ Owner MUST name the metric and complete the §5.3 definition fields for it.
```

### ⚠ §5.2 Privacy interaction — disclosed, not decided here

`UniqueViewers` requires distinguishing *who* viewed a profile. `PRD_OWNERSHIP_MODEL.md` **L353** assigns *"per-viewer behavioural tracking, presence and location inference, minor-inclusive data flows, cross-context identification"* to the **Privacy Owner** — and **L509** records that **no holder is appointed** (the role was constituted by `ADR-0077`).

⚠ Therefore, if **option A** is ticked, the Product Owner should expect a **Privacy Owner dependency** to surface, and that role is currently **VACANT**. The lawful remedy is an explicit, disclosed conferral in the manner of `ADR-0083` — ⛔ **not an inference**. This form neither appoints that role nor resolves `XPC-OD-005`.

Related standing constraints, for context only: `Library_PRD_v1.md` **L1014** defers **Public Live Occupancy** to **V2** pending a privacy review, and `ARCHITECTURE_RULINGS.md` **§6** lists it under *"Explicitly deferred — do not invent."*

### §5.3 Metric definition fields — required for options **A**, **B** and **D**

> ⛔ **A metric is not certified until every field below is filled.** A partially-defined
> metric cannot be single-sourced from the semantic layer, so `LPP-FR-035` would remain
> unsatisfiable. Leave this block untouched if option **C** is ticked.

```
--- METRIC 1 ---
Metric name ................ [ ProfileViews ]  (or, option D: ...............)

Counting rule .............................................................
   (What exactly increments the count? Which surface? Owner-side views
    counted or excluded? Authenticated vs anonymous?)
...........................................................................

Uniqueness window .........................................................
   (Over what interval is a repeat view collapsed? e.g. per session,
    rolling 24h, calendar day, none)
...........................................................................

Duplicate / bot handling ..................................................
   (Crawlers, prefetch, refresh, self-views, known-bot user agents —
    excluded or counted?)
...........................................................................

Trend period ..............................................................
   (The comparison window behind C3's "+18% this week" style summary:
    period length and the baseline it compares against)
...........................................................................

Privacy / suppression rules ...............................................
   (Minimum-count suppression threshold? Any per-viewer identity retained?
    Retention period? Minor-inclusive flows? Anonymous aggregation only?)
...........................................................................

BC-26 ownership confirmed .. [ ] BC-26 is the sole authority for this metric
                                 definition, and it is single-sourced from the
                                 BC-26 semantic layer (BC Map L135 / L385).

--- METRIC 2 (only if option A ticked) ---
Metric name ................ [ UniqueViewers ]

Counting rule .............................................................
Uniqueness window .........................................................
Duplicate / bot handling ..................................................
Trend period ..............................................................
Privacy / suppression rules ...............................................
   ⚠ Per-viewer identity handling — see §5.2. Privacy Owner role is VACANT.

BC-26 ownership confirmed .. [ ] As above.
```

### §5.4 Sign-off — `XPC-OD-007B`

```
Selected option ............ [        ]   (A / B / C / D — exactly one)

Decision rationale ........................................................
...........................................................................
...........................................................................

§5.3 definition fields complete for every certified metric?
   [ ] Yes    [ ] Not applicable (option C ticked)

Owner role ................. [ Product Owner ]
Source of authority ........ ..............................................
                             ⛔ Do NOT record a personal name
                                (PRD_OWNERSHIP_MODEL.md §7 rule 4)
Decision date .............. [ YYYY-MM-DD ]
Explicit authorization ..... [ ] I hold the Product Owner role for this
                                 decision and I authorize the option ticked above.

Applicable ADR number ...... [        ]
                             ⛔ LEAVE BLANK until authorization is complete.
                             ⛔ MUST NOT be 0088 / 0089 / 0090. Next lawful: ADR-0093+
```

**Status after authoring this form: ⛔ OPEN — PENDING OWNER DECISION.**

---

## §6. ⛔ Governance guards — what this form is, and is not

| # | Guard |
|---|---|
| 1 | ⛔ **This form does not itself make decisions.** It is a blank signature surface. Authoring it changed no architecture |
| 2 | ⛔ **No decision is valid without the required owner authority.** The required role is stated on every decision. A ruling recorded by the wrong role is void |
| 3 | ⛔ **No ADR is created until authorization exists.** Every "Applicable ADR number" field is deliberately blank and is filled **after** sign-off, never before |
| 4 | ⛔ **`ADR-0088`, `ADR-0089`, `ADR-0090` MUST NOT be used** — reserved and unwritten for `PRD-021B` (`ADR-0091` **L315**). Next lawful: **`ADR-0093`+** |
| 5 | ⛔ **No frozen history is rewritten.** `PRD-021B` B0–B9 stays **FROZEN/BASELINED** at `BASELINE-2026-09-02-A`. `PRD_REGISTRY.md` is **append-only** |
| 6 | ⛔ **No duplicate bounded context, event, edge, search system, media system or analytics system.** `BC-23` remains sole search owner; `BC-29` sole media owner; `BC-26` sole analytics/semantic authority |
| 7 | ⛔ **No `IMPL-*` identifiers.** Implementation identifiers belong to a later stage and are out of scope |
| 8 | ⛔ **No application code.** No file under `lib/`, `test/`, `tool/`, `web/`, `android/` or `ios/` is touched |
| 9 | ⛔ **Stage 3 is NOT entered by this form.** Stage 3 requires a written alignment record naming every conflict and its disposition (`PRD_LIFECYCLE.md` **L88**). No such record exists for `PRD-021C`. This form is not one, and does not become one when signed |
| 10 | ⛔ **No freeze, approval, baseline or rank** is conferred, claimed or implied |
| 11 | ✅ **👁️ Profile Views remain PRESERVED in C3** — `LPP-FR-035`, `LPP-FR-037`, `LPP-FR-042` and C3 **§9A** are authored and intact — but remain **CONDITIONAL on `XPC-OD-007A` *and* `XPC-OD-007B`**. ⭐ The feature is not lost; it is **unreleasable** until both are decided |
| 12 | ⛔ **`PRD-015` is not authored and `PRD-009` is not created** by this form. Both remain `PLANNED` in `PRD_REGISTRY.md` (**L315**, **L246**) |
| 13 | ⛔ **No identifier is minted.** This form declares no `FR`, `AC`, `XC`, `XPC-OD` or `XPC-CONF` identifier. It references existing ones only |
| 14 | ⚠ **A blank box is not a deferral.** Blank means **still OPEN**. Deferral is an explicit tick (`XPC-OD-001` C, `002` D, `003` D, `007A` D, `007B` C) |

### §6.1 What a completed form does **not** authorize

Signing this form authorizes **only** the option ticked, for **only** the decision signed. It does **not** authorize: entering Stage 3 · freezing or baselining any `PRD-021C` part · creating `PRD-009` or `PRD-015` unless that specific box is ticked · declaring any new bounded context · minting `IMPL-*` identifiers · writing application code · amending any cell beyond the one named in the ticked option.

---

## §7. Completion checklist

| # | Item | State |
|---|---|---|
| 1 | `XPC-OD-001` — Architecture Owner | ⛔ **OPEN — PENDING OWNER DECISION** |
| 2 | `XPC-OD-002` — Product **+** Architecture Owner (joint, 2 signatures) | ⛔ **OPEN — PENDING OWNER DECISION** |
| 3 | `XPC-OD-003` — Architecture Owner | ⛔ **OPEN — PENDING OWNER DECISION** |
| 4 | `XPC-OD-007A` — Architecture Owner | ⛔ **OPEN / BLOCKED — PENDING OWNER DECISION** |
| 5 | `XPC-OD-007B` — Product Owner (+ §5.3 fields) | ⛔ **OPEN — PENDING OWNER DECISION** |
| — | **Answered** | ⛔ **0 of 5** |
| — | **ADRs created** | ⛔ **0** (81 on disk, unchanged) |
| — | **Cells amended** | ⛔ **0** |
| — | `PRD-021C` lifecycle | **`DRAFT` / Stage 2** — unchanged |

### §7.1 Non-blocking decisions — disclosed, not on this form

`XPC-OD-004` and `XPC-OD-006` (Architecture Owner) and `XPC-OD-005` (**Privacy Owner — ⚠ role VACANT**, `PRD_OWNERSHIP_MODEL.md` **L509**) remain **OPEN** but are **not V1-blocking** and are therefore not carried by this form. They are recorded in `PRD-021C_OWNER_DECISION_REQUEST.md` **§6**.

---

## §8. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-02 | ⭐ **Created** as a blank owner sign-off instrument for the five blocking decisions of `PRD-021C` C2/C3 — `XPC-OD-001`, `002`, `003`, `007A`, `007B`. Each decision carries its required owner role, its measured evidence pointer, its explicit option set, and a sign-off block with selected option, rationale, owner role, source of authority, date, explicit authorization and an ADR field that is **deliberately blank until authorization**. `XPC-OD-002` requires **two** signatures. `XPC-OD-007B` adds the five metric-definition fields (counting rule, uniqueness window, duplicate/bot handling, trend period, privacy/suppression rules) for options A/B/D. ⛔ **0 decisions made · 0 options selected · 0 ADRs created · 0 identifiers minted · 0 cells amended · 0 code changed.** All five remain **OPEN — PENDING OWNER DECISION**; lifecycle unchanged at **`DRAFT` / Stage 2**; Stage 3 **NOT** entered |

---

> ⭐⭐ **Closing statement.**
>
> Every tick-box in this document is empty, and that is the **correct** state. The form was
> authored to be signed by named owners — not to be filled in by its author.
>
> **Authoring a decision form is not making a decision. `XPC-OD-001`, `XPC-OD-002`,
> `XPC-OD-003`, `XPC-OD-007A` and `XPC-OD-007B` all remain ⛔ OPEN — PENDING OWNER DECISION.**
