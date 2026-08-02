# CHANGE_REPORT-001 — Account creation on first successful OTP verification

| Field | Value |
|---|---|
| **Report ID** | `CHANGE_REPORT-001` |
| **Implements** | [`IVR-001`](./IVR-001-OTP-Account-Creation.md) v1.1 §4.1 (validated) |
| **Rulings** | `AR-2`, `AR-5` (option A1), `AR-6` (option B3), `AR-7` (option C1) |
| **Implementation commit** | `37a66ea` — *feat(auth): create Account on first successful OTP; split session issuance* |
| **Preceding documentation commit** | `8698550` |
| **Status** | **COMPLETE** |
| **Date** | 2026-08-02 |

---

## 1. Files modified

Four files, exactly the set validated in `IVR-001` §4.1. **381 insertions, 61 deletions.**

| File | +/− | Layer |
|---|---|---|
| `lib/platform/identity/identity.dart` | +73 | `platform/identity`, rank 4 |
| `lib/app/session.dart` | +59 | `app/**` |
| `lib/app/shell/login_screen.dart` | +33 | `app/**` |
| `test/authentication_conformance_test.dart` | +277 | `test` (non-runtime) |

**No other file was modified.** Verified mechanically at commit time.

---

## 2. Exact code paths changed

### 2.1 `AuthService.requestOtp` — unconditional challenge storage

The registration-dependent guard is **deleted**:

```dart
// REMOVED
if (_accountForPhone(phone) != null) {
  _issued[phone] = challenge;
}

// NOW
_issued[phone] = challenge;
```

Signature unchanged: `void requestOtp(String phone)`.

### 2.2 `AuthService.verifyOtp` — Stage 1, Authentication only

```dart
Account? verifyOtp({
  required String phone,
  required String code,
  String? displayName,
})
```

Sequence, unchanged up to the point of success: challenge lookup → expiry check → attempt-budget
increment and check → code comparison → single-use removal. After success:

1. If an account exists for the number, **return it unchanged.** No profile field is written.
2. Otherwise create one, using the display name Registration collected:
   - `final name = displayName?.trim() ?? '';`
   - `if (name.isEmpty || name == phone.trim()) return null;` — no account is created
   - `Account(id: AccountId(_ids.next('acc')), phone: phone, displayName: name, roles: const {})`
   - appended to `_accounts`, returned

### 2.3 `AuthService.issueSession` — Stage 2, new

```dart
AuthSession? issueSession({
  required Account account,
  required TenantId tenant,
  required BranchId branch,
})
```

Returns `null` while `account.rolesIn(tenant)` is empty. Otherwise constructs the **identical** `AuthSession` the
previous single-call implementation constructed — same id source, same fields, same clock.

### 2.4 `SessionController.verifyOtp` — two-stage caller

Calls Stage 1, then Stage 2. Three outcomes instead of two:

| Outcome | State | Returns |
|---|---|---|
| Stage 1 returns `null` | `_error` = code did not match | `false` |
| Stage 1 succeeds, Stage 2 returns `null` | `_verifiedAccount` set; `_error` = *"Number verified. This account is not a member of any library yet."* | `false` |
| Both succeed | `_session` set; tenant scope entered | `true` |

New members: `Account? _verifiedAccount`, `Account? get verifiedAccount`, `bool get awaitingAuthorization`.
`_verifiedAccount` is cleared on `requestOtp`, on a new `verifyOtp`, and on `signOut`.

### 2.5 `login_screen.dart` — display name collected before OTP verification

`_name` controller added and disposed. Step 1 renders **both** the name and the mobile-number field,
unconditionally for every number. `_verify()` passes `displayName: _name.text`.

---

## 3. Requirements implemented

