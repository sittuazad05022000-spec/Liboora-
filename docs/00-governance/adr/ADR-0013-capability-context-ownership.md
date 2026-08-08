# ADR-0013 — A capability context is owned by its platform, not by the domain that consumes it

| Field | Value |
|---|---|
| **Status** | **Proposed** |
| **Date** | 2026-08-04 |
| **Deciders** | *Pending* — Principal Product Architect; Program Architect; Principal Software Architect |
| **Supersedes** | Nothing |
| **Amends** | *If accepted:* the **Owning contexts** header row of `Library_PRD_v1.md` (Rank 3, frozen). No requirement text, no business rule, no `LIB-*` identifier |
| **Amended by** | — |
| **Baseline** | Requires a new baseline identifier on acceptance — a Rank 3 document changes version (`DOCUMENTATION_BASELINE.md` §7 step 4) |
| **Related** | `PGA-11` · `ADR-0001` (modular monolith) · `ADR-0011` (rank 7.5) · Bounded Context Map §3.2, §3.3 · Dependency Matrix §4, §6 · `MASTER_PRD.md` §8, §8.1 · `PRD-002`, `PRD-013`, `PRD-015`, `PRD-017` |

> ⚠ **This ADR is a PROPOSAL. It changes nothing on merge.**
>
> `ADR-INDEX.md` process step 1: *"A decision that changes structure, ownership, a boundary, or a platform-wide
> rule requires an ADR **before** implementation."* This document exists so the decision can be taken. Until its
> status reads **Accepted**, `Library_PRD_v1.md` stands exactly as frozen and `PGA-11` remains open.
>
> **The one document requiring an ADR-approved change is `docs/30-product/library/Library_PRD_v1.md`, line 10.**
> It has not been modified. See §8.

---

## 1. Context

`PRD_GAP_ANALYSIS.md` `PGA-11` records that two bounded contexts are claimed twice. Investigation for this ADR
found the count is **three**, not two, and that the disagreement is narrower and more mechanical than the gap
analysis could establish from PRD-level reading alone.

### 1.1 The competing claims

| Source | Precedence | Claim |
|---|---|---|
| `Library_PRD_v1.md` line 10 | Rank 3 | **Owning contexts:** *"`BC-19` Tenancy · `BC-06` Library Policy · `BC-25` Configuration · `BC-29` File & Media"* |
| `LIBOORA_BOUNDED_CONTEXT_MAP.md` §3.2/§3.3, **"Owning Platform"** column | Rank 4 | `BC-19` → **Shared Core** · `BC-06` → **Library Management** · `BC-25` → **Configuration** · `BC-29` → **Platform Services** |
| `MASTER_PRD.md` §8.1 | Rank 1 | Lists `BC-19` and `BC-29` among contexts that *"carry product-visible obligations but had no module entry. Listed here so they receive requirements, budgets and owners"* |

Only **`BC-06` Library Policy** is agreed by all three. `BC-19`, `BC-25` and `BC-29` are each assigned by the
Bounded Context Map to a platform that is **not** Library Management.

### 1.2 The Library PRD already disagrees with itself

Its own data-ownership table at line 1094 marks `BC-29` as **"References by id"**, while `BC-19`, `BC-06` and
`BC-25` are each marked **"Owns"**. So for `BC-29` the header and the body of the same frozen document give
different answers. The body is the one the implementation follows.

### 1.3 The machine-readable manifest already encodes the platform reading

`tool/module_dependencies.yaml` is described by the Dependency Matrix as the **machine-readable source**. It
declares:

```yaml
domain/library:
  rank: 8
  contexts: [enrollment, membership, attendance, seating, fee, policy]   # policy = BC-06 only
  ports:
    - platform/configuration:settings      # BC-25
    - platform/services:files              # BC-29
    - platform/tenancy:tenant_context      # BC-19
```

`domain/library` declares ownership of **six** contexts and `BC-19`/`BC-25`/`BC-29` are **not** among them; all
three are reached as **ports**. The relevant ranks are `platform/services` **3**, `platform/configuration` **3**,
`platform/tenancy` **4**, `domain/library` **8**.

### 1.4 Why the Library PRD's reading is not merely unconventional but unimplementable

Law `L2` is downward-only. A rank-8 module cannot own a rank-3 capability, because every other consumer of that
capability would then depend upward on rank 8. Concretely, if `PRD-002` owned `BC-29`:

- `domain/person` (rank 7.5) needs `BC-29` for `SID-4.35`'s Global Profile Photo. It would depend on rank 8 —
  violating `L2` **and** `X-05`, which forbids exactly the Library ↔ Person direction.
