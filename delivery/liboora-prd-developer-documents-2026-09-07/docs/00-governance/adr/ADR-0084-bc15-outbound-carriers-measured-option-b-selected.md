# ADR-0084 — `BC-15` outbound carriers: **Option B selected on measurement.** A4's group events publish through §9 + `E-20`/`E-23`; A6's report filing is `BC-13`'s internal command surface, not an edge — and one residue is disclosed, not closed

| Field | Value |
|---|---|
| **Status** | **Accepted** — 2026-08-31 |
| **Date** | 2026-08-31 |
| **Deciders** | **Architecture Owner** — authority conferred directly by the human principal in *"PRD-021A — FINAL A4/A6 ARCHITECTURE BLOCKER RESOLUTION"* |
| **Supersedes** | — |
| **Amends** | `PRD-021A_A4_..._v0.1.md` (`LCG-ADR-002` resolved) · `PRD-021A_A6_..._v0.1.md` (`LCS-ADR-001b` resolved) · `ADR-INDEX.md` (registration + count re-derivation) |
| **Amended by** | — |
| **Baseline** | ⛔ **No baseline re-issue.** ⭐⭐ **AND NO Rank 1–5 DOCUMENT IS MODIFIED AT ALL** — see §6. The BC Map, the Dependency Matrix and `module_dependencies.yaml` are **byte-unchanged** by this ADR. That is the strongest possible form of citation-integrity preservation: not "measured and minimised", but **zero**. |
| **Closes** | ✅ `LCG-ADR-002` (A4) · ✅ `LCS-ADR-001b` (A6) |
| **Does NOT close** | ⛔ **`GAP-BC15-ANALYTICS`** — newly measured in §5.4 and **disclosed, not closed**: `BC-15 → BC-26` has no carrier, and A2/A3 name "analytics" as an event consumer. This ADR does not manufacture one. ⛔ `GAP-BC14-RANK` · ⛔ `LCG-DEC-005b` · ⛔ `LCO-DEC-003`…`006` |
| **Related** | `ADR-0083` (the 22 Owner rulings; **AO-4** is the ruling this ADR completes) · `ADR-0065` (the local-projection pattern) · `ADR-0033` (withdrew `E-27`) · `PRD-017` Stage-3 alignment **R-6** — ⭐ **the precedent that was tested and found NOT to transfer** (§4.3) |

> ✅ **ACCEPTED 2026-08-31.**
>
> ⭐⭐⭐ **This ADR corrects a finding of my own.** The Stage-3 alignment record dated
> 2026-08-31 (commit `cf1d07f`) recorded A4 and A6 as **failing** Stage-3 check 2 on the
> ground that *"`BC-15` is the source of ZERO edges."* **That measurement was taken with a
> faulty instrument.** The awk expression read the edge table's **column 2** as the source
> cell; §7's tables put the source in **column 3**. Re-measured correctly, five §7 edges
> have a **wildcard source** — `E-17` *"All write paths"*, and `E-18`, `E-19`, `E-20`,
> `E-23` *"All contexts"* — and a wildcard includes `BC-15`.
>
> ⚠ **The prior record is NOT deleted or overwritten.** It is superseded by a new dated
> record placed beside it, exactly as it was itself placed beside its own predecessor. A
> corrected measurement that erases the wrong one destroys the evidence that the
> instrument was faulty.

---

## 1. Context

At commit `cf1d07f`, `PRD-021A` stood at:

- **Stage 3 CONFERRED:** A1, A2, A3, A5, A7, A8
- **Stage 3 NOT CONFERRED:** A4, A6
- Two blockers, both check 2, both attributed to one root cause:

| Blocker | Part | Claim as recorded |
|---|---|---|
| `LCG-ADR-002` | A4 | `GroupCreated` / `GroupMembershipGranted` / `GroupMembershipRevoked` have no publication carrier |
| `LCS-ADR-001b` | A6 | Report **filing** (`BC-15` → `BC-13`) has no carrier |

The Architecture Owner authorised resolution, requiring a repository-grounded analysis of
**Option A** (add an outbound edge) versus **Option B** (use an existing carrier), with the
explicit constraint: *"Do NOT choose an option merely because it makes Stage 3 pass."*

---

## 2. The measurement that changed the answer

### 2.1 The faulty instrument

The prior pass ran, in effect:

```awk
awk -F'|' '/^\| *E-[0-9]/ { src=$2; if (src ~ /BC-15/) ... }'
```

