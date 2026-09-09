# `ADR-0125` — Mechanical **detection criteria** for `SID-INT-5`, `-6`, `-8`, `-9`, `-10`, `-11`: the `IMPL-220` specification gap closed

| Field | Value |
|---|---|
| **ADR** | `ADR-0125` |
| **Title** | Mechanical detection criteria for `SID-INT-5`, `-6`, `-8`, `-9`, `-10`, `-11` (`IMPL-220`) |
| **Date** | 2026-09-08 |
| **Status** | **`ACCEPTED`** — by **direct, joint conferral from the human principal**, **for one act only**: *"Define and record the mechanical detection criteria required to implement the already-existing `SID-INT-5`, `SID-INT-6`, `SID-INT-8`, `SID-INT-9`, `SID-INT-10` and `SID-INT-11` rules."* ⛔ No ARB quorum, attendee list, sign-off date or Security review is asserted |
| **Decision by** | **Architecture Owner + `BC-10` Domain Owner**, jointly. ⭐ **Two offices, because the act has two limbs**: the *detection method* is an Architecture Owner matter (`PRD_OWNERSHIP_MODEL.md` **L85** — *"Boundaries, ranks, permitted edges, precedence"*), and *whether a criterion faithfully expresses a `BC-10` rule* is a Domain Owner matter (**L84** — *"Correctness of the PRD **within its bounded contexts**; ubiquitous language; invariants"*). The `ADR-0011` *"three roles for one decision"* precedent |
| **One-act conferral** | **One**, jointly held, 2026-09-08. ⛔ **Not a standing licence** (`ADR-0033` §7.1). Expires on recording; both offices revert to their prior state. ⛔ **No holder appointed, no personal name recorded** (`PRD_OWNERSHIP_MODEL.md` §7 rule 4) |
| **Subject** | **How** the six already-existing rules are mechanically detected — ⛔ **not what they forbid** |
| **Supersedes** | **Nothing** |
| **Amends** | ⛔ **Nothing.** No PRD, no BC Map, no Dependency Matrix, no manifest, no EA, no `MASTER_PRD.md`, no other ADR — the **`ADR-0058` / `ADR-0119`…`ADR-0124` shape**: a decision recorded **in the ADR itself** |
| **Amended by** | — |
| **Does NOT amend** | **`Student_Identity_PRD_v1.md`** (Rank 3, declared baseline) — ⛔⛔ **`SID-INT-1`…`SID-INT-12` are BYTE-UNCHANGED and their meaning is unchanged; §4.16's `Detection` column is NOT rewritten**; ⛔ **0** `SID-*`, `SID-BR-*`, `SXC-*`, `SPO-*`, `SEV-*`, `SID-INV-*`, `SCFG-*` or `SID-AC-*` identifiers minted, moved or altered · `MASTER_PRD.md` (Rank 1) · **BC Map** (Rank 4) · **Dependency Matrix** (Rank 4) · `ARCHITECTURE_RULINGS.md` (Rank 5) · the EA (Rank 6) · **`tool/module_dependencies.yaml`** · **`tool/check_module_boundaries.dart`** · `PRD-001` · `PRD-006` · `PRD-012a` · every other frozen PRD · **`ADR-0014`** · ⛔ **`ADR-0119`, `ADR-0120`, `ADR-0121`, `ADR-0122`, `ADR-0123`, `ADR-0124`** · `ADR-0011` · `IMPL-220` · `TASK-D10` |
| **Baseline** | Written against **`BASELINE-2026-09-03-A`**. ⛔ **Not admitted to it and no baseline identifier is re-issued** — `DOCUMENTATION_BASELINE.md` §7 rule 4 moves it only when a **Rank 1–3** document changes version, and this ADR changes none (§9.2) |
| **Closes** | ⭐ **The `IMPL-220` DETECTION-SPECIFICATION gap for the six named rules only.** All six now have an explicit, mechanically reproducible criterion (§3–§8) |
| **Does NOT close** | ⛔⛔ **`BLK-03` / `IMPL-220` itself** — no checker is implemented (§10) · ⛔ **`SID-4.56`**: until the checks *run*, all twelve rules remain **unmet, not satisfied** · ⛔ **two prerequisite artifacts do not yet exist** and are **NOT created here** (§9.1: the `SID-INT-9` repository allow-list and the `SID-INT-10` index-field declaration) · ⛔ `SID-INT-1`, `-2`, `-3`, `-4`, `-7`, `-12` — outside this conferral (§2.2) · ⛔ `BLK-01`, `BLK-02`, `BLK-04`, `BLK-05`, Item 7a, Item 9b, the `ADR-0123` residues |
| **Related** | `Student_Identity_PRD_v1.md` **§4.16** (**L1049–1066**), `SID-4.56`, `SID-2.28`, `SID-4.6`, `SID-4.9`, `SID-4.13`, `SID-4.39`, `SID-4.44`, `SID-INV-5`, `SID-INV-11`, `SID-AC-14`, `SID-AC-20`, `SXC-7` · `MASTER_PRD` `MP-GBR-26` (**L380**) · BC Map `E-20` (**L329**), `E-13`, `ID-1`, `ID-2` · Dependency Matrix `X-04`, `X-07`, `X-08`, `X-13` · `ARCHITECTURE_RULINGS.md` `AR-1` · **`ADR-0014`** (the *"read the manifest that already existed"* precedent) · `IMPL-220` · `ADR-0011` |
| **Implementation authorised** | ⛔ **No** |

