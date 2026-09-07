# `E-27` versus the Core Library cluster allow-list — a Rank 4 conflict found during freeze-readiness checking

| Field | Value |
|---|---|
| **Raised by** | Freeze-readiness verification for `PRD-006` v1.9, **after** Stage 4 returned **A** |
| **Severity** | 🟠 **MEDIUM — documentation-level conflict between two Rank 4 documents.** No code check fails and no runtime behaviour is implicated. **It is not CRITICAL, and it is not nothing** |
| **Effect on freeze** | ✅ **RESOLVED — this finding no longer blocks the freeze, and it was resolved by *withdrawing* the edge, not by permitting it.** `PRD-006` v1.9 is **`FROZEN`** at Rank 3 under `BASELINE-2026-08-05-A`. *This row read ⛔ "`PRD-006` is NOT freeze-ready, and this finding is one of the reasons"*, which was true when written; see §7 |
| **Status** | ✅ **CLOSED 2026-08-05 by [`ADR-0033`](../../00-governance/adr/ADR-0033-e27-core-cluster-edge-allowlist.md), option `O-C` — `E-27` is WITHDRAWN.** *This row read 🔴 "OPEN — deferred with a reason and an owner (Architecture Owner). **Deliberately NOT fixed by me**"*, and that was the correct posture at the time: the owner named in that row is exactly the authority that later decided it. **§4 — "Why I did not fix it" — is preserved unaltered**, because the reasoning it records was sound and is the reason this ended in a ruling rather than in a quiet edit |
| **Date** | 2026-08-05 |

> **Why this document exists at all.** Stage 4 passed, and the instruction was to complete freeze readiness *only*
> if it did. Freeze readiness is not the same question as Stage 4, so I checked the other stages instead of assuming
> the pass carried them — and **Stage 3's territory is where this turned up**. Reporting a clean freeze-readiness
> result without having looked would have been the failure mode this whole engagement is trying to avoid.

---

## 1. The conflict, stated exactly

`ADR-0032` (`Accepted`) added **one** new edge to the Bounded Context Map:

> `| E-27 | BC-03 Attendance | BC-04 Seating | C/S + PL | Read projection | … |`

`LIBOORA_MODULE_DEPENDENCY_MATRIX.md` **v1.3 (Rank 4)** L89 constrains the same pair of contexts:

| Cluster | Members | Allowed internal edges |
|---|---|---|
| **Core Library cluster** (within R8) | BC-01 Enrollment, BC-02 Membership, **BC-03 Attendance**, **BC-04 Seating**, BC-05 Fee, BC-06 Policy | **Only the edges `E-01`…`E-10`** listed in the context map. **Enforced as an explicit allow-list, not *"anything within the cluster"*.** |

And the machine-readable manifest repeats it, L202:

```yaml
internal_edges_allowed: [ E-01, E-02, E-03, E-04, E-05, E-06, E-07, E-08, E-09, E-10 ]
```

**`BC-03` and `BC-04` are both Core Library cluster members, so `E-27` is an intra-cluster edge — and `E-27` is not
in `E-01`…`E-10`.** The allow-list explicitly forecloses the reading that would rescue it: *"not 'anything within
the cluster'"*.

---

## 2. This was measured, not inferred — and one measurement makes it distinctive

**`E-27` is the ONLY edge above `E-10` whose two endpoints are both inside the Core Library cluster.** Every other
high-numbered edge leaves the cluster for a platform or capability context:

| Edge | From | To | Intra-cluster? |
|---|---|---|---|
| `E-11` | `BC-18` Identity | `BC-01` Enrollment | No — crosses in from Identity |
| `E-17`…`E-20`, `E-23` | All contexts / write paths | `BC-21`, `BC-19`, `BC-25`, `BC-24`, `BC-22` | No — platform capabilities |
| `E-24` | **`BC-03` Attendance** | `BC-30` Offline Sync | No — `BC-30` is outside the cluster |
| `E-26` | `BC-27` AI | `BC-26`, `BC-23` | No |
| **`E-27`** | **`BC-03` Attendance** | **`BC-04` Seating** | **YES — both are cluster members** |

**So there is no precedent to lean on.** `E-24` looked like the closest candidate precisely because it starts at
`BC-03`, but its target sits outside the cluster, so it never engaged the allow-list. **I checked the one edge that
would have made this easy, and it does not help.**

---

## 3. What the conflict is NOT — measured, so the severity is not inflated either

