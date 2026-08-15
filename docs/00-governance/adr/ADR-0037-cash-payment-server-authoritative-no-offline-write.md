# ADR-0037 — Cash payment is supported; financial recording is server-authoritative. `FEE-GAP-002`(c) is dissolved, not routed

| Field | Value |
|---|---|
| **Status** | **ACCEPTED** — *"In force. Binding on all implementation"* (`ADR-INDEX.md` status vocabulary). **ACCEPTED by direct conferral of Product Owner authority by the human principal**, 2026-08-15, on the identical basis and with the identical disclosure as `ADR-0032` §5.2, `ADR-0033` §7.2 and `ADR-0035` §7.2: **no ARB quorum, attendee list or Security review is asserted**, and *a conferral for one act is not a standing licence*. |
| **Date** | 2026-08-15 |
| **Raised by** | `FEE-GAP-002`(c) — the last surviving reason `PRD-008` Stage 3 check 2 was ⛔ BLOCKED, recorded in [`PRD-008_ARCHITECTURE_ALIGNMENT.md`](../../30-product/revenue-finance/PRD-008_ARCHITECTURE_ALIGNMENT.md) §3 and §12 |
| **Decision by** | **Product Owner** — the decision is about **product scope** (is offline financial capture a V1 capability?), not about architecture. See §6 for why this authority is the correct one and why the **Architecture Owner** is *not* required. |
| **Supersedes / amends** | **Nothing.** No ranked document is amended. **No edge is added. No bounded context is created. No aggregate, port, contract, endpoint, schema, permission identifier or configuration identifier is defined.** `tool/module_dependencies.yaml` is **not** modified. |
| **Governs** | `BC-05` offline behaviour · `FEE-GAP-002`(c) · `FEE-FR-061` · `FEE-XC-022` · `PRD-008` Stage 3 check 2 |

---

## 1. The decision, stated exactly as conferred

> **Cash payment is supported, but financial recording MUST remain online/server-authoritative. Physical cash may be
> offline, but the app MUST NOT perform an offline financial write, queue, local financial ledger, or later sync.**
>
> **Therefore do NOT create a `BC-05` → `BC-30` dependency edge and do NOT create `BC-32`.**
>
> Cash confirmation is a **server-side `BC-05` financial operation performed when connectivity exists**, preserving
> `FEE-FR-061`, `FEE-XC-022`, idempotency, and `MP-GBR-24`.

---

## 2. The central finding: this gap is **dissolved**, not answered

`FEE-GAP-002`(c) asked:

> *"Through which \[declared architectural edge\] does `BC-05` **queue an offline financial write**?"*

**That question had no answer because it had a false premise.** It assumed `BC-05` performs an offline financial
write, and then hunted for the edge that would carry it. The conferred decision says **`BC-05` never performs one**.

A question of the form *"which edge carries X?"* has exactly two lawful terminations:

| Termination | What it requires | Applies here? |
|---|---|---|
| **Declare the edge** | A BC Map §7 amendment — a new numbered `E-*` row, Architecture Owner authority | ❌ **No** — explicitly forbidden by the decision |
| **Establish that X does not occur** | A product-scope decision that the behaviour is out of scope | ✅ **Yes** — this is that decision |

**The gap is closed by the second route.** No edge is needed because there is no traffic. This is the same shape of
reasoning as **`ADR-0033`**, which closed an edge conflict by **withdrawing `E-27`** rather than by adding it to an
allow-list, and recorded the principle that a fix which *"restores compliance with the law that already existed"* is
stronger than one which rewrites the law. Here the parallel is exact: **no law is rewritten, and no edge is created**.

> **⚠ This is the one place where this ADR could most easily over-claim, so it is stated flatly.** Dissolving a
> question is a legitimate way to close it **only when the dissolution is itself an authorised decision**. If I had
> reached *"`BC-05` does no offline write, therefore no edge is needed"* by my own reasoning from `FEE-XC-022`, that
> would have been **me closing an Architecture Owner blocker by re-reading a requirement I had written myself** — and
> it would have been invalid. It is valid here **only because a product authority decided the scope**. The
> distinction is the whole difference between a resolved gap and a self-served one.

---

## 3. What the PRD already said — measured, not assumed

The decision required **no new requirement**, because `PRD-008` §28.1 already specifies it. Measured at HEAD:

