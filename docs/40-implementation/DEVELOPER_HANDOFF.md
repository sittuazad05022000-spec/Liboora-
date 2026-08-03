# Liboora — Developer Handoff

| Field | Value |
|---|---|
| **Version** | v1.0 |
| **Date** | 2026-08-02 |
| **Baseline** | BASELINE-2026-08-02 |
| **Audience** | Engineers implementing `BC-18` Identity & Access |
| **Read this** | **First.** Before any other document, before any code |

---

## 1. What Liboora is

A **multi-tenant SaaS platform for libraries and study halls in India.** One deployment serves many independent
library organisations. A library's owner, managers and reception staff run their venue; students and parents use
it.

Two facts shape almost every technical decision:

1. **Tenant isolation is absolute.** Data belonging to one library must never be reachable from another. A
   tenant-less query on tenant data is a **blocker-severity** defect, not a bug to schedule.
2. **Authentication is a mobile number and a one-time code. There are no passwords anywhere.** Not hashed, not
   optional, not "for admins." None.

---

## 2. Read in this order

| # | Document | Why |
|---|---|---|
| 1 | **This document** | Orientation and the traps |
| 2 | `00-governance/DOCUMENTATION_BASELINE.md` | Which documents are authoritative, and precedence |
| 3 | `00-governance/adr/ADR-INDEX.md` → all 8 ADRs | The structural decisions. **Binding** |
| 4 | `30-product/authentication/Authentication_PRD_v2.md` | The specification. 588 requirements |
| 5 | `20-configuration/CONFIGURATION_GUIDE.md` | The twelve configurable values and why |
| 6 | `40-implementation/IMPLEMENTATION_ROADMAP.md` | What to build, in what order |
| 7 | `40-implementation/AUTHENTICATION_IMPLEMENTATION_CHECKLIST.md` | Keep open while coding |
| 8 | `40-implementation/DEFINITION_OF_DONE.md` | The three gates |

The eight ADRs are short. **Read all eight before writing code.** Each records a decision that looks arbitrary
until you know why, and each has been re-litigated at least once already.

---

## 3. Architecture in one page

**Modular monolith.** One deployable, hard internal boundaries. A pure-Dart shared kernel in
`packages/liboora_contracts` holds cross-module contracts. Modules communicate only along permitted edges
(`E-01`…`E-26`); fourteen edges are explicitly forbidden (`X-01`…`X-14`).

**31 bounded contexts, 23 in V1.** `BC-18` Identity & Access owns *"credentials, sessions, devices, OTP, roles,
permissions, policy decisions, consent."* Nothing else may create an account, issue a session, or decide a
permission.

**Hybrid tenancy.** `Account` is **global** — one person, one mobile number, one account across the whole
platform. Role assignments are **tenant-scoped** — the same person can be a manager in one library and a student
in another, and those facts are unrelated. `AccessPolicy` is always evaluated with a tenant in scope.

**Two-stage authentication.** Verification proves *who* and yields an `Account`. Session issuance grants *what,
where* and yields a `Session` bound to exactly one library. These are separate operations with separate outputs.

**Boundaries are currently unenforced.** `tool/check_module_boundaries.dart` does not exist (`IMPL-014`). Until
it does, every boundary rule is honour-system. This is the first task in the roadmap.

---

## 4. The seven things most likely to be got wrong

Ranked by consequence. Each is elaborated in the checklist.

### 1. Letting the OTP reach the client ⚠ severity: authentication does not exist

The code must never appear in any client response, header or field, in **any** environment. Development reads it
from **server logs**. Tests read it from a fake gateway in `test/`.

This is not hypothetical — it is the current state of the codebase (`TASK-D10`, Surface 3).

### 2. Getting `CFG-3` wrong ⚠ severity: venue-wide outage

A study hall is **60–200 students behind one NAT gateway**. Per-origin rate limiting must tolerate that, and the
origin must be the true client address, not a proxy address. The original value of 30/hour would have locked out
every venue on day one.

### 3. Caching an authorization decision ⚠ severity: violates a global rule

`MP-GBR-26`: revocation is *"immediate and global — authoritative-or-absent, with no propagation window."* Even
a few seconds of cached authorization violates it. **Design for this from the start.**

### 4. Treating device management as optional ⚠ severity: no takeover detection

It is V1. In a single-factor system SIM swap defeats authentication completely, and unrecognised-device
notification (`EV-16`) is the **only** compensating control.

### 5. Making "authenticated, no library" an error ⚠ severity: first-run broken for everyone

Every user is in this state immediately after registering. It is normal, persistent, and must be representable.

### 6. One session timeout for everyone ⚠ severity: compliance failure

Staff use **shared reception devices** — 30 minutes idle, 12 hours absolute, per NIST SP 800-63B AAL2. Mobile
users have personal devices — 30 days idle, 90 days absolute. Two threat models.

### 7. Inventing a requirement ⚠ severity: permanent undocumented rule

If the specification is silent, **raise it — do not decide it.** `AR-4` says *"do not invent"* about invitation
security and lists six unspecified properties. A guess made under delivery pressure is indistinguishable from a
decision to the next reader.

---

## 5. Ground rules