| Claim | Verdict | Evidence |
|---|---|---|
| A code-boundary check now fails | ❌ **No** | `dart run tool/check_module_boundaries.dart` → **FAIL, 9 violations in 1 category** — the **same** nine `ADR-0012` time-boxed `app → domain/library` findings that were failing before this work, red **by design**. **Not one is about `E-27`** |
| The manifest's edge list is mechanically enforced per-edge | ❌ **No** | `check_module_boundaries.dart` L420–435 reads `internal_edges` only to collect the **context names** into `_clusterContexts`. `grep -c clusterContexts` = **2** — one declaration, one write, **and no read that raises a violation**. The edge **IDs** are never enforced |
| `E-27` introduces a new cluster member | ❌ **No** | `attendance` and `seating` are already in the set via `E-03` and `E-02`, so the collected set is **unchanged** |
| Rank direction is violated | ❌ **No** | `BC-03` and `BC-04` are the **same rank** (R8); this is the declared same-rank cluster exception, not an upward import |
| `E-08` was touched | ❌ **No** | Byte-identical |

**Conclusion: the specification contradicts itself; the code does not violate anything.** Two Rank 4 documents
disagree, and *that* is the defect.

---

## 4. Why I did not fix it

Adding `E-27` to the allow-list would be a **one-line** change in two places. **I am not making it**, for reasons
that are governance, not timidity:

1. **It is a Rank 4 amendment, and baseline §7 requires an ADR *before* the change.** `ADR-0032` **does not name the Dependency Matrix in its `Amends` row** — it names the BC Map, `PRD-007` and the Traceability Matrix. **An ADR cannot retroactively authorise a document it never mentioned**, and quietly widening the list under an ADR that is silent about it is exactly the *"silent modification"* the freeze rules forbid.
2. **`ADR-0032`'s authority was conferred for a specific act.** The conferral covered the presence read path. Treating it as a general licence to amend any Rank 4 document I later find inconvenient would be **precisely the over-reach the conferral did not grant**.
3. **The right fix may not be the obvious one.** The allow-list's wording — *"Enforced as an explicit allow-list"* — suggests the numbering `E-01`…`E-10` was meant to be a **contiguous reserved band** for intra-cluster edges. If so, the correct remedy might be to renumber the new edge **into** that band rather than to append `E-27` to the list. **That is an architecture judgement with a real trade-off** (renumbering touches a published edge identifier), and it belongs to the Architecture Owner, not to me.

> **The cheapest available move was to say nothing.** The allow-list is not mechanically enforced, gate 3's failures
> are pre-existing and attributable elsewhere, and no gate I was asked to run turns red because of this. **A
> freeze-readiness report that stayed silent would have passed every check in this repository and still been
> dishonest.**

---

## 5. Disposition — deferred with a reason and an owner

| Field | Value |
|---|---|
| **Conflict** | `E-27` is an intra-Core-Library-cluster edge outside the Rank 4 allow-list `E-01`…`E-10` |
| **Reason for deferral** *(as recorded on 2026-08-05, preserved)* | Resolving it requires a **Rank 4 amendment to `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` (v1.3) and `tool/module_dependencies.yaml`**, which needs an **ADR naming that document first**. `ADR-0032` does not name it. The remedy also has **two defensible shapes** (extend the list, or renumber into the reserved band) and choosing between them is an owner's call |
| **Owner** | **Architecture Owner** |
| **Blocks** | **Nothing at runtime and no gate.** It blocks **clean freeze readiness** for `PRD-006`, because a freeze row should not be conferred while two Rank 4 documents contradict each other about an edge the PRD depends on |
| **Suggested route** | A new ADR — *"the Core Library cluster's internal edge allow-list admits the presence read projection"* — amending the Matrix header, L89, L202 and the manifest, in baseline §7 order |

**This satisfies the Stage 4 gate's own standard** — *"conflicts closed **or explicitly deferred with a reason and

---

## 7. Resolution — `ADR-0033`, option `O-C`: the edge was withdrawn, not admitted

