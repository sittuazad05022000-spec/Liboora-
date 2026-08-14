# DEVELOPER — PRD-006 Attendance Management v1.9

| Field | Value |
|---|---|
| **Source of truth** | [`../PRD/PRD-006_ATTENDANCE-MANAGEMENT.md`](../PRD/PRD-006_ATTENDANCE-MANAGEMENT.md) — **FROZEN v1.9** |
| **Admitting decision** | [`../ADR/ADR-0034-...`](../ADR/ADR-0034-attendance-management-prd-v1.9-baseline.md) — **`Accepted`** |
| **Authority of these 15 documents** | **Derived. Zero.** They restate and reorganise; they never add |

---

## 1. How to read this set

These documents exist to make a 3216-line frozen specification implementable
without anyone having to hold all of it in their head at once. They are
**derived**: every normative sentence traces to a numbered obligation
(`ATT-FR-*`, `ATT-BR-*`, `ATT-INV-*`, `ATT-EVT-*`, `ATT-XC-*`, `ATT-PO-*`,
`ATT-CFG-*`, `ATT-NFR-*`, `ATT-AC-*`) or to an **`Accepted`** ADR.

**The precedence order is absolute:**

```
frozen PRD-006 v1.9  >  Accepted ADRs  >  Architecture (BC Map, Dependency Matrix)
                     >  these DEVELOPER documents
```

If a `DEVELOPER/` document contradicts the frozen PRD, **the PRD is right and the
developer document is a defect**. Report it. Do not reconcile it in code, and do
not "fix" the PRD.

## 2. Reading order

| Order | Document | Why here |
|---|---|---|
| 1 | [`DEVELOPER_GUIDE.md`](./DEVELOPER_GUIDE.md) | What the module owns, what it must never own |
| 2 | [`DOMAIN_RULES.md`](./DOMAIN_RULES.md) | The vocabulary. Nothing later makes sense without it |
| 3 | [`ATTENDANCE_STATE_MACHINE.md`](./ATTENDANCE_STATE_MACHINE.md) | The nine statuses and the 5-minute rule — the highest-risk logic in the module |
| 4 | [`WIFI_PRESENCE_ARCHITECTURE.md`](./WIFI_PRESENCE_ARCHITECTURE.md) | How observations become sessions, without a timer |
| 5 | [`EVENT_CONTRACTS.md`](./EVENT_CONTRACTS.md) | The closed four-event surface |
| 6 | [`SEAT_CARD_INTEGRATION.md`](./SEAT_CARD_INTEGRATION.md) | Read-time composition and four refused shortcuts |
| 7 | [`ATTENDANCE_HISTORY.md`](./ATTENDANCE_HISTORY.md) | Append-only history and corrections |
| 8 | [`SECURITY_REQUIREMENTS.md`](./SECURITY_REQUIREMENTS.md) | Authorisation, isolation, and the five never-claims |
| 9 | [`ANDROID_BACKGROUND_BEHAVIOUR.md`](./ANDROID_BACKGROUND_BEHAVIOUR.md) | What the platform will not promise you |
| 10 | [`API_SPECIFICATION.md`](./API_SPECIFICATION.md) | **Constraints only** — read §1 before expecting endpoints |
| 11 | [`DATABASE_SPECIFICATION.md`](./DATABASE_SPECIFICATION.md) | **Constraints only** — read §1 before expecting DDL |
| 12 | [`IMPLEMENTATION_GUIDE.md`](./IMPLEMENTATION_GUIDE.md) | Build sequence |
| 13 | [`TESTING_REQUIREMENTS.md`](./TESTING_REQUIREMENTS.md) | What proves it works |
| 14 | [`IMPLEMENTATION_TASKS.md`](./IMPLEMENTATION_TASKS.md) | The 80 tasks |

## 3. Two documents are not what their names suggest

`API_SPECIFICATION.md` and `DATABASE_SPECIFICATION.md` are **constraint
documents**. They contain **no endpoints and no table definitions**, because the
frozen PRD and every accepted ADR contain none — measured as **0** occurrences of
REST-shaped paths, `openapi`/`swagger`, `CREATE TABLE`, `varchar`, `NOT NULL` and
`primary key` across `PRD-006`, `ADR-0034`, `ADR-0032`, the BC Map and the
Dependency Matrix.

Inventing them would have violated the explicit instruction not to invent APIs or
DB fields. Instead they state the **boundaries** any API or schema must satisfy,
and name the owner authorised to decide the rest.

## 4. The eleven decisions that must not drift

Grace **5 minutes** · tolerance **30 minutes** both sides, Owner **and** Manager ·
final qualifying Wi-Fi disconnect **is** an exit · **no** exit inference from
silence or process death · multi-device **OR** presence · Location Verification
**optional, default OFF** · no-booking and overstay are **stored** statuses ·
manual attendance **≠** verified presence · seat allocation **≠** presence · Seat
Card composed **at read time** and **never** reads raw Wi-Fi · **exactly four**
events, **no** fifth, **no** `StudentCheckedOut` overload.

## 5. What these documents deliberately do not contain

- **No code.** No Dart, no SQL, no schema migrations.
- **No numeric value** beyond the approved **5** and **30** minutes and the 24
  registered `ATT-CFG-*` defaults and ranges.
- **No periodic-check interval** — `D-14` withholds it.
- **No latency or throughput figure** — `ATT-NFR-003` forbids it while
  `ATT-GAP-017a` is open.
- **No retention period** — `ATT-GAP-005` is open and this module **MUST NOT**
  define its own.
- **No network identification mechanism** — `ATT-XC-015` forbids naming one.
- **No content from a `Proposed` ADR presented as a rule.**
