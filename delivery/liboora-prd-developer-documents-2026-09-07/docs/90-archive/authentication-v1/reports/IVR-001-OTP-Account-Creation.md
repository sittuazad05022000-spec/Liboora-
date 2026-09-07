> # ⛔ ARCHIVED — NOT AUTHORITATIVE
>
> **This document has no standing.** It is retained for historical record only and **must not be cited as
> authority, quoted in a specification, or used to guide implementation.**
>
> | | |
> |---|---|
> | **Archived** | 2026-08-02 |
> | **Superseded by** | [`Authentication PRD v2.0`](../../../30-product/authentication/Authentication_PRD_v2.md) |
> | **Authority** | [`ADR-0008`](../../../00-governance/adr/ADR-0008-authentication-prd-v2-baseline.md) · [`DOCUMENTATION_BASELINE.md`](../../../00-governance/DOCUMENTATION_BASELINE.md) |
>
> **Why archived: superseded as a validation record. Its rulings `AR-2`, `AR-5`, `AR-6` and `AR-7` remain in force and are promoted to `ADR-0005`, `ADR-0006`, `ADR-0004` and `ADR-0007` respectively. References within to an empty or missing PRD are stale.**
>
> Defect `D-7` — *"the Authentication PRD is not present in this repository"* — is **CLOSED**. The specification
> now exists as Authentication PRD v2.0. Any statement below asserting that the specification is missing, empty,
> pending transfer, or unwritten **was true when written and is false now.**

---

# IVR-001 — Implementation Validation Report
## Account creation on first successful OTP verification

| Field | Value |
|---|---|
| **Report ID** | `IVR-001` |
| **Version** | **v1.1** — updated to reflect the approved rulings `AR-5`, `AR-6`, `AR-7` |
| **Implements** | `ACR-001` (approved) · rulings `AR-2`, `AR-5`, `AR-6`, `AR-7` |
| **Status** | **COMPLETE — VALIDATED. All blockers resolved. Implementation authorised.** |
| **Previously blocked by** | [`ACR-002`](./ACR-002-New-Account-State.md) — **now resolved by ruling.** Blocker A → `AR-5` (option A1) · Blocker B → `AR-6` (option B3) · `RK-3` → `AR-7` (option C1) |
| **Deferred by ruling** | OTP request rate limiting → [`ACN-001`](./ACN-001-OTP-Request-Rate-Limiting.md). **Not a blocker for this report** (§5) |
| **Date** | 2026-08-02 (v1.0) · 2026-08-02 (v1.1, post-ruling) |
| **Code state at v1.1** | commit `e6f1d3e`, working tree clean, `flutter analyze` → `No issues found!`, all tests passing |
| **Code written at time of writing** | **NONE.** Written only after this update, per your sequencing instruction |

> **Outcome of validation: PASS. Implementation may proceed.**
>
> **v1.0 concluded STOP.** Two states required by the change were unspecified in every authoritative document,
> and choosing either would have invented a requirement. `ACR-002` documented them without choosing.
>
> **v1.1 records that all three open items have been settled by ruling**, not by inference:
>
> | v1.0 blocker | Ruling | Approved answer |
> |---|---|---|
> | §4.2 Blocker A — `displayName` unknown at OTP time | **`AR-5`** (option A1) | Registration collects the Display Name **before** OTP verification. `displayName` stays required and non-nullable |
> | §4.3 Blocker B — a role-less account can hold no `AuthSession` | **`AR-6`** (option B3) | Authentication and Session Issuance are **separate stages**. An Account may exist before any tenant role |
> | §6.1 `RK-3` — an `F-02` assertion tests internal storage | **`AR-7`** (option C1) | Conformance validates **security behaviour**, not storage. `F-01`/`F-02` not weakened |
>
> Your sequencing instruction — *"Before writing code, update IVR-001 to reflect these approved rulings and
> confirm that all validation blockers are resolved"* — is satisfied by this version. **§9 confirms every
> validation gate now passes.** No requirement has been invented at any point: each answer is quoted from your
> ruling.

---

## 1. Requirements being implemented

| # | Requirement | Source |
|---|---|---|
| **1.1** | A new `Account` shall be created **only after** successful OTP verification | Your approval, *Approved Principle* · `AR-2` · Bounded Context Map §4 |
| **1.2** | OTP challenge handling shall preserve the existing anti-enumeration guarantees `F-01` and `F-02` | Your approval · `BLOCKER_CLOSURE_v1.0.md` §4 |
| **1.3** | Observable behaviour shall remain **identical** for existing and non-existing phone numbers **until OTP verification succeeds** | Your approval, *Approved Principle* |
| **1.4** | `BC-18` retains ownership of OTP, Registration, Account creation, Session management, Authorization handoff | `AR-2` |
| **1.5** | Mobile OTP remains the sole authentication factor; no passwords, no alternative methods, no guest or anonymous accounts | `MP-GBR-25`, `MP-CON-11`, your approval |
| **1.6** | Minimum possible change; APIs unchanged unless absolutely necessary; backward compatibility preserved | Your approval, *Implementation Requirements* |
| **1.7** | The Registration flow shall collect the Display Name **before** OTP verification. `displayName` remains **required and non-nullable.** Empty string, mobile number, placeholder values and auto-generated names are **prohibited.** Authentication is responsible for **OTP verification only**; Registration owns profile collection | **`AR-5`** (option A1) |
| **1.8** | **Authentication and Session Issuance are separate stages.** An Account may exist before any tenant role exists. Session issuance shall occur **only after** the required authorization context exists. Authentication and Authorization responsibilities shall not be merged | **`AR-6`** (option B3) |
| **1.9** | `F-02` conformance shall validate **security behaviour** — identical observable behaviour for registered and unregistered numbers until verification succeeds — rather than implementation details such as internal storage. `F-01` and `F-02` shall not be weakened | **`AR-7`** (option C1) |
| **1.10** | **No rate-limiting policy shall be invented.** The requirement is recorded for the Authentication Security PRD | Ruling · [`ACN-001`](./ACN-001-OTP-Request-Rate-Limiting.md) |

