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

---

## 5. The 40 tasks

**Reading rules.** `Blocks` and `Blocked by` are within this backlog unless a foreign identifier is named. `P0` =
required before any other wave task can be trusted; `P1` = required for the module to function; `P2` = required for
the module to be *provably* correct. Every task cites the obligations it discharges; **no task cites an obligation
that does not exist**, and every Class A obligation is cited by at least one task (§6).

Each task carries all **ten** required fields. Six are in the table — **ID**, **objective** (Task), **requirement
traceability** (Discharges), **priority**, **Blocked by**, **Blocks** — and four are stated once per wave because
they are uniform within it: **scope**, **affected module/package**, **security/tenant implications**, **test
requirements**. **Completion definition** is §10, applying to every task without exception.

### 5.1 Wave 1 — Storage boundary, port, upload, validation, scanning (`IMPL-1200` … `IMPL-1209`)

> **Scope:** the module's position, its single port, and everything that must happen before bytes become readable.
> **Affected module:** `lib/platform/services/files/` (to be created), rank 3. Plus `tool/module_dependencies.yaml`,
> which currently has **no** `platform/services:` block (`FIL-GAP-010`).
> **Security/tenant implications:** `IMPL-1204` is the tenant gate for the whole module — no upload proceeds without a
> resolved tenant context. `IMPL-1207`/`1208` are the readability gate. Every later task inherits both.
> **Test requirements:** unit tests per task; the scan-before-read ordering of `IMPL-1208` exercised as a property,
> not an example. ⛔ None can currently be *proven* — `B-2`.

| ID | Task | Discharges | Priority | Blocked by | Blocks |
|---|---|---|---|---|---|
| `IMPL-1200` | Create the module at `platform/services` rank 3; declare its outbound port block in `tool/module_dependencies.yaml`, closing `FIL-GAP-010`; forbid any import of a domain context | `FIL-FR-001` | **P0** | — | 1201, 1202 |
| `IMPL-1201` | Expose the **entire** capability as the single registered port; prohibit a second surface, a direct client or a side channel | `FIL-FR-002`, `FIL-FR-013` | **P0** | 1200 | 1203, 1210 |
| `IMPL-1202` | Keep every storage-vendor identity out of the module contract; express the vendor behind an internal abstraction only | `FIL-FR-003`, `FIL-FR-072` | P0 | 1200 | 1237 |
| `IMPL-1203` | Enforce the `E-22` consumer list as the admission rule: serve only a caller whose bounded context appears in it; **refuse to widen it**, and refuse to treat a manifest port grant as authority to serve | `FIL-FR-006`, `FIL-FR-007` | **P0** | 1201 | 1230 |
| `IMPL-1204` | **Refuse any upload with no resolved tenant context**; never default, infer or borrow one | `FIL-FR-015` | **P0** | 1201 | 1205, 1220 |
| `IMPL-1205` | Define the upload request contract: resolved tenant context, declared purpose, declared content type, byte length, idempotency key | `FIL-FR-014` | P0 | 1204 | 1206, 1226 |
| `IMPL-1206` | Validate declared content type **against byte content**, and byte length against the purpose-resolved limit; reject before any storage commitment | `FIL-FR-016`, `FIL-FR-017`, `FIL-BR-005` | **P0** | 1205 | 1207, 1223 |
| `IMPL-1207` | Subject every object to virus/malware scanning **before readability**; on scanner unavailability **refuse the upload** rather than admit unscanned bytes | `FIL-FR-018`, `FIL-FR-066` | **P0** | 1206 | 1208 |
| `IMPL-1208` | Make unscanned and failed-scan objects unreadable and un-signable; make an *infected* verdict terminal and unrecoverable by any operation; **admit no privileged bypass** for support, migration or maintenance | `FIL-FR-019`, `FIL-FR-020`, `FIL-FR-021`, `FIL-BR-004`, `FIL-BR-014`, `FIL-INV-001` | **P0** | 1207 | 1210, 1239 |
| `IMPL-1209` | Restrict V1 to the three declared content classes; keep video and audio out of the type allow-list (`FIL-CFG-002`) and out of the code paths | `FIL-FR-004`, `FIL-FR-005` | P1 | 1206 | 1237 |

### 5.2 Wave 2 — `FileRef`, metadata, read path, signed URLs, authorization (`IMPL-1210` … `IMPL-1219`)

