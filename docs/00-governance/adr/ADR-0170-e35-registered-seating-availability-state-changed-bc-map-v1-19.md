# ADR-0170 — `E-35` is registered in the BC Map at **v1.19**, carrying the new `BC-04` event `seating.AvailabilityStateChanged` with payload `{libraryId, availabilityState}`

| Field | Value |
|---|---|
| **Status** | ⭐⭐ **Accepted** — **2026-09-19**, under the one-act conferral recorded **verbatim** at **§9.1**. ⛔ **Reverting on completion** *(`ADR-0033` §7.1)*. ⚠️⚠️ **NO INDEPENDENT REVIEW CLAIMED** |
| **Rank** | 2 — Architecture Decision Record |
| **Date prepared** | 2026-09-19 |
| **Bounded context** | `BC-04` Seating *(producer)* · `BC-23` Search Indexing *(consumer)* |
| **Supersedes** | ⛔ **NOTHING** |
| **Superseded by** | — |
| ⭐⭐ **Deciding authority** | ⭐⭐ **Architecture Owner** — `PRD_OWNERSHIP_MODEL` §2.2 *("Boundaries, ranks, permitted edges… **any Rank 1–5 document change**")*; BC Map **L292**; `SEAT-FR-206` *("adding an event requires an **ADR**")* |
| **Mints** | ⭐ Event **`seating.AvailabilityStateChanged`** — ⭐ the **fifth** `BC-04` event, `SEAT-EVT-005` |
| **Amends** | ⭐⭐ **`LIBOORA_BOUNDED_CONTEXT_MAP.md` v1.18 → v1.19, BY APPEND** *(new §25)* · ⭐ `DOCUMENTATION_BASELINE.md` §3 row *(§7 rules 2–3)*. ⛔ **Executed — see §7** |
| **Decides** | ⭐ The event **name** · ⭐ the `E-35` **registration** · ⭐ its **consumer set**. ⛔ **Nothing else** |
| **Expressly does NOT decide** | ⛔ Thresholds *(`ADR-0168`/`0169`)* · ⛔ the derivation *(allocation only)* · ⛔ any UI or code · ⛔ `SEAT-CFG-017` · ⛔ `SEAT-EVT-004` · ⛔ `SEAT-GAP-005`/`011`/`014` · ⛔ `LIB-24.2` · ⛔ Public Live Occupancy *(**V2**)* · ⛔ any `PERM-*`, role, office or scope class |
| **Origin** | ⭐ **`ADR-0167`** §9 steps 2–3 — the two **blocking** Architecture Owner acts |

> ⭐⭐ **Identifier checks, immediately before drafting.** **ADR:** `ADR-0169`
> highest; `ADR-0170` measured **0** files and **0** references; `0150`…`0169`
> **contiguous**. **Event:** `SEAT-EVT-005` measured **0** repo-wide.
> **Edge:** `E-35` re-verified free *(`ADR-0167` §4.3)*.

---

## 1. ⭐⭐ The decisions

### `D-1` — ⭐ The event is named **`seating.AvailabilityStateChanged`**

| Field | Value |
|---|---|
| **Identifier** | ⭐ **`SEAT-EVT-005`** |
| **Name** | ⭐⭐ **`seating.AvailabilityStateChanged`** |
| **Producer** | `BC-04` Seating |
| **Primary consumer** | ⭐ **`BC-23`** Search Indexing — ⛔ **and no other** |
| **Emitted when** | ⭐ The computed public availability state **transitions** between `Available`, `Limited Availability` and `Full` |
| **Payload** | ⭐⭐ **`{libraryId, availabilityState}` — exactly two fields** |
| **Purpose** | ⭐ Public availability projection *(§14B)* |

⭐ **Convention compliance** — BC Map §9's binding form is
`<Context>.<Aggregate><PastTenseVerb>`: ⭐ context **`seating`** *(matching
`SEAT-EVT-001`…`004`)*, ⭐ **`AvailabilityState`**, ⭐ past tense **`Changed`**.
⛔ Not an imperative, ⛔ so not a `BC-28` command *(`SEAT-FR-207`)*.

