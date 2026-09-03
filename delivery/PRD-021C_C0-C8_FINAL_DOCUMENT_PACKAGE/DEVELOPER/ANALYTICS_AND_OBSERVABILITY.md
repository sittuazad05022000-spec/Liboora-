# ANALYTICS AND OBSERVABILITY — `PRD-021C` C0–C8

**Derived document.** ⛔ No authority. Authority: [`../PRD/`](../PRD/) (**FROZEN**) ·
**`Accepted`** ADRs in [`../ADR/`](../ADR/) · [`../ARCHITECTURE/`](../ARCHITECTURE/).

---

## 1. ⭐⭐ Read this first — the marketplace computes no metric

> **`LMT-XC-018`** — ⛔ **No metric is defined, computed, certified, aggregated,
> projected or reported by C8.** 📤 `BC-26` is the **sole** analytics authority
> (**L135**, **L385**). ⭐ `ProfileViews` remains the only `CertifiedMetric`
> instance and **`UniqueViewers` remains NOT CERTIFIED** (`ADR-0097`) — ⛔ and
> **MUST NOT** be rendered as zero, unknown, a placeholder, *"coming soon"*,
> disabled, blurred, teased or estimated.
>
> — C8 **§11**, **L531**

Note the **six verbs**: *defined, computed, certified, aggregated, projected,
reported*. Every one is excluded. ⛔ A `COUNT(*)` in a marketplace query is an
aggregation. ⛔ A running total held in a view model is a computation. ⛔ A
derived percentage in a widget is a metric.

**`BC-26` is the sole analytics authority.** The marketplace **reads** a certified
metric; it does not produce one.

> **`LMT-XC-019`** — ⛔ No second analytics store, warehouse, event-tracking SDK,
> product-analytics tool or materialised view outside `BC-26`.
>
> — C8 **L538**

⚠ **"event-tracking SDK" is named explicitly.** Dropping in a third-party
analytics SDK is prohibited — not as a preference, but because it constitutes a
second analytics system with its own uncertified numbers.

---

## 2. ⭐⭐ The certified / not-certified split — the most important rule here

| Metric | Status | May it be shown? |
|---|---|---|
| `ProfileViews` | ✅ **`CertifiedMetric`** — the **only** instance | ✅ Yes, owner-only, as C3 specifies |
| `UniqueViewers` | ⛔ **NOT CERTIFIED** (`ADR-0097`) | ⛔ **No — in any form whatsoever** |

`ADR-0097` refused to certify `UniqueViewers`. `LMT-XC-018` then closes every
surrogate rendering, and the list is exhaustive by design:

| ⛔ Forbidden rendering of `UniqueViewers` | Why it is still forbidden |
|---|---|
| `0` | A number the architecture cannot produce, presented as fact |
| "Unknown" | Implies the metric exists but is unavailable now |
| A placeholder / dash / blank slot | Implies a value belongs there |
| *"Coming soon"* | A product promise for a metric nobody owns |
| A **disabled** control | Advertises a capability that does not exist |
| **Blurred** or **teased** | The classic upsell pattern — still asserts the metric is real |
| **Estimated** | ⭐ The worst case: an uncertified number wearing a hedge |

⭐⭐ **Why the list is this long.** Each entry is an implementation an engineer or
designer would reach for *in good faith* when a metric is missing. The frozen
text closes them all, so there is no "reasonable" fallback left. **The correct
rendering is absence** — the readout is simply not there.

C8 **§12** (**L562**) confirms the freeze reinforced this rather than relaxing it:

> | **`UniqueViewers` NOT CERTIFIED** and not renderable in any surrogate form |
> ✅ **Reinforced** — `LMT-XC-018`, `LMT-FR-024` |

⚠ And `LMT-FR-024` **strengthens** `ADR-0097`: it forbids exactly the
zero/unknown/placeholder renderings that would otherwise appear **when the
projection is unavailable**. See
[`ERROR_AND_FAILURE_HANDLING.md`](./ERROR_AND_FAILURE_HANDLING.md) §3.

---

## 3. Profile Views — the one analytics readout, and its constraints

C8 **§12** (**L554**) preserves C3's Profile Views compatibility item by item:

| Property | C8 treatment |
|---|---|
| `E-30` unchanged | ✅ Unchanged |
| `E-30` payload ⛔ unextended | ✅ Unchanged — **`LMT-XC-010`** |
| `BC-26` is the sole analytics authority | ✅ Unchanged — **`LMT-XC-018`** (**L560**) |
| `ProfileViews` the only `CertifiedMetric` | ✅ Unchanged |
| `UniqueViewers` NOT CERTIFIED, no surrogate form | ✅ **Reinforced** (**L562**) |
| `BC-19` gains no analytics capability | ✅ Unchanged |
| `PRD-009` remains `PLANNED` | ✅ Unchanged |

