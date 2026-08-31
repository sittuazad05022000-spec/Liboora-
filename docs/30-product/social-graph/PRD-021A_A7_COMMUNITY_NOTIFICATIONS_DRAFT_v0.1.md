<!--
  PROVENANCE
  ==========
  Document      : PRD-021A Part A7 — Community Notifications
  Status        : DRAFT — v0.1
  Freeze status : NOT FROZEN. NOT FINAL. NOT APPROVED. NOT BASELINED.
  Lifecycle     : No stage advanced. Stage 3 is NOT CONFERRED for any part.
  Authorization : Product Owner decision D-A authorized PRD-021A as the
                  product decomposition of BC-15 Community & Groups (V2).
                  A SUBSEQUENT Product Owner instruction authorized A6, A7
                  and A8 as PARTS OF PRD-021A, expressly stating they are
                  "NOT permission to create competing standalone PRDs for
                  BC-13, BC-22, or the platform architecture." See 0.4.

  WHAT THIS DOCUMENT IS
  ---------------------
  An INTEGRATION CONTRACT defining the community-domain FACTS that BC-15
  publishes, and nothing about how they are delivered. It is NOT a
  notification system and NOT a substitute for PRD-010.

  THE CENTRAL MEASURED FINDING OF THIS PART
  -----------------------------------------
  E-23 (BC Map L332) reads: "All contexts | BC-22 Notification Delivery |
  PL | Event | Domain emits *facts* (MembershipExpiringSoon), never
  'send an SMS'".

  CONSEQUENCE — and it is the OPPOSITE of A6's:
    - "All contexts" ALREADY INCLUDES BC-15. A7 therefore requires
      NO NEW EDGE and is NOT self-blocked on an edge.
    - But E-23's contract is strict about SHAPE: a fact, never a command.
      A7's entire discipline is derived from that one clause.

  A SECOND MEASURED FINDING, DISCLOSED NOT WORKED AROUND
  ------------------------------------------------------
  PRD-010 Notifications & Communication is PLANNED and DOES NOT EXIST.
  Measured: PRD_REGISTRY.md L247 lists it PLANNED; `find docs -iname
  "*notification*"` returns only an authentication-domain file and an
  archived empty slot. There is NO BC-22 PRD to integrate against.

  Therefore A7 integrates against the BC MAP (Rank 4) directly, and every
  place where a BC-22 behaviour would need to be known is recorded as a
  DELEGATION TO AN UNWRITTEN PRD — routed, not invented.

  WHAT THIS DOCUMENT DOES NOT DO
  ------------------------------
    - does NOT own channel selection, templates, quiet hours, consent,
      unsubscribe, deduplication, delivery guarantees or the notification
      inbox. All BC-22's (BC Map L131)
    - does NOT create PRD-010, or act as PRD-010
    - does NOT create an aggregate, bounded context, edge, permission,
      role, module or delivery policy
    - does NOT state a channel, a template, a quiet-hours window, a retry
      count, a backoff value, a fan-out limit or any numeric value
    - does NOT take a Product Owner, Architecture Owner, Governance Owner
      or Privacy Owner decision
-->

# PRD-021A — Part A7

## Community Notifications

### Specification v0.1 — DRAFT

> ⚠ **DRAFT — NOT FROZEN, NOT FINAL, NOT BASELINED.** Publication is a
> **filing act**: it confers no lifecycle stage, ratifies no identifier, and
> closes no gap.
>
> ⛔ **This part owns no notification capability.** `BC-22` Notification
> Delivery owns *"channel selection, templates, deduplication, quiet hours,
> delivery guarantees, consent/unsubscribe"* (BC Map **L131**). A7 owns only
> the **community-domain facts**.
>
> ⭐ **A7 requires NO new bounded-context edge.** `E-23` is *"All contexts →
> `BC-22`"* and already covers `BC-15` — §2.3.
>
> ⛔ **`PRD-010` does not exist.** A7 integrates against Rank 4 directly and
> routes every unwritten `BC-22` behaviour — §2.4.

---

## 0. Document control

| Field | Value |
|---|---|
| **Part** | `PRD-021A` A7 |
| **Title** | Community Notifications |
| **Version** | v0.1 |
| **Status** | **DRAFT** — not baselined, not approved, not frozen |
| **Authorization** | Product Owner instruction authorizing A7 as a **part of `PRD-021A`** — §0.4 |
| **Predecessors read** | A1 v0.2, A2 v0.8, A3 v0.6, A4 v0.1, A5 v0.1, **A6 v0.1** (all DRAFT) |
| **Authorities read** | BC Map v1.8 (**L131**, **L205**, **L332**, **L402**, **L405–436**), `MASTER_PRD.md`, Module Dependency Matrix, `PRD_REGISTRY.md` **L247**, `PRD_LIFECYCLE.md`, `PRD_OWNERSHIP_MODEL.md`, `PRD-020` v0.5, `ADR-0001`, `ADR-0078`, `ADR-0080`, `ADR-0082` |
| **Identifier prefix** | `LCN-` — **PROPOSED, NOT REGISTERED.** Collision-measured: **0** occurrences across `docs/`, `lib/`, `test/`, `tool/`. Registration is a Governance Owner act (`PRD_LIFECYCLE.md` §5 rule 3) — **not exercised here** |
| **Bounded context** | `BC-15` Community & Groups — `[SUPPORTING]`, **V2**, BC Map **L119** |
| **Integrates with** | `BC-22` `[GENERIC]` V1 (**L131**) over **`E-23`** (**L332**) |
| **Edges created** | **ZERO — and zero required.** ⭐ §2.3 |
| **Aggregates created** | **ZERO** |
| **Events defined** | **7 candidate facts** — §3. ⛔ **PROPOSED, unregistered**; BC Map §9 is a Rank 4 register and A7 amends nothing |
| **ADRs minted** | **ZERO.** Next free remains `ADR-0083` |
| **Channels / templates / policies defined** | **ZERO** |
| **Numeric values stated** | **ZERO** |

### 0.1 Normative language

`SHALL` / `SHALL NOT` bind any implementation **of this part**, subject to §0.3.
`MAY` is permissive.

⚠ **Unlike A6, A7 contains no edge-based self-blocking clause, because no edge
is missing.** A7's gating is of a different kind and is stated honestly in §0.3:
its facts describe objects whose *existence* is still open.

### 0.2 What this document is not

Not `PRD-010`. Not a notification service. Not a delivery policy. Not an
architecture amendment. It is a **producer-side integration contract**.

