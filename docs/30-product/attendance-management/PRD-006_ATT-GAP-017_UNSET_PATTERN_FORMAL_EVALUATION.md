# `ATT-GAP-017` — Formal Evaluation of the `SEAT-CFG-017` "Unset in V1" Pattern

| Field | Value |
|---|---|
| **Version** | v1.0 · 2026-08-04 |
| **Instruction** | Request BQ-2 / CF-2 — *"existing frozen `SEAT-CFG-017` precedent ke 'Unset in V1 — no value is substituted' pattern ko candidate resolution ke roop mein formally evaluate karo"* |
| **Method** | Predicate-by-predicate structural comparison against the frozen `PRD-007` precedent. Every claim computed from the repository. |
| **Verdict** | 🟡 **PARTIALLY PERMITTED — and insufficient to close `ATT-GAP-017`** |
| **Ceiling** | Option E can supply **at most 3 of the 8 missing answers** (§4). `ATT-GAP-017` requires 14; best case reaches **9 of 14**. |
| **Product Owner decision** | ⛔ **REQUIRED — NOT ASSUMED** (§6). Two distinct authorisations are needed, not one. |
| **Correction issued** | ⚠️ This document **narrows** the conclusion of `PRD-006_ATT-GAP-017_UNSET_DEFAULT_ROUTE_ANALYSIS.md` §5. See §7. |
| **`PRD-006` §16.3** | **NOT amended.** §5 states why the precondition remains unmet. |

---

## 1 · What the precedent actually says

Read verbatim from the **frozen, Rank 3** `PRD-SEAT-MANAGEMENT.md`.

**L1890 — the register row:**

> `| SEAT-CFG-017 | Occupancy percentage that emits SEAT-EVT-004 | BC-06 via E-05 | **Unset in V1 — no event is emitted and no value is substituted** (explicit unset behaviour per SEAT-FR-265); **90%** applies only once E-05 carries the threshold (SEAT-GAP-005) | **Integer 1–100, or unset** | §24.1, SEAT-FR-241, SEAT-FR-265, SEAT-FR-267 |`

**L1859–1868 — `SEAT-FR-265`, the rule that licenses it:**

> *"Where a configurable is unset and the table below states a default, the default **MUST** apply. The module **MUST NOT** treat an unset configurable as *unlimited*, *permitted* or *disabled* except where the default column says so explicitly. **Exactly one row exercises that escape clause** — `SEAT-CFG-017`, **the only configurable in §27.1 whose value domain admits `unset`** — and its Default column states its unset behaviour explicitly."*

**L2229 — the gap's declared impact:**

> `| SEAT-GAP-005 | … | Architecture | **None.** SEAT-FR-241 emits nothing while unset |`

Three properties of the precedent are load-bearing and must be carried across intact:

1. The **value domain itself is resolved** — `Integer 1–100`. The `unset` is an *additional admitted state*, not a substitute for a missing range.
2. A **named requirement** (`SEAT-FR-265`) explicitly authorises the escape clause, and states it is exercised **exactly once**.
3. The gap's impact is **`None`** — the unset state is a *complete, deterministic behaviour*, not a deferral.

---

## 2 · Predicate test — does `PRD-006` satisfy the precedent's preconditions?

| # | Precondition established by the precedent | `SEAT-CFG-017` | `ATT-CFG-005`/`006`/`019` | Verdict |
|---|---|---|---|---|
| 1 | Setting is numeric | ✅ | ✅ | ✅ MET |
| 2 | Tied to an open gap | ✅ `SEAT-GAP-005` | ✅ `ATT-GAP-017` | ✅ MET |
| 3 | Capability inoperative in V1 | ✅ no event emitted | ✅ all three flags **Disabled**; `ATT-FR-064`/`080` block the build | ✅ MET |
| 4 | Substitution explicitly forbidden | ✅ `SEAT-FR-241` | ✅ **`ATT-BR-043`** (stronger) | ✅ MET |
| 5 | Deterministic behaviour while unset | ✅ | ✅ **`ATT-FR-149`/`150`/`151`** (stronger) | ✅ MET |
| 6 | Module operable having configured nothing | ✅ | ✅ **`ATT-BR-044`** proves it per-capability | ✅ MET |
| 7 | **Value domain resolved independently of the default** | ✅ **`Integer 1–100`, or unset** | ❌ **`Bounded 0–1 — unresolved`** · **`Bounded duration — unresolved`** | ❌ **NOT MET** |
| 8 | A named FR authorises the unset escape clause | ✅ `SEAT-FR-265` | ❌ **0 occurrences** of `or unset` / `unset behaviour` in `PRD-006` | ❌ **NOT MET** |

**Measured evidence for rows 7 and 8:**