**How the fact reaches analytics:**

`BC-19` produces `tenancy.LibraryProfileViewed` → **`E-30`** → `BC-26`, which
projects `ProfileViews`. The marketplace **reads** that projection for the
library **owner only**.

### 3.1 ⛔ The payload boundary is the privacy control

> **`LMT-XC-010`** — ⛔ No extension of `E-30`'s payload. ⭐⭐ **The payload boundary
> IS the privacy control** (§17.2.1) — it carries the subject library and the
> occurrence time and ⛔ **no viewer identity in any form**.
>
> — C8 **L361**

⭐⭐ **This is the mechanism, and it is worth understanding rather than merely
obeying.** `UniqueViewers` is uncertified *and* uncomputable, because the only
event about a profile view **identifies nobody**. `ADR-0096` §4.2 built it that
way deliberately.

⛔ Therefore adding a viewer id, session id, hashed visitor token, IP or device
fingerprint to `E-30` does not "improve analytics" — it **removes the privacy
control** and manufactures the very input `ADR-0097` refused to certify. It would
also open personalised ranking, which C6 **§2.2** forecloses on exactly this
ground. See
[`SEARCH_RANKING_AND_DISCOVERY.md`](./SEARCH_RANKING_AND_DISCOVERY.md) §3.6.

---

## 4. Telemetry — use the existing port, add no stack

> **`LMT-FR-026`** — Marketplace telemetry **MUST** use the
> `platform/observability:telemetry` port both `domain/library` and `app` already
> declare. ⛔ No new observability stack, log store, tracing system or dashboard
> platform.
>
> — C8 **§11**, **L526**

✅ **Do:** emit through the declared `platform/observability:telemetry` port.

⛔ **Do not:** add a log aggregator, a tracing backend, a metrics scraper, a
dashboarding tool, or a second logging library.

⭐ **Telemetry is not analytics, and the distinction is load-bearing.** Telemetry
is operational instrumentation over an existing port. Analytics is a **certified
business metric** owned by `BC-26`. ⛔ Using the telemetry port to compute and
report a business metric would evade `LMT-XC-018` — the port is not a loophole.

---

## 5. Audit — fire-and-forget, and one prohibition that surprises people

From C8 **§11** (**L541**–**L545**):

> **Audit.** 📤 **`E-20`** — `PL`, Event, **fire-and-forget, outbox-backed**;
> *"Domain never calls audit synchronously"* (**L329**). ⛔ No audit entry for an
> anonymous public view, because `AuditEntry` requires an *"actor of record"*
> (**L384**) — 🔗 C7 `LTS-BR-007`, and the same determination `ADR-0096` made.
> ⛔ No second audit store.

| Rule | Requirement |
|---|---|
| Transport | **`E-20`**, wildcard source, **fire-and-forget**, **outbox-backed** |
| ⛔ Prohibition | *"Domain never calls audit synchronously"* (BC Map **L329**) |
| ⛔ Prohibition | **No audit entry for an anonymous public view** |
| Reason | `AuditEntry` **requires an "actor of record"** (BC Map **L384**) |
| ⛔ Prohibition | No second audit store |

### 5.1 ⚠⚠ Why an anonymous public view is not audited

This is counter-intuitive: auditing *more* usually seems safer. It is prohibited
here for a **structural** reason, not a policy one.

`AuditEntry` is scoped **per actor of record** — C8 **§5.2** records exactly that
in its ownership row (**L244**): *"Per actor of record (**L384**)"*. An anonymous
public visitor **is not an actor of record**. So there is no lawful subject for
the entry.

⛔ **The tempting workaround is the defect.** Synthesising an actor — a
pseudonymous id, a session token, a hashed IP, an `"anonymous"` sentinel — in
order to satisfy the audit schema would:

1. Create an identity the architecture deliberately refused to create;
2. Reintroduce the viewer identity that `LMT-XC-010` excludes from `E-30`;
3. Make `UniqueViewers` computable from the audit log, defeating `ADR-0097`.

⭐ C8 notes this is *"the same determination `ADR-0096` made"* and links C7's
`LTS-BR-007` — **three** independent places reach the same conclusion. That
convergence is the evidence it was reasoned rather than assumed.

✅ **Correct behaviour:** the anonymous public view produces the `E-30` fact
(carrying library + time, no identity) and **no audit entry**.

---

## 6. ⛔ The closing exclusion — no second system of any kind

> **`LMT-XC-020`** — ⛔ **No second search, media, analytics, audit, authorization,
> safety, configuration or job system exists after this part.** ⭐ This is the
> single sentence the instruction's *"do NOT invent infrastructure"* reduces to,
> and §0.2 measures it at **0** across every class.
>
> — C8 **L547**

