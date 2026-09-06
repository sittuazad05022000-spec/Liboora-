# `PRD-010` Notifications & Communication — Stage 6 Implementation Tasks

| Field | Value |
|---|---|
| **Document** | `PRD-010_STAGE6_IMPLEMENTATION_TASKS.md` |
| **Subject** | `PRD-010_NOTIFICATIONS_AND_COMMUNICATION.md` — Notifications & Communication (`BC-22`), **v0.14 `DRAFT`**, sha256 `63326045fefe8328` |
| **Stage** | **6 — Implementation Tasks** (`PRD_LIFECYCLE.md` **L135-152**) |
| **Range allocated** | ⭐ **`IMPL-1900` … `IMPL-1929`** — **30** tasks, contiguous, one row per number · **`IMPL-1930`…`1999`** declared growth reserve |
| **Prior stage** | ✅ Stage 5 conferred by [`PRD-010_STAGE5_CONFERRAL.md`](PRD-010_STAGE5_CONFERRAL.md) · registered at [`TRACEABILITY_MATRIX.md`](../../40-implementation/TRACEABILITY_MATRIX.md) **v1.25 §2T** |
| **Authority** | **Implementation Lead**, exercised by direct, explicit and unconditional conferral of the human principal of this engagement (§0) |
| **Baseline** | ⛔ **No baseline re-issue.** `PRD-010` is `DRAFT` and holds no rank |
| **Verdict** | ✅ **GATE SATISFIED — both halves present: a range is allocated, and every task traces back to requirements** · ⚠ self-audit repair applied at v1.1 (§4 count corrected 13/13 → measured **12/13**) |
| **Date** | 2026-09-05 |

---

## 0. Authority — stated, because Stage 6 has an owner

`PRD_LIFECYCLE.md` §6 **L280** assigns **Stages 6 and 8** to the **Implementation lead**. The authority
relied on here is the same form `PRD-008_STAGE4_CONFERRAL.md` established, `ADR-0033` §7.2 describes,
and `PRD-013`/`PRD-016` Stage 6 both used: **direct, explicit and unconditional conferral by the human
principal, scoped to one act.**

**Instruction (verbatim):** *"PHASE 3 — STAGE 6. Only after Stage 5 genuinely passes. Read the exact
Stage-6 requirements and applicable repository precedents. Perform Stage 6 exactly as required."*

⛔ **Scope: this act only** — `ADR-0033` §7.1. It confers no Stage 7 authority and no Stage 8
(verification) authority.

---

## 1. The gate, verbatim, and both halves

> **L137:** *"an `IMPL-*` range allocated and a task document in which **every task traces back to
> requirements**."*

| Half | Requirement | Evidence | Verdict |
|---|---|---|---|
| **G1** | An `IMPL-*` range is allocated | **`IMPL-1900`…`IMPL-1929`**, 30 contiguous numbers, one row each (§3) | ✅ |
| **G2** | Every task traces back to requirements | **30 / 30** tasks name at least one `NTF-*` obligation; **0** orphan tasks (§3, §4) | ✅ |

### 1.1 Allocation rules — each checked, not assumed

`PRD_LIFECYCLE.md` **L139-146** states four rules.

| Rule | Text | Compliance |
|---|---|---|
| 1 | *"Take the next free range. **Never reuse or reassign a number**"* | ⭐ **`IMPL-1900` is the next free number, measured.** The highest allocated is `IMPL-1873` (`PRD-015`, `IMPL-1850`…`1873`), and `PRD-015_IMPLEMENTATION_TASKS.md` **L67** already declares *"`IMPL-1900`+ — Unallocated — measured empty"*. ⛔ **0** reuse |
| 2 | *"Leave the previous group room to grow contiguously"* | ⭐ `IMPL-1874`…`1899` left untouched as `PRD-015`'s growth room; this allocation starts at the round **1900** boundary, the same convention `PRD-013` (800), `PRD-016` (900) and `PRD-014` (1000) used |
| 3 | *"Record `Priority`, `Blocks`, `Blocked by` per task"* | ✅ All three columns present for all 30 tasks |
| 4 | *"Add a traceability table mapping task groups → requirements → invariants → acceptance"* | ✅ §4 |

### 1.2 Collision check — measured

