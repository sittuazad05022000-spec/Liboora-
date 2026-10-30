# DP-0011 — IMPL-300: audit-reference semantics, `accountId` nullability, `DocumentRef[]` representation (BC-01)

> **⚠ STATUS: PROPOSED — NOT RATIFIED.**
> This record was prepared by an operator-convened Architecture + Domain decision panel on 2026-10-30.
> **No selection below is an approved decision for D-5, D-1, D-2.** Each becomes authoritative only when
> **both** the Architecture Owner and the Domain Owner sign the ratification block at the end of this document.
>
> **The three-field IMPL-300 increment (`tenantId`, `registeredAt`, `registrationSource`) was implemented
> under separate authorized scope and is on remote at `2f0a2d6`.** It is not subject to this record's
> ratification requirement. The tasks updated accordingly in `PRD-004_IMPLEMENTATION_TASKS.md`.
>
> No PRD, ADR, code, test or schema has been modified to reflect D-5, D-1, or D-2 selections, and none may be
> until ratification. This record has not been committed or pushed.

| Field | Value |
|---|---|
| **Type** | Decision record — three matters (D-5, D-1, D-2) |
|---|---|
| **Status** | PROPOSED · 0 signatures received |
| **Supersedes** | none |
| **Authorizes** | IMPL-300 remaining scope (upon ratification only) |
| **Sponsor / Owner** | Architecture Owner (Matter 2, Matter 3-shape) + Domain Owner (Matter 1, Matter 3-semantics) |
| **Convenor** | Product Owner (panel convened at operator direction, 2026-10-30) |
| **Parties affected** | Library Domain (BC-01); Identity & Access (BC-18) via Matter 2 |
| **Prepared** | 2026-10-30 · HEAD `fd749460b21f3d6be61140d221fefa5752d620f6`, branch `fix/opaque-cursor-pagination-h3` |
| **Updated** | 2026-10-30 · Three-field IMPL-300 increment confirmed on remote (`2f0a2d6`); task status updated; IMPL-301/IMPL-309 identified as next tasks |
| **Next review** | On receipt of the first signature, or 2026-11-13 |
| **Links** | `Student_Management_PRD_v1.md` (frozen); `Authentication_PRD_v2.md` (frozen); `MASTER_PRD.md`; `LIBOORA_BOUNDED_CONTEXT_MAP.md`; `ADR-0146` (Accepted); `DP-0010` (OPEN — adjacent, no overlap); `PRD-004_IMPLEMENTATION_TASKS.md`; completed IMPL-300 increment (commit `2f0a2d6`) |

---

## IMPL-300 three-field increment — confirmed complete (2026-10-30)

> **Authority**: Project Owner scope/priority decision (this record, L270+); task document `PRD-004_IMPLEMENTATION_TASKS.md` L179.

On `2f0a2d6` the following fields were added to `StudentRecord` under authorized scope:

| Field | Type | Authority | Status |
|---|---|---|---|
| `tenantId: TenantId` (required, non-nullable) | `TenantId` | SM-2.2 `:225`, SM-10.1 mandatory `:985`, SM-INV-8 "never null" `:319` | ✅ On remote |
| `registeredAt: DateTime` (required) | `DateTime` | SM-2.2 `:226`, SM-10.1 `:986`, SM-10.5 index `:997-998` | ✅ On remote |
| `registrationSource: RegistrationSource` (required, closed enum) | `RegistrationSource` | SM-3.8 verbatim closed set `:358-359` | ✅ On remote |

All 17 files updated; `flutter analyze` 12 pre-existing issues (zero new); full test suite `+911 ~2: All tests passed!`

**Remaining IMPL-300 scope** (blocked on DP-0011 ratification):
- `accountId: AccountId?` — D-1 (nullable, XC-4.2 state, single null→value transition) — requires ARB + Domain Owner
- `documents: List<FileRef>` — D-2 (non-nullable, `[]` valid, null forbidden) — requires ARB + Domain Owner
- Audit references — D-5 (linkage-only, no field) — requires ARB + Domain Owner

---

## Next tasks — governance analysis

### IMPL-301: `EnrollmentStatus` closed state machine

