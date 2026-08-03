# LIBOORA — Architecture Rulings Register

| Field | Value |
|---|---|
| **Document** | Architecture Rulings Register |
| **Version** | v1.1 |
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
`docs/30-product/library/README.md` · `docs/30-product/library/REVIEW_14A.md`.

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

→ [`docs/90-archive/authentication-v1/reports/ACR-001-OTP-Account-Creation.md`](../90-archive/authentication-v1/reports/ACR-001-OTP-Account-Creation.md)

Production code remains untouched pending approval of that report.

**Resolves:** review conflict `CC-4` at the architecture level. The implementation gap remains **open** pending
`ACR-001` approval.

**Documents updated:** `LIBOORA_BOUNDED_CONTEXT_MAP.md` §14 · `docs/30-product/library/REVIEW_14A.md` ·
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

**Documents updated:** `LIBOORA_BOUNDED_CONTEXT_MAP.md` §11.1, §14 · `docs/30-product/library/REVIEW_14A.md`.

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

**Documents updated:** `LIBOORA_BOUNDED_CONTEXT_MAP.md` §14 · `docs/30-product/library/REVIEW_14A.md`.

---

## AR-5 · Display Name collection (`IVR-001` Blocker A)

**Ruled — option A1.** The **Registration flow shall collect the user's Display Name before OTP verification.**

`displayName` shall remain **required and non-nullable.**

**Prohibited as a display name — DO NOT USE:**

| Prohibited | Status |
|---|---|
| Empty string | Forbidden |
| Mobile number | Forbidden |
| Placeholder values | Forbidden |
| Auto-generated names | Forbidden |

**Ownership.** The **Authentication** module remains responsible for **OTP verification only.**
**Registration owns the collection of user profile information.**

**Effect.** `Account.displayName` keeps its current type — `required`, non-nullable `String`. No nullable
migration, no default, no derivation. Because Authentication must not own profile collection, the collected name
is **supplied to Authentication at the moment of account creation** and is never held as profile state between
calls, never generated, and never inferred from the subject.

An existing account's display name is **never rewritten** by a later verification. Account creation is refused
when no collected display name is present, or when the value offered is empty, whitespace-only, or equal to the
mobile number — the three machine-detectable prohibitions above. "Placeholder" and "auto-generated" are honoured
by never producing one.

**Resolves:** `IVR-001` §4.2 Blocker A · risk `RK-1` · `ACR-002` Blocker A.

**Documents updated:** `IVR-001-OTP-Account-Creation.md` §1, §4 · this register.

---

## AR-6 · Authentication and Session Issuance are separate stages (`IVR-001` Blocker B)

**Ruled — option B3.** **Authentication and Session Issuance are separate stages.**

**Approved flow:**

```
Registration
  → Collect Display Name
  → Collect Mobile Number
  → OTP Verification
  → Create Account
  → Continue Original Action
  → Membership Processing (if required)
  → Role Assignment
  → Session Issuance
```

**An Account may exist before any tenant role exists.**

| Stage | Responsible for | Owner |
|---|---|---|
| **Authentication** | Identity verification · account creation | `BC-18` Identity & Access |
| **Authorization** | Tenant roles | `BC-18` Identity & Access — authorization concern, evaluated with a tenant in scope |
| **Session Issuance** | Occurs **only after** the required authorization context exists | `BC-18` Identity & Access |

**Do not merge Authentication and Authorization responsibilities.**

**Effect.** The single-call `verifyOtp → AuthSession?` shape is replaced by two stages. Verification yields a
verified **`Account`**; a session is issued separately and only once an authorization context exists. This makes
the interval described by the approved flow — authenticated, account exists, no tenant role yet — a
**representable state** rather than an outcome indistinguishable from authentication failure.

This confirms, and does not change, Bounded Context Map §11 line 473: *"**Hybrid.** `Account` is global; role
assignments are tenant-scoped. `AccessPolicy` is always evaluated with a tenant in scope"*, and Library PRD
§14A.7, which places role acquisition in **Membership Processing**, after Authentication.

