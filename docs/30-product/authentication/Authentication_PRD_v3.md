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
| **Authorised by** | `Accepted` [`ADR-0129`](../../00-governance/adr/ADR-0129-google-sign-in-v1-primary-authentication-mobile-otp-v2.md) |
| **Aligned to** | `MASTER_PRD.md` **v1.8** |
| **Supersedes** | Authentication PRD **v2.0** (2026-08-02) — ⛔ frozen, not edited |
| **Control chapter** | [`prd-v3/00-Cover-and-Control.md`](prd-v3/00-Cover-and-Control.md) — **normative, incorporated by reference** |

---

## 0. How to read this document

⭐ **This is a DELTA SUCCESSOR, not a rewrite.**

v2.0 contains **588 requirements**. `Accepted` `ADR-0129` changes an enumerated subset. Re-authoring all 588
would alter requirements nobody decided to alter, so v3.0 states **only** what changes and carries the rest
forward by reference.

**Normative reading rule:**

> A requirement's v3.0 text is its **amended** text if §3 amends it, its **tombstone** entry if §4 retires
> it, its **new** text if §5 adds it, and **otherwise its v2.0 text** — which remains valid, authoritative
> and citable.

⛔ **v2.0 is byte-frozen** and is **not** edited by this document. Fifteen line-number citations in nine
documents — including `Accepted` `ADR-0061` and `Accepted` `ADR-0063` — point into
`Authentication_PRD_v2.md`. Freezing it keeps every one of them resolving.

⚠ **Inherited, deliberately unrepaired:** v2.0's assembled file (**4638 lines**) and its `prd-v2/` chapter
sources (**4594 lines**) differ by **44 lines** and are **not byte-derivable** from each other. v3.0 makes
**no claim** that they are identical and does **not** repair the drift — repairing it would edit a frozen
artifact and move cited lines.

Vocabulary (`AccountId`, `provider identity`, Google `sub`, `PersonId`, `GuardianLink`), the tombstone
convention and the scope exclusions are defined in the **control chapter**, which is normative.

---

## 1. The Version 1 authentication decision

### 1.1 What V1 is

⭐⭐ **Google Sign-In (Google OIDC) is the SOLE REQUIRED authentication method in Version 1.**

