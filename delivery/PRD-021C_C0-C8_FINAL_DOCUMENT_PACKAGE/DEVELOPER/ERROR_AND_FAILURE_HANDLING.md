# ERROR AND FAILURE HANDLING — `PRD-021C` C0–C8

**Derived document.** ⛔ No authority. Authority: [`../PRD/`](../PRD/) (**FROZEN**) ·
**`Accepted`** ADRs in [`../ADR/`](../ADR/) · [`../ARCHITECTURE/`](../ARCHITECTURE/).

---

## 1. ⭐⭐ The one rule this entire document expresses

> **`LMT-FR-024`** — When an upstream owner is unavailable, the marketplace surface
> **MUST** degrade by **omitting or truthfully relabelling** the affected element,
> and ⛔ **MUST NOT** substitute a locally computed value, a cached guess, a zero,
> or a placeholder presented as data.
>
> — C8 **§10.3**, **L509**

**Two permitted responses. Four forbidden ones.**

| ✅ Permitted | ⛔ Forbidden |
|---|---|
| **Omit** the element | A **locally computed** value |
| **Truthfully relabel** it | A **cached guess** |
| | A **zero** |
| | A **placeholder presented as data** |

⭐⭐ **Why this is stricter than normal engineering practice.** The usual instinct
on upstream failure is to degrade *gracefully* — show the last known value, show
a zero, show a spinner that resolves to empty. Every one of those makes the
surface **assert something it does not know**. The marketplace owns no business
state (`AR-1`, `LMT-XC-001`), so it has no authority to assert anything on an
owner's behalf. **Silence is truthful; a zero is a claim.**

---

## 2. Consistency — what you are actually reading

> **`LMT-FR-023`** — All other marketplace reads are **eventually consistent** by
> construction, because they read projections fed by events. ⭐ **The correct
> response to staleness is truthful labelling, not a stronger guarantee** — the
> discipline C4 established for seat indicators and C6 for sort keys.
>
> — C8 **§10.2**, **L503**

**Every marketplace read is eventually consistent.** This is not a limitation to
be engineered away; it follows from reading projections fed by an at-least-once
event stream. See
[`INTEGRATIONS_AND_EVENTS.md`](./INTEGRATIONS_AND_EVENTS.md) §4.

⛔ **Do not attempt to strengthen the guarantee.** Do not read through to the
owner's operational store to get a fresher value. Do not add a synchronous
refresh. Do not poll until the projection catches up. ⭐ The prescribed response
is **truthful labelling** — tell the user what the value is and what it is not.

### 2.1 The three consistency overrides — all owned elsewhere

> **`LMT-FR-022`** — 📤 **DELEGATED — BC Map §10** consistency table and **§10.1**'s
> three overrides, which C1–C7 inherit unchanged.
>
> — C8 **L490**

| Override | Mechanism | Marketplace relevance |
|---|---|---|
| **Double seat allocation** | **DB unique constraint + row lock** | C4 booking — 📤 `BC-04`'s, ⛔ **not re-specified** |
| **Abuse containment** | **Synchronous enforcement check at send time in `BC-12`** | C7 — ⛔ **C7 adds no check of its own** |
| **Duplicate payment** | **Idempotency key at API edge + gateway reference uniqueness + reconciliation job** | C4 — `LMT-FR-015` |

⚠ **Read the "Marketplace relevance" column carefully — it is a set of
prohibitions.** These three are the *only* places where a strong guarantee
exists, and in each case the mechanism belongs to someone else:

- ⛔ Do not implement seat-allocation locking. `BC-04` owns the write. See
  [`ARCHITECTURE_AND_BOUNDARIES.md`](./ARCHITECTURE_AND_BOUNDARIES.md) §4.1 —
  **C4 defines no booking**.
- ⛔ Do not add an abuse-containment check. The synchronous check lives in
  `BC-12`, at send time.
- ✅ Idempotency **is** a marketplace obligation via `LMT-FR-015` — see
  [`API_AND_CONTRACTS.md`](./API_AND_CONTRACTS.md) §3.

