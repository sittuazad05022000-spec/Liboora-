# PRD-021C — Local Library Marketplace & Booking (C0–C8) — FINAL DOCUMENT PACKAGE

**Documentation only.** ⛔ No application or source code.

---

## 1. Title

**`PRD-021C` — Local Library Marketplace & Booking, parts C0–C8.**

`PRD-021C` is a **lettered suffix of the existing number `PRD-021`**, exactly as
`PRD-021A` and `PRD-021B` are — ⛔ **no new `PRD-nnn` number is consumed**
(`PRD_REGISTRY.md` **L1341**).

⭐ It owns **no bounded context**. It is an **application / read composition
capability of the Library domain** under ruling **`AR-1`**, already registered at
`MASTER_PRD.md` **L171** as module **19**. **No context was created; the count
remains 31** (`PRD_REGISTRY.md` **L1344**).

---

## 2. The nine parts — C0 through C8

| Part | Subject | Register stem | Lines |
|---|---|---|---|
| **C0** | Cross-Part Architecture and Open Decisions | `XPC-` | 576 |
| **C1** | Marketplace Foundation | `LMP-` | 365 |
| **C2** | Library Search and Local Discovery | `LSD-` | 472 |
| **C3** | Library Public Profile | `LPP-` | 1,039 |
| **C4** | Live Seat Availability and Booking | `LSB-` | 593 |
| **C5** | Library Ratings and Reviews | `LRR-` | 726 |
| **C6** | Library Discovery Presentation | `LDR-` | 755 |
| **C7** | Marketplace Trust and Safety Integration | `LTS-` | 719 |
| **C8** | Technical and Production Architecture | `LMT-` | 778 |
| | **Total** | **9 registers** | **6,023** |

All nine are in [`PRD/`](./PRD/), copied **byte-for-byte** and **sha256-verified**
against the repository. See §9.

---

## 3. Lifecycle status

## ⭐ **FROZEN / BASELINED**

Freeze is **conferred, not claimed** — `PRD_LIFECYCLE.md` **§Stage 7** states the
gate is *"a row in `DOCUMENTATION_BASELINE.md` §3 at an assigned precedence
rank"*, and notes that *"No PRD in this repository declares itself frozen."*

The Stage 7 gate at `PRD_LIFECYCLE.md` **L159** measured **PASS, 2 of 2**.

Conferred by **`ADR-0098`** (status **`Accepted`**, dated **2026-09-03**) —
`ADR-0098-prd-021c-c0-c8-library-marketplace-rank-3-baseline.md`, included in
[`ADR/`](./ADR/).

---

## 4. Baseline

## **`BASELINE-2026-09-03-A`**

`DOCUMENTATION_BASELINE.md` **L5** carries this as the baseline identifier, and
its **L127** row records the advance:

> *Advanced **2026-09-03** to **`BASELINE-2026-09-03-A`** by the **`PRD-021C`
> Local Library Marketplace & Booking C0–C8 admission** (`ADR-0098`) — §7 rule 4,
> a Rank 1–3 document entering, and updated in the **same commit** per §7 rule 3.*

⭐ This is the **eighteenth** Rank 3 module baseline.

---

## 5. Precedence rank

## **Rank 3**

Assigned by **`ADR-0098`**. ⛔ Documents in this package do **not** override any
Rank 1 or Rank 2 authority (`MASTER_PRD.md`, `ARCHITECTURE_RULINGS.md`,
`LIBOORA_BOUNDED_CONTEXT_MAP.md` at its own rank, and the frozen
`Library_PRD_v1.md` §14A).

---

## 6. Implementation tasks

## **`IMPL-1750` … `IMPL-1793`** — **44 tasks**

| Group | Part | Range | Tasks |
|---|---|---|---|
| G1 | C1 | `IMPL-1750`…`1755` | 6 |
| G2 | C2 | `IMPL-1756`…`1761` | 6 |
| G3 | C3 | `IMPL-1762`…`1768` | 7 |
| G4 | C4 | `IMPL-1769`…`1774` | 6 |
| G5 | C5 | `IMPL-1775`…`1778` | 4 — ⭐ **absence tests** |
| G6 | C6 | `IMPL-1779`…`1783` | 5 |
| G7 | C7 | `IMPL-1784`…`1788` | 5 |
| G8 | C8 | `IMPL-1789`…`1793` | 5 |
| | | **Total** | **44** |

