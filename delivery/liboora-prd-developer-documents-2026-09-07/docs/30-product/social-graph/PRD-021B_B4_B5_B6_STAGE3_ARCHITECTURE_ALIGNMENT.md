# PRD-021B — B4 / B5 / B6 · Stage 3 Architecture Alignment Record

| Field | Value |
|---|---|
| **Document** | `PRD-021B` Parts **B4** (Discovery Ranking), **B5** (Student Recommendations), **B6** (Discovery Scope) — Stage 3 Architecture Review |
| **Subject parts** | `PRD-021B_B4_DISCOVERY_RANKING_DRAFT_v0.1.md` (600 L) · `PRD-021B_B5_STUDENT_RECOMMENDATIONS_DRAFT_v0.1.md` (532 L) · `PRD-021B_B6_DISCOVERY_SCOPE_DRAFT_v0.1.md` (425 L) |
| **Date** | 2026-09-02 |
| **Reviewer** | Architecture Owner |
| **Gate authority** | `PRD_LIFECYCLE.md` **L88–106** — *"Validates the PRD against Ranks 1–5, in this order"*, six checks; **Gate:** *"a written alignment record naming every conflict and its disposition"* |
| **Verdict** | ⭐⭐ **PASS — 6 of 6 checks** (see §8). Stage 3 is **CONFERRED** on B4, B5 and B6. |
| **Prerequisite act** | [`ADR-0091`](../../00-governance/adr/ADR-0091-prd-021b-b4-b5-b6-owner-decisions.md) — **Accepted 2026-09-02**. Without it, checks 1 and 3 would have returned **BLOCKED**, not FAIL; see §2. |
| **Status of the subjects** | ⛔ **DRAFT / STAGE 3 PASSED.** Not Stage 4, not Stage 5, **NOT FROZEN**, no implementation. |
| **Bytes changed in the subjects by this review** | ⛔ **ZERO.** This record measures; it does not edit. Verified by `git diff` (§7.4). |

---

## §0 — The review in one sentence

**All six Stage-3 checks PASS on measured evidence, and the two checks that could have failed did not fail
because `ADR-0091` had already removed their grounds by *determination from Rank 1 authority* rather than by
grant of an exception** — check 1 (exclusive context ownership) passes because `MASTER_PRD.md` **L171** already
registers the read-composition shape B4 claims, and check 2 (edges exist in §7) passes because all **seven**
edges the three parts cite were found in the BC Map §7 table by line number and **zero** new edges are proposed.

---

## §1 — Scope of this review, stated as a boundary

| In scope | Out of scope, and why |
|---|---|
| B4, B5, B6 — the three Stage-2 drafts registered by `PRD_REGISTRY.md` §13 | ⛔ **B0, B1, B2, B3** — already Stage-3 PASS (6/6) at `PRD-021B_STAGE3_RESOLUTION_AND_RE_REVIEW.md` and Stage-4 PASS (6/6). **Read as authority, left byte-unchanged** (§7.3) |
| The six `PRD_LIFECYCLE.md` L92–99 checks, **in the document's stated order** | ⛔ **`PRD-021A`, `PRD-020`** — frozen/baselined. Read as authority only (§7.3) |
| The ten review areas named in the review request (mapped to the six checks in §3) | ⛔ **`FOD-1`, `FOD-2`** — B0–B3 subjects, reserved to `ADR-0088`/`ADR-0090`, which remain **unwritten** |
| Rank 1–5 conformance | ⛔ **Stage 4** (requirements review) and **Stage 5** (traceability) — NOT ENTERED |

---

## §2 — Why this record can be written at all

`PRD_LIFECYCLE.md` L92 requires validation *"against Ranks 1–5."* Three conflicts recorded by
`PRD-021B_B4_B5_B6_CROSS_PART_AUDIT.md` §8 were, at Stage 2, unresolved questions of **ownership and wave**,
which are not reviewer questions. `PRD_OWNERSHIP_MODEL.md` §2.2 assigns them to named owners.

They were resolved by **`ADR-0091`**, and the shape of that resolution matters to this review:

| Conflict | Disposition in `ADR-0091` | Effect on this review |
|---|---|---|
| `XPB-CONF-001` — B4/ranking ownership | **DETERMINED** from `MASTER_PRD.md` **L171** (Rank 1). Not chosen | Check 1 has **no conflict left to adjudicate** — the pattern pre-exists at Rank 1 |
| `XPB-CONF-002` — B5 V1 vs V2/V3 | **DECIDED** by the Product Owner; narrowed to the `PYK-SRC-001` subset | Check 1 and check 6 are evaluated **against the narrowed scope**, not the draft's original ask |
| `XPB-CONF-005` — B6 part/registry status | **DISCHARGED** by `PRD_REGISTRY.md` §13, the act `FOD-4` itself prescribed | The subjects are **registered parts**, so a part-level Stage 3 is the correct gate |

⭐ **This is the reason the verdict is PASS and not "PASS by exception."** Not one of the six checks is
satisfied by a waiver. `ADR-0091` **Amends NOTHING** and grants **no** §11 exception; it records what the
repository already said.

---

## §3 — Mapping the ten requested review areas onto the six lifecycle checks

