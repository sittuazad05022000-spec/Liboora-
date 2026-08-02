# LIBOORA — Architecture Rulings Register

| Field | Value |
|---|---|
| **Document** | Architecture Rulings Register |
| **Version** | v1.0 |
| **Status** | Approved — authoritative project decisions |
| **Purpose** | Durable record of architecture rulings issued by the product owner, so no ruling depends on conversation memory |
| **Identifier namespace** | `AR-*` — reserved exclusively for this document, collision-free against `MP-*`, `BC-*`, `E-*`, `X-*`, `Q-*`, `ID-*`, `A-*`, `D-*`, `F-*`, `LIB-DISC-*` |
| **Relationship to ADRs** | Interim. A formal ADR set (`docs/adr/`) is deferred as governance task `R-3`. Until it exists, **this file is the register of record for approved architecture decisions.** |

---

## How to use this register

- A ruling here **overrides** any earlier statement in any document that contradicts it.
- A ruling here does **not** create requirements. It settles ownership, classification and boundaries only.
- Every ruling lists the documents it changed, so the change set is auditable.
- Anything a ruling explicitly defers is recorded in §6 and must **not** be invented.

---

## AR-1 · Library Discovery Registration

**Ruled:** Library Discovery & Enrollment is **NOT a new bounded context.**

It is an **application / read composition capability of the Library domain**. It:

- owns **no aggregate**
- owns **no invariant**
- owns **no business state**
- only orchestrates **public read models**
- delegates **all** domain operations to their owning modules

**Effect.** The context count remains **31 (23 in V1)**. No `BC-` identifier is assigned. Library Discovery
takes the same classification already used for Dashboards and the Parent Portal — a presentation/read
composition. Per Master PRD §8 Correction 1, such surfaces *"own no aggregate and no invariant."*

**Read models composed** (each field remains owned by its existing context — Discovery references, never
duplicates):

| Public field group | Owning context |
|---|---|
| Library Name · Business Address · Map Location · Library Status · Business Contact Information | `BC-19` Tenancy |
| Logo · Cover Image · Description *(branding values)* | `BC-25` Configuration |
| Gallery | `BC-29` File & Media |
| Operating Hours · Weekly Holidays | `BC-06` Library Policy |
| Membership Plans & Pricing | `BC-02` Membership |
| Seat Capacity | `BC-04` Seating |
| Discovery projection & query | `BC-23` Search Indexing |

**Resolves:** review conflicts `CC-1` and `CC-3`.

**Documents updated:** `LIBOORA_BOUNDED_CONTEXT_MAP.md` §2, §14 · `MASTER_PRD.md` §8, §31, §36 ·
`docs/prd/library/README.md` · `docs/prd/library/REVIEW_14A.md`.

---

## AR-2 · Authentication Alignment

**Ruled:** The **Authentication architecture is the source of truth.**

**Account creation on the first successful OTP verification is explicitly approved.**

Authentication (`BC-18` Identity & Access) remains responsible for:

- OTP
- Registration
- Account creation
- Session management
- Authorization handoff

**Library Discovery must never implement registration logic.**

**Effect.** This confirms — it does not change — the lifecycle already recorded in Bounded Context Map §4:

> **Account** | `AccountId` | BC-18 Identity & Access | Global, cross-tenant | **Created on first successful
> OTP.** Destroyed on account deletion. Holds *credentials only*.

**Implementation divergence.** The shipped implementation diverges from this approved architecture. Per the
ruling, an **Architecture Consistency Report** has been prepared and **no production code has been changed**:

→ [`docs/prd/authentication/ACR-001-OTP-Account-Creation.md`](../prd/authentication/ACR-001-OTP-Account-Creation.md)

Production code remains untouched pending approval of that report.

**Resolves:** review conflict `CC-4` at the architecture level. The implementation gap remains **open** pending
`ACR-001` approval.

**Documents updated:** `LIBOORA_BOUNDED_CONTEXT_MAP.md` §14 · `docs/prd/library/REVIEW_14A.md` ·
new `ACR-001-OTP-Account-Creation.md`.

---

## AR-3 · Public Library Discovery Index

