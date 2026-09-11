# ADR-0135 — API governance: style, error taxonomy and non-disclosing denial, versioning, idempotency-key transport, session boundary, and authorization alignment

| Field | Value |
|---|---|
| **ADR** | `ADR-0135` |
| **Title** | The V1 API governance baseline: interaction style, error taxonomy and non-disclosing denial, versioning policy, idempotency-key transport, session/token contract boundary, and alignment with the existing role/action/scope/derived-capability authorization model |
| **Date** | 2026-09-10 |
| **Status** | ⭐ **Accepted** — by direct, explicit conferral of the human principal of this engagement, exercising **Architecture Owner** authority (the office `ADR-0131` §12 names for `B-5`), scoped to **this act only**. ⛔ The office **reverts on completion** (`ADR-0033` §7.1: *"a conferral for one act is not a standing appointment"*) |
| **Supersedes** | ⛔ **Nothing.** No ADR's decision text is altered |
| **Amends** | **`PRD_LIFECYCLE.md`** §7A.9 — one **new `API` row** appended to the boundary-clause table · **`ADR-INDEX.md`** (registration + `Count`) · **`DOCUMENTATION_BASELINE.md`** (§1 Authority; §8 changelog row) |
| **Does NOT amend** | ⛔⛔ **`ADR-0130`** · ⛔ **`ADR-0131`** · ⛔ **`ADR-0132`** · ⛔ **`ADR-0133`** · ⛔ **`ADR-0134`** · ⛔ `ADR-0010` · ⛔ `ADR-0129` · ⛔ **`MASTER_PRD.md`** · ⛔ **`LIBOORA_BOUNDED_CONTEXT_MAP.md`** · ⛔ `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` · ⛔ `LIBOORA_ENTERPRISE_ARCHITECTURE.md` · ⛔ **`PRD-008`** · ⛔ **`PRD-019`** · ⛔ **`PRD-022`** · ⛔ **Authentication v2 / v3 / `prd-v2/` / `prd-v3/`** · ⛔ `PRD-021A`/`B`/`C` · ⛔ every frozen PRD · ⛔ `tool/module_dependencies.yaml` |
| **Governs** | The six `B-5` API decisions **as governance constraints**, and nothing below them |
| **Outcome** | ⭐⭐ **Five of the six are DECIDED — four by RECOGNITION of existing higher-rank authority and one by Architecture determination on a rank conflict. The sixth limb — the API deprecation/sunset lifecycle — is STOPPED and recorded OPEN as `API-GAP-001`.** ⛔ **ZERO permission identifiers. ZERO endpoints. ZERO OpenAPI. ZERO Technical Specifications** |

---

## 0. Scope and method

⭐ This act governs **only** the six decisions `B-5` names. ⛔ It specifies **no endpoint, no path, no verb, no payload,
no status-code table, no header name beyond the one the idempotency obligation already requires, no schema and no
example.** Those are Stage `6A` Technical Specification work, and `ADR-0131` §D leaves `docs/50-technical/`
**deliberately absent**.

⭐⭐ **Method: read what already governs, and decide only the genuine remainder.** Four of the six were found
**already decided at Rank 1 and Rank 4** and are therefore **recognised, not re-decided** — the `ADR-0014` method
(*"read the manifest that already existed, rather than add a rule"*). ⚠ One required a real Architecture
determination because **Rank 1 and Rank 6 disagree**. ⚠ One limb had **no authority at any rank** and is
**stopped**.

### 0.1 Identifier namespace — measured before use

⭐ This ADR uses the labels **`API-1`…`API-9`** and **`API-GAP-001`**.

⚠⚠ **The namespace was measured before it was used, because the obvious choice was already taken.**

| Candidate | Measured | Verdict |
|---|---|---|
| `API-NNN` **bare**, e.g. `API-001` | **0** occurrences repository-wide | ⛔ **NOT used anyway** — see below |
| `LCF-API-*`, `LCR-API-*`, `LCM-API-*`, `MSG-API-*`, `SGR-API-*`, `SSF-API-*`, `SDS-API-*`, `LCO-API-*` | ⚠ **400 occurrences** across baselined Rank 3 `PRD-021A`/`PRD-021B` | ⛔⛔ **MUST NOT be reused or extended** |
| `AERR-1`…`AERR-13` | ⚠ **14 distinct**, in Authentication v2 (`prd-v2/11`) and `ADR-0063` | ⛔⛔ **MUST NOT be reused** — an authentication error set, not an API taxonomy |
| `TS-*`, `PERM-*`, `IMPL-*`, `LTS-*`, `LCTS-*`, `TPA-*`, `LMT-*` | reserved or occupied | ⛔ **MUST NOT be reused** (`PRD_REGISTRY` §19) |

