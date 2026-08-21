# `PRD-017` Implementation Tasks — `IMPL-1200` … `IMPL-1254`

| Field | Value |
|---|---|
| **Document** | `PRD-017_IMPLEMENTATION_TASKS.md` |
| **Subject** | `docs/30-product/file-media/PRD-017_FILE_AND_MEDIA.md` — File & Media (`BC-29`), **v0.2 `FROZEN`** *(was v0.1 `DRAFT` when this document was first written; the PRD was frozen at Stage 7 and amended to v0.2 by `ADR-0056`. This cell is corrected because it describes the subject as it is now — leaving it would have made this document cite a version of its own subject that no longer exists)* |
| **Stage** | **6 — Implementation tasks** (`PRD_LIFECYCLE.md` L135–146) |
| **Range** | **`IMPL-1200` … `IMPL-1254`** — **55** tasks, contiguous. ⚠ *Advanced from 40 on 2026-08-20 by the `PRD-017` v0.2 amendment (`ADR-0056`): Wave 5 drew `IMPL-1240`…`IMPL-1254` out of the growth reserve, so the reserve narrows and **no existing task moves**.* |
| **Growth reserve** | **`IMPL-1255` … `IMPL-1299`** — **45** remaining, reserved, not allocated. *Was `IMPL-1240`…`IMPL-1299` (60); 15 consumed by Wave 5* |
| **Date** | 2026-08-20 |
| **Depends on** | Stage 5 conferral — inventory frozen at **232 identifiers, 132 obligation-bearing**; **advanced to 277 / 150 by the v0.2 amendment** (`ADR-0056`) |
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
| Inventory frozen | ✅ **232** identifiers · **132** Class A · both checkers **exit 0** — *the state at Stage 5, which is what this prerequisite records. Superseded at v0.2 by **277** / **150**; the Stage 5 figure is left as the historical precondition it was, not overwritten* |
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
| **`IMPL-1240` … `IMPL-1254`** | **Wave 5 — media optimization: profiles, originals, documents, variants, processing lifecycle, tests** *(added by the v0.2 amendment, `ADR-0056`)* | This document |
| `IMPL-1255` … `IMPL-1299` | **Reserved for `PRD-017` growth** — **45** remaining; **15** open `FIL-GAP-*` may require tasks. ⚠ *The reserve is doing exactly what §3.2 designed it for: Wave 5 added 15 tasks without renumbering a single existing one* | This document, unallocated |
| `IMPL-1300` + | Unallocated | — |

**55 tasks, `IMPL-1200` … `IMPL-1254`, contiguous with no gaps inside the allocated span** (verified mechanically after Wave 5 was added, and **re-verified after the wave grew twice** — `IMPL-1253` and `IMPL-1254` were each added to close a measured allocation hole, not planned). *Was 40 tasks to `IMPL-1239` before the v0.2 amendment.* Wave boundaries fall on
round tens so a task added to a wave later does not force a renumber — rule 1 forbids reassignment, so slack must be
designed in rather than found later.

