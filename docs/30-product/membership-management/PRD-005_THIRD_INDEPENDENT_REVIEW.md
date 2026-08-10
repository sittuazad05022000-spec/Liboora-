# PRD-005 — Third Independent Review

**Audit-only review of the Membership Management PRD (`PRD-005`) v1.2, verifying the `F-1`…`F-4` correction pass.**

---

## 0. Verdict at a glance

# **B — MINOR CORRECTIONS REQUIRED**

Architecture and overall design are sound. `F-1` and `F-3` are fully corrected and are, in my judgement, exemplary.
`F-2` and `F-4` are **partially** corrected: each contains one defect that the correction pass introduced or failed to
detect, and in both cases the defect is a **claim that overstates what the document actually delivers** — the precise
failure mode `MM-NFR-014` exists to prevent.

| Finding | Area | Severity | Status |
|---|---|---|---|
| **TR-1** | `MM-BR-035`'s consumer-reachability clause is **violated by the register it governs** — `MM-EVT-006` lists `BC-28`, which has no edge in `MM-BR-006` | **HIGH** | New regression introduced by `F-2` |
| **TR-2** | The declared **81/81 = 100.0%** comparable coverage is **not reproducible**; measured **69/81 = 85.2%** by *Verifies* column, 77/81 = 95.1% at best. The figure is only reachable by counting a prose note that says the rules are *not* covered | **HIGH** | `F-4` claim overstated |
| **TR-3** | §25.3 states *"**Every** `MM-BR-*`, `MM-INV-*`, `MM-XC-*`, `MM-PO-*` and `MM-EVT-*` now carries at least one verifying `MM-AC-*`"* — false for 12 identifiers | **MEDIUM** | Consequence of TR-2, separately located |
| **TR-4** | `MM-EVT-001`…`006` and `MM-PO-003`/`004` are verified only in criterion *prose*, never in a *Verifies* cell, so no traceability tool can see them | **LOW** | Traceability hygiene |
| **TR-5** | Judgement Call #1: a new PRD version is **sufficient for closure**, but `ADR-0016` is direct precedent that the **consumer-reachability half** of `MM-BR-035` is ADR territory | **MEDIUM** (advisory) | Governance observation |

**`F-1` — Fully Corrected. `F-3` — Fully Corrected. `F-2` — Partially Corrected (TR-1). `F-4` — Partially Corrected
(TR-2, TR-3, TR-4).**

No finding requires a new ADR to fix inside `PRD-005`. TR-5 identifies an ADR that the **architecture owner** should
raise against the BC Map, exactly as `MM-GAP-010` already requests.

---

## 1. Review Metadata

| Field | Value |
|---|---|
| **Review** | Third independent review of `PRD-005` |
| **Reviewer role** | Independent auditor, adversarial posture |
| **Date** | 2026-08-04 |
| **Target** | `docs/30-product/membership-management/PRD-MEMBERSHIP-MANAGEMENT.md` **v1.2** |
| **Target commit** | `a60a083` |
| **Prior review** | `PRD-005_SECOND_INDEPENDENT_REVIEW.md` @ `9735de1` (verdict B, findings `F-1`…`F-4`) |
| **Correction report** | `PRD-005_F1-F4_CORRECTION_REPORT.md` @ `a60a083` (self-declared *READY FOR INDEPENDENT REVIEW*) |
| **Method** | Every quantitative claim recomputed from primary sources by script. Neither the prior review nor the correction report was accepted as evidence. |
| **Files created** | Exactly one — this report |
| **Files modified** | **None** |

---

## 2. Review Scope

In scope: verification that `F-1`…`F-4` were correctly, completely and architecturally validly corrected; the two
judgement calls the correction report flagged; and a targeted regression audit across requirements, architecture,
traceability, versioning, scope and cross-document consistency for the v1.1 → v1.2 delta.

Out of scope, and deliberately not re-litigated: `C-2` and `C-3`, ratified at `f65fd5a` and upheld by the second
review. I re-checked only that v1.2 did not disturb them (it did not — §25.1 rows are byte-identical apart from the
added `C-8` row).

**Audit-only.** No defect found here has been fixed.

---

## 3. Documents Examined

| Document | Rank | Use |
|---|---|---|
| `PRD-MEMBERSHIP-MANAGEMENT.md` v1.2 | 3 (draft) | Review target |
| `PRD-005_F1-F4_CORRECTION_REPORT.md` | — | Claims under test |
| `PRD-005_SECOND_INDEPENDENT_REVIEW.md` | — | Findings under test |
| `LIBOORA_BOUNDED_CONTEXT_MAP.md` | **4** | §5, §7 (all of E-01…E-26), §8, §9, §9.1, §10, §13, §14 |
| `Student_Management_PRD_v1.md` v1.2 **FROZEN** | **3** | §7.4 precedent, `SM-7.12`, `SM-GAP-11` |
| `ADR-0016-e22-consumer-list-includes-bc-10.md` | **2** | The consumer-list precedent — decisive for Judgement Call #1 |
| `ADR-0018-student-management-prd-v1.2-baseline.md` | **2** | Ratification of the PRD-004 treatment |
| `DOCUMENTATION_BASELINE.md` §4 | — | Precedence hierarchy |
| `MASTER_PRD.md` | **1** | Module 6 = `BC-02` `[CORE]` V1 |
| `LIBOORA_ENTERPRISE_ARCHITECTURE.md` | 6 | V1/V2/V3 classification |
| `PRD_REGISTRY.md` | — | `PRD-005` status |
| `Authentication_PRD_v2.md`, Library `REVIEW_14A.md` | 3 | Cross-document consistency |

---

## 4. Repository / Commit Examined

```
HEAD                a60a083  docs(PRD-005): correct F-1..F-4 ... v1.1 -> v1.2
                    8a3d21a  genspark auto-backup
                    9735de1  docs(PRD-005): second independent review — verdict B
git status --porcelain   → (clean, before this report)
git diff --name-status 9735de1..HEAD
  A  docs/30-product/membership-management/PRD-005_F1-F4_CORRECTION_REPORT.md
  M  docs/30-product/membership-management/PRD-MEMBERSHIP-MANAGEMENT.md
```

**Frozen / ranked-document containment — PASS.** `git diff --name-only 9735de1..HEAD` restricted to
`docs/10-architecture`, `docs/00-governance`, `student-management`, `authentication`, `library`, `MASTER_PRD.md`,
`lib`, `test`, `tool`, `pubspec.yaml` returns **empty**. ADR directory holds **18 ADRs + 1 index = 19 files** at both
`9735de1` and `a60a083` — **no ADR created**. `PRD_REGISTRY.md` L225 still shows `PRD-005` = **`PLANNED`**; the PRD
header still says `DRAFT`. **Not frozen, not registered, no implementation.** All correction-pass constraints held.

---

## 5. `F-1` Verification — BC-26 Analytics event consumer

### 5.1 Does a `BC-02` → `BC-26` edge exist? — **No. Independently confirmed.**

`grep -n 'BC-26'` over the BC Map returns 26 hits. Exactly **one** falls inside §7 (Integration Relationships,
L290–363):

```
L335 | E-26 | BC-27 AI | BC-26 Analytics, BC-23 Search | CF | Sync port | ...
```

`BC-26`'s only inbound edge in the entire register is `E-26`, from `BC-27`. There is no `BC-02` → `BC-26` row, and no
`BC-01` → `BC-26` row. **Verified independently — the correction report's central factual claim is true.**

### 5.2 Is the edge table binding? — **Yes.**

BC Map §7 preamble, L292, verbatim:

> *"Every edge that crosses a context boundary in V1. If an edge is not in this table, it **does not exist** and
> adding it requires an ADR."*

I checked the scope of this sentence adversarially: it is **edge-scoped**, and it is the **only** ADR trigger in the
BC Map. It does not speak to §9 consumer lists. PRD-005's reading is correct and is not overstated.

### 5.3 Does any edge reachable from `BC-02` terminate at `BC-26`? — **No.**

Destination check of every edge PRD-005 claims:

