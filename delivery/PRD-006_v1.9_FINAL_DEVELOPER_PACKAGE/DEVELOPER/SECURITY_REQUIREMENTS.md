# SECURITY_REQUIREMENTS — PRD-006 Attendance Management v1.9

**Derived document.** Authority: [`../PRD/PRD-006_ATTENDANCE-MANAGEMENT_v1.9_FROZEN.md`](../PRD/PRD-006_ATTENDANCE-MANAGEMENT_v1.9_FROZEN.md) §10A.3, §10A.8, §19, §21 (**FROZEN**) · `ADR-0014` (**`Accepted`**).

---

## 1. Five claims this module never makes

§10A.8 states these as **prohibitions**, because each is a sentence a reader or an
implementer *"might otherwise supply"*. They are security requirements in the
strongest sense: **the product must not be described or built as though any of
them were true.**

| # | MUST NOT claim | Why |
|---|---|---|
| **1** | *"Same Wi-Fi name means this is the library"* | A network name is **trivially reproducible**. `ATT-XC-015` leaves network identification unspecified — **`ATT-GAP-007`** |
| **2** | *"Wi-Fi alone proves the student's identity"* | **`ATT-XC-014`**: two students on one network are **indistinguishable** to a network check |
| **3** | *"Cheating is impossible"* | `ATT-FR-039`, `ATT-BR-042`. **No control in this document is presented as making proxy attendance impossible** |
| **4** | *"A Wi-Fi disconnect proves the student physically left at that instant"* | §10A.4a. It is an **approved exit method**, not a physical observation. *"A phone may lose Wi-Fi while its owner stays"* |
| **5** | *"An absence of observations proves the student left"* | §10A.4a row 2, §10A.3. **Silence is not evidence** — and it is **also not** evidence the student stayed |

**Do not write UI copy, log messages, notifications or documentation that implies
any of the five.**

## 2. Wi-Fi presence is not identity

§10A.3. **Device–account association is required, never inferred.**

| Situation | Required handling |
|---|---|
| A device is on the authorized network but **not associated** with a Liboora account | **`UNKNOWN DEVICE / UNVERIFIED PRESENCE`** — **no** automatic attendance, **no** session duration |
| That person is **manually verified** as a member by authorised staff | **`VERIFIED MEMBER`**, through the existing Manual workflow (§13) **and its authorisation rules** |
| That person is **not** verified | **`UNVERIFIED — NO ATTENDANCE`**. **No attendance record exists** |

**Never derive an account from a device that was not associated with it.**

## 3. Anti-abuse protections

| Protection | Requirement | Applies to |
|---|---|---|
| **Duplicate prevention** | `ATT-FR-090` … `ATT-FR-093` | **All six modes** |
| **Replay prevention** | `ATT-FR-094`, `ATT-FR-095` | **Dynamic QR, transport** |

Duplicate prevention is also an invariant: `ATT-INV-003` / `ATT-FR-090` pair with
platform rule **`MP-GBR-18` idempotency**. The offline path **will** replay
(`ATT-PO-011` … `ATT-PO-013`), so idempotency is a security control here, not only
a correctness one.

**`ATT-EVT-004 attendance.FraudSignalDetected`** exists for anti-proxy
enforcement, reaching `BC-24`, `BC-13` and `BC-22` with **raw evidence payloads**.

> **`INCOMPLETE / EXIT NOT VERIFIED` is NOT a fraud signal.** Its causes are
> *"named, and none of them is fraud"*. It **MUST NOT** raise `ATT-EVT-004` and
> **MUST NOT** be surfaced as suspicious.

## 4. Authorisation — roles are fixed

§19. **`ATT-FR-118` forbids defining a new role.** If a feature appears to need
one, it needs a **decision**, not an implementation.

| Operation | Role(s) | Scope |
|---|---|---|
| Configure attendance modes and values (§16) | `owner` | `tenantWide` |
| **Manage authorized Wi-Fi networks** (`ATT-CFG-008`, `ATT-FR-032`/`033`) | **`owner`, `manager`** — decision **`D-12`** | `tenantWide` |
| Operational attendance actions | `manager` | `tenantWide` |
| Individual manual entry (§13A) | `reception`, `manager` | `tenantWide` |
| OCR verification (§13C) | `reception`, `manager` | `tenantWide` |
| Corrections (§18) | `reception`, `manager` — subject to `ATT-CFG-022` | `tenantWide` |
| Self attendance (modes 1–5) | `student` | `self` |
| View own attendance | `student` | `self` |
| View guarded students' attendance | `parent` — subject to **`ATT-CFG-024`** | `guardianOf` |

**Authentication is `BC-18`'s**, not this module's (§19). Student identity is
`BC-01` (`StudentRecordId`) / `BC-10` (`PersonId`).