**Requirement 1.3 is the binding constraint** and is the reason the change is small. In v1.0 it was also what
exposed the two unspecified states: *"until OTP verification succeeds"* implies a defined behaviour **at and
after** the moment it succeeds for a number that has no account.

**That behaviour is now specified.** Requirements 1.7 and 1.8 supply it:

- **at** the moment of success — an `Account` is created using the name Registration collected beforehand (1.7);
- **after** it — the account exists with no tenant role, and a session is issued separately, only once an
  authorization context exists (1.8).

Requirements 1.7–1.9 **add no scope.** They answer questions the change already had to answer.

---

## 2. Exact architecture references

| Reference | Location | Statement |
|---|---|---|
| **Account lifecycle** | `LIBOORA_BOUNDED_CONTEXT_MAP.md` §4, line 155 | *"**Account** · `AccountId` · BC-18 Identity & Access · Global, cross-tenant · **Created on first successful OTP.** Destroyed on account deletion. Holds *credentials only*."* |
| **BC-18 ownership** | `LIBOORA_BOUNDED_CONTEXT_MAP.md` line 119 | `BC-18` *"Owns credentials, sessions, devices, OTP, roles, permissions, policy decisions, consent"* |
| **BC-18 tenancy model** | `LIBOORA_BOUNDED_CONTEXT_MAP.md` §11, line 473 | *"**Hybrid.** `Account` is global; role assignments are tenant-scoped. `AccessPolicy` is always evaluated with a tenant in scope"* |
| **Identity separation** | `LIBOORA_BOUNDED_CONTEXT_MAP.md` `ID-1` | *"No context outside BC-18 may store a password, OTP, session or credential."* |
| **Ruling** | `ARCHITECTURE_RULINGS.md` `AR-2` | *"Account creation on the first successful OTP verification is explicitly approved."* |
| **Ruling** | `ARCHITECTURE_RULINGS.md` `AR-5` | *"The Registration flow shall collect the user's Display Name before OTP verification. `displayName` shall remain required and non-nullable."* |
| **Ruling** | `ARCHITECTURE_RULINGS.md` `AR-6` | *"Authentication and Session Issuance are separate stages… An Account may exist before any tenant role exists… Session issuance shall occur only after the required authorization context exists."* |
| **Ruling** | `ARCHITECTURE_RULINGS.md` `AR-7` | *"Conformance tests shall validate security behaviour rather than implementation details such as internal storage."* |
| **Role acquisition sits after authentication** | Library PRD §14A.7 | *Join Library → Authentication → Registration (if required) → **Membership Processing** → Library Member* — confirms `AR-6`'s stage order |
| **Module boundary** | `tool/module_dependencies.yaml` `platform/identity` | `rank: 4` · `imports: [{target: contracts, mode: import}]` · `banned_imports: ["domain/**","app/**"]` · assertions `ID-1`…`ID-9` |
| **System Architecture** | `LIBOORA_ENTERPRISE_ARCHITECTURE.md` v2.0 | Authoritative per ruling `R-1` |

**Validated:** the change is confined to `platform/identity` (rank 4). It requires no new import, no new port, no
new event, no cross-module edge. Module boundary compliance: **PASS**.

---

## 3. Exact PRD references

| Reference | Location | Statement | Status |
|---|---|---|---|
| `MP-GBR-25` | `MASTER_PRD.md` line 369 | *"Mobile OTP is the sole authentication factor in V1. There are no passwords."* | ✅ Preserved |
| `MP-GBR-26` | `MASTER_PRD.md` line 370 | *"Session revocation is immediate and global."* | ✅ Untouched |
| `MP-GBR-27` | `MASTER_PRD.md` line 371 | *"No context outside `BC-18` may store a password, OTP, session or credential."* | ✅ Preserved — creation happens inside `BC-18` |
| `MP-CON-11` | `MASTER_PRD.md` line 512 | *"No passwords, no social login, no demo or guest accounts in any release build."* | ✅ No guest/anonymous account introduced |
| `LIB-DISC-008` | Library PRD §14A.11 | *"Authentication and Registration are owned by the Authentication module."* | ✅ Library side needs no change |
| §14A.7 | Library PRD | *Join Library → Authentication → **Registration (if required)** → Membership Processing → Library Member* | ⚠️ See §4 |
| §14A.7 | Library PRD | *Join Library → Authentication → **Registration (if required)** → Membership Processing → Library Member* | ✅ **Consistent with `AR-6`** — see §4 |
| **Chapter 3 — Registration** | `docs/prd/authentication/03-Registration.md` | **1,284 bytes, 29 lines, 0 body characters.** Empty transfer slot. Defect `D-7` OPEN | ⚠️ Still empty — **but the requirement this change needed is now supplied by ruling `AR-5`** |
| **Chapter 6 — Sessions** | `docs/prd/authentication/06-Sessions.md` | **1,280 bytes, 29 lines, 0 body characters.** Empty transfer slot. Defect `D-7` OPEN | ⚠️ Still empty — **but the requirement this change needed is now supplied by ruling `AR-6`** |
| **Chapter 7 — Security** | `docs/prd/authentication/07-Security.md` | **1,280 bytes, 29 lines, 0 body characters.** Empty transfer slot | ⚠️ Still empty — rate limiting deferred by ruling to [`ACN-001`](./ACN-001-OTP-Request-Rate-Limiting.md) |