| Edge | BC Map line | Terminates at | `BC-26`? |
|---|---|---|---|
| `E-02` | L299 | `BC-04` Seating | No |
| `E-03` | L300 | `BC-03` Attendance | No |
| `E-07` | L304 | `BC-05` Fee & Collection | No |
| `E-20` | L329 | `BC-24` Audit Trail (*"All contexts"* as **upstream**) | No |
| `E-23` | L332 | `BC-22` Notification (*"All contexts"* as **upstream**) | No |

The *"All contexts"* wording on `E-20`/`E-23` denotes the **upstream** column — any context may emit **to** `BC-24` /
`BC-22`. Neither creates a path to `BC-26`. **The v1.1 reachability claim was genuinely false, and v1.2's correction
of it is genuinely correct.**

### 5.4 Was `BC-26` correctly removed? — **Yes, completely.**

`grep -n 'BC-26'` over v1.2 returns 17 hits, and **not one** is a consumer declaration:

- **L15 header** — now reads *"…`BC-24` Audit Trail (`E-20`) — **`BC-26` Analytics is deliberately not listed; see
  `MM-BR-035` and `MM-GAP-010`**"*. Correct.
- **§12 event table L1006–1012** — all seven rows checked individually. `BC-26` appears in **zero** *Consumers*
  cells. Correct.
- **L1080 reachability sentence** — now names the five verified consumers with their edge IDs and states *"**`BC-26`
  is not among them and is therefore not listed as a consumer**"*. Matches my §5.3 table exactly.
- Remaining hits are ownership statements (L150, L973, `MM-BR-030` L867/L1185), the V1/V3 boundary table (L873), the
  `MM-BR-035` explanatory note, `MM-AC-076`, `C-8`, `MM-GAP-010` and the change-history row. All are correct in
  context; none asserts consumption.

### 5.5 Does `MM-GAP-010` capture the tension correctly? — **Yes.**

L1699 records both sides with line-level citations (§9 L409/410/412/413 vs §7 L335 and L292), assigns it to
*"Architecture (BC Map owner)"*, and marks it non-blocking with a stated reason. This is a faithful, verifiable
description of a **Rank 4 internal** tension. It correctly does **not** purport to decide it.

**I confirm the tension is real and is internal to Rank 4.** BC Map §9 names `BC-26` a consumer for **eleven**
producing contexts (`BC-01`, `BC-02`, `BC-03`, `BC-04`, `BC-05`, `BC-10`, `BC-11`, `BC-12`, `BC-18`, `BC-20`,
`BC-27`) while §7 gives it exactly one inbound edge. This is a **systemic** Rank 4 defect, not a `BC-02` peculiarity —
which strengthens, not weakens, PRD-005's refusal to resolve it locally.

### 5.6 Is `C-8` justified? — **Yes.**

Under `DOCUMENTATION_BASELINE.md` §4 — *"**A conflict is a defect.** If you find one, do not choose — raise it"* —
recording `C-8` is the mandated behaviour. Severity *Medium* is defensible: no V1 behaviour changes either way.

### 5.7 Does removing `BC-26` create hidden inconsistency? — **No.**

I searched for every place that could still presuppose `BC-26` consumption. `MM-BR-030` (*"`BC-26` **MUST** learn
about membership only from the events in §12"*) remains **coherent**: it constrains how `BC-26` may learn, not that
this document must enumerate it. §9's V1/V3 table, §22, `MM-XC-006` and `MM-AC-076`/`074a`/`094` are all consistent.
`MM-AC-076` is correctly framed as a **negative** check. No orphaned reference found.

### 5.8 Does the PRD imply Analytics can never consume in future? — **No, and this is handled well.**

L1046–1050 states the events are published to the bus *"regardless of which consumers this table enumerates"*, and
that on resolution of `MM-GAP-010` *"`BC-26` becomes a listed consumer with **no change to any event, payload or
producer**"*. The door is explicitly left open. No future-blocking implication exists.

### 5.9 Is the PRD-004 precedent real? — **Yes, verified verbatim.**

Frozen `Student_Management_PRD_v1.md` §7.4 L808–813:

> *"**`BC-26` Study Analytics** — BC Map §8 names `BC-26` a primary consumer … while BC Map §7 declares no
> `BC-01`→`BC-26` edge … That is a **tension internal to the Bounded Context Map (Rank 4)**, not a decision this
> document may take: `BC-26` is therefore **not listed as a consumer here**… Recorded as **`SM-GAP-11`**."*

`SM-GAP-11` exists at L1177; `ADR-0018` froze the document with that treatment intact and its §3 explicitly declines
to decide it. PRD-005 v1.2's treatment is structurally identical. One minor imprecision: PRD-005 cites the PRD-004
tension as *"§9 names"* whereas PRD-004 itself says *"§8 names"* — PRD-005's numbering is the **correct** one (the
event surface is §9; §8 is the Aggregate Register), so PRD-005 is silently right and PRD-004 is loose. Not a defect
in PRD-005.

### 5.10 `F-1` verdict

# **`F-1` — FULLY CORRECTED**

Factually accurate, precedent-consistent, no edge invented, no ADR taken, no hidden inconsistency, future path
preserved. This is a model correction.

---

## 6. `F-2` Verification — event register closure (`MM-BR-035`)

`MM-BR-035`, verbatim (L1027–1030):

> *"The event register above **MUST** be closed at **seven** events. Adding, removing or renaming an `MM-EVT-*`
> **MUST** require a new version of this document, and **MUST NOT** be done by an implementation. Every consumer
> named in the table **MUST** be reachable on an integration edge already declared in `MM-BR-006`; a consumer that is
> not **MUST NOT** be listed here."*

