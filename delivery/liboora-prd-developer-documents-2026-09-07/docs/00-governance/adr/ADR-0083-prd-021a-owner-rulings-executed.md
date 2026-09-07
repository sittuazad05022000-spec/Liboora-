# ADR-0083 — `PRD-021A` consolidated Owner rulings executed: two integration edges admitted by APPEND, the Social cluster extended to `BC-15`, six prefixes registered, A6/A7/A8 authorised — and three conflicts inside the rulings disclosed rather than resolved by inference

| Field | Value |
|---|---|
| **Status** | **Accepted** — 2026-08-31 |
| **Date** | 2026-08-31 |
| **Deciders** | **Product Owner** for §3 (PO-1…PO-7) · **Social Domain Owner** for §5 (`LCT-CONF-001`) · **Architecture Owner** for §4 (AO-1…AO-9, the BC Map and Matrix amendments) · **Governance Owner** for §6 (prefix registration, registry §11.4, A6/A7/A8 authorisation) — the role constituted by `ADR-0080` §2.2 and constituted **VACANT** at `ADR-0080` **L85**, here **filled for this act only** by **direct conferral from the human principal of this engagement**, in the same manner and with the same disclosure as `ADR-0032` §5.2, `ADR-0033` §7.2, `ADR-0036` §8.2 and `ADR-0080` §5. ⛔ **No ARB quorum, attendee list, sign-off date or Security review is asserted.** ⛔ **No personal name is recorded** — `PRD_OWNERSHIP_MODEL.md` §7 rule 4 |
| **Supersedes** | — |
| **Amends** | **`LIBOORA_BOUNDED_CONTEXT_MAP.md`** v1.8 → **v1.9** (new **§15**, appended below L624; §7 and §8 **byte-unchanged**) · **`LIBOORA_MODULE_DEPENDENCY_MATRIX.md`** (§3.2 **L90** and §12 **L652**, both edited **in place** with no line added or removed) · **`tool/module_dependencies.yaml`** (**L234**, **L255**, in place) · **`ADR-0036`** §8.2 (append only — question 2's outcome cell and a new §8.2a) · **`PRD_REGISTRY.md`** §11.4 · **`PRD_OWNERSHIP_MODEL.md`** §10 (prefix register, append) |
| **Amended by** | — |
| **Baseline** | ⛔ **No baseline re-issue.** `DOCUMENTATION_BASELINE.md` §7 rule 4 moves the identifier only when a **Rank 1–3** document changes version. The BC Map and Matrix are **Rank 4**; the registry and ownership model are **unranked**; `ADR-0036` is an ADR. **`DOCUMENTATION_BASELINE.md` is byte-unchanged** — sha256 `7e1c69f92363a5e5…` before and after |
| **Closes** | `LCM-DEC-001` · `LCM-GAP-001` · `LCR-DEC-006` · `LCR-DEC-009` · `LCG-DEC-001` · `LCG-DEC-003` · `LCG-DEC-004` · `LCG-DEC-005` · `LCG-DEC-006` · `LCO-DEC-001` · `LCO-DEC-002` · `LCT-CONF-001` · `LCT-CONF-002` · `LCF-ADR-002` · `LCF-ADR-003` · `LCF-ADR-007` · `LCF-ADR-001`/`LCR-DEC-007`/`LCG-ADR-001` (aggregate registration + part classification) · `LCS-ADR-001` · `LCT-ADR-002` · `LCF-GAP-009` · `LCS-GAP-001` · `LCM-GAP-011`-adjacent window-boundary row of `ADR-0036` §7.3 · prefix gaps for `LCM-`, `LCG-`, `LCO-`, `LCS-`, `LCN-`, `LCT-` |
| **Does NOT close** | ⛔ **`LCG-ADR-002`** — no `BC-15`-**sourced** event edge is authorised by any ruling, so `GroupCreated`/`GroupMembershipGranted`/`Revoked` remain unpublishable (§4.6) · ⛔ **`LCG-GAP-006`/`LCG-ADR-003`** — the `communityId` scoping key is unminted · ⛔ **`GAP-BC14-RANK`** (opened here, §4.4) — `BC-14`'s module and rank are **unmeasured** · ⛔ `LCG-AC-014` · ⛔ `PGA-08` · ⛔ `Q-A6` · ⛔ `SECP-DEP-007`'s ownership-model half · ⛔ **and it does NOT confer Stage 3, does NOT enter Stage 4, does NOT register traceability, does NOT create any `IMPL-*`, and does NOT make `PRD-021A` `READY`, `APPROVED` or `FROZEN`** |
| **Related** | `ADR-0079` §8.5 Option A — **the append-only method this ADR reuses** · `ADR-0011` (rank 7.5; the Social cluster's current membership) · `ADR-0033` (withdrew `E-27`; why this ADR mints `E-28`/`E-29` and **not** `E-27`) · `ADR-0065` (the existing-edge-fed local projection precedent AO-4 invokes) · `ADR-0078` (`BC-15` carries no `tenantId`; `ID-2`) · `ADR-0080` §5 (the prefix-registration method §6 reuses) · `ADR-0081`, `ADR-0082` (the prior refusal passes, **not reopened** — their refusals were correct *for want of an owner*, and an owner has now ruled) · `ADR-0036` §6.5, §8.2 · BC Map **L292**, **L119**, **L318**, **L379**, **L488** · Matrix **L49**, **L90** · `PRD_LIFECYCLE.md` §5 rule 5, §6 **L277**/**L282** |

> ✅ **ACCEPTED 2026-08-31.**
>
> This ADR executes the instruction *"Record and execute them exactly as stated. Do not reinterpret them."*
>
> ⭐ **It executes 22 rulings and reinterprets none.** Where a ruling could not be executed exactly as stated
> without a second, unstated decision, the ruling is executed **as far as its own words reach** and the residue
> is **disclosed and routed** — never inferred. Three such residues exist and are at **§4.4**, **§4.6** and
> **§7.3**. A pass that reported 22 clean executions would be concealing all three.

---

## 1. Context

On 2026-08-31 the human principal issued *"PRD-021A — CONSOLIDATED OWNER RULINGS + EXECUTION AUTHORIZATION"*,
supplying **22** rulings against the 22 open items measured at commit `c66f1d7` and recorded in
`PRD-021A_A1-A8_OWNER_DECISION_PACKAGE.md`, together with explicit execution authority.

`ADR-0081` and `ADR-0082` had previously **refused** several of these items as undecidable. ⭐ **Those refusals
are not reversed and are not errors.** Both were explicitly reasoned *"for want of an owner"* — `ADR-0081` §2 ran
six determinability probes and found no authority; `ADR-0082` routed 18 items rather than resolving them. An
owner has now ruled. **A refusal for want of authority is discharged by authority arriving, not by being
overturned**, and neither ADR is reopened.

---

## 2. ⭐ The method question, decided by measurement before any edit

Every architectural ruling below requires touching **Rank 4** documents that are cited by line across the
repository. The method was chosen by measurement, not preference.

**Measured at `c66f1d7`, across all of `docs/`:**

| Document | Line-citations | Highest cited line | Total lines |
|---|---|---|---|
| `LIBOORA_BOUNDED_CONTEXT_MAP.md` | **2,812** | **624** (= EOF) | 624 |
| `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` | **420** | **582** | 670 |

**Cost of inserting a row into §7, where the edges live:**

| Insertion point | Citations invalidated |
|---|---|
| §7.2 (after `E-16`, ~L320) | ⛔ **1,497** |
| §7.3 (after `E-26`, ~L336) | ⛔ **1,293** |
| §8 aggregate table (~L388) | ⛔ **747** |
| ⭐ **Append below L624** | ✅ **0** |

⛔ **Insertion is therefore refused.** Shifting 1,293 line-citations — many of them in **FROZEN** Rank 3
documents — to add two rows would be the exact defect `ADR-0075` measured and `ADR-0079` §8.5 declined, and the
exact defect `ADR-INDEX.md`'s "Process" step 1 disclosure records as having already happened four times.

⭐ **Method adopted: `ADR-0079` §8.5 Option A — append-only.** The BC Map gains a **new §15** below its last
line. **§7 and §8 are byte-identical.** Every one of the 2,812 existing citations re-resolves to the same text.

**Why an appended section is still normative.** BC Map **L292** says *"If an edge is not in this table, it does
not exist and adding it requires an ADR."* §15 is **an extension of that table by this ADR**, declared as such
in its own heading and cross-referenced from the header block. This is precisely what `ADR-0079` did to the
Enterprise Architecture: **482** citations re-resolved, **0** invalidated, and the appended §12 is authoritative.
The alternative — editing §7 in place — would satisfy a formatting preference at the cost of 1,293 true citations.

**The Matrix is amended IN PLACE, not appended**, because its two affected statements are **single lines whose
content changes without changing the line count** (L90, L652). An in-place edit that adds and removes no line
shifts **zero** citations, so it is strictly safer than an append here.

---

## 3. Product Owner rulings — executed

| # | Ruling as given | Executed as | Where |
|---|---|---|---|
| **PO-1** | `W₀ = D+1`; window is `D+1`, `D+2`, `D+3`; record inside existing `ADR-0036` §8.2 q2; **no new ADR** | ✅ `ADR-0036` §8.2 question 2 outcome cell changed `⛔ NOT ANSWERED` → **✅ ANSWERED**, and a new **§8.2a** records the conferral verbatim with its arithmetic | `ADR-0036` §8.2, §8.2a |
| **PO-2** | Permanent deferral. `LCR-RS-003` stays `ELIGIBLE` at weight `0`. Recency `70`, Legitimate engagement `30`, Helpfulness `0`. Close `LCR-DEC-009` as deliberately deferred **without inventing a weight** | ✅ `LCR-DEC-009` **CLOSED — PERMANENTLY DEFERRED**. §12.1 unchanged in its numbers (it already reads 70/30/0) | A3 §12.1, §31 |
| **PO-3** | The measured `BC-15` residue is **Part A4 — Community Groups & Roles**, a part of `PRD-021A`, **not** a standalone PRD | ✅ `LCG-DEC-001` **CLOSED**. `LCG-ADR-001` discharged by this ADR §6.4 | A4 §32; §6.4 below |
| **PO-4** | Closed role set `OWNER`, `MODERATOR`, `MEMBER`; ranking `OWNER > MODERATOR > MEMBER`; **add no other role** | ✅ `LCG-DEC-003` **CLOSED**. A4 **L208** candidate marker removed; set declared **CLOSED**; `LCG-AC-015` becomes **writable** | A4 §3, §32 |
| **PO-5** | Closed enum `PUBLIC`, `PRIVATE`. `PUBLIC` discoverable per existing discovery rules; `PRIVATE` requires membership/authorised access. **Invent no additional state** | ✅ `LCG-DEC-005`'s **visibility half CLOSED**. A4 **L231** enumerated | A4 §4, §32 |
| **PO-6** | A community SHALL NOT become ownerless. Last `OWNER`'s departure is **blocked** until another eligible member is explicitly promoted. ⛔ **No silent auto-promotion** | ✅ `LCG-DEC-006` **CLOSED**. Confirms A4 `LCG-EC-003` (**L455**), which already refused auto-promotion; `LCG-AC-016` becomes **writable** | A4 §8, §32 |
| **PO-7** | (1) The surface **exists**; (2) it is **Part A5**; (3) it does **not** silently extend A2's closed contract; (4) A5 may publish through its own mechanism, A2's six-event contract stays authoritative unless A2 is separately amended; (5) A5 invents **no seventh A2 event** | ✅ `LCO-DEC-001` (Gate 1) **CLOSED — ALLOCATED**; `LCO-DEC-002` (Gate 2) **CLOSED — EXISTS**; `LCR-DEC-006` **CLOSED — exists, does NOT extend the type set**. A5's §0.3 double gate is **satisfied**, not deleted | A5 §0.3, §29.2; A3 §31 |

### 3.1 ⚠ PO-2 — the arithmetic disclosed in the decision package is now moot, and why that is worth stating

The package disclosed that any weight `> 0` for `LCR-RS-003` would **necessarily supersede** `LCR-DEC-008`,
because A3 **L1160** forbids carving from the ruled `70`/`30` while `LCR-FR-035` (**L616**) requires the active
set to sum to exactly `100`. ⭐ **The ruling chose `0`, which is the one value that engages neither horn.**
`LCR-DEC-008` is **untouched**, `LCR-FR-035` still holds (`70 + 30 = 100`), and no renormalisation occurs.
The trap was real and the ruling avoided it; both facts are recorded.

### 3.2 ⚠ PO-5 — one half of `LCG-DEC-005` is NOT closed

`LCG-DEC-005` as written in A4 §32 asks **two** questions: *"Group `visibility` enum; **whether names are unique
per community**"*. The ruling answers the enum and is **silent on name uniqueness**. ⛔ **The uniqueness half is
therefore left OPEN and is not inferred** — a uniqueness constraint is an invariant with an index and an error
path, and PO-5's words do not reach it. Tracked as **`LCG-DEC-005b`**, Product Owner. `LCG-GAP-005` (`name`
bounds, deferred to `BC-25`) is likewise untouched.

---

## 4. Architecture Owner rulings — executed

### 4.1 The two new edges, and why they are `E-28` and `E-29`

⛔ **`E-27` is NOT reused.** It was withdrawn by `ADR-0033` (BC Map v1.7 changelog row, at **L615** in v1.9 —
it stood at **L614** in v1.8 and moved down one line when this ADR's own v1.9 row was inserted above it; that
single-citation cost is disclosed in the v1.9 row itself and repaired here in the same commit), and
`PRD_LIFECYCLE.md` §5 rule 5 states *"Numbers are never reused, even after withdrawal."* The edge set therefore
runs `E-01`…`E-26`, `E-28`, `E-29`, with **`E-27` permanently vacant** — a gap that is a record, not an error.

| # | Ruling | Edge minted | Direction as declared |
|---|---|---|---|
| **AO-1** | `LCF-ADR-007` **ACCEPT** — authorise `BC-15 → BC-11`, performing **both** required acts | **`E-28`** | Provider `BC-11 Social Graph` → consumer `BC-15`; the dependency direction is `BC-15 → BC-11`, matching `E-16`'s shape exactly (consumer asks through a port) |
| **AO-3** | `LCF-ADR-002` **ACCEPT** — authorise `BC-15 → BC-14`; **no duplicate media owner in `BC-15`** | **`E-29`** | Provider `BC-14 Content Sharing` → consumer `BC-15`. `BC-14` remains the **sole** owner of user-generated media (BC Map **L118**); `BC-15` holds a reference, never bytes |

Both are recorded in **BC Map §15.1**. §7 is byte-unchanged.

### 4.2 AO-1's second act — the Social cluster (also AO-7 / D-2)

Matrix rule `L2` (**L49**) forbids same-rank dependencies outside a **declared cluster**, and `domain/social` is
rank **8** (`tool/module_dependencies.yaml` **L47**). `E-28` is `BC-15 → BC-11`, both rank 8. So the edge alone
is insufficient — the cluster must admit `BC-15`.

**AO-7 rules exactly this**, enumerating the members as `BC-11`, `BC-12`, `BC-13`, `BC-15` and preserving
`domain/social` at rank 8. Executed:

- **Matrix L90** — members gain `BC-15 Community & Groups`; allowed internal edges become `E-14…E-16` **and `E-28`**
- **Matrix L652** — the §12 summary cell `Social BC-11…BC-13` becomes `Social BC-11…BC-13 + BC-15`
- **`tool/module_dependencies.yaml` L234** — `contexts: [graph, messaging, safety]` → `[graph, messaging, safety, community]`
- **`tool/module_dependencies.yaml` L255 area** — `E-28` declared, `from: community, to: graph, mode: port`

⭐ **No third cluster was created**, which matters: Matrix **L92–95** records `ADR-0011`'s warning that a third
R8 cluster spanning both worlds *"dissolves the Separate Ways boundary"*. Extending an existing cluster with a
context **already inside the Student Network** (BC Map **L119**, subdomain *Global Student*) engages none of
that. `X-05` is untouched — `BC-15` is on the social side of the prohibition, not the library side, so no bridge
is created and `E-13` remains the only one.

### 4.3 ⚠ `BC-15` is V2 and §7 is titled "in V1" — tested, and it is not an obstacle

BC Map **L292** reads *"Every edge that crosses a context boundary **in V1**"*, and `BC-15` is **V2** (**L119**).
Measured before relying on it: **`E-14` already lists `BC-14` and `BC-15` — both V2 — as consumers** (**L318**),
and `E-10` carries an explicit *"saga in V2, direct handler in V1"* note. V2 contexts appearing in §7 is
therefore an **existing shape**, not a new one. §15 nonetheless records both edges as **V2-scoped**, so no reader
can mistake them for V1 obligations.

### 4.4 ⛔⛔ RESIDUE 1 — `E-29`'s `L2` clearance is NOT established, and is not asserted

AO-3 authorises `BC-15 → BC-14`. AO-7 extends the cluster to **four** named members: `BC-11`, `BC-12`, `BC-13`,
`BC-15`. ⭐ **`BC-14` is not among them.**

**Measured:**

```
grep -c 'BC-14' LIBOORA_MODULE_DEPENDENCY_MATRIX.md   →  0
grep -c 'BC-14' tool/module_dependencies.yaml         →  0
```

⭐ **`BC-14` appears ZERO times in BOTH Rank 4 dependency documents.** Its module and its rank are therefore
**unmeasured**. Three consequences follow, and all three are stated rather than resolved:

1. If `BC-14` is rank 8 inside `domain/social`, then `E-29` is a **same-rank dependency outside the declared
   cluster** — an `L2` violation, because AO-7's enumeration stops at `BC-15`.
2. If `BC-14` is a lower rank, `E-29` is lawful downward and needs nothing further.
3. **It is not determinable which**, because no document assigns `BC-14` to a module.

⛔ **This ADR does not add `BC-14` to the cluster.** Doing so would exceed AO-7's explicit four-member
enumeration and would be *"inventing an additional decision"*, which the EXECUTION RULE forbids at item 5.
⛔ **It also does not claim `E-29` is `L2`-clear.** AO-9's own instruction — *"If an architectural amendment is
required, record it explicitly rather than silently claiming support"* — is applied here by analogy and by
preference.

**`E-29` is therefore admitted to §15.1 as AUTHORISED (AO-3) with its `L2` clearance recorded as UNDETERMINED**,
and the determination is routed as **`GAP-BC14-RANK`**, **Architecture Owner**. Any A2 requirement depending on
`E-29` stays blocked until it closes — which means **`LCF-FR-043`'s consequence survives this ADR**: only `TEXT`
posts ship, and `NOTE`/`MEDIA`/`LINK` remain blocked.

### 4.5 AO-2, AO-4, AO-5, AO-6, AO-8, AO-9 — executed

| # | Ruling | Executed as |
|---|---|---|
| **AO-2** | `LCF-ADR-003` **ACCEPT** opaque cursor pagination; opaque to clients; expose no internal ordering | ✅ Recorded in **§15.3**. ⭐ It **populates a declared-but-empty node** — EA **L379** already reads `Pagination & Filtering Standards (V1)`, and `grep -c cursor` across `docs/10-architecture/*.md` returned **0**. So no architectural layer is created; a reserved slot is filled. A2 `LCF-API-004` and `LCF-AC-036` updated |
| **AO-4** | `LCS-ADR-001` **Option B** — existing-edge-fed local projection; ⛔ **no new `BC-15 → BC-13` edge**; follow `ADR-0065`; `BC-13`/`PRD-020` keep moderation state | ✅ **Zero edges minted.** A6 reads a **local projection fed by the existing `E-14`**, which already targets `BC-15` (**L318**). No aggregate ownership moves; `ModerationCase`, `AbuseReport`, `EnforcementAction` stay `BC-13`'s (**L379**). §15.2 records the pattern and its limit |
| **AO-5** | ⛔ Do **not** promote V3 `Event Replay` into V2. A8 invents no V2 infrastructure. Where `LCF-NFR-006` is impossible in band, mark it **conditional/deferred** rather than pretend | ✅ `LCT-ADR-002` **CLOSED**. A2 `LCF-NFR-006` marked **CONDITIONAL — deferred to the V3 capability band**; A8 `LCT-GAP-004` closed as *"correctly identified, deliberately not solved in band"* |
| **AO-6** | `BC-15` events **exempt** from the universal envelope `tenantId` because `ID-2` is authoritative for `BC-15`; add no `tenantId`; don't violate `ID-2`; record the exception so A2/A8 share one rule; **no other BC gets it** | ✅ `LCT-CONF-002` **CLOSED**. Recorded in **§15.4** as a **single, narrowly-scoped** envelope exception naming `BC-15` only. Consistent with `ADR-0078` §2.1 and BC Map **L488** rule `ID-2` (*"BC-11→17 … Must never receive a `StudentRecordId` or `tenantId`"*) — ⭐ so this is **not a new exemption at all**; `ID-2` already forbade the field, and the defect was an envelope rule written as if universal |
| **AO-8** | D-5 **ACCEPT** append-only aggregate registration; ⛔ do not insert mid-table if it invalidates citations; preserve ownership and citation integrity | ✅ `BC-15`'s aggregates registered in **§15.5**, appended. §8's table is **byte-unchanged** — measured: a mid-table insert would have invalidated **747** citations |
| **AO-9** | Reporting → AO-4. Media → AO-3. Search → use `E-21` **only if** it supports `BC-15` without a new protocol; **otherwise record the amendment explicitly** | ✅ **Measured: `E-21` reads `BC-01, BC-10 → BC-23`. `BC-15` is NOT a consumer.** So `E-21` does **not** support it. ⭐ **Per AO-9's own conditional, no support is claimed and no edge is minted.** A8 `LCT-FR-064` (*"A8 SHALL NOT design a community search path"*) and `LCT-AC-032` are **CONFIRMED CORRECT**; community search stays **out of band** for V2, recorded in §15.6 |

### 4.6 ⛔⛔ RESIDUE 2 — `LCG-ADR-002` is not closed, so A4 publishes no event

A4 requires `LCG-ADR-002` — *"An ADR registering any `BC-15`-**sourced** event (`GroupCreated`,
`GroupMembershipGranted`/`Revoked`)"*. **Measured: BC Map §7 sources ZERO edges from `BC-15`**; the only row
touching it is `E-14`, **inbound**. `E-28` and `E-29` are both **inbound to `BC-15`** as well.