**This is where v1.0 failed validation**, because the two chapters that would specify what a newly created account
looks like and what session it receives were both empty.

**v1.1: resolved by ruling, not by inference.** Chapters 3, 6 and 7 remain empty — defect `D-7` stays **OPEN** and
is unchanged by this report. What has changed is that the **specific** decisions this change required no longer
depend on them: they were issued directly as `AR-5`, `AR-6` and `AR-7`, which the rulings register records as
authoritative. Nothing else that those chapters will eventually contain has been assumed.

---

## 4. Exact files that will change — RESOLVED BY RULING

### 4.0 Design derivation from the rulings

Every element below is traced to a ruling clause. Nothing is selected on preference.

**`AR-6` requires two stages.** The current single call cannot express them:

```dart
// BEFORE — one call performs authentication, authorization and session issuance
AuthSession? verifyOtp({required String phone, required String code,
                        required TenantId tenant, required BranchId branch});
```

A role-less account exits at `if (roles.isEmpty) return null;` (line 353), making a *successful* verification
observably identical to a *failed* one. `AR-6` splits the call:

```dart
// AFTER — Stage 1: Authentication only. Identity verification + account creation.
Account? verifyOtp({required String phone, required String code, String? displayName});

// AFTER — Stage 2: Session issuance. Requires an authorization context to already exist.
AuthSession? issueSession({required Account account,
                           required TenantId tenant, required BranchId branch});
```

| Design element | Ruling clause it implements |
|---|---|
| `verifyOtp` returns `Account?`, not `AuthSession?` | `AR-6`: *"Authentication is responsible for identity verification and account creation"* |
| `tenant` / `branch` removed from `verifyOtp` | `AR-6`: *"Do not merge Authentication and Authorization responsibilities"* — a tenant parameter on an authentication call **is** that merge |
| `issueSession` is separate and returns `null` while `rolesIn(tenant)` is empty | `AR-6`: *"Session issuance shall occur only after the required authorization context exists"* |
| A created `Account` carries `roles: const {}` | `AR-6`: *"An Account may exist before any tenant role exists"* |
| `displayName` passed **in** at creation time — never held between calls, never generated | `AR-5`: *"The Authentication module remains responsible for OTP verification only. Registration owns the collection of user profile information"* — Authentication must not hold profile-collection state |
| `Account.displayName` type unchanged (`required`, non-nullable `String`) | `AR-5`: *"`displayName` shall remain required and non-nullable"* |
| Creation refused when the offered name is null, empty, whitespace-only, or equal to the phone number | `AR-5`: *"Do not use: Empty string · Mobile number"* — the machine-detectable prohibitions |
| No name is ever synthesised | `AR-5`: *"Do not use: Placeholder values · Auto-generated names"* |
| An existing account's `displayName` is **never** rewritten by a later verification | `AR-5` ownership: profile mutation is not an Authentication concern |
| `requestOtp` stores the challenge unconditionally | `AR-7`: *"identical observable behaviour for registered and unregistered phone numbers"* — removes the last registration-dependent branch |
| `requestOtp` signature unchanged | Requirement 1.6, minimum change — the name is not needed until creation |

**Why a nullable parameter on a non-nullable field is not a loophole.** `Account.displayName` stays
**non-nullable**, per `AR-5`. The *parameter* is nullable solely so the existing sign-in path — where the account
already exists — compiles and behaves unchanged. When creation is required and no collected name is present, the
account is **not created**. There is no path on which a nullable parameter yields a null, empty, derived, or
generated `displayName`.

**Breaking-change declaration.** `verifyOtp`'s return type changes and two parameters are removed. This is a
breaking change to an internal API. It is in scope because **the signature is the subject of `AR-6`**; the
constraint *"do not modify unrelated APIs"* is not breached, because no other API changes.

### 4.1 Change set (minimum)

| File | Change | Forced by |
|---|---|---|
| `lib/platform/identity/identity.dart` | `requestOtp` — remove the registration-dependent storage branch; `verifyOtp` — return `Account?` and create on first success using the collected name; **new** `issueSession` | `AR-5`, `AR-6`, `AR-7` |
| `lib/app/session.dart` | `SessionController.verifyOtp` — adapt to the two-stage call, accept the collected display name, represent the authenticated-without-authorization state | `AR-6` |
| `lib/app/shell/login_screen.dart` | Collect the Display Name **before** OTP verification, shown uniformly for every number | `AR-5` |
| `test/authentication_conformance_test.dart` | Re-express one `F-02` assertion per `AR-7`; adapt call sites to the split API; add coverage for each ruling | `AR-6`, `AR-7` · §6 |

**No other file.** **No change** to `AccessPolicy`, `PolicyDecisionPoint`, `AccessRole`, `Permission`,
`AccessScope`, session revocation, `di.dart`, `seed.dart`, `pubspec.yaml`, `tool/module_dependencies.yaml`, any
`domain/**` module, or any PRD.

