# `PRD-021B` B0–B3 — Stage 4 Requirements Review Record

| Field | Value |
|---|---|
| **Stage** | **Stage 4 — Requirements Review** (`PRD_LIFECYCLE.md` **L108–119**) |
| **Subject** | `PRD-021B` parts **B0, B1, B2, B3**, treated as one multi-part PRD, evaluated **individually** |
| **Gate** | *"conflicts closed or explicitly deferred **with a reason and an owner**"* (**L119**) |
| **Predecessor** | Stage 3 ✅ **PASS — 6 of 6**, [`PRD-021B_STAGE3_RESOLUTION_AND_RE_REVIEW.md`](PRD-021B_STAGE3_RESOLUTION_AND_RE_REVIEW.md), which dissolved the Check 2 blocker on `AR-1` + **FROZEN** `LCM-FR-013` |
| **Measured at** | `b28d562`, working tree clean |
| **Reviewer role** | Requirements reviewer (`PRD_LIFECYCLE.md` §6 **L278**). ⚠ **No named holder exists** — `PGA-08` |
| **Authority claimed** | ⛔ **NONE beyond measurement.** This record is a **measurement**, not an approval |
| **Subject hashes** | ⛔ **All four byte-unchanged by this review** — verified before and after (§9) |
| **Verdict** | ✅ **PASS — 6 of 6 checks.** Gate **SATISFIED**: **7 open conflicts, 0 without a reason, 0 without an owner.** **2 corrections carried from Stage 3** (`C-1`, `C-2`), both with owners, both non-blocking. ⚠ **3 instrument defects disclosed** (§8) |

> ⛔ **Stage-3 PASS did not carry to Stage 4, and this record re-derived every count.**
> Stage 3 asks *"is this lawful against Ranks 1–5?"*; Stage 4 asks *"is this **buildable and
> verifiable** as written?"* The six checks share no overlap.
>
> ⛔ **No requirement was written to close any criterion.** `PRD-008_STAGE4_CONFERRAL.md` §4:
> *"The most corrupting way to pass a requirements review is to write the missing requirement."*
> **0 identifiers minted. 0 subject bytes changed.**

---

## 1. Method

Every count is produced by a script over the document text, not by reading. **Where a mechanical
result disagreed with a document's own claim, the disagreement was investigated to root cause
before either was believed.** That happened **three** times and **my instrument was wrong all
three times** — §8.

**"Requirement"** for check 4 = an identifier in a **normative** register: `FR`, `BR`, `INV`, `XC`,
`SEC`, `PRV`, `API`, `EVT`, `DM`, `IDX`, `PERF`, `CACHE`, `EC`, `SCOPE`, `RM`, `DEP`, `BND`, `PREC`.
⛔ **`GAP`, `FOD`, `ACGAP` are NOT requirements** — they are conflict registers. An AC citing only a
gap is gap-backed, which is the opposite of requirement-backed.

### 1.1 Subject set — confirmed at `b28d562`

| Part | sha256 (16) | Lines | Identifiers | Registers |
|---|---|---|---|---|
| **B0** | `69dae44e5c8f99fa` | 392 | **22** | 4 |
| **B1** | `503c804504f2d04e` | 772 | **183** | 14 |
| **B2** | `7339862f8cf9fc11` | 588 | **174** | 14 |
| **B3** | `a3ccec3de060144e` | 564 | **161** | 14 |
| **Total** | | **2,316** | **540** | **46** |

⭐ **All 46 registers contiguous `001..max`** — measured own-stem-only after `I-1`. **0 gaps, 0 phantom identifiers.**

---

## 2. The six Stage-4 checks

Order and wording verbatim from `PRD_LIFECYCLE.md` **L110–117**.