The **30-minute shift tolerance** is configurable by **Owner AND Manager** — *"the
same authority set `D-12` already granted for `ATT-CFG-008`"* — and **no new role
is defined** for it. **Location Verification** (§10A.12) is likewise Owner and
Manager, under the same authorisation, tenant-isolation and audit rules.

## 5. Tenant isolation

| Rule | Obligation |
|---|---|
| Tenant isolation is required | **`ATT-BR-017`** |
| Tenant context is **ambient**, propagated — **"never a domain method parameter"** | **`ATT-PO-004`** (`E-18`, `SK`) |
| Every audit fact carries the **tenant of record** | `ATT-FR-132` |
| Configuration is tenant/library scoped | §16, `ATT-BR-017` |
| Entitlement is checked **before the aggregate mutates** | `ATT-PO-003` (`E-17`, `CF`) |

`ADR-0014` (**`Accepted`**) governs tenant-key and audit-mutation enforcement
platform-wide.

## 6. Secrets

**`ATT-FR-133`: no audit fact may contain an authentication secret** (`ATT-FR-123`).

This extends by the same logic to logs, error payloads, telemetry and event
payloads. Note that `ATT-EVT-004` **does** carry raw evidence payloads — so its
consumers are inside the trust boundary, and its payload must still contain no
authentication secret.

## 7. Raw network data must not cross the boundary

**`ATT-AC-218`** requires a test asserting that the presence facts exposed for
composition contain **no SSID, BSSID, signal strength, MAC address or other
network datum**, and that **no consumer can obtain one through the exposed path**.

Reinforced from the other side: `ATT-BR-045`, `SEAT-BR-020`, BC Map **L292**, and
`SEAT-FR-108` (which assigns presence verification to `BC-03`, so moving it into
seating would violate the frozen seating PRD too).

**This includes** debug endpoints, verbose logs, crash reports, analytics events
and exports.

## 8. Location and permissions

§10A.12, decision **`D-21`**. **Location Verification is OPTIONAL and defaults to
OFF.**

- It is an **additional verification signal**, **never the sole identity proof**
  (`ATT-XC-014` unchanged).
- The student **MUST** be informed appropriately.
- **A denied location permission MUST NOT destroy all attendance capability** —
  the other six modes remain available (**`ATT-BR-008`**: no smartphone is required
  to attend at all).
- The failure **MUST be distinguishable rather than silent** — **`ATT-NFR-005`,
  `ATT-FR-036`: no silent downgrade.**

**No Android permission is asserted as a fact.** `ACCESS_FINE_LOCATION` and
`ACCESS_BACKGROUND_LOCATION` are **NOT** mandatory and **MUST NOT** be forced on
every student. The order of reasoning is fixed by the decision: *"First establish
whether the chosen Wi-Fi verification mechanism actually requires location."* Until
`ADR-0027` answers that, any permission is *"a conditional dependency of a
mechanism that has not been selected."*

**`ATT-FR-044` remains the only OS-permission line in the PRD**, and it concerns
**mode 4**.

## 9. No mechanism may be named

`D-13` **permits** a library-side device or software component *"if
Architecture/Security determines one is necessary"* — but **it selects no
mechanism**. No hardware, router, network identifier, API, gateway or certificate
is named, and **`ATT-XC-015` continues to forbid specifying one**.

**`ATT-GAP-007` is *narrowed by permission, not closed*.** Do not close it by
choosing a mechanism in code.

## 10. What must never be built for convenience

| Forbidden | Reason |
|---|---|
| A demo, test or guest attendance path in a release build | Not authorised by any requirement |
| Inferring an account from an unassociated device | §10A.3 — association is **required, never inferred** |
| Any exit timestamp derived from silence | §10A.5, `ATT-BR-030`, **`ATT-AC-220`** |
| Presenting `INCOMPLETE / EXIT NOT VERIFIED` as suspicion | §10A.5 — *"none of them is fraud"* |
| A new role, however narrow | **`ATT-FR-118`** |
| An attendance-specific audit store | **`ATT-FR-130`**, `X-10` |
| Any update or delete path over audit | **`X-10`** |
| A retention or purge default | **`ATT-GAP-005` OPEN** |
| Any claim of certification | **`ATT-FR-147`** |

## 11. Implementation checklist

- [ ] No UI copy, log or notification implies any of the **five never-claims**.
- [ ] Device–account association **enforced**, never inferred.
- [ ] Duplicate and replay prevention active across **all six modes**.
- [ ] Idempotency enforced in storage, not only in application code.
- [ ] Roles exactly as §19; **no new role**.
- [ ] Tenant context **ambient**; no `tenantId` domain parameter.
- [ ] Entitlement checked **before** mutation.
- [ ] **No** secret in audit, logs, events or telemetry.
- [ ] **No** raw network datum crosses the boundary — including in debug paths.
- [ ] Location Verification **OFF** by default; denial degrades **visibly**.
- [ ] **No** verification mechanism chosen in code.
- [ ] `INCOMPLETE / EXIT NOT VERIFIED` never triggers `ATT-EVT-004`.
