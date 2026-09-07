# TASK-D10 — Remove demo and debug authentication surfaces

| Field | Value |
|---|---|
| **Task ID** | `TASK-D10` |
| **Classification** | **Implementation task** — not a documentation issue |
| **Priority** | **P0 — release blocker** |
| **Type** | Code change (production code) |
| **Violates** | `MP-CON-11`, `AUTH-11.73` |
| **Blocks** | Any release build. Cannot ship with these present |
| **Estimated size** | Small in lines, medium in consequence — the login flow loses its only sign-in path |

---

## 1. Classification

`D-10` was previously carried on the documentation defect register. **It does not belong there.** The
documentation is correct and unambiguous:

> `MP-CON-11` — *"no demo or guest accounts in any release build"*
> `AUTH-11.73` — no debug or demo authentication surface may exist in a release build

There is no conflict, no ambiguity, and nothing to decide. The specification says one thing and the code does
another. That is a **defect in the code**, tracked as an implementation task, and it is closed by editing Dart —
not by editing Markdown.

It is recorded here so that it is impossible to reach a release build without having seen it.

---

## 2. Scope — three surfaces, five files

The surface is **wider than previously recorded.** Earlier registers listed two locations. There are three, and
the third is the most serious because it defeats the authentication factor outright.

### Surface 1 — Hardcoded demo child phone

**`lib/app/session.dart:26`**

```dart
const String kDemoChildPhone = '9810000004';
```

Consumed at **`lib/app/session.dart:71`**:

```dart
AccessRole.parent => container.studentAccountLinks[kDemoChildPhone],
```

**What it does.** Every parent session resolves to the same hardcoded student, regardless of who the parent is.

**Why it exists.** The existing comment is honest and correct: V1 has no Family Access bounded context, so the
parent↔student link has no home. Hardcoding kept the gap visible rather than inventing a wrong model.

**Why it must still go.** The reasoning justifies *not modelling the link*. It does not justify *shipping a
constant that silently gives every parent access to one specific student's record.* In a multi-tenant system that
is a cross-tenant data exposure with a plausible-looking comment above it.

### Surface 2 — Seeded accounts panel

**`lib/app/shell/login_screen.dart:219`** — `_seededAccounts()`, rendered unconditionally at **line 90**.

```dart
const accounts = <(String, String, String)>[
  ('9810000001', 'Rajesh Sharma', 'Owner'),
  ('9810000002', 'Priya Nair',    'Manager'),
  ('9810000003', 'Amit Kumar',    'Reception'),
  ('9810000004', 'Sneha Verma',   'Student'),
  ('9810000005', 'Suresh Verma',  'Parent'),
];
```

UI label: `'SEEDED ACCOUNTS · TAP TO SIGN IN'`.

**⚠ This surface has no release guard of any kind.** It is not behind `kDebugMode`, not behind
`dart.vm.product`, not behind a flag. It renders on the login screen of **every** build, including release. Five
tappable accounts covering every privilege level in the platform, up to and including Owner.

This is the most direct `MP-CON-11` violation in the codebase.

### Surface 3 — OTP auto-fill via debug peek ⚠ most severe

Three files participate:

| File | Line | Code |
|---|---|---|
| `lib/platform/identity/identity.dart` | 323–324 | `String? debugPeekChallenge(String phone) => challengePeekEnabled ? _issued[phone]?.code : null;` |
| `lib/app/session.dart` | 91 | `_otpHint = container.auth.debugPeekChallenge(phone.trim());` |
| `lib/app/shell/login_screen.dart` | 42 | `_code.text = s.otpHint ?? '';` |

**What it does.** Requesting a code reads that code out of the service and **types it into the OTP field for the
user.** The user never needs to receive the SMS. Possession of the mobile number — the sole authentication factor
in V1 (`MP-GBR-25`) — is not proven at any point.

**Guard status — partial and fragile.** `lib/bootstrap/di.dart:214` sets:

```dart
challengePeekEnabled: !const bool.fromEnvironment('dart.vm.product'),
```

