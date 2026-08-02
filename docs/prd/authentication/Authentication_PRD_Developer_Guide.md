# Authentication PRD — Developer Guide

**Audience:** a Senior Engineer joining the Liboora project and taking custody of the Authentication specification.

**Scope rule for this document:** every statement below is derived from a file that exists in this repository. Nothing is invented. Where the workspace does not contain an answer, this guide says so explicitly rather than supplying one. Section 19 lists what you are *not* being handed.

**Provenance of every claim:** `docs/prd/authentication/*` · `docs/architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md` · `docs/architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md` · `docs/architecture/LIBOORA_ENTERPRISE_ARCHITECTURE.md` · `docs/prd/MASTER_PRD.md` · `tool/module_dependencies.yaml` · `lib/platform/identity/identity.dart` · `packages/liboora_contracts/**` · `test/authentication_conformance_test.dart`.

---

## 1. Overview

Authentication in Liboora is owned by a single bounded context: **`BC-18` Identity & Access**, classified `[GENERIC]`, tagged **V1**, registered at line 119 of the bounded context map:

> Owns credentials, sessions, devices, OTP, roles, permissions, policy decisions, consent.

Two facts dominate everything else you will do here.

**First — the specification is not in the repository.** The Authentication Architecture Specification was approved as Chapters 1–11, but only its *custody shell* was committed. Eleven chapter files exist and all eleven are empty: 0 body characters between their transfer markers, verified mechanically. This is tracked as defect **`D-7`**, status **OPEN**. `docs/prd/authentication/README.md` therefore carries `STATUS = TRANSFER PENDING — NOT LOCKED`, and states the reason plainly:

> Declaring LOCKED over empty slots would create a source of truth that is authoritative and empty at the same time.

**Second — a substantial amount of authentication specification survives anyway, in enforceable form.** Two documents have real content (`BLOCKER_CLOSURE_v1.0.md`, `FINAL_VALIDATION_REPORT.md`), the manifest carries nine amendments as machine-readable declarations, the shared kernel encodes the error taxonomy as a closed enum with exhaustive projection, and 26 conformance tests execute the rules. **When the chapters and the code disagree, the chapters win — but the chapters are not available, so today the code and the closure record are the operative text.**

Authentication's product-level position is fixed by the Master PRD:

| Identifier | Rule | Source |
|---|---|---|
| `MP-GBR-25` | Mobile OTP is the sole authentication factor in V1. There are no passwords. OTP is single-use with a TTL and a bounded attempt budget. | `MASTER_PRD.md:369` |
| `MP-GBR-26` | Session revocation is immediate and global — authoritative-or-absent, with no propagation window. | `MASTER_PRD.md:370` |
| `MP-GBR-27` | No context outside `BC-18` may store a password, OTP, session or credential. | `MASTER_PRD.md:371` |
| `MP-CON-11` | Mobile OTP is the sole V1 factor. No passwords, no social login, **no demo or guest accounts in any release build**. | `MASTER_PRD.md:512` |
| `MP-DEP-03` | SMS provider + DLT template registration — V1 launch dependency; authentication cannot function without it. | `MASTER_PRD.md:560` |

---

## 2. Folder Structure

```
docs/prd/authentication/
├── README.md                              105 lines   index, status, chapter list, history
├── 01-Introduction.md                      29 lines   Chapter 1  — EMPTY SLOT
├── 02-Authentication-Foundation.md         29 lines   Chapter 2  — EMPTY SLOT
├── 03-Registration.md                      29 lines   Chapter 3  — EMPTY SLOT
├── 04-Login.md                             29 lines   Chapter 4  — EMPTY SLOT
├── 05-Authorization.md                     29 lines   Chapter 5  — EMPTY SLOT
├── 06-Sessions.md                          29 lines   Chapter 6  — EMPTY SLOT
├── 07-Security.md                          29 lines   Chapter 7  — EMPTY SLOT
├── 08-Lifecycle.md                         29 lines   Chapter 8  — EMPTY SLOT
├── 09-Events-Audit-Notifications.md        29 lines   Chapter 9  — EMPTY SLOT
├── 10-Amendments-And-Integration.md        29 lines   Chapter 10 — EMPTY SLOT, title unconfirmed
├── 11-Non-Functional-Requirements.md       29 lines   Chapter 11 — EMPTY SLOT
├── BLOCKER_CLOSURE_v1.0.md                171 lines   HAS CONTENT — GATE-1 decision record
├── FINAL_VALIDATION_REPORT.md              56 lines   HAS CONTENT — evidence + D-7 outcome
├── Authentication_PRD.md                  803 lines   GENERATED — verbatim merge of the above
└── Authentication_PRD_Developer_Guide.md    —         GENERATED — this file
```

Authentication also reaches outside this folder. These are the other files you must know:

| Path | Why it matters to Authentication |
|---|---|
| `docs/architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md` | Canonical for the Identity Triad (`ID-1`…`ID-6`), `BC-18` aggregates/invariants, `iam.*` events, edges `E-11`/`E-12`/`E-13` |
| `docs/architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md` | Laws `L1`–`L5`, ranks `R0`–`R9`, forbidden edges `X-01`–`X-14` |
| `docs/architecture/LIBOORA_ENTERPRISE_ARCHITECTURE.md` | Parent architecture, v2.0, approved and not modifiable by any PRD |
| `docs/prd/MASTER_PRD.md` | Product-level authentication rules `MP-GBR-25`…`27`, `MP-CON-11`, `MP-DEP-03` |
| `tool/module_dependencies.yaml` | Amendments `A-2`–`A-6`, `A-9`; assertions `ID-1`–`ID-9`, `CM-1`–`CM-3` |
| `lib/platform/identity/identity.dart` | The implementation — 372 lines, rank 4 |
| `packages/liboora_contracts/lib/src/errors/domain_error.dart` | 79-member `DomainErrorCode`, `ExternalOutcome`, `ErrorClass` |
| `packages/liboora_contracts/lib/src/value_objects/identifiers.dart` | `AccountId`, `SessionId`, `DeviceId`, `InviteId`, `PermissionId` |
| `packages/liboora_contracts/lib/src/ports/random_source.dart` | `RandomSource` port — the `F-02` fix |
| `test/authentication_conformance_test.dart` | 26 executable regressions |

---

## 3. Chapter Structure