> ⚠⚠ **READ THIS FIRST.** This ADR defines **HOW** six existing rules are detected. It does **not** change
> what any `SID-INT` rule forbids, does **not** create a `SID-*` requirement, does **not** edit the checker
> or the manifest, does **not** add a dependency, and does **not** touch application or domain code.
> ⛔ **It authorises no checker implementation.** ⭐ **A detection criterion is not a check.**

---

## §1 The gap this closes, measured before deciding

⭐ **`SID-4.56` (L1064–1066) is the governing principle and it is quoted, not paraphrased:**

> *"Every row above **SHALL** be enforceable by the module boundary checker (`IMPL-014`) once it exists,
> and **SHALL** be verified by review until then. A rule that cannot be checked **SHALL** be treated as
> unmet, not as satisfied by intent."*

⭐ **`IMPL-014` exists** (`tool/check_module_boundaries.dart`, twelve categories, `ADR-0014`). ⛔ **But it
contains `0` occurrences of `SID-INT`** — measured. And §4.16's own `Detection` column routes six rows to
methods a checker cannot execute as written:

| Rule | §4.16 `Detection` column, verbatim | Mechanically executable as written? |
|---|---|---|
| `SID-INT-5` | *"Field + payload scan"* | ⚠ **Partly** — names the method, not the field set |
| `SID-INT-6` | *"Code review + revocation test"* | ⛔ **No** — *"code review"* is not a check |
| `SID-INT-8` | *"Code review"* | ⛔ **No** |
| `SID-INT-9` | *"Repository allow-list"* | ⛔ **No** — the allow-list **does not exist** |
| `SID-INT-10` | *"Index schema review"* | ⛔ **No** — no index schema exists |
| `SID-INT-11` | *"Layer check"* | ⚠ **Partly** — names the method, not the criterion |

⛔ **The other six rows are already executable and are NOT touched** (§2.2).

### 1.1 ⭐ The method: read the authority that already exists

⭐ **`ADR-0014` is the governing precedent** and its own words set the standard:

> *"The fix was to **read the manifest that already existed**, not to add a rule or to soften one."*

⭐ **Every criterion below is derived from an existing, quoted authority** — a `SID-*` requirement, a Rank-1
global rule, a BC Map edge or a Dependency Matrix prohibition. ⛔ **Nothing is invented.** Where an
authority is genuinely absent, the criterion says so and routes it (§9.1) rather than filling the hole.

---

## §2 Scope

### 2.1 What this act decides

⭐ **Detection semantics only**, for exactly six rules: `SID-INT-5`, `-6`, `-8`, `-9`, `-10`, `-11`.

For each, six things are fixed, as the conferral required: **(1)** the artifact inspected, **(2)** what is a
violation, **(3)** what is compliance, **(4)** the evidence the checker must use, **(5)** what must **NOT**
be treated as a violation, **(6)** the method class.

### 2.2 ⛔ What this act does NOT decide

| Excluded | Why |
|---|---|
| **The substance of any `SID-INT` rule** | ⛔ Outside the conferral, which says *"This authority does **NOT** authorize changing the underlying `SID-INT` rules."* All twelve are byte-unchanged |
| **`SID-INT-1`, `-2`, `-3`, `-4`, `-7`, `-12`** | ⛔ Not named in the conferral. ⭐ They are already executable: `-1`/`-7` by `banned_imports`, `-2` by the rank check, `-3`/`-4` by `banned_symbols` — **`-3` and `-4` were probe-verified to fire today**. ⚠ They currently report under `ID-2`/`X-05` rather than under a `SID-INT` label; **making them *identifiable* is a separate act** (§9.3) |
| **The checker implementation** | ⛔ Expressly excluded |
| **The two missing artifacts** | ⛔ §9.1 — recorded, owned and routed; **not created** |
| **Any new `SID-*` requirement** | ⛔ **0** minted |

### 2.3 A naming note

