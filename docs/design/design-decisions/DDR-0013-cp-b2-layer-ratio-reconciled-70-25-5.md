<!-- LIBOORA Design Documentation | Design Decision Record | 2026-10-01 -->

> This document is design governance and documentation. ⛔ It does **not** amend
> product requirements, architecture decisions, bounded-context ownership,
> permissions, roles, scopes or backend contracts.

# DDR-0013 — `CP-B2` / `FA-GAP-002`: canonical layer ratio reconciled to 70% 2D / 25% 2.5D / ≤5% 3D

| Field | Value |
|---|---|
| **Register** | ⭐ Filed under [`README.md`](README.md) §2 template and §4 filing rules · global identifier `DDR-0013` (*the reserved-but-free identifier named at `LIBOORA_DESIGN_AUTHORITY_CLOSURE_PACK.md` §4 field 6 and the dashboard §A `CP-B2′` row; verified free at filing — 0 dedicated record; the only prior occurrences were reservation notes)* |
| ⭐ **Status** | ⭐ **ACCEPTED** — reconciling decision recorded per the §2 template |
| **Date** | **2026-10-01** (recording date = session date of the owner's approval; no date invented beyond it) |
| ⭐ **Owner** | ⭐ **Design System Owner**, with **Design Vision Owner** *(the office named on `DDR-0010` and closure pack §4 field 1)* · ⭐ **Design Documentation Owner** specifically for the `DESIGN_FOUNDATION.md` L10 amendment *(closure pack §4 field 1)* |
| **Approver / authority instrument** | ⭐ **Design System Owner** — the owner decision recorded in `LIBOORA_DESIGN_AUTHORITY_CLOSURE_PACK.md` §4 and the dashboard `CP-B2′` (blocker `FA-GAP-002`, a class-D4 source conflict). ⛔ This record **reconciles a CONFLICT** — it is not a convenience choice *(`DESIGN_GOVERNANCE.md` §3 rule 4: a CONFLICT is not closed by choosing the more convenient design; the owner has expressly ruled the conflict)* |
| **Scope** | ⭐ **Design / governance reconciliation only** — the canonical 2D / 2.5D / 3D layer ratio. ⛔ No production code, `pubspec`, Android configuration, or 3D asset/weight budget is changed by this record |
| **Decision** | ⭐ **The canonical layer ratio is `70%` clean 2D · `25%` subtle 2.5D depth · `≤5%` lightweight premium 3D.** ⭐ **Both limbs are reconciled, not one limb for convenience:** the **3D limb** moves from the live-document `~10%` to **`≤5%`** (the figure `DDR-0010` recorded), and the **2.5D depth limb** moves from the live-document `20%` to **`25%`** (the figure `DDR-0010` recorded, which `DDR-0010` had **not** recorded as a conflict — measured: `20%` appears 0 times in the `DDR-0001`–`0009` file). The 2D layer (`70%`) is unchanged in both records. ⭐ This **selects Option A** from `LIBOORA_DESIGN_AUTHORITY_CLOSURE_PACK.md` §4 field 4 *(adopt `70/25/≤5` and amend all four documents)* |
| **Rationale** | ⭐ The reconciliation is anchored to the **confirmed V1 target class** at [`DDR-0034`](DDR-0034-cp-a-v1-device-profile-confirmed-by-technical-owner.md) (Technical Owner, ACCEPTED 2026-10-01): **Android 8.0 / API 26 · 2 GB RAM · 720×1600 · intermittent/degraded connectivity, primarily 4G.** ⭐ On that low-end reference class, keeping the **3D layer controlled at `≤5%`** bounds the 3D asset / rendering footprint and its performance cost; the 5 points moved out of the 3D layer are re-allocated to the **2.5D depth layer (25%)**, which carries the personality/depth treatment without a 3D rendering cost. ⭐ `DDR-0010`'s caveat that "the ≤5% figure is validated against `DDR-0006`'s provisional target only" is **discharged**: `DDR-0006`'s provision was superseded by the Technical Owner's confirmation of the **same** `API 26 / 2 GB / 720×1600` class at `DDR-0034`, so the chosen triple is now validated against the confirmed class, not a provisional one. ⛔ No new value is invented — both figures (`25%` depth, `≤5%` 3D) are `DDR-0010`'s own recorded numbers; this record reconciles the live documents to them |
| **Alternatives** | ⭐ **Option B** (`70/20/10` — retain the live-document triple and amend `DDR-0010`) — ⛔ **not selected**: it would leave the 3D layer at `~10%`, the looser figure, on the confirmed 2 GB / 720×1600 class. ⭐ **Option C** (a third reconciled triple) — ⛔ **not selected**: the owner selected Option A. *(Carried from `LIBOORA_DESIGN_AUTHORITY_CLOSURE_PACK.md` §4 field 4; this record selects one, per the owner's decision.)* |
| **What is UNCHANGED (explicit)** | ⭐ **The four permitted 3D moments** (`DDR-0010`: seat/library visualisation → 2D floor-plan · student hero object → flat illustration · onboarding study-space → static image · selected empty states → flat illustration; **everywhere else 0% 3D**) are **unchanged** by this record. ⭐ **Mandatory complete 2D fallback** for every 3D moment is **unchanged**. ⭐ The **accessibility** constraint *(delight never overrides `DDR-0004`)*, the **information-hierarchy** constraint, and the **"the product must not feel like a children's game"** constraint are **unchanged**. ⛔ This record changes **only** the canonical ratio numbers and the live documents that carry them |
| **Historical preservation** | ⭐ `DDR-0010` **remains fully in place as historical evidence** — its decision text, alternatives, consequences and open-questions rows are **⛔ not rewritten, deleted or altered** by this record. Its open-CONFLICT row is re-pointed **by reference only** (as the `DDR-0006` row was to `DDR-0034`), with its prior text retained verbatim |
| **Consequences** | ⭐ The canonical triple is `70/25/≤5`; the four live design documents are amended to state it (§"Amended artifacts"). ⭐ The 3D layer is bounded at `≤5%` on the confirmed low-end class → the **3D asset-production and weight budget** (a separate **Design Performance Owner** act, gated on `DDR-0034`) now has a firm, confirmed-class ceiling. ⚠ Code conformance / asset production is **separate implementation work** — this record does not authorise or perform it. ⛔ No gate is passed and no debt closed by this record |
| **Open questions** | ⭐ **3D asset-production pipeline and weight budget** — **Design Performance Owner** *(a separate, forward-looking act now bounded by this record's `≤5%` and the `DDR-0034` class; it does not block this reconciliation)* · ⛔ No ratio open question remains |
| **Review trigger** | Any owner decision to change the canonical triple · any measured frame drop on the confirmed `API 26 / 2 GB / 720×1600` class · any proposal to add a fifth 3D moment |

---

## Amended artifacts (named, performed with this record)

Per `DESIGN_CHANGE_MANAGEMENT.md` §4 and `LIBOORA_DESIGN_AUTHORITY_CLOSURE_PACK.md` §4 field 6, this
reconciliation amends the **four authoritative live design documents** to the canonical `70/25/≤5`,
plus the two live tracking documents:

| Artifact | Change |
|---|---|
| `DESIGN_FOUNDATION.md` **L10** | `about 70% clean 2D, 20% subtle depth, 10% premium 3D` → `70% clean 2D, 25% subtle depth, ≤5% premium 3D` (prior value retained) |
| `VISUAL_LANGUAGE.md` §1 | `About 20% subtle depth` → `About 25% subtle depth`; `About 10% premium 3D-style illustration` → `About ≤5%` (prior values retained) |
| `DESIGN_SYSTEM.md` §2 (Illustration row) | `About 10% premium 3D-style illustration` → `About ≤5%` (prior value retained) |
| `LIBOORA_MASTER_DESIGN_SYSTEM.md` L105 + L326 | `~10% premium 3D` / `~10% of surface` → `≤5%` (prior values retained) |
| `LIBOORA_DESIGN_AUTHORITY_CLOSURE_PACK.md` | `CP-B2` field 7 status + §12 G5-checklist item 3 + §14 tracking rows (reconciled to `DDR-0013`; prior state retained) |
| `LIBOORA_DESIGN_APPROVAL_ACTION_PLAN.md` | `FA-GAP-002` verdict cells reconciled to `RESOLVED — DDR-0013` (prior state retained) |

⛔ `DDR-0010` (historical) is re-pointed **by reference only** — its text is not altered. ⛔ No
production code, `pubspec`, Android configuration, `CP-B1`/`FA-GAP-003`, `DDR-0012`, or other
unrelated governance record is touched by this act.

## What this record does NOT do

- ⛔ Does **NOT** alter `DDR-0010`'s historical decision text, alternatives, or the four permitted
  3D moments — it re-points its open-CONFLICT row by reference only.
- ⛔ Does **NOT** change the 4 permitted 3D moments, the mandatory 2D fallback, or the
  accessibility / hierarchy / "not a children's game" constraints.
- ⛔ Does **NOT** create or modify `DDR-0012` (the `CP-B1` typeface/Devanagari decision, which
  remains reserved-and-free and BLOCKED / UNVERIFIED on its own evidence).
- ⛔ Does **NOT** touch `CP-B1` / `FA-GAP-003` (Devanagari guarantee — still BLOCKED / UNVERIFIED).
- ⛔ Does **NOT** modify production code, `pubspec.yaml`, Android configuration, or fonts.
- ⛔ Does **NOT** pass any gate or close `DBT-008`; G5 remains unrecorded (this record is one more
  of the pre-G5 owner decisions).
- ⛔ Does **NOT** invent any ratio value — `25%` and `≤5%` are `DDR-0010`'s own recorded numbers.

## Change-control note

Per `DESIGN_CHANGE_MANAGEMENT.md` §4: decision ID `DDR-0013`, artifact = canonical layer ratio,
decision status **ACCEPTED**, owner (Design System Owner with Design Vision Owner; Design
Documentation Owner for `DESIGN_FOUNDATION.md` L10), approver role (Design System Owner), decision
date **2026-10-01**, source references (`DDR-0010` L187–193 · `DESIGN_FOUNDATION.md` L10 ·
`VISUAL_LANGUAGE.md` §1 · `DESIGN_SYSTEM.md` §2 · `LIBOORA_MASTER_DESIGN_SYSTEM.md` L105/L326 ·
`DDR-0034`), unresolved follow-ups per *Open questions*.