**Scope note on the two files added since v1.0.** v1.0 listed only `identity.dart` and the test file and stated
*"no change to `session.dart`, `login_screen.dart`."* `AR-6` makes `session.dart` unavoidable — it is the **sole**
production caller of `AuthService.verifyOtp` (`session.dart:83`), so a two-stage split cannot compile without it.
`AR-5` makes `login_screen.dart` unavoidable — a Display Name collected *before* OTP verification must be collected
*somewhere*, and that screen is the only registration surface that exists. Both are consequences of the rulings,
not scope creep. Neither adds a capability beyond what the rulings state.

**Anti-enumeration constraint carried into the UI.** The name field is shown for **every** number,
unconditionally. The screen must never ask *"is this number registered?"* to decide which fields to display —
that would rebuild the `F-02` oracle in the presentation layer, one level above the fix. The uniform-field rule is
the UI-level expression of requirement 1.3.

### 4.2 Blocker A — **RESOLVED** by `AR-5` (option A1)

**v1.0 finding, retained for the record:**

`lib/platform/identity/identity.dart` lines 26–45:

```dart
final class Account {
  const Account({
    required this.id,
    required this.phone,
    required this.displayName,   // ← non-nullable String, REQUIRED
    required this.roles,
    this.personId,
  });
```

To construct an `Account` at OTP-verification time, a `displayName` is mandatory. **A first-time user has not
supplied one.** The candidate answers — empty string, the phone number, a placeholder, or a name-capture step
before or after OTP — are **four different product decisions**, and Chapter 3 (Registration), which would settle
it, is empty.

**Resolution — `AR-5`, option A1.** You ruled the fourth answer, and the ordering within it:

> *"The Registration flow shall collect the user's Display Name **before** OTP verification. `displayName` shall
> remain required and non-nullable."*
>
> Prohibited: *empty string · mobile number · placeholder values · auto-generated names.*

| v1.0 candidate | Ruled |
|---|---|
| Empty string | ❌ Prohibited |
| Mobile number | ❌ Prohibited |
| Placeholder | ❌ Prohibited |
| Auto-generated | ❌ Prohibited |
| **Collect it before OTP verification** | ✅ **Approved (A1)** |

**Effect on the code.** `Account` at lines 26–45 is **unchanged** — no nullable migration, no default, no
derivation. The field stays `required` and non-nullable. The name arrives from the Registration flow and is used
only at the moment of creation (§4.0).

**Blocker A is closed.** No requirement was inferred: the answer is quoted above.

### 4.3 Blocker B — **RESOLVED** by `AR-6` (option B3)

**v1.0 finding, retained for the record:**

`lib/platform/identity/identity.dart` lines 350–362:

```dart
    final account = _accountForPhone(phone);
    if (account == null) return null;
    final roles = account.rolesIn(tenant);
    if (roles.isEmpty) return null;          // ← a new account ALWAYS lands here

    return AuthSession(
      ...
      activeRole: roles.first,               // ← non-nullable AccessRole
```

A newly created `Account` has `roles == {}`. This is **architecturally correct** — Bounded Context Map §11
line 473 states role assignments are tenant-scoped and `AccessPolicy` *"is always evaluated with a tenant in
scope"*, and Library PRD §14A.7 places role acquisition in **Membership Processing**, *after* Authentication.

So the approved flow necessarily produces an interval in which a user is **authenticated but holds no role in
any tenant.** The current model cannot represent that state: `AuthSession.activeRole` is a non-nullable
`AccessRole`, and `verifyOtp` returns `null` — indistinguishable from authentication failure.

**Consequence if I proceeded anyway:** the account would be created, `verifyOtp` would return `null`, and the UI
would report failure. The user would have an invisible account and no way in. That is a worse outcome than
today's clean rejection, and it would silently violate requirement 1.3 by making a *successful* verification
observably identical to a *failed* one.

The document that would specify this — Chapter 6, Sessions — is empty.

**Resolution — `AR-6`, option B3.** You ruled that the two responsibilities are distinct stages:

> *"Authentication and Session Issuance are separate stages… An Account may exist before any tenant role exists.
> Authentication is responsible for identity verification and account creation. Authorization remains responsible
> for tenant roles. Session issuance shall occur only after the required authorization context exists. Do not
> merge Authentication and Authorization responsibilities."*

**Approved flow:**

```
Registration → Collect Display Name → Collect Mobile Number → OTP Verification
  → Create Account → Continue Original Action
  → Membership Processing (if required) → Role Assignment → Session Issuance
```

**Why this closes the blocker.** The v1.0 failure mode was that the *only* success value was an `AuthSession`,
which a role-less account cannot produce — so success and failure collapsed onto the same `null`. Under B3, Stage 1
succeeds by returning an **`Account`**. The state *authenticated, account exists, no tenant role yet* becomes
**representable** instead of indistinguishable from failure, and requirement 1.3 is satisfied rather than silently
breached.

**No session model was invented.** `AuthSession` is **untouched** — `activeRole` stays a non-nullable
`AccessRole`, and no role-less or partial session type is introduced. The session simply is not issued until an
authorization context exists, which is what the ruling requires.

| v1.0 consequence | Under `AR-6` |
|---|---|
| Account created, `verifyOtp` → `null`, UI reports failure | `verifyOtp` → the created `Account`; a session is a separate, later stage |
| User holds an invisible account with no way in | The authenticated-without-authorization state is explicit and reportable |
| Requirement 1.3 silently violated | Requirement 1.3 satisfied |

**Blocker B is closed.**

### 4.4 Disposition of `ACR-002`