⛔ **No ruling authorises a `BC-15`-sourced event edge.** AO-1 and AO-3 authorise `BC-15` as a *consumer*;
AO-7 extends a cluster; neither makes `BC-15` a *producer*. **`LCG-ADR-002` therefore remains OPEN**, and A4's
three candidate events remain **unpublishable**. This is recorded in A4 §32 unchanged, and it is a **genuine
Stage-3 Check-2 failure for A4** reported as such in the fresh alignment record — not smoothed over.

⭐ **This is also why SD-1's withdrawal of `LCN-EVT-004` is coherent rather than merely obedient**: A7's
`MembershipChanged` was blocked by exactly this missing authority, and it still is.

---

## 5. Social Domain Owner ruling — executed

**SD-1 / `LCT-CONF-001`: OPTION B — reduce A7 to A2's existing six.** A2 remains the single source of truth.

**Measured before editing — the rename is an alignment, not a change of meaning:**

| | A2 v0.8 (measured) | A7 v0.1 (measured) |
|---|---|---|
| Comment event | `community.CommentPublished` | `community.CommentAdded` |
| Reaction event | `community.ReactionChanged` | `community.ReactionAdded` |

⭐ **A2 already uses the target names.** The ruling therefore corrects **A7's drift from A2**, which is exactly
what "A2 is the single source of truth" means in practice.

