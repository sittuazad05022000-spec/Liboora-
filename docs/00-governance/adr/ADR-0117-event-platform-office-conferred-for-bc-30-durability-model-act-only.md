# ADR-0117 — The **EVENT platform** office is constituted and conferred **for one act only**: to decide the `BC-30` Offline Sync durable-queue durability model

| Field | Value |
|---|---|
| **ADR** | `ADR-0117` |
| **Status** | **Accepted** — 2026-09-08 |
| **Date** | 2026-09-08 |
| **Deciders** | ⭐⭐ **The human principal of this engagement**, by **direct, explicit conferral**, constituting and authorizing the **`EVENT platform`** office **for the `BC-30` Offline Sync durable-queue durability-model act only** — on the `ADR-0077` / `ADR-0080` / `ADR-0102` precedent for constituting an office that **Rank 1 already names but this repository defines nowhere**. ⛔ **No ARB quorum, attendee list, sign-off date or Security review is asserted. No holder is appointed and no personal name is recorded** (`PRD_OWNERSHIP_MODEL.md` §7 rule 4) |
| **Subject** | Constitution and one-act conferral of the `EVENT platform` office |
| **Supersedes** | — |
| **Amends** | `docs/00-governance/prd-ecosystem/PRD_OWNERSHIP_MODEL.md` → **v1.5**. ⚠ **EXECUTED BY APPEND, NOT BY INSERTION — see §5.** The office is constituted in a new **§14**; every pre-existing line is **byte-identical**, because that document is cited by line number from `Accepted` ADRs and from `DOCUMENTATION_BASELINE.md` |
| **Amended by** | — |
| **Baseline** | ⛔ **No baseline re-issue.** `BASELINE-2026-09-03-A` stands. `DOCUMENTATION_BASELINE.md` §7 rule 4 moves the identifier only when a **Rank 1–3** document changes version; `PRD_OWNERSHIP_MODEL.md` is **Unranked** by its own `Precedence` row (*"Governance process, not a requirement source"*) and `ADR-INDEX.md` is a governance artefact. `ADR-0102`, `ADR-0077` and `ADR-0080` each set this precedent |
| **Closes** | ⭐ **The office-existence limb of Item 3 only** — the `EVENT platform` office is now **constituted** and **authorized for one act**. This discharges required act **1** of `IMPLEMENTATION_BLOCKER_REGISTER.md` §13.5 |
| **Does NOT close** | ⛔⛔ **Item 3 itself.** The durability model is **NOT decided in this ADR** — see §4. ⛔ **Item 7b** (a different office, `ADR-0118`). ⛔ Items 9b, 5, 7a and 8b-residual. ⛔ No implementation authority |
| **Related** | `MASTER_PRD.md` **L496** (`MP-NFR-02`, Rank 1 — owner `EVENT platform`) · **L537** (`MP-ASM-03`) · `PRD_OWNERSHIP_MODEL.md` **§13** (the one-act method), **§7 rule 4**, **§3 rule 1**, **§2.3** (role vocabulary is reused, not invented) · `ADR-0102` (the office-constituting precedent) · `ADR-0077`, `ADR-0080` · `ADR-0033` §7.1 · `ADR-0115`, `ADR-0116` · `ATT-INV-003`, `ATT-PO-011` |
| **Implementation authorised** | ⛔ **No** |

> ⚠⚠ **READ THIS FIRST.** This ADR **constitutes an office**. It does **NOT** decide the durability
> model, and it authorises **no** implementation. Constituting an office and exercising it are two
> different acts — `ADR-0102` §3 made exactly this distinction, and it is preserved here.

---

## 1. Context

### 1.1 The blocker, as it stood

`IMPLEMENTATION_BLOCKER_REGISTER.md` §13.2 measured that **Item 3 — Durable Queue** could not be decided,
and that the reason was **not** missing information:

- The **obligation** already exists at **Rank 1**. `MASTER_PRD.md` **L496**, `MP-NFR-02`:
  *"Reliability | At-least-once event delivery with idempotent consumers; DLQ depth is an SLO-monitored
  signal, not a silent bin. | **EVENT platform**"*. `MP-ASM-03` (**L537**) records that
  *"offline attendance capture is required."*
- The **idempotency half is already specified** — `ATT-INV-003`: a punch **MUST** be idempotent by
  `(studentRecordId, date, idempotencyKey)`.
- ⚠ But the office Rank 1 makes accountable — **`EVENT platform`** — was **constituted nowhere**.
  Measured before this ADR: **0** role-table rows and **0** §13-style constitutions naming it in
  `PRD_OWNERSHIP_MODEL.md`.

### 1.2 Why that was a genuine stop, not a formality

`PRD_OWNERSHIP_MODEL.md` §13.1 records the identical situation for `SRE / Observability`: three Rank-1
obligations named the office, yet a measurement returned **0** occurrences in the ownership model, so the
office was *"**defined nowhere**."* It took `ADR-0102` and a direct human-principal conferral before it
could act **even once**.