⛔⛔ **`API-001`-style three-digit identifiers are DELIBERATELY NOT minted, even though the bare form measured free.**
⭐ **Reason, stated as a risk rather than a preference:** a three-digit `API-NNN` sitting beside **400** existing
`XXX-API-NNN` identifiers is a collision waiting to happen in `grep`, in traceability and in the reader's eye. ⭐ The
single-digit **`API-1`…`API-9`** form matches the repository's convention for *architecture-level* rules —
`AP-3`…`AP-9`, `AR-1`…`AR-7`, `ID-1`…`ID-6`, `CID-1`…`CID-6`, `X-03`…`X-13` — which is exactly what these are.

⚠ **`API-1`…`API-9` are ADR-local architecture rules, on the `AR-*`/`CID-*` pattern.** ⛔ They are **not** PRD
requirements, ⛔ **not** entered in `TRACEABILITY_MATRIX.md`, and ⛔ **not** `IMPL-*` tasks.

---

## 1. Decision 1 — API style / interaction style

### 1.1 ⭐ RECOGNISED, not decided: the style is already fixed at Rank 1 and Rank 4

| Authority | Rank | Text |
|---|---|---|
| `MASTER_PRD.md` **L407** | **1** | *"REST API conventions **(and GraphQL where the BFF requires it** — the Open Host Service edge is specified as \"versioned REST/GraphQL\")"* |
| `MASTER_PRD.md` **L409**, **L410** | **1** | *"Consistent response structure"* · *"Validation errors"* |
| `LIBOORA_BOUNDED_CONTEXT_MAP.md` **L226** | **4** | *"OHS (versioned REST/GraphQL)"* on the `EDGE / COMPOSITION` → core boundary |
| `LIBOORA_ENTERPRISE_ARCHITECTURE.md` **L373**–**L375** | 6 | `API Specification (V1)` · `REST Standards (V1)` · `API Naming Convention (V1)` |
| `MP-CON-09` (`MASTER_PRD` **L520**) | **1** | *"V1 ships as a **modular monolith**. Microservices are not a V1 option."* |

> **`API-1` — The V1 external interaction style is REST over HTTP.** It is **recognised** from `MASTER_PRD` **L407**
> and BC Map **L226**, ⛔ **not** newly chosen here.

> **`API-2` — GraphQL is permitted ONLY at the BFF / Open Host Service edge, and ONLY where the BFF requires it.**
> ⛔ It is **not** a general interaction style, ⛔ **not** a second API surface, and ⛔ **not** a substitute for REST at
> any module boundary. This is `MASTER_PRD` **L407**'s conditional read literally: *"where the BFF **requires** it."*

> **`API-3` — Cross-context calls inside the monolith are IN-PROCESS PORT CALLS, never HTTP.** Under `MP-CON-09` the
> V1 deployment is a single modular monolith; the Rank 4 Dependency Matrix already expresses every inbound dependency
> as a **named port** (e.g. `identity.policy_decision`). ⛔ **An internal HTTP hop between contexts is therefore not
> an API style choice — it is a boundary violation**, and `ADR-0012`'s checker remains the merge gate.

⚠ **Measured, so the GraphQL clause is not read too widely:** `grep -ic 'graphql\|grpc'` across all of `docs/`
returns **0** occurrences other than the two phrases quoted above. ⛔ **There is no GraphQL schema, no gRPC service
definition and no design for either**, and `API-2` creates none.

### 1.2 ⛔ What `API-1`…`API-3` do NOT do

⛔ No endpoint, path, verb, resource name, media type, pagination shape or response envelope is specified. ⛔ The
*"consistent response structure"* of **L409** is **recognised as an obligation and left unspecified** — giving it a
concrete shape is Technical Specification work.

---

## 2. Decision 2 — Error taxonomy and non-disclosing denial

### 2.1 ⚠ The finding: the doctrine exists, but only in fragments, and never once at the API level

| Authority | Rank / status | Text |
|---|---|---|
| **`ADR-0010`** **L151** | **Rank 2, Accepted** | ⭐⭐ *"Distinct 404 / 403 for private vs non-existent"* → **listed as a REJECTED alternative**, reason: *"**Enumeration oracle** for the private-library inventory"* |
| **`AUTH-10.33`** | **FROZEN** | *"A notification about suspension **MUST NOT disclose the reason**, the reporting party, or any other account"* |
| **`LCM-API-003`** | Rank 3, baselined | *"a **non-enumerating** refusal reason … The reason **MUST NOT** disclose which conjunct failed in a way that reveals another person's state"* |
| **`AP-9`** | **BYTE-FROZEN** | *"Where any input to a decision is unavailable, indeterminate or in error, the decision is **refusal**"* |
| **`AP-6`** | **BYTE-FROZEN** | *"A decision without a tenant is **invalid**, and invalid means refused"* |
| `EA` **L377** | 6 | `Error Standards (V1)` |

⭐⭐ **`ADR-0010` L151 is the decisive one, and it is stronger than it looks.** It is an **Accepted Rank 2** ADR that
*already rejected* status-code discrimination between "forbidden" and "absent" — **as a security decision, on an
enumeration-oracle ground.** ⭐ So the non-disclosing rule below is **recognition of an existing Accepted decision**,
generalised to the API surface it was always about.

