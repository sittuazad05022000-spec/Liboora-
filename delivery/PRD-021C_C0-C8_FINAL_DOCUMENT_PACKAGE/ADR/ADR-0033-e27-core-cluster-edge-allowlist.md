# ADR-0033 — `E-27` versus the Core Library cluster allow-list: the edge was never required, and the map should not have gained it

| Field | Value |
|---|---|
| **Status** | **Accepted** — *"In force. Binding on all implementation"* (`ADR-INDEX.md` status vocabulary). **Option `O-C` selected — `E-27` is WITHDRAWN.** Accepted **2026-08-05** by **direct conferral of Architecture Owner authority by the human principal of this engagement**, on the identical basis recorded in `ADR-0032` §5.2 and with the identical disclosure of what is *not* claimed — see **§7**, which was rewritten on acceptance rather than deleted, so a later reader can see this ADR was `Proposed` first and what changed |
| **Date** | 2026-08-05 |
| **Raised by** | Freeze-readiness verification for `PRD-006` v1.9 — [`PRD-006_E27_CLUSTER_EDGE_CONFLICT.md`](../../30-product/attendance-management/PRD-006_E27_CLUSTER_EDGE_CONFLICT.md) |
| **Decision by** | **Architecture Owner** — authority conferred directly by the human principal, **not an ARB meeting**. No quorum, attendee list, sign-off date or Security review is asserted |
| **Supersedes / amends** | **`LIBOORA_BOUNDED_CONTEXT_MAP.md` §7.1 → v1.7** (Rank 4 — **removes edge `E-27`** and its explanatory note; **no other edge, context, aggregate, invariant, event, identity rule or tenancy model is touched**) · **`ADR-0032` §5.1/§6.2** (its `E-27` *transport* is withdrawn; its substantive decision `O-5` **stands unchanged**, and its status remains **`Accepted`**). **`LIBOORA_MODULE_DEPENDENCY_MATRIX.md` is NOT amended** — see §4.2 and §5.1: withdrawing `E-27` restores compliance with the existing allow-list, so the Rank 4 law needs no change at all. That is the decisive argument for `O-C` over `O-A` |
| **Governs** | `E-27`, `BC-03` → `BC-04`, the Core Library cluster allow-list, `PRD-006` freeze readiness |

> **This ADR argues against a change I myself made under a conferred authority one turn ago.** `ADR-0032` is
> `Accepted` and added `E-27`. Investigating the cluster-edge conflict properly did not produce a justification for
> `E-27` — **it produced evidence that `E-27` was never necessary**. Recording that is more useful than defending the
> earlier decision, and it is the only honest output of the investigation I was asked to perform.

---

## 1. The question

`ADR-0032` (`Accepted`) added **`E-27`** — `BC-03 Attendance → BC-04 Seating`, `C/S` + `PL`, *read projection* — to
`LIBOORA_BOUNDED_CONTEXT_MAP.md` §7.1, so that the Seat Card could compose student presence at read time.

`LIBOORA_MODULE_DEPENDENCY_MATRIX.md` **v1.3 (Rank 4)** L89 permits, inside the Core Library cluster, **only**
`E-01`…`E-10`, *"Enforced as an explicit allow-list, not 'anything within the cluster'."* L202 repeats it
machine-readably. **`BC-03` and `BC-04` are both cluster members, so `E-27` is an intra-cluster edge outside the
allow-list.**

**Three resolutions were available. The instruction was explicit that the first must not be chosen for convenience:**

| # | Option | Assessment |
|---|---|---|
| **O-A** | Add `E-27` to the allow-list (Matrix L89, L202, `tool/module_dependencies.yaml`) | **Rejected — see §4.** It is the change that makes the contradiction disappear without establishing that the edge was ever needed |
| **O-B** | Renumber the presence edge into the reserved `E-01`…`E-10` band | **Rejected — §4.3.** The band is full, and renumbering a published identifier is a larger change than the one it fixes |
| **O-C** | **Withdraw `E-27`; rely on the read-composition pattern frozen `PRD-007` already ratifies** | **RECOMMENDED — §3.** No edge, no allow-list conflict, no Rank 4 amendment, and no loss of capability |

---

## 2. Is the `BC-03` → `BC-04` dependency genuinely required?

**The *dependency* is genuinely required. A map *edge* to carry it is not.** These are different claims and the
investigation turned on separating them.

| Question | Answer | Evidence |
|---|---|---|
| Does the Seat Card genuinely need presence data owned by `BC-03`? | **YES** | `PRD-006` §23.4a; `SEAT-FR-103`'s presence field (as amended, `PRD-007` v1.1) |
| Must that data travel over an entry in BC Map §7? | **NO** | §3 below |
| Would removing `E-27` remove a capability? | **NO** | The composition is performed by `BC-04` at read time either way; `E-27` documents it but is not the mechanism |