Eleven chapters. Titles marked *unconfirmed* were supplied by the D-7 request, not read off the approved documents — the README says so at lines 66–76 and you should treat them as provisional.

| # | Chapter | File | Title status |
|---|---|---|---|
| 1 | Introduction | `01-Introduction.md` | Unconfirmed |
| 2 | Authentication Foundation | `02-Authentication-Foundation.md` | Unconfirmed |
| 3 | Registration | `03-Registration.md` | Unconfirmed |
| 4 | Login | `04-Login.md` | Unconfirmed |
| 5 | Authorization | `05-Authorization.md` | Unconfirmed |
| 6 | Sessions | `06-Sessions.md` | Unconfirmed |
| 7 | Security | `07-Security.md` | Unconfirmed |
| 8 | Lifecycle | `08-Lifecycle.md` | Unconfirmed |
| 9 | Events, Audit & Notifications | `09-Events-Audit-Notifications.md` | Unconfirmed |
| 10 | *(approved title unknown)* | `10-Amendments-And-Integration.md` | **Not supplied** |
| 11 | NFRs, Compliance & Final Acceptance | `11-Non-Functional-Requirements.md` | **Confirmed** |

**The numbering deviation you will inherit.** The D-7 request listed *ten* chapter files for *eleven* approved chapters and filed the NFR chapter as `10-`. Merging chapters was forbidden (D-7 rule 9) and numbering had to be preserved (D-7 rule 4), so Chapter 10 was given its own file and Chapter 11 was numbered 11. Two decisions remain open for an owner, per README lines 78–83:

1. the approved title and correct filename of Chapter 10;
2. whether the D-7 file list is corrected from ten slots to eleven.

Do not silently resolve either. They are owner decisions.

---

## 4. Specification Organization

Each chapter file has an identical four-part shape. Learn it once:

1. **`# Chapter N — Title`** — the H1.
2. **A blockquote warning banner** — states that the chapter is APPROVED but the file is an EMPTY SLOT, and that reconstructing it from memory would be regeneration.
3. **`## Transfer instruction`** — the transfer rule (*"Do not renumber. Do not reformat. Do not summarise."*) plus chapter-specific metadata.
4. **The marker pair:**
   ```
   <!-- ===== BEGIN APPROVED CHAPTER N CONTENT — PASTE VERBATIM BELOW ===== -->

   <!-- ===== END APPROVED CHAPTER N CONTENT ===== -->
   ```

**The metadata in part 3 is the single most valuable thing in the shell.** Three chapters carry substantive notes:

| Chapter | Metadata recorded in the stub |
|---|---|
| **2** | Defect `D-9`: this chapter's exception register uses band `EC-01…EC-48` and is scheduled for renumbering to an `EC-2xx` band on consolidation. **Transfer `EC-01…EC-48` as approved. Do not renumber during transfer.** `D-9` stays open. |
| **9** | Amendment `A-4` references the closed 36-fact event register `EVT-1001…EVT-1036`, whose member names were never available. `tool/module_dependencies.yaml` therefore *references* this register (`event_register_source: docs/prd/authentication`) rather than duplicating it. **That pointer does not currently resolve.** |
| **10** | Structural deviation notice. This chapter is the source of amendments `A-2`, `A-3`, `A-4`, `A-5`, `A-6`. |
| **11** | Full register-allocation inventory (see §6). Title confirmed. |

---

## 5. Identifier Conventions

Identifiers are **prefix + number**, allocated in per-chapter bands, and are never reused or renumbered. The prefixes below are all attested in the workspace.

**Specification registers** (from the Chapter 11 stub inventory and the closure record):

| Prefix | Meaning | Band attested |
|---|---|---|
| `NPB` | Non-functional — *(expansion not recorded in workspace)* | `NPB-1…9` |
| `NPO` | Non-functional — *(expansion not recorded)* | `NPO-1…12` |
| `NSP` | Non-functional — *(expansion not recorded)* | `NSP-1…12` |
| `PERF` | Performance | `PERF-1101…1134` |
| `AVL` | Availability | `AVL-1101…1128` |
| `SCL` | Scalability | `SCL-1101…1137` |
| `OBS` | Observability | `OBS-1101…1126` |
| `CMP` | Compliance | `CMP-1101…1154` |
| `ERR` | Error taxonomy | `ERR-1101…1136` |
| `BCP` | Business continuity | `BCP-1110…1140` |
| `CON` | Constraint | `CON-1101…1188` |
| `FAC` | Final acceptance criteria | `FAC-1101…1162` |
| `OOS` | Out of scope | `OOS-1101…1153` |
| `FUT` | Future | `FUT-1101…1135` |
| `EVT` | Event register (Ch. 9) | `EVT-1001…EVT-1036` |
| `EC` | Exception cases (Ch. 2) | `EC-01…EC-48` — see `D-9` |

**Governance identifiers:**

| Prefix | Meaning | Examples attested |
|---|---|---|
| `GATE` | Acceptance gate | `GATE-1`, `GATE-2`, `GATE-3` |
| `CFL` | Conflict | `CFL-21`, `CFL-22`, `CFL-24`, `CFL-26`, `CFL-28`, `CFL-30`, `CFL-31`; band `CFL-29…CFL-37` in Ch. 11 |
| `A-` | Amendment | `A-1`…`A-9` |
| `F-` | Defect (found in review) | `F-01`, `F-02` |
| `D-` | Defect (documentation/task) | `D-1`…`D-10` |
| `QA` | Open question | `QA-13`, `QA-24` |
| `AS` | Assumption | `AS-09` |
| `THR` | Threat | `THR-805.5`, `THR-806`, `THR-808.6` |
| `SBR` | *(security behavioural rule — expansion not recorded)* | `SBR-887`, `SBR-888` |
| `RBD` / `AZ` / `SC` / `BR` / `SSP` / `NTF` / `DC` | Referenced in the closure record; expansions not recorded in the workspace | `RBD-12`, `AZ-704`, `SC-305`–`SC-308`, `BR-514`, `SSP-4`, `NTF-1012`–`NTF-1017`, `DC-2`, `DC-3` |

**Architecture identifiers** (from the context map and matrix): `BC-01`…`BC-31`, `ID-1`…`ID-6`, `E-01`…`E-26`, `F-1`…`F-4`, `L1`–`L5`, `R0`–`R9`, `X-01`–`X-14`, `Q-01`…`Q-07`.

