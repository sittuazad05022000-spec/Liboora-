# ADR-0093 — Edge `E-21` must list `BC-19`, the context that owns the library organisation record indexed for public discovery

| Field | Value |
|---|---|
| **Status** | **Accepted** — 2026-09-02 |
| **Date** | 2026-09-02 |
| **Deciders** | **Architecture Owner** — the role `PRD_OWNERSHIP_MODEL.md` §2.2/§2.3 (L85, L102) assigns *"boundaries, ranks, permitted edges"*, and L284 records as the *only* approving body for a Rank 1–5 document change. ⭐ The role is here **filled for this act only** by **direct conferral from the human principal of this engagement**, in the same manner and with the same disclosure as `ADR-0032` §5.2, `ADR-0033` §7.2, `ADR-0036` §8.2, `ADR-0080` §5, `ADR-0083` and `ADR-0091`. ⛔ **No ARB quorum, attendee list, sign-off date or Security review is asserted.** ⛔ **No personal name is recorded** — `PRD_OWNERSHIP_MODEL.md` §7 rule 4 |
| **Authority instrument** | `PRD-021C_OWNER_DECISION_FORM.md` §1 — decision **`XPC-OD-001`**, option **A** (*"`E-21` में `BC-19` admit"*), authorized explicitly by the human principal |
| **Amends** | `docs/10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md` (Rank 4) — §7.3, edge **`E-21`**, the **Upstream (source) cell only**. ⛔ **No edge added, no edge removed, no mode changed, no mechanism changed, no contract semantics changed, no context reclassified, no aggregate moved, no invariant altered, no tenancy mode touched.** Executed, see §7 |
| **Baseline** | **No baseline re-issue.** BC Map is **Rank 4**; `DOCUMENTATION_BASELINE.md` §7 step 4 moves the baseline identifier *"only when a Rank 1–3 document changes version"*. `ADR-0016` and `ADR-0055` recorded the identical exemption for the identical class of cell |
| **Closes** | **`XPC-OD-001`** — the architecture half of `PRD-021C` C2's discovery-indexing blocker. See §5 |
| **Does NOT close** | `XPC-OD-002` (the *contract* — see `ADR-0094`), `XPC-OD-003`, `XPC-OD-007A`/`B`, `XPC-OD-004`, `XPC-OD-005`, `XPC-OD-006`. ⛔ Confers **no** lifecycle stage on `PRD-021C`; verifies **no** code; closes **no** acceptance criterion |
| **Related** | **`ADR-0016`** and **`ADR-0055`** (the one-cell `E-22` precedents this ADR follows in method) · `ADR-0083` §4.5 **AO-9** and L315 (which *declined* to claim `E-21` supported a new consumer without an explicit amendment — that refusal was correct *for want of an owner*, and an owner has now ruled) · `ADR-0084` L72–76 (the wildcard-source edge list, which `E-21` is **not** on) · BC Map **L292** (the governing rule), **L330** (`E-21`), **L128** (`BC-19`), **L132** (`BC-23`), **L435** (`BC-19`'s existing event row) · `AR-1`, `AR-3` · `PRD-021C` C2 `LSD-FR-001`…`LSD-FR-008` |

> ✅ **ACCEPTED 2026-09-02. The migration in §7 has been executed.**
>
> This is the **third** instance of the defect class `ADR-0016` opened: a PRD depends on an edge participant that
> the Rank 4 edge register does not list, and BC Map **L292** rules that an unlisted edge **does not exist**.

---

## 1. Context

### 1.1 The rule that makes this a defect, and that also forbids fixing it quietly

Bounded Context Map §7, **line 292**:

> *"Every edge that crosses a context boundary in V1. If an edge is not in this table, it **does not exist** and adding it requires an ADR."*

The rule cuts both ways, exactly as `ADR-0016` §1.1 and `ADR-0055` §1.1 observed. It is why this ADR exists — the
source cannot simply be typed into the cell — and it is why the omission matters: until amended, the map asserts
that `BC-19 → BC-23` **does not exist**.

### 1.2 The measured omission

`E-21` as it stood at BC Map **L330**:

```
| E-21 | BC-01, BC-10 | BC-23 Search Indexing | PL | Event | *Created/Updated/Deleted → index. Search never reads domain tables |
```

Sources were `BC-01 Enrollment` and `BC-10 Global Person Identity` only. **`BC-19 Tenancy` was absent.**

Yet `BC-19` (**L128**) *"owns the tenant (library organisation) record"* — and the **library organisation record is
precisely the entity that public library discovery indexes and queries**. `MASTER_PRD.md` **L171** describes module
19 *Library Discovery & Enrollment* as a *"Composition over **BC-19**, BC-25, BC-29, BC-06, BC-02, BC-04,
**projected via BC-23**"*. `AR-1` requires *"Discovery projection & query → `BC-23`"*. Rank 1 and Rank 5 therefore
both require a flow that the Rank 4 edge register denied.

### 1.3 Why the wildcard argument does not apply, and was tested

`ADR-0084` **L72–76** enumerates the wildcard-source edges — those whose Upstream cell reads *"All contexts"* or
*"All write paths"*: **`E-17`, `E-18`, `E-19`, `E-20`, `E-23`**. ⛔ **`E-21` is not among them.** Its source list is
explicit and closed. No blanket "all contexts publish to search" rule exists, so `BC-19` could not have been read in
by implication. This was measured before the amendment, not assumed.

### 1.4 The prior refusals were correct

`ADR-0083` §4.5 ruling **AO-9** directed: *"Search → use `E-21` **only if** it supports `BC-15` without a new
protocol; **otherwise record the amendment explicitly**"*, and `ADR-0083` **L315** then stated: *"⛔ Does **not**
claim `E-21` supports community search."* `PRD-021C`'s own C2 draft likewise refused, holding `LSD-FR-001`…`008`
**conditional** rather than assuming the edge.

**Nothing in that chain was a stall.** Each step routed the decision to the role competent to make it. This ADR is
that role making it.

---

## 2. Decision

**`E-21`'s Upstream (source) cell is amended to include `BC-19 Tenancy`.**

The source list becomes **`BC-01, BC-10, BC-19`**. The amending ADR is cited in the contract cell, exactly as
`ADR-0016` and `ADR-0055` are cited in `E-22`'s.

⛔ **Nothing else changes.** `E-21` keeps its downstream (`BC-23 Search Indexing`), its pattern (`PL`), its mechanism
(`Event`) and its contract semantics (*"`*Created/Updated/Deleted` → index. Search never reads domain tables"*).

---

## 3. Necessity, tested per context

Following the `ADR-0055` §3 discipline — necessity is tested for the **specific context**, not asserted generally.

| Test | `BC-19 Tenancy` |
|---|---|
| Does it own an entity that public discovery must find? | ✅ **Yes** — the tenant/library organisation record, BC Map **L128** |
| Does a Rank 1–5 document require that entity to be discoverable via `BC-23`? | ✅ **Yes** — `MASTER_PRD.md` **L171** (Rank 1); `AR-1` (Rank 5) |
| Does it already publish domain events, so the `PL`/Event mechanism fits without a new protocol? | ✅ **Yes** — BC Map **L435** already lists `BC-19` as a producer of `tenancy.TenantProvisioned` / `TenantSuspended` |
| Could an existing edge carry this instead? | ⛔ **No** — `E-21` is the only edge whose downstream is `BC-23` for indexing; `E-26` is `BC-27 AI`'s *retrieval* port, not an indexing feed |
| Is a **new** edge required? | ⛔ **No** — and that is the point of this ADR: the smallest compatible change is one cell on an existing edge |

---

## 4. Ownership boundaries preserved

| Invariant | Status after this ADR |
|---|---|
| **`BC-19` owns tenant organisation data of record** | ✅ Unchanged. `BC-19` publishes *facts about its own record*; it gains no index and no query surface |
| **`BC-23` owns search and indexing** | ✅ Unchanged and **sole**. *"Owns indices, permission-aware indexing, tenant index isolation, relevance, query rewriting"* (**L132**) |
| **Tenant isolation** | ✅ Unchanged. **L490** requires that *"indices, caches, projections, prompts, embeddings and files are **all** tenant-partitioned"*. `AR-3`'s two index classes are untouched by this ADR — which class the discovery index belongs to is `XPC-OD-002`'s question, ruled in **`ADR-0094`**, not here |
| **"Search never reads domain tables"** | ✅ Unchanged — preserved verbatim in the contract cell |
| **No second search system, context or edge** | ✅ **0** contexts added; **0** edges added; **0** aggregates moved. Context count remains **31 (23 in V1)**; edge set remains `E-01`…`E-26`, `E-28`, `E-29` with `E-27` permanently vacant |

---

## 5. What this closes, and what it does not

**Closes `XPC-OD-001`.** `BC-19 → BC-23` is now a declared edge participant, so `PRD-021C` C2's discovery-indexing
requirements are no longer blocked *on the existence of the route*.

⚠ **`XPC-OD-002` is a separate question and is not closed here.** This ADR authorises the **route**; it says nothing
about **what is indexed** — the field set, the query contract and the index class. That is ruled in **`ADR-0094`**.
`LSD-FR-001`…`008` remain conditional on `ADR-0094`, not on this one.

⛔ Does **not** confer Stage 3, alignment, PASS, freeze, baseline, rank or approval on `PRD-021C`. ⛔ Does **not**
create an `IMPL-*` identifier or verify any code.

---

## 6. Alternatives considered

| Option | Disposition |
|---|---|
| **A — amend `E-21` to admit `BC-19`** | ✅ **SELECTED** by the Architecture Owner. Smallest compatible change: one cell, existing edge, existing mechanism |
| **B — route over an existing alternative edge/contract** | ⛔ Rejected by the owner. Measured: no other edge terminates at `BC-23` for indexing |
| **C — defer discovery indexing from V1** | ⛔ Rejected by the owner. Would contradict `MASTER_PRD.md` **L171**, which scopes module 19 to **V1** |
| *(not offered)* — mint a new `BC-19 → BC-23` edge | ⛔ Never considered lawful: it would create a second indexing route where one already exists, and BC Map §7 admits one edge per boundary crossing |

---

## 7. Migration requirements — **executed 2026-09-02**

| # | Change | Document | Rank | Executed |
|---|---|---|---|---|
| **M1** | §7.3 `E-21`: source cell `BC-01, BC-10` → `BC-01, BC-10, BC-19`, with this ADR cited in the contract cell as `ADR-0016`/`ADR-0055` are in `E-22`'s | `LIBOORA_BOUNDED_CONTEXT_MAP.md` | **4** | ✅ |
| **M2** | Version → **v1.11**; changelog row; context/edge count note extended | same | **4** | ✅ |
| **M3** | Register this ADR | `ADR-INDEX.md` | — | ✅ |
| **M4** | Record `XPC-OD-001` **RESOLVED** in `PRD-021C` C0 §6 and lift the C2 condition that depended on the route | `PRD-021C_C0_...md`, `PRD-021C_C2_...md` | 2 | ✅ |

**Not required:** no baseline re-issue (Rank 4 — baseline §7 rule 4); no change to `tool/module_dependencies.yaml`;
no change to `E-17`…`E-20`, `E-22`…`E-26`, `E-28`, `E-29`; no context, aggregate, invariant, identity rule or
tenancy mode changed; ⛔ **no `lib/` source file touched**.

---

## 8. Consequences

**Positive.** The Rank 1 / Rank 5 requirement for V1 library discovery becomes servable in principle. The
`ADR-0016` omission class is closed for `E-21`'s tenant participant. `PRD-021C` C2 loses one of its two blockers.

**Negative / accepted.** `E-21` now has three sources, each widening the blast radius of a `BC-23` outage.
Indexing the tenant record raises the stakes on `AR-3`'s index-class separation — which is exactly why
**`ADR-0094`** must rule on the contract before any field is indexed.

**Not a consequence.** No context gained an aggregate. No PRD gained ownership. No entitlement changed. Nothing
became verified. `PRD-021C` did not advance a lifecycle stage.

---

## 9. Compliance

- ⛔ Does **not** add, remove or renumber an edge. The set stays `E-01`…`E-26`, `E-28`, `E-29`; `E-27` stays vacant.
- ⛔ Does **not** mint `E-27` or reuse any withdrawn number.
- ⛔ Does **not** change `E-21`'s downstream, pattern, mechanism or contract semantics.
- ⛔ Does **not** create a second search system, index, context or query authority.
- ⛔ Does **not** weaken tenant isolation, `AR-3`, `MP-GBR-08`, `SE-1` or `X-13`.
- ⛔ Does **not** re-issue the baseline — this file is **Rank 4** (`DOCUMENTATION_BASELINE.md` §7 rule 4).
- ⛔ Does **not** rewrite, supersede or reopen any historical ADR, and does **not** consume the reserved numbers
  `ADR-0088`, `ADR-0089` or `ADR-0090` (`ADR-0091` **L315**).
- ⛔ Does **not** confer any lifecycle stage, alignment, freeze, baseline, rank or approval on `PRD-021C`.
