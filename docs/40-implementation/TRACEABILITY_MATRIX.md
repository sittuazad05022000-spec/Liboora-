# Liboora — Requirements Traceability Matrix

| Field | Value |
|---|---|
| **Version** | v1.1 |
| **Status** | Active — updated with every requirement implemented |
| **Date** | 2026-08-02 · **extended 2026-08-03** |
| **Baseline** | BASELINE-2026-08-03 |
| **Sources** | Authentication PRD v2.0 · **Library PRD v1.0** + §14A + §14B + Invitation Security Specification |

---

## 1. Purpose

Maps every specification identifier to the artefact that satisfies it. Answers three questions that would
otherwise be answered by memory:

1. **Is this requirement implemented?**
2. **Which test proves it?**
3. **If I change this code, which requirements might I break?**

The **Status** column is the live record. It is updated in the same commit as the code, per `DEFINITION_OF_DONE.md`
Gate 2.

---

## 2. Identifier inventory — Authentication

Verified mechanically against `Authentication_PRD_v2.md`. **Zero collisions.**

| Prefix | Meaning | Count | Range |
|---|---|---|---|
| `AUTH-c.n` | Functional requirement | **588** | `AUTH-1.1` … `AUTH-11.81` |
| `BR-c.n` | Business rule | **297** | Chapters 2–10 |
| `XC-c.n` | Exclusion — must be impossible | **212** | Chapters 2–10 |
| `AC-c.n` | Acceptance criterion | **321** | Chapters 2–11 |
| `PR-n` | Product principle | 2 | Chapter 1 |
| `TR-n` | Trust requirement | 5 | Chapter 1 |
| `EV-n` | Domain event | **26** | Chapter 10 |
| `AERR-n` | Error class (closed set) | **13** | Chapter 11 |
| `CFG-n` | Configurable parameter | **12** | Cover §E |
| `SO-n` | Security objective | 10 | Chapter 8 |
| `PP-n` | Privacy principle | 10 | Chapter 8 |
| `AU-n` | Audit principle | 9 | Chapter 10 |
| `EP-n` | Event principle | 12 | Chapter 10 |

**Total normative identifiers: 1,517.**

---

## 2A. Identifier inventory — Library Management

Verified mechanically across the four Library specification documents. **Zero collisions with the authentication
register** — every Library prefix is distinct from every authentication prefix, deliberately.

| Prefix | Meaning | Count | Range | Source |
|---|---|---|---|---|
| `LIB-n.m` | Functional requirement | ~**130** | `LIB-4.1` … `LIB-26.2` | `Library_PRD_v1.md` §§1–25 |
| `LIB-14B.n` | Public preview requirement | **51** | `LIB-14B.1` … `LIB-14B.51` | §14B |
| `LIB-DISC-n` | Discovery requirement | **13** | `LIB-DISC-001` … `013` | §14A |
| `INV-SEC-n` | Invitation security requirement | **71** | `INV-SEC-001` … `071` | Invitation Security Specification |
| `LBR-n` | Library business rule | 8 | `LBR-1` … `LBR-8` | `Library_PRD_v1.md` |
| `LIB-PREV-n` | Preview business rule | 13 | `LIB-PREV-001` … `013` | §14B |
| `LXC-n` | Library exclusion — must be impossible | 10 | `LXC-1` … `LXC-10` | `Library_PRD_v1.md` |
| `INV-XC-n` | Invitation exclusion — out of scope, not deferred | 7 | `INV-XC-1` … `INV-XC-7` | Invitation Security Specification |
| `LAC-n` | Library acceptance criterion | 12 | `LAC-1` … `LAC-12` | `Library_PRD_v1.md` |
| `LAC-14B-n` | Preview acceptance criterion | 16 | `LAC-14B-1` … `16` | §14B |
| `IAC-n` | Invitation acceptance criterion | 25 | `IAC-1` … `IAC-25` | Invitation Security Specification |
| `LCFG-n` | Library configurable | 13 | `LCFG-1` … `LCFG-13` | §16.1, §14B.9 |
| `ICFG-n` | Invitation configurable | 10 | `ICFG-1` … `ICFG-10` | Invitation Security Specification §11 |
| `LEV-n` | Library domain event | 28 | `LEV-1` … `LEV-28` | §21.1 + invitation events |
| `PO-n` | Protected operation (**closed list**) | 12 | `PO-1` … `PO-12` | §14B.6 |
| `IT-n` | Invitation type (**closed set**) | 3 | `IT-1`, `IT-2`, `IT-3` | Invitation Security Specification §2 |

**Total Library normative identifiers: ~422.**

