# ADR-0030 — Attendance needs to resolve a device to a student; this proposes the smallest compliant mechanism and decides nothing

| Field | Value |
|---|---|
| **Status** | **Proposed** — not binding. *(`ADR-INDEX.md` status vocabulary: "Under consideration; not binding")* |
| **Date** | 2026-08-05 |
| **Deciders** | **Architecture owner (ARB) + Security** — the edge is absent from the BC Map, and the source context is Authentication |
| **Supersedes** | Nothing |
| **Amends** | **Nothing.** `LIBOORA_BOUNDED_CONTEXT_MAP.md`, the Authentication PRD and `PRD-006` are all byte-identical |
| **Baseline** | **None issued.** Baseline remains **`BASELINE-2026-08-04-E`** |
| **Closes** | **Nothing** |
| **Related** | `R-17` · `BC-18` Authentication · `BC-03` Attendance · `AUTH-6.30`…`AUTH-6.43` · BC Map §7 **L292** · `ATT-BR-017` · `ATT-XC-014` · `PRD-006` §10A.2, §10A.3 · `ADR-0027` · `ADR-0028` |

> ⚠️ **`Proposed`. This ADR identifies a required dependency and specifies the minimum information it would carry.
> It creates no edge, no event, no read model and no API.** BC Map §7 L292: *"If an edge is not in this table, it
> does not exist and adding it requires an ADR."* This is that ADR, in its `Proposed` form.

---

## 1. The requirement

`PRD-006` §10A.3 makes association of a device with an account **a prerequisite, not a by-product**: detection
**MUST NOT** be treated as association. §10A.2 makes one account plus N registered devices exactly one session. Both
rules require `BC-03` Attendance to answer one question:

> Is this observing device a **valid registered device** of a known student in **this tenant** — and which student?

Attendance cannot answer it today. **This is `R-17`.**

## 2. What already exists — measured, not assumed

**Authentication already owns a device registry, and it is already V1.** Nothing needs to be built there.

| Rule | Text as measured | Consequence for this decision |
|---|---|---|
| `AUTH-6.30` | Every session **MUST** be associated with exactly one device record | The mapping Attendance needs already exists |
| `AUTH-6.31` | A device record **MUST** be created on first successful authentication from that device | Registration is already a real event, not a new concept |
| **`AUTH-6.32`** | **A device record belongs to the account, not to the platform or to any library** | **Ownership is settled and MUST NOT move to Attendance** |
| **`AUTH-6.33`** | **No library MAY view, name, trust or remove any device belonging to an account** | **A library-facing device list is prohibited.** Any mechanism exposing devices to library staff is non-compliant |
| `AUTH-6.34` | Platform roles **MUST NOT** view or manage device records without approved elevation | Not a general-read licence for a platform service either |
| `AUTH-6.40` | An account **MUST NOT** exceed `CFG-8` (10) concurrently registered devices | The multi-device rule is already bounded; Attendance need not bound it |
| `AUTH-6.42` | Each record shows name, category, first-seen, last-active, trust expiry | Richer than Attendance needs — see §4 |
| **`AUTH-6.43`** | **Device records MUST NOT expose any authentication factor, challenge value or session secret** | Constrains the contract's payload absolutely |

Device categories already exist: **Trusted · Registered · Unknown**. `PRD-006` §10A.3's
`UNKNOWN DEVICE / UNVERIFIED PRESENCE` aligns with the third by meaning, and this ADR does **not** assert the two
vocabularies are the same thing — that is part of what a deciding authority must confirm.

**Attendance must not rebuild any of this.** `PRD-006` §26 already records that `BC-03` holds **nothing** of
`BC-18`'s credentials, sessions and roles. A second device registry inside Attendance would contradict `AUTH-6.32`
and that table simultaneously.

## 3. The gap

| Fact | Source |
|---|---|
| `BC-03`'s only inbound edges are `E-03` (`BC-02` membership), `E-04` (`BC-06` policy), `E-17`, `E-18`, `E-19`, `E-24` | BC Map §7.1; `PRD-006` header |
| **No `BC-18` → `BC-03` edge exists** | BC Map §7 table |
| An absent edge *"does not exist and adding it requires an ADR"* | BC Map §7 **L292** |

**So the dependency is real and unauthorised.** It must be created by decision or the capability cannot verify a
device at all.

## 4. Minimum information — the smallest payload that answers the question

