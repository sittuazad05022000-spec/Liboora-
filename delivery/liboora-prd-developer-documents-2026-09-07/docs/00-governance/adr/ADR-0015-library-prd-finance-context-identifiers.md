# ADR-0015 — The Library PRD's three finance rows name the wrong bounded contexts

| Field | Value |
|---|---|
| **Status** | **Accepted** — 2026-08-04 |
| **Date** | 2026-08-04 |
| **Deciders** | Architecture Review Board, acting through the Architecture Owner role defined in `PRD_OWNERSHIP_MODEL.md` §2.2 |
| **Supersedes** | — |
| **Amends** | `docs/30-product/library/Library_PRD_v1.md` (Rank 3) — **three table cells**, lines 136, 904 and 1103. **No requirement text, no business rule, no `LIB-*`/`LXC-*` identifier and no ownership boundary changes.** Executed, see §7 |
| **Amended by** | — |
| **Baseline** | `BASELINE-2026-08-04-B` |
| **Related** | `PGA-01` · `ADR-0013` (the other Library PRD amendment in the same commit) · BC Map §3.2 lines 100, 129, 202–204 · Master PRD §8 modules 5 and 17 |

> ✅ **ACCEPTED 2026-08-04. The migration in §7 has been executed.**
>
> This ADR corrects a **citation defect**, not a design decision. Three rows in the Library PRD point at
> `BC-11`…`BC-13` — the Social cluster — where they mean the two finance contexts. The *statement* each row makes
> is already correct; only the identifiers are wrong.

---

## 1. Context

`PRD_GAP_ANALYSIS.md` records `PGA-01`: the Library PRD attributes money handling to `BC-11`…`BC-13`. Verified
against the primary source, three rows carry the wrong identifier:

| Line | Row, verbatim |
|---|---|
| 136 | `` | `LXC-7` | Hold money, price anything, or issue a receipt | `BC-11`…`BC-13` | Finance PRD | `` |
| 904 | `` | Revenue & Finance | `BC-11`…`BC-13` | Read projection — never authoritative here | Library ← | `` |
| 1103 | `` | Invoice, payment, revenue | `BC-11`…`BC-13` | Reads projection | `` |

### 1.1 What `BC-11`…`BC-13` actually are

Per the Bounded Context Map §3.2 — the Rank 4 authority on context identity:

| Context | Name | Classification |
|---|---|---|
| `BC-11` | Social Graph | `[SUPPORTING]` |
| `BC-12` | Messaging | `[SUPPORTING]` |
| `BC-13` | Trust & Safety | `[CORE]` |

None of the three handles money. The range is the **Social cluster**, shrunk to exactly `BC-11`…`BC-13` by
`ADR-0011` when `BC-10` was moved to rank 7.5 — which is the most likely origin of the slip: a three-context
range was written from memory of the wrong cluster.

### 1.2 What the finance contexts actually are

LIBOORA deliberately splits money by **direction**, and the BC Map is explicit about it (lines 100, 129, and the
ubiquitous-language disambiguation table at lines 202–204):

| Context | Name | Class | Owns |
|---|---|---|---|
| **`BC-05`** | **Fee & Collection** | `[CORE]` | Money owed by a **student to the library** — fee structures, dues, receipts, discounts, refunds, cash reconciliation |
| **`BC-20`** | **Subscription & Billing** | `[GENERIC]` | Money owed by a **library to LIBOORA** — plans, subscriptions, invoices, gateway, dunning, revenue recognition |

`Payment`, `Plan` and `Invoice` are each listed in the BC Map as terms that mean **different things** in these two
contexts (`FeePayment` vs `SubscriptionCharge`; `MembershipPlan` vs `SubscriptionPlan`; `FeeDue` vs
`SubscriptionInvoice`). A single citation collapsing both into one range is therefore not merely wrong, it erases a
distinction the map treats as load-bearing.

### 1.3 Why this is Medium severity, not High

All three rows say the same thing about authority:

- `LXC-7` is an **exclusion** — *"Hold money, price anything, or issue a receipt"* is listed as something the
  Library PRD explicitly does **not** do.
- Line 904 says *"Read projection — **never authoritative here**"*.
- Line 1103 says *"Reads projection"*.

**The ownership boundary these rows assert is already correct.** The Library domain reads finance data and never
owns it, which is exactly what `BC-05`/`BC-20` ownership requires. No requirement was written against the wrong
model; no code was built to the wrong model. The defect is that a reader following the citation lands in the Social
cluster and finds nothing about money.

Had any row claimed the Library PRD *owned* the finance context, this would be a High-severity ownership conflict
requiring a scope decision. It does not.

---

## 2. Decision

**The three cells are corrected to name `BC-05` Fee & Collection and `BC-20` Subscription & Billing.**
Both are named, because the Library domain sits on the read side of both directions of money: it collects fees from
students (`BC-05`) and it is itself billed by LIBOORA (`BC-20`).

**Nothing else changes.** Specifically:

- `LXC-7`'s exclusion text is untouched — the Library PRD still does not hold money, price anything or issue a receipt.
- The *"never authoritative here"* and *"Reads projection"* qualifiers are untouched.
- No `LIB-*`, `LXC-*`, `LCFG-*`, `LEV-*` or `LAC-*` identifier is added, removed, renumbered or reworded.
- No aggregate moves. No edge is added — the Library↔finance read paths already exist in the BC Map §7.3.

