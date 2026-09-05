# `PRD-010` Notifications & Communication v0.1 — Stage 3 Architecture Alignment Record

| Field | Value |
|---|---|
| **Stage** | **Stage 3 — Architecture Review** ([`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md), Stage-3 check table and gate) |
| **Subject** | [`PRD-010_NOTIFICATIONS_AND_COMMUNICATION.md`](PRD-010_NOTIFICATIONS_AND_COMMUNICATION.md) — `PRD-010`, **`BC-22` Notification Delivery** `[GENERIC]`, **V1**, **v0.1a `DRAFT`** |
| **Gate satisfied by** | This document — *"a written alignment record naming every conflict and its disposition"* |
| **Worked examples followed** | [`LIBRARY_PRD_ALIGNMENT.md`](../library/LIBRARY_PRD_ALIGNMENT.md) · [`STUDENT_IDENTITY_ALIGNMENT.md`](../student-identity/STUDENT_IDENTITY_ALIGNMENT.md) · structurally closest: [`PRD-016_ARCHITECTURE_ALIGNMENT.md`](../audit/PRD-016_ARCHITECTURE_ALIGNMENT.md) |
| **Reviewed at** | `a63da0e46779b4d3118b00274532ed53cadc22a5` |
| **Subject `sha256` at review** | `b5b0d41da61b8e99d705275a1d2f949de566e4c670b4dc16e1e24a4d16507105` — 620 lines, 115 identifiers; verified identical before and after |
| **Date** | 2026-09-05 |
| **Mandate** | ⛔ **Stage 3 only.** No PRD modified · no ADR created or changed · no ranked or frozen document touched · no registry or baseline update · no identifier registered · no gap closed · no code |
| **Verdict** | ⚠ **ALIGNED WITH ONE REQUIRED CORRECTION — 6 of 6 checks PASS, 1 subject amendment REQUIRED (`NTF-AL-B2`).** See §12 |

---

## 1. Method

### 1.1 Sources validated against

| Rank | Source | Used for |
|---|---|---|
| 1 | `MASTER_PRD.md` | `MP-SCOPE-09` (L97) · `MP-GBR-21` (L120) · `MP-GBR-22` (L121) · `MP-GBR-33/34/35` (L461-463) · §22 (L446-455) · L110-111 · L229 |
| 2 | `ADR-0092`, `ADR-0098`, `ADR-0033` §7.1, `ADR-0020` §4, `ADR-0043`, `ADR-0046` | Frozen precedents, conferral limits |
| 3 | `Library_PRD_v1.md` (L596, L612) · `Authentication_PRD_v2.md` §10 (`AUTH-10.3`) · `PRD-021B` · `PRD-020` · `PRD-023` · `PRD-013` · `PRD-016` | Role model, frozen ownership |
| 4 | `LIBOORA_BOUNDED_CONTEXT_MAP.md` · `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` · **`tool/module_dependencies.yaml`** | Contexts, edges, ranks, module contract |
| 5 | `PRD_LIFECYCLE.md` · `PRD_REGISTRY.md` · `PRD_DEPENDENCY_GRAPH.md` · `PRODUCT_IMPLEMENTATION_ROADMAP.md` · `DEVELOPER_HANDOFF.md` | Gate, status, sequencing |

### 1.2 Classification scheme

**ACCEPTED** — a real conflict; the subject must change · **REJECTED** — a candidate finding tested and dismissed, **with its reason** · **NON-CONFLICT** — examined, no divergence · **DEFERRED** — real, belongs to a later stage · **OPEN** — real, needs authority this review does not hold.

> ⭐ Per the lifecycle: *"A rejected finding must be recorded as rejected, with its reason. A review that records only accepted findings is indistinguishable from a review that found nothing."* **§10 records 9 rejected candidates.**

### 1.3 What makes this review structurally unusual

⭐⭐ **The subject was drafted without ever reading `tool/module_dependencies.yaml`.** It reasoned from Rank 1 and the BC Map to a set of invariants that **converge** on the Rank-4 module contract — but never cites it, and misses one of its three assertions outright. That is finding **`NTF-AL-B2`**, and it is the substance of this record.

---

## 2. Check 1 — Context ownership is exclusive

**Authority:** BC Map §3; **L131** — `BC-22` *"Owns channel selection, templates, deduplication, quiet hours, delivery guarantees, consent/unsubscribe."*

### 2.1 Scan for a competing claimant

| Probe | Result |
|---|---|
| Files containing `DeliveryMessage` | **3** — BC Map (**L205**, definitional), `PRD-010` (claimant), `PRD-021A_A7` (**L211**) |
| Does `A7` **claim** it? | ⛔ **NO.** L211 reads *"distinguishes a `BC-22` `DeliveryMessage` from an in-app feed item"* — a **citation**. A7 §0.4 states *"This part owns no notification capability"* and §5 *"does NOT create `PRD-010`, or act as `PRD-010`"* |
| Registry `BC-22` claimants | **1** — `PRD_REGISTRY.md` **L247** |

### 2.2 Mirror test — does `PRD-010` claim another context's aggregate?

| Term | Occurrences | Character |
|---|---|---|
| `Conversation` | 3 | ⭐ **All** evidence citations or **prohibitions** (`NTF-XC-001`) |
| `Message` | 7 | Same — `BC-12` attribution |
| `FeedItem` | 1 | Cited from BC Map **L205**, which assigns the inbox projection **to `BC-22`** |
| `ModerationCase` / `AuditEntry` | 0 | ⛔ Never claimed |

### 2.3 Result — ✅ **PASS · NON-CONFLICT**

One claimant, one aggregate set. The subject's §5 non-scope table excludes **15** capabilities by owner, each with a citation.

---

## 3. Check 2 — Every integration edge exists in BC Map §7

**Authority:** BC Map §7; **L292** — *"if an edge is not in this table, it does not exist."*

| Edge cited | Exists in §7? | Direction as cited | Disposition |
|---|---|---|---|
| **`E-23`** All contexts → `BC-22`, `PL`, Event (**L332**) | ✅ **YES** | Inbound to `BC-22` — correct | **NON-CONFLICT** |
| `E-16` `BC-11 → BC-12`, `C/S` (**L320**) | ✅ **YES** | Cited only to **disclaim** it | **NON-CONFLICT** |
| `E-25` `BC-20 → BC-31`, `CF` (**L334**) | ✅ **YES** | Cited as *precedent* for vendor-name exclusion | **NON-CONFLICT** |
| `E-14` `BC-13 → BC-11/12/14/15` (**L318**) | ✅ **YES** | Cited to disclaim enforcement | **NON-CONFLICT** |

⚠ **One false positive corrected during review:** an initial mechanical scan reported `E-09`. It is a substring of **`MP-SCOPE-09`**, not an edge citation. ⭐ Recorded because a reviewer who silently dropped it would leave the next reviewer to re-derive it.

### 3.1 The edge the subject could have invented, and did not

⭐⭐ A chat-message notification requires `messaging.MessageSent` to reach `BC-22`. **L431** lists its consumers as **`BC-13` (sampling), `BC-26`** — ⛔ `BC-22` absent. The subject **registered `NTF-GAP-011`** instead of adding a consumer. **`NTF-XC-004`** states no edge is created.

### 3.2 Result — ✅ **PASS · 4/4 edges exist · 0 invented**

---

## 4. Check 3 — Rank direction is downward · ⭐ resolves prior finding **F1**

**Authority:** Matrix `L2` (**L49**) — *"A module may depend only on modules of **strictly lower rank**. Same-rank dependencies are forbidden **except within a declared cluster**."*

### 4.1 `BC-22` = `platform/communication`, established by three live sources

⚠ The BC Map and the Matrix contain **no** `BC-22` → module mapping row; the previous review recorded **F1 INDETERMINATE** for this reason. The mapping is nevertheless established:

| Source | Text |
|---|---|
| `DEVELOPER_HANDOFF.md` **L189** | *"Library Management never calls `platform/communication/**` — `X-04` — emit a fact (`LEV-*`), let **`BC-22`** deliver it"* |
| `INVITATION_SECURITY_SPECIFICATION.md` **`IAC-23`** | *"Invitations are delivered only via **`BC-22`** event emission \| This module imports `platform/communication/**`"* |
| `REVIEW_14A.md` **`CC-5`** | *"Library Management emits facts (`LEV-1`…`LEV-28`); **`BC-22`** delivers. No import of `platform/communication`"* |

⇒ ⭐⭐ **F1 is now RESOLVED, not by assumption but by triangulation.** Three independent live documents use `BC-22` and `platform/communication` interchangeably.

### 4.2 The declared module surface — `tool/module_dependencies.yaml` **L392-410**

```yaml
platform/communication:
  rank: 5
  imports:  [ { target: contracts, mode: import } ]
  ports:
    - platform/integration:connector
    - platform/identity:notification_address      # AMENDMENT A-3
  consumes_events: ["*"]
  banned_imports: ["domain/**", "app/**"]
```

| Dependency | Target rank | `L2` test |
|---|---|---|
| `contracts` (import) | **0** | ✅ 5 → 0 downward |
| `platform/identity:notification_address` (port) | **4** | ✅ **5 → 4 strictly lower — downward** |
| ⚠ `platform/integration:connector` (port) | ⚠ **5** | ⚠ **SAME RANK** — §4.4 |

### 4.3 `consumes_events: ["*"]` is not an `L2` breach

⭐ The widest surface in the manifest, and lawful: event consumption is **`PL`** (Published Language) over `E-23`, not an import. The subject's **`NTF-INV-002`** and **`NTF-XC-005`** independently forbid synchronous domain calls, and `banned_imports: ["domain/**","app/**"]` bars the import route. Precedent: `PRD-016` §4.4 dispositioned the identical construct for `platform/audit`. **NON-CONFLICT.**

### 4.4 ⚠⚠ A pre-existing same-rank port, disclosed and NOT repaired — `NTF-AL-F2`

`platform/communication` (**rank 5**) declares a port to `platform/integration` (**rank 5**, yaml **L40**). `L2` forbids same-rank dependencies *"except within a declared cluster"*, and Matrix **§3.2** declares **exactly two** clusters — *Core Library* and *Social* — ⛔ **both within R8**. There is **no rank-5 platform cluster**, and the yaml `exceptions:` block (L619-714) contains **no** communication→integration entry.

| Question | Answer |
|---|---|
| Is this created by `PRD-010`? | ⛔ **NO.** It is a **pre-existing manifest fact** predating the subject |
| Does `PRD-010` rely on it? | ⚠ **Yes, indirectly** — `NTF-FR-031` routes Push through `BC-31`, citing `MASTER_PRD` **L229** |
| Does the boundary checker flag it? | ⛔ **No** — it reports only the nine `ADR-0012` `app → domain/library` code violations; the manifest's own graph is not rank-audited by that tool |
| Contrast case | ⭐ `platform/ai` is **rank 6** → integration **rank 5**: lawfully downward. Communication is the **only** same-rank porter |
| Disposition | ⚠ **OPEN — Architecture Owner.** ⛔ **NOT repaired here**: amending the manifest or declaring a cluster is an ADR act (Matrix **L54** — *"L2–L5 admit exceptions only through the ADR process"*), and this review holds no such authority |

⭐ Precedent for disclosing rather than fixing: `ADR-0098` §5.1 left a pre-existing defect *"routed, not repaired as a side effect."*

### 4.5 Result — ✅ **PASS for the subject** · ⚠ **`NTF-AL-F2` OPEN against the manifest**

⭐ **The distinction is deliberate.** Every dependency `PRD-010` *itself* asserts is downward (5→0, 5→4). The same-rank port is a Rank-4 manifest condition the subject neither created nor can cure. Failing the subject for it would punish the wrong document.

---

## 5. Check 4 — No authorisation decided outside `BC-18`

**Authority:** `X-13`; `Library_PRD_v1.md` **L612** `LIB-15.3` — modules *"MUST NOT decide, store or evaluate permissions"*; `AUTH-7.3`.

| Probe | Finding |
|---|---|
| **`NTF-INV-004`** | *"`BC-22` **MUST NOT** decide, store or evaluate a permission; it **MUST** ask `BC-18` at action time"* — ⭐ verbatim compliance |
| **`NTF-BR-003`** | *"Authorization **MUST** be evaluated at action time by `BC-18`; a stale grant **MUST NOT** authorize a dispatch"* |
| §11 permission matrix | ⚠ Labelled **`[PROPOSED]`**, registered as **`NTF-GAP-008`** *"pending the Authorization PRD's authority"* — ⭐ **the matrix is an input to `BC-18`, not a decision** |
| ⭐ Corroboration | yaml **L220**: `identity.policy_decision` — *"ask `BC-18`, never evaluate or cache"* |

### 5.1 Result — ✅ **PASS · NON-CONFLICT**

⭐ **A candidate finding was tested and rejected here** — see §10 `R-4`: publishing a matrix is not deciding authorization, provided it is marked proposed and routed, which it is.

---

## 6. Check 5 — No credential, OTP or session outside `BC-18`

**Authority:** `ID-1` — Matrix yaml **L235**: *"`*.mobileNumber` — rule `ID-1` — **the number is a credential, held by `BC-18`**."*

| Probe | Result |
|---|---|
| Credential-class terms in subject | **12** occurrences |
| Character of each | ⭐ **Every one** is an exclusion (`N7`, `N8`), a prohibition (`NTF-INV-003`, `NTF-FR-027`, `NTF-FR-058`), or an evidence citation |
| OTP generation / delivery | ⛔ Excluded at **`N7`** → `BC-18` / Auth PRD |
| Provider credentials | ⛔ Excluded at **`N8`** → `BC-31`; **`NTF-INV-005`** |
| Mobile number in events | ⛔ **`NTF-INV-003`** bars it inbound **and** outbound (`MP-GBR-34`) |

### 6.1 Result — ✅ **PASS · NON-CONFLICT**

⭐ **The subject is stronger than `ID-1` requires**: `MP-GBR-34` bars numbers in *events*; `NTF-FR-058` extends the ban to **notification bodies and logs** — volunteered, not mandated.

---

## 7. Check 6 — Tenant scoping correct

**Authority:** `MP-GBR-08`, `X-13`; failure mode `MP-RSK-01` **Critical**; `MP-GBR-21` closed scope register; `MP-GBR-22` denial-indistinguishability.

| Requirement | Text |
|---|---|
| **`NTF-INV-008`** | *"No recipient set, preview, count, history record or delivery record may span two tenants"* |
| **`NTF-INV-010`** | *"Cross-tenant recipient access **MUST** be impossible **by construction, not by filtering**"* |
| **`NTF-FR-006`** | `tenantWide` bounded by exactly one `TenantId`; a spanning set **MUST** be rejected |
| **`NTF-FR-005`** | Every audience resolves to `self` / `guardianOf` / `tenantWide` — ⭐ `MP-GBR-21`'s closed set |
| **`NTF-FR-008`** | Denial indistinguishable from not-found — ⭐ `MP-GBR-22` |
| **`NTF-FR-009`** | Counts may be shown; identities **MUST NOT** be enumerable beyond independent authorization |
| **`NTF-FR-052`** | Configuration **MUST NOT** widen an audience beyond the three scopes |

### 7.1 Result — ✅ **PASS · NON-CONFLICT**

⭐ Two enumeration surfaces the subject closed without being asked: **preview counts** (`NTF-FR-009`) and **error/timing channels** (`NTF-FR-056`).

---

## 8. ⭐⭐⭐ `NTF-AL-B2` — the `platform/communication` contract, reconciled

**This section discharges blocker B2 of the prior review.**

### 8.1 The authoritative contract, recorded verbatim

`tool/module_dependencies.yaml` **L392-410** (Rank 4):

| Element | Value |
|---|---|
| Module | **`platform/communication`** = **`BC-22`** (§4.1) |
| **Rank** | **5** |
| Imports | `contracts` (rank 0) |
| **Port** | `platform/integration:connector` |
| **Port** | **`platform/identity:notification_address`** — **AMENDMENT A-3**, *"the narrow, purpose-limited delivery-address port. Resolves ONE address for ONE queued delivery, at delivery time. Closes `QA-24`. **This port is the reason no event ever carries a number.**"* |
| Events | `consumes_events: ["*"]` |
| Banned imports | `["domain/**", "app/**"]` |
| **`CM-1`** | *"`notification_address` is called with an `AccountId` and a delivery purpose; **never with a number, never in bulk, never to test existence**"* |
| **`CM-2`** | *"**no resolved address is persisted, cached, indexed or logged** by this platform"* |
| **`CM-3`** | *"an unresolvable address **fails the delivery only; it never fails the emitting operation**"* — `# EBR-1030` |

Port constraint, yaml **L462-464**: *"one address, one queued delivery, resolved at delivery time, **never retained by the caller**"*, consumers `[platform/communication]`.

### 8.2 Alignment test — clause by clause

| Contract clause | Subject position | Verdict |
|---|---|---|
| Rank 5 | ⛔ **not stated** (`"rank 5"` = 0 hits) | ⚠ **OMISSION** |
| `contracts` import only | ⛔ not stated | ⚠ OMISSION |
| Port `connector` | ⚠ Implied — `NTF-FR-031` routes Push via `BC-31`; port **not named** | ⚠ OMISSION |
| Port `notification_address` (A-3) | ⛔ **not stated** (0 hits) | ⚠ **MATERIAL OMISSION** |
| `consumes_events: ["*"]` | ⭐ **Substantively aligned** — `NTF-XC-004` restricts intake to `E-23`; §4.3 | ✅ **ALIGNED** |
| `banned_imports: domain/**, app/**` | ⭐ **Aligned** — `NTF-INV-001`, `NTF-FR-003`, `NTF-XC-005` forbid domain reads/calls | ✅ **ALIGNED** |
| **`CM-1`** never a number / never bulk / never existence-test | ⭐ **Aligned in substance** — `NTF-INV-003` (no number), `NTF-FR-009` (no enumeration), `NTF-FR-004` (resolve per delivery, never a cached list) | ✅ **ALIGNED, uncited** |
| **`CM-2`** never persisted/cached/indexed/logged | ⭐ **Aligned** — `NTF-FR-058` bars phone/email from bodies, events **and logs**; `NTF-FR-004` bars cached lists | ✅ **ALIGNED, uncited** |
| ⛔ **`CM-3` / `EBR-1030`** unresolvable address fails **the delivery only** | ⛔⛔ **NO CORRESPONDING REQUIREMENT.** Nearest is `NTF-FR-003` — a template-field failure — which is a **different trigger** and states no boundary protecting the **emitting business operation** | 🚫 **GAP — ACCEPTED FINDING** |

### 8.3 Disposition

> ### ⚠ `NTF-AL-B2` — **ACCEPTED. A subject amendment is REQUIRED.**

⭐⭐ **The subject contradicts nothing.** On all three assertions it either aligns or is silent; it independently converged on `CM-1` and `CM-2` from Rank-1 rules. ⛔ **But `CM-3`/`EBR-1030` is a normative Rank-4 rule the subject nowhere states**, and it is the assertion that protects **other contexts**: a notification failure must never fail the membership renewal, fee posting, or check-in that emitted the fact.

**Required correction — the minimum, and it is additive:**

| # | Correction | Governance path |
|---|---|---|
| **C-1** | Add a requirement stating that an unresolvable delivery address fails **that delivery only** and **never** the emitting business operation, citing **`CM-3`** and **`EBR-1030`** | Subject edit at **Stage 2/3 revision** → **v0.2**. ⛔ No ADR needed — it **adopts** an existing rule, creating none |
| **C-2** | Cite the module contract in the ownership section: `platform/communication`, rank 5, ports `connector` and `notification_address` (**A-3**), `banned_imports`, and assertions `CM-1`/`CM-2`/`CM-3` | Same revision. ⭐ Converts three **uncited convergences** into traceable citations |

⛔ **Neither correction is applied here.** This record may not modify the subject — `PRD_LIFECYCLE.md` gives Stage 3 the power to *name and disposition* conflicts, not to rewrite the PRD, and the task mandate forbids it. ⭐ **Owner: the PRD-010 author, at Stage 2/3 revision.** ⛔ No frozen document, no ADR, no manifest change is required for either.

---

## 9. Known findings — preserved and dispositioned

| Gap | Status | Evidence | Owner | Blocks Stage 3? |
|---|---|---|---|---|
| `NTF-GAP-001` prefix registration | ⛔ **OPEN** | `NTF-` = 8 hits, **all** in `docs/90-archive/`, which baseline **§3.5** says *"must not be cited as authority"*; `NOTIF-`/`COM-` = 0 | Governance Owner | ⛔ **No** — Stage **5** gate |
| ⭐ `NTF-GAP-002` platform scope | ⛔ **OPEN — correctly refused** | `MP-GBR-21` **L120**: register *"closed: `self`, `guardianOf`, `tenantWide`. **No fourth scope… without an ADR**"*; *"Platform Admin"* measured **0** in BC Map / Ownership Model / Auth PRD | **ADR + Product Owner** | ⛔ **No** — named with disposition |
| ⭐ `NTF-GAP-005` six missing events | ⛔ **OPEN** | Re-verified BC Map §8 independently: no grace-period, `fee.PaymentFailed`, outstanding-balance, absence or staff-lifecycle route to `BC-22`. `MembershipFrozen`/`Unfrozen` (**L413**) → `BC-05`/`BC-04`/`BC-26` only | Architecture + Product Owner | ⛔ **No** — absent entries, not wrong ones |
| ⚠ `NTF-GAP-006` BC Map vs Auth | ⛔ **OPEN — real contradiction** | BC Map **L437** routes `iam.*` → `BC-24`, `BC-26` **only**; Auth §10 lists *"notification"* as consumer (**L91**, L111, L121, L141, L203) and **`AUTH-10.3`** requires Auth *"MUST only determine that one is warranted and emit the fact"*. ⭐ **Two Rank-3 documents disagree** | **Architecture Owner** | ⛔ **No** for the gate; ⚠ **blocks the security-notice catalogue** |
| ⭐ `NTF-GAP-011` `messaging.MessageSent` | ⛔ **OPEN — verified accurate** | **L431** consumers = `BC-13` (sampling), `BC-26`; ⛔ **`BC-22` absent**. With **L292**, no lawful trigger exists | **Architecture Owner** | ⛔ **No** — ⭐ the subject refused to invent an edge |
| ⚠ `NTF-GAP-021` Push / `BC-31` | ⛔ **OPEN — subject text is STALE** | §10 |Product + Architecture Owner | ⛔ **No** — ⚠ blocks Stage 6 sequencing |
| `NTF-GAP-003`, `004`, `007`, `009`, `010`, `012`, `014`, `015`, `017`, `018`, `022`, `023` | ⛔ **OPEN** | Timing, moderator audience, bulk limits, scheduling, inbound, redirect audit, localization, mandatory-classification, push semantics, retry values, edge cases | Product / Architecture Owner as recorded | ⛔ **No** — Stage 4 will require defaults+ranges |
| `NTF-GAP-008` permission matrix | ⛔ **OPEN** | §5; correctly routed to `BC-18` | Authorization owner | ⛔ **No** |
| `NTF-GAP-013` redirect ownership | ⛔ **OPEN** | ⭐ Self-raised: redirect may belong to `BC-01` | Architecture Owner | ⛔ **No** |
| `NTF-GAP-016` `BC-25` contested | ⛔ **OPEN** | `PRD_REGISTRY.md` **L148** records `BC-25` ownership *"Contested"* | Architecture Owner | ⛔ **No** |
| `NTF-GAP-019`, `020` | ⛔ **OPEN** | Config keys; SLO/SLI. ⭐ `ADR-0102`'s SRE office was `PRD-015`-only — `ADR-0033` §7.1 bars reuse, and the subject did **not** borrow it | Architecture Owner / SRE | ⛔ **No** |

⭐⭐ **No gap is closed by this record.** The Stage-3 gate requires conflicts *"closed **or explicitly deferred with a reason and an owner**"* — the latter is satisfied for all 23.

### 9.1 ⚠ `NTF-GAP-021` — the subject's dependency text is factually stale

| Claim in subject §24 | Measured now |
|---|---|
| *"`PRD-019` is a `DRAFT` with **0 identifiers**"* | ⛔ **STALE.** `PRD-019_INTEGRATION.md` self-declares **v0.4 — DRAFT** with **111 `ITG-*` identifiers** (54 obligation-bearing + 54 `ITG-AC-*` + 3 `ITG-GAP-*`) |

⚠ **The registry is itself internally inconsistent** and this is disclosed rather than resolved: `PRD_REGISTRY.md` **L319** says `PRD-019` **v0.1**, while **L545** says **v0.4**. The document's own header (v0.4) is treated as controlling for this review, on the registry's own §8 rule 5 — *"If this register disagrees with a PRD, fix this register"* — ⛔ **which is a Governance Owner act, NOT performed here.**

⇒ **Disposition: `NTF-AL-F3` — ACCEPTED as a factual correction**, folded into the same subject revision as `C-1`/`C-2`. ⭐ The *dependency itself remains valid*: `MASTER_PRD` **L229** routes Push through `BC-31`, and yaml **L397** shows the `connector` port exists, so the dependency is **real, declared, and not blocked** — merely un-frozen.

---

## 10. ⭐ Candidate findings REJECTED — with reasons

| # | Candidate | Rejected because |
|---|---|---|
| `R-1` | *`E-09` is an undeclared edge* | ⛔ **Substring artefact** of `MP-SCOPE-09`. Not an edge citation |
| `R-2` | *`PRD-021A_A7` co-claims `DeliveryMessage`* | ⛔ A7 **cites**, never claims; its §0.4 disclaims all notification capability |
| `R-3` | *`consumes_events: ["*"]` breaches `L2`* | ⛔ `PL` event consumption is not an import; `PRD-016` §4.4 precedent |
| `R-4` | *§11's matrix decides authorization, breaching `X-13`* | ⛔ Marked `[PROPOSED]`, routed to `BC-18` via `NTF-GAP-008`. Proposing ≠ deciding |
| `R-5` | *`NTF-FR-004` (resolve guardians at delivery) breaches `CM-1`* | ⛔ **Opposite** — `CM-1` requires per-delivery resolution; a cached list is what it forbids. The subject **complies** |
| `R-6` | *The WhatsApp redirect is an undeclared channel* | ⛔ `NTF-FR-023` makes it a **UI action over already-visible contact data**, creating no `DeliveryMessage`. Not a channel ⇒ no port needed |
| `R-7` | *23 open gaps fail Stage 3* | ⛔ The gate requires **disposition**, not closure. `PRD-016` passed with 5 open items |
| `R-8` | *`NTF-AL-F2` (same-rank port) should fail the subject* | ⛔ Pre-existing **manifest** condition; the subject asserts only downward dependencies. Failing it punishes the wrong document |
| `R-9` | *The stale `PRD-019` version invalidates the dependency* | ⛔ The dependency is **more** substantiated now (111 identifiers, port declared), not less. Only the descriptive text is stale |

---

## 11. Product-scope alignment (recorded, non-gating)

### 11.1 Role model — ✅ authoritative

`Library_PRD_v1.md` **L596**: **Owner · Manager · Reception Staff**. ⭐ The subject uses **"Reception Staff"**, the repository's actual term, and **`NTF-BR-001`** states Staff *"MUST NOT inherit Manager or Owner communication capability."* Staff holds **no** default grant in §11. Authorization remains with `BC-18` (§5). **NON-CONFLICT.**

### 11.2 WhatsApp — ✅ compliant

Verified **absent**: Business API · Cloud API · webhook · provider integration · credentials · delivery tracking · inbound sync · Liboora-side history · Business templates. Excluded at **`N6`** and **`NTF-FR-025`**/**`-026`**. Evidence: EA **L1502**/**L1821** tier WhatsApp Business at **V3**; `MP-SCOPE-09` tiers WhatsApp as a channel at **V2**. Model is exactly *Liboora → external conversation → human sends*. **NON-CONFLICT.**

### 11.3 Automatic catalogue — ✅ re-verified

**13** entries re-derived independently from BC Map §8 (**L405-436**). **13/13 map to events already routed to `BC-22`. 0 invented events. 0 invented timings.** Consistent with `PRODUCT_IMPLEMENTATION_ROADMAP.md` **L144** (*"Needs real facts to notify about"*) and `PRD_DEPENDENCY_GRAPH.md` **`D-12`**. **NON-CONFLICT.**

### 11.4 Channel model — ✅ Rank-1 compliant

V1 = **In-App + Push only**. `MP-SCOPE-09` and §22 tier SMS-general/Email/WhatsApp at **V2**; `NTF-FR-030` forbids adding them without an ADR. **NON-CONFLICT.**

### 11.5 Deferred to Stage 4

⚠ **`NTF-FR-017`, `-037`, `-040`, `-044`, `-049`, `-054`, `-065`** are gap-pointers, not testable requirements; configurables lack **defaults and ranges**; AC coverage is **8** against ~84 obligation-bearing requirements. **DEFERRED — Stage 4**, whose gate expressly requires *"a default and a range"*.

---

## 12. Verdict

> ## ⚠ **ALIGNED WITH ONE REQUIRED CORRECTION — Stage 3 checks 6 of 6 PASS**

| # | Check | Authority | Result |
|---|---|---|---|
| 1 | Context ownership exclusive | BC Map §3, L131, L205 | ✅ **PASS** — 1 claimant; 3 `DeliveryMessage` files, only 1 claims it; mirror test clean |
| 2 | Every edge exists in §7 | BC Map §7, L292 | ✅ **PASS** — **4/4 exist, 0 invented**; 1 false positive corrected |
| 3 | Rank direction downward | Matrix `L2`, yaml L392 | ✅ **PASS** — 5→0, 5→4; ⭐ **F1 RESOLVED** by triangulation; ⚠ `NTF-AL-F2` OPEN against the manifest |
| 4 | No authorisation outside `BC-18` | `X-13`, `LIB-15.3` | ✅ **PASS** — `NTF-INV-004` verbatim; matrix is `[PROPOSED]` |
| 5 | No credential/OTP/session outside `BC-18` | `ID-1` | ✅ **PASS** — 12 terms, **every one** a prohibition or citation |
| 6 | Tenant scoping correct | `MP-GBR-08`, `X-13`, `MP-GBR-21/22` | ✅ **PASS** — impossible-by-construction; closed scope set |

**0 contradictions of any Rank 1–5 rule.** **1 ACCEPTED finding requiring a subject amendment** (`NTF-AL-B2` — `CM-3`/`EBR-1030` unstated, plus uncited contract). **2 further accepted corrections** (`NTF-AL-F3` stale `PRD-019` facts; `C-2` citations). **1 pre-existing manifest condition disclosed, not repaired** (`NTF-AL-F2`). **23 gaps dispositioned, 0 closed.** **9 candidate findings rejected with reasons.** **1 registry inconsistency recorded, not fixed.**

### 12.1 ⛔ Why this is not yet a bare "Stage 3 PASS"

`NTF-AL-B2` is an **ACCEPTED** finding: the subject omits a normative Rank-4 rule (`CM-3`/`EBR-1030`) that protects **other** bounded contexts from notification failures. ⭐ The lifecycle's Stage-3 gate is *"conflicts named and dispositioned"* — satisfied by this record — but an accepted finding whose remedy is **a subject amendment** cannot be discharged by the reviewer without becoming the author.

⇒ **Minimum governance-compliant next action:** the PRD-010 author applies **`C-1`** and **`C-2`** (and folds in `NTF-AL-F3`) as **v0.2**, then this record is re-verified by supplement. ⛔ **No ADR, no frozen-document change, and no manifest amendment is required** — both corrections **adopt** existing rules rather than create any.

⭐ **What this review could not do, and correctly did not attempt:** repair `NTF-AL-F2`'s same-rank port, resolve `NTF-GAP-006`'s two-Rank-3 contradiction, or correct `PRD_REGISTRY.md`'s internal v0.1/v0.4 disagreement. Each is measured, named, and given an owner.

**Status unchanged:** subject remains **v0.1a `DRAFT`**; `PRD_REGISTRY.md` remains **`PLANNED`**; baseline unchanged.

---

## 13. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-05 | ⭐⭐ **Created as the Stage-3 alignment record for `PRD-010`, discharging prior blocker B1 (artefact absent).** All **6** lifecycle checks re-run against the live repository: **6 PASS**, **0 contradictions** of any Rank 1–5 rule. ⭐⭐⭐ **Prior finding F1 (rank direction INDETERMINATE) is RESOLVED** — the `BC-22` ⇄ `platform/communication` mapping, absent from both the BC Map and the Matrix, is established by **triangulation** across three live documents (`DEVELOPER_HANDOFF` **L189**, `IAC-23`, `REVIEW_14A` **`CC-5`**), giving rank **5** → `contracts` **0** and → `platform/identity` **4**: both strictly downward. ⭐⭐⭐ **Prior blocker B2 is RECONCILED CLAUSE BY CLAUSE (§8)**: the subject **contradicts nothing** and independently converges on **`CM-1`** and **`CM-2`** from Rank-1 rules, but ⛔ **`CM-3`/`EBR-1030` — an unresolvable address must fail the delivery only, never the emitting business operation — has NO corresponding requirement**, so `NTF-AL-B2` is **ACCEPTED** with two additive corrections (`C-1`, `C-2`) routed to a subject **v0.2**; ⛔ **the subject was NOT edited here**, because Stage 3 dispositions conflicts and does not rewrite the PRD. ⚠⚠ **A pre-existing `L2` anomaly is DISCLOSED and NOT repaired** — `platform/communication` (rank 5) ports to `platform/integration` (**also rank 5**) while Matrix **§3.2** declares only **two** clusters, both within **R8**, and the yaml `exceptions` block contains no such entry; `platform/ai` (rank 6) is the lawful contrast case. Recorded as **`NTF-AL-F2`**, owner **Architecture Owner**, on the `ADR-0098` §5.1 *"routed, not repaired"* precedent — ⛔ and it is expressly **NOT** allowed to fail the subject, which asserts only downward dependencies. ⚠ **`NTF-GAP-021`'s subject text is measured STALE** — `PRD-019` is **v0.4 DRAFT with 111 `ITG-*` identifiers**, not *"0 identifiers"*; ⚠ and `PRD_REGISTRY.md` **contradicts itself** (L319 v0.1 vs L545 v0.4), which is **disclosed, not fixed**, being a Governance Owner act. ⭐ **All 23 `NTF-GAP-*` dispositioned with owners and 0 closed**; `NTF-GAP-002` (no fourth scope without an ADR), `005` (six absent events), `006` (BC Map **L437** vs Auth §10 — **two Rank-3 documents disagree**), `011` (`messaging.MessageSent` verified **not** routed to `BC-22`) each **re-verified independently** rather than accepted from the draft. ⭐ **9 candidate findings REJECTED with reasons (§10)**, including two that would have wrongly failed the subject. Role model confirmed **Owner · Manager · Reception Staff** with no Staff inheritance; WhatsApp confirmed **external redirect only**; catalogue re-verified **13/13 real events, 0 invented**. ⛔ **Mandate observed absolutely: 0 PRD bytes changed (`sha256` `b5b0d41d…507105` verified before and after), 0 ADRs created or modified, 0 frozen documents, 0 registry or baseline updates, 0 identifiers registered, 0 gaps closed, 0 events invented, 0 authorization scopes invented, 0 implementation tasks, 0 lines of application code.** |
