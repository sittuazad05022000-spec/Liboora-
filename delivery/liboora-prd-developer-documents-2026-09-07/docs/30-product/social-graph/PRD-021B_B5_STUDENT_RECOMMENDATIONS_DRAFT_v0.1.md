<!--
  PRD-021B — Part B5 — Student Recommendations ("People You May Know")
  DRAFT v0.1 — Stage 2

  PROVENANCE
  ----------
  Authored from the supplied B5 specification, reconciled against measured
  repository authority.

  ⚠ THE CENTRAL CONFLICT, STATED HERE SO IT CANNOT BE MISSED
  ----------------------------------------------------------
  The supplied specification says "V1 remains LIBRARY-FIRST / PEOPLE YOU MAY
  KNOW". The repository says otherwise, in four places:

    EA L930          Recommended Students (V2)
    EA L943          Friend Suggestions (V3)
    B3 SDS-BR-017    Recommendation is "V2/V3, NOT specified"
    B3 SDS-XC-006    "B3 MUST NOT implement recommendation logic"
    B0 §2 row 9      Recommendation -> BC-23, "V2/V3, not specified"

  Four authorities to zero. There is no dissenting repository line.

  This document therefore specifies B5 COMPLETELY but marks the capability
  V2-GATED. It does NOT silently promote a V2 capability into V1, and it does
  NOT refuse to author. The wave question is recorded as XPB-CONF-002, OPEN,
  owner = Architecture Owner + Product Owner.

  Status        : DRAFT — v0.1 (Stage 2)
  Freeze status : NOT FROZEN. NOT FINAL. NOT APPROVED. NOT BASELINED.
  Lifecycle     : Stage 2 (Draft) ONLY. Stage 3 and Stage 4 NOT entered.

  What this file does NOT do
    - It creates no bounded context. The count remains 31.
    - It creates no integration edge and mints no published event.
    - It amends no FROZEN PRD and no Rank 1-5 artefact.
    - It does NOT promote a V2 EA capability to V1.
    - It mints no IMPL-* identifier and creates no implementation task.
-->

# PRD-021B — PART B5

## Student Recommendations — Library-First "People You May Know"

### Specification v0.1 — Stage 2 (Draft) — ⚠ **V2-GATED**

> ⚠ **DRAFT — NOT FROZEN, NOT FINAL, NOT APPROVED.** Stage 3 and Stage 4 have
> **not** been entered.
>
> ⛔ **WAVE WARNING.** The repository places this capability at **V2**
> (EA **L930**) and its friend-suggestion form at **V3** (EA **L943**). This
> document specifies it **fully** but claims **no V1 release**. See §B5.2.

---

## §0. Document control

### §0.1 Status header

| Field | Value |
|---|---|
| Document | `PRD-021B` Part B5 — Student Recommendations |
| Version | **v0.1** |
| Status | **DRAFT** |
| Lifecycle stage | **Stage 2 (Draft)** — Stage 3 / Stage 4 NOT entered |
| Capability wave | ⚠ **V2** by repository authority (EA **L930**). ⛔ **No V1 claim** |
| Architectural form | **Read composition (`AR-1` shape)** — ⛔ **not** a bounded context |
| Contexts consumed | `BC-11` (relationships, via B1) · `BC-10` (privacy) · `BC-02` (membership, via `E-02`) · `BC-23` (candidate set) · `BC-25` (configuration via `E-19`) · `BC-24` (audit via `E-20`) · `BC-22` (notification via `E-23`, if surfaced) |
| Context count | **31** — unchanged |
| Edges created | **0** · Events minted | **0** |
| Freeze | ⛔ **NOT FROZEN** |
| Open conflicts | `XPB-CONF-002` (wave), `XPB-CONF-004` (candidate source) — both **OPEN** with owners |

### §0.2 Identifier registers — declared up front, with ranges

| Register | Meaning | Range | Count |
|---|---|---|---|
| `PYK-FR-nnn` | Functional requirement | `001`–`006` | **6** |
| `PYK-BR-nnn` | Business rule | `001`–`005` | **5** |
| `PYK-SRC-nnn` | Candidate source (with verdict) | `001`–`007` | **7** |
| `PYK-POL-nnn` | Recommendation policy rule | `001`–`008` | **8** |
| `PYK-FB-nnn` | Feedback rule | `001`–`006` | **6** |
| `PYK-SUP-nnn` | Suppression rule | `001`–`008` | **8** |
| `PYK-FRQ-nnn` | Frequency-control rule | `001`–`006` | **6** |
| `PYK-PRS-nnn` | Presentation rule | `001`–`007` | **7** |
| `PYK-CFG-nnn` | Configurable — default **and** range | `001`–`007` | **7** |
| `PYK-PRV-nnn` | Privacy rule | `001`–`007` | **7** |
| `PYK-SEC-nnn` | Security rule | `001`–`004` | **4** |
| `PYK-EC-nnn` | Edge case | `001`–`012` | **12** |
| `PYK-XC-nnn` | Explicit exclusion (what must be impossible) | `001`–`018` | **18** |
| `PYK-SCOPE-nnn` | V1 / Future scope statement | `001`–`005` | **5** |
| `PYK-AC-nnn` | Acceptance criterion (GWT) | `001`–`024` | **24** |
| `PYK-GAP-nnn` | Disclosed gap — OPEN, with owner | `001`–`005` | **5** |
| **Total** | | | **135** |

