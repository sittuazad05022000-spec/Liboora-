# ACR-002 — Architecture Consistency Report
## The state of a newly created Account is unspecified

| Field | Value |
|---|---|
| **Report ID** | `ACR-002` |
| **Raised by** | `IVR-001` §4.2, §4.3 — during validation of approved `ACR-001` |
| **Raised under** | Your instruction: *"If any unexpected architectural conflict is discovered, stop immediately and produce an Architecture Consistency Report instead of making assumptions or implementing a workaround."* |
| **Subject** | `BC-18` Identity & Access — `Account` construction and session issuance for a first-time user |
| **Status** | **AWAITING RULING — IMPLEMENTATION HALTED. NO PRODUCTION CODE CHANGED.** |
| **Date** | 2026-08-02 |
| **Code state** | commit `17d81af`, working tree clean, 35/35 tests passing, `flutter analyze` clean |

> `ACR-001` is approved and its **principle is sound**. This report does not dispute it.
>
> It reports that executing it requires two pieces of information that **do not exist in any authoritative
> document**: what a new `Account` is named, and what session — if any — an account with no tenant role holds.
> Both would have to be invented. Per your constraints, they are not.

---

## 1. Conflict

The approved architecture states that an `Account` is *"Created on first successful OTP."* The `Account`
aggregate as modelled **cannot be constructed** from the information available at that moment, and the resulting
object **cannot produce a session**.

Two distinct gaps:

- **Blocker A** — `Account.displayName` is a required, non-nullable `String`. A first-time user has supplied only
  a mobile number. No document says what the name should be.
- **Blocker B** — a new `Account` holds no role in any tenant. `AuthSession.activeRole` is a required,
  non-nullable `AccessRole`. No document says what session such an account receives, or whether it receives one.

Both are **specification gaps, not design errors.** The chapters that would close them are empty.

---

## 2. Supporting documents

| Source | Statement | Bearing |
|---|---|---|
| `LIBOORA_BOUNDED_CONTEXT_MAP.md` §4 line 155 | *"**Account** · `AccountId` · BC-18 · Global, cross-tenant · **Created on first successful OTP.** … Holds *credentials only*."* | Establishes the trigger. Says nothing about name or session |
| `LIBOORA_BOUNDED_CONTEXT_MAP.md` §11 line 473 | `BC-18` *"**Hybrid.** `Account` is global; role assignments are tenant-scoped. `AccessPolicy` is always evaluated with a tenant in scope"* | Confirms a new global account legitimately holds **no** tenant role |
| `ARCHITECTURE_RULINGS.md` `AR-2` | *"Account creation on the first successful OTP verification is explicitly approved."* | The approved rule |
| Library PRD §14A.7 | *Join Library → Authentication → Registration (if required) → **Membership Processing** → Library Member* | Role acquisition occurs **after** Authentication, confirming the role-less interval is by design |
| `MASTER_PRD.md` line 512 `MP-CON-11` | *"no demo or guest accounts in any release build"* | Constrains any answer: a role-less account must **not** become a guest account |
| **`03-Registration.md`** | **1,284 bytes, 29 lines, 0 body characters** — empty transfer slot | Would specify Blocker A. **Absent** |
| **`06-Sessions.md`** | **1,280 bytes, 29 lines, 0 body characters** — empty transfer slot | Would specify Blocker B. **Absent** |
| **`07-Security.md`** | **1,280 bytes, 29 lines, 0 body characters** — empty transfer slot | Would specify the rate limiting in §5. **Absent** |
| Defect `D-7` | `FINAL_VALIDATION_REPORT.md` §4 — **OPEN** | All eleven chapters are uncommitted transfer slots |

---

## 3. Exact locations

### Blocker A — `lib/platform/identity/identity.dart` lines 26–34

```dart
final class Account {
  const Account({
    required this.id,
    required this.phone,
    required this.displayName,   // ← required, non-nullable String
    required this.roles,
    this.personId,
  });
```

At OTP verification the system holds `phone` and can mint an `AccountId`. It does **not** hold a name.

### Blocker B — `lib/platform/identity/identity.dart` lines 45, 48–56, 350–362

```dart
  Set<AccessRole> rolesIn(TenantId tenant) => roles[tenant.value] ?? const {};
```

```dart
final class AuthSession {
  const AuthSession({
    ...
    required this.activeRole,    // ← required, non-nullable AccessRole
```

```dart
    final account = _accountForPhone(phone);
    if (account == null) return null;
    final roles = account.rolesIn(tenant);
    if (roles.isEmpty) return null;      // ← a newly created account ALWAYS returns here

    return AuthSession(
      ...
      activeRole: roles.first,
```

A new `Account` has `roles == {}`, so `rolesIn(anyTenant)` returns `const {}`, so `verifyOtp` returns `null`.

---

## 4. Impact

| If implemented without a ruling | Consequence |
|---|---|
| A `displayName` is inferred (empty string / phone number / placeholder) | Accounts are created with a fabricated identity attribute. Correcting it later is a data migration across every account, plus a UI change. **A product decision would have been made by a developer.** |
| `verifyOtp` returns `null` for the new account | The account is created but the caller sees **failure**. A successful verification becomes observably identical to a failed one — a **silent breach of your requirement 1.3** and of `F-02`'s uniformity intent in the opposite direction |
| The user retries | Each attempt creates nothing new (the account now exists) but still fails. The user is permanently locked out of an account that exists. **Worse than today's clean rejection** |
| A session is invented for a role-less account | Risks creating exactly what `MP-CON-11` forbids — an account that can be signed into with no tenant, no role and no membership is functionally an anonymous/guest session |

**Net: implementing without a ruling converts a clean, honest failure into a silent, unrecoverable one.**

---

## 5. Secondary finding — unbounded challenge storage

