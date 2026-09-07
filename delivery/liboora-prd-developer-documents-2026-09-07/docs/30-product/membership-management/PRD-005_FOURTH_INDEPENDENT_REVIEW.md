# `PRD-005` v1.3 — Fourth Independent Review

| Field | Value |
|---|---|
| **Review** | Fourth independent review — adversarial, audit-only |
| **Subject** | [`PRD-MEMBERSHIP-MANAGEMENT.md`](PRD-MEMBERSHIP-MANAGEMENT.md) — `PRD-005`, `BC-02` Membership, **v1.3** |
| **Prior inputs verified** | [`PRD-005_SECOND_INDEPENDENT_REVIEW.md`](PRD-005_SECOND_INDEPENDENT_REVIEW.md) (`F-1`…`F-4`) · [`PRD-005_F1-F4_CORRECTION_REPORT.md`](PRD-005_F1-F4_CORRECTION_REPORT.md) · [`PRD-005_THIRD_INDEPENDENT_REVIEW.md`](PRD-005_THIRD_INDEPENDENT_REVIEW.md) (`TR-1`…`TR-5`) · [`PRD-005_TR-1-TR-5_CORRECTION_REPORT.md`](PRD-005_TR-1-TR-5_CORRECTION_REPORT.md) |
| **Architecture sources** | BC Map (Rank 4) · `ADR-0016` · `ADR-0018` · frozen `PRD-004` v1.2 · `DOCUMENTATION_BASELINE.md` · `PRD_REGISTRY.md` |
| **Reviewed at** | `5fc2bc3` (working tree clean) |
| **Date** | 2026-08-04 |
| **Mandate** | **Audit only.** Nothing fixed, nothing modified, no specification, no ADR, no implementation |
| **Verdict** | **B — MINOR CORRECTIONS REQUIRED** (§16) |

---

## 0. Verdict

> ### **B — MINOR CORRECTIONS REQUIRED**

Two findings, **`QR-1`** (MEDIUM) and **`QR-2`** (LOW). Both are **accuracy-of-stated-reasoning** defects in
explanatory prose. Neither changes a requirement, a register, a coverage figure, an event, an invariant or a scope
decision. `PRD-005` v1.3's **model is sound and its numbers are exact** — every coverage claim reproduced to the
digit, every register matched, zero regressions.

**Why not A.** `QR-1` is a **factually incorrect claim about the Bounded Context Map** that is load-bearing for
`TR-1`'s resolution. The v1.3 note asserts that V2 contexts do not appear in BC Map §7. **They do** — `BC-14` and
`BC-15` are both V2 and both receive a §7 edge (`E-14`). The *conclusion* v1.3 reaches survives on other grounds, but
the *stated reason* is falsified by the primary source. Since this document's own governance standard is
`MM-NFR-014` — *"a rule that cannot be checked SHALL be treated as unmet, not as satisfied by intent"* — and since the
third review's finding `TR-2` was raised for exactly this class of defect (a stated justification that does not survive
mechanical checking), it cannot be waived at the moment of freeze.

**Why not C.** Nothing structural is wrong. No requirement is missing, weakened, duplicated or unverifiable; no
architectural boundary is violated; the corrections to `F-1`…`F-4` and `TR-1`…`TR-5` are otherwise genuine and
complete. The fix for `QR-1` is a **prose correction of two or three sentences**, plus one sentence for `QR-2`.

---

## 1. Method

Every claim was re-derived from the primary source. Nothing in the two correction reports or the third review was
assumed correct — including, deliberately, my own prior work on the v1.3 pass.

- **Registers, coverage, traceability** — recomputed from the PRD text by script, not read from its declarations.
- **Architecture claims** — checked line-by-line against the BC Map, parsing §7 into upstream/downstream sets and §9
  into producer/consumer pairs, rather than by `grep` for a context name (the weaker test v1.3 relied on).
- **Regression** — diffed against **two** baselines: `a60a083` (v1.2, the immediate parent) and `9735de1` (v1.1,
  before the `F-1`…`F-4` pass), so that a defect introduced across the whole correction arc cannot hide.
- **Containment** — object-hash comparison of ranked/frozen documents at three commits.

---

## 2. Repository state

