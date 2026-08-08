# ADR-0016 — Edge `E-22` must list `BC-10`, an edge the Student Identity PRD already requires

| Field | Value |
|---|---|
| **Status** | **Accepted** — 2026-08-04 |
| **Date** | 2026-08-04 |
| **Deciders** | Architecture Review Board, acting through the Architecture Owner role defined in `PRD_OWNERSHIP_MODEL.md` §2.2 |
| **Supersedes** | — |
| **Amends** | `docs/10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md` (Rank 4) — §7.3, edge **`E-22`**, the *Consumer* cell only. **No edge added, no edge removed, no mode changed, no context reclassified.** Executed, see §7 |
| **Amended by** | — |
| **Baseline** | `BASELINE-2026-08-04-B` |
| **Related** | `PGA-02` · `ADR-0011` (introduced `BC-10` at rank 7.5) · `SID-4.35`, `SID-4.36`, `SID-3.19` · BC Map line 292 (the governing rule) · `E-21` (the same omission, already fixed) |

> ✅ **ACCEPTED 2026-08-04. The migration in §7 has been executed.**
>
> This is the one finding in the closure phase where a **frozen Rank 4 document is genuinely incomplete** rather
> than merely mis-citing. A Rank 3 PRD depends on an edge that the Rank 4 edge register does not list, and BC Map
> line 292 states that an unlisted edge **does not exist**. That is a live contradiction between ranks, not a
> cosmetic defect.

---

## 1. Context

### 1.1 The rule that makes this a defect

Bounded Context Map §7, line 292:

> *"Every edge that crosses a context boundary in V1. If an edge is not in this table, it **does not exist** and
> adding it requires an ADR."*

The rule cuts both ways. It is why this ADR exists (the edge cannot simply be typed in), and it is why the omission
matters (until amended, the map asserts the edge does not exist).

### 1.2 The two edges `ADR-0011` should have touched, and the one it missed

`ADR-0011` moved `BC-10` Global Person Identity out of the Social cluster to rank 7.5 and made it `[CORE]`. Two
platform edges needed `BC-10` added to their consumer lists. Verified against §7.3:

| Line | Edge | Consumers | `BC-10` present? |
|---|---|---|---|
| 330 | `E-21` → `BC-23` Search Indexing | `BC-01`, **`BC-10`** | ✅ **Yes** — extended |
| 331 | `E-22` → `BC-29` File & Media | `BC-01`, `BC-14` | ❌ **No** — **missed** |

`E-21` was extended and `E-22` was not. This is a single-edge oversight in one ADR's migration, not a modelling
disagreement — nothing anywhere argues that `BC-10` should *not* use `BC-29`.

### 1.3 The Rank 3 requirement that depends on the missing edge

`Student_Identity_PRD_v1.md` §4.8 is headed, verbatim:

> `### 4.8 File & Media — BC-29 (E-22)`

and states:

> `SID-4.35` — The Global Profile Photo **SHALL** be held as a `FileRef` issued by `BC-29`. This module
> **SHALL NOT** hold bytes, a raw storage path or a public URL. *(`SID-3.19`.)*
>
> `SID-4.36` — Upload, virus scanning, thumbnailing and signed-URL issuance **SHALL** be owned by `BC-29`.

`BC-10` therefore **must** call `BC-29`. The PRD names the edge by identifier, and the edge register omits the
caller. A conforming implementation of `SID-4.35` would be reported by a strict reading of the map as traversing a
non-existent edge.

### 1.4 Why the omission is invisible to the boundary checker

`tool/check_module_boundaries.dart` enforces **module ranks and modes** from `module_dependencies.yaml`, not the
BC Map's `E-*` register. `domain/person` (7.5) → `platform/services` (3) is a legal downward port call, so the
checker passes it — correctly. Nothing mechanical was ever going to catch a missing row in a prose table. This is
precisely the class of defect `SID-4.56` warns about from the other direction: an *unchecked* rule stays unchecked
until a human reads it.

---

## 2. Decision

**`E-22`'s consumer list is amended from `BC-01, BC-14` to `BC-01, BC-10, BC-14`.**

Nothing else in the row changes. The relationship stays `CF`, the mechanism stays *Sync port*, and the note stays
*"Domain holds a `FileRef`, never bytes or a raw storage path"* — which is exactly what `SID-4.35` independently
requires, so `BC-10` joins the edge under a constraint it already obeys.

### 2.1 What this decision explicitly is not

- **Not a new capability.** `BC-29` already owns upload, scanning, thumbnailing and signed URLs for `BC-01` and
  `BC-14`. `BC-10` adds no requirement to `BC-29`.
- **Not a new dependency direction.** `domain/person` (7.5) → `platform/services` (3) is downward, satisfying `L2`,
  and mediated by a port, satisfying `L3`. No law is bent and **no exception is added** to `exceptions:`.
- **Not a change to `X-05`.** `BC-10` ↔ `domain/social` remains forbidden and untouched; `SID-4.35`'s neighbouring
  clause *"SHALL NOT introduce an import of `domain/social/**`"* is unaffected.

---

## 3. Options considered