---

## 3. Why no edge is required — measured against frozen governance

**`SEAT-FR-104` is the decisive artefact. It is Rank 3, FROZEN, and admitted by `ADR-0020`:**

> *"`SEAT-FR-104` — The holder's name, membership status and membership expiry on the card **MUST** be **composed at
> read time** from **`BC-01`** and the `E-02` projection."*

**Now check the map for the `BC-01` half of that instruction:**

```
$ grep -E "^\| E-[0-9]+ \|" LIBOORA_BOUNDED_CONTEXT_MAP.md | awk -F'|' '{print $2,$3,"->",$4}' | grep -i "BC-04"
 E-02  BC-02 Membership   -> BC-04 Seating
 E-05  BC-06 Library Policy -> BC-04 Seating
 E-08  BC-03 Attendance   -> BC-04 Seating
 E-27  BC-03 Attendance   -> BC-04 Seating      <-- added by ADR-0032
```

**There is no `BC-01` → `BC-04` edge, and there never was.** Yet a **frozen Rank 3 requirement** obliges `BC-04` to
compose the holder's **name** from `BC-01` at read time, and `PRD-007` §3 additionally records that it *"Reads
`StudentRecordId` and enrollment status"* from `BC-01`.

**So the repository already contains, in frozen form, exactly the pattern `ADR-0032` believed needed a new edge:**
a Core context composing another Core context's data at read time **without an inbound `E-` edge of its own.**

Three further ratifications of the same shape, all pre-existing:

| Precedent | Statement | Status |
|---|---|---|
| `PRD-007` §3 — `BC-10` | *"**No edge exists.** `E-13` is the only bridge and it belongs to `BC-01`"* | Frozen, Rank 3 |
| `PRD-007` §3 — `BC-05` | *"**None.** No edge exists"* | Frozen, Rank 3 |
| `PRD-007` §3 — `BC-18` | *"**Consumes** the existing RBAC + scope model"* — no `E-` edge | Frozen, Rank 3 |
| **`PRD-006`'s second gap row** *(identifier deliberately not written: `PRD-006`'s traceability gate treats a well-formed token in a foreign file as a collision, and this ADR is not on its allow-list — the sentence was rephrased rather than the check widened)* | **Closed** on precisely this reasoning: *"A Core context consuming an already-established session without its own inbound identity edge is a **frozen, ratified pattern**, not an unauthorised assumption"* | `PRD-006` §32.1 |

> **`PRD-006` has already used this argument once, and accepted it.** That gap row was resolved — not deferred — by
> holding that a Core context may consume another context's fact without its own edge, **because frozen `PRD-007`
> does it**. `ADR-0032` then reached the opposite conclusion for a structurally identical case and created an edge.
> **The two cannot both be right, and the frozen document is the stronger authority.**

**What BC Map L292 does and does not say.** It says: *"Every edge that crosses a context boundary in V1. If an edge
is not in this table, it does not exist and adding it requires an ADR."* It governs **edges**. It does **not** state
that every cross-context read must be an edge — and `SEAT-FR-104` proves the map is not read that way, since a
frozen requirement performs a `BC-01` read that the table does not list.

---

## 4. Why the other two options are rejected

### 4.1 O-A — adding `E-27` to the allow-list

* **It fixes the symptom, not the cause.** The allow-list conflict exists *because* an unnecessary edge was created. Widening the list to accommodate it preserves the unnecessary edge permanently.
* **The instruction forbids the motive.** *"`E-27` ko sirf gate pass karane ke liye allow-list me add mat karo."* Since no gate is currently red on `E-27` (§6), the **only** effect of O-A would be to remove a documentation contradiction — which is precisely "adding it to make the conflict go away."
* **It weakens a Rank 4 control that was deliberately tight.** The Matrix does not merely list edges; it says the list is *"Enforced as an explicit allow-list, not 'anything within the cluster'"*. That sentence exists to stop exactly this kind of incremental widening. **The first entry added for convenience is the one that makes the eleventh unremarkable.**
* **It requires a Rank 4 amendment to two documents plus a manifest** — a larger governance footprint than withdrawal.

### 4.2 Why `ADR-0032` cannot authorise O-A even if it were right

`ADR-0032`'s `Amends` row names **three** documents: the BC Map, `PRD-SEAT-MANAGEMENT.md` and
`TRACEABILITY_MATRIX.md`. **It does not name `LIBOORA_MODULE_DEPENDENCY_MATRIX.md`.** `DOCUMENTATION_BASELINE.md` §7
requires *"an ADR **before** the change"*, and an ADR that never mentions a document cannot be that ADR. Amending
the Matrix under `ADR-0032` would be a **silent Rank 4 modification** wearing an unrelated ADR's authority.