| Check | Result |
|---|---|
| HEAD | `5fc2bc3` |
| Working tree | **clean** |
| Files changed vs `a60a083` | **3** — third review, TR correction report, PRD |
| PRD version / status | **v1.3** / **`DRAFT`**, Stage 2 — correctly *not* frozen |
| `PRD_REGISTRY.md` | `PRD-005` = **`PLANNED`** (L225), `PLANNED` count **19** (L495) — correctly unchanged |
| ADR directory | **19 files** (18 ADRs + index) — none created |
| `flutter analyze` | `No issues found!` |
| Relative links | **589, 0 broken** |

---

## 3. Verification of `F-1` … `F-4` (second review)

| Finding | v1.3 state | Verdict |
|---|---|---|
| **`F-1`** `BC-26` listed as a consumer with no `BC-02`→`BC-26` edge | `BC-26` named consumer in **0 of 7** `MM-EVT-*` rows; absent from the header *Publishes to* row; §12 note records the refusal and the `PRD-004`/`SM-GAP-11` precedent | **FULLY RESOLVED** ✅ |
| **`F-2`** closure asserted but unenforceable | `MM-BR-035` present and normative — register **MUST** be closed at seven, changed only by a document version, never by an implementation. Analogue of frozen `SM-7.12` | **FULLY RESOLVED** ✅ (but see `QR-1` on its second clause) |
| **`F-3`** `endDate` recomputation contradiction | `MM-FR-057` formula unchanged (L473); `MM-FR-058` purity unchanged (L476); `MM-FR-057a` (L483) re-derives the **whole term** from a new `startDate`; §21 edge row (L940) explicitly forbids moving `endDate` while `startDate` is fixed | **FULLY RESOLVED** ✅ |
| **`F-4`** verification-coverage gap | 97 criteria, 0 empty *Verifies*, 0 `MM-GAP-*` cited as verifiable, four of five rule registers at 100% | **RESOLVED**, and v1.3 additionally corrected `F-4`'s own overstated metric | ✅ |

**No `F-*` finding has regressed.** Identifier set difference `9735de1` → HEAD: **empty** — nothing added by the
`F-1`…`F-4` pass was subsequently lost.

---

## 4. Verification of `TR-1` … `TR-5` (third review)

| Finding | v1.3 state | Verdict |
|---|---|---|
| **`TR-1`** `MM-BR-035` violated by its own table (`BC-28`) | Reachability clause narrowed to **V1** consumers; `(V2)` given enforceable meaning; `BC-28` retained annotated; `MM-AC-075` tightened to test the annotation rule. **Rule is no longer self-violating** | **RESOLVED in substance**; **stated justification is partly false** → `QR-1` |
| **`TR-2`** declared coverage not reproducible | §0.2 defines a binding strict counting rule; figures published with per-register breakdown; **both figures reproduced exactly** (§5) | **FULLY RESOLVED** ✅ |
| **`TR-3`** false *"Every…"* claim in §25.3 | Replaced by the measured statement; four unverified rules named; v1.2's claim explicitly marked false | **RESOLVED**; one residual same-class claim survives in §23.1's intro → `QR-2` |
| **`TR-4`** eight identifiers tested but untraced | 9 criteria amended; **all 9 verified genuine** (§6); AC count still 97; no duplicates | **FULLY RESOLVED** ✅ |
| **`TR-5`** `MM-GAP-010` too narrow | Broadened to the eleven-producer class with three candidate resolutions; `BC-28` explicitly excluded | **FULLY RESOLVED** ✅ (§8) |

---

## 5. Coverage claims — independently reproduced

Recomputed from the PRD text under the strict rule §0.2 declares binding (identifier must appear in an `MM-AC-*`
***Verifies* column**).

| Claim in PRD | Independently measured | Result |
|---|---|---|
| Rule registers **77/81 = 95.1%** | **77/81 = 95.1%** | ✅ **REPRODUCED** |
| All obligations **134/223 = 60.1%** | **134/223 = 60.1%** | ✅ **REPRODUCED** |
| `MM-BR-*` 31/35 | 31/35 | ✅ |
| `MM-INV-*` 12/12 · `MM-EVT-*` 7/7 · `MM-XC-*` 16/16 · `MM-PO-*` 11/11 | identical | ✅ |
| `MM-FR-*` 48/119 · `MM-NFR-*` 7/14 · `MM-CFG-*` 2/9 | identical | ✅ |
| Four uncovered rules = `MM-BR-012`, `MM-BR-022`, `MM-BR-027`, `MM-BR-028` | identical | ✅ |