The review request named ten areas. The lifecycle gate names six checks in a fixed order. The mapping is
stated here **before** the checks are run, so that no area is quietly dropped and no check is quietly invented.

| # | Requested area | Lifecycle check(s) | §4 sub-section |
|---|---|---|---|
| 1 | BC ownership | Check 1 | §4.1 |
| 2 | B3 → B4 → B5 dependency chain | Check 3 | §4.3 |
| 3 | B6 scope boundary | Check 6 + Check 1 | §4.6, §4.1 |
| 4 | Library ON / Global-Local-Nearby OFF | Check 6 | §4.6 |
| 5 | Privacy + safety ordering | Check 1 (ownership of the stages) | §4.1c |
| 6 | Membership / identity boundaries | Check 5 + Check 6 | §4.5, §4.6 |
| 7 | Ranking / recommendation ownership | Check 1 | §4.1a, §4.1b |
| 8 | Authorized signals / sources | Check 1 + Check 2 | §4.1d |
| 9 | Existing BC Map edges only | Check 2 | §4.2 |
| 10 | No duplicate systems, no cross-library / global leakage | Check 1 + Check 6 | §4.1e, §4.6c |

⚠ **Area 5 is deliberately routed to check 1, not to a check of its own.** The lifecycle gate has no
"ordering" check. Pipeline order is an **ownership** question — who owns each stage and in what sequence the
owners run — and `PRD-020` §8.3 is its authority. Inventing a seventh check would have made this record
non-comparable with the B0–B3 record, which ran six.

---

## §4 — The six checks, in lifecycle order

### §4.1 — CHECK 1 · Context ownership is exclusive · Authority: BC Map §3 · Failure: *"Two PRDs own one aggregate"*

#### §4.1a — B4 (ranking) — ✅ PASS

| Evidence | Measurement |
|---|---|
| `MASTER_PRD.md` **L171** (Rank 1) | `\| 19 \| Library Discovery & Enrollment \| Composition over BC-19, BC-25, BC-29, BC-06, BC-02, BC-04, projected via BC-23 \| not a context \| V1 \|` |
| `MASTER_PRD.md` **L175–180** | *"owns no aggregate, no invariant and no business state… It is **not** a bounded context, so §5.1's V1 scope of 23 bounded contexts is unchanged."* |
| `DRK-XC-001` (B4 L127) | ⛔ *"B4 MUST NOT create a bounded context. Count stays 31."* |
| `DRK-XC-005` (B4 L182) | ⛔ *"MUST NOT perform indexing, query rewriting, tokenisation…"* |
| `DRK-XC-006` (B4 L184) | ⛔ *"MUST NOT write to, read from or build any index."* |
| `DRK-XC-009` (B4 L233) | ⛔ *"MUST NOT persist an ordering, a score, a rank position…"* |
| BC Map **L132** | `BC-23 Search Indexing [GENERIC] Search V1 — Owns indices, permission-aware indexing, tenant index isolation, **relevance**, query…` |
| `AR-1` four-criterion test | Owns no aggregate ✅ · owns no invariant ✅ · owns no business state ✅ (`DRK-XC-009`) · orchestrates public read models only ✅ |

**Disposition.** B4 claims a **post-retrieval ordering layer inside a read composition** and refuses ownership
of relevance, the index and any persisted state. **`BC-23` retains relevance.** ⭐ **No aggregate is owned
twice.** BC count measured **31**, unchanged. New BCs: **0**.

⚠ **NARROWING CARRIED FORWARD, NOT SMOOTHED.** `ADR-0091` §3.3 relaxes `DRK-BR-001` **on query surfaces only**
and **RETAINS `DRK-XC-004` as binding** for query surfaces (B4 **L166**). This review does **not** treat the
retained prohibition as a defect: on a text query, relevance is the user's expressed intent, and re-ordering
across relevance bands would make a search box stop answering the query. **Check 1 passes on the narrowed
scope, and the narrowing is what makes it pass.**

#### §4.1b — B5 (recommendations) — ✅ PASS

| Evidence | Measurement |
|---|---|
| B5 **§B5.3** heading, L161 | *"Ownership — B5 duplicates nothing"* |
| `PYK-SRC-001` at V1 | Admitted by `ADR-0091` §4.3 — **same-library members, library-first, no traversal** |
| `PYK-SRC-002` (friends-of-friends) | ⛔ **NOT V1.** `PYK-GAP-003` left **OPEN** — traversal is `BC-11`'s, and a traversal right was not conferred |
| `PYK-SRC-004`, `PYK-SRC-006` | ⛔ **V2** — EA **L931**, EA **L929** |
| Smart Matching / AI Discovery | ⛔ **V3 / Future** — EA **L932**, **L933** |
| EA **L943** Friend Suggestions | ⛔ **V3 — explicitly NOT promoted** by `ADR-0091` §4.4 |
| `BC-11` wave | BC Map **L115**: `BC-11 Social Graph [SUPPORTING] Global Student **V1**` |

**Disposition.** ✅ **PASS.** B5 sources candidates and refuses to own the graph. `BC-11` owns relationships
(BC Map L115) and B5 does not mutate them. `MP-SCOPE-01`…`09` (`MASTER_PRD` L89–97) is **silent** on student
recommendations, so nothing at Rank 1 is contradicted by admitting the `PYK-SRC-001` subset at V1.