⚠ **This is the largest reserve any module has taken (60), and the largest task count (now 55).** Both follow from the
measured facts: **277 identifiers** at v0.2 — 232 when this reserve was sized — is the biggest register the matrix
carries, and **15 gaps are OPEN** — more than any predecessor froze with. A 60-wide reserve is not generosity; it is
the arithmetic of unresolved questions that may each need tasks. ⚠ *The sizing decision has now been **tested rather
than assumed**: the v0.2 amendment drew 15 tasks out of this reserve and **renumbered nothing**, which is the only
evidence that matters for rule 1.*

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
| **`B-11` / `FIL-GAP-012`** — ✅ **RESOLVED 2026-08-20 for the architecture question only.** `BC-12` Messaging **is now listed** in `E-22`'s Consumer cell (BC Map **v1.8**, L331), admitted by `ACCEPTED` [`ADR-0055`](../../00-governance/adr/ADR-0055-e22-consumer-list-includes-bc-12.md) after necessity was re-derived **per context** — `BC-11` Social Graph and `BC-13` Trust & Safety were tested and **NOT** admitted | ✅ **`IMPL-1230` … `IMPL-1236` are UNBLOCKED FOR EXECUTION**: the dependency they need is now recorded in the map, so building them no longer creates an edge that *"does not exist"*. ⛔ **Unblocked is not done.** None of the seven is implemented, and `B-2` still gates *proof* of completion for all **fifty-five** tasks. This row is deliberately **not deleted**, because a backlog that erases a resolved blocker loses the record of why seven tasks sat idle | `IMPL-1230` … `IMPL-1236` — **released** |
| **`B-2`** — all **seven** `TRACEABILITY_MATRIX.md` §10.3 required architecture tests are missing | ⛔ **No** task can be *proven* complete by architecture test. Completion is claimable, not demonstrable | all **55** |
| **`FIL-GAP-010`** — `tool/module_dependencies.yaml` has no `platform/services:` **block**, so this module's own outbound ports are undeclared | `IMPL-1200` must create it. Until then the boundary checker cannot see this module's dependencies at all | `IMPL-1200` |
| **`BC-18`** authorization is **consumed, never defined** here | Every access decision is a call out. If `BC-18` cannot answer, this module **refuses** (`FIL-BR-011`) | `IMPL-1214` … `IMPL-1217` |
| **Virus scanning** is a V1 obligation (`FIL-FR-018`) whose provider is unnamed | `IMPL-1207` specifies the *contract and the refusal semantics*, not a vendor. ⚠ The EA's `(V2)` token for virus scan is a **known contradiction**, deliberately not resolved here | `IMPL-1207`, `IMPL-1208` |

### 4.1 The module's rank and legal calls — measured

`tool/module_dependencies.yaml` **L33**: `platform/services: 3`. This module is **rank 3**. Its declared consumers
sit at ranks 5 (`domain/social`, L242) and 7.5 (`domain/person`), so every inbound call is **downward** and satisfies
`L2`/`L3` of the dependency matrix. Its own outbound calls — `platform/services:clock` (`FIL-FR-029`) — are
**same-rank within `platform/services`**, which is why `IMPL-1200` must declare the block rather than assume it.

---

## 5. The 55 tasks

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
> ✅ **`IMPL-1230` … `IMPL-1236` were BLOCKED by `B-11` / `FIL-GAP-012` and are now RELEASED.**
> Governance admitted `BC-12` to `E-22` on 2026-08-20 (`ADR-0055`, BC Map **v1.8**), which is exactly the
> condition this notice named. ⚠ **Their status changes from BLOCKED to `Not started`, and nothing else
> changes** — no task is marked done, no priority moves, no `Discharges` cell is rewritten. Release is a
> statement about *lawfulness*, not about progress, and `FIL-GAP-012`'s implementation half is still OPEN.
> ⛔ **`B-2` is untouched**: all seven §10.3 architecture tests remain missing, so completion of these seven
> — like all fifty-five — is claimable but not provable. See §4.

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
| `IMPL-1239` | Build the test suite for Waves 1–4: the **seven** `TRACEABILITY_MATRIX.md` §10.3 architecture tests (closing `B-2`), the isolation and authorization tests, the **78** §14.1–§14.4 acceptance tests, and the **22 exclusion** tests — which assert impossibility and are therefore a different shape from acceptance tests, never a substitute for them | `FIL-XC-001` … `FIL-XC-022`, `FIL-AC-001` … `FIL-AC-078` | **P2** | 1208, 1216, 1221, 1225, 1238 | — |

---

### 5.5 Wave 5 — Media optimization: profiles, originals, documents, variants, processing lifecycle, tests (`IMPL-1240` … `IMPL-1254`)

