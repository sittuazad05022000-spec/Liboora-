# PRD-006 ADDITIVE WIFI PRESENCE IMPACT REPORT

| Field | Value |
|---|---|
| **Type** | **READ-ONLY impact analysis.** Not a PRD, not an amendment, not an ADR, not a decision |
| **Subject** | [`PRD-006_ATTENDANCE-MANAGEMENT.md`](./PRD-006_ATTENDANCE-MANAGEMENT.md) **v1.4 `DRAFT`**, sha256 (16) **`28965ddbb4480a50`** |
| **Request** | Additive capability: **Wi-Fi Presence + Automatic Attendance + Study Hours** |
| **Date** | 2026-08-04 |
| **Version** | **v1.0** |
| **Files modified by this analysis** | **Zero.** No PRD, no ranked document, no governance file, no gate script, no code. Verified by hash at §0.1 |
| **Approvals asserted** | **None.** No ADR is created. No reviewer, ARB, PEA or Product Owner approval is claimed or implied |
| **Verdict** | ⛔ **NOT ADDITIVELY INSERTABLE AS SPECIFIED.** 13 conflicts, of which **3 are structurally decisive**. See §6 and §20 |

> **What this document is for.** The request asked for a read-only impact analysis *before* any amendment, and
> instructed: *"If the new feature conflicts with an existing MUST/EXCLUSION: STOP and report the exact conflict.
> Do not 'solve' it by silently changing the old rule."* That is what this document does. It reports conflicts. It
> resolves none of them, because resolving them is not within the authority of an analysis.

---

## 0. Method, and what was verified rather than assumed

Every rule quoted below was read from the file at the hash in the header, at the line number given. No rule is
paraphrased where the exact wording carries the constraint.

### 0.1 Hash verification — the protected set, measured at the end of this analysis

| sha256 (16) | File | State |
|---|---|---|
| `28965ddbb4480a50` | `PRD-006_ATTENDANCE-MANAGEMENT.md` | **Unchanged** — read only |
| `42405be29d392e14` | `docs/00-governance/DOCUMENTATION_BASELINE.md` | Unchanged |
| `5031fcc97a95980e` | `docs/00-governance/prd-ecosystem/PRD_LIFECYCLE.md` | Unchanged |
| `f8e71ce876c2b53b` | `docs/00-governance/prd-ecosystem/PRD_REGISTRY.md` | Unchanged |
| `110d533b144f029c` | `docs/00-governance/adr/ADR-INDEX.md` | Unchanged |
| `2ff06320e969baed` | `docs/00-governance/prd-ecosystem/PRD_OWNERSHIP_MODEL.md` | Unchanged |
| `e527df027664680e` | `docs/10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md` | Unchanged |
| `9895d244494372af` | `docs/10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md` | Unchanged |
| `51ba0d739a4c0bea` | `docs/40-implementation/TRACEABILITY_MATRIX.md` | Unchanged |
| `a587c65e2f451e02` | `docs/30-product/library/Library_PRD_v1.md` | Unchanged |
| `c8760a46a8a371a6` | `docs/30-product/seat-management/PRD-SEAT-MANAGEMENT.md` | Unchanged |
| `018dac636251008e` | `docs/00-governance/adr/ADR-0021-...configurable-defaults.md` | Unchanged |
| `b476f94e799a3cc3` | `docs/30-product/student-identity/Student_Identity_PRD_v1.md` | Unchanged |

### 0.2 Register sizes in the subject document, counted mechanically

`ATT-FR` **151** · `ATT-BR` **45** · `ATT-INV` **12** · `ATT-XC` **21** · `ATT-CFG` **24** · `ATT-NFR` **14** ·
`ATT-EVT` **4** · `ATT-PO` **14** · `ATT-AC` **213** · `ATT-GAP` **21 rows / 18 numbers**.

### 0.3 Four negative measurements that matter

```
grep -ci "bssid"                             → 0
grep -ci "ssid"                              → 0
grep -in "android"                           → 0 hits
grep -in "background|foreground service"     → 0 hits
grep -in "presence session|study hour"       → 0 hits
```

The document contains **no** network-identity vocabulary, **no** Android platform vocabulary, **no** background-
execution vocabulary, and **no** Study Hours or presence-session concept. This is not an omission to be filled in
passing — §10.4 records the first as a deliberate, owner-assigned gap (`ATT-GAP-007`), and the absence of the last
is a consequence of `ATT-BR-033` and of ownership held elsewhere (§6, conflicts 2 and 3).

---

## 1. Existing Wi-Fi behavior

**Located at §10, lines 670–714. Mode name `ATTENDANCE_MODE_FIXED_QR_WIFI` (mode 3 of six).**

| Aspect | The rule as written | Line |
|---|---|---|
| What Wi-Fi *is* | `ATT-BR-016` — *"Wi-Fi verification is an **environment verification** condition. It contributes evidence that the device was on an approved network at punch time."* | 675 |
| What Wi-Fi is **not** | `ATT-XC-014` — *"Wi-Fi **MUST NOT** be described, recorded or used as identity, authentication, or proof that a specific person was present. This module **MUST NOT** claim that Wi-Fi verification alone prevents attendance sharing."* | 679 |
| The flow | `ATT-FR-031` — *"authenticated Student App → Fixed QR scan → Wi-Fi verification → attendance validation → `AttendanceDay`. **Both parts of the condition MUST pass** for the mode to succeed."* | 689 |
| Configuration | `ATT-FR-032` approved network(s) configurable per tenant (`ATT-CFG-008`); `ATT-FR-033` owned by the **Owner** role, stored through **`BC-25`** via **`E-19`** | 695–696 |
| Failure — no Wi-Fi | `ATT-FR-034` distinguishable *"network unavailable"* | 697 |
| Failure — wrong network | `ATT-FR-035` distinguishable *"network not approved"* | 698 |
| No silent downgrade | `ATT-FR-036` — a Wi-Fi failure *"**MUST NOT** create an attendance record, and **MUST NOT** silently downgrade to `ATTENDANCE_MODE_FIXED_QR`"* | 699 |
| Evidence | `ATT-FR-037` outcome recorded as `VerificationEvidence` on the punch | 700 |
| Audit | `ATT-FR-038` Wi-Fi configuration changes **MUST** emit an audit fact (`E-20`) | 701 |
| Tenant isolation | `ATT-BR-017` — *"Wi-Fi configuration **MUST** be tenant-scoped; one tenant's approved network **MUST NOT** validate another tenant's attendance"* | 702 |
| Network identity | `ATT-XC-015` — *"This document **MUST NOT** specify how a network is technically identified or how a spoofed network would be detected… **`ATT-GAP-007`**"* | 708 |
| Claim limit | `ATT-FR-039` — *"Until `ATT-GAP-007` is answered, this mode **MUST NOT** be presented to an Owner as spoofing-resistant."* | 712 |
| Configurables | `ATT-CFG-003` mode enable (default **Disabled**); `ATT-CFG-008` approved network(s), default **Empty**, *"Non-empty when `ATT-CFG-003` enabled"*; `ATT-CFG-009` strictness, `strict` **only** in V1 | 1157, 1162, 1163 |
| Acceptance criteria | `ATT-AC-024` … `ATT-AC-033` — 10 criteria, §30.3 | 1838–1852 |

**The shape of the existing behavior, stated plainly.** Wi-Fi in PRD-006 today is a **synchronous, second condition
attached to a single QR scan**. It is evaluated once, at punch time. It produces one piece of evidence on one punch.
It is not a session, not a state, not a stream, and not a trigger. Its rationale blockquote (line 682) says why:

> *"Two students on the same network are indistinguishable to a network check. Wi-Fi raises the cost of remote
> attendance; it does not make proxy attendance impossible."*

---

## 2. Existing QR behavior

**Fixed QR at §8, lines 537–600. Dynamic QR at §9.**

| Aspect | The rule | Line |
|---|---|---|
| What a fixed QR is | `ATT-BR-009` — *"identifies the library / attendance context. It **MUST NOT** be treated as authentication, identity or a credential."* | 541 |
| Payload prohibition | `ATT-XC-012` — no password, OTP, session token, credential, secret, `AccountId`, `PersonId` or `StudentRecordId` | 544 |
| The flow | `ATT-FR-010` — 9 ordered steps: authenticated app → student context → scan → validate QR → validate tenant → validate student → consult membership (`E-03`, *"flag, never block"*) → apply rules (`E-04`) → validate state → create or extend `AttendanceDay` | 553 |
| Server-side | `ATT-FR-011` — every validation **MUST** be server-side; a client result **MUST NOT** be trusted | 568 |
| Lifecycle | `ATT-FR-012`…`017`: per-tenant binding · explicit activation · entrance association · replaceable without invalidating history · revocable with immediate effect · audit on each | 575–581 |
| Cross-tenant | `ATT-BR-010` — a QR presented for another tenant **MUST** be rejected and *"**MUST NOT** fall back to the scanning student's tenant"* | 582 |
| Failure | `ATT-FR-018` seven enumerated rejections, each with a specific reason; `ATT-BR-011` — *"A failure **MUST NOT** be silent… 'nothing happened' is not an acceptable result of a scan"* | 586, 592 |
| Duplicate / concurrency | `ATT-FR-019` idempotency; `ATT-FR-020` concurrent scans → exactly one transition | 597, 599 |
| Dynamic QR | Rotation `ATT-CFG-005` **30 s / 15–120 s**; validity `ATT-CFG-006` **60 s / 30–300 s**; single-use per student-day `ATT-CFG-007` **Enabled**; replay prevention `ATT-FR-094`; cryptography **not specified** — `ATT-GAP-006` | 1159–1161 |

**Nothing in the request touches this, and nothing in this analysis proposes touching it.** Recorded explicitly
because §1 of the request required it: **QR is not deleted, not weakened, not converted, and not made optional by
anything in this report.**

---

## 3. Existing GPS behavior

**Located at §11, lines 717–759. Mode name `ATTENDANCE_MODE_FIXED_QR_GPS` (mode 4 of six).**

| Aspect | The rule | Line |
|---|---|---|
| What location *is* | `ATT-BR-018` — *"Location verification is an **environment verification** mechanism. It is **not** identity."* | 723 |
| What it is not | `ATT-XC-016` — *"GPS **MUST NOT** be described, recorded or used as identity or authentication."* | 725 |
| The flow | `ATT-FR-040` — *"authenticated Student App → Fixed QR scan → location verification → attendance validation → `AttendanceDay`"* | 730 |
| Coordinates | `ATT-FR-041` per-tenant (`ATT-CFG-010`, default **Unset**) | 736 |
| Radius | `ATT-FR-042` per-tenant (`ATT-CFG-011`) **with a default and a bounded allowed range** — now **50 m / 20–200 m** | 737, 1165 |
| Accuracy floor | `ATT-CFG-012` **30 m / 5–100 m**; `ATT-FR-045` distinguishable *"location inaccurate"* | 1166, 740 |
| Failures | `ATT-FR-043` *"location unavailable"* · `ATT-FR-044` *"permission denied"*, and **MUST NOT** be reported as a system error · `ATT-FR-046` *"outside library area"* | 738–741 |
| No downgrade | `ATT-FR-047` — a GPS failure **MUST NOT** create a record and **MUST NOT** silently downgrade to mode 1 | 742 |
| Evidence, audit, tenancy | `ATT-FR-048` evidence · `ATT-FR-049` audit on coordinate/radius change · `ATT-BR-019` tenant-scoped | 743–745 |
| Coordinate ownership | **`ATT-GAP-008`** — whether the attendance radius centre is the same value as Library PRD `LIB-6.5` Map Location is **open**, owned by the **Library PRD owner**; *"this document does not merge them and does not duplicate ownership"* | 747–750 |
| Mock location | `ATT-XC-017` — *"**MUST NOT** specify mock-location detection… **`ATT-GAP-008a`**"*; `ATT-FR-050` — the mode **MUST NOT** be presented as location-spoofing-resistant | 754, 757 |
| Optionality | The mode is a **separate, independently switchable mode** (`ATT-CFG-004`, default **Disabled**), not a modifier on other modes — `ATT-BR-007` | 1158, 518 |