⚠ **The one thing this check does NOT do:** it does not certify the other six sources. They are held at their
measured waves. A future promotion is a **new** Product Owner act.

#### §4.1c — Privacy + safety stage ownership and ordering — ✅ PASS

| Stage | Owner | Authority |
|---|---|---|
| Candidate | `BC-23` | **FROZEN** `PRD-020` §8.3, L544–570 |
| [1] Eligibility | `BC-11` | same |
| [2] Privacy | `BC-10` | same |
| [3] Safety | `BC-13` | same |
| [4] Ranking (relevance) | `BC-23` | same |

| Draft statement | Measured at |
|---|---|
| `DRK-FR-003` — *"B4 MUST run **strictly after** steps [1], [2] and [3]"* | B4 **L212** |
| B5 — *"result passes: eligibility [1], privacy [2], safety [3]. Authority: **FROZEN**"* | B5 **L248** |
| `GLS-FR-006` — *"Scope MUST be applied as part of the **eligibility** stage"* | B6 **L201** |

**Disposition.** ✅ **PASS.** All three parts subordinate themselves to the frozen pipeline and **none claims
ownership of a privacy or safety decision**. B6 inserts scope **inside** the existing eligibility stage rather
than adding a stage — which is why the pipeline is not re-shaped and `PRD-020` needs no amendment.

#### §4.1d — Authorized signals and sources — ✅ PASS

| Item | Disposition in `ADR-0091` | Ownership consequence |
|---|---|---|
| `DRK-SIG-005` (identity freshness) | **WITHDRAWN**, not deferred | BC Map **L424** measured: `identity.PersonIdentityCreated` consumers are `BC-23`, `BC-24`, `BC-26` — **`BC-11` absent**. ⭐ Any future freshness signal must arrive **through `BC-23`'s projection via `E-21`**, never a new `BC-10`→`BC-11` edge |
| `DRK-GAP-003` (co-presence) | **REFUSED FINAL** | 0 edges; `X-05` preserved |
| `DRK-GAP-004` (behavioural) | **REFUSED FINAL for V1** | 0 store. A future store is a `BC-26` question |
| `PYK-GAP-004` (study-hall) | **REFUSED FINAL** | identical grounds |
| `DRK-BR-005` (B4 **L269**) | Draft's own rule | *"A signal whose source is DEFERRED or REFUSED MUST NOT…"* contribute |

**Disposition.** ✅ **PASS.** Every admitted signal traces to an edge that exists (§4.2). Four candidate
signals were **removed or refused rather than granted an edge**. ⭐ `DRK-BR-005` means the refusals are
enforced by the draft itself, not only by this record.

#### §4.1e — No duplicate systems — ✅ PASS

Measured ownership refusals across the three parts (`MUST NOT` + ownership verb): B4 declares `DRK-XC-001`…
`DRK-XC-009`; B5 declares §B5.3 *"B5 duplicates nothing"*; B6 declares `GLS-INV-005` (**L181**) ⛔ *"Scope MUST
NOT be enforced by `BC-11` — `BC-11` cannot"*.

⚠ **Instrument defect disclosed.** A first probe for the regex `MUST NOT (own|create|introduce|maintain|build|store)`
returned **0 matches across all three files**, which would have supported a finding of "no duplication
prohibitions exist." That result was **wrong** — the drafts phrase the prohibitions as
`MUST NOT create a bounded context`, `MUST NOT write to… any index`, `MUST NOT be enforced by BC-11`, which the
alternation did not cover. ⭐ **The zero was disbelieved and the probe re-run**, because a register that
declares 31 exclusions cannot plausibly contain none. Corrected count: B4 **19+** `MUST NOT` clauses measured.
**Recorded here rather than silently fixed**, per L104–106.

**CHECK 1 RESULT: ✅ PASS.** Aggregates owned twice: **0**. New bounded contexts: **0**. BC count: **31**.

---

### §4.2 — CHECK 2 · Every integration edge exists in §7 · Authority: BC Map §7 · Failure: *"If an edge is not in this table, it does not exist"*

Edges cited by the three parts, censused mechanically and each located in the BC Map §7 table **by line
number**:

| Edge | Cited by | Found at BC Map | §7 row content (measured) |
|---|---|---|---|
| `E-02` | B4, B5, B6 | **L299** | `BC-02 Membership → BC-04 Seating · C/S + PL · Read projection · MembershipValidity{studentRecordId, validUntil, seatQuota}` |
| `E-19` | B4, B5, B6 | **L328** | `All contexts → BC-25 Configuration · CF · Sync port` |
| `E-20` | B4, B5, B6 | **L329** | `All contexts → BC-24 Audit Trail · PL · Event (fire-and-forget, outbox-backed)` |
| `E-21` | B6 | **L330** | `BC-01, BC-10 → BC-23 Search Indexing · PL · Event` |
| `E-22` | B6 | **L331** | `BC-01, BC-10, BC-12, BC-14 → BC-29 File & Media · CF · Sync port` |
| `E-23` | B5 | **L332** | `All contexts → BC-22 Notification Delivery · PL · Event` |
| `E-26` | B4 | **L335** | `BC-27 AI → BC-26 Analytics, BC-23 Search · CF · Sync port` |

**Edges cited: 7. Edges found in §7: 7. Edges proposed, invented or implied: 0.**