> **Scope:** the reference consumers hold, what the module records about an object, and how a read is served.
> **Affected module:** `lib/platform/services/files/`, plus the rank-0 shared kernel for the `FileRef` type so that
> consumers can hold it without importing this module.
> **Security/tenant implications:** this wave contains the module's entire authorization surface. Every decision is
> **obtained from `BC-18`**, never computed here (`IMPL-1214`). `IMPL-1216` makes refusal indistinguishable from
> not-found on private scopes — an information-disclosure control, not a convenience.
> **Test requirements:** unit tests per task; `FileRef` opacity and non-enumerability (`IMPL-1211`) as property tests.
> ⛔ None provable — `B-2`.

| ID | Task | Discharges | Priority | Blocked by | Blocks |
|---|---|---|---|---|---|
| `IMPL-1210` | Issue a `FileRef` on successful upload as the **sole** handle a consumer receives; never return bytes or a raw storage path | `FIL-FR-022` | **P0** | 1201, 1208 | 1211, 1213 |
| `IMPL-1211` | Make the `FileRef` **opaque, non-guessable and non-enumerable** — no embedded path, bucket, vendor or sequential value derivable from it | `FIL-FR-023`, `FIL-FR-025` | **P0** | 1210 | 1212 |
| `IMPL-1212` | Make the `FileRef` **stable and immutable** for the object's lifetime; never reassign it to a different object; keep two refs' lifecycles independent | `FIL-FR-024`, `FIL-FR-027`, `FIL-INV-005` | P0 | 1211 | 1221 |
| `IMPL-1213` | Record the metadata set — `tenantId`, uploading actor, purpose, declared type, size, scan verdict, lifecycle state — with creation time from `platform/services:clock`, never client time | `FIL-FR-028`, `FIL-FR-029` | P0 | 1210 | 1214, 1219 |
| `IMPL-1214` | Obtain **every** access decision from `BC-18`; compute none locally; refuse when no decision is available | `FIL-FR-008`, `FIL-BR-011` | **P0** | 1213 | 1215, 1216, 1217 |
| `IMPL-1215` | Implement the three permission scopes — `self`, `guardianOf`, `tenantWide` — as scope-bearing, and treat a grant in one tenant as conferring nothing in another | `FIL-FR-009`, `FIL-FR-010`, `FIL-FR-012` | **P0** | 1214 | 1216 |
| `IMPL-1216` | Make refusal on `self`/`guardianOf` **indistinguishable from not-found**; disclose a cause only where doing so leaks nothing | `FIL-FR-011`, `FIL-FR-042` | **P0** | 1215 | 1239 |
| `IMPL-1217` | Keep read permission distinct from replace/delete permission, and grant the uploader **no implicit permanent right** — rights follow the current decision, not history | `FIL-BR-001`, `FIL-BR-002` | P0 | 1214 | 1221 |
| `IMPL-1218` | Serve reads **exclusively** as signed, expiring, read-only URLs bounded by `FIL-CFG-004`; make them non-extendable and non-renewable; issue only after an affirmative decision; keep objects **private by default** with no public state | `FIL-FR-034`, `FIL-FR-035`, `FIL-FR-036`, `FIL-FR-037`, `FIL-FR-038`, `FIL-FR-039`, `FIL-FR-041`, `FIL-INV-004` | **P0** | 1214 | 1219, 1234 |
| `IMPL-1219` | Implement revocation as an immediate block on **new** URL issuance, and **state the residual exposure honestly** — an already-issued URL remains valid until expiry; treat expiry, not revocability, as the security guarantee | `FIL-FR-040`, `FIL-BR-009` | **P0** | 1213, 1218 | 1235 |

### 5.3 Wave 3 — Tenant isolation, lifecycle, derivatives, failure, idempotency (`IMPL-1220` … `IMPL-1229`)

> **Scope:** the isolation model, the object's state machine, derived objects, and behaviour under failure.
> **Affected module:** `lib/platform/services/files/`. `IMPL-1220`/`1222` also touch every cache key, index name and
> storage namespace the module constructs.
> **Security/tenant implications:** this wave is where `PRD-013` is honoured or violated. `IMPL-1222` implements the
> **frozen** rule that a global object carries **no** `tenant_id` column at all (`TEN-FR-018`, `TEN-AC-014`) — not a
> null one. A change to any key or namespace here is a **breaking change** (`FIL-FR-046`).
> **Test requirements:** cross-tenant unreachability (`IMPL-1221`) must be tested through counts, aggregates, errors
> and timing — not only direct fetch. ⛔ None provable — `B-2`.

