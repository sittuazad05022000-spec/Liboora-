# IMPLEMENTATION_GUIDE — PRD-006 Attendance Management v1.9

**Derived document.** Authority: [`../PRD/PRD-006_ATTENDANCE-MANAGEMENT_v1.9_FROZEN.md`](../PRD/PRD-006_ATTENDANCE-MANAGEMENT_v1.9_FROZEN.md) (**FROZEN**) · [`../PRD/PRD-006_IMPLEMENTATION_TASKS.md`](../PRD/PRD-006_IMPLEMENTATION_TASKS.md) · **`Accepted`** ADRs.

---

## 1. Before writing any code

| Step | Why |
|---|---|
| 1. Read [`DOMAIN_RULES.md`](./DOMAIN_RULES.md) and [`ATTENDANCE_STATE_MACHINE.md`](./ATTENDANCE_STATE_MACHINE.md) | The vocabulary and the riskiest logic |
| 2. Read frozen §10A **in full** | It is the whole Wi-Fi Presence capability |
| 3. Read [`IMPLEMENTATION_TASKS.md`](./IMPLEMENTATION_TASKS.md) §4 | Your task may be **deliberately blocked** |
| 4. Confirm the ADRs you are relying on are **`Accepted`** | 11 of the attendance ADRs are `Proposed` and **not binding** |
| 5. Check whether the thing you are about to add is in the **must-not-create** list | §5 of `IMPLEMENTATION_TASKS.md` |

## 2. Build order — follow the wave sequence

The backlog's eight waves are a dependency order, not a grouping.

| Wave | Range | Build |
|---|---|---|
| **1** | `IMPL-600`–`609` | Context boundary, **ownership split**, ports, aggregate, **the 12 invariants** |
| **2** | `IMPL-610`–`619` | Roles, mode framework, **mode independence**, Fixed QR |
| **3** | `IMPL-620`–`629` | Dynamic QR, **Wi-Fi mode**, GPS mode |
| **4** | `IMPL-630`–`639` | Face — **mostly blocked**; build the **refusals** |
| **5** | `IMPL-640`–`649` | Manual entry, register image, OCR failure path, audit |
| **6** | `IMPL-650`–`659` | **Entry/exit determinism**, time, duplicates, concurrency, volume |
| **7** | `IMPL-660`–`669` | Owner configuration, the 24 configurables, device boundary, corrections |
| **8** | `IMPL-670`–`679` | Authorization, tenancy, audit, **events**, Seating boundary, NFRs, acceptance |

**Wave 1 first, always.** The ownership split and the invariants are what every
later wave is checked against.

## 3. Layering

Ports are declared in wave 1 *"as ports with fakes, **never as implementations of
the upstream contexts**"* (`IMPL-602`). That is the core structural instruction.

```
   ┌──────────────────────────────────────────────┐
   │  BC-03 Attendance (this module)              │
   │                                              │
   │  Domain:   AttendanceDay aggregate           │
   │            12 invariants (ATT-INV-001..012)  │
   │            9 status strings                  │
   │            grace + exit precedence PREDICATES│
   │                                              │
   │  Ports:    14 (ATT-PO-001..014) — declared   │
   │            here, implemented against fakes   │
   │                                              │
   │  Events:   exactly 4 published outward       │
   └──────────────────────────────────────────────┘
        │ consumes via ports          │ publishes facts
        ▼                             ▼
   BC-02 BC-06 BC-21 BC-19        BC-04  BC-24  BC-22
   BC-25 BC-30                    (occupancy, audit, notify)
```

**Four edges must be built as impossibilities** (`IMPL-605`): Analytics, File &
Media, AI Assistance, Search Indexing. Not "not yet wired" — **unreachable**.

## 4. What to implement as a predicate, not as state

This is the design decision most likely to be implemented wrongly.

| Concept | Implement as | Never as |
|---|---|---|
| The **5-minute grace** | A **predicate over recorded observations**, evaluated on read/reconcile | A timer, a scheduled job, a `session_expires_at` treated as truth |
| **Open/closed session status** | **Derived** and recomputable (frozen `SEAT-FR-116`) | An authoritative stored flag |
| **Seat Card presence** | **Composed at read time** (`SEAT-FR-104` pattern) | A stored copy on the seat or allocation |
| **Exit** | A **recorded fact** with a method | An inference from silence |

**`WorkManager` is EVENTUAL, never PUNCTUAL** — it reconciles; it is not a
deadline. See [`ANDROID_BACKGROUND_BEHAVIOUR.md`](./ANDROID_BACKGROUND_BEHAVIOUR.md).

## 5. The six modes are independent

**`ATT-XC-011`, `ATT-BR-004`:** the modes are *"**independent and each sufficient
alone**"*. **Do not build a `VerificationStrategy` pipeline** — a shared pipeline
creates coupling the specification forbids.

V1 has **six** modes; a seventh is a scope decision, not an implementation one
(`ATT-XC-010`). Wi-Fi Presence is **additive** and *"existing attendance is
untouched"* (§10A.11): all six modes and `ATT-BR-007` are preserved verbatim, and
**`FIXED_QR_WIFI` is not reinterpreted**.