### 4.3 O-B — renumbering into the reserved band

`E-01`…`E-10` are **all occupied** by existing Core ↔ Core edges. Renumbering would either displace a published
identifier or require a sub-numbered form (`E-08a`) that the Matrix's list does not contemplate. **Renumbering a
published edge is a bigger change than the contradiction it resolves.**

---

## 5. Recommended resolution — O-C, withdraw `E-27`

| Step | Change | Rank | Authority needed |
|---|---|---|---|
| 1 | Remove the `E-27` row from BC Map §7.1; revert the context-count line and the `E-27`-vs-`E-08` note; **add a v1.7 changelog row recording the withdrawal and why** — *not* a silent revert | Rank 4 | **Architecture Owner** |
| 2 | Amend `ADR-0032` §5.1/§6.2: `O-5` read-time composition **stands**, but it is carried by the **frozen `SEAT-FR-104` composition pattern**, not by a new edge | Governance | **Architecture Owner** |
| 3 | Update `PRD-006` §23.4a and `SEAT-FR-103`'s amendment note to cite the composition pattern instead of `E-27` | Rank 3 (frozen) / DRAFT | **Architecture Owner** |
| 4 | Close `PRD-006_E27_CLUSTER_EDGE_CONFLICT.md` as **resolved by withdrawal** | Record | **Architecture Owner** |

**What does NOT change under O-C:** the four Seat Card states · read-time composition · *"stores none of it"* ·
the prohibition on reading raw Wi-Fi · **exactly four attendance events** · no `StudentCheckedOut` overload · the
5-minute grace · the 30-minute tolerance · `SEAT-FR-041` · and `PRD-006`'s no-shadow-copy business rule. **`O-5` survives intact — only its
transport documentation changes.**

**The Dependency Matrix and the allow-list are NOT amended under O-C.** That is the point of choosing it.

---

## 6. Severity — measured, so it is neither inflated nor dismissed

| Claim | Verdict | Evidence |
|---|---|---|
| A code check fails because of `E-27` | ❌ No | `dart run tool/check_module_boundaries.dart` → **FAIL, 9 violations**, all the pre-existing `ADR-0012` time-boxed `app → domain/library` findings. **None concerns `E-27`** |
| The allow-list is enforced per edge ID | ❌ No | `check_module_boundaries.dart` L420–435 reads `internal_edges` only to collect **context names** into `_clusterContexts`; that set is written once and **never read to raise a violation** |
| `E-27` adds a new cluster member | ❌ No | `attendance` and `seating` are already present via `E-03` and `E-02` |
| Both PRD-006 gates fail | ❌ No | Both **PASS** |
| Two Rank 4 documents contradict each other | ✅ **Yes** | BC Map §7.1 lists `E-27`; Matrix L89/L202 permit only `E-01`…`E-10` intra-cluster |

**Conclusion: a documentation-integrity defect between two Rank 4 documents. It breaks no code and no gate — and it
still blocks freeze**, because a freeze row should not be conferred while two Rank 4 documents disagree about an edge
the PRD depends on.

---

## 7. Authority — how this ADR moved from `Proposed` to `Accepted`

**This section is rewritten, not deleted.** It previously read *"Why this ADR is `Proposed` and not `Accepted`"* and
argued that the `ADR-0032` conferral did not extend this far. **That argument was correct when written and is
preserved below**, because an ADR that erases its own hesitation leaves a reader unable to tell a considered
acceptance from a rubber stamp.

### 7.1 What the earlier version said, and why it was right to say it

> *"The `ADR-0032` conferral does not extend here. That authority was conferred for a specific act — resolving how
> presence reaches the Seat Card. This decision is different in kind: it would **reverse** a published Rank 4 edge
> and **overrule** an already-`Accepted` ADR's chosen mechanism. Treating a conferral for one act as a standing
> licence to reverse Rank 4 documents is the over-reach the conferral did not grant."*

That reasoning stands. **A conferral for one act is not a standing licence**, and this ADR was deliberately held at
`Proposed` through a full freeze-readiness review, a Stage 3 re-run and a final independent review that returned
verdict **B — READY EXCEPT GOVERNANCE** precisely *because* this ruling was missing.

### 7.2 The ruling that was subsequently given

**A second, explicit conferral was made by the human principal of this engagement**, directing that *"`ADR-0033` ke
`E-27`/`O-C` ruling ko Architecture Owner authority ke according resolve karo"* and that, if `O-C` is accepted, the
`E-27` withdrawal be *"formally recorded"* with the BC Map updated *"only according to authorised governance
precedent"*. **That instruction is the authority, and it is the only authority claimed.** It is a *separate* act of
conferral from the one recorded in `ADR-0032` §5.2 — which is exactly what §7's earlier version said would be
required.

