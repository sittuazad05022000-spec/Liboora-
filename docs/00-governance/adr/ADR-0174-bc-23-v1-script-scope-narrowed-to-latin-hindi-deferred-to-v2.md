<!-- LIBOORA Governance | Architecture Decision Record | 2026-10-06 -->

> This document is a governance record. It is a **PROPOSED** ADR whose **acceptance is
> PENDING** named authority. It does **not** approve a PRD, gate outcome, implementation,
> or release. It supersedes, **for V1 only**, the accepted Hindi/Devanagari limb of four
> search-track ADRs; it **does not rewrite** those files (byte-unchanged).

# ADR-0174 — **`BC-23` V1 script scope narrowed to English/Latin; Hindi/Devanagari deferred to V2**

| Field | Value |
|---|---|
| **Status** | ⛔ **PROPOSED** — 2026-10-06 drafting date. **Acceptance slot PENDING and unrecorded.** ⛔ **No ARB concurrence is fabricated.** ⛔ **Reverting on completion** *(if later accepted under `ADR-0033` §7.1; not yet applicable while PROPOSED)*. ⚠️ **NO INDEPENDENT REVIEW CLAIMED** |
| **Rank** | 2 — Architecture Decision Record |
| **Date prepared** | 2026-10-06 |
| **Bounded context** | ⭐ **`BC-23` Discovery / Search** *(the subject of this decision)* · **`PRD-015`** v0.1 **FROZEN, Rank 3 — byte-unchanged** *(amended only via the seven-step frozen-PRD route, **effective only upon Acceptance + ARB concurrence**)* |
| **Supersedes** | ⭐ **For V1 only (limb-supersession; ADR files byte-unchanged):** `ADR-0099` `C-8` *(closed set of two)* · `ADR-0100` §223–225 *(canonical English + Hindi; Hinglish/romanized-Hindi query behaviour)* · `ADR-0101` `D-10` *(the `ZWNJ`/Devanagari residue refusal)* · `ADR-0103` `C-8` + Supplement B *(the three `text`-role units bound to **Latin + Devanagari**)*. Each is **superseded-for-V1 by `ADR-0174`; Hindi/Devanagari is now a V2 scope item.** ⛔ The historical ADR text is **never rewritten**; supersession is recorded here and in the index addendum only. |
| **Superseded by** | — |
| **Amends** | ⭐ `PRD-015` `SRCHPO-1` **value** *(V1 canonical script set: **English/Latin only**; Hindi/Devanagari scheduled to V2)* via the seven-step frozen-PRD route — ⭐ **effective only upon Acceptance + ARB concurrence; while this ADR is PROPOSED the frozen `PRD-015` / `SRCHPO-1` remain the two-set and are byte-unchanged** |
| **Closes** | ⛔ **NOTHING at PROPOSED status.** `SRCH-GAP-002` / `SRCH-GAP-007` remain open; Stage 3 not conferred |
| **Decides** | ⭐ **One question — the V1 canonical search script/inventory set.** ⛔ **Nothing else** |
| **Expressly does NOT decide** | ⛔ **no new roles** · ⛔ **no new permissions** · ⛔ **no new scopes** · ⛔ **no new identifiers** · ⛔ **no new events** · ⛔ **no new architecture contracts** · ⛔ **no re-opening of the `SRCH-FR-024` conditional text** *(the `N1–N6` normalization limbs are textually unchanged; only the consumed `SRCHPO-1` value changes)* · ⛔ **no V2 discharge** *(V2 Indic/Devanagari support is scheduled, not decided here)* · ⛔ **no gate passed/closed** · ⛔ **no acceptance criterion recorded as passing** |
| **Deciding authority** | ⭐ **Product Owner** (V1 script inventory) · **Architecture Owner** (`BC-23` scope) · **ARB** (H-C `C-8` binding concurrence) — ⛔ **concurrence PENDING and UNRECORDED; not fabricated** |
| **Origin** | `PRD-015_SEARCH_INDEXING.md` / `SRCHPO-1` PO record L57 *(the two-set closed inventory)* · `PRD-015_CONSOLIDATED_ARCHITECTURE_COMPLETION.md` §316 · `ADR-0099` `C-8` · `ADR-0100` §223–225 · `ADR-0101` `D-10` · `ADR-0103` `C-8`/Supplement B · `DDR-0037` *(the paired design-layer D5 supersession of `DDR-0002`)* |

> ⭐⭐ **Identifier check, performed immediately before drafting and again before writing.**
> `ADR-0173` is the highest ADR file present. **`ADR-0174` measured 0 files on disk and
> 0 references anywhere in `docs/`.** ⛔ No identifier is reused, reserved, or renumbered.

