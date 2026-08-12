# `ATT-GAP-015` — Decision Pack: Is Face Attendance V1 or V3?

| Field | Value |
|---|---|
| **Document** | `ATT-GAP-015` Decision Pack |
| **Version** | v1.0 |
| **Date** | 2026-08-04 |
| **Status** | **Decision support only — decides nothing** |
| **Subject** | `PRD-006_ATTENDANCE-MANAGEMENT.md` v1.3 DRAFT, SHA-256 `93ab1c60d740c4e0…` |
| **Raised by** | `PRD-006` §12.5, §32; carried forward by `ADR-0021` §4 and the `ATT-GAP-017` Decision Sheet §3 |
| **`ATT-GAP-015` status** | 🔴 **OPEN — unchanged by this document** |
| **`ADR-0021` status** | **Proposed** — unchanged |
| **Decision taken here** | **None.** This pack presents the options and names the deciders |

> **Scope guard.** This pack does **not** choose V1 or V3, does **not** invent biometric architecture, does
> **not** modify `PRD-006`, `ADR-0021`, `PRD_REGISTRY.md`, `DOCUMENTATION_BASELINE.md` or any frozen document,
> does **not** close `ATT-GAP-015`, and freezes nothing. It answers the six questions asked and stops.

---

## 1. The question, stated precisely

`PRD-006` §32 records it as:

> *"Is Face attendance **V1** or **V3**? EA v2.1 lists `Face Recognition (V3)`; the product instruction says V1.
> EA is Rank 6 descriptive, but no Rank 1–5 document places it in V1."*

The dispute is **not** whether face attendance is specified — it is fully specified in `PRD-006` §12 — nor
whether it may be built, which `ATT-FR-064` already settles in the negative. The dispute is **which release
class the capability belongs to**, and therefore whether its unresolved dependencies are V1 obligations or
V3 obligations.

**Two sources disagree and neither can settle it:**

| Source | Says | Rank | Can it settle the question? |
|---|---|---|---|
| Enterprise Architecture v2.1, L754 | `Face Recognition (V3)` | **6 — descriptive only** | ❌ No. Baseline §4: *"Update it to match 1–5; never the reverse."* EA follows the PRDs; it cannot lead them |
| The authoring instruction for `PRD-006` | Face is a V1 mode | **Not a document** | ❌ No. An instruction is not a Rank 1–5 source and leaves no reviewable record |

`PRD-006` §12.5 states the position exactly, and refuses to resolve it in either direction:

> *"EA is **Rank 6, descriptive only** … so it does not outrank a product decision. But no Rank 1–5 document
> places Face in V1 either. This is recorded as **`ATT-GAP-015`** and is **not** silently resolved in either
> direction."*

That refusal is correct under `DOCUMENTATION_BASELINE.md`: *"**A conflict is a defect.** If you find one, do
not choose — raise it."*

---

## 2. What authoritative source supports each classification

### 2.1 Searched, and what was found

| Search | Scope | Result |
|---|---|---|
| `biometric`, `face recognition`, `facial` | all of `docs/**`, excluding the attendance module | **3 hits, none supporting V1** |
| `Face` | `LIBOORA_ENTERPRISE_ARCHITECTURE.md` | **1 relevant hit** — L754 `Face Recognition (V3)` |
| `QR`, `GPS`, `biometric`, `face` | `MASTER_PRD.md` (Rank 1) | **4 hits, none an attendance mode** |
| Attendance capability list | `LIBOORA_BOUNDED_CONTEXT_MAP.md` (Rank 4) | **None** — BC-03 is scoped by responsibility, not by mode |

The three non-attendance hits, inspected at their lines:

| Hit | Text | Does it place Face in V1? |
|---|---|---|
| `LIBOORA_ENTERPRISE_ARCHITECTURE.md:754` | `Face Recognition (V3)` | **It places it in V3** — but Rank 6, descriptive |
| `Authentication_PRD_v2.md:968` (Rank 3) | *"**Biometric login** — Device-local convenience, **not an authentication factor the platform can verify**"* | ❌ No. This **excludes** biometrics from `BC-18`, and is about *login*, not attendance |
| `Student_Identity_PRD_v1.md:187` (Rank 3) | `SXC-4` — *"Library Identification Photo · Organisation-scoped **biometric-adjacent** asset"* | ❌ No. This is an **exclusion** row. `BC-10` explicitly does not hold it, and *"biometric-adjacent"* is deliberately not *"biometric"* |