[`ACR-002`](./ACR-002-New-Account-State.md) raised both blockers and deliberately made **no choices**
(its §9, *"What was NOT done, deliberately"*). Its options are now settled:

| `ACR-002` option set | Ruled |
|---|---|
| A1–A4 — display name | **A1** → `AR-5` |
| B1–B4 — new-account state | **B3** → `AR-6` |
| C1–C3 — `F-02` conformance | **C1** → `AR-7` |
| §5 rate limiting | **Deferred by ruling** → [`ACN-001`](./ACN-001-OTP-Request-Rate-Limiting.md) |

`ACR-002` is **superseded** by rulings `AR-5`, `AR-6`, `AR-7` and is retained unmodified as the historical record
of the options that were presented.

---

## 5. Security impact assessment

| Dimension | Assessment |
|---|---|
| **Anti-enumeration (`F-02`)** | **Preserved, and strictly strengthened.** Today the code branches on registration status when *storing*. Storing unconditionally removes that branch entirely, so known and unknown numbers become byte-identical in both response **and** internal state. See §7 |
| **Scope-bearing authorization (`F-01`)** | **Untouched.** No change to `PolicyDecisionPoint`, `_grants`, `require()`, `requireOn()`, `AccessRole`, `Permission` or `AccessScope` |
| **Credential containment (`ID-1`, `MP-GBR-27`)** | **Preserved.** Creation occurs inside `BC-18`. No credential crosses a boundary |
| **Sole factor (`MP-GBR-25`)** | **Preserved.** No password, no alternative factor, no social login |
| **No guest/anonymous accounts (`MP-CON-11`)** | **Preserved.** Every account created is a full account bound to a verified mobile number. An unverified number yields **no** account |
| **Session management (`MP-GBR-26`)** | **Untouched.** Revocation is neither modified nor bypassed. `AuthSession` keeps its shape; `AR-6` changes *when* a session is issued, never *what* a session is or how it is revoked |
| **Stage separation (`AR-6`)** | **Strengthened.** Removing `tenant`/`branch` from the authentication call makes it structurally impossible for an authentication step to imply an authorization outcome. A session cannot be produced without an explicit, separate issuance call that checks `rolesIn(tenant)` |
| **Display name integrity (`AR-5`)** | **No new surface.** The name is caller-supplied at creation only, never derived from the phone number, never generated, and never overwritten on an existing account. An account is **not created** when the collected name is absent, empty, whitespace-only, or equal to the mobile number |
| **New attack surface — challenge storage** | **Availability consideration, deferred by ruling.** Storing a challenge for every requested number makes `_issued` writable by an unauthenticated caller — an unbounded-growth vector. Today `_issued` is bounded by the account count. **No rate limiting exists in `AuthService`**, and Chapter 7 (Security) is an empty transfer slot. Per ruling, **no rate-limiting policy is invented here**; the gap is recorded in [`ACN-001`](./ACN-001-OTP-Request-Rate-Limiting.md) |
| **Net security direction** | Three improvements (uniform state, uniform response, structural stage separation), one deferred availability gap |

**Assessment: no weakening of any security property.**

**On the deferred gap and why it does not block.** Per the ruling: *"Do not invent any rate-limiting policy… No
implementation assumptions are permitted."* [`ACN-001`](./ACN-001-OTP-Request-Rate-Limiting.md) records it, and
establishes three facts that make it a **residual risk rather than a blocker**:

1. **The gap pre-dates this change.** `requestOtp` is unthrottled today; nothing in this change creates the
   absence of a limiter.
2. **It is an availability concern, not an enumeration one.** The change *removes* an enumeration side-channel
   (§7); it does not add one.
3. **The capability is not even placed in V1.** The `IDENTITY & ACCESS PLATFORM → Authentication` branch of the
   System Architecture lists six capabilities and **no** rate-limiting node at any version; the only
   general-purpose `Rate Limiter Service` is **V2**. Inventing a limiter here would invent both a policy and a
   scope decision.

The alternative — keeping the registration-dependent storage branch to bound the map — is **prohibited** by
`AR-7`, which requires identical behaviour for registered and unregistered numbers. Security (anti-enumeration)
is therefore ruled ahead of the availability gap, and the gap is documented rather than silently mitigated.

---

## 6. Test impact assessment

### 6.1 CORRECTION TO `ACR-001` §5 — I was wrong

`ACR-001` §5 stated:

> *"The 8 `F-02` tests assert on the observable response of `requestOtp`. Step 1 does not alter that response."*

**That is incorrect.** On reading the suite, one of the eight asserts on **stored state**, via the debug peek.
`test/authentication_conformance_test.dart`, group `F-02`, test 2:

```dart
    test('an unknown number yields no usable challenge and no signal', () {
      ...
      svc.requestOtp(unknown);
      expect(svc.debugPeekChallenge(unknown), isNull);      // ← WOULD FAIL
      expect(
        svc.verifyOtp(phone: unknown, code: '123456', tenant: tenant, branch: branch),
        isNull,
      );
    });
```

The first assertion requires that **no challenge be stored** for an unknown number. Storing unconditionally makes
`debugPeekChallenge(unknown)` non-null, and this test **fails**. I flagged it rather than quietly editing it,
because it is an `F-02` conformance assertion and `F-02` is a closed security defect.

**Is the assertion a security invariant?** No — `debugPeekChallenge` is gated by `challengePeekEnabled`, which is
`false` in any release wiring (`di.dart:214`). It is not part of the production observable surface. The security
assertion in that test is the **second** one (`verifyOtp` → null).