---

## 1. ⭐ Question

> ⭐ **What is the V1 canonical search script/inventory set for `BC-23`, given that all
> Hindi/Devanagari support is moved to V2 under `DDR-0037`?**

The accepted two-set inventory is recorded as:

| Source | Text *(minimum necessary)* |
|---|---|
| `SRCHPO-1` (PO record L57) | *"V1 canonical supported languages/scripts = exactly two: English (Latin script) and Hindi (Devanagari script). This is a **closed set** for V1"* |
| `ADR-0099` `C-8` | *"Language scope is the closed set of two. The configuration MUST NOT presuppose a third canonical language or index"* |
| `ADR-0100` §223–225 | *"Canonical V1 inventory: **English + Hindi**, a closed set of two … English → **Latin**, Hindi → **Devanagari**, where applicable. Hinglish / Romanized Hindi is a supported query behaviour where technically validated."* |
| `ADR-0101` `D-10` | *"The `ZWNJ` / Devanagari residue is REFUSED and ROUTED"* |
| `ADR-0103` `C-8` / Supp B | *3 of 3 `text`-role units bound to **Latin + Devanagari**; both values are members of `SRCHPO-1`'s closed set of two* |

## 2. ⭐ Decision

| Limb | Ruling |
|---|---|
| V1 canonical script set | ⭐ **`SRCHPO-1` value narrowed to exactly ONE for V1: English (Latin).** Hindi (Devanagari) is **removed from the V1 closed set and scheduled to V2** *(not waived — V2 still owes it)* |
| `SRCH-FR-024` / `N1–N6` | ⛔ **Textually unchanged.** These limbs are *conditional on the declared script/scope*; only the consumed `SRCHPO-1` value changes. No normalization rule is re-decided |
| `SRCHPO-17` (Supplement B) | ⛔ The three `text`-role units are **superseded-for-V1 to Latin-only**; the Devanagari limb of the binding is the V2 scope item. Field table itself is amended only via the frozen-PRD route |
| Hinglish / romanized-Hindi | ⭐ Remains a **Latin-script query behaviour** where technically validated; it is not an Indic inventory member and is not affected |

## 3. ⭐ Why

The `DDR-0002` requirement limb (V1 Indic/Devanagari student names, guaranteed rendering)
is being moved to V2 by `DDR-0037` *(D5, design layer)*. The search-track two-set inventory
is the **authoritative source** that re-introduces Hindi/Devanagari into V1. To make the V1
contract **English/Latin-only** consistently, `SRCHPO-1`'s value must be narrowed and the
four accepted ADR Hindi limbs **superseded-for-V1**. Supersession (not in-place editing)
preserves every accepted record byte-for-byte per the index Process rules.

## 4. ⭐ Consequences / Preserved

- ⭐ **Effective only on Acceptance + ARB concurrence.** While PROPOSED, the frozen `PRD-015`
  v0.1 / `SRCHPO-1` remain the two-set and are **byte-unchanged**; the `SUPPLEMENT_D` filing
  and the `PRD-015` v0.2 seven-step route are **staged and held** for a follow-up act.
- ⛔ `PRD-003`, `MASTER_PRD`, `PRD-015` (v0.1) and the four accepted ADR files are **byte-unchanged**.
- ⛔ `G5` stays **PROPOSED / V2-deferred** · `DBT-008` stays **OPEN** · `CP-B1`/`FA-GAP-003` stay
  **BLOCKED / UNVERIFIED** · **no M1 PASS/FAIL asserted** · `DDR-0012` stays **reserved-and-free**.
- ⛔ 0 new roles, permissions, scopes, identifiers, events, or architecture contracts created.

## 5. ⛔ Registration hygiene

| Check | Result |
|---|---|
| Number | ⭐ `ADR-0174` is the next unregistered ADR; no number reused |
| Status | ⛔ Registered as **PROPOSED / PENDING** in the same commit as its drafting (late-registration discipline per `ADR-0065`/`ADR-0057`); the Count cell is **not** re-derived by this record |
| Acceptance | ⛔ **PENDING / UNRECORDED** — no Product Owner / Architecture Owner / ARB concurrence is asserted |

> ⚠️⚠️ **`ADR-0174` is PROPOSED, not Accepted.** ⭐ This record records the *decision*;
> acceptance, ARB concurrence, and the held `PRD-015` v0.2 seven-step route (incl.
> `SUPPLEMENT_D`) are **separate, later named acts** — none is performed or fabricated here.