> **Two of the three hits are exclusions.** The only two Rank 3 documents that mention biometrics at all do so
> to say **they do not own them**. That is not support for a V1 classification — but it is not support for V3
> either. It is a **void**: no Rank 1–5 document assigns face biometrics to any release class, and two
> explicitly push them away.

### 2.2 Rank 1 places the **module** in V1, not the **mode**

`MASTER_PRD.md` L160 (Rank 1) reads:

> `| 8 | Attendance Management | BC-03 Attendance | [CORE] | V1 |`

The Bounded Context Map L98 (Rank 4) agrees: `BC-03 · Attendance · [CORE] · V1`.

**Both classify the module. Neither enumerates modes.** `MASTER_PRD.md` mentions no attendance mode anywhere —
not QR, not GPS, not Wi-Fi, not Face. **Rank 1 therefore does not decide this question**, and cannot be cited
in either direction. The only document in the repository that classifies attendance *capabilities* individually
is the EA — and it is Rank 6.

### 2.3 The precedent that matters most: `PRD-006` has already overridden EA version tags — five times

EA v2.1's attendance tree tags these as **V2**, yet `PRD-006` specifies them as V1 content without raising a gap:

| EA capability | EA tag | `PRD-006` treatment |
|---|---|---|
| Attendance Corrections | **V2** | §18 fully specified — `ATT-FR-110`…`116`, `ATT-INV-011` |
| Clock Skew Handling | **V2** | `ATT-BR-015` specified, with an explicit narrowing note |
| Late Entry Rules | **V2** | Referenced via `AttendanceRules` (BC Map E-04) |
| Early Exit Rules | **V2** | Exit tracking specified |
| Attendance Policies / Reports | **V2** | Partially in scope |