⭐⭐ **Emitted on TRANSITION, not on every allocation** — ⭐ this is a deliberate
privacy property, ⛔ not an optimisation. §5.2.

### `D-2` — ⭐⭐ `E-35` is registered in the BC Map

| Field | Value |
|---|---|
| **Edge** | ⭐⭐ **`E-35`** |
| **Source → Target** | **`BC-04` Seating → `BC-23` Search Indexing** |
| **Pattern** | **`PL`** *(Published Language)* |
| **Mechanism** | **Event** |
| **Tier** | ⭐⭐ **V1** |
| **Payload** | ⭐ `{libraryId, availabilityState}` — ⭐ `ADR-0167` `D-3` |

⭐ Registered **by append** as BC Map **§25**, ⛔ **not** by insertion into §7 or §9.
⭐ Version **v1.18 → v1.19**. §6 records the measurement that chose the method.

### `D-3` — ⛔ The payload boundary is carried forward **unchanged**

⛔⛔ **`ADR-0167` `D-3` is restated verbatim in the BC Map, not relaxed.** ⛔ No
count, percentage, free-seat number, seat/floor/zone identifier, per-seat status
or timing, attendance datum, `PersonId`/`StudentRecordId`/device identifier, or
state-change timestamp beyond ordinary envelope metadata.

### `D-4` — ⛔⛔ **FROZEN `PRD-007` IS NOT AMENDED**

⭐⭐ **This is the most consequential determination in this ADR, and §4 is its
justification.** ⛔ `PRD-SEAT-MANAGEMENT.md` is **byte-unchanged**; ⛔ its §22.1
event table still lists **four** events; ⛔ `SEAT-FR-206` is not edited.

---

## 2. ⭐ Scope

| Dimension | Disposition |
|---|---|
| ⭐ Event name + identifier | ⭐⭐ **MINTED** |
| ⭐ `E-35` BC Map registration | ⭐⭐ **EXECUTED** — v1.19 |
| ⭐ Baseline §3 row | ⭐ **UPDATED** — §7.2 |
| ⛔ FROZEN `PRD-007` | ⛔⛔ **NOT AMENDED** — §4 |
| ⛔ `TRACEABILITY_MATRIX` | ⛔ **NOT AMENDED** — §4.4 |
| ⛔ Thresholds · UI · code | ⛔ **NOT DECIDED** |

---

## 3. ⭐ What was already decided, and is only carried here

| Decided by | What |
|---|---|
| ⭐ `ADR-0167` | The gap; `E-35`'s existence, endpoints, pattern, tier; the payload boundary |
| ⭐ `ADR-0168` | Thresholds `<80` / `80–<100` / `=100`; allocation-only derivation; counts private |
| ⭐ `ADR-0169` | Denominator = configured seat count; `C = 0` ⇒ `Full` |

⛔⛔ **None is re-opened, re-argued, widened or narrowed.** ⭐ This ADR supplies only
what those three expressly left outstanding: **a name and a register entry.**

---

## 4. ⭐⭐ The frozen-register question — the central procedural finding

⚠️⚠️ **The conferral said: *"formally register the `E-35` event name within the
permitted `BC-04` event-register procedure"*, and *"Follow the repository's
required procedure for modifying the frozen event register."* ⭐ I read that
procedure before acting, and it produced a conclusion I did not expect.**

### 4.1 ⭐ What `SEAT-FR-206` actually says

> **`SEAT-FR-206`** — *"This module's published domain events are **exactly** the
> following, **fixed by BC Map §9**. The set is **closed**; **adding an event
> requires an ADR**."*

⭐⭐ **Two limbs decide this question:**

1. ⭐⭐ ***"fixed by BC Map §9"*** — ⭐ `PRD-007` **does not own** the event set; it
   **transcribes** a Rank-4 register. ⭐ The BC Map is the **system of record**.