In a markdown row `| E-20 | All contexts | BC-24 Audit Trail | ... |`, splitting on `|`
yields `$1=""`, `$2=" E-20 "`, `$3=" All contexts "`, `$4=" BC-24 Audit Trail "`. **`$2` is
the edge id, not the source.** The scan therefore compared `BC-15` against `E-01`…`E-29`
and correctly returned zero — while measuring the wrong column.

⭐ **The zero was real. It was an answer to a question nobody asked.**

### 2.2 The corrected measurement

```
Edges whose SOURCE cell is a wildcard  (source = $3)
  E-17 : All write paths => BC-21 Entitlement
  E-18 : All contexts    => BC-19 Tenancy
  E-19 : All contexts    => BC-25 Configuration
  E-20 : All contexts    => BC-24 Audit Trail
  E-23 : All contexts    => BC-22 Notification Delivery

Edges whose DEST cell contains BC-13   (dest = $4)
  (none)  — BC-13 has ZERO inbound edges. This part of the prior finding was CORRECT.
```

**`BC-15` therefore has five lawful outbound carriers, and `BC-13` remains unreachable by
edge.** The two blockers are **not** the same root cause. They must be answered separately.

### 2.3 The repository had already said so, twice, in documents that PASSED

| Where | Verbatim | Status |
|---|---|---|
| A7 **L167** (`A7-F1`) | *"`E-23` = **'All contexts** → `BC-22`', `PL`, Event \| BC Map **L332** \| ✅ **`BC-15` is already a lawful producer. NO new edge.**"* | ✅ Stage 3 CONFERRED |
| A6 **L270** | *"Audit emission \| ✅ **NO** \| `E-20` **'All contexts → `BC-24`'**"* | in the failing part |
| A6 **L271** | *"Config reads \| ✅ **NO** \| `E-19` **'All contexts → `BC-25`'**"* | in the failing part |

⭐⭐ **A6 itself already relied on wildcard-sourced edges, two rows above the row that
declared it blocked.** A7 was conferred Stage 3 on exactly this reasoning. The prior pass
accepted the reasoning in A7 and contradicted it in A6 — an inconsistency the corrected
measurement removes.

---

## 3. A4 — `LCG-ADR-002` RESOLVED. Option B.

### 3.1 §9 is a registration mechanism independent of §7 — proven, not assumed

`GroupCreated` and its siblings are **domain events**, not synchronous calls. The question
is what governs event publication. **§9 "Published Language — Event Surface"**, not §7.

**Proof by counter-example, measured on the live document:**

| Producer | §9 row | Named consumer | §7 edge for it? |
|---|---|---|---|
| `BC-11` | **L430** `social.FriendshipEstablished` / `UserBlocked` → `BC-12`, **`BC-26`** | `BC-26` | ⛔ **NONE.** `BC-11`'s only §7 outbound edge is `E-16` → `BC-12` |
| `BC-03` | **L417** `attendance.FraudSignalDetected` → `BC-24`, **`BC-13`**, `BC-22` | `BC-13` | ⛔ **NONE.** `BC-03`'s edges are `E-08` → `BC-04`, `E-24` → `BC-30` |
| `BC-12` | **L431** `messaging.MessageSent` → **`BC-13`** (sampling), `BC-26` | `BC-13` | ⛔ **NONE** |

⭐⭐⭐ **Three producers publish lawfully to consumers they have no §7 edge to.** If §7
governed event publication, all three rows would be violations of the frozen BC Map. They
are not; §7's own preamble (**L292**) scopes itself to *"Every edge that **crosses a context
boundary**"* — synchronous coupling — while §9.1 defines a separate contract for events:
**Transactional Outbox**, at-least-once, per-aggregate ordering, DLQ.

**These are two different mechanisms with two different registries.** Publishing a domain
event does not create a §7 edge and does not require one.

### 3.2 What A4 actually needs, and what carries it

A4's three events are **`BC-15`-internal state facts**. Measured: **no part of A1–A8
consumes them**, and A4 mints no `LCG-EVT-*` identifiers. Their consumers are the generic
platform contexts every context reaches by wildcard:

| Need | Carrier | Authority |
|---|---|---|
| Audit of group lifecycle | **`E-20`** *"All contexts → `BC-24`"* | BC Map **L329** |
| Notification facts (e.g. membership granted) | **`E-23`** *"All contexts → `BC-22`"* | BC Map **L332** |
| Tenant context propagation | **`E-18`** | BC Map **L327** |
| Config reads | **`E-19`** | BC Map **L328** |
| Entitlement check before mutation | **`E-17`** | BC Map **L326** |