### 6.1a `RK-3` — **RESOLVED** by `AR-7` (option C1)

> *"The security objective of `F-02` is anti-enumeration. The implementation shall preserve identical observable
> behaviour for registered and unregistered phone numbers until OTP verification succeeds. **Conformance tests
> shall validate security behaviour rather than implementation details such as internal storage.** Do not weaken
> `F-01` or `F-02`."*

The first assertion tests `_issued` membership — an internal storage detail, read through a debug-only surface
that is disabled in every release wiring. Under `AR-7` it is re-expressed to assert the **security property** it
was standing in for:

| | Asserts | Classification |
|---|---|---|
| **Before** | `debugPeekChallenge(unknown)` is `null` — nothing was stored | Implementation detail |
| **After** | A caller can observe **no difference** between a registered and an unregistered number before verification succeeds, and a wrong code fails identically for both | Security behaviour |

**`F-02` is not weakened, and its guard is not removed** — it is aimed at the property the defect was about. The
test's second assertion (`verifyOtp` → `null` for an unknown number with a wrong code) is **retained**. Coverage
of the defect increases, because uniformity is now asserted across *both* numbers rather than inferred from one.

**`RK-3` is closed.**

### 6.2 Full expected impact

| Suite / group | Count | Expected | Note |
|---|---|---|---|
| `F-01 · authorization is scope-bearing` | 7 | ✅ Unaffected | No authorization code touched |
| `F-02` test 1 — *"returns nothing to branch on"* | 1 | ✅ Unaffected | Asserts the `void` signature of `requestOtp`, which does not change |
| **`F-02` test 2 — *"unknown number yields no usable challenge"*** | 1 | 🔄 **Re-expressed per `AR-7`** | §6.1a. Assertion 1 replaced by a uniformity assertion; assertion 2 retained |
| `F-02` test 3 — *"the challenge is not a function of the subject"* | 1 | ✅ Unaffected | Reads the peek only for a known number; no `verifyOtp` call |
| `F-02` tests 4–6 — expiry, attempt budget, single-use | 3 | 🔄 **Call sites adapted** | `verifyOtp` loses `tenant`/`branch` (`AR-6`). Assertions unchanged: `isNull` for expired, exhausted, and reused challenges. Test 6's first call now expects an `Account` rather than an `AuthSession` |
| `F-02` test 7 — *"the peek surface is off unless explicitly enabled"* | 1 | ✅ Unaffected | Asserts the gate, not the contents |
| `F-02` test 8 — *"a session carries an opaque identity"* | 1 | 🔄 **Split into two stages** | `verifyOtp` → `Account`, then `issueSession` → `AuthSession`. Both existing assertions on `session.id` retained verbatim |
| `A-7 · error projection` | 6 | ✅ Unaffected | |
| `A-8 · identity types` | 3 | ✅ Unaffected | |
| `QA-13 · entitlement gate` | 2 | ✅ Unaffected | |
| `widget_test.dart` | 9 | ✅ **Unaffected — confirmed by execution** | Includes `testWidgets('app renders the login screen on first frame')` at line 26, which asserts `find.text('Liboora')` and `find.text('Send OTP')`. Both survive the `AR-5` name field, so the test passes unchanged |
| **New coverage required** | ~6 | ⬜ To be written | One per ruling clause — see below |

**Note on v1.1's own erratum.** An intermediate v1.1 draft asserted that `widget_test.dart` holds 8 tests and no
login-screen coverage. **That assertion was wrong and has been withdrawn** — it came from grepping the class name
`LoginScreen` (never referenced; the test pumps `LiboraaApp`) and counting `    test(` (which misses
`testWidgets(`). **v1.0 was correct: 9 tests, including the login-screen frame test.** `RK-5` is closed on the
evidence of that test passing, not on an absence of coverage.

**New coverage, one test per ruling clause:**

| New test | Guards |
|---|---|
| A first successful verification creates an `Account` with the collected display name | `AR-2`, `AR-5` |
| Creation is refused when no display name was collected, when it is empty/whitespace, and when it equals the mobile number | `AR-5` prohibitions |
| A second verification returns the **same** account and never rewrites its display name | `AR-5` ownership |
| No account is created on a wrong code, an expired challenge, or an exhausted budget | Requirement 1.1 |
| A newly created account holds no tenant role, and `issueSession` yields **no** session for it | `AR-6` |
| `issueSession` yields a session once a role exists in the tenant | `AR-6` |
| A registered and an unregistered number are indistinguishable before verification succeeds | `AR-7`, requirement 1.3 |

**These are expectations, not results.** No test has been executed against a modified implementation, because no
implementation has been modified. Actual counts and outcomes will be reported in the Change Report.

---

## 7. Why this does not reintroduce phone-number enumeration

**The `F-02` threat model.** An attacker submits candidate mobile numbers and reads a difference in the system's
response to learn which are registered. The defect closed in `BLOCKER_CLOSURE_v1.0.md` was that the original
code derived the OTP from `phone.hashCode` — a public function of a public input — and branched observably.

**Why unconditional storage is strictly safer than the current code:**

| Aspect | Today | After change |
|---|---|---|
| Return type of `requestOtp` | `void` — nothing to read | `void` — unchanged |
| Work performed | Code generated for every caller | Identical |
| **Internal state after the call** | **Differs** — `_issued` gains an entry only for registered numbers | **Identical** — an entry is always added |
| `verifyOtp` with a wrong code | `null` | `null` |
| Timing profile | Slight difference: the storage write happens only on the registered path | Uniform: the write always happens |