### 2.2 The rules

> **`API-4` — A denial MUST NOT disclose existence.** Where a caller is not entitled to know whether a resource
> exists, the refusal for *"exists but forbidden"* and the refusal for *"does not exist"* **MUST be
> indistinguishable** — same status, same body, same shape, same timing class. ⛔ **Distinct 404 / 403 for
> private-vs-absent is PROHIBITED**, per `ADR-0010` **L151**'s rejected alternative.

> **`API-5` — A denial MUST NOT disclose the reason for the denial** beyond what the caller is already entitled to
> know. ⛔ It **MUST NOT** name the failing rule, the failing conjunct, the missing capability, the role required, the
> policy consulted, the tenant, or any other principal's state. Recognised from `AUTH-10.33`, `LCM-API-003` and
> `LCM-AUTH-002`'s non-enumeration posture.

> **`API-6` — The error taxonomy MUST distinguish CLASSES, and the classes MUST NOT be authorization oracles.**
> A caller-correctable error (malformed input, failed validation) **MAY** be specific, because `MASTER_PRD` **L410**
> requires validation errors to be usable. ⛔ An authorization or existence outcome **MUST NOT** be. ⭐ **The
> asymmetry is the whole rule:** validation is about the *request*, which the caller already owns; authorization is
> about the *world*, which it may not.

⚠ **`AP-9` composes with `API-4`/`API-5` and is NOT weakened:** a fail-closed refusal caused by an unavailable input
is itself a denial, and ⛔ **MUST NOT** be reported in a way that reveals that a dependency was down and that a
different answer might be obtainable by retrying. ⭐ **A fail-closed refusal and an entitlement refusal must look the
same to the caller.**

### 2.3 ⛔ What `API-4`…`API-6` do NOT do

⛔ **No status-code table, no error-code list, no error body schema, no message catalogue and no new `AERR-*` or
`ERR-*` identifier.** ⚠ `AERR-1`…`AERR-13` belong to **Authentication v2** and are ⛔ **not extended, reused,
renumbered or referenced as an API taxonomy**. ⛔ **`AUTH-10.33` is restated, never amended** — Auth documents are
byte-frozen here.

---

## 3. Decision 3 — API versioning policy

### 3.1 ⚠⚠ A genuine rank conflict, and the one decision that required Architecture judgement

| Authority | Rank | Says |
|---|---|---|
| `MASTER_PRD.md` **L408** | **1** | *"**Versioned endpoints**"* |
| `MASTER_PRD.md` **L407** | **1** | *"the Open Host Service edge is specified as \"**versioned** REST/GraphQL\""* |
| `LIBOORA_BOUNDED_CONTEXT_MAP.md` **L226** | **4** | *"OHS (**versioned** REST/GraphQL)"* |
| `LIBOORA_ENTERPRISE_ARCHITECTURE.md` **L380** | 6 | ⚠ `Versioning Strategy` **(V2)** |
| `LIBOORA_ENTERPRISE_ARCHITECTURE.md` **L1787** | 6 | ⚠ `API Versioning` **(V2)** |
| `LIBOORA_ENTERPRISE_ARCHITECTURE.md` **L1793** | 6 | ⚠ `API Lifecycle Management` **(V2)** |
| `LCT-FR-111` (`PRD-021A` A8, draft) | 3 | *"API versioning SHALL use `API Versioning` (EA **L1787**, **V2**)"* |

⭐⭐ **DETERMINATION — the conflict resolves by rank, and then by reading the two statements as different things.**

1. ⭐ **Rank decides the clash.** `DOCUMENTATION_BASELINE` §4 places **Rank 1** and **Rank 4** above **Rank 6**, and
   its **L139** records the EA as *"**Descriptive** — must follow the PRDs, never lead them."* ⛔ An EA `(V2)` tag
   **cannot** defer a Rank 1 requirement.
2. ⭐⭐ **But the two are not actually saying the same thing.** *"Versioned endpoints"* is an **interface property** —
   the surface carries a version identifier. *"Versioning Strategy" / "API Lifecycle Management"* is the
   **management machinery** — deprecation windows, sunset dates, dual publication, multi-version support. ⭐ **A V1
   surface can be versioned without operating a deprecation programme**, and reading the EA's `(V2)` as licence to
   ship an **unversioned** V1 surface would contradict Rank 1 for no benefit.

> **`API-7` — The V1 API surface MUST carry an explicit version identifier from first release.** This is Rank 1
> **L408** applied literally and Rank 4 **L226** corroborating it. ⛔ **An unversioned V1 surface is not permitted.**

> **`API-8` — The versioning MECHANISM is not selected here.** ⛔ Path-segment, header, media-type and query-parameter
> versioning are **all left open**; ⛔ **no mechanism is chosen, preferred or ranked**. ⭐ Selecting one requires a
> concrete surface to apply it to, which ⛔ **does not exist** — `docs/50-technical/` is deliberately absent and
> `TS-001` is unallocated.

