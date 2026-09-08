# ADR-0119 — The `BC-30` Offline Sync durability model is **RATIFIED from existing authority**, and its persistence limb is opened as `EVT-GAP-001`

| Field | Value |
|---|---|
| **ADR** | `ADR-0119` |
| **Status** | **Accepted** — 2026-09-08 |
| **Date** | 2026-09-08 |
| **Deciders** | **`EVENT platform`** — the office constituted by `Accepted` [`ADR-0117`](./ADR-0117-event-platform-office-conferred-for-bc-30-durability-model-act-only.md) and conferred **for one act only**: *"to decide and record the `BC-30` Offline Sync durable-queue durability model required for Item 3."* ⭐ **This ADR IS that act.** ⛔ **No spent conferral is reused** — `ADR-0117` §4 expressly **withheld the exercise**, so the act was outstanding, not consumed. ⛔ No holder appointed, no personal name recorded (`PRD_OWNERSHIP_MODEL.md` §7 rule 4). ⛔ The office is **VACANT** after this act (`ADR-0033` §7.1) |
| **Supersedes** | **Nothing** |
| **Amends** | **Nothing.** ⛔ No PRD, no BC Map, no Dependency Matrix, no manifest, no EA, no `MASTER_PRD.md`, no other ADR — the `ADR-0058` shape: a decision recorded **in the ADR**, ratifying obligations that already exist elsewhere |
| **Does NOT amend** | `MASTER_PRD.md` (Rank 1) · **BC Map (Rank 4), including §9.1 and `E-24` L333** · Dependency Matrix (Rank 4) · `PRD-006` (Rank 3, FROZEN) · `PRD-001` · every other frozen PRD · `ADR-0114`, `ADR-0115`, `ADR-0116`, `ADR-0117`, `ADR-0118` · `DOCUMENTATION_BASELINE.md` · `tool/module_dependencies.yaml` |
| **Baseline** | ⛔ **No baseline re-issue.** `BASELINE-2026-09-03-A` stands — §7 rule 4 moves the identifier only when a **Rank 1–3** document changes version, and none does |
| **Closes** | ⭐ **Item 3's *replay-semantics* limb** — the durability model is recorded **to the full extent existing authority fixes it** (§2) |
| **Opens** | ⚠⚠ **`EVT-GAP-001`** — the **client-side persistence limb** (survival across process death / restart, and the storage medium) is **NOT specified**. **Owner: this office. Requires a separate act.** See §3 |
| **Does NOT close** | ⛔ **Item 3 in full** (`EVT-GAP-001` remains) · ⛔ **Item 7b** — no queue-depth value exists to ratify (§5.1) · ⛔ Items **5**, **9b**, **7a**, **8b-residual** · ⛔ **no implementation authority** |
| **Implementation authorised** | ⛔ **No** |

> ⚠⚠ **READ THIS FIRST.** This ADR **invents nothing**. It records the durability properties that
> **Rank 1 and FROZEN Rank 3 already fix** for `BC-30` replay, and it **refuses** to state the one limb
> they do not fix. ⛔ **No storage, database, queue technology, schema, flush semantic, acknowledgement
> semantic or ordering mechanism is invented** — each was tested individually in §2 and §3.

---

## §1 The act, and why it is lawful now

`ADR-0117` constituted the `EVENT platform` office and, on the conferring instruction's express words
(*"DO NOT decide: Item 3 durability model"*), **withheld the exercise** — recording that *"the conferral
creates the capacity and withholds the exercise."*

The human principal has now directed the exercise: *"Item 3 — Durable Queue. Exercise EVENT platform
authority. Determine/record the authoritative durability model. Do not invent storage, database, queue
technology, schema, flush/ack/order semantics."*

⭐ **So this is the completion of one outstanding act, not the reuse of a spent one** — a distinction
`ADR-0033` §7.1 makes load-bearing, and one `ADR-0117` §4 recorded in advance precisely so it could be
audited here.

⭐⭐ **The method is ratification, not authorship** — the `ADR-0109` shape (*"CLOSED by existing
architecture"*) and the `ADR-0102` shape (ratify the pre-approved value, open a named gap for the
residue). **Every property in §2 is quoted from a document that already binds.**

---

## §2 ⭐ The durability model, ratified — each property with the authority that already fixes it

**The `BC-30` Offline Sync durable-queue durability model is the following four properties, and nothing
further:**