### 2A.1 Two registers that must not be confused

| Looks similar | Actually |
|---|---|
| `INV-n` | **Platform invariant** — `INV-1`…`INV-16`, in `CONFIGURATION_GUIDE.md` §3. A relationship between configurable values that must hold at startup |
| `INV-SEC-n` | **Invitation security requirement** — a numbered requirement in the Invitation Security Specification |
| `INV-XC-n` | **Invitation exclusion** — something deliberately out of scope |

These three share a prefix and mean different things. When citing one, cite it in full. `INV-4` and `INV-SEC-004`
are unrelated.

---

## 3. Chapter map

| Ch | Title | `AUTH` | `BR` | `XC` | `AC` | Implementation task | Status |
|---|---|---|---|---|---|---|---|
| 1 | Purpose and Goals | 1.1–1.5 | — | — | — | *(non-functional framing)* | N/A |
| 2 | User Types and Roles | 2.1–2.26 | 2.1–2.20 | 2.1–2.16 | 2.1–2.20 | `IMPL-050` | ⬜ Not started |
| 3 | Authentication Methods | 3.1–3.31 | 3.1–3.20 | 3.1–3.14 | 3.1–3.20 | `IMPL-020`, `IMPL-030` | ⬜ Not started |
| 4 | Registration and Account Claim | 4.1–4.37 | 4.1–4.25 | 4.1–4.16 | 4.1–4.26 | `IMPL-031` | ⬜ Not started |
| 5 | Login and Library Selection | 5.1–5.38 | 5.1–5.22 | 5.1–5.18 | 5.1–5.24 | `IMPL-030`, `IMPL-040` | ⬜ Not started |
| 6 | Session and Device Management | 6.1–6.75 | 6.1–6.34 | 6.1–6.22 | 6.1–6.34 | `IMPL-040`, `IMPL-041` | ⬜ Not started |
| 7 | Roles, Permissions, Access Policies | 7.1–7.73 | 7.1–7.33 | 7.1–7.26 | 7.1–7.32 | `IMPL-050`, `IMPL-051`, `IMPL-052` | ⬜ Not started |
| 8 | Security and Privacy | 8.1–8.105 | 8.1–8.64 | 8.1–8.36 | 8.1–8.44 | `IMPL-021`, `TASK-D10` | ⬜ Not started |
| 9 | Account Lifecycle | 9.1–9.80 | 9.1–9.44 | 9.1–9.36 | 9.1–9.46 | `IMPL-060` | ⬜ Not started |
| 10 | Events, Audit, Notifications | 10.1–10.37 | 10.1–10.35 | 10.1–10.28 | 10.1–10.38 | `IMPL-061`, `IMPL-062` | ⬜ Not started |
| 11 | NFR, Compliance, Final Acceptance | 11.1–11.81 | — | — | 11.1–11.37 | `IMPL-070`…`IMPL-073` | ⬜ Not started |

**Status vocabulary:** ⬜ Not started · 🟨 In progress · ✅ Implemented and tested · ⛔ Blocked

**Everything is `Not started`.** The specification was authored this baseline; no chapter has been implemented
against it. Existing code predates the specification and must be verified against it, not assumed to conform.

---

## 3A. Chapter map — Library Management

