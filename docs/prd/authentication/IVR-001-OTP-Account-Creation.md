# IVR-001 — Implementation Validation Report
## Account creation on first successful OTP verification

| Field | Value |
|---|---|
| **Report ID** | `IVR-001` |
| **Implements** | `ACR-001` (approved) · ruling `AR-2` |
| **Status** | **COMPLETE — BLOCKED. Implementation must NOT proceed.** |
| **Blocked by** | [`ACR-002`](./ACR-002-New-Account-State.md) — two unspecified states discovered during validation |
| **Date** | 2026-08-02 |
| **Code state** | commit `17d81af`, working tree clean, `flutter analyze` → `No issues found!`, 35/35 tests passing |
| **Code written** | **NONE.** No file under `lib/` or `test/` has been modified |

> **Outcome of validation: STOP.**
>
> The guardrails require: *"If any item cannot be validated, STOP."* Your approval added:
> *"If any unexpected architectural conflict is discovered, stop immediately and produce an Architecture
> Consistency Report instead of making assumptions or implementing a workaround."*
>
> Validation reached section 4 and found that **two states required by the change are unspecified in every
> authoritative document.** They cannot be chosen without inventing requirements. `ACR-002` documents them.
> This report is complete, and it concludes that implementation is blocked.

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

**Requirement 1.3 is the binding constraint** and is the reason the change is small. It also, as §4 shows, is
what exposes the two unspecified states: *"until OTP verification succeeds"* implies a defined behaviour **at
and after** the moment it succeeds for a number that has no account. That behaviour is not written down anywhere.

---

## 2. Exact architecture references

| Reference | Location | Statement |
|---|---|---|
| **Account lifecycle** | `LIBOORA_BOUNDED_CONTEXT_MAP.md` §4, line 155 | *"**Account** · `AccountId` · BC-18 Identity & Access · Global, cross-tenant · **Created on first successful OTP.** Destroyed on account deletion. Holds *credentials only*."* |
| **BC-18 ownership** | `LIBOORA_BOUNDED_CONTEXT_MAP.md` line 119 | `BC-18` *"Owns credentials, sessions, devices, OTP, roles, permissions, policy decisions, consent"* |
| **BC-18 tenancy model** | `LIBOORA_BOUNDED_CONTEXT_MAP.md` §11, line 473 | *"**Hybrid.** `Account` is global; role assignments are tenant-scoped. `AccessPolicy` is always evaluated with a tenant in scope"* |
| **Identity separation** | `LIBOORA_BOUNDED_CONTEXT_MAP.md` `ID-1` | *"No context outside BC-18 may store a password, OTP, session or credential."* |
| **Ruling** | `ARCHITECTURE_RULINGS.md` `AR-2` | *"Account creation on the first successful OTP verification is explicitly approved."* |
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
| **Chapter 3 — Registration** | `docs/prd/authentication/03-Registration.md` | **1,284 bytes, 29 lines, 0 body characters.** Empty transfer slot. Defect `D-7` OPEN | ❌ **Requirement unspecified** |
| **Chapter 6 — Sessions** | `docs/prd/authentication/06-Sessions.md` | **1,280 bytes, 29 lines, 0 body characters.** Empty transfer slot. Defect `D-7` OPEN | ❌ **Requirement unspecified** |

**This is where validation fails.** The two chapters that would specify what a newly created account looks like,
and what session it receives, are both empty.

---

## 4. Exact files that will change — AND WHY THIS IS BLOCKED

### 4.1 Intended change set (minimum)

| File | Intended change | Lines |
|---|---|---|
| `lib/platform/identity/identity.dart` | `AuthService.requestOtp` — store the challenge unconditionally; `AuthService.verifyOtp` — create an `Account` when verification succeeds and none exists | ~307–319, ~350–353 |
| `test/authentication_conformance_test.dart` | Amend one `F-02` assertion; add coverage for the creation path | see §6 |
| `docs/prd/authentication/03-Registration.md` | Chapter 3 content | requires content from you (`D-7`) |

No other file. **No change** to `AccessPolicy`, `PolicyDecisionPoint`, `AuthSession` revocation, `di.dart`,
`session.dart`, `login_screen.dart`, `seed.dart`, `pubspec.yaml`, or `tool/module_dependencies.yaml`.

### 4.2 Blocker A — `Account.displayName` is required and unknown at OTP time

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
supplied one.** Nothing in any authoritative document states what it should be. The candidate answers — empty
string, the phone number, a placeholder, or a name-capture step before or after OTP — are **four different
product decisions**, and Chapter 3 (Registration), which would settle it, is empty.

Choosing one would be inventing a requirement. **I will not choose.**

### 4.3 Blocker B — a new `Account` holds no tenant role, so no `AuthSession` can exist

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

The document that would specify this — Chapter 6, Sessions — is empty. **I will not invent a session model.**

→ Both blockers are documented in [`ACR-002`](./ACR-002-New-Account-State.md).

---

## 5. Security impact assessment

