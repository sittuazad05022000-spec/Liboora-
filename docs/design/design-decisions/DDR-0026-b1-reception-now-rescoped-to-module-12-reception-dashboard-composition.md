<!-- LIBOORA Design Documentation | Design Decision Record | 2026-09-28 -->

> This document is design governance and documentation. ⛔ It does **not** amend product
> requirements, architecture decisions, bounded-context ownership, permissions, roles,
> scopes or backend contracts.

# DDR-0026 — `DD6-TBD-006` proposal: `B1` "Reception Now" re-scoped from a `BC-26` surface to the module-12 **Reception Dashboard** presentation composition

| Field | Value |
|---|---|
| **Register** | ⭐ Filed under [`README.md`](README.md) §2 template and §4 filing rules · global identifier `DDR-0026` (`DDR-0025` is the last registered — *never reused, never reassigned*) |
| ⭐⭐ **Status** | ⭐⭐ **PROPOSED — NOT CONFERRED** · ⛔ **0 of 2 required conferrals recorded** · the decision below is the prepared wording only |
| **Date (proposal)** | 2026-09-28 |
| **Proposing role** | UX Architecture Owner (audit role) — ⚠️ a *recorder*, ⛔ not one of the two roles this decision requires |
| ⭐⭐ **Required approvers** | ⭐⭐ **Product Owner** + **Architecture Owner** — named by `DD-0006` `DD6-TBD-006` (`DD-0006` **L1682**) · ⛔ the question is *not* in the UX Architecture Owner's lane, and the record does not claim it was decided otherwise |
| **Scope** | Surface-placement ruling for `B1` "Reception Now" (`DD-0006` §9.2 **L648**): `BC-26` Analytics surface **or** module-12 Reception Dashboard composition |
| **Change class** | ⭐ Experience/ownership clarification only · ⛔ **no** requirement, permission, BC, backend, contract, role, scope or identifier change |
| ⛔ **What this record does NOT do** | ⛔ Does **not** confer the decision (0 of 2 approvals) · ⛔ does **not** resolve `DD6-TBD-006` (resolution = a `RESOLVED` entry appended to this record **after** both conferrals) · ⛔ does **not** create `DD-0010` · ⛔ does **not** create a dashboard PRD · ⛔ mints **no** `PERM-*`, role, aggregate, invariant, context or identifier · ⛔ authorizes **no** implementation *(`DESIGN_GOVERNANCE.md` §3 rule 5: design decisions never approve implementation)* · ⛔ changes `DD-0006` status — it remains **`PROPOSED` / `UNRANKED`** |

---

## 1. The decision question

> `DD6-TBD-006` (`DD-0006` **L1682**): *"Is `B1` Reception a `BC-26` surface or dashboard
> scope?"* — owners: **Product Owner + Architecture Owner**.

`DD-0006`'s own classification table (**L262–274**) already measured the answer and carried
the ruling forward as an open question: B2/B3 are `BC-26` *analysis* surfaces (drill-down
`ANL-FR-028`, trend-over-periods); **B1 is a situational-now tile** — "tiles for
*situational awareness*, which BC Map **L84** assigns to a **composition**, not a
context."

## 2. Proposed decision (exact wording, for the two required conferrals)

**Option B.** `B1` "Reception Now" is a surface of the **module-12 Reception Dashboard** —
a presentation composition over read models that **owns no aggregate and no invariant** and
**has no PRD**. `BC-26` is **not** the owner of B1's surface; `BC-26`'s role is limited to
**certifying and exposing** the underlying metric values the composition displays.

### 2.1 DATA OWNERSHIP (unchanged by this decision)

`BC-26` Analytics Read Model **owns and certifies** the underlying metrics and their
definitions. B1's displayed values — `InsideNow`, `SeatsOccupied`, today's check-ins, and
the dues-on-arrival flag — are `BC-26` CertifiedMetrics (the 12 `DashboardMetrics`
counters certified at `version:1` by `Accepted` [`ADR-0147`](../../00-governance/adr/ADR-0147-twelve-dashboardmetrics-counters-certified-anl-obd-001-resolved.md));
no dashboard may define its own metric formula (`MP-GBR-36`, `MASTER_PRD.md`).

### 2.2 PRESENTATION OWNERSHIP

The module-12 Reception Dashboard composition **presents** those certified values. It owns
**no aggregate and no invariant** and requires **no PRD**. `PRD-009` places "dashboard UI
composition" and "defining dashboards themselves" out of `BC-26` scope.

## 3. Authoritative evidence

| Rank | Source | Text |
|---:|---|---|
| 1 | `MASTER_PRD.md` **L164** | "12 · Reception Dashboard · Composition over read models · *not a context* · V1" |
| 1 | `MASTER_PRD.md` **L173** | Correction 1: dashboards "marked as compositions so no team builds an aggregate behind one" |
| 4 | `LIBOORA_BOUNDED_CONTEXT_MAP.md` **L84** | "Dashboards (`Owner`, `Manager`, `Reception`, `Parent`) are **not contexts** … own no aggregate and no invariant" |
| 3 | `PRD-009` **NG-2 (L164)** / **L179** | "Defining dashboards themselves — compositions, not contexts" · "Out of scope: dashboard UI composition" |
| register | `PRD_REGISTRY.md` **L387** | "Dashboards — Owner, Manager, Reception (modules 10–12) · *not contexts* · **No PRD.** Presentation compositions; own no aggregate" |
| 2 | `ADR-0147` | The 12 `DashboardMetrics` counters are certified `BC-26` metrics (data ownership, `version:1`) |
| UNRANKED | `DD-0006` **L262–274**, **L1682** | The in-document measurement that opened `DD6-TBD-006` (re-scoring, not authority) |