**Master PRD identifiers:** the `MP-*` namespace (`MP-GBR`, `MP-CON`, `MP-NFR`, `MP-ASM`, `MP-RSK`, `MP-DEP`, `MP-SM`, `MP-CFL`, `MP-DUP`, `MP-SCOPE`), deliberately disjoint from the specification prefixes above so the two documents can never collide.

> **Honest gap.** For many prefixes the workspace records the *band* but not the *member text*. `FINAL_VALIDATION_REPORT.md:31` states this directly for `EVT-1001`–`EVT-1036`: *"whose member names were never available."* Do not reconstruct member texts. Request them.

---

## 6. Requirement Numbering

Four rules, all attested:

1. **Bands are per-chapter and contiguous.** Chapter 11 owns `PERF-1101…1134`, `AVL-1101…1128`, and so on. A new performance requirement extends the band; it never reuses a retired number.
2. **Numbering is preserved across moves.** D-7 rule 4. This is why Chapter 11 is numbered 11 even though the request filed it as 10, and why `EC-01…EC-48` must transfer unchanged despite `D-9` scheduling a future renumber.
3. **Renumbering is a separate, tracked act.** `D-9` exists precisely so that the `EC-01…EC-48` → `EC-2xx` move happens once, deliberately, under its own defect — not incidentally during a transfer.
4. **Registers are closed where declared closed.** `ExternalOutcome` is closed at seven members, `AccessScope` at three, `Permission` at ten, `EVT-*` at thirty-six. A closed register is not extended by a call site or by configuration — `identity.dart:69–70` states this for `Permission`: *"This catalogue is **closed**: it is not extensible by a tenant, by configuration, or at a call site."*

---

## 7. Business Rule Mapping

The following authentication rules are **enforced in code today** and each one traces to a specification identifier recorded in `BLOCKER_CLOSURE_v1.0.md`.

### 7.1 Authorization — defect `F-01`, closed

Violated `RBD-12`, `AZ-704`, `THR-808.6`, `CON-1141`, `CON-1146`.

The grant table changed **shape, not content**: `Map<AccessRole, Set<Permission>>` → `Map<AccessRole, Map<Permission, AccessScope>>`. The closure record states the point of the fix exactly: *"There is now no way to express an unscoped grant."*

| Rule | Where enforced |
|---|---|
| Every grant declares a scope from the closed register `{self, guardianOf, tenantWide}` | `identity.dart:112–146`; assertion `ID-8`; test *"every grant in the catalogue declares a scope"* |
| `student` → `viewStudent` at `self` | `identity.dart:144` |
| `parent` → `viewStudent` at `guardianOf` | `identity.dart:145` |
| Staff roles → `tenantWide`, unchanged | `identity.dart:113–142` |
| A scoped grant cannot be exercised without naming a resource | `require()` refuses; `requireOn()` is the only passing path |
| A scoped denial is **indistinguishable from not-found** | `authzScopeOutsideSubject` → `xNotFound`, never `xDenied` (`CON-1146`, `SBR-887`/`888`) |

### 7.2 Challenge issuance — defect `F-02`, closed

Violated `SC-305`–`SC-308`, `BR-514`, `THR-805.5`, `CON-1121`, `CON-1123`.

| Sub-defect | Correction | Enforced at |
|---|---|---|
| `requestOtp` returned `false` for unknown numbers | Returns **`void`** — *"the signature is the fix"* | `identity.dart:307` |
| Oracle repeated at two higher layers | Controller no longer sets an error; UI no longer branches; the string *"No Liboora account is registered for this number."* is deleted | `session.dart`, `login_screen.dart` |
| Code = `phone.hashCode` | Drawn digit-by-digit from `RandomSource`; `SecureRandomSource` lives in the adapter layer because the kernel may not import `dart:math` (law `L5`) | `identity.dart:234–241`, `365–371`; assertion `ID-9` |
| No TTL | `challengeTtl` enforced against the injected `Clock` | `identity.dart:277`, `335–338` |
| No attempt limit | `maxVerifyAttempts`; exhaustion discards the challenge | `identity.dart:278`, `340–344` |
| Debug peek was a public field | `lastIssuedOtp` removed; `debugPeekChallenge()` returns null unless `challengePeekEnabled`, derived by DI from `!dart.vm.product` | `identity.dart:288`, `323–324` |

**Adapter defaults are configuration, not specification.** `challengeTtl` = 5 min, `maxVerifyAttempts` = 5, 6 numeric digits (TRAI DLT). The closure record is explicit: *"The normative values remain the locked registers'."* If the chapters give different bounds, **the chapters win** and these constants change.

### 7.3 Entitlement gating — `QA-13`, resolved

**Ruling: fail closed for entitlement-gated mutations. Fail-open is not available.** Derived — not decided — from `AVL-1114` (*an absent input may narrow a decision and may never widen it*), `BCP-1135` (*where a decision cannot be rendered correctly, it is refused*), and the non-escalation guardrail `CON-1143`.

| Path | Effect of entitlement unavailability |
|---|---|
| Authenticate / establish session | **None** (`AVL-1107`) |
| Validate session | **None** |
| Non-entitlement authorization decision | **None** |
| Read a resource | **None** — reads are not gated |
| Entitlement-gated **mutation** | **Refused** |

Refusal shape: class `AUTHZ` (`ERR-1111`), code `authzEntitlementGateRefused`, projection `xDenied` (`ERR-1130`), **not** `xTemporaryFailure`. Enforced by construction — `AuthService` takes no entitlement dependency.

### 7.4 Notification address — `QA-24`, resolved

Port `platform/identity:notification_address`. Consumer: `platform/communication` (BC-22) **only**. Input: one `AccountId` + one declared delivery purpose. Output: one address for one already-queued delivery, **at delivery time, never at emission time**. Listing, bulk, enumeration, existence testing and caller retention are all **forbidden**. Derived from `CON-1177`, `NTF-1012`–`NTF-1017`, `CMP-1116`, `OBS-1104`. Assertions `CM-1`, `CM-2`, `CM-3`.

### 7.5 Identity Triad — `ID-1`…`ID-6`