- `platform/audit` (rank 5) and `platform/search` (rank 5) would depend on rank 8 to store or index artefacts —
  violating `L2` and `L4` (*a capability never depends on a domain*).

`ADR-0011` created rank **7.5** precisely so `domain/library` → `domain/person` would be lawfully downward. The
same logic applied to capabilities gives the answer this ADR proposes.

### 1.5 What the Library PRD legitimately owns

The Library PRD specifies real, tenant-facing aggregates against these contexts, and this ADR does not touch
them: `TenantOrganisation` and `StaffAssignment` (`BC-19`), `LibraryBranding` (`BC-25` + `BC-29`, already
recorded there as **"Split"**), and the `LIB-6.x` field rules. The question is not whether that specification is
valid. It is whether specifying an aggregate *inside* a capability context makes the specifier the **owner of the
capability**. Under `ADR-0001`'s modular monolith it does not: the capability is the mechanism, the aggregate is
tenant-facing data that uses it.

---

## 2. Decision

**A capability context is owned by the platform module that implements it. A domain PRD that specifies an
aggregate residing in a capability context is a *consumer* of that context, not its owner.**

Applied to the three contested contexts:

| Context | Owner *(if accepted)* | Owning platform | `PRD-002`'s relationship |
|---|---|---|---|
| **`BC-19` Tenancy** | **`PRD-013` Tenancy** | `platform/tenancy` (rank 4) | **Consumer.** Continues to own the `TenantOrganisation` and `StaffAssignment` **aggregates** and every `LIB-6.x` field rule |
| **`BC-25` Configuration** | **`PRD-013`'s sibling — see §7** | `platform/configuration` (rank 3) | **Consumer.** Continues to own branding *values* and `LCFG-*` |
| **`BC-29` File & Media** | **`PRD-017` File & Media** | `platform/services` (rank 3) | **Consumer.** Already stated as *"References by id"* in its own body |
| **`BC-06` Library Policy** | **`PRD-002` Library** — *unchanged* | `domain/library` (rank 8) | **Owner.** Not affected by this ADR |

**The distinction this ADR makes normative:**

> **Context ownership** is the right to define the capability's contract, invariants and lifecycle.
> **Aggregate ownership** is the right to define a specific tenant-facing record that lives within it.
> They are different rights and may be held by different PRDs. Only the first is what
> *"no duplicate ownership between PRDs"* governs.

### 2.1 What this decision does NOT do

- It does **not** move, delete or reword a single requirement. `LIB-6.1`…`LIB-6.x`, `LCFG-*` and every field
  rule stay in `PRD-002`, unchanged, at the same identifiers.
- It does **not** change any aggregate's location, name or invariant.
- It does **not** change `BC-06`, which `PRD-002` owns outright.
- It does **not** alter `module_dependencies.yaml`. The manifest already encodes this reading; this ADR makes the
  prose agree with the manifest, not the reverse.
- It does **not** touch Student Identity. `ADR-0011` and `Student_Identity_PRD_v1.md` are unaffected.
- It does **not** create `PRD-013`, `PRD-015` or `PRD-017`.

---

## 3. Options considered

### Option A — Capability contexts are platform-owned; domain PRDs are consumers ✅ **PROPOSED**

Distinguish context ownership from aggregate ownership, as §2.

**For:** agrees with the Bounded Context Map's *"Owning Platform"* column, the manifest, the Library PRD's own
line 1094, `SID-4.36`, and `L2`/`L4`. Amends one header row and no requirement. Unblocks `PRD-013`, `PRD-015` and
`PRD-017` to state their own scope.
**Against:** requires amending a frozen Rank-3 document and a new baseline identifier.

### Option B — Do nothing; leave `PGA-11` open

**For:** zero cost today; no frozen document touched.
**Against:** `PRD-013` and `PRD-017` cannot state their scope without contradicting a frozen document, so Wave 1
of the roadmap cannot start — and Wave 1 precedes all of Waves 2–5. Leaves the register permanently reporting a
duplicate-ownership defect against an explicit architectural rule. **Rejected.**

### Option C — Confirm `PRD-002` as owner of all four contexts; delete `PRD-013`/`PRD-017` from the register

**For:** fewest documents; matches the frozen header literally.
**Against:** contradicts Master PRD §8.1 (**Rank 1**, which outranks a module PRD) and makes `L2` unsatisfiable —
`domain/person` would depend upward on `domain/library` for a profile photo, which is the precise shape `X-05`
forbids and `ADR-0011` was written to avoid. Also strands `BC-19` tenancy isolation, the control guarding
`MP-RSK-01`, inside a single domain module. **Rejected.**

