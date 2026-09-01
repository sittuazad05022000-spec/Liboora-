# PRD-021B — Parts B4 / B5 / B6 — Cross-Part Architecture Consistency Audit

```
┌──────────────────────────────────────────────────────────────────────────┐
│ DOCUMENT       PRD-021B_B4_B5_B6_CROSS_PART_AUDIT                        │
│ VERSION        v0.1                                                      │
│ DATE           2026-09-02                                                │
│ STATUS         AUDIT RECORD — Stage 2 (Draft) self-check                  │
│ SUBJECTS       PRD-021B Part B4 (DRK) · Part B5 (PYK) · Part B6 (GLS)     │
│ VERDICT        See §12                                                    │
│                                                                          │
│ ⛔ WHAT THIS DOCUMENT IS NOT                                              │
│    - It is NOT a Stage 3 architecture alignment record.                   │
│    - It is NOT a Stage 4 requirements review.                             │
│    - It confers NO lifecycle stage. B4/B5/B6 remain DRAFT / STAGE 2.      │
│    - It resolves NO open decision and creates NO ADR.                     │
│    - It amends no FROZEN PRD and no Rank 1-5 artefact.                    │
│                                                                          │
│ ⭐ It is the cross-part consistency check the authoring task required,     │
│    executed by MEASUREMENT against the repository, and it reports the     │
│    defects it found in its own subjects as well as the passes.            │
└──────────────────────────────────────────────────────────────────────────┘
```

> **Method.** Every row below is backed by a command run against this working
> tree, not by recollection. Where a check produced a **finding against my own
> draft**, the finding is recorded and the remediation is stated. Where the
> repository and the supplied task assumptions disagree, the conflict is carried
> **OPEN** to a named owner — ⛔ never silently resolved.

---

## 1. Subjects and measured size

| Part | File | Stem | Registers | Identifiers | Non-contiguous | GWT ACs | Orphan ACs |
|---|---|---|---|---|---|---|---|
| **B4** | `PRD-021B_B4_DISCOVERY_RANKING_DRAFT_v0.1.md` | `DRK-` | 14 | **133** | **0** | 26 | **0** |
| **B5** | `PRD-021B_B5_STUDENT_RECOMMENDATIONS_DRAFT_v0.1.md` | `PYK-` | 16 | **135** | **0** | 24 | **0** |
| **B6** | `PRD-021B_B6_DISCOVERY_SCOPE_DRAFT_v0.1.md` | `GLS-` | 12 | **100** | **0** | 20 | **0** |
| | | | **42** | **368** | **0** | **70** | **0** |

⚠ **Stem collision check (measured).** Before authoring, `DRK-`, `PYK-` and
`GLS-` each returned **0 occurrences** repository-wide. No existing identifier
namespace is shadowed.

---

## 2. Chain 1 — `B3 candidate generation → B4 ranking → B5 recommendations`

| Link | Contract | Direction | Measured evidence | Verdict |
|---|---|---|---|---|
| B3 → B4 | B4 consumes B3's already-filtered candidate list; `SDS-FR-017` is the read contract | ▶ one-way | B4 cites 17 distinct `SDS-*`/`SGR-*` identifiers; defines **0** of them | ✅ |
| B3 → B4 | B4 may not widen the set | ▶ | `DRK-XC-007` — output **MUST** be a *permutation* of input: "same multiset in, same multiset out" | ✅ |
| B3 → B4 | B4 may not re-derive eligibility | ▶ | `DRK-XC-008` — ⛔ impossible to invoke B4 before step [3] | ✅ |
| B4 → B5 | B5 delegates ordering, never scores | ▶ | B5 §B5.3 row *"Ordering / scoring \| **B4** \| `DRK-FR-005` \| ▶ Delegates; ⛔ never scores"* | ✅ |
| B5 → B3 | B5 consumes B3 eligibility, never re-derives | ▶ | B5 §B5.3 row *"▶ Consumes; ⛔ never re-derives"* | ✅ |
| ⟲ | No cycle B5 → B4 → B3 → B5 | — | No `SDS-*` or `DRK-*` identifier is **defined** in B5; citation only | ✅ **acyclic** |

**Chain 1 verdict: ✅ CONSISTENT, ACYCLIC, ONE-WAY.**

---

## 3. Chain 2 — `B6 scope → B3 / B4 / B5`