| Property | Value |
|---|---|
| **Authority** | `PRD-004_IMPLEMENTATION_TASKS.md` L59 |
| **Requirements** | `SM-2.5`–`SM-2.13` — no accountId, no DocumentRef, no audit references |
| **Dependency** | `IMPL-300` (partial — three-field increment sufficient per Project Owner scope decision) |
| **Blocked?** | **No** — structurally independent of D-1, D-2, D-5; pending Project Owner confirmation that partial IMPL-300 satisfies the dependency |
| **Encoding** | `CONF-1` — test must **fail** if `Expired` is accepted; BC Map L209 assigns `Expired` to `BC-02` |

**Structural independence rationale**: `EnrollmentStatus` is a closed enum (`:19-27` in `student_record.dart`). Its SM-2.5–SM-2.13 requirements govern transitions and invariants on that enum. None of SM-2.5–SM-2.13 references `accountId`, `DocumentRef[]`, or audit references. The three-field increment (`tenantId`, `registeredAt`, `registrationSource`) establishes the `StudentRecord` constructor that `EnrollmentStatus` validation guards — sufficient for IMPL-301 to begin.

**Test requirement**: Reject `Expired` state; reject illegal transitions. `EnrollmentStatus.confirmed` and `.archived` are V1 states; `Expired` belongs to `BC-02`.

### IMPL-302: Schema + unique constraints + indexes

| Property | Value |
|---|---|
| **Authority** | `PRD-004_IMPLEMENTATION_TASKS.md` L60 |
| **Requirements** | `SM-10.1`–`SM-10.6` |
| **Dependency** | `IMPL-300` (partial — schema exists; nullability pending D-1) |
| **Blocked?** | **No** — SM-10.1 provable with provisional schema; `OWN-4` test independent of nullability |
| **Note** | `account_id` nullability deferred to D-1 ratification; provisional schema uses nullable pending confirmation |

### IMPL-309: Document `FileRef` via `E-22`

| Property | Value |
|---|---|
| **Authority** | `PRD-004_IMPLEMENTATION_TASKS.md` L85 |
| **Requirements** | `SM-4.9`–`SM-4.12` |
| **Dependency** | `IMPL-300` (partial — `StudentRecord` aggregate exists) |
| **Blocked?** | **No** — SM-4.9/SM-4.12 are ratified requirements (element-level FileRef invariance per SM-INV-10 `:321`); D-2 determines the container type (`List<FileRef>`) but not the element type or the E-22 port contract |
| **Authority note** | D-2/B1 (`List<FileRef>`) confirms element type but does not change SM-4.9/SM-4.12 authority |

---

## Priority ordering removed

The `D-5 → D-1 → D-2` ordering in prior audit records was **not an authorized priority decision** and has been removed. No governance document assigns this precedence. Each matter proceeds to ratification independently.

---


The verified IMPL-300 audit left three SM-2.2 MUST-hold items unresolved. This record documents the
convened panel's determinations — **as proposals** — for:

| # | Matter | Audit ID | Selection (PROPOSED) |
|---|---|---|---|
| 1 | Meaning of SM-2.2 *"audit references"* | D-5 | **Option C** — linkage-only; no aggregate field |
| 2 | `accountId` nullability | D-1 | **Option A1** — nullable `AccountId?`; null only in the XC-4.2 unclaimed state; single null→value transition |
| 3 | `DocumentRef[]` representation | D-2 | **Option B1** — non-nullable bare `List<FileRef>`; empty `[]` valid; null forbidden |

---

## Matter 1 (D-5) — SM-2.2 *"audit references"*: proposed Option C (linkage-only, no aggregate field)

### Question
What does the final item of SM-2.2's MUST-hold list (`Student_Management_PRD_v1.md:227`) require of
`StudentRecord`?

### Evidence (verified)
- *"audit references"* occurs **exactly once** in PRD-004 (`:227`) and is defined nowhere in it (full-document search).
- The only other repository use treats the identical term as **tenant-partitioned pointers into audit
  infrastructure**, enumerated alongside artifacts — *"emitted events · idempotency keys · caches ·
  projections · exports · audit references"* — not as an entity field: ATT-FR-124, `PRD-006_ATTENDANCE-MANAGEMENT.md:2029-2033`.
- SM-6.6 (`:688-689`): *"History **MUST** be read from `BC-24` Audit Trail … this module **MUST NOT** maintain a parallel audit store."*
- SM-8.10 (`:908-910`): the actions that MUST be audited; SM-8.11 (`:912-913`): entry content — actor, role,
  tenant, target `studentRecordId`, action, timestamp, correlation ID, reason; SM-8.12 (`:915-916`): append-only (X-10).
