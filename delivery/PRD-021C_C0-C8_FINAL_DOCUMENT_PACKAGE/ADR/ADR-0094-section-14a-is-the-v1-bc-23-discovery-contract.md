# ADR-0094 — `Library_PRD_v1.md` §14A is the V1 `BC-23` library discovery and query contract; `PRD-015` stays PLANNED

| Field | Value |
|---|---|
| **Status** | **Accepted** — 2026-09-02 |
| **Date** | 2026-09-02 |
| **Deciders** | ⭐ **Product Owner *and* Architecture Owner, jointly** — the two roles `PRD_OWNERSHIP_MODEL.md` §2.2 constitutes, required together because this decision fixes both *what the product exposes* (Product) and *which context owns the contract and index class* (Architecture). Both roles are here **filled for this act only** by **direct conferral from the human principal of this engagement**, in the same manner and with the same disclosure as `ADR-0032` §5.2, `ADR-0033` §7.2, `ADR-0036` §8.2, `ADR-0080` §5, `ADR-0083` and `ADR-0091`. ⛔ **No ARB quorum, attendee list, sign-off date or Security review is asserted.** ⛔ **No personal name is recorded** — `PRD_OWNERSHIP_MODEL.md` §7 rule 4 |
| **Authority instrument** | `PRD-021C_OWNER_DECISION_FORM.md` §2 — decision **`XPC-OD-002`**, option **A** (*"`Library_PRD_v1.md` §14A को V1 `BC-23` contract establish"*), authorized explicitly by the human principal for **both** required roles |
| **Amends** | ⛔ **Nothing is edited.** This ADR is **declaratory**: it establishes an **already-existing, already-FROZEN** artefact as the authoritative V1 contract for `BC-23` library discovery. `docs/30-product/library/14A-Library-Discovery-And-Enrollment.md` is **byte-unchanged** — see §4 |
| **Baseline** | **No baseline re-issue.** No Rank 1–3 document changes version. §14A's own frozen status and content are untouched |
| **Closes** | **`XPC-OD-002`** — the V1 `BC-23` contract question. See §5 |
| **Does NOT close** | `XPC-OD-003`, `XPC-OD-007A`/`B`, `XPC-OD-004`, `XPC-OD-005`, `XPC-OD-006`. ⛔ Does **not** author `PRD-015`. ⛔ Does **not** change `PRD-015`'s registry status. ⛔ Confers no lifecycle stage; verifies no code |
| **Related** | **`ADR-0093`** (authorises the `BC-19 → BC-23` *route*; this ADR fixes *what travels on it*) · `Library_PRD_v1.md` **§14A** — `14A-Library-Discovery-And-Enrollment.md`, **FROZEN 2026-08-03**, §14A.4 *Public Library Discovery*, §14A.5 *Public Library Profile*, §14A.6 *Library Visibility*, §14A.10 *Public Information Policy* · `14B-Public-Library-Preview.md` (`PO-1`…`PO-12`, `LIB-14B.29`/`.30`) · `PRD_REGISTRY.md` **L315** (`PRD-015`, `PLANNED`) and **L1429** · BC Map **L132** (`BC-23`), **L490** (tenant partitioning) · `ARCHITECTURE_RULINGS.md` `AR-1`, **`AR-3`** · `PRD-021C` C2 `LSD-FR-001`…`LSD-FR-008` |

> ✅ **ACCEPTED 2026-09-02.**
>
> ⭐ **This ADR creates no new authority — it names an existing one.** The defect was never a missing contract; it
> was a missing *statement of which existing artefact is the contract*. That distinction is why nothing is edited.

---

## 1. Context

### 1.1 The measured gap

`PRD_REGISTRY.md` **L315** registers the owner of `BC-23`:

```
| PRD-015 | Search Indexing | **BC-23** | [GENERIC] | V1 | PLANNED | Permission-aware, tenant-partitioned search |
```

⚠ **But no such document exists.** Measured: `find docs -iname "*PRD-015*"` → **nothing**. `BC-23` is a V1 context
whose nominated owning PRD has never been written.

`PRD-021C` C2 therefore had a real problem: `ADR-0093` can authorise the *route* `BC-19 → BC-23`, but a route with
no contract indexes nothing. C2 held `LSD-FR-001`…`008` **conditional** rather than inventing a field set.

### 1.2 What already exists, and is already frozen

