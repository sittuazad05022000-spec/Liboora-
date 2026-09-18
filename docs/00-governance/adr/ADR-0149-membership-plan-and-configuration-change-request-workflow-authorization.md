# ADR-0149 — The Student-raised Membership Plan / Configuration **change-request workflow** is established, and its `TR-1`…`TR-5` authorization is allocated by **derived capability**

| Field | Value |
|---|---|
| **Status** | ⭐⭐ **Accepted** — 2026-09-18 |
| **Date** | 2026-09-18 |
| **Deciders** | **Product Owner** *(the request lifecycle, the decision-note rule, the self-cancellation rule, and the `MM-PO-002` approval split)* **and Architecture Owner** *(record ownership, aggregate boundary, transaction boundary, search, events, read-model enforcement)*, **jointly**, under a one-act conferral; ⛔ **both offices revert on completion** (`ADR-0033` §7.1) |
| **Authority instrument** | ⭐ The Product Owner's decision, recorded verbatim: *"**A-2** — TR-2 Manager may approve Membership Plan activate/deactivate operations. TR-1 Owner approval is required for Membership Plan edits. Do not invent or infer a commercial field set. Preserve the existing separation between request approval and underlying execution/update authorization. Treat activate/deactivate as distinct operations within the existing Membership Plan authorization model."* |
| **Amends** | ⛔⛔ **NOTHING IS EDITED BY THIS ADR.** No file outside this one changes. It is **declaratory and constitutive**: it records decisions and allocates authority under mechanisms that already exist (`ADR-0132` §5.3; `prd-v2/07` action and scope classes). ⛔ `PRD-005`, `PRD-004`, `PRD-006`, `PRD-023`, `prd-v2/*`, `ADR-0132`, BC Map and `DD-0001` are **byte-unchanged** |
| **Baseline** | ⛔ **No baseline re-issue.** No Rank 1–3 document changes version; no Rank 1–5 document changes at all (`DOCUMENTATION_BASELINE.md` §7 **L383-384**, rule 4) |
| **Closes** | ⭐ **`C-A`** (`MM-PO-002` approval split) · ⭐ **`C-B`** (`TR-3` request read) · ⭐ **`AO-2`**, **`AO-3`**, **`AO-4`**, **`AO-5`**, **`AO-7`**, **`AO-8`**, **`AO-9`**, **`AO-10`** |
| **Does NOT close** | ⛔ **`G-8`** (§9 — independent, pre-existing, NON-BLOCKING) · ⛔ **`G-9`** (§10 — the `PRD-005` instrument form, Governance Owner's) · ⛔ **`P-1`…`P-6`** privacy items (§8) · ⛔ **`MM-GAP-004`**, **`MM-GAP-005`**, **`MM-GAP-010`**, **`MM-GAP-010a`**, **`SM-GAP-4`**, **`SM-GAP-5`**, **`SEAT-GAP-010`** · ⛔ **`DD-0001` Declaration 3**, which stays **GAP** until §10 completes |
| **Related** | `ADR-0019` *(`PRD-005` v1.4 freeze)* · `ADR-0132` *(`AUTH-7.22` audited; derived capability)* · `ADR-0053` *(`PRD-023` freeze)* · `ADR-0018` *(`PRD-004` freeze)* · `ADR-0032` *(the in-place frozen-PRD amendment precedent)* · `ADR-0087` *(the 253 derived capabilities at Rank 3)* |

> ⭐⭐ **`AUTH-7.22` REMAINS CLOSED AT ZERO ENUMERATED PERMISSIONS.** ⛔ This ADR mints **no** permission
> identifier, **no** `PERM-*` token, **no** action class, **no** scope class, **no** role, **no** event, **no**
> aggregate, **no** BC Map row, **no** edge and **no** configuration identifier. ⛔ **`ADR-0132` is NOT reopened.**

---

## 1. Context

`PRD-005` Membership Management is **FROZEN v1.4** at **Rank 3** (`ADR-0019`). Its §16.3 **L1316-1331** registers
eleven protected operations `MM-PO-001`…`MM-PO-011` as a **closed list**. Two of them are the subject here:

| ID | Operation | `PRD-005` Notes cell, **verbatim** | Location |
|---|---|---|---|
| `MM-PO-002` | Edit / activate / deactivate plan | *"Owner/Manager class"* | **L1321** |
| `MM-PO-011` | Change a membership configurable (`MM-CFG-*`) | *"Owner class; `BC-25` performs the write"* | **L1330** |

⛔⛔ **Those Notes cells are NOT role allocations, and this ADR does not treat them as any.** `ADR-0019` **L103**
ratified at freeze that *"`MM-PO-001`…`011` name the protected operations **without modelling a role**"*, and
`PRD-005_IMPLEMENTATION_TASKS.md` **L268** states expressly *"**no role defined here**"*. Measured: `PRD-005`'s
protected-operation register contains **0** `TR-n` identifiers.

⭐ The **Student** (`TR-4`) must be able to *ask* for a plan or configuration change without holding the authority
to *make* one. `prd-v2/02` **L202** scopes `TR-4` to *"Own records"*; `AP-3` (`prd-v2/07` **L51**) makes absence of
authorisation a **deny**. So a request concept is required, and its authorization must be allocated by a competent
instrument. ⛔ No such allocation exists anywhere in the repository — which is why this ADR exists.

---

## 2. The decisions

### 2.1 `D-1` — Request lifecycle (**T-3**)

⭐ A change request **SHALL** carry exactly one state from the closed set:

| From | To | Trigger | Actor |
|---|---|---|---|
| — | `Pending` | Student raises the request | `TR-4` Student |
| `Pending` | `Approved` | Authorised staff approve; conditions re-evaluated at approval time | staff (§2.2) |
| `Pending` | `Rejected` | Authorised staff reject; reason **required** (§2.5) | staff (§2.2) |
| `Pending` | `Cancelled` | The requesting Student cancels (§2.6) | `TR-4` Student |
| `Pending` | `Expired` | Decision deadline elapsed | system |

- ⭐ **`Pending` is the ONLY non-terminal state.** `Approved`, `Rejected`, `Cancelled` and `Expired` are **terminal**.
- ⛔ **Any transition not in the table above MUST be impossible.**
- ⛔⛔ **A `Pending` request MUST NOT create, hold, reserve, mutate or pre-commit** the `MembershipPlan`, any
  `MM-CFG-*` value, or any `Membership`. **It is a request record only.**
- ⭐ Eligibility and conditions **MUST** be evaluated at **approval** time, not at request time. Where approval
  fails, the request **MUST** remain `Pending`.
- ⭐ Every automatic transition to `Expired`, and every transition to `Cancelled`, **MUST** record its cause.
  A terminal state without a recorded cause **MUST NOT** be possible.
- ⭐ A terminal request **MUST** be retained. ⛔ It **MUST NOT** be deleted.
- ⛔⛔ **`Submitted`, `UnderReview` and `Withdrawn` are NOT adopted.** Measured repo-wide across `docs/` and
  `lib/`: **0** occurrences of each as a status token.

**Fixed V1 constants** — ⛔ **not configurables:**

| Constant | Value |
|---|---|
| Decision deadline after which a `Pending` request becomes `Expired` | **7 days** |
| Maximum concurrent `Pending` requests per Student | **1** |

⭐ A `Cancelled` request **MUST NOT** count toward the concurrency constant — it is terminal, not `Pending`.

**Authority.** `SEAT-FR-070` (`PRD-006`, FROZEN, Rank 3) **L660-661** states the identical closed set:
*"A request **MUST** have exactly one state from the closed set: `Pending` · `Approved` · `Rejected` ·
`Cancelled` · `Expired`."* The closure form follows `MM-FR-074` **L623**; terminality follows `MM-FR-075`
**L639-640**; *"request record only"* follows `SEAT-FR-069` **L657-658**; approval-time re-evaluation follows
`SEAT-FR-072` **L666-668** and `SEAT-FR-129` **L1020-1021**; recorded cause follows `SEAT-FR-126` **L1005-1006**;
retention follows `SEAT-FR-061` **L622-623**.

⭐ The **7 days** and **1** figures are the defaults two independently frozen PRDs already carry —
`SEAT-CFG-007` **L1908** and `MM-CFG-007` **L1214** (both 7 days), `SEAT-CFG-006` **L1907** (1).
⛔ They are adopted as **fixed V1 constants rather than configurables** because `PRD-005` §13.4 **L1202** closes
`MM-CFG-*` at **nine**, and creating a tenth is not within this act. ⭐ The fixed-not-configurable shape is
precedented: BC Map **L540** records `ADR-0036`'s window as *"**FIXED and mandatory in V1**"* and *"⛔ **NOT
tenant-configurable** — `BC-25` does **not** own it."*

### 2.2 `D-2` — `MM-PO-002` approval is split by **operation** (**T-5 / C-A = A-2**)

⭐ For a request concerning **`MM-PO-002` Edit / activate / deactivate plan**:

| Requested operation | `TR-1` Owner | `TR-2` Manager | `TR-3` Reception | `TR-4` Student | `TR-5` Parent |
|---|---|---|---|---|---|
| **Edit** a plan | ⭐ **Approve — ALLOW** | ⛔ **DENY** | ⛔ **DENY** | ⛔ **DENY** | ⛔ **DENY** |
| **Activate / deactivate** a plan | ⭐ **Approve — ALLOW** | ⭐ **Approve — ALLOW** | ⛔ **DENY** | ⛔ **DENY** | ⛔ **DENY** |

**Authority.** `MM-FR-018` **L263** already enumerates the operations as distinct: *"A plan **MUST** support:
create, **edit**, **activate**, **deactivate**, and list."* ⭐ The split therefore uses a distinction the frozen
PRD itself draws; ⛔ no new operation is invented.

⭐⭐ **`TR-2`'s inclusion on activate/deactivate does not cross the commercial-configuration restriction, and the
ground is a frozen `MUST NOT`:** `MM-FR-019` **L265-266** — *"Deactivation (`isActive: false`) **MUST NOT** delete
the plan, **MUST NOT** alter any existing membership, and **MUST NOT** alter any price snapshot."* `MM-FR-021`
**L270-271** makes deactivation the mandated retirement path. `PRD-005` §2.5 **L286** records `isActive` as
*"Editable"* with **no** commercial qualifier, against `price` and `durationDays` (*"future-effective only"*) and
`currency` (*"IMMUTABLE"*); and `MM-FR-023` **L294-295** names the economically significant fields as
`price`, `durationDays` and `eligibilityRule` — ⛔ **`isActive` is not among them.**

⭐ `TR-2` holds positive authority for exactly this class of act: `prd-v2/02` **L167** — *"Day-to-day operational
management"*. Its restriction at **L169** and **L200** reaches *"library-level **commercial** configuration"*, and
`PRD-023` **L956** (FROZEN, Rank 3) records that this restriction operates *"by **subject**, not by scope"*,
classifying `TR-2` as *"**A partial writer**"* — ⛔ **not** a non-writer.

⛔⛔ **NO COMMERCIAL FIELD SET IS DEFINED, INFERRED, IMPLIED OR RESERVED BY THIS ADR.** `PRD-023` `CNF-BR-008`
**L991** with its note **L996-999** places that determination with *"the parameter's **owning PRD**"* —
*"Only the owning PRD knows whether its parameter is commercial"* — and `PRD-005` has never made it. ⭐ **Option
A-2 was selected precisely because it requires no such set**, and this ADR does not supply one.

⛔ **`TR-3` receives no Approve** — `prd-v2/02` **L176** (*"Cannot alter library configuration"*), **L201**
(financial visibility *"None"*), `PRD-023` **L957** (*"Not a writer"*).
⛔ **`TR-4` and `TR-5` receive no Approve** — `prd-v2/02` **L202-203**; `PRD-023` **L958-959** (*"Not a writer"*);
`AC-7.18` **L492** (*"Temporary access requested and approved by the same account is refused"*); and `TR-5` is
additionally read-only with `SM-GAP-4` **L1170** open under the `SM-8.4a` **L880** interim deny.

### 2.3 `D-3` — **Approve ≠ Update**, expressly preserved

⭐⭐ **An approval grant under `D-2` or `D-4` confers NO authority to execute the underlying operation.**

- ⭐ **`TR-2`'s approval of an activate/deactivate request does NOT itself grant `TR-2` execution or update
  authority over the `MembershipPlan`.** The two are **separately granted** capabilities.
- ⛔ The underlying `MM-PO-002` and `MM-PO-011` **Update** authority is **pre-existing and UNCHANGED by this ADR**.
- ⛔ **Read confers no Approve. Approve confers no Update. Update confers no Approve.**

**Authority.** `AUTH-7.24` **L151-152** — each action class *"**MUST** be granted independently"*. `AUTH-7.25`
**L154** — ***Approve*** *"**MUST** always be granted explicitly, and **MUST NOT** be implied by any other action
on the same resource."* `AC-7.12` **L486** — *"Granting Read confers no Create, Update, Delete, Approve or
Export."* `AUTH-7.35` **L213** — *"Permissions **MUST NOT** be inherited between roles, between scopes or between
tenants. Every grant is direct."* `AUTH-7.28` **L182** — no hierarchy. `AP-7`/`AUTH-7.10` **L55** — *"Owner is an
enumerated permission set, not 'everything Manager has, plus more'."*

⭐ The repository's own worked rationale for this separation is `MM-NFR-008` **L1332**: without it *"the payment
gate is decorative."* The same logic applies here — an approval grant that silently carried execution would make
the operation split in `D-2` decorative.

### 2.4 `D-4` — `MM-PO-011` approval is `TR-1` Owner only (**T-5**)

⭐ For a request concerning **`MM-PO-011` Change a membership configurable**:

| `TR-1` Owner | `TR-2` Manager | `TR-3` Reception | `TR-4` Student | `TR-5` Parent |
|---|---|---|---|---|
| ⭐ **Approve — ALLOW** | ⛔ **DENY** | ⛔ **DENY** | ⛔ **DENY** | ⛔ **DENY** |

**Authority.** `PRD-023` **L955** (FROZEN, Rank 3) — `TR-1` is *"**The only tenant role with unrestricted
configuration write authority at its library**"*; **L956** `TR-2` *"A partial writer"*; **L957** `TR-3` *"Not a
writer"*. `prd-v2/02` **L169** bars `TR-2` from commercial configuration and **L176** bars `TR-3` from library
configuration. ⭐ `MM-CFG-001` **L1208** is *"Tenant default currency"* — a commercial value. ⭐ Structural
analogue: `SEAT-PO-021` **L2005**, *"Change a module configurable owned by `BC-25`"* — Owner **Y**, Manager **—**,
Reception **—**.

### 2.5 `D-5` — Decision note (**T-6**)

- ⭐ On **`Rejected`**: a decision reason is **REQUIRED**.
- ⭐ On **`Approved`**: a decision reason is **OPTIONAL**.
- ⭐ Where a structured reason set applies, free text is stored **in addition to, never instead of**, the
  structured code.
- ⭐⭐ The **Student's message** and the **staff decision note** are **separate fields and separate concepts**.
  ⛔ They **MUST NOT** be merged, conflated or rendered as one another.
- ⭐ The Student's message remains **optional** and **supplements** a structured requested-change descriptor.
  ⛔ Free text **MUST NOT** become the sole machine-readable meaning of a request.
- ⭐ Decision facts are recorded through the **existing audit architecture** — `E-20` → `BC-24`.
- ⛔⛔ **No new `MM-EVT-*` is created to carry the note, or for any other purpose** (see `D-11`).
- ⛔ No event payload may carry a mobile number, name, email, photograph or any `BC-10` profile field.

**Authority.** `SEAT-FR-071` **L663-664** and `SEAT-FR-128` **L1017-1018** each require *"a reason mandatory on
rejection"* — the asymmetry stated twice, both frozen; ⛔ **no frozen requirement mandates a reason on approval.**
The storage shape is `SEAT-FR-224` **L1590-1591** (*"in addition to, never instead of, the closed-set code"*),
`SEAT-FR-223` **L1586-1588** and `SEAT-FR-060` **L619-620**. The structured-plus-optional-text request shape is
`SEAT-FR-068` **L654-655**. Audit routing is BC Map **L329** (`E-20`, *"Domain never calls audit synchronously"*)
with `PRD-005` **L172** (*"Emits audit events; **stores no audit log**"*) and `MM-FR-022` **L291-292**. The payload
prohibition is `MP-GBR-34` (`MASTER_PRD` **L462**) and `MM-BR-015` **L1018**.

⛔⛔ **NO PII RULE, REDACTION RULE OR MAXIMUM-LENGTH RULE IS CREATED BY THIS ADR** (§8).

### 2.6 `D-6` — Student self-cancellation (**T-7**)

⭐ A Student **MAY** cancel **their own** request, and only:

- at **`Self`** scope; ⛔ never another Student's request;
- while the request is **`Pending`**; ⛔ never after `Approved`, `Rejected` or `Expired`;
- producing the terminal state **`Cancelled`**, with actor and cause recorded;
- ⛔ the request is **closed, not deleted**.

⛔⛔ **Cancelling a request is NOT membership cancellation.** It **MUST NOT** be presented to users as
*"cancel membership"*, **MUST NOT** cancel or alter an `Active` membership, and **MUST NOT** trigger a refund.
⛔ It creates **no** new action class and **no** permission identifier — it is **Update at `Self` scope** on a
record the Student created.
⭐ After cancelling, a Student **MAY** submit a new request, subject to whatever anti-abuse architecture already
exists. ⛔ **No rate-limit value is created by this ADR** (§9, note b).

**Authority.** `SEAT-FR-073` **L670** — *"A student **MUST** be able to cancel their own `Pending` request."*
`SEAT-PO-023` **L2007** allocates it Owner **—** / Manager **—** / Reception **—** / Student **Y (`self`)**.
`SEAT-AC-059` **L2423** — *"the student cannot cancel another student's request."* `SEAT-FR-077` **L689-690**;
`SEAT-FR-078` **L692**; `AC-7.10` **L484**. Terminality: `MM-FR-075` **L639-640**. Retention: `SEAT-FR-061`
**L621-622**. ⛔ The membership boundary is `MM-FR-079` **L663-665** — *"**MUST NOT** be extended to an `Active`
membership, **MUST NOT** trigger a refund, and **MUST NOT** be presented to users as \"cancel membership\""* —
with `MM-XC-011` **L190** (cancellation with refund is **V2**). ⛔ No notification fact is emitted on
holder-initiated cancellation: `SEAT-FR-125` row **A5 L1003**.

### 2.7 `D-7` — `TR-3` request read is field-restricted (**C-B = B-1**)

⭐ `TR-3` Reception **MAY** read a change request, **field-restricted**. `TR-3` **MAY** see:

- request existence · requester identity **only to the extent already authorised** · request type ·
  status · timestamps · non-commercial requested-change information.

⛔ `TR-3` **MUST NOT** see `price`, `currency`, or any other value the frozen role model denies to Reception.

⭐ The restriction is enforced at the **read model** and the restricted field **SHALL** be presented as restricted
rather than silently omitted where a surface would otherwise display it.

**Authority.** ⭐⭐ `PRD-023` `CNF-BR-010` **L1004-1005** (FROZEN, Rank 3) — *"**Read authority SHALL NOT be
assumed to follow write authority.** A role that may read an effective value **MAY** be unable to write it, and
the reverse **SHALL NOT** be inferred"* — with its note **L1007-1009**: *"`TR-3` Reception cannot alter library
configuration, **yet Reception's screens plainly depend on resolved configuration to function**. Collapsing the
two would either break Reception or grant it writes."* `CNF-FR-081` **L1198** — *"A parameter the current actor
may read but not write **SHALL** be presented as such."*

⭐ The field-restriction shape against `TR-3` specifically is already frozen in `PRD-004` §8.2: `SM-PO-2` **L868**
grants `TR-3` *"View member detail"* while `SM-PO-10` **L876** denies `TR-3` *"View sensitive data"* — two
protected operations over one entity. `MM-NFR-010` **L1344** shows `BC-02` already restricting a read by field.

⭐⭐ **`AC-7.8` (`prd-v2/07` L482) IS PRESERVED LITERALLY, NOT WEAKENED** — *"A Reception holder is denied
financial permissions **regardless of other roles held anywhere**."* `TR-3` receives **no financial permission**
here; it receives a **non-financial view**. ⛔ Nothing in this ADR grants Reception any financial or commercial
value.

⚠️ **The exclusion list depends on the commercial-field determination this ADR expressly does not make (§2.2).**
Until that determination exists, the restriction is stated by **rule** — exclude values the frozen role model
denies Reception — and ⛔ **not** by an enumerated list. Recorded as a known limit, not concealed.

### 2.8 `D-8` — Request authority and record belong to `BC-02` (**AO-2**)

⭐ The change-request record, and authority over it, belong to **`BC-02` Membership Management**.
⛔ `BC-25` Configuration does **not** own the request, even for an `MM-PO-011` request.
⭐ `BC-25` performs the configuration **write** only, and the write arrives **already authorised**.

**Authority.** `PRD-023` `CNF-BR-008` **L991** — *"Authority over a parameter **SHALL** be determined by the
parameter's **owning PRD**… This module **SHALL NOT** hold a table of which role may write which parameter."*
`CNF-XC-014` **L1011** — `BC-25` *"**MUST NOT** define, amend, extend, interpret or store the definition of any
role, nor the authority attached to one."* `CNF-FR-064` **L969** — *"Every write **SHALL** be authorised **before**
it reaches this module."* `CNF-FR-065` **L972** — actor and scope are **explicit arguments**, never inferred.
`E-19` (`PRD-005` **L974**; BC Map **L328**) already carries the `BC-02` → `BC-25` typed accessor path.

### 2.9 `D-9` — No new aggregate root, and no BC Map row (**AO-3**)

⛔⛔ **This ADR creates no aggregate root, adds no BC Map §8 row, and mints no bounded context or edge.**

**Authority.** ⭐ The repository's only comparable frozen request workflow — `PRD-006` §10, `SEAT-FR-068`…`075`,
with its own closed status set, approval step, expiry and student cancellation — carries **no aggregate row
whatsoever**. BC Map **L374** lists `BC-04 Seating` as `SeatAllocation` · `SeatLayout`, with key entities `Seat`,
`Floor`, `SeatCategory`, `OccupancySnapshot`; ⛔ **the seat-change request appears in neither column.**
`PRD-006` **L148** states the boundary deliberately: `SeatAllocation` is *"**The transaction boundary**"* — *"Not:
the seat itself; **a reservation**; an attendance punch."*

⚠️ **A pre-existing Rank-4 divergence is disclosed, NOT repaired here:** BC Map §8 **L371** lists
`MembershipPlanRef` (a value object) among `BC-02`'s key entities and names **`Membership`** as the sole aggregate
root, while `MM-FR-006` **L206** requires *"`MembershipPlan` **MUST** be a separate aggregate root."*
⛔ **This ADR does not resolve it** — it is unrelated to the request workflow and predates it.
**Owner: Architecture Owner (BC Map).**

### 2.10 `D-10` — Search stays local to `BC-02` (**AO-4**)

⭐ Request and plan lookup **SHALL** use local `BC-02` matching. ⛔ **No `BC-23` Search Indexing involvement, and
no new `E-2x` edge.**

**Authority.** ⭐ This **preserves an existing decision rather than taking a new one.** `MM-GAP-004`
(`PRD-005` **L1763**) already records the resolution: *"Should membership search use `BC-23`, requiring a new
`E-2x` edge? — Architecture — **No — local match suffices at V1 scale**."* `MM-FR-030` **L329** specifies the
local match, and its note **L331-335** records that *"There is **no `BC-02` → `BC-23` edge**, and line 292 holds
that 'if an edge is not in this table, it does not exist and adding it requires an ADR.'"* `PRD-005` **L1707**
classifies a membership search index **"D — Not needed"**; **L1722** preserves the existing decision.

### 2.11 `D-11` — No new domain event (**AO-10**)

⛔⛔ **No `MM-EVT-*` is created, renamed or extended.** The `BC-02` event register remains **closed at seven**.

**Authority.** `MM-BR-035` **L1043** — the register *"**MUST** be closed at **seven**. Adding, removing or
renaming an `MM-EVT-*` **MUST** require a new version of this document."* ⭐ Precedent that a request workflow
needs no event: `SEAT-FR-206` **L1469** closes `BC-04`'s events at four, and **none of the four** is emitted by
`PRD-006` §10's request workflow. ⭐ Request facts reach `BC-24` on `E-20` (BC Map **L329**), which `PRD-005`
**L172** already relies on.

### 2.12 `D-12` — `BC-28` Workflow Orchestration is unavailable in V1 (**AO-5**)

⛔ Request review **SHALL NOT** be routed through `BC-28`.

**Authority.** BC Map **L137** classifies `BC-28` Workflow Orchestration as **V2**; **L147** lists it among the
six V2 contexts. `MM-GAP-010a` (`PRD-005` **L1772**) records that BC Map §7 *"declares **no edge to `BC-28` at
all**."*

### 2.13 `D-13` — Approval and execution are separate transactions (**AO-7**)

⭐ Approving a request and executing the underlying operation **SHALL** occur in **separate transactions**.
⛔ They **MUST NOT** be committed as one.

**Authority.** BC Map §8 **L366** — *"**The aggregate is the transaction boundary** — one aggregate, one database
transaction, no exceptions."* `MM-FR-006` **L206-207** — *"Editing a plan **MUST NOT** occur in the same
transaction as creating or renewing a membership."* ⭐ `SEAT-FR-072` **L666-668** confirms the split behaviourally:
an approval may **fail** and leave the request `Pending`, which is only expressible if the two are not one
transaction.

### 2.14 `D-14` — Field restriction is enforced at the read model (**AO-8**)

⭐ The `D-7` restriction **SHALL** be enforced at the **read model / projection**, not by post-hoc filtering in a
client, and not by a second copy of the authority model.

**Authority.** `CNF-FR-081` **L1198** states it as a presentation obligation; `MM-NFR-010` **L1344** expresses the
equivalent `BC-02` rule as a view rule; `PRD-004` `SM-PO-2` / `SM-PO-10` **L868**/**L876** express the same split
in the protected-operation register. `CNF-XC-006` (`PRD-023` **L812**) forbids a module making, caching, storing
or evaluating an authorisation decision — so the decision remains `BC-18`'s and the **projection** merely honours
it.

### 2.15 `D-15` — The `PRD-023` configuration write path remains authoritative (**AO-9**)

⭐ For `MM-PO-011`, the existing `PRD-023` write contract is **unchanged and authoritative**: the write reaches
`BC-25` **already authorised** (`CNF-FR-064` **L969**), carrying **actor** and **scope** as explicit arguments
(`CNF-FR-065` **L972**), through no unauthorised surface (`CNF-FR-066` **L975**), with a refused write leaving
configuration unchanged and reported with a reason (`CNF-FR-067` **L985**).
⛔ **This ADR adds nothing to that path and modifies none of it.**

---

## 3. Authorization treatment

⭐⭐ **The allocation is expressed as a DERIVED CAPABILITY, not as an enumerated permission.**

`ADR-0132` (`Accepted`) §5.1 **L151** and §5.3 **L179** record the derived-capability mechanism as *"the lawful
route"*, measured in active use across **253** identifiers in three families (`LCF-AUTH-*`, `LCM-AUTH-*`,
`LCO-AUTH-*`), all baselined at **Rank 3** by `Accepted` `ADR-0087`, and ⛔ **none of the 253 claims to be a
permission**. The per-role treatment form is `LCM-AUTH-007` (`PRD-021A` **L438**): every role stated **explicitly**,
with no inheritance, and an interim **DENY** with a **named** open item wherever authority is absent.

### 3.1 The complete allocation — every role, every action, every scope

| # | Capability | Action | Scope | `TR-1` | `TR-2` | `TR-3` | `TR-4` | `TR-5` |
|---|---|---|---|---|---|---|---|---|
| 1 | Create a change request (`MM-PO-002`) | **Create** | **`Self`** | — | — | — | ⭐ **ALLOW** | ⛔ DENY |
| 2 | Create a change request (`MM-PO-011`) | **Create** | **`Self`** | — | — | — | ⭐ **ALLOW** | ⛔ DENY |
| 3 | Read own change request | **Read** | **`Self`** | — | — | — | ⭐ **ALLOW** | ⛔ DENY |
| 4 | Read a change request (`MM-PO-002`) | **Read** | **`Tenant`** | ⭐ ALLOW | ⭐ ALLOW | ⭐ **ALLOW, field-restricted** (`D-7`) | ⛔ DENY | ⛔ DENY |
| 5 | Read a change request (`MM-PO-011`) | **Read** | **`Tenant`** | ⭐ ALLOW | ⭐ ALLOW | ⭐ **ALLOW, field-restricted** (`D-7`) | ⛔ DENY | ⛔ DENY |
| 6 | Approve/reject a request to **edit** a plan | **Approve** | **`Tenant`** | ⭐ **ALLOW** | ⛔ **DENY** | ⛔ DENY | ⛔ DENY | ⛔ DENY |
| 7 | Approve/reject a request to **activate/deactivate** a plan | **Approve** | **`Tenant`** | ⭐ **ALLOW** | ⭐ **ALLOW** | ⛔ DENY | ⛔ DENY | ⛔ DENY |
| 8 | Approve/reject a request to change a configurable (`MM-PO-011`) | **Approve** | **`Tenant`** | ⭐ **ALLOW** | ⛔ **DENY** | ⛔ DENY | ⛔ DENY | ⛔ DENY |
| 9 | Cancel one's own `Pending` request | **Update** | **`Self`** | — | — | — | ⭐ **ALLOW** | ⛔ DENY |
| 10 | Execute `MM-PO-002` | **Update** | **`Tenant`** | ⛔ *pre-existing, UNCHANGED by this ADR* | | | ⛔ DENY | ⛔ DENY |
| 11 | Execute `MM-PO-011` | **Update** | **`Tenant`** | ⛔ *pre-existing, UNCHANGED by this ADR* | | | ⛔ DENY | ⛔ DENY |

⭐ **Legend.** **ALLOW** / **DENY** are stated per role explicitly. **—** means the capability is not applicable to
that role (rows 1–3 and 9 are Student-authored records at `Self` scope; rows 10–11 carry no allocation because
this ADR does not touch the pre-existing execution authority).

### 3.2 Invariants re-verified against this allocation

| Invariant | Holds | Authority |
|---|---|---|
| ⛔ No role inheritance | ✅ | `AUTH-7.35` **L213** · `AUTH-7.28` **L182** · `AP-7` **L55** |
| ⛔ No permission implied by another | ✅ | `AUTH-7.24` **L151-152** · `AUTH-7.25` **L154** · `AC-7.12` **L486** |
| ⭐ Read ≠ Approve ≠ Update | ✅ | Rows 4–8 vs 10–11; `D-3` |
| ⭐ Student is `Self` only | ✅ | `AC-7.10` **L484** · `AUTH-7.29` **L184** (Self ⊂ Linked ⊂ Tenant, never widened) |
| ⛔ Student holds no `Tenant` authority | ✅ | Rows 1–3, 9 are all `Self` |
| ⛔ Parent receives no Approve | ✅ | `prd-v2/02` **L203** · `PRD-023` **L959** · `SM-8.4a` **L880** |
| ⛔ Reception receives no financial permission | ✅ | `AC-7.8` **L482** preserved literally by `D-7` |
| ⛔ Manager crosses no commercial boundary | ✅ | `MM-FR-019` **L265-266**; `isActive` absent from `MM-FR-023` **L294** |
| ⭐ Deny-by-default for anything unstated | ✅ | `AP-3` **L51** · `AUTH-7.36` **L218-227** rows 4–5 · `AUTH-7.37` |
| ⭐ Action vocabulary unchanged | ✅ | Only **Read · Create · Update · Approve**, all in `prd-v2/07` **L141-151** |
| ⭐ Scope vocabulary unchanged | ✅ | Only **`Self`** and **`Tenant`**, both in `prd-v2/07` **L164-169** |

### 3.3 What is NOT created

⛔⛔ **Zero permission identifiers.** ⛔ No `PERM-*` token, no dotted token, no category–action pair, no
provisional name, no placeholder, **no example**. `AUTH-7.22` (`prd-v2/07` **L124**) remains **closed at zero
enumerated permissions**, exactly as `ADR-0132` retained it. ⛔ **`ADR-0132` is NOT reopened, amended or
superseded**, and ⛔ **none of its §7 prerequisites is engaged** — this act mints nothing.

⛔ No new action class · no new scope class · no new role · no new event · no new aggregate · no new bounded
context · no new edge · no new configuration identifier · no new `MM-PO-*` register entry · no `TS-*` · no rank.

---

## 4. Options considered and rejected

### 4.1 `MM-PO-002` approval (`C-A`)

| Option | Disposition |
|---|---|
| **A-1** — split by **field**: `TR-2` approves non-commercial fields | ⛔ **Not selected.** It is internally coherent and precedented by `PRD-005` §2.5 **L277-288**, but it **requires a commercial field set that no document defines** — `CNF-BR-008` **L991** assigns that determination to the owning PRD, and `PRD-005` has never made it |
| **A-2** — split by **operation** | ⭐⭐ **SELECTED.** Uses a distinction `MM-FR-018` **L263** already draws, and rests on a frozen **MUST NOT** (`MM-FR-019` **L265-266**) rather than on a classification the repository never made |
| **A-3** — `TR-1` only | ⛔ **Eliminated by repository authority.** `PRD-023` **L956** classifies `TR-2` as *"**A partial writer**"*, distinct from `TR-3`/`TR-4`/`TR-5` at **L957-959** (*"Not a writer"*). A-3 collapses `TR-2` into the non-writer row, contradicting a frozen Rank-3 classification |
| **A-4** — retain unrestricted `TR-2` approval and distinguish later | ⛔ **Eliminated by repository authority.** `PRD-023` **L956** establishes that the restriction operates *"by **subject**"*. An unrestricted allocation is not a distinction from a subject-matter restriction; it is its negation |

### 4.2 `TR-3` request read (`C-B`)

| Option | Disposition |
|---|---|
| **B-1** — field-restricted read | ⭐⭐ **SELECTED — uniquely surviving.** Required in shape by `CNF-FR-081` **L1198**, permitted by `CNF-BR-010` **L1004-1005**, precedented against `TR-3` by `SM-PO-2`/`SM-PO-10` **L868**/**L876**, and preserves `AC-7.8` **L482** literally |
| **B-2** — read `MM-PO-011` requests only | ⛔ **Eliminated as internally incoherent.** `MM-CFG-001` **L1208** is *"Tenant default currency"* — commercial. B-2 relocates the exposure rather than removing it, and still requires field restriction |
| **B-3** — no read at all | ⛔ **Eliminated by frozen authority.** It performs exactly the inference `CNF-BR-010` **L1004** forbids — deriving "no read" from "no write" — and its note **L1007-1009** warns that collapsing the two *"would either break Reception or grant it writes"* |

⚠️ **These dispositions distinguish the frozen texts; they do not amend, weaken or read down any of them.**
`prd-v2/02`, `prd-v2/07`, `PRD-023`, `PRD-004`, `PRD-005` and `PRD-006` are **byte-unchanged**.

---

## 5. What this ADR does NOT decide

⛔ It does **not** define, infer, imply or reserve a **commercial field set** (§2.2).
⛔ It does **not** resolve **`G-8`** (§9).
⛔ It does **not** resolve any **privacy** question (§8).
⛔ It does **not** determine the **`PRD-005` instrument form** — `G-9` (§10).
⛔ It does **not** amend `PRD-005`, `DD-0001`, `TRACEABILITY_MATRIX.md` or `DOCUMENTATION_BASELINE.md`.
⛔ It does **not** mark `DD-0001` Declaration 3 as `PASS` (§11).
⛔ It does **not** confer implementation authority (§12).
⛔ It does **not** resolve the BC Map §8 `MembershipPlan` divergence disclosed at `D-9`.
⛔ It does **not** close `MM-GAP-004`, `MM-GAP-005`, `MM-GAP-010`, `MM-GAP-010a`, `SM-GAP-4`, `SM-GAP-5` or
`SEAT-GAP-010`; each is **cited** where relevant and left in its recorded state.

---

## 6. Consequences

⭐ A Student may raise a change request without holding any authority to make the change.
⭐ Every role's treatment is stated explicitly, with no inheritance and no implied approval.
⭐ The commercial-configuration boundary and the Reception financial boundary are both preserved **literally**.
⭐ No new architectural surface is required: no edge, no event, no aggregate, no BC Map row, no configurable.
⚠️ The workflow is **not implementable** until §10 completes — this ADR authorises the decision, not the code.

---

## 7. Architecture Owner items — status

| # | Item | Status |
|---|---|---|
| `AO-1` | Deadline / concurrency as configurables | ⭐ **RESOLVED** — fixed V1 constants (`D-1`) |
| `AO-2` | `BC-02` vs `BC-25` request ownership | ⭐ **RESOLVED** (`D-8`) |
| `AO-3` | Aggregate root / BC Map row | ⭐ **RESOLVED — none required** (`D-9`) |
| `AO-4` | `BC-23` search extension | ⭐ **RESOLVED — local match** (`D-10`) |
| `AO-5` | `BC-28` Workflow routing | ⭐ **RESOLVED — unavailable in V1** (`D-12`) |
| `AO-6` | Structured descriptor leaking commercial information | ⚠️ **MOOT for approval** — `A-2` requires no field set. ⚠️ A narrow read-side residue folds into `D-7`, whose exclusion is stated by rule. **NON-BLOCKING** |
| `AO-7` | Approval → execution transaction boundary | ⭐ **RESOLVED — separate transactions** (`D-13`) |
| `AO-8` | Field-restriction enforcement point | ⭐ **RESOLVED — read model** (`D-14`) |
| `AO-9` | `PRD-023` configuration write path | ⭐ **RESOLVED — unchanged and authoritative** (`D-15`) |
| `AO-10` | New domain event | ⭐ **RESOLVED — none** (`D-11`) |

---

## 8. Privacy — open, and deliberately not decided

⛔⛔ **NO PRIVACY RULE IS CREATED BY THIS ADR.** The following remain **OPEN** and **NON-BLOCKING**:

| # | Item | Recorded at |
|---|---|---|
| `P-1` | Student-authored free text has **no authoritative source anywhere in the repository** | `SM-GAP-5` (`PRD-004` **L1171**) — *"Not specified"* |
| `P-2` | Whether free text may contain PII, against `MM-NFR-009` **L1341** (*"MUST store no PII"*) | — |
| `P-3` | Maximum length / content constraints on either text field | — |
| `P-4` | Whether the staff decision note is visible to the requesting Student | ⚠️ counter-precedent `INV-SEC-043` **L335-338** |
| `P-5` | Whether free text may cross a context boundary | `SEAT-GAP-010` (`PRD-006` **L2262**) |
| `P-6` | Retention period for request records | `SM-GAP-1` **L1167**; `SEAT-GAP-013` **L2265** |

⭐ **Two are satisfied by construction, not by a new rule:** no event exists to carry a payload (`D-11`), so
`MP-GBR-34` and `MM-BR-015` are met structurally; and audit integrity rests on `E-20` (BC Map **L329**) with
`INV-SEC-051`, which makes audit records non-editable *"by any library role, including `TR-1` Owner."*

⚠️⚠️ **THE PRIVACY OWNER OFFICE IS CONSTITUTED BUT VACANT** (`ADR-0080` **L85**; recorded again at
`SPX-GAP-001`, `docs/design/SECURITY_PRIVACY_UX.md` **L67**). ⛔ **No privacy sign-off is claimed for this ADR.**

---

## 9. `G-8` — disclosed as an independent, pre-existing, NON-BLOCKING gap

⚠️⚠️ **Disclosed so that it is not mistaken for an oversight, and expressly NOT resolved here.**

`PRD-005` **L1444** requires the membership-creation flow to *"show the amount applicable"*; **L1442** requires the
plan list to show *"price with currency"*; `MM-PO-008` **L1327** *"Includes price snapshot"*. The operation that
needs them, `MM-PO-003` **L1322**, carries the Notes text *"Reception class and above"*. Meanwhile `AC-7.8`
**L482** denies Reception financial permissions *"regardless of other roles held anywhere."*

| Question | Answer |
|---|---|
| Caused by this workflow? | ⛔ **No.** All four citations predate it; `PRD-005` was frozen 2026-08-04 |
| Is it a CONFLICT between two frozen requirements? | ⛔ **No.** `MM-PO-003` **L1322** is a **prose Notes cell**, disclaimed as role-modelling by `ADR-0019` **L103**. A prose note asserts nothing normative, so there is nothing for `AC-7.8` to contradict |
| Does it block this ADR? | ⛔ **No.** Under `D-7` the request surface excludes commercial values, so this workflow adds **zero** new Reception price exposure |
| Is it resolved here? | ⛔ **No** — and ⛔ **it is not resolved by weakening `AC-7.8`, which is untouched** |

⭐ **Classification: independent NON-BLOCKING GAP.** **Owner: Product Owner + Authorization (`BC-18`/`PRD-001`)
Owner**, on a future `PRD-005` pass. ⭐ The disclose-don't-sweep treatment follows `MM-GAP-010` (`PRD-005`
**L1771**), where a pre-existing systemic defect surfaced by an unrelated pass was recorded and routed rather than
folded into that pass.