| Identifier | Text as written in `PRD-008` §28.1 (L1247–L1250) | Relationship to the decision |
|---|---|---|
| **`FEE-FR-061`** | *"A **cash** payment **MUST NOT** reach `CONFIRMED` except by a **server-side** recording of an authorised staff action. Where connectivity is absent, the collection attempt **MUST** yield **no** confirmed financial record, **no** receipt and **no** membership activation."* | ✅ **Exactly the decision.** Server-authoritative recording; nothing confirmed offline |
| **`FEE-XC-022`** | *"Creating, queueing, mirroring or synchronising **any** financial write while offline."* — stated as an **exclusion** | ✅ **Exactly the prohibition.** Covers all four forbidden things by name: *write*, *queue*, *mirror*, *sync* |
| **`FEE-PO-006`** | *"Online payment **MUST NOT** be treated as successful because the device is offline or the confirmation could not be fetched. Absence of confirmation is **not** confirmation."* | ✅ Reinforces it for the online path |
| **`FEE-PO-007`** | *"Where a payment's outcome is unknown, it **MUST** remain `PENDING`"* | ✅ The unknown case has a defined home, and it is not a local ledger |
| **`FEE-FR-029`** | *"Every payment-recording operation **MUST** accept an idempotency key at the API edge."* | ✅ Idempotency preserved — **at the API edge**, i.e. server-side |
| **`FEE-AC-081`** | *"With no connectivity, a staff cash-collection attempt produces no `CONFIRMED` record, no receipt and no membership activation"* | ✅ `FEE-FR-061` is **verifiable**, not merely asserted |
| **`FEE-AC-082`** | *"No financial write is queued, mirrored or synchronised while offline; a repeated cash submission with the same idempotency key yields one confirmed payment"* | ✅ Verifies the exclusion **and** the idempotency guarantee in one criterion |

**The requirement set is complete and already traced.** `PRD-008` §32 maps `FEE-FR-061` → `FEE-AC-081` and
`FEE-XC-022` → `FEE-AC-081`, `FEE-AC-082` (L1818, L1822). **Nothing was added to satisfy this decision.**

> **§28.1 also already anticipated this ADR, in writing.** Its own note reads: *"It is consistent with the
> architecture rather than merely with intent: **`E-24` grants the offline-sync edge to `BC-03` Attendance only**
> (BC Map L333), and `BC-05` has no such edge (`FEE-GAP-002`(b))."* The PRD had **already drawn the conclusion**
> that the absence of a `BC-05` → `BC-30` edge is *correct* rather than *missing*. What it lacked was the
> **authority** to say so, because scope is not a PRD's to decide. That authority is what this ADR supplies.
>
> *(That note's internal cross-reference says `FEE-GAP-002`**(b)**; the offline-sync limb is **(c)**. A one-letter
> citation defect, pre-existing, not corrected here — this ADR does not amend `PRD-008`'s prose — and recorded so
> it is not mistaken for a substantive disagreement. Logged in §8.)*

---

## 4. The three prohibitions, verified as observed

| Prohibition | Verified how | Result |
|---|---|---|
| **Do NOT create a `BC-05` → `BC-30` edge** | `LIBOORA_BOUNDED_CONTEXT_MAP.md` §7 re-measured; `E-24` remains the **only** `BC-30` inbound edge and its source remains `BC-03` Attendance (L333). No row added. Map hash **unchanged** at `81518f1bb251218b` | ✅ **Observed** |
| **Do NOT create `BC-32`** | `BC-32` register rows in the BC Map = **0**. Context count remains **31**. Consistent with `AR-1`, `ADR-0035` `D-2`, and `PRD_REGISTRY.md` L355 | ✅ **Observed** |
| **No offline financial write / queue / local ledger / later sync** | Already excluded by `FEE-XC-022`, which names all four; verified by `FEE-AC-082` | ✅ **Observed — and pre-existing** |

**No file under `docs/10-architecture/` is modified by this ADR**, and `tool/module_dependencies.yaml` stands
byte-unchanged at `22e40ac3fe080387`.

---

## 5. `MP-GBR-24` and idempotency are preserved, and here is why they were never at risk