```
awk -F'|' '/^\| `SEAT-CFG-017`/ {print $6}'  →  " Integer 1–100, or unset "
awk -F'|' '/^\| `ATT-CFG-(005|006|014|019)`/ {print $6}'
    →  " Bounded duration — **unresolved** "   (005, 006)
    →  " Bounded 0–1 — **unresolved** "        (014, 019)

grep -c -iE 'or unset|admits `unset`|unset behaviour' PRD-006  →  0
awk -F'|' '/^\| `ATT-CFG-/ {print $6}' PRD-006 | grep -ic unset →  0
```

**Rows 1–6 pass. Rows 7 and 8 fail.** `PRD-006` is in fact *stronger* than the precedent on rows 4, 5 and 6 — it already has `ATT-BR-043`, `ATT-FR-149`, `ATT-FR-150`, `ATT-FR-151` and `ATT-BR-044`, where `PRD-007` has `SEAT-FR-265` alone. The two failures are not about behaviour. They are about **the domain column** and **the absence of an authorising rule**.

---

## 3 · Why row 7 is decisive, in the repository's own words

`ADR-0021` already adjudicated this exact distinction, at L105–109:

> *"**An envelope is a declared range, and for all seven the envelope is itself marked unresolved.** `Bounded 0–1` is a **type**, not a range: it excludes `1.7` but admits `0.01` and `0.99` equally, and a face-match threshold of `0.01` authorises impersonation."*
>
> *"Contrast `ICFG-2`: **'7 d, range 1 h – 30 d.'** The PRD supplied the envelope; the Guide set the value inside it."*

`SEAT-CFG-017` is the `ICFG-2` shape: envelope supplied (`1–100`), value deferred. The four `ATT-CFG-*` rows are the shape `ADR-0021` ruled *cannot* be discharged downstream: **envelope itself unresolved**.

So the precedent does **not** show that `LIB-16.2` tolerates an unresolved *domain*. It shows `LIB-16.2` tolerates an unresolved **value** when the domain is known. That is a materially narrower proposition than the one recorded in the prior analysis document, and this evaluation corrects it (§7).

Further, `PRD-006` §16.3's own preamble (L1150–1151) makes the domain column a stated obligation:

> *"Every entry carries owner, **default, allowed domain**, validation, failure behaviour, effective behaviour and audit — **as required by §0.3 and `LIB-16.2`/`LIB-16.3`**."*

Writing `Unset in V1` into the Default column while leaving `Allowed domain` at `— unresolved` would leave that preamble false. That is the `GCP-01`/`07`/`08` defect class: *a derived statement left behind by a change to the thing it describes.*

---

## 4 · Arithmetic ceiling — what Option E can and cannot reach

`ATT-GAP-017` (L2178) asks for *"the **default values and allowed ranges**"* for seven configurables → **14 required answers**.

| State | Defaults | Ranges | Total |
|---|---|---|---|
| Supplied by Product Owner (`011`, `012`, `023`) | 3 | 3 | **6 of 14** |
| Option E could add (`005`, `006`, `019`) — default half **only** | +3 | +0 | **9 of 14** |
| `ATT-CFG-014` — ARB-blocked either way | 0 | 0 | — |
| **Still missing at the ceiling** | **1** (`014`) | **4** (`005`, `006`, `019`, `014`) | **5 answers** |

**Conclusion: even fully exercised, Option E leaves `ATT-GAP-017` OPEN with 5 of 14 answers absent.** The `LIB-16.2` breach is *reduced* — from 4 undocumented defaults to 1 — but **not cleared**, because the three ranges remain unresolved and the domain column stays `— unresolved` unless a bounded duration and a bounded 0–1 envelope are also supplied.

This is the same conclusion the Product Owner already reached for Face V3, in `PRD-006_ATT-GAP-015_DECISION_RECORD.md`:

> *"We confirm this does **not** clear the breach and does **not** make `PRD-006` freezable."*

---

## 5 · Why §16.3 is not amended, and v1.4 is not cut

The instruction authorises the amendment only when *"all seven configurables' default + allowed range/domain **legitimately complete**."* Measured state: **6 of 14 answers**, ceiling **9 of 14**. The precondition is unmet by 5 answers, so the single coherent amendment cannot be written truthfully.

Amending partially would additionally require touching the ten dependent "seven" statements (L1185, 1187, 1190, 1214, 1229, 2059, 2071, 2178, 2212, 2316) to say something that is not yet true, and would move the subject hash — re-triggering a full Stage 4 re-review only to arrive at the same unresolved verdict.

**`PRD-006` remains v1.3 DRAFT, sha256 `93ab1c60d740c4e0`, byte-unmodified.**

---

## 6 · The two Product Owner authorisations required — recorded, not assumed

Option E is not self-applying. `ATT-GAP-017`'s register row names the **Product owner** as its authority, and §0.4 states a gap *"may not be satisfied by an implementer choosing an answer."* Two separate decisions are required, and neither has been given:

| # | Decision required | Why it is the PO's, not a reviewer's | Status |
|---|---|---|---|
| **E-1** | Authorise re-reading `ATT-GAP-017`'s question so that **"Unset in V1"** counts as a valid *documented default* for `ATT-CFG-005`, `006`, `019` | Reinterprets the gap's own wording (*"default values and allowed ranges"*). Only the named owner may narrow the question they asked. | ⛔ **NOT GIVEN** |
| **E-2** | Supply the **allowed domain** for those three — a bounded duration for `005`/`006`, a bounded 0–1 for `019` | `ADR-0021` L105: the envelope is *"a declared range"*; `Bounded 0–1` is a type, not a range. A domain is a security statement (`0.01` vs `0.95`). | ⛔ **NOT GIVEN** — and for `005`/`006` the competent owner (Security Platform) has no authored specification |

A third instrument is also required if E-1 is granted: **an `ATT-FR-*` rule analogous to `SEAT-FR-265`** authorising the unset escape clause and stating which rows exercise it. `PRD-006` has 0 such rule today (§2 row 8). Adding a new numbered requirement changes the `ATT-FR-*` register count from 151 and is itself a specification act, not a clerical one.

**Nothing in this document ticks a box, signs a line, or assumes an approval.**

---

## 7 · Correction to the prior analysis

`PRD-006_ATT-GAP-017_UNSET_DEFAULT_ROUTE_ANALYSIS.md` §5 recorded that under Option E *"three of four settings need no Security Platform document and no OCR ownership assignment."*

**That statement was too strong and is corrected here.** It holds only for the **default** half of those three rows. The **range/domain** half still requires exactly the authority that is missing:

- `ATT-CFG-005`/`006` — a bounded duration envelope is a Dynamic-QR security parameter. Owner: **Security Platform**, which per `PRD_REGISTRY.md` L248 *"is therefore a placeholder that will never be authored."*
- `ATT-CFG-019` — a bounded 0–1 envelope is an OCR accuracy parameter, whose owning context `ADR-0023` has not assigned.

So Option E **reduces** the blocker but does **not** eliminate the external dependency. The prior document's §4 finding (that `LIB-16.2` accepts a documented rather than numeric default) stands and is confirmed. Its §5 extrapolation about eliminating dependencies does not.

---

## 8 · Gate results after creating this document

| Gate | Result |
|---|---|
| Stage 5 — `prd006_traceability.py` | recorded in the commit; not weakened |
| Stage 6 — `prd006_task_coverage.py` | recorded in the commit; not weakened |
| Stage 4 | subject `PRD-006` unmodified → not re-triggered; recorded **CONDITIONAL** verdict **not** upgraded |
| Stage 7 | **UNSATISFIED** — 0 baseline rows for `attendance-management`; `PRD_REGISTRY.md` L236 = `PLANNED` |

---

## 9 · What this document did not do

| # | Not done | Why |
|---|---|---|
| 1 | Did not invent a numeric value for `005`, `006`, `014`, `019` | `ATT-BR-043`; §0.4 |
| 2 | Did not invent a bounded duration or bounded 0–1 envelope | `ADR-0021` L105 — a range is itself a security statement |
| 3 | Did not apply the unset pattern | Requires PO decisions E-1 **and** E-2 (§6) |
| 4 | Did not add an `SEAT-FR-265` analogue to `PRD-006` | Would change the `ATT-FR-*` register count; a specification act |
| 5 | Did not amend §16.3 or cut v1.4 | Precondition unmet — 6 of 14, ceiling 9 of 14 (§4, §5) |
| 6 | Did not mark `ATT-CFG-014` resolved | ARB ratification absent; instruction CF-3 forbids it |
| 7 | Did not accept `ADR-0021`/`0022`/`0023` | All **Proposed**; no authority present |
| 8 | Did not create the admitting ADR | Its substantive prerequisites are unsatisfied (instruction CF-4) |
| 9 | Did not add a baseline row or change registry status | Stage 7 gate is conferred, not claimed |
| 10 | Did not modify any protected document or any code | All 10 hashes verified byte-identical |

---

## 10 · Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-04 | Formal predicate evaluation of the `SEAT-CFG-017` unset pattern against `ATT-CFG-005`/`006`/`019`. 6 of 8 preconditions met; rows 7 (unresolved domain) and 8 (no authorising FR) fail. Ceiling computed at 9 of 14 answers. Two required PO authorisations recorded. Corrects the prior analysis §5 extrapolation. |