✅ **`LCG-ADR-002` is RESOLVED. No ADR registering a "`BC-15`-sourced event edge" is
required, because no such edge is required for event publication.** `E-20` and `E-23`
already source from `BC-15` by wildcard, and `LCG-FS-006`'s outbox/idempotency requirement
is precisely §9.1's contract.

### 3.3 ⛔ What this does NOT authorise

- ⛔ **No `LCG-EVT-*` identifier is minted.** A4 named its events in prose; this ADR does not
  register them in BC Map §9 either. **Adding a `BC-15` producer row to §9 would be a Rank 4
  amendment**, and it is not needed for Stage 3: the events are consumed by wildcard-reached
  generic contexts, not by a named domain peer.
- ⛔ **No new edge.** §7 is byte-unchanged.
- ⛔ **`LCG-DEC-003`, `LCG-DEC-006`, `LCG-GAP-006` remain OPEN.** A4's flows carry other
  ⏸ markers. Only the `LCG-ADR-002` marker clears.

---

## 4. A6 — `LCS-ADR-001b` RESOLVED. Option B, on a different mechanism.

### 4.1 The premise of the blocker was architecturally inverted

`LCS-ADR-001b` assumed report filing requires a `BC-15 → BC-13` carrier. **`PRD-020`
§21.3 L1800–1801 says the opposite, in terms:**

> *"`BC-13` has **no published inbound edge** (`F-3`), so every command below is **internal
> to the safety application, not a cross-context API**."*

| Command | Actor |
|---|---|
| **`FileAbuseReport`** | **Any authenticated person** |

⭐⭐⭐ **The actor is a person, not a context.** Filing a report is a **user action against
`BC-13`'s own command surface**, not an inter-context integration. `BC-13` has zero inbound
edges **by design** — `F-3` requires that anything causing a `BC-13` change *"invok[es] the
domain's public command API through a registered port"*, with `BC-13` re-validating.

**Symmetry test.** `BC-11` and `BC-12` — `BC-15`'s cluster peers, both `[SUPPORTING]`, both
V1, both with reportable content — have **zero** outbound edges to `BC-13`. If filing
required an edge, every reportable context in the system would be broken. None is.
**`BC-15` is not an exception; it is the rule.**

### 4.2 What A6 must supply, and it already does

`PRD-020` **`TSF-FR-027`**: *"The `AbuseReport` subject type register **MUST** include
`COMMUNITY_POST` and `COMMUNITY_COMMENT` from V1, **unpopulated until `BC-15` ships**."*

A6 **L326**: *"`AbuseReport` | `BC-13` | ⛔ **Never held.** A6 supplies a **subject
reference**."*

`TSF-EVT-001` payload: `{caseId, category, severity, filedAt}` — ⛔ **no reporter identity,
no content.** `BC-13` needs a subject reference, which the filing person's client supplies.
**`BC-15` transmits nothing to `BC-13`.**

✅ **`LCS-ADR-001b` is RESOLVED.** The carrier is `BC-13`'s own `FileAbuseReport` command,
invoked by the reporting person per `F-3`, against subject types `PRD-020` **L603** built so
that *"the machinery is built now so that `BC-15` inherits it rather than reinventing it."*

⭐ **`LCS-ADR-001a` (reads) and `LCS-ADR-001b` (filing) are now both closed, by two
different existing mechanisms** — `E-14`-fed projection for reads, `F-3` command invocation
for filing. Neither invents a transport.

### 4.3 ⭐⭐ The `PRD-017` R-6 precedent was TESTED and does NOT transfer

`PRD-017`'s Stage-3 alignment **R-6** *rejected* minting an event, reasoning: *"`BC-29` is a
producer in **0** BC Map §9 rows … Minting the event would assert a path L292 says does not
exist."* `BC-15` is **also** a producer in 0 §9 rows. The precedent appears to forbid this
ADR's conclusion.

**It does not, and the distinction is classification:**