| Invariant | Why the decision preserves it |
|---|---|
| **`MP-GBR-24`** (Rank 1) — `BC-20` must not model student money | Untouched. This decision concerns **where** and **when** a `BC-05` write happens (server-side, online), not **who** owns it. `BC-05` keeps ownership of student financial truth per `ADR-0035` `D-2`/decision 3; `BC-20` gains nothing |
| **Idempotency** (`MP-GBR-18`, `MP-RSK-04`, frozen `MM-BR-005`) | **Strengthened, not merely preserved.** Idempotency is hardest to guarantee across an offline queue that replays; forbidding the queue removes the failure mode entirely. `FEE-FR-029` places the key **at the API edge** — i.e. server-side — and `FEE-AC-082` verifies that a repeated cash submission with the same key yields **one** confirmed payment |
| **`FEE-FR-061`** | **Preserved verbatim.** Not reworded, not widened, not made configurable |
| **`FEE-XC-022`** | **Preserved verbatim as an exclusion.** §28.1's own reasoning for exclusion-over-configurable stands: *"so that an offline mode cannot be switched on later without amending this register"* |
| **Frozen `PRD-006`** | Untouched. The analogy `FEE-PO-006` draws to *"absence of observation is never evidence of an exit"* is a citation, not an amendment. Body md5 unchanged |

> **Cash is not made unsupported by this decision, and the distinction matters commercially.** A student may hand
> over physical cash in a room with no signal. What the decision forbids is the **app** treating that as a
> *recorded* payment before the server says so. The staff action becomes a confirmed financial fact when
> connectivity exists — which is why the conferral says *"performed when connectivity exists"* and not *"cash is
> online-only"*. `FEE-FR-061` already draws exactly this line: the **collection attempt** may occur; the
> **confirmed record** may not.

---

## 6. Which authority this needed — and why it is **not** the Architecture Owner

`FEE-GAP-002`'s `Owner` field says **Architecture Owner**, and every prior pass routed limb (c) there. **That
routing was correct while the question was architectural**, and it is retained in the gap block rather than deleted.

The decision changes the *kind* of question:

| Question | Kind | Authority |
|---|---|---|
| *"Through which declared edge does `BC-05` queue an offline financial write?"* | **Architectural** — it asks for an edge | **Architecture Owner** |
| *"Does `BC-05` perform an offline financial write at all?"* | **Product scope** — it asks whether a capability exists in V1 | **Product Owner** |

The second question was answered, and it **removes** the first rather than answering it. `PRD_OWNERSHIP_MODEL.md`
§2.2 gives the Architecture Owner authority over edges and boundaries; **there is no edge to rule on**, because the
decision creates no traffic to carry.

### 6.1 Is any Architecture Owner decision still required for check 2?

**No — and this was tested rather than assumed.** Measured at HEAD, `PRD-008_ARCHITECTURE_ALIGNMENT.md` §9.3 lists
every gap against its Stage 3 impact. After `FEE-GAP-016` was resolved at v1.1, **`FEE-GAP-002`(c) was the only
remaining limb marked as blocking check 2**; all sixteen other gaps are recorded *"No"*. With (a), (b) and (c) all
closed and (d) resolved, **no gap blocks check 2**.

> **⚠ What remains open, and where it goes — so that closing one gate does not look like closing all of them.**
> These are **untouched** by this decision and are **not** in check 2's path:
>
> | Still open | Authority | Blocks |
> |---|---|---|
> | `FEE-GAP-001`, `004`, `005`, `006` | Product Owner *(`001` also Architecture Owner)* | **Stage 4** |
> | `FEE-GAP-003`, `007`, `009`, `011`, `012` | Named per gap in `PRD-008` §37 | **Freeze** |
> | `FEE-GAP-013` (a2 partly), `014`, `015`, `017` | `BC-20` owner · `BC-25` · Product Owner | The **feature**, not this PRD |
> | `ADR-0036` **Q2** — protected-state window boundary | **Product Owner** | `ADR-0036` completeness |
> | **`Q-01`** — seat release after expiry | **Architecture Owner + `BC-04`** | `PRD-005`/`PRD-007` interaction |
> | `D-14` mis-attribution of `E-25` | **Architecture Owner** | Nothing — authorised, deliberately unexecuted |
>
> **`PRD-008` Stage 3 passing is not `PRD-008` being frozen, and not Stage 4 being permitted.** **5 gaps still
> block Stage 4** (`FEE-GAP-001`, `002`, `004`, `005`, `006`) and **10 still block Freeze**.

### 6.2 The one thing this ADR deliberately does **not** do

**It does not mark `FEE-GAP-002` as fully resolved for Stage 4.** Limbs (a), (b), (c) are all closed, but the gap's
**`Stage 4` field says `BLOCKS`** for reasons recorded in its own block that are **not** the edge question. That
field is **left as `BLOCKS`**. Closing a gap for one gate does not close it for another, and this ADR does not
reach past the gate it was raised against.