---

## 3. ⭐⭐ The degraded-mode table — the operational heart of the specification

Reproduced verbatim from C8 **§10.3** (**L514**–**L520**):

| Upstream down | Required behaviour | ⛔ Forbidden |
|---|---|---|
| **`BC-23`** index | Present whatever ordering C2 supplies, **relabelled** | ⛔ A C6-side fallback ordering — the slot C6 **§4.8 withdrew** |
| **`BC-04`** availability | **Omit** the indicator | ⛔ Rendering *"available"* or *"0"* as fact |
| **`BC-26`** projection | **Omit** the owner-only readout | ⛔ Estimating, or showing `UniqueViewers` as zero/unknown/placeholder (`ADR-0097`) |
| **`BC-13`** intake | Report affordance **reports failure honestly** | ⛔ Queuing locally, ⛔ **claiming a case was opened** |
| **`BC-29`** media | **Omit** the image | ⛔ Serving bytes from a marketplace-side copy |

Each row rewards a second look, because in each the forbidden behaviour is the
one an engineer would naturally write.

### 3.1 `BC-23` down — ⛔ and this is the trap

The instinct is: *"search is down, so fall back to a local ordering."* That
requirement **was drafted and then withdrawn**:

> ⛔ **Slot `023` in the `LDR-FR-*` register is deliberately NOT allocated.** …
> A fallback requirement was drafted here stating that C6 must present a degraded
> ordering if `BC-23` is unavailable. It was **withdrawn** on measurement: what
> happens when the index is unavailable is a property of the **query layer**, owned
> by C2 and ultimately by `BC-23` (**L132**), not of the presentation layer.
>
> — C6 **§4.8**, **L449**

⭐⭐ **Two frozen parts agree from opposite directions.** C6 withdrew the
requirement slot; C8 forbade the behaviour. When two independently authored parts
converge on the same refusal, treat it as settled.

✅ **Correct:** present whatever ordering C2 supplies, **relabelled** so the user
knows what they are looking at.
⛔ **Incorrect:** compute any ordering on the presentation side.

⚠ **Do not mint `LDR-FR-023`.** The slot is empty by decision (C8 **§16**: ⛔ no
unallocated, reserved, withdrawn or placeholder slot is rendered as a formed
identifier token).

### 3.2 `BC-04` down — ⛔ *"available"* and *"0"* are both lies

Rendering **"0 seats"** looks like the safe, conservative choice. It is
prohibited, because zero is a **fact about seats** that the marketplace does not
know. Rendering **"available"** is prohibited for the symmetric reason.

⭐ Note this compounds a boundary already in force: live occupancy is **V2** and
must not be invented (C4 **L10**–**L15**), and availability is ⛔ not an ordering
input because ordering by it **leaks occupancy by inference**. See
[`SEARCH_RANKING_AND_DISCOVERY.md`](./SEARCH_RANKING_AND_DISCOVERY.md) §3.2.

✅ **Correct:** omit the indicator entirely.

### 3.3 `BC-26` down — ⛔ the full surrogate list applies

The forbidden set is the same one `LMT-XC-018` enumerates: zero, unknown,
placeholder, *"coming soon"*, disabled, blurred, teased, **estimated**.

⭐ C8's own summary records that `LMT-FR-024` **strengthens** `ADR-0097` here — by
closing precisely the renderings *"that would otherwise appear when the
projection is unavailable."* The failure path was where the surrogate would have
slipped in, so the failure path is where it is explicitly closed.

✅ **Correct:** omit the owner-only readout. See
[`ANALYTICS_AND_OBSERVABILITY.md`](./ANALYTICS_AND_OBSERVABILITY.md) §2.

### 3.4 `BC-13` down — ⛔⛔ never claim a case was opened

This is the most consequential row, because the forbidden behaviour is the one
best practice normally recommends: *accept the user's report, queue it locally,
deliver it when the service returns, and reassure the user meanwhile.*

