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
> **Why archived: approved and superseded. Its subject — account creation on first successful OTP — is now recorded as `ADR-0005` and specified in Authentication PRD v2.0 Chapters 4 and 9.**
>
> Defect `D-7` — *"the Authentication PRD is not present in this repository"* — is **CLOSED**. The specification
> now exists as Authentication PRD v2.0. Any statement below asserting that the specification is missing, empty,
> pending transfer, or unwritten **was true when written and is false now.**

---

# ACR-001 — Architecture Consistency Report
## Account creation on first successful OTP verification

| Field | Value |
|---|---|
| **Report ID** | `ACR-001` |
| **Raised under** | Ruling `AR-2` — Authentication Alignment |
| **Subject** | `BC-18` Identity & Access — OTP challenge issuance and account creation |
| **Status** | **AWAITING APPROVAL — NO PRODUCTION CODE CHANGED** |
| **Date** | 2026-08-02 |
| **Code state at time of report** | commit `2fddce8`, working tree clean, `flutter analyze` → `No issues found!`, 35/35 tests passing |

> Ruling `AR-2` instructs: *"Review the current implementation and prepare an Architecture Consistency Report if
> the implementation diverges from this approved architecture. Do not change production code until the report is
> completed and approved."*
>
> **A divergence exists.** It is documented below. **No file under `lib/` has been modified.**

---

## 1. Conflict

The approved architecture requires that an `Account` come into existence on the first successful OTP
verification. The shipped implementation makes that outcome **unreachable**: it refuses to store a verifiable
challenge for any mobile number that does not already have an `Account`. An unknown number can therefore never
verify, and an `AccountId` can never be created.

The architecture permits self-registration. The code prevents it.

---

## 2. Supporting documents

### 2.1 The approved rule

`docs/architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md` §4, Identity Triad table, line 155 — verbatim:

> | **Account** | `AccountId` | BC-18 Identity & Access | Global, cross-tenant | **Created on first successful
> OTP.** Destroyed on account deletion. Holds *credentials only*. |

### 2.2 The ruling that confirms it

`docs/architecture/ARCHITECTURE_RULINGS.md` → `AR-2`:

> *"Account creation on the first successful OTP verification is explicitly approved."*
> Authentication remains responsible for OTP, Registration, Account creation, Session management,
> Authorization handoff.

### 2.3 Consistent supporting authorities

| Source | Statement | Bearing |
|---|---|---|
| `MASTER_PRD.md` line 369, `MP-GBR-25` | *"Mobile OTP is the sole authentication factor in V1. There are no passwords."* | OTP is the **only** path to an account; if OTP cannot create one, nothing can |
| `MASTER_PRD.md` line 371, `MP-GBR-27` | *"No context outside `BC-18` may store a password, OTP, session or credential."* | Account creation must happen **inside** `BC-18` — consistent with `AR-2` |
| `LIBOORA_BOUNDED_CONTEXT_MAP.md` line 119 | `BC-18` *"Owns credentials, sessions, devices, OTP, roles, permissions, policy decisions, consent"* | Registration is `BC-18`'s, not Library Discovery's |
| Library PRD §14A.7 / `LIB-DISC-008` | *"Authentication and Registration are delegated to the Authentication module."* | Library side is correct as written; no change needed there |

---

## 3. Exact location of the divergence

**File:** `lib/platform/identity/identity.dart`
**Method:** `AuthService.requestOtp(String phone)`
**Lines:** 307–318

```dart
  void requestOtp(String phone) {
    final code = _generateCode();
    final challenge = _Challenge(code: code, expiresAt: _clock.now().add(challengeTtl));
    // The only branch is on *storage*, never on the response. An unregistered
    // number consumes the same work and yields the same observable outcome.
    if (_accountForPhone(phone) != null) {
      _issued[phone] = challenge;
    }
  }
```

**Mechanism of the divergence.** The challenge is generated for every caller, but **persisted only when an
`Account` already exists**. Verification reads from `_issued`. For an unknown number there is no stored
challenge, so verification can never succeed, so the *"created on first successful OTP"* lifecycle can never be
entered.

**Origin — this was not carelessness.** The guard was introduced by the remediation of defect `F-02`
(*"challenge issuance is uniform and unpredictable"*), recorded in
`docs/prd/authentication/BLOCKER_CLOSURE_v1.0.md`. Its purpose is correct and must be preserved: it removes an
**account-enumeration oracle**, so an attacker cannot learn which mobile numbers are registered by observing
responses. The defect closure is sound. The side effect — eliminating self-registration along with the oracle —
was not intended by any document.

**Corroborating evidence in the same repository:**

