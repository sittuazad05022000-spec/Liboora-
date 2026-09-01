<!--
  PROVENANCE — PRD-021B Part B0 (cross-part architecture and open decisions)

  Purpose of this file
  --------------------
  CONTEXT-LOSS RECOVERY / CONTINUITY ARTEFACT.

  This is the cross-part companion to PRD-021B Parts B1, B2 and B3. It carries
  the ownership matrix, the dependency-direction rules, the acceptance-criteria
  coverage summary, and the FINAL OPEN DECISIONS register.

  Status        : DRAFT — v0.1 (Stage 2)
  Freeze status : NOT FROZEN. NOT FINAL. NOT APPROVED. NOT BASELINED.
  Lifecycle     : Stage 2 (Draft) ONLY. Stage 3 (Architecture Review) NOT
                  entered. No alignment record exists and none is claimed.
                  The Stage 3 checks reproduced in section 6 are a PREPARATORY
                  SELF-ASSESSMENT ONLY. They are NOT a Stage 3 gate result.

  Open items    : FOD-1 and FOD-2 remain ⛔ OPEN. ADR-0088 and ADR-0090 are
                  PROPOSED ONLY — neither file exists, neither is ratified, and
                  this document ratifies neither.

  What this file does NOT do
  --------------------------
    - It creates no bounded context. The count remains 31.
    - It creates no integration edge or published event.
    - It amends no FROZEN PRD and no Rank 1-5 artefact.
    - It mints no IMPL-* identifier and creates no implementation task.
    - It confers no lifecycle stage.
-->

# PRD-021B — PART B0

## Cross-Part Architecture, Coverage Summary & Final Open Decisions

### v0.1 — Stage 2 (Draft)

> ⚠ **DRAFT — NOT FROZEN, NOT FINAL, NOT APPROVED.** Stage 3 has **not** been
> entered. Section 6 is a **preparatory self-assessment**, ⛔ **not** a Stage 3
> alignment record.

---

## §1. Scope of this document

`PRD-021B` consists of four files:

| Part | File | Register stem | ACs |
|---|---|---|---|
| **B0** | `PRD-021B_B0_CROSS_PART_ARCHITECTURE_AND_OPEN_DECISIONS_v0.1.md` | `XPA-`, `FOD-` | — |
| **B1** | `PRD-021B_B1_SOCIAL_GRAPH_DRAFT_v0.1.md` | `SGR-` | **30** |
| **B2** | `PRD-021B_B2_SOCIAL_SAFETY_DRAFT_v0.1.md` | `SSF-` | **28** |
| **B3** | `PRD-021B_B3_STUDENT_DISCOVERY_DRAFT_v0.1.md` | `SDS-` | **32** |
| | | **Total ACs** | **90** |

### §1.1 Identifier registers for this file

| Register | Meaning | Range | Count |
|---|---|---|---|
| `XPA-DEP-nnn` | Dependency-direction rule | `001`–`006` | 6 |
| `XPA-PREC-nnn` | Precedence rule | `001`–`007` | 7 |
| `XPA-BND-nnn` | Library/global boundary rule | `001`–`006` | 6 |
| `XPA-ACGAP-nnn` | Disclosed AC-coverage gap | `001`–`003` | 3 |
| `FOD-n` | Final open decision | `1`–`4` | 4 |

⛔ No `IMPL-*` identifier is minted. Prefixes `XPA-` and `FOD-` measured **0**
occurrences across `docs/` before authoring.

---

## §2. Authoritative ownership matrix — 15 capabilities

**Legend:** ✅ owns · ▶ consumes/orchestrates · ⛔ must not touch

