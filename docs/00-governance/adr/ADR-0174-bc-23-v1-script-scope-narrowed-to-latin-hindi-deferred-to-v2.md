<!-- LIBOORA Governance | Architecture Decision Record | 2026-10-06 -->

> This document is a governance record. It is an **ACCEPTED** ADR whose acceptance is
> **recorded verbatim at §8.1** (2026-10-07 — three one-act conferrals: Product Owner,
> Architecture Owner, ARB; all three offices exercised by one principal; ⛔ no independent
> review, no ARB quorum, no external audit claimed). It does **not** approve a PRD, gate
> outcome, implementation, or release. It supersedes, **for V1 only**, the accepted
> Hindi/Devanagari limb of four search-track ADRs; it **does not rewrite** those files
> (byte-unchanged).

# ADR-0174 — **`BC-23` V1 script scope narrowed to English/Latin; Hindi/Devanagari deferred to V2**

| Field | Value |
|---|---|
| **Status** | ⭐⭐ **Accepted** — 2026-10-07, under the **Product Owner + Architecture Owner + ARB** one-act conferrals recorded **verbatim at §8.1** (all three offices exercised by one principal; ⛔ no independent review, no ARB quorum, no external audit claimed — `ADR-0103`/`ADR-0146` disclosure form; each conferral **reverts on completion** per `ADR-0033` §7.1). *Prior text retained: ⛔ PROPOSED — 2026-10-06 drafting date; acceptance slot PENDING and unrecorded* |
| **Rank** | 2 — Architecture Decision Record |
| **Date prepared** | 2026-10-06 |
| **Bounded context** | ⭐ **`BC-23` Discovery / Search** *(the subject of this decision)* · **`PRD-015`** v0.1 **FROZEN, Rank 3 — byte-unchanged** *(amended only via the seven-step frozen-PRD route, **effective only upon Acceptance + ARB concurrence**)* |
| **Supersedes** | ⭐ **For V1 only (limb-supersession; ADR files byte-unchanged):** `ADR-0099` `C-8` *(closed set of two)* · `ADR-0100` §223–225 *(canonical English + Hindi; Hinglish/romanized-Hindi query behaviour)* · `ADR-0101` `D-10` *(the `ZWNJ`/Devanagari residue refusal)* · `ADR-0103` `C-8` + Supplement B *(the three `text`-role units bound to **Latin + Devanagari**)*. Each is **superseded-for-V1 by `ADR-0174`; Hindi/Devanagari is now a V2 scope item.** ⛔ The historical ADR text is **never rewritten**; supersession is recorded here and in the index addendum only. |
| **Superseded by** | — |
| **Amends** | ⭐ `PRD-015` `SRCHPO-1` **value** *(V1 canonical script set: **English/Latin only**; Hindi/Devanagari scheduled to V2)* via the seven-step frozen-PRD route — ⭐ **condition met 2026-10-07 (§8.1); the seven-step route is now actionable but remains a separate, later named act; the frozen `PRD-015` v0.1 stays byte-unchanged until that route is filed** |
| **Closes** | ⛔ **NOTHING at acceptance as well.** `SRCH-GAP-002` / `SRCH-GAP-007` remain open; Stage 3 not conferred; no criterion recorded as passing. Acceptance authorises the document class and releases the held `PRD-015` v0.2 route; it closes no gap and confers no stage |
| **Decides** | ⭐ **One question — the V1 canonical search script/inventory set.** ⛔ **Nothing else** |
| **Expressly does NOT decide** | ⛔ **no new roles** · ⛔ **no new permissions** · ⛔ **no new scopes** · ⛔ **no new identifiers** · ⛔ **no new events** · ⛔ **no new architecture contracts** · ⛔ **no re-opening of the `SRCH-FR-024` conditional text** *(the `N1–N6` normalization limbs are textually unchanged; only the consumed `SRCHPO-1` value changes)* · ⛔ **no V2 discharge** *(V2 Indic/Devanagari support is scheduled, not decided here)* · ⛔ **no gate passed/closed** · ⛔ **no acceptance criterion recorded as passing** |
| **Deciding authority** | ⭐ **Product Owner** (V1 script inventory) · **Architecture Owner** (`BC-23` scope) · **ARB** (H-C `C-8` binding concurrence) — ⭐ **conferral RECORDED 2026-10-07, verbatim at §8.1** (one-principal form; ⛔ no independent review / ARB quorum asserted; not fabricated) |
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
| Acceptance | ⭐ **RECORDED** — the Product Owner approval, Architecture Owner approval, and ARB concurrence are recorded **verbatim at §8.1** (2026-10-07; one-principal form; ⛔ no independent review / ARB quorum asserted; each conferral reverts on completion per `ADR-0033` §7.1) |

> ⚠️⚠️ **`ADR-0174` is Accepted (2026-10-07), recorded in the instrument per §8.1.** ⭐ The
> held `PRD-015` v0.2 seven-step route (incl. `SUPPLEMENT_D`) is now **actionable** and
> remains a **separate, later named act** — it is NOT performed by this record; the frozen
> `PRD-015` v0.1 stays **byte-unchanged** until that route is filed.

---

## 6. ⭐ Authority and conferral boundary