⭐ **The same reasoning applies here, and the audit refused to shortcut it.** An office named by a Rank-1
NFR is *nominated*, not *constituted*; and `ADR-0033` §7.1 — *"A conferral for one act is not a standing
licence"* — means no prior conferral in this engagement could be stretched to cover it.

---

## 2. The conferral

The human principal directed, in these words:

> *"I explicitly constitute and confer the office **'EVENT platform'** for **ONE ACT ONLY**: To decide and
> record the BC-30 Offline Sync durable-queue durability model required for Item 3. This is ONE ACT ONLY
> and NOT a standing licence. The act authorizes only the durability-model decision."*

⛔ **One holder**, per `PRD_OWNERSHIP_MODEL.md` §3 rule 1. ⛔ **Outside this act the office is VACANT.**
⛔ **No personal name is recorded** (§7 rule 4).

⭐ **The role vocabulary is reused, not invented** — §2.3's rule is satisfied at **Rank 1**:
`MASTER_PRD.md` **L496** assigns `MP-NFR-02` *Reliability* to **`EVENT platform`** verbatim, and **L498**
(`MP-NFR-04`) names `DATA / EVENT`. This ADR adopts the existing name and does not coin one.

---

## 3. Scope of the authority — stated exactly

| | |
|---|---|
| **Office** | **`EVENT platform`** |
| **Constituted** | 2026-09-08, by direct human-principal conferral |
| **Authorized for** | **ONE ACT:** to decide and record the **`BC-30` Offline Sync durable-queue durability model** required for **Item 3** |
| **Standing authority** | ⛔ **NONE.** `ADR-0033` §7.1 |

| Role | Decides | ⛔ Does NOT decide |
|---|---|---|
| **`EVENT platform`** | For this act only: the `BC-30` Offline Sync **durable-queue durability model** — the durability guarantee the queue must provide, expressed against `MP-NFR-02`'s at-least-once + idempotent-consumer obligation | ⛔ **Application implementation** · ⛔ **queue implementation** · ⛔ **database/schema creation** · ⛔ **provider configuration** · ⛔ **retry count** · ⛔ **retry/backoff** (Item 5) · ⛔ **queue-depth limit** (Item 7b — `ADR-0118`) · ⛔ **retention** (7a) · ⛔ **encryption algorithm** (9b) · ⛔ **secret format** · ⛔ **cloud resources** · ⛔ changes to **`PRD-006`** · ⛔ creation of **`PRD-018`** · ⛔ boundaries, ranks or permitted edges (**Architecture Owner**) · ⛔ scope, priority or acceptance (**Product Owner**) · ⛔ document status or freeze (**Governance Owner**) · ⛔ **its own conferral** |

⛔ **The prohibition list above is the conferring instruction's own, transcribed rather than summarised.**

---

## 4. ⛔⛔ What this ADR deliberately does NOT do — and why that is the point

⛔ **THE DURABILITY MODEL IS NOT DECIDED HERE, AND IS NOT HINTED AT.** No durability guarantee,
mechanism, technology, storage medium, journal format, flush policy, acknowledgement scheme, ordering
guarantee or persistence tier is stated, preferred, ranked or implied anywhere in this ADR.

⭐ **This separation is the established discipline, not caution for its own sake.** `ADR-0102` constituted
the `SRE / Observability` office **and** exercised it in the same ADR, because its conferral expressly
covered both — *"shall ratify the already pre-approved target of 99.9% monthly availability."* ⚠ **This
conferral is different, and the difference is decisive:** it authorises the office *"To decide and record
the … durability model"*, and the instruction closes with:

> *"DO NOT decide: Item 3 durability model … Those are the subsequent acts of the newly constituted
> offices."*

⭐ So the conferral **creates the capacity** and **withholds the exercise**. There is also no pre-approved
value to carry across — unlike `ADR-0102`'s `99.9%`, which `ADR-0100` §3.2 had already fixed. Writing a
durability model here would be **inventing** one, which every governing rule in scope forbids.

⛔ **`ADR-0115` and `ADR-0116` are preserved** — neither is amended, superseded or restatused; both are
byte-unchanged. `ADR-0116`'s runtime selection (`Supabase`) is **not** treated as implying any durability
property: a runtime is not a durability guarantee, and `MP-CON-02`/`MP-CON-03` require the model to remain
expressible behind the abstract Data Layer so a dedicated backend can replace it.

⛔ **`ATT-PO-011` is preserved unweakened** — `BC-03` *"**MUST NOT** implement the queue, the replay or the
conflict detection itself"*; `BC-03` keeps the conflict-resolution policy. **This ADR moves no
responsibility between `BC-03` and `BC-30`**, and `E-24` is byte-unchanged.

---

## 5. Method: APPEND, and the measurement that forced it

