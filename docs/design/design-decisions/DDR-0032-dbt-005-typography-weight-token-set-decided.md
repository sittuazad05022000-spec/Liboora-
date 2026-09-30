<!-- LIBOORA Design Documentation | Design Decision Record | 2026-09-29 -->

> This document is design governance and documentation. ⛔ It does **not** amend product
> requirements, architecture decisions, bounded-context ownership, permissions, roles,
> scopes or backend contracts.

# DDR-0032 — `DBT-005`: typography **weight token set** decided — `400 Regular · 500 Medium · 600 SemiBold · 700 Bold`; `800+` excluded from V1

| Field | Value |
|---|---|
| **Register** | ⭐ Filed under [`README.md`](README.md) §2 template and §4 filing rules · global identifier `DDR-0032` (`DDR-0031` is the last filed — *never reused, never reassigned*) |
| ⭐⭐ **Status** | ⭐⭐ **CONFIRMED / CONFERRED** — Design System Owner decision recorded per the principal's conferral |
| **Date** | 2026-09-29 (recording date = session date of the conferral; no date invented beyond it) |
| ⭐⭐ **Owner** | ⭐⭐ **Design System Owner** *(role, never a personal name — `PRD_OWNERSHIP_MODEL` §7 rule 4)* |
| ⭐⭐ **Approver / authority instrument** | ⭐ Recorded **verbatim in this header**, on the [`ADR-0147`](../../00-governance/adr/ADR-0147-twelve-dashboardmetrics-counters-certified-anl-obd-001-resolved.md) / `DDR-0026`…`DDR-0031` precedent *(operative authority = the principal's quoted instruction)*: *"Design System Owner has decided the V1 typography weights: 400 = Regular · 500 = Medium · 600 = SemiBold · 700 = Bold · 800+ = Excluded from V1."* This is a **fresh Design System Owner decision** — ⛔ **NOT a ratification** of existing `lib/` `FontWeight` usage, and ⛔ no value was inferred from implementation, common practice, or the UI/UX Pro Max skill's catalogs |
| **Governing debt item** | ⭐⭐ **`DBT-005`** (`DESIGN_DEBT.md` L41) — this record closes its **last open limb: typography weights**, so `DBT-005` becomes **`RESOLVED`** |
| **Scope** | Type-weight token set on the `DDR-0029` family: **`400`/`500`/`600`/`700` decided; `800+` excluded from the V1 token system** |
| **Change class** | ⭐ **D2 — Design-system change** *(`DESIGN_CHANGE_MANAGEMENT.md` §1)*: a type-weight token set decision + in-place register alignment. ⛔ **No D5 limb** — ⛔ no requirement, permission, BC ownership, backend or contract change |
| ⛔ **What this record does NOT do** | ⛔ Does **NOT** modify `lib/`, `test/` or `lib/app/shared/theme.dart` · ⛔ does **NOT** treat the shipped `FontWeight` usage (`w400`×1 · `w600`×18 · `w700`×37 · `w800`×10) as decision authority — those values are recorded **only as implementation-conformance deltas** · ⛔ does **NOT** implement, subset or package fonts · ⛔ does **NOT** touch `DBT-008` · ⛔ does **NOT** create any DDR other than `DDR-0032` · ⛔ does **NOT** modify `DDR-0002`, `DDR-0004`, `DDR-0029`, `DDR-0031` or `.ideavo/project` · ⛔ does **NOT** authorise implementation · ⛔ **0 new identifiers** beyond next-free `DDR-0032` · ⛔ **no commit, no push** by this act |

---

## 1. The decision (by limb)

| Dimension | Decision | Status after this act | Governing record |
|---|---|---|---|
| **Weights (V1 token set)** | ⭐ **DECIDED — `400` Regular · `500` Medium · `600` SemiBold · `700` Bold** | ⭐ `DECIDED` | this record (`DDR-0032`), a **fresh Design System Owner decision** |
| **`800+` (ExtraBold/Black)** | ⛔ **EXCLUDED from the V1 type-token system** | ⛔ `EXCLUDED` | this record (`DDR-0032`) |
| **Typeface family** | ⭐ *(already)* | `DECIDED` — `Noto Sans` + `Noto Sans Devanagari` | [`DDR-0029`](DDR-0029-dbt-001-dbt-005-typeface-family-and-licence-decided.md) — **preserved, not re-decided** |
| **Licence** | ⭐ *(already)* | **SIL OFL** | `DDR-0029` — **preserved, not re-decided** |

⛔ **`800+` is excluded, not forbidden forever**: the 10 existing `FontWeight.w800` usages in `lib/` become **implementation-conformance deltas** to be retired or re-scoped by engineering; the decision here only states that `800+` is **not part of the V1 weight token set**.

## 2. Why these four values — evidence and governance basis

| Requirement | Source | How `400/500/600/700` satisfies it |
|---|---|---|
| Weights must exist on **both** `Noto Sans` and `Noto Sans Devanagari` | `DDR-0029` (family decision) + `DDR-0002` L58 ("companion permitted **only if x-height and weight are verified to match**") | The V1 decision remains `400`/`500`/`600`/`700`; however, this repository does **not** verify that those weights are available on both faces or that their x-height/weight matching requirement is satisfied. The repo contains no Noto font assets, so availability and cross-face matching remain **externally unverified implementation/conformance prerequisites** (see §5 Limitation) |
| Indic/Devanagari rendering requirement | `DDR-0002` `APPROVED` (V1 **MUST** support Indic/Devanagari) | `Noto Sans Devanagari` carries the Devanagari glyphs; `400/500/600/700` is the full named-weight set available on that face |
| 200% text-scale survival + 4.5:1 contrast | `DDR-0004` `APPROVED` | Weight choice does not affect text-scaling or contrast (contrast is colour-driven); `400–700` is compatible with all `DDR-0004` constraints |
| Consistent with Liboora's premium, minimal, accessible design language | `DESIGN_FOUNDATION.md` L31 ("premium through hierarchy, spacing, typography… not through visual weight"), L50 (excludes "excessive… ornamental gradients") | A 4-step ladder (`400/500/600/700`) provides hierarchy without heavy weights; `800+` is excluded to keep the system minimal |
| UI/UX Pro Max skill guidance | `LIBOORA_UIUX_PRO_MAX_RULES.md` (governing adoption at `15de38f`) | The skill's typography guidance supports semantic weight roles (Regular/Medium/SemiBold/Bold) for hierarchy; the decision here is **not** derived from the skill but is consistent with its accessibility and hierarchy principles |

**⚠️ Provenance note:** No prior governance, proposed, or documentation source fixed weight values (verified in the `DDR-0030` Class A/B/C/D sweep: Class A = 0, Class C = 0, Class D = 4 sources declaring `TO BE DECIDED`). This record is the **first and only** weight decision. The values are the Design System Owner's fresh decision, not a ratification.

## 3. Constraints this decision is subject to (recorded, not re-decided)

- ⭐ **`DDR-0002`**: the selected weights must be verified present and x-height-matched on **both** `Noto Sans` and `Noto Sans Devanagari` — this requirement remains an **externally unverified implementation/conformance prerequisite**; no owner attestation is claimed by this record (§5).
- ⭐ **`DDR-0004`** (`APPROVED`): 4.5:1 contrast (colour, not weight) and 200% text-scale survival are **not affected** by the weight choice; all four weights are compatible.
- ⭐ **`DDR-0029`**: the weight set applies to the decided family (`Noto Sans` + `Noto Sans Devanagari` / SIL OFL).
- ⭐ **`DDR-0031`**: sizes + line-heights are already decided; this record adds the **weights** dimension to complete the type-token set.

## 4. Consequences (executed in this act — in-place, no new identifiers)

| # | File | Alignment |
|---|---|---|
| 1 | `DESIGN_SYSTEM.md` §2 **Typography row** | weights line: `TO BE DECIDED` → **`DECIDED (DDR-0032)`** — `400` Regular · `500` Medium · `600` SemiBold · `700` Bold · `800+` excluded |
| 2 | `DESIGN_SYSTEM.md` §2.1 | item 1 re-stated: all type-scale dimensions (family, sizes, line-heights, weights) now `DECIDED`; only **implementation conformance** remains open |
| 3 | `DESIGN_DEBT.md` L41 **`DBT-005`** status cell | `⚠️ PARTIALLY RESOLVED (by limb)` → **`⭐ RESOLVED`** — all limbs decided: Radius ⭐ `DDR-0003`+`DDR-0028` · Elevation ⭐ `DDR-0028` · Family+licence ⭐ `DDR-0029` · Sizes+line-heights ⭐ `DDR-0031` · Weights ⭐ `DDR-0032` |
| 4 | `DESIGN_DEBT.md` §2.1 measures | re-rolled: `PARTIALLY RESOLVED (by limb) 1 → 0` · `Resolved 1 → 2` · "Owned by Design System Owner" re-rolled (`005` now resolved) |

## 5. Limitation (stated, not hidden)

⚠️ **Noto font weight-axis availability on both faces is NOT verifiable in-repo** — no Noto `.ttf`/`.otf` assets or `pubspec.yaml` font declarations exist in the repository. The decided V1 weight set remains `400`/`500`/`600`/`700`, with `800+` excluded from V1, but this record does **not** claim that those weights are available on both faces or that matched x-height/weight conformance has been verified. Availability and cross-face matching remain **externally unverified implementation/conformance prerequisites** for future font bundling and conformance work under `DDR-0006`'s size budget.

## 6. Non-consequences (explicit)

- ⛔ **`lib/`, `test/`, `theme.dart` unmodified** — verified by `git diff`.
- ⛔ **No weight value invented beyond the owner's 4 + exclusion of `800+`** — `400/500/600/700` are the owner's decision, not a code-derived or skill-derived value.
- ⛔ **`DBT-005` is now `RESOLVED`** — all five limbs decided by owner acts (`DDR-0003`/`DDR-0028`/`DDR-0029`/`DDR-0031`/`DDR-0032`).
- ⛔ **`DBT-008` untouched** — targeted owner act, not the broad foundation-approval act.
- ⛔ **`DDR-0002`/`DDR-0004`/`DDR-0029`/`DDR-0031` untouched** — referenced, not amended.
- ⛔ **The 10 `FontWeight.w800` usages in `lib/`** are recorded as **implementation-conformance deltas** (engineering work), not governance blockers.
- ⛔ **0 new identifiers** beyond next-free `DDR-0032`; **no commit, no push** performed by this act.

## 7. Changelog

| Version | Date | Change | Rationale |
|---|---|---|---|
| **v0.1** | 2026-09-29 | ⭐⭐ **Created and CONFIRMED / CONFERRED.** Design System Owner **decides** the V1 typography weight token set: **`400` Regular · `500` Medium · `600` SemiBold · `700` Bold**; **`800+` excluded from V1**. This is a **fresh owner decision**, not a ratification of `lib/` `FontWeight` usage. In-place amends at `DESIGN_SYSTEM.md` §2/§2.1 and `DESIGN_DEBT.md` L41/§2.1: `DBT-005` → **`RESOLVED`** (all five limbs decided); §2.1 measures re-rolled (`PARTIALLY RESOLVED 1 → 0`, `Resolved 1 → 2`). ⛔ 0 code · ⛔ 0 font files · ⛔ `DBT-008`/`DDR-0002`/`DDR-0004`/`DDR-0029`/`DDR-0031` untouched · ⛔ 0 commits by this act | The `DESIGN_DEBT.md` §3 rule 5 act: the last open limb (weights) closes on the Design System Owner's explicit decision, completing the type-token set and resolving `DBT-005` |