Ranges contiguous `001..max` — **measured, not asserted**.
⛔ No `IMPL-*` identifier minted.

⚠ **Note on register sizes.** `PYK-FR` and `PYK-BR` are deliberately small
because B5's normative weight sits in its **policy**, **suppression** and
**exclusion** registers — which is the correct shape for a part whose whole job
is to *not* bypass other owners' rules.

### §0.3 Prefix collision — executed before writing

`PYK-` measured **0** occurrences across `docs/` prior to authoring.
⚠ `REC-` was **rejected**: it collides with `BC-26`'s `Report`/record vocabulary
and with `AbuseReport` disambiguation at BC Map **L206**.

### §0.4 Normative language

**MUST**/**MUST NOT** absolute · **SHOULD**/**SHOULD NOT** strong · **MAY**
optional · ⛔ prohibition · ⚠ disclosed defect/gap/risk · ⭐ load-bearing.

---

## §B5.1 Architectural form

`PYK-FR-001` — B5 is a **read composition** (`AR-1` shape): it owns no aggregate,
no invariant and no business state, and orchestrates public read models only.

⚠ **One honest qualification.** Feedback (§B5.7) and suppression (§B5.8) imply
**per-viewer persisted state**, which a pure read composition cannot hold. That
tension is real and is **not papered over** — it is `PYK-GAP-002`, and §B5.7
specifies the behaviour while explicitly **refusing to site the store**.

`PYK-XC-001` — ⛔ B5 **MUST NOT** create a bounded context. Count stays **31**.
`PYK-XC-002` — ⛔ B5 **MUST NOT** create an integration edge.
`PYK-XC-003` — ⛔ B5 **MUST NOT** mint a published event. `BC-11`'s surface is
closed at two (BC Map **L430**).

---

## §B5.2 ⭐ `XPB-CONF-002` — the wave conflict, recorded not overridden

| Field | Value |
|---|---|
| **Supplied specification** | *"V1 remains LIBRARY-FIRST / PEOPLE YOU MAY KNOW."* |
| **Repository authority** | EA **L930** `Recommended Students (V2)` · EA **L943** `Friend Suggestions (V3)` · B3 `SDS-BR-017` *"Recommendation is system-initiated with no explicit query — ⛔ **V2/V3, NOT specified**"* · B3 `SDS-XC-006` *"⛔ B3 **MUST NOT** implement recommendation logic"* · B0 §2 row 9 `Recommendation → BC-23 — V2/V3, not specified` |
| **Count** | **4 authorities to 0.** ⛔ No repository line places student recommendation in V1 |
| **Already resolved?** | ⛔ **No.** Unlike `FOD-3` (where EA contradicted *itself* 4-to-1 and the majority could be followed), here the repository is **unanimous** and the dissent comes from the **instruction**, not from a document |
| **Why I cannot simply comply** | `PRD_LIFECYCLE.md` Stage 4 check 6: *"Business rules do not contradict Rank 1 — **Rank 1 wins; the PRD is wrong**."* The EA is **Rank 4** and unanimous. Promoting a V2 capability to V1 in a Stage-2 draft would be exactly the *"silent override"* the instruction forbids |
| **Disposition** | B5 is specified **completely** and marked **V2-GATED**. Every requirement is written so that it is correct whenever the wave opens. ⛔ **No V1 release is claimed** |
| **Smallest compatible resolution** | **One** of: (a) a Product-Owner wave decision recorded in the EA changelog moving `Recommended Students` L930 `(V2)` → `(V1)`; or (b) accept B5 as V2 and ship only B3 search + B4 ordering in V1. ⛔ Neither is taken here |
| **Owner** | **Architecture Owner** (EA document owner) **+ Product Owner** (wave decision) |
| **Status** | ⛔ **OPEN** — `PYK-GAP-001` |
| **Blocks authoring?** | ⛔ No |
| **Blocks release?** | ✅ **Yes, absolutely** |

`PYK-SCOPE-001` — ⚠ Every requirement in this document is **specified but NOT
RELEASED** until `XPB-CONF-002` closes. ⛔ No acceptance criterion here may be
cited as evidence of a **V1** capability.

