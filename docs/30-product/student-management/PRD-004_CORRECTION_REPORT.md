# `PRD-004` Correction & Re-Validation Report

| Field | Value |
|---|---|
| **Document** | Correction record for [`Student_Management_PRD_v1.md`](Student_Management_PRD_v1.md) (`PRD-004`) |
| **Version** | v1.0 |
| **Date** | 2026-08-04 |
| **Baseline** | `BASELINE-2026-08-04-B` · repository inspected live at `1922f8d` |
| **Input** | [`PRD-004_INDEPENDENT_REVIEW_REPORT.md`](PRD-004_INDEPENDENT_REVIEW_REPORT.md) — verdict **C. REQUIRES MAJOR CORRECTIONS**, 21 findings |
| **Scope** | **Controlled correction.** The PRD was not recreated, the architecture was not redesigned, no new PRD or `BC-` identifier was created, and no application code was touched |
| **Status** | Supporting record. **Not ranked**, therefore editable without an ADR |
| **Precedence** | Below every document it cites. Where this file disagrees with `PRD-004`, **`PRD-004` is right and this file is a defect** |
| **Governing principle** | `SID-4.56` — *"A rule that cannot be checked SHALL be treated as unmet, not as satisfied by intent."* |
| **FINAL DECISION** | **B. NEEDS ANOTHER REVIEW** — see §10 |

---

## 1. Findings reproduced

Every finding was re-derived from the live repository before any edit. The review report was **not** trusted as
evidence; it was treated as a hypothesis to test.

### 1.1 The three HIGH findings

**`RF-01` — Directory reads across edges that do not exist. REPRODUCED, and the resolution is stronger than the
review supposed.**

`BC-01`'s complete edge set was enumerated from BC Map §7:

| Edge | Direction | Kind |
|---|---|---|
| `E-01` | `BC-01` → `BC-02` | **Event** |
| `E-09` | `BC-01` → `BC-05` | **Event** (dues assertion) |
| `E-11` | `BC-18` → `BC-01` | Sync port |
| `E-13` | `BC-01` → `BC-10` | ACL |
| `E-21` | `BC-01`, `BC-10` → `BC-23` | Event |
| `E-22` | `BC-01`, `BC-10`, `BC-14` → `BC-29` | Sync port |

`BC-03` and `BC-04`: **no edge of any kind.** `E-01` and `E-09` exist but are *event* edges, so they do not
authorise a synchronous read either. BC Map line 292 is unambiguous: *"If an edge is not in this table, it **does
not exist** and adding it requires an ADR."* The finding is real.

The review recommended invoking `AR-1` as a *precedent*. Reading `AR-1` verbatim (`ARCHITECTURE_RULINGS.md`
lines 23–58) showed something better than a precedent — **the identical fact pattern, already ruled on.** `AR-1`
composes a read model from seven contexts, and its own table includes **`Membership Plans & Pricing | BC-02`** and
**`Seat Capacity | BC-04`** — the very contexts `RF-01` flags — while the ruling states the capability *"owns no
aggregate · owns no invariant · owns no business state · only orchestrates public read models"*, that the context
count *"remains 31 (23 in V1)"*, and that *"no `BC-` identifier is assigned."*

**Consequence:** the preferred resolution is consistent with `AR-1`'s actual wording, so no conflict had to be
escalated, **no ADR is required, and the BC Map is untouched.**

**`RF-02` — the ten-th event. REPRODUCED.**

- BC Map §8 line 408: `| BC-01 | `enrollment.StudentLinkedToPerson` | BC-10 (via ACL) | The consented social bridge |`
- BC Map line 466: *"Enroll → activate social profile … Consent gate → `StudentLinkedToPerson` → ACL"*
- `PRD_DEPENDENCY_GRAPH.md` line 154 lists it for `BC-01`/`PRD-004`
- Occurrences in `PRD-004` §7.4 before correction: **zero**

Rank 4 assigns this event to `BC-01`; the PRD declared a *closed* set that omitted it. A closed set missing a
mandated member is a defect in the set, not in the mandate.

**`RF-06` — guardian rule unevaluable. REPRODUCED, including the underlying tension.**

`SM-4.4`/`SM-INV-3` required a guardian when the student is under 18. Age derives from Date of Birth, which
`BC-10` owns. `PRD-003` §2.4 lists Date of Birth under **Optional** (mandatory fields are *"Full Name (the only
mandatory human-supplied field)"* plus Username), reinforced by `SID-2.5`. Yet `SID-5.9` (line 1120) says DOB
*"**SHALL** be stored, because minor-safety obligations (`ID-6`) depend on it."* That tension is **internal to
`PRD-003`** — a frozen Rank 3 document — and the third case (DOB absent) had no specified behaviour at all.

### 1.2 MEDIUM / LOW / OBSERVATION findings — inspection results