**Every published figure is exact, including each of the eight per-register sub-figures.** The counting rule is stated,
strict, and the one under which the numbers reproduce — which is precisely what `TR-2` demanded. This is a material
improvement over v1.2, whose headline figure reproduced under no defensible rule.

---

## 6. *Verifies* references — genuineness

The risk with `TR-4` was manufacturing traceability: adding an ID to a *Verifies* cell where the criterion does not
actually test it. I inspected all 9 amended rows.

| Criterion | ID added | Criterion text substantively tests it? |
|---|---|---|
| `MM-AC-062` | `MM-EVT-001` | ✅ *"`MM-EVT-001`/`003`/`004` are emitted"* |
| `MM-AC-024` | `MM-EVT-002` | ✅ *"…and emits `MM-EVT-002`"* |
| `MM-AC-040` | `MM-EVT-003` | ✅ *"Renewal emits exactly one `MM-EVT-003`"* |
| `MM-AC-049` | `MM-EVT-004` | ✅ *"`MM-EVT-004` carries `priceDifference`…"* |
| `MM-AC-042` | `MM-EVT-005` | ✅ *"emits `MM-EVT-005` exactly once…"* |
| `MM-AC-043` | `MM-EVT-006` | ✅ *"`MM-EVT-006` fires once per threshold crossing"* |
| `MM-AC-081` | `MM-EVT-006` | ✅ *"`MM-EVT-006` and the view read the same `MM-CFG-008`"* |
| `MM-AC-027` | `MM-PO-003` | ✅ *"A user holding `MM-PO-003` but not `MM-PO-004`…"* |
| `MM-AC-026` | `MM-PO-004` | ✅ *"Manual activation requires `MM-PO-004`…"* |

**All 9 genuine. No false verification claim.** Each ID was named in the criterion body already; only the traceability
cell was incomplete. This is the honest form of the repair — a **traceability** fix, not a coverage inflation, exactly
as the correction report claims.

The 16 rows whose *Verifies* cells carry non-identifier values (`§17`, `§15`, `§6.3`, `Edge 1/14/18/19/26`, `E-10`,
`PRD-004 SM-2.7`) are **legitimate**: each cites a real section, a real declared edge or a real frozen requirement, and
each also carries at least one `MM-*` identifier or points at a genuine governing section. Not dangling.

---

## 7. `MM-BR-035` — architecture and governance validity

**Clause 1 (closure at seven, changeable only by a document version).** **Valid.** Verified against primary sources:

- BC Map **L426** closes the `BC-10` register by *delegating it to that context's Rank 3 PRD* — establishing that
  register closure is a Rank 3 responsibility.
- BC Map **L399** self-describes §9 as the *"seed of the full Event Catalog"*, an artefact that does not yet exist.
- BC Map **L292** — the only ADR trigger in the document — is scoped to **edges**, not to event registers.
- Frozen `PRD-004` §7.4 declares a closed set of **ten** `BC-01` events where §9 lists **four**, ratified by
  `ADR-0018` with no BC Map amendment. Established, ratified practice.

**Clause 2 (V1-consumer reachability + `(V2)` semantics).** **Governance-valid, reasoning partly false.** The clause
itself is sound and, importantly, **self-consistent** — the table it governs no longer violates it, which was the
whole of `TR-1`. `MM-AC-075` correctly tests all three of its conjuncts. But the note justifying it makes a false claim
about §7 → **`QR-1`**.

**No Rank-boundary violation.** The PRD amends only its own Rank 3 text, invents no edge, creates no ADR, and refers
the unresolved Rank 4 question upward — the treatment `ADR-0016` and `ADR-0018` jointly establish as correct.

---

## 8. `BC-28` V2 handling · `MM-GAP-010` scoping

**`MM-GAP-010` is correctly scoped.** ✅ Independently reproduced: BC Map §9 names `BC-26` a consumer for **eleven**
producing contexts (`BC-01`, `BC-02`, `BC-03`, `BC-04`, `BC-05`, `BC-10`, `BC-11`, `BC-12`, `BC-18`, `BC-20`, `BC-27`),
while §7 declares an inbound edge to `BC-26` from **exactly one** (`E-26`, from `BC-27`, L335). Ten relationships are
asserted with no §7 edge. The gap states the class, names the `BC-01`/`SM-GAP-11` sibling, poses the general
Published-Language question, offers three candidate resolutions, and remains **non-blocking** with the architecture
owner. This is a genuine improvement on v1.2's single-instance framing and satisfies `TR-5` fully.

