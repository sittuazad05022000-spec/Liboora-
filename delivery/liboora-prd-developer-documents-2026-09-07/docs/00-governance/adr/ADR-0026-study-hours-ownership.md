# ADR-0026 — Study Hours is owned by `BC-26` in a Rank 3 document, and this ADR does not move it

| Field | Value |
|---|---|
| **Status** | **Proposed** — not binding. *(`ADR-INDEX.md` status vocabulary: "Under consideration; not binding")* |
| **Date** | 2026-08-05 |
| **Deciders** | **Architecture owner (ARB)** — ownership and bounded-context authority · **Product owner** — `PRD-009` sequencing versus deferral, and whether Study Hours ships in V1 |
| **Supersedes** | Nothing |
| **Amends** | **Nothing.** `Student_Identity_PRD_v1.md` (**Rank 3**) is byte-identical. `PRD-006` is byte-identical. No baseline changes |
| **Baseline** | **None issued.** Baseline remains **`BASELINE-2026-08-04-E`** |
| **Closes** | **Nothing.** It does not close `ATT-GAP-003` / `MM-GAP-010` |
| **Related** | `Student_Identity_PRD_v1.md` **L470, L474, L477 (`SID-2.38`), L592** (**Rank 3**) · `DOCUMENTATION_BASELINE.md` L155, **L286** · `PRD_REGISTRY.md` **L239** · `PRD_LIFECYCLE.md` Stage 1 (L60-78) · BC Map **L135** (`BC-26`), §7 L292, §9 L402-417 · `ATT-FR-146` (L1578) · `ATT-FR-137` · §2.2 `NG-6` · `ATT-GAP-003` · `ADR-0013` · `ADR-0017` · `ADR-0024` |

> ⚠️ **`Proposed`. This ADR records an ownership fact and declines to overturn it.**
>
> The Product Owner's instruction is explicit and is followed exactly: *"**DO NOT** silently move ownership into
> PRD-006"* and *"**DO NOT invent PRD-009**."*

---

## 0. Product Owner decision recorded — Option 3 in shape, with the ARB's semantic finding **deliberately left open**

> **This section records a Product Owner answer. It does not change this ADR's status.** This ADR remains
> **`Proposed`**, and §5's first action — the ARB's ownership finding — remains **unperformed**.

| PO decision | Question asked | Answer as given |
|---|---|---|
| **`D-11`** | D2 — who owns Study Hours? | **C** — Attendance owns *"How long did this verified presence session last?"*; Analytics owns Study Hours totals · weekly/monthly aggregation · streaks · analytics views. *"Do NOT transfer the entire Study Hours domain to Attendance. Do NOT invent PRD-009. If ARB must rule whether session duration is an operational fact, **record that as the remaining ARB decision rather than pretending it is resolved.**"* |

**`D-11` selects the *shape* of Option 3 and nothing more.** The split it describes — per-session duration in
Attendance, totals and aggregation in Analytics — is Option 3's split, stated in the Product Owner's own words. Three
things follow, and only three:

1. **Option 2 is eliminated.** The entire Study Hours domain is **not** transferred to Attendance. `BC-26`'s ownership of totals, weekly/monthly aggregation, streaks and analytics views stands, and `Student_Identity_PRD_v1.md` (**Rank 3**) is untouched and byte-identical.
2. **Option 1 is eliminated as a V1 route, and `PRD-009` is prohibited.** *"Do NOT invent PRD-009."* This ADR created none and creates none.
3. **Option 4 is eliminated.** Study Hours/session-duration is V1 scope (see also `D-16` on `ADR-0024`).

### 0.1 ⛔ REMAINING ARB DECISION — preserved open at the Product Owner's explicit instruction

> **The Product Owner did not resolve, and expressly declined to have anyone pretend to resolve, the semantic
> question this ADR was written to frame.** The instruction is quoted above and is honoured literally: *"If ARB must
> rule whether session duration is an operational fact, **record that as the remaining ARB decision rather than
> pretending it is resolved.**"*

**The open question, unchanged from §4 Option 3 and §5 action 1:**

> **Is a verified presence session's elapsed duration an *operational fact* of the class `ATT-FR-145` (L1576) already
> permits `BC-03` to expose — or is it the beginning of the Study Hours metric that `Student_Identity_PRD_v1.md`
> L474 grants `BC-26`?** If the former, state **in words** where "operational session duration" ends and "the Study
> Hours metric" begins, so the boundary is not re-litigated.

**Only the Architecture Owner (ARB) may answer this.** `PRD_OWNERSHIP_MODEL.md` §5: *"Only the Architecture Owner
approves"*. It is carried as a numbered remaining decision in
[`PRD-006_PO_DECISION_RESOLUTION_RECORD.md`](../../30-product/attendance-management/PRD-006_PO_DECISION_RESOLUTION_RECORD.md) §5.