| Link | Measured evidence | Verdict |
|---|---|---|
| B6 → B3 | B3 candidate composition runs **inside** a resolved scope; `GLS-FR-002` is the resolution contract | ✅ |
| B6 → B4 | `GLS-*` cited in B4; B4 defines none. B4 orders **within** scope, never across it | ✅ |
| B6 → B5 | B5 §B5.3 row *"Scope … \| **B6** \| `GLS-FR-002` \| ▶ Obeys; ⛔ never sets"* | ✅ |
| B6 ← client | `GLS-SEC-001` — ⛔ **IMPOSSIBLE** for a client to supply, widen or override scope | ✅ |
| B6 ordering | Scope resolution precedes the pipeline; ordering is step **[5]** | ✅ |

**Chain 2 verdict: ✅ CONSISTENT. Scope is an upstream precondition, not a parameter.**

---

## 4. Consumption of B2 safety · BC-10 privacy · Library Membership · B1 signals

| Consumed authority | Consumed by | Mechanism | ⛔ Not duplicated because | Verdict |
|---|---|---|---|---|
| **B2 / `BC-13`** safety | B4, B5 | Hard filter at pipeline step **[3]** | `DRK-XC-011` — ⛔ impossible for enforcement state to act as a *soft ranking penalty* (would breach `TSF-FR-024` indistinguishability) | ✅ |
| **`BC-10`** privacy | B4, B5, B6 | Projection read at step **[2]** | `DRK-PRV-*` / `PYK-PRV-*` read only; **0** privacy rules authored | ✅ |
| **Library Membership / `BC-02`** | B5, B6 | `MembershipValidity` via **`E-02`** (existing edge, `MM-BR-006` allowlist) | Membership *predicate* consumed; ⛔ no membership rule restated | ✅ |
| **B1 / `BC-11`** relationships | B4, B5 | `SGR-FR-025` mutual **count**; `SGR-FR-020` friend state | ⚠ See §7 finding on traversal vs count | ✅ with disclosure |

---

## 5. The twelve required verifications

| # | Verification | Method | Result |
|---|---|---|---|
| 1 | **No duplicate ownership** | Per-file stem-definition census across B0–B6 | ✅ **PASS.** Each of `DRK`/`PYK`/`GLS` is defined in exactly one file. B4/B5/B6 contain **0** definitions of `SGR-`, `SSF-`, `SDS-`, `XPA-`, `FOD-` — citation only |
| 2 | **No unauthorized edges** | Extracted every `E-nn` cited; matched against BC Map edge table | ✅ **PASS.** 7 edges cited — `E-02`, `E-19`, `E-20`, `E-21`, `E-22`, `E-23`, `E-26` — each returns **exactly 1** row. **0** new edges (rule **L292**) |
| 3 | **No invented BCs** | Extracted every `BC-nn`; matched against BC Map catalogue | ⚠ **PASS AFTER FIX** — see §6 finding **F-1**. All 15 substantive BCs verified present. Count remains **31** |
| 4 | **No invented events** | Searched for new `social.*` / event mints | ✅ **PASS.** **0** events minted. `BC-11`'s surface stays closed at **two** (BC Map **L430**) |
| 5 | **No invented data sources** | Signal-by-signal and source-by-source verification | ✅ **PASS.** B4 **refused 4 of 10** signals and deferred 1; B5 **refused 4 of 7** sources and marked 1 PARTIAL. **8 refusals, 0 inventions** — see §7 |
| 6 | **No cross-library leakage** | Traced tenant boundary rules | ✅ **PASS.** `GLS-INV-002` — ⛔ impossible for `tenantId`/`StudentRecordId` to enter the `BC-11`..`BC-17` band. Enforced by CI `banned_symbols`, i.e. a **build failure** |
| 7 | **No global leakage into V1** | Scope enum + config rejection semantics | ✅ **PASS.** `GLS-FR-003` — `GLOBAL`/`LOCAL`/`NEARBY` **rejected**, ⛔ never silently downgraded. `GLS-BR-005` — rejected **at load**, not accepted-and-ignored |
| 8 | **No ranking before eligibility/privacy/safety** | Pipeline position audit | ✅ **PASS.** Ordering is step **[5]**, after [1] eligibility, [2] privacy, [3] safety, [4] relevance. `DRK-XC-008` makes earlier invocation impossible |
| 9 | **No recommendation bypass** | B5 policy register | ✅ **PASS.** `PYK-POL-001`/`002` reproduce **FROZEN** `TSF-INV-005` — *"A ranking or recommendation path that reaches the index without step 3 is a defect"* |
| 10 | **No client-controlled scope** | Client-input rules | ✅ **PASS.** `GLS-SEC-001`, `GLS-BR-006`, plus ACs `GLS-AC-002`/`003` asserting rejection without downgrade |
| 11 | **No forbidden cache behaviour** | Cache-rule census | ✅ **PASS.** B4 holds **no** cache of record; `PYK-XC-018` forbids shared/cross-viewer caches and mandates invalidation on privacy/safety change; `GLS-SEC-005` forbids cross-viewer scope caching |
| 12 | **No CI architecture violation** | Read `tool/module_dependencies.yaml` L250–270 | ✅ **PASS.** ⛔ **0 bytes changed** in any `tool/` file. No draft requires `domain/library/**`, `domain/person/**` or `app/**`; no draft introduces a banned symbol |