Not a blocker to the ruling, but it must be specified before code ships.

Making challenge storage unconditional (the core of `ACR-001` §5 step 1) means an **unauthenticated caller can
insert into `_issued` at will.** Today that map is bounded by the number of registered accounts; afterwards it is
bounded only by attacker effort.

`AuthService` contains **no rate limiting** — verified: the only budget is `maxVerifyAttempts = 5`, which bounds
*verification* attempts against an existing challenge, not *issuance*. Chapter 7 (Security), which would specify
issuance throttling, is an empty transfer slot.

This is an availability concern, not an enumeration one. It is recorded here so it is not discovered after
deployment.

---

## 6. Recommended resolution — OPTIONS ONLY, NOT A CHOICE

I am not selecting among these. Each is a product decision. Presented so a ruling can be a single line.

### Blocker A — `displayName` for a new account

| Option | Behaviour | Consequence |
|---|---|---|
| **A1** | Capture the name **before** OTP is requested (name + mobile on one screen) | Matches §14A.7's *"Registration (if required)"* most literally. Adds a UI field. No placeholder data ever exists |
| **A2** | Capture the name **after** successful OTP, as a mandatory completion step | Account exists briefly without a name → `displayName` must become nullable, an **API change** to the `Account` aggregate |
| **A3** | Default `displayName` to the mobile number, editable later | Smallest change. Creates a real identity attribute from a credential — arguably contrary to *"Holds *credentials only*"* and to `AR-4`-style separation of contact data from credentials |
| **A4** | Default to an empty string | Smallest change; produces accounts with no display identity. Not recommended |

### Blocker B — session for a role-less account

| Option | Behaviour | Consequence |
|---|---|---|
| **B1** | `verifyOtp` keeps returning `null` when there is no tenant role; the caller treats *"account created, no membership"* as a distinct outcome via a separate query | No change to `AuthSession`. Requires the caller to distinguish two cases — likely an **API change** to expose the outcome |
| **B2** | Introduce a **tenant-less authenticated session** — `AuthSession` with nullable `tenantId`/`activeRole`, usable only to complete enrollment | Represents the real state honestly. **Changes the `AuthSession` aggregate**, touches session management, and needs explicit confirmation it is not a guest session under `MP-CON-11` |
| **B3** | Split verification from session issuance: `verifyOtp` returns a verification outcome; session issuance becomes a separate tenant-scoped operation | Cleanest architecturally, and matches §14A.7's staged flow. **Largest API change** — conflicts with your *"Do not change APIs unless absolutely necessary"* |
| **B4** | Defer: create the account on successful OTP, return `null`, and require the Membership/Enrollment step to assign a role before any sign-in succeeds | Smallest code change, but see §4 — the user is locked out until an out-of-band role assignment occurs. Only viable if reception-led enrollment is the intended V1 path |

**Observation, offered as analysis rather than as a decision:** options **A1** and **B4** together are the
smallest possible change set and require no API change, but B4's lock-out only makes sense if a staff member
assigns the role. Options **A1 + B3** match Library PRD §14A.7's staged flow most faithfully but change the
`AuthService` API. The tension between *"minimum possible implementation changes"* and *"align with the approved
architecture"* resolves differently depending on whether V1's join path is **self-service** or
**reception-mediated** — and that is the underlying product question `03-Registration.md` was meant to answer.

### Item `RK-3` — the `F-02` conformance assertion

`test/authentication_conformance_test.dart`, group `F-02`, test 2, first assertion
`expect(svc.debugPeekChallenge(unknown), isNull)` becomes false under unconditional storage.

| Option | Behaviour |
|---|---|
| **C1** | Amend the assertion to assert **uniformity** instead of absence — e.g. that a challenge exists for both known and unknown numbers, which is the stronger `F-02` guarantee |
| **C2** | Remove the assertion, retaining the test's second (security-bearing) assertion |
| **C3** | Refuse the change; keep conditional storage and abandon `ACR-001` |

`debugPeekChallenge` is gated by `challengePeekEnabled`, `false` in every release wiring (`di.dart:214`), so it is
not a production surface. **C1 appears to strengthen the guarantee rather than weaken it, but amending an `F-02`
conformance assertion requires your explicit approval.**

---

## 7. Approval gate

Implementation remains halted until:

- [ ] **Blocker A** ruled — `A1` / `A2` / `A3` / `A4`, or an alternative
- [ ] **Blocker B** ruled — `B1` / `B2` / `B3` / `B4`, or an alternative
- [ ] **`RK-3`** ruled — `C1` / `C2` / `C3`
- [ ] **§5 rate limiting** — specify, or explicitly accept as a known gap for V1

On ruling, `IVR-001` will be revised to a validated state and re-submitted for approval before any code is
written. A **Change Report** will follow implementation.

---

## 8. Files that would change on approval — none touched yet

| File | Anticipated change | Current state |
|---|---|---|
| `lib/platform/identity/identity.dart` | `requestOtp` storage; account creation in `verifyOtp`; possibly `Account`/`AuthSession` shape depending on the A/B rulings | **Unmodified** |
| `test/authentication_conformance_test.dart` | One amended assertion, ~4 new tests | **Unmodified** |
| `docs/prd/authentication/03-Registration.md` | Chapter 3 content (`D-7`) | **Unmodified** — empty |
| `docs/prd/authentication/06-Sessions.md` | Chapter 6 content (`D-7`) | **Unmodified** — empty |

**Verified:** `git status --short` clean at `17d81af`; no file under `lib/` or `test/` appears in this report's
commit.

---

## 9. What was NOT done, deliberately

- No `displayName` default chosen
- No session model invented
- No conformance assertion edited
- No rate-limiting policy invented
- No PRD modified
- No API changed
- **No production code written**