| Probe | Result |
|---|---|
| `IMPL-1900`…`1929` occurring anywhere in `docs/` before this document | ⭐ **0** |
| Overlap with any allocated range (`014`–`073`, `100`–`127`, `200`–`226`, `800`–`829`, `900`–`929`, `1000`–`1029`, `1300`–`1359`, `1500`–`1569`, `1600`–`1689`, `1750`–`1793`, `1850`–`1873`) | ⭐ **0** |
| Contiguity of this range | ✅ 1900…1929, no gaps, no duplicates |

---

## 2. ⛔ What Stage 6 does NOT assert

⭐⭐ **This is the most important section, because a task list is the artefact most likely to be
mistaken for a readiness claim.**

- ⛔ **It does not assert the tasks are implementable today.** **7** `NTF-GAP-*` remain OPEN; three of them (`-017`, `-028`, `-029`) sit *inside* the tasks below and are named there.
- ⛔ **It does not close any gap**, resolve any `[OWED]` item, or discharge `NTF-CFG-004`'s suspensive condition (`ADR-0108` §3.1).
- ⛔ **It does not confer Stage 7, rank, baseline or freeze.** `PRD-010` stays `DRAFT`; `PRD_REGISTRY.md` stays `PLANNED`.
- ⛔ **It writes no application code and no test.** **0** `.dart` files changed.
- ⛔ **It does not create the `platform/communication` port grant.** `T-29` records that the manifest amendment is an **Architecture Owner** act requiring its own ADR, and is **not performed here**.

---

## 3. The tasks — `IMPL-1900` … `IMPL-1929`

**Priority:** `P1` = blocks a V1 delivery path · `P2` = required for V1 completeness · `P3` = required
before Stage 8 verification.

### Wave A — foundations (`IMPL-1900`…`1909`)

| # | Task | Traces to | Priority | Blocks | Blocked by |
|---|---|---|---|---|---|
| `IMPL-1900` | Declare the `FeedItem` aggregate root — durable per-recipient notification record with `read` state | `NTF-INV-001`, `BCM-22-INV-1`, `BCM-22-INV-2` | P1 | 1901, 1903, 1912 | — |
| `IMPL-1901` | Declare the `DeliveryMessage` aggregate root — per-recipient-per-channel delivery with `DeliveryState` | `NTF-FR-042`, `NTF-FR-043`, `BCM-22-R1` | P1 | 1902, 1908, 1913 | 1900 |
| `IMPL-1902` | Enforce the no-cross-root-transaction rule at the repository boundary | `BCM-22-R1`, `ADR-0107` §3.3 | P1 | — | 1901 |
| `IMPL-1903` | Persist `FeedItem` durably; prove restart survival | `BCM-22-INV-1` | P1 | 1904 | 1900 |
| `IMPL-1904` | Implement `FeedItem` rebuild-from-log yielding an identical set per tenant+recipient | `BCM-22-INV-1` | P2 | — | 1903 |
| `IMPL-1905` | Tenant-scope every recipient set, preview, count and delivery record | `NTF-FR-006`, `NTF-INV-008`, `MP-GBR-21` | P1 | 1906 | — |
| `IMPL-1906` | Reject a recipient set spanning two tenants, at the aggregate boundary | `NTF-FR-006`, `NTF-INV-008` | P1 | — | 1905 |
| `IMPL-1907` | Consume domain facts over `E-23` only; reject any other edge | `NTF-XC-004`, `NTF-XC-005` | P1 | — | — |
| `IMPL-1908` | Implement the `[PROPOSED]` §18 delivery lifecycle with monotonic transitions | `NTF-FR-042` | P1 | 1913 | 1901 |
| `IMPL-1909` | Assert `BC-22` never writes a domain aggregate (architecture test) | `NTF-INV-001` | P2 | — | — |

### Wave B — dispatch, dedup and retry (`IMPL-1910`…`1919`)