| § | Subject | Requirements | Implementation task | Status |
|---|---|---|---|---|
| 1–3 | Purpose, scope, definitions | `LIB-1.*`…`LIB-3.*` | *(framing)* | N/A |
| 4 | Roles consumed from `BC-18` | `LIB-4.1`…`LIB-4.4` | `IMPL-112` | ⬜ Not started |
| 5 | Staff as accounts holding roles | `LIB-5.1`…`LIB-5.4` | `IMPL-112` | ⬜ Not started |
| 6 | Library profile | `LIB-6.1`…`LIB-6.6` | `IMPL-102`, `IMPL-109` | ⬜ Not started |
| 7 | Public visibility | `LIB-7.1`…`LIB-7.3` | `IMPL-120` | ⬜ Not started |
| 8 | Lifecycle | `LIB-8.1`…`LIB-8.11` | `IMPL-101` | ⬜ Not started |
| 9–11 | Branch, floor, zone | `LIB-9.*`…`LIB-11.5` | `IMPL-104` | ⬜ Not started |
| 12 | Operating hours, holidays, closure | `LIB-12.1`…`LIB-12.8` | `IMPL-105` | ⬜ Not started |
| 13 | Facilities | `LIB-13.1`…`LIB-13.6` | `IMPL-106` | ⬜ Not started |
| 14 | Visibility (Public / Private) | `LIB-14.1`…`LIB-14.7` | `IMPL-101`, `IMPL-120` | ⬜ Not started |
| **14A** | Discovery and enrollment | `LIB-DISC-001`…`013` | `IMPL-122` | ⬜ Not started |
| **14B** | **Public preview** | `LIB-14B.1`…`51`, `PO-1`…`PO-12` | `IMPL-120`, `121`, `123`, `124`, `125` | ⬜ Not started |
| 15 | Staff and role assignment | `LIB-15.1`…`LIB-15.13` | `IMPL-112` | ⬜ Not started |
| 16 | Settings | `LIB-16.1`…`LIB-16.9` | `IMPL-107`, `IMPL-127` | ⬜ Not started |
| 17 | Business policies | `LIB-17.1`…`LIB-17.5` | `IMPL-108` | ⬜ Not started |
| 18 | Identifiers | `LIB-18.1`…`LIB-18.4` | `IMPL-100` | ⬜ Not started |
| 19 | Read models | `LIB-19.1`…`LIB-19.10` | `IMPL-120` | ⬜ Not started |
| 20 | Audit | `LIB-20.*` | `IMPL-103` | ⬜ Not started |
| 21 | Events and integration boundaries | `LIB-21.1`…`LIB-21.5`, `LEV-1`…`LEV-28` | `IMPL-126` | ⬜ Not started |
| 22–25 | NFR, exclusions, acceptance | `LXC-1`…`10`, `LAC-1`…`12` | All | ⬜ Not started |
| 26 | Ownership boundary | `LIB-26.1`, `LIB-26.2` | *(governance)* | N/A |
| — | **Invitation security** | `INV-SEC-001`…`071` | `IMPL-110`…`IMPL-114` | ⬜ Not started |

**Every Library row is `Not started`, and this is not a formality.** There is no tenancy module, no library
aggregate, no public projection and no invitation mechanism in `lib/`. Unlike authentication — where code predates
the specification and must be *verified* against it — Library Management has nothing to verify. The two situations
look identical in this column and are not: one is unproven, the other is absent.

---

## 4. Decision traceability — ADR to specification

| ADR | Promotes | Governs | Chapters | Task |
|---|---|---|---|---|
| `ADR-0001` | — | Modular monolith | All | `IMPL-014` |
| `ADR-0002` | `MP-GBR-25`, `MP-CON-11` | OTP sole factor | 3, 8 | `IMPL-020`, `TASK-D10` |
| `ADR-0003` | BC Map §11 | Hybrid tenancy | 2, 7 | `IMPL-050` |
| `ADR-0004` | `AR-6` | Two-stage auth | 4, 5, 6 | `IMPL-030` |
| `ADR-0005` | `AR-2` | Account creation on first OTP | 4, 9 | `IMPL-031` |
| `ADR-0006` | `AR-5` | Display name before verification | 4, 9 | `IMPL-031` |
| `ADR-0007` | `AR-7` | Behavioural conformance | 8 | `TASK-D10` D10-8 |
| `ADR-0008` | Closes `D-7` | v2.0 baseline | All | — |
| `ADR-0009` | Completes `AR-4` | Invitation is a claim, not a credential | Invitation spec; Library §15 | `IMPL-110`…`IMPL-114` |
| `ADR-0010` | Extends `AR-3` | Anonymous public access via projection | §14A, §14B | `IMPL-120`…`IMPL-125` |

---

## 5. Global rule traceability

Master PRD rules constrain the whole platform and outrank the Authentication PRD.

| Rule | Line | Statement | Enforced by | Gate |
|---|---|---|---|---|
| `MP-GBR-08` | — | Tenant key mandatory on tenant data | `IMPL-052`, **`IMPL-100`** | Merge + Release |
| `MP-GBR-25` | 378 | Mobile OTP sole V1 factor; no passwords | `ADR-0002`, `IMPL-020` | Merge |
| `MP-GBR-26` | 379 | Revocation immediate and global; no propagation window | `IMPL-040` | Release |
| `MP-GBR-27` | 380 | *(per Master PRD)* | `IMPL-040` | Release |
| `MP-CON-11` | 521 | **No demo or guest accounts in any release build** | **`TASK-D10`** | **Release — blocking** |
| `MP-DEP-03` | 569 | SMS/DLT dependency | `IMPL-020`, **`IMPL-112`** | Release |
| `MP-DEP-06` | — | Module boundary manifest | `IMPL-014` | Merge |

---

## 6. Configurable parameter traceability

