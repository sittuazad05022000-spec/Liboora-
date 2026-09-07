# `PRD-006` Attendance Management v1.9 — Stage 3 Architecture Alignment **RE-RUN** (Supplement)

| Field | Value |
|---|---|
| **Stage** | **Stage 3 — Architecture Review, RE-RUN** ([`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) §3, lines **89–107**) |
| **Subject** | [`PRD-006_ATTENDANCE-MANAGEMENT.md`](PRD-006_ATTENDANCE-MANAGEMENT.md) — `PRD-006`, `BC-03` Attendance, **v1.9 `DRAFT`** |
| **Supplements** | [`PRD-006_ARCHITECTURE_ALIGNMENT.md`](PRD-006_ARCHITECTURE_ALIGNMENT.md) — the **v1.2** record, reviewed at `17e7205` |
| **Why a supplement and not a rewrite** | The v1.2 record is an **unranked, dated validation artefact** that states its own subject version, its own commit and its own PRD hash. Overwriting it would destroy the evidence that the earlier review was correct **for what it examined**, and would leave a later reader unable to see that a check was re-opened. **A stale review is corrected by a dated re-run beside it, not by editing what it concluded.** This is the same reasoning `ADR-0013` §7.1 records for its own incomplete framing |
| **Gate satisfied by** | This document, jointly with the v1.2 record — *"a written alignment record naming every conflict and its disposition"* (`PRD_LIFECYCLE.md` L103) |
| **Reviewed at** | `24b3e5c` |
| **Date** | 2026-08-05 |
| **Status** | **Unranked.** A review record is a validation artefact, not a specification. It claims no authority and confers no status |
| **Mandate** | **Stage 3 only.** No PRD requirement modified, no ADR accepted, no ranked document amended, no registry or baseline update, **no freeze** |
| **Verdict (v1.1, after the dependency decision)** | ✅ **ALIGNED — 6 of 6 lifecycle checks PASS.** The Check 2 failure recorded in v1.0 below is **CLOSED**: `E-27` was **withdrawn** from the BC Map by `ADR-0033` (`Accepted`, option `O-C`, BC Map **v1.7**), so no intra-cluster edge outside `E-01`…`E-10` remains. **The allow-list was not widened and the Dependency Matrix was not amended** — the conflict was removed at its cause. See **§0** |
| **Verdict (v1.0, superseded — retained as the record of what was found)** | ⛔ **NOT ALIGNED — 1 of 6 lifecycle checks FAILED.** Check 2 (*"Every integration edge exists in §7"*) **PASSES on existence and FAILS on authorisation**: `E-27` exists in BC Map §7 but is **outside the allow-list imposed by Rank 4 `LIBOORA_MODULE_DEPENDENCY_MATRIX.md`**. The other five checks are re-verified **PASS**. **This is a governance blocker, not a specification defect in `PRD-006`** |

---

## 0. RESOLUTION — added in v1.1, after the Architecture Owner ruled

**The blocker this document was written to report has been resolved, by the mechanism this document
recommended.** The v1.0 analysis below is **unchanged**: it is what a reader needs in order to judge whether the
resolution was sound, and deleting it would leave only the conclusion.

| | |
|---|---|
| **Ruling** | [`ADR-0033`](../../00-governance/adr/ADR-0033-e27-core-cluster-edge-allowlist.md) — **`Accepted`**, option **`O-C`** |
| **Authority** | **Architecture Owner**, by direct conferral of the human principal — recorded in `ADR-0033` §7.2 **as a conferral, not as an ARB meeting** |
| **Executed** | `LIBOORA_BOUNDED_CONTEXT_MAP.md` **v1.6 → v1.7**: the `E-27` row and its explanatory note are **removed**; the edge set returns to **`E-01`…`E-26`** |
| **NOT done** | `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` **unamended** (`9895d244494372af`) · allow-list **not widened** · `ADR-0032` **not demoted** (still `Accepted`) · no requirement, rule, event, invariant, criterion or configurable changed · no gate modified · no Dart source touched |

### 0.1 Check 2, re-run against BC Map v1.7

| Test | v1.0 (BC Map v1.6) | v1.1 (BC Map v1.7) |
|---|---|---|
| Every edge the PRD cites exists in §7 | ✅ PASS | ✅ **PASS** — `PRD-006` cites `E-27` only in **prose narrating `ADR-0032`**, declares **no port** on it, and its nine actual port edges are unaffected |
| Every Core Library intra-cluster edge is inside `E-01`…`E-10` | ⛔ **FAIL** — `E-27` was outside it | ✅ **PASS** — **`E-27` no longer exists.** Edge rows number **26**, identical to baseline `01684e5` |
| `E-08` unchanged | ✅ | ✅ **byte-identical to baseline** (md5 `34dc906540c90ed447003348e52f5f39`) |

### 0.2 What did **not** change, and why that is the point

`ADR-0032`'s substantive decision `O-5` **stands in full** — read-time composition, the **four** Seat Card states,
nothing stored in `BC-04`, no raw Wi-Fi or device state read by the card, **no fifth `attendance.*` event**. Only
the decision to express the read as a *numbered map edge* was reversed, because frozen Rank 3 **`SEAT-FR-104`**
already composes Seat Card data **from `BC-01` at read time** with **no `BC-01` → `BC-04` edge in existence**.

**The presence feature was never carried by `E-27`.** Withdrawing the edge removed a documentation defect and
took no capability with it — which is precisely why `O-C` was preferable to widening a Rank 4 law.

### 0.3 Stage 3 verdict

✅ **ALIGNED — 6 of 6 lifecycle checks PASS.** Check 12 (`BC-26`/`BC-13` event consumers with no edge) remains
**GAP-BEARING and correctly undisposed** — it is the systemic defect that two frozen PRDs also declined, and it
is not a `PRD-006` defect. **Stage 3 no longer blocks freeze.**

---

## 1. Why this re-run was necessary

The v1.2 record's §5.1 states, in its own words:

> *"The PRD cites the edge tokens `E-01`, `E-03`, `E-04`, `E-08`, `E-10`, `E-11`, `E-14`, `E-17`…`E-24`. The BC Map
> defines `E-01`…`E-26`. **Every token the PRD cites is defined. Zero invented edges.**"*

Both halves are now **false as a description of v1.9**, and neither was false when written:

| | v1.2, at `17e7205` | v1.9, at `24b3e5c` |
|---|---|---|
| Edge tokens the PRD cites | `E-01`, `E-03`, `E-04`, `E-08`, `E-10`, `E-11`, `E-14`, `E-17`…`E-24` | the same **plus `E-27`** (6 occurrences) |
| Edges the BC Map defines | `E-01`…`E-26` | `E-01`…`E-26` **and `E-27`** (BC Map **v1.6**) |
| Edges consumed by `BC-03`'s ports | 9 claimed, 9 verified | 9 claimed, 9 verified — **`E-27` is consumed by `BC-04`, not by `BC-03`** |

**Mechanical confirmation** — `grep -c "E-27"` against the v1.2 alignment record returns **0**. The document that
owns the *"every integration edge exists in §7"* check has never seen the edge in question. That is the definition
of a stale gate record. Stage 3 owns this question, so Stage 4's `A` verdict neither covers it nor can cover it.

---

## 2. Check 2 re-run — the finding

### 2.1 `E-27` exists. That was never the whole test.

BC Map **L291** is the rule the v1.2 record applied:

> *"Every edge that crosses a context boundary in V1. If an edge is not in this table, it **does not exist** and
> adding it requires an ADR."*

`E-27` satisfies it exactly. It is in BC Map §7.1 at **L308**, it was added by an ADR (`ADR-0032`, `Accepted`), and
that ADR was written **before** the change per `DOCUMENTATION_BASELINE.md` §7. **On the BC Map's own test, `E-27`
is lawful.** Nothing in this supplement disputes that.

### 2.2 A second Rank 4 document imposes a test the BC Map does not

`LIBOORA_MODULE_DEPENDENCY_MATRIX.md` v1.3 (Rank 4, protected) **L89**:

> | **Core Library cluster** (within R8) | BC-01 Enrollment, BC-02 Membership, **BC-03 Attendance**, **BC-04 Seating**, BC-05 Fee, BC-06 Policy | **Only the edges E-01…E-10** listed in the context map. **Enforced as an explicit allow-list, not "anything within the cluster".** |

and **L202**, machine-readably, in the same document:

```yaml
  internal_edges_allowed: [ E-01, E-02, E-03, E-04, E-05, E-06, E-07, E-08, E-09, E-10 ]
```

`E-27` runs **`BC-03` → `BC-04`**. Both endpoints are named members of that cluster. The allow-list stops at
`E-10`. **`E-27` is therefore an intra-cluster Core Library edge that the Rank 4 dependency law does not permit.**

The prose forecloses the convenient reading in advance: it is *"not 'anything within the cluster'"*. The list
whitelists **edge identifiers**, not pairs of contexts that may talk.

### 2.3 Severity, measured rather than asserted

| Question | Answer | Method |
|---|---|---|
| Is `E-27` the only edge above `E-10` inside the cluster? | **Yes — the only one** | Enumerated every `E-11`…`E-27` row's endpoints. `E-24` is `BC-03` → `BC-30` (outside the cluster); `E-11`, `E-17`…`E-26` all leave it |
| Does any gate catch it? | **No** | `tool/check_module_boundaries.dart` reads `internal_edges` only to collect context *names* (L420 → L435); the identifier list is **never compared against an edge**. `grep -c clusterContexts` = 2 — one declaration, one write, **zero reads for a violation** |
| Did the BC Map amendment disturb `E-08`? | **No** | `E-08` is byte-identical to baseline `01684e5` (md5 `34dc906540c90ed447003348e52f5f39`) |
| Does any Dart source depend on `E-27`? | **No** | `git diff --name-only 01684e5 HEAD -- lib test pubspec.yaml android web` = **0 files** |
| Is `PRD-006` itself wrong? | **No** | `PRD-006` cites `E-27` in prose only (6 occurrences, all narrating `ADR-0032`); it declares **no port** on it. `E-27`'s consumer is `BC-04` |

⇒ **🟠 MEDIUM: a documentation-integrity conflict between two Rank 4 documents, with no code, no gate and no
requirement depending on it.** It is not CRITICAL. It is also not ignorable, because Rank 4 is precisely the layer
a PRD is checked *against*.

---

## 3. The disposition — and why it is not "add `E-27` to the allow-list"

`ADR-0033` (**`Proposed`**) records the full analysis. Its recommendation is **withdraw `E-27`**, and the reason is
evidential rather than aesthetic:

**Frozen Rank 3 `PRD-SEAT-MANAGEMENT.md` v1.1, `SEAT-FR-104` (L872–874):**

> *"The holder's name, membership status and membership expiry on the card **MUST** be **composed at read time**
> from **`BC-01`** and the `E-02` projection."*

**But there is no `BC-01` → `BC-04` edge, and there never was.** The complete set of BC Map edges terminating at
`BC-04` is `E-02`, `E-05`, `E-08`, `E-27`. `E-02` originates at `BC-02` Membership — not `BC-01`.

So a **frozen** Rank 3 requirement already performs a cross-context read-time composition **with no `E-` edge
carrying it**, and it was frozen through the full lifecycle in that state. Three further instances sit in
`PRD-007` §3: `BC-10` (*"**No edge exists.** `E-13` is the only bridge and it belongs to `BC-01`"*), `BC-05`
(*"**None.** No edge exists"*), `BC-18` (*"**Consumes** the existing RBAC + scope model"*).

`PRD-006`'s own second gap row was closed on precisely this reasoning:

> *"A Core context consuming an already-established session without its own inbound identity edge is a **frozen,
> ratified pattern**, not an unauthorised assumption."*

⇒ **`E-27` was never architecturally required.** `ADR-0032`'s substantive decision — `O-5`, read-time composition,
the four-state card, nothing stored, no fifth event — was lawful without any new edge. `E-27` documented a
transport that governance had already blessed without one.

### 3.1 Options considered and rejected

| Option | Disposition | Reason |
|---|---|---|
| **O-A** — add `E-27` to `internal_edges_allowed` | ❌ **Rejected** | It would amend a **protected Rank 4** document whose authority no existing ADR carries, and its only effect would be to remove a documentation contradiction — which is exactly *"adding it to make the conflict go away"* |
| **O-B** — renumber `E-27` into the `E-01`…`E-10` band | ❌ **Rejected** | The band is **full** — `E-01` through `E-10` are all occupied. Renumbering would collide with a published edge and rewrite frozen citations across several documents |
| **O-C** — **withdraw `E-27`**, rely on the ratified no-edge read pattern | ✅ **RECOMMENDED** | Removes the conflict at its cause, preserves every substantive `ADR-0032` decision, changes no requirement, and widens no Rank 4 law |

### 3.2 What this supplement deliberately did **not** do

- ❌ **Did not amend `LIBOORA_MODULE_DEPENDENCY_MATRIX.md`.** `ADR-0032`'s `Amends` row names only BC Map §7.1, `PRD-SEAT-MANAGEMENT.md` `SEAT-FR-103` and `TRACEABILITY_MATRIX.md` §2F. `DOCUMENTATION_BASELINE.md` §7 requires *"an ADR **before** the change"*, so amending the Matrix under `ADR-0032` would be a **silent Rank 4 modification wearing an unrelated authority**. Hash `9895d244494372af` unchanged.
- ❌ **Did not remove `E-27` from the BC Map.** Removal is `ADR-0033`'s recommendation, and `ADR-0033` is `Proposed`. Executing a `Proposed` ADR is indistinguishable from acting with no ADR at all.
- ❌ **Did not demote `ADR-0032` from `Accepted`.** It was accepted under a genuine conferral; un-accepting it unilaterally is the same unauthorised status change in the opposite direction. §5.1 and §6.2 now carry **⚠ CHALLENGED** notices instead.
- ❌ **Did not modify `tool/check_module_boundaries.dart`** to detect this. `git diff --stat tool/` is empty. Adding the check would be a code change, and the finding stands on the documents regardless.
- ❌ **Did not touch any requirement, rule, event, invariant, criterion or configurable in `PRD-006`.**

---

## 4. The other five lifecycle checks — re-verified for v1.9

| Lifecycle check (`PRD_LIFECYCLE.md` L92–99) | Authority | v1.2 result | v1.9 re-run |
|---|---|---|---|
| Context ownership is exclusive | BC Map §3 | ✅ PASS | ✅ **PASS** — `BC-03` remains sole owner of `AttendanceDay`; `ADR-0032` explicitly leaves Attendance *"the sole owner"* of presence and stores nothing in `BC-04` |
| **Every integration edge exists in §7** | BC Map §7 | ✅ PASS | ⛔ **FAIL on authorisation** — see §2. `E-27` exists in §7 but is outside the Rank 4 intra-cluster allow-list |
| Rank direction is downward | Matrix `L2` | ✅ PASS | ✅ **PASS** — `E-27` is `BC-03` → `BC-04`, both R8; it is a *lateral* edge, not an upward one. The defect is allow-list membership, **not** direction |
| No authorisation outside `BC-18` | `X-13` | ✅ PASS | ✅ **PASS** — v1.9 added no role, scope or permission framework; its new acceptance criteria are timing and state assertions |
| No credential, OTP or session outside `BC-18` | `ID-1` | ✅ PASS | ✅ **PASS** — every mention remains a prohibition |
| Tenant scoping correct | `MP-GBR-08`, `X-13` | ✅ PASS | ✅ **PASS** — the `E-27` payload carries `tenant` explicitly (BC Map L308) |

**Also re-confirmed unchanged by v1.9:** exactly **four** attendance events, no fifth event, no overload of the
existing check-out event, the **four** Seat Card states, presence never stored in `BC-04`, and the Seat Card never
reading raw Wi-Fi or device state.

**Check 12 (the `BC-26`/`BC-13` consumers with no edge) remains GAP-BEARING and correctly undisposed** — it is the
systemic `SM-GAP-11`/`MM-GAP-010` defect that two frozen PRDs also declined to resolve.

---

## 5. Verdict

### ⛔ NOT ALIGNED — Stage 3 gate **satisfied**, Stage 3 **outcome** not clean

The distinction matters, because `PRD_LIFECYCLE.md` treats them as separate things:

| | |
|---|---|
| **Stage 3 gate** (L103) — *"a written alignment record naming every conflict and its disposition"* | ✅ **Satisfied.** This document names the conflict and states its disposition. The gate asks for disclosure, not for the absence of conflict |
| **Stage 3 outcome** | ⛔ **NOT ALIGNED.** One of six lifecycle checks fails against a Rank 4 authority. A record can satisfy the gate and still report a failing check — that is what a review is for |
| **Whose decision the disposition is** | **Architecture Owner.** `ADR-0033` is `Proposed` and binds nothing |
| **Freeze impact** | ⛔ **BLOCKS FREEZE.** Stage 7 cannot confer a baseline on a document whose architecture alignment reports an unresolved Rank 4 conflict while the resolving ADR is not `Accepted` |
| **Stage 4 impact** | **None.** Stage 4's six checks are internal-consistency checks on the PRD's own registers; none of them asks *"is every edge inside the dependency allow-list"*. `PRD-006_STAGE4_REREVIEW_V19.md`'s verdict **A** stands, and its §4 deferral table already lists this conflict as row 4 |
| **`PRD-006` lifecycle status** | **`DRAFT`. NOT frozen. NOT ranked. NOT admitted to any baseline** |

**What the evidence actually supports.** The cheapest available action was to leave the v1.2 record alone — it says
`PASS`, it is dated, it names its own commit, and nobody re-reads a superseded review. It would have passed every
mechanical gate in this repository, because **no gate can see this defect**: the checker reads the allow-list and
throws the edge identifiers away. The conflict is recorded here because a review that reports only what the tooling
could already have caught is not a review.

**And the correction that matters is not that `E-27` is unlawful — it is that `E-27` was never needed.** A frozen
Rank 3 requirement composes Seat Card data from `BC-01` across a boundary with no edge at all. Once that is on the
table, widening a Rank 4 allow-list to legalise `E-27` stops looking like a fix and starts looking like paying for
something the architecture had already granted for free.

### Next action

~~**Architecture Owner** rules on `ADR-0033`. Until then `PRD-006` stays `DRAFT`, `E-27` is **not** settled architecture, and no implementer may build on it.~~

✅ **DONE — see §0.** The Architecture Owner accepted `ADR-0033` option `O-C`; `E-27` is **withdrawn** and no longer exists in the map, so there is nothing left for an implementer to build on or to avoid. **Stage 3 is ALIGNED and no longer blocks freeze.**

---

## 6. Change history

| Version | Date | Change |
|---|---|---|
| **v1.1** | 2026-08-05 | **Check 2 CLOSED; verdict ✅ ALIGNED (6 of 6).** Re-run after the **Architecture Owner** accepted [`ADR-0033`](../../00-governance/adr/ADR-0033-e27-core-cluster-edge-allowlist.md) option **`O-C`** and `E-27` was **withdrawn** from `LIBOORA_BOUNDED_CONTEXT_MAP.md` (**v1.7**). Verified mechanically: edge rows **26**, matching baseline `01684e5`; **no intra-cluster Core Library edge above `E-10` remains**; `E-08` **byte-identical** (md5 `34dc906540c90ed447003348e52f5f39`). **`LIBOORA_MODULE_DEPENDENCY_MATRIX.md` was NOT amended** (`9895d244494372af`) — the conflict was removed at its cause instead of legalised, which is why no Rank 4 law needed widening. `ADR-0032` **remains `Accepted`**; its §5.1/§6.2 notices move from ⚠ *challenged* to ✅ *resolved*, and `O-5` is unchanged. **The v1.0 analysis and its ⛔ NOT ALIGNED verdict are retained verbatim below**, because a reader cannot judge whether a resolution was sound if the finding it resolved has been deleted. No requirement, rule, event, invariant, criterion or configurable was touched; no gate was modified; **no Dart source was changed**. |
| **v1.0** | 2026-08-05 | Created as a **supplement** to the v1.2 alignment record, re-running Stage 3 against `PRD-006` **v1.9** at `24b3e5c`. Re-verifies five of six lifecycle checks as **PASS** and **re-opens Check 2**: `E-27` (`BC-03` → `BC-04`, added by `ADR-0032`) satisfies BC Map L291 but sits **outside the `E-01`…`E-10` intra-cluster allow-list** that Rank 4 `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` L89/L202 declares *"Enforced as an explicit allow-list"*. Severity measured 🟠 **MEDIUM** — `E-27` is the **only** edge above `E-10` with both endpoints in the cluster, **no gate detects it**, **no Dart source depends on it**, and **`PRD-006` declares no port on it**. Records that `ADR-0033` recommends **withdrawing** `E-27`, because frozen Rank 3 `SEAT-FR-104` already composes Seat Card data **from `BC-01`** while **no `BC-01` → `BC-04` edge exists anywhere in the map** — so no edge was ever required. **The v1.2 record was not rewritten**, the Dependency Matrix was **not** amended, `E-27` was **not** removed, `ADR-0032` was **not** demoted, and **no gate or Dart source was modified**. Verdict ⛔ **NOT ALIGNED** — gate satisfied by disclosure, outcome blocked pending the **Architecture Owner**. |