| Rule | Statement | Enforcement named in the map |
|---|---|---|
| `ID-1` | No context outside BC-18 may store a password, OTP, session or credential | Security review + schema scan in CI |
| `ID-2` | `StudentRecordId` **never** leaves its tenant | Cross-tenant leak test suite |
| `ID-3` | Social contexts key exclusively on `PersonId` | ACL at Global Student boundary |
| `ID-4` | Library contexts key exclusively on `StudentRecordId`; may hold a nullable `PersonId` and must degrade gracefully when null | Nullable by design; tests assert the null path |
| `ID-5` | Account deletion deletes the `Account` and anonymises the `Person`; it does **not** delete `StudentRecord` financial/attendance history | Data Privacy runbook + retention policy |
| `ID-6` | A minor's `Account` is linked to a guardian consent record before any social context is activated | BC-18 Consent Management gate |

`Account.personId` is `PersonId?` — nullable — with the comment *"an account may never opt into the social product"* (`identity.dart:42–43`). That nullability is `ID-4` made structural.

---

## 8. Event Mapping

**The event register itself is not in the repository.** Chapter 9 holds `EVT-1001…EVT-1036` and Chapter 9 is empty. What *is* declared is the part a boundary checker can enforce.

**Naming convention** (context map): `<Context>.<Aggregate><PastTenseVerb>`. BC-18 emits under the `iam.*` namespace. Attested members: `iam.AccountCreated`, `iam.SessionRevoked`, `iam.ConsentGranted`, `iam.AccountVerified`, `iam.AccountStatusChanged`.

**Emission classes** — amendments `A-4`, `A-5`, `A-9`, declared at `tool/module_dependencies.yaml:378–390`:

| Class | Meaning | Transport | Consumers |
|---|---|---|---|
| **D** | Domain fact | Outbox event | `domain/library`, `platform/audit`, `platform/communication` — declared per event |
| **A** | Audit-only fact | event | `platform/audit` **only** — *"any consumer other than platform/audit is a boundary violation, not a subscription"* |
| **T** | Telemetry | **none** | **none** — *"no transport, no subscriber, no export; egress attempt is a blocker"* |

**Assertions:**

| ID | Rule |
|---|---|
| `ID-1` | Every emitted `iam.*` fact appears in the closed register `EVT-1001..EVT-1036` |
| `ID-2` | Every Class D fact declares named consumers; a fact with no declared consumer is Class A or Class T |
| `ID-3` | No Class A fact has a consumer other than `platform/audit` |
| `ID-4` | No Class T value is published, exported or subscribed to |
| `ID-5` | No event payload contains a mobile number, challenge value, session token or key material |
| `ID-6` | The audit fact commits in the same transaction as the state change it describes |
| `ID-7` | Every grant is tenant-scoped; no grant event without a `TenantId` |
| `ID-8` | No permission granted without a scope from `{self, guardianOf, tenantWide}` |
| `ID-9` | No challenge value is a function of its subject; `RandomSource` only |

`platform/analytics` carries `excluded_events: ["iam.*"]` (amendment `A-6`, assertion `AN-3`) — explicit, because a wildcard subscription would otherwise pull authentication facts into analytics silently.

> **Live broken reference.** `event_register_source: docs/prd/authentication` points at a register that does not exist yet. README line 103 flags it as an *"Unresolved reference."* It resolves the moment Chapter 9 is transferred.

---

## 9. Aggregate Mapping

From the bounded context map, line 370:

| Context | Aggregate roots | Entities | Synchronous invariants |
|---|---|---|---|
| **BC-18 Identity & Access** | `Account`, `AccessPolicy` | `Credential`, `AuthSession`, `Device`, `ConsentRecord` | One active credential set per account · OTP single-use with TTL · session revocation immediate and global · minor guardian consent precedes social activation |

Implemented today in `lib/platform/identity/identity.dart`:

| Construct | Kind | Notes |
|---|---|---|
| `Account` | `final class` | Credentials only. Fields: `AccountId id`, `String phone`, `String displayName`, `Map<String, Set<AccessRole>> roles` (tenant-scoped), `PersonId? personId` |
| `AuthSession` | `final class` | `SessionId id` (opaque, *"Never a log or metric dimension"*), `Account`, `TenantId`, `BranchId`, `AccessRole activeRole`, `DateTime startedAt` |
| `PolicyDecisionPoint` | `final class`, const | The `AccessPolicy` aggregate's decision surface. `allows` / `scopeOf` / `require` / `requireOn` |
| `AuthService` | `final class` | Possession-of-number authentication. `requestOtp` / `verifyOtp` / `debugPeekChallenge` |
| `_Challenge` | private `final class` | Single-use, time-bounded, attempt-bounded |
| `SecureRandomSource` | `final class` | `RandomSource` adapter wrapping `Random.secure()` |

`Credential`, `Device` and `ConsentRecord` are named in the map as BC-18 entities but **are not implemented**. That is a known gap, not an omission from this guide.

---

## 10. Entity Relationships

The **Identity Triad** (context map §4) is the relationship model you must internalise. Three identifiers that look similar and are absolutely not interchangeable:

| Concept | Identifier | Owner | Scope | Lifecycle |
|---|---|---|---|---|
| **Account** | `AccountId` | BC-18 Identity & Access | Global, cross-tenant | Created on first successful OTP. Destroyed on account deletion. **Credentials only.** |
| **Person** | `PersonId` | BC-10 Global Student Identity | Global | **Opt-in — may never exist.** |
| **Student record** | `StudentRecordId` | BC-01 Enrollment | **Per-tenant** | **Never leaves its tenant** (`ID-2`) |

```
AccountId  1 ──── 0..1  PersonId          (an account may never opt into social)
AccountId  1 ──── 0..*  StudentRecordId   (one login, many library enrollments)
```

**Integration edges:**

| Edge | From → To | Pattern | Contract |
|---|---|---|---|
| `E-11` | BC-18 → BC-01 Enrollment | `CF`, sync port | `AccountId` resolution on login; Enrollment stores it, never mutates it |
| `E-12` | BC-18 → BC-10 Global Identity | `CF`, sync port | `AccountId` → `PersonId` creation on social opt-in |
| `E-13` | BC-01 → BC-10 | **`ACL`** | User-consented link. *"The only bridge between the two worlds."* Enrollment stores nullable `personId`; Global Identity stores **no** `StudentRecordId` |

