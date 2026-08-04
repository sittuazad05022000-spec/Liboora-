# Liboora — Definition of Done

| Field | Value |
|---|---|
| **Version** | v1.2 |
| **Status** | Binding on all merges and releases |
| **Date** | 2026-08-04 |
| **Baseline** | BASELINE-2026-08-04 |
| **Applies to** | All modules. Authentication, Library Management **and** Student Identity |
| **ADRs applied** | `ADR-0001` … **`ADR-0011`** |

---

## 1. Purpose

Three gates. A change passes **every** item in a gate or it does not pass the gate.

| Gate | Applies to | Enforced by |
|---|---|---|
| **Gate 1 — Merge** | Every pull request | CI + review |
| **Gate 2 — Requirement complete** | A `AUTH-n.n` claimed as implemented | Review against the PRD |
| **Gate 3 — Release** | Any build reaching a real user | Release checklist |

**"Done" is not a feeling.** If an item cannot be verified, it is not done.

---

## 2. Gate 1 — Merge

### Code

- [ ] `flutter analyze` → **`No issues found!`**. Not "warnings only"
- [ ] `flutter test` → all tests pass. **No skipped tests without a linked task**
- [ ] `dart format .` produces no diff
- [ ] `tool/check_module_boundaries.dart` passes *(once `IMPL-014` exists)*
- [ ] No `print()` in `lib/` — `debugPrint` behind `kDebugMode` only
- [ ] No deprecated `withOpacity()` — use `withValues(alpha:)`
- [ ] No new public API without a doc comment

### Specification

- [ ] Every behavioural change traces to a `AUTH-n.n`, `BR-n.n`, `LIB-n.n`, `LIB-14B.n`, `LIB-DISC-n`, `INV-SEC-n`, `LBR-n`, `LIB-PREV-n`, **`SID-n.n`, `SID-BR-n`** or an ADR
- [ ] No requirement invented. If the specification is silent, **raise it — do not decide it**
- [ ] The change is not in an **exclusion register** — `LXC-1`…`LXC-10`, `INV-XC-1`…`INV-XC-7`, **`SXC-1`…`SXC-11`**, and the authentication exclusions. A feature listed there is out of scope by decision, not by oversight; shipping it requires an ADR, not a ticket
- [ ] No `CFG-*`, `LCFG-*`, `ICFG-*` **or `SCFG-*`** value hardcoded outside the configuration module
- [ ] No PRD §F structural fact made configurable
- [ ] No **closed register** extended in code: `TR-1`…`TR-5`, `PO-1`…`PO-12`, `IT-1`…`IT-3`, **`SPO-1`…`SPO-9`, `SEV-1`…`SEV-16`, `SID-AC-1`…`SID-AC-26`**, and the §14A.5 public field allow-list are closed. Adding a member is a specification change
- [ ] **No new role name.** `TR-1`…`TR-5` and Platform Administrator are the whole set (`AUTH-7.21`, `SID-5.4`). A module needing a role that does not exist has found a specification defect, not a naming opportunity
- [ ] **`PO-n` and `SPO-n` are not the same register.** `PO-*` governs anonymous reads of the public Library preview; `SPO-*` governs authenticated writes to a Global Person Identity. Citing one for the other moves a requirement between bounded contexts

### Security