| Rule | Consequence of breaking it |
|---|---|
| No passwords or reusable secrets, ever | `MP-GBR-25` — architectural, not a preference |
| No demo, guest, seeded or sample account in any build | `MP-CON-11` — **release blocker** |
| No emergency bypass, no break-glass | `AUTH-11.53`, `AUTH-11.54` — permanently excluded |
| Every tenant-scoped query carries a tenant key | `MP-GBR-08` — blocker severity |
| Structural facts (PRD §F) are never configurable | Lets operators configure out of conformance |
| A structural decision needs an ADR **before** the code | Otherwise the reasoning is lost |
| Documentation updates in the **same commit** as the code | This is how the repository reached its audit state |

---

## 6. Current codebase state — read honestly

| | |
|---|---|
| **Flutter / Dart** | 3.35.4 / 3.9.2 — version-locked, do not upgrade |
| **`flutter analyze`** | `No issues found!` |
| **`flutter test`** | 43 passing — 34 conformance, 9 widget |
| **Conformance to v2.0** | **Unknown.** The tests predate the specification |

**The code predates the specification.** 43 green tests do not evidence conformance to 588 requirements. They
were written against earlier rulings and cover a fraction of the surface. Treat existing authentication code as
**unverified**, not as a working baseline.

**The application currently cannot lawfully ship.** Three demo surfaces violate `MP-CON-11`:

| Surface | Location | Guard |
|---|---|---|
| Seeded accounts panel — 5 tappable accounts including Owner | `login_screen.dart:219`, rendered at line 90 | **None** |
| OTP auto-filled into the login field | `identity.dart:323` → `session.dart:91` → `login_screen.dart:42` | Release only — **active in profile builds** |
| Hardcoded demo child phone | `session.dart:26` | None |

Full detail and remediation: `TASK-D10-remove-demo-surfaces.md`.

**One thing you can do today.** Deleting `login_screen.dart:42` (`_code.text = s.otpHint ?? '';`) closes the live
authentication bypass. One line, no dependencies. Everything else in `TASK-D10` waits for real SMS delivery,
because removing the demo surfaces without it leaves an application nobody can enter.

---

## 7. Known gaps — declared, not hidden

| Gap | Effect | Priority |
|---|---|---|
| **`TASK-D10`** — demo surfaces in code | Cannot ship any release build | **P0** |
| **`IMPL-020`** — no real SMS delivery | Blocks `TASK-D10`, blocks everything | **P0** |
| **`IMPL-014`** — no module boundary checker | Boundaries unenforced; violations accumulate silently | **P1** |
| **`IMPL-015`** — no configuration validation | A misconfigured control looks enabled | **P1** |
| **Library PRD §§1–25** never supplied | Library module cannot be built beyond §14A | **P1** |
| **Invitation security spec** (`AR-4`) never written | Private libraries cannot be built. Six properties unspecified. **Do not invent** | **P1** |
| `D-8`, `D-9` | Carried forward from earlier registers | P2 |
| Development Standards (`R-4`) | Deferred | P3 |

**Authentication is fully specified and ready to implement.** The Library module is not — it has §14A and nothing
else.

---

## 8. When documents disagree

| Rank | Source |
|---|---|
| 1 | `MASTER_PRD.md` global rules — `MP-GBR-*`, `MP-CON-*`, `MP-DEP-*` |
| 2 | Accepted ADRs |
| 3 | Authentication PRD v2.0 |
| 4 | Bounded Context Map · Module Dependency Matrix |
| 5 | Architecture Rulings `AR-1`, `AR-3`, `AR-4` |
| 6 | Enterprise Architecture v2.1 — **descriptive only** |
| 7 | Configuration Guide |

**A conflict is a defect.** Do not resolve it in code. The precedence order tells you which document is *wrong* —
report it so it gets fixed once, rather than worked around repeatedly.

---

## 9. A note on the Authentication PRD

Authentication PRD **v2.0** was **authored, not recovered.** An earlier v1 was referenced throughout the
repository but never existed in it — eleven chapter files were empty placeholders. Recovery failed; the text is
not in git history or any versioned artefact.

v2.0 was written from scratch against the constraints that *were* present: the Master PRD global rules, the
Bounded Context Map, the Module Dependency Matrix, and Architecture Rulings `AR-1`…`AR-7`. It makes **no claim**
about what v1 contained. It is now the official baseline (`ADR-0008`), and if v1 ever resurfaces it has no
standing.

**Practical consequence:** you may encounter archived documents in `90-archive/` asserting that the specification
is missing. They are historical. Every one carries a header saying so. The specification exists.

---

## 10. First week

| Day | Do |
|---|---|
| 1 | Read documents 2–5 above. All eight ADRs |
| 1 | Delete `login_screen.dart:42`. Closes the live bypass |
| 2 | `IMPL-014` — module boundary checker. Run it; record existing violations |
| 3 | `IMPL-015` — configuration validation, `INV-1`…`INV-9` |
| 4 | `IMPL-016` — configuration surface. No `CFG` literals anywhere |
| 5 | Begin `IMPL-020` — SMS provider. The critical path starts here |

**Do not begin feature work before `IMPL-014`.** Authentication touches more modules than anything else, and
without boundary enforcement it is the work most likely to create a violation that is expensive to unwind later.

---

## 11. References

`DOCUMENTATION_BASELINE.md` · `ADR-INDEX.md` · `Authentication_PRD_v2.md` · `CONFIGURATION_GUIDE.md` ·
`IMPLEMENTATION_ROADMAP.md` · `AUTHENTICATION_IMPLEMENTATION_CHECKLIST.md` · `TASK-D10-remove-demo-surfaces.md` ·
`DEFINITION_OF_DONE.md` · `TRACEABILITY_MATRIX.md`