**`BC-28` handling: the outcome is defensible; the reasoning is not.** The `(V2)` annotation plus `MM-BR-035`'s
enforceable *"asserts no V1 edge and no V1 delivery obligation"* is a sound, conservative treatment. It invents no
edge, modifies no BC Map, creates no ADR, and V1 delivery is `BC-22` on `E-23` alone. **But see `QR-1`.**

---

## 9. Finding `QR-1` — MEDIUM — the "wholly-V2 contexts have no §7 row" claim is false

### 9.1 The claim

§12's `BC-28` note (PRD L1050–1055) states:

> *"BC Map **§7** is scoped, by its own preamble at line 292, to "every edge that crosses a context boundary **in
> V1**". `BC-28` consequently has **no §7 row at all**, and neither do the other wholly-V2 contexts `BC-07`, `BC-08`
> and `BC-09`. Its absence from §7 is therefore **that table working as designed, not a defect**."*

The same reasoning is restated in the v1.3 change-history row and in the correction report §3.1, where it is the stated
basis for rejecting the third review's remedy (a).

### 9.2 The evidence that falsifies it

I parsed §7 (L294–363) into upstream and downstream context sets and cross-referenced the version column of the
context register (L100–150):

| V2 context | Appears in §7? | Role |
|---|---|---|
| `BC-07` Staff & Shift | No | — |
| `BC-08` Inventory | No | — |
| `BC-09` Visitor | No | — |
| **`BC-14` Content Sharing** | **YES** | **downstream of `E-14`**, and upstream on `E-22` |
| **`BC-15` Community & Groups** | **YES** | **downstream of `E-14`** |
| `BC-28` Workflow Orchestration | No | — |

`E-14` (BC Map **L318**) reads:

> `| E-14 | BC-13 Trust & Safety | BC-11, BC-12, BC-14, BC-15 | PL | Event | EnforcementActionTaken{...} → each context self-restricts |`

`BC-13` is **V1**; `BC-14` and `BC-15` are **V2** (L118, L119). So **§7 contains a declared edge from a V1 producer to
V2 consumers.** Three consequences:

1. **The stated premise is false.** V2 contexts *can* and *do* hold §7 rows. "Wholly-V2" is not a BC Map category —
   the string appears **0 times** in the document — so it cannot be doing the work the note assigns to it. `BC-14`
   and `BC-15` are as wholly-V2 as `BC-28` and are nonetheless in the table.
2. **The inference does not follow.** Because §7 *does* declare V1→V2 edges, `BC-28`'s absence is **not** demonstrably
   "the table working as designed". It is equally consistent with the *same* omission class as `BC-26` — and therefore
   with the third review's remedy (a). The correction report's stated ground for rejecting remedy (a) —
   *"would record a defect that does not exist"* — is **not established** by the evidence cited.
3. **`MM-EVT-006`'s `BC-28` is now the sole V2 consumer named in §9 with no §7 edge**, which by symmetry with `BC-14`
   and `BC-15` is at least *arguably* an omission rather than a design intent.

### 9.3 What is *not* wrong

- **`MM-BR-035` is still internally consistent** — the rule and its table agree. `TR-1`'s actual defect is fixed.
- **The conservative outcome is still defensible** on a narrower and true ground: BC Map §9 L411 names `BC-28`, no §7
  edge to it exists, `BC-28` is V2, this PRD is V1, and the `(V2)` annotation asserts nothing about V1. Whether the
  absence is by design or an omission, `PRD-005` behaves identically and correctly.
- **No requirement, event, payload or scope decision depends on the false premise.**

### 9.4 Severity — and why it must be corrected before freeze

MEDIUM. The defect is confined to justification prose, but:

- It is a **false statement about a Rank 4 document** inside a document that would become Rank 3 on freeze, and it
  would be **frozen into the baseline**.
- It **suppresses a possible architectural defect**: it tells the architecture owner, in effect, "there is nothing to
  look at here", and `MM-GAP-010` explicitly excludes `BC-28` on this basis. If the absence *is* an omission, freezing
  this text buries it.
- `DOCUMENTATION_BASELINE.md` §4: ***"A conflict is a defect. If you find one, do not choose — raise it."*** The
  correction pass chose, on a false premise, rather than raising.
- It is the **same class** as `TR-2`: a stated justification that does not survive mechanical checking.

### 9.5 Recommended correction (for the owner; **not applied here**)