| `CFG` | Chapters | Governing requirements | Invariants | Task |
|---|---|---|---|---|
| `CFG-1` | 8 | `AUTH-8.16`–`8.23` | `INV-4`, `INV-5` | `IMPL-021` |
| `CFG-2` | 8 | `AUTH-8.16`–`8.23` | `INV-4`, `INV-6` | `IMPL-021` |
| `CFG-3` | 8 | `AUTH-8.16`–`8.23` | `INV-5` | `IMPL-021` |
| `CFG-4` | 8, 9 | `AUTH-8.24`–`8.28` | `INV-4` | `IMPL-021` |
| `CFG-5` | 6 | `AUTH-8.34`–`8.40` | `INV-1`, `INV-2`, `INV-7` | `IMPL-040` |
| `CFG-6` | 6 | `AUTH-8.34`–`8.40` | `INV-1`, `INV-2`, `INV-3`, `INV-8` | `IMPL-040` |
| `CFG-7` | 6 | `AUTH-6.46`, `AUTH-8.41`–`8.47` | `INV-3` | `IMPL-041` |
| `CFG-8` | 6 | `AUTH-8.41`–`8.47` | — | `IMPL-041` |
| `CFG-9` | 9 | Chapter 9 retention | — | `IMPL-060` |
| `CFG-10` | 9 | Chapter 9 retention | — | `IMPL-060` |
| `CFG-11` | 4 | Chapter 4 claim | — | `IMPL-031` |
| `CFG-12` | 2, 7 | `AUTH-7.19` | — | `IMPL-051` |

### 6A. Library and invitation configurables

| Group | Range | Governing requirements | Invariants | Task |
|---|---|---|---|---|
| Library settings | `LCFG-1` … `LCFG-10` | `LIB-16.1`…`LIB-16.9` | *(none — each is independently bounded)* | `IMPL-107`, `IMPL-127` |
| Preview | `LCFG-11` … `LCFG-13` | `LIB-14B.32`…`LIB-14B.42` | `INV-10`, `INV-11`, `INV-12` | `IMPL-124`, `IMPL-125` |
| Invitation TTL | `ICFG-1` … `ICFG-4` | `INV-SEC-016`…`022`, `INV-SEC-035` | `INV-13`, `INV-14`, `INV-15` | `IMPL-111` |
| Invitation limits | `ICFG-5` … `ICFG-10` | `INV-SEC-057`…`063` | `INV-16` | `IMPL-114` |

Stated in full:

| Invariant | Constraint | What breaks if it is violated |
|---|---|---|
| `INV-10` | `LCFG-11` ≤ `CFG-6` | A preserved intent outlives the longest session that could resume it — it can never be used |
| `INV-11` | `LCFG-11` > `CFG-2` × `CFG-1` | A user who takes the full permitted OTP retry cycle loses the thing they were trying to do |
| `INV-12` | `LCFG-13` ≤ 3600 s | Preview cache staleness becomes indefinite |
| `INV-13` | `ICFG-1` ≤ 7 d | A staff invitation outlives any plausible administrative window |
| `INV-14` | `ICFG-3` ≤ `ICFG-2` | The **weakest** artefact (`IT-3`, ≥40 bits, multi-use, read aloud) lives **longest** |
| `INV-15` | `ICFG-4` > `CFG-2` × `CFG-1` | An invitee times out part-way through authentication |
| `INV-16` | `ICFG-6` ≥ 1 | An `IT-3` code is created that nobody can ever redeem |

**`INV-11` and `INV-15` are the same constraint applied twice**, and they exist because the failure they prevent is
invisible in testing. Both bound a Library timeout *below* the maximum legitimate duration of an authentication
flow. A developer testing with a fast OTP will never see the failure; a real user on a slow network, using the
retries `CFG-1` explicitly permits, hits it every time. Neither value can be chosen by looking only at the document
that defines it.

**`INV-14` is the one that looks arbitrary and is not.** `IT-3` access codes have the lowest entropy of the three
types by design — they are short, unambiguous and meant to be spoken aloud to a room. That is acceptable only while
their exposure window stays short. Permitting `ICFG-3` to exceed `ICFG-2` would leave the weakest artefact in
circulation longest, which inverts the entire rationale for allowing a weak artefact at all.

**`LCFG-6` is the one that will be misread.** It is a search-index propagation delay and it applies to *removal
latency only*. It must never gate an authorization, membership, suspension or revocation decision (`LIB-16.9`).
`MP-GBR-26` requires revocation to be immediate and global with no propagation window, and a 60-second index delay
is exactly the propagation window that rule forbids — if anyone wires it into a policy path.

---

## 7. Event traceability

