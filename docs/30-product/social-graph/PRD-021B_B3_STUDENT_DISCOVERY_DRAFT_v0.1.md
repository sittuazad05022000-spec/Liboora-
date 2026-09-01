<!--
  PROVENANCE — PRD-021B Part B3

  Purpose of this file
  --------------------
  CONTEXT-LOSS RECOVERY / CONTINUITY ARTEFACT.

  Status        : DRAFT — v0.1 (Stage 2)
  Freeze status : NOT FROZEN. NOT FINAL. NOT APPROVED. NOT BASELINED.
  Lifecycle     : Stage 2 (Draft) ONLY. Stage 3 NOT entered.
  Open items    : FOD-1 and FOD-2 remain ⛔ OPEN (neither blocks B3).
                  ADR-0092 is PROPOSED ONLY and is NOT ratified. B3's AR-1
                  determination rests on the EXISTING AR-1 ruling, not on a new
                  ADR. No new BC- identifier is minted. Context count remains 31.

  ⭐ B3 IS A READ COMPOSITION, NOT A BOUNDED CONTEXT.
  It owns no aggregate, no invariant and no business state. It composes public
  read models produced by existing owners. This is the AR-1 shape, already ruled
  for Library Discovery (BC Map L86 and L558, ADR-INDEX L150, MASTER_PRD module
  19, restated in PRD-020 section 8).

  ⭐ B3 MUST NOT BE PLACED IN domain/social.
  MembershipValidity is keyed on studentRecordId, a CI-banned symbol inside the
  social module. The alternative placement is unbuildable, not merely
  inadvisable. See SDS-XC-002.

  What this file does NOT do
  --------------------------
    - It creates no bounded context. The count remains 31.
    - It creates no integration edge or published event.
    - It amends no FROZEN PRD and no Rank 1-5 artefact.
    - It invents no B4/B5/B7/B8/B9 system, owner or consumer.
    - It mints no IMPL-* identifier and creates no implementation task.
-->

# PRD-021B — PART B3

## Student Discovery — Library-First Discovery & Read Composition

### Specification v0.1 — Stage 2 (Draft)

> ⚠ **DRAFT — NOT FROZEN, NOT FINAL, NOT APPROVED.** Committed for context-loss
> recovery and continuity only. Stage 3 has **not** been entered.

---

## §0. Document control

### §0.1 Status header

| Field | Value |
|---|---|
| Document | `PRD-021B` Part B3 — Student Discovery |
| Version | **v0.1** |
| Status | **DRAFT** |
| Lifecycle stage | **Stage 2 (Draft)** — Stage 3 NOT entered |
| Architectural form | **Read composition (`AR-1` shape)** — ⛔ **not** a bounded context |
| Bounded contexts consumed | `BC-23` (index/ranking) · `BC-10` (privacy) · `BC-11` (eligibility/relationship) · `BC-02` (membership validity) |
| Context count | **31** — unchanged. ⛔ No `BC-` identifier minted |
| Freeze | ⛔ **NOT FROZEN** |
| Open decisions | `FOD-1`, `FOD-2` — ⛔ **neither blocks B3** |

### §0.2 Identifier registers — declared up front, with ranges

| Register | Meaning | Range | Count |
|---|---|---|---|
| `SDS-FR-nnn` | Functional requirement | `001`–`017` | **17** |
| `SDS-BR-nnn` | Business rule | `001`–`019` | **19** |
| `SDS-DM-nnn` | Data / projection rule | `001`–`006` | **6** |
| `SDS-API-nnn` | API behaviour rule | `001`–`004` | **4** |
| `SDS-PRV-nnn` | Privacy rule | `001`–`009` | **9** |
| `SDS-SEC-nnn` | Security rule | `001`–`008` | **8** |
| `SDS-IDX-nnn` | Search / index architecture rule | `001`–`010` | **10** |
| `SDS-PERF-nnn` | Performance rule | `001`–`008` | **8** |
| `SDS-CACHE-nnn` | Caching rule | `001`–`008` | **8** |
| `SDS-EC-nnn` | Edge case | `001`–`018` | **18** |
| `SDS-XC-nnn` | Explicit exclusion | `001`–`016` | **16** |
| `SDS-SCOPE-nnn` | V1 / Future scope statement | `001`–`003` | **3** |
| `SDS-AC-nnn` | Acceptance criterion (GWT) | `001`–`032` | **32** |
| `SDS-GAP-nnn` | Disclosed gap — OPEN | `001`–`003` | **3** |
| **Total** | | | **161** |

