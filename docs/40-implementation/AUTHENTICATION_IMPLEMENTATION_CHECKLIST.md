# Authentication — Implementation Checklist

| Field | Value |
|---|---|
| **Version** | v1.0 |
| **Status** | Active |
| **Date** | 2026-08-02 |
| **Scope** | `BC-18` Identity & Access |
| **Source** | Authentication PRD v2.0 — 588 requirements across 11 chapters |

---

## How to use this

This is the **working checklist** a developer keeps open while implementing authentication. It is organised by
build order, not by chapter number, because chapter order is not implementation order.

It does **not** restate all 588 requirements — the PRD does that, and duplicating it would create two sources of
truth. It captures the items that are **easy to get wrong**, **easy to skip**, or **catastrophic if missed**, and
points at the chapter for the rest.

Each block names its governing chapter. **Read the chapter.** This checklist is a guard against omission, not a
substitute for the specification.

---

## Block 0 — Before writing any authentication code

- [ ] Read Authentication PRD v2.0 Chapters 3, 4, 6 in full — not skimmed
- [ ] Read `ADR-0002`, `ADR-0004`, `ADR-0005`, `ADR-0006`, `ADR-0007`
- [ ] Read `CONFIGURATION_GUIDE.md` §2 — know which values are yours to choose (none)
- [ ] Know the seven **structural facts** (PRD §F) that are not configurable
- [ ] Know the nine **never done** items in `DEFINITION_OF_DONE.md` §5
- [ ] `tool/check_module_boundaries.dart` exists and runs — `IMPL-014`

**The last item matters more than it looks.** Authentication touches more modules than anything else in the
platform. Without boundary enforcement, this is the work most likely to create a forbidden edge.

---

## Block 1 — OTP delivery `IMPL-020`

**Chapter 3 · `MP-DEP-03`**

- [ ] Provider behind an interface — swappable per `AUTH-11.51`
- [ ] DLT-registered transactional template (TRAI)
- [ ] Code is **6 numeric digits** — structural, not configurable. Digits are required by DLT
- [ ] Validity **5 minutes** — structural
- [ ] **Single-use** — a verified code cannot be reused
- [ ] **One concurrent challenge per number** — requesting again replaces, never accumulates
- [ ] **5 verification attempts** per challenge, then the challenge dies
- [ ] Delivery failure maps to its own `AERR-*`, distinct from a wrong code
- [ ] Development sink writes the code to **server logs only**
- [ ] **The code never appears in any client response, header, or field** ⚠
- [ ] Test sink is a fake gateway in `test/` — not in `lib/`

> ⚠ **The single most important line in this document.** If the code reaches the client in any environment, the
> authentication factor does not exist. `D-10` happened exactly this way.

---

## Block 2 — Anti-enumeration

**Chapter 3, Chapter 8 · `ADR-0007`**

- [ ] Requesting a code for a **registered** and an **unregistered** number is indistinguishable
- [ ] Same response shape · same status · same message · same timing class
- [ ] Requesting a code creates **no** account and **no** user-visible persistent state
- [ ] The UI does **not** branch on whether the number is known
- [ ] Conformance asserts **observable behaviour**, never internal storage

**Timing counts.** A registered number that takes 200 ms and an unregistered one that takes 20 ms is an
enumeration oracle regardless of what the response body says.

---

## Block 3 — Rate limiting `IMPL-021`

**Chapter 8 §8.3 · `AUTH-8.16`–`8.28`**

- [ ] `CFG-1` — 5 requests per number per rolling hour
- [ ] `CFG-2` — 30 s minimum interval per number
- [ ] `CFG-3` — 100 requests per origin per rolling hour
- [ ] `CFG-4` — 30 min lock, **self-clearing**, never needs support to lift
- [ ] All four read from configuration; **no literals**
- [ ] Origin derived from the **true client address**, not a proxy or CDN address ⚠
- [ ] Tested with a simulated NAT gateway of 60 clients — **no lockout**
- [ ] Rate-limit rejection is its own `AERR-*`, not a wrong-code error
- [ ] Metrics emitted per `CONFIGURATION_GUIDE.md` §6

> ⚠ **`CFG-3` is the one that takes down a venue.** A study hall is 60–200 students behind one gateway. Get the
> origin wrong and every user shares one bucket. Get the value wrong and Monday morning is an outage.