The labels `SID-DET-5`, `-6`, `-8`, `-9`, `-10`, `-11` below are **ADR-local citation labels** for the
*criteria*, on the `EVT-PERS-1` / `EVT-AUTHZ-1` pattern established by `ADR-0120`…`ADR-0124`. ⛔ They are
**not** `SID-*` requirements, **not** added to any PRD register, and **not** entered in the traceability
matrix. The numbering deliberately mirrors the rule each serves.

---

## §3 ⭐⭐ `SID-INT-5` — storing a mobile number, OTP, session or credential

**Rule (unchanged):** *"Storing a mobile number, OTP, session or credential"* · Rule `ID-1` · Detection
*"Field + payload scan"*.

> **`SID-DET-5` — Lexical scan of declared member names and string literals in `domain/person`, plus of
> every declared `SEV-*` event payload field, against the four credential classes `ID-1` names.**

| | |
|---|---|
| **1 · Artifact inspected** | Every `.dart` file resolving to module `domain/person`; specifically **declared field and getter names**, **constructor parameter names**, and **declared event payload field names** |
| **2 · Violation** | A declared member name, in code (not comment), matching any token in the **credential-class set** below |
| **3 · Compliance** | The credential is **absent** from this module and obtained read-through from `BC-18` per `SID-4.13` — *"the verified mobile number as a **read-through value** owned by"* `BC-18` |
| **4 · Evidence** | ⭐ **The credential-class set is NOT invented.** It is the intersection of two existing authorities: `SID-INV-5` (**L1307**) — *"No credential, OTP, session, device record or mobile number exists in this module's schema, events, logs or indices"* — and the manifest's already-declared `global.observability_plane.banned_content`: *"mobile number, in any form or transform · challenge value, current, expired or hashed · session token or any revalidating material · device secret · key material"*. The manifest already bans `mobileNumber` and `otp` as `banned_symbols` on `domain/person`; **this criterion states that the same four classes apply to declared members, which `SID-INV-5` already asserts** |
| **5 · NOT a violation** | ⛔ **Comments and doc-comments** — `person.dart` **L21–22** legitimately names `StudentRecordId`/`TenantId` in prose to explain their absence; the checker's existing `_stripComment` must be applied. ⛔ **A port or interface *type* whose implementation lives in `BC-18`** — a read-through accessor is what `SID-4.13` requires. ⛔ **`AccountId`**, which `person.dart` holds by design: *"Held so the uniqueness constraint is expressible; **it is not a credential**"*. ⛔ **A `FileRef`/`avatarRef`** — an opaque reference, not key material |
| **6 · Method class** | **Lexical**, comment-stripped, on declarations — the existing `banned_symbols` mechanism's scope, extended from symbol occurrence to declared-member names |

⚠ **What this criterion does NOT claim.** It cannot detect a credential stored under a **misleading name**
(e.g. `note` holding an OTP). ⭐ **That limit is disclosed, not hidden**: `SID-INV-5` remains broader than
its check, and `SID-4.56`'s *"unmet, not satisfied"* discipline continues to apply to the residue. ⛔ **The
rule is not narrowed to match the check.**

---

## §4 ⭐⭐ `SID-INT-6` — caching an authorisation decision

**Rule (unchanged):** *"Caching an authorisation decision"* · Rules `MP-GBR-26`, `X-13` · Detection *"Code
review + revocation test"*.

> **`SID-DET-6` — Structural check: within `domain/person`, the value returned by the declared
> `platform/identity:policy_decision` port MUST NOT be assigned to any field, static, top-level variable,
> collection or memo; it may only be consumed within the invoking expression or local scope.**

| | |
|---|---|
| **1 · Artifact inspected** | Every `.dart` file in `domain/person`: call sites of the declared `policy_decision` port, and the storage destination of their results |
| **2 · Violation** | **Any of:** (a) a `policy_decision` result assigned to an instance field, static field or top-level variable; (b) inserted into a `Map`/`List`/`Set`; (c) a declared member whose name matches a cache idiom (`*cache*`, `*cached*`, `*memo*`) **and** whose type is an authorisation result; (d) any local `Map`/`Set` keyed by subject identity that holds an authorisation result |
| **3 · Compliance** | The decision is obtained per request and consumed in place — `SID-AC-20` (**L1382**): *"Every authorisation decision is obtained from `BC-18` **per request and never cached**; revoking access takes effect on the next request"* |
| **4 · Evidence** | ⭐ **Four independent authorities converge and none is invented.** Rank-1 **`MP-GBR-26`** (**L380**): *"Session revocation is **immediate and global** — authoritative-or-absent, **with no propagation window**."* `SXC-7` (**L190**) lists *"Authorisation decisions, or caching one"* as **excluded from this module and owned by `BC-18`**. `SID-AC-20`. And the **manifest already declares the constraint on the port itself** — `domain/person`'s `ports:` entry reads `platform/identity:policy_decision  # ask BC-18 per request; never cache (MP-GBR-26)`. ⭐ **The rule is already in the manifest as a comment; this criterion makes it checkable without adding it** |
| **5 · NOT a violation** | ⛔ **Holding the port *interface* itself** as a constructor-injected field — that is the required dependency-injection shape, not a cached decision. ⛔ **A local variable used once within the same method** — consuming a decision is not caching it. ⛔ **Caching a non-authorisation value** (e.g. a settings value). ⛔ **`SID-5.x` latency targets** — `L1163` forbids meeting them by caching, which this criterion enforces rather than relaxes |
| **6 · Method class** | **Structural** (assignment-destination analysis), with a **lexical** cache-idiom sub-check. ⚠ **Not** call-graph based |