### 0.3 Standing conditions

| Condition | Source | State |
|---|---|---|
| `PRD-010` / `BC-22` PRD does not exist | `PRD_REGISTRY.md` **L247** `PLANNED` | ⛔ **OPEN** — §2.4 |
| Stage 3 not conferred for `PRD-021A` | Stage-3 record + re-run | ⛔ OPEN |
| `BC-15` publishes **zero** registered events today | BC Map §9 scan — **0** rows with `BC-15` as producer | ⛔ **A7's facts are unregistered** — §3.6 |
| A2 content objects are DRAFT | A2 v0.8 | Facts about posts/comments inherit that condition |
| A4 groups/roles is a **CANDIDATE** | A4 `LCG-DEC-001` | ⛔ Group facts (§9) gated |
| A5 existence is open | A5 `LCO-DEC-001` / A3 `LCR-DEC-006` | ⛔ Official-communication facts (§7) gated |
| A6 reporting is self-blocked | A6 `LCS-ADR-001` | ⛔ Moderation facts (§8) constrained |
| `BC-15` release band | **V2**, unchanged | **UNCHANGED** |

### 0.4 ⭐ The authorization, and the refusal it overrides

`PRD_REGISTRY.md` **§11.4 L758** records, from `D-A`:

> | **A7** | Community notifications | ⛔ **NO STANDALONE PRD — NOT AUTHORIZED** | **`BC-22` Notification Delivery / `PRD-010`.** BC Map **L332** `E-23` routes *all contexts* to `BC-22`. ⛔ **A7 not created. `PRD-010` NOT created** |

The Product Owner has since authorized A7 **as a part of `PRD-021A`**.

⭐ **The two are compatible, and note what the refusal actually reasoned.** It
refused a standalone PRD *because `E-23` already routes all contexts to
`BC-22`* — i.e. because **delivery is already owned**. A7 accepts that reasoning
completely: it claims no delivery behaviour. It specifies only the **producer
side** of an edge the refusal itself cites as existing.

⛔ **`PRD-010` is still NOT created by this part.** It remains `PLANNED` at
registry §4.1. A7 is not a substitute for it, and §2.4 records exactly what
remains unspecifiable in its absence.

⚠ **Disclosed:** as with A6, §11.4's verification line is now falsified.
Recorded at A6 `LCS-GAP-001`, **Governance Owner**. A7 does not edit the
registry either, and does not duplicate that gap.

---

## 1. Executive summary

Community activity generates notifiable moments: someone comments on your post,
a moderator restricts your content, a library posts an official communication.
`BC-22` already owns every question of *how* a person is reached.

A7 therefore specifies **one thing**: the set of community-domain **facts**
`BC-15` publishes, and their payload discipline, so `BC-22` can decide delivery
without `BC-15` knowing anything about channels.

**Four measured facts govern this part.**

| # | Fact | Measured at | Consequence |
|---|---|---|---|
| **A7-F1** | `E-23` = *"**All contexts** → `BC-22`"*, `PL`, Event | BC Map **L332** | ✅ **`BC-15` is already a lawful producer. NO new edge.** §2.3 |
| **A7-F2** | `E-23`'s contract: *"Domain emits **facts** … never 'send an SMS'"* | BC Map **L332** | ⭐ Shapes every requirement — §4 |
| **A7-F3** | `BC-22` owns channels, templates, dedup, quiet hours, delivery guarantees, consent/unsubscribe | BC Map **L131** | **All eight delegated** — §§12–19 |
| **A7-F4** | ⛔ `PRD-010` **does not exist** | `PRD_REGISTRY.md` **L247**; filesystem scan | Delegations point at an **unwritten** PRD — §2.4 |

⭐ **A7-F1 versus A6's finding is the structural contrast of this pass.** A6
needed an edge into `BC-13` and found **zero** inbound edges → self-blocked. A7
needed an edge into `BC-22` and found *"All contexts"* → **unblocked**. Both
results come from the same measurement performed on the same table, and the
difference is why A7 is materially more implementable than A6.

### 1.1 Ownership disposition summary

| Class | Count |
|---|---|
| **OWNED BY `PRD-021A`** | **5** — the fact set, payload shape, emission points, idempotency keys, producer-side isolation |
| **INTEGRATION WITH EXISTING CONTEXT** | **4** — `E-23` contract, `E-20` audit, `E-19` config, `E-14`-derived moderation facts |
| **DELEGATED TO EXISTING CONTEXT** | **11** — the eight `BC-22` capabilities plus inbox, reference model, observability of delivery |
| **OPEN OWNER DECISION** | **5** |
| **FUTURE / V2 SCALE** | **3** |

⛔ **No integration dependency is converted into ownership.** §24 re-audits.

---

## 2. Problem statement

### 2.1 What is being asked

Community events should reach people. Without notifications a feed is inert:
nobody returns to a comment they cannot know exists.

### 2.2 Why the naive answer is wrong

| Naive move | Fails against | Measured |
|---|---|---|
| A `BC-15` notification module | `ADR-0001`; Matrix module tree | No `BC-15` module exists at all (Matrix **L480–483**); inventing a *notification* one is doubly unauthorised |
| `BC-15` picks email vs push | BC Map **L131** | `BC-22` *"owns channel selection"* |
| `BC-15` emits `SendCommentEmail` | BC Map **L402** | ⛔ *"An event named as an imperative (`SendReminder`) is a **command**, belongs to Workflow, and **must not enter the event bus** as a domain event"* |
| `BC-15` suppresses at night | BC Map **L131** | `BC-22` owns quiet hours |
| `BC-15` de-duplicates | BC Map **L131** | `BC-22` owns deduplication |
| `BC-15` holds an inbox | BC Map **L205** | `FeedItem` is *"owned by `BC-22`'s inbox projection"* |

⭐ **The last row is the subtlest and most valuable.** BC Map **L205**
distinguishes a `BC-22` `DeliveryMessage` from an in-app feed item and assigns
the latter to *"`BC-22`'s inbox projection"*. So even the **in-app** notification
list is `BC-22`'s — not `BC-15`'s, and not A2's feed. A7 must not build one.

### 2.3 ⭐ The edge — measured, and it EXISTS

**Live BC Map §7:**

```
E-23 | All contexts | BC-22 Notification Delivery | PL | Event |
     "Domain emits *facts* (MembershipExpiringSoon), never 'send an SMS'"
```

