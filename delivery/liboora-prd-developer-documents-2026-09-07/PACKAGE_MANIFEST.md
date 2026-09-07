# Liboora — PRD & Developer Documents Package

| Field | Value |
|---|---|
| **Package** | `liboora-prd-developer-documents-2026-09-07.zip` |
| **Created** | 2026-09-07 |
| **Source commit** | see `SOURCE_COMMIT` below |
| **Purpose** | External developer handoff — full PRD/product and developer/implementation documentation |
| **Nature** | ⚠ **Documentation only.** No application source, no build outputs, no credentials |

---

## 1. What is INCLUDED, and why

| Path | Files | Why it is required to implement the PRDs |
|---|---|---|
| `docs/30-product/**` | 285 | ⭐ **The PRDs themselves** — every module PRD plus its lifecycle gate records (Stage-3 alignment/conferral, Stage-4/5/7 conferrals, freeze readiness). A PRD without its gate records cannot be audited |
| `docs/40-implementation/**` | 34 | ⭐ **Implementation tasks** (`IMPL-*` per module), `TRACEABILITY_MATRIX.md`, `DEVELOPER_HANDOFF.md`, `DEFINITION_OF_DONE.md`, `IMPLEMENTATION_BLOCKER_REGISTER.md`, roadmap and status |
| `docs/00-governance/**` | 114 | ⭐ **Rank 1–2 authority.** `MASTER_PRD.md` global rules bind every module; the **ADRs** are Rank 2 and decide questions the PRDs defer to them; `DOCUMENTATION_BASELINE.md` assigns precedence rank; `PRD_LIFECYCLE.md` defines every stage gate; `PRD_REGISTRY.md` gives each PRD's status; `PRD_OWNERSHIP_MODEL.md` names owning roles. **A PRD read without these is unreadable** — it cites them constantly |
| `docs/10-architecture/**` | 8 | ⭐ **Rank 4/5.** `LIBOORA_BOUNDED_CONTEXT_MAP.md` (context ownership and the event/edge tables), `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` (permitted edges), `ARCHITECTURE_RULINGS.md`, `DEPENDENCY_GRAPH.md`, `BOUNDARY_CHECKER_DESIGN.md` |
| `docs/20-configuration/**` | 1 | `CONFIGURATION_GUIDE.md` — resolves the `*-CFG-*` configuration identifiers the PRDs declare |
| `docs/90-archive/**` | 22 | Superseded records, retained because the append-only doctrine means history is evidence, never deleted |
| `tool/docs_check/**` | 39 | ⭐⭐ **The mechanical gate instruments.** Stage 5 requires counts *"verified mechanically… counted by a tool, not by reading"* — these are those tools. A developer can re-run them and reproduce every published count |
| `tool/module_dependencies.yaml` | 1 | ⭐ The machine-readable module manifest: ranks, ports, `consumes_events`, `excluded_events`, `banned_imports`, assertions |
| `tool/check_module_boundaries.dart`, `tool/gates.sh` | 2 | Boundary checker and gate runner |
| root `README.md`, `DEVELOPER_GUIDE.md`, `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `SECURITY.md`, `CHANGELOG.md`, `LICENSE` | 7 | Standard developer onboarding and contribution rules |
| root `analysis_options.yaml`, `pubspec.yaml` | 2 | Lint configuration and the declared dependency set — needed to reproduce the analysis environment |

**Repository directory structure is preserved**, so every relative link and every `docs/…` path citation inside the documents still resolves.

## 2. What is EXCLUDED, and why

| Excluded | Why |
|---|---|
| `.git/` | Version-control internals; not a delivery artefact |
| `build/`, `.dart_tool/`, `__pycache__/`, `*.pyc` | Build outputs and caches — regenerable, and `build/web/handoff/` holds stale copies of older packages |
| `lib/`, `test/`, `web/`, `android/` | ⚠ **Application source is deliberately out of scope.** This package is the PRD/developer *documentation* deliverable |
| `.idea/`, `.vscode/`, `.DS_Store` | IDE and OS metadata |
| `delivery/**` (prior packages and `*.zip`) | Excluded to avoid nesting packages inside packages |
| `*.log`, `/tmp` scratch | Temporary files |
| `google-services.json`, `*.jks`, `*.keystore`, `key.properties`, `.env*`, `*.pem`, `*.p12` | ⛔ **Credentials — never packaged.** Verified absent both by filename and by content pattern scan |

## 3. ⚠ Read this before implementing

⭐⭐ **A FROZEN specification is NOT a shippable capability.** Several PRDs in this package are frozen
*with named open items*, which is lawful and deliberate — a freeze records what a bounded context
**owns**, not what has been **decided**.

⛔ **`PRD-009` Analytics & Reports (`BC-26`) — FROZEN at Rank 3 on 2026-09-05, with 12 OPEN blockers:**

| Item | State |
|---|---|
| **F-1** — no semantic layer exists, though `MP-GBR-36` requires every metric to come from one | ⛔ OPEN — BLOCKER |
| **F-2** — no learning-outcome data source exists | ⛔ OPEN — BLOCKER |
| **F-3** — peer comparison barred by `MP-GBR-21`'s closed scope register | ⛔ OPEN |
| `AttendanceCorrected` restatement semantics | ⛔ OPEN |
| **`ANL-AL-B1` / `ANL-OBD-008`** — a live **Rank-4 vs Rank-4** conflict: the BC Map routes `iam.*` to `BC-26` while `module_dependencies.yaml` excludes it. Precedence cannot break a tie between equals. The conservative default `ANL-XC-012` governs ⇒ ⛔ **no `iam.*`-derived metric is authorised** | ⛔ OPEN |
| `ANL-OBD-002` · `-004` · `-009` | ⛔ OPEN |
| `ANL-CFG-003` · `-005` · `-006` | ⛔ OWED |
| **25 / 25** `ANL-GAP-*` | ⛔ OPEN |
| Acceptance criteria proven by a test | ⛔ **0 of 17** |
| Stage-6 tasks startable | ⚠ **8 of 32 BLOCKED** |
| Stage 8 | ⛔ NOT entered |

⭐ Re-run `tool/docs_check/prd009_stage5.py`, `prd009_traceability.py` and `prd009_task_coverage.py`
to reproduce these facts mechanically. Two of the three fail deliberately if a blocker is deleted
or if a stage is claimed without authority.

⚠ Other modules carry their own open items — read each PRD's own gate records, not this summary.

## 4. Suite status at packaging time

`tool/docs_check`: **33 pass / 6 fail**. The six failures are **pre-existing and known**
(`alignment_record_freshness.py`, `prd004_traceability.py`, `prd005_traceability.py`,
`prd006_traceability.py`, `prd007_traceability.py`, `prd020_stage5.py`) and are shipped red
**deliberately** — a suite doctored to look green would be worthless as evidence.