⚠ **The *"revocation test"* limb of §4.16's Detection column is preserved, not replaced.** `SID-DET-6`
covers the *"code review"* limb only. ⭐ A behavioural revocation test remains required by `SID-AC-20` and is
**test authority, not checker authority** — outside this act and **not** cancelled by it.

---

## §5 ⭐⭐ `SID-INT-8` — calling `BC-24` synchronously from domain code

**Rule (unchanged):** *"Calling `BC-24` synchronously from domain code"* · Rule `E-20` · Detection *"Code
review"*.

> **`SID-DET-8` — Structural check: `domain/person` MUST NOT import, reference as a type, or hold as a
> collaborator any `platform/audit` symbol. Audit facts leave this module only as outbox-delivered events.**

| | |
|---|---|
| **1 · Artifact inspected** | Imports, declared types, constructor parameters and field types in `domain/person` |
| **2 · Violation** | An import of `platform/audit/**`, **or** any `platform/audit` type appearing as a declared type, parameter type or field type |
| **3 · Compliance** | Audit facts are emitted as events through the outbox — `SID-4.44` (**L966–967**): *"This module **SHALL** emit audit events fire-and-forget through the outbox and **SHALL NOT** call `BC-24` synchronously from domain code"* |
| **4 · Evidence** | ⭐⭐ **The synchrony problem is solved by an existing structural equivalence, not by a new definition.** BC Map **`E-20`** (**L329**) declares the *only* sanctioned path: *"All contexts → BC-24 Audit Trail \| `PL` \| **Event (fire-and-forget, outbox-backed)** \| **Domain never calls audit synchronously**."* ⭐ **If `E-20` is the only path and it is an event, then any *reference* to `platform/audit` from domain code is necessarily off-path** — so the absence of a reference is a *sufficient* mechanical proxy for the absence of a synchronous call. ⚠ This is the same reasoning `ADR-0014` used for `X-10`: *"if no mutator exists, no caller can invoke one… Checking declarations is therefore both the faithful reading and the cheaper one — it needs no call-graph"* |
| **5 · NOT a violation** | ⛔ **Emitting an audit *event*** whose payload types come from `contracts` (rank 0) — that is `SID-4.44` compliance. ⛔ **A comment naming `BC-24` or `platform/audit`** for explanatory purposes. ⛔ **`platform/audit` importing `contracts`** — a different module's concern. ⛔ **`domain/library`'s existing `platform/audit` reference**, which is a **separate module** and is already covered by a dated `ADR-0012` waiver — ⭐ this criterion is scoped to `domain/person` and **does not disturb that waiver** |
| **6 · Method class** | **Structural / graph-based on the import and type graph.** ⭐ Mechanically it is a per-module `banned_imports`-shaped test |

⚠ **Disclosed limit.** A synchronous call reached through a **rank-0 contracts interface** that a composition
root binds to `platform/audit` would not be detected by import analysis. ⭐ **Recorded, not resolved**: the
residue stays under `SID-4.56`, and ⛔ **`E-20` is not reinterpreted to make the check look complete.**

---

## §6 ⭐⭐ `SID-INT-9` — reading another context's tables or index

**Rule (unchanged):** *"Reading another context's tables or index"* · Rules `X-07`, `X-08` · Detection
*"Repository allow-list"*.

> **`SID-DET-9` — Structural check against the module's ALREADY-DECLARED `ports:` list: every persistence
> or index access from `domain/person` MUST resolve to a port declared for `domain/person` in
> `tool/module_dependencies.yaml`. Any store or index access not so declared is a violation.**