**Executed in A7:**

| Action | Identifier | Result |
|---|---|---|
| Rename | `LCN-EVT-002` | `community.CommentAdded` → **`community.CommentPublished`** |
| Rename | `LCN-EVT-003` | `community.ReactionAdded` → **`community.ReactionChanged`** |
| **WITHDRAW** | `LCN-EVT-004` | `community.MembershipChanged` — blocked by `LCG-ADR-002` (§4.6) |
| **WITHDRAW** | `LCN-EVT-005` | `community.ContentEligibilityChanged` — redundant; A1 derives eligibility with **no event** |
| **WITHDRAW** | `LCN-EVT-006` | `community.OfficialCommunicationPublished` — PO-7 item 5 forbids a seventh A2 event |
| **WITHDRAW** | `LCN-EVT-007` | `community.HelpRequestAnswered` — PO-2 defers helpfulness permanently |

⭐ **All four identifiers are RETAINED as `WITHDRAWN` rows and their numbers are NOT reused**, per
`PRD_LIFECYCLE.md` §5 rule 5. `LCN-EVT-008` is the next free number. A2 is **not** expanded, and **no seventh
A2 event exists**.

### 5.1 ⚠ One A7 token is deliberately left alone

A7 also carries **`community.NotificationSent`** (1 occurrence). ⛔ **It is not withdrawn.** SD-1 enumerates
four withdrawals by name and this is not among them; and on measurement it is **A7's own delivery-side fact**,
not a claim on A2's content contract — A2's closed set governs *community content events*, which this is not.
Withdrawing it would exceed the ruling. Its register placement is flagged for A7's own next pass.