| Finding | Reproduction method | Result |
|---|---|---|
| `RF-03` | BC Map §8 binding convention `<Context>.<Aggregate><PastTenseVerb>` vs §7.4 names | **Confirmed** — 9 of 9 unprefixed |
| `RF-04` | Diff supporting doc §4 against PRD §7.4 | **Confirmed** — 9 vs 10 events, `StudentLinkedToPerson` mis-numbered `SM-EV-4`, 5 events collapsed into one summary row |
| `RF-05` | `PRD_LIFECYCLE.md` Stage 2 rule 4; grep §0 for MUST/SHOULD/MAY definition | **Confirmed** — 0 definition sections, MUST used 125× |
| `RF-07` | Attempt to reproduce 233/242 from §10.5 | **Confirmed** — §10.5 is a **10-row group table**; a per-identifier percentage cannot be derived from it |
| `RF-08` | grep for any requirement ID inside the AC table | **Confirmed** — 2-column table, 0 requirement links |
| `RF-09` | Set-difference of requirement IDs vs task-referenced IDs | **Confirmed** — 40 unreferenced, incl. `LMD-25`–`LMD-29` |
| `RF-10` | Read `MP-GBR-16` | **Confirmed** — it governs `MembershipStatus`, not `Suspended` enrollment |
| `RF-11` | Read `LMD-11` against `LMD-15` | **Confirmed** — cursor stability over eventually-consistent foreign projections |
| `RF-12` | `sed -n '818p;826p'` §8.2 | **Confirmed** — two literal `**GAP**` cells inside a declared *"closed list"* |
| `RF-13` | `SM-10.2` partial index vs `SM-INV-6` | **Confirmed** — archived duplicates unbounded, restore target ambiguous |
| `RF-14` | Compare with three sibling modules | **Confirmed** — no module `README.md` |
| `RF-15` | grep `SM-XC-*` for `BC-20` | Confirmed as fact, **rejected as defect** — see §3 |
| `RF-16` | Read roadmap line 60 | **Already corrected** in J-2 (`1922f8d`), before this pass |
| `RF-17` | Read `PRD-003` §2.4 and `SID-5.9` | **Confirmed**, but belongs to the `BC-10` owner — see §7 |
| `RF-18` | grep `LMD-11`/`LMD-17` | Confirmed as fact, **rejected as defect** — see §3 |
| `RF-19` | grep PRD for `outbox` | **Confirmed** — 0 occurrences; idempotency required of consumers only |
| `RF-20` | Read `SM-EV-3`, `SM-EV-6` vs §7.1 and BC Map line 306 | **Confirmed** — ordering ambiguity |
| `RF-21` | Read §10.4 header | **Confirmed** — *"abridged to the falsifiable set"* left a normative register with an undefined boundary |

---

## 2. Findings accepted

**15 accepted and corrected inside `PRD-004`** (or, for `RF-04`, inside the unranked supporting document it
concerns):

`RF-01` · `RF-02` · `RF-03` · `RF-04` · `RF-05` · `RF-06` · `RF-07` · `RF-08` · `RF-09` · `RF-10` · `RF-11` ·
`RF-12` · `RF-13` · `RF-19` · `RF-21`

**1 accepted, corrected before this pass:** `RF-14` (module `README.md`, created in J-2) — and `RF-16` (roadmap
line 60, corrected in J-2; its counts were refreshed again here because the correction changed them).

**1 accepted but deliberately not resolved here:** `RF-17` — recorded as `SM-GAP-10`. See §7 and §9.

**Correction plan, as produced in Phase 1 before any edit:**

| Finding | Valid? | Correctable inside `PRD-004`? | ADR required? | Action |
|---|---|---|---|---|
| `RF-01` | ✅ yes | ✅ yes | ❌ **no** — `AR-1` already rules this exact pattern | Scope `SM-7.1` to the domain layer; add `SM-7.1a`, `LMD-24a`, `LMD-24b`; rebuild §5.4 edge column |
| `RF-02` | ✅ yes | ✅ yes | ❌ no — Rank 4 already assigns the event | Add `SM-EV-10`; add `SM-7.12a`, `SM-7.12b` |
| `RF-03` | ✅ yes | ✅ yes | ❌ no | Prefix all 10 events `enrollment.` |
| `RF-04` | ✅ yes | ✅ yes (unranked supporting doc) | ❌ no | Rewrite its §4 from PRD §7.4; withdraw its coverage claim |
| `RF-05` | ✅ yes | ✅ yes | ❌ no | Add §0.1 normative language |
| `RF-06` | ✅ yes | ✅ yes | ❌ no — deny-by-default is already authorised by `AP-3` | Add §4.2.1 three-case table; `SM-4.5a`/`5b`/`5c`; log `SM-GAP-10` |
| `RF-07` | ✅ yes | ✅ yes | ❌ no | Withdraw 96.3%; compute per identifier; publish §10.5.1 |
| `RF-08` | ✅ yes | ✅ yes | ❌ no | Add `Verifies` column; add `SM-AC-29`/`30`, `SM-10.11`/`10.12` |
| `RF-09` | ✅ yes | ✅ yes | ❌ no | Add `IMPL-318`–`323`; extend `IMPL-312` |
| `RF-10` | ✅ yes | ✅ yes | ❌ no | Restate `SM-2.14` as event emission; mark `MP-GBR-16` analogous |
| `RF-11` | ✅ yes | ✅ yes | ❌ no | Add `LMD-15a`/`15b` filter classes |
| `RF-12` | ✅ yes | ✅ yes | ❌ no | Add `SM-8.4a` interim deny; keep `SM-GAP-4` open |
| `RF-13` | ✅ yes | ✅ yes | ❌ no | Add `SM-3.14a`/`14b`; correct `SM-INV-6` |
| `RF-15` | fact ✅ / defect ❌ | n/a | ❌ no | **Reject** — §3 |
| `RF-17` | ✅ yes | ❌ **no** — `PRD-003` is frozen Rank 3 | ✅ **yes, by the `BC-10` owner** | Record `SM-GAP-10`; forbid resolution here via `SM-4.5c` |
| `RF-18` | fact ✅ / defect ❌ | partially | ❌ no | **Reject**; §0.1 mitigates — §3 |
| `RF-19` | ✅ yes | ✅ yes | ❌ no | Add `SM-7.7a`/`7b` transactional outbox |
| `RF-20` | ✅ yes | ✅ yes | ❌ no | Clarify `SM-EV-3`, `SM-EV-6`, `SM-EV-9` |
| `RF-21` | ✅ yes | ✅ yes | ❌ no | Remove *"abridged"*; declare `SM-AC-1`…`SM-AC-30` |
| `RF-14` | ✅ yes | n/a | ❌ no | Done in J-2 |
| `RF-16` | ✅ yes | n/a (unranked) | ❌ no | Done in J-2; counts refreshed here |