| ID | Task | Discharges | Priority | Blocked by | Blocks |
|---|---|---|---|---|---|
| `IMPL-1220` | Carry `tenant_id` on **every** tenant-scoped object; make every cache key, lookup key, index name and storage namespace tenant-partitioned; treat any change to one as a breaking change | `FIL-FR-043`, `FIL-FR-045`, `FIL-FR-046` | **P0** | 1204 | 1221, 1222 |
| `IMPL-1221` | Resolve a `FileRef` **only** within its owning tenant; make a cross-tenant object unreachable **and unobservable** — including through counts, aggregates, error text and timing | `FIL-FR-026`, `FIL-FR-047`, `FIL-INV-002` | **P0** | 1212, 1217, 1220 | 1239 |
| `IMPL-1222` | Implement the **two** isolation classes declared per purpose; give a global object **no `tenant_id` column at all**; make a global object unreachable by a tenant-scoped decision and vice-versa; never conflate a tenant object with a global one | `FIL-FR-044`, `FIL-FR-048`, `FIL-BR-010`, `FIL-INV-008` | **P0** | 1220 | 1233 |
| `IMPL-1223` | Implement **replace**: substitute bytes behind an existing `FileRef`, preserving the ref, and re-run validation, scanning and quota accounting as for a new upload | `FIL-FR-049`, `FIL-BR-006`, `FIL-BR-007` | P1 | 1206, 1212 | 1224 |
| `IMPL-1224` | Implement **soft-delete** (unreadable, metadata retained, reversible inside the window) and **permanent delete** (irreversible); enforce exactly one lifecycle state at any instant | `FIL-FR-050`, `FIL-FR-051`, `FIL-BR-003`, `FIL-BR-008` | P1 | 1223 | 1225, 1236 |
| `IMPL-1225` | Execute the per-purpose retention rule and the erasure obligation **as instructed by the owning context**, inventing neither; make legal hold block permanent deletion and retention expiry, overridable by no operation | `FIL-FR-052`, `FIL-FR-053`, `FIL-FR-054`, `FIL-INV-007` | P1 | 1224 | 1239 |
| `IMPL-1226` | Make every mutating port operation **idempotent** on a caller-supplied key; a retried upload returns the original `FileRef` and stores nothing new | `FIL-FR-060`, `FIL-FR-061` | P0 | 1205 | 1227 |
| `IMPL-1227` | Guarantee a partial or interrupted upload leaves **no readable object and no `FileRef`**; make a `FileRef` denote a complete object or nothing | `FIL-FR-063`, `FIL-INV-003` | **P0** | 1226 | 1228 |
| `IMPL-1228` | Handle bytes-committed-but-metadata-absent by treating the bytes as unreferenced, and operate a **reclamation sweep** for orphaned bytes | `FIL-FR-064`, `FIL-FR-065` | P1 | 1227 | — |
| `IMPL-1229` | Generate image derivatives inheriting the original's access decision, tenant class and lifecycle state; keep them regenerable and never the sole copy; delete every derivative with its original; bound sizes to `FIL-CFG-007` | `FIL-FR-055`, `FIL-FR-056`, `FIL-FR-057`, `FIL-FR-058`, `FIL-FR-059`, `FIL-INV-006` | P1 | 1224 | — |

### 5.4 Wave 4 — Share grants, audit routing, extensibility, exclusions, testing (`IMPL-1230` … `IMPL-1239`)

> **Scope:** the shared-object infrastructure behind student-to-student sharing, plus the module's boundaries and its
> test obligations.
> **Affected module:** `lib/platform/services/files/`, plus `test/architecture/` for `IMPL-1239`.
> **Security/tenant implications:** `IMPL-1233` keeps both parties to a share inside the object's isolation class — a
> share is **not** a cross-tenant bridge. `IMPL-1231` is the ownership boundary: this module records a share, it never
> decides one. Getting that backwards would move eligibility policy out of its owning context.
> **Test requirements:** the seven `TRACEABILITY_MATRIX.md` §10.3 architecture tests (`IMPL-1239`), plus exclusion
> tests, which are a **different shape** — see §6.2. ⛔ None provable today — `B-2`.
>
> ⛔ **`IMPL-1230` … `IMPL-1236` are BLOCKED FOR EXECUTION by `B-11` / `FIL-GAP-012`.** They are specified and
> numbered because Stage 6 allocates work; they may not be *built* until governance admits `BC-12` to `E-22`. See §4.

