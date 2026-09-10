# Liboora — Authentication Product Requirements Document

| Field | Value |
|---|---|
| **Document** | Authentication PRD |
| **Bounded context** | `BC-18` Identity & Access `[GENERIC]` |
| **Version** | **v3.0** |
| **Status** | **AUTHORITATIVE — supersedes v2.0** |
| **Applies to** | Liboora multi-tenant SaaS platform, Version 1 |
| **Date** | 2026-09-10 |
| **Precedence rank** | Rank 3 — module PRD (`DOCUMENTATION_BASELINE.md` §4) |
| **Authorised by** | `Accepted` [`ADR-0129`](../../../00-governance/adr/ADR-0129-google-sign-in-v1-primary-authentication-mobile-otp-v2.md) |
| **Aligned to** | `MASTER_PRD.md` **v1.8** |
| **Supersedes** | Authentication PRD **v2.0** (2026-08-02) |

---

## A. Authority and standing

This document is the **authoritative Authentication specification** for `BC-18`. It replaces
Authentication PRD **v2.0** in that role.

### A.1 What authorises this version

v3.0 exists to carry a single decided change into the Authentication specification:

> **Google Sign-In (Google OIDC) is the sole required authentication method in Version 1. Mobile OTP is
> re-scoped to Version 2.**

That decision is **not taken here**. It was taken jointly by the Architecture Owner and the Product Owner,
with Privacy Owner sign-off, and is recorded in `Accepted` `ADR-0129`. This document **implements** it.
Where this document and `ADR-0129` disagree, `ADR-0129` wins and this document is a defect to be repaired
(`MP-CON-08` reasoning, applied to rank 3 against rank 2).

### A.2 Relationship to v2.0 — v2.0 is FROZEN, not deleted

⛔ **v2.0 is byte-frozen. It is not edited, renumbered or repaired by this act.**

`Authentication_PRD_v2.md` and every file under `prd-v2/` remain exactly as committed. This is deliberate
and load-bearing: **fifteen line-number citations in nine documents point into `Authentication_PRD_v2.md`**,
including citations from `Accepted` `ADR-0061` and `Accepted` `ADR-0063`. Freezing v2.0 keeps every one of
those citations resolving to the line it was written against.

⚠ **A known, deliberately unrepaired condition in v2.0.** `README.md` describes both
`Authentication_PRD_v2.md` and the eleven `prd-v2/` chapters as authoritative, but the assembled file is
**4638 lines** while the chapter sources total **4594 lines** — a **44-line drift**. The two v2.0
representations are **not byte-derivable from each other**, and no assembly tool exists in the repository.

⛔ **v3.0 does not claim the v2.0 representations are byte-identical, and does not repair the drift.**
Repairing v2.0 would edit a frozen artifact and move cited lines. The drift is recorded here as an
inherited fact.

### A.3 The v3.0 representation rule — stated once, so it cannot drift

v3.0 has **two files by design, with one of them authoritative**:

| File | Standing |
|---|---|
| `Authentication_PRD_v3.md` | ⭐ **AUTHORITATIVE — the single source of truth for Authentication** |
| `prd-v3/00-Cover-and-Control.md` | **Normative** — this control chapter, incorporated by reference |

⛔ **v3.0 does NOT reproduce the eleven v2.0 chapters as eleven new files.** Creating eleven near-duplicate
chapter files would recreate exactly the dual-authority drift that v2.0 suffers from. v3.0 therefore uses a
**delta-successor** structure, described in §B.

⛔ **No build script, assembler or generator is introduced by this act.** Neither representation is
generated from the other; the authoritative file is maintained directly.

---

## B. How v3.0 is structured — the delta-successor convention

v2.0 contains **588 requirements** across eleven chapters. `ADR-0129` changes a **small, enumerated subset**
of them. Re-authoring 588 requirements to change roughly twenty would be a rewrite disguised as an
amendment, and would silently alter requirements nobody decided to alter.

v3.0 is therefore a **delta successor**:

| Part | Content |
|---|---|
| **Carried forward** | Every v2.0 requirement not listed in the change register below is **carried into v3.0 unchanged, by reference**, retaining its v2.0 identifier and meaning |
| **Amended** | The requirements enumerated in `Authentication_PRD_v3.md` §3, each quoted in its v2.0 form and then restated in its v3.0 form |
| **Removed** | `AUTH-3.22`, retained as a **tombstone** — see §C |
| **Added** | New requirements needed by `ADR-0129`, allocated **new identifiers only**, never reusing a retired one |

**Reading rule, normative:** a requirement's v3.0 text is its **amended** text if this document amends it,
its **tombstone** entry if this document retires it, and otherwise its **v2.0 text**, which remains valid
and citable.

⭐ **Consequence for citations, stated deliberately:** because unamended requirements keep their v2.0
identifiers, the **2134 `AUTH-x.y` identifier citations across the repository continue to resolve**. Only
the enumerated requirements change meaning, and each is listed explicitly so no reader has to infer it.

---

## C. Requirement retirement — the tombstone convention

`AUTH-3.22` is **REMOVED** as an active requirement by `ADR-0129` `U-1 = B`.

It is **not deleted from the identifier space**:

| Rule | Statement |
|---|---|
| **C.1** | A retired requirement identifier **MUST** be retained with status **REMOVED**, its original text quoted, and the authority that retired it named |
| **C.2** | A retired identifier **MUST NOT** be reused for any future requirement |
| **C.3** | A retired requirement **MUST NOT** be cited as an active obligation. Historical citations of it remain **valid as history** |
| **C.4** | An **active** range expression **MUST NOT** span a retired identifier |