**Not every reviewer recommendation was applied.** Three were rejected (§3), and one — `RF-17` — was deliberately
*not* implemented as recommended because implementing it would have required editing a frozen document.

---

## 3. Findings rejected, with evidence

**`RF-15` — `BC-20` Subscription & Billing is not explicitly excluded. REJECTED as a defect.**

The observation is factually correct: `SM-XC-1`…`SM-XC-14` name 13 excluded areas and `BC-20` is not among them.
It is rejected because the exclusion register is not the mechanism that prevents `BC-20` scope creep. `SM-1.1`
scopes this module to `BC-01`, §5.4 delegates every foreign value to its owning context, and `LMD-24b` forbids
authority over any of them. A 15th exclusion would restate an existing constraint. Adding a requirement whose only
effect is rhetorical would breach the instruction *"Do not increase the requirement count artificially."* **No
functional risk is created by the omission**, and no implementer could read the PRD as licensing billing work.

**`RF-18` — design preferences stated as `MUST`. REJECTED as a defect; mitigated instead.**

`LMD-11` (cursor-based pagination) and `LMD-17` (documented tie-breaker) are genuinely design choices rather than
derivations from a ranked source. They are nonetheless correctly `MUST`: `LMD-11` is what makes `LMD-15b`'s
stability guarantee checkable, and `LMD-17` is what makes ordering deterministic and therefore testable. A
`SHOULD` here would make both unenforceable, which `SID-4.56` treats as unmet. The legitimate part of the
finding — that the document never said what its modal verbs *mean* — is `RF-05`, and **§0.1 now fixes exactly
that**, including that these obligations bind implementation and may be revisited only by document change.

**`RF-16` — stale roadmap. NOT REJECTED, but out of scope for this pass:** already corrected in `1922f8d` during
Request J-2, i.e. before this correction phase began. Its counts were refreshed here as a consequence of the
corrections (18→24 tasks, 28→30 criteria).

---

## 4. Corrections made

| # | Finding | Correction | Files |
|---|---|---|---|
| 1 | `RF-05` | New **§0.1 Normative language** — MUST/SHOULD/MAY defined; prose and rationale blocks carry no obligation; precedence clause. Old §0 renumbered §0.2 | PRD |
| 2 | `RF-01` | `SM-7.1` rescoped to the **domain layer**; `SM-7.1a` quotes `AR-1` verbatim; §5.4 edge column for `BC-02`/`03`/`04`/`05` → *"none — none required"* with mechanism *"`AR-1` composition"*; false *"`E-02` pattern"* citation removed; `LMD-24a` (no domain-layer read, no persist/cache, no invariant evaluation), `LMD-24b` (no authority; writes delegate per `F-3`) | PRD |
| 3 | `RF-02`, `RF-03`, `RF-20` | §7.4 → `SM-EV-1`…`SM-EV-10`; all ten names prefixed `enrollment.`; `SM-EV-10 enrollment.StudentLinkedToPerson` added with `BC-10` consumer via `E-13`; `SM-7.12a` consent gate, `SM-7.12b` payload limit; `SM-EV-3`/`6`/`9` ordering clarified; `SM-7.12` ceiling nine → **ten** | PRD |
| 4 | `RF-06` | `SM-4.4` → *"when the person's age is **known** to be under 18"*; new **§4.2.1** three-case table; `SM-4.5a` minor-status `Unknown` + audited staff declaration; `SM-4.5b` **fail-safe to minor** under `AP-3`; `SM-4.5c` forbids pushing DOB mandatory at `BC-10`; `SM-INV-3` updated | PRD |
| 5 | `RF-13` | `SM-3.14a` restore targets most recently archived by `archivedAt` desc, tie-break by greater ordinal; `SM-3.14b` report count; `SM-INV-6` exempts `Archived` per `ID-5`; `SM-10.2` declared *deliberately partial* | PRD |
| 6 | `RF-10` | `SM-2.14` restated as `SM-EV-2` emission with `BC-02`/`03`/`04` reacting; *"This module **MUST NOT** enforce any of those three behaviours itself"*; `MP-GBR-16` marked **analogous, not authoritative** | PRD |
| 7 | `RF-11` | `LMD-15a` two filter classes (authoritative vs best-effort); `LMD-15b` cursor stability for authoritative only, drift *"**MUST** be disclosed in the API contract rather than concealed"* | PRD |
| 8 | `RF-19` | `SM-7.7a` transactional **outbox** in the same transaction; `SM-7.7b` tenant-partitioned, per-aggregate ordering | PRD |
| 9 | `RF-21`, `RF-08` | *"abridged"* removed; register declared `SM-AC-1`…`SM-AC-30`; **`Verifies` column added to all 30 rows**; `SM-AC-29` (absent-DOB path), `SM-AC-30` (restore among archived); `SM-10.11`, `SM-10.12` | PRD |
| 10 | `RF-07` | **§10.5.1 Coverage — computed, not asserted**: 96.3% withdrawn, DIRECT/DERIVED model documented, all 17 untraced identifiers named, script linked | PRD + new script |
| 11 | `RF-09` | §10.7 → `IMPL-300`…`IMPL-323`; six new tasks `IMPL-318`–`323`; `IMPL-312` extended | PRD |
| 12 | `RF-12` | §8.2's two `**GAP**` cells → **`❌` interim deny**, governed by new `SM-8.4a`; `SM-GAP-4` explicitly **stays open** | PRD |
| 13 | `RF-17` | `SM-GAP-10` recorded; `SM-4.5c` forbids resolving it here | PRD |
| 14 | `RF-04` | Supporting doc §4 rebuilt from PRD §7.4 (ten prefixed events, `SM-EV-10` correct, all enumerated); coverage claim **withdrawn**; stale counts refreshed; bumped to v1.1 | `PRD-004_TRACEABILITY.md` |
| 15 | consequential | Index rows and roadmap counts refreshed to match | `docs/README.md`, `PRODUCT_IMPLEMENTATION_ROADMAP.md` |