| ID | Task | Discharges | Priority | Blocked by | Blocks |
|---|---|---|---|---|---|
| `IMPL-1230` | Implement the **share grant** record: a named recipient `PersonId` may read a named `FileRef`; one grant references exactly one ref and one recipient | `FIL-FR-075`, `FIL-INV-009` | P1 | 1203, 1218 | 1231, 1232 |
| `IMPL-1231` | **Refuse to decide whether a share is permitted.** Require the calling context to supply the eligibility decision; never infer it from a prior share, a prior conversation or any other signal | `FIL-FR-076`, `FIL-BR-016` | **P0** | 1230 | 1232 |
| `IMPL-1232` | Convey **read only** through a grant — no replace, delete, re-share or ownership transfer; keep the uploading actor the owner for the object's whole life | `FIL-FR-077`, `FIL-BR-015` | **P0** | 1230, 1231 | 1234 |
| `IMPL-1233` | Require both parties to a share to be in the **same isolation class** as the object; refuse a grant that would cross it | `FIL-FR-081` | **P0** | 1222, 1230 | — |
| `IMPL-1234` | Serve a recipient's read **only** through a per-request signed, expiring URL — never a stored or reusable link | `FIL-FR-078` | **P0** | 1218, 1232 | — |
| `IMPL-1235` | Make a grant **revocable** by the granting actor or a `BC-18`-authorised actor; keep it in exactly one state (Active or Revoked); forbid a grant naming the same `PersonId` as granter and recipient | `FIL-FR-079`, `FIL-INV-010`, `FIL-INV-011` | P1 | 1219, 1230 | — |
| `IMPL-1236` | Bind the grant's life to the **object**, not the message: unreadable while the object is soft-deleted, gone when the object is permanently deleted, and unaffected by the calling context deleting a message | `FIL-FR-080`, `FIL-BR-017` | P1 | 1224, 1230 | — |
| `IMPL-1237` | Confine extensibility to configuration: admit a new content class, size limit or purpose by changing `FIL-CFG-*` only; **pre-build nothing** listed out of scope; give every configurable a declared default and range | `FIL-FR-071`, `FIL-FR-073`, `FIL-FR-074` | P1 | 1202, 1209 | — |
| `IMPL-1238` | Enforce the module's **silence**: publish no domain event; neither consume nor provide `platform/services:realtime`; report progress synchronously and non-authoritatively; keep ownership metadata free of business meaning, hold no reverse index, and let a consumer degrade rather than corrupt when this module is unavailable | `FIL-FR-030`, `FIL-FR-031`, `FIL-FR-032`, `FIL-FR-033`, `FIL-FR-062`, `FIL-FR-067`, `FIL-FR-068`, `FIL-FR-069`, `FIL-FR-070`, `FIL-FR-082`, `FIL-BR-012`, `FIL-BR-013` | P1 | 1213 | 1239 |
| `IMPL-1239` | Build the test suite: the **seven** `TRACEABILITY_MATRIX.md` §10.3 architecture tests (closing `B-2`), the isolation and authorization tests, and the **22 exclusion** tests — which assert impossibility and are therefore a different shape from acceptance tests, never a substitute for them | `FIL-XC-001` … `FIL-XC-022` | **P2** | 1208, 1216, 1221, 1225, 1238 | — |

---

## 6. Traceability — task group → requirements → invariants → acceptance

Required by allocation rule 4.

