# Liboora — Implementation Roadmap

| Field | Value |
|---|---|
| **Version** | v1.0 |
| **Status** | Active |
| **Date** | 2026-08-02 |
| **Baseline** | BASELINE-2026-08-02 |
| **Scope** | `BC-18` Identity & Access to a releasable state, plus the platform work that blocks it |

---

## 1. What this roadmap is

An ordered list of implementation tasks with **explicit dependencies**, derived from Authentication PRD v2.0, the
accepted ADRs, and the enterprise documentation audit.

It is ordered by **dependency, not by preference.** Where the order looks inconvenient, the dependency is stated so
the cost of reordering is visible rather than discovered.

**It contains no estimates.** Sequencing and readiness are architectural facts; duration is a team fact.

---

## 2. Phase overview

| Phase | Theme | Exit condition |
|---|---|---|
| **Phase 0** | Foundations — enforce what is already decided | Boundaries mechanically enforced; configuration validated at startup |
| **Phase 1** | Real OTP delivery | A user can receive a code by SMS in a real environment |
| **Phase 2** | Remove demo surfaces | `TASK-D10` closed; `MP-CON-11` satisfied |
| **Phase 3** | Two-stage authentication | `ADR-0004` implemented; `AuthService` split |
| **Phase 4** | Sessions and devices | Chapter 6 implemented; SIM-swap defence live |
| **Phase 5** | Roles and policy | Chapter 7 implemented; tenant isolation enforced |
| **Phase 6** | Lifecycle, events, audit | Chapters 9 and 10 implemented |
| **Phase 7** | NFR and release readiness | Chapter 11 acceptance met |

**Phases 0–2 are prerequisites for a releasable build of anything.** Phase 2 in particular cannot be skipped or
deferred: the current code cannot lawfully ship.

---

## 3. Phase 0 — Foundations

### `IMPL-014` — Module boundary checker ⚠ P1

| | |
|---|---|
| **Blocks** | Nothing directly. **Silently permits everything to break** |
| **Depends on** | Nothing |
| **Files** | `tool/check_module_boundaries.dart` (**does not exist**) |

`tool/module_dependencies.yaml` is present and is the only file in `tool/`. The checker that reads it was never
written. `ADR-0001` declares a modular monolith with enforced boundaries; **without this tool the boundaries are
comments.** Twenty-six permitted edges (`E-01`…`E-26`) and fourteen forbidden edges (`X-01`…`X-14`) are currently
enforced by reviewer memory.

Every phase after this one adds code that can violate a boundary. Each week it does not exist, the eventual cost of
adding it rises, because it will fail on accumulated violations rather than on new ones.

**Requirements.**

| # | Requirement |
|---|---|
| 1 | Parse `tool/module_dependencies.yaml` |
| 2 | Walk `lib/` and `packages/`, resolving every import to an owning module |
| 3 | Fail with a non-zero exit code on any edge not in the permitted set |
| 4 | Name the file, line, and the specific `X-nn` violated |
| 5 | Run in CI on every pull request, blocking merge |
| 6 | Report **all** violations, not the first |

**Acceptance.** Tool exists · runs clean on `main` today **or** existing violations are recorded as accepted
exceptions with expiry dates · a deliberately introduced forbidden import fails the build.

Closes governance task `R-5` and `MP-DEP-06`.

---

### `IMPL-015` — Configuration validation at startup ⚠ P1

| | |
|---|---|
| **Blocks** | Safe operation of every security control |
| **Depends on** | Nothing |
| **Reference** | `CONFIGURATION_GUIDE.md` §3 |

`CFG-1`…`CFG-12` are configurable. Nothing currently validates them. A deployment can set a staff idle timeout of
30 days and no part of the system will object.

Implement invariants `INV-1` … `INV-9`. Validation runs at application startup **in every environment**, reports
**all** violations at once, and **refuses to start** on any violation.

**A silently misconfigured security control is worse than a missing one** — the dashboard says it is enabled.

**Acceptance.** All nine invariants implemented · violation prevents startup with a complete, readable message ·
unit-tested for each invariant · development profile passes with its relaxed values.