| Group | Events | Producer | Task |
|---|---|---|---|
| Identity | `EV-1` … `EV-7` | `BC-18` | `IMPL-061` |
| Authentication | `EV-8` … `EV-12` | `BC-18` | `IMPL-061` |
| Session / Device | `EV-13` … `EV-19` | `BC-18` | `IMPL-061`, `IMPL-041` |
| Authorization | `EV-20` … `EV-26` | `BC-18` | `IMPL-061`, `IMPL-050` |

### 7A. Library events

| Group | Events | Producer | Task |
|---|---|---|---|
| Library lifecycle | `LEV-1` … `LEV-8` | Library Management | `IMPL-126` |
| Structure and hours | `LEV-9` … `LEV-15` | Library Management | `IMPL-126` |
| Staff and settings | `LEV-16` … `LEV-22` | Library Management | `IMPL-126` |
| Invitation | `LEV-23` … `LEV-28` | Library Management | `IMPL-111`, `IMPL-126` |

**No Library event may carry a credential or an unmasked mobile number** (`LIB-21.5`). An event is the one artefact
in the system that is deliberately copied to subscribers who were not part of the original authorization decision;
whatever it carries, it carries everywhere.

**`EV-16` — unrecognised device notification — is security-critical.** It is the sole compensating control for
SIM swap in a single-factor system (`ADR-0002`). It is traced separately in `AUTHENTICATION_IMPLEMENTATION_CHECKLIST.md`.

---

## 8. Existing code — conformance unknown

The code predates the specification. These files touch `BC-18` and must be **verified against v2.0**, not assumed
conformant.

| File | Concern | Known status |
|---|---|---|
| `lib/platform/identity/identity.dart` | `AuthService`, challenge issuance, verification | Contains `debugPeekChallenge` — `TASK-D10` |
| `lib/app/session.dart` | Session controller, role resolution | Contains `kDemoChildPhone`, `_otpHint` — `TASK-D10` |
| `lib/app/shell/login_screen.dart` | Login UI | Contains `_seededAccounts()`, OTP auto-fill — `TASK-D10` |
| `lib/bootstrap/di.dart` | Service wiring | Sets `challengePeekEnabled` — `TASK-D10` |
| `test/authentication_conformance_test.dart` | 34 conformance tests | 13 call sites on `debugPeekChallenge` — must migrate to a test-only SMS sink per `ADR-0007` |

**The 34 passing conformance tests do not evidence conformance to v2.0.** They were written against earlier
rulings and cover a fraction of 588 requirements. Re-verification is part of Gate 2, per requirement.

---

## 9. Maintenance

1. Update this matrix **in the same commit** as the code — `DEFINITION_OF_DONE.md` Gate 1.
2. A requirement moves to ✅ only when its `AC-n.n` are verified by automated tests.
3. An `XC-n.n` needs a test proving the behaviour is **impossible**, not merely absent.
4. When a chapter reaches 100% ✅, record the verifying commit in the chapter map.
5. A requirement that cannot be implemented as written is a **specification defect** — raise a PRD amendment. Do
   not silently reinterpret it.

---

## 10. References

`Authentication_PRD_v2.md` · `DOCUMENTATION_BASELINE.md` · `IMPLEMENTATION_ROADMAP.md` ·
`AUTHENTICATION_IMPLEMENTATION_CHECKLIST.md` · `DEFINITION_OF_DONE.md` · `CONFIGURATION_GUIDE.md` ·
[`Library_PRD_v1.md`](../30-product/library/Library_PRD_v1.md) ·
[`14B-Public-Library-Preview.md`](../30-product/library/14B-Public-Library-Preview.md) ·
[`INVITATION_SECURITY_SPECIFICATION.md`](../30-product/library/INVITATION_SECURITY_SPECIFICATION.md) ·
[`LIBRARY_IMPLEMENTATION_TASKS.md`](./LIBRARY_IMPLEMENTATION_TASKS.md)

---

## 11. Change history

| Version | Date | Change |
|---|---|---|
| **v1.1** | 2026-08-03 | Added the Library identifier inventory (§2A, ~422 identifiers, zero collisions with the authentication register), the Library chapter map (§3A, 22 rows), Library configurable traceability (§6A) and Library event traceability (§7A). Added `ADR-0009` and `ADR-0010` to §4. Named `IMPL-100` as a second enforcer of `MP-GBR-08` and `IMPL-112` as a second consumer of `MP-DEP-03`. Recorded the `INV-n` / `INV-SEC-n` / `INV-XC-n` prefix hazard in §2A.1, and stated `INV-10`…`INV-16` in full with the failure each prevents. No authentication row changed. |
| v1.0 | 2026-08-02 | Created. 1,517 authentication identifiers mapped. Closes audit finding `G-9`. |