2. ⭐⭐ ***"adding an event requires an ADR"*** — ⭐ the closure carries **its own
   escape clause**, and it names **exactly one instrument: an ADR.** ⛔ It does
   **not** require a PRD amendment.

⭐⭐ **So the lawful act is: amend the register that fixes the set (BC Map,
Rank 4, by ADR) — and `PRD-007`'s transcription becomes stale, not wrong.**

### 4.2 ⛔⛔ Why amending `PRD-007` would have been the WRONG act

⭐ `PRD_LIFECYCLE` §4 routes a *"new requirement"* through ADR → **PRD version
increment** → baseline → traceability → registry. ⚠️ A superficial reading says
that applies here.

⛔⛔ **It does not, for three measured reasons:**

| # | Reason |
|---|---|
| 1 | ⭐⭐ **No `SEAT-*` requirement is created, changed or withdrawn.** ⭐ `SEAT-FR-206` remains true **as written** — it says the set is *"fixed by BC Map §9"*, and it still is. ⛔ Amending it would be recording a fact it **already delegates**, ⭐ duplicating the register it points at — ⭐⭐ the exact *"the number gets written twice and drifts"* failure `LIB-10.4` warns of |
| 2 | ⭐⭐ **`PRD_LIFECYCLE` L177 is a prohibition, not a licence.** *"**A frozen PRD is never silently modified.** Not for an obvious correction, and not for one that is certainly right"* — ⭐ with `PGA-01`/`PGA-02` recorded as **two confirmed defects left unfixed for exactly this reason**. ⭐⭐ The discipline is to amend a frozen document **only when nothing else will do.** ⭐ Here something else does: the Rank-4 register |
| 3 | ⭐⭐ **The `ADR-0096` precedent is exactly on point.** ⭐ It minted **`E-30`** *and the new event `tenancy.LibraryProfileViewed`* produced by **`BC-19`**, whose owning `PRD-013` is **`FROZEN`** — ⭐⭐ and it recorded: ⛔ *"Does **not** amend §7 or §9 in place, and does **not** edit any **FROZEN** artefact."* ⭐ **A new event was minted for a frozen context's producer by BC Map append alone. That is the worked procedure.** |

### 4.3 ⚠️ The consequence, disclosed rather than hidden

⚠️⚠️ **`PRD-007` §22.1 now lists four events while the authoritative register lists
five.** ⭐ Its `SEAT-EVT-*` range is `001`…`004`; ⭐ `SEAT-EVT-005` exists only here
and in the BC Map.

⭐⭐ **This is a documentation lag, ⛔ not a contradiction** — ⭐ because
`SEAT-FR-206` **defers** to BC Map §9 rather than asserting independently. ⛔ The
PRD does not say *"there are four events"* as a free-standing claim; ⭐ it says the
set is *"exactly the following, **fixed by BC Map §9**"*.

⭐ Registered as **`GAP-SEAT-EVT005-TRANSCRIPTION`**, routed to the **`PRD-007`
owner** *(Product Owner + Library Domain, `PRD_OWNERSHIP_MODEL` **L164**)* for the
next lawful `PRD-007` amendment — ⛔ **not repaired here**, because doing so is the
frozen-edit L177 forbids when another route exists.

⭐ **Precedent for disclosing rather than repairing:** `ADR-0163` recorded
`SM-GAP-2`'s frozen row still reading *"placeholder"* as ⭐ *"a documentation lag,
not a live gap"*.

### 4.4 ⛔ `TRACEABILITY_MATRIX` is not amended

⭐ `PRD_LIFECYCLE` §4 step 6 is conditional — *"**if identifiers changed**"*. ⭐ The
matrix **L404** records `SEAT-EVT-n` as *"Domain event (**closed set, fixed by BC
Map §9**) — **4**"*, ⭐ transcribing the same delegated register.

