# LIBOORA — Master Product Requirements Document

| Field | Value |
|---|---|
| **Document** | Master PRD |
| **Version** | v1.5 |
| **Supersedes** | v1.2 · v1.1 (refined) · v1.0 (Foundation Document) |
| **Status** | Foundation Document — aligned to Enterprise Architecture v2.1 |
| **Governance position** | `FOUNDATION → Master PRD (V1)` in the Enterprise Architecture tree |
| **Aligned to** | `LIBOORA_ENTERPRISE_ARCHITECTURE.md` v2.0 · `LIBOORA_BOUNDED_CONTEXT_MAP.md` **v1.2** · `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` v1.0 |
| **Identifier namespace** | `MP-*` — reserved exclusively for this document, collision-free against every other register |
| **Rulings applied** | `AR-1`, `AR-2`, `AR-5`, `AR-6`, `AR-7` — see [`../architecture/ARCHITECTURE_RULINGS.md`](../10-architecture/ARCHITECTURE_RULINGS.md). (`AR-3`, `AR-4` affect the Bounded Context Map and Library PRD, not this document.) |

---

## 1. Document Purpose

This Master PRD defines the overall vision, architecture posture, product principles, module boundaries, business rules, and engineering standards for LIBOORA.

This document does **not** contain detailed feature specifications for individual modules. Those are maintained in their own dedicated PRDs.

This document acts as the **Single Source of Truth for the product**.

### 1.1 What this document is not

Three boundaries, added to stop this document drifting into territory owned elsewhere:

| This document does not | Owner instead |
|---|---|
| Define the architecture | `LIBOORA_ENTERPRISE_ARCHITECTURE.md` v2.0 — **approved, final, not modifiable by this PRD** |
| Define model boundaries or integration edges | `LIBOORA_BOUNDED_CONTEXT_MAP.md` v1.0 |
| Define what code may import what | `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` v1.0 |
| Record architecture decisions | ADR Summary / Architecture Decision Log |
| Specify module features | The per-module PRDs listed in §31 |

Where this PRD restates architecture, it restates it **by reference and in summary only**. If a discrepancy is ever found between this PRD and the Enterprise Architecture, **the Enterprise Architecture wins** and this PRD is defective.

### 1.2 Product name

The product is **LIBOORA** (double `o`). The spelling `Libora` is incorrect and must not appear in any artifact. This was corrected in the codebase at commit `e1ec088`; the repository currently contains zero occurrences of the single-`o` form.

---

## 2. Product Vision

LIBOORA is a cloud-based, AI-powered Library Management SaaS platform designed for modern libraries.

Its goal is to digitize every operational aspect of a library while providing an exceptional experience for library owners, staff, students, and parents.

LIBOORA is designed to evolve into a broader education platform in the future.

---

## 3. Product Mission

To become India's most trusted **Library Business Operating System** by helping library owners manage operations, students, revenue, attendance, seats, analytics, and communication from a single platform.

---

## 4. Product Objectives

| ID | Objective |
|---|---|
| **MP-OBJ-01** | Digitize library operations |
| **MP-OBJ-02** | Reduce manual work |
| **MP-OBJ-03** | Improve operational efficiency |
| **MP-OBJ-04** | Improve student experience |
| **MP-OBJ-05** | Increase owner profitability |
| **MP-OBJ-06** | Provide AI-powered assistance |
| **MP-OBJ-07** | Support multi-library SaaS deployment |
| **MP-OBJ-08** | Build a scalable foundation for future education products |

Every objective above is preserved verbatim from v1.0. Identifiers were added for traceability only.

---

## 5. Product Scope

*New section. v1.0 had no scope statement, which made "implementation-ready" unassessable.*

### 5.1 In scope for V1

The 23 V1 bounded contexts registered in the context map §3.4: `BC-01`→`BC-06`, `BC-10`→`BC-13`, `BC-18`→`BC-27`, `BC-29`→`BC-31`.

### 5.2 Explicitly out of scope for V1

| ID | Out of V1 | Arrives at |
|---|---|---|
| **MP-SCOPE-01** | Staff & Shift management, including staff attendance (`BC-07`) | V2 |
| **MP-SCOPE-02** | Inventory — books, furniture, devices (`BC-08`) | V2 |
| **MP-SCOPE-03** | Visitor management (`BC-09`) | V2 |
| **MP-SCOPE-04** | Content Sharing (`BC-14`), Community & Groups (`BC-15`) | V2 |
| **MP-SCOPE-05** | Workflow Orchestration / sagas (`BC-28`) | V2 |
| **MP-SCOPE-06** | Reputation (`BC-16`), Marketplace (`BC-17`) | V3 |
| **MP-SCOPE-07** | Multi-branch as a live product capability | V3 — but `branchId` **is** modelled in the V1 schema per open question `Q-02` |
| **MP-SCOPE-08** | School, College, Coaching, Hostel products | Future |
| **MP-SCOPE-09** | SMS, Email and WhatsApp as **general-purpose** notification channels | V2 — see §22 for the V1 OTP-delivery exception |

---

## 6. Target Users & User Roles

*Consolidated from v1.0 §5 (Target Users) and v1.0 §14 (User Roles), which listed the same five roles twice. No role, description or capability was lost.*

| Role | Enum value | Description (preserved from v1.0) | Identity | Tenancy of grant |
|---|---|---|---|---|
| **Library Owner** | `owner` | Complete business control. | `AccountId` | Per-library |
| **Manager** | `manager` | Daily operations management. | `AccountId` | Per-library |
| **Reception Staff** | `reception` | Student onboarding, attendance, memberships, seat allocation and support. | `AccountId` | Per-library |
| **Student** | `student` | Attendance, membership, profile, AI assistant, notifications and self-service. | `AccountId` + `StudentRecordId` (per library) + optional `PersonId` | Per-library |
| **Parent** | `parent` | Attendance visibility, fee updates and important notifications. | `AccountId` with guardian role | Per-library, scoped to guarded students |

### 6.1 Access control model

Each role follows **Role-Based Access Control (RBAC)**, extended with attribute-based scoping.