| Evidence | Location | Meaning |
|---|---|---|
| `challengePeekEnabled: !const bool.fromEnvironment('dart.vm.product')` | `lib/bootstrap/di.dart` line 214 | The only way a challenge reaches a caller in a non-seeded scenario is the debug peek — off in release |
| `_code.text = s.otpHint ?? ''` | `lib/app/shell/login_screen.dart` line 40 | The login screen has no path for a number that was never seeded |
| 5 hard-coded accounts in `_seededAccounts()` | `lib/app/shell/login_screen.dart` line 196 | Every account that can currently log in was created by `lib/bootstrap/seed.dart`, never by OTP |
| 8 tests in group `F-02 · challenge issuance is uniform and unpredictable` | `test/authentication_conformance_test.dart` | Uniformity is asserted on the **observable response**, not on storage — see §5 |

---

## 4. Impact

| Area | Impact if unchanged |
|---|---|
| **Product** | No user can create an account. Every first-time journey terminates at the OTP screen. The library-discovery funnel (Library PRD §14A.7) has a **structurally zero** conversion rate for new users |
| **Library PRD §14A** | `LIB-DISC-012` (*preserve the user's intended action after authentication*) can never fire for a new user. Acceptance criteria 6 and 7 are unachievable |
| **Stated objectives** | §14A.2's *"Reduce onboarding friction"* and *"Increase membership conversion"* are unreachable |
| **Architecture** | The Identity Triad lifecycle for `AccountId` is documented but not implemented — a silent divergence between an approved rule and shipped behaviour |
| **Operations** | The product is only usable by accounts created via `lib/bootstrap/seed.dart`. That is a demo posture, and it collides with `MP-CON-11` (*no demo or guest accounts in any release build*) |
| **Security** | **None from the divergence itself.** The current behaviour is *more* restrictive, not less. This is a functional gap, not a vulnerability |

---

## 5. Recommended resolution

**Principle: preserve `F-02` in full; remove only the unintended side effect.**

`F-02` requires that the **observable response** to `requestOtp` be identical for known and unknown numbers.
It does **not** require that unknown numbers be unable to verify. The two requirements can both hold.

| Step | Change | Rule preserved |
|---|---|---|
| **1** | Store the challenge for **every** well-formed mobile number, uniformly | `F-02` — response was already uniform; storage now is too, so the observable surface is *unchanged* |
| **2** | On **successful verification** of a number with no `Account`, `BC-18` creates the `Account` | Bounded Context Map §4 lifecycle; ruling `AR-2` |
| **3** | Specify this in Authentication PRD Chapter 3 (`03-Registration.md`, currently an empty transfer slot) | Closes part of defect `D-7` |

**Why step 1 does not re-create the enumeration oracle.** The oracle `F-02` removed was observable *before*
authentication — an attacker could probe numbers and read the difference. Under this design the discriminating
fact (*"this number had no account, so one was created"*) is revealed only **after** the caller has proven
possession of the number by entering a correctly delivered OTP. An attacker who can do that already controls
the SIM, so no information is disclosed that they did not already hold.

**Expected test impact — to be confirmed at implementation time, not assumed.** The 8 `F-02` tests assert on the
observable response of `requestOtp`. Step 1 does not alter that response. The 3 `A-8 · identity types` tests and
the 7 `F-01` authorization tests are untouched. New coverage would be required for the account-creation path.
**These are expectations, not verified results — no test has been run against a modified implementation, because
no implementation has been modified.**

### Explicitly out of scope for this report

- No change to session management, revocation (`MP-GBR-26`), or the `AccessPolicy` model
- No change to `AccessRole`, `Permission`, `AccessScope` or any closed register
- No change to Library Discovery, which correctly delegates registration (`LIB-DISC-008`, §14A.8)
- No new role, permission, event or error code
- No relaxation of `MP-GBR-25` or `MP-GBR-27`

---

## 6. Approval gate

Per ruling `AR-2`, **production code remains unmodified.** The following is required before any implementation:

- [ ] Approve §5's three-step resolution, **or** direct an alternative
- [ ] Confirm that storing a challenge for unknown numbers is acceptable to the Security Architect
- [ ] Authorise the `BC-18` change (guardrails forbid unapproved authentication changes)
- [ ] Supply or authorise Authentication PRD Chapter 3 content (`D-7`)

On approval, an **Implementation Validation Report** will be produced before any code is written, and a
**Change Report** after.

---

## 7. Files that would change on approval — none touched yet

| File | Anticipated change | Current state |
|---|---|---|
| `lib/platform/identity/identity.dart` | `requestOtp` storage guard; account creation on first successful verify | **Unmodified** |
| `docs/prd/authentication/03-Registration.md` | Chapter 3 content | **Unmodified** — empty transfer slot |
| `test/authentication_conformance_test.dart` | New coverage for the creation path | **Unmodified** |

**Verification of the above:** `git status --short` reports a clean tree at commit `2fddce8`; no file under
`lib/` or `test/` appears in the change set of this report's commit.