---

## 7. Consequences

| | Effect |
|---|---|
| **`FEE-GAP-002`(c)** | ✅ **CLOSED — dissolved by product scope.** The premise (that `BC-05` performs an offline financial write) is denied by authority |
| **`PRD-008` Stage 3 check 2** | ✅ **PASS** — *the first time this check has passed in seven passes* |
| **`PRD-008` Stage 3 verdict** | ✅ **ALIGNED — 6 of 6** |
| **BC Map** | **Unchanged.** No edge, no context. Hash `81518f1bb251218b` |
| **`tool/module_dependencies.yaml`** | **Unchanged.** Hash `22e40ac3fe080387` |
| **`BC-32`** | **Not created.** Count stays **31** |
| **`PRD-008` status** | **Still `DRAFT`, still `PLANNED` in `PRD_REGISTRY.md`.** Stage 3 alignment is **not** a freeze and **not** a Stage 4 entry ticket. **`GCP-14` is preserved** |
| **Requirements** | **None added, none reworded.** `FEE-FR-061`, `FEE-XC-022`, `FEE-PO-006`, `FEE-PO-007`, `FEE-FR-029` all pre-exist and are traced |
| **Implementation code** | **None written** |

> **Why check 2 may now pass without the gate having been weakened.** Check 2 asks whether *"every integration edge
> is in BC Map §7"*. It failed because a **required** integration — offline financial capture — had no declared
> edge. It passes now not because the requirement was granted an edge, and not because the check was relaxed, but
> because **the integration is no longer required**. The check's question is answered in the affirmative for every
> edge `BC-05` actually needs: intent via `business.payment_intent`, execution by the Business Platform capability,
> gateway via `platform/integration:payment_gateway` → `BC-31`, inbound webhook via the same capability's return
> leg. **`BC-30` is not among them, and now never was.**

---

## 8. Defects observed and **not** silently repaired

| Observation | Disposition |
|---|---|
| `PRD-008` §28.1's note cites *"`FEE-GAP-002`**(b)**"* where the offline-sync limb is **(c)** | **Left as written.** A one-letter citation defect in a document this ADR does not amend. Recorded here so a future reader does not read it as disagreement about which limb is which |
| `PRD-008` L799 cites *"EA L1408"* where the anchor is L1399 | Pre-existing, previously logged, **not** corrected here |
| `PRD-008` contains a `100%%` typo | Pre-existing (F-198), **not** corrected here |
| `FEE-RSK-10` states a stale count of *"5"* | Flagged at v1.1 as *"now correct by coincidence rather than by maintenance"*. **Unchanged** |
| A naive re-derivation of the Freeze blocker set returned **13** against the ledger's **10** | **The ledger is right and the regex was wrong.** Reading every `Freeze` field verbatim shows `FEE-GAP-013`/`014`/`017` each say *"**BLOCKS the … feature, not this PRD**"*. A pattern that matched `BLOCKS` anywhere in the cell mis-counted three. Recorded because *a count that disagrees with a document is a claim about the document, and it must be checked against the text before it is believed* |

---

## 9. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-15 | **First record, `ACCEPTED` on conferral of Product Owner authority.** Closes `FEE-GAP-002`(c) by **dissolving** it: cash payment is supported, financial recording is server-authoritative, and the app performs **no** offline financial write, queue, local ledger or later sync — therefore **no `BC-05` → `BC-30` edge** and **no `BC-32`**. The requirement set (`FEE-FR-061`, `FEE-XC-022`, `FEE-PO-006`, `FEE-PO-007`, `FEE-FR-029`, verified by `FEE-AC-081`/`082`) **already existed and is unchanged** — the ADR supplies the *authority* the PRD lacked, not the *specification*. `MP-GBR-24` and idempotency preserved; idempotency **strengthened**, since removing the replay queue removes the failure mode. **`PRD-008` Stage 3 → ✅ ALIGNED 6 of 6**, the first pass of seven to reach it. **Nothing else moves:** `PRD-008` stays `DRAFT` and `PLANNED` (`GCP-14` preserved), **5 gaps still block Stage 4**, **10 still block Freeze**, `FEE-GAP-002`'s own `Stage 4` field is **left at `BLOCKS`**, and `ADR-0036` Q2 and `Q-01` remain open with named authorities. No ranked document amended, no edge, context, port, schema, endpoint, permission or configuration identifier created, no gate modified, no code written. |
