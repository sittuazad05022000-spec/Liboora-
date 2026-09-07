# ADR-0096 — The profile-view fact is produced by `BC-19` Tenancy and reaches `BC-26` Analytics over new edge `E-30`

| Field | Value |
|---|---|
| **Status** | **Accepted** — 2026-09-02 |
| **Date** | 2026-09-02 |
| **Deciders** | **Architecture Owner** — the role `PRD_OWNERSHIP_MODEL.md` §2.2/§2.3 (**L85**, **L102**) assigns *"boundaries, ranks, permitted edges"*, and **L284** records as the *only* approving body for a Rank 1–5 document change. ⭐ The role is here **filled for this act only** by **direct conferral from the human principal of this engagement**, in the same manner and with the same disclosure as `ADR-0032` §5.2, `ADR-0033` §7.2, `ADR-0036` §8.2, `ADR-0080` §5, `ADR-0083`, `ADR-0091`, `ADR-0093` and `ADR-0095`. ⛔ **No ARB quorum, attendee list, sign-off date or Security review is asserted.** ⛔ **No personal name is recorded** — `PRD_OWNERSHIP_MODEL.md` §7 rule 4 |
| **Authority instrument** | `PRD-021C_OWNER_DECISION_FORM.md` §4 — decision **`XPC-OD-007A`**, option **C** (*authorize a new Profile View event **plus** a lawful edge into `BC-26`*), authorized explicitly by the human principal. ⭐ The instrument **directed a determination, not a shortcut**: the producer, event name, contract and edge were to be established from *actual ownership*, and the ADR was to **stop and report** rather than guess. §3 records that determination as measurement |
| **Amends** | `docs/10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md` (Rank 4) — **by APPEND as new §17**, the `ADR-0079` §8.5 Option A method that `ADR-0083` (§15) and `ADR-0085` (§16) both used. ⛔ **§7 is NOT edited by this ADR and §9 is NOT edited by this ADR**; §17 is a **normative extension of both**. Executed, see §8 |
| **Mints** | Edge **`E-30`** — `BC-19 Tenancy` → `BC-26 Analytics Read Model`, `PL`, Event, **V1**, and event **`tenancy.LibraryProfileViewed`**. ⭐ **`E-27` is NOT reused** (permanently vacant per `ADR-0033`; `PRD_LIFECYCLE.md` §5 rule 5 — *"Numbers are never reused, even after withdrawal"*) and `E-28`/`E-29` are already taken by `ADR-0083`, so **`E-30` is the next lawful number** |
| **Baseline** | **No baseline re-issue.** BC Map is **Rank 4**; `DOCUMENTATION_BASELINE.md` §7 step 4 moves the baseline identifier *"only when a Rank 1–3 document changes version"*. `ADR-0083` and `ADR-0085` recorded the identical exemption **for edge-minting and identifier-publishing appends to this same file** |
| **Closes** | **`XPC-OD-007A`** — the producer/edge half of `PRD-021C` C3 §9A's blocker. See §6 |
| **Does NOT close** | **`XPC-OD-007B`** — the *metric certification* half, decided separately by `ADR-0097`. `XPC-OD-004`, `XPC-OD-005`, `XPC-OD-006` — **all three remain OPEN and untouched.** ⛔ Confers **no** lifecycle stage; verifies **no** code; closes **no** acceptance criterion |
| **Related** | `ADR-0083` §4.1 and BC Map **§15.1** (the edge-minting-by-append precedent, and the `E-27`-vacancy statement) · `ADR-0079` §8.5 Option A (why append, as measurement) · `ADR-0032`/`ADR-0033` (`E-27`'s minting and withdrawal) · `ADR-0093` (`E-21` gains `BC-19`) · `ADR-0097` (the metric) · BC Map **L292**, **L128**, **L135**, **L381**, **L385**, **L397**–**L440** (§9), **L435**, **L490** · `AR-3`, `AR-7` · `PRD-021C` C3 **§9A**, `LPP-FR-030`…`LPP-FR-044`, `LPP-XC-013`, `LPP-XC-014` · `SM-7.17` (the `StudentViewed` precedent, distinguished in §3.3) |

> ✅ **ACCEPTED 2026-09-02. The migration in §8 has been executed.**
>
> ⭐ This is the **first** event minted for `LIBOORA` outside the original v1.0 surface, and the **first** edge
> minted since `E-29`. Both are done at the **minimum** size the requirement admits: **one** event, **one**
> edge, **zero** new contexts, **zero** new aggregates, **zero** new analytics authorities.

---

## 1. Context

### 1.1 The requirement, and the two things it was missing

`PRD-021C` C3 §9A specifies an **Owner Profile Engagement Summary** — 👁️ Profile Views, a trend, and a
**[View Analytics]** CTA — as a **render-only** readout. `LPP-FR-035` requires the count to be *read* as a
`CertifiedMetric` of `BC-26`; `LPP-XC-013` and `LPP-XC-014` forbid C3 from defining any metric semantic or
from emitting or routing any event.

For that readout to be lawful, two things had to exist and **neither did**:

| Missing | Measured absence |
|---|---|
| A **profile-view fact** in the event surface | `grep -niE 'Viewed\|PageView\|ProfileView\|Impression\|Visited'` against the whole BC Map → **0 matches**. The V1 surface (§9, **L397**–**L440**) contains **no** view event for **any** aggregate |
| A **lawful edge** carrying it into `BC-26` | §7.3's only edge *into* `BC-26` is **`E-26`** — `BC-27 AI → BC-26, BC-23`, `CF`, Sync port, *"AI retrieves through permission-aware ports only"*. That is a **retrieval port for AI's benefit**, not a telemetry ingress |

BC Map **L292** rules the consequence: *"If an edge is not in this table, it **does not exist** and adding it
requires an ADR."*

### 1.2 ⭐ A measured anomaly, disclosed rather than exploited

**`BC-26` already appears as a *"Primary consumer"* in roughly twenty §9 event rows** — for example
`enrollment.StudentEnrolled | BC-02, BC-23, BC-24, BC-26, BC-22` (**L405**) — **while §7 declares no edge into
`BC-26` other than `E-26`.**

⚠ **This ADR does not use that anomaly as its authority, and does not "fix" it.**

It would have been convenient to argue that since `BC-26` already consumes twenty events without a §7 edge, a
twenty-first needs no edge either. **That argument is refused**, for two reasons:

1. It would resolve a **pre-existing, unrelated inconsistency** as a side effect of a `PRD-021C` decision —
   exactly the kind of silent scope creep governance forbids.
2. It would leave the new fact resting on an *absence* rather than a *declaration*, and the authority
   instrument said **explicitly** *"a new Profile View event **+ lawful edge**"*.

⚠ The anomaly is therefore **disclosed as `GAP-BCMAP-BC26-EDGES`** — *§9 records `BC-26` as a consumer of
~20 events for which §7 declares no edge* — and **routed to the Architecture Owner as a separate question**.
⛔ **It is NOT resolved here.** `E-30` is declared on its own merits and covers **only** the profile-view fact.

---

## 2. Decision

Three things, and nothing more.

### 2.1 The event

| Field | Value |
|---|---|
| **Name** | **`tenancy.LibraryProfileViewed`** |
| **Producer** | **`BC-19` Tenancy** |
| **Primary consumer** | **`BC-26` Analytics Read Model** |
| **Purpose** | The **fact** that a library's public profile was rendered. Nothing more |
| **Release** | **V1** |
| **Carried over** | Edge **`E-30`** |

**The name is derived, not chosen.** §9's convention is **binding**:
*"`<Context>.<Aggregate><PastTenseVerb>` — e.g. `membership.MembershipRenewed`. Events are facts about the
past."* Applying it mechanically: context prefix **`tenancy`** (`BC-19`'s existing prefix, **L435**);
the aggregate is `BC-19`'s **`Tenant`** (**L381**), named in its published form as the **library profile**
that §14A.5 specifies; past-tense verb **`Viewed`**. ⛔ No imperative form (`TrackView`, `RecordProfileView`)
is admissible — §9 rules a command *"must not enter the event bus as a domain event."*

### 2.2 The edge

| # | Upstream (provider) | Downstream (consumer) | Pattern | Mechanism | Release | Contract |
|---|---|---|---|---|---|---|
| **`E-30`** | BC-19 Tenancy | BC-26 Analytics Read Model | `PL` | Event | **V1** | `tenancy.LibraryProfileViewed` — see §4 for the payload boundary |

`PL` + Event is the **existing shape** for a fact travelling into a capability context: `E-20` (`→ BC-24`),
`E-21` (`→ BC-23`) and `E-23` (`→ BC-22`) are all `PL` + Event. ⭐ **No new pattern is introduced.**

### 2.3 The method of amendment

The edge and the event are declared in a **new appended §17**. ⛔ **§7 and §9 are not edited.** This is the
`ADR-0079` §8.5 Option A method, restated as measurement in §15's own preamble: inserting a row after `E-26`
would have shifted *"**1,293** of those citations, several inside **FROZEN** Rank 3 documents. Appending
shifts **zero**."* §15 and §16 both used it. §17 is the third instance.

---

## 3. ⭐ The producer determination — measured, not assumed

The authority instrument required checks before the event could be created. Each is answered below with its
measured source. ⭐ **This section is the substance of the ADR.** Had any check failed to resolve from
repository evidence, the instrument required a **stop-and-report**; none did.

### 3.1 Candidates enumerated and tested

| Candidate producer | Verdict | Measured reason |
|---|---|---|
| **`BC-19` Tenancy** | ✅ **SELECTED** | See §3.2 |
| `BC-24` Audit Trail | ⛔ **REJECTED** | See §3.3 — and the instrument independently forbade it absent a documented requirement |
| `BC-27` AI (via `E-26`) | ⛔ **REJECTED** | See §3.4 — and the instrument independently forbade reusing `E-26` as telemetry |
| `PRD-021C` C3 itself | ⛔ **REJECTED** | C3 is *"NOT a bounded context"* (`AR-1`, module 19 *"not a context"*); owns no aggregate (`LPP-XC-001`); already forbidden from emitting any event (`LPP-XC-003`, `LPP-XC-014`) |
| `BC-23` Search Indexing | ⛔ **REJECTED** | Owns *"indices, permission-aware indexing… relevance, query rewriting"* (**L132**). A profile **view** is not a search event, and `BC-23` owns no profile |
| `BC-18` Identity & Access | ⛔ **REJECTED** | Owns *"credentials, sessions, devices, OTP, roles, permissions, policy decisions, consent"*. ⭐ Decisive: the public profile is readable **without authentication** (`LPP-FR-004`, §14A.8), so `BC-18` is **not even in the path** for the majority of views |
| `BC-26` Analytics itself | ⛔ **REJECTED** | Would make the read model the source of its own input. Its invariant forbids it: *"Fully rebuildable from the event log; **no projection is a system of record**"* (**L385**). This is precisely the *"analytics-derived duplicate"* the instrument prohibited |
| A **new** bounded context | ⛔ **REJECTED** | Would take the count from 31 to 32 to carry one fact. ⛔ `BC-32` was already recorded as a **rejected candidate**; not revived here |

### 3.2 Why `BC-19` — the ownership argument, in three measured steps

| Step | Measured fact | Source |
|---|---|---|
| 1 | **`BC-19` owns the entity that was viewed.** *"Owns the tenant (library organisation) record, tenant context propagation, tiers, residency, lifecycle."* The public library profile **is** a rendering of that record — `MASTER_PRD.md` **L171** composes module 19 *"over `BC-19`, `BC-25`, `BC-29`, `BC-06`, `BC-02`, `BC-04`"* with `BC-19` **first** | BC Map **L128**; `MASTER_PRD.md` **L171** |
| 2 | **`BC-19` already publishes events, so no new capability is conferred.** `\| BC-19 \| tenancy.TenantProvisioned / TenantSuspended \| All, BC-21, BC-24 \| Lifecycle gates \|` — the `tenancy.*` prefix **and** the producer role both **pre-exist** | BC Map **L435** |
| 3 | **`BC-19` owns the `Tenant` aggregate**, so the event is a fact about an aggregate its own producer owns — which §9's convention requires (*"every producer in the catalogue is a context that owns an aggregate"*, as C3 §9A.1 observed) | BC Map **L381** |

⭐ **The determination is corroborated by an independent act.** `ADR-0093`, executed on the same authority,
admits **`BC-19`** to `E-21` as the source of the library record `BC-23` indexes for public discovery. The
same context that **supplies** the profile for discovery is the context that **owns** the profile that was
viewed. ⛔ Neither ADR is cited as the other's authority — each stands on **L128** — but the convergence is
recorded, because a determination producing *two different* owners for the same entity would have been
evidence of an error.

### 3.3 ⛔ Why NOT `BC-24 → BC-26`

The instrument said: *"Do NOT use `BC-24` Audit Trail → `BC-26` unless an explicit repository-compatible
architecture requires and documents it."* **No such architecture exists**, and two measurements make the
route unavailable:

1. **`BC-24` is the source of no edge.** Measured: `grep -nE "^\| E-[0-9]+ \| [^|]*BC-24"` against §7 →
   **0 rows**. `BC-24` appears only as the **downstream** of `E-20`. Routing through it would require minting
   a `BC-24 → BC-26` edge *in addition to* everything else — a **larger** change, not a smaller one.
2. **`BC-24`'s aggregate forbids the shape.** `AuditEntry` is *"**Append-only, no update or delete path exists
   in code**; entry carries the tenant **and actor** of record; legal hold blocks purge"* (**L384**). An audit
   entry records **an actor's action on a target** for accountability. A profile view by an anonymous,
   unauthenticated visitor has **no actor of record** — and `LPP-FR-039` forbids identifying one. Forcing
   anonymous view telemetry into an accountability ledger under legal hold would corrupt the ledger's meaning
   and manufacture the privacy liability the summary explicitly rejects.

⭐ **This is the substantive difference from `SM-7.17`.** That record rules `StudentViewed` *"deliberately
absent — viewing is an **audit** concern… not a domain event."* It is correct **for its case**: a *staff
member* viewing a *student's* record is an accountability event with a **named actor and a named data
subject**. A *seeker* viewing a *library's public profile* has neither. ⛔ `SM-7.17` is **not overruled, not
amended and not cited as authority** — it is **distinguished on its facts**, and
`Student_Management_PRD_v1.md` is byte-unchanged.

### 3.4 ⛔ Why `E-26` is not reused

`E-26` is `BC-27 AI → BC-26 Analytics, BC-23 Search`, `CF`, **Sync port**, contract *"AI retrieves through
permission-aware ports only — never direct index or table access."* Three independent disqualifications:

- **Wrong producer.** Its upstream is `BC-27`, which has no part in serving a public profile.
- **Wrong direction of benefit.** It is a **retrieval** port by which AI *reads from* `BC-26`; it does not
  deliver facts *to* `BC-26`.
- **Wrong mechanism.** It is a **Sync port**. A view fact must not block the render of a public page, and
  `E-20`'s established discipline for fire-and-forget facts is *"Domain never calls audit synchronously."*

### 3.5 The fact/derivation test

The instrument required the event to be *"a profile-view fact and not an analytics-derived duplicate."*

| Test | Result |
|---|---|
| Is the payload a **statement about a single past occurrence**? | ✅ Yes — one render of one profile at one time |
| Does it carry a **count, rate, total, average, trend, percentage or ranking**? | ⛔ **No, and §4 forbids it.** Those are `BC-26` derivations |
| Could `BC-26` reconstruct its projection by **replaying** these facts? | ✅ Yes — satisfying **L385**'s *"fully rebuildable from the event log"* invariant |
| Does any context other than `BC-26` derive a metric from it? | ⛔ **No.** `E-30` has exactly one consumer |

---

## 4. Payload boundary, tenancy and privacy

⭐ **What the event carries is deliberately constrained, and the constraint *is* the privacy control.**

### 4.1 MUST carry

| Element | Why |
|---|---|
| The **library/tenant** whose profile was viewed | The fact is meaningless without its subject. `BC-19` owns this identifier (**L381**, *"Tenant ID immutable"*) |
| The **occurrence time** | Required for `BC-26` to bucket into the periods `ADR-0097` defines |

### 4.2 ⛔ MUST NOT carry

- ⛔ **No viewer identity in any form** — no `PersonId`, `AccountId`, name, handle, avatar, partial
  identifier, device identifier or fingerprint. (`LPP-FR-039`; `ID-3`; §14A.5 never-public.)
- ⛔ **No `StudentRecordId`** and nothing from which one is recoverable (`ID-2`, **L489**).
- ⛔ **No social signal** — which friends, followers or peers viewed (`X-05`; `LPP-FR-041`).
- ⛔ **No count, total, trend, percentage or comparison** — `BC-26`'s to derive (§3.5).
- ⛔ **No credential, session token or IP address.**

⭐ **Viewer anonymity is a property of the payload, not a promise about downstream behaviour.** A metric
cannot re-identify a viewer whose identity was never transmitted. This is why the boundary is set at the
**producer** rather than left to a suppression rule alone — and it is also why **`UniqueViewers` is not
certified** by `ADR-0097`: this payload deliberately carries nothing from which uniqueness could be computed.
⭐ **The two decisions are consistent by construction, not by coincidence.**

### 4.3 Tenancy

- `BC-19` is in the **`BC-19→31` capability tier**: *"Tenant-aware. Carry and propagate `tenantId`… Indices,
  caches, projections… are **all** tenant-partitioned"* (**L490**). `BC-26`'s projection of this event
  inherits that rule; **no exemption is created**.
- The **public profile read** is served on the `AR-3` **Platform Public Discovery Index** path, with **no
  caller tenant context**. ⭐ The event names the **subject** library — which is *published* information,
  not tenant-operational data.
- The **readout** of the resulting metric is `AR-3` **Tenant Operational Data**: `LPP-FR-034` requires tenant
  context on that path and refusal where it is absent or mismatched. ⛔ **This ADR does not weaken
  `MP-GBR-08`, `SE-1` or `X-13`**, and does not put the metric on the discovery-index path.

### 4.4 Delivery

`E-30` is `PL` + Event and is therefore governed by §9.1's **Event Delivery Contract** as written — no
property of it is varied. Following `E-20`'s established discipline for facts of this class, delivery is
**not** on the synchronous path of the public profile render: `LPP-FR-044` already requires that an analytics
failure **MUST NOT** fail the public profile.

---

## 5. `BC-26` remains the sole analytics authority

| Concern | Owner after this ADR | Unchanged? |
|---|---|---|
| Metric/semantic layer — what a view *counts as* | **`BC-26`** (**L135**, **L385**) | ✅ Unchanged. This ADR defines **no** metric — see `ADR-0097` |
| Read-model store, projections, reports, exports | **`BC-26`** (**L135**) | ✅ Unchanged |
| The **fact** that a render occurred | **`BC-19`** — it owns the entity | ✅ New, and **not** an analytics concern |
| Rendering an already-certified metric | **C3**, render-only | ✅ Unchanged (`LPP-FR-035`, `LPP-XC-013`) |

⛔ **No second analytics system, semantic layer, metric store, projection engine or read model exists after
this ADR.** `BC-19` gains the ability to **state a fact**; it gains **no** ability to count, aggregate,
project, define or report. ⛔ `BC-19` does **not** become an analytics context; its `[GENERIC]`
classification, Shared Core cluster and V1 release are unchanged.

---

## 6. What this closes, and what it does not

**Closes `XPC-OD-007A`** — the producer and the edge are now declared.

⛔ **Does NOT close `XPC-OD-007B`.** That asks whether `BC-26` certifies the *metric*, and it is decided
separately by **`ADR-0097`**. ⭐ The separation is deliberate: a fact may lawfully exist and still not be
certified as a published metric, and conflating the two would let an edge authorisation imply a product
commitment.

⛔ **`XPC-OD-004`, `XPC-OD-005` and `XPC-OD-006` remain OPEN.** Not addressed, not implied, not resolved.

⛔ **Confers no lifecycle stage.** `PRD-021C` and all parts remain **DRAFT at Stage 2**, **NOT FROZEN**, **NOT
APPROVED**, **NOT BASELINED**. Stage 3 is **not** entered; no alignment record exists; no `IMPL-*` is minted.

---

## 7. Alternatives considered

| Option | Verdict |
|---|---|
| **A** — no event; drop the summary | ⛔ Rejected by the owner. Would delete a stated product requirement |
| **B** — reuse an existing event or edge | ⛔ Rejected. §1.1 measured that **no** view event exists and §3.4 that `E-26` is unsuitable. There was nothing to reuse |
| **C** — new event + new lawful edge, producer determined from ownership | ✅ **SELECTED** |
| **D** — route through `BC-24` | ⛔ Rejected — §3.3. Strictly larger *and* semantically wrong |
| **E** — let C3 write to `BC-26` directly | ⛔ Rejected. C3 is not a context and cannot be an edge participant |
| **F** — a new bounded context for engagement telemetry | ⛔ Rejected. 31 → 32 contexts to carry one fact |
| **G** — insert the rows into §7.3 and §9 in place | ⛔ Rejected **on measurement**: `ADR-0079` §8.5 Option A and §15's preamble measured **1,293** citations shifted by a §7 insertion versus **0** by an append |

---

## 8. Migration requirements — executed

| # | Change | Document | Rank | Executed |
|---|---|---|---|---|
| **M1** | New **§17** appended, declaring edge **`E-30`** and event **`tenancy.LibraryProfileViewed`** as a normative extension of §7 and §9, with the payload boundary, the `E-27`-vacancy restatement and the disclosed `GAP-BCMAP-BC26-EDGES` | `LIBOORA_BOUNDED_CONTEXT_MAP.md` | 4 | ✅ |
| **M2** | Header `Version` **v1.10 → v1.11**; header count cell restated to **29 edges** (`E-01`…`E-26`, `E-28`, `E-29`, `E-30`; `E-27` vacant), context count **unchanged at 31 (23 in V1)**; one changelog row | `LIBOORA_BOUNDED_CONTEXT_MAP.md` | 4 | ✅ |
| **M3** | Register `ADR-0096` | `docs/00-governance/adr/ADR-INDEX.md` | — | ✅ |
| **M4** | `XPC-OD-007A` marked **RESOLVED**; C3 §9A's producer/edge conditionals lifted | `PRD-021C` C0, C3 | — | ✅ |

⚠ **One consequence of the append method, disclosed.** §7.5's *pattern distribution* table (**L352**–**L356**)
counts *"Published Language (`PL`) | 7"*. `E-30` makes eight. ⛔ **That table is deliberately NOT edited**,
exactly as §15 left it unedited when `E-28` and `E-29` were minted: it is a §7 statistic, and §15/§16 both
declare §1–§14 byte-identical. §17 states the correct total in its own text so no reader is misled. Silently
editing a §7 cell to keep a derived count tidy would break the byte-identity guarantee that made the append
method safe in the first place.

**Not required:** no baseline re-issue (Rank 4); no Rank 1–3 document changed; **no `lib/` source file
touched**; no `PRD_REGISTRY.md` change (append-only, and no PRD is created).

---

## 9. Consequences

**Positive**

- C3 §9A's 👁️ **Profile Views** readout rests on a **declared** producer and a **declared** edge.
- The privacy posture is **stronger** than a naive tracking design: viewer identity is excluded **at the
  producer**, so no downstream component can leak what it never received.
- `BC-26` remains the sole analytics authority, and C3 remains render-only.

**Negative — accepted**

- The edge set grows to **29**. Disclosed and counted rather than left implicit.
- Two derived §7.5 statistics are now stated correctly in §17 but stale in §7.5. Accepted for the
  byte-identity reason in §8.
- The BC Map now carries a **third** appended section. Accepted: **0** citations invalidated, versus 1,293.

**Not a consequence**

- ⛔ No bounded context added, removed or reclassified — **31 before and after, 23 in V1**.
- ⛔ No aggregate, member or invariant altered. §8 is byte-unchanged.
- ⛔ No second analytics system, semantic layer or metric store.
- ⛔ No metric is certified — that is `ADR-0097`.
- ⛔ `BC-15` remains the source of zero edges; `LCG-ADR-002` stays **OPEN**.
- ⛔ `E-27` remains permanently vacant.

---

## 10. Compliance

- ⛔ Does **not** rewrite `ADR-0032`, `ADR-0033`, `ADR-0083`, `ADR-0085` or any historical ADR.
- ⛔ Does **not** consume `ADR-0088`, `ADR-0089` or `ADR-0090` — **reserved and unwritten** for `PRD-021B`
  per `ADR-0091` **L315**. Verified absent by exact filename before this number was taken.
- ⛔ Does **not** reuse `E-27`.
- ⛔ Does **not** reuse `E-26` as telemetry, and does **not** alter `E-26`'s row.
- ⛔ Does **not** create a `BC-24 → BC-26` edge, and does **not** amend `BC-24`'s row or aggregate.
- ⛔ Does **not** amend `Student_Management_PRD_v1.md`; `SM-7.17` is distinguished, not overruled.
- ⛔ Does **not** amend §7 or §9 in place, and does **not** edit any FROZEN artefact.
- ⛔ Does **not** resolve `XPC-OD-007B`, `XPC-OD-004`, `XPC-OD-005` or `XPC-OD-006`.
- ⛔ Does **not** resolve `GAP-BCMAP-BC26-EDGES`, which is **disclosed** and routed.
- ⛔ Does **not** expose individual viewer identities, by default or otherwise.
- ⛔ Does **not** enter Stage 3, create an Alignment Record, claim alignment `PASS`, mint an `IMPL-*`, write
  application code, freeze, baseline, rank or approve `PRD-021C`.