| Field | Value |
|---|---|
| **Deciding authority** | ⭐ **Product Owner** (V1 script inventory) · **Architecture Owner** (`BC-23` scope) · **ARB** (H-C script-binding concurrence) — recorded at §8.1 |
| **Conferral status** | ✅ **RECORDED** — three one-act conferrals recorded verbatim at §8.1 (2026-10-07) |
| ⭐ **One-principal form** | ⚠ **All three offices were exercised by one principal** — so ⛔ **no independent review, no ARB quorum and no external audit is claimed** (`ADR-0146` disclosure form); each office's conferral **reverts on completion** (`ADR-0033` §7.1) |
| **ARB quorum basis** | ⛔ **None asserted** — per `ADR-0103` (the direct ARB-concurrence precedent for `PRD-015`'s script bindings): *"No ARB meeting was held, minuted or attended. No quorum, attendee list or sign-off date is asserted"*; the ARB acts through the Architecture Owner role for this act only (`PRD_OWNERSHIP_MODEL.md` L85/L107/L197) |
| ⭐ **Precedent** | `ADR-0103` · `ADR-0146` · `ADR-0173` §8.1 · `ADR-0033` §7.1 |

---

## 7. ⛔ What this acceptance does NOT do

- ⛔ Does **NOT** close `SRCH-GAP-002` / `SRCH-GAP-007`; Stage 3 not conferred; no criterion recorded as passing.
- ⛔ Does **NOT** file the `PRD-015` v0.2 seven-step route or `SUPPLEMENT_D` — that route is now actionable but is still a **separate, later named act**; `PRD-015` v0.1 (FROZEN, Rank 3) stays **byte-unchanged** until then.
- ⛔ Does **NOT** edit `ADR-0099` / `ADR-0100` / `ADR-0101` / `ADR-0103`, `PRD-003`, `MASTER_PRD`, `DDR-0037`, or `DDR-0002`'s record — all **byte-unchanged**; the limb-supersession is recorded in this ADR + the index addendum only.
- ⛔ Does **NOT** create `DDR-0038`, close or re-status `G5`, change `DBT-008`, re-open `CP-B1` / `FA-GAP-003`, or assert any M1 result; `DDR-0012` stays **reserved-and-free**.
- ⛔ **0** new roles, permissions, scopes, identifiers, events, or architecture contracts; no file under `lib/`, `test/`, `tool/`, `packages/` or `web/` touched.

---

## 8. ⭐⭐ Conferral and reversion

| Field | Value |
|---|---|
| **Form** | ⭐ **THREE one-act conferrals** — Product Owner, Architecture Owner, ARB — by the human principal, 2026-10-07; all three offices exercised by one principal |
| **Scope** | ⭐ *Acceptance of `ADR-0174` only:* the `SRCHPO-1` V1 value narrowing (English/Latin; Hindi/Devanagari scheduled to V2, not waived) + the limb-supersession of `ADR-0099` `C-8` · `ADR-0100` §223–225 · `ADR-0101` `D-10` · `ADR-0103` `C-8`/Supp B *(for V1; the four ADR files byte-unchanged)* |
| ⛔ **Not claimed** | ⛔ No independent review · ⛔ No ARB quorum / attendee list / sign-off date · ⛔ No external audit *(`ADR-0103` / `ADR-0146` disclosure form)* |
| ⭐ **Reversion** | ⭐ Each office's conferral **reverts on completion** of the acceptance act *(`ADR-0033` §7.1 — "a conferral for one act is not a standing licence")*. ⛔⛔ **Filing the held `PRD-015` v0.2 / `SUPPLEMENT_D` route, or resolving any other `SRCH-GAP-*`, requires a NEW conferral or the competent office** |

### 8.1 ⭐ The conferrals, recorded verbatim (2026-10-07)

> **Product Owner:** *"I approve ADR-0174: the V1 canonical search script scope is narrowed to English/Latin only, and Hindi/Devanagari student-name support is scheduled for V2, not waived. The SRCHPO-1 value change is approved subject to the required ARB concurrence. No new roles, permissions, or unrelated scope are created."*

> **Architecture Owner:** *"I approve the architecture change defined by ADR-0174. The specified BC-23 Hindi/Devanagari V1 limbs are superseded through ADR-0174 while the historical ADR files remain byte-unchanged. The change is consistent with the existing architecture boundaries."*

> **ARB (concurrence):** *"I concur with ADR-0174, including the SRCHPO-1 value change, H-C binding supersession, V1 English/Latin-only scope, and Hindi/Devanagari V2 deferral."*

| Disclosure | Recorded form |
|---|---|
| **Quorum basis** | ⛔ **None asserted** — the ARB concurrence is recorded on the `ADR-0103` one-act-conferral precedent (*"No ARB meeting was held, minuted or attended. No quorum, attendee list or sign-off date is asserted"*); no seat count or role list is invented |
| **Independent review** | ⛔ **Not claimed / not evidenced** — all three offices were exercised by one principal; no independent review, ARB quorum, or external audit is asserted *(`ADR-0146` / `ADR-0173` §8 disclosure form)*; each conferral reverts on completion *(`ADR-0033` §7.1)* |
| ⭐ **Elements present** | ⭐ office named (each statement issued under its named office) · scope named (the exact §2/§4 limb-supersession; non-scope enumerated in §7) · reversion stated (this §8) |