The eight systems, with their owners:

| System | Sole owner |
|---|---|
| Search | `BC-23` |
| Media | `BC-29` |
| Analytics | `BC-26` |
| Audit | `BC-24` |
| Authorization | `BC-18` |
| Safety | `BC-13` |
| Configuration | via **`E-19`** |
| Jobs | `platform/services:job_runtime` (`ADR-0058`) |

⭐ C8 **§0.2** measures the result across fifteen classes and every one is **0** —
including **0** metrics, **0** caches, **0** indexes, **0** queues, **0**
infrastructure components.

This whole area is traced by **`LMT-AC-016`** (C8 **L611**), which bundles
`LMT-XC-010`, `LMT-XC-018`, `LMT-XC-019`, `LMT-XC-020`, `LMT-XC-016` and
`LMT-XC-017` into one acceptance criterion — so *"we added no second system"* is
a **testable** claim, not a stylistic one. See
[`TESTING_REQUIREMENTS.md`](./TESTING_REQUIREMENTS.md).

---

## 7. ⛔ No numeric budget, and therefore no SLO dashboard

> **`LMT-XC-016`** — ⛔ no latency target, throughput figure, percentile SLO,
> payload cap, cache TTL or timeout is minted.

The recorded ground, from C8's own summary:

> *"a number invented in a product part becomes an unowned obligation that no
> operator agreed to and no test can justify"*

⛔ So there is no marketplace latency SLO to instrument against, and building a
dashboard around an invented threshold would create precisely that unowned
obligation. **`LMT-FR-021`** instead **inherits each owner's** existing
obligation.

⛔ **`LMT-XC-017`** additionally refuses a cache tier — because the public
discovery index **already is** the read-optimised representation, and a cache in
front of a projection would create a **second derived copy with its own staleness
and no owner.** ⭐ That is an observability argument as much as a performance one:
an unowned derived copy has no one accountable for its correctness.

---

## 8. Self-check before shipping anything analytics-adjacent

1. **Am I computing, counting, aggregating or averaging anything for display?**
   If yes — stop. That is a metric, and `BC-26` owns metrics.
2. **Am I adding an analytics or event-tracking SDK?** ⛔ Prohibited
   (`LMT-XC-019`).
3. **Am I rendering `UniqueViewers` in any form** — including zero, unknown, a
   dash, "coming soon", a disabled toggle, a blur or an estimate? ⛔ All
   prohibited. **Absence is the correct rendering.**
4. **Am I adding a field to `E-30`?** Stop — the payload boundary *is* the privacy
   control.
5. **Am I writing an audit entry for an anonymous public view?** ⛔ Prohibited —
   there is no actor of record.
6. **Am I synthesising an actor id to satisfy an audit schema?** ⛔ That is the
   defect, not the fix.
7. **Am I calling audit synchronously?** ⛔ Prohibited — `E-20` is
   fire-and-forget, outbox-backed.
8. **Am I standing up a log store, tracing system or dashboard?** ⛔ Prohibited —
   use the declared telemetry port.
9. **Am I instrumenting against a latency number I chose myself?** ⛔ That number
   does not exist (`LMT-XC-016`).
10. **Am I adding a materialised view or cache in front of the index?** ⛔
    Prohibited (`LMT-XC-019`, `LMT-XC-017`).

---

## 9. Open items in this area

| Item | Status | Owner |
|---|---|---|
| **`PRD-009`** — `BC-26` Analytics owner — `PLANNED`, **absent from disk** (`PRD_REGISTRY.md` **L246**) | **OPEN upstream** | Product / Architecture Owner |
| `GAP-BCMAP-BC26-EDGES` — `BC-26` appears as *"Primary consumer"* in ~20 §9 rows while §7 declares no inbound edge besides `E-26` | **OPEN, INHERITED** — ⛔ `LMT-BR-010` forbids relying on any undeclared path | **Architecture Owner** |
| `UniqueViewers` certification | ⛔ **REFUSED** by `ADR-0097` — not open, decided | — |
| `XPC-OD-005` — privacy question bearing on view data | **OPEN — unclosable**, Privacy Owner **VACANT** (`PRD_OWNERSHIP_MODEL.md` **L509**) | Privacy Owner |

⭐ Note the discipline in row 2 once more: an apparent licence existed (~20 rows
naming `BC-26` as primary consumer) and **`ADR-0096` declined to use it**,
minting `E-30` explicitly instead. ⛔ Do not resolve this gap in code.

⛔ **Stage 8 implementation has NOT been performed.** No analytics readout or
telemetry described here has been built. **0** lines of application code exist
for `PRD-021C`.