- `AuditEntry` (`lib/platform/audit/audit.dart:9-27`) carries a stable id minted at append (`:46`, `audit_*`)
  and `target` holding the studentRecordId. Entries are created **asynchronously after** `repo.save` via the
  composition-root-wired event drain (`audit.dart:65-75`; `enrollment.dart:404-424`).
- `created_by`/`updated_by` are Rank-1 platform-wide **"All"**-entity column standards (§19 Data Standards,
  `MASTER_PRD.md:386-399`) — uniform persistence metadata, not BC-01-specific aggregate semantics.
- An uncheckable rule cannot be treated as satisfied — SID-4.56 principle, `Student_Management_PRD_v1.md:882`.

### Options considered
| Option | Description | Disposition |
|---|---|---|
| A | Aggregate field holding BC-24 entry ids | **Rejected.** Audit ids are minted *after* the aggregate is saved (`audit.dart:65-75`); holding them requires a post-construction mutation path that does not exist, and caching audit state on the aggregate creates a second read path and a parallel-store risk directly against SM-6.6 (`:688-689`). |
| B | Aggregate alias for the SM-10.1 `created_by`/`updated_by` columns | **Rejected.** Those are Rank-1 "All"-entity persistence standards (`MASTER_PRD.md:386-399`), owned at schema level by IMPL-302 (`PRD-004_IMPLEMENTATION_TASKS.md:60`); aliasing them into SM-2.2 would duplicate IMPL-302 scope and contradict the uniform-standard reading. |
| C | **Linkage-only** — the term names the record↔BC-24 linkage that already exists structurally: every audit action on the record is locatable via `AuditEntry.target` = the record's id; no member is added | **PROPOSED.** |

### Rationale (proposed)
C is the only reading with **zero conflict against any ranked document**: it preserves SM-6.6's single
canonical read path, matches the PRD-006 lexical precedent, and adds no lifecycle impossible under the
outbox pattern. SID-4.56 is satisfied because C carries a **checkable form**: *every SM-8.10 action on a
record MUST produce a BC-24 entry whose `target` equals that record's id, with SM-8.11 content* —
mechanically verifiable against `audit.dart:9-27,46`.

### Conflicts evaluated
- vs SM-2.2's *"MUST hold"*: the aggregate "holds" its audit linkage in BC-24, the store SM-6.6 designates
  as canonical — the same document's §6 governs the reading of §2.2's item. Recorded as the interpretation
  of a frozen requirement, **not** an amendment to it.
- vs SM-6.5 (`:685`): member history remains fully served by read-through to BC-24; no surface impact.
- vs `Membership.createdBy` aggregate precedent (`membership.dart:138,576`): **not transferable** — a
  different aggregate's design decision, explicitly excluded as an authority for `StudentRecord`.

### Impact
- IMPL-300: the SM-2.2 item is satisfied by interpretation; no field, no codec key, no constructor change.
- Enforcement of the checkable form belongs to the audit/history surfaces (IMPL-316/IMPL-319 scope).
- Compatibility: none (no persisted-representation change).

### Review conditions
- Ratification must be **joint** (Architecture + Domain Owner): the reading of a frozen §2.2 item is a
  domain-semantics act.
- If either owner selects A instead, an explicit SM-6.6 reconciliation and an async-linkage lifecycle
  design must accompany it — that combination requires its own record.

---

## Matter 2 (D-1) — `accountId` nullability: proposed Option A1 (nullable, single transition)

### Question
Is `accountId` (SM-2.2, `:225-227`; SM-10.1 `account_id`, `:985-987`) nullable or non-nullable on
`StudentRecord`?

### Evidence (verified)
- SM-2.2 lists `accountId` **unannotated** in a list that annotates deliberately when it means it:
  `personId` *(non-nullable)* (`:229`/SM-2.3), `GuardianLink?`, `LibraryIdentificationPhoto?` (`:225-227`).
- SM-10.1 uses **three distinct qualifiers in one sentence** — *"**mandatory** `tenant_id`; `person_id`
  NOT NULL; `account_id`"* — and applies **neither** to `account_id` (`:985-987`).
- Rank-3 (frozen): *"**Student record exists without an account** — The record remains unclaimed and
  inert. It confers nothing until claimed. Library staff may continue to operate on it"* — XC-4.2,
  `Authentication_PRD_v2.md:1424`; anticipated by AUTH-4.23 (`:1271`).
- Rank-4: *"`AccountId` resolution on login; **Enrollment stores it, never mutates it**"*
  (`LIBOORA_BOUNDED_CONTEXT_MAP.md:315`).