| Field | Value |
|---|---|
| **Resolved** | **2026-08-05**, by [`ADR-0033`](../../00-governance/adr/ADR-0033-e27-core-cluster-edge-allowlist.md), **`Accepted`** under **Architecture Owner** authority **conferred directly by the human principal** — recorded as a conferral, **not** as an ARB meeting, with no quorum, attendee list or Security review asserted |
| **Option selected** | **`O-C` — withdraw `E-27`.** `LIBOORA_BOUNDED_CONTEXT_MAP.md` → **v1.7**, removing the `E-27` row and its explanatory note. The edge set is once more `E-01`…`E-26` |
| **Option rejected** | **`O-A` — add `E-27` to the allow-list.** Rejected **in writing** in `ADR-0033` §5, because its only effect would have been to make a documentation contradiction disappear. That is the precise failure mode §4 of this document warned about |
| **The Dependency Matrix was NOT amended** | `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` stands **byte-unchanged** at `sha256… 9895d244494372af`. **This is the decisive point, and it inverts §5's own "Suggested route":** §5 assumed the fix required a Rank 4 amendment to the Matrix, L89, L202 and the manifest. It did not. **Withdrawing the edge restored compliance with the law that already existed**, so no Rank 4 law needed changing at all — the cheapest correct fix was the one that touched the *newer* document, not the older one |
| **Why the edge was never needed** | Frozen **Rank 3** `SEAT-FR-104` already requires the Seat Card to compose holder data **at read time from `BC-01`** — and **no `BC-01` → `BC-04` edge has ever existed** in the BC Map. Read-time composition across a context boundary is therefore an **already-ratified pattern that needs no numbered edge**, corroborated by `PRD-007` §3's three further no-edge consumptions. `E-27` documented a transport that governance had already blessed without one |
| **Mechanically verified** | BC Map edge rows measured at **26**, *identical to the pre-`ADR-0032` count*; the neighbouring `E-08` row **byte-identical** (`md5 34dc906540c90ed447003348e52f5f39`) to prove the deletion did not disturb its surroundings |
| **`ADR-0032` was NOT demoted** | Its status is unchanged at **`Accepted`** and was never altered at any point. Its substantive decision `O-5` — presence reaches the Seat Card as a **read-time projection** — **stands**; only its *transport* was withdrawn, and its ⚠ CHALLENGED notices became ✅ RESOLVED |
| **What is still open** | **`ATT-GAP-002a` and `SEAT-GAP-009` remain OPEN**, both with the Architecture Owner. §5's rows above correctly noted that each runs in the **opposite direction** to `E-27`, so **withdrawing `E-27` neither closes nor worsens them.** A freeze supplies documents; it answers no questions |

> **§1–§6 above are preserved exactly as written on 2026-08-05, including the "Suggested route" that this resolution did not take.**
> That is deliberate. The record is more useful showing a correct diagnosis paired with an *incorrect* proposed remedy than it would be
> silently rewritten to look prescient — and the gap between them is the finding worth keeping: **§4 was right that the conflict must
> not be fixed by whoever noticed it, and §5 was wrong about what the fix would cost.** Asking the owner is what surfaced the cheaper,
> more conservative option that a self-authorised fix would never have found.
an owner**"* — which is why Stage 4's **A** stands. **Stage 4 was never the gate this finding threatens; Stage 7 is.**

---

## 6. Change log

| Version | Date | Change |
|---|---|---|
| **v1.1** | 2026-08-05 | **RESOLVED by `ADR-0033`, option `O-C` — `E-27` WITHDRAWN.** Header *Status* and *Effect on freeze* rows updated, both quoting what they previously said; **§7 added** with the full resolution. **§1–§6 are unaltered**, including §4 *"Why I did not fix it"* and §5's *"Suggested route"*, which proposed amending the Dependency Matrix — **a route the resolution did not take, because the Matrix needed no amendment at all.** Preserved rather than corrected, because a diagnosis that was right paired with a remedy that was wrong is the most informative part of this record. |
| **v1.0** | 2026-08-05 | Created during freeze-readiness verification for `PRD-006` v1.9. Records that **`E-27`, added by `Accepted` `ADR-0032`, sits outside the Rank 4 Core Library cluster allow-list `E-01`…`E-10`** — and that **`E-27` is the only edge above `E-10` with both endpoints inside that cluster**, so no precedent covers it. Severity assessed **MEDIUM and no higher**: measured that the edge IDs are **not** mechanically enforced (`check_module_boundaries.dart` collects context names only), that the collected set is **unchanged**, and that gate 3's **9** failures are the pre-existing `ADR-0012` ones. **Deliberately left unfixed**, because `ADR-0032` does not name the Dependency Matrix in its `Amends` row and a Rank 4 change requires an ADR **before** it. Deferred to the **Architecture Owner** with a reason, which is what the Stage 4 gate requires — so **Stage 4's A stands** while **freeze readiness does not**. |