**One line matters directly for the request's §7.** `ATT-FR-044` (line 739) is the **only** occurrence of the word
*"permission"* in an OS sense anywhere in the 2400-line document. There is no Android permission model here to
extend; there is one requirement that a denied location permission must fail distinguishably.

---

## 4. Existing attendance modes

**§7.1, lines 479–493. This is the single most consequential section for the request.**

> `ATT-FR-007` — *"V1 **MUST** support **exactly these six** attendance modes, **and no others**."* — line 481

| # | Enum | Line |
|---|---|---|
| 1 | `ATTENDANCE_MODE_FIXED_QR` | 485 |
| 2 | `ATTENDANCE_MODE_DYNAMIC_QR` | 486 |
| 3 | `ATTENDANCE_MODE_FIXED_QR_WIFI` | 487 |
| 4 | `ATTENDANCE_MODE_FIXED_QR_GPS` | 488 |
| 5 | `ATTENDANCE_MODE_FACE` | 489 |
| 6 | `ATTENDANCE_MODE_MANUAL` | 490 |

> `ATT-XC-010` — *"V1 **MUST NOT** define a seventh mode. RFID, NFC and BLE are Future/V3 (§12, §33) and **MUST
> NOT** appear as a V1 mode, requirement, configurable, event or acceptance criterion."*

**Mode independence — §7.2, lines 495–523.**

| Rule | Text | Line |
|---|---|---|
| `ATT-BR-004` / `ATT-BR-005` | Modes are independent; each is sufficient alone | 497–499 |
| `ATT-XC-011` | *"**MUST NOT** implement a generic verification-layer architecture, a verification pipeline, a verification chain, or any construct in which one attendance requires a sequence of methods"* | 500 |
| `ATT-BR-006` | Enabling one mode does not enable or alter another | ~512 |
| **`ATT-BR-007`** | *"A Wi-Fi condition **MUST** apply **only** to `ATTENDANCE_MODE_FIXED_QR_WIFI`. A GPS condition **MUST** apply **only** to `ATTENDANCE_MODE_FIXED_QR_GPS`. Neither **SHALL** be applied to Fixed QR, Dynamic QR, Face or Manual."* | **518** |
| `ATT-FR-009` / `ATT-BR-008` | A student **MUST NOT** be required to have a smartphone in order to attend | 527–529 |
| `ATT-INV-007` | *"Every punch **MUST** record **exactly one** `AttendanceMethod` from the six V1 modes"* | ~452 |
| `ATT-FR-099` | The Owner **MUST** be able to independently enable/disable **each of the six** V1 modes (`ATT-CFG-001`…`004`, `016`, `017`) | 1128 |
| `ATT-FR-106` | This document **MUST NOT** enforce an "at least one mode enabled" rule — **`ATT-GAP-018`** open | 1290 |
| §33.1 | Class table: modes 1, 3, 4, 6 **V1**; mode 2 V1 but build-blocked by `ATT-GAP-006`; **mode 5 Face = V3** by decision `D-3a` | 2354–2366 |

The mode set is closed **three times over**: by a positive MUST (`ATT-FR-007`), by an exclusion (`ATT-XC-010`), and
by an invariant on every punch (`ATT-INV-007`). It is also closed **mechanically** — 213 acceptance criteria and the
Stage 5/6 gate scripts are counted against these registers, and `ATT-AC-*` is registered at exactly **213** in the
Rank 4 `TRACEABILITY_MATRIX.md` §2F.

---

## 5. Proposed new capability

Restated from the request without adding to it or softening it, so the conflict test in §6 is fair.

| # | Requested behavior | Request § |
|---|---|---|
| P-1 | Owner **and Manager** designate one or more **AUTHORIZED Wi-Fi networks**, with labels, enable/disable, multiple per tenant, tenant-isolated, audited | §3, §10, §11, §16 |
| P-2 | Connection to an authorized network **establishes an active library-presence session** | §2, §6 |
| P-3 | Attendance is **automatically created** *"according to the newly approved Wi-Fi attendance mode"* — i.e. a new mode | §2, §6 |
| P-4 | **Study Hours** begin at valid presence-session start and stop at end; duration = validated presence-session duration; **not** app-open time and **not** last-attendance-to-now | §2, §8 |
| P-5 | Disconnect **ends** the session, stops Study Hours, records the end; must not count indefinitely after disconnect | §2 |
| P-6 | Attendance, Presence and Study Hours are **three distinct concepts** preserved in the data model **and** the event model | §9 |
| P-7 | Location remains **optional**, tenant-configurable as *Wi-Fi only* or *Wi-Fi + Location*, **reusing existing approved GPS configuration** | §5 |
| P-8 | Student experience is **automatic**; the app need not be kept open; Android background/permission model designed separately | §6, §7 |
| P-9 | **Minimum** Android permissions, with a 6-column matrix (Permission · Purpose · Required/Optional · When requested · Why required · If denied) | §7 |
| P-10 | Handoff between authorized APs: no duplicate attendance, no overlapping sessions, presence continuous within one authorized presence domain | §10 |
| P-11 | 18 enumerated failure cases behave defined-ly | §12 |
| P-12 | No polling; event/state-based; duration from authoritative timestamps; idempotency; documented load assumptions | §13 |
| P-13 | **Owner dashboard**: students currently present, active sessions, current + today's Study Hours, configured networks, Wi-Fi-mode attendance | §14 |
| P-14 | **Student dashboard**: presence status, today's/total Study Hours, Wi-Fi-mode attendance, session history, verification method; UI states Present / Not Present / Session Active / Session Ended | §15 |
| P-15 | Audit of 10 administrative actions | §16 |
| P-16 | No claim that cheating is impossible; explicit recognition of SSID copying, hotspot spoofing, device/network manipulation, location spoofing | §17 |

**P-16 is already satisfied by the existing document** and requires nothing new — see §7.2.

---

## 6. Exact conflicts with current PRD

Thirteen conflicts. Each names the exact rule, its exact wording, its line, and the exact requested item it
collides with. **Three are structurally decisive**, meaning they cannot be resolved by amending PRD-006 alone.

### 🔴 CONFLICT 1 — DECISIVE — a new Wi-Fi attendance mode is a seventh mode

| | |
|---|---|
| **Rules** | `ATT-FR-007` (L481) *"exactly these six attendance modes, **and no others**"* · `ATT-XC-010` (L481, register L1770) *"**MUST NOT** define a seventh mode… **MUST NOT** appear as a V1 mode, requirement, configurable, event or acceptance criterion"* · `ATT-INV-007` *"exactly one `AttendanceMethod` from the six V1 modes"* |
| **Collides with** | **P-3** — *"attendance may be automatically created according to the **newly approved Wi-Fi attendance mode**"* |
| **Why renaming does not avoid it** | The requested behavior differs from mode 3 in kind, not in label: no QR scan, no single punch-time evaluation, a session rather than an event, automatic rather than student-initiated. It cannot be folded into `ATTENDANCE_MODE_FIXED_QR_WIFI` without violating `ATT-FR-031` (*"Fixed QR scan → Wi-Fi verification"*, both parts required) and `ATT-BR-007`. Presented as anything else, it is still a seventh member of a closed set |
| **Decisive because** | `ATT-XC-010` is an **exclusion**, and §29 states of the exclusion register: *"Each exclusion states what is **impossible**, not merely discouraged."* An exclusion is not satisfied by careful drafting |

### 🔴 CONFLICT 2 — DECISIVE — no second presence system of record

| | |
|---|---|
| **Rule** | **`ATT-BR-033`** (§14.7, **L1066**) — *"This module **MUST NOT** create a second presence, occupancy or \"currently inside\" system of record beyond the `AttendanceDay` aggregate. Live seat occupancy is `BC-04`'s (§23)."* |
| **Reinforced by** | `ATT-FR-140` (L1530) — *"**MUST NOT** own, compute or publish live occupancy, occupancy counts, or \"currently inside\" as an authoritative seating fact"* · `ATT-BR-045` (L1564) — *"Neither module **SHALL** hold a shadow copy of the other's system of record"* · BC Map `E-08` (L305) — ***"Seating is the occupancy owner**, Attendance is the trigger"* |
| **Collides with** | **P-2**, **P-6**, **P-13**, **P-14** — a `PresenceSession` aggregate with start/end/status, queried for *"students currently present"* and *"active presence sessions"*, **is** a second presence and "currently inside" system of record |
| **Decisive because** | The prohibition names the exact artifact the request needs. It is also cross-module: `PRD-007` is **FROZEN v1.0** (`ADR-0020`, `BASELINE-2026-08-04-E`), and §23 of PRD-006 is written to be compatible with it. Relaxing `ATT-BR-033` reopens a frozen boundary |

### 🔴 CONFLICT 3 — DECISIVE — Study Hours is already owned by `BC-26`, in a Rank 3 document

| | |
|---|---|
| **Rule** | `docs/30-product/student-identity/Student_Identity_PRD_v1.md` **L474** — `\| Study Analytics \| study hours · streak · reading statistics · productivity \| `**`BC-26`**` \|` · **L592** — *"daily / weekly / monthly **study hours** · study streak · reading statistics"* · **L470** assigns `BC-03` only *"Attendance \| percentage · present days · summary"* |
| **Authority** | `DOCUMENTATION_BASELINE.md` **L155** — that file is **v1.0**, *"**Authoritative** — the Student Identity baseline"* → **Rank 3**. BC Map **L135** — `BC-26` Analytics Read Model *"Owns the metric/semantic layer, read-model store, projections, reports, exports."* `PRD_REGISTRY.md` L239 — `BC-26` is **`PRD-009` Analytics & Reports**, status `PLANNED`, **unwritten** |
| **Collides with** | **P-4**, **P-13**, **P-14** — PRD-006 defining, storing and reporting Study Hours |
| **Decisive because** | `DOCUMENTATION_BASELINE.md` **L286**: *"A change to any Rank 1–5 document requires an ADR **before** the change."* Assigning Study Hours to `BC-03` contradicts a **Rank 3** assignment. Worse: the correct owner's PRD (`PRD-009`) **does not exist yet**, so there is no document in which to place the capability properly |
| **Aggravating** | `SID-2.38` (L477) — *"Aggregation **SHALL** be read-only composition. This module **SHALL NOT** store, cache beyond a display request, or become the authority for any contributed value."* The composition pattern assumes each value has exactly one owning module |

### 🟠 CONFLICT 4 — Wi-Fi may not be presence proof, and the request's core premise is that it is

| | |
|---|---|
| **Rule** | `ATT-XC-014` (**L679**) — *"Wi-Fi **MUST NOT** be described, recorded or used as identity, authentication, or **proof that a specific person was present**."* |
| **Collides with** | **P-2**, **P-3**, **P-4** — using the connection as the sole basis for establishing presence and accruing time |
| **Note** | The request's own §4 and §17 agree with the *spirit* of `ATT-XC-014`. The collision is narrower and sharper than a philosophical one: an automatically-created attendance record whose only evidence is a network association **is** a record asserting that a specific person was present, on Wi-Fi alone |

### 🟠 CONFLICT 5 — network identity cannot be specified in this document

| | |
|---|---|
| **Rule** | `ATT-XC-015` (**L708**) — *"This document **MUST NOT** specify how a network is technically identified or how a spoofed network would be detected. No Rank 1–5 document defines a network-verification mechanism… **`ATT-GAP-007`**"* · `ATT-FR-039` (L712) — until answered, the mode **MUST NOT** be presented as spoofing-resistant |
| **Owner** | `ATT-GAP-007` = **Architecture owner**, 🔴 **OPEN** (§32.1) |
| **Collides with** | **P-1** (duplicate-network prevention needs a network identity), **P-10** (*"the same authorized **presence domain**"*), **P-16** |
| **Consequence** | The request itself forbids inventing this (*"DO NOT invent a BSSID/network fingerprint/security mechanism"*). Both instructions agree; the effect is that **P-1's uniqueness rule and P-10's handoff rule cannot be written at all** until `ATT-GAP-007` is answered. Measured: `grep -ci bssid` = **0**, `grep -ci ssid` = **0** |

### 🟠 CONFLICT 6 — Wi-Fi is bound to mode 3 only, and composition is forbidden