⛔ **`IMPL-1794` … `IMPL-1849` is a declared growth reserve — NOT allocated and
NOT used.**

⚠ A naive `grep -oE 'IMPL-[0-9]{4}' | sort -u` over the task file returns **51**,
which is **wrong** — seven of those are citations of other ranges, not
allocations. See
[`DEVELOPER/IMPLEMENTATION_TASK_REFERENCE.md`](./DEVELOPER/IMPLEMENTATION_TASK_REFERENCE.md)
§2.1.

---

## 7. ⛔⛔ Stage 8 implementation has NOT been performed

**This is stated unambiguously and is the most important statement in this
README.**

| Item | State |
|---|---|
| Stage 8 entered | ⛔ **NO** |
| Tasks allocated | 44 |
| Tasks implemented | **0** |
| Lines of application code written | ⛔ **0** |
| Lines of test code written | ⛔ **0** |
| Files under `lib/ test/ web/ android/ ios/ tool/ .github/` touched | ⛔ **0** |

⭐ Allocation of `IMPL-1750`…`IMPL-1793` is a **plan of record**, not a work
order. Nothing in this package begins Stage 8, and this package confers no
lifecycle stage.

---

## 8. Document inventory — 69 files

| Directory | Files | Contents |
|---|---|---|
| [`PRD/`](./PRD/) | **9** | The nine frozen subjects C0–C8 |
| [`ADR/`](./ADR/) | **22** | The **21** `Accepted` ADRs cited by the frozen parts, plus `ADR-INDEX.md` |
| [`ARCHITECTURE/`](./ARCHITECTURE/) | **4** | `LIBOORA_BOUNDED_CONTEXT_MAP.md`, `ARCHITECTURE_RULINGS.md`, `LIBOORA_MODULE_DEPENDENCY_MATRIX.md`, `LIBOORA_ENTERPRISE_ARCHITECTURE.md` |
| [`GOVERNANCE/`](./GOVERNANCE/) | **4** | `DOCUMENTATION_BASELINE.md`, `PRD_REGISTRY.md`, `PRD_LIFECYCLE.md`, `PRD_OWNERSHIP_MODEL.md` |
| [`REVIEWS/`](./REVIEWS/) | **10** | Stage 3–7 records, incl. the retained superseded `STAGE7_BLOCKER` |
| [`DECISIONS/`](./DECISIONS/) | **3** | Owner decision request + form, and the memory/continuation record |
| [`IMPLEMENTATION/`](./IMPLEMENTATION/) | **5** | `PRD-021C_IMPLEMENTATION_TASKS.md`, `TRACEABILITY_MATRIX.md`, `DEFINITION_OF_DONE.md`, `DEVELOPER_HANDOFF.md`, `IMPLEMENTATION_BLOCKER_REGISTER.md` |
| [`DEVELOPER/`](./DEVELOPER/) | **11** | ⭐ Developer documentation — **authored for this package** (§8.2) |
| *this file* | **1** | `README.md` |
| | **69** | |

**57 documents were copied unchanged from the repository. 11 developer documents
plus this README were authored.**

### 8.1 The 21 ADRs — all `Accepted`

`ADR-0010`, `0011`, `0016`, `0020`, `0033`, `0055`, `0058`, `0060`, `0061`,
`0065`, `0077`, `0079`, `0083`, `0084`, `0091`, `0093`, `0094`, `0095`, `0096`,
`0097`, `0098`.

Citation frequency (top): `ADR-0097` ×74 · `ADR-0096` ×57 · `ADR-0094` ×33 ·
`ADR-0093` ×27 · `ADR-0095` ×25 · `ADR-0091` ×20.

⚠⚠ **`ADR-0088`, `ADR-0089` and `ADR-0090` are cited 4, 2 and 2 times
respectively by the frozen parts but DO NOT EXIST** in the repository — verified
by exact-filename probe. They are reserved-unwritten identifiers, and they are
**absent from this package because they are absent from the repository**. ⛔ They
were not authored to close the gap. This is the same condition `PRD-021B`
disclosed in its own package.