*"All contexts"* is unqualified. It is the same construction `E-18` (`BC-19`
tenancy), `E-19` (`BC-25` config) and `E-20` (`BC-24` audit) use, and A2/A3
already rely on those for `BC-15` without raising an edge request.

✅ **Therefore no `LCN-ADR-*` for an edge is raised, and none is needed.**

⚠ **What "no edge needed" does NOT mean — stated because the distinction is
exactly the one the Stage-3 record insists on.** It does **not** mean `BC-15`'s
*events* are registered. `E-23` authorises the **transport**; BC Map **§9**
(**L405–436**) is the **event register**, and a live scan finds **zero** rows
with `BC-15` as producer. The seven facts in §3 are therefore **proposed,
unregistered** facts travelling over a **registered** edge. §3.6 routes their
registration.

⭐ **This is the same "lawful-as-written versus formally registered"
distinction** the Stage-3 re-run applied to `BC-15 → BC-11`. A7 states it in its
own terms rather than letting a reader assume registration follows from
transport.

### 2.4 ⛔ `PRD-010` does not exist — and what that costs

**Measured:**

```
PRD_REGISTRY.md L247:
| PRD-010 | Notifications & Communication | BC-22 Notification Delivery
| [GENERIC] | V1 | PLANNED | Every event-driven notice |

registry L546: PLANNED — 7 — ... PRD-010 ...
registry L548: Missing V1 PRDs — 9 — ... PRD-010 ...

find docs -iname "*notification*" →
  docs/30-product/authentication/prd-v2/10-Events-Audit-and-Notifications.md
  docs/90-archive/authentication-v1/empty-slots/09-Events-Audit-Notifications.md
  (neither is a BC-22 PRD)
```

⛔ **There is no `BC-22` specification to integrate against.** The Product
Owner's instruction says *"`PRD-010` when/where applicable"* — measured, it is
**not yet applicable**, because it does not exist.

**Consequences, each recorded rather than papered over:**

| What A7 cannot know | Effect |
|---|---|
| The `BC-22` event-payload contract | A7 specifies payloads from **`E-23`'s own clause** + the BC Map §9 naming convention, and marks them **provisional** — `LCN-GAP-001` |
| Preference model shape | A7 delegates *by name* and cannot cite a requirement — `LCN-GAP-002` |
| Whether `BC-22` de-duplicates on producer key or its own | A7 supplies an idempotency key and delegates the policy — §15, `LCN-GAP-003` |
| Delivery-failure semantics visible to producers | A7 specifies producer-side fire-and-forget only — §18 |
| Inbox reference model | A7 specifies a **reference**, not a rendering — §14, `LCN-GAP-004` |

⭐ **A7 is written so that `PRD-010`, when authored, can contradict its
provisional payload assumptions without invalidating A7's structure** — because
A7 owns only the *fact set*, and the fact set is derived from `BC-15`'s domain,
not from `BC-22`'s interface.

---

## 3. Notification event sources — OWNED (fact set)

**Classification: OWNED BY `PRD-021A`.** Which community facts exist is
`BC-15`'s domain knowledge. Nothing about delivery is claimed.

### 3.1 The naming rule A7 obeys

BC Map **L402**, *binding*:

> `<Context>.<Aggregate><PastTenseVerb>` — *"Events are facts about the past. An
> event named as an imperative (`SendReminder`) is a **command** … and must not
> enter the event bus as a domain event."*

`LCN-FR-001` | Every A7 fact **SHALL** be named
`community.<Aggregate><PastTenseVerb>` and **SHALL** be a statement about the
past. ⛔ No imperative. No `Send*`, `Notify*`, `Alert*` or `Remind*`.

⚠ **Context token disclosed as provisional.** A7 uses `community.` by analogy
with `membership.`, `safety.`, `messaging.` in BC Map §9. ⛔ The token for
`BC-15` is **not registered anywhere** — measured: `BC-15` has no §9 row.
Recorded as `LCN-GAP-005`, **Architecture Owner** (jointly with the A2/A8
author, since A2 also emits content events).

### 3.2 The seven candidate facts

⛔ **Deliberately minimal.** The Product Owner's instruction says *"Do not
create unnecessary events."* Each row states why it cannot be derived from
another.

| # | Fact | Why it must exist separately | Gated on |
|---|---|---|---|
| `LCN-EVT-001` | `community.PostPublished` | The root activity fact. Everything else references a post | A2 |
| `LCN-EVT-002` | `community.CommentAdded` | Distinct audience (post author + thread), distinct from a post's audience | A2 |
| `LCN-EVT-003` | `community.ReactionAdded` | Distinct audience (author only) and the highest-volume, most aggregation-prone fact — §21 | A2 |
| `LCN-EVT-004` | `community.MembershipChanged` | Membership transitions are A1's; the *fact* that one occurred is notifiable | A1 |
| `LCN-EVT-005` | `community.ContentEligibilityChanged` | ⭐ Derived from A6 §9. Carries **no** moderation detail — §8 | A6 |
| `LCN-EVT-006` | `community.OfficialCommunicationPublished` | A5's subject matter; audience is community-wide, unlike `001` | ⛔ A5 open |
| `LCN-EVT-007` | `community.HelpRequestAnswered` | A3's helpfulness domain (`LCR-BR-010`); distinct from a plain comment | ⛔ A3 `LCR-DEC-009` |

`LCN-FR-002` | ⛔ A7 **SHALL NOT** define a fact for: a channel, a delivery
attempt, a read receipt, a preference change, a digest, or any `BC-22` internal
state.

`LCN-FR-003` | ⛔ A7 **SHALL NOT** define a *"community.NotificationSent"* fact
of any kind. Delivery is not a `BC-15` fact and `BC-15` cannot know it.

### 3.3 Per-fact contract

Per the Product Owner's events instruction, each fact carries **owner, producer,
consumer, payload, version, idempotency, retry, ordering**.

| Attribute | Value — uniform across all seven |
|---|---|
| **Owner** | `BC-15` (the **fact**). ⛔ The **notification** is `BC-22`'s |
| **Producer** | `BC-15` only |
| **Primary consumer** | `BC-22` over `E-23`. Secondary: `BC-24` over `E-20` |
| **Payload** | §16 — minimal, reference-based, no content bodies |
| **Version** | `v1` at introduction; §22 governs evolution |
| **Idempotency** | Producer-supplied key — §17 |
| **Retry** | Transactional outbox, at-least-once — §18 |
| **Ordering** | ⛔ **Not guaranteed.** Consumers **SHALL NOT** assume it — §17 |