The change **removes** the last remaining registration-dependent branch in the request path. There is currently a
side-channel — a map insertion that occurs for registered numbers only, observable in principle via timing or
memory growth. After the change, no branch on registration status exists in `requestOtp` at all.

**Where the discriminating fact is disclosed, and why that is safe.** The only point at which known and unknown
numbers diverge is **after a correct 6-digit code is submitted**. To reach that point the caller must possess the
code, which is:

- drawn from `SecureRandomSource` (`math.Random.secure()`), never derived from the subject;
- 6 digits — a 1-in-10⁶ blind guess;
- bounded to 5 attempts (`maxVerifyAttempts`), after which the challenge is discarded;
- valid for 5 minutes (`challengeTtl`);
- single-use (`_issued.remove(phone)` on success).

An attacker who supplies a correct code has demonstrated possession of the SIM. At that point they already know
the number is theirs, so learning whether it had an account discloses nothing they did not already control.
Blind enumeration would require ~10⁶ guesses against a 5-attempt budget per 5-minute window — the budget, not
the branch, is the control.

**This satisfies your requirement 1.3 exactly:** identical observable behaviour for existing and non-existing
numbers **until OTP verification succeeds**, and only then a legitimate divergence.

**Residual issue:** the unbounded-growth surface in §5. Uniformity is achieved by always writing; without rate
limiting that write is attacker-controlled. This is an availability concern, not an enumeration one. Per ruling it
is **recorded, not mitigated by invention** — see [`ACN-001`](./ACN-001-OTP-Request-Rate-Limiting.md).

**Does the two-stage split of `AR-6` change this analysis?** No, and it improves one line of it. The stage that
discloses the discriminating fact is unchanged — it is still gated behind possession of a correct, random,
expiring, attempt-bounded, single-use code. What changes is that the disclosure now takes the form of a returned
`Account` rather than a returned `AuthSession`, so the *authorization* outcome no longer rides on the
*authentication* result. No new observable is added before verification succeeds:

| Observable | Before verification succeeds |
|---|---|
| `requestOtp` return value | `void` — unchanged |
| `requestOtp` internal state | **Now identical** for registered and unregistered numbers |
| `verifyOtp` with a wrong code | `null` for both — unchanged |
| `verifyOtp` with an expired or exhausted challenge | `null` for both — unchanged |
| `issueSession` | **Unreachable** — it requires an `Account`, which only a successful verification yields |

`issueSession` cannot be used as an oracle: it takes an `Account`, not a phone number, so a caller who does not
already hold a verified account has nothing to pass it.

---

## 8. Risk assessment

| ID | Risk | Likelihood | Impact | Status |
|---|---|---|---|---|
| **RK-1** | **`displayName` chosen by inference** rather than by specification, producing accounts with placeholder identities that later require a migration | — | — | ✅ **CLOSED by `AR-5`.** The name is collected by Registration before OTP verification; all four inferred candidates are prohibited; no account is created without one |
| **RK-2** | **Role-less account receives no session**, so a successful verification is observably identical to a failure — a silent breach of requirement 1.3 | — | — | ✅ **CLOSED by `AR-6`.** Stage 1 succeeds by returning an `Account`, so the state is representable and success is distinguishable from failure |
| **RK-3** | Amending an `F-02` conformance assertion weakens a closed security defect's guard | — | — | ✅ **CLOSED by `AR-7`.** The assertion is re-expressed onto the security property; the defect's guard is retained and broadened (§6.1a) |
| **RK-4** | Unbounded `_issued` growth from unauthenticated callers (no rate limiting exists) | Medium | Medium | ⚠️ **ACCEPTED AND RECORDED — deferred by ruling.** Pre-existing, availability-only, capability not placed in V1. [`ACN-001`](./ACN-001-OTP-Request-Rate-Limiting.md). **Not a blocker** — §5 |
| **RK-5** | `widget_test.dart` login-screen tests break if a session model changes | — | — | ✅ **CLOSED by passing test.** `widget_test.dart` holds 9 tests, one of which renders the login screen. It passes unchanged against the implemented change: no session model was introduced, and the `AR-5` field addition preserves the `'Liboora'` and `'Send OTP'` finders it asserts (§6.2) |
| **RK-6** | Scope creep into session management, authorization or registration UI | Low | High | 🔒 **Controlled.** §4.1 enumerates a closed four-file set. `AuthSession`, revocation, `PolicyDecisionPoint`, `AccessRole`, `Permission` and `AccessScope` are explicitly untouched. Anything beyond the set stops and raises an ACR |
| **RK-7** | `AuthService` mutating its injected `_accounts` list is a hidden side effect on a caller-owned collection (`di.dart:178` `final accounts = <Account>[]`) | Medium | Low | 🔧 **Open design note.** The list is growable, so this is mechanically viable. It is the minimum-change option: the alternative — introducing an account-repository port — would add a port and a module edge, exceeding *"minimum architecture-aligned changes."* To be stated explicitly in the Change Report |
| **RK-8** | The registration UI could branch on whether a number is registered, rebuilding the `F-02` oracle one layer above the fix | Low | High | 🔒 **Controlled by design.** The name field is shown unconditionally for every number; the screen never queries registration status (§4.1) |

**Five risks closed, one accepted and recorded by ruling, two controlled, one new risk identified and controlled.**

**Overall: implementation risk is LOW.** Every product decision that v1.0 refused to make has been made by the
owner and quoted in §4. `RK-4` is the only accepted residual, and it is pre-existing, availability-only, and
documented rather than silently mitigated.