- [ ] No demo, seeded, guest or sample account added — `MP-CON-11`
- [ ] No method exposes an OTP code to any caller
- [ ] No hardcoded mobile number in `lib/`
- [ ] No new debug surface that alters authentication behaviour
- [ ] Every tenant-scoped query carries a tenant key — `MP-GBR-08`, `X-13`
- [ ] No authorization decision cached beyond immediate revocation — `MP-GBR-26`
- [ ] No field reaches an **anonymous** response unless it is on the §14A.5 allow-list — `LIB-7.1`, `LIB-14B.44`. The check is allow-list membership, never "does this look sensitive"
- [ ] No mobile number is read from, written to, or inferred from a business contact field — `LIB-6.4`. In a system whose sole authentication factor is a mobile number, **every field that can hold a number is a credential field**
- [ ] Public seat information is coarse (`Available` / `Limited` / `Full`) — `LIB-14B.12`. An exact count is an attendance feed
- [ ] An invitation artefact is never accepted as proof of identity — `INV-SEC-002`. Validate the artefact, then authenticate the holder separately
- [ ] The `INV-SEC-036` acceptance sequence is not reordered
- [ ] Private, Draft, Pending, Suspended, Archived and non-existent libraries are indistinguishable to an anonymous caller, **including by response time** — `LIB-14B.24`, `AR-7`
- [ ] **A Global Person Identity is Private by default.** A code path that publishes a profile without an explicit act of consent is a consent defect, not a usability improvement — `SID-2.27`, `SID-5.44`
- [ ] **No never-public field is indexed anywhere** — `SID-4.39`. An index is a second read path, and it is not guarded by the projection that guards the first
- [ ] **No `StudentRecordId` or `tenantId` appears in `domain/person`**, in any `SEV-*` payload, log, metric or index — `ID-2`, `SID-4.52`, `SID-INT-9`
- [ ] **This module stores no mobile number, no OTP, no session and no credential** — `ID-1`, `SID-5.8`. A mobile number is the sole authentication factor; a copy of it in a profile table is a copy of the credential
- [ ] **Date of birth is never public — including as an age, an age bracket or a birthday** — `SID-5.9`. It is stored for `ID-6` guardian-consent evaluation only
- [ ] **A Trust & Safety action restricts the public projection only.** It never suspends, archives or invalidates an identity — `SID-4.32`, `SID-4.33`. The social product must not be able to disable a person's identity for the paying product
- [ ] **No organisation role mutates global profile state.** `TR-1`, `TR-2` and `TR-3` appear in no mutating row of `SPO-1`…`SPO-9`; Platform Administrator is limited to status — `SID-5.2`

### Documentation

- [ ] A structural decision has an ADR **merged before** the code
- [ ] Affected documents updated **in the same commit**
- [ ] A version bump carries a changelog entry
- [ ] The commit references its `IMPL-*` / `AUTH-*` identifier

**A commit that changes behaviour and leaves the documentation stale has not passed Gate 1.** This is how the
repository reached a state needing a full audit.

---

## 3. Gate 2 — Requirement complete

For each `AUTH-n.n` claimed as implemented:

- [ ] Behaviour matches the requirement **text**, not a paraphrase of it
- [ ] Every `AC-n.n` for that requirement is verified by an automated test
- [ ] Every `XC-n.n` (exclusion) is verified — the excluded behaviour **cannot** occur
- [ ] Every `BR-n.n` (business rule) it depends on is enforced
- [ ] Every `EV-n` it triggers is emitted, with correct producer and consumers
- [ ] Every failure maps to exactly one `AERR-n` — no unmapped failures
- [ ] `CFG-*` values are read from configuration, not literals
- [ ] Traceability matrix updated

**Exclusions matter as much as requirements.** An `XC-n.n` is not documentation of a non-feature — it is a
statement that the behaviour must be **impossible**, and it needs a test proving it.

---

## 4. Gate 3 — Release

### Blocking

- [ ] **`TASK-D10` CLOSED.** All ten steps, all ten acceptance criteria
- [ ] `grep -c "SEEDED" build/web/main.dart.js` → **0**
- [ ] Same check passes on a **profile** build — profile builds reach testers
- [ ] `grep -rnE "'98100000[0-9]+'" lib/` → **empty**
- [ ] `grep -rn "PeekChallenge\|otpHint" lib/` → **empty**
- [ ] Real SMS delivery verified end-to-end in staging
- [ ] Configuration validation `INV-1`…`INV-9` passes in the production profile
- [ ] No emergency bypass exists — `AUTH-11.53`
- [ ] No break-glass mechanism exists — `AUTH-11.54`