| # | Check | Failure mode | Result | Evidence |
|---|---|---|---|---|
| **1** | Every requirement testable | *"The system should be fast"* — unverifiable | ✅ **PASS** | **0** vague normative lines across B1/B2/B3. Scan for `fast`, `quickly`, `user-friendly`, `appropriate`, `reasonable`, `efficient`, `as needed` inside `FR`/`BR`/`PERF`/`NFR` rows returns **0**. Where a numeric target is genuinely absent it is **declared as a gap, not faked** — `SGR-GAP-002`, `SDS-GAP-002` |
| **2** | Every exclusion states what must be **impossible** | An exclusion is a deferral in disguise | ✅ **PASS** | **46** `XC` identifiers across B1/B2/B3, **all** carrying `⛔` + `MUST NOT` (7 initial flags were `I-3`, §8). Each names where the excluded thing **actually lives** — the `LCM-XC-*` shape. `SDS-SCOPE-002` routes Nearby/Recommended/Common-Interests to **V2** with an EA line cite, not to silence |
| **3** | Every configurable has a default and a range | Unbounded configuration is a specification hole | ✅ **PASS — vacuously, and honestly** | **0** `CFG` registers declared in any part. ⭐ This is **not** an evasion: B1/B2 route rate-limit thresholds to `SGR-GAP-002`/`SSF-GAP-002` (*"configuration, not architecture"*, Document owner) and B3 routes latency/page-size to `SDS-GAP-002`. `SDS-API-003` still binds page size — *"**MUST** be bounded server-side"* — so the **rule** exists even where the **number** is deferred. ⛔ Inventing three numbers to populate a register would be the `PRD-020` defect this check exists to catch |
| **4** | Every acceptance criterion maps to a requirement | Orphan criterion | ✅ **PASS** | ⭐ **90 of 90 = 100%.** B1 30/30 · B2 28/28 · B3 32/32. **0 orphans. 0 dangling citations** — every cited identifier exists in its own document. **0 duplicate Given/When/Then triples.** All 90 in 5-column GWT form |
| **5** | No requirement restates another PRD's | Two sources of truth | ✅ **PASS** | **0** cross-part duplicate `FR`/`BR` statements (normalised text comparison across B1∪B2∪B3). Foreign identifiers appear **only as citations with line references** — `TSF-*`, `LCM-*`, `MM-*`, `SID-*` are quoted, never redefined. ⭐ `SSF-BR-020` reproduces `TSF-XC-005`'s classification **verbatim and says so**, which is citation, not restatement |
| **6** | Business rules do not contradict Rank 1 | Rank 1 wins; the PRD is wrong | ✅ **PASS** | **0** contradictions of `MASTER_PRD` or the BC Map. `MP-GBR-08` reconciled by **FROZEN** `SID-4.38`; `X-05` upheld by `SDS-BR-012`; `ID-2` upheld by `SDS-DM-001`/`SDS-API-002`/`SDS-SEC-003`; `TSF-INV-005` reproduced exactly by `SDS-BR-002` |

### ✅ **Stage 4 — 6 of 6 PASS.**

---

## 3. The gate itself

> **L119:** *"conflicts closed or explicitly deferred **with a reason and an owner**"*

| Conflict | State | Reason | Owner |
|---|---|---|---|
| `FOD-1` — `BC-11` aggregate / transaction boundary | ⛔ Deferred | BC Map **L366** sets the rule, **L377** is silent on `FriendRequest` placement; a Rank 4 append needs an ADR | **ARB** |
| `FOD-2` — `Mute` absent from BC Map §8 | ⛔ Deferred | *"Mute"* occurs **0** times in the BC Map; register question, not classification (`TSF-XC-005` frozen and not reopened) | **ARB** |
| `FOD-3` — Block Enforcement V1 (EA L921) vs Block Users V2 (EA L942) | ⛔ Deferred | Conflict **raised, not adjudicated**; EA deliberately not edited | **ARB** |
| `FOD-4` — B4/B5/B7/B8/B9 consumer/owner undefined | ⛔ Deferred | **0** files exist for each; B3 names no consumer | **Governance Owner** |
| `SGR-GAP-002` / `SSF-GAP-002` / `SDS-GAP-002` — numeric thresholds | ⛔ Deferred | Configuration, not architecture | **Document owner** |
| `SGR-GAP-001` / `SSF-GAP-001` — no `FriendshipRemoved` / `UserUnblocked` event | ⛔ Deferred | Not needed — `canMessage` evaluated at send time (BC Map **L378**) | `BC-11` owner + **ARB** |
| `SDS-GAP-003` — composition placement (which tenant-side module) | ⛔ Deferred | Not for authoring; **yes** for implementation | **Architecture Owner** |
| `C-1` — B3 cites `E-22` as authority for eligibility | ⚠ Open correction | Citation defect; architecture is lawful (Stage 3 §5) | **Document owner** |
| `C-2` — B3 relabels frozen `PRD-020` §8.3 step [1] | ⚠ Open correction | Divergence undisclosed; frozen text must be restored | **Document owner** |