**Consequence acknowledged.** Splitting the stages is a **breaking change to the `AuthService` verification
signature.** It is in scope precisely because the signature is the subject of this ruling; the constraint
*"do not modify unrelated APIs"* is not breached, because no other API changes.

**Resolves:** `IVR-001` §4.3 Blocker B · risk `RK-2` · `ACR-002` Blocker B.

**Documents updated:** `IVR-001-OTP-Account-Creation.md` §1, §4 · this register.

---

## AR-7 · `F-02` conformance validates security behaviour, not storage (`IVR-001` `RK-3`)

**Ruled — option C1.** **The security objective of `F-02` is anti-enumeration.**

- The implementation shall preserve **identical observable behaviour** for registered and unregistered phone
  numbers **until OTP verification succeeds.**
- **Conformance tests shall validate security behaviour** rather than implementation details such as internal
  storage.
- **Do not weaken `F-01` or `F-02`.**

**Effect.** The `F-02` conformance assertion that required *no challenge to be stored* for an unregistered number
was asserting an **implementation detail** (`_issued` membership, read through a debug-only peek surface that is
disabled in every release wiring). It is re-expressed to assert the **security property**: a caller can observe
no difference between a registered and an unregistered number before verification succeeds.

`F-01` and `F-02` remain **closed**. Neither the defect nor its guard is removed: the guard is aimed at the
property the defect was about.

**Resolves:** `IVR-001` §6.1 · risk `RK-3`.

**Documents updated:** `IVR-001-OTP-Account-Creation.md` §6 · `test/authentication_conformance_test.dart`
(implementation) · this register.

---

## 6. Explicitly deferred — do not invent

| Item | Source | Status |
|---|---|---|
| Invitation security specification (expiry, revocation, single-use, entropy, validation, audit logging) | `AR-4` | Deferred by ruling |
| **OTP request rate-limiting policy** | Ruled alongside `AR-5`…`AR-7` | **Deferred by ruling. No rate-limiting policy may be invented. Must be specified in the Authentication Security PRD (Chapter 7) before implementation. No implementation assumptions are permitted.** Recorded in [`ACN-001`](../90-archive/authentication-v1/reports/ACN-001-OTP-Request-Rate-Limiting.md) |
| Formal ADR set `docs/adr/` | Governance task `R-3` | Deferred |
| Development Standards document | Governance task `R-4` | Deferred |
| `tool/check_module_boundaries.dart` + manifest defect fix | Governance task `R-5`, `MP-DEP-06` | Deferred |
| Authentication PRD Chapters 1–11 content | Defect `D-7` | Deferred |
| Library PRD sections 1–25 | Not supplied | Outstanding |

---

## Changelog

| Version | Date | Change |
|---|---|---|
| **v1.1** | 2026-08-02 | Rulings on `IVR-001` recorded: `AR-5` (option A1 — Registration collects the Display Name before OTP verification; `displayName` stays required and non-nullable; empty string, mobile number, placeholder and auto-generated names all prohibited), `AR-6` (option B3 — Authentication and Session Issuance are separate stages; an Account may exist before any tenant role; session issuance only after the authorization context exists; Authentication and Authorization must not be merged), `AR-7` (option C1 — `F-02` conformance validates anti-enumeration behaviour, not internal storage; `F-01` and `F-02` not weakened). OTP request rate limiting added to §6 as deferred by ruling, with `ACN-001` as its record. |
| **v1.0** | 2026-08-02 | Register created. Rulings `AR-1` (Library Discovery is a read composition, not a context), `AR-2` (account creation on first successful OTP approved; Authentication owns registration), `AR-3` (Platform Public Discovery Index distinguished from Tenant Operational Data without weakening tenant isolation), `AR-4` (invitation ownership assigned to Library Management / Tenant Organization; security spec deferred) recorded as authoritative. |