| # | Capability | **Owner** | B1 | B2 | B3 |
|---|---|---|---|---|---|
| 1 | Identity | **`BC-10`** (BC Map L376) | ▶ | ▶ | ▶ |
| 2 | Profile | **`BC-10`** — `GlobalStudentProfile` (L376) | ⛔ | ⛔ | ▶ projection only |
| 3 | Membership | **`BC-02`** — `Membership` (L370) | ⛔ | ⛔ | ▶ `MembershipValidity` |
| 4 | Friendship | **`BC-11`** (L115, L377) | ✅ | ⛔ | ▶ signals |
| 5 | Block | **`BC-11`** — `BlockList` (L377); `TSF-XC-004` | ▶ | ✅ | ▶ filter |
| 6 | Mute | **`BC-11`** — `TSF-XC-005` (FROZEN) ⚠ register append **`FOD-2`** | ⛔ | ✅ *(gated)* | ⛔ |
| 7 | Discovery | **Read composition** (`AR-1` shape) — no context | ⛔ | ⛔ | ✅ composes |
| 8 | Ranking | **`BC-23`** (`PRD-020` §8.3 step [4]) | ⛔ | ⛔ | ⛔ |
| 9 | Recommendation | **`BC-23`** — V2/V3, not specified | ⛔ | ⛔ | ⛔ |
| 10 | Messaging | **`BC-12`** (L378) | ▶ `canMessage` via `E-16` | ▶ | ⛔ |
| 11 | Notifications | **`BC-22`** via `E-23` (L332) | ▶ | ▶ | ⛔ |
| 12 | Community moderation | **`BC-13`** — `ModerationCase` (L379) | ⛔ | ▶ report routing | ⛔ |
| 13 | Audit | **`BC-16`** | ▶ writes records | ▶ writes records | ⛔ |
| 14 | Safety decision | **`BC-13`** enforcement (`E-14`) + **`BC-11`** graph-level block | ▶ | ✅ graph-level | ▶ |
| 15 | Mutual connections | **`BC-11`** — derivation, not stored | ✅ count | ⛔ | ▶ count only |

⚠ **Row 6 note.** Mute's **owner and classification are FROZEN** by `TSF-XC-005`
— *"Same owner as Block — a unilateral graph-visibility preference, not a safety
decision."* ⛔ This document does **not** reopen that. Only the **BC Map §8
register append** is open (`FOD-2`).

⚠ **Row 7 note.** "Owner = read composition" is not an evasion: it is the `AR-1`
shape, already ruled for Library Discovery — *"owns no aggregate, no invariant
and no business state"*, *"orchestrates public read models only"*, *"No `BC-`
identifier is assigned; the context count remains 31."*

### §2.1 Entity ownership

| Entity / structure | Owner | Authority |
|---|---|---|
| `GlobalStudentProfile`, `Username`, `PrivacySettings`, `VerificationState` | `BC-10` | BC Map L376 |
| `Membership`, `MembershipPlanRef`, `Term`, `FreezeWindow[]`, `MembershipStatus` | `BC-02` | BC Map L370 |
| `MembershipValidity{studentRecordId, validUntil, seatQuota}` | `BC-02` | `MM-FR-066`, L538 |
| `Friendship`, `BlockList`, `FriendRequest`, `RateLimitCounter` | `BC-11` | BC Map **L377** |
| ⚠ `Mute` | `BC-11` by `TSF-XC-005`; ⛔ **absent from L377** | **`FOD-2`** |
| `Conversation`, `Message`, `DeliveryReceipt`, `RetentionPolicy` | `BC-12` | BC Map L378 |
| `ModerationCase`, `AbuseReport`, `EnforcementAction`, `StrikeRecord`, `Appeal` | `BC-13` | BC Map L379 |
| Search index | `BC-23` | `E-21`, `SID-4.38` |
| ⛔ Composed discovery result | **nobody** — not persisted | `SDS-DM-005`, `LCM-RM-006` |

### §2.2 API ownership

| Surface | Owner | Note |
|---|---|---|
| Friend request / accept / reject / cancel / unfriend / list / status | **B1** | `SGR-API-003`…`011` |
| Block / unblock / list blocked | **B2** | `SSF-API-003`…`005` |
| Mute / unmute / list muted | **B2** ⚠ gated by `FOD-2` | `SSF-API-006`…`008` |
| Report | **`BC-13`** — B2 routes only | `SSF-API-009` |
| Student search / discovery | **B3** | `SDS-API-001`…`004` |
| `canMessage(a,b)` | **`BC-11`** internal port `E-16` | BC Map L320 |
| Safety Check | **B2** internal, not public | `SSF-API-001` |

⚠ ⛔ **No path, route, schema, header or status code is specified in any part.**
Barred by the `ADR-0035` §5.5b class of prohibition.

### §2.3 Event ownership