### 3.4 What A7 does NOT list as consumers

`LCN-FR-004` | A7 **SHALL NOT** name `BC-23` Search, `BC-26` Analytics or
`BC-27` AI as consumers of its facts. Measured: `E-21` (`BC-23`) lists producers
`BC-01`, `BC-10` only; `E-26` targets `BC-26`/`BC-23` from `BC-27`. ⛔ Naming a
consumer the map does not authorise would invent an edge.

### 3.5 Volume asymmetry, disclosed

⚠ `LCN-EVT-003` (reactions) will exceed the other six combined by orders of
magnitude on any active community. Aggregation is the obvious mitigation — and
aggregation is **deduplication**, which BC Map **L131** assigns to `BC-22`.
⛔ **A7 does not aggregate.** §21 records the producer-side limit question and
routes it.

### 3.6 ⛔ Registration status

`LCN-FR-005` | These seven facts are **PROPOSED, NOT REGISTERED**. BC Map §9 is
the Rank 4 event register and A7 **SHALL NOT** amend it. Registration is an
**Architecture Owner** act — `LCN-ADR-001` (§25).

⭐ **A7 therefore does not claim its events exist as registered platform
events.** It claims they are the correct fact set for `BC-15` and requests
registration. Same discipline as A2's `LCF-ADR-*` rows.

---

## 4. The `E-23` integration contract — INTEGRATION

`LCN-FR-006` | `BC-15` **SHALL** publish facts to `BC-22` over `E-23` only.
⛔ No direct call, no synchronous port, no shared table.

`LCN-FR-007` | `BC-15` **SHALL NOT** express delivery intent. It states what
happened; `BC-22` decides whether, how and when anyone is told.

`LCN-FR-008` | `BC-15` **SHALL NOT** receive, read or infer delivery outcome.
⛔ No inbound path from `BC-22` exists — measured: **zero** BC Map §7 rows list
`BC-22` as a source.

⭐ **`BC-22` is a sink, exactly as `BC-24` is.** This is why §18's failure model
is producer-side only, and it is a structural fact rather than a simplification.

`LCN-FR-009` | Publication **SHALL** be through the transactional outbox, in the
same transaction as the state change the fact describes.

`LCN-FR-010` | Publication **SHALL NOT** be on the request's critical path.
`E-23` is `PL` (Published Language), asynchronous.

---

## 5. Community post notifications

`LCN-FR-011` | `community.PostPublished` **SHALL** be emitted when a post
reaches `PUBLISHED` — never on draft, and never while attachment references are
unresolved (A2 `LCF-FR-032`).

`LCN-FR-012` | The fact **SHALL** carry the community reference, post reference
and author reference. ⛔ **Not** the body, title, excerpt or attachment.

`LCN-FR-013` | ⛔ A7 **SHALL NOT** determine *who* is notified. Audience
resolution from a community reference is a **preference and subscription**
concern, and BC Map **L131** gives consent/preference to `BC-22`.

⚠ **A genuine gap, disclosed rather than assumed away.** `BC-22` cannot resolve
*"members of community X"* — that is A1 membership data in the Global band, and
`BC-22` sits in the Communication platform. Neither side can currently do it
alone. ⛔ **A7 does not solve it.** `LCN-GAP-006`, **Architecture Owner**, with
two shapes **named, not chosen**: (a) `BC-15` includes an audience reference and
`BC-22` resolves it over a path that must be established; (b) `BC-15` emits
per-recipient facts, which multiplies volume (§21). ⭐ Naming both without
ranking one follows the `PRD-020` §10.1 discipline.

`LCN-FR-014` | A post that is `WITHHELD` or `RESTRICTED` (A6 §9) **SHALL NOT**
produce a notification fact.

---

## 6. Comment / reply notifications

`LCN-FR-015` | `community.CommentAdded` **SHALL** be emitted on a published
comment, carrying community, post, comment and author references.

`LCN-FR-016` | ⛔ The comment body **SHALL NOT** be in the payload. Templating
is `BC-22`'s (**L131**), and a body in an event payload becomes an
unmoderatable copy outside `BC-15`'s eligibility control.

⭐ **That second reason is the load-bearing one.** If a comment body travels in
the payload and is later restricted (A6 §12), the copy inside `BC-22` cannot be
retracted by `BC-15`. Reference-only payloads make A6's restriction cascade
**enforceable**; content-bearing payloads would silently break it.

`LCN-FR-017` | Reply threading **SHALL** be expressed by reference to the parent
comment. ⛔ A7 defines no thread-depth rule — A2's.

`LCN-FR-018` | ⛔ A7 **SHALL NOT** suppress self-notification (author commenting
on their own post). ⚠ It looks like A7's job, but suppression is a **preference**
decision, `BC-22`'s per **L131**. Recorded as an integration expectation only,
with **no requirement written**.

---

## 7. Help-related and official-communication notifications

`LCN-FR-019` | `community.HelpRequestAnswered` **SHALL** be emitted when a
contribution is designated helpful, per A3's `HELPFUL` designation
(`LCR-BR-010`, `LCR-BR-010a`).

> ⛔ **Gated.** A3's `LCR-DEC-009` (helpfulness weight) is **REFUSED and still
> open**, and `LCR-RS-003` stays `ELIGIBLE` at weight **0**. **Until the Product
> Owner resolves `LCR-DEC-009`, `LCN-EVT-007` SHALL be treated as blocked.**
> ⛔ A7 does **not** resolve it and states **no** weight.

`LCN-FR-020` | `community.OfficialCommunicationPublished` **SHALL** be emitted
when A5 subject matter is published.

> ⛔ **Gated twice over.** A5's own existence is open (`LCO-DEC-001`) **and** its
> subject matter is gated on A3 `LCR-DEC-006`. **Until both resolve,
> `LCN-EVT-006` SHALL be treated as blocked.** ⚠ Additionally, `PRD-020`
> `TSF-XC-034` refused *"Library official post"* as a reportable type *"for want
> of a subject"* (`TSF-GAP-010`) — so an official communication is currently
> **notifiable-but-unreportable**, which A6 `LCS-EDGE-009` also records.
> ⛔ **Not resolved here.** `LCN-GAP-007`, **Product Owner**.

`LCN-FR-021` | ⛔ A7 **SHALL NOT** mark any fact urgent, high-priority or
bypassing quiet hours. Priority and quiet hours are `BC-22`'s (**L131**).