### 2.1 The "Finance PRD" pointer in `LXC-7`

`LXC-7`'s fourth cell reads *"Finance PRD"*. There is no document by that name. The correct destinations are
Master PRD §8 **module 5** (Fee & Payment Management → `BC-05`) and **module 17** (SaaS Billing → `BC-20`, which
`PRD_REGISTRY.md` §4.3 registers as `PRD-022`). The cell is corrected to point at the two owning PRDs rather than
a document that does not exist.

---

## 3. Options considered

| # | Option | Verdict |
|---|---|---|
| 1 | Correct the three cells to `BC-05` and `BC-20` | **Chosen.** Smallest change that makes the citation resolve |
| 2 | Correct to `BC-05` only | **Rejected.** Line 904's row is headed *"Revenue & Finance"* and line 1103 names *"Invoice… revenue"* — `BC-20` terms. Dropping `BC-20` would trade one wrong citation for an incomplete one |
| 3 | Leave the identifiers and add a footnote | **Rejected.** Leaves a Rank 3 document asserting something false about a Rank 4 document. Precedence says the lower-ranked document is *wrong*, not that it may be annotated |
| 4 | Renumber `BC-05`/`BC-20` into an `BC-11`…`BC-13`-adjacent range | **Rejected outright.** Renumbering 31 contexts to match a typo inverts the precedence order and would invalidate every existing citation |
| 5 | Defer until a Finance PRD exists | **Rejected.** The defect is a wrong pointer, and it is wrong today. Its correction does not depend on any document being written |

---

## 4. Consequences

### 4.1 Positive

- A reader following `LXC-7` reaches the contexts that actually own money.
- The `Payment`/`Plan`/`Invoice` direction split the BC Map protects is no longer collapsed by a Rank 3 citation.
- `PGA-01` closes without any requirement change.

### 4.2 Negative

- A second amendment to a frozen Rank 3 document on the same day as `ADR-0013`. Both are in the same commit and
  the same `v1.1` changelog row, so the document's history shows one version bump, not two.

### 4.3 Risks

| Risk | Severity | Mitigation |
|---|---|---|
| Read as giving the Library domain finance authority | Medium | The *"never authoritative here"* / *"Reads projection"* qualifiers are preserved verbatim in all three rows, and `LXC-7` remains an **exclusion** |
| Used as precedent for editing frozen documents to fix "obvious" typos without an ADR | **High** | This ADR authorises **three named cells in one named file**. The requirement for an ADR-before-change is unchanged; the next correction needs its own ADR, however small |

---

## 5. Traceability impact

| Register | Impact |
|---|---|
| `LIB-*` (129 unique ids) | **None** |
| `LXC-1`…`LXC-10` | **None.** `LXC-7`'s exclusion text is unchanged; only its context citation and PRD pointer change |
| `LCFG-*`, `LEV-*`, `LAC-*`, `PO-*` | **None** |
| `BC-01`…`BC-31` | **None.** No context added, removed, renamed or reclassified |
| `E-01`…`E-26` | **None.** No edge added — unlike `PGA-02`, which does require one (`ADR-0016`) |
| `X-01`…`X-14` | **None** |
| `IMPL-*`, `TASK-*` | **None** |

**Net traceability impact: zero identifiers.**

---

## 6. Compliance

| # | Check | Expected |
|---|---|---|
| 1 | `grep -c 'BC-11…BC-13' Library_PRD_v1.md` | **0** occurrences in a finance context |
| 2 | Requirement identifier set diff vs pre-amendment | **Empty** — 129 `LIB`, 10 `LXC`, 10 `LCFG`, 22 `LEV`, 12 `LAC` |
| 3 | `dart run tool/check_module_boundaries.dart` | Unchanged output — this ADR touches no code and no manifest |
| 4 | Link validation | `LXC-7`'s new PRD pointer resolves |

---

## 7. Migration requirements — **executed 2026-08-04**

| # | Change | Document | Rank | Executed |
|---|---|---|---|---|
| **M1** | Line 136 — `LXC-7`: context cell `BC-11`…`BC-13` → `BC-05`, `BC-20`; PRD cell *"Finance PRD"* → the two owning PRDs | `Library_PRD_v1.md` | **3** | ✅ |
| **M2** | Line 904 — Revenue & Finance row: context cell corrected | same | **3** | ✅ |
| **M3** | Line 1103 — Invoice/payment/revenue row: context cell corrected | same | **3** | ✅ |
| **M4** | Covered by the same **v1.1** changelog row as `ADR-0013` — no second version bump | same | **3** | ✅ |
| **M5** | Close `PGA-01` | `PRD_GAP_ANALYSIS.md` | unranked | ✅ |
| **M6** | Register this ADR | `ADR-INDEX.md` | — | ✅ |

**Not required:** no baseline re-issue beyond the one `ADR-0013` already triggers; no change to the BC Map, the
Dependency Matrix, `module_dependencies.yaml`, any other PRD, or any `lib/` source file.

---

## 8. Change history

| Date | Change |
|---|---|
| 2026-08-04 | Created and **Accepted** in the same Governance Closure Phase sitting. The finding was verified against the primary source before the ADR was written — `sed -n '136p;904p;1103p'` on the Library PRD and BC Map lines 100/129/202–204 — rather than trusted from the gap analysis. Five options considered, four rejected. Three table cells corrected; **zero requirement identifiers affected.** |