**All three parts of that are prohibited:**

| ⛔ Forbidden | Why |
|---|---|
| Queuing locally | The marketplace owns no state (`LMT-XC-001`); a local queue **is** state, and `LMT-FR-025` names the prohibition directly |
| Claiming a case was opened | It was not. `BC-13` opens cases; the marketplace only **enters** reports |
| Implying deferred success | Same defect, softer wording |

✅ **Correct:** the report affordance **reports failure honestly** — the user is
told the report was not submitted.

⭐ This is consistent with C7's whole posture: a report is **entered, never
decided**. A marketplace that says "your case is open" has decided something. See
[`AUTHORIZATION_AND_SECURITY.md`](./AUTHORIZATION_AND_SECURITY.md) §5.1.

### 3.5 `BC-29` down — ⛔ no marketplace-side bytes

⛔ Do not serve a cached copy, a locally stored thumbnail, or a re-hosted image.
The marketplace holds **`FileRef`s**, never bytes or raw storage paths
(`LMT-FR-005`); `BC-29` is *"the sole media infrastructure owner"* (`LMT-XC-005`).

⚠ A "temporary" local image cache is exactly the second media store `LMT-XC-005`
excludes.

✅ **Correct:** omit the image.

---

## 4. ⛔ No local write buffer, ever

> **`LMT-FR-025`** — ⛔ The marketplace **MUST NOT** implement a local write buffer,
> store-and-forward queue or offline mutation log for any C1–C7 action.
> ⭐ Consequence of `LMT-XC-001` and `LMT-XC-011`.
>
> — C8 **L522**

⭐ **This is a derivation, not an independent rule** — which is why it cannot be
argued around. `LMT-XC-001` says the composition **stores nothing**;
`LMT-XC-011` says it owns **no queue, worker pool, retry scheduler or cron**. A
write buffer requires both a store and a drain. Neither exists.

⛔ Prohibited, by name: local write buffer · store-and-forward queue · offline
mutation log · optimistic local mutation awaiting sync · retry queue for failed
writes.

⚠ And note the interaction with **`E-24`**: the *offline booking queue* edge
exists, but its source is **`BC-03` Attendance only** — `BC-04` is **not** a
consumer, so `XPC-CONF-011` was resolved **by exclusion, not by an edge** (C0
**§4**). ⭐ So there is no lawful offline booking path either: the edge that would
carry it is closed to the marketplace.

---

## 5. ⛔ No invented numbers — including timeouts

> **`LMT-XC-016`** — ⛔ C8 **MUST NOT** mint a latency target, throughput budget,
> percentile SLO, payload-size cap, cache TTL or **timeout value**. ⭐ **A8 refused
> the same** … a number invented in a product part becomes an **unowned obligation
> that no operator agreed to and no test can justify**. ⚠ **Disclosed as an
> absence**, not presented as satisfied.
>
> — C8 **§10.1**, **L471**

> **`LMT-FR-021`** — Where a marketplace surface needs a performance obligation, it
> **MUST** inherit the obligation of the owner whose read it composes, and ⛔ **MUST
> NOT** state a stricter or looser one.
>
> — C8 **L478**

⚠ **"Timeout value" is in the list, and timeouts are failure handling.** So the
timeout you need is **inherited from the owner whose read you compose** — ⛔ not
chosen, and ⛔ not made stricter "to be safe". A stricter timeout converts a slow
success into a failure that the owner never agreed to.

⭐ Note the honesty of the disposition: the absence is **disclosed as an absence**,
not dressed up as satisfied. If you need a number, you have found an **open
question for the owner**, not a decision to make.

### 5.1 ⛔ No cache tier

> **`LMT-XC-017`** — ⛔ No cache tier, cache invalidation protocol or read replica.
> ⭐ The public discovery index is **already** the read-optimised representation
> (`AR-3`); adding a cache in front of a projection would create a **second**
> derived copy with its own staleness, and no owner.
>
> — C8 **L482**