`Library_PRD_v1.md` **§14A** — `14A-Library-Discovery-And-Enrollment.md`, **`RECEIVED VERBATIM · REVIEW COMPLETE ·
FROZEN 2026-08-03`** — already contains, as **normative frozen product text**:

| §14A section | What it fixes |
|---|---|
| **§14A.4** *Public Library Discovery* | The discovery surface and the fields a seeker discovers a library by |
| **§14A.5** *Public Library Profile* | The public field set of a library profile |
| **§14A.6** *Library Visibility* | Which libraries are discoverable, and on whose choice |
| **§14A.10** *Public Information Policy* | ⭐ The **public/never-public boundary** — including the *Internal Analytics* material marked **never-public** |
| **§14A.11** *Business Rules* · **§14A.13** *Acceptance Criteria* | The enforceable rules and their acceptance |

⭐ **Every element a `BC-23` V1 discovery contract needs is already written, already reviewed and already frozen.**
Authoring `PRD-015` would have restated frozen text in a new document — creating a **second** search/query authority
and a divergence risk, for zero new information.

---

## 2. Decision

**`Library_PRD_v1.md` §14A is hereby established as the authoritative V1 `BC-23` library discovery and query
contract.**

Specifically:

1. **§14A.4 / §14A.5** define the **indexable and queryable field set** for V1 library discovery. `BC-23` indexes
   these fields and no others for the library-discovery surface.
2. **§14A.6** defines **eligibility** — a library enters the discovery index only where §14A.6 makes it visible.
3. **§14A.10** defines the **public boundary**, and is binding on the index: ⛔ **anything §14A.10 marks
   never-public MUST NOT enter the public discovery index.** This explicitly includes *Internal Analytics*.
4. **`PRD-015` remains `PLANNED`** in `PRD_REGISTRY.md` **L315**, unchanged and unauthored. ⭐ It is **not** obsolete
   — should a future release need search capability beyond §14A's library-discovery scope (e.g. cross-entity or
   student search), `PRD-015` remains the registered home for it.
5. ⛔ **No second search, query or ranking authority is created.** `BC-23` remains sole owner of *"indices,
   permission-aware indexing, tenant index isolation, relevance, query rewriting"* (BC Map **L132**).

### 2.1 ⭐ Index class — the mandatory `AR-3` determination

`ARCHITECTURE_RULINGS.md` `AR-3` separates two index classes, and records that *"the single highest-severity failure
mode in the entire architecture is a cross-tenant data leak via a capability context."* The determination for this
contract is:

| Aspect | Ruling |
|---|---|
| **Index class** | ⭐ **Platform Public Discovery Index** — anonymous-readable, **no caller tenant context required**, because a seeker discovering a library is by definition not yet a member of it |
| **Content limit** | ⛔ **Only** fields §14A.4/§14A.5 mark public, filtered by §14A.6 visibility, and never anything §14A.10 marks never-public |
| **Tenant Operational Data** | ⛔ **MUST NOT** enter this index. Member lists, attendance, fees, seat occupancy, internal analytics and every other tenant-operational field stay in tenant-partitioned indices where a **tenant key is mandatory** (`MP-GBR-08`, `SE-1`, `X-13`, BC Map **L490**) |
| **Direction of the boundary** | The public index is a **projection of a deliberately published subset**, never a relaxation of the tenant-partitioned store. Publication is `BC-19`'s and §14A.6's choice; `BC-23` only indexes what it is given |

⚠ **This is the safety-critical half of the decision.** `ADR-0093` opened a route from the tenant record to the
index. Without §2.1, that route would have had no stated ceiling. The ceiling is: **public means the §14A public
field set, and nothing else.**

---

## 3. Why option A, and not the alternatives

| Option | Disposition |
|---|---|
| **A — establish §14A as the V1 `BC-23` contract** | ✅ **SELECTED** jointly by Product Owner and Architecture Owner. Reuses frozen, reviewed text; creates no second authority; edits nothing |
| **B — author `PRD-015`** | ⛔ Rejected by the owners. Would restate frozen §14A text in a new Stage-1 document, opening a full lifecycle and creating a divergence risk between two descriptions of one field set |
| **C — a different existing artefact** | ⛔ Rejected. `14B-Public-Library-Preview.md` is the closest candidate but governs the **preview surface** (`PO-1`…`PO-12`), not the discovery index; §14A is the discovery authority |
| **D — defer discovery indexing from V1** | ⛔ Rejected. `MASTER_PRD.md` **L171** scopes module 19 to **V1** |