## 6. Ordering rules that are testable

| Rule | Task | Obligation |
|---|---|---|
| Entitlement is checked **before** the aggregate mutates | `IMPL-603` | `ATT-PO-003` — *"Ordering test: a denied entitlement…"* |
| Attendance is complete **when the attendance write commits** — **not** when occupancy updates | — | `ATT-XC-009`, `ATT-NFR-013`, `ATT-FR-142` |
| Audit is **fire-and-forget via outbox**, never synchronous | `IMPL-673` | `ATT-FR-129` |
| Exit precedence is evaluated **in order**, row 1 first | `IMPL-650`–`659` | §10A.4a |

**Never wrap check-in and seat occupancy in one transaction** (`ATT-XC-009`).

## 7. Configuration

Read all **24** `ATT-CFG-*` through `E-19` / `ATT-PO-005` using **typed
accessors** — *"no raw string lookups"* (`IMPL-661`).

- **Seven configurables have no default** — **`ATT-GAP-017`**. `IMPL-661`
  **cannot supply them.** Leave them absent and make the absence visible.
- **`ATT-CFG-008`** (approved Wi-Fi networks) is **`owner` + `manager`** (`D-12`);
  every other row is `owner`.
- **Do not create `ATT-CFG-025`** for the 30-minute tolerance. Implement the
  behaviour; the register entry is owed and **no range has been approved**.

## 8. Things to build as refusals

An unusual but explicit instruction: several tasks implement a **prohibition**
rather than a feature, and the prohibition is the deliverable.

| Build the refusal | Not the feature | Why |
|---|---|---|
| `IMPL-605` | Four non-existent edges | Must be **impossible**, not merely absent |
| `IMPL-622`, `IMPL-625`, `IMPL-626` | Network/location detections | **`ATT-GAP-007`/`008`/`008a`** — no source identifies a network |
| `IMPL-634` | The Face build | **`ATT-FR-064`** blocks it regardless of version class |
| `IMPL-676`, `IMPL-677` | Offline Dynamic QR, latency targets | **`ATT-PO-014`** undefined; **`ATT-GAP-017a`** open |
| `IMPL-663` | An *"at least one mode"* constraint | **`ATT-GAP-018`** — not authorised. **Preserve permissive behaviour** |

## 9. Cross-context reality — build against fakes

Several upstream producers do not exist yet, and the backlog says so:

- `PRD-005` `BC-02` `E-03` producer unbuilt → **consume against a port with a
  fake**; Attendance **records and flags, never blocks**.
- `PRD-004` `BC-01` identity projection absent → this module **never creates or
  renames a student**.
- `PRD-007` `BC-04` `E-08` consumer unbuilt → `IMPL-675` is *"the producer side of
  a link whose consumer is also unbuilt"*. **Publish correctly anyway** — and per
  `ATT-FR-137`, **never depend on consumption**.
- `PRD-023` `BC-25` Configuration PRD **does not exist** → still read the 24
  configurables through `E-19`.

## 10. Gates you must keep green

| Gate | Expected |
|---|---|
| `prd006_traceability.py` | **exit 0** — `285/285`, dangling 0, orphans 0 |
| `prd006_task_coverage.py` | **exit 0** — 80 tasks, `IMPL-600..679`, 0 holes |
| `check_module_boundaries.dart` | **Red today** — 9 `ADR-0012` time-boxed violations (**`BLK-01`/`TASK-D10`**). Pre-existing; **do not "fix" in an attendance PR** |
| `prd007_traceability.py` | **2 pre-existing failures.** Not yours |

**Never weaken a gate to make a change pass.** The specification's own record shows
probes being **reverted** when they failed, not gates being relaxed.

## 11. Definition of done for a task

- [ ] Every `ATT-*` in the task's **Requirements** cell is satisfied.
- [ ] The relevant `ATT-AC-*` have **named tests** ([`TESTING_REQUIREMENTS.md`](./TESTING_REQUIREMENTS.md)).
- [ ] No new event, edge, role, status string, configurable or gap number.
- [ ] No numeric value beyond **5 minutes**, **30 minutes** and the registered
      `ATT-CFG-*` defaults/ranges.
- [ ] No raw Wi-Fi datum crosses the boundary.
- [ ] Nothing is fabricated when evidence is missing.
- [ ] Tenant context **ambient**; idempotency enforced.
- [ ] Blocked items **left blocked**, with the blocker cited in code comments.
- [ ] `prd006_traceability.py` and `prd006_task_coverage.py` still **exit 0**.

## 12. If the specification seems to be missing something

**It is probably missing on purpose.** Eighteen `ATT-GAP-*` gaps are open and *"no
task resolves any of them"*.

The correct response is, in order:

1. Check whether it is a **registered gap** or an **`ATT-XC-*` exclusion**.
2. Check whether a **`Proposed`** ADR already frames it — read the options, do not
   pick one.
3. Escalate to the **named owner** in the gap ledger.
4. **Do not** implement a plausible default. **Do not** amend the frozen PRD.

*"Freeze is **conferred, not claimed**."*