---

## Block 4 — Two-stage authentication `IMPL-030`

**Chapters 4, 5, 6 · `ADR-0004`**

- [ ] Stage 1 (verification) returns a verified **`Account`** — not a session
- [ ] Stage 2 (issuance) returns a **`Session`** bound to exactly one library
- [ ] **"Authenticated, no library" is representable** in the model, the API, and the UI ⚠
- [ ] A user in that state reaches a meaningful screen — join, discover, or invitation prompt
- [ ] Never an authentication error
- [ ] A session is issued only after an authorization context exists
- [ ] Switching library is a **scope change**, never re-authentication
- [ ] Authentication and Authorization are not merged in any method or screen

> ⚠ Every user is in this state immediately after registering. If it is not representable, first-run is broken
> for **every new user**.

---

## Block 5 — Account creation `IMPL-031`

**Chapters 4, 9 · `ADR-0005`, `ADR-0006`**

- [ ] Account created **only** on first successful verification
- [ ] Created **only** by `BC-18` — no other module, no proxy
- [ ] **Idempotent per number** — a partial failure must not consume a challenge without creating the account
- [ ] Display name collected **before** verification
- [ ] `displayName` stays `required`, non-nullable — no migration, no default, no derivation
- [ ] Refuse creation on: empty string · whitespace-only · equal to the mobile number
- [ ] Never generate or infer a name
- [ ] **A later sign-in never rewrites an existing account's name** ⚠
- [ ] Authentication receives the name as a parameter; never holds it as state between calls
- [ ] `CFG-11` — 5 claim failures per 24 h, then claim lock

> ⚠ Otherwise a user typing a different name on the sign-in screen silently renames their own account.

---

## Block 6 — Sessions `IMPL-040`

**Chapter 6 · `MP-GBR-26`**

- [ ] `CFG-5` idle — 30 days mobile, **30 minutes staff**
- [ ] `CFG-6` absolute — 90 days mobile, **12 hours staff**
- [ ] Staff and mobile values are genuinely distinct, not one value with a comment
- [ ] Exactly **one** active library per session
- [ ] Revocation is **immediate and global — no propagation window** ⚠
- [ ] No authorization decision cached beyond immediate revocation
- [ ] Session termination cause recorded and emitted

> ⚠ `MP-GBR-26` says *"authoritative-or-absent."* Any cache holding an authorization decision for even a few
> seconds violates it. **Design for this at the start** — it constrains caching platform-wide and cannot be
> retrofitted cheaply.

**Staff timeouts are a compliance floor, not a preference.** NIST SP 800-63B AAL2 requires 30-minute idle
reauthentication. A reception tablet is a shared, physically accessible device.

---

## Block 7 — Devices `IMPL-041` ⚠ security-critical

**Chapter 6, `AUTH-8.41`–`8.47` · `ADR-0002`**

- [ ] Device registration on session issuance
- [ ] `CFG-7` — trust expires at 90 days
- [ ] `CFG-8` — max 10 devices; **the user chooses what to remove** ⚠
- [ ] **Never silently evict a device**
- [ ] **`EV-16` fires on every sign-in from an unrecognised device** ⚠⚠
- [ ] The notification reaches the user out-of-band
- [ ] The user can revoke any device remotely
- [ ] Revoking a device terminates its sessions immediately

> ⚠⚠ **This is V1, not V2.** In a single-factor system SIM swap defeats authentication completely. `EV-16` is the
> **only** compensating control. Without it, V1 ships with **no account-takeover detection whatsoever**.
>
> Silent eviction is indistinguishable from an attack — the user loses a device and cannot tell whether it was
> the system or an intruder.

---

## Block 8 — Roles and policy `IMPL-050` … `IMPL-052`

**Chapter 7 · `ADR-0003`**

- [ ] `Account` is global; role assignments are **tenant-scoped**
- [ ] `AccessPolicy` is **always** evaluated with a tenant in scope — no exceptions
- [ ] Roles in one library have **zero** effect in another
- [ ] Every tenant-scoped query carries a tenant key — `MP-GBR-08`, `X-13`
- [ ] Automated cross-tenant access test on **every** tenant-scoped read
- [ ] `CFG-12` — support elevation max **1 hour**
- [ ] Elevation is time-boxed, consented, audited; expiry automatic
- [ ] **Every** elevation is alertable — not sampled ⚠