| Event | Publisher | Consumers | Authority |
|---|---|---|---|
| `social.FriendshipEstablished` | `BC-11` | `BC-12`, `BC-26` | BC Map **L430** |
| `social.UserBlocked` | `BC-11` | `BC-12`, `BC-26` | BC Map **L430** |
| `identity.PersonProfileUpdated` | `BC-10` | `BC-23`, `BC-24`, `BC-26`, **`BC-11`** | L425 |
| `identity.PersonUsernameChanged` | `BC-10` | `BC-23`, `BC-24`, **`BC-11`**, `BC-12` | L426 |
| `identity.PersonPrivacyModeChanged` | `BC-10` | `BC-23`, `BC-24`, **`BC-11`**, `BC-26` | L427 — *"no propagation window"* |
| `identity.PersonAnonymised` | `BC-10` | `BC-23`, `BC-24`, **`BC-11`**, `BC-12`, `BC-26` | L428 |
| `EnforcementActionTaken` | `BC-13` | `BC-11`, `BC-12`, `BC-14`, `BC-15` | `E-14`, L318 |

⛔ **`BC-11`'s published surface is CLOSED AT TWO.** No part mints an event.

⚠ **`identity.PersonIdentityCreated` (L424) does NOT list `BC-11`.** ⇒ A
`PersonId` may be referenced before the graph has observed any event for it;
treated as **valid but unenriched** (`SGR-DM-007`).

---

## §3. Dependency direction

```
        BC-18 Auth ──(E-12, CF, same txn)──▶ BC-10 Identity
                                               │
   BC-01 Tenant ──(E-13, ACL, only bridge)─────┤   (upward only)
                                               │
                                    ┌──────────┴──────────┐
                                    │ events L425-428     │ E-15 (SK)
                                    ▼                     ▼
                              BC-11 Social Graph  ◀── PrivacyPolicy VO
                               (B1 graph, B2 safety)
                                    │  ▲
                        E-16 (C/S)  │  │  E-14 (PL, self-restrict)
                                    ▼  │
                              BC-12 Messaging   BC-13 Trust & Safety
                                                       │
   BC-02 Membership ──(MembershipValidity, E-02)──┐    │
   BC-10 Identity ─────(E-21, PL)──▶ BC-23 Search │    │
                                          │       │    │
                                          ▼       ▼    ▼
                              ┌───────────────────────────────┐
                              │  B3 DISCOVERY READ COMPOSITION │
                              │  (AR-1 shape — no BC, no state)│
                              └───────────────────────────────┘
```

`XPA-DEP-001` — Reference direction is **upward only**: tenant world → global
world, never the reverse. Authority: `E-13` (BC Map L317).
`XPA-DEP-002` — ⛔ `BC-13` **MUST NOT** write into `BC-11`, `BC-12`, `BC-14`,
`BC-15` or `BC-10`. Authority: `E-14`; `TSF-XC-021`.
`XPA-DEP-003` — ⛔ `BC-11` **MUST NOT** import `domain/person/**` or
`domain/library/**`. CI-enforced `banned_imports`.
`XPA-DEP-004` — ⛔ `BC-11` **MUST NOT** be a `BC-23` consumer. `E-22`.
`XPA-DEP-005` — ⛔ B3 **MUST NOT** be depended upon by `BC-11`. Composition is a
leaf; a reverse dependency would invert `AR-1`.
`XPA-DEP-006` — ⛔ **No new edge is created by `PRD-021B`.** BC Map §7: *"If an
edge is not in this table, it does not exist."*

⭐ **No reverse ownership. No duplicated source of truth.**

---

## §4. Precedence — privacy and safety

`XPA-PREC-001` — Order, highest first: **[1]** `BC-13` enforcement · **[2]**
Block · **[3]** Privacy (`BC-10`) · **[4]** Mute · **[5]** Relationship state.
`XPA-PREC-002` — A lower rank **MUST NOT** override a higher rank.
`XPA-PREC-003` — Safety filtering is **non-bypassable** (`TSF-INV-005`).
`XPA-PREC-004` — ⛔ Exclusion reasons **MUST NOT** be published
(`TSF-XC-030`).
`XPA-PREC-005` — Every filter **MUST fail closed** (`LCM-RM-025`).
`XPA-PREC-006` — ⛔ **No decision at any rank MAY be cached** (`LCM-RM-021`,
`LCM-RM-023`).
`XPA-PREC-007` — ⛔ `BC-13` **MUST NOT** filter a discovery result set itself
(`TSF-XC-029`).

---

## §5. Library / global boundary