| Corroborating measurement | Result |
|---|---|
| `DRK-XC-002` (B4 **L128**) | ⛔ *"B4 MUST NOT create an integration edge."* |
| `DRK-XC-003` (B4 **L130**) | ⛔ *"B4 MUST NOT mint a published event."* |
| BC Map **L292** (the governing rule, verbatim) | *"Every edge that crosses a context boundary in V1. If an edge is not in this table, it **does not exist** and adding it requires an ADR."* |
| ADRs required by this check | **0** |

⭐ **The `BC-17` finding from Stage 2 is confirmed closed here by independent measurement.** The cross-part
audit's finding **F-1** was that B6 rendered the BC Map residency-band label `BC-11→17` as an integration
arrow. Re-measured at HEAD: B6 **L25** now reads *"(⚠ \"BC-11→17\" in the BC Map is a…"* band notation with an
explicit disclosure, and `BC-17` appears **only** in that band context. ⭐ Had the arrow survived, **this
check would have FAILED**, because `BC-17` is **Marketplace, V3** (BC Map **L121**) and no `BC-11`→`BC-17` row
exists in §7. **The Stage-2 self-audit is what prevented a Stage-3 failure**, which is the argument for
running one.

**CHECK 2 RESULT: ✅ PASS.** 7/7 edges exist. 0 new edges. 0 ADRs required.

---

### §4.3 — CHECK 3 · Rank direction is downward · Authority: Dependency Matrix `L2` · Failure: *"Illegal import"*

Matrix **L49**, verbatim: **`L2 — Downward only`** — *"A module may depend only on modules of **strictly lower
rank** (§3). Same-rank dependencies are forbidden except within a declared cluster."* Matrix **L54**:
*"L1 is absolute. L2–L5 admit exceptions only through the ADR process in §11."*

| Dependency | Direction | Verdict |
|---|---|---|
| B3 → B4 → B5 (part-internal chain) | One-way, acyclic — verified in `PRD-021B_B4_B5_B6_CROSS_PART_AUDIT.md` §4 and re-confirmed at HEAD | ✅ Not a module-rank edge at all: all three sit within the **same** part family and consume `BC-11`'s surface. `L2` is not engaged by an intra-part sequence |
| B6 → B3 / B4 / B5 | One-way (`GLS-FR-004`, B6 **L148**: *"B3, B4 and B5 MUST obtain scope from B6"*), acyclic | ✅ PASS |
| B4/B5/B6 → `BC-11` (R8, Social cluster) | Consumers of a published read surface | ✅ PASS |
| B4/B5/B6 → `BC-10` (**R7.5**) | Matrix **L72**: *"Platform identity. Its own tier: below every domain module, above every capability platform"* | ✅ **Downward.** Matrix **L354** (`X-05`) states expressly: *"`BC-10` is **not** the social side of this prohibition — since `ADR-0011` it is a rank-7.5 platform identity that library modules may depend on downward"* |
| B4/B5/B6 → `BC-23`, `BC-24`, `BC-25`, `BC-26` (capability platforms) | Below R7.5 | ✅ Downward |
| Social cluster same-rank edges | Matrix **L90**: *"Only edges E-14…E-16 **and E-28**"* | ✅ **The three parts cite NONE of E-14/E-15/E-16/E-28** — measured. So the cluster exception is not even invoked |
| §11 exceptions requested | **0** | ✅ |

⭐ **The strongest result in this check is a negative one.** The parts do not use the Social cluster's
same-rank exception at all, so `L2` holds in its unexceptioned form.

**CHECK 3 RESULT: ✅ PASS.** Same-rank dependencies: 0. Upward dependencies: 0. §11 exceptions: 0. Cycles: 0.

---

### §4.4 — CHECK 4 · No authorisation decided outside `BC-18` · Authority: `X-13` · Failure: *"A security defect that passes its own tests"*

| Measurement | Result |
|---|---|
| Occurrences of `password`, `OTP`, `session token`, `credential` across B4+B5+B6 | **0 / 0 / 0** (per-file count) |
| `BC-18` references | Exactly **1** per part — each a boundary acknowledgement, not a claim |
| BC Map **L127** | `BC-18 Identity & Access [GENERIC] — Owns credentials, sessions, devices, OTP, roles, permissions, policy` |
| BC Map **L178** (`ID-1`) | *"No context outside BC-18 may store a password, OTP, session or credential."* |
| Authorisation decisions made by B4/B5/B6 | **0** — the parts consume already-authorised read surfaces |

⚠ **The visibility/permission question is deliberately NOT treated as authorisation here.** B4/B5/B6 apply
**privacy visibility** (`BC-10`) and **safety suppression** (`BC-13`) — both are stage outputs of the frozen
`PRD-020` §8.3 pipeline, owned by their respective contexts, and neither is a role/permission grant. Calling
them "authorisation" would have manufactured a violation the repository does not recognise.

**CHECK 4 RESULT: ✅ PASS.** Authorisation decided outside `BC-18`: **0 sites**.

---

### §4.5 — CHECK 5 · No credential, OTP or session outside `BC-18` · Authority: `ID-1` · Failure: *"Prohibited"*

This check is the storage counterpart of check 4 and is run separately, in the lifecycle's order, rather than
folded into it.