| ID | Rule |
|---|---|
| **MP-GBR-20** | A permission grant is **scope-bearing**. Holding a permission is not the same as being able to exercise it on a given resource. |
| **MP-GBR-21** | The scope register is closed: `self`, `guardianOf`, `tenantWide`. No fourth scope may be introduced without an ADR. |
| **MP-GBR-22** | A denial on a `self` or `guardianOf` scope must be **indistinguishable from not-found** — authorization must not disclose existence. |
| **MP-GBR-23** | One human holds **one global account** and **independent grants per library**. A role in one library confers nothing in another. |

**Parent identity is settled**, per context-map open question `Q-07`: the Parent receives a **full `Account` with a guardian role**, not a scoped view token, because the consent audit trail requires an accountable identity.

---

## 7. Product Principles

| ID | Principle |
|---|---|
| **MP-PRIN-01** | AI First |
| **MP-PRIN-02** | Mobile First |
| **MP-PRIN-03** | API First |
| **MP-PRIN-04** | Security by Design |
| **MP-PRIN-05** | Cloud Native |
| **MP-PRIN-06** | Modular Architecture |
| **MP-PRIN-07** | Multi-Tenant SaaS |
| **MP-PRIN-08** | Clean User Experience |
| **MP-PRIN-09** | Enterprise Quality |
| **MP-PRIN-10** | Future Ready |

All ten preserved verbatim. Enterprise Architecture §5 scores each of these as validated at 9/10 after the v2.0 review; this PRD does not re-litigate them.

---

## 8. Core Product Modules

Every module from v1.0 §7 is preserved. Two structural corrections were required for architecture alignment, both explained beneath the table.

| # | Product module (v1.0 name) | Owning bounded context | Type | V |
|---|---|---|---|---|
| 1 | Authentication | `BC-18` Identity & Access | `[GENERIC]` | V1 |
| 2 | Global Identity | `BC-10` Global Student Identity | `[SUPPORTING]` | V1 |
| 3 | Library Member Directory | `BC-01` Enrollment *(read composition)* | `[CORE]` | V1 |
| 4 | Student Management | `BC-01` Enrollment | `[CORE]` | V1 |
| 5 | Parent Portal | Composition over `BC-01`, `BC-03`, `BC-05` | *not a context* | V1 |
| 6 | Membership Management | `BC-02` Membership | `[CORE]` | V1 |
| 7 | Seat Management | `BC-04` Seating | `[CORE]` | V1 |
| 8 | Attendance Management | `BC-03` Attendance | `[CORE]` | V1 |
| 9 | Revenue & Finance | `BC-05` Fee & Collection | `[CORE]` | V1 |
| 10 | Owner Dashboard | Composition over read models | *not a context* | V1 |
| 11 | Manager Dashboard | Composition over read models | *not a context* | V1 |
| 12 | Reception Dashboard | Composition over read models | *not a context* | V1 |
| 13 | Notifications & Communication | `BC-22` Notification Delivery | `[GENERIC]` | V1 |
| 14 | Analytics & Reports | `BC-26` Analytics Read Model | `[GENERIC]` | V1 |
| 15 | AI Super Assistant | `BC-27` AI Assistance | `[SUPPORTING]` | V1 |
| 16 | Security & Automation | `SECURITY` platform + `BC-28` Workflow | mixed | V1 / V2 |
| 17 | SaaS Billing | `BC-20` Subscription & Billing | `[GENERIC]` | V1 |
| 18 | Settings & Configuration | `BC-25` Configuration | `[GENERIC]` | V1 |
| 19 | Library Discovery & Enrollment | Composition over `BC-19`, `BC-25`, `BC-29`, `BC-06`, `BC-02`, `BC-04`, projected via `BC-23` | *not a context* | V1 |

**Correction 1 — dashboards are not modules.** Context map §2 is explicit: *"Dashboards (Owner, Manager, Reception, Parent) are not contexts. They are presentation compositions over read models. They own no aggregate and no invariant."* They are retained in this list because they are real product surfaces with real requirements, but they are marked as compositions so no team builds an aggregate behind one.

**Addition — module 19, added by ruling `AR-1`.** Library Discovery & Enrollment is registered as an
**application / read composition capability of the Library domain**. Per `AR-1` it owns **no aggregate, no
invariant and no business state**; it orchestrates public read models and delegates every domain operation to
the owning module — registration to `BC-18` (ruling `AR-2`), membership creation to `BC-02`, student records to
`BC-01`. It is **not** a bounded context, so §5.1's V1 scope of 23 bounded contexts is unchanged, exactly as for
modules 5, 10, 11 and 12. Requirements are specified in `docs/30-product/library/`.

**Correction 2 — `Security & Automation` is two owners.** "Security" is the SECURITY platform (R2). "Automation" is Workflow Orchestration (`BC-28`, V2). A single module name spanning two owners at two ranks violates the Single Owner Rule (EA §10.1.1). The name is preserved; the ownership split is now explicit.

### 8.1 Bounded contexts absent from the v1.0 module list

The following V1 contexts carry product-visible obligations but had no module entry. Listed here so they receive requirements, budgets and owners.

| Context | Why the product needs it in V1 |
|---|---|
| `BC-19` Tenancy | Tenant lifecycle, tiers, quotas, residency. Nothing multi-tenant works without it. |
| `BC-21` Entitlement | Answers *"is this tenant allowed to do X, and how much is left?"* Every paid gate depends on it. |
| `BC-23` Search Indexing | Permission-aware, tenant-partitioned search. |
| `BC-24` Audit Trail | Required by global business rule "every critical action is auditable". |
| `BC-29` File & Media | Student documents, uploads, signed URLs, virus scan. |
| `BC-30` Offline Sync | Attendance capture in a basement with no signal — EA critique #9. |
| `BC-31` Integration | Outbound third-party contracts, retries, idempotent delivery. |
| `BC-11`, `BC-12`, `BC-13` | Social Graph, Messaging and **Trust & Safety**. T&S is `[CORE]` and, on a minor-heavy product, is existential legal risk — EA critique #8. |

---

## 9. Future Platform Modules

| ID | Module | Tag |
|---|---|---|
| **MP-FUT-01** | Global Student Network | Future |
| **MP-FUT-02** | LIBOORA School | Future |
| **MP-FUT-03** | LIBOORA College | Future |
| **MP-FUT-04** | LIBOORA Coaching | Future |
| **MP-FUT-05** | LIBOORA Hostel | Future |