| Dimension | Assessment |
|---|---|
| **Anti-enumeration (`F-02`)** | **Preserved, and strictly strengthened.** Today the code branches on registration status when *storing*. Storing unconditionally removes that branch entirely, so known and unknown numbers become byte-identical in both response **and** internal state. See §7 |
| **Scope-bearing authorization (`F-01`)** | **Untouched.** No change to `PolicyDecisionPoint`, `_grants`, `require()`, `requireOn()`, `AccessRole`, `Permission` or `AccessScope` |
| **Credential containment (`ID-1`, `MP-GBR-27`)** | **Preserved.** Creation occurs inside `BC-18`. No credential crosses a boundary |
| **Sole factor (`MP-GBR-25`)** | **Preserved.** No password, no alternative factor, no social login |
| **No guest/anonymous accounts (`MP-CON-11`)** | **Preserved.** Every account created is a full account bound to a verified mobile number. An unverified number yields **no** account |
| **Session management (`MP-GBR-26`)** | **Untouched** — and this is precisely what Blocker B exposes as unspecified |
| **New attack surface — challenge storage** | **New consideration.** Storing a challenge for every requested number makes `_issued` writable by an unauthenticated caller, i.e. an unbounded-growth / memory-exhaustion vector. Today `_issued` is bounded by the account count. **No rate limiting exists in `AuthService`.** Mitigation is required but **not specified** in any document — Chapter 7 (Security) is also an empty transfer slot. Recorded in `ACR-002` §5 |
| **Net security direction** | Two improvements (uniform state, uniform response), one new surface requiring a specified mitigation |

**Assessment: no weakening, one new surface that must be specified before implementation.**

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
`debugPeekChallenge(unknown)` non-null, and this test **fails**. I am flagging it rather than quietly editing it,
because it is an `F-02` conformance assertion and `F-02` is a closed security defect.

**Is the assertion a security invariant?** No — `debugPeekChallenge` is gated by `challengePeekEnabled`, which is
`false` in any release wiring (`di.dart:214`). It is not part of the production observable surface. The security
assertion in that test is the **second** one (`verifyOtp` → null). But amending it still requires your approval.

### 6.2 Full expected impact

| Suite / group | Count | Expected | Note |
|---|---|---|---|
| `F-01 · authorization is scope-bearing` | 7 | ✅ Unaffected | No authorization code touched |
| `F-02` test 1 — *"returns nothing to branch on"* | 1 | ✅ Unaffected | Asserts the `void` signature |
| **`F-02` test 2 — *"unknown number yields no usable challenge"*** | 1 | ❌ **Assertion 1 fails; requires approved amendment** | §6.1 |
| `F-02` tests 3–8 — non-derivation, expiry, attempt budget, single-use | 6 | ✅ Expected to pass | All operate on a known number |
| `A-7 · error projection` | 6 | ✅ Unaffected | |
| `A-8 · identity types` | 3 | ✅ Unaffected | |
| `QA-13 · entitlement gate` | 2 | ✅ Unaffected | |
| `widget_test.dart` | 9 | ⚠️ **Unknown until Blocker B is resolved** | Includes *"app renders the login screen on first frame"*; the login path changes only if a session model for role-less accounts is introduced |
| **New coverage required** | ~4 | ⬜ To be written | Account created on first successful verify · not created on failed verify · not created on expired challenge · uniform state for known vs unknown before verification |

**Total today: 35 passing. Expected after change: 1 amended, ~4 added, remainder unchanged — contingent on
Blocker B.**

**These are expectations, not results.** No test has been executed against a modified implementation, because no
implementation has been modified.

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
limiting that write is attacker-controlled. This is a availability concern, not an enumeration one, but it must
be specified before implementation.

---

## 8. Risk assessment

| ID | Risk | Likelihood | Impact | Status |
|---|---|---|---|---|
| **RK-1** | **`displayName` chosen by inference** rather than by specification, producing accounts with placeholder identities that later require a migration | High if unblocked | High | **BLOCKING** — `ACR-002` Blocker A |
| **RK-2** | **Role-less account receives no session**, so a successful verification is observably identical to a failure — a silent breach of requirement 1.3 | Certain if unblocked | High | **BLOCKING** — `ACR-002` Blocker B |
| **RK-3** | Amending an `F-02` conformance assertion weakens a closed security defect's guard | Low — the assertion covers a debug-only surface | Medium | **Requires approval** — §6.1 |
| **RK-4** | Unbounded `_issued` growth from unauthenticated callers (no rate limiting exists) | Medium | Medium | **Requires specification** — §5. Chapter 7 empty |
| **RK-5** | `widget_test.dart` login-screen tests break if a session model changes | Unknown until `ACR-002` resolved | Low | Deferred |
| **RK-6** | Scope creep into session management, authorization or registration UI | Low | High | Controlled — §4.1 enumerates the file set; anything beyond it stops |
| **RK-7** | `AuthService` mutating its injected `_accounts` list is a hidden side effect on a caller-owned collection (`di.dart:178` `final accounts = <Account>[]`) | Medium | Low | Design note for implementation; growable list confirmed, so mechanically viable |

**Overall: implementation risk is LOW once `ACR-002` is ruled. Implementation risk while unruled is HIGH,
because two product decisions would be made by a developer rather than by the owner.**

---

## 9. Validation outcome

| Gate | Result |
|---|---|
| Requirement exists in an authoritative document | ⚠️ **Partial** — the *lifecycle rule* exists (Context Map §4, `AR-2`); the *resulting state* does not (Chapters 3 and 6 empty) |
| Owning PRD exists | ⚠️ Authentication PRD exists; the two relevant chapters are empty transfer slots (`D-7`) |
| Owning bounded context correct | ✅ `BC-18` Identity & Access |
| Owning module correct | ✅ `platform/identity`, rank 4 |
| Dependencies permitted | ✅ No new import, port, event or edge |
| Architecture allows it | ✅ Explicitly — Context Map §4 and ruling `AR-2` |
| **All items validated** | ❌ **NO** |

**Per the guardrails — *"If any validation fails, STOP"* — and per your instruction to raise an Architecture
Consistency Report on discovering a conflict: implementation is halted. No code written.**

**Required to unblock:** rulings on `ACR-002` Blocker A, Blocker B, and item `RK-3`.