- ADR-0146 (Accepted): a provisioned-but-unbound account remains `Provisioned` (PO-3 = A, `ADR-0146:205`).
- MP-GBR-01: *"Every student has one **Account**"* (`MASTER_PRD.md:315`).
- Non-credential: `AccountId extends Identifier` (`identifiers.dart:53`) is an opaque entity identifier —
  SM-XC-1 (`:199`) and SM-INV-11 (`:322`) target authentication secrets; SM-AC-4's schema scan (`:1060`)
  targets credential columns.
- Current flow provisions an account before every enrollment and **discards** the id
  (`di.dart:586`, `:600`); `EnrollStudent` accepts no `accountId` (`enrollment.dart:345-353`).

### Options considered
| Option | Description | Disposition |
|---|---|---|
| A1 | Nullable `AccountId?`; null only in the XC-4.2 unclaimed state; at most one null→value transition | **PROPOSED.** |
| A2 | Required non-nullable | **Rejected.** Renders frozen Rank-3 XC-4.2 unimplementable in BC-01 without a cross-PRD reconciliation act; contradicts SM-10.1's deliberate omission of `NOT NULL`; forces old-row decode failures for no demonstrated benefit (the V1 flow always supplies a value). |

### Proposed null-state definition (the panel's determinative addition)
- **Null-allowed state**: exactly XC-4.2's *unclaimed-and-inert* record state (no account exists).
- **Transition**: at most **one** — null → `AccountId` at provision/claim; never the reverse; never
  reassignment (BC Map L315: stored, never mutated).
- **V1 shipped flow**: the provision step always supplies the value at construction, so null is a
  type-level allowance for the XC-4.2 state, not a new V1 path.

### Rationale (proposed)
A1 is the only option consistent with frozen XC-4.2; it respects SM-10.1's qualifier system (the PRD says
`NOT NULL` when it means it); it is reversible (A2 remains available later as a tightening, if XC-4.2 is
ever superseded); and it breaks no persisted row.

### Conflicts evaluated
- vs SM-2.2 `?`-less listing: outweighed — the same list's `?` marks *optional-in-all-states* fields
  (guardian for adults, photo for no-photo); `accountId` is present in every state except the XC-4.2
  state, so `?` would overstate absence. Explicit non-nullability is used where intended (`personId`) and
  was declined here.
- vs MP-GBR-01: no conflict — the platform invariant is satisfied via the provision/claim flow
  (AUTH-4.23–4.28); nullability governs the interim XC-4.2 state only.
- vs SM-3.1 / SM-3.2 / BC Map L315 / L461: no conflict — storage ≠ creation; the composition-root
  provision flow's boundary status is separately documented (`BOUNDARY_CHECKER_DESIGN.md:132-133` import
  exemption is not a functional exemption) and is **not** reopened by this record.
- vs DP-0010 DR-2 (BC-10 field storage): **no overlap** — `accountId` is absent from SM-4.2's BC-10-owned
  list, exactly as `phone` is (`DP-0010:86`).

### Impact
- Constructor, codec key (`as String?` — zero old-row impact), IMPL-302 column parity.
- **Population wiring is NOT authorized by this record**: the E-11 return widening
  (`di.dart:586-600` → `EnrollStudent` parameter) remains **IMPL-306 scope** and requires its own
  task-level approval.
- Tenant isolation: neutral — `AccountId` is global-class; the reference is stored, never mutated (ID-2
  permits the reference; BC Map L315 mandates it).

### Review conditions
- Joint signature required (Architecture + Domain Owner) — cross-PRD tension (PRD-004 vs Authentication PRD).
- The single-transition rule must be restated in the implementation task before any code change.

---

## Matter 3 (D-2) — `DocumentRef[]` representation: proposed Option B1 (bare `List<FileRef>`, non-nullable, `[]` valid)

### Question
What Dart declaration implements SM-2.2's `DocumentRef[]` (`:226`, SM-4.1 `:410-411`), and what does a
record with no documents hold?

### Evidence (verified)
- Element type invariant-forced: *"Every document **MUST** be stored as a `FileRef` issued by `BC-29`
  through `E-22`"* — SM-4.9 (`:482`); *"Every document **is** a `FileRef`, never bytes"* — SM-INV-10
  (`:321`), schema-scan-verified by SM-AC-27 (`:1083`); BC Map E-22: *"Domain holds a `FileRef`, never
  bytes or a raw storage path"* (`LIBOORA_BOUNDED_CONTEXT_MAP.md:331`).