⚠ **`LCT-FR-111` is a DRAFT Rank 3 requirement citing a Rank 6 `(V2)` tag.** ⛔ It is **not amended, corrected or
reinterpreted here** — `PRD-021A` A8 is a draft owned elsewhere, and `API-7` governs it by rank regardless. ⭐ The
divergence is **recorded, not repaired** — the `ADR-0134` posture.

### 3.2 ⚠⚠ STOP — the deprecation / sunset lifecycle is OPEN

⛔⛔ **A versioning *policy* needs more than "carry a version": it needs to say what happens when a version ends.**
**Measured: `grep -rn "deprecation window\|sunset period\|support window"` across all of `docs/` returns exactly
`0`.** There is **no** governed statement of:

- how long a released API version is supported;
- what notice a breaking change requires;
- whether two versions may be served simultaneously;
- who may declare a version deprecated, and who must consent.

⚠⚠ **I do not have the authority to decide these, and I am recording them OPEN rather than guessing.** Each is a
**Product** commitment about the obligation owed to consumers, not an Architecture property of the interface —
and **Product Owner authority is not conferred for this act**. ⭐ The EA independently places
`API Lifecycle Management` at **V2**, so ⛔ **deciding it now would also invent a V1 obligation that no governed
document requires.**

> ⛔⛔ **`API-GAP-001` — OPEN.** The API deprecation / sunset / multi-version-support policy is **undecided**.
> **Authority required: Product Owner + Architecture Owner.** ⛔ **Not resolvable by Architecture alone.**
> ⚠ **Consequence stated plainly: `B-5` is therefore DISPOSED, not fully closed** — see §8.

⭐ **What makes the gap safe to leave open:** measured, V1 has **no external API consumer**. The EA places
`Public Developer APIs` at **(Future)** (**L1783**), and `MASTER_PRD` names **no** partner, third-party or public API
programme. ⛔ **With one first-party client, a version can be retired by shipping the client** — so the absence of a
deprecation policy is ⭐ **a real gap that blocks a public API, not a V1 launch blocker.**

---

## 4. Decision 4 — Idempotency-key transport

### 4.1 ⭐ The obligation already exists; only its transport was unstated

| Authority | Rank / status | Text |
|---|---|---|
| **`FEE-FR-029`** (`PRD-008` **L944**) | **FROZEN** | ⭐⭐ *"Every payment-recording operation **MUST accept an idempotency key at the API edge**."* |
| **`FEE-INV-005`** (`PRD-008` **L949**) | **FROZEN** | *"For a given tenant, **no two confirmed payments MAY share an idempotency key**"* |
| **`MP-GBR-18`** (`MASTER_PRD` **L359**) | **1** | *"Attendance check-in is **idempotent** by `(studentRecordId, date, idempotencyKey)`"* |
| `ATT-FR-090`…`ATT-FR-095` | 3, FROZEN | idempotency keys, replay tolerance, duplicate suppression |
| `EA` **L378** | 6 | `Idempotency Standards (V1)` |

⭐ **So the key's existence, its scope and its uniqueness rule are all already governed.** ⚠ What no document states
is **where the key travels** — and that single question is what `B-5` names.

> **`API-9` — An idempotency key is carried as REQUEST METADATA, not as domain payload.** Every non-idempotent
> state-changing operation at the API edge **MUST** accept one; it **MUST** be supplied by the caller, **MUST** be
> opaque to the domain, and ⛔ **MUST NOT** be a business field, a natural key, or derived from payload content.
> ⭐ Uniqueness is scoped **per tenant**, exactly as `FEE-INV-005` already scopes it, which `AP-6` makes inevitable —
> *"every decision is evaluated with exactly one library in scope."*

⭐⭐ **Why "metadata, not payload" is a recognition rather than an invention.** `FEE-FR-029` places the key *"at the
**API edge**"* — not in the `FeeDue` aggregate, not in a domain command's business fields. `MP-GBR-18` treats it as
the **third element of a de-duplication tuple** alongside identity and date, i.e. a **replay discriminator**, not a
property of the payment. ⭐ **Reading it as domain data would contradict both.**

### 4.2 ⛔ What `API-9` does NOT do

⛔ **No header name is specified** — not `Idempotency-Key`, not any other. ⛔ No retention period for keys, no
storage design, no collision-response status code, no key format, length or generator. ⭐ **`API-9` fixes the
*transport class*, which is what `B-5` asks; the wire name is Technical Specification work.**

⛔⛔ **No payment mechanism is touched.** `ADR-0130` stands: **V1 student payment is CASH ONLY**; ⛔ UPI, card, online,
gateway, platform charge and settlement are **V2** and ⛔ **no V2 mechanism is invented here.** ⭐ `API-9` is
**method-neutral** — a cash receipt recorded twice is exactly the duplicate `FEE-FR-029` exists to stop.

---

## 5. Decision 5 — Session / token contract boundary

