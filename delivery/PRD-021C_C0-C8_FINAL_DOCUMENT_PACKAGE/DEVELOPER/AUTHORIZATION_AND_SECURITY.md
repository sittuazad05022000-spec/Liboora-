# AUTHORIZATION AND SECURITY — `PRD-021C` C0–C8

**Derived document.** ⛔ No authority. Authority: [`../PRD/`](../PRD/) (**FROZEN**) ·
**`Accepted`** ADRs in [`../ADR/`](../ADR/) · [`../ARCHITECTURE/`](../ARCHITECTURE/).

---

## 1. ⚠ Read this first — the marketplace defines no authorization model

There is no role table here, no permission list, no scope vocabulary and no
policy DSL — because the frozen specification deliberately defines none:

> **`LMT-XC-014`** — ⛔ No role, permission, scope, policy language or consent
> mechanism is defined. 📤 `BC-18` (**L127**).
>
> — C8 **§9.4**, **L441**

`BC-18` Authorization is the owner. C0 **§3.1** records the same in its ownership
matrix: the **authorisation decision** belongs to `BC-18` **only** (`X-13`).

**What this document does instead.** It states the **obligations any marketplace
surface must satisfy**, and it names the mistakes that are structurally available
to an implementer here. ⛔ It invents no model.

---

## 2. The authentication boundary

> **`LMT-FR-017`** — 📤 **DELEGATED — `LIB-DISC-005`/`006`/`008`**: public browsing
> requires no authentication; protected operations always require it; auth and
> registration are owned by Authentication. Every protected marketplace operation
> **MUST** be authorized **server-side** by a `BC-18` policy decision.
>
> — C8 **§9.4**, **L436**

Three separate rules are packed into that one requirement. Separated:

| # | Rule | Consequence |
|---|---|---|
| 1 | **Public browsing requires no authentication** | Discovery, search, and the public profile must work for an anonymous visitor. ⛔ Do not gate them behind a login. |
| 2 | **Protected operations always require it** | There is no "mostly protected". No unauthenticated path to a protected operation may exist. |
| 3 | **Auth and registration are owned by Authentication** | ⛔ Do not build a login screen, a session store, a password reset or a registration flow in the marketplace. |
| 4 | **Every protected operation authorized server-side by a `BC-18` policy decision** | See §3 — this is the rule most easily broken. |

⭐ The two halves must both hold at once. The marketplace is simultaneously an
**anonymous public surface** and a host for **protected operations**. A design
that makes everything public is wrong; a design that makes everything
authenticated is also wrong.

---

## 3. ⭐⭐ Server-side authorization, per request, per object

> **`LMT-FR-018`** — Object references in marketplace URLs and payloads **MUST** be
> authorized **per request** against the caller's policy decision, ⛔ **never
> inferred from possession of an identifier**.
>
> — C8 **§9.4**, **L444**

**This is the single most important sentence in this document.**

⛔ **Possession of an identifier is not authorization.** If a caller supplies a
library id, a booking id, a report id or a media `FileRef`, the fact that they
*have* it proves nothing. They may have guessed it, enumerated it, kept it from a
previous role, or received it from someone else.

**The forbidden reasoning, stated plainly so it is recognisable:**

| ⛔ Tempting inference | Why it is forbidden |
|---|---|
| "The id is a UUID, so it is unguessable, so possession is sufficient" | Unguessability is not authorization. `LMT-FR-018` says **never** inferred from possession — with no exception for opaque ids. |
| "They got this id from a page we already authorized, so it is fine" | The earlier authorization was for the earlier request. Authorization is **per request**. |
| "The client only shows buttons the user is allowed to press" | Client-side gating is not a `BC-18` policy decision. `LMT-FR-017` requires it **server-side**. |
| "The object is in their tenant, so they may act on it" | Tenant membership is isolation, not authorization. Both are required, separately. |
| "It's a read, not a write" | `LMT-FR-018` says *object references in marketplace URLs and payloads* — it does not exempt reads. |

**Positive form.** For every protected request: obtain a **`BC-18` policy
decision** for **this caller**, for **this object**, on **this request**, on the
**server**. Then act.

⭐ Note that `LMT-FR-017` and `LMT-FR-018` are both traced by **`LMT-AC-013`**
(C8 **L608**), alongside `LMT-XC-014` — so this obligation is a tested acceptance
criterion, not advice.

---

## 4. Tenant isolation is a security control, not a data-modelling concern

Full treatment is in [`OWNERSHIP_AND_DATA.md`](./OWNERSHIP_AND_DATA.md) **§4**.
It is cross-referenced here because it is the highest-severity item in this area.

The BC Map **§11.1** characterisation, quoted in C8 **§6**, is unambiguous: a
cross-tenant data leak via a capability context is