| Check | Result |
|---|---|
| Register defined as a closed set? | **Yes** — §12 heading, `MM-BR-035`, §0.2 (*"**closed set**"*, count 7) all agree |
| Seven-event count correct? | **Yes** — mechanically 7 `MM-EVT-*`, contiguous `001`…`007`, no duplicates |
| Adding/removing/renaming controlled? | **Yes** — and notably it forbids implementation-level change, which frozen `SM-7.12` does not |
| Deterministic and enforceable? | **Partly** — the count half is trivially checkable; the reachability half is checkable and **currently fails** (TR-1) |
| Consumer reachability constrained? | **Yes in wording — but the rule is violated by its own table** |
| Consistent with existing architecture? | Yes for the count; **no** for reachability as written (TR-1) |
| Conflicts with a higher-ranked document? | **No.** BC Map §9 declares closure only for `BC-10` (L429) and self-describes as the *"**seed** of the full Event Catalog"* (L399). A Rank 3 PRD declaring its own register is ratified practice (`ADR-0018` over PRD-004's 10-vs-4) |

### 6.1 **TR-1 (HIGH) — `MM-BR-035` is violated by the register it governs**

**Location:** `PRD-MEMBERSHIP-MANAGEMENT.md` L1012 (`MM-EVT-006` row) against `MM-BR-035` (L1027–1030) and
`MM-BR-006` (§11.1, L943–958).

**What is wrong.** `MM-BR-035` requires that *"Every consumer named in the table **MUST** be reachable on an
integration edge already declared in `MM-BR-006`; a consumer that is not **MUST NOT** be listed here."* The
`MM-EVT-006` row reads:

```
| MM-EVT-006 | membership.MembershipExpiringSoon | ... | `BC-22`, `BC-28` (V2) | ...
```

**`BC-28` is not reachable on any edge declared in `MM-BR-006`.** The ten edges listed there are `E-01`, `E-02`,
`E-03`, `E-07`, `E-10`, `E-17`, `E-18`, `E-19`, `E-20`, `E-23` — none terminates at `BC-28`. Worse, `BC-28` has **no
edge anywhere in BC Map §7**: `grep 'BC-28'` over L290–363 returns **zero** hits. `BC-28` appears in the BC Map only
at L137 (register), L147 (V2 list), L266 (diagram), **L411 (§9 consumer of exactly this event)**, L420 and L465.

**Evidence.** This is the *identical* defect class as `F-1`: BC Map §9 L411 names `BC-28` a consumer of
`membership.MembershipExpiringSoon` while §7 declares no edge to it. The correction pass de-listed `BC-26` for exactly
this reason and **left `BC-28` in place on the very next column of the very same table**.

**Why it matters.** Three compounding reasons:
1. **A brand-new rule is false on introduction.** `MM-BR-035` is one of only two `MUST` rules added at v1.2, and the
   register it governs violates it. Under `MM-NFR-014` (*"a rule that cannot be checked SHALL be treated as unmet"*)
   a rule that **is** checkable and **fails** is worse than unmet.
2. **It makes `MM-AC-075` fail.** That criterion asserts *"every consumer named resolves to an edge declared in
   `MM-BR-006`"*. Executed today it returns **fail** on `BC-28`.
3. **It undermines the `F-1` fix's stated rationale.** The document's justification for de-listing `BC-26` applies
   verbatim to `BC-28`. Leaving one and removing the other is internally inconsistent and invites the reasonable
   objection that `BC-26` was removed to satisfy a review rather than a principle.

**Recommended correction (not applied).** Choose one and state it:
- **(a)** De-list `BC-28` from `MM-EVT-006` and extend the `MM-GAP-010` note (or add a sibling gap) to record the
  `BC-28` §9-vs-§7 tension — perfectly parallel to the `BC-26` treatment; **or**
- **(b)** Narrow `MM-BR-035`'s reachability clause to V1 consumers, e.g. *"every **V1** consumer … a V2 consumer is
  annotated `(V2)` and is listed for forward compatibility only, and does not assert a V1 edge"*, and say so in the
  note. This is defensible because the row already carries the `(V2)` annotation, and `MM-EVT-006` is itself a fact
  that will be consumed by a V2 saga.

Option (a) is more consistent with the `F-1` precedent; option (b) preserves more information. Either resolves it.

**ADR required?** **No.** Both options are internal to `PRD-005` — one removes an unsupported claim, the other scopes
a rule this document owns. Neither adds an edge. The **underlying Rank 4 defect** (§9 naming `BC-28` with no §7 edge)
needs the architecture owner, as `MM-GAP-010` already frames for `BC-26`.

### 6.2 Is a new PRD version *sufficient*, or is an ADR *required*? — see §9 (Judgement Call #1).

### 6.3 `F-2` verdict

# **`F-2` — PARTIALLY CORRECTED**

The closure obligation is now genuine, enforceable and well-drafted — a real improvement that did what `F-2` asked.
But the rule's own table violates its second clause (**TR-1**), so the "actually enforceable" objective is met in
wording and failed in fact.

---

## 7. `F-3` Verification — `endDate` / reactivation contradiction

I traced every rule the instruction named.

| Requirement | Line | Text (material part) |
|---|---|---|
| `MM-FR-057` | L454 | `endDate` = `startDate + (durationDays − 1)`, calendar arithmetic in tenant timezone |
| `MM-FR-058` | L457 | **Pure function** of (`startDate`, `durationDays`, timezone); **MUST NOT** depend on the current clock |
| `MM-FR-057a` | L464–470 | On delayed activation with `MM-CFG-009` enabled, re-derive by setting `startDate` := activation date and recomputing `endDate` by the **`MM-FR-057` formula unchanged**; activation date captured once as `activatedAt` and **passed in as the new `startDate` input**; *"Moving `endDate` while holding `startDate` fixed **MUST** be impossible"* |
| `MM-FR-047` | L401 | Idempotency on `idempotencyKey` |
| `MM-INV-002` | L1200 | `endDate >= startDate` |
| `MM-INV-011` | L1211 | `activatedAt` set iff ever `Active` |

**1. Is `endDate` still pure where the PRD says it must be? — Yes.** `MM-FR-057` is textually unmodified
(`git diff` confirms no change to L454). `MM-FR-058`'s purity holds because `MM-FR-057a` routes the activation date in
as a **recorded input** (`activatedAt`) rather than a clock read inside the computation. This is the correct
distinction and the document states it explicitly at L471–479.

**2. Is reactivation handled consistently? — Yes.** Three sites agree, with no residual "recompute `endDate`" wording
anywhere:
- §10.2 L921: *"either the original term stands (default, `MM-CFG-009` = `false`), **or** the whole term is re-derived
  from a new `startDate` equal to the activation date, with `endDate` recomputed by the **same** `MM-FR-057`
  formula… `endDate` **MUST NOT** be moved while `startDate` is held fixed"*
- `MM-CFG-009` L1166: *"Re-derive the **whole term** … (`startDate` := activation date, `endDate` by the `MM-FR-057`
  formula)"*, default `false`
- §21 edge 13 L1424: *"`MM-CFG-009` governs whether the whole term is re-derived per `MM-FR-057a`, **never `endDate`
  alone**"*

**3. Is `activatedAt` used correctly? — Yes.** Declared in §13.1, stored **UTC** per `MM-FR-063`, governed by
`MM-INV-011`, verified by `MM-AC-091`. Note `MM-FR-063` keeps timestamps in UTC while term endpoints are dates; the
conversion boundary is `MM-FR-061` (tenant timezone). Consistent.

**4. Can `endDate` be moved independently? — No.** Forbidden in three places (`MM-FR-057a`, §10.2, §21 edge 13), and
`MM-FR-057a` supplies the *reason* (it would exceed `durationDays` and break `MM-FR-057`), not merely a prohibition.

**5. Is the operation idempotent? — Yes.** Because the new `startDate` is `activatedAt` — persisted once, guarded by
`MM-INV-011` — replaying the activation event yields the same term. `MM-FR-047` holds, as L478 claims. `MM-AC-064`
verifies replay on `paymentReference`; §10.2 row 3 forbids a second `MM-EVT-002`.

**6. Does the new wording introduce a contradiction elsewhere? — No.** I specifically probed:
- `MM-FR-064` (timezone reconfiguration must not retroactively alter `startDate`/`endDate`) — no conflict:
  `MM-FR-057a` fires on activation, not on config change.
- `MM-FR-019`/`023` (plan edits must not change existing terms) — no conflict: re-derivation is driven by activation,
  not by plan mutation.
- §6.3 renewal boundary cases — untouched; renewal derives from the source `endDate`, which is now stable.
- `MM-INV-002` — preserved for all `durationDays >= 1`, as L479 states. The pre-existing `MM-GAP-008` (`>` vs `>=`)
  is unchanged and correctly still flagged at §21 edge 29.

**7. Architecturally valid? — Yes.** It stays inside `BC-02`, adds no edge, invents no proration (correctly deferred
to V2 / `MM-GAP-002`), and is default-off (`MM-CFG-009` = `false`), so V1 behaviour is unchanged unless a tenant opts
in. Config ownership routes through `BC-25` per `MM-BR-025`/`ADR-0017`.

**One observation, not a finding.** §0.2 L75 documents the `MM-FR-057a` suffix convention, and the register maths
works (118 numeric + 1 suffixed = 119). Choosing a suffix over `MM-FR-119` deliberately avoids shifting existing
citations. Sound.

### 7.1 `F-3` verdict

# **`F-3` — FULLY CORRECTED**

The contradiction is genuinely eliminated rather than papered over: reformulating the change as an **input
substitution** preserves `MM-FR-057` and `MM-FR-058` literally, keeps idempotency, and aligns all four dependent
sites. No new contradiction introduced.

---

## 8. `F-4` Verification — acceptance-criteria coverage (recalculated, not trusted)

I recomputed coverage from scratch. Comparable set = `MM-BR-*` ∪ `MM-INV-*` ∪ `MM-EVT-*` ∪ `MM-XC-*` ∪ `MM-PO-*`.

**Register sizes (independently measured):** `MM-BR` 35, `MM-INV` 12, `MM-EVT` 7, `MM-XC` 16, `MM-PO` 11 → **81**.
Matches the declared denominator. `MM-AC-*` rows parsed: **97**. Overall criterion-verifiable denominator (all
registers except `MM-AC-*` and `MM-GAP-*`): **223**. Both denominators are correct and honestly chosen.

### 8.1 The three defensible counting methods, and what each yields

| Method | Comparable | Overall |
|---|---|---|
| **(A) Strict — ID appears in a criterion's *Verifies* column** | **69/81 = 85.2%** | **126/223 = 56.5%** |
| **(B) Loose — ID appears anywhere in the criterion row (text or *Verifies*)** | **77/81 = 95.1%** | **135/223 = 60.5%** |
| **(C) Block-scan — ID appears anywhere in §23, including the closing prose notes** | **81/81 = 100.0%** | **140/223 = 62.8%** |
| **PRD-005 declares** | **81/81 = 100.0%** | **140/223 = 62.8%** |