**Method note — why sub-lettered identifiers.** Corrections that *narrow or complete* an existing requirement took
that requirement's number with a letter suffix (`SM-7.1a` qualifies `SM-7.1`). This keeps every pre-existing
identifier stable — §10.7 tasks, §10.4 criteria and three supporting documents cite them — while honouring *"Do
not increase the requirement count artificially."* All **15** suffixes are declared in a table in §0.2, so the
count remains honest rather than hidden: **248 base + 15 sub-lettered = 263**.

**One collision was caught before it shipped.** The new coverage requirement was initially numbered `SM-10.10`;
re-verification found `SM-10.10` already exists (*"Every configurable **MUST** have a documented default"*).
`SM-10.11`/`SM-10.12` were used instead — the exact defect validation point 3 exists to catch.

---

## 5. Requirements added, removed, modified

**Added — 4 base identifiers, 1 gap, 6 tasks, 15 clarifications. Removed — none.**

| Requirement | Previous | New | Reason | Source |
|---|---|---|---|---|
| `SM-7.1` | Prohibited the module from depending on other contexts, without naming a layer | Binds the **domain layer** explicitly | Unqualified, it contradicted `AR-1` | `AR-1`, `L3` |
| `SM-7.1a` | — *(new)* | Application-layer read composition is permitted; quotes `AR-1` | `RF-01` — resolves the apparent edge violation | `AR-1` lines 23–58 |
| `LMD-24a` | — *(new)* | Composition may not enter the domain layer, persist, cache or evaluate invariants | Bounds the permission `SM-7.1a` grants | `AR-1`, `L3` |
| `LMD-24b` | — *(new)* | No authority over `MembershipStatus`/seat/attendance/fee; writes delegate | Prevents `BC-01` becoming authoritative | `AR-1`, `F-3` |
| §5.4 edge column | `BC-02`/`03`/`04`/`05` cited an *"`E-02` pattern"* | *"none — none required"* + *"`AR-1` composition"* | `E-02` is `BC-02`→`BC-04`, an edge between two **other** contexts | BC Map §7, line 292 |
| `SM-EV-10` | — *(new)* | `enrollment.StudentLinkedToPerson`, consumer `BC-10` via `E-13` ACL | Rank 4 already assigns this event to `BC-01`; the closed set omitted it | BC Map line 408, line 466; `PRD_DEPENDENCY_GRAPH.md` line 154 |
| `SM-7.12` | *"closed at nine events"* | *"closed at **ten** events"* | Consequence of `SM-EV-10` | as above |
| `SM-7.12a` | — *(new)* | `SM-EV-10` emitted only after `BC-18` records consent; enrollment still succeeds without it | `ID-6` consent gate | `ID-6`, BC Map line 466 |
| `SM-7.12b` | — *(new)* | `SM-EV-10` **MUST NOT** carry `StudentRecordId` | `BC-10` is global; the id is tenant-scoped | `ID-4`, `SM-XC-9` |
| `SM-EV-1`…`SM-EV-9` | Unprefixed names | All prefixed `enrollment.` | BC Map §8 convention is **binding** | BC Map §8 |
| `SM-4.4` | Guardian required when *"under 18"* | Required when age is **known** to be under 18 | Age was unevaluable when DOB is absent | `SID-4.56` |
| `SM-4.5a` | — *(new)* | Absent DOB ⇒ minor-status `Unknown`; audited staff declaration required before leaving `Pending` | Case 3 had no specified behaviour | `AP-3`, `SID-4.56` |
| `SM-4.5b` | — *(new)* | **Fail safe to minor**; `ID-6`-gated capability stays closed | Deny-by-default; no legal rule invented | `AP-3`, `ID-6` |
| `SM-4.5c` | — *(new)* | This module **MUST NOT** push DOB mandatory at `BC-10` | `PRD-003` is frozen Rank 3 | `SM-XC-2`, `SID-2.42` |
| `SM-INV-3` | *"Guardian mandatory if age < 18"* | *"…**or if minor-status is `Unknown`**"* | Makes the invariant evaluable | BC Map line 370, `AP-3`, `SID-4.56` |
| `SM-INV-6` | One `StudentRecord` per `(tenantId, personId)` | One **non-`Archived`** record; archived exempt | Absolute uniqueness would make archival destructive, contradicting `ID-5` | `ID-5` |
| `SM-3.14a` | — *(new)* | Restore targets the most recently archived record | `SM-INV-6` permitted several; target was ambiguous | `ID-5` |
| `SM-3.14b` | — *(new)* | Restore reports the count of archived records | Makes ambiguity visible to the operator | `ID-5` |
| `SM-10.2` | Partial unique index, unexplained | Declared *deliberately* partial, with reason | The partiality is a design decision, not an oversight | `ID-5` |
| `SM-2.14` | Legislated `BC-03`/`BC-04` behaviour, cited `MP-GBR-16` | Emits `SM-EV-2`; consumers react; *"**MUST NOT** enforce any of those three behaviours itself"* | `MP-GBR-16` governs `MembershipStatus`, so it is **analogous**, not authoritative | `E-01`, `F-3` |
| `LMD-15a` | — *(new)* | Filters split into **authoritative** and **best-effort** classes | `LMD-11` and `LMD-15` were not jointly satisfiable | `AR-1` |
| `LMD-15b` | — *(new)* | Cursor stability guaranteed for authoritative filters only; drift disclosed | Honest guarantee replaces an unachievable one | `AR-1`, `SID-4.56` |
| `SM-7.7a` | — *(new)* | Transactional **outbox** in the same transaction as the state change | Producer-side exactly-once was unspecified | BC Map `E-20` *"outbox-backed"* |
| `SM-7.7b` | — *(new)* | Tenant-partitioned, per-aggregate ordering | Ordering guarantee was unstated | `E-20`, `X-13` |
| `SM-8.4a` | — *(new)* | `TR-5` denied `SM-PO-2`/`SM-PO-10` as an **interim** value; `SM-GAP-4` stays open | A *"closed list"* cannot contain an undefined cell | `AP-3`, `SID-4.56` |
| §8.2 `TR-5` cells | `**GAP** SM-GAP-4` | `❌ (interim — SM-8.4a)` | as above | `AP-3` |
| `SM-AC-1`…`SM-AC-28` | 2-column table, no requirement link | Third **`Verifies`** column on every row | *"A criterion that verifies nothing is not an acceptance criterion"* | `SID-4.56` |
| `SM-AC-29` | — *(new)* | Verifies the absent-DOB path | New behaviour needs verification | `SM-4.5a`/`5b` |
| `SM-AC-30` | — *(new)* | Verifies restore among several archived records | New behaviour needs verification | `SM-3.14a` |
| `SM-10.11` | — *(new)* | Every requirement verifiable by AC, task, or declared gap | Closes the `RF-09` class of defect structurally | `SID-4.56` |
| `SM-10.12` | — *(new)* | Outbox must contain `SM-EV-10` iff consent recorded | Makes `SM-7.12a` checkable | `SM-7.12a` |
| §10.4 header | *"abridged to the falsifiable set"* | `SM-AC-1` … `SM-AC-30` | An abridged normative register has no boundary | `PRD_LIFECYCLE.md` Stage 2 |
| §10.5 coverage | *"233 of 242 (96.3%)"* | **Withdrawn**; §10.5.1 computes 221/238 = **92.9%** | The claim was inferred from a 10-row group table, so it was never measured | `SID-4.56` |
| §10.7 tasks | `IMPL-300`…`IMPL-317` | `IMPL-300`…`IMPL-323` | 40 requirements were named by no task | `RF-09` |
| `IMPL-312` | Directory task | Extended with `LMD-24a`/`24b`, `LMD-15a`/`15b` | New requirements need an owner | — |
| `SM-GAP-10` | — *(new gap)* | Whether DOB becomes mandatory at `BC-10` | `PRD-003` §2.4 vs `SID-5.9`; not this module's to resolve | `RF-17` |
| §0.1 | absent | Normative language defined | Stage 2 gate rule 4 | `PRD_LIFECYCLE.md` |
| §0.2 counts | 105/9/28/9, total 242 | **107/10/30/10, 248 base + 15 = 263** | Mechanically recounted | script |