| # | Property (ratified) | Authority that already fixes it — quoted |
|---|---|---|
| **D-1** | **At-least-once with idempotent absorption.** A queued attendance mutation may be delivered more than once; a redelivery **MUST** be absorbed, never applied twice | **FROZEN Rank 3** `PRD-006` **L2430–2431**: *"a replayed observation **MUST** be absorbed by idempotency (`ATT-INV-003`, `ATT-FR-090`…`095`) rather than applied twice."* Corroborated at **Rank 1** by `MP-NFR-02`: *"At-least-once event delivery with idempotent consumers"* |
| **D-2** | **The idempotency key is already specified** — no new key, scheme or scope is created | `ATT-INV-003`: idempotent by **`(studentRecordId, date, idempotencyKey)`**; `ATT-FR-090`, `ATT-FR-091` (*"MUST return the original outcome"*), `ATT-FR-092` (**tenant-scoped**, `X-13`), `ATT-FR-095` |
| **D-3** | **Ordering is by the platform time port, never the device clock** | `PRD-006` **L2435–2436**: *"Ordering by the platform time port (`ATT-FR-088`), never by device clock."* `ATT-FR-088` **L1647**; `ATT-AC-098` |
| **D-4** | **No silent discard.** A queued item that fails to replay **MUST NOT** vanish; its failure must remain an observable signal | **Rank 1** `MP-NFR-02`: *"**DLQ depth is an SLO-monitored signal, not a silent bin**."* Corroborated by BC Map **L452** (`Failure`): *"Retry with backoff → Dead Letter Queue. DLQ depth is an SLO-monitored signal, not a silent bin"* |

⭐ **D-1 and D-3 are the two properties an implementer would otherwise have guessed, and both were
already law** — in a **FROZEN** document, in the section (`§27.1`/`ATT-PO-011`…`013`) that governs exactly
this queue. Ratifying them is the whole value of this act.

### §2.1 ⛔ What §2 does NOT contain, tested item by item against the instruction

| Forbidden to invent | Does §2 contain it? |
|---|---|
| **Storage** / medium | ❌ **No.** No file, box, table, journal or medium is named |
| **Database** | ❌ **No.** No database, and ⛔ `ADR-0116`'s `Supabase` selection is **not** read as implying any local durability property |
| **Queue technology** | ❌ **No.** No library, package or engine |
| **Schema** | ❌ **No.** No field, column, envelope or record layout |
| **Flush semantics** | ❌ **No.** No `fsync`, write-ahead, commit-point or flush policy |
| **Acknowledgement semantics** | ❌ **No.** D-1 states *what must not happen twice*, not **when** an ack is emitted or what it contains |
| **Ordering semantics** | ⚠ **Only the ordering rule FROZEN `PRD-006` L2436 already states** — *"by the platform time port … never by device clock."* ⛔ **No** partition key, sequence number, monotonic counter or tie-break rule is invented |

⭐ **D-4 is deliberately expressed as a prohibition, not a mechanism.** It says a failure **must not be
silent**; it does **not** create a DLQ, name a retry policy or set a depth — those are Items 5 and 7b,
belonging to other acts.

---

## §3 ⚠⚠ `EVT-GAP-001` — the persistence limb, OPEN and deliberately not written

⛔ **The client-side persistence guarantee — that a captured mutation survives process death, force-stop
or device reboot — is NOT specified by this act.**

⭐ **This is modelled exactly on `ADR-0102` §13.2's `SRE-GAP-001`**, which ratified the pre-approved
availability *target* and left the SLO, SLI and error budget **OPEN**, on the reasoning that *"defining an
SLI is new content rather than ratification of a pre-approved value, and **a one-act conferral may not
produce it**."* The same reasoning binds here.

**The measurement that forces it:**

| Probe | Result |
|---|---|
| Any Rank 1–5 statement that `BC-30`'s local queue **survives process restart** | ⛔ **NONE.** Swept `MASTER_PRD.md`, `PRD-006`, BC Map and the Dependency Matrix for `durable/durability/survive/persist/restart/fsync/write-ahead/WAL/acknowledg` — **0** hits attach such a guarantee to `BC-30` |
| Does BC Map **§9.1**'s Event Delivery Contract supply it? | ⛔ **No — and this is the decisive scope finding.** §9.1 is scoped by its own preamble (**L442**) to *"every event **above**"*, i.e. the §9 domain-event table. **`BC-30` appears in no §9 event row**, and **`E-24` (L333) is a `CF` **Sync port**, not an event edge** |
| Is that scoping a novel reading? | ❌ **No — the BC Map itself already reasons this way.** §18.4 records that §9.1's `Replay` row *"does NOT reach `BC-22`"* because it is *"parenthetically **scoped**"*, which is why **`BCM-22-INV-1`** had to state durability separately: *"MUST be durably persisted at creation and **MUST survive process restart**"* |
| Could I therefore just write the `BC-30` equivalent of `BCM-22-INV-1`? | ⛔ **No.** `BCM-22-INV-1` lives in the **Rank 4 BC Map**. Writing a new invariant there is **new content in a ranked document**, requiring an ADR-before-change (`DOCUMENTATION_BASELINE.md` §7 rule 1) **and** an act of the **Architecture Owner** — and `PRD_OWNERSHIP_MODEL.md` **§14**'s own table excludes *"boundaries, ranks or permitted edges"* from this office |