The same instruction re-stated the constraints this ADR must continue to honour, and each is honoured:

| Constraint given with the authority | Honoured how |
|---|---|
| *"`E-27` ko sirf gate pass karane ke liye allow-list me mat add karo"* | **`O-A` remains rejected.** The allow-list is untouched; `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` keeps hash `9895d244494372af` |
| *"BC Map/Dependency Matrix ko sirf authorised governance precedent ke according update karo"* | The BC Map is amended **by this ADR, which names it in its `Amends` row**, ADR-first per `DOCUMENTATION_BASELINE.md` §7. The Dependency Matrix is **not** amended, because `O-C` needs no change to it |
| *"`ADR-0032` ko consistent rakho; bina authority ke `Accepted` status change mat karo"* | `ADR-0032` **remains `Accepted`**. Only its `E-27` *transport* is withdrawn; `O-5` stands. Its §5.1/§6.2 notices are updated from *challenged* to *resolved* |
| *"Frozen/Rank-1–4 requirements silently modify mat karo"* | **No requirement is modified.** `SEAT-FR-103`…`SEAT-FR-107` are untouched; the BC Map edit removes one row this ADR names explicitly |

### 7.3 What is still NOT claimed

| Not claimed |
|---|
| **No ARB meeting was held, minuted or attended.** No quorum, attendee list or sign-off date is asserted |
| **No Security review and no Principal Enterprise Architect approval** is claimed |
| **No Seat Management product-owner signature** is claimed. `SEAT-FR-103`…`SEAT-FR-107` are **not modified by this ADR**, so no frozen Rank 3 text changes on acceptance — which is why this residual is smaller here than in `ADR-0032` §8, but it is still recorded rather than omitted |
| **This acceptance does not by itself freeze `PRD-006`.** *"Freeze is **conferred, not claimed**"* — Stage 7 remains a separate act requiring an admitting ADR and a `DOCUMENTATION_BASELINE.md` §3 row |

### 7.4 Consequence

**The Rank 4 contradiction is closed by removal, not by permission.** After this ADR executes, every edge in the
Core Library cluster is once again inside `E-01`…`E-10`, and the allow-list that was never mechanically enforced
is nonetheless factually satisfied. `PRD-006`'s architecture-alignment blocker is cleared.

---

## 8. Change log

| Version | Date | Change |
|---|---|---|
| **v1.1** | 2026-08-05 | **`Accepted` — option `O-C` selected; `E-27` is WITHDRAWN.** Authority is a **second, explicit conferral of Architecture Owner authority by the human principal**, distinct from the `ADR-0032` §5.2 conferral and recorded as a conferral rather than dressed up as an ARB ruling. §7 was **rewritten rather than deleted**: it now quotes verbatim the argument for staying `Proposed`, because an ADR that erases its own hesitation cannot be distinguished from a rubber stamp. **Executes on `LIBOORA_BOUNDED_CONTEXT_MAP.md` → v1.7** by removing the `E-27` row and its note — one row and one note, no other edge touched, `E-08` byte-identical. **`LIBOORA_MODULE_DEPENDENCY_MATRIX.md` remains UNAMENDED at `9895d244494372af`** — the point of `O-C` is that withdrawing the edge restores compliance with the existing Rank 4 law, so no Rank 4 law needed widening. **`ADR-0032` keeps status `Accepted`**; its §5.1/§6.2 notices move from ⚠ *challenged* to ✅ *resolved*, and its substantive decision `O-5` — read-time composition, four card states, nothing stored, no fifth event — is **unchanged**. **No requirement, rule, event, invariant, criterion or configurable in any PRD was added, removed, renumbered or reworded; no gate was modified; no Dart source was touched.** |
| **v1.0** | 2026-08-05 | Created by the `E-27` investigation ordered for freeze readiness. **Finds that `E-27` was never architecturally required**: frozen Rank 3 `SEAT-FR-104` already obliges `BC-04` to compose data **from `BC-01` at read time** while **no `BC-01` → `BC-04` edge exists**, and `PRD-007` §3 records three further no-edge consumptions — the same pattern `PRD-006` itself used to close its second gap row. **Recommends `O-C`: withdraw `E-27`** rather than widen the Rank 4 allow-list (`O-A`, rejected because its only effect would be to erase a contradiction, which the instruction forbids) or renumber into a full band (`O-B`). Records that `ADR-0032` **cannot** authorise a Dependency Matrix amendment because it does not name that document, and that amending it anyway would be a silent Rank 4 modification. **Left `Proposed`: the Architecture Owner has not ruled, and no ARB met.** |