## 4. Consequences (to be executed only after both conferrals are recorded here)

**`DD-0006` in-place alignment** (all line references re-verified at the time of recording):

| # | Location | Alignment |
|---|---|---|
| 1 | **L1682** (`DD6-TBD-006` row) | Replace with the closure text in §5 |
| 2 | **L211** (§4.1 in-scope table) | "Reception / Manager / Owner decision surfaces → YES → `B2`, `B3`" — B1 re-homed to the module-12 composition |
| 3 | **L264–274** (classification table + note) | B1 settled as **dashboard composition**; "retained with a TBD" framing removed |
| 4 | **L512** (11×5 role matrix) | B1 marked composition-presented; role view `TR-3` **unchanged** |
| 5 | **L571 / L742 / L752** (ID note, APP-2 count, designable count) | Recount: B1 exits the `BC-26` designable set (7 → 6, with the figure's basis restated) |
| 6 | **L817 / L825** (metric rows) | Confirmed as `BC-26` **data** rows only (data ownership unchanged) |
| 7 | **L648** (§9.2 inventory) | B1 reclassified: values `BC-26`-certified; tile presented by module-12 composition |
| 8 | **L720 / L1103 / L1198 / L1597** | Propagate: B1 values remain `BC-26`; B1 tiles belong to the dashboard |
| 9 | **L1803** (reconciliation row) | "only B1 flagged, retained with a TBD" → "B1 re-scoped; `DD6-TBD-006` closed" |

**Index alignment:** `docs/35-design/README.md` §2A `analytics/` row, only if the `BC-26`
surface count changes.

**No other file changes.** `MASTER_PRD`, BC Map, `PRD-009` and `PRD_REGISTRY` **already
state the composition rule** — this decision *applies* it; it does not amend any of them.

## 5. Closure text (insert at `DD-0006` L1682, only after both conferrals below are recorded)

> `DD6-TBD-006` — **RESOLVED** (`[DATE]`, conferral recorded at `DDR-0026` §6): B1
> "Reception Now" is **re-scoped out of the `BC-26` surface inventory** and re-homed to
> the **module-12 Reception Dashboard composition**. `BC-26` continues to **own and
> certify** the underlying metrics and their definitions (`MP-GBR-36`; `ADR-0147`). The
> composition **presents** those certified values and **owns no aggregate, no invariant
> and no PRD** (`LIBOORA_BOUNDED_CONTEXT_MAP.md` L84; `MASTER_PRD.md` L164/L173;
> `PRD_REGISTRY.md` L387). No bounded context, aggregate, invariant, `PERM-*`, PRD or
> identifier is created or minted. **No implementation is authorized.** `DD-0006` remains
> `PROPOSED` / `UNRANKED`.

## 6. Approval slots — ⛔ 0 of 2 conferred as of recording

| # | Required conferral | Required evidence (`DESIGN_OWNERSHIP.md` §3: role, decision, date; no personal names) | Status |
|---|---|---|---|
| 1 | **Product Owner** — *"B1 is a module-12 Reception Dashboard composition surface; the composition presents `BC-26` certified values and owns no aggregate/invariant; no dashboard PRD is created"* | `[PRODUCT OWNER]` · conferral date `[DATE]` · role-only naming | ⛔ **NOT RECORDED** |
| 2 | **Architecture Owner** — *"B1 is placed as a presentation composition, not a `BC-26` context surface; no aggregate, invariant or identifier is minted; `DD-0006` is aligned per §4 only"* | `[ARCHITECTURE OWNER]` · conferral date `[DATE]` · role-only naming | ⛔ **NOT RECORDED** |

**Conferment rule (repository precedent):** a conferral is performed *by the role holder
and recorded in the instrument that exercises it* (`PRD-009_STAGE4_CONFERRAL.md` §44.6;
`ADR-0060` L212). ⛔ **This record will NOT be marked `RESOLVED` and `DD-0006` will NOT be
edited until both rows above carry recorded conferrals.** A directive to "assume
approval" is an instruction to *try*, not the act itself.

## 7. Non-consequences (explicit)

- ⛔ **`DD-0010` is NOT required.** A new DD is allocatable only where a **frozen PRD
  fixes surface requirements** for a new context (`docs/35-design/README.md` §2A);
  dashboards get **no PRD** (`PRD_REGISTRY` L387) and `PRD-009` excludes dashboard UI
  composition (L179), so the discriminator is **unmet**. B1 re-homing is an in-place
  alignment, not a new surface-requirement set.
- ⛔ **No dashboard PRD, no `BC-*`, no aggregate, no invariant, no `PERM-*`, no role.**
- ⛔ **No implementation authorization** — `DESIGN_GOVERNANCE.md` §3 rule 5: design
  decisions do not approve implementation.
- ⛔ **`DD-0006` status unchanged** — `PROPOSED` / `UNRANKED`.

## 8. Changelog

| Version | Date | Change | Rationale |
|---|---|---|---|
| **v0.1** | 2026-09-28 | ⭐ **Created as `PROPOSED`.** Decision wording for `DD6-TBD-006` prepared at the UX Architecture Owner's audit role: Option B (module-12 Reception Dashboard composition) evidenced at §3. ⛔ **0 of 2 required conferrals (Product Owner, Architecture Owner) are recorded** — §6 slots open. ⛔ `DD-0006` **NOT edited** pending both conferrals. ⛔ 0 identifiers, 0 PRD/ADR/BC-Map edits, 0 code, 0 commits by this act | Records the prepared ruling without conferring it — the `ADR-0060`/`PRD-009_STAGE4_CONFERRAL` precedent bars recording a conferral that has not been performed by the role holder |