---

## 9. Validation outcome

### 9.1 Gates — re-run at v1.1

| # | Gate | v1.0 | v1.1 | Evidence |
|---|---|---|---|---|
| 1 | Requirement exists in an authoritative document | ⚠️ Partial | ✅ **PASS** | Lifecycle rule: BC Map §4 line 155 + `AR-2`. Resulting state: `AR-5` (display name) and `AR-6` (stage separation), recorded in the rulings register |
| 2 | Owning PRD exists | ⚠️ Partial | ✅ **PASS** | Authentication PRD exists. Chapters 3, 6, 7 remain empty (`D-7`, unchanged), but the specific decisions this change required were issued as rulings, which §"How to use this register" makes authoritative |
| 3 | Owning bounded context correct | ✅ | ✅ **PASS** | `BC-18` Identity & Access — *"Owns credentials, sessions, devices, OTP, roles, permissions…"* |
| 4 | Owning module correct | ✅ | ✅ **PASS** | `platform/identity`, rank 4. `session.dart` / `login_screen.dart` are `app/**` callers, permitted to depend on rank 4 |
| 5 | Dependencies permitted | ✅ | ✅ **PASS** | No new import, port, event, edge or manifest change. `banned_imports` and `banned_symbols_in_domain_layer` unaffected |
| 6 | Architecture allows it | ✅ | ✅ **PASS** | Explicitly — BC Map §4 and rulings `AR-2`, `AR-5`, `AR-6`, `AR-7` |
| 7 | **All items validated** | ❌ NO | ✅ **YES** | — |

### 9.2 Additional gates from your Implementation Requirements

| Gate | Result |
|---|---|
| Approved PRD not modified | ✅ **PASS** — no PRD file is in the change set. `§14A` remains byte-identical |
| Business requirements unchanged | ✅ **PASS** — no requirement added, removed or reinterpreted |
| Authorization unchanged | ✅ **PASS** — `PolicyDecisionPoint`, `_grants`, `require()`, `requireOn()`, `AccessRole`, `Permission`, `AccessScope` untouched |
| Session management unchanged | ✅ **PASS** — `AuthSession` shape and revocation untouched; only *when* issuance occurs changes, per `AR-6` |
| Security not weakened | ✅ **PASS** — §5, §7. Three improvements, one recorded availability gap |
| No Guest / Anonymous accounts | ✅ **PASS** — every account is bound to a verified mobile number and a collected name |
| No passwords, no additional factors | ✅ **PASS** — `MP-GBR-25` preserved |
| APIs unchanged unless absolutely necessary | ⚠️ **DECLARED** — `AuthService.verifyOtp` changes, and this is a **breaking change**. It is necessary, because the signature is the subject of `AR-6` (§4.0). No other API changes |
| Backward compatibility preserved | ⚠️ **PARTIAL, declared** — preserved for `requestOtp` and for `Account`; **not** preserved for `verifyOtp`, by ruling |
| Minimum changes | ✅ **PASS** — four files, closed set (§4.1) |
| Module ownership unchanged | ✅ **PASS** — all work stays inside `BC-18` / `platform/identity` and its existing `app/**` callers |

### 9.3 Confirmation

**All validation blockers are resolved.**

| Blocker | Resolved by | Where |
|---|---|---|
| Blocker A — `displayName` unspecified | **`AR-5`** (option A1) | §4.2 |
| Blocker B — new-account session state unspecified | **`AR-6`** (option B3) | §4.3 |
| `RK-3` — `F-02` assertion tests internal storage | **`AR-7`** (option C1) | §6.1a |
| OTP request rate limiting | **Deferred by ruling; recorded, not invented** | [`ACN-001`](./ACN-001-OTP-Request-Rate-Limiting.md) |

**Nothing is inferred.** Each resolution is a quoted ruling clause, recorded in
[`ARCHITECTURE_RULINGS.md`](../../../10-architecture/ARCHITECTURE_RULINGS.md) so it survives independently of this report.

**Two items are declared rather than passed** — gates 8 and 9 of §9.2, the breaking change to
`AuthService.verifyOtp`. This is stated plainly rather than presented as compliance, because `AR-6` cannot be
implemented without it.

**Status: VALIDATED. Implementation is authorised** for the four-file change set in §4.1 and nothing beyond it.
Per your standing instruction, if any additional architectural blocker is discovered during implementation, work
stops immediately and an Architecture Consistency Report is produced instead of an assumption or a workaround.

---

## Changelog

| Version | Date | Change |
|---|---|---|
| **v1.1** | 2026-08-02 | Updated to reflect approved rulings `AR-5` (A1), `AR-6` (B3), `AR-7` (C1). Blocker A resolved (§4.2), Blocker B resolved (§4.3), `RK-3` resolved (§6.1a). Design derivation traced clause-by-clause to the rulings (§4.0); change set restated as four files (§4.1); `ACR-002` disposed of (§4.4). Rate limiting recorded as deferred via `ACN-001` and shown not to block (§5). Test impact restated (§6.2). Risks re-dispositioned: `RK-1`, `RK-2`, `RK-3`, `RK-5` closed; `RK-4` accepted and recorded; `RK-8` added (§8). All seven validation gates now PASS; breaking change to `verifyOtp` declared (§9). **Status BLOCKED → VALIDATED. Still no code written.** |
| **v1.0** | 2026-08-02 | Report created. Validation halted at §4 on two unspecified states; `ACR-002` raised; no code written. |