| | |
|---|---|
| **1 · Artifact inspected** | Imports and declared collaborator types in `domain/person`, compared against its manifest `ports:` entries |
| **2 · Violation** | A persistence, repository, query or index type reached other than through a declared port — specifically any reference to another module's repository, store, table or index type |
| **3 · Compliance** | The answer is obtained through a declared synchronous port — `SID-4.6` (**L775–776**): *"Where this module needs an answer it does not own, it **SHALL** ask through a declared synchronous port and **SHALL NOT** read another context's store"* |
| **4 · Evidence** | ⭐⭐ **The allow-list §4.16 asks for ALREADY EXISTS in substance** — it is `domain/person`'s manifest `ports:` block, which declares exactly eight: `platform/data:repository`, `platform/security:crypto`, `platform/configuration:settings`, `platform/observability:telemetry`, `platform/services:files`, `platform/services:clock`, `platform/identity:policy_decision`, `platform/search:indexer`. Plus `provides_ports:` `identity_directory` (`E-13`) and `person_identity_factory`. ⭐ Combined with `default_decision: deny` (*"anything not listed is forbidden"*), the manifest is already an allow-list by construction. Corroborated by `X-07` and `X-08` (Matrix **L356–357**), the latter being precisely *"`SEARCH → domain repository` for indexing"* |
| **5 · NOT a violation** | ⛔ **This module's own repository** — `PersonIdentityRepository` and `InMemoryPersonIdentityRepository` are `BC-10`'s own aggregate store. ⛔ **`identity_directory`**, which this module **provides** across the `E-13` ACL. ⛔ **`contracts` types** (rank 0, L5). ⛔ **A declared port whose implementation reads another store** — the port is the sanctioned boundary; what lies behind it is that module's concern |
| **6 · Method class** | **Structural**, manifest-driven — the `ADR-0014` shape exactly |

⚠⚠ **ONE GENUINE ARTIFACT GAP REMAINS, AND IT IS NOT FILLED HERE.** `SID-DET-9` covers *store access reached
by import or declared type*. It does **not** cover a **raw table or index name passed as a string** to a
declared generic port (e.g. `repository.query('bc01_student_records')`). ⭐ Detecting that requires a
**declared inventory of table/index names per context**, which **does not exist anywhere in the repository**
— measured. ⛔ **It is recorded in §9.1 with its owner, not invented.**

---

## §7 ⭐⭐ `SID-INT-10` — indexing a never-public field

**Rule (unchanged):** *"Indexing a never-public field"* · Rule `SID-4.39` · Detection *"Index schema
review"*.

> **`SID-DET-10` — Schema-based check: every field submitted to the `platform/search:indexer` port from
> `domain/person` MUST be a member of the `SID-2.28` public allow-list. A field in the never-public set MUST
> NOT appear in any index-field argument, for any purpose.**