**The design principle: Attendance is told the answer, not given the registry.**

| Field | Why it is necessary | Why nothing more |
|---|---|---|
| An opaque **device reference** | The correlation key for the observation | Not a serial, IMEI, MAC, model or OS build. Attendance never needs to know *what* the device is |
| The **`StudentRecordId`** it resolves to | §10A.2 attributes presence to a student | Already the only student identifier `BC-03` holds (`PRD-006` §26). No name, no contact, no profile |
| The **tenant** the resolution is valid in | `ATT-BR-017` isolation, and `ATT-INV-010`'s tenant qualifier | Prevents a device registered for one library resolving in another |
| **Whether the device is currently valid/registered** for that account | §10A.2 says *valid* registered device; §10A.3 needs the unknown case | A boolean-shaped verdict. **Not** trust state, not category history, not first-seen/last-active |

**Explicitly NOT carried:** any authentication factor, challenge or session secret (`AUTH-6.43` forbids it) · device
name (`AUTH-6.33` — libraries may not name devices) · trust expiry or trust level · session identifiers · the
account's other devices · any list-shaped access at all.

**Direction matters.** Attendance asks about **one** device it has already observed and receives a verdict. It
**MUST NOT** be able to enumerate an account's devices, because enumeration is the shape `AUTH-6.33` and `AUTH-6.34`
exist to prevent. **This is the single most important constraint in this ADR.**

## 5. Options, none selected

| # | Shape | Preserves `AUTH-6.32`/`33`/`34` | Notes |
|---|---|---|---|
| **O-1** | A **synchronous query port** `BC-18` → `BC-03`, single-device verdict only | **Yes**, if enumeration is impossible by construction | Simplest to reason about; couples presence verification to Authentication availability |
| **O-2** | An **event** published on device registration/removal, projected by Attendance into a local read model | Yes, but Attendance then **holds** a device projection — arguably in tension with §26's *"holds nothing"* | Resilient offline; adds staleness, and a removed device (`AUTH-6.38`/`6.39`) must not stay valid |
| **O-3** | Resolution performed **in the authenticated session** — presence is asserted by an authenticated client, so the device is already bound by `AUTH-6.30` | **Strongest**: needs no new cross-context read of the registry at all | May not cover the observation-without-a-live-session case, which is precisely what §10A.5's incomplete sessions are |
| **O-4** | A **platform-service resolution** sitting between the two contexts | Requires `AUTH-6.34` elevation analysis | Adds a component and a hop |

**O-3 deserves the deciding authority's attention first, because it may dissolve the dependency instead of
authorising it.** If every presence observation necessarily arrives inside an authenticated session, `AUTH-6.30`
already binds device to account and no new edge is needed. **Whether that holds for queued offline observations
replayed later through `E-24` is exactly the question this ADR cannot answer** — and it is the deciding factor
between O-3 and O-1. **This is not a recommendation.**

## 6. What an accepting decision must record

1. Which option, and the edge's BC Map row if one is created — id, direction, pattern, port, payload.
2. That the payload is limited to §4, or what is added and why.
3. That enumeration is impossible by construction.
4. How a removed device (`AUTH-6.38`/`6.39`) invalidates in-flight presence.
5. Whether the offline replay path (`E-24`) is covered, and if not, the resulting status — `PRD-006` §10A.4a row 2
   already gives `INCOMPLETE / EXIT NOT VERIFIED` for unresolvable cases.
6. Security sign-off, because the subject is Authentication data.
7. Whether the `Unknown` device category and `UNKNOWN DEVICE / UNVERIFIED PRESENCE` are the same condition.

## 7. What this ADR explicitly does not do

- It does **not** create, name or number an edge, event, port, API or read model.
- It does **not** modify the BC Map, the Authentication PRD, `PRD-006`, or any Rank 1–4 document.
- It does **not** grant Attendance access to Authentication data — it proposes a bounded verdict and **prohibits
  enumeration**.
- It does **not** weaken `AUTH-6.32`, `AUTH-6.33`, `AUTH-6.34` or `AUTH-6.43`.
- It does **not** define a device registry inside Attendance.
- It does **not** select an option, and **O-3 is flagged for attention, not recommended**.
- It does **not** assert approval by any person or body, and does **not** become `Accepted` by being written.
- It does **not** resolve `ADR-0027`'s identity question, which is a different question about the **network**.