**What was done in `PRD-006` while it stays open, and what was deliberately *not* done.** `PRD-006` §10A.6 states the
product rule (a session's duration belongs to the session; totals and aggregation do not) and carries its own
⛔ REMAINING ARB DECISION block. **`ATT-FR-145` was deliberately left unamended** — its permitted-fact list gained
nothing. That is the whole point: extending it to name session duration **would be** the ARB's finding, made by
whoever typed the edit. So the field is not added, and the ARB's ruling is not pre-empted.

**A consequence stated plainly.** Because `ATT-FR-145` is unamended, a `PRD-006` implemented today would hold a
verified session's duration as an internal operational fact and would **not** be cleared to expose it as a read.
That is a real limitation of leaving the question open, and it is disclosed rather than engineered around.

---

## 1. The measured fact

Repository-wide measurement, run on the current working tree:

```
$ grep -rn -i "study hour" docs/
docs/30-product/student-identity/Student_Identity_PRD_v1.md:474
docs/30-product/student-identity/Student_Identity_PRD_v1.md:592
docs/30-product/student-identity/Student_Identity_PRD_v1.md:596

$ grep -c -i "study hour" docs/30-product/attendance-management/PRD-006_ATTENDANCE-MANAGEMENT.md
0
```

**Three hits in the entire repository, all in one file. Zero in `PRD-006`.**

The governing lines, verbatim:

```
L470  | Attendance      | percentage · present days · summary                       | BC-03  |
L474  | Study Analytics | study hours · streak · reading statistics · productivity  | BC-26  |
L592  daily / weekly / monthly study hours
```

L470 is decisive **by contrast**: the same table that grants `BC-03` *"percentage · present days · summary"* grants
**Study Analytics — explicitly including "study hours" — to `BC-26`**. The split is deliberate and adjacent, not an
omission.

`Student_Identity_PRD_v1.md` is **Rank 3, Authoritative** (`DOCUMENTATION_BASELINE.md` L155). `DOCUMENTATION_BASELINE.md`
**L286**: *"A change to any Rank 1–5 document requires an ADR **before** the change."*

By contrast `PRD-006` holds **zero** baseline rank rows and `PRD_REGISTRY.md` L236 records it as `PLANNED`. A lower-
standing document cannot absorb a capability assigned by a higher-ranked one. `PRD_LIFECYCLE.md` Stage 1 states the
rule directly: *"Does another PRD already own the context? It is an amendment to that PRD, not a new one."*

## 2. The complication the Product Owner already identified

`BC-26`'s PRD does not exist.

| Fact | Evidence |
|---|---|
| `PRD-009` Analytics & Reports is assigned to `BC-26`, V1 | `PRD_REGISTRY.md` **L239** |
| Its status is `PLANNED` | `PRD_REGISTRY.md` L239 |
| No directory exists for it | `ls docs/30-product/` — no analytics directory |

So Study Hours has an owner, and that owner has no document. **There is currently no correct file in the repository in
which to specify Study Hours.** Per the instruction, this ADR does **not** create one.

A second, independent obstacle compounds it. Even if a Study Hours read model were authorised, it has **no authorised
delivery path**:

- BC Map §9 names `BC-26` as a **consumer** of attendance events.
- BC Map §7 (L292) declares **no** `BC-03` → `BC-26` edge, and *"if an edge is not in this table, it **does not exist** and adding it requires an ADR."*
- `ATT-FR-137` forbids `BC-03` from depending on `BC-26` consuming anything.

This is the pre-existing registered gap `ATT-GAP-003` (= `MM-GAP-010`). **It is not created by this feature**, but it
must be resolved before Study Hours can reach any dashboard.

## 3. The question

**Which bounded context is authoritative for Study Hours, and where is it specified, given that `BC-26` owns it and
`BC-26` has no PRD?**

## 4. Alternatives

### Option 1 — `BC-26` remains the owner; `BC-03` publishes presence facts only

`BC-03` owns the Presence Session (per `ADR-0024`) and publishes session start/end. `BC-26` derives Study Hours as a
projection.

- **For:** honours L474 with no Rank 3 amendment. Consistent with `ATT-FR-146` (L1578) — attendance *"MUST NOT own analytics … MUST NOT define a metric, compute a certified figure, build a read model"* — and with §2.2 `NG-6`. Consistent with `SID-2.38`'s read-only-composition precedent.
- **Against:** requires a `BC-03` → `BC-26` edge (BC Map §7, **Rank 4**, ADR-gated) and requires `PRD-009` to exist before Study Hours can be specified. **Blocks V1 delivery until `PRD-009` is sequenced.**
- **Cost:** BC Map §7 + §9 (**Rank 4**) · `PRD_REGISTRY.md` sequencing · new `PRD-009`.

### Option 2 — Architecture Owner formally reassigns Study Hours to `BC-03`

- **For:** unblocks V1 immediately; the duration is computed where the session lives, so no cross-context edge is needed for the core value.
- **Against:** amends **Rank 3** `Student_Identity_PRD_v1.md` L474 (ADR-first, `DOCUMENTATION_BASELINE.md` L286). Contradicts `ATT-FR-146`, §2.2 `NG-6` and `ATT-FR-147`, all of which must then be amended in `PRD-006` too. Sets a precedent that analytics ownership follows whoever produces the raw data, which `ADR-0013` deliberately resisted for capability contexts.
- **Cost:** `Student_Identity_PRD_v1.md` (**Rank 3**) · `PRD-006` (`ATT-FR-146`, `NG-6`, `ATT-FR-147`) · `DOCUMENTATION_BASELINE.md` rank/baseline rows.

### Option 3 — Split: `BC-03` owns *session duration*, `BC-26` owns *Study Hours analytics*

`BC-03` records each session's authoritative start, end and elapsed duration as **operational fact**. `BC-26` remains
the sole owner of aggregated Study Hours metrics (daily/weekly/monthly, streaks, certified figures).

- **For:** `ATT-FR-145` (L1576) **already permits** `BC-03` to expose operational facts — *"students currently inside · check-ins today · check-outs today · attendance by mode · failed attempts"* — provided `ATT-FR-147` labels them operational reads. A per-session elapsed duration is arguably the same class of fact. This may require **no Rank 3 amendment at all**, because L474 grants `BC-26` *"study hours"* as **analytics**, not as raw interval arithmetic.
- **Against:** the boundary between "operational duration" and "the metric Study Hours" must be drawn **explicitly in words**, or it will be re-litigated. The Architecture Owner must state where it falls. This ADR must not draw it.
- **Cost:** potentially `PRD-006` only (extend `ATT-FR-145`'s permitted fact list). Possibly zero Rank 3 change. **This is the cheapest option if the semantic finding supports it — and that finding is the ARB's to make, not this ADR's.**

### Option 4 — Defer Study Hours out of V1

Ship Wi-Fi Presence and automatic attendance in V1; defer Study Hours until `PRD-009` exists.

- **For:** removes the hardest conflict from the V1 critical path; `ADR-0024` and `ADR-0025` can proceed independently.
- **Against:** **contradicts the Product Owner's decision that Study Hours is required for V1.** Offered only because `PRD_LIFECYCLE.md` Stage 1 requires the V1/V2/V3/Future question to be answered explicitly, and because the Product Owner is entitled to revise scope in light of the `PRD-009` finding.
- **Cost:** none structurally; a scope decision only.

## 5. Decision

**None. Deferred.** Two owners must act, in this order:

1. **Architecture owner (ARB)** — which of Options 1–3 describes the correct ownership model? If Option 3, state **in words** where "operational session duration" ends and "the Study Hours metric" begins.
2. **Product owner** — if the chosen option requires `PRD-009` to exist first (Option 1), is `PRD-009` sequenced now, or is Study Hours deferred (Option 4)? V1 scope is the Product Owner's to confirm.

## 6. Requirements that are already settled and need no decision

Recorded so the eventual specification does not re-open them:

| Requirement | Source | Status |
|---|---|---|
| Study Hours **MUST NOT** be app-open time | request §4 | ✅ uncontested; no existing rule conflicts |
| Study Hours **MUST NOT** be "attendance timestamp → now" | request §4 | ✅ uncontested; `ATT-BR-030` already forbids the analogous fabrication |
| Duration derives from authoritative session timestamps | request §4, §14 | ✅ `ATT-FR-088` (L1055) already mandates the platform time port |
| Counting stops when the student is not in a validated session | request §4 | ✅ principle uncontested; the *mechanism* depends on `ADR-0024` and `ADR-0028` |
| No continuous polling to accumulate hours | request §14 | ✅ `ATT-NFR-007` and `ATT-FR-088` already align |
| Attendance, Presence and Study Hours stay three distinct concepts | request §16 | ✅ consistent with `ATT-FR-146` and this ADR's own reasoning |

## 7. Consequences

- **Option 1:** correct by the book, **slowest**; V1 Study Hours waits on `PRD-009`.
- **Option 2:** fastest, **most expensive in governance**; amends a Rank 3 document and four `PRD-006` rules.
- **Option 3:** potentially **cheapest**; depends entirely on a semantic finding only the ARB may make.
- **Option 4:** removes the conflict; contradicts the current V1 scope decision.
- **Left `Proposed`:** Study Hours cannot be specified in any document. Presence and attendance work (`ADR-0024`, `ADR-0025`) is **not blocked** by this ADR and can proceed in parallel.

## 8. What this ADR explicitly does not do

- It does **not** move Study Hours ownership into `PRD-006`.
- It does **not** amend `Student_Identity_PRD_v1.md`, or any other document.
- It does **not** create, name, sequence or draft `PRD-009`.
- It does **not** create a `BC-03` → `BC-26` edge, or close `ATT-GAP-003`.
- It does **not** decide whether session duration is an operational fact — that is Option 3's open finding, and §0.1 keeps it open **by instruction** rather than by omission.
- It does **not** assert approval by any person or body.
- It does **not** treat `D-11` as the ARB finding §5 action 1 requires. `D-11` chose a shape; the ARB must still rule on the semantics and draw the boundary in words.
- It does **not** extend `ATT-FR-145`'s permitted-fact list, because doing so *would be* the ruling it is not entitled to make.
- It does **not** create, name, sequence or draft `PRD-009` — `D-11` prohibits it, and none exists.
- It does **not** become `Accepted` by virtue of §0. Its status is unchanged: **`Proposed`**.