This is better than Surface 2, but it is **not sufficient**, for three reasons:

1. It is `false` **only in release**. Profile builds — which are shipped to testers and are how the current
   preview is served — have the auto-fill fully active.
2. The safety of the entire authentication factor rests on **one boolean, in one wiring file, that a future
   `AuthService` construction elsewhere could forget.** Nothing structurally prevents a second call site passing
   `true`, and the parameter defaults to `false` only by convention.
3. Under `ADR-0007`, conformance now validates **behaviour, not storage**, so this method has lost the
   justification it was created for. It is a live authentication bypass retained for a purpose that no longer
   exists.

---

## 3. Required changes

### 3.1 Surface 2 — delete outright

| Step | Action |
|---|---|
| D10-1 | Delete `_seededAccounts()` from `lib/app/shell/login_screen.dart` |
| D10-2 | Delete its call site at line 90 and the adjacent `SizedBox` spacer |
| D10-3 | Confirm no string `'SEEDED ACCOUNTS'` remains anywhere in `lib/` |

**Do not guard it — delete it.** A guarded demo panel is still a demo panel one build flag away from production.

### 3.2 Surface 3 — remove the auto-fill, then the peek

| Step | Action |
|---|---|
| D10-4 | Delete `_code.text = s.otpHint ?? '';` (`login_screen.dart:42`). **This alone closes the bypass** |
| D10-5 | Delete `_otpHint`, `otpHint`, and all four assignments in `session.dart` (36, 41, 91, 137, 145, 160) |
| D10-6 | Delete `debugPeekChallenge` and the `challengePeekEnabled` field from `identity.dart` |
| D10-7 | Delete `challengePeekEnabled:` from `di.dart:214` |
| D10-8 | Update `test/authentication_conformance_test.dart` — **see §4, this is the substantial part** |

**Order matters.** D10-4 removes the bypass in one line and can merge immediately. D10-5 through D10-8 remove the
mechanism and require the test work below.

### 3.3 Surface 1 — remove with an explicit product decision

| Step | Action |
|---|---|
| D10-9 | Delete `kDemoChildPhone` from `session.dart:26` |
| D10-10 | Resolve `subjectStudentId` for `AccessRole.parent` — **requires a product decision** |

`subjectStudentId` must return something for a parent. Three options, in order of preference:

| Option | Behaviour | Assessment |
|---|---|---|
| **A** | Return `null` for `AccessRole.parent`; parent screens show "no linked student" | **Recommended.** Honest. The gap becomes visible in the product, which is what the original comment intended |
| **B** | Look up a real link via `studentAccountLinks` keyed on the parent's own phone | Correct if the mapping is genuinely populated. Verify before choosing |
| **C** | Defer the parent role from V1 entirely | Cleanest, but a scope change requiring product sign-off |

**Do not** substitute another constant. Option A is the default if no decision is made.

---

## 4. Test impact — the real work

`test/authentication_conformance_test.dart` calls `debugPeekChallenge` at **13 sites** (lines 202, 203, 233, 234,
236, 249, 262, 278, 293, 306, 340, 356, 367) and constructs the service with `challengePeekEnabled: peek` at
line 26. Removing the method breaks the conformance suite, which currently passes 34 tests.

**The tests are not wrong to need the code — they are wrong to obtain it by inspecting internal state.** This is
exactly what `ADR-0007` addresses.

**Required approach.** Introduce a **test-only delivery channel** at the boundary the service already has: a fake
SMS/notification sink injected in test wiring. The test then reads the code from *the message that was
delivered*, which is what a legitimate user does.

```
Before:  code = service.debugPeekChallenge(phone)      // reads private state
After:   code = fakeSmsGateway.lastMessageTo(phone).code // reads the delivered message
```

This is strictly better:

- it lives in `test/`, so it **cannot** ship — the current mechanism lives in `lib/`
- it exercises the real delivery path, catching failures the peek cannot see
- it satisfies `ADR-0007` — the assertion is about observable behaviour
- production code loses a parameter and a method rather than gaining a flag