Per EA §10.3, `Future` means: *do not design for it now, only avoid blocking it.* The Identity Triad (§15) is the specific structure that keeps these unblocked.

---

## 10. Technology Stack

**This section was materially corrected. See Conflict `MP-CFL-01` in the review report.**

The approved Enterprise Architecture v2.1 is **vendor-neutral by construction**. It names no database, no backend-as-a-service and no AI provider. Dependency Law L3 requires that *"domain code contains no vendor name, no SDK import, no HTTP client, no SQL."* A stack table that names a vendor as "the backend platform" contradicts that posture and, if implemented literally, would put a vendor inside the layered architecture.

The stack is therefore expressed as **capabilities with abstractions**, with vendors recorded as *candidate implementations behind ports*.

| Capability | Architectural owner | Abstraction that must exist | Candidate implementation (V1) | Approved in EA v2.1? |
|---|---|---|---|---|
| Client application | API/BFF + client | — | **Flutter** | Yes |
| Persistence | DATA platform (R2) | `data.repository` port | Managed PostgreSQL | **Not named in EA** — candidate only |
| Backend runtime | INFRASTRUCTURE (R1) | — | BaaS (e.g. Supabase) for V1 | **Not named in EA** — candidate only |
| File storage | `BC-29` File & Media | Storage Abstraction | BaaS storage | **Not named in EA** — candidate only |
| Push notifications | `BC-22` via `BC-31` Integration | Channel adapter | **Firebase Cloud Messaging** | **Yes — FCM (V1)** |
| Crash reporting | OBSERVABILITY (R3) | Telemetry port | **Firebase Crashlytics** | **Yes — Crashlytics (V1)** |
| AI inference | `BC-27` AI Assistance | AI Provider Abstraction + Regional Model Routing | LLM vendor | **Not named in EA** — candidate only |
| Payments | `BC-20` via `BC-31` | Payment Gateway Abstraction | Gateway | **Not named in EA** — candidate only |
| Event backbone | EVENT platform | Transactional Outbox | — | EVENT PLATFORM is tagged **V2** |

| ID | Rule |
|---|---|
| **MP-CON-01** | No vendor name may appear in domain code. Vendors live behind ports, wired at the composition root. |
| **MP-CON-02** | Choosing a BaaS for V1 is a **deployment decision, not an architecture decision**. It must not collapse the 25 approved platforms into a vendor's feature list. |
| **MP-CON-03** | The Data Layer must remain abstract so a dedicated backend can replace direct BaaS access later without affecting upper layers. *(Preserved verbatim from v1.0 §11.)* |