> **Added 2026-08-20 by the `PRD-017` v0.2 amendment** (`ADR-0056`). These **fifteen** tasks come out of the
> **reserved** `IMPL-1240` … `IMPL-1299` band declared in §3.2 — **no existing task was renumbered, resplit or
> reassigned**, which is the whole reason §3.2 designed a 60-wide reserve instead of packing the range tight.
>
> **Scope:** the optimization and processing pipeline behind image compression, document handling and serving
> variants. **Affected module:** `lib/platform/services/files/`.
> **Security/tenant implications:** ⛔ **A derivative is not a loophole.** `IMPL-1240` establishes that every
> optimized representation inherits the source object's authorization, isolation class, audit obligations and
> lifecycle — so no task in this wave may create a path that serves bytes the original would have refused.
> `IMPL-1247` keeps the original-quality choice an **entitlement decision consumed over `E-19`**, never a local
> policy read. *(⚠ This sentence first cited `IMPL-1248`, which is the lossless-document task; the entitlement work
> is `IMPL-1247`. Caught by a mechanical cross-check of prose task references against the `Discharges` cells — a
> wrong ID inside a preamble is exactly the defect class that survives proofreading.)*
> **Test requirements:** `IMPL-1252` builds the fixture corpus and **`IMPL-1254` is this wave's test task**, which
> together are the only way `FIL-AC-080`'s readability obligation becomes testable rather than aspirational.
> ⛔ None provable today — `B-2`.
>
> ⚠ **`IMPL-1254` exists because a SECOND coverage hole was measured after `IMPL-1253` closed the first.** A scan of
> every task row's `Discharges` cell returned **`FIL-AC-*` cited by ZERO tasks in this wave**: Wave 4 carries its own
> test task (`IMPL-1239`), whose row is explicitly scoped to the seven §10.3 architecture tests and the **22**
> exclusions `FIL-XC-001`…`022`. It therefore does **not** reach the 18 new §14.5 criteria, and §6.1's *"AC claimed
> by `IMPL-1239`"* row would have become **false** the moment the register grew to 96. Rather than widen
> `IMPL-1239`'s scope retroactively — which would have edited a Wave 4 task to absorb Wave 5 work and made the
> already-shipped v1.0 row misdescribe it — a fifteenth task was added. **`FIL-XC-023` is now allocated to
> `IMPL-1247`, `IMPL-1251` and `IMPL-1254`.**
>
> ⛔ **VIDEO AND AUDIO ARE NOT IN THIS WAVE, AND NO TASK MAY ADD THEM.** `FIL-FR-005`, `FIL-XC-016` and
> `FIL-XC-023` forbid video/audio acceptance and transcoding at V1; the request was made and **refused**
> (`FIL-GAP-016`). "Adaptive" here means *adaptive across image and document characteristics*, not across media
> types. A task creating a transcoding path would contradict three frozen requirements in the owning PRD.
>
> ⚠ **Three tasks depend on values that do not yet exist.** `FIL-CFG-010` (quality floor), `FIL-CFG-011` (minimum
> document long edge) and `FIL-CFG-015` (processing timeout) are published with owners and ranges but **no
> defaults** — `FIL-GAP-014`. Those tasks are therefore **specified and startable but not completable**: the
> mechanism can be built, the threshold cannot be chosen here. This is stated per task rather than hidden.
>
> ⚠ **`IMPL-1253` exists because a coverage check found a hole this wave had left.** The wave was first written
> with thirteen tasks and a mechanical check of the eighteen new v0.2 obligations against the `Discharges` cells
> returned **`FIL-FR-091` — serving variants — allocated to nothing.** The convenient repair was to append the
> identifier to `IMPL-1240`, which already covers derivative inheritance; that was **rejected**, because
> `FIL-FR-091` obliges the *generation and serving* of variants through the signed-URL path, which is work, not
> a property of another task. A fourteenth task was added instead. **Measured after the repair: 0 of the 18 new
> obligations unallocated.**