| Measurement | Result |
|---|---|
| Credential/OTP/session **storage** obligations in B4/B5/B6 | **0** |
| `DRK-XC-009` (B4 **L233**) | ⛔ *"MUST NOT persist an ordering, a score, a rank position…"* — B4 persists nothing at all, so it cannot persist a credential |
| B4 **L119** | ⛔ *"It MUST NOT hold…"* (candidate list, signal values, configuration version are transient) |
| Membership / identity boundary (requested area 6) | `GLS-INV-004` (B6 **L177**): *"Because the membership predicate is `studentRecordId`-keyed…"* — the predicate is **evaluated on the library side** and only a boolean crosses; no identity record is copied into the social side |

⭐ **`GLS-INV-004` is the load-bearing statement for the membership/identity boundary**, and it passes check 5
by construction: what crosses the boundary is a **decision**, not an **identifier**.

**CHECK 5 RESULT: ✅ PASS.** Credential/OTP/session held outside `BC-18`: **0**.

---

### §4.6 — CHECK 6 · Tenant scoping correct · Authority: `MP-GBR-08`, `X-13` · Failure: *"Cross-tenant leak — `MP-RSK-01`, Critical"*

Authorities measured: `MASTER_PRD` **L339** (`MP-GBR-08`) — *"Every search index and vector namespace is
tenant-partitioned. Every RAG retrieval is tenant-scoped **and** permission-aware."* Matrix **L362** (`X-13`) —
*"Cache/index/vector key without `tenantId` … **Cross-tenant data leak — highest-severity failure class in the
system**."* BC Map **L488** — the residency band: *"**Global.** No tenantId. Keyed on PersonId. Must never
receive a StudentRecordId or tenantId (rule `ID-2`)."*

#### §4.6a — The two-regime distinction is stated, not blurred — ✅ PASS

B6 **L161–163** sets the two regimes side by side:

| | Social side | Library side |
|---|---|---|
| Key | `PersonId` | `StudentRecordId` + `tenantId` |
| Tenancy | **Global.** *"No `tenantId`"* — BC Map **L488** | **Tenant-scoped** — `MP-GBR-08` |
| Rule | `ID-2`: *"Must never receive a `StudentRecordId` or `tenantId`"* | `X-13` forbids untenanted access |

⭐ This is the `AR-3` distinction (BC Map **L494**: two *"categorically different"* index classes) applied at
the part level. **Both rules are satisfied simultaneously because the two sides are never merged.**

#### §4.6b — Library ON / Global-Local-Nearby OFF (requested area 4) — ✅ PASS

`GLS-DEF-001` (B6 **L128**): `DiscoveryScope` is a **closed enum** of exactly four values.
`GLS-DEF-002` (**L130**): ⛔ *"MUST NOT be extended without an architecture…"* act.

| Value | State | Authority measured |
|---|---|---|
| `GLS-DEF-003` **`LIBRARY`** (**L136**) | ✅ **ON** | EA **L926** `Student Discovery (V1)`; **L927** `Search Studen…` |
| `GLS-DEF-004` **`GLOBAL`** (**L137**) | ⛔ **OFF** | ⚠ ***"0 repository lines authorise global student discovery. Measured"*** |
| `GLS-DEF-005` **`LOCAL`** (**L138**) | ⛔ **OFF** | ⚠ *"0 repository lines. No region model measured"* |
| `GLS-DEF-006` **`NEARBY`** (**L139**) | ⛔ **OFF** | EA **L929** `Nearby Students (V2)` |

| Enforcement register | Content |
|---|---|
| `GLS-FR-002` (**L143**) | ⭐ *"In V1 the value **MUST** be **`LIBRARY`**, always, for every…"* |
| `GLS-FR-003` (**L145**) | `GLOBAL`, `LOCAL`, `NEARBY` **MUST** be rejected in V1 |
| `GLS-FR-005` (**L199**) | Scope **MUST** be resolved **server-side before** candidate retrieval |
| `GLS-EC-003` (**L346**) | Client sends `scope=GLOBAL` → **reject**; ⛔ *"no silent downgrade"* |
| `GLS-INV-003` (**L175**) | ⛔ **IMPOSSIBLE** for a scope value to be re-interpreted |
| `GLS-DEF-002` | The enum cannot grow without an architecture act |

⭐ **`GLS-EC-003`'s refusal to silently downgrade is what makes this a boundary rather than a default.** A
system that quietly rewrites `GLOBAL` to `LIBRARY` teaches clients that the parameter is advisory.

#### §4.6c — No cross-library or global leakage (requested area 10) — ✅ PASS, with one item held OPEN

