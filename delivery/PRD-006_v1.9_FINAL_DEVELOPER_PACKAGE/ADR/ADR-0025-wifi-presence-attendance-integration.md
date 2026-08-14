# ADR-0025 — Wi-Fi-triggered attendance needs either a seventh mode or an honest trigger model, and this ADR does not pick

| Field | Value |
|---|---|
| **Status** | **Proposed** — not binding. *(`ADR-INDEX.md` status vocabulary: "Under consideration; not binding")* |
| **Date** | 2026-08-05 |
| **Deciders** | **Architecture owner (ARB)** — the mode set is a platform-wide rule and an invariant; **Product owner** consulted on the student-visible meaning of an auto-created record |
| **Supersedes** | Nothing |
| **Amends** | **Nothing.** While `Proposed` this ADR amends no document. `PRD-006` is byte-identical |
| **Baseline** | **None issued.** Baseline remains **`BASELINE-2026-08-04-E`** |
| **Closes** | **Nothing** |
| **Related** | `ATT-FR-007` (L481) · `ATT-XC-010` · `ATT-INV-007` · `ATT-BR-007` (L518) · `ATT-XC-011` (L500) · `ATT-XC-014` (L679) · `ATT-FR-134` (L1480) · `ATT-FR-090`…`095` · BC Map §9 (L402-417) · `ADR-0024` · [`PRD-006_ADDITIVE_WIFI_PRESENCE_IMPACT_REPORT.md`](../../30-product/attendance-management/PRD-006_ADDITIVE_WIFI_PRESENCE_IMPACT_REPORT.md) §4, §16 |

> ⚠️ **`Proposed`. This ADR presents two lawful routes and declines to choose between them.**
>
> The Product Owner's instruction is explicit: *"Prefer the design that preserves the existing six-mode invariant …
> **IF AND ONLY IF it is semantically valid** under the repository's architecture. **Do not choose merely to bypass a
> prohibition.** Architecture Owner must make the final decision."*
>
> §4 of this ADR reports, honestly, that the mode-preserving route is **not free** and carries a specific semantic
> problem. That finding is the substance of this ADR.

---

## 0. Product Owner decision recorded — §4.1's finding was accepted, and this ADR is still `Proposed`

> **This section records a Product Owner answer. It does not change this ADR's status.** The mode set is a
> platform-wide rule carrying an invariant (`ATT-INV-007`); amending it is an **Architecture Owner (ARB)** decision.
> Governance step 8 is explicit: *"do NOT mark an ADR Accepted merely because the Product Owner approved a product
> decision."* This ADR remains **`Proposed`**.

| PO decision | Question asked | Answer as given |
|---|---|---|
| **`D-10`** | D1 — may a Wi-Fi connection automatically create attendance, and how is it typed? | **A** — *"Library Wi-Fi connection may automatically create attendance. This is an additive 7th attendance type. **Do NOT fake it as FIXED_QR_WIFI.** Amend the required attendance-mode rules through the proper ADR/governance process."* |

**`D-10` agrees with §4.1's central finding. Whether it was reached by reading it is not claimed here, because that
cannot be verified from the answer.** What is observable is that the two coincide. This ADR reported that reusing
`ATTENDANCE_MODE_FIXED_QR_WIFI` for a scan-less event *"records a false provenance"* and *"would be"* the bypass the
Product Owner's own guard forbids. `D-10` prohibits that reuse **in the Product Owner's own words**. The finding was
therefore not overruled, and §4.1 stands unamended and is not softened.

**What `D-10` settles — three things, all of them product-side.**

1. **Automatic attendance from verified Wi-Fi presence is approved product scope.** The question of *whether* the
   capability is wanted is closed.
2. **Option §4.1 is eliminated.** Reuse of `FIXED_QR_WIFI` is prohibited by the Product Owner as well as advised
   against by this ADR. `PRD-006` §7.1a records the prohibition and `ATT-BR-007` is preserved **verbatim** — mode 3
   is not reinterpreted to perform the new behaviour.
3. **The route is Option A in shape** — an *additive seventh type*, amended *"through the proper ADR/governance
   process"* — which is a direction to use this process, **not a substitute for its outcome**.

**What `D-10` does not settle, and must not be read as settling.** A Product Owner may say *"there shall be a seventh
type"*; only the ARB may **define** one. Specifically, `D-10` does **not**:

- **name the mode constant.** §4.3 L47's `ATTENDANCE_MODE_WIFI_PRESENCE` remains *"name illustrative, not proposed"*, and `PRD-006` §7.1a states *"No mode constant is named here, and none is reserved."*
- **amend `ATT-FR-007`'s closed enumeration, `ATT-XC-010` or `ATT-INV-007`.** `PRD-006` records that a seventh is *authorised in product scope and not yet definable*; the enumeration itself is unchanged.
- **authorise the `TRACEABILITY_MATRIX.md` §2F amendment** that §7 records as necessary. That matrix is **Rank 4**.
- **create the register entries a seventh mode needs.** Measurement establishes that **no new identifier may be added to any of the ten registers** while §2F fixes their counts: a seventh configurable would need an `ATT-CFG` number beyond 24, and a criterion for it an `ATT-AC` number beyond 213. `PRD-006` §7.1a carries this as a three-row outstanding table, and the constraint was proven by injecting a temporary row and observing the §2F failure — it is measured, not assumed.

**Consequence for §5 and §6.** Option B §4.1 is now closed by product decision; Option B §4.2 (presence as a
*trigger* producing no new mode) remains architecturally available and is **not** eliminated by `D-10`, because a
Product Owner's *"7th attendance type"* expresses the intended semantics rather than a storage design. **The ARB may
still find that §4.2 satisfies `D-10`'s intent honestly.** This ADR does not decide that, and does not pretend
`D-10` decided it.

---

## 1. Context

Option B requires that establishing a valid Wi-Fi Presence Session **automatically records attendance**.

`PRD-006` §7.1 `ATT-FR-007` (L481) closes the mode set:

> V1 **MUST** support **exactly these six** attendance modes, **and no others**.

The six are `ATTENDANCE_MODE_FIXED_QR`, `_DYNAMIC_QR`, `_FIXED_QR_WIFI`, `_FIXED_QR_GPS`, `_FACE`, `_MANUAL`.

It is closed a further two times: `ATT-XC-010` — *"**MUST NOT** define a seventh mode … **MUST NOT** appear as a V1
mode, requirement, configurable, event or acceptance criterion"* — and `ATT-INV-007`, which requires every punch to
record *"exactly one `AttendanceMethod` from the six V1 modes."* §29's preamble adds that each exclusion states what
is *"**impossible**, not merely discouraged."*

## 2. The question

**How is attendance produced from a Presence Session without either violating `ATT-FR-007` or misrepresenting how
the record was created?**

## 3. Option A — Extend the mode model to seven

Add `ATTENDANCE_MODE_WIFI_PRESENCE` (name illustrative, not proposed) as a seventh mode.

- **For:** semantically honest. The record says exactly how it was made. `ATT-INV-007` continues to hold with seven members instead of six. `AttendanceMethod` remains a faithful audit field. Student and Owner dashboards can display the true provenance, which request §18 asks for.
- **Against:** requires amending `ATT-FR-007`, `ATT-XC-010` and `ATT-INV-007` in `PRD-006` — three rules, one of which is an **exclusion** and one an **invariant**. Amending an exclusion is the heaviest kind of PRD change.
- **Also against:** `ATT-XC-010`'s wording *"MUST NOT appear as a V1 … acceptance criterion"* means the acceptance-criteria register must change too, which reaches `TRACEABILITY_MATRIX.md` §2F (**Rank 4**, `ATT-AC-*` currently **213**).
- **Cost:** `PRD-006` (3 rules + ACs) · `TRACEABILITY_MATRIX.md` (**Rank 4**) · possibly BC Map §9 if a new event is needed.

## 4. Option B — Presence as a *trigger* that produces an existing mode

The Presence Session is an attendance **trigger**; the resulting record carries one of the existing six modes. The
mode set is untouched.

**This is the option the Product Owner asked to be preferred. It must not be recommended without disclosing the
following, which is the central finding of this ADR.**

### 4.1 The semantic problem

There is no existing mode that truthfully describes an attendance created with **no QR scan**.

- `ATTENDANCE_MODE_FIXED_QR_WIFI` is the closest candidate by name. But `ATT-BR-007` (**L518**) states: *"A Wi-Fi condition **MUST** apply **only** to `ATTENDANCE_MODE_FIXED_QR_WIFI`."* That mode is defined as **a Fixed QR scan plus a Wi-Fi condition** — the Wi-Fi is the *second* factor, not the first. Recording a scan-less, Wi-Fi-only event as `FIXED_QR_WIFI` would assert a QR scan that never happened.
- `ATTENDANCE_MODE_MANUAL` is definitionally a staff action and is bound to the Manual workflow (§13, `ATT-BR-038`). An automatic record is not manual.
- `_FIXED_QR`, `_DYNAMIC_QR`, `_FIXED_QR_GPS`, `_FACE` are each inapplicable on their face.