`XPA-BND-001` — `BC-11`…`BC-17` are **global**: no `tenantId`, keyed on
`PersonId` (BC Map **L488**).
`XPA-BND-002` — ⛔ `StudentRecordId` and `TenantId` **MUST NOT** appear in
`domain/social`. CI-enforced.
`XPA-BND-003` — Library Management ⟷ `BC-11`…`BC-17` are **Separate Ways**
(`X-05`, Matrix L354).
`XPA-BND-004` — `E-13` is *"the only bridge between the two worlds"*, reference
direction **upward only**.
`XPA-BND-005` — ⭐ B3's composition **MUST** sit on the **tenant side**, because
`MembershipValidity` is `studentRecordId`-keyed. The alternative is
**unbuildable**.
`XPA-BND-006` — Friendship is **global** and survives membership expiry;
**discovery eligibility** is library-scoped and does not.

---

## §6. Architecture consistency chain — preparatory self-assessment

> ⚠ ⛔ **THIS IS NOT A STAGE 3 GATE RESULT.** `PRD_LIFECYCLE.md` makes the
> Stage 3 gate *"a written alignment record naming every conflict and its
> disposition"*. **No such record exists for `PRD-021B` and none is claimed.**
> The table below is a preparatory self-assessment only.

| # | Chain link | Holds? | Authority |
|---|---|---|---|
| 1 | Identity → Profile | ✅ | `BC-10` owns both (L376) |
| 2 | Membership → Library eligibility | ✅ | `BC-02` `MembershipValidity` (`MM-FR-002`/`066`) |
| 3 | B2 Safety → safety eligibility | ✅ | `BlockList` (L377); `TSF-XC-004` |
| 4 | B1 Social Graph → relationship signals | ✅ | `Friendship` (L377) |
| 5 | B3 Discovery → eligible candidate / read composition | ✅ | `AR-1`; `PRD-020` §8.3 |
| 6 | Ranking / Recommendation → existing owner only | ✅ | `BC-23`, step [4] |
| 7 | Messaging → existing owner only | ✅ | `BC-12` (L378); `E-16` |
| 8 | Notifications → existing owner only | ✅ | `BC-22` via `E-23` (L332) |

⭐ **No reverse ownership. No duplicated source of truth.** Every terminal node
is an **existing** owner.

---

## §7. Acceptance-criteria coverage summary

**Total: 90** — B1 **30** (`SGR-AC-001`…`030`) · B2 **28** (`SSF-AC-001`…`028`)
· B3 **32** (`SDS-AC-001`…`032`).

| # | Required coverage area | B1 | B2 | B3 | Total |
|---|---|---|---|---|---|
| 1 | Security | `012`,`013`,`028`,`029` | `011`,`018`,`025`,`027` | `026`,`027`,`028`,`029` | 12 |
| 2 | Privacy | `020` | `021`,`024` | `012`,`013`,`014`,`015`,`016` | 8 |
| 3 | Authorization | `006`,`012`,`013` | `007`,`011`,`018` | `027` | 7 |
| 4 | Concurrency | `003`,`005`,`008` | `005` | `025` | 5 |
| 5 | Idempotency | `004`,`008` | `005`,`006` | — | 4 |
| 6 | Membership expiry | `016`,`017` | — | `006`,`007`,`008`,`009` | 6 |
| 7 | Block / mute | `009`,`010` | `001`–`010`,`021`–`024` | `017`,`018` | 18 |
| 8 | Cross-library isolation | `018`,`019` | — | `003`,`004`,`005` | 5 |
| 9 | API behaviour | `023` | — | `024`,`026` | 3 |
| 10 | Event behaviour | `021`,`022`,`026`,`027` | `019`,`026` | `031` | 7 |
| 11 | Performance | `025` | `014` | `010`,`011`,`021` | 5 |
| 12 | Failure behaviour | `011` | `012`,`013`,`028` | `019`,`020` | 6 |
| 13 | Data-model integrity | `001`,`002`,`029` | `025` | `032` | 5 |
| 14 | Audit | `030` | `017` | — | 2 |

⚠ Some ACs cover more than one area, so the column sum exceeds 90. **All 90 are
mapped; there are no orphans and no invented requirements.**

**Machine-checkable now (14):** `SGR-AC-028`, `SGR-AC-029`, `SSF-AC-025`,
`SDS-AC-026`, `SDS-AC-028`, `SDS-AC-029`, `SDS-AC-032`, `SGR-AC-027`,
`SSF-AC-026`, `SGR-AC-002`, `SGR-AC-005`, `SSF-AC-002`, `SDS-AC-022`,
`SGR-AC-023`.

⚠ **Disclosed coverage gaps:**