`PYK-XC-004` — ⛔ **It MUST be IMPOSSIBLE for a recommendation surface to be
enabled while `XPB-CONF-002` is OPEN.** Enforced by a server-side capability
flag defaulting to **OFF** (`PYK-CFG-001`), owned by `BC-25` via `E-19`.
Precedent: this is the same degraded-ship-mode discipline B2 `SSF-AC-028` uses
for mute while `FOD-2` is open.

---

## §B5.3 Ownership — B5 duplicates nothing

| Concern | Owner | Repository basis | B5's relationship |
|---|---|---|---|
| Candidate eligibility / discovery composition | **B3** | `SDS-FR-017` read contract | ▶ Consumes; ⛔ never re-derives |
| Ordering / scoring | **B4** | `DRK-FR-005` | ▶ Delegates; ⛔ never scores |
| Text relevance / index | **`BC-23`** | BC Map **L132** | ⛔ Never touches |
| Relationships (friend, request, block) | **`BC-11`** via **B1** | BC Map **L377** | ▶ Reads signals |
| Safety / block / mute enforcement | **`BC-11`** graph-level + **`BC-13`** | B2; `TSF-XC-004`/`005` | ▶ Consumes as hard filter |
| Identity, profile, privacy | **`BC-10`** | BC Map **L376** | ▶ Projection only |
| Membership validity | **`BC-02`** | `E-02`, `MM-BR-011` | ▶ Consumes `MembershipValidity` |
| Scope (library/global/local/nearby) | **B6** | `GLS-FR-002` | ▶ Obeys; ⛔ never sets |
| Notification delivery | **`BC-22`** via `E-23` | BC Map **L332** | ▶ Requests only |
| Configuration | **`BC-25`** via `E-19` | BC Map **L328** | ▶ Reads typed config |
| Audit | **`BC-24`** via `E-20` | BC Map **L329** | ▶ Emits records |

`PYK-FR-002` — ⭐ B5 **MUST** obtain candidates **only** by calling B3's published
read contract and **MUST** order them **only** by calling B4.
`PYK-XC-005` — ⛔ B5 **MUST NOT** implement eligibility, privacy or safety
filtering of its own. Re-implementing a filter creates a second source of truth
and a second place for it to be wrong.
`PYK-XC-006` — ⛔ B5 **MUST NOT** implement a scoring function, weight or
ordering key. Owner: B4.
`PYK-XC-007` — ⛔ B5 **MUST NOT** read `BC-10`'s store, `BC-11`'s store,
`BC-02`'s store or `BC-23`'s index directly.

---

## §B5.4 ⭐ Candidate sources — every one verified

| ID | Requested source | Exists? | Authorised path | Verdict |
|---|---|---|---|---|
| `PYK-SRC-001` | **Same-library members** | ✅ | `E-02` `MembershipValidity` — B3 `SDS-FR-004`; `MM-BR-006` allowlist | ✅ **AUTHORISED** — the primary V1-shaped source |
| `PYK-SRC-002` | **Friends-of-friends (2nd degree)** | ✅ data exists in `BC-11` | B1 `SGR-FR-025` derives a mutual **count**; ⚠ **traversal** is a different operation | ⚠ **PARTIAL** → `PYK-GAP-003` |
| `PYK-SRC-003` | **Pending / historical requests** | ✅ | `BC-11` `FriendRequest` (BC Map **L377**) | ✅ **AUTHORISED** — as **suppression** only (`PYK-SUP-002`) |
| `PYK-SRC-004` | **Common interests / tags** | ⛔ | No V1 interest store measured; `Common Interests` **V2** (EA **L931**) | ⛔ **REFUSED — V2** |
| `PYK-SRC-005` | **Same study hall / co-attendance** | ⛔ | **0** edges `BC-03`/`BC-04` → `BC-11` in BC Map §7; `X-05` bans `domain/library/**` (CI **L265**) | ⛔ **REFUSED** → `PYK-GAP-004` |
| `PYK-SRC-006` | **Nearby / geographic** | ⛔ | `Nearby Students` **V2** (EA **L929**); B6 sets NEARBY **OFF** | ⛔ **REFUSED — V2** |
| `PYK-SRC-007` | **Contact-book / phone-book import** | ⛔ | **0** occurrences measured; would require a new `BC-10` capability and a privacy review | ⛔ **REFUSED — not specified anywhere** |

⭐ **4 of 7 requested sources are refused, 1 partial.** ⛔ **No source was
invented.** Each refusal cites the measurement that produced it.

`PYK-BR-001` — ⚠ **`PYK-SRC-002` is the hinge and it is only partial.** B1
authorises a mutual-connection **count** for an *already-identified* pair
(`SGR-FR-025`). Enumerating *"friends of my friends whom I do not yet know"* is a
**graph traversal producing new candidates** — a different operation, and B1
does not authorise it. ⛔ It is **not** assumed here.