⭐ **This is the most tempting delegation to break** — an official library
announcement *feels* like it should override quiet hours. ⛔ Refused: that is a
delivery policy, and inventing one here would be exactly the *"competing
notification system"* the instruction forbids. Routed as `LCN-DEC-001`, owner
**Product Owner** with the `BC-22` owner.

---

## 8. Moderation-related notification integration

`LCN-FR-022` | `community.ContentEligibilityChanged` **SHALL** be emitted when
A6 §9 eligibility transitions, carrying the content reference and the **new
eligibility value only**.

`LCN-FR-023` | ⛔ The fact **SHALL NOT** carry: reporter identity
(`TSF-INV-009`), case reference, evidence, category, severity, strike count or
policy version.

`LCN-FR-024` | ⛔ `BC-15` **SHALL NOT** emit a notification fact on behalf of
`BC-13`. `TSF-EVT-001` `safety.AbuseReportFiled` **already** has `BC-22` in its
consumer set (BC Map **L432**) — `BC-13` notifies for itself, and A7 duplicating
that would create a competing path.

`LCN-FR-025` | Eligibility facts **SHALL** be emitted only for transitions
`BC-15` itself performed by self-restriction (A6 `LCS-FR-043`), never as a
re-broadcast of `TSF-EVT-002`.

⭐ **`LCN-FR-024` is the clearest instance of the anti-duplication rule in A7.**
The measurement — `BC-22` is already a consumer of `TSF-EVT-001` — comes from
the map, and it settles the question without any judgement call.

⚠ **Open:** whether an author is notified that their content was *reported* (as
distinct from *restricted*) is A6's `LCS-DEC-003`, **Privacy Owner**. ⛔ A7 emits
**no** report-filed fact and takes no position.

---

## 9. Membership-related community notifications

`LCN-FR-026` | `community.MembershipChanged` **SHALL** be emitted on a community
membership transition, carrying community, person and the new state reference.

`LCN-FR-027` | ⛔ A7 **SHALL NOT** define membership states. A1's.

`LCN-FR-028` | ⛔ A7 **SHALL NOT** emit a fact about **library** membership.
`BC-02` owns that, and `membership.MembershipCreated` / `Renewed` /
`ExpiringSoon` / `Expired` already reach `BC-22` (BC Map **L409–412**).
Duplicating them would be a competing path.

`LCN-FR-029` | Group (A4) membership facts **SHALL** be treated as blocked.
⛔ A4 is a **CANDIDATE** (`LCG-DEC-001` open) and A7 defines no group fact.

`LCN-FR-030` | ⛔ A7 **SHALL NOT** emit a fact carrying a community **role**.
Roles are A4's/`BC-18`'s, and A6 `LCS-DEC-001` (community moderator) is open.

---

## 10–13. Delegated to `BC-22` — stated, not specified

⭐ **These four sections exist to record delegation explicitly. Each states the
delegation, its authority, and the fact that A7 adds nothing.**

### 10. Notification preference delegation — DELEGATED

`LCN-FR-031` | Preferences (opt-in/out, per-community, per-type, frequency,
digest) are **wholly `BC-22`'s** (**L131**: *"consent/unsubscribe"*). ⛔ `BC-15`
**SHALL NOT** store, read, cache or honour a preference — honouring one would
require reading `BC-22` state, and no inbound path exists (`LCN-FR-008`).

⚠ ⛔ **`LCN-GAP-002`** — the preference model is unspecified because `PRD-010`
does not exist. **Owner: `BC-22` owner / Product Owner.**

### 11. Channel selection delegation — DELEGATED

`LCN-FR-032` | Channel selection is **wholly `BC-22`'s** (**L131**). ⛔ A7 names
**no** channel — not push, email, SMS, in-app or webhook. ⛔ `BC-15` **SHALL NOT**
express a channel hint, preference or fallback order.

### 12. Quiet hours delegation — DELEGATED

`LCN-FR-033` | Quiet hours are **wholly `BC-22`'s** (**L131**). ⛔ A7 states no
window, timezone rule or override, and per `LCN-FR-021` no bypass flag.

### 13. Deduplication delegation — DELEGATED

`LCN-FR-034` | Deduplication is **wholly `BC-22`'s** (**L131**). `BC-15`
**SHALL** supply a stable idempotency key (§17) as **input** to that policy, and
**SHALL NOT** implement suppression, collapsing, batching or digesting.

⚠ ⛔ **`LCN-GAP-003`** — whether `BC-22` dedups on the producer key or its own is
unknowable without `PRD-010`. **Owner: `BC-22` owner.**

---

## 14. Notification reference model — INTEGRATION

`LCN-FR-035` | Every fact **SHALL** identify its subject by **opaque reference**,
resolvable only by an authorized `BC-15` read path.

`LCN-FR-036` | A reference **SHALL NOT** be a URL, a route, a database key or a
guessable sequential identifier. ⭐ A notification payload is the most widely
copied object in any system; a guessable reference in one is an IDOR vector by
construction.

`LCN-FR-037` | Resolving a reference **SHALL** re-apply full authorization:
membership, eligibility (A6 §9), block/mute (A6 §14) and community scope. ⛔ A
notification **SHALL NOT** be treated as a capability grant.

⭐ **`LCN-FR-037` is A7's single most important security requirement.** A
notification is a *pointer*, not an *entitlement*. Without it, a notification
delivered before a restriction became visible would become a permanent bypass of
A6's entire filter chain.

`LCN-FR-038` | The notification **inbox** is `BC-22`'s. BC Map **L205**: the
in-app item is *"owned by `BC-22`'s inbox projection"*. ⛔ `BC-15` **SHALL NOT**
build, store or render a notification list.

`LCN-FR-039` | ⛔ A7 **SHALL NOT** specify read/unread state, badge counts or
mark-all-read. All inbox concerns.

⚠ ⛔ **`LCN-GAP-004`** — the inbox reference contract is unspecified absent
`PRD-010`. **Owner: `BC-22` owner.**

---

## 15. Event payload requirements — OWNED (shape)

`LCN-FR-040` | A payload **SHALL** contain only: fact name, version, opaque
subject references, the community scope reference, an occurrence timestamp, and
the idempotency key.

`LCN-FR-041` | ⛔ A payload **SHALL NOT** contain: post/comment bodies, titles,
excerpts, media bytes, `FileRef`, display names, avatars, email addresses, phone
numbers, `tenantId`, `StudentRecordId`, reporter identity, or any `BC-13` case
detail.