⚠ **This convention is deliberately distinct from ADR supersession.** `ADR-INDEX.md` **L206–L207** govern
*ADRs* — *"Never edit an Accepted ADR's decision text — supersede it with a new ADR"* and *"An ADR
supersedes; it does not delete."* Those rules are **not** applied to requirements here: a requirement lives
inside a versioned PRD which is itself superseded as a whole, whereas an ADR is a standalone immutable
record. Applying ADR supersession mechanics to a requirement would require a new ADR per requirement, which
no repository convention asks for.

⭐ **Historical citations of `AUTH-3.22` remain intact and are NOT repaired.** `Accepted` `ADR-0129`
(L44, L46, L229, L313) and `MASTER_PRD.md` v1.8 (L726) cite `AUTH-3.22` **as the requirement being
removed**. That is correct usage of a tombstone and must not be edited.

---

## D. Canonical vocabulary — defined here, used throughout v3.0

`ADR-0129` and `MASTER_PRD` v1.8 use identity terms that **do not appear in v2.0 at all**. Measured in
v2.0: `AccountId` **0 occurrences**, `PersonId` **0**, `provider identity` **0**, `GuardianLink` **0**.
v2.0 says *"Account ID"* (13 occurrences), *"Global Identity"* (4) and *"Guardian"* (11).

⛔ **No blind global rename is performed.** v2.0's wording is frozen and its phrasing is preserved wherever
it is quoted. The following terms are **defined for v3.0** and used in v3.0's own normative text.

| Term | Definition | Owner |
|---|---|---|
| ⭐ **`AccountId`** | The **canonical, internal, immutable Liboora account identifier**. Permanent, never reused. ⛔ **NOT** derived from — and **MUST NOT** permit derivation of — a mobile number, the Google `sub`, or a Google email. This is the same object v2.0 calls the *"account identifier"* / *"Account ID"*; v3.0 fixes the spelling `AccountId` for it | `BC-18` |
| ⭐ **`provider identity`** | The identity of the account holder **as asserted by an external authentication provider**, together with the platform's binding to it. In V1 the only provider is **Google (OIDC)** and the provider identity is keyed by the immutable Google **`sub`**. A provider identity is **evidence of control**, never the canonical identity | `BC-18` |
| ⭐ **Google `sub`** | The **immutable provider-side subject identifier** issued by Google. It is the **provider identity key**. It is stable across email change and display-name change, which is exactly why it, and not the email, is the key | Google (external) |
| ⭐ **`PersonId`** | The **global person identity** owned by **`BC-10`**, created atomically and mandatorily with the Account per `Accepted` `ADR-0011`, and permanent for the person's lifetime on the platform | **`BC-10`** — ⛔ never `BC-18` |
| **`GuardianLink`** | A **domain relationship** recorded outside `BC-18` linking a guardian to a student for **enrollment and consent** purposes. ⛔ **It is not an authentication mechanism** and confers **no** login capability | Student/enrollment contexts |

### D.1 `Global Identity` — inspected, NOT silently equated to `PersonId`

v2.0 uses *"Global Identity"* in **four** places. Inspected individually, all four use it to mean **"one
platform-wide account rather than a per-library account"** — for example `RP-1` *"One global identity —
`AUTH-4.3` — Registration creates a **platform-level** account, not a library-level one."*

⭐ **Determination: v2.0's *"Global Identity"* means the platform-scope of the ACCOUNT. It does NOT mean
`BC-10`'s `PersonId`.** They are different objects with different owners.

⛔ Therefore v3.0 **does not** rewrite v2.0's *"Global Identity"* wording into `PersonId`, and **does not**
transfer `PersonId` ownership into `BC-18`. `AUTH-4.3` and `RP-1` are **carried forward unchanged**.

---

## E. Normative language

Unchanged from v2.0. **MUST**, **MUST NOT**, **MAY** carry their RFC-2119 senses. A requirement is
identified `AUTH-<chapter>.<n>`; an acceptance criterion `AC-<chapter>.<n>`.

## F. Configurable parameters

`CFG-1`…`CFG-12` are **carried forward unchanged** from v2.0, and
[`../../20-configuration/CONFIGURATION_GUIDE.md`](../../../20-configuration/CONFIGURATION_GUIDE.md) remains
normative for their values.

⚠ **`CFG-1`, `CFG-2`, `CFG-3`, `CFG-4` describe OTP request quotas.** Because Mobile OTP is **not a V1
authentication method** in v3.0, those four parameters have **no V1 authentication effect**. They are
**retained, not deleted**, because Mobile OTP is re-scoped to V2 rather than removed from the product.
⛔ Their V2 values, ranges and eventual disposition are **not decided by this act**.

## G. What this document does NOT do

⛔ Enumerated so no reader infers otherwise:

- ⛔ It selects **no** OIDC library, SDK, client, backend, or SMS provider. **No implementation is specified.**
- ⛔ It does **not** create a Bounded Context Map edge, does **not** allocate **`E-34`**, and does **not**
  create a `platform/integration:identity_provider` port. Those are separate governed acts (`ADR-0129` §6).
- ⛔ It does **not** supersede `ADR-0002` or `ADR-0005`; both supersessions remain **outstanding** (`ADR-0129` §7).
- ⛔ It does **not** update `DOCUMENTATION_BASELINE.md` and does **not** mint a baseline identifier.
- ⛔ It closes **no** blocker — `MP-DEP-03`, `BLK-01`, `BLK-02`, `TASK-D10`, gate 3, `H1`–`H4`, `D3` all stand.
- ⛔ It performs **no** secret custody; `A-9` remains outside scope.
- ⛔ It decides **nothing** about Mobile OTP's final V2 design, optionality or eventual removal.