| # | Task | Traces to | Priority | Blocks | Blocked by |
|---|---|---|---|---|---|
| `IMPL-1910` | Build the notification catalogue from the 13 BC Map events | `NTF-FR-001`…`-005` (§8 catalogue) | P1 | 1911, 1912 | — |
| `IMPL-1911` | Enforce the `{mandatory, optional}` class per catalogue entry; refuse dispatch when unclassified | `NTF-FR-038`, `NTF-FR-040`, `NTF-CFG-003` | P1 | 1916 | 1910 |
| `IMPL-1912` | Project each consumed fact into a `FeedItem` per resolved recipient | `NTF-FR-007`, `NTF-INV-001` | P1 | 1913 | 1900, 1910 |
| `IMPL-1913` | Fan out one `FeedItem` to M `DeliveryMessage`s, one per channel in the channel set | `G1`, `NTF-FR-013`, `NTF-FR-015` | P1 | 1914 | 1901, 1908, 1912 |
| `IMPL-1914` | Implement the dedup record on `(eventId, recipientId, channel, templateId)`, claimed **atomically before dispatch** | `NTF-INV-007`, `NTF-FR-045`, `NTF-FR-046` | P1 | 1915 | 1913 |
| `IMPL-1915` | Bind dedup-record lifetime to the `FeedItem` lifetime; assert absence after | `NTF-FR-066`, `NTF-AC-010` | P2 | — | 1914 · ⚠ **`NTF-GAP-028`** for numeric bounds |
| `IMPL-1916` | Enforce the recipient-count ceiling `NTF-CFG-001` (200, 1–500); refuse over-ceiling dispatch | `NTF-FR-017`, `NTF-CFG-001` | P1 | — | 1911 |
| `IMPL-1917` | Submit deliveries via the `JobRuntime` port with `retryBudget` = `NTF-CFG-004` | `NTF-FR-049`, `NTF-CFG-004` | P1 | 1918 | 1913 · ⚠ **`T-29`** port grant |
| `IMPL-1918` | Pass a `deadline` on every submission satisfying `NTF-FR-067`'s inequality | `NTF-FR-067`, `NTF-AC-011` | P1 | — | 1917 · ⛔ **`NTF-GAP-017`** supplies the per-attempt bound |
| `IMPL-1919` | Distinguish transient from permanent failure so only transient retries | `NTF-FR-047` | P2 | — | ⛔ **`NTF-GAP-029`** — the V1 adapter cannot yet distinguish them |

### Wave C — channels, content, consent (`IMPL-1920`…`1925`)

| # | Task | Traces to | Priority | Blocks | Blocked by |
|---|---|---|---|---|---|
| `IMPL-1920` | Implement the In-App inbox read surface with `read`/unread on `FeedItem` | `NTF-FR-043`, `BCM-22-INV-2` | P1 | — | 1900, 1903 |
| `IMPL-1921` | Route Push egress through `BC-31`; forbid any direct vendor call | `NTF-XC-006` | P1 | 1922 | 1901 |
| `IMPL-1922` | Mark `delivered` **only** on a durably recorded successful `BC-31` acknowledgement | `NTF-FR-044`, `NTF-AC-013` | P1 | — | 1921 |
| `IMPL-1923` | Render templates from the approved placeholder set; forbid number/credential/financial leakage | `NTF-FR-035`, `NTF-FR-027`, `MP-GBR-34` | P1 | — | 1910 |
| `IMPL-1924` | Resolve template locale through `LCFG-2`; consume, never redefine | `NTF-FR-037`, `NTF-CFG-002` | P2 | — | 1923 |
| `IMPL-1925` | Implement consent / unsubscribe honouring `optional` and refusing opt-out of `mandatory` | `NTF-FR-038`, `NTF-CFG-003` | P1 | — | 1911 |

### Wave D — observability, boundaries and residues (`IMPL-1926`…`1929`)

| # | Task | Traces to | Priority | Blocks | Blocked by |
|---|---|---|---|---|---|
| `IMPL-1926` | Emit per-tenant delivery telemetry — attempted / succeeded / failed-terminal / suppressed-duplicate, carrying no forbidden identifier | `NTF-FR-065`, `NTF-AC-012` | P2 | — | 1913 |
| `IMPL-1927` | Enforce `NTF-INV-011` — an unresolvable address fails only that delivery, never the emitting operation | `NTF-INV-011`, `CM-3` | P1 | — | 1913 |
| `IMPL-1928` | Enforce the WhatsApp-redirect exclusions — no `DeliveryMessage`, no `FeedItem`, no audit event, no stored content, and ⛔ **no communication-history record** | `NTF-XC-007`, `NTF-FR-023`, `NTF-FR-026`, `NTF-FR-063` | P2 | — | — |
| `IMPL-1929` | Assert `BC-22` publishes no rate/throughput limit and no configuration resolution order | `NTF-XC-008`, `NTF-FR-054` | P3 | — | — |

**Count: 30 tasks · `IMPL-1900`…`IMPL-1929` · contiguous · 0 duplicates · 0 orphans.**