| | |
|---|---|
| **Rule** | `ATT-BR-007` (**L518**) — *"A Wi-Fi condition **MUST** apply **only** to `ATTENDANCE_MODE_FIXED_QR_WIFI`… Neither **SHALL** be applied to Fixed QR, Dynamic QR, Face or Manual."* Verified by `ATT-AC-032` (L1849) |
| **Collides with** | **P-3**, **P-7** — a Wi-Fi condition driving a different mode, and a Wi-Fi mode optionally carrying a GPS condition |
| **P-7 collides twice** | *Wi-Fi + Location* on one mode is precisely the *"sequence of methods"* construct that `ATT-XC-011` (L500) forbids: *"**MUST NOT** implement a generic verification-layer architecture, a verification pipeline, a verification chain, or any construct in which one attendance requires a sequence of methods."* Modes 3 and 4 are two conditions on two **separate** modes, never composed |

### 🟠 CONFLICT 7 — the event set is closed at four

| | |
|---|---|
| **Rule** | `ATT-FR-134` (**L1480**) — *"This module **MUST** publish **only** the events below. It **MUST NOT** invent an event name, a producer or a consumer."* The four: `attendance.StudentCheckedIn` · `attendance.StudentCheckedOut` · `attendance.AttendanceCorrected` · `attendance.FraudSignalDetected` |
| **Cross-authority** | The same four, with the same consumers, are in **BC Map §9** (L414–417, Rank 4 `e527df027664680e`) |
| **Collides with** | **P-6**, **P-12** — presence-started / presence-ended / study-session events, and any realtime event feeding a dashboard |
| **Why amending PRD-006 is insufficient** | `ATT-FR-135` binds the naming convention to BC Map §9, and BC Map §7's own rule (L292) is *"If an edge is not in this table, it **does not exist** and adding it requires an ADR."* New events with new consumers need the **BC Map**, a Rank 4 protected document |

### 🟠 CONFLICT 8 — analytics, metrics and dashboards are excluded

| | |
|---|---|
| **Rules** | §2.2 **NG-6** — *"Attendance reports, percentages, streaks, dashboards → `BC-26` Analytics Read Model"* · `ATT-FR-146` (**L1578**) — *"This module **MUST NOT** own analytics. It **MUST NOT** define a metric, compute a certified figure, build a read model, produce a report, or become the source for any attendance percentage, streak or dashboard."* |
| **Collides with** | **P-13**, **P-14** — both dashboards; and *"today's Study Hours"* / *"total Study Hours"* are metrics by definition |
| **Partial relief exists** | `ATT-FR-145` (L1576) **MAY** expose operational facts — *"students currently inside · check-ins today · check-outs today · attendance by mode · failed attempts"* — provided `ATT-FR-147` labels them **operational reads, not certified metrics**. This covers *some* of P-13 (configured networks, Wi-Fi-mode attendance) but **not** Study Hours totals, which are aggregations |

### 🟠 CONFLICT 9 — one open session per student

| | |
|---|---|
| **Rule** | `ATT-INV-004` (§6.2) — *"There **MUST** be **no more than one open session per student** at any moment"*, quoted from **BC Map §8** (L372) and therefore **Rank 4 in origin** |
| **Collides with** | **P-2**, **P-10** — a presence session concurrent with an existing open attendance presence, and AP-handoff continuity |
| **Note** | Line 1013 records that a student **may** legitimately have open days at *"different libraries at the same time, and that is not a violation"* — so the invariant is per (student, tenant). This narrows the conflict but does not remove it: within one tenant, an auto-created Wi-Fi presence and a QR check-in are two open sessions |

### 🟡 CONFLICT 10 — automatic creation vs. no fabricated timestamps

| | |
|---|---|
| **Rules** | `ATT-BR-030` (L1025) — *"A missed check-out **MUST NOT** be auto-completed with an invented timestamp"* · `ATT-FR-083` (L1030) — *"**MUST** publish `StudentCheckedOut` only for an **actual** check-out. A missed check-out **MUST NOT** emit a fabricated check-out event"* · `ATT-FR-088` (L1055) — every timestamp from the platform time port, *"never from the client"* |
| **Collides with** | **P-5** — deriving a session end from a **disconnect**, which is a client-side network event with no server-observed timestamp, and which may itself be unobservable (phone off, app killed) |
| **Sharpened by the blockquote at L1033** | *"A fabricated check-out would silently free a seat that is still occupied… Fabricating one is worse than missing one."* A disconnect-derived end time is exactly the class of value this rule refuses |

### 🟡 CONFLICT 11 — the module must not own configuration storage, and the register is Owner-only

| | |
|---|---|
| **Rules** | `ATT-FR-002` (L216) — **MUST NOT** own *"configuration storage, the audit store, notification delivery, analytics metrics, or generic device lifecycle"* · `ATT-FR-097`/`098` (L1121–1122) — all configuration through **`BC-25`** (`E-19`); *"**MUST NOT** implement a configuration store, a settings hierarchy or a feature-flag system"* |
| **Collides with** | **P-1** — a Wi-Fi *management interface* with labels, enable/disable and history. The **behavior** may be owned here (`ATT-BR-037`); the **setting records** may not |
| **Measured** | All **24** rows of the §16.3 register have Owner = **Owner**. `ATT-FR-033` (L696) names the **Owner** role for Wi-Fi configuration specifically. **The Manager role exists** (`ATT-FR-003`, L263, enum `manager`) and holds attendance duties at L1383–1386 — *operational actions, manual entry, OCR verification, corrections* — but holds **no configuration authority anywhere in the document.** Granting Manager configuration rights is a **permission change**, not a UI addition |

### 🟡 CONFLICT 12 — a smartphone must not be required

| | |
|---|---|
| **Rule** | `ATT-BR-008` (**L529**) — *"A student **MUST NOT** be required to have a smartphone in order to attend."* Reinforced by `ATT-NFR-014` (L1673) — accessibility of Manual **MUST NOT** be worse than the app modes, *"because the students served by Manual are those least served by devices"* |
| **Collides with** | **P-4**, **P-8** — Study Hours accrual is only possible for students carrying a connected device |
| **Nature of the conflict** | Not a blocker for an **optional mode**. It **is** a blocker for Study Hours as a **universal student metric**: a device-only metric silently excludes exactly the cohort `ATT-BR-008` and `ATT-NFR-014` protect. That is a product decision, not a drafting one |

### 🟡 CONFLICT 13 — no Android or background-execution vocabulary exists to extend

| | |
|---|---|
| **Measured** | `grep -in "android"` → **0 hits**. `grep -in "background\|foreground service"` → **0 hits**. The only OS-permission requirement in 2400 lines is `ATT-FR-044` (L739), for denied location permission |
| **Rules that fence the gap** | `ATT-NFR-003` (L1652) — *"**MUST NOT** state a latency figure, throughput number or percentile target… an invented number becomes a false acceptance criterion — **`ATT-GAP-017a`**"* · `ATT-NFR-012` — offline behaviour **MUST NOT** be promised beyond what `E-24` authorises · `ATT-PO-011` (L1697) — this module defines the conflict-resolution policy and **MUST NOT** implement the queue, the replay or the detection · `ATT-XC-021` — **MUST NOT** own device lifecycle |
| **Collides with** | **P-8**, **P-9**, **P-12** — background execution, a permission matrix, persistence frequency, reconnect behavior, and any documented load assumption |
| **Consequence** | This is not a contradiction but a **void with a fence around it**. Filling it here would breach `ATT-NFR-003` and `ATT-XC-021` |

### 6.1 Conflict summary

| # | Rule | Severity | Resolvable by amending PRD-006 alone? |
|---|---|---|---|
| 1 | `ATT-FR-007`, `ATT-XC-010`, `ATT-INV-007` | 🔴 Decisive | **No** — exclusion + 213 AC + Rank 4 matrix count |
| 2 | `ATT-BR-033`, `ATT-FR-140`, `ATT-BR-045` | 🔴 Decisive | **No** — crosses into **frozen** `PRD-007` / BC Map `E-08` |
| 3 | `Student_Identity_PRD_v1.md` L474 (`BC-26`) | 🔴 Decisive | **No** — **Rank 3** ownership; receiving PRD unwritten |
| 4 | `ATT-XC-014` | 🟠 Major | No — exclusion |
| 5 | `ATT-XC-015` / `ATT-GAP-007` | 🟠 Major | No — Architecture owner must answer first |
| 6 | `ATT-BR-007`, `ATT-XC-011` | 🟠 Major | Only with an explicit rule change |
| 7 | `ATT-FR-134`, `ATT-FR-135` | 🟠 Major | **No** — BC Map §9 is Rank 4 |
| 8 | NG-6, `ATT-FR-146` | 🟠 Major | Partly — `ATT-FR-145` relieves some of it |
| 9 | `ATT-INV-004` | 🟠 Major | **No** — BC Map §8 is Rank 4 |
| 10 | `ATT-BR-030`, `ATT-FR-083`, `ATT-FR-088` | 🟡 Material | Needs a product decision on disconnect semantics |
| 11 | `ATT-FR-002`, `ATT-FR-097`/`098`, `ATT-FR-033` | 🟡 Material | Partly — role grant is a permission decision |
| 12 | `ATT-BR-008`, `ATT-NFR-014` | 🟡 Material | Needs a product decision on metric universality |
| 13 | Void, fenced by `ATT-NFR-003`, `ATT-XC-021` | 🟡 Material | Needs platform/architecture input |

**Conflicts requiring a document outside PRD-006: 6 of 13** — 1, 2, 3, 7, 9, and 5's precondition.

---

## 7. Rules that can remain unchanged

Recorded because the request's §1 required proof that nothing existing is disturbed. Every rule below is
**compatible with the requested capability as-is** and needs no amendment.

### 7.1 Directly reusable — the request needs these and they already exist

| Rule | Text | Serves |
|---|---|---|
| `ATT-CFG-008` (L1162) | *"Approved Wi-Fi network(s) \| Owner \| **Empty** \| Tenant-scoped **list**"*, non-empty when the mode is enabled | **P-1** — a *list* already, so "multiple networks" needs no new configurable |
| `ATT-FR-032` (L695) | Approved network(s) configurable **per tenant** | P-1 |
| `ATT-FR-033` (L696) | Configuration stored through **`BC-25`** (`E-19`) | P-1 — the storage mechanism is settled |
| `ATT-FR-038` (L701) | *"Wi-Fi configuration changes **MUST** emit an audit fact (`E-20`)"* | **P-15** — 4 of the 10 audited actions |
| `ATT-BR-017` (L702) | *"one tenant's approved network **MUST NOT** validate another tenant's attendance"* | **P-1, and the whole of request §11** — multi-tenant isolation is **fully satisfied** |
| `ATT-FR-034`/`035`/`036` (L697–699) | Distinguishable *"network unavailable"* / *"network not approved"*; **no silent downgrade** | **P-11** cases 1, 12, 17, 18 |
| `ATT-CFG-010`, `011`, `012` (L1164–1166) | Coordinates **Unset** · radius **50 m / 20–200 m** · accuracy **30 m / 5–100 m** | **P-7 — fully satisfiable. No new GPS radius is needed or proposed** |
| `ATT-FR-043`…`047` (L738–742) | location unavailable · permission denied · inaccurate · outside area · no downgrade | **P-11** cases 14, 15 |
| `ATT-FR-090`…`095`, `ATT-INV-003`, `ATT-BR-034` | Idempotency by `(studentRecordId, date, idempotencyKey)`, enforced **inside** the aggregate; replay absorbed | **P-12**, and **P-11** cases 8, 9 |
| `ATT-FR-084`…`086` (L1040–1046) | Concurrent check-in / check-out determinism | P-11, P-12 |
| `ATT-NFR-001`/`002` (L1110, 1647) | Contention confined to one student-day; correct under 50+ burst arrival | **P-12** |
| `ATT-FR-088`/`089`, `ATT-BR-032` (L1055–1061) | Platform time port only; rules-in-force-at-record-time; explicit tenant time zone | **P-12** — *"duration from authoritative timestamps"* is already the rule |
| `ATT-NFR-007` (L1665) | No attendance operation depends on a **synchronous** call to `BC-22`, `BC-24` or `BC-26` | **P-12** — the no-polling posture is already architectural |
| `ATT-NFR-009` (L1670) | Where membership validity is stale/unavailable, attendance **MUST** still be recordable and **flagged rather than blocked** — BC Map `E-03` | **P-11** cases 6, 7 — *"membership expires mid-session"* already has a governing rule: **flag, never block** |
| `ATT-NFR-005` (L1660) | *"Every rejection **MUST** carry a specific, distinguishable reason. A generic failure is a defect"* | **P-11**, all 18 cases |
| `ATT-FR-129`…`133` (§21, L1455–1470) | Audit to `BC-24` via `E-20`, fire-and-forget, outbox-backed; actor + tenant on every fact; no secrets | **P-15** — the audit mechanism needs no change |
| `ATT-CFG-021` + `ATT-BR-029` (L1015) | A tenant **MAY** operate without check-out; a day with only a check-in is *"a complete, valid record — not an error state"* | Relevant to **P-5**: the document already tolerates an unclosed presence without fabricating an end |