`LCN-FR-042` | Payloads **SHALL NOT** carry a `tenantId` or `StudentRecordId`,
per `ID-2` (BC Map **L488**) and `ACCEPTED` `ADR-0078`.

⚠ **The `BC Map` L450 tension, inherited and NOT reopened.** **L450** states
*"`tenantId` is mandatory on every domain event"*; **L488** forbids `BC-11`→`17`
holding one. `ACCEPTED` `ADR-0078` §2.1 ruled **L450 is scoped, not universal**,
and A2 v0.8 records the closure at `LCF-ADR-006`/`LCF-DEC-003a`. ⛔ **A7 relies
on that accepted ruling and does not reopen it.**

`LCN-FR-043` | ⛔ A7 **SHALL NOT** state a payload size limit. No numeric value.

`LCN-FR-044` | Payload **SHALL** be additive-only within a version (§22).

⚠ ⛔ **`LCN-GAP-001`** — the `BC-22` payload contract is unknown absent
`PRD-010`; §15's shape is derived from `E-23`'s clause and the §9 naming
convention, and is **provisional**. **Owner: `BC-22` owner.**

---

## 16. Idempotency — OWNED (key) / DELEGATED (policy)

`LCN-FR-045` | Every fact **SHALL** carry a producer-supplied idempotency key,
deterministic from the domain change it describes.

`LCN-FR-046` | Re-emission after a producer-side retry **SHALL** reuse the same
key. ⛔ A retry **SHALL NOT** mint a new key.

`LCN-FR-047` | ⛔ Consumers **SHALL NOT** assume ordering across facts.
Correctness **SHALL** rest on idempotency plus each fact's own timestamp.

`LCN-FR-048` | ⛔ A7 **SHALL NOT** define the dedup **window**. `BC-22`'s
(§13).

⭐ **Split stated precisely: `BC-15` owns the *key*, `BC-22` owns the *policy*.**
Conflating them is how a producer accidentally acquires delivery semantics.

---

## 17. Retry behaviour — INTEGRATION

`LCN-FR-049` | Producer-side publication **SHALL** be at-least-once via the
transactional outbox, mirroring `E-20`'s *"fire-and-forget, outbox-backed"*
pattern (BC Map **L328**) and `TSF-FR-123`'s outbox requirement.

`LCN-FR-050` | ⛔ A7 **SHALL NOT** state a retry count, backoff, jitter or
dead-letter threshold. **Zero numbers.** ⚠ Whether these are `BC-25`
configuration or `BC-22` policy is unresolved — `LCN-GAP-008`, **Architecture
Owner**.

`LCN-FR-051` | Delivery-side retry is **wholly `BC-22`'s** (*"delivery
guarantees"*, **L131**).

`LCN-FR-052` | An unpublishable fact **SHALL** remain in the outbox and **SHALL
NOT** be silently dropped; exhaustion **SHALL** be audited (§20).

---

## 18. Failure behaviour — INTEGRATION

`LCN-FR-053` | Failure to publish a fact **SHALL NOT** fail, roll back or block
the domain operation. A post succeeds even if its fact cannot be published.

`LCN-FR-054` | ⭐ Failure to publish **SHALL NOT** be treated as a safety
failure. A6's fail-closed rules govern **content visibility**; A7 governs
**awareness**. Withholding content because a notification failed would be a
category error and would convert an availability incident into an outage.

`LCN-FR-055` | ⛔ `BC-15` **SHALL NOT** surface delivery success or failure to
any user, because it cannot know it (`LCN-FR-008`).

`LCN-FR-056` | Outbox depth, publication failures and exhaustion **SHALL** be
observable (§20).

⭐ **`LCN-FR-054` records a deliberate asymmetry with A6, and the reasoning
matters.** A6 fails **closed** because the risk is *unsafe content reaching a
reader*. A7 fails **open** because the risk is *a missed notification* — a
degradation, not a hazard. Failing closed here would mean an inaccessible
community, which is strictly worse.

---

## 19. Privacy — INTEGRATION

`LCN-FR-057` | Payloads **SHALL** be reference-only (§15), so a leaked payload
discloses no content.

`LCN-FR-058` | ⛔ A payload **SHALL NOT** disclose a block or mute relationship,
by presence, absence, count or timing (A6 `LCS-FR-038`).

`LCN-FR-059` | A fact **SHALL NOT** be emitted for content excluded by A6 §9 or
§14 (`LCN-FR-014`). ⭐ Otherwise a notification becomes a side channel proving
the existence of content the reader is forbidden to see — defeating A6
`LCS-FR-025`'s indistinguishability guarantee.

`LCN-FR-060` | ⛔ Reporter identity **SHALL NOT** appear in any A7 fact
(`TSF-INV-009`).

`LCN-FR-061` | ⛔ A7 **SHALL NOT** define a minor-specific notification rule.
`BC-10`/`BC-18`/`BC-13`'s.

⚠ ⛔ **`LCN-DEC-002` — OPEN.** Whether community notifications require distinct
consent for minors is a **Privacy Owner** decision, and it interacts with
`BC-22`'s unwritten consent model. A7 takes no position.

---

## 20. Tenant / community isolation — OWNED (producer side)

`LCN-FR-062` | Every fact **SHALL** carry its community scope reference, so no
consumer must infer scope.

`LCN-FR-063` | ⛔ A fact **SHALL NOT** reference two communities.

`LCN-FR-064` | ⛔ A fact **SHALL NOT** carry a `tenantId` or `StudentRecordId`
(`ID-2`, `ADR-0078`).

`LCN-FR-065` | ⛔ `BC-15` **SHALL NEVER** trust a client-supplied `LibraryId`,
`CommunityId`, membership status, role or `AuthorId` when deciding to emit.
All **SHALL** be server-derived (A6 `LCS-SEC-001`).

⚠ **Cross-library isolation.** As A6 `LCS-GAP-006` records, `BC-15` is Global
and has **no library partition**; cross-**library** isolation is not expressible
here. A7 delivers cross-**community** isolation and does **not** duplicate that
gap.

---

## 21. Notification fan-out limits — ⛔ OPEN

`LCN-FR-066` | ⛔ **A7 states no fan-out limit.** Not one number.

⛔ **`LCN-DEC-003` — OPEN.** A community-wide fact addresses an unbounded
audience, and `LCN-EVT-003` (reactions) is high-volume by nature (§3.5).
Resolution requires: a limit value (`BC-25` config — and
`CONFIGURATION_GUIDE.md` **L863** makes adding a parameter a PRD amendment), a
decision on whether limiting is a **producer** or **`BC-22`** concern, and
`BC-21` entitlement interaction (`E-17` is *"All write paths → `BC-21`"*).
**Owner: Product Owner with the `BC-22` owner and Architecture Owner.**