**Note (b) — an honest qualification on anti-abuse.** `D-6` permits re-submission *"subject to whatever anti-abuse
architecture already exists."* Measured: `PRD-005` contains **0** occurrences of *rate limit / rate-limit /
throttl*, and `prd-v2/07` contains **0**. The rate-limiting architecture that exists is scoped to authentication
and to invitations (`INV-SEC-057`…`062`, **L421-441**). ⭐ **The only control that actually applies to request
submission today is the concurrency constant of 1** in `D-1`. ⛔ **No rate-limit value is created here.** Whether
a cancel/re-submit cycle needs more is left open, **NON-BLOCKING**.

---

## 10. `G-9` — the `PRD-005` instrument form is **TO BE DETERMINED** by the Governance Owner

⭐⭐ **This ADR deliberately does not choose between the two lawful routes**, and records both with their
precedents so the determination can be made on evidence.

| Route | Precedent | Consideration |
|---|---|---|
| **In-place amendment**, `PRD-005` **v1.4 → v1.5**, `FROZEN` retained | ⭐ `ADR-0032` → `PRD-006` **v1.1** (changelog **L2888**): *"One requirement's field list widened in fidelity. `FROZEN` retained; Rank 3 unchanged… Applies `ADR-0032`, `Accepted`, **written before this document was touched** per `DOCUMENTATION_BASELINE.md` §7 step 1"* | ⚠️ That precedent turned expressly on the target enumeration being **open** — *"`SEAT-FR-103`'s field list contains **no** 'only', 'exactly' or 'no other'… so the enumeration was never closed."* ⚠️ `PRD-005` §16.3 **L1316** is expressly a *"closed list"* |
| **Successor PRD**, `PRD-005` **v1.4 byte-unchanged** | ⭐ `ADR-0130` §10 row 1 registers a `PRD-008` successor path | ⚠️ Heavier; may exceed the true size of the change |