---

## 6. Governance Owner acts — executed

### 6.1 Prefix registration — six prefixes

Method: **`ADR-0080` §5**, reused exactly. `PRD_LIFECYCLE.md` §5 rule 3 (*"On collision, change the new prefix,
never the existing one"*) and rule 5 applied. Each prefix was measured against every registered prefix.

| Prefix | Owning document | Collision check | Determination |
|---|---|---|---|
| **`LCM-`** | `PRD-021A` A1 — Library Community Foundation | Measured: **no collision** | ✅ **REGISTERED** |
| **`LCG-`** | `PRD-021A` A4 — Community Groups & Roles | Measured: **no collision** | ✅ **REGISTERED** |
| **`LCO-`** | `PRD-021A` A5 — Official Library Communication | Measured: **no collision** | ✅ **REGISTERED** |
| **`LCS-`** | `PRD-021A` A6 — Community Safety, Privacy & Moderation | Measured: **no collision** | ✅ **REGISTERED** |
| **`LCN-`** | `PRD-021A` A7 — Community Notifications | Measured: **no collision** | ✅ **REGISTERED** |
| **`LCT-`** | `PRD-021A` A8 — Technical & Production Architecture | Measured: **no collision** | ✅ **REGISTERED** |

⛔ **What registration does NOT do** — quoting `ADR-0080` §5, which said it first: *"It settles **only** the
prefix. It creates no requirement, closes no other gap, and confers no readiness."* All eight parts remain
**NOT READY / NOT FROZEN**.

### 6.2 `PRD_REGISTRY.md` §11.4 — A6, A7, A8 authorised as parts

The Governance authorisation item 1 requires the section *"so A6/A7/A8 are no longer recorded as nonexistent"*,
and item 2 *"Record their authorization as parts of PRD-021A."*

⭐ **This is the act `c66f1d7` expressly declined to perform**, and it declined for the right reason: it held
that *"Allocating these three parts is a Product Owner act and remains OPEN"* and that writing an authorisation
without one *"would manufacture a governance trace"*. **An authorisation now exists.** The three
`NOT AUTHORIZED` dispositions are replaced by **`AUTHORIZED as Part A6/A7/A8 of PRD-021A`**, and the second
falsification disclosed in `c66f1d7` (*"A6/A7/A8 not created"*) is **repaired by the same authority** —
because it is now a disposition cell whose disposition has actually changed.

`LCS-GAP-001` **CLOSED** (both halves).

### 6.3 ⚠ The scope limit on §6.2, stated so it cannot be over-read

Authorising A6/A7/A8 as **parts** confers **existence and allocation only**. It does **not** confer Stage 3,
does not resolve one gap inside them, and does not make their drafts correct. A6 still carries its unwritable
criteria; A8 still carries its conditional checks.

### 6.4 `LCG-ADR-001` and the part classification

PO-3 classifies the residue as **Part A4 of `PRD-021A`** and confirms it is not a standalone PRD.
`LCG-ADR-001` asked for *"An ADR classifying this part and assigning (or withholding) `BC-15` specification
authority"*. ✅ **Classified** as Part A4; **`BC-15` specification authority is assigned to `PRD-021A`**
collectively (A2 content, A4 groups/roles), consistent with `ADR-0078` and `ADR-0079` §12, both of which already
treat `BC-15` capabilities as `PRD-021A`'s subject matter. `LCG-ADR-001` **CLOSED**.

---

## 7. What this ADR does **not** do

1. ⛔ Does **not** confer Stage 3, enter Stage 4, register traceability, mint any `IMPL-*`, or freeze anything.
2. ⛔ Does **not** modify any **frozen** document. Measured: `DOCUMENTATION_BASELINE.md`, `MASTER_PRD.md`,
   `PRD_LIFECYCLE.md`, `TRACEABILITY_MATRIX.md` and the stale Stage-3 record are **byte-unchanged**.
3. ⛔ Does **not** reopen `ADR-0078`, `ADR-0079`, `ADR-0080`, `ADR-0081` or `ADR-0082`. `ADR-0036` is
   **appended to under PO-1's explicit instruction**, and its existing text is not rewritten.
4. ⛔ Does **not** create a bounded context. **31** before and after.
5. ⛔ Does **not** mint `E-27`, and does not reuse any withdrawn number.
6. ⛔ Does **not** add a `tenantId` anywhere, and does not weaken `ID-2`.
7. ⛔ Does **not** move anything from V2 to V1. `BC-15` and `BC-14` remain **V2**; `E-28`/`E-29` are V2-scoped.
8. ⛔ Does **not** make `BC-15` an event producer (§4.6).
9. ⛔ Does **not** claim `E-29` is `L2`-clear (§4.4).
10. ⛔ Does **not** claim `E-21` supports community search (§4.5, AO-9).
11. ⛔ Does **not** answer `LCG-DEC-005`'s name-uniqueness half (§3.2).
12. ⛔ Does **not** touch `lib/`, `packages/`, `test/` or `web/` — **0 lines of code**.

### 7.1 Three open items this ADR **creates or preserves**, named so they cannot be lost

| Item | Statement | Owner |
|---|---|---|
| **`GAP-BC14-RANK`** | ⭐ **NEW.** `BC-14` appears **0** times in both Rank 4 dependency documents; its module and rank are unmeasured, so `E-29`'s `L2` clearance is undetermined | **Architecture Owner** |
| **`LCG-ADR-002`** | **PRESERVED OPEN.** No `BC-15`-sourced event edge is authorised; A4 publishes no event | **Architecture Owner** |
| **`LCG-DEC-005b`** | ⭐ **NEW (split).** Whether group names are unique per community — the unanswered half of `LCG-DEC-005` | **Product Owner** |

Also preserved open: `LCG-GAP-006`/`LCG-ADR-003` (`communityId` unminted), `LCG-GAP-005`, `PGA-08`, `Q-A6`.

---

## 8. Consequential records

| Document | Change |
|---|---|
| `LIBOORA_BOUNDED_CONTEXT_MAP.md` | v1.8 → **v1.9**; new **§15** appended; header `ADRs applied` row extended; changelog row added. §1–§14 byte-unchanged |
| `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` | **L90**, **L652** edited in place; **0** lines added or removed |
| `tool/module_dependencies.yaml` | `contexts` extended with `community`; `E-28` declared |
| `ADR-0036` | §8.2 q2 outcome cell; new §8.2a conferral record; changelog |
| `PRD_REGISTRY.md` | §11.4 dispositions replaced; A6/A7/A8 authorised |
| `PRD_OWNERSHIP_MODEL.md` | §10 prefix register — six prefixes appended |
| `ADR-INDEX.md` | `ADR-0083` row |
| A1, A3, A4, A5, A6, A7, A8 | Ruling-specific updates; version bumps |
| `PRD-021A_STAGE3_ALIGNMENT_2026-08-31.md` | **NEW** fresh record. ⛔ The stale record is **byte-unchanged** |

---

## 9. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-31 | Initial. Executes 22 Owner rulings. **2** integration edges minted (`E-28`, `E-29` — **not** `E-27`, withdrawn and unreusable). **1** cluster extended. **6** prefixes registered. **3** parts authorised. Method chosen by measurement: append-only, because insertion into §7 was measured to invalidate **1,293** line-citations against the append's **0**. **3** residues disclosed rather than inferred (§4.4 `E-29`'s `L2` clearance, §4.6 `LCG-ADR-002`, §3.2 name uniqueness) and **3** items opened or preserved as a result. **0** frozen documents modified · **0** contexts added · **0** `tenantId` fields added · **0** lines of code. ⛔ **No lifecycle stage conferred.** |

---

*End of `ADR-0083`. Executing a ruling exactly is not the same as reporting that everything closed —
three items did not, and they are named.*