`LCN-FR-067` | Pending that decision, community-wide facts **SHALL** be emitted
as a **single** fact with an audience reference, **not** as per-recipient facts —
⭐ deliberately the shape that does **not** multiply volume, and the one that
keeps `LCN-GAP-006`'s option (a) open rather than foreclosing it.

⚠ **Disclosed:** `LCN-FR-067` is a *provisional structural choice*, not a
decision on `LCN-DEC-003`. It is reversible and states no value.

---

## 22. Observability — INTEGRATION

`LCN-FR-068` | `BC-15` **SHALL** emit audit facts for publication attempts over
`E-20` (*"All contexts → `BC-24`"*).

`LCN-FR-069` | Producer-side observability **SHALL** cover: emission count by
fact type, outbox depth, publication failure count, retry exhaustion.

`LCN-FR-070` | ⛔ `BC-15` **SHALL NOT** observe delivery rate, open rate, channel
performance or bounce rate. `BC-22`'s, and unreachable (`LCN-FR-008`).

`LCN-FR-071` | ⛔ Telemetry **SHALL NOT** contain content bodies or personal
identifiers beyond opaque references.

`LCN-FR-072` | ⛔ A7 **SHALL NOT** state an alert threshold or SLO value.

---

## 23. Versioning

`LCN-FR-073` | Facts **SHALL** be versioned; `v1` at introduction.

`LCN-FR-074` | Within a version, changes **SHALL** be additive-only; a
consumer's ignorance of a new optional field **SHALL NOT** break it.

`LCN-FR-075` | A breaking change **SHALL** be a new version, and **SHALL NOT**
mutate an existing one.

`LCN-FR-076` | ⛔ A7 **SHALL NOT** state a deprecation period. No numbers.

---

## 24. Acceptance criteria — Given / When / Then

⚠ **All `PENDING`.** `BC-15` does not exist, Stage 3 is not conferred, and
several facts are gated. Written measurably to become executable when gates
clear.

### 24.1 Fact emission and shape

| ID | Criterion | Status |
|---|---|---|
| `LCN-AC-001` | **Given** a post reaching `PUBLISHED`, **when** the transaction commits, **then** exactly one `community.PostPublished` is enqueued in the outbox with the same transaction | `PENDING` |
| `LCN-AC-002` | **Given** any emitted fact, **when** the payload is inspected, **then** it contains **no** body, title, excerpt, `FileRef`, display name, email, phone, `tenantId` or `StudentRecordId` | `PENDING` |
| `LCN-AC-003` | **Given** any emitted fact, **when** its name is inspected, **then** it matches `community.<Aggregate><PastTenseVerb>` and is **not** imperative (BC Map **L402**) | `PENDING` |
| `LCN-AC-004` | **Given** a post that is `WITHHELD` or `RESTRICTED`, **when** eligibility is evaluated, **then** **no** notification fact is emitted (`LCN-FR-014`, `LCN-FR-059`) | `PENDING` |
| `LCN-AC-005` | **Given** a producer retry, **when** the fact is re-emitted, **then** the idempotency key is **identical** to the first attempt | `PENDING` |

### 24.2 Delegation — asserting A7 owns nothing it must not

| ID | Criterion | Status |
|---|---|---|
| `LCN-AC-006` | **Given** A7's full text, **when** measured, **then** it names **zero** channels, **zero** templates, **zero** quiet-hours windows, **zero** consent rules, **zero** dedup windows and **zero** delivery guarantees | ✅ **VERIFIABLE NOW** — §26 |
| `LCN-AC-007` | **Given** the `BC-15` implementation, **when** searched, **then** it contains **no** notification inbox, read/unread state, badge count or preference store | `PENDING` |
| `LCN-AC-008` | **Given** a delivery failure in `BC-22`, **when** `BC-15` is inspected, **then** `BC-15` has **no** record of it and exposes **no** delivery status | `PENDING` |
| `LCN-AC-009` | **Given** an abuse report filed, **when** A7's facts are enumerated, **then** **none** describes it — `BC-13` notifies via `TSF-EVT-001` (`LCN-FR-024`) | `PENDING` |
| `LCN-AC-010` | **Given** a library membership change, **when** A7's facts are enumerated, **then** **none** duplicates `membership.*` (`LCN-FR-028`) | `PENDING` |

### 24.3 Security — notification is a pointer, not a grant

| ID | Criterion | Status |
|---|---|---|
| `LCN-AC-011` | **Given** a delivered notification referencing a post, **when** the recipient's membership is subsequently revoked and they follow the reference, **then** access is **REFUSED** (`LCN-FR-037`) | `PENDING` |
| `LCN-AC-012` | **Given** a delivered notification, **when** the content is subsequently `RESTRICTED` and the recipient follows the reference, **then** access is **REFUSED** and indistinguishable from *not found* | `PENDING` |
| `LCN-AC-013` | **Given** a notification reference, **when** an unrelated authenticated person submits it, **then** access is **REFUSED** — no IDOR (`LCN-FR-036`) | `PENDING` |
| `LCN-AC-014` | **Given** a blocked pair, **when** either party acts, **then** **no** fact is emitted that would inform the other, and no timing difference is observable (`LCN-FR-058`) | `PENDING` |
| `LCN-AC-015` | **Given** a client-supplied `LibraryId` or `CommunityId`, **when** emission is decided, **then** the client value is **ignored** and the server-derived scope is used (`LCN-FR-065`) | `PENDING` |

### 24.4 Isolation and failure

| ID | Criterion | Status |
|---|---|---|
| `LCN-AC-016` | **Given** two communities, **when** a fact is emitted in one, **then** its payload references **only** that community and no member of the other can resolve it | `PENDING` |
| `LCN-AC-017` | **Given** the outbox is unavailable, **when** a post is created, **then** the post **succeeds** and the failure is audited (`LCN-FR-053`) | `PENDING` |
| `LCN-AC-018` | **Given** notification publication fails entirely, **when** the feed is read, **then** content visibility is **unaffected** — no fail-closed (`LCN-FR-054`) | `PENDING` |
| `LCN-AC-019` | **Given** retry exhaustion, **when** the outbox entry is abandoned, **then** it is audited over `E-20` and not silently dropped (`LCN-FR-052`) | `PENDING` |
| `LCN-AC-020` | **Given** a fact delivered twice to `BC-22`, **when** consumed, **then** the idempotency key is identical and dedup is `BC-22`'s decision, not `BC-15`'s | `PENDING` |
| `LCN-AC-021` | **Given** a community-wide fact, **when** emitted, **then** exactly **one** fact is produced, not one per recipient (`LCN-FR-067`) | `PENDING` |

