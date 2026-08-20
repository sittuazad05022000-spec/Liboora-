# `PRD-017` Implementation Tasks — `IMPL-1200` … `IMPL-1239`

| Field | Value |
|---|---|
| **Document** | `PRD-017_IMPLEMENTATION_TASKS.md` |
| **Subject** | `docs/30-product/file-media/PRD-017_FILE_AND_MEDIA.md` — File & Media (`BC-29`), v0.1 `DRAFT` |
| **Stage** | **6 — Implementation tasks** (`PRD_LIFECYCLE.md` L135–146) |
| **Range** | **`IMPL-1200` … `IMPL-1239`** — 40 tasks, contiguous |
| **Growth reserve** | **`IMPL-1240` … `IMPL-1299`** — reserved, **not allocated here** |
| **Date** | 2026-08-20 |
| **Depends on** | Stage 5 conferral — inventory frozen at **232 identifiers, 132 obligation-bearing** |
| **Verdict** | ✅ **Stage 6 gate satisfied** — range allocated, every task traces to requirements, every Class A obligation claimed |
| **Application code written** | **None.** ⛔ See §1 |

---

## 1. The one thing this document is not

**This document contains no application code, and creates none.** It is a numbered backlog with traceability. Every
row names work to be done; no row is work done. `lib/`, `packages/`, `test/` and `pubspec.yaml` are untouched by this
stage — measured, not asserted: `git status --short lib/ packages/ test/ web/ pubspec.yaml` → **0 lines**.

The instruction for this stage said so explicitly: *"Do not write application code."* A Stage 6 document that shipped
a Dart file would have failed the stage while appearing to over-deliver.

---

## 2. Stage 6 prerequisites — verified, not assumed

| Prerequisite | State |
|---|---|
| Stage 5 conferred | ✅ `PRD-017_STAGE5_CONFERRAL.md`, §2M registered at matrix **v1.17** |
| Inventory frozen | ✅ **232** identifiers · **132** Class A · both checkers **exit 0** |
| Identifiers mechanically verified | ✅ two independent parsers (line-form, scope-position) both reach 232 |
| Architecture alignment | ⛔ **NOT clean.** `FIL-GAP-012` and blocker `B-11` **OPEN** (§4) |

⚠ **The last row does not block Stage 6, and it is not being treated as though it did.** Stage 6 allocates and traces
task numbers; it does not implement them. The unresolved `E-22` consumer question blocks *executing* the sharing
tasks, and is recorded as such in §4 against the specific task IDs it gates — not hidden, and not allowed to stall
numbering that is independent of it.

---

## 3. `IMPL-*` allocation

### 3.1 Why this range — computed, not chosen

Allocation rule 1 forbids reuse. The next free block was therefore **measured**, not read off a summary table:

```
python3: scan every docs/**/*.md for (?<![A-Za-z-])IMPL-(\d+)
→ 553 distinct numbers in use
→ MAX in the entire repository = 1200
→ the only occurrence of 1200 is a boundary marker, not a task
```

The single `IMPL-1200` occurrence is `PRD-023_IMPLEMENTATION_TASKS.md` **L89**, which reads literally:

```
| IMPL-1200 + | Unallocated | — |
```

**So `IMPL-1200` is the first free number, confirmed by two independent routes** — the repository-wide maximum scan,
and the predecessor's own published boundary. No allocated task anywhere holds it.

### 3.2 The allocation table

| Range | Owner | Source |
|---|---|---|
| `IMPL-800` … `IMPL-829` | Tenancy (`PRD-013`, `BC-19`) — `ADR-0050` | [`../tenancy/PRD-013_IMPLEMENTATION_TASKS.md`](../tenancy/PRD-013_IMPLEMENTATION_TASKS.md) |
| `IMPL-830` … `IMPL-899` | Reserved — `PRD-013` growth. **Not touched here** | — |
| `IMPL-900` … `IMPL-929` | Audit Trail (`PRD-016`, `BC-24`) — `ADR-0051` | [`../audit/PRD-016_IMPLEMENTATION_TASKS.md`](../audit/PRD-016_IMPLEMENTATION_TASKS.md) |
| `IMPL-930` … `IMPL-999` | Reserved — `PRD-016` growth. **Not touched here** | — |
| `IMPL-1000` … `IMPL-1029` | Entitlement (`PRD-014`, `BC-21`) — `ADR-0052` | [`../entitlement/PRD-014_IMPLEMENTATION_TASKS.md`](../entitlement/PRD-014_IMPLEMENTATION_TASKS.md) |
| `IMPL-1030` … `IMPL-1099` | Reserved — `PRD-014` growth. **Not touched here** | — |
| `IMPL-1100` … `IMPL-1129` | Configuration (`PRD-023`, `BC-25`) — `ADR-0053` | [`../configuration/PRD-023_IMPLEMENTATION_TASKS.md`](../configuration/PRD-023_IMPLEMENTATION_TASKS.md) |
| `IMPL-1130` … `IMPL-1199` | Reserved — `PRD-023` growth. **Not touched here** | — |
| **`IMPL-1200` … `IMPL-1209`** | **Wave 1 — storage boundary, port, upload, validation, scanning** | This document |
| **`IMPL-1210` … `IMPL-1219`** | **Wave 2 — `FileRef`, metadata, read path, signed URLs, authorization** | This document |
| **`IMPL-1220` … `IMPL-1229`** | **Wave 3 — tenant isolation, lifecycle, derivatives, failure, idempotency** | This document |
| **`IMPL-1230` … `IMPL-1239`** | **Wave 4 — share grants, audit routing, extensibility, exclusions, testing** | This document |
| `IMPL-1240` … `IMPL-1299` | **Reserved for `PRD-017` growth** — 13 open `FIL-GAP-*` may require tasks | This document, unallocated |
| `IMPL-1300` + | Unallocated | — |