Ranges contiguous `001..max`. ⛔ No `IMPL-*` identifier minted.

### §0.3 Prefix collision — executed before writing

`SDS-` measured **0** occurrences across `docs/` prior to authoring. ✅ Free.
⚠ `SD-` was **rejected** as a stem (ambiguous tokenisation against `SID-`).

### §0.4 Normative language

**MUST**/**MUST NOT** absolute · **SHOULD**/**SHOULD NOT** strong, deviation
recorded · **MAY** optional · ⛔ prohibition · ⚠ disclosed defect/gap/risk.

---

## §B3.1 Architectural form — the `AR-1` determination

⭐ **B3 is a read composition, not a bounded context.** Tested against the four
criteria the repository already uses for Library Discovery:

| Criterion | Library Discovery (`AR-1`) | B3 Student Discovery | Verdict |
|---|---|---|---|
| Owns an aggregate? | *"owns **no aggregate**"* | No — every entity belongs to `BC-10`, `BC-11`, `BC-02`, `BC-23` | ✅ same |
| Owns an invariant? | *"no invariant"* | No — every rule enforced is another owner's | ✅ same |
| Owns business state? | *"no business state"* | No — composes only | ✅ same |
| What does it do? | *"orchestrates **public read models only**"* | Same | ✅ same |

Authority: BC Map **L86** and **L558**; `ADR-INDEX` **L150**; `MASTER_PRD`
module 19 (*"is likewise not a context"*); restated in `PRD-020` §8.

`SDS-XC-001` — ⛔ **No `BC-` identifier is minted for B3.** *"The context count
remains 31."* Precedent: `LCM-XC-001` (`PRD-021A` A1, FROZEN) did exactly this.

⚠ **This applies an existing ruling; it does not create a new one.** A proposed
`ADR-0092` would **record** the application, not confer authority. ⛔ It is not
created here and is **not** a gate — see `FOD-4`.

⭐ `SDS-XC-002` — ⛔ **B3's composition MUST NOT be placed in `domain/social`.**
Two independent, executable reasons:

1. **CI-banned symbol.** `tool/module_dependencies.yaml` L263-267 bans
   `StudentRecordId` and `TenantId` inside the social module.
2. **The canonical projection names one.** `MembershipValidity{studentRecordId,
   validUntil, seatQuota}` is the *"exact shape BC Map `E-02` specifies"*
   (`MM-FR-066`, `PRD-MEMBERSHIP-MANAGEMENT.md` **L538**).

⇒ Composing library-scoped eligibility inside `domain/social` is **unbuildable**,
not merely inadvisable. The composition sits on the **tenant side**, following
`LCM-RM-001`/`LCM-RM-017`.

---

## §B3.2 Library-first discovery

`SDS-SCOPE-001` — Discovery is **library-first**: the default and only V1
candidate scope is *people who share a library with the viewer*.
Authority: EA **L926-933** Student Discovery wave, `Search Students (V1)`.

`SDS-FR-001` — The viewer's candidate pool **MUST** be constrained to persons
holding a **valid** membership in at least one library where the viewer also
holds a valid membership.

`SDS-BR-001` — ⛔ Global (non-library-scoped) student browse is **NOT V1**.

`SDS-SCOPE-002` — **Future:** `Nearby Students (V2)`, `Recommended Students
(V2)`, `Common Interests (V2)` (EA L926-933); `Friend Suggestions (V3)`
(EA L943). ⛔ None specified here.

---

## §B3.3 The four-stage pipeline

⭐ `SDS-FR-002` — B3 **MUST** compose results in exactly this order. This is
**not** B3's invention — it is `PRD-020` §8.3, **FROZEN**:

| Step | Stage | Owner | B3's role |
|---|---|---|---|
| 0 | Candidate set | **`BC-23`** | consume |
| 1 | **Eligibility** (library membership) | **`BC-11`** answers as a boolean; validity from **`BC-02`** | orchestrate |
| 2 | **Privacy** | **`BC-10`** | orchestrate |
| 3 | **Safety** | **`BC-13`** *(and B2's graph-level block filter)* | orchestrate |
| 4 | **Ranking** | **`BC-23`** | ⛔ **consume only — B3 does NOT rank** |

⭐ `SDS-BR-002` — **Step [3] is non-bypassable.** `TSF-INV-005` (FROZEN):
*"Step [3] MUST run after [1] and [2] and MUST be non-bypassable. A ranking or
recommendation path that reaches the index without step 3 is a defect."*

`SDS-BR-003` — ⛔ No path **MAY** reach the index without steps [1]–[3].

`SDS-BR-004` — Steps **MUST** execute in order. Reordering is a defect.

---

## §B3.4 Library-scoped eligibility (step 1)

`SDS-FR-003` — Eligibility **MUST** be answered by `BC-11` **as a boolean**.
Authority: `E-22` (BC Map L331) — *"`BC-11` answers eligibility as a boolean and
never holds a `FileRef`."*

`SDS-FR-004` — Membership validity **MUST** be read from the **`MembershipValidity`
projection** owned by `BC-02`. Authority: `MM-FR-002` — *"MUST publish validity
as a read projection (`MembershipValidity`, `E-02`)"*; `MM-FR-066` — *"MUST be
implemented once, inside `BC-02`."*

`SDS-BR-005` — ⛔ B3 **MUST NOT** re-implement membership validity. `MM-FR-066`
says it is implemented **once**, inside `BC-02`.

`SDS-BR-006` — Suspended, cancelled and expired memberships **MUST NOT** be
treated as valid. Authority: `PRD-MEMBERSHIP-MANAGEMENT.md` **L392** — such
memberships *"**MUST NOT** appear as valid in the `MembershipValidity`
projection."*

`SDS-DM-001` — ⛔ The `MembershipValidity` shape **MUST NOT** cross into any
social-side structure. `ID-2`; CI `banned_symbols`.

---

## §B3.5 Student search

`SDS-FR-005` — The viewer **MUST** be able to search eligible students by an
allow-listed field set.
`SDS-FR-006` — Search **MUST** apply steps [1]–[3] before returning results.
`SDS-FR-007` — Zero results **MUST** be a valid outcome, indistinguishable from
"everyone was filtered".
`SDS-BR-007` — ⛔ Search **MUST NOT** reveal result counts prior to filtering.
`SDS-PRV-001` — ⛔ Search **MUST NOT** support lookup by mobile number.
Authority: `SID-4.41` — *"SHALL NOT support lookup by mobile number."*

---

## §B3.6 Public profile projection

`SDS-FR-008` — B3 **MUST** return a **projection** of the public profile, not the
profile entity.
`SDS-DM-002` — ⛔ **B3 MUST NOT define a profile entity.** `GlobalStudentProfile`
is `BC-10`'s (BC Map **L376**).
`SDS-DM-003` — ⛔ **B3 MUST NOT define a membership entity.** `Membership` is
`BC-02`'s (BC Map **L370**).
`SDS-DM-004` — The projection **MUST** contain only allow-listed fields.
`SDS-DM-005` — ⛔ **No persisted composed row, table, cache or materialised
view.** Precedent: `LCM-RM-006`.
`SDS-DM-006` — The projection **MUST** be composed at read time. Precedent:
`LCM-RM-001` (4-field projection composition), `LCM-RM-023`.

---

## §B3.7 Privacy filtering (step 2)

`SDS-PRV-002` — Privacy is owned by `BC-10` (BC Map L376: *"privacy default =
most restrictive; minors cannot set profile to public"*).
`SDS-PRV-003` — ⛔ B3 **MUST NOT** own, duplicate, override or cache privacy
policy.
⭐ `SDS-PRV-004` — Only **allow-listed** fields **MAY** be indexed. A never-public
field *"SHALL NOT be indexed at all, in any index, for any purpose"*
(`SID-4.39`, FROZEN).
⭐ `SDS-PRV-005` — A public→private transition **MUST** remove the person from
public search results *"as part of the same operation, not on the next scheduled
reindex"* (`SID-4.40`, FROZEN).
⭐ `SDS-PRV-006` — `identity.PersonPrivacyModeChanged` carries **"no propagation
window"** (BC Map **L427**). ⇒ There is **no** window in which a stale public
result is acceptable.
`SDS-PRV-007` — A minor's profile **MUST NOT** be discoverable as public
(BC Map L376).
`SDS-PRV-008` — ⛔ Privacy exclusion reasons **MUST NOT** be published
(`TSF-XC-030`).

---

## §B3.8 Safety filtering (step 3)

`SDS-FR-009` — B3 **MUST** apply B2's Safety Check to remove anyone blocked in
either direction relative to the viewer.
`SDS-BR-008` — The safety filter **MUST** be non-bypassable (`TSF-INV-005`).
⭐ `SDS-XC-003` — ⛔ **`BC-13` MUST NOT filter the result set itself.**
`TSF-XC-029` (FROZEN): *"T&S MUST NOT filter a discovery result set itself — it
has no query path into the graph (`F-3`)."* B3 **orchestrates**; it does not ask
`BC-13` to query the graph.
`SDS-PRV-009` — ⛔ **MUST NOT** publish the reason for a discovery exclusion
(`TSF-XC-030`, verbatim).
`SDS-SEC-001` — If the Safety Check cannot be evaluated, B3 **MUST** fail
**closed** — omit the candidate, never include it (`LCM-RM-025`).

---

## §B3.9 Relationship signals (B1 integration)

`SDS-FR-010` — Each result **MUST** carry the viewer-relative relationship status
(`SGR-FR-012`).
`SDS-FR-011` — Each result **MAY** carry a mutual-connection **count**
(`SGR-FR-025`).
`SDS-BR-019` — ⛔ A **browsable mutual list MUST NOT** be returned (V2 —
EA L940).
`SDS-BR-010` — Relationship signals **MUST** be computed at read time. ⛔ Not
cached (`LCM-RM-021`, `LCM-RM-023`).
`SDS-XC-004` — ⛔ B3 **MUST NOT** mutate the graph. Read-only.

---

## §B3.10 Multiple libraries, cross-library privacy, membership expiry

`SDS-FR-012` — A viewer in multiple libraries **MUST** see the **union** of
eligible candidates across those libraries.
`SDS-BR-011` — Sharing **any one** library is sufficient for eligibility.
⭐ `SDS-BR-012` — ⛔ **Cross-library isolation MUST hold for non-shared
libraries.** A viewer **MUST NOT** discover members of a library they do not
belong to. Authority: `X-05` (Matrix **L354**) — Library Management ⟷
`BC-11`…`BC-17` are **Separate Ways** because the alternative *"merges two
tenancy models and two privacy regimes."*
`SDS-BR-013` — ⛔ B3 **MUST NOT** disclose **which** shared library produced a
candidate. Disclosing it would leak the target's membership set.
⭐ `SDS-BR-009` — **Membership expiry removes discovery eligibility, and only
that.** An expired member drops out of step [1] and therefore out of results;
⛔ their **friendships persist** (`SGR-BR-014`). Discovery eligibility and
relationship existence are different questions with different owners.
`SDS-FR-013` — Expiry **MUST** take effect on the next read; ⛔ **MUST NOT** wait
for a scheduled reindex.

---

## §B3.11 Account lifecycle

`SDS-FR-014` — An anonymised person (`identity.PersonAnonymised`, BC Map L428)
**MUST** be absent from all results.
`SDS-FR-015` — A suspended person (`E-14`) **MUST** be absent from results.
`SDS-FR-016` — A person with **no** valid membership **MUST** be absent.
⚠ Account-lifecycle edge cases are tabulated in §B3.19 (`SDS-EC-011`, `SDS-EC-012`).

---

## §B3.12 Pagination

`SDS-API-001` — Results **MUST** use **cursor** pagination. ⛔ Offset pagination
**MUST NOT** be used.
`SDS-API-002` — The cursor **MUST** be opaque and **MUST NOT** encode any
`StudentRecordId` or `TenantId`.
`SDS-BR-014` — Filters [1]–[3] **MUST** be re-applied on **every** page. ⛔ A
cursor **MUST NOT** carry a pre-approved candidate list.
`SDS-API-003` — Page size **MUST** be bounded server-side.
`SDS-API-004` — ⚠ ⛔ No path, route, schema or status code is specified
(`ADR-0035` §5.5b class).

---

## §B3.13 Search and index architecture

`SDS-IDX-001` — The index is owned by **`BC-23`**. Authority: `E-21` (BC Map
**L330**) — `BC-01`, `BC-10` → `BC-23`, *"Search never reads domain tables."*
⭐ `SDS-IDX-002` — ⛔ **`BC-11` is deliberately NOT a `BC-23` consumer.**
`E-22` (BC Map L331): *"`BC-11` and `BC-13` are deliberately NOT consumers —
`ADR-0055` §3."*
`SDS-IDX-003` — ⛔ `BC-23` **MUST NOT** read this module's store. `SID-4.38`:
*"`BC-23` SHALL NOT read this module's store (`X-08`)."*
`SDS-IDX-004` — Discoverability **SHALL** be provided by `BC-23`, driven by
`BC-10`'s **events** (`SID-4.38`).
`SDS-IDX-005` — Only allow-listed fields indexed (`SID-4.39`).
`SDS-IDX-006` — ⛔ Never-public fields **MUST NOT** be indexed *"at all, in any
index, for any purpose"* (`SID-4.39`).
`SDS-IDX-007` — ⛔ B3 **MUST NOT** build a second index.
`SDS-IDX-008` — ⛔ B3 **MUST NOT** write to `BC-23`'s index.
`SDS-IDX-009` — Index membership on privacy change is same-operation
(`SID-4.40`).
`SDS-IDX-010` — ⛔ B3 **MUST NOT** query the index without steps [1]–[3]
(`TSF-INV-005`).

---

## §B3.14 Candidate generation vs search vs recommendation

`SDS-BR-015` — **Candidate generation** (step 0) is `BC-23`'s.
`SDS-BR-016` — **Search** is a viewer-initiated query with explicit terms —
**V1**.
`SDS-BR-017` — **Recommendation** is system-initiated with no explicit query —
⛔ **V2/V3, NOT specified.** Authority: EA `Recommended Students (V2)`,
`Friend Suggestions (V3)`.
⭐ `SDS-XC-005` — ⛔ **Search and recommendation MUST remain separate surfaces.**
Conflating them would place a V2/V3 capability inside a V1 deliverable.
`SDS-XC-006` — ⛔ B3 **MUST NOT** implement recommendation logic.

---

## §B3.15 No ranking in B3

⭐ `SDS-XC-007` — ⛔ **B3 MUST NOT rank.** Ranking is step **[4]**, owned by
**`BC-23`** (`PRD-020` §8.3, FROZEN).
`SDS-BR-018` — B3 **MUST** return results in the order `BC-23` supplies, after
filtering. Filtering **MUST NOT** reorder.
`SDS-XC-008` — ⛔ No score, weight, boost, relevance tuning or personalisation
signal in B3.

---

## §B3.16 External consumers — B4/B5/B7/B8/B9

⭐ `SDS-XC-009` — ⛔ **Consumer/owner not currently defined in repository.**
Measured at authoring time: `Part B4`, `Part B5`, `Part B7`, `Part B8`,
`Part B9` = **0 files each**. ⛔ **No such system is invented, named, scoped or
given an owner here.**

`SDS-FR-017` — B3 publishes a **read contract** and names **no** consumer.

`SDS-XC-010` — ⛔ B3 **MUST NOT** create an edge to an undefined consumer.
BC Map §7: *"If an edge is not in this table, it does not exist."*

⭐ `SDS-XC-013` — Where an obligation implies a downstream system, it binds to an
**existing** owner or is recorded as undefined:

| Obligation | Bound to | Status |
|---|---|---|
| Ranking | **`BC-23`** | ✅ exists (`PRD-020` §8.3 [4]) |
| Notification delivery | **`BC-22`** via `E-23` | ✅ exists (BC Map L332) |
| Moderation cases | **`BC-13`** | ✅ exists (BC Map L379) |
| B4/B5/B7/B8/B9 | — | ⛔ **Consumer/owner not currently defined in repository** |

⚠ `SDS-GAP-001` — **OPEN, non-blocking.** The five undefined parts are recorded
as absent. Nothing in B1/B2/B3 depends on them.

---

## §B3.17 Performance and caching

`SDS-PERF-001` — Step [1] eligibility **MUST** be a bounded lookup.
`SDS-PERF-002` — Steps [1]–[3] **MUST NOT** be O(n) unbounded per candidate.
`SDS-PERF-003` — Filtering **MUST** occur before pagination materialisation.
`SDS-PERF-004` — ⛔ No B3 read path **MAY** call `BC-10` synchronously per
candidate.
`SDS-PERF-005` — ⚠ No numeric latency target is invented — owner-set operational
parameter (`SDS-GAP-002`).
`SDS-PERF-006` — Page size bounded (`SDS-API-003`).
`SDS-PERF-007` — Composition **MUST** degrade to **fewer results**, never to
**unfiltered** results.
`SDS-PERF-008` — Any upstream unavailability ⇒ omit the candidate.

⛔ `SDS-CACHE-001` — **No composed result row is persisted** (`LCM-RM-006`).
⭐ ⛔ `SDS-CACHE-002` — **Result pages MUST NOT be cached.**
⛔ `SDS-CACHE-003` — **No eligibility decision cached** (`LCM-RM-021`).
⛔ `SDS-CACHE-004` — **No privacy decision cached.**
⛔ `SDS-CACHE-005` — **No safety decision cached** (`SSF-CACHE-002`).
`SDS-CACHE-006` — Unvalidatable cache ⇒ **unavailable, not stale-but-usable**
(`LCM-RM-025`).
⭐ `SDS-CACHE-007` — **Independent corroboration for `SDS-CACHE-002`.** Even
setting aside `LCM-RM-021`, caching a result page is prohibited because
`SID-4.40` requires same-operation removal on privacy change and BC Map **L427**
gives `PersonPrivacyModeChanged` **"no propagation window."** A cached page has,
by construction, a propagation window.
`SDS-CACHE-008` — B3 **MAY** cache only genuinely immutable derived data.

---

## §B3.18 Security

`SDS-SEC-002` — Viewer identity resolved **server-side**; a client-supplied
viewer **MUST** be **rejected, not honoured** (`LCM-API-013`).
`SDS-SEC-003` — ⛔ `tenantId` **MUST NOT** be accepted from the client. Resolved
server-side (`LCM-API-013`).
`SDS-SEC-004` — ⛔ No authorization decision outside `BC-18` (Stage 3 check 4,
`X-13`).
`SDS-SEC-005` — ⛔ No credentials/OTP/session handling (`ID-1`).
`SDS-SEC-006` — ⛔ Enumeration resistance: a filtered person and a nonexistent
person **MUST** be indistinguishable.
`SDS-SEC-007` — ⛔ Result payloads **MUST NOT** contain `StudentRecordId` or
`TenantId`.
`SDS-SEC-008` — ⛔ Logs **MUST NOT** correlate a `PersonId` with a tenant-scoped
identifier.

---

## §B3.19 Edge cases

| ID | Case | Required behaviour |
|---|---|---|
| `SDS-EC-001` | Viewer has no valid membership | Empty result set |
| `SDS-EC-002` | Viewer in multiple libraries | Union across shared libraries. `SDS-FR-012` |
| `SDS-EC-003` | Target in a non-shared library only | Absent. `SDS-BR-012` |
| `SDS-EC-004` | Target's membership expires | Absent on next read; friendship persists. `SDS-BR-009` |
| `SDS-EC-005` | Target membership suspended/cancelled | Not valid ⇒ absent. `SDS-BR-006` |
| `SDS-EC-006` | Target switches public → private | Removed same-operation. `SDS-PRV-005` |
| `SDS-EC-007` | Target is a minor | Not discoverable as public. `SDS-PRV-007` |
| `SDS-EC-008` | Target blocked the viewer | Absent; no reason published. `SDS-FR-009` |
| `SDS-EC-009` | Viewer blocked the target | Absent |
| `SDS-EC-010` | Safety Check unavailable | Candidate omitted (fail closed). `SDS-SEC-001` |
| `SDS-EC-011` | Target suspended via `E-14` | Absent. `SDS-FR-015` |
| `SDS-EC-012` | Target anonymised | Absent. `SDS-FR-014` |
| `SDS-EC-013` | All candidates filtered | Empty set, indistinguishable from no matches. `SDS-FR-007` |
| `SDS-EC-014` | Cursor reused after a block is added | Filters re-applied; blocked person absent. `SDS-BR-014` |
| `SDS-EC-015` | Search by mobile number attempted | Not supported. `SDS-PRV-001` |
| `SDS-EC-016` | Client supplies `tenantId` | Rejected, not honoured. `SDS-SEC-003` |
| `SDS-EC-017` | `BC-23` unavailable | Composition fails; ⛔ **no unfiltered fallback**. `SDS-PERF-007` |
| `SDS-EC-018` | Never-public field requested | Not indexed, not returned. `SDS-IDX-006` |

---

## §B3.20 Explicit exclusions (consolidated)

`SDS-XC-011` ⛔ no ranking · `SDS-XC-012` ⛔ no recommendation ·
`SDS-XC-014` ⛔ no profile entity · `SDS-XC-015` ⛔ no membership entity ·
`SDS-XC-016` ⛔ no second index. *(Plus `SDS-XC-001`…`010`, `013`.)*

---

## §B3.21 V1 / Future scope summary

| Capability | Scope | Authority |
|---|---|---|
| Search students (library-scoped) | **V1** | EA L926-933 |
| Discovery privacy controls | **V1** | EA L926-933 |
| Relationship signals on results | **V1** | `SDS-FR-010` |
| Mutual-connection count | **V1** (count only) | `SGR-FR-025` |
| Nearby students | **V2** | EA |
| Recommended students | **V2** | EA |
| Common interests | **V2** | EA |
| Friend suggestions | **V3** | EA L943 |

`SDS-SCOPE-003`…`008` are the eight rows above, in order.

---

## §B3.22 Acceptance criteria — GWT (32)

> ⚠ **No criterion is recorded as passing.** ⛔ No test exists and none is claimed.

| ID | Given | When | Then | Maps to |
|---|---|---|---|---|
| `SDS-AC-001` | Viewer has a valid membership in L1 | Search is run | Only persons with a valid L1 membership are candidates | `SDS-FR-001` |
| `SDS-AC-002` | Viewer has no valid membership | Search is run | Empty result set | `SDS-EC-001` |
| `SDS-AC-003` | Viewer belongs to L1 and L2 | Search is run | Union of L1 and L2 eligible candidates | `SDS-FR-012` |
| `SDS-AC-004` | Target belongs only to L3 | Viewer (L1, L2) searches | Target absent | `SDS-BR-012` |
| `SDS-AC-005` | A candidate is returned | Result payload is inspected | The producing library is **not** disclosed | `SDS-BR-013` |
| `SDS-AC-006` | Target membership expires | Search is re-run | Target absent on the next read, without a reindex | `SDS-FR-013` |
| `SDS-AC-007` | Target membership expires | Viewer's friend list is read | The friendship is still present | `SDS-BR-009`, `SGR-BR-014` |
| `SDS-AC-008` | Target membership is suspended | Search is run | Target absent — not valid in the projection | `SDS-BR-006` |
| `SDS-AC-009` | Validity is needed | B3 composes | Read from `BC-02`'s `MembershipValidity`; ⛔ not re-implemented | `SDS-BR-005` |
| `SDS-AC-010` | The pipeline executes | Step order is observed | `[1]` → `[2]` → `[3]` → `[4]`, in order | `SDS-FR-002`, `SDS-BR-004` |
| `SDS-AC-011` | A path attempts to reach the index | Steps `[1]`–`[3]` are skipped | Rejected as a defect; non-bypassable | `SDS-BR-002/003` |
| `SDS-AC-012` | Target switches public → private | Search is re-run | Absent as part of the same operation, not on a reindex | `SDS-PRV-005` |
| `SDS-AC-013` | Privacy mode changes | Any cached page would apply | ⛔ No cached page exists; results reflect current state | `SDS-CACHE-002/007` |
| `SDS-AC-014` | Target is a minor | Search is run by a stranger | Not discoverable as public | `SDS-PRV-007` |
| `SDS-AC-015` | A never-public field exists | Any index is inspected | The field is not indexed anywhere, for any purpose | `SDS-IDX-006` |
| `SDS-AC-016` | Search by mobile number | Attempted | Not supported | `SDS-PRV-001` |
| `SDS-AC-017` | Target blocked the viewer | Search is run | Target absent; ⛔ no exclusion reason published | `SDS-FR-009`, `SDS-PRV-009` |
| `SDS-AC-018` | Safety filtering is required | `BC-13` is consulted | ⛔ `BC-13` does **not** filter the set itself | `SDS-XC-003` |
| `SDS-AC-019` | Safety Check unavailable | Composition runs | Candidate omitted; fails **closed** | `SDS-SEC-001`, `SDS-PERF-007` |
| `SDS-AC-020` | `BC-23` unavailable | Search is run | Composition fails; ⛔ no unfiltered fallback | `SDS-EC-017` |
| `SDS-AC-021` | Results are returned | Order is inspected | `BC-23`'s order preserved; filtering did not reorder | `SDS-BR-018` |
| `SDS-AC-022` | B3 source is inspected | Ranking logic is sought | None present — no score, weight or boost | `SDS-XC-007/008` |
| `SDS-AC-023` | A result is returned | Payload is inspected | Relationship status present; ⛔ no browsable mutual list | `SDS-FR-010`, `SDS-BR-019` |
| `SDS-AC-024` | Pagination is used | Next page requested | Cursor-based; ⛔ no offset pagination | `SDS-API-001` |
| `SDS-AC-025` | A block is added mid-pagination | Next page requested | Filters re-applied; blocked person absent | `SDS-BR-014`, `SDS-EC-014` |
| `SDS-AC-026` | A cursor is issued | Cursor is decoded | ⛔ Contains no `StudentRecordId`, no `TenantId` | `SDS-API-002` |
| `SDS-AC-027` | Client supplies `tenantId` | Request is processed | **Rejected, not honoured**; resolved server-side | `SDS-SEC-003` |
| `SDS-AC-028` | Result payload is inspected | Fields enumerated | ⛔ No `StudentRecordId`, no `TenantId` | `SDS-SEC-007` |
| `SDS-AC-029` | B3 composition code is analysed | Module boundary check runs | Composition is **not** in `domain/social`; ⛔ zero banned-symbol violations introduced by B3 | `SDS-XC-002` |
| `SDS-AC-030` | Target does not exist / is filtered | Search is run | The two outcomes are indistinguishable | `SDS-SEC-006` |
| `SDS-AC-031` | Target is anonymised | Search is run | Absent from all results | `SDS-FR-014` |
| `SDS-AC-032` | B3 storage is inspected | Persisted structures enumerated | ⛔ No composed row, table, cache or materialised view; no profile or membership entity | `SDS-DM-005`, `SDS-DM-002/003` |

⚠ `SDS-AC-029` is worded *"introduced by B3"*: repository CI currently returns
`FAIL — 9 violation(s)` from the **pre-existing `ADR-0012` set**, ⛔ not caused by
and not repaired by this document.

---

## §B3.23 Disclosed gaps — all OPEN

| ID | Gap | Blocking? | Routed to |
|---|---|---|---|
| `SDS-GAP-001` | B4/B5/B7/B8/B9 consumer/owner undefined (0 files each) | ⛔ No — B3 names no consumer | Governance Owner |
| `SDS-GAP-002` | No numeric latency/page-size targets | ⛔ No — configuration | Document owner |
| `SDS-GAP-003` | Exact composition **placement** (which tenant-side module) unassigned | ⛔ No for authoring; **yes** for implementation | Architecture Owner |

---

## §B3.24 What this document does not do

⛔ Creates no bounded context — count remains **31** · ⛔ mints no `BC-`
identifier · ⛔ creates no edge · ⛔ mints no event · ⛔ mints no `IMPL-*` ·
⛔ creates no implementation task · ⛔ amends no frozen PRD · ⛔ amends no
Rank 1–5 artefact · ⛔ invents no B4/B5/B7/B8/B9 system or owner · ⛔ ratifies no
ADR · ⛔ claims no Stage 3 alignment · ⛔ records no AC as passing · ⛔ ranks
nothing.

---

**END — `PRD-021B` Part B3 v0.1 — DRAFT / Stage 2.**
