# DOMAIN_RULES — PRD-006 Attendance Management v1.9

**Derived document.** Authority: [`../PRD/PRD-006_ATTENDANCE-MANAGEMENT.md`](../PRD/PRD-006_ATTENDANCE-MANAGEMENT.md) (**FROZEN**).

---

## 1. The vocabulary, and why the distinctions matter

Most defects in this module come from collapsing two concepts that the frozen
specification keeps apart. Each row below is a separation the PRD enforces.

| Concept | Means | Does **NOT** mean |
|---|---|---|
| **Attendance** | A recorded presence fact produced by an approved method | That the student is present **now** |
| **Verified presence** | An open session where a valid registered device holds verified Wi-Fi presence | Identity proof — see §5 |
| **Allocation** (`Occupied`) | A seat is assigned | The student is physically present. Frozen `SEAT-FR-041`: *"`Occupied` means allocated, not physically present"* |
| **Manual attendance** | Attendance recorded by authorised staff | **Verified presence.** `ATT-AC-214` requires it to render as `PRESENCE UNVERIFIED`, **never** as `PRESENT` |
| **Wi-Fi disconnect** | An **approved exit method** | A physical observation that the student left at that instant |
| **Absence of observations** | Nothing is known about that interval | That the student left. **Also not** that they stayed |
| **Session ended** | A qualifying exit closed the session | That an exit timestamp may be invented for it |
| **Study Hours** | Verified presence **inside the booked shift**, aggregated by `BC-26` | Total time on the network |

## 2. The four final-principle questions — four fields, four timestamps, never one

§23.4a states these are **four separate questions** and must never be collapsed:

1. *Is this student's seat assigned?* → **`BC-04`**, answerable today.
2. *Is this student currently verified as present?* → computable inside
   **`BC-03`**, answerable today.
3. *When did the configured attendance exit event occur?* → §10A.4a's **final
   qualifying disconnect**.
4. *How many booked-shift Study Hours are countable?* → §10A.7a's
   **inside-the-booked-window** rule.

## 3. Invariants

`ATT-INV-001` … `ATT-INV-012` — **12 invariants**. Four of them
(`ATT-INV-002` … `ATT-INV-005`, with §6.3) are the `AttendanceDay` invariants the
Bounded Context Map §8 also carries, and two are cross-referenced to
platform-wide global business rules:

| Invariant | Paired obligation | Platform rule |
|---|---|---|
| `ATT-INV-003`, `ATT-FR-090` | Duplicate prevention | `MP-GBR-18` **idempotency** |
| `ATT-INV-005`, `ATT-BR-040` | Corrections | `MP-GBR-11` **append-only corrections** |

**Every invariant must survive offline replay.** `ATT-PO-012` states this
explicitly: the conflict-resolution policy **MUST** preserve every §6.2
invariant, and a replayed punch **MUST NOT** be applied twice.

## 4. The nine status strings — the complete stored vocabulary

§10A.1. **Seven** came from decisions `D-10` … `D-16`; **rows 8 and 9 were added
by `D-20`** and are **stored**, not derived.

| # | Condition | Stored status | Source |
|---|---|---|---|
| 1 | Correct shift **and** verified presence inside the booked window | **`VERIFIED PRESENCE`** | `D-10`…`D-16` |
| 2 | Verified presence outside the booked shift, **a booking existing** | **`SCHEDULE MISMATCH`** | `D-10`…`D-16` |
| 3 | A qualifying exit event closed the session | **`SESSION ENDED`** | `D-10`…`D-16` |
| 4 | A proper exit cannot be reliably verified | **`INCOMPLETE / EXIT NOT VERIFIED`** | `D-10`…`D-16` |
| 5 | A device or account cannot be identified | **`UNKNOWN DEVICE / UNVERIFIED PRESENCE`** | `D-10`…`D-16` |
| 6 | An unknown person manually verified as a member | **`VERIFIED MEMBER`** | `D-10`…`D-16` |
| 7 | An unknown person not verified | **`UNVERIFIED — NO ATTENDANCE`** | `D-10`…`D-16` |
| **8** | Verified network presence by a student with **NO booked shift** | **`NO BOOKED SHIFT / PRESENCE UNASSIGNED`** | **`D-20`** |
| **9** | Verified presence continuing **beyond the booked shift + tolerance** | **`SHIFT OVERSTAY / PRESENCE OUTSIDE BOOKED WINDOW`** | **`D-20`** |

**Do not add a tenth.** `ADR-0029` §3.2 considered exactly that for a null shift
reference and **refused**: *"It does **not** invent an eighth status string"* — an
extra string needs a Product Owner decision, and `ADR-0029` is `Proposed`
(non-binding) anyway.

## 5. Multi-device — OR presence

§10A.2, **one account, one session**:

| Situation | Outcome |
|---|---|
| Phone A verified **and** Phone B verified | **ONE `VERIFIED PRESENCE`** — not two sessions, not double time |
| No valid registered device for more than 5 minutes | **`SESSION ENDED`** |