| ID | Task | Discharges | Priority | Blocked by | Blocks |
|---|---|---|---|---|---|
| `IMPL-1240` | Treat every optimized representation as a **derivative** of its source object, inheriting its authorization, isolation class, audit obligations and lifecycle; never as an independent object | `FIL-FR-083`, `FIL-INV-013` | **P0** | 1222, 1224 | 1241, 1242, 1243, 1246, 1249 |
| `IMPL-1241` | Classify an accepted image as **document-like** or **photographic** from measured properties, and **record the decision** on the object so it is auditable and reproducible | `FIL-FR-084`, `FIL-INV-012` | **P0** | 1240 | 1242, 1243, 1244 |
| `IMPL-1242` | Implement the **document-aware** compression profile: honour the `FIL-CFG-010` quality floor, disable chroma subsampling, never reduce the long edge below `FIL-CFG-011`. ⚠ **Not completable until `FIL-GAP-014` supplies the two values** — build the mechanism, do not invent the thresholds | `FIL-FR-085`, `FIL-BR-019` | **P0** | 1241 | 1252 |
| `IMPL-1243` | Implement the **perceptual** profile for photographic images within `FIL-CFG-012`, restricted to the `FIL-CFG-013` output-encoding allow-list; **never enlarge** an image and never emit a derivative larger than its source | `FIL-FR-086` | P1 | 1241 | 1252 |
| `IMPL-1244` | Select the profile **adaptively from measured input properties only**. ⛔ Refuse a caller-supplied profile: a sender must not be able to force a photographic profile onto handwritten notes | `FIL-FR-087` | **P0** | 1241 | — |
| `IMPL-1245` | **Refuse rather than emit** an unreadable derivative: when no admissible parameter set satisfies the floor, fail the processing step and keep the object out of `READY` | `FIL-FR-085`, `FIL-BR-019` | **P0** | 1242, 1249 | — |
| `IMPL-1246` | **Preserve original bytes** whenever any of the four trigger conditions in `FIL-FR-088` holds; **never overwrite** an original with a derivative | `FIL-FR-088`, `FIL-INV-012` | **P0** | 1240 | 1247 |
| `IMPL-1247` | Consume the **original-quality upload** decision as an entitlement answer over `E-19`; ⛔ never evaluate the entitlement locally and never infer it from a prior upload | `FIL-FR-089`, `FIL-XC-023` | **P0** | 1246, 1215 | — |
| `IMPL-1248` | Handle PDFs and office documents **losslessly only**: container-level optimization at most, byte-exact decompressible recovery always. ⛔ No lossy transform, no rasterization, no re-encode | `FIL-FR-090`, `FIL-BR-018`, `FIL-INV-012` | **P0** | 1240 | 1252 |
| `IMPL-1249` | Implement the processing lifecycle `RECEIVED → VALIDATING → PROCESSING → READY` / `FAILED`, with **only** `READY` and `FAILED` terminal, and an object **servable only in `READY`** | `FIL-FR-092`, `FIL-INV-013` | **P0** | 1240, 1225 | 1245, 1250, 1251 |
| `IMPL-1250` | Make processing **idempotent** under an operation key and bound retries by `FIL-CFG-014`; delegate scheduling per `FIL-XC-017` rather than building a scheduler here | `FIL-FR-093`, `FIL-XC-017` | P1 | 1249, 1226 | — |
| `IMPL-1251` | Report **progress and status** without leaking a storage path, worker identity or internal error text; make progress for an object the caller may not read **indistinguishable from a non-existent object** | `FIL-FR-094`, `FIL-XC-023` | **P0** | 1249, 1216 | — |
| `IMPL-1252` | Enforce the **stall timeout** `FIL-CFG-015` — drive a stalled `PROCESSING` object to terminal `FAILED` and delete the abandoned derivative — and build the **fixture corpus** of handwritten notes, assignments and text-heavy study material that makes `FIL-AC-080`'s readability obligation testable. ⚠ Timeout value owed by `FIL-GAP-014` | `FIL-FR-095`, `FIL-FR-085` | P1 | 1242, 1243, 1248, 1249 | — |
| `IMPL-1253` | Generate and serve **optimized serving variants** from the `FIL-CFG-007` set through the **same signed-URL and authorization path** as the source object. ⛔ A variant is not a shortcut: no variant may be reachable by a URL shape, cache key or path that the original would not have permitted | `FIL-FR-091`, `FIL-FR-083` | **P0** | 1240, 1218, 1249 | — |
| `IMPL-1254` | Build the **Wave 5 test suite**: the **18** §14.5 acceptance tests (`FIL-AC-079` … `FIL-AC-096`), the readability assertions over `IMPL-1252`'s fixture corpus, the derivative-authorization tests that prove `IMPL-1240`'s inheritance is not bypassable, and the **`FIL-XC-023`** exclusion test asserting that no video or audio transcoding path exists. ⚠ Three acceptance tests are **not passable** until `FIL-GAP-014` supplies the `FIL-CFG-010`/`011`/`015` values; they are written to fail closed rather than skipped | `FIL-AC-079` … `FIL-AC-096`, `FIL-XC-023` | **P2** | 1245, 1248, 1250, 1252, 1253 | — |

⚠ **`IMPL-1237` is deliberately NOT rewritten.** It already confines extensibility to configuration, and the six
new `FIL-CFG-*` members are admitted by that existing rule rather than by amending it — the rule working as
designed is evidence for it, not a reason to edit it.

