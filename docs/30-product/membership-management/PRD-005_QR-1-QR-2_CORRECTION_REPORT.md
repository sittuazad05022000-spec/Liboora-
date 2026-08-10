# `PRD-005` — `QR-1`/`QR-2` Correction Report (v1.3 → v1.4)

| Field | Value |
|---|---|
| **Subject** | [`PRD-MEMBERSHIP-MANAGEMENT.md`](PRD-MEMBERSHIP-MANAGEMENT.md) — `PRD-005`, `BC-02` Membership |
| **Authorising review** | [`PRD-005_FOURTH_INDEPENDENT_REVIEW.md`](PRD-005_FOURTH_INDEPENDENT_REVIEW.md) — verdict **B — MINOR CORRECTIONS REQUIRED**, findings `QR-1` (MEDIUM) and `QR-2` (LOW) |
| **Version change** | **v1.3 → v1.4** |
| **Status after correction** | **DRAFT** — Stage 2. **Not frozen, not registered, not approved** |
| **Scope** | `QR-1` and `QR-2` **only** |
| **Date** | 2026-08-04 |
| **Commit** | **`fabc7e6`** — see §6 |

---

## 1. `QR-1` correction — the false claim about BC Map §7

### 1.1 What was wrong

v1.3's §12 note justified retaining `BC-28 (V2)` on this assertion:

> *"`BC-28` consequently has **no §7 row at all**, and neither do the other wholly-V2 contexts `BC-07`, `BC-08` and
> `BC-09`. Its absence from §7 is therefore **that table working as designed, not a defect**…"*

### 1.2 Verification against the primary source

I re-derived every relevant fact from the BC Map itself, parsing §7 (L294–363) into upstream/downstream sets rather
than grepping for a context name (the weaker test v1.3 relied on).

| Claim under test | Verified result | Evidence |
|---|---|---|
| `BC-28` is a V2 context | **TRUE** | BC Map L137; V2 roll-up L147 |
| BC Map §9 names `BC-28` a consumer | **TRUE** | L411 — `\| BC-02 \| membership.MembershipExpiringSoon \| BC-22, BC-28 \|` |
| §7 declares no edge to `BC-28` | **TRUE** | 0 occurrences of `BC-28` in L290–363 |
| §7 is scoped to V1 by its preamble | **TRUE** | L292 |
| **"No wholly-V2 context has a §7 row"** | **FALSE** | **`E-14` (L318)** — `BC-13` Trust & Safety (**V1**) → `BC-11`, `BC-12`, **`BC-14`**, **`BC-15`**. `BC-14`/`BC-15` are **V2** (L118/L119). `BC-14` is also upstream on **`E-22`** (L331) |
| **"wholly-V2" is a BC Map category** | **FALSE** | The string appears **0 times** in the BC Map |

**Conclusion.** V2 status does **not** entail absence from §7. The stated premise is falsified by the primary source,
so the inference *"absence is by construction, not a defect"* does not follow — and the parallel ground on which v1.3
rejected the third review's remedy (a) is **not established**.

### 1.3 What was changed

Four edits, all prose or gap-register entries.