| Requirement | Source | Implementation |
|---|---|---|
| Account created only after successful OTP verification | `AR-2`, BC Map §4 | §2.2 — creation occurs after the code comparison and single-use removal |
| Display Name collected before OTP verification; required and non-nullable | `AR-5` | §2.5 collects it; §2.2 consumes it; `Account.displayName` type unchanged |
| Empty string / mobile number prohibited | `AR-5` | §2.2 — creation refused |
| Placeholder / auto-generated names prohibited | `AR-5` | Honoured by never synthesising a name |
| Existing display name never rewritten | `AR-5` | §2.2 step 1 |
| Authentication and Session Issuance separate | `AR-6` | §2.2 and §2.3 are distinct methods with distinct return types |
| An Account may exist before any tenant role | `AR-6` | `roles: const {}` at creation |
| Session issued only after the authorization context exists | `AR-6` | §2.3 `rolesIn(tenant).isEmpty → null` |
| Identical observable behaviour until verification succeeds | `AR-7`, requirement 1.3 | §2.1 removes the last registration-dependent branch |
| Conformance validates security behaviour, not storage | `AR-7` | §6 — `F-02` test 2 re-expressed |
| No rate-limiting policy invented | Ruling · `ACN-001` | Nothing added |

---

## 4. Architecture impact

**None beyond the recorded rulings.**

| Dimension | Result |
|---|---|
| Bounded contexts | Unchanged — 31 (23 in V1). `AR-6` is a stage separation *inside* `BC-18`, not a context split |
| Aggregates, invariants | Unchanged |
| Integration edges `E-01`…`E-26` | Unchanged — none added |
| Events | None added, none emitted |
| Identity rules `ID-1`…`ID-6` | Unchanged. `AccountId` lifecycle confirmed, not altered |
| Module ranks / dependency laws | Unchanged. Work confined to `platform/identity` (rank 4) and its existing `app/**` callers |
| `tool/module_dependencies.yaml` | **Not modified.** No new import, port or banned-symbol interaction |
| Forbidden edges `X-01`…`X-14` | None approached. `X-09` respected — clock, ids and randomness all injected |

---

## 5. Security impact summary

| Property | Before | After | Direction |
|---|---|---|---|
| `requestOtp` return value | `void` | `void` | Unchanged |
| Internal state after `requestOtp` | Differs by registration status | **Identical** | **Improved** |
| Timing profile of `requestOtp` | Map write on the registered path only | Write always | **Improved** |
| `verifyOtp` on wrong / expired / exhausted | `null` | `null` | Unchanged |
| Authentication implying authorization | Possible — one call returned a session | **Structurally impossible** — separate methods, separate types | **Improved** |
| `F-01` scope-bearing authorization | Closed | Closed, untouched | Unchanged |
| `F-02` enumeration oracle | Closed | Closed, **strengthened** | **Improved** |
| Credential containment `ID-1`, `MP-GBR-27` | Held | Held — creation is inside `BC-18` | Unchanged |
| Sole factor `MP-GBR-25` | Held | Held — no password, no second factor | Unchanged |
| No guest/anonymous accounts `MP-CON-11` | Held | Held — every account has a verified number and a collected name | Unchanged |
| Session revocation `MP-GBR-26` | Held | Held — revocation code untouched | Unchanged |
| Challenge store growth bound | Account roster | **Caller-controlled** | **Regressed — accepted, recorded in [`ACN-001`](./ACN-001-OTP-Request-Rate-Limiting.md)** |

**Net: four improvements, no weakening, one accepted availability regression recorded as an open note.**

`issueSession` cannot be used as an existence oracle: it accepts an `Account`, never a phone number, so a caller
without a verified account has nothing to pass it.

---

## 6. Test impact and results

| Suite | Before | After | Change |
|---|---|---|---|
| `authentication_conformance_test.dart` | 26 | **34** | 1 re-expressed · 6 call sites adapted · 8 added |
| `widget_test.dart` | 9 | 9 | **Unmodified**; all pass |
| **Total** | 35 | **43** | |

**Re-expressed under `AR-7`** — `F-02` test 2, from *"an unknown number yields no usable challenge and no signal"*
to *"a registered and an unregistered number are indistinguishable"*. The storage assertion
(`debugPeekChallenge(unknown)` is null) is replaced by a uniformity assertion across both numbers; the security
assertion (`verifyOtp` → `null`) is retained, and a further assertion confirms no account was created.

**Eight new tests, one per ruling clause** — creation on first OTP · refusal without a collected name · refusal of
the mobile number as a name · no rewrite of an existing name · no creation on wrong/expired/exhausted code ·
role-less account yields no session · session issued once a role exists · authentication never returns a session.