⭐ **This is a failure-handling argument.** A cache does not merely add speed — it
adds a **second staleness horizon that nobody owns**, and it is precisely the
thing that would later be used to serve a "cached guess" when the upstream is
down, which `LMT-FR-024` forbids. Refusing the cache removes the temptation
structurally.

---

## 6. Errors at the API edge

From [`API_AND_CONTRACTS.md`](./API_AND_CONTRACTS.md) and C8 **§9**:

| Condition | Required behaviour |
|---|---|
| Expired or malformed cursor | **MUST** yield a **domain error** — ⛔ **never** a silent reset (C8 **§9.3**, **L428**) |
| Missing tenant context | **MUST fail loudly** — ⛔ never default to a first/default/any tenant (`LMT-BR-008`, `LMT-FR-009`) |
| Unauthorized object reference | Denied per request via a `BC-18` policy decision — ⛔ never permitted by possession (`LMT-FR-018`) |
| Duplicate submission | Handled by **idempotency** (`LMT-FR-015`) |
| New error taxonomy | ⛔ **Not defined here** — `LMT-XC-012`: no new API convention, envelope, **error taxonomy**, version scheme or content type |

⭐⭐ **Two of these are "fail loudly" requirements, and they share one rationale.**
A silent cursor reset and a defaulted tenant both **convert a broken request into
a plausible-looking success**. In the tenant case the plausible success is a
**cross-tenant data leak** — what BC Map **§11.1** calls *"the single
highest-severity failure mode in the entire architecture."* See
[`OWNERSHIP_AND_DATA.md`](./OWNERSHIP_AND_DATA.md) §4.

⛔ And note the last row: you may **not** invent an error taxonomy. Use the
existing repository-wide conventions.

---

## 7. Self-check before shipping a failure path

1. **When the upstream is down, does my surface omit or truthfully relabel?** If
   it does anything else, it is non-conformant.
2. **Am I showing a zero?** A zero is a claim. ⛔ Prohibited.
3. **Am I showing a last-known / cached value?** That is a cached guess. ⛔
   Prohibited.
4. **Am I computing a substitute locally?** ⛔ Prohibited.
5. **Am I rendering a placeholder that looks like data** — a dash, a blurred
   number, a disabled control, "coming soon"? ⛔ Prohibited.
6. **When `BC-13` is down, does my UI say the report failed** — or does it imply
   it was received? Only the former is permitted.
7. **Am I queueing anything locally to retry later?** ⛔ Prohibited
   (`LMT-FR-025`).
8. **Am I building a C6-side fallback ordering?** That is the **withdrawn slot**.
   ⛔ Stop.
9. **Did I choose a timeout myself?** ⛔ Inherit the owner's obligation instead.
10. **Does a malformed cursor error, or silently reset?** It must error.
11. **Does a missing tenant context fail loudly, or default?** A default is a
    security defect.
12. **Am I adding a cache to smooth over upstream flakiness?** ⛔ Prohibited — and
    it is the mechanism by which every other prohibition here gets violated.

---

## 8. Open items in this area

| Item | Status | Owner |
|---|---|---|
| Numeric budgets for marketplace surfaces | ⛔ **Deliberately absent** — `LMT-XC-016`; ⚠ **disclosed as an absence, not satisfied** | The owner of each composed read |
| `LDR-FR-*` slot `023` — C6-side fallback ordering | ⛔ **WITHDRAWN by decision** — not open, and ⛔ not to be minted | — |
| `XPC-CONF-011` — offline booking via `E-24` | ✅ **RESOLVED by exclusion, not by an edge** | — |
| `TSF-GAP-009` — `BC-13` → `BC-19` referral transport; ADR **required, not written**; blocks `IMPL-1424` | **OPEN, INHERITED from `PRD-020`** | Architecture Owner with the `BC-19` owner |

⛔ **Stage 8 implementation has NOT been performed.** No failure path described
here has been built. **0** lines of application code exist for `PRD-021C`.