---

## 6. Traceability — task group → requirements → invariants → acceptance

Required by allocation rule 4.

| Wave | Tasks | Requirements discharged | Invariants | Acceptance criteria |
|---|---|---|---|---|
| **1** — boundary, port, upload, validation, scanning | `IMPL-1200`…`1209` | `FIL-FR-001`…`007`, `013`…`022`; `FIL-BR-004`, `005`, `014` | `FIL-INV-001` | `FIL-AC-001`…`020` (§14.1) |
| **2** — `FileRef`, metadata, read, signed URLs, authz | `IMPL-1210`…`1219` | `FIL-FR-008`…`012`, `022`…`042`; `FIL-BR-001`, `002`, `009`, `011` | `FIL-INV-004`, `FIL-INV-005` | `FIL-AC-021`…`045` (§14.2) |
| **3** — isolation, lifecycle, derivatives, failure | `IMPL-1220`…`1229` | `FIL-FR-043`…`061`, `063`…`066`; `FIL-BR-003`, `006`, `007`, `008`, `010` | `FIL-INV-002`, `003`, `006`, `007`, `008` | `FIL-AC-046`…`068` (§14.2–§14.3) |
| **4** — sharing, boundaries, extensibility, testing | `IMPL-1230`…`1239` | `FIL-FR-030`…`033`, `062`, `067`…`082`; `FIL-BR-012`, `013`, `015`, `016`, `017`; `FIL-XC-001`…`022` | `FIL-INV-009`, `010`, `011` | `FIL-AC-069`…`078` (§14.3–§14.4) |
| **5** — media optimization, documents, variants, processing lifecycle, tests | `IMPL-1240`…`1254` | `FIL-FR-083`…`095`; `FIL-BR-018`, `019`; `FIL-XC-023` | `FIL-INV-012`, `FIL-INV-013` | `FIL-AC-079`…`096` (§14.5, by `IMPL-1254`) |

**All 13 invariants are claimed:** `FIL-INV-001` by `IMPL-1208`; `002` by `1221`; `003` by `1227`; `004` by `1218`;
`005` by `1212`; `006` by `1229`; `007` by `1225`; `008` by `1222`; `009` by `1230`; `010`/`011` by `1235`; **`012` by `1241`, `1246` and `1248`; `013` by `1240` and `1249`.** *(Advanced from 11 by the v0.2 amendment.)*

### 6.1 Coverage

| Register | Members | Claimed by ≥1 task | Coverage |
|---|---|---|---|
| `FIL-FR-*` | 95 | 95 | **100.0%** |
| `FIL-BR-*` | 19 | 19 | **100.0%** |
| `FIL-INV-*` | 13 | 13 | **100.0%** |
| `FIL-EVT-*` | 0 | — | **n/a — DECLARED EMPTY** |
| `FIL-XC-*` | 23 | 23 | **100.0%** |
| **Class A total** | **150** | **150** | **100.0%** |
| `FIL-AC-*` | 96 | 96 (78 by `IMPL-1239`, 18 by `IMPL-1254`) | **100.0%** claimed · ⛔ **0 proven** |

⚠ **This table was stale, and the staleness is what exposed a real hole rather than merely a wrong number.** Every row
still carried its v0.1 membership (82 / 17 / 11 / 22 / 132 / 78) after the v0.2 amendment had grown the registers.
Recomputing it was not a cosmetic update: the `FIL-AC-*` row attributed **all** acceptance criteria to `IMPL-1239`,
whose task row is scoped to the seven §10.3 architecture tests and `FIL-XC-001`…`022`. Simply writing *"96 by
`IMPL-1239`"* would have been the convenient repair and it would have been **false**. `IMPL-1254` was added instead.