**Tenancy model.** BC-18 is **hybrid**: `Account` is global, role assignments are tenant-scoped, and *"`AccessPolicy` is always evaluated with a tenant in scope"* (map line 473). This is why `Account.roles` is keyed by tenant and why `rolesIn(TenantId)` exists.

**Typed identifiers are non-interchangeable by construction** (amendment `A-8`). `DeviceId`, `SessionId`, `InviteId` and `PermissionId` are `Identifier` subtypes; the test *"same value, different type, never equal"* asserts `DeviceId('x') != SessionId('x')`.

---

## 11. Cross Reference Strategy

Four conventions, all observable in the existing files:

1. **Reference by identifier, never by page or paragraph.** The closure record cites `AVL-1114`, `BCP-1135`, `CON-1143` — not "as discussed in Chapter 11".
2. **Every ruling names the identifiers it derives from.** Constraint `C-4` of the closure record: *"Every ruling derives from an already-locked identifier; none is an independent decision."* Where a ruling could not be derived, the process required escalation as an Architecture Change Request. **No ACR was required.** Preserve this discipline.
3. **Reference registers; never duplicate them.** From the manifest, verbatim: *"The authoritative register is the closed 36-fact Authentication event register (EVT-1001..EVT-1036). It is NOT duplicated here: duplication is how two registers drift apart."*
4. **Code cites the specification in comments.** `identity.dart` cites `CON-1146`, `SBR-887/888`, law `L5`, `A-8`, `F-01`, `F-02`, `X-09`. Tests cite the register entry they guard, so *"a reviewer can read the test name and know which register entry it guards."*

---

## 12. Dependency Rules

`platform/identity` sits at **rank 4**. The five laws in `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` are binding; `L1` (no cycles) is marked **never overridable**.

Manifest block, `tool/module_dependencies.yaml:345–413`:

```yaml
platform/identity:
  rank: 4
  imports:
    - { target: contracts, mode: import }
  ports:
    - platform/tenancy:tenant_context
    - platform/integration:sso_provider   # sanctioned bypass, challenge delivery only
  banned_imports: ["domain/**", "app/**"]
```

**Ports provided** — *"Both are deliberately narrower than a general identity API."*

| Port | Consumers | Constraint |
|---|---|---|
| `policy_decision` | `domain/library`, `domain/social`, `platform/ai`, `platform/analytics`, `platform/workflow` | — |
| `auth` | `app` | — |
| `account_directory` (`A-2`) | `domain/library` | single `AccountId` in, single resolution out; **no listing, no lookup by number, no existence test** |
| `notification_address` (`A-3`) | `platform/communication` | one address, one queued delivery, resolved at delivery time, **never retained by the caller** |

**Global rules that bite Authentication hardest:**

- `barrel_only_cross_module: true` — import `<module>.dart`, never internals.
- `default_decision: deny` — anything not listed is forbidden.
- `tenant_key_required_in`: cache keys, search index names, vector namespaces, storage prefixes, projection table names. Violation severity: **blocker** (`X-13`).
- **The observability plane** (`A-9`) — `classification_ceiling: DC-2`; `is_authoritative_for: []` (*nothing*); 30-day retention; violation severity **blocker**. Banned content includes mobile numbers in any form or transform, challenge values (current, expired **or hashed**), session tokens, device secrets, key material, consent document content, guardian relationship detail, subject free text, **and remaining attempt budget / lockout remainder / grace remainder**. Banned metric dimensions: `AccountId`, `PersonId`, `StudentRecordId`, `SessionId`, `DeviceId`, mobile number, any subject-derived value. Allowed: `function`, external outcome (projection only, never internal class), `TenantId`, `plane`, deployment locus. Forbidden inferences: whether a number corresponds to an account; whether a denial was a denial or a not-found; which control is degraded.
- **`exceptions: []`** — still empty, deliberately. None of the nine amendments is an exception to a law: *"A law exception would require an ADR and an expiry; none was needed."*

**Law `L5` in practice.** The shared kernel `packages/liboora_contracts` has an empty `dependencies:` block, compiler-enforced. It may not import `dart:math`. That is precisely why `RandomSource` is a port in the kernel and `SecureRandomSource` is an adapter in `platform/identity`.

---

## 13. Validation Workflow

The workflow that produced `FINAL_VALIDATION_REPORT.md` separates **measurements** from **judgements**, and you should keep that separation.

**§1 — machine-verified.** Every row is a command and its output:

| Check | Command | Result |
|---|---|---|
| Static analysis | `flutter analyze` | `No issues found!` — exit 0 |
| Baseline suite | `flutter test test/widget_test.dart` | `+9` — All tests passed |
| Conformance suite | `flutter test test/authentication_conformance_test.dart` | `+26` — All tests passed |
| Total | — | 35 passing tests |

**§2 — explicitly NOT machine-verified**, *"recorded so that no reader mistakes a judgement for a measurement."* Includes: that each amendment *fully discharges* its intent; `QA-13`/`QA-24` rulings (authored, not externally attested); `AS-09` accepted by non-contradiction only; "Architecture Complete = YES" self-assessed against gates authored in the same effort over chapters that are not yet files.

**The most important row in §2:** the manifest assertions `ID-1`–`ID-9`, `CM-1`–`CM-3`, `AN-3`, `AU-2`–`AU-4` are **declarative only**. *"No checker consumes the file; `tool/` contains no `check_module_boundaries.dart`."* Confirmed still true: `tool/` contains exactly one file. Tracked as `MP-DEP-06`, mitigating risk `MP-RSK-06`.

**Known internal inconsistency, carried forward:** `ERR-1113` names `X-DEVICE-REFUSED`, which is absent from the closed seven-member set in `ERR-1130`. Implemented per `ERR-1130`. Do not "fix" this — it needs a review-authority ruling.

**Gates.** `GATE-1` is cleared: 14 blockers closed with 0 chapters modified, 0 identifiers renumbered, 0 new conflicts/amendments/assumptions/open questions/defects, 0 ACRs. `GATE-2` and `GATE-3` are named in the Chapter 11 inventory but their criteria are in the untransferred chapter.

---

## 14. Versioning Process