```
flutter analyze  →  No issues found!
flutter test     →  All tests passed!   43 tests
```

---

## 7. API impact summary

| API | Change | Compatibility |
|---|---|---|
| `AuthService.requestOtp(String)` | None | ✅ Compatible |
| `AuthService.debugPeekChallenge(String)` | None | ✅ Compatible |
| `AuthService.accounts` | None | ✅ Compatible |
| `AuthService.verifyOtp({...})` | Return type `AuthSession?` → `Account?`; `tenant` and `branch` removed; optional `displayName` added | ❌ **BREAKING** |
| `AuthService.issueSession({...})` | **New method** | ➕ Additive |
| `Account` | None — `displayName` still `required`, non-nullable | ✅ Compatible |
| `AuthSession` | None — `activeRole` still non-nullable | ✅ Compatible |
| `AccessRole`, `Permission`, `AccessScope`, `PolicyDecisionPoint` | None | ✅ Compatible |
| `SessionController.verifyOtp({...})` | Optional `displayName` added; return type unchanged (`bool`) | ✅ Source-compatible |
| `SessionController.verifiedAccount`, `.awaitingAuthorization` | **New getters** | ➕ Additive |

**No HTTP, REST or wire API exists in this scaffold.** All API surface is in-process Dart.

---

## 8. Breaking changes summary

**One breaking change.**

`AuthService.verifyOtp` no longer returns a session and no longer accepts a tenant or branch.

| Aspect | Detail |
|---|---|
| **Why** | Ruling `AR-6`: *"Do not merge Authentication and Authorization responsibilities."* A tenant parameter on an authentication call is that merge; a session return value is that merge's result |
| **Scope note** | Permitted under *"do not modify unrelated APIs"* because this API **is** the subject of the ruling |
| **Call sites updated** | 1 production (`lib/app/session.dart:83`) · 7 test call sites |
| **Migration** | `verifyOtp(...)` → `verifyOtp(phone:, code:, displayName:)` then `issueSession(account:, tenant:, branch:)` |
| **Undeclared breakage** | **None.** `flutter analyze` reports no issues; the compiler enumerated every call site |

---

## 9. Database impact

**None.** The scaffold holds accounts in an in-memory `List<Account>`; no schema, migration, index or query exists.

`AuthService` appends to the list injected at `lib/bootstrap/di.dart:178` (`final accounts = <Account>[]`, growable).
This is recorded as design note `RK-7` in `IVR-001` §8: the alternative — an account-repository port — would add a
port and a module edge, exceeding *"minimum architecture-aligned changes."*

---

## 10. Confirmation of invariants

| Invariant | Status |
|---|---|
| `F-01` — authorization is scope-bearing | ✅ Closed, untouched |
| `F-02` — challenge issuance uniform and unpredictable | ✅ Closed, strengthened |
| `ID-1` — no credential outside `BC-18` | ✅ Held |
| `MP-GBR-25` — OTP is the sole factor | ✅ Held |
| `MP-GBR-26` — revocation immediate and global | ✅ Held |
| `MP-GBR-27` — no credential outside `BC-18` | ✅ Held |
| `MP-CON-11` — no demo/guest accounts in a release build | ⚠️ Held by this change; **pre-existing defect `D-10` remains open** — `kDemoChildPhone` (`session.dart:26`) and the seeded tap-to-sign-in list (`login_screen.dart:196`) must be removed before a release build. Not introduced and not worsened here |
| `X-09` — no ambient time, id or randomness | ✅ Held — all injected |
| Tenant isolation | ✅ Untouched. `issueSession` still requires a tenant; scope entry is unchanged |

---

## 11. Deviations from `IVR-001`

**One**, disclosed and corrected in the documentation:

`IVR-001` v1.1 §6.2 initially claimed `widget_test.dart` held 8 tests with no login-screen coverage. It holds
**9**, one of which renders the login screen. The claim was withdrawn in commit `cbd59b3`. No functional impact —
that test passes unchanged, because the `AR-5` field addition preserves the `'Liboora'` and `'Send OTP'` finders it
asserts.

No other deviation. The implemented change set equals the validated change set.