**Ruled:** Public Library Discovery is approved as a **platform-wide public directory.**

- It indexes **only explicitly public library metadata.**
- It is **not** a tenant data index.
- Operational, financial, administrative, member, attendance, analytics, or other tenant-private data must
  **never** be indexed.
- **This approval must not weaken tenant isolation.**

**Effect — two categorically different index classes now exist:**

| | **Platform Public Discovery Index** | **Tenant Operational Data** |
|---|---|---|
| **Indexed unit** | The `TenantOrganisation` itself (`BC-19`) | Rows belonging to one tenant |
| **Contents** | Only the public metadata enumerated in Library PRD §14A.5 | Students, memberships, attendance, fees, analytics, configuration, staff |
| **Tenant key in index name** | Not applicable — the tenant *is* the indexed record | **Mandatory.** `MP-GBR-08`, `SE-1`, `X-13` |
| **Caller tenant context** | None — pre-authentication, anonymous | Always required (`E-18`) |
| **Visibility** | Public, subject to `LIB-DISC-002` (verified + activated) and `LIB-DISC-004` (Private excluded) | Tenant-private, permission-scoped |
| **Severity if mixed** | Mixing tenant-private data into this index is a **blocker** | Serving a tenant-less query is a **blocker** |

**What this ruling does NOT do.** It does **not** relax `MP-GBR-08`, `SE-1` or `X-13` for tenant operational
data. Those remain in force, unmodified, at `blocker` severity. The ruling states that a directory *of tenants*
is not an index *of tenant data*, and is therefore outside the scope those rules govern.

**Resolves:** review conflict `CC-2` at the architecture level.

**Documents updated:** `LIBOORA_BOUNDED_CONTEXT_MAP.md` §11.1, §14 · `docs/prd/library/REVIEW_14A.md`.

---

## AR-4 · Invitation Ownership

**Ruled:** Invitation Links, Invitation QR Codes and Library Invitation Codes are owned by the
**Library Management / Tenant Organization module.**

- Authentication does **not** own invitations.
- Membership does **not** own invitations.
- Student Identity does **not** own invitations.

**Effect.** Ownership is assigned. The invitation artifact is a Library-Management / Tenant-Organization
concern, consistent with Library PRD §14A.6, where an invitation is the access mechanism for a **Private
library** — a property of the organisation, not of a credential or a plan.

**Explicitly deferred by this ruling — DO NOT INVENT.** The invitation **security specification** will be
documented separately. The following are **unspecified and must not be assumed**:

| Deferred | Status |
|---|---|
| Expiry / TTL | Not specified |
| Revocation | Not specified |
| Single-use policy | Not specified |
| Entropy | Not specified |
| Validation rules | Not specified |
| Audit logging | Not specified |

**Resolves:** review conflict `CC-7` **partially** — ownership is settled; the security specification remains
open by explicit instruction.

**Documents updated:** `LIBOORA_BOUNDED_CONTEXT_MAP.md` §14 · `docs/prd/library/REVIEW_14A.md`.

---

## 6. Explicitly deferred — do not invent

| Item | Source | Status |
|---|---|---|
| Invitation security specification (expiry, revocation, single-use, entropy, validation, audit logging) | `AR-4` | Deferred by ruling |
| Formal ADR set `docs/adr/` | Governance task `R-3` | Deferred |
| Development Standards document | Governance task `R-4` | Deferred |
| `tool/check_module_boundaries.dart` + manifest defect fix | Governance task `R-5`, `MP-DEP-06` | Deferred |
| Authentication PRD Chapters 1–11 content | Defect `D-7` | Deferred |
| Library PRD sections 1–25 | Not supplied | Outstanding |

---

## Changelog

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-02 | Register created. Rulings `AR-1` (Library Discovery is a read composition, not a context), `AR-2` (account creation on first successful OTP approved; Authentication owns registration), `AR-3` (Platform Public Discovery Index distinguished from Tenant Operational Data without weakening tenant isolation), `AR-4` (invitation ownership assigned to Library Management / Tenant Organization; security spec deferred) recorded as authoritative. |