### 8.2 ⭐ Developer documentation — created vs existing

**The repository contained NO developer documentation for `PRD-021C`.** Measured
before authoring: `git ls-files docs/ | grep -icE 'developer'` returns **3**, and
none of the three concerns `PRD-021C`:

| Pre-existing developer document | Subject |
|---|---|
| `DEVELOPER_GUIDE.md` (repo root) | Repository-wide |
| `docs/40-implementation/DEVELOPER_HANDOFF.md` | Repository-wide (included in [`IMPLEMENTATION/`](./IMPLEMENTATION/)) |
| `docs/40-implementation/seat-management/PRD-007_DEVELOPER_GUIDE.md` | `PRD-007`, a different subject |

⭐ The user instruction's *"if a required developer document is genuinely
missing"* condition is therefore satisfied by measurement, and the **11**
documents in [`DEVELOPER/`](./DEVELOPER/) were authored **from the frozen PRD and
existing architecture only**.

| # | Document | Required topics covered |
|---|---|---|
| 1 | `README.md` | Entry point, precedence rule, the "genuinely missing" evidence |
| 2 | `ARCHITECTURE_AND_BOUNDARIES.md` | architecture/boundaries · BC ownership · availability/booking boundaries |
| 3 | `OWNERSHIP_AND_DATA.md` | data/entity ownership · tenant isolation |
| 4 | `API_AND_CONTRACTS.md` | API/contract expectations |
| 5 | `INTEGRATIONS_AND_EVENTS.md` | integrations · events |
| 6 | `AUTHORIZATION_AND_SECURITY.md` | authorization · security |
| 7 | `SEARCH_RANKING_AND_DISCOVERY.md` | search/ranking |
| 8 | `ANALYTICS_AND_OBSERVABILITY.md` | analytics · observability |
| 9 | `ERROR_AND_FAILURE_HANDLING.md` | error/failure handling |
| 10 | `TESTING_REQUIREMENTS.md` | testing requirements |
| 11 | `IMPLEMENTATION_TASK_REFERENCE.md` | implementation task references |

**All 16 required topics are covered.** The coverage map is
[`DEVELOPER/ARCHITECTURE_AND_BOUNDARIES.md`](./DEVELOPER/ARCHITECTURE_AND_BOUNDARIES.md)
**§8**.

⭐ **Authority rule, stated in every derived document:** when a `DEVELOPER/`
document and a `PRD/` document disagree, **`PRD/` wins, and the disagreement is a
defect in the `DEVELOPER/` document.** ⛔ The derived documents carry no
authority, mint no identifier, and change no decision.

### 8.3 ⚠ Two disclosed packaging judgements

**These are judgements, not measurements, and they are disclosed rather than
presented as obvious.**

**(a) The superseded Stage 7 blocker is INCLUDED.**
`REVIEWS/PRD-021C_C0_C8_STAGE7_BLOCKER.md` was **superseded** by
`STAGE7_FREEZE.md`. It is **retained deliberately**, on the repository's own
established rule that *a superseded verdict is retained, never deleted or
rewritten* — precedents `ADR-0034`, `PRD-013_STAGE7_BLOCKER`,
`PRD-012a_STAGE7_BLOCKER`, and `PRD-021B`'s own package, whose
`README-PACKAGE.md` §2.3 lists its blocker as *"⛔ **BLOCKED** — superseded,
retained deliberately."*

**(b) Repository-wide documents are INCLUDED.**
`IMPLEMENTATION/TRACEABILITY_MATRIX.md`, `DEFINITION_OF_DONE.md`,
`DEVELOPER_HANDOFF.md`, `IMPLEMENTATION_BLOCKER_REGISTER.md`, and the 4
`GOVERNANCE/` and 4 `ARCHITECTURE/` files are **repository-wide**, not exclusive
to `PRD-021C`. They are included because the frozen parts are **unreadable
without them** — every requirement cites the BC Map, the rulings and the matrix.
⭐ `PRD-021B` included the same class of document and disclosed it the same way.