Confine the claim to what is true, and stop excluding `BC-28` from the gap on a false basis. Concretely:

1. In §12's `BC-28` note, **delete or correct** the assertion that V2 contexts have no §7 row; state instead the true
   position — *`BC-28` has no §7 row; §7 does declare some V1→V2 edges (`E-14` → `BC-14`/`BC-15`), so whether
   `BC-28`'s absence is deliberate or an omission is **not determinable from the BC Map** and is not a question this
   document may settle.*
2. Justify retention of the `(V2)` annotation on the **true** narrow ground (§9.3 above) — it asserts no V1 edge either
   way, so `PRD-005` is correct under both readings.
3. Extend **`MM-GAP-010`** (or add a non-blocking successor observation in §25.2, consistent with the existing
   `MM-GAP-006a`/`007a` convention) to record the `BC-28` question for the architecture owner instead of excluding it.
4. Align the v1.3 change-history row and the TR correction report §3.1 to the corrected reasoning.

**No requirement changes. No ADR. No BC Map modification. No edge invented.** Prose and one gap entry only.

---

## 10. Finding `QR-2` — LOW — residual `TR-3`-class claim in §23.1's intro

**PRD L1571–1573** still reads:

> *"Each criterion verifies a rule that previously had **no** verifying criterion, so that `MM-NFR-014` … **holds for**
> the business-rule, invariant, exclusion, protected-operation and event registers as well as for the functional one."*

`MM-NFR-014` requires **every** rule to be falsifiable by a test. It does **not** hold for the business-rule register:
`MM-BR-012`, `MM-BR-022`, `MM-BR-027` and `MM-BR-028` carry no verifying criterion — as the very same subsection
concedes 40 lines later, and as §0.2 and §25.3 now state plainly.

This is the identical defect `TR-3` corrected at §25.3, surviving one section earlier. `TR-3`'s instruction was to
correct *"the false 'Every…' claim in §25.3"*, and that specific sentence was corrected; this sibling was missed.

**Severity: LOW** — the true figures appear in §0.2, §23.1's own note and §25.3, so a reader is not misled for long,
and nothing normative depends on it.

**Recommended correction:** qualify to *"holds for the invariant, exclusion, protected-operation and event registers,
and for 31 of 35 business rules"*, or *"holds for the functional register and, with four `MM-BR-*` exceptions named
below, for the rule registers."*

---

## 11. Regression audit

| Check | Baselines | Result |
|---|---|---|
| Requirements deleted | vs `a60a083` **and** vs `9735de1` | **none** — set difference empty in both ✅ |
| Requirements renumbered | per-register set equality | **identical** ✅ |
| Requirements weakened | modal-verb census vs v1.1: `MUST NOT` 99→**104**, `MUST` 221→**227**, `SHOULD` 1→1, `MAY` 8→**9** | **strengthened, never downgraded** ✅ |
| Register contiguity | all 10 | **0 gaps** ✅ |
| Duplicate identifiers | all 10 | **0** ✅ |
| Duplicate rule definitions | `MM-BR-*`, `MM-FR-*` em-dash definition sites | **0** ✅ |
| Dangling references | cited − defined | **0** ✅ |
| Phantom `MM-FR-119` | literal scan | **0** ✅ |
| AC rows | table parse | **97** = declared ✅ |
| Duplicate AC IDs / criterion text | scan | **0 / 0** ✅ |
| Empty *Verifies* | 97 rows | **0** ✅ |
| `MM-GAP-*` cited as verifiable | scan | **0** ✅ |
| Declared totals | 332 / 320 / 12 | **all three reproduced** ✅ |
| Links | `docs/**` | **589, 0 broken** ✅ |
| Dart analysis | `flutter analyze` | **clean** ✅ |

**No new architectural conflict introduced.** §25.1 still records 8 conflicts (`C-1`…`C-8`), none silently resolved;
no new edge appears anywhere in the PRD; `MM-BR-006` still lists exactly the ten pre-declared edges.

---

## 12. Scope audit — V1 / V2 / V3