### 7.2 The anti-cheating position is already exactly what the request asks for

Request §17 demanded that the feature **not** claim cheating is impossible. **PRD-006 already forbids the claim, in
five places, and needs no amendment whatsoever:**

| Rule | The prohibition |
|---|---|
| `ATT-XC-014` (L679) | **MUST NOT** claim Wi-Fi *"prevents attendance sharing"* |
| `ATT-FR-039` (L712) | Mode 3 **MUST NOT** be presented as **spoofing-resistant** while `ATT-GAP-007` is open |
| `ATT-FR-050` (L757) | Mode 4 **MUST NOT** be presented as **location-spoofing-resistant** while `ATT-GAP-008a` is open |
| `ATT-BR-042` (L1750) | *"Never overstate a control; state its bound where offered"* |
| `ATT-AC-033` (L1852) | *"No product surface or document describes Wi-Fi as identity or as preventing sharing"* — a **testable** criterion |

**P-16 requires zero change.** The existing rules are stricter than the request asks for. The blockquote at L682
already names the specific weakness the request wanted acknowledged: *"Two students on the same network are
indistinguishable to a network check."*

### 7.3 Explicitly untouched by anything in this report

Fixed QR §8 in full · Dynamic QR §9 in full · GPS §11 in full · Face §12 · Manual §13A–13E · entry/exit determinism
§14.1–14.6 · corrections §18 · authorization §19 · tenancy §20 · audit §21 · seat integration §23 · offline §27.1 ·
all 21 `ATT-XC` exclusions · all 24 `ATT-CFG` values and ranges · all 213 `ATT-AC` criteria.

> **On the request's "already-approved configurable values."** The six values closed by `ATT-GAP-017` —
> `ATT-CFG-005` 30 s / 15–120 s, `ATT-CFG-006` 60 s / 30–300 s, `ATT-CFG-011` 50 m / 20–200 m, `ATT-CFG-012`
> 30 m / 5–100 m, `ATT-CFG-019` 0.90 / 0.80–1.00, `ATT-CFG-023` 15 min / 0–60 min — are **not** proposed for change
> by anything in this report. **No new numeric threshold is invented anywhere in this document.**

---

## 8. Rules that require amendment

**Nothing below is amended by this document.** This is an inventory of what *would* have to change, with the
authority required for each, so the cost is visible before it is authorised.

### 8.1 In PRD-006 (v1.4 `DRAFT`, unranked — see §22.4 on what that permits)

| Rule | Line | Amendment that would be required | Authority |
|---|---|---|---|
| `ATT-FR-007` | 481 | Six → seven modes; register table extended | Product Owner **+** ARB |
| `ATT-XC-010` | 481 / 1770 | Exclusion narrowed — currently absolute | **ARB** (it is an exclusion) |
| `ATT-INV-007` | ~452 | Method set extended | ARB |
| `ATT-BR-007` | 518 | Wi-Fi condition unbound from mode 3 only | ARB |
| `ATT-XC-011` | 500 | Explicit carve-out for Wi-Fi + optional Location, **or** the composition dropped | ARB |
| `ATT-XC-014` | 679 | A narrowing that keeps the anti-identity rule while permitting presence inference | **ARB + Security** |
| `ATT-XC-015` | 708 | Cannot be amended until `ATT-GAP-007` is answered | Architecture owner |
| `ATT-BR-033` | 1066 | Permit a presence record — **crosses into frozen `PRD-007`** | ARB |
| `ATT-FR-134` | 1480 | Event set 4 → more; but see §8.3 | ARB |
| `ATT-FR-146` + NG-6 | 1578, 172 | Study Hours excluded from "analytics", or scoped as an `ATT-FR-145` operational read | Product Owner + ARB |
| `ATT-FR-033` | 696 | Owner → Owner **and** Manager for Wi-Fi configuration | Product Owner |
| §16.3 register | 1148–1273 | New rows (labels, per-network enable, Wi-Fi-only vs Wi-Fi+Location, grace policy) — **each needing a default *and* an allowed domain** per `LIB-16.2`/`LIB-16.3` | Product Owner |
| §19.3 table | 1400–1414 | New rows for the new mode's controls, each with its bound stated (`ATT-BR-042`) | Product Owner |
| §26 data ownership | 1617 | New rows for presence/session data — **only after §8.2 row 2 is settled** | ARB |
| §30 acceptance criteria | 1794 | New `ATT-AC-*` — see §8.3 | Requirements reviewer |
| §32 gap register | 2200 | New gap rows for everything not decidable here | — |
| §33.1 class table | 2354 | New capability row with its V-class | Product Owner |

### 8.2 Outside PRD-006 — where the decisive conflicts live

| Document | Rank / state | What would have to change | Authority |
|---|---|---|---|
| `LIBOORA_BOUNDED_CONTEXT_MAP.md` | **Rank 4**, `e527df027664680e` | §8 `BC-03` aggregate row (a second aggregate, or an extended `AttendanceDay`); §8 invariant *"no more than one open session per student"*; §9 event table; possibly §7 a new edge | **ARB, via ADR, before the change** |
| `Student_Identity_PRD_v1.md` | **Rank 3**, `b476f94e799a3cc3` | **L474** — reassign *"study hours"* away from `BC-26`, **or** confirm `BC-26` keeps it and `BC-03` merely emits raw session facts | **ARB, via ADR** |
| `PRD-007` Seat Management | **FROZEN v1.0**, `ADR-0020` | Nothing, *if* `ATT-BR-033` holds. If a presence record is permitted, the `E-08` occupancy boundary must be re-examined against a frozen document | **ARB.** *"A frozen PRD is never silently modified"* |
| `PRD-009` Analytics & Reports | **`PLANNED` — does not exist** | This is where Study Hours *as a metric* belongs. There is no document to amend | Product Owner to commission |
| `TRACEABILITY_MATRIX.md` §2F | **Rank 4**, `51ba0d739a4c0bea` | L425 `ATT-AC-*` count **213** and L428 totals **516 / 285** would move | Traceability owner (Stage 5) |
| `PRD_REGISTRY.md` | `f8e71ce876c2b53b` | Only if scope or status changes | Governance owner |
| `docs/00-governance/adr/` | — | New ADR(s) — see §11 | **ARB** |

### 8.3 Two mechanical constraints that make "just add requirements" harder than it looks

**1. The AC count is cross-checked by a gate.** `tool/docs_check/prd006_traceability.py` L380–402 compares the
PRD's `ATT-AC-*` count against `TRACEABILITY_MATRIX.md` §2F. §2F is a **Rank 4 protected document** at
`51ba0d739a4c0bea` and registers the count as **213**. Adding acceptance criteria therefore requires touching a
Rank 4 file, which requires an ADR first (`DOCUMENTATION_BASELINE.md` L286). The AC row parser at L298 matches only
``^\|\s*`(ATT-AC-\d{3})`\s*\|``, so a suffixed identifier such as `ATT-AC-199a` is **not** a way around this. The
precedent recorded at §2F L446 is that a gap was *"closed during Stage 4 reconciliation by **extending
`ATT-AC-152`, not by inventing a criterion**."*

**2. Every obligation must be covered, and coverage is measured.** `ATT-NFR-010` (L1668): *"A rule that cannot be
checked **MUST** be treated as unmet. A requirement in this document with no acceptance criterion is not satisfied
by assertion."* The Stage 5 gate currently measures **285/285 = 100.0%**. Every new `ATT-FR`/`ATT-BR`/`ATT-CFG`
added for this capability lands in that denominator and needs a criterion — which needs §2F changed. The two
constraints are circular by design, and the loop is only opened by an ADR.

---

## 9. New requirements required

Scope only. **No requirement is drafted, numbered or worded here**, because drafting them would presuppose the
conflicts in §6 were resolved, and several cannot be worded at all until `ATT-GAP-007` is answered.

| Group | Requirements needed | Blocked by |
|---|---|---|
| **A — Network authorization management** | Add / remove / enable / disable / label / list; duplicate prevention; per-tenant scoping; audit on each | **Duplicate prevention is unwriteable** — needs `ATT-GAP-007` (Conflict 5). Manager access needs a role decision (Conflict 11) |
| **B — Presence session lifecycle** | Start conditions; end conditions; status enum; one-active-per-student-per-tenant; grace/reconnection policy; AP handoff | **Blocked by `ATT-BR-033`** (Conflict 2). Grace window is a **numeric threshold** — the request forbids inventing it, and so does `ATT-NFR-003` |
| **C — Automatic attendance creation** | Trigger; the mode enum; evidence recorded; idempotency; interaction with existing modes | **Blocked by `ATT-FR-007`/`ATT-XC-010`** (Conflict 1) |
| **D — Study Hours** | Definition as validated session duration; accrual; stop; overlap prohibition; correction path | **Blocked by `BC-26` ownership** (Conflict 3) |
| **E — Optional location on the new mode** | Tenant switch *Wi-Fi only* / *Wi-Fi + Location*; reuse of `ATT-CFG-010`/`011`/`012` | The **configuration half is unblocked** (§7.1). The **composition** half hits `ATT-XC-011` (Conflict 6) |
| **F — Failure behavior** | 18 cases, each with a distinguishable reason | `ATT-NFR-005` already mandates the *shape*; ~7 of 18 map onto existing rules (§7.1). The rest need B and C first |
| **G — Client/backend contract** | Client duties; backend duties; persistence frequency; reconnect; load assumptions | **`ATT-NFR-003`** forbids figures here — needs `ATT-GAP-017a` answered |
| **H — Android permissions** | The 6-column matrix in request §7 | No Android vocabulary exists (Conflict 13); `ATT-XC-021` forbids owning device lifecycle |
| **I — Owner reads** | Present students; active sessions; configured networks; Wi-Fi-mode attendance | Partly available under `ATT-FR-145`/`147` as **operational reads**. Study Hours totals are **not** (Conflict 8) |
| **J — Student reads** | Presence status; session history; verification method; Study Hours | Same split; Study Hours blocked (Conflicts 3, 8) |
| **K — Audit** | The 10 actions from request §16 | **Mechanism fully exists** (`E-20`, `ATT-FR-129`…`133`). Only the *list* extends. **Lowest-friction group of all** |

**Unblocked today: group K, and the configuration half of group E. Everything else waits on a decision.**

---

## 10. New gaps / questions

Twelve questions this analysis **cannot** answer and does **not** answer. Each names who must. They are numbered
`Q-W-01`… deliberately — **these are not `ATT-GAP-*` numbers**, because allocating a number in the subject
document's register would be modifying that register.