### 8.4 ⛔ What is deliberately NOT included

| Excluded | Why |
|---|---|
| Any application or test source code | ⛔ None exists — Stage 8 not performed |
| `lib/`, `test/`, `web/`, `android/`, `ios/`, `tool/` | ⛔ Not documentation; **0** files touched |
| `.git/` | ⛔ Excluded by instruction |
| Other PRDs' documents (`PRD-006`, `PRD-021A`, `PRD-021B`, `PRD-020`, …) | ⛔ Unrelated PRDs — instruction forbids copying them |
| Other deliveries in `delivery/` | ⛔ Unrelated implementation work |
| `ADR-0088`, `ADR-0089`, `ADR-0090` | ⚠ **Cited but do not exist** — §8.1 |
| `PRD-015`, `PRD-009` | ⚠ **Do not exist** — §10 |
| `tool/docs_check/prd021c_*.py` Stage-5 instruments | ⚠ Deliberately never committed — disclosed in `DEVELOPER/TESTING_REQUIREMENTS.md` §6 |
| Duplicate or conflicting versions of any document | ⛔ None — one version of each, §9 |

---

## 9. Source repository and commit

| Field | Value |
|---|---|
| **Repository** | `sittuazad05022000-spec/Liboora-` |
| **Remote** | `https://github.com/sittuazad05022000-spec/Liboora-.git` |
| **Branch** | `main` |
| **Freeze commit (verified base)** | **`16644ee249a3cb671cd036b386982a44bcbcbb1d`** |

⚠ **Disclosure — two automated backup commits.** The sandbox's `genspark`
auto-backup fired mid-work and produced **`82f3ec6`** and **`013b3d1`**, both
titled *"genspark auto-backup"*, which captured partially-assembled package files.
`16644ee` remains an **ancestor** of both, the reflog contains only `commit:`
entries, and ⛔ **neither was amended, rebased, squashed or force-pushed.** They
are left in history and disclosed here rather than rewritten.

### 9.1 Byte-fidelity verification

**All 57 copied documents were sha256-verified after copying: 57 of 57
byte-identical to the repository, 0 mismatches.**

The nine frozen subjects, re-verified when this README was written (sha256, first
16 hex):

| Part | sha256 (16) | Status |
|---|---|---|
| C0 | `27722b18f3e2285e` | ✅ unchanged |
| C1 | `c66f8de6eb648d09` | ✅ unchanged |
| C2 | `ea2e3e73f4efab81` | ✅ unchanged |
| C3 | `930ac35443fc5b40` | ✅ unchanged |
| C4 | `6d22b31172f9e75a` | ✅ unchanged |
| C5 | `4327033aae82486d` | ✅ unchanged |
| C6 | `0bd6572931dc104c` | ✅ unchanged |
| C7 | `c90376fcaed9161f` | ✅ unchanged |
| C8 | `1cfbb5e6beb5e639` | ✅ unchanged |

⛔ **No frozen PRD content was modified for packaging.** Full digests for every
file are in [`SHA256SUMS.txt`](./SHA256SUMS.txt), making this package
reproducible from the repository.

---

## 10. Invariants preserved

| Invariant | Value |
|---|---|
| Bounded contexts | **31** — unchanged |
| Integration edges | **29** — unchanged; `E-27` permanently vacant; ⛔ `E-31` not minted |
| ADR files in repository | **86** — unchanged; ⛔ **0** written by this package |
| Identifiers across 30 registers | **528** — all contiguous |
| Normative requirements | **258** (220 FR + 38 BR) on own-stem occupancy |
| Exclusions | **118** |
| Acceptance criteria | **123** — forward **123/123, 0 orphans**; reverse **210/258 = 81.4%**, ⚠ **48 uncovered, registered not repaired** |
| C5 | **V2** on two frozen authorities — ⛔ *"do not invent"* |
| `PRD-007` booking authority | Intact — C4 defines **no** booking |
| `ProfileViews` | ✅ certified — the only `CertifiedMetric` |
| `UniqueViewers` | ⛔ **NOT certified** (`ADR-0097`) — and not renderable in any surrogate form |

### 10.1 ⚠ Open items carried forward — six decisions remain OPEN