⚠ **The same measurement then exposed a PRE-EXISTING v1.0 defect, and it is disclosed rather than quietly absorbed.**
Scanning the `Discharges` cells returned **`FIL-AC-*` cited by ZERO task rows** — not merely zero Wave 5 rows.
`IMPL-1239`'s cell read `FIL-XC-001` … `FIL-XC-022` and **nothing else**, in v1.0 as shipped (verified against the
committed text, not from memory). So this table's *"78 by `IMPL-1239`"* was a **prose claim with no allocation cell
behind it** from the day it was written: the register-coverage row asserted 100% while the mechanism that measures
coverage would have returned 0%. The v0.2 amendment did not cause this; it is only what made it visible, because
recomputing a stale table forces every row to be re-derived instead of re-read. `IMPL-1239`'s cell now carries
`FIL-AC-001` … `FIL-AC-078` explicitly, so the claim and the allocation agree. **This is the third defect in this
pass found by measurement and the only one that predates it.**

Measured after all repairs: **`FIL-AC-*` cited by task rows = 96 of 96 (78 by `IMPL-1239`, 18 by `IMPL-1254`);
Class A allocated = 150 of 150; unallocated = 0; dangling citations = 0.**

**No task claims zero obligations, and no task cites an obligation that does not exist** — every identifier above is
drawn from the inventory the owning PRD publishes — **277** at v0.2, advanced from the **232** Stage 5 froze. ⚠ *Re-verified mechanically after Wave 5, expanding range citations such as `FIL-XC-001`…`022`: **0 dangling citations, 0 unallocated Class A obligations**.*

### 6.2 Why 100% task coverage sits beside 74.7% acceptance coverage — the two are different claims

The owning PRD publishes **112 / 150 = 74.7%** acceptance coverage at v0.2 (was 94 / 132 = 71.2% at Stage 5). This document publishes **150 / 150 = 100.0%** task coverage (was 132 / 132). Both are true, and the difference is not slack:

⚠ **Both figures were RECOMPUTED after the v0.2 amendment, not scaled.** The task figure is measured by expanding every range citation in §6 and intersecting with the PRD’s Class A set: **150 allocated of 150, 0 unallocated**. It would have been easy to leave *"132 / 132"* standing — it is still a true sentence about a register that no longer exists — and the denominator moving from 132 to 150 while the claim stayed 100% is exactly the kind of coincidence that has to be **verified rather than assumed**.

- **Task coverage** asks *is this obligation somebody's work?* Every obligation is, including the 22 `FIL-XC-*`
  exclusions — now **23** of them — enforcing a prohibition is real work (`IMPL-1208`, `1231`, `1238`, `1239`), and `FIL-XC-023` is allocated to `IMPL-1247`, `IMPL-1251` and `IMPL-1254`.
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

- **It does not claim the module is implementable today.** ⚠ *`B-11` no longer blocks anything* — `ADR-0055` released `IMPL-1230`…`IMPL-1236` on 2026-08-20 — but **`B-2` still blocks *proof* of all 55**, and three Wave 5 tasks are not completable until `FIL-GAP-014` supplies the values they depend on. **0 of 55 are implemented.**
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
| An `IMPL-*` range is allocated | ✅ **`IMPL-1200` … `IMPL-1254`**, measured as free by two routes (§3.1); extended from `IMPL-1239` into the reserved band by the v0.2 amendment |
| Every task traces to requirements | ✅ **55 of 55** cite ≥1 obligation; **0** cite a nonexistent one — re-measured after Wave 5, expanding range citations |
| Rule 1 — never reuse a number | ✅ repository max was **1200**, held only as a boundary marker |
| Rule 2 — leave growth room | ✅ **`IMPL-1255` … `IMPL-1299`** (45) reserved for **15** open gaps. ⚠ *The reserve was drawn on for the first time on 2026-08-20 — Wave 5 took 15 — and the design held: **zero existing tasks renumbered**, which is the outcome rule 1 exists to protect* |
| Rule 3 — record Priority / Blocks / Blocked by | ✅ all three on all **55** rows |
| Rule 4 — add a traceability table | ✅ §6, plus per-register coverage §6.1 |

✅ **Stage 6 gate satisfied.**

---

## 12. Change history