| Field | Value | Source |
|---|---|---|
| Specification version | **v1.0 (lock candidate)** | `README.md:17` |
| Directory status | **TRANSFER PENDING — NOT LOCKED** | `README.md:24` |
| Manifest version | `version: 1` | `tool/module_dependencies.yaml:17` |
| Master PRD | v1.1, commit `218142a` | `MASTER_PRD.md` |
| Enterprise Architecture | v2.0 — approved, final, **not modifiable by any PRD** | `MASTER_PRD.md:29` |
| Bounded Context Map | v1.0, dated 2026-07-30 | map line 520 |

**Lock criteria** (`README.md:33–38`) — `Status` becomes `LOCKED` only when **both** hold:

1. All eleven chapter files contain their approved text between the `BEGIN`/`END APPROVED CHAPTER CONTENT` markers.
2. The identifier-preservation check in `FINAL_VALIDATION_REPORT.md` has been run against the transferred text **and passes**.

Until then the directory is a *custody shell* and the authoring channel remains the only complete copy.

**Version-tag semantics** (EA §10.3, normalised into the Master PRD §32): **V1** = MVP · **V2** = Growth · **V3** = Enterprise · **Future** = Ecosystem. Do not reintroduce "Phase 1/2/3" — that vocabulary was deliberately retired.

**Change history is recorded in a table**, not in commit messages alone (`README.md:85–90`). Add a row.

---

## 15. How to Safely Modify the Authentication PRD

**The single most important rule: you are almost certainly not authorised to modify it.** The chapters are approved and locked. The correct action for nearly every change is to raise an identifier, not to edit prose.

**The five constraints that governed the last change**, and that you should assume govern yours (`BLOCKER_CLOSURE_v1.0.md:9–15`):

| # | Constraint |
|---|---|
| `C-1` | No new functional requirement, business rule, bounded context, user role or authentication method |
| `C-2` | No locked chapter rewritten, no identifier renumbered |
| `C-3` | No new conflict, amendment, assumption, open question or defect |
| `C-4` | Every ruling derives from an already-locked identifier; none is an independent decision |
| `C-5` | Only artifacts named in the task scope modified |

**Decision procedure:**

1. **Is the chapter text present?** If the file is still an empty slot — you cannot modify it. Perform the transfer first (see below). Do not author into the slot.
2. **Can your change be derived from already-locked identifiers?** If yes, it is a *ruling*: record it in a decision record, cite the identifiers it derives from, and change nothing in the chapters. This is exactly the shape of `QA-13` and `QA-24`.
3. **If it cannot be derived** — it is an **Architecture Change Request**. Escalate. Do not proceed. The last effort resolved 14 blockers with **zero** ACRs; treat needing one as a signal, not a formality.
4. **If it is a defect** — file it as `F-nn` (specification defect) or `D-nn` (documentation/task defect), fix the *code* to match the specification, and add a regression test named after the register entry it guards.

**Performing a chapter transfer:**

- Paste the approved text **between** the `BEGIN`/`END` markers. Leave the markers in place.
- Do not renumber. Do not reformat. Do not summarise. (Stated in every stub.)
- Transfer `EC-01…EC-48` exactly as approved even though `D-9` schedules a renumber. The renumber is a separate act.
- Confirm Chapter 10's approved title and correct its filename **at transfer time**, and get the D-7 file list corrected from ten slots to eleven.
- Run the identifier-preservation check before touching `Status`.
- Update `README.md`: the Document index state column, the Chapter list title-source column, and the Change history table.
- Only then set `Status = LOCKED`, and only if criterion 2 passed.

---

## 16. How to Add New Specifications

**Adding to an existing register:** extend the band contiguously; never reuse a retired number; add the member to the register in its owning chapter, not to a second location.

**Adding a new error condition** — the compiler enforces the process. Amendment `A-7` made the projection exhaustive: *"Adding a code cannot compile until its class and projection are declared."* So:

1. Append to `DomainErrorCode` in `packages/liboora_contracts/lib/src/errors/domain_error.dart`. **Append only — the enum is additive-only, never interleaved.**
2. Declare its `ErrorClass` (one of: `auth`, `authz`, `session`, `device`, `lifecycle`, `validation`, `system`, `domainBusiness`).
3. Declare its `ExternalOutcome` from the **closed seven**: `xUniformAuth`, `xSessionInvalid`, `xDenied`, `xNotFound`, `xNotPermitted`, `xInvalidRequest`, `xTemporaryFailure`.
4. Respect the projection invariants asserted by tests: every `auth` code projects `xUniformAuth`; every `session` code projects `xSessionInvalid`; **only** `system` codes are retriable.
5. It will not compile until 2 and 3 are done. That is the design.

**Adding a new port:** declare it under `provides_ports` with `consumers` and a `constraint` string. Both existing amendment ports carry explicit narrowing constraints — follow that pattern. A port with no constraint is a general API, and the manifest comment says both were made *"deliberately narrower than a general identity API."*

**Adding a new event:** it must appear in the closed register `EVT-1001…EVT-1036` (assertion `ID-1`), declare its emission class, and — if Class D — declare its named consumers (assertion `ID-2`). It must not carry a mobile number, challenge value, session token or key material (assertion `ID-5`).

**Adding a permission or a scope:** both catalogues are **closed**. `Permission` has ten members; `AccessScope` has exactly three. Extending either is a specification change, not an implementation change. The test *"every grant in the catalogue declares a scope"* loops the full catalogue, so an unscoped addition fails CI immediately.

**Adding a dependency:** `default_decision: deny`. Add it to the manifest allow-list first, or it is forbidden. Do not add an entry to `exceptions:` — it has been empty by design since v1.0, and an exception requires an ADR and an expiry.

---

## 17. Review Checklist

Run this before requesting review on any Authentication change.

**Mechanical:**
- [ ] `flutter analyze` → `No issues found!`, exit 0
- [ ] `flutter test test/authentication_conformance_test.dart` → 26 passing
- [ ] `flutter test test/widget_test.dart` → 9 passing
- [ ] `dart format .` clean
- [ ] Working tree committed; change history table updated

**Specification integrity:**
- [ ] Locked chapters modified: **0** (or an ACR is attached)
- [ ] Identifiers renumbered: **0**
- [ ] New conflicts / amendments / assumptions / open questions / defects: **0** (or each is registered)
- [ ] Every ruling names the locked identifiers it derives from
- [ ] No register duplicated — referenced instead