The declared figures reproduce **only under method (C)**.

### 8.2 **TR-2 (HIGH) — the 100% figure is a measurement artifact**

**Location:** §0.2 L67–71; §23.1 closing note L1585–1587; §25.3 *Verification coverage* row L1713; and
`PRD-005_F1-F4_CORRECTION_REPORT.md` L165, L209, L224.

**What is wrong.** Method (C) counts an identifier as *covered* when it appears anywhere in §23 — **including inside
the prose note that exists to say it is not covered**. The decisive evidence is a single line, L1589:

> *"`MM-BR-012`, `MM-BR-022`, `MM-BR-027` and `MM-BR-028` are intentionally **not** given new criteria…"*

That sentence is the **only** occurrence of those four identifiers anywhere in §23. Under method (C) the sentence
declaring them uncovered is what makes them count as covered. Delete that one line and the declared figure drops from
100.0% to 95.1%. A coverage metric that **increases when you write prose about a gap** is not measuring verification.

The correction report states the figures were *"reproduced by script, not asserted"* (L1587, L224). I accept the
script ran — but it implemented method (C), which does not measure what the surrounding sentence claims it measures.

**The 12 identifiers with no *Verifies* citation** (method A), reproduced mechanically:

| Identifier | In any *Verifies* cell? | Appears only as |
|---|---|---|
| `MM-BR-012` | No | prose at L1589 (the "not covered" note) |
| `MM-BR-022` | No | prose at L1589 |
| `MM-BR-027` | No | prose at L1589 |
| `MM-BR-028` | No | prose at L1589 |
| `MM-EVT-001` | No | criterion **text** of `MM-AC-062` |
| `MM-EVT-002` | No | criterion text of `MM-AC-024` |
| `MM-EVT-003` | No | criterion text of `MM-AC-040` |
| `MM-EVT-004` | No | criterion text of `MM-AC-049` |
| `MM-EVT-005` | No | criterion text of `MM-AC-042` |
| `MM-EVT-006` | No | criterion text of `MM-AC-043`, `MM-AC-081` |
| `MM-PO-003` | No | criterion text of `MM-AC-027` |
| `MM-PO-004` | No | criterion text of `MM-AC-026`, `MM-AC-027` |

**Why it matters.** `F-4` was raised as a **verification-honesty** finding, and `MM-NFR-014` / `SID-4.56` state that
*"a rule that cannot be checked SHALL be treated as unmet, **not as satisfied by intent**."* A 100% claim resting on a
sentence that documents non-coverage is satisfaction by intent. The correction report is otherwise scrupulous —
§5.1 discloses four self-caught defects and explicitly refuses to pad — which makes this the one place where its own
standard was not applied to its own headline number.

**Mitigating, and material to severity.** The **substantive** work is sound. Eight of the twelve (`MM-EVT-001`…`006`,
`MM-PO-003`, `MM-PO-004`) **are genuinely tested** — just cited in prose rather than in the *Verifies* column. And the
four `MM-BR-*` are, as claimed, largely covered by other criteria (`MM-BR-027` tenant scoping by `MM-AC-051`/`052`;
`MM-BR-028` enrollment precondition by `MM-AC-015`; `MM-BR-022` plan-field mutability by `MM-AC-004`…`011`;
`MM-BR-012` bounded staleness is arguably not directly testable in this module at all). **The defect is the claim, not
the coverage.** Honestly stated, this is a **~85–95% comparable / ~57–61% overall** result — still a very large
improvement on v1.1's 13.8%, and still enough for the `F-4` objective.

**Recommended correction (not applied).** Either:
- **(a)** State the measured figure under a declared method — e.g. *"81 of 81 comparable registers are addressed; **69
  carry an explicit *Verifies* citation** and 12 are covered by criteria that name them in the criterion text or by
  the criteria listed in the note below"* — and define the counting rule in §0.2 so it is reproducible; **or**
- **(b)** Move the 8 genuinely-tested identifiers into the *Verifies* cells of the criteria that already test them
  (raising method (A) to **77/81 = 95.1%** with no new criteria and no padding), and report the remaining four
  honestly as *covered indirectly*.

Option (b) is preferable: it makes the claim true rather than re-explaining it, adds no rows, and fixes TR-4 at the
same time. Neither option requires a new obligation.

**ADR required?** **No** — internal to `PRD-005`.

### 8.3 **TR-3 (MEDIUM) — §25.3 states a universal that is false**

**Location:** §25.3, *Verification coverage* row, L1713.

**What is wrong.** It reads: *"**Measured, not asserted.** **Every** `MM-BR-*`, `MM-INV-*`, `MM-XC-*`, `MM-PO-*` and
`MM-EVT-*` now carries at least one verifying `MM-AC-*` — **81/81 = 100.0%**"*. Read literally — *carries* a verifying
criterion — this is false for the 12 identifiers in §8.2. It is the strongest form of the claim and appears in the
document's own self-audit section, which is precisely where a reader will look to decide whether to trust the rest.

I record it separately from TR-2 because it needs a separate edit and because "Measured, not asserted" is itself the
assertion under challenge.

**Why it matters.** §25.3 is the compliance summary a freeze decision would rely on. An overstatement here is a
governance risk beyond the metric itself.

**Recommended correction (not applied).** Align with whichever method §8.2 adopts; if (b), the sentence becomes true
for 77/81 and should name the four indirectly-covered rules.

**ADR required?** No.

### 8.4 **TR-4 (LOW) — machine-invisible traceability for 8 identifiers**

**Location:** `MM-AC-024`, `026`, `027`, `040`, `042`, `043`, `049`, `062`, `081`.

**What is wrong.** These criteria genuinely test `MM-EVT-001`…`006`, `MM-PO-003`, `MM-PO-004`, but name them only in
the **Criterion** column. Any traceability tool keyed on the *Verifies* column — including the repository's own
`prod004_traceability`-style scanning — cannot see the link.

Additionally, **11 of the 97 criteria have a non-identifier *Verifies* value**: `MM-AC-014`, `017`, `018`, `025`,
`057` cite *"Edge 1/18/19/14/26"*; `MM-AC-032`, `033`, `034` cite *"§6.3"*; `MM-AC-039`, `050` cite *"§15"*;
`MM-AC-054` cites *"§17"*. These are **legitimate** — the referenced sections and edge-case rows exist and are
normative (§21 is explicitly a normative table) — so this is not a dangling-reference defect. But it means 11 rows are
unresolvable to a register ID by tooling.

**Why it matters.** Low severity: correctness is unaffected. It matters for the *repeatability* of the coverage figure
that TR-2 turns on — the metric is only as good as the machine-readable field.

**Recommended correction (not applied).** Add the register IDs to the *Verifies* cells of the nine criteria; optionally
add the governing requirement ID alongside the section reference for the 11 prose citations.

**ADR required?** No.

### 8.5 Do the criteria genuinely test what they cite? — spot audit

I read all 39 new criteria and judged substance, not presence. Sample:

| Criterion | Cites | Genuinely tests it? |
|---|---|---|
| `MM-AC-059` | `MM-BR-001`, `MM-XC-004` | **Yes** — "no monetary ledger/balance/receipt/refund table" is directly falsifiable against a schema |
| `MM-AC-065` | `MM-BR-006` | **Yes** — "only the ten edges are used" is checkable; note it is also what TR-1 breaks |
| `MM-AC-071` | `MM-BR-014` | **Yes** — name-convention regex over 7 events |
| `MM-AC-075` | `MM-BR-035` | **Yes, and it currently FAILS** on `BC-28` (TR-1) |
| `MM-AC-076` | `MM-BR-035`, `MM-BR-030` | **Yes** — negative check, verifiable |
| `MM-AC-084` | `MM-BR-031`, `MM-INV-004` | **Yes** — "exactly one validity answer" is testable against §4.5 |
| `MM-AC-091` | `MM-INV-011` | **Yes** — iff-condition on `activatedAt` |
| `MM-AC-088` | `MM-INV-002`, `MM-FR-056` | **Yes** — and correctly no longer cites the open question `MM-GAP-008`; the §5.1 self-caught defect was genuinely fixed |