---

## 6. Traceability recalculation

The previous figure — **233 of 242 = 96.3%** — is **withdrawn**. It was not measured: §10.5 is a ten-row
*group* table, from which no per-identifier percentage can be derived. Per `SID-4.56`, an unverifiable claim is
treated as unmet.

It has **not** been replaced with another invented percentage. Coverage is now computed from actual requirement
identifiers by [`tool/docs_check/prd004_traceability.py`](../../../tool/docs_check/prd004_traceability.py), which
exits non-zero while any requirement is untraced.

**Model — two tiers, because a one-tier model gave a knowingly wrong answer.** A first strict implementation
counted only identifiers whose own defining line cites an external authority, returning **50.2%** and marking all
28 acceptance criteria untraced. That is wrong in principle: an acceptance criterion's job is to verify a
*requirement*, not to cite a ranked document. The model was rebuilt:

- **DIRECT** — the defining line, *or its section preamble*, cites an external authority (`MP-*`, `SID-*`,
  `LIB-*`, `AUTH-*`, `AR-n`, `ADR-nnnn`, `E-nn`, `ID-n`, `X-nn`, `F-n`, `L1`–`L5`, BC Map, `AP-n`, `LCFG-n`,
  `TR-1`–`TR-5`, `14A`/`14B`).