### Option D — Split `BC-19` into two contexts (`BC-19a` platform tenancy / `BC-19b` library organisation)

**For:** each PRD would own an undisputed context; superficially the tidiest.
**Against:** invents a bounded context that no source document names, renumbers a context referenced across four
documents and the manifest, and solves by fragmentation what §2's ownership distinction solves by definition.
Directly contrary to the standing instruction to *"prefer a smaller number of clear bounded contexts over
unnecessary fragmentation."* **Rejected.**

### Option E — Amend the Bounded Context Map instead, to name Library Management as owning platform

**For:** the Library PRD would need no change.
**Against:** inverts precedence — Rank 4 would be amended to match Rank 3. Requires renaming the *"Owning
Platform"* column semantics for four contexts, contradicts the manifest, and still leaves `L2` violated.
**Rejected.**

---

## 4. Rejected options — summary

| Option | Reason for rejection |
|---|---|
| **B** Do nothing | Blocks Wave 1, therefore all subsequent waves. Leaves a known duplicate-ownership defect open indefinitely |
| **C** `PRD-002` owns all four | Contradicts Rank 1 §8.1; makes `L2` unsatisfiable; re-creates the `X-05` shape `ADR-0011` removed |
| **D** Split `BC-19` | Invents a context no document names; fragmentation where a definition suffices |
| **E** Amend the Context Map | Inverts the precedence order; contradicts the manifest; `L2` still violated |

---

## 5. Final ownership *(on acceptance)*

| Context | Context owner | Aggregate owner(s) | Mode |
|---|---|---|---|
| `BC-06` Library Policy | `PRD-002` | `PRD-002` | Owned outright — **unchanged** |
| `BC-19` Tenancy | `PRD-013` | `TenantOrganisation`, `StaffAssignment` → **`PRD-002`** | `port` — `platform/tenancy:tenant_context` |
| `BC-25` Configuration | *`BC-25`'s PRD — §7* | `LibraryBranding` values → **`PRD-002`** | `port` — `platform/configuration:settings` |
| `BC-29` File & Media | `PRD-017` | Binaries owned by `BC-29`; `FileRef`s held by consumers | `port` — `platform/services:files` |

**After acceptance no context has two context-owners, and the count of contested contexts becomes 0.**

---

## 6. Consequences

### 6.1 Positive

- `PRD-013`, `PRD-015` and `PRD-017` can state their scope without contradicting a frozen document. **Wave 1 of
  `PRODUCT_IMPLEMENTATION_ROADMAP.md` is unblocked.**
- The prose agrees with the manifest, so `tool/check_module_boundaries.dart` enforces the documented model rather
  than a variant of it.
- `PRD_REGISTRY.md` §6 can report a single owner per context.
- Establishes a reusable rule: the next domain PRD specifying an aggregate in a capability context needs no
  further ADR.

### 6.2 Negative / costs

- Amends a **frozen Rank-3 document**. Requires `Library_PRD_v1.md` → **v1.1**, a changelog entry, and a new
  baseline identifier.
- `PRD-002`'s registry entry lists four contexts today and three thereafter, which will look like a reduction in
  scope. It is not: **no requirement moves.** This must be stated in the registry entry to prevent
  misreading.

### 6.3 Risks

| Risk | Severity | Mitigation |
|---|---|---|
| Read as removing library control over tenant data | Medium | §2.1 and §5 state that every `LIB-6.x` requirement and both aggregates stay in `PRD-002` |
| `PRD-013` over-reaches into library organisation data on the strength of "owning `BC-19`" | Medium | §5's aggregate column is normative: `TenantOrganisation` and `StaffAssignment` are `PRD-002`'s |
| Amendment is used as precedent for editing other frozen documents | High | This ADR authorises **one header row in one document**. Every other frozen document stays untouched, and the next amendment needs its own ADR |

---

## 7. Open question — `BC-25` Configuration has no registered PRD

`BC-25` is in neither Master PRD §31's nine nor §8.1's eight, so `PRD_REGISTRY.md` currently records it as
*"Covered — `PRD-002` owns `BC-25`."* Under this decision that entry is wrong, but there is **no PRD to transfer
it to**, and inventing one here would exceed this ADR's scope.

**Two admissible resolutions, to be settled by the deciders:**

1. Register a new `PRD-023` Configuration for `BC-25` (`platform/configuration`, rank 3), consistent with
   `BC-19`/`BC-29`; or
2. Record `BC-25` as owned by `PRD-013` as the platform-capability PRD, on the grounds that settings and tenancy
   share a lifecycle.