---

## 6. ⚠ Findings against my own drafts

### F-1 — `BC-11→17` was rendered as an integration edge (FIXED)

| Field | Value |
|---|---|
| **Severity** | ⚠ Material — it read as an unauthorized edge to a V3 context |
| **What I wrote** | B6 stated the tension as `BC-11`→`BC-17`, in 3 places |
| **What the repository says** | BC Map **L488** uses `BC-11→17 Student Network` as a **residency-band RANGE label** in the tenancy table. Separately, **L121** shows `BC-17` is **Marketplace**, `[SUPPORTING]`, **V3** |
| **Why it mattered** | Under rule **L292** (*"If an edge is not in this table, it does not exist"*), an arrow notation between two BC numbers reads as an edge claim. There is **no** `BC-11 → BC-17` edge, and B6 never intended one |
| **Remediation applied** | All 3 sites rewritten to the unambiguous band form `BC-11`..`BC-17`, with an explicit parenthetical: *"⚠ 'BC-11→17' in the BC Map is a RANGE label for that band, NOT an integration edge; B6 cites no edge to BC-17 Marketplace, which is V3."* |
| **Re-measured after fix** | `0` occurrences of the arrow form remain. Register counts **unchanged** (100 GLS ids, 0 non-contiguous) |

### F-2 — my first contiguity script mis-detected the stem (method defect, no document impact)

A stem-autodetect script reported B5 as `registers=7 non_contiguous=6` and B6 as
`registers=0`. Cause: B5 and B6 legitimately **cite** `DRK-*`, so autodetect
selected `DRK` instead of `PYK`/`GLS`. Re-run with the stem bound by filename:
**B4 133 / B5 135 / B6 100, all contiguous, 0 defects.** ⚠ Recorded because the
first output was wrong and a reader comparing runs would otherwise see a
contradiction.

---

## 7. Signal and candidate-source discipline — 8 refusals, 0 inventions

### 7.1 B4 ranking signals (§B4.5)

| Signal | Status | Measured basis |
|---|---|---|
| `DRK-SIG-001` `BC-23` relevance | ✅ ACTIVE 0.60 | BC Map **L132** |
| `DRK-SIG-002` mutual-connection count | ✅ ACTIVE 0.25 | B1 `SGR-FR-025` |
| `DRK-SIG-003` same-library membership | ✅ weight **0.00** | ⚠ Mathematically **constant** in V1 (all candidates are same-library) — carried at zero and disclosed, per A3 `LCR-RS-009` precedent |
| `DRK-SIG-004` profile completeness | ✅ ACTIVE 0.15 | BC Map **L425** |
| `DRK-SIG-005` account freshness | ⚠ **DEFERRED** | `BC-11` is **absent** from the `PersonIdentityCreated` consumer cell (BC Map **L424**) → `DRK-GAP-002` |
| `DRK-SIG-006` pending-request state | ✅ suppression only | ⛔ not a boost |
| `DRK-SIG-007` co-presence / attendance | ⛔ **REFUSED** | **0** edges `BC-03`/`BC-04` → `BC-11`; `X-05` Separate Ways → `DRK-GAP-003` |
| `DRK-SIG-008` common interests | ⛔ **REFUSED** | EA **L931** = V2 |
| `DRK-SIG-009` proximity | ⛔ **REFUSED** | EA **L929** = V2 |
| `DRK-SIG-010` behavioural / impressions | ⛔ **REFUSED** | **0** impression store measured; A3 `D-3` defers the same → `DRK-GAP-004` |