- BC Map names `DocumentRef` verbatim as a BC-01 value object (`:370`, quoted `PRD-004:223`).
- The executable E-22 contract carries **only** `FileRef` — `FileAccess.resolve(BoundedContextId, FileRef)
  → FileRef?` (`packages/liboora_contracts/lib/src/ports/file_access.dart:156-179`, signature `:174`);
  no document-metadata type exists in the contract; no `DocumentRef` class exists in the repository.
- BC Map value objects decompose in practice: `ContactDetails` is shipped as scattered
  `fullName`/`phone`/`email` with no class (`student_record.dart:66-69`).
- `photoRef: FileRef?` (`student_record.dart` codec key `'photoRef'`, `codecs.dart`) satisfies the
  **separate** Library Identification Photo item (SM-4.3) — not this one.
- Document attach/remove is protected operation SM-PO-9 (`:875`) — IMPL-319 scope; DP-0010 DR-1
  (field-level authorization, `DP-0010:52-64`) sits directly on this field.

### Options considered
| Option | Description | Disposition |
|---|---|---|
| B1 | Bare `List<FileRef>`, non-nullable; constructor-required; empty `[]` is the legitimate initial value | **PROPOSED.** |
| B2 | Named `DocumentRef` wrapper (extends or contains `FileRef`) | **Not selected — not foreclosed.** The BC Map names the value object, but the PRD defines **zero content** for a wrapper (the E-22 port exposes none); a wrapper today would be content-free. B2 remains available as a mechanical element-type refactor if a future PRD defines document metadata. |

### Null/empty determination (proposed)
- **Empty `[]` is valid and is the initial value at enrollment** (documents attach later via SM-PO-9).
- **Null is forbidden**: the SM-2.2 listing is `?`-less; the same list's `?` marks optional-in-all-states
  fields; and unlike `accountId`, **no ranked document contemplates an absent collection state** — only a
  zero-document record. Empty list and null are **not** the same thing, and this record treats them as
  distinct on purpose.
- Constructor convention: the parameter is **required** (caller supplies the possibly-empty list
  explicitly), matching the convention of every other MUST-hold field just implemented
  (`student_record.dart:39-47` — `tenantId`, `registeredAt`, `registrationSource`).

### Rationale (proposed)
B1 is minimal, invariant-forced at the element level, matches the executable contract, and follows the
repository's own decomposition precedent; choosing it now forecloses nothing.

### Conflicts evaluated
- vs BC Map L370's `DocumentRef` value-object name: resolved by the `ContactDetails` decomposition
  precedent — BC Map names are conceptual; B2 reopening is conditioned on a future metadata definition.
- vs SM-INV-10's *"is a `FileRef`"*: a `DocumentRef extends FileRef` wrapper would also satisfy the
  invariant — recorded honestly as the reason B2 stays open rather than being declared invalid.
- vs IMPL-319 / DP-0010 DR-1: sequencing benefit only — settling the shape first avoids reworking
  authorization logic over the field later.

### Impact
- Constructor + codec key (`List<String>` of FileRef values); strict codec read → **old rows missing the
  key fail decode and are skipped at boot** (`data.dart:226-230`) — the same accepted compatibility class
  as the three implemented fields; recorded as accepted, not silent.
- **Schema representation is NOT decided here**: SM-10.1's column list (`:985-987`) contains **no
  documents column** — child table vs JSON column is IMPL-302 scope and requires its own decision at
  IMPL-302 implementation time.

### Review conditions
- Architecture Owner signs for the shape; Domain Owner signs for the null/empty semantics — both
  signatures required.

---

## Consolidated selection summary (ALL PROPOSED — NONE RATIFIED)

| Matter | Selection | Null/empty rule | Compat. class | Ratification |
|---|---|---|---|---|
| D-5 | C — linkage-only, no field | n/a | none | Architecture + Domain |
| D-1 | A1 — nullable `AccountId?` | null only in XC-4.2 unclaimed state; single null→value transition | zero (optional codec read) | Architecture + Domain |
| D-2 | B1 — bare `List<FileRef>` | `[]` valid initial value; null forbidden; constructor-required | old-row decode-skip (accepted) | Architecture (shape) + Domain (semantics) |

---

## RATIFICATION BLOCK — explicit human signatures required

> This record must not be marked RATIFIED, and no implementation may proceed from it, until **both**
> owners below have signed. Signatures must not be fabricated, assumed, or entered by any agent.