**No phantom references.** Every ID cited by any criterion resolves to a defined identifier — measured: **0 dangling**.
**0 `MM-GAP-*` cited as verifiable.** **0 rows with an empty *Verifies* field.** The phantom `MM-FR-119` reported as
self-caught in the correction report is genuinely absent (`grep` = 0 hits). Those three self-audit claims **verify**.

### 8.6 `F-4` verdict

# **`F-4` — PARTIALLY CORRECTED**

39 real criteria testing pre-existing rule text is a substantial, non-padded improvement, and the underlying coverage
gain is genuine. But the headline **100.0%** is not reproducible by any method that measures verification rather than
textual mention (**TR-2**), and §25.3 states it as a universal that is false (**TR-3**).

---

## 9. Judgement Call #1 — new PRD version vs ADR for `MM-BR-035`

**The claim under test:** *"`MM-BR-035` requires a new version of this document rather than an ADR… A reviewer may
reasonably rule that the closure rule must ultimately be ADR-backed."*

I neither accept nor reject this automatically. The rule has **two clauses**, and the governance hierarchy gives them
**different** answers.

### 9.1 Clause 1 — closure at seven, changed by a new document version

**Verdict: ARCHITECTURALLY VALID.** Evidence:

1. **The BC Map's only ADR trigger is edge-scoped.** L292 concerns §7 edges. Closure of a module's own event register
   is not an edge.
2. **§9 does not claim to be an enumeration.** L399: *"This is the **seed of the full Event Catalog**… names,
   producers and consumers are **fixed here**; payload schemas and versioning belong in the catalog."* *"Names are
   fixed"* binds spelling; PRD-005 conforms (`membership.MembershipRenewed` etc.).
3. **§9 marks closure explicitly when it means it — and delegates it downward.** The only *"closed set"* in the entire
   BC Map is L426: *"`SEV-1`…`SEV-16` — closed set, **see Student Identity PRD §4.14**"* — i.e. Rank 4 delegates
   register closure to a **Rank 3 PRD**. That is direct authority for PRD-005 owning its own closure.
4. **Ratified precedent.** Frozen PRD-004 §7.4 declares a closed set of **ten** where §9 lists **four**, adding six
   events, and `ADR-0018` froze it **without** amending the BC Map and **without** an ADR for the additions.
5. **Rank.** `DOCUMENTATION_BASELINE.md` §4 puts module PRDs at Rank 3 with scope *"everything inside"* their BC.
   `BC-02`'s event register is inside `BC-02`.

Requiring an ADR merely to close a register the document owns would be **stricter than the frozen precedent** and
stricter than Rank 4's own delegation pattern. `MM-BR-035` clause 1 is correctly placed. It is also *stronger* than
`SM-7.12` in one respect — it forbids implementation-level change — which is an improvement, not a divergence.

### 9.2 Clause 2 — consumer reachability: **this is where an ADR is implicated**

**Verdict: ACCEPTABLE AS WRITTEN, BUT THE UNDERLYING QUESTION IS ADR TERRITORY — and `ADR-0016` is the precedent.**

`ADR-0016` is directly on point and I verified it in full. Its title: *"Edge `E-22` must list `BC-10`, an edge the
Student Identity PRD already requires."* Its `Amends` field: *"BC Map (Rank 4) — §7.3, edge **`E-22`**, the
***Consumer* cell only**. No edge added, no edge removed, no mode changed, no context reclassified."* Its §1.1 quotes
L292 and reasons: *"The rule cuts both ways. It is why this ADR exists (**the edge cannot simply be typed in**), and it
is why the omission matters (until amended, the map asserts the edge does not exist)."*

So the repository has already ruled that **amending a §7 consumer list requires an ADR at Rank 2** — even when nothing
disputes the modelling. By that precedent, *adding* `BC-26` (or `BC-28`) as a reachable consumer is **not** something
`PRD-005` could ever do by versioning itself.

**But `PRD-005` does not attempt that.** It does the opposite: it **declines** to list them and refers the question
upward via `MM-GAP-010`. That is the `ADR-0016`-consistent behaviour, and it is why clause 2 as *written* is
acceptable.

**Conclusion.** Judgement Call #1 resolves as **"Architecturally valid" for clause 1; "Acceptable but the underlying
architecture question must be ADR-backed" for clause 2** — where the ADR is owed by the **architecture owner against
the BC Map**, not by `PRD-005`. `MM-GAP-010` already requests exactly this. **No governance violation.** The author's
caveat was appropriately raised and resolves in the document's favour.

### 9.3 **TR-5 (MEDIUM, advisory) — the referred ADR is under-scoped**

`MM-GAP-010` frames the referral as a `BC-26` question. The primary evidence shows it is **systemic**: BC Map §9 names
`BC-26` a consumer for **eleven** producing contexts with one inbound edge, and names `BC-28` a consumer (L411, L420)
with **zero** edges. `SM-GAP-11` raised the `BC-01` slice; `MM-GAP-010` raises the `BC-02` slice; nobody has raised the
general rule. Because this is the second module PRD to hit it and the gap register is the only carrier, the referral
would be more useful stated as the general question: *"do capability contexts consuming Published Language require
per-producer §7 edges, or does §9 consumption need a general fan-out rule analogous to `E-20`/`E-23`?"*

**Recommended correction (not applied).** Broaden `MM-GAP-010`'s question to name `BC-28` and the general
projection/fan-out rule. **ADR required?** Not from `PRD-005` — but the architecture owner owes one against the BC Map,
and the Rank 4 defect should not be closed piecemeal.

---

## 10. Judgement Call #2 — grouped criteria `MM-AC-093` / `MM-AC-094`

**The claim under test:** grouping is legitimate because *"the underlying obligations are genuinely one test apiece…
splitting them into eighteen near-identical rows would inflate the count without adding a single distinct check."*

**`MM-AC-093`** — cites `MM-NFR-007` plus `MM-PO-001`, `002`, `005`…`011` (nine protected operations):
> *"Each of `MM-PO-001`, `MM-PO-002`, `MM-PO-005`…`MM-PO-011` is refused when the caller lacks it, and authorised
> **before** any state is read or mutated"*

**Assessment: LEGITIMATE.** The word *"Each"* makes it distributive — it is a parameterised assertion over an
authorisation matrix, which is exactly how such a suite is written in practice (one test body, nine cases). Each
grouped obligation **is** individually testable, and the criterion says so. Splitting it would produce nine rows with
identical bodies. This is not inflation; refusing to split it is the **anti**-inflation choice, and the author
correctly declined the padding.

**`MM-AC-094`** — cites `MM-NFR-006`, `MM-XC-016`, `MM-XC-005`, `MM-XC-006`, `MM-XC-013`, `MM-XC-014`:
> *"No role, permission or authorisation model is defined in this module; no cross-tenant or cross-library membership
> is representable; no SMS/push/email is sent and no analytic metric is computed"*

**Assessment: LEGITIMATE BUT WEAKER.** This bundles **three distinct** propositions (no auth model / no cross-tenant
representability / no notification-or-analytics execution), unlike `MM-AC-093`'s single parameterised one. Each is
falsifiable and each maps to its cited exclusions, so coverage is meaningful — but the three are not "one test." Also
note `MM-XC-005`/`MM-XC-006` are **additionally** covered by `MM-AC-074a`, so the bundle is not the sole carrier.

**Is grouping merely a way to claim 100%?** **No.** The grouping is not what produces the 100% figure — TR-2 shows the
figure comes from block-scanning prose. Removing the grouped rows entirely would not change the 12 identifiers that
lack a *Verifies* citation. The two issues are independent, and on verification quality the grouped criteria are
sound.

**Verdict:** **Grouping is legitimate; each grouped obligation is testable; meaningful coverage is preserved.**
Optional, non-blocking improvement: split `MM-AC-094` into three criteria to match one assertion per row. Not a
finding.

---

## 11. Regression Audit (v1.1 → v1.2)

### 11.1 Requirements — **PASS**

Set-differenced every register ID between `9735de1` and `a60a083`:

```
v1.1 distinct = 290    v1.2 distinct = 332
REMOVED = []   (none)
ADDED   = MM-BR-035, MM-FR-057a, MM-GAP-010, MM-AC-059…094 + 074a/076a/080a   (42)
```