1. **§12 note rewritten** (`MM-EVT-006`'s `(V2)` note). It now rests on **only** the three directly verified facts
   (V2 status L137/L147; §9 L411 names `BC-28`; §7 declares no edge to it), then states the honest position:

   > *"It does **not** establish that the absence is by construction… **§7 does declare edges whose consumers are V2
   > contexts** — `E-14` (line 318) runs from **V1** `BC-13` Trust & Safety to `BC-11`, `BC-12` and the **V2** contexts
   > `BC-14` and `BC-15`… So `BC-28`'s absence from §7 is consistent with two readings — a deliberate deferral of V2
   > orchestration edges, or an omission — and **the BC Map does not distinguish between them.** Which of the two it is
   > **is not a question this document may settle**."*

2. **Retention of `BC-28 (V2)` re-justified on the narrow true ground.** The *outcome* is unchanged; only its
   justification is repaired. §9 L411 names `BC-28`, so de-listing it would make §12 diverge from the Rank 4 Published
   Language; `MM-BR-035` already makes the `(V2)` annotation assert **no V1 edge and no V1 delivery obligation**; V1
   delivery of `MM-EVT-006` is to `BC-22` on `E-23` alone. The note now states explicitly that this holds **under
   either reading**, so *"no resolution of `MM-GAP-010a` can falsify anything in this document."*

3. **`MM-GAP-010a` added** (§25.2) — a new open question recording the `BC-28` §7 absence for the architecture owner,
   using the **suffixed-successor convention already established** by `MM-GAP-006a` and `MM-GAP-007a`. It poses the
   question (*deliberate deferral or omission?*), cites `E-14`/`E-22` as the reason V2 status alone does not settle it,
   and records disposition **"No"** — non-blocking, because the PRD is correct either way.

4. **`MM-GAP-010`'s false parenthetical removed.** It had excluded `BC-28` on the basis that *"no wholly-V2 context…
   has a §7 row. That absence is by construction."* Replaced by a neutral cross-reference: *"Related but tracked
   separately, because `BC-26` is V1 and `BC-28` is V2: the `BC-28` question is `MM-GAP-010a` below."*

5. **v1.3 history row annotated inline** (not rewritten), marking the justification superseded and pointing to `QR-1` —
   the same convention v1.3 applied to the v1.2 row and v1.2 applied to v1.1, so the reasoning each version actually
   published stays auditable.

### 1.4 Constraint compliance

| Constraint | Status |
|---|---|
| No BC edge invented | ✅ Zero edges asserted; `MM-BR-006` untouched |
| BC Map not modified | ✅ Object hash identical (§4) |
| No ADR created | ✅ 19 ADRs before and after |
| `BC-28` treated on verified facts only | ✅ Each cited line re-read and confirmed (§1.2) |
| `MM-GAP-010` aligned / successor used | ✅ Both — parenthetical corrected **and** `MM-GAP-010a` added per existing convention |
| `MM-BR-035` unchanged | ✅ Byte-identical (§4) |

---

## 2. `QR-2` correction — the residual universal claim in §23.1

### 2.1 What was wrong

§23.1's introduction asserted that `MM-NFR-014` *"holds for the **business-rule**, invariant, exclusion,
protected-operation and event registers as well as for the functional one."* It does not hold for the business-rule
register: **`MM-BR-012`, `MM-BR-022`, `MM-BR-027` and `MM-BR-028`** carry no verifying criterion under the strict
counting rule — as §0.2, §23.1's own note and §25.3 all state. This was the same false universal `TR-3` corrected at
§25.3, surviving one section earlier.

### 2.2 What was changed

Qualified to the measured position, naming the exceptions:

> *"…holds for the invariant, exclusion, protected-operation and event registers in full, and for **31 of the 35**
> business rules — `MM-BR-012`, `MM-BR-022`, `MM-BR-027` and `MM-BR-028` remain **uncovered** under the strict counting
> rule of §0.2 and are named as such in the note below, in §0.2 and in §25.3."*

### 2.3 Constraint compliance

**No coverage number or requirement was changed to make this true.** The claim was corrected to match the measurement,
not the reverse. Zero criteria added, deleted, weakened or manufactured — all **97** `MM-AC-*` rows are byte-identical
(§4). The figures 31/35, 77/81 and 134/223 were re-measured after the edit and are unchanged (§4).

---

## 3. Regression check

| Check | Baseline | Result |
|---|---|---|
| Identifiers removed | vs `5fc2bc3` (v1.3) | **0** |
| Identifiers removed | vs `a60a083` (v1.2) | **0** |
| Identifiers removed | vs `9735de1` (v1.1) | **0** |
| Identifiers added | vs `5fc2bc3` | **1** — `MM-GAP-010a` only (a `MM-GAP-*`, which carries **no obligation**) |
| `**MUST NOT**` | 104 | **104** — unchanged |
| `**MUST**` | 227 | **227** — unchanged |
| `**SHOULD**` / `**SHOULD NOT**` / `**MAY**` | 1 / 1 / 9 | **1 / 1 / 9** — unchanged |
| All 97 `MM-AC-*` rows | v1.3 | **byte-identical** — no criterion touched |
| All 35 `MM-BR-*` definitions | v1.3 | **byte-identical** |
| `MM-BR-035` | v1.3 | **byte-identical** |
| `MM-AC-075` row | v1.3 | **byte-identical** |
| All 7 `MM-EVT-*` register rows | v1.3 | **byte-identical** — `BC-28 (V2)` still listed, unchanged |
| Requirement definition lines removed | v1.3 | **0** |

**No requirement was added, deleted, weakened or renumbered. No scope, status value, event, payload or invariant
changed.** The one new identifier is an open question, not an obligation — which is why the obligation-bearing count
stays at 320.

---

## 4. Coverage — **unchanged**, and re-measured to prove it

Recomputed after the edits under §0.2's binding strict rule (identifier must appear in an `MM-AC-*` *Verifies*
**column**; prose never counts).

| Metric | v1.3 declared | v1.4 measured | Change |
|---|---|---|---|
| Rule registers (`BR`/`INV`/`XC`/`PO`/`EVT`) | 77/81 = 95.1% | **77/81 = 95.1%** | **none** |
| All criterion-verifiable obligations | 134/223 = 60.1% | **134/223 = 60.1%** | **none** |
| `MM-BR` | 31/35 | **31/35** | none |
| `MM-INV` | 12/12 | **12/12** | none |
| `MM-EVT` | 7/7 | **7/7** | none |
| `MM-XC` | 16/16 | **16/16** | none |
| `MM-PO` | 11/11 | **11/11** | none |
| `MM-FR` | 48/119 | **48/119** | none |
| `MM-NFR` | 7/14 | **7/14** | none |
| `MM-CFG` | 2/9 | **2/9** | none |
| Uncovered rules | 4 | **4** — `MM-BR-012`, `MM-BR-022`, `MM-BR-027`, `MM-BR-028` | none |

