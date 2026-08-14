# PRD-006 Attendance Management — v1.9 FINAL DEVELOPER PACKAGE

| Field | Value |
|---|---|
| **Subject** | `PRD-006` Attendance Management, **v1.9** |
| **PRD status** | **FROZEN** |
| **Admitted by** | [`ADR-0034`](./ADR/ADR-0034-attendance-management-prd-v1.9-baseline.md) — **`Accepted`** |
| **Baseline** | `BASELINE-2026-08-05-A` |
| **Package purpose** | Hand the frozen specification to implementers **without changing it** |
| **Contains code** | **No.** This package is documentation only |

---

## 1. What this package is, and what it is deliberately not

This package is the **complete developer-facing reading set** for building
`PRD-006` Attendance Management v1.9. It collects the frozen PRD, the accepted
ADRs that authorise it, the architecture documents that bound it, the governance
documents that rank it, and the review records that cleared it — plus **15
derived developer documents** that reorganise those sources for implementation.

**It is not a redesign, and it adds no authority.** Every normative statement in
`DEVELOPER/` is traceable to a numbered obligation in `PRD/` or to an
**`Accepted`** ADR in `ADR/`. Where a fact was not found in those sources, the
developer documents say **so explicitly** rather than supplying a plausible one.

Two of the fifteen requested documents therefore turned out to be
**constraint documents rather than specifications**, and this is stated up front
because it is the single most important thing a reader needs to know before
opening them:

> **[`API_SPECIFICATION.md`](./DEVELOPER/API_SPECIFICATION.md) contains no HTTP
> endpoints, and
> [`DATABASE_SPECIFICATION.md`](./DEVELOPER/DATABASE_SPECIFICATION.md) contains
> no table definitions — because the frozen PRD contains none.**
>
> **Measured, not assumed.** A case-insensitive search for
> `(POST|GET|PUT|PATCH|DELETE) /<path>`, `openapi` and `swagger` across
> `PRD-006`, `ADR-0034`, `ADR-0032`, the Bounded Context Map and the Module
> Dependency Matrix returns **0** in every file. A search for `CREATE TABLE`,
> `varchar`, `NOT NULL` and `primary key` across the same five files also
> returns **0** in every file.
>
> Writing an endpoint table or a DDL script would therefore have **invented**
> the very thing this package was instructed not to invent. Both documents
> instead specify the **boundaries** any future API or schema must respect, and
> name who is authorised to decide the rest.

---

## 2. Package structure

```
PRD-006_v1.9_FINAL_DEVELOPER_PACKAGE/
├── README.md          ← you are here
├── PRD/               2 files   the frozen specification + its task backlog
├── ADR/              22 files   10 Accepted + 11 Proposed + the index
├── ARCHITECTURE/      2 files   Bounded Context Map, Module Dependency Matrix
├── GOVERNANCE/        5 files   baseline, registry, lifecycle, ownership, matrix
├── REVIEWS/           4 files   Stage 3, Stage 4, E-27 conflict, Stage 7 freeze
└── DEVELOPER/        15 files   derived implementation documents
```

### `PRD/` — the frozen source of truth

| File | Role |
|---|---|
| `PRD-006_ATTENDANCE-MANAGEMENT.md` | **FROZEN v1.9.** 3216 lines. The only normative product source |
| `PRD-006_IMPLEMENTATION_TASKS.md` | The task backlog — **80 tasks**, `IMPL-600` … `IMPL-679` |

> ⚠️ **`PRD-006_IMPLEMENTATION_TASKS.md` carries a stale header** that still
> says *"Source of truth: `PRD-006` v1.4 **DRAFT**"* and *"`PRD-006` remains
> **`DRAFT`**"*. That header is **out of date and deliberately left untouched**:
> the file is *"Backlog record. **Not ranked**, therefore editable without an
> ADR"*, and silently editing it inside a delivery package would be exactly the
> quiet amendment this project's governance forbids. **Read its task rows;
> disregard its version header.** The authoritative status is in `PRD/`'s frozen
> PRD and in [`ADR-0034`](./ADR/ADR-0034-attendance-management-prd-v1.9-baseline.md).

### `ADR/` — decisions, with their binding status stated

**Only `Accepted` ADRs are binding.** `ADR-INDEX.md` defines `Proposed` as
*"Under consideration; **not binding**"*. This matters enormously for
implementation, so the split is printed here rather than left to be discovered:

| Status | ADRs | How to treat them |
|---|---|---|
| **`Accepted`** — binding | `ADR-0001`, `ADR-0011`, `ADR-0012`, `ADR-0013`, `ADR-0014`, `ADR-0018`, `ADR-0020`, **`ADR-0032`**, **`ADR-0033`**, **`ADR-0034`** | **Build to these** |
| **`Proposed`** — **NOT binding** | `ADR-0021`, `ADR-0022`, `ADR-0023`, `ADR-0024`, `ADR-0025`, `ADR-0026`, `ADR-0027`, `ADR-0028`, `ADR-0029`, `ADR-0030`, `ADR-0031` | **Read for context. Do NOT implement their content as a rule.** They are included because they record *why* certain questions are still open, and their option lists prevent re-litigating settled analysis |

The three ADRs that specifically carry v1.9:

- **`ADR-0034`** — admits `PRD-006` v1.9 to baseline `BASELINE-2026-08-05-A`.
- **`ADR-0032`** — resolves Seat Card presence visibility, option **`O-5`**:
  presence is **composed at read time**; **no fifth event** was created.
- **`ADR-0033`** — the `E-27` core-cluster edge allow-list decision.

### `ARCHITECTURE/`, `GOVERNANCE/`, `REVIEWS/`

`ARCHITECTURE/` holds the two documents that bound the module: the **Bounded
Context Map** (contexts, edges `E-01` … `E-26`, event surface) and the **Module
Dependency Matrix** (the explicit edge allow-list). `GOVERNANCE/` holds the
baseline declaration, the PRD registry, the lifecycle and ownership models, and
the Rank 4 traceability matrix. `REVIEWS/` holds the Stage 3 alignment
supplement, the Stage 4 re-review, the `E-27` cluster-edge conflict analysis and
the Stage 7 freeze-readiness record.

### `DEVELOPER/` — the 15 derived documents

| # | Document | What it gives you |
|---|---|---|
| 1 | [`README.md`](./DEVELOPER/README.md) | Entry point and reading order for the developer set |
| 2 | [`DEVELOPER_GUIDE.md`](./DEVELOPER/DEVELOPER_GUIDE.md) | Orientation: the module's job, its boundaries, the rules that bite first |
| 3 | [`IMPLEMENTATION_GUIDE.md`](./DEVELOPER/IMPLEMENTATION_GUIDE.md) | Build order, layering, what to write and in what sequence |
| 4 | [`DOMAIN_RULES.md`](./DEVELOPER/DOMAIN_RULES.md) | The domain vocabulary and the invariants that must never break |
| 5 | [`ATTENDANCE_STATE_MACHINE.md`](./DEVELOPER/ATTENDANCE_STATE_MACHINE.md) | The nine statuses, the 5-minute grace, exit precedence |
| 6 | [`WIFI_PRESENCE_ARCHITECTURE.md`](./DEVELOPER/WIFI_PRESENCE_ARCHITECTURE.md) | Observation → verification → session, and the derived-state model |
| 7 | [`SEAT_CARD_INTEGRATION.md`](./DEVELOPER/SEAT_CARD_INTEGRATION.md) | Read-time composition, and the four shortcuts that are refused |
| 8 | [`ATTENDANCE_HISTORY.md`](./DEVELOPER/ATTENDANCE_HISTORY.md) | Append-only history, corrections, what history may and may not claim |
| 9 | [`EVENT_CONTRACTS.md`](./DEVELOPER/EVENT_CONTRACTS.md) | **Exactly four** events, their consumers, and the closed surface |
| 10 | [`API_SPECIFICATION.md`](./DEVELOPER/API_SPECIFICATION.md) | **Constraint document** — no endpoints exist to specify |
| 11 | [`DATABASE_SPECIFICATION.md`](./DEVELOPER/DATABASE_SPECIFICATION.md) | **Constraint document** — no schema exists to specify |
| 12 | [`SECURITY_REQUIREMENTS.md`](./DEVELOPER/SECURITY_REQUIREMENTS.md) | Authorisation, tenant isolation, and the five never-claims |
| 13 | [`ANDROID_BACKGROUND_BEHAVIOUR.md`](./DEVELOPER/ANDROID_BACKGROUND_BEHAVIOUR.md) | What Android does **not** guarantee, and the required responses |
| 14 | [`TESTING_REQUIREMENTS.md`](./DEVELOPER/TESTING_REQUIREMENTS.md) | What must be tested, drawn from the `ATT-AC-*` register |
| 15 | [`IMPLEMENTATION_TASKS.md`](./DEVELOPER/IMPLEMENTATION_TASKS.md) | The **80** tasks, derived — not re-invented |