⛔ **Not amended here** — ⭐ no `SEAT-*` identifier in `PRD-007` changed; ⭐ the
matrix's figure moves when the PRD's transcription does. ⭐ Folded into
`GAP-SEAT-EVT005-TRANSCRIPTION`.

---

## 5. ⭐ Why this shape

### 5.1 ⭐ Why `SEAT-EVT-005` and why this name

| Check | Result |
|---|---|
| `SEAT-EVT-005` free | ⭐ **0** occurrences repo-wide |
| Sequential | ⭐ `001`…`004` contiguous ⇒ `005` next |
| `seating.` prefix | ⭐ Matches all four existing |
| `<Aggregate><PastTenseVerb>` | ⭐ `AvailabilityState` + `Changed` |
| ⛔ Not an imperative | ⭐ `SEAT-FR-207` satisfied |
| ⛔ Collides with `SEAT-EVT-004`? | ⛔ **NO** — §5.3 |

### 5.2 ⭐⭐ Transition-triggered emission is a privacy property

⭐ The event fires **only when the state label changes**, ⛔ not on every allocation
or release.

⭐⭐ **Why that matters:** an event per allocation would let an observer counting
events **reconstruct the occupancy count** — ⛔ defeating `ADR-0167` `D-3` by
inference even though no payload field carries a number. ⭐ A transition-only
event emits at most **twice** across a day's fill cycle.

⭐⭐ **The payload boundary is protected in the emission pattern as well as the
field list.** ⭐ `ADR-0096` §17.2.1's principle, applied to **frequency** rather
than content.

### 5.3 ⛔ `SEAT-EVT-005` and `SEAT-EVT-004` are unrelated

| | ⭐ `SEAT-EVT-005` | ⛔ `SEAT-EVT-004` |
|---|---|---|
| Trigger | ⭐ Public **availability state** transition | ⛔ **Live occupancy** crossing a configured threshold |
| Input | ⭐⭐ **Allocation** ÷ configured capacity | ⛔⛔ **Live occupancy** *(attendance-derived)* |
| Consumers | ⭐ `BC-23` | ⛔ `BC-22`, `BC-26` |
| Configurable | ⛔ **No** *(`LIB-7.4`)* | ⭐ Yes — `SEAT-CFG-017` |
| V1 status | ⭐⭐ **V1, active** | ⛔⛔ **V2 — "Unset in V1; no event is emitted"** |

⛔⛔ **`SEAT-EVT-004` stays unset and `SEAT-CFG-017` stays HELD.** ⭐ Minting `005`
⛔ does **not** activate, substitute for, or unblock `004`.

### 5.4 ⭐ Why `BC-23` alone