### Security

- [ ] Rate limits active; a 60-client NAT gateway does not lock out (`CFG-3`)
- [ ] Session timeouts correct for **both** audiences — staff 30 min idle / 12 h absolute
- [ ] Device management live; **`EV-16` fires on every unrecognised device**
- [ ] Support elevation time-boxed to `CFG-12` = 1 hour, consented, audited
- [ ] Cross-tenant access test suite passes on every tenant-scoped read
- [ ] Audit trail append-only with no gaps under load

### Compliance

- [ ] DLT-registered templates in use — TRAI
- [ ] DPDP retention honoured: `CFG-9` 24 h, `CFG-10` 30 days
- [ ] Minors' consent path implemented and tested — **not an edge case**
- [ ] Data localisation verified

### Quality

- [ ] Chapter 11 latency table met, all 8 rows
- [ ] Availability targets instrumented — 99.9% / 99.95%
- [ ] All `AC-11.1`…`AC-11.37` verified
- [ ] Observability emits every signal in `CONFIGURATION_GUIDE.md` §6

### Documentation

- [ ] `DOCUMENTATION_BASELINE.md` matches the repository
- [ ] No document claims a specification is missing that now exists
- [ ] Traceability matrix complete for shipped requirements
- [ ] Known gaps declared, not hidden

---

## 5. Never done

The following are **out of specification permanently.** Their appearance in a review is a rejection, not a
discussion.

| Item | Authority |
|---|---|
| Passwords, PINs, or any reusable secret | `MP-GBR-25`, `AUTH-11.79` |
| Demo, guest, seeded or sample accounts in any build | `MP-CON-11` |
| Any surface returning an OTP to a client | `AUTH-11.73` |
| Emergency authentication bypass | `AUTH-11.53` |
| Break-glass access | `AUTH-11.54` |
| Tenant-less queries on tenant data | `MP-GBR-08`, `X-13` |
| Authorization cached past revocation | `MP-GBR-26` |
| Invitation security properties invented instead of implemented | `INVITATION_SECURITY_SPECIFICATION.md`, `ADR-0009`. **This row changed on 2026-08-03.** It previously read *"invented invitation security properties — `AR-4`: do not invent"*. The `AR-4` deferral is now **lifted**: all six properties — expiry, revocation, single use, entropy, validation, audit — are specified. The prohibition is no longer *"do not decide"* but *"do not deviate"* |
| An invitation treated as a credential | `INV-SEC-002`, `ADR-0009` |
| An invitation code below the specified entropy, or drawn from an alphabet containing `0`/`O` or `1`/`I`/`l` | `INV-SEC` §5 |
| A mobile number collected to browse a library | `LIB-14B.5` |
| A field published anonymously that is not on the §14A.5 allow-list | `LIB-7.1`, `LIB-14B.44` |
| Exact live occupancy exposed publicly | `LIB-14B.12`. Deferred to V2 **as a decision**, not an omission |
| A Library module evaluating or caching an authorization decision | `X-13`, `MP-GBR-26` |
| A Library module importing `platform/communication/**` or `platform/integration/**` | `X-04`, `X-03`, `LIB-21.2`, `LIB-21.3` |
| More than one active library per session | PRD §F |
| An account existing without a Global Person Identity, or an identity without an account | **`MP-GBR-02` as amended by `ADR-0011`**, `SID-INV-1`. Note this row **inverts** the pre-`ADR-0011` rule, which required Library operation to *"degrade gracefully"* when `PersonId` was null. That wording is now itself the defect |
| A nullable `personId` on an `Account` or a `StudentRecord` | amended `ID-4`, `SID-4.17`, `IMPL-208` |
| More than one global identity aggregate in the codebase | `SID-5.51`, `IMPL-207` |
| A `StudentRecordId` leaving its tenant, in any event, index, log or metric | `ID-2`, `SID-INT-9` |
| Re-keying Membership, Attendance, Seating or Finance on `PersonId` | `SID-4.23`. It would make `ID-5` unsatisfiable — account erasure could no longer preserve organisation financial history |
| A Global Person Identity owning a list of the organisations a person belongs to | `SID-4.19`, `SC-12`. The module must not be *capable* of answering *"which libraries does this person attend?"* |
| Global Person Identity on the critical path of check-in, seat allocation, fee collection or membership | `SID-4.21`. This is the operational half of `X-05` |
| A Student Identity configurable that is organisation-scoped | `SID-5.45`. The module is not organisation-scoped, so a per-organisation setting has no meaning here |
| A public profile default, an allow-list change, or `SCFG-5 = 0`, set by configuration | `SID-5.44`. Configuration must be **rejected at startup**, not accepted with a warning |