`PYK-GAP-003` — **OPEN.** Second-degree candidate enumeration requires either an
explicit B1 requirement or a `BC-11` read-model addition. Owner: **`BC-11` owner
+ ARB**. ⚠ Until then, `PYK-SRC-001` is the **only** fully authorised generative
source, which — combined with `XPB-CONF-002` — means a lawful V1 "People You May
Know" would consist of *same-library members you are not yet connected to*,
ordered by B4. ⭐ That is a coherent product, and it is deliberately the **only**
one this document claims is buildable today.

---

## §B5.5 Generation

`PYK-FR-003` — B5 **MUST** generate a recommendation set by: [1] requesting a
scope from B6; [2] requesting candidates from B3 within that scope; [3] applying
suppression (§B5.8); [4] requesting ordering from B4; [5] applying frequency
control (§B5.9); [6] presenting (§B5.10).
`PYK-FR-004` — ⭐ Generation **MUST** be **system-initiated** with no viewer
query. This is precisely what distinguishes it from search (B3 `SDS-BR-016`).
`PYK-XC-008` — ⛔ **Search and recommendation MUST remain separate surfaces.**
Authority: B3 `SDS-XC-005` — conflating them *"would place a V2/V3 capability
inside a V1 deliverable."*
`PYK-FR-005` — Generation **MUST** be reproducible: same viewer, same `asOf`,
same configuration ⇒ same set. Inherits B4 `DRK-DET-001`.
`PYK-FR-006` — ⛔ B5 **MUST NOT** generate a recommendation for a viewer with no
valid library membership. Authority: `E-02` `MembershipValidity`; B3
`SDS-FR-004`.
`PYK-BR-002` — Generation **MUST** be a **read-only** operation with respect to
every other context. ⛔ It creates no relationship and sends no request.
`PYK-XC-009` — ⛔ **It MUST be IMPOSSIBLE for B5 to create, accept or imply a
relationship.** A recommendation is a suggestion; only B1 mutates the graph
(`SGR-` requirements). A B5 path that writes a `Friendship` or `FriendRequest`
is a defect.

---

## §B5.6 ⭐ Policy — recommendations cannot bypass anything

`PYK-POL-001` — ⭐ A recommendation **MUST** pass **every** filter a search
result passes: eligibility [1], privacy [2], safety [3]. Authority: **FROZEN**
`TSF-FR-023` — *"A person under `SUSPENSION`, `TERMINATION` or
`DISCOVERY_RESTRICTION` **MUST NOT** appear in any discovery result,
**recommendation** or search suggestion."* ⚠ Note that frozen text names
recommendation **explicitly**.
`PYK-POL-002` — ⭐ **FROZEN** `TSF-INV-005`: *"A ranking or **recommendation**
path that reaches the index without step 3 is a defect."* B5 **MUST** therefore
reach candidates **only** through B3 (`PYK-FR-002`).
`PYK-XC-010` — ⛔ **It MUST be IMPOSSIBLE for B5 to reach `BC-23`'s index
directly.** Enforced by construction: B5 has no index client and no query path.
Testable by dependency inspection (`PYK-AC-005`).
`PYK-POL-003` — ⛔ A blocked person (either direction) **MUST NOT** be
recommended. Authority: `TSF-XC-004`; B1 `SGR-` block rules.
`PYK-POL-004` — ⛔ A person whose privacy mode excludes them from discovery
**MUST NOT** be recommended. Authority: `BC-10` `PrivacySettings` (BC Map
**L376**); *"privacy default = most restrictive"*; *"minors cannot set profile to
public."*
`PYK-POL-005` — ⛔ A recommendation **MUST NOT** disclose why a person was
recommended in a way that reveals a private attribute or another person's
relationship. See `PYK-PRS-004`.
`PYK-POL-006` — ⛔ A recommendation **MUST NOT** be generated across libraries.
Authority: B6 `GLS-FR-002`; B3 `SDS-BR-012`; `X-05`.
`PYK-POL-007` — Recommendation manipulation signals (reciprocal-follow rings,
mass-follow-then-unfollow) are **`BC-13`'s**, not B5's. Authority: **FROZEN**
`TSF-FR-025`. ⛔ B5 **MUST NOT** implement ring detection.
`PYK-POL-008` — ⛔ B5 **MUST NOT** make an authorisation decision. Owner:
`BC-18` (`X-13`).