| ID | Requirement |
|---|---|
| ⭐ **`AUTH-3.40`** | Google Sign-In (Google OIDC) **MUST** be the sole required authentication method in Version 1. Authenticating a person **MUST** consist of validating a Google OIDC assertion and resolving it to a bound `provider identity` |
| ⭐ **`AUTH-3.41`** | Version 1 **MUST NOT** require, collect or verify a mobile number in order to authenticate a person or to create an account |
| ⭐ **`AUTH-3.42`** | Version 1 **MUST NOT** offer Mobile OTP, SMS OTP or any possession-of-number challenge as an authentication method |
| ⭐ **`AUTH-3.43`** | Version 1 **MUST NOT** provide a password, PIN, reusable secret or password-style fallback. *(This restates and does not weaken v2.0 `AUTH-11.68`.)* |
| ⭐ **`AUTH-3.44`** | Version 1 **MUST NOT** provide demo authentication, guest authentication, seeded sign-in identities or any bypass of Google Sign-In in a release build. *(This is `MP-CON-11`'s no-demo / no-guest limb, which `MASTER_PRD` v1.8 preserves **unchanged and still binding**; `TASK-D10` and Matrix §10.4 gate 3 depend on it.)* |
| ⭐ **`AUTH-3.45`** | Version 1 **MUST NOT** provide a second independently authenticating method or a second authentication factor. Existing step-up, elevation, session and audit controls remain **layered security obligations on this mechanism**, not authentication methods — per `Accepted` `ADR-0063`, which is **not reopened** |

### 1.2 What V2 is — re-scoped, NOT removed

| ID | Requirement |
|---|---|
| ⭐ **`AUTH-3.46`** | Mobile OTP and mobile verification **MUST** be treated as a **Version 2 capability**. They are **re-scoped, not removed from the product roadmap** |
| ⭐ **`AUTH-3.47`** | ⛔ The Version 2 purpose, optionality, design and eventual disposition of Mobile OTP **MUST NOT** be inferred from this document. They remain a **future joint Product + Architecture decision** |

⛔ **No SMS provider, gateway, template or implementation is selected by this document.**

### 1.3 The accepted V1 scope exclusion

| ID | Requirement |
|---|---|
| ⭐ **`AUTH-3.48`** | Persons who cannot or do not hold an eligible Google account — **including minors who cannot independently satisfy Google's account eligibility** — are **outside Version 1 authentication scope**. ⛔ This exclusion is **ACCEPTED, not mitigated**: no fallback factor, alternate method or compensating V1 path **MAY** be introduced for them (`ADR-0129` `A-14`/`A-16`) |

⚠ This is a **product scope boundary**, not a defect to be engineered around. It is recorded so that no
implementer invents an alternate V1 authentication route to "fix" it.

---

## 2. The identity chain

⭐ The V1 identity chain, normative:

```
Google OIDC assertion validated
        ↓
immutable Google  sub                  ← provider-side key
        ↓
BC-18  provider identity               ← binding held by Identity & Access
        ↓
canonical Liboora  AccountId           ← internal, immutable, never reused
        ↓
BC-10  PersonId                        ← global person identity (ADR-0011)
        ↓
Tenant / Role / Membership
        ↓
Payments
```

| ID | Requirement |
|---|---|
| ⭐ **`AUTH-3.49`** | The immutable Google **`sub`** **MUST** be the `provider identity` key. Authentication **MUST NOT** key on the Google email, the Google display name, the Google profile picture or any other mutable Google profile attribute |
| ⭐ **`AUTH-3.50`** | One Google `sub` **MUST** resolve to **at most one** `AccountId`. Two accounts **MUST NOT** share a `sub` |
| ⭐ **`AUTH-3.51`** | An `AccountId` **MUST** hold **exactly one** `provider identity` in Version 1 — consistent with the one-primary-method rule carried forward as `AUTH-3.16` |
| ⭐ **`AUTH-3.52`** | ⛔ The Google **email MUST NOT** be, or be used as: the canonical identity · the `AccountId` · the `PersonId` · a uniqueness key · an automatic matching key · an automatic re-link key · a payment identity · a recovery identity |
| ⭐ **`AUTH-3.53`** | ⛔ Two `provider identity` records with different `sub` values **MUST NOT** be merged, linked or collapsed on the basis of a shared email, display name or profile attribute. A person legitimately holding more than one Google account holds **separate** provider identities, and the domain model **MUST NOT** silently unify them |
| ⭐ **`AUTH-3.54`** | The `PersonId` **MUST** remain owned by **`BC-10`** and **MUST** be created atomically and mandatorily with the Account, per `Accepted` `ADR-0011`. ⛔ `BC-18` **MUST NOT** assume ownership of `PersonId` |
| ⭐ **`AUTH-3.55`** | ⛔ No context outside `BC-18` **MAY** store a Google OIDC token, `sub`, credential or session. *(Restates `MP-GBR-27`; unchanged.)* |

---

## 3. Amended requirements

Each entry quotes the **v2.0 text verbatim**, then states the **v3.0 text**. v2.0's file is unchanged; the
quotation exists so the change is auditable without opening a frozen document.

### 3.1 Chapter 3 — Authentication Methods

#### `AUTH-3.13` — unsupported methods absent from the build

> **v2.0 (`Authentication_PRD_v2.md` L971):** *"No unsupported method **MAY** be present in a release build
> in any form — enabled, disabled, hidden, partially implemented or reachable by configuration."*

⭐ **v3.0 — AMENDED.** The rule is **preserved in full force**; only the membership of the unsupported set
changes.

| ID | v3.0 requirement |
|---|---|
| **`AUTH-3.13`** | No unsupported method **MAY** be present in a release build in any form — enabled, disabled, hidden, partially implemented or reachable by configuration. ⭐ **In Version 1 the supported set is exactly `{ Google Sign-In (Google OIDC) }`.** ⛔ **Mobile OTP / SMS OTP is NOT in the Version 1 supported set** and therefore **MUST NOT** be present in a Version 1 release build as an **authentication** method. ⚠ This **MUST NOT** be read as deleting Mobile OTP from the product: it is a **V2 capability** (`AUTH-3.46`), and a V2 build's supported set is a **future decision** (`AUTH-3.47`) |

⛔ **Google Sign-In moves OUT of the v2.0 §3.4 unsupported table.** v2.0 listed it as unsupported because
*"Adds an external identity provider dependency and a second account-linking model, for a population with
inconsistent Google account usage."* ⭐ **That reasoning is reversed by `Accepted` `ADR-0129` `P-1`.**
Email login, Password login, Apple Sign-In, Passkeys, Biometric login and *"Social login (any provider)"*
other than Google **remain unsupported**, with their v2.0 reasoning intact.

⚠ **`AUTH-3.14` is carried forward unchanged** — a request to authenticate by an unsupported method must be
refused without disclosing roadmap, configuration or account state.

#### `AUTH-3.15` — the default and only method

> **v2.0 (L983):** *"Mobile Number + OTP is the default and, in Version 1, the only method. No selection
> interface is presented, because no choice exists."*

| ID | v3.0 requirement |
|---|---|
| **`AUTH-3.15`** | ⭐ **Google Sign-In (Google OIDC)** is the default and, in Version 1, the **only** method. No selection interface is presented, because no choice exists |

#### `AUTH-3.16` — one primary method

> **v2.0 (L988):** *"Every account **MUST** have exactly one primary authentication method at any time. In
> Version 1 this is Mobile Number + OTP for every account, without exception."*

| ID | v3.0 requirement |
|---|---|
| **`AUTH-3.16`** | Every account **MUST** have exactly one primary authentication method at any time. ⭐ In Version 1 this is **Google Sign-In (Google OIDC)** for every account, **without exception** |

⭐ The underlying **single-method architecture rule is preserved exactly**; only the method's identity changes.

#### `AUTH-3.17` — no two independently authenticating methods

> **v2.0 (L991):** *"An account **MUST NOT** hold two methods that independently authenticate it in Version 1."*

| ID | v3.0 requirement |
|---|---|
| **`AUTH-3.17`** | An account **MUST NOT** hold two methods that independently authenticate it in Version 1. ⭐ Consequently an account **MUST NOT** hold both a Google `provider identity` and any mobile-possession credential capable of authenticating it |

#### `AUTH-3.18` — method consistency across every category

> **v2.0 (L995):** *"The method **MUST** behave identically for every account, in every library, for every
> role. No category, role, tenant, region or device may alter method behaviour."*

| ID | v3.0 requirement |
|---|---|
| **`AUTH-3.18`** | ⭐ **PRESERVED VERBATIM IN SUBSTANCE.** The method **MUST** behave identically for every account, in every library, for every role. **No category, role, tenant, region or device may alter method behaviour** — now read against Google Sign-In. ⛔ There is **no** Reception exception, **no** privileged-role exception, **no** shared-device exception and **no** region exception |

#### `AUTH-3.19` — authentication is a platform property

> **v2.0 (L998):** *"No tenant **MAY** configure, restrict, extend or substitute the authentication method
> for its users. The method is a platform property, never a tenant setting."*

| ID | v3.0 requirement |
|---|---|
| **`AUTH-3.19`** | ⭐ **PRESERVED VERBATIM IN SUBSTANCE.** No tenant **MAY** configure, restrict, extend or substitute the authentication method for its users. The method is a **platform property, never a tenant setting** |

#### `AUTH-3.20` / `AUTH-3.21` — future extensibility

> **v2.0 (L1003):** *"A future method **MUST** be introduced as an **additional proof of control over an
> existing account**, never as a parallel identity."*
> **v2.0 (L1006):** *"Introducing a method **MUST NOT** require any change to the account model, the role
> model, the session model or existing accounts."*

⭐ **v3.0 — both CARRIED FORWARD UNCHANGED in substance, with one clarification** so they cannot be read as
licensing a second V1 method:

| ID | v3.0 requirement |
|---|---|
| **`AUTH-3.20`** | A future method **MUST** be introduced as an **additional proof of control over an existing account**, never as a parallel identity. ⚠ *"Future"* means **V2 or later**; this rule **MUST NOT** be used to introduce a second method into Version 1 (`AUTH-3.45`) |
| **`AUTH-3.21`** | Introducing a method **MUST NOT** require any change to the account model, the role model, the session model or existing accounts |

⭐ **Active range expression, corrected:** the future-extensibility rules are **`AUTH-3.20` through
`AUTH-3.21`**.

⚠ v2.0 L1074 reads *"`AUTH-3.20` through `AUTH-3.22`."* ⛔ That range is **not valid in v3.0** because it
would span a retired identifier (control chapter rule **C.4**). ⛔ v2.0's own line is **not edited** — it is
frozen, and its range remains historically accurate for v2.0.

---

## 4. Removed requirements — tombstones

### `AUTH-3.22` — **REMOVED**

| Field | Value |
|---|---|
| **Identifier** | `AUTH-3.22` |
| **Status** | ⛔⛔ **REMOVED — retired in v3.0. Not an active requirement.** |
| **v2.0 text, quoted verbatim** | *"Every account **MUST** retain a verified mobile number as its identity anchor, irrespective of any additional method added later."* |
| **Retired by** | `Accepted` [`ADR-0129`](../../00-governance/adr/ADR-0129-google-sign-in-v1-primary-authentication-mobile-otp-v2.md) — decision **`U-1 = B`** |
| **Reason** | The verified mobile number is **no longer the V1 identity anchor**. V1 requires no mobile number at all (`AUTH-3.41`) |
| **Successor** | ⛔ **There is no direct successor requirement, and deliberately so.** The **`provider identity`, keyed by the immutable Google `sub`, is the V1 anchor of authentication evidence** (`AUTH-3.49`), while the **`AccountId` remains the canonical Liboora identity** (`AUTH-4.19`, `AUTH-4.20`). ⛔ **The Google email MUST NOT take the retired anchor's place** (`AUTH-3.52`) |
| **Identifier reuse** | ⛔ **PROHIBITED.** `AUTH-3.22` **MUST NOT** be reassigned to any future requirement (control chapter **C.2**) |
| **Historical citations** | ⭐ **VALID AND PRESERVED.** `Accepted` `ADR-0129` (L44, L46, L229, L313) and `MASTER_PRD.md` v1.8 (L726) cite `AUTH-3.22` **as the requirement being removed** — correct tombstone usage. ⛔ **These citations MUST NOT be edited or "repaired"** |

⚠ **Not an ADR supersession.** Control chapter §C explains why ADR-INDEX L206–L207 supersession mechanics
are **not** applied to a requirement retirement.

---

## 5. Account creation, uniqueness and identity

### 5.1 Uniqueness

> **v2.0 `AUTH-4.1` (L1149):** *"Exactly one account **MUST** exist per verified mobile number,
> platform-wide, irrespective of path taken or number of libraries involved."*

| ID | v3.0 requirement |
|---|---|
| **`AUTH-4.1`** | ⭐ **AMENDED.** Exactly one account **MUST** exist **per immutable Google `sub`**, platform-wide, irrespective of path taken or number of libraries involved. ⛔ Uniqueness **MUST NOT** be keyed on a mobile number, a Google email, a display name or any mutable profile attribute |
| **`AUTH-4.2`** | ⭐ **CARRIED FORWARD.** Neither path **MAY** create a second identity for a person already holding an account — now evaluated against the `provider identity` |

⚠ **`AUTH-4.5` is carried forward with its meaning re-keyed by `AUTH-4.1`**: an authentication attempt
presenting a `sub` already bound to an account **MUST** authenticate that existing account rather than
create another. ⛔ There is no path to a second account for one `sub`.

### 5.2 Account creation

> **v2.0 `AUTH-4.4` (L1161, `RP-2`):** *"An account **MUST NOT** be created until control of the mobile
> number has been proven by successful verification. An unverified number never yields an account."*

| ID | v3.0 requirement |
|---|---|
| **`AUTH-4.4`** | ⭐ **AMENDED — `RP-2` re-scoped from *"Mobile number ownership"* to *"Provider identity binding"*.** An account **MUST NOT** be created until a **Google OIDC assertion has been successfully validated** and its **`sub` bound as the account's `provider identity`**. ⛔ An unvalidated assertion never yields an account. ⛔ **Mobile-number verification MUST NOT be a precondition of account creation** |

> **v2.0 `AUTH-4.16` (L1213):** *"All three **MUST** be satisfied. Absence of any one prevents account
> creation."* — the three being display name, mobile number, and completed verification.

| ID | v3.0 requirement |
|---|---|
| **`AUTH-4.16`** | ⭐ **AMENDED.** The prerequisites for account creation are exactly: **(i)** a **successfully validated Google OIDC assertion** yielding an immutable `sub`, and **(ii)** a `sub` **not already bound** to an account. Both **MUST** be satisfied. ⛔ **A mobile number is NOT a prerequisite.** ⛔ **Mobile verification is NOT a prerequisite.** ⚠ A **display name MAY be sourced from the Google profile or supplied by the person; it is a mutable presentation attribute and MUST NOT be a prerequisite of identity, a uniqueness key or a matching key** (`AUTH-3.52`, `AUTH-3.53`) |

⚠ **`AUTH-4.6`, `AUTH-4.11` and `AUTH-11.69` — display-name collection.** v2.0 required a display name to
be collected *before* verification, because the account was created at the instant of OTP success. ⭐ In
v3.0 the account is created at the instant of **provider identity binding**, and the display name is
available from the validated Google assertion. ⛔ **The display name therefore MUST NOT block account
creation**, and any v2.0 obligation to collect it *before* authentication is **re-scoped to: a display name
MUST be present on the account at creation, sourced from the assertion or supplied by the person.**

> **v2.0 `AUTH-4.17` (L1217):** *"Account creation **MUST** occur only upon successful verification, and
> **MUST** be atomic with it — there is no intermediate state in which an unverified account exists."*

| ID | v3.0 requirement |
|---|---|
| **`AUTH-4.17`** | ⭐ **AMENDED.** Account creation **MUST** occur only upon **successful Google authentication and provider-identity binding**, and **MUST** be atomic with it — there is **no** intermediate state in which an unbound account exists. ⭐ **The `PersonId` MUST be created in the same atomic act** (`ADR-0011`, `AUTH-3.54`) |
| **`AUTH-4.18`** | ⭐ **CARRIED FORWARD, re-keyed.** A failed or invalid Google assertion **MUST NOT** create an account and **MUST NOT** leave residue from which a future attempt could infer prior activity |

### 5.3 The account identifier

> **v2.0 `AUTH-4.19` (L1238):** *"The account identifier **MUST** be permanent and **MUST NOT** be reused
> after deletion."*
> **v2.0 `AUTH-4.20` (L1240):** *"The account identifier **MUST NOT** be derived from, or permit derivation
> of, the mobile number."*

| ID | v3.0 requirement |
|---|---|
| **`AUTH-4.19`** | ⭐ **PRESERVED — unchanged in substance.** The **`AccountId`** **MUST** be permanent and **MUST NOT** be reused after deletion |
| **`AUTH-4.20`** | ⭐ **AMENDED — STRENGTHENED.** The **`AccountId`** **MUST NOT** be derived from, or permit derivation of: ⛔ a **mobile number** · ⛔ the **Google `sub`** · ⛔ a **Google email** · ⛔ any **mutable Google profile datum**. ⛔ Identity matching, re-linking or account resolution **MUST NOT** be performed on a Google **email**, display name or profile attribute (`AUTH-3.52`, `AUTH-3.53`) |

⚠ **`AUTH-4.21` carried forward unchanged** — a newly created account is **Active** and holds no role at
either scope.

⚠ **v2.0's account-creation attribute table** listed *"Mobile number — the verified number"*. ⭐ In v3.0 the
attributes at creation are: `AccountId` (newly allocated, globally unique, permanent, non-reassignable) ·
`provider identity` (the bound immutable `sub`) · display name · account state **Active** · platform roles
**None** · tenant roles **None** · library associations **None**. ⛔ **No mobile number is held at creation.**

---

## 6. The `Unlinked` account state

⭐ `ADR-0129` decision **`A-11`**, Option (i). The eight v2.0 states cannot express the condition that
`U-1 = B` creates: every existing non-authenticable state is entered by a **deliberate administrative act**
(`Suspended`, `Disabled`, `Pending Deletion`, `Deleted`), or is automatic-but-punitive and OTP-specific
(`Locked`), or **permits** authentication (`Pending Verification`, `Active`, `Inactive`).

### 6.1 Why the name is `Unlinked` and not `Orphaned`

⛔ **"Orphaned" is REJECTED on measured evidence.** `Accepted` `ADR-0011` **L63** requires that Account and
`PersonId` are *"mandatory, created together, **never orphaned**"*, and `Student_Identity_PRD_v1` states the
same. In this repository *"orphaned"* denotes a **forbidden dangling-identity defect**. Reusing it for a
**legitimate, governed state** would make a prohibited condition and a permitted state share one word.

⭐ **`Unlinked` names exactly what happened: the account's link to its sole provider identity is gone,
while the account itself remains fully intact.**

### 6.2 Definition

**`Unlinked`** — the account's **sole `provider identity` has become permanently invalid or unavailable**,
so no Google assertion can any longer resolve to it. It is **system-triggered** and **non-punitive**: no
administrator judged the holder, and no abuse was detected. The `AccountId`, the `PersonId` and every
business record remain **intact and authoritative**; only the ability to *prove* control is gone.

### 6.3 The state table row

| State | Meaning | Can authenticate | Can obtain a session | Holds data |
|---|---|---|---|---|
| ⭐ **Unlinked** | The sole `provider identity` is permanently invalid or unavailable; the account and all its records survive | **No** | **No** | **Yes — fully retained** |

### 6.4 Requirements

| ID | Requirement |
|---|---|
| **`AUTH-9.8`** | ⭐ **AMENDED.** Authentication **MUST** be permitted only in **Active** and **Inactive**; every other state **MUST** refuse it — ⛔ **including `Unlinked`**. ⚠ *(v2.0 also listed **Pending Verification**, which existed to complete mobile verification. In v3.0 an account is created only upon provider-identity binding (`AUTH-4.17`), so no pre-binding authenticable state exists. **Pending Verification is retained as a state for Version 2 mobile-verification use and MUST NOT permit Version 1 authentication.**)* |
| ⭐ **`AUTH-9.90`** | `Unlinked` **MUST** be **system-triggered** and **MUST NOT** be enterable by administrative action, nor used as a sanction, penalty or security signal |
| ⭐ **`AUTH-9.91`** | Entering `Unlinked` **MUST** preserve the **`AccountId`**, the **`PersonId`** and **every** business record — membership, attendance, fees, financial history and audit. ⛔ It **MUST NOT** delete, anonymise or release anything |
| ⭐ **`AUTH-9.92`** | While `Unlinked`, the account **MUST NOT** authenticate and **MUST NOT** hold or obtain a session. Existing sessions **MUST** be terminated immediately and globally on entry (`AUTH-6.26`, `AUTH-11.66`) |
| ⭐ **`AUTH-9.93`** | ⛔ Version 1 **MUST NOT** provide any exit from `Unlinked`. There is **no** re-link, **no** recovery, **no** identity-proofing and **no** administrative override in Version 1 |
| ⭐ **`AUTH-9.94`** | ⛔ Re-linking **MUST NOT** be performed automatically, and **MUST NOT** be keyed on a Google email, a display name or any profile attribute (`AUTH-3.52`, `AUTH-3.53`) |
| ⭐ **`AUTH-9.95`** | A future re-link or recovery mechanism **MUST** be introduced only by a **separate joint Product + Architecture decision**. ⛔ It is **not** decided by this document |
| ⭐ **`AUTH-9.96`** | ⛔ `Unlinked` **MUST NOT** be described, logged, reported or presented as *"orphaned"*, that term being reserved by `ADR-0011` for a **forbidden** dangling-identity condition |
| ⭐ **`AUTH-9.97`** | The `AccountId` of an `Unlinked` account **MUST NOT** be reused, consistent with `AUTH-4.19` |

### 6.5 Transitions

| From | To | Trigger | Reversible in V1 |
|---|---|---|---|
| `Active` · `Inactive` | ⭐ **`Unlinked`** | The sole `provider identity` becomes permanently invalid or unavailable | ⛔ **No** |
| ⭐ **`Unlinked`** | any state | ⛔ **No V1 transition exists** | ⛔ **No** |

⚠ **`Unlinked` is not terminal in the sense `Deleted` is** — the data survives and a future governed
decision may define an exit (`AUTH-9.95`). But **in Version 1 it has no exit**, and that is the accepted
consequence of `A-10`.

⚠ **`AUTH-9.6`, `AUTH-9.7`, `AUTH-9.9`–`AUTH-9.13` are carried forward unchanged.** ⚠ **`AUTH-9.9`
(`Locked` is automatic and self-clearing) is retained**, though its stated trigger — *"exhaustion of the OTP
request quota"* — has **no V1 authentication effect**, since Mobile OTP is not a V1 method. ⛔ `Locked` is
**not** repurposed and **not** deleted.

---

## 7. Recovery — Version 1 has none

⭐ `ADR-0129` decision **`A-10`**, faithfully implemented.

| ID | Requirement |
|---|---|
| ⭐ **`AUTH-4.40`** | ⛔⛔ Version 1 **MUST NOT** provide any Liboora-side recovery path for permanent loss of the sole Google account. Specifically prohibited: ⛔ OTP recovery · ⛔ SMS recovery · ⛔ email recovery · ⛔ guardian recovery · ⛔ administrative or manual identity proofing · ⛔ support-mediated re-linking · ⛔ passkey recovery · ⛔ alternate identity-provider recovery · ⛔ security questions |
| ⭐ **`AUTH-4.41`** | Where the person **recovers their Google account through Google**, the **same immutable `sub`** is presented and the **same `provider identity` continues to resolve** to the same `AccountId`. ⭐ **This is not a Liboora recovery mechanism** — nothing in Liboora changes, and no Liboora recovery capability is implied |
| ⭐ **`AUTH-4.42`** | Where the Google account is **permanently unrecoverable**, the account **MUST** enter **`Unlinked`** as defined in §6 |
| ⭐ **`AUTH-4.43`** | ⛔ A Google **recovery email or recovery phone MUST NOT** be treated as a Liboora identity, a Liboora recovery identity, a matching key or a re-link key. Google-side recovery contact details are **Google's mechanism, not Liboora's** |

⚠ **This gap is ACCEPTED, not mitigated** (`ADR-0129` `A-10.1`/`A-10.4`). It is recorded so that no
implementer introduces a recovery route to close it.

---

## 8. Sessions and revocation

> **v2.0 `AUTH-6.26` (L1908):** *"The platform **MUST** terminate sessions without user action on: account
> suspension, locking, disablement or deletion; mobile number change; device removal or trust revocation;
> administrative revocation; or detection of a security condition warranting it."*

| ID | v3.0 requirement |
|---|---|
| **`AUTH-6.26`** | ⭐ **AMENDED.** The platform **MUST** terminate sessions without user action on: account **suspension, locking, disablement or deletion** · ⭐ **entry into `Unlinked`** · ⭐ **revocation, invalidation or permanent unavailability of the bound `provider identity`** · **device removal or trust revocation** · **administrative revocation** · or **detection of a security condition warranting it**. ⛔ *"Mobile number change"* is **removed as a V1 trigger**, the mobile number no longer being the V1 authentication identity |

⚠ **Every other trigger is preserved.** ⛔ Nothing in this amendment weakens revocation:
**`AUTH-6.25`** (global sign-out within the revocation window, including offline devices),
**`AUTH-6.27`** (forced sign-out emits an event identifying the cause),
**`AUTH-6.28`** (a terminated session is never recoverable) and
**`AUTH-11.66`** (*"Revocation MUST be immediate and global"*) are **carried forward unchanged**.

⚠ **`AUTH-8.81` — inspected, deliberately CARRIED FORWARD UNCHANGED.** It reads *"A stolen device holding a
valid session MUST NOT be able to change the mobile number, remove other devices…"*. This is a **stolen-device
containment** control, not an authentication requirement. Since V1 holds no mobile number, the
mobile-number limb is **inert in V1** rather than wrong, and the remaining limbs are still required. ⛔ It is
**not** edited — it is cited by line (`Authentication_PRD_v2.md` **L2983**) and freezing it preserves that
citation.

---

## 9. Privacy — conditions `C-1`, `C-2`, `C-3`

⭐ Privacy Owner sign-off was **APPROVE WITH CONDITIONS**. All three are implemented here.

### `C-1` — the provider identity may be held

> **v2.0 `AUTH-11.31` (L4373):** *"Personal data MUST be collected only for authentication, protection and
> notification, and MUST be limited to the mobile number and display name."*
> **v2.0 `AC-11.18` (L4498):** *"Authentication holds no personal attribute beyond mobile number and display name."*

| ID | v3.0 requirement |
|---|---|
| **`AUTH-11.31`** | ⭐ **AMENDED.** Personal data **MUST** be collected only for authentication, protection and notification, and **MUST** be limited to: ⭐ the **immutable Google `sub`** (the `provider identity` key) and a **display name**. ⛔ A **mobile number is NOT mandatory Version 1 authentication data** and **MUST NOT** be required for authentication or account creation |
| **`AC-11.18`** | ⭐ **AMENDED.** Authentication holds no personal attribute beyond the **immutable Google `sub`** and a **display name** |

⭐ **Data minimisation is preserved, not relaxed:** the permitted set stays at **two** attributes. The `sub`
replaces the mobile number; it does not join it.

### `C-2` — the mobile number is not mandatory V1 authentication data

| ID | Requirement |
|---|---|
| ⭐ **`AUTH-11.90`** | ⛔ A mobile number **MUST NOT** be mandatory Version 1 authentication data, **MUST NOT** be a Version 1 authentication credential, and **MUST NOT** be required to create, hold or use an account |

⚠ **`MP-GBR-34` is preserved** — no event may ever carry a mobile number. ⚠ **`AC-11.19` is carried
forward** — where a mobile number exists for non-authentication purposes it remains masked everywhere except
to its own holder.

### `C-3` — prohibited uses of Google data

| ID | Requirement |
|---|---|
| ⭐ **`AUTH-11.91`** | ⛔ The Google **email MUST NOT** be persisted or used as: canonical identity · `AccountId` · `PersonId` · uniqueness key · automatic matching key · automatic re-link key · payment identity · recovery identity |
| ⭐ **`AUTH-11.92`** | ⛔ Google **profile data** — display name, profile picture, locale, given/family name — **MUST NOT** be treated as canonical identity or used as a matching or re-link key. It is **mutable presentation data only** |
| ⭐ **`AUTH-11.93`** | ⛔ A Google **recovery Gmail address or recovery phone MUST NOT** be persisted or used as a Liboora identity, matching key, re-link key or recovery identity. It remains **Google-side recovery only** |
| ⭐ **`AUTH-11.94`** | ⛔ No **new Liboora recovery channel** is created by these conditions (`AUTH-4.40`) |

⚠ **`AUTH-11.24`** (observability holds no unmasked personal data), **`AUTH-11.35`** (minors' data receives
the strictest treatment), **`AUTH-11.37`** (personal data held within permitted jurisdictions) and
**`AUTH-11.38`** (audit holds no unmasked personal data) are **carried forward unchanged** — and now apply
to the `sub` as authentication personal data.

---

## 10. Roles, Reception and privileged access

⭐ `ADR-0129` decisions **`A-13`** (Options A + C) and **`A-15`** (Option B), implemented.

| ID | Requirement |
|---|---|
| ⭐ **`AUTH-7.80`** | **Reception MUST authenticate by Google Sign-In**, identically to every other role. ⛔ **No** Reception-specific method, exception, bypass or fallback **MAY** exist (`AUTH-3.18`) |
| ⭐ **`AUTH-7.81`** | ⛔ A **shared, generic or desk-level Reception account MUST NOT** exist. Every Reception operator authenticates as **themselves** |
| ⭐ **`AUTH-7.82`** | Shared-device behaviour at a reception desk **MUST** be handled as a **device and session concern** — short idle timeout (`CFG-5`), bounded absolute lifetime (`CFG-6`), device trust (`CFG-7`) — ⛔ **never** as an authentication exception |
| ⭐ **`AUTH-7.83`** | **`PR-1` and `PR-2` MUST authenticate by Google Sign-In**, with ⛔ **no second Version 1 authentication factor** (`AUTH-3.45`) |
| ⭐ **`AUTH-7.84`** | Existing privileged **elevation, re-authentication, session and audit** controls remain **layered security obligations on the authentication mechanism**, per `Accepted` `ADR-0063`: *"a SECURITY-platform obligation layered on `BC-18`'s existing mechanism. It is not an authentication requirement."* ⛔ **`ADR-0063` is NOT reopened, NOT amended and NOT weakened** |

⚠ Chapter 7's access-policy requirements — including **`AUTH-7.6`** *"Deny by default"*, cited by line at
`Authentication_PRD_v2.md` **L2263** — are **carried forward unchanged**.

---

## 11. Minors, guardians and enrollment

⭐ Boundaries preserved exactly as decided; nothing new invented.

| ID | Requirement |
|---|---|
| ⭐ **`AUTH-2.40`** | A **student record MAY exist without any account**. Enrollment, attendance and library operation on that record **MUST** remain possible with no account and no authentication *(consistent with v2.0 `XC-4.2`)* |
| ⭐ **`AUTH-2.41`** | ⛔ **`GuardianLink` is an enrollment and consent relationship, NOT an authentication mechanism.** It **MUST NOT** confer login capability, session capability or any authentication right |
| ⭐ **`AUTH-2.42`** | ⛔ A guardian **MUST NOT** authenticate as, on behalf of, or in place of a student. **No** guardian login, **no** proxy login, **no** delegated authentication, **no** impersonation |
| ⭐ **`AUTH-2.43`** | Minors who cannot independently satisfy Google account eligibility are **outside Version 1 authentication scope** (`AUTH-3.48`). ⛔ **No alternate Version 1 authentication method MAY be invented for them** |

⚠ **`AUTH-11.35` is carried forward** — minors' data receives the strictest available treatment and is
reachable only by the minor, their linked guardian, and roles strictly requiring it.

---

## 12. OTP and SMS references — classified, not swept

⛔ **No global deletion of OTP/SMS content was performed.** Every category was classified deliberately.

| Class | Disposition | Examples |
|---|---|---|
| **A — V1 authentication** | ⭐ **Removed or re-scoped** | `AUTH-3.15`, `3.16`, `3.17`, `3.22` (tombstone), `4.1`, `4.4`, `4.16`, `4.17`, `11.31`, `11.67`, `AC-11.18` |
| **B — V2 capability** | ⭐ **Preserved as future scope** | `AUTH-3.46`, `AUTH-3.47`; `CFG-1`–`CFG-4`; `Pending Verification` retained for V2 |
| **C — notification / communication / security** | ⭐ **Preserved unchanged** | `AUTH-11.36`, `AUTH-11.50`, `AUTH-8.81`, `AUTH-11.24`, `AUTH-11.37` |
| **D — unrelated** | ⭐ **Untouched** | every other v2.0 requirement, carried forward by reference |

### 12.1 Individually inspected

> **v2.0 `AUTH-11.67` (L4452):** *"Mobile OTP MUST be the sole authentication factor in the first version"*

| ID | v3.0 requirement |
|---|---|
| **`AUTH-11.67`** | ⭐ **AMENDED — re-scoped.** ⛔ Mobile OTP is **NOT** an authentication factor in Version 1. **Google Sign-In is the sole required Version 1 authentication factor.** ⚠ Mobile OTP is **re-scoped to Version 2 and not removed from the product** (`AUTH-3.46`); its V2 purpose remains a future decision (`AUTH-3.47`) |

> **v2.0 `AUTH-11.36` (L4378):** *"Transactional messages MUST conform to the registered-sender and template
> regime; codes MUST be numeric to satisfy it"*

⭐ **CARRIED FORWARD UNCHANGED — class C.** This governs **transactional messaging** (DLT
registered-sender/template compliance), not authentication. It is **not contradictory**: it constrains codes
*wherever* codes are sent, and is dormant for V1 authentication while remaining correct for V2 and for
non-authentication messaging. ⛔ Not deleted.

> **v2.0 `AUTH-11.50`:** existing sessions unaffected by delivery-provider failure.
> **v2.0 `AUTH-11.51` (L4427):** the platform can switch delivery providers without specification change.

⭐ **Both CARRIED FORWARD UNCHANGED — class C.** They are **delivery-independence** guarantees. ⛔ `AUTH-11.51`
is cited by line and is deliberately untouched.

⚠ **`AUTH-11.68`** (no password, PIN, security question or reusable secret) · **`AUTH-11.63`**–**`11.66`**
(one active library, authentication/authorization distinct, sessions carry no permissions, revocation
immediate and global) · **`AUTH-11.71`** (cross-context communication solely by events) — **all carried
forward unchanged**.

⚠ **`AUTH-11.70`** (*"Account creation MUST occur on first successful verification"*) is ⭐ **AMENDED** to:
account creation **MUST** occur on **first successful Google authentication and provider-identity binding**,
and at no earlier point — consistent with `AUTH-4.17`.

---

## 13. Traceability to `ADR-0129`

| Decision | Where implemented |
|---|---|
| **`P-1`** Google Sign-In is the V1 method | §1.1 `AUTH-3.40`–`3.45`; §3.1 `AUTH-3.13`/`3.15`/`3.16`/`3.17` |
| **`U-1 = B`** remove the mobile identity anchor | §4 `AUTH-3.22` tombstone; `AUTH-3.41`; `AUTH-11.90` |
| **`A-1`…`A-6`** identity model | §2 `AUTH-3.49`–`3.55`; §5 `AUTH-4.1`/`4.20` |
| **`A-7`** BC Map edge required | ⛔ **NOT executed here** — separate act; `E-34` not allocated |
| **`A-8`** `identity_provider` port required | ⛔ **NOT executed here** — separate act |
| **`A-9`** secret custody | ⛔ **Outside the conferral** — not addressed |
| **`A-10`** recovery gap accepted | §7 `AUTH-4.40`–`4.43` |
| **`A-11`** new state, Option (i) | §6 `Unlinked`, `AUTH-9.8`, `9.14`–`9.21` |
| **`A-12`** session/revocation | §8 `AUTH-6.26` |
| **`A-13`** Reception, Options A + C | §10 `AUTH-7.80`–`7.82` |
| **`A-14`**/**`A-16`** V1 scope exclusion accepted | §1.3 `AUTH-3.48`; §11 `AUTH-2.43` |
| **`A-15`** `PR-1`/`PR-2`, Option B | §10 `AUTH-7.83`–`7.84` |
| **`C-1`**/**`C-2`**/**`C-3`** privacy | §9 `AUTH-11.31`, `AC-11.18`, `AUTH-11.90`–`11.94` |

---

## 14. Change history

| Version | Change |
|---|---|
| ⭐ **v3.0** | 2026-09-10. **Google Sign-In (Google OIDC) becomes the sole required Version 1 authentication method; Mobile OTP is re-scoped to Version 2 and NOT removed** — authorised by `Accepted` `ADR-0129`, aligned to `MASTER_PRD` v1.8. Authored as a **delta successor**: v2.0's 588 requirements are carried forward by reference except those enumerated in §3–§5, §8, §9 and §12. **`AUTH-3.22` is REMOVED as a tombstone**, its identifier retired and never reusable, its historical citations in `ADR-0129` and `MASTER_PRD` v1.8 left intact; the **active range is corrected to `AUTH-3.20` through `AUTH-3.21`**. **New: `AUTH-3.40`–`3.55`, `AUTH-4.40`–`4.43`, `AUTH-9.90`–`9.97`, `AUTH-7.80`–`7.84`, `AUTH-2.40`–`2.43`, `AUTH-11.90`–`11.94`.** **Amended: `AUTH-3.13`/`3.15`/`3.16`/`3.17`/`3.20`, `AUTH-4.1`/`4.4`/`4.16`/`4.17`/`4.20`, `AUTH-6.26`, `AUTH-9.8`, `AUTH-11.31`/`11.67`/`11.70`, `AC-11.18`.** The **`Unlinked`** state is introduced (⛔ *"Orphaned"* rejected — `ADR-0011` L63 reserves *"orphaned"* for a forbidden condition). ⛔⛔ **Authentication PRD v2.0 and all of `prd-v2/` are BYTE-FROZEN and NOT edited**, preserving 15 line-number citations in 9 documents including `Accepted` `ADR-0061` and `ADR-0063`; the inherited **44-line drift** between v2.0's assembled file and its chapter sources is **recorded, not repaired**. ⛔ **NOTHING ELSE EXECUTED:** no BC Map edge, **`E-34` NOT allocated**, no `identity_provider` port, `module_dependencies.yaml` untouched, `DOCUMENTATION_BASELINE.md` **not updated and now knowingly stale** for this module, **`ADR-0002` and `ADR-0005` NOT superseded** (both still outstanding), `ADR-0011`/`ADR-0063`/`ADR-0128`/`ADR-0129` unmodified, **no blocker closed** (`MP-DEP-03`, `BLK-01`, `BLK-02`, `TASK-D10`, gate 3, `H1`–`H4`, `D3`), **`A-9` not executed**, and **no code, schema, API, UI or test changed**. ⛔ **No implementation, SDK, OIDC library or SMS provider selected.** |
| **v2.0** | 2026-08-02. Authored from scratch against the approved architecture rulings, Master PRD global rules, the Bounded Context Map and implemented behaviour. 588 requirements, eleven chapters. `D-7` closed by authorship; `ACN-001` closed by Chapter 8. ⛔ **Frozen by v3.0 — retained as the historical baseline and as the anchor for existing line-number citations.** |
| **v1.0** | Never transferred into the repository — eleven empty custody slots, retained under `docs/90-archive/authentication-v1/`. Historical input only; carries no authority. |