| # | Option | Verdict |
|---|---|---|
| 1 | Add `BC-10` to `E-22`'s consumer list | **Chosen.** One cell. Makes the register match a requirement that already exists at a higher rank |
| 2 | Create a new edge `E-27` for `BC-10` → `BC-29` | **Rejected.** Two edges to the same context with the same mode, mechanism and constraint. `E-21`'s precedent — extend the consumer list — is already established in this same table |
| 3 | Route `BC-10`'s photo through `BC-01` | **Rejected, and would break a requirement.** `BC-10` is `1:1` with `Account` and exists without any enrollment (`Q-05`: *"yes, necessarily"*). A person with no `StudentRecord` could not hold a profile photo. It would also make `BC-01` a pass-through for data it does not own |
| 4 | Amend `SID-4.35` to drop the `FileRef` requirement | **Rejected outright.** Inverts precedence — changing a Rank 3 requirement to accommodate an incomplete Rank 4 table — and would put profile-photo bytes inside the identity module, violating `SID-3.19` |
| 5 | Leave it; treat the §4.8 heading as sufficient | **Rejected.** Line 292 is unambiguous: an unlisted edge does not exist. Relying on a heading in a lower-ranked document to establish an edge is the failure mode `SID-4.56` names |

---

## 4. Consequences

### 4.1 Positive

- The Rank 3 requirement `SID-4.35` and the Rank 4 edge register agree.
- `PGA-02` closes.
- `E-21` and `E-22` become consistent with each other, both listing `BC-10`.
- Implementation of `SID-4.35` is unblocked without a waiver.

### 4.2 Negative

- Amends a Rank 4 document, raising the BC Map to **v1.5**. Cost accepted: the alternative is a permanent
  contradiction between ranks.

### 4.3 Risks

| Risk | Severity | Mitigation |
|---|---|---|
| Read as licence to add edges when convenient | **High** | Line 292 is unchanged and this ADR relies on it. One cell, one edge, named explicitly. The next edge needs its own ADR |
| `BC-10` interpreted as owning file storage | Medium | The row's note is preserved verbatim; `SID-4.36` assigns upload, scanning, thumbnailing and signed URLs to `BC-29` |
| Other `ADR-0011` migration omissions remain undetected | Medium | Every `E-*` row was re-read during this closure. `E-21` was already correct; `E-22` was the only gap. Recorded here so the search is not repeated blindly |

---

## 5. Traceability impact

| Register | Impact |
|---|---|
| `E-01`…`E-26` | **One consumer cell.** No edge created, retired or renumbered; count unchanged |
| `BC-01`…`BC-31` | **None.** Count remains **31 (23 in V1)**; no reclassification |
| `SID-*` (343) | **None.** `SID-4.35`/`SID-4.36` are *satisfied* by this amendment, not changed |
| `LIB-*`, `LXC-*`, `MP-*` | **None** |
| `X-01`…`X-14` | **None.** `X-05` untouched |
| `L1`…`L5` | **None.** No exception added |
| `module_dependencies.yaml` | **None.** The underlying module edge was already legal |
| `IMPL-*` | **None.** `IMPL-109` (*"Reference `BC-29` by id; never build a storage URL"*) already assumes this |

**Net traceability impact: zero identifiers.**

---

## 6. Compliance

| # | Check | Expected |
|---|---|---|
| 1 | `grep 'E-22' LIBOORA_BOUNDED_CONTEXT_MAP.md` | Consumer cell reads `BC-01, BC-10, BC-14` |
| 2 | BC Map context count | **31 (23 in V1)** — unchanged |
| 3 | `dart run tool/check_module_boundaries.dart` | Unchanged output; no manifest or code change |
| 4 | `grep -c 'SID-' Student_Identity_PRD_v1.md` | Unchanged — that document is **not** edited |

---

## 7. Migration requirements — **executed 2026-08-04**

| # | Change | Document | Rank | Executed |
|---|---|---|---|---|
| **M1** | §7.3 `E-22`: consumer cell `BC-01, BC-14` → `BC-01, BC-10, BC-14` | `LIBOORA_BOUNDED_CONTEXT_MAP.md` | **4** | ✅ |
| **M2** | Version → **v1.5**; changelog row; the *"unchanged by v1.1…v1.4"* count note extended | same | **4** | ✅ |
| **M3** | Close `PGA-02` | `PRD_GAP_ANALYSIS.md` | unranked | ✅ |
| **M4** | Register this ADR | `ADR-INDEX.md` | — | ✅ |

**Not required:** no baseline re-issue caused by this ADR (Rank 4 — baseline §7 step 4); no change to
`Student_Identity_PRD_v1.md`, the Dependency Matrix, `module_dependencies.yaml`, or any `lib/` source file.

---

## 8. Change history

| Date | Change |
|---|---|
| 2026-08-04 | Created and **Accepted** in the same Governance Closure Phase sitting. Verified against primary sources before drafting: BC Map lines 330–331 (`E-21` extended, `E-22` not), line 292 (the governing rule), and `Student_Identity_PRD_v1.md` lines 927/929 (§4.8 heading and `SID-4.35`). Root cause identified as an incomplete `ADR-0011` migration, not a modelling disagreement. Five options considered, four rejected — including two that would have inverted the precedence order. One consumer cell amended; **zero requirement identifiers affected.** |