---

## 4. ⭐ Why nothing is edited — the declaratory form

`14A-Library-Discovery-And-Enrollment.md` is **FROZEN**. A frozen Rank 3 artefact is not edited to record that
another context relies on it — and it does not need to be, because **§14A's content already says everything this
contract requires**. What was missing was the *statement of standing*, and that statement's proper home is an ADR.

**Measured guarantee:** §14A is **byte-unchanged** by this ADR. So is `Library_PRD_v1.md`, `14B`, and
`PRD_REGISTRY.md`.

⭐ This is the same discipline `ADR-0060` used when ruling that *"Security platform has no bounded context"* — a
declaratory ruling about existing artefacts, recorded in an ADR, editing none of them.

---

## 5. What this closes, and what it does not

**Closes `XPC-OD-002`.** `BC-23`'s V1 library-discovery contract, field set, eligibility rule, public boundary and
index class are now authoritatively fixed. Together with `ADR-0093` (the route), `PRD-021C` C2's
`LSD-FR-001`…`LSD-FR-008` are no longer blocked.

⛔ Does **not** author `PRD-015`. ⛔ Does **not** alter `PRD-015`'s `PLANNED` status or touch `PRD_REGISTRY.md` (which
is **append-only** and cited by line number 366+ times). ⛔ Does **not** confer Stage 3, alignment, PASS, freeze,
baseline, rank or approval on `PRD-021C`. ⛔ Does **not** create an `IMPL-*` identifier or verify any code.

---

## 6. Migration requirements — **executed 2026-09-02**

| # | Change | Document | Rank | Executed |
|---|---|---|---|---|
| **M1** | Register this ADR | `ADR-INDEX.md` | — | ✅ |
| **M2** | Record `XPC-OD-002` **RESOLVED** in `PRD-021C` C0 §6; lift the C2 contract condition; cite §14A and the index class | `PRD-021C_C0_...md`, `PRD-021C_C2_...md` | 2 | ✅ |

**Not required:** ⛔ no edit to `14A-Library-Discovery-And-Enrollment.md` (**FROZEN**, byte-unchanged); ⛔ no edit to
`Library_PRD_v1.md`, `14B-Public-Library-Preview.md` or `PRD_REGISTRY.md`; ⛔ no `PRD-015` created; ⛔ no BC Map change
(the route is `ADR-0093`'s act, not this one); ⛔ **no `lib/` source file touched**.

---

## 7. Consequences

**Positive.** `BC-23` gains a real, frozen, reviewed V1 contract without a new document. The public/tenant index
boundary is stated explicitly rather than left to implementation. `PRD-021C` C2's second blocker closes.

**Negative / accepted.** §14A now carries a second role — library product spec **and** `BC-23` contract — so a future
change to §14A's public field lists becomes an architectural change, not merely a product one. That coupling is
accepted, and is the price of not duplicating the field set. `PRD-015` remains registered but unwritten, which is a
disclosed, deliberate state rather than an oversight.

**Not a consequence.** No context gained an aggregate. No edge changed. No metric was certified. `PRD-021C` did not
advance a lifecycle stage.

---

## 8. Compliance

- ⛔ Does **not** create a second search, query, ranking or index authority — `BC-23` remains sole owner.
- ⛔ Does **not** author `PRD-015`, nor change its `PLANNED` registry status.
- ⛔ Does **not** edit any FROZEN artefact — §14A, §14B and `Library_PRD_v1.md` are byte-unchanged.
- ⛔ Does **not** insert into `PRD_REGISTRY.md` (append-only, 366+ line citations).
- ⛔ Does **not** weaken tenant isolation. It **strengthens** it by naming the ceiling: never-public §14A.10 material
  and all Tenant Operational Data are excluded from the public discovery index.
- ⛔ Does **not** add, remove or alter a context, edge, aggregate, event, invariant or tenancy mode.
- ⛔ Does **not** re-issue the baseline; no Rank 1–3 document changes version.
- ⛔ Does **not** rewrite, supersede or reopen any historical ADR, and does **not** consume the reserved numbers
  `ADR-0088`, `ADR-0089` or `ADR-0090` (`ADR-0091` **L315**).
- ⛔ Does **not** confer any lifecycle stage, alignment, freeze, baseline, rank or approval on `PRD-021C`.