| Item | Required position | v1.3 | ✅ |
|---|---|---|---|
| **Membership Analytics** | **not V1** — V3 per EA 734 (V2 per 837/1607, recorded as `C-1`) | §9 heading *"explicitly NOT V1"* (L881); §22 row *"**V3** per EA line 734"* (L1498); `MM-XC-006` present; `C-1` intact (L1731) | ✅ **still V3** |
| Freeze / Unfreeze | V2, excluded | `MM-INV-012` + `MM-XC-008`; `Frozen`/`Unfrozen` absent from the event register | ✅ |
| Downgrade · Transfer · Cancellation-with-refund · Proration | V2, excluded | `MM-XC-009`…`MM-XC-012` present | ✅ |
| Auto Renewal | V3, excluded | `MM-XC-007` present | ✅ |
| Cross-Library Membership | Future, excluded | `MM-XC-013` present | ✅ |
| Saga-based renewal | V2 (`BC-28`) | §22 row intact; V1 uses two-stage flow + reconciliation queue | ✅ |
| Event register | closed at 7 | exactly 7 rows, `MM-BR-035` enforces | ✅ |

**No V1 scope expansion. No new feature. No capability added.** v1.3 added zero identifiers.

---

## 13. Frozen / ranked document containment

| Document | Rank | Result |
|---|---|---|
| `MASTER_PRD.md` | 1 | untouched ✅ |
| `docs/00-governance/adr/` | 2 | untouched — **19 files**, no ADR created ✅ |
| `Student_Management_PRD_v1.md` (**FROZEN** v1.2) | 3 | untouched ✅ |
| `LIBOORA_BOUNDED_CONTEXT_MAP.md` | 4 | **object hash `9dd7241…` identical at `9735de1`, `a60a083` and HEAD** ✅ |
| Rulings · EA · Config Guide | 5–7 | untouched ✅ |
| `PRD_REGISTRY.md` | — | untouched; `PRD-005` still **`PLANNED`**, count **19** ✅ |
| `authentication/`, `library/` | 3 | untouched ✅ |
| `lib/`, `test/`, `tool/`, `pubspec.yaml` | — | untouched ✅ |
| Prior review / correction reports | — | not edited ✅ |

`git diff --stat a60a083` restricted to all ranked/frozen paths returns **empty**.

---

## 14. Findings summary

| ID | Severity | Finding | Blocks freeze? |
|---|---|---|---|
| **`QR-1`** | **MEDIUM** | §12's `BC-28` note claims V2 contexts have no BC Map §7 row. **False** — `BC-14` and `BC-15` are V2 and both receive `E-14`. The premise used to reject the third review's remedy (a), and to exclude `BC-28` from `MM-GAP-010`, is not established | **Yes** — a false Rank 4 claim would be frozen into the baseline, and a possible architectural omission suppressed |
| **`QR-2`** | **LOW** | §23.1's intro still asserts `MM-NFR-014` *"holds for"* the business-rule register; four `MM-BR-*` are unverified. Same class as `TR-3`, one section earlier | **No** on its own — but should be corrected in the same pass |

**Verified genuinely resolved and not re-raised:** `F-1`, `F-2`, `F-3`, `F-4`, `TR-2`, `TR-4`, `TR-5`; `TR-1` in
substance; both coverage figures; all 9 *Verifies* additions; all registers, counts, IDs and links; zero regressions;
scope intact; Analytics still V3; frozen/ranked documents untouched.

---

## 15. Recommended corrections

1. **`QR-1`** — Correct §12's `BC-28` note to the true position (`BC-28` has no §7 row; §7 *does* declare V1→V2 edges,
   so the reason for the absence is not determinable from the BC Map). Retain the `(V2)` annotation on the narrow true
   ground. Record the `BC-28` question for the architecture owner — extend `MM-GAP-010` or open a non-blocking
   successor observation per the `MM-GAP-006a`/`007a` convention — instead of excluding it. Align the v1.3
   change-history row and TR correction report §3.1.
2. **`QR-2`** — Qualify §23.1's intro sentence to the measured position, naming the four `MM-BR-*` exceptions.
3. **Version** — v1.3 → **v1.4** with a change-history row, per the convention applied at v1.1, v1.2 and v1.3.
4. **Then re-verify** — `MM-AC-075` and `MM-BR-035` remain consistent; coverage figures are unaffected (no criterion
   changes); registers unchanged.

**Not required:** no ADR · no BC Map modification · no new requirement · no scope change · no recomputation of
coverage. Both corrections are Rank 3 prose plus one gap entry.

---

## 16. Final verdict

> ## **B — MINOR CORRECTIONS REQUIRED**