| Register | Content | Verdict |
|---|---|---|
| `GLS-INV-001` (**L166**) | ⭐ *"The social graph stays global; the scope filter is…"* applied outside it | ✅ |
| `GLS-INV-002` (**L170**) | ⛔ *"It MUST be IMPOSSIBLE for a `tenantId` or `StudentRecordId`"* to reach the social side | ✅ |
| `GLS-INV-005` (**L181**) | ⛔ *"Scope MUST NOT be enforced by `BC-11` — `BC-11` cannot"* | ✅ Enforcement is placed where the data lives |
| `GLS-INV-006` (**L183**) | ⛔ **IMPOSSIBLE** for a `LIBRARY`-scoped result to… cross out | ✅ |
| B6 **L169** | Scope is achieved *"without introducing a `tenantId` into `BC-11`"* | ✅ |
| B6 **L213** | Rejects a *"client-supplied `tenantId`"* | ✅ |
| B6 **L251** | `GLS-INV-002` and the **CI banned symbols MUST hold even if a flag is** flipped | ✅ Not flag-dependent |
| `DRK-SEC-002` (B4 **L456**) + `DRK-AC-018` (**L544**) | ⛔ B4 MUST NOT accept `tenantId`/`StudentRecordId`; AC inspects the payload | ✅ Testable |
| `PYK-PRV-007` (B5 **L289**) + `PYK-AC-023` (**L486**) | Same prohibition, same payload inspection | ✅ Testable |
| `GLS-AC-006` (B6 **L366**) | *"Any social-side call in the scope path · Payload inspected · ⛔ Contains no `tenantId` and no `StudentRecordId`"* | ✅ |
| CI corroboration | `tool/module_dependencies.yaml` `banned_symbols: StudentRecordId, TenantId` | ✅ Machine-enforced |

⚠⚠ **`GLS-GAP-002` REMAINS OPEN AND IS NOT CLOSED BY THIS PASS.** The multi-library viewer case — where a
union across the viewer's libraries would leak library A's membership into library B's surface — is left
**OPEN** to **Product Owner + ARB** by `ADR-0091` §7. **This check passes for the single-library viewer, which
is the V1 case `GLS-FR-002` mandates**, and the multi-library case is a **future-scope question, not a present
defect**: no register admits it, so there is nothing implementable to leak through. ⛔ **It is named here
rather than absorbed into the PASS.**

**CHECK 6 RESULT: ✅ PASS.** Untenanted library-side keys: **0**. `tenantId` in the social side: **0**.
Cross-library leakage paths in the V1 scope: **0**. Open future-scope items: **1** (`GLS-GAP-002`).

---

## §5 — Findings REJECTED, with reasons

`PRD_LIFECYCLE.md` **L104–106**: *"A rejected finding must be recorded as rejected, with its reason. … A
review that records only accepted findings is indistinguishable from a review that found nothing."*

Seven candidate findings were raised during this review and **rejected**. They are recorded because a review
that reports only its confirmations has concealed its own reasoning.

| # | Candidate finding | Disposition | Reason |
|---|---|---|---|
| **R-1** | *"B4 owns ranking, which duplicates `BC-23` — check 1 FAIL."* | ⛔ **REJECTED** | `MASTER_PRD.md` **L171** already registers a **V1** read composition *"projected via `BC-23`"* that *"owns no aggregate, no invariant and no business state."* B4 claims that exact shape. The pattern is **Rank 1 authority**, not a novel claim. Raising it as a FAIL would have made the reviewer overrule Rank 1 |
| **R-2** | *"`DRK-XC-004` is still binding on query surfaces, so `ADR-0091` did not fully resolve `XPB-CONF-001` — return BLOCKED."* | ⛔ **REJECTED** | A **narrower** ruling is a complete ruling. `ADR-0091` §3.3 states the narrowing expressly and gives a product reason (a search box must answer the query). BLOCKED is for *"an owner has not spoken"*, not for *"an owner spoke and said less than was asked"* |
| **R-3** | *"B5 admits recommendations that `MP-SCOPE-01`…`09` never authorises — check 1 FAIL."* | ⛔ **REJECTED** | `MASTER_PRD` **L89–97** is **silent** on student recommendations — measured. Silence is not prohibition; `MP-SCOPE-04`/`06` place **BC-14/15** at V2 and **BC-16/17** at V3, and B5 touches none of them. `BC-11` is **V1** (BC Map **L115**). A Product Owner ruling on a Rank-1-silent question is within `PRD_OWNERSHIP_MODEL.md` §2.2 |
| **R-4** | *"The EA's wave tree contradicts B5's V1 admission — check 1 FAIL."* | ⛔ **REJECTED**, and the drafts' own error corrected | The EA is **Rank 6** and *"Descriptive — must follow the PRDs, never lead them"* (`DOCUMENTATION_BASELINE.md`, stated twice). ⚠ **B4/B5/B6 call it "Rank 4" — that is wrong, and `ADR-0091` §4.1 corrects it rather than carrying it.** `ADR-0061` is the governing precedent: a higher rank prevails over an EA wave tag **without editing the EA**. ⚠ The residual staleness is real and is opened as **`XPB-DRIFT-001`**, routed to the Architecture Owner — **disclosed, not repaired** |
| **R-5** | *"B6 cites `BC-17`, a V3 Marketplace context, with no `BC-11`→`BC-17` row in §7 — check 2 FAIL."* | ⛔ **REJECTED** — but only after re-measurement | This **was** a real defect at Stage 2 (audit finding **F-1**) and was **fixed before this review**. Re-measured at HEAD: B6 **L25** carries band notation plus an explicit disclosure; `BC-17` appears in **no** arrow form. ⭐ Recorded as rejected **because it was true and is no longer**, which is different from having been groundless |
| **R-6** | *"B6 adds a scope stage to the frozen `PRD-020` §8.3 pipeline — check 1 FAIL, and `PRD-020` needs amending."* | ⛔ **REJECTED** | `GLS-FR-006` (B6 **L201**) places scope *"as part of the **eligibility** stage"* — **inside** step [1], not as a new step. The pipeline's five stages and their owners are unchanged, which is why `PRD-020` is byte-unchanged (§7.3) |
| **R-7** | *"No duplication prohibitions exist in the three parts — check 1 FAIL."* | ⛔ **REJECTED — the finding was an INSTRUMENT DEFECT, disclosed in §4.1e** | The probe regex missed the drafts' actual phrasing and returned **0**. The zero was disbelieved because a register declaring 31 exclusions cannot contain none. ⭐ **This is the most dangerous finding in the list**, because it was produced by a tool and would have read as objective |

