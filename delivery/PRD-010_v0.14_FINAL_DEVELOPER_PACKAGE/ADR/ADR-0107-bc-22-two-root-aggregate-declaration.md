# ADR-0107 — `BC-22` Notification Delivery is declared with **two aggregate roots**: `FeedItem` and `DeliveryMessage`

| Field | Value |
|---|---|
| **Status** | **Accepted** — 2026-09-05 |
| **Date** | 2026-09-05 |
| **Deciders** | ⭐⭐ **The Architecture Owner**, by **direct, explicit, first-person act** quoted verbatim at §2 (decisions **AO-1**…**AO-5**). Declaring an aggregate root and its transaction boundary is a **structural** determination, which `PRD_OWNERSHIP_MODEL.md` **L85** assigns to the Architecture Owner (*"Boundaries, ranks, permitted edges, precedence … ADR approval; any Rank 1–5 document change"*), and which `ADR-INDEX.md` Process step 1 requires be recorded in an ADR (*"a decision that changes structure, ownership, a boundary, or a platform-wide rule requires an ADR"*) |
| **Supersedes** | — |
| **Amends** | `LIBOORA_BOUNDED_CONTEXT_MAP.md` — **by APPEND only**, as a new **§18**. ⛔⛔ **§8's table (L364–L387) is byte-unchanged**, per the **§15.5 precedent** (**L735-736**). ⛔ No PRD, no frozen document, no Rank 1–3 artefact is modified by this ADR |
| **Amended by** | — |
| **Baseline** | ⛔ **No baseline re-issue.** `DOCUMENTATION_BASELINE.md` §7 rule 4 moves the baseline identifier only for a **Rank 1–3** document changing version; this ADR amends a **Rank 4** artefact and no document changes version |
| **Closes** | ⭐ The `BC-22` **structural gap** — `BC-22` had **0** rows in BC Map §8 while **17** other contexts had one. An aggregate/entity declaration now exists, so a retention obligation has an artefact to attach to |
| **Does NOT close** | ⛔⛔ **`NTF-CFG-006`'s numerical lifetime bounds** — see `ADR-0108` §4. ⛔ **`NTF-CFG-007`** (value `[OWED]`). ⛔ **`NTF-GAP-013`** (`[OWED — AO]`, expressly withheld by the deciding act). ⛔ **`NTF-GAP-010`**, **`-012`**, **`-017`**, **`-020`**. ⛔ **Stage 4 is NOT conferred by this ADR** |
| **Related** | BC Map **L131**, **L205**, **L366**, **L370-386**, **L447**, **L453**, **L735-736** · `PRD-010_NOTIFICATIONS_AND_COMMUNICATION.md` **L349-351**, **L447-449**, **L792** · `PRD_OWNERSHIP_MODEL.md` **L85** · `ADR-0083` §4.5 (the §15.5 append precedent) |

---

## 1. Context — the gap this closes, and why it blocked a configuration decision