| Wave | Tasks | Requirements discharged | Invariants | Acceptance criteria |
|---|---|---|---|---|
| **1** — boundary, port, upload, validation, scanning | `IMPL-1200`…`1209` | `FIL-FR-001`…`007`, `013`…`022`; `FIL-BR-004`, `005`, `014` | `FIL-INV-001` | `FIL-AC-001`…`020` (§14.1) |
| **2** — `FileRef`, metadata, read, signed URLs, authz | `IMPL-1210`…`1219` | `FIL-FR-008`…`012`, `022`…`042`; `FIL-BR-001`, `002`, `009`, `011` | `FIL-INV-004`, `FIL-INV-005` | `FIL-AC-021`…`045` (§14.2) |
| **3** — isolation, lifecycle, derivatives, failure | `IMPL-1220`…`1229` | `FIL-FR-043`…`061`, `063`…`066`; `FIL-BR-003`, `006`, `007`, `008`, `010` | `FIL-INV-002`, `003`, `006`, `007`, `008` | `FIL-AC-046`…`068` (§14.2–§14.3) |
| **4** — sharing, boundaries, extensibility, testing | `IMPL-1230`…`1239` | `FIL-FR-030`…`033`, `062`, `067`…`082`; `FIL-BR-012`, `013`, `015`, `016`, `017`; `FIL-XC-001`…`022` | `FIL-INV-009`, `010`, `011` | `FIL-AC-069`…`078` (§14.3–§14.4) |

**All 11 invariants are claimed:** `FIL-INV-001` by `IMPL-1208`; `002` by `1221`; `003` by `1227`; `004` by `1218`;
`005` by `1212`; `006` by `1229`; `007` by `1225`; `008` by `1222`; `009` by `1230`; `010`/`011` by `1235`.

### 6.1 Coverage

| Register | Members | Claimed by ≥1 task | Coverage |
|---|---|---|---|
| `FIL-FR-*` | 82 | 82 | **100.0%** |
| `FIL-BR-*` | 17 | 17 | **100.0%** |
| `FIL-INV-*` | 11 | 11 | **100.0%** |
| `FIL-EVT-*` | 0 | — | **n/a — DECLARED EMPTY** |
| `FIL-XC-*` | 22 | 22 | **100.0%** |
| **Class A total** | **132** | **132** | **100.0%** |
| `FIL-AC-*` | 78 | 78 (by `IMPL-1239`) | **100.0%** claimed · ⛔ **0 proven** |

**No task claims zero obligations, and no task cites an obligation that does not exist** — every identifier above is
drawn from the inventory frozen by Stage 5 at **232**.

### 6.2 Why 100% task coverage sits beside 71.2% acceptance coverage — the two are different claims

Stage 5 published **94 / 132 = 71.2%** acceptance coverage. This document publishes **132 / 132 = 100.0%** task
coverage. Both are true, and the difference is not slack:

- **Task coverage** asks *is this obligation somebody's work?* Every obligation is, including the 22 `FIL-XC-*`
  exclusions — enforcing a prohibition is real work (`IMPL-1208`, `1231`, `1238`, `1239`).
- **Acceptance coverage** asks *is this obligation observably provable?* An exclusion states what must be
  **impossible**, and a criterion asserting that something never happens is **unfalsifiable by observation**.

⚠ **The trap avoided is worth naming.** It would have been easy to write `IMPL-1239` as *"prove all 132 obligations"*
and publish 100% on both lines. That would restate the `PRD-006` v1.0 failure — *"100% coverage"* against a true
**49.1%** — in a new column. `IMPL-1239`'s field therefore says the exclusion tests are a **different shape** rather
than pretending they are the same.

---

## 7. Critical path

```
IMPL-1200  module exists, ports declared
   └─ 1201  the single port
        ├─ 1203  E-22 admission rule  ────────────────┐
        └─ 1204  refuse without tenant context        │
             └─ 1205 → 1206 → 1207 → 1208            │  (scan gate)
                                  └─ 1210  FileRef    │
                                       └─ 1213 → 1214 │  (BC-18 authz)
                                            └─ 1218   │  (signed URL)
                                                 └────┴─ 1230  share grant  ⛔ B-11
                                                          └─ 1231 → 1232 → 1234
                                                               1239  tests  ⛔ B-2
```

**`IMPL-1208` and `IMPL-1214` are the two chokepoints.** Nothing readable exists before the scan gate, and no read is
served before `BC-18` answers. **`IMPL-1230` cannot start at all** until `B-11` is resolved.

---

## 8. Tasks that must **not** be created