⭐⭐ **Accepted findings: 0. Rejected findings: 7.** ⚠ **A review with no accepted findings requires an
explanation, and the explanation is not "the drafts were perfect."** It is that the two **material** defects
in these drafts — the `BC-17` arrow (**F-1**) and the "Rank 4" mis-citation of the EA — were **found and
disposed of before this gate**: F-1 by the Stage-2 cross-part audit, and the EA rank error by `ADR-0091` §4.1.
**Both were self-findings against my own drafting.** A Stage 3 that found them again would have been a Stage 3
run too late.

---

## §6 — Items that remain OPEN or BLOCKED after this review

⛔ **None of these blocks Stage 3, and none is closed by it.** Each is named with its owner.

| Item | State | Owner | Why it does not block Stage 3 |
|---|---|---|---|
| `PYK-GAP-002` — per-viewer suppression state | ⛔ **OPEN** | **ARB** | Option (a) is a **Rank 4 BC Map §8 append**, which is **`ADR-0090`'s reserved subject**. Resolving it here would decide a reserved question by side effect. `PYK-CFG-001` default remains **FALSE**, so nothing ships that needs it |
| `PYK-GAP-003` — friends-of-friends traversal | ⛔ **OPEN** | **ARB** | `PYK-SRC-002` is **NOT V1**. Traversal is `BC-11`'s and no traversal right was conferred |
| `GLS-GAP-002` — multi-library viewer union | ⛔ **OPEN** | **PO + ARB** | §4.6c: a future-scope question. `GLS-FR-002` mandates single `LIBRARY` scope in V1 |
| `XPB-DRIFT-001` — EA L930 stale vs the V1 admission | ⚠ **DISCLOSED** | **Architecture Owner** | The EA is **Rank 6, descriptive**. `ADR-0061` holds that the higher rank prevails **without** editing it |
| `FOD-4` — part allocation for **B7, B8, B9** | ⛔ **OPEN** | **Governance Owner** | Discharged **only** for B4/B5/B6 (`ADR-0091` §6). ⛔ B0 was **not edited** — the *discharged-not-rewritten* precedent |
| `FOD-1`, `FOD-2` | ⛔ **OPEN** | **ARB** | **B0–B3 subjects**, out of scope. `ADR-0088`/`ADR-0090` remain **RESERVED and UNWRITTEN** |
| `PRD-021A` `L143`/`L150`/`L138` citation staleness | ⚠ **PRE-EXISTING** | routed to `ADR-0075` §8.5 Option B | Not caused here; disclosed in the `ADR-INDEX.md` `Count` cell |

---

## §7 — Verification performed by this review

### §7.1 — Measurements
| Measurement | Result |
|---|---|
| BC census across B4/B5/B6 | B4: `BC-02,03,04,10,11,12,13,18,23,24,25,26` · B5: `BC-02,03,04,10,11,13,18,22,23,24,25,26` · B6: `BC-01,02,10,11,13,17,18,19,23,24,25` |
| Every cited BC found in BC Map §3 | ✅ **Yes** — all located by line number |
| Edge census | 7 cited (`E-02,19,20,21,22,23,26`); **7/7** found in §7 at L299/L328/L329/L330/L331/L332/L335 |
| New edges / new BCs / new events | **0 / 0 / 0** |
| Credential-OTP-session tokens | **0 / 0 / 0** per file |
| Same-rank or upward module dependencies | **0** |
| §11 exceptions requested | **0** |
| BC count at HEAD | **31**, unchanged |

### §7.2 — ADR register integrity
| Check | Result |
|---|---|
| `ADR-0091` registered in `ADR-INDEX.md` | ✅ Row at **L114**, `Status: Accepted` |
| Counts re-derived by classifier over all files (never incremented) | **FILES 79 · ACCEPTED 65 · PROPOSED 13 · ACCEPTED-IN-PRINCIPLE 1 · SUPERSEDED 0 · DEPRECATED 0** — **sum closes at 79**, **unparsed bucket EMPTY** |
| In-principle bucket printed by name | `ADR-0075` |
| Unregistered-file enumeration | returned exactly `ADR-0091`, now registered → now **[]** |
| `L9` `Count` cell and the L116 summary sentence | Both re-derived **independently from the files**, not copied from each other; prior text **retained verbatim** in both |
| Citation cost of the row insert, **measured before the insert** | Insert after **L113**; all currently-valid citations (**L9, L50, L75, L84, L95–L99, L110/L111**) sit **above** it → **0 valid citations invalidated** |
| Pre-existing stale citations | *"L143"* ×8, *"L150"* ×3, *"L138"* ×1 — routed to `ADR-0075` §8.5 Option B, **not** silently repointed |
| Reserved numbers | ⛔ `ADR-0088`, `ADR-0089`, `ADR-0090` **deliberately do not exist**; `ADR-0066`…`ADR-0074` remain unopened |