| | Classification | §7 wildcard reach |
|---|---|---|
| `BC-29` File & Media | **`[GENERIC]`** — a *capability* | ⛔ Bound by **`F-1`**/**`F-2`**: *"No capability context may import, reference, or query a domain context"* |
| `BC-15` Community & Groups | **`[SUPPORTING]`** — a *domain* context (BC Map **L119**) | ✅ Included in *"All contexts"* |

⭐⭐⭐ **R-6 rejected giving a CAPABILITY a publisher role. This ADR gives `BC-15` nothing —
it observes that a DOMAIN context already has the wildcard carriers.** And this ADR
**follows** R-6 on the point that matters: **it mints no event identifier and adds no §9
producer row**, routing the facts through carriers *"whose owner already publishes."* That
is R-6's own remedy, applied.

---

## 5. Verification of the chosen architecture

### 5.1 Option A was considered and REJECTED on the merits

| Requirement | Finding |
|---|---|
| Exact destination BC | ⛔ **Cannot be named.** A4's events have **no named consumer** in any part; A6's filing needs `BC-13`, which refuses inbound edges by design (`F-3`) |
| Capability/aggregate consumed | ⛔ None identified for A4. For A6, `AbuseReport` — and A6 explicitly *"never holds"* it |
| Rank direction | ⚠ A `BC-15 → BC-13` edge would be **same-rank within the Social cluster** and would need the `ADR-0011` L92–95 analysis |
| Duplicate ownership risk | ⛔ **An edge feeding `BC-13` writes would put `BC-15` adjacent to `AbuseReport`** — the exact duplication A6-F1 forbids |
| Owner constraint | ⛔ **`AO-4` expressly forbids** a `BC-15 → BC-13` edge |

⭐ **Option A fails on its own checklist before reaching the Stage-3 question.** It cannot
name a destination for A4 and is forbidden for A6.

### 5.2 Option B verified against every required check

| Check | Result |
|---|---|
| **Ownership** | ✅ No aggregate moves. `AbuseReport`/`ModerationCase` stay `BC-13`'s; `Community`/`Group` stay `BC-15`'s |
| **Edge existence** | ✅ `E-17`…`E-20`, `E-23` exist in §7 at **L326–L332**; `E-14` at **L318** |
| **Rank direction** | ✅ All five wildcard edges are **domain → capability**, §7.3's declared downward direction. `F-4`'s forbidden direction is not engaged |
| **Cluster membership** | ✅ Unchanged. `BC-15` remains in the Social cluster per `AO-7`; no cluster edit |
| **Authorization** | ✅ `FileAbuseReport` is authorised *"Rate-limited by `BC-18`/edge"* — `BC-18` retains it. **0 `PERM-*` minted** |
| **Credential/session** | ✅ Untouched. `ID-1` intact |
| **Tenant/community isolation** | ✅ `EV-1`…`EV-4` unchanged; `BC-15` events still carry **no `tenantId`**; **`ID-2` untouched** |
| **Duplicate ownership** | ✅ None created — this is why Option B is safer than Option A, not merely cheaper |
| **New transport invented** | ✅ **NONE.** Outbox (§9.1) and `F-3` command invocation both pre-exist |
| **BC Map / Matrix modified** | ✅ **NO — byte-unchanged.** See §6 |

### 5.3 Why this is not an option chosen to make Stage 3 pass

⭐⭐ **The strongest evidence that this analysis was not outcome-driven is §5.4: it opens a
new gap the prior pass had not found.** An analysis steered toward a PASS would not
manufacture a fresh blocker on its way there.

Further: **`E-21` search remains REFUSED.** The same wildcard logic was tested against
search and **fails** — `E-21`'s source cell is `BC-01, BC-10`, an **enumeration, not a
wildcard**, so `BC-15` is genuinely absent and `AO-9`'s conditional still bites. A
convenient reading would have extended the wildcard argument to `E-21`. Measurement forbids
it.

### 5.4 ⛔ NEW GAP — `GAP-BC15-ANALYTICS`, disclosed and NOT closed

Measured while verifying §5.2:

```
Edges whose DEST contains BC-26:   E-26 : BC-27 AI => BC-26 Analytics, BC-23 Search
```

**`BC-26` is reachable only from `BC-27`.** There is no wildcard carrier to Analytics. Yet
A2 **L1490–1495** names *"analytics"* / *"analytics aggregate"* as a consumer of four of its
six events, and A3 relies on ranking inputs.

| | |
|---|---|
| **Mitigating** | A2 **L481** `LCF-XC-029` scopes *"the analytics product for community content"* as **V3** (EA **L973**), so nothing in V2 depends on it |
| **Not resolved** | The §9 counter-examples show `BC-11`/`BC-03` name `BC-26` as a consumer with no edge — so the pattern may be lawful by the same §9-independence this ADR establishes. ⚠ **But that is an inference, and this ADR does not make it.** `BC-11`'s `BC-26` reach may rest on an authority not measured here |
| **Disposition** | ⚠ **DISCLOSED, NOT CLOSED.** Routed to the Architecture Owner as **`GAP-BC15-ANALYTICS`**. ⛔ **Non-blocking for Stage 3** — the dependent product is V3 and no V2 requirement fails on it |

⛔ **A2's Stage-3 conferral is NOT retracted**, because the dependency is V3-scoped and
`LCF-XC-029` already excludes it. But the gap is named rather than left for someone else to
rediscover.

---

## 6. ⭐⭐ Citation integrity — the cost of this decision is ZERO

| Document | Rank | Modified? |
|---|---|---|
| `LIBOORA_BOUNDED_CONTEXT_MAP.md` | 4 | ⛔ **NO — byte-unchanged** |
| `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` | 4 | ⛔ **NO — byte-unchanged** |
| `tool/module_dependencies.yaml` | 4 | ⛔ **NO — byte-unchanged** |
| `MASTER_PRD.md`, `PRD_LIFECYCLE.md`, EA, `DOCUMENTATION_BASELINE.md`, `TRACEABILITY_MATRIX.md` | 1–3 | ⛔ **NO** |
| `PRD-020_TRUST_AND_SAFETY.md` | 5 | ⛔ **NO** |

⭐⭐⭐ **Option B required no architectural amendment at all** — because the architecture
already permitted what A4 and A6 needed. **187** references point into the BC Map; this ADR
shifts **none of them**, because it changes nothing in it.

⚠ **This is the decisive practical argument for Option B over Option A**, and it is a
consequence of the analysis rather than its motive: an option that needs no amendment to a
Rank 4 document is safer than one that needs two, **when both are architecturally sound**.
Option A was rejected in §5.1 on soundness, before cost was considered.

**Edited by this ADR:** A4 (Rank 6 draft), A6 (Rank 6 draft), `ADR-INDEX.md`, and a new
dated Stage-3 record. All in-place or new-file; **no line-shift in any cited document.**

---

## 7. Decision

1. ✅ **Option B is selected for both blockers**, on two distinct pre-existing mechanisms:
   - **A4:** BC Map **§9** publication + the wildcard carriers `E-20`/`E-23` (with `E-17`,
     `E-18`, `E-19` for gating, tenancy and config).
   - **A6:** `BC-13`'s **internal `FileAbuseReport` command surface**, invoked per **`F-3`**
     by the reporting person, against `TSF-FR-027`'s pre-built subject types.
2. ✅ **`LCG-ADR-002` is CLOSED.** No `BC-15`-sourced event edge is required.
3. ✅ **`LCS-ADR-001b` is CLOSED.** Report filing needs no edge; requiring one misread `F-3`.
4. ⛔ **No edge, event identifier, permission, policy value, BC, or infrastructure is
   invented. No §9 producer row is added. `ID-2` is untouched. No accepted ADR is reopened.
   No requirement is downgraded.**
5. ⛔ **`E-21` search remains REFUSED** — `E-21`'s source is an enumeration, not a wildcard.
6. ⚠ **`GAP-BC15-ANALYTICS` is opened, disclosed and routed** — not closed.
7. ⭐ **The prior Stage-3 record's check-2 finding is CORRECTED, not deleted.** The faulty
   column offset is documented in §2.1 so the error is auditable.

---

## 8. Consequences

**Positive.** A4 and A6 become Stage-3 evaluable on their merits. `PRD-021A` can be assessed
as a whole. No Rank 1–5 document changes. The A6/A7 inconsistency is removed.

**Negative / accepted.** A4's events remain **unregistered in BC Map §9** — deliberate: the
events have no named domain consumer, and registering them would be an unnecessary Rank 4
amendment. If a future part consumes `GroupCreated` by name, a §9 producer row **will** be
required, and that is a new decision.

⚠ **What this ADR does not make true.** A4 and A6 still carry unrelated open items
(`LCG-DEC-003`, `LCG-DEC-006`, `LCG-GAP-006`, `LCG-DEC-005b`, `LCO-*`). Closing a check-2
blocker does not make a part complete, and Stage 4 is a separate gate.

---

**Determination:** ✅ **Option B, on measurement.** `LCG-ADR-002` and `LCS-ADR-001b` CLOSED;
`GAP-BC15-ANALYTICS` opened and disclosed; **zero Rank 1–5 modifications**; zero inventions.