### 7.2 B5 candidate sources (§B5.4)

| Source | Status | Measured basis |
|---|---|---|
| `PYK-SRC-001` same-library members | ✅ **AUTHORISED** | `E-02`, `MM-BR-006`. ⭐ The **only fully authorised generative source** |
| `PYK-SRC-002` friends-of-friends | ⚠ **PARTIAL** | B1 `SGR-FR-025` authorises a mutual **count for an already-identified pair**. A **traversal that produces new candidates** is a different operation → `PYK-GAP-003` |
| `PYK-SRC-003` pending/historical requests | ✅ suppression only | ⛔ not generative |
| `PYK-SRC-004` common interests | ⛔ **REFUSED** | V2 |
| `PYK-SRC-005` same study hall | ⛔ **REFUSED** | **0** edges; `X-05` → `PYK-GAP-004` |
| `PYK-SRC-006` nearby | ⛔ **REFUSED** | V2 |
| `PYK-SRC-007` contact-book import | ⛔ **REFUSED** | **0** occurrences repository-wide |

⭐ **Consequence stated plainly:** because `PYK-SRC-002` is only PARTIAL, B5's V1
generative capability rests on **one** authorised source. That is a genuine
narrowness, disclosed rather than padded with invented signals.

---

## 8. Open conflicts carried forward — ⛔ none resolved here

| ID | Conflict | Authoritative source | Already resolved? | Owner | Blocks authoring? | Blocks implementation? |
|---|---|---|---|---|---|---|
| **`XPB-CONF-001`** | Task says B4 owns *ranking*; repository assigns ranking to **`BC-23`** | **FROZEN** `PRD-020` §8.3 step [4]; B0 §2 row 8; B3 `SDS-XC-007` | ⚠ The **pattern** is (A3 `LCR-XC-004` + `AR-3`); the **assignment** is not | **ARB** | ⛔ No | ✅ **YES** |
| **`XPB-CONF-002`** | Task says B5 is **V1**; repository says **V2/V3**, unanimously | EA **L930** (V2), EA **L943** (V3), B3 `SDS-BR-017`, B3 `SDS-XC-006`, B0 §2 row 9 — **4 authorities to 0** | ⛔ **NO** | **Architecture Owner + Product Owner** | ⛔ No | ✅ **YES** |
| **`XPB-CONF-005`** | **B6 is a new part identifier** | `grep -rl "Part B6" docs/` → **0 files**; B0 `FOD-4` names B4, B5, B7, B8, B9 — ⛔ **not B6**; `PRD_REGISTRY` §12.1 registers B0–B3 only | ⛔ **NO** | **Governance Owner** | ⛔ No | ⚠ Registration only |

⚠ **On `XPB-CONF-002` specifically.** This is *not* the `FOD-3` shape. In `FOD-3`
the EA contradicted **itself** 4-to-1 and the majority reading could be followed.
Here the repository is **unanimous** and the dissent originates in the
**instruction**. `PRD_LIFECYCLE` Stage 4 check 6 states *"Rank 1 wins; the PRD is
wrong."* B5 is therefore specified **completely** but **V2-GATED**:
`PYK-CFG-001 capability.recommendationsEnabled` defaults **FALSE**, and
`PYK-XC-004` makes enablement ⛔ **impossible** while the conflict is OPEN. This
mirrors the degraded-ship-mode discipline B2 `SSF-AC-028` already uses.

⛔ **No ADR was created for any of the three.** The repository lifecycle does not
authorise a Stage-2 author to ratify an ADR, and none of the three is resolvable
by evidence alone.

---

## 9. `AR-1` four-criterion test applied to each new part

| Criterion (`ARCHITECTURE_RULINGS` L23–52) | B4 | B5 | B6 |
|---|---|---|---|
| Owns an aggregate? | ⛔ No | ⛔ No | ⛔ No |
| Owns an invariant? | ⛔ No | ⛔ No | ⚠ Owns **scope policy** only |
| Owns business state? | ⛔ No | ⚠ **See `PYK-GAP-002`** | ⛔ No |
| Only orchestrates public read models? | ✅ Yes | ✅ Yes | ✅ Yes |
| **Form** | **Read composition** | **Read composition** | **Scope policy** |