---

### `IMPL-016` — Configuration surface

| | |
|---|---|
| **Depends on** | `IMPL-015` |

Expose `CFG-1`…`CFG-12` as typed, injected configuration. Values come from environment configuration, never from
literals scattered through call sites.

**No structural fact from PRD §F may be exposed** — code length, validity, attempt count, single-use, one
challenge per number, sole factor, one active library. Exposing one is a defect.

**Acceptance.** No `CFG` value appears as a literal outside the configuration module · no structural fact is
configurable · profiles for development, staging and production match `CONFIGURATION_GUIDE.md` §4.

---

## 4. Phase 1 — Real OTP delivery

### `IMPL-020` — SMS provider integration ⚠ P0

| | |
|---|---|
| **Blocks** | **`TASK-D10`, and therefore every release** |
| **Depends on** | `IMPL-016` |
| **Reference** | `MP-DEP-03`, Chapter 8, `AUTH-11.51` |

The single highest-leverage item in this roadmap. Until a code can actually reach a phone, the demo surfaces
cannot be removed, and while they exist nothing can ship.

**Requirements.**

| # | Requirement |
|---|---|
| 1 | DLT-registered transactional template (Indian TRAI regime) |
| 2 | Provider abstracted behind an interface — swappable per `AUTH-11.51` |
| 3 | Delivery failure surfaces as `AERR-*`, never as a wrong-code error |
| 4 | Development sink writes the code to **server logs only**, never to any client response |
| 5 | Test sink is a fake gateway in `test/`, supporting `TASK-D10` D10-8 |
| 6 | Cost and delivery-rate metrics emitted per `CONFIGURATION_GUIDE.md` §6 |

**Requirement 4 is the one that matters.** If the development sink returns the code to the client, `D-10` has been
recreated under a new name.

**Acceptance.** A real SMS arrives in staging · provider swap needs no change outside the adapter · development
codes appear in server logs and nowhere else · fake gateway available to tests.

---

### `IMPL-021` — Rate limiting

| | |
|---|---|
| **Depends on** | `IMPL-016`, `IMPL-020` |
| **Reference** | `AUTH-8.16`–`AUTH-8.23` |

Implement `CFG-1`, `CFG-2`, `CFG-3`, `CFG-4`.

**`CFG-3` requires care.** The origin must be the true client address, not a proxy or CDN address. Getting this
wrong puts every user in one bucket and takes the platform down. See `CONFIGURATION_GUIDE.md` `CFG-3` deployment
note.

**Acceptance.** Per-number and per-origin limits enforced · lock self-clears without intervention · a simulated
NAT gateway with 60 clients does not lock out · metrics emitted.

---

## 5. Phase 2 — Remove demo surfaces

### `TASK-D10` — Remove demo and debug authentication surfaces ⚠ P0 release blocker

| | |
|---|---|
| **Blocks** | **Every release** |
| **Depends on** | `IMPL-020` (except step D10-4, which depends on nothing) |
| **Detail** | [`TASK-D10-remove-demo-surfaces.md`](./TASK-D10-remove-demo-surfaces.md) |

Three surfaces across five files. **Step D10-4 — deleting the OTP auto-fill line — depends on nothing and should
be done immediately**, ahead of this phase.

**Acceptance.** As specified in the task. Release **and profile** artefacts grepped clean.

---

## 6. Phase 3 — Two-stage authentication

### `IMPL-030` — Split `AuthService` verification

| | |
|---|---|
| **Depends on** | `IMPL-020` |
| **Reference** | `ADR-0004`, Chapters 4 and 6 |

Replace `verifyOtp → AuthSession?` with two stages. Stage 1 yields a verified `Account`. Stage 2 issues a
`Session` once an authorization context exists.

**"Authenticated, no library" must be representable** in the model, the API, and the UI. It is a normal state, not
an error.

**Breaking change**, in scope by `ADR-0004`. No other API changes.

**Acceptance.** Two stages exist · a user with no role reaches a meaningful screen, not an error · conformance
tests updated · no other public API modified.

---