### §7.3 — Documents verified BYTE-UNCHANGED
`PRD-021B` **B0** (`69dae44e5c8f99fa`), **B1** (`503c804504f2d04e`), **B2** (`7339862f8cf9fc11`),
**B3** (`a3ccec3de060144e`) · `MASTER_PRD.md` · `LIBOORA_BOUNDED_CONTEXT_MAP.md` ·
`LIBOORA_MODULE_DEPENDENCY_MATRIX.md` · `LIBOORA_ENTERPRISE_ARCHITECTURE.md` (**L926–L943 included**) ·
`ARCHITECTURE_RULINGS.md` · `DOCUMENTATION_BASELINE.md` · `PRD_LIFECYCLE.md` · `PRD_OWNERSHIP_MODEL.md` ·
**FROZEN** `PRD-020_TRUST_AND_SAFETY.md` (**§8.3 L544–570 included**) · every `PRD-021A` part and record ·
`TRACEABILITY_MATRIX.md` · the B0–B3 Stage-3 and Stage-4 records · **and the three subject drafts themselves.**

### §7.4 — What this pass did NOT do
⛔ 0 documents changed version · ⛔ 0 baseline rows added (`DOCUMENTATION_BASELINE.md` has **0** `PRD-021B`
rows and none was added) · ⛔ 0 traceability rows added (Stage 5) · ⛔ 0 identifiers minted in the subjects ·
⛔ 0 requirements or ACs changed · ⛔ 0 gaps closed beyond those `ADR-0091` closed · ⛔ 0 waivers ·
⛔ 0 §11 exceptions · ⛔ 0 lines under `lib/`, `test/`, `tool/`, `web/`, `android/`, `.github/`.

---

## §8 — Verdict

| # | Check | Authority | Result | Evidence |
|---|---|---|---|---|
| 1 | Context ownership is exclusive | BC Map §3 | ✅ **PASS** | §4.1 — `MASTER_PRD` **L171**; BC Map **L132**, **L115**; `AR-1`; 0 aggregates owned twice; BC count **31** |
| 2 | Every integration edge exists in §7 | BC Map §7 | ✅ **PASS** | §4.2 — **7/7** edges at L299/L328/L329/L330/L331/L332/L335; **0** new edges |
| 3 | Rank direction is downward | Matrix `L2` | ✅ **PASS** | §4.3 — Matrix **L49**, **L72**, **L354**, **L90**; 0 same-rank, 0 upward, 0 §11 exceptions |
| 4 | No authorisation outside `BC-18` | `X-13` | ✅ **PASS** | §4.4 — 0 authorisation decisions; BC Map **L127** |
| 5 | No credential/OTP/session outside `BC-18` | `ID-1` | ✅ **PASS** | §4.5 — 0 occurrences; BC Map **L178**; `GLS-INV-004` |
| 6 | Tenant scoping correct | `MP-GBR-08`, `X-13` | ✅ **PASS** | §4.6 — `MASTER_PRD` **L339**; Matrix **L362**; BC Map **L488**; `GLS-INV-001`…`006`; CI banned symbols |

### ⭐⭐ STAGE 3 — **PASS, 6 of 6** — CONFERRED on B4, B5 and B6

**Findings accepted: 0 · Findings rejected: 7 (§5, each with its reason) · Conflicts named and disposed: 3
(§2) · Items left OPEN with named owners: 6 (§6) · ADRs required by this review: 0.**

### What this verdict does NOT confer

| ⛔ | Statement |
|---|---|
| ⛔ | **Stage 4 NOT ENTERED.** No requirements review has been performed on B4/B5/B6 |
| ⛔ | **Stage 5 NOT ENTERED.** **0** traceability rows exist for `PRD-021B` B4/B5/B6 and none was added |
| ⛔ | Stage 6, 7, 8, 9 **NOT ENTERED** |
| ⛔ | **`PRD-021B` is NOT FROZEN.** No part of it is `READY`, `APPROVED` or `VERIFIED` |
| ⛔ | **NO IMPLEMENTATION.** 0 lines of code, 0 `IMPL-*` identifiers, 0 test files |
| ⛔ | No baseline identifier movement; `DOCUMENTATION_BASELINE.md` untouched |
| ⛔ | No wave promotion beyond the `PYK-SRC-001` subset `ADR-0091` §4.3 admits |
| ⛔ | No closure of `PYK-GAP-002`, `PYK-GAP-003`, `GLS-GAP-002`, `XPB-DRIFT-001`, `FOD-1`, `FOD-2` or `FOD-4`-for-B7/B8/B9 |

---

## §9 — Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-02 | Created. Stage 3 Architecture Review of `PRD-021B` B4/B5/B6 — **PASS 6/6**. Prerequisite: `ADR-0091` (Accepted). 7 findings rejected with reasons; 1 instrument defect disclosed (§4.1e / R-7); 6 items left OPEN with named owners. 0 subject bytes changed; 0 Rank 1–6 documents changed. |