- **No valid requirement deleted** — removed set is empty.
- **No requirement renumbered** — every v1.1 ID survives with the same number.
- **No requirement weakened** — normative-verb census: `MUST NOT` 99 → **102**, total `MUST` 325 → **334**,
  `SHOULD` 2 → 2, `MAY` 13 → 13. Obligations strictly increased; no `MUST` was downgraded.
- **No duplicate IDs**; **all registers contiguous** (script below).
- **Declared counts match actual** — 332 total, 320 obligation-bearing, 12 `MM-GAP`.

| Register | Declared | Numeric | Suffixed | Total | Gaps |
|---|---|---|---|---|---|
| `MM-FR` | 119 | 118 | 1 (`057a`) | 119 | none |
| `MM-BR` | 35 | 35 | 0 | 35 | none |
| `MM-INV` | 12 | 12 | 0 | 12 | none |
| `MM-EVT` | 7 | 7 | 0 | 7 | none |
| `MM-XC` | 16 | 16 | 0 | 16 | none |
| `MM-AC` | 97 | 94 | 3 (`074a`,`076a`,`080a`) | 97 | none |
| `MM-NFR` | 14 | 14 | 0 | 14 | none |
| `MM-PO` | 11 | 11 | 0 | 11 | none |
| `MM-CFG` | 9 | 9 | 0 | 9 | none |
| `MM-GAP` | 12 | 10 | 2 (`006a`,`007a`) | 12 | none |

### 11.2 Architecture — **PASS with one exception (TR-1)**

- **No new BC ownership violation** — §1.4 / §11.2 unchanged; `MM-BR-010` still routes analytics to `BC-26`,
  notifications to `BC-22`, auth to `BC-18`.
- **No invented integration edge** — `MM-BR-006`'s ten edges are byte-identical to v1.1; each verified present in BC
  Map §7. The v1.2 delta **removes** an unsupported consumer claim rather than adding one.
- **No unauthorised architecture decision** — BC Map, EA, ADRs untouched; ADR count 19 files at both commits.
- **No cross-context responsibility duplication** — `MM-XC-001`…`016` intact; `MM-AC-068`/`078` newly *verify*
  non-duplication.
- **Exception:** the retained `BC-28` consumer on `MM-EVT-006` is now inconsistent with the newly added
  `MM-BR-035` (**TR-1**). It is not a *new* edge claim (the row pre-dates v1.2 and carries a `(V2)` marker), which is
  why I rate TR-1 as a rule/table inconsistency rather than an invented edge.

### 11.3 Traceability — **PASS with qualifications (TR-2/TR-3/TR-4)**

- **0 dangling references** — every ID cited by a criterion resolves to a defined identifier.
- **0 phantom references** — `MM-FR-119` absent (0 hits); the self-caught defect is genuinely fixed.
- **0 `MM-GAP-*` cited as a verifiable obligation** — the `MM-AC-088` defect is genuinely fixed.
- **0 criteria with an empty *Verifies* field** — 97/97 populated.
- **Repo-wide link integrity: 582 relative links, 0 broken.**
- Qualification: coverage **claims** overstated (TR-2/TR-3); 8 real links machine-invisible (TR-4).

### 11.4 Versioning — **PASS**