| # | Question | Who must answer | Blocks |
|---|---|---|---|
| `Q-W-01` | Is Wi-Fi presence a **seventh attendance mode**, a non-mode presence capability, or out of `BC-03` entirely? | **Product Owner + ARB** | Everything. This is the first question |
| `Q-W-02` | May `BC-03` hold a presence-session record at all, given `ATT-BR-033`, `ATT-FR-140`, `ATT-BR-045` and frozen `PRD-007`? | **ARB** | Conflict 2 |
| `Q-W-03` | Who owns **Study Hours** — `BC-26` per `Student_Identity_PRD_v1.md` L474, or `BC-03`? If `BC-26`, what raw fact does `BC-03` emit, and over which edge? | **ARB** (Rank 3 change) | Conflict 3; P-4, P-13, P-14 |
| `Q-W-04` | How is an authorized network **technically identified**, and can a spoofed one be detected? | **Architecture owner** — this is the *existing* `ATT-GAP-007`, not a new question | Conflicts 4, 5; P-1 uniqueness; P-10 handoff |
| `Q-W-05` | What constitutes one **"authorized presence domain"** for AP handoff? | Architecture owner — **depends on `Q-W-04`** | P-10 |
| `Q-W-06` | What is the **grace / reconnection window** on transient disconnect? A number, and a bounded range | **Product Owner** — must not be invented | P-5; P-11 cases 3, 4, 12, 13 |
| `Q-W-07` | May the **Manager** role hold attendance *configuration* authority, when all 24 register rows say Owner? | **Product Owner** | Conflict 11; P-1 |
| `Q-W-08` | May new domain **events** be published, and to which consumers, when BC Map §9 lists four? | **ARB** (Rank 4) | Conflict 7; P-6, P-12 |
| `Q-W-09` | Is *"current Study Hours"* an **operational read** under `ATT-FR-145` or a **certified metric** under `ATT-FR-146`? | Product Owner + ARB | Conflict 8; P-13, P-14 |
| `Q-W-10` | What **Android background-execution and permission model** is available and platform-legal, and who owns it? | Architecture owner + platform owner | Conflict 13; P-8, P-9 |
| `Q-W-11` | Given `ATT-BR-008` (*no smartphone required*), is Study Hours a **universal** student metric or a device-only one — and is that acceptable? | **Product Owner** | Conflict 12 |
| `Q-W-12` | What is the **V-class** of this capability — V1, V2 or V3? | **Product Owner** | §33 placement, and whether any of this is in scope now |

> **`Q-W-12` deserves attention before the rest.** `PRD_LIFECYCLE.md` Stage 1 asks: *"Is it V1/V2/V3, or Future?
> Future ⇒ **stop**."* §33.2 already classes *"Anti-fraud controls (beyond §19.3)"* as **V2** and *"Attendance
> reports"* as **V2**. The requested capability is materially both. If it is V2, the correct answer to this whole
> request is a named V2 entry, not an amendment.

---

## 11. Required ADRs

**No ADR is created by this document.** `ADR-INDEX.md` Process rule 1: *"A decision that changes structure,
ownership, a boundary, or a platform-wide rule requires an ADR **before** implementation."*
`DOCUMENTATION_BASELINE.md` L286: *"A change to any Rank 1–5 document requires an ADR **before** the change."*
`PRD_OWNERSHIP_MODEL.md` §5: *"**Only the Architecture Owner approves.**"*

| # | Subject | Why an ADR and not a PRD edit | Rank 1–5 documents affected |
|---|---|---|---|
| **A-1** | **Presence as a concept in `BC-03`** — may a second presence record exist beside `AttendanceDay`? | Changes an **aggregate boundary and an invariant** | BC Map §8 (Rank 4); frozen `PRD-007` boundary |
| **A-2** | **Study Hours ownership** — `BC-26` or `BC-03`? | Changes **ownership** — the canonical ADR trigger | `Student_Identity_PRD_v1.md` L474 (**Rank 3**); BC Map §3 `BC-26` |
| **A-3** | **A seventh V1 attendance mode** | Narrows an **exclusion** (`ATT-XC-010`) and changes a closed set | PRD-006 §7.1; `TRACEABILITY_MATRIX.md` §2F count (Rank 4) |
| **A-4** | **New `attendance.*` events + consumers** | BC Map §7's own rule: an absent edge *"does not exist and adding it requires an ADR"* | BC Map §9, possibly §7 (Rank 4) |
| **A-5** | **Network identity mechanism** | This is `ATT-GAP-007`, already assigned to the **Architecture owner**; it is a security design | None yet — it creates the missing one |
| **A-6** | *(conditional)* **Manager configuration authority** | If treated as a permission-model change rather than a product setting | PRD-006 §19.2; Master PRD §6 role scope |

**Precedent for the mechanism, from the repository itself.** `ADR-0016` added `BC-10` to `E-22`'s consumer list on
exactly this finding — that a Rank 3 requirement depended on an edge BC Map §7 said did not exist. PRD-006 cites it
at `ATT-GAP-010` as *"the exact precedent… the mechanism to close this is therefore known and proven; only the
decision is missing."* The same is true here.

**Current ADR state, measured.** `ADR-0021`, `ADR-0022`, `ADR-0023` are all **`Proposed`** at line 5 of each file —
*"Under consideration; not binding."* `ADR-INDEX.md` L9 reads *"20 accepted… **0 proposed**"*, which is stale by
three; that staleness is **disclosed here and not corrected**, because `ADR-INDEX.md` is a protected governance
file. **The repository currently carries an ARB backlog of three unapproved ADRs. Six more would make nine.**

---

## 12. Security implications

| # | Implication | Existing rule that governs it | Status |
|---|---|---|---|
| S-1 | **SSID string equality is not proof of presence.** A student can raise a hotspot with the same name | `ATT-XC-014` (L679) already forbids treating Wi-Fi as proof a *specific person* was present; `ATT-FR-039` forbids the spoofing-resistant claim | ✅ **Already correct in PRD-006.** The request's §4 and the document agree |
| S-2 | **No network-identity mechanism exists.** `grep -ci bssid` = 0, `grep -ci ssid` = 0 | `ATT-XC-015` **forbids specifying one here**; `ATT-GAP-007` assigns it to the **Architecture owner** | 🔴 **OPEN.** Blocks S-1's mitigation, P-1's uniqueness rule, P-10's handoff |
| S-3 | **Automatic attendance widens the blast radius of S-1/S-2.** Today a spoof yields at most one punch from a deliberate scan. Automatic creation yields punches *and* accruing time with **no student action at all** | No existing rule contemplates unattended creation. `ATT-CFG-020` is the nearest analogue — *"Unattended creation of high-confidence OCR entries"*, default **Disabled** | 🔴 **New risk.** Note the precedent: the one unattended-creation switch in the document defaults **off** |
| S-4 | **Proxy attendance is unchanged and arguably easier.** A device left in the library accrues Study Hours for an absent student | The L682 blockquote already states network checks cannot distinguish two students | 🟠 Must be stated, not solved |
| S-5 | **Location spoofing** where the optional location leg is enabled | `ATT-XC-017` forbids specifying mock-location detection; `ATT-FR-050` forbids the claim — **`ATT-GAP-008a`**, Architecture owner | 🔴 **OPEN**, pre-existing |
| S-6 | **Evidence must not become identity.** A network identifier tied to a person edges toward identity | `ATT-BR-002` — evidence describes *"what was verified, not who the person is"*; `ATT-XC-008` — no credential, secret, key or biometric in evidence | ✅ Governed; must be respected by any new evidence type |
| S-7 | **Tenant isolation.** `X-13` is *"the highest-severity failure class in the system"*; for attendance, *"a student's presence appearing at a library they never attended"* | `ATT-BR-017`, `ATT-INV-006`, `ATT-FR-092`, `ATT-NFR-006` | ✅ **Fully covered. Request §11 needs nothing new** |
| S-8 | **No claim of impossibility** | `ATT-BR-042`, and `ATT-AC-033` makes it **testable** | ✅ Already stricter than the request asks |

**Position statement, as request §17 requires.** Wi-Fi presence raises the cost of falsifying attendance. It does
**not** make cheating impossible. **SSID copying, hotspot spoofing, device-left-behind proxying, device/network
manipulation and location spoofing all remain feasible.** The strength of any mitigation depends entirely on the
answer to `ATT-GAP-007`, which is **open and not answerable by this analysis**. Nothing in this report asserts a
security guarantee.

---

## 13. Android permission implications

**Measured first:** `grep -in "android"` → **0 hits**. `grep -in "background"` → **0 hits**. The word *"permission"*
appears in an OS sense **once**, at `ATT-FR-044` (L739), for denied location permission on mode 4.