The session survives while **any one** valid registered device holds verified
presence. The grace clock starts only when **all** of them have lost it.

## 6. Wi-Fi presence is not identity

§10A.3. Device–account association is **required, never inferred**.

| Situation | Outcome |
|---|---|
| A device is on the authorized network but **not associated** with a Liboora account | **`UNKNOWN DEVICE / UNVERIFIED PRESENCE`** — **no** automatic attendance, **no** session duration |
| That person is subsequently **manually verified** as a member by authorised staff | **`VERIFIED MEMBER`** — through the existing Manual workflow (§13) and its authorisation rules |
| That person is **not** verified | **`UNVERIFIED — NO ATTENDANCE`**. **No attendance record exists** |

## 7. Five claims this specification never makes

§10A.8 states these as **prohibitions**, because each is a sentence a reader
might otherwise supply.

| # | MUST NOT claim | Why |
|---|---|---|
| 1 | *"Same Wi-Fi name means this is the library"* | A network name is trivially reproducible. `ATT-XC-015` leaves network identification unspecified — **`ATT-GAP-007`** |
| 2 | *"Wi-Fi alone proves the student's identity"* | `ATT-XC-014`: two students on one network are indistinguishable to a network check |
| 3 | *"Cheating is impossible"* | `ATT-FR-039`, `ATT-BR-042`. **No control here makes proxy attendance impossible** |
| 4 | *"A Wi-Fi disconnect proves the student physically left at that instant"* | §10A.4a. It is an **approved exit method**, not a physical observation |
| 5 | *"An absence of observations proves the student left"* | §10A.4a row 2, §10A.3. **Silence is not evidence** — and not evidence they stayed |

## 8. Shift tolerance — 30 minutes, both sides

§10A.7a. **Default 30 MINUTES**, Owner **and** Manager configurable,
tenant/library scoped, every change auditable. Applies to **both** sides.
Booked 06:00–10:00 therefore has an **effective operational window of
05:30–10:30**.

| Window | Operational treatment | Counts toward booked-shift Study Hours |
|---|---|---|
| before 05:30 | Outside the operational window — §10A.7b governs | **No** |
| **05:30 – 06:00** | Early-arrival tolerance. Presence **MAY** be accepted operationally | **NO** |
| **06:00 – 10:00** | Normal booked-shift presence — `VERIFIED PRESENCE` | **Yes**, the verified portion only |
| **10:00 – 10:30** | Shift ended / tolerance. **MUST NOT** be silently treated as normal presence. Student **and** authorised staff **MAY** be alerted | **NO** |
| after 10:30 | **Shift overstay.** **MUST NOT** silently continue as `VERIFIED PRESENCE`. Alert student **and** staff | **NO** |

**Worked example, because the arithmetic is the point.** Booked 06:00–10:00,
tolerance 30 minutes, verified presence **05:50 → 10:10**. Study Hours count
**only 06:00 → 10:00** — exactly **4 hours**. The 10 minutes before and the 10
after are operationally accepted and contribute **nothing**.

The excluded time *"is not a metric being withheld, it is presence that falls
outside the booked shift the figure is about"* — `ATT-FR-145`/`146`/`147`
unchanged. Verified by **`ATT-AC-221`**.

> ⛔ **Blocked dependency, stated so it is not implemented by guesswork:** the
> tolerance is measured against a **booked shift** that `BC-03` cannot currently
> read — **`ATT-GAP-002a`, OPEN**. `ADR-0029` frames the question and is
> `Proposed`. *"A tolerance around a shift that cannot be read is not
> independently implementable."*

## 9. Location Verification — optional, default OFF

§10A.12, decision **`D-21`**. **MUST NOT** be mandatory for Wi-Fi Presence. A
per-library option, **default OFF**, configurable by **Owner and Manager** under
the same authorisation, tenant-isolation and audit rules as every other setting.

When enabled:

- It is an **additional verification signal**, **never the sole identity proof**
  (`ATT-XC-014` unchanged).
- The student **MUST** be informed appropriately.
- **A denied location permission MUST NOT destroy all attendance capability** —
  the other six modes remain available (`ATT-BR-008`: no smartphone is required
  to attend at all), and the failure **MUST** be distinguishable rather than
  silent (`ATT-NFR-005`, `ATT-FR-036` — **no silent downgrade**).

**No Android permission is asserted as a fact.** `ACCESS_FINE_LOCATION` and
`ACCESS_BACKGROUND_LOCATION` are **NOT** mandatory and **MUST NOT** be forced on
every student. `ATT-FR-044` remains the only OS-permission line in the PRD, and
it concerns mode 4.

## 10. Analytics, certification, retention

| Rule | Obligation |
|---|---|
| The module **MAY** expose operational facts | `ATT-FR-145` |
| The module **MUST NOT** own analytics or metrics — `BC-26` does | `ATT-FR-146` |
| Attendance is **never certified** | `ATT-FR-147` |
| **Retention is undefined and this module MUST NOT define its own** | **`ATT-GAP-005` OPEN** |
| Audit has **no update and no delete path** | `X-10` |