| | |
|---|---|
| **1 · Artifact inspected** | Every `platform/search:indexer` call site in `domain/person` and the field identifiers passed to it |
| **2 · Violation** | An index-field argument naming a field in the **never-public set**, **or** naming any field absent from the **public allow-list** (`SID-2.28`'s test is **membership**, not judgement) |
| **3 · Compliance** | Only allow-list fields are indexed — `SID-4.39` (**L944–946**): *"Only allow-list fields (`SID-2.28`) **SHALL** be indexed for public search. A field in the never-public set **SHALL NOT** be indexed at all, in any index, for any purpose"* |
| **4 · Evidence** | ⭐⭐ **Both sets are already enumerated in the PRD and are quoted, not composed.** **Public allow-list (L379–386):** Full Name · Username · Global Profile Photo *(if set and not hidden)* · Bio · Study statistics *(only if separately enabled)* · Achievements *(only if separately enabled)*. **Never-public set (L393–397):** *"`PersonId` · verified mobile number · parent / guardian contact · address · emergency contact · authentication information · Library Identification Photo · membership information · attendance records · seat allocation · financial information · audit metadata."* Reinforced by `SID-2.29` (no configuration may make these public), `SID-INV-11` (**L1313**) and `SID-AC-7` (**L1369**). ⭐ The manifest already annotates the port: `platform/search:indexer          # allow-list fields only` |
| **5 · NOT a violation** | ⛔ **Indexing an allow-list field.** ⛔ **Holding a never-public field in the aggregate** — `SID-INT-10` bans *indexing*, not holding; several never-public fields legitimately exist elsewhere in the system. ⛔ **A `FileRef` to the Global Profile Photo** where set and not hidden. ⛔ **`PersonId` used as an index *key/document id*** — ⚠ **this distinction is preserved exactly as `SID-4.39` writes it**: the rule bans indexing a never-public field *as searchable content*; ⭐ **`SID-DET-10` therefore inspects index *field* arguments, and does not extend the ban to document identity**, because extending it would change the rule |
| **6 · Method class** | **Schema-based** (set membership against two enumerated field sets), applied at port call sites |

⚠⚠ **A PREREQUISITE ARTIFACT IS MISSING AND IS NOT CREATED HERE.** The two field sets are **prose in a Rank-3
PRD**, not machine-readable, and **`grep` for `indexName|indexField|indexSchema|createIndex|addIndex` across
`lib/` and `packages/` returns 0** — so today there is **nothing to inspect**. ⭐ **`SID-DET-10` is
well-defined but not yet executable.** Routed in §9.1.

---

## §8 ⭐⭐ `SID-INT-11` — composing the aggregated profile inside this module

**Rule (unchanged):** *"Composing the aggregated profile inside this module"* · Rule `AR-1` · Detection
*"Layer check"*.

> **`SID-DET-11` — Layer check: no type declared in `domain/person` may aggregate data originating from
> more than one bounded context. Concretely: a declared type in `domain/person` MUST NOT hold, as a field,
> both a `BC-10` field and a value obtained from any other context's port.**

| | |
|---|---|
| **1 · Artifact inspected** | Type declarations in `domain/person` and the provenance of their field types |
| **2 · Violation** | A type declared in `domain/person` holding fields sourced from two or more contexts — e.g. a class combining `PersonIdentity` content with membership, attendance, seat or fee data; or a method in `domain/person` returning such a composite |
| **3 · Compliance** | Composition happens in the application layer — `SID-4.9` (**L785–786**): *"Read composition of the aggregated profile screen **SHALL** occur in the application layer (`app`, rank 9), **never inside this module**"* |
| **4 · Evidence** | ⭐ **`AR-1`** (`ARCHITECTURE_RULINGS.md` **§AR-1**, applied by BC Map **L12**/**L86**) rules that a read composition *"is likewise **not a context**… It owns **no aggregate**"* — so composition is an application-layer activity by ruling, not by preference. ⭐ **`SID-4.9`** places it at `app`, rank 9. ⭐ **The PRD even enumerates the contributors** at **L1184**: *"**Aggregated profile screen** — composed in the application layer from many contributors"*. ⭐ And the shape of a **compliant** cross-boundary type already exists as a worked example: `IdentityCoreFields` *"Carries no aggregate, no status history and no reference back into this module"* |
| **5 · NOT a violation** | ⛔ **`IdentityCoreFields`** — the `E-13` ACL projection, single-context (`BC-10`) content only. ⛔ **`app`-layer composition** — that is the required location. ⛔ **`domain/person` holding `AccountId`** — `BC-18` linkage mandated by `SID-INV-1`, not aggregation. ⛔ **A summary fetched live for display** under `SID-4.24`, provided it is not composed here. ⛔ **A type merely *referencing* `PersonId`** |
| **6 · Method class** | **Structural / layer analysis** on declared field provenance |

⚠ **Disclosed limit.** *"Composition"* is judged by **field provenance across contexts**, which is the most
faithful mechanical reading of `SID-4.9` available from existing authority. ⭐ It will not catch a composite
assembled entirely from primitives (`String`, `int`) that *semantically* originate elsewhere. ⛔ **The rule
is not narrowed to the check**; the residue remains under `SID-4.56`.

---

## §9 What must exist before implementation, and what is NOT decided

### 9.1 ⚠⚠ Two prerequisite artifacts — recorded, owned, routed, **NOT created**

⭐ The conferral required exactly this disclosure. Both are **artifacts**, not rules.

| # | Artifact | Why required | Owner | Minimum authoritative contents | Separate governance act needed? |
|---|---|---|---|---|---|
| **A1** | **A per-context inventory of persistence table / index names** | `SID-DET-9` cannot detect a **string-literal** table or index name passed to a generic port without knowing which names belong to which context. Measured: **no such inventory exists anywhere in the repository** | **Architecture Owner** — it partitions persistence across bounded contexts, which **L85** reserves (*"Boundaries… permitted edges"*) | For each bounded context: the set of table and index name **prefixes or exact names** it owns. Nothing more — ⛔ no schema, no column, no DDL | ⭐ **Probably not a new ADR** if it is expressed as a manifest key, on the `ADR-0014` model (*"read the manifest that already existed"*). ⚠ **But this ADR does not decide that**, because populating it is an Architecture Owner act and the manifest carries **169 measured line-citations** |
| **A2** | **A machine-readable index-field declaration for `domain/person`** | `SID-DET-10` is well-defined but **not executable**: **0** index declarations exist in `lib/` or `packages/`, so there is nothing to inspect. The two field sets are **prose** in a Rank-3 PRD | **`BC-10` Domain Owner** (which fields) **+ Architecture Owner** (where the declaration lives) | The `SID-2.28` public allow-list and the never-public set, transcribed **verbatim** from `Student_Identity_PRD_v1.md` **L379–397** — ⛔ **no field added, removed or renamed** | ⚠ **Undetermined here.** If it is a pure transcription of frozen prose into a manifest key, the `ADR-0014` precedent suggests no new ADR; ⛔ **this act does not rule on it**, because doing so would decide an Architecture Owner question outside the conferral |

⛔ **Neither artifact is created, drafted, named as a file, or given a schema by this ADR.**

### 9.2 Baseline test, performed rather than asserted

`DOCUMENTATION_BASELINE.md` **§7** (L377–383):

| Rule | Met? |
|---|---|
| 1 — A Rank 1–5 change needs an ADR **before** the change | ⛔ **Unmet** — **no Rank 1–5 document changes** |
| 2 — Version + changelog in the same commit | ⛔ **Unmet** |
| 3 — Declaration updated in the same commit | ⛔ **Unmet** |
| 4 — Baseline identifier moves **only** for a Rank 1–3 version change | ⛔ **Unmet** |

⭐ **All four unmet ⇒ no version bump anywhere and `BASELINE-2026-09-03-A` STANDS.**

### 9.3 ⚠ A separate, smaller act is identified but NOT performed

⭐ **`SID-INT-1`, `-2`, `-3`, `-4`, `-7` already fire** — `-3` and `-4` were **probe-verified** during the
audit — but they report under `ID-2`, `X-05`, `X-04` and `L2`, **not** under a `SID-INT` label. ⚠ Making
them **independently identifiable** is a **manifest/checker labelling act**, outside this conferral and
⛔ **not performed here**. It is recorded so it is not mistaken for done.

---

## §10 What this act explicitly does not do

- ⛔ It does **not** change what any `SID-INT` rule forbids. **`SID-INT-1`…`SID-INT-12` are byte-unchanged**,
  and §4.16's `Detection` column is **not rewritten**.
- ⛔ It does **not** create a `SID-*`, `SID-BR-*`, `SXC-*`, `SPO-*`, `SEV-*`, `SID-INV-*`, `SCFG-*` or
  `SID-AC-*` requirement. **0** minted.
- ⛔ It does **not** weaken a rule to make it checkable — every criterion that is narrower than its rule
  **says so** (§3, §5, §6, §7, §8) and leaves the residue under `SID-4.56`.
- ⛔ It does **not** implement, edit or configure the checker; `tool/check_module_boundaries.dart` and
  `tool/module_dependencies.yaml` are **byte-unchanged**.
- ⛔ It does **not** add a dependency, or touch `lib/`, `test/`, `pubspec.yaml`, `android/` or `web/`.
- ⛔ It does **not** create the two prerequisite artifacts (§9.1).
- ⛔ It does **not** close `BLK-03` / `IMPL-220`, and it does **not** make any rule *"satisfied"* —
  `SID-4.56` still counts all twelve as **unmet** until the checks run.
- ⛔ It does **not** select a provider, backend runtime, DLT registration, authentication configuration or
  retention period, and does **not** reopen `ADR-0119`…`ADR-0124`.
- ⛔ It confers **no standing authority** and appoints **no holder**.

---

## §11 Changelog

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-08 | ⭐⭐⭐ **Created and ACCEPTED. The `IMPL-220` DETECTION-SPECIFICATION gap is closed for the six rules that lacked a mechanical criterion — and `IMPL-220` itself is deliberately NOT closed.** The **Architecture Owner + `BC-10` Domain Owner**, jointly, under a **new** one-act conferral (⛔ **no prior conferral reused**; both offices revert afterwards), record **`SID-DET-5`**, **`SID-DET-6`**, **`SID-DET-8`**, **`SID-DET-9`**, **`SID-DET-10`** and **`SID-DET-11`** — each specifying the artifact inspected, what is a violation, what is compliance, the required evidence, what must **NOT** be flagged, and the method class, exactly as the conferral required. ⭐ **Two offices jointly** because the act has a *detection-method* limb (Architecture, `PRD_OWNERSHIP_MODEL` **L85**) and a *faithfulness-to-the-`BC-10`-rule* limb (Domain, **L84**) — the `ADR-0011` precedent. ⭐⭐ **THE METHOD WAS `ADR-0014`'S, QUOTED AND FOLLOWED:** *"The fix was to **read the manifest that already existed**, not to add a rule or to soften one."* Every criterion is derived from quoted existing authority: **`SID-DET-5`** from `SID-INV-5` **L1307** + the manifest's already-declared `observability_plane.banned_content` + `SID-4.13`; **`SID-DET-6`** from Rank-1 **`MP-GBR-26`** (*"immediate and global… no propagation window"*), `SXC-7`, `SID-AC-20`, and ⭐ the manifest comment that **already** reads `policy_decision  # ask BC-18 per request; never cache`; **`SID-DET-8`** from `SID-4.44` + BC Map **`E-20`** **L329**; **`SID-DET-9`** from `SID-4.6` + the manifest's **existing eight-port allow-list** under `default_decision: deny`; **`SID-DET-10`** from `SID-4.39` + the **two field sets already enumerated verbatim** at **L379–386** and **L393–397**; **`SID-DET-11`** from `SID-4.9` + `AR-1` + the `IdentityCoreFields` worked example. ⭐⭐ **THE HARDEST PROBLEM — `SID-INT-8`'s \"synchronously\" — WAS SOLVED WITHOUT REDEFINING IT:** because `E-20` declares the *only* audit path and declares it an **event**, any *reference* to `platform/audit` from domain code is necessarily off-path, so absence-of-reference is a **sufficient structural proxy** — the identical reasoning `ADR-0014` used for `X-10` (*"if no mutator exists, no caller can invoke one… it needs no call-graph"*). ⛔⛔ **NO `SID-INT` RULE IS CHANGED, NARROWED OR REINTERPRETED** — `Student_Identity_PRD_v1.md` is **byte-unchanged**, §4.16's `Detection` column is **not rewritten**, and **0** `SID-*` identifiers are minted; the `SID-DET-*` labels are **ADR-local citation labels** on the `EVT-PERS-1`/`EVT-AUTHZ-1` pattern, **not** PRD requirements and **not** entered in the traceability matrix. ⭐⭐ **FOUR CRITERIA ARE NARROWER THAN THEIR RULES AND EACH SAYS SO RATHER THAN PRETENDING OTHERWISE:** `SID-DET-5` cannot catch a credential under a misleading field name; `SID-DET-8` cannot catch a synchronous call bound through a rank-0 contracts interface at the composition root; `SID-DET-9` cannot catch a raw table/index name passed as a **string literal**; `SID-DET-11` cannot catch a composite assembled purely from primitives. ⛔ **In every case the residue is left under `SID-4.56` and the RULE IS NOT NARROWED TO MATCH THE CHECK** — which rule 4 of the conferral required. ⚠⚠ **TWO PREREQUISITE ARTIFACTS ARE RECORDED, OWNED AND ROUTED — AND NOT CREATED (§9.1):** **A1** a per-context table/index name inventory (**Architecture Owner**; measured: exists **nowhere** in the repository) and **A2** a machine-readable index-field declaration for `domain/person` (**`BC-10` Domain Owner + Architecture Owner**; measured: **0** index declarations in `lib/` or `packages/`, so `SID-DET-10` is **well-defined but not yet executable**). ⛔ Whether each needs its own ADR is **explicitly left undetermined**, because deciding it is an Architecture Owner act outside this conferral — ⭐ and the `ADR-0014` manifest precedent is cited as *suggestive, not dispositive*. ⚠ **A separate smaller act is identified and NOT performed (§9.3):** `SID-INT-1`/`-2`/`-3`/`-4`/`-7` **already fire** (`-3` and `-4` **probe-verified** during the audit) but report under `ID-2`/`X-05`/`X-04`/`L2` rather than a `SID-INT` label; making them **independently identifiable** is a manifest/checker labelling act. ⛔⛔ **`BLK-03` / `IMPL-220` IS NOT CLOSED** and **no rule becomes \"satisfied\"** — `SID-4.56` still counts **all twelve as unmet** until the checks run; ⭐ **a detection criterion is not a check**. ⛔ **NOTHING ELSE AUTHORISED:** no checker implementation or edit, no manifest edit, no dependency, no application/domain code, no artifact creation, no provider, backend runtime, DLT, authentication or retention decision. ⛔⛔ **`ADR-0125` AMENDS NOTHING** — `Student_Identity_PRD_v1.md`, `MASTER_PRD.md`, the BC Map, the Dependency Matrix, `ARCHITECTURE_RULINGS.md`, the EA, **`tool/module_dependencies.yaml`**, **`tool/check_module_boundaries.dart`**, `DOCUMENTATION_BASELINE.md`, `PRD_OWNERSHIP_MODEL.md`, **`ADR-0014`**, `ADR-0011`, ⛔ **`ADR-0119`…`ADR-0124`**, `IMPL-220` and `TASK-D10` are all **byte-unchanged**; **§7 rules 1–4** each tested and **ALL UNMET**, so **no version bump anywhere** and **`BASELINE-2026-09-03-A` STANDS**. ⛔ No standing authority; no person appointed; **0** new `IMPL-*`, **0** code/config/dependency files. |