**"Temporarily" does not apply to this table.** Every one of these reaches production by being temporary first.

---

## 6. Raising a conflict

If a requirement is ambiguous, contradictory, or absent:

1. **Stop.** Do not choose an interpretation and proceed.
2. Record it against the governing document with the identifier.
3. If it is a structural question, it needs an ADR.
4. If it is a specification defect, it needs a PRD amendment.
5. **Only then** implement.

A guess made under delivery pressure becomes a permanent, undocumented rule that the next reader cannot
distinguish from a decision.

---

## 7. References

`DOCUMENTATION_BASELINE.md` (BASELINE-2026-08-04) · `MASTER_PRD.md` **v1.7** ·
Authentication PRD v2.0 Chapter 11 · **Library PRD v1.0** · `14B-Public-Library-Preview.md` ·
`INVITATION_SECURITY_SPECIFICATION.md` · **`ADR-0001`…`ADR-0011`** · `CONFIGURATION_GUIDE.md` v1.1 ·
`TASK-D10-remove-demo-surfaces.md` · `IMPLEMENTATION_ROADMAP.md` v1.1 ·
`LIBRARY_IMPLEMENTATION_TASKS.md` ·
[`Student_Identity_PRD_v1.md`](../30-product/student-identity/Student_Identity_PRD_v1.md) v1.0 ·
[`STUDENT_IDENTITY_IMPLEMENTATION_TASKS.md`](./STUDENT_IDENTITY_IMPLEMENTATION_TASKS.md) ·
[`ADR-0011`](../00-governance/adr/ADR-0011-global-person-identity.md)

---

## 8. Change history

| Version | Date | Change |
|---|---|---|
| **v1.2** | **2026-08-04** | **Extended to cover Student Identity.** Gate 1 gains eight identity security checks — Private by default, never-public fields never indexed, no `StudentRecordId`/`tenantId`, no credential, date of birth never public *"including as an age"*, Trust & Safety restricted to the public projection, no organisation role mutating global state — and three specification checks: the `SXC-*` exclusion register, the four newly closed registers (`SPO-*`, `SEV-*`, `SID-AC-*`), and an explicit *"no new role name"* rule. The `PO-n` / `SPO-n` prefix hazard is recorded. *"Never done"* gains **nine** rows, one of which (**account without identity**) *inverts* a rule that held before `ADR-0011`; that inversion is stated in the row rather than left implicit. Baseline advanced to `BASELINE-2026-08-04`; ADR range to `ADR-0011`; Master PRD reference to v1.7. **No existing gate was weakened or removed.** |
| v1.0 | 2026-08-02 | Created. Three gates, authored against the authentication baseline. |
| **v1.1** | **2026-08-03** | **Extended to cover Library Management.** Gate 1 gains six Library security checks, the exclusion-register check and the closed-register check; the traceability prefix list is extended to the seven Library prefixes; the *"Never done"* table gains eight Library rows and the stale `AR-4` *"do not invent"* row is **replaced** — the deferral was lifted, so the rule is now *"do not deviate"*. Baseline reference advanced to `BASELINE-2026-08-03`; ADR range to `ADR-0010`. **No existing gate was weakened or removed.** |