**Future:** Dedicated Backend APIs (Railway or equivalent) when business scale requires it. *(Preserved from v1.0 §9. Note this is the same future migration as v1.0 §10's "Service-Oriented / Microservices" — see Duplicate `MP-DUP-06`; the authoritative sequencing is the extraction order in context map §12.)*

---

## 11. Architecture Principles

Version 1 uses a **Modular Monolith**. Future: Service-Oriented / Microservices if required.

Every module remains independent. **No module directly accesses another module's database.**

This is confirmed by context map §12, which additionally supplies what v1.0 lacked — the **order** of extraction and, more valuably, what must *never* be extracted:

> `BC-01`/`02`/`04`/`05`/`06` are one transactional cluster. Splitting Enrollment from Membership from Fee introduces distributed transactions across invariants that genuinely need strong consistency. **They stay together.**

---

## 12. Layered Architecture

```
Presentation Layer
        ↓
Application Layer
        ↓
Domain Layer
        ↓
Data Layer
        ↓
[ Persistence Adapter ]   ← a swappable adapter, NOT a named vendor
```

**Correction:** v1.0 terminated this stack with `Supabase`. Naming a vendor as a layer contradicts the sentence immediately following it in v1.0 — *"The Data Layer must remain abstract so a dedicated backend can replace direct Supabase access later"* — a layer you can swap is an adapter, not a layer. The requirement is preserved as `MP-CON-03`; only the diagram was corrected.

---

## 13. Product Architecture Decisions

Architecture decisions are maintained separately inside the **ADR Summary** document.

Every engineering decision must comply with ADRs. Per EA §10.5, a change is proposed as an ADR, verified against the Single Owner Rule and the Duplicate Resolution Matrix, assigned a version tag, and registered in the Allowed Dependencies Matrix.

---

## 14. Module Dependency Rules

Modules communicate through defined interfaces. Direct database dependency between modules is prohibited. All cross-module interactions must follow documented APIs or service boundaries.

The normative form is `LIBOORA_MODULE_DEPENDENCY_MATRIX.md`. Its five laws are binding on this product:

| Law | Statement |
|---|---|
| **L1 — Acyclic** | The dependency graph is a DAG. **Zero exceptions.** |
| **L2 — Downward only** | A module depends only on strictly lower ranks (R0…R9). |
| **L3 — Domain never depends on capability implementations** | Domain declares ports; adapters are injected. |
| **L4 — Capability never depends on domain** | This is what makes microservice extraction a deployment change. |
| **L5 — Contracts import nothing** | `liboora_contracts` depends on the Dart SDK alone. |

Communication modes are as binding as the permission itself: `▪` direct import · `◇` port · `⚡` event · `⌘` command API · `⇥` edge/HTTP · `✖` forbidden. **Default when unspecified is `◇` port.**

---

## 15. Identity Model

*New section. It exists because a v1.0 global business rule contradicted the highest-risk modelling decision in the architecture.*

A single human appears in **three contexts with three identities and three lifecycles**. Collapsing them is the mistake that makes multi-library membership, privacy and account deletion unimplementable later.

| Identity | Owner | Scope | Lifecycle |
|---|---|---|---|
| `AccountId` | `BC-18` | Global | Created on first successful OTP. Credentials only. |
| `PersonId` | `BC-10` | Global | Created **only if** the human opts into the social product. **May never exist.** |
| `StudentRecordId` | `BC-01` | **Per-tenant** | Created when a library enrolls them. Three libraries ⇒ three records. Survives account deletion. |

| ID | Rule |
|---|---|
| **MP-GBR-01** | Every student has one **Account** (`AccountId`). *(Corrected from v1.0 — see Conflict `MP-CFL-02`.)* |
| **MP-GBR-02** | A **Global Identity** (`PersonId`) is **opt-in and may never exist**. Library operation must degrade gracefully when it is null. |
| **MP-GBR-03** | `StudentRecordId` **never** leaves its tenant — not in any global context, event or index. |
| **MP-GBR-04** | Account deletion deletes the Account and anonymises the Person. It does **not** delete StudentRecord financial and attendance history, which is retained under legal basis and pseudonymised. |
| **MP-GBR-05** | A minor's Account is linked to a guardian consent record before any social context is activated. |

---

## 16. Multi-Tenancy

*New section. v1.0 asserted "every library has isolated data" without stating how, or acknowledging that some contexts have no tenant at all.*

| Context group | Model | Enforcement |
|---|---|---|
| `BC-01`→`09` Library Management | **Tenant-scoped** — every row carries `tenantId` | Row-level security + mandatory tenant context. A query without a tenant predicate **fails at runtime rather than returning everything.** |
| `BC-10`→`17` Global Student | **Global** — no `tenantId`, keyed on `PersonId` | Must never receive a `StudentRecordId` or `tenantId` |
| `BC-18` Identity | **Hybrid** — Account global, role grants tenant-scoped | Policy always evaluated with a tenant in scope |
| `BC-19`→`31` Capability | **Tenant-aware** — carry and propagate, own no tenant data of record | Indices, caches, projections, prompts, embeddings and files are all tenant-partitioned |

| ID | Rule |
|---|---|
| **MP-GBR-06** | Every request carries a resolved tenant context. |
| **MP-GBR-07** | Every emitted domain event carries tenant context. A consumer that processes an event without establishing tenant context **fails loudly, never defaults**. |
| **MP-GBR-08** | Every search index and vector namespace is tenant-partitioned. Every RAG retrieval is tenant-scoped **and** permission-aware. |
| **MP-GBR-09** | A change to a cache key, index name or vector namespace is a **security-reviewable change**. Cross-tenant leakage via a capability context is the single highest-severity failure mode in the architecture. |

---

## 17. Global Business Rules

Every v1.0 rule is preserved. Four required precision to survive contact with the architecture; the original intent is preserved in each case and the change is justified inline.

| ID | Rule | Status vs v1.0 |
|---|---|---|
| **MP-GBR-01** | Every student has one Account; a Global Identity is opt-in (§15). | **Corrected** — v1.0 said "one Global Identity" |
| **MP-GBR-10** | Every library has isolated data (§16). | Preserved, now enforceable |
| **MP-GBR-11** | Attendance cannot be **silently** manipulated. Corrections exist, but are **append-only, carry an actor and a reason, and emit `attendance.AttendanceCorrected`**. | **Refined** — v1.0's absolute "cannot be manipulated" would have outlawed the correction workflow the domain requires |
| **MP-GBR-12** | Financial records are immutable. A receipt is immutable once issued; a refund is a **compensating entry, never a mutation**; ledger balance = Σ dues − Σ receipts and is never stored independently. | **Refined** — v1.0's "except through approved workflows" was a loophole that permits in-place edits |
| **MP-GBR-13** | Every critical action is auditable. The audit trail is **append-only with no update or delete path in code**; legal hold blocks purge. | Preserved, hardened |
| **MP-GBR-14** | Soft delete is preferred for important business data — **except where erasure is legally compelled**, in which case the Hard Delete Pipeline and anonymisation path execute. | **Corrected** — soft delete alone cannot satisfy Right to Erasure |
| **MP-GBR-15** | AI must respect permissions (§21). | Preserved, hardened |
| **MP-GBR-16** | A student may not be **seated** without a valid membership. Seating **blocks**; Attendance **records and flags** — a paying student is never locked out at the door. | **New — recovered from architecture.** This asymmetry is deliberate and documented so a future engineer does not "fix" it. |
| **MP-GBR-17** | One active seat allocation per seat per time window, enforced by a database constraint and a pessimistic lock — never optimistically. | **New — recovered** |
| **MP-GBR-18** | Attendance check-in is **idempotent** by `(studentRecordId, date, idempotencyKey)`. Payment capture is idempotent by gateway reference. | **New — recovered.** EA critique #10: *"double-charges and duplicate check-ins are inevitable at scale."* |
| **MP-GBR-19** | Policy changes are **versioned with `effectiveFrom` and never retroactive** — historical attendance stays judgeable under the rules live at the time. | **New — recovered** |
| **MP-GBR-20**…**23** | Scope-bearing authorization, closed scope register, non-disclosing denial, per-library grants (§6.1). | **New — recovered** |
| **MP-GBR-24** | Money owed by a **student to the library** (`BC-05`) is a different concept from money owed by a **library to LIBOORA** (`BC-20`). They must never share a model, a table or a metric. | **New — recovered** |

---

## 18. Security Principles

- OTP authentication
- RBAC
- Permission validation
- Audit logging
- Encrypted communication
- Secure storage
- Input validation
- Least privilege access

| ID | Addition |
|---|---|
| **MP-GBR-25** | **Mobile OTP is the sole authentication factor in V1. There are no passwords.** OTP is single-use with a TTL and a bounded attempt budget. |
| **MP-GBR-26** | Session revocation is **immediate and global** — authoritative-or-absent, with no propagation window. |
| **MP-GBR-27** | No context outside `BC-18` may store a password, OTP, session or credential. |
| **MP-GBR-28** | Enterprise SSO (SAML/OIDC), SCIM provisioning and ABAC are **V3** — required to pass enterprise procurement, not to launch. |

---

## 19. Data Standards

Every important entity should include:

| Field | Applies to |
|---|---|
| `UUID` | All |
| `created_at` | All |
| `updated_at` | All |
| `created_by` | All |
| `updated_by` | All |
| `deleted_at` | Where soft delete applies (see `MP-GBR-14`) |
| `tenant_id` | **Mandatory** for tenant-scoped contexts. **Forbidden** in global contexts. |
| `branch_id` | Modelled in V1 schema, default single branch (`Q-02`) |

**Correction:** v1.0 said `tenant_id (where applicable)`. That phrasing is too weak in one direction and too strong in the other. Tenant-scoped rows must carry it or the isolation guarantee is unenforceable; global rows must **not** carry it or rule `MP-GBR-03` is violated. "Where applicable" is now a decision rule, not a hedge.

---

## 20. API Standards

- REST API conventions *(and GraphQL where the BFF requires it — the Open Host Service edge is specified as "versioned REST/GraphQL")*
- Versioned endpoints
- Consistent response structure
- Validation errors
- Permission errors
- Audit logging

| ID | Addition |
|---|---|
| **MP-CON-04** | **OpenAPI is the source of truth** for API contracts, with a contract-testing gate in CI. |
| **MP-CON-05** | Idempotency keys are required at the API edge for every non-idempotent mutation. |
| **MP-CON-06** | Pagination is mandatory on every collection endpoint. |
| **MP-CON-07** | Permission errors must not disclose resource existence (`MP-GBR-22`). |

---

## 21. AI Strategy

AI is a core platform capability.

Supported assistants: **Library Assistant · Study Coach · Business Advisor**

AI capabilities: Smart Navigation · Recommendations · Context-aware assistance · Workflow guidance · Business insights

**AI never accesses the database directly. All requests pass through secure application logic.**

The architecture states this more strongly, and the stronger form is binding:

| ID | Rule |
|---|---|
| **MP-GBR-29** | No capability context — AI included — may import, reference or query a domain context. AI learns the domain **only** through published events and permission-aware ports. |
| **MP-GBR-30** | Where AI must *cause* a domain change, it invokes the domain's published command API through a port, and **the domain re-validates every invariant. The capability is an untrusted caller.** |
| **MP-GBR-31** | AI-initiated domain writes require a **Human-in-the-Loop approval record** and produce an AI Action Log entry. **No exceptions in V1.** |
| **MP-GBR-32** | **PII is redacted before egress to any model.** Retrieval is tenant- and permission-filtered — asserted per query, not assumed. |

`MP-GBR-31` and `MP-GBR-32` close EA critique #5: *"Your AI writes to production data with no human-in-the-loop and no PII redaction. That's an incident and a regulatory finding."*

---

## 22. Notifications Strategy

| Channel | v1.0 tag | Corrected tag | Reason |
|---|---|---|---|
| Push Notifications | V1 | **V1** | — |
| In-App Notifications | V1 | **V1** | — |
| **SMS — OTP delivery only** | Future | **V1 — mandatory** | See below |
| SMS — general messaging | Future | V2 | Unchanged in substance |
| Email | Future | V2 | — |
| WhatsApp | Future | V2 | — |

**Conflict `MP-CFL-03`, corrected.** v1.0 §16 makes OTP the authentication method and v1.0 §20 places SMS in "Future". Those cannot both hold: with mobile OTP as the sole V1 factor and no passwords, **an SMS channel is a V1 launch dependency**, not a future enhancement. Indian DLT template registration is a lead-time item and is recorded as dependency `MP-DEP-03`.

| ID | Rule |
|---|---|
| **MP-GBR-33** | The domain emits **facts** (`membership.MembershipExpiringSoon`), never instructions ("send an SMS"). Channel selection belongs to `BC-22`. |
| **MP-GBR-34** | No event may ever carry a mobile number. |
| **MP-GBR-35** | Quiet hours, deduplication and consent/unsubscribe are owned by `BC-22` and apply to every channel. |

---

## 23. Analytics Strategy

Every major module should generate analytics: Attendance · Revenue · Membership · Seats · Students · Library Growth · Operational Performance.

| ID | Rule |
|---|---|
| **MP-GBR-36** | **No dashboard may define its own metric formula.** All metrics come from the Metric (Semantic) Layer as Certified Metrics. |
| **MP-GBR-37** | Analytics has **no read access to domain tables**. It learns only from events, and every projection must be **rebuildable from the event log**. |
| **MP-GBR-38** | No projection is a system of record. |

`MP-GBR-36` closes EA critique #6: *"'revenue' will mean five different things in five dashboards within 18 months."*

---

## 24. Performance Goals

Preserved from v1.0 as design directives; the measurable form lives in §25 and in the `NFR Budgets (V1)` document.

Fast mobile experience · Efficient database queries · Pagination · Lazy loading · Caching where appropriate · Scalable architecture

---

## 25. Non-Functional Requirements

v1.0 listed nine NFR *categories* with no targets, which makes them unverifiable. Categories are preserved; each now carries an obligation and an owner.

| ID | Category | Obligation | Owner |
|---|---|---|---|
| **MP-NFR-01** | Availability | Per-function availability targets with SLOs, SLIs and error budgets. Authentication is availability-critical; adjacent features degrade independently. | SRE / OBSERVABILITY |
| **MP-NFR-02** | Reliability | At-least-once event delivery with idempotent consumers; DLQ depth is an SLO-monitored signal, not a silent bin. | EVENT platform |
| **MP-NFR-03** | Maintainability | Single ownership everywhere; boundary violations fail the build. | ARCHITECTURE GOVERNANCE |
| **MP-NFR-04** | Scalability | CQRS read models, cache tier, queues, partitioning, backpressure. The **aggregate instance** is the atomic unit of scale. | DATA / EVENT |
| **MP-NFR-05** | Security | Zero trust, secrets management, encryption, threat detection. | SECURITY |
| **MP-NFR-06** | Usability | Mobile-first, accessible, portrait-optimised. | UI Design System |
| **MP-NFR-07** | Performance | Latency budgets **with a floor as well as a ceiling** where response time is security-relevant — uniformity outranks speed on authentication paths. | Per-platform |
| **MP-NFR-08** | Accessibility | WCAG-aligned targets defined in the UI Design System. | UI Design System |
| **MP-NFR-09** | Observability | Logs, metrics, traces, per-tenant observability. The observability plane is **never authoritative** and must not carry identifiers it is not cleared to hold. | OBSERVABILITY |
| **MP-NFR-10** | **Compliance** *(new)* | DPDP/GDPR posture, DSR, right to erasure, retention enforcement, data residency, legal hold. | SECURITY + DATA Governance |
| **MP-NFR-11** | **Cost / FinOps** *(new)* | Cost per tenant, AI cost attribution, budget alerts, unit economics. | Business platform |
| **MP-NFR-12** | **Business continuity** *(new)* | Backup, restore, DR drills. Where a decision cannot be rendered correctly, **it is refused** rather than guessed. | SRE |

`MP-NFR-10` closes EA critique #13 (*"You fail DPDP/GDPR on day one of enterprise procurement"*) and `MP-NFR-11` closes critique #12 (*"AI + realtime + analytics will destroy your gross margin silently"*).

---

## 26. Constraints

*New section.*

| ID | Constraint |
|---|---|
| **MP-CON-01**…**07** | *(defined in §10 and §20)* |
| **MP-CON-08** | The Enterprise Architecture **v2.1** is approved and governing for **structure** — layering, dependency law, bounded-context inventory. It is nonetheless **descriptive, not prescriptive**: it records the shape of the system and sits at **precedence rank 6** (`DOCUMENTATION_BASELINE.md` §4). Where it disagrees with this document's global rules, an accepted ADR or an approved module PRD, **the higher-ranked document wins and the Enterprise Architecture is updated to match** — never the reverse. A disagreement is a **defect to be raised**, not a choice to be made. |
| **MP-CON-09** | V1 ships as a **modular monolith**. Microservices are not a V1 option. |
| **MP-CON-10** | `EVENT PLATFORM` is tagged **V2**. Any V1 requirement depending on a runtime event backbone must state its V1 fallback explicitly. |
| **MP-CON-11** | Mobile OTP is the sole V1 authentication factor. No passwords, no social login, no demo or guest accounts in any release build. |
| **MP-CON-12** | India-first: DLT template registration, DPDP Act applicability, INR, IST, and a network-unreliable operating environment. |
| **MP-CON-13** | `branchId` is modelled in V1 even though multi-branch is V3 — retrofitting it later is a migration across every tenant-scoped table (`Q-02`). |
| **MP-CON-14** | Startup staffing reality: a separate data-governance platform cannot be staffed in year one; governance lives next to the data. |

---

## 27. Assumptions

*New section.*

| ID | Assumption | If false |
|---|---|---|
| **MP-ASM-01** | Every user has a mobile number capable of receiving SMS. | The sole authentication factor fails; a fallback factor becomes a V1 blocker. |
| **MP-ASM-02** | SMS delivery via a DLT-registered template is achievable within V1 timelines. | Launch slips or OTP delivery degrades. |
| **MP-ASM-03** | Libraries operate with intermittent connectivity; offline attendance capture is required. | Offline Sync could be deferred. |
| **MP-ASM-04** | A student may enrol at multiple libraries. | The Identity Triad is over-engineered for V1 — but removing it later is a rewrite, so it is retained. |
| **MP-ASM-05** | Parents will accept holding an account rather than a link-based view. | Consent audit trail requires rework (`Q-07`). |
| **MP-ASM-06** | A minor-heavy user base makes Trust & Safety a V1 legal necessity, not a growth feature. | T&S could move to V2. |
| **MP-ASM-07** | Owners will pay for a SaaS subscription in INR via a domestic gateway. | Billing and entitlement assumptions change. |

---

## 28. Risks

*New section.*

| ID | Risk | Severity | Mitigation |
|---|---|---|---|
| **MP-RSK-01** | **Cross-tenant data leak via a capability context** — unpartitioned index, shared embedding collection, cache key missing the tenant prefix. | **Critical** | Multi-Tenant Test Suite in CI; cache/index/namespace changes are security-reviewable. |
| **MP-RSK-02** | Minor-safety incident on the social product. | **Critical** | `BC-13` Trust & Safety at V1; guardian consent gate; synchronous enforcement check at message send. |
| **MP-RSK-03** | Regulatory finding on AI handling of student PII. | High | PII redaction gateway, HITL, AI action logs. |
| **MP-RSK-04** | Double seat allocation or duplicate payment capture. | High | DB constraints, pessimistic locks, idempotency keys, reconciliation. |
| **MP-RSK-05** | BaaS lock-in silently absorbs platform responsibilities, making the future backend migration a rewrite. | High | `MP-CON-01`/`02`; the Data Layer abstraction is load-bearing, not decorative. |
| **MP-RSK-06** | Architecture decays because boundary rules are documented but not mechanically enforced. | High | Module Boundary Enforcement + fitness functions in CI. **Currently unimplemented — see `MP-DEP-06`.** |
| **MP-RSK-07** | Metric drift across dashboards. | Medium | Certified Metrics via the semantic layer. |
| **MP-RSK-08** | AI and realtime costs erode gross margin invisibly. | Medium | FinOps, cost per tenant, budget alerts. |

---

## 29. Dependencies

*New section.*

| ID | Dependency | Type | Blocks |
|---|---|---|---|
| **MP-DEP-01** | Approved Enterprise Architecture v2.1 | Internal — **satisfied** | Everything |
| **MP-DEP-02** | Bounded Context Map + Module Dependency Matrix | Internal — **satisfied** | Module implementation |
| **MP-DEP-03** | SMS provider + **DLT template registration** | External | V1 launch — authentication cannot function without it |
| **MP-DEP-04** | Payment gateway onboarding | External | SaaS Billing, fee collection |
| **MP-DEP-05** | FCM project configuration | External | Push notifications |
| **MP-DEP-06** | **Automated boundary checker in CI** | Internal — **not implemented** | Mitigation of `MP-RSK-06`. The manifest `tool/module_dependencies.yaml` exists, but no tool consumes it; its assertions are declarative only. |
| **MP-DEP-07** | Resolution of open questions `Q-01`…`Q-07` | Internal — partially resolved (`Q-02`, `Q-07` settled) | Schema freeze |
| **MP-DEP-08** | NFR Budgets document | Internal | Verifiability of §25 |

---

## 30. Documentation Standards

Every module must have its own independent PRD. The Master PRD never duplicates module-level specifications.

| ID | Addition |
|---|---|
| **MP-CON-15** | Every specification must exist as a **version-controlled file**. A specification that exists only in conversation is not a specification. |
| **MP-CON-16** | Terminology is binding, not advisory. The banned-term list in context map §5 is enforced by lint in cross-context contract files. |

---

## 31. Linked Documents

| Document | Status |
|---|---|
| **Enterprise Architecture v2.1** | Approved — governing, but **descriptive not prescriptive** (precedence rank 6). Where it disagrees with an approved PRD, the PRD wins. See `docs/00-governance/DOCUMENTATION_BASELINE.md` §4 |
| **Bounded Context Map v1.2** | Approved — governing. `AR-1`…`AR-7` applied |
| **Module Dependency Matrix v1.0** | Approved — governing. **Known defect:** declares `contracts: path: lib/contracts`, which does not exist; the shared kernel is `packages/liboora_contracts/`. Deferred as governance task `R-5` |
| **Architecture Rulings Register v1.1** | **Approved, authoritative.** `AR-1`…`AR-7` |
| **ADR set** | **Present and authoritative** — `docs/00-governance/adr/`, `ADR-0001`…`ADR-0008`, indexed by `ADR-INDEX.md`. `ADR-0001`–`ADR-0003` record foundational decisions; `ADR-0004`–`ADR-0007` promote rulings `AR-6`, `AR-2`, `AR-5`, `AR-7`; `ADR-0008` declares Authentication PRD v2.0 the official baseline. Governance task `R-3` **closed**. The Rulings Register remains authoritative for rulings not yet promoted to an ADR |
| Architecture Handbook | Listed in v1.0 |
| System Architecture | **Resolved by ruling `R-1`** — `LIBOORA_ENTERPRISE_ARCHITECTURE.md` **v2.1** is the designated System Architecture. It is **descriptive**: it records the shape of the system, it does not override PRD requirements |
| Database Design (ERD) | Listed in v1.0 |
| API Specification | Listed in v1.0 |
| Authentication PRD | **v2.0 — present and authoritative.** `docs/30-product/authentication/Authentication_PRD_v2.md` (single file) and `docs/30-product/authentication/prd-v2/` (cover + eleven chapters). Defect `D-7` **CLOSED by authorship, not by transfer** — v2.0 was written from the rulings, this document's global rules, the Bounded Context Map and implemented behaviour; it does not reproduce the never-transferred v1.0 text. The eleven v1.0 transfer slots are **archived** at `docs/90-archive/authentication-v1/empty-slots/`. v2.0 was **declared the official baseline by `ADR-0008`** and recorded in `DOCUMENTATION_BASELINE.md` (BASELINE-2026-08-02). The twelve configurable parameters are **no longer awaiting sign-off** — they are reviewed, anchored to named external standards and published in `docs/20-configuration/CONFIGURATION_GUIDE.md`; six defaults were reset (`CFG-3`, `CFG-4`, `CFG-5`, `CFG-6`, `CFG-7`, `CFG-12`) |
| **Authentication implementation record** | **Added** — `ACR-001` (approved) · `ACR-002` (superseded by `AR-5`/`AR-6`/`AR-7`) · `ACN-001` (**closed** — OTP request rate limiting specified by Authentication PRD v2.0 Chapter 8, parameters `CFG-1`–`CFG-4`) · `IVR-001` v1.1 (validated) · `CHANGE_REPORT-001` · `VERIFICATION_REPORT-001`. **Archived** at `docs/90-archive/authentication-v1/reports/` — historical record, superseded by Authentication PRD v2.0 |
| **Developer documentation set** | **Added** — `docs/40-implementation/`: `DEVELOPER_HANDOFF.md` · `IMPLEMENTATION_ROADMAP.md` · `AUTHENTICATION_IMPLEMENTATION_CHECKLIST.md` · `TASK-D10-remove-demo-surfaces.md` · `DEFINITION_OF_DONE.md` · `TRACEABILITY_MATRIX.md`. Entry point `docs/README.md` |
| **Library PRD** (Organization & Library Management) | **Added** — `docs/30-product/library/`. §14A captured and reviewed; **§§1–25 not yet supplied** |
| Student Management · Membership · Attendance · Seat · Revenue & Finance · Analytics · Notifications · Security & Automation · AI Super Assistant PRDs | Listed in v1.0 |
| **Domain Model · Data Dictionary · Business Capability Map** | **Added** — present in EA tree, absent from v1.0 §25 |
| **Tenancy Model · Modularization Strategy · NFR Budgets** | **Added** — V1 in EA tree |
| **Event Catalog · Service Catalog · Threat Model · Compliance Requirements · Cost Model** | **Added** — V2 in EA tree |
| **Risk Register · Project Glossary · Versioning Strategy · Environment Strategy** | **Added** — V1 in EA tree |

---

## 32. Version Roadmap

**Terminology corrected.** v1.0 used "Phase 1/2/3"; the architecture uses `V1/V2/V3/Future` with defined semantics (EA §10.3). Two vocabularies for one concept is exactly the drift this review exists to remove. Content is unchanged; only the labels are normalised.

| Tag | Meaning (EA §10.3) | Contents |
|---|---|---|
| **V1** | MVP — required to launch and operate the core product | Authentication · Student Management · Membership · Attendance · Seats · Dashboards · Finance · Analytics · AI Assistant **+ recovered V1 essentials:** Tenancy · Entitlement · Audit · Search · File & Media · Offline Sync · Integration · Trust & Safety |
| **V2** | Growth — scale operations, sell to multi-branch customers | Advanced AI · Parent Enhancements · Advanced Reports · Automation · Billing Improvements **+** Event Platform · Workflow · Staff & Shift · Inventory · Visitor · Content Sharing · Community |
| **V3** | Enterprise — pass procurement, security review, compliance | Multi-Branch · Enterprise SSO/SCIM/ABAC · Reputation · Marketplace · Disaster Recovery Plan |
| **Future** | Ecosystem — post-PMF; do not design for it, only avoid blocking it | Global Student Network · School · College · Coaching · Hostel |

**Note:** the v1.0 Phase-1 list omitted eight contexts that the architecture places in V1. They are added above, not invented — every one is drawn from context map §3.4.

---

## 33. Success Metrics

Preserved from v1.0, with the addition required by `MP-GBR-36`: each must resolve to a **Certified Metric** in the semantic layer before it appears on a dashboard.

| ID | Metric | Certified definition required |
|---|---|---|
| **MP-SM-01** | Active Libraries | Yes |
| **MP-SM-02** | Active Students | Yes |
| **MP-SM-03** | Daily Attendance Rate | Yes |
| **MP-SM-04** | Seat Occupancy | Yes |
| **MP-SM-05** | Membership Renewal Rate | Yes |
| **MP-SM-06** | Revenue Growth | Yes — **must state whether it means `BC-05` student fees or `BC-20` SaaS revenue** (`MP-GBR-24`) |
| **MP-SM-07** | AI Usage | Yes |
| **MP-SM-08** | Customer Retention | Yes |
| **MP-SM-09** | Customer Satisfaction | Yes |

Targets are deliberately not set here; they belong to the Product Roadmap and NFR Budgets documents.

---

## 34. Open Questions

Inherited from context map §13. Each should become an ADR before the V1 implementation freeze.

| # | Question | Status |
|---|---|---|
| `Q-01` | Does an expired membership release the seat immediately, at end-of-day, or after a grace period? | Open — recommendation: configurable, default 24h |
| `Q-02` | Is `Branch` first-class in V1? | **Settled** — model `branchId` in V1, default single branch (`MP-CON-13`) |
| `Q-03` | Entitlement fail-open or fail-closed on timeout? | Open — recommendation: per-gate; paid features fail-closed |
| `Q-04` | Retention period for attendance after enrollment archival? | Open — needs counsel |
| `Q-05` | Is Global Student available with no library enrollment? | Open — recommendation: yes, reduced trust tier |
| `Q-06` | Who owns proration arithmetic? | Open — recommendation: `BC-02` computes entitlement delta, Business executes money |
| `Q-07` | Does Parent get an Account or a scoped token? | **Settled** — full account with guardian role (§6) |

---

## 35. Preservation Ledger

Auditable proof that refinement did not become deletion.

| v1.0 section | Disposition | Location in v1.1 |
|---|---|---|
| 1 Document Purpose | Preserved + expanded | §1 |
| 2 Product Vision | Verbatim | §2 |
| 3 Product Mission | Verbatim | §3 |
| 4 Product Objectives | Verbatim + IDs | §4 |
| 5 Target Users | **Merged** (true duplicate of §14) | §6 |
| 6 Product Principles | Verbatim + IDs | §7 |
| 7 Core Product Modules | Preserved + BC ownership | §8 |
| 8 Future Platform Modules | Verbatim + IDs | §9 |
| 9 Technology Stack | **Corrected** — vendors moved behind ports | §10 |
| 10 Architecture Principles | Preserved | §11 |
| 11 Layered Architecture | **Corrected** — vendor removed from stack | §12 |
| 12 Architecture Decisions | Verbatim | §13 |
| 13 Module Dependency Rules | Preserved + L1–L5 | §14 |
| 14 User Roles | **Merged** into §6 | §6 |
| 15 Global Business Rules | Preserved; 4 refined, 9 recovered | §17 (+ §15, §16) |
| 16 Security Principles | Verbatim + 4 additions | §18 |
| 17 Data Standards | Preserved; `tenant_id` rule sharpened | §19 |
| 18 API Standards | Verbatim + 4 additions | §20 |
| 19 AI Strategy | Verbatim + HITL/PII | §21 |
| 20 Notifications Strategy | **Corrected** — SMS OTP to V1 | §22 |
| 21 Analytics Strategy | Verbatim + metric layer | §23 |
| 22 Performance Goals | Verbatim, retained | §24 |
| 23 NFRs | Preserved + targets + 3 new | §25 |
| 24 Documentation Standards | Verbatim + 2 additions | §30 |
| 25 Linked Documents | Preserved + 12 added | §31 |
| 26 Development Roadmap | **Relabelled** Phase→V, content preserved | §32 |
| 27 Success Metrics | Verbatim + IDs | §33 |
| — | **New**: Scope, Identity Model, Multi-Tenancy, Constraints, Assumptions, Risks, Dependencies, Open Questions, this ledger | §5, §15, §16, §26–29, §34, §35 |

**Nothing was deleted. Two sections were merged as a declared true duplicate. Four requirements were corrected for architecture conflict, each with its original intent preserved and the reason recorded.**

---

## 36. Changelog

| Version | Change |
|---|---|
| **v1.5** | Cross-reference alignment only. §31 updated to record the **ADR set** `ADR-0001`…`ADR-0008` (governance task `R-3` **closed**), Enterprise Architecture **v2.1** and its **descriptive** standing, Authentication PRD v2.0 as the **declared baseline** (`ADR-0008`), the twelve configurable parameters as **reviewed and anchored** with six defaults reset, the v1.0 authentication material as **archived**, and the new **developer documentation set**. **No requirement added, removed or altered. No business rule, security principle, identity rule, multi-tenancy rule or module ownership changed.** |
| **v1.4** | Cross-reference alignment only. §31 updated to record **Authentication PRD v2.0** as present and authoritative, `D-7` **closed by authorship rather than transfer**, and `ACN-001` **closed** by v2.0 Chapter 8 (`CFG-1`–`CFG-4`). **No requirement added, removed or altered. No business rule, security principle, identity rule, multi-tenancy rule or module ownership changed.** |
| **v1.3** | Cross-reference alignment only. Header records Bounded Context Map **v1.2** and rulings `AR-1`, `AR-2`, `AR-5`, `AR-6`, `AR-7`. §31 updated: Rulings Register v1.1, BC Map v1.2, the Module Dependency Matrix's known `lib/contracts` defect, the Authentication PRD's true state (custody shell, 0 body characters, `D-7` open), and the Authentication implementation record. **No requirement added, removed or altered. No business rule, security principle, identity rule, multi-tenancy rule or module ownership changed.** |
| **v1.2** | Applied approved rulings. `AR-1`: registered module 19, Library Discovery & Enrollment, as a read composition owning no aggregate — §5.1's 23-bounded-context V1 scope is unchanged. `R-1`: §31 records `LIBOORA_ENTERPRISE_ARCHITECTURE.md` as the authoritative System Architecture. §31 adds the Architecture Rulings Register and the Library PRD, and records that no ADR files exist. **No requirement added, removed or altered. No business rule, security principle, identity rule, multi-tenancy rule or module ownership changed.** |
| **v1.1** | Enterprise review and refinement against approved Enterprise Architecture v2.0. 8 conflicts resolved, 7 duplicates merged, 9 business rules recovered from the architecture, 9 sections added, roadmap vocabulary normalised to V1/V2/V3/Future, product name corrected to LIBOORA. No requirement removed. |
| **v1.0** | Initial Foundation Document. |