**Security invariants** (these are the ones that were actually violated before):
- [ ] No new enumeration oracle — no response, timing, or error distinction reveals whether a number is registered
- [ ] No grant expressible without a scope
- [ ] Every scoped denial projects `xNotFound`, never `xDenied`
- [ ] No challenge value derived from its subject
- [ ] Nothing on the banned-content list reaches logs, metrics or traces — including *hashed* challenge values and remaining attempt budgets
- [ ] No `AccountId`/`PersonId`/`StudentRecordId`/`SessionId`/`DeviceId` used as a metric dimension
- [ ] No credential, OTP or session stored outside BC-18 (`ID-1`)
- [ ] No `StudentRecordId` in any global context, event or index (`ID-2`)
- [ ] Every cache key, index name, namespace, storage prefix and projection table carries a tenant key
- [ ] No demo, guest or test account path reachable in a release build (`MP-CON-11`; note `D-10` below)

---

## 18. Common Pitfalls

**1. Returning a boolean from a challenge request.** This was `F-02`. Any success/failure signal is an enumeration oracle. The fix was to make the return type `void` — *"the signature is the fix."* Do not add a status object, a nullable result, or a distinct error.

**2. Fixing the oracle in one layer only.** `F-02` was repeated at **three** layers: service, controller, and UI. The user-facing string *"No Liboora account is registered for this number."* was itself the leak. When you close an oracle, walk the whole stack.

**3. Granting a permission without a scope.** This was `F-01` — `viewStudent` was `tenantWide` *by omission* for `student` and `parent`, meaning any student could read any student. The type system now forbids it. Do not add a convenience overload that reintroduces it.

**4. Projecting a scoped denial as `xDenied`.** `xDenied` means *"on a resource whose existence the caller already legitimately knows."* Using it for a `self`/`guardianOf` miss turns the response into an existence oracle. The test *"a scoped denial is indistinguishable from not-found"* guards this.

**5. Assuming `PersonId` exists.** It is nullable by design and *"an account may never opt into the social product."* Library contexts must degrade gracefully on null (`ID-4`).

**6. Treating adapter constants as specification.** `challengeTtl = 5 min` and `maxVerifyAttempts = 5` are *"configuration of the locked bounds, not restatements of them."*

**7. Duplicating a register.** *"Duplication is how two registers drift apart."* Reference it.

**8. Trusting the manifest assertions to be enforced.** They are **declarative only**. No checker consumes `tool/module_dependencies.yaml`. Reading `ID-8` in the manifest does not mean `ID-8` is enforced — the enforcement that exists is in the *type system and the tests*, not the manifest.

**9. Making the observability plane authoritative.** `is_authoritative_for: []`. Retention is 30 days. *"It may always be deleted; therefore nothing may live only there."*

**10. Logging a hashed challenge.** The banned-content list says *"challenge value, current, expired **or hashed**."* Hashing is not redaction here.

**11. Adding a wildcard event subscription.** `platform/analytics` needed an explicit `excluded_events: ["iam.*"]` because `"*"` *"would otherwise silently subscribe it."*

**12. Renumbering `EC-01…EC-48` during transfer.** `D-9` schedules that renumber as its own act. Doing it during a transfer violates D-7 rule 4.

---

## 19. Handover Notes

**What you are receiving, honestly:**

| Asset | State |
|---|---|
| Chapters 1–11 | ❌ **Not present.** Eleven empty slots, 0 body characters each. Not in the working tree, not in Git history (all 275 objects scanned). |
| Final Validation Report Revision 2 | ❌ Not present. `FINAL_VALIDATION_REPORT.md` §3 is an empty transfer slot. |
| GATE-1 blocker closure record | ✅ Complete, 171 lines — the richest surviving specification source |
| Machine-verified evidence | ✅ Complete |
| Manifest amendments `A-2`–`A-6`, `A-9` | ✅ Declared in `tool/module_dependencies.yaml` |
| Amendments `A-1`, `A-7`, `A-8` | ✅ Implemented in the shared kernel |
| Defect fixes `F-01`, `F-02` | ✅ Implemented and regression-tested |
| Conformance suite | ✅ 26 tests, all passing |
| Identity Triad, aggregates, edges, invariants | ✅ In the bounded context map |
| Event register `EVT-1001…EVT-1036` | ❌ **Member names were never available.** Only the emission-class structure survives. |
| Register member texts (`PERF-*`, `AVL-*`, `CON-*`, `FAC-*`, …) | ❌ Band allocations only |
| Boundary checker | ❌ Not implemented (`MP-DEP-06`) |

**Open defects and decisions you inherit:**

| ID | Status | Description |
|---|---|---|
| `D-7` | **OPEN** | Chapters 1–11 not committed. Blocks the documentation lock. |
| `D-8` | Open | 14 unassigned QA items need gate assignment |
| `D-9` | Open | Chapter 2 `EC-01…EC-48` scheduled for renumber to `EC-2xx` |
| `D-10` | **Open — release blocker** | `kDemoChildPhone = '9810000004'` still present in `lib/app/session.dart`. Directly contradicts `MP-CON-11` (*no demo or guest accounts in any release build*). |
| `MP-DEP-06` | Not implemented | Boundary checker; `tool/` has no `check_module_boundaries.dart` |
| `ERR-1113` | Unresolved | Names `X-DEVICE-REFUSED`, absent from the closed set in `ERR-1130` |
| Chapter 10 | Undecided | Approved title and filename unknown |
| D-7 file list | Undecided | Ten slots listed for eleven chapters |
| `GATE-2` | Pending | `QA-14`…`QA-23`, `AS-17`, `AS-23` await rulings |
| `AS-09` | Accepted, conditional | Lapses if `CON-1120`, `CFL-30` or the `THR-806` verdict changes |
| `event_register_source` | Broken pointer | Resolves only when Chapter 9 transfers |

**Two manifest defects found during this recovery**, not previously recorded:

1. `tool/module_dependencies.yaml:57` declares `contracts: path: lib/contracts`. **That directory does not exist** — the shared kernel is `packages/liboora_contracts/`. A checker written faithfully against the manifest would scan nothing and pass rank 0 silently.
2. `default_decision: deny`, yet five real directories have **no manifest block**: `lib/bootstrap`, `lib/platform/data`, `lib/platform/event`, `lib/platform/observability`, `lib/platform/services`. Four manifest blocks have no directory: `platform/ai`, `platform/workflow`, `platform/search`, `platform/communication`.