⛔ `BC-26` Analytics and `BC-24` Audit are **not** consumers. ⭐ Adding them would
widen the edge beyond §14B's need, and ⭐ `BC-26`'s own **L385** invariant *("no
projection is a system of record")* is not engaged by a public read. ⭐⭐ **The
consumer set is the minimum that satisfies the requirement.**

---

## 6. ⭐ Method — append, chosen on measurement

| Probe | Result |
|---|---|
| BC Map length before | **1501** lines |
| Highest live line-citation into the file | ⭐ **L1482** |
| Citations shifted by an **append** | ⭐⭐ **ZERO** |
| Citations shifted by inserting a row after `E-26` *(§7)* | ⛔⛔ **~1,293** — *"several inside **FROZEN** Rank 3 documents"* *(measured at BC Map v1.9)* |
| Citations shifted by inserting into §9 | ⛔ **~747** |

⭐ The `ADR-0079` §8.5 Option A doctrine, reused by BC Map §15, §16, §17, §19, §24
— ⭐ and now **§25**. ⛔ §7 and §9 are **byte-unchanged**; ⭐ only the header
`Version` cell *(L6)* and the appended section differ.

---

## 7. ⭐⭐ The executed acts

### 7.1 BC Map → **v1.19**

⭐ **Appended new §25** carrying: the `E-35` row · the `SEAT-EVT-005` row · the
`D-3` payload boundary · the §5.2 emission rule · the §4.3 transcription
disclosure · a *"what this does NOT do"* block.

⭐ Header **Version** cell updated in place *(L6 — measured **uncited**)*.
⛔ **§7, §8, §9 byte-unchanged.** ⛔ Contexts remain **31** *(23 in V1)*.

### 7.2 `DOCUMENTATION_BASELINE.md` §3 row

⭐ Updated to **v1.19** citing this ADR — `DOCUMENTATION_BASELINE` §7 **rule 2**
*(version + changelog same commit)* and **rule 3** *(declaration updated same
commit)*.

⛔⛔ **No baseline identifier re-issue.** ⭐ §7 **rule 4**: the identifier moves
*"only when a **Rank 1–3** document changes version"* — ⭐ the BC Map is **Rank 4**
and ⛔ **no Rank 1–3 document changes version here**. ⭐ **`BASELINE-2026-09-11-B`
STANDS** — ⭐ the `ADR-0016`/`0055`/`0083`/`0085`/`0146` precedent.

---

## 8. ⛔ Refused

| # | Move | ⛔ Refused because |
|---|---|---|
| 1 | ⭐ Amend FROZEN `PRD-007` §22.1 to add `SEAT-EVT-005` | ⛔⛔ **§4** — `SEAT-FR-206` delegates to BC Map §9; ⛔ `PRD_LIFECYCLE` **L177**; ⭐ the `ADR-0096` precedent |
| 2 | ⭐ Silently correct the four-vs-five discrepancy | ⛔⛔ **L177** — *"never silently modified… **not for one that is certainly right**"*. ⭐ Disclosed at §4.3 instead |
| 3 | ⭐ Insert `E-35` into §7 in place | ⛔ **~1,293** citations shifted, ⭐ several inside FROZEN documents |
| 4 | ⭐ Reuse `SEAT-EVT-004` | ⛔ **§5.3** — different trigger, input, consumers and **tier** |
| 5 | ⭐ Reuse `E-31` | ⛔ **RESERVED** for `PRD-021C`/`TSF-GAP-009` |
| 6 | ⭐ Add `BC-26`/`BC-24` as consumers | ⛔ **§5.4** — beyond the requirement |
| 7 | ⭐ Emit per allocation rather than per transition | ⛔⛔ **§5.2** — ⭐ an event-counting observer could reconstruct the occupancy count |
| 8 | ⭐ Re-issue the baseline identifier | ⛔ §7 **rule 4** unmet — ⭐ Rank 4 |
| 9 | ⭐ Amend `TRACEABILITY_MATRIX` | ⛔ **§4.4** — step 6 is conditional; ⛔ no `PRD-007` identifier changed |
| 10 | ⭐ Implement anything | ⛔ ⭐⭐ *"a registered edge is not an implementation"* *(`ADR-0146` §24.3)* |

---

## 9. ⭐⭐ Authority record

### 9.1 ⭐⭐ The conferral — VERBATIM

> ⭐⭐ **VERBATIM — human principal of this engagement, 2026-09-19:**
>
> ```
> "I confer the Architecture Owner office for the single act of completing the
> already-approved V1 public seat-availability architecture: formally register the
> `E-35` event name within the permitted `BC-04` event-register procedure, then
> append `E-35` to the BC Map as `BC-04 → BC-23`, `PL`, `Event`, `V1`, with
> payload exactly `{libraryId, availabilityState}`. Preserve the decisions in
> `ADR-0167`, `ADR-0168`, and `ADR-0169`; do not change thresholds, roles,
> permissions, frozen/approved product requirements, or any unrelated
> architecture. Follow the repository's required procedure for modifying the
> frozen event register. Record the completed act in an ADR if required by that
> procedure. This one-act conferral reverts on completion. No independent review
> is claimed. Do not commit or push."
> ```

### 9.2 ⭐ Validity

| # | Element | Supplied? | Words relied on |
|---|---|---|---|
| 1 | First-person grant | ⭐ **YES** | *"**I confer**"* |
| 2 | Names the office | ⭐ **YES** | *"the **Architecture Owner** office"* |
| 3 | Single act | ⭐ **YES** | *"for the **single act** of completing the already-approved V1 public seat-availability architecture"* |
| 4 | Both limbs specified | ⭐ **YES** | *"register the `E-35` event name… then **append** `E-35` to the BC Map"* |
| 5 | Edge parameters fixed | ⭐ **YES** | *"`BC-04 → BC-23`, `PL`, `Event`, `V1`"* |
| 6 | Payload fixed | ⭐ **YES** | *"payload **exactly** `{libraryId, availabilityState}`"* |
| 7 | ⭐⭐ Procedure clause | ⭐ **YES** | *"**Follow the repository's required procedure** for modifying the frozen event register"* |
| 8 | ADR conditional | ⭐ **YES** | *"Record the completed act in an ADR **if required by that procedure**"* |
| 9 | Express prohibitions | ⭐ **YES** | *"do not change thresholds, roles, permissions, **frozen/approved product requirements**, or any unrelated architecture"* |
| 10 | One-act, reverting | ⭐ **YES** | *"This **one-act** conferral **reverts on completion**"* |
| 11 | Review disclosure | ⭐ **YES** | *"**No independent review is claimed**"* |
| 12 | Commit/push | ⭐ **YES** | *"**Do not commit or push**"* |

⭐⭐ **12 / 12.** ⭐ `ADR-0080` **L7**; `ADR-0106`.

### 9.3 ⭐⭐ Two clauses that were load-bearing

⭐⭐ **Element 7 — *"Follow the repository's required procedure"*.** ⭐ Reading it
changed the act: the procedure turned out to require ⛔ **NOT** amending the frozen
PRD *(§4)*. ⭐ Had I assumed a PRD amendment was implied by *"frozen event
register"*, I would have made an edit **L177 forbids**.

⭐⭐ **Element 9 — *"do not change… frozen/approved product requirements"*.** ⭐ This
**confirms** the §4 conclusion rather than conflicting with it. ⭐⭐ The two clauses
read together are coherent: *follow the procedure, and that procedure does not
touch the frozen PRD.*

⭐ **Element 8's conditional is satisfied** — ⭐ `SEAT-FR-206` requires an ADR to add
an event, and `DOCUMENTATION_BASELINE` §7 rule 1 requires one before any Rank 1–5
change. ⭐⭐ **An ADR was required, and this is it.**

### 9.4 ⛔ Not reused

⛔ `ADR-0167`'s Architecture Owner conferral — ⭐ **reverted on completion**; ⭐ this
is **fresh text**. ⛔ `ADR-0168`/`0169` were **direct Product Owner exercises**.
⛔ `ADR-0162`/`0164`/`0165`/`0166` — Authorization Owner, all spent.

### 9.5 ⭐⭐ Reversion

⭐⭐ **Reverts on completion of this act.** ⛔⛔ **Any further architecture act —
including repairing the §4.3 transcription lag — requires a NEW one-act
conferral.**

---

## 10. ⭐ Sources

| # | Source | Locus | Relied on for |
|---|---|---|---|
| 1 | ⭐⭐ `PRD-SEAT-MANAGEMENT.md` **FROZEN** | **`SEAT-FR-206`**, `SEAT-FR-207`, §22.1 | ⭐ ***"fixed by BC Map §9"*** and ⭐ *"adding an event requires an ADR"* |
| 2 | ⭐⭐ `PRD_LIFECYCLE.md` | **§4**, **L177** | ⭐ The amendment procedure; ⛔ **the never-silently-modify rule** |
| 3 | ⭐⭐ `ADR-0096` | §336, §10 | ⭐⭐ **The precedent: a new event for a FROZEN context's producer, by BC Map append alone** |
| 4 | `ADR-0167` · `ADR-0168` · `ADR-0169` | — | The edge, payload, thresholds, denominator, zero case |
| 5 | `LIBOORA_BOUNDED_CONTEXT_MAP.md` | **L292**, §9 convention, **L1482**, v1.9 changelog | Edge rule; naming; `E-35` free; append measurement |
| 6 | `DOCUMENTATION_BASELINE.md` | §7 rules 1–4, §3 row | ADR-first; version+changelog; ⛔ no identifier re-issue |
| 7 | `ADR-0079` | §8.5 Option A | The append doctrine |
| 8 | `PRD_OWNERSHIP_MODEL` | §2.2, **L164** | Architecture Owner remit; `PRD-007`'s owner |
| 9 | `TRACEABILITY_MATRIX.md` | **L404** | ⭐ The matrix also transcribes the delegated set |
| 10 | `ADR-0080` · `ADR-0106` · `ADR-0033` | L7 · L7 · §7.1 | Conferral mechanism |

---

## 11. ⭐ Status after acceptance

| Item | State |
|---|---|
| **This ADR** | ⭐⭐ **Accepted** — 2026-09-19 |
| ⭐ **`E-35`** | ⭐⭐ **REGISTERED** — BC Map **§25**, v1.19 |
| ⭐ **`SEAT-EVT-005`** | ⭐⭐ **MINTED** — `seating.AvailabilityStateChanged` |
| **BC Map** | ⭐ **v1.19** · edges **30** live *(⛔ `E-27` vacant, ⛔ `E-31` reserved)* · contexts **31** |
| **Baseline** | ⭐ §3 row updated; ⛔ **`BASELINE-2026-09-11-B` STANDS** |
| ⚠️ **`GAP-SEAT-EVT005-TRANSCRIPTION`** | ⚠️ **OPEN** — ⭐ documentation lag; **`PRD-007` owner** |
| **FROZEN `PRD-007`** | ⛔⛔ **BYTE-UNCHANGED** |
| **`TRACEABILITY_MATRIX`** | ⛔ **Unchanged** |
| **`SEAT-EVT-004` / `SEAT-CFG-017`** | ⛔⛔ **V2, unset, HELD** — untouched |
| **Public Live Occupancy** | ⛔ **V2** |
| **`PERM-*`** | ⛔ **0** — `AUTH-7.22` closed at zero |
| **Coverage / holds** | ⭐ **95 / 104** · ⛔ **9** — unchanged |
| **`ADR-INDEX`** | ⛔ **Not modified** — a Governance Owner act |
| **The conferral** | ⛔⛔ **REVERTED ON COMPLETION** |

---

## 12. Change history

| Version | Date | Change |
|---|---|---|
| ⭐⭐ **1.0** | 2026-09-19 | ⭐⭐ **Created and `Accepted`. `E-35` is REGISTERED in the BC Map at v1.19 — `BC-04 Seating → BC-23 Search Indexing`, `PL`, Event, V1 — carrying the newly minted fifth `BC-04` event `SEAT-EVT-005` `seating.AvailabilityStateChanged`, payload exactly `{libraryId, availabilityState}`.** ⭐⭐⭐ **THE CENTRAL FINDING IS PROCEDURAL AND IT WENT THE OTHER WAY FROM THE OBVIOUS READING** *(§4)*: the conferral said *"follow the repository's required procedure for modifying the **frozen event register**"*, ⭐ and reading it established that ⛔⛔ **the procedure does NOT amend the frozen PRD.** ⭐⭐ **`SEAT-FR-206` says the event set is *"exactly the following, **fixed by BC Map §9**"* and that *"adding an event **requires an ADR**"*** — ⭐ two limbs which together mean `PRD-007` **transcribes** a Rank-4 register rather than owning it, ⭐ and that the closure carries **its own escape clause naming exactly one instrument: an ADR**. ⭐⭐ **The `ADR-0096` precedent is exactly on point** — it minted `E-30` **and** the new event `tenancy.LibraryProfileViewed` for **`BC-19`**, whose owning `PRD-013` is **`FROZEN`**, recording ⛔ *"does **not** edit any **FROZEN** artefact"*. ⭐ And **`PRD_LIFECYCLE` L177** is a **prohibition, not a licence**: *"**A frozen PRD is never silently modified.** Not for an obvious correction, and **not for one that is certainly right**"*, with `PGA-01`/`PGA-02` left unfixed for exactly this reason. ⛔⛔ **FROZEN `PRD-007` IS THEREFORE BYTE-UNCHANGED**, and ⚠️ the resulting **four-vs-five** discrepancy is **DISCLOSED as `GAP-SEAT-EVT005-TRANSCRIPTION`** — ⭐ a **documentation lag, ⛔ not a contradiction**, because `SEAT-FR-206` **defers** rather than asserting independently — ⭐ routed to the `PRD-007` owner, on the `ADR-0163` *"documentation lag, not a live gap"* precedent. ⛔ **`TRACEABILITY_MATRIX` is likewise NOT amended** — §4 step 6 is conditional *("if identifiers changed")* and **L404** transcribes the same delegated set. ⭐⭐ **THE EVENT NAME FOLLOWS THE BINDING CONVENTION** — `seating.` + `AvailabilityState` + past-tense `Changed`; ⭐ `SEAT-EVT-005` measured **0** repo-wide and `001`…`004` contiguous. ⭐⭐ **EMISSION IS TRANSITION-TRIGGERED, AND THAT IS A PRIVACY PROPERTY, ⛔ NOT AN OPTIMISATION** *(§5.2)* — ⭐ an event per allocation would let an observer **counting events reconstruct the occupancy count**, ⛔ defeating `ADR-0167` `D-3` by inference even with no numeric field; ⭐⭐ **the payload boundary is protected in the emission FREQUENCY as well as the field list**. ⭐ **`SEAT-EVT-005` and `SEAT-EVT-004` are proven unrelated** *(§5.3)* — different trigger, input *(**allocation** vs **live occupancy**)*, consumers, configurability and **tier**; ⛔⛔ **`SEAT-EVT-004` stays unset and `SEAT-CFG-017` stays HELD**. ⭐ **`BC-23` is the sole consumer** — ⛔ `BC-26`/`BC-24` refused as beyond the requirement. ⭐ **APPEND CHOSEN ON MEASUREMENT** *(§6)* — highest live citation **L1482**; append shifts ⭐ **ZERO**, an `E-26` insertion ⛔ **~1,293** *"several inside FROZEN Rank 3 documents"*; ⛔ **§7, §8, §9 byte-unchanged**; only **L6** *(measured uncited)* edited in place. ⭐ **Baseline §3 row updated** per §7 rules 2–3; ⛔⛔ **no identifier re-issue** — rule 4's Rank 1–3 limb **unmet**, ⭐ **`BASELINE-2026-09-11-B` STANDS**. ⛔ **TEN MOVES REFUSED** *(§8)*, incl. ⛔ amending `PRD-007`, ⛔ silently correcting the discrepancy, ⛔ in-place §7 insertion, ⛔ reusing `SEAT-EVT-004` or the **reserved** `E-31`, ⛔ widening consumers, ⛔ per-allocation emission, and ⛔ implementing anything — ⭐⭐ *"a registered edge is not an implementation"*. ⛔ Supersedes **NOTHING** · ⛔ **0** frozen/approved product requirements modified · ⛔ **0** thresholds changed · ⛔ **0** `PERM-*` *(`AUTH-7.22` closed at zero)* · ⛔ **0** roles, offices or scopes · ⛔ **0** contexts, aggregates or invariants *(**31**, 23 in V1)* · ⛔ **0** unrelated architecture · ⛔ **0** UI or runtime code · ⛔ `ADR-INDEX` **not modified** · ⛔ **no commit, no push**. ⭐⭐ **The conferral has REVERTED ON COMPLETION.** |