**Coverage is identical in every one of the ten figures.** Both findings were accuracy-of-prose defects; neither could
move a number, and neither was permitted to.

### Mechanical verification (post-correction)

| Check | Result |
|---|---|
| Register totals | **333** identifiers, **320** obligation-bearing, **13** `MM-GAP` — matches §0.2 as amended |
| Register contiguity | All 10 registers contiguous, **0 gaps** |
| Duplicate identifiers | **0** |
| Duplicate rule definitions | **0** |
| Duplicate `MM-AC-*` IDs | **0** |
| `MM-AC-*` rows | **97**, **0** with an empty *Verifies* cell |
| `MM-GAP-*` cited as a verifiable obligation | **0** |
| Phantom identifiers | **0** |
| §25.2 gap-table structure | all **11** `MM-GAP` rows 4 columns |
| BC Map line citations in new text | **9/9 verified** — L118, L119, L135, L137, L147, L292, L318, L331, L411 |
| Relative links repository-wide | **600**, **0 broken** |
| `flutter analyze` | **No issues found** |
| Ranked/frozen documents | **unchanged** — BC Map, frozen `PRD-004`, `MASTER_PRD`, `DOCUMENTATION_BASELINE`, `PRD_REGISTRY` all byte-identical (object-hash compared) |
| ADR count | **19** before and after |
| `PRD-005` registry status | **`PLANNED`** — not updated |

---

## 5. Files changed

| File | Change |
|---|---|
| `docs/30-product/membership-management/PRD-MEMBERSHIP-MANAGEMENT.md` | **Modified** — v1.3 → v1.4; 12 hunks, +39/−25 lines |
| `docs/30-product/membership-management/PRD-005_QR-1-QR-2_CORRECTION_REPORT.md` | **Created** — this report |

**Exactly two files.** Edit sites within the PRD: header version (L7); Supporting-documents row (L21); §0.2 `MM-GAP`
count row and totals paragraph; §12 `(V2)` note; §23.1 introduction; §25.2 `MM-GAP-010` row + new `MM-GAP-010a` row;
§25.3 contiguity row; v1.3 history row annotation; new v1.4 history row.

**Not touched:** any `MM-FR`/`MM-BR`/`MM-INV`/`MM-XC`/`MM-PO`/`MM-NFR`/`MM-CFG`/`MM-EVT` definition, any `MM-AC-*`
criterion, any architecture document, any ADR, `PRD_REGISTRY.md`, frozen `PRD-004`, any code, test or configuration.

---

## 6. Commit SHA and GitHub push status

| Field | Value |
|---|---|
| **Commit SHA** | **`fabc7e6`** (full: `fabc7e6859e7b252bd006d9da36cd0d0d51d94cb`) |
| **Branch** | `main` |
| **Remote** | `github` → `https://github.com/sittuazad05022000-spec/Liboora-.git` |
| **Push** | ✅ **Pushed** — `52ed87a..fabc7e6  main -> main` |
| **Unpushed commits** | **0** |
| **Working tree** | **clean** |

---

## 7. What was deliberately **not** done

| Withheld | Reason |
|---|---|
| Freeze `PRD-005` | Not authorised by this task — explicitly excluded |
| Update `PRD_REGISTRY.md` | Not authorised — `PRD-005` remains `PLANNED` |
| Create the Specification | Not authorised — explicitly excluded |
| Implementation / code changes | Not authorised — explicitly excluded |
| Create an ADR | Not authorised; and none is required (no edge added) |
| Modify BC Map or any frozen/ranked document | Not authorised; verified unchanged |
| Fifth independent review | Explicitly excluded — *"Correction ke baad STOP"* |
| Touch `F-1`…`F-4` or `TR-1`…`TR-5` | Out of scope. The only contact is the **annotation** of the v1.3 history row, required by `QR-1` itself, and it changes no outcome |
| Add features or requirements | Out of scope; register count of obligations unchanged at 320 |

---

## 8. Summary

Both findings from the fourth independent review are corrected, and **only** those two.

- **`QR-1`** — the false claim that wholly-V2 contexts have no BC Map §7 row is removed. `E-14` (L318) disproves it:
  V1 `BC-13` → V2 `BC-14`/`BC-15`. The §12 note now rests solely on facts I re-verified line by line, states plainly
  that the BC Map does not reveal whether `BC-28`'s absence is deliberate or an omission, and refers the question to
  the architecture owner as **`MM-GAP-010a`** instead of suppressing it. `BC-28`'s retention with its `(V2)` annotation
  is unchanged, now justified on ground that is actually true and correct under **either** reading.
- **`QR-2`** — §23.1's universal claim is qualified to the measured position (31 of 35 business rules), with the four
  uncovered rules named.

**No edge invented. No ADR. BC Map and every frozen/ranked document byte-identical. No requirement added, deleted,
weakened or renumbered. Coverage identical in all ten figures — 77/81 = 95.1% and 134/223 = 60.1%.** The PRD is
**v1.4, DRAFT** — not frozen, not registered, not approved, with no specification or implementation begun.

**A fifth independent review is required before freeze; it was not performed here, as instructed.**