`PRD_OWNERSHIP_MODEL.md` is cited **by line number** from `Accepted` ADRs and from
`DOCUMENTATION_BASELINE.md`. §13's preamble enumerated those citations — **L68, L69, L85 (×35), L102,
L107, L139, L144, L159, L197, L284, L331** — and recorded that *"inserting a row into §2.2's role table
would silently misdirect every citation beneath it."*

⭐ **The same instrument was re-run for this pass and the same conclusion holds.** The office is therefore
constituted in a **new §14 appended below the existing last line**, so **every pre-existing line is
byte-identical** and **0 citations shift**.

⚠ **The `Version` field at L6 still reads `v1.1` and is NOT edited.** It has been stale since v1.2 for
exactly this citation reason — a pre-existing condition disclosed by `ADR-0077` §8, carried forward by
`ADR-0080` and `ADR-0102`, and **not introduced by this pass**. ⛔ **Not repaired here**, on the same
routing (`ADR-0075` §8.5 Option B). The authoritative version advance to **v1.5** is recorded in this
ADR's `Amends` row and in §14's own change-history block, per `ADR-0102` §13.3's precedent.

---

## 6. What remains open — nothing is closed by implication

| Item | Status after this ADR | Why |
|---|---|---|
| **3 — Durable Queue** | ⛔ **OPEN — office now exists, decision does NOT** | The constituted office must still perform its one act |
| **7b — Queue depth** | 🔒 **BLOCKED behind Item 3** | Different office — `ADR-0118`. A bound is meaningless before the queue it bounds |
| **9b — At-rest** | 🔒 **BLOCKED behind Item 3** | **SECURITY PLATFORM**; and `ATT-GAP-006` is independently OPEN |
| **5 — Retry/Backoff** | ⛔ **OPEN — untouched** | `PRD-006` **L2332**: *"none may be invented"* |
| **7a — Retention** | ⛔ **OPEN — untouched** | `Q-04` open; `ATT-GAP-005` |
| **8b-residual** | ⚠ **REQUIRES OWNER DECISION — untouched** | Product Owner + `BC-03` Domain Owner |
| **`MASTER_PRD` L227** | ✅ **No amendment required** | Register §13.3, on the `ADR-0046`/L232 precedent |

⛔ **This ADR confers NO lifecycle stage**, creates **no** bounded context, edge, event, port or
requirement identifier, allocates **0** `IMPL-*`, mints **0** `SYNC-*`, and touches **0**
application-code files.

---

## 7. Changelog

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-08 | ⭐⭐ **Created and ACCEPTED. The `EVENT platform` office is CONSTITUTED and CONFERRED FOR ONE ACT ONLY** — to decide and record the `BC-30` Offline Sync durable-queue durability model (Item 3) — by direct human-principal conferral, on the `ADR-0077` / `ADR-0080` / `ADR-0102` precedent for an office **Rank 1 names but the repository defines nowhere**. Measured before the act: **0** role-table rows and **0** §13-style constitutions for `EVENT platform` in `PRD_OWNERSHIP_MODEL.md`. ⭐ Vocabulary **reused, not invented** — `MASTER_PRD` **L496** names `EVENT platform` verbatim at Rank 1 (§2.3 satisfied). ⛔⛔ **THE DURABILITY MODEL IS NOT DECIDED, HINTED AT OR IMPLIED** — no guarantee, mechanism, technology, medium, journal format, flush policy, acknowledgement scheme or ordering guarantee appears anywhere in this ADR; unlike `ADR-0102`, which had a pre-approved `99.9%` to carry across, **no pre-approved durability value exists**, so writing one would be invention. The conferral **creates the capacity and withholds the exercise**, exactly as instructed. ⛔ **Not a standing licence** (`ADR-0033` §7.1); outside this act the office is **VACANT**; **no holder appointed and no personal name recorded** (§7 rule 4); **one holder** (§3 rule 1). ⭐ **Amends `PRD_OWNERSHIP_MODEL.md` → v1.5 BY APPEND (new §14)** — citation instrument re-run, every pre-existing line **byte-identical**, **0** citations shifted; the L6 `Version` field's pre-existing staleness is **disclosed and not repaired**, as in `ADR-0077`/`ADR-0080`/`ADR-0102`. ⛔ **No baseline re-issue** — `PRD_OWNERSHIP_MODEL.md` is **Unranked** by its own `Precedence` row, so §7 rule 4's Rank 1–3 limb is unmet. ⛔ **`ADR-0115` and `ADR-0116` preserved byte-unchanged**; `ADR-0116`'s `Supabase` selection is **not** read as implying any durability property. ⛔ **`ATT-PO-011` preserved** — no responsibility moves between `BC-03` and `BC-30`; `E-24` byte-unchanged. ⛔ **Nothing else authorised:** no implementation, queue implementation, schema, provider configuration, retry count, backoff, queue depth, retention, encryption algorithm, secret format or cloud resource; **`PRD-006` byte-unchanged**; **`PRD-018` not created**; **0** `IMPL-*`, **0** `SYNC-*`, **0** application-code files. ⛔ **Item 3 remains OPEN** — the office now exists; the decision does not. |