⚠⚠ **This decision is deliberately the narrowest in this ADR, because Auth v3 is FORBIDDEN to modify.** ⭐ Only the
boundary *as far as API governance requires* is stated; everything behind it stays Authentication's.

| Authority | Rank / status | Text |
|---|---|---|
| **`MP-GBR-26`** (`MASTER_PRD` **L380**) | **1** | *"Session revocation is **immediate and global** — **authoritative-or-absent**, with no propagation window."* |
| **Dependency Matrix L220** | **4** | `identity.policy_decision  # ` ⭐ *"**ask BC-18, never evaluate or cache**"* |
| **`AP-6`** | BYTE-FROZEN | one library in scope; a decision without a tenant is refused |
| **`AUTH-3.12`** | FROZEN | the secret *"MUST NOT appear in any response, event, log, metric, error or analytics record"* |

⭐ **RECOGNISED — the boundary is already drawn, and this ADR only states its API consequence:**

- ⭐ **The API edge is a CONSUMER of authorization decisions, never a producer.** It **MUST** ask `BC-18` through
  `identity.policy_decision` and ⛔ **MUST NOT** evaluate policy itself, ⛔ **MUST NOT** cache a decision, and
  ⛔ **MUST NOT** infer one from a token's contents. `MP-GBR-26`'s *"no propagation window"* makes a cached decision
  **unsound by construction** — a revoked session that still passes a cached check is precisely the defect the Rank 1
  rule forbids.