V1/V2/V3 classification unchanged and consistent: §22 sources from EA 722–735 — Downgrade/Freeze/Transfer/
Cancellation-with-refund/Proration **V2**, Auto-Renewal **V3**, Cross-Library **Future**, Saga **V2 (`BC-28`)`**.
`MM-XC-007`…`016` unchanged. `MM-EVT-006`'s `BC-28 (V2)` annotation and `MM-BR-030` are untouched from v1.1.

### 11.5 Scope — **PASS**

- **No feature creep.** The v1.2 delta adds one business rule, one narrowing functional requirement, one gap and 39
  acceptance criteria. §23.1's preamble states *"**No new obligation is created here**"* — I verified this by reading
  all 39: each tests pre-existing text, none introduces a behaviour.
- **Membership Analytics NOT promoted to V1** — §9 still headed *"explicitly NOT V1"*; `MM-XC-006` intact; the V1/V3
  table unchanged. The `F-1` fix moves analytics *further* from V1, not closer.
- **No V2/V3 capability introduced into V1.** `MM-FR-057a` is a **narrowing** of `MM-FR-057` gated by a config
  defaulting to `false` — not proration (still V2, `MM-XC-012`, `MM-GAP-002`) and not freeze (still V2,
  `MM-XC-009`/`MM-INV-012`). `MM-INV-012` (*"`Frozen` unreachable in V1"*) and `MM-AC-092` confirm.

### 11.6 Cross-document consistency — **PASS**

| Against | Result |
|---|---|
| **Master PRD** (Rank 1) | L158: module 6 = Membership Management / `BC-02` / `[CORE]` / **V1** — consistent |
| **BC Map** (Rank 4) | §5 collisions observed (§25.3); §7 edges all verified; §8 `BC-02` invariants map to `MM-INV-001`/`002`; §9 naming convention honoured; §10 L465 reconciliation queue → `MM-BR-004`; `Q-01`/`Q-06` correctly left open |
| **ADRs** (Rank 2) | None modified. `ADR-0016` precedent respected (§9.2). `ADR-0017` config ownership respected via `MM-BR-025`. `ADR-0018` treatment mirrored |
| **Student Management PRD** (Rank 3, FROZEN) | `E-01` precondition, `SM-2.7` citation at `MM-AC-058`, Directory contract `MM-BR-011` — all verify; PRD-004 unmodified |
| **Authentication PRD** (Rank 3) | §16.2 consumes, never defines, the authorisation model; `MM-NFR-006`/`MM-AC-094` enforce. Consistent |
| **Library Member Directory** | `MM-BR-011` matches PRD-004's own statement of the contract from the other side |
| **EA** (Rank 6, descriptive) | `C-1` V2/V3 self-contradiction still correctly *recorded, not resolved* |

---

## 12. Mechanical Verification

All results reproduced by me; nothing accepted on the correction report's word. Scripts were run via stdin
(`python3 - <<'PY'`); **no file was created in the repository** other than this report.

| # | Check | Method | Result |
|---|---|---|---|
| 1 | Current commit | `git log --oneline -5` | `a60a083` ✅ |
| 2 | Working tree | `git status --porcelain` | clean (before this report) ✅ |
| 3 | Diff vs `9735de1` | `git diff --name-status` | exactly 2 files: 1 M, 1 A ✅ |
| 4 | Frozen/ranked modified? | path-scoped `git diff --name-only` | **empty — none** ✅ |
| 5 | ADRs created? | `git diff` + `ls` at both commits | 19 files both → **none** ✅ |
| 6 | Register counts | regex census | 332 / 320 / 12 = declared ✅ |
| 7 | Register contiguity | per-register gap scan | **0 gaps, 0 duplicates**, all 10 ✅ |
| 8 | Requirements deleted | ID set-difference v1.1→v1.2 | **removed = ∅** ✅ |
| 9 | Requirements weakened | `MUST`/`MUST NOT`/`SHOULD`/`MAY` census | 325→334, 99→102, 2→2, 13→13 ✅ |
| 10 | AC coverage — strict | *Verifies* column only | **69/81 = 85.2%**; 126/223 = 56.5% ❌ vs declared |
| 11 | AC coverage — loose | anywhere in AC row | **77/81 = 95.1%**; 135/223 = 60.5% ❌ vs declared |
| 12 | AC coverage — block-scan | anywhere in §23 incl. prose | **81/81 = 100.0%**; 140/223 = 62.8% = declared ⚠️ artifact |
| 13 | Dangling references | AC-cited IDs vs defined IDs | **0** ✅ |
| 14 | Phantom `MM-FR-119` | `grep -c` | **0 hits** ✅ |
| 15 | `MM-GAP-*` cited as verifiable | AC *Verifies* scan | **0** ✅ |
| 16 | Empty *Verifies* fields | AC row parse | **0 of 97** ✅ |
| 17 | AC row count | table parse | **97** = declared ✅ |
| 18 | `BC-26` in event rows | §12 row scan | **0 occurrences** ✅ |
| 19 | `BC-26` edges in BC Map §7 | `grep` L290–363 | **1 row (`E-26`, from `BC-27`)** — no `BC-02` edge ✅ |
| 20 | `BC-28` edges in BC Map §7 | `grep` L290–363 | **0 rows** → **TR-1** ❌ |
| 21 | `MM-BR-006` edge existence | each of 10 vs BC Map §7 | all 10 exist ✅ |
| 22 | Repo-wide links | relative-link resolver | **582 links, 0 broken** ✅ |
| 23 | Code untouched | `git diff` on `lib`/`test`/`tool` | empty ✅ |
| 24 | `flutter analyze` | CLI | **No issues found! (ran in 2.0s)** ✅ |
| 25 | `PRD-005` registry status | `grep` L225 | **`PLANNED`** — not frozen ✅ |

**Note on check 22.** I measure **582** relative links repo-wide where the correction report states **660**. This is a
counting-scope difference (my resolver excludes anchor-only and non-`docs/` paths), not a contradiction — the material
result, **0 broken**, agrees.

---

## 13. Findings

| ID | Severity | Location | Summary | ADR required? |
|---|---|---|---|---|
| **TR-1** | **HIGH** | `PRD-MEMBERSHIP-MANAGEMENT.md` L1012 vs `MM-BR-035` L1027–1030 and `MM-BR-006` §11.1 | `MM-EVT-006` lists consumer `BC-28`, which is reachable on **no** edge in `MM-BR-006` and has **no edge in BC Map §7 at all**. The new rule is violated by the table it governs; `MM-AC-075` fails as written. Same defect class as `F-1`, left unfixed one column away | **No** (internal). Underlying Rank 4 defect owed by architecture owner |
| **TR-2** | **HIGH** | §0.2 L67–71; §23.1 L1585–1587; §25.3 L1713; correction report L165/209/224 | Declared **81/81 = 100.0%** comparable coverage is reproducible **only** by counting identifiers mentioned anywhere in §23 — including L1589, the prose note stating those four rules are *"intentionally **not** given new criteria"*. Strict measure: **69/81 = 85.2%** (overall 56.5%, not 62.8%) | **No** |
| **TR-3** | **MEDIUM** | §25.3 *Verification coverage* row, L1713 | Asserts *"**Every** `MM-BR-*`, `MM-INV-*`, `MM-XC-*`, `MM-PO-*` and `MM-EVT-*` now carries at least one verifying `MM-AC-*`"* — false for 12 identifiers; appears in the document's own compliance summary | **No** |
| **TR-4** | **LOW** | `MM-AC-024`, `026`, `027`, `040`, `042`, `043`, `049`, `062`, `081` | `MM-EVT-001`…`006`, `MM-PO-003`, `MM-PO-004` are genuinely tested but named only in criterion prose, never in a *Verifies* cell → invisible to traceability tooling | **No** |
| **TR-5** | **MEDIUM** (advisory) | §25.2 `MM-GAP-010` L1699 | The referral is scoped to `BC-26`, but the Rank 4 defect is systemic: §9 names `BC-26` a consumer for **11** producers with 1 inbound edge, and names `BC-28` with **0** edges. Second module PRD to hit it; no general rule has been raised | **Yes — by the architecture owner against the BC Map**, not by `PRD-005` |

**Explicitly NOT findings** (tested and cleared): `F-1` correctness and completeness · `F-3` in all seven respects ·
grouped criteria `MM-AC-093`/`094` · closure-by-document-version (clause 1 of Judgement Call #1) · requirement
deletion/weakening/renumbering · duplicate IDs · register contiguity · declared register totals · dangling and phantom
references · invented edges · ownership violations · scope creep · V1/V2/V3 classification · cross-document
consistency · frozen-document containment · ADR count · code/test integrity.

---

## 14. Severity Classification

| Severity | Definition applied | Findings |
|---|---|---|
| **HIGH** | A normative rule is self-contradicted, or a quantitative compliance claim is not reproducible from the document | **TR-1**, **TR-2** |
| **MEDIUM** | A statement in a compliance/governance section is false or under-scoped, without changing V1 behaviour | **TR-3**, **TR-5** |
| **LOW** | Hygiene; correctness unaffected | **TR-4** |
| **CRITICAL** | Would block progression outright — invented architecture, lost requirement, unauthorised decision | **none** |

**Why no CRITICAL.** No requirement was lost or weakened; no edge invented; no frozen or ranked document touched; no
ADR usurped; no V2/V3 capability smuggled into V1; no ownership violation. Every finding is localised and repairable
inside `PRD-005` without any architectural decision.

**Why not verdict A.** TR-1 leaves a newly added `MUST` rule violated by its own table, and TR-2/TR-3 leave a
quantitative claim in §0.2 and §25.3 that a reviewer cannot reproduce — in a document whose own `MM-NFR-014` forbids
treating unverifiable things as satisfied.

**Why not verdict C or D.** The architecture is sound and unchanged; the `F-1` and `F-3` corrections are correct and
well-reasoned; the substantive AC work is real and non-padded; all governance constraints held. TR-1 is a one-cell or
one-clause edit; TR-2/TR-3 are a re-measurement and a re-wording; TR-4 is nine cell edits; TR-5 is one sentence.
Nothing requires rework of requirements, architecture or design.

---

## 15. Recommended Corrections

Not applied. Listed in priority order. **None requires an ADR from `PRD-005`.**

1. **TR-1 — resolve the `BC-28` inconsistency.** Either **(a)** de-list `BC-28` from `MM-EVT-006` and record the
   `BC-28` §9-vs-§7 tension alongside `BC-26` (strict `F-1` parallel), or **(b)** narrow `MM-BR-035`'s reachability
   clause to **V1** consumers and state that a `(V2)`-annotated consumer asserts no V1 edge. Then re-verify
   `MM-AC-075`.
2. **TR-2 — make the coverage figure true or state the method.** Preferred: move the 8 genuinely-tested identifiers
   into *Verifies* cells (lifting the strict measure to **77/81 = 95.1%** with no new criteria), report the remaining
   four as *covered indirectly*, and define the counting rule in §0.2. Alternative: keep the criteria as-is and
   publish the measured strict figure (**69/81**) with the method named.
3. **TR-3 — correct §25.3.** Replace *"Every … carries at least one verifying `MM-AC-*`"* with the measured statement
   from item 2, naming the indirectly-covered rules.
4. **TR-5 — broaden `MM-GAP-010`.** Name `BC-28` and pose the general question about Published-Language consumption
   versus per-producer §7 edges, so the architecture owner's ADR can settle the class rather than one instance.
5. **TR-4 — traceability hygiene.** Add register IDs to the nine criteria identified; optionally add governing
   requirement IDs beside the 11 section/edge-only *Verifies* citations.
6. *(Optional, not a finding)* Split `MM-AC-094` into three criteria so each row carries one assertion.

**Architecture owner action (outside `PRD-005`):** an ADR against the Bounded Context Map resolving §9-consumer versus
§7-edge coherence for capability contexts — currently carried by `SM-GAP-11` (`BC-01`), `MM-GAP-010` (`BC-02`) and, per
TR-1/TR-5, `BC-28`. `ADR-0016` is the procedural template.

---

## 16. Final Verdict

# **B — MINOR CORRECTIONS REQUIRED**

Only localised corrections are necessary; **architecture and overall design remain sound.**

The correction pass did the hard part correctly. `F-1` is exemplary: it establishes a true fact about the edge
register, declines to resolve a Rank 4 tension it has no authority over, follows a frozen ratified precedent exactly,
invents nothing, and leaves the future path open. `F-3` genuinely eliminates a real contradiction by reformulating it
as an input substitution, and survives every consistency probe I could construct. No requirement was deleted,
weakened or renumbered; no frozen or ranked document was touched; no ADR was created or usurped; no code changed;
the PRD was correctly **not** frozen and **not** registered.

Two claims, however, outrun what the document delivers. `MM-BR-035` is well-drafted and needed — but its own event
table violates its consumer-reachability clause via `BC-28`, the same defect class `F-1` was raised to fix, sitting one
column away in the same table (**TR-1**). And the **100.0%** coverage headline is reachable only by a counting method
that treats a sentence documenting a gap as evidence the gap is closed (**TR-2**), with §25.3 restating it as a
universal that is false for 12 identifiers (**TR-3**).

That matters more than the arithmetic, because this document's own `MM-NFR-014` — *"a rule that cannot be checked
SHALL be treated as unmet, not as satisfied by intent"* — is the standard the correction pass invoked to justify `F-4`
in the first place. The correction report is otherwise unusually candid: it discloses four self-caught defects and
explicitly refuses to pad. Applying that same standard to its own headline number is all that is missing.

**`F-1` Fully Corrected · `F-2` Partially Corrected · `F-3` Fully Corrected · `F-4` Partially Corrected.**
No regression in requirements, architecture, versioning, scope or cross-document consistency. One new regression
(TR-1) introduced by the `F-2` fix.

**Recommendation:** apply the five corrections in §15 — each is a localised edit, none needs an ADR — then a fourth
review can be limited to re-verifying TR-1…TR-5 rather than re-auditing the document.

**`PRD-005` must NOT be frozen and implementation must NOT begin on the strength of this review.**

---

## 17. Evidence / Source References

### 17.1 Bounded Context Map (Rank 4) — verbatim, with line numbers

| Line | Content | Used for |
|---|---|---|
| L292 | *"Every edge that crosses a context boundary in V1. If an edge is not in this table, it **does not exist** and adding it requires an ADR."* | The only ADR trigger; edge-scoped |
| L299 | `E-02 \| BC-02 Membership \| BC-04 Seating` | `F-1` reachability |
| L300 | `E-03 \| BC-02 Membership \| BC-03 Attendance` | `F-1` reachability |
| L304 | `E-07 \| BC-02 Membership \| BC-05 Fee & Collection` — names `MembershipCreated/Renewed/**Upgraded**/Frozen` | `F-1`; `C-3` |
| L307 | `E-10 \| BC-05 \| BC-02` — *"may activate a pending membership"* | `MM-EVT-002` justification |
| L329 | `E-20 \| All contexts \| BC-24 Audit Trail` | `F-1` — *"All contexts"* is the **upstream** column |
| L332 | `E-23 \| All contexts \| BC-22 Notification Delivery` | `F-1` — same |
| L335 | `E-26 \| BC-27 AI \| BC-26 Analytics, BC-23 Search` | **`BC-26`'s only inbound edge** |
| L290–363 | Complete §7, `E-01`…`E-26` | **Zero `BC-28` occurrences** → TR-1 |
| L399 | *"seed of the full Event Catalog … names, producers and consumers are fixed here"* | Judgement Call #1 |
| L409/410/412/413 | §9 rows naming `BC-26` a `BC-02` consumer | `C-8`, `MM-GAP-010` |
| **L411** | `BC-02 \| membership.MembershipExpiringSoon \| BC-22, BC-28` | **TR-1 primary evidence** |
| L426 | *"`SEV-1`…`SEV-16` — closed set, **see Student Identity PRD §4.14**"* | Rank 4 delegates closure to Rank 3 |
| L371 | `BC-02` invariants incl. `validUntil > validFrom` | `MM-INV-002`, `MM-GAP-008` |
| L465 | *"visible reconciliation queue for failures"*; saga = `BC-28` V2 | `MM-BR-004` |
| L135/137/147 | `BC-26` and `BC-28` register rows; `BC-28` = **V2** | Scope/versioning |

### 17.2 Frozen Student Management PRD v1.2 (Rank 3) — the precedent

| Line | Content |
|---|---|
| L808–813 | *"`BC-26` … is therefore **not listed as a consumer here**, and this module emits nothing additional for it. Recorded as **`SM-GAP-11`** for the architecture owner."* |
| L817 | `SM-7.12` — *"This set **MUST** be closed at **ten** events. A new event requires an ADR."* |
| L1177 | `SM-GAP-11` register entry — *"tension is internal to the Bounded Context Map (Rank 4) and is **not** this module's to resolve"* |
| L783–792 | §7.4 event table — 10 events where BC Map §9 lists 4 |

### 17.3 ADRs (Rank 2)

| Source | Content | Used for |
|---|---|---|
| `ADR-0016` header | *"Amends … §7.3, edge `E-22`, the ***Consumer* cell only**"* | Judgement Call #1 clause 2 — amending a §7 consumer list needs an ADR |
| `ADR-0016` §1.1 | *"The rule cuts both ways… **the edge cannot simply be typed in**"* | Same |
| `ADR-0018` | Froze PRD-004 with the `BC-26` refusal and 10-event register intact; §3 declines to decide `SM-GAP-11` | `F-1` precedent; Judgement Call #1 clause 1 |

### 17.4 Governance

`DOCUMENTATION_BASELINE.md` §4 — precedence table (1 Master PRD · 2 ADRs · 3 module PRDs · 4 BC Map · 5 Rulings ·
6 EA *descriptive* · 7 Config) and *"**A conflict is a defect.** If you find one, do not choose — raise it."*
`PRD_REGISTRY.md` L225 — `PRD-005` = **`PLANNED`**. `MASTER_PRD.md` L158 — module 6 = `BC-02` `[CORE]` V1.

### 17.5 PRD-005 v1.2 — key lines

L15 (header *Publishes to*) · L67–71 (§0.2 totals & coverage claim) · L454/457/464–479 (`MM-FR-057`/`058`/`057a`) ·
L921 (§10.2 delayed-payment row) · L943–958 (`MM-BR-006` ten edges) · L1006–1012 (event table; **L1012 = TR-1**) ·
L1027–1030 (`MM-BR-035`) · L1029–1050 (`BC-26` note) · L1080 (corrected reachability sentence) · L1166
(`MM-CFG-009`) · L1200/1211 (`MM-INV-002`/`011`) · L1424 (§21 edge 13) · L1531–1594 (§23.1, **L1589 = TR-2
evidence**) · L1678 (`C-8`) · L1699 (`MM-GAP-010`) · L1713 (§25.3, **TR-3**) · L1731 (v1.2 history row).

---

## 18. Files Changed

**Created — exactly one:**

```
docs/30-product/membership-management/PRD-005_THIRD_INDEPENDENT_REVIEW.md    (this report)
```

**Modified: none.**

Explicitly **not** touched, verified by `git status` and `git diff`:
`PRD-MEMBERSHIP-MANAGEMENT.md` · `PRD-005_F1-F4_CORRECTION_REPORT.md` · `PRD-005_SECOND_INDEPENDENT_REVIEW.md` ·
`MASTER_PRD.md` · `LIBOORA_BOUNDED_CONTEXT_MAP.md` · `LIBOORA_ENTERPRISE_ARCHITECTURE.md` · all ADRs ·
`Student_Management_PRD_v1.md` · `Authentication_PRD_v2.md` · Library PRD and `REVIEW_14A.md` · `PRD_REGISTRY.md` ·
`DOCUMENTATION_BASELINE.md` · `lib/**` · `test/**` · `tool/**` · `pubspec.yaml` · all configuration.

**No defect found in this review was fixed.** No correction was committed or pushed. No script or temporary file was
added to the repository — all verification ran through stdin-piped interpreters.

---

## 19. Document Control

| Field | Value |
|---|---|
| **Document** | `PRD-005_THIRD_INDEPENDENT_REVIEW.md` |
| **Type** | Independent audit report — **advisory, non-normative** |
| **Rank** | None. Creates no requirement and amends no document |
| **Reviewed** | `PRD-MEMBERSHIP-MANAGEMENT.md` v1.2 @ `a60a083` |
| **Verdict** | **B — MINOR CORRECTIONS REQUIRED** |
| **Findings** | 5 — TR-1 (HIGH), TR-2 (HIGH), TR-3 (MEDIUM), TR-4 (LOW), TR-5 (MEDIUM advisory) |
| **ADRs required from `PRD-005`** | **None** |
| **ADRs owed by the architecture owner** | 1 — BC Map §9-consumer vs §7-edge coherence (`SM-GAP-11`, `MM-GAP-010`, `BC-28`) |
| **Freeze recommendation** | **Do not freeze.** Apply §15 items 1–3 at minimum, then re-verify |
| **Status** | **FINAL** — review complete, no further action taken |