`PYK-PRV-001` — ⛔ B5 **MUST NOT** read a non-allow-listed profile field
(`SID-4.39`).
`PYK-PRV-002` — ⛔ Exclusion **MUST** be indistinguishable from non-existence: a
suppressed or filtered person **MUST NOT** produce a placeholder, a count
difference or a tombstone. Authority: **FROZEN** `TSF-FR-024`; `MP-GBR-22`.
`PYK-PRV-003` — ⛔ B5 **MUST NOT** publish the reason for an exclusion to a
peer-facing surface. Authority: **FROZEN** `TSF-XC-030`.
`PYK-PRV-004` — ⛔ B5 **MUST NOT** reveal that person A was recommended to
person B.
`PYK-PRV-005` — A minor's recommendation set **MUST** apply the most restrictive
privacy default. Authority: BC Map **L376**.
`PYK-PRV-006` — ⛔ Feedback data **MUST NOT** be readable by, or inferable to,
the recommended person.
`PYK-PRV-007` — ⛔ B5 **MUST NOT** carry a `tenantId` or `StudentRecordId` into
a social-side call. Authority: `ID-2` (BC Map **L488**); CI **L268-270**.

`PYK-SEC-001` — ⛔ **It MUST be IMPOSSIBLE for a client to supply, widen or
override the scope.** Scope comes from B6 server-side (`GLS-SEC-001`).
`PYK-SEC-002` — A request carrying a client-supplied scope, source or suppression
override **MUST** be rejected, not ignored.
`PYK-SEC-003` — Cursors **MUST** be opaque (`PG-1`…`PG-4`).
`PYK-SEC-004` — ⛔ B5 **MUST NOT** accept a client-supplied candidate list.

---

## §B5.7 Feedback