**`XPC-OD-004`, `XPC-OD-005`, `XPC-OD-006`, `XPC-OD-008`, `XPC-OD-009`,
`XPC-OD-010`.** ⛔ None was closed by this package.

⚠⚠ **`XPC-OD-005` is unclosable** — the **Privacy Owner role is VACANT**
(`PRD_OWNERSHIP_MODEL.md` **L509**). ⭐ Five sibling decisions were closed earlier
by `ADR-0093`…`ADR-0097` when their owners were available; this one was not, and
that asymmetry is the evidence the discipline was applied rather than merely
stated.

Other open items:

| Item | Status | Owner |
|---|---|---|
| `XPC-CONF-004` — `E-21` enumeration omits `BC-19` | **OPEN** | Architecture Owner |
| `XPC-CONF-007` — `E-22` enumeration omits `BC-19`/`BC-25` | **OPEN** | Architecture Owner |
| `GAP-BCMAP-BC26-EDGES` — `BC-26` inbound-edge anomaly | **OPEN, INHERITED** | Architecture Owner |
| `TSF-GAP-009` — `BC-13` → `BC-19` referral transport; ADR **required, not written**; blocks `IMPL-1424` | **OPEN, INHERITED from `PRD-020`** | Architecture Owner with `BC-19` owner |
| **`PRD-015`** (`BC-23` Search Indexing owner) | ⚠ **DOES NOT EXIST** | Product / Architecture Owner |
| **`PRD-009`** (`BC-26` Analytics owner) | ⚠ **`PLANNED`, absent from disk** (`PRD_REGISTRY.md` **L246**) | Product / Architecture Owner |
| `ADR-0088` / `ADR-0089` / `ADR-0090` | ⚠ **Cited but not written** | Architecture Owner |
| 48 uncovered normative requirements | ⚠ **Registered at measured value** — ⛔ not repaired by minting | Matrix §2R |

⭐ `PRD-015` and `PRD-009` own `BC-23` Search Indexing and `BC-26` Analytics
respectively — **a real open upstream dependency**, and C0 says so directly:
*"`PRD-015` — ⚠ does not exist"*.

---

## 11. Reading order

1. **This README** — status, scope, inventory.
2. [`DEVELOPER/README.md`](./DEVELOPER/README.md) — the derived-documentation
   entry point and its precedence rule.
3. [`DEVELOPER/ARCHITECTURE_AND_BOUNDARIES.md`](./DEVELOPER/ARCHITECTURE_AND_BOUNDARIES.md)
   — the keystone; **§8** is the 16-topic coverage map.
4. [`PRD/PRD-021C_C0_CROSS_PART_ARCHITECTURE_AND_OPEN_DECISIONS_v0.1.md`](./PRD/PRD-021C_C0_CROSS_PART_ARCHITECTURE_AND_OPEN_DECISIONS_v0.1.md)
   — ownership matrix, edge table, conflict register.
5. The remaining `PRD/` parts C1–C8 — ⭐ **the authority**.
6. [`REVIEWS/`](./REVIEWS/) — how each stage was gated, including the retained
   blocker.
7. [`IMPLEMENTATION/`](./IMPLEMENTATION/) — the 44 tasks and the matrix.

---

## 12. Package integrity statement

- ⛔ **No frozen PRD content was modified** — 57 of 57 copies sha256-verified
  byte-identical.
- ⛔ **No PRD was reopened, rewritten, re-ranked or re-baselined.**
- ⛔ **No BC ownership, ADR, event, edge, requirement, AC or decision was
  changed.**
- ⛔ **No new `IMPL-*` identifier was created** — the register is **44**, the
  reserve `IMPL-1794`…`1849` is untouched.
- ⛔ **No reserved ADR number was consumed** — **0** ADRs written.
- ⛔ **No open decision was closed** — all **six** remain OPEN.
- ⛔ **No application or test code exists** — **0** lines, **0** files under
  `lib/ test/ web/ android/ ios/ tool/ .github/`.
- ⛔ **Stage 8 was NOT entered.**
- ✅ **Repository authority is final.** Where this package and the repository
  differ, the repository governs.