- **DERIVED** — cites another `PRD-004` identifier that is itself traced, computed as a fixpoint. Internal chains
  that never reach an external authority do **not** count.
- Section-preamble inheritance is permitted because §8.2 deliberately establishes `LIB-4.1`/`AUTH-7.21`/`TR-1`–`TR-5`
  once for all 12 `SM-PO-*` rows rather than repeating it per row.
- `SM-GAP-*` are excluded from the denominator: carrying no source **by definition** is what makes them gaps.

**Result:**

| Measure | Count |
|---|---|
| Identifiers located in the PRD | **248** |
| Proposed gaps (`SM-GAP-*`, excluded) | 10 |
| **Denominator — real requirements** | **238** |
| Traced **DIRECT** | 211 |
| Traced **DERIVED** | 10 |
| **UNTRACED** | **17** |
| **Coverage** | **221 / 238 = 92.9%** |

**The 17 untraced identifiers, named rather than hidden:** `SM-2.8`, `SM-3.12`, `SM-3.13`, `SM-3.14`, `SM-3.16`,
`SM-3.17`, `SM-4.1`, `SM-6.1`, `SM-6.3`, `SM-6.5`, `SM-6.6`, `SM-6.8`, `SM-8.11`, `SM-8.15`, `SM-10.1`, `SM-10.7`,
`SM-10.8`.

These are **not** proposed gaps. Each is an internal design decision that no ranked document mandates and none
contradicts — for example `SM-10.7` (idempotency keys on mutating endpoints) is sound engineering that no cited
authority requires. They are disclosed so a reviewer can challenge any of them, and `SM-10.11` now requires that
every requirement be verifiable by a criterion, a task, or a declared gap.

**On the direction of the change.** The withdrawn figure was 96.3%; the computed figure is **92.9%**, which is
**lower**. The correction pass did not tune the metric upward. Both figures were recomputed after the `RF-12` and
`RF-04` corrections and were unchanged, confirming those corrections added no requirement.

---

## 7. Governance impact

**No frozen or ranked document was modified. No ADR was required. Governance was not bypassed.**

| Ranked document | Rank | Touched? | Verified |
|---|---|---|---|
| `MASTER_PRD.md` | 1 | ❌ no | `git diff 1922f8d HEAD` — unchanged |
| `ADR-0001`…`ADR-0017` | 2 | ❌ no | unchanged |
| `Student_Identity_PRD_v1.md` (`PRD-003`) | 3 | ❌ no | unchanged |
| `Authentication_PRD_v2.md` | 3 | ❌ no | unchanged |
| `Library_PRD_v1.md` | 3 | ❌ no | unchanged |
| `LIBOORA_BOUNDED_CONTEXT_MAP.md` | 4 | ❌ no | unchanged |
| `ARCHITECTURE_RULINGS.md` | 5 | ❌ no | unchanged |
| `CONFIGURATION_GUIDE.md` | 7 | ❌ no | unchanged |
| `tool/module_dependencies.yaml` | tooling | ❌ no | unchanged |

**`RF-01` required no ADR** because `AR-1` already rules the exact pattern — it composes `BC-02` Membership Plans
and `BC-04` Seat Capacity with no edge declared and no `BC-` identifier assigned. The correction *cites* that
ruling rather than extending it. The context count remains **31 (23 in V1)**, no `BC-32` was created, and no new
edge was declared.

**`RF-02` required no ADR** because BC Map §8 line 408 **already assigns** `enrollment.StudentLinkedToPerson` to
`BC-01`. The event was not invented; an earlier draft of the PRD omitted a mandated member of its own closed set.
Its semantics were not changed.

**`RF-06` required no ADR** because the resolution invokes the existing deny-by-default posture (`AP-3`) and
`SID-4.56`. **No legal rule was invented** — the age threshold stays 18 per BC Map line 370, and the absent-DOB
case is answered with a controlled, auditable behaviour rather than a guess.

### 7.1 One governance item is raised, not actioned — `RF-17`

Per the instruction to stop before modifying a frozen document:

| Field | Value |
|---|---|
| **Document** | `docs/30-product/student-identity/Student_Identity_PRD_v1.md` (`PRD-003`), **Rank 3, frozen** |
| **Sections** | §2.4 (lines 305–315) and `SID-5.9` (line 1120) |
| **Conflict** | §2.4 lists **Date of Birth** under *Optional* (mandatory = *"Full Name (the only mandatory human-supplied field)"* + Username), reinforced by `SID-2.5`. `SID-5.9` states DOB *"**SHALL** be stored, because minor-safety obligations (`ID-6`) depend on it."* A field cannot be both optional to supply and guaranteed to exist |
| **Proposed change** | Either narrow `SID-5.9` to *"when supplied"*, or move DOB to mandatory in §2.4 and accept the `SID-2.5` minimality consequence |
| **ADR required?** | **Yes** — Rank 3 frozen document, owner is `BC-10` |
| **Action taken here** | **None.** Recorded as `SM-GAP-10`; `SM-4.5c` forbids this module from resolving it; `SM-4.5a`/`SM-4.5b` make `PRD-004` safe under either outcome |

### 7.2 Unranked documents updated as a consequence