### `IMPL-031` — Account creation and display name

| | |
|---|---|
| **Depends on** | `IMPL-030` |
| **Reference** | `ADR-0005`, `ADR-0006` |

Account created **only** on first successful verification, only by `BC-18`, idempotent per number. Display name
collected before verification, required and non-nullable, with the three machine-detectable prohibitions enforced
at creation. An existing account's name is never rewritten by a later sign-in.

**Acceptance.** No other module can create an `Account` (enforced by `IMPL-014`) · empty, whitespace-only and
mobile-number names refused · re-verification does not overwrite a stored name.

---

## 7. Phase 4 — Sessions and devices

### `IMPL-040` — Session lifecycle

| | |
|---|---|
| **Depends on** | `IMPL-030`, `IMPL-016` |
| **Reference** | Chapter 6, `MP-GBR-26` |

Idle and absolute timeouts per `CFG-5`/`CFG-6` with distinct staff and mobile values. Exactly one active library
per session; switching is a scope change, never re-authentication.

**`MP-GBR-26` is unusually strict:** revocation is *"immediate and global — authoritative-or-absent, with no
propagation window."* A cached authorisation decision that outlives revocation violates it. This constrains
caching platform-wide and must be designed for, not retrofitted.

**Acceptance.** Both timeouts fire correctly per audience · revocation is immediate with no cached grace · exactly
one active library enforced.

---

### `IMPL-041` — Device management ⚠ security-critical

| | |
|---|---|
| **Depends on** | `IMPL-040` |
| **Reference** | Chapter 6, `AUTH-8.41`–`8.47`, `ADR-0002` |

**This is V1, not V2.** The Enterprise Architecture previously tagged it V2; that was corrected in EA v2.1 because
it is wrong in a way that matters.

In a single-factor system, **SIM swap defeats authentication completely.** Unrecognised-device notification
(`EV-16`) is the *only* compensating control. Shipping V1 without device management means shipping with **no
account-takeover detection at all.**

Device registration, trust (`CFG-7`), the device limit (`CFG-8`, user chooses what to remove — never silent
eviction), and unrecognised-device notification.

**Acceptance.** Devices registered and listed · trust expires at `CFG-7` · limit reached prompts user choice ·
**`EV-16` fires on every unrecognised device** · users can revoke a device remotely.

---

## 8. Phase 5 — Roles and policy

### `IMPL-050` — Roles and permissions

| | |
|---|---|
| **Depends on** | `IMPL-030` |
| **Reference** | Chapter 7, `ADR-0003` |

Tenant-scoped role assignment against a global account. `AccessPolicy` always evaluated with a tenant in scope.

**Acceptance.** No policy decision without a tenant · roles scoped per tenant · a user's roles in one library have
no effect in another.

---

### `IMPL-051` — Support elevation

| | |
|---|---|
| **Depends on** | `IMPL-050`, `IMPL-016` |
| **Reference** | `AUTH-7.19`, `CFG-12` |

Time-boxed (`CFG-12` = 1 hour), consented, fully audited. Expiry automatic.

**Every elevation is alertable — not sampled.** This is the highest-privilege state in the platform.

**Acceptance.** Elevation expires automatically · consent recorded · every elevation emits an alertable audit
event with actor, tenant, duration and consent reference.

---

### `IMPL-052` — Tenant isolation verification

| | |
|---|---|
| **Depends on** | `IMPL-050` |
| **Reference** | `MP-GBR-08`, `SE-1`, `X-13` |

Every tenant-scoped query carries a tenant key. A tenant-less query on tenant data is a **blocker-severity**
defect.

**Acceptance.** Automated test attempts cross-tenant access on every tenant-scoped read and is refused every time.

---

## 9. Phase 6 — Lifecycle, events, audit

### `IMPL-060` — Account lifecycle

| | |
|---|---|
| **Depends on** | `IMPL-031` |
| **Reference** | Chapter 9 |

Eight states. **Both** the valid and the invalid transition tables are normative — invalid transitions must be
actively refused, not merely absent.

`CFG-9` pending retention, `CFG-10` soft-delete retention. A soft-deleted account cannot authenticate.