**All 34 conformance tests must still pass.** If a test cannot be expressed through the delivered message, that
test was asserting an implementation detail and must be re-expressed per `ADR-0007` — not exempted.

---

## 5. Acceptance criteria

| # | Criterion | Verification |
|---|---|---|
| **AC-1** | No demo, seeded, guest or sample account exists in `lib/` | `grep -rniE "seeded\|demo\|guest\|sample.?account" lib/` → no auth-related hit |
| **AC-2** | No hardcoded mobile number in `lib/` | `grep -rnE "'98100000[0-9]+'" lib/` → empty |
| **AC-3** | No method returns an OTP code to a caller | `grep -rn "PeekChallenge\|otpHint" lib/` → empty |
| **AC-4** | The OTP field is never pre-filled | `grep -rn "_code.text = " lib/` → only user-initiated clears |
| **AC-5** | Signing in requires a code the user actually received | Manual: request a code, confirm the field is empty |
| **AC-6** | `flutter analyze` → `No issues found!` | CI |
| **AC-7** | All 34 conformance + 9 widget tests pass | `flutter test` |
| **AC-8** | Release build contains no demo string | `grep -c "SEEDED" build/web/main.dart.js` → `0` |
| **AC-9** | **Profile** build also contains none | Same check on a profile build — profile builds reach testers |
| **AC-10** | Parent `subjectStudentId` resolves without a constant | Code review against §3.3 |

**AC-9 is deliberate.** The current guard protects release only. Profile builds are shipped to testers and are
how the preview is served today. A bypass that reaches testers is a bypass.

---

## 6. Sequencing

```
D10-4  ── delete one line, closes the live bypass ──────────► merge immediately
   │
   ├── D10-1..3   delete seeded panel        ─────────────► merge (needs §7 first)
   │
   ├── D10-8      test-only SMS sink         ─────────────► merge
   │        └── D10-5..7  remove peek mechanism ──────────► merge
   │
   └── D10-9..10  parent link                ─────────────► needs product decision
```

**D10-4 is a one-line change that closes the authentication bypass.** It does not depend on the test work and
should not wait for it.

---

## 7. Prerequisite — this task removes the only way to sign in

The seeded panel exists because *"the scaffold has no sign-up backend"*, and the auto-fill exists because no SMS
provider is wired. Deleting both without a replacement leaves an application nobody can enter.

**Therefore `TASK-D10` cannot complete before a real OTP delivery path exists** — an SMS provider integration
under `MP-DEP-03` (DLT-registered templates), with development environments using a provider sandbox or a
logging sink that writes the code to **server logs**, never to the client.

This ordering is reflected in `IMPLEMENTATION_ROADMAP.md`. **Attempting `TASK-D10` before SMS delivery exists
will fail**, and the pressure to reinstate the bypass "temporarily" is exactly how these surfaces survive to
production.

The single exception is **D10-4**, which removes the auto-fill only. A developer can still read the code from a
debug log and type it. Do that one now.

---

## 8. Definition of done

- [ ] All ten steps `D10-1` … `D10-10` complete
- [ ] All ten acceptance criteria `AC-1` … `AC-10` verified
- [ ] `flutter analyze` clean, `flutter test` green
- [ ] Release **and** profile artefacts grepped clean
- [ ] Parent-link decision recorded (option A, B or C) with an owner
- [ ] `MP-CON-11` and `AUTH-11.73` confirmed satisfied in code review
- [ ] `D-10` marked CLOSED in the defect register with the closing commit SHA

---

## 9. References

`MASTER_PRD.md` `MP-CON-11` (line 521), `MP-GBR-25` (line 378), `MP-DEP-03` (line 569) ·
Authentication PRD v2.0 `AUTH-11.73`, Chapter 8 §8.3 ·
`ADR-0002` (OTP as sole factor) · `ADR-0007` (behavioural conformance) ·
`DOCUMENTATION_AUDIT-001.md` finding `G-6` · `DEFINITION_OF_DONE.md`