`PRD-004_TRACEABILITY.md` (v1.0 → v1.1), `docs/README.md`, `PRODUCT_IMPLEMENTATION_ROADMAP.md`. All three are
outside the `DOCUMENTATION_BASELINE.md` §4 precedence list, so they are editable without an ADR.
`PRD-004_TRACEABILITY.md`'s own header authorises this correction: *"Where this file disagrees with `PRD-004`,
`PRD-004` is right and this file is a defect."*

---

## 8. Validation results — 16 points

| # | Point | Result | Evidence |
|---|---|---|---|
| 1 | PRD format | ✅ pass | Structure preserved; still **10 chapters**; §0.1/§0.2 and §4.2.1/§10.5.1 are subsections, not new chapters |
| 2 | Requirement ID continuity | ✅ pass | `SM-c.n` 107 contiguous per chapter; `SM-BR` 1-16, `SM-XC` 1-14, `SM-INV` 1-11, `SM-EV` 1-10, `SM-PO` 1-12, `SM-AC` 1-30, `SMCFG` 1-7, `LMD` 1-31, `SM-GAP` 1-10 — **zero gaps**; `IMPL-300`…`323` contiguous (`IMPL-214` is a cross-reference to an existing task) |
| 3 | Duplicate IDs | ✅ pass | 303 distinct defined identifiers, **no duplicate definition site**. The two apparent hits (`SM-7.1a`, `SM-8.4a`) are §0.2 register-declaration rows, not definitions. **One real collision was caught pre-commit**: `SM-10.10` was already taken |
| 4 | Traceability | ✅ pass (measured) | **221/238 = 92.9%**, 17 untraced, all named. Script exits non-zero while any remain |
| 5 | Architecture references resolve | ✅ pass | `AR-1`…`AR-4` present in `ARCHITECTURE_RULINGS.md`; `ADR-0011`, `ADR-0013`, `ADR-0016` files exist in `docs/00-governance/adr/` |
| 6 | Event references resolve | ✅ pass | All 10 cited edges (`E-01`, `E-09`, `E-11`, `E-13`, `E-19`, `E-20`, `E-21`, `E-22`, `E-23`) present in BC Map. `E-02` now appears **only** in the rationale explaining why the old citation was wrong |
| 7 | Cross-context ownership | ✅ pass | `LMD-24b` denies authority over `MembershipStatus`/seat/attendance/fee; `SM-2.14` delegates; writes go through owning command APIs (`F-3`) |
| 8 | Directory remains a read composition | ✅ pass | 0 occurrences of `BC-32`; `LibraryMember` appears **only** in `SM-1.7`'s prohibition and its rationale; §5.4 declares **no edge**; context count 31 |
| 9 | Global Identity boundary | ✅ pass | `personId` non-nullable (`SM-2.3`, `SM-INV-5`); `SM-XC-9` bans `StudentRecordId` in global events/indexes; `SM-7.12b` applies it to `SM-EV-10`; `SM-AC-28` verifies |
| 10 | Enrollment vs Membership separation | ✅ pass | `SM-BR-2` and §2 rationale keep them **two independent state machines** (BC Map line 209); `SM-2.14` no longer legislates membership |
| 11 | API ownership | ✅ pass | §10.2 — every endpoint a `BC-01` resource; authorisation delegated to `BC-18` (`SM-8.6`); search delegated to `BC-23` (`LMD-12`) |
| 12 | AC coverage | ✅ pass | 30/30 rows carry a non-empty `Verifies` cell; **65 distinct requirements** verified; `SM-10.11` makes the reverse direction normative |
| 13 | Links | ✅ pass | **517 relative links, 0 broken** (516 before; the new script link resolves) |
| 14 | YAML | ✅ pass | All 5 tracked YAML files parse; `module_dependencies.yaml` **unchanged** |
| 15 | Architecture tests / checker | ⚠️ **pre-existing red, unchanged** | Gate 1 format exit 0 (59 files, 0 changed) · Gate 2 analyze *"No issues found!"* · **Gate 3 exit 1** · Gate 4 `test/architecture/` **20/20 pass** · Gate 5 `flutter test` **77/77 pass** |
| 16 | Frozen-document integrity | ✅ pass | All 9 ranked/frozen documents byte-identical vs `1922f8d`; `git diff 1922f8d HEAD -- lib/ test/ pubspec.yaml web/ packages/ android/` → **empty** |

**On point 15.** Gate 3 is red for exactly one pre-existing reason: `platform/business → platform/tenancy`, one
site, `EntitlementService` importing the tenancy barrel for `TenantTier` — owned by `TASK-D10`/`BLK-01` under
`ADR-0012` §3.4, expiring 2026-10-31. **This correction did not change that result**, and per instruction it is
not treated as a `PRD-004` defect. This is a documentation-only pass; no Dart file was touched, so gates 1–5 could
only have been affected by accident, and were not.

---

## 9. Remaining open decisions