---

## 4. Traceability — task groups → requirements → invariants → acceptance

Rule 4 requires this mapping explicitly.

| Wave | Tasks | Requirements | Invariants | Acceptance |
|---|---|---|---|---|
| **A** foundations | 1900–1909 | `NTF-FR-006`, `-042`, `-043`, `NTF-XC-004`, `-005` | `NTF-INV-001`, `-008`, `BCM-22-INV-1`, `-INV-2`, `BCM-22-R1` | `NTF-AC-003` |
| **B** dispatch/dedup/retry | 1910–1919 | `NTF-FR-013`, `-015`, `-017`, `-038`, `-040`, `-045`, `-046`, `-047`, `-049`, `-066`, `-067` | `NTF-INV-007` | `NTF-AC-001`, `-002`, `-008`, `-010`, `-011` |
| **C** channels/content/consent | 1920–1925 | `NTF-FR-023`, `-027`, `-035`, `-037`, `-043`, `-044` | `BCM-22-INV-2` | `NTF-AC-004`, `-007`, `-013` |
| **D** observability/boundaries | 1926–1929 | `NTF-FR-026`, `-054`, `-063`, `-065`, `NTF-XC-007`, `-008` | `NTF-INV-011` | `NTF-AC-006`, `-009`, `-012` |

⭐ **Coverage of the acceptance register: 12 / 13 criteria are exercised by at least one task — measured,
not asserted.** The measurement is reproducible: extract `NTF-AC-*` from the §4 table above and compare
against the PRD's `NTF-AC-*` register.

```
sed -n '/^| \*\*A\*\* foundations/,/^| \*\*D\*\*/p' PRD-010_STAGE6_IMPLEMENTATION_TASKS.md \
  | grep -oE 'NTF-AC-[0-9]{3}' | sort -u        # expand the -00n shorthand by row first
```

| Result | Criteria |
|---|---|
| ✅ **Covered — 12** | `NTF-AC-001`, `-002`, `-003`, `-004`, `-006`, `-007`, `-008`, `-009`, `-010`, `-011`, `-012`, `-013` |
| ⚠ **Uncovered — 1** | `NTF-AC-005` |

⚠ `NTF-AC-005` is exercised by no task **and that is deliberate** — it tests the §11 permission matrix,
which is expressly `[PROPOSED]` and blocked on `NTF-GAP-008` (`BC-18` authority). Assigning it a task
would imply an authority that does not exist.

> ⚠⚠ **Disclosure — this line previously read "13 / 13", and that was wrong.** The claim was written
> before the §4 table was mechanically expanded. On measurement, §4 named **11** criteria, `NTF-AC-006`
> was **uncovered and undisclosed**, and `IMPL-1928` did not cite `NTF-FR-063` — the requirement
> `NTF-AC-006` verifies. The defect was **a missing citation plus a false count, not a missing task**:
> `IMPL-1928` already enforces the WhatsApp-redirect exclusions that `NTF-FR-063` states. The repair
> added `NTF-FR-063` to `IMPL-1928`, added `NTF-AC-006` to wave D, and ⭐ **corrected the count downward
> to the measured 12/13 rather than upward to the claim.** No task was invented to make a number true.

---

## 5. Blocked tasks — named, not hidden

| Task | Blocked by | Class |
|---|---|---|
| `IMPL-1915` | `NTF-GAP-028` / `NTF-OBD-001` — numeric `FeedItem` lifetime | **`[OWED — AO]`** |
| `IMPL-1918` | `NTF-GAP-017` — FCM/`BC-31` per-attempt bound | **`[OWED — EXTERNAL EVIDENCE]`** |
| `IMPL-1919` | `NTF-GAP-029` / `NTF-RTD-001` — adapter cannot distinguish transient from permanent | **`[OWED — AO + implementation]`** |
| `IMPL-1917` | `T-29` — `platform/communication` lacks the `platform/services:job_runtime` port | **`[OWED — AO, ADR first]`** |

> ⭐ **T-29 — the manifest amendment, recorded and NOT performed.** `tool/module_dependencies.yaml`
> **L392-410** does not grant `platform/communication` the `platform/services:job_runtime` port;
> **L338** shows `platform/workflow` as the only holder. The edge is **strictly downward** (rank 3 →
> rank 5), so no `L2` waiver is needed and the fix is one line in the `A-3` shape — ⛔ **but amending a
> Rank 4 artefact requires an ADR first** (`DOCUMENTATION_BASELINE.md` §7 step 1) and is the
> **Architecture Owner**'s act. **Not performed here.**