Corrections are the sharpest case: **Rank 1 `MP-GBR-11` mandates the correction workflow** (*"Corrections exist,
but are append-only, carry an actor and a reason"*), which makes corrections a V1 obligation **regardless** of
the EA's V2 tag. `PRD-006` did not raise a gap there because **a Rank 1 rule settled it**.

The Clock Skew note (L652) shows the disciplined pattern:

> *"**Clock Skew Handling is listed V2** in Enterprise Architecture v2.1's attendance tree. `ATT-BR-015` does
> not specify a skew-correction mechanism — it states which clock wins, which is a V1 necessity for a rotating
> code. A skew *correction* algorithm remains out of V1 scope."*

**Why Face is different, and why it alone got a gap.** In all five cases above, a Rank 1–5 source or an
in-scope V1 necessity justified the override. **For Face, there is none.** The EA tag is the *only* classifying
statement in existence, and overriding the only statement in existence — with nothing behind it but an
authoring instruction — is precisely what `PRD-006` §0.4 forbids:

> *"A gap resolved by implementation choice is not resolved — it is an undocumented architecture decision made
> by whoever happened to write the code first."*

### 2.4 Conclusion on sources

| Claim | Supported? |
|---|---|
| A Rank 1–5 document places Face in **V1** | ❌ **No such document exists** |
| A Rank 1–5 document places Face in **V3** | ❌ **No such document exists** |
| A Rank 6 document places Face in V3 | ✅ Yes — EA v2.1 L754, descriptive only |
| Rank 1 places the **Attendance module** in V1 | ✅ Yes — but it classifies modules, not modes |

**Neither classification is ratifiable from current sources.** This is why the gap cannot self-close, and why
the decision must be *made and recorded*, not *discovered*.

---

## 3. What changes for `ATT-CFG-014` if Face is V3

`ATT-CFG-014` (Face match confidence threshold) is one of the seven settings in the `LIB-16.2` breach that
blocks `PRD-006`'s freeze. Its treatment depends entirely on this decision.

| Aspect | If Face is **V1** | If Face is **V3** |
|---|---|---|
| `LIB-16.2` obligation | **Live.** A documented default is required for the V1 baseline | **Deferred to V3.** The setting is not part of the V1 configuration surface |
| Contribution to the breach | 1 of 7 | **0 of 7 — the breach shrinks to six settings** |
| Who must approve a value | Product Owner + Security Platform + Legal (via `ATT-GAP-014`) | The same, **at V3**, when an engine exists and can be measured |
| Decidability today | 🔴 Blocked by `ATT-GAP-012` + `ATT-GAP-014` | **Not applicable** — nothing to decide in V1 |
| `ATT-FR-064` build block | Remains, and is the correct outcome | Remains; becomes consistent with the version class rather than an exception inside it |

**The other four Face configurables behave differently and must not be conflated:**

| ID | Setting | Default | Effect of a V3 ruling |
|---|---|---|---|
| `ATT-CFG-013` | Face enrollment required before use | **Enabled** | Has a default — **not part of the breach** either way |
| `ATT-CFG-014` | Face match confidence threshold | **`ATT-GAP-017`** | 🔴 **The only Face setting in the breach.** Leaves V1 scope |
| `ATT-CFG-015` | Face liveness required | **Enabled** | Has a default — unaffected |
| `ATT-CFG-016` | Face mode enabled | **Disabled** | Has a default — unaffected |

> **What a V3 ruling does *not* do.** It does not delete `ATT-CFG-014`, does not remove §12 from `PRD-006`,
> and does not weaken `ATT-FR-064`. The mode stays specified. Only its **release class** changes, and with it
> the question of whether its missing default is a V1 defect.

### 3.1 The freeze arithmetic — stated carefully

| Scenario | Settings still breaching `LIB-16.2` | Is `PRD-006` freezable? |
|---|---|---|
| Today | **7** — `005`, `006`, `011`, `012`, `014`, `019`, `023` | ❌ No |
| Face ruled V3 | **6** — `014` removed | ❌ **Still no** |
| Face V3 **and** `023`, `011`, `012` decided | **3** — `005`, `006`, `019` | ❌ **Still no** |
| All remaining settings documented | **0** | Then, and only then, is the blocker cleared |

**A V3 ruling does not unblock the freeze.** It removes the *hardest and highest-consequence* of the seven —
the one requiring Legal counsel, a biometric template owner and an unselected engine — converting an
undecidable row into a non-row. That is a material improvement in the **critical path**, not a resolution of
the breach. Any claim that ruling V3 makes `PRD-006` freezable would be false.

---

## 4. Which gaps and dependencies become irrelevant to V1 if Face is V3

`PRD-006` §32 currently carries **18 open gaps**. A V3 ruling would move the following **out of the V1
critical path** — they remain open questions owed at V3, and none is closed by this pack.

| Gap | Question | Owner | Status if Face → V3 |
|---|---|---|---|
| `ATT-GAP-012` | Who **owns and stores** the biometric template? | Architecture Owner + Security Platform | ➡️ **Out of V1.** Deferred to V3 |
| `ATT-GAP-014` | Biometric **retention and erasure**, including minors | **Legal counsel** + Security Platform | ➡️ **Out of V1.** Deferred to V3 |
| `ATT-GAP-013` | *(face-scoped, §12)* | Per register | ➡️ Out of V1 |
| `ATT-GAP-009` | Who owns the **face-scanner device lifecycle**? | Per register | ➡️ **Substantially relieved** — see below |
| `ATT-GAP-017` | The seven defaults | Product Owner | ⚠️ **Narrowed to six.** Remains open |

### 4.1 `ATT-GAP-009` deserves separate attention — a V3 ruling dissolves a structural contradiction

`PRD-006` L841 records:

> *"`BC-18` owns `Device` (BC Map L380) but in the **authentication** sense — credentials and sessions. `BC-08`
> Inventory owns 'books, furniture, **devices**, consumables' (L103) but is **V2**, so it cannot own a **V1**
> face scanner's lifecycle. **A V1 gap between two contexts, neither of which can take it.**"*

This impasse **exists only because the scanner is assumed V1**. `BC-08` is V2 and cannot own a V1 device — but
it can own a **V3** one. **A V3 ruling would make the natural owner available and remove the structural
contradiction.** This is a consequence the deciders should weigh, not a resolution: `ATT-GAP-009` also covers
*"any future attendance hardware"* (L1281) and would remain open on that broader question.

### 4.2 What a V3 ruling does **not** relieve

Stated so the pack is not read as claiming more than it shows:

| Not relieved | Why |
|---|---|
| `ATT-GAP-006` — cryptographic construction | Dynamic QR, unrelated to Face |
| `ATT-GAP-008` — GPS centre ownership | GPS, unrelated |
| `ATT-GAP-010`, `ATT-GAP-011` — `FileRef` and OCR ownership | OCR/Vision. **Independently build-blocked by `ATT-FR-080`** |
| `ATT-CFG-019` — OCR threshold | Unaffected. Still 🔴 blocked |
| `ATT-CFG-005`, `006`, `011`, `012`, `023` | Unaffected. Still required for V1 |
| The `LIB-16.2` breach itself | Reduced from seven settings to six. **Still a live breach** |
| `ATT-FR-064` | The build block stands either way |

**Net effect of a V3 ruling: 3 gaps leave the V1 path, 1 is substantially relieved, 1 narrows. 14 remain.**

---

## 5. Which owners must approve the decision

`PRD-006` §32 names the owners as **"Product owner + architecture owner"**. Under
`PRD_OWNERSHIP_MODEL.md` §2.2 (**four** roles — Product, Domain, Architecture, Technical):

| Owner | Why their approval is required | What they are deciding |
|---|---|---|
| **Product Owner** | §2.2: *"Accountable for business intent: scope, priority… Decides whether a requirement is correct and **in scope**."* Release class **is** scope | Whether face attendance is in the V1 product |
| **Architecture Owner** *(ARB)* | §2.2: *"Decides ADR approval; **any Rank 1–5 document change**."* Ratifying a class requires a Rank 2 ADR, and correcting Rank 6 EA is an architecture act | Whether the decision is recorded correctly and what follows in the document set |

**Consulted, not approving:**

| Party | Role |
|---|---|
| **Security Platform** *(Domain Owner, `PRD-012a`)* | Must be heard **if V1 is chosen** — `ATT-GAP-012` becomes a live V1 obligation |
| **Legal counsel** | Must be heard **if V1 is chosen** — `ATT-GAP-014` becomes a live V1 obligation, and `PRD-006` L840 establishes that platform erasure (`ID-5`, `MP-GBR-04`) is *"**structurally inapplicable**"* to a biometric template |
| **Technical Owner** | Informed — `IMPL-630`…`639` and `IMPL-679` carry the affected tasks |

> **`PRD_OWNERSHIP_MODEL.md` warns against a single signature.** *"**The Product Owner is not the default
> answer.** `ADR-0011`'s header records 'Deciders: Product owner (authoritative ruling); Principal Enterprise
> Architect; DDD reviewer' — three roles for one decision."* That pattern fits this question exactly.

### 5.1 Note on the recording instrument

`ADR-0021` §3 explicitly declines to decide `ATT-GAP-015`, listing it among *"`ATT-GAP-001`…`016`, `018` — each
has its own named owner."* **`ADR-0021` is therefore not the vehicle for this decision.**

The precedent for recording a capability/version ruling is `ADR-0013` — *"A capability context is owned by its
platform, not by the domain that consumes it"* — decided by *"Architecture Review Board, acting through the
Architecture Owner role defined in `PRD_OWNERSHIP_MODEL.md` §2.2."* A **separate ADR** is the appropriate
instrument. Whether to raise one is the Architecture Owner's call; this pack does not raise it, and drafts no
ADR.

---

## 6. The exact approval statement

**Both owners must sign the same option. Choose exactly one.**
Neither template below is filled in, endorsed or recommended here.

### Option A — Face is **V1**

> **`ATT-GAP-015` — RULING.**
> Face attendance (`ATTENDANCE_MODE_FACE`, `PRD-006` §12) is classified **V1**.
> Enterprise Architecture v2.1 L754 `Face Recognition (V3)` is **incorrect** and MUST be corrected to `(V1)`
> under `DOCUMENTATION_BASELINE.md` §4 — *"Update it to match 1–5; never the reverse."*
> We accept that this makes `ATT-GAP-012` (template ownership and storage) and `ATT-GAP-014` (biometric
> retention and erasure, including minors) **live V1 obligations**, that `ATT-CFG-014` remains within the
> `LIB-16.2` breach, and that `ATT-FR-064` continues to block implementation until both gaps are answered by
> their named owners.
> We confirm Security Platform and Legal counsel have been consulted on that exposure.
> `ATT-GAP-015` is **CLOSED — resolved V1**.
>
> Product Owner: ______________________  Date: __________
> Architecture Owner (ARB): ______________________  Date: __________

### Option B — Face is **V3**

> **`ATT-GAP-015` — RULING.**
> Face attendance (`ATTENDANCE_MODE_FACE`, `PRD-006` §12) is classified **V3**, consistent with Enterprise
> Architecture v2.1 L754. The EA requires no correction.
> §12 remains **specified but out of V1 scope**. `ATT-FR-064`'s build block stands.
> `ATT-CFG-014` leaves the V1 configuration surface; the `LIB-16.2` breach reduces from **seven settings to
> six**. We confirm this does **not** clear the breach and does **not** make `PRD-006` freezable.
> `ATT-GAP-012`, `ATT-GAP-013` and `ATT-GAP-014` are **deferred to V3** — deferred, not closed — and
> `ATT-GAP-009` is relieved for the V1 path insofar as it concerns the face scanner.
> `ATT-GAP-015` is **CLOSED — resolved V3**.
>
> Product Owner: ______________________  Date: __________
> Architecture Owner (ARB): ______________________  Date: __________

### Option C — Defer

> **`ATT-GAP-015` — DEFERRED.**
> No classification is made at this time. `ATT-GAP-015` remains **OPEN** with reason: ______________________
> and review date: __________.
> We accept that `ATT-CFG-014` remains undecidable, that the `LIB-16.2` breach remains at **seven** settings,
> and that `PRD-006` remains **unfreezable** for as long as this is deferred.
>
> Product Owner: ______________________  Date: __________
> Architecture Owner (ARB): ______________________  Date: __________

### 6.1 What must follow the signature — for the owners' awareness, not for this pack to do

| Step | Action | Whose |
|---|---|---|
| 1 | Raise an ADR recording the ruling (`ADR-0013` pattern) | Architecture Owner |
| 2 | Update `PRD-006` §12.5 and the §32 register from OPEN to the ruling | `PRD-006` owner |
| 3 | **If A:** correct EA v2.1 L754 to `(V1)`. **If B:** no EA change | Architecture Owner |
| 4 | **If A:** escalate `ATT-GAP-012`/`014` as V1 blockers. **If B:** re-mark them V3-deferred | Named gap owners |
| 5 | Update `ATT-GAP-017` scope — seven settings or six | `PRD-006` owner |
| 6 | Re-run `prd006_traceability.py` and `prd006_task_coverage.py`; review `IMPL-630`…`639` | Technical Owner |

**None of the six steps is performed by this pack.**

---

## 7. What this pack deliberately did not do

| Not done | Why |
|---|---|
| Choose V1 or V3 | Instructed not to. The owners are named in §5 and neither is me |
| Recommend an option | §3 and §4 quantify the consequences of each; the weighing is a scope judgement, not an analysis result |
| Invent biometric architecture | No template store, engine, format, threshold, liveness method or retention rule is proposed anywhere |
| Propose a value for `ATT-CFG-014` | `ATT-BR-043` forbids substitution. **Zero values appear in this document** |
| Close `ATT-GAP-015` | It remains 🔴 **OPEN**. §6 supplies statements for others to sign |
| Close `ATT-GAP-009`, `012`, `013`, `014` | §4 describes what a ruling would *do to* them. Each has its own owner |
| Modify `PRD-006`, `ADR-0021`, Registry, Baseline or any frozen document | Instructed not to; verified in §8 |
| Raise or draft the follow-on ADR | The Architecture Owner's call (§5.1) |
| Freeze anything | No baseline row is created |
| Claim a V3 ruling unblocks the freeze | It does not — §3.1 states the arithmetic explicitly |

---

## 8. Verification

| Claim | Method | Result |
|---|---|---|
| EA v2.1 lists `Face Recognition (V3)` | `LIBOORA_ENTERPRISE_ARCHITECTURE.md` L754 | Confirmed, inside the Attendance Management tree |
| EA is Rank 6, descriptive | `DOCUMENTATION_BASELINE.md` L215, L139 | *"Descriptive only. Update it to match 1–5; never the reverse"* |
| No Rank 1–5 source places Face in V1 or V3 | `grep -riE 'biometric\|face recognition\|facial' docs/` outside the module | **3 hits — 1 is the Rank 6 EA, 2 are Rank 3 *exclusions*** |
| Rank 1 classifies the module, not the mode | `MASTER_PRD.md` L160; mode-term search | Module **V1**; **0** attendance modes enumerated |
| `PRD-006` overrode EA V2 tags elsewhere | EA tree vs `PRD-006` §18, `ATT-BR-015` | **5 capabilities**, each with a Rank 1–5 or V1-necessity basis |
| Corrections are mandated at Rank 1 | `MP-GBR-11` | Confirmed — which is why no gap was raised there |
| `ATT-CFG-014` is the only Face setting in the breach | §16.3 L1167–1170 | `013`, `015`, `016` have defaults; only `014` cites `ATT-GAP-017` |
| `ATT-GAP-009`'s impasse depends on the V1 assumption | `PRD-006` L841 | *"`BC-08` … is **V2**, so it cannot own a **V1** face scanner's lifecycle"* |
| Erasure is structurally inapplicable to biometrics | `PRD-006` L840 | *"A biometric template cannot be pseudonymised — it **is** the identifier"* |
| Owners are Product + Architecture | `PRD-006` §32 L2175; `PRD_OWNERSHIP_MODEL.md` §2.2 | Confirmed; four roles, no "Security Owner" |
| `ADR-0021` declines this gap | `ADR-0021` §3 | Lists `ATT-GAP-001`…`016` as not decided |
| `ATT-GAP-015` still OPEN | `PRD-006` L2209 | 🔴 **OPEN — correctly framed, cannot self-close** |
| Subject unmodified | SHA-256 | `93ab1c60d740c4e0…` — byte-identical |
| Registry / Baseline unmodified | SHA-256 | `f8e71ce876c2b53b` · `42405be29d392e14` |
| Zero values proposed | Full-document scan | **0** thresholds, durations or distances |

---

## 9. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-04 | Created as decision support for the two owners named in `PRD-006` §32. **Chooses nothing.** Establishes by negative search that **no Rank 1–5 document places Face in either V1 or V3** — the only two Rank 3 documents mentioning biometrics (`Authentication_PRD_v2.md` L968, `Student_Identity_PRD_v1.md` `SXC-4`) are **exclusion rows** that push biometrics away rather than assign them, and Rank 1 `MASTER_PRD.md` classifies the *module* as V1 while enumerating **no** attendance mode. Records that `PRD-006` has already overridden EA version tags **five times** (Corrections, Clock Skew, Late Entry, Early Exit, Policies/Reports) but that each override had a Rank 1–5 basis — `MP-GBR-11` for Corrections — whereas **Face has none**, which is why it alone was raised as a gap. Quantifies the effect of a V3 ruling: `ATT-CFG-014` leaves the V1 surface and the `LIB-16.2` breach falls from **seven settings to six**, three gaps (`012`, `013`, `014`) leave the V1 path and `ATT-GAP-009`'s impasse is **structurally dissolved** because `BC-08` Inventory is V2 and could own a V3 scanner though not a V1 one. States explicitly in §3.1 that **a V3 ruling does not make `PRD-006` freezable** — six settings still breach. Supplies three signature-ready statements (V1, V3, Defer) and a six-step post-signature sequence, **none of which is executed here**. `ATT-GAP-015` remains 🔴 **OPEN**, `ADR-0021` remains **Proposed**, `PRD-006` is byte-identical, and `PRD_REGISTRY.md` and `DOCUMENTATION_BASELINE.md` are unmodified. |