---

## 3. The decisions that must survive implementation

These are the load-bearing product decisions. Changing any of them requires a
new Product Owner decision or a new ADR — **not** an implementer's judgement.

| Decision | Value | Source |
|---|---|---|
| Disconnect grace period | **EXACTLY 5 MINUTES** | §10A.4, `D-15` |
| Shift tolerance | **30 MINUTES**, Owner **and** Manager configurable, **both sides** | §10A.7a |
| Attendance exit | The **final qualifying Wi-Fi disconnect** is an approved exit method | §10A.4a row 3 |
| Exit inference | **Never** inferred from absence of observations or process death | §10A.4a row 2, §10A.5 |
| Multi-device | **OR** presence — any one valid device holds the session | §10A.2 |
| Location Verification | **OPTIONAL, default OFF** | §10A.12, `D-21` |
| No-booking / overstay | Two **stored** statuses, rows 8 and 9 | §10A.1, `D-20` |
| Manual attendance | **≠ verified presence** | `ATT-AC-214` |
| Seat allocation | **≠ presence** | frozen `SEAT-FR-041` |
| Seat Card | Composed **at read time**; **never** reads raw Wi-Fi or device state | §23.4a, `ADR-0032` |
| Event surface | **EXACTLY 4** events. **No fifth event. No `StudentCheckedOut` overload** | §22.1, `ATT-FR-134`, `ATT-AC-117`, `ATT-AC-216`, `ATT-AC-217` |

---

## 4. Verification recorded with this package

| Check | Result |
|---|---|
| Frozen PRD body md5 (lines 20–3190) | **`8fb479c2387d1098a47824eb8b9b69a9`** — unchanged |
| Frozen PRD line count | **3216** |
| Source code changed (`lib/`, `test/`, `pubspec.yaml`, `android/`, `web/`) | **0 files** |
| `prd006_traceability.py` | **PASS**, exit 0 — `285/285 = 100.0%`, dangling 0, orphans 0 |
| `prd006_task_coverage.py` | **PASS**, exit 0 — `80` tasks, `IMPL-600..679`, 0 holes |
| Protected Rank 1–4 / frozen document hashes | **6 of 6 unchanged** |
| Stage 3 | ✅ **ALIGNED 6/6** |
| Stage 4 | ✅ **A — PASSED** |

---

## 5. Known-open items a reader will meet

These are **open by record**, not by omission. Do not close them by guessing.

- **18 open `ATT-GAP-*` gaps** across a 23-row ledger (4 resolved, 1 narrowed).
- **`ATT-GAP-002a` — the booked shift `BC-03` cannot read.** This blocks the
  *shift-relative* Seat Card renderings (outside-window, overstay). The plain
  presence axis is buildable; the conformance badge is not.
- **`ATT-GAP-005` — retention is undefined**, and this module **MUST NOT**
  define its own.
- **`ATT-GAP-007` — network identification is unspecified**; `ADR-0027`
  (`Proposed`) owns the question.
- **`ATT-GAP-017a` — no latency or throughput figure** may be stated.
- **The 30-minute tolerance is NOT registered as `ATT-CFG-*`.** It is binding
  product intent, but the register entry is owed, because no allowed **range**
  has been approved. `ADR-0031` remains `Proposed`.
- **No periodic-check interval exists.** `D-14` explicitly withholds it.

---

## 6. Reading order

1. This file.
2. [`DEVELOPER/README.md`](./DEVELOPER/README.md) → [`DEVELOPER_GUIDE.md`](./DEVELOPER/DEVELOPER_GUIDE.md).
3. [`DEVELOPER/DOMAIN_RULES.md`](./DEVELOPER/DOMAIN_RULES.md) and
   [`ATTENDANCE_STATE_MACHINE.md`](./DEVELOPER/ATTENDANCE_STATE_MACHINE.md) — the two you cannot skip.
4. [`ADR/ADR-0034`](./ADR/ADR-0034-attendance-management-prd-v1.9-baseline.md), then
   [`PRD/PRD-006_ATTENDANCE-MANAGEMENT.md`](./PRD/PRD-006_ATTENDANCE-MANAGEMENT.md) **§10A** in full.
5. The remaining `DEVELOPER/` documents as your work touches them.

**When a developer document and the frozen PRD disagree, the frozen PRD wins,
and the disagreement is a defect in the developer document.** Report it; do not
resolve it in code.
