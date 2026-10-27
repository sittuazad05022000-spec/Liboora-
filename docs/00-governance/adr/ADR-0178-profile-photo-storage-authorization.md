# ADR-0178 — Profile Photo Storage Authorization

| Field | Value |
|---|---|
| **ADR** | `ADR-0178` |
| **Status** | **`Accepted`** — by a one-act, direct, explicit conferral of **Architecture Owner** authority by the human principal of this engagement, on the `ADR-0032` §5.2 / `ADR-0033` §7.2 precedent. Same disclosure: **no ARB quorum, attendee list, sign-off date or Security review is asserted**, and *a conferral for one act is not a standing licence* (`ADR-0033` §7.1) |
| **Deciders** | **Architecture Owner** |
| **Supersedes** | Nothing |
| **Amends** | **No ranked document's content.** Proposal for future implementation |
| **Amended by** | Nothing |
| **Related** | `ADR-0054` (File & Media PRD) · `ADR-0016` (E-22 consumer list) · `FIL-GAP-012` |

---

## 1. The question

How must authorization be arranged for profile photo storage that serves tenant-isolated data, where image bytes must be protected by access checks that not only succeed before serving bytes but also prevent information leakage about object existence?

---

## 2. Evidence — the artefacts, not the feelings

`ADR-0054`-style requirements for `BC-29`:

| Requirement | Current / Proposed |
|---|---|
| Tenant isolation | **Required** — mandatory for all profile photo operations |
| Authorization before return | **Required** — `FileAccess.isPermittedConsumer()` must check E-22 membership before image bytes are returned |
| Non-revelation of existence | **Required** — unauthorized requests must receive a forbidden error, not "not found" |
| `FileAccess.isPermittedConsumer()` | Checks E-22 consumer-list membership (`BC-01`, `BC-10`, `BC-14`) |
| `FileAccess.resolve()` | Returns `FileRef?`; unknown reference returns null; unauthorized consumer receives forbidden error |
| `InProcessFileAccess` | Stores references in an in-memory table, **not** image bytes |
| `BC-01` authorized context | Valid for profile viewing |
| `BC-12` sharing | **Remains blocked** by `ADR-0054` (FIL-GAP-012) |
| Upload limits | No unverified size, dimensions, format, retention, or configuration limits defined |

`FIL-FR-094` requires: *"Authorization results must not reveal whether a resource exists."*

`FIL-GAP-008` remains OPEN pending retention/legal determination.

---

## 3. Findings routed at the correct rank, and **not** fixed here

| Finding | Where it belongs | Disposition |
|---|---|---|
| Upload size, dimensions, format limits | `BC-29` PRD owner, or left as open `FIL-GAP-*` | **OPEN** |
| Retention period for profile photos | `FIL-GAP-008` | **OPEN** |
| Legal basis for photo storage | Legal / Compliance team | **OPEN** |

---

## 4. The decision

**Proposal:** Profile photo storage authorization shall be implemented as follows:

1. **`FileAccess.isPermittedConsumer()` checks E-22 membership** — BC Map **L331** authorizes only `BC-01`, `BC-10`, `BC-14` as consumers of the files port. `BC-01` (authenticated profile viewing) is among the valid consumers.

2. **Authorization must succeed before image bytes are returned** — The `FileAccess.resolve()` method returns a `FileRef?` that pointers to stored image data. The caller must call `isPermittedConsumer()` before any bytes are read or transmitted.

3. **Unauthorized requests receive a forbidden error, not "not found"** — This satisfies `FIL-FR-094` and prevents unauthorized enumeration of stored photos through existence probes.

4. **`InProcessFileAccess` stores only references** — Image bytes are stored separately (e.g., in an object store), and the in-memory table holds only `FileRef` objects that map to paths/identifiers in that store.

5. **BC-12 student-to-student sharing remains blocked** — `FIL-GAP-012` blocks the `E-22` consumer cell admission needed for `BC-12`. This ADR does not amend BC Map; routing to Architecture Owner for `FIL-GAP-012` resolution is documented.

6. **No limits or policies are specified here** — Upload size, dimensions, format, retention period, and lifecycle policies remain to be defined by the BC-29 owner and/or new ADRs against Rank 1–4 authority.

---

## 5. What this decision does **not** license

| Claim | Licensed? |
|---|---|
| Implementation of profile photo storage | ❌ No. This is design guidance, not implementation authorization |
| Upload size or format limits | ❌ No. `FIL-GAP-*` remains open |
| Retention period | ❌ No. `FIL-GAP-008` remains open |
| BC-12 access via `E-22` | ❌ No. `FIL-GAP-012` blocked by ADR-0054 |

---

## 6. Compliance

| Rule | Satisfied? |
|---|---|
| Tenant isolation mandatory | ✅ Yes — required by multi-tenant architecture |
| `FIL-FR-094` non-revelation of existence | ✅ Yes — forbidden error on unauthorized |
| `E-22` membership check | ✅ Yes — `FileAccess.isPermittedConsumer()` enforces |
| BC Map current at v1.5 | ✅ Yes — ADR-0016/ADR-0055/ADR-0095 record current consumers |

---

## 7. Change history

| Date | Change |
|---|---|
| 2026-10-27 | **Created `Proposed`**. Documents the authorization requirements for profile photo storage pending implementation. Does not amend any ranked document. |
| 2026-10-27 | **Accepted** by a one-act, direct, explicit conferral of **Architecture Owner** authority by the human principal of this engagement — §8. No ranked document amended; `FIL-GAP-008`/`FIL-GAP-012` remain OPEN; no implementation authorized |

---

## 8. Acceptance record

**Status moved `Proposed` → `Accepted` under the authority named in the Status row.**

**Authority — recorded as it was given, verbatim:**

> *"I, the human principal of this engagement, explicitly confer authority for the single act of accepting
> ADR-0178, 'profile-photo-storage-authorization', under the Architecture Owner approval mechanism described in
> ADR-0032 §5.2 and ADR-0033 §7.2. This is a one-act conferral limited exclusively to ADR-0178. It does not grant
> standing authority for any other ADR or governance decision."*

**Mechanism check:** `PRD_OWNERSHIP_MODEL.md` §5 (**L284**) — *"Only the Architecture Owner approves."* The
approval is exercised here by the human principal under the one-act conferral pattern recorded at `ADR-0032` §5.2
and `ADR-0033` §7.2.

**Disclosure, per the convention:**

| Not claimed |
|---|
| **No ARB quorum, attendee list, sign-off date or Security review is asserted** (`ADR-0032` §5.2 · `ADR-0033` §7.2 · `ADR-0046` L8) |
| **No personal name is recorded** (`PRD_OWNERSHIP_MODEL.md` §7 rule 4) |
| **A conferral for one act is not a standing licence** (`ADR-0033` §7.1) — this acceptance confers no standing authority |
| **No implementation is authorized.** §5 stands: storage, retrieval, rendering, upload limits, retention and deletion are **not** licensed by this acceptance |

**Acceptance rationale:** this ADR passes the acceptance test every accepted ADR here must pass — it contains **no
question addressed to another authority**: every matter it does not decide (`FIL-GAP-008` retention/legal,
`FIL-GAP-012` BC-12 sharing, upload/format/retention limits) is **named, given an owner and left OPEN**, and nothing
is invented to close them. `FIL-GAP-008` **remains OPEN** pending the retention/legal determination.