There is therefore **no Android permission model in PRD-006 to extend**. The request's §7 matrix cannot be populated
here without inventing platform facts, which both the request (*"MUST be designed separately… Do not assume
unlimited background execution"*) and the document (`ATT-NFR-003`, `ATT-XC-021`) forbid.

**What can be said without inventing anything:**

| Constraint | Source |
|---|---|
| The matrix must state 6 columns: Permission · Purpose · Required/Optional · When requested · Why required · **What happens if denied** | Request §7 |
| Any *denied* permission must fail with a **distinguishable reason** and **MUST NOT** be reported as a system error | `ATT-FR-044` (L739) — the existing pattern, directly extensible |
| Every rejection must carry a specific reason; *"a generic failure is a defect"* | `ATT-NFR-005` (L1660) |
| **Background location only if genuinely required and platform-permitted** | Request §7 — unresolvable here, because no platform-capability owner is assigned |
| The module **MUST NOT** own generic device lifecycle | `ATT-FR-002` (L216), `ATT-XC-021` |
| A student **MUST NOT** be required to have a smartphone to attend | `ATT-BR-008` (L529) — so the permission model must not become a precondition for attendance |
| No latency/throughput figure may be stated | `ATT-NFR-003` — relevant because background scan intervals **are** figures |

**Conclusion for point 13:** a **fenced void**, recorded as `Q-W-10`, owner **Architecture owner + platform owner**.
It is not a contradiction, and it is not fillable by drafting.

---

## 14. Backend / load implications

Request §13 asks that the design avoid continuous unnecessary requests, avoid an "every few seconds → API request" pattern, prefer event/state-based signalling, and derive duration from authoritative timestamps rather than polling.

### 14.1 Where the request is already aligned with PRD-006

| Request §13 point | Existing rule that already says it | Verdict |
|---|---|---|
| No synchronous chatter to analytics/other contexts | `ATT-NFR-007` (L1666) — attendance **MUST NOT** call `BC-22`, `BC-24` or `BC-26` synchronously in the punch path | ✅ aligned |
| Duration from authoritative timestamps, not polling | `ATT-FR-088` (L1055) — time comes from a **platform time port**, never from the client clock | ✅ aligned, and stricter than asked |
| Idempotency / duplicate-event handling | `ATT-FR-090`…`ATT-FR-095` — idempotency keys, replay tolerance, duplicate suppression | ✅ aligned |
| Contention and burst behaviour | `ATT-NFR-001`, `ATT-NFR-002` — concurrent punch contention and opening-hour burst behaviour are already specified | ✅ aligned |
| Reconnect / offline policy ownership | `ATT-PO-011` (L1697) — this module **defines the policy** and **MUST NOT** implement the queue or the replay machinery | ✅ aligned, with a boundary |
| Distinguishable failure reasons under load | `ATT-NFR-005` (L1660) — *"a generic failure is a defect"* | ✅ aligned |
| Backend enforces, client does not decide | `ATT-BR-017` tenant scoping + `ATT-FR-088` server time | ✅ aligned |

### 14.2 Where the request cannot be answered without a decision

| Request §13 point | Blocker | Owner |
|---|---|---|
| "Define realtime events" | `ATT-FR-134` (L1480) — **only** the four listed events may be published, and the module *"MUST NOT invent an event name, a producer or a consumer"*. Any presence/session event is an invented event. See Conflict 7. | Architecture owner (ADR) |
| "Define persistence frequency" | A frequency is a **numeric threshold**. `ATT-CFG` has no row for it. Request §18 forbids inventing one. | Product Owner via the `ATT-CFG` register |
| "Document performance/load assumptions" | `ATT-NFR-003` (L1652) deliberately states **no** latency or throughput figure; that omission is itself the open gap `ATT-GAP-017a`. A load assumption is a figure. | Architecture owner |
| "Define client vs backend responsibilities" for background presence | The Android/background execution model does not exist in PRD-006 at all (0 hits, §0.3). See point 13. | Architecture owner + platform owner |

**Conclusion for point 14:** the *principles* in request §13 are already PRD-006 policy and need no amendment. The *four concrete artifacts* requested (event set, persistence frequency, load figures, client/backend split) are each blocked by an existing MUST or by an existing deliberate omission. None of them is drafted in this report.

---

## 15. Data model implications

### 15.1 The aggregate as it exists today

Measured from `LIBOORA_BOUNDED_CONTEXT_MAP.md` §8 (L368-390) and PRD-006 §6.1 / §26:

```
BC-03  Attendance
└── AttendanceDay                    ← aggregate root
    │   "aggregate = one student-day, not one punch"
    │   invariant: no more than one OPEN SESSION per student at any moment
    │              (ATT-INV-004; narrowed at L1013 to per (student, tenant))
    ├── Punch                        ← entity, one per check-in / check-out
    ├── VerificationEvidence         ← QR | GPS | WiFi   (evidence, not a session)
    └── CorrectionRecord             ← the correction workflow
```

Three structural findings follow from that shape.

**Finding 15.1-a — `AttendanceDay` is a day, not a session.**
The BC Map states the aggregate boundary explicitly: *"aggregate = one student-day, not one punch."* A presence session with its own start, end, duration, status and lifecycle is a **different aggregate**, not a field on this one. Adding it inside `AttendanceDay` changes the aggregate boundary, which is a Rank 4 BC Map change. Adding it as a sibling aggregate creates the second presence system of record that `ATT-BR-033` (L1066) forbids. Both doors are governed.

**Finding 15.1-b — `VerificationEvidence` is evidence attached to a punch, not a stateful object.**
`VerificationEvidence(GPS/WiFi/QR)` already exists and already carries a Wi-Fi result. But it is created **at the moment of a punch** and is immutable evidence of that punch. It has no start/end, no duration, and no status transitions. It cannot host a session without becoming a different thing.

**Finding 15.1-c — one aggregate, one transaction.**
`ATT-BR-003` requires that a single transaction mutate a single aggregate. A design in which "Wi-Fi connect" simultaneously opens a presence session, creates an attendance punch and starts a Study Hours counter touches up to three aggregates in three contexts. The transactional decomposition is itself an architecture decision.

### 15.2 The eleven requested session fields, mapped

Request §8 enumerates eleven fields for the presence-session record. Each is mapped against what exists.

| # | Requested field | Status against PRD-006 today | Note |
|---|---|---|---|
| 1 | `studentId` | ✅ exists | `AttendanceDay` is keyed by student |
| 2 | tenant / `libraryId` | ✅ exists | `ATT-BR-017` tenant scoping is mandatory already |
| 3 | session **start** timestamp | ⚠️ partially | a check-in `Punch` timestamp exists, but it is a punch, not a session start |
| 4 | session **end** timestamp | ⚠️ partially | a check-out `Punch` exists and is **optional** (`ATT-CFG-021` / `ATT-BR-029`); and `ATT-BR-030` forbids inventing one |
| 5 | **duration** | 🔴 does not exist | nothing in PRD-006 stores or computes a duration; see point 17 |
| 6 | presence **verification method** | ✅ exists in spirit | `AttendanceMethod` exists, but `ATT-INV-007` requires exactly one of the **six** modes — see Conflict 1 |
| 7 | Wi-Fi **authorization reference** | ⚠️ partially | `ATT-CFG-008` holds the approved list, and `VerificationEvidence(WiFi)` records a result; a *reference to which authorization matched* is not specified, and specifying it is fenced by `ATT-XC-015` — see Conflict 5 |
| 8 | optional **location result** | ✅ exists | `VerificationEvidence(GPS)`, plus `ATT-CFG-010`/`011`/`012` |
| 9 | session **status** | 🔴 does not exist | `AttendanceStatus` exists but is a *day* status, not a session status — see point 19 |
| 10 | created / updated timestamps | ✅ exists | standard on the aggregate; `ATT-FR-088` platform time |
| 11 | audit information | ✅ exists | `ATT-FR-129`…`133` via `E-20` |

**Count: 5 exist, 3 partially exist, 3 do not exist.** The three that do not exist (duration, session status, and the session itself as a record) are exactly the three that `ATT-BR-033` and the `BC-26` ownership ruling govern.

### 15.3 Duplicate / overlap prevention

Request §8 requires preventing duplicate overlapping sessions. Request §10 requires no overlapping sessions when a student moves between authorized access points.

`ATT-INV-004` already provides the *shape* of this rule — *"no more than one open session per student at any moment"* — sourced from BC Map §8 L372, and narrowed at PRD-006 L1013 so that open days at **different libraries** simultaneously are explicitly **not** a violation. So the invariant is per **(student, tenant)**, not global.

That invariant is directly reusable and needs **no amendment** for the single-library case. It does **not** answer the access-point handoff case, because "the same authorized presence domain" (request §10) is not a concept PRD-006 defines, and the request itself says *"the exact handoff mechanism must be specified explicitly."* Recorded as `Q-W-05`.

**Conclusion for point 15:** the data model can carry the *evidence* and the *tenant/audit/location* halves of the request today. It cannot carry a session, a duration or a session status without either changing the `AttendanceDay` aggregate boundary (Rank 4) or creating a second presence system of record (`ATT-BR-033`).

---

## 16. Event model implications

### 16.1 The closed event set

`ATT-FR-134` (L1480): the module *"**MUST** publish **only** the events below. It **MUST NOT** invent an event name, a producer or a consumer."*

| Event | Also registered in | Rank |
|---|---|---|
| `attendance.StudentCheckedIn` | BC Map §9 L414 | 4 |
| `attendance.StudentCheckedOut` | BC Map §9 L415 | 4 |
| `attendance.AttendanceCorrected` | BC Map §9 L416 | 4 |
| `attendance.FraudSignalDetected` | BC Map §9 L417 | 4 |

BC Map §7 L292 reinforces it at the edge level: *"If an edge is not in this table, it **does not exist** and adding it requires an ADR."*

### 16.2 Verdict on each event the request implies

| Event the request needs | Verdict | Governing rule |
|---|---|---|
| presence session started | 🔴 not publishable | `ATT-FR-134` — invented event name |
| presence session ended | 🔴 not publishable | `ATT-FR-134` |
| study hours started | 🔴 not publishable, **and** not this context's to publish | `ATT-FR-134` + `BC-26` ownership (point 17) |
| study hours stopped | 🔴 not publishable | same |
| Wi-Fi authorization added / removed / enabled / disabled | ⚠️ not an integration event, but **already covered as audit** | `ATT-FR-038` audit on Wi-Fi config change; `ATT-FR-129`…`133` via `E-20` — no new event needed |
| attendance created by Wi-Fi mode | ⚠️ the *event* already exists (`StudentCheckedIn`); the **mode** does not | Conflict 1, not Conflict 7 |

That last row matters: auto-created attendance does **not** require a new event. `StudentCheckedIn` is already the right event. What it cannot carry is a seventh `AttendanceMethod`.

### 16.3 A compounding finding — there is no authorised delivery path to analytics

Even if a Study Hours read model were authorised, it would have no legitimate way to be fed:

- BC Map §9 names `BC-26` as a **consumer** of attendance events.
- BC Map §7 (the edge table, L292) declares **no** `BC-03` → `BC-26` edge, and *"if an edge is not in this table, it does not exist."*
- `ATT-FR-137` forbids this module from depending on `BC-26` consuming anything.

This is an existing, already-registered systemic gap (`ATT-GAP-003`, corresponding to `MM-GAP-010`) — **not** something this feature creates. But it means the Study Hours conflict is not merely an ownership question; the pipe itself is undefined.

**Conclusion for point 16:** four of the six events the feature implies are forbidden outright by `ATT-FR-134`. One needs no event at all (audit already covers it). One reuses an existing event but needs a forbidden new mode. Opening the event set requires an ADR **and** a Rank 4 BC Map amendment, in that order.

---

## 17. Study Hours model

### 17.1 Where Study Hours lives today — measured, not inferred

Repository-wide measurement:

```
$ grep -rn -i "study hour" docs/
docs/30-product/student-identity/Student_Identity_PRD_v1.md:474
docs/30-product/student-identity/Student_Identity_PRD_v1.md:592
docs/30-product/student-identity/Student_Identity_PRD_v1.md:596

$ grep -c -i "study hour" docs/30-product/attendance-management/PRD-006_ATTENDANCE-MANAGEMENT.md
0
```

Three hits in the whole repository. All three in one file. **Zero** in PRD-006.

The governing lines, verbatim:

```
L470  | Attendance      | percentage · present days · summary                          | BC-03  |
L474  | Study Analytics | study hours · streak · reading statistics · productivity     | BC-26  |
L592  daily / weekly / monthly study hours
L477  SID-2.38  Aggregation SHALL be read-only composition. This module SHALL NOT
                store, cache beyond a display request, or become the authority for
                any contributed value.
```

L470 is decisive by contrast: the same table that grants `BC-03` *"percentage · present days · summary"* grants **Study Analytics** — explicitly including *"study hours"* — to **`BC-26`**. The split is deliberate and adjacent.

### 17.2 The rank, and what it costs

`DOCUMENTATION_BASELINE.md` L155: `Student_Identity_PRD_v1.md` is **v1.0 | Authoritative** → **Rank 3**.
`DOCUMENTATION_BASELINE.md` L286: *"A change to any Rank 1–5 document requires an ADR **before** the change."*

PRD-006 holds **no** baseline rank (0 rows) and `PRD_REGISTRY.md` L236 records it as `PLANNED`. So this is a lower-standing document proposing to take a capability assigned to another context by a higher-ranked one. That is the definition of the case `PRD_LIFECYCLE.md` Stage 1 sends back: *"Does another PRD already own the context? It is an amendment to that PRD, not a new one."*

### 17.3 And the receiving owner's PRD does not exist

| Fact | Evidence |
|---|---|
| `PRD-009` Analytics & Reports is assigned to `BC-26`, V1 | `PRD_REGISTRY.md` L239 |
| Its status is `PLANNED` | `PRD_REGISTRY.md` L239 |
| No directory for it exists | `ls docs/30-product/` — no analytics directory |

So Study Hours has an owner, and that owner has no document. There is currently **no correct file in the repository to specify Study Hours in.** This is the single hardest finding in this report, and it is not solvable by drafting — only by a Product Owner decision on sequencing.

### 17.4 The request's own definition, requirement by requirement

| Request §8 requirement | Verdict |
|---|---|
| Study Hours **MUST NOT** equal "app open time" | ✅ correct and uncontroversial; no PRD-006 rule contradicts it |
| Study Hours **MUST NOT** equal "last attendance time → current time" | ✅ correct; and note `ATT-BR-030` already forbids the closely-related sin of inventing a check-out timestamp |
| Study Hours = validated presence-session duration | 🔴 requires a presence session (Conflict 2) **and** Study Hours ownership (Conflict 3) |
| Session record with 11 fields | ⚠️ see §15.2 — 5 exist, 3 partial, 3 absent |
| Prevent duplicate overlapping sessions | ✅ shape exists as `ATT-INV-004`, reusable |
| Bounded grace / reconnection policy | 🔴 blocked — a bound is a numeric threshold; the request itself says do not invent one. `Q-W-04` |
| Stop counting on disconnect; do not count indefinitely | ✅ intent is consistent with `ATT-BR-030`'s spirit (no fabricated open-endedness); the mechanism is blocked, the principle is not |

### 17.5 An observation on shape — offered as an observation only

`SID-2.38` (L477) describes a pattern the repository already uses for exactly this class of problem: *"Aggregation **SHALL** be read-only composition. This module **SHALL NOT** store, cache beyond a display request, or become the authority for any contributed value."*

If a decision-maker wished to expose Study Hours to a student without moving ownership, that read-only-composition shape is the precedent already present in the codebase's own governance.

This is recorded here because point 10 asks for gaps and point 18 forbids invention — and stating an existing precedent is neither a recommendation nor a decision. Three reasons it changes nothing:

1. It still requires a **producer** of the duration, and no context is authorised to produce it.
2. It still requires a `BC-03` → `BC-26` edge that BC Map §7 says does not exist (§16.3).
3. `SID-2.38` binds Student Identity, not Attendance; applying it to `BC-03` is itself an architecture decision.

**Conclusion for point 17:** Study Hours is **owned elsewhere, by a Rank 3 document, in a context whose PRD has not been written.** It cannot be added to PRD-006 by amendment. It is `A-3` in point 11 and `Q-W-03` in point 10.

---

## 18. Owner / Manager configuration

### 18.1 What already exists

| Fact | Source | Line |
|---|---|---|
| `manager` is a **real, permitted role** in this module | `ATT-FR-003` | L263 |
| Its stated purpose is *"Daily operations management"* | `ATT-FR-003` | L263 |
| Manager holds **operational** duties: operational actions, individual manual entry, OCR verification, corrections | §19.2 | L1383-1386 |
| Manager holds **zero configuration authority** — measured, all **24 of 24** `ATT-CFG` rows name **Owner** | §16.3 register | L1162-1200 |
| Wi-Fi configuration is specifically Owner-only | `ATT-FR-033` | L696 |
| Approved Wi-Fi network(s) is already a **tenant-scoped list**, default **Empty** | `ATT-CFG-008` | L1162 |
| Wi-Fi configuration change is **already audited** | `ATT-FR-038` | — |
| Tenant scoping of configuration is mandatory and backend-enforced | `ATT-BR-017` | — |
| This module stores **no** configuration itself | `ATT-FR-002` | L216 |
| All configuration flows through `BC-25` via edge `E-19` | `ATT-FR-097` / `ATT-FR-098` | L1121-1122 |
| No settings hierarchy and no feature-flag system may be built | `ATT-FR-098` | L1122 |

### 18.2 Request §3, item by item

| # | Request §3 item | Available today? | What is needed |
|---|---|---|---|
| 1 | View authorized networks | ✅ **yes, no amendment** | `ATT-CFG-008` is already a list; reading it is already Owner-permitted |
| 2 | Add a network | ✅ **yes, no amendment** | same |
| 3 | Remove a network | ✅ **yes, no amendment** | same |
| 4 | See which are active | ⚠️ partial | the list exists; an *active/inactive* attribute per entry does not |
| 5 | Enable / disable an individual network | 🔴 no | an enabled flag per list entry is a new field on `ATT-CFG-008`'s shape — a config-register amendment |
| 6 | Assign a human-readable label (`LIBRARY_MAIN`, `LIBRARY_2ND_FLOOR`) | 🔴 no | a label field is a new attribute; also a config-register amendment |
| 7 | Manage **multiple** networks | ✅ **yes, no amendment** | `ATT-CFG-008` says *"list"*, plural, today |
| 8 | Audit history of authorization changes | ✅ **yes, no amendment** | `ATT-FR-038` + `ATT-FR-129`…`133` via `E-20` |
| 9 | Tenant isolation of the configuration | ✅ **yes, no amendment** | `ATT-BR-017` — request §11 is fully satisfied already |
| 10 | **Manager** (not only Owner) may do all of the above | 🔴 no | a **permission change**, decided by the Product Owner, applied across the `ATT-CFG` register. This is Conflict 11 / `Q-W-07`. |

**4 of 10 items are available with no amendment at all** (1, 2, 3, 7), and two more (8, 9) are satisfied by existing cross-cutting rules — so **6 of 10** require nothing. Four require change: three are `ATT-CFG-008` shape attributes (4, 5, 6), one is a role-permission decision (10).

Critically: **none of the four is blocked by an EXCLUSION.** They are all inside PRD-006's own authority. This is the cleanest area in the entire request.

### 18.3 The one thing that is not clean

Duplicate prevention on the network list (request §10) cannot be specified without knowing **what makes two entries "the same network."** That is the network-identity question fenced by `ATT-XC-015` and registered as `ATT-GAP-007` (owner: Architecture owner, status 🔴 OPEN). Until it is answered, "prevent duplicates" has no testable definition. Recorded as `Q-W-02`.

**Conclusion for point 18:** the Owner/Manager configuration surface is **the most additive part of the request.** Six of ten items need nothing; three need a bounded `ATT-CFG-008` amendment within PRD-006's own authority; one needs a Product Owner permission decision. No EXCLUSION is violated anywhere in this point.

---

## 19. Student experience

### 19.1 The twelve conceptual steps, assessed

| Step | Request §6 step | Status | Governing note |
|---|---|---|---|
| 1 | Student enters the library | ✅ neutral | no rule engaged |
| 2 | Phone connects to authorized Wi-Fi | ⚠️ | connection itself is outside the module; `ATT-XC-021` excludes device lifecycle |
| 3 | App detects the connection | 🔴 | requires the Android/background model that does not exist (point 13) |
| 4 | Validate eligibility / membership | ⚠️ **see 19.2** | must **flag**, not block |
| 5 | Presence session starts | 🔴 | Conflict 2 — `ATT-BR-033` |
| 6 | Attendance is created | 🔴 | Conflict 1 — no seventh mode; and Conflict 6 — Wi-Fi may attach only to `FIXED_QR_WIFI` |
| 7 | Study Hours start | 🔴 | Conflict 3 — `BC-26` ownership |
| 8 | Student studies | ✅ neutral | no rule engaged |
| 9 | Disconnect | 🔴 | requires the detection model of step 3 |
| 10 | Presence session ends | 🔴 | Conflict 2 |
| 11 | Study Hours stop | 🔴 | Conflict 3 |
| 12 | Persist the record | ⚠️ | persistable as evidence; not persistable as a session (§15.2) |

**Two steps neutral, three partially supported, seven blocked.**

### 19.2 A specific finding on step 4 — "validate membership" must not become "block"

Request §12 lists *"not an active member"* and *"membership expiry mid-session"* as failure cases. PRD-006 has already decided how this module treats invalid membership, and the decision is the opposite of blocking:

- `ATT-NFR-009` — when membership data is stale, the module **flags**; it never blocks.
- BC Map `E-03` (L300) — attendance *"flags `membershipInvalid` rather than blocking entry."*

So a Wi-Fi presence design that **refuses** to start a session because membership is invalid would contradict an existing rule. The correct behaviour, per existing rules, is: start, and flag. This is not a conflict with the request — the request only says "validate" — but it is a constraint the eventual design must respect, and it is worth stating because the natural reading of "validate eligibility" is "reject if ineligible."

### 19.3 Student dashboard (request §15)

| Requested element | Available today? | Note |
|---|---|---|
| Presence status | 🔴 | Conflict 2 |
| Today's Study Hours | 🔴 | Conflict 3 |
| Total Study Hours | 🔴 | Conflict 3 |
| Attendance created by Wi-Fi mode | 🔴 | Conflict 1 |
| Session start / end history | 🔴 | Conflict 2 — no session record exists |
| Verification method shown to the student | ✅ | `AttendanceMethod` is recorded per punch and is displayable |

### 19.4 The four requested UI states versus the three that exist

Request §15 requires the UI to distinguish **Present · Not Present · Study Session Active · Study Session Ended**.

PRD-006's `AttendanceStatus` is a **day** status with three values, not a session status. The mapping is not partial — it is a category difference:

| Requested UI state | Maps to an existing state? |
|---|---|
| Present | ⚠️ approximately, via an open `AttendanceDay` |
| Not Present | ⚠️ approximately, via no open `AttendanceDay` |
| Study Session **Active** | 🔴 no — there is no session concept |
| Study Session **Ended** | 🔴 no — same |

Note also that "Not Present" cannot be derived reliably today, because check-out is **optional** (`ATT-CFG-021` / `ATT-BR-029`) and a check-out timestamp **must not be fabricated** (`ATT-BR-030`, L1025). An open day is therefore not proof of current presence. That is precisely why `ATT-BR-033` assigns live occupancy to `BC-04`.

### 19.5 The device constraint that bounds all of this

`ATT-BR-008` (L529): *"A student **MUST NOT** be required to have a smartphone in order to attend."*
`ATT-NFR-014` (L1673): Manual accessibility MUST NOT become worse, because *"the students served by Manual are those least served by devices."*

A Wi-Fi presence feature is **inherently** smartphone-dependent. It therefore cannot become the *only* path, and it cannot degrade the Manual path. As an **additional optional** capability alongside the six existing modes it does not violate `ATT-BR-008`; as a replacement for any of them it does. This is Conflict 12, and it is a conflict only under the replacement reading — which the user's §1 explicitly disclaims.

**Conclusion for point 19:** the student experience is **7/12 blocked**, all seven by the same three decisive conflicts. The one non-obvious design constraint discovered is 19.2: validation must flag, not block.

---

## 20. Migration / backward compatibility

### 20.1 There is nothing to migrate — measured

| Fact | Evidence |
|---|---|
| PRD-006 is `DRAFT` v1.4 | document header |
| `PRD_REGISTRY.md` records it as `PLANNED` | L236 |
| It holds **zero** baseline rank rows | `DOCUMENTATION_BASELINE.md` — 0 PRD-006 rows |
| Stage 8 (implementation) has **not** been entered | `PRD_LIFECYCLE.md` L181-200 gates unmet |
| Implementation tasks exist on paper only: 80 tasks `IMPL-600`…`679`, **11 BLOCKED** | `PRD-006_IMPLEMENTATION_TASKS.md` |
| **Zero attendance code exists** in `lib/` | measured — no attendance module in the Flutter tree |

**Therefore: no data migration is required, no schema migration is required, and no deployed behaviour would change.** There is no production attendance system to be backward-compatible *with*. This is the one point in the entire report where the answer is unambiguously easy.

### 20.2 What backward compatibility still means here — six obligations

Compatibility is owed to the **specification**, not to data. If the feature were later approved, these six must hold:

| # | Obligation | Source of the obligation |
|---|---|---|
| 1 | All six existing modes remain available and unchanged | `ATT-FR-007`, request §1 |
| 2 | Fixed QR remains a complete, independently sufficient flow | §8, request §1 |
| 3 | GPS capability remains, with its existing approved radii (**50 m / 20–200 m**, **30 m / 5–100 m**) unchanged | `ATT-CFG-011`, `ATT-CFG-012`, request §5 |
| 4 | Location remains **optional** per tenant (`ATT-CFG-010` default **Unset**) | `ATT-CFG-010`, request §5 |
| 5 | Manual attendance remains **Enabled** by default and no less accessible | `ATT-CFG-017`, `ATT-BR-038`, `LIB-16.2`, `ATT-NFR-014` |
| 6 | The correction workflow, audit trail and tenant isolation remain intact | §13, `ATT-FR-129`…`133`, `ATT-BR-017` |

**All six are satisfied by this report itself**, because this report changes nothing. They are recorded as the compatibility contract for whoever implements a future decision.

### 20.3 The real cost is protected-file churn, not migration

| File | Rank | Why it would need to change | Authority required |
|---|---|---|---|
| `PRD-006_ATTENDANCE-MANAGEMENT.md` | unranked (DRAFT) | mode set, exclusions, config register, events, ACs | Product Owner + Architecture Owner |
| `LIBOORA_BOUNDED_CONTEXT_MAP.md` | 4 | §7 edges, §8 aggregates, §9 events | ADR (§7 L292 explicitly) |
| `Student_Identity_PRD_v1.md` | 3 | Study Hours ownership at L474 | ADR before change (`DOCUMENTATION_BASELINE.md` L286) |
| `TRACEABILITY_MATRIX.md` | 4 | `ATT-AC-*` count, currently **213**; total **516**; obligation-bearing **285** | ADR before change |
| `DOCUMENTATION_BASELINE.md` | 1 | rank/baseline entries if ownership moves | ADR |
| `PRD_REGISTRY.md` | — | `PRD-009` sequencing if Study Hours is written there | Product Owner |
| `ADR-INDEX.md` | — | registering any new ADR | Architecture Owner |
| `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` | 4 | if a new dependency edge is introduced | ADR |

**Eight files, of which five are Rank 1–4 protected.** Every one of them is byte-identical right now and remains so.

### 20.4 The precedent for how this must be done

`PRD_LIFECYCLE.md` after-freeze table:

> business-rule change → *"ADR → version increment → changelog → baseline update, **in that order**"*
> ownership / boundary change → ADR; `LIB-26.2` *"**MUST NOT** be amended by a PRD revision alone"*
> *"A frozen PRD is never silently modified. Not for an obvious correction, and not for one that is certainly right."*

`TRACEABILITY_MATRIX.md` L446 records the concrete precedent for the *smallest* kind of change: a gap was closed *"by **extending `ATT-AC-152`, not by inventing a criterion**."* That is the sanctioned pattern — extend an existing obligation rather than add a new ID — and it is the pattern any future Wi-Fi presence amendment should be measured against.

**Conclusion for point 20:** ✅ **no data or schema migration is required.** The cost is entirely governance: **eight files, five of them Rank 1–4 protected**, in the strict order ADR → amendment → version → changelog → baseline.

---

## 21. Testing requirements

### 21.1 The binding coverage rule

`ATT-NFR-010` requires **100% acceptance-criterion coverage** of obligation-bearing requirements. The current measured position, from `prd006_traceability.py` (last run, exit 0 PASS):

```
ATT-AC-*                213
total registered IDs    516
obligation-bearing      285
coverage                285 / 285 = 100.0%
dangling                0
orphan                  0
gap ledger              3 resolved · 1 narrowed · 17 open
```

And the standing rule that shapes everything below: **no acceptance criterion may test a `GAP`.** A criterion whose expected result depends on an unresolved decision is not a criterion.

### 21.2 What is testable today, and what is not

| # | Test area implied by the request | Testable now? | Why |
|---|---|---|---|
| 1 | Tenant isolation of the Wi-Fi network list | ✅ | `ATT-BR-017` is concrete; request §11 needs no change |
| 2 | Audit entry written on Wi-Fi config change | ✅ | `ATT-FR-038` |
| 3 | Multiple networks may be stored per tenant | ✅ | `ATT-CFG-008` already says *"list"* |
| 4 | Anti-cheating position — no claim of impossibility | ✅ **already covered** | `ATT-AC-033` (L1852) makes `ATT-BR-042` testable |
| 5 | Wi-Fi is not treated as identity proof | ✅ **already covered** | `ATT-XC-014` (L679) + existing Wi-Fi ACs |
| 6 | Failure reasons are distinguishable, never generic | ✅ | `ATT-NFR-005`, `ATT-FR-034`/`035`/`036` |
| 7 | No silent downgrade when Wi-Fi is unavailable | ✅ **already covered** | `ATT-FR-036` |
| 8 | GPS radii unchanged at 50 m / 30 m with their ranges | ✅ | `ATT-CFG-011`, `ATT-CFG-012` |
| 9 | Location remains optional per tenant | ✅ | `ATT-CFG-010` default **Unset** |
| 10 | Enable / disable an individual network | 🔴 | field does not exist (§18.2 item 5) |
| 11 | Duplicate network entry rejected | 🔴 | "same network" undefined — `ATT-GAP-007` / `Q-W-02` |
| 12 | Presence session starts / ends correctly | 🔴 | no session exists — Conflict 2 |
| 13 | Study Hours computed as session duration | 🔴 | not owned here — Conflict 3 |
| 14 | Transient disconnect within the grace window | 🔴 | no bound exists, and none may be invented — `Q-W-04` |
| 15 | Access-point handoff produces no duplicate attendance | 🔴 | handoff mechanism undefined — `Q-W-05` |
| 16 | Background detection after app close / phone restart | 🔴 | platform model absent — `Q-W-10` |

**Nine of sixteen areas are testable today; five of those nine are already covered by existing criteria.** Seven are untestable because they depend on an open decision, and writing a criterion for any of them would violate the "no criterion tests a `GAP`" rule.

### 21.3 The eighteen failure cases of request §12

| Category | Cases | Testable today? |
|---|---|---|
| Unauthorized Wi-Fi · spoofed SSID | 2 | ⚠️ testable only as *"the system does not claim proof"* (`ATT-AC-033`); **not** testable as detection, because detection is `ATT-GAP-007` |
| Disconnect · temporary disappearance · moving between networks · switch to mobile data · manual Wi-Fi disable | 5 | 🔴 all require the session + grace-window decisions |
| Not an active member · membership expiry mid-session | 2 | ⚠️ the **flag-not-block** rule is testable today (`ATT-NFR-009`); the mid-session half is not |
| Duplicate presence event · duplicate attendance event | 2 | ⚠️ attendance-side idempotency is testable (`ATT-FR-090`…`095`); presence-side is not |
| App closed · phone restarted · network unavailable · backend unavailable | 4 | 🔴 platform/offline model absent (`Q-W-10`); note `ATT-PO-011` says this module defines *policy* only |
| Location enabled-but-unavailable · location permission denied · Wi-Fi permission denied | 3 | ⚠️ the location pair is testable via `ATT-FR-044` (L739); the Wi-Fi-permission case has no existing rule |

**Roughly 5 of 18 fully testable, 6 partially, 7 not at all.**

### 21.4 The mechanical constraint that recurs here

Any new `ATT-AC-*` criterion changes the count from **213**. `prd006_traceability.py` L380-402 cross-checks that count against `TRACEABILITY_MATRIX.md` §2F, which is **Rank 4 protected** and requires an ADR *before* modification (`DOCUMENTATION_BASELINE.md` L286).

And the suffix escape does not exist: the AC parser regex at L298 is

```
^\|\s*`(ATT-AC-\d{3})`\s*\|
```

— exactly three digits. An ID such as `ATT-AC-199a` **will not match** and will therefore be invisible to the gate rather than counted. So there is no way to add a criterion "quietly."

The sanctioned alternative is already precedented: `TRACEABILITY_MATRIX.md` L446 records a gap closed *"by **extending `ATT-AC-152`, not by inventing a criterion**."* Extending existing criteria does not change the count and does not touch a protected file.

**Conclusion for point 21:** testing is **partially specifiable today** — nine areas, five already covered. Everything session-, Study-Hours- and platform-dependent is untestable by rule, not by omission. Adding new criteria is gated by a Rank 4 file.

---

## 22. Freeze / governance impact

### 22.1 The measured governance state, before anything

| Fact | Value | Source |
|---|---|---|
| PRD-006 status | **DRAFT v1.4** | document header, hash `28965ddbb4480a50` |
| Registry status | **`PLANNED`** | `PRD_REGISTRY.md` L236 |
| Baseline rank rows for attendance-management | **0** | `DOCUMENTATION_BASELINE.md` |
| Stage 4 | ⚠️ **CONDITIONALLY PASSED**, 6/6 checks pass | `PRD-006_STAGE4_RE_REVIEW.md` v1.1 |
| Stage 7 (freeze) | ⛔ **NOT ENTERED** | no baseline row, registry `PLANNED` |
| Open gaps | **17 open** (of 21 rows / 18 numbers) | gap ledger |
| ADRs relating to PRD-006 | `ADR-0021`, `ADR-0022`, `ADR-0023` — **all `Proposed`** | ADR files |
| `ADR-INDEX.md` L9 | *"20 accepted … **0 proposed**"* — **stale by three** | measured; pre-existing defect, disclosed not fixed |
| Signed commits | **0** (`git log --pretty=%G?` → all `N`) | measured |

**PRD-006 is not frozen. It was never frozen. Nothing in this report freezes it, and nothing in this report unfreezes it.**

### 22.2 Compliance with the ten governance-safety rules of request §18

| # | Rule | Compliance in this report |
|---|---|---|
| 1 | Read PRD-006 completely before concluding | ✅ ~2400 lines read; §3 of this report lists every section with line numbers |
| 2 | Identify all existing rules that apply | ✅ registers measured mechanically: FR 151 · BR 45 · INV 12 · XC 21 · CFG 24 · NFR 14 · EVT 4 · PO 14 · AC 213 · GAP 21 |
| 3 | Identify **every** conflicting rule | ✅ 13 conflicts, each with exact ID, line number and verbatim wording |
| 4 | **DO NOT override a higher-authority rule** | ✅ none overridden; Rank 3 and Rank 4 findings are reported, not resolved |
| 5 | **DO NOT invent missing security / network-identity rules** | ✅ `grep -ci "bssid"` = **0** before and after; no mechanism proposed; `ATT-GAP-007` left open |
| 6 | **DO NOT invent numeric thresholds** | ✅ **zero** new numbers anywhere; grace window, scan interval, persistence frequency and load figures all left as named open questions |
| 7 | **DO NOT fabricate human approval** | ✅ header states *"Approvals asserted: **None**"* |
| 8 | **DO NOT mark an ADR Accepted without genuine authorization** | ✅ **no ADR created at all**; six are *identified as required* (A-1…A-6) |
| 9 | **DO NOT weaken Stage 4/5/6/7 gates** | ✅ no gate script read-modified; `prd006_task_coverage.py` and `prd006_traceability.py` untouched; Stage 4 verdict left at ⚠️ CONDITIONALLY PASSED |
| 10 | **DO NOT modify protected / ranked documents without authorization** | ✅ **all 13 protected hashes byte-identical**, verified before and after writing |

And the overriding instruction — *"If the new feature conflicts with an existing MUST/EXCLUSION: STOP and report the exact conflict. Do not 'solve' it by silently changing the old rule."* — is the organising principle of this entire document. **Not one existing rule was changed to accommodate the feature.**

### 22.3 What a freeze path would cost, if the feature were approved later

| # | Consequence | Detail |
|---|---|---|
| 1 | Open gaps would rise from **17** to roughly **29** | the 12 new questions `Q-W-01`…`Q-W-12` would become `ATT-GAP-*` rows once authorised |
| 2 | The ARB backlog would rise from **3** to **9** | `ADR-0021`/`0022`/`0023` already `Proposed`, plus `A-1`…`A-6` |
| 3 | Stage 4 would have to be re-run | its 6/6 pass was measured against the current rule set |
| 4 | Stage 5 / 6 could not be entered while any `Q-W-*` blocks a MUST | `PRD_LIFECYCLE.md` — an unresolved gap is not a passable gate |
| 5 | Five Rank 1–4 protected files would need ADR-first amendment | §20.3 |
| 6 | `PRD-009` would have to be sequenced or Study Hours deferred | it is `PLANNED` with no directory (§17.3) |

An additional Stage 1 consequence, from `PRD_LIFECYCLE.md` L60-78: *"Is it V1/V2/V3, or Future? Future ⇒ **stop**."* Combined with `ARCHITECTURE_RULINGS.md` L290 — Public Live Occupancy is *"**Deferred — V2.** … Live per-seat occupancy is a proxy for individual presence and **must not be invented**"* — a live "who is currently present" surface (request §14) sits adjacent to an already-deferred V2 item. Whether Wi-Fi presence is V1 at all is therefore itself a Stage 1 question, recorded as `Q-W-12`.

### 22.4 What is *not* blocked

To keep the picture accurate rather than uniformly negative:

- **Request §11 (multi-tenant security)** — satisfied today. No change.
- **Request §17 (anti-cheating position)** — satisfied today, and **already stricter** than asked. No change.
- **Request §5 (optional location, reuse existing GPS config)** — satisfiable today with `ATT-CFG-010`/`011`/`012`. No new radius.
- **Request §16 (audit)** — the Wi-Fi-configuration half is satisfied today by `ATT-FR-038` + `ATT-FR-129`…`133`.
- **Request §3 items 1, 2, 3, 7, 8, 9** — six of ten available with no amendment.
- **Requirement group K** and the configuration half of group E (point 9) — unblocked.

**Conclusion for point 22:** governance is **fully intact**. Zero protected files modified, zero gate scripts touched, zero ADRs created, zero approvals asserted, zero numeric thresholds invented, zero code written. The feature's cost is not technical — it is **six ADRs and five protected-file amendments**, in a strictly ordered sequence, by named authorities.

---

## 23. Change history

| Version | Date | Author | Change |
|---|---|---|---|
| v1.0 | 2026-08 | AI analysis, unapproved | Initial READ-ONLY impact analysis of the proposed additive Wi-Fi Presence + Automatic Attendance + Study Hours capability against `PRD-006_ATTENDANCE-MANAGEMENT.md` v1.4 DRAFT (`28965ddbb4480a50`). 22 required points delivered. 13 conflicts identified, 3 structurally decisive. **No document amended. No ADR created. No approval asserted. No threshold invented. Zero files modified.** |

---

## END OF READ-ONLY IMPACT ANALYSIS — STOP

This document is an **analysis**, not a decision, not an amendment, not a PRD and not an ADR.

It confers nothing, freezes nothing, approves nothing and authorises nothing.

The next legitimate step is **human decision** by the named authorities in points 10 and 11 — not further drafting.