**This ADR does not choose.** Until it is chosen, `BC-25` remains contested and the registry says so. Option 1 is
noted as marginally more consistent with §2, since `platform/configuration` is a distinct rank-3 module with its
own manifest entry — but consistency is not sufficient grounds to add a document, and the question is left open
deliberately rather than resolved by default.

---

## 8. Migration requirements

**Nothing in this section may be executed while this ADR reads *Proposed*.**

| # | Action | Document | Authorised by |
|---|---|---|---|
| M1 | Amend the **Owning contexts** header row (line 10) to distinguish owned from consumed contexts. **Body untouched.** | `docs/30-product/library/Library_PRD_v1.md` | This ADR, once Accepted |
| M2 | Bump version v1.0 → **v1.1**; add a changelog row citing `ADR-0013`; state *"no requirement changed"* | same file | `DOCUMENTATION_BASELINE.md` §7 step 2 |
| M3 | Issue a new baseline identifier; update the Rank-3 entry | `docs/00-governance/DOCUMENTATION_BASELINE.md` | §7 steps 3 and 4 |
| M4 | Set `PRD-002` contexts to `BC-06` owned + `BC-19`/`BC-25`/`BC-29` consumed; update §6 and §7 counts | `PRD_REGISTRY.md` | Registry maintenance rule 3 |
| M5 | Close `PGA-11`, citing this ADR | `PRD_GAP_ANALYSIS.md` | — |
| M6 | Remove the Wave 1 entry gate | `PRODUCT_IMPLEMENTATION_ROADMAP.md` | — |
| M7 | Record the `BC-25` decision from §7 | `PRD_REGISTRY.md` | Requires the deciders' answer |

**Explicitly NOT required:** no change to `module_dependencies.yaml` (already correct), the Bounded Context Map,
any ADR, `Authentication_PRD_v2.md`, `Student_Identity_PRD_v1.md`, `MASTER_PRD.md`, or any `lib/` source file.

**Order matters.** M1 before M2 before M3; M4–M6 in the same commit as M3, so the baseline never disagrees with
the repository — *"a baseline that does not match the repository is worse than no baseline"* (§7 step 3).

---

## 9. Traceability impact

| Register | Impact |
|---|---|
| `LIB-*` (~130) | **None.** No identifier added, removed, renumbered or reworded |
| `LCFG-*`, `LBR`, `LXC-*`, `PO-*`, `LEV-*` | **None** |
| `SID-*` (343) | **None.** `SID-4.35`/`SID-4.36` already name `BC-29` as owner — this ADR agrees with them |
| Authentication (1,517) | **None** |
| `MP-GBR-*`, `MP-CON-*`, `MP-DEP-*` | **None.** §8.1 is *satisfied* by this reading, not amended |
| `IMPL-100`…`IMPL-127` | **No task changes.** `IMPL-109` (*"Reference `BC-29` by id; never build a storage URL"*) already assumes the port model |
| `IMPL-200`…`IMPL-226` | **None.** `IMPL-212` unaffected |
| `TRACEABILITY_MATRIX.md` | One clarifying row may be added noting that `BC-19`/`BC-25`/`BC-29` rows in `PRD-002` trace to *consumed* contexts. **No mapping changes** |
| `X-01`…`X-14` | **None.** This ADR removes a latent `L2`/`X-05` hazard rather than creating one |
| `E-01`…`E-26` | **None.** `E-22`'s consumer-list gap is `PGA-02`, a separate finding requiring its own ADR |

**Net traceability impact: zero identifiers affected.** The change is to one ownership header row.

---

## 10. Compliance

If accepted, compliance is verifiable by four mechanical checks:

1. `grep -c 'LIB-' Library_PRD_v1.md` — unchanged before and after M1.
2. `dart run tool/check_module_boundaries.dart` — no new violation category; the manifest is unchanged.
3. `PRD_REGISTRY.md` §6 shows exactly one context-owner per context, and §7's contested count reads **0**
   (or **1** if §7's `BC-25` question is left open).
4. `git diff` for M1 touches **one line** of `Library_PRD_v1.md` plus its changelog.

---

## 11. Change history

| Version | Date | Change |
|---|---|---|
| **Proposed** | 2026-08-04 | Raised by `PGA-11`. Investigation found **three** contested contexts, not two: `BC-25` Configuration is contested on identical grounds and was missed by the PRD-level gap analysis because `PRD_REGISTRY.md` recorded it as *"Covered."* Proposes that capability contexts are platform-owned and that context ownership is distinct from aggregate ownership. Five options considered, four rejected. **No document has been modified. `Library_PRD_v1.md` remains frozen at v1.0.** The `BC-25` owner is left deliberately open (§7) rather than resolved by default. |