> ⚠ A tenant-less query on tenant data is **blocker** severity. Not a warning, not a follow-up.

---

## Block 9 — Lifecycle `IMPL-060`

**Chapter 9**

- [ ] All eight states implemented
- [ ] Every **valid** transition works
- [ ] Every **invalid** transition is **actively refused** ⚠
- [ ] `CFG-9` — pending records discarded after 24 h
- [ ] `CFG-10` — soft-deleted accounts erased after 30 days
- [ ] A soft-deleted account **cannot authenticate, hold a session, or appear in any roster**
- [ ] `Locked` (`CFG-4`) self-clears and is distinct from `Suspended`

> ⚠ Chapter 9 §9.3 has **both** a valid and an invalid transition table. The invalid table is normative. Absence
> of a code path is not refusal — refusal must be explicit and tested.

---

## Block 10 — Events and audit `IMPL-061`, `IMPL-062`

**Chapter 10**

- [ ] All **26** events (`EV-1`…`EV-26`) emitted at their specified triggers
- [ ] Producers and consumers match the register
- [ ] Audit is **append-only** and tamper-evident
- [ ] **No authentication or authorization event is unlogged** ⚠
- [ ] No gaps under load
- [ ] All 12 notifiable occurrences reach the user

> ⚠ An unlogged authentication event is an incident you cannot investigate.

---

## Block 11 — Errors, NFR, compliance `IMPL-070` … `IMPL-073`

**Chapter 11**

- [ ] Every failure maps to exactly one of the **13** `AERR-n` — closed set
- [ ] An unmapped error is a defect, not a default case
- [ ] `AERR` classes do not leak whether a number is registered
- [ ] Latency table met — all 8 rows
- [ ] Availability instrumented — 99.9% / 99.95%
- [ ] DPDP retention honoured
- [ ] **Minors' consent path implemented and tested** — a large share of students ⚠
- [ ] DLT/TRAI templates in use
- [ ] Data localisation verified
- [ ] **No emergency bypass** — `AUTH-11.53`
- [ ] **No break-glass** — `AUTH-11.54`
- [ ] All `AC-11.1`…`AC-11.37` verified

---

## Block 12 — Release gate

- [ ] **`TASK-D10` CLOSED** — all ten steps, all ten acceptance criteria
- [ ] `grep -c "SEEDED" build/web/main.dart.js` → **0**
- [ ] Same on a **profile** build
- [ ] `grep -rnE "'98100000[0-9]+'" lib/` → empty
- [ ] `grep -rn "PeekChallenge\|otpHint" lib/` → empty
- [ ] Configuration invariants `INV-1`…`INV-9` pass in the production profile
- [ ] `flutter analyze` clean · `flutter test` green
- [ ] Traceability matrix updated
- [ ] `DEFINITION_OF_DONE.md` Gate 3 fully satisfied

---

## Anti-patterns — reject on sight

| Anti-pattern | Why it is rejected |
|---|---|
| "Temporary" demo account for testing | This is precisely how `D-10` reached the codebase |
| Returning the OTP in a response "only in dev" | Environments leak. The dev sink writes to **server logs** |
| Caching an authorization decision "for performance" | `MP-GBR-26` — no propagation window |
| A single session timeout for staff and mobile | Two different threat models. NIST requires the distinction |
| Silently evicting the oldest device | Indistinguishable from an attack from the user's side |
| Nullable `displayName` "just for migration" | `ADR-0006`. Propagates into every consumer permanently |
| An emergency bypass "for support" | `AUTH-11.53`. Explicitly excluded |
| Inventing invitation expiry or entropy | `AR-4` — *"do not invent."* Six properties are unspecified |
| Making a structural fact configurable | Lets an operator configure the system out of conformance |

---

## References

Authentication PRD v2.0 · `ADR-0002`, `ADR-0004`…`ADR-0007` · `CONFIGURATION_GUIDE.md` ·
`IMPLEMENTATION_ROADMAP.md` · `TASK-D10-remove-demo-surfaces.md` · `DEFINITION_OF_DONE.md` ·
`TRACEABILITY_MATRIX.md`