| Version | Date | Change |
|---|---|---|
| **v1.1** | 2026-08-20 | **Wave 5 added by the `PRD-017` v0.2 amendment** (`ADR-0056`), drawn entirely from the growth reserve: **`IMPL-1240`…`IMPL-1254`, 15 tasks — and ZERO existing tasks renumbered, resplit or reassigned**, which is the outcome rule 1 exists to protect and the first real test of the 60-wide reserve §3.2 designed. Task count **40 → 55**; reserve **`IMPL-1240`…`1299` (60) → `IMPL-1255`…`1299` (45)**. ⚠ **`B-11` / `FIL-GAP-012` RELEASED for the architecture question only** by `ACCEPTED` `ADR-0055`: `IMPL-1230`…`IMPL-1236` move from ⛔ *blocked* to `Not started` and **nothing else changes** — *unblocked is not done*, none of the seven is implemented, `B-2` still gates *proof* of all 55, and the blocker rows in §4, §5.4 and §9 were **deliberately not deleted** so the record of why seven tasks sat idle survives. ⚠ **TWO allocation holes were found by measurement and each closed with a new task rather than a convenient citation:** (1) a scan of the 18 new v0.2 obligations against the `Discharges` cells returned **`FIL-FR-091` (serving variants) allocated to nothing** — appending it to `IMPL-1240` was rejected because generating and serving variants is *work*, not a property of derivative inheritance, so **`IMPL-1253`** was added; (2) a scan of every task row then returned **`FIL-AC-*` cited by ZERO Wave 5 tasks** — §6.1 attributed all acceptance criteria to `IMPL-1239`, whose row is scoped to the seven §10.3 architecture tests and `FIL-XC-001`…`022`, so writing *"96 by `IMPL-1239`"* would have been **false** and widening a Wave 4 task to absorb Wave 5 work was rejected; **`IMPL-1254`** was added instead. A misattributed prose reference (`IMPL-1248` where the entitlement work is `IMPL-1247`) was caught by the same cross-check. ⚠ **A THIRD defect surfaced and it PREDATES this amendment:** `IMPL-1239`'s `Discharges` cell cited `FIL-XC-001`…`022` and nothing else in **v1.0 as shipped**, so §6.1's *"78 AC claimed by `IMPL-1239`"* was a prose claim with **no allocation cell behind it** — the table asserted 100% AC coverage where the mechanism would have measured 0%. The cell now carries `FIL-AC-001`…`FIL-AC-078` explicitly; the defect is **disclosed in §6.1 rather than quietly absorbed**, because a pre-existing hole that a later pass silently fixes leaves no record that the original claim was unbacked. Counts **recomputed, not scaled**: invariants 11 → **13**, exclusions 22 → **23**, §6.1 per-register table refreshed from its stale v0.1 membership (82/17/11/22/132/78 → **95/19/13/23/150/96**), inventory 232 → **277**, task coverage 132/132 → **150 / 150 = 100.0%** *verified by expanding range citations* (a first per-identifier pass wrongly reported 132/150 because `FIL-XC-001`…`022` is cited as a range), AC coverage 71.2% → **74.7%**. Subject cell corrected to **v0.2 `FROZEN`**. ⚠ Three tasks (`IMPL-1242`, `1245`, `1252`) are **specified and startable but not completable** until `FIL-GAP-014` supplies `FIL-CFG-010`/`011`/`015`. ⛔ **The video/audio prohibition binds the whole wave** — `FIL-FR-005`, `FIL-XC-016`, `FIL-XC-023`; the V1 transcoding request was **refused** and recorded as `FIL-GAP-016`, and *"adaptive"* means adaptive across image and document characteristics, never across media types. **`IMPL-1237` deliberately NOT rewritten** — its existing configuration-extensibility rule already admits the six new `FIL-CFG-*` members. **No application code written; `lib/`, `packages/`, `test/`, `pubspec.yaml` still measure 0 changed lines** |
| v1.0 | 2026-08-20 | Stage 6 allocated. **40 tasks, `IMPL-1200`…`IMPL-1239`**, range computed by repository-wide scan (max in use = 1200, a boundary marker only) and confirmed against `PRD-023_IMPLEMENTATION_TASKS.md` L89. **60-wide growth reserve** for 13 open gaps. All **132** Class A obligations claimed; **0** phantom citations. Sharing tasks limited to `FIL-FR-075`…`082` + `FIL-BR-015`…`017` + `FIL-INV-009`…`011` — **no `PRD-021` work created or duplicated**. `IMPL-1230`…`1236` marked ⛔ **blocked for execution** by `B-11`/`FIL-GAP-012`. **No application code written.** `PRD_LIFECYCLE.md` L147–153 staleness disclosed, not repaired |