| ID | Gap | Consequence |
|---|---|---|
| `XPA-ACGAP-001` | No AC asserts a **numeric** latency or throughput target | ⛔ No number is invented. Performance ACs assert *shape* (bounded, O(1), no unbounded scan) |
| `XPA-ACGAP-002` | Mute ACs (`SSF-AC-021`…`024`) cannot be executed while `FOD-2` is open | Degraded ship mode `SSF-AC-028` covers the gated state |
| `XPA-ACGAP-003` | No AC asserts end-to-end behaviour across `BC-22` notification delivery | ⛔ `PRD-010` not created; notification contract owner undefined at PRD level |

⛔ **No acceptance criterion in any part is recorded as passing. No test exists.**

---

## §8. FINAL OPEN DECISIONS

### `FOD-1` — `BC-11` aggregate and transaction boundary

| Field | Value |
|---|---|
| **Question** | Do `Friendship`, `FriendRequest`, `BlockList` and `RateLimitCounter` form **one** `BC-11` aggregate (one transaction), or separate aggregates with an eventual-consistency seam? |
| **Why unresolved** | BC Map §8 preamble: *"**The aggregate is the transaction boundary** — one aggregate, one database transaction, no exceptions."* L377 names four structures in one row but ⛔ does **not** state whether they share an aggregate root. Neither reading contradicts any authority; it is a genuine design trade-off (contention vs. atomicity) |
| **Required owner** | **ARB** (`PRD_OWNERSHIP_MODEL.md` **L203**) |
| **Exact smallest action** | **One ADR** recording the transaction-boundary choice for `BC-11`. ⛔ No BC Map edit, no new context, no new edge |
| **Blocks B1/B2/B3 authoring?** | ⛔ **No.** Written boundary-agnostically; outcomes specified, mechanism deferred (`SGR-BR-006`, `SGR-DM-010`, `SSF-BR-004`, `SSF-DM-008`) |
| **Blocks later implementation?** | ✅ **Yes.** Schema and concurrency tests cannot be written until fixed |

### `FOD-2` — `Mute` absent from the BC Map §8 aggregate register

| Field | Value |
|---|---|
| **Question** | May `BC-11` persist a `Mute` structure, and is BC Map §8 appended to record it? |
| **Why unresolved** | BC Map **L377** names exactly four structures — `Friendship`, `BlockList`, `FriendRequest`, `RateLimitCounter` — and ⛔ **no `Mute`**. Adding one is a **Rank 4** change, and `DOCUMENTATION_BASELINE.md` §7 rule 1 requires *"an ADR before the change."* ⚠ **This is a REGISTER question, not a classification question:** `TSF-XC-005` (FROZEN) already settles owner and classification, and is ⛔ **not reopened** |
| **Required owner** | **ARB** |
| **Exact smallest action** | **One ADR** authorizing a Rank 4 append of `Mute` to BC Map L377 as a `BC-11` structure. ⛔ Not a reclassification |
| **Blocks B1/B2/B3 authoring?** | ⛔ **No.** Classification is frozen and reproduced verbatim (`SSF-BR-020`) |
| **Blocks later implementation?** | ⚠ **Partially** — the `mute_list` structure **only**. `SSF-EC-016`/`SSF-AC-028` specify a degraded ship mode: mute endpoints return *not implemented*; Block, unblock, rate limiting, Safety Check and **all of B1 and B3** ship complete |

### `FOD-3` — Enterprise Architecture Block wave self-contradiction

| Field | Value |
|---|---|
| **Question** | Is `Block Users` V1 or V2? |
| **Why unresolved** | EA **L942** says `Block Users (V2)` while EA **L921** says `Block Enforcement (V1)`; `PRD-020` `F-6`/`TSF-XC-004` presuppose Block in V1; BC Map L115/L377 make `BlockList` a `BC-11` structure with no wave qualifier. **4 authorities to 1**, the dissenter inside the same Rank 4 document |
| **Required owner** | **Architecture Owner** (EA document owner) |
| **Exact smallest action** | Correct EA **L942** `(V2)` → `(V1)`, with a changelog entry |
| **Blocks B1/B2/B3 authoring?** | ⛔ **No.** Block treated as V1 on the 4-to-1 reading; ⛔ EA **not** edited here — conflict **raised, not adjudicated** |
| **Blocks later implementation?** | ⛔ **No** |

### `FOD-4` — B4/B5/B7/B8/B9 consumer/owner undefined