**Therefore Option B, implemented naively, records a false provenance.** That is not a technicality: `ATT-INV-007`
makes `AttendanceMethod` an *invariant-bearing* field, and the audit trail (`ATT-FR-129`…`133`) depends on it being
true. A false method value corrupts the audit record, which is a worse outcome than an honest seventh mode.

The Product Owner's own guard applies precisely here: *"Do not choose merely to bypass a prohibition."* Reusing
`FIXED_QR_WIFI` for a scan-less event **would be** such a bypass.

### 4.2 The variant that may survive

Option B is only semantically valid if the **trigger produces a genuine instance of an existing mode** — that is, if
the Wi-Fi Presence Session **prompts the student to complete an existing flow** rather than replacing it. For example,
presence detection surfaces a check-in the student confirms, and the resulting record is honestly whatever mode that
flow used.

- **For:** the mode set, `ATT-BR-007` and `ATT-INV-007` are all untouched. Nothing is bypassed.
- **Against:** this is **weaker than the Product Owner asked for.** §3 of the instruction says presence establishment should *"automatically create/record"* attendance. A confirmation step is not fully automatic. Whether that reduction is acceptable is a **product** decision, not an architecture one.

### 4.3 A further constraint on both variants

`ATT-XC-011` (L500) forbids *"a verification pipeline … or any construct in which one attendance requires a sequence
of methods."* A design that chains *Wi-Fi verify → then QR → then GPS* would breach it. Any trigger model must
therefore keep the produced attendance a **single-method** event.

## 5. Decision

**None. Deferred to the Architecture owner (ARB), with a product input from the Product owner.**

Two questions must be answered together, because the answer to the second changes the viability of the first:

- **ARB:** is a seventh `AttendanceMethod` acceptable (Option A), or must the six-mode invariant hold (Option B)?
- **Product owner:** if the six-mode invariant holds, is the **confirmation-step** variant (§4.2) acceptable, given it is not fully automatic?

If the Product Owner requires *fully* automatic attendance **and** the ARB requires the six-mode invariant, then
**there is no lawful design**, and one of the two constraints must be relaxed by its own owner. Recording that
possibility is the honest output of this analysis.

## 6. What does *not* need to change either way

Measured, so the decision is not made to look more expensive than it is:

| Fact | Consequence |
|---|---|
| `attendance.StudentCheckedIn` already exists (`ATT-FR-134`, BC Map §9 L414) | **No new attendance event is required.** Auto-created attendance publishes the existing event |
| `ATT-FR-090`…`ATT-FR-095` already specify idempotency keys, replay tolerance and duplicate suppression | Request §3's *"DO NOT create a duplicate attendance record"* is **already satisfied** by existing rules |
| `ATT-XC-014` (L679) already states Wi-Fi is not proof a specific person was present | Request §8's honesty requirement is **already met**; no anti-cheating rule weakens |
| `ATT-BR-007` binds Wi-Fi to `FIXED_QR_WIFI` only | Existing QR + Wi-Fi attendance is **unchanged** by either option |

## 7. Consequences

- **Option A accepted:** `PRD-006` amends `ATT-FR-007`, `ATT-XC-010`, `ATT-INV-007`; `TRACEABILITY_MATRIX.md` §2F (**Rank 4**) amends the AC count. Provenance stays truthful.
- **Option B §4.2 accepted:** no mode change, no Rank 4 change on this axis; attendance is not fully automatic; the Product Owner's §3 is partially met.
- **Option B §4.1 (reuse `FIXED_QR_WIFI`) accepted:** **this ADR advises against it on record.** It records a QR scan that did not occur, corrupting `AttendanceMethod` and the audit trail, and constitutes bypassing `ATT-FR-007` rather than amending it.
- **Left `Proposed`:** automatic attendance cannot be specified. Existing QR, QR+Wi-Fi, GPS and Manual attendance are **entirely unaffected**.

## 8. What this ADR explicitly does not do

- It does **not** add, name or reserve a seventh mode.
- It does **not** amend `ATT-FR-007`, `ATT-XC-010`, `ATT-INV-007` or `ATT-BR-007`.
- It does **not** select Option A or Option B.
- It does **not** claim the mode-preserving route is free — §4.1 records that it is not.
- It does **not** assert approval by any person or body.
- It does **not** treat `D-10` as an ARB approval of a seventh mode. §0 records what the Product Owner may and may not settle.
- It does **not** soften or withdraw §4.1 now that the Product Owner has agreed with it — the finding is left exactly as originally written.
- It does **not** eliminate Option B §4.2 on the strength of `D-10`, and does not claim that only Option A can satisfy it.
- It does **not** become `Accepted` by virtue of §0. Its status is unchanged: **`Proposed`**.