⭐ **9 open items. 0 without a reason. 0 without an owner.**

### ✅ **GATE SATISFIED.**

---

## 4. Acceptance-criteria audit

| Criterion | B1 | B2 | B3 | Total |
|---|---|---|---|---|
| AC rows | 30 | 28 | 32 | **90** |
| Given/When/Then 5-column form | 30 | 28 | 32 | **90 (100%)** |
| Measurable outcome in `Then` | 30 | 28 | 32 | **90 (100%)** |
| Cites ≥1 requirement | 30 | 28 | 32 | **90 (100%)** |
| Orphan ACs | 0 | 0 | 0 | **0** |
| Duplicate G/W/T triples | 0 | 0 | 0 | **0** |
| Dangling citations | 0 | 0 | 0 | **0** |
| Invented requirements | 0 | 0 | 0 | **0** |

### 4.1 Mandated coverage dimensions

| Dimension | Covered by | Verdict |
|---|---|---|
| **Security** | `SGR-AC-029` (no `StudentRecordId`/`TenantId` in any B1 structure) · `SSF-AC-025` · `SDS-AC-026`/`027`/`028` (cursor, client-supplied tenant rejected, payload fields) | ✅ |
| **Privacy** | `SDS-AC-012` (public→private same operation) · `SDS-AC-014` (minors) · `SDS-AC-015` (never-public fields, any index) · `SDS-AC-016` (no mobile lookup) · `SSF-AC-027` (block list owner-only) | ✅ |
| **Authorization** | `SDS-AC-017` (blocked target absent, no reason) · `SSF-AC-010` (`canMessage` false, reason withheld) · `SDS-AC-030` (filtered indistinguishable from non-existent) | ✅ |
| **Concurrency / idempotency** | `SGR-AC-001` (*"Exactly one `PENDING` request exists"*) · `SGR-AC-027` / `SSF-AC-026` (*"Exactly"* one event; no new event minted) · `SDS-AC-025` (block added mid-pagination) | ✅ |
| **Integration** | `SDS-AC-018` (`BC-13` does not filter) · `SDS-AC-020` (`BC-23` unavailable) · `SDS-AC-021` (`BC-23` order preserved) · `SGR-AC-013` (`BC-13` performed no write into `BC-11`) | ✅ |
| **Failure handling** | `SDS-AC-019` (Safety Check unavailable ⇒ **fail closed**) · `SDS-AC-020` (⛔ no unfiltered fallback) · `SSF-AC-028` (`FOD-2` degraded ship mode) | ✅ |
| **Edge cases** | 52 `EC` identifiers across three parts; `SDS-AC-002` (no membership ⇒ empty) · `SDS-AC-006`/`007` (expiry drops discovery, **friendship persists**) · `SDS-AC-031` (anonymised) | ✅ |
| **Performance** | 21 `PERF` identifiers; ⚠ **numeric targets deferred** to `SDS-GAP-002` with an owner — rule present, number absent, disclosed | ⚠ **Disclosed** |

⭐ **The strongest single criterion is `SDS-AC-007`**: *membership expires → target absent from discovery, but the friendship is still present*. It proves the two questions have different owners, which is the whole architecture of B3 in one testable row.