⭐ **Two measurements that narrow the question, recorded as facts rather than as a recommendation:**
1. ⭐ `MM-BR-035`'s *"new version of this document"* trigger is **NOT fired** — `D-11` creates no event.
2. ⭐ `MM-PO-002` is cited in `PRD-005` at only **three** places — **L1321**, **L1420**, **L1629** — and `A-2`
   adds **no field set** and **no new register entry**, being expressible as a role-differentiated grant on the
   existing row (the shape `SEAT-PO-016` **L2000** / `SEAT-FR-028` **L329** already uses, where *"the grant is not
   implied by the Manager role"*).

⛔⛔ **THE FORM OF THE GOVERNANCE INSTRUMENT IS STILL TO BE DETERMINED ACCORDING TO THE REPOSITORY'S LAWFUL
PROCESS.** It is the **Governance Owner's** determination, taken under `DOCUMENTATION_BASELINE.md` §7
**L380-384**. ⛔ **Until it is made and executed, none of §2's decisions is lawfully published in a ranked
document**, and ⛔ **`PRD-005` v1.4 remains byte-unchanged.**

---

## 11. `DD-0001` Declaration 3 — remains `GAP`

⛔⛔ **This ADR does NOT mark `DD-0001` Declaration 3 as `PASS`, and `DD-0001` is not modified.**

`docs/35-design/README.md` §2B.3 **L367** requires Declaration 3 to state *"**Permission Scope** — the
authoritative operation×role source."* Measured: `DD-0001` is **805 lines**, **v0.2**, `PROPOSED`, containing
**0** `TR-n` identifiers and **0** `APP` identifiers.

⭐ **What changes:** every input Declaration 3 requires now exists as a **decided** allocation (§3.1).
⛔ **What does not:** a Design Doc is **UNRANKED** and must cite a **ranked** source; this ADR is Rank 2 and
competent to allocate, but the module-level statement belongs in the `PRD-005` instrument, which §10 has not yet
determined. ⭐ Under §2B.5 **L399** a missing declaration is **`GAP`**; **L400** reserves `CONFLICT` for a
source-vs-source contradiction, and `DD-0001` asserts nothing, so `GAP` is correct and `CONFLICT` would overstate.

⭐ **Declaration 3 may become `PASS` only after §10 completes.** ⚠️ Declarations 1, 2, 4 and 5 are **separate**
`GAP`s and are **not** addressed by this ADR.

---

## 12. Implementation

⛔⛔ **NO IMPLEMENTATION AUTHORITY IS CONFERRED, AND NO CODE IS WRITTEN.** Measured: **0** files changed under
`lib/`, `test/`, `tool/`, `packages/`, `android/` or `web/`.

Prerequisites, in order: ① this ADR `Accepted` · ② the §10 `PRD-005` instrument · ③ `TRACEABILITY_MATRIX.md`
(**L230** pins `MM-PO-n` at **11**) and any baseline consequence · ④ `DD-0001` Declaration 3 amendment · ⑤ design
· ⑥ implementation. ⚠️ `PRD-005` is **`FROZEN`, not `VERIFIED`** — **0 of 42** tasks and **0 of 97** acceptance
criteria are proven by a test.

---

## 13. Number allocation

⭐ **`ADR-0149` is the next lawful number, allocated by measurement:**

| Check | Result |
|---|---|
| Highest existing `ADR-0*` file | **`ADR-0147`** (134 ADR files incl. the index) |
| `ADR-0148` | ⛔ **Consumed as a name, not free.** `ADR-0147` §2.3 **L63** is titled *"`ADR-0148` — RAISED, NARROWED, WITHDRAWN AND CLOSED AT ZERO GOVERNANCE COST"* — an audit trail of an ADR deliberately not created. Reusing the number would collide with that record |
| `ADR-0145` | ⛔ **A disclosed deliberate gap**, not a free slot to backfill — `ADR-INDEX.md` **L1311**: *"`ADR-0145` IS SKIPPED — DISCLOSED, NOT CONCEALED"*, with its disposition reserved to the Governance Owner |
| `ADR-0149` | ⭐ **0 files · 0 occurrences repository-wide** — measured |

⭐ `ADR-INDEX.md` **L206**'s binding rule — *"Never reuse a number"* — is satisfied. ⭐ A **gap** is not a reuse,
and the register already carries deliberate gaps (`ADR-0066`…`0074`, `ADR-0088`…`0090`, `ADR-0145`).
⛔ **`ADR-0148` and `ADR-0150` are neither allocated nor reserved by this act.**

---

## 14. Changelog

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-18 | ⭐⭐ **Created and `Accepted`. The Student-raised Membership Plan / Configuration change-request workflow is established, and its authorization is allocated per role by DERIVED CAPABILITY.** Under a one-act joint **Product Owner + Architecture Owner** conferral; ⛔ both offices **revert on completion** (`ADR-0033` §7.1); ⚠️ **both exercised by one principal, so ⛔ no independent review, ARB quorum or Security audit is claimed.** ⭐ **Fifteen decisions `D-1`…`D-15`.** ⭐ **`C-A` resolved as `A-2`** — `MM-PO-002` approval splits **by operation**: `TR-1` for **edit**, `TR-1`+`TR-2` for **activate/deactivate**, on the frozen `MUST NOT` at `MM-FR-019` **L265-266** and the distinct-operation enumeration at `MM-FR-018` **L263**; ⛔ **A-3 and A-4 eliminated by `PRD-023` L956**, which classifies `TR-2` as *"a **partial writer** — the restriction is by **subject**, not by scope."* ⭐⭐ **`C-B` resolved as `B-1`** — `TR-3` retains a **field-restricted** read; ⛔ **B-2 eliminated as internally incoherent** (`MM-CFG-001` **L1208** is tenant default currency — commercial), ⛔ **B-3 eliminated** because it performs exactly the inference `CNF-BR-010` **L1004** forbids. ⭐ **`AUTH-7.22` REMAINS CLOSED AT ZERO** — ⛔ **0 permission identifiers**, ⛔ no `PERM-*`, no placeholder, no example; ⛔ **`ADR-0132` NOT reopened** and ⛔ none of its §7 prerequisites engaged. ⛔ **No new action class, scope class, role, event, aggregate, bounded context, edge, BC Map row, configurable or `MM-PO-*` entry.** ⭐ Eight AO items resolved (`AO-2`,`-3`,`-4`,`-5`,`-7`,`-8`,`-9`,`-10`); `AO-1` resolved as fixed constants; `AO-6` **moot for approval** because `A-2` needs no field set. ⛔⛔ **NO COMMERCIAL FIELD SET IS DEFINED OR INFERRED** — `CNF-BR-008` **L991** assigns that to the owning PRD and `PRD-005` has never made it; ⚠️ the `D-7` exclusion is therefore stated **by rule, not by list**, and that limit is disclosed rather than concealed. ⚠️ **`G-8` DISCLOSED as an independent, pre-existing, NON-BLOCKING gap** and ⛔ **not resolved** — `MM-PO-003` **L1322** is prose disclaimed by `ADR-0019` **L103**, so it is a **GAP, not a CONFLICT**, and ⛔ `AC-7.8` is untouched. ⚠️ **`G-9` EXPRESSLY LEFT TO THE GOVERNANCE OWNER** — whether `PRD-005` is amended **in place v1.4 → v1.5** (the `ADR-0032`/`PRD-006` **v1.1 L2888** precedent) or superseded (the `ADR-0130` §10 `PRD-008` precedent) is **TO BE DETERMINED by the repository's lawful process**; ⚠️ the precedent's own distinguishing test — whether the target enumeration is **open** — is recorded **against** the in-place route, since `PRD-005` §16.3 **L1316** is a *"closed list"*. ⚠️ **A pre-existing Rank-4 divergence is disclosed, not repaired**: BC Map §8 **L371** names `Membership` the sole `BC-02` aggregate root with `MembershipPlanRef` a VO, while `MM-FR-006` **L206** requires `MembershipPlan` be a separate root — **Architecture Owner**. ⛔ **Privacy items `P-1`…`P-6` remain OPEN**; ⛔ **no privacy rule invented**; ⚠️ **Privacy Owner VACANT** (`ADR-0080` **L85**) so ⛔ **no privacy sign-off is claimed**. ⛔ **`DD-0001` Declaration 3 remains `GAP`** and ⛔ is **NOT** marked `PASS`; `DD-0001` **byte-unchanged at 805 lines, v0.2, `PROPOSED`**. ⛔⛔ **NOTHING ELSE IS TOUCHED:** `PRD-005` **v1.4**, `PRD-004`, `PRD-006` **v1.1**, `PRD-023` **v0.1**, `prd-v2/02`, `prd-v2/07`, `MASTER_PRD`, BC Map, `ADR-0132`, `ADR-0019`, `TRACEABILITY_MATRIX.md` and `DOCUMENTATION_BASELINE.md` are **byte-unchanged**; ⛔ **0 files** under `lib/`, `test/`, `tool/`, `packages/`, `android/`, `web/`; ⛔ **no commit and no push performed by the authoring act**. ⭐ **§7 rule 1 satisfied** — the ADR is written **before** any amendment it contemplates. ⚠️ **Rule 4's limb is UNMET** — no Rank 1–3 document changes version — so the **current baseline identifier STANDS**. ⭐ **Number allocated by measurement** (§13): `ADR-0147` is the highest file, `ADR-0148` is **consumed** as the name of the withdrawal trail at `ADR-0147` §2.3 **L63**, `ADR-0145` is a **disclosed deliberate gap**, and **`ADR-0149` measures 0 files / 0 occurrences**; `ADR-INDEX` **L206**'s *"never reuse a number"* is satisfied, and ⛔ **`ADR-0150` is neither allocated nor reserved**. ⛔⛔ **NO IMPLEMENTATION AUTHORITY IS CONFERRED — 0 code files.** |