| # | Open item | Owner | Blocking freeze? |
|---|---|---|---|
| 1 | **`SM-GAP-10` / `RF-17`** — DOB optional (`PRD-003` §2.4) vs *"SHALL be stored"* (`SID-5.9`) | `BC-10` owner; **ADR required** | ❌ no — `SM-4.5a`/`5b` make `PRD-004` safe either way |
| 2 | **`SM-GAP-4`** — `TR-5` Parent authorisation. `SM-8.4a` records an interim **deny**; the question is unanswered | Parent Portal owner (Master PRD §8 module 5, **no PRD**) | ❌ no — interim value is safe under `AP-3` |
| 3 | `SM-GAP-1` retention period · `SM-GAP-2` `enrollmentNumber` format · `SM-GAP-3` `Inactive` and seat allocation · `SM-GAP-5`…`SM-GAP-9` | various | ❌ no — declared, not silently assumed |
| 4 | **17 untraced requirements** (§6) — internal design decisions with no external authority | `PRD-004` owner + next reviewer | ⚠️ **reviewer should challenge**; none contradicts a ranked document |
| 5 | **0 of 30 acceptance criteria executed**; `IMPL-300`…`IMPL-323` all unstarted | implementation | ❌ not a PRD defect, but per `SID-4.56` the criteria are **unmet, not satisfied by design** |
| 6 | `TASK-D10`/`BLK-01` — gate 3 red | architecture | ❌ pre-existing, unrelated |

---

## 10. Freeze readiness

### FINAL DECISION: **B. NEEDS ANOTHER REVIEW**

`PRD-004` is **not** frozen by this pass, and freezing it now would be wrong.

**Why not A.** All three HIGH findings are resolved, all 16 validation points pass or are pre-existing-red, no
frozen document was touched, and no ADR proved necessary. That makes the document *materially better* — but the
`RF-01` correction changed the **architectural interpretation** of how the Directory reads foreign data: from an
implied cross-context read to an explicit `AR-1` application-layer composition, with `SM-7.1` rescoped to the
domain layer. Three new requirements (`SM-7.1a`, `LMD-24a`, `LMD-24b`) now carry that interpretation, and
`SM-EV-10` adds a member to a previously closed event set. The governing instruction is explicit: *"If any
substantive requirement or architectural interpretation changed, recommend another independent review before
freeze."* Both changed. A self-assessment by the author of the corrections is not the evidence a freeze needs.

**Why not C.** No architectural blocker exists. The one candidate — `RF-01` — dissolved on inspection: `AR-1`
already rules this exact pattern, composing `BC-02` and `BC-04` with no edge and no `BC-` identifier. Nothing
required a BC Map change, a `module_dependencies.yaml` change, or a new context. The one genuine frozen-document
conflict (`RF-17`) is in `PRD-003`, does not block `PRD-004`, and is recorded for its owner with an ADR flagged.

**What the second review should target, in priority order:**

1. **`RF-01` as applied** — is `SM-7.1a` + `LMD-24a` + `LMD-24b` a faithful application of `AR-1`, or does it
   stretch the ruling? This is the single highest-risk judgement in the pass.
2. **`SM-EV-10`** — confirm the payload (`personId`, `tenantId`, `at`, `consentRecordRef`), the consent gate
   (`SM-7.12a`), and that no existing event's semantics shifted.
3. **`SM-4.5b` fail-safe-to-minor** — is defaulting to the protective posture the correct controlled behaviour, or
   does it create an unacceptable onboarding cost?
4. **The 17 untraced requirements** — challenge each; some may deserve deletion rather than a citation.
5. **The two rejections** (`RF-15`, `RF-18`) — the evidence is in §3; a reviewer may disagree.
6. **`SM-8.4a`** — is an interim deny acceptable, or must `SM-GAP-4` be resolved before freeze?

**Preconditions for freeze**, per `PRD_LIFECYCLE.md`: Stage 2 gate rules now all pass (unique identifiers,
collision-checked prefixes, contiguous ranges, **normative language defined** — the last was `RF-05`). Freeze
additionally needs a second independent review with no HIGH findings, and a decision on whether `SM-GAP-4` and
`SM-GAP-10` may remain open at freeze.

---

## 11. What this report does **not** claim

| Not claimed | Actual state |
|---|---|
| That `PRD-004` is correct | It is **less wrong**. 15 findings were fixed; a second reviewer may find more |
| That 92.9% coverage means the requirements are right | It means 221 of 238 **name** a source. Naming a source is not being correct |
| That the 17 untraced requirements are safe | They are **disclosed** so they can be challenged. Disclosure is not justification |
| That any acceptance criterion passes | **0 of 30 are executed.** Per `SID-4.56` they are unmet |
| That gate 3 is green | **Legitimately red** — `TASK-D10`/`BLK-01`, unrelated to `PRD-004`, **not waived** |
| That `RF-17` is resolved | It is **raised** for the `BC-10` owner with an ADR flagged. Nothing was changed in `PRD-003` |
| That this pass may substitute for review | It may not. **Verdict B.** |

---

## 12. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-04 | Created as the review record for the `PRD-004` correction pass. Reproduces all 21 findings from the live repository, accepts 15, rejects 3 with evidence, and defers 1 (`RF-17`) to the `BC-10` owner with an ADR flagged. Records that `RF-01` was resolved by **citing** `AR-1` — which already composes `BC-02` and `BC-04` with no declared edge — so **no ADR, no BC Map change and no `module_dependencies.yaml` change was required**, and the context count remains 31. Withdraws the unverifiable **96.3%** traceability claim and replaces it with a mechanically computed **221/238 = 92.9%**, a **lower** figure, with all 17 untraced identifiers named. Documents all 16 validation points, including that gate 3 remains legitimately red for the pre-existing `TASK-D10` debt. Final decision **B. NEEDS ANOTHER REVIEW** — `PRD-004` is **not** frozen, because the `RF-01` architectural interpretation and the `SM-EV-10` event-set change are both substantive. |