---

## 6. Governance verification

| Constraint | Verified |
|---|---|
| Frozen PRDs untouched | ✅ byte-unchanged |
| Rank-1 / Rank-4 untouched | ✅ `MASTER_PRD.md`, BC Map (**§8 and §18 intact**), `module_dependencies.yaml` all unchanged |
| `ADR-0107`…`0110` | ✅ preserved, not reopened |
| Subject PRD | ✅ **byte-unchanged by Stage 6** — sha256 `63326045fefe8328` |
| Matrix | ✅ unchanged by this stage (§2T stands as registered at Stage 5) |
| Baseline / registry | ✅ **0** `PRD-010` baseline rows; registry **`PLANNED`** |
| Code / tests | ✅ **0** `.dart` files |
| `IMPL-*` reuse | ✅ **0** — `IMPL-1900` measured free |

---

## 7. Changelog

| Version | Date | Change |
|---|---|---|
| **v1.1** | 2026-09-05 | ⚠⚠ **Self-audit repair — one defect found by mechanical measurement of my own v1.0 claim, and corrected downward.** §4 asserted *"13 / 13 criteria are exercised"*; expanding the `-00n` shorthand per wave row measured **11**, so the count was false and **`NTF-AC-006` was uncovered and undisclosed**. Root cause: `IMPL-1928` enforced the WhatsApp-redirect exclusions but did **not cite `NTF-FR-063`** — the requirement `NTF-AC-006` verifies (*"MUST NOT appear in communication history"*). ⭐ **The defect was a missing citation plus a false count, not a missing task** — so the repair added `NTF-FR-063` to `IMPL-1928` and `NTF-AC-006` to wave D, and ⭐⭐ **corrected the headline to the measured `12 / 13` rather than inflating the evidence to match the claim. No task was invented to make a number true.** The single remaining uncovered criterion `NTF-AC-005` stays deliberately unassigned (`[PROPOSED]` §11 matrix, blocked on `NTF-GAP-008`). §4 now publishes the reproducing command so the number can be re-measured rather than believed. ⛔ Range, task count, waves, priorities and dependency edges **unchanged**: still `IMPL-1900`…`1929`, 30 tasks, 0 orphans. Subject PRD **byte-unchanged** (`63326045fefe8328`); all checkers exit 0; frozen/Rank-1/Rank-4 byte-unchanged. |
| **v1.0** | 2026-09-05 | Created. **Stage 6 gate SATISFIED** — both halves present. ⭐ **`IMPL-1900`…`IMPL-1929` allocated**: 30 contiguous tasks in four waves, one row per number, **0 reuse**, **0 overlap** with the eleven existing allocations. ⚠ **The next-free number was measured, not assumed** — the highest allocated is `IMPL-1873` (`PRD-015`), and `PRD-015_IMPLEMENTATION_TASKS.md` **L67** already declares `IMPL-1900`+ unallocated; `IMPL-1874`…`1899` is left as `PRD-015`'s growth room per rule 2. All four **L139-146** allocation rules checked individually, including `Priority`/`Blocks`/`Blocked by` on every task and the §4 group→requirement→invariant→acceptance mapping. ⭐ **Every task traces to at least one `NTF-*` obligation; 0 orphans; 13/13 acceptance criteria exercised** — with **`NTF-AC-005` deliberately unassigned** because it tests a `[PROPOSED]` permission matrix blocked on `NTF-GAP-008`, and giving it a task would imply absent `BC-18` authority. ⚠⚠ **Four tasks are recorded as BLOCKED with their owners named** (`IMPL-1915`/`GAP-028`, `IMPL-1918`/`GAP-017`, `IMPL-1919`/`GAP-029`, `IMPL-1917`/`T-29` manifest port) rather than being written as though executable. ⭐ **T-29 documents the one-line manifest amendment and expressly does NOT perform it** — Rank 4 needs an ADR first, and it is the Architecture Owner's act. ⛔ **0 gaps closed (7 OPEN) · subject PRD byte-unchanged · matrix unchanged · nothing ranked, baselined or frozen · registry `PLANNED` · Stage 7 NOT conferred · 0 code · 0 tests · BC Map §8/§18 intact · `ADR-0107`…`0110` preserved.** |