`PYK-FB-001` — A viewer **MUST** be able to dismiss a recommendation ("not
interested").
`PYK-FB-002` — A dismissal **MUST** suppress that person from the viewer's
recommendations for at least `PYK-CFG-004`.
`PYK-FB-003` — ⛔ A dismissal **MUST NOT** be visible to the dismissed person,
and **MUST NOT** alter any relationship, block or mute state.
`PYK-FB-004` — ⛔ A dismissal **MUST NOT** be a safety signal. It is a
preference. Routing it to `BC-13` would conflate preference with abuse —
compare `TSF-XC-005`'s reasoning that mute is *"a unilateral graph-visibility
preference, not a safety decision."*
`PYK-FB-005` — A viewer **MUST** be able to report a recommended person, and
that path **MUST** route to `BC-13` unchanged (B2's report routing). ⛔ B5
**MUST NOT** adjudicate.
`PYK-FB-006` — ⚠ **Feedback state has no sited store in this document.**

⭐ `PYK-GAP-002` — **OPEN and honest.** `PYK-FB-002` requires per-viewer
dismissal state, but B5 is an `AR-1` read composition that *"owns no business
state"*, and `Mute` is already blocked from BC Map §8 by `FOD-2` for exactly this
class of reason — a structure that has an owner but **no register row**.
⛔ **No aggregate is minted here and no BC Map append is assumed.**
Smallest compatible options, **not chosen**: (a) `BC-11` holds
`RecommendationSuppression` beside `BlockList` (needs the same Rank 4 append
`FOD-2` needs); (b) `BC-25` holds it as per-user configuration; (c) V1 ships
dismissal as **session-only, non-durable**, which needs no store.
Owner: **ARB**.

`PYK-XC-011` — ⛔ Until `PYK-GAP-002` closes, B5 **MUST NOT** claim durable
dismissal. ⚠ If a surface ships, it **MUST** ship option (c) or nothing —
mirroring B2's degraded-ship-mode precedent (`SSF-AC-028`).

---

## §B5.8 Suppression

| ID | Rule | Authority |
|---|---|---|
| `PYK-SUP-001` | ⛔ Existing friends **MUST NOT** be recommended | `BC-11` `Friendship` |
| `PYK-SUP-002` | ⛔ Anyone with a pending request in either direction **MUST NOT** be recommended | `BC-11` `FriendRequest`; `PYK-SRC-003` |
| `PYK-SUP-003` | ⛔ Anyone blocked in either direction **MUST NOT** be recommended | `TSF-XC-004`; `PYK-POL-003` |
| `PYK-SUP-004` | ⛔ Anyone muted by the viewer **SHOULD NOT** be recommended | `TSF-XC-005` (FROZEN); ⚠ gated by `FOD-2` |
| `PYK-SUP-005` | ⛔ The viewer themselves **MUST NOT** be recommended | Self-evident; still testable (`PYK-AC-009`) |
| `PYK-SUP-006` | ⛔ A dismissed person **MUST NOT** be recommended within the dismissal window | `PYK-FB-002`; ⚠ gated by `PYK-GAP-002` |
| `PYK-SUP-007` | ⛔ A person previously rejected by the viewer **MUST NOT** be re-recommended within `PYK-CFG-005` | `BC-11` request history |
| `PYK-SUP-008` | ⭐ Suppression **MUST** be applied **before** B4 ordering | `PYK-FR-003` step order |

`PYK-BR-003` — ⭐ Suppression **MUST NOT** be implemented by hiding at
presentation time. A suppressed person **MUST** be absent from the set, so that
counts, pagination and cursors cannot leak their existence. This is
`TSF-FR-024`'s *"indistinguishable from non-existence"* applied to pagination.
`PYK-XC-012` — ⛔ **It MUST be IMPOSSIBLE for a suppressed person to appear in a
page count, a total, a cursor or a "N more" indicator.**

---

## §B5.9 Frequency control

`PYK-FRQ-001` — The recommendation set **MUST** be capped at `PYK-CFG-002` items
per request.
`PYK-FRQ-002` — The set **MUST** be refreshed no more often than
`PYK-CFG-003`.
`PYK-FRQ-003` — ⛔ B5 **MUST NOT** send an unsolicited notification for a
recommendation in this version. If ever surfaced, delivery is `BC-22`'s via
`E-23` (BC Map **L332**) and ⛔ B5 **MUST NOT** deliver directly.
`PYK-FRQ-004` — ⚠ Per-viewer "already shown" capping is **NOT specified** — it
requires the same impression store B4 refused (`DRK-GAP-004`). ⛔ Not invented
here.
`PYK-FRQ-005` — Repeated requests within the refresh window **MUST** return a
stable set. Inherits B4 `DRK-FR-012`.
`PYK-FRQ-006` — ⛔ Frequency control **MUST NOT** be implemented by excluding a
person permanently without a recorded rule.

---

## §B5.10 Presentation

`PYK-PRS-001` — Each item **MUST** carry only allow-listed `BC-10` profile fields
(`SID-4.39`).
`PYK-PRS-002` — Each item **MAY** carry a mutual-connection **count** (B1
`SGR-FR-025`, V1 derivation).
`PYK-PRS-003` — ⛔ Each item **MUST NOT** carry a browsable mutual-friend
**list**. Authority: B1 `SGR-FR-027`; EA **L940** `Mutual Friends (V2)`.
`PYK-PRS-004` — ⭐ A reason string **MAY** be shown only when it discloses
nothing private. ⛔ *"You both know Alice"* **MUST NOT** be shown while
`SGR-FR-027` keeps the mutual **list** at V2 — naming the connector discloses the
list one element at a time. Permitted form: *"3 mutual connections."*
`PYK-PRS-005` — ⛔ No score, rank position or weight **MUST** be exposed.
Inherits B4 `DRK-PRV-003`, `DRK-EXP-004`.
`PYK-PRS-006` — Pagination **MUST** use opaque cursors (`PG-1`…`PG-4`).
`PYK-PRS-007` — ⛔ The surface **MUST NOT** imply that a recommendation was
endorsed by another person.

---

## §B5.11 Configuration — default **and** range

| ID | Configurable | Default | Range | Owner |
|---|---|---|---|---|
| `PYK-CFG-001` | ⭐ `capability.recommendationsEnabled` | **`false`** | `{true,false}` | `BC-25`; ⛔ **MUST** stay `false` while `XPB-CONF-002` is OPEN |
| `PYK-CFG-002` | `set.maxItems` | `10` | `1`–`50` | `BC-25` |
| `PYK-CFG-003` | `set.refreshIntervalHours` | `24` | `1`–`168` | `BC-25` |
| `PYK-CFG-004` | `dismissal.windowDays` | `90` | `1`–`365` | `BC-25`; ⚠ inert while `PYK-GAP-002` open |
| `PYK-CFG-005` | `rejectedRequest.cooloffDays` | `30` | `1`–`365` | `BC-25` |
| `PYK-CFG-006` | `minMutualConnections` | `0` | `0`–`10` | `BC-25` |
| `PYK-CFG-007` | `set.minItemsToShow` | `3` | `0`–`50` | `BC-25` |

`PYK-BR-004` — Out-of-range configuration **MUST** be rejected; ⛔ never clamped.
`PYK-BR-005` — ⛔ Configuration **MUST NOT** be client-supplied
(`PYK-SEC-002`).
`PYK-XC-013` — ⛔ B5 **MUST NOT** define a configuration store or flag
mechanism. Owner: `BC-25` (BC Map **L134**), reached by `E-19`.

---

## §B5.12 Scope — V1 · Future · Deferred

| ID | Statement | Wave | Authority |
|---|---|---|---|
| `PYK-SCOPE-001` | Whole capability specified, ⛔ **not released** | **V2-gated** | EA **L930**; `XPB-CONF-002` |
| `PYK-SCOPE-002` | Same-library "People You May Know" | ⚠ **V2** as written; would be the **only** lawful V1 shape if the wave opens | `PYK-SRC-001` |
| `PYK-SCOPE-003` | Friends-of-friends enumeration | ⏸ **DEFERRED** | `PYK-GAP-003` |
| `PYK-SCOPE-004` | `Friend Suggestions` (graph-native form) | **V3** | EA **L943** |
| `PYK-SCOPE-005` | Smart matching / AI recommendation | **V3 / Future** | EA **L932**, **L933** |

`PYK-XC-014` — ⛔ B5 **MUST NOT** implement `Smart Matching` or `AI Discovery`.
`PYK-XC-015` — ⛔ B5 **MUST NOT** recommend across libraries, globally, locally
or by proximity in V1. Enforced by B6.
`PYK-XC-016` — ⛔ B5 **MUST NOT** recommend a person who is not a member of the
viewer's library while B6 keeps GLOBAL **OFF**.
`PYK-XC-017` — ⛔ B5 **MUST NOT** recommend content, communities, groups,
libraries or seats. Its only subject is a person.
`PYK-XC-018` — ⛔ B5 **MUST NOT** cache a recommendation set in a shared or
cross-viewer cache. Any cache **MUST** be per-viewer and **MUST** be invalidated
on a privacy, block or membership change. Authority: B3 `SDS-CACHE-*`;
`identity.PersonPrivacyModeChanged` has *"no propagation window"* (BC Map
**L427**).

---

## §B5.13 Edge cases

| ID | Case | Required behaviour |
|---|---|---|
| `PYK-EC-001` | No candidates after suppression | Return empty set; ⛔ no padding, no relaxation |
| `PYK-EC-002` | Fewer candidates than `PYK-CFG-007` | Return what exists; ⛔ **MUST NOT** widen scope to fill |
| `PYK-EC-003` | Viewer has no valid membership | Return empty; ⛔ no error disclosing membership state |
| `PYK-EC-004` | Viewer is a minor | Most restrictive privacy default applied (`PYK-PRV-005`) |
| `PYK-EC-005` | Candidate blocked after generation, before display | Not re-filtered mid-flight; next generation excludes them; ⛔ no stale cache serves them (`PYK-XC-018`) |
| `PYK-EC-006` | Candidate suspended after generation | Same as `PYK-EC-005`; cache invalidated on safety change |
| `PYK-EC-007` | B4 unavailable | Return B3's order; record degradation (inherits `DRK-BR-003`) |
| `PYK-EC-008` | B3 unavailable | Return empty; ⛔ **MUST NOT** fall back to an unfiltered source |
| `PYK-EC-009` | B6 returns a scope other than LIBRARY in V1 | Reject the request as a B6 defect |
| `PYK-EC-010` | Viewer dismisses every candidate | Empty set; ⛔ no re-surfacing inside the window |
| `PYK-EC-011` | `recommendationsEnabled = false` | Surface returns *not enabled*; ⛔ no partial set |
| `PYK-EC-012` | Duplicate candidate from two sources | Deduplicate by `PersonId` **before** B4 (⛔ B4 may not dedupe — `DRK-EC-010`) |

---

## §B5.14 Acceptance criteria — 24, all GWT, all mapped

| ID | Given | When | Then (measurable) | Requirement |
|---|---|---|---|---|
| `PYK-AC-001` | ⭐ `XPB-CONF-002` is OPEN | The recommendation surface is requested | Surface reports *not enabled*; `recommendationsEnabled` reads `false` | `PYK-XC-004`, `PYK-CFG-001` |
| `PYK-AC-002` | A suspended person in the library | Recommendations generated | They are absent from the set | `PYK-POL-001` |
| `PYK-AC-003` | A person blocked by the viewer | Recommendations generated | They are absent | `PYK-POL-003`, `PYK-SUP-003` |
| `PYK-AC-004` | A person who blocked the viewer | Recommendations generated | They are absent | `PYK-SUP-003` |
| `PYK-AC-005` | B5's hosting module | Dependencies inspected | ⛔ No `BC-23` index client and no query path exists | `PYK-XC-010`, `PYK-POL-002` |
| `PYK-AC-006` | An existing friend | Recommendations generated | They are absent | `PYK-SUP-001` |
| `PYK-AC-007` | A pending outbound request | Recommendations generated | That person is absent | `PYK-SUP-002` |
| `PYK-AC-008` | A person with discovery-restricting privacy | Recommendations generated | They are absent | `PYK-POL-004` |
| `PYK-AC-009` | The viewer | Recommendations generated | The viewer is absent from their own set | `PYK-SUP-005` |
| `PYK-AC-010` | A suppressed person | Page count and cursor inspected | ⛔ No count, total or indicator reveals their existence | `PYK-XC-012`, `PYK-BR-003` |
| `PYK-AC-011` | A viewer with no valid membership | Recommendations requested | Empty set; ⛔ response does not disclose membership state | `PYK-FR-006`, `PYK-EC-003` |
| `PYK-AC-012` | A request with a client-supplied scope | Received | Rejected, not ignored | `PYK-SEC-001`, `PYK-SEC-002` |
| `PYK-AC-013` | A recommendation item | Payload inspected | ⛔ Contains no score, weight or rank rationale | `PYK-PRS-005` |
| `PYK-AC-014` | A recommendation item | Payload inspected | ⛔ Contains no browsable mutual-friend list; a count only | `PYK-PRS-002`, `PYK-PRS-003` |
| `PYK-AC-015` | A reason string is shown | Inspected | ⛔ Names no connector; count form only | `PYK-PRS-004` |
| `PYK-AC-016` | A viewer dismisses a recommendation | The dismissed person's view is inspected | ⛔ They observe no change of any kind | `PYK-FB-003` |
| `PYK-AC-017` | A dismissal occurs | `BC-13` queue inspected | ⛔ No safety signal was routed | `PYK-FB-004` |
| `PYK-AC-018` | A viewer reports a recommended person | `BC-13` inspected | Report routed unchanged; ⛔ B5 made no adjudication | `PYK-FB-005` |
| `PYK-AC-019` | B3 is unavailable | Recommendations requested | Empty set; ⛔ no unfiltered fallback source is used | `PYK-EC-008` |
| `PYK-AC-020` | B4 is unavailable | Recommendations requested | B3's order returned; degradation recorded | `PYK-EC-007` |
| `PYK-AC-021` | Fewer candidates than the minimum | Recommendations generated | Short set returned; ⛔ scope not widened | `PYK-EC-002`, `PYK-XC-015` |
| `PYK-AC-022` | A privacy-mode change occurs | Cached set inspected | Cache invalidated; ⛔ no stale entry served | `PYK-XC-018` |
| `PYK-AC-023` | A social-side B5 call | Payload inspected | ⛔ Contains no `tenantId` and no `StudentRecordId` | `PYK-PRV-007` |
| `PYK-AC-024` | ⚠ `PYK-GAP-002` is OPEN | Dismissal durability is tested | Dismissal is session-only; ⛔ no durable store is claimed | `PYK-XC-011`, `PYK-FB-006` |

⭐ **24 ACs · 24 map to a requirement · 0 orphans.**
⚠ `PYK-AC-001` and `PYK-AC-024` assert the **gated/degraded** state, not a
working capability — deliberately, because claiming otherwise would be false.

---

## §B5.15 Disclosed gaps — OPEN, each with an owner

| ID | Gap | Blocks authoring? | Blocks release? | Owner |
|---|---|---|---|---|
| `PYK-GAP-001` | ⭐ `XPB-CONF-002` — EA places recommendation at **V2**; instruction asks for V1 | ⛔ No | ✅ **Yes** | **Architecture Owner + Product Owner** |
| `PYK-GAP-002` | ⭐ Dismissal/suppression state has no sited store; `AR-1` form owns no state | ⛔ No | ⚠ Durable dismissal only | **ARB** |
| `PYK-GAP-003` | Second-degree candidate enumeration not authorised by B1 | ⛔ No | ⚠ That source only | **`BC-11` owner + ARB** |
| `PYK-GAP-004` | Co-attendance source blocked by `X-05` with **0** edges | ⛔ No | ⛔ No — refused | **Architecture Owner** |
| `PYK-GAP-005` | Mute-based suppression (`PYK-SUP-004`) depends on `FOD-2` | ⛔ No | ⚠ Partial | **ARB** |

---

## §B5.16 What B5 does **not** do

⛔ Creates no bounded context (**31**) · ⛔ creates no edge · ⛔ mints no event ·
⛔ mints no `PERM-*` · ⛔ mints no `IMPL-*` · ⛔ creates no aggregate or store ·
⛔ mutates no relationship · ⛔ filters, scores or ranks · ⛔ reads any index ·
⛔ makes an authorisation decision · ⛔ promotes a V2 EA capability to V1 ·
⛔ amends any frozen PRD or Rank 1–5 artefact · ⛔ modifies a CI rule · ⛔ creates
an ADR · ⛔ resolves `XPB-CONF-002` · ⛔ modifies any B0/B1/B2/B3/B4 requirement ·
⛔ claims Stage 3 or Stage 4 · ⛔ writes application code.

---

## §B5.17 Status

> ## `PRD-021B` Part B5 STATUS: **DRAFT / STAGE 2** · ⚠ **V2-GATED**

⛔ **NOT** Stage 3. ⛔ **NOT** Stage 4. ⛔ **NOT** `APPROVED`. ⛔ **NOT**
`FROZEN`. ⛔ **NOT** V1. ⛔ **NOT** implementation-ready.

**Exact next step: Stage 3 — Architecture Review.** ⚠ `XPB-CONF-002` is a
**wave** decision for the Architecture Owner and Product Owner; ⛔ it cannot be
closed by authoring, and it is not closed here.

---

**END — `PRD-021B` Part B5 v0.1 — DRAFT / Stage 2.**