- ⭐ **The token is an authentication artefact, not an authorization store.** Embedding roles, capabilities or
  permissions in it and trusting them would breach `MP-GBR-26` (staleness), `AP-8` (*"never by conditional logic
  embedded in a feature"*) and `AP-6` (tenant must be in scope at decision time).
- ⛔ **`AUTH-3.12` is restated, not extended:** no secret, code or credential appears in any API response, error,
  log, metric or analytics record.

⛔⛔ **NOT decided here, and NOT stopped either — because it is already owned:** token format, lifetime, refresh,
rotation, storage and transport are **Authentication v3.0 / `ADR-0129`** territory. ⛔ **Auth v3 is not modified,
extended or re-interpreted**, and ⛔ **no Auth v4.0 exists.** ⭐ **This is not a gap; it is another office's
settled scope.**

---

## 6. Decision 6 — Alignment with the existing authorization model

⭐⭐ **This decision creates nothing. It is an alignment statement, and its whole content is a prohibition.**

| Authority | Status | Effect |
|---|---|---|
| **`AUTH-7.22`** | ⛔ **BYTE-FROZEN, CLOSED** | The permission catalogue is closed |
| **`ADR-0132`** | **Accepted** | ⭐ **Active enumerated permissions measured ZERO and RETAINED at zero**; `PERM-*` repo-wide = **2, both withdrawals** |
| **`ADR-0043` §5.1** | **Accepted** | *"**Do not invent a new permission ID.**"* |
| **`LCM-AUTH-002`** | Rank 3, baselined | *"**MUST NOT** introduce a permission identifier"* |
| **`LCM-AUTH-001`** | Rank 3, baselined | capabilities *"**derived at evaluation time**. Nothing is granted, assignable, delegable, inheritable, or stored"* |
| **`AP-3`…`AP-9`** | BYTE-FROZEN | deny-by-default · by name · separation of duties · tenant isolation · no inheritance · policy-based · fail-closed |
| Derived-capability sets | Rank 3 | `LCF-AUTH-*` **12** · `LCM-AUTH-*` **18** · `LCO-AUTH-*` **11** distinct, drafted |

⭐ **The API surface authorises through the EXISTING model and adds nothing to it:**

- ⛔⛔ **This ADR creates ZERO permission identifiers.** ⛔ No `PERM-*`, no dotted token, no category–action pair, no
  provisional name, no placeholder, and ⛔ **no API-specific permission of any kind.**
- ⛔ **`ADR-0132` is NOT reopened, revisited or qualified.** Its audit stands exactly as accepted.
- ⭐ **Authorization is by role + action class + scope class, evaluated as policy** (`AP-8`), against the closed
  vocabularies `AUTH-7.22`–`AUTH-7.27` already enumerate: **6** categories, **6** action classes, **4** scope classes.
- ⭐ **Where a capability is needed that no permission names, the DERIVED-CAPABILITY mechanism is the sanctioned
  route** — derived at evaluation time, never stored, never minted (`LCM-AUTH-001`/`002`).
- ⛔ **An API operation MUST NOT become a de-facto permission.** Route-level allow-lists, endpoint-name-keyed grants
  and per-endpoint role maps are ⛔ **prohibited**: each would create a permission vocabulary outside the closed
  catalogue, which `AUTH-7.22` and `ADR-0043` §5.1 forbid.

⚠ **The `AP-4` / `AP-8` tension `ADR-0132` recorded is NOT resolved here.** `AP-4` requires permissions be granted
*"by name"* while the catalogue holds **no names**. ⭐ **`ADR-0132` recorded it deliberately; this act neither
resolves it nor relies on either limb**, and ⛔ resolving it would reopen `ADR-0132`.

---

## 7. Files amended, and citation discipline

| File | Rank | Change |
|---|---|---|
| `PRD_LIFECYCLE.md` | — | ⭐ **ONE new `API` row appended to §7A.9's boundary table**, so every future Technical Specification is bound by `API-1`…`API-9` and warned of `API-GAP-001` |
| `ADR-INDEX.md` | — | `ADR-0135` registered in the end-of-file addendum; `Count` corrected **in place** |
| `DOCUMENTATION_BASELINE.md` | — | §1 Authority gains `ADR-0135`; §8 changelog row |

⭐⭐ **Why §7A.9 is the right and minimal home.** `ADR-0131` §9 and `PRD_LIFECYCLE` §7A.9 are **already** the
mechanism that binds Technical Specifications, and they carry **four** domains — PAYMENT, AUTHORIZATION,
AUTHENTICATION, ARCHITECTURE — and ⛔ **no API domain.** ⭐ **That absence is exactly the structural gap `B-5`
describes**, and one appended row closes it at the point of use. ⛔ **A second parallel register would be duplicate
governance.**

### 7.1 Citation cost, measured before the write

| Target | Measurement | Treatment |
|---|---|---|
| `PRD_LIFECYCLE.md` §7A.9 table | Highest live inbound citation **L403** — ⚠ **the PAYMENT row itself**, cited by `ADR-0134`. The table's last row is **L406** | ⭐ **Row APPENDED at L407, below every cited line — 0 citations shifted.** ⛔ L403 is **byte-unchanged** |
| `ADR-INDEX.md` | Highest live inbound citation **L890**; `Count` at **L9** | ⭐ `Count` **in place**; entry appended far below L890 |
| `DOCUMENTATION_BASELINE.md` | Highest live inbound citation **L383**; changelog's newest row at **L391** | ⭐ Row inserted at **L391**, below every cited line |

⭐ The `ADR-0079` §8.5 append-not-insert doctrine, applied as re-measured (`ADR-0133` §8.4).

### 7.2 ⚠ Baseline identifier — §7 rule 4's limb is UNMET

⭐ Rule 4: *"The baseline identifier changes only when a **Rank 1–3** document changes version."* ⚠⚠ **No Rank 1–3
document changes version here.** `MASTER_PRD` stays **v1.10**; the BC Map stays **v1.15**; every PRD is
byte-unchanged. `PRD_LIFECYCLE` is the **unranked** process document — ⭐ and it moves **v1.1 → v1.2** with its
changelog in this same commit, satisfying rule 2.

⭐ **Therefore `BASELINE-2026-09-10-C` STANDS** — the `ADR-0131`, `ADR-0132` and `ADR-0134` precedent.

---

## 8. `B-5` disposition — DISPOSED, ⛔ not fully closed

| `B-5` limb | Before | After |
|---|---|---|
| **API style** | ⛔ *"No API style selected"* | ⭐ **DECIDED — `API-1`/`API-2`/`API-3`**, by recognition of Rank 1 **L407** + Rank 4 **L226** + `MP-CON-09` |
| **Error taxonomy + non-disclosing denial** | ⛔ *"No error taxonomy"* | ⭐ **DECIDED — `API-4`/`API-5`/`API-6`**, by recognition of Accepted `ADR-0010` **L151**, `AUTH-10.33`, `LCM-API-003`, `AP-9` |
| **Versioning — surface property** | ⛔ *"No versioning selected"*; ⚠ Rank 1 vs Rank 6 conflict | ⭐ **DECIDED — `API-7`**: the surface **MUST** carry a version. Conflict resolved by rank |
| **Versioning — mechanism** | ⛔ none | ⚠ **DELIBERATELY LEFT OPEN — `API-8`**; needs a concrete surface that does not exist |
| **Versioning — deprecation / sunset lifecycle** | ⛔ none | ⛔⛔ **STOPPED — `API-GAP-001` OPEN.** Needs **Product Owner + Architecture Owner**; not conferred |
| **Idempotency-key transport** | ⛔ *"No idempotency transport"* | ⭐ **DECIDED — `API-9`**: request **metadata**, caller-supplied, opaque, per-tenant unique. Recognised from FROZEN `FEE-FR-029`/`FEE-INV-005` + `MP-GBR-18` |
| **Session/token boundary** | ⛔ undefined at the API edge | ⭐ **DECIDED (narrowly)** — consumer-not-producer, never cached, token ≠ authorization store, by `MP-GBR-26` + Matrix **L220**. ⛔ Auth v3 untouched |
| **Authorization alignment** | ⛔ unstated | ⭐ **ALIGNED — 0 permissions created**; derived capability is the sanctioned route; endpoint-keyed grants prohibited |

⭐⭐ **`B-5` is DISPOSED: five of six decided, one limb stopped and named.** ⛔⛔ **It is NOT "fully closed"** — a
versioning *policy* without a deprecation rule is incomplete, and ⭐ **saying so is more useful than a tidy
✅.** ⛔ **The Technical Specification phase remains NOT ENTERABLE.**

| Blocker | Status |
|---|---|
| **B-1** | ✅ RESOLVED — `ADR-0131` |
| **B-2** | ✅ AUDITED AND DISPOSED — `ADR-0132`, **0** permissions |
| **B-3** | ⚠ PARTIAL — `ADR-0133`; ⛔ **`Q-04` OPEN pending Legal counsel; V1 schema freeze BLOCKED** |
| **B-4** | ⭐ DISPOSED — `ADR-0134`; text repair outstanding (`BC-05` Domain Owner) |
| **B-5** | ⭐ **DISPOSED — this ADR**; ⛔ **`API-GAP-001` OPEN** |
| **B-6** | ⛔ **OPEN — untouched.** `DEVELOPER_HANDOFF.md` + 6 implementation documents stale on authentication |

---

## 9. ⛔ What this ADR does NOT do

- ⛔⛔ **No Technical Specification.** ⛔ `TS-001` **NOT allocated**; ⛔ `docs/50-technical/` **NOT created**
- ⛔⛔ **No OpenAPI, Swagger, schema, endpoint, path, verb, status-code table, header name or payload**
- ⛔⛔ **No database, schema, table, index, SQL or migration.** ⛔ **No Supabase change** — `ADR-0116`/`ADR-0124` untouched
- ⛔⛔ **ZERO permission identifiers**; ⛔ **`ADR-0132` NOT reopened**; ⛔ `AUTH-7.22` stays closed at **0**
- ⛔ **No Auth v2/v3 change**; ⛔ no `AERR-*` created, reused or extended; ⛔ **no Auth v4.0**
- ⛔ **`ADR-0130`, `ADR-0131`, `ADR-0132`, `ADR-0133`, `ADR-0134` byte-unchanged**
- ⛔ **`PRD-008`, `PRD-019`, `PRD-022` and every frozen PRD byte-unchanged**; ⛔ `MASTER_PRD`, BC Map, Matrix and EA byte-unchanged
- ⛔ **Does NOT resolve `Q-04`** (Legal counsel; **V1 schema freeze remains BLOCKED**) or **`B-6`**
- ⛔ **No V1 digital payment mechanism; no V2 payment or settlement mechanism; no provider** (`Q-B31` OPEN)
- ⛔ **No code, test, tool, checker or manifest file** — **0** under `lib/`, `test/`, `tool/`, `packages/`
- ⛔ **Closes no implementation blocker**; mints no `IMPL-*`; ⛔ no traceability-matrix entry
- ⛔ **Confers no lifecycle stage** and authorises no implementation. ⛔ **NOT pushed**

---

## 10. Changelog

| Version | Date | Change |
|---|---|---|
| **1.0** | 2026-09-10 | ⭐⭐ **Created and `Accepted`. The V1 API governance baseline is established: `API-1`…`API-9` decided, and `API-GAP-001` recorded OPEN.** Under a one-act **Architecture Owner** conferral — the office `ADR-0131` §12 names for `B-5`; ⛔ the office **reverts on completion**. ⭐⭐⭐ **FOUR OF THE SIX DECISIONS WERE ALREADY MADE AT HIGHER RANK AND ARE RECOGNISED, NOT RE-DECIDED** — the `ADR-0014` method: **style** from Rank-1 `MASTER_PRD` **L407** (*"REST API conventions (and GraphQL where the BFF requires it)"*) + Rank-4 BC Map **L226** + `MP-CON-09`'s modular monolith; **non-disclosing denial** from ⭐ **Accepted `ADR-0010` L151**, which had **already rejected** *"Distinct 404 / 403 for private vs non-existent"* as an *"**enumeration oracle**"*, plus FROZEN `AUTH-10.33`, Rank-3 `LCM-API-003` and byte-frozen `AP-9`; **idempotency** from ⭐ **FROZEN `FEE-FR-029`** (*"MUST accept an idempotency key **at the API edge**"*) + `FEE-INV-005` + Rank-1 `MP-GBR-18`; **session boundary** from Rank-1 `MP-GBR-26` (*"immediate and global … no propagation window"*) + Rank-4 Matrix **L220** (*"ask `BC-18`, **never evaluate or cache**"*). ⚠⚠ **ONE DECISION REQUIRED REAL ARCHITECTURE JUDGEMENT, BECAUSE RANK 1 AND RANK 6 DISAGREE:** `MASTER_PRD` **L408** requires *"**Versioned endpoints**"* while EA **L380**/**L1787** date *"Versioning Strategy"*/*"API Versioning"* at **(V2)**. ⭐ Resolved **by rank** — §4 puts Rank 1/4 above Rank 6 and baseline **L139** makes the EA *"**Descriptive** — must follow the PRDs, never lead them"* — ⭐⭐ **and then by distinguishing the two claims**: *"versioned endpoints"* is an **interface property**, *"versioning strategy / lifecycle management"* is **management machinery**; a V1 surface can carry a version without operating a deprecation programme. So **`API-7`** requires a version identifier from first release while **`API-8`** ⛔ **selects no mechanism** (path/header/media-type/query all left open), because choosing one needs a concrete surface that ⛔ **does not exist**. ⛔⛔ **AND ONE LIMB IS STOPPED, NOT GUESSED: `API-GAP-001` — the deprecation / sunset / multi-version-support policy is OPEN**, measured at **0** governed statements repo-wide (`grep "deprecation window\|sunset period\|support window"` → **0**). ⭐ It is a **Product** commitment about what is owed to consumers, not an Architecture property, and **Product Owner authority was not conferred** — so it is **recorded rather than invented**, and the EA independently dates `API Lifecycle Management` at **V2**. ⭐ **Why the gap is safe:** measured, V1 has **no external API consumer** — `Public Developer APIs` is **(Future)** at EA **L1783** and no partner/public API programme exists — so with one first-party client a version retires by shipping the client. ⭐ **`API-9` fixes the idempotency TRANSPORT CLASS — request metadata, caller-supplied, opaque to the domain, unique per tenant** — and that too is recognition: `FEE-FR-029` puts the key *"at the API edge"*, not in an aggregate, and `MP-GBR-18` treats it as the third element of a **replay-discriminator tuple**; ⛔ **no header name is specified**. ⚠⚠ **THE IDENTIFIER NAMESPACE WAS MEASURED BEFORE USE AND THE OBVIOUS CHOICE WAS DELIBERATELY REFUSED:** bare `API-NNN` measured **free (0)**, but ⛔ **three-digit `API-001` was NOT minted** because **400** `LCF-`/`LCR-`/`LCM-`/`MSG-`/`SGR-`/`SSF-`/`SDS-`/`LCO-API-NNN` identifiers already exist in baselined Rank 3 `PRD-021A`/`B` and a bare three-digit twin would collide in `grep`, in traceability and in the eye; ⭐ the single-digit **`API-1`…`API-9`** form matches this repository's convention for architecture-level rules (`AP-3`…`AP-9`, `AR-1`…`AR-7`, `ID-1`…`ID-6`, `CID-1`…`CID-6`). ⛔ **`AERR-1`…`AERR-13` (14 distinct, Authentication v2) are NOT reused, extended or renumbered.** ⭐ **`API-1`…`API-9` are ADR-local architecture rules on the `AR-*`/`CID-*` pattern** — ⛔ not PRD requirements, ⛔ not traceability entries, ⛔ not `IMPL-*`. ⛔⛔ **ZERO PERMISSION IDENTIFIERS CREATED** — `AUTH-7.22` stays **CLOSED at 0**, `ADR-0043` §5.1 binding, ⛔ **`ADR-0132` NOT reopened**, the derived-capability mechanism (`LCM-AUTH-001`/`002`) named as the sanctioned route, and ⛔ **endpoint-keyed grants / route allow-lists PROHIBITED** because each would build a permission vocabulary outside the closed catalogue. ⚠ The **`AP-4`/`AP-8` tension** `ADR-0132` recorded is ⛔ **neither resolved nor relied upon**. ⛔ **Session/token internals stay Authentication's** — Auth **v3.0**/`ADR-0129` untouched, `AUTH-3.12` restated not extended, ⛔ no v4.0; ⭐ **that is another office's settled scope, not a gap**. ⭐ **Amends ONE row into `PRD_LIFECYCLE` §7A.9** — the mechanism that **already** binds Technical Specifications, which carried **four** domains and ⛔ **no API domain**; ⭐ **that absence was the structural gap**, and a second parallel register would have been duplicate governance. ⚠⚠ **CITATION COST ZERO, MEASURED BEFORE THE WRITE:** §7A.9's highest live citation is **L403** — the PAYMENT row, cited by `ADR-0134` — so the new row is **appended at L407, below it**, and ⛔ **L403 is byte-unchanged**. ⛔ **NOT DONE:** no Technical Specification, `TS-001` **not allocated**, `docs/50-technical/` absent; ⛔ **0** OpenAPI/endpoints/paths/verbs/status-code tables/header names; ⛔ **0** DB/schema/SQL/migrations; ⛔ no Supabase change; ⛔ `PRD-008`/`019`/`022` and every frozen PRD byte-unchanged; ⛔ `ADR-0130`/`0131`/`0132`/`0133`/`0134` byte-unchanged; ⛔ **`Q-04` still OPEN and the V1 schema freeze still BLOCKED**; ⛔ **`B-6` untouched**; ⛔ **0** code/test/tool files; ⛔ **0** blockers closed. §7 rule 1 satisfied (this ADR precedes its own amendment); ⭐ **rule 4's limb UNMET — no Rank 1–3 version change — so `BASELINE-2026-09-10-C` STANDS**. ⛔ **NOT pushed.** |