**Acceptance.** All valid transitions work · **every invalid transition is refused** · retention timers fire.

---

### `IMPL-061` — Events

| | |
|---|---|
| **Depends on** | `IMPL-060`, `IMPL-041` |
| **Reference** | Chapter 10, `EV-1`…`EV-26` |

All twenty-six events with correct producers and consumers.

**Acceptance.** Every event emitted at its specified trigger · `EV-16` verified end-to-end (Phase 4 dependency).

---

### `IMPL-062` — Audit trail

| | |
|---|---|
| **Depends on** | `IMPL-061` |
| **Reference** | Chapter 10 `AU-1`…`AU-9` |

Append-only. **No authentication or authorization event may be unlogged.**

**Acceptance.** Audit is append-only and tamper-evident · no gaps under load · retention meets Chapter 11.

---

## 10. Phase 7 — Release readiness

### `IMPL-070` — NFR verification

| | |
|---|---|
| **Depends on** | All prior |
| **Reference** | Chapter 11 §§11.2–11.5 |

Latency table (8 rows), availability targets, scalability envelope, observability.

### `IMPL-071` — Compliance verification

| | |
|---|---|
| **Reference** | §11.6 |

DPDP, minors' consent, DLT/TRAI, data localisation. **Minors are a large share of the student population** — the
consent path is not an edge case.

### `IMPL-072` — Error classification

| | |
|---|---|
| **Reference** | §11.7 `AERR-1`…`AERR-13` |

Closed set. **Every** authentication failure maps to exactly one `AERR-n`. An unmapped error is a defect.

### `IMPL-073` — Final acceptance

| | |
|---|---|
| **Reference** | `AC-11.1`…`AC-11.37`, `DEFINITION_OF_DONE.md` |

**No emergency bypass (`AUTH-11.53`), no break-glass (`AUTH-11.54`).** Any mechanism proposed under either name
during hardening is out of specification.

---

## 11. Dependency graph

```
IMPL-014 ─────────────────────────────► (gates all merges)
IMPL-015 ──► IMPL-016 ──► IMPL-020 ──┬──► IMPL-021
                                     │
                                     ├──► TASK-D10 ──► releasable
                                     │
                                     └──► IMPL-030 ──┬──► IMPL-031 ──► IMPL-060 ──► IMPL-061 ──► IMPL-062
                                                     │                                              │
                                                     ├──► IMPL-040 ──► IMPL-041 ────────────────────┤
                                                     │                                              │
                                                     └──► IMPL-050 ──┬──► IMPL-051                  │
                                                                     └──► IMPL-052                  │
                                                                                                    ▼
                                                                                        IMPL-070..073
```

**Critical path:** `IMPL-015` → `IMPL-016` → `IMPL-020` → `TASK-D10`. Nothing releases until it completes.

**Start `IMPL-014` immediately and in parallel.** It gates merges; every day without it accumulates violations.

**Do `TASK-D10` step D10-4 today.** One line, no dependencies, closes a live authentication bypass.

---

## 12. Blocked — not on the critical path

| Item | Blocked by | Priority |
|---|---|---|
| Library module beyond §14A | Library PRD §§1–25 never supplied | **P1** |
| Private-library invitations | Invitation security spec (`AR-4`) never written — expiry, revocation, single-use, entropy, validation, audit all unspecified. **Do not invent** | **P1** |
| Development Standards (`R-4`) | Deferred | P3 |
| `D-8`, `D-9` | Carried forward | P2 |

**`AR-4` says explicitly: do not invent.** Six security properties are unspecified. Implementing invitations by
guessing them would create exactly the kind of retrofit this roadmap exists to prevent.

---

## 13. References

`DOCUMENTATION_BASELINE.md` · `ADR-0001`…`ADR-0008` · Authentication PRD v2.0 ·
`CONFIGURATION_GUIDE.md` · `TASK-D10-remove-demo-surfaces.md` · `DEFINITION_OF_DONE.md` ·
`DOCUMENTATION_AUDIT-001.md` findings `G-4`, `R-F`