| Role | Name | Decision (Approve / Amend / Reject per matter) | Date | Signature |
|---|---|---|---|---|
| **Architecture Owner** (Matters 1, 2, 3) | ______________ | Matter 1 (D-5 C): ☐ ☐ ☐ · Matter 2 (D-1 A1): ☐ ☐ ☐ · Matter 3 (D-2 B1): ☐ ☐ ☐ | ______ | ______________ |
| **Domain Owner** (Matters 1, 2, 3) | ______________ | Matter 1 (D-5 C): ☐ ☐ ☐ · Matter 2 (D-1 A1): ☐ ☐ ☐ · Matter 3 (D-2 B1): ☐ ☐ ☐ | ______ | ______________ |

*(☐ ☐ ☐ = Approve / Amend / Reject.)*

---

## Decision history

| Date | Change |
|---|---|
| 2026-10-30 | Opened as **PROPOSED**: three matters (D-5 → C, D-1 → A1, D-2 → B1 with `[]`-not-null) determined by the operator-convened Architecture + Domain panel; zero signatures; verdict **AWAITING RATIFICATION**; no implementation, no commit, no push |
| 2026-10-30 | **Project Owner decision recorded** (panel Convenor, scope/priority authority per `PRD_OWNERSHIP_MODEL.md` L83): confirmed D-5/C, D-1/A1, D-2/B1 as the correct scope for IMPL-300; priority ordering D-5→D-1→D-2 accepted; no structural approval claimed — see §below |

---

## Project Owner scope decisions — panel Convenor authority (2026-10-30)

> **Authority notice — read before relying on this section.**
> This section records the **Product Owner** (panel Convenor) exercising their scope/priority/acceptance
> authority per `PRD_OWNERSHIP_MODEL.md` L83: *"Whether a requirement is correct and in scope."*
>
> It does **not** record Architecture Owner or Domain Owner approval of any matter's substance.
> The ratification block above (L237-248) is the only authoritative record of ARB/Domain Owner decisions.
> **This section is not a substitute for those signatures.**

### Decisions recorded (Product Owner, scope/priority authority only)

| Matter | Decision | Scope/priority basis | Structural authority required |
|---|---|---|---|
| **D-5** — audit references | Confirmed: Option C (linkage-only, no aggregate field) is the correct scope for IMPL-300 | D-5/C is within IMPL-300 scope; priority D-5→D-1→D-2 ordering accepted | **Yes** — domain-semantics reading of frozen SM-2.2 requires **Architecture Owner + Domain Owner** (joint) per review conditions L87-88 |
| **D-1** — `accountId` nullability | Confirmed: Option A1 (nullable `AccountId?`, XC-4.2 state, single null→value transition) is the correct scope for IMPL-300 | D-1/A1 is within IMPL-300 scope; cross-PRD dimension acknowledged and accepted as scope item | **Yes** — `accountId` cross-PRD nullability is a structural/boundary matter requiring **Architecture Owner + Domain Owner** per review conditions L157-159 |
| **D-2** — `DocumentRef[]` representation | Confirmed: Option B1 (non-nullable `List<FileRef>`, `[]` valid, null forbidden) is the correct scope for IMPL-300 | D-2/B1 is within IMPL-300 scope; element-type invariance accepted as a constraint | **Yes** — field representation shape is a structural matter; **Architecture Owner** (shape, L221-223) and **Domain Owner** (semantics, L221-223) both required |

### Governance status of each matter

| Matter | Project Owner scope confirmation | ARB/Domain Owner structural approval | Document status |
|---|---|---|---|
| D-5 (audit references) | ✅ Recorded this section | ⏳ Pending — requires Architecture Owner + Domain Owner joint | `PROPOSED` — not RATIFIED |
| D-1 (`accountId` nullability) | ✅ Recorded this section | ⏳ Pending — requires Architecture Owner + Domain Owner joint | `PROPOSED` — not RATIFIED |
| D-2 (`DocumentRef[]` representation) | ✅ Recorded this section | ⏳ Pending — requires Architecture Owner (shape) + Domain Owner (semantics) | `PROPOSED` — not RATIFIED |

**DP-0011 remains `PROPOSED — NOT RATIFIED` until both ARB and Domain Owner sign the ratification block above.**

The Project Owner's scope decisions above authorize the IMPL-300 task to proceed **only for the interpretation/analysis phase** — they do not authorize code, schema, or codec changes, which require ratification per L5-8.

---