**Your first action should be to obtain the approved chapter text.** Everything else is secondary. Until `D-7` closes, this project's authentication specification lives outside version control, which the Master PRD's own `MP-CON-15` identifies as the failure mode: *"A specification that exists only in conversation is not a specification."*

---

## 20. Repository Maintenance Guidelines

**Commit conventions** — observed across the eight commits in this repository:

```
docs(prd):          Master PRD changes
docs(auth):         Authentication documentation
docs(architecture): Architecture documents
feat(auth):         Authentication implementation
feat(scaffold):     Structural work
fix(naming):        Corrections
```

Bodies are substantive. Commit `218142a` enumerates each conflict corrected, each duplicate merged, and each section added. Follow that.

**Repository state at the time of this guide:** branch `main`, HEAD `218142a`, working tree clean, 8 commits, one remote (`genspark`, auto-backup).

**Standing rules:**

- **Never regenerate an existing specification.** If it exists in the workspace, cite it. If it does not, report the gap. This is the rule that produced empty slots instead of plausible-looking chapters, and it was the correct call.
- **Never declare a lock you cannot substantiate.** `Status = LOCKED` was explicitly refused because it would have been false.
- **Keep judgements separate from measurements.** The validation report's §1/§2 split is the template.
- **`exceptions:` stays empty.** Every widening so far was an allow-list extension or an assertion, not a law exception. Keep it that way; if you cannot, write the ADR and set an expiry.
- **Run `flutter analyze` and both test suites before every commit.** The clean-analyzer baseline was deliberately restored during `F-01`/`F-02` work and is worth preserving.
- **Do not update Flutter or Dart.** The environment is version-locked at Flutter 3.35.4 / Dart 3.9.2.
- **Vendor neutrality is enforced.** A grep for `supabase|postgres|openai|railway|drift|sqlite|isar` across the architecture returns zero. Only `Firebase Cloud Messaging (V1)` and `Firebase Crashlytics (V1)` are named. Keep vendors behind ports.
- **Treat `docs/architecture/` as read-only from a PRD.** The Enterprise Architecture v2.0 is *"approved, final, not modifiable by this PRD."*

---

## Appendix A — Verified file inventory

| File | Bytes | Lines | Content state |
|---|---|---|---|
| `README.md` | 5,758 | 105 | Complete |
| `01-Introduction.md` | 1,342 | 29 | **Empty slot** |
| `02-Authentication-Foundation.md` | 1,548 | 29 | **Empty slot** |
| `03-Registration.md` | 1,284 | 29 | **Empty slot** |
| `04-Login.md` | 1,277 | 29 | **Empty slot** |
| `05-Authorization.md` | 1,285 | 29 | **Empty slot** |
| `06-Sessions.md` | 1,280 | 29 | **Empty slot** |
| `07-Security.md` | 1,280 | 29 | **Empty slot** |
| `08-Lifecycle.md` | 1,281 | 29 | **Empty slot** |
| `09-Events-Audit-Notifications.md` | 1,655 | 29 | **Empty slot** |
| `10-Amendments-And-Integration.md` | 1,666 | 29 | **Empty slot** |
| `11-Non-Functional-Requirements.md` | 1,836 | 29 | **Empty slot** |
| `BLOCKER_CLOSURE_v1.0.md` | 12,334 | 171 | Complete |
| `FINAL_VALIDATION_REPORT.md` | 3,760 | 56 | Complete, partial (§3 empty) |

## Appendix B — Closed registers

| Register | Members | Location |
|---|---|---|
| `AccessRole` | 5 — `owner`, `manager`, `reception`, `student`, `parent` | `identity.dart:14` |
| `Permission` | 10 — `enrollStudent`, `viewStudent`, `createMembership`, `recordAttendance`, `assignSeat`, `collectFee`, `applyDiscount`, `viewRevenue`, `viewAllBranches`, `managePolicy` | `identity.dart:71` |
| `AccessScope` | **3** — `self`, `guardianOf`, `tenantWide` | `identity.dart:93` |
| `ExternalOutcome` | **7** — `xUniformAuth`, `xSessionInvalid`, `xDenied`, `xNotFound`, `xNotPermitted`, `xInvalidRequest`, `xTemporaryFailure` | `domain_error.dart:130–150` |
| `ErrorClass` | 8 — `auth`, `authz`, `session`, `device`, `lifecycle`, `validation`, `system`, `domainBusiness` | `domain_error.dart:155–165` |
| `DomainErrorCode` | 79 total; BC-18 block = 36 (lines 67–114) | `domain_error.dart` |
| `EVT-*` | 36 — **member names not available** | Chapter 9, untransferred |

## Appendix C — BC-18 error codes as implemented

| Class | Codes |
|---|---|
| `auth` | `authChallengeNotIssued`, `authChallengeInvalid`, `authChallengeExpired`, `authChallengeConsumed`, `authAttemptBudgetExhausted`, `authPossessionProofIncomplete` |
| `authz` | `authzNoRoleGrantsPermission`, `authzConditionNarrowedToNone`, `authzScopeOutsideSubject`, `authzPermissionNotInCatalogue`, `authzEntitlementGateRefused` |
| `session` | `sessionAbsent`, `sessionUnknown`, `sessionRevoked`, `sessionExpired`, `sessionKindMismatch`, `sessionBindingUnsatisfied`, `sessionOfflineGraceExhausted`, `sessionPrivilegedOperationOffline` |
| `device` | `deviceCeilingReached`, `deviceNotPermittedForOperation`, `deviceStateInsufficient`, `deviceAssociationConflict` |
| `lifecycle` | `lifecycleTransitionNotPermitted`, `lifecycleAuthorityInsufficient`, `lifecycleDualControlRequired`, `lifecycleClosureWindowElapsed`, `lifecycleErasurePreconditionUnmet`, `lifecycleAccountErased` |
| `validation` | `identifierTypeMismatch`, `idempotencyKeyReused` |
| `system` | `systemDependencyUnavailable`, `systemAuditCommitUnavailable`, `systemCapacityExceeded`, `systemOperationTimeout`, `systemInvariantViolation` |

---

*Generated by mechanical inspection of the workspace. Every claim traces to a file listed in the header. Where the workspace is silent, this guide is silent.*