---

## 25. Self-measurement — what A7 minted

| Quantity | Count | Verification |
|---|---|---|
| Bounded-context edges created | **0** | ⭐ **and zero required** — `E-23` already covers `BC-15` |
| Bounded contexts created | **0** | Count remains **31** |
| Aggregates created | **0** | Facts reference existing A1/A2/A4/A5 objects |
| Notification modules created | **0** | `ADR-0001` preserved; no module added to the Matrix tree |
| Channels / templates / delivery policies | **0** | §§11–13 delegate all |
| Permissions / roles | **0** | |
| Numeric values (limits, retries, windows, thresholds, SLOs) | **0** | §§13, 17, 21, 22, 23 all decline |
| `LCN-CFG-*` identifiers | **0** | `CONFIGURATION_GUIDE.md` **L863** |
| ADRs created | **0** | Next free remains `ADR-0083` |
| `PRD-010` created | **0** | ⭐ Remains `PLANNED` at registry §4.1 |
| BC Map §9 rows added | **0** | Facts are **PROPOSED**; registration raised as `LCN-ADR-001` |
| Existing documents modified | **0** | A7 is a new file only |
| Candidate facts defined | **7** | §3.2 — each justified as non-derivable |

### 25.1 Identifier register

| Register | Count | Range |
|---|---|---|
| `LCN-EVT-*` | 7 | `001`–`007` |
| `LCN-FR-*` | 76 | `001`–`076` |
| `LCN-AC-*` | 21 | `001`–`021` |
| `LCN-GAP-*` | 8 | `001`–`008` |
| `LCN-DEC-*` | 3 | `001`–`003` |
| `LCN-ADR-*` | 1 | `001` |
| **Total** | **116** | across **6** registers |

⛔ All **PROPOSED and UNRATIFIED**; `LCN-` prefix **not registered**.

---

## 26. Open items — routed, not closed

### 26.1 Architecture decisions

| ID | Requirement | Owner | State |
|---|---|---|---|
| **`LCN-ADR-001`** | ⛔ **Register `BC-15`'s producer rows in BC Map §9**, and settle the `community.` context token (`LCN-GAP-005`). ⚠ **No new edge is required** — `E-23` exists; this is **event registration**, a strictly smaller act than an edge admission | **Architecture Owner** | ⛔ **OPEN** |

### 26.2 Gaps

| ID | Gap | Owner |
|---|---|---|
| `LCN-GAP-001` | `BC-22` payload contract unknown — `PRD-010` absent; §15 provisional | **`BC-22` owner** |
| `LCN-GAP-002` | Preference/consent model unspecified | **`BC-22` owner** / Product Owner |
| `LCN-GAP-003` | Dedup on producer key vs `BC-22`'s own | **`BC-22` owner** |
| `LCN-GAP-004` | Inbox reference contract unspecified | **`BC-22` owner** |
| `LCN-GAP-005` | `community.` context token unregistered | **Architecture Owner** |
| `LCN-GAP-006` | ⭐ **Audience resolution:** `BC-22` cannot resolve *"members of community X"* — A1 membership is Global, `BC-22` is Communication. Two shapes named, neither chosen | **Architecture Owner** |
| `LCN-GAP-007` | Official communication is notifiable-but-unreportable (`TSF-GAP-010`) | **Product Owner** |
| `LCN-GAP-008` | Retry parameters: `BC-25` config vs `BC-22` policy | **Architecture Owner** |

### 26.3 Owner decisions

| ID | Decision | Owner |
|---|---|---|
| `LCN-DEC-001` | Whether official communications may bypass quiet hours | **Product Owner** + `BC-22` owner |
| `LCN-DEC-002` | Minor-specific notification consent | **Privacy Owner** |
| `LCN-DEC-003` | Fan-out limits, and whose concern they are | **Product Owner** + `BC-22` owner + Architecture Owner |

### 26.4 ⛔ Preserved untouched

`PRD-010` remains **`PLANNED`, not created**. A3 `LCR-DEC-009` **REFUSED and
open**. A4 `LCG-DEC-001` **open** (A4 remains a CANDIDATE). A5 `LCO-DEC-001` /
A3 `LCR-DEC-006` **open**. A6 `LCS-ADR-001`, `LCS-DEC-001`…`003` **open**.
`LCF-ADR-007` **open**. `TSF-GAP-010` **open**. `ADR-0078` **relied upon, not
reopened**.

---

## 27. Future / V2 scale

| Item | Disposition |
|---|---|
| Digests / aggregation | ⛔ **FUTURE and `BC-22`'s** — aggregation is deduplication (**L131**) |
| Real-time in-app push | ⛔ **FUTURE.** A2's realtime section and A8 §14 govern transport; not a notification concern |
| Cross-community recommendation notices | ⛔ **FUTURE.** Would need `BC-27`/`BC-26` paths `BC-15` does not have |

---

## 28. Verification of this document

| Assertion | Result |
|---|---|
| Existing documents modified | ✅ **0** |
| Edges created / required | ✅ **0 / 0** |
| `BC-22` capabilities claimed | ✅ **0** of 8 |
| Notification module created | ✅ **0** |
| Numeric values stated | ✅ **0** |
| `PRD-010` created or substituted | ✅ **NO** |
| Owner decisions taken | ✅ **0** (3 raised) |
| Competing notification path created | ✅ **0** — `LCN-FR-024`, `LCN-FR-028` |
| Lifecycle stages conferred | ✅ **0** |

---

| Field | Value |
|---|---|
| **Version** | v0.1 |
| **Date** | 2026-08-25 |
| **Status** | **DRAFT** — NOT FROZEN, NOT CONFERRED, NOT BASELINED |
| **Part of** | `PRD-021A` (A7 authorized as a **part**, not a standalone PRD; **`PRD-010` NOT created**) |
| **Determination** | A **producer-side integration contract**. ⭐ **No edge required** — `E-23` is *"All contexts"*. `BC-22` retains all eight delegated capabilities. ⛔ Facts are **PROPOSED, unregistered** — `LCN-ADR-001`. Two facts gated on open A3/A5 decisions |