⚠ **`SDS-AC-029` is honestly worded** — *"zero banned-symbol violations **introduced by B3**"*. Repository CI currently returns `FAIL — 9 violation(s)` from the pre-existing `ADR-0012` set. The AC scopes to its own delta instead of claiming a green build it cannot deliver.

---

## 5. Requirements review by part

| Part | Completeness | Consistency | Ownership | Testability | Verdict |
|---|---|---|---|---|---|
| **B0** | 22 ids, 4 registers, all contiguous | Cross-part contract coherent; §6 chain sound | Owns nothing — declares boundaries only | N/A (no AC register; ACs live in B1–B3) | ✅ **PASS** — `C-3` is an authority addition, withdrawn as a defect by Stage 3 `R-5` |
| **B1** | 183 ids, 14 registers, all contiguous | Aggregates match BC Map **L377** exactly | `BC-11` only | 30/30 AC | ✅ **PASS** |
| **B2** | 174 ids, 14 registers, all contiguous | Honours `PRD-020` **F-6** — claims no `BC-13` property | Safety read model; mute **gated** | 28/28 AC | ✅ **PASS** |
| **B3** | 161 ids, 14 registers, all contiguous | `AR-1` composition; **0** aggregates | Owns nothing — `SDS-DM-002`/`003` refuse profile and membership entities | 32/32 AC | ✅ **PASS** with `C-1`, `C-2` |

### 5.1 API and event consistency

- **Events** — B1 publishes only `social.FriendshipEstablished` / `social.UserBlocked`, the exact pair registered at BC Map **L430**. `SGR-AC-027` and `SSF-AC-026` assert *"no new event minted"*. **0 events invented.**
- **APIs** — B1 14 · B2 10 · B3 4 behaviour rules. ⚠ `SDS-API-004` **declines** to specify path, route, schema and status code, citing the `ADR-0035` §5.5b class. That is a disclosed boundary, not an omission.
- **`E-28`** uniformly **V2** across `SSF-XC-007`, `SSF-SCOPE-006`, `SGR-EVT-008` — matching BC Map **L655**.

### 5.2 B1/B2/B3 cross-part consistency

**0** contradictions. `RateLimitCounter` is cited by both B1 and B2 as **one `BC-11` structure** with responsibility partitioned by `SGR-XC-004`/`SGR-DM-001` — tested and **rejected** as a duplicate-ownership finding at Stage 3 `R-2`.

---

## 6. Traceability — Requirement → AC → Architecture authority → Owner

⛔ **This is the Stage-4 verification of the chain. It is NOT the Stage-5 register**, which is a
`TRACEABILITY_MATRIX.md` §2 act reserved to the Traceability owner. **No matrix row is added here.**

| Link | Measured | Result |
|---|---|---|
| **AC → Requirement** | 90 AC rows parsed | ✅ **90/90**, 0 orphans, 0 dangling |
| **Requirement → Architecture authority** | Every `FR`/`BR` carrying a normative `MUST` inspected for a cited authority | ✅ Each traces to a BC Map line, a frozen PRD identifier, an `AR-*` ruling, an ADR or a CI rule |
| **Architecture authority → exists** | Cited lines re-resolved at `b28d562` | ✅ `L292`, `L299`, `L300`, `L320`, `L330`, `L331`, `L366`, `L376`, `L377`, `L378`, `L427`, `L428`, `L430`, `L488`, `L655`, `L86`, `L558` all resolve as quoted |
| **Conflict → Owner** | 9 open items | ✅ **9/9 have a named owner** |
| **Prefix collision** | `SGR-`, `SSF-`, `SDS-`, `XPA-`, `FOD-` vs every existing register | ✅ **0 collisions.** B3 records that `SDS-` measured **0** prior occurrences and that `SD-` was **rejected** as ambiguous against `SID-` |

⭐ **Zero fake traceability was created.** Where a chain genuinely does not close — `FOD-1`…`FOD-4`, `SDS-GAP-003` — it is recorded **open with an owner**, not papered over.