> *"the single highest-severity failure mode in the entire architecture."*

The controls that bear on security:

| Control | Requirement |
|---|---|
| **`LMT-FR-007`** | The `AR-3` classification is **MANDATORY per read** — every read declares whether it is over the untenanted public index or over tenanted operational rows |
| **`LMT-BR-007`** | ⛔ **MUST NOT** join the untenanted public index to tenanted operational rows in one query |
| **`LMT-FR-008`** | Tenant scope must not be leaked **by value or by inference** |
| **`LMT-BR-008`** / **`LMT-FR-009`** | A missing tenant context **MUST fail loudly** — ⛔ never default to a first, default or any tenant |
| **`LMT-XC-007`** | ⛔ Never pass a `StudentRecordId` into `BC-10`…`BC-17` |

⚠ **`LMT-FR-008` says "by inference", and that is deliberate.** Suppressing the
tenant id while leaking a count, an ordering position, an error message that
differs by tenant, or a timing difference is still a leak. Absence of the value
is not sufficient.

⚠ **`LMT-BR-007`'s forbidden join looks helpful.** It would let one query return a
public listing enriched with operational detail — which is exactly why it must be
recognised and refused rather than merely "avoided".

---

## 5. Security-relevant boundaries the marketplace must not cross

### 5.1 The safety boundary — report entered, never decided

C7's whole posture is integration over `BC-13`, and the boundary is one-way:

- ✅ The marketplace **enters** a report.
- ⛔ The marketplace **never decides** an outcome.
- ✅ It **renders** an enforcement consequence it learns from
  `safety.EnforcementActionTaken` over **`E-14`**.

⛔ Do not implement a local moderation decision, a local ban, a shadow-ban, a
local suppression rule or an automatic action derived from report volume. Those
are `BC-13`'s. See C7 **§4.4**, which covers authorization, isolation and
auditability together (**L334**).

⛔ And when `BC-13` is unavailable, **do not claim a case was opened**. See
[`ERROR_AND_FAILURE_HANDLING.md`](./ERROR_AND_FAILURE_HANDLING.md).

### 5.2 Rate limiting — required, but it must not identify the visitor

> **`LMT-FR-020`** — Public marketplace surfaces **MUST** be rate-limited **per
> origin** (`LIB-14B.41`); a short-lived anonymous session id **MAY** be used
> (`LIB-14B.6`); and the mechanism ⛔ **MUST NOT** identify the visitor
> (`LIB-14B.42`).
>
> — C8 **§9.6**, **L456**

> **`LMT-XC-015`** — ⛔ No rate-limit counter, bucket, store or evaluator is
> created. `RateLimitCounter` remains `BC-11`'s (BC Map **L377**). 🔗 C7
> `LTS-XC-005`.
>
> — C8 **L461**

⭐⭐ **This is a genuine tension and it is resolved in a specific direction.**
Rate limiting normally wants a stable identity for the caller; here it is
forbidden from having one. The resolution is: **per origin**, with an optional
**short-lived anonymous session id**, and the mechanism must not become a visitor
identifier.

⛔ Therefore: no persistent visitor cookie for rate-limiting purposes, no device
fingerprint, no IP-to-user correlation, no long-lived anonymous token. The
short-lived session id is *short-lived* as a control, in the same way `E-30`'s
payload boundary is minimal as a control.

⛔ And the counter itself is **`BC-11`'s** — do not build a bucket store.

This is traced by **`LMT-AC-014`** (C8 **L609**).

### 5.3 Media — references only

> **`LMT-FR-005`** — Marketplace surfaces **MUST** reference media by **`FileRef`**
> and **MUST NOT** hold bytes or a raw storage path (`E-22`, BC Map **L331**).
>
> — C8 **§5.3**, **L260**

> **`LMT-XC-005`** — ⛔ No second media store, transform pipeline, thumbnailer,
> virus scanner or URL signer. `BC-29` is *"the sole media infrastructure owner"*.

⛔ **Note that the URL signer is explicitly named.** Signing a media URL yourself
is a security-relevant act, and it belongs to `BC-29`. Likewise the virus
scanner — declining to implement it is correct here precisely because
implementing it would create a second, unowned control.

### 5.4 Configuration — typed accessors, no raw lookups

> **`LMT-FR-019`** — Tunable marketplace values **MUST** be read through typed
> accessors over **`E-19`** (`CF`, sync port); ⛔ *"no raw string lookups in domain
> code"* (BC Map **L328**). ⛔ No new configuration store or flag system.
>
> — C8 **§9.5**, **L450**

⛔ Do not read a secret, a limit or a toggle from an environment variable, an
inline constant, or a raw string key in domain code. ⛔ Do not add a feature-flag
service.

### 5.5 Opaque cursors — a boundary, not a convenience