⚠ **A counter-argument was tested and rejected as insufficient.** `PRD-006` **G-1** (*"Record presence as a
durable, correctable, auditable fact"*) and `MP-ASM-03` (*"offline attendance capture is required"*) point
toward persistence — but **G-1 governs the stored business record, not the client queue**, and *"offline
capture"* does not by itself decide whether a queue must survive a **reboot** as opposed to a
connectivity gap. ⭐ **Inferring the stronger guarantee from the weaker premise would be exactly the
promotion `ATT-GAP-005` forbids elsewhere** (*"A PRD may not promote an architecture document's own open
question to an answer"*). **So it is opened, not assumed.**

| | |
|---|---|
| **`EVT-GAP-001`** | The `BC-30` client-side **persistence guarantee** (survival across process death / force-stop / reboot) and its **storage medium** are **UNSPECIFIED** |
| **Owner** | **`EVENT platform`** for the guarantee; **Architecture Owner** if it is to be recorded as a Rank-4 invariant on the `BCM-22-INV-1` model |
| **Status** | 🔴 **OPEN — requires a separate act** |

⛔ **Item 3 is therefore NOT fully closed**, and is **not** recorded as resolved anywhere in this ADR.

---

## §4 Boundaries preserved

| Boundary | Still in force |
|---|---|
| `ATT-PO-011` — `BC-03` *"**MUST NOT** implement the queue, the replay or the conflict detection itself"* | ✅ **Yes.** ⛔ This ADR moves **no** responsibility between `BC-03` and `BC-30` |
| `BC-03` owns the conflict-resolution policy; `BC-30` executes | ✅ **Yes** — `ADR-0114`, `E-24` byte-unchanged |
| `ATT-NFR-012` — offline behaviour not promised beyond `E-24` | ✅ **Yes.** D-1…D-4 promise nothing `E-24` does not already carry |
| A replayed observation **MUST NOT** overwrite a staff correction (§18) | ✅ **Yes** — `PRD-006` L2431, untouched and unweakened |
| `MP-CON-03` — Data Layer abstract, dedicated backend can replace the BaaS later | ✅ **Yes.** D-1…D-4 are **vendor-neutral** and name no product |
| `MP-CON-01` — no vendor name in domain code | ✅ **Yes** |
| No distributed transaction | ✅ **Yes** — none introduced, implied or permitted |
| Context / edge counts | ✅ **31 contexts (23 in V1), 29 edges** — none created |

---

## §5 What remains open — nothing is closed by implication

### §5.1 ⛔ Item 7b is NOT unlocked, and the reason is not merely sequencing

`ADR-0118` conferred the `DATA / EVENT` act *"after the Item-3 durability model is authoritative."* Two
independent bars remain:

1. ⚠ **The precondition is only partly met** — `EVT-GAP-001` leaves the persistence limb open.
2. ⛔⛔ **More decisively, NO queue-depth value exists anywhere to ratify.** Measured: **0** limits, water
   marks, shed policies or eviction rules for `BC-30` in any Rank 1–5 document. `MP-NFR-04` states the
   *obligation* (*"queues, partitioning, **backpressure**"*) and no *value*. ⚠ The EA's nearest line is
   **`Realtime Scaling & Backpressure (V3)`** (**L1855**) — **V3**, and about the **realtime** engine, not
   the V1 offline queue; it is Rank 6 descriptive and confers nothing.

⭐ **So Item 7b would require an owner-supplied value, not a ratification.** Exercising `ADR-0118`'s act
now would produce an invented number. ⛔ **Not done.** Item 7b stays **BLOCKED**, and `ADR-0118`'s one act
remains **unspent and available**.

### §5.2 Items 5, 9b, 7a, 8b-residual — untouched

| Item | Status | Why unchanged by this ADR |
|---|---|---|
| **5 — Retry/Backoff** | ⛔ **OPEN** | `PRD-006` **L2332**: *"no cooldown, frequency, quiet-hour rule, **retry count** or escalation ladder is stated … and **none may be invented**."* ⚠ **D-4's *"no silent discard"* is deliberately NOT a retry policy** — it forbids silence; it sets no count, delay or ladder |
| **9b — At-rest** | 🔒 **BLOCKED** | **SECURITY PLATFORM**'s. `ATT-GAP-006` **OPEN**: *"the construction is Security Platform's. Inventing one here would be a security design, which §0.4 forbids."* ⚠ And it now also sits behind **`EVT-GAP-001`** — there is no agreed persistence medium to protect |
| **7a — Retention** | ⛔ **OPEN** | `Q-04` open *in the authoritative document*; `ATT-GAP-005` bars promoting its unratified note; `MP-NFR-10` → **SECURITY + DATA Governance**. ⭐ `ADR-0051` **L136** is the precedent: it refused the same for `AUD-CFG-*` because *"**No Rank 1–7 authority supplies a retention period**"* |
| **8b-residual** | ⚠ **REQUIRES OWNER DECISION** | Fresh-authorization rule **preserved unweakened** (`AUTH-8.38`, `BR-7.1`); stored facts protected (`ATT-INV-008`, `ATT-FR-015` forward-acting). ⛔ The disposition of a legitimately queued mutation on revoked/expired access is **not chosen here** |

⛔ **This ADR confers NO lifecycle stage**, creates **no** context, edge, event, port or requirement
identifier, allocates **0** `IMPL-*`, mints **0** `SYNC-*`, and touches **0** application-code files.
⚠ **`EVT-GAP-001` is an ADR-local gap identifier on the `SRE-GAP-001` precedent** (`ADR-0102` §13.2) — it
is **not** a `SYNC-*` identifier and is **not** added to any PRD register.

---

## §6 Changelog

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-08 | ⭐⭐ **Created and ACCEPTED. The `EVENT platform` office EXERCISES its one act** (conferred by `ADR-0117`, which expressly **withheld** it — so this completes an outstanding act and **reuses no spent conferral**). ⭐⭐ **The `BC-30` durability model is RATIFIED, not authored:** **D-1** at-least-once with idempotent absorption (**FROZEN** `PRD-006` **L2430–2431**, corroborated by Rank-1 `MP-NFR-02`), **D-2** the already-specified idempotency key `(studentRecordId, date, idempotencyKey)` (`ATT-INV-003`, `ATT-FR-090`…`095`, tenant-scoped via `ATT-FR-092`/`X-13`), **D-3** ordering by the platform time port never the device clock (`PRD-006` **L2436**, `ATT-FR-088`), **D-4** no silent discard (Rank-1 `MP-NFR-02` *"not a silent bin"*, BC Map **L452**). ⭐ **D-1 and D-3 are exactly what an implementer would otherwise have guessed, and both were already law in a FROZEN document** — ratifying them is this act's whole value. ⛔ **NOTHING INVENTED, tested item by item (§2.1):** no storage, medium, database, queue technology, schema, flush semantic or acknowledgement semantic; the only ordering rule stated is the one `PRD-006` already fixes; `ADR-0116`'s `Supabase` selection is **not** read as implying any local durability property. ⚠⚠ **`EVT-GAP-001` OPENED, not assumed:** the client-side **persistence** limb (survival across process death / force-stop / reboot) and its storage medium are **UNSPECIFIED** — swept for `durable/survive/persist/restart/fsync/WAL` and found **0** Rank 1–5 statements attaching such a guarantee to `BC-30`; **BC Map §9.1 does not supply it**, being scoped by its own **L442** preamble to *"every event above"* while **`BC-30` appears in no §9 event row** and **`E-24` is a `CF` Sync port, not an event edge** — the very scoping the BC Map's own **§18.4** applied when `BCM-22-INV-1` had to state durability separately for `BC-22`. Writing the `BC-30` equivalent would be **new content in the Rank-4 BC Map**, needing an ADR-before-change and the **Architecture Owner**, which **§14 excludes from this office**. ⚠ A counter-argument from `G-1` + `MP-ASM-03` was tested and **rejected as insufficient** — `G-1` governs the stored record, not the client queue, and inferring reboot-survival from *"offline capture"* would be the promotion `ATT-GAP-005` forbids. ⛔ **Item 3 is NOT fully closed.** ⛔⛔ **Item 7b NOT unlocked** — beyond the partial precondition, **no queue-depth value exists anywhere to ratify** (`MP-NFR-04` gives the obligation, no value; the EA's *"Realtime Scaling & Backpressure"* is **V3** and about the realtime engine, Rank 6 descriptive); `ADR-0118`'s act remains **unspent**. ⛔ **Items 5, 9b, 7a, 8b-residual untouched**; **D-4 is expressly NOT a retry policy**. ⛔ **Amends NOTHING** — `PRD-006`, BC Map (incl. §9.1, `E-24`), `MASTER_PRD`, `ADR-0114`…`ADR-0118`, `DOCUMENTATION_BASELINE` all byte-unchanged; `ATT-PO-011` preserved; `PRD-018` not created; **0** `IMPL-*`, **0** `SYNC-*`, **0** code files. ⛔ **Implementation authorised: No.** Office **VACANT** after this act. |