⭐ **`PYK-GAP-002` is the honest tension of this whole draft set.** B5's
dismissal/suppression needs **per-viewer durable state**, which an `AR-1` read
composition *"owns no business state"* cannot hold. Three options are recorded
and **none is chosen**: (a) `BC-11` holds `RecommendationSuppression`; (b) `BC-25`
per-user config; (c) session-only non-durable. Owner **ARB**. `PYK-XC-011`
forbids claiming durable dismissal until it closes. This mirrors how `FOD-2`
handles `Mute` — an owner with no register row.

---

## 10. Lifecycle-claim scan

Scanned all three drafts for `APPROVED`, `FROZEN`, `Stage 3/4/5`,
`Implementation Ready`, `IMPL-`:

- Every `FROZEN` hit is a **citation of another document's** frozen status
  (`PRD-020` §8.3, `TSF-*`, `PRD-021A` A1) or an explicit negation.
- Every `Stage` hit is either an explicit **negation** (*"Stage 3 has not been
  entered … Nothing here is claimed to pass"*) or a forward statement of the
  **next** gate.
- ⛔ **0** `IMPL-*` identifiers allocated.
- ⛔ **0** self-claims of approval, freeze or stage advancement.

**✅ PASS.**

---

## 11. Boundary compliance — files NOT touched

| Protected surface | Requirement | Measured |
|---|---|---|
| `lib/`, `test/`, `tool/`, `web/`, `android/`, `.github/` | ⛔ no change | ✅ **0 bytes** |
| `MASTER_PRD.md` (Rank 1) | byte-unchanged | ✅ |
| BC Map, EA, `ARCHITECTURE_RULINGS`, Dependency Matrix (Rank 4) | byte-unchanged | ✅ |
| `PRD-020` (FROZEN), `PRD-021A` A1 (FROZEN), Student Identity (FROZEN) | byte-unchanged | ✅ |
| `PRD-021B` B0, B1, B2, B3 | byte-unchanged (Stage-3/4-passed subjects) | ✅ sha256 verified |
| `DOCUMENTATION_BASELINE.md` | ⛔ no row added | ✅ 0 `PRD-021B` rows |
| `TRACEABILITY_MATRIX.md` | ⛔ no row added (Stage 5) | ✅ 0 `PRD-021B` rows |
| `docs/00-governance/adr/` | ⛔ no ADR created | ✅ highest remains `ADR-0087` |
| `PRD_OWNERSHIP_MODEL.md` | ⛔ unchanged | ✅ **L203** already covers `PRD-021` |

---

## 12. Verdict

| Dimension | Result |
|---|---|
| Chain `B3 → B4 → B5` | ✅ **CONSISTENT** — one-way, acyclic |
| Chain `B6 → B3/B4/B5` | ✅ **CONSISTENT** — scope is an upstream precondition |
| Consumption of B2 / `BC-10` / Membership / B1 | ✅ **CONSISTENT** — consumed, never restated |
| Twelve required verifications | ✅ **12 / 12 PASS** (item 3 passed **after** fixing finding **F-1**) |
| Ownership duplication | ✅ **0** |
| Invented BCs / events / edges / data sources | ✅ **0** (8 signal/source refusals recorded instead) |
| Findings against my own drafts | ⚠ **2** — **F-1** fixed; **F-2** method-only |
| Open conflicts | ⚠ **3** — all carried **OPEN** to named owners; ⛔ none overridden |
| Orphan ACs | ✅ **0 / 70** |
| Prohibited lifecycle claims | ✅ **0** |

### ⭐ Lifecycle status — unchanged by this audit

```
PRD-021B  Part B4  =  DRAFT / STAGE 2
PRD-021B  Part B5  =  DRAFT / STAGE 2   (⚠ V2-GATED, XPB-CONF-002 OPEN)
PRD-021B  Part B6  =  DRAFT / STAGE 2   (⚠ XPB-CONF-005 OPEN — part id unregistered)
```

⛔ **Stage 3 NOT entered.** Its gate is a written architecture alignment record;
this audit is a **self-check by the author**, which is categorically not that.
⛔ **Stage 4 NOT entered. Stage 5 NOT entered. Nothing is approved or frozen.**

**Exact next step:** ⚠ `XPB-CONF-001`, `XPB-CONF-002` and `XPB-CONF-005` require
owner decisions **before** Stage 3 can produce a meaningful alignment record for
B5 in particular, since its wave placement is contested by the repository itself.