`BC-22` Notification Delivery holds an ownership row at BC Map **L131** (*"Owns channel
selection, templates, deduplication, quiet hours, delivery guarantees,
consent/unsubscribe"*) and a ubiquitous-language row at **L205**. It held **no row in §8
Aggregate & Invariant Register**.

Measured before this act, at §8 rows **L370-386**: **17** contexts declared —
`BC-01`, `-02`, `-03`, `-04`, `-05`, `-06`, `-10`, `-11`, `-12`, `-13`, `-18`, `-19`,
`-20`, `-21`, `-24`, `-26`, `-27`. **`BC-22` count = 0.**

⭐ **Why that blocked `NTF-CFG-006`.** A deduplication-retention rule must bind to a
declared artefact. `BC-12` can own retention because §8 **L378** names `RetentionPolicy`
as one of its entities. `BC-22` had no entity set, so every candidate retention rule was
either unfalsifiable or an invention — the finding recorded as **D1 UNRESOLVED**.

⚠ **A false premise is corrected rather than relied upon.** `PRD-010` **L792** and
`PRD-010_STAGE4_REQUIREMENTS_REVIEW.md` **L1007** each assert that *"`DeliveryMessage`
is a `BC-22`-owned aggregate (BC Map **L205**)"*. **L205 does not so state.** It is a row
in **§5 Ubiquitous Language Collisions**, whose governing text (**L195**) makes its
resolution column binding on *"the names that must appear in code, APIs"* — **names, not
aggregate structure**. The word *aggregate* appears nowhere in L205. That over-reading is
recorded here as an error and is corrected in `PRD-010` under this ADR's authority.

---

## 2. The deciding act, quoted verbatim

> *"AO-1 — Aggregate architecture: APPROVE the recommended two-root BC-22 architecture:
> `FeedItem`, `DeliveryMessage`.*
>
> *AO-2 — Transaction boundaries: APPROVE: `FeedItem` = one recipient-notification
> transaction boundary. `DeliveryMessage` = one recipient-channel delivery transaction
> boundary.*
>
> *AO-3 — Cross-root transaction: APPROVE an explicit rule that no shared database
> transaction spanning `FeedItem` and `DeliveryMessage` is required.*
>
> *AO-4 — Durability: APPROVE: `FeedItem` is durable. `FeedItem` is rebuildable from the
> authoritative event/log source. `FeedItem` is NOT a system of record. Record the exact
> invariant needed to make this falsifiable and testable.*
>
> *AO-5 — BC-12 boundary: APPROVE the clarifier distinguishing notification-item `read`
> from conversation read state, while preserving BC-12 ownership."*

**Authority basis.** That instruction **is** the authority, and it is **the only authority
claimed**. Same form as `ADR-0033` §7.2, `ADR-0034` §7.2 and
`PRD-008_STAGE4_CONFERRAL.md`. **Scope: these five decisions only** —
`ADR-0033` §7.1: *"A conferral for one act is not a standing licence."*

⛔ **`AO-11` (`NTF-GAP-013`) was expressly withheld** by the same act (*"DO NOT invent the
ownership answer. Keep it `[OWED — AO]`"*) and is **not** decided here.

---

## 3. Decision

### 3.1 Two aggregate roots (AO-1)

`BC-22` is declared with **two** aggregate roots:

| Root | Meaning |
|---|---|
| **`FeedItem`** | The **durable, per-recipient, user-visible notification record** — the in-app inbox item. Owns **In-App `read`/unread** state |
| **`DeliveryMessage`** | The **per-recipient-per-channel delivery** — one attempt-bearing dispatch over one channel. Owns **per-channel delivery state** |

⭐ **A two-root declaration is an existing repository pattern, not an invention.** Measured
at §8: **4 of 17** rows already declare two roots joined by `·` — `BC-04`
(`SeatAllocation` · `SeatLayout`), `BC-11` (`Friendship` · `BlockList`), `BC-18`
(`Account` · `AccessPolicy`), `BC-20` (`Subscription` · `SubscriptionInvoice`) — and
`BC-15` §15.5 adds a fifth (`Community` · `Group`). §8 **L366** constrains **each
aggregate** (*"one aggregate, one database transaction"*); it does not limit a context to
one root.

### 3.2 Transaction boundaries (AO-2)

| Root | Boundary |
|---|---|
| `FeedItem` | **One recipient-notification** = one transaction |
| `DeliveryMessage` | **One recipient-channel delivery** = one transaction |

Consistent with `NTF-FR-013` (*"one `OperationId` and **N delivery records**"*),
`NTF-FR-015` (*"per-recipient state is authoritative"*) and `G1` (*"exactly one notice per
recipient **per channel**"*).

### 3.3 No cross-root transaction (AO-3)

⛔ **No requirement may be written that obliges a single database transaction to span a
`FeedItem` and a `DeliveryMessage`.** Each root is its own transaction boundary
(**L366**). A design that needs both mutated atomically must be re-modelled, not granted
an exception.

### 3.4 Deduplication record — not an aggregate

The idempotency/deduplication record keyed
`(eventId, recipientId, channel, templateId)` (`NTF-INV-007`) is a **separate
infrastructure record**, not an aggregate of either root.

⭐ **This is permitted, not a workaround.** BC Map **L447** requires *"a processed-events
table **or equivalent**"* — an infrastructure artefact. `NTF-FR-046` requires the record be
*"claimed **atomically before dispatch**"*, which is an **atomicity and ordering**
obligation and **not** a same-aggregate obligation; `SEAT-BR-032` locates the comparable
gate (**G3**) *"before any mutation"*, outside the aggregate.

### 3.5 `FeedItem` durability invariant (AO-4)

⭐⭐ **A new invariant is required because no existing rule reaches `BC-22`.** BC Map
**L453** reads, verbatim: *"Every projection **(BC-26)** and index **(BC-23)** must be
rebuildable from the log. This is tested quarterly, not assumed."* The parenthetical
**scopes** the rule to `BC-26` and `BC-23`; corroborated by `MASTER_PRD.md` **L474**
(`MP-GBR-37`, Analytics) and by `test/architecture/every_projection_rebuildable_test.dart`,
which covers Analytics only. ⇒ **`BC-22`'s inbox was not bound by it.**

The invariant, stated so that it can fail:

> **`BCM-22-INV-1`** — A `FeedItem` **MUST** be durably persisted at creation and **MUST**
> survive process restart; it **MUST** be reconstructible from the authoritative event log
> such that a rebuild yields an identical set of `FeedItem`s for a given tenant and
> recipient; and it **MUST NOT** be treated as a system of record — no consumer may read a
> `FeedItem` as the authoritative statement of the business fact it reports, which remains
> the emitting context's.

⭐ **Falsifiable at three points, each independently testable:** (i) a `FeedItem` absent
after restart **fails**; (ii) a rebuild from the log producing a different set **fails**;
(iii) any consumer treating a `FeedItem` as authoritative for the business fact **fails**.

⚠ **Deliberately NOT stated: any retention period.** Durability is not retention. This
invariant fixes that a `FeedItem` **exists and is rebuildable**; it fixes **no lifetime**.
See `ADR-0108` §4.

### 3.6 `BC-12` clarifier (AO-5)

`BC-12` ownership is **preserved unchanged**: `Conversation` (root), `Message`,
`DeliveryReceipt`, `RetentionPolicy` remain `BC-12`'s (§8 **L378**).

> **`BCM-22-INV-2`** — `BC-22`'s `read` state applies **only** to a `FeedItem` — a
> notification item in the in-app inbox. It is **NOT** conversation read state, **NOT**
> message read state and **NOT** a `DeliveryReceipt`. `BC-22` **MUST NOT** create, store,
> read, moderate or infer the read state of a `Conversation` or `Message`.

Consistent with, and narrower than, `NTF-XC-001`…`-003` (`PRD-010` **L349-351**) and
`PRD-010` **L48**. ⛔ `PRD-021B` is **FROZEN** and is **not** touched.

---

## 4. What this ADR does NOT do

| # | Not done |
|---|---|
| 1 | ⛔ **`NTF-GAP-013` NOT decided** — expressly withheld; stays **`[OWED — AO]`** |
| 2 | ⛔ **No retention period, TTL, timeout or numeric bound** of any kind |
| 3 | ⛔ **§8's table NOT edited** — byte-unchanged; the declaration is appended as **§18** per §15.5 |
| 4 | ⛔ **No existing aggregate ownership moves** — `BC-12`'s four, `BC-11`'s three, `BC-13`'s four and every other §8 row stand unchanged |
| 5 | ⛔ **No frozen PRD modified, reopened or re-ranked** |
| 6 | ⛔ **No Rank 1 document changed** — `MASTER_PRD.md` byte-unchanged |
| 7 | ⛔ **No new `BC-*`, `E-*` edge, port, permission or event created** — context count stays **31** |
| 8 | ⛔ **No lifecycle stage conferred.** `PRD-010` stays **`DRAFT`**, registry **`PLANNED`**, Stage 4 **NOT CONFERRED**, Stage 5 **NOT ENTERED** |
| 9 | ⛔ **No `IMPL-*` allocated · no traceability registration · no baseline row** |
| 10 | ⛔ **No application or test code changed** |

---

## 5. Consequences

- ⭐ `NTF-CFG-006` gains a **host artefact** (`FeedItem`) and a **durability** invariant. ⚠ It does **not** thereby gain numeric bounds — `ADR-0108` §4 records that residue explicitly.
- ⭐ `read`/unread now has a lawful home; the earlier objection that it *"cannot attach to a Push record"* is resolved.
- ⭐ The dedup grain (`channel`) and the user-visibility grain (per recipient) are both representable, resolving the `NTF-INV-007` text-vs-key tension without weakening either.
- ⚠ `PRD-010` §18's lifecycle must be read as **`DeliveryMessage`** state; `read` is **`FeedItem`** state. `PRD-010` is amended accordingly under this ADR.
- ⚠ **`BCM-22-INV-1` is specified but not yet executably proven** for `BC-22`; `every_projection_rebuildable_test.dart` covers Analytics only. Proving it is implementation work, not a governance act, and is **not** claimed here.

---

## 6. Changelog

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-05 | Created and **`Accepted`**. Records the Architecture Owner's act on **AO-1**…**AO-5**: `BC-22` declared with two aggregate roots `FeedItem` · `DeliveryMessage`; transaction boundaries fixed per recipient-notification and per recipient-channel delivery; a **no-cross-root-transaction** rule stated; the dedup record placed **outside** both aggregates on BC Map **L447**'s *"or equivalent"*; **`BCM-22-INV-1`** durability/SoR invariant minted, stated in falsifiable form, and justified by the measured finding that BC Map **L453** is **scoped to `BC-26`/`BC-23`** and does not reach `BC-22`; **`BCM-22-INV-2`** `BC-12` clarifier minted. ⚠ **The `PRD-010` L792 / Stage-4 L1007 claim that BC Map L205 declares `DeliveryMessage` an aggregate is recorded as FALSE and corrected** — L205 is a §5 ubiquitous-language row binding on *names*. ⛔ **`AO-11` / `NTF-GAP-013` expressly NOT decided.** ⛔ 0 numbers introduced · 0 frozen PRDs touched · 0 Rank 1 changes · §8 table byte-unchanged · 0 stages conferred. |