| Field | Value |
|---|---|
| **Question** | Who owns and consumes `Part B4`, `B5`, `B7`, `B8`, `B9`? |
| **Why unresolved** | Measured at authoring: **0 files each**. `PRD_REGISTRY.md` §11.3/§11.4 recognise `PRD-021A` parts **A1–A8 only**. ⛔ No B-series part beyond B1/B2/B3 is authorized anywhere |
| **Required owner** | **Governance Owner** |
| **Exact smallest action** | None required for `PRD-021B`. If such parts are wanted, a registry §11-style allocation act |
| **Blocks B1/B2/B3 authoring?** | ⛔ **No.** B3 publishes a read contract and names **no** consumer (`SDS-XC-009`, `SDS-XC-013`) |
| **Blocks later implementation?** | ⛔ **No** |

### §8.1 Closed by the re-verification pass — recorded, not silently dropped

> `PRD_LIFECYCLE.md` Stage 3: *"A rejected finding must be recorded as rejected,
> with its reason."*

| Prior finding | Disposition | Reason |
|---|---|---|
| A6/A7 have "zero repository existence" | ⛔ **REJECTED — measurement error** | `PRD_REGISTRY.md` §11.4: both **AUTHORIZED 2026-08-31** as `PRD-021A` parts by `ADR-0083` |
| Moderation counterparty undefined | ✅ **CLOSED** | **`BC-13`** keeps `ModerationCase` (BC Map L379); A6 is a local projection reader only |
| Notification counterparty undefined | ✅ **CLOSED** | **`BC-22`** keeps delivery via `E-23` (L332) |
| `BC-11` not an identity-event consumer | ⛔ **REJECTED** | BC Map **L425-428** list `BC-11` for four `BC-10` events |
| B3 placement is a style preference | ⛔ **REJECTED** | `MembershipValidity` is `studentRecordId`-keyed ⇒ **unbuildable** in `domain/social` |
| `ADR-0089`/`0091`/`0092` are required gates | ⛔ **REJECTED** | Resolvable on existing authority; an ADR would **create** authority not asked for |

---

## §9. Status

> ## `PRD-021B` STATUS: **DRAFT / STAGE 2**

⛔ **NOT** `READY`. ⛔ **NOT** `APPROVED`. ⛔ **NOT** `FROZEN`. ⛔ **NOT**
Stage 3. ⛔ **NOT** implementation-ready.

| Claim | Permitted? | Reason |
|---|---|---|
| `DRAFT` / Stage 2 | ✅ **This is the claim made** | `PRD_REGISTRY.md` §2 entry evidence: *"A document on disk with a version header"* — satisfied by B0–B3 |
| Stage 3 / `IN_REVIEW` | ⛔ No | Stage 3 gate is *"a written alignment record"* — none exists |
| `APPROVED` | ⛔ No | Requires an alignment/validation record with a verdict |
| `FROZEN` | ⛔ No | Requires a row in `DOCUMENTATION_BASELINE.md` §3 — none written, none requested |
| Implementation-ready | ⛔ No | Stage 5 and Stage 6 not performed; **0** `IMPL-*` allocated |

**Exact next step: Stage 3 — Architecture Review.** Its gate is a **written
alignment record** naming every conflict and its disposition, validated against
the six checks in `PRD_LIFECYCLE.md` §3 Stage 3, in order.

---

## §10. What `PRD-021B` does not do

⛔ Creates no bounded context — count remains **31** · ⛔ mints no `BC-`
identifier · ⛔ creates no integration edge · ⛔ mints no published event ·
⛔ mints no `IMPL-*` identifier · ⛔ creates no implementation task · ⛔ amends no
frozen PRD (`PRD-020`, `PRD-021A` A1, `Student_Identity_PRD_v1`, `PRD-017` all
byte-unchanged) · ⛔ amends no Rank 1–5 artefact (BC Map, EA, Matrix,
`MASTER_PRD` byte-unchanged) · ⛔ modifies no CI rule
(`tool/module_dependencies.yaml` byte-unchanged) · ⛔ creates no ADR file ·
⛔ ratifies no proposed ADR · ⛔ resolves neither `FOD-1` nor `FOD-2` ·
⛔ claims no Stage 3 alignment · ⛔ records no acceptance criterion as passing ·
⛔ writes no application code.

---

**END — `PRD-021B` Part B0 v0.1 — DRAFT / Stage 2.**