C8 **§9.3** (**L428**) requires that cursors **not** expose ordering keys, DB ids,
offsets, table names or index structure, and that an expired or malformed cursor
**MUST** yield a domain error and ⛔ **never** a silent reset.

⭐ The first half is **information disclosure** control: a cursor that embeds a
primary key or a table name leaks internal structure to an anonymous caller. The
second half is **integrity**: a silent reset turns a tampered cursor into a
successful request, which is exactly the wrong signal.

> **`LMT-XC-013`** — ⛔ No offset pagination, page numbers, total-count guarantee
> or new pagination mechanism.
>
> — C8 **L431**

---

## 6. What is NOT specified, and who owns it

| Question | Owner | ⛔ Not decided in `PRD-021C` |
|---|---|---|
| Roles, permissions, scopes | **`BC-18`** (BC Map **L127**) | ✅ correct — `LMT-XC-014` |
| Consent mechanism | **`BC-18`** | ✅ correct — `LMT-XC-014` |
| Authentication, registration, password policy, session lifetime | **Authentication** | ✅ correct — `LMT-FR-017` |
| Encryption at rest / in transit, key management | Existing platform conventions | ⛔ not authored here |
| Rate-limit thresholds (the actual numbers) | **`BC-11`** | ⛔ `LMT-XC-016` forbids minting numbers |
| Media URL signing, virus scanning | **`BC-29`** | ✅ correct — `LMT-XC-005` |
| Moderation and enforcement decisions | **`BC-13`** | ✅ correct — C7 |
| Privacy questions arising from view data | ⚠ **Privacy Owner — VACANT** | See §7 |

⛔ **No numeric security budget is defined here**, because
**`LMT-XC-016`** forbids minting latency targets, percentile SLOs, payload caps,
cache TTLs and timeouts, on the recorded ground that *"a number invented in a
product part becomes an unowned obligation that no operator agreed to and no test
can justify."* That reasoning applies identically to an invented rate-limit
threshold or token lifetime.

---

## 7. ⚠⚠ One security-adjacent decision cannot currently be closed

**`XPC-OD-005`** is **OPEN** and **unclosable**, because the **Privacy Owner role
is VACANT** (`PRD_OWNERSHIP_MODEL.md` **L509**).

⭐ **The correct response to a vacant owner is to leave the decision open**, not
to decide it on the owner's behalf because it is blocking. Five sibling decisions
were closed by `ADR-0093`…`ADR-0097` when their owners were available; this one
was not, and that asymmetry is the evidence that the discipline was actually
applied rather than merely stated.

Six decisions remain **OPEN** overall: `XPC-OD-004`, `XPC-OD-005`, `XPC-OD-006`,
`XPC-OD-008`, `XPC-OD-009`, `XPC-OD-010`.

⛔ An implementer may not close any of them, and may not implement a behaviour
whose authorisation depends on one of them.

---

## 8. Self-check before shipping a protected surface

1. **Is this surface public or protected?** If protected, does *every* path to it
   require authentication — including any alternate route?
2. **Does the server obtain a `BC-18` policy decision for this caller, this
   object, this request?** If the answer involves "the client already checked",
   it is non-conformant.
3. **Am I inferring permission from possession of an identifier anywhere?** If
   yes, that is `LMT-FR-018`'s explicit prohibition.
4. **Does every read declare its `AR-3` classification?**
5. **Does any query join the untenanted public index to tenanted rows?** If yes,
   stop — `LMT-BR-007`.
6. **Does a missing tenant context fail loudly, or does something default?** A
   default is a defect.
7. **Does my rate limiting identify the visitor?** If it can be used to
   re-identify a returning anonymous visitor, it violates `LIB-14B.42`.
8. **Does a tampered or expired cursor silently reset?** It must error.
9. **Am I about to define a role, permission, scope or consent flow?** Stop —
   that is `BC-18`'s.

---

## 9. Open items in this area

| Item | Status | Owner |
|---|---|---|
| `XPC-OD-005` — privacy question | **OPEN — unclosable**, Privacy Owner **VACANT** (`PRD_OWNERSHIP_MODEL.md` **L509**) | Privacy Owner |
| `XPC-OD-004`, `XPC-OD-006`, `XPC-OD-008`, `XPC-OD-009`, `XPC-OD-010` | **OPEN** | Named per C0 §5 |
| `ADR-0088` / `ADR-0089` / `ADR-0090` — cited across the frozen parts but **not written** | **OPEN** | Architecture Owner |
| `TSF-GAP-009` — `BC-13` → `BC-19` referral transport; ADR **required, not written** | **OPEN, INHERITED** | Architecture Owner with `BC-19` owner |

⛔ **Stage 8 implementation has NOT been performed.** No authorization check
described here has been built. **0** lines of application code exist for
`PRD-021C`.