**40 tasks, `IMPL-1200` … `IMPL-1239`, contiguous with no gaps inside the allocated span.** Wave boundaries fall on
round tens so a task added to a wave later does not force a renumber — rule 1 forbids reassignment, so slack must be
designed in rather than found later.

⚠ **This is the largest reserve any module has taken (60), and the largest task count (40).** Both follow from the
measured facts: **232 identifiers** is the biggest register the matrix carries, and **13 gaps are OPEN** — more than
any predecessor froze with. A 60-wide reserve is not generosity; it is the arithmetic of 13 unresolved questions that
may each need tasks.

### 3.3 A staleness disclosed rather than corrected

`PRD_LIFECYCLE.md` **L147–153** publishes an allocation table stating the next free range is **`IMPL-227`+**. That is
**stale by four modules** — `PRD-013`, `PRD-016`, `PRD-014` and `PRD-023` have all allocated above it since.

**This document does not use it, and does not repair it.** Repairing a Rank 1–5 governance document requires an ADR
*before* the change (`DOCUMENTATION_BASELINE.md` §7), and this is not that ADR. The staleness is carried forward as a
known defect, exactly as `PRD-023`'s Stage 6 record carried it. **Following that table instead of measuring would
have collided with four allocated ranges at once.**

---

## 4. Blocking dependencies outside `PRD-017`

| Blocker | Effect | Tasks gated |
|---|---|---|
| **`B-11` / `FIL-GAP-012`** — `BC-12` Messaging is absent from `E-22`'s Consumer cell (BC Map L331), and L292 states *"If an edge is not in this table, it does not exist and adding it requires an ADR"* | ⛔ The **share-grant tasks may be specified but NOT executed** until governance resolves the consumer question. Building them first would create a dependency the BC Map says does not exist | `IMPL-1230` … `IMPL-1236` |
| **`B-2`** — all **seven** `TRACEABILITY_MATRIX.md` §10.3 required architecture tests are missing | ⛔ **No** task can be *proven* complete by architecture test. Completion is claimable, not demonstrable | all 40 |
| **`FIL-GAP-010`** — `tool/module_dependencies.yaml` has no `platform/services:` **block**, so this module's own outbound ports are undeclared | `IMPL-1200` must create it. Until then the boundary checker cannot see this module's dependencies at all | `IMPL-1200` |
| **`BC-18`** authorization is **consumed, never defined** here | Every access decision is a call out. If `BC-18` cannot answer, this module **refuses** (`FIL-BR-011`) | `IMPL-1214` … `IMPL-1217` |
| **Virus scanning** is a V1 obligation (`FIL-FR-018`) whose provider is unnamed | `IMPL-1207` specifies the *contract and the refusal semantics*, not a vendor. ⚠ The EA's `(V2)` token for virus scan is a **known contradiction**, deliberately not resolved here | `IMPL-1207`, `IMPL-1208` |

### 4.1 The module's rank and legal calls — measured

`tool/module_dependencies.yaml` **L33**: `platform/services: 3`. This module is **rank 3**. Its declared consumers
sit at ranks 5 (`domain/social`, L242) and 7.5 (`domain/person`), so every inbound call is **downward** and satisfies
`L2`/`L3` of the dependency matrix. Its own outbound calls — `platform/services:clock` (`FIL-FR-029`) — are
**same-rank within `platform/services`**, which is why `IMPL-1200` must declare the block rather than assume it.