| Forbidden task | Why |
|---|---|
| Anything deciding **whether two students may share** | `BC-11`/`BC-12` own eligibility. `FIL-FR-076` and `IMPL-1231` require this module to *ask*, never infer. Building it here would move policy out of its owning context |
| A messaging, conversation or friend-request feature | `PRD-021` owns them. **This document creates no `PRD-021` work and duplicates none** |
| A moderation, abuse-report or enforcement flow | `BC-13` Trust & Safety owns them; `E-14` is **outbound** from it |
| An entitlement or quota-enforcement decision | `BC-21` owns entitlement. `FIL-BR-012` — this module *measures and reports* consumption; it does not enforce a limit |
| A domain event for upload, share or delete | `FIL-FR-062`; `BC-29` appears in **0** BC Map §9 producer rows. `FIL-EVT-*` is **empty by design** |
| An audit-record writer | `BC-24` owns audit. `FIL-FR-082` routes auditability through the **calling context** and `E-20`, which this module cannot reach |
| Adding `BC-12` to `E-22` in the BC Map | Requires an ADR **before** the change (`DOCUMENTATION_BASELINE.md` §7). Stage 6 has no such authority |
| Video or audio support | `FIL-FR-005`. Out of V1 scope, and `IMPL-1237` forbids pre-building it |
| A realtime/websocket progress channel | `FIL-FR-069`. Measured: the module neither consumes nor provides `platform/services:realtime` |
| Any application code at all, in this stage | §1 |

---

## 9. What this document does **not** claim

- **It does not claim the module is implementable today.** `B-11` blocks 7 of 40 tasks; `B-2` blocks *proof* of all 40.
- **It does not claim any obligation is verified.** Task coverage is allocation, not evidence (§6.2).
- **It does not close a single `FIL-GAP-*`.** All **13** remain OPEN.
- **It does not resolve the `E-22` consumer question**, and does not treat the manifest's `platform/services:files`
  grant to `domain/social` as resolving it — `FIL-FR-007` and `IMPL-1203` forbid exactly that inference.

---

## 10. Definition of done — applies to every task

A task is complete when **all** hold:

1. The behaviour it discharges is implemented at the declared module and rank, importing nothing above it.
2. Every obligation in its **Discharges** field is satisfied — not partially, not by a TODO.
3. Unit tests exist for its behaviour, and **pass**.
4. Any exclusion it enforces is tested as an impossibility, not as an example.
5. `dart run tool/check_module_boundaries.dart` introduces **no new** finding attributable to the task.
6. Tenant isolation is preserved on every surface the task touches — including caches, indices and error text.
7. No authorization decision is computed inside this module.
8. The task's row here is updated only by adding evidence; **its ID is never reassigned** (allocation rule 1).

⛔ Criterion 3 cannot currently be *proven* for architecture properties — `B-2`. A task meeting 1–2 and 4–8 with tests
written but unprovable is **claimable, not done**.

---

## 11. Stage 6 exit gate

| Gate clause (`PRD_LIFECYCLE.md` L135–146) | State |
|---|---|
| An `IMPL-*` range is allocated | ✅ **`IMPL-1200` … `IMPL-1239`**, measured as free by two routes (§3.1) |
| Every task traces to requirements | ✅ 40 of 40 cite ≥1 obligation; **0** cite a nonexistent one |
| Rule 1 — never reuse a number | ✅ repository max was **1200**, held only as a boundary marker |
| Rule 2 — leave growth room | ✅ **`IMPL-1240` … `IMPL-1299`** reserved for 13 open gaps |
| Rule 3 — record Priority / Blocks / Blocked by | ✅ all three on all 40 rows |
| Rule 4 — add a traceability table | ✅ §6, plus per-register coverage §6.1 |

✅ **Stage 6 gate satisfied.**

---

## 12. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-20 | Stage 6 allocated. **40 tasks, `IMPL-1200`…`IMPL-1239`**, range computed by repository-wide scan (max in use = 1200, a boundary marker only) and confirmed against `PRD-023_IMPLEMENTATION_TASKS.md` L89. **60-wide growth reserve** for 13 open gaps. All **132** Class A obligations claimed; **0** phantom citations. Sharing tasks limited to `FIL-FR-075`…`082` + `FIL-BR-015`…`017` + `FIL-INV-009`…`011` — **no `PRD-021` work created or duplicated**. `IMPL-1230`…`1236` marked ⛔ **blocked for execution** by `B-11`/`FIL-GAP-012`. **No application code written.** `PRD_LIFECYCLE.md` L147–153 staleness disclosed, not repaired |