`PRD-005` v1.3 is a **substantially sound document**. All four second-review findings and four of five third-review
findings are genuinely and fully resolved; the fifth (`TR-1`) is resolved in substance. Its coverage figures are now
**exactly reproducible** — 77/81 and 134/223, with all eight per-register sub-figures matching — under a counting rule
that is explicitly stated and strict enough that prose cannot inflate it. Registers, IDs, contiguity, traceability and
links are all clean; no requirement was deleted or weakened; no scope expanded; Membership Analytics remains
correctly not-V1; and every frozen and ranked document is byte-identical.

It is **not yet ready to freeze.** `QR-1` would freeze a demonstrably false statement about the Bounded Context Map
into the baseline, and would suppress a possible Rank 4 omission that this document's own governance rule
(*"a conflict is a defect… do not choose — raise it"*) requires to be raised rather than argued away. That is a
two-sentence prose correction plus one gap entry — but it must happen **before**, not after, the freeze.

**Per the governing instruction, because the verdict is not A — PASS:**

- `PRD-005` **has NOT been frozen**.
- `PRD_REGISTRY.md` **has NOT been updated** — `PRD-005` remains **`PLANNED`**.
- The **Specification has NOT been started**.
- **Implementation has NOT been started**.
- **Recommended next cycle:** correct `QR-1` and `QR-2` → bump to **v1.4** → fifth independent review (or a targeted
  re-verification of `QR-1`/`QR-2` plus a regression pass) → freeze only on a verdict of **A**.

---

## 17. Evidence index

| # | Claim | Method | Result |
|---|---|---|---|
| 1 | Coverage 77/81, 134/223 | script, strict *Verifies*-column rule | reproduced exactly |
| 2 | 8 per-register sub-figures | script | all match |
| 3 | Registers = declared (332/320/12) | script | all match |
| 4 | Contiguity, duplicates, dangling, phantom | script, 10 registers | 0/0/0/0 |
| 5 | AC rows, empty *Verifies*, `MM-GAP-*` cited | table parse | 97 / 0 / 0 |
| 6 | 9 `TR-4` additions genuine | manual row-by-row read | all 9 genuine |
| 7 | `BC-26` not a consumer of any event | `MM-EVT-*` consumer-column parse | 0 of 7 |
| 8 | §7 preamble V1-scoped | BC Map L292 verbatim | confirmed |
| 9 | `BC-28` is V2, no §7 row | BC Map L137/L147; §7 scan | confirmed |
| 10 | **V2 contexts `BC-14`/`BC-15` DO have §7 rows** | §7 upstream/downstream parse + register version join | **confirmed → `QR-1`** |
| 11 | "wholly-V2" not a BC Map category | literal scan | 0 occurrences |
| 12 | `BC-26`: 11 producers in §9, 1 inbound edge in §7 | §9/§7 parse | confirmed |
| 13 | `MM-GAP-010` scope | text inspection | class-scoped, non-blocking |
| 14 | Regression vs v1.1 **and** v1.2 | dual set difference | empty both |
| 15 | Normative strength | modal-verb census | strengthened |
| 16 | Frozen/ranked containment | object hashes at 3 commits + path-scoped diff | identical / empty |
| 17 | ADR count | directory listing | 19, none created |
| 18 | Registry status | L225 / L495 | `PLANNED` / 19 |
| 19 | Scope + Analytics V3 | `MM-XC-*` presence, §9/§22/§25.1 | intact |
| 20 | Links | resolver over `docs/**` | 589, 0 broken |
| 21 | `flutter analyze` | executed | clean |
| 22 | Working tree | `git status --porcelain` | clean |
| 23 | `MM-NFR-014` vs §23.1 intro | text comparison | **contradiction → `QR-2`** |

---

## 18. Files changed by this review

**Exactly one file created:** `PRD-005_FOURTH_INDEPENDENT_REVIEW.md` (this document).

**Nothing was fixed, modified, specified or implemented.** `PRD-MEMBERSHIP-MANAGEMENT.md` is byte-identical to
`5fc2bc3`. No ADR created. No BC Map change. No code touched. `PRD-005` remains **`DRAFT`**, Stage 2, **`PLANNED`** in
the registry.

| Field | Value |
|---|---|
| **Reviewed at** | `5fc2bc3` |
| **Verdict** | **B — MINOR CORRECTIONS REQUIRED** |
| **Findings** | `QR-1` (MEDIUM), `QR-2` (LOW) |
| **Freeze** | **withheld** |

---

*End of fourth independent review.*