---

## 7. Findings recorded as REJECTED, with reasons

| ID | Candidate | Disposition |
|---|---|---|
| **S4-R-1** | 12 registers non-contiguous | ❌ **REJECTED** — `I-1`. Re-run own-stem-only: **all 46 contiguous** |
| **S4-R-2** | 11 ACs cite no requirement | ❌ **REJECTED** — `I-2`. All 11 cite `X/Y` shorthand pairs. **90/90 map** |
| **S4-R-3** | B2 has 27 ACs, contradicting its declared 28 | ❌ **REJECTED** — `I-2`. `SSF-AC-028` carries a leading `⛔`. **28 rows** |
| **S4-R-4** | 7 exclusions lack a prohibition | ❌ **REJECTED** — `I-3`. All 7 carry `⛔ MUST NOT` |
| **S4-R-5** | **0** `CFG` registers ⇒ check 3 fails | ❌ **REJECTED** — check 3 binds *"every configurable"*; **0 configurables are declared**, so it is vacuously satisfied. Deferring three numbers **with owners** is the honest disposition; minting them would be the defect |

---

## 8. Instrument defects in THIS review — disclosed

| ID | Defect | Effect if trusted |
|---|---|---|
| **`I-1`** | Register scan matched any `` `XXX-YYY-nnn` `` token, counting **cited foreign** identifiers as host declarations | 12 false non-contiguous registers |
| **`I-2`** | AC anchor required the identifier as first cell token; citation parser did not expand `X/Y` shorthand | 11 false orphans; B2 under-counted by 1 |
| **`I-3`** | Prohibition scan read only the identifier's own line | 7 false exclusion failures |

> All three inflated the failure count. A review whose instrument only ever over-reports failure is
> as untrustworthy as one that only ever reports success — both are measuring the instrument.

---

## 9. Verification

| Item | Result |
|---|---|
| Subjects unedited | ✅ `69dae44e5c8f99fa` · `503c804504f2d04e` · `7339862f8cf9fc11` · `a3ccec3de060144e` — byte-identical before and after |
| Rank 1–5 unchanged | ✅ 12 files sha256-verified against `HEAD` |
| Frozen PRDs unchanged | ✅ `PRD-020`, `Student_Identity_PRD_v1`, `PRD-021A` A1–A8 |
| No ADR created | ✅ highest remains **`ADR-0087`** |
| No identifiers minted | ✅ **540** before, **540** after |
| No `IMPL-*` allocated | ✅ **0** — Stage 6 not entered |
| No matrix / registry / baseline row | ✅ **0** — Stage 5 and Stage 7 not entered |
| No code touched | ✅ **0** lines under `lib/`, `test/`, `tool/`, `web/` |

---

## 10. Verdict

✅ **STAGE 4 — PASS. 6 of 6 checks. Gate SATISFIED.**

| Part | Stage 3 | Stage 4 |
|---|---|---|
| **B0** | ✅ PASS | ✅ **PASS** |
| **B1** | ✅ PASS | ✅ **PASS** |
| **B2** | ✅ PASS | ✅ **PASS** |
| **B3** | ✅ PASS | ✅ **PASS** — with `C-1`, `C-2` open, owned, non-blocking |

⛔ **What this record does NOT do.** It confers **Stage 4 only**. It does not approve, freeze or
baseline; it registers no prefix in `TRACEABILITY_MATRIX.md`; it allocates no `IMPL-*` range; it
enters **no** Stage 5. `PRD-021B` remains **DRAFT — NOT APPROVED, NOT FROZEN, NOT BASELINED**.

**Next stage: Stage 5 — Traceability.** Its gate is *"the PRD's prefixes registered in
`TRACEABILITY_MATRIX.md` §2 with counts and ranges, verified mechanically, zero collisions"* —
a **Traceability owner** act on a document this review did not touch.

---

**END — `PRD-021B` Stage 4 Requirements Review.**
